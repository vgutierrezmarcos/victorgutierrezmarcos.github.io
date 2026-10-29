#!/usr/bin/env python3
"""
Convierte un informe en Markdown (cante, dictamen, escrito, cronograma, «cómo
voy», ficha) en un PDF con la plantilla LaTeX de los temas del temario y la
estética de la oposición del opositor: TCEE (morado #5F2987 como tinta,
filete dorado, fondo verde salvia, letra TeX Gyre Pagella, la de la web y la
app) o DCE (granate #7a1f4b y azul #234a6b, fondo crema, letra Latin Modern
Roman, la de la web de Manuel Cabado).

    python3 informe-pdf.py informe.md [--oposicion tcee|dce] [-o informe.pdf] [--motor latex|docx|auto]

Cómo lo hace (solo biblioteca estándar más los programas externos que Claude
tiene en su entorno de ejecución de código):
 1. Prepara el Markdown: el primer «# Título» pasa a ser el título del
    documento y las imágenes se copian al directorio de trabajo.
 2. pandoc: Markdown (gfm, fórmulas $…$ tal cual) -> LaTeX con la plantilla
    assets/latex/informe.tex, que carga assets/latex/informe.sty (cabecera,
    pie con «página n de N», apartados en banda, citas «>» como caja con el
    fondo de la app, tablas booktabs, listas compactas); el filtro
    assets/latex/informe.lua lleva el aviso final («Este informe lo ha
    redactado una IA…») a su caja pálida y lo añade si no estaba.
 3. XeLaTeX (dos o tres pasadas) con las fuentes OTF de assets/fuentes.
Si no hay XeLaTeX (o falla), usa la vía anterior: pandoc -> DOCX con un
reference.docx de estilos -> PDF con LibreOffice (soffice), y lo dice. Si
falta soffice, deja el DOCX; si falta pandoc, se detiene con un mensaje claro.
El Markdown de entrada no se modifica.

Programas: se buscan en el PATH o en las variables de entorno PANDOC, XELATEX,
LATEXMK y SOFFICE (ruta completa; en WSL puede ser un .exe de Windows, como
el pandoc de Quarto o el xelatex de MiKTeX: las rutas se traducen solas).
En las fórmulas $…$ escribe \\alpha, \\leq, \\rightarrow (no α, ≤, →): en el
texto corriente los símbolos Unicode sí valen, informe.sty sustituye los que
la fuente no tiene.

Autor: Víctor Gutiérrez Marcos (skill «Prepara con Claude»).
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile
from datetime import date

AQUI = os.path.dirname(os.path.abspath(__file__))
ASSETS = os.path.join(os.path.dirname(AQUI), 'assets')
FUENTES = os.path.join(ASSETS, 'fuentes')
LATEX = os.path.join(ASSETS, 'latex')
MESES = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre']

# Estética de cada oposición: fuente del texto, fuente de los títulos, color
# principal (títulos), color secundario (subtítulos), color del filete, fondo
# de la app (cajas: cabecera, citas y bloque «Para la app»), color pálido del
# aviso y texto de la cabecera. Son los mismos tokens que la web y la app
# (TCEE: morado y verde salvia; DCE: granate, azul y crema). La vía LaTeX los
# tiene en assets/latex/informe.sty; aquí los usa la vía DOCX.
ESTILOS = {
    'tcee': {
        'texto': 'TeX Gyre Pagella', 'titulos': 'TeX Gyre Pagella',
        'primario': '5F2987', 'secundario': '4A1F6B', 'filete': 'B8860B', 'gris': '5E5866', 'fondo': 'E2EFD9', 'palido': 'F1EBF6',
        'cabecera': 'Prepara con Claude · Oposición a Técnico Comercial y Economista del Estado · victorgutierrezmarcos.es',
    },
    'dce': {
        'texto': 'Latin Modern Roman', 'titulos': 'Latin Modern Roman',
        'primario': '7A1F4B', 'secundario': '234A6B', 'filete': '234A6B', 'gris': '57534B', 'fondo': 'F7F4EC', 'palido': 'F4E9EE',
        'cabecera': 'Prepara con Claude · Oposición a Diplomado Comercial del Estado · manuelcabadogarcia.es',
    },
}
AVISO = ('Este informe lo ha redactado una IA con el temario de victorgutierrezmarcos.es y tus propios datos. '
         'No sustituye a un preparador para la oposición: lo complementa. Contrasta con él lo que te sorprenda y, en caso de duda, manda su criterio.')
INICIO_AVISO = 'Este informe lo ha redactado una IA'


def programa(nombre, variable):
    """Ruta del programa externo: la variable de entorno, si está, o el PATH."""
    return os.environ.get(variable) or shutil.which(nombre)


def es_exe(programa_ruta):
    """¿Es un programa de Windows llamado desde WSL?"""
    return bool(programa_ruta) and programa_ruta.lower().endswith('.exe') and bool(shutil.which('wslpath'))


def ruta_para(programa_ruta, ruta):
    """Un .exe de Windows ejecutado desde WSL necesita rutas de Windows."""
    if es_exe(programa_ruta):
        return subprocess.run(['wslpath', '-w', ruta], capture_output=True, text=True).stdout.strip()
    return ruta


def directorio_trabajo(programas):
    """Directorio temporal: si algún programa es un .exe de Windows, en el %TEMP%
    de Windows (los .exe no ven /tmp de WSL); si no, el temporal del sistema."""
    if any(es_exe(p) for p in programas):
        try:
            temp = subprocess.run(['cmd.exe', '/c', 'echo %TEMP%'], capture_output=True, text=True, timeout=20).stdout.strip()
            temp = subprocess.run(['wslpath', '-u', temp], capture_output=True, text=True).stdout.strip()
            if os.path.isdir(temp):
                return tempfile.TemporaryDirectory(dir=temp, prefix='informe-')
        except (OSError, subprocess.SubprocessError):
            pass
    return tempfile.TemporaryDirectory(prefix='informe-')


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


def fecha_es(d=None):
    d = d or date.today()
    return f'{d.day} de {MESES[d.month - 1]} de {d.year}'


# ============================================================================
# Vía LaTeX: pandoc -> LaTeX (informe.tex + informe.sty) -> XeLaTeX
# ============================================================================

def partir_titulo(texto):
    """Separa el primer «# Título» (si el documento empieza por él) del cuerpo."""
    lineas = texto.strip().split('\n')
    if lineas and re.match(r'#\s+\S', lineas[0]):
        return lineas[0][1:].strip().rstrip('#').strip(), '\n'.join(lineas[1:]).strip()
    return None, '\n'.join(lineas).strip()


def renivelar_titulos(cuerpo):
    """El nivel de título más alto del cuerpo pasa a ser «#» (→ \\section, en banda)."""
    lineas = cuerpo.split('\n')
    niveles, en_codigo = [], False
    for l in lineas:
        if l.startswith('```') or l.startswith('~~~'):
            en_codigo = not en_codigo
        elif not en_codigo:
            m = re.match(r'(#{1,6})\s+\S', l)
            if m:
                niveles.append(len(m.group(1)))
    if not niveles or min(niveles) == 1:
        return cuerpo
    quitar = min(niveles) - 1
    salida, en_codigo = [], False
    for l in lineas:
        if l.startswith('```') or l.startswith('~~~'):
            en_codigo = not en_codigo
        elif not en_codigo and re.match(r'#{1,6}\s+\S', l):
            l = l[quitar:]
        salida.append(l)
    return '\n'.join(salida)


def copiar_imagenes(cuerpo, base, destino):
    """Copia las imágenes locales ![…](ruta) al directorio de trabajo (sin espacios ni rutas raras)."""
    contador = [0]

    def sustituir(m):
        ruta = m.group(2).strip()
        if re.match(r'[a-z]+://', ruta):
            return m.group(0)
        origen = ruta if os.path.isabs(ruta) else os.path.join(base, ruta)
        if not os.path.isfile(origen):
            print(f'Aviso: no encuentro la imagen {origen}; sale sin ella.')
            return m.group(1) + ' [imagen no encontrada]' if m.group(1) else ''
        contador[0] += 1
        nombre = f'img{contador[0]}{os.path.splitext(origen)[1].lower() or ".png"}'
        shutil.copy(origen, os.path.join(destino, nombre))
        return f'![{m.group(1)}]({nombre}{m.group(3) or ""})'

    return re.sub(r'!\[([^\]]*)\]\(([^)\s]+)(\s+"[^"]*")?\)', sustituir, cuerpo)


def errores_del_log(log):
    """Las líneas «!» del .log de XeLaTeX con sus dos siguientes."""
    lineas = log.split('\n')
    salida = []
    for i, l in enumerate(lineas):
        if l.startswith('!'):
            salida.extend(lineas[i:i + 3])
        if len(salida) > 18:
            break
    return '\n'.join(salida)


def avisos_del_log(log):
    """Caracteres que faltan en la fuente y sustituciones de forma, para avisar."""
    faltan = sorted(set(re.findall(r'Missing character: There is no (\S+)', log)))
    formas = re.findall(r'Font shape `[^\']*\' undefined', log)
    avisos = []
    if faltan:
        avisos.append('caracteres que la fuente no tiene (salen en blanco): ' + ' '.join(faltan[:20]))
    if formas:
        avisos.append(f'{len(formas)} sustituciones de forma de fuente (mira el .log)')
    return avisos


def via_latex(texto, opo, salida, pandoc, xelatex, latexmk, base, guardar_tex=False):
    """Markdown -> LaTeX -> PDF (base: carpeta del Markdown, para las imágenes). Devuelve True si el PDF queda en `salida`."""
    titulo, cuerpo = partir_titulo(texto)
    cuerpo = renivelar_titulos(cuerpo)
    programas = [pandoc, xelatex, latexmk]
    with directorio_trabajo(programas) as tmp:
        cuerpo = copiar_imagenes(cuerpo, base, tmp)
        for f in ('informe.sty', 'informe.tex', 'informe.lua'):
            shutil.copy(os.path.join(LATEX, f), tmp)
        os.makedirs(os.path.join(tmp, 'fuentes'), exist_ok=True)
        for f in os.listdir(FUENTES):
            if f.lower().endswith('.otf'):
                shutil.copy(os.path.join(FUENTES, f), os.path.join(tmp, 'fuentes', f))
        md = os.path.join(tmp, 'informe.md')
        with open(md, 'w', encoding='utf-8') as f:
            f.write(cuerpo)
        meta = os.path.join(tmp, 'meta.json')
        with open(meta, 'w', encoding='utf-8') as f:
            json.dump({'title': titulo, 'aviso': AVISO} if titulo else {'aviso': AVISO}, f, ensure_ascii=False)
        tex = os.path.join(tmp, 'informe-cuerpo.tex')
        orden = [pandoc, ruta_para(pandoc, md), '-f', 'gfm+tex_math_dollars+smart+implicit_figures', '-t', 'latex',
                 '--lua-filter', ruta_para(pandoc, os.path.join(tmp, 'informe.lua')),
                 '--template', ruta_para(pandoc, os.path.join(tmp, 'informe.tex')),
                 '--metadata-file', ruta_para(pandoc, meta), '--no-highlight',
                 '-V', 'oposicion=' + opo, '-V', 'fuentes=fuentes/', '-V', 'fecha=' + fecha_es(),
                 '-o', ruta_para(pandoc, tex)]
        r = subprocess.run(orden, capture_output=True, text=True, cwd=tmp)
        if r.returncode != 0 and 'extension' in r.stderr.lower():
            # pandoc antiguo: sin smart ni implicit_figures en gfm
            orden[orden.index('-f') + 1] = 'gfm+tex_math_dollars'
            r = subprocess.run(orden, capture_output=True, text=True, cwd=tmp)
        if r.returncode != 0 or not os.path.exists(tex):
            print(f'pandoc no ha generado el LaTeX:\n{r.stderr}')
            return False
        if guardar_tex:
            shutil.copy(tex, os.path.splitext(salida)[0] + '.tex')
        # Compilación: xelatex, dos pasadas (tres si pide otra); latexmk solo si no hay xelatex
        log = os.path.join(tmp, 'informe-cuerpo.log')
        if xelatex:
            base = [xelatex, '-interaction=nonstopmode', '-file-line-error']
            if 'miktex' in xelatex.lower():
                base.append('--enable-installer')
            # Siempre el nombre relativo: el directorio de trabajo ya es el temporal (también para un .exe de
            # Windows, que hereda el cwd de /mnt/c), y una ruta absoluta de Windows con «~» (nombres 8.3) rompe a TeX.
            base.append('informe-cuerpo.tex')
            pasadas = 2
            for i in range(3):
                try:
                    r = subprocess.run(base, capture_output=True, text=True, cwd=tmp, timeout=300, errors='replace')
                except subprocess.TimeoutExpired:
                    print('XeLaTeX ha tardado más de cinco minutos: lo dejo.')
                    return False
                contenido = open(log, encoding='utf-8', errors='replace').read() if os.path.exists(log) else ''
                if r.returncode != 0:
                    print('XeLaTeX ha fallado:\n' + (errores_del_log(contenido) or r.stdout[-1500:]))
                    return False
                if i == 1 and 'Rerun' in contenido:
                    pasadas = 3
                if i + 1 >= pasadas:
                    break
        else:
            r = subprocess.run([latexmk, '-xelatex', '-interaction=nonstopmode', 'informe-cuerpo.tex'],
                               capture_output=True, text=True, cwd=tmp, timeout=600, errors='replace')
            contenido = open(log, encoding='utf-8', errors='replace').read() if os.path.exists(log) else ''
            if r.returncode != 0:
                print('latexmk ha fallado:\n' + (errores_del_log(contenido) or r.stdout[-1500:]))
                return False
        pdf = os.path.join(tmp, 'informe-cuerpo.pdf')
        if not os.path.exists(pdf):
            print('XeLaTeX ha terminado sin producir el PDF.')
            return False
        for aviso in avisos_del_log(contenido):
            print('Aviso: ' + aviso)
        shutil.copy(pdf, salida)
    print(f'PDF: {salida} ({os.path.getsize(salida) // 1024} KB, estética {opo.upper()}, plantilla LaTeX de los temas)')
    return True


# ============================================================================
# Vía DOCX (de reserva): pandoc -> DOCX con reference.docx -> PDF con LibreOffice
# ============================================================================

def estilo_parrafo(id_, nombre, basado, fuente, tamano, color, negrita=False, cursiva=False, antes=0, despues=120, filete=None, versalitas=False, alineacion=None, siguiente='BodyText', fondo=None):
    """Un estilo de párrafo de styles.xml (medidas en medios puntos y vigésimos de punto)."""
    pbdr = f'<w:pBdr><w:bottom w:val="single" w:sz="8" w:space="2" w:color="{filete}"/></w:pBdr>' if filete else ''
    jc = f'<w:jc w:val="{alineacion}"/>' if alineacion else ''
    shd = f'<w:shd w:val="clear" w:color="auto" w:fill="{fondo}"/>' if fondo else ''
    rpr = (f'<w:rFonts w:ascii="{fuente}" w:hAnsi="{fuente}" w:cs="{fuente}" w:eastAsia="{fuente}"/>'
           + ('<w:b/><w:bCs/>' if negrita else '') + ('<w:i/><w:iCs/>' if cursiva else '') + ('<w:smallCaps/>' if versalitas else '')
           + f'<w:color w:val="{color}"/><w:sz w:val="{tamano}"/><w:szCs w:val="{tamano}"/>')
    return (f'<w:style w:type="paragraph" w:customStyle="1" w:styleId="{id_}"><w:name w:val="{nombre}"/>'
            f'<w:basedOn w:val="{basado}"/><w:next w:val="{siguiente}"/><w:qFormat/>'
            f'<w:pPr><w:keepNext/><w:spacing w:before="{antes}" w:after="{despues}"/>{pbdr}{shd}{jc}</w:pPr><w:rPr>{rpr}</w:rPr></w:style>')


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
    s = redefinir(s, 'Cabecera', estilo_parrafo('Cabecera', 'Cabecera', 'Normal', titulos, 18, e['primario'], versalitas=True, antes=0, despues=240, filete=e['filete'], fondo=e['fondo']))
    s = redefinir(s, 'Aviso', estilo_parrafo('Aviso', 'Aviso', 'Normal', texto, 18, e['gris'], cursiva=True, antes=360, despues=0, fondo=e['palido']))
    s = redefinir(s, 'BlockText', estilo_parrafo('BlockText', 'Block Text', 'BodyText', texto, 21, e['secundario'], antes=120, despues=120, fondo=e['fondo']).replace('<w:keepNext/>', '<w:ind w:left="567"/><w:pBdr><w:left w:val="single" w:sz="12" w:space="8" w:color="%s"/></w:pBdr>' % e['filete']))
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


def preparar_markdown_docx(texto, e):
    """Cabecera con estilo propio delante y el aviso al final si no estaba."""
    cabecera = f'::: {{custom-style="Cabecera"}}\n{e["cabecera"]} · {date.today().strftime("%d/%m/%Y")}\n:::\n\n'
    cuerpo = texto.strip() + '\n'
    if INICIO_AVISO not in cuerpo:
        cuerpo += f'\n::: {{custom-style="Aviso"}}\n{AVISO}\n:::\n'
    else:
        # El aviso ya está (en cursiva, como lo escribe la skill): se le pone su estilo
        cuerpo = re.sub(r'\n(?:> )?\*?(Este informe lo ha redactado una IA[^\n]*?)\*?\n?$', r'\n::: {custom-style="Aviso"}\n\1\n:::\n', cuerpo, count=1)
    return cabecera + cuerpo


def via_docx(texto, opo, salida, pandoc, soffice, base):
    e = ESTILOS[opo]
    docx = os.path.splitext(salida)[0] + '.docx'
    instalar_fuentes()
    with directorio_trabajo([pandoc, soffice]) as tmp:
        ref = os.path.join(tmp, 'referencia.docx')
        reference_docx(pandoc, ref, e)
        md = os.path.join(tmp, 'informe.md')
        with open(md, 'w', encoding='utf-8') as f:
            f.write(preparar_markdown_docx(texto, e))
        docx_tmp = os.path.join(tmp, 'informe.docx')
        subprocess.run([pandoc, ruta_para(pandoc, md), '-f', 'markdown+smart', '-t', 'docx',
                        '--reference-doc=' + ruta_para(pandoc, ref), '-o', ruta_para(pandoc, docx_tmp)], check=True,
                       cwd=base)
        shutil.copy(docx_tmp, docx)
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
    print(f'PDF: {salida} ({os.path.getsize(salida) // 1024} KB, estética {opo.upper()}, vía DOCX + LibreOffice)')



def main():
    p = argparse.ArgumentParser(description='Informe en PDF con la estética de la oposición')
    p.add_argument('markdown', help='el informe en Markdown')
    p.add_argument('--oposicion', choices=['tcee', 'dce'], help='tcee (por defecto) o dce; si no se da, se deduce de la cabecera')
    p.add_argument('-o', '--salida', help='fichero PDF de salida (por defecto, el .md con extensión .pdf)')
    p.add_argument('--motor', choices=['auto', 'latex', 'docx'], default='auto',
                   help='latex: plantilla de los temas con XeLaTeX; docx: pandoc + LibreOffice; auto (por defecto): latex si hay XeLaTeX, si no docx')
    p.add_argument('--tex', action='store_true', help='deja también el .tex generado junto al PDF (para depurar)')
    a = p.parse_args()

    base = os.path.dirname(os.path.abspath(a.markdown))
    with open(a.markdown, encoding='utf-8') as f:
        texto = f.read()
    opo = a.oposicion or detectar_oposicion(texto)
    salida = os.path.abspath(a.salida or os.path.splitext(a.markdown)[0] + '.pdf')

    pandoc = programa('pandoc', 'PANDOC')
    if not pandoc:
        sys.exit('No encuentro pandoc. En el entorno de Claude suele estar; si no, instálalo o entrega el informe en Markdown y dilo.')
    xelatex = programa('xelatex', 'XELATEX')
    latexmk = programa('latexmk', 'LATEXMK')
    soffice = programa('soffice', 'SOFFICE') or programa('libreoffice', 'SOFFICE')

    if a.motor in ('auto', 'latex'):
        if xelatex or latexmk:
            if via_latex(texto, opo, salida, pandoc, xelatex, latexmk, base, guardar_tex=a.tex):
                return
            if a.motor == 'latex':
                sys.exit('La vía LaTeX ha fallado (arriba está el error). Prueba con --motor docx o corrige el Markdown.')
            print('La vía LaTeX ha fallado: paso a la vía DOCX + LibreOffice.')
        elif a.motor == 'latex':
            sys.exit('No encuentro XeLaTeX (ni latexmk). Instala TeX Live o MiKTeX, o usa --motor docx.')
        else:
            print('No hay XeLaTeX: uso la vía DOCX + LibreOffice.')
    via_docx(texto, opo, salida, pandoc, soffice, base)


if __name__ == '__main__':
    main()
