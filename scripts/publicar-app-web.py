#!/usr/bin/env python3
"""Compila la app Flutter (app/) para el navegador y la deja en app/abrir/,
que GitHub Pages sirve en victorgutierrezmarcos.es/app/abrir/.

Uso (desde la raíz del repositorio):
    python3 scripts/publicar-app-web.py            # compila y copia
    python3 scripts/publicar-app-web.py --sin-compilar   # solo copia app/build/web

Después, subir app/abrir/ con el resto de cambios. Hay que repetirlo cada vez
que cambie el código de la app (lib/) o web/index.html.

El motor gráfico (canvaskit, ~37 MB) no se copia: el navegador lo descarga de
www.gstatic.com, como hace Flutter por defecto. Tampoco se copian los
.symbols (depuración) ni el service worker de Flutter (desactivado).
"""
import argparse
import shutil
import subprocess
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
APP = RAIZ / 'app'
ORIGEN = APP / 'build' / 'web'
DESTINO = APP / 'abrir'
RUTA_WEB = '/app/abrir/'
EXCLUIR = {'canvaskit', '.last_build_id', 'flutter_service_worker.js'}


def compilar():
    orden = ['flutter', 'build', 'web', '--release', '--base-href', RUTA_WEB, '--pwa-strategy=none', '--no-wasm-dry-run']
    print('>', ' '.join(orden), flush=True)
    subprocess.run(orden, cwd=APP, check=True, shell=sys.platform == 'win32')


def copiar():
    if not (ORIGEN / 'main.dart.js').exists():
        sys.exit(f'No existe {ORIGEN / "main.dart.js"}: compila primero.')
    if DESTINO.exists():
        shutil.rmtree(DESTINO)
    shutil.copytree(ORIGEN, DESTINO, ignore=lambda d, nombres: [n for n in nombres if n in EXCLUIR or n.endswith('.symbols')])
    total = sum(f.stat().st_size for f in DESTINO.rglob('*') if f.is_file())
    print(f'Copiado a {DESTINO.relative_to(RAIZ)} ({total / 1048576:.1f} MB)')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--sin-compilar', action='store_true', help='copiar la última compilación sin volver a compilar')
    a = p.parse_args()
    if not a.sin_compilar:
        compilar()
    copiar()
