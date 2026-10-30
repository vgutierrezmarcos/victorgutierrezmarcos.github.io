#!/usr/bin/env python3
"""Páginas puente de las direcciones antiguas (antes de /oposicion/).

Cada una lleva a la dirección actual con un canonical, un refresh a 0 y
location.replace (que conserva ?… y #…). Copian el título y la descripción de
su destino para que los buscadores no vean muchas páginas con el mismo título
(aviso de Bing Webmaster Tools). Están fuera del sitemap (generate-sitemap.js).

    python3 scripts/paginas-puente.py
"""
import html
import os
import re

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WEB = 'https://www.victorgutierrezmarcos.es'

# página puente -> destino (ruta desde la raíz)
PUENTES = {
    'temario.html': 'oposicion/temario.html',
    'temario/index.html': 'oposicion/temario.html',
    'oposicion/temario/index.html': 'oposicion/temario.html',
    'enlaces.html': 'oposicion/enlaces.html',
    'organizacion.html': 'oposicion/organizacion.html',
    # La guía «Qué es TCEE» pasó a llamarse «¿Por qué TCEE?» el 18 oct. 2026.
    'oposicion/que-es-tcee.html': 'oposicion/por-que-tcee.html',
    # «Prepara con Claude» pasó a «EconomIA» (Claude, ChatGPT, Le Chat y Gemini) el 30 oct. 2026.
    'oposicion/prepara-con-claude.html': 'oposicion/prepara-con-ia.html',
    **{f'temario/{e}-ejercicio.html': f'oposicion/temario/{e}-ejercicio.html'
       for e in ['primer', 'segundo', 'tercer', 'cuarto', 'quinto']},
    'temario/primer-ejercicio/test.html': 'oposicion/temario/primer-ejercicio/test.html',
    'temario/primer-ejercicio/test/simulador.html': 'oposicion/temario/primer-ejercicio/test/simulador.html',
}

PLANTILLA = '''<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Dirección antigua: lleva a la actual. La genera scripts/paginas-puente.py -->
    <title>{titulo}</title>
    <meta name="description" content="{descripcion}">
    <link rel="canonical" href="{web}/{destino}">
    <meta http-equiv="refresh" content="0; url=/{destino}">
    <script>location.replace('/{destino}' + location.search + location.hash);</script>
</head>
<body>
    <p>Esta página se ha movido a <a href="/{destino}">{web}/{destino}</a>.</p>
</body>
</html>
'''


def dato(fuente, patron):
    m = re.search(patron, fuente, re.S | re.I)
    return html.unescape(re.sub(r'\s+', ' ', m.group(1)).strip()) if m else ''


def main():
    os.chdir(RAIZ)
    for puente, destino in PUENTES.items():
        fuente = open(destino, encoding='utf-8').read()
        titulo = dato(fuente, r'<title>(.*?)</title>')
        descripcion = dato(fuente, r'<meta\s+name="description"\s+content="(.*?)"')
        nuevo = PLANTILLA.format(titulo=html.escape(titulo, quote=False), descripcion=html.escape(descripcion),
                                 web=WEB, destino=destino)
        viejo = open(puente, encoding='utf-8').read() if os.path.exists(puente) else ''
        if nuevo != viejo:
            os.makedirs(os.path.dirname(puente) or '.', exist_ok=True)
            open(puente, 'w', encoding='utf-8').write(nuevo)
            print(f'✓ {puente} -> {destino}')


if __name__ == '__main__':
    main()
