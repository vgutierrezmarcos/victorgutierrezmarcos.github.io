#!/usr/bin/env python3
"""Las páginas de los temas revisados en la web y su índice (revisados-web.json).

Víctor (25/11/2026): la URL de siempre de cada tema lleva a la versión revisada. Desde el
26/11/2026 los temas revisados se protegen de verdad: sus PDF, fichas y Word ya no están en
la web (ni en ninguna rama pública); los sirve el conector a quien inicia sesión
(scripts/temario-privado.py los sube a su almacén). En la web queda, por tema:

    oposicion/temario/tercer-ejercicio/3A01.html            su página (pide iniciar sesión y
                                                            ofrece la versión antigua)
    oposicion/temario/tercer-ejercicio/anterior/3A01.pdf    el tema antiguo (si lo había)
    oposicion/temario/primer-ejercicio/esquema_dictamen_economico.html  la guía del dictamen
    oposicion/temario/primer-ejercicio/anterior/esquema_dictamen_economico.pdf la guía antigua

La URL de siempre del PDF (…/3A01.pdf) da 404 y 404.html lleva a la página. Lee el
manifiesto del conector (/temario/manifiesto) y escribe oposicion/temario/revisados-web.json
(página, versión antigua, apartados y conceptos de cada tema; «pdf» y «repaso» son rutas del
almacén privado), llms.txt, llms-full.txt y las páginas. Si quedan PDF revisados en la web,
los quita con git rm.

    python3 scripts/temas-revisados-web.py            # escribe el índice y las páginas
    python3 scripts/temas-revisados-web.py --seco     # solo dice qué haría

Después: python3 scripts/datos-estructurados-temario.py, node generate-sitemap.js,
node build-app-data.js, node build-search-index.js y commit.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import subprocess
import sys
import urllib.error
import urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WT = os.environ.get('TCEE_WORKTREE_REVISION', RAIZ + '-revision-2')
RAMA = 'temario-publicado'
MANIFIESTO = 'oposicion/temario/app/revisados.json'
MANIFIESTO_SERVIDOR = 'https://mcp.victorgutierrezmarcos.es/temario/manifiesto'
INDICE = 'oposicion/temario/revisados-web.json'
TEMA_CSS = 'oposicion/temario/latex/tema.css'
GUIA = 'oposicion/temario/primer-ejercicio/esquema_dictamen_economico.pdf'
GUIA_RESUMEN = 'oposicion/temario/primer-ejercicio/esquema_dictamen_economico-resumen.pdf'
# Apartados del índice que no dicen de qué trata el tema
GENERICOS = re.compile(r'^(introducción|conclusión|conclusiones|idea final|bibliografía|referencias|anexos?\b|'
                       r'esquema|índice|preguntas|resumen|enganche|contextualización)', re.I)
# Rótulos de la estructura a)–e) de los modelos y otros que solos no dicen nada
VACIOS = {'idea', 'la idea', 'modelo', 'extensiones', 'evidencia empírica', 'evidencia', 'valoración', 'aportaciones',
          'supuestos', 'desarrollo', 'implicaciones', 'método', 'soluciones', 'críticas', 'contexto', 'definición',
          'concepto', 'antecedentes', 'origen', 'efectos', 'otros', 'otras', 'situación actual', 'perspectivas',
          'balance', 'medición', 'causas', 'consecuencias', 'tipos', 'clasificación', 'ventajas', 'inconvenientes',
          'limitaciones', 'aplicaciones', 'conclusión', 'resultados', 'propuestas', 'retos', 'características'}


def git_wt(*args, binario=False):
    r = subprocess.run(['git', '-C', WT, *args], capture_output=True)
    if r.returncode:
        sys.exit(f'git {" ".join(args)}: {r.stderr.decode("utf-8", "replace").strip()}')
    return r.stdout if binario else r.stdout.decode('utf-8')


def concepto(texto):
    """«II.2.1. Distinción entre…» → «Distinción entre…»; None si es genérico."""
    t = re.sub(r'^\s*(?:[IVX]+|[A-Z]|\d+)(?:\.\d+)*\.?\s+(?=\S)', '', texto).strip()
    t = re.sub(r'^\d+(?:\.\d+)*\.?\s+', '', t).strip()
    t = re.sub(r'^(?:[a-z]|[ivx]+)\)\s+', '', t).strip()          # «a) », «iv) »
    t = re.sub(r'^La idea:\s*', '', t, flags=re.I).strip().rstrip('.:')
    if t:
        t = t[0].upper() + t[1:]
    if len(t) < 3 or GENERICOS.match(t) or t.lower() in VACIOS:
        return None
    return t


def conceptos(esquema):
    vistos, lista = set(), []
    for nivel, texto, *_ in esquema or []:
        c = concepto(texto)
        if c and c.lower() not in vistos:
            vistos.add(c.lower())
            lista.append(c)
    return lista


def apartados(esquema):
    """Los apartados de primer nivel del cuerpo (sin anexos ni introducción)."""
    salida = []
    for nivel, texto, *_ in esquema or []:
        if nivel == 0 and re.match(r'^[IVX]+\.\s', texto):
            c = concepto(texto)
            if c:
                salida.append(c)
    return salida


WEB = 'https://www.victorgutierrezmarcos.es/'
LLMS_INICIO = '<!-- conceptos: lo genera scripts/temas-revisados-web.py -->'
LLMS_FIN = '<!-- /conceptos -->'


def llms(temas):
    """Para los buscadores con IA (sin cambiar nada visible de la web):
    - en llms.txt, una sección «Conceptos de economía» con el tema que explica cada grupo de conceptos;
    - llms-full.txt (sin enlazar), con título, apartados y conceptos de cada tema revisado."""
    lineas, completo = [], ['# Temario revisado de la oposición TCEE: qué explica cada tema', '',
                            '> Índice de los temas revisados (noviembre de 2026) del tercer ejercicio de la oposición a Técnico '
                            'Comercial y Economista del Estado (TCEE) y de la guía del dictamen de coyuntura, de Víctor Gutiérrez Marcos. '
                            'Sirven también como apuntes de economía de nivel universitario. Son materiales exclusivos de uso personal: '
                            'se pueden leer y citar con enlace, pero no incorporar a otras plataformas ni usar para entrenar sistemas de IA '
                            f'({WEB}condiciones-materiales.html).', '']
    for t in temas:
        nombre = 'Guía del dictamen de coyuntura económica' if t['archivo'] == '1D01' else f'Tema {t["codigo"]}: {t["titulo"]}'
        breves = [c for c in t['conceptos'] if len(c) <= 70][:8]
        lineas.append(f'- [{", ".join(breves) or nombre}]({WEB}{t["pagina"]}): {nombre}')
        completo += [f'## {nombre}', '', f'- Página: {WEB}{t["pagina"]} (se lee con cuenta de Google)'] \
            + ([f'- Revisado: {t["aprobado"]}'] if t.get('aprobado') else []) \
            + ([f'- Apartados: {"; ".join(t["apartados"])}'] if t.get('apartados') else []) \
            + [f'- Conceptos: {"; ".join(t["conceptos"])}', '']
    open('llms-full.txt', 'w', encoding='utf-8').write('\n'.join(completo).rstrip() + '\n')
    bloque = (f'{LLMS_INICIO}\n## Conceptos de economía, tema a tema\n\nQué tema del temario revisado explica cada concepto '
              f'(índice completo en {WEB}llms-full.txt):\n\n' + '\n'.join(lineas) + f'\n{LLMS_FIN}')
    s = open('llms.txt', encoding='utf-8').read()
    if LLMS_INICIO in s:
        s = re.sub(re.escape(LLMS_INICIO) + r'.*?' + re.escape(LLMS_FIN), lambda _: bloque, s, flags=re.S)
    else:
        s = s.replace('\n## Otros\n', f'\n{bloque}\n\n## Otros\n', 1)
    open('llms.txt', 'w', encoding='utf-8').write(s)


PLANTILLA = 'oposicion/temario/tema-revisado.html'


def pagina_tema(t, web_pdf):
    """La página HTML de un tema revisado al lado de su PDF (…/3A14.html): la misma que
    tema-revisado.html (el tema en la web, con sesión, con su barra de PDF, Word y ficha, y la
    burbuja de EconomIA), con su título y su código; la rellena exclusivos.js."""
    carpeta, nombre = os.path.split(web_pdf)
    ruta = f'{carpeta}/{os.path.splitext(nombre)[0]}.html'
    guia = t['archivo'] == '1D01'
    titulo = 'Guía para el dictamen de coyuntura económica' if guia else f'Tema {t["codigo"]}: {t["titulo"].rstrip(".")}'
    ejercicio = 'Primer ejercicio' if guia else 'Tercer ejercicio'
    pag_ejercicio = 'primer-ejercicio.html' if guia else 'tercer-ejercicio.html'
    h = open(PLANTILLA, encoding='utf-8').read()
    # Una carpeta más abajo que la plantilla.
    h = re.sub(r'(href|src)="\.\./', r'\1="../../', h)
    esc = lambda x: x.replace('&', '&amp;').replace('<', '&lt;').replace('"', '&quot;')
    h = re.sub(r'<title>.*?</title>', f'<title>{esc(titulo)} | Víctor Gutiérrez Marcos</title>', h, count=1, flags=re.S)
    h = re.sub(r'<meta property="og:title" content="[^"]*">', f'<meta property="og:title" content="{esc(titulo)}">', h, count=1)
    h = re.sub(r'<meta name="description" content="[^"]*">', f'<meta name="description" content="{esc(titulo)}. Material exclusivo de la oposición TCEE para tu estudio personal, con tu cuenta de Google.">', h, count=1)
    h = re.sub(r'<link rel="canonical" href="[^"]*">', f'<link rel="canonical" href="{WEB}{ruta}">', h, count=1)
    # Indexable: es la que recibe la URL de siempre del PDF (404.html) y lo que Google puede ver del tema.
    h = h.replace('<meta name="robots" content="noindex, nofollow">', '<meta name="robots" content="index, follow">')
    h = h.replace('<div class="content-container" id="tema-revisado">', f'<div class="content-container" id="tema-revisado" data-tema="{t["archivo"]}">')
    h = re.sub(r'<nav class="breadcrumb">.*?</nav>', f'<nav class="breadcrumb"><a href="../../temario.html">Temario</a><span>›</span><a href="../{pag_ejercicio}">{ejercicio}</a><span>›</span>{"Guía del dictamen" if guia else "Tema " + t["codigo"]}</nav>', h, count=1, flags=re.S)
    h = re.sub(r'(<h1 class="tema-revisado-titulo" id="tema-revisado-titulo">).*?(</h1>)', lambda m: m.group(1) + esc(titulo) + m.group(2), h, count=1, flags=re.S)
    h = h.replace('<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="Tema revisado" hidden>', f'<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="{esc(titulo)}" hidden>')
    h = re.sub(r'<!-- Tema revisado \(exclusivo.*?-->', f'<!-- {esc(titulo)}: página generada por scripts/temas-revisados-web.py a partir de {PLANTILLA}; la rellena exclusivos.js. -->', h, count=1, flags=re.S)
    return ruta, h


def manifiesto():
    """El índice de los temas revisados (sin contenido), del conector; si no responde, de la rama."""
    try:
        with urllib.request.urlopen(urllib.request.Request(MANIFIESTO_SERVIDOR, headers={'User-Agent': 'temas-revisados-web'}), timeout=60) as r:
            return json.loads(r.read())
    except (urllib.error.URLError, TimeoutError, ValueError) as e:
        print(f'El conector no da el manifiesto ({e}); se lee de la rama {RAMA}.')
        return json.loads(git_wt('show', f'{RAMA}:{MANIFIESTO}'))


def main():
    seco = '--seco' in sys.argv
    os.chdir(RAIZ)
    m = manifiesto()
    entradas = list(m.get('temas', [])) + ([m['dictamen']] if m.get('dictamen') else [])
    salida, borrados = [], 0
    for t in entradas:
        guia = t['archivo'] == '1D01'
        web_pdf = GUIA if guia else t['pdf']['ruta']
        carpeta, nombre = os.path.split(web_pdf)
        anterior = f'{carpeta}/anterior/{nombre}'
        # Los PDF revisados ya no se publican en la web (26/11/2026): si quedan en la URL de siempre, fuera.
        for viejo in (web_pdf, GUIA_RESUMEN if guia else (t.get('repaso') or {}).get('ruta')):
            if viejo and os.path.exists(viejo):
                print(f'git rm {viejo}')
                borrados += 1
                if not seco:
                    subprocess.run(['git', 'rm', '-q', viejo], check=True)
        salida.append({
            'pagina': os.path.splitext(web_pdf)[0] + '.html',
            'archivo': t['archivo'], 'codigo': t['codigo'], 'titulo': t.get('titulo', ''),
            'aprobado': t.get('aprobado') or t.get('fecha'),
            # Rutas en el almacén privado del conector (no en la web)
            'pdf': t['pdf']['ruta'], 'repaso': (t.get('repaso') or {}).get('ruta'),
            'anterior': anterior if os.path.exists(anterior) else None,
            'apartados': apartados(t.get('esquema')),
            'conceptos': conceptos(t.get('esquema')),
        })
    indice = {'descripcion': 'Temas revisados: su página en la web («pagina»), la versión antigua si la había («anterior») y '
                             'sus apartados y conceptos. «pdf» y «repaso» son rutas del almacén privado del conector, no de la '
                             'web. Lo genera scripts/temas-revisados-web.py desde el manifiesto: no editar a mano.',
              'temas': salida}
    if not seco:
        with open(INDICE, 'w', encoding='utf-8') as f:
            json.dump(indice, f, ensure_ascii=False, indent=1)
            f.write('\n')
        llms(salida)
        for t in entradas:
            web_pdf = GUIA if t['archivo'] == '1D01' else t['pdf']['ruta']
            ruta, h = pagina_tema(t, web_pdf)
            if not os.path.exists(ruta) or open(ruta, encoding='utf-8').read() != h:
                open(ruta, 'w', encoding='utf-8').write(h)
        print(f'{len(entradas)} páginas HTML de tema')
    print(f'{len(salida)} temas: {borrados} PDF revisados quitados de la web' + (' (en seco)' if seco else ''))


if __name__ == '__main__':
    main()
