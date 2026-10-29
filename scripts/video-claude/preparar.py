#!/usr/bin/env python3
"""
Prepara los recursos del vídeo «Prepara con Claude» (HyperFrames) en
scripts/video-claude/assets/: fuentes (Pagella, Latin Modern para DCE y Source
Sans 3), GSAP, el asterisco del logo de Claude (solo el símbolo: el nombre va
en la letra del vídeo), el icono de la app, las capturas de la app y de
claude.ai en el móvil reducidas a WebP, las páginas del informe en PDF, las
tomas grabadas en claude.ai (MP4) y la banda sonora compuesta para este vídeo
(musica.py: misma música que el promocional, de una pieza, sin bucle).

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
TOMAS = ['G2c', 'G4a', 'G4b', 'G5a', 'G5b', 'G6a', 'G6b', 'G7b', 'G8', 'G9na', 'G9nb']
# Capturas de claude.ai en el móvil (cdp.mjs con CDP_MOVIL=1, en la carpeta de grabación): chat con el cante adjunto y respuesta
MOVIL = {'claude-movil-1': 'movil-2.png', 'claude-movil-2': 'movil-4.png'}
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
    html, n = re.subn(r'(id="capa-(?:capitulos|barrido)" class="clip" data-start="0" )data-duration="[\d.]+"',
                      rf'\g<1>data-duration="{guion["duracion"]:.4f}"', html)
    if n != 2:
        sys.exit('No encuentro las capas de rótulos y barrido en index.html')
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(html)
    return guion['duracion']


def musica():
    """La banda sonora compuesta para este vídeo (musica.py, con el guion y la duración actuales)."""
    subprocess.run([sys.executable, os.path.join(AQUI, 'musica.py'), os.path.join(ASSETS, 'musica.wav')], check=True)


def asterisco():
    """Solo el símbolo del logo de Claude (el trazado naranja), recortado a su caja: el nombre nunca va con la letra de la marca."""
    with open(os.path.join(RAIZ, 'oposicion', 'img', 'claude', 'claude-logo.svg'), encoding='utf-8') as f:
        svg = f.read()
    d = re.search(r'<path[^>]*class="cls-2"[^>]*\sd="([^"]+)"', svg, re.S).group(1)
    tx, ty = re.search(r'transform="translate\(([-\d.]+),([-\d.]+)\)"', svg).groups()
    # Caja del trazado (calculada una vez sobre el SVG original, con medio punto de margen)
    salida = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="-0.5 -0.5 149.09 149.18"><g transform="translate({tx},{ty})"><path fill="#d97757" d="{d}"/></g></svg>'
    with open(os.path.join(ASSETS, 'logos', 'asterisco.svg'), 'w', encoding='utf-8') as f:
        f.write(salida)


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    p.add_argument('--tomas', default=TOMAS_DEF, help='carpeta con las tomas montadas (G2.mp4, G4a.mp4…)')
    args = p.parse_args()
    sincronizar_guion()
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

    asterisco()
    for viejo in ('claude.svg', 'claude-claro.svg'):
        if os.path.exists(os.path.join(ASSETS, 'logos', viejo)):
            os.remove(os.path.join(ASSETS, 'logos', viejo))

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
    for nombre, fichero in MOVIL.items():
        origen = os.path.join(os.path.dirname(args.tomas), fichero)
        if not os.path.exists(origen):
            print('Falta la captura del móvil', fichero)
            continue
        img = Image.open(origen).convert('RGB')
        img = img.resize((ANCHO_MOVIL, round(img.height * ANCHO_MOVIL / img.width)), Image.LANCZOS)
        img.save(os.path.join(ASSETS, 'capturas', nombre + '.webp'), 'WEBP', quality=92, method=6)

    n = 0
    for t in TOMAS:
        origen = os.path.join(args.tomas, t + '.mp4')
        if os.path.exists(origen):
            shutil.copy(origen, os.path.join(ASSETS, 'tomas', t + '.mp4'))
            n += 1
        else:
            print('Falta la toma', t)
    print(f'{n} tomas')

    musica()
    print('Recursos listos en', ASSETS)


if __name__ == '__main__':
    main()
