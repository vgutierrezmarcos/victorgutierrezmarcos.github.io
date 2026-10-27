#!/usr/bin/env python3
"""Publicar la app en Google Play desde aquí (API Google Play Developer).

    python3 scripts/play.py estado                          # qué versión hay en cada pista
    python3 scripts/play.py subir app.aab [--pista alpha] [--notas "…" | --notas-archivo f.txt]
    python3 scripts/play.py promocionar [--de alpha] [--a production] [--fraccion 0.2]
    python3 scripts/play.py despliegue 0.5                  # producción escalonada: sube el porcentaje
    python3 scripts/play.py despliegue completar | detener | reanudar
    python3 scripts/play.py resenas [--dias 30]
    python3 scripts/play.py responder ID_RESEÑA "texto"

Pistas: «alpha» es la prueba cerrada (el canal beta: cada versión va primero ahí)
y «production» la de producción. Cada cambio se confirma (commit) en el acto y
Google lo manda a revisión; las notas de la versión van en español (es-ES) y no
pasan de 500 caracteres.

Clave: la de la cuenta de servicio estadisticas-lectura@web-vgm (la de
estadisticas-app.py), en ~/.config/oposicion-red/clave.json o $ESTADISTICAS_CLAVE,
con permisos en Play Console → Usuarios y permisos para publicar en las pistas de
prueba y de producción, gestionar la presencia en Play Store y responder reseñas.
Lo que Google no deja hacer por API (formularios de Contenido de la app, políticas,
pagos) sigue siendo en la consola.

Solo usa la biblioteca estándar y `openssl` (para firmar el token).
"""
import argparse
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
from datetime import datetime, timedelta, timezone
from pathlib import Path

CLAVE = Path(os.environ.get('ESTADISTICAS_CLAVE', Path.home() / '.config/oposicion-red/clave.json'))
PAQUETE = 'es.victorgutierrezmarcos.tcee_app'
API = f'https://androidpublisher.googleapis.com/androidpublisher/v3/applications/{PAQUETE}'
SUBIDA = f'https://androidpublisher.googleapis.com/upload/androidpublisher/v3/applications/{PAQUETE}'
IDIOMA = 'es-ES'

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
    cuerpo = _b64(json.dumps({'iss': c['client_email'], 'scope': 'https://www.googleapis.com/auth/androidpublisher',
                              'aud': c['token_uri'], 'iat': ahora, 'exp': ahora + 3600}).encode())
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

    def pedir(self, metodo, url, cuerpo=None, tipo='application/json', espera=120):
        if isinstance(cuerpo, (dict, list)):
            cuerpo = json.dumps(cuerpo).encode()
        r = urllib.request.Request(url, cuerpo, {'Authorization': f'Bearer {self.t}', 'Content-Type': tipo}, method=metodo)
        try:
            with urllib.request.urlopen(r, timeout=espera) as resp:
                datos = resp.read()
                return json.loads(datos) if datos else {}
        except urllib.error.HTTPError as e:
            try:
                msg = json.loads(e.read().decode())['error'].get('message', '')
            except Exception:
                msg = ''
            sys.exit(f'Google Play respondió {e.code}: {msg}'
                     + ('\n(La cuenta de servicio no tiene ese permiso en Play Console → Usuarios y permisos.)' if e.code in (401, 403) else ''))


class Edicion:
    """Una edición de Play: los cambios se hacen dentro y se confirman juntos."""

    def __init__(self, api):
        self.api = api
        self.id = api.pedir('POST', f'{API}/edits', {})['id']
        self.url = f'{API}/edits/{self.id}'

    def pista(self, nombre):
        return self.api.pedir('GET', f'{self.url}/tracks/{nombre}')

    def poner_pista(self, nombre, versiones):
        return self.api.pedir('PUT', f'{self.url}/tracks/{nombre}', {'track': nombre, 'releases': versiones})

    def subir(self, aab):
        return self.api.pedir('POST', f'{SUBIDA}/edits/{self.id}/bundles?uploadType=media', aab.read_bytes(),
                              'application/octet-stream', espera=900)['versionCode']

    def confirmar(self):
        return self.api.pedir('POST', f'{self.url}:commit')

    def descartar(self):
        self.api.pedir('DELETE', self.url)


# ---------------------------------------------------------------- Órdenes

def _vigente(pista):
    """La versión que manda en una pista: la última no borrador."""
    vs = [v for v in pista.get('releases', []) if v.get('status') != 'draft']
    return vs[0] if vs else None


def _notas(a):
    texto = Path(a.notas_archivo).read_text(encoding='utf-8').strip() if a.notas_archivo else (a.notas or '').strip()
    if len(texto) > 500:
        sys.exit(f'Las notas tienen {len(texto)} caracteres: Play admite 500.')
    return [{'language': IDIOMA, 'text': texto}] if texto else None


def estado(_):
    e = Edicion(Api())
    try:
        for p in e.api.pedir('GET', f'{e.url}/tracks').get('tracks', []):
            print(f'— {p["track"]}')
            for v in p.get('releases', []):
                fr = f' al {v["userFraction"] * 100:.0f} %' if 'userFraction' in v else ''
                print(f'    {v.get("name", "?")}  códigos {",".join(v.get("versionCodes", []))}  {v["status"]}{fr}')
    finally:
        e.descartar()


def subir(a):
    aab = Path(a.aab)
    if not aab.is_file():
        sys.exit(f'No existe {aab}')
    e = Edicion(Api())
    print(f'Subiendo {aab.name} ({aab.stat().st_size / 1e6:.0f} MB)…')
    codigo = e.subir(aab)
    m = re.search(r'(\d+\.\d+\.\d+)', aab.name)
    version = {'name': f'{m.group(1)} ({codigo})' if m else str(codigo), 'versionCodes': [str(codigo)],
               'status': 'draft' if a.borrador else 'completed'}
    if notas := _notas(a):
        version['releaseNotes'] = notas
    e.poner_pista(a.pista, [version])
    e.confirmar()
    print(f'{version["name"]} en la pista {a.pista}' + (' como borrador.' if a.borrador else '; Google la revisa ahora.'))


def promocionar(a):
    e = Edicion(Api())
    v = _vigente(e.pista(a.de))
    if not v:
        e.descartar()
        sys.exit(f'No hay ninguna versión en {a.de}.')
    nueva = {k: v[k] for k in ('name', 'versionCodes', 'releaseNotes') if k in v}
    if a.fraccion and a.fraccion < 1:
        nueva.update(status='inProgress', userFraction=a.fraccion)
    else:
        nueva['status'] = 'completed'
    e.poner_pista(a.a, [nueva])
    e.confirmar()
    fr = f' al {a.fraccion * 100:.0f} % de los usuarios' if nueva['status'] == 'inProgress' else ''
    print(f'{v.get("name")} de {a.de} a {a.a}{fr}; Google la revisa ahora.')


def despliegue(a):
    e = Edicion(Api())
    pista = e.pista('production')
    v = next((x for x in pista.get('releases', []) if x['status'] in ('inProgress', 'halted')), None)
    if not v:
        e.descartar()
        sys.exit('No hay ninguna versión escalonada en producción.')
    if a.orden == 'completar':
        v.pop('userFraction', None)
        v['status'] = 'completed'
    elif a.orden == 'detener':
        v['status'] = 'halted'
    elif a.orden == 'reanudar':
        v['status'] = 'inProgress'
    else:
        v.update(status='inProgress', userFraction=float(a.orden))
    e.poner_pista('production', pista['releases'])
    e.confirmar()
    print(f'{v.get("name")}: {v["status"]}' + (f' al {v["userFraction"] * 100:.0f} %' if 'userFraction' in v else ''))


def resenas(a):
    api = Api()
    desde = datetime.now(timezone.utc) - timedelta(days=a.dias)
    for r in api.pedir('GET', f'{API}/reviews?maxResults=100').get('reviews', []):
        c = r['comments'][0]['userComment']
        cuando = datetime.fromtimestamp(int(c['lastModified']['seconds']), timezone.utc)
        if cuando < desde:
            continue
        respondida = any('developerComment' in x for x in r['comments'])
        print(f'{r["reviewId"]}  {"★" * c["starRating"]}{"☆" * (5 - c["starRating"])}  {cuando:%d/%m/%Y}'
              f'  {c.get("appVersionName", "")}{"  (respondida)" if respondida else ""}\n    {c["text"].strip()}')


def responder(a):
    if len(a.texto) > 350:
        sys.exit(f'La respuesta tiene {len(a.texto)} caracteres: Play admite 350.')
    Api().pedir('POST', f'{API}/reviews/{a.id}:reply', {'replyText': a.texto})
    print('Respuesta publicada.')


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    s = p.add_subparsers(dest='orden_', required=True)
    s.add_parser('estado')
    o = s.add_parser('subir')
    o.add_argument('aab')
    o.add_argument('--pista', default='alpha')
    o.add_argument('--notas')
    o.add_argument('--notas-archivo')
    o.add_argument('--borrador', action='store_true')
    o = s.add_parser('promocionar')
    o.add_argument('--de', default='alpha')
    o.add_argument('--a', default='production')
    o.add_argument('--fraccion', type=float)
    s.add_parser('despliegue').add_argument('orden', help='porcentaje en tanto por uno (0.5), completar, detener o reanudar')
    s.add_parser('resenas').add_argument('--dias', type=int, default=30)
    o = s.add_parser('responder')
    o.add_argument('id')
    o.add_argument('texto')
    a = p.parse_args()
    {'estado': estado, 'subir': subir, 'promocionar': promocionar, 'despliegue': despliegue,
     'resenas': resenas, 'responder': responder}[a.orden_](a)


if __name__ == '__main__':
    main()
