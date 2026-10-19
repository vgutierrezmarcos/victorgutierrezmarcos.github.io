#!/usr/bin/env python3
"""
Reconstruye varios temas revisados (o todos) con las plantillas y los scripts
actuales, en dos pasadas para que las remisiones entre ellos apunten a la
página de cada tema revisado, y los publica en la rama de una vez.

    python3 scripts/temario/reconstruir-todos.py 3A08 3A09 …   # los que se digan
    python3 scripts/temario/reconstruir-todos.py --revisados   # todos los que tienen HTML en la rama
    opciones: --sin-fichas (no reconstruye las fichas de repaso), --sin-publicar,
              --sin-verificar, --excepto 3A10 (temas que no se tocan)

Para cada tema: construir-tema.py (gráficos, PDF, HTML y Word) y, si tiene
repaso/<T>-repaso.tex, construir-repaso.py. Después, una segunda pasada de
construir-tema.py --solo html de todos (los \\vertema a temas construidos en
esta tanda ya enlazan a su página, no a su PDF). Luego verificar-tema.py de
cada uno y publicar-tema.py con todos (índice, temario.json y buscador, con
deno una sola vez). Al final, un resumen por tema: páginas, letra de la ficha,
errores y avisos.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import glob
import json
import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, FUENTES, TEMARIO  # noqa: E402

AQUI = os.path.dirname(os.path.abspath(__file__))


def revisados():
    """Temas con fuente y HTML en la rama."""
    temas = []
    for d in sorted(glob.glob(os.path.join(FUENTES, '[34][AB][0-9][0-9]'))):
        t = Tema(os.path.basename(d))
        if os.path.exists(os.path.join(t.dir_publico, f'{t.archivo}.html')):
            temas.append(t)
    return temas


def correr(script, *args, timeout=3600):
    orden = [sys.executable, os.path.join(AQUI, script), *args]
    r = subprocess.run(orden, capture_output=True, text=True, timeout=timeout)
    return r.returncode, r.stdout + r.stderr


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('temas', nargs='*')
    ap.add_argument('--revisados', action='store_true')
    ap.add_argument('--excepto', action='append', default=[])
    ap.add_argument('--sin-fichas', action='store_true')
    ap.add_argument('--sin-publicar', action='store_true')
    ap.add_argument('--sin-verificar', action='store_true')
    args = ap.parse_args()
    temas = revisados() if args.revisados else [Tema(t) for t in args.temas]
    excepto = {Tema(t).archivo for t in args.excepto}
    temas = [t for t in temas if t.archivo not in excepto]
    if not temas:
        ap.error('ningún tema (indica los códigos o --revisados)')
    resumen = {}
    fallos = []
    print('Temas:', ', '.join(t.codigo for t in temas), flush=True)
    for t in temas:
        print(f'\n=== {t.codigo}: construir-tema.py', flush=True)
        cod, salida = correr('construir-tema.py', t.archivo)
        print(salida.strip()[-1500:], flush=True)
        resumen[t.archivo] = {'construir': cod}
        if cod != 0:
            fallos.append(f'{t.codigo}: construir-tema.py falló')
            continue
        if not args.sin_fichas and os.path.exists(os.path.join(t.dir, 'repaso', f'{t.archivo}-repaso.tex')):
            print(f'=== {t.codigo}: construir-repaso.py', flush=True)
            cod, salida = correr('construir-repaso.py', t.archivo)
            print(salida.strip()[-800:], flush=True)
            resumen[t.archivo]['repaso'] = cod
            if cod != 0:
                fallos.append(f'{t.codigo}: construir-repaso.py falló')
    # Segunda pasada: el HTML de todos, con los destinos de \vertema ya al día
    # (y el enlace a la ficha si se acaba de crear)
    for t in temas:
        if resumen[t.archivo]['construir'] != 0:
            continue
        print(f'\n=== {t.codigo}: construir-tema.py --solo html (segunda pasada)', flush=True)
        cod, salida = correr('construir-tema.py', t.archivo, '--solo', 'html')
        if cod != 0:
            print(salida.strip()[-800:])
            fallos.append(f'{t.codigo}: segunda pasada del HTML falló')
    if not args.sin_verificar:
        for t in temas:
            cod, salida = correr('verificar-tema.py', t.archivo, '--json')
            try:
                v = json.loads(salida)
                resumen[t.archivo].update({'errores': v['errores'], 'avisos': v['avisos'], 'datos': v['datos']})
            except ValueError:
                resumen[t.archivo]['errores'] = [f'verificar-tema.py no devolvió JSON: {salida[-300:]}']
    if not args.sin_publicar:
        buenos = [t.archivo for t in temas if resumen[t.archivo]['construir'] == 0]
        print('\n=== publicar-tema.py', ' '.join(buenos), flush=True)
        cod, salida = correr('publicar-tema.py', *buenos)
        print(salida.strip()[-1500:])
        if cod != 0:
            fallos.append('publicar-tema.py falló')
    print('\n=== Resumen')
    for t in temas:
        r = resumen[t.archivo]
        d = r.get('datos', {})
        estado = t.estado()
        ficha = (estado.get('repaso') or {}).get('tam')
        print(f'{t.codigo}: tema {d.get("paginas_tema", "?")} págs. (anexos {d.get("paginas_anexos", 0)}, '
              f'bibliografía {d.get("paginas_bibliografia", 0)}); ficha {ficha or "-"} pt; '
              f'{len(r.get("errores", []))} errores, {len(r.get("avisos", []))} avisos')
        for e in r.get('errores', []):
            print('   ERROR', e)
    if fallos:
        print('\nFALLOS:\n  ' + '\n  '.join(fallos))
        sys.exit(1)


if __name__ == '__main__':
    main()
