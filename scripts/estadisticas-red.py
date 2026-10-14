#!/usr/bin/env python3
"""Estadísticas privadas de la red de la app (TCEE y DCE), solo agregadas.

Lee Firestore con una cuenta de servicio de solo lectura y saca recuentos:
cuentas, actividad, preparadores, conexiones, clases y tablón, por
oposición. No escribe nada en Firestore ni muestra nombres, correos, uid ni
contenidos: solo números. Cada ejecución guarda la foto del día (también
solo números) para ver la evolución.

    python3 scripts/estadisticas-red.py            # resumen y foto del día
    python3 scripts/estadisticas-red.py --json     # la foto en JSON

Clave: la de la cuenta de servicio con el papel «Cloud Datastore Viewer»
(lectura), en ~/.config/oposicion-red/clave.json o en $ESTADISTICAS_CLAVE.
Nunca dentro del repositorio. Fotos: ~/.local/share/oposicion-red/.

Solo usa la biblioteca estándar y `openssl` (para firmar el token).
"""
import base64
import json
import os
import subprocess
import sys
import tempfile
import time
import urllib.parse
import urllib.request
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
from pathlib import Path

CLAVE = Path(os.environ.get('ESTADISTICAS_CLAVE', Path.home() / '.config/oposicion-red/clave.json'))
FOTOS = Path.home() / '.local/share/oposicion-red'
PROYECTO = 'web-vgm'
API = f'https://firestore.googleapis.com/v1/projects/{PROYECTO}/databases/(default)/documents'
OPOSICIONES = ('tcee', 'dce')


# ------------------------------------------------------------------ Acceso

def _b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b'=').decode()


def token():
    c = json.loads(CLAVE.read_text())
    ahora = int(time.time())
    cabecera = _b64(json.dumps({'alg': 'RS256', 'typ': 'JWT'}).encode())
    cuerpo = _b64(json.dumps({
        'iss': c['client_email'], 'scope': 'https://www.googleapis.com/auth/datastore',
        'aud': c['token_uri'], 'iat': ahora, 'exp': ahora + 3600,
    }).encode())
    with tempfile.NamedTemporaryFile('w', suffix='.pem', delete=False) as f:
        f.write(c['private_key'])
    try:
        firma = subprocess.run(['openssl', 'dgst', '-sha256', '-sign', f.name], input=f'{cabecera}.{cuerpo}'.encode(), capture_output=True, check=True).stdout
    finally:
        os.unlink(f.name)
    datos = urllib.parse.urlencode({'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer', 'assertion': f'{cabecera}.{cuerpo}.{_b64(firma)}'}).encode()
    return json.load(urllib.request.urlopen(c['token_uri'], datos, timeout=30))['access_token']


class Firestore:
    def __init__(self):
        self.t = token()

    def _pedir(self, url, cuerpo=None):
        for intento in range(5):
            try:
                r = urllib.request.Request(url, json.dumps(cuerpo).encode() if cuerpo is not None else None, {'Authorization': f'Bearer {self.t}', 'Content-Type': 'application/json'})
                return json.load(urllib.request.urlopen(r, timeout=60))
            except urllib.error.HTTPError:
                raise
            except OSError:
                if intento == 4:
                    raise
                time.sleep(2 * (intento + 1))

    def colecciones(self, ruta):
        url = f'{API}/{ruta}:listCollectionIds' if ruta else f'{API}:listCollectionIds'
        ids, pagina = [], None
        while True:
            r = self._pedir(url, {'pageSize': 300, **({'pageToken': pagina} if pagina else {})})
            ids += r.get('collectionIds', [])
            pagina = r.get('nextPageToken')
            if not pagina:
                return ids

    def documentos(self, ruta):
        # showMissing: también los documentos que no existen pero tienen
        # subcolecciones (p. ej. users/{uid} sin campos).
        docs, pagina = [], None
        while True:
            q = {'pageSize': 300, 'showMissing': 'true', **({'pageToken': pagina} if pagina else {})}
            r = self._pedir(f'{API}/{ruta}?{urllib.parse.urlencode(q)}')
            docs += r.get('documents', [])
            pagina = r.get('nextPageToken')
            if not pagina:
                return docs

    def recorrer(self, ruta=''):
        """Todos los documentos, con su ruta relativa, campos y fechas."""
        for col in self.colecciones(ruta):
            base = f'{ruta}/{col}' if ruta else col
            for d in self.documentos(base):
                rel = d['name'].split('/documents/', 1)[1]
                if 'createTime' in d:
                    yield rel, d.get('fields', {}), _fecha(d['createTime']), _fecha(d['updateTime'])
                yield from self.recorrer(rel)


def _fecha(s):
    return datetime.fromisoformat(s.replace('Z', '+00:00')) if s else None


def valor(v):
    if not v:
        return None
    for k in ('stringValue', 'booleanValue', 'integerValue', 'doubleValue', 'timestampValue'):
        if k in v:
            return v[k]
    return None


# ------------------------------------------------------------------ Recuento

def oposicion_y_resto(partes):
    """('tcee'|'dce', partes desde la raíz de esa oposición) de una ruta."""
    if partes[0] == 'users' and len(partes) > 3 and partes[2] == 'oposiciones':
        return partes[3], ['users', partes[1], *partes[4:]]
    if partes[0] == 'oposiciones' and len(partes) > 2:
        return partes[1], partes[2:]
    return 'tcee', partes


def recontar(docs, ahora):
    hace7, hace30 = ahora - timedelta(days=7), ahora - timedelta(days=30)
    en7, en14 = ahora + timedelta(days=7), ahora + timedelta(days=14)
    s = {op: defaultdict(Counter) for op in OPOSICIONES}
    alta = {op: {} for op in OPOSICIONES}       # uid → primera escritura
    ultima = {op: {} for op in OPOSICIONES}     # uid → última escritura
    alumnos_de = {op: defaultdict(set) for op in OPOSICIONES}   # preparador → alumnos aceptados
    preparadores_de = {op: defaultdict(set) for op in OPOSICIONES}
    verificados = {op: set() for op in OPOSICIONES}
    con_clases = {op: set() for op in OPOSICIONES}
    con_huecos = {op: set() for op in OPOSICIONES}
    # El papel no se guarda en Firestore: es preparador quien tiene algo de
    # preparador (verificación pedida o hecha, código, huecos, clases o
    # fichas de alumnos); el resto de cuentas, opositores.
    preparadores = {op: set() for op in OPOSICIONES}

    for ruta, campos, creado, cambiado in docs:
        partes = ruta.split('/')
        op, p = oposicion_y_resto(partes)
        if op not in s:
            continue
        c = s[op]
        f = lambda k: valor(campos.get(k))
        if p[0] == 'users' and len(p) >= 3:
            uid, col = p[1], p[2]
            alta[op][uid] = min(alta[op].get(uid, creado), creado)
            ultima[op][uid] = max(ultima[op].get(uid, cambiado), cambiado)
            if len(p) == 4:
                c['documentos'][col] += 1
                if col in ('sesiones', 'alumnos', 'alumnosSueltos'):
                    preparadores[op].add(uid)
                if col == 'exam_results':
                    c['tests']['últimos 7 días'] += creado >= hace7
                    c['tests']['últimos 30 días'] += creado >= hace30
                    c['tests']['total'] += 1
                if col == 'sesiones':
                    fecha = _fecha(f('fecha'))
                    if fecha and fecha.tzinfo is None:
                        fecha = fecha.replace(tzinfo=timezone.utc)
                    c['clases']['total'] += 1
                    if fecha:
                        c['clases']['dadas últimos 7 días'] += hace7 <= fecha < ahora
                        c['clases']['dadas últimos 30 días'] += hace30 <= fecha < ahora
                        c['clases']['programadas próximos 7 días'] += ahora <= fecha < en7
                        if ahora <= fecha < en14:
                            con_clases[op].add(uid)
                    c['clases']['creadas últimos 7 días'] += creado >= hace7
                if col == 'alumnos':
                    # Fichas de alumnos que lleva el preparador: con la app
                    # (uid) o apuntados a mano, sin ella.
                    c['red']['fichas de alumnos con la app' if f('uid') else 'fichas de alumnos sin la app'] += 1
                if col == 'cronogramasRecibidos':
                    c['red']['cronogramas mandados'] += 1
                if col == 'notasPreparadores':
                    c['red']['notas entre preparadores'] += 1
                if col == 'contactosPreparadores':
                    c['red']['contactos compartidos'] += 1
        elif p[0] == 'preparadores' and len(p) == 4 and p[2] == 'alumnos':
            prep, alumno = p[1], p[3]
            if f('aceptado') is False:
                c['conexiones']['pendientes de aceptar'] += 1
            else:
                c['conexiones']['aceptadas'] += 1
                c['conexiones']['nuevas últimos 7 días'] += creado >= hace7
                c['conexiones']['nuevas últimos 30 días'] += creado >= hace30
                alumnos_de[op][prep].add(alumno)
                preparadores_de[op][alumno].add(prep)
        elif len(p) == 2 and p[0] == 'preparadoresVerificados':
            verificados[op].add(p[1])
            preparadores[op].add(p[1])
        elif len(p) == 2 and p[0] == 'solicitudesPreparador':
            c['preparadores']['solicitudes de verificación'] += 1
            preparadores[op].add(p[1])
        elif len(p) == 2 and p[0] == 'codigos':
            c['preparadores']['con código'] += 1
            if f('uid'):
                preparadores[op].add(f('uid'))
        elif len(p) == 2 and p[0] == 'huecos':
            con_huecos[op].add(p[1])
            preparadores[op].add(p[1])
        elif len(p) == 2 and p[0] == 'sustituciones':
            c['tablón'][f'clases sueltas {f("estado") or "abierta"}'] += 1
            c['tablón']['clases sueltas últimos 30 días'] += creado >= hace30
        elif len(p) == 2 and p[0] == 'reservas':
            c['tablón'][f'reservas {f("estado") or "pedida"}'] += 1
        elif len(p) == 2 and p[0] == 'busquedas':
            c['tablón']['búsquedas de preparador'] += 1
        elif len(p) == 4 and p[0] == 'busquedas' and p[2] == 'interesados':
            c['tablón']['preparadores interesados en búsquedas'] += 1

    foto = {'fecha': ahora.isoformat(timespec='minutes')}
    for op in OPOSICIONES:
        c = s[op]
        uids = alta[op]
        c['cuentas']['total'] = len(uids)
        c['cuentas']['preparadores'] = len(preparadores[op])
        c['cuentas']['opositores'] = len(set(uids) - preparadores[op])
        c['cuentas']['opositores activos últimos 7 días'] = sum(1 for u, t in ultima[op].items() if u not in preparadores[op] and t >= hace7)
        c['cuentas']['nuevas últimos 7 días'] = sum(t >= hace7 for t in uids.values())
        c['cuentas']['nuevas últimos 30 días'] = sum(t >= hace30 for t in uids.values())
        c['cuentas']['activas últimos 7 días'] = sum(t >= hace7 for t in ultima[op].values())
        c['cuentas']['activas últimos 30 días'] = sum(t >= hace30 for t in ultima[op].values())
        v = verificados[op]
        c['preparadores']['verificados'] = len(v)
        c['preparadores']['verificados activos últimos 7 días'] = sum(ultima[op].get(u, datetime.min.replace(tzinfo=timezone.utc)) >= hace7 for u in v)
        c['preparadores']['con algún alumno conectado'] = sum(1 for u in alumnos_de[op] if alumnos_de[op][u])
        c['preparadores']['verificados sin alumnos'] = sum(1 for u in v if not alumnos_de[op].get(u))
        c['preparadores']['con huecos abiertos'] = len(con_huecos[op])
        c['preparadores']['con clases en los próximos 14 días'] = len(con_clases[op])
        tam = sorted((len(a) for a in alumnos_de[op].values() if a), reverse=True)
        c['red']['alumnos conectados (distintos)'] = len(preparadores_de[op])
        c['red']['alumnos con 2 o más preparadores'] = sum(1 for p in preparadores_de[op].values() if len(p) >= 2)
        foto[op] = {k: dict(sorted(v.items())) for k, v in sorted(c.items()) if k != 'documentos'}
        foto[op]['red']['alumnos por preparador (de mayor a menor)'] = tam
    return foto


# ------------------------------------------------------------------ Salida

ORDEN = ['cuentas', 'preparadores', 'conexiones', 'clases', 'red', 'tablón', 'tests']


def diferencia(nuevo, viejo):
    if isinstance(nuevo, int) and isinstance(viejo, int) and nuevo != viejo:
        return f'  ({nuevo - viejo:+d})'
    return ''


def imprimir(foto, anterior):
    print(f'Red de la app — {foto["fecha"]}' + (f'  (cambios desde {anterior["fecha"]})' if anterior else ''))
    for op in OPOSICIONES:
        print(f'\n## {op.upper()}')
        for grupo in ORDEN:
            datos = foto[op].get(grupo)
            if not datos:
                continue
            print(f'\n{grupo.capitalize()}')
            for k, v in datos.items():
                previo = (anterior or {}).get(op, {}).get(grupo, {}).get(k)
                print(f'  - {k}: {v}{diferencia(v, previo)}')


def main():
    if not CLAVE.exists():
        sys.exit(f'Falta la clave de la cuenta de servicio en {CLAVE} (ver la ayuda del script).')
    ahora = datetime.now(timezone.utc)
    foto = recontar(Firestore().recorrer(), ahora)
    FOTOS.mkdir(parents=True, exist_ok=True)
    anteriores = sorted(p for p in FOTOS.glob('*.json') if p.stem != ahora.date().isoformat())
    anterior = json.loads(anteriores[-1].read_text()) if anteriores else None
    (FOTOS / f'{ahora.date().isoformat()}.json').write_text(json.dumps(foto, ensure_ascii=False, indent=1))
    if '--json' in sys.argv:
        print(json.dumps(foto, ensure_ascii=False, indent=1))
    else:
        imprimir(foto, anterior)


if __name__ == '__main__':
    main()
