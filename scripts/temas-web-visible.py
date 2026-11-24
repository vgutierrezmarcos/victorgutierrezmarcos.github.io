#!/usr/bin/env python3
"""Enseña u oculta en la web los temas revisados (materiales exclusivos), con sesión de Google.

Víctor (20/11/2026): de momento los temas revisados solo se leen en la app con
cuenta; la web los lista y remite a la app. Víctor (24/11/2026): el día del
lanzamiento («lanzarlo todo al público»), también en la web:

  - Al abrir un tema que tiene versión revisada (lista del temario, buscador,
    tarjetas, tema-no-disponible.html), con sesión se abre directamente la
    versión revisada en oposicion/temario/tema-revisado.html (página web con
    sus botones de PDF, Word, ficha de repaso y versión anterior).
  - Sin sesión, un aviso «Inicia sesión para ver el tema nuevo» con el botón de
    Google y, si el tema tenía versión antigua, «Seguir con el tema antiguo».
    Tras entrar desde el aviso, se abre el tema revisado.
  - Igual con la guía del dictamen (1D01) y su resumen. El examen de ejemplo de
    España y su solución no se publican nunca (scripts/rama-publicada.py).

    python3 scripts/temas-web-visible.py --mostrar    # el día del lanzamiento (paso de LANZAMIENTO.md)
    python3 scripts/temas-web-visible.py --ocultar    # vuelve a remitir a la app
    python3 scripts/temas-web-visible.py              # dice cómo está

Cambia la constante TEMAS_EN_WEB de exclusivos.js (la lógica ya está hecha
allí: lee el mismo revisados.json de temario-publicado que la app). Después,
commit y push de main.

Autor: Víctor Gutiérrez Marcos
"""
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
JS = os.path.join(RAIZ, 'exclusivos.js')
PATRON = re.compile(r'var TEMAS_EN_WEB = (true|false);')


def main():
    s = open(JS, encoding='utf-8').read()
    m = PATRON.search(s)
    if not m:
        sys.exit('No encuentro «var TEMAS_EN_WEB» en exclusivos.js')
    if '--mostrar' in sys.argv or '--ocultar' in sys.argv:
        valor = 'true' if '--mostrar' in sys.argv else 'false'
        open(JS, 'w', encoding='utf-8').write(PATRON.sub(f'var TEMAS_EN_WEB = {valor};', s, count=1))
        print(f'Temas revisados en la web: {"visibles con sesión" if valor == "true" else "solo en la app"}. Falta commit y push.')
    else:
        print('Temas revisados en la web:', 'visibles con sesión' if m.group(1) == 'true' else 'solo en la app (oculto)')


if __name__ == '__main__':
    main()
