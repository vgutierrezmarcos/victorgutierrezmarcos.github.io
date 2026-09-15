#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Genera las copias publicas en DOCX de los temas del tercer y cuarto ejercicio.

Para cada 'Tema N.X.M.docx' de las carpetas privadas 'oculto/' produce
'<ejercicio>/NX0M.docx' limpiado con limpiar-docx.py, pero solo si temario.json
declara ese tema como disponible (hay PDFs en disco que la web no enlaza a
proposito). Tambien publica el esquema del dictamen economico 2025.

Uso:
    python3 scripts/publicar-docx.py            # genera y verifica
    python3 scripts/publicar-docx.py --listar   # solo muestra que haria
"""

import glob
import importlib.util
import json
import os
import re
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TEMARIO = os.path.join(RAIZ, "oposicion", "temario")
EJERCICIOS = ("tercer-ejercicio", "cuarto-ejercicio")

DICTAMEN_ORIGEN = os.path.join(
    TEMARIO, "primer-ejercicio", "oculto", "2. Dictamen económico",
    "2025_Esquema dictamen económico [Víctor Gutiérrez Marcos].docx",
)
DICTAMEN_DESTINO = os.path.join(
    TEMARIO, "primer-ejercicio", "esquema_dictamen_economico_2025.docx"
)


def _cargar(nombre):
    ruta = os.path.join(RAIZ, "scripts", nombre + ".py")
    spec = importlib.util.spec_from_file_location(nombre.replace("-", "_"), ruta)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


L = _cargar("limpiar-docx")
V = _cargar("verificar-docx")


def codigos_disponibles():
    """Codigos ('3A01') de los temas que temario.json declara disponibles."""
    with open(os.path.join(TEMARIO, "temario.json"), encoding="utf-8") as fh:
        datos = json.load(fh)
    disponibles = set()
    for ejercicio in datos["ejercicios"]:
        for parte in ejercicio.get("partes", []):
            for tema in parte["temas"]:
                if not tema.get("disponible"):
                    continue
                n, letra, num = tema["codigo"].split(".")
                disponibles.add("%s%s%02d" % (n, letra, int(num)))
    return disponibles


def codigo_de(nombre):
    """'Tema 3.A.1.docx' -> '3A01'; None si el nombre no sigue el patron."""
    m = re.match(r"Tema (\d)\.([AB])\.(\d+)", os.path.basename(nombre))
    return "%s%s%02d" % (m.group(1), m.group(2), int(m.group(3))) if m else None


def tareas():
    """Lista de (origen, destino, etiqueta) a procesar."""
    pendientes, omitidos = [], []
    disponibles = codigos_disponibles()
    for ejercicio in EJERCICIOS:
        carpeta = os.path.join(TEMARIO, ejercicio)
        for origen in sorted(glob.glob(os.path.join(carpeta, "oculto", "*.docx"))):
            codigo = codigo_de(origen)
            if not codigo:
                omitidos.append((os.path.basename(origen), "nombre no reconocido"))
                continue
            if codigo not in disponibles:
                omitidos.append((os.path.basename(origen), "no disponible en temario.json"))
                continue
            if not os.path.exists(os.path.join(carpeta, codigo + ".pdf")):
                omitidos.append((os.path.basename(origen), "sin PDF publico"))
                continue
            pendientes.append((origen, os.path.join(carpeta, codigo + ".docx"), codigo))
    if os.path.exists(DICTAMEN_ORIGEN):
        pendientes.append((DICTAMEN_ORIGEN, DICTAMEN_DESTINO, "dictamen 2025"))
    else:
        omitidos.append((os.path.basename(DICTAMEN_ORIGEN), "no encontrado"))
    return pendientes, omitidos


def main():
    pendientes, omitidos = tareas()
    print("A publicar: %d | omitidos: %d\n" % (len(pendientes), len(omitidos)))
    for nombre, motivo in omitidos:
        print("   omitido (%s): %s" % (motivo, nombre))
    if "--listar" in sys.argv:
        for origen, destino, etiqueta in pendientes:
            print("   %s -> %s" % (os.path.basename(origen), os.path.basename(destino)))
        return 0

    print()
    antes = despues = 0
    fallos = []
    for i, (origen, destino, etiqueta) in enumerate(pendientes, 1):
        stats = L.limpiar(origen, destino)
        o, n = os.path.getsize(origen), os.path.getsize(destino)
        antes += o
        despues += n
        problemas = V.verificar(origen, destino)
        if problemas:
            fallos.append((etiqueta, problemas))
        print("[%3d/%d] %-14s %6.1f -> %5.1f MB  runs=%-4d parrafos=%-4d imgs=%-3d %s"
              % (i, len(pendientes), etiqueta, o / 1e6, n / 1e6, stats["runs"],
                 stats["parrafos"], stats["imagenes"],
                 "OK" if not problemas else "FALLO"))

    print("\nTotal: %.0f MB -> %.0f MB (%.0f %%)"
          % (antes / 1e6, despues / 1e6, 100 * despues / max(antes, 1)))
    if fallos:
        print("\n%d ficheros con problemas:" % len(fallos))
        for etiqueta, problemas in fallos:
            print("   %s: %s" % (etiqueta, problemas[0]))
        return 1
    print("Verificacion correcta en los %d ficheros." % len(pendientes))
    return 0


if __name__ == "__main__":
    sys.exit(main())
