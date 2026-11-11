#!/usr/bin/env python3
"""
Lleva a app/promo/ el último vídeo renderizado con hyperframes (renders/):
oposicion-tcee.mp4 (H.264 + AAC, listo para la web), el póster (poster.jpg y
poster.webp, un fotograma de la portada) y la versión ligera de cada captura
(720 px, WebP) que usa app/index.html.

    python3 scripts/video-app/publicar.py [--ffmpeg RUTA]

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import glob
import os
import shutil
import subprocess
import sys

from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(AQUI))
PROMO = os.path.join(RAIZ, 'app', 'promo')
CAPTURAS = os.path.join(PROMO, 'capturas')
POSTER = 3.4  # segundo del póster: la portada ya entera


def a_youtube(claves):
    """Lleva los vídeos a YouTube (scripts/publicar-videos-app.py) si hay permiso en este ordenador."""
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    raiz = os.path.dirname(raiz)
    if not os.path.exists(os.path.expanduser('~/.config/oposicion-red/youtube-token.json')):
        print('Sin permiso de YouTube en este ordenador: los vídeos quedan solo en la web.')
        return
    subprocess.run([sys.executable, os.path.join(raiz, 'scripts', 'publicar-videos-app.py'), *claves])
    print('Haz commit de videos.json para que la web y la app enlacen los vídeos nuevos.')

def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'), help='ruta de ffmpeg')
    args = p.parse_args()
    if not args.ffmpeg:
        sys.exit('No se encuentra ffmpeg: indícalo con --ffmpeg o con la variable FFMPEG.')
    renders = sorted(glob.glob(os.path.join(AQUI, 'renders', '*.mp4')), key=os.path.getmtime)
    if not renders:
        sys.exit('No hay ningún vídeo en renders/: ejecuta antes «npx hyperframes render».')
    origen = renders[-1]

    salida = os.path.join(PROMO, 'oposicion-tcee.mp4')
    subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-i', origen,
                    '-c:v', 'libx264', '-preset', 'slow', '-crf', '20', '-pix_fmt', 'yuv420p',
                    '-c:a', 'aac', '-b:a', '160k', '-movflags', '+faststart', salida], check=True)

    poster = os.path.join(PROMO, 'poster.jpg')
    subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-ss', str(POSTER), '-i', salida,
                    '-frames:v', '1', '-q:v', '3', poster], check=True)
    Image.open(poster).convert('RGB').save(os.path.join(PROMO, 'poster.webp'), 'WEBP', quality=82, method=6)

    for fichero in sorted(os.listdir(CAPTURAS)):
        if fichero.endswith('.png'):
            img = Image.open(os.path.join(CAPTURAS, fichero)).convert('RGB')
            img = img.resize((720, round(img.height * 720 / img.width)), Image.LANCZOS)
            img.save(os.path.join(PROMO, fichero[:-4] + '.webp'), quality=82, method=6)
    print(f'{salida}: {os.path.getsize(salida) / 1e6:.1f} MB (desde {os.path.basename(origen)})')
    a_youtube(['promo-app'])


if __name__ == '__main__':
    main()
