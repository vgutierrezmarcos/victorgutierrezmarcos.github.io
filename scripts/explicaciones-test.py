#!/usr/bin/env python3
"""Monta las explicaciones del test que lee la app (botón «¿Por qué?»).

Parte de una explicación por pregunta en ~/.local/share/oposicion-web/explicaciones-test/<id>.json
(formato en FORMATO.md de esa carpeta; las redactan y verifican agentes con el
temario como fuente) y escribe, por examen,
oposicion/temario/primer-ejercicio/test/explicaciones/<examen>.json solo con lo
que se publica (clave, desarrollo, opciones, gráficos, temas y fuentes). Las
discrepancias con la clave oficial y las notas del verificador no se publican:
salen en discrepancias.json de la carpeta de origen para revisarlas.

    python3 scripts/explicaciones-test.py            # monta y comprueba
    python3 scripts/explicaciones-test.py --origen <carpeta>

Comprueba que haya una explicación por pregunta, que la opción marcada como
respuesta sea la oficial y que los `$` de las fórmulas vayan por pares.
Exclusivas de la app: la web no las enlaza.
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
TEST = RAIZ / 'oposicion/temario/primer-ejercicio/test'
GRAFICOS = TEST / 'explicaciones/graficos'
ORIGEN = Path.home() / '.local/share/oposicion-web/explicaciones-test'
PUBLICO = ('clave', 'desarrollo', 'opciones', 'graficos', 'temas', 'fuentes')


def textos(e):
    yield e.get('clave', '')
    yield e.get('desarrollo', '')
    for o in e.get('opciones', {}).values():
        yield o.get('texto', '')


def main():
    origen = Path(sys.argv[sys.argv.index('--origen') + 1]) if '--origen' in sys.argv else ORIGEN
    banco = json.loads((TEST / 'preguntas.json').read_text(encoding='utf-8'))['preguntas']
    por_examen = defaultdict(dict)
    avisos, discrepancias = [], []
    for p in banco:
        f = origen / f"{p['id']}.json"
        if not f.exists():
            avisos.append(f"{p['id']}: sin explicación")
            continue
        e = json.loads(f.read_text(encoding='utf-8'))
        marcadas = sorted(k for k, o in e.get('opciones', {}).items() if o.get('es_respuesta'))
        if p.get('tipo_pregunta') != 'aceptada' and marcadas != sorted(p['respuesta']):
            avisos.append(f"{p['id']}: marca {marcadas} y la clave oficial es {p['respuesta']}")
        for t in textos(e):
            if t.replace('\\$', '').count('$') % 2:
                avisos.append(f"{p['id']}: «$» sin pareja")
        for g in e.get('graficos', []):
            if not (GRAFICOS / f"{g['archivo']}.webp").exists():
                avisos.append(f"{p['id']}: falta el gráfico {g['archivo']}.webp (scripts/graficos-explicaciones.py)")
        if e.get('discrepancia'):
            discrepancias.append({'id': p['id'], 'examen': p['examen'], 'numero': p['numero'], 'temas': p['temas'],
                                  'respuesta_oficial': p['respuesta'], **e['discrepancia'],
                                  'fuentes': e.get('fuentes', []), 'confianza': e.get('confianza')})
        por_examen[p['examen']][str(p['id'])] = {k: e[k] for k in PUBLICO if k in e}
    destino = TEST / 'explicaciones'
    destino.mkdir(exist_ok=True)
    for examen, exp in por_examen.items():
        (destino / f'{examen}.json').write_text(
            json.dumps({'examen': examen, 'explicaciones': exp}, ensure_ascii=False, separators=(',', ':')), encoding='utf-8')
    (origen / 'discrepancias.json').write_text(json.dumps(discrepancias, ensure_ascii=False, indent=1), encoding='utf-8')
    total = sum(len(v) for v in por_examen.values())
    print(f'{total} explicaciones en {len(por_examen)} exámenes → {destino.relative_to(RAIZ)}')
    print(f'{len(discrepancias)} discrepancias con la clave oficial → {origen / "discrepancias.json"}')
    for a in avisos:
        print('AVISO', a)
    sys.exit(1 if avisos else 0)


if __name__ == '__main__':
    main()
