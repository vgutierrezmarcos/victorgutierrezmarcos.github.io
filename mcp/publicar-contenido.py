#!/usr/bin/env python3
"""Sube al KV CONTENIDO del Worker los materiales exclusivos de la skill «EconomIA».

Lee la carpeta de construcción de la skill (la genera scripts/skill-opositor.py; --origen para otra):
    ~/.cache/skill-opositor/prepara-oposicion/references/{temas,dictamen,canon}
(la copia desplegada en la web no lleva este material: solo se sirve con sesión)
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
import time
import os
import re
import subprocess
import sys
import tempfile
from datetime import datetime, timezone

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# La carpeta de construcción de scripts/skill-opositor.py (completa). La copia desplegada en la web ya no lleva
# el material exclusivo: solo se sirve con sesión, desde este KV.
SKILL = os.path.join(os.path.expanduser('~'), '.cache', 'skill-opositor', 'prepara-oposicion', 'references')
WORKER = os.path.join(RAIZ, 'mcp', 'worker')
CARPETAS = ('temas', 'dictamen', 'canon')
# KV admite valores de hasta 25 MB; los .md de un tema rondan los 100-300 kB.
MAX_BYTES = 25 * 1024 * 1024
# Nunca se publican (Víctor, 24/11/2026): el examen de ejemplo del dictamen (España) y su solución.
# No se suben aunque estén en la carpeta y, en cada subida, se borran del KV por si quedaron de antes.
NUNCA = ('dictamen/examen-espana.md', 'dictamen/solucion-espana.md')


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
                if clave in NUNCA or 'espana' in nombre and clave.startswith('dictamen/'):
                    print(f'  (fuera: {clave}, no se publica nunca)')
                    continue
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
    version = re.search(r'^version:\s*(\S+)', leer(os.path.join(os.path.dirname(SKILL), 'VERSION.txt')), re.M) if os.path.exists(os.path.join(os.path.dirname(SKILL), 'VERSION.txt')) else None
    indice = {
        'version': version.group(1) if version else None,
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


# ------------------------------------------------------------------ Búsqueda en todo el temario
# Índice invertido para la herramienta buscar_en_temario del conector (Víctor, 25/11/2026): el Worker
# no puede recorrer 90 temas en cada consulta (límite de CPU), así que aquí se parte cada tema en
# pasajes y se apunta, por palabra, en qué pasajes sale. Las claves:
#   busqueda/meta.json          número de pasajes, longitud media y títulos de los temas
#   busqueda/t/<T>.json         pasajes de un tema: [[apartado, texto], …]
#   busqueda/i/<2 letras>.json  {palabra: "T:i:tf:long,…"} (las dos primeras letras de la palabra)
# La normalización (sin tildes, raíz corta) es la misma que la de src/busqueda.ts.
VACIAS_BUSQUEDA = set('los las del una uno unos unas que con por para sus como sobre entre esta este estos estas cada mas más son sin pero sino tras ante bajo desde hasta segun según donde cuando cual cuales quien tema temas apartado tambien también muy hay han ser fue sea'.split())
MAX_PASAJE = 1200


def normalizar_palabra(w):
    import unicodedata
    w = ''.join(c for c in unicodedata.normalize('NFD', w.lower()) if unicodedata.category(c) != 'Mn')
    if w.isdigit() or any(ch.isdigit() for ch in w):
        return w
    if len(w) > 5 and w.endswith('es'):
        w = w[:-2]
    elif len(w) > 4 and w.endswith('s'):
        w = w[:-1]
    return w[:9]


def palabras_busqueda(texto):
    salida = []
    for w in re.findall(r'\d+(?:[.,]\d+)?|[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+', texto):
        if len(w) < 3 and not w.isdigit() and not re.match(r'\d', w):
            continue
        n = normalizar_palabra(w)
        if n and n not in VACIAS_BUSQUEDA:
            salida.append(n)
    return salida


def pasajes_de(md):
    """[(apartado, texto)] partiendo por títulos (##…#####) y en trozos de ~1.200 caracteres."""
    ruta, actual, salida = [], [], []
    def cerrar():
        texto = '\n'.join(actual).strip()
        actual.clear()
        if len(texto) < 40:
            return
        apartado = ' › '.join(x for x in ruta if x)
        trozo = ''
        for parrafo in re.split(r'\n\s*\n', texto):
            if trozo and len(trozo) + len(parrafo) > MAX_PASAJE:
                salida.append((apartado, trozo.strip()))
                trozo = ''
            trozo += parrafo + '\n\n'
        if trozo.strip():
            salida.append((apartado, trozo.strip()))
    for linea in md.split('\n'):
        m = re.match(r'^(#{1,5})\s+(.*)$', linea)
        if m:
            cerrar()
            nivel = len(m.group(1))
            del ruta[nivel - 1:]
            ruta.extend([''] * (nivel - 1 - len(ruta)))
            ruta.append(m.group(2).strip())
        elif not linea.startswith('<!--') and not linea.startswith('*Material exclusivo'):
            actual.append(linea)
    cerrar()
    return salida


def indice_busqueda(pares, indice):
    """Las claves del índice de búsqueda a partir de los .md de los temas y de la guía del dictamen."""
    titulos = {t['codigo']: t.get('titulo', '') for t in indice['temas']}
    textos = {clave.split('/')[1]: texto for clave, texto in pares if re.match(r'^temas/[^/]+/tema\.md$', clave)}
    for clave, texto in pares:
        if clave == 'dictamen/guia-1D01.md':
            textos['1D01'] = texto
            titulos['1D01'] = 'Guía para el dictamen de coyuntura económica'
    postings, claves, total, suma = {}, [], 0, 0
    for codigo, md in sorted(textos.items()):
        pasajes = pasajes_de(md)
        claves.append((f'busqueda/t/{codigo}.json', json.dumps([[a, t] for a, t in pasajes], ensure_ascii=False)))
        for i, (apartado, texto) in enumerate(pasajes):
            ws = palabras_busqueda(apartado + ' ' + apartado + ' ' + texto)  # el apartado cuenta doble
            total += 1
            suma += len(ws)
            cuenta = {}
            for w in ws:
                cuenta[w] = cuenta.get(w, 0) + 1
            for w, tf in cuenta.items():
                postings.setdefault(w, []).append(f'{codigo}:{i}:{tf}:{len(ws)}')
    # Fuera las palabras que salen en más del 25 % de los pasajes: no distinguen nada.
    postings = {w: l for w, l in postings.items() if len(l) <= total * 0.25}
    por_pref = {}
    for w, lista in postings.items():
        por_pref.setdefault(w[:2], {})[w] = ','.join(lista)
    # Los pares de letras muy frecuentes («co», «de»…) se parten por las tres primeras.
    for pref in [p for p, d in por_pref.items() if sum(len(k) + len(v) + 6 for k, v in d.items()) > 200_000]:
        for w, v in por_pref.pop(pref).items():
            por_pref.setdefault(w[:3], {})[w] = v
    # Las dos primeras letras se agrupan en trozos de ~250 KB (menos claves que escribir en el KV y
    # poco que leer por consulta); meta.json dice en qué trozo está cada par de letras.
    trozo_de, trozos, actual, tam, n = {}, [], {}, 0, 0
    for pref in sorted(por_pref):
        d = por_pref[pref]
        t = sum(len(k) + len(v) + 6 for k, v in d.items())
        if actual and tam + t > 250_000:
            trozos.append(actual)
            actual, tam = {}, 0
        actual.update(d)
        tam += t
        trozo_de[pref] = len(trozos)
    if actual:
        trozos.append(actual)
    for i, d in enumerate(trozos):
        claves.append((f'busqueda/i/{i}.json', json.dumps(d, ensure_ascii=False, separators=(',', ':'))))
    meta = {'pasajes': total, 'media': round(suma / max(total, 1), 1), 'titulos': titulos, 'trozos': trozo_de, 'generado': time.strftime('%Y-%m-%d')}
    claves.append(('busqueda/meta.json', json.dumps(meta, ensure_ascii=False)))
    return claves


def main():
    p = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    p.add_argument('--binding', default='CONTENIDO', help='binding del KV en wrangler.toml (por defecto CONTENIDO)')
    p.add_argument('--local', action='store_true', help='subir al KV local de wrangler dev en vez del remoto')
    p.add_argument('--limpiar', action='store_true', help='borrar antes las claves de temas, dictamen y canon')
    p.add_argument('--solo-json', metavar='FICHERO', help='escribir el fichero bulk y no subir nada')
    p.add_argument('--origen', metavar='CARPETA', help='carpeta references/ de la skill completa (por defecto, la de construcción de skill-opositor.py)')
    args = p.parse_args()
    if args.origen:
        global SKILL
        SKILL = os.path.abspath(args.origen)

    pares, indice = recoger()
    busqueda = indice_busqueda(pares, indice)
    print(f'Índice de búsqueda: {len(busqueda)} claves ({sum(1 for c, _ in busqueda if c.startswith("busqueda/t/"))} temas, {sum(1 for c, _ in busqueda if c.startswith("busqueda/i/"))} trozos del índice)')
    pares = pares + busqueda
    print(f'{len(pares) - 1} ficheros ({len(indice["temas"])} temas, {len(indice["dictamen"])} del dictamen, {len(indice["canon"])} del canon) + indice.json')
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

    # Lo que no se publica nunca se borra siempre (si no está, wrangler no se queja).
    with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False, encoding='utf-8') as f:
        json.dump(list(NUNCA), f)
    try:
        wrangler('kv', 'bulk', 'delete', f.name, '--binding', args.binding, '--force', remoto=remoto)
    finally:
        os.unlink(f.name)

    with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False, encoding='utf-8') as f:
        json.dump(bulk, f, ensure_ascii=False)
    try:
        wrangler('kv', 'bulk', 'put', f.name, '--binding', args.binding, remoto=remoto)
    finally:
        os.unlink(f.name)
    print('Hecho. Comprueba con: npx wrangler kv key get indice.json --binding', args.binding, '--remote' if remoto else '')


if __name__ == '__main__':
    main()
