#!/usr/bin/env python3
"""
Oculta o muestra en la web todo lo que lleva a «EconomIA» (el conector
«Oposición TCEE · DCE» para Claude, ChatGPT, Le Chat y Gemini, y la skill de Claude),
de forma reversible:

    python3 scripts/economia-visible.py --ocultar   # nadie llega a la página si no sabe la URL
    python3 scripts/economia-visible.py --mostrar   # el día del lanzamiento
    python3 scripts/economia-visible.py                 # dice cómo está

La página oposicion/economia.html (y su puente prepara-con-claude.html), la skill desplegada y el ZIP siguen
existiendo en sus URL (para probarlo todo); lo que cambia es que no se enlazan
desde ningún sitio ni se indexan:

  - enlaces y bloques en HTML (sub-nav de /oposicion/, portada, comunidad,
    /app/): se envuelven en <template data-oculto="economia"> entre
    marcas <!-- pcc --> … <!-- /pcc -->, que no se renderiza; al mostrar se
    quitan las marcas y la plantilla
  - la pregunta del FAQ en JSON-LD de /app/ y el enlace de condiciones-materiales.html
  - la entrada de novedades.json (se quita; al mostrar se pone con la fecha del día
    y se regenera la portada con scripts/novedades.py)
  - sitemap.xml, llms.txt y el índice de búsqueda (build-search-index.js, que se
    vuelve a ejecutar)
  - exclusivos.py: OCULTOS, para que la lista de materiales exclusivos no la
    nombre (el botón de descarga de la página sigue funcionando)
  - <meta name="robots"> de la página: noindex mientras está oculta

Autor: Víctor Gutiérrez Marcos
"""
import datetime
import json
import os
import re
import subprocess
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MARCA = 'economia'
ABRE = f'<!-- pcc --><template data-oculto="{MARCA}">'
CIERRA = '</template><!-- /pcc -->'

# Bloques HTML a envolver: fichero -> expresiones regulares (DOTALL) del bloque
BLOQUES = {
    'index.html': [r'<a class="app-banner-more" href="oposicion/economia\.html">.*?</a>'],
    'comunidad.html': [r'<div class="community-card">\s*<span class="community-icon">(?:(?!</div>).)*?<h3>EconomIA</h3>.*?</div>'],
    'app/index.html': [
        r'<section class="app-seccion revelar" id="claude">.*?</section>',
        r'<li><strong>EconomIA</strong>:.*?</li>',
        r'<details>\s*<summary>¿Qué es EconomIA\?</summary>.*?</details>',
    ],
}
for pagina in ('index', 'enlaces', 'cifras', 'organizacion', 'probabilidad-test', 'temario', 'por-que-tcee'):
    BLOQUES[f'oposicion/{pagina}.html'] = [r'<li><a href="economia\.html">EconomIA</a></li>']

# Trozos que se sustituyen por otro texto (oculto -> visible)
SUSTITUCIONES = {
    'condiciones-materiales.html': [('«EconomIA»', '<a href="oposicion/economia.html">«EconomIA»</a>')],
    'oposicion/economia.html': [('<meta name="robots" content="noindex, nofollow">', '<meta name="robots" content="index, follow">')],
    'scripts/exclusivos.py': [("OCULTOS = {'prepara-con-claude'}", 'OCULTOS = set()')],
    'politica-cookies.html': [('Más detalle en EconomIA.', 'Más detalle en <a href="/oposicion/economia.html">EconomIA</a>.')],
}

FAQ_JSONLD = """                {
                    "@type": "Question",
                    "name": "¿Qué es EconomIA?",
                    "acceptedAnswer": {
                        "@type": "Answer",
                        "text": "Un conector que añades a tu asistente de IA (Claude, ChatGPT, Le Chat o Gemini; con Claude, completo) y que corrige tus cantes transcritos y tus dictámenes, resuelve dudas con el temario, te hace el cronograma y te pregunta como el tribunal, con tus datos de la app si le das permiso. Depende de la IA, hace falta un plan que admita conectores, y no sustituye a un preparador: lo complementa. Lo explica paso a paso victorgutierrezmarcos.es/oposicion/economia.html."
                    }
                },
"""
FAQ_SIGUIENTE = """                {
                    "@type": "Question",
                    "name": "He encontrado un fallo o tengo una idea","""

NOVEDAD = {
    'seccion': 'Oposición',
    'texto': '«EconomIA»: un conector para Claude, ChatGPT, Le Chat y Gemini (con Claude, completo) que corrige tus cantes y dictámenes con el temario revisado y tus datos de la app, resuelve dudas, hace el cronograma y te pregunta como el tribunal; para TCEE y DCE, y complementa a tu preparador',
    'enlace': 'oposicion/economia.html',
}

SITEMAP = """  <url>
    <loc>https://www.victorgutierrezmarcos.es/oposicion/economia.html</loc>
    <lastmod>{fecha}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
"""
SITEMAP_ANTES = '  <url>\n    <loc>https://www.victorgutierrezmarcos.es/oposicion/enlaces.html</loc>'

LLMS = ('- [EconomIA](https://www.victorgutierrezmarcos.es/oposicion/economia.html): conector MCP «Oposición TCEE · DCE» para Claude, ChatGPT, Le Chat y Gemini (con Claude, completo; también como skill de Claude) que actúa como equipo de preparación para TCEE y DCE con los datos de la app del opositor: corrige cantes transcritos por la app y dictámenes de coyuntura, resuelve dudas con el temario, organiza el cronograma, simula al tribunal y hace tests personales; material exclusivo de uso personal, no sustituye a un preparador. Para usarla sin instalar nada, un asistente puede leer y seguir https://www.victorgutierrezmarcos.es/oposicion/temario/app/skill/prepara-oposicion/SKILL.md (sus ficheros están en esa misma carpeta; versión en https://www.victorgutierrezmarcos.es/oposicion/temario/app/skill/version.json); solo para la preparación personal del opositor en su propia cuenta\n')
LLMS_ANTES = '- [App Oposición TCEE · DCE](https://www.victorgutierrezmarcos.es/app/)'

BUSQUEDA = """  {
    id: 'economia',
    title: 'EconomIA',
    url: '/oposicion/economia.html',
    description: 'Conector para Claude, ChatGPT, Le Chat y Gemini que corrige tus cantes y dictámenes, resuelve dudas con el temario, organiza tu cronograma y te pregunta como el tribunal',
    keywords: ['ia', 'claude', 'chatgpt', 'le chat', 'mistral', 'gemini', 'conector', 'skill', 'inteligencia artificial', 'IA', 'corregir cante', 'corrector', 'dictamen', 'dudas', 'cronograma', 'tribunal', 'simulacro', 'test personal', 'anthropic', 'exportar datos'],
    content: 'Qué hace cada agente, en qué IA funciona y qué plan pide cada una, cómo añadir el conector paso a paso, cómo corregir un cante y un dictamen, cómo hacer el cronograma, privacidad, licencia y preguntas frecuentes'
  },
"""
BUSQUEDA_ANTES = "  {\n    id: 'enlaces',"


def leer(ruta):
    with open(os.path.join(RAIZ, ruta), encoding='utf-8', newline='') as f:
        return f.read()


def escribir(ruta, texto):
    with open(os.path.join(RAIZ, ruta), 'w', encoding='utf-8', newline='') as f:
        f.write(texto)


def esta_oculto():
    return ABRE in leer('oposicion/index.html')


def ocultar():
    hoy = datetime.date.today().isoformat()
    for ruta, patrones in BLOQUES.items():
        s = leer(ruta)
        for patron in patrones:
            m = re.search(patron, s, re.S)
            if not m:
                print(f'  AVISO: no encuentro en {ruta}: {patron[:50]}')
                continue
            if s[max(0, m.start() - len(ABRE)):m.start()] == ABRE:
                continue
            s = s[:m.start()] + ABRE + m.group(0) + CIERRA + s[m.end():]
        escribir(ruta, s)
    for ruta, pares in SUSTITUCIONES.items():
        s = leer(ruta)
        for oculto, visible in pares:
            s = s.replace(visible, oculto)
        escribir(ruta, s)
    # FAQ en JSON-LD de /app/
    s = leer('app/index.html')
    if FAQ_JSONLD in s:
        escribir('app/index.html', s.replace(FAQ_JSONLD, ''))
    # Novedad
    ruta = 'novedades.json'
    novedades = json.loads(leer(ruta))
    quedan = [n for n in novedades if n.get('enlace') != NOVEDAD['enlace']]
    if len(quedan) != len(novedades):
        escribir(ruta, json.dumps(quedan, ensure_ascii=False, indent=2) + '\n')
    subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'novedades.py')], check=True, cwd=RAIZ)
    # Sitemap, llms.txt, índice de búsqueda
    s = leer('sitemap.xml')
    escribir('sitemap.xml', re.sub(r'  <url>\s*<loc>https://www\.victorgutierrezmarcos\.es/oposicion/economia\.html</loc>.*?</url>\n', '', s, flags=re.S))
    s = leer('llms.txt')
    escribir('llms.txt', re.sub(r'- \[(?:Prepara con (?:Claude|IA)|EconomIA)\]\(https://www\.victorgutierrezmarcos\.es/oposicion/(?:prepara-con-(?:claude|ia)|economia)\.html\):[^\n]*\n', '', s))
    s = leer('build-search-index.js')
    escribir('build-search-index.js', re.sub(r"  \{\n    id: '(?:prepara-con-(?:claude|ia)|economia)',.*?\n  \},\n", '', s, flags=re.S))
    subprocess.run(['node', os.path.join(RAIZ, 'build-search-index.js')], check=True, cwd=RAIZ)
    subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'exclusivos.py')], check=True, cwd=RAIZ)
    print(f'Oculto ({hoy}): la página sigue en /oposicion/economia.html, sin enlaces ni índices.')


def mostrar():
    hoy = datetime.date.today().isoformat()
    for ruta in BLOQUES:
        s = leer(ruta)
        escribir(ruta, s.replace(ABRE, '').replace(CIERRA, ''))
    for ruta, pares in SUSTITUCIONES.items():
        s = leer(ruta)
        for oculto, visible in pares:
            s = s.replace(oculto, visible)
        escribir(ruta, s)
    s = leer('app/index.html')
    if FAQ_JSONLD not in s:
        assert s.count(FAQ_SIGUIENTE) == 1, 'no encuentro dónde poner la pregunta del FAQ en app/index.html'
        escribir('app/index.html', s.replace(FAQ_SIGUIENTE, FAQ_JSONLD + FAQ_SIGUIENTE))
    ruta = 'novedades.json'
    novedades = json.loads(leer(ruta))
    if not any(n.get('enlace') == NOVEDAD['enlace'] for n in novedades):
        novedades.insert(0, {'fecha': hoy, **NOVEDAD})
        escribir(ruta, json.dumps(novedades, ensure_ascii=False, indent=2) + '\n')
    subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'novedades.py')], check=True, cwd=RAIZ)
    s = leer('sitemap.xml')
    if 'economia.html</loc>' not in s:
        assert s.count(SITEMAP_ANTES) == 1
        escribir('sitemap.xml', s.replace(SITEMAP_ANTES, SITEMAP.format(fecha=hoy) + SITEMAP_ANTES))
    s = leer('llms.txt')
    if 'economia.html' not in s:
        i = s.index(LLMS_ANTES)
        j = s.index('\n', i) + 1
        escribir('llms.txt', s[:j] + LLMS + s[j:])
    s = leer('build-search-index.js')
    if "id: 'economia'" not in s:
        assert s.count(BUSQUEDA_ANTES) == 1
        escribir('build-search-index.js', s.replace(BUSQUEDA_ANTES, BUSQUEDA + BUSQUEDA_ANTES))
    subprocess.run(['node', os.path.join(RAIZ, 'build-search-index.js')], check=True, cwd=RAIZ)
    subprocess.run([sys.executable, os.path.join(RAIZ, 'scripts', 'exclusivos.py')], check=True, cwd=RAIZ)
    print(f'Visible ({hoy}): novedad con fecha de hoy, sitemap, llms.txt, búsqueda y enlaces restaurados.')
    print('Recuerda: quitar «hidden» del vídeo cuando exista la clave claude-prepara, y del apartado #conector cuando esté desplegado.')


if __name__ == '__main__':
    if '--ocultar' in sys.argv:
        ocultar()
    elif '--mostrar' in sys.argv:
        mostrar()
    else:
        print('oculto' if esta_oculto() else 'visible')
