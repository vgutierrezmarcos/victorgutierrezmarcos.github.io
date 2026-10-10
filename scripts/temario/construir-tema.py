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
def sincronizar_lyx(tema):
    """Mantiene a la par T.lyx y T.tex, ambos en git.

    Los agentes escriben el .tex; Víctor puede editar el .lyx en LyX. Manda el
    más reciente: si el .lyx es más nuevo, LyX lo exporta a .tex; si lo es el
    .tex, tex2lyx regenera el .lyx. Sin LyX instalado no se hace nada.
    """
    tex = os.path.join(tema.dir, f'{tema.archivo}.tex')
    if not LYX:
        return 'LyX no está instalado: se usa solo el .tex'
    if os.path.exists(tema.lyx) and (not os.path.exists(tex) or os.path.getmtime(tema.lyx) > os.path.getmtime(tex) + 1):
        ejecutar([LYX, '--batch', '-E', 'pdflatex', ruta_windows(tex), ruta_windows(tema.lyx)],
                 env=entorno_tex(), timeout=600)
        return f'{tema.archivo}.lyx → {tema.archivo}.tex'
    if os.path.exists(tex) and (not os.path.exists(tema.lyx) or os.path.getmtime(tex) > os.path.getmtime(tema.lyx) + 1):
        ejecutar([TEX2LYX, '-f', '-n', ruta_windows(tex), ruta_windows(tema.lyx)], env=entorno_tex(), timeout=600)
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
    m = re.search(r'\\tcetema\{([^}]*)\}\{((?:[^{}]|\{[^{}]*\})*)\}', texto)
    f = re.search(r'\\tcefecha\{([^}]*)\}', texto)
    minutos = [int(x) for x in re.findall(r'\\minutos\{(\d+)\}', texto)]
    return {
        'titulo': m.group(2).strip() if m else '',
        'fecha': f.group(1) if f else datetime.date.today().strftime('%d/%m/%Y'),
        'duracion': sum(minutos) if minutos else None,
    }


# --- 2. Gráficos -------------------------------------------------------------------
def compilar_graficos(tema, forzar=False):
    """Compila cada graficos/*.tex a PDF, SVG y PNG. Devuelve la lista de errores."""
    errores = []
    env = entorno_tex()
    for tex in sorted(glob.glob(os.path.join(tema.graficos, '*.tex'))):
        base = tex[:-4]
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


def preparar_pandoc(tema, tex):
    """LaTeX para pandoc: las equivalencias de pandoc-macros.tex delante."""
    macros = open(os.path.join(LATEX, 'pandoc-macros.tex'), encoding='utf-8').read()
    cuerpo = open(tex, encoding='utf-8').read()
    destino = os.path.join(tema.trabajo, f'{tema.archivo}-pandoc.tex')
    with open(destino, 'w', encoding='utf-8') as f:
        f.write(macros + '\n' + cuerpo)
    return destino


def comunes_pandoc(tema, datos):
    orden = ['-f', 'latex', '--figure-caption-position=above', '--lua-filter', ruta_windows(os.path.join(LATEX, 'tcee.lua')),
             '-M', 'lang=es-ES', '-M', f'codigo={tema.codigo}', '-M', f'titulo={datos["titulo"]}',
             '-M', f'fecha={datos["fecha"]}', '-M', f'archivo={tema.archivo}',
             '-M', f'carpeta={tema.carpeta}', '-M', f'ejercicio={tema.nombre_ejercicio}']
    if os.path.exists(tema.bib):
        orden += ['--citeproc', '--bibliography', ruta_windows(tema.bib),
                  '-M', 'link-citations=true', '-M', 'reference-section-title=Bibliografía']
    return orden


def generar_html(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.html')
    corto = re.split(r'[.:]', datos['titulo'])[0].strip()
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'html5', '-s', '--mathjax',
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
    ejecutar(orden, timeout=600)
    return destino


def generar_docx(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.docx')
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'docx',
             '--reference-doc', ruta_windows(os.path.join(LATEX, 'reference.docx')),
             '-M', f'graficos-docx={ruta_windows(tema.graficos)}',
             '-M', f'title={tema.codigo}: {datos["titulo"]}',
             '-M', 'author=Víctor Gutiérrez Marcos',
             '-M', f'date=Fecha de la última actualización: {datos["fecha"]}',
             '--resource-path', ruta_windows(tema.dir), '-o', ruta_windows(destino)]
    orden += comunes_pandoc(tema, datos)
    ejecutar(orden, timeout=600)
    return destino


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--solo', choices=['pdf', 'html', 'docx', 'graficos'])
    ap.add_argument('--forzar-graficos', action='store_true')
    ap.add_argument('--no-publicar', action='store_true',
                    help='deja los resultados en _trabajo/ sin copiarlos a la carpeta pública')
    args = ap.parse_args()
    tema = Tema(args.tema)

    errores = compilar_graficos(tema, forzar=args.forzar_graficos)
    if errores:
        print('ERRORES EN LOS GRÁFICOS:\n' + '\n\n'.join(errores))
        sys.exit(1)
    print('Gráficos compilados.')
    if args.solo == 'graficos':
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
        tex_pandoc = preparar_pandoc(tema, tex)
        if args.solo in (None, 'html'):
            resultados['html'] = generar_html(tema, tex_pandoc, datos)
            print('HTML:', resultados['html'])
        if args.solo in (None, 'docx'):
            resultados['docx'] = generar_docx(tema, tex_pandoc, datos)
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
