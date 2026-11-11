#!/usr/bin/env python3
"""Qué preguntas del test se fallan más, con los tests de todos los usuarios.

Recorre `users/{uid}/exam_results` (TCEE; DCE no tiene test) con la misma
cuenta de servicio de solo lectura que estadisticas-red.py y cuenta, pregunta
a pregunta, cuántas veces se ha visto, acertado, fallado y dejado en blanco.
Solo los tests de la app traen el detalle (`respuestas`: id → letra); los del
simulador web no, y se cuentan aparte. Nada identificable sale del script: ni
cuentas, ni uid, ni resultados individuales; solo recuentos por pregunta.

    python3 scripts/dificultad-test.py            # escribe el JSON y enseña las 20 más falladas
    python3 scripts/dificultad-test.py --no-escribir

Escribe oposicion/temario/primer-ejercicio/test/dificultad.json, que leen la
app y el simulador («esta pregunta la fallan 7 de cada 10»). Cada pregunta
lleva `v` (vistas), `a` (aciertos), `f` (fallos) y `b` (en blanco); se enseña
solo a partir de `minimo` vistas. Clave: ~/.config/oposicion-red/clave.json
(o $ESTADISTICAS_CLAVE), nunca en el repositorio.
"""
import importlib.util
import json
import sys
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
PREGUNTAS = RAIZ / 'oposicion/temario/primer-ejercicio/test/preguntas.json'
SALIDA = RAIZ / 'oposicion/temario/primer-ejercicio/test/dificultad.json'
MINIMO = 5  # vistas necesarias para enseñar la cifra de una pregunta

_spec = importlib.util.spec_from_file_location('estadisticas_red', RAIZ / 'scripts/estadisticas-red.py')
_red = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_red)


def respuestas_de(campos):
    """id → letra (o None, en blanco) del campo `respuestas` de un test, o None si no lo trae."""
    m = campos.get('respuestas', {}).get('mapValue')
    if m is None:
        return None
    salida = {}
    for k, v in m.get('fields', {}).items():
        salida[k] = v.get('stringValue') if 'stringValue' in v else None
    return salida


def recontar(fs, correctas):
    por_pregunta = defaultdict(Counter)
    tests = Counter()
    for u in fs.documentos('users'):
        uid = u['name'].rsplit('/', 1)[1]
        for d in fs.documentos(f'users/{uid}/exam_results'):
            if 'createTime' not in d:
                continue
            tests['total'] += 1
            r = respuestas_de(d.get('fields', {}))
            if r is None:
                tests['sin detalle (web)'] += 1
                continue
            tests['con detalle'] += 1
            for pid, letra in r.items():
                if pid not in correctas:
                    continue
                c = por_pregunta[pid]
                c['v'] += 1
                if letra is None or letra == '':
                    c['b'] += 1
                elif letra.lower() in correctas[pid]:
                    c['a'] += 1
                else:
                    c['f'] += 1
    return por_pregunta, tests


def main():
    banco = json.loads(PREGUNTAS.read_text(encoding='utf-8'))
    preguntas = {str(p['id']): p for p in banco['preguntas']}
    correctas = {pid: {str(x).lower() for x in (p.get('respuesta') or [])} for pid, p in preguntas.items()}
    examenes = {e['id']: e for e in banco['examenes']}

    fs = _red.Firestore()
    por_pregunta, tests = recontar(fs, correctas)
    ahora = datetime.now(timezone.utc)
    salida = {
        'actualizado': ahora.date().isoformat(),
        'minimo': MINIMO,
        'tests': tests['con detalle'],
        'preguntas': {pid: {'v': c['v'], 'a': c['a'], 'f': c['f'], 'b': c['b']} for pid, c in sorted(por_pregunta.items(), key=lambda kv: int(kv[0]))},
    }
    # Solo se reescribe si cambian los recuentos (no por la fecha): la acción diaria no hace commits vacíos.
    try:
        antes = json.loads(SALIDA.read_text(encoding='utf-8'))
    except Exception:
        antes = {}
    igual = antes.get('tests') == salida['tests'] and antes.get('preguntas') == salida['preguntas']
    if igual:
        print('Sin cambios en los recuentos.')
    elif '--no-escribir' not in sys.argv:
        SALIDA.write_text(json.dumps(salida, ensure_ascii=False, separators=(',', ':')) + '\n', encoding='utf-8')
        print(f'Escrito {SALIDA.relative_to(RAIZ)}')

    print(f"Tests: {tests['total']} ({tests['con detalle']} con detalle, {tests['sin detalle (web)']} del simulador web sin detalle)")
    print(f'Preguntas vistas al menos una vez: {len(por_pregunta)} de {len(preguntas)}; con {MINIMO} vistas o más: {sum(1 for c in por_pregunta.values() if c["v"] >= MINIMO)}')
    print()
    print(f'Las 20 más falladas (con {MINIMO} vistas o más; fallos y blancos sobre vistas):')
    filas = [(pid, c) for pid, c in por_pregunta.items() if c['v'] >= MINIMO]
    filas.sort(key=lambda kv: (-(kv[1]['f'] + kv[1]['b']) / kv[1]['v'], -kv[1]['v']))
    for pid, c in filas[:20]:
        p = preguntas[pid]
        ex = examenes.get(p['examen'], {}).get('nombre', p['examen'])
        print(f"  {100 * (c['f'] + c['b']) / c['v']:3.0f} %  {c['v']:3d} vistas  {c['f']:3d} fallos  {c['b']:3d} blancos  · {ex} nº {p['numero']} · {', '.join(p.get('temas') or [])} · {p['enunciado'][:70]}")


if __name__ == '__main__':
    main()
