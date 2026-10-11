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


def trocear(texto, maximo=240):
    """XTTS funciona mejor con frases cortas: parte por frases (y por comas solo si
    una frase pasa del límite del modelo en español). Partir de más deja pausas
    raras en mitad de la frase, así que las frases cortas seguidas se juntan."""
    frases = [f for f in re.split(r'(?<=[.!?…;:])\s+', texto) if f.strip()]
    trozos = []
    for f in frases:
        while len(f) > maximo:
            corte = f.rfind(',', 0, maximo)
            corte = corte if corte > 60 else f.rfind(' ', 0, maximo)
            trozos.append(f[:corte + 1].strip())
            f = f[corte + 1:].strip()
        if f:
            if trozos and len(trozos[-1]) + len(f) < 120:
                trozos[-1] += ' ' + f
            else:
                trozos.append(f)
    return trozos


def limpiar_silencios(wav, sr=24000, umbral_db=-42, max_hueco=0.28, deja=0.18):
    """Quita el silencio del principio y del final y acorta los huecos largos en
    mitad de la frase (XTTS a veces deja silencios raros entre palabras)."""
    import numpy as np
    paso = int(sr * 0.01)
    n = len(wav) // paso
    if n == 0:
        return wav
    rms = np.sqrt(np.mean(wav[:n * paso].reshape(n, paso) ** 2, axis=1) + 1e-12)
    voz = 20 * np.log10(rms + 1e-9) > umbral_db
    if not voz.any():
        return wav
    ini, fin = np.argmax(voz), n - np.argmax(voz[::-1])
    trozos, k = [], ini
    while k < fin:
        if voz[k]:
            j = k
            while j < fin and voz[j]:
                j += 1
        else:
            j = k
            while j < fin and not voz[j]:
                j += 1
            if (j - k) * 0.01 > max_hueco:
                trozos.append(wav[k * paso:k * paso + int(sr * deja)])
                k = j
                continue
        trozos.append(wav[k * paso:j * paso])
        k = j
    return np.concatenate(trozos) if trozos else wav


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
    # Se usa toda la grabación (hasta 3 min) y no solo los primeros segundos
    latente, altavoz = modelo.get_conditioning_latents(audio_path=[muestra], max_ref_length=180,
                                                       gpt_cond_len=30, gpt_cond_chunk_len=6)
    for i, p in enumerate(pendientes, 1):
        partes = []
        for trozo in trocear(p['texto']):
            salida = modelo.inference(trozo, 'es', latente, altavoz, speed=velocidad, temperature=0.65,
                                      repetition_penalty=5.0, enable_text_splitting=False)
            partes.append(limpiar_silencios(np.asarray(salida['wav'], dtype=np.float32)))
            partes.append(np.zeros(int(24000 * 0.22), dtype=np.float32))   # pausa entre frases
        sf.write(p['wav'], np.concatenate(partes), 24000)
        print(f'  voz {i}/{len(pendientes)}', flush=True)


if __name__ == '__main__':
    main()
