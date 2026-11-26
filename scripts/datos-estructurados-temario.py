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


def revisados_web():
    """ruta del PDF → entrada de revisados-web.json (temas revisados en la web)."""
    ruta = os.path.join(RAIZ, metadatos.REVISADOS_WEB)
    if not os.path.exists(ruta):
        return {}
    salida = {}
    for t in json.load(open(ruta, encoding='utf-8'))['temas']:
        salida[t['pdf']] = t
    return salida


def wikipedia():
    """archivo del tema (3A14) → conceptos con su artículo de Wikipedia (conceptos-wikipedia.py)."""
    ruta = os.path.join(RAIZ, 'oposicion', 'temario', 'conceptos-wikipedia.json')
    if not os.path.exists(ruta):
        return {}, 0
    d = json.load(open(ruta, encoding='utf-8'))
    return d.get('temas', {}), d.get('maximo', 4)


def bloque(pagina, temas, revisados=None):
    revisados = revisados or {}
    wiki, maximo = wikipedia()
    url_pagina = f'{WEB}/{pagina}'
    elementos = []
    for posicion, (ruta, (titulo, asunto, claves)) in enumerate(temas, 1):
        rev = revisados.get(ruta)
        item = {
                '@type': 'LearningResource',
                'name': titulo,
                'description': asunto,
                'url': f'{WEB}/{rev["pagina"] if rev else ruta}',
                'encodingFormat': 'text/html' if rev else 'application/pdf',
                'inLanguage': 'es',
                'learningResourceType': 'apuntes',
                'educationalUse': 'preparación de oposiciones',
                'keywords': claves,
                'isAccessibleForFree': True,
                'license': 'https://creativecommons.org/licenses/by-nc-nd/4.0/',
                'author': {'@type': 'Person', '@id': f'{WEB}/#victor', 'name': 'Víctor Gutiérrez Marcos'},
            }
        if rev:
            # Tema revisado: material exclusivo (condiciones propias, no CC), con lo que
            # enseña (los apartados del índice), su fecha y su ficha de repaso.
            # (Sin repetir en la descripción los apartados de «teaches» y con pocas palabras
            # clave: la lista entera va dentro del PDF; aquí pesaría en todas las visitas.)
            item['description'] = asunto.split(' Apartados:')[0]
            item['keywords'] = ', '.join(claves.split(', ')[:14])
            item['license'] = metadatos.CONDICIONES
            item['educationalLevel'] = 'universitario'
            if rev.get('aprobado'):
                item['dateModified'] = rev['aprobado']
            if rev.get('apartados'):
                item['teaches'] = rev['apartados']
            # De qué trata, con el artículo de Wikipedia de cada concepto: Google y las IA lo asocian
            # sin adivinar (nada visible; conceptos-wikipedia.py).
            conceptos = wiki.get(rev.get('archivo', ''), [])[:maximo]
            if conceptos:
                item['about'] = [{'@type': 'Thing', 'name': c['nombre'],
                                  'sameAs': [c['wikipedia'], 'https://www.wikidata.org/wiki/' + c['wikidata']]} for c in conceptos]
            # Se lee en su página con cuenta de Google (el PDF no es público desde el 26/11/2026).
            item['isAccessibleForFree'] = True
            item['conditionsOfAccess'] = 'Con cuenta de Google, para uso personal'
        elementos.append({'@type': 'ListItem', 'position': posicion, 'item': item})
    datos = {'@context': 'https://schema.org', '@type': 'ItemList', '@id': f'{url_pagina}#temas',
             'url': url_pagina, 'numberOfItems': len(elementos), 'itemListElement': elementos}
    # Compacto, una línea por tema: con sangría pesaba el doble en cada visita
    cuerpo = json.dumps(datos, ensure_ascii=False, separators=(',', ':'))
    cuerpo = cuerpo.replace(',{"@type":"ListItem"', ',\n    {"@type":"ListItem"')
    return f'{INICIO}\n    <script type="application/ld+json">\n    {cuerpo}\n    </script>\n    {FIN}'


def main():
    os.chdir(RAIZ)
    titulos = metadatos.titulados(todos=True)
    revisados = revisados_web()
    for ejercicio in EJERCICIOS:
        pagina = f'oposicion/temario/{ejercicio}-ejercicio.html'
        fuente = open(pagina, encoding='utf-8').read()
        # Los PDF de esa página, en el orden en que aparecen
        orden = []
        for href in re.findall(r'href="([^"#?]+\.pdf)"', fuente):
            ruta = os.path.normpath(os.path.join(os.path.dirname(pagina), href))
            if ruta in titulos and ruta not in orden:
                orden.append(ruta)
        # Los temas revisados de esa página que aún no se enlazan (no tenían versión antigua)
        carpeta = f'oposicion/temario/{ejercicio}-ejercicio/'
        for ruta in sorted(revisados):
            if ruta.startswith(carpeta) and ruta not in orden and ruta in titulos and '/' not in ruta[len(carpeta):]:
                orden.append(ruta)
        orden.sort(key=lambda r: (os.path.basename(r)[:4] if re.match(r'^\d[AB]\d\d', os.path.basename(r)) else 'zz') if ejercicio == 'tercer' else 0)
        temas = [(r, titulos[r]) for r in orden]
        # Sin PDF enlazados (segundo ejercicio), sin bloque
        nuevo = bloque(pagina, temas, revisados) if temas else ''
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
