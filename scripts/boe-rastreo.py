#!/usr/bin/env python3
"""Rastrea los sumarios diarios del BOE (API de datos abiertos) y guarda los
anuncios del Cuerpo Superior de Técnicos Comerciales y Economistas del Estado
(convocatorias, relaciones de aprobados, nombramientos) para cifras-oposicion.py.

    python3 scripts/boe-rastreo.py [AÑO_INICIO [AÑO_FIN]]

Sin argumentos, desde 2008 hasta hoy en ~/.local/share/oposicion-web/cifras/boe/anuncios.json;
con dos años, ese tramo en anuncios-INICIO-FIN.json (se pueden lanzar varios tramos a la
vez). Es reanudable: guarda cada 50 días los días ya leídos. Un día sin BOE da 404.
Autor: Víctor Gutiérrez Marcos."""
import json, os, ssl, sys, time, urllib.request
from datetime import date, timedelta

SUFIJO = ('-' + sys.argv[1] + '-' + sys.argv[2]) if len(sys.argv) > 2 else ''
SALIDA = os.path.expanduser(f'~/.local/share/oposicion-web/cifras/boe/anuncios{SUFIJO}.json')
os.makedirs(os.path.dirname(SALIDA), exist_ok=True)
ctx = ssl.create_default_context(cafile=os.path.expanduser('~/.config/oposicion-red/cas.pem'))
estado = json.load(open(SALIDA, encoding='utf-8')) if os.path.exists(SALIDA) else {'hecho': [], 'anuncios': []}
hechos = set(estado['hecho'])
vistos = {a['id'] for a in estado['anuncios']}

def recorrer(nodo, ruta, fecha, out):
    if isinstance(nodo, dict):
        nombre = nodo.get('nombre', '')
        ruta2 = ruta + [nombre] if nombre else ruta
        if 'Comerciales y Economistas del Estado' in nombre or 'Comerciales y Economistas del Estado' in json.dumps(nodo.get('item', ''), ensure_ascii=False):
            items = nodo.get('item', [])
            if isinstance(items, dict): items = [items]
            for it in items:
                out.append({'id': it.get('identificador'), 'fecha': fecha, 'seccion': ' / '.join(ruta2[-3:]), 'titulo': it.get('titulo', ''),
                            'url_xml': (it.get('url_xml') or ''), 'url_html': (it.get('url_html') or '')})
            return
        for v in nodo.values():
            recorrer(v, ruta2, fecha, out)
    elif isinstance(nodo, list):
        for v in nodo:
            recorrer(v, ruta, fecha, out)

inicio = date(int(sys.argv[1]) if len(sys.argv) > 1 else 2008, 1, 1)
fin = date(int(sys.argv[2]), 12, 31) if len(sys.argv) > 2 else date.today()
d = inicio
n = 0
t0 = time.time()
while d <= fin:
    k = d.strftime('%Y%m%d')
    if k not in hechos:
        for intento in range(3):
            try:
                pet = urllib.request.Request(f'https://www.boe.es/datosabiertos/api/boe/sumario/{k}', headers={'Accept': 'application/json', 'User-Agent': 'Mozilla/5.0'})
                with urllib.request.urlopen(pet, context=ctx, timeout=40) as r:
                    cuerpo = r.read()
                datos = json.loads(cuerpo)
                out = []
                recorrer(datos.get('data', {}), [], k, out)
                for a in out:
                    if a['id'] and a['id'] not in vistos:
                        vistos.add(a['id']); estado['anuncios'].append(a)
                hechos.add(k); estado['hecho'].append(k)
                break
            except urllib.error.HTTPError as e:
                if e.code == 404:  # día sin BOE (domingos, festivos)
                    hechos.add(k); estado['hecho'].append(k); break
                time.sleep(3)
            except Exception:
                time.sleep(3)
        n += 1
        if n % 50 == 0:
            json.dump(estado, open(SALIDA, 'w', encoding='utf-8'), ensure_ascii=False, indent=0)
            print(k, len(estado['anuncios']), 'anuncios', f'{time.time() - t0:.0f}s', flush=True)
        time.sleep(0.15)
    d += timedelta(days=1)
json.dump(estado, open(SALIDA, 'w', encoding='utf-8'), ensure_ascii=False, indent=0)
print('FIN', len(estado['anuncios']), 'anuncios')
