#!/usr/bin/env python3
"""
Monta el vídeo promocional de la app (un minuto, 1920 × 1080, con una banda
sonora electrónica propia generada aquí) a partir de las capturas de
app/promo/capturas/.

    python3 scripts/montar-video-app.py [--ffmpeg RUTA] [--solo-fotogramas DIR]

Va al compás de la música (110 pulsaciones por minuto): cada escena dura uno o
varios compases y los cambios caen en el primer tiempo. En lugar de una
sucesión de diapositivas, cada escena tiene su propia composición (frases que
entran palabra a palabra, un móvil que cambia de pantalla, lupas sobre la parte
que importa, bolas que caen, un cronómetro que corre, avisos que llegan…) y
las transiciones varían (barrido dorado, empuje, zoom y corte).

Requisitos: Pillow, numpy y ffmpeg (por ejemplo, el binario estático que trae el
paquete imageio-ffmpeg). Las capturas se regeneran con
`flutter test tool/capturas_test.dart --update-goldens` y, las de DCE,
`flutter test tool/capturas_dce_test.dart --update-goldens`, desde app/.

Salida, en app/promo/: oposicion-tcee.mp4, poster.jpg y una versión ligera de
cada captura (720 px de ancho, WebP) para la página app/index.html. Los PNG
originales de app/promo/capturas/ no se suben al repositorio.

Autor: Víctor Gutiérrez Marcos
"""
import math
import argparse
import os
import tempfile
import shutil
import subprocess
import sys

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROMO = os.path.join(RAIZ, 'app', 'promo')
CAPTURAS = os.path.join(PROMO, 'capturas')
FUENTES = os.path.join(RAIZ, 'app', 'assets', 'fonts')
ICONO = os.path.join(RAIZ, 'app', 'assets', 'icon', 'icon.png')

ANCHO, ALTO, FPS, DURACION = 1920, 1080, 30, 60

# Estética neutra, común a TCEE y DCE (como PaletaNeutra de la app): la de
# styles.css en lo fundamental (Pagella, Source Sans, línea dorada), con un
# berenjena oscuro y una crema que casan con el morado de TCEE y el granate de DCE.
TINTA, TINTA_CLARA = (46, 34, 53), (67, 41, 79)
FONDO, FONDO_2 = (246, 244, 239), (238, 234, 226)
DORADO, DORADO_CLARO = (184, 134, 11), (218, 165, 32)
TEXTO, TEXTO_SUAVE = (45, 45, 45), (85, 85, 85)
BLANCO = (255, 255, 255)


def serif(tam, estilo='bold'):
    return ImageFont.truetype(os.path.join(FUENTES, f'texgyrepagella-{estilo}.otf'), tam)


def sans(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


def suave(x):
    """Curva de salida suave (cúbica) entre 0 y 1."""
    x = max(0.0, min(1.0, x))
    return 1 - (1 - x) ** 3


def degradado(tamano, c1, c2, vertical=False):
    """Degradado lineal entre dos colores."""
    base = Image.linear_gradient('L')
    if not vertical:
        base = base.rotate(90)
    mascara = base.resize(tamano)
    return Image.composite(Image.new('RGB', tamano, c2), Image.new('RGB', tamano, c1), mascara)


def icono(tam, sombra=False):
    """Icono de la app con la forma de los iconos de móvil: esquinas redondeadas
    (22 % del lado) y, sobre fondo oscuro, una sombra suave que lo despega."""
    img = Image.open(ICONO).convert('RGBA').resize((tam, tam), Image.LANCZOS)
    mascara = Image.new('L', (tam, tam), 0)
    ImageDraw.Draw(mascara).rounded_rectangle((0, 0, tam - 1, tam - 1), round(tam * 0.22), fill=255)
    img.putalpha(mascara)
    if not sombra:
        return img
    m = round(tam * 0.18)
    lienzo = Image.new('RGBA', (tam + 2 * m, tam + 2 * m), (0, 0, 0, 0))
    s = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(s).rounded_rectangle((m, m + round(tam * 0.05), m + tam, m + tam + round(tam * 0.05)), round(tam * 0.22), fill=150)
    s = s.filter(ImageFilter.GaussianBlur(tam * 0.08))
    lienzo.paste((10, 5, 15, 255), (0, 0), s)
    lienzo.putalpha(s)
    lienzo.paste(img, (m, m), img)
    return lienzo


def rebote(x):
    """Entrada con un pequeño rebote (easeOutBack), entre 0 y 1."""
    x = max(0.0, min(1.0, x))
    c = 1.70158
    return 1 + (c + 1) * (x - 1) ** 3 + c * (x - 1) ** 2


# Colores del logo: mitad izquierda, TCEE; mitad derecha, DCE.
LOGO = {'fondo_i': (95, 41, 135), 'fondo_d': (122, 31, 75), 'aro_i': (226, 239, 217), 'aro_d': (247, 244, 236)}


def logo_animado(tam, t, sombra=True):
    """El icono montándose: las dos mitades (TCEE y DCE) entran desde los lados
    y se juntan (0-0,7 s), y los anillos de la diana aparecen de fuera adentro
    con un rebote (0,5-1,2 s). Con t ≥ 1,3 es el icono quieto."""
    k = 4  # se dibuja a 4× y se reduce, para que los bordes salgan suaves
    T = tam * k
    capa = Image.new('RGBA', (T, T), (0, 0, 0, 0))
    a = suave(t / 0.7)
    desp = round(T * 0.55 * (1 - a))
    mitad_i = Image.new('RGBA', (T, T), (0, 0, 0, 0))
    mitad_d = Image.new('RGBA', (T, T), (0, 0, 0, 0))
    di, dd = ImageDraw.Draw(mitad_i), ImageDraw.Draw(mitad_d)
    di.rectangle((0, 0, T // 2, T), fill=LOGO['fondo_i'] + (255,))
    dd.rectangle((T // 2, 0, T, T), fill=LOGO['fondo_d'] + (255,))
    c = T / 2
    for i, (r, grosor, inicio) in enumerate([(0.283, 0.0586, 0.5), (0.156, 0.0586, 0.68), (0.0566, 0, 0.86)]):
        e = rebote((t - inicio) / 0.35)
        if e <= 0:
            continue
        rr = r * T * e
        g = grosor * T * min(1.0, e)
        for d, color in ((di, LOGO['aro_i']), (dd, LOGO['aro_d'])):
            if grosor:
                d.ellipse((c - rr - g / 2, c - rr - g / 2, c + rr + g / 2, c + rr + g / 2), outline=color + (255,), width=max(1, round(g)))
            else:
                d.ellipse((c - rr, c - rr, c + rr, c + rr), fill=color + (255,))
    # Cada mitad solo en su lado (los anillos también).
    mi = Image.new('L', (T, T), 0)
    ImageDraw.Draw(mi).rectangle((0, 0, T // 2, T), fill=255)
    md = Image.new('L', (T, T), 0)
    ImageDraw.Draw(md).rectangle((T // 2, 0, T, T), fill=255)
    capa.paste(mitad_i, (-desp, 0), mi)
    capa.paste(mitad_d, (desp, 0), md)
    if a >= 0.999:
        # Juntas: la forma de icono de app.
        mascara = Image.new('L', (T, T), 0)
        ImageDraw.Draw(mascara).rounded_rectangle((0, 0, T - 1, T - 1), round(T * 0.22), fill=255)
        capa.putalpha(Image.composite(capa.getchannel('A'), Image.new('L', (T, T), 0), mascara))
    else:
        # Mientras entran, cada mitad con sus esquinas exteriores redondeadas.
        mascara = Image.new('L', (T, T), 0)
        m = ImageDraw.Draw(mascara)
        m.rounded_rectangle((-desp, 0, T // 2 - desp + T * 0.3, T - 1), round(T * 0.22), fill=255)
        m.rectangle((T // 2 - desp, 0, T // 2 - desp, T), fill=255)
        m.rounded_rectangle((T // 2 + desp - T * 0.3, 0, T - 1 + desp, T - 1), round(T * 0.22), fill=255)
        m.rectangle((T // 2 + desp - T * 0.3, 0, T // 2 + desp, T - 1), fill=255)
        m.rectangle((T // 2 - desp - T * 0.3, 0, T // 2 - desp, T - 1), fill=255)
        capa.putalpha(Image.composite(capa.getchannel('A'), Image.new('L', (T, T), 0), mascara))
    img = capa.resize((tam, tam), Image.LANCZOS)
    if not sombra:
        return img
    m = round(tam * 0.18)
    lienzo = Image.new('RGBA', (tam + 2 * m, tam + 2 * m), (0, 0, 0, 0))
    s = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(s).rounded_rectangle((m, m + round(tam * 0.05), m + tam, m + tam + round(tam * 0.05)), round(tam * 0.22), fill=round(150 * a))
    s = s.filter(ImageFilter.GaussianBlur(tam * 0.08))
    lienzo.paste((10, 5, 15, 255), (0, 0), s)
    lienzo.putalpha(s)
    lienzo.paste(img, (m, m), img)
    return lienzo


def linea_dorada(ancho, alto):
    mitad = degradado((ancho // 2, alto), DORADO, DORADO_CLARO)
    linea = Image.new('RGB', (ancho, alto))
    linea.paste(mitad, (0, 0))
    linea.paste(mitad.transpose(Image.FLIP_LEFT_RIGHT), (ancho - ancho // 2, 0))
    return linea


def movil(nombre, ancho):
    """Captura dentro de un móvil dibujado, con su sombra. Devuelve una imagen RGBA."""
    captura = Image.open(os.path.join(CAPTURAS, f'{nombre}.png')).convert('RGB')
    alto = round(captura.height * ancho / captura.width)
    captura = captura.resize((ancho, alto), Image.LANCZOS)
    marco, radio, margen = 12, 46, 50
    w, h = ancho + 2 * marco, alto + 2 * marco
    lienzo = Image.new('RGBA', (w + 2 * margen, h + 2 * margen), (0, 0, 0, 0))
    sombra = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(sombra).rounded_rectangle((margen, margen + 18, margen + w, margen + h + 18), radio, fill=120)
    sombra = sombra.filter(ImageFilter.GaussianBlur(22))
    lienzo.paste((40, 20, 60, 255), (0, 0), sombra)
    lienzo.putalpha(sombra)
    cuerpo = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
    ImageDraw.Draw(cuerpo).rounded_rectangle((margen, margen, margen + w, margen + h), radio, fill=(28, 22, 38, 255))
    lienzo = Image.alpha_composite(lienzo, cuerpo)
    mascara = Image.new('L', (ancho, alto), 0)
    ImageDraw.Draw(mascara).rounded_rectangle((0, 0, ancho, alto), radio - marco, fill=255)
    lienzo.paste(captura, (margen + marco, margen + marco), mascara)
    return lienzo, margen


def portatil(nombre, ancho):
    """Captura de escritorio dentro de un portátil dibujado, con su sombra. Devuelve (RGBA, margen)."""
    captura = Image.open(os.path.join(CAPTURAS, f'{nombre}.png')).convert('RGB')
    marco, margen = 22, 50
    pantalla_w = ancho - 2 * marco
    pantalla_h = round(captura.height * pantalla_w / captura.width)
    captura = captura.resize((pantalla_w, pantalla_h), Image.LANCZOS)
    tapa_h = pantalla_h + 2 * marco
    base_h, base_extra = 34, 70
    w, h = ancho + 2 * base_extra, tapa_h + base_h
    lienzo = Image.new('RGBA', (w + 2 * margen, h + 2 * margen), (0, 0, 0, 0))
    sombra = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(sombra).rounded_rectangle((margen + base_extra, margen + 20, margen + base_extra + ancho, margen + h + 16), 26, fill=120)
    sombra = sombra.filter(ImageFilter.GaussianBlur(24))
    lienzo.paste((40, 20, 60, 255), (0, 0), sombra)
    lienzo.putalpha(sombra)
    cuerpo = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(cuerpo)
    x0, y0 = margen + base_extra, margen
    d.rounded_rectangle((x0, y0, x0 + ancho, y0 + tapa_h), 24, fill=(28, 22, 38, 255))
    # Base: una plancha más ancha que la tapa, con la muesca para abrirla.
    d.rounded_rectangle((margen, y0 + tapa_h - 4, margen + w, y0 + tapa_h + base_h), 16, fill=(190, 186, 196, 255))
    d.rounded_rectangle((margen + w // 2 - 90, y0 + tapa_h - 4, margen + w // 2 + 90, y0 + tapa_h + 10), 8, fill=(160, 156, 168, 255))
    lienzo = Image.alpha_composite(lienzo, cuerpo)
    lienzo.paste(captura, (x0 + marco, y0 + marco))
    return lienzo, margen


def partir(texto, fuente, ancho):
    """Parte un texto en líneas que caben en [ancho]."""
    lineas, actual = [], ''
    for palabra in texto.split():
        prueba = f'{actual} {palabra}'.strip()
        if fuente.getlength(prueba) <= ancho or not actual:
            actual = prueba
        else:
            lineas.append(actual)
            actual = palabra
    return lineas + [actual]


def con_opacidad(img, alfa):
    if alfa >= 0.999:
        return img
    copia = img.copy()
    copia.putalpha(img.getchannel('A').point(lambda v: round(v * alfa)))
    return copia


def _nota(n):
    """Frecuencia de una nota MIDI."""
    return 440.0 * 2 ** ((n - 69) / 12)


def _env(n, ataque, caida):
    t = np.arange(n) / SR
    e = np.minimum(1.0, t / max(ataque, 1e-4)) * np.exp(-t / caida)
    return e


def _piano(f, dur, vel):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = sum(a * np.sin(2 * np.pi * f * k * t) for k, a in ((1, 1.0), (2, 0.45), (3, 0.18), (4, 0.08)))
    return vel * onda * _env(n, 0.006, 0.9)


def _campana(f, vel, dur=2.2):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = sum(a * np.sin(2 * np.pi * f * k * t) * np.exp(-t / (1.2 / k)) for k, a in ((1, 1.0), (2.76, 0.4), (5.4, 0.2)))
    return vel * onda * np.minimum(1.0, t / 0.003)


def _golpe(vel):
    """Golpe seco y grave (las dos mitades del logo al juntarse)."""
    n = int(0.35 * SR)
    t = np.arange(n) / SR
    f = 140 * np.exp(-t * 9) + 55
    return vel * np.sin(2 * np.pi * np.cumsum(f) / SR) * np.exp(-t / 0.09)


def _toque(vel):
    """Toque suave de interfaz (al entrar un móvil)."""
    n = int(0.12 * SR)
    t = np.arange(n) / SR
    return vel * (np.sin(2 * np.pi * 1320 * t) + 0.5 * np.sin(2 * np.pi * 2640 * t)) * np.exp(-t / 0.03)


def _tic(vel):
    n = int(0.05 * SR)
    t = np.arange(n) / SR
    return vel * np.sin(2 * np.pi * 2200 * t) * np.exp(-t / 0.008)


def exportar_capturas():
    """Versión ligera de cada captura para la página web."""
    for fichero in sorted(os.listdir(CAPTURAS)):
        if not fichero.endswith('.png'):
            continue
        img = Image.open(os.path.join(CAPTURAS, fichero)).convert('RGB')
        img = img.resize((720, round(img.height * 720 / img.width)), Image.LANCZOS)
        img.save(os.path.join(PROMO, fichero[:-4] + '.webp'), quality=82, method=6)




# ====================================================================== Ritmo
BPM = 110
PULSO = 60 / BPM
COMPAS = 4 * PULSO
MEDIO = PULSO / 2
CREMA = (240, 232, 248)
VERDE = (46, 125, 50)
ROJO = (183, 28, 28)


def compas(n):
    """Inicio del compás [n] (desde 0), en segundos."""
    return n * COMPAS


_cache = {}


def cache(clave, crear):
    if clave not in _cache:
        _cache[clave] = crear()
    return _cache[clave]


def entre(t, a, b):
    """Avance de 0 a 1 de t entre a y b (suavizado)."""
    return suave((t - a) / (b - a)) if b > a else float(t >= a)


# ===================================================================== Piezas

def captura(nombre, ancho):
    def crear():
        img = Image.open(os.path.join(CAPTURAS, f'{nombre}.png')).convert('RGB')
        return img.resize((ancho, round(img.height * ancho / img.width)), Image.LANCZOS)
    return cache(('captura', nombre, ancho), crear)


def armazon(w, h):
    """Cuerpo de un móvil (con su sombra) para una pantalla de w × h."""
    def crear():
        marco, radio, margen = 12, 46, 50
        W, H = w + 2 * marco, h + 2 * marco
        lienzo = Image.new('RGBA', (W + 2 * margen, H + 2 * margen), (0, 0, 0, 0))
        sombra = Image.new('L', lienzo.size, 0)
        ImageDraw.Draw(sombra).rounded_rectangle((margen, margen + 22, margen + W, margen + H + 22), radio, fill=130)
        sombra = sombra.filter(ImageFilter.GaussianBlur(24))
        lienzo.paste((30, 14, 44, 255), (0, 0), sombra)
        lienzo.putalpha(sombra)
        cuerpo = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
        ImageDraw.Draw(cuerpo).rounded_rectangle((margen, margen, margen + W, margen + H), radio, fill=(28, 22, 38, 255))
        lienzo = Image.alpha_composite(lienzo, cuerpo)
        mascara = Image.new('L', (w, h), 0)
        ImageDraw.Draw(mascara).rounded_rectangle((0, 0, w, h), radio - marco, fill=255)
        return lienzo, margen + marco, mascara
    return cache(('armazon', w, h), crear)


def telefono(nombre, ancho, siguiente=None, f=0.0):
    """Móvil con la captura [nombre]; con [siguiente], la pantalla se desliza
    hacia ella (f de 0 a 1), como al pasar de una pantalla a otra."""
    if siguiente is None or f <= 0:
        return cache(('telefono', nombre, ancho), lambda: telefono_compuesto(captura(nombre, ancho), ancho))
    if f >= 1:
        return telefono(siguiente, ancho)
    a, b = captura(nombre, ancho), captura(siguiente, ancho)
    w, h = a.size
    pant = Image.new('RGB', (w, max(h, b.height)), (246, 244, 239))
    dx = round(w * suave(f))
    pant.paste(a, (-dx, 0))
    pant.paste(b, (w - dx, 0))
    return telefono_compuesto(pant.crop((0, 0, w, h)), ancho)


def telefono_compuesto(pantalla, ancho):
    arm, desp, mascara = armazon(*pantalla.size)
    img = arm.copy()
    img.paste(pantalla, (desp, desp), mascara)
    return img


def pegar(lienzo, img, cx, cy, escala=1.0, giro=0.0, alfa=1.0):
    """Pega [img] (RGBA) centrada en (cx, cy), escalada, girada y con opacidad."""
    if alfa <= 0.004:
        return
    if abs(escala - 1) > 1e-3:
        img = img.resize((max(1, round(img.width * escala)), max(1, round(img.height * escala))), Image.BILINEAR)
    if abs(giro) > 0.05:
        img = img.rotate(giro, resample=Image.BICUBIC, expand=True)
    if alfa < 0.996:
        img = con_opacidad(img, alfa)
    lienzo.paste(img, (round(cx - img.width / 2), round(cy - img.height / 2)), img)


def tarjeta(contenido, radio=26, borde=DORADO, relleno=BLANCO, margen=34, sombra=True, grosor=3):
    """Tarjeta flotante (con sombra) alrededor de una imagen."""
    w, h = contenido.width + 2 * margen, contenido.height + 2 * margen
    m = 46
    lienzo = Image.new('RGBA', (w + 2 * m, h + 2 * m), (0, 0, 0, 0))
    if sombra:
        s = Image.new('L', lienzo.size, 0)
        ImageDraw.Draw(s).rounded_rectangle((m, m + 16, m + w, m + h + 16), radio, fill=110)
        s = s.filter(ImageFilter.GaussianBlur(20))
        lienzo.paste((30, 14, 44, 255), (0, 0), s)
        lienzo.putalpha(s)
    capa = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(capa)
    d.rounded_rectangle((m, m, m + w, m + h), radio, fill=relleno + (255,), outline=(borde + (255,)) if borde else None, width=grosor)
    lienzo = Image.alpha_composite(lienzo, capa)
    lienzo.paste(contenido, (m + margen, m + margen), contenido if contenido.mode == 'RGBA' else None)
    return lienzo


def lupa(nombre, y0, y1, ancho):
    """Una parte de la captura, ampliada, en una tarjeta con borde dorado."""
    def crear():
        img = Image.open(os.path.join(CAPTURAS, f'{nombre}.png')).convert('RGB').crop((0, y0, 1080, y1))
        img = img.resize((ancho, round(img.height * ancho / img.width)), Image.LANCZOS).convert('RGBA')
        mascara = Image.new('L', img.size, 0)
        ImageDraw.Draw(mascara).rounded_rectangle((0, 0, img.width - 1, img.height - 1), 18, fill=255)
        img.putalpha(mascara)
        return tarjeta(img, margen=10, radio=26, grosor=4)
    return cache(('lupa', nombre, y0, y1, ancho), crear)


def palabra(texto, fuente, color):
    def crear():
        f = fuente
        x0, y0, x1, y1 = f.getbbox(texto)
        asc, desc = f.getmetrics()
        img = Image.new('RGBA', (max(1, x1 + 4), asc + desc + 6), (0, 0, 0, 0))
        ImageDraw.Draw(img).text((0, 2), texto, font=f, fill=color)
        return img
    return cache(('palabra', texto, id(fuente), color), crear)


_fuentes = {}


def fuente(tipo, tam, estilo):
    clave = (tipo, tam, estilo)
    if clave not in _fuentes:
        _fuentes[clave] = serif(tam, estilo) if tipo == 'serif' else sans(tam, estilo)
    return _fuentes[clave]


def titular(lienzo, lineas, x, y, t, tam=88, color=TEXTO, acento=TINTA_CLARA, paso=0.07, inicio=0.0, centrado=False,
            tipo='serif', estilo='bold', interlinea=1.2, salida=None, alfa=1.0):
    """Frase que entra palabra a palabra (sube y aparece). Las palabras que
    empiezan por «*» van en el color de [acento]. Con [salida] (instante), se
    va hacia arriba. Devuelve la altura que ocupa."""
    f = fuente(tipo, tam, estilo)
    espacio = f.getlength(' ')
    alto = round(tam * interlinea)
    k = 0
    for i, linea in enumerate(lineas):
        palabras = linea.split()
        imgs = [palabra(p.lstrip('*'), f, acento if p.startswith('*') else color) for p in palabras]
        ancho_linea = sum(im.width for im in imgs) + espacio * (len(imgs) - 1)
        xx = x - ancho_linea / 2 if centrado else x
        for im in imgs:
            a = entre(t, inicio + k * paso, inicio + k * paso + 0.4)
            dy = round(26 * (1 - a))
            if salida is not None:
                s = entre(t, salida, salida + 0.35)
                a *= 1 - s
                dy -= round(40 * s)
            if a > 0.004:
                pegar(lienzo, im, xx + im.width / 2, y + i * alto + im.height / 2 + dy, alfa=a * alfa)
            xx += im.width + espacio
            k += 1
    return alto * len(lineas)


def rotulo(lienzo, texto, x, y, t, color=DORADO, inicio=0.0, centrado=False):
    """Rótulo pequeño en mayúsculas con su raya (como .section-title)."""
    a = entre(t, inicio, inicio + 0.4)
    if a <= 0:
        return
    f = fuente('sans', 30, 'Bold')
    im = palabra(texto, f, color)
    xx = x - im.width / 2 if centrado else x
    pegar(lienzo, im, xx + im.width / 2, y + im.height / 2, alfa=a)
    largo = round(min(im.width, 120) * a)
    x0 = round(x - largo / 2) if centrado else round(x)
    ImageDraw.Draw(lienzo).rectangle((x0, y + 52, x0 + largo, y + 56), fill=color)


def parrafo(lienzo, texto, x, y, t, ancho=640, tam=36, color=TEXTO_SUAVE, inicio=0.0, alfa=1.0):
    f = fuente('sans', tam, 'Regular')
    a = entre(t, inicio, inicio + 0.5) * alfa
    if a <= 0:
        return
    for i, linea in enumerate(partir(texto, f, ancho)):
        im = palabra(linea, f, color)
        pegar(lienzo, im, x + im.width / 2, y + i * round(tam * 1.38) + im.height / 2 + round(18 * (1 - a)), alfa=a)


def pastilla(texto, color_punto=DORADO, oscura=False, tam=34):
    """Pastilla flotante con un punto de color (datos, avisos breves)."""
    def crear():
        f = fuente('sans', tam, 'Semibold')
        w = round(f.getlength(texto)) + 92
        h = round(tam * 2.1)
        img = Image.new('RGBA', (w + 60, h + 60), (0, 0, 0, 0))
        s = Image.new('L', img.size, 0)
        ImageDraw.Draw(s).rounded_rectangle((30, 40, 30 + w, 40 + h), h // 2, fill=90)
        s = s.filter(ImageFilter.GaussianBlur(12))
        img.paste((30, 14, 44, 255), (0, 0), s)
        img.putalpha(s)
        capa = Image.new('RGBA', img.size, (0, 0, 0, 0))
        d = ImageDraw.Draw(capa)
        fondo = (46, 34, 53, 255) if oscura else (255, 255, 255, 255)
        d.rounded_rectangle((30, 30, 30 + w, 30 + h), h // 2, fill=fondo)
        d.ellipse((30 + 30, 30 + h / 2 - 9, 30 + 48, 30 + h / 2 + 9), fill=color_punto + (255,))
        d.text((30 + 64, 30 + h / 2), texto, font=f, fill=BLANCO if oscura else TEXTO, anchor='lm')
        return Image.alpha_composite(img, capa)
    return cache(('pastilla', texto, color_punto, oscura, tam), crear)


def aviso(titulo, texto, color, ancho=520):
    """Notificación como las del móvil: icono, título y texto."""
    def crear():
        cont = Image.new('RGBA', (ancho, 104), (0, 0, 0, 0))
        d = ImageDraw.Draw(cont)
        d.rounded_rectangle((0, 8, 72, 80), 18, fill=(46, 34, 53, 255))
        ic = icono(56)
        cont.paste(ic, (8, 16), ic)
        d.ellipse((58, 2, 80, 24), fill=color + (255,))
        d.text((96, 26), titulo, font=fuente('sans', 32, 'Bold'), fill=TEXTO, anchor='lm')
        d.text((96, 68), texto, font=fuente('sans', 28, 'Regular'), fill=TEXTO_SUAVE, anchor='lm')
        return tarjeta(cont, radio=28, borde=None, margen=22)
    return cache(('aviso', titulo, texto, color, ancho), crear)


def documento(etiqueta, color):
    """Icono de fichero (hoja con la esquina doblada y su etiqueta)."""
    def crear():
        w, h = 130, 160
        img = Image.new('RGBA', (w + 40, h + 40), (0, 0, 0, 0))
        s = Image.new('L', img.size, 0)
        ImageDraw.Draw(s).rounded_rectangle((20, 30, 20 + w, 30 + h), 12, fill=110)
        s = s.filter(ImageFilter.GaussianBlur(10))
        img.paste((30, 14, 44, 255), (0, 0), s)
        img.putalpha(s)
        capa = Image.new('RGBA', img.size, (0, 0, 0, 0))
        d = ImageDraw.Draw(capa)
        d.polygon([(20, 20), (20 + w - 36, 20), (20 + w, 56), (20 + w, 20 + h), (20, 20 + h)], fill=(255, 255, 255, 255))
        d.polygon([(20 + w - 36, 20), (20 + w - 36, 56), (20 + w, 56)], fill=(220, 214, 226, 255))
        for i in range(3):
            d.rounded_rectangle((38, 76 + i * 18, 20 + w - 18 - (i % 2) * 24, 84 + i * 18), 4, fill=(225, 220, 230, 255))
        d.rounded_rectangle((30, 20 + h - 52, 20 + w - 10, 20 + h - 14), 8, fill=color + (255,))
        d.text((20 + w / 2 + 4, 20 + h - 33), etiqueta, font=fuente('sans', 28, 'Bold'), fill=BLANCO, anchor='mm')
        return Image.alpha_composite(img, capa)
    return cache(('documento', etiqueta, color), crear)


def bola(codigo, color):
    """Bola del bombo con el código de un tema."""
    def crear():
        r = 92
        img = Image.new('RGBA', (2 * r + 40, 2 * r + 50), (0, 0, 0, 0))
        s = Image.new('L', img.size, 0)
        ImageDraw.Draw(s).ellipse((20, 34, 20 + 2 * r, 34 + 2 * r), fill=120)
        s = s.filter(ImageFilter.GaussianBlur(12))
        img.paste((10, 5, 15, 255), (0, 0), s)
        img.putalpha(s)
        capa = Image.new('RGBA', img.size, (0, 0, 0, 0))
        d = ImageDraw.Draw(capa)
        d.ellipse((20, 20, 20 + 2 * r, 20 + 2 * r), fill=(247, 244, 236, 255), outline=color + (255,), width=12)
        d.ellipse((58, 44, 98, 70), fill=(255, 255, 255, 170))
        d.text((20 + r, 20 + r), codigo, font=fuente('serif', 46, 'bold'), fill=color, anchor='mm')
        return Image.alpha_composite(img, capa)
    return cache(('bola', codigo, color), crear)


def estrella(llena, tam=86):
    def crear():
        img = Image.new('RGBA', (tam, tam), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        c = tam / 2
        puntos = []
        for i in range(10):
            r = c * (0.95 if i % 2 == 0 else 0.42)
            ang = -math.pi / 2 + i * math.pi / 5
            puntos.append((c + r * math.cos(ang), c + r * math.sin(ang)))
        if llena:
            d.polygon(puntos, fill=DORADO_CLARO + (255,))
        else:
            d.polygon(puntos, outline=(240, 232, 248, 140), width=4)
        return img
    return cache(('estrella', llena, tam), crear)


# ===================================================================== Fondos

def fondo_luz():
    """Crema con una rejilla de puntos y anillos de diana muy tenues."""
    def crear():
        f = degradado((ANCHO, ALTO), FONDO, FONDO_2).convert('RGBA')
        puntos = Image.new('RGBA', (ANCHO, ALTO), (0, 0, 0, 0))
        d = ImageDraw.Draw(puntos)
        for x in range(24, ANCHO, 40):
            for y in range(24, ALTO, 40):
                d.ellipse((x - 1.6, y - 1.6, x + 1.6, y + 1.6), fill=TINTA + (34,))
        return Image.alpha_composite(f, puntos).convert('RGB')
    return cache('fondo_luz', crear)


def anillos_tenues():
    def crear():
        R = 900
        img = Image.new('RGBA', (2 * R, 2 * R), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        for i, r in enumerate(range(R - 10, 100, -110)):
            d.ellipse((R - r, R - r, R + r, R + r), outline=(DORADO if i % 2 else TINTA_CLARA) + (22,), width=3)
        return img
    return cache('anillos', crear)


def lienzo_luz(t):
    img = fondo_luz().copy()
    a = anillos_tenues()
    # Los anillos derivan despacio: el fondo nunca está quieto.
    pegar(img, a, 1500 + 60 * math.sin(t * 0.25), 760 + 40 * math.cos(t * 0.2))
    # La marca, discreta, arriba a la izquierda.
    marca = cache('marca', lambda: _marca())
    img.paste(marca, (52, 40), marca)
    return img


def _marca():
    ic = icono(46)
    f = fuente('sans', 28, 'Semibold')
    texto = 'Oposición TCEE · DCE'
    img = Image.new('RGBA', (60 + round(f.getlength(texto)) + 10, 50), (0, 0, 0, 0))
    img.paste(ic, (0, 2), ic)
    ImageDraw.Draw(img).text((60, 25), texto, font=f, fill=TINTA_CLARA, anchor='lm')
    return img


def fondo_noche():
    def crear():
        f = degradado((ANCHO, ALTO), TINTA_CLARA, TINTA)
        brillo = Image.new('L', (ANCHO, ALTO), 0)
        ImageDraw.Draw(brillo).ellipse((ANCHO * 0.25, -ALTO * 0.3, ANCHO * 0.95, ALTO * 0.9), fill=60)
        brillo = brillo.filter(ImageFilter.GaussianBlur(160))
        f.paste((122, 31, 75), (0, 0), brillo)
        puntos = Image.new('RGBA', (ANCHO, ALTO), (0, 0, 0, 0))
        d = ImageDraw.Draw(puntos)
        for x in range(24, ANCHO, 40):
            for y in range(24, ALTO, 40):
                d.ellipse((x - 1.4, y - 1.4, x + 1.4, y + 1.4), fill=(255, 255, 255, 16))
        return Image.alpha_composite(f.convert('RGBA'), puntos).convert('RGB')
    return cache('fondo_noche', crear)


def ondas(lienzo, centro, t, n=5, cada=0.3, dur=2.0, r0=120, grosor=5):
    """Ondas que salen de la diana y llegan hasta los bordes de la pantalla."""
    cx, cy = centro
    rmax = max(math.hypot(x - cx, y - cy) for x in (0, ANCHO) for y in (0, ALTO)) + 30
    capa = None
    for k in range(n):
        x = (t - k * cada) / dur
        if not 0 < x < 1:
            continue
        if capa is None:
            capa = Image.new('RGBA', (ANCHO, ALTO), (0, 0, 0, 0))
            d = ImageDraw.Draw(capa)
        r = r0 + (rmax - r0) * (1 - (1 - x) ** 2.2)
        alfa = round(190 * (1 - x) ** 0.8)
        color = DORADO_CLARO if k % 2 == 0 else CREMA
        d.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color + (alfa,), width=grosor)
    if capa is not None:
        lienzo.paste(capa, (0, 0), capa)


def progreso(lienzo, t, oscuro=False):
    ImageDraw.Draw(lienzo).rectangle((0, ALTO - 6, round(ANCHO * t / DURACION), ALTO), fill=DORADO_CLARO)


# ==================================================================== Escenas
# Cada escena recibe su tiempo local y devuelve el fotograma completo.

def e_portada(t):
    img = fondo_noche().copy()
    centro = (ANCHO // 2, 380)
    ondas(img, centro, t - 1.0)
    ic = logo_animado(230, t)
    pegar(img, ic, centro[0], centro[1])
    titular(img, ['Oposición TCEE · DCE'], ANCHO // 2, 590, t, tam=104, color=BLANCO, centrado=True, inicio=1.25, paso=0.12)
    a = entre(t, 1.9, 2.5)
    ImageDraw.Draw(img).rectangle((ANCHO // 2 - round(170 * a), 732, ANCHO // 2 + round(170 * a), 737), fill=DORADO_CLARO)
    titular(img, ['Prepara tu oposición con una sola app'], ANCHO // 2, 770, t, tam=48, color=CREMA, centrado=True, inicio=2.3, paso=0.05, estilo='italic')
    return img


def e_gancho(t):
    img = fondo_noche().copy()
    sal = COMPAS - 0.15
    y = 330
    for i, (linea, ini) in enumerate([('Años de vueltas al temario.', 0.0), ('Cantes cada semana.', 2 * PULSO), ('Test, diario, *cronograma…', 3 * PULSO)]):
        titular(img, [linea], 220, y + i * 140, t, tam=90, color=CREMA, acento=DORADO_CLARO, inicio=ini, paso=MEDIO / 2, salida=sal)
    titular(img, ['Ahora, todo', 'en *un *solo *sitio.'], ANCHO // 2, 330, t, tam=124, color=BLANCO, acento=DORADO_CLARO, centrado=True, inicio=COMPAS, paso=MEDIO)
    a = entre(t, COMPAS + 4 * MEDIO, COMPAS + 6 * MEDIO)
    ImageDraw.Draw(img).rectangle((ANCHO // 2 - round(260 * a), 680, ANCHO // 2 + round(260 * a), 686), fill=DORADO_CLARO)
    return img


def e_elegir(t):
    img = lienzo_luz(t)
    cambio = COMPAS
    rotulo(img, 'AL EMPEZAR', 150, 320, t)
    titular(img, ['Tu oposición.'], 150, 400, t, tam=100, inicio=0.1)
    titular(img, ['*Y *tu *papel.'], 150, 530, t, tam=100, inicio=cambio, paso=MEDIO / 2)
    parrafo(img, 'TCEE o DCE. Me preparo la oposición o preparo a opositores.', 150, 690, t, inicio=0.5, ancho=600)
    a = entre(t, 0.0, 0.8)
    f = entre(t, cambio - 0.1, cambio + 0.35)
    pegar(img, telefono('elegir-oposicion', 400, 'elegir-papel', f), 1290, 560 + round(120 * (1 - a)), escala=0.92 + 0.08 * a, alfa=a)
    # Las dos oposiciones (y después los dos papeles), flotando junto al móvil.
    flota = 10 * math.sin(t * 2.2)
    for i, (txt1, txt2, color, x, y) in enumerate([('TCEE', 'Me preparo', LOGO['fondo_i'], 1000, 210), ('DCE', 'Preparo a otros', LOGO['fondo_d'], 1650, 820)]):
        e = entre(t, 0.4 + i * PULSO, 0.9 + i * PULSO)
        dx = (-260 if i == 0 else 260) * (1 - e)
        g = cache(('chip', txt1, color), lambda: tarjeta(palabra(txt1, fuente('serif', 64, 'bold'), BLANCO), relleno=color, borde=None, margen=24, radio=22))
        h = cache(('chip', txt2, color), lambda: tarjeta(palabra(txt2, fuente('serif', 46, 'bold'), BLANCO), relleno=color, borde=None, margen=24, radio=22))
        pegar(img, g, x + dx, y + (flota if i else -flota), alfa=e * (1 - f))
        pegar(img, h, x + dx, y + (flota if i else -flota), alfa=e * f, escala=0.9 + 0.1 * f)
    return img


def e_hoy(t):
    img = lienzo_luz(t)
    cambio = COMPAS
    rotulo(img, 'CADA DÍA', 120, 330, t)
    titular(img, ['Cada día sabes', '*qué *te *toca.'], 120, 400, t, tam=92, paso=MEDIO / 2)
    parrafo(img, 'Cuenta atrás, test diario, los temas de tu cronograma y tu probabilidad, nada más abrir.', 120, 660, t, inicio=0.6, ancho=620)
    a = entre(t, 0, 0.8)
    f = entre(t, cambio - 0.1, cambio + 0.35)
    tel = telefono('hoy', 390, 'dce-hoy', f)
    cx, cy = 1110, 560 + round(100 * (1 - a))
    pegar(img, tel, cx, cy, giro=-3 * a, alfa=a)
    # Lupa sobre «Esta semana te toca», unida al móvil por una línea dorada.
    l = entre(t, 0.5, 0.9) * (1 - entre(t, cambio - 0.3, cambio))
    if l > 0:
        y_m = cy - 464 + round((1220 / 2340) * 845)
        d = ImageDraw.Draw(img)
        x1 = 1280 + round(150 * l)
        d.line((1290, y_m, x1, y_m), fill=DORADO, width=4)
        d.ellipse((1282, y_m - 8, 1298, y_m + 8), fill=DORADO)
        pegar(img, lupa('hoy', 960, 1480, 560), 1600, y_m, escala=0.8 + 0.2 * rebote(l), alfa=l)
    # Después, en DCE: los datos del día, como pastillas.
    for i, (txt, color) in enumerate([('Próximo cante en 41 h', LOGO['fondo_d']), ('Test diario: 10 preguntas', VERDE), ('Esta semana: 3 temas', DORADO)]):
        e = entre(t, cambio + 0.3 + i * PULSO, cambio + 0.7 + i * PULSO)
        pegar(img, pastilla(txt, color), 1580 + round(80 * (1 - e)), 400 + i * 130 + 6 * math.sin(t * 2 + i), alfa=e)
    return img


def e_estudiar(t):
    img = lienzo_luz(t)
    rotulo(img, 'ESTUDIAR', 120, 330, t)
    titular(img, ['Todo el temario.', '*Todos *los *test.'], 120, 400, t, tam=92, paso=MEDIO / 2)
    parrafo(img, 'Los PDF de TCEE y los apuntes de DCE, dentro de la app, cada tema con su agenda. Y las preguntas oficiales, con tu historial.', 120, 660, t, inicio=0.6, ancho=640)
    deriva = -12 * t
    for i, (nombre, x, y, giro, ancho) in enumerate([('temario-temas', 1040, 600, 7, 320), ('test-estadisticas', 1640, 600, -7, 320), ('dce-tema-web', 1340, 560, 0, 350)]):
        e = entre(t, i * PULSO, i * PULSO + 0.7)
        pegar(img, telefono(nombre, ancho), x, y + deriva + round(260 * (1 - e)), giro=giro + (14 if giro >= 0 else -14) * (1 - e), alfa=e)
    return img


def e_cantes(t):
    img = fondo_noche().copy()
    c1, c2 = COMPAS, 2 * COMPAS
    a = entre(t, 0, 0.7)
    f = entre(t, c2 - 0.1, c2 + 0.35)
    pegar(img, telefono('dce-cantar', 380, 'cantes-diario', f), 470, 560 + round(120 * (1 - a)), alfa=a)
    rotulo(img, 'CANTES', 860, 200, t)
    titular(img, ['Saca bola.'], 860, 270, t, tam=110, color=BLANCO, salida=c1 - 0.2)
    titular(img, ['Cronometra.'], 860, 270, t, tam=110, color=BLANCO, inicio=c1, salida=c2 - 0.2)
    titular(img, ['Y anota cómo fue.'], 860, 270, t, tam=110, color=BLANCO, inicio=c2)
    # 1) Dos bolas que caen y botan.
    for i, (codigo, color, x) in enumerate([('3.A.4', LOGO['fondo_d'], 1080), ('3.A.20', LOGO['fondo_i'], 1380)]):
        t0 = PULSO * (1 + i)
        if t < t0 or t > c1 + 0.4:
            continue
        u = t - t0
        caida = 0.45
        if u < caida:
            y = 640 - 560 * (1 - (u / caida) ** 2)
        else:
            v = u - caida
            y = 640 - 120 * abs(math.sin(v * 7)) * math.exp(-v * 5)
        fuera = entre(t, c1 - 0.1, c1 + 0.35)
        pegar(img, bola(codigo, color), x, y - 300 * fuera, alfa=1 - fuera)
    # 2) El cronómetro: un segundo menos en cada pulso.
    if c1 - 0.1 < t < c2 + 0.3:
        e = entre(t, c1, c1 + 0.4) * (1 - entre(t, c2 - 0.2, c2 + 0.2))
        pasos = max(0, int((t - c1) / PULSO))
        resto = 30 * 60 - pasos
        texto = f'{resto // 60:02d}:{resto % 60:02d}'
        pegar(img, palabra('Exposición', fuente('sans', 40, 'Medium'), CREMA), 1240, 480, alfa=e)
        pegar(img, palabra(texto, fuente('sans', 230, 'Medium'), BLANCO), 1240, 640, alfa=e, escala=0.94 + 0.06 * e)
        d = ImageDraw.Draw(img)
        largo = round(620 * e)
        d.rounded_rectangle((1240 - 310, 790, 1240 - 310 + largo, 800), 5, fill=(90, 70, 100))
        d.rounded_rectangle((1240 - 310, 790, 1240 - 310 + round(largo * (1 - (t - c1) / (COMPAS * 6))), 800), 5, fill=DORADO_CLARO)
    # 3) Valoración: las estrellas se llenan a pulso.
    if t > c2 - 0.1:
        e = entre(t, c2 + 0.2, c2 + 0.6)
        for i in range(5):
            llena = i < 4 and t > c2 + PULSO * (1 + i * 0.5)
            pegar(img, estrella(llena, 96), 960 + i * 116, 560, alfa=e, escala=1.15 if llena and t < c2 + PULSO * (1 + i * 0.5) + 0.12 else 1)
        parrafo(img, 'Qué tema cantaste, cuánto duró y qué te dijeron: así salen los temas flojos.', 900, 680, t, inicio=c2 + 0.6, ancho=760, color=CREMA)
    return img


def e_organizacion(t):
    """Tres tiempos: si no tienes cronograma, la app te lo hace; si ya lo
    tienes, lo traes; y la probabilidad de que salga un tema que llevas."""
    img = lienzo_luz(t)
    c1, c2 = COMPAS, 2 * COMPAS
    rotulo(img, 'ORGANIZACIÓN', 120, 220, t)
    titular(img, ['¿Sin cronograma?', '*La *app *te *lo *hace.'], 120, 320, t, tam=86, paso=MEDIO / 2, salida=c1 - 0.3)
    parrafo(img, 'Eliges los temas y el ritmo: propone un orden por bloques y conexiones y te dice cada semana lo que toca.', 120, 560, t, inicio=0.6, ancho=620, alfa=1 - entre(t, c1 - 0.25, c1))
    titular(img, ['¿Ya tienes el tuyo?', '*Tráelo.'], 120, 320, t, tam=86, paso=MEDIO / 2, inicio=c1 + 0.15, salida=c2 - 0.3)
    parrafo(img, 'De un Excel, un Word, un PDF o un texto: lo lee y te lo deja para revisar.', 120, 560, t, inicio=c1 + 0.5, ancho=620, alfa=1 - entre(t, c2 - 0.25, c2))
    titular(img, ['¿Qué probabilidad', '*llevas?'], 120, 320, t, tam=86, paso=MEDIO / 2, inicio=c2 + 0.15, salida=c2 + PULSO * 2.4)
    titular(img, ['Cada tema', '*suma.'], 120, 320, t, tam=86, paso=MEDIO / 2, inicio=c2 + PULSO * 2.4 + 0.4)
    # El móvil: el asistente, el cronograma hecho, el importado y las probabilidades.
    cx, cy = 1420, 560
    a = entre(t, 0, 0.7)
    if t < c1 * 0.5 + 0.4:
        tel = telefono('cronograma-nuevo', 380, 'cronograma', entre(t, c1 * 0.5, c1 * 0.5 + 0.35))
    elif t < c1 + PULSO * 3:
        tel = telefono('cronograma', 380, 'cronograma-revisar', entre(t, c1 + PULSO * 2.6, c1 + PULSO * 2.6 + 0.35))
    else:
        tel = telefono('cronograma-revisar', 380, 'probabilidades', entre(t, c2 - 0.1, c2 + 0.35))
    pegar(img, tel, cx, cy + round(100 * (1 - a)), alfa=a)
    e = entre(t, c1 * 0.5 + 0.35, c1 * 0.5 + 0.7) * (1 - entre(t, c1 - 0.2, c1))
    pegar(img, pastilla('3 temas por semana', DORADO), 1060, 300 + 5 * math.sin(t * 2), alfa=e, escala=0.85 + 0.15 * rebote(e))
    # Los ficheros vuelan al móvil, uno por corchea.
    for i, (etq, color, x0, y0) in enumerate([('XLSX', (33, 115, 70), 200, 820), ('DOCX', (43, 87, 154), 390, 820), ('PDF', (179, 11, 0), 580, 820)]):
        aparece = entre(t, c1 + 0.2 + i * MEDIO, c1 + 0.5 + i * MEDIO)
        u = entre(t, c1 + PULSO * (1.4 + i * 0.5), c1 + PULSO * (1.4 + i * 0.5) + 0.55)
        if aparece <= 0 or u >= 1:
            continue
        x = x0 + (cx - x0) * u
        y = y0 + (cy - 80 - y0) * u - 260 * math.sin(math.pi * u)
        pegar(img, documento(etq, color), x, y + 6 * math.sin(t * 3 + i), escala=1.15 - 0.75 * u, giro=(1 - u) * (6 - 6 * i) + 30 * u, alfa=aparece * (1 - u * 0.5))
    e = entre(t, c1 + PULSO * 3, c1 + PULSO * 3 + 0.4) * (1 - entre(t, c2 - 0.2, c2))
    pegar(img, pastilla('9 temas en 3 semanas', VERDE), 1060, 300 + 5 * math.sin(t * 2), alfa=e, escala=0.85 + 0.15 * rebote(e))
    # La probabilidad del tercer ejercicio en un medidor que se llena contando;
    # después, lo que sube con cinco temas más (34 y 28 de 45: 81,5 %).
    if t > c2:
        e = entre(t, c2 + 0.15, c2 + 0.45)
        sube = entre(t, c2 + PULSO * 2.5, c2 + PULSO * 3.3)
        v = 75.1 * entre(t, c2 + 0.3, c2 + 1.3) + (81.5 - 75.1) * sube
        medidor(img, 400, 720, 140, v / 100, t, alfa=e)
        pegar(img, palabra('Tercer ejercicio de TCEE', fuente('sans', 30, 'Semibold'), TEXTO_SUAVE), 400, 905, alfa=e)
        p = entre(t, c2 + PULSO * 1.8, c2 + PULSO * 2.3)
        pegar(img, pastilla('¿Y si estudias 5 temas más?', DORADO), 400, 990, alfa=p, escala=0.85 + 0.15 * rebote(p))
    return img


def medidor(img, cx, cy, r, valor, t, alfa=1.0):
    """Anillo dorado que se llena hasta [valor] (0-1), con la cifra dentro."""
    if alfa <= 0:
        return
    k = 3
    capa = Image.new('RGBA', (2 * r * k + 40 * k, 2 * r * k + 40 * k), (0, 0, 0, 0))
    d = ImageDraw.Draw(capa)
    c = capa.width / 2
    g = 26 * k
    caja = (c - r * k, c - r * k, c + r * k, c + r * k)
    d.ellipse(caja, outline=TINTA_CLARA + (40,), width=g)
    if valor > 0.001:
        d.arc(caja, -90, -90 + 360 * valor, fill=DORADO_CLARO + (255,), width=g)
        # Extremo redondeado y con brillo.
        ang = math.radians(-90 + 360 * valor)
        x, y = c + (r * k - g / 2) * math.cos(ang), c + (r * k - g / 2) * math.sin(ang)
        d.ellipse((x - g / 2, y - g / 2, x + g / 2, y + g / 2), fill=DORADO_CLARO + (255,))
    capa = capa.resize((capa.width // k, capa.height // k), Image.LANCZOS)
    pegar(img, capa, cx, cy, alfa=alfa)
    texto = f'{valor * 100:.1f}'.replace('.', ',')
    pegar(img, palabra(texto, fuente('serif', 92, 'bold'), TINTA_CLARA), cx - 18, cy - 4, alfa=alfa)
    pegar(img, palabra('%', fuente('serif', 52, 'bold'), DORADO), cx + palabra(texto, fuente('serif', 92, 'bold'), TINTA_CLARA).width / 2 + 6, cy + 4, alfa=alfa)


def e_clases(t):
    img = lienzo_luz(t)
    c1, c2 = COMPAS, 2 * COMPAS
    rotulo(img, 'SI ALGO FALLA', 120, 200, t)
    titular(img, ['¿Te cancelan', 'la clase?'], 120, 270, t, tam=86, paso=MEDIO / 2)
    titular(img, ['Pídela una vez.'], 120, 490, t, tam=70, inicio=c1, color=TINTA_CLARA)
    titular(img, ['*Otro *preparador', '*te *la *coge.'], 120, 600, t, tam=86, inicio=c2, paso=MEDIO / 2)
    cx, cy = 1300, 560
    a = entre(t, 0, 0.7)
    if t < c1 + 0.5:
        tel = telefono('cante-cancelado', 390, 'dce-buscar-preparador', entre(t, c1 - 0.1, c1 + 0.35))
    else:
        tel = telefono('dce-buscar-preparador', 390, 'peticion-cogida', entre(t, c2 - 0.1, c2 + 0.35))
    # 2) La petición sale a los preparadores verificados: ondas y avatares que se encienden.
    if c1 <= t < c2 + 0.4:
        u = t - c1
        capa = Image.new('RGBA', (ANCHO, ALTO), (0, 0, 0, 0))
        d = ImageDraw.Draw(capa)
        for k in range(4):
            x = (u - k * PULSO) / (2.2 * PULSO)
            if 0 < x < 1:
                r = 220 + 380 * x
                d.ellipse((cx - r, cy - r, cx + r, cy + r), outline=DORADO_CLARO + (round(170 * (1 - x)),), width=4)
        img.paste(capa, (0, 0), capa)
    pegar(img, tel, cx, cy + round(100 * (1 - a)), alfa=a)
    if c1 <= t < c2 + 0.4:
        u = t - c1
        fuera = entre(t, c2, c2 + 0.4)
        for k, (ini, ang) in enumerate([('O', -60), ('L', -20), ('M', 20), ('A', 60), ('J', 150), ('P', 200)]):
            r = 470
            x = cx + r * math.cos(math.radians(ang)) * 0.95
            y = cy + r * math.sin(math.radians(ang)) * 0.85
            encendido = u > 0.25 + k * MEDIO
            img_av = cache(('avatar', ini, encendido), lambda: _avatar(ini, encendido))
            pegar(img, img_av, x, y, alfa=entre(t, c1 + k * 0.08, c1 + k * 0.08 + 0.3) * (1 - fuera), escala=1.12 if encendido and u < 0.25 + k * MEDIO + 0.15 else 1)
    # 1) y 3) Avisos que llegan, como en el móvil.
    for ini, fin, av in [(0.35, c1 - 0.25, aviso('Paula Pérez ha cancelado tu clase', 'Mañana, 18:00 · Motivo: estoy de viaje', ROJO, 620)),
                         (c2 + 0.35, c2 + COMPAS + 1, aviso('Olga Martín te coge la clase', 'Mañana, 18:30 · Escríbele por WhatsApp', VERDE, 620))]:
        e = entre(t, ini, ini + 0.35) * (1 - entre(t, fin, fin + 0.3))
        if e > 0:
            pegar(img, av, cx + 40, 150 + round(-120 * (1 - e)), alfa=e)
    return img


def _avatar(inicial, encendido):
    r = 46
    img = Image.new('RGBA', (2 * r + 20, 2 * r + 20), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    color = DORADO if encendido else (200, 194, 206)
    d.ellipse((10, 10, 10 + 2 * r, 10 + 2 * r), fill=(255, 255, 255, 255), outline=color + (255,), width=6)
    d.text((10 + r, 10 + r), inicial, font=fuente('serif', 44, 'bold'), fill=TINTA_CLARA if encendido else (160, 154, 166), anchor='mm')
    return img


def e_mi_preparador(t):
    img = lienzo_luz(t)
    rotulo(img, 'TU PREPARADOR', 120, 290, t)
    titular(img, ['Conecta con', 'tu preparador.'], 120, 360, t, tam=88, paso=MEDIO / 2)
    a = entre(t, 0, 0.6)
    pegar(img, telefono('mi-preparador', 380), 1420, 560 + round(100 * (1 - a)), alfa=a)
    # El código se teclea, una letra por corchea.
    d = ImageDraw.Draw(img)
    for i, letra in enumerate('K7M3PQ'):
        x = 120 + i * 104
        d.rounded_rectangle((x, 620, x + 88, 726), 14, fill=BLANCO, outline=(DORADO if t > 0.2 + i * MEDIO * 0.75 else (210, 204, 214)), width=4)
        if t > 0.2 + i * MEDIO * 0.75:
            pegar(img, palabra(letra, fuente('sans', 64, 'Bold'), TINTA_CLARA), x + 44, 673)
    e = entre(t, 0.3 + 6 * MEDIO * 0.75, 0.6 + 6 * MEDIO * 0.75)
    pegar(img, pastilla('Conectado', VERDE), 120 + 150, 810, alfa=e, escala=0.8 + 0.2 * rebote(e))
    return img


def e_preparadores(t):
    img = fondo_noche().copy()
    rotulo(img, 'SI PREPARAS A OPOSITORES', 120, 300, t, color=DORADO_CLARO)
    titular(img, ['Lleva a', 'tus alumnos.'], 120, 370, t, tam=96, color=BLANCO, paso=MEDIO / 2)
    parrafo(img, 'Te das de alta y te verifica otro preparador. Al abrir la app, tus clases de hoy; además, tu semana, la ficha de cada alumno y el tablón de clases sueltas.', 120, 640, t, inicio=0.6, ancho=640, color=CREMA)
    for i, (nombre, x, y, giro) in enumerate([('dce-hoy-preparador', 1080, 590, 5), ('dce-preparador', 1760, 590, -5), ('semana', 1420, 560, 0)]):
        e = entre(t, i * PULSO, i * PULSO + 0.7)
        pegar(img, telefono(nombre, 340), x + round(300 * (1 - e)), y, giro=giro, alfa=e)
    return img


def e_ordenador(t):
    img = lienzo_luz(t)
    rotulo(img, 'EN TODAS PARTES', 120, 330, t)
    titular(img, ['En el móvil', '*y *en *el *ordenador.'], 120, 400, t, tam=80, paso=MEDIO / 2)
    parrafo(img, 'Con tu cuenta de Google, todo sincronizado: lo que haces en uno aparece en el otro.', 120, 640, t, inicio=0.6, ancho=600)
    a = entre(t, 0, 0.8)
    lap = cache('portatil', lambda: portatil('dce-escritorio', 860)[0])
    pegar(img, lap, 1390, 500 + round(80 * (1 - a)), alfa=a, escala=0.86 + 0.04 * a)
    b = entre(t, PULSO, PULSO + 0.6)
    pegar(img, telefono('hoy', 220), 1780, 720 + round(120 * (1 - b)), alfa=b)
    # Puntos dorados que van y vienen entre los dos.
    if t > PULSO + 0.5:
        d = ImageDraw.Draw(img)
        for k in range(4):
            u = ((t - PULSO) * 0.7 + k / 4) % 1
            x = 1700 + (1390 - 1700) * u
            y = 560 - 200 * math.sin(math.pi * u) + (440 - 560) * u
            r = 9
            d.ellipse((x - r, y - r, x + r, y + r), fill=DORADO_CLARO)
    return img


def e_cierre(t):
    img = fondo_noche().copy()
    centro = (ANCHO // 2, 330)
    ondas(img, centro, t * 1.3 - 1.0)
    pegar(img, logo_animado(210, t * 1.3), centro[0], centro[1])
    titular(img, ['Empieza hoy.'], ANCHO // 2, 520, t, tam=140, color=BLANCO, centrado=True, inicio=0.9, paso=PULSO / 2)
    a = entre(t, 1.8, 2.4)
    ImageDraw.Draw(img).rectangle((ANCHO // 2 - round(170 * a), 712, ANCHO // 2 + round(170 * a), 717), fill=DORADO_CLARO)
    titular(img, ['Oposición TCEE · DCE  ·  Gratis  ·  Sin anuncios  ·  Android y navegador'], ANCHO // 2, 750, t, tam=40, color=CREMA, centrado=True, inicio=2.0, paso=0.04, tipo='sans', estilo='Medium')
    titular(img, ['Apuntes de TCEE: victorgutierrezmarcos.es  ·  Apuntes de DCE: manuelcabadogarcia.es'], ANCHO // 2, 830, t, tam=34, color=(210, 200, 220), centrado=True, inicio=2.8, paso=0.03, tipo='sans', estilo='Regular')
    return img


# (escena, compás de inicio, transición de entrada)
GUION = [
    (e_portada, 0, None),
    (e_gancho, 2, 'fundido'),
    (e_elegir, 4, 'barrido'),
    (e_hoy, 6, 'empuje'),
    (e_estudiar, 8, 'zoom'),
    (e_cantes, 10, 'barrido'),
    (e_organizacion, 13, 'empuje'),
    (e_mi_preparador, 16, 'zoom'),
    (e_clases, 17, 'corte'),
    (e_preparadores, 20, 'barrido'),
    (e_ordenador, 22, 'empuje'),
    (e_cierre, 24, 'zoom'),
]
# Escenas en las que no va la barra de progreso.
SIN_PROGRESO = {e_portada, e_gancho, e_cierre}
TRANSICION = 0.5


def _escena(t):
    for i, (f, c, tr) in enumerate(GUION):
        fin = compas(GUION[i + 1][1]) if i + 1 < len(GUION) else DURACION + 1
        if compas(c) <= t < fin:
            return i
    return len(GUION) - 1


def _base(i, t):
    f, c, _ = GUION[i]
    img = f(t - compas(c))
    if f not in SIN_PROGRESO:
        progreso(img, t)
    return img


def fotograma(t):
    """Imagen del instante [t] (en segundos)."""
    i = _escena(t)
    img = _base(i, t)
    _, c, tr = GUION[i]
    u = (t - compas(c)) / TRANSICION
    if tr is None or u >= 1 or i == 0:
        return img
    antes = cache(('ultimo', i), lambda: _base(i - 1, compas(c) - 1e-3))
    e = suave(u)
    if tr == 'fundido':
        return Image.blend(antes, img, e)
    if tr == 'corte':
        flash = Image.new('RGB', img.size, (255, 255, 255))
        return Image.blend(img, flash, 0.35 * max(0.0, 1 - u * 2.5))
    if tr == 'empuje':
        out = Image.new('RGB', img.size)
        dx = round(ANCHO * e)
        out.paste(antes, (-dx, 0))
        out.paste(img, (ANCHO - dx, 0))
        return out
    if tr == 'barrido':
        # Una franja dorada cruza la pantalla y deja detrás la escena nueva.
        x = round(-120 + (ANCHO + 240) * e)
        out = antes.copy()
        if x > 0:
            out.paste(img.crop((0, 0, min(x, ANCHO), ALTO)), (0, 0))
        d = ImageDraw.Draw(out)
        d.rectangle((x - 10, 0, x + 10, ALTO), fill=DORADO_CLARO)
        d.rectangle((x - 30, 0, x - 24, ALTO), fill=DORADO)
        return out
    if tr == 'zoom':
        s = 1 + 0.18 * e
        grande = antes.resize((round(ANCHO * s), round(ALTO * s)), Image.BILINEAR)
        grande = grande.crop(((grande.width - ANCHO) // 2, (grande.height - ALTO) // 2, (grande.width - ANCHO) // 2 + ANCHO, (grande.height - ALTO) // 2 + ALTO))
        s2 = 0.92 + 0.08 * e
        peq = img.resize((round(ANCHO * s2), round(ALTO * s2)), Image.BILINEAR)
        fondo = img.copy()
        fondo.paste(peq, ((ANCHO - peq.width) // 2, (ALTO - peq.height) // 2))
        return Image.blend(grande, fondo, e)
    return img


# ====================================================================== Sonido
# Banda sonora propia (sin derechos de terceros), electrónica y suave, a 110
# pulsaciones por minuto: colchón de sintetizador con la progresión re-si-sol-la
# (un acorde por compás), bajo, bombo suave con «sidechain», charles, arpegio y
# efectos sincronizados con la imagen (el logo, las bolas, el cronómetro, las
# estrellas, los avisos, el teclado y la sincronización). Sin ruido de barrido
# en los cortes.

SR = 44100
ACORDES = [(62, 66, 69), (59, 62, 66), (55, 59, 62), (57, 61, 64)]
RAICES = [38, 35, 31, 33]


def _pad(fs, dur, vel):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = np.zeros(n)
    for f in fs:
        for det in (0.997, 1.003):
            for k in range(1, 7):
                onda += np.sin(2 * np.pi * f * det * k * t + k) / (k ** 1.6)
    onda /= len(fs) * 2
    env = np.minimum(1.0, t / 0.35) * np.clip((dur - t) / 0.4, 0, 1)
    return vel * onda * env


def _bajo(f, dur, vel):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = np.sin(2 * np.pi * f * t) + 0.35 * np.sin(2 * np.pi * 2 * f * t) + 0.12 * np.sin(2 * np.pi * 3 * f * t)
    return vel * onda * np.minimum(1.0, t / 0.004) * np.exp(-t / 0.16)


def _bombo(vel):
    n = int(0.32 * SR)
    t = np.arange(n) / SR
    f = 46 + 90 * np.exp(-t * 28)
    return vel * np.sin(2 * np.pi * np.cumsum(f) / SR) * np.exp(-t / 0.11)


_rng = np.random.default_rng(11)


def _charles(vel):
    n = int(0.05 * SR)
    r = _rng.standard_normal(n)
    r = r - np.convolve(r, np.ones(6) / 6, mode='same')
    t = np.arange(n) / SR
    return vel * r * np.exp(-t / 0.012)


def _palmada(vel):
    n = int(0.14 * SR)
    r = _rng.standard_normal(n)
    r = np.convolve(r, np.ones(4) / 4, mode='same') - np.convolve(r, np.ones(40) / 40, mode='same')
    t = np.arange(n) / SR
    return vel * r * np.exp(-t / 0.035)


def _pulsacion(f, vel, dur=0.22):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = np.sin(2 * np.pi * f * t) + 0.25 * np.sin(2 * np.pi * 2 * f * t) + 0.1 * np.sin(2 * np.pi * 3 * f * t)
    return vel * onda * np.minimum(1.0, t / 0.003) * np.exp(-t / 0.07)


def _subida(f0, f1, dur, vel):
    """Glissando tonal (sin ruido) que sube hacia un cambio."""
    n = int(dur * SR)
    t = np.arange(n) / SR
    f = f0 * (f1 / f0) ** (t / dur)
    fase = 2 * np.pi * np.cumsum(f) / SR
    return vel * (np.sin(fase) + 0.3 * np.sin(2 * fase)) * (t / dur) ** 2


def _madera(vel, f=520):
    n = int(0.12 * SR)
    t = np.arange(n) / SR
    return vel * np.sin(2 * np.pi * f * t) * np.exp(-t / 0.025)


def inicio(escena):
    """Segundo en que empieza [escena] según el guion."""
    return compas(next(c for f, c, _ in GUION if f is escena))


def banda_sonora(ruta):
    import wave
    largo = int((DURACION + 2) * SR)
    musica, ritmo, efectos = np.zeros(largo), np.zeros(largo), np.zeros(largo)
    bombos = np.zeros(largo)

    def poner(pista, muestra, t):
        i = int(t * SR)
        j = min(largo, i + len(muestra))
        if 0 <= i < largo:
            pista[i:j] += muestra[: j - i]

    n_compases = int(math.ceil(DURACION / COMPAS))
    for b in range(n_compases):
        t0 = compas(b)
        acorde = [_nota(n) for n in ACORDES[b % 4]]
        raiz = _nota(RAICES[b % 4])
        # El ritmo sigue hasta «Empieza hoy» (compases 24 y 25); al final, el acorde.
        intro, gancho, cierre = b < 2, 2 <= b < 4, b >= 26
        cuerpo = not (intro or gancho or cierre)
        # Colchón.
        vel = 0.12 if intro else (0.04 if cuerpo else (0.08 if gancho else 0.06))
        poner(musica, _pad(acorde + [acorde[0] / 2], COMPAS + 0.4, vel), t0)
        # Bajo: negras en el gancho, corcheas en el cuerpo, una nota larga al cerrar.
        if gancho:
            for k in range(4):
                poner(ritmo, _bajo(raiz, PULSO, 0.16), t0 + k * PULSO)
        elif cuerpo:
            for k in range(8):
                poner(ritmo, _bajo(raiz * (2 if k % 4 == 3 else 1), MEDIO, 0.15), t0 + k * MEDIO)
        elif cierre and b == 26:
            n = int(3.0 * SR)
            tt = np.arange(n) / SR
            poner(ritmo, 0.2 * (np.sin(2 * np.pi * raiz * tt) + 0.3 * np.sin(4 * np.pi * raiz * tt)) * np.exp(-tt / 1.2) * np.minimum(1.0, tt / 0.01), t0)
        # Bombo (más suave en el respiro de las clases sueltas), charles y palmada.
        respiro = compas(b) == inicio(e_clases)
        if gancho and b == 2:
            for k in (0, 2):
                poner(bombos, _bombo(0.3), t0 + k * PULSO)
        if cuerpo or (gancho and b == 3):
            for k in range(4):
                if respiro and k % 2:
                    continue
                poner(bombos, _bombo(0.55 if not gancho else 0.4), t0 + k * PULSO)
        if cuerpo:
            for k in range(4):
                poner(ritmo, _charles(0.05), t0 + k * PULSO + MEDIO)
            if b >= 6 and not respiro:
                for k in (1, 3):
                    poner(ritmo, _palmada(0.06), t0 + k * PULSO)
        # Arpegio: corcheas suaves en la intro y el gancho, semicorcheas en el cuerpo.
        if b < 4:
            notas = [acorde[0] * 2, acorde[2] * 2, acorde[1] * 2, acorde[2] * 2]
            for k in range(8):
                poner(musica, _pulsacion(notas[k % 4], 0.04 if b < 2 else 0.05, 0.4), t0 + k * MEDIO)
        if 6 <= b < 26 and not respiro:
            notas = [acorde[0] * 2, acorde[1] * 2, acorde[2] * 2, acorde[1] * 2]
            for k in range(16):
                poner(musica, _pulsacion(notas[k % 4], 0.03 + 0.008 * (k % 4 == 0)), t0 + k * PULSO / 4)

    # Logo: el golpe al juntarse las mitades y una campana por anillo.
    for base, vel in ((0.0, 1.0), (compas(24), 1 / 1.3)):
        poner(efectos, _golpe(0.4), base + 0.62 * vel)
        for desde, nota in ((0.5, 86), (0.68, 90), (0.86, 93)):
            poner(efectos, _campana(_nota(nota), 0.08), base + (desde + 0.12) * vel)
    # Subida hacia el primer gran cambio y golpe al entrar el cuerpo.
    poner(efectos, _subida(180, 900, COMPAS * 0.9, 0.05), compas(4) - COMPAS * 0.9)
    poner(efectos, _golpe(0.35), compas(4))
    poner(efectos, _golpe(0.3), compas(24))
    # Cantes: bolas que botan, el reloj a pulso y las estrellas.
    c = inicio(e_cantes)
    for i in range(2):
        t0 = c + PULSO * (1 + i) + 0.45
        for k, h in enumerate((1.0, 0.45, 0.2)):
            poner(efectos, _madera(0.18 * h, 480 + 60 * i), t0 + k * (math.pi / 7))
    for k in range(8):
        poner(efectos, _tic(0.06), c + COMPAS + k * PULSO)
    for i in range(4):
        poner(efectos, _campana(_nota(81 + 2 * i), 0.05, 1.0), c + 2 * COMPAS + PULSO * (1 + i * 0.5))
    # Clases sueltas: los avisos y los preparadores que se encienden.
    c = inicio(e_clases)
    for t0 in (c + 0.35, c + 2 * COMPAS + 0.35):
        poner(efectos, _campana(_nota(88), 0.07, 1.2), t0)
        poner(efectos, _campana(_nota(93), 0.07, 1.4), t0 + 0.13)
    for k in range(6):
        poner(efectos, _toque(0.05), c + COMPAS + 0.25 + k * MEDIO)
    # Tu preparador: el teclado.
    c = inicio(e_mi_preparador)
    for i in range(6):
        poner(efectos, _tic(0.08), c + 0.2 + i * MEDIO * 0.75)
    poner(efectos, _campana(_nota(86), 0.06, 1.0), c + 0.3 + 6 * MEDIO * 0.75)

    # Organización: los ficheros llegan al móvil y la probabilidad sube.
    c = inicio(e_organizacion)
    for i in range(3):
        poner(efectos, _toque(0.05), c + COMPAS + PULSO * (1.4 + i * 0.5) + 0.5)
    poner(efectos, _subida(300, 1200, 1.1, 0.03), c + 2 * COMPAS + 0.3)

    # «Sidechain»: el bombo hace respirar al colchón y al arpegio.
    golpes = np.convolve(np.abs(bombos), np.ones(int(0.01 * SR)) / int(0.01 * SR), mode='same')
    env = np.clip(golpes / (golpes.max() + 1e-9), 0, 1)
    env = np.convolve(env, np.ones(int(0.12 * SR)) / int(0.12 * SR), mode='same')
    env = np.clip(env / (env.max() + 1e-9), 0, 1)
    total = musica * (1 - 0.45 * env) + ritmo + bombos + efectos
    total = total[: int(DURACION * SR)]
    # Entrada y salida suaves, y normalización.
    total[: int(0.05 * SR)] *= np.linspace(0, 1, int(0.05 * SR))
    fin = int(1.6 * SR)
    total[-fin:] *= np.linspace(1, 0, fin)
    total *= 0.89 / max(1e-9, np.abs(total).max())
    estereo = np.repeat((total * 32767).astype('<i2')[:, None], 2, axis=1)
    with wave.open(ruta, 'wb') as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(estereo.tobytes())


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'), help='ruta de ffmpeg')
    p.add_argument('--solo-fotogramas', metavar='DIR', help='guarda fotogramas de muestra en DIR y termina (para revisar el montaje)')
    p.add_argument('--solo-capturas', action='store_true', help='solo exporta las capturas ligeras para la web')
    p.add_argument('--solo-sonido', metavar='WAV', help='solo genera la banda sonora en WAV (para escucharla)')
    args = p.parse_args()
    exportar_capturas()
    if args.solo_capturas:
        return
    if args.solo_sonido:
        banda_sonora(args.solo_sonido)
        return
    if args.solo_fotogramas:
        os.makedirs(args.solo_fotogramas, exist_ok=True)
        for b in range(25):
            for frac in (0.15, 0.6, 0.95):
                t = compas(b) + COMPAS * frac
                fotograma(t).save(os.path.join(args.solo_fotogramas, f't{t:05.2f}.jpg'), quality=82)
        for t in (0.3, 0.8, 1.3, 2.0, 3.2, 53.5, 55.0, 58.0):
            fotograma(t).save(os.path.join(args.solo_fotogramas, f't{t:05.2f}.jpg'), quality=82)
        return

    if not args.ffmpeg:
        sys.exit('No se encuentra ffmpeg: indícalo con --ffmpeg o con la variable FFMPEG.')
    salida = os.path.join(PROMO, 'oposicion-tcee.mp4')
    sonido = os.path.join(tempfile.gettempdir(), 'oposicion-tcee-sonido.wav')
    banda_sonora(sonido)
    orden = [
        args.ffmpeg, '-y', '-loglevel', 'error',
        '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{ANCHO}x{ALTO}', '-r', str(FPS), '-i', '-',
        '-i', sonido,
        '-c:v', 'libx264', '-preset', 'slow', '-crf', '20', '-pix_fmt', 'yuv420p',
        '-c:a', 'aac', '-b:a', '160k', '-shortest', '-movflags', '+faststart', salida,
    ]
    proceso = subprocess.Popen(orden, stdin=subprocess.PIPE)
    total = DURACION * FPS
    for i in range(total):
        proceso.stdin.write(fotograma(i / FPS).tobytes())
        if i % 150 == 0:
            print(f'{i // FPS:>2} s de {DURACION}', flush=True)
    proceso.stdin.close()
    if proceso.wait() != 0:
        sys.exit('ffmpeg ha fallado')
    fotograma(3.4).save(os.path.join(PROMO, 'poster.jpg'), quality=88, optimize=True)
    print(f'{salida}: {os.path.getsize(salida) / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
