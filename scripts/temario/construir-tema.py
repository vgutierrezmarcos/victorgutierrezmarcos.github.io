#!/usr/bin/env python3
"""
Construye el PDF, la página HTML y el Word de un tema a partir de su fuente
LyX (o LaTeX) en oposicion/temario/fuentes/<tema>/.

    python3 scripts/temario/construir-tema.py 3A08 [--solo pdf|html|docx|graficos]

Pasos:
  1. Pone a la par T.lyx y T.tex (manda el más reciente; ver sincronizar_lyx).
  2. Compila cada gráfico de graficos/*.tex (TikZ standalone) a PDF y de ahí
     saca un SVG (para la web, con pdftocairo) y un PNG a 300 ppp (para Word).
  3. Compila el PDF del tema (pdflatex + biber + pdflatex ×2).
  4. Genera el HTML y el Word con pandoc (latex/tcee.lua, latex/pandoc-macros.tex,
     latex/plantilla-tema.html y latex/reference.docx).
  5. Copia los tres ficheros a oposicion/temario/<ejercicio>/<tema>.{pdf,html,docx}.

Los intermedios quedan en fuentes/<tema>/_trabajo/ (no van a git).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import datetime
import glob
import json
import os
import re
import shutil
import sys

import fitz  # PyMuPDF

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import (Tema, guardar_pdf_anterior, guardar_docx_anterior, LATEX, MIKTEX, PANDOC, LYX, TEX2LYX, TEMARIO, entorno_tex, ejecutar,  # noqa: E402
                   errores_log, ruta_windows, minutos_texto, paginas_partes, linea_paginas)

PDFLATEX = os.path.join(MIKTEX, 'pdflatex.exe')
BIBER = os.path.join(MIKTEX, 'biber.exe')
PDFTOCAIRO = os.path.join(MIKTEX, 'miktex-pdftocairo.exe')


# --- 1. LyX ↔ LaTeX ------------------------------------------------------------
def _lyx_windows(exe, argumentos, cwd):
    """LyX y tex2lyx necesitan que se les llame con su ruta completa de Windows
    (si no, no encuentran su instalación): se lanzan desde un .bat."""
    bat = os.path.join(cwd, '_lyx.bat')
    with open(bat, 'w', encoding='utf-8', newline='\r\n') as f:
        f.write('@echo off\nchcp 65001 >nul\n')
        f.write(f'set PATH={ruta_windows(MIKTEX)};%PATH%\n')
        f.write(f'cd /d "{ruta_windows(cwd)}"\n')
        f.write(f'"{ruta_windows(exe)}" ' + ' '.join(f'"{a}"' for a in argumentos) + '\n')
    try:
        return ejecutar(['/mnt/c/Windows/System32/cmd.exe', '/c', ruta_windows(bat)], timeout=900, comprobar=False)
    finally:
        os.remove(bat)


def _huella_fichero(ruta):
    import hashlib
    return hashlib.sha1(open(ruta, 'rb').read()).hexdigest()


def sincronizar_lyx(tema):
    """Mantiene a la par T.lyx y T.tex, ambos en git.

    El .tex es la fuente de los agentes; el .lyx se regenera a partir de él
    para que Víctor pueda abrir el tema en LyX. Solo si Víctor ha editado el
    .lyx (su contenido ya no es el que generó tex2lyx) se exporta a .tex.
    Sin LyX, o si LyX falla, se avisa y se sigue con el .tex.
    """
    tex = os.path.join(tema.dir, f'{tema.archivo}.tex')
    marca = os.path.join(tema.trabajo, 'lyx-generado.sha1')
    if not LYX or not TEX2LYX:
        return 'LyX no está instalado: se usa solo el .tex'
    generado = open(marca).read().strip() if os.path.exists(marca) else None
    if os.path.exists(tema.lyx) and generado and _huella_fichero(tema.lyx) != generado:
        cod, salida = _lyx_windows(LYX, ['--batch', '-E', 'pdflatex', f'{tema.archivo}.tex', f'{tema.archivo}.lyx'],
                                   tema.dir)
        if cod != 0 or os.path.getmtime(tex) < os.path.getmtime(tema.lyx):
            return (f'AVISO: {tema.archivo}.lyx se ha editado en LyX pero no se pudo exportar desde aquí: '
                    f'en LyX, Archivo > Exportar > LaTeX (pdflatex) sobre {tema.archivo}.tex, y volver a construir')
        open(marca, 'w').write(_huella_fichero(tema.lyx))
        return f'{tema.archivo}.lyx (editado en LyX) → {tema.archivo}.tex'
    if not os.path.exists(tema.lyx) or os.path.getmtime(tex) > os.path.getmtime(tema.lyx) + 1:
        # El módulo tcee.module convierte \\autor, \\concepto, las cajas… en elementos de LyX
        modulo = os.path.join(os.environ.get('LYX_USERDIR', '/mnt/c/Users/vgutierrez/AppData/Roaming/LyX2.4'),
                              'layouts', 'tcee.module')
        if os.path.isdir(os.path.dirname(modulo)):
            shutil.copyfile(os.path.join(LATEX, 'tcee.module'), modulo)
        cod, salida = _lyx_windows(TEX2LYX, ['-m', 'tcee', '-f', '-n', f'{tema.archivo}.tex', f'{tema.archivo}.lyx'],
                                   tema.dir)
        if cod != 0 or not os.path.exists(tema.lyx) or os.path.getsize(tema.lyx) == 0:
            if os.path.exists(tema.lyx) and os.path.getsize(tema.lyx) == 0:
                os.remove(tema.lyx)
            return f'AVISO: tex2lyx no pudo generar {tema.archivo}.lyx: {salida.strip()[-300:]}'
        os.makedirs(tema.trabajo, exist_ok=True)
        open(marca, 'w').write(_huella_fichero(tema.lyx))
        return f'{tema.archivo}.tex → {tema.archivo}.lyx'
    return 'LyX y LaTeX ya estaban a la par'


def exportar_latex(tema):
    os.makedirs(tema.trabajo, exist_ok=True)
    print(sincronizar_lyx(tema))
    tex_fuente = os.path.join(tema.dir, f'{tema.archivo}.tex')
    if not os.path.exists(tex_fuente):
        raise RuntimeError(f'No hay {tema.archivo}.tex ni {tema.archivo}.lyx en {tema.dir}')
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.tex')
    shutil.copyfile(tex_fuente, destino)
    return destino


def datos_documento(tex):
    texto = open(tex, encoding='utf-8').read()
    m = re.search(r'\\tcetema(?:\[[^\]]*\])?\{([^}]*)\}\{((?:[^{}]|\{[^{}]*\})*)\}', texto)
    f = re.search(r'\\tcefecha\{([^}]*)\}', texto)
    # Se admiten medios minutos: \minutos{2,5}
    minutos = [float(x.replace(',', '.')) for x in re.findall(r'\\minutos\{(\d+(?:[.,]\d+)?)\}', texto)]
    return {
        'titulo': m.group(2).strip() if m else '',
        'fecha': f.group(1) if f else datetime.date.today().strftime('%d/%m/%Y'),
        'duracion': (f'{sum(minutos):g}'.replace('.', ',')) if minutos else None,
        # Para la web: 30 → «30 minutos»; 29,5 → «29′30″»
        'duracion_texto': (f'{sum(minutos):g} minutos' if sum(minutos) == int(sum(minutos))
                           else minutos_texto(sum(minutos))) if minutos else None,
    }


def datos_seo(tema):
    """Campos opcionales para buscadores de fuentes/<tema>/seo.json: titulo_seo
    (el concepto primero: «Teoría del consumidor: preferencias y demanda»),
    resumen (2-3 frases, ≤160 caracteres; va de meta description y visible bajo
    el título), palabras_clave (lista: modelos, autores, teoremas) y materia (la
    asignatura universitaria). Si falta el fichero, la página sale como antes."""
    ruta = os.path.join(tema.dir, 'seo.json')
    if not os.path.exists(ruta):
        return {}
    with open(ruta, encoding='utf-8') as f:
        seo = json.load(f)
    if isinstance(seo.get('palabras_clave'), list):
        seo['palabras_clave'] = ', '.join(seo['palabras_clave'])
    # Van dentro de atributos HTML y de JSON-LD: sin comillas rectas ni barras invertidas
    return {k: str(v).replace('"', '”').replace('\\', '').strip() for k, v in seo.items() if v}


# --- 2. Gráficos -------------------------------------------------------------------
def compilar_graficos(tema, forzar=False, solo=None):
    """Compila cada graficos/*.tex a PDF, SVG y PNG. Devuelve la lista de errores."""
    errores = []
    env = entorno_tex()
    for tex in sorted(glob.glob(os.path.join(tema.graficos, '*.tex'))):
        base = tex[:-4]
        if solo and os.path.basename(base) not in solo:
            continue
        pdf, svg, png = base + '.pdf', base + '.svg', base + '.png'
        if not forzar and all(os.path.exists(x) and os.path.getmtime(x) >= os.path.getmtime(tex)
                              for x in (pdf, svg, png)):
            continue
        nombre = os.path.basename(tex)
        cod, _ = ejecutar([PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', nombre],
                          cwd=tema.graficos, env=env, timeout=300, comprobar=False)
        if cod != 0:
            errores.append(f'{nombre}:\n' + '\n'.join(errores_log(base + '.log')))
            continue
        ejecutar([PDFTOCAIRO, '-svg', os.path.basename(pdf), os.path.basename(svg)], cwd=tema.graficos)
        doc = fitz.open(pdf)
        doc[0].get_pixmap(dpi=300, alpha=False).save(png)
        doc.close()
        for ext in ('.aux', '.log'):
            if os.path.exists(base + ext):
                os.remove(base + ext)
    return errores


# --- 3. PDF ----------------------------------------------------------------------------
def compilar_pdf(tema, tex):
    env = entorno_tex()
    # Para que \graphicspath{{graficos/}} y \addbibresource{3A08.bib} funcionen,
    # se compila en la carpeta del tema y los auxiliares van a _trabajo/
    env['TEXINPUTS'] = ruta_windows(tema.dir) + ';' + env['TEXINPUTS']
    nombre = os.path.basename(tex)
    rel = os.path.relpath(tex, tema.dir)
    salida = ['-output-directory=_trabajo']
    orden = [PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', *salida, rel.replace('/', '\\')]
    log = os.path.join(tema.trabajo, nombre[:-4] + '.log')
    cod, _ = ejecutar(orden, cwd=tema.dir, env=env, timeout=900, comprobar=False)
    if cod != 0:
        raise RuntimeError('Error de LaTeX:\n' + '\n\n'.join(errores_log(log)))
    if os.path.exists(tema.bib):
        ejecutar([BIBER, '--input-directory', '_trabajo', '--output-directory', '_trabajo',
                  nombre[:-4]], cwd=tema.dir, env=env, timeout=300)
    for _ in range(2):
        cod, _ = ejecutar(orden, cwd=tema.dir, env=env, timeout=900, comprobar=False)
        if cod != 0:
            raise RuntimeError('Error de LaTeX:\n' + '\n\n'.join(errores_log(log)))
    texto_log = open(log, encoding='latin-1').read()
    avisos = sorted(set(re.findall(r'(?:LaTeX|Package \w+) Warning: ([^\n]*(?:undefined|multiply)[^\n]*)', texto_log)))
    return os.path.join(tema.trabajo, nombre[:-4] + '.pdf'), avisos


# --- 4. HTML y Word --------------------------------------------------------------------
def video_de(tema):
    ruta = os.path.join(TEMARIO, 'videos.json')
    if os.path.exists(ruta):
        with open(ruta, encoding='utf-8') as f:
            return json.load(f).get(tema.archivo)
    return None


def etiquetas_aux(tema):
    """Números de las etiquetas según el .aux del PDF: {'eq:gorman': '17', 'anexo:cardinal': 'A'}."""
    aux = os.path.join(tema.trabajo, f'{tema.archivo}.aux')
    if not os.path.exists(aux):
        return {}
    texto = open(aux, encoding='utf-8', errors='replace').read()
    return {m.group(1): m.group(2) for m in re.finditer(r'\\newlabel\{([^}]+)\}\{\{([^}]*)\}', texto)}


def numerar_anexos(cuerpo):
    """Tras \\appendix, los apartados pasan a «A.», «A.1.»… como en el PDF (pandoc no
    entiende \\appendix y seguiría con la numeración romana)."""
    if '\\appendix' not in cuerpo:
        return cuerpo
    antes, despues = cuerpo.split('\\appendix', 1)
    letra, sub = 0, 0

    def cambiar(m):
        nonlocal letra, sub
        nivel = m.group(1)
        if nivel == 'section':
            letra += 1
            sub = 0
            return f'\\section*{{{chr(64 + letra)}. '
        sub += 1
        return f'\\subsection*{{{chr(64 + letra)}.{sub}. '
    despues = re.sub(r'\\(section|subsection)\{', cambiar, despues)
    # En Word, los anexos son otra sección (páginas A-1…; tcee.lua y numerar_paginas_docx)
    return antes + '\\begin{saltoseccion}\\mbox{}\\end{saltoseccion}' + despues


# --- Órdenes con argumentos anidados (\funcionclave, \optim) --------------------------
def _argumento(texto, i):
    """Lee el argumento entre llaves que empieza en texto[i] (saltando espacios):
    devuelve (contenido, posición tras la llave de cierre)."""
    while i < len(texto) and texto[i] in ' \t\n':
        i += 1
    if i >= len(texto) or texto[i] != '{':
        raise ValueError(f'se esperaba «{{» en: {texto[i:i + 60]!r}')
    nivel, j = 0, i
    while j < len(texto):
        c = texto[j]
        if c == '\\':
            j += 2
            continue
        if c == '{':
            nivel += 1
        elif c == '}':
            nivel -= 1
            if nivel == 0:
                return texto[i + 1:j], j + 1
        j += 1
    raise ValueError(f'llave sin cerrar en: {texto[i:i + 60]!r}')


def _partir_filas(texto):
    """Parte por \\\\ en el nivel de llaves superior."""
    filas, nivel, actual, j = [], 0, '', 0
    while j < len(texto):
        if texto.startswith('\\\\', j) and nivel == 0:
            filas.append(actual)
            actual = ''
            j += 2
            continue
        c = texto[j]
        if c == '\\':
            actual += texto[j:j + 2]
            j += 2
            continue
        nivel += (c == '{') - (c == '}')
        actual += c
        j += 1
    filas.append(actual)
    return [f.strip() for f in filas if f.strip()]


def expandir_optim(cuerpo):
    """\\optim{\\max}{\\vect{z}}{objetivo}{r1\\\\ r2} → array de dos columnas (lo
    mismo que hace tcee.sty), que MathJax y el Word de pandoc entienden."""
    salida, pos = '', 0
    for m in re.finditer(r'\\optim(?![a-zA-Z])', cuerpo):
        if m.start() < pos:
            continue
        args, j = [], m.end()
        try:
            for _ in range(4):
                a, j = _argumento(cuerpo, j)
                args.append(a)
        except ValueError:
            continue        # p. ej., «\optim» citado en un comentario
        filas = [f'\\displaystyle {args[0]}_{{{args[1]}}} & \\displaystyle {args[2]}']
        for k, r in enumerate(_partir_filas(expandir_optim(args[3]))):
            filas.append(('\\text{s.a.} & ' if k == 0 else ' & ') + r)
        salida += cuerpo[pos:m.start()] + '\\begin{array}{rl}' + ' \\\\ '.join(filas) + '\\end{array}'
        pos = j
    return salida + cuerpo[pos:]


def expandir_funcionclave(cuerpo):
    """\\funcionclave[eq:x]{F} → entorno «funcionclave» (un Div para tcee.lua) con
    la ecuación dentro; con etiqueta, en equation para que lleve su número."""
    salida, pos = '', 0
    for m in re.finditer(r'\\funcionclave(?![a-zA-Z])\s*(?:\[([^\]]*)\])?', cuerpo):
        if m.start() < pos:
            continue
        try:
            formula, j = _argumento(cuerpo, m.end())
        except ValueError:
            continue
        if m.group(1):
            ecuacion = f'\\begin{{equation}}{formula}\\label{{{m.group(1)}}}\\end{{equation}}'
        else:
            ecuacion = f'\\[{formula}\\]'
        salida += cuerpo[pos:m.start()] + f'\n\\begin{{funcionclave}}\n{ecuacion}\n\\end{{funcionclave}}\n'
        pos = j
    return salida + cuerpo[pos:]


def preparar_pandoc(tema, tex, formato):
    """LaTeX para pandoc: las equivalencias de pandoc-macros.tex delante, las
    referencias (\\ref, \\eqref) con el número que tienen en el PDF y los anexos
    con letra. En HTML, las ecuaciones citadas llevan su número (\\tag)."""
    macros = open(os.path.join(LATEX, 'pandoc-macros.tex'), encoding='utf-8').read()
    cuerpo = open(tex, encoding='utf-8').read()
    numeros = etiquetas_aux(tema)
    cuerpo = expandir_funcionclave(expandir_optim(cuerpo))
    # \grafico[\textwidth]: pandoc no entiende un ancho sin número y deja el
    # gráfico pequeño en la web; se trata como 1\textwidth
    cuerpo = re.sub(r'(?<![\d.])\\(textwidth|linewidth|columnwidth)\b', r'1\\\1', cuerpo)
    cuerpo = re.sub(r'\\eqref\{([^}]+)\}', lambda m: f'({numeros.get(m.group(1), "?")})', cuerpo)
    cuerpo = re.sub(r'\\(?:auto|c|C|name)?ref\{([^}]+)\}', lambda m: numeros.get(m.group(1), '?'), cuerpo)

    def etiqueta(m):
        n = numeros.get(m.group(1))
        if formato == 'html' and n and m.group(1).startswith('eq'):
            return f'\\tag{{{n}}}'
        return ''
    # Solo las etiquetas dentro de fórmulas; las de figuras y apartados las usa pandoc
    cuerpo = re.sub(r'(\\begin\{(equation|align|gather|multline)\*?\}.*?\\end\{\2\*?\})',
                    lambda m: re.sub(r'\\label\{([^}]+)\}', etiqueta, m.group(1)), cuerpo, flags=re.S)
    cuerpo = numerar_anexos(cuerpo)
    # Tablas: pandoc no entiende \multirow, \newline, \cellcolor ni \rowcolor y
    # pierde lo que va en {\footnotesize …}. Se dejan como marcas de color
    # (\textcolor{tcee…}) que tcee.lua convierte en celdas combinadas, saltos de
    # línea y fondos.
    # \multirow[c]{n}[bigstruts]{ancho}[desplazamiento]{texto}: solo cuenta n
    cuerpo = re.sub(r'\\multirow(?:\[[^\]]*\])?\{(\d+)\}(?:\[[^\]]*\])?\{[^}]*\}(?:\[[^\]]*\])?\{',
                    r'\\textcolor{tceefilas\1}{', cuerpo)
    # Columnas centradas (>{\centering\arraybackslash}m{…} o p{…}): pandoc las lee
    # como alineadas a la izquierda; como «c» salen centradas (y tcee.lua las
    # centra también en vertical)
    cuerpo = re.sub(r'>\{\\centering(?:\\arraybackslash)?\}[mpb]\{[^{}]*\}', 'c', cuerpo)
    # Con columnas «c», pandoc deja el argumento de \cline como texto («1-2»): las
    # rayas parciales no hacen falta en la web ni en Word
    cuerpo = re.sub(r'\\cline\{[^}]*\}', '', cuerpo)
    cuerpo = re.sub(r'\\newline\b\s*', r'\\textcolor{tceesalto}{.}', cuerpo)
    cuerpo = re.sub(r'\\cellcolor\{(\w+)\}', r'\\textcolor{tceefondo\1}{.}', cuerpo)
    cuerpo = re.sub(r'\\rowcolor\{(\w+)\}', r'\\textcolor{tceefilafondo\1}{.}', cuerpo)
    cuerpo = re.sub(r'\{\\(?:footnotesize|scriptsize|small)\s+', r'\\textcolor{tceenota}{', cuerpo)
    # Dentro de \text{…} de una fórmula, \autor{} y \textsc{} rompen la conversión
    # de la ecuación en Word: se dejan como texto normal
    patron_text = re.compile(r'(\\text\{[^{}]*)\\(?:autor|textsc)\{([^{}]*)\}')
    while patron_text.search(cuerpo):
        cuerpo = patron_text.sub(r'\1\2', cuerpo)
    # Los saltos de página del PDF pasan a Word (tcee.lua los convierte; en HTML se quitan)
    cuerpo = re.sub(r'\\(?:clearpage|newpage|pagebreak)\b', r'\\begin{saltopagina}\\mbox{}\\end{saltopagina}', cuerpo)
    destino = os.path.join(tema.trabajo, f'{tema.archivo}-pandoc-{formato}.tex')
    with open(destino, 'w', encoding='utf-8') as f:
        f.write(macros + '\n' + cuerpo)
    return destino


def comunes_pandoc(tema, datos):
    # citeproc va antes del filtro para que tcee.lua vea ya la bibliografía (salto de página en Word)
    orden = ['-f', 'latex', '--figure-caption-position=above'] + (['--citeproc', '--csl', ruta_windows(os.path.join(LATEX, 'tcee.csl'))] if os.path.exists(tema.bib) else []) + [
             '--lua-filter', ruta_windows(os.path.join(LATEX, 'tcee.lua')),
             '-M', 'lang=es-ES', '-M', f'codigo={tema.codigo}', '-M', f'titulo={datos["titulo"]}',
             '-M', f'fecha={datos["fecha"]}', '-M', f'archivo={tema.archivo}',
             '-M', f'carpeta={tema.carpeta}', '-M', f'ejercicio={tema.nombre_ejercicio}']
    try:
        dia = datetime.datetime.strptime(datos['fecha'], '%d/%m/%Y').date()
    except ValueError:
        dia = datetime.date.today()
    orden += ['-M', f'fecha-iso={dia.isoformat()}', '-M', f'fecha-cita={dia:%Y/%m/%d}', '-M', f'anio={dia.year}']
    paginas = linea_paginas(paginas_partes(os.path.join(tema.trabajo, f'{tema.archivo}.aux')))
    if paginas:
        orden += ['-M', f'paginas={paginas}']
    for campo, valor in datos_seo(tema).items():
        orden += ['-M', f'{campo.replace("_", "-")}={valor}']
    if os.path.exists(tema.bib):
        orden += ['--bibliography', ruta_windows(tema.bib),
                  '-M', 'link-citations=true', '-M', 'reference-section-title=Bibliografía']
    return orden


def generar_html(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.html')
    corto = re.split(r'[.:]', datos['titulo'])[0].strip()
    # --wrap=none: si pandoc parte una línea dentro de \text{…}, MathJax se come el espacio
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'html5', '-s', '--mathjax', '--wrap=none',
             '--template', ruta_windows(os.path.join(LATEX, 'plantilla-tema.html')),
             '--toc', '--toc-depth=2', '--section-divs',
             '-M', f'graficos-html=../fuentes/{tema.archivo}/graficos',
             '-M', f'titulo-corto={corto}', '-o', ruta_windows(destino)]
    orden += comunes_pandoc(tema, datos)
    if datos['duracion']:
        orden += ['-M', f'duracion={datos["duracion_texto"]}']
    video = video_de(tema)
    if video:
        orden += ['-M', f'video={video}']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf')):
        orden += ['-M', 'repaso=true']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-anterior.pdf')):
        orden += ['-M', 'anterior=true']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-anterior.docx')):
        orden += ['-M', 'anterior-docx=true']
    ejecutar(orden, timeout=600)
    return destino


def generar_docx(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.docx')
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'docx',
             '--reference-doc', ruta_windows(os.path.join(LATEX, 'reference.docx')),
             '-M', f'graficos-docx={ruta_windows(tema.graficos)}',
             '-M', f'title={tema.codigo}: {datos["titulo"]}',
             '-M', 'author=Víctor Gutiérrez Marcos',
             '-M', f'date=Última actualización: {datos["fecha"]}',
             '--resource-path', ruta_windows(tema.dir), '-o', ruta_windows(destino)]
    orden += comunes_pandoc(tema, datos)
    ejecutar(orden, timeout=600)
    centrar_celdas_docx(destino)
    retocar_docx(destino)
    return destino


def centrar_celdas_docx(ruta):
    """En las tablas con alguna celda centrada (columnas >{\\centering}m{…} del
    LaTeX), centra todas las celdas también en vertical (w:vAlign), como en el
    PDF: pandoc no lo escribe."""
    import zipfile
    with zipfile.ZipFile(ruta) as z:
        partes = {n: z.read(n) for n in z.namelist()}
        infos = {i.filename: i for i in z.infolist()}
    xml = partes['word/document.xml'].decode('utf-8')

    def tabla(m):
        t = m.group(0)
        if '<w:jc w:val="center"' not in t:
            return t
        t = t.replace('<w:tcPr />', '<w:tcPr><w:vAlign w:val="center" /></w:tcPr>')
        return re.sub(r'<w:tcPr>((?:(?!</w:tcPr>).)*?)</w:tcPr>',
                      lambda c: c.group(0) if 'w:vAlign' in c.group(1)
                      else f'<w:tcPr>{c.group(1)}<w:vAlign w:val="center" /></w:tcPr>', t, flags=re.S)
    nuevo = re.sub(r'<w:tbl>.*?</w:tbl>', tabla, xml, flags=re.S)
    if nuevo == xml:
        return
    partes['word/document.xml'] = nuevo.encode('utf-8')
    with zipfile.ZipFile(ruta, 'w', zipfile.ZIP_DEFLATED) as z:
        for nombre, datos in partes.items():
            z.writestr(infos[nombre], datos)


def _partes_docx(ruta):
    import zipfile
    with zipfile.ZipFile(ruta) as z:
        return {n: z.read(n) for n in z.namelist()}, {i.filename: i for i in z.infolist()}


def _guardar_docx(ruta, partes, infos):
    import zipfile
    with zipfile.ZipFile(ruta, 'w', zipfile.ZIP_DEFLATED) as z:
        for nombre, datos in partes.items():
            if nombre in infos:
                z.writestr(infos[nombre], datos)
            else:
                z.writestr(nombre, datos)


_PARRAFO = re.compile(r'<w:p(?: [^>]*)?>.*?</w:p>|<w:p(?: [^>]*)?/>', re.S)


def conservar_listas_docx(xml):
    """«Conservar con el siguiente» (w:keepNext) en cada párrafo seguido de otro
    de nivel más profundo: una viñeta seguida de una subviñeta y un párrafo
    normal seguido de una lista, como el beginpenalty=10000 de tcee.sty. Solo
    en el cuerpo (no dentro de tablas ni notas)."""
    cuerpo_ini = xml.find('<w:body>')
    trozos = re.split(r'(<w:tbl>.*?</w:tbl>)', xml[cuerpo_ini:], flags=re.S)
    salida = [xml[:cuerpo_ini]]
    for t, trozo in enumerate(trozos):
        if t % 2:            # tabla
            salida.append(trozo)
            continue
        parrafos = list(_PARRAFO.finditer(trozo))

        def nivel(p):
            m = re.search(r'<w:ilvl w:val="(\d+)"', p)
            if m:
                return int(m.group(1))
            estilo = re.search(r'<w:pStyle w:val="([^"]+)"', p)
            if estilo and estilo.group(1) not in ('BodyText', 'FirstParagraph', 'Compact', 'Normal'):
                return None      # títulos, cajas, figuras…: no cuentan
            return -1            # párrafo normal
        niveles = [nivel(p.group(0)) for p in parrafos]
        nuevo, pos = '', 0
        for k, p in enumerate(parrafos):
            texto = p.group(0)
            sig = niveles[k + 1] if k + 1 < len(parrafos) else None
            # Solo si los dos párrafos son seguidos (nada entre medias)
            seguidos = k + 1 < len(parrafos) and not trozo[p.end():parrafos[k + 1].start()].strip()
            if (niveles[k] is not None and sig is not None and seguidos and sig > niveles[k]
                    and '<w:keepNext' not in texto):
                if '<w:pPr>' in texto:
                    texto = re.sub(r'<w:pPr>((?:<w:pStyle [^>]*/>)?)', r'<w:pPr>\1<w:keepNext />', texto, count=1)
                elif '<w:pPr />' in texto:
                    texto = texto.replace('<w:pPr />', '<w:pPr><w:keepNext /></w:pPr>', 1)
                else:
                    texto = re.sub(r'^(<w:p(?: [^>]*)?>)', r'\1<w:pPr><w:keepNext /></w:pPr>', texto, count=1)
            nuevo += trozo[pos:p.start()] + texto
            pos = p.end()
        salida.append(nuevo + trozo[pos:])
    return ''.join(salida)


def numerar_paginas_docx(partes):
    """Secciones de Word como las partes del PDF: el tema en 1…N, los anexos en
    A-1… y la bibliografía en B-1…, cada una con «página/páginas de la
    sección» al pie. tcee.lua deja una marca @@TCEE-SECCION:A@@ donde empieza
    cada parte; aquí cada marca pasa a ser un salto de sección."""
    xml = partes['word/document.xml'].decode('utf-8')
    marcas = list(re.finditer(r'<w:p>(?:(?!</w:p>).)*?@@TCEE-SECCION:([A-Z])@@(?:(?!</w:p>).)*?</w:p>', xml, re.S))
    i = xml.rfind('<w:sectPr')
    final = re.match(r'<w:sectPr>(.*?)</w:sectPr>', xml[i:], re.S)
    pie = re.search(r'<w:footerReference r:id="([^"]+)" w:type="default"\s*/>', final.group(1)) if final else None
    rels = partes['word/_rels/document.xml.rels'].decode('utf-8')
    destino_pie = re.search(rf'<Relationship[^>]*Id="{pie.group(1)}"[^>]*/>', rels) if pie else None
    if not (final and pie and destino_pie):
        return
    nombre_pie = 'word/' + re.search(r'Target="([^"]+)"', destino_pie.group(0)).group(1)
    pie_xml = partes[nombre_pie].decode('utf-8').replace(' NUMPAGES ', ' SECTIONPAGES ')
    partes[nombre_pie] = pie_xml.encode('utf-8')
    tipos = partes['[Content_Types].xml'].decode('utf-8')

    def pie_con_letra(letra):
        nombre = f'footerTcee{letra}.xml'
        if f'word/{nombre}' not in partes:
            m = re.search(r'<w:r>(<w:rPr>(?:(?!</w:rPr>).)*</w:rPr>)<w:fldChar w:fldCharType="begin"', pie_xml, re.S)
            rpr = m.group(1) if m else ''
            texto = re.sub(r'(<w:r>' + re.escape(rpr) + r'<w:fldChar w:fldCharType="begin"\s*/><w:instrText[^>]*> PAGE )',
                           f'<w:r>{rpr}<w:t>{letra}-</w:t></w:r>' + r'\1', pie_xml, count=1)
            partes[f'word/{nombre}'] = texto.encode('utf-8')
        return nombre

    def seccion(rid):
        interior = re.sub(r'<w:footerReference r:id="[^"]+" w:type="default"\s*/>',
                          f'<w:footerReference r:id="{rid}" w:type="default" />', final.group(1))
        interior = interior.replace('w:val="eachSect"', 'w:val="continuous"')
        interior = re.sub(r'<w:pgNumType[^>]*/>', '', interior)
        interior = re.sub(r'(<w:pgMar [^>]*/>)', r'\1<w:pgNumType w:start="1" />', interior, count=1)
        return f'<w:sectPr>{interior}</w:sectPr>'

    rid_actual = pie.group(1)
    nuevo, pos = '', 0
    for m in marcas:
        letra = m.group(1)
        nombre = pie_con_letra(letra)
        rid = f'rIdTcee{letra}'
        if rid not in rels:
            rels = rels.replace('</Relationships>', f'<Relationship Id="{rid}" Target="{nombre}" Type="http://schemas.'
                                'openxmlformats.org/officeDocument/2006/relationships/footer" /></Relationships>')
            tipos = tipos.replace('</Types>', f'<Override PartName="/word/{nombre}" ContentType="application/vnd.'
                                  'openxmlformats-officedocument.wordprocessingml.footer+xml" /></Types>')
        # Párrafo mínimo que cierra la sección anterior
        cierre = ('<w:p><w:pPr><w:spacing w:before="0" w:after="0" w:line="20" w:lineRule="exact" />'
                  f'{seccion(rid_actual)}</w:pPr></w:p>')
        nuevo += xml[pos:m.start()] + cierre
        pos = m.end()
        rid_actual = rid
    resto = xml[pos:]
    j = resto.rfind('<w:sectPr')
    resto = resto[:j] + re.sub(r'<w:sectPr>.*?</w:sectPr>', lambda _: seccion(rid_actual), resto[j:], count=1, flags=re.S)
    partes['word/document.xml'] = (nuevo + resto).encode('utf-8')
    partes['word/_rels/document.xml.rels'] = rels.encode('utf-8')
    partes['[Content_Types].xml'] = tipos.encode('utf-8')


def retocar_docx(ruta):
    """Postproceso del Word: listas que no se separan de lo que las introduce y
    numeración de páginas por partes."""
    partes, infos = _partes_docx(ruta)
    partes['word/document.xml'] = conservar_listas_docx(partes['word/document.xml'].decode('utf-8')).encode('utf-8')
    numerar_paginas_docx(partes)
    imagenes_notas_docx(partes)
    _guardar_docx(ruta, partes, infos)


def imagenes_notas_docx(partes):
    """pandoc deja la relación de las imágenes de las notas al pie
    (\\graficonota) en document.xml.rels y Word no las encuentra: se copian a
    footnotes.xml.rels."""
    notas = partes.get('word/footnotes.xml', b'').decode('utf-8')
    nombre_rels = 'word/_rels/footnotes.xml.rels'
    rels_notas = partes.get(nombre_rels, b'').decode('utf-8')
    rels_doc = partes['word/_rels/document.xml.rels'].decode('utf-8')
    if not rels_notas:
        rels_notas = ('<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/'
                      'package/2006/relationships"></Relationships>')
    cambiado = False
    for rid in set(re.findall(r'r:embed="([^"]+)"', notas)):
        if f'Id="{rid}"' in rels_notas:
            continue
        rel = re.search(rf'<Relationship [^>]*Id="{rid}"[^>]*/>', rels_doc)
        if rel:
            rels_notas = rels_notas.replace('</Relationships>', rel.group(0) + '</Relationships>')
            cambiado = True
    if cambiado:
        partes[nombre_rels] = rels_notas.encode('utf-8')


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--solo', choices=['pdf', 'html', 'docx', 'graficos'])
    ap.add_argument('--forzar-graficos', action='store_true')
    ap.add_argument('--grafico', action='append',
                    help='compila solo ese gráfico (nombre sin .tex; se puede repetir). '
                         'Para que varios agentes TikZ trabajen a la vez sin pisarse')
    ap.add_argument('--no-publicar', action='store_true',
                    help='deja los resultados en _trabajo/ sin copiarlos a la carpeta pública')
    args = ap.parse_args()
    tema = Tema(args.tema)
    guardar_pdf_anterior(tema)
    guardar_docx_anterior(tema)

    errores = compilar_graficos(tema, forzar=args.forzar_graficos or bool(args.grafico), solo=args.grafico)
    if errores:
        print('ERRORES EN LOS GRÁFICOS:\n' + '\n\n'.join(errores))
        sys.exit(1)
    print('Gráficos compilados.')
    if args.solo == 'graficos' or args.grafico:
        return

    tex = exportar_latex(tema)
    datos = datos_documento(tex)
    resultados = {}
    if args.solo in (None, 'pdf'):
        pdf, avisos = compilar_pdf(tema, tex)
        resultados['pdf'] = pdf
        for a in avisos:
            print('AVISO LaTeX:', a)
        partes = paginas_partes(os.path.join(tema.trabajo, f'{tema.archivo}.aux'))
        print('PDF:', pdf, f'({fitz.open(pdf).page_count} páginas en total)')
        if partes:
            print(f'Páginas del tema: {partes.get("tema", "?")} (anexos: {partes.get("anexos", 0)}; '
                  f'bibliografía: {partes.get("bib", 0)})')
    if args.solo in (None, 'html', 'docx'):
        if args.solo in (None, 'html'):
            resultados['html'] = generar_html(tema, preparar_pandoc(tema, tex, 'html'), datos)
            print('HTML:', resultados['html'])
        if args.solo in (None, 'docx'):
            resultados['docx'] = generar_docx(tema, preparar_pandoc(tema, tex, 'docx'), datos)
            print('Word:', resultados['docx'])

    if not args.no_publicar:
        os.makedirs(tema.dir_publico, exist_ok=True)
        for ext, ruta in resultados.items():
            destino = os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}')
            shutil.copyfile(ruta, destino)
            print('Publicado en la rama:', os.path.relpath(destino, TEMARIO))
    if datos['duracion']:
        print(f'Duración del cante según \\minutos: {datos["duracion"]} min')


if __name__ == '__main__':
    main()
