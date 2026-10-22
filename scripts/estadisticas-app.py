#!/usr/bin/env python3
"""Estadísticas de la app «Oposición TCEE · DCE», solo agregadas y de solo lectura.

Reúne en una foto lo que se sabe de la app por fuentes distintas:
  - Google Play (instalaciones, desinstalaciones, dispositivos activos y
    valoraciones, de los informes del bucket de Play Console; fallos y ANR de
    la API Play Developer Reporting; reseñas de la última semana).
  - Google Analytics de la app (propiedad de Firebase): usuarios, sesiones,
    pantallas, versiones, retención y usuarios sin fallos. Solo quien acepta
    enviar estadísticas desde la app (1.18.0).
  - Descargas del APK publicado en la release app-latest de GitHub.
  - La red (cuentas, opositores, preparadores, clases, tests), de
    estadisticas-red.py, por oposición.

Nunca saca nombres, correos ni uid: solo recuentos. Cada ejecución guarda la
foto del día en ~/.local/share/oposicion-red/app/ (aparte de las fotos de la
red, que estadisticas-red.py compara entre sí).

    python3 scripts/estadisticas-app.py            # resumen y foto del día
    python3 scripts/estadisticas-app.py --json     # la foto en JSON
    python3 scripts/estadisticas-app.py --dias 90

Clave: la cuenta de servicio estadisticas-lectura@web-vgm (la misma de
estadisticas-red.py y estadisticas-web.py), en ~/.config/oposicion-red/clave.json
o en $ESTADISTICAS_CLAVE. Para Google Play hace falta además
~/.config/oposicion-red/play.json:
    {"bucket": "pubsite_prod_rev_XXXXXXXXXXXXXXXX", "paquete": "es.victorgutierrezmarcos.tcee_app"}
(el bucket sale en Play Console → Descargar informes → Estadísticas → «Copiar
URI de Cloud Storage», sin el «gs://»). Y en Play Console → Usuarios y permisos
hay que invitar al correo de la cuenta de servicio con «Ver información de la
app y descargar informes masivos (solo lectura)». Si algo falta, la foto lo
dice en «pendiente» en vez de fallar.

Solo usa la biblioteca estándar y `openssl` (para firmar el token).
"""
import base64
import csv
import io
import json
import os
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
from collections import Counter
from datetime import date, timedelta
from pathlib import Path

CLAVE = Path(os.environ.get('ESTADISTICAS_CLAVE', Path.home() / '.config/oposicion-red/clave.json'))
PLAY = Path.home() / '.config/oposicion-red/play.json'
FOTOS = Path.home() / '.local/share/oposicion-red/app'
PROYECTO = 'web-vgm'
PAQUETE = 'es.victorgutierrezmarcos.tcee_app'
# Propiedad de Analytics de Firebase (la de la app; la 520890893 es la de la web)
PROPIEDAD_GA_APP = os.environ.get('PROPIEDAD_GA_APP', '521757581')
REPO = 'vgutierrezmarcos/victorgutierrezmarcos.github.io'
AMBITOS = ' '.join([
    'https://www.googleapis.com/auth/androidpublisher',
    'https://www.googleapis.com/auth/playdeveloperreporting',
    'https://www.googleapis.com/auth/devstorage.read_only',
    'https://www.googleapis.com/auth/analytics.readonly',
])
# Los seis eventos que la app registra (lib/core/analitica.dart)
EVENTOS = ('test_terminado', 'cante_terminado', 'tema_abierto', 'clase_creada', 'preparador_conectado', 'clase_suelta_pedida')

_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


# ------------------------------------------------------------------ Acceso

def _b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b'=').decode()


def token(ambitos=AMBITOS):
    c = json.loads(CLAVE.read_text())
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


class Api:
    def __init__(self):
        self.t = token()

    def pedir(self, url, cuerpo=None, crudo=False):
        for intento in range(4):
            try:
                r = urllib.request.Request(url, json.dumps(cuerpo).encode() if cuerpo is not None else None,
                                           {'Authorization': f'Bearer {self.t}', 'Content-Type': 'application/json'})
                with urllib.request.urlopen(r, timeout=60) as resp:
                    return resp.read() if crudo else json.load(resp)
            except urllib.error.HTTPError:
                raise
            except OSError:
                if intento == 3:
                    raise
                time.sleep(2 * (intento + 1))


def _error(e):
    """Texto corto y útil de un HTTPError de Google."""
    try:
        cuerpo = json.loads(e.read().decode())['error']
        return f"{e.code}: {cuerpo.get('message', '')[:160]}"
    except Exception:
        return f'{e.code}'


# ------------------------------------------------------------- Google Play

def _csv_play(datos):
    """Los CSV de Play Console van en UTF-16 con BOM."""
    for cod in ('utf-16', 'utf-8-sig'):
        try:
            return list(csv.DictReader(io.StringIO(datos.decode(cod))))
        except UnicodeError:
            continue
    return []


def _meses(desde, hasta):
    m = date(desde.year, desde.month, 1)
    while m <= hasta:
        yield f'{m.year}{m.month:02d}'
        m = date(m.year + (m.month == 12), m.month % 12 + 1, 1)


def _entero(s):
    try:
        return int(float(s or 0))
    except ValueError:
        return 0


def play_informes(api, conf, desde, hasta):
    """Instalaciones y valoraciones de los informes mensuales del bucket."""
    bucket, paquete = conf['bucket'], conf.get('paquete', PAQUETE)
    base = f'https://storage.googleapis.com/storage/v1/b/{urllib.parse.quote(bucket, safe="")}/o'
    filas, valoraciones, paises = [], [], Counter()
    for mes in _meses(desde, hasta):
        for carpeta, nombre, destino in (('installs', 'overview', filas), ('ratings', 'overview', valoraciones)):
            objeto = f'stats/{carpeta}/{carpeta}_{paquete}_{mes}_{nombre}.csv'
            try:
                destino += _csv_play(api.pedir(f'{base}/{urllib.parse.quote(objeto, safe="")}?alt=media', crudo=True))
            except urllib.error.HTTPError as e:
                if e.code != 404:
                    raise
        try:
            for f in _csv_play(api.pedir(f'{base}/{urllib.parse.quote(f"stats/installs/installs_{paquete}_{mes}_country.csv", safe="")}?alt=media', crudo=True)):
                if desde.isoformat() <= f.get('Date', '') <= hasta.isoformat():
                    paises[f.get('Country', '?')] += _entero(f.get('Daily User Installs') or f.get('Daily Device Installs'))
        except urllib.error.HTTPError as e:
            if e.code != 404:
                raise
    if not filas:
        return {'pendiente': 'Play Console aún no ha generado informes para este paquete (tardan un día tras la primera instalación), o el bucket no es el de esta cuenta.'}
    filas.sort(key=lambda f: f.get('Date', ''))
    periodo = [f for f in filas if desde.isoformat() <= f.get('Date', '') <= hasta.isoformat()]
    anterior = [f for f in filas if (desde - (hasta - desde) - timedelta(days=1)).isoformat() <= f.get('Date', '') < desde.isoformat()]

    def suma(fs, col):
        return sum(_entero(f.get(col)) for f in fs)

    ultimo = filas[-1]
    r = {
        'fuente': 'informes de Play Console',
        'hasta': ultimo.get('Date'),
        'instalaciones (usuarios)': suma(periodo, 'Daily User Installs'),
        'desinstalaciones (usuarios)': suma(periodo, 'Daily User Uninstalls'),
        'instalaciones periodo anterior': suma(anterior, 'Daily User Installs'),
        'instalaciones acumuladas (usuarios)': _entero(ultimo.get('Total User Installs')),
        'dispositivos activos': _entero(ultimo.get('Active Device Installs')),
        'por día': [[f.get('Date'), _entero(f.get('Daily User Installs')), _entero(f.get('Daily User Uninstalls')),
                     _entero(f.get('Active Device Installs'))] for f in periodo],
        'países': [[p, n] for p, n in paises.most_common(6)],
    }
    if valoraciones:
        valoraciones.sort(key=lambda f: f.get('Date', ''))
        u = valoraciones[-1]
        r['valoración media'] = round(float(u.get('Total Average Rating') or 0), 2) or None
    return r


def play_vitales(api, paquete, desde, hasta):
    """Tasa de fallos y de ANR (Play Developer Reporting API)."""
    base = f'https://playdeveloperreporting.googleapis.com/v1beta1/apps/{paquete}'
    salida = {}
    for conjunto, metricas in (('crashRateMetricSet', ['crashRate', 'userPerceivedCrashRate', 'distinctUsers']),
                               ('anrRateMetricSet', ['anrRate', 'userPerceivedAnrRate', 'distinctUsers'])):
        try:
            frescura = api.pedir(f'{base}/{conjunto}')
            fin = None
            for f in frescura.get('freshnessInfo', {}).get('freshnesses', []):
                if f.get('aggregationPeriod') == 'DAILY':
                    fin = f.get('latestEndTime')
            fin_d = date(fin['year'], fin['month'], fin['day']) if fin else hasta
            ini_d = max(desde, fin_d - timedelta(days=(hasta - desde).days))
            r = api.pedir(f'{base}/{conjunto}:query', {
                'timelineSpec': {'aggregationPeriod': 'DAILY',
                                 'startTime': {'year': ini_d.year, 'month': ini_d.month, 'day': ini_d.day},
                                 'endTime': {'year': fin_d.year, 'month': fin_d.month, 'day': fin_d.day}},
                'metrics': metricas, 'pageSize': 100})
            filas = r.get('rows', [])
            vals = {m: [] for m in metricas}
            for fila in filas:
                for m in fila.get('metrics', []):
                    v = m.get('decimalValue', {}).get('value')
                    if v is not None:
                        vals[m['metric']].append(float(v))
            medias = {m: (round(100 * sum(v) / len(v), 2) if m != 'distinctUsers' else int(sum(v))) for m, v in vals.items() if v}
            salida[conjunto.replace('MetricSet', '')] = {'hasta': fin_d.isoformat(), 'días': len(filas), **medias}
        except urllib.error.HTTPError as e:
            salida[conjunto.replace('MetricSet', '')] = {'pendiente': _error(e)}
    return salida


def play_resenas(api, paquete):
    """Reseñas de la última semana (la API no da más atrás)."""
    try:
        r = api.pedir(f'https://androidpublisher.googleapis.com/androidpublisher/v3/applications/{paquete}/reviews?maxResults=100')
    except urllib.error.HTTPError as e:
        return {'pendiente': _error(e)}
    estrellas = [c.get('userComment', {}).get('starRating') for rv in r.get('reviews', []) for c in rv.get('comments', [])[:1]]
    estrellas = [e for e in estrellas if e]
    return {'última semana': len(estrellas), 'media': round(sum(estrellas) / len(estrellas), 2) if estrellas else None,
            'por estrellas': dict(sorted(Counter(estrellas).items()))}


def play(api, desde, hasta):
    if not PLAY.exists():
        return {'pendiente': f'Falta {PLAY} con el bucket de los informes de Play Console (ver la ayuda del script).'}
    conf = json.loads(PLAY.read_text())
    paquete = conf.get('paquete', PAQUETE)
    r = {}
    try:
        r['informes'] = play_informes(api, conf, desde, hasta)
    except urllib.error.HTTPError as e:
        r['informes'] = {'pendiente': f'Bucket de Play sin acceso ({_error(e)}): invita a la cuenta de servicio en Play Console → Usuarios y permisos.'}
    r['vitales'] = play_vitales(api, paquete, desde, hasta)
    r['reseñas'] = play_resenas(api, paquete)
    return r


# ---------------------------------------------------------------- Analytics

def ga(api, desde, hasta, dimensiones, metricas, filas=15, filtro=None):
    cuerpo = {'dateRanges': [{'startDate': desde.isoformat(), 'endDate': hasta.isoformat()}],
              'dimensions': [{'name': d} for d in dimensiones], 'metrics': [{'name': m} for m in metricas],
              'limit': filas, 'orderBys': [{'metric': {'metricName': metricas[0]}, 'desc': True}]}
    if filtro:
        cuerpo['dimensionFilter'] = filtro
    r = api.pedir(f'https://analyticsdata.googleapis.com/v1beta/properties/{PROPIEDAD_GA_APP}:runReport', cuerpo)
    salida = []
    for f in r.get('rows', []):
        fila = {d: v['value'] for d, v in zip(dimensiones, f.get('dimensionValues', []))}
        for m, v in zip(metricas, f['metricValues']):
            x = float(v['value'])
            fila[m] = round(x, 2) if m in ('averageSessionDuration', 'dauPerMau', 'wauPerMau', 'crashFreeUsersRate') else int(x)
        salida.append(fila)
    return salida


def analytics_app(api, desde, hasta):
    ant_hasta, ant_desde = desde - timedelta(days=1), desde - timedelta(days=(hasta - desde).days + 1)
    try:
        total = (ga(api, desde, hasta, [], ['activeUsers', 'newUsers', 'sessions', 'averageSessionDuration'], 1) or [{}])[0]
        if not total:
            return {'periodo': [desde.isoformat(), hasta.isoformat()],
                    'pendiente': 'Sin datos todavía en la propiedad de Analytics de Firebase: llegan con la 1.18.0 y solo de quien acepta enviar estadísticas.'}
        r = {
            'periodo': [desde.isoformat(), hasta.isoformat()],
            'total': total,
            'total_anterior': (ga(api, ant_desde, ant_hasta, [], ['activeUsers', 'newUsers', 'sessions'], 1) or [{}])[0],
            'plataformas': ga(api, desde, hasta, ['platform'], ['activeUsers', 'sessions'], 5),
            'versiones': ga(api, desde, hasta, ['appVersion'], ['activeUsers'], 8),
            'pantallas': ga(api, desde, hasta, ['unifiedScreenName'], ['screenPageViews', 'activeUsers'], 15),
            'eventos': ga(api, desde, hasta, ['eventName'], ['eventCount', 'activeUsers'], 20,
                          {'filter': {'fieldName': 'eventName', 'inListFilter': {'values': list(EVENTOS)}}}),
            'por día': ga(api, desde, hasta, ['date'], ['activeUsers'], 100),
        }
        r['por día'].sort(key=lambda x: x['date'])
        try:
            r['retención'] = (ga(api, desde, hasta, [], ['dauPerMau', 'wauPerMau'], 1) or [{}])[0]
        except urllib.error.HTTPError:
            pass
        try:
            r['fallos'] = (ga(api, desde, hasta, [], ['crashFreeUsersRate', 'crashAffectedUsers'], 1) or [{}])[0]
        except urllib.error.HTTPError:
            pass
        return r
    except urllib.error.HTTPError as e:
        return {'pendiente': f'Analytics de la app sin acceso ({_error(e)}): la cuenta de servicio necesita el rol Lector en la propiedad {PROPIEDAD_GA_APP}.'}


# ------------------------------------------------------------------- GitHub

def apk_github():
    try:
        r = urllib.request.Request(f'https://api.github.com/repos/{REPO}/releases/tags/app-latest',
                                   headers={'Accept': 'application/vnd.github+json', 'User-Agent': 'estadisticas-app'})
        d = json.load(urllib.request.urlopen(r, timeout=30))
        a = [x for x in d.get('assets', []) if x['name'].endswith('.apk')]
        return {'descargas': sum(x['download_count'] for x in a),
                'subido': max((x['updated_at'][:10] for x in a), default=None)}
    except (urllib.error.URLError, OSError, ValueError) as e:
        return {'pendiente': f'GitHub no responde: {str(e)[:80]}'}


# --------------------------------------------------------------------- Red

def red():
    try:
        p = subprocess.run([sys.executable, str(Path(__file__).with_name('estadisticas-red.py')), '--json'],
                           capture_output=True, text=True, timeout=600)
        if p.returncode:
            return {'pendiente': p.stderr.strip()[-200:]}
        return json.loads(p.stdout)
    except (OSError, ValueError, subprocess.TimeoutExpired) as e:
        return {'pendiente': str(e)[:160]}


# -------------------------------------------------------------------- Foto

def foto(dias):
    hasta = date.today() - timedelta(days=1)
    desde = hasta - timedelta(days=dias - 1)
    api = Api()
    return {
        'fecha': date.today().isoformat(), 'dias': dias, 'periodo': [desde.isoformat(), hasta.isoformat()],
        'play': play(api, desde, hasta),
        'analytics': analytics_app(api, desde, hasta),
        'apk_github': apk_github(),
        'red': red(),
    }


def _n(d, *claves, defecto='—'):
    for k in claves:
        d = d.get(k, {}) if isinstance(d, dict) else {}
    return d if d not in ({}, None) else defecto


def imprimir(f):
    print(f"App — {f['fecha']} · {f['periodo'][0]} a {f['periodo'][1]}")
    p = f['play']
    print('\nGOOGLE PLAY')
    if 'pendiente' in p:
        print('  Pendiente:', p['pendiente'])
    else:
        i = p['informes']
        if 'pendiente' in i:
            print('  Informes pendientes:', i['pendiente'])
        else:
            print(f"  Instalaciones {i['instalaciones (usuarios)']} (antes {i['instalaciones periodo anterior']}) · "
                  f"desinstalaciones {i['desinstalaciones (usuarios)']} · dispositivos activos {i['dispositivos activos']} · "
                  f"acumuladas {i['instalaciones acumuladas (usuarios)']} · valoración {i.get('valoración media', '—')} (hasta {i['hasta']})")
            if i['países']:
                print('  Países: ' + ', '.join(f'{pa} {n}' for pa, n in i['países']))
        for k, v in p['vitales'].items():
            print(f"  {k}: " + (f"pendiente ({v['pendiente']})" if 'pendiente' in v else ', '.join(f'{a} {b}' for a, b in v.items())))
        r = p['reseñas']
        print('  Reseñas: ' + (f"pendiente ({r['pendiente']})" if 'pendiente' in r else f"{r['última semana']} esta semana, media {r['media']}"))
    a = f['analytics']
    print('\nANALYTICS DE LA APP (solo quien acepta enviar estadísticas)')
    if 'pendiente' in a:
        print('  Pendiente:', a['pendiente'])
    else:
        t = a['total']
        print(f"  {t.get('activeUsers', 0)} usuarios ({t.get('newUsers', 0)} nuevos), {t.get('sessions', 0)} sesiones, "
              f"{t.get('averageSessionDuration', 0)} s de media")
        print('  Plataformas: ' + ', '.join(f"{x['platform']} {x['activeUsers']}" for x in a['plataformas']))
        print('  Versiones: ' + ', '.join(f"{x['appVersion']} {x['activeUsers']}" for x in a['versiones']))
        print('  Pantallas: ' + ', '.join(f"{x['unifiedScreenName']} {x['screenPageViews']}" for x in a['pantallas'][:8]))
        print('  Eventos: ' + (', '.join(f"{x['eventName']} {x['eventCount']}" for x in a['eventos']) or 'ninguno'))
        if a.get('retención'):
            print(f"  Retención: DAU/MAU {a['retención'].get('dauPerMau')} · WAU/MAU {a['retención'].get('wauPerMau')}")
        if a.get('fallos'):
            print(f"  Usuarios sin fallos: {a['fallos'].get('crashFreeUsersRate')} % · afectados {a['fallos'].get('crashAffectedUsers')}")
    g = f['apk_github']
    print('\nAPK EN GITHUB (app-latest): ' + (f"pendiente ({g['pendiente']})" if 'pendiente' in g else f"{g['descargas']} descargas (subido el {g['subido']})"))
    r = f['red']
    print('\nRED (Firestore y cuentas)')
    if 'pendiente' in r:
        print('  Pendiente:', r['pendiente'])
    else:
        gl = r.get('global', {})
        print(f"  Cuentas de Google {_n(gl, 'cuentas', 'cuentas de Google (app y web)')} · usan la app {_n(gl, 'personas', 'usan la app')} "
              f"(opositores {_n(gl, 'personas', 'app: opositores')}, preparadores {_n(gl, 'personas', 'app: preparadores')}) · "
              f"activas 7 días {_n(gl, 'personas', 'app: activas últimos 7 días')} · 30 días {_n(gl, 'personas', 'app: activas últimos 30 días')}")
        for op in ('tcee', 'dce'):
            c = r.get(op, {})
            print(f"  {op.upper()}: cuentas {_n(c, 'cuentas', 'total')} (opositores {_n(c, 'cuentas', 'opositores')}, preparadores {_n(c, 'cuentas', 'preparadores')}) · "
                  f"preparadores verificados {_n(c, 'preparadores', 'verificados')} · alumnos conectados {_n(c, 'red', 'alumnos conectados (distintos)')} · "
                  f"clases 30 días {_n(c, 'clases', 'dadas últimos 30 días')} · tests 30 días {_n(c, 'tests', 'últimos 30 días')}")


def main():
    if not CLAVE.exists():
        sys.exit(f'Falta la clave de la cuenta de servicio en {CLAVE} (ver la ayuda del script).')
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
