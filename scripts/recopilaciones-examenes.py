#!/usr/bin/env python3
"""Monta las recopilaciones en PDF de los exámenes oficiales del primer ejercicio:

    oposicion/temario/primer-ejercicio/test/examenes_oficiales_test.pdf   (test, 2002-2026)
    oposicion/temario/primer-ejercicio/examenes_oficiales_dictamen.pdf    (dictamen, 2011-2026)

Cada examen sale de su PDF original (oculto/ATCEE_Examenesanteriores/{test,coyuntura}/),
a dos páginas por hoja apaisada, sin las páginas en blanco ni las de «No dé la vuelta
a las hojas», con su plantilla al final y un marcador por año. Los tests de 2002 a 2009
solo existen escaneados (oculto/1. Test/Examenes Oficiales Test 2024-2002.pdf): se
rasterizan a 300 ppp en blanco y negro con compresión CCITT G4, que deja el texto nítido
y ocupa unos 40 KB por hoja.

La portada es scripts/portada-recopilacion.html impresa a PDF con Edge (A4 apaisado):
    msedge --headless=new --no-pdf-header-footer --virtual-time-budget=8000 \
        --print-to-pdf=portada_test.pdf "file:///…/scripts/portada-recopilacion.html#test"
(y lo mismo con #dictamen).

Uso (desde la raíz del repositorio):
    python3 scripts/recopilaciones-examenes.py portada_test.pdf portada_dictamen.pdf

Requiere PyMuPDF y Pillow (con libtiff).
Autor: Víctor Gutiérrez Marcos
"""
import io
import re
import sys
from pathlib import Path

import fitz
from PIL import Image

RAIZ = Path(__file__).resolve().parent.parent
PRIMER = RAIZ / 'oposicion' / 'temario' / 'primer-ejercicio'
ORIGINALES = PRIMER / 'test' / 'oculto' / 'ATCEE_Examenesanteriores'
ESCANEADOS = PRIMER / 'oculto' / '1. Test' / 'Examenes Oficiales Test 2024-2002.pdf'

# (marcador, [(fichero, páginas o None = todas), …]), del más reciente al más antiguo.
TEST = [
    ('2026 (marzo)', [('OEP2025_test_mar2026.pdf', None)]),
    ('2025 (marzo)', [('OEP2024_test_mar2025.pdf', None)]),
    ('2024 (junio)', [('OEP2023_test_jun2024.pdf', None), ('OEP2023TECOS_Ej1_Plantilla_Definitiva.pdf', None)]),
    ('2023 (junio)', [('OEP2022_test_jun2023.pdf', None)]),
    ('2022 (julio)', [('OEP2021_test_jul2022.pdf', None)]),
    ('2021 (julio)', [('OEP2020_test_jul2021.pdf', None)]),
    ('2020 (enero)', [('OEP2019_test_ene2020.pdf', None)]),
    ('2019 (febrero)', [('OEP2018_test_feb2019.pdf', None)]),
    ('2018 (enero)', [('OEP2017_test_ene2018.pdf', None)]),
    ('2016 (noviembre)', [('OEP2016_test_nov2016.pdf', None)]),
    ('2016 (enero)', [('OEP2015_test_ene2016.pdf', None)]),
    ('2014 (septiembre)', [('OEP2014_test_sep2014.pdf', None)]),
    ('2013 (noviembre)', [('OEP2013_test_nov2013.pdf', None)]),
    ('2011 (octubre)', [('OEP2011_test_oct2011.pdf', None)]),
]
# Marcadores del PDF escaneado → título en la recopilación.
ESCANEADOS_ANIOS = {'2009': '2009 (octubre)', '2008': '2008 (julio)', '2007': '2007 (julio)', '2006': '2006 (septiembre)',
                    '2005': '2005 (septiembre)', '2004': '2004 (junio)', '2003': '2003 (julio)', '2002': '2002 (octubre)'}

DICTAMEN = [
    # El enunciado de 2026 con los cuadros y gráficos de la versión rectificada.
    ('2026 (marzo)', [('OEP2025_coyuntura_mar2026.pdf', [0, 1]), ('OEP2025_coyuntura_rectificada_mar2026.pdf', None)]),
    ('2025 (marzo)', [('OEP2024_coyuntura_mar2025.pdf', None)]),
    ('2024 (junio)', [('OEP2023_coyuntura_jun2024.pdf', None)]),
    ('2023 (junio)', [('OEP2022_coyuntura_jun2023.pdf', None)]),
    ('2022 (julio)', [('OEP2021_coyuntura_jul2022.pdf', None)]),
    ('2021 (julio)', [('OEP2020_coyuntura_jul2021.pdf', None)]),
    ('2020 (enero)', [('OEP2019_coyuntura_ene2020.pdf', None)]),
    ('2019 (febrero)', [('OEP2018_coyuntura_feb2019.pdf', None)]),
    ('2018 (enero)', [('OEP2017_coyuntura_ene2018.pdf', None)]),
    ('2016 (noviembre)', [('OEP2016_coyuntura_nov2016.pdf', None)]),
    ('2016 (enero)', [('OEP2015_coyuntura_ene2016.pdf', None)]),
    ('2014 (septiembre)', [('OEP2014_coyuntura_sep2014.pdf', None)]),
    ('2013 (noviembre)', [('OEP2013_coyuntura_nov2013.pdf', None)]),
    ('2011 (octubre)', [('OEP2011_coyuntura_oct 2011.pdf', None)]),
]

ANCHO, ALTO = 841.89, 595.28  # A4 apaisado


def sobra(pagina):
    """Páginas en blanco, o con solo el número de página y «No dé la vuelta a las hojas…»."""
    if pagina.get_images() or len(pagina.get_drawings()) > 2:
        return False
    texto = re.sub(r'\s+', ' ', pagina.get_text()).strip()
    texto = re.sub(r'NO D[ÉE] LA VUELTA A LAS HOJAS HASTA QUE (?:ASÍ |SE )?LO INDIQUE EL TRIBUNAL\.?', '', texto, flags=re.I)
    texto = re.sub(r'^(?:P[áa]gina )?\d+(?:(?: de |/)\d+)?$', '', texto.strip(), flags=re.I)
    return texto.strip() == ''


def anadir_examen(salida, carpeta, ficheros):
    """Añade un examen a dos páginas por hoja y devuelve el número de su primera hoja."""
    paginas = []
    for nombre, cuales in ficheros:
        doc = fitz.open(carpeta / nombre)
        for i in (cuales if cuales is not None else range(doc.page_count)):
            if not sobra(doc[i]):
                paginas.append((doc, i))
    primera = salida.page_count
    for k in range(0, len(paginas), 2):
        hoja = salida.new_page(width=ANCHO, height=ALTO)
        for lado, (doc, i) in enumerate(paginas[k:k + 2]):
            hoja.show_pdf_page(fitz.Rect(lado * ANCHO / 2, 0, (lado + 1) * ANCHO / 2, ALTO), doc, i)
    return primera


def hoja_g4(salida, pagina, dpi=300, umbral=165):
    """Copia una hoja escaneada como imagen en blanco y negro con compresión CCITT G4 (salvo si está en blanco)."""
    pix = pagina.get_pixmap(dpi=dpi, colorspace=fitz.csGRAY)
    gris = Image.frombytes('L', (pix.width, pix.height), pix.samples)
    bn = gris.point(lambda v: 255 if v > umbral else 0).convert('1')
    if bn.convert('L').histogram()[0] < 0.0003 * bn.width * bn.height:
        return False  # hoja en blanco
    tiff = io.BytesIO()
    bn.save(tiff, 'TIFF', compression='group4', tiffinfo={278: bn.height})  # una sola tira
    t = Image.open(io.BytesIO(tiff.getvalue()))
    inicio, largo = t.tag_v2[273][0], t.tag_v2[279][0]
    datos = tiff.getvalue()[inicio:inicio + largo]
    negro_es_1 = 'true' if t.tag_v2.get(262) == 1 else 'false'
    hoja = salida.new_page(width=ANCHO, height=ALTO)
    xref = hoja.insert_image(hoja.rect, pixmap=fitz.Pixmap(fitz.csGRAY, fitz.IRect(0, 0, 1, 1), False))
    w, h = bn.size
    salida.update_stream(xref, datos, compress=False)
    salida.update_object(xref, f'<< /Type /XObject /Subtype /Image /Width {w} /Height {h} /ColorSpace /DeviceGray /BitsPerComponent 1 '
                               f'/Filter /CCITTFaxDecode /DecodeParms << /K -1 /Columns {w} /Rows {h} /BlackIs1 {negro_es_1} >> /Length {len(datos)} >>')
    return True


def montar(portada, examenes, carpeta, destino, escaneados=False):
    salida = fitz.open()
    salida.insert_pdf(fitz.open(portada))
    indice = [[1, 'Portada', 1]]
    for titulo, ficheros in examenes:
        indice.append([1, titulo, anadir_examen(salida, carpeta, ficheros) + 1])
    if escaneados:
        doc = fitz.open(ESCANEADOS)
        marcas = [(t, p) for nivel, t, p in doc.get_toc() if nivel == 1 and t in ESCANEADOS_ANIOS]
        fines = [p for _, p in marcas[1:]] + [doc.page_count + 1]
        for (t, desde), hasta in zip(marcas, fines):
            indice.append([1, ESCANEADOS_ANIOS[t], salida.page_count + 1])
            hojas = sum(hoja_g4(salida, doc[i]) for i in range(desde - 1, hasta - 1))
            print(' ', ESCANEADOS_ANIOS[t], hojas, 'hojas', flush=True)
    salida.set_toc(indice)
    salida.set_metadata({'title': 'Exámenes de la oposición a TCEE', 'author': 'Víctor Gutiérrez Marcos'})
    salida.save(destino, garbage=4, deflate=True, deflate_images=False)
    print(destino.relative_to(RAIZ), salida.page_count, 'hojas,', round(destino.stat().st_size / 1e6, 1), 'MB')


if __name__ == '__main__':
    portada_test, portada_dictamen = sys.argv[1:3]
    montar(portada_dictamen, DICTAMEN, ORIGINALES / 'coyuntura', PRIMER / 'examenes_oficiales_dictamen.pdf')
    montar(portada_test, TEST, ORIGINALES / 'test', PRIMER / 'test' / 'examenes_oficiales_test.pdf', escaneados=True)
