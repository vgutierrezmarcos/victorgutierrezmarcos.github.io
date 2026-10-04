#!/usr/bin/env python3
"""
Compone dos capturas «dentro» de un tema para la página de la app y el vídeo,
que no se pueden sacar de las pruebas de Flutter (el visor de PDF y el
navegador integrado son nativos):

- tema-pdf.png: la ficha de un tema de TCEE (tema-base.png, de
  app/tool/capturas_dce_test.dart) con su PDF abierto y desplazado.
- dce-tema-web.png: los apuntes de un tema de DCE tal como se leen en la app
  (pestaña del navegador integrado), desplazados hasta mitad del tema.

    python3 scripts/componer-capturas-temas.py --web-dce RUTA.png

RUTA.png es la página del tema de DCE a 500 px de ancho (p. ej. con Edge sin
ventana: --window-size=500,3200 --screenshot), sin la cortina de la portada.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import os

import fitz  # PyMuPDF
from PIL import Image, ImageDraw, ImageFont

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAPTURAS = os.path.join(RAIZ, 'app', 'promo', 'capturas')
FUENTES = os.path.join(RAIZ, 'app', 'assets', 'fonts')
ANCHO, ALTO = 1080, 2340

# Tema de cada oposición que se enseña.
PDF_TCEE = os.path.join(RAIZ, 'oposicion', 'temario', 'tercer-ejercicio', '3A09.pdf')
TITULO_DCE = 'Análisis de mercados (III). Teoría del oligopolio'
DOMINIO_DCE = 'manuelcabadogarcia.es'


def sans(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


def tema_pdf():
    base = Image.open(os.path.join(CAPTURAS, 'tema-base.png')).convert('RGB')
    # El cuerpo empieza donde acaba la fila del título: la primera línea, por
    # debajo de la cabecera, del color de fondo de la app.
    fondo = base.getpixel((ANCHO // 2, ALTO - 300))
    y0 = next(y for y in range(260, ALTO) if all(abs(a - b) < 6 for a, b in zip(base.getpixel((ANCHO // 2, y)), fondo)))
    # Páginas 1 y 2 del PDF a lo ancho de la pantalla, desplazadas como si se
    # hubiera bajado hasta el final de la primera.
    doc = fitz.open(PDF_TCEE)
    paginas = []
    for i in range(min(2, len(doc))):
        p = doc[i].get_pixmap(matrix=fitz.Matrix(ANCHO / doc[i].rect.width, ANCHO / doc[i].rect.width))
        paginas.append(Image.frombytes('RGB', (p.width, p.height), p.samples))
    separacion = 16
    tira = Image.new('RGB', (ANCHO, sum(p.height for p in paginas) + separacion * len(paginas)), (220, 220, 220))
    y = 0
    for p in paginas:
        tira.paste(p, (0, y))
        y += p.height + separacion
    desplazado = round(paginas[0].height * 0.55)
    out = base.copy()
    out.paste(tira.crop((0, desplazado, ANCHO, desplazado + ALTO - y0)), (0, y0))
    # Indicador de página del visor.
    d = ImageDraw.Draw(out)
    texto = f'2 / {len(doc)}'
    f = sans(40, 'Semibold')
    w = f.getlength(texto) + 56
    d.rounded_rectangle(((ANCHO - w) / 2, ALTO - 130, (ANCHO + w) / 2, ALTO - 64), 33, fill=(45, 45, 45))
    d.text((ANCHO / 2, ALTO - 97), texto, font=f, fill=(255, 255, 255), anchor='mm')
    out.save(os.path.join(CAPTURAS, 'tema-pdf.png'))


def dce_tema_web(ruta):
    pagina = Image.open(ruta).convert('RGB')
    escala = ANCHO / pagina.width
    barra = 168
    # Desde la caracterización del oligopolio hasta su primera ecuación.
    y_pag = 1900
    alto_pag = round((ALTO - barra) / escala)
    trozo = pagina.crop((0, y_pag, pagina.width, y_pag + alto_pag)).resize((ANCHO, ALTO - barra), Image.LANCZOS)
    out = Image.new('RGB', (ANCHO, ALTO), (255, 255, 255))
    out.paste(trozo, (0, barra))
    # Barra de la pestaña del navegador integrado: cerrar, título y dominio.
    d = ImageDraw.Draw(out)
    d.rectangle((0, 0, ANCHO, barra), fill=(250, 250, 250))
    d.line((0, barra - 1, ANCHO, barra - 1), fill=(222, 222, 222), width=2)
    cx, cy, r = 70, barra // 2, 20
    d.line((cx - r, cy - r, cx + r, cy + r), fill=(60, 60, 60), width=6)
    d.line((cx - r, cy + r, cx + r, cy - r), fill=(60, 60, 60), width=6)
    f_titulo, f_dominio = sans(44, 'Semibold'), sans(36)
    titulo = TITULO_DCE
    while f_titulo.getlength(titulo + '…') > ANCHO - 260:
        titulo = titulo[:-1]
    d.text((140, cy - 26), titulo.rstrip() + ('…' if titulo != TITULO_DCE else ''), font=f_titulo, fill=(32, 32, 32), anchor='lm')
    d.text((140, cy + 30), DOMINIO_DCE, font=f_dominio, fill=(110, 110, 110), anchor='lm')
    for i in range(3):
        d.ellipse((ANCHO - 72, cy - 34 + i * 30, ANCHO - 60, cy - 22 + i * 30), fill=(60, 60, 60))
    out.save(os.path.join(CAPTURAS, 'dce-tema-web.png'))


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--web-dce', required=True, help='captura de la página del tema de DCE a 500 px de ancho')
    a = p.parse_args()
    tema_pdf()
    dce_tema_web(a.web_dce)
    print('tema-pdf.png y dce-tema-web.png en', CAPTURAS)


if __name__ == '__main__':
    main()
