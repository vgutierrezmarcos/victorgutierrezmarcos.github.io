#!/usr/bin/env python3
"""Lo que hace la Action sugerencias.yml con las sugerencias de mejora de los usuarios.

Las sugerencias viven en los datos de cada usuario (…/sugerencias/{id}; ver
scripts/sugerencias.py). Con la cuenta de servicio (la misma de los reportes del
test), este script hace dos cosas:

    python3 scripts/enviar-sugerencias.py --resumen
        Red de seguridad: un correo a Víctor (Brevo) con las sugerencias que
        llevan más de tres días sin tramitar (el agente de su ordenador,
        scripts/agente-sugerencias.py, no ha pasado), agrupadas por tema. Sin
        identidades: ni uid ni correo. Si no hay ninguna, no manda nada.

    INFORME='<clave>.<firma>' ASUNTO='…' python3 scripts/enviar-sugerencias.py --informe
        Manda por correo el informe del día que el agente ha dejado en el
        conector (https://mcp.victorgutierrezmarcos.es/informe), con los botones
        para decidir.

    RESOLUCIONES='[{"id":"s_…","estado":"aceptada","respuesta":"…"}]' python3 scripts/enviar-sugerencias.py --resolver
        Pone estado, respuesta y fecha en el documento de cada sugerencia, para
        que su autor lo vea en la app y en su asistente de IA. Las manda
        scripts/sugerencias.py --enviar.

Variables: FCM_CUENTA_SERVICIO (JSON de la cuenta de servicio), BREVO_API_KEY y,
si se quiere otro destinatario, REPORTES_CORREO. Con --prueba no manda ni
escribe nada: deja el correo en la carpeta temporal o dice qué cambiaría.
"""
import html
import importlib.util
import json
import os
import sys
import tempfile
import urllib.error
from collections import defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
ESTADOS = ('aceptada', 'descartada', 'duplicada')
TIPOS = {'error': 'Hay un error', 'desactualizado': 'Está desactualizado', 'no_explica': 'No lo explica', 'poco_claro': 'Está poco claro',
         'falta': 'Falta algo', 'errata': 'Errata', 'otro': 'Otra cosa'}


def _reportes():
    """Token de la cuenta de servicio, peticiones y correo: lo mismo que usan los reportes del test."""
    spec = importlib.util.spec_from_file_location('enviar_reportes_test', RAIZ / 'scripts/enviar-reportes-test.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def todas(rep, proyecto, token):
    """Todas las sugerencias: (nombre del documento, campos de texto, fecha de creación)."""
    url = f'https://firestore.googleapis.com/v1/projects/{proyecto}/databases/(default)/documents:runQuery'
    filas = rep.peticion(url, token, {'structuredQuery': {'from': [{'collectionId': 'sugerencias', 'allDescendants': True}]}})
    out = []
    for fila in filas:
        d = fila.get('document')
        if not d:
            continue
        ruta = d['name'].split('/documents/', 1)[1].split('/')
        if len(ruta) not in (4, 6) or ruta[0] != 'users' or ruta[-2] != 'sugerencias':
            continue
        campos = {k: v['stringValue'] for k, v in d.get('fields', {}).items() if 'stringValue' in v}
        campos['oposicion'] = ruta[3] if len(ruta) == 6 else 'tcee'
        out.append((d['name'], campos, d.get('createTime', '')))
    return out


def esc(s, n=2000):
    return html.escape(str(s or '')[:n]).replace('\n', '<br>')


def correo_resumen(nuevas, pendientes):
    grupos = defaultdict(list)
    for _, c, _ in nuevas:
        grupos[(c.get('tema', '?')[:12], c.get('recurso', 'tema')[:10], c['oposicion'])].append(c)
    partes = []
    for (tema, recurso, op), lista in sorted(grupos.items()):
        partes.append(f'<h3 style="color:#5F2987;margin-bottom:4px">{esc(tema)} · {esc(recurso)} <span style="color:#666;font-weight:normal">({esc(op.upper())})</span></h3>')
        for c in lista:
            partes.append(
                '<div style="border-left:4px solid #C9A227;padding:8px 12px;background:#faf7ee;margin:8px 0">'
                f'<p style="margin:0"><b>{esc(TIPOS.get(c.get("tipo"), c.get("tipo")), 40)}</b>'
                + (f' · {esc(c.get("apartado"), 200)}' if c.get('apartado') else '') + '</p>'
                + (f'<p style="color:#555;margin:6px 0"><i>«{esc(c.get("cita"), 500)}»</i></p>' if c.get('cita') else '')
                + f'<p style="margin:6px 0">{esc(c.get("propuesta"))}</p>'
                + (f'<p style="color:#666;font-size:12px;margin:0">Duda: {esc(c.get("duda"), 500)}</p>' if c.get('duda') else '')
                + f'<p style="color:#999;font-size:11px;margin:4px 0 0">{esc(c.get("origen"), 60)} · versión {esc(c.get("version"), 40) or "—"}</p></div>')
    return f'''<div style="font-family:Georgia,serif;max-width:720px;color:#222">
<h2 style="color:#5F2987;margin-bottom:4px">Sugerencias de mejora: {len(nuevas)} sin tramitar desde hace más de tres días</h2>
<p style="color:#666;margin-top:0">{pendientes} sin resolver en total. Son anónimas: no llevan quién las manda.</p>
{''.join(partes)}
<p style="color:#666">Para tramitarlas: <code>/sugerencias</code> en Claude Code, o <code>python3 scripts/sugerencias.py</code>.</p>
<p style="color:#999;font-size:11px">Generado por scripts/enviar-sugerencias.py.</p></div>'''


def resumen(rep, proyecto, token, prueba):
    lista = todas(rep, proyecto, token)
    hasta = (datetime.now(timezone.utc) - timedelta(days=3)).isoformat()
    pendientes = sum(1 for _, c, _ in lista if c.get('estado', 'recibida') == 'recibida')
    nuevas = [x for x in lista if x[1].get('estado', 'recibida') == 'recibida' and x[2][:19] < hasta[:19]]
    print(f'{len(lista)} sugerencias; {pendientes} sin resolver; {len(nuevas)} llevan más de tres días')
    if not nuevas:
        return
    cuerpo = correo_resumen(nuevas, pendientes)
    if prueba:
        f = Path(tempfile.gettempdir()) / 'sugerencias-resumen.html'
        f.write_text(cuerpo, encoding='utf-8')
        print('escrito', f)
        return
    rep.enviar_correo(f'Sugerencias de mejora · {len(nuevas)} sin tramitar', cuerpo, None)
    print('correo enviado')


def resolver(rep, proyecto, token, prueba):
    try:
        pedidas = json.loads(os.environ.get('RESOLUCIONES') or '[]')
    except ValueError:
        sys.exit('RESOLUCIONES no es JSON.')
    por_id = {nombre.rsplit('/', 1)[1]: nombre for nombre, _, _ in todas(rep, proyecto, token)}
    ahora = datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')
    hechas = 0
    for r in pedidas if isinstance(pedidas, list) else []:
        nombre = por_id.get(str(r.get('id')))
        if not nombre or r.get('estado') not in ESTADOS:
            print('no vale o no existe:', str(r.get('id'))[:40])
            continue
        if prueba:
            print('cambiaría', r['id'], '→', r['estado'])
            continue
        # «vista» vuelve a falso: es una novedad que su autor aún no ha visto.
        url = f'https://firestore.googleapis.com/v1/{nombre}?' + '&'.join(f'updateMask.fieldPaths={c}' for c in ('estado', 'respuesta', 'resuelta', 'vista'))
        try:
            rep.peticion(url, token, {'fields': {'estado': {'stringValue': r['estado']}, 'respuesta': {'stringValue': str(r.get('respuesta') or '')[:1000]},
                                                 'resuelta': {'timestampValue': ahora}, 'vista': {'booleanValue': False}}}, metodo='PATCH')
            hechas += 1
        except urllib.error.HTTPError as err:
            print('ERROR', r['id'], err.code, err.read().decode()[:200])
    # Sin el texto de las respuestas: el registro de la Action es público.
    print(f'{hechas} de {len(pedidas)} sugerencias resueltas')


def informe(rep, prueba):
    """El informe del agente, que está en el conector: se baja con su enlace firmado y se manda tal cual."""
    import re
    import urllib.request
    ref = os.environ.get('INFORME', '')
    if not re.fullmatch(r'[\w-]{3,48}\.[0-9a-f]{32}', ref):
        sys.exit('INFORME no tiene la forma <clave>.<firma>.')
    clave, firma = ref.split('.')
    url = f'https://mcp.victorgutierrezmarcos.es/informe?c={clave}&f={firma}'
    with urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent': 'sugerencias-action'}), timeout=30) as r:
        cuerpo = r.read().decode('utf-8')
    asunto = (os.environ.get('ASUNTO') or 'Sugerencias de mejora').replace('\n', ' ')[:150]
    if prueba:
        print('mandaría', len(cuerpo), 'caracteres con el asunto', asunto)
        return
    rep.enviar_correo(asunto, cuerpo, None)
    print('informe enviado')


def main():
    prueba = '--prueba' in sys.argv
    rep = _reportes()
    if '--informe' in sys.argv:
        return informe(rep, prueba)
    cuenta = json.loads(os.environ['FCM_CUENTA_SERVICIO'])
    token = rep.token_acceso(cuenta)
    if '--resolver' in sys.argv:
        resolver(rep, cuenta['project_id'], token, prueba)
    else:
        resumen(rep, cuenta['project_id'], token, prueba)


if __name__ == '__main__':
    main()
