#!/usr/bin/env python3
"""
Pone voz a todos los vídeos de golpe (pensado para el ordenador nuevo).

Los vídeos se preparan sin audio tema a tema (generar-video.py T --borrador):
guion y escenas definitivos, revisados por Víctor. Cuando hay un ordenador con
potencia, esta orden recorre todos los temas con video/escenas.yaml y, para
cada uno, genera la voz (por fragmentos, con caché: si se corta, retoma) y
vuelve a montar el vídeo sincronizado con la voz real. El contenido es el del
borrador; solo cambian los tiempos para seguir la voz.

    python3 scripts/temario/voz-todos.py                    # todos
    python3 scripts/temario/voz-todos.py 3A08 3A09          # solo esos
    python3 scripts/temario/voz-todos.py --voz '{"motor_tts": "voxcpm2"}'
    python3 scripts/temario/voz-todos.py --listar

--voz cambia el motor o la referencia en todos los temas a la vez (el
elegido tras la comparativa de motores); sin él, se usa el `voz:` de cada
escenas.yaml. Con el motor voicestudio, el backend de VoiceStudio debe estar
arrancado antes (API en 127.0.0.1:3900). Los MP4 quedan en oposicion/temario/videos/ (fuera de git).
"""
import argparse
import glob
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import RAIZ, TEMARIO  # noqa: E402

GENERAR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'generar-video.py')


def temas_con_escenas():
    rutas = glob.glob(os.path.join(TEMARIO, 'fuentes', '*', 'video', 'escenas.yaml'))
    return sorted(os.path.basename(os.path.dirname(os.path.dirname(r))) for r in rutas)


def ejecutar(tema, extra, intentos):
    for i in range(1, intentos + 1):
        r = subprocess.run([sys.executable, GENERAR, tema] + extra, cwd=RAIZ)
        if r.returncode == 0:
            return True
        print(f'  {tema}: fallo ({i}/{intentos}); se reintenta en 20 s (la voz ya hecha se conserva)')
        time.sleep(20)
    return False


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('temas', nargs='*')
    ap.add_argument('--voz', help='JSON con la voz para todos los temas')
    ap.add_argument('--listar', action='store_true')
    ap.add_argument('--intentos', type=int, default=5)
    args = ap.parse_args()
    temas = args.temas or temas_con_escenas()
    if args.listar:
        print('\n'.join(temas))
        return
    extra = ['--voz', args.voz] if args.voz else []
    hechos, fallidos = [], []
    for t in temas:
        print(f'== {t}: voz ==', flush=True)
        if ejecutar(t, ['--medir'] + extra, args.intentos):
            print(f'== {t}: montaje ==', flush=True)
            if ejecutar(t, extra, 2):
                hechos.append(t)
                continue
        fallidos.append(t)
    print(f'Hechos: {", ".join(hechos) or "ninguno"}')
    if fallidos:
        print(f'Fallidos: {", ".join(fallidos)}')
        sys.exit(1)


if __name__ == '__main__':
    main()
