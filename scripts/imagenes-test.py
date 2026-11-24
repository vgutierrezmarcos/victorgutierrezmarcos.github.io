#!/usr/bin/env python3
"""Regenera con más nitidez las imágenes de los enunciados del simulador del test.

Las imágenes de oposicion/temario/primer-ejercicio/test/img/ eran recortes de poca
resolución y se veían borrosas, sobre todo en pantallas de alta densidad. Cada una
sale ahora de una de estas tres fuentes:

- VECTOR: la recopilación examenes_oficiales_test.pdf tiene la figura en vectorial
  (texto y trazos). Se renderiza el recorte al doble de su ancho en pantalla.
- NATIVO: la figura es un mapa de bits incrustado en el PDF. Se recorta a la
  resolución del original, sin inventar píxeles (si es menor que el doble del
  ancho en pantalla, se queda en la del original).
- img/tex/<nombre>.tex: escaneos antiguos (2002-2013) redibujados en LaTeX.
  Se compilan con el pdflatex de MiKTeX, como scripts/graficos-explicaciones.py.

Las que no están en ninguna lista (2022-julio_p40, 2026-marzo_p09 y p24) ya eran
nítidas y no se tocan.

ANCHO es el ancho en pantalla (px CSS) de cada imagen, el que tenían los recortes
antiguos: el simulador lo pone en el atributo width para que una imagen con el doble
de píxeles no salga el doble de grande. El script lo copia al campo «ancho» de cada
imagen en preguntas.json.

    python3 scripts/imagenes-test.py               # todas
    python3 scripts/imagenes-test.py 2026-marzo_p04 # solo esas

Necesita PyMuPDF y Pillow (p. ej. el venv-ocr de ~/.local/share/oposicion-web).
"""
import io
import json
import os
import subprocess
import sys
from pathlib import Path

import fitz  # PyMuPDF
from PIL import Image

RAIZ = Path(__file__).resolve().parents[1]
TEST = RAIZ / 'oposicion/temario/primer-ejercicio/test'
IMG = TEST / 'img'
TEX = IMG / 'tex'
PDF = TEST / 'examenes_oficiales_test.pdf'
PDFLATEX = os.environ.get('TCEE_PDFLATEX', '/mnt/c/Users/vgutierrez/AppData/Local/Programs/MiKTeX/miktex/bin/x64/pdflatex.exe')
DENSIDAD = 2        # píxeles por px CSS
CALIDAD = 90

# Página (1 = primera) y rectángulo en puntos de examenes_oficiales_test.pdf
VECTOR = {
    '2016-enero-OEP2015_p36': (119, (487.7, 223.7, 791.0, 283.7)),
    '2016-noviembre-OEP2016_p10': (105, (87.3, 283.7, 346.0, 327.3)),
    '2016-noviembre-OEP2016_p23': (107, (53.7, 157.3, 365.0, 346.7)),
    '2016-noviembre-OEP2016_p24': (107, (476.0, 48.3, 786.3, 122.3)),
    '2016-noviembre-OEP2016_p25': (107, (476.0, 48.3, 786.3, 122.3)),
    '2020-enero-OEP2019_p15': (79, (566.0, 159.3, 697.7, 295.3)),
    '2021-julio-OEP2020_p10': (65, (580.7, 239.0, 682.3, 272.7)),
    '2024-junio-A_p07': (27, (552.0, 109.5, 700.0, 153.5)),
    '2025-marzo-A_p08': (15, (121.5, 129.8, 299.3, 191.6)),
    '2026-marzo_p04': (3, (531.0, 138.3, 732.0, 172.3)),
    '2026-marzo_p06': (4, (87.0, 183.7, 333.7, 244.7)),
    '2026-marzo_p34': (9, (125.0, 387.0, 296.0, 439.0)),
}
NATIVO = {
    '2020-enero-OEP2019_p09': (78, (115.7, 217.7, 323.7, 407.3)),
    '2021-julio-OEP2020_p05': (64, (555.3, 103.0, 726.3, 251.0)),
    '2021-julio-OEP2020_p22': (68, (137.3, 132.7, 301.0, 245.3)),
    '2022-julio_p13': (52, (505.7, 85.7, 764.3, 172.3)),
}
ANCHO = {
    '2002-octubre-OEP2002_p34': 616, '2004-junio-OEP2004_p03': 761,
    '2008-julio-OEP2008_p08': 900, '2008-julio-OEP2008_p27': 760,
    '2011-octubre-OEP2011_p25': 834, '2013-noviembre-OEP2013_p15': 663,
    '2016-enero-OEP2015_p36': 1399, '2016-noviembre-OEP2016_p10': 1188,
    '2016-noviembre-OEP2016_p23': 804, '2016-noviembre-OEP2016_p24': 803,
    '2016-noviembre-OEP2016_p25': 803, '2020-enero-OEP2019_p09': 612,
    '2020-enero-OEP2019_p15': 365, '2021-julio-OEP2020_p05': 517,
    '2021-julio-OEP2020_p10': 580, '2021-julio-OEP2020_p22': 660,
    '2022-julio_p13': 1190, '2022-julio_p40': 884, '2024-junio-A_p07': 980,
    '2025-marzo-A_p08': 765, '2026-marzo_p04': 856, '2026-marzo_p06': 1051,
    '2026-marzo_p09': 523, '2026-marzo_p24': 1096, '2026-marzo_p34': 728,
}


def a_imagen(pix):
    return Image.open(io.BytesIO(pix.tobytes('png'))).convert('RGB')


def guardar(nombre, img):
    img.save(IMG / f'{nombre}.webp', 'WEBP', quality=CALIDAD, method=6)
    print(f'ok {nombre}.webp ({img.width}×{img.height}, {(IMG / f"{nombre}.webp").stat().st_size // 1024} KB)')


def recorte(doc, nombre, pagina, rect, nativo):
    rect = fitz.Rect(rect)
    zoom = ANCHO[nombre] * DENSIDAD / rect.width
    if nativo:
        pagina_pdf = doc[pagina - 1]
        densidades = [im[2] / r.width for im in pagina_pdf.get_images(full=True)
                      for r in pagina_pdf.get_image_rects(im[0]) if r.intersects(rect)]
        zoom = min(zoom, max(densidades))
    guardar(nombre, a_imagen(doc[pagina - 1].get_pixmap(matrix=fitz.Matrix(zoom, zoom), clip=rect, alpha=False)))


def ruta_windows(p):
    return subprocess.run(['wslpath', '-w', str(p)], capture_output=True, text=True, check=True).stdout.strip()


def latex(nombre):
    tex = TEX / f'{nombre}.tex'
    base = tex.with_suffix('')
    try:
        r = subprocess.run([PDFLATEX, '-interaction=nonstopmode', '-halt-on-error', tex.name],
                           cwd=TEX, capture_output=True, timeout=300)
        if r.returncode != 0:
            print(f'ERROR {tex.name}:\n{r.stdout.decode("latin-1")[-1500:]}')
            return False
        doc = fitz.open(base.with_suffix('.pdf'))
        zoom = ANCHO[nombre] * DENSIDAD / doc[0].rect.width
        guardar(nombre, a_imagen(doc[0].get_pixmap(matrix=fitz.Matrix(zoom, zoom), alpha=False)))
        doc.close()
        return True
    finally:
        for ext in ('.aux', '.log', '.pdf'):
            if base.with_suffix(ext).exists():
                base.with_suffix(ext).unlink()


def actualizar_json():
    ruta = TEST / 'preguntas.json'
    texto = ruta.read_text(encoding='utf-8')
    datos = json.loads(texto)
    for p in datos['preguntas']:
        for img in p.get('imagenes', []):
            nombre = Path(img['src']).stem
            if nombre in ANCHO:
                img['ancho'] = ANCHO[nombre]
    sangria = 2 if texto.startswith('{\n  ') else None
    ruta.write_text(json.dumps(datos, ensure_ascii=False, indent=sangria) + ('\n' if texto.endswith('\n') else ''), encoding='utf-8')


def main():
    solo = set(sys.argv[1:])
    doc = fitz.open(PDF)
    fallos = 0
    for nombre, (pagina, rect) in {**VECTOR, **NATIVO}.items():
        if not solo or nombre in solo:
            recorte(doc, nombre, pagina, rect, nombre in NATIVO)
    for tex in sorted(TEX.glob('*.tex')):
        if not solo or tex.stem in solo:
            fallos += not latex(tex.stem)
    actualizar_json()
    sys.exit(1 if fallos else 0)


if __name__ == '__main__':
    main()
