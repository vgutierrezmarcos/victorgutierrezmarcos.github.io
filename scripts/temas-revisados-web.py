#!/usr/bin/env python3
"""Los PDF de los temas revisados, en la web con la URL de siempre.

Víctor (25/11/2026): el PDF de un tema se abre en el navegador con una URL de la
web terminada en .pdf (no se descarga desde GitHub), y la URL de siempre lleva al
tema nuevo, para que los enlaces viejos y Google den la versión revisada:

    oposicion/temario/tercer-ejercicio/3A01.pdf             el tema revisado
    oposicion/temario/tercer-ejercicio/3A01-repaso.pdf      su ficha de repaso
    oposicion/temario/tercer-ejercicio/anterior/3A01.pdf    el tema antiguo (si lo había)
    oposicion/temario/primer-ejercicio/esquema_dictamen_economico.pdf          la guía del dictamen revisada
    oposicion/temario/primer-ejercicio/esquema_dictamen_economico-resumen.pdf  su resumen de repaso
    oposicion/temario/primer-ejercicio/anterior/esquema_dictamen_economico.pdf la guía antigua

Lee el manifiesto y los PDF de la rama publicada (temario-publicado, la que ya no
lleva el examen de España) y escribe además oposicion/temario/revisados-web.json:
por tema, sus rutas en la web y los conceptos de su índice (para los metadatos del
PDF, los datos estructurados y el sitemap: metadatos-pdf.py,
datos-estructurados-temario.py y generate-sitemap.js). La primera vez mueve el PDF
antiguo a anterior/ con git mv; después solo copia los que han cambiado. El Word
sigue bajándose de la rama publicada.

    python3 scripts/temas-revisados-web.py            # copia y escribe el índice
    python3 scripts/temas-revisados-web.py --seco     # solo dice qué haría

Después: python3 scripts/metadatos-pdf.py, python3 scripts/datos-estructurados-temario.py,
node generate-sitemap.js, node build-app-data.js y commit (ver LANZAMIENTO.md).

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import subprocess
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WT = os.environ.get('TCEE_WORKTREE_REVISION', RAIZ + '-revision-2')
RAMA = 'temario-publicado'
MANIFIESTO = 'oposicion/temario/app/revisados.json'
INDICE = 'oposicion/temario/revisados-web.json'
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
        lineas.append(f'- [{", ".join(breves) or nombre}]({WEB}{t["pdf"]}): {nombre}')
        completo += [f'## {nombre}', '', f'- PDF: {WEB}{t["pdf"]}'] + ([f'- Ficha de repaso: {WEB}{t["repaso"]}'] if t.get('repaso') else []) \
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
    h = h.replace('<meta name="robots" content="noindex, nofollow">', '<meta name="robots" content="noindex, follow">')
    h = h.replace('<div class="content-container" id="tema-revisado">', f'<div class="content-container" id="tema-revisado" data-tema="{t["archivo"]}">')
    h = re.sub(r'<nav class="breadcrumb">.*?</nav>', f'<nav class="breadcrumb"><a href="../../temario.html">Temario</a><span>›</span><a href="../{pag_ejercicio}">{ejercicio}</a><span>›</span>{"Guía del dictamen" if guia else "Tema " + t["codigo"]}</nav>', h, count=1, flags=re.S)
    h = re.sub(r'(<h1 class="tema-revisado-titulo" id="tema-revisado-titulo">).*?(</h1>)', lambda m: m.group(1) + esc(titulo) + m.group(2), h, count=1, flags=re.S)
    h = h.replace('<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="Tema revisado" hidden>', f'<iframe class="tema-revisado-marco" id="tema-revisado-marco" title="{esc(titulo)}" hidden>')
    h = re.sub(r'<!-- Tema revisado \(exclusivo.*?-->', f'<!-- {esc(titulo)}: página generada por scripts/temas-revisados-web.py a partir de {PLANTILLA}; la rellena exclusivos.js. -->', h, count=1, flags=re.S)
    return ruta, h


def main():
    seco = '--seco' in sys.argv
    os.chdir(RAIZ)
    m = json.loads(git_wt('show', f'{RAMA}:{MANIFIESTO}'))
    anterior_indice = {}
    if os.path.exists(INDICE):
        anterior_indice = {e['archivo']: e for e in json.load(open(INDICE, encoding='utf-8'))['temas']}
    entradas = list(m.get('temas', [])) + ([m['dictamen']] if m.get('dictamen') else [])
    salida, copiados, movidos = [], 0, 0
    for t in entradas:
        guia = t['archivo'] == '1D01'
        web = {'pdf': GUIA if guia else t['pdf']['ruta'],
               'repaso': (GUIA_RESUMEN if guia else t['repaso']['ruta']) if t.get('repaso') else None}
        carpeta, nombre = os.path.split(web['pdf'])
        anterior = f'{carpeta}/anterior/{nombre}'
        previo = anterior_indice.get(t['archivo'], {})
        # La primera vez, el PDF que hay en la URL de siempre es el antiguo: a anterior/.
        if not os.path.exists(anterior) and os.path.exists(web['pdf']) and not previo:
            print(f'mv {web["pdf"]} → {anterior}')
            movidos += 1
            if not seco:
                os.makedirs(os.path.dirname(anterior), exist_ok=True)
                subprocess.run(['git', 'mv', web['pdf'], anterior], check=True)
        for tipo in ('pdf', 'repaso'):
            if not web[tipo]:
                continue
            origen = t[tipo]['ruta']
            sha = git_wt('rev-parse', f'{RAMA}:{origen}').strip()
            if previo.get('sha', {}).get(tipo) == sha and os.path.exists(web[tipo]):
                continue
            print(f'cp {RAMA}:{origen} → {web[tipo]}')
            copiados += 1
            if not seco:
                with open(web[tipo], 'wb') as f:
                    f.write(git_wt('cat-file', 'blob', sha, binario=True))
            previo.setdefault('sha', {})[tipo] = sha
        salida.append({
            'pagina': os.path.splitext(web['pdf'])[0] + '.html',
            'archivo': t['archivo'], 'codigo': t['codigo'], 'titulo': t.get('titulo', ''),
            'aprobado': t.get('aprobado') or t.get('fecha'),
            'pdf': web['pdf'], 'repaso': web['repaso'],
            'anterior': anterior if (os.path.exists(anterior) or (seco and os.path.exists(web['pdf']) and not previo)) else None,
            'apartados': apartados(t.get('esquema')),
            'conceptos': conceptos(t.get('esquema')),
            'sha': previo.get('sha', {}),
        })
    indice = {'descripcion': 'Temas revisados en la web (URL de siempre; el antiguo en anterior/). '
                             'Lo genera scripts/temas-revisados-web.py desde la rama temario-publicado: no editar a mano.',
              'commit': m.get('commit'), 'temas': salida}
    if not seco:
        with open(INDICE, 'w', encoding='utf-8') as f:
            json.dump(indice, f, ensure_ascii=False, indent=1)
            f.write('\n')
    if not seco:
        llms(salida)
        for t in entradas:
            web_pdf = GUIA if t['archivo'] == '1D01' else t['pdf']['ruta']
            ruta, h = pagina_tema(t, web_pdf)
            if not os.path.exists(ruta) or open(ruta, encoding='utf-8').read() != h:
                open(ruta, 'w', encoding='utf-8').write(h)
        print(f'{len(entradas)} páginas HTML de tema junto a su PDF')
    print(f'{len(salida)} temas: {movidos} antiguos a anterior/, {copiados} PDF copiados' + (' (en seco)' if seco else ''))


if __name__ == '__main__':
    main()
