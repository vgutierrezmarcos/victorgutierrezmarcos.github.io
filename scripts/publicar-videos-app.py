#!/usr/bin/env python3
"""Lleva a YouTube los vídeos de la página de la app (/app/): el promocional y
los de ayuda. Cada <video data-video="clave"> de app/index.html se publica con
scripts/youtube.py, con el título y el texto de su pie: solo se sube lo que es
nuevo o ha cambiado (sha256), y lo sustituido queda privado hasta «purgar».

    python3 scripts/publicar-videos-app.py            # todos
    python3 scripts/publicar-videos-app.py ayuda-clase promo-app

Lo llaman al final scripts/montar-videos-ayuda.py y scripts/video-app/publicar.py.
Después: commit de videos.json.
"""
import html
import re
import subprocess
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
PAGINA = RAIZ / 'app' / 'index.html'
ENLACE = 'https://www.victorgutierrezmarcos.es/app/'
PIE = (f'\n\nApp gratuita para preparar las oposiciones a Técnico Comercial y Economista del Estado (TCEE) '
       f'y a Diplomado Comercial del Estado (DCE), de Víctor Gutiérrez Marcos y Manuel Cabado García: {ENLACE}')


def videos():
    t = PAGINA.read_text(encoding='utf-8')
    for m in re.finditer(r'<video[^>]*data-video="([^"]+)"[^>]*>\s*<source src="([^"?]+)', t):
        clave, src = m.groups()
        resto = t[m.end():m.end() + 1500]
        pie = re.search(r'<figcaption><strong>(.*?)</strong><span>(.*?)</span>', resto)
        if pie:
            titulo, texto = (html.unescape(re.sub('<[^>]+>', '', x)) for x in pie.groups())
            if clave.startswith('ayuda-instalar-'):
                titulo = f'Instalar la app {titulo[0].lower()}{titulo[1:]}'
        else:  # el promocional: su <h2> está antes del <video>
            titulo, texto = 'La app, de un vistazo', 'Presentación en minuto y medio de la app.'
        yield clave, PAGINA.parent / src, f'{titulo} · Oposición TCEE · DCE', texto + PIE


def main():
    elegidos = set(sys.argv[1:])
    fallos = 0
    for clave, archivo, titulo, descripcion in videos():
        if elegidos and clave not in elegidos:
            continue
        r = subprocess.run([sys.executable, str(RAIZ / 'scripts' / 'youtube.py'), 'publicar', clave, str(archivo),
                            '--titulo', titulo, '--descripcion', descripcion])
        fallos += r.returncode != 0
    sys.exit(1 if fallos else 0)


if __name__ == '__main__':
    main()
