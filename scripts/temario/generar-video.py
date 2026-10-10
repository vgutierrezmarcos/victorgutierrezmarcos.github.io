#!/usr/bin/env python3
"""
Genera el vídeo del cante de un tema (exactamente 30:00, 1920 × 1080) a partir
de fuentes/<tema>/video/escenas.yaml.

    python3 scripts/temario/generar-video.py 3A08 [--borrador] [--tramo 0:00-3:00]

Cómo es el vídeo (CRITERIOS.md, «Vídeo»):
  - Cabecera como las presentaciones Beamer: el tema y el apartado, los
    bloques de la exposición con un punto por apartado (el actual resaltado),
    la barra de progreso y el tiempo que queda.
  - Dos modos, como en el examen:
      guion    lo que el opositor cuenta sentado, sin pizarra (introducción,
               conclusión, partes habladas): en pantalla sale el guion en
               viñetas, que aparecen según se dicen. Es material didáctico, con
               la tipografía del tema (Palatino) sobre papel.
      pizarra  lo que el opositor escribe y dibuja de pie: la pantalla es solo
               la pizarra blanca, con letra de rotulador. Los gráficos TikZ se
               dibujan trazo a trazo en el orden de su código y las fórmulas y
               el texto se escriben de izquierda a derecha. Lo didáctico va
               aparte, en la franja «Apunte» de abajo.
  - La pizarra tiene tres paneles (1, 2 y 3, como las pizarras de tres hojas):
    cada cosa se coloca en un panel o en varios (zona: "2-3") y bajo lo que ya
    hay; se borra con borrar: true (todo) o borrar: [2, 3].
  - Pausa entre pasos, más larga entre apartados y más aún entre bloques.
  - Dura exactamente lo que diga «duracion» (1800 s): se ajusta el ritmo de
    toda la narración a la vez (sin cambiar el tono) para que acabe justo
    antes de la pantalla final, que sale unos segundos en silencio.

Formato de escenas.yaml:

    tema: 3.A.8
    duracion: 1800                     # opcional
    voz: {motor: edge, nombre: es-ES-AlvaroNeural, velocidad: "+15%"}
    pronunciacion: {Slutsky: Slútski}  # además de scripts/temario/pronunciacion.yaml
    bloques:                           # cabecera (orden de la exposición)
      - {nombre: Introducción, minutos: 3}
      - {nombre: "I. La función de demanda", minutos: 10}
      - {nombre: Conclusión, minutos: 2}
    escenas:
      - bloque: Introducción
        titulo: Introducción           # sale en la cabecera; uno por apartado
        modo: guion
        estructura: [Enganche, Relevancia, Contextualización, Problemática, Estructura]
        pasos:
          - di: "Texto que se narra."
            parte: Enganche            # resalta esa parte de la estructura
            guion: "Marshall (1890): la economía, «los asuntos ordinarios de la vida»"
          - di: "…"
            guion: ["> subidea", "> otra"]     # «>» sangra un nivel
      - bloque: "I. La función de demanda"
        titulo: "I.1. Preferencias"
        modo: pizarra
        pasos:
          - di: "…"
            borrar: true               # o [2, 3]
            pizarra:
              - {escribe: "# I.1. Preferencias", zona: 1}     # «#» = título subrayado
              - {escribe: "Completitud", zona: 1, color: rojo}
              - {formula: 'x \\succeq y', zona: 1}
              - {grafico: axiomas, capa: 1, zona: 2-3, alto: 0.9}
            apunte: "Debreu (1959): racionalidad + continuidad ⇒ función de utilidad"
          - di: "…"
            pizarra: [{grafico: axiomas, capa: 3}]    # mismo gráfico: dibuja lo nuevo

Salida (fuera de git, en la carpeta Vídeos de Windows):
  Vídeos/temario/<tema>.mp4          el vídeo
  Vídeos/temario/<tema>.srt          subtítulos (para YouTube)
  Vídeos/temario/<tema>-youtube.txt  título, descripción y capítulos para YouTube

Voces (voz.motor): «edge» (Edge TTS neural, gratis) o «xtts» (voz clonada a
partir de una grabación, con scripts/temario/voz-xtts.py en ~/.venvs/voz).
Los audios, gráficos y fórmulas se guardan en fuentes/<tema>/_trabajo/video/
y solo se rehacen si cambia su texto.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import asyncio
import glob
import hashlib
import io
import json
import math
import os
import re
import subprocess
import sys
import time
import wave
from collections import Counter

import fitz  # PyMuPDF
import yaml
from PIL import Image, ImageChops, ImageDraw, ImageFont

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, MIKTEX, entorno_tex, ejecutar, errores_log  # noqa: E402

ANCHO, ALTO = 1920, 1080
FPS = 25
CAB = 124                      # alto de la cabecera
CUERPO = ALTO - CAB
MUESTREO = 24000               # Hz del audio
CIERRE = 6.0                   # segundos de la pantalla final, en silencio
PAUSA_PASO = 0.35
PAUSA_APARTADO = 1.0
PAUSA_BLOQUE = 1.8
FUNDIDO = 0.4
SALIDA = os.environ.get('TCEE_VIDEOS', '/mnt/c/Users/vgutierrez/Videos/temario')
FUENTES_WIN = '/mnt/c/Windows/Fonts'
PRONUNCIACION = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pronunciacion.yaml')
VOZ_DEFECTO = {'motor': 'edge', 'nombre': 'es-ES-AlvaroNeural', 'velocidad': '+15%'}
PYTHON_VOZ = os.path.expanduser('~/.venvs/voz/bin/python')

MORADO = (95, 41, 135)
MORADO_OSCURO = (58, 24, 84)
MORADO_PALIDO = (240, 233, 246)
TINTA = (40, 38, 44)
GRIS = (130, 125, 135)
SALVIA = (226, 239, 217)
SALVIA_OSCURO = (150, 180, 140)
PAPEL = (250, 249, 246)
PIZARRA = (253, 253, 251)
MARCO = (196, 199, 204)
ROTULADOR = {'azul': (24, 58, 140), 'negro': (32, 32, 36), 'rojo': (190, 32, 38),
             'verde': (24, 118, 60), 'morado': MORADO}

# Pizarra: tres paneles dentro del marco
PZ_X0, PZ_Y0, PZ_X1, PZ_Y1 = 44, CAB + 18, ANCHO - 44, ALTO - 92   # en coordenadas de pantalla
PZ_MARGEN = 26
APUNTE_Y = ALTO - 80


def fuente(nombre, tam):
    return ImageFont.truetype(os.path.join(FUENTES_WIN, nombre), tam)


F_UI = fuente('segoeui.ttf', 22)
F_UI_N = fuente('segoeuib.ttf', 22)
F_UI_P = fuente('segoeui.ttf', 18)
F_BARRA = fuente('segoeuib.ttf', 28)
F_BARRA_L = fuente('segoeuisl.ttf', 28)
F_GUION = fuente('pala.ttf', 36)
F_GUION_N = fuente('palab.ttf', 36)
F_GUION_T = fuente('palab.ttf', 46)
F_APUNTE = fuente('palai.ttf', 30)
F_APUNTE_E = fuente('segoeuib.ttf', 20)
F_PIZ = fuente('segoeprb.ttf', 38)
F_PIZ_T = fuente('segoeprb.ttf', 44)
F_TITULO = fuente('palab.ttf', 64)
F_SUBTITULO = fuente('pala.ttf', 42)


def huella(*partes):
    return hashlib.sha1('\x00'.join(map(str, partes)).encode()).hexdigest()[:12]


def mmss(s):
    s = max(0, int(round(s)))
    return f'{s // 60}:{s % 60:02d}'


# --- Voz -------------------------------------------------------------------------------
def version_edge():
    """Edge TTS exige una versión de Edge reciente: se toma la instalada en Windows."""
    versiones = [os.path.basename(p) for p in glob.glob('/mnt/c/Program Files (x86)/Microsoft/Edge/Application/*')
                 if re.fullmatch(r'\d+\.\d+\.\d+\.\d+', os.path.basename(p))]
    return max(versiones, key=lambda v: tuple(map(int, v.split('.')))) if versiones else None


def preparar_edge_tts():
    import edge_tts.communicate as cm
    v = version_edge()
    if v:
        mayor = v.split('.')[0]
        cm.SEC_MS_GEC_VERSION = '1-' + v
        cm.WSS_HEADERS['User-Agent'] = re.sub(r'(Chrome|Edg)/\d+', rf'\1/{mayor}', cm.WSS_HEADERS['User-Agent'])


async def _edge(texto, voz, velocidad, mp3):
    import edge_tts
    com = edge_tts.Communicate(texto, voz, rate=velocidad)
    with open(mp3, 'wb') as f:
        async for trozo in com.stream():
            if trozo['type'] == 'audio':
                f.write(trozo['data'])


def a_pcm(ffmpeg, origen, destino):
    """Cualquier audio → PCM 16 bits mono a MUESTREO Hz (sin cabecera)."""
    subprocess.run([ffmpeg, '-y', '-loglevel', 'error', '-i', origen, '-f', 's16le', '-ac', '1',
                    '-ar', str(MUESTREO), destino], check=True)


def pronunciar(texto, diccionario):
    """Cambia los nombres que la voz lee mal por cómo se dicen (solo para la voz)."""
    for escrito, dicho in diccionario.items():
        texto = re.sub(rf'(?<![\wÁÉÍÓÚáéíóúñÑ]){re.escape(escrito)}(?![\wÁÉÍÓÚáéíóúñÑ])', dicho, texto)
    return texto


def sintetizar_todos(textos, voz, carpeta, ffmpeg):
    """Devuelve, para cada texto, la ruta de su audio en PCM. Solo sintetiza los nuevos."""
    motor = voz.get('motor', 'edge')
    claves = [huella(motor, json.dumps(voz, sort_keys=True), t) for t in textos]
    pcm = [os.path.join(carpeta, f'voz-{c}.pcm') for c in claves]
    pendientes = [(t, p) for t, p in zip(textos, pcm) if not (os.path.exists(p) and os.path.getsize(p) > 0)]
    if not pendientes:
        return pcm
    print(f'Voz ({motor}): {len(pendientes)} fragmentos nuevos de {len(textos)}', flush=True)
    if motor == 'edge':
        preparar_edge_tts()
        for i, (texto, destino) in enumerate(pendientes, 1):
            mp3 = destino[:-4] + '.mp3'
            # Edge TTS devuelve a veces 403 durante un rato: se reintenta esperando cada vez más
            for intento in range(8):
                try:
                    asyncio.run(_edge(texto, voz.get('nombre', VOZ_DEFECTO['nombre']),
                                      voz.get('velocidad', VOZ_DEFECTO['velocidad']), mp3))
                    if os.path.getsize(mp3) == 0:
                        raise RuntimeError('audio vacío')
                    break
                except Exception as e:
                    if intento == 7:
                        raise RuntimeError(f'Edge TTS falló: {e}')
                    time.sleep(min(15 * 2 ** intento, 300))
            a_pcm(ffmpeg, mp3, destino)
            if i % 20 == 0:
                print(f'  {i}/{len(pendientes)}', flush=True)
    elif motor == 'xtts':
        muestra = os.path.expanduser(voz['muestra'])
        if not os.path.exists(muestra):
            raise RuntimeError(f'No existe la grabación de la voz: {muestra}')
        trabajo = os.path.join(carpeta, 'xtts-pendientes.json')
        json.dump([{'texto': t, 'wav': p[:-4] + '.wav'} for t, p in pendientes], open(trabajo, 'w', encoding='utf-8'),
                  ensure_ascii=False)
        guion_xtts = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'voz-xtts.py')
        subprocess.run([PYTHON_VOZ, guion_xtts, trabajo, muestra, str(voz.get('velocidad', 1.0))], check=True,
                       env={**os.environ, 'COQUI_TOS_AGREED': '1'})
        for _, destino in pendientes:
            a_pcm(ffmpeg, destino[:-4] + '.wav', destino)
    else:
        raise RuntimeError(f'Motor de voz desconocido: {motor}')
    return pcm


# --- Gráficos TikZ por capas ---------------------------------------------------------------
def compilar_capa(tema, nombre, capa, carpeta):
    tex = os.path.join(tema.graficos, f'{nombre}.tex')
    if not os.path.exists(tex):
        raise RuntimeError(f'No existe el gráfico graficos/{nombre}.tex')
    contenido = open(tex, encoding='utf-8').read()
    pdf = os.path.join(carpeta, f'g-{nombre}-{capa}-{huella(contenido, capa)}.pdf')
    if os.path.exists(pdf):
        return pdf
    trabajo = f'{nombre}-capa{capa}'
    orden = [os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
             f'-jobname={trabajo}', '-output-directory=../_trabajo/video',
             f'\\def\\tceepaso{{{capa}}}\\input{{{nombre}.tex}}']
    # Se compila desde graficos/ para que \input{../../../latex/tikz-tcee} funcione
    cod, _ = ejecutar(orden, cwd=tema.graficos, env=entorno_tex(), timeout=300, comprobar=False)
    salida = os.path.join(carpeta, f'{trabajo}.pdf')
    if cod != 0 or not os.path.exists(salida):
        raise RuntimeError(f'Error al compilar {nombre} (capa {capa}):\n'
                           + '\n'.join(errores_log(os.path.join(carpeta, f'{trabajo}.log'))))
    os.replace(salida, pdf)
    return pdf


def _r(v, paso=0.25):
    return round(v / paso) * paso


def _puntos_item(it):
    if it[0] == 'l':
        return [it[1], it[2]]
    if it[0] == 'c':
        p0, p1, p2, p3 = it[1], it[2], it[3], it[4]
        return [p0 * (1 - t) ** 3 + p1 * 3 * t * (1 - t) ** 2 + p2 * 3 * t ** 2 * (1 - t) + p3 * t ** 3
                for t in (i / 16 for i in range(17))]
    if it[0] == 're':
        r = it[1]
        return [r.tl, r.tr, r.br, r.bl, r.tl]
    if it[0] == 'qu':
        q = it[1]
        return [q.ul, q.ur, q.lr, q.ll, q.ul]
    return []


def elementos_pdf(pdf):
    """Trazos, rellenos y textos de un PDF de TikZ, en el orden en que se dibujan."""
    pag = fitz.open(pdf)[0]
    elems = []
    for d in pag.get_drawings():
        if (d.get('stroke_opacity') == 0 and d.get('fill_opacity') == 0):
            continue
        tramos, actual = [], []
        for it in d['items']:
            pts = _puntos_item(it)
            if not pts:
                continue
            if actual and (abs(actual[-1].x - pts[0].x) > 0.3 or abs(actual[-1].y - pts[0].y) > 0.3):
                tramos.append(actual)
                actual = []
            actual.extend(pts if not actual else pts[1:])
        if actual:
            tramos.append(actual)
        tipo = 'trazo' if d['type'] == 's' else 'relleno'
        if d['type'] == 'fs' and d['rect'].width * d['rect'].height > 400:
            tipo = 'trazo'
        forma = tuple((_r(p.x - d['rect'].x0), _r(p.y - d['rect'].y0)) for t in tramos for p in t)
        elems.append({'tipo': tipo, 'orden': d['seqno'], 'tramos': [[(p.x, p.y) for p in t] for t in tramos],
                      'rect': tuple(d['rect']), 'ancho': d.get('width') or 1.0,
                      'firma': (d['type'], str(d.get('color')), str(d.get('fill')), forma)})
    for s in pag.get_texttrace():
        if s.get('opacity', 1) == 0 or not s['chars']:
            continue
        cajas = [c[3] for c in s['chars']]
        rect = (min(c[0] for c in cajas), min(c[1] for c in cajas), max(c[2] for c in cajas), max(c[3] for c in cajas))
        texto = ''.join(chr(c[0]) if c[0] > 0 else '?' for c in s['chars'])
        forma = tuple((_r(c[2][0] - rect[0]), _r(c[2][1] - rect[1])) for c in s['chars'])
        elems.append({'tipo': 'texto', 'orden': s['seqno'], 'rect': rect, 'n': len(s['chars']),
                      'firma': ('t', texto, round(s['size'], 1), forma)})
    elems.sort(key=lambda e: e['orden'])
    return elems


def desplazamiento(parcial, completo):
    """Lo que hay que mover el PDF de una capa para que encaje con el completo
    (standalone recorta cada capa a su contenido)."""
    en_completo = {}
    for e in completo:
        en_completo.setdefault(e['firma'], []).append(e['rect'])
    votos = Counter()
    for e in parcial:
        for r in en_completo.get(e['firma'], []):
            votos[(_r(r[0] - e['rect'][0], 0.1), _r(r[1] - e['rect'][1], 0.1))] += 1
    return votos.most_common(1)[0][0] if votos else (0.0, 0.0)


def clave_posicion(e, d):
    return (e['firma'], _r(e['rect'][0] + d[0], 0.5), _r(e['rect'][1] + d[1], 0.5))


class Grafico:
    """Un gráfico TikZ en la pizarra: sabe dibujar sus capas y qué hay nuevo en cada una."""

    def __init__(self, tema, nombre, carpeta, caja):
        self.tema, self.nombre, self.carpeta = tema, nombre, carpeta
        self.pdf_completo = compilar_capa(tema, nombre, 1000, carpeta)
        self.completo = elementos_pdf(self.pdf_completo)
        pag = fitz.open(self.pdf_completo)[0]
        self.w_pt, self.h_pt = pag.rect.width, pag.rect.height
        x0, y0, x1, y1 = caja
        self.escala = min((x1 - x0) / self.w_pt, (y1 - y0) / self.h_pt)
        self.w, self.h = int(self.w_pt * self.escala), int(self.h_pt * self.escala)
        self.x = int(x0 + ((x1 - x0) - self.w) / 2)
        self.y = int(y0)
        self.capa = 0
        self._cache = {}

    def caja(self):
        return (self.x, self.y, self.x + self.w, self.y + self.h)

    def _capa(self, k):
        if k in self._cache:
            return self._cache[k]
        lienzo = Image.new('RGBA', (self.w, self.h), (0, 0, 0, 0))
        if k <= 0:
            self._cache[k] = (lienzo, [], (0, 0))
            return self._cache[k]
        pdf = compilar_capa(self.tema, self.nombre, k, self.carpeta)
        elems = elementos_pdf(pdf)
        d = desplazamiento(elems, self.completo)
        pix = fitz.open(pdf)[0].get_pixmap(matrix=fitz.Matrix(self.escala, self.escala), alpha=True)
        img = Image.open(io.BytesIO(pix.tobytes('png'))).convert('RGBA')
        lienzo.alpha_composite(img, (int(round(d[0] * self.escala)), int(round(d[1] * self.escala))))
        self._cache[k] = (lienzo, elems, d)
        return self._cache[k]

    def imagen(self, k=None):
        return self._capa(self.capa if k is None else k)[0]

    def nuevos(self, desde, hasta):
        """Elementos de la capa «hasta» que no estaban en «desde», en orden de dibujo, en píxeles."""
        _, previos, dp = self._capa(desde)
        _, actuales, da = self._capa(hasta)
        ya = Counter(clave_posicion(e, dp) for e in previos)
        s = self.escala
        salida = []
        for e in actuales:
            k = clave_posicion(e, da)
            if ya[k] > 0:
                ya[k] -= 1
                continue
            r = e['rect']
            caja = ((r[0] + da[0]) * s, (r[1] + da[1]) * s, (r[2] + da[0]) * s, (r[3] + da[1]) * s)
            n = dict(tipo=e['tipo'], caja=caja)
            if e['tipo'] == 'trazo':
                n['tramos'] = [[((x + da[0]) * s, (y + da[1]) * s) for x, y in t] for t in e['tramos']]
                n['grosor'] = max(3, e['ancho'] * s + 4)
            if e['tipo'] == 'texto':
                n['n'] = e['n']
            salida.append(n)
        return salida


def duracion_elemento(e):
    if e['tipo'] == 'trazo':
        largo = sum(math.dist(a, b) for t in e['tramos'] for a, b in zip(t, t[1:]))
        return min(2.2, max(0.25, largo / 650))
    if e['tipo'] == 'texto':
        return min(1.2, max(0.25, 0.07 * e['n']))
    return 0.3


def dibujar_mascara(mascara, e, u):
    """Revela la fracción u (0-1) del elemento en la máscara: los trazos se
    recorren y los textos y rellenos se descubren de izquierda a derecha."""
    d = ImageDraw.Draw(mascara)
    if e['tipo'] == 'trazo':
        total = sum(math.dist(a, b) for t in e['tramos'] for a, b in zip(t, t[1:])) or 1
        queda = u * total
        for t in e['tramos']:
            puntos = [t[0]]
            for a, b in zip(t, t[1:]):
                seg = math.dist(a, b)
                if queda <= 0:
                    break
                if seg <= queda:
                    puntos.append(b)
                    queda -= seg
                else:
                    f = queda / seg
                    puntos.append((a[0] + (b[0] - a[0]) * f, a[1] + (b[1] - a[1]) * f))
                    queda = 0
            if len(puntos) > 1:
                d.line(puntos, fill=255, width=int(e['grosor']), joint='curve')
                r = e['grosor'] / 2
                for p in (puntos[0], puntos[-1]):
                    d.ellipse([p[0] - r, p[1] - r, p[0] + r, p[1] + r], fill=255)
            if queda <= 0:
                break
    else:
        x0, y0, x1, y1 = e['caja']
        d.rectangle([x0 - 3, y0 - 3, x0 - 3 + (x1 - x0 + 6) * u, y1 + 3], fill=255)


# --- Fórmulas y texto de pizarra ------------------------------------------------------------
def formula_png(formula, color, carpeta):
    h = huella(formula, color)
    png = os.path.join(carpeta, f'f-{h}.png')
    if os.path.exists(png):
        return png
    tex = os.path.join(carpeta, f'f-{h}.tex')
    rgb = '{:02X}{:02X}{:02X}'.format(*color)
    with open(tex, 'w', encoding='utf-8') as f:
        f.write('\\documentclass[border=4pt]{standalone}\n\\usepackage{amsmath,amssymb}\\usepackage{newpxtext,newpxmath}\n'
                f'\\usepackage{{xcolor}}\\definecolor{{tinta}}{{HTML}}{{{rgb}}}\n'
                f'\\begin{{document}}\\color{{tinta}}$\\displaystyle {formula}$\\end{{document}}\n')
    cod, _ = ejecutar([os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
                       os.path.basename(tex)], cwd=carpeta, env=entorno_tex(), timeout=300, comprobar=False)
    if cod != 0:
        raise RuntimeError(f'Error en la fórmula {formula!r}:\n' + '\n'.join(errores_log(tex[:-4] + '.log')))
    fitz.open(tex[:-4] + '.pdf')[0].get_pixmap(dpi=300, alpha=True).save(png)
    return png


def partir(texto, fuente_, ancho):
    palabras, lineas, actual = texto.split(), [], ''
    medidor = ImageDraw.Draw(Image.new('L', (1, 1)))
    for p in palabras:
        prueba = (actual + ' ' + p).strip()
        if medidor.textlength(prueba, font=fuente_) <= ancho or not actual:
            actual = prueba
        else:
            lineas.append(actual)
            actual = p
    if actual:
        lineas.append(actual)
    return lineas


# --- Pizarra -----------------------------------------------------------------------------
class Pizarra:
    """Lo que hay escrito en la pizarra y dónde. Tres paneles; cada elemento va
    debajo de lo último que hay en sus paneles."""

    def __init__(self, tema, carpeta):
        self.tema, self.carpeta = tema, carpeta
        ancho = (PZ_X1 - PZ_X0) / 3
        self.paneles = {i: (PZ_X0 + (i - 1) * ancho, PZ_X0 + i * ancho) for i in (1, 2, 3)}
        self.elementos = []           # dicts: tipo, paneles, imagen (RGBA), pos, y_fin, [grafico]
        self.cursor = {1: PZ_Y0 + PZ_MARGEN, 2: PZ_Y0 + PZ_MARGEN, 3: PZ_Y0 + PZ_MARGEN}
        self.graficos = {}
        self.avisos = []

    @staticmethod
    def zona(z):
        z = str(z if z is not None else 1)
        m = re.fullmatch(r'(\d)(?:-(\d))?', z)
        if not m:
            raise ValueError(f'Zona de pizarra no válida: {z!r} (1, 2, 3, "1-2", "2-3", "1-3")')
        a, b = int(m.group(1)), int(m.group(2) or m.group(1))
        return list(range(a, b + 1))

    def borrar(self, cuales):
        paneles = [1, 2, 3] if cuales is True else [int(c) for c in (cuales if isinstance(cuales, list) else [cuales])]
        self.elementos = [e for e in self.elementos if not set(e['paneles']) & set(paneles)]
        for nombre, g in list(self.graficos.items()):
            if set(g['paneles']) & set(paneles):
                del self.graficos[nombre]
        for p in paneles:
            ocupado = [e['y_fin'] for e in self.elementos if p in e['paneles']]
            self.cursor[p] = max(ocupado) + 14 if ocupado else PZ_Y0 + PZ_MARGEN

    def _sitio(self, paneles, alto):
        x0 = self.paneles[paneles[0]][0] + PZ_MARGEN
        x1 = self.paneles[paneles[-1]][1] - PZ_MARGEN
        y = max(self.cursor[p] for p in paneles)
        if y + alto > PZ_Y1 - 10:
            self.avisos.append(f'La pizarra se llena en el panel {paneles}: hay que borrar antes')
        return x0, x1, y

    def _ocupar(self, paneles, y_fin):
        for p in paneles:
            self.cursor[p] = y_fin + 14

    def anadir(self, accion):
        """Coloca un elemento y devuelve la animación que lo dibuja: (caja, capa_final, elementos, duración)."""
        color = ROTULADOR.get(accion.get('color', ''), None)
        if 'escribe' in accion:
            texto = str(accion['escribe'])
            paneles = self.zona(accion.get('zona'))
            titulo = texto.startswith('#')
            nivel = len(texto) - len(texto.lstrip('>'))
            texto = texto.lstrip('#> ').strip()
            f = F_PIZ_T if titulo else F_PIZ
            color = color or (ROTULADOR['rojo'] if titulo else ROTULADOR['azul'])
            x0, x1, y = self._sitio(paneles, 60)
            sangria = 40 * nivel
            lineas = partir(('– ' if nivel else '') + texto, f, x1 - x0 - sangria)
            alto = 58 * len(lineas) + (10 if titulo else 0)
            img = Image.new('RGBA', (int(x1 - x0), alto), (0, 0, 0, 0))
            d = ImageDraw.Draw(img)
            for i, l in enumerate(lineas):
                d.text((sangria, i * 58), l, font=f, fill=color + (255,))
            if titulo:
                largo = max(d.textlength(l, font=f) for l in lineas)
                d.line([(sangria, alto - 8), (sangria + largo, alto - 6)], fill=color + (255,), width=4)
            pos = (int(x0), int(y))
            self._ocupar(paneles, y + alto)
            self.elementos.append({'paneles': paneles, 'imagen': img, 'pos': pos, 'y_fin': y + alto})
            partes = [{'tipo': 'texto', 'caja': (sangria, i * 58, sangria + d.textlength(l, font=f), i * 58 + 58),
                       'n': len(l)} for i, l in enumerate(lineas)]
            for p in partes:
                p['dur'] = min(2.5, max(0.5, len(texto) / 18 / len(lineas)))
            return pos, img, None, partes
        if 'formula' in accion:
            paneles = self.zona(accion.get('zona'))
            png = formula_png(accion['formula'], color or ROTULADOR['negro'], self.carpeta)
            img = Image.open(png).convert('RGBA')
            x0, x1, y = self._sitio(paneles, 80)
            escala = min(accion.get('tam', 1.0) * 0.8, (x1 - x0) / img.width)
            img = img.resize((max(1, int(img.width * escala)), max(1, int(img.height * escala))), Image.LANCZOS)
            pos = (int(x0 + (x1 - x0 - img.width) / 2) if accion.get('centrar', True) else int(x0), int(y))
            self._ocupar(paneles, y + img.height)
            self.elementos.append({'paneles': paneles, 'imagen': img, 'pos': pos, 'y_fin': y + img.height})
            parte = {'tipo': 'relleno', 'caja': (0, 0, img.width, img.height),
                     'dur': min(3.5, max(0.8, img.width / 420))}
            return pos, img, None, [parte]
        if 'imagen' in accion:
            paneles = self.zona(accion.get('zona'))
            img = Image.open(os.path.join(self.tema.dir, accion['imagen'])).convert('RGBA')
            x0, x1, y = self._sitio(paneles, 200)
            alto = (PZ_Y1 - y - 10) * float(accion.get('alto', 1.0))
            escala = min((x1 - x0) / img.width, alto / img.height)
            img = img.resize((max(1, int(img.width * escala)), max(1, int(img.height * escala))), Image.LANCZOS)
            pos = (int(x0 + (x1 - x0 - img.width) / 2), int(y))
            self._ocupar(paneles, y + img.height)
            self.elementos.append({'paneles': paneles, 'imagen': img, 'pos': pos, 'y_fin': y + img.height})
            return pos, img, None, [{'tipo': 'relleno', 'caja': (0, 0, img.width, img.height), 'dur': 0.6}]
        if 'grafico' in accion:
            nombre = accion['grafico']
            capa = int(accion.get('capa', 1000))
            if nombre not in self.graficos:
                paneles = self.zona(accion.get('zona'))
                x0, x1, y = self._sitio(paneles, 300)
                alto = (PZ_Y1 - y - 10) * float(accion.get('alto', 1.0))
                g = Grafico(self.tema, nombre, self.carpeta, (x0, y, x1, y + alto))
                self._ocupar(paneles, y + g.h)
                elem = {'paneles': paneles, 'imagen': None, 'pos': (g.x, g.y), 'y_fin': y + g.h, 'grafico': g}
                self.elementos.append(elem)
                self.graficos[nombre] = {'g': g, 'paneles': paneles, 'elem': elem}
            g = self.graficos[nombre]['g']
            antes = g.capa
            partes = g.nuevos(antes, capa)
            previa = g.imagen(antes)
            g.capa = capa
            for p in partes:
                p['dur'] = duracion_elemento(p)
            return (g.x, g.y), g.imagen(), previa, partes
        raise ValueError(f'Acción de pizarra desconocida: {accion}')

    def pintar(self, img):
        """Dibuja la pizarra con todo lo que hay en ella sobre img (pantalla completa)."""
        d = ImageDraw.Draw(img)
        d.rounded_rectangle([PZ_X0 - 14, PZ_Y0 - 14, PZ_X1 + 14, PZ_Y1 + 14], radius=10, fill=MARCO)
        d.rectangle([PZ_X0, PZ_Y0, PZ_X1, PZ_Y1], fill=PIZARRA)
        for i in (2, 3):
            x = self.paneles[i][0]
            d.line([(x, PZ_Y0 + 6), (x, PZ_Y1 - 6)], fill=(226, 228, 232), width=3)
        for e in self.elementos:
            capa = e['grafico'].imagen() if e.get('grafico') else e['imagen']
            img.paste(capa, e['pos'], capa)


# --- Pantallas -----------------------------------------------------------------------------
class Pantallas:
    def __init__(self, tema, guion, titulo, corto):
        self.tema, self.titulo, self.corto = tema, titulo, corto
        self.bloques = guion['bloques']
        self.escenas = guion['escenas']
        total = sum(b.get('minutos', 1) for b in self.bloques)
        # Cada bloque ocupa en la cabecera lo que dura (como mínimo 180 px)
        anchos = [max(180, (ANCHO - 60) * b.get('minutos', 1) / total) for b in self.bloques]
        f = (ANCHO - 60) / sum(anchos)
        x = 30
        self.celdas = []
        for a in anchos:
            self.celdas.append((x, x + a * f))
            x += a * f
        self.escenas_bloque = {b['nombre']: [i for i, e in enumerate(self.escenas) if e['bloque'] == b['nombre']]
                               for b in self.bloques}
        for i, e in enumerate(self.escenas):
            if e['bloque'] not in self.escenas_bloque:
                raise ValueError(f'La escena {i + 1} es del bloque «{e["bloque"]}», que no está en «bloques»')

    def cabecera(self, escena, t, total):
        img = Image.new('RGB', (ANCHO, CAB), MORADO)
        d = ImageDraw.Draw(img)
        e = self.escenas[escena]
        izq = f'Tema {self.tema.codigo}'
        d.text((30, 14), izq, font=F_BARRA, fill='white')
        x = 30 + d.textlength(izq, font=F_BARRA) + 22
        sub = e.get('titulo') or e['bloque']
        d.text((x, 14), sub, font=F_BARRA_L, fill=(236, 226, 246))
        reloj = f'{mmss(t)} / {mmss(total)}   ·   quedan {mmss(total - t)}'
        d.text((ANCHO - 30 - d.textlength(reloj, font=F_BARRA_L), 14), reloj, font=F_BARRA_L, fill=(236, 226, 246))
        # Bloques con un punto por apartado (como los «miniframes» de Beamer)
        d.rectangle([0, 60, ANCHO, CAB - 6], fill=MORADO_OSCURO)
        for (x0, x1), b in zip(self.celdas, self.bloques):
            indices = self.escenas_bloque[b['nombre']]
            actual = escena in indices
            pasado = indices and escena > max(indices)
            color = (255, 255, 255) if actual else ((196, 178, 214) if pasado else (140, 118, 160))
            nombre = b['nombre']
            fnt = F_UI_N if actual else F_UI
            while d.textlength(nombre, font=fnt) > x1 - x0 - 16 and len(nombre) > 4:
                nombre = nombre[:-2].rstrip() + '…' if not nombre.endswith('…') else nombre[:-2] + '…'
            d.text((x0 + 8, 64), nombre, font=fnt, fill=color)
            for j, k in enumerate(indices):
                cx, cy, r = x0 + 16 + j * 18, 101, 5
                if k < escena:
                    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(196, 178, 214))
                elif k == escena:
                    d.ellipse([cx - r - 1, cy - r - 1, cx + r + 1, cy + r + 1], fill=SALVIA)
                else:
                    d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(140, 118, 160), width=2)
        # Barra de progreso
        d.rectangle([0, CAB - 6, ANCHO, CAB], fill=(90, 60, 112))
        d.rectangle([0, CAB - 6, int(ANCHO * min(1, t / total)), CAB], fill=SALVIA_OSCURO)
        return img

    def portada(self):
        img = Image.new('RGB', (ANCHO, ALTO), MORADO)
        d = ImageDraw.Draw(img)
        d.text((ANCHO / 2, 330), f'Tema {self.tema.codigo}', font=F_TITULO, fill='white', anchor='mm')
        y = 450
        for l in partir(self.titulo, F_SUBTITULO, 1500):
            d.text((ANCHO / 2, y), l, font=F_SUBTITULO, fill=(236, 226, 246), anchor='mm')
            y += 60
        d.text((ANCHO / 2, ALTO - 150), 'Cante del tema · 30 minutos', font=F_BARRA_L, fill=SALVIA, anchor='mm')
        d.text((ANCHO / 2, ALTO - 100), 'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es', font=F_UI,
               fill=(220, 210, 230), anchor='mm')
        return img

    def cierre(self):
        img = Image.new('RGB', (ANCHO, ALTO), MORADO)
        d = ImageDraw.Draw(img)
        d.text((ANCHO / 2, 400), 'Fin de la exposición', font=F_TITULO, fill='white', anchor='mm')
        d.text((ANCHO / 2, 500), f'Tema {self.tema.codigo}: {self.corto}', font=F_SUBTITULO,
               fill=(236, 226, 246), anchor='mm')
        d.text((ANCHO / 2, 640), 'El tema completo (web, PDF y Word) y el resto del temario en',
               font=F_UI, fill=(220, 210, 230), anchor='mm')
        d.text((ANCHO / 2, 690), 'victorgutierrezmarcos.es', font=F_BARRA, fill=SALVIA, anchor='mm')
        return img


def pintar_guion(img, escena, estado):
    """Hoja del guion: lo que se dice sin pizarra, en viñetas que aparecen al decirlas."""
    d = ImageDraw.Draw(img)
    d.rectangle([0, CAB, ANCHO, ALTO], fill=(236, 236, 232))
    d.rounded_rectangle([110, CAB + 22, ANCHO - 110, ALTO - 22], radius=14, fill=PAPEL, outline=(214, 212, 205))
    etiqueta = 'GUION  ·  se expone sin pizarra'
    w = d.textlength(etiqueta, font=F_APUNTE_E)
    d.rounded_rectangle([ANCHO - 140 - w - 24, CAB + 40, ANCHO - 140, CAB + 74], radius=16, fill=SALVIA)
    d.text((ANCHO - 140 - w - 12, CAB + 44), etiqueta, font=F_APUNTE_E, fill=(60, 90, 50))
    d.text((170, CAB + 50), escena.get('titulo') or escena['bloque'], font=F_GUION_T, fill=MORADO)
    x0, y, ancho = 180, CAB + 135, ANCHO - 400
    # Líneas a pintar: partes de la estructura (todas desde el principio, en gris
    # las que aún no han llegado) y las viñetas de cada una
    lineas = []
    for parte in estado['partes']:
        if parte['nombre'] is not None:
            lineas.append(('parte', parte['nombre'], parte['estado']))
        for texto in parte['lineas']:
            lineas.append(('linea', texto, None))
    # Si no cabe, se pliegan las partes ya dichas (solo su título)
    alto_disp = ALTO - 50 - y

    def medir(ls):
        h = 0
        for tipo, texto, _ in ls:
            if tipo == 'parte':
                h += 56
            else:
                nivel = len(texto) - len(texto.lstrip('>'))
                h += 48 * len(partir(texto.lstrip('> '), F_GUION, ancho - 60 - 50 * nivel)) + 6
        return h

    plegadas = set()
    for i, parte in enumerate(estado['partes']):
        if medir(lineas) <= alto_disp:
            break
        if parte['estado'] == 'hecha':
            plegadas.add(i)
            lineas = []
            for j, p in enumerate(estado['partes']):
                if p['nombre'] is not None:
                    lineas.append(('parte', p['nombre'], p['estado']))
                if j not in plegadas:
                    lineas.extend(('linea', t, None) for t in p['lineas'])
    while medir(lineas) > alto_disp and any(t == 'linea' for t, _, _ in lineas):
        k = next(i for i, l in enumerate(lineas) if l[0] == 'linea')
        lineas.pop(k)
    ultima = estado.get('ultima')
    for tipo, texto, est in lineas:
        if tipo == 'parte':
            color = MORADO if est == 'actual' else ((150, 120, 175) if est == 'hecha' else (190, 186, 196))
            d.rectangle([x0, y + 16, x0 + 14, y + 30], fill=color)
            d.text((x0 + 30, y), texto, font=F_GUION_N, fill=color)
            y += 56
        else:
            nivel = len(texto) - len(texto.lstrip('>'))
            limpio = texto.lstrip('> ')
            xi = x0 + 40 + 50 * nivel
            filas = partir(limpio, F_GUION, ancho - 60 - 50 * nivel)
            if texto == ultima:
                d.rounded_rectangle([xi - 14, y - 4, x0 + ancho + 20, y + 48 * len(filas) + 2], radius=8,
                                    fill=MORADO_PALIDO)
            d.text((xi, y), '–' if nivel == 0 else '·', font=F_GUION_N, fill=MORADO)
            for fila in filas:
                d.text((xi + 32, y), fila, font=F_GUION, fill=TINTA)
                y += 48
            y += 6


def pintar_apunte(img, texto):
    d = ImageDraw.Draw(img)
    d.rectangle([0, APUNTE_Y - 8, ANCHO, ALTO], fill=(236, 236, 232))
    if not texto:
        return
    d.rounded_rectangle([44, APUNTE_Y, ANCHO - 44, ALTO - 12], radius=10, fill=SALVIA)
    d.text((66, APUNTE_Y + 20), 'APUNTE', font=F_APUNTE_E, fill=(60, 90, 50))
    fila = partir(texto, F_APUNTE, ANCHO - 260)[0]
    d.text((170, APUNTE_Y + 12), fila, font=F_APUNTE, fill=(40, 60, 35))


# --- Montaje ---------------------------------------------------------------------------------
def leer_pcm(ruta):
    return open(ruta, 'rb').read()


def silencio(segundos):
    return b'\x00\x00' * int(round(segundos * MUESTREO))


def srt_tiempo(s):
    h, s = divmod(s, 3600)
    m, s = divmod(s, 60)
    return f'{int(h):02d}:{int(m):02d}:{s:06.3f}'.replace('.', ',')


def yt_tiempo(s):
    m, s = divmod(int(s), 60)
    h, m = divmod(m, 60)
    return f'{h}:{m:02d}:{s:02d}' if h else f'{m}:{s:02d}'


def frases(texto):
    return [f.strip() for f in re.split(r'(?<=[.!?…])\s+(?=[«¿¡A-ZÁÉÍÓÚÑ0-9])', texto) if f.strip()]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--borrador', action='store_true',
                    help='sin voz (la duración se estima por palabras) para revisar la imagen deprisa')
    ap.add_argument('--tramo', help='solo ese trozo del vídeo, p. ej. 0:00-3:00 (para probar)')
    ap.add_argument('--escenas', help='otro escenas.yaml (para pruebas)')
    ap.add_argument('--medir', action='store_true',
                    help='solo genera la voz y dice cuánto dura la narración y cuánto hay que ajustar el ritmo')
    ap.add_argument('--ffmpeg', default=None)
    args = ap.parse_args()
    tema = Tema(args.tema)
    import imageio_ffmpeg
    ffmpeg = args.ffmpeg or imageio_ffmpeg.get_ffmpeg_exe()

    guion = yaml.safe_load(open(args.escenas or os.path.join(tema.dir, 'video', 'escenas.yaml'), encoding='utf-8'))
    voz = {**VOZ_DEFECTO, **(guion.get('voz') or {})} if isinstance(guion.get('voz'), dict) else dict(VOZ_DEFECTO)
    total = float(guion.get('duracion', 1800))
    titulo = guion.get('titulo') or tema.titulo()
    corto = guion.get('titulo_corto') or re.split(r'[.:]', titulo)[0].strip()
    diccionario = yaml.safe_load(open(PRONUNCIACION, encoding='utf-8')) if os.path.exists(PRONUNCIACION) else {}
    diccionario = {**(diccionario or {}), **(guion.get('pronunciacion') or {})}
    carpeta = os.path.join(tema.trabajo, 'video')
    os.makedirs(carpeta, exist_ok=True)
    pantallas = Pantallas(tema, guion, titulo, corto)
    escenas = guion['escenas']

    # 1. Voz de cada paso (y del título, al principio) ------------------------------------
    lectura_titulo = guion.get('lectura_titulo') or f'Tema {tema.codigo.replace(".", " ")}. {titulo}'
    dichos = [lectura_titulo] + [p.get('di', '').strip() for e in escenas for p in e.get('pasos', [])]
    if args.borrador:
        duraciones = [max(1.0, len(t.split()) / 2.75) if t else 0 for t in dichos]
        audios = [None] * len(dichos)
    else:
        con_texto = [pronunciar(t, diccionario) for t in dichos if t]
        rutas = iter(sintetizar_todos(con_texto, voz, carpeta, ffmpeg))
        audios = [next(rutas) if t else None for t in dichos]
        duraciones = [os.path.getsize(a) / 2 / MUESTREO if a else 0 for a in audios]

    # 2. Línea de tiempo natural y ajuste a la duración exacta ------------------------------
    pasos = []           # (escena, paso, inicio natural, duración natural, índice de audio)
    t = duraciones[0] + PAUSA_BLOQUE
    portada_fin = t
    k = 1
    for i, e in enumerate(escenas):
        for p in e.get('pasos', []):
            dur = duraciones[k] if dichos[k] else 1.2
            pasos.append({'escena': i, 'paso': p, 'inicio': t, 'dur': dur, 'audio': k})
            t += dur + PAUSA_PASO
            k += 1
        siguiente = escenas[i + 1] if i + 1 < len(escenas) else None
        t += (PAUSA_BLOQUE if not siguiente or siguiente['bloque'] != e['bloque'] else PAUSA_APARTADO) - PAUSA_PASO
    natural = t
    factor = natural / (total - CIERRE)
    print(f'Narración natural: {mmss(natural)}; ritmo ajustado ×{factor:.3f} para durar {mmss(total)}', flush=True)
    if not 0.9 <= factor <= 1.12:
        print(f'  AVISO: el guion es {"largo" if factor > 1 else "corto"} para {mmss(total)}: '
              f'conviene {"recortar" if factor > 1 else "alargar"} unas {abs(int((natural - total + CIERRE) * 2.6))} '
              f'palabras', flush=True)
    if args.medir:
        palabras = sum(len(re.findall(r'\w+', d)) for d in dichos)
        objetivo = int(palabras / factor)
        print(f'MEDIDA: {palabras} palabras; narración natural {mmss(natural)}; ritmo ×{factor:.3f}. '
              f'Para ritmo ×1,00 harían falta unas {objetivo} palabras ({objetivo - palabras:+d}).')
        return
    escala = 1 / factor
    portada_fin *= escala
    for p in pasos:
        p['inicio'] *= escala
        p['dur'] *= escala
    for a, b in zip(pasos, pasos[1:]):
        b['previo_fin'] = a['inicio'] + a['dur']
    contenido_fin = total - CIERRE

    # 3. Audio completo ---------------------------------------------------------------------
    audio_wav = os.path.join(carpeta, 'audio-completo.wav')
    if not args.borrador:
        crudo = bytearray()
        crudo += leer_pcm(audios[0]) + silencio(PAUSA_BLOQUE)
        for p in pasos:
            if p['audio'] and audios[p['audio']]:
                crudo += leer_pcm(audios[p['audio']])
            else:
                crudo += silencio(1.2)
            sig = next((q for q in pasos if q['inicio'] > p['inicio']), None)
            if sig is None:
                crudo += silencio(PAUSA_BLOQUE)
            else:
                crudo += silencio(max(0.0, (sig['inicio'] - p['inicio']) * factor - p['dur'] * factor))
        crudo_ruta = os.path.join(carpeta, 'audio-natural.pcm')
        open(crudo_ruta, 'wb').write(crudo)
        subprocess.run([ffmpeg, '-y', '-loglevel', 'error', '-f', 's16le', '-ar', str(MUESTREO), '-ac', '1',
                        '-i', crudo_ruta, '-af', f'atempo={factor:.6f},apad', '-t', f'{total:.3f}',
                        '-ar', str(MUESTREO), audio_wav], check=True)

    # 4. Imágenes ---------------------------------------------------------------------------
    pizarra = Pizarra(tema, carpeta)
    tramo = (0, total)
    if args.tramo:
        a, b = args.tramo.split('-')
        tramo = tuple(sum(float(x) * 60 ** i for i, x in enumerate(reversed(v.split(':')))) for v in (a, b))

    os.makedirs(SALIDA, exist_ok=True)
    sufijo = '-borrador' if args.borrador else ''
    if args.tramo or args.escenas:
        sufijo += '-prueba'
    mp4 = os.path.join(SALIDA, f'{tema.archivo}{sufijo}.mp4')
    entradas = ['-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{ANCHO}x{ALTO}', '-r', str(FPS), '-i', '-']
    if not args.borrador:
        entradas += ['-ss', f'{tramo[0]:.3f}', '-t', f'{tramo[1] - tramo[0]:.3f}', '-i', audio_wav]
    salida_ff = ['-c:v', 'libx264', '-preset', 'veryfast', '-crf', '21', '-pix_fmt', 'yuv420p']
    if not args.borrador:
        salida_ff += ['-c:a', 'aac', '-b:a', '160k', '-map', '0:v', '-map', '1:a']
    proceso = subprocess.Popen([ffmpeg, '-y', '-loglevel', 'error', *entradas, *salida_ff,
                                '-t', f'{tramo[1] - tramo[0]:.3f}', '-movflags', '+faststart', mp4],
                               stdin=subprocess.PIPE)
    marcos_tramo = (int(round(tramo[0] * FPS)), int(round(tramo[1] * FPS)))
    marco = 0
    cabeceras = {}

    def emitir(cuerpo_bytes, escena_i, hasta, completo=False):
        """Escribe fotogramas hasta el instante «hasta» con ese cuerpo."""
        nonlocal marco
        fin = min(int(round(hasta * FPS)), int(round(total * FPS)))
        while marco < fin:
            if marcos_tramo[0] <= marco < marcos_tramo[1]:
                if completo:
                    proceso.stdin.write(cuerpo_bytes)
                else:
                    seg = int(marco / FPS)
                    clave = (escena_i, seg)
                    if clave not in cabeceras:
                        cabeceras.clear()
                        cabeceras[clave] = pantallas.cabecera(escena_i, seg, total).tobytes()
                    proceso.stdin.write(cabeceras[clave] + cuerpo_bytes)
            marco += 1

    def cuerpo(img):
        return img.crop((0, CAB, ANCHO, ALTO)).tobytes()

    def en_tramo(t0, t1):
        return t1 >= tramo[0] and t0 <= tramo[1]

    # Portada (se lee el título)
    emitir(pantallas.portada().tobytes(), 0, portada_fin, completo=True)

    vacia = Image.new('RGB', (ANCHO, ALTO), (236, 236, 232))
    Pizarra(tema, carpeta).pintar(vacia)
    estado_guion = None
    pantalla = None          # imagen completa actual (sin cabecera válida)
    subtitulos, capitulos = [], [(0.0, 'Título')]
    escena_actual = -1
    apunte = None
    for n, p in enumerate(pasos):
        e = escenas[p['escena']]
        paso = p['paso']
        t0, dur = p['inicio'], p['dur']
        t_fin = pasos[n + 1]['inicio'] if n + 1 < len(pasos) else contenido_fin
        nueva_escena = p['escena'] != escena_actual
        if nueva_escena:
            escena_actual = p['escena']
            capitulos.append((t0, e.get('titulo') or e['bloque']))
            apunte = None
            if e.get('modo', 'pizarra') == 'guion':
                estructura = e.get('estructura') or []
                estado_guion = {'partes': [{'nombre': x, 'estado': 'pendiente', 'lineas': []} for x in estructura],
                                'ultima': None}
                if not estructura:
                    estado_guion['partes'].append({'nombre': None, 'estado': 'actual', 'lineas': []})
        modo = e.get('modo', 'pizarra')
        if paso.get('di'):
            fr = frases(paso['di'])
            largo = sum(len(f) for f in fr) or 1
            ti = t0
            for f in fr:
                tf = ti + dur * len(f) / largo
                subtitulos.append((ti, tf, f))
                ti = tf

        previa = pantalla
        animaciones = []            # (inicio relativo, duración, función(u) → imagen)
        if modo == 'guion':
            if paso.get('parte'):
                encontrada = False
                for parte in estado_guion['partes']:
                    if parte['nombre'] == paso['parte']:
                        parte['estado'] = 'actual'
                        encontrada = True
                    elif parte['estado'] == 'actual':
                        parte['estado'] = 'hecha'
                if not encontrada:
                    for parte in estado_guion['partes']:
                        if parte['estado'] == 'actual':
                            parte['estado'] = 'hecha'
                    estado_guion['partes'].append({'nombre': paso['parte'], 'estado': 'actual', 'lineas': []})
            nuevas = paso.get('guion') or []
            if isinstance(nuevas, str):
                nuevas = [nuevas]
            destino = next((x for x in estado_guion['partes'] if x['estado'] == 'actual'), estado_guion['partes'][-1])
            for linea in nuevas:
                destino['lineas'].append(str(linea))
                estado_guion['ultima'] = str(linea)
            img = Image.new('RGB', (ANCHO, ALTO), PAPEL)
            pintar_guion(img, e, estado_guion)
            pantalla = img
            if previa is not None:
                animaciones.append((0, FUNDIDO, lambda u, a=previa, b=img: Image.blend(a, b, u)))
        else:
            if paso.get('apunte') is not None:
                apunte = paso.get('apunte') or None
            if paso.get('borrar'):
                pizarra.borrar(paso['borrar'])
            base = Image.new('RGB', (ANCHO, ALTO), (236, 236, 232))
            pizarra.pintar(base)
            pintar_apunte(base, apunte)
            inicio_rel = 0.0
            if previa is not None and (nueva_escena or paso.get('borrar')):
                animaciones.append((0, FUNDIDO, lambda u, a=previa, b=base.copy(): Image.blend(a, b, u)))
                inicio_rel = FUNDIDO
            acciones = paso.get('pizarra') or []
            if isinstance(acciones, dict):
                acciones = [acciones]
            dibujos = []
            for accion in acciones:
                pos, final, antes, partes = pizarra.anadir(accion)
                dibujos.append((pos, final, antes, partes))
            # Ajusta la velocidad para que lo dibujado quepa en el 90 % del paso
            necesario = sum(x['dur'] for _, _, _, partes in dibujos for x in partes)
            disponible = max(0.5, 0.9 * (t_fin - t0) - inicio_rel)
            ritmo = min(1.0, disponible / necesario) if necesario else 1.0
            if ritmo < 0.5:
                pizarra.avisos.append(f'{mmss(t0)} («{(paso.get("di") or "")[:40]}…»): el dibujo va {1 / ritmo:.1f} '
                                      f'veces más rápido de lo natural; repartirlo en más pasos o capas')
            estado = base
            # Cada elemento se revela sobre la pizarra vacía de su caja (los elementos
            # no se solapan): «antes» es como estaba y «final» como queda
            for pos, final, antes, partes in dibujos:
                caja = (pos[0], pos[1], pos[0] + final.width, pos[1] + final.height)
                fondo_caja = vacia.crop(caja).convert('RGBA')
                parche_antes = fondo_caja.copy()
                if antes is not None:
                    parche_antes.alpha_composite(antes)
                parche_final = fondo_caja.copy()
                parche_final.alpha_composite(final)
                # El estado de partida: la pizarra con este elemento como estaba antes
                estado = estado.copy()
                estado.paste(parche_antes.convert('RGB'), caja[:2])
                mascara = Image.new('L', final.size, 0)
                for parte in partes:
                    d_parte = parte['dur'] * ritmo
                    if True:
                        def f(u, est=estado, pa=parche_antes, pf=parche_final, m=mascara, pt=parte, c=caja):
                            mm = m.copy()
                            dibujar_mascara(mm, pt, u)
                            img = est.copy()
                            img.paste(Image.composite(pf, pa, mm).convert('RGB'), c[:2])
                            return img
                        animaciones.append((inicio_rel, d_parte, f))
                    dibujar_mascara(mascara, parte, 1.0)
                    inicio_rel += d_parte
                    # Tras cada parte, el estado ya la incluye
                    estado = estado.copy()
                    estado.paste(Image.composite(parche_final, parche_antes, mascara).convert('RGB'), caja[:2])
            pantalla = Image.new('RGB', (ANCHO, ALTO), (236, 236, 232))
            pizarra.pintar(pantalla)
            pintar_apunte(pantalla, apunte)
        # Emite: animaciones en su momento y la pantalla final el resto del paso
        ultimo = previa if previa is not None else pantalla
        for ini, d_an, f in animaciones:
            emitir(cuerpo(ultimo), p['escena'], t0 + ini)
            n_marcos = max(1, int(round(d_an * FPS)))
            for j in range(n_marcos):
                if marcos_tramo[0] <= marco < marcos_tramo[1]:
                    ultimo = f(min(1.0, (j + 1) / n_marcos))
                    emitir(cuerpo(ultimo), p['escena'], (marco + 1) / FPS)
                else:
                    marco += 1
        emitir(cuerpo(pantalla), p['escena'], t_fin)
        if n % 10 == 0:
            print(f'  {mmss(t0)} · {e.get("titulo") or e["bloque"]}', flush=True)

    # Cierre en silencio hasta el final exacto
    emitir(pantallas.cierre().tobytes(), escena_actual, total, completo=True)
    proceso.stdin.close()
    proceso.wait()
    if proceso.returncode != 0:
        raise RuntimeError('ffmpeg falló al montar el vídeo')
    for aviso in dict.fromkeys(pizarra.avisos):
        print('AVISO:', aviso)
    json.dump({'factor_ritmo': round(factor, 3), 'narracion_natural': round(natural, 1),
               'avisos': list(dict.fromkeys(pizarra.avisos))},
              open(os.path.join(carpeta, 'informe-video.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)

    base_salida = os.path.join(SALIDA, f'{tema.archivo}{sufijo}')
    with open(base_salida + '.srt', 'w', encoding='utf-8') as f:
        f.write(f'1\n{srt_tiempo(0)} --> {srt_tiempo(portada_fin - 0.2)}\n{lectura_titulo}\n\n')
        for i, (a, b, texto) in enumerate(subtitulos, 2):
            f.write(f'{i}\n{srt_tiempo(a)} --> {srt_tiempo(b)}\n{texto}\n\n')
    with open(base_salida + '-youtube.txt', 'w', encoding='utf-8') as f:
        # YouTube admite 100 caracteres en el título: si no cabe, solo hasta el primer punto
        titulo_yt = f'Tema {tema.codigo}: {titulo} | Cante (Oposición TCEE)'
        if len(titulo_yt) > 100:
            titulo_yt = f'Tema {tema.codigo}: {titulo.split(". ")[0].rstrip(".")} | Cante TCEE'
        f.write(f'{titulo_yt[:100]}\n\n{titulo}\n\n')
        f.write(f'Exposición oral (cante) del tema {tema.codigo} de la oposición a Técnico Comercial y Economista '
                f'del Estado, en 30 minutos, con el guion y la pizarra.\n\n'
                f'Tema completo (web, PDF y Word): https://www.victorgutierrezmarcos.es/oposicion/temario/'
                f'{tema.carpeta}/{tema.archivo}.html\n\nCapítulos:\n')
        vistos = []
        for inicio, nombre in capitulos:
            if vistos and inicio - vistos[-1][0] < 10:
                continue
            vistos.append((inicio, nombre))
        for inicio, nombre in vistos:
            f.write(f'{yt_tiempo(inicio)} {nombre}\n')
        motor = 'voz sintética (Microsoft Edge TTS)' if voz.get('motor') == 'edge' else 'voz sintética clonada'
        f.write(f'\nNarración con {motor}. Material de preparación no oficial.\n'
                'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es\n')
    print(f'Vídeo: {mp4} ({mmss(total)}; {len(pasos)} pasos)')


if __name__ == '__main__':
    main()
