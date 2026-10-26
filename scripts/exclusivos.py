#!/usr/bin/env python3
"""
Registro de los materiales exclusivos (publicados o revisados desde el 1 de
octubre de 2026): oposicion/exclusivos.json, que leen la web (exclusivos.js:
etiqueta «Exclusivo», llamada a la app y la sección «Materiales exclusivos»)
y los scripts que sellan los ficheros (sellar-exclusivo.py).

    python3 scripts/exclusivos.py

De dónde sale cada cosa:
- Los temas revisados y la guía del dictamen: del manifiesto de la app
  (oposicion/temario/app/revisados.json de la rama revision-temario; se lee del
  árbol hermano ../victorgutierrezmarcos.github.io-revision si existe y, si no,
  de raw.githubusercontent.com). Entra todo lo aprobado desde el corte.
- Los ficheros de la web: la lista WEB de abajo (añadir aquí lo nuevo); la fecha
  es la del último commit que los tocó.
- Las explicaciones del test: fijas (solo en la app).

Nada se marca a mano en las páginas: el campo «exclusivo» vive aquí.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import subprocess
import sys
import urllib.request
from datetime import date

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SALIDA = os.path.join(RAIZ, 'oposicion', 'exclusivos.json')
REVISION = os.path.join(os.path.dirname(RAIZ), 'victorgutierrezmarcos.github.io-revision', 'oposicion', 'temario', 'app', 'revisados.json')
REVISION_RAW = 'https://raw.githubusercontent.com/vgutierrezmarcos/victorgutierrezmarcos.github.io/revision-temario/oposicion/temario/app/revisados.json'

CORTE = '2026-10-01'
AVISO = ('Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. '
         'Puedes usarlo libremente para tu estudio personal. No se autoriza su incorporación a otras plataformas, aplicaciones o servicios.')
PIE = '© Víctor Gutiérrez Marcos · Exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE'
CONDICIONES = 'https://www.victorgutierrezmarcos.es/condiciones-materiales.html'

# Ficheros de la web que son exclusivos (ruta desde la raíz del sitio). Las
# recopilaciones de exámenes oficiales quedan fuera (Víctor, 27 oct. 2026): los
# exámenes son del Ministerio y no llevan aviso. Formato de cada entrada:
# {'ruta': 'oposicion/…/fichero.pdf', 'tipo': 'guia', 'titulo': '…'}
WEB = []


def fecha_git(ruta):
    try:
        return subprocess.run(['git', 'log', '-1', '--format=%ad', '--date=short', '--', ruta], cwd=RAIZ, capture_output=True, text=True).stdout.strip() or None
    except OSError:
        return None


def manifiesto():
    if os.path.exists(REVISION):
        with open(REVISION, encoding='utf-8') as f:
            return json.load(f), 'local'
    try:
        with urllib.request.urlopen(REVISION_RAW, timeout=20) as r:
            return json.load(r), 'raw'
    except Exception as e:  # noqa: BLE001
        print(f'Aviso: sin manifiesto de la app ({e}); solo los ficheros de la web.', file=sys.stderr)
        return None, None


def main():
    materiales = []
    for w in WEB:
        f = fecha_git(w['ruta'])
        if f and f < CORTE:
            print(f'Aviso: {w["ruta"]} es anterior al corte ({f}); entra porque está en la lista.', file=sys.stderr)
        materiales.append({**w, 'donde': 'web', 'fecha': f, 'formatos': [w['ruta'].rsplit('.', 1)[-1]], 'sellar': True})
    m, origen = manifiesto()
    if m:
        temas = m.get('temas') or {}
        temas = temas.items() if isinstance(temas, dict) else [(t.get('codigo'), t) for t in temas]
        for codigo, t in temas:
            if (t.get('aprobado') or '') < CORTE:
                continue
            formatos = [k for k in ('pdf', 'html', 'docx') if t.get(k)] + (['repaso'] if t.get('repaso') else [])
            materiales.append({'tipo': 'tema', 'codigo': codigo, 'titulo': t.get('titulo', ''), 'donde': 'app', 'fecha': t.get('aprobado'), 'revisado': t.get('fecha'), 'formatos': formatos})
        d = m.get('dictamen')
        if d and (d.get('aprobado') or '') >= CORTE:
            formatos = [k for k in ('pdf', 'html', 'docx') if d.get(k)] + (['repaso'] if d.get('repaso') else [])
            materiales.append({'tipo': 'guia', 'codigo': d.get('archivo', '1D01'), 'titulo': d.get('titulo', 'Guía para el dictamen de coyuntura económica'), 'donde': 'app', 'fecha': d.get('aprobado'), 'revisado': d.get('fecha'), 'formatos': formatos})
    materiales.append({'tipo': 'test', 'codigo': 'explicaciones', 'titulo': 'Explicaciones de las 1004 preguntas oficiales del test («¿Por qué?»), con 232 gráficos', 'donde': 'app', 'fecha': '2026-10-24', 'formatos': ['app']})
    salida = {
        'generado': date.today().isoformat(),
        'corte': CORTE,
        'condiciones': CONDICIONES,
        'aviso': AVISO,
        'pie': PIE,
        'origenManifiesto': origen,
        'materiales': materiales,
    }
    with open(SALIDA, 'w', encoding='utf-8') as f:
        json.dump(salida, f, ensure_ascii=False, indent=2)
        f.write('\n')
    por = {}
    for x in materiales:
        por[x['donde']] = por.get(x['donde'], 0) + 1
    print(f'{len(materiales)} materiales exclusivos ({por}) -> {os.path.relpath(SALIDA, RAIZ)}')


if __name__ == '__main__':
    main()
