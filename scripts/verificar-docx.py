#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Comprueba que un .docx limpiado conserva el texto visible del original y que
no le queda nada oculto.

Uso:
    python3 scripts/verificar-docx.py original.docx limpio.docx
"""

import importlib.util
import os
import re
import sys
import zipfile

from lxml import etree

_spec = importlib.util.spec_from_file_location(
    "limpiar_docx", os.path.join(os.path.dirname(os.path.abspath(__file__)), "limpiar-docx.py")
)
L = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(L)

q = L.q


def _recorrer(nodo, ocultos, trozos):
    """Acumula el texto del subarbol saltando lo que Word muestra como oculto.

    Recorre en orden en lugar de usar .//w:r por parrafo: los parrafos anidados
    (cuadros de texto) harian contar sus runs dos veces.
    """
    for hijo in nodo:
        tag = hijo.tag
        if tag == q("p"):
            ppr = hijo.find(q("pPr"))
            pstyle = ppr.find(q("pStyle")) if ppr is not None else None
            if pstyle is not None and pstyle.get(q("val")) in ocultos:
                continue
        elif tag == q("r"):
            if L._rpr_oculto(hijo.find(q("rPr")), ocultos):
                continue
        elif tag == q("del"):
            continue
        elif tag == q("sdt"):
            sdtpr = hijo.find(q("sdtPr"))
            if sdtpr is not None and L._rpr_oculto(sdtpr.find(q("rPr")), ocultos):
                continue
        elif tag == q("t"):
            trozos.append(hijo.text or "")
            continue
        _recorrer(hijo, ocultos, trozos)


def texto_visible(ruta, aplicar_ocultos=True):
    """Texto del documento ignorando todo lo que Word muestra como oculto."""
    z = zipfile.ZipFile(ruta)
    nombres = set(z.namelist())
    ocultos = set()
    if aplicar_ocultos and "word/styles.xml" in nombres:
        ocultos = L.estilos_ocultos(z.read("word/styles.xml"))
    raiz = etree.fromstring(z.read("word/document.xml"))
    trozos = []
    _recorrer(raiz, ocultos, trozos)
    return re.sub(r"\s+", " ", "".join(trozos)).strip()


def quedan_ocultos(ruta):
    """Partes del paquete en las que todavia hay formato oculto activo."""
    z = zipfile.ZipFile(ruta)
    nombres = set(z.namelist())
    ocultos = L.estilos_ocultos(z.read("word/styles.xml") if "word/styles.xml" in nombres else None)
    restos = []
    for nombre in nombres:
        if not L.PARTES_TEXTO.match(nombre):
            continue
        raiz = etree.fromstring(z.read(nombre))
        for r in raiz.findall(".//" + q("r")):
            if L._rpr_oculto(r.find(q("rPr")), ocultos):
                restos.append((nombre, "run"))
                break
        for p in raiz.findall(".//" + q("p")):
            ppr = p.find(q("pPr"))
            pstyle = ppr.find(q("pStyle")) if ppr is not None else None
            if pstyle is not None and pstyle.get(q("val")) in ocultos:
                restos.append((nombre, "parrafo"))
                break
    return restos


def verificar(original, limpio):
    problemas = []
    try:
        z = zipfile.ZipFile(limpio)
        if z.testzip() is not None:
            problemas.append("ZIP corrupto")
        if "word/document.xml" not in z.namelist():
            problemas.append("falta word/document.xml")
    except Exception as exc:
        return ["no se puede abrir: %s" % exc]

    restos = quedan_ocultos(limpio)
    if restos:
        problemas.append("queda contenido oculto: %s" % restos[:3])

    esperado = texto_visible(original)
    obtenido = texto_visible(limpio, aplicar_ocultos=False)
    if esperado != obtenido:
        # localiza el primer punto de divergencia para poder diagnosticar
        i = next((i for i, (a, b) in enumerate(zip(esperado, obtenido)) if a != b),
                 min(len(esperado), len(obtenido)))
        problemas.append(
            "el texto visible no coincide (len %d vs %d, diverge en %d): %r | %r"
            % (len(esperado), len(obtenido), i, esperado[i:i + 80], obtenido[i:i + 80])
        )
    return problemas


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    problemas = verificar(sys.argv[1], sys.argv[2])
    nombre = os.path.basename(sys.argv[2])
    if problemas:
        print("FALLO %s" % nombre)
        for p in problemas:
            print("   - %s" % p)
        return 1
    print("OK %s" % nombre)
    return 0


if __name__ == "__main__":
    sys.exit(main())
