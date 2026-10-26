#!/usr/bin/env python3
"""
Sella los PDF exclusivos de la web (los de oposicion/exclusivos.json con
«sellar»): aviso de uso personal en un recuadro al pie de la portada, pie
breve en todas las páginas y metadatos de autor y derechos (Info y XMP, con la
reserva de minería de textos y datos). Es idempotente: un PDF ya sellado (lleva
«Exclusivo» en las palabras clave) se salta, salvo con --forzar.

    ~/.local/share/oposicion-web/venv-ocr/bin/python scripts/sellar-exclusivo.py [--forzar] [ruta.pdf ...]

Necesita PyMuPDF (está en el venv del OCR). Los PDF que salen del pipeline de
la rama revision-temario no pasan por aquí: llevan el aviso desde LaTeX.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import shutil
import sys
import tempfile

import pymupdf

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REGISTRO = os.path.join(RAIZ, 'oposicion', 'exclusivos.json')
FUENTE = os.path.join(RAIZ, 'app', 'assets', 'fonts', 'texgyrepagella-regular.otf')
FUENTE_NEGRITA = os.path.join(RAIZ, 'app', 'assets', 'fonts', 'texgyrepagella-bold.otf')
TINTA = (0x5F / 255, 0x29 / 255, 0x87 / 255)
DORADO = (0xB8 / 255, 0x86 / 255, 0x0B / 255)
CREMA = (0xFB / 255, 0xFA / 255, 0xF6 / 255)
GRIS = (0x5E / 255, 0x58 / 255, 0x66 / 255)
MARCA = 'Exclusivo · uso personal'


def xmp(titulo, aviso, pie, condiciones, anio):
    return f'''<?xpacket begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/"><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xmpRights="http://ns.adobe.com/xap/1.0/rights/" xmlns:tdm="http://www.w3.org/ns/tdmrep#" xmlns:cc="http://creativecommons.org/ns#">
<dc:title><rdf:Alt><rdf:li xml:lang="es">{titulo}</rdf:li></rdf:Alt></dc:title>
<dc:creator><rdf:Seq><rdf:li>Víctor Gutiérrez Marcos</rdf:li></rdf:Seq></dc:creator>
<dc:rights><rdf:Alt><rdf:li xml:lang="es">© {anio} Víctor Gutiérrez Marcos. Todos los derechos reservados. {aviso}</rdf:li></rdf:Alt></dc:rights>
<xmpRights:Marked>True</xmpRights:Marked>
<xmpRights:UsageTerms><rdf:Alt><rdf:li xml:lang="es">{pie}. Uso personal; no se autoriza su incorporación a otras plataformas, aplicaciones o servicios ni la minería de textos y datos.</rdf:li></rdf:Alt></xmpRights:UsageTerms>
<xmpRights:WebStatement>{condiciones}</xmpRights:WebStatement>
<tdm:reservation>1</tdm:reservation>
<tdm:policy>{condiciones}</tdm:policy>
<cc:morePermissions>{condiciones}</cc:morePermissions>
</rdf:Description></rdf:RDF></x:xmpmeta>
<?xpacket end="w"?>'''


def sellar(ruta, datos, forzar=False):
    doc = pymupdf.open(ruta)
    meta = doc.metadata or {}
    if MARCA in (meta.get('keywords') or '') and not forzar:
        print(f'  ya sellado: {os.path.relpath(ruta, RAIZ)}')
        doc.close()
        return False
    aviso, pie, condiciones = datos['aviso'], datos['pie'], datos['condiciones']
    anio = (datos.get('generado') or '2026')[:4]
    for i, pagina in enumerate(doc):
        pagina.insert_font(fontname='pag', fontfile=FUENTE)
        pagina.insert_font(fontname='pagb', fontfile=FUENTE_NEGRITA)
        r = pagina.rect
        if i == 0:
            # Recuadro del aviso al pie de la portada.
            alto = 44 if r.width > r.height else 54
            caja = pymupdf.Rect(r.x0 + 28, r.y1 - alto - 22, r.x1 - 28, r.y1 - 22)
            pagina.draw_rect(caja, color=TINTA, fill=CREMA, width=0.8, radius=0.08)
            pagina.draw_line((caja.x0 + 14, caja.y0 + 15), (caja.x0 + 40, caja.y0 + 15), color=DORADO, width=0.8)
            pagina.insert_text((caja.x0 + 46, caja.y0 + 18), MARCA.upper(), fontname='pagb', fontsize=7.5, color=TINTA)
            pagina.insert_textbox(pymupdf.Rect(caja.x0 + 14, caja.y0 + 22, caja.x1 - 14, caja.y1 - 4), aviso, fontname='pag', fontsize=8.2, color=GRIS, align=pymupdf.TEXT_ALIGN_LEFT, lineheight=1.25)
        # Pie breve en todas las páginas (también en la portada, debajo del recuadro).
        pagina.insert_textbox(pymupdf.Rect(r.x0 + 28, r.y1 - 19, r.x1 - 28, r.y1 - 5), pie, fontname='pag', fontsize=6.5, color=GRIS, align=pymupdf.TEXT_ALIGN_CENTER)
    palabras = ', '.join([k for k in [(meta.get('keywords') or '').strip(), MARCA] if k])
    doc.set_metadata({**meta, 'author': 'Víctor Gutiérrez Marcos', 'keywords': palabras,
                      'subject': ((meta.get('subject') or '').rstrip('. ') + '. ' + aviso).strip()})
    doc.set_xml_metadata(xmp(meta.get('title') or os.path.basename(ruta), aviso, pie, condiciones, anio))
    tmp = tempfile.NamedTemporaryFile(suffix='.pdf', delete=False, dir=os.path.dirname(ruta)).name
    doc.save(tmp, garbage=3, deflate=True)
    doc.close()
    shutil.move(tmp, ruta)
    print(f'  sellado: {os.path.relpath(ruta, RAIZ)}')
    return True


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('rutas', nargs='*', help='PDF concretos (por defecto, los del registro con «sellar»)')
    p.add_argument('--forzar', action='store_true', help='volver a sellar aunque ya lleven la marca (añade otro pie: solo para pruebas)')
    args = p.parse_args()
    with open(REGISTRO, encoding='utf-8') as f:
        datos = json.load(f)
    rutas = args.rutas or [os.path.join(RAIZ, m['ruta']) for m in datos['materiales'] if m.get('sellar') and m.get('ruta', '').endswith('.pdf')]
    n = 0
    for r in rutas:
        if not os.path.exists(r):
            print(f'  no existe: {r}', file=sys.stderr)
            continue
        n += sellar(r, datos, args.forzar)
    print(f'{n} PDF sellados')


if __name__ == '__main__':
    main()
