#!/usr/bin/env python3
"""Conceptos de los temas revisados enlazados con su artículo de Wikipedia (SEO, sin nada visible).

Para que Google y las IA sepan sin adivinar de qué trata cada tema, el JSON-LD de las
páginas de ejercicio (datos-estructurados-temario.py) lleva en cada tema revisado un
«about» con sus conceptos y el artículo de Wikipedia en español de cada uno («sameAs»).

Los conceptos salen de los apartados del índice (revisados-web.json). Cada apartado se
parte en frases («Juegos estáticos: dominancia y equilibrio de Nash» → «juegos estáticos»,
«dominancia», «equilibrio de Nash») y solo se acepta una frase si en Wikidata es, tal
cual, la etiqueta o un alias en español de un elemento con artículo en la Wikipedia en
español que no sea una persona, una desambiguación ni una obra. Mejor pocos y seguros:
un emparejamiento malo confunde más de lo que ayuda. Lo dudoso se quita con EXCLUIR.

    python3 scripts/conceptos-wikipedia.py            # consulta lo que falte (caché en ~/.cache) y escribe el JSON
    python3 scripts/conceptos-wikipedia.py --listar   # además, lista lo aceptado por tema para revisarlo

Escribe oposicion/temario/conceptos-wikipedia.json. Después: python3 scripts/datos-estructurados-temario.py

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.parse
import urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REVISADOS = os.path.join(RAIZ, 'oposicion', 'temario', 'revisados-web.json')
SALIDA = os.path.join(RAIZ, 'oposicion', 'temario', 'conceptos-wikipedia.json')
CACHE = os.path.expanduser('~/.cache/oposicion-web/wikidata-conceptos.json')
CAS = os.path.expanduser('~/.config/oposicion-red/cas.pem')
API = 'https://www.wikidata.org/w/api.php'
WIKI = 'https://es.wikipedia.org/w/api.php'
AGENTE = 'temario-conceptos/1.0 (generador de datos estructurados de una web educativa)'
MAXIMO = 4  # conceptos por tema en el JSON-LD (pesa en cada visita a la página de ejercicio)

# Tipos de elemento que no son un concepto: persona, desambiguación, obra, película, libro,
# artículo científico, apellido, nombre, empresa, organización, lugar.
NO = {'Q5', 'Q4167410', 'Q386724', 'Q11424', 'Q571', 'Q7725634', 'Q13442814', 'Q101352', 'Q202444',
      'Q4830453', 'Q43229', 'Q6256', 'Q515', 'Q22808320', 'Q4167836', 'Q17442446', 'Q47461344'}
# Palabras que solas no dicen nada (y no se buscan)
VACIAS = {'extensiones', 'extensión', 'valoración', 'supuestos', 'concepto', 'conceptos', 'aplicaciones', 'evidencia',
          'evidencia empírica', 'introducción', 'conclusión', 'idea', 'modelo', 'modelos', 'tipos', 'clasificación',
          'elementos', 'representación', 'origen', 'evolución', 'situación actual', 'perspectivas', 'los límites',
          'principales conceptos', 'teoría', 'política', 'efectos', 'causas', 'consecuencias', 'medición',
          'implementación', 'definición', 'características', 'formatos', 'objetivos', 'instrumentos', 'balance',
          'críticas', 'resultados', 'retos', 'funciones', 'estructura', 'antecedentes', 'contexto', 'historia',
          'españa', 'la ue', 'ue', 'unión europea', 'europa', 'mundo', 'economía', 'mercado', 'mercados', 'estado'}
# Emparejamientos revisados a mano que no valen: frase normalizada (o «frase|Q…»).
EXCLUIR = {  # revisado el 25/11/2026
    'ejercicio', 'cowling', 'mercado de pescado', 'valor intrinseco', 'gerencia', 'tipo fijo', 'maastricht',
    'libre circulacion de capitales', 'generaciones', 'acuerdo', 'socios', 'trabajo', 'implementacion', 'cooperacion',
    'calidades', 'sociologico', 'tendencia', 'formalizacion', 'airbus', 'boeing', 'tribunal de cuentas',
    'toma de decisiones', 'contabilidad', 'publicidad', 'empresa', 'empresas', 'oferta', 'consumo', 'ingresos', 'gastos',
    'inversiones', 'inversion', 'bancos', 'comercio', 'financieros', 'empleo', 'preferencias', 'excedentes',
    'consumidores', 'contribuyentes', 'salarios', 'deuda', 'dinero', 'moneda', 'seguros', 'pobreza', 'datos masivos',
}


def normalizar(t):
    t = unicodedata.normalize('NFD', t.lower())
    t = ''.join(c for c in t if unicodedata.category(c) != 'Mn')
    return re.sub(r'\s+', ' ', re.sub(r'[^\w\s-]', ' ', t)).strip()


def frases(apartado):
    """«Juegos estáticos: dominancia y equilibrio de Nash» → frases candidatas."""
    t = re.sub(r'\([^)]*\)', ' ', apartado)
    t = re.sub(r'^(principales conceptos|extensiones?|aplicaciones?|valoración)\s*(\([^)]*\))?\s*:', '', t, flags=re.I)
    salida = []
    for parte in re.split(r'\s*[:;,¿?¡!«»]\s*|\s+y\s+|\s+e\s+|\s+frente a\s+|\s+con\s+|\s+en\s+(?:el|la|los|las)\s+', t):
        parte = re.sub(r'^(el|la|los|las|un|una|del|de|lo)\s+', '', parte.strip(), flags=re.I).strip(' .-–')
        n = normalizar(parte)
        if len(n) < 5 or n in VACIAS or len(n.split()) > 6 or re.search(r'\d', n):
            continue
        salida.append(parte)
    return salida


def pedir(url, params):
    params = dict(params, format='json', formatversion=2)
    req = urllib.request.Request(url + '?' + urllib.parse.urlencode(params), headers={'User-Agent': AGENTE})
    import ssl
    ctx = ssl.create_default_context(cafile=CAS) if os.path.exists(CAS) else None
    for intento in range(8):
        time.sleep(1.0)  # despacio: Wikimedia contesta 429 si se le pide deprisa
        try:
            with urllib.request.urlopen(req, timeout=30, context=ctx) as r:
                return json.load(r)
        except urllib.error.HTTPError as e:
            if e.code != 429 or intento == 7:
                raise
            time.sleep(int(e.headers.get('Retry-After') or 30) + 5)
        except Exception:  # la red del Ministerio corta a veces
            if intento == 7:
                raise
            time.sleep(2 + 3 * intento)


def titulo_wiki(frase):
    return frase[:1].upper() + frase[1:]


def buscar_lote(frases_, cache):
    """Rellena la caché: cada frase es, tal cual, el título de un artículo de es.wikipedia (o una
    redirección a él) que no es desambiguación, y su elemento de Wikidata no es persona, obra, lugar…"""
    pendientes = [f for f in dict.fromkeys(frases_) if normalizar(f) not in cache]
    for k in range(0, len(pendientes), 50):
        lote = pendientes[k:k + 50]
        r = pedir(WIKI, {'action': 'query', 'titles': '|'.join(titulo_wiki(f) for f in lote), 'redirects': 1,
                         'prop': 'pageprops', 'ppprop': 'wikibase_item|disambiguation'})['query']
        destino = {}
        for x in r.get('normalized', []) + r.get('redirects', []):
            destino[x['from']] = x['to']
        paginas = {p['title']: p for p in r.get('pages', [])}
        encontrados = {}
        for f in lote:
            t = titulo_wiki(f)
            while t in destino and destino[t] != t:
                t = destino[t]
            p = paginas.get(t)
            pp = (p or {}).get('pageprops', {})
            if not p or p.get('missing') or 'disambiguation' in pp or not pp.get('wikibase_item'):
                cache[normalizar(f)] = None
            else:
                encontrados[f] = (t, pp['wikibase_item'])
        if encontrados:
            ids = sorted({q for _, q in encontrados.values()})
            e = pedir(API, {'action': 'wbgetentities', 'ids': '|'.join(ids), 'props': 'claims|labels', 'languages': 'es'})
            e = e.get('entities', {})
            for f, (t, q) in encontrados.items():
                d = e.get(q, {})
                tipos = {c['mainsnak'].get('datavalue', {}).get('value', {}).get('id') for c in d.get('claims', {}).get('P31', [])}
                cache[normalizar(f)] = None if tipos & NO else {
                    'wikidata': q, 'titulo': t, 'etiqueta': d.get('labels', {}).get('es', {}).get('value', t),
                    'wikipedia': 'https://es.wikipedia.org/wiki/' + urllib.parse.quote(t.replace(' ', '_'))}
        print(f'  {min(k + 50, len(pendientes))}/{len(pendientes)}', file=sys.stderr)


# Palabras que dicen que un artículo es de economía (en su entrada)
ECONOMIA = re.compile(r'econom|mercado|precio|financ|monetar|fiscal|comerci|empresa|consum|inversi|'
                      r'utilidad|juego|bienestar|impuest|banc|dinero|capital|salari|empleo|inflaci|'
                      r'producci|demanda|oferta|contab|presupuest|deuda|crédito|tipo de inter|elección social|vot', re.I)


def de_economia(cache):
    """Marca en la caché si la entrada del artículo habla de economía (20 artículos por consulta)."""
    titulos = sorted({e['titulo'] for e in cache.values() if e and 'economia' not in e})
    for k in range(0, len(titulos), 20):
        lote = titulos[k:k + 20]
        r = pedir(WIKI, {'action': 'query', 'titles': '|'.join(lote), 'prop': 'extracts', 'exintro': 1,
                         'explaintext': 1, 'exlimit': 20, 'exchars': 600})['query']
        textos = {p['title']: p.get('extract', '') for p in r.get('pages', [])}
        for e in cache.values():
            if e and e['titulo'] in textos:
                e['economia'] = bool(ECONOMIA.search(textos[e['titulo']]))
        print(f'  entradas {min(k + 20, len(titulos))}/{len(titulos)}', file=sys.stderr)


def main():
    listar = '--listar' in sys.argv
    cache = json.load(open(CACHE, encoding='utf-8')) if os.path.exists(CACHE) else {}
    temas = json.load(open(REVISADOS, encoding='utf-8'))['temas']
    salida, nuevas = {}, 0
    try:
        todas = [f for t in temas for ap in t.get('conceptos', []) for f in frases(ap)]
        nuevas = len({normalizar(f) for f in todas} - set(cache))
        buscar_lote(todas, cache)
        de_economia(cache)
        # En cuántos temas sale cada elemento: cuanto menos, más dice del tema.
        frecuencia = {}
        for t in temas:
            for q in {cache[normalizar(f)]['wikidata'] for ap in t.get('conceptos', []) for f in frases(ap) if cache.get(normalizar(f))}:
                frecuencia[q] = frecuencia.get(q, 0) + 1
        for t in temas:
            vistos, lista = set(), []
            for ap in t.get('conceptos', []):
                for f in frases(ap):
                    n = normalizar(f)
                    if n in vistos:
                        continue
                    vistos.add(n)
                    e = cache.get(n)
                    if not e or not e.get('economia') or n in EXCLUIR or f'{n}|{e["wikidata"]}' in EXCLUIR:
                        continue
                    if any(x['wikidata'] == e['wikidata'] for x in lista):
                        continue
                    lista.append({'nombre': e['etiqueta'], 'titulo': e['titulo'], 'frase': f, 'wikidata': e['wikidata'], 'wikipedia': e['wikipedia']})
            # Primero lo propio del tema (sale en pocos), luego lo más largo (más concreto).
            lista.sort(key=lambda x: (frecuencia.get(x['wikidata'], 1) > 3, frecuencia.get(x['wikidata'], 1), -len(x['frase'].split())))
            salida[t['archivo']] = lista
            if listar:
                print(f"{t['archivo']}: " + '; '.join(f"{x['frase']} → {x['titulo']} ({x['wikidata']})" for x in lista))
    finally:
        os.makedirs(os.path.dirname(CACHE), exist_ok=True)
        json.dump(cache, open(CACHE, 'w', encoding='utf-8'), ensure_ascii=False)
    datos = {'descripcion': 'Conceptos de cada tema revisado con su artículo de Wikipedia (JSON-LD «about» de las páginas de '
                            'ejercicio). Lo genera scripts/conceptos-wikipedia.py: no editar a mano (lo que no valga, a EXCLUIR).',
             'maximo': MAXIMO, 'temas': salida}
    with open(SALIDA, 'w', encoding='utf-8') as f:
        json.dump(datos, f, ensure_ascii=False, indent=1)
        f.write('\n')
    total = sum(len(v) for v in salida.values())
    print(f'{len(salida)} temas, {total} conceptos con artículo ({nuevas} consultas nuevas); '
          f'{sum(1 for v in salida.values() if not v)} temas sin ninguno')


if __name__ == '__main__':
    main()
