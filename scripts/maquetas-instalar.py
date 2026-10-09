#!/usr/bin/env python3
"""
Pantallas de los vídeos de ayuda sobre cómo instalar la app (Android, iPhone,
Windows y Mac): maquetas sencillas de la tienda, el navegador y el sistema,
dibujadas aquí, y las capturas reales de la app en DCE.

    python3 scripts/maquetas-instalar.py

Necesita las capturas de la app (app/promo/capturas/: elegir-oposicion,
elegir-papel, dce-hoy y dce-escritorio, de tool/capturas_test.dart y
tool/capturas_dce_test.dart) y la de la guía de instalación en el móvil
(app/promo/ayuda/fuentes/instalar-movil.png). Deja cada vídeo en
app/promo/ayuda/capturas/instalar-<dispositivo>/, con su pasos.json (dónde se
toca en cada pantalla), igual que tool/capturas_ayuda_test.dart; el montaje es
el de scripts/montar-videos-ayuda.py.

Las maquetas no copian ninguna marca: tienda, navegador y escritorio son
genéricos, con los textos que se ven en español.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os

from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
APP = os.path.join(RAIZ, 'app')
CAPTURAS_APP = os.path.join(APP, 'promo', 'capturas')
SALIDA = os.path.join(APP, 'promo', 'ayuda', 'capturas')
FUENTES = os.path.join(APP, 'assets', 'fonts')
ICONO = os.path.join(APP, 'assets', 'icon', 'icon.png')
GUIA = os.path.join(APP, 'promo', 'ayuda', 'fuentes', 'instalar-movil.png')

M_ANCHO, M_ALTO = 1080, 2340          # móvil (como las capturas de la app)
E_ANCHO, E_ALTO = 2880, 1800          # escritorio

NEGRO, GRIS, GRIS_CLARO, LINEA = (32, 33, 36), (95, 99, 104), (241, 243, 244), (218, 220, 224)
VERDE, AZUL, BLANCO = (1, 120, 85), (11, 87, 208), (255, 255, 255)
DCE = (122, 31, 75)
NOMBRE = 'Oposición TCEE · DCE'
CORTO = 'TCEE · DCE'


def sans(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


def icono(tam):
    img = Image.open(ICONO).convert('RGBA').resize((tam, tam), Image.LANCZOS)
    m = Image.new('L', (tam, tam), 0)
    ImageDraw.Draw(m).rounded_rectangle((0, 0, tam - 1, tam - 1), round(tam * 0.22), fill=255)
    img.putalpha(m)
    return img


def app(nombre):
    return Image.open(os.path.join(CAPTURAS_APP, f'{nombre}.png')).convert('RGB')


def lienzo(w=M_ANCHO, h=M_ALTO, color=BLANCO):
    return Image.new('RGB', (w, h), color)


def barra_estado(img, oscura=False, alto=84):
    d = ImageDraw.Draw(img)
    c = BLANCO if oscura else NEGRO
    d.text((60, alto / 2), '10:30', font=sans(40, 'Semibold'), fill=c, anchor='lm')
    x = img.width - 60
    d.rounded_rectangle((x - 62, alto / 2 - 16, x, alto / 2 + 16), 7, outline=c, width=4)
    d.rectangle((x - 56, alto / 2 - 10, x - 18, alto / 2 + 10), fill=c)


def boton(d, caja, texto, fondo, color=BLANCO, radio=None, borde=None, tam=44):
    x0, y0, x1, y1 = caja
    d.rounded_rectangle(caja, radio if radio is not None else (y1 - y0) // 2, fill=fondo, outline=borde, width=4 if borde else 0)
    d.text(((x0 + x1) / 2, (y0 + y1) / 2), texto, font=sans(tam, 'Semibold'), fill=color, anchor='mm')
    return [x0, y0, x1 - x0, y1 - y0]


def oscurecer(img, alfa=110):
    capa = Image.new('RGB', img.size, (0, 0, 0))
    return Image.blend(img, capa, alfa / 255)


def tarjeta(img, caja, radio=48, color=BLANCO):
    s = Image.new('L', img.size, 0)
    ImageDraw.Draw(s).rounded_rectangle((caja[0], caja[1] + 14, caja[2], caja[3] + 14), radio, fill=90)
    s = s.filter(ImageFilter.GaussianBlur(24))
    img.paste((0, 0, 0), (0, 0), s)
    ImageDraw.Draw(img).rounded_rectangle(caja, radio, fill=color)


def guardar(video, pasos):
    """pasos: [(nombre, imagen, toque o None)]"""
    carpeta = os.path.join(SALIDA, video)
    os.makedirs(carpeta, exist_ok=True)
    datos = []
    for nombre, img, toque in pasos:
        img.save(os.path.join(carpeta, f'{nombre}.png'), optimize=True)
        datos.append({'paso': nombre, **({'toque': [round(v) for v in toque]} if toque else {})})
    with open(os.path.join(carpeta, 'pasos.json'), 'w', encoding='utf-8') as f:
        json.dump(datos, f, ensure_ascii=False, indent=2)
    print(f'{video}: {len(pasos)} pantallas')


# Dónde se toca en las capturas de la app (en píxeles de la captura de 1080 × 2340).
TOQUE_DCE = [54, 1053, 978, 270]        # tarjeta DCE en «¿Qué oposición?»
TOQUE_OPOSITOR = [54, 696, 974, 261]   # «Me preparo la oposición»


def pantallas_app():
    """La app al abrirse por primera vez, eligiendo DCE."""
    return [
        ('elegir', app('elegir-oposicion'), TOQUE_DCE),
        ('papel', app('elegir-papel'), TOQUE_OPOSITOR),
        ('hoy', app('dce-hoy'), None),
    ]


# ===================================================================== Android
def ficha_tienda(abrir=False):
    img = lienzo()
    barra_estado(img)
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((40, 110, 1040, 230), 60, fill=GRIS_CLARO)
    d.text((100, 170), '←', font=sans(50), fill=NEGRO, anchor='lm')
    d.text((180, 170), 'Oposición TCEE · DCE', font=sans(44), fill=NEGRO, anchor='lm')
    ic = icono(210)
    img.paste(ic, (60, 290), ic)
    d.text((310, 300), NOMBRE, font=sans(54, 'Semibold'), fill=NEGRO)
    d.text((310, 378), 'Víctor Gutiérrez Marcos', font=sans(38, 'Semibold'), fill=VERDE)
    d.text((310, 432), 'Educación · Gratis, sin anuncios', font=sans(36), fill=GRIS)
    if abrir:
        boton(d, (60, 580, 525, 700), 'Desinstalar', BLANCO, VERDE, borde=LINEA)
        toque = boton(d, (555, 580, 1020, 700), 'Abrir', VERDE)
    else:
        toque = boton(d, (60, 580, 1020, 700), 'Instalar', VERDE)
    # Las capturas de la ficha: las de DCE.
    for i, n in enumerate(['dce-hoy', 'elegir-oposicion', 'dce-temario']):
        c = app(n).resize((300, 650), Image.LANCZOS)
        m = Image.new('L', c.size, 0)
        ImageDraw.Draw(m).rounded_rectangle((0, 0, 299, 649), 24, fill=255)
        img.paste(c, (60 + i * 330, 780), m)
    d.text((60, 1500), 'Información de la app', font=sans(46, 'Semibold'), fill=NEGRO)
    for k, l in enumerate(['Prepara TCEE y DCE: temario, cantes, test,', 'cronograma y tu preparador, en el móvil.']):
        d.text((60, 1580 + k * 56), l, font=sans(38), fill=GRIS)
    return img, toque


def con_navegador(pagina, url, desplaza=0):
    """Página dentro de un navegador de móvil (barra de dirección arriba)."""
    img = lienzo()
    barra_estado(img)
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((40, 100, 1040, 210), 55, fill=GRIS_CLARO)
    d.text((100, 155), url, font=sans(40), fill=NEGRO, anchor='lm')
    img.paste(pagina.crop((0, desplaza, M_ANCHO, desplaza + M_ALTO - 230)), (0, 230))
    return img, 230 - desplaza


def dialogo(base, titulo, texto, botones, icono_app=False):
    """Diálogo del sistema centrado; devuelve la imagen y el rectángulo de cada botón."""
    img = oscurecer(base)
    caja = (90, 760, 990, 1500 if icono_app else 1360)
    tarjeta(img, caja, 56, (248, 249, 250))
    d = ImageDraw.Draw(img)
    y = caja[1] + 60
    if icono_app:
        ic = icono(150)
        img.paste(ic, ((M_ANCHO - 150) // 2, y), ic)
        y += 180
        d.text((M_ANCHO / 2, y), NOMBRE, font=sans(46, 'Semibold'), fill=NEGRO, anchor='mt')
        y += 80
    else:
        d.text((150, y), titulo, font=sans(50, 'Semibold'), fill=NEGRO)
        y += 100
    for l in texto:
        d.text((M_ANCHO / 2 if icono_app else 150, y), l, font=sans(40), fill=GRIS, anchor='mt' if icono_app else 'la')
        y += 56
    rects = []
    x = caja[2] - 60
    for t in reversed(botones):
        w = round(sans(44, 'Semibold').getlength(t)) + 70
        rects.insert(0, boton(d, (x - w, caja[3] - 140, x, caja[3] - 50), t, (248, 249, 250), AZUL))
        x -= w + 20
    return img, rects


def ajustes(permitido):
    img = lienzo()
    barra_estado(img)
    d = ImageDraw.Draw(img)
    d.text((60, 170), '←', font=sans(56), fill=NEGRO, anchor='lm')
    d.text((60, 300), 'Instalar aplicaciones', font=sans(66, 'Semibold'), fill=NEGRO)
    d.text((60, 380), 'desconocidas', font=sans(66, 'Semibold'), fill=NEGRO)
    d.ellipse((60, 520, 180, 640), fill=(66, 133, 244))
    d.ellipse((95, 555, 145, 605), fill=BLANCO)
    d.text((210, 545), 'Navegador', font=sans(48, 'Semibold'), fill=NEGRO)
    d.text((210, 605), 'Versión de la app', font=sans(36), fill=GRIS)
    d.line((60, 720, 1020, 720), fill=LINEA, width=3)
    d.text((60, 800), 'Permitir de esta fuente', font=sans(46), fill=NEGRO)
    x0, y0 = 860, 780
    d.rounded_rectangle((x0, y0, x0 + 160, y0 + 84), 42, fill=AZUL if permitido else (205, 208, 213))
    cx = x0 + 118 if permitido else x0 + 42
    d.ellipse((cx - 32, y0 + 10, cx + 32, y0 + 74), fill=BLANCO)
    for k, l in enumerate(['Las aplicaciones de esta fuente pueden dañar', 'tu teléfono. Instala solo las que conozcas.']):
        d.text((60, 920 + k * 54), l, font=sans(36), fill=GRIS)
    return img, [x0, y0, 160, 84], [30, 120, 100, 100]


def android():
    pasos = []
    tienda, toque = ficha_tienda()
    pasos.append(('tienda', tienda, toque))
    abrir, toque = ficha_tienda(abrir=True)
    pasos.append(('abrir', abrir, toque))
    pasos += pantallas_app()
    # Mientras tanto, desde la web.
    guia = Image.open(GUIA).convert('RGB').resize((M_ANCHO, M_ALTO))
    web, dy = con_navegador(guia, 'victorgutierrezmarcos.es/app/instalar.html')
    boton_web = [66, 875 + dy, 500, 125]
    pasos.append(('web', web, boton_web))
    descarga = web.copy()
    tarjeta(descarga, (40, 2040, 1040, 2230), 30, (48, 49, 52))
    d = ImageDraw.Draw(descarga)
    d.text((90, 2100), 'Archivo descargado', font=sans(40, 'Semibold'), fill=BLANCO)
    d.text((90, 2155), 'oposicion-tcee.apk', font=sans(36), fill=(200, 200, 200))
    d.text((960, 2135), 'Abrir', font=sans(44, 'Semibold'), fill=(138, 180, 248), anchor='rm')
    pasos.append(('descarga', descarga, [820, 2085, 160, 100]))
    fuente, (cancelar, configuracion) = dialogo(web, 'Instalar apps desconocidas', ['Por tu seguridad, tu teléfono no puede', 'instalar aplicaciones desconocidas', 'de esta fuente.'], ['Cancelar', 'Configuración'])
    pasos.append(('fuente', fuente, configuracion))
    sin, interruptor, _ = ajustes(False)
    pasos.append(('permitir', sin, interruptor))
    con, _, atras = ajustes(True)
    pasos.append(('permitido', con, atras))
    instalar, (_, inst) = dialogo(web, '', ['¿Quieres instalar esta aplicación?'], ['Cancelar', 'Instalar'], icono_app=True)
    pasos.append(('instalar', instalar, inst))
    hecha, (_, abrir_apk) = dialogo(web, '', ['Aplicación instalada.'], ['Hecho', 'Abrir'], icono_app=True)
    pasos.append(('instalada', hecha, abrir_apk))
    guardar('instalar-android', pasos)


# ====================================================================== iPhone
def safari(contenido, hoja=None):
    """La app abierta en el navegador del iPhone, con la barra abajo."""
    img = lienzo(color=(246, 246, 246))
    barra_estado(img)
    img.paste(contenido.resize((M_ANCHO, round(contenido.height * M_ANCHO / contenido.width))).crop((0, 0, M_ANCHO, M_ALTO - 380)), (0, 90))
    d = ImageDraw.Draw(img)
    d.rectangle((0, M_ALTO - 300, M_ANCHO, M_ALTO), fill=(246, 246, 246))
    d.rounded_rectangle((50, M_ALTO - 285, 1030, M_ALTO - 175), 30, fill=BLANCO)
    d.text((M_ANCHO / 2, M_ALTO - 230), 'victorgutierrezmarcos.es', font=sans(40), fill=NEGRO, anchor='mm')
    # Barra de herramientas: atrás, adelante, compartir, libro, pestañas.
    y = M_ALTO - 95
    for x in (120, 330):
        d.text((x, y), '‹' if x == 120 else '›', font=sans(80), fill=AZUL if x == 120 else (180, 180, 180), anchor='mm')
    cx = 540
    d.rounded_rectangle((cx - 30, y - 22, cx + 30, y + 38), 8, outline=AZUL, width=6)
    d.rectangle((cx - 14, y - 26, cx + 14, y - 16), fill=(246, 246, 246))
    d.line((cx, y - 52, cx, y + 8), fill=AZUL, width=6)
    d.line((cx - 18, y - 34, cx, y - 52), fill=AZUL, width=6)
    d.line((cx + 18, y - 34, cx, y - 52), fill=AZUL, width=6)
    d.rounded_rectangle((720, y - 30, 790, y + 30), 8, outline=AZUL, width=6)
    d.rounded_rectangle((920, y - 30, 980, y + 30), 8, outline=AZUL, width=6)
    return img, [cx - 70, y - 80, 140, 140]


def hoja_compartir(base):
    img = oscurecer(base, 90)
    caja = (0, 900, M_ANCHO, M_ALTO + 60)
    tarjeta(img, caja, 50, (242, 242, 247))
    d = ImageDraw.Draw(img)
    ic = icono(130)
    img.paste(ic, (60, 960), ic)
    d.text((220, 985), 'Oposición DCE', font=sans(44, 'Semibold'), fill=NEGRO)
    d.text((220, 1045), 'victorgutierrezmarcos.es', font=sans(36), fill=GRIS)
    filas = ['Copiar', 'Añadir a la lista de lectura', 'Añadir a favoritos', 'Añadir a pantalla de inicio', 'Buscar en la página']
    y = 1180
    toque = None
    d.rounded_rectangle((40, y, 1040, y + 5 * 130), 30, fill=BLANCO)
    for i, f in enumerate(filas):
        yy = y + i * 130
        if i:
            d.line((80, yy, 1040, yy), fill=LINEA, width=2)
        d.text((80, yy + 65), f, font=sans(44), fill=NEGRO, anchor='lm')
        if f == 'Añadir a pantalla de inicio':
            d.rounded_rectangle((930, yy + 35, 990, yy + 95), 12, outline=NEGRO, width=5)
            d.line((960, yy + 50, 960, yy + 80), fill=NEGRO, width=5)
            d.line((945, yy + 65, 975, yy + 65), fill=NEGRO, width=5)
            toque = [40, yy, 1000, 130]
    return img, toque


def pantalla_anadir():
    img = lienzo(color=(242, 242, 247))
    barra_estado(img)
    d = ImageDraw.Draw(img)
    d.text((60, 170), 'Cancelar', font=sans(44), fill=AZUL, anchor='lm')
    d.text((M_ANCHO / 2, 170), 'Añadir a inicio', font=sans(44, 'Semibold'), fill=NEGRO, anchor='mm')
    d.text((1020, 170), 'Añadir', font=sans(44, 'Semibold'), fill=AZUL, anchor='rm')
    d.rounded_rectangle((40, 280, 1040, 560), 30, fill=BLANCO)
    ic = icono(180)
    img.paste(ic, (80, 330), ic)
    d.text((300, 370), CORTO, font=sans(48), fill=NEGRO)
    d.line((300, 450, 1000, 450), fill=LINEA, width=2)
    d.text((300, 475), 'victorgutierrezmarcos.es/app/abrir/', font=sans(34), fill=GRIS)
    d.text((60, 620), 'Se añadirá un icono a tu pantalla de inicio para', font=sans(36), fill=GRIS)
    d.text((60, 670), 'que puedas acceder rápidamente a esta web.', font=sans(36), fill=GRIS)
    return img, [900, 120, 160, 100]


def inicio_iphone():
    img = Image.new('RGB', (M_ANCHO, M_ALTO))
    fondo = Image.linear_gradient('L').resize((M_ANCHO, M_ALTO))
    img = Image.composite(Image.new('RGB', img.size, (60, 40, 90)), Image.new('RGB', img.size, (150, 120, 170)), fondo)
    barra_estado(img, oscura=True)
    d = ImageDraw.Draw(img)
    colores = [(76, 175, 80), (33, 150, 243), (255, 152, 0), (233, 30, 99), (0, 150, 136), (121, 85, 72), (96, 125, 139), (255, 193, 7)]
    tam, paso_x, paso_y = 190, 250, 300
    x0, y0 = 75, 220
    for i, c in enumerate(colores):
        x, y = x0 + (i % 4) * paso_x, y0 + (i // 4) * paso_y
        d.rounded_rectangle((x, y, x + tam, y + tam), 44, fill=c)
        d.rounded_rectangle((x + 60, y + 60, x + 130, y + 130), 16, fill=(255, 255, 255, 180))
    x, y = x0, y0 + 2 * paso_y
    ic = icono(tam)
    img.paste(ic, (x, y), ic)
    d.text((x + tam / 2, y + tam + 34), CORTO, font=sans(34, 'Semibold'), fill=BLANCO, anchor='mm')
    return img, [x, y, tam, tam]


def iphone():
    pasos = []
    base, compartir = safari(app('elegir-oposicion'))
    pasos.append(('safari', base, compartir))
    hoja, anadir = hoja_compartir(base)
    pasos.append(('compartir', hoja, anadir))
    nombre, boton_anadir = pantalla_anadir()
    pasos.append(('anadir', nombre, boton_anadir))
    inicio, icono_toque = inicio_iphone()
    pasos.append(('inicio', inicio, icono_toque))
    pasos += pantallas_app()
    guardar('instalar-iphone', pasos)


# ================================================================== Escritorio
def ventana_app(img, caja, titulo_barra=None, navegador=True, url='victorgutierrezmarcos.es/app/abrir/'):
    """Ventana con la app de DCE (la del ordenador). Devuelve dónde acaba la barra de dirección."""
    x0, y0, x1, y1 = caja
    tarjeta(img, caja, 20, BLANCO)
    d = ImageDraw.Draw(img)
    alto_barra = 0
    if navegador:
        d.rounded_rectangle((x0, y0, x1, y0 + 200), 20, fill=(222, 225, 230))
        d.rectangle((x0, y0 + 180, x1, y0 + 200), fill=(222, 225, 230))
        d.rounded_rectangle((x0 + 40, y0 + 20, x0 + 620, y0 + 90), 16, fill=BLANCO)
        ic = icono(44)
        img.paste(ic, (x0 + 64, y0 + 33), ic)
        d.text((x0 + 130, y0 + 55), 'Oposición DCE', font=sans(36), fill=NEGRO, anchor='lm')
        d.rectangle((x0, y0 + 100, x1, y0 + 200), fill=BLANCO)
        d.rounded_rectangle((x0 + 220, y0 + 115, x1 - 260, y0 + 185), 35, fill=GRIS_CLARO)
        d.text((x0 + 270, y0 + 150), url, font=sans(36), fill=NEGRO, anchor='lm')
        alto_barra = 200
    else:
        d.rounded_rectangle((x0, y0, x1, y0 + 90), 20, fill=DCE)
        d.rectangle((x0, y0 + 70, x1, y0 + 90), fill=DCE)
        ic = icono(48)
        img.paste(ic, (x0 + 30, y0 + 21), ic)
        d.text((x0 + 100, y0 + 45), titulo_barra or CORTO, font=sans(36, 'Semibold'), fill=BLANCO, anchor='lm')
        # Cerrar, maximizar y minimizar, dibujados (la fuente no trae esos símbolos).
        cx, cy = x1 - 60, y0 + 45
        d.line((cx - 14, cy - 14, cx + 14, cy + 14), fill=BLANCO, width=4)
        d.line((cx - 14, cy + 14, cx + 14, cy - 14), fill=BLANCO, width=4)
        d.rectangle((cx - 104, cy - 14, cx - 76, cy + 14), outline=BLANCO, width=4)
        d.line((cx - 194, cy, cx - 166, cy), fill=BLANCO, width=4)
        alto_barra = 90
    contenido = app('dce-escritorio')
    w = x1 - x0
    h = y1 - y0 - alto_barra
    c = contenido.resize((w, round(contenido.height * w / contenido.width)), Image.LANCZOS).crop((0, 0, w, h))
    img.paste(c, (x0, y0 + alto_barra))
    return x1 - 260, y0 + 115


def escritorio_windows(icono_barra=False):
    img = Image.composite(Image.new('RGB', (E_ANCHO, E_ALTO), (180, 200, 230)), Image.new('RGB', (E_ANCHO, E_ALTO), (90, 120, 180)),
                          Image.linear_gradient('L').resize((E_ANCHO, E_ALTO)))
    d = ImageDraw.Draw(img)
    d.rectangle((0, E_ALTO - 110, E_ANCHO, E_ALTO), fill=(243, 243, 243))
    xs = [E_ANCHO / 2 + (k - 3) * 110 for k in range(7 if icono_barra else 6)]
    colores = [(0, 120, 212), (255, 185, 0), (16, 124, 16), (0, 99, 177), (180, 0, 158), (90, 90, 90)]
    for k, x in enumerate(xs):
        if k < len(colores):
            d.rounded_rectangle((x - 34, E_ALTO - 89, x + 34, E_ALTO - 21), 14, fill=colores[k])
    toque = None
    if icono_barra:
        x = xs[-1]
        ic = icono(68)
        img.paste(ic, (round(x - 34), E_ALTO - 89), ic)
        d.rounded_rectangle((x - 16, E_ALTO - 12, x + 16, E_ALTO - 6), 3, fill=(0, 103, 192))
        toque = [x - 50, E_ALTO - 105, 100, 100]
    return img, toque


def icono_instalar(d, x, y, color=NEGRO):
    """Icono de «instalar app» de la barra de dirección (tres cuadrados y un más)."""
    for dx, dy in ((0, 0), (34, 0), (0, 34)):
        d.rounded_rectangle((x + dx, y + dy, x + dx + 26, y + dy + 26), 5, outline=color, width=4)
    d.line((x + 47, y + 34, x + 47, y + 60), fill=color, width=4)
    d.line((x + 34, y + 47, x + 60, y + 47), fill=color, width=4)


def windows():
    pasos = []
    img, _ = escritorio_windows()
    caja = (160, 80, E_ANCHO - 160, E_ALTO - 170)
    xr, yb = ventana_app(img, caja)
    d = ImageDraw.Draw(img)
    ix, iy = xr - 80, yb + 6
    icono_instalar(d, ix, iy)
    toque = [ix - 20, iy - 20, 100, 100]
    pasos.append(('navegador', img.copy(), toque))
    # Ventana emergente «Instalar aplicación».
    pop = img.copy()
    px1, py0 = xr + 60, yb + 100
    px0 = px1 - 900
    tarjeta(pop, (px0, py0, px1, py0 + 520), 24, BLANCO)
    d = ImageDraw.Draw(pop)
    d.text((px0 + 50, py0 + 50), 'Instalar aplicación', font=sans(48, 'Semibold'), fill=NEGRO)
    ic = icono(110)
    pop.paste(ic, (px0 + 50, py0 + 150), ic)
    d.text((px0 + 190, py0 + 160), CORTO, font=sans(44, 'Semibold'), fill=NEGRO)
    d.text((px0 + 190, py0 + 220), 'victorgutierrezmarcos.es', font=sans(36), fill=GRIS)
    inst = boton(d, (px1 - 560, py0 + 380, px1 - 300, py0 + 470), 'Instalar', AZUL, radio=12, tam=40)
    boton(d, (px1 - 280, py0 + 380, px1 - 50, py0 + 470), 'Cancelar', GRIS_CLARO, NEGRO, radio=12, tam=40)
    pasos.append(('instalar', pop, inst))
    # La app en su propia ventana y en la barra de tareas.
    sola, toque_barra = escritorio_windows(icono_barra=True)
    ventana_app(sola, (260, 120, E_ANCHO - 260, E_ALTO - 200), navegador=False)
    pasos.append(('app', sola, toque_barra))
    guardar('instalar-windows', pasos)


def escritorio_mac(con_dock_icono=False):
    img = Image.composite(Image.new('RGB', (E_ANCHO, E_ALTO), (230, 170, 140)), Image.new('RGB', (E_ANCHO, E_ALTO), (110, 80, 150)),
                          Image.linear_gradient('L').resize((E_ANCHO, E_ALTO)))
    d = ImageDraw.Draw(img)
    d.rectangle((0, 0, E_ANCHO, 64), fill=(236, 236, 236))
    menus = ['Safari', 'Archivo', 'Edición', 'Visualización', 'Historial', 'Marcadores', 'Ventana', 'Ayuda']
    x = 90
    rects = {}
    d.ellipse((34, 18, 62, 46), fill=NEGRO)
    for m in menus:
        f = sans(36, 'Semibold' if m == 'Safari' else 'Regular')
        w = f.getlength(m)
        d.text((x, 32), m, font=f, fill=NEGRO, anchor='lm')
        rects[m] = [x - 20, 4, w + 40, 56]
        x += w + 56
    # Dock.
    n = 8 if con_dock_icono else 7
    ancho = n * 130 + 40
    dx0 = (E_ANCHO - ancho) / 2
    d.rounded_rectangle((dx0, E_ALTO - 170, dx0 + ancho, E_ALTO - 20), 40, fill=(245, 245, 245))
    colores = [(30, 144, 255), (52, 199, 89), (255, 149, 0), (175, 82, 222), (255, 59, 48), (90, 200, 250), (142, 142, 147)]
    toque = None
    for k in range(n):
        x = dx0 + 40 + k * 130
        if k == n - 1 and con_dock_icono:
            ic = icono(110)
            img.paste(ic, (round(x), E_ALTO - 150), ic)
            d.ellipse((x + 49, E_ALTO - 34, x + 61, E_ALTO - 22), fill=NEGRO)
            toque = [x - 10, E_ALTO - 160, 130, 130]
        else:
            d.rounded_rectangle((x, E_ALTO - 150, x + 110, E_ALTO - 40), 26, fill=colores[k % len(colores)])
    return img, rects, toque


def mac():
    pasos = []
    img, rects, _ = escritorio_mac()
    caja = (200, 120, E_ANCHO - 200, E_ALTO - 210)
    ventana_app(img, caja)
    pasos.append(('safari', img.copy(), rects['Archivo']))
    # Menú Archivo desplegado.
    menu = img.copy()
    mx0, my0 = rects['Archivo'][0], 64
    opciones = ['Nueva ventana', 'Nueva ventana privada', 'Nueva pestaña', 'Abrir archivo…', 'Cerrar ventana', '—', 'Compartir', 'Añadir al Dock…', '—', 'Exportar como PDF…', 'Imprimir…']
    alto = sum(24 if o == '—' else 66 for o in opciones) + 30
    tarjeta(menu, (mx0, my0, mx0 + 720, my0 + alto), 18, (246, 246, 246))
    d = ImageDraw.Draw(menu)
    y = my0 + 15
    toque = None
    for o in opciones:
        if o == '—':
            d.line((mx0 + 20, y + 12, mx0 + 700, y + 12), fill=LINEA, width=2)
            y += 24
            continue
        if o == 'Añadir al Dock…':
            d.rounded_rectangle((mx0 + 12, y, mx0 + 708, y + 62), 10, fill=(10, 100, 220))
            d.text((mx0 + 40, y + 31), o, font=sans(38), fill=BLANCO, anchor='lm')
            toque = [mx0 + 12, y, 696, 62]
        else:
            d.text((mx0 + 40, y + 31), o, font=sans(38), fill=NEGRO, anchor='lm')
        y += 66
    pasos.append(('menu', menu, toque))
    # Diálogo «Añadir al Dock».
    dlg = oscurecer(img, 60)
    cx0, cy0 = E_ANCHO / 2 - 520, 400
    tarjeta(dlg, (cx0, cy0, cx0 + 1040, cy0 + 620), 30, (246, 246, 246))
    d = ImageDraw.Draw(dlg)
    d.text((cx0 + 520, cy0 + 70), 'Añadir al Dock', font=sans(48, 'Semibold'), fill=NEGRO, anchor='mm')
    ic = icono(170)
    dlg.paste(ic, (round(cx0 + 60), cy0 + 150), ic)
    d.rounded_rectangle((cx0 + 270, cy0 + 170, cx0 + 980, cy0 + 250), 12, fill=BLANCO, outline=LINEA, width=3)
    d.text((cx0 + 300, cy0 + 210), CORTO, font=sans(40), fill=NEGRO, anchor='lm')
    d.text((cx0 + 270, cy0 + 300), 'victorgutierrezmarcos.es/app/abrir/', font=sans(34), fill=GRIS)
    boton(d, (cx0 + 520, cy0 + 480, cx0 + 740, cy0 + 570), 'Cancelar', BLANCO, NEGRO, radio=14, borde=LINEA, tam=40)
    anadir = boton(d, (cx0 + 760, cy0 + 480, cx0 + 980, cy0 + 570), 'Añadir', (10, 100, 220), radio=14, tam=40)
    pasos.append(('anadir', dlg, anadir))
    # En el Dock, y la app en su ventana.
    dock, _, toque_dock = escritorio_mac(con_dock_icono=True)
    pasos.append(('dock', dock, toque_dock))
    sola, _, _ = escritorio_mac(con_dock_icono=True)
    ventana_app(sola, (260, 130, E_ANCHO - 260, E_ALTO - 220), navegador=False)
    pasos.append(('app', sola, None))
    guardar('instalar-mac', pasos)


if __name__ == '__main__':
    android()
    iphone()
    windows()
    mac()
