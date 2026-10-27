#!/usr/bin/env python3
"""
Genera el vídeo del cante de un tema (exactamente 30:00, 1920 × 1080) a partir
de fuentes/<tema>/video/escenas.yaml.

    python3 scripts/temario/generar-video.py 3A08 [--borrador] [--tramo 0:00-3:00]

Cómo es el vídeo (CRITERIOS.md, «Vídeo»):
  - Cabecera como las presentaciones Beamer, en tres filas: el tema, el
    apartado y el tiempo que queda; los bloques de la exposición (el actual
    resaltado y los ya expuestos con una marca), y los apartados del bloque
    actual (o las partes de la introducción y la conclusión) como una
    sucesión de pasos. Al cambiar de bloque o de apartado el paso nuevo se
    ilumina y, durante la pausa, sale el esquema de la exposición con la
    marca avanzando del apartado anterior al nuevo (como \\tableofcontents
    [currentsection] de Beamer).
  - Dos modos, como en el examen:
      guion    lo que el opositor cuenta sentado, sin pizarra (introducción,
               conclusión, partes habladas): en pantalla sale el guion en
               viñetas, que aparecen según se dicen (Palatino sobre papel).
      pizarra  la pantalla es la pizarra blanca y en ella solo está lo que el
               opositor escribiría a mano: gráficos y fórmulas (texto, solo
               si aclara mucho). Todo se escribe trazo a trazo, a la velocidad
               de una mano: cada letra o símbolo se recorre por su esqueleto
               en el orden en que se escribe (renglón a renglón, de izquierda
               a derecha, numerador, raya y denominador, tildes y puntos al
               final de la letra) y cada gráfico TikZ en el orden de su
               código. Lo que se dice pero no se escribe va fuera de la
               pizarra, en la franja de abajo («Se dice», Palatino sobre
               papel), y lo didáctico en «Apunte» (sobre salvia).
  - Además de lo escrito a mano puede salir material de APOYO (gráficos,
    fórmulas o texto que el opositor no escribiría pero que ayudan a seguirle),
    en tarjetas azuladas que aparecen de golpe y no se confunden con la pizarra.
  - La voz no se para: lo que dibuja cada paso se escribe mientras se dice ese
    paso (la mano acelera hasta 1,6 veces si hace falta; si no basta, aviso).
    «[pausa]» o «[pausa 800]» en lo que se dice: pausa de énfasis (2 s como máximo).
  - La pizarra se divide en una rejilla de 1 a 3 columnas, y cada columna en
    1 o 2 filas, con el ancho y el alto que se quiera; las rayas que separan
    las celdas solo se pintan si se pide (lineas: true), cuando ayudan a
    seguir la exposición. Cambiar de rejilla borra la pizarra, salvo las zonas
    que se pidan conservar (las funciones clave: ver «Conservar» abajo).
  - Pausa entre pasos, más larga entre escenas y más aún entre apartados y
    bloques.
  - Dura exactamente lo que diga «duracion» (1800 s; la guía del dictamen, 1D01,
    5400 s): se ajusta el ritmo de
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
      # con muchos bloques (la guía del dictamen), «corto» es lo que sale en la cabecera:
      # - {nombre: "II. Mercados de factores", corto: "II. Factores", minutos: 10}
    escenas:
      - bloque: Introducción
        titulo: Introducción           # sale en la cabecera
        modo: guion
        estructura: [Enganche, Relevancia, Contextualización, Problemática, Estructura]
        pasos:
          - di: "Texto que se narra."
            parte: Enganche            # resalta esa parte de la estructura
            guion: "Marshall (1890): la economía, «los asuntos ordinarios de la vida»"
          - di: "…"
            guion: ["> subidea", "> otra"]     # «>» sangra un nivel
      - bloque: "I. La función de demanda"
        titulo: "I.1. Preferencias: axiomas"   # «I.1» es el apartado de la cabecera
        apartado: "I.1"                # opcional (se saca del título)
        modo: pizarra
        rejilla: "35|65"               # al empezar la escena (ver abajo)
        pasos:
          - di: "…"
            borrar: true               # o [2] o ["2b"]: zonas que se borran
            pizarra:
              - {formula: 'x \\succeq y', zona: 1}
              - {grafico: axiomas, capa: 1, zona: 2, alto: 0.9}
              - {escribe: "Completitud", zona: 1, color: rojo}   # texto: solo si aclara
            apoyo: {grafico: axiomas, capa: 3, zona: 2}   # apoyo: se enseña, no se escribe
            guion: "Tres axiomas de racionalidad"    # franja «Se dice»
            apunte: "Debreu (1959): racionalidad + continuidad ⇒ U"
          - di: "…"
            rejilla: {columnas: [40, 60], filas: {2: [55, 45]}, lineas: true}
            pizarra: [{grafico: axiomas, capa: 3}]    # mismo gráfico: dibuja lo nuevo
          - di: "…"
            rejilla: "25|75"
            conservar: ["2a"]          # lo de 2a (rejilla vieja) se queda donde está
            pizarra:
              - {formula: '\\funcionclave{\\optim{\\max}{\\vect{x}}{U(\\vect{x})}{\\vect{p}\\cdot\\vect{x}\\leq W}}'}

Apoyo (`apoyo:` en un paso, uno o una lista): gráficos, fórmulas ({formula: …}),
texto ({texto: [..]}) o imágenes que ayudan a seguir la exposición pero que el
opositor NO escribiría: salen de golpe en una tarjeta azulada («APOYO · no se
escribe en la pizarra») en una celda de la rejilla, y se quitan al borrar esa
zona o cambiar de rejilla.

Rejilla: "100" (una celda), "50|50", "30|40|30", "40|60(55/45)" (la segunda
columna con dos filas del 55 % y 45 %) o {columnas: [...], filas: {col:
[a, b]}, lineas: true}. Zonas: "1" (columna entera), "2a" y "2b" (filas de la
columna 2), "1-2" (columnas 1 y 2) y "1a-2a". Cada cosa va debajo de lo último
escrito en su zona.

Conservar (funciones clave que se quedan en la pizarra entre apartados y
bloques): `conservar: [zonas]` junto a `rejilla:` (en el paso o en la escena)
o junto a `borrar: true`. Lo escrito en esas zonas (zonas de la rejilla de
ANTES del cambio) no se borra ni se mueve: se queda donde está y pasa a ser
de la celda de la rejilla nueva que lo contiene; lo demás se borra. Lo nuevo
de esa celda se escribe debajo de lo conservado (o encima, si lo conservado
está abajo y deja sitio). La rejilla nueva tiene que tener una celda que lo
contenga entero (si no, aviso). P. ej., con "20|40|40" y la función clave en
1, `rejilla: "25|75"` + `conservar: [1]`; o, sin cambiar de rejilla,
`borrar: true` + `conservar: [1]` (equivale a `borrar: [2, 3]`).

Fórmulas (`formula:`): LaTeX en modo matemático con los macros de tcee.sty
(se leen del propio tcee.sty): \\vect, \\optim{\\max}{\\vect{x}}{U(\\vect{x})}{restr.
\\\\ restr.}, \\funcionclave{…} (morada y recuadrada, con el fondo morado
pálido, como en el tema), \\tiempo{2,5}, \\autor, \\concepto, \\text, \\mathrm{RMS}
y los colores tcee*. Los recuadros (\\funcionclave, \\boxed) se trazan al final,
después de su contenido, como a mano.

Franjas y guion: lo que no tenga Palatino (→ ⇒ ≫ ℝ ∈ ᵢ ⱼ…) sale con Cambria,
Cambria Math o Segoe UI Symbol; si ninguna lo tiene, el script avisa.

Formato «slides» (`formato: slides` en escenas.yaml; la guía del dictamen, 1D01; Víctor,
27/10/2026). Una sucesión de slides con libertad total para usar la pizarra: slide entera,
pizarra entera, slide con un panel de pizarra al lado o anotaciones a mano encima de la slide.
Sin franja «Se dice» ni «Apunte» ni tarjetas de apoyo: la explicación es la voz («di», que es
también la nota de cada slide y va al .srt y a videos/<tema>-notas.json, con el inicio de cada
slide y su sitio en la guía, para sacar luego una presentación con notas). La cabecera lleva el
tiempo transcurrido sobre el total («38′ / 90′») y se mantienen los esquemas entre apartados y
bloques. Los pasos van dentro de cada slide; los cantes (formato por defecto) no cambian.

    formato: slides
    escenas:
      - bloque: "I. Perfil cíclico"
        titulo: "I.3. Medidores: crecimiento, brecha y renta"   # cabecera y esquema, como siempre
        guia: "I.3"                    # apartado de la guía (por defecto de sus slides)
        estructura: [...]              # en la introducción y la conclusión, con «parte:» en los pasos
        slides:
          - titulo: "Crecimiento del PIB real"
            guia: "I.3 > Crecimiento del PIB real"   # esquina «§ I.3 · pág. 9» (páginas del .aux)
            pizarra: {ancho: 38, lado: derecha, rejilla: "100"}   # panel; «pizarra: 100», pizarra entera
            columnas: [55, 45]         # opcional; cada elemento con «col: 2»
            vertical: centro           # opcional
            contenido: [...]           # lo que se ve desde el principio
            pasos:
              - di: "Lo que dice la voz."
                muestra: [...]         # lo que aparece en este paso (de golpe, como en una presentación)
                pizarra: [{formula: '…'}]   # lo que se escribe en el panel (como en los cantes:
                                             # rejilla, borrar, conservar, zona, gráficos por capas)
                anota: [{rodea: "umbrales/fila 3"}, {escribe: "≈ potencial", junto: "umbrales/fila 3"}]

  Elementos de slide: {vinetas: [..]} («>» sangra; numerada: true o 3), {texto: .., grande,
  centrado, cursiva}, {formula: ..}, {grafico: nombre, capa, alto, pie} (sin «alto», ocupa el
  sitio que quede; con otra «capa» en un paso posterior, se le añade esa capa), {tabla: true,
  cabecera: [..], filas: [[..]], anchos: [..], destaca: [..]}, {caja: clave|pregunta|nota|ejemplo|
  umbral|anexo, texto: .. o [..], titulo}, {cifras: [[cifra, texto], ..]} y {flujo: [..]}. Todos
  admiten «id» (para anotarlos) y «col». En los textos, **negrita** y *cursiva*.
  Anotaciones a mano (en rojo; «color» para otro): rodea, subraya, tacha, flecha (con «desde» o
  «lado»), escribe y formula (junto a algo, con «lado», o en «pos: [x, y]» de la slide).
  Selectores: «id», «id/fila 2» (0, la cabecera), «id/celda 2,1», «id/vineta 3», «id/cifra 1»,
  «id/paso 2» (flujo) e «id/zona x0,y0,x1,y1» (fracciones de la caja: un dato de un gráfico).
  Ningún texto se corta: cada slide se mide y, si no cabe, se reduce la letra hasta el 80 %; si
  aun así no cabe (o una palabra no cabe en su caja, un carácter no tiene fuente, una anotación
  tapa algo o se sale, o la cabecera o el esquema recortarían un título), es un ERROR con
  minuto, escena y texto: --medir termina con código 4 y el montaje no se hace.

Salida (fuera de git, en oposicion/temario/videos/, que está en .gitignore):
  videos/<tema>.mp4          el vídeo
  videos/<tema>.srt          subtítulos (para YouTube)
  videos/<tema>-youtube.txt  título, descripción y capítulos para YouTube
  videos/<tema>-notas.json   (slides) las notas de cada slide, con su inicio y su sitio en la guía

Voces (voz.motor): «edge» (Edge TTS neural, gratis), «xtts» (voz clonada a
partir de una grabación, con scripts/temario/voz-xtts.py en ~/.venvs/voz) o
«voicestudio» (VoiceStudio con su backend en marcha; motor_tts: omnivoice por
defecto; referencia: WAV corto de la voz con su transcripción en un .txt al
lado; velocidad; pasos). Ejemplo:
    voz: {motor: voicestudio, motor_tts: omnivoice, velocidad: 1.15,
          referencia: /mnt/c/Users/vgutierrez/Documents/voz/referencia-12s.wav}
Los audios, gráficos y fórmulas se guardan en fuentes/<tema>/_trabajo/video/
y solo se rehacen si cambia su texto.

Avisos: claves desconocidas en escenas.yaml (se ignoran, pero se dicen), pasos
sin «di» (la voz no se para), más de dos [pausa] en un paso, minutos de
«bloques» distintos de los \\minutos del tema, gráficos 3D dibujados en la
pizarra (van como apoyo o como boceto), capas que bajan, y una rejilla igual a
la actual en un paso (no borra nada: hay que usar borrar: true). El ritmo tiene
que quedar entre ×0,95 y ×1,05 (CRITERIOS, «Parámetros»): si no, el script
termina con código 3 (también con --medir), para que voz-todos.py pare.

Rutas que se pueden cambiar con variables de entorno: TCEE_VIDEOS (carpeta de
salida), TCEE_FUENTES_WIN (fuentes TrueType; /mnt/c/Windows/Fonts),
TCEE_EDGE_DIR (instalación de Edge, para Edge TTS), TCEE_VOZ_PYTHON (Python
del entorno de XTTS), VOICESTUDIO_URL (API de VoiceStudio).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import asyncio
import copy
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
from collections import Counter

import fitz  # PyMuPDF
import numpy as np
import yaml
from PIL import Image, ImageChops, ImageDraw, ImageFont
from scipy import ndimage
from skimage.morphology import skeletonize

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import (Tema, LATEX, MIKTEX, entorno_tex, ejecutar, errores_log, minutos_texto, segundos_texto,  # noqa: E402
                   anio_tema, licencia_corta, licencia_larga, es_exclusivo)

ANCHO, ALTO = 1920, 1080
FPS = 25
CAB = 150                      # alto de la cabecera (tres filas y la barra de progreso)
MUESTREO = 24000               # Hz del audio
CIERRE = 6.0                   # segundos de la pantalla final, en silencio
PAUSA_PASO = 0.35
PAUSA_ESCENA = 0.8             # otra escena del mismo apartado
PAUSA_APARTADO = 2.0           # otro apartado (sale el esquema)
PAUSA_BLOQUE = 2.6             # otro bloque (sale el esquema)
TARJETA_MIN = 1.8              # segundos mínimos del esquema al cambiar de apartado
FUNDIDO = 0.4
VEL_MANO = 7.0                 # velocidad de la pluma, en alturas de letra por segundo
VEL_TRAZO = 800                # píxeles por segundo de los trazos de los gráficos (como una mano en la pizarra)
VEL_REGLA = 1400               # rayas de la rejilla (con regla)
LEVANTAR = 0.06                # levantar la pluma entre trazos
ACELERACION_MAX = 1.6          # más rápido que esto ya no parece una mano: se avisa
# Todos los vídeos juntos en oposicion/temario/videos/ (fuera de git: .gitignore); se
# publican en YouTube cuando estén todos
SALIDA = os.environ.get('TCEE_VIDEOS', os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))), 'oposicion', 'temario', 'videos'))
FUENTES_WIN = os.environ.get('TCEE_FUENTES_WIN', '/mnt/c/Windows/Fonts')
EDGE_DIR = os.environ.get('TCEE_EDGE_DIR', '/mnt/c/Program Files (x86)/Microsoft/Edge/Application')
PRONUNCIACION = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pronunciacion.yaml')
# Solo para el motor edge (los demás tienen su propia velocidad, numérica)
VOZ_DEFECTO = {'motor': 'edge', 'nombre': 'es-ES-AlvaroNeural', 'velocidad': '+15%'}
PYTHON_VOZ = os.environ.get('TCEE_VOZ_PYTHON', os.path.expanduser('~/.venvs/voz/bin/python'))
RITMO_MIN, RITMO_MAX = 0.95, 1.05   # ajuste admisible del ritmo (CRITERIOS, «Parámetros»)
if not os.path.isdir(FUENTES_WIN):
    sys.exit(f'No existe la carpeta de fuentes {FUENTES_WIN} (TCEE_FUENTES_WIN): el vídeo necesita '
             'Palatino (pala*.ttf), Segoe UI, Segoe Print y Cambria')

MORADO = (95, 41, 135)
MORADO_OSCURO = (58, 24, 84)
MORADO_MEDIO = (124, 80, 160)
MORADO_PALIDO = (240, 233, 246)
LILA = (196, 178, 214)
LILA_APAGADO = (146, 124, 166)
TINTA = (40, 38, 44)
GRIS = (130, 125, 135)
SALVIA = (226, 239, 217)
SALVIA_OSCURO = (150, 180, 140)
APOYO_FONDO = (232, 239, 248)  # tarjetas de apoyo: lo que se enseña pero no se escribe
APOYO_BORDE = (120, 145, 185)
PAPEL = (250, 249, 246)
FONDO = (236, 236, 232)
PIZARRA = (253, 253, 251)
MARCO = (196, 199, 204)
RAYA = (214, 218, 225)
ROTULADOR = {'azul': (24, 58, 140), 'negro': (32, 32, 36), 'rojo': (190, 32, 38),
             'verde': (24, 118, 60), 'morado': MORADO}

# Pizarra (en coordenadas de pantalla); dentro, todo va en coordenadas de la pizarra
PZ_X0, PZ_Y0, PZ_X1, PZ_Y1 = 44, CAB + 40, ANCHO - 44, ALTO - 132
PZ_W, PZ_H = PZ_X1 - PZ_X0, PZ_Y1 - PZ_Y0
PZ_MARGEN = 24
FRANJA_Y = ALTO - 112


def fuente(nombre, tam):
    return ImageFont.truetype(os.path.join(FUENTES_WIN, nombre), tam)


F_UI = fuente('segoeui.ttf', 22)
F_UI_N = fuente('segoeuib.ttf', 22)
F_PASO = fuente('segoeui.ttf', 20)
F_PASO_N = fuente('segoeuib.ttf', 20)
F_MARCO = fuente('segoeuisl.ttf', 17)
F_BARRA = fuente('segoeuib.ttf', 28)
F_BARRA_L = fuente('segoeuisl.ttf', 28)
F_GUION = fuente('pala.ttf', 36)
F_GUION_N = fuente('palab.ttf', 36)
F_GUION_T = fuente('palab.ttf', 46)
F_FRANJA = fuente('pala.ttf', 28)
F_FRANJA_I = fuente('palai.ttf', 28)
F_ETIQUETA = fuente('segoeuib.ttf', 17)
F_APUNTE_E = fuente('segoeuib.ttf', 20)
F_PIZ = fuente('segoeprb.ttf', 38)
F_APOYO = fuente('pala.ttf', 32)
F_PIZ_T = fuente('segoeprb.ttf', 44)
F_TITULO = fuente('palab.ttf', 64)
F_SUBTITULO = fuente('pala.ttf', 42)
F_TARJETA_T = fuente('segoeuib.ttf', 20)
F_TARJETA_B = fuente('palab.ttf', 38)
F_TARJETA_A = fuente('pala.ttf', 33)
F_TARJETA_S = fuente('palai.ttf', 28)


# --- Texto con fuente de respaldo ----------------------------------------------------------------
# Palatino (y Segoe Print) no tienen → ⇒ ≫ ℝ ᵢ ⱼ…: esos caracteres se escriben con Cambria,
# Cambria Math o Segoe UI Symbol, del mismo tamaño y en la misma línea base. Si ninguna los
# tiene, se avisa (saldrían como cajas).
RESPALDO = [('cambria.ttc', 0), ('cambria.ttc', 1), ('seguisym.ttf', 0)]
RESPALDO_CURSIVA = [('cambriai.ttf', 0)] + RESPALDO
_GLIFOS, _FUENTES = {}, {}


def glifos(fnt):
    clave = (fnt.path, getattr(fnt, 'index', 0))
    if clave not in _GLIFOS:
        from fontTools.ttLib import TTFont
        _GLIFOS[clave] = set(TTFont(fnt.path, fontNumber=clave[1], lazy=True).getBestCmap())
    return _GLIFOS[clave]


def respaldos(fnt):
    cursiva = 'italic' in fnt.getname()[1].lower()
    lista = []
    for nombre, i in (RESPALDO_CURSIVA if cursiva else RESPALDO):
        clave = (nombre, i, fnt.size)
        if clave not in _FUENTES:
            ruta = os.path.join(FUENTES_WIN, nombre)
            _FUENTES[clave] = ImageFont.truetype(ruta, fnt.size, index=i) if os.path.exists(ruta) else None
        if _FUENTES[clave] is not None:
            lista.append(_FUENTES[clave])
    return lista


def _tramos(texto, fnt):
    """[(trozo, fuente)]: cada carácter con la primera fuente que lo tiene (la principal si ninguna)."""
    if all(ord(ch) in glifos(fnt) or ch.isspace() for ch in texto):
        return [(texto, fnt)]
    tramos = []
    for ch in texto:
        f = fnt
        if not (ch.isspace() or ord(ch) in glifos(fnt)):
            f = next((r for r in respaldos(fnt) if ord(ch) in glifos(r)), fnt)
        if tramos and tramos[-1][1] is f:
            tramos[-1][0] += ch
        else:
            tramos.append([ch, f])
    return [tuple(t) for t in tramos]


def sin_glifo(texto, fnt):
    """Caracteres que no tiene ni la fuente ni sus respaldos."""
    return sorted({ch for ch in texto if not ch.isspace() and ord(ch) not in glifos(fnt)
                   and not any(ord(ch) in glifos(r) for r in respaldos(fnt))})


def avisar_glifos(texto, fnt, donde, avisos):
    faltan = sin_glifo(str(texto), fnt)
    if faltan:
        avisos.append(f'Glifos sin fuente en {donde} («{str(texto)[:40]}…»): {" ".join(faltan)} '
                      f'(saldrían como cajas: cambiarlos por otros)')


_MEDIDOR = ImageDraw.Draw(Image.new('L', (1, 1)))


def ancho_texto(texto, fnt, d=None):
    d = d or _MEDIDOR
    return sum(d.textlength(t, font=f) for t, f in _tramos(texto, fnt))


def escribir(d, xy, texto, fnt, fill, anchor='la'):
    """d.text con fuentes de respaldo (anclas «la», «lm» o «ls»)."""
    tramos = _tramos(texto, fnt)
    if len(tramos) == 1 and tramos[0][1] is fnt:
        d.text(xy, texto, font=fnt, fill=fill, anchor=anchor)
        return
    ascenso, descenso = fnt.getmetrics()
    x, y = xy
    base = {'la': y + ascenso, 'lm': y + (ascenso - descenso) / 2, 'ls': y}[anchor]
    for t, f in tramos:
        d.text((x, base), t, font=f, fill=fill, anchor='ls')
        x += d.textlength(t, font=f)


def huella(*partes):
    return hashlib.sha1('\x00'.join(map(str, partes)).encode()).hexdigest()[:12]


def mmss(s):
    s = max(0, int(round(s)))
    return f'{s // 60}:{s % 60:02d}'


# --- Voz -------------------------------------------------------------------------------
def version_edge():
    """Edge TTS exige una versión de Edge reciente: se toma la instalada en Windows."""
    versiones = [os.path.basename(p) for p in glob.glob(os.path.join(EDGE_DIR, '*'))
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
        # Lo ya sintetizado en una ejecución interrumpida (hay .wav) no se repite
        faltan = [(t, p) for t, p in pendientes if not os.path.exists(p[:-4] + '.wav')]
        json.dump([{'texto': t, 'wav': p[:-4] + '.wav'} for t, p in faltan], open(trabajo, 'w', encoding='utf-8'),
                  ensure_ascii=False)
        guion_xtts = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'voz-xtts.py')
        if faltan:
            subprocess.run([PYTHON_VOZ, guion_xtts, trabajo, muestra, str(voz.get('velocidad', 1.0))], check=True,
                           env={**os.environ, 'COQUI_TOS_AGREED': '1'})
        for _, destino in pendientes:
            a_pcm(ffmpeg, destino[:-4] + '.wav', destino)
    elif motor == 'voicestudio':
        # VoiceStudio (github.com/debpalash/VoiceStudio) con su backend en marcha; por defecto
        # su motor OmniVoice, clonando la voz de una referencia corta con su transcripción
        import requests
        url = os.environ.get('VOICESTUDIO_URL', 'http://127.0.0.1:3900')
        try:
            requests.get(f'{url}/engines/tts', timeout=10).raise_for_status()
        except Exception:
            raise RuntimeError(f'VoiceStudio no responde en {url}: arranca su backend (p. ej. ~/src/arrancar-voicestudio.sh)')
        referencia = os.path.expanduser(voz['referencia'])
        texto_ref = voz.get('referencia_texto') or open(os.path.splitext(referencia)[0] + '.txt', encoding='utf-8').read().strip()
        for i, (texto, destino) in enumerate(pendientes, 1):
            wav = destino[:-4] + '.wav'
            if not os.path.exists(wav):
                datos = {'text': texto, 'language': 'Spanish', 'engine': voz.get('motor_tts', 'omnivoice'),
                         'ref_text': texto_ref, 'speed': str(voz.get('velocidad', 1.0)),
                         'num_step': str(voz.get('pasos', 32))}
                for intento in range(3):
                    with open(referencia, 'rb') as f:
                        r = requests.post(f'{url}/generate', data=datos, files={'ref_audio': ('ref.wav', f, 'audio/wav')},
                                          timeout=36000)
                    if r.status_code == 200:
                        break
                    if intento == 2:
                        raise RuntimeError(f'VoiceStudio falló ({r.status_code}): {r.text[:300]}')
                    time.sleep(30)
                open(wav, 'wb').write(r.content)
            a_pcm(ffmpeg, wav, destino)
            print(f'  voz {i}/{len(pendientes)}', flush=True)
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
    # Se reintenta si pdflatex.exe (Windows, desde WSL) no llega a arrancar: a veces la
    # interoperabilidad falla («UtilAcceptVsock») y no deja ni el .log
    salida = os.path.join(carpeta, f'{trabajo}.pdf')
    for intento in range(3):
        cod, _ = ejecutar(orden, cwd=tema.graficos, env=entorno_tex(), timeout=300, comprobar=False)
        if cod == 0 and os.path.exists(salida) or os.path.exists(os.path.join(carpeta, f'{trabajo}.log')):
            break
        time.sleep(2)
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




# --- Escritura a mano -------------------------------------------------------------------------
VECINOS = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]


def trazar_esqueleto(esq):
    """Recorre el esqueleto de un trazo (array booleano) como lo haría una pluma:
    empieza arriba a la izquierda, sigue la dirección que lleva y, al acabar un
    tramo, salta al extremo libre más cercano. Devuelve polilíneas (x, y)."""
    libres = set(zip(*np.nonzero(esq)))
    tramos, ultimo = [], None

    def vecinos(p):
        return [(p[0] + dy, p[1] + dx) for dy, dx in VECINOS if (p[0] + dy, p[1] + dx) in libres]

    while libres:
        extremos = [p for p in libres if len(vecinos(p)) <= 1]
        candidatos = extremos or list(libres)
        if ultimo is None:
            inicio = min(candidatos, key=lambda p: p[1] + 0.8 * p[0])
        else:
            inicio = min(candidatos, key=lambda p: (p[0] - ultimo[0]) ** 2 + (p[1] - ultimo[1]) ** 2)
        camino = [inicio]
        libres.discard(inicio)
        while True:
            actual = camino[-1]
            sig = vecinos(actual)
            if not sig:
                break
            if len(camino) < 2:
                q = min(sig, key=lambda q: abs(q[0] - actual[0]) + abs(q[1] - actual[1]))
            else:
                atras = camino[max(0, len(camino) - 4)]
                dy, dx = actual[0] - atras[0], actual[1] - atras[1]
                n = math.hypot(dy, dx) or 1
                q = max(sig, key=lambda q: ((q[0] - actual[0]) * dy + (q[1] - actual[1]) * dx)
                        / (n * math.hypot(q[0] - actual[0], q[1] - actual[1])))
            camino.append(q)
            libres.discard(q)
        ultimo = camino[-1]
        if len(camino) >= 3:
            puntos = camino[::2] + ([camino[-1]] if (len(camino) - 1) % 2 else [])
            tramos.append([(x + 0.5, y + 0.5) for y, x in puntos])
    return tramos


def largo_tramos(tramos):
    return sum(math.dist(a, b) for t in tramos for a, b in zip(t, t[1:]))


def trazos_mano(alfa, dx=0, dy=0, umbral=90):
    """Descompone lo escrito (canal alfa, array uint8) en los trazos de una mano.

    Cada componente conexa es un trazo de pluma; se ordenan por renglones (bandas
    horizontales separadas por un hueco), dentro de cada renglón de izquierda a
    derecha, con las fracciones como se escriben (numerador, raya, denominador)
    y las tildes y puntos justo después de su letra. Devuelve las partes (en
    coordenadas desplazadas dx, dy) con su duración a velocidad de mano."""
    b = alfa > umbral
    etiquetas, n = ndimage.label(b, structure=np.ones((3, 3)))
    if n == 0:
        return []
    comps = []
    for i, sl in enumerate(ndimage.find_objects(etiquetas), 1):
        if sl is None:
            continue
        m = etiquetas[sl] == i
        area = int(m.sum())
        if area < 3:
            continue
        y0, y1, x0, x1 = sl[0].start, sl[0].stop, sl[1].start, sl[1].stop
        comps.append({'m': m, 'area': area, 'x0': x0, 'y0': y0, 'x1': x1, 'y1': y1, 'w': x1 - x0, 'h': y1 - y0})
    if not comps:
        return []
    ref = max(10, sorted(c['h'] for c in comps)[len(comps) // 2])
    area_med = sorted(c['area'] for c in comps)[len(comps) // 2]
    for c in comps:
        c['barra'] = c['w'] > 2.5 * c['h'] and c['w'] > 1.2 * ref and c['h'] < 0.35 * ref
        c['marca'] = not c['barra'] and c['area'] < 0.2 * area_med and c['h'] < 0.45 * ref
    # Renglones
    grandes = sorted((c for c in comps if not c['marca']), key=lambda c: c['y0'])
    bandas = []
    solo_rayas = False      # un renglón con solo rayas (la de W̄) se une al de debajo
    for c in grandes:
        if bandas and (c['y0'] < bandas[-1][1] + 0.12 * ref or (solo_rayas and c['y0'] < bandas[-1][1] + ref)):
            bandas[-1][1] = max(bandas[-1][1], c['y1'])
            solo_rayas = solo_rayas and c['barra']
        else:
            bandas.append([c['y0'], c['y1']])
            solo_rayas = c['barra']
    for c in comps:
        cy = (c['y0'] + c['y1']) / 2
        c['banda'] = min(range(len(bandas)), key=lambda k: 0 if bandas[k][0] <= cy <= bandas[k][1]
                         else min(abs(cy - bandas[k][0]), abs(cy - bandas[k][1]))) if bandas else 0
    orden = []
    for k in range(max(1, len(bandas))):
        en = [c for c in comps if c['banda'] == k]

        def junto(o, c):
            return not o['barra'] and o['x0'] < c['x1'] and o['x1'] > c['x0']
        # Una raya sin nada encima es una barra de W̄ o x̄: va después de lo que cubre
        for c in en:
            c['sobre'] = None
            if c['barra'] and not any(junto(o, c) and o['y1'] <= c['y0'] + 2 for o in en):
                debajo = [o for o in en if junto(o, c) and o['y0'] >= c['y1'] - 2]
                if debajo:
                    c['sobre'] = max(o['x0'] for o in debajo)
        barras = [c for c in en if c['barra'] and c['sobre'] is None]

        def clave(c):
            if c['barra']:
                return (c['sobre'], 1, c['sobre'] + 0.5) if c['sobre'] is not None else (c['x0'], 1, c['x0'])
            cx = (c['x0'] + c['x1']) / 2
            cubren = [r for r in barras if r['x0'] - 2 <= cx <= r['x1'] + 2
                      and (c['y1'] <= r['y0'] + 2 or c['y0'] >= r['y1'] - 2)]
            if cubren:
                r = min(cubren, key=lambda r: r['w'])
                return (r['x0'], 0 if c['y1'] <= r['y0'] + 2 else 2, c['x0'])
            return (c['x0'], 1, c['x0'])

        principales = sorted((c for c in en if not c['marca']), key=clave)
        marcas = [c for c in en if c['marca']]
        despues = {}
        sueltas = []
        for mk in marcas:
            solape = [(min(mk['x1'], c['x1']) - max(mk['x0'], c['x0']), j) for j, c in enumerate(principales)]
            mejor = max(solape, default=(0, None))
            if mejor[0] > 0:
                despues.setdefault(mejor[1], []).append(mk)
            else:
                sueltas.append(mk)
        fila = []
        for j, c in enumerate(principales):
            fila.append(c)
            fila.extend(despues.get(j, []))
        for mk in sueltas:   # p. ej., un punto final: en su sitio de izquierda a derecha
            pos = next((j for j, c in enumerate(fila) if c['x0'] > mk['x0']), len(fila))
            fila.insert(pos, mk)
        orden.extend(fila)
    partes = []
    for c in orden:
        esq = skeletonize(c['m'])
        tramos = [[(x + c['x0'] + dx, y + c['y0'] + dy) for x, y in t] for t in trazar_esqueleto(esq)]
        grosor = 2 * float(ndimage.distance_transform_edt(c['m']).max()) + 3
        largo = largo_tramos(tramos)
        partes.append({'tipo': 'pluma', 'caja': (c['x0'] + dx, c['y0'] + dy, c['x1'] + dx, c['y1'] + dy),
                       'comp': Image.fromarray((c['m'] * 255).astype(np.uint8), 'L'), 'tramos': tramos,
                       'grosor': grosor, 'largo': largo,
                       # las tildes, los puntos y los trazos sueltos pequeños son un toque rápido
                       'dur': max(0.05, max(largo, 0.6 * c['h']) / (VEL_MANO * ref))
                       + (LEVANTAR / 2 if c['marca'] or c['h'] < 0.5 * ref else LEVANTAR)})
    return partes


def dibujar_mascara(mascara, e, u):
    """Revela la fracción u (0-1) del elemento en la máscara: la pluma recorre su
    esqueleto, los trazos de los gráficos se recorren y los rellenos (y lo que
    se borra) se descubren de izquierda a derecha."""
    if e['tipo'] == 'pluma':
        x0, y0, x1, y1 = e['caja']
        if u >= 1:
            mascara.paste(255, (x0, y0, x1, y1), e['comp'])
            return
        m = Image.new('L', e['comp'].size, 0)
        d = ImageDraw.Draw(m)
        queda = u * e['largo']
        for t in e['tramos']:
            puntos = [(t[0][0] - x0, t[0][1] - y0)]
            for a, b in zip(t, t[1:]):
                if queda <= 0:
                    break
                seg = math.dist(a, b)
                f = min(1.0, queda / seg) if seg else 1.0
                puntos.append((a[0] + (b[0] - a[0]) * f - x0, a[1] + (b[1] - a[1]) * f - y0))
                queda -= seg
            if len(puntos) > 1:
                d.line(puntos, fill=255, width=int(e['grosor']), joint='curve')
                r = e['grosor'] / 2
                for p in (puntos[0], puntos[-1]):
                    d.ellipse([p[0] - r, p[1] - r, p[0] + r, p[1] + r], fill=255)
            if queda <= 0:
                break
        m = ImageChops.multiply(m, e['comp'])
        zona = mascara.crop((x0, y0, x1, y1))
        mascara.paste(ImageChops.lighter(zona, m), (x0, y0))
        return
    d = ImageDraw.Draw(mascara)
    if e['tipo'] == 'trazo':
        total = largo_tramos(e['tramos']) or 1
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


# --- Gráficos TikZ en la pizarra ---------------------------------------------------------------
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
        """Partes que dibujan lo que la capa «hasta» añade a la capa «desde», en el
        orden del código TikZ y en píxeles del gráfico. Los textos se escriben a mano."""
        img_antes, previos, dp = self._capa(desde)
        img_ahora, actuales, da = self._capa(hasta)
        alfa_nuevo = np.clip(np.asarray(img_ahora)[:, :, 3].astype(int)
                             - np.asarray(img_antes)[:, :, 3].astype(int), 0, 255).astype(np.uint8)
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
            if e['tipo'] == 'trazo':
                tramos = [[((x + da[0]) * s, (y + da[1]) * s) for x, y in t] for t in e['tramos']]
                largo = largo_tramos(tramos)
                salida.append({'tipo': 'trazo', 'caja': caja, 'tramos': tramos,
                               'grosor': max(3, e['ancho'] * s + 4),
                               'dur': min(1.6, max(0.25, largo / VEL_TRAZO)) + LEVANTAR})
            elif e['tipo'] == 'texto':
                x0, y0 = max(0, int(caja[0]) - 2), max(0, int(caja[1]) - 2)
                x1, y1 = min(self.w, int(math.ceil(caja[2])) + 2), min(self.h, int(math.ceil(caja[3])) + 2)
                if x1 > x0 and y1 > y0:
                    salida.extend(trazos_mano(alfa_nuevo[y0:y1, x0:x1], x0, y0))
            else:
                lado = max(caja[2] - caja[0], caja[3] - caja[1])   # puntas de flecha y puntos: un toque
                salida.append({'tipo': 'relleno', 'caja': caja, 'dur': 0.15 if lado < 60 else 0.5})
        return salida


# --- Fórmulas y texto de pizarra ------------------------------------------------------------
def _grupo(s, i):
    """Índice justo después del grupo {…} o […] que empieza en s[i] (llaves equilibradas)."""
    abre = s[i]
    cierra = '}' if abre == '{' else ']'
    nivel = 0
    for j in range(i, len(s)):
        if s[j] == '\\':
            continue
        if s[j] == abre and (j == 0 or s[j - 1] != '\\'):
            nivel += 1
        elif s[j] == cierra and s[j - 1] != '\\':
            nivel -= 1
            if nivel == 0:
                return j + 1
    raise ValueError('Llaves sin cerrar en tcee.sty')


def _definicion(sty, nombre):
    """La definición de \\nombre en tcee-comun.sty/tcee.sty (\\newcommand, \\providecommand o \\NewDocumentCommand)."""
    m = re.search(r'\\(newcommand|providecommand|NewDocumentCommand)\s*\{\\' + nombre + r'\}', sty)
    if not m:
        raise RuntimeError(f'No encuentro la definición de \\{nombre} en tcee-comun.sty ni en tcee.sty')
    i = m.end()
    grupos = 2 if m.group(1) == 'NewDocumentCommand' else None
    while True:
        while sty[i] in ' \t\n%':
            i = sty.index('\n', i) + 1 if sty[i] == '%' else i + 1
        if grupos is None and sty[i] == '[':
            i = _grupo(sty, i)
            continue
        i = _grupo(sty, i)
        if grupos is None or grupos == 1:
            return sty[m.start():i]
        grupos -= 1


_MACROS_TCEE = None


def macros_tcee():
    """Los macros del temario que pueden salir en una fórmula del vídeo, leídos de los
    propios tcee-comun.sty y tcee.sty (así no se desincronizan): colores, \\vect, \\optim,
    \\tiempo (\\tceemmss), \\autor, \\concepto y el estilo de \\funcionclave. Sin el resto
    del estilo del documento."""
    global _MACROS_TCEE
    if _MACROS_TCEE is None:
        sty = ''.join(open(os.path.join(LATEX, f), encoding='utf-8').read() + '\n'
                      for f in ('tcee-comun.sty', 'tcee.sty') if os.path.exists(os.path.join(LATEX, f)))
        sty = re.sub(r'(?<!\\)%[^\n]*', '', sty)
        partes = re.findall(r'^\\definecolor\{[^}]*\}\{[^}]*\}\{[^}]*\}', sty, re.M)
        for bloque in re.findall(r'\\ExplSyntaxOn.*?\\ExplSyntaxOff', sty, re.S):
            if 'tceemmss' in bloque or '{\\optim}' in bloque:
                partes.append(bloque)
        partes += [_definicion(sty, n) for n in ('vect', 'tiempo', 'autor', 'concepto')]
        i = sty.index('\\tcbset{tcee funcion clave')
        partes.append(sty[i:_grupo(sty, i + len('\\tcbset'))])
        _MACROS_TCEE = '\n'.join(partes)
    return _MACROS_TCEE


# Colores testigo de los recuadros: se pintan así en LaTeX y luego se separan del resto
# para trazarlos al final (a mano, primero se escribe la fórmula y después se recuadra).
TESTIGO_BOXED = (0, 255, 0)
TESTIGO_CLAVE = (0, 255, 255)
FONDO_CLAVE = (247, 243, 248)     # tceemoradopalido!70!white, el fondo de \funcionclave en tcee.sty


def preambulo_formula(formula, color):
    rgb = '{:02X}{:02X}{:02X}'.format(*color)
    p = ['\\documentclass[border=4pt]{standalone}',
         '\\usepackage{amsmath,amssymb,mathtools}\\usepackage{newpxtext,newpxmath}',
         '\\usepackage{xcolor}',
         f'\\definecolor{{tinta}}{{HTML}}{{{rgb}}}',
         '\\definecolor{{tceetestigoboxed}}{{RGB}}{{{},{},{}}}'.format(*TESTIGO_BOXED),
         '\\definecolor{{tceetestigoclave}}{{RGB}}{{{},{},{}}}'.format(*TESTIGO_CLAVE)]
    if 'funcionclave' in formula:
        p.append('\\usepackage{tcolorbox}\\tcbuselibrary{skins,theorems}')
    p.append(macros_tcee() if 'funcionclave' in formula
             else re.sub(r'\\tcbset\{tcee funcion clave.*', '', macros_tcee(), flags=re.S))
    # \funcionclave como en tcee.sty (morado, recuadrada, fondo morado pálido), pero dentro de la
    # fórmula (sin \[…\]) y con el marco en el color testigo, sin fondo y algo más grueso (rotulador);
    # el fondo lo pone el script al final. \boxed: el marco en el color testigo.
    p.append('\\tcbset{tcee funcion clave video/.style={tcee funcion clave,boxrule=1.2pt,interior hidden,'
             'frame code={\\draw[tceetestigoclave,line width=1.2pt,rounded corners=2pt]'
             '([shift={(0.6pt,0.6pt)}]frame.south west) rectangle ([shift={(-0.6pt,-0.6pt)}]frame.north east);}}}'
             '\\NewDocumentCommand{\\funcionclave}{om}{\\tcbhighmath[tcee funcion clave video]{\\displaystyle #2}}'
             if 'funcionclave' in formula else '')
    p.append('\\renewcommand{\\boxed}[1]{{\\colorlet{tceeantes}{.}\\color{tceetestigoboxed}'
             '\\fbox{\\color{tceeantes}$\\displaystyle #1$}}}')
    return '\n'.join(p) + '\n'


def formula_png(formula, color, carpeta):
    """PNG de la fórmula (300 ppp, fondo transparente) con los recuadros ya en su color.
    Si tiene recuadros (\\boxed, \\funcionclave), deja al lado f-…-capas.png: R, lo escrito;
    G, los marcos; B, el fondo de las \\funcionclave (para trazar los marcos al final)."""
    preambulo = preambulo_formula(formula, color)
    h = huella(formula, color, preambulo)
    png = os.path.join(carpeta, f'f-{h}.png')
    if os.path.exists(png):
        return png
    tex = os.path.join(carpeta, f'f-{h}.tex')
    with open(tex, 'w', encoding='utf-8') as f:
        f.write(preambulo + f'\\begin{{document}}\\color{{tinta}}$\\displaystyle {formula}$\\end{{document}}\n')
    cod, _ = ejecutar([os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
                       os.path.basename(tex)], cwd=carpeta, env=entorno_tex(), timeout=300, comprobar=False)
    if cod != 0:
        raise RuntimeError(f'Error en la fórmula {formula!r}:\n' + '\n'.join(errores_log(tex[:-4] + '.log')))
    pix = fitz.open(tex[:-4] + '.pdf')[0].get_pixmap(dpi=300, alpha=True)
    img = np.array(Image.open(io.BytesIO(pix.tobytes('png'))).convert('RGBA'))
    rgb, alfa = img[:, :, :3].astype(int), img[:, :, 3]
    testigo = (alfa > 0) & (rgb[:, :, 1] > 180) & (rgb[:, :, 0] < 90)
    if testigo.any():
        clave = testigo & (rgb[:, :, 2] > 128)
        boxed = testigo & ~clave
        img[boxed, :3] = color
        img[clave, :3] = MORADO
        marco = np.where(testigo, alfa, 0).astype(np.uint8)
        fondo = ndimage.binary_fill_holes(clave & (alfa > 40)) & ~(clave & (alfa > 40))
        tinta = np.where(testigo, 0, alfa).astype(np.uint8)
        final = Image.new('RGBA', (img.shape[1], img.shape[0]), (0, 0, 0, 0))
        if fondo.any():
            capa_fondo = np.zeros_like(img)
            capa_fondo[fondo] = FONDO_CLAVE + (255,)
            final = Image.fromarray(capa_fondo, 'RGBA')
        final.alpha_composite(Image.fromarray(img, 'RGBA'))
        final.save(png)
        Image.fromarray(np.dstack([tinta, marco, (fondo * 255).astype(np.uint8)]), 'RGB').save(png[:-4] + '-capas.png')
    else:
        Image.fromarray(img, 'RGBA').save(png)
    return png


def partes_formula(png, img):
    """Trazos de una fórmula ya escalada (img): primero lo escrito y, al final, los recuadros
    (a la velocidad de los trazos de los gráficos) y el fondo de las funciones clave."""
    capas = png[:-4] + '-capas.png'
    if not os.path.exists(capas):
        return trazos_mano(np.asarray(img)[:, :, 3])
    c = np.asarray(Image.open(capas).resize(img.size, Image.LANCZOS))
    partes = trazos_mano(c[:, :, 0])
    for p in trazos_mano(c[:, :, 1]):
        p['dur'] = min(1.6, max(0.4, p['largo'] / VEL_TRAZO)) + LEVANTAR
        partes.append(p)
    fondo = c[:, :, 2] > 127
    if fondo.any():
        etiquetas, _ = ndimage.label(fondo)
        for sl in ndimage.find_objects(etiquetas):
            if sl is not None:
                partes.append({'tipo': 'relleno', 'caja': (sl[1].start, sl[0].start, sl[1].stop, sl[0].stop),
                               'dur': 0.3})
    return partes


# --- Rejilla de la pizarra ---------------------------------------------------------------------
class Rejilla:
    """División de la pizarra en 1-3 columnas y cada columna en 1 o 2 filas."""

    def __init__(self, spec=None, lineas=None, ancho=None, alto=None):
        """spec: "100", "40|60(55/45)" o {columnas, filas, lineas}; lineas, si se da,
        manda sobre la del dict (así `lineas: true` puede ir junto a `rejilla: "40|60"`).
        ancho y alto: los de la pizarra (por defecto, la de los cantes; en las slides de la
        guía, el panel de pizarra)."""
        self.W, self.H = ancho or PZ_W, alto or PZ_H
        lineas_spec, filas = False, {}
        if spec is None or isinstance(spec, (int, float)):
            cols = [100]
        elif isinstance(spec, str):
            cols = []
            for i, trozo in enumerate(spec.split('|'), 1):
                m = re.fullmatch(r'\s*(\d+(?:\.\d+)?)\s*(?:\(\s*(\d+(?:\.\d+)?)\s*/\s*(\d+(?:\.\d+)?)\s*\))?\s*', trozo)
                if not m:
                    raise ValueError(f'Rejilla no válida: {spec!r} (p. ej. "35|65" o "40|60(55/45)")')
                cols.append(float(m.group(1)))
                if m.group(2):
                    filas[i] = [float(m.group(2)), float(m.group(3))]
        elif isinstance(spec, dict):
            cols = [float(c) for c in spec.get('columnas', [100])]
            filas = {int(k): [float(x) for x in v] for k, v in (spec.get('filas') or {}).items()}
            lineas_spec = bool(spec.get('lineas', False))
        else:
            raise ValueError(f'Rejilla no válida: {spec!r}')
        lineas = bool(lineas) if lineas is not None else lineas_spec
        if not 1 <= len(cols) <= 3 or any(len(v) != 2 or k > len(cols) for k, v in filas.items()):
            raise ValueError(f'Rejilla no válida: {spec!r} (de 1 a 3 columnas; cada una con 1 o 2 filas)')
        self.columnas, x = [], 0.0
        for c in cols:
            ancho = self.W * c / sum(cols)
            self.columnas.append((x, x + ancho))
            x += ancho
        self.filas = {}
        for i in range(1, len(cols) + 1):
            if i in filas:
                a, b = filas[i]
                corte = self.H * a / (a + b)
                self.filas[i] = [(0, corte), (corte, self.H)]
            else:
                self.filas[i] = [(0, self.H)]
        self.lineas = lineas
        self.clave = (tuple(cols), tuple(sorted((k, tuple(v)) for k, v in filas.items())), lineas)

    def celdas_columna(self, c):
        return [f'{c}a', f'{c}b'] if len(self.filas[c]) == 2 else [str(c)]

    def todas(self):
        return [x for c in self.filas for x in self.celdas_columna(c)]

    def caja_celda(self, celda):
        c = int(celda[0])
        f = 'ab'.index(celda[1]) if len(celda) > 1 else 0
        return (self.columnas[c - 1][0], self.filas[c][f][0], self.columnas[c - 1][1], self.filas[c][f][1])

    def zona(self, z):
        """Caja (coordenadas de la pizarra) y celdas de una zona: "1", "2b", "1-2", "1a-2a"."""
        z = str(z if z is not None else '1').replace(' ', '')
        m = re.fullmatch(r'(\d)([ab])?(?:-(\d)([ab])?)?', z)
        if not m:
            raise ValueError(f'Zona de pizarra no válida: {z!r} (1, "2a", "2b", "1-2", "1a-2a")')
        c1, f1 = int(m.group(1)), m.group(2)
        c2, f2 = int(m.group(3) or c1), m.group(4) or f1
        if c2 > len(self.columnas) or c1 < 1 or c2 < c1:
            raise ValueError(f'La zona {z!r} no existe en una rejilla de {len(self.columnas)} columnas')
        x0, x1 = self.columnas[c1 - 1][0], self.columnas[c2 - 1][1]
        celdas = []
        if f1:
            filas_c1 = self.filas[c1]
            y0, y1 = filas_c1['ab'.index(f1)] if len(filas_c1) == 2 else filas_c1[0]
            for c in range(c1, c2 + 1):
                celdas.append(f'{c}{f2}' if len(self.filas[c]) == 2 else str(c))
        else:
            y0, y1 = 0, self.H
            for c in range(c1, c2 + 1):
                celdas.extend(self.celdas_columna(c))
        return (x0, y0, x1, y1), celdas

    def segmentos(self):
        segs = [((x1, 12), (x1, self.H - 12)) for _, x1 in self.columnas[:-1]]
        for c, fs in self.filas.items():
            if len(fs) == 2:
                x0, x1 = self.columnas[c - 1]
                segs.append(((x0 + 14, fs[0][1]), (x1 - 14, fs[0][1])))
        return segs

    def fondo(self):
        img = Image.new('RGB', (self.W, self.H), PIZARRA)
        if self.lineas:
            d = ImageDraw.Draw(img)
            for a, b in self.segmentos():
                d.line([a, b], fill=RAYA, width=3)
        return img


# --- Pizarra: dónde va cada cosa y qué hay que dibujar -----------------------------------------
class Pizarra:
    """Coloca lo que se escribe en la rejilla (cada cosa debajo de lo último de su
    zona) y devuelve las operaciones de dibujo y de borrado para el tablero."""

    def __init__(self, tema, carpeta, ancho=None, alto=None):
        self.tema, self.carpeta = tema, carpeta
        self.W, self.H = ancho or PZ_W, alto or PZ_H
        self.rejilla = Rejilla(None, None, self.W, self.H)
        self.fondo = self.rejilla.fondo()
        self.elementos = []           # {'celdas': set, 'y_fin': y, 'caja': (x0, y0, x1, y1)}
        self.graficos = {}
        self.cursor = {}
        self.tope = {}                # celda → hasta dónde se puede escribir (encima de lo conservado)
        self.avisos = []
        self._reiniciar(self.rejilla.todas())

    def _reiniciar(self, celdas):
        """Cursor de cada celda: arriba si está vacía; si queda algo (lo conservado), debajo de
        ello o, si está abajo y deja sitio encima, arriba y con tope en lo conservado."""
        for c in celdas:
            arriba = self.rejilla.caja_celda(c)[1] + PZ_MARGEN
            restos = [e for e in self.elementos if c in e['celdas']]
            self.tope.pop(c, None)
            if not restos:
                self.cursor[c] = arriba
                continue
            y0 = min(e['caja'][1] for e in restos)
            if y0 - arriba >= 150:
                self.cursor[c], self.tope[c] = arriba, y0 - 16
            else:
                self.cursor[c] = max(e['y_fin'] for e in restos) + 16

    def _celdas_de(self, zonas):
        celdas = set()
        for z in ([] if zonas is None else zonas if isinstance(zonas, list) else [zonas]):
            celdas |= set(self.rejilla.zona(str(z))[1])
        return celdas

    def _recolocar(self, rejilla, caja, que):
        """Celdas de la rejilla nueva que ocupa algo conservado (avisa si no cabe en una)."""
        celdas = set()
        for c in rejilla.todas():
            x0, y0, x1, y1 = rejilla.caja_celda(c)
            if min(x1, caja[2]) - max(x0, caja[0]) > 4 and min(y1, caja[3]) - max(y0, caja[1]) > 4:
                celdas.add(c)
        if len(celdas) != 1:
            self.avisos.append(f'Lo conservado ({que}) no cabe en una sola celda de la rejilla nueva: '
                               f'elegir una rejilla cuya celda lo contenga')
        return celdas

    def cambiar_rejilla(self, spec, conservar=None, lineas=None):
        """Cambia la rejilla y borra la pizarra, salvo lo escrito en las zonas «conservar» (de la
        rejilla vieja), que se queda donde está y pasa a la celda de la rejilla nueva que lo contiene."""
        nueva = Rejilla(spec, lineas, self.W, self.H)
        if nueva.clave == self.rejilla.clave:
            return []
        guardar = self._celdas_de(conservar)
        quedan = [e for e in self.elementos if e['celdas'] <= guardar] if guardar else []
        graficos = {n: g for n, g in self.graficos.items() if g['celdas'] <= guardar} if guardar else {}
        ops = []
        if len(quedan) < len(self.elementos) or self.rejilla.lineas:
            op = op_borrar((0, 0, self.W, self.H), Image.new('RGB', (self.W, self.H), PIZARRA))
            if quedan:
                op['conservar'] = [e['caja'] for e in quedan]
            ops.append(op)
        zonas = ', '.join(map(str, conservar if isinstance(conservar, list) else [conservar]))
        for e in quedan:
            e['celdas'] = self._recolocar(nueva, e['caja'], f'zona {zonas}')
        for g in graficos.values():
            gr = g['g']
            g['celdas'] = self._recolocar(nueva, (gr.x, gr.y, gr.x + gr.w, gr.y + gr.h), f'gráfico {gr.nombre}')
        self.rejilla, self.elementos, self.graficos, self.cursor, self.tope = nueva, quedan, graficos, {}, {}
        self._reiniciar(nueva.todas())
        self.fondo = nueva.fondo()
        if nueva.lineas:
            partes = []
            for a, b in nueva.segmentos():
                largo = math.dist(a, b)
                partes.append({'tipo': 'trazo', 'tramos': [[a, b]], 'grosor': 7, 'caja': None,
                               'dur': largo / VEL_REGLA + 0.1})
            ops.append({'tipo': 'lineas', 'caja': (0, 0, self.W, self.H), 'fondo': self.fondo, 'partes': partes})
        return ops

    def borrar(self, cuales, conservar=None):
        if cuales is True or cuales == 'todo':
            zonas = None
        else:
            zonas = [str(z) for z in (cuales if isinstance(cuales, list) else [cuales])]
        if zonas is None:
            cajas, celdas = [(0, 0, self.W, self.H)], set(self.rejilla.todas())
        else:
            cajas, celdas = [], set()
            for z in zonas:
                caja, cs = self.rejilla.zona(z)
                cajas.append(caja)
                celdas |= set(cs)
        guardar = self._celdas_de(conservar)
        celdas -= guardar
        tocados = [e for e in self.elementos if e['celdas'] & celdas]
        self.elementos = [e for e in self.elementos if not e['celdas'] & celdas]
        for nombre, g in list(self.graficos.items()):
            if g['celdas'] & celdas:
                del self.graficos[nombre]
        self._reiniciar(celdas)
        if not tocados:
            return []
        ops = [op_borrar(tuple(int(round(v)) for v in caja), self.fondo) for caja in cajas]
        if guardar:
            for op in ops:
                op['conservar'] = [e['caja'] for e in self.elementos]
        return ops

    def _sitio(self, zona, alto_min):
        caja, celdas = self.rejilla.zona(zona)
        x0, x1 = caja[0] + PZ_MARGEN, caja[2] - PZ_MARGEN
        y = max(self.cursor[c] for c in celdas)
        limite = min([caja[3] - 8] + [self.tope[c] for c in celdas if c in self.tope])
        if y + alto_min > limite:
            self.avisos.append(f'La pizarra se llena en la zona {zona}: hay que borrar antes o cambiar la rejilla')
        return x0, x1, y, limite, celdas

    def _ocupar(self, celdas, y_fin, limite, zona, caja):
        if y_fin > limite + 2:
            self.avisos.append(f'Lo escrito en la zona {zona} se sale de la pizarra: borrar antes o reducir')
        for c in celdas:
            self.cursor[c] = y_fin + 16
        self.elementos.append({'celdas': set(celdas), 'y_fin': y_fin, 'caja': tuple(int(round(v)) for v in caja)})

    def anadir(self, accion):
        """Coloca un elemento y devuelve la operación que lo dibuja."""
        if accion.get('_apoyo'):
            return self.anadir_apoyo(accion)
        color = ROTULADOR.get(accion.get('color', ''), None)
        zona = accion.get('zona')
        if 'escribe' in accion:
            texto = str(accion['escribe'])
            titulo = texto.startswith('#')
            nivel = len(texto.lstrip('#').lstrip()) - len(texto.lstrip('#').lstrip().lstrip('>'))
            texto = texto.lstrip('#> ').strip()
            f = F_PIZ_T if titulo else F_PIZ
            color = color or (ROTULADOR['rojo'] if titulo else ROTULADOR['azul'])
            x0, x1, y, limite, celdas = self._sitio(zona, 60)
            sangria = 40 * nivel
            avisar_glifos(texto, f, 'pizarra', self.avisos)
            lineas = partir(('– ' if nivel else '') + texto, f, x1 - x0 - sangria)
            alto = 58 * len(lineas) + (12 if titulo else 0)
            img = Image.new('RGBA', (max(1, int(x1 - x0)), alto), (0, 0, 0, 0))
            d = ImageDraw.Draw(img)
            for i, l in enumerate(lineas):
                escribir(d, (sangria, i * 58), l, f, color + (255,))
            if titulo:
                largo = max(ancho_texto(l, f) for l in lineas)
                d.line([(sangria, alto - 9), (sangria + largo, alto - 6)], fill=color + (255,), width=4)
            pos = (int(x0), int(y))
            ancho_t = max(ancho_texto(l, f) for l in lineas) if lineas else 0
            self._ocupar(celdas, y + alto, limite, zona, (x0 + sangria, y, x0 + sangria + ancho_t, y + alto))
            return op_dibujo(pos, img, False, self.fondo, trazos_mano(np.asarray(img)[:, :, 3]))
        if 'formula' in accion:
            png = formula_png(accion['formula'], color or ROTULADOR['negro'], self.carpeta)
            img = Image.open(png).convert('RGBA')
            x0, x1, y, limite, celdas = self._sitio(zona, 80)
            escala = min(accion.get('tam', 1.0) * 1.1, (x1 - x0) / img.width)
            img = img.resize((max(1, int(img.width * escala)), max(1, int(img.height * escala))), Image.LANCZOS)
            izquierda = accion.get('alinear') == 'izquierda' or accion.get('centrar') is False
            pos = (int(x0) if izquierda else int(x0 + (x1 - x0 - img.width) / 2), int(y))
            self._ocupar(celdas, y + img.height, limite, zona, (pos[0], pos[1], pos[0] + img.width, pos[1] + img.height))
            return op_dibujo(pos, img, False, self.fondo, partes_formula(png, img))
        if 'imagen' in accion:
            img = Image.open(os.path.join(self.tema.dir, accion['imagen'])).convert('RGBA')
            x0, x1, y, limite, celdas = self._sitio(zona, 200)
            alto = (limite - y) * float(accion.get('alto', 1.0))
            escala = min((x1 - x0) / img.width, alto / img.height)
            img = img.resize((max(1, int(img.width * escala)), max(1, int(img.height * escala))), Image.LANCZOS)
            pos = (int(x0 + (x1 - x0 - img.width) / 2), int(y))
            self._ocupar(celdas, y + img.height, limite, zona, (pos[0], pos[1], pos[0] + img.width, pos[1] + img.height))
            return op_dibujo(pos, img, False, self.fondo,
                             [{'tipo': 'relleno', 'caja': (0, 0, img.width, img.height), 'dur': 0.8}])
        if 'grafico' in accion:
            nombre = accion['grafico']
            capa = int(accion.get('capa', 1000))
            if nombre not in self.graficos:
                # Los gráficos 3D no se dibujan trazo a trazo en la pizarra (CRITERIOS, «Vídeo»):
                # van como apoyo o como boceto a mano de pocas líneas
                ruta_tex = os.path.join(self.tema.graficos, f'{nombre}.tex')
                if os.path.exists(ruta_tex) and re.search(r'\bview\s*=|z\s*buffer|\\addplot3|\bz\s*=\s*\{\(',
                                                          open(ruta_tex, encoding='utf-8').read()):
                    self.avisos.append(f'El gráfico {nombre} es 3D y se dibuja en la pizarra: ponlo como apoyo '
                                       'o haz un boceto a mano (CRITERIOS, «Vídeo»)')
            elif capa < self.graficos[nombre]['g'].capa:
                self.avisos.append(f'El gráfico {nombre} baja de la capa {self.graficos[nombre]["g"].capa} a la '
                                   f'{capa}: las capas van subiendo (para empezar de nuevo, borrar antes)')
            if nombre not in self.graficos:
                x0, x1, y, limite, celdas = self._sitio(zona, 300)
                alto = (limite - y) * float(accion.get('alto', 1.0))
                g = Grafico(self.tema, nombre, self.carpeta, (x0, y, x1, y + alto))
                self._ocupar(celdas, y + g.h, limite, zona, (g.x, g.y, g.x + g.w, g.y + g.h))
                self.graficos[nombre] = {'g': g, 'celdas': set(celdas)}
            g = self.graficos[nombre]['g']
            partes = g.nuevos(g.capa, capa)
            g.capa = capa
            return op_dibujo((g.x, g.y), g.imagen(), True, self.fondo, partes)
        raise ValueError(f'Acción de pizarra desconocida: {accion}')

    def anadir_apoyo(self, accion):
        """Material de apoyo (gráfico, fórmula, texto o imagen) que NO escribe el opositor:
        una tarjeta azulada con su rótulo, en una celda de la rejilla, que aparece de golpe.
        Con `sustituye: true`, antes se quita el apoyo que hubiera en esa zona (para el apoyo
        que «se mueve»: estados sucesivos de un gráfico). Devuelve una lista de operaciones."""
        zona = accion.get('zona')
        ops = []
        if accion.get('sustituye'):
            _, celdas_z = self.rejilla.zona(zona)
            previos = [e for e in self.elementos if e.get('apoyo') and e['celdas'] & set(celdas_z)]
            if previos:
                self.elementos = [e for e in self.elementos if e not in previos]
                self._reiniciar(set(celdas_z))
                ops += [op_borrar(e['caja'], self.fondo) for e in previos]
        x0, x1, y, limite, celdas = self._sitio(zona, 200)
        alto_max = (limite - y) * float(accion.get('alto', 1.0))
        ancho, margen, cab = int(x1 - x0), 18, 42
        caja_util = (ancho - 2 * margen, int(alto_max) - cab - margen)
        if 'grafico' in accion:
            g = Grafico(self.tema, accion['grafico'], self.carpeta, (0, 0, caja_util[0], caja_util[1]))
            dentro = g.imagen(int(accion.get('capa', 1000)))
        elif 'formula' in accion:
            dentro = Image.open(formula_png(accion['formula'], TINTA, self.carpeta)).convert('RGBA')
            esc = min(accion.get('tam', 1.0), caja_util[0] / dentro.width, caja_util[1] / dentro.height)
            dentro = dentro.resize((max(1, int(dentro.width * esc)), max(1, int(dentro.height * esc))), Image.LANCZOS)
        elif 'imagen' in accion:
            dentro = Image.open(os.path.join(self.tema.dir, accion['imagen'])).convert('RGBA')
            esc = min(caja_util[0] / dentro.width, caja_util[1] / dentro.height)
            dentro = dentro.resize((max(1, int(dentro.width * esc)), max(1, int(dentro.height * esc))), Image.LANCZOS)
        else:
            lineas = []
            for t in ([accion['texto']] if isinstance(accion.get('texto'), str) else accion.get('texto', [])):
                avisar_glifos(str(t), F_APOYO, 'apoyo', self.avisos)
                lineas += partir(str(t), F_APOYO, caja_util[0])
            dentro = Image.new('RGBA', (caja_util[0], max(1, 44 * len(lineas))), (0, 0, 0, 0))
            dd = ImageDraw.Draw(dentro)
            for i, l in enumerate(lineas):
                escribir(dd, (0, i * 44), l, F_APOYO, TINTA + (255,))
        alto = min(int(alto_max), dentro.height + cab + margen)
        tarjeta = Image.new('RGBA', (ancho, alto), (0, 0, 0, 0))
        d = ImageDraw.Draw(tarjeta)
        d.rounded_rectangle([0, 0, ancho - 1, alto - 1], radius=14, fill=APOYO_FONDO + (255,), outline=APOYO_BORDE, width=2)
        d.text((margen, 9), 'APOYO  ·  no se escribe en la pizarra', font=F_MARCO, fill=APOYO_BORDE)
        tarjeta.alpha_composite(dentro, ((ancho - dentro.width) // 2, cab))
        pos = (int(x0), int(y))
        self._ocupar(celdas, y + alto, limite, zona, (x0, y, x0 + ancho, y + alto))
        self.elementos[-1]['apoyo'] = True
        return ops + [op_dibujo(pos, tarjeta, False, self.fondo,
                                [{'tipo': 'relleno', 'caja': (0, 0, ancho, alto), 'dur': 0.3}])]


def op_dibujo(pos, img, reemplaza, fondo, partes):
    return {'tipo': 'dibujo', 'caja': (pos[0], pos[1], pos[0] + img.width, pos[1] + img.height), 'img': img,
            'reemplaza': reemplaza, 'fondo': fondo, 'partes': partes}


def op_borrar(caja, fondo):
    x0, y0, x1, y1 = caja
    return {'tipo': 'borrar', 'caja': caja, 'fondo': fondo,
            'partes': [{'tipo': 'barrido', 'caja': (0, 0, x1 - x0, y1 - y0), 'dur': 0.3 + (x1 - x0) / 4000}]}


# --- Tablero: la pizarra en cada instante --------------------------------------------------------
class Tablero:
    """Ejecuta las operaciones programadas (inicio, fin, ritmo) y da la imagen de la
    pizarra en cada instante. Hay que pedirla con tiempos crecientes."""

    def __init__(self, ops):
        self.img = Image.new('RGB', (PZ_W, PZ_H), PIZARRA)
        self.ops = ops
        self.i = 0
        self.version = 0

    def _preparar(self, op):
        antes = self.img.crop(op['caja'])
        if op['tipo'] == 'dibujo':
            base = (op['fondo'].crop(op['caja']) if op['reemplaza'] else antes).convert('RGBA')
            base.alpha_composite(op['img'])
            final = base.convert('RGB')
        elif op['tipo'] == 'lineas':          # solo cambian las rayas: lo que hubiera (lo conservado) sigue
            m = Image.new('L', antes.size, 0)
            for p in op['partes']:
                dibujar_mascara(m, p, 1.0)
            final = Image.composite(op['fondo'].crop(op['caja']), antes, m)
        else:
            final = op['fondo'].crop(op['caja'])
            x0, y0, x1, y1 = op['caja']
            for c in op.get('conservar', []):        # lo conservado no se borra
                r = (max(x0, c[0]), max(y0, c[1]), min(x1, c[2]), min(y1, c[3]))
                if r[2] > r[0] and r[3] > r[1]:
                    final.paste(antes.crop((r[0] - x0, r[1] - y0, r[2] - x0, r[3] - y0)), (r[0] - x0, r[1] - y0))
        op['antes'], op['final'] = antes, final
        op['mascara'] = Image.new('L', antes.size, 0)
        op['k'] = 0
        acum = [0.0]
        for p in op['partes']:
            acum.append(acum[-1] + p['dur'])
        op['acum'] = acum

    def imagen(self, t):
        """(imagen, clave): la clave cambia solo cuando cambia la imagen."""
        while self.i < len(self.ops):
            op = self.ops[self.i]
            if t < op['inicio']:
                break
            if 'antes' not in op:
                self._preparar(op)
            if t >= op['fin']:
                self.img.paste(op['final'], op['caja'][:2])
                for k in ('antes', 'final', 'mascara', 'img'):
                    op.pop(k, None)
                self.i += 1
                self.version += 1
                continue
            tr = (t - op['inicio']) / op['ritmo']
            partes = op['partes']
            while op['k'] < len(partes) and op['acum'][op['k'] + 1] <= tr:
                dibujar_mascara(op['mascara'], partes[op['k']], 1.0)
                op['k'] += 1
            m = op['mascara']
            if op['k'] < len(partes):
                p = partes[op['k']]
                u = (tr - op['acum'][op['k']]) / max(1e-6, p['dur'])
                m = m.copy()
                dibujar_mascara(m, p, min(1.0, max(0.0, u)))
            salida = self.img.copy()
            salida.paste(Image.composite(op['final'], op['antes'], m), op['caja'][:2])
            return salida, (self.version, self.i, round(t * FPS))
        return self.img, (self.version,)


def programar(ops, avisos):
    """Pone inicio, fin y ritmo a las operaciones: en cola, a velocidad de mano, sin
    pasar de su barrera (si no da tiempo, se acelera todo el grupo)."""
    grupos = []
    for op in ops:
        if grupos and grupos[-1][0]['barrera'] == op['barrera']:
            grupos[-1].append(op)
        else:
            grupos.append([op])
    for grupo in grupos:
        barrera = grupo[0]['barrera']

        def fin_con(f, asignar=False):
            t = -1e9
            for op in grupo:
                ini = max(op['listo'], t)
                dur = sum(p['dur'] for p in op['partes']) / f
                t = ini + dur
                if asignar:
                    op['inicio'], op['fin'], op['ritmo'] = ini, t, 1 / f
            return t

        f = 1.0
        if fin_con(1.0) > barrera:
            lo, hi = 1.0, 50.0
            for _ in range(40):
                mid = (lo + hi) / 2
                if fin_con(mid) > barrera:
                    lo = mid
                else:
                    hi = mid
            f = hi
            if f > ACELERACION_MAX:
                op0 = grupo[0]
                avisos.append(f'{mmss(op0["listo"])} («{op0.get("dicho", "")[:45]}…»): para acabar a tiempo la mano '
                              f'tendría que ir {f:.1f} veces más rápido de lo natural: quitar cosas de la pizarra, '
                              f'repartirlas en más pasos o borrar más tarde')
        fin_con(f, asignar=True)


def partir(texto, fuente_, ancho):
    palabras, lineas, actual = texto.split(), [], ''
    medidor = ImageDraw.Draw(Image.new('L', (1, 1)))
    for p in palabras:
        prueba = (actual + ' ' + p).strip()
        if ancho_texto(prueba, fuente_, medidor) <= ancho or not actual:
            actual = prueba
        else:
            lineas.append(actual)
            actual = p
    if actual:
        lineas.append(actual)
    return lineas



def mezclar(a, b, u):
    return tuple(int(round(x + (y - x) * u)) for x, y in zip(a, b))


def suave(u):
    u = min(1.0, max(0.0, u))
    return u * u * (3 - 2 * u)


def recortar(d, texto, fnt, ancho):
    if ancho_texto(texto, fnt, d) <= ancho:
        return texto
    while len(texto) > 3 and ancho_texto(texto + '…', fnt, d) > ancho:
        texto = texto[:-1]
    return texto.rstrip(' .,:;') + '…'


def marca_hecho(d, cx, cy, r, color, grosor=3):
    """Marca de «ya expuesto» (✓) dibujada a mano."""
    d.line([(cx - r * 0.55, cy), (cx - r * 0.12, cy + r * 0.45), (cx + r * 0.6, cy - r * 0.5)],
           fill=color, width=grosor, joint='curve')


# --- Pantallas -----------------------------------------------------------------------------
class Pantallas:
    def __init__(self, tema, guion, titulo, corto):
        self.tema, self.titulo, self.corto = tema, titulo, corto
        self.total = float(guion.get('duracion', 1800))
        # Rótulo de la licencia (portada y cierre): «© 2026 Víctor Gutiérrez Marcos · CC BY-NC-ND 4.0»
        self.exclusivo = es_exclusivo(tema)
        self.licencia = licencia_corta(anio_tema(tema), self.exclusivo)
        self.bloques = guion['bloques']
        self.escenas = guion['escenas']
        # Formato «slides» (la guía del dictamen): en la cabecera, el tiempo transcurrido sobre el
        # total («38′ / 90′»), y ningún texto se puede recortar (lo que no cabe se apunta en «cortes»)
        self.slides = guion.get('formato') == 'slides'
        self.cortes = []
        total = sum(b.get('minutos', 1) for b in self.bloques)
        # Cada bloque ocupa en la cabecera lo que dura (como mínimo 200 px)
        anchos = [max(200, (ANCHO - 60) * b.get('minutos', 1) / total) for b in self.bloques]
        if len(self.bloques) > 6:
            # Con muchos bloques (la guía del dictamen) cada uno lleva el ancho de su nombre (o de
            # su «corto») y el sitio que sobra se reparte según los minutos, para que no se recorten
            medida = ImageDraw.Draw(Image.new('RGB', (8, 8)))
            nombres = [medida.textlength(b.get('corto') or b['nombre'], font=F_UI_N) + 50 for b in self.bloques]
            sobra = (ANCHO - 60) - sum(nombres)
            if sobra > 0:
                anchos = [n + sobra * b.get('minutos', 1) / total for n, b in zip(nombres, self.bloques)]
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
        # Apartados de cada bloque (segundo nivel): consecutivos con la misma clave
        self.apartados = {}
        for b in self.bloques:
            lista = []
            for i in self.escenas_bloque[b['nombre']]:
                clave, etiqueta = self.clave_apartado(i)
                if lista and lista[-1]['clave'] == clave:
                    lista[-1]['escenas'].append(i)
                else:
                    lista.append({'clave': clave, 'etiqueta': etiqueta, 'escenas': [i]})
            self.apartados[b['nombre']] = lista

    def _recortar(self, d, texto, fnt, ancho):
        corto = recortar(d, texto, fnt, ancho)
        if self.slides and corto != texto and texto not in self.cortes:
            self.cortes.append(texto)
        return corto

    def clave_apartado(self, i):
        e = self.escenas[i]
        titulo = e.get('titulo') or e['bloque']
        if e.get('apartado'):
            return str(e['apartado']), titulo.split(':')[0].strip()
        m = re.match(r'^([IVX]+\.\d+)\.?\s', titulo)
        if m:
            return m.group(1), titulo.split(':')[0].strip()
        if e.get('estructura'):
            return '_partes', None
        return '_presentacion', 'Esquema del bloque'

    def cambia_apartado(self, previa, nueva):
        a, b = self.escenas[previa], self.escenas[nueva]
        return a['bloque'] != b['bloque'] or self.clave_apartado(previa)[0] != self.clave_apartado(nueva)[0]

    def subtitulo(self, i):
        titulo = self.escenas[i].get('titulo') or ''
        return titulo.split(':', 1)[1].strip() if ':' in titulo else None

    def _pasos_fila(self, escena, parte):
        """Lo que sale en la tercera fila: [(etiqueta, estado, [estados de sus escenas])]."""
        e = self.escenas[escena]
        if e.get('estructura'):
            nombres = list(e['estructura'])
            k = nombres.index(parte) if parte in nombres else -1
            return [(n, 'actual' if j == k else ('hecho' if j < k else 'futuro'), []) for j, n in enumerate(nombres)]
        filas = []
        for ap in self.apartados[e['bloque']]:
            if ap['clave'] == '_partes':
                continue
            if escena in ap['escenas']:
                estado = 'actual'
            elif escena > max(ap['escenas']):
                estado = 'hecho'
            else:
                estado = 'futuro'
            puntos = ['hecho' if j < escena else ('actual' if j == escena else 'futuro') for j in ap['escenas']] \
                if len(ap['escenas']) > 1 else []
            filas.append((ap['etiqueta'], estado, puntos))
        return filas

    def cabecera(self, escena, t, total, parte=None, brillo=0.0, brillo_bloque=0.0):
        img = Image.new('RGB', (ANCHO, CAB), MORADO)
        d = ImageDraw.Draw(img)
        e = self.escenas[escena]
        # Fila 1: tema, apartado y reloj
        izq = self.tema.etiqueta
        d.text((30, 11), izq, font=F_BARRA, fill='white')
        x = 30 + d.textlength(izq, font=F_BARRA) + 22
        # Sin decimales y con primas, como en el tema (CRITERIOS.md): 12′05″ / 30′ · quedan 17′55″;
        # en las slides, solo los minutos transcurridos sobre el total: 38′ / 90′
        reloj = (f'{int(t // 60)}′ / {int(round(total / 60))}′' if self.slides else
                 f'{segundos_texto(t)} / {segundos_texto(total)}   ·   quedan {segundos_texto(total - t)}')
        w_reloj = d.textlength(reloj, font=F_BARRA_L)
        d.text((ANCHO - 30 - w_reloj, 11), reloj, font=F_BARRA_L, fill=(236, 226, 246))
        d.text((x, 11), self._recortar(d, e.get('titulo') or e['bloque'], F_BARRA_L, ANCHO - 90 - w_reloj - x),
               font=F_BARRA_L, fill=(236, 226, 246))
        # Fila 2: bloques de la exposición
        d.rectangle([0, 54, ANCHO, 98], fill=MORADO_OSCURO)
        for (x0, x1), b in zip(self.celdas, self.bloques):
            indices = self.escenas_bloque[b['nombre']]
            actual = escena in indices
            pasado = bool(indices) and escena > max(indices)
            if actual:
                d.rounded_rectangle([x0 + 2, 59, x1 - 2, 93], radius=8,
                                    fill=mezclar(MORADO_MEDIO, (150, 190, 135), brillo_bloque))
            color = (255, 255, 255) if actual else (LILA if pasado else LILA_APAGADO)
            fnt = F_UI_N if actual else F_UI
            xt = x0 + 12
            if pasado:
                marca_hecho(d, xt + 8, 76, 11, LILA)
                xt += 26
            # Minutos del bloque a la derecha de la celda (2′30″), si caben sin recortar el nombre
            ancho_min = 0
            if b.get('minutos') is not None:
                etiqueta_min = minutos_texto(b['minutos'])
                ancho_min = d.textlength(etiqueta_min, font=F_PASO)
                if d.textlength(b.get('corto') or b['nombre'], font=fnt) + ancho_min + 24 <= x1 - xt - 10 \
                        or x1 - xt - 10 - ancho_min - 14 >= 260:
                    d.text((x1 - 12 - ancho_min, 66), etiqueta_min, font=F_PASO,
                           fill=(225, 212, 238) if actual else LILA_APAGADO)
                    ancho_min += 14
                else:
                    ancho_min = 0
            # «corto» (opcional): el nombre que cabe en la cabecera si hay muchos bloques (la guía
            # del dictamen); el esquema de la exposición usa siempre el nombre completo
            d.text((xt, 63), self._recortar(d, b.get('corto') or b['nombre'], fnt, x1 - xt - 10 - ancho_min), font=fnt,
                   fill=color)
        # Fila 3: apartados del bloque actual (o partes de la introducción y la conclusión)
        d.rectangle([0, 98, ANCHO, CAB - 6], fill=(72, 33, 102))
        filas = self._pasos_fila(escena, parte)
        if filas:
            espacio = (ANCHO - 60) / len(filas)
            for j, (etiqueta, estado, puntos) in enumerate(filas):
                x0 = 30 + j * espacio
                cx, cy, r = x0 + 16, 121, 10
                if j > 0:
                    d.line([(x0 - 14, cy), (x0 + 2, cy)], fill=LILA_APAGADO, width=2)
                fnt = F_PASO_N if estado == 'actual' else F_PASO
                ancho_puntos = 14 * len(puntos) + (8 if puntos else 0)
                texto = self._recortar(d, etiqueta, fnt, espacio - 60 - ancho_puntos)
                w = d.textlength(texto, font=fnt)
                if estado == 'actual':
                    d.rounded_rectangle([x0 - 2, 103, x0 + 40 + w + ancho_puntos + 10, 139], radius=17,
                                        fill=mezclar(MORADO_MEDIO, (150, 190, 135), brillo))
                    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=SALVIA)
                    color = (255, 255, 255)
                elif estado == 'hecho':
                    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=LILA)
                    marca_hecho(d, cx, cy, r, MORADO_OSCURO, 3)
                    color = LILA
                else:
                    d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=LILA_APAGADO, width=2)
                    color = LILA_APAGADO
                d.text((x0 + 36, 109), texto, font=fnt, fill=color)
                px = x0 + 36 + w + 12
                for est in puntos:
                    rr = 4
                    if est == 'hecho':
                        d.ellipse([px - rr, cy - rr, px + rr, cy + rr], fill=LILA)
                    elif est == 'actual':
                        d.ellipse([px - rr - 1, cy - rr - 1, px + rr + 1, cy + rr + 1], fill=SALVIA)
                    else:
                        d.ellipse([px - rr, cy - rr, px + rr, cy + rr], outline=LILA_APAGADO, width=2)
                    px += 14
        # Marca de agua discreta de los exclusivos, en todos los fotogramas (sobre la barra de progreso;
        # en las slides, al pie de cada slide, porque aquí taparía los pasos de la tercera fila)
        if self.exclusivo and not self.slides:
            d.text((ANCHO - 30, CAB - 10), self.licencia, font=F_MARCO, fill=(150, 120, 172), anchor='rs')
        # Barra de progreso
        d.rectangle([0, CAB - 6, ANCHO, CAB], fill=(90, 60, 112))
        d.rectangle([0, CAB - 6, int(ANCHO * min(1, t / total)), CAB], fill=SALVIA_OSCURO)
        return img

    # Esquema de la exposición al cambiar de apartado (como \tableofcontents de Beamer)
    def _filas_esquema(self, escena):
        filas = []      # (tipo, texto, estado, escenas)
        for b in self.bloques:
            indices = self.escenas_bloque[b['nombre']]
            if escena in indices:
                estado = 'actual'
            elif indices and escena > max(indices):
                estado = 'hecho'
            else:
                estado = 'futuro'
            filas.append(('bloque', b['nombre'], estado, indices))
            if estado != 'actual':
                continue
            for ap in self.apartados[b['nombre']]:
                if ap['clave'] in ('_partes',):
                    continue
                est = 'actual' if escena in ap['escenas'] else ('hecho' if escena > max(ap['escenas']) else 'futuro')
                filas.append(('apartado', ap['etiqueta'], est, ap['escenas']))
                if est == 'actual' and len(ap['escenas']) > 1:
                    for j in ap['escenas']:
                        sub = self.subtitulo(j)
                        if sub:
                            filas.append(('sub', sub, 'actual' if j == escena else ('hecho' if j < escena else 'futuro'),
                                          [j]))
        return filas

    def tarjeta(self, escena, previa, u):
        """Tarjeta con el esquema; la banda de resalte va del apartado anterior al nuevo."""
        filas = self._filas_esquema(escena)
        altos = {'bloque': 62, 'apartado': 50, 'sub': 42}
        altos_base = dict(altos)
        sangria = {'bloque': 0, 'apartado': 48, 'sub': 96}
        fuentes = {'bloque': F_TARJETA_B, 'apartado': F_TARJETA_A, 'sub': F_TARJETA_S}
        ancho = 1240
        # Con muchos bloques y apartados (la guía del dictamen, de 1 h 30 min) el esquema no
        # cabría en la pantalla: se quitan los subapartados que no son el actual y, si aún no
        # cabe, se reducen las filas y la letra (en los cantes de 30 minutos no cambia nada)
        disponible = ALTO - CAB - 20 - 140   # lo que ya cabía no cambia
        if sum(altos[f[0]] for f in filas) > disponible:
            filas = [f for f in filas if f[0] != 'sub' or f[2] == 'actual']
        necesario = sum(altos[f[0]] for f in filas)
        if necesario > disponible:
            k = disponible / necesario
            altos = {t: int(a * k) for t, a in altos.items()}
            fuentes = {'bloque': fuente('palab.ttf', int(38 * k)), 'apartado': fuente('pala.ttf', int(33 * k)),
                       'sub': fuente('palai.ttf', int(28 * k))}
        alto = 110 + sum(altos[f[0]] for f in filas) + 30
        img = Image.new('RGBA', (ancho, alto), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        d.rounded_rectangle([0, 0, ancho - 1, alto - 1], radius=18, fill=PAPEL + (255,), outline=MORADO + (255,),
                            width=3)
        d.text((48, 34), 'ESQUEMA DE LA EXPOSICIÓN', font=F_TARJETA_T, fill=MORADO)
        d.line([(48, 70), (ancho - 48, 70)], fill=LILA, width=2)
        ys, y = [], 96
        for f in filas:
            ys.append(y)
            y += altos[f[0]]

        def fila_de(esc):
            """La fila más profunda que corresponde a una escena (para la banda)."""
            mejor = None
            for k, f in enumerate(filas):
                if esc in f[3]:
                    mejor = k
            return mejor

        destino = fila_de(escena)
        origen = fila_de(previa) if previa is not None else destino
        if origen is None:
            origen = destino
        if destino is not None:
            v = suave(u)
            y_banda = ys[origen] + (ys[destino] - ys[origen]) * v
            h_banda = altos[filas[origen][0]] + (altos[filas[destino][0]] - altos[filas[origen][0]]) * v
            x_banda = 34 + sangria[filas[origen][0]] + (sangria[filas[destino][0]] - sangria[filas[origen][0]]) * v
            d.rounded_rectangle([x_banda, y_banda - 4, ancho - 34, y_banda + h_banda - 8], radius=10,
                                fill=MORADO_PALIDO + (255,), outline=MORADO_MEDIO + (255,), width=2)
        for k, (tipo, texto, estado, _) in enumerate(filas):
            x = 60 + sangria[tipo]
            fnt = fuentes[tipo]
            color = MORADO if estado == 'actual' else ((150, 140, 158) if estado == 'hecho' else TINTA)
            if estado == 'hecho':
                marca_hecho(d, x + 10, ys[k] + altos[tipo] / 2 - 6, 12, SALVIA_OSCURO, 4)
            elif estado == 'actual' and k == destino:
                m = altos[tipo] / altos_base[tipo]
                d.polygon([(x + 2, ys[k] + 8 * m), (x + 2, ys[k] + 32 * m), (x + 20, ys[k] + 20 * m)], fill=MORADO)
            d.text((x + 36, ys[k]), self._recortar(d, texto, fnt, ancho - x - 90), font=fnt, fill=color)
        return img

    def rotulo_duracion(self):
        """«Cante del tema · 30 minutos» o, en la guía del dictamen, «Vídeo de la guía · 1 h 30 min»."""
        minutos = int(round(self.total / 60))
        if self.tema.es_dictamen:
            h, m = divmod(minutos, 60)
            return 'Vídeo de la guía · ' + (f'{h} h {m} min' if h and m else f'{h} h' if h else f'{m} min')
        return f'Cante del tema · {minutos} minutos'

    def portada(self):
        img = Image.new('RGB', (ANCHO, ALTO), MORADO)
        d = ImageDraw.Draw(img)
        d.text((ANCHO / 2, 330), self.tema.etiqueta, font=F_TITULO, fill='white', anchor='mm')
        y = 450
        for l in partir(self.titulo, F_SUBTITULO, 1500):
            d.text((ANCHO / 2, y), l, font=F_SUBTITULO, fill=(236, 226, 246), anchor='mm')
            y += 60
        d.text((ANCHO / 2, ALTO - 150), self.rotulo_duracion(), font=F_BARRA_L, fill=SALVIA, anchor='mm')
        d.text((ANCHO / 2, ALTO - 100), 'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es', font=F_UI,
               fill=(220, 210, 230), anchor='mm')
        d.text((ANCHO / 2, ALTO - 42), self.licencia, font=F_MARCO, fill=(176, 150, 200), anchor='mm')
        return img

    def cierre(self):
        img = Image.new('RGB', (ANCHO, ALTO), MORADO)
        d = ImageDraw.Draw(img)
        d.text((ANCHO / 2, 400), 'Fin de la exposición', font=F_TITULO, fill='white', anchor='mm')
        d.text((ANCHO / 2, 500), f'{self.tema.etiqueta}: {self.corto}', font=F_SUBTITULO,
               fill=(236, 226, 246), anchor='mm')
        d.text((ANCHO / 2, 640), 'La guía completa (PDF, web y Word), su resumen y el temario, en la app y en'
               if self.tema.es_dictamen else 'El tema completo (web, PDF y Word) y el resto del temario en',
               font=F_UI, fill=(220, 210, 230), anchor='mm')
        d.text((ANCHO / 2, 690), 'victorgutierrezmarcos.es', font=F_BARRA, fill=SALVIA, anchor='mm')
        d.text((ANCHO / 2, ALTO - 42), self.licencia + (' · solo para tu estudio personal; no se autoriza su incorporación a otras plataformas'
               if self.exclusivo else ' · puedes compartirlo citando al autor, sin fines comerciales y sin modificarlo'),
               font=F_MARCO, fill=(176, 150, 200), anchor='mm')
        return img


def con_tarjeta(cuerpo_img, tarjeta, alfa):
    """Oscurece el cuerpo y pone encima la tarjeta del esquema (alfa: 0-1)."""
    oscuro = Image.blend(cuerpo_img, Image.new('RGB', cuerpo_img.size, MORADO_OSCURO), 0.55 * alfa)
    if alfa <= 0:
        return oscuro
    t = tarjeta
    if alfa < 1:
        t = tarjeta.copy()
        t.putalpha(ImageChops.multiply(tarjeta.getchannel('A'), Image.new('L', tarjeta.size, int(255 * alfa))))
    x = (ANCHO - t.width) // 2
    y = CAB + max(20, (ALTO - CAB - t.height) // 2)
    oscuro.paste(t, (x, y), t)
    return oscuro


def fondo_pizarra(dice, apunte):
    """Todo lo que rodea a la pizarra: el marco (con su rótulo) y la franja de abajo,
    con lo que se dice sin escribirlo y el apunte didáctico."""
    img = Image.new('RGB', (ANCHO, ALTO), FONDO)
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([PZ_X0 - 16, PZ_Y0 - 30, PZ_X1 + 16, PZ_Y1 + 16], radius=12, fill=MARCO)
    d.text((PZ_X0 + 4, PZ_Y0 - 27), 'PIZARRA  ·  lo que escribiría el opositor', font=F_MARCO, fill=(88, 92, 100))
    pintar_franja(img, dice, apunte)
    return img


def pintar_franja(img, dice, apunte):
    d = ImageDraw.Draw(img)
    filas = [(t, e) for t, e in ((dice, 'dice'), (apunte, 'apunte')) if t]
    if not filas:
        return
    alto = (ALTO - 12 - FRANJA_Y) / len(filas)
    y = FRANJA_Y
    for texto, tipo in filas:
        if tipo == 'dice':
            fondo, borde, etiqueta, color_e, fnt, tinta = PAPEL, (214, 212, 205), 'SE DICE', MORADO, F_FRANJA, TINTA
        else:
            fondo, borde, etiqueta, color_e, fnt, tinta = SALVIA, SALVIA, 'APUNTE', (60, 90, 50), F_FRANJA_I, (40, 60, 35)
        d.rounded_rectangle([28, y + 3, ANCHO - 28, y + alto - 3], radius=10, fill=fondo, outline=borde, width=2)
        d.text((50, y + alto / 2), etiqueta, font=F_ETIQUETA, fill=color_e, anchor='lm')
        lineas = partir(texto, fnt, ANCHO - 230)
        if len(filas) == 1 and len(lineas) > 1:
            escribir(d, (170, y + alto / 2 - 18), lineas[0], fnt, tinta, 'lm')
            escribir(d, (170, y + alto / 2 + 18), recortar(d, ' '.join(lineas[1:]), fnt, ANCHO - 230), fnt, tinta, 'lm')
        else:
            escribir(d, (170, y + alto / 2), recortar(d, texto, fnt, ANCHO - 230), fnt, tinta, 'lm')
        y += alto


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
            escribir(d, (x0 + 30, y), texto, F_GUION_N, color)
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
                escribir(d, (xi + 32, y), fila, F_GUION, TINTA)
                y += 48
            y += 6



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


PAUSA_RE = re.compile(r'\s*\[pausa(?:\s+(\d+))?\]\s*')


def sin_pausas(texto):
    """Lo que se dice sin las marcas de pausa (para subtítulos, avisos y recuentos)."""
    return re.sub(r'\s{2,}', ' ', PAUSA_RE.sub(' ', texto)).strip()


def trozos_pausa(texto):
    """[(trozo, silencio después en s)]: «[pausa]» son 0,5 s y «[pausa 800]», 800 ms (2 s como máximo)."""
    trozos, ini = [], 0
    for m in PAUSA_RE.finditer(texto):
        if texto[ini:m.start()].strip():
            trozos.append([texto[ini:m.start()].strip(), 0.0])
        if trozos:
            trozos[-1][1] = min(2.0, trozos[-1][1] + (int(m.group(1)) / 1000 if m.group(1) else 0.5))
        ini = m.end()
    if texto[ini:].strip():
        trozos.append([texto[ini:].strip(), 0.0])
    return [tuple(t) for t in trozos]


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
    ap.add_argument('--fotogramas', help='en vez del vídeo, guarda los fotogramas de esos instantes '
                                         '(p. ej. 1:30,4:10) en _trabajo/video/fotogramas/')
    ap.add_argument('--ffmpeg', default=None)
    ap.add_argument('--voz', help='JSON que cambia la voz de escenas.yaml (p. ej. otro motor para todos los temas, '
                                  'desde voz-todos.py): {"motor_tts": "voxcpm2"}')
    args = ap.parse_args()
    tema = Tema(args.tema)
    import imageio_ffmpeg
    ffmpeg = args.ffmpeg or imageio_ffmpeg.get_ffmpeg_exe()

    guion = yaml.safe_load(open(args.escenas or os.path.join(tema.dir, 'video', 'escenas.yaml'), encoding='utf-8'))
    voz = dict(guion.get('voz') or {}) if isinstance(guion.get('voz'), dict) else {}
    if args.voz:
        voz.update(json.loads(args.voz))
    if voz.get('motor', 'edge') == 'edge':
        # Solo el motor edge toma los valores por defecto (su velocidad es «+15%»;
        # en xtts y voicestudio es un número y no debe colarse)
        voz = {**VOZ_DEFECTO, **voz}
    # Formato «slides» (la guía del dictamen): pasos dentro de cada slide; se aplanan para la voz
    slides = guion.get('formato') == 'slides'
    for aviso in (comprobar_slides(guion) if slides else comprobar_guion(guion, tema)):
        print('AVISO:', aviso, flush=True)
    if slides:
        preparar_slides(guion)
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
    # «[pausa]» o «[pausa 800]» (ms) en lo que se dice: silencio para dar énfasis o separar ideas
    lectura_titulo = guion.get('lectura_titulo') or (titulo if tema.es_dictamen else f'Tema {tema.codigo.replace(".", " ")}. {titulo}')
    dichos = [lectura_titulo] + [p.get('di', '').strip() for e in escenas for p in e.get('pasos', [])]
    if args.borrador:
        duraciones = [max(1.0, len(sin_pausas(t).split()) / 2.75) + sum(s for _, s in trozos_pausa(t)) if t else 0
                      for t in dichos]
        audios = [None] * len(dichos)
    else:
        trozos = [trozos_pausa(t) if t else [] for t in dichos]
        textos = [pronunciar(x, diccionario) for tr in trozos for x, _ in tr]
        rutas = iter(sintetizar_todos(textos, voz, carpeta, ffmpeg))
        audios = []
        for t, tr in zip(dichos, trozos):
            if not t:
                audios.append(None)
                continue
            piezas = [(next(rutas), s) for _, s in tr]
            if len(piezas) == 1 and not piezas[0][1]:
                audios.append(piezas[0][0])
                continue
            junta = os.path.join(carpeta, f'voz-junta-{huella(*[a for a, _ in piezas], *[s for _, s in piezas])}.pcm')
            if not os.path.exists(junta):
                open(junta, 'wb').write(b''.join(leer_pcm(a) + silencio(s) for a, s in piezas))
            audios.append(junta)
        duraciones = [os.path.getsize(a) / 2 / MUESTREO if a else 0 for a in audios]

    # 2. Plan de la pizarra y línea de tiempo -------------------------------------------------
    # La voz no se para: cada paso dura lo que tarda en decirse y lo que dibuja tiene que
    # escribirse dentro de ese tiempo (la mano acelera hasta ACELERACION_MAX; si no basta,
    # se avisa y se corrige el guion). Así lo que se escribe es siempre lo que se dice.
    def cronologia(minimos):
        pasos = []           # escena, paso, inicio y duración (naturales), índice de audio
        t = duraciones[0] + PAUSA_BLOQUE
        portada_fin = t
        k = 1
        for i, e in enumerate(escenas):
            for p in e.get('pasos', []):
                t += p.get('_pausa_antes', 0.0)       # solo en las slides (cambio de slide)
                dur = duraciones[k] if dichos[k] else 1.2
                hueco = max(dur, minimos.get(len(pasos), 0.0))
                pasos.append({'escena': i, 'paso': p, 'inicio': t, 'dur': dur, 'hueco': hueco, 'audio': k})
                t += hueco + PAUSA_PASO
                k += 1
            if i + 1 < len(escenas):
                if escenas[i + 1]['bloque'] != e['bloque']:
                    pausa = PAUSA_BLOQUE
                elif pantallas.cambia_apartado(i, i + 1):
                    pausa = PAUSA_APARTADO
                else:
                    pausa = PAUSA_ESCENA
            else:
                pausa = PAUSA_BLOQUE
            t += pausa - PAUSA_PASO
        return pasos, t, portada_fin

    def planificar(pasos, contenido_fin):
        pizarra = Pizarra(tema, carpeta)
        ops, pendientes, tarjetas, avisos = [], [], [], pizarra.avisos
        subtitulos, capitulos = [], [(0.0, 'Título')]

        def barrera(tb):
            for op in pendientes:
                op['barrera'] = tb
            pendientes.clear()

        escena_actual, estado_guion, dice, apunte, modo_previo = -1, None, None, None, None
        for n, p in enumerate(pasos):
            e = escenas[p['escena']]
            paso = p['paso']
            t0 = p['inicio']
            modo = e.get('modo', 'pizarra')
            listo = t0
            nueva = p['escena'] != escena_actual
            p['brillo_desde'] = None
            if nueva:
                escena_actual = p['escena']
                capitulos.append((t0, e.get('titulo') or e['bloque']))
                dice = apunte = None
                if n > 0 and pantallas.cambia_apartado(pasos[n - 1]['escena'], p['escena']):
                    previo = pasos[n - 1]
                    c0 = previo['inicio'] + previo['dur'] + 0.15
                    c1 = max(c0 + TARJETA_MIN, t0 + 0.6)
                    tarjetas.append({'c0': c0, 'c1': c1, 'escena': p['escena'], 'previa': previo['escena']})
                    barrera(c0 - 0.1)
                    listo = c1
                    p['brillo_desde'] = t0
                    p['brillo_bloque'] = escenas[previo['escena']]['bloque'] != e['bloque']
                if modo == 'guion':
                    estructura = e.get('estructura') or []
                    estado_guion = {'partes': [{'nombre': x, 'estado': 'pendiente', 'lineas': []} for x in estructura],
                                    'ultima': None}
                    if not estructura:
                        estado_guion['partes'].append({'nombre': None, 'estado': 'actual', 'lineas': []})
            avisos_antes = len(avisos)
            if not str(paso.get('di') or '').strip():
                avisos.append(f'{mmss(t0)} (escena {p["escena"] + 1}): paso sin «di»: la voz no se para nunca')
            elif len(re.findall(r'\[pausa', paso['di'])) > 2:
                avisos.append(f'{mmss(t0)}: más de dos [pausa] en un paso (una o dos como mucho)')
            if paso.get('di'):
                fr = frases(sin_pausas(paso['di']))
                largo = sum(len(f) for f in fr) or 1
                ti = t0
                for f in fr:
                    tf = ti + p['dur'] * len(f) / largo
                    subtitulos.append((ti, tf, f))
                    ti = tf
            # Coordinación voz-pizarra: lo del paso anterior tiene que estar escrito al empezar este
            barrera(t0)
            p['modo'] = modo
            p['fundido'] = n > 0 and (modo == 'guion' or modo_previo == 'guion')
            if modo == 'guion':
                barrera(t0)
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
                    avisar_glifos(str(linea).lstrip('> '), F_GUION, 'el guion', avisos)
                    destino['lineas'].append(str(linea))
                    estado_guion['ultima'] = str(linea)
                p['guion'] = copy.deepcopy(estado_guion)
                p['parte'] = next((x['nombre'] for x in estado_guion['partes'] if x['estado'] == 'actual'), None)
            else:
                p['parte'] = None
                if p['fundido']:
                    listo = max(listo, t0 + FUNDIDO)
                if paso.get('guion') is not None:
                    g = paso.get('guion')
                    dice = ' · '.join(map(str, g)) if isinstance(g, list) else (str(g) if g else None)
                if paso.get('apunte') is not None:
                    apunte = paso.get('apunte') or None
                p['dice'], p['apunte'] = dice, apunte
                if paso.get('guion') is not None and dice:
                    avisar_glifos(dice, F_FRANJA, '«Se dice»', avisos)
                if paso.get('apunte') is not None and apunte:
                    avisar_glifos(apunte, F_FRANJA_I, '«Apunte»', avisos)
                nuevos = []
                spec = paso.get('rejilla', e.get('rejilla') if nueva else None)
                lineas = paso.get('lineas', e.get('lineas') if nueva else None)
                conservar = paso.get('conservar', e.get('conservar') if nueva and 'rejilla' not in paso else None)
                if spec is not None and Rejilla(spec, lineas).clave != pizarra.rejilla.clave or paso.get('borrar'):
                    barrera(t0)
                if 'rejilla' in paso and Rejilla(spec, lineas).clave == pizarra.rejilla.clave and not paso.get('borrar'):
                    avisos.append(f'{mmss(t0)}: la rejilla del paso es la misma que había, así que no se borra nada '
                                  '(para limpiar la pizarra, borrar: true)')
                if spec is not None:
                    nuevos += pizarra.cambiar_rejilla(spec, conservar, lineas)
                if paso.get('borrar'):
                    nuevos += pizarra.borrar(paso['borrar'], conservar)
                acciones = paso.get('pizarra') or []
                if isinstance(acciones, dict):
                    acciones = [acciones]
                for accion in acciones:
                    nuevos.append(pizarra.anadir(accion))
                apoyos = paso.get('apoyo') or []
                for accion in ([apoyos] if isinstance(apoyos, dict) else apoyos):
                    nuevos += pizarra.anadir({**accion, '_apoyo': True})
                for op in nuevos:
                    op['listo'], op['paso'], op['dicho'] = listo, n, sin_pausas(paso.get('di') or '')
                    ops.append(op)
                    pendientes.append(op)
            # Los avisos de la pizarra (se llena, se sale, no cabe…) dicen en qué paso pasa
            for j in range(avisos_antes, len(avisos)):
                if not re.match(r'\d+:\d\d', avisos[j]):
                    avisos[j] = f'{mmss(t0)} (escena {p["escena"] + 1}): {avisos[j]}'
            modo_previo = modo
        barrera(contenido_fin - 0.2)
        return ops, tarjetas, avisos, subtitulos, capitulos

    pasos, natural, portada_fin = cronologia({})
    factor = natural / (total - CIERRE)
    print(f'Narración natural: {mmss(natural)}; ritmo ajustado ×{factor:.3f} para durar {mmss(total)}', flush=True)
    ritmo_fuera = not RITMO_MIN <= factor <= RITMO_MAX
    if ritmo_fuera:
        print(f'  AVISO: el guion es {"largo" if factor > 1 else "corto"} para {mmss(total)} (el ritmo tiene que quedar '
              f'entre ×{RITMO_MIN:.2f} y ×{RITMO_MAX:.2f}): conviene {"recortar" if factor > 1 else "alargar"} unas '
              f'{abs(int((natural - total + CIERRE) * 2.6))} palabras', flush=True)
    if args.medir:
        palabras = sum(len(re.findall(r'\w+', sin_pausas(d))) for d in dichos)
        objetivo = int(palabras / factor)
        print(f'MEDIDA: {palabras} palabras; narración natural {mmss(natural)}; ritmo ×{factor:.3f}. '
              f'Para ritmo ×1,00 harían falta unas {objetivo} palabras ({objetivo - palabras:+d}).')
        # Y si a la mano le da tiempo a escribir lo de cada paso mientras se dice
        prueba = copy.deepcopy(pasos)
        for p in prueba:
            p['inicio'] /= factor
            p['dur'] /= factor
            p['hueco'] /= factor
        errores_m = []
        if slides:
            plan_m = planificar_slides(tema, carpeta, escenas, pantallas, prueba, total - CIERRE)
            avisos_m, errores_m = plan_m['avisos'], plan_m['errores']
            # Cuándo empieza cada slide (para revisar fotogramas sueltos con --fotogramas)
            json.dump(plan_m['notas'], open(os.path.join(carpeta, 'slides-medida.json'), 'w', encoding='utf-8'),
                      ensure_ascii=False, indent=1)
        else:
            ops_m, _, avisos_m, _, _ = planificar(prueba, total - CIERRE)
            programar(ops_m, avisos_m)
        for aviso in dict.fromkeys(avisos_m):
            print('AVISO:', aviso)
        print(f'{len(set(avisos_m))} avisos de pizarra')
        if slides:
            for error in errores_m:
                print('ERROR:', error)
            print(f'{len(errores_m)} errores de maquetación (texto que no cabe o que se cortaría)')
            if errores_m:
                sys.exit(4)
        if ritmo_fuera:
            sys.exit(3)
        return
    escala = 1 / factor
    portada_fin *= escala
    for p in pasos:
        p['inicio'] *= escala
        p['dur'] *= escala
        p['hueco'] *= escala
    contenido_fin = total - CIERRE

    # 3. Audio completo ---------------------------------------------------------------------
    audio_wav = os.path.join(carpeta, 'audio-completo.wav')
    if not args.borrador:
        crudo = bytearray()
        crudo += leer_pcm(audios[0]) + silencio(PAUSA_BLOQUE)
        for n, p in enumerate(pasos):
            if p['audio'] and audios[p['audio']]:
                crudo += leer_pcm(audios[p['audio']])
            else:
                crudo += silencio(1.2)
            if n + 1 == len(pasos):
                crudo += silencio(PAUSA_BLOQUE)
            else:
                crudo += silencio(max(0.0, (pasos[n + 1]['inicio'] - p['inicio']) * factor - p['dur'] * factor))
        crudo_ruta = os.path.join(carpeta, 'audio-natural.pcm')
        open(crudo_ruta, 'wb').write(crudo)
        subprocess.run([ffmpeg, '-y', '-loglevel', 'error', '-f', 's16le', '-ar', str(MUESTREO), '-ac', '1',
                        '-i', crudo_ruta, '-af', f'atempo={factor:.6f},apad', '-t', f'{total:.3f}',
                        '-ar', str(MUESTREO), audio_wav], check=True)

    # 4. Plan definitivo de la pizarra --------------------------------------------------------
    if slides:
        plan = planificar_slides(tema, carpeta, escenas, pantallas, pasos, contenido_fin)
        if plan['errores']:
            for error in plan['errores']:
                print('ERROR:', error)
            sys.exit(f'{len(plan["errores"])} errores de maquetación: no se monta un vídeo con texto cortado')
        ops, tarjetas, avisos = [], plan['tarjetas'], plan['avisos']
        subtitulos, capitulos = plan['subtitulos'], plan['capitulos']
    else:
        ops, tarjetas, avisos, subtitulos, capitulos = planificar(pasos, contenido_fin)
        programar(ops, avisos)
    for p in pasos:
        p['fin'] = None
    for a, b in zip(pasos, pasos[1:]):
        a['fin'] = b['inicio']
    pasos[-1]['fin'] = contenido_fin

    # 5. Fotogramas -------------------------------------------------------------------------
    tramo = (0, total)
    if args.tramo:
        a, b = args.tramo.split('-')
        tramo = tuple(sum(float(x) * 60 ** i for i, x in enumerate(reversed(v.split(':')))) for v in (a, b))
    instantes = None
    if args.fotogramas:
        instantes = sorted(sum(float(x) * 60 ** i for i, x in enumerate(reversed(v.strip().split(':'))))
                           for v in args.fotogramas.split(','))
        tramo = (0, instantes[-1] + 0.1)
        carpeta_f = os.path.join(carpeta, 'fotogramas')
        os.makedirs(carpeta_f, exist_ok=True)

    os.makedirs(SALIDA, exist_ok=True)
    sufijo = '-borrador' if args.borrador else ''
    if args.tramo or args.escenas:
        sufijo += '-prueba'
    mp4 = os.path.join(SALIDA, f'{tema.archivo}{sufijo}.mp4')
    proceso = None
    if not instantes:
        entradas = ['-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{ANCHO}x{ALTO}', '-r', str(FPS), '-i', '-']
        if not args.borrador:
            entradas += ['-ss', f'{tramo[0]:.3f}', '-t', f'{tramo[1] - tramo[0]:.3f}', '-i', audio_wav]
        salida_ff = ['-c:v', 'libx264', '-preset', 'veryfast', '-crf', '21', '-pix_fmt', 'yuv420p']
        if not args.borrador:
            salida_ff += ['-c:a', 'aac', '-b:a', '160k', '-map', '0:v', '-map', '1:a']
        proceso = subprocess.Popen([ffmpeg, '-y', '-loglevel', 'error', *entradas, *salida_ff,
                                    '-t', f'{tramo[1] - tramo[0]:.3f}', '-movflags', '+faststart', mp4],
                                   stdin=subprocess.PIPE)

    if slides:
        fotogramas_slides(plan, pasos, escenas, pantallas, total, portada_fin, contenido_fin, tramo, instantes,
                          proceso, carpeta_f if instantes else None)
    else:
        tablero = Tablero(ops)
        primer_paso = {}
        for q in pasos:
            primer_paso.setdefault(q['escena'], q)
        portada = pantallas.portada().tobytes()
        cierre = pantallas.cierre().tobytes()
        cache_guion, cache_fondo, cache_tarjeta = {}, {}, {}
        cabecera_clave, cabecera_bytes = None, None
        cuerpo_clave, cuerpo_img, cuerpo_bytes = None, None, None
        ultimo_de_paso = {}            # n → última imagen del cuerpo mostrada en ese paso
        n = 0
        marcos = int(round(total * FPS))
        siguiente_instante = 0
        for marco in range(int(round(tramo[0] * FPS)) if not instantes else 0, min(marcos, int(math.ceil(tramo[1] * FPS)))):
            t = marco / FPS
            if instantes:
                if siguiente_instante >= len(instantes):
                    break
                # Solo se pintan los instantes pedidos (el tablero avanza solo)
                if t + 1e-9 < instantes[siguiente_instante] - 0.5 / FPS:
                    continue
            if t < portada_fin or t >= contenido_fin:
                datos = portada if t < portada_fin else cierre
                if instantes:
                    Image.frombytes('RGB', (ANCHO, ALTO), datos).save(
                        os.path.join(carpeta_f, f"t{t:07.2f}.png"))
                    siguiente_instante += 1
                else:
                    proceso.stdin.write(datos)
                continue
            while n + 1 < len(pasos) and pasos[n + 1]['inicio'] <= t:
                n += 1
            p = pasos[n]
            if t < p['inicio']:          # pausa tras la portada
                p = pasos[0]
            # Cuerpo
            if p['modo'] == 'guion':
                if n not in cache_guion:
                    cache_guion.clear()
                    img = Image.new('RGB', (ANCHO, ALTO), PAPEL)
                    pintar_guion(img, escenas[p['escena']], p['guion'])
                    cache_guion[n] = img
                img, clave = cache_guion[n], ('g', n)
            else:
                tab, ck = tablero.imagen(t)
                clave_f = (p['dice'], p['apunte'])
                if clave_f not in cache_fondo:
                    cache_fondo.clear()
                    cache_fondo[clave_f] = fondo_pizarra(*clave_f)
                clave = ('p', clave_f, ck)
                if clave == cuerpo_clave:
                    img = cuerpo_img
                else:
                    img = cache_fondo[clave_f].copy()
                    img.paste(tab, (PZ_X0, PZ_Y0))
            if p['fundido'] and t - p['inicio'] < FUNDIDO and (n - 1) in ultimo_de_paso:
                u = (t - p['inicio']) / FUNDIDO
                img = Image.blend(ultimo_de_paso[n - 1], img, u)
                clave = clave + ('f', marco)
            ultimo_de_paso = {n - 1: ultimo_de_paso.get(n - 1), n: img} if (n - 1) in ultimo_de_paso else {n: img}
            tarjeta = next((c for c in tarjetas if c['c0'] <= t < c['c1']), None)
            if tarjeta:
                alfa = min(1.0, (t - tarjeta['c0']) / 0.3, (tarjeta['c1'] - t) / 0.3)
                u = min(1.0, max(0.0, (t - tarjeta['c0'] - 0.25) / 0.7))
                ct = (tarjeta['escena'], round(u * 20))
                if ct not in cache_tarjeta:
                    if len(cache_tarjeta) > 40:
                        cache_tarjeta.clear()
                    cache_tarjeta[ct] = pantallas.tarjeta(tarjeta['escena'], tarjeta['previa'], u)
                img = con_tarjeta(img, cache_tarjeta[ct], alfa)
                clave = clave + ('t', marco)
            if clave != cuerpo_clave:
                cuerpo_clave, cuerpo_img = clave, img
                cuerpo_bytes = img.crop((0, CAB, ANCHO, ALTO)).tobytes()
            # Cabecera
            escena_cab = p['escena']
            brillo, brillo_bloque = 0.0, 0.0
            primero = primer_paso[escena_cab]
            if primero.get('brillo_desde') is not None and 0 <= t - primero['brillo_desde'] < 2.0:
                brillo = round(1 - (t - primero['brillo_desde']) / 2.0, 1)
                brillo_bloque = brillo if primero.get('brillo_bloque') else 0.0
            cc = (escena_cab, int(t), p['parte'], brillo, brillo_bloque)
            if cc != cabecera_clave:
                cabecera_clave = cc
                cabecera_bytes = pantallas.cabecera(escena_cab, int(t), total, p['parte'], brillo, brillo_bloque).tobytes()
            if instantes:
                Image.frombytes('RGB', (ANCHO, ALTO), cabecera_bytes + cuerpo_bytes).save(
                    os.path.join(carpeta_f, f"t{t:07.2f}.png"))
                siguiente_instante += 1
            else:
                proceso.stdin.write(cabecera_bytes + cuerpo_bytes)
            if marco % (FPS * 60) == 0:
                print(f'  {mmss(t)} · {escenas[p["escena"]].get("titulo") or escenas[p["escena"]]["bloque"]}', flush=True)

    if proceso:
        proceso.stdin.close()
        proceso.wait()
        if proceso.returncode != 0:
            raise RuntimeError('ffmpeg falló al montar el vídeo')
    for aviso in dict.fromkeys(avisos):
        print('AVISO:', aviso)
    if not (args.tramo or args.escenas or instantes):
        # Solo el montaje completo deja el informe (un tramo o unos fotogramas no lo pisan)
        json.dump({'factor_ritmo': round(factor, 3), 'narracion_natural': round(natural, 1), 'borrador': bool(args.borrador),
                   'avisos': list(dict.fromkeys(avisos))},
                  open(os.path.join(carpeta, 'informe-video.json'), 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    if instantes:
        print(f'Fotogramas en {carpeta_f}')
        return

    base_salida = os.path.join(SALIDA, f'{tema.archivo}{sufijo}')
    if slides:
        # Las notas de cada slide (lo que dice la voz), con su inicio y su sitio en la guía: lo
        # que haría falta para sacar luego una presentación con notas
        json.dump(plan['notas'], open(base_salida + '-notas.json', 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
    with open(base_salida + '.srt', 'w', encoding='utf-8') as f:
        f.write(f'1\n{srt_tiempo(0)} --> {srt_tiempo(portada_fin - 0.2)}\n{lectura_titulo}\n\n')
        for i, (a, b, texto) in enumerate(subtitulos, 2):
            f.write(f'{i}\n{srt_tiempo(a)} --> {srt_tiempo(b)}\n{texto}\n\n')
    with open(base_salida + '-youtube.txt', 'w', encoding='utf-8') as f:
        # YouTube admite 100 caracteres en el título: si no cabe, solo hasta el primer punto
        if tema.es_dictamen:
            titulo_yt = f'{titulo} | Clase en vídeo (Oposición TCEE)'
            f.write(f'{titulo_yt[:100]}\n\n{titulo}\n\n')
            f.write(f'Clase en vídeo de la guía para el dictamen de coyuntura económica (primer ejercicio de la '
                    f'oposición a Técnico Comercial y Economista del Estado), {pantallas.rotulo_duracion().split(" · ")[1]}, '
                    f'{"con diapositivas y pizarra" if slides else "con el guion y la pizarra"}.\n\nLa guía completa, en la app Oposición TCEE: '
                    f'https://www.victorgutierrezmarcos.es/app/\n\nCapítulos:\n')
        else:
            titulo_yt = f'Tema {tema.codigo}: {titulo} | Cante (Oposición TCEE)'
            if len(titulo_yt) > 100:
                titulo_yt = f'Tema {tema.codigo}: {titulo.split(". ")[0].rstrip(".")} | Cante TCEE'
            f.write(f'{titulo_yt[:100]}\n\n{titulo}\n\n')
            f.write(f'Exposición oral (cante) del tema {tema.codigo} de la oposición a Técnico Comercial y Economista '
                    f'del Estado, en {int(round(total / 60))} minutos, con el guion y la pizarra.\n\n'
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
                'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es\n\n'
                f'{licencia_larga(anio_tema(tema))}\n')
        # Al subirlo: «licencia estándar de YouTube» (YouTube no ofrece CC BY-NC-ND; la que
        # rige es la de la descripción). Esta nota no es para la descripción.
        f.write('\n[Al subirlo a YouTube: Licencia → «Licencia estándar de YouTube»; '
                'no copiar esta línea en la descripción]\n')
    print(f'Vídeo: {mp4} ({mmss(total)}; {len(pasos)} pasos)')
    if ritmo_fuera:
        print(f'El ritmo ×{factor:.3f} queda fuera de ×{RITMO_MIN:.2f}–×{RITMO_MAX:.2f}: hay que ajustar el guion')
        sys.exit(3)


# --- Formato «slides»: la guía del dictamen (1D01) -----------------------------------------------
# Decidido por Víctor el 27/10/2026: el vídeo de la guía es una sucesión de slides con libertad
# total para usar la pizarra (slide entera, pizarra entera, slide con un panel de pizarra al lado o
# anotaciones a mano encima de la slide). Las slides llevan lo esencial; la explicación es la voz
# («di», que también es la nota de cada slide y va al .srt). Cada slide dice en una esquina dónde
# está en la guía («§ I.3 · pág. 10», páginas del .aux). Ningún texto se corta: si algo no cabe,
# se reduce la letra hasta un mínimo legible y, si aun así no cabe, es un error con minuto, escena
# y texto (también con --medir). Los cantes (formato por defecto) no usan nada de esta sección.

ORO = (176, 141, 58)
CUERPO_H = ALTO - CAB
SL_X0, SL_X1 = 56, ANCHO - 56
SL_Y0, SL_Y1 = 106, CUERPO_H - 52           # contenido de la slide (coordenadas del cuerpo)
SL_HUECO = 24                               # entre elementos
SL_ESCALAS = (1.0, 0.95, 0.9, 0.85, 0.8)    # si no cabe se reduce la letra, hasta el 80 % (mínimo legible)
GRAFICO_ESCALA_MIN = 1.9                    # píxeles por punto del PDF: por debajo, los rótulos no se leen
GRAFICO_ALTO_MIN = 230
PAUSA_SLIDE = 0.3                           # pausa (además de la de paso) al cambiar de slide
NOTA_FONDO = (247, 243, 231)
EJEMPLO_FONDO = (240, 239, 236)
FAMILIAS = {'pala': {'n': 'pala.ttf', 'b': 'palab.ttf', 'i': 'palai.ttf', 'bi': 'palabi.ttf'},
            'segoe': {'n': 'segoeui.ttf', 'b': 'segoeuib.ttf', 'i': 'segoeuii.ttf', 'bi': 'segoeuiz.ttf'},
            'mano': {'n': 'segoeprb.ttf', 'b': 'segoeprb.ttf', 'i': 'segoeprb.ttf', 'bi': 'segoeprb.ttf'}}
CAJAS = {   # tipo: (fondo, raya y título, título por defecto, estilo del texto); como los cuadros de la guía
    'pregunta': (MORADO_PALIDO, MORADO, 'Qué hay que contestar', 'n'),
    'clave': (MORADO_PALIDO, MORADO, 'La idea clave', 'n'),
    'nota': (NOTA_FONDO, (150, 115, 35), 'Nota al opositor', 'n'),
    'ejemplo': (EJEMPLO_FONDO, (105, 102, 110), 'Ejemplo de redacción', 'i'),
    'umbral': (SALVIA, (64, 98, 52), 'Umbrales', 'n'),
    'anexo': (APOYO_FONDO, (70, 95, 140), 'Del anexo', 'n'),
}
_FS = {}


def fs(nombre, tam):
    clave = (nombre, max(8, int(round(tam))))
    if clave not in _FS:
        _FS[clave] = fuente(nombre, clave[1])
    return _FS[clave]


class ErrorSlides(Exception):
    pass


def _estilos(texto):
    """[(trozo, estilo)] de un texto con **negrita** y *cursiva* (estilos 'n', 'b', 'i')."""
    trozos = []
    for t in re.split(r'(\*\*[^*]+\*\*|(?<![\w*])\*[^*\s][^*]*\*(?![\w*]))', str(texto)):
        if not t:
            continue
        if len(t) > 4 and t.startswith('**') and t.endswith('**'):
            trozos.append((t[2:-2], 'b'))
        elif len(t) > 2 and t.startswith('*') and t.endswith('*'):
            trozos.append((t[1:-1], 'i'))
        else:
            trozos.append((t, 'n'))
    return trozos


class Parrafo:
    """Texto con estilos partido en renglones para un ancho. No recorta nunca: lo que no cabe
    (una palabra más ancha que la caja o un carácter sin fuente) queda en «problemas»."""

    def __init__(self, texto, tam, ancho, familia='pala', base='n', interlinea=1.28):
        self.texto, self.tam, self.ancho = str(texto), tam, ancho
        self.alto_linea = int(round(tam * interlinea))
        self.problemas = []
        fam = FAMILIAS[familia]
        tokens, espacio_pendiente = [], False
        for trozo, est in _estilos(texto):
            est = base if est == 'n' else ('bi' if base == 'i' and est == 'b' else est)
            f = fs(fam[est], tam)
            for m in re.finditer(r'\s+|\S+', trozo):
                if m.group().isspace():
                    espacio_pendiente = True
                    continue
                if tokens and not espacio_pendiente:
                    tokens[-1][0].append((m.group(), f))
                else:
                    tokens.append([[(m.group(), f)]])
                espacio_pendiente = False
                faltan = sin_glifo(m.group(), f)
                if faltan:
                    self.problemas.append(f'caracteres sin fuente {" ".join(faltan)}')
        espacio = ancho_texto(' ', fs(fam['n'], tam))
        self.lineas, self.anchos, x = [[]], [0], 0
        for (grupo,) in tokens:
            w = sum(ancho_texto(t, f) for t, f in grupo)
            if w > ancho + 0.5:
                self.problemas.append(f'«{"".join(t for t, _ in grupo)}» es más ancho que la caja')
            if self.lineas[-1] and x + espacio + w > ancho:
                self.lineas.append([])
                self.anchos.append(0)
                x = 0
            x0 = x + (espacio if self.lineas[-1] else 0)
            for t, f in grupo:
                self.lineas[-1].append((x0, t, f))
                x0 += ancho_texto(t, f)
            x = x0
            self.anchos[-1] = x
        self.alto = self.alto_linea * len(self.lineas)
        self.ancho_usado = max(self.anchos) if self.anchos else 0

    def pintar(self, d, x, y, color, centrado=False):
        for i, linea in enumerate(self.lineas):
            dx = (self.ancho - self.anchos[i]) / 2 if centrado else 0
            for xt, t, f in linea:
                escribir(d, (x + dx + xt, y + i * self.alto_linea), t, f, color)


def _rgba(w, h):
    return Image.new('RGBA', (max(1, int(round(w))), max(1, int(round(h)))), (0, 0, 0, 0))


class Elemento:
    """Algo que se enseña en una slide (aparece de golpe, como en una presentación)."""
    flexible = False
    alinear = 'izquierda'

    def __init__(self, spec, ctx):
        self.spec, self.ctx = spec, ctx
        self.id = spec.get('id')
        self.col = int(spec.get('col', 1))
        self.x = self.y = self.w = self.h = 0
        self.problemas = []
        self.subcajas = {}

    def texto(self):
        return ''

    def ocupado(self):
        """Las cajas (en el cuerpo) donde hay algo pintado: lo que una anotación no puede tapar."""
        return [(self.x, self.y, self.x + self.w, self.y + self.h)]

    def caja(self, sub=None):
        """Caja (en el cuerpo) del elemento o de una parte: ('fila', 2), ('celda', (2, 1)), ('vineta', 3)."""
        if sub is None:
            return (self.x, self.y, self.x + self.w, self.y + self.h)
        if sub not in self.subcajas:
            raise ErrorSlides(f'«{self.id}» no tiene {sub[0]} {sub[1]}')
        x0, y0, x1, y1 = self.subcajas[sub]
        return (self.x + x0, self.y + y0, self.x + x1, self.y + y1)


class ElVinetas(Elemento):
    def texto(self):
        return ' · '.join(map(str, self.spec['vinetas']))

    def medir(self, ancho, s):
        self.items, y, self.subcajas = [], 0, {}
        tam0 = float(self.spec.get('tam', 1.0)) * 34 * s
        for k, it in enumerate(self.spec['vinetas'] if isinstance(self.spec['vinetas'], list) else [self.spec['vinetas']], 1):
            it = str(it)
            nivel = len(it) - len(it.lstrip('>'))
            limpio = it.lstrip('> ').strip()
            tam = tam0 * (0.88 if nivel else 1.0)
            sangria = 46 * s * nivel
            marca = 36 * s
            p = Parrafo(limpio, tam, ancho - sangria - marca, base='i' if self.spec.get('cursiva') else 'n')
            self.problemas += p.problemas
            self.items.append((nivel, sangria, marca, p, y, k))
            self.subcajas[('vineta', k)] = (sangria + marca - 6, y - 4, sangria + marca + p.ancho_usado + 6, y + p.alto + 2)
            y += p.alto + (14 if nivel == 0 else 8) * s
        self.w, self.h = ancho, max(1, y - 8 * s)
        return self.h

    def ocupado(self):
        return [(self.x + sangria, self.y + y, self.x + sangria + marca + p.ancho_usado, self.y + y + p.alto)
                for nivel, sangria, marca, p, y, k in self.items]

    def imagen(self):
        img = _rgba(self.w, self.h)
        d = ImageDraw.Draw(img)
        for nivel, sangria, marca, p, y, k in self.items:
            if self.spec.get('numerada') and nivel == 0:
                num = self.spec['numerada']
                inicio = num if isinstance(num, int) and not isinstance(num, bool) else 1
                d.text((sangria, y), f'{k + inicio - 1}.', font=fs('palab.ttf', p.tam), fill=MORADO)
            else:
                d.text((sangria + 4, y), '–' if nivel == 0 else '·', font=fs('palab.ttf', p.tam), fill=MORADO)
            p.pintar(d, sangria + marca, y, TINTA + (255,))
        return img


class ElTexto(Elemento):
    def texto(self):
        return str(self.spec['texto'])

    def medir(self, ancho, s):
        grande = self.spec.get('grande')
        tam = float(self.spec.get('tam', 1.0)) * (40 if grande else 32) * s
        self.p = Parrafo(self.spec['texto'], tam, ancho, base='b' if grande else ('i' if self.spec.get('cursiva') else 'n'))
        self.problemas = list(self.p.problemas)
        self.w, self.h = ancho, self.p.alto
        return self.h

    def ocupado(self):
        dx = (self.w - self.p.ancho_usado) / 2 if self.spec.get('centrado') else 0
        return [(self.x + dx, self.y, self.x + dx + self.p.ancho_usado, self.y + self.h)]

    def imagen(self):
        img = _rgba(self.w, self.h)
        color = ROTULADOR.get(self.spec.get('color'), MORADO if self.spec.get('grande') else TINTA)
        self.p.pintar(ImageDraw.Draw(img), 0, 0, color + (255,), centrado=bool(self.spec.get('centrado')))
        return img


class ElFormula(Elemento):
    alinear = 'centro'

    def texto(self):
        return self.spec['formula']

    def medir(self, ancho, s):
        color = ROTULADOR.get(self.spec.get('color'), TINTA)
        self.png = formula_png(self.spec['formula'], color, self.ctx['carpeta'])
        w0, h0 = Image.open(self.png).size
        tam = float(self.spec.get('tam', 1.0))
        self.escala = min(0.78 * tam * s, ancho / w0)
        if self.escala < 0.5 * tam:
            self.problemas.append(f'la fórmula no cabe (habría que reducirla al {self.escala / (0.78 * tam):.0%})')
        self.w, self.h = int(w0 * self.escala), int(h0 * self.escala)
        if self.spec.get('alinear') == 'izquierda':
            self.alinear = 'izquierda'
        return self.h

    def imagen(self):
        return Image.open(self.png).convert('RGBA').resize((max(1, self.w), max(1, self.h)), Image.LANCZOS)


class ElGrafico(Elemento):
    alinear = 'centro'

    def __init__(self, spec, ctx):
        super().__init__(spec, ctx)
        self.nombre = spec['grafico']
        self.capa = int(spec.get('capa', 1000))
        self.flexible = spec.get('alto') is None
        self.g = None

    def texto(self):
        return f'gráfico {self.nombre}'

    def _pie(self, ancho, s):
        if not self.spec.get('pie'):
            return None
        p = Parrafo(self.spec['pie'], 24 * s, ancho, base='i')
        self.problemas += p.problemas
        return p

    def natural(self, ancho, s):
        """Alto que tendría a todo el ancho de la columna."""
        pdf = compilar_capa(self.ctx['tema'], self.nombre, 1000, self.ctx['carpeta'])
        pag = fitz.open(pdf)[0]
        pie = self._pie(ancho, s)
        return ancho * pag.rect.height / pag.rect.width + (pie.alto + 10 if pie else 0)

    def medir(self, ancho, s, alto=None):
        if alto is None:
            a = float(self.spec['alto'])
            alto = a * (SL_Y1 - SL_Y0) if a <= 1 else a
        self.problemas = []
        self.pie = self._pie(ancho, s)
        alto_g = alto - (self.pie.alto + 10 if self.pie else 0)
        self.g = Grafico(self.ctx['tema'], self.nombre, self.ctx['carpeta'], (0, 0, ancho, max(10, alto_g)))
        if self.g.escala < GRAFICO_ESCALA_MIN:
            self.problemas.append(f'el gráfico {self.nombre} queda demasiado pequeño para leer sus rótulos '
                                  f'({self.g.escala:.2f} px/pt; mínimo {GRAFICO_ESCALA_MIN})')
        self.gx = int((ancho - self.g.w) / 2)
        self.w, self.h = ancho, self.g.h + (self.pie.alto + 10 if self.pie else 0)
        return self.h

    def imagen(self, capa=None):
        img = _rgba(self.w, self.h)
        img.alpha_composite(self.g.imagen(self.capa if capa is None else capa), (int(self.gx), 0))
        self.g._cache.clear()           # la memoria: cada capa se pinta una vez
        if self.pie:
            self.pie.pintar(ImageDraw.Draw(img), 0, self.g.h + 10, GRIS + (255,), centrado=True)
        return img

    def caja(self, sub=None):
        """La del gráfico (no la de la columna): para rodearlo o señalarlo."""
        if sub is None:
            return (self.x + self.gx, self.y, self.x + self.gx + self.g.w, self.y + self.g.h)
        return super().caja(sub)


class ElTabla(Elemento):
    def texto(self):
        return ' | '.join(map(str, self.spec.get('cabecera') or [])) or str(self.spec['tabla'])

    def medir(self, ancho, s):
        cab = self.spec.get('cabecera') or []
        filas = self.spec.get('filas') or []
        ncol = max([len(cab)] + [len(f) for f in filas])
        rel = self.spec.get('anchos') or [1] * ncol
        cols = [ancho * r / sum(rel) for r in rel]
        pad = 12 * s
        tam = float(self.spec.get('tam', 1.0)) * 27 * s
        self.celdas, self.subcajas, y = [], {}, 0
        destaca = set(self.spec.get('destaca') or [])
        for i, fila in enumerate(([cab] if cab else []) + filas):
            k = i if cab else i + 1           # 0, la cabecera; 1…, las filas
            ps, x = [], 0
            for j in range(ncol):
                t = fila[j] if j < len(fila) else ''
                p = Parrafo(t, tam * (0.88 if k == 0 else 1.0), cols[j] - 2 * pad,
                            familia='segoe' if k == 0 else 'pala', base='b' if (k == 0 or (k in destaca and j == 0)) else 'n')
                self.problemas += p.problemas
                ps.append((x, cols[j], p))
                x += cols[j]
            alto = max(p.alto for _, _, p in ps) + 2 * pad
            self.celdas.append((k, y, alto, ps))
            self.subcajas[('fila', k)] = (0, y, ancho, y + alto)
            for j, (xc, wc, _) in enumerate(ps, 1):
                self.subcajas[('celda', (k, j))] = (xc, y, xc + wc, y + alto)
            y += alto
        self.pad, self.destaca = pad, destaca
        self.w, self.h = ancho, y
        return self.h

    def imagen(self):
        img = _rgba(self.w, self.h)
        d = ImageDraw.Draw(img)
        for k, y, alto, ps in self.celdas:
            fondo = MORADO if k == 0 else (MORADO_PALIDO if k in self.destaca else ((255, 255, 255) if k % 2 else (246, 244, 248)))
            d.rectangle([0, y, self.w - 1, y + alto], fill=fondo + (255,))
            for xc, wc, p in ps:
                p.pintar(d, xc + self.pad, y + self.pad, ((255, 255, 255) if k == 0 else TINTA) + (255,))
            d.line([(0, y + alto), (self.w, y + alto)], fill=LILA + (255,), width=1)
        for xc, wc, p in self.celdas[0][3][1:]:
            d.line([(xc, 0), (xc, self.h)], fill=LILA + (255,), width=1)
        d.rectangle([0, 0, self.w - 1, self.h - 1], outline=MORADO + (255,), width=2)
        return img


class ElCaja(Elemento):
    def texto(self):
        t = self.spec.get('texto')
        return ' · '.join(map(str, t)) if isinstance(t, list) else str(t)

    def medir(self, ancho, s):
        tipo = self.spec.get('caja', 'clave')
        if tipo not in CAJAS:
            raise ErrorSlides(f'caja de tipo desconocido «{tipo}» (tipos: {", ".join(CAJAS)})')
        self.fondo, self.tinta_t, titulo, estilo = CAJAS[tipo]
        titulo = self.spec.get('titulo', titulo)
        self.pad = 22 * s
        dentro = ancho - 2 * self.pad - 8
        self.pt = Parrafo(titulo, 23 * s, dentro, familia='segoe', base='b') if titulo else None
        t = self.spec.get('texto')
        if isinstance(t, list):
            self.cuerpo = ElVinetas({'vinetas': t, 'tam': 0.9, 'cursiva': estilo == 'i'}, self.ctx)
            self.cuerpo.medir(dentro, s)
        else:
            self.cuerpo = ElTexto({'texto': t, 'cursiva': estilo == 'i', 'tam': 0.94}, self.ctx)
            self.cuerpo.medir(dentro, s)
        self.problemas = (self.pt.problemas if self.pt else []) + self.cuerpo.problemas
        self.yc = self.pad + (self.pt.alto + 6 * s if self.pt else 0)
        self.w, self.h = ancho, self.yc + self.cuerpo.h + self.pad
        return self.h

    def imagen(self):
        img = _rgba(self.w, self.h)
        d = ImageDraw.Draw(img)
        d.rounded_rectangle([0, 0, self.w - 1, self.h - 1], radius=12, fill=self.fondo + (255,))
        d.rounded_rectangle([0, 0, 8, self.h - 1], radius=4, fill=self.tinta_t + (255,))
        if self.pt:
            self.pt.pintar(d, self.pad + 8, self.pad, self.tinta_t + (255,))
        img.alpha_composite(self.cuerpo.imagen(), (int(self.pad + 8), int(self.yc)))
        return img


class ElCifras(Elemento):
    def texto(self):
        return ' · '.join(f'{a} {b}' for a, b in self.spec['cifras'])

    def medir(self, ancho, s):
        items = self.spec['cifras']
        self.colw = ancho / len(items)
        self.ps, alto = [], 0
        for k, (cifra, etiqueta) in enumerate(items, 1):
            pc = Parrafo(cifra, 64 * s, self.colw - 30, base='b', interlinea=1.15)
            pe = Parrafo(etiqueta, 26 * s, self.colw - 40)
            self.problemas += pc.problemas + pe.problemas
            self.ps.append((pc, pe))
            alto = max(alto, pc.alto + 6 + pe.alto)
        for k, (pc, pe) in enumerate(self.ps, 1):
            w = max(pc.ancho_usado, pe.ancho_usado)
            x0 = (k - 1) * self.colw + (self.colw - w) / 2
            self.subcajas[('cifra', k)] = (x0, 0, x0 + w, alto)
        self.w, self.h = ancho, alto
        return alto

    def imagen(self):
        img = _rgba(self.w, self.h)
        d = ImageDraw.Draw(img)
        for k, (pc, pe) in enumerate(self.ps):
            x = k * self.colw
            if k:
                d.line([(x, 10), (x, self.h - 10)], fill=LILA + (255,), width=2)
            pc.pintar(d, x + 15, 0, MORADO + (255,), centrado=True)
            pe.pintar(d, x + 20, pc.alto + 6, TINTA + (255,), centrado=True)
        return img


class ElFlujo(Elemento):
    def texto(self):
        return ' → '.join(map(str, self.spec['flujo']))

    def medir(self, ancho, s):
        items = self.spec['flujo']
        self.fl = 60 * s
        self.bw = (ancho - self.fl * (len(items) - 1)) / len(items)
        self.pad = 16 * s
        self.ps = [Parrafo(t, 30 * s, self.bw - 2 * self.pad, base='b') for t in items]
        for p in self.ps:
            self.problemas += p.problemas
        alto = max(p.alto for p in self.ps) + 2 * self.pad
        for k in range(len(items)):
            x = k * (self.bw + self.fl)
            self.subcajas[('paso', k + 1)] = (x, 0, x + self.bw, alto)
        self.w, self.h = ancho, alto
        return alto

    def imagen(self):
        img = _rgba(self.w, self.h)
        d = ImageDraw.Draw(img)
        for k, p in enumerate(self.ps):
            x = k * (self.bw + self.fl)
            d.rounded_rectangle([x, 0, x + self.bw, self.h - 1], radius=14, fill=MORADO_PALIDO + (255,),
                                outline=MORADO + (255,), width=2)
            p.pintar(d, x + self.pad, (self.h - p.alto) / 2, MORADO_OSCURO + (255,), centrado=True)
            if k + 1 < len(self.ps):
                xa, xb, ym = x + self.bw + 8, x + self.bw + self.fl - 8, self.h / 2
                d.line([(xa, ym), (xb, ym)], fill=MORADO + (255,), width=4)
                d.polygon([(xb, ym), (xb - 14, ym - 9), (xb - 14, ym + 9)], fill=MORADO + (255,))
        return img


TIPOS_ELEMENTO = {'vinetas': ElVinetas, 'texto': ElTexto, 'formula': ElFormula, 'grafico': ElGrafico,
                  'tabla': ElTabla, 'caja': ElCaja, 'cifras': ElCifras, 'flujo': ElFlujo}


def crear_elemento(spec, ctx):
    # La caja lleva «texto» dentro: el tipo es la primera clave que aparece en este orden
    tipos = [k for k in ('caja', 'tabla', 'grafico', 'formula', 'cifras', 'flujo', 'vinetas', 'texto') if k in spec][:1]
    if len(tipos) != 1:
        raise ErrorSlides(f'elemento de slide no válido (tiene que llevar uno de {", ".join(TIPOS_ELEMENTO)}): {spec}')
    if tipos[0] == 'tabla' and spec['tabla'] is not True and 'filas' not in spec:
        spec = {**spec, **spec['tabla']} if isinstance(spec['tabla'], dict) else spec
    return TIPOS_ELEMENTO[tipos[0]](spec, ctx)


# --- Índice de la guía: «§ I.3 · pág. 10» desde el .aux -------------------------------------------
def _limpiar_tex(t):
    t = re.sub(r'\\(?:numberline|ignorespaces|protect|relax)\s*', '', t)
    t = re.sub(r'\\[a-zA-Z]+\s*', '', t)
    return re.sub(r'\s+', ' ', t.replace('{', '').replace('}', '').replace('~', ' ')).strip()


class IndiceGuia:
    """Apartados, párrafos, gráficos y tablas de la guía con su página impresa (la del .aux)."""

    def __init__(self, tema):
        aux = os.path.join(tema.trabajo, f'{tema.archivo}.aux')
        if not os.path.exists(aux):
            raise ErrorSlides(f'No existe {aux}: hay que compilar la guía para sacar las páginas')
        self.entradas = []
        patron = re.compile(r'\\@writefile\{(toc|lof|lot)\}\{\\contentsline \{(\w+)\}\{(.*)\}\{([^{}]*)\}\{[^{}]*\}'
                            r'\\protected@file@percent \}')
        for linea in open(aux, encoding='utf-8'):
            m = patron.match(linea.strip())
            if not m:
                continue
            fichero, nivel, cuerpo, pagina = m.groups()
            num = re.match(r'\\numberline \{([^{}]*)\}', cuerpo)
            numero = num.group(1) if num else None
            titulo = _limpiar_tex(cuerpo[num.end():] if num else cuerpo)
            self.entradas.append({'tipo': fichero, 'nivel': nivel, 'numero': numero, 'titulo': titulo, 'pagina': pagina})

    def buscar(self, ref):
        """«I.3», «I.3 > Brecha de producción», «Gráfico 5», «Tabla 7» o «Introducción»
        → (rótulo de la esquina, página)."""
        ref = str(ref).strip()
        m = re.fullmatch(r'(Gráfico|Tabla)\s+(\d+)', ref, re.I)
        if m:
            tipo = 'lof' if m.group(1).lower().startswith('g') else 'lot'
            for k, e in enumerate(self.entradas):
                if e['tipo'] == tipo and e['numero'] == m.group(2):
                    sec = next((x for x in reversed(self.entradas[:k]) if x['tipo'] == 'toc' and x['numero']), None)
                    pre = f'§ {sec["numero"]} · ' if sec else ''
                    return f'{pre}{m.group(1).lower()} {m.group(2)} · pág. {e["pagina"]}', e['pagina']
            raise ErrorSlides(f'la guía no tiene «{ref}»')
        partes = [x.strip() for x in ref.split('>')]
        for k, e in enumerate(self.entradas):
            if e['tipo'] != 'toc':
                continue
            if e['numero'] == partes[0] or (e['numero'] is None and e['titulo'].lower() == partes[0].lower()):
                if len(partes) == 1:
                    return f'§ {partes[0]} · pág. {e["pagina"]}', e['pagina']
                for x in self.entradas[k + 1:]:
                    if x['tipo'] != 'toc':
                        continue
                    if x['nivel'] in ('section', 'subsection') and x['numero']:
                        break
                    if x['titulo'].lower().startswith(partes[1].lower()):
                        return f'§ {partes[0]} · pág. {x["pagina"]}', x['pagina']
                raise ErrorSlides(f'el apartado {partes[0]} de la guía no tiene «{partes[1]}»')
        raise ErrorSlides(f'la guía no tiene el apartado «{partes[0]}»')


# --- Una slide: maquetación, imagen y anotaciones -------------------------------------------------
class Slide:
    def __init__(self, spec, escena, ctx):
        self.spec, self.ctx = spec, ctx
        self.titulo = spec.get('titulo') or escena.get('titulo') or escena['bloque']
        self.guia = spec.get('guia') or escena.get('guia')
        panel = spec.get('pizarra')
        self.panel = None
        if panel:
            panel = {'ancho': panel} if isinstance(panel, (int, float)) else dict(panel)
            a = float(panel.get('ancho', 40))
            if a >= 100:
                self.panel, self.area = (SL_X0, SL_Y0, SL_X1, SL_Y1), None
            else:
                wp = (SL_X1 - SL_X0) * a / 100
                if panel.get('lado', 'derecha') == 'izquierda':
                    self.panel, self.area = (SL_X0, SL_Y0, SL_X0 + wp, SL_Y1), (SL_X0 + wp + 40, SL_Y0, SL_X1, SL_Y1)
                else:
                    self.panel, self.area = (SL_X1 - wp, SL_Y0, SL_X1, SL_Y1), (SL_X0, SL_Y0, SL_X1 - wp - 40, SL_Y1)
            self.panel = tuple(int(round(v)) for v in self.panel)
            self.panel_spec = panel
        else:
            self.area = (SL_X0, SL_Y0, SL_X1, SL_Y1)
        # Los elementos, en el orden en que aparecen: los de «contenido» al empezar la slide y los
        # de «muestra» de cada paso al empezar ese paso. Un gráfico que ya está y vuelve con otra
        # capa no es un elemento nuevo: se le añade la capa
        self.elementos, self.capas, self.ids = [], [], {}
        pasos = spec.get('pasos') or []
        listas = [(0, spec.get('contenido') or [])] + [(k, p.get('muestra') or []) for k, p in enumerate(pasos)]
        for k, lista in listas:
            for el in (lista if isinstance(lista, list) else [lista]):
                previo = next((e for e in self.elementos if isinstance(e, ElGrafico) and 'grafico' in el
                               and e.nombre == el['grafico'] and not el.get('id')), None)
                if previo is not None:
                    self.capas.append((k, previo, int(el.get('capa', 1000))))
                    continue
                e = crear_elemento(el, ctx)
                e.paso = k
                self.elementos.append(e)
                if e.id:
                    self.ids[e.id] = e
        if self.elementos and self.area is None:
            raise ErrorSlides('la slide es una pizarra entera (pizarra: 100) y lleva elementos de slide')

    def maquetar(self):
        """Coloca los elementos (columnas y de arriba abajo). Devuelve los problemas (texto que no cabe)."""
        if not self.elementos:
            return []
        x0, y0, x1, y1 = self.area
        rel = self.spec.get('columnas') or [100]
        hueco_col = 44
        util = x1 - x0 - hueco_col * (len(rel) - 1)
        cols, x = [], x0
        for r in rel:
            w = util * r / sum(rel)
            cols.append((x, x + w))
            x += w + hueco_col
        alto = y1 - y0
        ultimo = None
        for s in SL_ESCALAS:
            problemas, colocados = [], []
            for c, (cx0, cx1) in enumerate(cols, 1):
                en = [e for e in self.elementos if e.col == c]
                if not en:
                    continue
                ancho = cx1 - cx0
                fijos = [e for e in en if not e.flexible]
                flex = [e for e in en if e.flexible]
                usado = sum(e.medir(ancho, s) for e in fijos) + SL_HUECO * s * (len(en) - 1)
                resto = alto - usado
                if flex:
                    cada = resto / len(flex)
                    if cada < GRAFICO_ALTO_MIN:
                        problemas.append((en[-1], f'no queda sitio para {len(flex)} gráfico(s) ({int(cada)} px; mínimo {GRAFICO_ALTO_MIN})'))
                    for e in flex:
                        usado += e.medir(ancho, s, max(GRAFICO_ALTO_MIN, min(cada, e.natural(ancho, s))))
                if usado > alto + 0.5:
                    problemas.append((en[-1], f'no cabe ni con la letra al {SL_ESCALAS[-1]:.0%}: la columna {c} mide '
                                              f'{int(usado)} px y caben {int(alto)} (partir la slide o quitar algo)'))
                for e in en:
                    for pr in e.problemas:
                        problemas.append((e, pr))
                y = y0 + (max(0, alto - usado) / 2 if self.spec.get('vertical') == 'centro' else 0)
                for e in en:
                    e.w, e.h = int(round(e.w)), int(round(e.h))
                    e.x = int(cx0 + ((ancho - e.w) / 2 if e.alinear == 'centro' else 0))
                    e.y = int(y)
                    y += e.h + SL_HUECO * s
                    colocados.append(e)
            ultimo = problemas
            if not problemas:
                self.escala = s
                return []
        return [f'{pr} — «{e.texto()[:70]}»' for e, pr in ultimo]

    def esquina(self):
        if not self.guia:
            raise ErrorSlides('la slide no dice dónde está en la guía («guia: "I.3"»)')
        return self.ctx['indice'].buscar(self.guia)[0]

    def problemas_titulo(self):
        for tam in (46, 42, 38):
            p = Parrafo(self.titulo, tam, SL_X1 - SL_X0 - 10, base='b')
            if len(p.lineas) == 1 and not p.problemas:
                self.p_titulo = p
                return []
        return [f'el título de la slide no cabe en una línea — «{self.titulo}»']

    def base(self, hasta_paso=0):
        """Imagen del cuerpo al empezar la slide (con lo que se ve desde el primer paso)."""
        img = Image.new('RGBA', (ANCHO, CUERPO_H), PAPEL + (255,))
        d = ImageDraw.Draw(img)
        self.p_titulo.pintar(d, SL_X0, 22, MORADO + (255,))
        d.line([(SL_X0, 88), (SL_X1, 88)], fill=ORO + (255,), width=2)
        esquina = self.esquina()
        f = fs('segoeui.ttf', 21)
        w = d.textlength(esquina, font=f)
        d.rounded_rectangle([SL_X1 - w - 22, CUERPO_H - 44, SL_X1, CUERPO_H - 12], radius=14,
                            fill=MORADO_PALIDO + (255,))
        d.text((SL_X1 - 11, CUERPO_H - 28), esquina, font=f, fill=MORADO_MEDIO + (255,), anchor='rm')
        if self.ctx.get('licencia'):
            d.text((SL_X0, CUERPO_H - 28), self.ctx['licencia'], font=F_MARCO, fill=(165, 150, 178, 255), anchor='lm')
        if self.panel:
            px0, py0, px1, py1 = self.panel
            d.rounded_rectangle([px0 - 9, py0 - 9, px1 + 9, py1 + 9], radius=10, fill=MARCO + (255,))
            d.rectangle([px0, py0, px1, py1], fill=PIZARRA + (255,))
        for e in self.elementos:
            if e.paso <= hasta_paso:
                img.alpha_composite(e.imagen(), (e.x, e.y))
        for k, e, capa in self.capas:
            if k <= hasta_paso:
                img.alpha_composite(e.imagen(capa), (e.x, e.y))
        return img

    def objetivo(self, sel):
        """Caja (en el cuerpo) de un selector: «id», «id/fila 2», «id/celda 2,1», «id/vineta 3»."""
        sel = str(sel)
        nombre, _, resto = sel.partition('/')
        if nombre not in self.ids:
            raise ErrorSlides(f'la anotación apunta a «{nombre}», que no está en la slide')
        e = self.ids[nombre]
        if not resto:
            return e.caja()
        z = re.fullmatch(r'\s*zona\s+([\d.]+)\s*,\s*([\d.]+)\s*,\s*([\d.]+)\s*,\s*([\d.]+)\s*', resto)
        if z:       # un trozo del elemento, en fracciones de su caja (p. ej., un dato de un gráfico)
            x0, y0, x1, y1 = e.caja()
            f = [float(v) for v in z.groups()]
            return (x0 + f[0] * (x1 - x0), y0 + f[1] * (y1 - y0), x0 + f[2] * (x1 - x0), y0 + f[3] * (y1 - y0))
        m = re.fullmatch(r'\s*(fila|celda|vineta|cifra|paso)\s+(\d+)(?:\s*,\s*(\d+))?\s*', resto)
        if not m:
            raise ErrorSlides(f'selector de anotación no válido: «{sel}»')
        arg = (int(m.group(2)), int(m.group(3))) if m.group(1) == 'celda' else int(m.group(2))
        return e.caja((m.group(1), arg))


def _trazo(puntos, color, grosor=5):
    """Una línea a mano (lista de puntos) → (imagen RGBA, parte del tablero, caja en el cuerpo)."""
    xs, ys = [p[0] for p in puntos], [p[1] for p in puntos]
    m = grosor + 6
    x0, y0 = int(max(0, min(xs) - m)), int(max(0, min(ys) - m))
    x1, y1 = int(min(ANCHO, max(xs) + m)), int(min(CUERPO_H, max(ys) + m))
    loc = [(x - x0, y - y0) for x, y in puntos]
    img = _rgba(x1 - x0, y1 - y0)
    ImageDraw.Draw(img).line(loc, fill=color + (255,), width=grosor, joint='curve')
    largo = largo_tramos([loc])
    parte = {'tipo': 'trazo', 'tramos': [loc], 'grosor': grosor + 4, 'caja': None,
             'dur': min(1.4, max(0.35, largo / VEL_TRAZO)) + LEVANTAR}
    return img, parte, (x0, y0, x1, y1)


def _semilla(*cosas):
    return int(huella(*cosas)[:8], 16)


def anotacion(slide, a):
    """Lo que se escribe a mano encima de la slide: rodear, subrayar, una flecha, un texto o una
    fórmula junto a algo. Devuelve operaciones de dibujo (coordenadas del cuerpo)."""
    color = ROTULADOR.get(a.get('color', 'rojo'), ROTULADOR['rojo'])
    rng = np.random.default_rng(_semilla(json.dumps(a, sort_keys=True, ensure_ascii=False)))
    if 'rodea' in a:
        x0, y0, x1, y1 = slide.objetivo(a['rodea'])
        cx, cy = (x0 + x1) / 2, (y0 + y1) / 2
        w, h = x1 - x0, y1 - y0
        ancha = w > 2.6 * h          # una fila o una caja ancha: un rectángulo redondeado a mano
        if ancha:
            rx, ry, n = w / 2 + 12, h / 2 + 8, 5.0
        else:
            rx, ry, n = w / 2 + 14 + min(30, 0.06 * w), h / 2 + 10 + min(18, 0.14 * h), 2.0
        rx = max(10, min(rx, cx - 8, ANCHO - 8 - cx))           # sin salirse del cuerpo
        ry = max(8, min(ry, cy - SL_Y0 + 30, CUERPO_H - 8 - cy))
        ini = math.radians(200 + rng.uniform(-10, 10))
        pts = []
        for k in range(97):
            ang = ini - math.radians(380) * k / 96
            r = 1 + 0.02 * math.sin(3 * ang + rng.uniform(0, 0.3)) + (0.04 * k / 96)
            c, sn = math.cos(ang), math.sin(ang)
            ex = abs(c) ** (2 / n) * (1 if c >= 0 else -1)
            ey = abs(sn) ** (2 / n) * (1 if sn >= 0 else -1)
            pts.append((cx + rx * r * ex, cy - ry * r * ey))
        img, parte, caja = _trazo(pts, color)
        return [op_dibujo(caja[:2], img, False, None, [parte])]
    if 'subraya' in a:
        x0, y0, x1, y1 = slide.objetivo(a['subraya'])
        y = y1 + 4
        pts = [(x0 + (x1 - x0) * k / 20, y + 2.5 * math.sin(k * 0.9 + rng.uniform(0, 1)) - 3 * k / 20) for k in range(21)]
        img, parte, caja = _trazo(pts, color)
        return [op_dibujo(caja[:2], img, False, None, [parte])]
    if 'tacha' in a:           # una raya a mano que atraviesa lo que no hay que hacer
        x0, y0, x1, y1 = slide.objetivo(a['tacha'])
        pts = [(x0 + (x1 - x0) * k / 20, y1 - (y1 - y0) * (0.25 + 0.5 * k / 20) + 2 * math.sin(k + rng.uniform(0, 1)))
               for k in range(21)]
        img, parte, caja = _trazo(pts, color, 6)
        return [op_dibujo(caja[:2], img, False, None, [parte])]
    if 'flecha' in a:
        bx0, by0, bx1, by1 = slide.objetivo(a['flecha'])
        if a.get('desde'):
            ax0, ay0, ax1, ay1 = slide.objetivo(a['desde'])
            acx, acy, bcx, bcy = (ax0 + ax1) / 2, (ay0 + ay1) / 2, (bx0 + bx1) / 2, (by0 + by1) / 2
            if abs(bcx - acx) > abs(bcy - acy):
                p0 = (ax1 + 10, acy) if bcx > acx else (ax0 - 10, acy)
                p1 = (bx0 - 12, bcy) if bcx > acx else (bx1 + 12, bcy)
            else:
                p0 = (acx, ay1 + 8) if bcy > acy else (acx, ay0 - 8)
                p1 = (bcx, by0 - 10) if bcy > acy else (bcx, by1 + 10)
        else:
            lado = a.get('lado', 'izquierda')
            largo = float(a.get('largo', 90))
            bcx, bcy = (bx0 + bx1) / 2, (by0 + by1) / 2
            p1 = {'izquierda': (bx0 - 10, bcy), 'derecha': (bx1 + 10, bcy), 'arriba': (bcx, by0 - 8),
                  'abajo': (bcx, by1 + 8)}[lado]
            dx, dy = {'izquierda': (-1, 0.25), 'derecha': (1, 0.25), 'arriba': (0.2, -1), 'abajo': (0.2, 1)}[lado]
            p0 = (p1[0] + dx * largo, p1[1] + dy * largo * 0.6)
        ang = math.atan2(p1[1] - p0[1], p1[0] - p0[0])
        medio = ((p0[0] + p1[0]) / 2 - math.sin(ang) * 8, (p0[1] + p1[1]) / 2 + math.cos(ang) * 8)
        cuerpo = [(p0[0] + (medio[0] - p0[0]) * k / 10, p0[1] + (medio[1] - p0[1]) * k / 10) for k in range(11)] + \
                 [(medio[0] + (p1[0] - medio[0]) * k / 10, medio[1] + (p1[1] - medio[1]) * k / 10) for k in range(1, 11)]
        punta = [(p1[0] - 22 * math.cos(ang - 0.45), p1[1] - 22 * math.sin(ang - 0.45)), p1,
                 (p1[0] - 22 * math.cos(ang + 0.45), p1[1] - 22 * math.sin(ang + 0.45))]
        ops = []
        for pts in (cuerpo, punta):
            img, parte, caja = _trazo(pts, color)
            ops.append(op_dibujo(caja[:2], img, False, None, [parte]))
        return ops
    if 'escribe' in a or 'formula' in a:
        if 'escribe' in a:
            p = Parrafo(a['escribe'], 34 * float(a.get('tam', 1.0)), float(a.get('ancho', 620)), familia='mano',
                        interlinea=1.25)
            if p.problemas:
                raise ErrorSlides(f'anotación «{a["escribe"]}»: {"; ".join(p.problemas)}')
            img = _rgba(p.ancho_usado + 4, p.alto + 8)
            p.pintar(ImageDraw.Draw(img), 0, 0, color + (255,))
            partes = trazos_mano(np.asarray(img)[:, :, 3])
        else:
            png = formula_png(a['formula'], color, slide.ctx['carpeta'])
            img = Image.open(png).convert('RGBA')
            esc = 0.8 * float(a.get('tam', 1.0))
            img = img.resize((max(1, int(img.width * esc)), max(1, int(img.height * esc))), Image.LANCZOS)
            partes = partes_formula(png, img)
        if a.get('pos'):
            fx, fy = a['pos']
            ax0, ay0, ax1, ay1 = slide.area or (SL_X0, SL_Y0, SL_X1, SL_Y1)
            x, y = ax0 + fx * (ax1 - ax0), ay0 + fy * (ay1 - ay0)
        else:
            x0, y0, x1, y1 = slide.objetivo(a.get('junto'))
            lado = a.get('lado', 'derecha')
            if lado == 'derecha':
                x, y = x1 + 22, (y0 + y1) / 2 - img.height / 2
            elif lado == 'izquierda':
                x, y = x0 - 22 - img.width, (y0 + y1) / 2 - img.height / 2
            elif lado == 'abajo':
                x, y = x0, y1 + 10
            else:
                x, y = x0, y0 - 10 - img.height
        x, y = int(round(x)), int(round(y))
        texto = a.get('escribe') or a.get('formula')
        if x < SL_X0 - 30 or y < SL_Y0 - 20 or x + img.width > SL_X1 + 30 or y + img.height > SL_Y1 + 20:
            raise ErrorSlides(f'la anotación «{texto}» se sale de la slide')
        if slide.panel and x < slide.panel[2] and x + img.width > slide.panel[0] and y < slide.panel[3] \
                and y + img.height > slide.panel[1]:
            raise ErrorSlides(f'la anotación «{texto}» se mete en la pizarra')
        for e in slide.elementos:          # lo escrito a mano no puede tapar nada de la slide
            for ex0, ey0, ex1, ey1 in ([e.caja()] if isinstance(e, ElGrafico) else e.ocupado()):
                if x < ex1 - 4 and x + img.width > ex0 + 4 and y < ey1 - 4 and y + img.height > ey0 + 4:
                    raise ErrorSlides(f'la anotación «{texto}» tapa «{e.texto()[:50]}»')
        return [op_dibujo((x, y), img, False, None, partes)]
    raise ErrorSlides(f'anotación desconocida: {a}')


class TableroSlides(Tablero):
    """El tablero de las slides (o de un panel de pizarra): como el de la pizarra, pero de otro
    tamaño y con imágenes que se pintan al llegar su momento (crear), para no tenerlas todas en memoria."""

    def __init__(self, ops, tam, color):
        super().__init__(ops)
        self.img = Image.new('RGB', tam, color)

    def _preparar(self, op):
        if 'crear' in op:
            op['img'] = op.pop('crear')()
        super()._preparar(op)


# --- Plan de las slides: qué se ve y se escribe en cada momento ------------------------------------
def preparar_slides(guion):
    """Pone en cada escena la lista plana de sus pasos (la de los cantes), con la slide de cada uno."""
    for i, e in enumerate(guion['escenas']):
        if 'pasos' in e and 'slides' not in e:
            raise ErrorSlides(f'escena {i + 1}: en el formato slides los pasos van dentro de «slides»')
        e['pasos'] = []
        for j, sl in enumerate(e.get('slides') or []):
            for k, p in enumerate(sl.get('pasos') or []):
                p['_slide'] = (i, j)
                p['_k'] = k
                p['_pausa_antes'] = PAUSA_SLIDE if k == 0 and j > 0 else 0.0
                e['pasos'].append(p)
            if not sl.get('pasos'):
                raise ErrorSlides(f'escena {i + 1}, slide «{sl.get("titulo")}»: sin pasos (sin voz)')


def planificar_slides(tema, carpeta, escenas, pantallas, pasos, contenido_fin):
    """Como planificar() de los cantes, para las slides: operaciones del tablero de las slides,
    sesiones del panel de pizarra, esquemas entre apartados, subtítulos, capítulos, notas de cada
    slide y los errores de maquetación (texto que no cabe)."""
    ctx = {'tema': tema, 'carpeta': carpeta, 'indice': IndiceGuia(tema),
           'licencia': pantallas.licencia if pantallas.exclusivo else None}
    ops, pendientes, tarjetas, avisos, errores = [], [], [], [], []
    subtitulos, capitulos, notas = [], [(0.0, 'Título')], []
    sesiones, sesion = [], None
    slides = {}

    def barrera(tb):
        for op in pendientes:
            op['barrera'] = tb
        pendientes.clear()

    escena_actual, parte_actual = -1, None
    slide_actual = None
    for n, p in enumerate(pasos):
        e = escenas[p['escena']]
        paso = p['paso']
        t0 = p['inicio']
        listo = t0
        clave_sl = paso['_slide']
        nueva_slide = clave_sl != slide_actual
        nueva = p['escena'] != escena_actual
        p['brillo_desde'] = None
        p['fundido'] = nueva_slide and n > 0
        if nueva:
            escena_actual = p['escena']
            parte_actual = None
            capitulos.append((t0, e.get('titulo') or e['bloque']))
            if n > 0 and pantallas.cambia_apartado(pasos[n - 1]['escena'], p['escena']):
                previo = pasos[n - 1]
                c0 = previo['inicio'] + previo['dur'] + 0.15
                c1 = max(c0 + TARJETA_MIN, t0 + 0.6)
                tarjetas.append({'c0': c0, 'c1': c1, 'escena': p['escena'], 'previa': previo['escena']})
                barrera(c0 - 0.1)
                listo = c1
                p['brillo_desde'] = t0
                p['brillo_bloque'] = escenas[previo['escena']]['bloque'] != e['bloque']
        if paso.get('parte'):
            parte_actual = paso['parte']
        p['parte'] = parte_actual if e.get('estructura') else None
        donde = f'{mmss(t0)} (escena {p["escena"] + 1}, «{e["slides"][clave_sl[1]].get("titulo") or e.get("titulo")}»)'
        if not str(paso.get('di') or '').strip():
            avisos.append(f'{donde}: paso sin «di»: la voz no se para nunca')
        elif len(re.findall(r'\[pausa', paso['di'])) > 2:
            avisos.append(f'{donde}: más de dos [pausa] en un paso (una o dos como mucho)')
        if paso.get('di'):
            fr = frases(sin_pausas(paso['di']))
            largo = sum(len(f) for f in fr) or 1
            ti = t0
            for f in fr:
                tf = ti + p['dur'] * len(f) / largo
                subtitulos.append((ti, tf, f))
                ti = tf
        barrera(t0)
        # La slide: al empezar, su imagen de base (título, esquina, marco del panel y lo que se ve desde el principio)
        if nueva_slide:
            slide_actual = clave_sl
            try:
                sl = Slide(e['slides'][clave_sl[1]], e, ctx)
                problemas = sl.problemas_titulo() + sl.maquetar()
                sl.esquina()
            except ErrorSlides as ex:
                errores.append(f'{donde}: {ex}')
                sl = None
                problemas = []
            for pr in problemas:
                errores.append(f'{donde}: {pr}')
            if problemas:
                sl = None
            slides[clave_sl] = sl
            notas.append({'inicio': round(t0, 2), 'escena': p['escena'] + 1, 'apartado': e.get('titulo'),
                          'slide': (e['slides'][clave_sl[1]].get('titulo') or e.get('titulo')),
                          'guia': sl.esquina() if sl else None, 'notas': []})
            if sl:
                ops.append({'tipo': 'dibujo', 'caja': (0, 0, ANCHO, CUERPO_H), 'crear': (lambda s=sl: s.base(0)),
                            'reemplaza': False, 'fondo': None, 'listo': t0, 'paso': n, 'dicho': '',
                            'partes': [{'tipo': 'relleno', 'caja': (0, 0, ANCHO, CUERPO_H), 'dur': 0.02}]})
                pendientes.append(ops[-1])
            # El panel de pizarra: sigue el mismo mientras las slides lo tengan en el mismo sitio
            if sesion and (not sl or sl.panel != sesion['rect'] or (sl.panel_spec or {}).get('nueva')):
                sesion['t1'] = t0
                sesion = None
            if sl and sl.panel and sesion is None:
                x0, y0, x1, y1 = sl.panel
                sesion = {'rect': sl.panel, 't0': t0, 't1': contenido_fin, 'ops': [], 'pendientes': [],
                          'pizarra': Pizarra(tema, carpeta, x1 - x0, y1 - y0)}
                sesiones.append(sesion)
            if sl and sl.panel and sesion is not None and (sl.panel_spec.get('rejilla') is not None):
                # rejilla de la slide: se aplica en su primer paso (si no la cambia el propio paso)
                if 'rejilla' not in paso:
                    paso = {**paso, 'rejilla': sl.panel_spec['rejilla'], 'lineas': sl.panel_spec.get('lineas')}
        sl = slides.get(clave_sl)
        if sesion is not None:
            for op in sesion['pendientes']:
                op['barrera'] = t0
            sesion['pendientes'].clear()
        notas[-1]['notas'].append(sin_pausas(paso.get('di') or ''))
        notas[-1].setdefault('pasos', []).append([round(t0, 2), round(p['dur'], 2)])
        if sl is None:
            continue
        k = paso['_k']
        nuevos = []
        # Lo que aparece en este paso (salvo en el primero, que ya está en la base)
        if k > 0:
            for el in sl.elementos:
                if el.paso == k:
                    nuevos.append({'tipo': 'dibujo', 'caja': (el.x, el.y, el.x + el.w, el.y + el.h), 'crear': (lambda el=el: el.imagen()),
                                   'reemplaza': False, 'fondo': None,
                                   'partes': [{'tipo': 'relleno', 'caja': (0, 0, el.w, el.h), 'dur': 0.45}]})
            for kc, el, capa in sl.capas:
                if kc == k:
                    nuevos.append({'tipo': 'dibujo', 'caja': (el.x, el.y, el.x + el.w, el.y + el.h), 'crear': (lambda el=el, c=capa: el.imagen(c)),
                                   'reemplaza': False, 'fondo': None,
                                   'partes': [{'tipo': 'relleno', 'caja': (0, 0, el.w, el.h), 'dur': 0.6}]})
        try:
            for a in (paso.get('anota') or []):
                nuevos += anotacion(sl, a)
        except ErrorSlides as ex:
            errores.append(f'{donde}: {ex}')
        for op in nuevos:
            op['listo'], op['paso'], op['dicho'] = listo + (FUNDIDO if p['fundido'] else 0), n, sin_pausas(paso.get('di') or '')
            ops.append(op)
            pendientes.append(op)
        # La pizarra del panel: lo mismo que en los cantes (rejilla, borrar, conservar y lo que se escribe)
        acciones = paso.get('pizarra') or []
        acciones = [acciones] if isinstance(acciones, dict) else acciones
        if (acciones or paso.get('borrar') or 'rejilla' in paso) and sesion is None:
            errores.append(f'{donde}: el paso escribe en la pizarra, pero la slide no tiene panel de pizarra')
            continue
        if sesion is None:
            continue
        piz = sesion['pizarra']
        antes = len(piz.avisos)
        nuevos = []
        if 'rejilla' in paso and paso['rejilla'] is not None:
            nuevos += piz.cambiar_rejilla(paso['rejilla'], paso.get('conservar'), paso.get('lineas'))
        if paso.get('borrar'):
            nuevos += piz.borrar(paso['borrar'], paso.get('conservar'))
        for accion in acciones:
            try:
                nuevos.append(piz.anadir(accion))
            except (ValueError, RuntimeError) as ex:
                errores.append(f'{donde}: pizarra: {ex}')
        for op in nuevos:
            op['listo'], op['paso'], op['dicho'] = listo + (FUNDIDO if p['fundido'] else 0), n, sin_pausas(paso.get('di') or '')
            sesion['ops'].append(op)
            sesion['pendientes'].append(op)
        for j in range(antes, len(piz.avisos)):
            avisos.append(f'{donde}: {piz.avisos[j]}')
    barrera(contenido_fin - 0.2)
    for s in sesiones:
        for op in s['pendientes']:
            op['barrera'] = min(s['t1'], contenido_fin) - 0.2
        s['pendientes'].clear()
    programar(ops, avisos)
    for s in sesiones:
        programar(s['ops'], avisos)
    # Ningún texto de la cabecera ni del esquema puede recortarse
    for i in range(len(escenas)):
        partes = [None] + list(escenas[i].get('estructura') or [])
        for parte in partes:
            pantallas.cabecera(i, 0, pantallas.total, parte)
    for c in tarjetas:
        pantallas.tarjeta(c['escena'], c['previa'], 1.0)
    for texto in pantallas.cortes:
        errores.append(f'la cabecera o el esquema recortarían «{texto}» (acortar el título o usar «corto»)')
    return {'ops': ops, 'sesiones': sesiones, 'tarjetas': tarjetas, 'avisos': avisos, 'errores': errores,
            'subtitulos': subtitulos, 'capitulos': capitulos, 'notas': notas}


def fotogramas_slides(plan, pasos, escenas, pantallas, total, portada_fin, contenido_fin, tramo, instantes,
                      proceso, carpeta_f):
    """El bucle de fotogramas de las slides (el de los cantes está en main)."""
    tablero = TableroSlides(plan['ops'], (ANCHO, CUERPO_H), PAPEL)
    for s in plan['sesiones']:
        x0, y0, x1, y1 = s['rect']
        s['tablero'] = TableroSlides(s['ops'], (x1 - x0, y1 - y0), PIZARRA)
    tarjetas = plan['tarjetas']
    primer_paso = {}
    for q in pasos:
        primer_paso.setdefault(q['escena'], q)
    portada = pantallas.portada().tobytes()
    cierre = pantallas.cierre().tobytes()
    cache_tarjeta = {}
    cabecera_clave = cabecera_bytes = None
    cuerpo_clave = cuerpo_img = cuerpo_bytes = None
    ultimo, antes_de_paso, n_visto = None, None, -1
    n = 0
    siguiente_instante = 0
    marcos = int(round(total * FPS))
    for marco in range(int(round(tramo[0] * FPS)) if not instantes else 0, min(marcos, int(math.ceil(tramo[1] * FPS)))):
        t = marco / FPS
        if instantes:
            if siguiente_instante >= len(instantes):
                break
            if t + 1e-9 < instantes[siguiente_instante] - 0.5 / FPS:
                continue
        if t < portada_fin or t >= contenido_fin:
            datos = portada if t < portada_fin else cierre
            if instantes:
                Image.frombytes('RGB', (ANCHO, ALTO), datos).save(os.path.join(carpeta_f, f"t{t:07.2f}.png"))
                siguiente_instante += 1
            else:
                proceso.stdin.write(datos)
            continue
        while n + 1 < len(pasos) and pasos[n + 1]['inicio'] <= t:
            n += 1
        p = pasos[n]
        if t < p['inicio']:
            p = pasos[0]
        if n != n_visto:
            antes_de_paso, n_visto = ultimo, n
        img, ck = tablero.imagen(t)
        clave = ('s', ck)
        ses = next((s for s in plan['sesiones'] if s['t0'] <= t < s['t1']), None)
        if ses:
            pimg, pk = ses['tablero'].imagen(t)
            clave += (id(ses), pk)
        if clave == cuerpo_clave:
            img = cuerpo_img
        else:
            img = img.copy()          # el tablero sigue pintando sobre su imagen
            if ses:
                img.paste(pimg, ses['rect'][:2])
        if p.get('fundido') and t - p['inicio'] < FUNDIDO and antes_de_paso is not None:
            img = Image.blend(antes_de_paso, img, (t - p['inicio']) / FUNDIDO)
            clave += ('f', marco)
        else:
            ultimo = img
        tarjeta = next((c for c in tarjetas if c['c0'] <= t < c['c1']), None)
        if tarjeta:
            alfa = min(1.0, (t - tarjeta['c0']) / 0.3, (tarjeta['c1'] - t) / 0.3)
            u = min(1.0, max(0.0, (t - tarjeta['c0'] - 0.25) / 0.7))
            ct = (tarjeta['escena'], round(u * 20))
            if ct not in cache_tarjeta:
                if len(cache_tarjeta) > 40:
                    cache_tarjeta.clear()
                cache_tarjeta[ct] = pantallas.tarjeta(tarjeta['escena'], tarjeta['previa'], u)
            entero = Image.new('RGB', (ANCHO, ALTO), PAPEL)
            entero.paste(img, (0, CAB))
            img = con_tarjeta(entero, cache_tarjeta[ct], alfa).crop((0, CAB, ANCHO, ALTO))
            clave += ('t', marco)
        if clave != cuerpo_clave:
            cuerpo_clave, cuerpo_img = clave, img
            cuerpo_bytes = img.tobytes()
        escena_cab = p['escena']
        brillo, brillo_bloque = 0.0, 0.0
        primero = primer_paso[escena_cab]
        if primero.get('brillo_desde') is not None and 0 <= t - primero['brillo_desde'] < 2.0:
            brillo = round(1 - (t - primero['brillo_desde']) / 2.0, 1)
            brillo_bloque = brillo if primero.get('brillo_bloque') else 0.0
        cc = (escena_cab, int(t), p.get('parte'), brillo, brillo_bloque)
        if cc != cabecera_clave:
            cabecera_clave = cc
            cabecera_bytes = pantallas.cabecera(escena_cab, t, total, p.get('parte'), brillo, brillo_bloque).tobytes()
        if instantes:
            Image.frombytes('RGB', (ANCHO, ALTO), cabecera_bytes + cuerpo_bytes).save(
                os.path.join(carpeta_f, f"t{t:07.2f}.png"))
            siguiente_instante += 1
        else:
            proceso.stdin.write(cabecera_bytes + cuerpo_bytes)
        if marco % (FPS * 60) == 0:
            print(f'  {mmss(t)} · {escenas[p["escena"]].get("titulo") or escenas[p["escena"]]["bloque"]}', flush=True)


CLAVES_SLIDES = {
    'escena': {'bloque', 'titulo', 'apartado', 'estructura', 'guia', 'slides'},
    'slide': {'titulo', 'guia', 'pizarra', 'columnas', 'vertical', 'contenido', 'pasos'},
    'paso': {'di', 'parte', 'muestra', 'anota', 'pizarra', 'rejilla', 'conservar', 'lineas', 'borrar'},
    'elemento': {'vinetas', 'texto', 'formula', 'grafico', 'tabla', 'caja', 'cifras', 'flujo', 'id', 'col', 'capa',
                 'alto', 'pie', 'tam', 'color', 'alinear', 'centrado', 'grande', 'cursiva', 'numerada', 'cabecera',
                 'filas', 'anchos', 'destaca', 'titulo'},
    'anota': {'rodea', 'subraya', 'tacha', 'flecha', 'escribe', 'formula', 'junto', 'lado', 'desde', 'pos', 'color', 'tam',
              'largo', 'ancho'},
    'panel': {'ancho', 'lado', 'rejilla', 'lineas', 'nueva'},
}


def comprobar_slides(guion):
    avisos = []
    for k in guion:
        if k not in CLAVES_RAIZ | {'formato'}:
            avisos.append(f'clave desconocida «{k}» en escenas.yaml (se ignora)')

    def desconocidas(d, validas, donde):
        if isinstance(d, dict):
            for k in d:
                if k not in validas:
                    avisos.append(f'clave desconocida «{k}» en {donde} (se ignora)')
    for i, e in enumerate(guion.get('escenas') or [], 1):
        desconocidas(e, CLAVES_SLIDES['escena'], f'la escena {i}')
        for j, sl in enumerate(e.get('slides') or [], 1):
            donde = f'la escena {i}, slide {j}'
            desconocidas(sl, CLAVES_SLIDES['slide'], donde)
            if isinstance(sl.get('pizarra'), dict):
                desconocidas(sl['pizarra'], CLAVES_SLIDES['panel'], donde + ', pizarra')
            for el in sl.get('contenido') or []:
                desconocidas(el, CLAVES_SLIDES['elemento'], donde + ', contenido')
            for k, p in enumerate(sl.get('pasos') or [], 1):
                desconocidas(p, CLAVES_SLIDES['paso'], f'{donde}, paso {k}')
                for el in p.get('muestra') or []:
                    desconocidas(el, CLAVES_SLIDES['elemento'], f'{donde}, paso {k}, muestra')
                for a in p.get('anota') or []:
                    desconocidas(a, CLAVES_SLIDES['anota'], f'{donde}, paso {k}, anota')
                acciones = p.get('pizarra') or []
                for a in (acciones if isinstance(acciones, list) else [acciones]):
                    desconocidas(a, CLAVES_ACCION, f'{donde}, paso {k}, pizarra')
    return avisos


# --- Comprobaciones del guion ---------------------------------------------------------------------
CLAVES_RAIZ = {'tema', 'duracion', 'voz', 'pronunciacion', 'bloques', 'escenas', 'titulo', 'titulo_corto', 'lectura_titulo'}
CLAVES_ESCENA = {'bloque', 'titulo', 'apartado', 'modo', 'estructura', 'rejilla', 'conservar', 'lineas', 'pasos'}
CLAVES_PASO = {'di', 'parte', 'guion', 'apunte', 'rejilla', 'conservar', 'lineas', 'borrar', 'pizarra', 'apoyo'}
CLAVES_ACCION = {'escribe', 'formula', 'imagen', 'grafico', 'capa', 'zona', 'color', 'tam', 'alinear', 'centrar',
                 'alto', 'texto', 'sustituye'}


def comprobar_guion(guion, tema):
    """Avisos sobre escenas.yaml que no impiden montar el vídeo: claves que el script
    no conoce (se ignoran) y minutos de «bloques» distintos de los \\minutos del tema."""
    avisos = []

    def desconocidas(d, validas, donde):
        for k in d:
            if k not in validas:
                avisos.append(f'clave desconocida «{k}» en {donde} (se ignora)')
    desconocidas(guion, CLAVES_RAIZ, 'escenas.yaml')
    for i, e in enumerate(guion.get('escenas') or [], 1):
        desconocidas(e, CLAVES_ESCENA, f'la escena {i}')
        for k, p in enumerate(e.get('pasos') or [], 1):
            desconocidas(p, CLAVES_PASO, f'la escena {i}, paso {k}')
            for clave in ('pizarra', 'apoyo'):
                acciones = p.get(clave) or []
                for a in (acciones if isinstance(acciones, list) else [acciones]):
                    if isinstance(a, dict):
                        desconocidas(a, CLAVES_ACCION, f'la escena {i}, paso {k}, {clave}')
    tex = os.path.join(tema.dir, f'{tema.archivo}.tex')
    bloques = guion.get('bloques') or []
    if os.path.exists(tex) and bloques:
        texto = re.sub(r'(?<!\\)%[^\n]*', '', open(tex, encoding='utf-8').read())
        del_tema = [float(x.replace(',', '.')) for x in re.findall(r'\\minutos\{(\d+(?:[.,]\d+)?)\}', texto)]
        del_video = [float(str(b.get('minutos', 0)).replace(',', '.')) for b in bloques]
        if del_tema and (len(del_tema) != len(del_video) or any(abs(a - b) > 0.01 for a, b in zip(del_tema, del_video))):
            avisos.append('los minutos de «bloques» (' + ', '.join(f'{m:g}' for m in del_video) + ') no son los '
                          '\\minutos del tema (' + ', '.join(f'{m:g}' for m in del_tema) + ')')
    return avisos


if __name__ == '__main__':
    main()
