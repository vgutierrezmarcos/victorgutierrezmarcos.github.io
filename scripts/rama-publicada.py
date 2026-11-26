#!/usr/bin/env python3
"""Crea la rama de publicación del temario (temario-publicado) SIN lo que nunca se publica.

Víctor (24/11/2026): «Para el dictamen, el ejemplo de España y su solución no lo subas en
ningún caso». La rama temario-publicado vive en el repositorio privado vgutierrezmarcos/tcee-temario
(remoto «privado», desde el 26/11/2026; antes era pública en este repositorio): la
leen la app, la web (exclusivos.js) y los scripts. Por eso no se publica empujando la rama
de trabajo (revision-temario-2) tal cual, sino una instantánea sin historia:

  1. Commit A (sin padre): el árbol de revision-temario-2 menos NUNCA (la carpeta
     oposicion/temario/fuentes/1D01/examen-espana/ y cualquier ruta con examen-espana o
     solucion-espana). Sin historia: desde temario-publicado no se llega a ningún commit
     que los tenga.
  2. Commit B (padre A): el manifiesto (oposicion/temario/app/revisados.json) con
     rama, commit, raw, cdn y skill.commit apuntando a A, para que la app y la web bajen los
     ficheros de la rama publicada y no de la de trabajo.
  3. La rama local temario-publicado pasa a B. El push lo hace Víctor (forzado: cada
     publicación es una instantánea nueva).

Se niega si algún ZIP del árbol (la skill) lleva dentro el examen o la solución.

    python3 scripts/rama-publicada.py                     # crea o rehace la rama local
    git -C ../victorgutierrezmarcos.github.io-revision-2 push --force privado temario-publicado
    python3 scripts/temario-privado.py                    # y al almacén del conector
    python3 scripts/rama-publicada.py --comprobar         # rama local y la de GitHub: sin nada de NUNCA
    python3 scripts/rama-publicada.py --origen <ref> --rama <nombre>   # para probar con otra rama

No toca el directorio de trabajo de ningún worktree (usa un índice temporal de git).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import io
import json
import os
import re
import subprocess
import sys
import tempfile
import zipfile

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WT = os.environ.get('TCEE_WORKTREE_REVISION', RAIZ + '-revision-2')
REPO = 'vgutierrezmarcos/victorgutierrezmarcos.github.io'
ORIGEN = 'revision-temario-2'
RAMA = 'temario-publicado'
MANIFIESTO = 'oposicion/temario/app/revisados.json'
# Lo que nunca se publica: carpetas enteras y cualquier ruta que case con el patrón.
NUNCA_CARPETAS = ('oposicion/temario/fuentes/1D01/examen-espana/',)
NUNCA_PATRON = re.compile(r'(examen|solucion)[-_]espana', re.I)


def git(*args, entrada=None, env=None, binario=False):
    r = subprocess.run(['git', '-C', WT, *args], input=entrada, capture_output=True, env=env)
    if r.returncode:
        raise RuntimeError(f'git {" ".join(args)}: {r.stderr.decode("utf-8", "replace").strip()}')
    return r.stdout if binario else r.stdout.decode('utf-8').rstrip('\n')


def prohibida(ruta):
    return ruta.startswith(NUNCA_CARPETAS) or bool(NUNCA_PATRON.search(ruta))


def problemas(ref):
    """Lo que no debería estar en el árbol de ref: rutas prohibidas y ZIP que las llevan dentro."""
    rutas = git('ls-tree', '-r', '--name-only', ref).splitlines()
    malos = [r for r in rutas if prohibida(r)]
    for r in rutas:
        if r.lower().endswith('.zip'):
            datos = git('cat-file', 'blob', f'{ref}:{r}', binario=True)
            try:
                dentro = zipfile.ZipFile(io.BytesIO(datos)).namelist()
            except zipfile.BadZipFile:
                continue
            malos += [f'{r} → {n}' for n in dentro if NUNCA_PATRON.search(n)]
    return malos


def crear(origen, rama):
    sha_origen = git('rev-parse', '--verify', f'{origen}^{{commit}}')
    with tempfile.TemporaryDirectory() as tmp:
        env = {**os.environ, 'GIT_INDEX_FILE': os.path.join(tmp, 'indice')}
        git('read-tree', sha_origen, env=env)
        fuera = [r for r in git('ls-files', env=env).splitlines() if prohibida(r)]
        if fuera:
            git('update-index', '--force-remove', '-z', '--stdin', entrada=('\0'.join(fuera) + '\0').encode(), env=env)
        arbol_a = git('write-tree', env=env)
        # Los ZIP (la skill) no pueden llevar el examen dentro.
        zips = []
        for r in git('ls-files', env=env).splitlines():
            if r.lower().endswith('.zip'):
                try:
                    dentro = zipfile.ZipFile(io.BytesIO(git('cat-file', 'blob', f'{arbol_a}:{r}', binario=True))).namelist()
                except zipfile.BadZipFile:
                    continue
                zips += [f'{r} → {n}' for n in dentro if NUNCA_PATRON.search(n)]
        if zips:
            sys.exit('No se publica: estos ZIP llevan el examen de España o su solución (reconstruye la skill con '
                     'scripts/skill-opositor.py, que ya no los mete, y confirma en la rama de revisión):\n  ' + '\n  '.join(zips))
        msg_a = (f'Temario publicado: instantánea de {origen} ({sha_origen[:10]}) sin el examen de ejemplo de España '
                 f'ni su solución ({len(fuera)} rutas fuera)')
        commit_a = git('commit-tree', arbol_a, '-m', msg_a)

        # El manifiesto, fijado a la instantánea publicada.
        m = json.loads(git('cat-file', 'blob', f'{arbol_a}:{MANIFIESTO}'))
        m.update({'rama': rama, 'commit': commit_a,
                  'raw': f'https://raw.githubusercontent.com/{REPO}/{commit_a}/',
                  'cdn': f'https://rawcdn.githack.com/{REPO}/{commit_a}/'})
        if isinstance(m.get('skill'), dict) and m['skill'].get('commit'):
            m['skill']['commit'] = commit_a
        texto = json.dumps(m, ensure_ascii=False, indent=1) + '\n'
        blob = git('hash-object', '-w', '--stdin', entrada=texto.encode('utf-8'))
        git('update-index', '--cacheinfo', f'100644,{blob},{MANIFIESTO}', env=env)
        arbol_b = git('write-tree', env=env)
        commit_b = git('commit-tree', arbol_b, '-p', commit_a, '-m', f'Manifiesto fijado a la instantánea publicada {commit_a[:10]}')
    git('update-ref', f'refs/heads/{rama}', commit_b)
    malos = problemas(rama)
    if malos:
        sys.exit('La rama ha quedado con rutas prohibidas (no la empujes):\n  ' + '\n  '.join(malos[:20]))
    print(f'Rama local {rama} = {commit_b[:10]} (instantánea {commit_a[:10]} de {origen} {sha_origen[:10]}; '
          f'{len(fuera)} rutas del examen de España fuera; manifiesto fijado a {commit_a[:10]}).')
    print(f'Falta el push:  git -C {WT} push --force privado {rama}  y  python3 scripts/temario-privado.py')


def comprobar(rama):
    fallos = 0
    for ref in (rama, f'privado/{rama}'):
        if ref.startswith('privado/'):
            try:
                git('fetch', '--quiet', 'privado', f'+refs/heads/{rama}:refs/remotes/privado/{rama}')
            except RuntimeError:
                print(f'--    {ref}: no existe en GitHub')
                continue
        try:
            git('rev-parse', '--verify', '--quiet', ref)
        except RuntimeError:
            print(f'--    {ref}: no existe')
            continue
        malos = problemas(ref)
        padres = git('rev-list', '--count', ref)
        # Commits de su historia que tocan algo prohibido (si la historia viene de la rama de trabajo, los hay).
        historia = git('rev-list', ref, '--', *NUNCA_CARPETAS, ':(glob,icase)**/*examen-espana*', ':(glob,icase)**/*solucion-espana*').splitlines()
        if malos or historia:
            fallos += 1
            print(f'FALLA {ref}: {len(malos)} rutas o ZIP con el examen de España; {len(historia)} commits de su historia lo llevan')
            for x in malos[:10]:
                print('        ', x)
        else:
            print(f'OK    {ref}: sin el examen de España ni su solución ({padres} commits de historia)')
    sys.exit(1 if fallos else 0)


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    p.add_argument('--comprobar', action='store_true', help='solo comprobar la rama local y la de GitHub')
    p.add_argument('--origen', default=ORIGEN, help=f'rama o commit de trabajo (por defecto {ORIGEN})')
    p.add_argument('--rama', default=RAMA, help=f'rama de publicación (por defecto {RAMA})')
    a = p.parse_args()
    if a.comprobar:
        comprobar(a.rama)
    else:
        crear(a.origen, a.rama)


if __name__ == '__main__':
    main()
