#!/usr/bin/env python3
"""
Banda sonora del vídeo de la app (hyperframes): la misma música electrónica del
vídeo anterior (110 pulsaciones por minuto, scripts/montar-video-app.py), con
los efectos colocados según el guion nuevo (guion.json).

    python3 scripts/video-app/musica.py SALIDA.wav

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

# Los instrumentos son los del montaje anterior.
_spec = importlib.util.spec_from_file_location('montaje', os.path.join(RAIZ, 'scripts', 'montar-video-app.py'))
m = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(m)

SR, PULSO, COMPAS, MEDIO = m.SR, m.PULSO, m.COMPAS, m.MEDIO

with open(os.path.join(AQUI, 'guion.json'), encoding='utf-8') as f:
    GUION = json.load(f)
DURACION = GUION['duracion']
ESCENAS = {e['id']: e['compas'] for e in GUION['escenas']}
CIERRE = ESCENAS['cierre']
CUERPO = ESCENAS['elegir']  # el ritmo entra al acabar el gancho
RESPIRO = ESCENAS['clases']  # compás más suave: «¿Te cancelan la clase?»


def inicio(escena):
    return m.compas(ESCENAS[escena])


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
        intro, gancho, cierre = b < 2, 2 <= b < CUERPO, b >= CIERRE + 2
        cuerpo = not (intro or gancho or cierre)
        vel = 0.12 if intro else (0.04 if cuerpo else (0.08 if gancho else 0.06))
        poner(musica, m._pad(acorde + [acorde[0] / 2], COMPAS + 0.4, vel), t0)
        if gancho:
            for k in range(4):
                poner(ritmo, m._bajo(raiz, PULSO, 0.16), t0 + k * PULSO)
        elif cuerpo:
            for k in range(8):
                poner(ritmo, m._bajo(raiz * (2 if k % 4 == 3 else 1), MEDIO, 0.15), t0 + k * MEDIO)
        elif cierre and b == CIERRE + 2:
            n = int(3.0 * SR)
            tt = np.arange(n) / SR
            poner(ritmo, 0.2 * (np.sin(2 * np.pi * raiz * tt) + 0.3 * np.sin(4 * np.pi * raiz * tt)) * np.exp(-tt / 1.2) * np.minimum(1.0, tt / 0.01), t0)
        respiro = b == RESPIRO
        if gancho and b < CUERPO - 1:
            for k in (0, 2):
                poner(bombos, m._bombo(0.3), t0 + k * PULSO)
        if cuerpo or (gancho and b == CUERPO - 1):
            for k in range(4):
                if respiro and k % 2:
                    continue
                poner(bombos, m._bombo(0.55 if not gancho else 0.4), t0 + k * PULSO)
        if cuerpo:
            for k in range(4):
                poner(ritmo, m._charles(0.05), t0 + k * PULSO + MEDIO)
            if b >= CUERPO + 2 and not respiro:
                for k in (1, 3):
                    poner(ritmo, m._palmada(0.06), t0 + k * PULSO)
        if b < CUERPO:
            notas = [acorde[0] * 2, acorde[2] * 2, acorde[1] * 2, acorde[2] * 2]
            for k in range(8):
                poner(musica, m._pulsacion(notas[k % 4], 0.04 if b < 2 else 0.05, 0.4), t0 + k * MEDIO)
        if CUERPO + 2 <= b < CIERRE + 2 and not respiro:
            notas = [acorde[0] * 2, acorde[1] * 2, acorde[2] * 2, acorde[1] * 2]
            for k in range(16):
                poner(musica, m._pulsacion(notas[k % 4], 0.03 + 0.008 * (k % 4 == 0)), t0 + k * PULSO / 4)

    def aviso(t, vel=0.07):
        poner(efectos, m._campana(m._nota(88), vel, 1.2), t)
        poner(efectos, m._campana(m._nota(93), vel, 1.4), t + 0.13)

    def bolas(t0, n=2):
        for i in range(n):
            t = t0 + PULSO * (1 + i) + 0.45
            for k, h in enumerate((1.0, 0.45, 0.2)):
                poner(efectos, m._madera(0.18 * h, 480 + 60 * i), t + k * (math.pi / 7))

    # Logo al empezar y al cerrar; subida hacia el cuerpo.
    for base, vel in ((0.0, 1.0), (m.compas(CIERRE), 1 / 1.3)):
        poner(efectos, m._golpe(0.4), base + 0.62 * vel)
        for desde, nota in ((0.5, 86), (0.68, 90), (0.86, 93)):
            poner(efectos, m._campana(m._nota(nota), 0.08), base + (desde + 0.12) * vel)
    poner(efectos, m._subida(180, 900, COMPAS * 0.9, 0.05), m.compas(CUERPO) - COMPAS * 0.9)
    poner(efectos, m._golpe(0.35), m.compas(CUERPO))
    poner(efectos, m._golpe(0.3), m.compas(CIERRE))

    # Proceso selectivo: un aviso por novedad.
    c = inicio('proceso')
    poner(efectos, m._toque(0.05), c + PULSO - 0.15)
    for k in (1, 3, 5):
        aviso(c + k * PULSO, 0.06)
    # Temario revisado: el sello y los cuatro formatos.
    c = inicio('revisado')
    poner(efectos, m._golpe(0.25), c + COMPAS + 0.3)
    for i in range(4):
        poner(efectos, m._toque(0.05), c + 2 * COMPAS + 0.3 + i * MEDIO)
    # Estudiar: el trazo del fosforito.
    c = inicio('estudiar')
    poner(efectos, m._subida(220, 660, 2 * PULSO, 0.02), c + 0.9)
    # Cantes: bolas, el reloj a pulso y las estrellas.
    c = inicio('cantes')
    bolas(c)
    for k in range(8):
        poner(efectos, m._tic(0.06), c + COMPAS + k * PULSO)
    for i in range(4):
        poner(efectos, m._campana(m._nota(81 + 2 * i), 0.05, 1.0), c + 2 * COMPAS + PULSO * (1 + i * 0.5))
    # Cronograma: los ficheros aparecen y entran en el móvil.
    c = inicio('organizacion') + COMPAS
    for i in range(3):
        poner(efectos, m._toque(0.05), c + 0.3 + i * PULSO / 2)
    poner(efectos, m._subida(300, 900, 0.5, 0.025), c + 2.4 * PULSO)
    # Buscar preparador: la compatibilidad que sube y el aviso.
    c = inicio('mi_preparador')
    poner(efectos, m._subida(300, 1200, 1.0, 0.03), c + 0.6)
    aviso(c + COMPAS + 0.5)
    # Clases sueltas: los avisos y los preparadores que se encienden.
    c = inicio('clases')
    for t0 in (c + 0.35, c + 2 * COMPAS + 0.35):
        aviso(t0)
    for k in range(6):
        poner(efectos, m._toque(0.05), c + COMPAS + 0.25 + k * MEDIO)
    # Varios preparadores: las tres ideas, el aviso del tablón.
    c = inicio('varios')
    for i in range(3):
        poner(efectos, m._toque(0.05), c + 0.6 + i * 0.7 * PULSO)
    aviso(c + COMPAS + 0.5)
    # La clase al día: el aviso y las dos bolas.
    c = inicio('clase_viva')
    aviso(c + 0.35)
    bolas(c + COMPAS)
    # Pizarra: el trazo que se dibuja.
    c = inicio('pizarra')
    poner(efectos, m._subida(220, 660, 4 * PULSO, 0.025), c + 2 * PULSO)
    # Materiales: los ficheros y el aviso.
    c = inicio('materiales')
    for i in range(3):
        poner(efectos, m._toque(0.05), c + PULSO * (0.6 + i * 0.5) + 0.5)
    aviso(c + COMPAS + 0.6, 0.06)

    golpes = np.convolve(np.abs(bombos), np.ones(int(0.01 * SR)) / int(0.01 * SR), mode='same')
    env = np.clip(golpes / (golpes.max() + 1e-9), 0, 1)
    env = np.convolve(env, np.ones(int(0.12 * SR)) / int(0.12 * SR), mode='same')
    env = np.clip(env / (env.max() + 1e-9), 0, 1)
    total = musica * (1 - 0.45 * env) + ritmo + bombos + efectos
    total = total[: int(DURACION * SR)]
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


if __name__ == '__main__':
    banda_sonora(sys.argv[1] if len(sys.argv) > 1 else os.path.join(AQUI, 'assets', 'musica.wav'))
