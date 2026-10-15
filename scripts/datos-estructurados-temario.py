#!/usr/bin/env python3
"""Datos estructurados (JSON-LD) de las páginas de cada ejercicio del temario.

Añade a cada página de /oposicion/temario/<ejercicio>.html un bloque JSON-LD con
la lista de temas en PDF enlazados (ItemList de LearningResource: título, PDF,
autor, licencia), para que los buscadores entiendan que son materiales de
estudio. No cambia nada visible. Los títulos son los mismos que pone
metadatos-pdf.py dentro de cada PDF.

Lo pasa solo GitHub Actions (.github/workflows/metadatos-pdf.yml). A mano:

    python3 scripts/datos-estructurados-temario.py
"""
import importlib.util
import json
import os
import re

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WEB = 'https://www.victorgutierrezmarcos.es'
EJERCICIOS = ['primer', 'segundo', 'tercer', 'cuarto', 'quinto']
INICIO = '<!-- datos-estructurados-temas: lo genera scripts/datos-estructurados-temario.py -->'
FIN = '<!-- /datos-estructurados-temas -->'

_spec = importlib.util.spec_from_file_location('metadatos', os.path.join(RAIZ, 'scripts', 'metadatos-pdf.py'))
metadatos = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(metadatos)


def bloque(pagina, temas):
    url_pagina = f'{WEB}/{pagina}'
    elementos = []
    for posicion, (ruta, (titulo, asunto, claves)) in enumerate(temas, 1):
        elementos.append({
            '@type': 'ListItem', 'position': posicion,
            'item': {
                '@type': 'LearningResource',
                'name': titulo,
                'description': asunto,
                'url': f'{WEB}/{ruta}',
                'encodingFormat': 'application/pdf',
                'inLanguage': 'es',
                'learningResourceType': 'apuntes',
                'educationalUse': 'preparación de oposiciones',
                'keywords': claves,
                'isAccessibleForFree': True,
                'license': 'https://creativecommons.org/licenses/by-nc-nd/4.0/',
                'author': {'@type': 'Person', '@id': f'{WEB}/#victor', 'name': 'Víctor Gutiérrez Marcos'},
            },
        })
    datos = {'@context': 'https://schema.org', '@type': 'ItemList', '@id': f'{url_pagina}#temas',
             'url': url_pagina, 'numberOfItems': len(elementos), 'itemListElement': elementos}
    cuerpo = json.dumps(datos, ensure_ascii=False, indent=4).replace('\n', '\n    ')
    return f'{INICIO}\n    <script type="application/ld+json">\n    {cuerpo}\n    </script>\n    {FIN}'


def main():
    os.chdir(RAIZ)
    textos = metadatos.enlaces()
    for ejercicio in EJERCICIOS:
        pagina = f'oposicion/temario/{ejercicio}-ejercicio.html'
        fuente = open(pagina, encoding='utf-8').read()
        # Los PDF de esa página, en el orden en que aparecen
        orden = []
        for href in re.findall(r'href="([^"#?]+\.pdf)"', fuente):
            ruta = os.path.normpath(os.path.join(os.path.dirname(pagina), href))
            if ruta in textos and ruta not in orden:
                orden.append(ruta)
        temas = [(r, metadatos.metadatos(r, textos[r])) for r in orden]
        # Sin PDF enlazados (segundo ejercicio), sin bloque
        nuevo = bloque(pagina, temas) if temas else ''
        if INICIO in fuente:
            fuente2 = re.sub(re.escape(INICIO) + r'.*?' + re.escape(FIN), lambda _: nuevo, fuente, flags=re.S)
        elif nuevo:
            fuente2 = fuente.replace('</head>', f'    {nuevo}\n</head>', 1)
        else:
            fuente2 = fuente
        if fuente2 != fuente:
            open(pagina, 'w', encoding='utf-8').write(fuente2)
            print(f'✓ {pagina}: {len(temas)} temas')
        else:
            print(f'= {pagina}: sin cambios ({len(temas)} temas)')


if __name__ == '__main__':
    main()
