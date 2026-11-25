#!/usr/bin/env python3
"""Uso del conector EconomIA por IA y por herramienta (solo cifras agregadas y anónimas).

Lee el conjunto «analytics_mcp» de Workers Analytics Engine (lo escribe el Worker en cada
llamada: herramienta, IA cliente, oposición, ok/error y milisegundos; sin usuario ni texto)
con la API SQL de Cloudflare. Para el informe mensual (/informe-web): qué IA usan los
opositores, cuánto falla cada herramienta en cada una y si alguna IA empieza a ir peor.

    python3 scripts/estadisticas-conector.py            # tabla
    python3 scripts/estadisticas-conector.py --json     # para informe-web.py
    python3 scripts/estadisticas-conector.py --dias 90

Token: ~/.config/oposicion-red/cloudflare.token (el de wrangler). En la red del Ministerio,
el certificado del proxy de ~/.config/oposicion-red/cas.pem.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import ssl
import sys
import time
import urllib.request

CONFIG = os.path.expanduser('~/.config/oposicion-red')
API = 'https://api.cloudflare.com/client/v4'
CONJUNTO = 'analytics_mcp'


def contexto():
    cas = os.path.join(CONFIG, 'cas.pem')
    return ssl.create_default_context(cafile=cas) if os.path.exists(cas) else ssl.create_default_context()


def pedir(url, token, datos=None):
    error = None
    for _ in range(4):
        try:
            r = urllib.request.Request(url, data=datos, headers={'Authorization': f'Bearer {token}'})
            return urllib.request.urlopen(r, timeout=60, context=contexto()).read().decode()
        except urllib.error.HTTPError as e:
            sys.exit(f'Cloudflare respondió {e.code}: {e.read().decode()[:300]}')
        except Exception as e:  # la red del Ministerio corta a veces
            error = e
            time.sleep(3)
    sys.exit(f'No se pudo hablar con Cloudflare: {error}')


def consulta(token, cuenta, sql):
    return json.loads(pedir(f'{API}/accounts/{cuenta}/analytics_engine/sql', token, sql.encode())).get('data', [])


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    p.add_argument('--dias', type=int, default=30)
    p.add_argument('--json', action='store_true')
    a = p.parse_args()
    token = open(os.path.join(CONFIG, 'cloudflare.token')).read().strip()
    cuenta = json.loads(pedir(f'{API}/accounts', token))['result'][0]['id']
    filtro = f"timestamp > NOW() - INTERVAL '{a.dias}' DAY AND index1 != 'senal'"
    por_ia = consulta(token, cuenta, f"SELECT blob2 AS ia, blob4 AS resultado, SUM(_sample_interval) AS n FROM {CONJUNTO} WHERE {filtro} GROUP BY ia, resultado")
    por_herr = consulta(token, cuenta, f"SELECT blob1 AS herramienta, blob2 AS ia, blob4 AS resultado, SUM(_sample_interval) AS n, AVG(double1) AS ms FROM {CONJUNTO} WHERE {filtro} GROUP BY herramienta, ia, resultado")
    ias = {}
    for f in por_ia:
        d = ias.setdefault(f['ia'] or '(sin nombre)', {'llamadas': 0, 'errores': 0})
        d['llamadas'] += int(f['n'])
        d['errores'] += int(f['n']) if f['resultado'] == 'error' else 0
    for d in ias.values():
        d['tasaError'] = round(100 * d['errores'] / d['llamadas'], 1) if d['llamadas'] else 0
    herr = {}
    for f in por_herr:
        d = herr.setdefault(f['herramienta'], {'llamadas': 0, 'errores': 0, 'porIa': {}})
        n = int(f['n'])
        d['llamadas'] += n
        d['errores'] += n if f['resultado'] == 'error' else 0
        e = d['porIa'].setdefault(f['ia'] or '(sin nombre)', {'llamadas': 0, 'errores': 0})
        e['llamadas'] += n
        e['errores'] += n if f['resultado'] == 'error' else 0
    peores = sorted(((k, v) for k, v in herr.items() if v['llamadas'] >= 5), key=lambda kv: -kv[1]['errores'] / kv[1]['llamadas'])[:8]
    salida = {'dias': a.dias, 'porIa': dict(sorted(ias.items(), key=lambda kv: -kv[1]['llamadas'])),
              'herramientas': len(herr), 'masUsadas': sorted(((k, v['llamadas']) for k, v in herr.items()), key=lambda kv: -kv[1])[:10],
              'conMasErrores': [{'herramienta': k, 'llamadas': v['llamadas'], 'errores': v['errores'], 'porIa': v['porIa']} for k, v in peores if v['errores']]}
    if a.json:
        print(json.dumps(salida, ensure_ascii=False, indent=1))
        return
    print(f'Conector, últimos {a.dias} días')
    for ia, d in salida['porIa'].items():
        print(f'  {ia:22} {d["llamadas"]:6} llamadas · {d["tasaError"]:5} % con error')
    print('Herramientas con más errores:')
    for f in salida['conMasErrores']:
        print(f'  {f["herramienta"]:24} {f["errores"]}/{f["llamadas"]}  ' + ', '.join(f'{ia} {e["errores"]}/{e["llamadas"]}' for ia, e in f['porIa'].items()))


if __name__ == '__main__':
    main()
