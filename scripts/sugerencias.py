#!/usr/bin/env python3
"""Bandeja de las sugerencias de mejora de temas y fichas que mandan los usuarios.

Las sugerencias las escriben el conector (sugerir_mejora) y la app («Sugerir una
mejora») en los datos del propio usuario: users/{uid}/sugerencias/{id} en TCEE y
users/{uid}/oposiciones/{op}/sugerencias/{id} en las demás. Este script las lee
todas con la cuenta de solo lectura de scripts/estadisticas-red.py
(~/.config/oposicion-red/clave.json), DESCARTA el uid (la bandeja es anónima) y
las deja agrupadas por tema en ~/.local/share/oposicion-web/sugerencias/.

    python3 scripts/sugerencias.py                       # baja y lista las pendientes, por tema
    python3 scripts/sugerencias.py --todas               # también las ya resueltas
    python3 scripts/sugerencias.py --tema 3.A.8          # solo las de un tema (pendientes y aceptadas sin aplicar)
    python3 scripts/sugerencias.py --resolver ID [ID…] --estado aceptada|descartada|duplicada [--respuesta "…"]
    python3 scripts/sugerencias.py --aplicada ID [ID…]   # la aceptada ya está en el material
    python3 scripts/sugerencias.py --enviar              # manda al usuario lo resuelto (Action sugerencias.yml)
    python3 scripts/sugerencias.py --dudas [DIAS]        # qué apartados dan más dudas (contador anónimo del conector)
    python3 scripts/sugerencias.py --cuenta              # sugerencias aceptadas por tema (para «Mejorado con N sugerencias»)

Esta cuenta no escribe en Firestore: lo resuelto se apunta en resueltas.json de
esa carpeta y --enviar lo pasa a la Action (gh workflow run), que con la cuenta
de servicio pone estado, respuesta y fecha en el documento del usuario. Así él
lo ve en la app (Más → Mis sugerencias) y en su asistente de IA (empezar).

El estado que cuenta para la bandeja es el de resueltas.json, no el del
documento: el usuario es dueño de sus datos y podría cambiarlo.
Las del test van aparte: scripts/reportes-test.py.
"""
import importlib.util
import json
import os
import subprocess
import sys
import urllib.error
import urllib.request
from collections import defaultdict
from datetime import datetime
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
CARPETA = Path.home() / '.local/share/oposicion-web/sugerencias'
RESUELTAS = CARPETA / 'resueltas.json'
ESTADOS = ('aceptada', 'descartada', 'duplicada')
TIPOS = {'error': 'error', 'desactualizado': 'desactualizado', 'no_explica': 'no lo explica', 'poco_claro': 'poco claro',
         'falta': 'falta algo', 'errata': 'errata', 'otro': 'otro'}
# El usuario es dueño de su documento: lo que llega se recorta a lo que admiten el conector y la app.
LIMITES = {'recurso': 10, 'tema': 12, 'apartado': 200, 'tipo': 20, 'cita': 500, 'propuesta': 2000, 'duda': 500,
           'version': 40, 'origen': 60, 'oposicion': 8, 'estado': 12}
CLOUDFLARE = Path.home() / '.config/oposicion-red/cloudflare.token'


def _red():
    spec = importlib.util.spec_from_file_location('estadisticas_red', RAIZ / 'scripts/estadisticas-red.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def leer(documento):
    """Un documento de Firestore → sugerencia sin nada del usuario (ni el uid de la ruta)."""
    ruta = documento['name'].split('/documents/', 1)[1].split('/')
    if len(ruta) not in (4, 6) or ruta[0] != 'users' or ruta[-2] != 'sugerencias':
        return None
    campos = documento.get('fields', {})
    s = {'id': ruta[-1][:40], 'oposicion': ruta[3] if len(ruta) == 6 else 'tcee', 'creado': documento.get('createTime', '')[:19]}
    for k, n in LIMITES.items():
        v = campos.get(k, {}).get('stringValue')
        if isinstance(v, str) and k != 'oposicion':
            s[k] = v[:n]
    return s if s.get('tema') and s.get('propuesta') else None


def bajar():
    red = _red()
    fs = red.Firestore()
    filas = fs._pedir(f'{red.API}:runQuery', {'structuredQuery': {'from': [{'collectionId': 'sugerencias', 'allDescendants': True}]}})
    todas = [s for s in (leer(f['document']) for f in filas if f.get('document')) if s]
    CARPETA.mkdir(parents=True, exist_ok=True)
    (CARPETA / 'todas.json').write_text(json.dumps(sorted(todas, key=lambda s: s['creado']), ensure_ascii=False, indent=1), encoding='utf-8')
    return todas


def resueltas():
    return json.loads(RESUELTAS.read_text(encoding='utf-8')) if RESUELTAS.exists() else {}


def guardar_resueltas(r):
    CARPETA.mkdir(parents=True, exist_ok=True)
    RESUELTAS.write_text(json.dumps(r, ensure_ascii=False, indent=1), encoding='utf-8')


def clave_tema(codigo):
    """«3.A.8» o «3A08» → «3.A.8»."""
    c = codigo.strip().upper().replace('.', '')
    return f'{c[0]}.{c[1]}.{int(c[2:])}' if len(c) >= 3 and c[2:].isdigit() else codigo


def listar(todas, hechas, solo_tema=None, con_resueltas=False):
    grupos = defaultdict(list)
    for s in todas:
        r = hechas.get(s['id'])
        if solo_tema and s['tema'] != solo_tema:
            continue
        if r and not con_resueltas and not (solo_tema and r['estado'] == 'aceptada' and not r.get('aplicada')):
            continue
        grupos[(s['oposicion'], s['tema'], s.get('recurso', 'tema'))].append(s)
    pendientes = sum(1 for s in todas if s['id'] not in hechas)
    print(f'{len(todas)} sugerencias en Firestore; {pendientes} por resolver → {CARPETA}')
    for (op, tema, recurso), lista in sorted(grupos.items()):
        print(f'\n## {tema} · {recurso} ({op.upper()}) — {len(lista)}')
        for s in sorted(lista, key=lambda s: (s.get('apartado', ''), s['creado'])):
            r = hechas.get(s['id'])
            marca = f" [{r['estado']}{'' if r.get('aplicada') or r['estado'] != 'aceptada' else ', sin aplicar'}{'' if r.get('enviada') else ', sin enviar'}]" if r else ''
            print(f"- {s['id']}{marca} · {s['creado'][:10]} · {TIPOS.get(s.get('tipo'), s.get('tipo'))} · versión {s.get('version') or '—'} · {s.get('origen', '')}")
            if s.get('apartado'):
                print(f"    Apartado: {s['apartado']}")
            if s.get('cita'):
                print(f"    Cita: «{s['cita']}»")
            print(f"    Propuesta: {s['propuesta']}")
            if s.get('duda'):
                print(f"    Duda: {s['duda']}")


def resolver(ids, estado, respuesta):
    if estado not in ESTADOS:
        sys.exit(f'--estado tiene que ser uno de: {", ".join(ESTADOS)}')
    conocidas = {s['id'] for s in json.loads((CARPETA / 'todas.json').read_text(encoding='utf-8'))} if (CARPETA / 'todas.json').exists() else set()
    hechas = resueltas()
    for i in ids:
        if i not in conocidas:
            sys.exit(f'No conozco la sugerencia {i} (ejecuta antes el script sin argumentos).')
        hechas[i] = {'estado': estado, 'respuesta': respuesta[:1000], 'fecha': datetime.now().isoformat(timespec='minutes'),
                     'aplicada': False, 'enviada': False}
    guardar_resueltas(hechas)
    print(f'{len(ids)} apuntadas como «{estado}». Para que el usuario lo vea: python3 scripts/sugerencias.py --enviar')


def enviar():
    hechas = resueltas()
    lote = [{'id': i, 'estado': r['estado'], 'respuesta': r.get('respuesta', '')} for i, r in hechas.items() if not r.get('enviada')]
    if not lote:
        print('Nada que enviar.')
        return
    # De 40 en 40: las entradas de un workflow_dispatch tienen tope de tamaño.
    for k in range(0, len(lote), 40):
        tramo = lote[k:k + 40]
        subprocess.run(['gh', 'workflow', 'run', 'sugerencias.yml', '--ref', 'main', '-f', 'resoluciones=' + json.dumps(tramo, ensure_ascii=False)],
                       check=True, cwd=RAIZ)
        for x in tramo:
            hechas[x['id']]['enviada'] = True
        guardar_resueltas(hechas)
    print(f'{len(lote)} resoluciones enviadas a la Action sugerencias.yml (mira el resultado con: gh run list --workflow sugerencias.yml).')


def cuenta():
    """Aceptadas por tema: lo que la web o la app pueden enseñar como «Mejorado con N sugerencias»."""
    todas = {s['id']: s for s in json.loads((CARPETA / 'todas.json').read_text(encoding='utf-8'))}
    n = defaultdict(int)
    for i, r in resueltas().items():
        if r['estado'] == 'aceptada' and i in todas:
            n[todas[i]['tema']] += 1
    print(json.dumps(dict(sorted(n.items())), ensure_ascii=False, indent=1))


def filas_dudas(dias):
    """Filas del contador anónimo del conector (Analytics Engine, índice «senal»): tema, apartado, tipo y veces."""
    token = CLOUDFLARE.read_text().strip()

    def pedir(url, cuerpo=None):
        req = urllib.request.Request(url, data=cuerpo.encode() if cuerpo else None, headers={'Authorization': f'Bearer {token}'})
        return json.load(urllib.request.urlopen(req, timeout=60))
    cuenta_cf = os.environ.get('CLOUDFLARE_ACCOUNT_ID') or pedir('https://api.cloudflare.com/client/v4/accounts')['result'][0]['id']
    sql = ("SELECT blob3 AS oposicion, blob4 AS recurso, blob5 AS tema, blob6 AS apartado, blob7 AS tipo, SUM(_sample_interval) AS veces "
           f"FROM analytics_mcp WHERE index1 = 'senal' AND timestamp > NOW() - INTERVAL '{int(dias)}' DAY "
           "GROUP BY oposicion, recurso, tema, apartado, tipo ORDER BY veces DESC LIMIT 200 FORMAT JSON")
    return pedir(f'https://api.cloudflare.com/client/v4/accounts/{cuenta_cf}/analytics_engine/sql', sql).get('data', [])


def dudas(dias):
    """Qué apartados dan pie a más dudas."""
    if not CLOUDFLARE.exists():
        sys.exit(f'Falta el token de Cloudflare ({CLOUDFLARE}).')
    try:
        filas = filas_dudas(dias)
    except urllib.error.HTTPError as e:
        sys.exit(f'Cloudflare ha contestado {e.code}: el token necesita el permiso «Account Analytics: Read». {e.read().decode()[:200]}')
    print(f'Dudas por apartado en los últimos {dias} días ({len(filas)} filas):')
    for f in filas:
        print(f"- {int(float(f['veces'])):>3} × {f['tema']} · {f['recurso']}{' · ' + f['apartado'] if f['apartado'] else ''} · {TIPOS.get(f['tipo'], f['tipo'])} ({f['oposicion']})")


def main():
    a = sys.argv[1:]

    def tras(opcion):
        """Los argumentos que siguen a una opción hasta la siguiente."""
        if opcion not in a:
            return []
        resto = a[a.index(opcion) + 1:]
        fin = next((k for k, x in enumerate(resto) if x.startswith('--')), len(resto))
        return resto[:fin]

    if '--resolver' in a:
        return resolver(tras('--resolver'), ''.join(tras('--estado')), ' '.join(tras('--respuesta')))
    if '--aplicada' in a:
        hechas = resueltas()
        for i in tras('--aplicada'):
            if hechas.get(i, {}).get('estado') != 'aceptada':
                sys.exit(f'{i} no está aceptada.')
            hechas[i]['aplicada'] = True
        guardar_resueltas(hechas)
        return print('Apuntado.')
    if '--enviar' in a:
        return enviar()
    if '--cuenta' in a:
        return cuenta()
    if '--dudas' in a:
        return dudas((tras('--dudas') or ['30'])[0])
    tema = clave_tema(tras('--tema')[0]) if tras('--tema') else None
    listar(bajar(), resueltas(), tema, '--todas' in a)


if __name__ == '__main__':
    main()
