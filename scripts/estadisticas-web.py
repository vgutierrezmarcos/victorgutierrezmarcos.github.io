#!/usr/bin/env python3
"""Estadísticas de la web para el SEO: Search Console y Google Analytics, solo lectura.

Search Console: clics, impresiones, CTR y posición media en Google, por búsqueda
y por página, comparados con el periodo anterior. Analytics: usuarios, sesiones,
páginas y de dónde llegan (solo quien acepta las cookies, así que se queda corto).
Cada ejecución guarda la foto del día (solo agregados) para ver la evolución.

    python3 scripts/estadisticas-web.py              # últimos 28 días
    python3 scripts/estadisticas-web.py --dias 90
    python3 scripts/estadisticas-web.py --json       # la foto en JSON

Clave: la de la cuenta de servicio estadisticas-lectura@web-vgm (la misma de
estadisticas-red.py), en ~/.config/oposicion-red/clave.json o en
$ESTADISTICAS_CLAVE, con permiso «Restringido» en Search Console y «Lector» en
la propiedad de Analytics. Nunca dentro del repositorio. Fotos:
~/.local/share/oposicion-web/.

Solo usa la biblioteca estándar y `openssl` (para firmar el token).
"""
import base64
import json
import os
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import date, timedelta
from pathlib import Path

CLAVE = Path(os.environ.get('ESTADISTICAS_CLAVE', Path.home() / '.config/oposicion-red/clave.json'))
FOTOS = Path.home() / '.local/share/oposicion-web'
SITIO = 'sc-domain:victorgutierrezmarcos.es'
PROPIEDAD_GA = os.environ.get('PROPIEDAD_GA', '520890893')
AMBITOS = 'https://www.googleapis.com/auth/webmasters.readonly https://www.googleapis.com/auth/analytics.readonly'

# Detrás del proxy del trabajo (intercepta TLS): ver estadisticas-red.py
_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


# ------------------------------------------------------------------ Acceso

def _b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b'=').decode()


def token():
    c = json.loads(CLAVE.read_text())
    ahora = int(time.time())
    cabecera = _b64(json.dumps({'alg': 'RS256', 'typ': 'JWT'}).encode())
    cuerpo = _b64(json.dumps({'iss': c['client_email'], 'scope': AMBITOS, 'aud': c['token_uri'],
                              'iat': ahora, 'exp': ahora + 3600}).encode())
    with tempfile.NamedTemporaryFile('w', suffix='.pem', delete=False) as f:
        f.write(c['private_key'])
    try:
        firma = subprocess.run(['openssl', 'dgst', '-sha256', '-sign', f.name], input=f'{cabecera}.{cuerpo}'.encode(),
                               capture_output=True, check=True).stdout
    finally:
        os.unlink(f.name)
    datos = urllib.parse.urlencode({'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
                                    'assertion': f'{cabecera}.{cuerpo}.{_b64(firma)}'}).encode()
    return json.load(urllib.request.urlopen(c['token_uri'], datos, timeout=30))['access_token']


class Api:
    def __init__(self):
        self.t = token()

    def post(self, url, cuerpo):
        for intento in range(4):
            try:
                r = urllib.request.Request(url, json.dumps(cuerpo).encode(),
                                           {'Authorization': f'Bearer {self.t}', 'Content-Type': 'application/json'})
                return json.load(urllib.request.urlopen(r, timeout=60))
            except urllib.error.HTTPError:
                raise
            except OSError:
                if intento == 3:
                    raise
                time.sleep(2 * (intento + 1))


# ------------------------------------------------------------ Search Console

def consola(api, desde, hasta, dimensiones, filas=25, filtro=None):
    cuerpo = {'startDate': desde.isoformat(), 'endDate': hasta.isoformat(), 'dimensions': dimensiones, 'rowLimit': filas}
    if filtro:
        cuerpo['dimensionFilterGroups'] = [{'filters': [filtro]}]
    url = f'https://www.googleapis.com/webmasters/v3/sites/{urllib.parse.quote(SITIO, safe="")}/searchAnalytics/query'
    return [{**{d: k for d, k in zip(dimensiones, f.get('keys', []))},
             'clics': f['clicks'], 'impresiones': f['impressions'], 'ctr': round(100 * f['ctr'], 1),
             'posicion': round(f['position'], 1)} for f in api.post(url, cuerpo).get('rows', [])]


def totales(api, desde, hasta):
    filas = consola(api, desde, hasta, [], 1)
    return filas[0] if filas else {'clics': 0, 'impresiones': 0, 'ctr': 0, 'posicion': None}


# ----------------------------------------------------------------- Analytics

def analytics(api, desde, hasta, dimensiones, metricas, filas=15, contiene=None):
    cuerpo = {'dateRanges': [{'startDate': desde.isoformat(), 'endDate': hasta.isoformat()}],
              'dimensions': [{'name': d} for d in dimensiones], 'metrics': [{'name': m} for m in metricas],
              'limit': filas, 'orderBys': [{'metric': {'metricName': metricas[0]}, 'desc': True}]}
    if contiene:
        cuerpo['dimensionFilter'] = {'filter': {'fieldName': dimensiones[0],
                                                'stringFilter': {'matchType': 'CONTAINS', 'value': contiene}}}
    r = api.post(f'https://analyticsdata.googleapis.com/v1beta/properties/{PROPIEDAD_GA}:runReport', cuerpo)
    return [{**{d: v['value'] for d, v in zip(dimensiones, f.get('dimensionValues', []))},
             **{m: int(float(v['value'])) for m, v in zip(metricas, f['metricValues'])}} for f in r.get('rows', [])]


# -------------------------------------------------------------------- Foto

def foto(dias):
    api = Api()
    # Search Console va con 2-3 días de retraso
    hasta = date.today() - timedelta(days=3)
    desde = hasta - timedelta(days=dias - 1)
    antes_hasta, antes_desde = desde - timedelta(days=1), desde - timedelta(days=dias)
    sc = {
        'periodo': [desde.isoformat(), hasta.isoformat()],
        'total': totales(api, desde, hasta),
        'total_anterior': totales(api, antes_desde, antes_hasta),
        'busquedas': consola(api, desde, hasta, ['query'], 40),
        'paginas': consola(api, desde, hasta, ['page'], 30),
        'busquedas_app': consola(api, desde, hasta, ['query'], 20,
                                 {'dimension': 'page', 'operator': 'contains', 'expression': '/app/'}),
        # Objetivo del SEO de oct. 2026: que la web salga para DCE / Diplomado Comercial del Estado
        'busquedas_dce': consola(api, desde, hasta, ['query', 'page'], 20,
                                 {'dimension': 'query', 'operator': 'includingRegex', 'expression': '(?i)dce|diplomad'}),
        'dispositivos': consola(api, desde, hasta, ['device'], 5),
        'paises': consola(api, desde, hasta, ['country'], 5),
    }
    ga_hasta = date.today() - timedelta(days=1)
    ga_desde = ga_hasta - timedelta(days=dias - 1)
    try:
        ga = {
            'periodo': [ga_desde.isoformat(), ga_hasta.isoformat()],
            'total': (analytics(api, ga_desde, ga_hasta, [], ['activeUsers', 'sessions', 'screenPageViews'], 1) or [{}])[0],
            'canales': analytics(api, ga_desde, ga_hasta, ['sessionDefaultChannelGroup'], ['sessions', 'activeUsers'], 10),
            'origenes': analytics(api, ga_desde, ga_hasta, ['sessionSource'], ['sessions'], 15),
            'paginas': analytics(api, ga_desde, ga_hasta, ['pagePath'], ['screenPageViews', 'activeUsers'], 25),
            'dispositivos': analytics(api, ga_desde, ga_hasta, ['deviceCategory'], ['activeUsers'], 5),
            # Temas sin PDF que la gente pincha (los enlaces llevan ?tema=3.A.5 desde el 15 oct. 2026)
            'temas_pedidos': analytics(api, ga_desde, ga_hasta, ['pagePathPlusQueryString'], ['screenPageViews'], 50,
                                       'tema-no-disponible.html?tema='),
        }
    except urllib.error.HTTPError as e:
        ga = {'error': f'{e.code}: {e.read().decode()[:200]}'}
    return {'fecha': date.today().isoformat(), 'dias': dias, 'search_console': sc, 'analytics': ga}


def _corta(url):
    return url.replace('https://www.victorgutierrezmarcos.es', '') or '/'


def imprimir(f):
    sc, ga = f['search_console'], f['analytics']
    t, a = sc['total'], sc['total_anterior']
    print(f"\nGOOGLE (Search Console) · {sc['periodo'][0]} a {sc['periodo'][1]}")
    print(f"  Clics {t['clics']} (antes {a['clics']}) · impresiones {t['impresiones']} (antes {a['impresiones']})"
          f" · CTR {t['ctr']} % · posición media {t['posicion']}")
    for titulo, filas, clave in [('Búsquedas', sc['busquedas'], 'query'), ('Páginas', sc['paginas'], 'page'),
                                 ('Búsquedas que llevan a /app/', sc['busquedas_app'], 'query'),
                                 ('Búsquedas con «dce» o «diplomado»', sc.get('busquedas_dce'), 'query')]:
        print(f'\n  {titulo} (clics · impresiones · posición):')
        for x in filas or [{clave: '(sin datos todavía)', 'clics': '', 'impresiones': '', 'posicion': ''}]:
            nombre = _corta(x[clave]) if clave == 'page' else x[clave]
            if 'page' in x and clave == 'query':
                nombre += f"  → {_corta(x['page'])}"
            print(f"    {str(x['clics']):>4} · {str(x['impresiones']):>6} · {str(x['posicion']):>5}  {nombre}")
    print('\n  Dispositivos: ' + ', '.join(f"{x['device']} {x['clics']}/{x['impresiones']}" for x in sc['dispositivos']))
    print('  Países: ' + ', '.join(f"{x['country']} {x['clics']}/{x['impresiones']}" for x in sc['paises']))

    print('\nVISITAS (Analytics, solo quien acepta cookies)')
    if 'error' in ga:
        print('  No se ha podido leer:', ga['error'])
        return
    tot = ga['total']
    if not tot:
        print(f'  Sin datos en la propiedad {PROPIEDAD_GA}: comprueba que es la del flujo G-ZC63ML9ECJ')
        return
    print(f"  {ga['periodo'][0]} a {ga['periodo'][1]}: {tot.get('activeUsers', 0)} usuarios,"
          f" {tot.get('sessions', 0)} sesiones, {tot.get('screenPageViews', 0)} páginas vistas")
    print('  Canales: ' + ', '.join(f"{x['sessionDefaultChannelGroup']} {x['sessions']}" for x in ga['canales']))
    print('  Orígenes: ' + ', '.join(f"{x['sessionSource']} {x['sessions']}" for x in ga['origenes']))
    print('  Dispositivos: ' + ', '.join(f"{x['deviceCategory']} {x['activeUsers']}" for x in ga['dispositivos']))
    pedidos = [(x['pagePathPlusQueryString'].split('tema=')[-1], x['screenPageViews']) for x in ga['temas_pedidos']]
    print('  Temas no disponibles que se piden: ' + (', '.join(f'{t} ({n})' for t, n in pedidos) or 'ninguno todavía'))
    print('  Páginas más vistas:')
    for x in ga['paginas']:
        print(f"    {x['screenPageViews']:>5}  {x['pagePath']}")


def main():
    dias = int(sys.argv[sys.argv.index('--dias') + 1]) if '--dias' in sys.argv else 28
    f = foto(dias)
    FOTOS.mkdir(parents=True, exist_ok=True)
    (FOTOS / f"{f['fecha']}-{dias}d.json").write_text(json.dumps(f, ensure_ascii=False, indent=1))
    if '--json' in sys.argv:
        print(json.dumps(f, ensure_ascii=False, indent=1))
    else:
        imprimir(f)


if __name__ == '__main__':
    main()
