#!/usr/bin/env python3
"""Comprueba que todo está listo para «Lanza todo al público» (solo lectura).

El lanzamiento conjunto (Víctor, 11 y 20/11/2026) publica a la vez: la app
nueva con el conector de EconomIA integrado, todo lo de EconomIA visible, los
temas revisados del 3.er ejercicio con cuenta en la app y, desde el 24/11, también
en la web con sesión (scripts/temas-web-visible.py --mostrar), y el banco de
preguntas. El examen de ejemplo de España del dictamen y su solución no se
publican nunca (scripts/rama-publicada.py crea temario-publicado sin ellos). El orden de los pasos está en LANZAMIENTO.md; este script dice, paso
por paso, qué está listo (OK), qué falta (FALLA) y qué solo se hace ese día (DÍA).

    python3 scripts/lanzamiento.py            # comprobaciones rápidas
    python3 scripts/lanzamiento.py --tests    # además, tests del Worker (npm test y typecheck)

Autor: Víctor Gutiérrez Marcos
"""
import glob
import hashlib
import json
import os
import re
import subprocess
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WT = os.environ.get('TCEE_WORKTREE_REVISION', RAIZ + '-revision-2')
VERSION_LANZAMIENTO = '1.26.0'
RAMA_PUBLICADA = 'temario-publicado'
resultados = []


def paso(nombre, estado, detalle=''):
    resultados.append((nombre, estado, detalle))


def sha(ruta):
    h = hashlib.sha256()
    with open(ruta, 'rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


def salida(cmd, cwd=RAIZ, timeout=600):
    r = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=timeout)
    return r.returncode, (r.stdout + r.stderr).strip()


def temario():
    fuentes = os.path.join(WT, 'oposicion', 'temario', 'fuentes')
    temas = sorted(os.path.basename(d) for d in glob.glob(os.path.join(fuentes, '3[AB][0-9][0-9]')))
    paso('Temario: 90 temas del 3.º en el worktree', 'OK' if len(temas) == 90 else 'FALLA', f'{len(temas)} en {WT}')
    # Páginas (portada a conclusión) ≤ 40, leídas de la portada de cada PDF
    try:
        import fitz
        largos = []
        for t in temas:
            pdf = os.path.join(WT, 'oposicion', 'temario', 'tercer-ejercicio', f'{t}.pdf')
            m = re.search(r'Tema: (\d+) págs', fitz.open(pdf)[0].get_text()) if os.path.exists(pdf) else None
            if m and int(m.group(1)) > 40:
                largos.append(f'{t} ({m.group(1)})')
        paso('Temario: ningún tema pasa de 40 páginas', 'FALLA' if largos else 'OK', ', '.join(largos))
    except ImportError:
        paso('Temario: ningún tema pasa de 40 páginas', 'FALLA', 'falta PyMuPDF (pip install pymupdf)')
    code, out = salida([sys.executable, os.path.join(WT, 'scripts', 'temario', 'fecha-comun.py'), '--comprobar'], cwd=WT)
    fechas = [l.split(':')[0] for l in out.splitlines() if 'ficheros' in l]
    paso('Temario: la misma fecha en temas, fichas, 1D01 y «Cómo cantar»', 'OK' if code == 0 else 'DÍA',
         f'{len(fechas)} fechas distintas; el día: fecha-comun.py DD/MM/AAAA --reconstruir')
    man = os.path.join(WT, 'oposicion', 'temario', 'app', 'revisados.json')
    try:
        m = json.load(open(man, encoding='utf-8'))
        n = len(m.get('temas', []))
        paso('Temario: manifiesto de la app con los 90 temas y 1D01', 'OK' if n >= 91 and m.get('rama') == RAMA_PUBLICADA else 'DÍA',
             f'{n} temas, rama {m.get("rama")}; el día: marcar aprobados y manifiesto-app.py')
    except (OSError, ValueError) as e:
        paso('Temario: manifiesto de la app', 'FALLA', str(e))
    code, out = salida(['git', 'ls-remote', '--heads', 'origin', RAMA_PUBLICADA], cwd=WT, timeout=60)
    paso(f'Temario: rama {RAMA_PUBLICADA} en GitHub', 'OK' if out.strip() else 'DÍA', 'la leen la app y la web')
    code, out = salida(['git', 'status', '--porcelain', '--', 'oposicion', 'scripts', '.claude'], cwd=WT)
    pend = [l for l in out.splitlines() if l and not l.endswith('.xml') and '/word/' not in l and '_rels' not in l
            and 'docProps' not in l and 'customXml' not in l]
    paso('Temario: rama de revisión sin cambios sin confirmar', 'OK' if not pend else 'FALLA', f'{len(pend)} rutas')


def app():
    v = re.search(r'^version:\s*(\S+)', open(os.path.join(RAIZ, 'app', 'pubspec.yaml'), encoding='utf-8').read(), re.M).group(1)
    paso(f'App: versión {VERSION_LANZAMIENTO} en pubspec.yaml', 'OK' if v.startswith(VERSION_LANZAMIENTO) else 'DÍA', v)
    try:
        w = json.load(open(os.path.join(RAIZ, 'app', 'abrir', 'version.json')))
        paso('App: versión web (app/abrir) igual que pubspec', 'OK' if f'{w["version"]}+{w["build_number"]}' == v else 'FALLA',
             f'{w["version"]}+{w["build_number"]}; publicar-app-web.py')
    except (OSError, KeyError, ValueError) as e:
        paso('App: versión web', 'FALLA', str(e))
    rev = open(os.path.join(RAIZ, 'app', 'lib', 'data', 'models', 'revisado.dart'), encoding='utf-8').read()
    paso(f'App: lee el manifiesto de {RAMA_PUBLICADA}', 'OK' if f"_rama = '{RAMA_PUBLICADA}'" in rev else 'FALLA')
    cfg = json.load(open(os.path.join(RAIZ, 'oposicion', 'app-config.json'), encoding='utf-8')).get('app', {})
    paso('App: versionActual de app-config.json', 'OK' if cfg.get('versionActual') == VERSION_LANZAMIENTO else 'DÍA',
         f'{cfg.get("versionActual")} (se cambia cuando Play la apruebe)')


def economia():
    code, out = salida([sys.executable, 'scripts/economia-visible.py'])
    paso('EconomIA: oculta hasta el lanzamiento', 'OK' if 'oculto' in out else 'FALLA', out.splitlines()[-1] if out else '')
    code, out = salida([sys.executable, 'scripts/temas-web-visible.py'])
    listo = os.path.exists(os.path.join(RAIZ, 'oposicion', 'temario', 'tema-revisado.html'))
    paso('Web: temas revisados con sesión, preparados y apagados hasta el día', 'OK' if 'solo en la app' in out and listo else 'FALLA',
         f'{out}; el día: temas-web-visible.py --mostrar' if listo else 'falta oposicion/temario/tema-revisado.html')
    rutas = ['scripts/video-claude/GUION.md', 'scripts/video-claude/preparar.py', 'scripts/video-claude/musica.py',
             'oposicion/economia.html', 'app/index.html']
    malas = [r for r in rutas if os.path.exists(os.path.join(RAIZ, r))
             and 'Prepara con Claude' in open(os.path.join(RAIZ, r), encoding='utf-8').read()]
    paso('EconomIA: sin «Prepara con Claude» en guion, vídeo y páginas', 'FALLA' if malas else 'OK', ', '.join(malas))


def examen_espana():
    """El examen de ejemplo de España del dictamen y su solución no se publican nunca (Víctor, 24/11/2026)."""
    patron = re.compile(r'(examen|solucion)[-_]espana', re.I)
    # El conector: ni en la lista del Worker, ni en la skill construida, ni en el ZIP.
    malos = []
    contenido = open(os.path.join(RAIZ, 'mcp', 'worker', 'src', 'contenido.ts'), encoding='utf-8').read()
    m = re.search(r'documentosDictamen = \[([^\]]*)\]', contenido)
    if not m or patron.search(m.group(1)):
        malos.append('mcp/worker/src/contenido.ts')
    for r in ('scripts/skill-opositor.py', 'mcp/publicar-contenido.py'):
        t = open(os.path.join(RAIZ, r), encoding='utf-8').read()
        if 'DICTAMEN_NUNCA' not in t and 'NUNCA = (' not in t:
            malos.append(r)
    construida = os.path.join(os.path.expanduser('~'), '.cache', 'skill-opositor', 'prepara-oposicion', 'references', 'dictamen')
    if os.path.isdir(construida):
        malos += [f'~/.cache/…/dictamen/{f}' for f in os.listdir(construida) if patron.search(f)]
    paso('Dictamen: el examen de España fuera del conector y de la skill', 'FALLA' if malos else 'OK',
         ', '.join(malos) + ('; reconstruir con skill-opositor.py' if malos else ''))
    # El ZIP de la skill en la rama de revisión (temario-publicado sale de ahí).
    try:
        import io
        import zipfile
        r = subprocess.run(['git', 'show', 'HEAD:oposicion/temario/app/prepara-con-claude.zip'], cwd=WT, capture_output=True)
        dentro = [n for n in zipfile.ZipFile(io.BytesIO(r.stdout)).namelist() if patron.search(n)] if r.returncode == 0 else []
        paso('Dictamen: el ZIP de la skill (rama de revisión) sin el examen de España', 'FALLA' if dentro else 'OK',
             'skill-opositor.py y commit en la rama de revisión' if dentro else '')
    except Exception as e:  # noqa: BLE001
        paso('Dictamen: el ZIP de la skill sin el examen de España', 'FALLA', str(e)[:100])
    # La rama de publicación (si existe): sin el examen ni en su árbol ni en su historia.
    code, out = salida([sys.executable, os.path.join(RAIZ, 'scripts', 'rama-publicada.py'), '--comprobar'], timeout=900)
    if 'FALLA' in out:
        paso(f'Dictamen: {RAMA_PUBLICADA} sin el examen de España', 'FALLA', 'rehacerla con scripts/rama-publicada.py y push --force')
    elif 'OK' in out:
        paso(f'Dictamen: {RAMA_PUBLICADA} sin el examen de España', 'OK', '; '.join(l.split(':')[0].replace('OK', '').strip() for l in out.splitlines() if l.startswith('OK')))
    else:
        paso(f'Dictamen: {RAMA_PUBLICADA} sin el examen de España', 'DÍA', 'el día: scripts/rama-publicada.py y push --force')
    # Las ramas públicas de trabajo que ya lo llevan (decisión de Víctor: ver LANZAMIENTO.md).
    expuestas = []
    for rama in ('revision-temario-2', 'revision-temario'):
        code, out = salida(['git', 'ls-tree', '-r', '--name-only', f'origin/{rama}', '--', 'oposicion/temario/fuentes/1D01/examen-espana'], cwd=WT)
        if code == 0 and out.strip():
            expuestas.append(rama)
    paso('Dictamen: ninguna rama pública de GitHub con el examen de España', 'FALLA' if expuestas else 'OK',
         ('en ' + ', '.join(expuestas) + ': decidir qué hacer (LANZAMIENTO.md, «Examen de España»)') if expuestas else '')


def worker(tests):
    w = os.path.join(RAIZ, 'mcp', 'worker')
    if not tests:
        paso('Worker: tests y typecheck', 'DÍA', 'con --tests (npm test, npm run typecheck)')
        return
    for nombre, cmd in (('npm test', ['npm', 'test', '--silent']), ('typecheck', ['npm', 'run', 'typecheck', '--silent'])):
        code, out = salida(cmd, cwd=w, timeout=900)
        paso(f'Worker: {nombre}', 'OK' if code == 0 else 'FALLA', out.splitlines()[-1][:120] if out else '')


def videos():
    d = json.load(open(os.path.join(RAIZ, 'videos.json'), encoding='utf-8'))['videos']
    renders = sorted(glob.glob(os.path.join(RAIZ, 'scripts', 'video-claude', 'renders', '*.mp4')))
    locales = {'promo-app': os.path.join(RAIZ, 'app', 'promo', 'oposicion-tcee.mp4'),
               'economia': renders[-1] if renders else ''}
    distintos = []
    for clave in ('promo-app', 'economia'):
        f = locales[clave]
        if not f or not os.path.exists(f):
            distintos.append(f'{clave} (sin fichero)')
        elif sha(f) != d.get(clave, {}).get('sha256'):
            distintos.append(clave)
    paso('Vídeos: promo-app y economia subidos son los últimos renders', 'DÍA' if distintos else 'OK',
         ('volver a subir: ' + ', '.join(distintos)) if distintos else '')
    ayuda = [os.path.basename(f) for f in glob.glob(os.path.join(RAIZ, 'app', 'promo', 'ayuda', '*.mp4'))]
    subidos = {v.get('archivo') for k, v in d.items() if k.startswith('ayuda-')}
    sin = sorted(set(ayuda) - subidos)
    paso('Vídeos de ayuda en YouTube', 'OK', f'{len(subidos)} subidos; {len(sin)} solo locales (se ven igual): {", ".join(sin)}')


def banco():
    origen = os.path.join(WT, 'banco-test')
    fs = glob.glob(os.path.join(origen, '*.json'))
    n, borr = 0, 0
    for f in fs:
        try:
            datos = json.load(open(f, encoding='utf-8'))
        except ValueError:
            borr += 1
            continue
        pre = datos.get('preguntas', datos) if isinstance(datos, dict) else datos
        n += len(pre)
        borr += sum(1 for p in pre if isinstance(p, dict) and p.get('estado') == 'borrador')
    paso('Banco de test: preguntas revisadas sin borradores', 'OK' if n >= 1000 and not borr else 'FALLA', f'{n} preguntas, {borr} en borrador')
    paso('Banco de test: publicado en el KV del conector', 'DÍA', 'banco-test.py --publicar')


def main():
    temario()
    app()
    economia()
    examen_espana()
    worker('--tests' in sys.argv)
    videos()
    banco()
    code, out = salida(['git', 'status', '--porcelain'])
    paso('Main: cambios sin confirmar', 'OK' if not out else 'FALLA', f'{len(out.splitlines())} rutas (confirmar antes de lanzar)')
    ancho = max(len(n) for n, _, _ in resultados)
    for n, e, d in resultados:
        print(f'{e:5} {n:{ancho}}  {d}')
    fallos = sum(1 for _, e, _ in resultados if e == 'FALLA')
    print(f'\n{fallos} por arreglar antes del lanzamiento; {sum(1 for _, e, _ in resultados if e == "DÍA")} pasos del mismo día (LANZAMIENTO.md).')
    sys.exit(1 if fallos else 0)


if __name__ == '__main__':
    main()
