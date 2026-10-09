#!/usr/bin/env python3
"""
Frecuencia de cada tema en el test del primer ejercicio de TCEE: cuántas
preguntas ha tenido cada tema del temario en cada examen oficial.

    python3 scripts/frecuencia-test.py

Lee oposicion/temario/primer-ejercicio/test/preguntas.json (el banco del
simulador, con el tema de cada pregunta) y examenes_sin_texto.json (exámenes
clasificados por tema de los que no está el texto) y escribe, en la misma
carpeta, frecuencia_temas.json. Lo usan la app (Probabilidades, ficha del tema,
mapa de calor, simulador y cronograma) y la página de probabilidad del test.

Hay que volver a ejecutarlo cada vez que se añade un examen o se cambia el
tema de alguna pregunta.

Autor: Víctor Gutiérrez Marcos
"""
import collections
import datetime
import json
import os

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TEST = os.path.join(RAIZ, 'oposicion', 'temario', 'primer-ejercicio', 'test')


def main():
    with open(os.path.join(TEST, 'preguntas.json'), encoding='utf-8') as f:
        banco = json.load(f)
    with open(os.path.join(TEST, 'examenes_sin_texto.json'), encoding='utf-8') as f:
        sin_texto = json.load(f)
    examenes = []
    for e in banco['examenes']:
        temas = collections.Counter(q['temas'][0] for q in banco['preguntas'] if q['examen'] == e['id'] and q.get('temas'))
        examenes.append({'id': e['id'], 'nombre': e['nombre'], 'anio': int(e['fecha'][:4]), 'preguntas': sum(temas.values()), 'temas': dict(sorted(temas.items()))})
    for e in sin_texto['examenes']:
        temas = collections.Counter(e['temas'].values())
        examenes.append({'id': e['id'], 'nombre': e['nombre'], 'anio': e['anio'], 'preguntas': sum(temas.values()), 'temas': dict(sorted(temas.items())), 'sinTexto': True})
    examenes.sort(key=lambda e: (-e['anio'], e['id']))
    # Los temas que entran en el test (partes A y B del tercer ejercicio), con su título.
    temas = {c: titulo for c, titulo in banco['temas'].items() if c.startswith(('3.A.', '3.B.'))}
    salida = {
        'actualizado': datetime.date.today().isoformat(),
        'explicacion': 'Preguntas de cada tema del temario en cada examen oficial del test (anuladas fuera). Una pregunta cuenta en su tema principal.',
        'temas': temas,
        'examenes': examenes,
    }
    with open(os.path.join(TEST, 'frecuencia_temas.json'), 'w', encoding='utf-8') as f:
        json.dump(salida, f, ensure_ascii=False, indent=1)
    print(f'{len(examenes)} exámenes, {sum(e["preguntas"] for e in examenes)} preguntas')


if __name__ == '__main__':
    main()
