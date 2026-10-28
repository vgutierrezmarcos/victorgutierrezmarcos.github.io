#!/usr/bin/env python3
"""
Banda sonora del vídeo «Prepara con Claude» (HyperFrames): la misma música
electrónica del promocional de la app (110 pulsaciones por minuto, los
instrumentos de scripts/montar-video-app.py), compuesta de una pieza para la
duración de este vídeo, sin bucles ni cortes: intro en la portada, gancho,
cuerpo con un respiro en cada cambio de bloque y secciones que alternan el
arpegio, y un final que se apaga con el cierre. Los efectos (golpes, toques,
campanas) siguen el guion de este vídeo (guion.json).

    python3 scripts/video-claude/musica.py [SALIDA.wav]

Autor: Víctor Gutiérrez Marcos
"""
import importlib.util
import json
import math
import os
import sys
import wave

import numpy as np

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(os.path.dirname(AQUI))

# Los instrumentos son los del montaje anterior (y del promocional).
_spec = importlib.util.spec_from_file_location('montaje', os.path.join(RAIZ, 'scripts', 'montar-video-app.py'))
m = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(m)

SR, PULSO, COMPAS, MEDIO = m.SR, m.PULSO, m.COMPAS, m.MEDIO

with open(os.path.join(AQUI, 'guion.json'), encoding='utf-8') as f:
    GUION = json.load(f)
DURACION = GUION['duracion']
ESCENAS = {e['id']: e['compas'] for e in GUION['escenas']}
BLOQUES = {e['id']: e['bloque'] for e in GUION['escenas']}
ORDEN = sorted(ESCENAS, key=ESCENAS.get)
CIERRE = ESCENAS['cierre']
CUERPO = ESCENAS['quehace']  # el ritmo entra al acabar el gancho
# Primer compás de cada bloque (donde pasa el barrido dorado): la música respira ahí.
CAMBIOS = [ESCENAS[e] for i, e in enumerate(ORDEN) if i and BLOQUES[e] != BLOQUES[ORDEN[i - 1]]]
RESPIROS = {c for c in CAMBIOS if CUERPO < c < CIERRE}
# Secciones con el arpegio de semicorcheas (las más activas); el resto lleva corcheas.
ARPEGIO = [(ESCENAS['cante_app'], ESCENAS['dictamen']), (ESCENAS['cronograma'], ESCENAS['carpeta']),
           (ESCENAS['movil'], ESCENAS['actualiza'])]
# Tramos más calmados: sin palmadas y bombo a la mitad (la explicación, DCE y el final).
CALMA = [(ESCENAS['porque'], ESCENAS['instalar']), (ESCENAS['cronograma_dce'], ESCENAS['cronograma_app']),
         (ESCENAS['actualiza'], CIERRE)]


def inicio(escena):
    return m.compas(ESCENAS[escena])


def en(tramos, b):
    return any(a <= b < z for a, z in tramos)


def banda_sonora(ruta):
    largo = int((DURACION + 2) * SR)
    musica, ritmo, efectos, bombos = (np.zeros(largo) for _ in range(4))

    def poner(pista, muestra, t):
        i = int(t * SR)
        j = min(largo, i + len(muestra))
        if 0 <= i < largo:
            pista[i:j] += muestra[: j - i]

    for b in range(int(math.ceil(DURACION / COMPAS))):
        t0 = m.compas(b)
        acorde = [m._nota(n) for n in m.ACORDES[b % 4]]
        raiz = m._nota(m.RAICES[b % 4])
        intro, gancho, cierre = b < ESCENAS['gancho'], ESCENAS['gancho'] <= b < CUERPO, b >= CIERRE
        cuerpo = not (intro or gancho or cierre)
        respiro, calma = b in RESPIROS, en(CALMA, b)
        vel = 0.12 if intro else (0.08 if gancho else (0.07 if cierre else (0.05 if calma else 0.04)))
        if not (cierre and b > CIERRE + 1):
            poner(musica, m._pad(acorde + [acorde[0] / 2], COMPAS + 0.4, vel), t0)
        if gancho:
            for k in range(4):
                poner(ritmo, m._bajo(raiz, PULSO, 0.16), t0 + k * PULSO)
        elif cuerpo:
            for k in range(8):
                if respiro and k % 2:
                    continue
                poner(ritmo, m._bajo(raiz * (2 if k % 4 == 3 else 1), MEDIO, 0.15 if not calma else 0.12), t0 + k * MEDIO)
        elif cierre and b == CIERRE + 1:
            # La nota final: la raíz que se apaga despacio bajo el «Empieza hoy».
            n = int(4.0 * SR)
            tt = np.arange(n) / SR
            poner(ritmo, 0.22 * (np.sin(2 * np.pi * raiz * tt) + 0.3 * np.sin(4 * np.pi * raiz * tt)) * np.exp(-tt / 1.5) * np.minimum(1.0, tt / 0.01), t0)
        if gancho and b < CUERPO - 1:
            for k in (0, 2):
                poner(bombos, m._bombo(0.3), t0 + k * PULSO)
        if cuerpo or (gancho and b == CUERPO - 1):
            for k in range(4):
                if (respiro or calma) and k % 2:
                    continue
                poner(bombos, m._bombo(0.55 if cuerpo else 0.4), t0 + k * PULSO)
        if cierre and b == CIERRE:
            poner(bombos, m._bombo(0.5), t0)
        if cuerpo:
            for k in range(4):
                poner(ritmo, m._charles(0.05 if not calma else 0.035), t0 + k * PULSO + MEDIO)
            if b >= CUERPO + 2 and not respiro and not calma:
                for k in (1, 3):
                    poner(ritmo, m._palmada(0.06), t0 + k * PULSO)
        if b < CUERPO:
            notas = [acorde[0] * 2, acorde[2] * 2, acorde[1] * 2, acorde[2] * 2]
            for k in range(8):
                poner(musica, m._pulsacion(notas[k % 4], 0.04 if intro else 0.05, 0.4), t0 + k * MEDIO)
        elif cuerpo and not respiro:
            notas = [acorde[0] * 2, acorde[1] * 2, acorde[2] * 2, acorde[1] * 2]
            if en(ARPEGIO, b):
                for k in range(16):
                    poner(musica, m._pulsacion(notas[k % 4], 0.03 + 0.008 * (k % 4 == 0)), t0 + k * PULSO / 4)
            elif not calma:
                for k in range(8):
                    poner(musica, m._pulsacion(notas[k % 4], 0.035 if k % 2 == 0 else 0.025, 0.3), t0 + k * MEDIO)

    def aviso(t, vel=0.07):
        poner(efectos, m._campana(m._nota(88), vel, 1.2), t)
        poner(efectos, m._campana(m._nota(93), vel, 1.4), t + 0.13)

    def toques(t0, n, paso, vel=0.05):
        for i in range(n):
            poner(efectos, m._toque(vel), t0 + i * paso)

    def entra_movil(t):
        poner(efectos, m._subida(300, 900, 0.5, 0.025), t)

    # Logo al empezar y al cerrar; subida hacia el cuerpo; golpe en cada cambio de bloque (el barrido dorado).
    for base, vel in ((0.0, 1.0), (m.compas(CIERRE), 1 / 1.3)):
        poner(efectos, m._golpe(0.4), base + 0.62 * vel)
        for desde, nota in ((0.5, 86), (0.68, 90), (0.86, 93)):
            poner(efectos, m._campana(m._nota(nota), 0.08), base + (desde + 0.12) * vel)
    poner(efectos, m._subida(180, 900, COMPAS * 0.9, 0.05), m.compas(CUERPO) - COMPAS * 0.9)
    poner(efectos, m._golpe(0.35), m.compas(CUERPO))
    for c in CAMBIOS:
        if CUERPO < c <= CIERRE:
            poner(efectos, m._golpe(0.28), m.compas(c))
    # Gancho: la segunda línea y el titular.
    poner(efectos, m._toque(0.05), inicio('gancho') + 1.6 * PULSO)
    aviso(inicio('gancho') + 2 * COMPAS + 0.3, 0.06)
    # Qué hace y por qué: una tarjeta, un toque.
    toques(inicio('quehace') + 0.8, 6, 0.9 * PULSO)
    toques(inicio('porque') + 0.9, 4, 1.3 * PULSO)
    # Instalar: los cuatro pasos.
    for t in (3.4, 7.8, 13.6, 17.4):
        poner(efectos, m._toque(0.045), inicio('instalar') + t)
    aviso(inicio('instalar') + 17.6, 0.05)
    # Un cante: los móviles, la pastilla del minuto y las páginas del PDF.
    entra_movil(inicio('cante_app') + 0.1)
    entra_movil(inicio('cante_app') + 0.5)
    aviso(inicio('cante_app') + 2 * PULSO, 0.06)
    for t in (10.0, 10.3):
        for k, h in enumerate((1.0, 0.45)):
            poner(efectos, m._madera(0.16 * h, 480), inicio('cante_informe') + t + k * 0.12)
    # Cronograma: exportar, DCE y traerlo a la app.
    entra_movil(inicio('cronograma') + 0.1)
    entra_movil(inicio('cronograma') + 0.5)
    entra_movil(inicio('cronograma_app') + 5.1)
    entra_movil(inicio('cronograma_app') + 5.5)
    # La carpeta: la estructura (cuatro tarjetas) y el informe que aparece.
    toques(inicio('carpeta') + 0.7, 4, 0.75 * PULSO)
    aviso(inicio('carpeta') + 16.8, 0.05)
    # El móvil: los tres teléfonos.
    for i in range(3):
        entra_movil(inicio('movil') + 0.2 + i * 0.6)
    # Y además: las seis peticiones; al día: las tres tarjetas.
    toques(inicio('ademas') + 0.8, 6, 1.1 * PULSO)
    toques(inicio('actualiza') + 0.9, 3, 1.6 * PULSO)

    golpes = np.convolve(np.abs(bombos), np.ones(int(0.01 * SR)) / int(0.01 * SR), mode='same')
    env = np.clip(golpes / (golpes.max() + 1e-9), 0, 1)
    env = np.convolve(env, np.ones(int(0.12 * SR)) / int(0.12 * SR), mode='same')
    env = np.clip(env / (env.max() + 1e-9), 0, 1)
    total = musica * (1 - 0.45 * env) + ritmo + bombos + efectos
    total = total[: int(DURACION * SR)]
    total[: int(0.05 * SR)] *= np.linspace(0, 1, int(0.05 * SR))
    fin = int(2.5 * SR)
    total[-fin:] *= np.linspace(1, 0, fin)
    total *= 0.89 / max(1e-9, np.abs(total).max())
    estereo = np.repeat((total * 32767).astype('<i2')[:, None], 2, axis=1)
    with wave.open(ruta, 'wb') as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(estereo.tobytes())


if __name__ == '__main__':
    banda_sonora(sys.argv[1] if len(sys.argv) > 1 else os.path.join(AQUI, 'assets', 'musica.wav'))
