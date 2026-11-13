#!/usr/bin/env python3
"""Manda por correo los reportes del test («Reportar respuesta» en la app).

La app guarda cada reporte en Firestore (`reportesTest`, ver
app/tool/reglas/generar.py) con `enviado: false`. Este script los lee con la
cuenta de servicio, le manda a Víctor un correo por reporte (Brevo,
transaccional) con la pregunta, las opciones, la clave oficial, la
explicación y el comentario, y los marca como enviados.

    FCM_CUENTA_SERVICIO='{...json de la cuenta de servicio...}' BREVO_API_KEY=... \\
        python3 scripts/enviar-reportes-test.py

REPORTES_CORREO cambia el destinatario. Con --prueba no manda ni marca nada:
escribe el HTML de cada correo en la carpeta temporal.
Sin dependencias: el JWT se firma con openssl, como en enviar-push-proceso.py.
"""
import base64
import html
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

RAIZ = Path(__file__).resolve().parents[1]
TEST = RAIZ / 'oposicion/temario/primer-ejercicio/test'
ALCANCE = 'https://www.googleapis.com/auth/datastore'
DESTINO = os.environ.get('REPORTES_CORREO', 'contacto@victorgutierrezmarcos.es')
REMITENTE = {'name': 'App Oposición TCEE', 'email': 'newsletter@victorgutierrezmarcos.es'}
MOTIVOS = {
    'respuesta': 'La respuesta correcta está mal',
    'explicacion': 'La explicación tiene un error',
    'enunciado': 'Errata en el enunciado o las opciones',
    'otro': 'Otro',
}


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


def peticion(url, token, cuerpo=None, metodo='POST'):
    req = urllib.request.Request(url, data=json.dumps(cuerpo).encode() if cuerpo is not None else None, method=metodo,
                                 headers={'Authorization': f'Bearer {token}', 'Content-Type': 'application/json'})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.load(r)


def valor(v):
    """Valor de un campo de la API REST de Firestore."""
    for tipo in ('stringValue', 'booleanValue', 'timestampValue'):
        if tipo in v:
            return v[tipo]
    if 'integerValue' in v:
        return int(v['integerValue'])
    return None


def pendientes(proyecto, token):
    url = f'https://firestore.googleapis.com/v1/projects/{proyecto}/databases/(default)/documents:runQuery'
    consulta = {'structuredQuery': {
        'from': [{'collectionId': 'reportesTest'}],
        'where': {'fieldFilter': {'field': {'fieldPath': 'enviado'}, 'op': 'EQUAL', 'value': {'booleanValue': False}}},
        'limit': 50,
    }}
    out = []
    for fila in peticion(url, token, consulta):
        doc = fila.get('document')
        if doc:
            out.append((doc['name'], {k: valor(v) for k, v in doc.get('fields', {}).items()}))
    return out


def marcar_enviado(nombre, token):
    url = f'https://firestore.googleapis.com/v1/{nombre}?updateMask.fieldPaths=enviado'
    peticion(url, token, {'fields': {'enviado': {'booleanValue': True}}}, metodo='PATCH')


def explicacion(examen, id_):
    f = TEST / 'explicaciones' / f'{examen}.json'
    if not f.exists():
        return None
    return json.loads(f.read_text(encoding='utf-8')).get('explicaciones', {}).get(str(id_))


def esc(s):
    return html.escape(str(s or '')).replace('\n', '<br>')


def correo_html(r, p, e):
    """Correo de un reporte: comentario arriba, pregunta con la clave en verde y la elegida en rojo, explicación debajo."""
    fila = 'padding:6px 10px;margin:4px 0;border-radius:4px;border:1px solid #ddd'
    opciones = []
    for k, t in (p or {}).get('opciones', {}).items():
        estilo = fila
        marca = ''
        if k in p.get('respuesta', []):
            estilo += ';background:#e6f2e6;border-color:#3c8a3c'
            marca = ' <b>(clave oficial)</b>'
        if k == r.get('elegida'):
            estilo += ';outline:2px solid #b33'
            marca += ' <b>(elegida)</b>'
        opciones.append(f'<div style="{estilo}"><b>{k})</b> {esc(t)}{marca}</div>')
    exp = ''
    if e:
        ops = ''.join(f'<li><b>{k})</b> {esc(o.get("texto") if isinstance(o, dict) else o)}</li>' for k, o in e.get('opciones', {}).items())
        exp = (f'<h3 style="color:#5F2987">Explicación publicada</h3><p><b>{esc(e.get("clave"))}</b></p>'
               f'<p>{esc(e.get("desarrollo")).replace("<br><br>", "</p><p>")}</p><ul>{ops}</ul>'
               f'<p style="color:#666;font-size:12px">Fuentes: {esc(" · ".join(e.get("fuentes", [])))}</p>')
    nota = f'<p style="background:#f6eed8;padding:6px 10px"><b>Nota actual:</b> {esc(p.get("nota"))}</p>' if p and p.get('nota') else ''
    return f'''<div style="font-family:Georgia,serif;max-width:720px;color:#222">
<h2 style="color:#5F2987;margin-bottom:4px">Reporte del test: pregunta {r.get('numero')} · {esc(r.get('examen'))}</h2>
<p style="color:#666;margin-top:0">id {r.get('pregunta')} · temas {esc(', '.join((p or {}).get('temas', [])))} · {esc(r.get('oposicion'))} · app {esc(r.get('version'))} · {esc(r.get('creado'))}</p>
<div style="border-left:4px solid #C9A227;padding:8px 12px;background:#faf7ee">
<p style="margin:0"><b>{esc(MOTIVOS.get(r.get('motivo'), r.get('motivo')))}</b></p>
<p>{esc(r.get('comentario')) or '<i>(sin comentario)</i>'}</p>
<p style="color:#666;font-size:12px;margin:0">De {esc(r.get('nombre'))} &lt;{esc(r.get('correo'))}&gt;</p></div>
<h3 style="color:#5F2987">Pregunta</h3><p>{esc((p or {}).get('enunciado', '(no está en preguntas.json)'))}</p>
{''.join(opciones)}{nota}{exp}
<p style="color:#999;font-size:11px">Las fórmulas van en LaTeX. Generado por scripts/enviar-reportes-test.py.</p></div>'''


def enviar_correo(asunto, cuerpo, responder_a):
    datos = {'sender': REMITENTE, 'to': [{'email': DESTINO}], 'subject': asunto, 'htmlContent': cuerpo}
    if responder_a:
        datos['replyTo'] = {'email': responder_a}
    req = urllib.request.Request('https://api.brevo.com/v3/smtp/email', data=json.dumps(datos).encode(), method='POST',
                                 headers={'api-key': os.environ['BREVO_API_KEY'], 'Content-Type': 'application/json', 'Accept': 'application/json'})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.status


def main():
    prueba = '--prueba' in sys.argv
    cuenta = json.loads(os.environ['FCM_CUENTA_SERVICIO'])
    token = token_acceso(cuenta)
    banco = {p['id']: p for p in json.loads((TEST / 'preguntas.json').read_text(encoding='utf-8'))['preguntas']}
    lista = pendientes(cuenta['project_id'], token)
    print(f'{len(lista)} reportes pendientes')
    for nombre, r in lista:
        p = banco.get(r.get('pregunta'))
        e = explicacion(r.get('examen'), r.get('pregunta'))
        asunto = f"Reporte test · {r.get('examen')} n.º {r.get('numero')} · {MOTIVOS.get(r.get('motivo'), r.get('motivo'))}"
        cuerpo = correo_html(r, p, e)
        if prueba:
            f = Path(tempfile.gettempdir()) / f"reporte-{nombre.rsplit('/', 1)[-1]}.html"
            f.write_text(cuerpo, encoding='utf-8')
            print('escrito', f)
            continue
        try:
            enviar_correo(asunto, cuerpo, r.get('correo'))
            marcar_enviado(nombre, token)
            print('enviado', nombre.rsplit('/', 1)[-1])
        except urllib.error.HTTPError as err:
            print('ERROR', nombre, err.code, err.read().decode()[:300])


if __name__ == '__main__':
    main()
