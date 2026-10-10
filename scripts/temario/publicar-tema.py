#!/usr/bin/env python3
"""
Enlaza un tema revisado en el índice de su ejercicio y regenera los datos de
la app y el buscador (último paso de /revisartema, en la rama
revision-temario; la web no cambia hasta que se fusione con main).

    python3 scripts/temario/publicar-tema.py 3A08

En oposicion/temario/<ejercicio>.html deja la línea del tema con:
  - el título enlazado a la página web del tema (HTML);
  - los botones PDF y DOCX para descargarlo;
  - un botón VÍDEO si el tema tiene vídeo en oposicion/temario/videos.json
    ({"3A08": "https://youtu.be/…"}).
Si el tema figuraba como no disponible, pasa a disponible. En el 4.º ejercicio
se quitan las etiquetas «Temario anterior» y «Parcial»: el tema revisado ya
está adaptado al temario nuevo.

En build-search-index.js el tema pasa a enlazar a su página web. Después
ejecuta build-app-data.js (temario.json: url sigue siendo el PDF, para la
app, y urlHtml la página web; urlVideo si hay vídeo) y build-search-index.js
con el deno de Quarto.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, RAIZ, TEMARIO, DENO, ejecutar  # noqa: E402


def linea_tema(tema, titulo_html, video):
    """El título lleva a la página web del tema; PDF y Word se descargan con los botones."""
    c = tema.carpeta
    a = tema.archivo
    partes = [f'<div class="tema-item"><a href="{c}/{a}.html">Tema {tema.codigo}: '
              f'<span class="tema-item-title">{titulo_html}</span></a>',
              f'<a class="tema-item-docx tema-item-pdf" href="{c}/{a}.pdf" target="_blank" '
              f'title="Descargar el tema en PDF">PDF</a>',
              f'<a class="tema-item-docx" href="{c}/{a}.docx" download title="Descargar el tema en Word">DOCX</a>']
    if video:
        partes.append(f'<a class="tema-item-docx tema-item-video" href="{video}" target="_blank" '
                      f'rel="noopener" title="Vídeo del cante del tema">VÍDEO</a>')
    return ''.join(partes) + '</div>'


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(2)
    tema = Tema(sys.argv[1])
    for ext in ('pdf', 'html', 'docx'):
        if not os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}')):
            print(f'Falta {tema.archivo}.{ext}: ejecuta antes construir-tema.py')
            sys.exit(1)
    videos_ruta = os.path.join(TEMARIO, 'videos.json')
    videos = json.load(open(videos_ruta, encoding='utf-8')) if os.path.exists(videos_ruta) else {}
    video = videos.get(tema.archivo)

    ruta = os.path.join(TEMARIO, f'{tema.carpeta}.html')
    html = open(ruta, encoding='utf-8').read()
    patron = re.compile(r'<div class="tema-item">(?:(?!</div>).)*?Tema ' + re.escape(tema.codigo)
                        + r':\s*(.*?)</div>', re.S)
    m = patron.search(html)
    if not m:
        print(f'No encuentro el tema {tema.codigo} en {os.path.basename(ruta)}')
        sys.exit(1)
    interior = m.group(1)
    titulo = re.search(r'<span class="tema-item-title">(.*?)</span>', interior, re.S)
    nueva = linea_tema(tema, titulo.group(1).strip() if titulo else tema.titulo(), video)
    html = html[:m.start()] + nueva + html[m.end():]
    open(ruta, 'w', encoding='utf-8').write(html)
    print(f'{os.path.relpath(ruta, RAIZ)}: tema {tema.codigo} con web, PDF, DOCX' + (' y VÍDEO' if video else ''))

    # El buscador también lleva a la página web del tema
    ruta_buscador = os.path.join(RAIZ, 'build-search-index.js')
    if os.path.exists(ruta_buscador):
        js = open(ruta_buscador, encoding='utf-8').read()
        nuevo = js.replace(f"file: '{tema.archivo}.pdf'", f"file: '{tema.archivo}.html'")
        if nuevo != js:
            open(ruta_buscador, 'w', encoding='utf-8').write(nuevo)
            print(f'build-search-index.js: el tema {tema.codigo} enlaza a su página web')

    for script in ('build-app-data.js', 'build-search-index.js'):
        if os.path.exists(os.path.join(RAIZ, script)):
            _, salida = ejecutar([DENO, 'run', '-A', '--unstable-detect-cjs', script], cwd=RAIZ, timeout=300)
            print(f'{script}: {salida.strip().splitlines()[-1] if salida.strip() else "hecho"}')


if __name__ == '__main__':
    main()
