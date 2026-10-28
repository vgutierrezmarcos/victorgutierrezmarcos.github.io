#!/usr/bin/env python3
"""
Convierte un informe en Markdown (cante, dictamen, escrito, cronograma, «cómo
voy») en un PDF con la estética de la oposición del opositor: TCEE (morado
#5F2987 como tinta, filete dorado, letra TeX Gyre Pagella, la de la web y la
app) o DCE (granate #7a1f4b y azul #234a6b, letra Latin Modern Roman, la de la
web de Manuel Cabado).

    python3 informe-pdf.py informe.md [--oposicion tcee|dce] [-o informe.pdf]

Cómo lo hace (solo biblioteca estándar más dos programas externos que Claude
tiene en su entorno de ejecución de código):
 1. Instala las fuentes de assets/fuentes en ~/.fonts (si hace falta).
 2. Construye un reference.docx a partir del de pandoc, con los estilos de la
    oposición (fuentes, colores, títulos con filete, tamaño A4 y márgenes).
 3. pandoc: Markdown -> DOCX con ese reference.docx.
 4. LibreOffice (soffice): DOCX -> PDF.
Si falta soffice, deja el DOCX y lo dice; si falta pandoc, se detiene con un
mensaje claro. El Markdown de entrada no se modifica.

Autor: Víctor Gutiérrez Marcos (skill «Prepara con Claude»).
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile
from datetime import date

AQUI = os.path.dirname(os.path.abspath(__file__))
FUENTES = os.path.join(os.path.dirname(AQUI), 'assets', 'fuentes')

# Estética de cada oposición: fuente del texto, fuente de los títulos, color
# principal (títulos), color secundario (subtítulos), color del filete y texto
# de la cabecera.
ESTILOS = {
    'tcee': {
        'texto': 'TeX Gyre Pagella', 'titulos': 'TeX Gyre Pagella',
        'primario': '5F2987', 'secundario': '4A1F6B', 'filete': 'B8860B', 'gris': '5E5866',
        'cabecera': 'Prepara con Claude · Oposición a Técnico Comercial y Economista del Estado · victorgutierrezmarcos.es',
    },
    'dce': {
        'texto': 'Latin Modern Roman', 'titulos': 'Latin Modern Roman',
        'primario': '7A1F4B', 'secundario': '234A6B', 'filete': '7A1F4B', 'gris': '5E5866',
        'cabecera': 'Prepara con Claude · Oposición a Diplomado Comercial del Estado · manuelcabadogarcia.es',
    },
}
AVISO = ('Este informe lo ha redactado una IA con el temario de victorgutierrezmarcos.es y tus propios datos. '
         'No sustituye a un preparador para la oposición: lo complementa. Contrasta con él lo que te sorprenda y, en caso de duda, manda su criterio.')


def programa(nombre, variable):
    """Ruta del programa externo: la variable de entorno, si está, o el PATH."""
    return os.environ.get(variable) or shutil.which(nombre)


def ruta_para(programa_ruta, ruta):
    """Un .exe de Windows ejecutado desde WSL necesita rutas de Windows."""
    if programa_ruta and programa_ruta.lower().endswith('.exe') and shutil.which('wslpath'):
        return subprocess.run(['wslpath', '-w', ruta], capture_output=True, text=True).stdout.strip()
    return ruta


def instalar_fuentes():
    """Copia las fuentes de la skill a ~/.fonts (Linux) para que LibreOffice las encuentre."""
    if not os.path.isdir(FUENTES) or sys.platform.startswith('win'):
        return
    destino = os.path.expanduser('~/.fonts')
    os.makedirs(destino, exist_ok=True)
    nuevas = 0
    for f in os.listdir(FUENTES):
        if f.lower().endswith(('.otf', '.ttf')) and not os.path.exists(os.path.join(destino, f)):
            shutil.copy(os.path.join(FUENTES, f), destino)
            nuevas += 1
    if nuevas and shutil.which('fc-cache'):
        subprocess.run(['fc-cache', '-f', destino], capture_output=True)


def detectar_oposicion(texto):
    cabeza = texto[:2000].lower()
    if 'dce' in cabeza or 'diplomado comercial' in cabeza:
        return 'dce'
    return 'tcee'


def estilo_parrafo(id_, nombre, basado, fuente, tamano, color, negrita=False, cursiva=False, antes=0, despues=120, filete=None, versalitas=False, alineacion=None, siguiente='BodyText'):
    """Un estilo de párrafo de styles.xml (medidas en medios puntos y vigésimos de punto)."""
    pbdr = f'<w:pBdr><w:bottom w:val="single" w:sz="8" w:space="2" w:color="{filete}"/></w:pBdr>' if filete else ''
    jc = f'<w:jc w:val="{alineacion}"/>' if alineacion else ''
    rpr = (f'<w:rFonts w:ascii="{fuente}" w:hAnsi="{fuente}" w:cs="{fuente}" w:eastAsia="{fuente}"/>'
           + ('<w:b/><w:bCs/>' if negrita else '') + ('<w:i/><w:iCs/>' if cursiva else '') + ('<w:smallCaps/>' if versalitas else '')
           + f'<w:color w:val="{color}"/><w:sz w:val="{tamano}"/><w:szCs w:val="{tamano}"/>')
    return (f'<w:style w:type="paragraph" w:customStyle="1" w:styleId="{id_}"><w:name w:val="{nombre}"/>'
            f'<w:basedOn w:val="{basado}"/><w:next w:val="{siguiente}"/><w:qFormat/>'
            f'<w:pPr><w:keepNext/><w:spacing w:before="{antes}" w:after="{despues}"/>{pbdr}{jc}</w:pPr><w:rPr>{rpr}</w:rPr></w:style>')


def redefinir(xml, style_id, nuevo):
    """Sustituye un estilo existente de styles.xml por otro (o lo añade al final)."""
    patron = re.compile(r'<w:style [^>]*w:styleId="%s".*?</w:style>' % re.escape(style_id), re.S)
    if patron.search(xml):
        return patron.sub(lambda m: nuevo, xml, count=1)
    return xml.replace('</w:styles>', nuevo + '</w:styles>')


def reference_docx(pandoc, destino, e):
    """El reference.docx de pandoc con los estilos de la oposición."""
    base = subprocess.run([pandoc, '--print-default-data-file', 'reference.docx'], capture_output=True, check=True).stdout
    tmp = destino + '.base'
    with open(tmp, 'wb') as f:
        f.write(base)
    with zipfile.ZipFile(tmp) as z:
        partes = {n: z.read(n) for n in z.namelist()}
    os.remove(tmp)
    s = partes['word/styles.xml'].decode('utf-8')
    texto, titulos = e['texto'], e['titulos']
    # Fuente y tamaño por defecto (11 pt), idioma español
    s = re.sub(r'<w:rFonts [^/]*/>', f'<w:rFonts w:ascii="{texto}" w:hAnsi="{texto}" w:cs="{texto}" w:eastAsia="{texto}"/>', s, count=1)
    s = re.sub(r'(<w:rPrDefault>.*?)<w:sz w:val="\d+" />(\s*)<w:szCs w:val="\d+" />', r'\1<w:sz w:val="22" />\2<w:szCs w:val="22" />', s, count=1, flags=re.S)
    s = re.sub(r'<w:lang w:val="[^"]*"', '<w:lang w:val="es-ES"', s, count=1)
    s = s.replace('<w:spacing w:after="200" />', '<w:spacing w:after="120" w:line="276" w:lineRule="auto" />', 1)
    # Títulos: el 1 es el del informe; el 2 lleva el filete; el 3 va en el color secundario
    s = redefinir(s, 'Title', estilo_parrafo('Title', 'Title', 'Normal', titulos, 40, e['primario'], negrita=True, antes=0, despues=120))
    s = redefinir(s, 'Heading1', estilo_parrafo('Heading1', 'heading 1', 'Normal', titulos, 34, e['primario'], negrita=True, antes=120, despues=200, filete=e['filete']))
    s = redefinir(s, 'Heading2', estilo_parrafo('Heading2', 'heading 2', 'Normal', titulos, 27, e['primario'], negrita=True, antes=360, despues=120, filete=e['filete']))
    s = redefinir(s, 'Heading3', estilo_parrafo('Heading3', 'heading 3', 'Normal', titulos, 24, e['secundario'], negrita=True, antes=240, despues=80))
    s = redefinir(s, 'Heading4', estilo_parrafo('Heading4', 'heading 4', 'Normal', titulos, 22, e['secundario'], negrita=True, cursiva=True, antes=200, despues=60))
    # Los estilos de pandoc heading 1-3 se basan en Heading1… por el nombre: con customStyle no rompe nada.
    s = s.replace('w:customStyle="1" w:styleId="Title"', 'w:styleId="Title"')
    for n in ('Heading1', 'Heading2', 'Heading3', 'Heading4'):
        s = s.replace(f'w:customStyle="1" w:styleId="{n}"', f'w:styleId="{n}"')
    # Cabecera (línea pequeña en versalitas sobre el título), aviso final y citas
    s = redefinir(s, 'Cabecera', estilo_parrafo('Cabecera', 'Cabecera', 'Normal', titulos, 18, e['gris'], versalitas=True, antes=0, despues=240, filete=e['filete']))
    s = redefinir(s, 'Aviso', estilo_parrafo('Aviso', 'Aviso', 'Normal', texto, 18, e['gris'], cursiva=True, antes=360, despues=0))
    s = redefinir(s, 'BlockText', estilo_parrafo('BlockText', 'Block Text', 'BodyText', texto, 21, e['secundario'], antes=120, despues=120).replace('<w:keepNext/>', '<w:ind w:left="567"/><w:pBdr><w:left w:val="single" w:sz="12" w:space="8" w:color="%s"/></w:pBdr>' % e['filete']))
    # Enlaces en el color principal; tablas con cabecera en negrita
    s = re.sub(r'(<w:style [^>]*w:styleId="Hyperlink".*?<w:color w:val=")[^"]*(")', r'\g<1>%s\2' % e['primario'], s, count=1, flags=re.S)
    partes['word/styles.xml'] = s.encode('utf-8')
    # Página A4 y márgenes de 2,2 cm (en vigésimos de punto)
    d = partes['word/document.xml'].decode('utf-8')
    d = re.sub(r'<w:pgSz [^>]*/>', '', d)
    d = re.sub(r'<w:pgMar [^>]*/>', '', d)
    pagina = ('<w:pgSz w:w="11906" w:h="16838"/>'
              '<w:pgMar w:top="1247" w:right="1247" w:bottom="1247" w:left="1247" w:header="708" w:footer="708" w:gutter="0"/>')
    d = d.replace('</w:sectPr>', pagina + '</w:sectPr>', 1)
    partes['word/document.xml'] = d.encode('utf-8')
    with zipfile.ZipFile(destino, 'w', zipfile.ZIP_DEFLATED) as z:
        for n, b in partes.items():
            z.writestr(n, b)


def preparar_markdown(texto, e):
    """Cabecera con estilo propio delante y el aviso al final si no estaba."""
    cabecera = f'::: {{custom-style="Cabecera"}}\n{e["cabecera"]} · {date.today().strftime("%d/%m/%Y")}\n:::\n\n'
    cuerpo = texto.strip() + '\n'
    if 'No sustituye a un preparador' not in cuerpo:
        cuerpo += f'\n::: {{custom-style="Aviso"}}\n{AVISO}\n:::\n'
    else:
        # El aviso ya está (en cursiva, como lo escribe la skill): se le pone su estilo
        cuerpo = re.sub(r'\n\*?(Este informe lo ha redactado una IA[^\n]*?)\*?\n?$', r'\n::: {custom-style="Aviso"}\n\1\n:::\n', cuerpo, count=1)
    return cabecera + cuerpo


def main():
    p = argparse.ArgumentParser(description='Informe en PDF con la estética de la oposición')
    p.add_argument('markdown', help='el informe en Markdown')
    p.add_argument('--oposicion', choices=['tcee', 'dce'], help='tcee (por defecto) o dce; si no se da, se deduce de la cabecera')
    p.add_argument('-o', '--salida', help='fichero PDF de salida (por defecto, el .md con extensión .pdf)')
    a = p.parse_args()

    with open(a.markdown, encoding='utf-8') as f:
        texto = f.read()
    opo = a.oposicion or detectar_oposicion(texto)
    e = ESTILOS[opo]
    salida = os.path.abspath(a.salida or os.path.splitext(a.markdown)[0] + '.pdf')
    docx = os.path.splitext(salida)[0] + '.docx'

    pandoc = programa('pandoc', 'PANDOC')
    if not pandoc:
        sys.exit('No encuentro pandoc. En el entorno de Claude suele estar; si no, instálalo o entrega el informe en Markdown y dilo.')
    soffice = programa('soffice', 'SOFFICE') or programa('libreoffice', 'SOFFICE')
    instalar_fuentes()

    with tempfile.TemporaryDirectory(dir=os.path.dirname(salida)) as tmp:
        ref = os.path.join(tmp, 'referencia.docx')
        reference_docx(pandoc, ref, e)
        md = os.path.join(tmp, 'informe.md')
        with open(md, 'w', encoding='utf-8') as f:
            f.write(preparar_markdown(texto, e))
        subprocess.run([pandoc, ruta_para(pandoc, md), '-f', 'markdown+smart', '-t', 'docx',
                        '--reference-doc=' + ruta_para(pandoc, ref), '-o', ruta_para(pandoc, docx)], check=True)
        print(f'DOCX: {docx}')
        if not soffice:
            print('No encuentro LibreOffice (soffice): queda el DOCX. Para el PDF, instala LibreOffice o conviértelo con Word.')
            return
        r = subprocess.run([soffice, '--headless', '--convert-to', 'pdf', '--outdir', os.path.dirname(salida), docx], capture_output=True, text=True, timeout=180)
        pdf_generado = os.path.splitext(docx)[0] + '.pdf'
        if r.returncode != 0 or not os.path.exists(pdf_generado):
            sys.exit(f'LibreOffice no ha generado el PDF:\n{r.stdout}\n{r.stderr}\nQueda el DOCX: {docx}')
        if pdf_generado != salida:
            shutil.move(pdf_generado, salida)
        print(f'PDF: {salida} ({os.path.getsize(salida) // 1024} KB, estética {opo.upper()})')


if __name__ == '__main__':
    main()
