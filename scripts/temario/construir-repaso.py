#!/usr/bin/env python3
"""
Compila la ficha de repaso de un tema (exactamente cuatro páginas, a dos columnas) y la publica
junto al tema.

    python3 scripts/temario/construir-repaso.py 3A08 [--no-publicar]

La fuente es fuentes/<tema>/repaso/<tema>-repaso.tex (estilo tcee-repaso.sty,
la escribe el agente tema-repaso). El script prueba tamaños de letra de 10,5 a
8 puntos y se queda con el mayor con el que la ficha cabe en cuatro páginas.
Avisa si sobra mucho sitio en la última (conviene añadir contenido) y falla
si ni con 8 puntos cabe (hay que recortar).

Salida: oposicion/temario/<ejercicio>/<tema>-repaso.pdf y, para revisarla,
fuentes/<tema>/_trabajo/repaso/<tema>-repaso-p1.png … -p4.png.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import os
import shutil
import sys

import fitz  # PyMuPDF

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, MIKTEX, entorno_tex, ejecutar, errores_log, ruta_windows, escribir_destinos_tex  # noqa: E402

TAMANOS = (10.5, 10, 9.5, 9, 8.75, 8.5, 8.25, 8)
PAGINAS = 4
LLENADO_MINIMO = 0.80      # parte de la última página que debe estar ocupada


def compilar(tema, tam, salida):
    fuente = os.path.join(tema.dir, 'repaso', f'{tema.archivo}-repaso.tex')
    env = entorno_tex()
    env['TEXINPUTS'] = ruta_windows(os.path.join(tema.dir, 'repaso')) + ';' + env['TEXINPUTS']
    trabajo = f'{tema.archivo}-repaso-{str(tam).replace(".", "_")}'
    orden = [os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
             f'-jobname={trabajo}', f'-output-directory={ruta_windows(salida)}',
             f'\\def\\tceetam{{{tam}}}\\input{{{tema.archivo}-repaso.tex}}']
    for _ in range(2):   # la segunda vez, para el número total de páginas
        cod, _ = ejecutar(orden, cwd=os.path.dirname(fuente), env=env, timeout=600, comprobar=False)
        if cod != 0:
            raise RuntimeError(f'Error de LaTeX ({tam} pt):\n'
                               + '\n'.join(errores_log(os.path.join(salida, trabajo + '.log'))))
    return os.path.join(salida, trabajo + '.pdf')


# Márgenes y columnas de tcee-repaso.sty (en puntos PostScript)
MARGEN_SUP, MARGEN_INF, MARGEN_LAT, SEP_COL, COLUMNAS = 1.1 * 28.35, 1.2 * 28.35, 1.2 * 28.35, 0.6 * 28.35, 2


def ocupacion(pagina):
    """Parte ocupada de las columnas de una página (media de las columnas).

    Como multicols* llena las columnas de una en una, la media mide de verdad el
    sitio que queda: una segunda columna vacía da 50 %, no 100 %. Se descartan el
    pie y las rayas verticales entre columnas, que ocupan toda la altura."""
    ancho, alto = pagina.rect.width, pagina.rect.height
    arriba, abajo = MARGEN_SUP, alto - MARGEN_INF
    ancho_col = (ancho - 2 * MARGEN_LAT - (COLUMNAS - 1) * SEP_COL) / COLUMNAS
    rects = [fitz.Rect(b[:4]) for b in pagina.get_text('blocks')]
    rects += [d['rect'] for d in pagina.get_drawings() if d['rect'].width > 1.5]   # sin rayas de columna
    rects += [fitz.Rect(i['bbox']) for i in pagina.get_image_info()]
    llenos = []
    for c in range(COLUMNAS):
        x0 = MARGEN_LAT + c * (ancho_col + SEP_COL)
        centro = [r for r in rects if x0 - 2 <= (r.x0 + r.x1) / 2 <= x0 + ancho_col + 2 and r.y1 <= abajo + 2]
        fondo = max((r.y1 for r in centro), default=arriba)
        llenos.append(min(1, max(0, (fondo - arriba) / (abajo - arriba))))
    return sum(llenos) / COLUMNAS, llenos


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--no-publicar', action='store_true')
    args = ap.parse_args()
    tema = Tema(args.tema)
    fuente = os.path.join(tema.dir, 'repaso', f'{tema.archivo}-repaso.tex')
    if not os.path.exists(fuente):
        print(f'No existe {os.path.relpath(fuente, tema.dir)} (lo escribe el agente tema-repaso)')
        sys.exit(1)
    salida = os.path.join(tema.trabajo, 'repaso')
    os.makedirs(salida, exist_ok=True)
    escribir_destinos_tex()     # destinos de \vertema (tcee-repaso.sty)

    elegido = None
    for tam in TAMANOS:
        pdf = compilar(tema, tam, salida)
        paginas = len(fitz.open(pdf))
        print(f'  {tam} pt: {paginas} páginas', flush=True)
        if paginas <= PAGINAS:
            elegido = (tam, pdf, paginas)
            break
    if not elegido:
        print(f'ERROR: ni con {TAMANOS[-1]} pt cabe en {PAGINAS} páginas: hay que recortar la ficha')
        sys.exit(1)
    tam, pdf, paginas = elegido
    doc = fitz.open(pdf)
    if paginas < PAGINAS:
        print(f'AVISO: la ficha ocupa {paginas} páginas: hay que añadir contenido hasta llenar {PAGINAS}')
    else:
        lleno, columnas = ocupacion(doc[PAGINAS - 1])
        print(f'Letra de {tam} pt; última página ocupada al {lleno:.0%} '
              f'(columnas: {", ".join(f"{c:.0%}" for c in columnas)})')
        if lleno < LLENADO_MINIMO:
            print(f'AVISO: sobra sitio en la última página ({lleno:.0%}): conviene añadir contenido')
    for i, pagina in enumerate(doc, 1):
        pagina.get_pixmap(dpi=110).save(os.path.join(salida, f'{tema.archivo}-repaso-p{i}.png'))
    final = os.path.join(salida, f'{tema.archivo}-repaso.pdf')
    shutil.copyfile(pdf, final)
    if not args.no_publicar:
        destino = os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf')
        shutil.copyfile(final, destino)
        print(f'Publicado en la rama: {tema.carpeta}/{tema.archivo}-repaso.pdf')


if __name__ == '__main__':
    main()
