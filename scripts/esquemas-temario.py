#!/usr/bin/env python3
"""Saca el esquema (los marcadores) de cada PDF del temario para la app.

Escribe oposicion/temario/esquemas.json: para cada PDF (por su nombre de
fichero, p. ej. «3A08.pdf»), la lista de marcadores como [nivel, título,
página], con el nivel desde 0. La app lo enseña al lado del PDF (en el
ordenador) o en una hoja para saltar de bloque (en el móvil). Los PDF sin
marcadores no salen.

Uso, desde la raíz del repositorio (hace falta pypdf):
    python3 scripts/esquemas-temario.py
Volver a ejecutarlo cuando cambie un PDF del temario.
"""
import json
import re
from pathlib import Path

from pypdf import PdfReader

RAIZ = Path(__file__).resolve().parents[1]
TEMARIO = RAIZ / 'oposicion' / 'temario'
SALIDA = TEMARIO / 'esquemas.json'
# Hasta qué nivel se guarda (0 = capítulos): más hondo no ayuda a saltar.
NIVEL_MAX = 3


def esquema(ruta: Path) -> list:
    lector = PdfReader(ruta)
    salida = []

    def recorrer(elementos, nivel):
        for e in elementos:
            if isinstance(e, list):
                recorrer(e, nivel + 1)
                continue
            if nivel > NIVEL_MAX:
                continue
            try:
                pagina = lector.get_destination_page_number(e) + 1
            except Exception:
                continue
            titulo = re.sub(r'\s+', ' ', str(e.title or '')).strip()
            if titulo:
                salida.append([nivel, titulo, pagina])

    recorrer(lector.outline, 0)
    return salida


def main() -> None:
    resultado = {}
    for pdf in sorted(TEMARIO.glob('*/*.pdf')):
        if 'oculto' in pdf.parts:
            continue
        try:
            e = esquema(pdf)
        except Exception as err:  # un PDF raro no para el resto
            print(f'  ! {pdf.name}: {err}')
            continue
        if e:
            resultado[pdf.name] = e
    SALIDA.write_text(json.dumps(resultado, ensure_ascii=False, separators=(',', ':')), encoding='utf-8')
    print(f'{len(resultado)} PDF con esquema → {SALIDA.relative_to(RAIZ)}')


if __name__ == '__main__':
    main()
