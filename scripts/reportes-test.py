#!/usr/bin/env python3
"""Reúne los reportes del test («Reportar respuesta» en la app) para revisarlos.

Lee la colección `reportesTest` de Firestore con la cuenta de servicio de solo
lectura de scripts/estadisticas-red.py (~/.config/oposicion-red/clave.json) y
guarda cada reporte, junto con su pregunta y la explicación publicada, en
~/.local/share/oposicion-web/explicaciones-test/reportes/<doc>.json (fuera del
repo: llevan el correo del opositor). Los ya revisados se apuntan en
revisados.json de esa carpeta, porque esta cuenta no puede escribir en Firestore.

    python3 scripts/reportes-test.py                    # baja y lista los pendientes
    python3 scripts/reportes-test.py --todos            # también los revisados
    python3 scripts/reportes-test.py --revisado <doc> [<doc> ...] [--nota "qué se hizo"]

Al corregir: editar ~/.local/share/oposicion-web/explicaciones-test/<id>.json
(o la clave/nota en preguntas.json), ejecutar scripts/explicaciones-test.py y
marcar el reporte como revisado. El correo (reportes-test.yml) va aparte.
"""
import importlib.util
import json
import sys
from datetime import datetime
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
TEST = RAIZ / 'oposicion/temario/primer-ejercicio/test'
CARPETA = Path.home() / '.local/share/oposicion-web/explicaciones-test/reportes'
REVISADOS = CARPETA / 'revisados.json'


def _red():
    spec = importlib.util.spec_from_file_location('estadisticas_red', RAIZ / 'scripts/estadisticas-red.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def valor(v):
    for tipo in ('stringValue', 'booleanValue', 'timestampValue'):
        if tipo in v:
            return v[tipo]
    if 'integerValue' in v:
        return int(v['integerValue'])
    return None


def main():
    CARPETA.mkdir(parents=True, exist_ok=True)
    revisados = json.loads(REVISADOS.read_text()) if REVISADOS.exists() else {}
    if '--revisado' in sys.argv:
        args = sys.argv[sys.argv.index('--revisado') + 1:]
        nota = args[args.index('--nota') + 1] if '--nota' in args else ''
        for doc in [a for a in args[:args.index('--nota')] if '--nota' in args] or args:
            revisados[doc] = {'fecha': datetime.now().isoformat(timespec='minutes'), 'nota': nota}
        REVISADOS.write_text(json.dumps(revisados, ensure_ascii=False, indent=1))
        print(f'{len(revisados)} reportes revisados')
        return

    red = _red()
    fs = red.Firestore()
    filas = fs._pedir(f'{red.API}:runQuery', {'structuredQuery': {'from': [{'collectionId': 'reportesTest'}]}})
    banco = {p['id']: p for p in json.loads((TEST / 'preguntas.json').read_text(encoding='utf-8'))['preguntas']}
    pendientes = []
    for fila in filas:
        d = fila.get('document')
        if not d:
            continue
        doc = d['name'].rsplit('/', 1)[1]
        r = {k: valor(v) for k, v in d.get('fields', {}).items()}
        p = banco.get(r.get('pregunta'), {})
        f = TEST / 'explicaciones' / f"{p.get('examen', r.get('examen'))}.json"
        exp = json.loads(f.read_text(encoding='utf-8'))['explicaciones'].get(str(r.get('pregunta'))) if f.exists() else None
        (CARPETA / f'{doc}.json').write_text(json.dumps({'doc': doc, 'reporte': r, 'pregunta': p, 'explicacion': exp},
                                                        ensure_ascii=False, indent=1))
        if doc not in revisados or '--todos' in sys.argv:
            pendientes.append((r.get('creado') or '', doc, r))
    total = sum(1 for f in filas if f.get('document'))
    print(f'{total} reportes en Firestore; {len(pendientes)} por revisar → {CARPETA}')
    for creado, doc, r in sorted(pendientes):
        print(f"- {doc} · {creado[:16]} · pregunta {r.get('pregunta')} ({r.get('examen')}, n.º {r.get('numero')}) · "
              f"{r.get('motivo')} · marcó {r.get('elegida') or '—'}: {(r.get('comentario') or '').replace(chr(10), ' ')[:300]}")


if __name__ == '__main__':
    main()
