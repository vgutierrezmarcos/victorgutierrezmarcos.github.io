#!/usr/bin/env python3
"""El esquema público de cada tema revisado, sacado de su fuente LaTeX.

Víctor (26/11/2026): quien no inicia sesión ni quiere la versión antigua puede ver, en la
página del tema, un esquema detallado: todos los apartados (también los párrafos y los
a)–e) de los modelos), los autores citados en cada uno con su año, el refrán con que abre,
los minutos de cada bloque para cantarlo, los títulos de los anexos, los conceptos (con su
artículo de Wikipedia) y los temas relacionados. El tema completo sigue protegido.

Lee la fuente y la bibliografía del almacén (rama privado/temario-publicado:
oposicion/temario/fuentes/<archivo>/<archivo>.tex y .bib). Lo usa
scripts/temas-revisados-web.py para escribir el esquema en cada página de tema.

    python3 scripts/esquemas_publicos.py 3A08            # el esquema de un tema, en texto
    python3 scripts/esquemas_publicos.py --manuales      # los manuales que no salen como autores

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import subprocess
import sys
from collections import Counter
from functools import lru_cache

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF = os.environ.get('TCEE_REF_FUENTES', 'privado/temario-publicado')
FUENTES = 'oposicion/temario/fuentes'
NIVELES = {'section': 0, 'subsection': 1, 'subsubsection': 2, 'paragraph': 3, 'subparagraph': 4}
# Títulos de manual (ver manuales())
MANUAL = re.compile(r'^\s*(?:advanced|intermediate|introduc\w*|principles of|principios de|fundamentos de|foundations of|'
                    r'elements of|curso de|manual de|lecciones de|lectures on|teor[ií]a econ[oó]mica|handbook|a course|'
                    r'microecon\w*|macroecon\w*|an[aá]lisis microecon\w*|international (?:economics|macroeconomics|trade|finance)|'
                    r'econom[ií]a internacional|recursive macroecon\w*|a history of|history of economic|historia del pensamiento)'
                    r'|textbook|\bmanual\b|:\s*(?:an?|una) introduc', re.I)
MAX_AUTORES = 8

GRIEGAS = {'alpha': 'α', 'beta': 'β', 'gamma': 'γ', 'delta': 'δ', 'epsilon': 'ε', 'varepsilon': 'ε', 'theta': 'θ',
           'lambda': 'λ', 'mu': 'μ', 'pi': 'π', 'rho': 'ρ', 'sigma': 'σ', 'tau': 'τ', 'phi': 'φ', 'varphi': 'φ',
           'chi': 'χ', 'psi': 'ψ', 'omega': 'ω', 'Delta': 'Δ', 'Sigma': 'Σ', 'Omega': 'Ω', 'Pi': 'Π', 'kappa': 'κ',
           'eta': 'η', 'nu': 'ν', 'xi': 'ξ', 'zeta': 'ζ', 'iota': 'ι', 'Gamma': 'Γ', 'Lambda': 'Λ', 'Phi': 'Φ',
           'Psi': 'Ψ', 'Theta': 'Θ', 'infty': '∞', 'times': '×', 'cdot': '·', 'leq': '≤', 'geq': '≥', 'neq': '≠',
           'to': '→', 'rightarrow': '→', 'approx': '≈', 'pm': '±', 'ldots': '…', 'dots': '…', 'in': '∈'}


def git(*args):
    r = subprocess.run(['git', '-C', RAIZ, *args], capture_output=True)
    return r.stdout.decode('utf-8', 'replace') if r.returncode == 0 else None


@lru_cache(maxsize=None)
def _todas():
    """Todas las .tex y .bib de los temas, de una vez (git cat-file --batch: en /mnt/c, un
    git show por fichero tarda más de un minuto)."""
    arbol = git('ls-tree', '-r', REF, '--', FUENTES + '/') or ''
    objetos = {}
    for linea in arbol.splitlines():
        meta, ruta = linea.split('\t', 1)
        m = re.fullmatch(FUENTES + r'/(\w+)/\1\.(tex|bib)', ruta)
        if m:
            objetos[meta.split()[2]] = (m.group(1), m.group(2))
    if not objetos:
        return {}
    r = subprocess.run(['git', '-C', RAIZ, 'cat-file', '--batch'], input='\n'.join(objetos).encode() + b'\n',
                       capture_output=True, check=True)
    datos, i, salida = r.stdout, 0, {}
    while i < len(datos):
        fin = datos.index(b'\n', i)
        sha, _, tam = datos[i:fin].decode().split()
        cuerpo = datos[fin + 1: fin + 1 + int(tam)]
        salida[objetos[sha]] = cuerpo.decode('utf-8', 'replace')
        i = fin + 1 + int(tam) + 1
    return salida


def fuente(archivo, ext='tex'):
    return _todas().get((archivo, ext))


def archivos():
    return sorted({a for a, ext in _todas() if ext == 'tex' and re.fullmatch(r'\d[A-Z]\d\d', a)})


# ------------------------------------------------------------------ LaTeX

def sin_comentarios(t):
    return re.sub(r'(?<!\\)%.*', '', t)


def llave(t, i):
    """t[i] == '{': devuelve (contenido, índice tras la llave de cierre)."""
    nivel, j = 0, i
    while j < len(t):
        c = t[j]
        if c == '\\':
            j += 2
            continue
        if c == '{':
            nivel += 1
        elif c == '}':
            nivel -= 1
            if nivel == 0:
                return t[i + 1:j], j + 1
        j += 1
    return t[i + 1:], len(t)


def quitar_orden(t, orden):
    """Quita \\orden{…} entera (con su argumento), p. ej. las notas al pie."""
    salida, i = [], 0
    patron = re.compile(r'\\' + orden + r'\*?(?:\[[^\]]*\])?\s*\{')
    while True:
        m = patron.search(t, i)
        if not m:
            salida.append(t[i:])
            return ''.join(salida)
        salida.append(t[i:m.start()])
        _, i = llave(t, m.end() - 1)


def matematicas(m):
    t = m.group(1)
    t = re.sub(r'\\(?:mathrm|text|textrm|mathit|mathbf|boldsymbol|vect|overline|bar|hat|tilde)\s*\{([^{}]*)\}', r'\1', t)
    t = re.sub(r'\\([A-Za-z]+)', lambda g: GRIEGAS.get(g.group(1), ''), t)
    t = re.sub(r'_\{([^{}]*)\}|_(\w)', lambda g: g.group(1) or g.group(2), t)
    t = re.sub(r'\^\{([^{}]*)\}|\^(\w)', lambda g: '^' + (g.group(1) or g.group(2)), t)
    return t.replace('{', '').replace('}', '').replace(' ', '')


def texto(t):
    """Un título de apartado en LaTeX → texto plano."""
    t = re.sub(r'\\label\{[^}]*\}', '', t)
    t = re.sub(r'\\(?:cortetitulo|newline|linebreak|\\)\s*(?:\{\})?', ' ', t)
    t = re.sub(r'\$([^$]*)\$', matematicas, t)
    t = re.sub(r'\\vertema\{([^}]*)\}', r'(tema \1)', t)
    for _ in range(4):
        t = re.sub(r'\\[A-Za-z]+\*?(?:\[[^\]]*\])?\{([^{}]*)\}', r'\1', t)
    t = re.sub(r'\\([A-Za-z]+)', lambda g: GRIEGAS.get(g.group(1), ''), t)
    t = t.replace('~', ' ').replace('---', '—').replace('--', '–').replace('\\&', '&').replace('\\%', '%')
    t = t.replace('{', '').replace('}', '').replace('\\', '')
    return re.sub(r'\s+', ' ', t).strip()


def minutos(valor):
    """«2,5» → 2'30"; «11» → 11'."""
    try:
        v = float(valor.replace(',', '.'))
    except ValueError:
        return None
    m, s = int(v), round((v - int(v)) * 60)
    return f"{m}'{s:02d}\"" if s else f"{m}'"


# ---------------------------------------------------------- Bibliografía

@lru_cache(maxsize=None)
def entradas(archivo):
    """clave → (tipo, campos) de la .bib del tema."""
    t = sin_comentarios(fuente(archivo, 'bib') or '')
    salida = {}
    for m in re.finditer(r'@(\w+)\s*\{\s*([^,\s]+)\s*,', t):
        cuerpo, _ = llave(t, t.index('{', m.start()))
        campos, j = {}, cuerpo.index(',') + 1 if ',' in cuerpo else 0
        # campo = {valor} | "valor" | valor, uno detrás de otro (sin mirar dentro de los valores)
        while True:
            c = re.compile(r'\s*,?\s*(\w+)\s*=\s*').match(cuerpo, j)
            if not c:
                break
            j = c.end()
            if j < len(cuerpo) and cuerpo[j] == '{':
                v, j = llave(cuerpo, j)
            elif j < len(cuerpo) and cuerpo[j] == '"':
                k = cuerpo.find('"', j + 1)
                v, j = cuerpo[j + 1:k], k + 1
            else:
                v = re.match(r'[^,\n]*', cuerpo[j:]).group(0)
                j += len(v)
            campos.setdefault(c.group(1).lower(), v.strip())
        salida[m.group(2)] = (m.group(1).lower(), campos)
    return salida


@lru_cache(maxsize=None)
def bib(archivo):
    """clave → (apellidos, año); sin las de autor institucional ({{…}})."""
    salida = {}
    for clave, (_, campos) in entradas(archivo).items():
        autor = campos.get('author') or campos.get('editor') or ''
        if not autor or autor.startswith('{'):
            continue
        anio = (re.search(r'\d{4}', campos.get('year') or campos.get('date') or '') or [None])[0]
        apellidos = []
        for x in re.split(r'\s+and\s+', autor):
            x = texto(x)
            if not x:
                continue
            if x.lower() == 'others':
                apellidos.append(None)
                continue
            apellidos.append(x.split(',')[0].strip() if ',' in x else x.split()[-1])
        salida[clave] = (apellidos, anio)
    return salida


def cita(apellidos, anio):
    """«Samuelson (1938)», «Mas-Colell, Whinston y Green (1995)», «Deaton et al. (1980)»."""
    a = [x for x in apellidos if x]
    if not a:
        return None
    if len(apellidos) > 3 or None in apellidos:
        nombre = f'{a[0]} et al.'
    elif len(a) == 1:
        nombre = a[0]
    else:
        nombre = ', '.join(a[:-1]) + ' y ' + a[-1]
    return f'{nombre} ({anio})' if anio else nombre


CITAS = re.compile(r'\\(?:text|paren|auto|foot|full)?cite[pt]?\*?((?:\s*\[[^\]]*\]){0,2})\s*\{([^}]*)\}')


def claves_citadas(t):
    for m in CITAS.finditer(t):
        for k in m.group(2).split(','):
            if k.strip():
                yield k.strip()


@lru_cache(maxsize=None)
def manuales(archivo):
    """Claves de manuales y obras de consulta (Mas-Colell, Varian, Romer…): libros de 1980 en
    adelante con título de manual. No son el autor de un modelo: no salen en los autores."""
    salida = set()
    for clave, (tipo, campos) in entradas(archivo).items():
        anio = int((re.search(r'\d{4}', campos.get('year') or campos.get('date') or '') or ['0'])[0])
        if tipo == 'book' and anio >= 1980 and MANUAL.search(texto(campos.get('title', ''))):
            salida.add(clave)
    return salida


# --------------------------------------------------------------- Esquema

ORDEN_TITULO = re.compile(r'\\(section|subsection|subsubsection|paragraph|subparagraph)(\*?)\s*(?:\[[^\]]*\])?\s*\{')


def refran(intro):
    """El refrán (o dicho) del enganche: «…», dice el refrán; si no lo dice, la primera cita
    entre comillas del enganche."""
    limpio = quitar_orden(intro, 'footnote')
    enganche = limpio[limpio.find('Enganche'):] if 'Enganche' in limpio else limpio
    for patron, donde in ((r'«([^«»]{8,220})»[^«»]{0,60}?(?:refr[aá]n|dicho)', limpio),
                          (r'(?:refr[aá]n|dicho)[^«»]{0,80}?«([^«»]{8,220})»', limpio),
                          (r'^[^«]{0,80}«([^«»]{8,220})»', enganche[:600])):
        m = re.search(patron, donde, re.S)
        if m:
            r = texto(m.group(1)).rstrip(',;:')
            return r[0].upper() + r[1:]
    return None


def esquema(archivo):
    """{'refran', 'apartados': [{nivel, numero, titulo, minutos, autores, anexo, hijos…}] (plano, en orden),
    'anexos': [{titulo, partes}], 'relacionados': [códigos], 'minutos_total'} o None si no hay fuente."""
    t = fuente(archivo)
    if not t:
        return None
    t = sin_comentarios(t)
    if '\\begin{document}' in t:
        t = t.split('\\begin{document}', 1)[1]
    t = re.split(r'\\end\{document\}|\\printbibliography', t)[0]
    referencias = bib(archivo)
    excluidos = manuales(archivo)
    codigo_propio = re.sub(r'^(\d)([A-Z])0?(\d+)$', r'\1.\2.\3', archivo)
    relacionados = Counter(c.strip() for c in re.findall(r'\\vertema\{([^}]*)\}', t) if c.strip() != codigo_propio)

    marcas = list(ORDEN_TITULO.finditer(t))
    apartados, anexos, contador = [], [], [0] * 5
    total = 0.0
    en_anexo = False
    refr = None
    for n, m in enumerate(marcas):
        orden, estrella = m.group(1), m.group(2)
        titulo_tex, fin = llave(t, m.end() - 1)
        cuerpo = t[fin: marcas[n + 1].start() if n + 1 < len(marcas) else len(t)]
        titulo = texto(titulo_tex)
        nivel = NIVELES[orden]
        if nivel == 0:
            en_anexo = titulo.lower().startswith('anexo')
            if en_anexo:
                anexos.append({'titulo': re.sub(r'^Anexo\s*[:.]?\s*', '', titulo).strip(), 'partes': []})
                continue
        if en_anexo:
            if nivel == 1:
                anexos[-1]['partes'].append(titulo)
            continue
        numero = None
        if not estrella and nivel <= 2:
            contador[nivel] += 1
            for k in range(nivel + 1, 5):
                contador[k] = 0
            numero = '.'.join(str(c) for c in contador[:nivel + 1])
        mm = re.match(r'\s*(?:\\label\{[^}]*\}\s*)*\\minutos\{([^}]*)\}', cuerpo)
        mins = minutos(mm.group(1)) if mm else None
        if mm:
            try:
                total += float(mm.group(1).replace(',', '.'))
            except ValueError:
                pass
        if nivel == 0 and titulo.lower().startswith('introducción') and refr is None:
            refr = refran(cuerpo)
        vistos, autores = set(), []
        for k in claves_citadas(quitar_orden(cuerpo, 'footnote')):
            if k not in referencias:
                continue
            c = cita(*referencias[k])
            if c and c not in vistos and k not in excluidos:
                vistos.add(c)
                autores.append(c)
        apartados.append({'nivel': nivel, 'numero': numero, 'titulo': titulo, 'minutos': mins,
                          'autores': agrupar(autores)[:MAX_AUTORES]})
    return {'refran': refr, 'apartados': apartados, 'anexos': anexos,
            'relacionados': [c for c, _ in relacionados.most_common()],
            'minutos_total': minutos(f'{total:g}') if total else None}


def agrupar(citas):
    """«Samuelson (1938)», «Samuelson (1948)» → «Samuelson (1938, 1948)», en el orden de la primera."""
    orden, anios = [], {}
    for c in citas:
        m = re.fullmatch(r'(.*) \((\d{4})\)', c)
        nombre, anio = (m.group(1), m.group(2)) if m else (c, None)
        if nombre not in anios:
            orden.append(nombre)
            anios[nombre] = []
        if anio and anio not in anios[nombre]:
            anios[nombre].append(anio)
    return [f'{n} ({", ".join(anios[n])})' if anios[n] else n for n in orden]


def imprimir(archivo):
    e = esquema(archivo)
    if not e:
        sys.exit(f'Sin fuente para {archivo} en {REF}')
    if e['refran']:
        print(f'«{e["refran"]}»\n')
    for a in e['apartados']:
        linea = '  ' * a['nivel'] + (a['numero'] + '. ' if a['numero'] else '') + a['titulo']
        if a['minutos']:
            linea += f'  [{a["minutos"]}]'
        print(linea)
        if a['autores']:
            print('  ' * a['nivel'] + '    — ' + ' · '.join(a['autores']))
    for x in e['anexos']:
        print('Anexo: ' + x['titulo'] + (' — ' + ', '.join(x['partes']) if x['partes'] else ''))
    print('\nRelacionados:', ', '.join(e['relacionados']))
    print('Total:', e['minutos_total'])


if __name__ == '__main__':
    if '--manuales' in sys.argv:
        todos = Counter()
        for a in archivos():
            b = bib(a)
            todos.update(cita(*b[k]) for k in manuales(a) if k in b)
        print(json.dumps(sorted(todos), ensure_ascii=False, indent=1))
    else:
        for a in sys.argv[1:] or ['3A08']:
            imprimir(a)
