#!/usr/bin/env python3
"""
Voz clonada con XTTS v2 (Coqui) para generar-video.py (voz: {motor: xtts}).
Se ejecuta con el Python de ~/.venvs/voz, que tiene torch y coqui-tts:

    ~/.venvs/voz/bin/python voz-xtts.py pendientes.json muestra.wav [velocidad]

pendientes.json es una lista de {"texto": …, "wav": ruta de salida}. La
muestra es una grabación limpia de la voz (1-3 minutos, WAV). Carga el modelo
una sola vez y sintetiza todos los fragmentos. En CPU tarda unas 5-8 veces la
duración del audio.

Licencia del modelo: Coqui Public Model License (uso no comercial).

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys

os.environ.setdefault('COQUI_TOS_AGREED', '1')


def trocear(texto, maximo=230):
    """XTTS funciona mejor con frases cortas: parte por frases y, si hace falta, por comas."""
    frases = re.split(r'(?<=[.!?…;:])\s+', texto)
    trozos = []
    for f in frases:
        while len(f) > maximo:
            corte = f.rfind(',', 0, maximo)
            corte = corte if corte > 40 else f.rfind(' ', 0, maximo)
            trozos.append(f[:corte + 1].strip())
            f = f[corte + 1:].strip()
        if f:
            trozos.append(f)
    return trozos


def main():
    pendientes = json.load(open(sys.argv[1], encoding='utf-8'))
    muestra = sys.argv[2]
    velocidad = float(sys.argv[3]) if len(sys.argv) > 3 else 1.0
    import numpy as np
    import soundfile as sf
    import torch
    from TTS.api import TTS
    torch.set_num_threads(os.cpu_count() or 4)
    tts = TTS('tts_models/multilingual/multi-dataset/xtts_v2')
    modelo = tts.synthesizer.tts_model
    latente, altavoz = modelo.get_conditioning_latents(audio_path=[muestra])
    for i, p in enumerate(pendientes, 1):
        partes = []
        for trozo in trocear(p['texto']):
            salida = modelo.inference(trozo, 'es', latente, altavoz, speed=velocidad, enable_text_splitting=False)
            partes.append(np.asarray(salida['wav'], dtype=np.float32))
            partes.append(np.zeros(int(24000 * 0.12), dtype=np.float32))
        sf.write(p['wav'], np.concatenate(partes), 24000)
        print(f'  voz {i}/{len(pendientes)}', flush=True)


if __name__ == '__main__':
    main()
