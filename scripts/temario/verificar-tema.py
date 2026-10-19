#!/usr/bin/env python3
"""
Comprueba que un tema revisado está listo para que lo lea Víctor
(último paso de /revisartema, lo usa el agente tema-control-calidad).

    python3 scripts/temario/verificar-tema.py 3A08 [--json]

Errores (el tema no está terminado):
  - quedan marcas ⟦…⟧ de la extracción, «Fuente: …» vacías o notas de trabajo
    (TODO, PENDIENTE, XXX) en la fuente;
  - alguna figura no tiene \\fuente{…};
  - faltan el PDF, el HTML o el Word, o son más antiguos que la fuente;
  - el PDF tiene referencias o citas sin definir;
  - el HTML tiene LaTeX sin convertir o imágenes que no existen;
  - el Word no se abre;
  - una remisión no es un enlace (Víctor, 18/10/2026): «[ver tema» escrito a
    mano sin \\vertema, un \\vertema a un tema que no existe, una remisión a un
    apartado, anexo, gráfico, tabla o ecuación escrita a mano sin \\ref (o
    \\hyperref en la ficha), un «[ver tema …]» del PDF o de la ficha sin enlace
    encima, o un enlace interno del HTML o del Word sin destino;
  - falta revision.md o alguna de sus secciones (el guion y las escenas del
    vídeo son de la entrega 3: solo avisa);
  - los \\minutos no suman 30, o la introducción y la conclusión no duran lo
    que dice CRITERIOS §2 (2′–2′30″ y 1′–1′30″); minutos con decimales en el
    texto («2,5 minutos» en vez de \\tiempo{2,5});
  - un bloque i), ii)… con \\paragraph en vez de \\subparagraph; la bibliografía
    antes de los anexos;
  - «se ha visto en el tema…» (cada tema se canta solo), nombres de
    preparadores (referencias.json) o enlaces a quia.com;
  - la ficha de repaso no tiene cuatro páginas o es anterior a su fuente;
  - un título queda al pie de una página del PDF, o una fórmula destacada
    separada de la frase que la presenta.

Avisos (para que los mire el control de calidad):
  - párrafos con cifras (%, millones, años recientes) sin cita en ese párrafo;
  - apellidos de la bibliografía escritos sin \\autor{}; demostraciones sin
    \\findemo; letras a), b)… que no van seguidas; más o menos de tres apartados;
  - palabras del guion y de la narración del vídeo lejos de ≈4.700; pasos del
    vídeo sin narración, con más de dos pausas o con un apoyo que no existe;
  - números de tema dichos en voz alta.
Y comprueba los criterios del cante: sin saludo al tribunal, conclusión que
empieza por «En conclusión» y sin gracias al final.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, paginas_partes, destinos_temas, primer_tema  # noqa: E402

PALABRAS_POR_MINUTO = 158  # borrador de generar-video.py (≈2,75 palabras/s) con las pausas
SECCIONES_INFORME = ['Resumen', 'Errores corregidos', 'Marcas resueltas', 'Datos actualizados',
                     'Contenido añadido', 'Coherencia', 'Dudas abiertas']
SECCIONES_INFORME_OPCIONALES = ['Instrucciones para el vídeo']   # CRITERIOS §9.8 (desde el 19/10/2026): solo avisa


def leer(ruta):
    return open(ruta, encoding='utf-8', errors='replace').read() if os.path.exists(ruta) else None


def parrafos_tex(tex):
    cuerpo = tex.split('\\begin{document}', 1)[-1]
    return [p for p in re.split(r'\n\s*\n|\\item\b', cuerpo) if p.strip()]


# --- Remisiones (CRITERIOS §6: toda remisión es un enlace) ---------------------------
ROMANOS = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII']


def _fin_argumento(t, i):
    """t[i] == '{': posición tras la llave que lo cierra."""
    nivel, j = 0, i
    while j < len(t):
        if t[j] == '\\':
            j += 2
            continue
        nivel += (t[j] == '{') - (t[j] == '}')
        if nivel == 0:
            return j + 1
        j += 1
    return len(t)


def numeros_apartados(tex, ficha=False):
    """Números de los apartados del tema (I, I.2, II.1.3; A, B.2 en los anexos)
    o, en la ficha, de sus \\bloque y \\sub (que llevan el número a mano)."""
    if ficha:
        return set(re.findall(r'\\(?:bloque|sub)(?:\[[^\]]*\])?\{([IVX]{1,4}(?:\.\d+)*)\.\s', tex))
    numeros, sec, sub, subsub, anexos = set(), 0, 0, 0, False
    for m in re.finditer(r'\\appendix\b|^\\(section|subsection|subsubsection)(\*?)\{', tex, re.M):
        if m.group(0) == '\\appendix':
            anexos, sec = True, 0
            continue
        if m.group(2):
            continue
        if m.group(1) == 'section':
            sec, sub, subsub = sec + 1, 0, 0
        elif m.group(1) == 'subsection':
            sub, subsub = sub + 1, 0
        else:
            subsub += 1
        if sec == 0 or sec > len(ROMANOS):
            continue
        n = chr(64 + sec) if anexos else ROMANOS[sec - 1]
        numeros.add(n if m.group(1) == 'section' else f'{n}.{sub}' if m.group(1) == 'subsection'
                    else f'{n}.{sub}.{subsub}')
    return numeros


def remisiones_a_mano(tex, ficha=False):
    """Remisiones escritas a mano, sin \\ref ni \\hyperref: [(línea, texto)].

    Heurística (probada en los temas revisados, sin falsos positivos): números
    de apartado del propio tema (I.2, II.1.3) o de sus anexos (B.3); bloques sin
    punto (I, II, III) tras «bloque», «apartado», «de», «en», «desde», «hasta»,
    «y» o «(»; «anexo B»; «gráfico 4», «tabla 2», «figura 3», «ecuación (5)».
    No cuentan los comentarios, las fórmulas en display, los títulos de los apartados, lo
    que ya va en \\ref, \\hyperref, \\label… ni las listas de tiempos del cante
    («I.1, \\tiempo{3}»)."""
    numeros = numeros_apartados(tex, ficha)
    zonas = [(m.start(), m.end()) for m in re.finditer(r'(?<!\\)%[^\n]*', tex)]
    zonas += [(m.start(), m.end()) for m in re.finditer(
        r'\\(?:label|ref|eqref|autoref|cref|Cref|nameref|hyperref|hypertarget|vertema|\w*cite\w*|href|url'
        r'|sub|bloque|subcante|apartadocante|caption|grafico|graficorepaso|includegraphics)\*?(?:\[[^\]]*\])?\{[^}]*\}', tex)]
    zonas += [(m.start(), _fin_argumento(tex, m.end() - 1))
              for m in re.finditer(r'^\\(?:sub)*section\*?\{', tex, re.M)]
    # Fórmulas en display (las $…$ no se excluyen: un $ dentro de \text{} las desempareja)
    zonas += [(m.start(), m.end()) for m in re.finditer(r'\\begin\{(equation|align|gather|multline)\*?\}.*?\\end\{\1\*?\}'
                                                        r'|\$\$.*?\$\$|(?<!\\)\\\[.*?\\\]', tex, re.S)]
    # El título del tema («Teoría de la demanda del consumidor (I)»): \\tcetema y la portada
    zonas += [(m.start(), m.end()) for m in re.finditer(r'^.*(?:\\tcetema|\\textbf\{\d\.[AB]\.\d).*$', tex, re.M)]

    def libre(p):
        return not any(a <= p < b for a, b in zonas)

    def tiempos(fin):
        return re.match(r',?\s*\\tiempo|[^;()]{0,15},\s*\\tiempo', tex[fin:])
    halladas = []
    patrones = [
        (r'(?<![\w.\\{:/§«-])([IVX]{1,4}(?:\.\d+){1,3}|[A-H]\.\d+)(?![\w}]|\.\d)', True),
        (r'(?:(?<=[Bb]loque)|(?<=[Bb]loques)|(?<=[Aa]partado)|(?<=[Aa]partados)|(?<=\bde)|(?<=\bdel)|(?<=\ben)'
         r'|(?<=\bdesde)|(?<=\bhasta)|(?<=\by))[ ~]([IVX]{1,3})(?=[\s,.;:)~]|$)(?!\.\d)(?!\+)', True),
        (r'(?<=\()([IVX]{1,3})(?=[\s,.;:)~]|$)(?!\.\d)(?!\+)', True),
        (r'\b[Aa]nexos?[~ ]+([A-H])\b(?![.\w])', False),
        (r'\b(?:[Gg]r[áa]ficos?|[Tt]ablas?|[Ff]iguras?)[~ ]+(\d{1,2})(?![.\d\w])', False),
        (r'\b[Ee]cuaci[óo]n(?:es)?[~ ]*\((\d{1,3})\)', False),
    ]
    for patron, de_apartado in patrones:
        for m in re.finditer(patron, tex):
            if not libre(m.start(1)) or tiempos(m.end(1)):
                continue
            if de_apartado and m.group(1) not in numeros:
                continue
            linea = tex.count('\n', 0, m.start()) + 1
            halladas.append((linea, tex[max(0, m.start() - 30):m.end() + 10].replace('\n', ' ')))
    return sorted(set(halladas))


def comprobar_remisiones(tema, tex, errores, datos):
    """Fuente, PDF, ficha, HTML y Word: cada remisión es un enlace."""
    destinos = destinos_temas(tema.carpeta)
    fuentes = [(f'{tema.archivo}.tex', tex, False)]
    ruta_ficha = os.path.join(tema.dir, 'repaso', f'{tema.archivo}-repaso.tex')
    if os.path.exists(ruta_ficha):
        fuentes.append((f'{tema.archivo}-repaso.tex', leer(ruta_ficha), True))
    for nombre, texto, ficha in fuentes:
        sin_coment = re.sub(r'(?<!\\)%[^\n]*', '', texto)
        for m in re.finditer(r'\[ver tema', sin_coment):
            errores.append(f'«[ver tema» escrito a mano en {nombre}:{sin_coment.count(chr(10), 0, m.start()) + 1}: '
                           'usar \\vertema{…}')
        for arg in re.findall(r'\\vertema\{([^{}]*)\}', sin_coment):
            if primer_tema(arg) not in destinos:
                errores.append(f'\\vertema{{{arg}}} en {nombre}: no es un tema de temario.json (no se puede enlazar)')
        for linea, texto_m in remisiones_a_mano(texto, ficha):
            orden = '\\hyperref[rep:…]{…}' if ficha else '\\ref{…}'
            errores.append(f'Remisión escrita a mano en {nombre}:{linea} (usar {orden}): «{texto_m.strip()}»')
    datos['remisiones_a_temas'] = len(re.findall(r'\\vertema\{', re.sub(r'(?<!\\)%[^\n]*', '', tex)))
    datos['remisiones_internas'] = len(re.findall(r'\\(?:ref|eqref|autoref|hyperref)\b', re.sub(r'(?<!\\)%[^\n]*', '', tex)))
    try:
        import fitz
    except ImportError:
        return
    # PDF: cada «[ver tema …]» con un enlace encima; ficha: cada «[3.A.12]»
    for ruta, patron in ((os.path.join(tema.dir_publico, f'{tema.archivo}.pdf'), r'\[ver tema'),
                         (os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf'), r'\[\d\.[A-C]\.\d')):
        if not os.path.exists(ruta):
            continue
        sin_enlace = 0
        for n, pag in enumerate(fitz.open(ruta), 1):
            enlaces = [fitz.Rect(l['from']) for l in pag.get_links() if l.get('uri')]
            palabras = pag.get_text('words')
            for i, w in enumerate(palabras):
                if not re.match(patron, w[4] + (' ' + palabras[i + 1][4] if i + 1 < len(palabras) else '')):
                    continue
                r = fitz.Rect(w[:4])
                if not any(e.intersects(r) for e in enlaces):
                    sin_enlace += 1
                    if sin_enlace <= 5:
                        errores.append(f'{os.path.basename(ruta)}, página {n}: «{w[4]}…» sin enlace al tema')
        if sin_enlace > 5:
            errores.append(f'{os.path.basename(ruta)}: {sin_enlace} remisiones a temas sin enlace en total')
    # HTML: los \\vertema enlazados y todos los enlaces internos con destino
    html = leer(os.path.join(tema.dir_publico, f'{tema.archivo}.html'))
    if html:
        spans = html.count('<span class="vertema"')
        enlazados = len(re.findall(r'<a [^>]*class="vertema"[^>]*>\s*<span class="vertema"', html))
        if enlazados != spans:
            errores.append(f'HTML: {spans - enlazados} de {spans} remisiones a temas sin enlace')
        ids = set(re.findall(r'\sid="([^"]+)"', html))
        rotos = sorted({h for h in re.findall(r'href="#([^"]+)"', html) if h not in ids})
        if rotos:
            errores.append(f'HTML: {len(rotos)} enlaces internos sin destino: {", ".join(rotos[:8])}')
    # Word: enlaces internos con su marcador y cada «[ver tema» dentro de un hipervínculo
    docx = os.path.join(tema.dir_publico, f'{tema.archivo}.docx')
    if os.path.exists(docx):
        import zipfile
        with zipfile.ZipFile(docx) as z:
            xml = ''.join(z.read(n).decode('utf-8') for n in ('word/document.xml', 'word/footnotes.xml')
                          if n in z.namelist())
        marcadores = set(re.findall(r'<w:bookmarkStart [^>]*w:name="([^"]+)"', xml))
        rotos = sorted({a for a in re.findall(r'<w:hyperlink [^>]*w:anchor="([^"]+)"', xml) if a not in marcadores})
        if rotos:
            errores.append(f'Word: {len(rotos)} enlaces internos sin marcador: {", ".join(rotos[:8])}')
        total = len(re.findall(r'\[ver tema', xml))
        dentro = sum(h.count('[ver tema') for h in re.findall(r'<w:hyperlink [^>]*r:id=[^>]*>.*?</w:hyperlink>', xml, re.S))
        if dentro != total:
            errores.append(f'Word: {total - dentro} de {total} remisiones a temas sin hipervínculo')


def comprobar_formulas_separadas(tex, errores):
    """Una fórmula destacada no puede separarse de lo que la presenta (Víctor,
    19/10/2026): ni tras una línea en blanco ni tras el cierre de una lista
    cuando la línea anterior no acaba en punto (va dentro de la viñeta)."""
    lineas = tex.split('\n')
    for i, l in enumerate(lineas):
        if re.match(r'\s*(\\funcionclave|\\begin\{(equation|align|gather|multline|eqnarray)|\\\[|\$\$)', l):
            j, blanco = i - 1, False
            while j >= 0 and not lineas[j].strip():
                blanco, j = True, j - 1
            previa = re.sub(r'(?<!\\)%.*$', '', lineas[j]).rstrip() if j >= 0 else ''
            if (blanco or re.match(r'\s*\\end\{(itemize|enumerate)\}', previa)) and not previa.endswith('.'):
                errores.append(f'Fórmula separada de lo que la presenta (l. {i + 1} del .tex): '
                               'va dentro de la viñeta o del párrafo, sin línea en blanco')


def apellidos_bib(ruta_bib):
    """Apellidos de los autores del .bib (los de «Apellido, Nombre»; no las
    instituciones entre llaves), para avisar de los que salen sin \\autor{}."""
    texto = leer(ruta_bib) or ''
    apellidos = set()
    for campo in re.findall(r'\b(?:author|editor)\s*=\s*\{((?:[^{}]|\{[^{}]*\})*)\}', texto, re.I):
        for persona in re.split(r'\s+and\s+', campo):
            if persona.strip().startswith('{') or ',' not in persona:
                continue
            apellido = re.sub(r'\{|\}|\\[a-zA-Z]+', '', persona.split(',')[0]).strip()
            # «de la Fuente» → «Fuente»; partículas fuera
            apellido = re.sub(r'^(?:de|del|la|las|los|van|von|der|di|da)\s+', '', apellido, flags=re.I)
            if len(apellido) >= 4 and apellido[0].isupper() and not apellido.isupper() and ' ' not in apellido:
                apellidos.add(apellido)
    return apellidos


def comprobar_criterios(tema, tex, errores, avisos, datos):
    """Reglas de CRITERIOS.md (§2 y §6) que se pueden comprobar en la fuente."""
    sin = re.sub(r'(?<!\\)%[^\n]*', '', tex)
    cuerpo = sin.split('\\begin{document}', 1)[-1]
    antes_anexos = cuerpo.split('\\appendix', 1)[0]

    def linea(pos):
        return cuerpo.count('\n', 0, pos) + 1 + sin.split('\\begin{document}', 1)[0].count('\n')

    # --- Minutos (§2): suman 30; introducción 2′–2′30″; conclusión 1′–1′30″
    def minutos_tras(titulo):
        m = re.search(r'\\section\*\{' + titulo + r'\}\s*(?:\\label\{[^}]*\}\s*)?\\minutos\{([\d.,]+)\}', cuerpo)
        return float(m.group(1).replace(',', '.')) if m else None
    todos = [float(x.replace(',', '.')) for x in re.findall(r'\\minutos\{(\d+(?:[.,]\d+)?)\}', cuerpo)]
    if todos:
        datos['minutos'] = round(sum(todos), 2)
        if abs(sum(todos) - 30) > 1e-6:
            errores.append(f'Los \\minutos suman {sum(todos):g}, no 30')
    for titulo, lo, hi, nombre in (('Introducción', 2, 2.5, 'La introducción'), ('Conclusión', 1, 1.5, 'La conclusión')):
        mins = minutos_tras(titulo)
        if mins is None:
            avisos.append(f'{nombre} no lleva \\minutos justo tras \\section*{{{titulo}}}')
        elif not lo <= mins <= hi:
            errores.append(f'{nombre} dura {mins:g} min: debe durar entre {lo:g}′ y {hi:g}′ (CRITERIOS §2)')
    # Minutos con decimales en el texto («2,5 minutos», «2,5′»): siempre \tiempo{2,5}
    for m in re.finditer(r'(?<![\d,.])\d+[,.]5\s*(?:min(?:utos?)?\b|′|\\prime)', cuerpo):
        errores.append(f'Minutos con decimales en el texto (l. {linea(m.start())}): «{m.group(0)}» → \\tiempo{{…}}')
    # --- Tres apartados (§2)
    n = len(re.findall(r'^\\section\{', antes_anexos, re.M))
    datos['apartados'] = n
    if n and n != 3:
        avisos.append(f'{n} apartados de primer nivel (CRITERIOS §2: tres siempre que se pueda)')
    # --- Final del documento (§2): \clearpage antes de \appendix; bibliografía tras los anexos
    if '\\appendix' in cuerpo and not re.search(r'\\clearpage\s*\\appendix', cuerpo):
        avisos.append('Falta \\clearpage justo antes de \\appendix')
    if '\\appendix' in cuerpo and '\\bibliografia' in cuerpo and cuerpo.index('\\bibliografia') < cuerpo.index('\\appendix'):
        errores.append('La bibliografía (\\bibliografia) va antes que los anexos: tiene que ir al final')
    # --- Estructura de los modelos (§2): a), b)… seguidas con \paragraph; i), ii)… con \subparagraph
    # (aviso, no error: temas aprobados antes del 19/10/2026 los tienen al revés o un nivel más abajo)
    nivel_i = [linea(m.start()) for m in re.finditer(r'^\\paragraph\{[ivx]+\)', cuerpo, re.M)]
    if nivel_i:
        avisos.append(f'{len(nivel_i)} bloques i), ii), iii) con \\paragraph (l. {", ".join(map(str, nivel_i[:6]))}…): '
                      'CRITERIOS §2 los pide con \\subparagraph')
    nivel_a = [linea(m.start()) for m in re.finditer(r'^\\subparagraph\{[a-h]\)', cuerpo, re.M)]
    if nivel_a:
        avisos.append(f'{len(nivel_a)} bloques a), b), c) con \\subparagraph (l. {", ".join(map(str, nivel_a[:6]))}…): '
                      'CRITERIOS §2 los pide con \\paragraph')
    for trozo in re.split(r'^\\(?:sub)*section\*?\{', cuerpo, flags=re.M):
        letras = re.findall(r'^\\paragraph\{([a-h])\)', trozo, re.M)
        tanda = []
        for le in letras + ['a']:
            if le == 'a' and tanda:
                if tanda != [chr(97 + k) for k in range(len(tanda))]:
                    avisos.append('Letras de los bloques de un modelo no seguidas: ' + ', '.join(f'{x})' for x in tanda)
                           + ' (CRITERIOS §2: a, b, c… sin huecos)')
                tanda = []
            tanda.append(le)
    # --- Demostraciones con \findemo (§2)
    for m in re.finditer(r'\\(?:emph|textbf|textit|concepto|paragraph|subparagraph)\{Demostraci[óo]n', cuerpo):
        resto = cuerpo[m.end():]
        fin = re.search(r'\\(?:sub)*section\*?\{|\\(?:sub)?paragraph\{|\\end\{(?:anotaciones|document)\}', resto)
        if '\\findemo' not in resto[:fin.start() if fin else len(resto)]:
            avisos.append(f'Demostración sin \\findemo al final (l. {linea(m.start())})')
    # --- Cada tema se canta solo (§2): nunca «se ha visto en el tema…»
    for m in re.finditer(r'(?:visto|vista|vistos|estudiado|estudiada|estudiados|desarrollado|desarrollada|analizado|'
                         r'analizada|explicado|explicada|tratado|tratada)\s+(?:ya\s+)?en\s+(?:el|los)\s+temas?\b', cuerpo, re.I):
        errores.append(f'«{m.group(0)}» (l. {linea(m.start())}): cada tema se canta solo; se remite con \\vertema sin decir que se vio en otro tema')
    # --- Sin nombres de preparadores (§2) ni enlaces a quia.com
    ruta_ref = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'referencias.json')
    if os.path.exists(ruta_ref):
        try:
            autores = json.load(open(ruta_ref, encoding='utf-8')).get('autores', [])
        except ValueError:
            autores = []
        # Se busca el apellido por el que se les conoce (la «clave» de referencias.json:
        # Tebar, Cerezal, Cordero, Cabado…), no el nombre de pila ni apellidos
        # corrientes («Fuentes», «García»)
        for a in autores:
            clave = str(a.get('clave', '')).strip()
            apellido = clave.capitalize()
            if len(apellido) < 4 or apellido in ('Fuentes', 'Garcia', 'García') or apellido.lower() not in a.get('nombre', '').lower():
                continue
            m = re.search(r'\b' + re.escape(apellido) + r'\b', cuerpo)
            if m:
                errores.append(f'Nombre de preparador en el tema («{apellido}», l. {linea(m.start())}): CRITERIOS §2, solo en revision.md')
    for m in re.finditer(r'quia\.com', cuerpo):
        errores.append(f'Enlace a quia.com (l. {linea(m.start())}): solo el enlace genérico al simulador')
    # --- Apellidos sin \autor{} (§2; aviso, por los falsos positivos)
    apellidos = apellidos_bib(tema.bib)
    if apellidos:
        texto = re.sub(r'\\(?:autor|textsc|\w*cites?|label|ref|eqref|hyperref|href|url|vertema|includegraphics|grafico\w*|'
                       r'addbibresource|tcetema|bibliografia)\*?(?:\[[^\]]*\])?\{(?:[^{}]|\{[^{}]*\})*\}', ' ', cuerpo)
        texto = re.sub(r'\\begin\{(figure|figuracaja|table|tablacaja)\}.*?\\end\{\1\}', ' ', texto, flags=re.S)
        sueltos = []
        for ap in sorted(apellidos):
            n = len(re.findall(r'(?<![\w{\-])' + re.escape(ap) + r'(?![\w}\-])', texto))
            if n:
                sueltos.append(f'{ap} ({n})')
        if sueltos:
            avisos.append('Apellidos sin \\autor{}: ' + ', '.join(sueltos[:12]) + (' …' if len(sueltos) > 12 else ''))
        datos['apellidos_sin_autor'] = len(sueltos)


def verificar(tema):
    errores, avisos, datos = [], [], {}
    tex_ruta = os.path.join(tema.dir, f'{tema.archivo}.tex')
    tex = leer(tex_ruta)
    if tex is None:
        return [f'No existe la fuente {tema.archivo}.tex'], avisos, datos
    if not os.path.exists(tema.lyx):
        avisos.append(f'No existe {tema.archivo}.lyx (¿está instalado LyX?)')

    # --- Fuente ---------------------------------------------------------------
    for patron, texto in ((r'⟦[^⟧]*⟧', 'marca de la extracción'), (r'\b(TODO|PENDIENTE|XXX|FIXME)\b', 'nota de trabajo'),
                          (r'\\fuente\{\s*(…|\.\.\.)?\s*\}', '«Fuente» vacía')):
        for m in re.finditer(patron, tex):
            linea = tex.count('\n', 0, m.start()) + 1
            errores.append(f'{texto} en {tema.archivo}.tex:{linea}: {m.group(0)[:60]}')
    figuras = [f[1] for f in re.findall(r'\\begin\{(figure|figuracaja)\}(.*?)\\end\{\1\}', tex, re.S)]
    for i, fig in enumerate(figuras, 1):
        if '\\fuente{' not in fig:
            cap = re.search(r'\\caption\{([^}]*)', fig)
            errores.append(f'Figura {i} sin \\fuente: {cap.group(1)[:60] if cap else ""}')
    datos['figuras'] = len(figuras)
    comprobar_remisiones(tema, tex, errores, datos)
    comprobar_formulas_separadas(tex, errores)
    comprobar_criterios(tema, tex, errores, avisos, datos)
    datos['citas'] = len(re.findall(r'\\(?:foot|auto|text|paren)?cites?\b', tex))
    datos['notas_al_pie'] = len(re.findall(r'\\footnote\b', tex)) + len(re.findall(r'\\footcite\b', tex))
    graficos_usados = set(re.findall(r'\\(?:grafico|graficonota|includegraphics)(?:\[[^\]]*\])?\{([^}]+)\}', tex))
    for g in graficos_usados:
        base = os.path.join(tema.graficos, os.path.splitext(g)[0])
        if not any(os.path.exists(base + ext) for ext in ('.tex', '.png', '.jpg', '.jpeg', '.pdf', '.svg')):
            errores.append(f'Gráfico inexistente: {g}')
    datos['graficos_tikz'] = len([f for f in os.listdir(tema.graficos) if f.endswith('.tex')]) \
        if os.path.isdir(tema.graficos) else 0

    # Cifras sin cita en el mismo párrafo
    sin_cita = 0
    for p in parrafos_tex(tex):
        texto = re.sub(r'\$[^$]*\$|\\\[.*?\\\]', '', p, flags=re.S)
        if re.search(r'\d+(?:[.,]\d+)?\s*(?:\\?%|por ciento|millones|mill\.|billones|€|puntos)|\b20[12]\d\b', texto) \
                and not re.search(r'\\(?:foot|auto|text|paren)?cite|\\footnote|\\fuente', p):
            sin_cita += 1
            if sin_cita <= 15:
                avisos.append('Cifra sin cita: ' + re.sub(r'\s+', ' ', texto.strip())[:140])
    datos['parrafos_con_cifras_sin_cita'] = sin_cita

    # --- Resultados ---------------------------------------------------------------
    mtime_fuente = max(os.path.getmtime(tex_ruta), os.path.getmtime(tema.lyx) if os.path.exists(tema.lyx) else 0)
    for ext in ('pdf', 'html', 'docx'):
        ruta = os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}')
        if not os.path.exists(ruta):
            errores.append(f'Falta {tema.carpeta}/{tema.archivo}.{ext} (ejecutar construir-tema.py)')
        elif os.path.getmtime(ruta) + 1 < mtime_fuente:
            errores.append(f'{tema.archivo}.{ext} es anterior a la fuente: volver a construir')
    log = leer(os.path.join(tema.trabajo, f'{tema.archivo}.log'))
    if log:
        for m in set(re.findall(r'(?:Reference|Citation) [`\']([^\']+)\' on page \d+ undefined', log)):
            errores.append(f'Referencia o cita sin definir en el PDF: {m}')
        datos['avisos_overfull'] = len(re.findall(r'Overfull \\hbox \((\d{2,})', log))
    # Páginas de cada parte (las escribe tcee.sty en el .aux): tema 1…N, anexos A-n, bibliografía B-n
    partes = paginas_partes(os.path.join(tema.trabajo, f'{tema.archivo}.aux'))
    if partes:
        datos['paginas_tema'] = partes.get('tema')
        datos['paginas_anexos'] = partes.get('anexos', 0)
        datos['paginas_bibliografia'] = partes.get('bib', 0)
    pdf = os.path.join(tema.dir_publico, f'{tema.archivo}.pdf')
    if os.path.exists(pdf):
        try:
            import fitz
            doc = fitz.open(pdf)
            datos['paginas_total'] = doc.page_count
            # Ningún título puede ser lo último de una página (ni seguido de otro
            # título: CRITERIOS.md); se mira la última línea de texto de cada una.
            # Es título si empieza por un número de apartado o una letra de bloque,
            # o si va en morado (bandas, I.1, a) Idea, i) Supuestos…) en negrita o
            # cursiva y es corta y sin punto final (los \paragraph sin letra).
            titulo = re.compile(r'([IVX]+\.(?:\d+\.)*\s|[A-H]\.(?:\d+\.)*\s|[a-h]\)\s|[ivx]+\)\s|'
                                r'(?:INTRODUCCIÓN|CONCLUSIÓN|ANEXO)\b)')
            morados = {0x5F2987, 0x4A1F6B, 0xFFFFFF}
            for n, pag in enumerate(doc, 1):
                alto = pag.rect.height
                lineas = sorted(
                    ((l['bbox'][3], ''.join(s['text'] for s in l['spans']).strip(), l['spans'][0])
                     for b in pag.get_text('dict')['blocks'] for l in b.get('lines', [])
                     if 60 < l['bbox'][1] and l['bbox'][3] < alto - 60 and l['spans']),
                    key=lambda x: x[0])
                lineas = [(t, s) for _, t, s in lineas if t]
                if not lineas:
                    continue
                texto, span = lineas[-1]
                destacado = span['color'] in morados and (span['flags'] & 2 or span['flags'] & 16)
                if titulo.match(texto) or (destacado and len(texto) < 90 and not texto.endswith('.')):
                    errores.append(f'Título al pie de la página {n} del PDF: «{texto[:60]}»')
        except Exception as e:
            avisos.append(f'No se pudo comprobar si hay títulos al pie del PDF: {e}')
    # Ficha de repaso: lo mismo al pie de cada columna (CRITERIOS.md, ficha):
    # ni el título de un bloque (texto blanco sobre morado), ni un \sub (morado
    # en negrita, salvo los años de la cronología), ni una línea que anuncia con
    # «:» lo que va en la columna siguiente.
    repaso = os.path.join(tema.dir_publico, f'{tema.archivo}-repaso.pdf')
    if os.path.exists(repaso):
        try:
            import fitz
            for n, pag in enumerate(fitz.open(repaso), 1):
                ancho, alto = pag.rect.width, pag.rect.height
                lineas = []
                for b in pag.get_text('dict')['blocks']:
                    for l in b.get('lines', []):
                        # sin las viñetas (■, –, ◦), que son moradas
                        sp = [s for s in l['spans'] if s['text'].strip().strip('■–◦•')]
                        if sp and l['bbox'][3] < alto - 30:
                            lineas.append((l['bbox'], ''.join(s['text'] for s in sp).strip(), sp[0]))
                for c, (x0, x1) in enumerate([(0, ancho / 2), (ancho / 2, ancho)], 1):
                    col = [x for x in lineas if x0 <= (x[0][0] + x[0][2]) / 2 < x1]
                    if not col:
                        continue
                    caja, texto, s = max(col, key=lambda x: x[0][3])
                    negrita = 'Bold' in s['font'] or s['flags'] & 16
                    if (s['color'] == 0xFFFFFF or (s['color'] == 0x5F2987 and negrita and not re.match(r'\d{3,4}\b', texto))
                            or (texto.endswith(':') and caja[2] - caja[0] < 0.8 * (x1 - x0))):
                        errores.append(f'Ficha de repaso: título o «:» al pie de la columna {c} de la página {n}: «{texto[:60]}»')
        except Exception as e:
            avisos.append(f'No se pudo comprobar la ficha de repaso: {e}')
        # Exactamente cuatro páginas (CRITERIOS § 8 bis) y más reciente que su fuente
        try:
            import fitz
            n_pags = fitz.open(repaso).page_count
            datos['paginas_repaso'] = n_pags
            if n_pags != 4:
                errores.append(f'La ficha de repaso tiene {n_pags} páginas, no 4 (construir-repaso.py)')
        except Exception as e:
            avisos.append(f'No se pudo abrir la ficha de repaso: {e}')
        fuente_repaso = os.path.join(tema.dir, 'repaso', f'{tema.archivo}-repaso.tex')
        if os.path.exists(fuente_repaso) and os.path.getmtime(repaso) + 1 < os.path.getmtime(fuente_repaso):
            errores.append(f'{tema.archivo}-repaso.pdf es anterior a su fuente: volver a construir la ficha')
    html = leer(os.path.join(tema.dir_publico, f'{tema.archivo}.html'))
    if html:
        sin_math = re.sub(r'\\\(.*?\\\)|\\\[.*?\\\]', '', html, flags=re.S)
        for m in set(re.findall(r'\\(?:textbf|emph|textit|begin|end|cite|footcite|ref|label|capa|fuente)\b', sin_math)):
            errores.append(f'LaTeX sin convertir en el HTML: {m}')
        for src in re.findall(r'<img[^>]+src="([^"]+)"', html):
            if not src.startswith('http') and not os.path.exists(os.path.normpath(os.path.join(tema.dir_publico, src))):
                errores.append(f'Imagen inexistente en el HTML: {src}')
    docx = os.path.join(tema.dir_publico, f'{tema.archivo}.docx')
    if os.path.exists(docx):
        try:
            from docx import Document
            d = Document(docx)
            datos['docx_imagenes'] = len(d.inline_shapes)
            for p in d.paragraphs:
                if re.search(r'\\[a-zA-Z]{2,}\{|\$\$', p.text):
                    errores.append(f'LaTeX sin convertir en el Word: {p.text[:80]}')
        except Exception as e:
            errores.append(f'El Word no se abre: {e}')

    # --- Informe, guion y vídeo -------------------------------------------------------
    informe = leer(os.path.join(tema.dir, 'revision.md'))
    if informe is None:
        errores.append('Falta revision.md (informe de revisión)')
    else:
        posiciones = []
        for s in SECCIONES_INFORME:
            m = re.search(rf'^#+\s*(?:\d+\.\s*)?{re.escape(s)}', informe, re.M | re.I)
            if not m:
                errores.append(f'revision.md sin la sección «{s}»')
            else:
                posiciones.append(m.start())
        if posiciones != sorted(posiciones):
            avisos.append('Las secciones de revision.md no van en el orden de CRITERIOS §9')
        for s in SECCIONES_INFORME_OPCIONALES:
            if not re.search(rf'^#+\s*(?:\d+\.\s*)?{re.escape(s)}', informe, re.M | re.I):
                avisos.append(f'revision.md sin la sección «{s}» (CRITERIOS §9; la usa el guionista)')
    # Buscadores: seo.json (CRITERIOS §9 bis). Solo avisos: la página sale igual sin él
    seo = leer(os.path.join(tema.dir, 'seo.json'))
    if seo is None:
        avisos.append('Falta seo.json (título para buscadores, resumen, palabras clave y materia)')
    else:
        try:
            seo = json.loads(seo)
        except ValueError as e:
            errores.append(f'seo.json no es JSON válido: {e}')
            seo = {}
        for campo in ('titulo_seo', 'resumen', 'palabras_clave', 'materia'):
            if not seo.get(campo):
                avisos.append(f'seo.json sin «{campo}»')
        if len(seo.get('resumen', '')) > 160:
            avisos.append(f'El resumen de seo.json tiene {len(seo["resumen"])} caracteres (máximo 160)')
        if re.search(r'\bTECOs?\b', seo.get('titulo_seo', '') + ' ' + seo.get('resumen', '')):
            avisos.append('seo.json: «TECO» no puede salir en el título ni en el resumen')
    guion = leer(os.path.join(tema.dir, 'guion-cante.md'))
    if guion is None:
        avisos.append('Aún no hay guion-cante.md (entrega 3, --fase video)')
    else:
        # Solo lo que se dice: fuera títulos, el esquema de pizarra y las notas [Pizarra: …]
        hablado = re.sub(r'^## (?:Esquema|Plan) de pizarra.*?(?=^## )', '', guion, flags=re.M | re.S)
        hablado = re.sub(r'^```.*?^```', '', hablado, flags=re.M | re.S)
        hablado = re.sub(r'\[[^\]\n]*\]|^#.*$|^>.*$|\|.*\|', '', hablado, flags=re.M)
        palabras = len(re.findall(r'\w+', hablado))
        datos['guion_palabras'] = palabras
        datos['guion_minutos_estimados'] = round(palabras / PALABRAS_POR_MINUTO, 1)
        if not 28 <= palabras / PALABRAS_POR_MINUTO <= 32:
            avisos.append(f'El guion da {palabras / PALABRAS_POR_MINUTO:.1f} min a {PALABRAS_POR_MINUTO} palabras/min')
    escenas = leer(os.path.join(tema.dir, 'video', 'escenas.yaml'))
    if escenas is None:
        avisos.append('Aún no hay video/escenas.yaml (entrega 3, --fase video)')
    else:
        import yaml
        try:
            g = yaml.safe_load(escenas)
            escs = g['escenas']
            dichos = [p.get('di', '') for e in escs for p in e.get('pasos', [])]
            palabras_video = len(re.findall(r'\w+', ' '.join(dichos)))
            datos['video_palabras'] = palabras_video
            # Con pausas y cambios de escena caben unas 4.700 palabras en 30:00 (≈158 por
            # minuto); generar-video.py --medir da la cifra exacta y ajusta el ritmo
            datos['video_minutos_naturales_estimados'] = round(palabras_video / PALABRAS_POR_MINUTO, 1)
            if not 4300 <= palabras_video <= 5100:
                avisos.append(f'La narración del vídeo tiene {palabras_video} palabras (objetivo ≈4.700)')
            if 'bloques' not in g:
                errores.append('escenas.yaml sin «bloques» (formato antiguo del vídeo)')
            nombres = {b['nombre'] for b in g.get('bloques', [])}
            for i, e in enumerate(escs, 1):
                if e.get('bloque') not in nombres:
                    errores.append(f'Escena {i}: el bloque «{e.get("bloque")}» no está en «bloques»')
                for k, p in enumerate(e.get('pasos', []), 1):
                    for clave in ('pizarra', 'apoyo'):
                        acciones = p.get(clave) or []
                        for a in (acciones if isinstance(acciones, list) else [acciones]):
                            if isinstance(a, dict) and a.get('grafico') and not os.path.exists(
                                    os.path.join(tema.graficos, a['grafico'] + '.tex')):
                                errores.append(f'escenas.yaml usa un gráfico inexistente en «{clave}»: {a["grafico"]}')
                    if not str(p.get('di', '')).strip():
                        avisos.append(f'Escena {i}, paso {k}: sin «di» (la voz no se para nunca; CRITERIOS §8)')
                    if len(re.findall(r'\[pausa', str(p.get('di', '')))) > 2:
                        avisos.append(f'Escena {i}, paso {k}: más de dos [pausa] (CRITERIOS §8: una o dos por paso)')
            # Criterios del cante (CRITERIOS.md, 8)
            texto = ' '.join(dichos)
            if re.search(r'miembros del tribunal', texto, re.I):
                errores.append('El cante saluda al tribunal («Señores miembros del tribunal»): se empieza por el título')
            if re.search(r'\b(muchas gracias|gracias por su atención|gracias)\b', ' '.join(dichos[-3:]), re.I):
                errores.append('El cante termina dando las gracias')
            concl = [e for e in escs if re.match(r'conclusi', str(e.get('bloque', '')), re.I)]
            if concl:
                primero = next((p.get('di', '') for p in concl[0].get('pasos', []) if p.get('di')), '')
                if not re.match(r'\s*(En conclusión|A modo de conclusión)', primero):
                    errores.append('La conclusión no empieza por «En conclusión» o «A modo de conclusión»')
            for m in set(re.findall(r'\btema\s+(?:\d|tres|cuatro)[\w .]*?(?=[,.;:]|$)', texto, re.I)):
                avisos.append(f'Se dice un número de tema en voz alta: «{m.strip()[:40]}»')
            if re.search(r'\btermino ya\b', texto, re.I):
                avisos.append('«termino ya»: la conclusión empieza por «En conclusión»')
        except Exception as e:
            errores.append(f'escenas.yaml no es válido: {e}')
    return errores, avisos, datos


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    tema = Tema(sys.argv[1])
    errores, avisos, datos = verificar(tema)
    if '--json' in sys.argv:
        print(json.dumps({'tema': tema.codigo, 'errores': errores, 'avisos': avisos, 'datos': datos},
                         ensure_ascii=False, indent=2))
    else:
        print(f'Tema {tema}: {len(errores)} errores, {len(avisos)} avisos')
        if datos.get('paginas_tema'):
            print(f'  páginas del tema: {datos["paginas_tema"]} (anexos: {datos.get("paginas_anexos", 0)}; '
                  f'bibliografía: {datos.get("paginas_bibliografia", 0)}; total: {datos.get("paginas_total", "?")})')
        for e in errores:
            print('  ERROR', e)
        for a in avisos:
            print('  aviso', a)
        print('  ' + ', '.join(f'{k}: {v}' for k, v in datos.items()))
    sys.exit(1 if errores else 0)


if __name__ == '__main__':
    main()
