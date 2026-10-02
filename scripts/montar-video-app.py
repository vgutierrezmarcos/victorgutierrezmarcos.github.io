#!/usr/bin/env python3
"""
Monta el vídeo promocional de la app (1 minuto, 1920 × 1080, sin sonido) a
partir de las capturas de app/promo/capturas/.

    python3 scripts/montar-video-app.py [--ffmpeg RUTA] [--solo-fotogramas DIR]

Requisitos: Pillow y ffmpeg (por ejemplo, el binario estático que trae el
paquete imageio-ffmpeg). Las capturas se regeneran con
`flutter test tool/capturas_test.dart --update-goldens` desde app/.

Salida, en app/promo/: oposicion-tcee.mp4, poster.jpg y una versión ligera de
cada captura (720 px de ancho, WebP) para la página app/index.html. Los PNG
originales de app/promo/capturas/ no se suben al repositorio.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import os
import shutil
import subprocess
import sys

from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROMO = os.path.join(RAIZ, 'app', 'promo')
CAPTURAS = os.path.join(PROMO, 'capturas')
FUENTES = os.path.join(RAIZ, 'app', 'assets', 'fonts')
ICONO = os.path.join(RAIZ, 'app', 'assets', 'icon', 'icon.png')

ANCHO, ALTO, FPS, DURACION = 1920, 1080, 30, 60

# Paleta de styles.css
MORADO, MORADO_OSCURO, MORADO_CLARO = (95, 41, 135), (74, 31, 107), (122, 60, 168)
VERDE, VERDE_CLARO = (226, 239, 217), (237, 245, 231)
DORADO, DORADO_CLARO = (184, 134, 11), (218, 165, 32)
TEXTO, TEXTO_SUAVE = (45, 45, 45), (85, 85, 85)
BLANCO = (255, 255, 255)


def serif(tam, estilo='bold'):
    return ImageFont.truetype(os.path.join(FUENTES, f'texgyrepagella-{estilo}.otf'), tam)


def sans(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


# Cada escena: (inicio, fin, rótulo, título, texto, capturas)
ESCENAS = [
    (5, 12, 'HOY', 'Cada día,\nlo que toca', 'La cuenta atrás al examen y al próximo cante, el test diario, el repaso pendiente y tu racha.', ['hoy']),
    (12, 21, 'TEMARIO', 'El temario,\nordenado', 'Temas y PDF, bloques por colores y esquemas con las conexiones entre temas.', ['temario-temas', 'organizacion', 'esquema']),
    (21, 31, 'CANTES', 'Programa, sortea,\ncanta y anota', 'Agenda con avisos, sorteo como en el examen, cronómetro y diario de cantes.', ['cantes-agenda', 'cantes-cantar', 'cantes-diario']),
    (31, 38, 'TEST', 'Los test oficiales,\ncon tu historial', 'El simulador de la web en el móvil, con las mismas preguntas y el mismo historial.', ['test-pregunta', 'test-estadisticas']),
    (38, 45, 'PROBABILIDADES', '¿Qué probabilidad\nllevas?', 'La probabilidad de que salga un tema que te sabes, según los que llevas estudiados.', ['probabilidades', 'probabilidades-3d']),
    (45, 54, 'PREPARADORES', 'Tu preparador\ny tú, enlazados', 'Sesiones, sorteo y valoraciones que llegan solas a la agenda y al diario del alumno.', ['preparador', 'alumno', 'sesion']),
]
INICIO_CIERRE = 54
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
    f = degradado((ANCHO, ALTO), VERDE, VERDE_CLARO).convert('RGB')
    d = ImageDraw.Draw(f)
    # Cabecera de la web: banda morada con la línea dorada.
    f.paste(degradado((ANCHO, 84), MORADO, MORADO_OSCURO), (0, 0))
    f.paste(linea_dorada(ANCHO, 6), (0, 84))
    icono = Image.open(ICONO).convert('RGBA').resize((52, 52), Image.LANCZOS)
    f.paste(icono, (64, 16), icono)
    d.text((132, 42), 'Oposición TCEE', font=serif(34), fill=BLANCO, anchor='lm')
    d.text((ANCHO - 64, 42), 'victorgutierrezmarcos.es/app', font=sans(26, 'Medium'), fill=(255, 255, 255), anchor='rm')
    return f


def fondo_oscuro():
    f = degradado((ANCHO, ALTO), MORADO, MORADO_OSCURO)
    f.paste(linea_dorada(ANCHO, 8), (0, ALTO - 8))
    return f


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
    d.text((0, y), rotulo, font=f_rotulo, fill=MORADO)
    # Subrayado con rombo, como .section-title de la web.
    largo = round(f_rotulo.getlength(rotulo))
    y += 48
    d.rectangle((0, y, largo, y + 3), fill=MORADO)
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
        self.texto = bloque_texto(rotulo, titulo, texto, 620)
        n = len(capturas)
        ancho = {1: 400, 2: 380, 3: 318}[n]
        self.moviles = [movil(c, ancho) for c in capturas]
        m0, margen = self.moviles[0]
        paso = m0.width - 2 * margen + 34
        total = paso * (n - 1) + m0.width - 2 * margen
        # Los móviles se centran en la parte derecha de la pantalla, a partir de x = 770.
        x0 = 770 + (ANCHO - 770 - 50 - total) // 2 - margen
        self.posiciones = [(x0 + i * paso, 84 + 6 + (ALTO - 90 - m0.height) // 2 + (26 if n == 3 and i == 1 else 0)) for i in range(n)]
        # Cada móvil entra un poco después que el anterior.
        self.retrasos = [0.25 + i * (1.6 if n > 1 else 0) for i in range(n)]

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
    """0-5 s: nombre de la app sobre morado y el móvil con la pantalla de hoy."""
    a = suave(t / 0.9)
    icono = Image.open(ICONO).convert('RGBA').resize((150, 150), Image.LANCZOS)
    capa = Image.new('RGBA', (1000, 620), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    capa.paste(icono, (0, 0), icono)
    c.text((0, 200), 'Oposición TCEE', font=serif(118), fill=BLANCO)
    c.rectangle((0, 352, 420, 358), fill=DORADO_CLARO)
    c.text((0, 392), 'La oposición a Técnico Comercial', font=serif(50, 'italic'), fill=(240, 232, 248))
    c.text((0, 456), 'y Economista del Estado, en el bolsillo', font=serif(50, 'italic'), fill=(240, 232, 248))
    capa = con_opacidad(capa, a)
    lienzo.paste(capa, (120 - round(40 * (1 - a)), 230), capa)
    img, _ = PORTADA_MOVIL
    b = suave((t - 0.6) / 1.0)
    if b > 0:
        capa = con_opacidad(img, b)
        lienzo.paste(capa, (1250, 60 + round(90 * (1 - b))), capa)


def cierre(lienzo, t):
    """54-60 s: cómo conseguirla."""
    a = suave(t / 0.8)
    capa = Image.new('RGBA', (ANCHO, 700), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    icono = Image.open(ICONO).convert('RGBA').resize((170, 170), Image.LANCZOS)
    capa.paste(icono, ((ANCHO - 170) // 2, 0), icono)
    c.text((ANCHO // 2, 270), 'Oposición TCEE', font=serif(104), fill=BLANCO, anchor='mm')
    c.text((ANCHO // 2, 380), 'Gratis · Sin anuncios · Para Android', font=sans(46, 'Medium'), fill=(240, 232, 248), anchor='mm')
    c.rectangle((ANCHO // 2 - 150, 440, ANCHO // 2 + 150, 445), fill=DORADO_CLARO)
    b = suave((t - 0.9) / 0.8)
    if b > 0:
        ancho_caja = 900
        c.rounded_rectangle(((ANCHO - ancho_caja) // 2, 500, (ANCHO + ancho_caja) // 2, 610), 14, fill=tuple(round(v * b + m * (1 - b)) for v, m in zip(BLANCO, MORADO_OSCURO)) + (255,))
        c.text((ANCHO // 2, 555), 'victorgutierrezmarcos.es/app', font=sans(54, 'Semibold'), fill=MORADO + (round(255 * b),), anchor='mm')
    capa = con_opacidad(capa, a)
    lienzo.paste(capa, (0, 190 + round(30 * (1 - a))), capa)


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


def preparar():
    global FONDO_CLARO, FONDO_OSCURO, OBJ_ESCENAS, CORTES, PORTADA_MOVIL
    FONDO_CLARO, FONDO_OSCURO = fondo_claro(), fondo_oscuro()
    OBJ_ESCENAS = [Escena(*e) for e in ESCENAS]
    CORTES = [e[0] for e in ESCENAS] + [INICIO_CIERRE]
    PORTADA_MOVIL = movil('hoy', 430)


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
    args = p.parse_args()
    exportar_capturas()
    if args.solo_capturas:
        return
    preparar()

    if args.solo_fotogramas:
        os.makedirs(args.solo_fotogramas, exist_ok=True)
        for t in [0.5, 3, 5.2, 9, 14, 17, 20, 23, 26, 30, 31.2, 36, 42, 47, 50, 53, 54.3, 58]:
            fotograma(t).save(os.path.join(args.solo_fotogramas, f't{t:05.1f}.jpg'), quality=85)
        return

    if not args.ffmpeg:
        sys.exit('No se encuentra ffmpeg: indícalo con --ffmpeg o con la variable FFMPEG.')
    salida = os.path.join(PROMO, 'oposicion-tcee.mp4')
    orden = [
        args.ffmpeg, '-y', '-loglevel', 'error',
        '-f', 'rawvideo', '-pix_fmt', 'rgb24', '-s', f'{ANCHO}x{ALTO}', '-r', str(FPS), '-i', '-',
        '-c:v', 'libx264', '-preset', 'slow', '-crf', '21', '-pix_fmt', 'yuv420p', '-movflags', '+faststart', salida,
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
    fotograma(26).save(os.path.join(PROMO, 'poster.jpg'), quality=88, optimize=True)
    print(f'{salida}: {os.path.getsize(salida) / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
