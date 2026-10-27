#!/usr/bin/env python3
"""Vídeos en YouTube (no listados) con un registro de claves fijas: videos.json.

La web y la app nunca guardan el ID de YouTube: piden el vídeo por su clave
(p. ej. «3A08-cante», «ayuda-reservar-clase») y videos.json dice qué ID vale hoy.
Como YouTube no deja cambiar el archivo de un vídeo, sustituir es: subir el
nuevo, apuntar la clave al nuevo ID y pasar el viejo a privado. Los privados se
borran después con «purgar», cuando se confirma que el nuevo está bien.

    python3 scripts/youtube.py autorizar                    # una vez: abre el navegador
    python3 scripts/youtube.py subir CLAVE video.mp4 --titulo "…" [--descripcion "…"]
    python3 scripts/youtube.py sustituir CLAVE video.mp4 [--titulo "…"]
    python3 scripts/youtube.py lista
    python3 scripts/youtube.py enlace CLAVE                 # https://youtu.be/…
    python3 scripts/youtube.py comprobar                    # que cada ID exista y siga no listado
    python3 scripts/youtube.py purgar [--dias 7] [--si]     # borra los retirados (sin --si, solo lista)
    python3 scripts/youtube.py quitar CLAVE                 # retira la clave (el vídeo pasa a privado)

Credenciales fuera del repo, en ~/.config/oposicion-red/: youtube-cliente.json
(cliente OAuth «Aplicación de escritorio» del proyecto de Google Cloud, con la API
YouTube Data v3 activada) y youtube-token.json (lo crea «autorizar»). La cuenta
es la del canal (Gmail personal). La pantalla de consentimiento debe estar «En
producción»: en «Prueba» el permiso caduca a los 7 días.

Solo usa la biblioteca estándar.
"""
import argparse
import base64
import hashlib
import http.server
import json
import os
import secrets
import subprocess
import sys
import threading
import time
import urllib.error
import urllib.parse
import urllib.request
from datetime import date, timedelta
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
REGISTRO = RAIZ / 'videos.json'
CONFIG = Path.home() / '.config/oposicion-red'
CLIENTE = CONFIG / 'youtube-cliente.json'
TOKEN = CONFIG / 'youtube-token.json'
# Analytics, de solo lectura, para el informe mensual (/informe-web)
AMBITO = 'https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/yt-analytics.readonly'
API = 'https://www.googleapis.com/youtube/v3'
TROZO = 8 * 1024 * 1024  # múltiplo de 256 KiB, como pide la subida reanudable

# Detrás del proxy del trabajo (intercepta TLS): ver estadisticas-red.py
_CAS = CONFIG / 'cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)


# ------------------------------------------------------------------ Acceso

def _cliente():
    if not CLIENTE.exists():
        sys.exit(f'Falta {CLIENTE}: descarga el JSON del cliente OAuth (Aplicación de escritorio).')
    c = json.loads(CLIENTE.read_text())
    return c.get('installed') or c.get('web') or c


def autorizar():
    c = _cliente()
    verificador = secrets.token_urlsafe(64)
    reto = base64.urlsafe_b64encode(hashlib.sha256(verificador.encode()).digest()).rstrip(b'=').decode()
    estado = secrets.token_urlsafe(16)
    recibido = {}

    class Manejador(http.server.BaseHTTPRequestHandler):
        def do_GET(self):
            q = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
            if 'code' not in q and 'error' not in q:
                self.send_response(404)
                self.end_headers()
                return
            recibido.update({k: v[0] for k, v in q.items()})
            self.send_response(200)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.end_headers()
            self.wfile.write('<p>Listo: ya puedes cerrar esta pestaña y volver a la terminal.</p>'.encode())

        def log_message(self, *a):
            pass

    servidor = http.server.HTTPServer(('127.0.0.1', 0), Manejador)
    redireccion = f'http://127.0.0.1:{servidor.server_port}/'
    url = 'https://accounts.google.com/o/oauth2/v2/auth?' + urllib.parse.urlencode({
        'client_id': c['client_id'], 'redirect_uri': redireccion, 'response_type': 'code',
        'scope': AMBITO, 'access_type': 'offline', 'prompt': 'consent', 'state': estado,
        'code_challenge': reto, 'code_challenge_method': 'S256'})
    print('Abre este enlace con la cuenta del canal (Gmail personal) y acepta:\n\n' + url + '\n')
    try:  # desde WSL, el navegador de Windows
        subprocess.run(['cmd.exe', '/c', 'start', '', url.replace('&', '^&')], capture_output=True, timeout=10)
    except (OSError, subprocess.SubprocessError):
        pass
    hilo = threading.Thread(target=lambda: [servidor.handle_request() for _ in range(5) if not recibido], daemon=True)
    hilo.start()
    hilo.join(600)
    servidor.server_close()
    if recibido.get('state') != estado or 'code' not in recibido:
        sys.exit(f'No llegó la autorización: {recibido.get("error", "sin respuesta")}')
    datos = urllib.parse.urlencode({
        'code': recibido['code'], 'client_id': c['client_id'], 'client_secret': c.get('client_secret', ''),
        'redirect_uri': redireccion, 'grant_type': 'authorization_code', 'code_verifier': verificador}).encode()
    t = json.load(urllib.request.urlopen(c.get('token_uri', 'https://oauth2.googleapis.com/token'), datos, timeout=30))
    if 'refresh_token' not in t:
        sys.exit('Google no devolvió refresh_token: quita el acceso en myaccount.google.com/permissions y repite.')
    CONFIG.mkdir(parents=True, exist_ok=True)
    TOKEN.write_text(json.dumps({'refresh_token': t['refresh_token']}))
    TOKEN.chmod(0o600)
    canal = Api().get('channels', part='snippet', mine='true')['items'][0]['snippet']['title']
    print(f'Autorizado. Canal: {canal}')


class Api:
    def __init__(self):
        if not TOKEN.exists():
            sys.exit('Sin autorizar: python3 scripts/youtube.py autorizar')
        c = _cliente()
        datos = urllib.parse.urlencode({
            'client_id': c['client_id'], 'client_secret': c.get('client_secret', ''),
            'refresh_token': json.loads(TOKEN.read_text())['refresh_token'], 'grant_type': 'refresh_token'}).encode()
        try:
            self.t = json.load(urllib.request.urlopen(c.get('token_uri', 'https://oauth2.googleapis.com/token'),
                                                      datos, timeout=30))['access_token']
        except urllib.error.HTTPError as e:
            sys.exit(f'El permiso ha caducado o se ha retirado ({e.code}): python3 scripts/youtube.py autorizar')

    def _pedir(self, metodo, url, cuerpo=None, cabeceras=None):
        c = {'Authorization': f'Bearer {self.t}', **(cabeceras or {})}
        if isinstance(cuerpo, (dict, list)):
            cuerpo = json.dumps(cuerpo).encode()
            c['Content-Type'] = 'application/json; charset=UTF-8'
        return urllib.request.urlopen(urllib.request.Request(url, cuerpo, c, method=metodo), timeout=120)

    def get(self, recurso, **q):
        return json.load(self._pedir('GET', f'{API}/{recurso}?' + urllib.parse.urlencode(q)))

    def put(self, recurso, cuerpo, **q):
        return json.load(self._pedir('PUT', f'{API}/{recurso}?' + urllib.parse.urlencode(q), cuerpo))

    def delete(self, recurso, **q):
        self._pedir('DELETE', f'{API}/{recurso}?' + urllib.parse.urlencode(q))

    def subir(self, archivo, titulo, descripcion):
        tam = archivo.stat().st_size
        meta = {
            'snippet': {'title': titulo[:100], 'description': descripcion[:5000], 'categoryId': '27',
                        'defaultLanguage': 'es', 'defaultAudioLanguage': 'es'},
            'status': {'privacyStatus': 'unlisted', 'selfDeclaredMadeForKids': False, 'embeddable': True},
        }
        r = self._pedir('POST', 'https://www.googleapis.com/upload/youtube/v3/videos?uploadType=resumable&part=snippet,status',
                        meta, {'X-Upload-Content-Length': str(tam), 'X-Upload-Content-Type': 'video/mp4'})
        sesion = r.headers['Location']
        hecho, fallos = 0, 0
        with archivo.open('rb') as f:
            while True:
                try:
                    f.seek(hecho)
                    trozo = f.read(TROZO)
                    fin = hecho + len(trozo) - 1
                    r = self._pedir('PUT', sesion, trozo, {'Content-Range': f'bytes {hecho}-{fin}/{tam}'})
                    print(f'\r  subido 100 %{" " * 10}')
                    return json.load(r)['id']
                except urllib.error.HTTPError as e:
                    if e.code == 308:  # trozo recibido, falta el resto
                        rango = e.headers.get('Range')
                        hecho = int(rango.split('-')[1]) + 1 if rango else 0
                        fallos = 0
                        print(f'\r  subido {100 * hecho // tam} %', end='', flush=True)
                        continue
                    if e.code < 500:
                        raise
                    error = e
                except OSError as e:
                    error = e
                fallos += 1
                if fallos > 6:
                    raise error
                time.sleep(2 ** fallos)
                hecho = self._recibido(sesion, tam)

    def _recibido(self, sesion, tam):
        try:
            self._pedir('PUT', sesion, b'', {'Content-Range': f'bytes */{tam}'})
        except urllib.error.HTTPError as e:
            if e.code == 308:
                rango = e.headers.get('Range')
                return int(rango.split('-')[1]) + 1 if rango else 0
            raise
        return tam

    def privado(self, vid):
        v = self.get('videos', part='status', id=vid)['items']
        if not v:
            return False
        estado = v[0]['status']
        estado['privacyStatus'] = 'private'
        self.put('videos', {'id': vid, 'status': estado}, part='status')
        return True

    def retocar(self, vid, titulo=None, descripcion=None):
        s = self.get('videos', part='snippet', id=vid)['items'][0]['snippet']
        s = {k: s[k] for k in ('title', 'description', 'categoryId', 'defaultLanguage', 'tags') if k in s}
        if titulo:
            s['title'] = titulo[:100]
        if descripcion is not None:
            s['description'] = descripcion[:5000]
        self.put('videos', {'id': vid, 'snippet': s}, part='snippet')


# ----------------------------------------------------------------- Registro

def leer():
    if REGISTRO.exists():
        return json.loads(REGISTRO.read_text())
    return {'videos': {}, 'retirados': []}


def guardar(r):
    r['videos'] = dict(sorted(r['videos'].items()))
    r['actualizado'] = date.today().isoformat()
    REGISTRO.write_text(json.dumps({'actualizado': r['actualizado'], 'videos': r['videos'],
                                    'retirados': r['retirados']}, ensure_ascii=False, indent=2) + '\n')


def huella(archivo):
    h = hashlib.sha256()
    with archivo.open('rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


# ---------------------------------------------------------------- Órdenes

def subir(a, sustituir):
    archivo = Path(a.archivo)
    if not archivo.is_file():
        sys.exit(f'No existe {archivo}')
    r = leer()
    viejo = r['videos'].get(a.clave)
    if viejo and not sustituir:
        sys.exit(f'La clave {a.clave} ya existe ({viejo["youtube"]}): usa «sustituir».')
    if sustituir and not viejo:
        sys.exit(f'La clave {a.clave} no existe: usa «subir».')
    sha = huella(archivo)
    if viejo and viejo.get('sha256') == sha:
        sys.exit(f'{archivo.name} es idéntico al que ya está subido: nada que hacer.')
    titulo = a.titulo or (viejo or {}).get('titulo')
    if not titulo:
        sys.exit('Falta --titulo')
    descripcion = a.descripcion if a.descripcion is not None else (viejo or {}).get('descripcion', '')
    api = Api()
    print(f'Subiendo {archivo.name} ({archivo.stat().st_size / 1e6:.0f} MB) como no listado…')
    vid = api.subir(archivo, titulo, descripcion)
    r['videos'][a.clave] = {'youtube': vid, 'titulo': titulo, 'descripcion': descripcion,
                            'archivo': archivo.name, 'sha256': sha, 'subido': date.today().isoformat(),
                            'version': (viejo or {}).get('version', 0) + 1}
    if viejo:
        api.privado(viejo['youtube'])
        r['retirados'].append({'clave': a.clave, 'youtube': viejo['youtube'], 'retirado': date.today().isoformat(),
                               'sustituido_por': vid})
    guardar(r)
    print(f'{a.clave} → https://youtu.be/{vid}' + (f' (el anterior, {viejo["youtube"]}, queda privado)' if viejo else ''))
    print('YouTube tarda unos minutos en procesarlo. Haz commit de videos.json para que la web y la app lo vean.')


def lista(_):
    r = leer()
    for k, v in r['videos'].items():
        print(f'{k:32} {v["youtube"]:12} v{v["version"]}  {v["subido"]}  {v["titulo"]}')
    if r['retirados']:
        print(f'\n{len(r["retirados"])} retirado(s) pendiente(s) de borrar: «purgar» para verlos.')


def enlace(a):
    v = leer()['videos'].get(a.clave) or sys.exit(f'No existe la clave {a.clave}')
    print(f'https://youtu.be/{v["youtube"]}')


def comprobar(_):
    r = leer()
    ids = [v['youtube'] for v in r['videos'].values()]
    api, estado = Api(), {}
    for i in range(0, len(ids), 50):
        for it in api.get('videos', part='status', id=','.join(ids[i:i + 50]))['items']:
            estado[it['id']] = it['status']
    malos = 0
    for k, v in r['videos'].items():
        s = estado.get(v['youtube'])
        if s and s['uploadStatus'] == 'uploaded':  # YouTube aún lo está procesando
            print(f'PROCESANDO {k} ({v["youtube"]}): repite «comprobar» en unos minutos')
            continue
        problema = ('no existe' if not s else
                    f'está {s["privacyStatus"]}' if s['privacyStatus'] != 'unlisted' else
                    f'procesado: {s["uploadStatus"]}' if s['uploadStatus'] != 'processed' else
                    'no se puede insertar' if not s.get('embeddable', True) else '')
        if problema:
            malos += 1
            print(f'FALLA {k} ({v["youtube"]}): {problema}')
    print(f'{len(ids) - malos} de {len(ids)} vídeos bien.')
    sys.exit(1 if malos else 0)


def purgar(a):
    r = leer()
    limite = date.today() - timedelta(days=a.dias)
    viejos = [x for x in r['retirados'] if date.fromisoformat(x['retirado']) <= limite]
    if not viejos:
        print(f'Ningún retirado con más de {a.dias} días.')
        return
    for x in viejos:
        print(f'{"Borrando" if a.si else "Se borraría"} {x["youtube"]} ({x["clave"]}, retirado el {x["retirado"]})')
    if not a.si:
        print('\nNada borrado. Repite con --si para borrarlos de YouTube (no se puede deshacer).')
        return
    api = Api()
    for x in viejos:
        try:
            api.delete('videos', id=x['youtube'])
        except urllib.error.HTTPError as e:
            if e.code != 404:
                raise
        r['retirados'].remove(x)
        guardar(r)


def quitar(a):
    r = leer()
    v = r['videos'].pop(a.clave, None) or sys.exit(f'No existe la clave {a.clave}')
    Api().privado(v['youtube'])
    r['retirados'].append({'clave': a.clave, 'youtube': v['youtube'], 'retirado': date.today().isoformat(),
                           'sustituido_por': None})
    guardar(r)
    print(f'{a.clave} retirada; {v["youtube"]} queda privado hasta «purgar».')


def retocar(a):
    r = leer()
    v = r['videos'].get(a.clave) or sys.exit(f'No existe la clave {a.clave}')
    Api().retocar(v['youtube'], a.titulo, a.descripcion)
    if a.titulo:
        v['titulo'] = a.titulo
    if a.descripcion is not None:
        v['descripcion'] = a.descripcion
    guardar(r)
    print(f'{a.clave}: título y descripción cambiados sin tocar el vídeo.')


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    s = p.add_subparsers(dest='orden', required=True)
    s.add_parser('autorizar')
    for nombre in ('subir', 'sustituir'):
        o = s.add_parser(nombre)
        o.add_argument('clave')
        o.add_argument('archivo')
        o.add_argument('--titulo')
        o.add_argument('--descripcion')
    o = s.add_parser('retocar', help='cambia título o descripción sin subir de nuevo')
    o.add_argument('clave')
    o.add_argument('--titulo')
    o.add_argument('--descripcion')
    s.add_parser('lista')
    s.add_parser('enlace').add_argument('clave')
    s.add_parser('comprobar')
    o = s.add_parser('purgar')
    o.add_argument('--dias', type=int, default=7)
    o.add_argument('--si', action='store_true')
    s.add_parser('quitar').add_argument('clave')
    a = p.parse_args()
    {'autorizar': lambda _: autorizar(), 'subir': lambda a: subir(a, False), 'sustituir': lambda a: subir(a, True),
     'retocar': retocar, 'lista': lista, 'enlace': enlace, 'comprobar': comprobar, 'purgar': purgar,
     'quitar': quitar}[a.orden](a)


if __name__ == '__main__':
    main()
