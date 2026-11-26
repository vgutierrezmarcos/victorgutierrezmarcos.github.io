#!/usr/bin/env python3
"""Sube los temas revisados al almacén privado del conector (R2 «tcee-temario»).

Víctor (26/11/2026): los temas revisados se protegen de verdad: no están en ningún sitio
público y solo los sirve el Worker (mcp/worker/src/temarioPrivado.ts) a quien ha iniciado
sesión con Google. Este script los lleva allí desde la rama de publicación (una referencia
de git: hoy temario-publicado; desde el cierre, la del repositorio privado):

  - manifiesto.json   el de la rama, sin las bases raw/cdn de GitHub (lo lee la app 1.28
                      y la web en /temario/manifiesto)
  - de cada tema y de la guía del dictamen: PDF, Word, HTML y ficha de repaso, con las
    rutas del manifiesto (oposicion/temario/tercer-ejercicio/3A08.pdf…)
  - los gráficos que enlaza cada HTML (oposicion/temario/fuentes/<T>/graficos/…); el resto
    de enlaces relativos del HTML (estilos, otras páginas, PDF del 4.º) se reescriben a la
    web, porque el HTML se sirve desde el Worker
  - el ZIP de la skill (oposicion/temario/app/prepara-con-claude.zip)
  - zip/materiales-tcee-con-revisados.zip (scripts/materiales-zip.py con estos PDF)
  - del árbol de trabajo de main (fuera de git desde el 26/11/2026): las explicaciones del
    test con sus gráficos (oposicion/temario/primer-ejercicio/test/explicaciones/*.json y
    graficos/*.webp) y la autoevaluación (oposicion/temario/app/autoevaluacion/*.json)

Solo sube lo que ha cambiado (huella de git o sha256) y borra del almacén lo que ya no
está. Necesita el secreto de subida en ~/.config/oposicion-red/temario-admin.token.

    python3 scripts/temario-privado.py                    # desde temario-publicado
    python3 scripts/temario-privado.py --ref <ref>        # otra referencia de git
    python3 scripts/temario-privado.py --git-dir <ruta>   # otro repositorio (el privado)
    python3 scripts/temario-privado.py --sin-zip          # sin rehacer el ZIP con revisados
    python3 scripts/temario-privado.py --seco             # solo dice qué haría

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import concurrent.futures as cf
import hashlib
import importlib.util
import json
import os
import posixpath
import re
import subprocess
import sys
import tempfile
import urllib.error
import urllib.parse
import urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WORKER = 'https://mcp.victorgutierrezmarcos.es'
WEB = 'https://www.victorgutierrezmarcos.es/'
MANIFIESTO = 'oposicion/temario/app/revisados.json'
TOKEN = os.path.expanduser('~/.config/oposicion-red/temario-admin.token')
PARTE = 50 * 1024 * 1024
ENLACE = re.compile(r'(\s(?:src|href)=")([^"]+)(")')
# Material exclusivo que se genera en main (scripts/explicaciones-test.py, graficos-explicaciones.py,
# autoevaluacion.py) y no se sube a git: carpeta → extensiones que van al almacén.
LOCALES = {
    'oposicion/temario/primer-ejercicio/test/explicaciones': ('.json',),
    'oposicion/temario/primer-ejercicio/test/explicaciones/graficos': ('.webp',),
    'oposicion/temario/app/autoevaluacion': ('.json',),
}


class Git:
    def __init__(self, git_dir, ref):
        self.base = ['git', '--git-dir', git_dir] if git_dir else ['git', '-C', RAIZ]
        self.ref = ref
        salida = subprocess.run(self.base + ['ls-tree', '-r', '-l', ref], capture_output=True, text=True, check=True).stdout
        self.blobs = {}
        for linea in salida.splitlines():
            meta, ruta = linea.split('\t', 1)
            _, tipo, sha, tam = meta.split()
            if tipo == 'blob':
                self.blobs[ruta] = (sha, int(tam))

    def leer(self, ruta):
        return subprocess.run(self.base + ['cat-file', 'blob', self.blobs[ruta][0]], capture_output=True, check=True).stdout


def pedir(metodo, ruta, cuerpo=None, token='', tipo=None, intentos=4):
    url = WORKER + ruta
    for i in range(intentos):
        req = urllib.request.Request(url, data=cuerpo, method=metodo, headers={'Authorization': f'Bearer {token}', 'User-Agent': 'temario-privado'})
        if tipo:
            req.add_header('Content-Type', tipo)
        try:
            with urllib.request.urlopen(req, timeout=600) as r:
                return json.loads(r.read() or b'{}')
        except urllib.error.HTTPError as e:
            if e.code < 500 or i == intentos - 1:
                raise SystemExit(f'{metodo} {ruta}: HTTP {e.code} {e.read()[:200]!r}')
        except (urllib.error.URLError, TimeoutError) as e:
            if i == intentos - 1:
                raise SystemExit(f'{metodo} {ruta}: {e}')


def clave_url(clave):
    return '/temario/admin/f/' + urllib.parse.quote(clave)


def subir(clave, datos, sha, token):
    if len(datos) <= 90 * 1024 * 1024:
        pedir('PUT', f'{clave_url(clave)}?sha={sha}', datos, token)
        return
    s = pedir('POST', f'{clave_url(clave)}?subida=crear&sha={sha}', b'', token)['subida']
    partes = []
    for n, i in enumerate(range(0, len(datos), PARTE), 1):
        partes.append(pedir('PUT', f'{clave_url(clave)}?subida={urllib.parse.quote(s)}&parte={n}', datos[i:i + PARTE], token))
    pedir('POST', f'{clave_url(clave)}?subida={urllib.parse.quote(s)}&sha={sha}', json.dumps(partes).encode(), token, 'application/json')


def reescribir_html(ruta, html, privados):
    """Enlaces relativos: a lo privado se quedan relativos; a lo demás, a la web."""
    carpeta = posixpath.dirname(ruta)
    graficos = set()

    def cambia(m):
        valor = m.group(2)
        if re.match(r'^(?:[a-z]+:|//|#|data:)', valor, re.I):
            return m.group(0)
        sin_frag = re.split(r'[?#]', valor, 1)[0]
        resto = valor[len(sin_frag):]
        destino = posixpath.normpath(posixpath.join(carpeta, urllib.parse.unquote(sin_frag)))
        if destino in privados or re.match(r'^oposicion/temario/fuentes/[^/]+/graficos/', destino):
            if destino not in privados:
                graficos.add(destino)
            return m.group(0)
        return f'{m.group(1)}{WEB}{urllib.parse.quote(destino)}{resto}{m.group(3)}'

    texto = ENLACE.sub(cambia, html.decode('utf-8'))
    return texto.encode('utf-8'), graficos


def materiales_zip_con(revisados_dir, salida):
    spec = importlib.util.spec_from_file_location('materiales_zip', os.path.join(RAIZ, 'scripts', 'materiales-zip.py'))
    mz = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mz)
    mz.PRIVADO = revisados_dir
    filas, revisados = mz.materiales()
    mz.escribir(salida, filas, True, revisados)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('--ref', default='origin/temario-publicado')
    ap.add_argument('--git-dir')
    ap.add_argument('--sin-zip', action='store_true')
    ap.add_argument('--seco', action='store_true')
    a = ap.parse_args()
    token = open(TOKEN).read().strip()
    git = Git(a.git_dir, a.ref)
    manifiesto = json.loads(git.leer(MANIFIESTO))

    entradas = list(manifiesto.get('temas', []))
    if manifiesto.get('dictamen'):
        entradas.append(manifiesto['dictamen'])
    privados = {}
    for t in entradas:
        for c in ('pdf', 'docx', 'html', 'repaso'):
            f = t.get(c)
            if f and f.get('ruta') in git.blobs:
                privados[f['ruta']] = None
    skill = (manifiesto.get('skill') or {}).get('ruta')
    if skill in git.blobs:
        privados[skill] = None

    # Contenido y huella de cada clave
    ficheros = {}
    graficos = set()
    for ruta in privados:
        if ruta.endswith('.html'):
            datos, g = reescribir_html(ruta, git.leer(ruta), privados)
            graficos |= g
            ficheros[ruta] = (lambda d=datos: d, hashlib.sha256(datos).hexdigest()[:40])
        else:
            ficheros[ruta] = (lambda r=ruta: git.leer(r), git.blobs[ruta][0])
    faltan = sorted(g for g in graficos if g not in git.blobs)
    for g in graficos:
        if g in git.blobs:
            ficheros[g] = (lambda r=g: git.leer(r), git.blobs[g][0])

    for carpeta, extensiones in LOCALES.items():
        absoluta = os.path.join(RAIZ, carpeta)
        if not os.path.isdir(absoluta):
            print(f'Ojo: no está {carpeta} (se dejan en el almacén las que hubiera)')
            continue
        for nombre in sorted(os.listdir(absoluta)):
            if nombre.endswith(extensiones):
                ruta = f'{carpeta}/{nombre}'
                with open(os.path.join(RAIZ, ruta), 'rb') as fh:
                    sha = hashlib.sha256(fh.read()).hexdigest()[:40]
                ficheros[ruta] = (lambda r=ruta: open(os.path.join(RAIZ, r), 'rb').read(), sha)

    publico = dict(manifiesto)
    for k in ('raw', 'cdn'):
        publico.pop(k, None)
    publico['servidor'] = WORKER + '/t/'
    m_bytes = json.dumps(publico, ensure_ascii=False, indent=1).encode('utf-8')
    ficheros['manifiesto.json'] = (lambda: m_bytes, hashlib.sha256(m_bytes).hexdigest()[:40])

    if not a.sin_zip:
        # Los PDF, en las rutas que espera materiales-zip.py (las de revisados-web.json de main)
        rw = json.load(open(os.path.join(RAIZ, 'oposicion/temario/revisados-web.json'), encoding='utf-8'))
        rutas_web = {('1D01' if t['codigo'] == 'Dictamen' else t['archivo']): t for t in rw['temas']}
        with tempfile.TemporaryDirectory() as tmp:
            for t in entradas:
                web = rutas_web.get(t.get('archivo'))
                for c in ('pdf', 'repaso'):
                    f = t.get(c)
                    if web and web.get(c) and f and f.get('ruta') in git.blobs:
                        destino = os.path.join(tmp, web[c])
                        os.makedirs(os.path.dirname(destino), exist_ok=True)
                        with open(destino, 'wb') as fh:
                            fh.write(git.leer(f['ruta']))
            zip_local = os.path.join(os.path.expanduser('~/.local/share/oposicion-web'), 'materiales-tcee-con-revisados.zip')
            os.makedirs(os.path.dirname(zip_local), exist_ok=True)
            materiales_zip_con(tmp, zip_local)
        h = hashlib.sha256()
        with open(zip_local, 'rb') as fh:
            for trozo in iter(lambda: fh.read(1 << 20), b''):
                h.update(trozo)
        ficheros['zip/materiales-tcee-con-revisados.zip'] = (lambda: open(zip_local, 'rb').read(), h.hexdigest()[:40])

    hay = {c['clave']: c['sha'] for c in pedir('GET', '/temario/admin/lista', token=token)['claves']}
    if a.sin_zip and 'zip/materiales-tcee-con-revisados.zip' in hay:
        ficheros.setdefault('zip/materiales-tcee-con-revisados.zip', (None, hay['zip/materiales-tcee-con-revisados.zip']))
    nuevos = [k for k, (_, sha) in ficheros.items() if hay.get(k) != sha and k != 'manifiesto.json']
    # Lo local que no está (carpeta ausente) no se borra del almacén
    ausentes = [c for c in LOCALES if not os.path.isdir(os.path.join(RAIZ, c))]
    sobran = [k for k in hay if k not in ficheros and not any(k.startswith(c + '/') for c in ausentes)]
    cambia_manifiesto = hay.get('manifiesto.json') != ficheros['manifiesto.json'][1]
    print(f'{len(ficheros)} ficheros; {len(nuevos)} por subir, {len(sobran)} por borrar, manifiesto {"nuevo" if cambia_manifiesto else "igual"}')
    if faltan:
        print(f'Ojo: {len(faltan)} gráficos enlazados no están en la rama: {faltan[:5]}')
    if a.seco:
        for k in nuevos[:30]:
            print('  +', k)
        for k in sobran[:30]:
            print('  -', k)
        return

    def uno(k):
        leer, sha = ficheros[k]
        subir(k, leer(), sha, token)
        return k

    with cf.ThreadPoolExecutor(8) as ex:
        for i, k in enumerate(ex.map(uno, sorted(nuevos, key=lambda k: k.endswith('.zip'))), 1):
            if i % 50 == 0 or i == len(nuevos):
                print(f'  {i}/{len(nuevos)} subidos')
    if cambia_manifiesto:
        subir('manifiesto.json', m_bytes, ficheros['manifiesto.json'][1], token)
    for k in sobran:
        pedir('DELETE', clave_url(k), token=token)
    print('Almacén al día.')


if __name__ == '__main__':
    sys.exit(main())
