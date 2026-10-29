#!/usr/bin/env python3
"""APK de respaldo: la versión de producción de Google Play, firmada por Google,
como descarga directa en la release `app-latest` de GitHub (oposicion-tcee.apk,
el `urlApk` de oposicion/app-config.json).

Baja de la API de Play el APK universal que Google genera para la versión que
hay en producción (o la de --codigo), comprueba que lleva la firma de Play (la
misma huella SHA-256 que .well-known/assetlinks.json) y sustituye el de la
release. Se ejecuta tras cada versión aprobada en producción (paso 7 de la
skill /play); si la release ya tiene esa versión, no hace nada.

    python3 scripts/apk-respaldo.py              # la de producción
    python3 scripts/apk-respaldo.py --codigo 65  # una concreta
    python3 scripts/apk-respaldo.py --sin-subir  # solo bajarla y comprobarla

Necesita la cuenta de servicio de play.py (con permiso de descarga en Play
Console), `gh` con permiso de escritura en el repositorio y, para comprobar la
firma, apksigner (Android SDK de ~/.local/share/tcee-herramientas).

Autor: Víctor Gutiérrez Marcos
"""
import importlib.util
import json
import re
import subprocess
import sys
import urllib.request
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = Path.home() / '.local/share/tcee-herramientas/salida'
RELEASE = 'app-latest'
NOMBRE = 'oposicion-tcee.apk'
HERRAMIENTAS = Path.home() / '.local/share/tcee-herramientas'

_s = importlib.util.spec_from_file_location('play', RAIZ / 'scripts/play.py')
play = importlib.util.module_from_spec(_s)
_s.loader.exec_module(play)


def huella_play():
    d = json.loads((RAIZ / '.well-known/assetlinks.json').read_text(encoding='utf-8'))
    return d[0]['target']['sha256_cert_fingerprints'][0].replace(':', '').lower()


def codigo_produccion(api):
    e = play.Edicion(api)
    try:
        pista = e.pista('production')
    finally:
        e.descartar()
    vs = [v for v in pista.get('releases', []) if v.get('status') in ('completed', 'inProgress')]
    codigos = [int(c) for v in vs for c in v.get('versionCodes', [])]
    if not codigos:
        sys.exit('No hay ninguna versión en producción.')
    nombre = next((v.get('name', '') for v in vs if str(max(codigos)) in v.get('versionCodes', [])), '')
    return max(codigos), nombre


def bajar(api, codigo, destino):
    r = api.pedir('GET', f'{play.API}/generatedApks/{codigo}')
    universal = next((g['generatedUniversalApk']['downloadId'] for g in r.get('generatedApks', []) if g.get('generatedUniversalApk')), None)
    if not universal:
        sys.exit(f'Google aún no ha generado el APK universal de la versión {codigo}.')
    url = f'{play.API}/generatedApks/{codigo}/downloads/{universal}:download?alt=media'
    pet = urllib.request.Request(url, headers={'Authorization': f'Bearer {api.t}'})
    with urllib.request.urlopen(pet, timeout=600) as resp, open(destino, 'wb') as f:
        while bloque := resp.read(1 << 20):
            f.write(bloque)


def comprobar_firma(apk):
    apksigner = sorted((HERRAMIENTAS / 'android-sdk/build-tools').glob('*/apksigner'))
    if not apksigner:
        print('Sin apksigner: no se comprueba la firma.')
        return
    env = {'JAVA_HOME': str(HERRAMIENTAS / 'jdk'), 'PATH': f"{HERRAMIENTAS / 'jdk/bin'}:/usr/bin:/bin"}
    out = subprocess.run([str(apksigner[-1]), 'verify', '--print-certs', str(apk)], capture_output=True, text=True, env=env)
    huellas = re.findall(r'SHA-256 digest: ([0-9a-f]{64})', out.stdout)
    if out.returncode != 0 or huella_play() not in huellas:
        sys.exit(f'La firma del APK no es la de Google Play:\n{out.stdout}{out.stderr}')
    print('Firma de Google Play comprobada.')


def version_subida():
    """Versión que dice la descripción de la release («1.22.0 (65)»), o ''."""
    out = subprocess.run(['gh', 'release', 'view', RELEASE, '--json', 'body', '--jq', '.body'], capture_output=True, text=True, cwd=RAIZ)
    m = re.search(r'APK de respaldo: (\S+ \(\d+\))', out.stdout or '')
    return m.group(1) if m else ''


def main():
    api = play.Api()
    if '--codigo' in sys.argv:
        codigo = int(sys.argv[sys.argv.index('--codigo') + 1])
        nombre = f'({codigo})'
    else:
        codigo, nombre = codigo_produccion(api)
    etiqueta = nombre if '(' in nombre else f'{nombre} ({codigo})'
    if version_subida() == etiqueta and '--forzar' not in sys.argv:
        print(f'La release {RELEASE} ya tiene la {etiqueta}.')
        return
    SALIDA.mkdir(parents=True, exist_ok=True)
    apk = SALIDA / f'oposicion-tcee-{codigo}-universal.apk'
    print(f'Bajando el APK universal de la {etiqueta}…')
    bajar(api, codigo, apk)
    print(f'{apk} ({apk.stat().st_size / 1e6:.0f} MB)')
    comprobar_firma(apk)
    if '--sin-subir' in sys.argv:
        return
    # Se sube con otro nombre y se cambia después: si la subida falla a medias,
    # la release sigue con el APK anterior.
    temporal = apk.with_name(NOMBRE)
    temporal.write_bytes(apk.read_bytes())
    subprocess.run(['gh', 'release', 'upload', RELEASE, f'{temporal}#{NOMBRE}', '--clobber'], check=True, cwd=RAIZ)
    cuerpo = (f'APK de respaldo: {etiqueta}, el mismo que Google Play (firmado por Google). '
              'Lo normal es instalar la app desde Google Play; este fichero es para quien no puede usar la tienda.')
    subprocess.run(['gh', 'release', 'edit', RELEASE, '--notes', cuerpo], check=True, cwd=RAIZ)
    temporal.unlink()
    print(f'Release {RELEASE}: {NOMBRE} = {etiqueta}.')


if __name__ == '__main__':
    main()
