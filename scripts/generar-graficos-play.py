#!/usr/bin/env python3
"""
Genera los gráficos de la ficha de Google Play en app/play-store/graficos/, a
partir de las capturas de app/promo/capturas/ (las mismas del vídeo; ver
scripts/montar-video-app.py) y con su misma estética neutra:

    icono-512.png            icono de la app (512 × 512, PNG de 32 bits)
    grafico-destacado.png    gráfico destacado (1024 × 500)
    capturas/01.png … 08.png capturas del teléfono (1080 × 1920, 9:16), con un
                             rótulo; mitad de TCEE y mitad de DCE

    python3 scripts/generar-graficos-play.py

Google Play no admite capturas con un lado más del doble que el otro (las de
la app son 1080 × 2340), por eso van dentro de un móvil sobre un fondo 9:16.

Autor: Víctor Gutiérrez Marcos
"""
import importlib.util
import os

from PIL import Image, ImageDraw

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SALIDA = os.path.join(RAIZ, 'app', 'play-store', 'graficos')

# Reutiliza las piezas del montaje del vídeo (fuentes, colores, móvil, icono).
_spec = importlib.util.spec_from_file_location('montaje', os.path.join(RAIZ, 'scripts', 'montar-video-app.py'))
v = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(v)

# (captura, rótulo en dos líneas). Cuatro de TCEE y cuatro de DCE, alternas
# (Play admite hasta ocho capturas de teléfono).
CAPTURAS = [
    ('hoy', 'Cada día,\nlo que toca'),
    ('dce-tema-web', 'Todo el temario,\ndentro de la app'),
    ('dce-cantar', 'Saca bola y canta\ncomo en el examen'),
    ('cronograma-revisar', 'Tu cronograma,\no el que ya tienes'),
    ('dce-probabilidades', '¿Qué probabilidad\nllevas?'),
    ('mi-preparador', 'Tu preparador\ny tú, conectados'),
    ('cante-cancelado', '¿Te cancelan la clase?\nOtro preparador te la coge'),
    ('dce-hoy-preparador', '¿Preparas a opositores?\nLo tuyo, al abrir la app'),
]


def fondo(ancho, alto):
    f = v.degradado((ancho, alto), v.FONDO, v.FONDO_2, vertical=True).convert('RGB')
    return f


def captura_play(nombre, rotulo, ruta):
    ancho, alto = 1080, 1920
    img = fondo(ancho, alto)
    d = ImageDraw.Draw(img)
    # Banda superior berenjena con la línea dorada y el rótulo.
    banda = 430
    img.paste(v.degradado((ancho, banda), v.TINTA, v.TINTA_CLARA), (0, 0))
    img.paste(v.linea_dorada(ancho, 8), (0, banda))
    tam = 74
    while max(v.serif(tam).getlength(l) for l in rotulo.split('\n')) > ancho - 120:
        tam -= 2
    lineas = rotulo.split('\n')
    y = banda / 2 - (len(lineas) - 1) * tam * 0.62
    for l in lineas:
        d.text((ancho / 2, y), l, font=v.serif(tam), fill=v.BLANCO, anchor='mm')
        y += tam * 1.24
    # El móvil, centrado y cortado por abajo, como asomando.
    movil, margen = v.movil(nombre, 760)
    x = (ancho - movil.width) // 2
    img.paste(movil, (x, banda + 40 - margen), movil)
    img.save(ruta)


def grafico_destacado(ruta):
    ancho, alto = 1024, 500
    img = v.degradado((ancho, alto), v.TINTA_CLARA, v.TINTA).convert('RGB')
    img.paste(v.linea_dorada(ancho, 6), (0, alto - 6))
    d = ImageDraw.Draw(img)
    ic = v.icono(150, sombra=True)
    img.paste(ic, (60, (alto - ic.height) // 2 - 10), ic)
    d.text((270, 196), 'Oposición TCEE · DCE', font=v.serif(58), fill=v.BLANCO, anchor='lm')
    d.rectangle((270, 242, 470, 246), fill=v.DORADO_CLARO)
    d.text((270, 296), 'Cantes, temario, test y preparadores', font=v.serif(34, 'italic'), fill=(240, 232, 248), anchor='lm')
    img.save(ruta)


def icono_512(ruta):
    # Play redondea él mismo las esquinas: va el icono cuadrado, sin transparencias.
    Image.open(v.ICONO).convert('RGB').resize((512, 512), Image.LANCZOS).save(ruta)


def main():
    os.makedirs(os.path.join(SALIDA, 'capturas'), exist_ok=True)
    icono_512(os.path.join(SALIDA, 'icono-512.png'))
    grafico_destacado(os.path.join(SALIDA, 'grafico-destacado.png'))
    for i, (nombre, rotulo) in enumerate(CAPTURAS, 1):
        captura_play(nombre, rotulo, os.path.join(SALIDA, 'capturas', f'{i:02}.png'))
    print('Gráficos en', SALIDA)


if __name__ == '__main__':
    main()
