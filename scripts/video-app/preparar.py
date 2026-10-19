#!/usr/bin/env python3
"""
Prepara los recursos del vídeo de la app (hyperframes) en scripts/video-app/assets/:
fuentes, GSAP, icono, capturas reducidas a WebP y la banda sonora.

    python3 scripts/video-app/preparar.py

Después, desde scripts/video-app/: `npx hyperframes render` (el vídeo sale en
renders/) y `python3 publicar.py` lo copia a app/promo/ con el póster.

Las capturas se regeneran antes, desde app/:
`flutter test tool/capturas_test.dart --update-goldens` (y capturas_dce_test.dart).

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import shutil
import ssl
import subprocess
import sys
import urllib.request

from PIL import Image

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(AQUI))
ASSETS = os.path.join(AQUI, 'assets')
CAPTURAS = os.path.join(RAIZ, 'app', 'promo', 'capturas')
FUENTES = os.path.join(RAIZ, 'app', 'assets', 'fonts')
GSAP = 'https://cdn.jsdelivr.net/npm/gsap@3.14.2/dist/gsap.min.js'

# Ancho al que se guarda cada captura: los móviles se ven a unos 420 px de
# ancho (con margen para los recortes ampliados); las apaisadas, a lo ancho.
ANCHO_MOVIL, ANCHO_APAISADA = 760, 1700


def sincronizar_guion():
    """Lleva a index.html los compases de guion.json: data-start y data-duration
    de cada escena, la tabla E del guion y la capa de progreso."""
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
    html = re.sub(r'const DURACION = [\d.]+;', f'const DURACION = {guion["duracion"]};', html)
    # El progreso va de «Al empezar» al cierre.
    desde = next(e['compas'] for e in escenas if e['id'] == 'elegir') * compas
    hasta = next(e['compas'] for e in escenas if e['id'] == 'cierre') * compas
    html = re.sub(r'(<div id="progreso" class="clip" )data-start="[\d.]+" data-duration="[\d.]+"',
                  rf'\g<1>data-start="{desde:.4f}" data-duration="{hasta - desde:.4f}"', html)
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(html)


def main():
    sincronizar_guion()
    os.makedirs(os.path.join(ASSETS, 'capturas'), exist_ok=True)
    for f in ('texgyrepagella-bold.otf', 'texgyrepagella-italic.otf', 'texgyrepagella-bolditalic.otf',
              'SourceSans3-Regular.ttf', 'SourceSans3-Medium.ttf', 'SourceSans3-Semibold.ttf'):
        shutil.copy(os.path.join(FUENTES, f), ASSETS)
    shutil.copy(os.path.join(RAIZ, 'app', 'assets', 'icon', 'icon.png'), os.path.join(ASSETS, 'icono.png'))

    gsap = os.path.join(ASSETS, 'gsap.min.js')
    if not os.path.exists(gsap):
        # Detrás de un proxy que intercepta TLS, SSL_CERT_FILE apunta a su raíz.
        contexto = ssl.create_default_context(cafile=os.environ.get('SSL_CERT_FILE'))
        with urllib.request.urlopen(GSAP, context=contexto) as r, open(gsap, 'wb') as f:
            f.write(r.read())

    n = 0
    for nombre in sorted(os.listdir(CAPTURAS)):
        if not nombre.endswith('.png'):
            continue
        img = Image.open(os.path.join(CAPTURAS, nombre)).convert('RGB')
        ancho = ANCHO_MOVIL if img.height > img.width else ANCHO_APAISADA
        img = img.resize((ancho, round(img.height * ancho / img.width)), Image.LANCZOS)
        img.save(os.path.join(ASSETS, 'capturas', nombre[:-4] + '.webp'), 'WEBP', quality=92, method=6)
        n += 1
    print(f'{n} capturas')

    subprocess.run([sys.executable, os.path.join(AQUI, 'musica.py'), os.path.join(ASSETS, 'musica.wav')], check=True)
    print('Recursos listos en', ASSETS)


if __name__ == '__main__':
    main()
