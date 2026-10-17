"""
Utilidades comunes de los scripts de scripts/temario/ (revisión del temario
del 3.º y 4.º ejercicio con /revisartema).

Los programas son los de Windows (MiKTeX, LyX, el pandoc de Quarto) y se
llaman desde WSL; por eso las rutas que se les pasan van en formato Windows y
TEXINPUTS se exporta con WSLENV.

Autor: Víctor Gutiérrez Marcos
"""
import glob
import json
import os
import re
import shutil
import subprocess

RAIZ = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
TEMARIO = os.path.join(RAIZ, 'oposicion', 'temario')
LATEX = os.path.join(TEMARIO, 'latex')
FUENTES = os.path.join(TEMARIO, 'fuentes')

# Checkout principal (main): ahí están los Word originales de oculto/, que no
# van en git y por tanto no existen en el worktree de la rama.
REPO_MAIN = os.environ.get(
    'TCEE_REPO_MAIN', '/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io')

_WIN = '/mnt/c/Users/vgutierrez/AppData/Local/Programs'
MIKTEX = os.environ.get('TCEE_MIKTEX', f'{_WIN}/MiKTeX/miktex/bin/x64')
PANDOC = os.environ.get('TCEE_PANDOC', f'{_WIN}/Quarto/bin/tools/pandoc.exe')
DENO = f'{_WIN}/Quarto/bin/tools/x86_64/deno.exe'


def _buscar_lyx():
    if os.environ.get('TCEE_LYX'):
        return os.environ['TCEE_LYX']
    candidatos = (glob.glob('/mnt/c/Program Files/LyX*/bin/LyX.exe')
                  + glob.glob('/mnt/c/Program Files (x86)/LyX*/bin/LyX.exe')
                  + glob.glob(f'{_WIN}/LyX*/bin/LyX.exe')
                  + glob.glob('/mnt/c/Users/vgutierrez/AppData/Local/LyX*/bin/LyX.exe'))
    return sorted(candidatos)[-1] if candidatos else None


LYX = _buscar_lyx()
TEX2LYX = os.path.join(os.path.dirname(LYX), 'tex2lyx.exe') if LYX else None

EJERCICIOS = {
    '3': ('tercer-ejercicio', 'Tercer ejercicio'),
    '4': ('cuarto-ejercicio', 'Cuarto ejercicio'),
}


class Tema:
    """Un tema identificado por su código: 3A08, 3.A.8, 4B12…"""

    def __init__(self, codigo):
        m = re.fullmatch(r'\s*([34])\.?([AB])\.?(\d{1,2})\s*', codigo, re.I)
        if not m:
            raise ValueError(f'Código de tema no válido: {codigo!r} (ejemplos: 3A08, 3.A.8, 4B12)')
        self.ejercicio, self.parte, n = m.group(1), m.group(2).upper(), int(m.group(3))
        self.numero = n
        self.archivo = f'{self.ejercicio}{self.parte}{n:02d}'      # 3A08
        self.codigo = f'{self.ejercicio}.{self.parte}.{n}'          # 3.A.8
        self.carpeta, self.nombre_ejercicio = EJERCICIOS[self.ejercicio]
        self.dir = os.path.join(FUENTES, self.archivo)
        self.dir_publico = os.path.join(TEMARIO, self.carpeta)
        self.lyx = os.path.join(self.dir, f'{self.archivo}.lyx')
        self.bib = os.path.join(self.dir, f'{self.archivo}.bib')
        self.graficos = os.path.join(self.dir, 'graficos')
        self.trabajo = os.path.join(self.dir, '_trabajo')   # intermedios, fuera de git

    def __str__(self):
        return self.codigo

    # --- Datos del índice de temas ------------------------------------------
    def info(self):
        """Título y disponibilidad según oposicion/temario/temario.json."""
        with open(os.path.join(TEMARIO, 'temario.json'), encoding='utf-8') as f:
            datos = json.load(f)
        for ej in datos.get('ejercicios', []):
            for parte in ej.get('partes', []):
                for t in parte.get('temas', []):
                    if t.get('codigo') == self.codigo:
                        return t
        return None

    def titulo(self):
        t = self.info()
        return t['titulo'] if t else ''

    # --- Original en Word ---------------------------------------------------------
    def original_docx(self):
        """Word original (oculto/) cuyo contenido corresponde a este tema.

        En el 4.º ejercicio la numeración cambió con el temario nuevo: el
        comentario «<!-- 4A22 nuevo ← 4A25 viejo -->» de cuarto-ejercicio.html
        indica de qué original viejo sale cada tema nuevo.
        """
        oculto = os.path.join(REPO_MAIN, 'oposicion', 'temario', self.carpeta, 'oculto')
        codigo_original = self.codigo
        if self.ejercicio == '4':
            html = open(os.path.join(TEMARIO, 'cuarto-ejercicio.html'), encoding='utf-8').read()
            m = re.search(rf'<!--\s*{self.archivo}\s+nuevo\s*←\s*(4[AB]\d\d)\s+viejo', html)
            if m:
                viejo = Tema(m.group(1))
                codigo_original = viejo.codigo
        candidatos = sorted(glob.glob(os.path.join(oculto, f'Tema {codigo_original}.docx'))
                            + glob.glob(os.path.join(oculto, f'Tema {codigo_original} (*).docx')))
        return candidatos[0] if candidatos else None

    def pdf_publicado(self):
        ruta = os.path.join(REPO_MAIN, 'oposicion', 'temario', self.carpeta, f'{self.archivo}.pdf')
        return ruta if os.path.exists(ruta) else None

    # --- Estado de la revisión ---------------------------------------------------
    def estado(self):
        ruta = os.path.join(self.dir, 'estado.json')
        if os.path.exists(ruta):
            with open(ruta, encoding='utf-8') as f:
                return json.load(f)
        return {'tema': self.codigo, 'fases': {}}

    def guardar_estado(self, estado):
        os.makedirs(self.dir, exist_ok=True)
        with open(os.path.join(self.dir, 'estado.json'), 'w', encoding='utf-8') as f:
            json.dump(estado, f, ensure_ascii=False, indent=2)
            f.write('\n')


def ruta_windows(ruta):
    return subprocess.run(['wslpath', '-w', ruta], capture_output=True, text=True, check=True).stdout.strip()


def entorno_tex():
    """Entorno para MiKTeX con oposicion/temario/latex en TEXINPUTS."""
    env = dict(os.environ)
    env['TEXINPUTS'] = ruta_windows(LATEX) + '//;'
    env['WSLENV'] = ':'.join(filter(None, [env.get('WSLENV', ''), 'TEXINPUTS']))
    return env


def ejecutar(orden, cwd=None, env=None, timeout=900, comprobar=True):
    """Ejecuta un programa y devuelve (código, salida). Si falla y comprobar es
    True, lanza RuntimeError con el final de la salida."""
    r = subprocess.run(orden, cwd=cwd, env=env, capture_output=True, timeout=timeout)
    salida = (r.stdout + r.stderr).decode('utf-8', errors='replace')
    if comprobar and r.returncode != 0:
        raise RuntimeError(f'Falló {os.path.basename(orden[0])} (código {r.returncode}):\n' + salida[-3000:])
    return r.returncode, salida


def errores_log(ruta_log):
    """Errores de un .log de LaTeX (líneas que empiezan por «!» y su contexto)."""
    if not os.path.exists(ruta_log):
        return ['No se generó el .log']
    texto = open(ruta_log, encoding='latin-1').read()
    errores = []
    lineas = texto.splitlines()
    for i, l in enumerate(lineas):
        if l.startswith('!'):
            errores.append('\n'.join(lineas[i:i + 4]))
    return errores


def copiar_si_cambia(origen, destino):
    if os.path.exists(destino) and open(origen, 'rb').read() == open(destino, 'rb').read():
        return False
    shutil.copyfile(origen, destino)
    return True


def guardar_anterior(tema, ext, firma):
    """Guarda una vez el fichero del tema (pdf o docx) tal como está en main
    antes de revisarlo (<tema>-anterior.<ext>), para que en la web se pueda
    consultar la versión antigua. Nunca lo sobrescribe: es la versión original.
    Si en main no hay ese fichero, no crea nada. Devuelve la ruta si existe."""
    destino = os.path.join(tema.dir_publico, f'{tema.archivo}-anterior.{ext}')
    if os.path.exists(destino):
        return destino
    relativa = os.path.relpath(os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}'), RAIZ).replace(os.sep, '/')
    for rama in ('origin/main', 'main'):
        r = subprocess.run(['git', '-C', RAIZ, 'show', f'{rama}:{relativa}'], capture_output=True)
        if r.returncode == 0 and r.stdout.startswith(firma):
            with open(destino, 'wb') as f:
                f.write(r.stdout)
            return destino
    return None


def guardar_pdf_anterior(tema):
    """PDF del tema tal como está en main antes de revisarlo (<tema>-anterior.pdf)."""
    return guardar_anterior(tema, 'pdf', b'%PDF')


def guardar_docx_anterior(tema):
    """Word del tema tal como está en main antes de revisarlo (<tema>-anterior.docx)."""
    return guardar_anterior(tema, 'docx', b'PK')


# --- Minutos y páginas ---------------------------------------------------------------
def minutos_texto(valor, primas=('′', '″')):
    """Minutos decimales sin decimales, como \\tceemmss de tcee.sty:
    2,5 → 2′30″; 26,5 → 26′30″; 1 → 1′. Acepta '2,5', '2.5' o un número; si no
    es un número, lo devuelve tal cual."""
    try:
        seg = round(float(str(valor).strip().replace(',', '.')) * 60)
    except ValueError:
        return str(valor)
    m, s = divmod(seg, 60)
    return f'{m}{primas[0]}' + (f'{s:02d}{primas[1]}' if s else '')


def segundos_texto(segundos):
    """Un tiempo en segundos como 17′05″ (o 17′ si son minutos justos)."""
    return minutos_texto(max(0, int(round(segundos))) / 60)


def paginas_partes(aux):
    """Páginas de cada parte del PDF según el .aux (las escribe tcee.sty):
    {'tema': 18, 'anexos': 6, 'bib': 2}. Vacío si no hay .aux."""
    if not os.path.exists(aux):
        return {}
    texto = open(aux, encoding='utf-8', errors='replace').read()
    return {m.group(1): int(m.group(2))
            for m in re.finditer(r'\\global\s*\\@namedef\s*\{tcee@pags@(\w+)\}\{(\d+)\}', texto)}


def linea_paginas(partes):
    """«Tema: 18 págs. · Anexos: 6 · Bibliografía: 2», como en la portada del PDF."""
    if 'tema' not in partes:
        return ''
    trozos = [f'Tema: {partes["tema"]} págs.']
    if partes.get('anexos'):
        trozos.append(f'Anexos: {partes["anexos"]}')
    if partes.get('bib'):
        trozos.append(f'Bibliografía: {partes["bib"]}')
    return ' · '.join(trozos)


# --- Licencia ------------------------------------------------------------------------
# Todos los formatos del temario (PDF, HTML, Word, ficha de repaso y vídeo) llevan
# la licencia CC BY-NC-ND 4.0; la ponen las plantillas (tcee.sty, tcee-repaso.sty,
# plantilla-tema.html) y estos scripts, no cada tema.
AUTOR = 'Víctor Gutiérrez Marcos'
LICENCIA = 'CC BY-NC-ND 4.0'
LICENCIA_URL = 'https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es'
LICENCIA_URL_LEGAL = 'https://creativecommons.org/licenses/by-nc-nd/4.0/'
LICENCIA_PERMISOS = 'puedes compartirlo citando al autor, sin fines comerciales y sin modificarlo'


def anio_tema(tema):
    """Año de la última actualización del tema (\\tcefecha{dd/mm/aaaa} de su .tex);
    si no se encuentra, el año en curso."""
    import datetime
    ruta = os.path.join(tema.dir, f'{tema.archivo}.tex')
    if os.path.exists(ruta):
        m = re.search(r'\\tcefecha\{[^}]*?(\d{4})\s*\}', open(ruta, encoding='utf-8').read())
        if m:
            return int(m.group(1))
    return datetime.date.today().year


def licencia_corta(anio):
    """«© 2026 Víctor Gutiérrez Marcos · CC BY-NC-ND 4.0»"""
    return f'© {anio} {AUTOR} · {LICENCIA}'


def licencia_larga(anio):
    """La línea completa, con el enlace y lo que permite."""
    return f'© {anio} {AUTOR} · Licencia {LICENCIA} ({LICENCIA_URL}): {LICENCIA_PERMISOS}.'
