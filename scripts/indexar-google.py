#!/usr/bin/env python3
"""Pide a Google cada día que rastree una tanda de páginas de la web (Indexing API).

Cada mañana (indexar-google.yml) inspecciona con la API de inspección de URL de
Search Console todas las URL de sitemap.xml y manda a la Indexing API, por orden
de relevancia (ORDEN y luego los PDF), como mucho TANDA URL:

1. las que Google aún no tiene indexadas (y que no bloquean robots ni noindex),
   si no se mandaron en los últimos REPETIR_SIN_INDEXAR días;
2. si sobra sitio, las indexadas que cambiaron (lastmod del sitemap) después del
   último rastreo, si no se mandaron en los últimos REPETIR_CAMBIADAS días.

Lo enviado se apunta en scripts/indexacion-google.json (solo URL, fechas y estado).

    python3 scripts/indexar-google.py --simular   # inspecciona y dice qué mandaría
    python3 scripts/indexar-google.py             # manda la tanda
    python3 scripts/indexar-google.py --hora 8    # solo si en Madrid son ya las 8 y hoy no se mandó

La Indexing API es oficialmente para ofertas de empleo y emisiones en directo:
con otras páginas acepta el aviso, pero Google no garantiza que lo use.

Clave: la de la cuenta de servicio de indexación, que debe ser «Propietario» de
la propiedad en Search Console. En $GOOGLE_INDEXACION_CLAVE (el JSON entero, como
secreto de GitHub) o en ~/.config/oposicion-red/indexacion.json. Nunca en el
repositorio. Con --simular vale la de solo lectura (clave.json).

Solo usa la biblioteca estándar y `openssl` (para firmar el token).
"""
import base64
import json
import os
import re
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from datetime import date, datetime, timedelta
from pathlib import Path
from zoneinfo import ZoneInfo

RAIZ = Path(__file__).resolve().parent.parent
REGISTRO = RAIZ / 'scripts/indexacion-google.json'
SITIO = 'sc-domain:victorgutierrezmarcos.es'
WEB = 'https://www.victorgutierrezmarcos.es/'
TANDA = 10
REPETIR_SIN_INDEXAR = 7
REPETIR_CAMBIADAS = 30
CONFIG = Path.home() / '.config/oposicion-red'

# Páginas por orden de relevancia (rutas relativas a WEB); detrás, el resto de
# páginas del sitemap, luego los PDF (tercer ejercicio, cuarto y demás) y al final
# las páginas legales de la app (AL_FINAL)
ORDEN = [
    '',
    'oposicion/por-que-tcee.html',
    'oposicion/',
    'oposicion/temario.html',
    'app/',
    'oposicion/temario/primer-ejercicio/test/simulador.html',
    'oposicion/cifras.html',
    'oposicion/temario/tercer-ejercicio.html',
    'oposicion/temario/cuarto-ejercicio.html',
    'oposicion/temario/primer-ejercicio.html',
    'oposicion/temario/primer-ejercicio/test.html',
    'oposicion/temario/segundo-ejercicio.html',
    'oposicion/temario/quinto-ejercicio.html',
    'oposicion/organizacion.html',
    'oposicion/probabilidad-test.html',
    'blog/',
    'oposicion/enlaces.html',
    'novedades.html',
    'sobre-mi.html',
    'comunidad.html',
    'oposicion/prepara-con-ia.html',
    'oposicion/prepara-con-claude.html',
    'app/instalar.html',
]
ORDEN_PDF = ['oposicion/temario/tercer-ejercicio/', 'oposicion/temario/cuarto-ejercicio/']
AL_FINAL = ['app/condiciones.html', 'app/eliminar-cuenta.html']

# Detrás del proxy del trabajo (intercepta TLS): ver estadisticas-red.py
_CAS = CONFIG / 'cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


# ------------------------------------------------------------------ Acceso

def _b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b'=').decode()


def clave(simular):
    if os.environ.get('GOOGLE_INDEXACION_CLAVE'):
        return json.loads(os.environ['GOOGLE_INDEXACION_CLAVE'])
    for f in ['indexacion.json'] + (['clave.json'] if simular else []):
        if (CONFIG / f).exists():
            return json.loads((CONFIG / f).read_text())
    sys.exit('Falta la clave: $GOOGLE_INDEXACION_CLAVE o ~/.config/oposicion-red/indexacion.json')


def token(c, ambitos):
    ahora = int(time.time())
    cabecera = _b64(json.dumps({'alg': 'RS256', 'typ': 'JWT'}).encode())
    cuerpo = _b64(json.dumps({'iss': c['client_email'], 'scope': ambitos, 'aud': c['token_uri'],
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


def post(t, url, cuerpo):
    for intento in range(4):
        try:
            r = urllib.request.Request(url, json.dumps(cuerpo).encode(),
                                       {'Authorization': f'Bearer {t}', 'Content-Type': 'application/json'})
            return json.load(urllib.request.urlopen(r, timeout=60))
        except urllib.error.HTTPError as e:
            if e.code < 500 or intento == 3:
                raise
        except OSError:
            if intento == 3:
                raise
        time.sleep(2 * (intento + 1))


# ------------------------------------------------------------------ Sitemap

def sitemap():
    """[(url, lastmod)] por orden de relevancia."""
    texto = (RAIZ / 'sitemap.xml').read_text(encoding='utf-8')
    urls = [(m.group(1), (re.search(r'<lastmod>([^<]+)</lastmod>', m.group(0)) or [None, None])[1])
            for m in re.finditer(r'<url>\s*<loc>([^<]+)</loc>.*?</url>', texto, re.S)]

    def rango(par):
        ruta = par[0].removeprefix(WEB)
        if ruta in ORDEN:
            return (0, ORDEN.index(ruta), ruta)
        if ruta in AL_FINAL:
            return (3, AL_FINAL.index(ruta), ruta)
        if not ruta.endswith('.pdf'):
            return (1, 0, ruta)
        pre = next((i for i, p in enumerate(ORDEN_PDF) if ruta.startswith(p)), len(ORDEN_PDF))
        return (2, pre, ruta)
    return sorted(urls, key=rango)


# ------------------------------------------------------------------ Inspección

def inspeccionar(t, url):
    try:
        d = post(t, 'https://searchconsole.googleapis.com/v1/urlInspection/index:inspect',
                 {'inspectionUrl': url, 'siteUrl': SITIO, 'languageCode': 'es'})['inspectionResult']['indexStatusResult']
    except urllib.error.HTTPError as e:
        return {'error': f'{e.code} {e.read().decode(errors="replace")[:200]}'}
    return {k: d.get(k) for k in ('verdict', 'coverageState', 'indexingState', 'robotsTxtState', 'lastCrawlTime')}


def bloqueada(e):
    return e.get('indexingState') not in (None, 'INDEXING_STATE_UNSPECIFIED', 'INDEXING_ALLOWED') \
        or e.get('robotsTxtState') == 'DISALLOWED'


def elegir(urls, estados, registro, hoy):
    sin_indexar, cambiadas = [], []
    for url, lastmod in urls:
        e = estados[url]
        if 'error' in e or bloqueada(e):
            continue
        enviada = registro.get(url, {}).get('enviada')
        dias = (hoy - date.fromisoformat(enviada)).days if enviada else 10 ** 6
        if e.get('verdict') != 'PASS':
            if dias >= REPETIR_SIN_INDEXAR:
                sin_indexar.append((url, 'sin indexar'))
        elif lastmod and e.get('lastCrawlTime') and e['lastCrawlTime'][:10] < lastmod[:10] \
                and dias >= REPETIR_CAMBIADAS:
            cambiadas.append((url, 'cambiada desde el último rastreo'))
    return (sin_indexar + cambiadas)[:TANDA]


# ------------------------------------------------------------------ Principal

def main():
    simular = '--simular' in sys.argv
    madrid = datetime.now(ZoneInfo('Europe/Madrid'))
    hoy = madrid.date()
    registro = json.loads(REGISTRO.read_text()) if REGISTRO.exists() else {}
    if '--hora' in sys.argv:
        hora = int(sys.argv[sys.argv.index('--hora') + 1])
        if madrid.hour < hora or registro.get('_ultima_tanda') == hoy.isoformat():
            print(f'Nada que hacer: en Madrid son las {madrid:%H:%M} y la última tanda fue el {registro.get("_ultima_tanda")}')
            return

    c = clave(simular)
    ambitos = 'https://www.googleapis.com/auth/webmasters.readonly'
    if not simular:
        ambitos += ' https://www.googleapis.com/auth/indexing'
    t = token(c, ambitos)

    urls = sitemap()
    with ThreadPoolExecutor(4) as hilos:
        estados = dict(zip([u for u, _ in urls], hilos.map(lambda u: inspeccionar(t, u[0]), urls)))
    errores = [u for u, e in estados.items() if 'error' in e]
    if len(errores) == len(urls):
        sys.exit(f'La inspección falla en todas las URL: {estados[errores[0]]["error"]}')

    indexadas = sum(e.get('verdict') == 'PASS' for e in estados.values())
    print(f'{indexadas} de {len(urls)} URL del sitemap indexadas en Google ({len(errores)} sin poder inspeccionar)')
    tanda = elegir(urls, estados, registro, hoy)
    if not tanda:
        print('Nada que mandar hoy')

    enviadas = []
    for url, motivo in tanda:
        if simular:
            print(f'  mandaría  {url}  ({motivo}: {estados[url].get("coverageState")})')
            continue
        try:
            post(t, 'https://indexing.googleapis.com/v3/urlNotifications:publish', {'url': url, 'type': 'URL_UPDATED'})
        except urllib.error.HTTPError as e:
            detalle = e.read().decode(errors='replace')[:300]
            if e.code == 429:
                print(f'Cuota agotada: {detalle}')
                break
            sys.exit(f'La Indexing API rechaza {url}: {e.code} {detalle}')
        enviadas.append(url)
        print(f'  enviada   {url}  ({motivo})')

    if simular:
        return
    for url, e in estados.items():
        r = registro.setdefault(url, {})
        if url in enviadas:
            r['enviada'] = hoy.isoformat()
        if 'error' not in e:
            r['estado'] = e.get('coverageState')
            r['rastreo'] = (e.get('lastCrawlTime') or '')[:10] or None
    registro['_ultima_tanda'] = hoy.isoformat()
    registro['_indexadas'] = f'{indexadas}/{len(urls)}'
    REGISTRO.write_text(json.dumps(dict(sorted(registro.items())), ensure_ascii=False, indent=1) + '\n')

    resumen = os.environ.get('GITHUB_STEP_SUMMARY')
    if resumen:
        with open(resumen, 'a') as f:
            f.write(f'### Indexación en Google ({hoy})\n\n{indexadas} de {len(urls)} URL indexadas.\n\n')
            f.write(''.join(f'- {u}\n' for u in enviadas) or 'Nada que mandar hoy.\n')


if __name__ == '__main__':
    main()
