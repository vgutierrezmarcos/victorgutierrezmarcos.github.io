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
.symbols (depuración) ni el service worker de Flutter (desactivado); sí
avisos-sw.js, el de los avisos del navegador (sin caché).
"""
import argparse
import hashlib
import json
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
    poner_huella()
    total = sum(f.stat().st_size for f in DESTINO.rglob('*') if f.is_file())
    print(f'Copiado a {DESTINO.relative_to(RAIZ)} ({total / 1048576:.1f} MB)')


def poner_huella():
    """GitHub Pages deja guardar cada fichero 10 minutos y main.dart.js se
    llama siempre igual, así que el navegador podía seguir con la versión
    anterior. Se renombra con una huella de su contenido (main.<huella>.dart.js)
    y index.html carga flutter_bootstrap.js con esa misma huella."""
    principal = DESTINO / 'main.dart.js'
    huella = hashlib.sha256(principal.read_bytes()).hexdigest()[:10]
    nuevo = f'main.{huella}.dart.js'
    principal.rename(DESTINO / nuevo)
    arranque = DESTINO / 'flutter_bootstrap.js'
    texto = arranque.read_text(encoding='utf-8')
    if 'main.dart.js' not in texto:
        sys.exit('flutter_bootstrap.js no menciona main.dart.js: revisa el arranque de Flutter.')
    arranque.write_text(texto.replace('main.dart.js', nuevo), encoding='utf-8')
    indice = DESTINO / 'index.html'
    html = indice.read_text(encoding='utf-8')
    if '__HUELLA__' not in html:
        sys.exit('index.html no tiene __HUELLA__: revisa app/web/index.html.')
    html = html.replace('src="flutter_bootstrap.js"', f'src="flutter_bootstrap.js?v={huella}"').replace('__HUELLA__', huella)
    indice.write_text(html, encoding='utf-8')
    # La app abierta compara su huella con la de version.json (que se pide
    # sin caché) para ofrecer «Recargar» cuando hay una versión nueva.
    version = DESTINO / 'version.json'
    datos = json.loads(version.read_text(encoding='utf-8'))
    datos['huella'] = huella
    datos['etiqueta'] = f"{datos.get('version', '')} ({datos.get('build_number', '')})"
    version.write_text(json.dumps(datos, ensure_ascii=False), encoding='utf-8')
    print(f'Huella de la versión: {huella}')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--sin-compilar', action='store_true', help='copiar la última compilación sin volver a compilar')
    a = p.parse_args()
    if not a.sin_compilar:
        compilar()
    copiar()
