#!/usr/bin/env python3
"""
Monta el vídeo promocional de la app (algo más de un minuto, 1920 × 1080, sin
sonido) a partir de las capturas de app/promo/capturas/.

    python3 scripts/montar-video-app.py [--ffmpeg RUTA] [--solo-fotogramas DIR]

Requisitos: Pillow y ffmpeg (por ejemplo, el binario estático que trae el
paquete imageio-ffmpeg). Las capturas se regeneran con
`flutter test tool/capturas_test.dart --update-goldens` y, las de DCE,
`flutter test tool/capturas_dce_test.dart --update-goldens`, desde app/.

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

ANCHO, ALTO, FPS, DURACION = 1920, 1080, 30, 64

# Estética neutra, común a TCEE y DCE (como PaletaNeutra de la app): la de
# styles.css en lo fundamental (Pagella, Source Sans, línea dorada), con un
# berenjena oscuro y una crema que casan con el morado de TCEE y el granate de DCE.
TINTA, TINTA_CLARA = (46, 34, 53), (67, 41, 79)
FONDO, FONDO_2 = (246, 244, 239), (238, 234, 226)
DORADO, DORADO_CLARO = (184, 134, 11), (218, 165, 32)
TEXTO, TEXTO_SUAVE = (45, 45, 45), (85, 85, 85)
BLANCO = (255, 255, 255)


def serif(tam, estilo='bold'):
    return ImageFont.truetype(os.path.join(FUENTES, f'texgyrepagella-{estilo}.otf'), tam)


def sans(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


# Cada escena: (inicio, fin, rótulo, título, texto, capturas)
# Cada escena: (inicio, fin, rótulo, título, texto, capturas). Las capturas
# están repartidas a partes iguales entre TCEE y DCE; una que empieza por «@»
# se pinta en un portátil (la app en el ordenador).
ESCENAS = [
    (5, 11, 'DOS OPOSICIONES', 'TCEE o DCE:\nelige la tuya', 'Cada una con su temario, su examen, sus probabilidades y sus preparadores, y con los colores de su web. Lo de cada una se guarda aparte.', ['elegir-oposicion', 'hoy', 'dce-hoy']),
    (11, 18, 'TEMARIO', 'Todo el temario,\ndentro de la app', 'Los PDF de TCEE y los apuntes de DCE se leen sin salir de la app, y cada tema lleva su agenda: apuntes para la próxima vuelta, vueltas y notas.', ['temario-temas', 'tema-pdf', 'dce-tema-web']),
    (18, 24, 'CANTES', 'Programa, sortea,\ncanta y anota', 'Agenda con avisos, cantes presenciales u online, sorteo como en el examen, cronómetro y diario.', ['cantes-agenda', 'dce-cantar']),
    (24, 29, 'TEST', 'Los test oficiales,\ncon tu historial', 'El simulador de la web en el móvil, con las mismas preguntas. En DCE, como práctica voluntaria.', ['test-pregunta', 'dce-test']),
    (29, 33, 'PROBABILIDADES', '¿Qué probabilidad\nllevas?', 'La de que salga un tema que te sabes, con las reglas del examen de cada oposición.', ['probabilidades', 'dce-probabilidades']),
    (33, 45, 'CLASES SUELTAS', '¿Te cancelan la clase?\nOtro preparador te la coge', 'Pide el cante a preparadores verificados: el día, una franja de horas y los temas que llevas. Quien lo coge elige la hora y os pasáis el WhatsApp.', ['cante-cancelado', 'dce-buscar-preparador', 'peticion-cogida']),
    (45, 52, 'PREPARADORES', 'Tu preparador\ny tú, enlazados', 'Su semana con todas las clases, valoraciones que llegan al alumno y el tablón de sustituciones de cada oposición.', ['dce-preparador', 'semana', 'dce-sustituciones']),
    (52, 58, 'EN EL ORDENADOR', 'También en el ordenador,\ntodo sincronizado', 'La misma app en el navegador, con tu cuenta de Google: lo que haces en el móvil aparece en el ordenador, y al revés.', ['@dce-escritorio']),
]
INICIO_CIERRE = 58
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
    f = degradado((ANCHO, ALTO), FONDO, FONDO_2).convert('RGB')
    d = ImageDraw.Draw(f)
    # Cabecera de la web: banda morada con la línea dorada.
    f.paste(degradado((ANCHO, 84), TINTA, TINTA_CLARA), (0, 0))
    f.paste(linea_dorada(ANCHO, 6), (0, 84))
    ic = icono(52)
    f.paste(ic, (64, 16), ic)
    d.text((132, 42), 'Oposición TCEE · DCE', font=serif(34), fill=BLANCO, anchor='lm')
    return f


def fondo_oscuro():
    f = degradado((ANCHO, ALTO), TINTA_CLARA, TINTA)
    f.paste(linea_dorada(ANCHO, 8), (0, ALTO - 8))
    return f


def icono(tam, sombra=False):
    """Icono de la app con la forma de los iconos de móvil: esquinas redondeadas
    (22 % del lado) y, sobre fondo oscuro, una sombra suave que lo despega."""
    img = Image.open(ICONO).convert('RGBA').resize((tam, tam), Image.LANCZOS)
    mascara = Image.new('L', (tam, tam), 0)
    ImageDraw.Draw(mascara).rounded_rectangle((0, 0, tam - 1, tam - 1), round(tam * 0.22), fill=255)
    img.putalpha(mascara)
    if not sombra:
        return img
    m = round(tam * 0.18)
    lienzo = Image.new('RGBA', (tam + 2 * m, tam + 2 * m), (0, 0, 0, 0))
    s = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(s).rounded_rectangle((m, m + round(tam * 0.05), m + tam, m + tam + round(tam * 0.05)), round(tam * 0.22), fill=150)
    s = s.filter(ImageFilter.GaussianBlur(tam * 0.08))
    lienzo.paste((10, 5, 15, 255), (0, 0), s)
    lienzo.putalpha(s)
    lienzo.paste(img, (m, m), img)
    return lienzo


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


def portatil(nombre, ancho):
    """Captura de escritorio dentro de un portátil dibujado, con su sombra. Devuelve (RGBA, margen)."""
    captura = Image.open(os.path.join(CAPTURAS, f'{nombre}.png')).convert('RGB')
    marco, margen = 22, 50
    pantalla_w = ancho - 2 * marco
    pantalla_h = round(captura.height * pantalla_w / captura.width)
    captura = captura.resize((pantalla_w, pantalla_h), Image.LANCZOS)
    tapa_h = pantalla_h + 2 * marco
    base_h, base_extra = 34, 70
    w, h = ancho + 2 * base_extra, tapa_h + base_h
    lienzo = Image.new('RGBA', (w + 2 * margen, h + 2 * margen), (0, 0, 0, 0))
    sombra = Image.new('L', lienzo.size, 0)
    ImageDraw.Draw(sombra).rounded_rectangle((margen + base_extra, margen + 20, margen + base_extra + ancho, margen + h + 16), 26, fill=120)
    sombra = sombra.filter(ImageFilter.GaussianBlur(24))
    lienzo.paste((40, 20, 60, 255), (0, 0), sombra)
    lienzo.putalpha(sombra)
    cuerpo = Image.new('RGBA', lienzo.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(cuerpo)
    x0, y0 = margen + base_extra, margen
    d.rounded_rectangle((x0, y0, x0 + ancho, y0 + tapa_h), 24, fill=(28, 22, 38, 255))
    # Base: una plancha más ancha que la tapa, con la muesca para abrirla.
    d.rounded_rectangle((margen, y0 + tapa_h - 4, margen + w, y0 + tapa_h + base_h), 16, fill=(190, 186, 196, 255))
    d.rounded_rectangle((margen + w // 2 - 90, y0 + tapa_h - 4, margen + w // 2 + 90, y0 + tapa_h + 10), 8, fill=(160, 156, 168, 255))
    lienzo = Image.alpha_composite(lienzo, cuerpo)
    lienzo.paste(captura, (x0 + marco, y0 + marco))
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
    d.text((0, y), rotulo, font=f_rotulo, fill=TINTA_CLARA)
    # Subrayado con rombo, como .section-title de la web.
    largo = round(f_rotulo.getlength(rotulo))
    y += 48
    d.rectangle((0, y, largo, y + 3), fill=TINTA_CLARA)
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
        if n == 1 and capturas[0].startswith('@'):
            img, margen = portatil(capturas[0][1:], 880)
            self.moviles = [(img, margen)]
            self.posiciones = [(770 + (ANCHO - 770 - img.width) // 2, 90 + (ALTO - 90 - img.height) // 2)]
            self.retrasos = [0.25]
            return
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
    """0-5 s: la app (icono, nombre y para qué es), sin capturas."""
    a = suave(t / 0.9)
    capa = Image.new('RGBA', (ANCHO, 900), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    ic = icono(190, sombra=True)
    capa.paste(ic, ((ANCHO - ic.width) // 2, 0), ic)
    c.text((ANCHO // 2, 330), 'Oposición TCEE · DCE', font=serif(104), fill=BLANCO, anchor='mm')
    c.rectangle((ANCHO // 2 - 160, 412, ANCHO // 2 + 160, 417), fill=DORADO_CLARO)
    c.text((ANCHO // 2, 482), 'La app para preparar las oposiciones a', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    c.text((ANCHO // 2, 540), 'Técnico Comercial y Economista del Estado', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    c.text((ANCHO // 2, 598), 'y a Diplomado Comercial del Estado', font=serif(46, 'italic'), fill=(240, 232, 248), anchor='mm')
    # Dónde se usa, en etiquetas.
    b = suave((t - 0.8) / 0.8)
    if b > 0:
        etiquetas = ['App para Android', 'En el navegador', 'Gratis']
        f = sans(38, 'Semibold')
        anchos = [f.getlength(e) + 64 for e in etiquetas]
        x = (ANCHO - sum(anchos) - 28 * (len(anchos) - 1)) / 2
        for e, w in zip(etiquetas, anchos):
            c.rounded_rectangle((x, 668, x + w, 736), 34, outline=(240, 232, 248, round(255 * b)), width=3)
            c.text((x + w / 2, 702), e, font=f, fill=(255, 255, 255, round(255 * b)), anchor='mm')
            x += w + 28
    capa = con_opacidad(capa, a)
    lienzo.paste(capa, (0, 110 + round(30 * (1 - a))), capa)


def cierre(lienzo, t):
    """58-64 s: nombre de la app y de dónde salen los apuntes."""
    a = suave(t / 0.8)
    capa = Image.new('RGBA', (ANCHO, 700), (0, 0, 0, 0))
    c = ImageDraw.Draw(capa)
    ic = icono(170, sombra=True)
    capa.paste(ic, ((ANCHO - ic.width) // 2, -31), ic)
    c.text((ANCHO // 2, 270), 'Oposición TCEE · DCE', font=serif(96), fill=BLANCO, anchor='mm')
    c.text((ANCHO // 2, 380), 'Gratis · Sin anuncios · Android y navegador', font=sans(46, 'Medium'), fill=(240, 232, 248), anchor='mm')
    c.rectangle((ANCHO // 2 - 150, 440, ANCHO // 2 + 150, 445), fill=DORADO_CLARO)
    b = suave((t - 0.9) / 0.8)
    if b > 0:
        c.text((ANCHO // 2, 520), 'Apuntes de TCEE: victorgutierrezmarcos.es  ·  Apuntes de DCE: manuelcabadogarcia.es', font=sans(36, 'Medium'), fill=(240, 232, 248, round(255 * b)), anchor='mm')
    capa = con_opacidad(capa, a)
    lienzo.paste(capa, (0, 250 + round(30 * (1 - a))), capa)


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
    global FONDO_CLARO, FONDO_OSCURO, OBJ_ESCENAS, CORTES
    FONDO_CLARO, FONDO_OSCURO = fondo_claro(), fondo_oscuro()
    OBJ_ESCENAS = [Escena(*e) for e in ESCENAS]
    CORTES = [e[0] for e in ESCENAS] + [INICIO_CIERRE]


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
        for t in [0.5, 3, 5.2, 9, 14, 17, 21, 27, 31, 36, 42, 48, 51, 55, 58.3, 62]:
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
    fotograma(3).save(os.path.join(PROMO, 'poster.jpg'), quality=88, optimize=True)
    print(f'{salida}: {os.path.getsize(salida) / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
