#!/usr/bin/env python3
"""
Extrae el contenido del Word original de un tema para revisarlo y migrarlo a
LyX/LaTeX (primer paso de /revisartema).

    python3 scripts/temario/extraer-docx.py 3A08

Lee el Word original de oculto/ (en el checkout de main, porque no está en
git; en el 4.º ejercicio sigue la correspondencia nueva ← vieja de
cuarto-ejercicio.html) y deja en oposicion/temario/fuentes/<tema>/_trabajo/:

  original.md       el tema en Markdown (pandoc), con los estilos de párrafo
                    de Word como bloques ::: {custom-style="…"} y marcas en el
                    texto para lo que Víctor dejó señalado:
                      ⟦AMARILLO⟧…⟦/AMARILLO⟧  subrayado amarillo (dudas, pendientes)
                      ⟦ROJO⟧…⟦/ROJO⟧          texto en rojo
                      ⟦OCULTO⟧…⟦/OCULTO⟧      texto oculto (notas privadas: no publicar)
  media/            las imágenes del Word
  paginas/p-NNN.png las páginas del PDF publicado, para ver los gráficos tal
                    como están ahora
  inventario.json   lo que hay que resolver: marcas, notas al opositor, cajas
                    de anotaciones, comentarios, figuras y sus fuentes,
                    referencias a otros temas, notas al pie y número de palabras

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import shutil
import sys
import zipfile

import fitz  # PyMuPDF
from lxml import etree

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, PANDOC, ejecutar, ruta_windows  # noqa: E402

W = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
NS = {'w': W}
ROJOS = {'FF0000', 'C00000', 'FF3300', 'E60000'}
PARTES = re.compile(r'^word/(document|footnotes|endnotes)\.xml$')


def q(etiqueta):
    return f'{{{W}}}{etiqueta}'


# --- Marcas en el XML -----------------------------------------------------------
def marcas_run(r):
    """Qué marcas tiene un run: amarillo, rojo, oculto."""
    rpr = r.find('w:rPr', NS)
    m = set()
    if rpr is None:
        return m
    hl = rpr.find('w:highlight', NS)
    if hl is not None and hl.get(q('val')) == 'yellow':
        m.add('AMARILLO')
    shd = rpr.find('w:shd', NS)
    if shd is not None and (shd.get(q('fill')) or '').upper() == 'FFFF00':
        m.add('AMARILLO')
    color = rpr.find('w:color', NS)
    if color is not None and (color.get(q('val')) or '').upper() in ROJOS:
        m.add('ROJO')
    vanish = rpr.find('w:vanish', NS)
    if vanish is not None and vanish.get(q('val')) not in ('0', 'false'):
        m.add('OCULTO')
    return m


def run_texto(texto):
    r = etree.Element(q('r'))
    t = etree.SubElement(r, q('t'))
    t.text = texto
    t.set('{http://www.w3.org/XML/1998/namespace}space', 'preserve')
    return r


def marcar_parrafo(p):
    """Inserta runs de texto ⟦MARCA⟧ y ⟦/MARCA⟧ alrededor de los tramos marcados."""
    runs = [r for r in p.iter(q('r')) if r.find('w:t', NS) is not None or r.find('w:tab', NS) is not None]
    abiertas = []
    for r in runs:
        actuales = marcas_run(r)
        for marca in [m for m in abiertas if m not in actuales][::-1]:
            r.addprevious(run_texto(f'⟦/{marca}⟧'))
            abiertas.remove(marca)
        for marca in sorted(actuales - set(abiertas)):
            r.addprevious(run_texto(f'⟦{marca}⟧'))
            abiertas.append(marca)
        # El texto oculto se hace visible para que pandoc lo lea
        rpr = r.find('w:rPr', NS)
        if rpr is not None:
            for v in rpr.findall('w:vanish', NS):
                rpr.remove(v)
    if abiertas and runs:
        ultimo = runs[-1]
        for marca in abiertas[::-1]:
            ultimo.addnext(run_texto(f'⟦/{marca}⟧'))
            ultimo = ultimo.getnext()


def aceptar_cambios(raiz):
    for d in list(raiz.iter(q('del'))):
        d.getparent().remove(d)
    for i in list(raiz.iter(q('ins'))):
        padre = i.getparent()
        pos = padre.index(i)
        for hijo in list(i):
            padre.insert(pos, hijo)
            pos += 1
        padre.remove(i)


def estilos_ocultos(xml_estilos):
    """Estilos de carácter/párrafo que ocultan el texto (w:vanish en el estilo)."""
    raiz = etree.fromstring(xml_estilos)
    ocultos = set()
    for st in raiz.findall('w:style', NS):
        rpr = st.find('w:rPr', NS)
        if rpr is not None and rpr.find('w:vanish', NS) is not None:
            ocultos.add(st.get(q('styleId')))
    return ocultos


def preparar_docx(origen, destino):
    """Copia el Word con las marcas en el texto y los cambios aceptados."""
    with zipfile.ZipFile(origen) as zin, zipfile.ZipFile(destino, 'w', zipfile.ZIP_DEFLATED) as zout:
        ocultos = estilos_ocultos(zin.read('word/styles.xml')) if 'word/styles.xml' in zin.namelist() else set()
        for item in zin.infolist():
            datos = zin.read(item.filename)
            if PARTES.match(item.filename):
                raiz = etree.fromstring(datos)
                aceptar_cambios(raiz)
                # Runs con un estilo de carácter oculto: se marcan como OCULTO
                for r in raiz.iter(q('r')):
                    rs = r.find('w:rPr/w:rStyle', NS)
                    if rs is not None and rs.get(q('val')) in ocultos:
                        rpr = r.find('w:rPr', NS)
                        etree.SubElement(rpr, q('vanish'))
                for p in raiz.iter(q('p')):
                    marcar_parrafo(p)
                datos = etree.tostring(raiz, xml_declaration=True, encoding='UTF-8', standalone=True)
            if item.filename == 'word/styles.xml':
                # Los estilos ocultos dejan de ocultar (para que pandoc lea su texto)
                datos = re.sub(rb'<w:vanish/>', b'', datos)
            zout.writestr(item, datos)


def comentarios(origen):
    """Comentarios de Word con el texto al que se refieren."""
    salida = []
    with zipfile.ZipFile(origen) as z:
        if 'word/comments.xml' not in z.namelist():
            return salida
        com = etree.fromstring(z.read('word/comments.xml'))
        doc = etree.fromstring(z.read('word/document.xml'))
    textos = {}
    for c in com.findall('w:comment', NS):
        textos[c.get(q('id'))] = (c.get(q('author')), ''.join(c.itertext()).strip())
    # Texto anclado: entre commentRangeStart y commentRangeEnd
    anclas, abiertos = {}, set()
    for el in doc.iter():
        if el.tag == q('commentRangeStart'):
            abiertos.add(el.get(q('id')))
            anclas.setdefault(el.get(q('id')), '')
        elif el.tag == q('commentRangeEnd'):
            abiertos.discard(el.get(q('id')))
        elif el.tag == q('t') and el.text:
            for i in abiertos:
                anclas[i] += el.text
    for i, (autor, texto) in textos.items():
        salida.append({'autor': autor, 'comentario': texto, 'texto_anclado': anclas.get(i, '')[:400]})
    return salida


# --- Inventario --------------------------------------------------------------------
def contexto(md, ini, fin, ancho=220):
    a = md.rfind('\n', 0, max(0, ini - ancho))
    b = md.find('\n', min(len(md), fin + ancho))
    return md[a + 1 if a >= 0 else 0: b if b >= 0 else len(md)].strip()


def apartado_en(md, pos):
    titulos = [(m.start(), m.group(2)) for m in re.finditer(r'^(#{1,6})\s+(.*)$', md[:pos], re.M)]
    return titulos[-1][1].strip() if titulos else ''


def bloques_estilo(md, estilo):
    patron = re.compile(r'^:::+\s*\{custom-style="%s"\}\s*\n(.*?)\n:::+\s*$' % re.escape(estilo), re.M | re.S)
    return [m.group(1).strip() for m in patron.finditer(md)]


def inventario(tema, md, coms, origen):
    inv = {'tema': tema.codigo, 'titulo': tema.titulo(), 'original': origen,
           'palabras': len(re.findall(r'\w+', re.sub(r'⟦/?\w+⟧|\$[^$]*\$', ' ', md)))}
    for marca in ('AMARILLO', 'ROJO', 'OCULTO'):
        lista = []
        for m in re.finditer(r'⟦%s⟧(.*?)⟦/%s⟧' % (marca, marca), md, re.S):
            texto = m.group(1).strip()
            if not texto or texto in ('❌', '✔', '✓'):
                continue
            lista.append({'texto': texto[:600], 'apartado': apartado_en(md, m.start()),
                          'contexto': contexto(md, m.start(), m.end())[:900]})
        inv[marca.lower()] = lista
    inv['notas_al_opositor'] = bloques_estilo(md, 'Nota al opositor')
    inv['cajas_de_anotaciones'] = bloques_estilo(md, 'Caja de anotaciones')
    inv['advertencias'] = bloques_estilo(md, 'Advertencia')
    inv['no_cantar'] = bloques_estilo(md, 'No cantar')
    inv['comentarios_word'] = coms
    inv['comentarios_internos'] = bloques_estilo(md, 'Comentario')
    titulos = bloques_estilo(md, 'Título imagen')
    pies = bloques_estilo(md, 'Pie de Imagen')
    inv['figuras'] = [{'titulo': t} for t in titulos]
    inv['pies_de_imagen'] = pies
    inv['fuentes_vacias'] = [p for p in pies if re.fullmatch(r'\W*Fuente:?\s*(…|\.\.\.)?\W*', p)]
    inv['referencias_a_temas'] = sorted(set(re.findall(r'\[?ver (?:el )?temas? ([34]\.[AB]\.\d+(?:\s*[-–y,]\s*[34]?\.?[AB]?\.?\d+)*)', md)))
    inv['notas_al_pie'] = len(re.findall(r'^\[\^\d+\]:', md, re.M))
    inv['ecuaciones'] = md.count('$$') // 2 + len(re.findall(r'(?<!\$)\$[^$\n]+\$(?!\$)', md))
    inv['imagenes'] = len(re.findall(r'!\[[^\]]*\]\(', md))
    return inv


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(2)
    tema = Tema(sys.argv[1])
    origen = tema.original_docx()
    if not origen:
        print(f'No encuentro el Word original de {tema} en oculto/.')
        sys.exit(1)
    os.makedirs(tema.trabajo, exist_ok=True)
    marcado = os.path.join(tema.trabajo, 'original-marcado.docx')
    preparar_docx(origen, marcado)

    md_ruta = os.path.join(tema.trabajo, 'original.md')
    media = os.path.join(tema.trabajo, 'media')
    if os.path.exists(media):
        shutil.rmtree(media)
    ejecutar([PANDOC, ruta_windows(marcado), '-f', 'docx+styles', '-t', 'markdown-smart',
              '--wrap=none', '--extract-media', ruta_windows(tema.trabajo),
              '--lua-filter', ruta_windows(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'extraer-docx.lua')),
              '-o', ruta_windows(md_ruta)], timeout=600)
    md = open(md_ruta, encoding='utf-8').read()
    md = re.sub(r'\]\([A-Za-z]:[^)]*?_trabajo[/\\]media[/\\]', '](media/', md)
    with open(md_ruta, 'w', encoding='utf-8') as f:
        f.write(md)

    # Páginas del PDF publicado
    pdf = tema.pdf_publicado()
    paginas = os.path.join(tema.trabajo, 'paginas')
    if pdf:
        os.makedirs(paginas, exist_ok=True)
        doc = fitz.open(pdf)
        for i, pag in enumerate(doc):
            pag.get_pixmap(dpi=110).save(os.path.join(paginas, f'p-{i + 1:03d}.png'))
        n_paginas = doc.page_count
    else:
        n_paginas = 0

    inv = inventario(tema, md, comentarios(origen), origen)
    inv['paginas_pdf_publicado'] = n_paginas
    with open(os.path.join(tema.trabajo, 'inventario.json'), 'w', encoding='utf-8') as f:
        json.dump(inv, f, ensure_ascii=False, indent=2)

    print(f'Tema {tema}: {inv["titulo"]}')
    print(f'Original: {origen}')
    print(f'{inv["palabras"]} palabras, {n_paginas} páginas en el PDF publicado, {inv["imagenes"]} imágenes, '
          f'{inv["notas_al_pie"]} notas al pie, {inv["ecuaciones"]} fórmulas')
    print(f'Pendiente: {len(inv["amarillo"])} tramos en amarillo, {len(inv["rojo"])} en rojo, '
          f'{len(inv["oculto"])} ocultos, {len(inv["notas_al_opositor"])} notas al opositor, '
          f'{len(inv["comentarios_word"])} comentarios, {len(inv["fuentes_vacias"])} fuentes vacías')
    print('Resultado en', os.path.relpath(tema.trabajo))


if __name__ == '__main__':
    main()
