#!/usr/bin/env python3
"""Autoevaluación de los temas revisados: comprueba las preguntas y rehace el índice.

Cada tema revisado con ficha de repaso lleva 24 preguntas cortas en
oposicion/temario/app/autoevaluacion/<archivo>.json (las redactan agentes a
partir del tema y su ficha; ver la fase en .claude/skills/revisartema). La
app las enseña en la ficha del tema («Autoevalúate»), con Leitner por tema.
Son materiales exclusivos (uso personal), como el tema revisado.

    python3 scripts/autoevaluacion.py                 # comprueba todas y escribe indice.json
    python3 scripts/autoevaluacion.py --comprobar F   # solo comprueba ese fichero (para los agentes)

Autor: Víctor Gutiérrez Marcos
"""
import json
import re
import sys
from datetime import date
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
CARPETA = RAIZ / 'oposicion/temario/app/autoevaluacion'
TIPOS = {'definicion', 'formula', 'prediccion', 'vf'}
N = 24


def comprobar(ruta):
    """Lista de problemas del fichero (vacía si está bien)."""
    p = []
    try:
        d = json.loads(Path(ruta).read_text(encoding='utf-8'))
    except Exception as e:  # noqa: BLE001
        return [f'no es JSON válido: {e}']
    archivo = Path(ruta).stem
    if d.get('archivo') != archivo:
        p.append(f"«archivo» debería ser {archivo}")
    if not re.fullmatch(r'\d\.[AB]\.\d{1,2}', str(d.get('codigo', ''))):
        p.append('«codigo» con formato 3.A.8')
    qs = d.get('preguntas')
    if not isinstance(qs, list):
        return p + ['falta la lista «preguntas»']
    if len(qs) != N:
        p.append(f'hay {len(qs)} preguntas y tienen que ser {N}')
    vistos = set()
    tipos = {t: 0 for t in TIPOS}
    for i, q in enumerate(qs, 1):
        donde = f'pregunta {i}'
        if not isinstance(q, dict):
            p.append(f'{donde}: no es un objeto')
            continue
        esperado = f'{archivo}-{i:02d}'
        if q.get('id') != esperado:
            p.append(f'{donde}: id {q.get("id")!r}, debería ser {esperado}')
        if q.get('id') in vistos:
            p.append(f'{donde}: id repetido')
        vistos.add(q.get('id'))
        t = q.get('tipo')
        if t not in TIPOS:
            p.append(f'{donde}: tipo {t!r} (uno de {sorted(TIPOS)})')
        else:
            tipos[t] += 1
        for campo, maximo in (('pregunta', 220), ('respuesta', 450), ('apartado', 160)):
            v = q.get(campo)
            if not isinstance(v, str) or not v.strip():
                p.append(f'{donde}: falta «{campo}»')
            elif len(v) > maximo:
                p.append(f'{donde}: «{campo}» tiene {len(v)} caracteres (máximo {maximo})')
            elif v.replace('\\$', '').count('$') % 2:
                p.append(f'{donde}: «{campo}» con un $ sin cerrar')
            elif re.search(r'\\(optim|tcefecha|tcee\w*)\b', v):
                p.append(f'{donde}: «{campo}» usa una macro propia del tema')
        if t == 'vf':
            if not isinstance(q.get('verdadero'), bool):
                p.append(f'{donde}: en «vf», «verdadero» tiene que ser true o false')
            elif not str(q.get('respuesta', '')).startswith('Verdadero' if q['verdadero'] else 'Falso'):
                p.append(f'{donde}: la respuesta de «vf» debe empezar por «{"Verdadero" if q["verdadero"] else "Falso"}»')
        elif 'verdadero' in q:
            p.append(f'{donde}: «verdadero» solo en las de tipo vf')
    if tipos['vf'] < 3 or tipos['definicion'] < 3:
        p.append(f'reparto de tipos raro: {tipos}')
    return p


def main():
    if '--comprobar' in sys.argv:
        rutas = sys.argv[sys.argv.index('--comprobar') + 1:]
        mal = 0
        for r in rutas:
            problemas = comprobar(r)
            print(f'{r}: ' + ('bien' if not problemas else f'{len(problemas)} problemas'))
            for x in problemas:
                print('  -', x)
            mal += bool(problemas)
        sys.exit(1 if mal else 0)
    indice, mal = {}, 0
    for f in sorted(CARPETA.glob('*.json')):
        if f.name == 'indice.json':
            continue
        problemas = comprobar(f)
        if problemas:
            mal += 1
            print(f'{f.name}: {len(problemas)} problemas (no entra en el índice)')
            for x in problemas:
                print('  -', x)
            continue
        d = json.loads(f.read_text(encoding='utf-8'))
        indice[d['codigo']] = {'archivo': d['archivo'], 'preguntas': len(d['preguntas'])}
    salida = {'actualizado': date.today().isoformat(), 'temas': indice}
    (CARPETA / 'indice.json').write_text(json.dumps(salida, ensure_ascii=False, indent=1) + '\n', encoding='utf-8')
    print(f'indice.json: {len(indice)} temas{f", {mal} con problemas" if mal else ""}')
    sys.exit(1 if mal else 0)


if __name__ == '__main__':
    main()
