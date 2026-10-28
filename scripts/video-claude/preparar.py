#!/usr/bin/env python3
"""
Prepara los recursos del vídeo «Prepara con Claude» (HyperFrames) en
scripts/video-claude/assets/: fuentes (Pagella, Latin Modern para DCE y Source
Sans 3), GSAP, el logo de Claude (y una versión clara para los fondos
oscuros), el icono de la app, las capturas de la app reducidas a WebP, las
páginas del informe en PDF, las tomas grabadas en claude.ai (MP4) y la banda
sonora del promocional en bucle con fundido final.

    python3 scripts/video-claude/preparar.py [--tomas CARPETA]

Las tomas salen de la carpeta de grabación (por defecto
C:\\Users\\vgutierrez\\AppData\\Local\\Temp\\claude-video\\tomas, montadas con
montar-toma.py). Después, desde scripts/video-claude/: `npx hyperframes render`
y `python3 publicar.py`.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys

from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(AQUI))
ASSETS = os.path.join(AQUI, 'assets')
VIDEO_APP = os.path.join(RAIZ, 'scripts', 'video-app', 'assets')
CAPTURAS = os.path.join(RAIZ, 'app', 'promo', 'capturas')
FUENTES_APP = os.path.join(RAIZ, 'app', 'assets', 'fonts')
FUENTES_SKILL = os.path.join(RAIZ, 'claude', 'prepara-con-claude', 'assets', 'fuentes')
TOMAS_DEF = '/mnt/c/Users/vgutierrez/AppData/Local/Temp/claude-video/tomas'
TOMAS = ['G2', 'G4a', 'G4b', 'G5a', 'G5b', 'G6a', 'G6b', 'G7a', 'G7b', 'G8', 'G9ma', 'G9mb']
# Capturas de la app que usa la composición
PANTALLAS = ['cantes-cantar', 'cantes-diario', 'cronograma-traer', 'cronograma-semanas', 'hoy', 'mas',
             'dce-cantar', 'dce-hoy', 'dce-temario', 'tema-revisado', 'test', 'organizacion', 'esquema', 'temario']
ANCHO_MOVIL = 760


def sincronizar_guion():
    """Lleva a index.html los compases de guion.json (data-start y data-duration de
    cada escena, las tablas E y BLOQUE y la duración)."""
    with open(os.path.join(AQUI, 'guion.json'), encoding='utf-8') as f:
        guion = json.load(f)
    compas = 4 * 60 / guion['bpm']
    escenas = sorted(guion['escenas'], key=lambda e: e['compas'])
    ruta = os.path.join(AQUI, 'index.html')
    with open(ruta, encoding='utf-8') as f:
        html = f.read()
    for i, e in enumerate(escenas):
        inicio = e['compas'] * compas
        fin = escenas[i + 1]['compas'] * compas if i + 1 < len(escenas) else guion['duracion']
        html, n = re.subn(rf'(<section id="{e["id"]}" class="[^"]*" )data-start="[\d.]+" data-duration="[\d.]+"',
                          rf'\g<1>data-start="{inicio:.4f}" data-duration="{fin - inicio:.4f}"', html)
        if n != 1:
            sys.exit(f'No encuentro la escena «{e["id"]}» en index.html')
    tabla = ', '.join(f'{e["id"]}: {e["compas"]}' for e in escenas)
    html = re.sub(r'const E = \{[^}]*\}; // guion', f'const E = {{ {tabla} }}; // guion', html)
    tabla = ', '.join(f'{e["id"]}: "{e["bloque"]}"' for e in escenas)
    html = re.sub(r'const BLOQUE = \{[^}]*\}; // guion', f'const BLOQUE = {{ {tabla} }}; // guion', html)
    html = re.sub(r'const DURACION = [\d.]+;', f'const DURACION = {guion["duracion"]};', html)
    html = re.sub(r'(data-composition-id="main" data-start="0" data-width="1920" data-height="1080" )data-duration="[\d.]+"',
                  rf'\g<1>data-duration="{guion["duracion"]}"', html)
    html = re.sub(r'(<audio id="musica" src="assets/musica.wav" data-start="0" )data-duration="[\d.]+"',
                  rf'\g<1>data-duration="{guion["duracion"]}"', html)
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(html)
    return guion['duracion']


def musica(duracion):
    """La banda sonora del promocional, en bucle hasta la duración del vídeo, con fundido final."""
    origen = os.path.join(VIDEO_APP, 'musica.wav')
    if not os.path.exists(origen):
        subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'video-app', 'musica.py'), origen], check=True)
    salida = os.path.join(ASSETS, 'musica.wav')
    subprocess.run(['ffmpeg', '-y', '-loglevel', 'error', '-stream_loop', '-1', '-i', origen, '-t', str(duracion),
                    '-af', f'afade=t=in:st=0:d=1.5,afade=t=out:st={duracion - 4}:d=4', salida], check=True)


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    p.add_argument('--tomas', default=TOMAS_DEF, help='carpeta con las tomas montadas (G2.mp4, G4a.mp4…)')
    args = p.parse_args()
    duracion = sincronizar_guion()
    for carpeta in ('capturas', 'tomas', 'pdf', 'logos'):
        os.makedirs(os.path.join(ASSETS, carpeta), exist_ok=True)

    for f in ('texgyrepagella-regular.otf', 'texgyrepagella-bold.otf', 'texgyrepagella-italic.otf', 'texgyrepagella-bolditalic.otf',
              'lmroman10-regular.otf', 'lmroman10-bold.otf', 'lmroman10-italic.otf', 'lmroman10-bolditalic.otf'):
        shutil.copy(os.path.join(FUENTES_SKILL, f), ASSETS)
    for f in ('SourceSans3-Regular.ttf', 'SourceSans3-Medium.ttf', 'SourceSans3-Semibold.ttf'):
        shutil.copy(os.path.join(FUENTES_APP, f), ASSETS)
    shutil.copy(os.path.join(RAIZ, 'app', 'assets', 'icon', 'icon.png'), os.path.join(ASSETS, 'icono.png'))
    gsap = os.path.join(VIDEO_APP, 'gsap.min.js')
    if not os.path.exists(gsap):
        subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'video-app', 'preparar.py')], check=True)
    shutil.copy(gsap, ASSETS)

    # Logo de Claude (wordmark oscuro) y versión clara para los fondos berenjena.
    with open(os.path.join(RAIZ, 'oposicion', 'img', 'claude', 'claude-logo.svg'), encoding='utf-8') as f:
        svg = f.read()
    with open(os.path.join(ASSETS, 'logos', 'claude.svg'), 'w', encoding='utf-8') as f:
        f.write(svg)
    with open(os.path.join(ASSETS, 'logos', 'claude-claro.svg'), 'w', encoding='utf-8') as f:
        f.write(svg.replace('#0f0f0d', '#f6f4ef'))

    n = 0
    for nombre in PANTALLAS:
        origen = os.path.join(CAPTURAS, nombre + '.png')
        if not os.path.exists(origen):
            print('Falta la captura', nombre)
            continue
        img = Image.open(origen).convert('RGB')
        img = img.resize((ANCHO_MOVIL, round(img.height * ANCHO_MOVIL / img.width)), Image.LANCZOS)
        img.save(os.path.join(ASSETS, 'capturas', nombre + '.webp'), 'WEBP', quality=92, method=6)
        n += 1
    print(f'{n} capturas de la app')

    n = 0
    for t in TOMAS:
        origen = os.path.join(args.tomas, t + '.mp4')
        if os.path.exists(origen):
            shutil.copy(origen, os.path.join(ASSETS, 'tomas', t + '.mp4'))
            n += 1
        else:
            print('Falta la toma', t)
    print(f'{n} tomas')

    musica(duracion)
    print('Recursos listos en', ASSETS)


if __name__ == '__main__':
    main()
