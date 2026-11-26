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
from html import escape

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import esquemas_publicos  # noqa: E402

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
HUECO_ESQUEMA = '<!-- esquema público: lo escribe scripts/temas-revisados-web.py en cada página de tema -->'
HUECO_DATOS = '<!-- datos estructurados del tema -->'
CONCEPTOS_WIKI = 'oposicion/temario/conceptos-wikipedia.json'
TEMARIO = 'oposicion/temario/temario.json'


def _leer_json(ruta):
    try:
        return json.load(open(ruta, encoding='utf-8'))
    except (OSError, ValueError):
        return {}


def contexto_esquemas(salida):
    """Lo que necesita el esquema de cada página: conceptos con su Wikipedia, títulos y
    direcciones de todos los temas (para los relacionados) y la versión antigua."""
    titulos = {}
    for e in _leer_json(TEMARIO).get('ejercicios', []):
        for p in e.get('partes', []):
            for t in p.get('temas', []):
                titulos[t['codigo']] = (t.get('titulo', ''), t.get('url') if t.get('disponible') else None, e.get('urlPagina'))
    return {'conceptos': _leer_json(CONCEPTOS_WIKI).get('temas', {}), 'titulos': titulos,
            'revisados': {t['codigo']: t for t in salida}, 'anterior': {t['archivo']: t.get('anterior') for t in salida}}


def _lista(apartados, desde=0):
    """La lista anidada de apartados (los niveles pueden saltar: sección → párrafo)."""
    html, i = [], desde
    nivel = apartados[desde]['nivel'] if desde < len(apartados) else 0
    html.append('<ol class="tema-esquema-lista">' if nivel == 0 else '<ol>')
    while i < len(apartados) and apartados[i]['nivel'] >= nivel:
        a = apartados[i]
        if a['nivel'] > nivel:              # un hijo sin padre directo (salto de nivel)
            sub, i = _lista(apartados, i)
            html.append(f'<li class="tema-esquema-salto">{sub}</li>')
            continue
        fila = '<span class="tema-esquema-apartado">' + (f'<span class="numero">{a["numero"]}.</span> ' if a['numero'] else '') \
            + escape(a['titulo'], quote=False) + '</span>'
        if a['minutos']:
            fila += f' <span class="tema-esquema-minutos" title="Minutos para cantarlo">{escape(a["minutos"], quote=False)}</span>'
        if a['autores']:
            fila += ' <span class="tema-esquema-autores">' + ' · '.join(escape(x, quote=False) for x in a['autores']) + '</span>'
        i += 1
        if i < len(apartados) and apartados[i]['nivel'] > nivel:
            sub, i = _lista(apartados, i)
            fila += sub
        html.append(f'<li>{fila}</li>')
    html.append('</ol>')
    return ''.join(html), i


def esquema_html(t, ctx):
    """El esquema público de la página (desplegable; exclusivos.js lo ofrece a quien no inicia
    sesión y lo esconde a quien la inicia). Devuelve (html, datos para el JSON-LD)."""
    e = esquemas_publicos.esquema(t['archivo'])
    if not e or not e['apartados']:
        return '', {}
    guia = t['archivo'] == '1D01'
    de = 'de la guía' if guia else 'del tema'
    total = f' ({e["minutos_total"]} en total)' if e['minutos_total'] else ''
    partes = ['<details class="tema-esquema" id="tema-esquema">',
              f'<summary><h2 class="tema-esquema-titulo">Esquema {de}</h2>'
              f'<span class="tema-esquema-subtitulo">Apartados, autores{" y minutos para cantarlo" if e["minutos_total"] else ""}</span></summary>',
              '<div class="tema-esquema-cuerpo">',
              f'<p class="tema-esquema-aviso">El esquema {de} revisado: todos sus apartados, con los autores que se citan en cada uno'
              + (f' y los minutos para cantar cada bloque{total}' if e['minutos_total'] else '') + '. '
              + ('La guía completa' if guia else 'El tema completo') + ', con su desarrollo, sus gráficos y su '
              + ('resumen' if guia else 'ficha') + ' de repaso, se lee con tu cuenta de Google.</p>']
    if e['refran']:
        partes.append(f'<p class="tema-esquema-refran"><span class="tema-esquema-etiqueta">Para empezar</span> «{escape(e["refran"], quote=False)}»</p>')
    partes.append(_lista(e['apartados'])[0])
    if e['anexos']:
        partes.append('<h3>Anexos</h3><ul class="tema-esquema-anexos">')
        for x in e['anexos']:
            tit = x['titulo'][:1].upper() + x['titulo'][1:]
            partes.append(f'<li><span class="tema-esquema-apartado">{escape(tit, quote=False)}</span>'
                          + (': ' + '; '.join(escape(p, quote=False) for p in x['partes']) if x['partes'] else '') + '</li>')
        partes.append('</ul>')
    conceptos = [c for c in ctx['conceptos'].get(t['archivo'], []) if c.get('wikipedia')]
    if conceptos:
        partes.append('<h3>Conceptos</h3><p class="tema-esquema-conceptos">' + ' · '.join(
            f'<a href="{escape(c["wikipedia"])}" target="_blank" rel="noopener">{escape(c.get("titulo") or c["nombre"], quote=False)}</a>'
            for c in conceptos) + '</p>')
    relacionados = []
    for cod in e['relacionados'][:12]:
        titulo, url, pag = ctx['titulos'].get(cod, ('', None, None))
        rev = ctx['revisados'].get(cod)
        destino = f'{WEB}{rev["pagina"]}' if rev else (url or pag)
        if not titulo or not destino:
            continue
        relacionados.append(f'<li><a href="{escape(destino)}">{cod}</a>: {escape(titulo.rstrip("."), quote=False)}</li>')
    if relacionados:
        partes.append('<h3>Temas relacionados</h3><ul class="tema-esquema-relacionados">' + ''.join(relacionados) + '</ul>')
    anterior = ctx['anterior'].get(t['archivo'])
    if anterior:
        partes.append(f'<p class="tema-esquema-anterior">La versión anterior {de} (licencia CC BY-NC-ND) sigue en abierto: '
                      f'<a href="anterior/{os.path.basename(anterior)}">{"guía" if guia else "tema"} anterior en PDF</a>.</p>')
    partes.append('<p class="tema-esquema-entrar" hidden><button type="button" class="boton">Iniciar sesión para leer '
                  + ('la guía completa' if guia else 'el tema completo') + '</button></p>')
    partes.append('</div></details>')
    mins = e['minutos_total']
    duracion = None
    if mins:
        m = re.match(r"(\d+)'(?:(\d+)\")?", mins)
        duracion = f'PT{m.group(1)}M' + (f'{int(m.group(2))}S' if m.group(2) else '') if m else None
    autores = []
    # Primero los de los apartados numerados (los modelos), luego los de la introducción y la conclusión
    for a in sorted(e['apartados'], key=lambda a: not a['numero'] and a['nivel'] == 0):
        for x in a['autores']:
            n = re.sub(r' \(.*\)$', '', x)
            if n not in autores:
                autores.append(n)
    return '\n            '.join(partes), {'conceptos': conceptos, 'duracion': duracion, 'autores': autores,
                                             'apartados': [a['titulo'] for a in e['apartados'] if a['nivel'] == 0 and a['numero']]}


def descripcion(titulo, codigo, guia, datos):
    """Hasta unos 158 caracteres: qué trae el esquema y los autores principales."""
    base = f'Esquema {"de la guía del dictamen" if guia else "del tema " + codigo} de la oposición TCEE'
    if datos.get('autores'):
        base += ': apartados y autores (' + ', '.join(datos['autores'][:6]) + '…)'
    elif datos.get('apartados'):
        base += ': ' + '; '.join(datos['apartados'])
    base += '. El tema completo, con tu cuenta de Google.' if not guia else '. La guía completa, con tu cuenta de Google.'
    if len(base) > 158:
        corte = base[:155].rsplit(' ', 1)[0].rstrip(',;:(')
        base = corte + '…'
    return base


def datos_estructurados(t, titulo, ruta, datos):
    """LearningResource con el tema de pago (sesión) marcado como tal: Google ve que el tema
    completo no es público y que lo que indexa es el esquema (no es cloaking)."""
    d = {'@context': 'https://schema.org', '@type': 'LearningResource', 'name': titulo, 'url': WEB + ruta,
         'inLanguage': 'es', 'learningResourceType': 'Tema de oposición',
         'educationalLevel': 'Oposición a Técnico Comercial y Economista del Estado (TCEE)',
         'author': {'@type': 'Person', 'name': 'Víctor Gutiérrez Marcos', 'url': WEB + 'sobre-mi.html'},
         'license': WEB + 'condiciones-materiales.html', 'isAccessibleForFree': False,
         'hasPart': {'@type': 'WebPageElement', 'isAccessibleForFree': False, 'cssSelector': '.tema-revisado-marco'}}
    if t.get('aprobado') or t.get('fecha'):
        d['dateModified'] = t.get('aprobado') or t.get('fecha')
    if datos.get('duracion'):
        d['timeRequired'] = datos['duracion']
    if datos.get('conceptos'):
        d['about'] = [{'@type': 'Thing', 'name': c.get('titulo') or c['nombre'], 'sameAs': c['wikipedia']}
                      for c in datos['conceptos']]
    if datos.get('autores'):
        d['mentions'] = [{'@type': 'Person', 'name': n} for n in datos['autores'][:25] if ' et al.' not in n and ' y ' not in n]
    return '<script type="application/ld+json">' + json.dumps(d, ensure_ascii=False) + '</script>'


def pagina_tema(t, web_pdf, ctx=None):
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
    bloque, datos = esquema_html(t, ctx) if ctx else ('', {})
    desc = descripcion(titulo, t['codigo'], guia, datos) if datos else f'{titulo}. Material exclusivo de la oposición TCEE para tu estudio personal, con tu cuenta de Google.'
    h = re.sub(r'<meta name="description" content="[^"]*">', lambda _: f'<meta name="description" content="{esc(desc)}">', h, count=1)
    h = re.sub(r'<link rel="canonical" href="[^"]*">', f'<link rel="canonical" href="{WEB}{ruta}">', h, count=1)
    # Indexable: es la que recibe la URL de siempre del PDF (404.html) y lo que Google puede ver del tema.
    h = h.replace('<meta name="robots" content="noindex, nofollow">', '<meta name="robots" content="index, follow">')
    h = h.replace('<div class="content-container" id="tema-revisado">', f'<div class="content-container" id="tema-revisado" data-tema="{t["archivo"]}">')
    h = re.sub(r'<nav class="breadcrumb">.*?</nav>', f'<nav class="breadcrumb"><a href="../../temario.html">Temario</a><span>›</span><a href="../{pag_ejercicio}">{ejercicio}</a><span>›</span>{"Guía del dictamen" if guia else "Tema " + t["codigo"]}</nav>', h, count=1, flags=re.S)
    h = re.sub(r'(<h1 class="tema-revisado-titulo" id="tema-revisado-titulo">).*?(</h1>)', lambda m: m.group(1) + esc(titulo) + m.group(2), h, count=1, flags=re.S)
    h = h.replace('<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="Tema revisado" hidden>', f'<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="{esc(titulo)}" hidden>')
    if bloque:
        h = h.replace(HUECO_ESQUEMA, bloque, 1)
        h = h.replace(HUECO_DATOS, datos_estructurados(t, titulo, ruta, datos), 1)
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
        ctx = contexto_esquemas(salida)
        for t in entradas:
            web_pdf = GUIA if t['archivo'] == '1D01' else t['pdf']['ruta']
            ruta, h = pagina_tema(t, web_pdf, ctx)
            if not os.path.exists(ruta) or open(ruta, encoding='utf-8').read() != h:
                open(ruta, 'w', encoding='utf-8').write(h)
        print(f'{len(entradas)} páginas HTML de tema')
    print(f'{len(salida)} temas: {borrados} PDF revisados quitados de la web' + (' (en seco)' if seco else ''))


if __name__ == '__main__':
    main()
