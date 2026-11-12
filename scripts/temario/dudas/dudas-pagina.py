#!/usr/bin/env python3
"""Página común de dudas de la revisión del temario (Víctor, 9 y 12/11/2026).

Todas las dudas para Víctor, las haya dejado cualquier sesión de cualquiera de
las dos cuentas de Claude, acaban en una sola página HTML que él contesta
cuando puede (botones «De acuerdo» / «Cambiar», nota y «Exportar respuestas»,
que copia un texto para pegarlo en la conversación).

Lee la sección «Dudas abiertas» del revision.md de cada tema revisado y aún sin
aprobar (estado.json → aprobado.tema), en todos los worktrees de la revisión
(…-revision, …-revision-2…; de cada tema, el revision.md más reciente), más
las dudas generales de canon/dudas-generales.md (misma sección). Las dudas
nuevas (no vistas en la última ejecución con --marcar-vistas) salen marcadas.

    python3 scripts/temario/dudas/dudas-pagina.py               # rehace la página
    python3 scripts/temario/dudas/dudas-pagina.py --marcar-vistas  # y da por vistas las de hoy
    python3 scripts/temario/dudas/dudas-pagina.py --salida otra/ruta.html

Por defecto la página va a C:\\Users\\vgutierrez\\Downloads\\dudas-temario.html
(fuera de git: no se publica). Las respuestas se guardan en el navegador
(localStorage «dudas-temario», por id de duda), así que no se pierden al
rehacerla.
"""
import argparse
import datetime
import glob
import html
import json
import os
import re

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.normpath(os.path.join(AQUI, '..', '..', '..'))
SALIDA = '/mnt/c/Users/vgutierrez/Downloads/dudas-temario.html'
VISTAS = os.path.expanduser('~/.local/share/oposicion-web/dudas/vistas.json')
# Temas revisados desde la cuenta personal (para el filtro «Cuenta»)
PERSONAL = {'3B02', '3B03', '3B04', '3B05', '3B06', '3B07', '3B08', '3B09', '3B10', '3B13', '3B23', '3B25'}
PROP = (r'[Dd]ecide Víctor|[Pp]ara Víctor|[Qq]ueda como propuesta|[Cc]onviene que Víctor|sin cambiar aún|'
        r'por decidir|pendiente de decisión|que Víctor decida|¿De acuerdo\?|'
        r'Víctor (?:debe|tiene que|puede) (?:decidir|confirmar|mirar|comprobar)|a confirmar|[Pp]reguntar a Víctor')


def inline(t):
    t = html.escape(t, quote=False)
    t = re.sub(r'`([^`]+)`', r'<code>\1</code>', t)
    t = re.sub(r'\*\*(.+?)\*\*', r'<strong>\1</strong>', t)
    t = re.sub(r'(?<![\w*])\*(?!\s)(.+?)(?<!\s)\*(?![\w*])', r'<em>\1</em>', t)
    t = re.sub(r'\\vertema\{([^}]*)\}', r'[ver tema \1]', t)
    return t.replace('~', ' ').replace('\\%', '%').replace('$', '')


def revisiones():
    """{tema: (ruta de revision.md, worktree)} con el más reciente de cada tema."""
    padre = os.path.dirname(RAIZ)
    base = os.path.basename(RAIZ).split('-revision')[0]
    elegidos = {}
    for wt in sorted(glob.glob(os.path.join(padre, base + '-revision*'))):
        for f in glob.glob(os.path.join(wt, 'oposicion', 'temario', 'fuentes', '*', 'revision.md')):
            t = os.path.basename(os.path.dirname(f))
            if not re.fullmatch(r'\d[A-Z]\d\d', t):
                continue
            if t not in elegidos or os.path.getmtime(f) > os.path.getmtime(elegidos[t][0]):
                elegidos[t] = (f, wt)
    return elegidos


def aprobado(ruta_rev):
    try:
        e = json.load(open(os.path.join(os.path.dirname(ruta_rev), 'estado.json'), encoding='utf-8'))
        return bool((e.get('aprobado') or {}).get('tema'))
    except (OSError, ValueError):
        return False


def dudas_de(md, T):
    m = re.search(r'^##+ [^\n]*[Dd]udas abiertas[^\n]*\n(.*?)(?=^## (?![^\n]*[Dd]udas)|\Z)', md, re.S | re.M)
    body = m.group(1) if m else ''
    blocks, hdr, intro = [], None, []
    for line in body.split('\n'):
        s = line.rstrip()
        if not s.strip():
            continue
        if s.startswith('|'):
            cells = [c.strip() for c in s.strip('|').split('|')]
            if all(re.match(r'^:?-+:?$', c) for c in cells if c):
                continue
            if hdr is None:
                hdr = cells
                continue
            parts = []
            for h, c in zip(hdr, cells):
                if c and c != '—':
                    parts.append(f'**{h}:** {c}' if parts else c)
            blocks.append(['item', ' · '.join(parts)])
            continue
        hdr = None
        mm = re.match(r'^\s{0,3}(?:[-*]|\d+[.)])\s+(.*)', s)
        if mm:
            blocks.append(['item', mm.group(1)])
            continue
        if s.startswith('#'):
            blocks.append(['h', s.lstrip('# ')])
            continue
        if re.match(r'^\*\*[^*]+\*\*:?\s*$', s.strip()) or re.match(r'^\*\*[^*]+:\*\*\s*$', s.strip()):
            blocks.append(['h', s.strip().strip('*').rstrip(':')])
            continue
        if blocks and blocks[-1][0] == 'item':
            blocks[-1][1] += ' ' + s.strip()
            continue
        intro.append(s.strip())
    ds, n = [], 0
    for k, txt in blocks:
        if k == 'h':
            ds.append({'h': inline(txt)})
            continue
        n += 1
        mid = re.match(r'\W*([A-Z]\d{2}-\d+[a-z]?|[A-Z]{1,3}\d{2}-\d+)', txt)
        did = mid.group(1) if mid else f'{T[1:]}-n{n:02d}'
        if re.search(r'[Rr]esuelta por Víctor|[Rr]esueltas? por (?:los )?comentarios de Víctor|[Rr]espuesta de Víctor', txt):
            estado = 'resuelta'
        elif re.search(PROP, txt):
            estado = 'propuesta'
        else:
            estado = 'aplicada'
        ds.append({'id': f'{T}:{did}:{n}', 'html': inline(txt), 'estado': estado})
    return ds, inline(' '.join(intro))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--salida', default=SALIDA)
    ap.add_argument('--marcar-vistas', action='store_true', help='dar por vistas las dudas de ahora')
    args = ap.parse_args()
    titulos = json.load(open(os.path.join(AQUI, 'titulos.json'), encoding='utf-8'))
    try:
        vistas = set(json.load(open(VISTAS, encoding='utf-8')))
    except (OSError, ValueError):
        vistas = None   # primera vez: ninguna sale como nueva
    temas = []
    general = os.path.join(RAIZ, 'oposicion', 'temario', 'canon', 'dudas-generales.md')
    if os.path.exists(general):
        ds, intro = dudas_de(open(general, encoding='utf-8').read(), 'GEN')
        if any('id' in d for d in ds):
            temas.append({'T': 'GEN', 'cod': 'General', 'titulo': 'Criterios, web y dudas comunes a varios temas',
                          'cuenta': 'trabajo', 'intro': intro, 'dudas': ds})
    for T, (ruta, wt) in sorted(revisiones().items()):
        if aprobado(ruta):
            continue
        ds, intro = dudas_de(open(ruta, encoding='utf-8').read(), T)
        if not any('id' in d for d in ds):
            continue
        cod = f'{T[0]}.{T[1]}.{int(T[2:])}' if T[0] != '1' else 'Guía del dictamen'
        cuenta = 'personal' if T in PERSONAL or wt.endswith('-revision-2') else 'trabajo'
        temas.append({'T': T, 'cod': cod, 'titulo': titulos.get(cod, 'Dictamen de coyuntura' if T == '1D01' else ''),
                      'cuenta': cuenta, 'intro': intro, 'dudas': ds})
    ids = [d['id'] for t in temas for d in t['dudas'] if 'id' in d]
    for t in temas:
        for d in t['dudas']:
            if 'id' in d:
                d['nueva'] = vistas is not None and d['id'] not in vistas and d['estado'] != 'resuelta'
    plantilla = open(os.path.join(AQUI, 'plantilla.html'), encoding='utf-8').read()
    fecha = datetime.datetime.now().strftime('%d/%m/%Y %H:%M')
    pagina = plantilla.replace('__DATOS__', json.dumps(temas, ensure_ascii=False)).replace('__FECHA__', fecha)
    os.makedirs(os.path.dirname(os.path.abspath(args.salida)), exist_ok=True)
    with open(args.salida, 'w', encoding='utf-8') as f:
        f.write(pagina)
    if vistas is None or args.marcar_vistas:
        os.makedirs(os.path.dirname(VISTAS), exist_ok=True)
        json.dump(sorted(set(ids) | (vistas or set())), open(VISTAS, 'w', encoding='utf-8'))
    nuevas = sum(1 for t in temas for d in t['dudas'] if d.get('nueva'))
    prop = sum(1 for t in temas for d in t['dudas'] if d.get('estado') == 'propuesta')
    print(f'{args.salida}: {len(temas)} temas, {len(ids)} dudas ({prop} piden decisión, {nuevas} nuevas)')


if __name__ == '__main__':
    main()
