#!/usr/bin/env python3
"""
Publica el último render del vídeo «Prepara con Claude» (renders/): lo recodifica
para la web (H.264 + AAC) en ~/.local/share/oposicion-web/videos/claude-prepara.mp4
(no se guarda en el repositorio: se sube a YouTube con la clave `claude-prepara`,
skill /videos), y saca los pósteres que enlazan la página y la app:
oposicion/img/claude/video.webp y app/promo/ayuda/claude-prepara.webp.

    python3 scripts/video-claude/publicar.py [--render RUTA.mp4] [--web] [--subir]
Con --web deja además una copia ligera en el repositorio (oposicion/img/claude/claude-prepara.mp4,
1080p a ~1 Mbps como app/promo/oposicion-tcee.mp4) para servirlo desde la propia página mientras
no está en YouTube. --render toma ese fichero en vez del último de renders/ (el render se escribe
fuera de C: cuando no hay sitio: npx hyperframes render -o ~/.local/share/oposicion-web/videos/x.mp4).

Con --subir, lo lleva a YouTube con scripts/youtube.py (hace falta el permiso de
YouTube en este ordenador) y recuerda hacer commit de videos.json.

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
SALIDA = os.path.expanduser('~/.local/share/oposicion-web/videos')
POSTER = 3.2  # segundo del póster: la portada ya entera
CLAVE = 'claude-prepara'
TITULO = 'Prepara la oposición a TCEE y DCE con Claude'
DESCRIPCION = ('Cómo usar el conector «EconomIA» (Claude, ChatGPT, Le Chat y Gemini; con Claude, completo) de victorgutierrezmarcos.es: Claude conoce tu temario y tus datos de la app, corrige cantes y dictámenes, '
               'resuelve dudas viendo el temario entero, organiza el cronograma y lo lleva a la app; también para DCE. '
               'No sustituye a un preparador para la oposición: lo complementa.\n\n'
               'https://victorgutierrezmarcos.es/oposicion/prepara-con-ia.html')


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'))
    p.add_argument('--subir', action='store_true', help='subirlo a YouTube con la clave claude-prepara')
    p.add_argument('--render', help='render de origen (por defecto, el último de renders/)')
    p.add_argument('--web', action='store_true', help='copia ligera en oposicion/img/claude/claude-prepara.mp4 para la página')
    args = p.parse_args()
    if args.render:
        origen = args.render
    else:
        renders = sorted(glob.glob(os.path.join(AQUI, 'renders', '*.mp4')), key=os.path.getmtime)
        if not renders:
            sys.exit('No hay ningún vídeo en renders/: ejecuta antes «npx hyperframes render».')
        origen = renders[-1]
    os.makedirs(SALIDA, exist_ok=True)
    salida = os.path.join(SALIDA, CLAVE + '.mp4')
    subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-i', origen,
                    '-c:v', 'libx264', '-preset', 'slow', '-crf', '20', '-pix_fmt', 'yuv420p',
                    '-c:a', 'aac', '-b:a', '160k', '-movflags', '+faststart', salida], check=True)
    poster = os.path.join(SALIDA, CLAVE + '.jpg')
    subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-ss', str(POSTER), '-i', salida, '-frames:v', '1', '-q:v', '3', poster], check=True)
    img = Image.open(poster).convert('RGB')
    for destino in (os.path.join(RAIZ, 'oposicion', 'img', 'claude', 'video.webp'),
                    os.path.join(RAIZ, 'app', 'promo', 'ayuda', CLAVE + '.webp')):
        os.makedirs(os.path.dirname(destino), exist_ok=True)
        img.resize((1280, 720), Image.LANCZOS).save(destino, 'WEBP', quality=82, method=6)
        print('Póster', os.path.relpath(destino, RAIZ))
    print('Vídeo', salida)
    if args.web:
        web = os.path.join(RAIZ, 'oposicion', 'img', 'claude', CLAVE + '.mp4')
        subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-i', salida,
                        '-c:v', 'libx264', '-preset', 'slow', '-crf', '25', '-maxrate', '1400k', '-bufsize', '2800k',
                        '-pix_fmt', 'yuv420p', '-c:a', 'aac', '-b:a', '96k', '-movflags', '+faststart', web], check=True)
        print('Copia para la página', os.path.relpath(web, RAIZ), round(os.path.getsize(web) / 1e6, 1), 'MB')
    if args.subir:
        subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'youtube.py'), 'subir', CLAVE, salida,
                        '--titulo', TITULO, '--descripcion', DESCRIPCION], check=True)
        print('Haz commit de videos.json y quita «hidden» a los reproductores de oposicion/prepara-con-ia.html y app/index.html.')


if __name__ == '__main__':
    main()
