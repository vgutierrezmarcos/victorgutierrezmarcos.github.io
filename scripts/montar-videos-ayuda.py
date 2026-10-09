#!/usr/bin/env python3
"""
Monta los vídeos de ayuda de la app: verticales (1080 × 1920), de menos de un
minuto, sin voz, con un rótulo grande para cada paso y un dedo que toca en la
pantalla lo que se nombra. Los guiones están en app/promo/ayuda/GUIONES.md y,
como datos, en VIDEOS (abajo).

    python3 scripts/montar-videos-ayuda.py [--ffmpeg RUTA] [--solo ID ...] [--solo-fotogramas DIR]

Las pantallas salen de `flutter test tool/capturas_ayuda_test.dart
--update-goldens` (desde app/): una carpeta por vídeo en
app/promo/ayuda/capturas/, con un PNG por pantalla y pasos.json, que dice dónde
se toca en cada una. Reutiliza el dibujo y los sonidos del vídeo promocional
(scripts/montar-video-app.py).

Salida, en app/promo/ayuda/: <id>.mp4 y <id>.jpg (póster) de cada vídeo.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import importlib.util
import json
import math
import os
import shutil
import subprocess
import sys
import tempfile

import numpy as np
from PIL import Image, ImageDraw, ImageFilter

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AYUDA = os.path.join(RAIZ, 'app', 'promo', 'ayuda')
CAPTURAS = os.path.join(AYUDA, 'capturas')

_spec = importlib.util.spec_from_file_location('promo', os.path.join(RAIZ, 'scripts', 'montar-video-app.py'))
promo = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(promo)

ANCHO, ALTO, FPS = 1080, 1920, 30
# El fondo del promocional se dibuja a la medida de su lienzo.
promo.ANCHO, promo.ALTO = ANCHO, ALTO

TINTA, TINTA_CLARA, DORADO, DORADO_CLARO = promo.TINTA, promo.TINTA_CLARA, promo.DORADO, promo.DORADO_CLARO
TEXTO, TEXTO_SUAVE, BLANCO, CREMA = promo.TEXTO, promo.TEXTO_SUAVE, promo.BLANCO, promo.CREMA
cache, entre, suave, rebote, pegar, fuente, palabra = promo.cache, promo.entre, promo.suave, promo.rebote, promo.pegar, promo.fuente, promo.palabra

OPOSITOR, PREPARADOR = 'Para opositores', 'Para preparadores'

# ======================================================================= Guiones
# Cada paso: (rótulo, pantallas[, opciones]). En el rótulo, lo que va entre
# corchetes se resalta. Opciones: 'aviso' = (título, texto) de una notificación
# que llega en la última pantalla del paso.
VIDEOS = {
    'reservar-clase': {
        'titulo': 'Reserva clase con tu preparador', 'para': OPOSITOR,
        'pasos': [
            ('En Cantes, toca [Añadir]', ['agenda']),
            ('Elige [Reservar clase con mi preparador]', ['hoja']),
            ('Toca uno de sus [huecos libres]', ['huecos']),
            ('Si quieres, deja una nota y toca [Pedir]', ['pedir', 'nota']),
            ('Queda [pendiente de confirmar]', ['pendiente']),
            ('[Aceptada]: ya está en tu agenda, con aviso la víspera', ['aceptada'], {'aviso': ('Paula Pérez ha aceptado tu clase', 'Reserva aceptada')}),
        ],
        'cierre': '¿No ves huecos? Tu preparador tiene que abrir las reservas.',
    },
    'clase-suelta': {
        'titulo': '¿Te cancelan? Pide una clase suelta', 'para': OPOSITOR,
        'pasos': [
            ('Si tu preparador cancela, lo ves en tu agenda', ['agenda', 'cancelada']),
            ('Elige el día y una [franja de horas]', ['franja']),
            ('Presencial, online o [me da igual]', ['modalidad']),
            ('Revisa los [temas] que llevas', ['temas']),
            ('Tu teléfono, para que te escriban por [WhatsApp]', ['contacto', 'a-todos']),
            ('Se la mandas a [todos los preparadores verificados]', ['enviada']),
            ('Uno la coge: [te llega un aviso] y le escribes', ['cogida'], {'aviso': ('Olga Martín te coge la clase', 'Sábado, a las 18:30')}),
        ],
        'cierre': 'Tu nombre y tu teléfono solo los ve quien la coge.',
    },
    'conectar-preparador': {
        'titulo': 'Conecta con tu preparador', 'para': OPOSITOR,
        'pasos': [
            ('En Más, toca [Mi preparador]', ['mas']),
            ('Escribe el [código de 6 letras] de tu preparador', ['mi-preparador', 'codigo']),
            ('Sus clases y sus materiales [ya están en tu app]', ['conectado']),
            ('[Qué ve]: tus temas y tus cantes. Ni tus tests ni tus notas', ['que-ve']),
        ],
        'cierre': 'Puedes dejar de compartir cuando quieras.',
    },
    'buscar-preparador': {
        'titulo': 'Busca preparador', 'para': OPOSITOR,
        'pasos': [
            ('En Mi preparador, toca [Buscar preparador]', ['mi-preparador']),
            ('Mira quién [admite alumnos]: escríbele o mira su LinkedIn', ['buscar', 'admiten']),
            ('O toca [Cuenta lo que buscas]', ['cuenta']),
            ('Ejercicio, cuándo puedes, desde cuándo. [Sin tu nombre ni tu teléfono]', ['formulario', 'cuando']),
            ('A quien le interese te deja su contacto. [Le escribes tú]', ['interesados'], {'aviso': ('Olga Martín quiere prepararte', 'Te ha dejado su contacto')}),
        ],
        'cierre': 'Cuando os pongáis de acuerdo, conecta con su código.',
    },
    'cronograma': {
        'titulo': 'Tu cronograma', 'para': OPOSITOR,
        'pasos': [
            ('En Organización, toca [Cronograma]', ['organizacion', 'vacio']),
            ('[Generarlo]: tú eliges temas y ritmo', ['como']),
            ('La [vuelta] y los temas', ['vuelta']),
            ('El [ritmo]: temas por semana o fecha de fin', ['ritmo']),
            ('La app propone el [orden] por bloques y conexiones', ['orden']),
            ('Semana a semana, marca lo que estudias', ['creado']),
            ('En Hoy ves [lo que te toca esta semana]', ['hoy']),
        ],
        'cierre': '¿Ya tienes uno? Tráelo desde un Excel, un Word o un PDF.',
    },
    'clase': {
        'titulo': 'La clase con tu preparador', 'para': OPOSITOR,
        'pasos': [
            ('En la clase, entra con el [enlace de Meet] o de Teams', ['clase']),
            ('Si te ha mandado los temas, a su hora: [Empezar el esquema]', ['temas', 'esquema']),
            ('[Cronómetro compartido]: los dos veis el mismo tiempo', ['compartir', 'compartido', 'corriendo']),
            ('[Pantalla grande] para verlo de lejos', ['arriba', 'grande']),
            ('[Pizarra compartida]: lo que dibuja uno lo ve el otro', ['pizarra']),
            ('Su [valoración] queda en tu diario', ['diario']),
        ],
        'cierre': 'En la pizarra solo se comparte lo que dibujáis en ella.',
    },
    'empezar-preparador': {
        'titulo': 'Empieza como preparador', 'para': PREPARADOR,
        'pasos': [
            ('En Mi preparador, toca [¿Preparas a opositores?]', ['mi-preparador']),
            ('[Darme de alta como preparador]', ['presentacion', 'alta']),
            ('Solo hace falta tu [nombre] y tus ejercicios', ['nombre', 'datos', 'enviar']),
            ('Otro preparador verificado [te verifica]', ['codigo'], {'aviso': ('Ya estás verificado', 'Olga Martín te ha verificado')}),
            ('Dale tu [código] a tus alumnos: ves sus temas y sus cantes', ['codigo']),
        ],
        'cierre': 'Sus clases y valoraciones nunca las ve nadie más.',
    },
    'huecos-reservas': {
        'titulo': 'Abre huecos y acepta reservas', 'para': PREPARADOR,
        'pasos': [
            ('En Preparador, toca [Ajustes de preparador]', ['preparador']),
            ('Activa [Mis alumnos pueden reservar clase]', ['reservas']),
            ('En Huecos semanales, añade un [hueco]', ['activadas', 'hueco', 'dia', 'martes']),
            ('Tus alumnos solo ven tus [huecos libres]', ['huecos']),
            ('Cuando piden uno, [Aceptar] o rechazar', ['por-confirmar'], {'aviso': ('Marta ha pedido clase', 'Domingo 11, 19:00–21:00')}),
            ('Ya está en tu agenda [y en la suya]', ['aceptada']),
        ],
        'cierre': 'Las reservas vienen desactivadas: las abres tú.',
    },
    'programar-clase': {
        'titulo': 'Programa una clase y manda los temas', 'para': PREPARADOR,
        'pasos': [
            ('En Preparador, toca [Clase]', ['preparador']),
            ('El [alumno], el día y la hora, o una clase fija', ['nueva', 'alumna']),
            ('[Online]: con el enlace vacío, Meet crea la reunión', ['cuando', 'online']),
            ('En la clase, [Mandarle los temas antes]', ['ficha', 'mandar']),
            ('1 o 2 temas: los eliges o [a suerte]', ['cuantos', 'suerte']),
            ('[Cuándo le llegan]: como en el examen o a tu hora', ['cuando-llegan']),
            ('Hasta entonces [no puede verlos]', ['programado']),
        ],
        'cierre': 'A su hora le llega con «Empezar el esquema».',
    },
    'coger-clase': {
        'titulo': 'Coge una clase suelta', 'para': PREPARADOR,
        'pasos': [
            ('En Preparador, toca [Tablón de clases sueltas]', ['preparador']),
            ('Día, franja y temas, [sin el nombre] del alumno', ['tablon']),
            ('Toca [Lo cojo]', ['confirmar']),
            ('Elige la [hora] dentro de su franja', ['hora']),
            ('[Es tuya]: tenéis el contacto del otro', ['cogida']),
            ('Ya está en [tu semana]', ['semana']),
        ],
        'cierre': 'Activa los avisos de clases sueltas en Ajustes.',
    },
    'materiales': {
        'titulo': 'Comparte materiales', 'para': PREPARADOR,
        'pasos': [
            ('En Preparador, toca [Materiales para tus alumnos]', ['preparador']),
            ('Toca [Material]', ['lista']),
            ('Un título y el [enlace]: Drive, un PDF, un vídeo…', ['nuevo', 'titulo', 'enlace']),
            ('Si es de un tema, elige el [tema]', ['elegir-tema', 'buscar-tema']),
            ('Para todos tus alumnos o solo algunos. [Compartir]', ['tema'], {'aviso': ('Paula Pérez ha compartido material', 'Esquema del tema 3.B.5')}),
        ],
        'cierre': 'Lo ven en «Mi preparador» y dentro de ese tema.',
    },
}

# ======================================================================= Tiempos
INTRO, CIERRE = 2.6, 3.4
CON_TOQUE, SIN_TOQUE = 2.9, 2.4
CRUCE = 0.35          # fundido entre pantallas
T_TOQUE = 1.75        # instante del toque dentro de una pantalla con toque


def leer_pasos(vid):
    with open(os.path.join(CAPTURAS, vid, 'pasos.json'), encoding='utf-8') as f:
        return {p['paso']: p.get('toque') for p in json.load(f)}


def linea_de_tiempo(vid):
    """Lista de tramos (inicio, fin, tipo, datos) del vídeo, y su duración."""
    v = VIDEOS[vid]
    toques = leer_pasos(vid)
    tramos, t = [('intro', 0.0, INTRO, None)], INTRO
    for n, paso in enumerate(v['pasos'], 1):
        rotulo, pantallas = paso[0], paso[1]
        op = paso[2] if len(paso) > 2 else {}
        inicio_paso = t
        for i, p in enumerate(pantallas):
            if p not in toques:
                sys.exit(f'{vid}: falta la pantalla «{p}» (¿has regenerado las capturas?)')
            toque = toques[p]
            # En la última pantalla de un paso con aviso no se toca nada.
            ultima = i == len(pantallas) - 1
            if ultima and op.get('aviso'):
                toque = None
            dur = CON_TOQUE if toque else SIN_TOQUE
            # El rótulo largo necesita tiempo para leerse.
            if i == 0:
                dur = max(dur, 1.4 + 0.075 * len(rotulo))
            if ultima and op.get('aviso'):
                dur += 1.6
            tramos.append(('pantalla', t, t + dur, {'paso': n, 'rotulo': rotulo, 'captura': p, 'toque': toque, 'inicio_paso': inicio_paso,
                                                     'aviso': op.get('aviso') if ultima else None}))
            t += dur
    tramos.append(('cierre', t, t + CIERRE, None))
    return tramos, t + CIERRE


# ======================================================================= Dibujo
def captura(vid, nombre):
    return cache(('ayuda', vid, nombre), lambda: Image.open(os.path.join(CAPTURAS, vid, f'{nombre}.png')).convert('RGB'))


ZONA_MOVIL = (420, 1900)   # y de arriba y de abajo del móvil en el lienzo
ANCHO_MOVIL = 680


def geometria(img):
    """Tamaño de la pantalla en el lienzo y su esquina, centrada en la zona del móvil."""
    if img.width > img.height:   # apaisada (la pizarra)
        w = 1000
    else:
        w = ANCHO_MOVIL
    h = round(img.height * w / img.width)
    x0 = (ANCHO - w) // 2
    y0 = ZONA_MOVIL[0] + (ZONA_MOVIL[1] - ZONA_MOVIL[0] - h) // 2 if img.width > img.height else ZONA_MOVIL[0]
    return w, h, x0, y0


def encuadre(img, toque, z):
    """Recorte de la captura ampliada [z] veces alrededor del toque."""
    W, H = img.size
    if z <= 1.001 or toque is None:
        return (0, 0, W, H)
    x, y, w, h = toque
    cx, cy = x + w / 2, y + h / 2
    cw, ch = W / z, H / z
    x0 = min(max(cx - cw / 2, 0), W - cw)
    y0 = min(max(cy - ch / 2, 0), H - ch)
    return (x0, y0, x0 + cw, y0 + ch)


def zoom_de(toque, img):
    """Cuánto se acerca la cámara: más cuanto más pequeño es lo que se toca."""
    if toque is None:
        return 1.0
    area = toque[2] * toque[3] / (img.width * img.height)
    return 1.45 if area < 0.01 else (1.3 if area < 0.04 else 1.15)


def pantalla(vid, nombre, toque, z):
    """La pantalla (ya en el tamaño del lienzo) con la cámara a [z]; devuelve
    también la caja de recorte para situar el dedo."""
    img = captura(vid, nombre)
    w, h, _, _ = geometria(img)
    caja = encuadre(img, toque, z)
    if 1.001 < z < zoom_de(toque, img) - 0.001:   # durante el acercamiento, sin guardar
        return img.resize((w, h), Image.BILINEAR, box=caja), caja
    return cache(('pant', vid, nombre, z), lambda: img.resize((w, h), Image.LANCZOS, box=caja)), caja


def movil(vid, nombre, toque, z):
    """Móvil completo (armazón y pantalla) como imagen RGBA, y dónde va."""
    pant, caja = pantalla(vid, nombre, toque, z)
    w, h, x0, y0 = geometria(captura(vid, nombre))
    arm, desp, mascara = promo.armazon(w, h)
    img = arm.copy()
    img.paste(pant, (desp, desp), mascara)
    return img, (x0 - desp, y0 - desp), caja


def a_lienzo(vid, nombre, caja, px, py):
    """Punto de la captura (px, py) → lienzo, con el recorte [caja]."""
    img = captura(vid, nombre)
    w, h, x0, y0 = geometria(img)
    sx, sy = w / (caja[2] - caja[0]), h / (caja[3] - caja[1])
    return x0 + (px - caja[0]) * sx, y0 + (py - caja[1]) * sy


def dedo(lienzo, cx, cy, alfa, pulsado, onda):
    """Marca del dedo (como «mostrar toques» de Android) y su onda al tocar."""
    if alfa <= 0.01:
        return
    capa = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(capa)
    if 0 < onda < 1:
        r = 40 + 90 * suave(onda)
        a = round(200 * (1 - onda))
        d.ellipse((cx - r, cy - r, cx + r, cy + r), outline=DORADO_CLARO + (a,), width=7)
    r = 38 * (0.86 if pulsado else 1.0)
    sombra = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(sombra).ellipse((cx - r, cy - r + 8, cx + r, cy + r + 8), fill=round(90 * alfa))
    sombra = sombra.filter(ImageFilter.GaussianBlur(10))
    lienzo.paste((30, 14, 44), (0, 0), sombra)
    d.ellipse((cx - r, cy - r, cx + r, cy + r), fill=(255, 255, 255, round(150 * alfa)), outline=TINTA + (round(230 * alfa),), width=5)
    lienzo.paste(capa, (0, 0), capa)


def fondo():
    def crear():
        img = promo.fondo_luz().copy()
        marca = promo._marca()
        img.paste(marca, (52, 44), marca)
        return img
    return cache('ayuda_fondo', crear)


def partir_marcado(texto, f, ancho):
    """Parte un rótulo con [resaltado] en líneas; devuelve líneas con «*» en las
    palabras resaltadas (el formato de promo.titular)."""
    palabras, dentro = [], False
    for p in texto.split():
        empieza = p.startswith('[')
        if empieza:
            dentro = True
        limpia = p.replace('[', '').replace(']', '')
        palabras.append(('*' if dentro else '') + limpia)
        if p.endswith(']') or (']' in p):
            dentro = False
    lineas, actual = [], []
    for p in palabras:
        prueba = ' '.join(x.lstrip('*') for x in actual + [p])
        if actual and f.getlength(prueba) > ancho:
            lineas.append(' '.join(actual))
            actual = [p]
        else:
            actual.append(p)
    return lineas + [' '.join(actual)]


def numero(n):
    def crear():
        tam = 92
        img = Image.new('RGBA', (tam, tam), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        d.ellipse((0, 0, tam - 1, tam - 1), fill=TINTA_CLARA)
        d.text((tam / 2, tam / 2 + 2), str(n), font=fuente('serif', 54, 'bold'), fill=BLANCO, anchor='mm')
        return img
    return cache(('numero', n), crear)


def rotulo_paso(lienzo, d, t_paso):
    """Número del paso y su rótulo, que entra palabra a palabra."""
    n = numero(d['paso'])
    a = entre(t_paso, 0, 0.3)
    pegar(lienzo, n, 60 + n.width / 2, 196 + n.height / 2, escala=0.6 + 0.4 * rebote(a), alfa=a)
    f = fuente('serif', 62, 'bold')
    lineas = partir_marcado(d['rotulo'], f, ANCHO - 200)
    tam = 62 if len(lineas) <= 3 else 54
    if tam != 62:
        lineas = partir_marcado(d['rotulo'], fuente('serif', tam, 'bold'), ANCHO - 200)
    promo.titular(lienzo, lineas, 176, 190, t_paso, tam=tam, color=TEXTO, acento=TINTA_CLARA, paso=0.045, inicio=0.1, interlinea=1.18)


def cabecera(lienzo, vid):
    v = VIDEOS[vid]
    f = fuente('sans', 30, 'Semibold')
    ImageDraw.Draw(lienzo).text((ANCHO - 52, 70), v['para'], font=f, fill=DORADO, anchor='rm')


def progreso(lienzo, t, total):
    ImageDraw.Draw(lienzo).rectangle((0, ALTO - 8, round(ANCHO * t / total), ALTO), fill=DORADO_CLARO)


def escena_movil(lienzo, vid, d, tl):
    """El móvil en el instante local [tl] de una pantalla, con zoom y dedo,
    dibujado en [lienzo] (una capa transparente)."""
    toque = d['toque']
    img = captura(vid, d['captura'])
    zmax = zoom_de(toque, img)
    dur = d['fin'] - d['inicio']
    z = 1.0
    if toque:
        z = 1 + (zmax - 1) * suave(entre(tl, 0.55, 1.35))
        z = 1 + (z - 1) * (1 - suave(entre(tl, dur - 0.45, dur)))
    z = round(z, 3)
    m, (mx, my), caja = movil(vid, d['captura'], toque, z)
    lienzo.paste(m, (mx, my), m)
    if toque:
        x, y, w, h = toque
        cx, cy = a_lienzo(vid, d['captura'], caja, x + w / 2, y + h / 2)
        llega = suave(entre(tl, 0.75, 1.35))
        alfa = llega * (1 - entre(tl, dur - 0.35, dur - 0.05))
        dx, dy = 120 * (1 - llega), 160 * (1 - llega)
        pulsado = T_TOQUE <= tl < T_TOQUE + 0.22
        onda = (tl - T_TOQUE) / 0.6
        dedo(lienzo, cx + dx, cy + dy, alfa, pulsado, onda)
    if d.get('aviso'):
        titulo, texto = d['aviso']
        av = promo.aviso(titulo, texto, DORADO_CLARO, ancho=760)
        a = entre(tl, 0.9, 1.4)
        if a > 0:
            y = ZONA_MOVIL[0] - 40 + 150 * rebote(a)
            pegar(lienzo, av, ANCHO / 2, y + av.height / 2, alfa=min(1.0, a * 2))


def capa_movil(vid, tramos, i, t):
    _, ini, fin, d = tramos[i]
    capa = Image.new('RGBA', (ANCHO, ALTO), (0, 0, 0, 0))
    escena_movil(capa, vid, dict(d, inicio=ini, fin=fin), t - ini)
    return capa


def fotograma_movil(vid, tramos, total, t, i):
    """Fondo y rótulo del paso, y el móvil; al cambiar de pantalla solo se
    funde el móvil (el rótulo nuevo entra palabra a palabra)."""
    _, ini, fin, d = tramos[i]
    img = fondo().copy()
    cabecera(img, vid)
    rotulo_paso(img, d, t - d['inicio_paso'])
    capa = capa_movil(vid, tramos, i, t)
    u = (t - ini) / CRUCE
    if u < 1 and tramos[i - 1][0] == 'pantalla':
        antes = cache(('capa', vid, i), lambda: capa_movil(vid, tramos, i - 1, ini - 1e-3))
        capa = Image.blend(antes, capa, suave(u))
    img.paste(capa, (0, 0), capa)
    progreso(img, t, total)
    return img


def intro(vid, t):
    v = VIDEOS[vid]
    img = promo.fondo_noche().copy()
    ic = promo.logo_animado(200, t + 0.6)
    pegar(img, ic, ANCHO / 2, 640)
    promo.rotulo(img, v['para'].upper(), ANCHO / 2, 820, t, color=DORADO_CLARO, inicio=0.5, centrado=True)
    f = fuente('serif', 84, 'bold')
    lineas = promo.partir(v['titulo'], f, ANCHO - 160)
    promo.titular(img, lineas, ANCHO / 2, 920, t, tam=84, color=BLANCO, centrado=True, inicio=0.7, paso=0.08)
    return img


def cierre(vid, t):
    v = VIDEOS[vid]
    img = promo.fondo_noche().copy()
    ic = promo.icono(150, sombra=True)
    pegar(img, ic, ANCHO / 2, 600, escala=0.8 + 0.2 * rebote(entre(t, 0, 0.5)), alfa=entre(t, 0, 0.3))
    f = fuente('serif', 64, 'bold')
    lineas = promo.partir(v['cierre'], f, ANCHO - 180)
    promo.titular(img, lineas, ANCHO / 2, 790, t, tam=64, color=BLANCO, centrado=True, inicio=0.3, paso=0.05)
    a = entre(t, 1.3, 1.8)
    ImageDraw.Draw(img).rectangle((ANCHO / 2 - 150 * a, 1150, ANCHO / 2 + 150 * a, 1155), fill=DORADO_CLARO)
    promo.titular(img, ['Más vídeos en', 'victorgutierrezmarcos.es/app'], ANCHO / 2, 1200, t, tam=44, color=CREMA, centrado=True,
                  inicio=1.5, paso=0.06, tipo='sans', estilo='Semibold')
    return img


def fotograma(vid, tramos, total, t):
    i = next((k for k, (_, a, b, _) in enumerate(tramos) if a <= t < b), len(tramos) - 1)
    tipo, ini, fin, d = tramos[i]
    if tipo == 'intro':
        img = intro(vid, t)
    elif tipo == 'cierre':
        img = cierre(vid, t - ini)
    else:
        img = fotograma_movil(vid, tramos, total, t, i)
    # Fundido con el tramo anterior (entre pantallas, ya lo hace fotograma_movil).
    u = (t - ini) / CRUCE
    if i > 0 and u < 1 and not (tipo == 'pantalla' and tramos[i - 1][0] == 'pantalla'):
        antes = cache(('ultimo', vid, i), lambda: fotograma(vid, tramos, total, ini - 1e-3))
        img = Image.blend(antes, img, suave(u))
    return img


# ======================================================================= Sonido
SR = promo.SR
ACORDES = [(57, 61, 64), (54, 57, 61), (50, 54, 57), (52, 56, 59)]  # la-fa#m-re-mi


def banda_sonora(vid, tramos, total, ruta):
    """Colchón suave (un acorde cada 4 s) y un toque en cada pulsación."""
    import wave
    n = int((total + 0.5) * SR)
    mezcla = np.zeros(n)

    def poner(x, t):
        i = int(t * SR)
        if i >= n:
            return
        m = min(len(x), n - i)
        mezcla[i:i + m] += x[:m]

    t, k = 0.0, 0
    while t < total:
        fs = [promo._nota(m) for m in ACORDES[k % 4]]
        poner(promo._pad(fs, 4.4, 0.16), t)
        poner(promo._piano(promo._nota(ACORDES[k % 4][0] + 12), 2.0, 0.05), t + 0.02)
        t += 4.0
        k += 1
    poner(promo._campana(promo._nota(81), 0.12), 0.9)
    for tipo, ini, fin, d in tramos:
        if tipo == 'pantalla' and d['toque']:
            poner(promo._toque(0.12), ini + T_TOQUE)
        if tipo == 'pantalla' and d.get('aviso'):
            poner(promo._campana(promo._nota(88), 0.10, 1.4), ini + 1.0)
        if tipo == 'cierre':
            poner(promo._campana(promo._nota(76), 0.12), ini + 0.1)
    # Entrada y salida suaves.
    e = np.ones(n)
    e[:int(0.8 * SR)] = np.linspace(0, 1, int(0.8 * SR))
    f = int(1.5 * SR)
    e[-f:] = np.linspace(1, 0, f)
    mezcla *= e
    mezcla /= max(1.0, np.abs(mezcla).max() / 0.8)
    datos = (np.stack([mezcla, mezcla], axis=1) * 32767).astype(np.int16)
    with wave.open(ruta, 'wb') as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(datos.tobytes())


# ======================================================================= Salida
def montar(vid, ffmpeg):
    tramos, total = linea_de_tiempo(vid)
    if total > 60:
        print(f'Aviso: {vid} dura {total:.1f} s (más de un minuto)')
    salida = os.path.join(AYUDA, f'{vid}.mp4')
    sonido = os.path.join(tempfile.gettempdir(), f'ayuda-{vid}-sonido.wav')
    banda_sonora(vid, tramos, total, sonido)
    orden = [
        ffmpeg, '-y', '-loglevel', 'error',
        '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{ANCHO}x{ALTO}', '-r', str(FPS), '-i', '-',
        '-i', sonido,
        '-c:v', 'libx264', '-preset', 'slow', '-crf', '24', '-pix_fmt', 'yuv420p', '-threads', '2',
        '-c:a', 'aac', '-b:a', '96k', '-shortest', '-movflags', '+faststart', salida,
    ]
    proceso = subprocess.Popen(orden, stdin=subprocess.PIPE)
    for i in range(int(total * FPS)):
        proceso.stdin.write(fotograma(vid, tramos, total, i / FPS).tobytes())
    proceso.stdin.close()
    if proceso.wait() != 0:
        sys.exit('ffmpeg ha fallado')
    os.remove(sonido)
    # Póster: el primer paso con el dedo encima.
    t_poster = next(ini + T_TOQUE for tipo, ini, fin, d in tramos if tipo == 'pantalla' and d['toque'])
    fotograma(vid, tramos, total, t_poster).save(os.path.join(AYUDA, f'{vid}.jpg'), quality=84, optimize=True)
    promo._cache.clear()
    print(f'{vid}: {total:.1f} s, {os.path.getsize(salida) / 1e6:.1f} MB', flush=True)


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'), help='ruta de ffmpeg')
    p.add_argument('--solo', nargs='+', metavar='ID', help='solo estos vídeos')
    p.add_argument('--solo-fotogramas', metavar='DIR', help='guarda fotogramas de muestra en DIR y termina')
    args = p.parse_args()
    ids = args.solo or list(VIDEOS)
    for vid in ids:
        if vid not in VIDEOS:
            sys.exit(f'No hay ningún vídeo «{vid}». Los que hay: {", ".join(VIDEOS)}')
    if args.solo_fotogramas:
        os.makedirs(args.solo_fotogramas, exist_ok=True)
        for vid in ids:
            tramos, total = linea_de_tiempo(vid)
            print(f'{vid}: {total:.1f} s')
            for tipo, ini, fin, d in tramos:
                for t in ((ini + 1.0,) if tipo != 'pantalla' else (ini + 0.15, ini + T_TOQUE + 0.05, fin - 0.05)):
                    if t < total:
                        fotograma(vid, tramos, total, t).save(os.path.join(args.solo_fotogramas, f'{vid}-{t:05.2f}.jpg'), quality=80)
        return
    if not args.ffmpeg:
        sys.exit('No se encuentra ffmpeg: indícalo con --ffmpeg o con la variable FFMPEG.')
    for vid in ids:
        montar(vid, args.ffmpeg)


if __name__ == '__main__':
    main()
