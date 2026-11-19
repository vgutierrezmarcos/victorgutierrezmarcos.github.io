#!/usr/bin/env python3
# Genera ../graficos/mapa-schengen.tex: mapa de Europa con el espacio Schengen
# (miembros de la UE, asociados de fuera de la UE, Estados de la UE que no lo
# aplican y controles interiores temporales).
#
# Uso: python3 mapa-schengen.py RUTA/ne_50m_admin_0_countries.geojson
#   El contorno de los países es Natural Earth, 1:50 millones, admin 0
#   (dominio público; https://www.naturalearthdata.com), en GeoJSON:
#   https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_50m_admin_0_countries.geojson
#   Las pertenencias salen de mapa-schengen.csv (fuentes en su cabecera).
# Mismo método que el mapa de bloques del 3.B.35 (proyección, simplificación de
# Douglas-Peucker y tramas recortadas en Python). Solo usa la biblioteca estándar.
# Autor: Víctor Gutiérrez Marcos
import csv
import json
import math
import sys
from collections import defaultdict
from pathlib import Path

AQUI = Path(__file__).resolve().parent
SALIDA = AQUI.parent / "graficos" / "mapa-schengen.tex"

ANCHO = 13.0          # cm, ancho del mapa
TOL = 0.008           # cm, tolerancia de Douglas-Peucker
AREA_MIN = 0.002      # cm², islas menores se quitan (salvo el mayor anillo de un país)
LON0, LAT0 = 10.0, 52.0   # centro de la proyección azimutal equivalente de Lambert (como la ETRS89-LAEA)

ALIAS = {"KOS": "XKX", "CYN": "CYP", "SDS": "SSD", "SOL": "SOM", "PSX": "PSE", "SAH": "ESH"}

# Marco: puntos (lon, lat) que deben verse
MARCO = [(-24.6, 63.5), (-24.6, 66.6), (-10.5, 36.0), (-9.6, 51.5), (35.0, 34.4),
         (31.6, 70.2), (25.8, 71.2), (32.5, 60.0), (14.5, 34.9), (-36.0, 49.0)]


def laea(lon, lat):
    lam, phi = math.radians(lon - LON0), math.radians(lat)
    phi0 = math.radians(LAT0)
    k = math.sqrt(2 / (1 + math.sin(phi0) * math.sin(phi) + math.cos(phi0) * math.cos(phi) * math.cos(lam)))
    x = k * math.cos(phi) * math.sin(lam)
    y = k * (math.cos(phi0) * math.sin(phi) - math.sin(phi0) * math.cos(phi) * math.cos(lam))
    return x, y


_xs = [laea(*p)[0] for p in MARCO]
_ys = [laea(*p)[1] for p in MARCO]
XMIN, XMAX, YMIN, YMAX = min(_xs), max(_xs), min(_ys), max(_ys)
ESCALA = ANCHO / (XMAX - XMIN)


def proy(lon, lat):
    x, y = laea(lon, lat)
    return (x - XMIN) * ESCALA, (y - YMIN) * ESCALA


ALTO = (YMAX - YMIN) * ESCALA


def dp(puntos, tol):
    if len(puntos) < 4:
        return puntos
    guardar = [False] * len(puntos)
    guardar[0] = guardar[-1] = True
    pila = [(0, len(puntos) - 1)]
    while pila:
        i, j = pila.pop()
        (x1, y1), (x2, y2) = puntos[i], puntos[j]
        dx, dy = x2 - x1, y2 - y1
        n = math.hypot(dx, dy)
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


def fmt(p):
    return f"({p[0]:.2f},{p[1]:.2f})"


def camino(anillos):
    return " ".join(" -- ".join(fmt(p) for p in r) + " -- cycle" for r in anillos)


def trama(anillos, color, sentido=1, paso=0.09, grosor=0.35):
    """Trama de líneas a 45° recortada a los anillos en Python (regla par-impar)."""
    lados = [(a, b) for r in anillos for a, b in zip(r, r[1:] + r[:1])]
    us = [p[1] - sentido * p[0] for r in anillos for p in r]
    segmentos = []
    for k in range(math.floor(min(us) / paso), math.ceil(max(us) / paso) + 1):
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
    return f"\\draw[{color},line width={grosor}pt,line cap=butt] " + " ".join(f"{fmt(a)} -- {fmt(b)}" for a, b in segmentos) + ";"


def dentro(anillo):
    m = 1.0
    return any(-m < x < ANCHO + m and -m < y < ALTO + m for x, y in anillo)


def leer_grupos():
    filas = [l for l in (AQUI / "mapa-schengen.csv").read_text(encoding="utf-8").splitlines()
             if l and not l.startswith("#")]
    return {f["grupo"]: f["miembros"].split() for f in csv.DictReader(filas, delimiter=";")}


def leer_paises(ruta):
    datos = json.loads(Path(ruta).read_text(encoding="utf-8"))
    paises = defaultdict(list)
    for f in datos["features"]:
        iso = f["properties"]["ADM0_A3"]
        iso = ALIAS.get(iso, iso)
        g = f["geometry"]
        polis = g["coordinates"] if g["type"] == "MultiPolygon" else [g["coordinates"]]
        for poli in polis:
            anillo = [tuple(p) for p in poli[0]]
            if max(p[1] for p in anillo) < 25 or min(p[1] for p in anillo) > 75:
                continue
            if min(p[0] for p in anillo) > 60 or max(p[0] for p in anillo) < -35:
                continue
            paises[iso].append(anillo)
    return paises


def main():
    grupos = leer_grupos()
    paises = leer_paises(sys.argv[1])
    geo, punto, diminuto = {}, {}, set()
    for iso, anillos in paises.items():
        pr = sorted(([proy(x, y) for x, y in r] for r in anillos), key=area, reverse=True)
        pr = [r for r in pr if dentro(r)]
        if not pr:
            continue
        mayor = pr[0]
        punto[iso] = centroide(mayor)
        xs, ys = [p[0] for p in mayor], [p[1] for p in mayor]
        if max(max(xs) - min(xs), max(ys) - min(ys)) < 0.12:
            diminuto.add(iso)
        quedan = []
        for k, r in enumerate(pr):
            if k > 0 and area(r) < AREA_MIN:
                continue
            s = dp(r + [r[0]], TOL)[:-1]
            if len(s) >= 3:
                quedan.append(s)
        geo[iso] = quedan
    for g, isos in grupos.items():
        for iso in isos:
            if iso not in geo:
                print("Aviso: sin contorno", iso, file=sys.stderr)

    color = {}
    for iso in grupos["ue_schengen"]:
        color[iso] = "mapaue"
    for iso in grupos["asociados"]:
        color[iso] = "mapaasoc"
    for iso in grupos["irlanda"]:
        color[iso] = "mapairl"
    for iso in grupos["chipre"]:
        color[iso] = "mapachp"

    lin = []
    w = lin.append
    w("% Mapa del espacio Schengen (19/11/2026).")
    w("% GENERADO por ../datos/mapa-schengen.py a partir de Natural Earth 1:50m (dominio público)")
    w("% y de ../datos/mapa-schengen.csv (pertenencias y fuentes). No editar a mano: cambiar el CSV")
    w("% o el script y volver a generarlo.")
    w("% Proyección azimutal equivalente de Lambert centrada en 10° E y 52° N (como la ETRS89-LAEA).")
    w("% Capas: 1 tierra; 2 UE en Schengen; 3 asociados; 4 UE fuera (Irlanda y Chipre);")
    w("% 5 trama de los controles interiores temporales; 6 rótulos; 7 leyenda.")
    w("% Autor: Víctor Gutiérrez Marcos")
    w("\\documentclass[tikz,border=2pt]{standalone}")
    w("\\input{../../../latex/tikz-tcee}")
    w("\\begin{document}")
    w("\\colorlet{mapatierra}{black!10}")
    w("\\colorlet{mapaue}{tceeazul!55}")
    w("\\colorlet{mapaasoc}{tceeverde!55}")
    w("\\colorlet{mapairl}{tceenaranja!65}")
    w("\\colorlet{mapachp}{tceedorado!70}")
    w("\\tikzset{frontera/.style={draw=white,line width=0.2pt},")
    w("  rotulo/.style={font=\\scriptsize\\bfseries,inner sep=1pt,text=black,align=center},")
    w("  guiarotulo/.style={draw=black!65,line width=0.3pt}}")
    w("\\begin{tikzpicture}[tcee]")
    w(f"\\clip (0,0) rectangle ({ANCHO:.2f},{ALTO:.2f});")
    w("% 1: tierra")
    w("\\capa{1}{\\filldraw[mapatierra,frontera] " + camino([r for iso in sorted(geo) if iso not in color for r in geo[iso]]) + ";}")
    nombres = {2: ("mapaue", "Estados de la UE en Schengen"), 3: ("mapaasoc", "asociados"),
               4: (None, "Estados de la UE fuera de Schengen")}
    for capa, (col, txt) in nombres.items():
        w(f"% {capa}: {txt}")
        w(f"\\capa{{{capa}}}{{")
        for iso in sorted(color):
            c = color[iso]
            if (capa == 4 and c in ("mapairl", "mapachp")) or c == col:
                if iso in geo:
                    w(f"  \\filldraw[{c},frontera] {camino(geo[iso])}; % {iso}")
                    if iso in diminuto:
                        x, y = punto[iso]
                        w(f"  \\filldraw[{c},draw=black!70,line width=0.25pt] ({x:.2f},{y:.2f}) circle (0.07); % {iso}, diminuto")
        w("}")
    w("% 5: controles interiores temporales (trama)")
    ctl = grupos["controles"]
    w("\\capa{5}{" + trama([r for iso in ctl if iso in geo for r in geo[iso]], "black!55", 1) + "}")
    # 6: rótulos (texto, lon, lat, opciones, destino)
    rot = [("Islandia", -12.6, 65.2, "anchor=west", None),
           ("Noruega", 9.5, 61.4, "", None),
           ("Suiza", 4.0, 44.6, "anchor=east", (8.2, 46.8)),
           ("Liechtenstein", 13.0, 48.6, "anchor=west", (9.55, 47.15)),
           ("Irlanda", -8.0, 53.2, "font=\\tiny\\bfseries", None),
           ("Chipre", 29.5, 36.6, "anchor=east", (32.9, 35.0))]
    w("% 6: rótulos")
    w("\\capa{6}{")
    for t, lon, lat, o, dest in rot:
        x, y = proy(lon, lat)
        if dest:
            xd, yd = proy(*dest)
            w(f"  \\draw[guiarotulo] ({x:.2f},{y:.2f}) -- ({xd:.2f},{yd:.2f});")
        w(f"  \\node[rotulo,{o}] at ({x:.2f},{y:.2f}) {{{t}}};")
    w("}")
    # 7: leyenda, en el Atlántico
    lx, ly = 0.25, proy(-30.0, 52.5)[1]
    w("% 7: leyenda")
    w("\\capa{7}{")
    w(f"\\begin{{scope}}[shift={{({lx:.2f},{ly:.2f})}},font=\\fontsize{{6.5}}{{7.5}}\\selectfont]")
    filas = [("mapaue", "UE en Schengen (25)"), ("mapaasoc", "asociados de fuera de la UE (4)"),
             ("mapairl", "Irlanda: exención"), ("mapachp", "Chipre: pendiente del Consejo")]
    for k, (c, t) in enumerate(filas):
        y = -0.36 * k
        w(f"  \\fill[{c}] (0,{y - 0.1:.2f}) rectangle (0.32,{y + 0.1:.2f});")
        w(f"  \\node[anchor=west] at (0.38,{y:.2f}) {{{t}}};")
    y = -0.36 * len(filas)
    w(f"  \\fill[mapaue] (0,{y - 0.1:.2f}) rectangle (0.32,{y + 0.1:.2f});")
    w("  " + trama([[(0, y - 0.1), (0.32, y - 0.1), (0.32, y + 0.1), (0, y + 0.1)]], "black!55", 1))
    w(f"  \\node[anchor=west,align=left] at (0.38,{y - 0.12:.2f}) {{controles interiores\\\\temporales (nov. 2026)}};")
    w("\\end{scope}}")
    w("\\end{tikzpicture}")
    w("\\end{document}")
    SALIDA.write_text("\n".join(lin) + "\n", encoding="utf-8")
    print(SALIDA, sum(len(l) for l in lin) // 1024, "KB", f"{ANCHO:.1f}x{ALTO:.1f} cm")


if __name__ == "__main__":
    main()
