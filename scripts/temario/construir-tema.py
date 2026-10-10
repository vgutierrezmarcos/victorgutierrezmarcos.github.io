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
from comun import (Tema, LATEX, MIKTEX, PANDOC, LYX, TEX2LYX, TEMARIO, entorno_tex, ejecutar,  # noqa: E402
                   errores_log, ruta_windows)

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
        if cod != 0:
            return f'AVISO: LyX no pudo exportar {tema.archivo}.lyx: {salida.strip()[-300:]}'
        open(marca, 'w').write(_huella_fichero(tema.lyx))
        return f'{tema.archivo}.lyx (editado en LyX) → {tema.archivo}.tex'
    if not os.path.exists(tema.lyx) or os.path.getmtime(tex) > os.path.getmtime(tema.lyx) + 1:
        cod, salida = _lyx_windows(TEX2LYX, ['-f', '-n', f'{tema.archivo}.tex', f'{tema.archivo}.lyx'], tema.dir)
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
    minutos = [int(x) for x in re.findall(r'\\minutos\{(\d+)\}', texto)]
    return {
        'titulo': m.group(2).strip() if m else '',
        'fecha': f.group(1) if f else datetime.date.today().strftime('%d/%m/%Y'),
        'duracion': sum(minutos) if minutos else None,
    }


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
    return antes + despues


def preparar_pandoc(tema, tex, formato):
    """LaTeX para pandoc: las equivalencias de pandoc-macros.tex delante, las
    referencias (\\ref, \\eqref) con el número que tienen en el PDF y los anexos
    con letra. En HTML, las ecuaciones citadas llevan su número (\\tag)."""
    macros = open(os.path.join(LATEX, 'pandoc-macros.tex'), encoding='utf-8').read()
    cuerpo = open(tex, encoding='utf-8').read()
    numeros = etiquetas_aux(tema)
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
    cuerpo = re.sub(r'\\multirow\{(\d+)\}\{[^}]*\}\{', r'\\textcolor{tceefilas\1}{', cuerpo)
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
    orden = ['-f', 'latex', '--figure-caption-position=above'] + (['--citeproc'] if os.path.exists(tema.bib) else []) + [
             '--lua-filter', ruta_windows(os.path.join(LATEX, 'tcee.lua')),
             '-M', 'lang=es-ES', '-M', f'codigo={tema.codigo}', '-M', f'titulo={datos["titulo"]}',
             '-M', f'fecha={datos["fecha"]}', '-M', f'archivo={tema.archivo}',
             '-M', f'carpeta={tema.carpeta}', '-M', f'ejercicio={tema.nombre_ejercicio}']
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
        orden += ['-M', f'duracion={datos["duracion"]}']
    video = video_de(tema)
    if video:
        orden += ['-M', f'video={video}']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf')):
        orden += ['-M', 'repaso=true']
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
    return destino


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
        print('PDF:', pdf, f'({fitz.open(pdf).page_count} páginas)')
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
