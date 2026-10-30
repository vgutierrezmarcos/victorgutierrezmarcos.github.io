#!/usr/bin/env python3
"""
Reúne en un solo fichero todas las fuentes que hay para cada tema de TCEE y DCE,
para que el conector «EconomIA» pueda contestar «¿qué fuente me
recomiendas para el 3.B.26?» o «¿qué temas forman la teoría microeconómica?»:

    python3 scripts/fuentes-temas.py        # escribe oposicion/temario/fuentes-temas.json

Por cada tema: título, ejercicio y parte, bloque y categoría de la organización
del temario (con su idea clave), si está revisado (material exclusivo de la app),
el PDF de esta web, los temas de manuelcabadogarcia.es que le corresponden
(emparejados por el título, como hace /revisartema) y los apuntes de otros TCEE
del repositorio de la ATCEE (autor, promoción, numeración y enlace: solo
nombres y enlaces, nunca su contenido). Además, los bloques y los manuales
que recomienda la ATCEE.

Lee: oposicion/temario/temario.json, oposicion/organizacion/estructura_temario.json,
oposicion/temario/apuntes-otros.json (scripts/apuntes-otros.py),
oposicion/temario/app/skill/version.json (temas revisados) y el temario de
Manuel (manuelcabadogarcia.es o, sin red, app/para-manuel/oposicion/temario/temario.json).
La acción apuntes-otros.yml lo ejecuta cada lunes detrás de apuntes-otros.py.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import unicodedata
import urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SALIDA = os.path.join(RAIZ, 'oposicion', 'temario', 'fuentes-temas.json')
MANUEL_URL = 'https://manuelcabadogarcia.es/oposicion/temario/temario.json'
MANUEL_LOCAL = os.path.join(RAIZ, 'app', 'para-manuel', 'oposicion', 'temario', 'temario.json')
WEB = 'https://www.victorgutierrezmarcos.es'
VACIAS = set('de del la las el los y en a o u e con por para su sus al lo un una sobre referencia especial '
             'teoria teorias analisis principales evolucion situacion actual'.split())


def leer(ruta):
    with open(os.path.join(RAIZ, ruta), encoding='utf-8') as f:
        return json.load(f)


def sin_tildes(texto):
    return ''.join(c for c in unicodedata.normalize('NFD', texto.lower()) if unicodedata.category(c) != 'Mn')


def palabras(texto):
    return {p for p in re.findall(r'[a-zñ]{3,}', sin_tildes(texto)) if p not in VACIAS}


def codigo_con_puntos(cod):
    """«3A08» o «3.A.8» → «3.A.8»."""
    m = re.match(r'^(\d)\.?([A-Z])\.?0*(\d+)$', cod.strip().upper())
    return f'{m.group(1)}.{m.group(2)}.{int(m.group(3))}' if m else cod


def temario_manuel():
    try:
        req = urllib.request.Request(MANUEL_URL, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=30) as r:
            return json.load(r), MANUEL_URL
    except Exception:
        with open(MANUEL_LOCAL, encoding='utf-8') as f:
            return json.load(f), 'app/para-manuel/oposicion/temario/temario.json'


def temas_de(temario):
    for ej in temario['ejercicios']:
        for parte in ej.get('partes', []):
            for t in parte['temas']:
                yield ej, parte, t


def main():
    tcee = leer('oposicion/temario/temario.json')
    org = leer('oposicion/organizacion/estructura_temario.json')
    apuntes = leer('oposicion/temario/apuntes-otros.json')
    revisados = set()
    try:
        revisados = {codigo_con_puntos(c) for c in leer('oposicion/temario/app/skill/version.json').get('temas', [])}
    except FileNotFoundError:
        pass
    manuel, origen_manuel = temario_manuel()

    bloque_de, ideas = {}, org.get('ideas', {})
    for b in org['bloques']:
        for c in b['temas']:
            bloque_de.setdefault(c, b)

    # Temas de Manuel publicados (con url), para emparejarlos por el título
    manuel_publicados = [{'codigo': t['codigo'], 'titulo': t['titulo'], 'url': t['url']}
                         for _, _, t in temas_de(manuel) if t.get('url')]

    # Apuntes de la ATCEE por tema (código con puntos)
    atcee, plantilla = {}, apuntes.get('url_fichero', 'https://drive.google.com/file/d/{id}/view')
    for prom in apuntes['promociones']:
        for autor in prom.get('autores', []):
            for rec in autor.get('recursos', []):
                for f in rec.get('ficheros', []) or []:
                    if not f.get('tema'):
                        continue
                    atcee.setdefault(codigo_con_puntos(f['tema']), []).append({
                        'autor': autor['nombre'], 'promocion': prom.get('promocion'), 'anio': prom.get('anio'),
                        'numeracion': autor.get('numeracion', 'actual'),
                        'fichero': os.path.basename(f['nombre']), 'url': plantilla.replace('{id}', f['id'])})

    temas = {}
    for ej, parte, t in temas_de(tcee):
        cod = t['codigo']
        b = bloque_de.get(cod)
        obj = palabras(t['titulo'])
        candidatos = sorted(manuel_publicados, key=lambda m: -len(obj & palabras(m['titulo'])))
        de_manuel = [{**m, 'coincidencia': len(obj & palabras(m['titulo']))}
                     for m in candidatos[:2] if len(obj & palabras(m['titulo'])) >= 3]
        temas[cod] = {
            'oposicion': 'tcee', 'titulo': t['titulo'], 'ejercicio': ej['id'], 'parte': f"{parte['letra']} · {parte['nombre']}",
            'bloque': b['nombre'] if b else None, 'categoria': b['categoria'] if b else None, 'idea': ideas.get(cod),
            'revisado': cod in revisados,
            'web': {'pdf': t.get('url'), 'disponible': bool(t.get('disponible')), 'pagina': ej.get('urlPagina')},
            'manuel': de_manuel,
            'atcee': atcee.get(cod, []),
        }

    # DCE: el programa de Manuel, con sus páginas y los temas de TCEE que le corresponden
    dce = {}
    for ej, parte, t in temas_de(manuel):
        obj = palabras(t['titulo'])
        equivalentes = sorted(((c, len(obj & palabras(v['titulo']))) for c, v in temas.items()), key=lambda x: -x[1])
        dce[t['codigo']] = {
            'oposicion': 'dce', 'titulo': t['titulo'], 'ejercicio': ej['id'], 'parte': f"{parte['letra']} · {parte['nombre']}",
            'manuel': t.get('url'), 'equivalentes_tcee': [c for c, n in equivalentes[:2] if n >= 3],
        }

    salida = {
        'generado': apuntes.get('generado'),
        'aviso': ('Índice de fuentes por tema. Los temas revisados y los de esta web son de Víctor Gutiérrez Marcos; '
                  'los de manuelcabadogarcia.es, de Manuel Cabado García (DCE, sirven para la teoría económica de TCEE); '
                  'los apuntes de la ATCEE son de sus autores (solo enlaces: no se copian) y no son condición necesaria '
                  'ni suficiente para aprobar. Los anteriores a la promoción LXXIII siguen la numeración antigua.'),
        'fuentes': {'web': WEB + '/oposicion/temario.html', 'manuel': origen_manuel, 'atcee': apuntes.get('fuentes')},
        'bloques': [{'nombre': b['nombre'], 'categoria': b['categoria'], 'ejercicio': b.get('ejercicio'), 'temas': b['temas']}
                    for b in org['bloques']],
        'manuales': apuntes.get('manuales'),
        'tcee': temas,
        'dce': dce,
    }
    with open(SALIDA, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(salida, f, ensure_ascii=False, indent=1, sort_keys=False)
        f.write('\n')
    n_manuel = sum(1 for v in temas.values() if v['manuel'])
    n_atcee = sum(1 for v in temas.values() if v['atcee'])
    print(f'{len(temas)} temas de TCEE ({len(revisados)} revisados, {n_manuel} con tema de Manuel, {n_atcee} con apuntes de la ATCEE), '
          f'{len(dce)} de DCE; {os.path.getsize(SALIDA) // 1024} KB -> {os.path.relpath(SALIDA, RAIZ)}')


if __name__ == '__main__':
    main()
