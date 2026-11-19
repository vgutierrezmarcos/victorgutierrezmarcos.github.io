#!/usr/bin/env python3
# Genera los mapas por regiones NUTS 2 del 3.B.40 (19/11/2026), con el método
# del mapa del 3.B.35 (contornos reales simplificados con Douglas-Peucker y
# escritos como caminos TikZ; sin imágenes):
#   ../graficos/mapa-categorias.tex   categorías de regiones 2021-2027 (mapa-categorias.csv)
#   ../graficos/mapa-pib-regional.tex PIB por habitante en PPA en 2024 y su variación
#                                     2000-2024 (mapa-pib-regional.csv)
#
# Uso: python3 mapas-regiones.py CARPETA
#   CARPETA tiene los contornos de GISCO (Eurostat), escala 1:20 millones, en
#   GeoJSON y EPSG:4326 (© EuroGeographics para los límites administrativos):
#   https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2021_4326_LEVL_2.geojson
#   https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2024_4326_LEVL_2.geojson
#   https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2024_4326_LEVL_0.geojson
#   https://gisco-services.ec.europa.eu/distribution/v2/countries/geojson/CNTR_RG_20M_2024_4326.geojson
# Las categorías son de NUTS 2021 (las de la Decisión 2021/1130) y el PIB, de
# NUTS 2024 (el de Eurostat de 2026). Proyección acimutal equivalente de
# Lambert centrada en 52° N, 10° E (la de ETRS89-LAEA, EPSG:3035, en esfera).
# Las regiones ultraperiféricas van en recuadros, cada una a su escala.
# Solo usa la biblioteca estándar. Autor: Víctor Gutiérrez Marcos
import json
import math
import sys
from pathlib import Path

AQUI = Path(__file__).resolve().parent
GRAF = AQUI.parent / "graficos"
EU = "BE BG CZ DK DE EE IE EL ES FR HR IT CY LV LT LU HU MT NL AT PL PT RO SI SK FI SE".split()

# Ventana del continente en grados (se proyecta y se recorta)
LON0, LAT0 = 10.0, 52.0
CAJA = (-0.42, -0.30, 0.37, 0.355)   # x0, y0, x1, y1 en la esfera unidad (radianes)
# Recuadros: (código NUTS, rótulo, lon_min, lon_max, lat_min, lat_max)
ULTRA = [
    ("PT20", "Azores", -31.5, -24.8, 36.7, 40.0),
    ("PT30", "Madeira", -17.4, -16.1, 32.5, 33.2),
    ("ES70", "Canarias", -18.3, -13.3, 27.5, 29.5),
    ("FRY1", "Guadalupe", -61.9, -60.9, 15.8, 16.6),
    ("FRY2", "Martinica", -61.3, -60.8, 14.35, 14.9),
    ("FRY3", "Guayana Fr.", -54.7, -51.5, 2.0, 5.85),
    ("FRY4", "Reunión", 55.15, 55.9, -21.45, -20.8),
    ("FRY5", "Mayotte", 44.95, 45.35, -13.05, -12.6),
]
EN_RECUADRO = {u[0] for u in ULTRA}


def laea(lon, lat):
    l0, p0 = math.radians(LON0), math.radians(LAT0)
    l, p = math.radians(lon), math.radians(lat)
    k = math.sqrt(2 / (1 + math.sin(p0) * math.sin(p) + math.cos(p0) * math.cos(p) * math.cos(l - l0)))
    return (k * math.cos(p) * math.sin(l - l0),
            k * (math.cos(p0) * math.sin(p) - math.sin(p0) * math.cos(p) * math.cos(l - l0)))


def dp(puntos, tol):
    """Douglas-Peucker iterativo (como en el 3.B.35)."""
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


def area(r):
    return abs(sum(x1 * y2 - x2 * y1 for (x1, y1), (x2, y2) in zip(r, r[1:] + r[:1]))) / 2


def trama(anillos, color, paso=0.06, grosor=0.25):
    """Trama a 45° recortada a los anillos en Python (regla par-impar), como en el 3.B.35."""
    lados = [(a, b) for r in anillos for a, b in zip(r, r[1:] + r[:1])]
    us = [p[1] - p[0] for r in anillos for p in r]
    seg = []
    for k in range(math.floor(min(us) / paso), math.ceil(max(us) / paso) + 1):
        u = (k + 0.5) * paso
        cortes = []
        for (x1, y1), (x2, y2) in lados:
            u1, u2 = y1 - x1, y2 - x2
            if (u1 - u) * (u2 - u) < 0:
                t = (u - u1) / (u2 - u1)
                cortes.append(x1 + t * (x2 - x1))
        cortes.sort()
        for xa, xb in zip(cortes[0::2], cortes[1::2]):
            if xb - xa > 0.01:
                seg.append(((xa, u + xa), (xb, u + xb)))
    if not seg:
        return ""
    return f"\\draw[{color},line width={grosor}pt,line cap=butt] " + " ".join(f"{fmt(a)} -- {fmt(b)}" for a, b in seg) + ";"


def fmt(p):
    return f"({p[0]:.2f},{p[1]:.2f})"


def camino(anillos):
    return " ".join(" -- ".join(fmt(p) for p in r) + " -- cycle" for r in anillos)


def anillos_de(geom):
    polis = geom["coordinates"] if geom["type"] == "MultiPolygon" else [geom["coordinates"]]
    return [[tuple(p) for p in poli[0]] for poli in polis]


def leer(ruta, clave="NUTS_ID"):
    d = json.loads(Path(ruta).read_text(encoding="utf-8"))
    return {f["properties"][clave]: anillos_de(f["geometry"]) for f in d["features"]}


class Mapa:
    """Proyecta y simplifica al ancho pedido; recuadros para las ultraperiféricas."""

    def __init__(self, ancho, alto_recuadro, tol=0.012, area_min=0.0012, hueco=0.12):
        self.esc = ancho / (CAJA[2] - CAJA[0])
        self.ancho = ancho
        self.alto = (CAJA[3] - CAJA[1]) * self.esc
        self.tol, self.area_min = tol, area_min
        self.rec = alto_recuadro
        self.hueco = hueco

    def xy(self, lon, lat):
        x, y = laea(lon, lat)
        return ((x - CAJA[0]) * self.esc, (y - CAJA[1]) * self.esc)

    def forma(self, anillos, fun):
        salida = []
        pr = sorted(([fun(*p) for p in r] for r in anillos), key=area, reverse=True)
        for k, r in enumerate(pr):
            if k > 0 and area(r) < self.area_min:
                continue
            s = dp(r + [r[0]], self.tol)[:-1]
            if len(s) >= 3:
                salida.append(s)
        return salida

    def continente(self, anillos):
        # Quita los anillos lejanos (ultraperiféricas) y lo que queda fuera de la ventana
        dentro = []
        for r in anillos:
            lon = sum(p[0] for p in r) / len(r)
            lat = sum(p[1] for p in r) / len(r)
            if lat < 27 or lon < -26 or lon > 50 or (lat < 34 and lon < -5):
                continue
            dentro.append(r)
        return self.forma(dentro, self.xy) if dentro else []

    def recuadros(self):
        """Posición de cada recuadro: una columna a la izquierda, en el Atlántico."""
        pos = {}
        lado = self.rec
        x0, y = 0.08, self.alto - 0.1
        for i, (cod, rot, l0, l1, a0, a1) in enumerate(ULTRA):
            col, fila = i % 2, i // 2
            pos[cod] = (x0 + col * (lado + self.hueco), y - (fila + 1) * (lado + 0.32) + 0.1, lado)
        return pos

    def en_recuadro(self, cod, anillos, pos):
        _, rot, l0, l1, a0, a1 = next(u for u in ULTRA if u[0] == cod)
        x0, y0, lado = pos[cod]
        c = math.cos(math.radians((a0 + a1) / 2))
        w, h = (l1 - l0) * c, (a1 - a0)
        e = (lado - 0.08) / max(w, h)
        ox = x0 + (lado - w * e) / 2
        oy = y0 + (lado - h * e) / 2

        def f(lon, lat):
            return (ox + (lon - l0) * c * e, oy + (lat - a0) * e)
        dentro = [r for r in anillos if l0 - 1 < sum(p[0] for p in r) / len(r) < l1 + 1
                  and a0 - 1 < sum(p[1] for p in r) / len(r) < a1 + 1]
        viejo = self.tol, self.area_min
        self.tol, self.area_min = self.tol / 2, self.area_min / 20
        s = self.forma(dentro, f)
        self.tol, self.area_min = viejo
        return s


def dibujar(m, regiones, color_de, fondo, paises0, desplaza=(0, 0), trama_de=None, tam_rotulo="\\tiny"):
    """Devuelve las líneas TikZ de un mapa (regiones coloreadas, fronteras y recuadros)."""
    lin = []
    w = lin.append
    dx, dy = desplaza
    w(f"\\begin{{scope}}[shift={{({dx:.2f},{dy:.2f})}}]")
    w(f"\\begin{{scope}}\\clip (0,0) rectangle ({m.ancho:.2f},{m.alto:.2f});")
    # 1: tierra fuera de la UE
    otros = [r for iso, an in fondo.items() if iso not in EU_ISO for r in m.continente(an)]
    w("\\capa{1}{\\fill[mapafuera] " + camino(otros) + ";}")
    # 2: regiones de la UE
    w("\\capa{2}{")
    for cod in sorted(regiones):
        if cod in EN_RECUADRO:
            continue
        g = m.continente(regiones[cod])
        if not g:
            continue
        w(f"  \\filldraw[{color_de(cod)},draw=white,line width=0.12pt] {camino(g)}; % {cod}")
        if trama_de and trama_de(cod):
            w("  " + trama(g, "black!55"))
    w("}")
    # 3: fronteras de los Estados
    fr = [r for iso in EU if iso in paises0 for r in m.continente(paises0[iso])]
    w("\\capa{3}{\\draw[black!65,line width=0.3pt,line join=round] " + camino(fr) + ";}")
    w("\\end{scope}")
    # 4: recuadros de las ultraperiféricas
    pos = m.recuadros()
    w("\\capa{4}{")
    for cod, rot, *_ in ULTRA:
        x0, y0, lado = pos[cod]
        w(f"  \\fill[mapamar] ({x0:.2f},{y0:.2f}) rectangle ({x0+lado:.2f},{y0+lado:.2f});")
        g = m.en_recuadro(cod, regiones[cod], pos)
        w(f"  \\filldraw[{color_de(cod)},draw=black!65,line width=0.2pt] {camino(g)}; % {cod}")
        if trama_de and trama_de(cod):
            w("  " + trama(g, "black!55", paso=0.04))
        w(f"  \\draw[black!45,line width=0.25pt] ({x0:.2f},{y0:.2f}) rectangle ({x0+lado:.2f},{y0+lado:.2f});")
        w(f"  \\node[font={tam_rotulo},anchor=north,inner sep=0.5pt] at ({x0+lado/2:.2f},{y0-0.01:.2f}) {{{rot}}};")
    w("}")
    w("\\end{scope}")
    return lin


EU_ISO = set("AT BE BG CY CZ DE DK EE EL ES FI FR HR HU IE IT LT LU LV MT NL PL PT RO SE SI SK".split())


def leyenda(x, y, entradas, titulo, ancho_caja=0.32, sep=0.27, fuente="\\scriptsize"):
    lin = [f"\\begin{{scope}}[shift={{({x:.2f},{y:.2f})}},font={fuente}]",
           f"  \\node[anchor=south west,font={fuente}\\bfseries,inner sep=0pt] at (0,-0.1) {{{titulo}}};"]
    for i, (color, texto, rayas) in enumerate(entradas):
        yy = -(i + 1) * sep
        lin.append(f"  \\filldraw[{color},draw=black!40,line width=0.2pt] (0,{yy-0.08:.2f}) rectangle ({ancho_caja},{yy+0.08:.2f});")
        if rayas:
            lin.append("  " + trama([[(0, yy - 0.08), (ancho_caja, yy - 0.08), (ancho_caja, yy + 0.08), (0, yy + 0.08)]], "black!55", paso=0.05))
        lin.append(f"  \\node[anchor=west,inner sep=0pt] at ({ancho_caja+0.1:.2f},{yy:.2f}) {{{texto}}};")
    lin.append("\\end{scope}")
    return lin


def cabecera(desc, capas):
    return ["% " + l for l in desc] + [
        "% GENERADO por ../datos/mapas-regiones.py con los contornos de GISCO (Eurostat, 1:20 millones;",
        "% © EuroGeographics para los límites administrativos). No editar a mano: cambiar el CSV o el",
        "% script y volver a generarlo.",
        "% " + capas,
        "% Autor: Víctor Gutiérrez Marcos",
        "\\documentclass[tikz,border=2pt]{standalone}",
        "\\input{../../../latex/tikz-tcee}",
        "\\begin{document}",
        "\\colorlet{mapafuera}{black!14}",
        "\\colorlet{mapamar}{white!100}",
        "\\colorlet{catmenos}{tceerojo!80}",
        "\\colorlet{cattransicion}{tceenaranja!55}",
        "\\colorlet{catmas}{tceedorado!25}",
        "\\colorlet{pib1}{tceerojo!85}",
        "\\colorlet{pib2}{tceerojo!45}",
        "\\colorlet{pib3}{tceenaranja!40}",
        "\\colorlet{pib4}{tceedorado!22}",
        "\\colorlet{pib5}{tceeazul!25}",
        "\\colorlet{pib6}{tceeazul!55}",
        "\\colorlet{pib7}{tceeazul!90}",
        "\\colorlet{dif1}{tceerojo!80}",
        "\\colorlet{dif2}{tceerojo!45}",
        "\\colorlet{dif3}{tceerojo!15}",
        "\\colorlet{dif4}{tceeverde!18}",
        "\\colorlet{dif5}{tceeverde!45}",
        "\\colorlet{dif6}{tceeverde!72}",
        "\\colorlet{dif7}{tceeverde!100}",
        "\\colorlet{sindato}{black!8}",
        "\\begin{tikzpicture}[tcee]",
    ]


def leer_csv(nombre):
    filas = [l for l in (AQUI / nombre).read_text(encoding="utf-8").splitlines() if l and not l.startswith("#")]
    cab = filas[0].split(";")
    return [dict(zip(cab, f.split(";"))) for f in filas[1:]]


def main():
    carpeta = Path(sys.argv[1])
    n21 = leer(carpeta / "NUTS_RG_20M_2021_4326_LEVL_2.geojson")
    n24 = leer(carpeta / "NUTS_RG_20M_2024_4326_LEVL_2.geojson")
    p0 = leer(carpeta / "NUTS_RG_20M_2024_4326_LEVL_0.geojson")
    fondo = leer(carpeta / "CNTR_RG_20M_2024_4326.geojson", "CNTR_ID")
    fondo = {k: v for k, v in fondo.items() if k not in EU_ISO and k != "GR"}

    # ---------------- Mapa 1: categorías 2021-2027 ----------------
    cat = {f["nuts"]: f["categoria"] for f in leer_csv("mapa-categorias.csv")}
    n = {c: sum(1 for v in cat.values() if v == c) for c in ("menos", "transicion", "mas")}
    m = Mapa(12.0, 0.95)
    regiones = {k: v for k, v in n21.items() if k in cat}
    lin = cabecera(["Categorías de regiones de la política de cohesión 2021-2027 (FEDER y FSE+), regiones NUTS 2 (NUTS 2021).",
                    "Datos: ../datos/mapa-categorias.csv (Decisión de Ejecución (UE) 2021/1130, anexos I-III)."],
                   "Capas: 1 tierra fuera de la UE; 2 regiones por categoría; 3 fronteras de los Estados; 4 recuadros; 5 leyenda.")
    colores = {"menos": "catmenos", "transicion": "cattransicion", "mas": "catmas"}
    lin += dibujar(m, regiones, lambda c: colores[cat[c]], fondo, p0)
    lin.append("\\capa{5}{")
    lin.append("\\node[anchor=north west,font=\\scriptsize\\bfseries,inner sep=0pt] at (0.2,-0.15) {Categoría según el PIB por habitante en PPA de 2015-2017 (UE-27 = 100) y número de regiones};")
    lin += leyenda(0.2, -0.45, [
        ("catmenos", f"menos desarrolladas (menos de 75): {n['menos']}", False),
        ("cattransicion", f"en transición (de 75 a 100): {n['transicion']}", False)], "", sep=0.3)
    lin += leyenda(6.4, -0.45, [
        ("catmas", f"más desarrolladas (más de 100): {n['mas']}", False),
        ("mapafuera", "fuera de la UE", False)], "", sep=0.3)
    lin.append("}")
    lin += ["\\end{tikzpicture}", "\\end{document}"]
    (GRAF / "mapa-categorias.tex").write_text("\n".join(lin) + "\n", encoding="utf-8")

    # ---------------- Mapa 2: PIB por habitante 2024 y variación 2000-2024 ----------------
    pib = {f["nuts"]: f for f in leer_csv("mapa-pib-regional.csv")}
    cortes = [50, 75, 90, 100, 125, 150]
    cdif = [-20, -10, 0, 10, 20, 40]

    def clase(x, cs):
        return sum(x >= c for c in cs) + 1

    m2 = Mapa(7.9, 0.62, tol=0.014, area_min=0.0015, hueco=0.3)
    regiones = {k: v for k, v in n24.items() if k in pib}
    lin = cabecera(["PIB por habitante en PPA de las regiones NUTS 2 (NUTS 2024), UE-27 = 100: a la izquierda, el nivel de 2024;",
                    "a la derecha, la variación en puntos de 2000 a 2024 (con trama, sin dato de 2000).",
                    "Datos: ../datos/mapa-pib-regional.csv (Eurostat, nama_10r_2gdp)."],
                   "Capas: 1 tierra fuera de la UE; 2 regiones; 3 fronteras; 4 recuadros; 5 leyenda (en cada panel).")
    cuenta = {}
    for c in pib:
        k = clase(float(pib[c]["idx2024"]), cortes)
        cuenta[k] = cuenta.get(k, 0) + 1
    lin.append("\\node[anchor=south west,font=\\footnotesize\\bfseries,inner sep=0pt] at (0,%.2f) {a) Nivel en 2024 (UE-27 = 100)};" % (m2.alto + 0.12))
    lin += dibujar(m2, regiones, lambda c: f"pib{clase(float(pib[c]['idx2024']), cortes)}", fondo, p0, tam_rotulo="\\fontsize{4.5}{5}\\selectfont")
    textos = ["menos de 50", "50-75", "75-90", "90-100", "100-125", "125-150", "150 o más"]
    lin.append("\\capa{5}{")
    lin += leyenda(0.0, -0.35, [(f"pib{i}", f"{t} ({cuenta.get(i, 0)})", False) for i, t in list(enumerate(textos, 1))[:4]],
                   "", sep=0.25, ancho_caja=0.28, fuente="\\scriptsize")
    lin += leyenda(2.6, -0.35, [(f"pib{i}", f"{t} ({cuenta.get(i, 0)})", False) for i, t in list(enumerate(textos, 1))[4:]],
                   "", sep=0.25, ancho_caja=0.28, fuente="\\scriptsize")
    lin.append("}")
    # panel b
    dx = m2.ancho + 0.45
    cuenta = {}
    for c in pib:
        if pib[c]["dif"]:
            k = clase(float(pib[c]["dif"]), cdif)
            cuenta[k] = cuenta.get(k, 0) + 1
    sin = sum(1 for c in pib if not pib[c]["dif"])
    lin.append("\\node[anchor=south west,font=\\footnotesize\\bfseries,inner sep=0pt] at (%.2f,%.2f) {b) Variación 2000-2024 (puntos)};" % (dx, m2.alto + 0.12))
    lin += dibujar(m2, regiones,
                   lambda c: (f"dif{clase(float(pib[c]['dif']), cdif)}" if pib[c]["dif"] else "sindato"),
                   fondo, p0, desplaza=(dx, 0), trama_de=lambda c: not pib[c]["dif"],
                   tam_rotulo="\\fontsize{4.5}{5}\\selectfont")
    textos = ["menos de $-20$", "de $-20$ a $-10$", "de $-10$ a 0", "de 0 a 10", "de 10 a 20", "de 20 a 40", "40 o más"]
    lin.append("\\capa{5}{")
    lin += leyenda(dx, -0.35, [(f"dif{i}", f"{t} ({cuenta.get(i, 0)})", False) for i, t in list(enumerate(textos, 1))[:4]],
                   "", sep=0.25, ancho_caja=0.28, fuente="\\scriptsize")
    lin += leyenda(dx + 2.9, -0.35, [(f"dif{i}", f"{t} ({cuenta.get(i, 0)})", False) for i, t in list(enumerate(textos, 1))[4:]]
                   + [("sindato", f"sin dato de 2000 ({sin})", True)],
                   "", sep=0.25, ancho_caja=0.28, fuente="\\scriptsize")
    lin.append("}")
    lin += ["\\end{tikzpicture}", "\\end{document}"]
    (GRAF / "mapa-pib-regional.tex").write_text("\n".join(lin) + "\n", encoding="utf-8")
    for f in ("mapa-categorias.tex", "mapa-pib-regional.tex"):
        print(GRAF / f, (GRAF / f).stat().st_size // 1024, "KB")


if __name__ == "__main__":
    main()
