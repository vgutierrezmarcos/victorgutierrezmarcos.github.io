#!/usr/bin/env python3
"""Sube al KV CONTENIDO del Worker los materiales exclusivos de la skill «EconomIA».

Lee la carpeta desplegada de la skill (la genera scripts/skill-opositor.py):
    oposicion/temario/app/skill/prepara-oposicion/references/{temas,dictamen,canon}
y la sube con `wrangler kv bulk put` con las mismas rutas relativas como claves
(temas/3A08/tema.md, temas/3A08/ficha.md, temas/3A08/guion-cante.md,
dictamen/guia-1D01.md, canon/notacion.md…) más un indice.json con lo que hay, que es
lo que devuelve la herramienta listar_temas_revisados.

Uso, desde la raíz del repositorio, después de `python3 scripts/skill-opositor.py`:
    python3 mcp/publicar-contenido.py            # sube todo (hace falta wrangler con sesión)
    python3 mcp/publicar-contenido.py --solo-json salida.json   # solo escribe el fichero bulk, sin subir
    python3 mcp/publicar-contenido.py --binding CONTENIDO --remoto  # por defecto

Cada ejecución sustituye las claves que existen y deja las demás: para retirar un tema
hay que borrarlo a mano (`npx wrangler kv key delete --binding CONTENIDO temas/3A08/tema.md`)
o pasar --limpiar, que primero borra las claves de temas, dictamen y canon (no las textos/… de extraer-textos.py).
"""
import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from datetime import datetime, timezone

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SKILL = os.path.join(RAIZ, 'oposicion', 'temario', 'app', 'skill', 'prepara-oposicion', 'references')
WORKER = os.path.join(RAIZ, 'mcp', 'worker')
CARPETAS = ('temas', 'dictamen', 'canon')
# KV admite valores de hasta 25 MB; los .md de un tema rondan los 100-300 kB.
MAX_BYTES = 25 * 1024 * 1024


def leer(ruta):
    with open(ruta, encoding='utf-8') as f:
        return f.read()


def filas_indice(md):
    """Las filas de la tabla de temas/INDICE.md, leídas por el nombre de sus columnas (no por su posición:
    la tabla ha ido ganando columnas, como «Pizarra», y leerla por posición estropeó el índice)."""
    cabecera, temas = None, []
    for linea in md.splitlines():
        if not linea.startswith('|'):
            continue
        celdas = [c.strip() for c in linea.strip().strip('|').split('|')]
        if cabecera is None:
            if 'Título' in celdas and 'Aprobado' in celdas:
                cabecera = celdas
            continue
        if not ''.join(celdas).strip('-: '):
            continue
        m = re.match(r'(\d\.[A-Z]\.\d{1,2})\s*\((\w+)\)$', celdas[0])
        if not m:
            continue  # filas que no son temas (la del dictamen): el cuadre con las carpetas detecta lo que falte
        if len(celdas) != len(cabecera):
            sys.exit(f'Fila de INDICE.md que no se entiende (¿ha cambiado la tabla?): {linea[:120]}')
        col = lambda nombre: celdas[cabecera.index(nombre)]
        temas.append({
            'codigo': m.group(2), 'tema': m.group(1), 'titulo': col('Título'),
            # ficha, guion y texto los fija recoger() con lo que hay de verdad en la carpeta
            'ficha': False, 'guion': False, 'texto': False,
            'aprobado': col('Aprobado'), 'version': col('Versión'),
        })
    return temas


def recoger():
    """Pares (clave, texto) de todo lo que hay en la skill, y el índice."""
    if not os.path.isdir(SKILL):
        sys.exit(f'No existe {SKILL}: genera la skill primero (python3 scripts/skill-opositor.py).')
    pares = []
    for carpeta in CARPETAS:
        base = os.path.join(SKILL, carpeta)
        if not os.path.isdir(base):
            print(f'  (no hay carpeta {carpeta})')
            continue
        for raiz, _, ficheros in os.walk(base):
            for nombre in sorted(ficheros):
                if not nombre.endswith('.md'):
                    continue
                ruta = os.path.join(raiz, nombre)
                clave = os.path.relpath(ruta, SKILL).replace(os.sep, '/')
                texto = leer(ruta)
                if len(texto.encode('utf-8')) > MAX_BYTES:
                    sys.exit(f'{clave} supera los 25 MB de KV')
                pares.append((clave, texto))
    indice_md = os.path.join(SKILL, 'temas', 'INDICE.md')
    temas = filas_indice(leer(indice_md)) if os.path.exists(indice_md) else []
    presentes = {clave for clave, _ in pares}
    for t in temas:
        # Lo que hay de verdad en la carpeta manda sobre lo que dice la tabla.
        t['texto'] = f"temas/{t['codigo']}/tema.md" in presentes
        t['ficha'] = f"temas/{t['codigo']}/ficha.md" in presentes
        t['guion'] = f"temas/{t['codigo']}/guion-cante.md" in presentes
    # El índice tiene que cuadrar con las carpetas: un tema sin fila (o una fila sin tema) es un índice roto.
    carpetas = {c.split('/')[1] for c in presentes if c.startswith('temas/') and c.endswith('/tema.md')}
    enIndice = {t['codigo'] for t in temas}
    if carpetas != enIndice or not temas:
        sys.exit(f'INDICE.md no cuadra con las carpetas de temas: sin fila {sorted(carpetas - enIndice)}, sin carpeta {sorted(enIndice - carpetas)}')
    commit = re.search(r'commit ([0-9a-f]{7,})', leer(indice_md)) if os.path.exists(indice_md) else None
    indice = {
        'generado': datetime.now(timezone.utc).isoformat(timespec='seconds'),
        'commit': commit.group(1) if commit else None,
        'temas': temas,
        'dictamen': sorted(c[len('dictamen/'):-3] for c in presentes if c.startswith('dictamen/')),
        'canon': sorted(c[len('canon/'):-3] for c in presentes if c.startswith('canon/')),
    }
    pares.append(('indice.json', json.dumps(indice, ensure_ascii=False, indent=1)))
    return pares, indice


def entorno():
    """El entorno de wrangler con el token de la API (`wrangler login` no sirve desde WSL)."""
    token = os.environ.get('CLOUDFLARE_API_TOKEN')
    ruta = os.path.expanduser('~/.config/oposicion-red/cloudflare.token')
    if not token and os.path.exists(ruta):
        token = open(ruta).read().strip()
    return {**os.environ, **({'CLOUDFLARE_API_TOKEN': token} if token else {})}


def wrangler(*args, remoto=True):
    orden = ['npx', 'wrangler', *args]
    if remoto:
        orden.append('--remote')
    print('  $', ' '.join(orden))
    subprocess.run(orden, cwd=WORKER, check=True, env=entorno())


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    p.add_argument('--binding', default='CONTENIDO', help='binding del KV en wrangler.toml (por defecto CONTENIDO)')
    p.add_argument('--local', action='store_true', help='subir al KV local de wrangler dev en vez del remoto')
    p.add_argument('--limpiar', action='store_true', help='borrar antes las claves de temas, dictamen y canon')
    p.add_argument('--solo-json', metavar='FICHERO', help='escribir el fichero bulk y no subir nada')
    args = p.parse_args()

    pares, indice = recoger()
    print(f'{len(pares) - 1} ficheros .md ({len(indice["temas"])} temas, {len(indice["dictamen"])} del dictamen, {len(indice["canon"])} del canon) + indice.json')
    bulk = [{'key': clave, 'value': texto} for clave, texto in pares]

    if args.solo_json:
        with open(args.solo_json, 'w', encoding='utf-8') as f:
            json.dump(bulk, f, ensure_ascii=False)
        print(f'Escrito {args.solo_json} (no se ha subido nada)')
        return

    remoto = not args.local
    if args.limpiar:
        salida = subprocess.run(['npx', 'wrangler', 'kv', 'key', 'list', '--binding', args.binding] + (['--remote'] if remoto else []),
                                cwd=WORKER, check=True, capture_output=True, text=True, env=entorno()).stdout
        # Solo lo que sube este script: las claves textos/… son de extraer-textos.py.
        claves = [k['name'] for k in json.loads(salida or '[]') if k['name'] == 'indice.json' or k['name'].split('/')[0] in CARPETAS]
        if claves:
            with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False, encoding='utf-8') as f:
                json.dump(claves, f)
            wrangler('kv', 'bulk', 'delete', f.name, '--binding', args.binding, '--force', remoto=remoto)
            os.unlink(f.name)
        print(f'  borradas {len(claves)} claves')

    with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False, encoding='utf-8') as f:
        json.dump(bulk, f, ensure_ascii=False)
    try:
        wrangler('kv', 'bulk', 'put', f.name, '--binding', args.binding, remoto=remoto)
    finally:
        os.unlink(f.name)
    print('Hecho. Comprueba con: npx wrangler kv key get indice.json --binding', args.binding, '--remote' if remoto else '')


if __name__ == '__main__':
    main()
