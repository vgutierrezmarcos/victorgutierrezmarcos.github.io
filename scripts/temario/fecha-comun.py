#!/usr/bin/env python3
"""Pone la misma fecha de «Última actualización» en todo el temario revisado.

Víctor (20/11/2026): los 90 temas del 3.er ejercicio, sus fichas, la guía del
dictamen (guía, resumen y solución del examen de España) y «Cómo cantar un
tema» salen con la misma fecha, la del día del lanzamiento. Hasta entonces se
usa una provisional.

    python3 scripts/temario/fecha-comun.py 01/12/2026               # solo cambia las fuentes
    python3 scripts/temario/fecha-comun.py 01/12/2026 --reconstruir  # y reconstruye todo
    python3 scripts/temario/fecha-comun.py --comprobar               # dice qué fechas hay

Solo toca `\\tcefecha{…}` en los `.tex` (el `.lyx` lo regenera construir-tema.py
por la huella de estado.json). Una fecha desde el 1/10/2026 mantiene el modo
«exclusivo» (tcee-comun.sty, comun.py).

Autor: Víctor Gutiérrez Marcos
"""
import collections
import glob
import os
import re
import shutil
import subprocess
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
R = os.path.normpath(os.path.join(AQUI, '..', '..'))
FUENTES = os.path.join(R, 'oposicion', 'temario', 'fuentes')
CANTAR = os.path.join(R, 'oposicion', 'organizacion', 'como-cantar')
MIK = '/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64'
PATRON = re.compile(r'\\tcefecha\{(\d{2}/\d{2}/\d{4})\}')


def ficheros():
    fs = sorted(glob.glob(os.path.join(FUENTES, '3[AB][0-9][0-9]', '3[AB][0-9][0-9].tex')))
    fs += sorted(glob.glob(os.path.join(FUENTES, '3[AB][0-9][0-9]', 'repaso', '*-repaso.tex')))
    fs += [os.path.join(FUENTES, '1D01', '1D01.tex'),
           os.path.join(FUENTES, '1D01', 'repaso', '1D01-repaso.tex'),
           os.path.join(FUENTES, '1D01', 'examen-espana', 'solucion', 'solucion-espana.tex'),
           os.path.join(CANTAR, 'como-cantar-un-tema.tex')]
    return [f for f in fs if os.path.exists(f)]


def comprobar():
    c = collections.defaultdict(list)
    for f in ficheros():
        m = PATRON.search(open(f, encoding='utf-8').read())
        c[m.group(1) if m else 'sin fecha'].append(os.path.relpath(f, R))
    for fecha, fs in sorted(c.items()):
        print(f'{fecha}: {len(fs)} ficheros' + ('' if len(c) == 1 else f' (p. ej., {fs[0]})'))
    return len(c) == 1


def compilar_cantar():
    lat = subprocess.check_output(['wslpath', '-w', os.path.join(R, 'oposicion', 'temario', 'latex')], text=True).strip()
    env = dict(os.environ, TEXINPUTS=lat + '//;', WSLENV='TEXINPUTS')
    for _ in range(2):
        subprocess.run([f'{MIK}/pdflatex.exe', '-interaction=nonstopmode', '-halt-on-error',
                        'como-cantar-un-tema.tex'], cwd=CANTAR, env=env, check=True, stdout=subprocess.DEVNULL)
    # La app y la web enlazan oposicion/organizacion/como_cantar_un_tema.pdf
    shutil.copy2(os.path.join(CANTAR, 'como-cantar-un-tema.pdf'),
                 os.path.join(R, 'oposicion', 'organizacion', 'como_cantar_un_tema.pdf'))
    for ext in ('aux', 'log', 'out', 'toc'):
        p = os.path.join(CANTAR, f'como-cantar-un-tema.{ext}')
        if os.path.exists(p):
            os.remove(p)


def main():
    args = sys.argv[1:]
    if not args or args[0] == '--comprobar':
        sys.exit(0 if comprobar() else 1)
    fecha = args[0]
    if not re.fullmatch(r'\d{2}/\d{2}/\d{4}', fecha):
        sys.exit('La fecha va como DD/MM/AAAA')
    cambiados = 0
    for f in ficheros():
        s = open(f, encoding='utf-8').read()
        n = PATRON.sub(lambda m: f'\\tcefecha{{{fecha}}}', s)
        if n != s:
            open(f, 'w', encoding='utf-8').write(n)
            cambiados += 1
    print(f'{cambiados} ficheros con \\tcefecha{{{fecha}}}')
    comprobar()
    if '--reconstruir' in args:
        py = sys.executable
        subprocess.run([py, os.path.join(AQUI, 'reconstruir-todos.py'), '--revisados'], check=True)
        subprocess.run([py, os.path.join(AQUI, 'construir-tema.py'), '1D01'], check=True)
        subprocess.run([py, os.path.join(AQUI, 'construir-repaso.py'), '1D01'], check=True)
        subprocess.run(['bash', os.path.join(FUENTES, '1D01', 'examen-espana', 'solucion', 'compilar.sh'), 'texto'], check=True)
        compilar_cantar()
        print('Reconstruido: 90 temas y fichas, 1D01 (guía, resumen y solución) y «Cómo cantar un tema».')


if __name__ == '__main__':
    main()
