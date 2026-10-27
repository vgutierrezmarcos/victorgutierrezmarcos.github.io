#!/usr/bin/env python3
"""
Construye el PDF, la página HTML y el Word de un tema a partir de su fuente
LyX (o LaTeX) en oposicion/temario/fuentes/<tema>/.

    python3 scripts/temario/construir-tema.py 3A08 [--solo pdf|html|docx|graficos]

Pasos:
  1. Pone a la par T.lyx y T.tex según las huellas guardadas en estado.json: si
     solo cambió el .lyx, se exporta a .tex; si solo el .tex, se regenera el
     .lyx; si los dos, se para y avisa (ver sincronizar_lyx).
  2. Compila cada gráfico de graficos/*.tex (TikZ standalone) a PDF y de ahí
     saca un SVG (para la web, con pdftocairo) y un PNG a 300 ppp (para Word).
  3. Compila el PDF del tema (pdflatex + biber + pdflatex ×2).
  4. Genera el HTML y el Word con pandoc (latex/tcee.lua, latex/pandoc-macros.tex,
     latex/plantilla-tema.html y latex/reference.docx).
  5. Copia los tres ficheros a oposicion/temario/<ejercicio>/<tema>.{pdf,html,docx}.

Los intermedios quedan en fuentes/<tema>/_trabajo/ (no van a git).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import datetime
import glob
import json
import os
import re
import shutil
import sys

import fitz  # PyMuPDF

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import (Tema, guardar_pdf_anterior, guardar_docx_anterior, LATEX, MIKTEX, PANDOC, LYX, TEX2LYX, TEMARIO, entorno_tex, ejecutar,  # noqa: E402
                   errores_log, ruta_windows, minutos_texto, paginas_partes, linea_paginas,
                   licencia_corta, licencia_larga, LICENCIA_URL_LEGAL, destinos_temas, primer_tema,
                   escribir_destinos_tex, es_exclusivo, AVISO_EXCLUSIVO, CONDICIONES_URL)

PDFLATEX = os.path.join(MIKTEX, 'pdflatex.exe')
BIBER = os.path.join(MIKTEX, 'biber.exe')
PDFTOCAIRO = os.path.join(MIKTEX, 'miktex-pdftocairo.exe')


# --- 1. LyX ↔ LaTeX ------------------------------------------------------------
def _lyx_windows(exe, argumentos, cwd):
    """LyX y tex2lyx necesitan que se les llame con su ruta completa de Windows
    (si no, no encuentran su instalación): se lanzan desde un .bat."""
    bat = os.path.join(cwd, '_lyx.bat')
    with open(bat, 'w', encoding='utf-8', newline='\r\n') as f:
        f.write('@echo off\nchcp 65001 >nul\n')
        f.write(f'set PATH={ruta_windows(MIKTEX)};%PATH%\n')
        f.write(f'cd /d "{ruta_windows(cwd)}"\n')
        f.write(f'"{ruta_windows(exe)}" ' + ' '.join(f'"{a}"' for a in argumentos) + '\n')
    try:
        return ejecutar(['/mnt/c/Windows/System32/cmd.exe', '/c', ruta_windows(bat)], timeout=900, comprobar=False)
    finally:
        if os.path.exists(bat):     # (alguna vez ya no está: otro proceso o el propio LyX lo quitan)
            os.remove(bat)


def _huella_fichero(ruta):
    import hashlib
    return hashlib.sha1(open(ruta, 'rb').read()).hexdigest()


def sincronizar_lyx(tema):
    """Mantiene a la par T.lyx y T.tex, ambos en git.

    El .tex es la fuente de los agentes; el .lyx se regenera a partir de él
    para que Víctor pueda abrir el tema en LyX. En estado.json («huellas») se
    guarda el SHA-1 de los dos ficheros tal como quedaron la última vez que se
    construyó el tema:
      - si solo ha cambiado el .lyx (Víctor lo editó en LyX), se exporta a .tex;
      - si solo ha cambiado el .tex (los agentes), se regenera el .lyx;
      - si han cambiado los dos, se para con un error: nunca se pisa ninguno
        (hay que decidir cuál manda y exportarlo a mano).
    Sin huellas (primera vez), manda el más reciente por fecha. Sin LyX, o si
    LyX falla, se avisa y se sigue con el .tex.
    """
    tex = os.path.join(tema.dir, f'{tema.archivo}.tex')
    if not LYX or not TEX2LYX:
        return 'LyX no está instalado: se usa solo el .tex'
    estado = tema.estado()
    huellas = dict(estado.get('huellas') or {})
    marca_antigua = os.path.join(tema.trabajo, 'lyx-generado.sha1')    # formato anterior (hasta 19/10/2026)
    if 'lyx' not in huellas and os.path.exists(marca_antigua):
        huellas['lyx'] = open(marca_antigua).read().strip()
    hay_lyx = os.path.exists(tema.lyx)
    lyx_cambiado = hay_lyx and huellas.get('lyx') is not None and _huella_fichero(tema.lyx) != huellas['lyx']
    tex_cambiado = (os.path.exists(tex) and huellas.get('tex') is not None
                    and _huella_fichero(tex) != huellas['tex'])

    def guardar_huellas():
        estado['huellas'] = {'lyx': _huella_fichero(tema.lyx) if os.path.exists(tema.lyx) else None,
                             'tex': _huella_fichero(tex) if os.path.exists(tex) else None}
        tema.guardar_estado(estado)
        if os.path.exists(marca_antigua):
            os.remove(marca_antigua)

    if lyx_cambiado and tex_cambiado:
        raise RuntimeError(
            f'{tema.archivo}.lyx y {tema.archivo}.tex han cambiado los dos desde la última construcción: '
            'no se pisa ninguno. Decide cuál manda: si el .lyx, expórtalo en LyX (Archivo > Exportar > '
            f'LaTeX (pdflatex)) sobre {tema.archivo}.tex; si el .tex, borra las huellas de estado.json '
            '(o el .lyx) y vuelve a construir.')
    if lyx_cambiado:
        cod, salida = _lyx_windows(LYX, ['--batch', '-E', 'pdflatex', f'{tema.archivo}.tex', f'{tema.archivo}.lyx'],
                                   tema.dir)
        if cod != 0 or os.path.getmtime(tex) < os.path.getmtime(tema.lyx):
            return (f'AVISO: {tema.archivo}.lyx se ha editado en LyX pero no se pudo exportar desde aquí: '
                    f'en LyX, Archivo > Exportar > LaTeX (pdflatex) sobre {tema.archivo}.tex, y volver a construir')
        guardar_huellas()
        return f'{tema.archivo}.lyx (editado en LyX) → {tema.archivo}.tex'
    primera_vez = huellas.get('tex') is None
    if not hay_lyx or tex_cambiado or (primera_vez and os.path.getmtime(tex) > os.path.getmtime(tema.lyx) + 1):
        # El módulo tcee.module convierte \\autor, \\concepto, las cajas… en elementos de LyX
        modulo = os.path.join(os.environ.get('LYX_USERDIR', '/mnt/c/Users/vgutierrez/AppData/Roaming/LyX2.4'),
                              'layouts', 'tcee.module')
        if os.path.isdir(os.path.dirname(modulo)):
            shutil.copyfile(os.path.join(LATEX, 'tcee.module'), modulo)
        cod, salida = _lyx_windows(TEX2LYX, ['-m', 'tcee', '-f', '-n', f'{tema.archivo}.tex', f'{tema.archivo}.lyx'],
                                   tema.dir)
        if cod != 0 or not os.path.exists(tema.lyx) or os.path.getsize(tema.lyx) == 0:
            if os.path.exists(tema.lyx) and os.path.getsize(tema.lyx) == 0:
                os.remove(tema.lyx)
            return f'AVISO: tex2lyx no pudo generar {tema.archivo}.lyx: {salida.strip()[-300:]}'
        guardar_huellas()
        return f'{tema.archivo}.tex → {tema.archivo}.lyx'
    if primera_vez or huellas.get('lyx') is None:
        guardar_huellas()
    return 'LyX y LaTeX ya estaban a la par'


def exportar_latex(tema):
    os.makedirs(tema.trabajo, exist_ok=True)
    print(sincronizar_lyx(tema))
    tex_fuente = os.path.join(tema.dir, f'{tema.archivo}.tex')
    if not os.path.exists(tex_fuente):
        raise RuntimeError(f'No hay {tema.archivo}.tex ni {tema.archivo}.lyx en {tema.dir}')
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.tex')
    shutil.copyfile(tex_fuente, destino)
    return destino


def datos_documento(tex):
    texto = re.sub(r'(?<!\\)%[^\n]*', '', open(tex, encoding='utf-8').read())   # sin comentarios
    m = re.search(r'\\tcetema(?:\[[^\]]*\])?\{([^}]*)\}\{((?:[^{}]|\{[^{}]*\})*)\}', texto)
    f = re.search(r'\\tcefecha\{([^}]*)\}', texto)
    # Se admiten medios minutos: \minutos{2,5}
    minutos = [float(x.replace(',', '.')) for x in re.findall(r'\\minutos\{(\d+(?:[.,]\d+)?)\}', texto)]
    return {
        'titulo': m.group(2).strip() if m else '',
        'fecha': f.group(1) if f else datetime.date.today().strftime('%d/%m/%Y'),
        'duracion': (f'{sum(minutos):g}'.replace('.', ',')) if minutos else None,
        # Para la web: 30 → «30 minutos»; 29,5 → «29′30″»
        'duracion_texto': (f'{sum(minutos):g} minutos' if sum(minutos) == int(sum(minutos))
                           else minutos_texto(sum(minutos))) if minutos else None,
    }


def datos_seo(tema):
    """Campos opcionales para buscadores de fuentes/<tema>/seo.json: titulo_seo
    (el concepto primero: «Teoría del consumidor: preferencias y demanda»),
    resumen (2-3 frases, ≤160 caracteres; va de meta description y visible bajo
    el título), palabras_clave (lista: modelos, autores, teoremas) y materia (la
    asignatura universitaria). Si falta el fichero, la página sale como antes."""
    ruta = os.path.join(tema.dir, 'seo.json')
    if not os.path.exists(ruta):
        return {}
    with open(ruta, encoding='utf-8') as f:
        seo = json.load(f)
    if isinstance(seo.get('palabras_clave'), list):
        seo['palabras_clave'] = ', '.join(seo['palabras_clave'])
    # Van dentro de atributos HTML y de JSON-LD: sin comillas rectas ni barras invertidas
    return {k: str(v).replace('"', '”').replace('\\', '').strip() for k, v in seo.items() if v}


# --- 2. Gráficos -------------------------------------------------------------------
def compilar_graficos(tema, forzar=False, solo=None):
    """Compila cada graficos/*.tex a PDF, SVG y PNG. Devuelve la lista de errores."""
    errores = []
    env = entorno_tex()
    for tex in sorted(glob.glob(os.path.join(tema.graficos, '*.tex'))):
        base = tex[:-4]
        if solo and os.path.basename(base) not in solo:
            continue
        pdf, svg, png = base + '.pdf', base + '.svg', base + '.png'
        if not forzar and all(os.path.exists(x) and os.path.getmtime(x) >= os.path.getmtime(tex)
                              for x in (pdf, svg, png)):
            continue
        nombre = os.path.basename(tex)
        cod, _ = ejecutar([PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', nombre],
                          cwd=tema.graficos, env=env, timeout=300, comprobar=False)
        if cod != 0:
            errores.append(f'{nombre}:\n' + '\n'.join(errores_log(base + '.log')))
            continue
        ejecutar([PDFTOCAIRO, '-svg', os.path.basename(pdf), os.path.basename(svg)], cwd=tema.graficos)
        titular_svg(svg)
        doc = fitz.open(pdf)
        doc[0].get_pixmap(dpi=300, alpha=False).save(png)
        doc.close()
        for ext in ('.aux', '.log'):
            if os.path.exists(base + ext):
                os.remove(base + ext)
    return errores


def titular_svg(svg):
    """<title> en el SVG (el nombre del gráfico, con espacios): los lectores de
    pantalla y los buscadores lo leen; pdftocairo deja el texto como trazos."""
    nombre = os.path.splitext(os.path.basename(svg))[0].replace('-', ' ').replace('_', ' ')
    texto = open(svg, encoding='utf-8').read()
    if '<title>' in texto:
        return
    texto = re.sub(r'(<svg\b[^>]*>)', lambda m: m.group(1) + f'<title>Gráfico: {nombre}</title>', texto, count=1)
    open(svg, 'w', encoding='utf-8', newline='\n').write(texto)


# --- 3. PDF ----------------------------------------------------------------------------
def compilar_pdf(tema, tex):
    env = entorno_tex()
    # Para que \graphicspath{{graficos/}} y \addbibresource{3A08.bib} funcionen,
    # se compila en la carpeta del tema y los auxiliares van a _trabajo/
    env['TEXINPUTS'] = ruta_windows(tema.dir) + ';' + env['TEXINPUTS']
    nombre = os.path.basename(tex)
    rel = os.path.relpath(tex, tema.dir)
    salida = ['-output-directory=_trabajo']
    orden = [PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', *salida, rel.replace('/', '\\')]
    log = os.path.join(tema.trabajo, nombre[:-4] + '.log')
    cod, _ = ejecutar(orden, cwd=tema.dir, env=env, timeout=900, comprobar=False)
    if cod != 0:
        raise RuntimeError('Error de LaTeX:\n' + '\n\n'.join(errores_log(log)))
    if os.path.exists(tema.bib):
        ejecutar([BIBER, '--input-directory', '_trabajo', '--output-directory', '_trabajo',
                  nombre[:-4]], cwd=tema.dir, env=env, timeout=300)
    for _ in range(2):
        cod, _ = ejecutar(orden, cwd=tema.dir, env=env, timeout=900, comprobar=False)
        if cod != 0:
            raise RuntimeError('Error de LaTeX:\n' + '\n\n'.join(errores_log(log)))
    return os.path.join(tema.trabajo, nombre[:-4] + '.pdf'), avisos_pdf(log, tema)


def avisos_pdf(log, tema):
    """Avisos del .log de LaTeX (y del .blg de biber) que conviene mirar:
    referencias o citas sin definir, cajas desbordadas de más de 2 pt, marcadores
    con órdenes no admitidas (hyperref «Token not allowed»), «Rerun» (hacen falta
    más pasadas), caracteres que faltan en la fuente y avisos de biber."""
    texto_log = open(log, encoding='latin-1').read()
    avisos = sorted(set(re.findall(r'(?:LaTeX|Package \w+) Warning: ([^\n]*(?:undefined|multiply)[^\n]*)', texto_log)))
    desbordes = [(float(pt), lin) for pt, lin in
                 re.findall(r'Overfull \\hbox \(([\d.]+)pt too wide\) in paragraph at lines (\d+)--', texto_log)
                 if float(pt) > 2]
    if desbordes:
        peor = max(desbordes)
        avisos.append(f'{len(desbordes)} líneas desbordadas más de 2 pt (la peor, {peor[0]:.1f} pt en la línea '
                      f'{peor[1]} del .tex): acortar o permitir el corte')
    n = texto_log.count('Token not allowed in a PDF string')
    if n:
        avisos.append(f'{n} marcadores del PDF con órdenes que hyperref quita (ver «Token not allowed» en el .log)')
    if re.search(r'Rerun to get|Label\(s\) may have changed', texto_log):
        avisos.append('LaTeX pide otra pasada (referencias que cambiaron): volver a construir')
    faltan = sorted(set(re.findall(r'Missing character: There is no (\S+) in font', texto_log)))
    if faltan:
        avisos.append('Caracteres que no tiene la fuente: ' + ' '.join(faltan[:10]))
    blg = os.path.join(tema.trabajo, f'{tema.archivo}.blg')
    if os.path.exists(blg):
        for m in sorted(set(re.findall(r'WARN - (.*)', open(blg, encoding='utf-8', errors='replace').read())))[:10]:
            if 'Duplicate entry' in m or 'not found' in m or 'Invalid' in m or 'conflicts' in m:
                avisos.append('biber: ' + m.strip())
    return avisos


# --- 4. HTML y Word --------------------------------------------------------------------
def video_de(tema):
    ruta = os.path.join(TEMARIO, 'videos.json')
    if os.path.exists(ruta):
        with open(ruta, encoding='utf-8') as f:
            return json.load(f).get(tema.archivo)
    return None


def etiquetas_aux(tema):
    """Números de las etiquetas según el .aux del PDF: {'eq:gorman': '17', 'anexo:cardinal': 'A'}."""
    aux = os.path.join(tema.trabajo, f'{tema.archivo}.aux')
    if not os.path.exists(aux):
        return {}
    texto = open(aux, encoding='utf-8', errors='replace').read()
    # Los elementos de una lista (enumitem) guardan el número entre llaves de más:
    # \newlabel{cond:x}{{{3}}{16}…}; se quitan para que quede «3»
    return {m.group(1): m.group(2) for m in re.finditer(r'\\newlabel\{([^}]+)\}\{\{+([^{}]*)\}', texto)}


def titulos_aux(tema):
    """Título del apartado de cada etiqueta según el .aux (para \\nameref):
    \\newlabel{sec:x}{{I.2}{7}{Título}{section.2.2}{}} → {'sec:x': 'Título'}."""
    aux = os.path.join(tema.trabajo, f'{tema.archivo}.aux')
    if not os.path.exists(aux):
        return {}
    texto = open(aux, encoding='utf-8', errors='replace').read()
    titulos = {}
    for m in re.finditer(r'\\newlabel\{([^}]+)\}\{\{[^{}]*\}\{[^{}]*\}\{((?:[^{}]|\{[^{}]*\})*)\}', texto):
        t = re.sub(r'\\(?:newline|\\)\s*', ' ', m.group(2))
        t = re.sub(r'\\[a-zA-Z@]+\s*', '', t).replace('{', '').replace('}', '').strip()
        if t:
            titulos[m.group(1)] = t
    return titulos


def listas_etiquetadas(cuerpo):
    """enumitem [label=\\roman*)] / [label=\\alph*)]… → la forma del paquete
    enumerate ([i)], [a)]), que pandoc sí entiende (<ol type="i">); con la de
    enumitem pierde la numeración y saca 1., 2."""
    formas = {'roman': 'i', 'Roman': 'I', 'alph': 'a', 'Alph': 'A', 'arabic': '1'}

    def cambiar(m):
        antes, tipo, despues = m.group(1), m.group(2), m.group(3)
        return f'\\begin{{enumerate}}[{antes}{formas[tipo]}{despues}]'
    return re.sub(r'\\begin\{enumerate\}\[label=([(]?)\\(roman|Roman|alph|Alph|arabic)\*([.)\]]?)[^\]]*\]', cambiar, cuerpo)


def numerar_anexos(cuerpo):
    """Tras \\appendix, los apartados pasan a «A.», «A.1.»… como en el PDF (pandoc no
    entiende \\appendix y seguiría con la numeración romana)."""
    if '\\appendix' not in cuerpo:
        return cuerpo
    antes, despues = cuerpo.split('\\appendix', 1)
    letra, sub = 0, 0

    def cambiar(m):
        nonlocal letra, sub
        nivel = m.group(1)
        if nivel == 'section':
            letra += 1
            sub = 0
            return f'\\section*{{{chr(64 + letra)}. '
        sub += 1
        return f'\\subsection*{{{chr(64 + letra)}.{sub}. '
    despues = re.sub(r'\\(section|subsection)\{', cambiar, despues)
    # En Word, los anexos son otra sección (páginas A-1…; tcee.lua y numerar_paginas_docx)
    return antes + '\\begin{saltoseccion}\\mbox{}\\end{saltoseccion}' + despues


# --- Órdenes con argumentos anidados (\funcionclave, \optim) --------------------------
def _argumento(texto, i):
    """Lee el argumento entre llaves que empieza en texto[i] (saltando espacios):
    devuelve (contenido, posición tras la llave de cierre)."""
    while i < len(texto) and texto[i] in ' \t\n':
        i += 1
    if i >= len(texto) or texto[i] != '{':
        raise ValueError(f'se esperaba «{{» en: {texto[i:i + 60]!r}')
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
    raise ValueError(f'llave sin cerrar en: {texto[i:i + 60]!r}')


def _partir_filas(texto):
    """Parte por \\\\ en el nivel de llaves superior."""
    filas, nivel, actual, j = [], 0, '', 0
    while j < len(texto):
        if texto.startswith('\\\\', j) and nivel == 0:
            filas.append(actual)
            actual = ''
            j += 2
            continue
        c = texto[j]
        if c == '\\':
            actual += texto[j:j + 2]
            j += 2
            continue
        nivel += (c == '{') - (c == '}')
        actual += c
        j += 1
    filas.append(actual)
    return [f.strip() for f in filas if f.strip()]


def expandir_optim(cuerpo):
    """\\optim{\\max}{\\vect{z}}{objetivo}{r1\\\\ r2} → array de dos columnas (lo
    mismo que hace tcee.sty), que MathJax y el Word de pandoc entienden."""
    salida, pos = '', 0
    for m in re.finditer(r'\\optim(?![a-zA-Z])', cuerpo):
        if m.start() < pos:
            continue
        args, j = [], m.end()
        try:
            for _ in range(4):
                a, j = _argumento(cuerpo, j)
                args.append(a)
        except ValueError:
            continue        # p. ej., «\optim» citado en un comentario
        filas = [f'\\displaystyle {args[0]}_{{{args[1]}}} & \\displaystyle {args[2]}']
        for k, r in enumerate(_partir_filas(expandir_optim(args[3]))):
            filas.append(('\\text{s.a.} & ' if k == 0 else ' & ') + r)
        salida += cuerpo[pos:m.start()] + '\\begin{array}{rl}' + ' \\\\ '.join(filas) + '\\end{array}'
        pos = j
    return salida + cuerpo[pos:]


def expandir_funcionclave(cuerpo):
    """\\funcionclave[eq:x]{F} → entorno «funcionclave» (un Div para tcee.lua) con
    la ecuación dentro; con etiqueta, en equation para que lleve su número."""
    salida, pos = '', 0
    for m in re.finditer(r'\\funcionclave(?![a-zA-Z])\s*(?:\[([^\]]*)\])?', cuerpo):
        if m.start() < pos:
            continue
        try:
            formula, j = _argumento(cuerpo, m.end())
        except ValueError:
            continue
        if m.group(1):
            ecuacion = f'\\begin{{equation}}{formula}\\label{{{m.group(1)}}}\\end{{equation}}'
        else:
            ecuacion = f'\\[{formula}\\]'
        salida += cuerpo[pos:m.start()] + f'\n\\begin{{funcionclave}}\n{ecuacion}\n\\end{{funcionclave}}\n'
        pos = j
    return salida + cuerpo[pos:]


def preparar_pandoc(tema, tex, formato):
    """LaTeX para pandoc: las equivalencias de pandoc-macros.tex delante, las
    referencias (\\ref, \\eqref) con el número que tienen en el PDF y los anexos
    con letra. En HTML, las ecuaciones citadas llevan su número (\\tag).

    Toda remisión es un enlace, como en el PDF: \\ref y \\eqref pasan a
    \\hyperref[etiqueta]{número} (pandoc los convierte en enlaces a #etiqueta;
    las ecuaciones llevan delante un \\hypertarget con su etiqueta) y cada
    \\vertema va dentro de un \\href al tema citado: en HTML, su página si es un
    tema revisado y si no su PDF (rutas relativas); en Word, el PDF de la web."""
    macros = open(os.path.join(LATEX, 'pandoc-macros.tex'), encoding='utf-8').read()
    cuerpo = open(tex, encoding='utf-8').read()
    numeros = etiquetas_aux(tema)
    destinos = destinos_temas(tema.carpeta)

    def enlace_tema(m):
        d = destinos.get(primer_tema(m.group(1)))
        if not d:
            return m.group(0)
        url = d['html'] if formato == 'html' else d['pdf']
        # En \href, «#», «%» y «~» se escapan; las rutas de los temas no los llevan
        return f'\\href{{{url}}}{{{m.group(0)}}}'
    cuerpo = re.sub(r'\\vertema(?:corto)?\{([^{}]*)\}', enlace_tema, cuerpo)
    cuerpo = expandir_funcionclave(expandir_optim(cuerpo))
    # Gráfico o tabla dentro de una caja (figuracaja, tablacaja de tcee.sty): en
    # la web y en Word son figuras y tablas normales dentro del Div de la caja
    cuerpo = re.sub(r'\\(begin|end)\{figuracaja\}', r'\\\1{figure}', cuerpo)
    cuerpo = re.sub(r'\\(begin|end)\{tablacaja\}', r'\\\1{table}', cuerpo)
    # \grafico[\textwidth]: pandoc no entiende un ancho sin número y deja el
    # gráfico pequeño en la web; se trata como 1\textwidth
    cuerpo = re.sub(r'(?<![\d.])\\(textwidth|linewidth|columnwidth)\b', r'1\\\1', cuerpo)
    cuerpo = listas_etiquetadas(cuerpo)
    cuerpo = re.sub(r'\\eqref\{([^}]+)\}',
                    lambda m: f'(\\hyperref[{m.group(1)}]{{{numeros.get(m.group(1), "?")}}})', cuerpo)
    # \nameref: el título del apartado; \pageref: la web y el Word no tienen las
    # páginas del PDF, así que «pág.~\pageref{x}» pasa a ser un enlace con el
    # número de lo citado (ecuación, gráfico, apartado) o «véase»
    titulos = titulos_aux(tema)
    cuerpo = re.sub(r'\\nameref\{([^}]+)\}',
                    lambda m: f'\\hyperref[{m.group(1)}]{{{titulos.get(m.group(1)) or numeros.get(m.group(1), "?")}}}', cuerpo)

    def pagina(m):
        e = m.group(1)
        n = numeros.get(e)
        tipo = {'eq': 'ecuación ', 'fig': 'gráfico ', 'tab': 'tabla ', 'sec': 'apartado ', 'anexo': 'anexo '}
        prefijo = next((v for k, v in tipo.items() if e.startswith(k + ':')), None)
        texto = f'{prefijo}{n}' if n and prefijo else 'véase'
        if prefijo == 'ecuación ' and n:
            texto = f'ecuación ({n})'
        return f'\\hyperref[{e}]{{{texto}}}'
    cuerpo = re.sub(r'(?:p[áa]g(?:ina)?s?\.?[~ ]*)?\\pageref\{([^}]+)\}', pagina, cuerpo)
    cuerpo = re.sub(r'\\(?:auto|c|C)?ref\{([^}]+)\}',
                    lambda m: f'\\hyperref[{m.group(1)}]{{{numeros.get(m.group(1), "?")}}}', cuerpo)

    def etiqueta(m):
        n = numeros.get(m.group(1))
        if formato == 'html' and n and m.group(1).startswith('eq'):
            return f'\\tag{{{n}}}'
        return ''

    def formula(m):
        # Las etiquetas de dentro se quitan (o pasan a \tag) y su ancla va delante
        anclas = ''.join(f'\\hypertarget{{{e}}}{{}}' for e in re.findall(r'\\label\{([^}]+)\}', m.group(1)))
        return anclas + re.sub(r'\\label\{([^}]+)\}', etiqueta, m.group(1))
    # Solo las etiquetas dentro de fórmulas; las de figuras y apartados las usa pandoc
    cuerpo = re.sub(r'(\\begin\{(equation|align|gather|multline)\*?\}.*?\\end\{\2\*?\})',
                    formula, cuerpo, flags=re.S)
    cuerpo = numerar_anexos(cuerpo)
    # Tablas: pandoc no entiende \multirow, \newline, \cellcolor ni \rowcolor y
    # pierde lo que va en {\footnotesize …}. Se dejan como marcas de color
    # (\textcolor{tcee…}) que tcee.lua convierte en celdas combinadas, saltos de
    # línea y fondos.
    # \multirow[c]{n}[bigstruts]{ancho}[desplazamiento]{texto}: solo cuenta n
    cuerpo = re.sub(r'\\multirow(?:\[[^\]]*\])?\{(\d+)\}(?:\[[^\]]*\])?\{[^}]*\}(?:\[[^\]]*\])?\{',
                    r'\\textcolor{tceefilas\1}{', cuerpo)
    # Columnas centradas (>{\centering\arraybackslash}m{…} o p{…}): pandoc las lee
    # como alineadas a la izquierda; como «c» salen centradas (y tcee.lua las
    # centra también en vertical)
    cuerpo = re.sub(r'>\{\\centering(?:\\arraybackslash)?\}[mpb]\{[^{}]*\}', 'c', cuerpo)
    # Con columnas «c», pandoc deja el argumento de \cline como texto («1-2»): las
    # rayas parciales no hacen falta en la web ni en Word
    cuerpo = re.sub(r'\\cline\{[^}]*\}', '', cuerpo)
    cuerpo = re.sub(r'\\hhline\{[^}]*\}', '', cuerpo)
    cuerpo = re.sub(r'\\newline\b\s*', r'\\textcolor{tceesalto}{.}', cuerpo)
    cuerpo = re.sub(r'\\cellcolor\{(\w+)\}', r'\\textcolor{tceefondo\1}{.}', cuerpo)
    cuerpo = re.sub(r'\\rowcolor\{(\w+)\}', r'\\textcolor{tceefilafondo\1}{.}', cuerpo)
    cuerpo = re.sub(r'\{\\(?:footnotesize|scriptsize|small)\s+', r'\\textcolor{tceenota}{', cuerpo)
    # Dentro de \text{…} de una fórmula, \autor{} y \textsc{} rompen la conversión
    # de la ecuación en Word: se dejan como texto normal
    patron_text = re.compile(r'(\\text\{[^{}]*)\\(?:autor|textsc)\{([^{}]*)\}')
    while patron_text.search(cuerpo):
        cuerpo = patron_text.sub(r'\1\2', cuerpo)
    # Los saltos de página del PDF pasan a Word (tcee.lua los convierte; en HTML se quitan)
    cuerpo = re.sub(r'\\(?:clearpage|newpage|pagebreak)\b', r'\\begin{saltopagina}\\mbox{}\\end{saltopagina}', cuerpo)
    destino = os.path.join(tema.trabajo, f'{tema.archivo}-pandoc-{formato}.tex')
    with open(destino, 'w', encoding='utf-8') as f:
        f.write(macros + '\n' + cuerpo)
    return destino


def comunes_pandoc(tema, datos):
    # citeproc va antes del filtro para que tcee.lua vea ya la bibliografía (salto de página en Word)
    orden = ['-f', 'latex', '--figure-caption-position=above'] + (['--citeproc', '--csl', ruta_windows(os.path.join(LATEX, 'tcee.csl'))] if os.path.exists(tema.bib) else []) + [
             '--lua-filter', ruta_windows(os.path.join(LATEX, 'tcee.lua')),
             '-M', 'lang=es-ES', '-M', f'codigo={tema.codigo}', '-M', f'etiqueta={tema.etiqueta}',
             '-M', f'titulo={datos["titulo"]}',
             '-M', f'fecha={datos["fecha"]}', '-M', f'archivo={tema.archivo}',
             '-M', f'carpeta={tema.carpeta}', '-M', f'ejercicio={tema.nombre_ejercicio}']
    if tema.es_dictamen:
        orden += ['-M', 'dictamen=true']
    if es_exclusivo(tema):
        # Aviso de uso personal en vez de la licencia CC (plantilla-tema.html).
        orden += ['-M', 'exclusivo=true', '-M', f'condiciones-url={CONDICIONES_URL}']
    try:
        dia = datetime.datetime.strptime(datos['fecha'], '%d/%m/%Y').date()
    except ValueError:
        dia = datetime.date.today()
    orden += ['-M', f'fecha-iso={dia.isoformat()}', '-M', f'fecha-cita={dia:%Y/%m/%d}', '-M', f'anio={dia.year}',
              '-M', f'titulo-cita={datos["titulo"].rstrip(". ")}']   # para Google Académico, sin el punto final
    # Fecha de publicación estable para los buscadores (Víctor, 19/10/2026): la de la
    # aprobación del tema (estado.json); la de modificación es la de \tcefecha
    aprobado = (tema.estado().get('aprobado') or {}).get('tema')
    try:
        publicada = datetime.date.fromisoformat(str(aprobado)[:10]) if aprobado else None
    except ValueError:
        publicada = None
    if publicada and publicada <= dia:
        orden += ['-M', f'fecha-publicada={publicada.isoformat()}', '-M', f'fecha-publicada-cita={publicada:%Y/%m/%d}']
    paginas = linea_paginas(paginas_partes(os.path.join(tema.trabajo, f'{tema.archivo}.aux')),
                            'Guía' if tema.es_dictamen else 'Tema')
    if paginas:
        orden += ['-M', f'paginas={paginas}']
    for campo, valor in datos_seo(tema).items():
        orden += ['-M', f'{campo.replace("_", "-")}={valor}']
    if os.path.exists(tema.bib):
        orden += ['--bibliography', ruta_windows(tema.bib),
                  '-M', 'link-citations=true', '-M', 'reference-section-title=Bibliografía']
    return orden


def generar_html(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.html')
    corto = re.split(r'[.:]', datos['titulo'])[0].strip()
    # --wrap=none: si pandoc parte una línea dentro de \text{…}, MathJax se come el espacio
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'html5', '-s', '--mathjax', '--wrap=none',
             '--template', ruta_windows(os.path.join(LATEX, 'plantilla-tema.html')),
             # Un solo h1 en la página (el título del tema): los apartados empiezan en h2
             '--shift-heading-level-by=1', '--toc', '--toc-depth=3', '--section-divs',
             '-M', f'graficos-html=../fuentes/{tema.archivo}/graficos',
             '-M', f'titulo-corto={corto}', '-o', ruta_windows(destino)]
    orden += comunes_pandoc(tema, datos)
    if datos['duracion']:
        orden += ['-M', f'duracion={datos["duracion_texto"]}']
    video = video_de(tema)
    if video:
        orden += ['-M', f'video={video}']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf')):
        orden += ['-M', 'repaso=true']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-anterior.pdf')):
        orden += ['-M', 'anterior=true']
    if os.path.exists(os.path.join(tema.dir_publico, f'{tema.archivo}-anterior.docx')):
        orden += ['-M', 'anterior-docx=true']
    ejecutar(orden, timeout=600)
    partir_urls_html(destino)
    enlaces_app_html(destino, tema)
    return destino


def enlaces_app_html(ruta, tema):
    """data-app en cada enlace de \\vertema: a dónde lleva dentro de la app,
    que abre la página desde jsDelivr (ver el script de plantilla-tema.html):
    el PDF del tema en la rama si es un tema revisado o disponible (ruta
    relativa) y, si no, la página de tema no disponible de la web."""
    destinos = destinos_temas(tema.carpeta)
    with open(ruta, encoding='utf-8') as f:
        html = f.read()

    def poner(m):
        d = destinos.get(primer_tema(m.group(2)))
        if not d:
            return m.group(0)
        if d['revisado']:
            app = re.sub(r'\.html$', '.pdf', d['html'])
        elif d['disponible']:
            app = d['html']
        else:
            app = d['pdf']
        return m.group(0).replace('<a ', f'<a data-app="{app}" ', 1)
    html = re.sub(r'(<a href="[^"]*" class="vertema">)\s*<span class="vertema"[^>]*>(?:\[ver tema )?([^\]<]*?)\]?</span>\s*</a>',
                  poner, html)
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(html)


def partir_urls_html(ruta):
    """Deja partir las URL que se ven en el texto (cita, bibliografía, notas):
    <wbr> tras / . - _ ? = & para que no abran huecos en el texto justificado."""
    with open(ruta, encoding='utf-8') as f:
        html = f.read()
    trozos = re.split(r'(<[^>]+>)', html)
    saltar = 0  # dentro de <head>, <script>, <style> o <title>
    for i, t in enumerate(trozos):
        if t.startswith('<'):
            m = re.match(r'<(/?)(head|script|style|title)\b', t, re.I)
            if m:
                saltar += -1 if m.group(1) else 1
            continue
        if saltar or 'http' not in t:
            continue
        trozos[i] = re.sub(r'(https?://)([^\s<]+)', lambda u: u.group(1) + re.sub(r'(&amp;|[/.\-_?=])(?=.)', r'\1<wbr>', u.group(2)), t)
    with open(ruta, 'w', encoding='utf-8') as f:
        f.write(''.join(trozos))


def generar_docx(tema, tex_pandoc, datos):
    destino = os.path.join(tema.trabajo, f'{tema.archivo}.docx')
    orden = [PANDOC, ruta_windows(tex_pandoc), '-t', 'docx',
             '--reference-doc', ruta_windows(os.path.join(LATEX, 'reference.docx')),
             '-M', f'graficos-docx={ruta_windows(tema.graficos)}',
             '-M', 'title=' + (datos['titulo'] if tema.es_dictamen else f'{tema.codigo}: {datos["titulo"]}'),
             '-M', 'author=Víctor Gutiérrez Marcos',
             '-M', f'date=Última actualización: {datos["fecha"]}',
             # Licencia en las propiedades del documento (Comentarios y personalizadas)
             '-M', f'description={licencia_larga(anio_de(datos), es_exclusivo(tema))}',
             '-M', f'Licencia={licencia_corta(anio_de(datos), es_exclusivo(tema))}',
             '-M', f'URL de la licencia={LICENCIA_URL_LEGAL}',
             '--resource-path', ruta_windows(tema.dir), '-o', ruta_windows(destino)]
    orden += comunes_pandoc(tema, datos)
    ejecutar(orden, timeout=600)
    centrar_celdas_docx(destino)
    retocar_docx(destino, anio_de(datos), es_exclusivo(tema))
    return destino


def anio_de(datos):
    """Año de la última actualización (\\tcefecha); el de hoy si no se entiende."""
    try:
        return datetime.datetime.strptime(datos['fecha'], '%d/%m/%Y').year
    except ValueError:
        return datetime.date.today().year


def centrar_celdas_docx(ruta):
    """En las tablas con alguna celda centrada (columnas >{\\centering}m{…} del
    LaTeX), centra todas las celdas también en vertical (w:vAlign), como en el
    PDF: pandoc no lo escribe."""
    import zipfile
    with zipfile.ZipFile(ruta) as z:
        partes = {n: z.read(n) for n in z.namelist()}
        infos = {i.filename: i for i in z.infolist()}
    xml = partes['word/document.xml'].decode('utf-8')

    def tabla(m):
        t = m.group(0)
        if '<w:jc w:val="center"' not in t:
            return t
        t = t.replace('<w:tcPr />', '<w:tcPr><w:vAlign w:val="center" /></w:tcPr>')
        return re.sub(r'<w:tcPr>((?:(?!</w:tcPr>).)*?)</w:tcPr>',
                      lambda c: c.group(0) if 'w:vAlign' in c.group(1)
                      else f'<w:tcPr>{c.group(1)}<w:vAlign w:val="center" /></w:tcPr>', t, flags=re.S)
    nuevo = re.sub(r'<w:tbl>.*?</w:tbl>', tabla, xml, flags=re.S)
    if nuevo == xml:
        return
    partes['word/document.xml'] = nuevo.encode('utf-8')
    with zipfile.ZipFile(ruta, 'w', zipfile.ZIP_DEFLATED) as z:
        for nombre, datos in partes.items():
            z.writestr(infos[nombre], datos)


def _partes_docx(ruta):
    import zipfile
    with zipfile.ZipFile(ruta) as z:
        return {n: z.read(n) for n in z.namelist()}, {i.filename: i for i in z.infolist()}


def _guardar_docx(ruta, partes, infos):
    import zipfile
    with zipfile.ZipFile(ruta, 'w', zipfile.ZIP_DEFLATED) as z:
        for nombre, datos in partes.items():
            if nombre in infos:
                z.writestr(infos[nombre], datos)
            else:
                z.writestr(nombre, datos)


_PARRAFO = re.compile(r'<w:p(?: [^>]*)?>.*?</w:p>|<w:p(?: [^>]*)?/>', re.S)


def conservar_listas_docx(xml):
    """«Conservar con el siguiente» (w:keepNext) en cada párrafo seguido de otro
    de nivel más profundo: una viñeta seguida de una subviñeta y un párrafo
    normal seguido de una lista, como el beginpenalty=10000 de tcee.sty. Solo
    en el cuerpo (no dentro de tablas ni notas)."""
    cuerpo_ini = xml.find('<w:body>')
    trozos = re.split(r'(<w:tbl>.*?</w:tbl>)', xml[cuerpo_ini:], flags=re.S)
    salida = [xml[:cuerpo_ini]]
    for t, trozo in enumerate(trozos):
        if t % 2:            # tabla
            salida.append(trozo)
            continue
        parrafos = list(_PARRAFO.finditer(trozo))

        def nivel(p):
            m = re.search(r'<w:ilvl w:val="(\d+)"', p)
            if m:
                return int(m.group(1))
            estilo = re.search(r'<w:pStyle w:val="([^"]+)"', p)
            if estilo and estilo.group(1) not in ('BodyText', 'FirstParagraph', 'Compact', 'Normal'):
                return None      # títulos, cajas, figuras…: no cuentan
            return -1            # párrafo normal
        niveles = [nivel(p.group(0)) for p in parrafos]
        nuevo, pos = '', 0
        for k, p in enumerate(parrafos):
            texto = p.group(0)
            sig = niveles[k + 1] if k + 1 < len(parrafos) else None
            # Solo si los dos párrafos son seguidos (nada entre medias)
            seguidos = k + 1 < len(parrafos) and not trozo[p.end():parrafos[k + 1].start()].strip()
            if (niveles[k] is not None and sig is not None and seguidos and sig > niveles[k]
                    and '<w:keepNext' not in texto):
                if '<w:pPr>' in texto:
                    texto = re.sub(r'<w:pPr>((?:<w:pStyle [^>]*/>)?)', r'<w:pPr>\1<w:keepNext />', texto, count=1)
                elif '<w:pPr />' in texto:
                    texto = texto.replace('<w:pPr />', '<w:pPr><w:keepNext /></w:pPr>', 1)
                else:
                    texto = re.sub(r'^(<w:p(?: [^>]*)?>)', r'\1<w:pPr><w:keepNext /></w:pPr>', texto, count=1)
            nuevo += trozo[pos:p.start()] + texto
            pos = p.end()
        salida.append(nuevo + trozo[pos:])
    return ''.join(salida)


def numerar_paginas_docx(partes):
    """Secciones de Word como las partes del PDF: el tema en 1…N, los anexos en
    A-1… y la bibliografía en B-1…, cada una con «página/páginas de la
    sección» al pie. tcee.lua deja una marca @@TCEE-SECCION:A@@ donde empieza
    cada parte; aquí cada marca pasa a ser un salto de sección."""
    xml = partes['word/document.xml'].decode('utf-8')
    marcas = list(re.finditer(r'<w:p>(?:(?!</w:p>).)*?@@TCEE-SECCION:([A-Z])@@(?:(?!</w:p>).)*?</w:p>', xml, re.S))
    i = xml.rfind('<w:sectPr')
    final = re.match(r'<w:sectPr>(.*?)</w:sectPr>', xml[i:], re.S)
    pie = re.search(r'<w:footerReference r:id="([^"]+)" w:type="default"\s*/>', final.group(1)) if final else None
    rels = partes['word/_rels/document.xml.rels'].decode('utf-8')
    destino_pie = re.search(rf'<Relationship[^>]*Id="{pie.group(1)}"[^>]*/>', rels) if pie else None
    if not (final and pie and destino_pie):
        return
    nombre_pie = 'word/' + re.search(r'Target="([^"]+)"', destino_pie.group(0)).group(1)
    pie_xml = partes[nombre_pie].decode('utf-8').replace(' NUMPAGES ', ' SECTIONPAGES ')
    partes[nombre_pie] = pie_xml.encode('utf-8')
    tipos = partes['[Content_Types].xml'].decode('utf-8')

    def pie_con_letra(letra):
        nombre = f'footerTcee{letra}.xml'
        if f'word/{nombre}' not in partes:
            m = re.search(r'<w:r>(<w:rPr>(?:(?!</w:rPr>).)*</w:rPr>)<w:fldChar w:fldCharType="begin"', pie_xml, re.S)
            rpr = m.group(1) if m else ''
            texto = re.sub(r'(<w:r>' + re.escape(rpr) + r'<w:fldChar w:fldCharType="begin"\s*/><w:instrText[^>]*> PAGE )',
                           f'<w:r>{rpr}<w:t>{letra}-</w:t></w:r>' + r'\1', pie_xml, count=1)
            partes[f'word/{nombre}'] = texto.encode('utf-8')
        return nombre

    def seccion(rid):
        interior = re.sub(r'<w:footerReference r:id="[^"]+" w:type="default"\s*/>',
                          f'<w:footerReference r:id="{rid}" w:type="default" />', final.group(1))
        interior = interior.replace('w:val="eachSect"', 'w:val="continuous"')
        interior = re.sub(r'<w:pgNumType[^>]*/>', '', interior)
        interior = re.sub(r'(<w:pgMar [^>]*/>)', r'\1<w:pgNumType w:start="1" />', interior, count=1)
        return f'<w:sectPr>{interior}</w:sectPr>'

    rid_actual = pie.group(1)
    nuevo, pos = '', 0
    for m in marcas:
        letra = m.group(1)
        nombre = pie_con_letra(letra)
        rid = f'rIdTcee{letra}'
        if rid not in rels:
            rels = rels.replace('</Relationships>', f'<Relationship Id="{rid}" Target="{nombre}" Type="http://schemas.'
                                'openxmlformats.org/officeDocument/2006/relationships/footer" /></Relationships>')
            tipos = tipos.replace('</Types>', f'<Override PartName="/word/{nombre}" ContentType="application/vnd.'
                                  'openxmlformats-officedocument.wordprocessingml.footer+xml" /></Types>')
        # Párrafo mínimo que cierra la sección anterior
        cierre = ('<w:p><w:pPr><w:spacing w:before="0" w:after="0" w:line="20" w:lineRule="exact" />'
                  f'{seccion(rid_actual)}</w:pPr></w:p>')
        nuevo += xml[pos:m.start()] + cierre
        pos = m.end()
        rid_actual = rid
    resto = xml[pos:]
    j = resto.rfind('<w:sectPr')
    resto = resto[:j] + re.sub(r'<w:sectPr>.*?</w:sectPr>', lambda _: seccion(rid_actual), resto[j:], count=1, flags=re.S)
    partes['word/document.xml'] = (nuevo + resto).encode('utf-8')
    partes['word/_rels/document.xml.rels'] = rels.encode('utf-8')
    partes['[Content_Types].xml'] = tipos.encode('utf-8')


FUENTE_DOCX, FUENTE_DOCX_RESERVA = 'TeX Gyre Pagella', 'Palatino Linotype'


def fuente_reserva_docx(partes):
    """La fuente del Word es TeX Gyre Pagella (la del PDF y la web); en la tabla de
    fuentes se declara Palatino Linotype como sustituta (altName), que es la que
    usa Word cuando Pagella no está instalada (Víctor, 19/10/2026)."""
    nombre = 'word/fontTable.xml'
    xml = partes.get(nombre, b'').decode('utf-8')
    if not xml or f'w:name="{FUENTE_DOCX}"' in xml and 'w:altName' in xml.split(f'w:name="{FUENTE_DOCX}"', 1)[1][:200]:
        return
    entrada = (f'<w:font w:name="{FUENTE_DOCX}"><w:altName w:val="{FUENTE_DOCX_RESERVA}"/>'
               '<w:panose1 w:val="02040502050505030304"/><w:charset w:val="00"/><w:family w:val="roman"/>'
               '<w:pitch w:val="variable"/></w:font>')
    xml = re.sub(rf'<w:font w:name="{re.escape(FUENTE_DOCX)}">.*?</w:font>', '', xml, flags=re.S)
    xml = xml.replace('</w:fonts>', entrada + '</w:fonts>')
    partes[nombre] = xml.encode('utf-8')


def retocar_docx(ruta, anio, exclusivo=False):
    """Postproceso del Word: listas que no se separan de lo que las introduce,
    cajas y filas de tabla que no se parten entre páginas, fondo de celda
    entero, numeración de páginas por partes, licencia en el pie y fuente de
    reserva."""
    partes, infos = _partes_docx(ruta)
    fuente_reserva_docx(partes)
    partes['word/document.xml'] = conservar_listas_docx(partes['word/document.xml'].decode('utf-8')).encode('utf-8')
    cajas_docx(partes)
    filas_docx(partes)
    cajas_enteras_docx(partes)
    sin_huecos_docx(partes)
    numerar_paginas_docx(partes)
    licencia_pie_docx(partes, anio, exclusivo)
    if exclusivo:
        aviso_portada_docx(partes)
    imagenes_notas_docx(partes)
    _guardar_docx(ruta, partes, infos)


def cajas_docx(partes):
    """Gráficos y tablas dentro de una caja (figuracaja, tablacaja): tcee.lua
    deja marcas <!--tcee-caja-ini:Estilo--> … <!--tcee-caja-fin--> alrededor;
    a sus párrafos (título, imagen, fuente) se les pone el borde y el fondo del
    estilo de la caja, para que Word los una a ella, y a las tablas, el fondo."""
    xml = partes['word/document.xml'].decode('utf-8')
    if '<!--tcee-caja-ini:' not in xml:
        return
    estilos = partes['word/styles.xml'].decode('utf-8')
    previos = r'(?:<w:(?:pStyle|keepNext|keepLines|pageBreakBefore|framePr|widowControl|numPr)\b(?:[^<]|<(?!/w:pPr>))*?(?:/>|</w:(?:framePr|numPr)>))*'

    def formato(estilo):
        m = re.search(rf'w:styleId="{estilo}"[^>]*>(.*?)</w:style>', estilos, re.S)
        bdr = re.search(r'<w:pBdr>.*?</w:pBdr>', m.group(1), re.S) if m else None
        shd = re.search(r'<w:shd [^>]*/>', m.group(1)) if m else None
        return (bdr.group(0) if bdr else '') + (shd.group(0) if shd else ''), shd.group(0) if shd else ''

    def parrafo(p, extra):
        p = re.sub(r'<w:pBdr>.*?</w:pBdr>|<w:shd [^>]*/>(?=(?:(?!<w:r[ >]).)*</w:pPr>)', '', p, flags=re.S)
        if '<w:pPr>' in p:
            return re.sub(r'(<w:pPr>' + previos + ')', lambda m: m.group(1) + extra, p, count=1, flags=re.S)
        return re.sub(r'^<w:p( [^>]*)?>', lambda m: m.group(0) + f'<w:pPr>{extra}</w:pPr>', p, count=1)

    def zona(m):
        extra, shd = formato(m.group(1))
        cuerpo = m.group(2)
        # Párrafos fuera de las tablas: borde y fondo; tablas: fondo
        trozos = re.split(r'(<w:tbl>.*?</w:tbl>)', cuerpo, flags=re.S)
        for i, t in enumerate(trozos):
            if t.startswith('<w:tbl>'):
                tblpr = re.search(r'<w:tblPr>.*?</w:tblPr>', t, re.S)
                if shd and tblpr and '<w:shd' not in tblpr.group(0):
                    # En tblPr, shd va antes de tblLayout, tblCellMar y tblLook
                    nuevo = re.sub(r'(?=<w:(?:tblLayout|tblCellMar|tblLook|tblCaption|tblDescription)\b)|(?=</w:tblPr>)',
                                   lambda _: shd, tblpr.group(0), count=1)
                    t = t.replace(tblpr.group(0), nuevo, 1)
                if shd:
                    # Word no siempre pinta el fondo de la tabla: también en cada celda sin fondo propio
                    def celda(m):
                        tcpr = m.group(0)
                        if '<w:shd' in tcpr:
                            return tcpr
                        return re.sub(r'(?=<w:(?:noWrap|tcMar|textDirection|tcFitText|vAlign|hideMark)\b)|(?=</w:tcPr>)',
                                      lambda _: shd, tcpr, count=1)
                    t = re.sub(r'<w:tcPr>.*?</w:tcPr>', celda, t, flags=re.S)
                    t = re.sub(r'<w:tc>(?!<w:tcPr>)', lambda _: f'<w:tc><w:tcPr>{shd}</w:tcPr>', t)
                trozos[i] = t
            else:
                # (los párrafos vacíos, <w:p />, se dejan como están)
                trozos[i] = re.sub(r'<w:p\s*/>|<w:p(?: [^>]*[^/>])?>.*?</w:p>',
                                   lambda p: p.group(0) if p.group(0).endswith('/>') and '</w:p>' not in p.group(0)
                                   else parrafo(p.group(0), extra), t, flags=re.S)
        return ''.join(trozos)

    xml = re.sub(r'<!--tcee-caja-ini:(\w+)-->(.*?)<!--tcee-caja-fin-->', zona, xml, flags=re.S)
    partes['word/document.xml'] = xml.encode('utf-8')


def filas_docx(partes):
    """Ninguna fila de tabla se parte entre páginas (w:cantSplit), y las celdas
    con fondo (estilos «Celda tcee…» de tcee.lua, \\cellcolor y \\rowcolor del
    LaTeX) llevan el fondo en la celda (w:shd en tcPr), no solo detrás del
    texto del párrafo."""
    xml = partes['word/document.xml'].decode('utf-8')
    estilos = partes['word/styles.xml'].decode('utf-8')
    fondos = {m.group(1): m.group(2) for m in re.finditer(
        r'<w:style [^>]*w:styleId="(Celda\w+)"[^>]*>(?:(?!</w:style>).)*?<w:shd [^>]*w:fill="([0-9A-Fa-f]{6})"', estilos, re.S)}
    xml = re.sub(r'<w:tr>(?!<w:trPr>)', '<w:tr><w:trPr><w:cantSplit /></w:trPr>', xml)
    xml = re.sub(r'<w:trPr>(?!<w:cantSplit)', '<w:trPr><w:cantSplit />', xml)
    xml = cabecera_con_tabla_docx(xml)

    def celda(m):
        tc = m.group(0)
        estilo = re.search(r'<w:pStyle w:val="(Celda\w+)"', tc)
        if not estilo or estilo.group(1) not in fondos:
            return tc
        shd = f'<w:shd w:val="clear" w:color="auto" w:fill="{fondos[estilo.group(1)]}" />'
        if not tc.startswith('<w:tc><w:tcPr>'):
            return tc.replace('<w:tc>', f'<w:tc><w:tcPr>{shd}</w:tcPr>', 1)
        tcpr = re.match(r'<w:tc><w:tcPr>(.*?)</w:tcPr>', tc, re.S)
        if '<w:shd' in tcpr.group(1):
            return tc
        # En tcPr, shd va antes de noWrap, tcMar, textDirection, tcFitText, vAlign y hideMark
        interior = re.sub(r'(?=<w:(?:noWrap|tcMar|textDirection|tcFitText|vAlign|hideMark)\b)|$',
                          lambda _: shd, tcpr.group(1), count=1)
        return f'<w:tc><w:tcPr>{interior}</w:tcPr>' + tc[tcpr.end():]
    # Solo las celdas más internas (sin otra tabla dentro)
    xml = re.sub(r'<w:tc>(?:(?!</?w:tc>).)*</w:tc>', celda, xml, flags=re.S)
    partes['word/document.xml'] = xml.encode('utf-8')


def cabecera_con_tabla_docx(xml):
    """La fila de cabecera de una tabla no se queda sola al pie de la página: sus
    párrafos llevan «conservar con el siguiente» (w:keepNext), que en Word la une
    a la primera fila del cuerpo. Es cabecera la fila marcada w:tblHeader o, si
    la tabla no tiene ninguna, la primera fila si va entera sombreada (\\rowcolor,
    estilos «Celda …»). El título de la tabla ya va unido a la cabecera (keepNext
    del estilo Table Caption): título, cabecera y primera fila van juntos."""
    def parrafo(p):
        t = p.group(0)
        if '<w:keepNext' in t:
            return t
        if '<w:pPr>' in t:
            return re.sub(r'<w:pPr>((?:<w:pStyle [^>]*/>)?)', r'<w:pPr>\1<w:keepNext />', t, count=1)
        if '<w:pPr />' in t:
            return t.replace('<w:pPr />', '<w:pPr><w:keepNext /></w:pPr>', 1)
        return re.sub(r'^(<w:p(?: [^>]*)?>)', r'\1<w:pPr><w:keepNext /></w:pPr>', t, count=1)

    def sombreada(tr):
        celdas = re.findall(r'<w:tc>.*?</w:tc>', tr, re.S)
        llenas = [c for c in celdas if re.search(r'<w:t[ >]', c)]      # una celda vacía no cuenta
        return bool(llenas) and all('<w:pStyle w:val="Celda' in c for c in llenas)

    def tabla(m):
        t = m.group(0)
        filas = list(re.finditer(r'<w:tr>.*?</w:tr>', t, re.S))
        if len(filas) < 2:
            return t
        cabecera = [f for f in filas if '<w:tblHeader' in f.group(0)]
        if not cabecera and sombreada(filas[0].group(0)):
            cabecera = [filas[0]]
        nuevo, pos = '', 0
        for f in cabecera:
            nuevo += t[pos:f.start()] + _PARRAFO.sub(parrafo, f.group(0))
            pos = f.end()
        return nuevo + t[pos:]
    # Solo las tablas más internas (sin otra tabla dentro)
    return re.sub(r'<w:tbl>(?:(?!<w:tbl>).)*?</w:tbl>', tabla, xml, flags=re.S)


ESTILOS_CAJA_DOCX = ('Esquema', 'Notaalopositor', 'Cajadeanotaciones', 'Ideaclave', 'Funcionclave')
LINEAS_CAJA_ENTERA = 40     # una página de Word tiene unas 48 líneas de texto


def _lineas_parrafo(p):
    texto = ''.join(re.findall(r'<(?:w|m):t(?: [^>]*)?>([^<]*)</(?:w|m):t>', p))
    return 1 + len(texto) // 90 + p.count('<w:br />') + p.count('<w:br/>')


def cajas_enteras_docx(partes):
    """Las cajas (esquema, nota al opositor, anotaciones, idea clave, función
    clave) no se parten entre páginas: sus párrafos llevan «conservar líneas
    juntas» (w:keepLines) y, salvo el último, «conservar con el siguiente»
    (w:keepNext). Una caja más larga que una página (más de LINEAS_CAJA_ENTERA
    líneas, a ojo) se deja partir: entera, dejaría la página anterior medio vacía."""
    xml = partes['word/document.xml'].decode('utf-8')
    ini = xml.find('<w:body>')
    trozos = re.split(r'(<w:tbl>.*?</w:tbl>)', xml[ini:], flags=re.S)
    salida = [xml[:ini]]

    def estilo(p):
        m = re.search(r'<w:pStyle w:val="([^"]+)"', p)
        return m.group(1) if m and m.group(1) in ESTILOS_CAJA_DOCX else None

    def guardar(p, siguiente):
        marcas = '<w:keepNext /><w:keepLines />' if siguiente else '<w:keepLines />'
        p = re.sub(r'<w:keep(?:Next|Lines)\s*/>', '', p)
        # Tras pStyle (primero en pPr)
        return re.sub(r'(<w:pPr>(?:<w:pStyle [^>]*/>)?)', lambda m: m.group(1) + marcas, p, count=1)

    for t, trozo in enumerate(trozos):
        if t % 2:
            salida.append(trozo)
            continue
        parrafos = list(_PARRAFO.finditer(trozo))
        grupos, actual = [], []
        for k, p in enumerate(parrafos):
            e = estilo(p.group(0))
            seguido = actual and not re.sub(r'<w:bookmark(?:Start|End) [^>]*/>', '',
                                            trozo[parrafos[k - 1].end():p.start()]).strip()
            if e and actual and seguido and estilo(parrafos[actual[-1]].group(0)) == e:
                actual.append(k)
            else:
                if actual:
                    grupos.append(actual)
                actual = [k] if e else []
        if actual:
            grupos.append(actual)
        cambios = {}
        for g in grupos:
            if sum(_lineas_parrafo(parrafos[k].group(0)) for k in g) > LINEAS_CAJA_ENTERA:
                continue
            for n, k in enumerate(g):
                cambios[k] = guardar(parrafos[k].group(0), n < len(g) - 1)
        nuevo, pos = '', 0
        for k, p in enumerate(parrafos):
            if k in cambios:
                nuevo += trozo[pos:p.start()] + cambios[k]
                pos = p.end()
        salida.append(nuevo + trozo[pos:])
    partes['word/document.xml'] = ''.join(salida).encode('utf-8')


def sin_huecos_docx(partes):
    """Los párrafos justificados con saltos de línea manuales (\\\\ del LaTeX) no
    estiran la línea que acaba en el salto (w:doNotExpandShiftReturn), como en
    el PDF."""
    nombre = 'word/settings.xml'
    xml = partes.get(nombre, b'').decode('utf-8')
    if not xml or 'doNotExpandShiftReturn' in xml:
        return
    if '<w:compat>' in xml:
        xml = xml.replace('<w:compat>', '<w:compat><w:doNotExpandShiftReturn />', 1)
    elif '<w:compat />' in xml:
        xml = xml.replace('<w:compat />', '<w:compat><w:doNotExpandShiftReturn /></w:compat>', 1)
    else:
        # En settings, compat va antes de docVars, rsids, mathPr, themeFontLang…
        xml = re.sub(r'(?=<(?:w:docVars|w:rsids|m:mathPr|w:attachedSchema|w:themeFontLang|w:clrSchemeMapping|'
                     r'w:doNotIncludeSubdocsInStats|w:doNotAutoCompressPictures|w:forceUpgrade|w:captions|'
                     r'w:readModeInkLockDown|w:smartTagType|w:shapeDefaults|w:doNotEmbedSmartTags|'
                     r'w:decimalSymbol|w:listSeparator)\b)|(?=</w:settings>)',
                     lambda _: '<w:compat><w:doNotExpandShiftReturn /></w:compat>', xml, count=1)
    partes[nombre] = xml.encode('utf-8')


def licencia_pie_docx(partes, anio, exclusivo=False):
    """«© 2026 Víctor Gutiérrez Marcos · CC BY-NC-ND 4.0» a la izquierda del pie,
    pequeño y en gris, en la misma línea que el número de página (que sigue a la
    derecha con un tabulador alineado al margen). Va en todos los pies (los de
    cada parte que crea numerar_paginas_docx incluidos)."""
    xml = partes['word/document.xml'].decode('utf-8')
    tam = re.search(r'<w:pgSz [^>]*w:w="(\d+)"', xml)
    izq = re.search(r'<w:pgMar [^>]*w:left="(\d+)"', xml)
    der = re.search(r'<w:pgMar [^>]*w:right="(\d+)"', xml)
    ancho = int(tam.group(1)) - int(izq.group(1)) - int(der.group(1)) if tam and izq and der else 9412
    texto = licencia_corta(anio, exclusivo)
    run = ('<w:r><w:rPr><w:i /><w:color w:val="767171" /><w:sz w:val="14" /></w:rPr>'
           f'<w:t xml:space="preserve">{texto}</w:t></w:r><w:r><w:tab /></w:r>')
    for nombre in [n for n in partes if re.fullmatch(r'word/footer[^/]*\.xml', n)]:
        pie = partes[nombre].decode('utf-8')
        if texto in pie or ' PAGE ' not in pie:
            continue
        ppr = (f'<w:pPr><w:pStyle w:val="Footer" /><w:tabs><w:tab w:val="right" w:pos="{ancho}" /></w:tabs>'
               '<w:jc w:val="left" /></w:pPr>')
        pie, n = re.subn(r'<w:p>\s*<w:pPr>(?:(?!</w:pPr>).)*</w:pPr>', lambda _: f'<w:p>{ppr}{run}', pie, count=1, flags=re.S)
        if n:
            partes[nombre] = pie.encode('utf-8')


def aviso_portada_docx(partes):
    """En los exclusivos, el aviso de uso personal como primer párrafo del Word
    (pequeño, en gris, en cursiva), debajo del título que pone pandoc."""
    xml = partes['word/document.xml'].decode('utf-8')
    if AVISO_EXCLUSIVO[:40] in xml:
        return
    parrafo = ('<w:p><w:pPr><w:spacing w:before="0" w:after="200" /></w:pPr>'
               '<w:r><w:rPr><w:b /><w:smallCaps /><w:color w:val="5F2987" /><w:sz w:val="16" /></w:rPr><w:t xml:space="preserve">Exclusivo · uso personal. </w:t></w:r>'
               '<w:r><w:rPr><w:i /><w:color w:val="767171" /><w:sz w:val="16" /></w:rPr>'
               f'<w:t xml:space="preserve">{AVISO_EXCLUSIVO} Condiciones: {CONDICIONES_URL}</w:t></w:r></w:p>')
    # Tras el primer párrafo del cuerpo (el título o la primera línea), si lo hay.
    i = xml.find('<w:body>')
    j = xml.find('</w:p>', i)
    if i < 0 or j < 0:
        return
    partes['word/document.xml'] = (xml[:j + 6] + parrafo + xml[j + 6:]).encode('utf-8')


def imagenes_notas_docx(partes):
    """pandoc deja la relación de las imágenes de las notas al pie
    (\\graficonota) en document.xml.rels y Word no las encuentra: se copian a
    footnotes.xml.rels."""
    notas = partes.get('word/footnotes.xml', b'').decode('utf-8')
    nombre_rels = 'word/_rels/footnotes.xml.rels'
    rels_notas = partes.get(nombre_rels, b'').decode('utf-8')
    rels_doc = partes['word/_rels/document.xml.rels'].decode('utf-8')
    if not rels_notas:
        rels_notas = ('<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/'
                      'package/2006/relationships"></Relationships>')
    cambiado = False
    for rid in set(re.findall(r'r:embed="([^"]+)"', notas)):
        if f'Id="{rid}"' in rels_notas:
            continue
        rel = re.search(rf'<Relationship [^>]*Id="{rid}"[^>]*/>', rels_doc)
        if rel:
            rels_notas = rels_notas.replace('</Relationships>', rel.group(0) + '</Relationships>')
            cambiado = True
    if cambiado:
        partes[nombre_rels] = rels_notas.encode('utf-8')


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--solo', choices=['pdf', 'html', 'docx', 'graficos'])
    ap.add_argument('--forzar-graficos', action='store_true')
    ap.add_argument('--grafico', action='append',
                    help='compila solo ese gráfico (nombre sin .tex; se puede repetir). '
                         'Para que varios agentes TikZ trabajen a la vez sin pisarse')
    ap.add_argument('--no-publicar', action='store_true',
                    help='deja los resultados en _trabajo/ sin copiarlos a la carpeta pública')
    args = ap.parse_args()
    tema = Tema(args.tema)
    guardar_pdf_anterior(tema)
    guardar_docx_anterior(tema)

    errores = compilar_graficos(tema, forzar=args.forzar_graficos or bool(args.grafico), solo=args.grafico)
    if errores:
        print('ERRORES EN LOS GRÁFICOS:\n' + '\n\n'.join(errores))
        sys.exit(1)
    print('Gráficos compilados.')
    if args.solo == 'graficos' or args.grafico:
        return

    escribir_destinos_tex()     # destinos de \vertema para tcee.sty
    tex = exportar_latex(tema)
    datos = datos_documento(tex)
    resultados = {}
    if args.solo in (None, 'pdf'):
        pdf, avisos = compilar_pdf(tema, tex)
        resultados['pdf'] = pdf
        for a in avisos:
            print('AVISO LaTeX:', a)
        partes = paginas_partes(os.path.join(tema.trabajo, f'{tema.archivo}.aux'))
        print('PDF:', pdf, f'({fitz.open(pdf).page_count} páginas en total)')
        if partes:
            print(f'Páginas del tema: {partes.get("tema", "?")} (anexos: {partes.get("anexos", 0)}; '
                  f'bibliografía: {partes.get("bib", 0)})')
    if args.solo in (None, 'html', 'docx'):
        if args.solo in (None, 'html'):
            resultados['html'] = generar_html(tema, preparar_pandoc(tema, tex, 'html'), datos)
            print('HTML:', resultados['html'])
        if args.solo in (None, 'docx'):
            resultados['docx'] = generar_docx(tema, preparar_pandoc(tema, tex, 'docx'), datos)
            print('Word:', resultados['docx'])

    if not args.no_publicar:
        os.makedirs(tema.dir_publico, exist_ok=True)
        for ext, ruta in resultados.items():
            destino = os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}')
            shutil.copyfile(ruta, destino)
            print('Publicado en la rama:', os.path.relpath(destino, TEMARIO))
    if datos['duracion'] and not tema.es_dictamen:
        print(f'Duración del cante según \\minutos: {datos["duracion"]} min')
        if datos['duracion'] != '30':
            print('AVISO: los \\minutos no suman 30 (CRITERIOS §2)')


if __name__ == '__main__':
    main()
