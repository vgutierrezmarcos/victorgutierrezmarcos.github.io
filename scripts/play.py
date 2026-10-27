#!/usr/bin/env python3
"""Publicar la app en Google Play desde aquí (API Google Play Developer).

    python3 scripts/play.py estado                          # qué versión hay en cada pista
    python3 scripts/play.py subir app.aab [--pistas alpha,production] [--notas "…" | --notas-archivo f.txt]
    python3 scripts/play.py promocionar [--de alpha] [--a production] [--fraccion 0.2]
    python3 scripts/play.py despliegue 0.5                  # producción escalonada: sube el porcentaje
    python3 scripts/play.py despliegue completar | detener | reanudar
    python3 scripts/play.py ficha [--video-clave promo-app | --video URL]
    python3 scripts/play.py resenas [--dias 30]
    python3 scripts/play.py responder ID_RESEÑA "texto"

Pistas: «alpha» es la prueba cerrada (el canal beta: cada versión va primero ahí)
y «production» la de producción. Las notas de la versión van en español (es-ES)
y no pasan de 500 caracteres.

**Nada va a revisión sin permiso de Víctor**: en esta cuenta Google manda a
revisión todo lo que se confirma por API (no admite changesNotSentForReview), así
que sin --enviar cada orden prepara la edición, la valida con Google (AAB, notas,
pistas) y la descarta: es un ensayo. Con --enviar va a revisión, y si ya hay
cambios en revisión da error en vez de cancelarlos.

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

    def confirmar(self, enviar=False):
        """Con enviar, a revisión (sin cancelar nunca lo que ya esté en ella);
        sin enviar, Google valida la edición y se descarta: no cambia nada."""
        if enviar:
            return self.api.pedir('POST', f'{self.url}:commit?changesInReviewBehavior=ERROR_IF_IN_REVIEW')
        self.api.pedir('POST', f'{self.url}:validate')
        self.descartar()

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


def _aviso(enviar):
    return ': enviado a revisión.' if enviar else ': ensayo validado por Google, nada enviado (repite con --enviar).'


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
    pistas = a.pistas.split(',')
    for pista in pistas:
        e.poner_pista(pista, [version])
    e.confirmar(a.enviar)
    print(f'{version["name"]} en {" y ".join(pistas)}' + (' como borrador.' if a.borrador else _aviso(a.enviar)))


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
    e.confirmar(a.enviar)
    fr = f' al {a.fraccion * 100:.0f} % de los usuarios' if nueva['status'] == 'inProgress' else ''
    print(f'{v.get("name")} de {a.de} a {a.a}{fr}' + _aviso(a.enviar))


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
    e.confirmar(a.enviar)
    print(f'{v.get("name")}: {v["status"]}' + (f' al {v["userFraction"] * 100:.0f} %' if 'userFraction' in v else ''))


def ficha(a):
    e = Edicion(Api())
    url = f'{e.url}/listings/{IDIOMA}'
    actual = e.api.pedir('GET', url)
    video = a.video
    if a.video_clave:
        registro = json.loads((Path(__file__).resolve().parent.parent / 'videos.json').read_text())
        v = registro['videos'].get(a.video_clave) or sys.exit(f'No está la clave {a.video_clave} en videos.json')
        video = f'https://www.youtube.com/watch?v={v["youtube"]}'
    if not video:
        e.descartar()
        print(f'Título: {actual.get("title")}\nBreve: {actual.get("shortDescription")}\nVídeo: {actual.get("video") or "ninguno"}')
        return
    e.api.pedir('PATCH', url, {'video': video})
    e.confirmar(a.enviar)
    print(f'Vídeo de la ficha: {actual.get("video") or "ninguno"} → {video}' + _aviso(a.enviar))


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
    o.add_argument('--pistas', default='alpha', help='una o varias, separadas por comas (alpha,production)')
    o.add_argument('--notas')
    o.add_argument('--notas-archivo')
    o.add_argument('--borrador', action='store_true')
    o.add_argument('--enviar', action='store_true', help='mandar a revisión ya (solo con permiso de Víctor)')
    o = s.add_parser('promocionar')
    o.add_argument('--enviar', action='store_true', help='mandar a revisión ya (solo con permiso de Víctor)')
    o.add_argument('--de', default='alpha')
    o.add_argument('--a', default='production')
    o.add_argument('--fraccion', type=float)
    o = s.add_parser('despliegue')
    o.add_argument('orden', help='porcentaje en tanto por uno (0.5), completar, detener o reanudar')
    o.add_argument('--enviar', action='store_true', help='mandar a revisión ya (solo con permiso de Víctor)')
    o = s.add_parser('ficha')
    o.add_argument('--video', help='URL de YouTube')
    o.add_argument('--video-clave', help='clave de videos.json (p. ej. promo-app)')
    o.add_argument('--enviar', action='store_true', help='mandar a revisión ya (solo con permiso de Víctor)')
    s.add_parser('resenas').add_argument('--dias', type=int, default=30)
    o = s.add_parser('responder')
    o.add_argument('id')
    o.add_argument('texto')
    a = p.parse_args()
    {'estado': estado, 'subir': subir, 'promocionar': promocionar, 'despliegue': despliegue, 'ficha': ficha,
     'resenas': resenas, 'responder': responder}[a.orden_](a)


if __name__ == '__main__':
    main()
