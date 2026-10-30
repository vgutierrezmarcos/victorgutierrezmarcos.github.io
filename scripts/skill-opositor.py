#!/usr/bin/env python3
"""
Construye el ZIP de la skill de Claude «EconomIA» para opositores:
el texto propio de la skill (claude/prepara-con-claude/, lo escribe otra
sesión) más las referencias que salen del temario revisado (rama
revision-temario, en el árbol hermano ../victorgutierrezmarcos.github.io-revision)
y de los JSON públicos de la web, todo convertido a Markdown.

    python3 scripts/skill-opositor.py                 # construye y escribe el ZIP y el manifiesto
    python3 scripts/skill-opositor.py --sin-temas     # sin temas/<T>/tema.md (solo fichas y guiones)
    python3 scripts/skill-opositor.py --instalar      # además copia la skill a ~/.claude/skills/
    python3 scripts/skill-opositor.py --comprobar     # no escribe: dice si el ZIP está al día
    python3 scripts/skill-opositor.py --solo 3A08 3A09  # solo esos temas (para probar)
    python3 scripts/skill-opositor.py --salida DIR    # carpeta de construcción (por defecto, temporal)
    python3 scripts/skill-opositor.py --solo-test     # solo references/test/ (banco del test) en la copia desplegada; sin ZIP ni rama
    python3 scripts/skill-opositor.py --ligera        # además, el ZIP «ligero» para el conector MCP (sin temas, dictamen ni canon)

Qué genera (dentro de prepara-con-claude/references/):
- test/: las preguntas oficiales del test con su explicación, por bloque y tema
  (preguntas.json + explicaciones/<examen>.json; INDICE.md dice qué fichero lleva
  cada tema). No necesita pandoc ni la rama: --solo-test lo escribe en la copia
  desplegada de main sin tocar el ZIP, version.json ni el manifiesto.
- temario/: programa-tcee.md y programa-dce.md (temario oficial con lo disponible y
  revisado), bloques-y-conexiones.md (estructura_temario.json), indices-temas.md
  (esquemas.json: el índice de cada PDF, para saber dónde se estudia algo en los
  temas no revisados), frecuencia-test.md y proceso-y-cifras.md.
- temas/<T>/: ficha.md (pandoc de la ficha de repaso .tex tras macros-repaso.tex),
  guion-cante.md (copia) y tema.md (pandoc del HTML del tema); temas/INDICE.md.
- dictamen/: guia-1D01.md, resumen-1D01.md, examen-espana.md y solucion-espana.md.
- canon/: notacion.md (copia) y modelos-indice.md (de mapa.yaml).

Solo convierte lo que hay: entran los temas del manifiesto de la app
(oposicion/temario/app/revisados.json de la rama) con fecha de aprobación. Si a un
tema le falta el guion, la ficha o el HTML, lo dice y sigue. Si pandoc falla en una
ficha, saca el texto de su PDF con pypdf (opcional) y lo avisa.

Pandoc es el de Quarto en Windows (TCEE_PANDOC, como en scripts/temario/comun.py
de la rama); se le pasa el texto por la entrada estándar y se lee de la salida,
así no hace falta traducir rutas. Al final escribe el ZIP en
oposicion/temario/app/prepara-con-claude.zip de la rama y la entrada «skill» de
revisados.json (manifiesto-app.py la conserva al regenerar el manifiesto).

Todo .md que sale de la rama lleva una cabecera de licencia (material exclusivo).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import hashlib
import html as modulo_html
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile
from datetime import datetime

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WT = os.environ.get('TCEE_WORKTREE_REVISION',
                    os.path.join(os.path.dirname(RAIZ), 'victorgutierrezmarcos.github.io-revision'))
REVISION = os.path.join(WT, 'oposicion', 'temario', 'app', 'revisados.json')
FUENTES = os.path.join(WT, 'oposicion', 'temario', 'fuentes')
CANON = os.path.join(WT, 'oposicion', 'temario', 'canon')
FUENTE_SKILL = os.path.join(RAIZ, 'claude', 'prepara-con-claude')
MACROS = os.path.join(RAIZ, 'scripts', 'skill-opositor', 'macros-repaso.tex')
ZIP_RUTA = 'oposicion/temario/app/prepara-con-claude.zip'
ZIP_LIGERA = 'oposicion/temario/app/prepara-con-claude-ligera.zip'  # sin material exclusivo: lo sirve el conector MCP
TEST = os.path.join(RAIZ, 'oposicion', 'temario', 'primer-ejercicio', 'test')
# Nombre técnico de la skill (carpeta dentro del ZIP y `name` de SKILL.md): Claude.ai
# no admite la palabra «claude» en el nombre, así que el título «EconomIA»
# es solo el nombre comercial.
NOMBRE = 'prepara-oposicion'
_WIN = '/mnt/c/Users/vgutierrez/AppData/Local/Programs'
PANDOC = os.environ.get('TCEE_PANDOC', f'{_WIN}/Quarto/bin/tools/pandoc.exe')
SKILLS_USUARIO = os.path.expanduser('~/.claude/skills')

AVISO = ('Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE. '
         'Forma parte de la skill «EconomIA»: solo para la preparación personal del opositor '
         'en su propia cuenta de Claude. No se autoriza copiarlo, redistribuirlo ni usarlo en otras '
         'plataformas o sistemas de IA (ver LICENCIA.md).')
CONDICIONES = 'https://www.victorgutierrezmarcos.es/condiciones-materiales.html'
UMBRAL_MD = 200 * 1024          # aviso si un .md pasa de 200 KB
MAX_LINEAS_SKILL = 500          # SKILL.md no puede pasar de 500 líneas
MAX_DESCRIPCION = 200           # ni su «description» de 200 caracteres

# Formatos de pandoc. El Markdown sale sin HTML en bruto (los span y div se
# quedan en su texto) y con las fórmulas entre $…$ (no la variante $`…`$ de GitHub).
# El HTML lleva las fórmulas como \(…\) y \[…\] (--mathjax); se pasan a $…$ y $$…$$
# antes de pandoc porque con tex_math_single_backslash se perdían las que llevan
# saltos \\ (aligned, gathered).
MD = 'gfm-raw_html-tex_math_gfm+tex_math_dollars'
DE_LATEX = 'latex'
DE_HTML = 'html+tex_math_dollars'

# Equivalencias de las órdenes propias del examen de ejemplo del dictamen y de su
# solución (definidas en sus preámbulos y en tcee.sty) que no están en macros-repaso.tex.
MACROS_EXAMEN = r'''
\newcommand{\cuadro}[3]{\section*{Cuadro #1. #2 (#3)}}
\newcommand{\fuentecuadro}[1]{\par\emph{Fuente: #1}\par}
\newcommand{\cabprev}[1]{\textbf{#1 P}}
\newcommand{\prevcel}[1]{#1}
\newenvironment{bloquecuadro}{}{}
\renewcommand{\grafico}[4]{\par\emph{[Gráfico #1: #2. Fuente: #3]}\par}
'''
MACROS_SOLUCION = r'''
\newcommand{\que}[1]{\par\textbf{#1} }
\newcommand{\rotulo}[1]{\subsection*{#1}}
\newcommand{\fmi}[1]{(FMI, Artículo IV de 2026, informe del personal técnico, p. #1)}
\newcommand{\fmicp}[1]{(FMI, Artículo IV de 2026, comunicado de prensa, p. #1)}
\newenvironment{enunciado}{\begin{quote}}{\end{quote}}
\newenvironment{examen}{}{}
\newenvironment{complemento}[1]{\par\textbf{Cuadro complementario: #1}\par}{}
\newcommand{\grafico}[2][]{\emph{[Gráfico: #2]}}
'''

avisos = []


def aviso(texto):
    avisos.append(texto)
    print('Aviso:', texto, file=sys.stderr)


# --- Utilidades ------------------------------------------------------------------
def leer(ruta):
    with open(ruta, encoding='utf-8') as f:
        return f.read()


def leer_json(ruta):
    with open(ruta, encoding='utf-8') as f:
        return json.load(f)


def escribir(ruta, texto):
    os.makedirs(os.path.dirname(ruta), exist_ok=True)
    with open(ruta, 'w', encoding='utf-8', newline='\n') as f:
        f.write(texto if texto.endswith('\n') else texto + '\n')


def cabecera_licencia():
    """Cabecera de todo .md que sale de la rama de revisión (material exclusivo)."""
    return f'<!-- {AVISO} -->\n*{AVISO}*\n\n'


def cabecera_publica(origen):
    return f'<!-- Generado por scripts/skill-opositor.py a partir de {origen} (datos públicos de victorgutierrezmarcos.es). -->\n\n'


def mmss(valor):
    """Minutos del cante sin decimales, como \\tceemmss: '2,5' → 2′30″, '11' → 11′."""
    v = valor.strip().replace(',', '.')
    if not re.fullmatch(r'\d+(\.\d+)?', v):
        return valor.strip()
    total = round(float(v) * 60)
    m, s = divmod(total, 60)
    return f'{m}′' + (f'{s:02d}″' if s else '')


def codigo_de(archivo):
    """3A08 → 3.A.8"""
    m = re.fullmatch(r'([1345])([A-D])(\d{2})', archivo)
    return f'{m.group(1)}.{m.group(2)}.{int(m.group(3))}' if m else archivo


def grupo(texto, i):
    """Devuelve (contenido, índice tras la llave de cierre) del grupo {…} que empieza en texto[i] == '{'."""
    assert texto[i] == '{', texto[i:i + 30]
    nivel, j = 0, i
    while j < len(texto):
        c = texto[j]
        if c == '\\':
            j += 2
            continue
        if c == '{':
            nivel += 1
        elif c == '}':
            nivel -= 1
            if nivel == 0:
                return texto[i + 1:j], j + 1
        j += 1
    raise ValueError('Llave sin cerrar: ' + texto[i:i + 60])


def grupos(texto, i, n):
    """n grupos {…} seguidos (admite espacios entre ellos) desde texto[i]."""
    salida = []
    for _ in range(n):
        while i < len(texto) and texto[i] in ' \t\n%':
            i = texto.index('\n', i) + 1 if texto[i] == '%' else i + 1
        g, i = grupo(texto, i)
        salida.append(g)
    return salida, i


def limpiar_tabulares(tex):
    """Quita los prefijos >{…} de las especificaciones de columna de tabular/tabularx:
    con >{\\centering} pandoc se come los dígitos con que empieza la celda («12′» → «′»)."""
    salida, pos = [], 0
    for m in re.finditer(r'\\begin\{tabular(x?)\*?\}', tex):
        if m.start() < pos:
            continue
        i = m.end()
        try:
            if m.group(1) and tex.startswith('{', i):   # tabularx: el ancho va antes de las columnas
                i = grupo(tex, i)[1]
            spec, fin = grupo(tex, i)
        except (ValueError, AssertionError):
            continue
        spec = re.sub(r'>\{(?:[^{}]|\{[^{}]*\})*\}', '', spec)
        salida.append(tex[pos:i] + '{' + spec + '}')
        pos = fin
    salida.append(tex[pos:])
    return ''.join(salida)


def sustituir_orden(texto, orden, n, funcion):
    """Sustituye cada \\orden{a}{b}… (n argumentos obligatorios, sin opcional) por funcion(args)."""
    patron = re.compile(r'\\' + orden + r'(?![a-zA-Z])')
    salida, pos = [], 0
    for m in patron.finditer(texto):
        if m.start() < pos:
            continue
        try:
            args, fin = grupos(texto, m.end(), n)
        except (ValueError, AssertionError, IndexError):
            continue
        salida.append(texto[pos:m.start()])
        salida.append(funcion(args))
        pos = fin
    salida.append(texto[pos:])
    return ''.join(salida)


def pandoc(texto, de, a=MD, extra=()):
    """Convierte texto con pandoc (entrada y salida estándar). Devuelve (markdown, avisos de pandoc)."""
    orden = [PANDOC, '-f', de, '-t', a, '--wrap=none', *extra]
    r = subprocess.run(orden, input=texto.encode('utf-8'), capture_output=True, timeout=600)
    err = r.stderr.decode('utf-8', errors='replace').strip()
    if r.returncode != 0:
        raise RuntimeError(f'pandoc falló (código {r.returncode}): {err[-1500:]}')
    return r.stdout.decode('utf-8').replace('\r\n', '\n'), err      # pandoc de Windows: fin de línea CRLF


def limpiar_md(md):
    """Arregla lo que pandoc deja ilegible: corchetes y puntos escapados, enlaces
    internos (quedan como texto), restos de span y más de dos líneas en blanco."""
    md = re.sub(r'\[([^\[\]]*)\]\(#[^)]*\)', r'\1', md)          # [texto](#ancla) → texto
    md = md.replace('\\[', '[').replace('\\]', ']')
    md = re.sub(r'(?<=\d)\\\.', '.', md)                           # 1\. → 1.
    md = re.sub(r'</?span[^>]*>', '', md)
    md = re.sub(r'^&nbsp;[ \t]*\n', '', md, flags=re.M)           # separador de dos listas seguidas
    md = re.sub(r'<div[^>]*>|</div>', '', md)
    md = re.sub(r'[ \t]+$', '', md, flags=re.M)
    md = re.sub(r'\n{3,}', '\n\n', md)
    return md.strip() + '\n'


# --- Fichas de repaso (LaTeX → Markdown) -------------------------------------------
def preparar_tex_repaso(tex):
    """Lo que las macros no pueden hacer: minutos calculados y preámbulo fuera."""
    lineas = [l for l in tex.splitlines()
              if not re.match(r'\s*\\(documentclass|usepackage|begin\{document\}|end\{document\})', l)]
    tex = '\n'.join(lineas)
    # \bloque[2,5]{Título} → \bloquemin{2′30″}{Título}
    tex = re.sub(r'\\bloque\[([^\]]*)\]\{', lambda m: '\\bloquemin{' + mmss(m.group(1)) + '}{', tex)
    for orden in ('apartadocante', 'subcante'):
        tex = sustituir_orden(tex, orden, 2, lambda a, o=orden:
                              f'\\{o}{{{a[0]}}}{{{mmss(a[1])}}}' if a[1].strip() else f'\\{o}sin{{{a[0]}}}')
    tex = sustituir_orden(tex, 'tiempo', 1, lambda a: mmss(a[0]))
    return limpiar_tabulares(tex)


def datos_tcetema(tex):
    """(código, título, corto, fecha) de \\tcetema[corto]{código}{título} y \\tcefecha{…}."""
    corto = codigo = titulo = fecha = ''
    m = re.search(r'\\tcetema(\[)?', tex)
    if m:
        i = m.end()
        if m.group(1):
            corto, i = tex[i:tex.index(']', i)], tex.index(']', i) + 1
        (codigo, titulo), _ = grupos(tex, i, 2)
    f = re.search(r'\\tcefecha\{([^}]*)\}', tex)
    if f:
        fecha = f.group(1).strip()
    return codigo.strip(), re.sub(r'\s+', ' ', titulo).strip(), corto.strip(), fecha


def repaso_a_md(ruta_tex, pdf=None, resumen=False):
    """Ficha de repaso (o resumen de la guía) en Markdown. Si pandoc falla y hay PDF, su texto con pypdf."""
    tex = leer(ruta_tex)
    codigo, titulo, corto, fecha = datos_tcetema(tex)
    tipo = 'Resumen' if resumen else 'Ficha de repaso'
    cabecera = (cabecera_licencia() + f'# {codigo}. {titulo}\n\n'
                + f'*{tipo}' + (f' · actualizada el {fecha}' if fecha else '') + '*\n\n')
    trampa = r'\newcommand{\trampatitulo}{Ojo en el dictamen}' + '\n' if resumen else ''
    try:
        md, err = pandoc(trampa + leer(MACROS) + '\n' + preparar_tex_repaso(tex), DE_LATEX,
                         extra=['--shift-heading-level-by=1'])
        if err:
            aviso(f'{os.path.basename(ruta_tex)}: pandoc dice: {err[-300:]}')
        return cabecera + limpiar_md(md), 'pandoc'
    except Exception as e:  # noqa: BLE001
        aviso(f'{os.path.basename(ruta_tex)}: pandoc falló ({str(e)[:200]})')
    texto = texto_pdf(pdf) if pdf else None
    if not texto:
        return None, None
    return (cabecera + '> Aviso: pandoc no pudo convertir la ficha; este es el texto extraído de su PDF '
            '(sin estructura, fórmulas aproximadas).\n\n' + texto), 'pypdf'


def texto_pdf(ruta):
    if not ruta or not os.path.exists(ruta):
        return None
    try:
        from pypdf import PdfReader
    except ImportError:
        aviso('sin pypdf no se puede sacar el texto del PDF')
        return None
    try:
        return '\n\n'.join((p.extract_text() or '') for p in PdfReader(ruta).pages)
    except Exception as e:  # noqa: BLE001
        aviso(f'{os.path.basename(ruta)}: pypdf falló ({e})')
        return None


# --- Temas (HTML → Markdown) ------------------------------------------------------
def quitar_etiquetas(s):
    return re.sub(r'\s+', ' ', modulo_html.unescape(re.sub(r'<[^>]+>', '', s))).strip()


def figura_a_texto(m):
    """<figure> → [Gráfico N: pie] Fuente: …; el pie conserva sus fórmulas (span.math) para pandoc."""
    pie = re.search(r'<figcaption>(.*?)</figcaption>', m.group(0), re.S)
    pie = re.sub(r'<(?!/?span class="math inline")[^>]+>', '', pie.group(1)) if pie else ''
    pie = re.sub(r'\s+', ' ', pie).strip()
    n = re.match(r'(Gráfico|Figura|Cuadro|Tabla)\s+([\w.]+?)\.?[–-]\s*(.*)', pie)
    pie = f'{n.group(1)} {n.group(2)}: {n.group(3)}' if n else ('Gráfico: ' + pie if pie else 'Gráfico')
    fuente = re.search(r'<div class="fuente">(.*?)</div>', m.group(0), re.S)
    fuente = (' ' + quitar_etiquetas(fuente.group(1))) if fuente else ''
    return f'<p><em>[{pie}]{fuente}</em></p>'


def titulo_con_minutos(m):
    """<h2 data-minutos="11′">…<span class="minutos">11′</span></h2> → <h2>… (11′)</h2>"""
    nivel, atributos, interior = m.group(1), m.group(2), m.group(3)
    minutos = re.search(r'data-minutos="([^"]*)"', atributos)
    interior = re.sub(r'<span class="minutos"[^>]*>.*?</span>', '', interior, flags=re.S).strip()
    if minutos and minutos.group(1):
        interior += f' ({minutos.group(1)})'
    return f'<h{nivel}>{interior}</h{nivel}>'


def preparar_html(html):
    """El artículo del tema sin navegación, cabecera, pie, SVG, estilos ni guiones;
    las figuras como [Gráfico: pie]; los minutos de cada apartado en su título."""
    m = re.search(r'<article class="tema-documento">(.*)</article>', html, re.S)
    cuerpo = m.group(1) if m else html
    for patron in (r'<nav class="breadcrumb">.*?</nav>', r'<header class="tema-cabecera">.*?</header>',
                   r'<footer class="tema-pie">.*?</footer>', r'<p class="aviso-exclusivo">.*?</p>',
                   r'<svg.*?</svg>', r'<style.*?</style>', r'<script.*?</script>',
                   r'<nav class="tema-indice".*?</nav>'):
        cuerpo = re.sub(patron, '', cuerpo, flags=re.S)
    cuerpo = re.sub(r'<figure\b.*?</figure>', figura_a_texto, cuerpo, flags=re.S)
    # (sin líneas en blanco dentro de la fórmula: $$…$$ no las admite)
    cuerpo = re.sub(r'(<span class="math inline">)\\\((.*?)\\\)(</span>)',
                    lambda m: m.group(1) + '$' + re.sub(r'\n\s*\n', '\n', m.group(2)) + '$' + m.group(3), cuerpo, flags=re.S)
    cuerpo = re.sub(r'(<span class="math display">)\\\[(.*?)\\\](</span>)',
                    lambda m: m.group(1) + '$$' + re.sub(r'\n\s*\n', '\n', m.group(2)) + '$$' + m.group(3), cuerpo, flags=re.S)
    cuerpo = re.sub(r'<h([1-6])([^>]*)>(.*?)</h\1>', titulo_con_minutos, cuerpo, flags=re.S)
    cuerpo = re.sub(r'<a [^>]*class="vertema"[^>]*>(.*?)</a>', r'\1', cuerpo, flags=re.S)
    cuerpo = re.sub(r'<span class="smallcaps">(.*?)</span>', r'\1', cuerpo, flags=re.S)
    cuerpo = re.sub(r'<a [^>]*class="footnote-back"[^>]*>.*?</a>', '', cuerpo, flags=re.S)
    cuerpo = cuerpo.replace('<wbr>', '')
    return cuerpo


def datos_cabecera_html(html):
    def uno(patron):
        m = re.search(patron, html, re.S)
        return quitar_etiquetas(m.group(1)) if m else ''
    return {'codigo': uno(r'<p class="tema-codigo">(.*?)</p>'),
            'titulo': uno(r'<h1 class="tema-titulo">(.*?)</h1>'),
            'meta': uno(r'<p class="tema-meta">(.*?)</p>'),
            'resumen': uno(r'<p class="tema-resumen">(.*?)</p>')}


def html_a_md(ruta_html, titulo_defecto=''):
    html = leer(ruta_html)
    d = datos_cabecera_html(html)
    titulo = d['titulo'] or titulo_defecto
    cabecera = cabecera_licencia() + f'# {d["codigo"] + ". " if d["codigo"] else ""}{titulo}\n\n'
    if d['meta']:
        cabecera += f'*{d["meta"]}*\n\n'
    if d['resumen']:
        cabecera += d['resumen'] + '\n\n'
    md, err = pandoc(preparar_html(html), DE_HTML)
    if err:
        aviso(f'{os.path.basename(ruta_html)}: pandoc dice: {err[-300:]}')
    return cabecera + limpiar_md(md)


# --- Guía del dictamen: examen de ejemplo y solución (LaTeX → Markdown) -------------
def cuerpo_documento(tex):
    m = re.search(r'\\begin\{document\}(.*)\\end\{document\}', tex, re.S)
    return m.group(1) if m else tex


def incluir_inputs(tex, carpeta):
    """Sustituye cada \\input{x} por el contenido de x.tex (relativo a carpeta), recursivamente."""
    def leer_input(m):
        ruta = os.path.join(carpeta, m.group(1))
        if not ruta.endswith('.tex'):
            ruta += '.tex'
        if not os.path.exists(ruta):
            aviso(f'falta {ruta}')
            return ''
        # Fuera los comentarios (con su salto de línea, como hace LaTeX): un fichero que
        # acaba en «2.100%» dentro de una fila de tabla se comía el resto de la fila
        contenido = re.sub(r'(?<!\\)%[^\n]*\n?', '', leer(ruta))
        return incluir_inputs(contenido, carpeta)   # los \input anidados son relativos al documento principal
    return re.sub(r'\\input\{([^}]+)\}', leer_input, tex)


def figuras_a_texto(tex):
    """\\begin{figure}…\\caption{t}…\\fuente{f}…\\end{figure} (y figuracaja) → [Gráfico: t. Fuente: f]."""
    def una(m):
        interior = m.group(2)
        pie = re.search(r'\\caption\{', interior)
        pie = grupo(interior, pie.end() - 1)[0] if pie else ''
        fuente = re.search(r'\\fuente\{', interior)
        fuente = grupo(interior, fuente.end() - 1)[0] if fuente else ''
        texto = 'Gráfico' + (f': {pie}' if pie else '') + (f'. Fuente: {fuente}' if fuente else '')
        return f'\n\\par\\emph{{[{texto}]}}\\par\n'
    return re.sub(r'\\begin\{(figure\*?|figuracaja)\}(.*?)\\end\{\1\}', una, tex, flags=re.S)


def examen_a_md(carpeta):
    """El examen de ejemplo del dictamen (examen-espana.tex con sus cuadros)."""
    tex = incluir_inputs(cuerpo_documento(leer(os.path.join(carpeta, 'examen-espana.tex'))), carpeta)
    tex = re.sub(r'^\\(paperwidth|newgeometry|fancyheadoffset|thispagestyle|setlength|pdfpagewidth).*$', '', tex, flags=re.M)
    tex = re.sub(r'\\fcolorbox\{[^}]*\}\{[^}]*\}', '', tex)
    # Cuadros generados: columnas *{n}{N} (números alineados) → l + n columnas r
    tex = re.sub(r'\\begin\{tabular\}\{@\{\}>\{[^}]*\}p\{[^}]*\}\*\{(\d+)\}\{N\}@\{\}\}',
                 lambda m: '\\begin{tabular}{l' + 'r' * int(m.group(1)) + '}', tex)
    tex = limpiar_tabulares(tex.replace('$-$', '−').replace('{,}', ','))
    md, err = pandoc(leer(MACROS) + MACROS_EXAMEN + tex, DE_LATEX, extra=['--shift-heading-level-by=1'])
    if err:
        aviso(f'examen-espana.tex: pandoc dice: {err[-300:]}')
    return (cabecera_licencia() + '# Examen de ejemplo completo del dictamen: la economía española\n\n'
            '*Guía del dictamen de coyuntura (1D01). Examen de ejemplo, no oficial, con datos oficiales; '
            'los gráficos del cuadernillo se indican entre corchetes.*\n\n' + limpiar_md(md))


def solucion_a_md(carpeta):
    """La solución de máximos del examen (solucion-espana.tex y sus secciones) más las notas."""
    sol = os.path.join(carpeta, 'solucion')
    tex = incluir_inputs(cuerpo_documento(leer(os.path.join(sol, 'solucion-espana.tex'))), sol)
    tex = re.sub(r'\\(begin|end)\{tablacaja\}', r'\\\1{table}', tex)
    tex = figuras_a_texto(tex)
    tex = sustituir_orden(tex, 'tiempo', 1, lambda a: mmss(a[0]))
    tex = citas_a_texto(tex, leer_bib(os.path.join(sol, 'solucion.bib'), os.path.join(FUENTES, '1D01', '1D01.bib')))
    tex = limpiar_tabulares(tex)
    md, err = pandoc(leer(MACROS) + MACROS_SOLUCION + tex, DE_LATEX, extra=['--shift-heading-level-by=1'])
    if err:
        aviso(f'solucion-espana.tex: pandoc dice: {err[-300:]}')
    salida = (cabecera_licencia() + '# Solución de máximos del examen de ejemplo del dictamen: España\n\n'
              '*Guía del dictamen de coyuntura (1D01). Texto de examen (lo que escribiría el opositor) y '
              'cuadros complementarios (por qué, cálculos, errores y alternativas).*\n\n' + limpiar_md(md))
    notas = os.path.join(carpeta, 'notas-para-la-solucion.md')
    if os.path.exists(notas):
        salida += '\n\n---\n\n# Anexo: notas para la solución (cifras y fuentes por pregunta)\n\n' + leer(notas)
    return salida


def leer_bib(*rutas):
    """clave → «Apellido, año» (o la organización) de los .bib, lo justo para citar en texto."""
    salida = {}
    for ruta in rutas:
        if not os.path.exists(ruta):
            continue
        texto = leer(ruta)
        for m in re.finditer(r'@\w+\s*\{\s*([^,\s]+)\s*,', texto):
            clave, i, campos = m.group(1), m.end(), {}
            while i < len(texto) and texto[i] != '@':
                c = re.compile(r'\s*(\w+)\s*=\s*').match(texto, i)
                if not c:
                    break
                i = c.end()
                if texto[i] == '{':
                    valor, i = grupo(texto, i)
                elif texto[i] == '"':
                    fin = texto.index('"', i + 1)
                    valor, i = texto[i + 1:fin], fin + 1
                else:
                    v = re.compile(r'[^,}\s]+').match(texto, i)
                    valor, i = v.group(0), v.end()
                campos[c.group(1).lower()] = re.sub(r'\s+', ' ', valor).strip()
                i = re.compile(r'\s*,?\s*').match(texto, i).end()
                if i < len(texto) and texto[i] == '}':
                    break
            autor = campos.get('author') or campos.get('editor') or campos.get('organization') or clave
            primero = re.split(r'\s+and\s+', autor)[0]
            if primero.startswith('{'):
                primero = primero.strip('{}')
            elif ',' in primero:
                primero = primero.split(',')[0]
            else:
                primero = primero.split()[-1]
            anno = (campos.get('year') or campos.get('date') or '')[:4]
            salida[clave] = primero.strip('{}') + (f', {anno}' if anno else '')
    return salida


def citas_a_texto(tex, bib):
    """\\parencite[p. 3]{clave} → (Autor, año, p. 3); \\textcite{clave} → Autor (año)."""
    def una(m):
        orden, opcion, claves = m.group(1), m.group(2), m.group(3)
        partes = []
        for k in claves.split(','):
            k = k.strip()
            partes.append(bib.get(k, k))
        texto = '; '.join(partes) + (f', {opcion}' if opcion else '')
        if orden == 'textcite':
            return re.sub(r'^([^,]+), (.*)$', r'\1 (\2)', texto)
        return f'({texto})'
    return re.sub(r'\\(parencite|textcite|cite)(?:\[([^\]]*)\])?\{([^}]*)\}', una, tex)


# --- Guion del cante -------------------------------------------------------------
def guion_a_md(ruta):
    """Copia literal del guion sin la cita inicial que habla de escenas.yaml."""
    texto = leer(ruta)
    partes = re.split(r'\n\s*\n', texto)
    for i, p in enumerate(partes[:4]):
        if p.lstrip().startswith('>') and 'escenas.yaml' in p:
            del partes[i]
            break
    return cabecera_licencia() + '\n\n'.join(partes)


# --- Canon: lector mínimo de YAML (mapa.yaml) --------------------------------------
_CLAVE = re.compile(r'^([^\s#][^:]*?):(?:\s+(.*))?$')


def leer_yaml(texto):
    """Lo justo para mapa.yaml: mapas por sangría, listas «- », escalares de varias
    líneas y cadenas entre comillas simples o dobles."""
    lineas = [l.rstrip() for l in texto.splitlines()]
    lineas = [l for l in lineas if l.strip() and not l.lstrip().startswith('#')]

    def sangria(l):
        return len(l) - len(l.lstrip())

    def cerrar_comillas(cuerpo, comilla):
        """El texto de una cadena entrecomillada si se cierra dentro de cuerpo ('' es una comilla literal); None si sigue."""
        j, salida = 0, []
        while j < len(cuerpo):
            c = cuerpo[j]
            if c == comilla:
                if comilla == "'" and cuerpo[j + 1:j + 2] == "'":
                    salida.append("'")
                    j += 2
                    continue
                return ''.join(salida)
            if comilla == '"' and c == '\\':
                salida.append(cuerpo[j + 1:j + 2])
                j += 2
                continue
            salida.append(c)
            j += 1
        return None

    def escalar(valor, i, nivel):
        """Valor que empieza en la línea i-1; se come las líneas de continuación. Devuelve (valor, i)."""
        v = valor.strip()
        if v[:1] in ('"', "'"):
            comilla, cuerpo = v[0], v[1:]
            texto = cerrar_comillas(cuerpo, comilla)
            while texto is None and i < len(lineas):
                cuerpo += ' ' + lineas[i].strip()
                i += 1
                texto = cerrar_comillas(cuerpo, comilla)
            return (cuerpo if texto is None else texto), i
        while i < len(lineas) and sangria(lineas[i]) > nivel:    # continuación del escalar
            v += ' ' + lineas[i].strip()
            i += 1
        if v in ('null', '~', ''):
            return None, i
        if v in ('true', 'false'):
            return v == 'true', i
        return v, i

    def nodo(i, nivel):
        if lineas[i].lstrip().startswith('- '):
            lista = []
            while i < len(lineas) and sangria(lineas[i]) == nivel and lineas[i].lstrip().startswith('- '):
                contenido = lineas[i].lstrip()[2:]
                if _CLAVE.match(contenido):
                    # Mapa cuyo primer par va en la línea del guion: se lee como si estuviera sangrado
                    lineas[i] = ' ' * (nivel + 2) + contenido
                    valor, i = nodo(i, nivel + 2)
                else:
                    valor, i = escalar(contenido, i + 1, nivel)
                lista.append(valor)
            return lista, i
        mapa = {}
        while i < len(lineas) and sangria(lineas[i]) == nivel and not lineas[i].lstrip().startswith('- '):
            m = _CLAVE.match(lineas[i].strip())
            if not m:
                i += 1
                continue
            clave, resto = m.group(1).strip(), m.group(2)
            if clave[:1] in ('"', "'"):
                clave = clave[1:-1]
            i += 1
            if resto is None or resto.strip() == '':
                if i < len(lineas) and sangria(lineas[i]) > nivel:
                    valor, i = nodo(i, sangria(lineas[i]))
                elif i < len(lineas) and sangria(lineas[i]) == nivel and lineas[i].lstrip().startswith('- '):
                    valor, i = nodo(i, nivel)      # lista con los guiones al nivel de la clave
                else:
                    valor = None
            else:
                valor, i = escalar(resto, i, nivel)
            mapa[clave] = valor
        return mapa, i

    return nodo(0, sangria(lineas[0]))[0] if lineas else {}


def modelos_indice_md(mapa):
    modelos = mapa.get('modelos') or {}
    temas = mapa.get('temas') or {}
    lineas = [cabecera_licencia(), '# Índice de modelos del canon del temario\n',
              'De `canon/mapa.yaml`: cada modelo compartido por dos o más temas, el tema que lo desarrolla '
              '(referencia) y los temas que lo usan, con el papel de cada uno (desarrollo, resumen o mención). '
              'Sirve para saber en qué tema se estudia un modelo y dónde se remite a él.\n']
    por_area = {}
    for id_, m in modelos.items():
        por_area.setdefault((m or {}).get('area') or 'sin área', []).append((id_, m or {}))
    for area, lista in por_area.items():
        lineas.append(f'\n## Área: {area}\n')
        lineas.append('| Modelo | Nombre | Tema de referencia | Temas que lo usan |')
        lineas.append('|---|---|---|---|')
        for id_, m in lista:
            ref = m.get('tema_referencia')
            ref = ', '.join(ref) if isinstance(ref, list) else (ref or '')
            usos = m.get('temas') or {}
            usos = '; '.join(f'{t}: {p}' for t, p in usos.items()) if isinstance(usos, dict) else str(usos)
            lineas.append(f'| {id_} | {m.get("nombre", "")} | {ref} | {usos} |'.replace('\n', ' '))
    lineas.append('\n## Modelos por tema\n')
    for codigo, t in temas.items():
        mods = (t or {}).get('modelos') or []
        if isinstance(mods, dict):
            mods = list(mods.keys())
        if mods:
            lineas.append(f'- **{codigo}**: ' + ', '.join(str(x) for x in mods))
    return '\n'.join(lineas) + '\n'


# --- Referencias del temario (JSON de main) ---------------------------------------
def programa_md(temario, nombre, estado_tema):
    lineas = [cabecera_publica('oposicion/temario/temario.json'),
              f'# Programa oficial de la oposición a {nombre}\n',
              'Por ejercicio y parte: código, título oficial y estado del tema en victorgutierrezmarcos.es: '
              '«revisado» (versión revisada en la app y en esta skill, con lo que incluye), «disponible» '
              '(PDF en la web) o «no disponible».\n']
    for ej in temario.get('ejercicios', []):
        lineas.append(f'\n## {ej.get("nombre", "")}' + (f': {ej["descripcion"]}' if ej.get('descripcion') else '') + '\n')
        for p in ej.get('partes', []):
            lineas.append(f'\n### Parte {p.get("letra", "")}. {p.get("nombre", "")}\n')
            lineas.append('| Código | Título oficial | Estado |')
            lineas.append('|---|---|---|')
            for t in p.get('temas', []):
                lineas.append(f'| {t.get("codigo", "")} | {t.get("titulo", "")} | {estado_tema(t)} |')
        if ej.get('recursos'):
            lineas.append('\nRecursos: ' + '; '.join(f'{r.get("titulo", "")} ({r.get("url", "")})' for r in ej['recursos']))
    return '\n'.join(lineas) + '\n'


def nodo_texto(n):
    if not isinstance(n, dict):
        return str(n)
    return n.get('tema') or (f'bloque {n["bloque"]}' if n.get('bloque') else str(n))


def bloques_md(estructuras):
    lineas = [cabecera_publica('oposicion/organizacion/estructura_temario.json (TCEE y DCE)'),
              '# Bloques del temario, ideas por tema y conexiones\n',
              'La organización del temario en bloques (grupos de temas que se estudian juntos), la idea '
              'de una línea de cada tema y las conexiones entre temas de los esquemas de la web.\n']
    for nombre, e, titulos in estructuras:
        ideas = e.get('ideas') or {}
        lineas.append(f'\n## {nombre}\n')
        lineas.append('### Bloques\n')
        lineas.append('| Id | Bloque | Ejercicio | Categoría | Temas |')
        lineas.append('|---|---|---|---|---|')
        for b in e.get('bloques', []):
            temas = '; '.join(f'{t} ({corto(ideas.get(t) or titulos.get(t, ""))})' for t in b.get('temas', []))
            lineas.append(f'| {b.get("id", "")} | {b.get("nombre", "")} | {b.get("ejercicio", "")} | {b.get("categoria", "")} | {temas} |')
        if ideas:
            lineas.append('\n### Idea de cada tema\n')
            for t, idea in ideas.items():
                lineas.append(f'- **{t}**: {idea}')
        conexiones, vistas = [], set()
        fuentes = [(es.get('titulo', es.get('id', '')), es.get('conexiones', [])) for es in e.get('esquemas', [])]
        if isinstance(e.get('conexiones'), list):
            fuentes.append(('general', e['conexiones']))
        for origen, lista in fuentes:
            for c in lista:
                de, a = nodo_texto(c.get('de')), nodo_texto(c.get('a'))
                clave = (de, a)
                if clave in vistas:
                    continue
                vistas.add(clave)
                flecha = {(True, True): '↔', (False, True): '→', (True, False): '←'}.get(
                    (bool(c.get('flechaDe')), bool(c.get('flechaA'))), '—')
                texto = f' — {c["texto"]}' if c.get('texto') else ''
                disc = ' (discontinua)' if c.get('discontinua') else ''
                conexiones.append(f'- {de} {flecha} {a}{texto}{disc}')
        if conexiones:
            lineas.append('\n### Conexiones entre temas\n')
            lineas.append('Flechas: → de un tema a otro (el segundo se apoya en el primero), ↔ en los dos sentidos; '
                          '«discontinua», relación más débil.\n')
            lineas.extend(conexiones)
    return '\n'.join(lineas) + '\n'


def corto(titulo):
    t = re.split(r'[.:(]', titulo or '')[0].strip()
    return t[:70] + ('…' if len(t) > 70 else '')


def indices_md(esquemas, titulos):
    lineas = [cabecera_publica('oposicion/temario/esquemas.json'),
              '# Índices de los temas (marcadores de cada PDF)\n',
              'El índice de cada PDF del temario de la web, con la página en la que empieza cada apartado. '
              'Permite localizar dónde se estudia algo en los temas que aún no están revisados (para los '
              'revisados, mejor temas/<T>/tema.md). Nivel de sangría = nivel del apartado.\n']
    for fichero, entradas in esquemas.items():
        m = re.fullmatch(r'([345][AB]\d{2})\.pdf', fichero)
        if m:
            codigo = codigo_de(m.group(1))
            lineas.append(f'\n## {codigo}. {titulos.get(codigo, "")} ({fichero})\n')
        else:
            lineas.append(f'\n## {fichero}\n')
        for e in entradas:
            try:
                nivel, titulo, pagina = e
            except (TypeError, ValueError):
                continue
            lineas.append('  ' * max(int(nivel), 0) + f'- {titulo} (p. {pagina})')
    return '\n'.join(lineas) + '\n'


def frecuencia_md(f):
    temas = f.get('temas') or {}
    examenes = f.get('examenes') or []
    totales = {t: 0 for t in temas}
    for ex in examenes:
        for t, n in (ex.get('temas') or {}).items():
            totales[t] = totales.get(t, 0) + n
    lineas = [cabecera_publica('oposicion/temario/primer-ejercicio/test/frecuencia_temas.json'),
              '# Frecuencia de los temas en el test del primer ejercicio\n',
              (f.get('explicacion') or '') + (f'\n\nActualizado: {f["actualizado"]}.' if f.get('actualizado') else ''),
              f'\n{len(examenes)} exámenes oficiales; {sum(totales.values())} preguntas asignadas a temas.\n',
              '## Exámenes\n', '| Examen | Año | Preguntas |', '|---|---|---|']
    for ex in examenes:
        lineas.append(f'| {ex.get("nombre", ex.get("id", ""))} | {ex.get("anio", "")} | {ex.get("preguntas", "")} |')
    lineas += ['\n## Ranking de temas por número de preguntas\n',
               '| Puesto | Tema | Título | Preguntas | Por examen (id: n) |', '|---|---|---|---|---|']
    orden = sorted(totales.items(), key=lambda x: (-x[1], x[0]))
    for i, (t, n) in enumerate(orden, 1):
        por = '; '.join(f'{ex.get("id", "")}: {ex["temas"][t]}' for ex in examenes if (ex.get('temas') or {}).get(t))
        lineas.append(f'| {i} | {t} | {corto(temas.get(t, ""))} | {n} | {por} |')
    return '\n'.join(lineas) + '\n'


# --- Banco del test: preguntas oficiales con su explicación, por bloque y tema --------
def _slug(texto):
    t = texto.lower()
    for a, b in zip('áéíóúüñ', 'aeiouun'):
        t = t.replace(a, b)
    return re.sub(r'[^a-z0-9]+', '-', t).strip('-')


def _pregunta_md(q, examen, explicacion, otros_temas):
    anio = (examen.get('fecha') or '')[:4]
    nombre = examen.get('nombre') or q['examen']
    cabecera = f'### {q["temas"][0]} · {q["examen"]} ({anio}) · pregunta {q["numero"]} · id {q["id"]}'
    if otros_temas:
        cabecera += f' · también {", ".join(otros_temas)}'
    lineas = [cabecera, '', q['enunciado'].strip()]
    for letra in ('a', 'b', 'c', 'd'):
        if letra in q.get('opciones', {}):
            lineas.append(f'- {letra}) {q["opciones"][letra].strip()}')
    for img in q.get('imagenes') or []:
        lineas.append(f'- *(Figura que no se incluye; en el simulador de la web: {img.get("src", "")}. Describe: {img.get("alt", "").strip()})*')
    resp = q.get('respuesta') or []
    if not resp:
        linea = '**Anulada por el tribunal.**'
    elif len(resp) == 1:
        linea = f'**Respuesta: {resp[0]}).**'
    elif len(resp) == 4:
        linea = '**Respuesta: el tribunal dio por válidas las cuatro.**'
    else:
        linea = f'**Respuesta: {" o ".join(r + ")" for r in resp)} (el tribunal admitió las dos).**'
    if q.get('nota'):
        linea += f' {q["nota"].strip()}'
    if explicacion and explicacion.get('clave'):
        linea += f' {explicacion["clave"].strip()}'
    elif not explicacion:
        linea += ' *(Sin explicación en la web todavía.)*'
    lineas += ['', linea, '']
    return '\n'.join(lineas), nombre


def test_md():
    """Devuelve {ruta relativa dentro de references/test: texto} con las preguntas
    oficiales del test (preguntas.json) y su explicación («¿Por qué?» de la web,
    explicaciones/<examen>.json), un fichero por bloque temático (bloques.json) y,
    dentro, por tema y examen (del más reciente al más antiguo). También el número de
    preguntas y explicaciones que han entrado."""
    datos = leer_json(os.path.join(TEST, 'preguntas.json'))
    bloques = leer_json(os.path.join(TEST, 'bloques.json'))
    examenes = {e['id']: e for e in datos.get('examenes', [])}
    titulos = datos.get('temas') or {}
    explicaciones = {}
    carpeta = os.path.join(TEST, 'explicaciones')
    for f in sorted(os.listdir(carpeta)) if os.path.isdir(carpeta) else []:
        if f.endswith('.json'):
            explicaciones.update(leer_json(os.path.join(carpeta, f)).get('explicaciones') or {})
    sin_texto = leer_json(os.path.join(TEST, 'examenes_sin_texto.json')).get('examenes') or [] \
        if os.path.exists(os.path.join(TEST, 'examenes_sin_texto.json')) else []

    por_tema = {}
    n_preg = n_expl = 0
    for q in datos.get('preguntas', []):
        if not q.get('temas') or not (q.get('enunciado') or '').strip():
            continue
        por_tema.setdefault(q['temas'][0], []).append(q)
    orden_examen = {e['id']: e.get('fecha', '') for e in datos.get('examenes', [])}

    ficheros = {}
    indice = [cabecera_publica('oposicion/temario/primer-ejercicio/test/preguntas.json y explicaciones/*.json'),
              '# Banco del test: preguntas oficiales por tema\n',
              'Las preguntas oficiales del test del primer ejercicio de TCEE (desde 2002) con la respuesta y la explicación '
              'que la app enseña con «¿Por qué?». Un fichero por bloque temático; dentro, por tema (código del programa del 3.er '
              'ejercicio) y examen, del más reciente al más antiguo. Cada pregunta lleva su `id`, el mismo que usa la app y el simulador '
              'de la web, para no repetirle al opositor las que ya ha hecho.\n',
              'Úsalo así: para un test a medida (`agentes/test-personal.md`) abre solo el fichero del bloque de cada tema flojo y '
              'busca `### 3.B.4 ·`; no leas los catorce ficheros. La explicación es la «clave» (dos o tres líneas): el desarrollo '
              'completo está en el simulador de la web y en la app.\n',
              '| Tema | Título | Preguntas | Fichero |', '|---|---|---|---|']
    for b in bloques.get('bloques', []):
        nombre = f'bloque-{b["id"]:02d}-{_slug(b["nombre"])}.md'
        lineas = [cabecera_publica('oposicion/temario/primer-ejercicio/test/preguntas.json y explicaciones/*.json'),
                  f'# Test · Bloque {b["id"]} · {b["nombre"]} (parte {b["parte"]})\n',
                  'Formato de cada pregunta: tema · examen (año) · número · id; enunciado; opciones; respuesta y explicación. '
                  'Las preguntas con figura la describen pero no la incluyen. Las anuladas se marcan.\n']
        total_bloque = 0
        for t in b.get('temas', []):
            qs = sorted(por_tema.get(t, []), key=lambda q: (orden_examen.get(q['examen'], ''), q['numero']), reverse=True)
            lineas.append(f'## {t} · {titulos.get(t, "")}\n')
            if not qs:
                lineas.append('*Sin preguntas con texto en el banco.*\n')
            for q in qs:
                ex = explicaciones.get(str(q['id']))
                md, _ = _pregunta_md(q, examenes.get(q['examen'], {}), ex, q['temas'][1:])
                lineas.append(md)
                n_preg += 1
                n_expl += 1 if ex and ex.get('clave') else 0
            total_bloque += len(qs)
            indice.append(f'| {t} | {corto(titulos.get(t, ""))} | {len(qs)} | `{nombre}` |')
        ficheros[nombre] = '\n'.join(lineas)
    sueltos = sorted(t for t in por_tema if t not in (bloques.get('temaABloque') or {}))
    if sueltos:
        aviso(f'test: temas sin bloque en bloques.json: {", ".join(sueltos)}')
    if sin_texto:
        indice.append(f'\nHay además {len(sin_texto)} exámenes sin el texto de las preguntas (solo cuentan en `temario/frecuencia-test.md`).')
    indice.append(f'\n{n_preg} preguntas, {n_expl} con explicación. Generado el {datetime.now().strftime("%Y-%m-%d")}.')
    ficheros['INDICE.md'] = '\n'.join(indice)
    return ficheros, n_preg, n_expl


def escribir_test(refs):
    """Escribe references/test/ (borra lo anterior) y devuelve (preguntas, explicaciones, bytes)."""
    carpeta = os.path.join(refs, 'test')
    if os.path.exists(carpeta):
        shutil.rmtree(carpeta)
    ficheros, n_preg, n_expl = test_md()
    for nombre, texto in ficheros.items():
        escribir(os.path.join(carpeta, nombre), texto)
    return n_preg, n_expl, tamano_carpeta(carpeta)



def proceso_cifras_md(proceso, cifras, config):
    lineas = [cabecera_publica('oposicion/proceso.json, oposicion/cifras.json y oposicion/app-config.json'),
              '# Convocatoria en curso, cifras de las últimas convocatorias y reglas del sorteo\n']
    if proceso.get('actualizado'):
        lineas.append(f'Proceso selectivo actualizado el {proceso["actualizado"][:10]}; cifras actualizadas el '
                      f'{cifras.get("actualizado", "")} ({cifras.get("fuente", "")}).\n')
    for clave, nombre in (('tcee', 'TCEE'), ('dce', 'DCE')):
        procesos = (proceso.get(clave) or {}).get('procesos') or []
        if not procesos:
            continue
        p = procesos[0]
        lineas.append(f'\n## {nombre}: convocatoria {p.get("convocatoria", "")} (en curso)\n')
        lineas.append(f'Página del Ministerio: {p.get("url", "")}\n')
        secciones = {}
        for d in p.get('documentos', []):
            secciones.setdefault(d.get('seccion', ''), []).append(d)
        for seccion, docs in secciones.items():
            lineas.append(f'\n### {seccion}\n')
            for d in docs:
                fecha = f' (publicado el {d["desde"]})' if d.get('desde') else ''
                lineas.append(f'- {d.get("titulo", "")}{fecha}' + (f' — {d["url"]}' if d.get('url') else ''))
        anteriores = [x.get('convocatoria', '') for x in procesos[1:]]
        if anteriores:
            lineas.append(f'\nConvocatorias anteriores con documentos en la web: {", ".join(anteriores)}.')
    convocatorias = cifras.get('convocatorias') or []
    ultimas = convocatorias[-8:]
    if ultimas:
        claves = []
        for c in ultimas:
            for k in (c.get('tasas_libre') or {}):
                if k not in claves:
                    claves.append(k)
        orden = ['1-test', '1-dictamen', '1', '2-ingles', '2-resto', '2', '3', '4', '5']
        claves.sort(key=lambda k: (orden.index(k) if k in orden else len(orden), k))
        lineas.append('\n## TCEE: plazas, admitidos y tasas por ejercicio (turno libre) de las últimas convocatorias\n')
        lineas.append('Cada celda: presentados → aprobados (% que supera el ejercicio). Fuente: BOE y Ministerio; solo recuentos.\n')
        lineas.append('| Examen (OEP) | Plazas libre | Plazas interna | Admitidos | ' + ' | '.join(claves) + ' | Aprobados finales |')
        lineas.append('|---|---|---|---|' + '---|' * len(claves) + '---|')
        for c in ultimas:
            plazas = c.get('plazas') or {}
            tasas = c.get('tasas_libre') or {}
            celdas = []
            for k in claves:
                t = tasas.get(k)
                celdas.append(f'{t.get("presentados", "")} → {t.get("aprobados", "")} ({t.get("superan_pct", "")} %)' if t else '')
            aprob = c.get('aprobados') or {}
            final = f'{aprob.get("libre", "")} libre' + (f' + {aprob["interna"]} interna' if aprob.get('interna') else '') if aprob else ''
            lineas.append(f'| {c.get("examenes", "")} ({c.get("oep") or "—"}) | {plazas.get("libre", "")} | {plazas.get("interna", "")} | '
                          f'{(c.get("admitidos") or {}).get("total", "")} | ' + ' | '.join(celdas) + f' | {final} |')
        lineas.append(f'\nHistórico completo ({len(convocatorias)} convocatorias desde {convocatorias[0].get("examenes", "")}): '
                      'https://www.victorgutierrezmarcos.es/oposicion/cifras.html')
    sorteo = config.get('sorteo') or {}
    if sorteo:
        lineas.append('\n## Reglas del sorteo de temas (app-config.json)\n')
        for ej, r in sorteo.items():
            partes = f'; se redactan {r["partesARedactar"]} partes' if r.get('partesARedactar') else ''
            lineas.append(f'- Ejercicio {ej}: {r.get("bolasPorParte", "")} bolas (temas) por parte{partes}.')
    conv = config.get('convocatoria') or {}
    if conv.get('urlBoe'):
        lineas.append(f'\nConvocatoria vigente en la app: {conv.get("nombre") or ""} {conv["urlBoe"]}'.rstrip())
    return '\n'.join(lineas) + '\n'


def titulos_de(temario):
    return {t.get('codigo'): t.get('titulo', '') for ej in temario.get('ejercicios', [])
            for p in ej.get('partes', []) for t in p.get('temas', [])}


# --- Construcción -----------------------------------------------------------------
def construir(args):
    manifiesto = leer_json(REVISION)
    temas = [t for t in manifiesto.get('temas', []) if t.get('aprobado')]
    if args.solo:
        quiere = {s.upper().replace('.', '') for s in args.solo}
        temas = [t for t in temas if t['archivo'] in quiere]
    dictamen = manifiesto.get('dictamen') if not args.solo or '1D01' in {s.upper() for s in args.solo} else None

    destino = os.path.join(args.salida, NOMBRE)
    if os.path.exists(destino):
        shutil.rmtree(destino)
    shutil.copytree(FUENTE_SKILL, destino, ignore=shutil.ignore_patterns('evals'))
    refs = os.path.join(destino, 'references')
    if not os.path.exists(os.path.join(destino, 'LICENCIA.md')):
        escribir(os.path.join(destino, 'LICENCIA.md'),
                 f'# Licencia de los materiales\n\n{AVISO}\n\nCondiciones completas: {CONDICIONES}\n')
        aviso('la fuente de la skill no tiene LICENCIA.md; se ha escrito una mínima con el aviso')

    # 1. Referencias del temario (JSON de main)
    temario = leer_json(os.path.join(RAIZ, 'oposicion', 'temario', 'temario.json'))
    titulos = titulos_de(temario)
    incluidos = {t['archivo']: t for t in temas}

    def estado_tcee(t):
        a = re.sub(r'\.', '', t.get('codigo', ''))
        m = re.fullmatch(r'([34])([AB])(\d+)', a)
        archivo = f'{m.group(1)}{m.group(2)}{int(m.group(3)):02d}' if m else ''
        if archivo in incluidos:
            r = incluidos[archivo]
            que = ['tema'] if r.get('html') else []
            que += ['ficha'] if r.get('repaso') else []
            que += ['guion'] if os.path.exists(os.path.join(FUENTES, archivo, 'guion-cante.md')) else []
            return f'revisado el {r.get("aprobado", "")} ({", ".join(que)}: temas/{archivo}/)'
        return 'disponible' if t.get('disponible') else 'no disponible'
    escribir(os.path.join(refs, 'temario', 'programa-tcee.md'),
             programa_md(temario, 'Técnico Comercial y Economista del Estado (TCEE)', estado_tcee))
    ruta_dce = os.path.join(RAIZ, 'app', 'para-manuel', 'oposicion', 'temario', 'temario.json')
    temario_dce = leer_json(ruta_dce) if os.path.exists(ruta_dce) else {}
    if temario_dce:
        escribir(os.path.join(refs, 'temario', 'programa-dce.md'),
                 programa_md(temario_dce, 'Diplomado Comercial del Estado (DCE)',
                             lambda t: 'disponible' if t.get('disponible') else 'no disponible'))
    estructuras = [('TCEE', leer_json(os.path.join(RAIZ, 'oposicion', 'organizacion', 'estructura_temario.json')), titulos)]
    ruta = os.path.join(RAIZ, 'app', 'para-manuel', 'oposicion', 'organizacion', 'estructura_temario.json')
    if os.path.exists(ruta):
        estructuras.append(('DCE', leer_json(ruta), titulos_de(temario_dce)))
    escribir(os.path.join(refs, 'temario', 'bloques-y-conexiones.md'), bloques_md(estructuras))
    escribir(os.path.join(refs, 'temario', 'indices-temas.md'),
             indices_md(leer_json(os.path.join(RAIZ, 'oposicion', 'temario', 'esquemas.json')), titulos))
    escribir(os.path.join(refs, 'temario', 'frecuencia-test.md'),
             frecuencia_md(leer_json(os.path.join(RAIZ, 'oposicion', 'temario', 'primer-ejercicio', 'test', 'frecuencia_temas.json'))))
    escribir(os.path.join(refs, 'temario', 'proceso-y-cifras.md'),
             proceso_cifras_md(leer_json(os.path.join(RAIZ, 'oposicion', 'proceso.json')),
                               leer_json(os.path.join(RAIZ, 'oposicion', 'cifras.json')),
                               leer_json(os.path.join(RAIZ, 'oposicion', 'app-config.json'))))
    n_preg, n_expl, _ = escribir_test(refs)
    print(f'  test: {n_preg} preguntas, {n_expl} con explicación (references/test/)')

    # 2-4. Temas revisados: ficha, guion y tema
    filas = []
    for t in temas:
        a = t['archivo']
        carpeta = os.path.join(refs, 'temas', a)
        fila = {'archivo': a, 'codigo': t.get('codigo', codigo_de(a)), 'titulo': t.get('titulo', ''),
                'aprobado': t.get('aprobado', ''), 'version': t.get('version', ''), 'ficha': 'no', 'guion': 'no', 'tema': 'no', 'pizarra': 'no'}
        tex = os.path.join(FUENTES, a, 'repaso', f'{a}-repaso.tex')
        if t.get('repaso') and os.path.exists(tex):
            md, como = repaso_a_md(tex, os.path.join(WT, t['repaso']['ruta']))
            if md:
                escribir(os.path.join(carpeta, 'ficha.md'), md)
                fila['ficha'] = 'sí' if como == 'pandoc' else 'sí (texto del PDF)'
            else:
                aviso(f'{a}: sin ficha (ni pandoc ni pypdf)')
        else:
            aviso(f'{a}: sin ficha de repaso aprobada')
        guion = os.path.join(FUENTES, a, 'guion-cante.md')
        if os.path.exists(guion):
            escribir(os.path.join(carpeta, 'guion-cante.md'), guion_a_md(guion))
            fila['guion'] = 'sí'
            fila['pizarra'] = 'sí (plan de pizarra en el guion)' if 'Plan de pizarra' in leer(guion) else 'no'
        else:
            aviso(f'{a}: sin guion del cante')
        html = os.path.join(WT, t['html']['ruta']) if t.get('html') else ''
        if args.sin_temas:
            fila['tema'] = 'no (--sin-temas)'
        elif html and os.path.exists(html):
            escribir(os.path.join(carpeta, 'tema.md'), html_a_md(html, t.get('titulo', '')))
            fila['tema'] = 'sí'
        else:
            aviso(f'{a}: sin HTML del tema')
        filas.append(fila)
        print(f'  {a}: ficha {fila["ficha"]}, guion {fila["guion"]}, tema {fila["tema"]}')

    # 7. Índice de temas
    lineas = [cabecera_licencia(), '# Temas revisados incluidos en la skill\n',
              '| Tema | Título | Ficha | Guion | Pizarra | Tema | Aprobado | Versión |', '|---|---|---|---|---|---|---|---|']
    for f in filas:
        lineas.append(f'| {f["codigo"]} ({f["archivo"]}) | {f["titulo"]} | {f["ficha"]} | {f["guion"]} | {f["pizarra"]} | {f["tema"]} | {f["aprobado"]} | {f["version"]} |')
    if dictamen:
        lineas.append(f'| Dictamen (1D01) | {dictamen.get("titulo", "")} | {"sí (resumen)" if dictamen.get("repaso") else "no"} | '
                      f'{"sí" if os.path.exists(os.path.join(FUENTES, "1D01", "guion-cante.md")) else "no"} | no | '
                      f'{"sí (guía)" if dictamen.get("html") and not args.sin_temas else "no"} | {dictamen.get("aprobado", "")} | {dictamen.get("version", "")} |')
    lineas.append('\n«Pizarra» dice si el guion del cante trae un «Plan de pizarra» (qué dibujar en cada apartado y en qué minuto): `references/pizarra.md`.')
    lineas.append(f'\nManifiesto de la rama {manifiesto.get("rama", "")}: commit {manifiesto.get("commit", "")[:10]} '
                  f'(generado el {manifiesto.get("generado", "")}); skill construida el {datetime.now().strftime("%Y-%m-%d %H:%M")}.')
    escribir(os.path.join(refs, 'temas', 'INDICE.md'), '\n'.join(lineas) + '\n')

    # 5. Guía del dictamen
    if dictamen:
        carpeta = os.path.join(refs, 'dictamen')
        html = os.path.join(WT, dictamen['html']['ruta']) if dictamen.get('html') else ''
        if html and os.path.exists(html) and not args.sin_temas:
            escribir(os.path.join(carpeta, 'guia-1D01.md'), html_a_md(html, dictamen.get('titulo', '')))
        tex = os.path.join(FUENTES, '1D01', 'repaso', '1D01-repaso.tex')
        if dictamen.get('repaso') and os.path.exists(tex):
            md, _ = repaso_a_md(tex, os.path.join(WT, dictamen['repaso']['ruta']), resumen=True)
            if md:
                escribir(os.path.join(carpeta, 'resumen-1D01.md'), md)
        guion = os.path.join(FUENTES, '1D01', 'guion-cante.md')
        if os.path.exists(guion):
            escribir(os.path.join(carpeta, 'guion-1D01.md'), guion_a_md(guion))
        examen = os.path.join(FUENTES, '1D01', 'examen-espana')
        if os.path.exists(os.path.join(examen, 'examen-espana.tex')):
            try:
                escribir(os.path.join(carpeta, 'examen-espana.md'), examen_a_md(examen))
            except Exception as e:  # noqa: BLE001
                aviso(f'examen-espana: {str(e)[:300]}')
        if os.path.exists(os.path.join(examen, 'solucion', 'solucion-espana.tex')):
            try:
                escribir(os.path.join(carpeta, 'solucion-espana.md'), solucion_a_md(examen))
            except Exception as e:  # noqa: BLE001
                aviso(f'solucion-espana: {str(e)[:300]}')
        print('  1D01: guía, resumen, examen y solución')

    # 6. Canon
    notacion = os.path.join(CANON, 'notacion.md')
    if os.path.exists(notacion):
        escribir(os.path.join(refs, 'canon', 'notacion.md'), cabecera_licencia() + leer(notacion))
    mapa = os.path.join(CANON, 'mapa.yaml')
    if os.path.exists(mapa):
        try:
            escribir(os.path.join(refs, 'canon', 'modelos-indice.md'), modelos_indice_md(leer_yaml(leer(mapa))))
        except Exception as e:  # noqa: BLE001
            aviso(f'mapa.yaml: no se pudo leer ({str(e)[:200]})')

    return destino, manifiesto, [f['archivo'] for f in filas]


def comprobar_skill_md(destino):
    """Líneas de SKILL.md y longitud de su description; devuelve los errores."""
    errores = []
    ruta = os.path.join(destino, 'SKILL.md')
    if not os.path.exists(ruta):
        return ['falta SKILL.md'], 0, 0
    texto = leer(ruta)
    lineas = texto.count('\n') + (0 if texto.endswith('\n') else 1)
    descripcion = ''
    m = re.search(r'^---\n(.*?)\n---', texto, re.S)
    if m:
        d = re.search(r'^description:\s*(.*?)(?=\n[a-zA-Z_-]+:|\Z)', m.group(1), re.S | re.M)
        if d:
            descripcion = re.sub(r'\s+', ' ', d.group(1)).strip().strip('"\'')
    if lineas > MAX_LINEAS_SKILL:
        errores.append(f'SKILL.md tiene {lineas} líneas (máximo {MAX_LINEAS_SKILL})')
    if len(descripcion) > MAX_DESCRIPCION:
        errores.append(f'la description de SKILL.md tiene {len(descripcion)} caracteres (máximo {MAX_DESCRIPCION})')
    return errores, lineas, len(descripcion)


def tamano_carpeta(ruta):
    total = 0
    for base, _, ficheros in os.walk(ruta):
        total += sum(os.path.getsize(os.path.join(base, f)) for f in ficheros)
    return total


def kb(n):
    return f'{n / 1024:,.0f} KB'.replace(',', '.')


# Carpeta de main (servida por GitHub Pages en victorgutierrezmarcos.es) donde se
# publica la skill también desplegada (fichero a fichero, con URL estable) y su
# version.json: así la skill instalada puede comprobar si hay versión nueva y
# leer de la web los ficheros más recientes sin que el opositor tenga que volver
# a subir el ZIP, y el botón «Empezar en Claude» de la página la lee sin instalar
# (SKILL.md lo explica). Tiene que ser la propia web: claude.ai no puede leer
# raw.githubusercontent.com, githack ni jsDelivr (comprobado el 28 oct. 2026).
# El ZIP sigue en la rama de revisión y se descarga con sesión.
SKILL_RUTA = 'oposicion/temario/app/skill'
KIT = 'kit-documentos.zip'  # en SKILL_RUTA: scripts/ y assets/ para el entorno de código de claude.ai
SITIO = 'https://www.victorgutierrezmarcos.es/'
# Lo que cuenta como «instrucciones» (si cambia, hay que volver a subir el ZIP;
# el resto son contenidos que la skill puede leer de la web)
INSTRUCCIONES = ('SKILL.md', 'LICENCIA.md', 'references/agentes', 'references/oposiciones', 'references/datos-app.md',
                 'references/como-se-canta.md', 'references/carpeta-oposicion.md', 'assets', 'scripts')


def sha_instrucciones(destino):
    h = hashlib.sha256()
    for rel in INSTRUCCIONES:
        ruta = os.path.join(destino, rel)
        if os.path.isfile(ruta):
            h.update(rel.encode()); h.update(open(ruta, 'rb').read())
        elif os.path.isdir(ruta):
            for base, carpetas, ficheros in os.walk(ruta):
                carpetas.sort()
                for f in sorted(ficheros):
                    r = os.path.join(base, f)
                    h.update(os.path.relpath(r, destino).encode()); h.update(open(r, 'rb').read())
    return h.hexdigest()[:16]


def empaquetar(destino, manifiesto, temas, sin_temas):
    """ZIP con la carpeta prepara-oposicion/ dentro (en la rama de revisión), la skill
    desplegada en main (SKILL_RUTA) con su version.json, y la entrada «skill» del manifiesto."""
    ahora = datetime.now()
    version = {
        'version': f'{ahora.strftime("%Y.%m.%d")}-{len(temas)}',
        'generado': ahora.strftime('%Y-%m-%dT%H:%M'),
        'instrucciones': sha_instrucciones(destino),
        'temas': temas,
        'sinTemas': bool(sin_temas),
        'zip': 'https://www.victorgutierrezmarcos.es/oposicion/economia.html',
        'base': f'{SITIO}{SKILL_RUTA}/{NOMBRE}/',
        'versionUrl': f'{SITIO}{SKILL_RUTA}/version.json',
    }
    with open(os.path.join(destino, 'VERSION.txt'), 'w', encoding='utf-8', newline='\n') as f:
        f.write(f"version: {version['version']}\ngenerado: {version['generado']}\ninstrucciones: {version['instrucciones']}\n"
                f"versionUrl: {version['versionUrl']}\nbase: {version['base']}\n")
    # Copia desplegada en main (se borra la anterior) y version.json al lado
    desplegada = os.path.join(RAIZ, SKILL_RUTA)
    if os.path.exists(desplegada):
        shutil.rmtree(desplegada)
    shutil.copytree(destino, os.path.join(desplegada, NOMBRE))
    with open(os.path.join(desplegada, 'version.json'), 'w', encoding='utf-8', newline='\n') as f:
        json.dump(version, f, ensure_ascii=False, indent=1)
        f.write('\n')
    # Kit de documentos y gráficos (scripts, plantilla LaTeX, fuentes y plantillas; nada exclusivo):
    # Claude lo descarga en su entorno de código cuando el opositor solo tiene el conector
    # (references/documentos-y-graficos.md)
    with zipfile.ZipFile(os.path.join(desplegada, KIT), 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for sub in ('scripts', 'assets'):
            for base, carpetas, ficheros in os.walk(os.path.join(destino, sub)):
                carpetas[:] = sorted(c for c in carpetas if c != '__pycache__')
                for f in sorted(ficheros):
                    ruta = os.path.join(base, f)
                    z.write(ruta, os.path.join('kit', os.path.relpath(ruta, destino)))
    zip_destino = os.path.join(WT, ZIP_RUTA)
    os.makedirs(os.path.dirname(zip_destino), exist_ok=True)
    with zipfile.ZipFile(zip_destino, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for base, carpetas, ficheros in os.walk(destino):
            carpetas.sort()
            for f in sorted(ficheros):
                ruta = os.path.join(base, f)
                z.write(ruta, os.path.join(NOMBRE, os.path.relpath(ruta, destino)))
    with open(zip_destino, 'rb') as f:
        contenido = f.read()
    manifiesto['skill'] = {
        'ruta': ZIP_RUTA,
        'tamano': len(contenido),
        'sha': hashlib.sha256(contenido).hexdigest(),
        'version': version['version'],
        'generado': version['generado'],
        'instrucciones': version['instrucciones'],
        'desplegada': f'{SKILL_RUTA}/{NOMBRE}/',
        'versionUrl': version['versionUrl'],
        'temas': temas,
        'sinTemas': bool(sin_temas),
    }
    with open(REVISION, 'w', encoding='utf-8', newline='\n') as f:
        json.dump(manifiesto, f, ensure_ascii=False, indent=1)
        f.write('\n')
    return zip_destino, len(contenido)


def aligerar(destino):
    """Variante «ligera» para el conector MCP (fase 2): quita el material exclusivo
    (references/temas/<T>/, dictamen/ y canon/), que Claude leerá del conector con
    leer_tema, leer_ficha y leer_guia_dictamen; deja temas/INDICE.md (qué temas
    están revisados) y escribe la nota que remite a references/conector.md."""
    refs = os.path.join(destino, 'references')
    for sub in ('dictamen', 'canon'):
        shutil.rmtree(os.path.join(refs, sub), ignore_errors=True)
    temas = os.path.join(refs, 'temas')
    if os.path.isdir(temas):
        for nombre in os.listdir(temas):
            ruta = os.path.join(temas, nombre)
            if os.path.isdir(ruta):
                shutil.rmtree(ruta)
    escribir(os.path.join(refs, 'LIGERA.md'),
             '# Skill ligera\n\nEsta copia de la skill no lleva el material exclusivo (temas revisados, fichas, guía del dictamen '
             'ni canon): se lee con las herramientas del conector «EconomIA» (`references/conector.md`: '
             '`listar_temas_revisados`, `leer_tema`, `leer_ficha`, `leer_guia_dictamen`). Si el conector no está activo, '
             'dilo en una línea y trabaja con los índices de `references/temario/` y conocimiento general.\n')
    zip_destino = os.path.join(WT, ZIP_LIGERA)
    os.makedirs(os.path.dirname(zip_destino), exist_ok=True)
    with zipfile.ZipFile(zip_destino, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for base, carpetas, ficheros in os.walk(destino):
            carpetas.sort()
            for f in sorted(ficheros):
                ruta = os.path.join(base, f)
                z.write(ruta, os.path.join(NOMBRE, os.path.relpath(ruta, destino)))
    return zip_destino, os.path.getsize(zip_destino)


def instalar(destino):
    final = os.path.join(SKILLS_USUARIO, NOMBRE)
    if os.path.exists(final):
        shutil.rmtree(final)
    shutil.copytree(destino, final)
    return final


def comprobar():
    """Sin escribir nada: ¿hay temas aprobados o actualizados después del ZIP, o temas nuevos?"""
    m = leer_json(REVISION)
    s = m.get('skill')
    if not s:
        print('El manifiesto no tiene entrada «skill»: no se ha construido nunca el ZIP.')
        return 1
    fecha = s.get('generado', '')[:10]
    problemas = []
    for t in m.get('temas', []) + ([m['dictamen']] if m.get('dictamen') else []):
        if not t.get('aprobado'):
            continue
        if t['archivo'] not in s.get('temas', []) and t['archivo'] != '1D01':
            problemas.append(f'{t["archivo"]} es nuevo (aprobado el {t["aprobado"]})')
        elif max(t.get('aprobado', ''), t.get('fecha', ''), t.get('repasoAprobado', '')) > fecha:
            problemas.append(f'{t["archivo"]} se aprobó o actualizó después del ZIP ({t.get("fecha")})')
    if not os.path.exists(os.path.join(WT, ZIP_RUTA)):
        problemas.append(f'falta el ZIP {ZIP_RUTA} en la rama')
    if problemas:
        print(f'La skill ({s.get("version")}, generada el {s.get("generado")}) NO está al día:')
        for p in problemas:
            print('  -', p)
        return 1
    print(f'La skill {s.get("version")} está al día ({len(s.get("temas", []))} temas, generada el {s.get("generado")}).')
    return 0


def main():
    p = argparse.ArgumentParser(description='Construye el ZIP de la skill «EconomIA».')
    p.add_argument('--sin-temas', action='store_true', help='sin temas/<T>/tema.md ni la guía del dictamen (solo fichas y guiones)')
    p.add_argument('--instalar', action='store_true', help='copia la skill a ~/.claude/skills/prepara-oposicion/')
    p.add_argument('--comprobar', action='store_true', help='no escribe: dice si el ZIP está al día con el manifiesto')
    p.add_argument('--solo', nargs='+', metavar='T', help='solo estos temas (3A08 3A09 1D01…)')
    p.add_argument('--salida', metavar='DIR', help='carpeta de construcción (por defecto, una temporal)')
    p.add_argument('--ligera', action='store_true',
                   help=f'además del ZIP completo, el ZIP «ligero» para el conector MCP ({ZIP_LIGERA}): sin temas, dictamen ni canon')
    p.add_argument('--solo-test', action='store_true',
                   help='solo references/test/ (banco del test con explicaciones) en la copia desplegada de main '
                        f'({SKILL_RUTA}/{NOMBRE}/references/test/); no toca el ZIP, version.json ni la rama')
    args = p.parse_args()
    if args.comprobar:
        sys.exit(comprobar())
    if args.solo_test:
        refs = os.path.join(RAIZ, SKILL_RUTA, NOMBRE, 'references')
        if not os.path.isdir(refs):
            refs = os.path.join(args.salida or os.path.join(os.path.expanduser('~'), '.cache', 'skill-opositor'), NOMBRE, 'references')
            print(f'No hay copia desplegada en {SKILL_RUTA}; escribo en {refs}')
        n_preg, n_expl, n_bytes = escribir_test(refs)
        print(f'references/test/: {n_preg} preguntas, {n_expl} con explicación, {kb(n_bytes)} en {os.path.join(refs, "test")}')
        for f in sorted(os.listdir(os.path.join(refs, 'test'))):
            n = os.path.getsize(os.path.join(refs, 'test', f))
            print(f'  {f}: {kb(n)}' + (f'  (> {UMBRAL_MD // 1024} KB)' if n > UMBRAL_MD else ''))
        sys.exit(0)
    for ruta, que in ((REVISION, 'el manifiesto de la rama'), (FUENTE_SKILL, 'la fuente de la skill'), (MACROS, 'macros-repaso.tex')):
        if not os.path.exists(ruta):
            sys.exit(f'Falta {que}: {ruta}')
    if not os.path.exists(PANDOC):
        sys.exit(f'No encuentro pandoc en {PANDOC} (variable TCEE_PANDOC)')
    # Carpeta de construcción fuera del repo (tempfile.gettempdir() cae en el
    # directorio actual cuando /tmp no se puede usar, y dejaba la carpeta en la raíz)
    args.salida = args.salida or os.path.join(os.path.expanduser('~'), '.cache', 'skill-opositor')
    os.makedirs(args.salida, exist_ok=True)

    destino, manifiesto, temas = construir(args)
    errores, lineas_skill, long_desc = comprobar_skill_md(destino)
    grandes = []
    for base, _, ficheros in os.walk(destino):
        for f in ficheros:
            ruta = os.path.join(base, f)
            if f.endswith('.md') and os.path.getsize(ruta) > UMBRAL_MD:
                grandes.append((os.path.relpath(ruta, destino), os.path.getsize(ruta)))
    zip_destino, tamano_zip = empaquetar(destino, manifiesto, temas, args.sin_temas)
    if args.instalar:
        print('Instalada en', instalar(destino))

    print(f'\nTemas incluidos ({len(temas)}): {", ".join(temas) or "ninguno"}'
          + (' + dictamen 1D01' if manifiesto.get('dictamen') and (not args.solo or '1D01' in [s.upper() for s in args.solo]) else ''))
    print('Tamaño de cada carpeta:')
    for nombre in sorted(os.listdir(destino)):
        ruta = os.path.join(destino, nombre)
        if os.path.isdir(ruta):
            print(f'  {nombre}/: {kb(tamano_carpeta(ruta))}')
            if nombre == 'references':
                for sub in sorted(os.listdir(ruta)):
                    if os.path.isdir(os.path.join(ruta, sub)):
                        print(f'    references/{sub}/: {kb(tamano_carpeta(os.path.join(ruta, sub)))}')
        else:
            print(f'  {nombre}: {kb(os.path.getsize(ruta))}')
    for ruta, n in grandes:
        print(f'Aviso: {ruta} ocupa {kb(n)} (> {UMBRAL_MD // 1024} KB)')
    print(f'SKILL.md: {lineas_skill} líneas; description: {long_desc} caracteres')
    print(f'ZIP: {os.path.relpath(zip_destino, WT)} ({kb(tamano_zip)}); manifiesto: {os.path.relpath(REVISION, WT)} '
          f'(skill {manifiesto["skill"]["version"]})')
    if args.ligera:  # al final: vacía temas/, dictamen/ y canon/ de la carpeta de construcción
        zip_ligera, tamano_ligera = aligerar(destino)
        print(f'ZIP ligero (conector MCP): {os.path.relpath(zip_ligera, WT)} ({kb(tamano_ligera)})')
    if avisos:
        print(f'{len(avisos)} avisos (arriba).')
    for e in errores:
        print('ERROR:', e)
    sys.exit(1 if errores else 0)


if __name__ == '__main__':
    main()
