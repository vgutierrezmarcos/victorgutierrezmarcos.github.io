#!/usr/bin/env python3
"""Manda por push (Firebase Cloud Messaging) los documentos nuevos del proceso
selectivo que ha encontrado `leer-proceso.py --novedades`.

Un mensaje por oposición al tema `proceso_{op}` (`proceso_tcee`,
`proceso_dce`), al que se suscribe la app de quien tiene activados los avisos
de esa oposición. Es un mensaje de datos (sin notificación): la app decide si
avisa y no repite lo que ya avisó la comprobación periódica.

    FCM_CUENTA_SERVICIO='{...json de la cuenta de servicio...}' \\
        python3 scripts/enviar-push-proceso.py novedades.json

Sin dependencias: el JWT de la cuenta de servicio se firma con openssl.
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
from pathlib import Path

ALCANCE = 'https://www.googleapis.com/auth/firebase.messaging'
# FCM admite hasta 4 KB de datos: se recortan los títulos y, si hacen falta,
# se mandan menos documentos (la app avisa de todos con un resumen si son más de tres).
MAX_DATOS = 3500
MAX_DOCS = 12


def b64(x):
    return base64.urlsafe_b64encode(x).rstrip(b'=').decode()


def token_acceso(cuenta):
    """Token OAuth de la cuenta de servicio (JWT firmado con su clave)."""
    ahora = int(time.time())
    cabecera = b64(json.dumps({'alg': 'RS256', 'typ': 'JWT'}).encode())
    cuerpo = b64(json.dumps({'iss': cuenta['client_email'], 'scope': ALCANCE, 'aud': cuenta['token_uri'], 'iat': ahora, 'exp': ahora + 3600}).encode())
    firmar = f'{cabecera}.{cuerpo}'.encode()
    with tempfile.NamedTemporaryFile('w', suffix='.pem', delete=False) as f:
        f.write(cuenta['private_key'])
        clave = f.name
    try:
        firma = subprocess.run(['openssl', 'dgst', '-sha256', '-sign', clave], input=firmar, capture_output=True, check=True).stdout
    finally:
        os.unlink(clave)
    datos = urllib.parse.urlencode({'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer', 'assertion': f'{firmar.decode()}.{b64(firma)}'}).encode()
    with urllib.request.urlopen(urllib.request.Request(cuenta['token_uri'], data=datos), timeout=30) as r:
        return json.load(r)['access_token']


def datos_mensaje(op, docs):
    """Los datos del mensaje, dentro del tamaño que admite FCM."""
    docs = docs[:MAX_DOCS]
    largo_titulo = 400
    while True:
        lista = [{'id': d['id'], 'seccion': d.get('seccion', ''), 'titulo': d.get('titulo', '')[:largo_titulo], 'url': d['url'], 'pagina': d.get('pagina', '')} for d in docs]
        datos = {'tipo': 'proceso', 'op': op, 'docs': json.dumps(lista, ensure_ascii=False)}
        if len(json.dumps(datos, ensure_ascii=False).encode()) <= MAX_DATOS:
            return datos
        if largo_titulo > 120:
            largo_titulo -= 80
        elif len(docs) > 1:
            docs = docs[:-1]
        else:
            return datos


def enviar(cuenta, token, op, docs):
    mensaje = {
        'message': {
            'topic': f'proceso_{op}',
            'data': datos_mensaje(op, docs),
            # Alta prioridad: llega aunque el móvil esté en reposo. Si está
            # apagado, se guarda un día.
            'android': {'priority': 'high', 'ttl': '86400s'},
        }
    }
    url = f"https://fcm.googleapis.com/v1/projects/{cuenta['project_id']}/messages:send"
    pet = urllib.request.Request(url, data=json.dumps(mensaje).encode(), headers={'Authorization': f'Bearer {token}', 'Content-Type': 'application/json'})
    with urllib.request.urlopen(pet, timeout=30) as r:
        print(f'{op}: {len(docs)} documento(s) enviados ({json.load(r).get("name", "")})')


def main():
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    novedades = json.loads(Path(sys.argv[1]).read_text(encoding='utf-8'))
    if not novedades:
        print('Sin novedades')
        return
    secreto = os.environ.get('FCM_CUENTA_SERVICIO', '').strip()
    if not secreto:
        print('Sin FCM_CUENTA_SERVICIO: no se manda el push (los móviles lo verán en su comprobación periódica)')
        return
    cuenta = json.loads(secreto)
    token = token_acceso(cuenta)
    fallos = 0
    for op, docs in novedades.items():
        try:
            enviar(cuenta, token, op, docs)
        except urllib.error.HTTPError as e:
            fallos += 1
            print(f'{op}: error {e.code} {e.read().decode(errors="replace")[:500]}', file=sys.stderr)
    sys.exit(1 if fallos else 0)


if __name__ == '__main__':
    main()
