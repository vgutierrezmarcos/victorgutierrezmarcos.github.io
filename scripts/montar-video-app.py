#!/usr/bin/env python3
"""
Monta el vídeo promocional de la app (un minuto, 1920 × 1080, con una banda
sonora propia generada aquí) a partir de las capturas de app/promo/capturas/.

    python3 scripts/montar-video-app.py [--ffmpeg RUTA] [--solo-fotogramas DIR]

Requisitos: Pillow, numpy y ffmpeg (por ejemplo, el binario estático que trae el
paquete imageio-ffmpeg). Las capturas se regeneran con
`flutter test tool/capturas_test.dart --update-goldens` y, las de DCE,
`flutter test tool/capturas_dce_test.dart --update-goldens`, desde app/.

Salida, en app/promo/: oposicion-tcee.mp4, poster.jpg y una versión ligera de
cada captura (720 px de ancho, WebP) para la página app/index.html. Los PNG
originales de app/promo/capturas/ no se suben al repositorio.

Autor: Víctor Gutiérrez Marcos
"""
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


# Cada escena: (inicio, fin, rótulo, título, texto, capturas)
# Cada escena: (inicio, fin, rótulo, título, texto, capturas). Las capturas
# están repartidas a partes iguales entre TCEE y DCE; una que empieza por «@»
# se pinta en un portátil (la app en el ordenador).
ESCENAS = [
    (4.5, 10, 'DOS OPOSICIONES', 'TCEE o DCE:\nelige la tuya', 'Cada una con su temario, su examen, sus probabilidades y sus preparadores. Lo de cada una se guarda aparte.', ['elegir-oposicion', 'hoy', 'dce-hoy']),
    (10, 16, 'TEMARIO', 'Todo el temario,\ndentro de la app', 'Los PDF de TCEE y los apuntes de DCE se leen sin salir de la app, y cada tema lleva su agenda: apuntes para la próxima vuelta, vueltas y notas.', ['temario-temas', 'tema-pdf', 'dce-tema-web']),
    (16, 21.5, 'CANTES', 'Programa, sortea,\ncanta y anota', 'Agenda con avisos, cantes presenciales u online, sorteo como en el examen, cronómetro y diario.', ['cantes-agenda', 'dce-cantar']),
    (21.5, 26, 'TEST', 'Los test oficiales,\ncon tu historial', 'El simulador de la web en el móvil, con las mismas preguntas. En DCE, como práctica voluntaria.', ['test-estadisticas', 'dce-test']),
    (26, 30, 'PROBABILIDADES', '¿Qué probabilidad\nllevas?', 'La de que salga un tema que te sabes, con las reglas del examen de cada oposición.', ['probabilidades', 'dce-probabilidades']),
    (30, 41, 'CLASES SUELTAS', '¿Te cancelan la clase?\nOtro preparador te la coge', 'Pide el cante a preparadores verificados: el día, una franja de horas y los temas que llevas. Quien lo coge elige la hora y os pasáis el WhatsApp.', ['cante-cancelado', 'dce-buscar-preparador', 'peticion-cogida']),
    (41, 47, 'PREPARADORES', 'Tu preparador\ny tú, enlazados', 'Su semana con todas las clases, la ficha de cada alumno y el tablón de sustituciones de cada oposición.', ['dce-preparador', 'semana', 'dce-sustituciones']),
    (47, 53, 'EN EL ORDENADOR', 'También en el ordenador,\ntodo sincronizado', 'La misma app en el navegador, con tu cuenta de Google: lo que haces en el móvil aparece en el ordenador, y al revés.', ['@dce-escritorio']),
]
INICIO_CIERRE = 53
FUNDIDO = 0.45  # segundos de fundido entre escenas


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


def fondo_claro():
    f = degradado((ANCHO, ALTO), FONDO, FONDO_2).convert('RGB')
    d = ImageDraw.Draw(f)
    # Cabecera de la web: banda morada con la línea dorada.
    f.paste(degradado((ANCHO, 84), TINTA, TINTA_CLARA), (0, 0))
    f.paste(linea_dorada(ANCHO, 6), (0, 84))
    ic = icono(52)
    f.paste(ic, (64, 16), ic)
    d.text((132, 42), 'Oposición TCEE · DCE', font=serif(34), fill=BLANCO, anchor='lm')
    return f


def fondo_oscuro():
    f = degradado((ANCHO, ALTO), TINTA_CLARA, TINTA)
    f.paste(linea_dorada(ANCHO, 8), (0, ALTO - 8))
    return f


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


def onda(capa, centro, t, tam):
    """Onda que sale del icono (como un impacto en la diana)."""
    if not 0 < t < 1.2:
        return
    d = ImageDraw.Draw(capa)
    for retraso in (0, 0.25):
        x = (t - retraso) / 0.95
        if not 0 < x < 1:
            continue
        r = tam * 0.5 + tam * 1.1 * suave(x)
        alfa = round(150 * (1 - x))
        d.ellipse((centro[0] - r, centro[1] - r, centro[0] + r, centro[1] + r), outline=(218, 165, 32, alfa), width=4)


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


def bloque_texto(rotulo, titulo, texto, ancho):
    """Rótulo, título y descripción de una escena, sobre fondo transparente."""
    img = Image.new('RGBA', (ancho, 720), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    y = 0
    f_rotulo = sans(30, 'Bold')
    d.text((0, y), rotulo, font=f_rotulo, fill=TINTA_CLARA)
    # Subrayado con rombo, como .section-title de la web.
    largo = round(f_rotulo.getlength(rotulo))
    y += 48
    d.rectangle((0, y, largo, y + 3), fill=TINTA_CLARA)
    y += 40
    # El título se reduce lo justo para que su línea más larga quepa.
    tam = 76
    while max(serif(tam).getlength(linea) for linea in titulo.split('\n')) > ancho:
        tam -= 2
    f_titulo = serif(tam)
    for linea in titulo.split('\n'):
        d.text((0, y), linea, font=f_titulo, fill=TEXTO)
        y += round(tam * 1.21)
    y += 26
    d.rectangle((0, y, 110, y + 5), fill=DORADO)
    y += 40
    f_texto = sans(36)
    for linea in partir(texto, f_texto, ancho):
        d.text((0, y), linea, font=f_texto, fill=TEXTO_SUAVE)
        y += 50
    return img.crop((0, 0, ancho, y + 10))


def con_opacidad(img, alfa):
    if alfa >= 0.999:
        return img
    copia = img.copy()
    copia.putalpha(img.getchannel('A').point(lambda v: round(v * alfa)))
    return copia


class Escena:
    def __init__(self, inicio, fin, rotulo, titulo, texto, capturas):
        self.inicio, self.fin = inicio, fin
        self.titulo_rotulo = rotulo
        self.texto = bloque_texto(rotulo, titulo, texto, 620)
        n = len(capturas)
        if n == 1 and capturas[0].startswith('@'):
            img, margen = portatil(capturas[0][1:], 880)
            self.moviles = [(img, margen)]
            self.posiciones = [(770 + (ANCHO - 770 - img.width) // 2, 90 + (ALTO - 90 - img.height) // 2)]
            self.retrasos = [0.25]
            return
        ancho = {1: 400, 2: 380, 3: 318}[n]
        self.moviles = [movil(c, ancho) for c in capturas]
        m0, margen = self.moviles[0]
        paso = m0.width - 2 * margen + 34
        total = paso * (n - 1) + m0.width - 2 * margen
        # Los móviles se centran en la parte derecha de la pantalla, a partir de x = 770.
        x0 = 770 + (ANCHO - 770 - 50 - total) // 2 - margen
        self.posiciones = [(x0 + i * paso, 84 + 6 + (ALTO - 90 - m0.height) // 2 + (26 if n == 3 and i == 1 else 0)) for i in range(n)]
        # Cada móvil entra un poco después que el anterior.
        self.retrasos = [0.2 + i * (1.2 if n > 1 else 0) for i in range(n)]

    def pintar(self, lienzo, t):
        dt = t - self.inicio
        entrada = suave(dt / 0.7)
        y_texto = 84 + (ALTO - 84 - self.texto.height) // 2
        capa = con_opacidad(self.texto, entrada)
        lienzo.paste(capa, (90 - round(40 * (1 - entrada)), y_texto), capa)
        for (img, _), (x, y), retraso in zip(self.moviles, self.posiciones, self.retrasos):
            a = suave((dt - retraso) / 0.8)
            if a <= 0:
                continue
            capa = con_opacidad(img, a)
            lienzo.paste(capa, (x, y + round(70 * (1 - a))), capa)


def portada(lienzo, t):
    """0-5 s: la app (icono, nombre y para qué es), sin capturas."""
    # El logo se monta primero; el texto entra cuando ya está.
    a = suave((t - 1.0) / 0.7)
    capa = Image.new('RGBA', (ANCHO, 900), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    ic = logo_animado(190, t)
    onda(capa, (ANCHO // 2, ic.height // 2), t - 1.05, 190)
    capa.paste(ic, ((ANCHO - ic.width) // 2, 0), ic)
    texto = Image.new('RGBA', capa.size, (0, 0, 0, 0))
    c = ImageDraw.Draw(texto)
    c.text((ANCHO // 2, 330), 'Oposición TCEE · DCE', font=serif(104), fill=BLANCO, anchor='mm')
    c.rectangle((ANCHO // 2 - 160, 412, ANCHO // 2 + 160, 417), fill=DORADO_CLARO)
    c.text((ANCHO // 2, 482), 'La app para preparar las oposiciones a', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    c.text((ANCHO // 2, 540), 'Técnico Comercial y Economista del Estado', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    c.text((ANCHO // 2, 598), 'y a Diplomado Comercial del Estado', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    # Dónde se usa, en etiquetas.
    b = suave((t - 1.8) / 0.6)
    if b > 0:
        etiquetas = ['App para Android', 'En el navegador', 'Gratis']
        f = sans(38, 'Semibold')
        anchos = [f.getlength(e) + 64 for e in etiquetas]
        x = (ANCHO - sum(anchos) - 28 * (len(anchos) - 1)) / 2
        for e, w in zip(etiquetas, anchos):
            c.rounded_rectangle((x, 668, x + w, 736), 34, outline=(240, 232, 248, round(255 * b)), width=3)
            c.text((x + w / 2, 702), e, font=f, fill=(255, 255, 255, round(255 * b)), anchor='mm')
            x += w + 28
    texto = con_opacidad(texto, a)
    capa.paste(texto, (0, round(30 * (1 - a))), texto)
    lienzo.paste(capa, (0, 110), capa)


def cierre(lienzo, t):
    """53-60 s: el logo vuelve a montarse, con su onda, y el nombre de la app."""
    a = suave((t - 0.6) / 0.7)
    fondo = Image.new('RGBA', (ANCHO, 700), (0, 0, 0, 0))
    ic = logo_animado(170, t * 1.4)
    onda(fondo, (ANCHO // 2, ic.height // 2 - 31), t - 0.8, 170)
    fondo.paste(ic, ((ANCHO - ic.width) // 2, -31), ic)
    capa = Image.new('RGBA', (ANCHO, 700), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    c.text((ANCHO // 2, 270), 'Oposición TCEE · DCE', font=serif(96), fill=BLANCO, anchor='mm')
    c.text((ANCHO // 2, 380), 'Gratis · Sin anuncios · Android y navegador', font=sans(46, 'Medium'), fill=(240, 232, 248), anchor='mm')
    c.rectangle((ANCHO // 2 - 150, 440, ANCHO // 2 + 150, 445), fill=DORADO_CLARO)
    b = suave((t - 1.4) / 0.8)
    if b > 0:
        c.text((ANCHO // 2, 520), 'Apuntes de TCEE: victorgutierrezmarcos.es  ·  Apuntes de DCE: manuelcabadogarcia.es', font=sans(36, 'Medium'), fill=(240, 232, 248, round(255 * b)), anchor='mm')
    capa = con_opacidad(capa, a)
    fondo.paste(capa, (0, round(30 * (1 - a))), capa)
    lienzo.paste(fondo, (0, 250), fondo)


def progreso(lienzo, t):
    """Barra dorada de avance al pie."""
    ImageDraw.Draw(lienzo).rectangle((0, ALTO - 8, round(ANCHO * t / DURACION), ALTO), fill=DORADO_CLARO)


def fotograma(t):
    """Imagen del instante [t] (en segundos)."""
    def base(t):
        if t < ESCENAS[0][0]:
            img = FONDO_OSCURO.copy()
            portada(img, t)
            return img
        if t >= INICIO_CIERRE:
            img = FONDO_OSCURO.copy()
            cierre(img, t - INICIO_CIERRE)
            return img
        escena = next(e for e in OBJ_ESCENAS if e.inicio <= t < e.fin)
        img = FONDO_CLARO.copy()
        escena.pintar(img, t)
        progreso(img, t)
        return img

    img = base(t)
    # Fundido desde el final de la escena anterior.
    for corte in CORTES:
        if corte <= t < corte + FUNDIDO:
            anterior = base(corte - 1e-3)
            return Image.blend(anterior, img, suave((t - corte) / FUNDIDO))
    return img



# ------------------------------------------------------------------ Sonido
# Banda sonora propia (sin derechos de terceros), generada a partir de los
# tiempos de las escenas para que vaya siempre acompasada con la imagen:
# piano en arpegios (más suave en el cuerpo del vídeo) y colchón de cuerdas con
# un acorde por escena, el logo que «suena» al montarse, un barrido suave en
# cada corte, el reloj del cronómetro y la notificación de la clase cogida.

SR = 44100


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


def _cuerdas(fs, dur, vel):
    n = int(dur * SR)
    t = np.arange(n) / SR
    onda = sum(np.sin(2 * np.pi * f * t) + 0.3 * np.sin(2 * np.pi * f * 1.003 * t) for f in fs) / len(fs)
    ent = np.minimum(1.0, t / 0.6)
    sal = np.minimum(1.0, (dur - t) / 0.6)
    return vel * onda * ent * np.clip(sal, 0, 1)


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


def _barrido(vel, dur=0.5):
    """Ruido filtrado que crece y se apaga (cambio de escena)."""
    n = int(dur * SR)
    ruido = np.random.default_rng(7).standard_normal(n)
    k = 60
    ruido = np.convolve(ruido, np.ones(k) / k, mode='same')
    t = np.arange(n) / SR
    env = np.sin(np.pi * t / dur) ** 2
    return vel * ruido * env * 3


def banda_sonora(ruta):
    import wave
    total = np.zeros(int((DURACION + 2) * SR))

    def poner(muestra, t, pan=0.0):
        i = int(t * SR)
        j = min(len(total), i + len(muestra))
        if 0 <= i < len(total):
            total[i:j] += muestra[: j - i]

    # Un acorde por escena (re mayor), en el orden de las escenas.
    acordes = {
        'portada': [50, 57, 62, 66, 69], 'DOS OPOSICIONES': [47, 54, 59, 62, 66], 'TEMARIO': [43, 50, 55, 59, 62],
        'CANTES': [45, 52, 57, 61, 64], 'TEST': [42, 49, 54, 57, 61], 'PROBABILIDADES': [43, 50, 55, 59, 62],
        'CLASES SUELTAS': [40, 47, 52, 55, 59], 'PREPARADORES': [45, 52, 57, 61, 64], 'EN EL ORDENADOR': [47, 54, 59, 62, 66],
        'cierre': [50, 57, 62, 66, 69],
    }
    tramos = [(0, ESCENAS[0][0], 'portada')] + [(e[0], e[1], e[2]) for e in ESCENAS] + [(INICIO_CIERRE, DURACION, 'cierre')]
    corchea = 60 / 96 / 2
    patron = [0, 1, 2, 3, 4, 3, 2, 1]
    for ini, fin, nombre in tramos:
        notas = acordes[nombre]
        # Bajo y cuerdas sostenidos todo el tramo.
        cuerpo = nombre not in ('portada', 'cierre')
        poner(_cuerdas([_nota(m + 12) for m in notas[1:4]], fin - ini + 0.5, 0.06 if cuerpo else 0.05), ini)
        poner(_piano(_nota(notas[0] - 12), min(3.0, fin - ini + 0.6), 0.06 if cuerpo else 0.10), ini)
        # Arpegio: en la portada empieza cuando el logo ya está montado. En el
        # cuerpo del vídeo, más suave (una nota por pulso y menos volumen),
        # para que acompañe sin distraer.
        extremo = nombre in ('portada', 'cierre')
        paso = corchea if extremo else 2 * corchea
        fuerte, flojo = (0.075, 0.055) if extremo else (0.046, 0.036)
        t = ini + (1.0 if nombre == 'portada' else 0)
        i = 0
        while t < fin - 0.05 and not (nombre == 'cierre' and t > ini + 3.2):
            n = notas[patron[i % len(patron)]] + 12
            poner(_piano(_nota(n), 1.8, flojo if i % 2 else fuerte), t)
            t += paso
            i += 1
    # Cierre: acorde final que resuelve.
    for m in acordes['cierre']:
        poner(_piano(_nota(m + 12), 4.0, 0.07), INICIO_CIERRE + 3.3)

    # El logo al montarse (portada y cierre, que va 1,4 veces más deprisa).
    for base, vel in ((0.0, 1.0), (INICIO_CIERRE, 1 / 1.4)):
        poner(_golpe(0.35), base + 0.62 * vel)
        for k, (inicio, nota) in enumerate(((0.5, 86), (0.68, 90), (0.86, 93))):
            poner(_campana(_nota(nota), 0.09), base + (inicio + 0.12) * vel)
    poner(_campana(_nota(74), 0.12, 3.5), INICIO_CIERRE + 3.3)

    # Un barrido suave en cada corte (sin sonido al entrar cada captura).
    for e in OBJ_ESCENAS:
        poner(_barrido(0.025), e.inicio - 0.25)
    poner(_barrido(0.03), INICIO_CIERRE - 0.25)

    # Cantes: el reloj del cronómetro, al entrar el segundo móvil.
    cantes = next(e for e in OBJ_ESCENAS if e.titulo_rotulo == 'CANTES')
    t0 = cantes.inicio + cantes.retrasos[-1] + 0.4
    for k in range(6):
        poner(_tic(0.025 if k % 2 else 0.035), t0 + k * 0.5)
    # Clases sueltas: notificación cuando aparece la clase cogida (tercer móvil).
    clases = next(e for e in OBJ_ESCENAS if e.titulo_rotulo == 'CLASES SUELTAS')
    tn = clases.inicio + clases.retrasos[-1] + 0.35
    poner(_campana(_nota(88), 0.06, 1.2), tn)
    poner(_campana(_nota(93), 0.06, 1.4), tn + 0.13)

    total = total[: int(DURACION * SR)]
    # Fundido final y normalización.
    fin = int(1.5 * SR)
    total[-fin:] *= np.linspace(1, 0, fin)
    total *= 0.89 / max(1e-9, np.abs(total).max())
    estereo = np.repeat((total * 32767).astype('<i2')[:, None], 2, axis=1)
    with wave.open(ruta, 'wb') as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(estereo.tobytes())


def preparar():
    global FONDO_CLARO, FONDO_OSCURO, OBJ_ESCENAS, CORTES
    FONDO_CLARO, FONDO_OSCURO = fondo_claro(), fondo_oscuro()
    OBJ_ESCENAS = [Escena(*e) for e in ESCENAS]
    CORTES = [e[0] for e in ESCENAS] + [INICIO_CIERRE]


def exportar_capturas():
    """Versión ligera de cada captura para la página web."""
    for fichero in sorted(os.listdir(CAPTURAS)):
        if not fichero.endswith('.png'):
            continue
        img = Image.open(os.path.join(CAPTURAS, fichero)).convert('RGB')
        img = img.resize((720, round(img.height * 720 / img.width)), Image.LANCZOS)
        img.save(os.path.join(PROMO, fichero[:-4] + '.webp'), quality=82, method=6)


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'), help='ruta de ffmpeg')
    p.add_argument('--solo-fotogramas', metavar='DIR', help='guarda un fotograma de cada escena en DIR y termina (para revisar el montaje)')
    p.add_argument('--solo-capturas', action='store_true', help='solo exporta las capturas ligeras para la web')
    p.add_argument('--solo-sonido', metavar='WAV', help='solo genera la banda sonora en WAV (para escucharla)')
    args = p.parse_args()
    exportar_capturas()
    if args.solo_capturas:
        return
    preparar()
    if args.solo_sonido:
        banda_sonora(args.solo_sonido)
        return

    if args.solo_fotogramas:
        os.makedirs(args.solo_fotogramas, exist_ok=True)
        for t in [0.2, 0.45, 0.7, 0.9, 1.2, 3, 7, 13, 18, 24, 28, 35, 44, 50, 53.4, 54.2, 58]:
            fotograma(t).save(os.path.join(args.solo_fotogramas, f't{t:05.1f}.jpg'), quality=85)
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
        '-c:v', 'libx264', '-preset', 'slow', '-crf', '21', '-pix_fmt', 'yuv420p',
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
    fotograma(3).save(os.path.join(PROMO, 'poster.jpg'), quality=88, optimize=True)
    print(f'{salida}: {os.path.getsize(salida) / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
