#!/usr/bin/env python3
# Genera ../graficos/mapa-acuerdos.tex: mapa del mundo (proyección Equal Earth)
# con la red de acuerdos comerciales de la UE coloreada por tipo de acuerdo.
#
# Uso: python3 mapa-acuerdos.py RUTA/ne_50m_admin_0_countries.geojson
#   El contorno de los países es Natural Earth, 1:50 millones, admin 0
#   (dominio público; https://www.naturalearthdata.com), en GeoJSON:
#   https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_50m_admin_0_countries.geojson
#   El tipo de acuerdo de cada país sale de mapa-acuerdos.csv (fuente y fecha en su cabecera).
#   Mismo método que el mapa de bloques del 3.B.35 (funciones geométricas copiadas).
# Solo usa la biblioteca estándar. Autor: Víctor Gutiérrez Marcos
import csv
import json
import math
import sys
from collections import defaultdict
from pathlib import Path

AQUI = Path(__file__).resolve().parent
SALIDA = AQUI.parent / "graficos" / "mapa-acuerdos.tex"

ANCHO = 16.6          # cm, el ancho del texto
TOL = 0.010           # cm, tolerancia de Douglas-Peucker
AREA_MIN = 0.0015     # cm², anillos menores se quitan (salvo el mayor de cada país)
LAT_MIN = -57.0

# Códigos de Natural Earth que no coinciden con ISO 3166-1
ALIAS = {"KOS": "XKX", "SDS": "SSD", "SOL": "SOM", "PSX": "PSE", "SAH": "ESH",
         "CYN": "CYP"}

UE = ("AUT BEL BGR HRV CYP CZE DNK EST FIN FRA DEU GRC HUN IRL ITA LVA LTU LUX "
      "MLT NLD POL PRT ROU SVK SVN ESP SWE").split()

# Tipo -> (color de relleno, capa del vídeo, texto de la leyenda)
TIPOS = {
    "eee":        ("acueee",   3, "EEE y Suiza"),
    "ua":         ("acuua",    3, "Unión aduanera"),
    "asociacion": ("acuasoc",  4, "Asociación y vecindad: Balcanes, DCFTA, Mediterráneo"),
    "nueva":      ("acunueva", 5, "ALC de nueva generación (con Reino Unido y Mercosur)"),
    "primera":    ("acuprim",  5, "ALC de primera generación (México, Feroe)"),
    "aae":        ("acuaae",   6, "Acuerdos de asociación económica (ACP)"),
}
# Con trama: acuerdo cerrado o firmado y pendiente; México, además, por su
# acuerdo modernizado (firmado el 22/5/2026)
TRAMA_PENDIENTE = ["MEX"]

def equal_earth(lon, lat):
    a1, a2, a3, a4 = 1.340264, -0.081106, 0.000893, 0.003796
    m = math.sqrt(3) / 2
    lam, phi = math.radians(lon), math.radians(lat)
    th = math.asin(m * math.sin(phi))
    t2 = th * th
    t6 = t2 * t2 * t2
    x = 2 * math.sqrt(3) * lam * math.cos(th) / (3 * (9 * a4 * t6 * t2 + 7 * a3 * t6 + 3 * a2 * t2 + a1))
    y = th * (a4 * t6 * t2 + a3 * t6 + a2 * t2 + a1)
    return x, y


XMAX = equal_earth(180, 0)[0]
ESCALA = ANCHO / (2 * XMAX)


def proy(lon, lat):
    x, y = equal_earth(lon, max(lat, LAT_MIN - 1))
    return x * ESCALA, y * ESCALA


def dp(puntos, tol):
    """Douglas-Peucker iterativo."""
    if len(puntos) < 4:
        return puntos
    guardar = [False] * len(puntos)
    guardar[0] = guardar[-1] = True
    pila = [(0, len(puntos) - 1)]
    while pila:
        i, j = pila.pop()
        (x1, y1), (x2, y2) = puntos[i], puntos[j]
        dx, dy = x2 - x1, y2 - y1
        n = math.hypot(dx, dy) or 1e-12
        dmax, kmax = 0.0, -1
        for k in range(i + 1, j):
            x0, y0 = puntos[k]
            d = abs(dy * x0 - dx * y0 + x2 * y1 - y2 * x1) / n if n > 1e-12 else math.hypot(x0 - x1, y0 - y1)
            if d > dmax:
                dmax, kmax = d, k
        if dmax > tol and kmax > 0:
            guardar[kmax] = True
            pila += [(i, kmax), (kmax, j)]
    return [p for p, g in zip(puntos, guardar) if g]


def area(anillo):
    s = 0.0
    for (x1, y1), (x2, y2) in zip(anillo, anillo[1:] + anillo[:1]):
        s += x1 * y2 - x2 * y1
    return abs(s) / 2


def centroide(anillo):
    a = cx = cy = 0.0
    for (x1, y1), (x2, y2) in zip(anillo, anillo[1:] + anillo[:1]):
        c = x1 * y2 - x2 * y1
        a += c
        cx += (x1 + x2) * c
        cy += (y1 + y2) * c
    if abs(a) < 1e-12:
        return anillo[0]
    return cx / (3 * a), cy / (3 * a)


def trama(anillos, color, sentido=1, paso=0.075, grosor=0.3):
    """Trama de líneas a 45° recortada a los anillos en Python (regla par-impar).
    Sin \\clip ni patterns: pdftocairo repetiría el recorte en cada línea del SVG."""
    # Coordenada u = y - sentido*x es constante en cada línea; v = x avanza por ella
    lados = []
    for r in anillos:
        for a, b in zip(r, r[1:] + r[:1]):
            lados.append((a, b))
    us = [p[1] - sentido * p[0] for r in anillos for p in r]
    segmentos = []
    k0, k1 = math.floor(min(us) / paso), math.ceil(max(us) / paso)
    for k in range(k0, k1 + 1):
        u = (k + 0.5) * paso
        cortes = []
        for (x1, y1), (x2, y2) in lados:
            u1, u2 = y1 - sentido * x1, y2 - sentido * x2
            if (u1 - u) * (u2 - u) < 0:
                t = (u - u1) / (u2 - u1)
                cortes.append(x1 + t * (x2 - x1))
        cortes.sort()
        for xa, xb in zip(cortes[0::2], cortes[1::2]):
            if xb - xa > 0.01:
                segmentos.append(((xa, u + sentido * xa), (xb, u + sentido * xb)))
    trazos = " ".join(f"{fmt(a)} -- {fmt(b)}" for a, b in segmentos)
    return f"\\draw[{color},line width={grosor}pt,line cap=butt] {trazos};"


def fmt(p):
    return f"({p[0]:.2f},{p[1]:.2f})"


def camino(anillos):
    return " ".join(" -- ".join(fmt(p) for p in r) + " -- cycle" for r in anillos)



def leer_tipos():
    filas = [l for l in (AQUI / "mapa-acuerdos.csv").read_text(encoding="utf-8").splitlines()
             if l and not l.startswith("#")]
    tipos = {}
    for f in csv.DictReader(filas, delimiter=";"):
        for iso in f["miembros"].split():
            tipos[iso] = f["tipo"]
    return tipos


def leer_paises(ruta):
    datos = json.loads(Path(ruta).read_text(encoding="utf-8"))
    paises = defaultdict(list)
    for f in datos["features"]:
        iso = f["properties"]["ADM0_A3"]
        iso = ALIAS.get(iso, iso)
        if iso == "ATA":
            continue
        g = f["geometry"]
        polis = g["coordinates"] if g["type"] == "MultiPolygon" else [g["coordinates"]]
        for poli in polis:
            anillo = [tuple(p) for p in poli[0]]
            if max(p[1] for p in anillo) < LAT_MIN:
                continue
            paises[iso].append(anillo)
    return paises


def main():
    tipos = leer_tipos()
    paises = leer_paises(sys.argv[1])
    for iso in tipos:
        if iso not in paises:
            print("Aviso: sin contorno", iso, file=sys.stderr)

    geo, punto, diminuto = {}, {}, set()
    for iso, anillos in paises.items():
        proyectados = sorted(([proy(x, y) for x, y in r] for r in anillos), key=area, reverse=True)
        mayor = proyectados[0]
        punto[iso] = centroide(mayor)
        xs = [p[0] for p in mayor]
        ys = [p[1] for p in mayor]
        if max(max(xs) - min(xs), max(ys) - min(ys)) < 0.07:
            diminuto.add(iso)
        quedan = []
        for k, pr in enumerate(proyectados):
            if k > 0 and area(pr) < AREA_MIN:
                continue
            s = dp(pr + [pr[0]], TOL)[:-1]
            if len(s) >= 3:
                quedan.append(s)
        geo[iso] = quedan

    lin = []
    w = lin.append
    w("% Red de acuerdos comerciales de la UE por tipo (19/11/2026).")
    w("% GENERADO por ../datos/mapa-acuerdos.py a partir de Natural Earth 1:50m (dominio público)")
    w("% y de ../datos/mapa-acuerdos.csv (tipos y fuente). No editar a mano: cambiar el CSV")
    w("% o el script y volver a generarlo.")
    w("% Proyección Equal Earth; color = tipo de acuerdo en aplicación; trama verde = cerrado o")
    w("% firmado y pendiente; trama gris = en negociación; los países muy pequeños, con un círculo.")
    w("% Capas: 1 tierra; 2 UE; 3 EEE, Suiza y uniones aduaneras; 4 asociación y vecindad;")
    w("% 5 ALC; 6 AAE; 7 pendientes; 8 en negociación; 9 leyenda.")
    w("% Autor: Víctor Gutiérrez Marcos")
    w("\\documentclass[tikz,border=2pt]{standalone}")
    w("\\input{../../../latex/tikz-tcee}")
    w("\\begin{document}")
    w("\\colorlet{mapatierra}{black!9}")
    w("\\colorlet{acuue}{tceemorado!80}")
    w("\\colorlet{acueee}{tceeazul!75}")
    w("\\colorlet{acuua}{tceerojo!60}")
    w("\\colorlet{acuasoc}{tceenaranja!55}")
    w("\\colorlet{acunueva}{tceeverde!70}")
    w("\\colorlet{acuprim}{tceeverde!38}")
    w("\\colorlet{acuaae}{tceedorado!55}")
    w("\\colorlet{acutramav}{tceeverde!60!black}")
    w("\\colorlet{acutramag}{black!50}")
    w("\\tikzset{frontera/.style={draw=white,line width=0.15pt}}")
    w("\\begin{tikzpicture}[tcee]")
    y0 = proy(0, LAT_MIN)[1]
    y1 = proy(0, 84)[1]
    w("\\begin{scope}")
    w(f"\\clip ({-ANCHO/2-0.05:.2f},{y0:.2f}) rectangle ({ANCHO/2+0.05:.2f},{y1+0.05:.2f});")
    w("% 1: tierra")
    w("\\capa{1}{\\fill[mapatierra] " + camino([r for iso in sorted(geo) for r in geo[iso]]) + ";}")
    w("% 2: la UE")
    w("\\capa{2}{\\filldraw[acuue,frontera] " + camino([r for iso in UE if iso in geo for r in geo[iso]]) + ";}")
    por_capa = defaultdict(list)
    for iso in sorted(geo):
        t = tipos.get(iso)
        if t in TIPOS:
            por_capa[TIPOS[t][1]].append((iso, t))
    nombres = {3: "EEE, Suiza y uniones aduaneras", 4: "asociación y vecindad", 5: "acuerdos de libre comercio",
               6: "acuerdos de asociación económica"}
    for c in (3, 4, 5, 6):
        w(f"% {c}: {nombres[c]}")
        w(f"\\capa{{{c}}}{{")
        for iso, t in por_capa[c]:
            col = TIPOS[t][0]
            w(f"  \\filldraw[{col},frontera] {camino(geo[iso])}; % {iso} ({t})")
            if iso in diminuto:
                x, y = punto[iso]
                w(f"  \\filldraw[{col},draw=black!60,line width=0.2pt] ({x:.2f},{y:.2f}) circle (0.05);")
        w("}")
    for c, tipo, color in ((7, "pendiente", "acutramav"), (8, "negociacion", "acutramag")):
        isos = [i for i in sorted(geo) if tipos.get(i) == tipo]
        if tipo == "pendiente":
            isos += TRAMA_PENDIENTE
        w(f"% {c}: {tipo} ({' '.join(isos)})")
        w(f"\\capa{{{c}}}{{")
        for iso in isos:
            if tipos.get(iso) == tipo:
                w(f"  \\fill[mapatierra!60!white] {camino(geo[iso])};")
        w("  " + trama([r for i in isos for r in geo[i]], color, 1, 0.07, 0.45))
        for iso in isos:
            w(f"  \\draw[{color},line width=0.35pt] {camino(geo[iso])};")
        w("}")
    w("\\end{scope}")
    # 9: leyenda, debajo del mapa, en 3 columnas de 3 filas
    w("% 9: leyenda")
    w("\\capa{9}{")
    w(f"\\begin{{scope}}[shift={{({-ANCHO/2:.2f},{y0-0.35:.2f})}},font=\\fontsize{{6}}{{7}}\\selectfont]")
    filas = [("acuue", "Unión Europea", None)] + [(TIPOS[t][0], TIPOS[t][2], None) for t in
             ("eee", "ua", "asociacion", "nueva", "primera", "aae")]
    filas += [("acutramav", "Pendiente: Australia, India, Indonesia, México (modernizado)", "trama"),
              ("acutramag", "En negociación: Malasia, Filipinas, Tailandia, EAU", "trama")]
    for k, (col, texto, modo) in enumerate(filas):
        x, yy = (0.0, 2.75, 9.4)[k // 3], -0.36 * (k % 3)
        if modo:
            caja = [[(x, yy - 0.1), (x + 0.32, yy - 0.1), (x + 0.32, yy + 0.1), (x, yy + 0.1)]]
            w(f"  \\fill[mapatierra!60!white] ({x:.2f},{yy-0.1:.2f}) rectangle ({x+0.32:.2f},{yy+0.1:.2f});")
            w("  " + trama(caja, col, 1, 0.07, 0.45))
            w(f"  \\draw[{col},line width=0.35pt] ({x:.2f},{yy-0.1:.2f}) rectangle ({x+0.32:.2f},{yy+0.1:.2f});")
        else:
            w(f"  \\fill[{col}] ({x:.2f},{yy-0.1:.2f}) rectangle ({x+0.32:.2f},{yy+0.1:.2f});")
        w(f"  \\node[anchor=west] at ({x+0.38:.2f},{yy:.2f}) {{{texto}}};")
    w("\\end{scope}}")
    w("\\end{tikzpicture}")
    w("\\end{document}")
    SALIDA.write_text("\n".join(lin) + "\n", encoding="utf-8")
    print(SALIDA, sum(len(l) for l in lin) // 1024, "KB")


if __name__ == "__main__":
    main()
