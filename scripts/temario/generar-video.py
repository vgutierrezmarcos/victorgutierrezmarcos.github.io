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

Salida (fuera de git, en oposicion/temario/videos/, que está en .gitignore):
  videos/<tema>.mp4          el vídeo
  videos/<tema>.srt          subtítulos (para YouTube)
  videos/<tema>-youtube.txt  título, descripción y capítulos para YouTube

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

    def __init__(self, spec=None, lineas=None):
        """spec: "100", "40|60(55/45)" o {columnas, filas, lineas}; lineas, si se da,
        manda sobre la del dict (así `lineas: true` puede ir junto a `rejilla: "40|60"`)."""
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
            ancho = PZ_W * c / sum(cols)
            self.columnas.append((x, x + ancho))
            x += ancho
        self.filas = {}
        for i in range(1, len(cols) + 1):
            if i in filas:
                a, b = filas[i]
                corte = PZ_H * a / (a + b)
                self.filas[i] = [(0, corte), (corte, PZ_H)]
            else:
                self.filas[i] = [(0, PZ_H)]
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
            y0, y1 = 0, PZ_H
            for c in range(c1, c2 + 1):
                celdas.extend(self.celdas_columna(c))
        return (x0, y0, x1, y1), celdas

    def segmentos(self):
        segs = [((x1, 12), (x1, PZ_H - 12)) for _, x1 in self.columnas[:-1]]
        for c, fs in self.filas.items():
            if len(fs) == 2:
                x0, x1 = self.columnas[c - 1]
                segs.append(((x0 + 14, fs[0][1]), (x1 - 14, fs[0][1])))
        return segs

    def fondo(self):
        img = Image.new('RGB', (PZ_W, PZ_H), PIZARRA)
        if self.lineas:
            d = ImageDraw.Draw(img)
            for a, b in self.segmentos():
                d.line([a, b], fill=RAYA, width=3)
        return img


# --- Pizarra: dónde va cada cosa y qué hay que dibujar -----------------------------------------
class Pizarra:
    """Coloca lo que se escribe en la rejilla (cada cosa debajo de lo último de su
    zona) y devuelve las operaciones de dibujo y de borrado para el tablero."""

    def __init__(self, tema, carpeta):
        self.tema, self.carpeta = tema, carpeta
        self.rejilla = Rejilla(None)
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
        nueva = Rejilla(spec, lineas)
        if nueva.clave == self.rejilla.clave:
            return []
        guardar = self._celdas_de(conservar)
        quedan = [e for e in self.elementos if e['celdas'] <= guardar] if guardar else []
        graficos = {n: g for n, g in self.graficos.items() if g['celdas'] <= guardar} if guardar else {}
        ops = []
        if len(quedan) < len(self.elementos) or self.rejilla.lineas:
            op = op_borrar((0, 0, PZ_W, PZ_H), Image.new('RGB', (PZ_W, PZ_H), PIZARRA))
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
            ops.append({'tipo': 'lineas', 'caja': (0, 0, PZ_W, PZ_H), 'fondo': self.fondo, 'partes': partes})
        return ops

    def borrar(self, cuales, conservar=None):
        if cuales is True or cuales == 'todo':
            zonas = None
        else:
            zonas = [str(z) for z in (cuales if isinstance(cuales, list) else [cuales])]
        if zonas is None:
            cajas, celdas = [(0, 0, PZ_W, PZ_H)], set(self.rejilla.todas())
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
        # Sin decimales y con primas, como en el tema (CRITERIOS.md): 12′05″ / 30′ · quedan 17′55″
        reloj = f'{segundos_texto(t)} / {segundos_texto(total)}   ·   quedan {segundos_texto(total - t)}'
        w_reloj = d.textlength(reloj, font=F_BARRA_L)
        d.text((ANCHO - 30 - w_reloj, 11), reloj, font=F_BARRA_L, fill=(236, 226, 246))
        d.text((x, 11), recortar(d, e.get('titulo') or e['bloque'], F_BARRA_L, ANCHO - 90 - w_reloj - x),
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
            d.text((xt, 63), recortar(d, b.get('corto') or b['nombre'], fnt, x1 - xt - 10 - ancho_min), font=fnt,
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
                texto = recortar(d, etiqueta, fnt, espacio - 60 - ancho_puntos)
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
        # Marca de agua discreta de los exclusivos, en todos los fotogramas (sobre la barra de progreso)
        if self.exclusivo:
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
            d.text((x + 36, ys[k]), recortar(d, texto, fnt, ancho - x - 90), font=fnt, fill=color)
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
    for aviso in comprobar_guion(guion, tema):
        print('AVISO:', aviso, flush=True)
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
        ops_m, _, avisos_m, _, _ = planificar(prueba, total - CIERRE)
        programar(ops_m, avisos_m)
        for aviso in dict.fromkeys(avisos_m):
            print('AVISO:', aviso)
        print(f'{len(set(avisos_m))} avisos de pizarra')
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
                    f'con el guion y la pizarra.\n\nLa guía completa, en la app Oposición TCEE: '
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
