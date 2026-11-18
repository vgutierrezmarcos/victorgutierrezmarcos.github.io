#!/usr/bin/env python3
# Genera ../graficos/mapa-bloques.tex: mapa del mundo (proyección Equal Earth)
# con los principales procesos de integración no comunitarios.
#
# Uso: python3 mapa-bloques.py RUTA/ne_50m_admin_0_countries.geojson
#   El contorno de los países es Natural Earth, 1:50 millones, admin 0
#   (dominio público; https://www.naturalearthdata.com), en GeoJSON:
#   https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_50m_admin_0_countries.geojson
#   Las pertenencias salen de mapa-bloques.csv (fuentes en su cabecera).
# Solo usa la biblioteca estándar. Autor: Víctor Gutiérrez Marcos
import csv
import json
import math
import sys
from collections import defaultdict
from pathlib import Path

AQUI = Path(__file__).resolve().parent
SALIDA = AQUI.parent / "graficos" / "mapa-bloques.tex"

ANCHO = 16.6          # cm, el ancho del texto
TOL = 0.010           # cm, tolerancia de Douglas-Peucker
AREA_MIN = 0.0015     # cm², anillos menores se quitan (salvo el mayor de un miembro)
LAT_MIN = -57.0

# Códigos de Natural Earth que no coinciden con ISO 3166-1
ALIAS = {"KOS": "XKX", "SDS": "SSD", "SOL": "SOM", "PSX": "PSE", "SAH": "ESH",
         "CYN": "CYP"}

UE = ("AUT BEL BGR HRV CYP CZE DNK EST FIN FRA DEU GRC HUN IRL ITA LVA LTU LUX "
      "MLT NLD POL PRT ROU SVK SVN ESP SWE").split()

# Bloque que da el color a cada país, por prioridad (el primero que lo tenga)
PRIORIDAD = ["T-MEC", "SICA", "Mercosur", "CAN", "AP", "CARICOM", "AELC", "CEFTA",
             "UEE", "CCG", "SAFTA", "ASEAN", "RCEP", "SACU", "EAC", "CEMAC",
             "CEDEAO", "UMA", "SADC", "COMESA"]
COLOR = {"T-MEC": "mapaazul", "Mercosur": "mapaverde", "CAN": "mapanaranja",
         "AP": "mapadorado", "SICA": "maparojo", "CARICOM": "mapamorado",
         "AELC": "mapaazul", "CEFTA": "mapanaranja", "UEE": "maparojo",
         "CCG": "mapadorado", "SAFTA": "mapaverde", "ASEAN": "mapanaranja",
         "RCEP": "mapaazul", "SACU": "maparojo", "EAC": "mapanaranja",
         "CEMAC": "mapaazul", "CEDEAO": "mapaverde", "UMA": "maparojo",
         "SADC": "mapadorado", "COMESA": "mapamorado"}
# Grupos para las capas del vídeo
CAPA_BLOQUE = {"T-MEC": 3, "SICA": 3, "Mercosur": 3, "CAN": 3, "AP": 3,
               "CARICOM": 3, "AELC": 4, "CEFTA": 4, "UEE": 4, "CCG": 5,
               "SAFTA": 5, "ASEAN": 5, "RCEP": 5, "SACU": 6, "EAC": 6,
               "CEMAC": 6, "CEDEAO": 6, "UMA": 6, "SADC": 6, "COMESA": 6}
# Con trama gris: miembro suspendido (Venezuela) y los que salieron de la CEDEAO
TRAMA_GRIS = {"VEN": "mapaverde", "MLI": "mapagris", "BFA": "mapagris",
              "NER": "mapagris"}

# Rótulos: (texto, lon, lat, opciones de nodo, [lon, lat] del destino de una línea guía)
ROTULOS = [
    ("T-MEC", -101, 45, "", None),
    ("SICA", -100, 8, "anchor=east", (-86, 14)),
    ("CARICOM", -62, 24, "anchor=west", (-66, 18)),
    ("CAN", -95, -6, "anchor=east", (-78, -4)),
    ("AP", -88, -30, "anchor=east", (-72, -30)),
    ("Mercosur", -50, -9, "", None),
    ("AELC", -32, 64, "anchor=east", (-20, 65)),
    ("CEFTA", 8, 37, "anchor=east", (19, 42)),
    ("UE", 10, 49, "text=black!70", None),
    ("UEE", 75, 61, "", None),
    ("CCG", 52, 17, "anchor=north", (48, 23)),
    ("SAFTA", 78, 20, "", None),
    ("ASEAN", 96, -2, "anchor=east", (102, 6)),
    ("RCEP", 104, 34, "", None),
    ("RCEP", 130, -27, "", None),
    ("CEDEAO", -24, 3, "anchor=east", (-6, 9)),
    ("AES", -1, 18, "font=\\tiny", None),
    ("UMA", 4, 28, "", None),
    ("CEMAC", 4, -6, "anchor=east", (14, 3)),
    ("COMESA", 33, 18, "", None),
    ("EAC", 50, -2, "anchor=west", (35, 0)),
    ("SADC", 18, -12, "", None),
    ("SACU", 7, -30, "anchor=east", (22, -27)),
]


# --------------------------------------------------------------------------
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


# --------------------------------------------------------------------------
def leer_bloques():
    filas = [l for l in (AQUI / "mapa-bloques.csv").read_text(encoding="utf-8").splitlines()
             if l and not l.startswith("#")]
    bloques = {}
    for f in csv.DictReader(filas, delimiter=";"):
        bloques[f["siglas"]] = (f["tipo"], f["miembros"].split())
    return bloques


def leer_paises(ruta):
    datos = json.loads(Path(ruta).read_text(encoding="utf-8"))
    paises = defaultdict(list)          # iso -> lista de anillos exteriores (lon, lat)
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


def contorno(paises, isos):
    """Contorno exterior de un grupo de países: los lados que comparten 2 países se anulan."""
    cuenta = defaultdict(int)
    lados = []
    for iso in isos:
        for anillo in paises.get(iso, []):
            pts = [(round(x, 5), round(y, 5)) for x, y in anillo]
            for a, b in zip(pts, pts[1:]):
                if a == b:
                    continue
                clave = (a, b) if a < b else (b, a)
                cuenta[clave] += 1
                lados.append((a, b))
    libres = [(a, b) for a, b in lados if cuenta[(a, b) if a < b else (b, a)] == 1]
    siguiente = defaultdict(list)
    for a, b in libres:
        siguiente[a].append(b)
    usados = set()
    cadenas = []
    for a, b in libres:
        if (a, b) in usados:
            continue
        cadena = [a, b]
        usados.add((a, b))
        while True:
            ult = cadena[-1]
            nuevos = [c for c in siguiente[ult] if (ult, c) not in usados]
            if not nuevos:
                break
            usados.add((ult, nuevos[0]))
            cadena.append(nuevos[0])
            if nuevos[0] == cadena[0]:
                break
        cadenas.append(cadena)
    salida = []
    for c in cadenas:
        pts = dp([proy(*p) for p in c], TOL * 1.5)
        if max(p[0] for p in pts) < -ANCHO / 2 + 0.6:
            continue  # restos al otro lado de la línea de cambio de fecha
        if len(pts) >= 2 and (len(pts) > 3 or math.hypot(pts[0][0] - pts[-1][0], pts[0][1] - pts[-1][1]) > 0.15):
            salida.append(pts)
    return salida


def main():
    ruta = sys.argv[1]
    bloques = leer_bloques()
    paises = leer_paises(ruta)
    pertenece = defaultdict(list)
    for sig, (tipo, miembros) in bloques.items():
        for iso in miembros:
            pertenece[iso].append(sig)
    for iso in pertenece:
        if iso not in paises:
            print("Aviso: sin contorno", iso, file=sys.stderr)

    # Geometría proyectada y simplificada
    geo, punto, diminuto = {}, {}, set()
    for iso, anillos in paises.items():
        proyectados = []
        for r in anillos:
            pr = [proy(x, y) for x, y in r]
            proyectados.append(pr)
        proyectados.sort(key=area, reverse=True)
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

    def color_de(iso):
        for b in PRIORIDAD:
            if b in pertenece.get(iso, []):
                return b
        return None

    lin = []
    w = lin.append
    w("% Mapa de los principales procesos de integración no comunitarios (noviembre de 2026).")
    w("% GENERADO por ../datos/mapa-bloques.py a partir de Natural Earth 1:50m (dominio público)")
    w("% y de ../datos/mapa-bloques.csv (pertenencias y fuentes). No editar a mano: cambiar el CSV")
    w("% o el script y volver a generarlo.")
    w("% Proyección Equal Earth; color = bloque regional principal de cada país; trama morada = CPTPP;")
    w("% contorno morado = RCEP; contorno discontinuo = ZLECAf; número = acuerdos del mapa a los que pertenece.")
    w("% Capas: 1 tierra; 2 UE; 3 América; 4 Europa y Eurasia; 5 Asia y Oriente Medio; 6 África;")
    w("% 7 trama del CPTPP; 8 contorno del RCEP; 9 contorno de la ZLECAf; 10 números; 11 rótulos; 12 leyenda.")
    w("% Autor: Víctor Gutiérrez Marcos")
    w("\\documentclass[tikz,border=2pt]{standalone}")
    w("\\input{../../../latex/tikz-tcee}")
    w("\\begin{document}")
    w("\\colorlet{mapatierra}{black!9}")
    w("\\colorlet{mapaue}{black!28}")
    w("\\colorlet{mapaazul}{tceeazul!45}")
    w("\\colorlet{mapaverde}{tceeverde!45}")
    w("\\colorlet{mapanaranja}{tceenaranja!50}")
    w("\\colorlet{mapadorado}{tceedorado!45}")
    w("\\colorlet{maparojo}{tceerojo!40}")
    w("\\colorlet{mapamorado}{tceemorado!35}")
    w("\\colorlet{mapagris}{black!18}")
    w("\\definecolor{tceemoradooscuro}{HTML}{4A1F6B}")
    w("\\tikzset{frontera/.style={draw=white,line width=0.15pt},")
    w("  rotulo/.style={font=\\scriptsize\\bfseries,inner sep=1pt,text=black},")
    w("  guiarotulo/.style={draw=black!60,line width=0.3pt},")
    w("  numero/.style={circle,draw=black!70,line width=0.25pt,fill=white,inner sep=0.2pt,")
    w("    minimum size=5.6pt,font=\\fontsize{4.5}{4.5}\\selectfont\\bfseries}}")
    w("\\begin{tikzpicture}[tcee]")
    y0 = proy(0, LAT_MIN)[1]
    y1 = proy(0, 84)[1]
    w(f"\\clip ({-ANCHO/2-0.05:.2f},{y0:.2f}) rectangle ({ANCHO/2+0.05:.2f},{y1+0.05:.2f});")
    # 1: tierra
    w("% 1: tierra")
    w("\\capa{1}{\\fill[mapatierra] " + camino([r for iso in sorted(geo) for r in geo[iso]]) + ";}")
    # 2: UE
    w("% 2: la UE, como referencia")
    w("\\capa{2}{\\filldraw[mapaue,frontera] " + camino([r for iso in UE if iso in geo for r in geo[iso]]) + ";}")
    # 3-6: bloques
    por_capa = defaultdict(list)
    for iso in sorted(geo):
        b = color_de(iso)
        if b:
            por_capa[CAPA_BLOQUE[b]].append((iso, b))
    nombres = {3: "América", 4: "Europa y Eurasia", 5: "Asia y Oriente Medio", 6: "África"}
    for c in (3, 4, 5, 6):
        w(f"% {c}: {nombres[c]}")
        w(f"\\capa{{{c}}}{{")
        for iso, b in por_capa[c]:
            w(f"  \\filldraw[{COLOR[b]},frontera] {camino(geo[iso])}; % {iso} ({b})")
            if iso in diminuto:
                x, y = punto[iso]
                w(f"  \\filldraw[{COLOR[b]},draw=black!60,line width=0.2pt] ({x:.2f},{y:.2f}) circle (0.045);")
        if c == 3:
            iso = "VEN"
            w(f"  \\filldraw[{TRAMA_GRIS[iso]}!50,frontera] {camino(geo[iso])}; % VEN (Mercosur, suspendida)")
            w(trama(geo[iso], "black!45", -1))
        if c == 6:
            for iso in ("MLI", "BFA", "NER"):
                w(f"  \\filldraw[mapagris,frontera] {camino(geo[iso])}; % {iso} (AES, salió de la CEDEAO en 2025)")
            w(trama([r for i in ("MLI", "BFA", "NER") for r in geo[i]], "black!45", -1))
        w("}")
    # 7: CPTPP
    w("% 7: trama del CPTPP")
    cptpp = bloques["CPTPP"][1]
    w("\\capa{7}{" + trama([r for iso in cptpp for r in geo[iso]], "tceemoradooscuro", 1, 0.07, 0.35))
    for iso in cptpp:
        if iso in diminuto:
            x, y = punto[iso]
            w(f"  \\draw[tceemoradooscuro,line width=0.5pt] ({x:.2f},{y:.2f}) circle (0.06);")
    w("}")
    # 8: RCEP
    w("% 8: contorno del RCEP")
    rcep = contorno(paises, bloques["RCEP"][1])
    w("\\capa{8}{\\draw[tceemorado,line width=0.7pt] "
      + " ".join(" -- ".join(fmt(p) for p in c) for c in rcep) + ";}")
    # 9: ZLECAf
    w("% 9: contorno de la ZLECAf (toda la Unión Africana salvo Eritrea)")
    africa = [iso for iso in geo if iso in AFRICA and iso != "ERI"]
    zl = contorno(paises, africa)
    w("\\capa{9}{\\draw[black!75,line width=0.55pt,dash pattern=on 2pt off 1.2pt] "
      + " ".join(" -- ".join(fmt(p) for p in c) for c in zl) + ";}")
    # 10: números
    w("% 10: número de acuerdos del mapa a los que pertenece cada país (si son 2 o más)")
    w("\\capa{10}{")
    for iso in sorted(pertenece):
        n = len(pertenece[iso])
        if n >= 2 and iso in punto:
            x, y = proy(*POS[iso]) if iso in POS else punto[iso]
            w(f"  \\node[numero] at ({x:.2f},{y:.2f}) {{{n}}}; % {iso}: {' '.join(pertenece[iso])}")
    w("}")
    # 11: rótulos
    w("% 11: rótulos de los bloques")
    w("\\capa{11}{")
    for texto, lon, lat, opc, dest in ROTULOS:
        x, y = proy(lon, lat)
        if dest:
            xd, yd = proy(*dest)
            w(f"  \\draw[guiarotulo] ({x:.2f},{y:.2f}) -- ({xd:.2f},{yd:.2f});")
        w(f"  \\node[rotulo,{opc}] at ({x:.2f},{y:.2f}) {{{texto}}};")
    w("}")
    # 12: leyenda
    lx, ly = proy(-176, -13)
    w("% 12: leyenda")
    w("\\capa{12}{")
    w(f"\\begin{{scope}}[shift={{({lx:.2f},{ly:.2f})}},font=\\fontsize{{6}}{{7}}\\selectfont]")
    w("  \\fill[mapaazul] (0,0) rectangle (0.32,0.2);")
    w("  " + trama([[(0, 0), (0.32, 0), (0.32, 0.2), (0, 0.2)]], "tceemoradooscuro", 1, 0.07, 0.35))
    w("  \\node[anchor=west] at (0.38,0.1) {CPTPP (trama)};")
    w("  \\draw[tceemorado,line width=0.7pt] (0,-0.25) -- (0.32,-0.25);")
    w("  \\node[anchor=west] at (0.38,-0.25) {RCEP (contorno)};")
    w("  \\draw[black!75,line width=0.55pt,dash pattern=on 2pt off 1.2pt] (0,-0.6) -- (0.32,-0.6);")
    w("  \\node[anchor=west] at (0.38,-0.6) {ZLECAf (contorno)};")
    w("  \\node[numero] at (0.16,-0.95) {3};")
    w("  \\node[anchor=west,align=left] at (0.38,-0.95) {n.º de acuerdos del mapa};")
    w("  \\fill[mapagris] (0,-1.4) rectangle (0.32,-1.2);")
    w("  " + trama([[(0, -1.4), (0.32, -1.4), (0.32, -1.2), (0, -1.2)]], "black!45", -1))
    w("  \\node[anchor=west] at (0.38,-1.3) {salida o suspensión};")
    w("  \\fill[mapaue] (0,-1.75) rectangle (0.32,-1.55);")
    w("  \\node[anchor=west] at (0.38,-1.65) {UE (referencia)};")
    w("\\end{scope}}")
    w("\\end{tikzpicture}")
    w("\\end{document}")
    SALIDA.write_text("\n".join(lin) + "\n", encoding="utf-8")
    print(SALIDA, sum(len(l) for l in lin) // 1024, "KB")


AFRICA = set(("DZA AGO BEN BWA BFA BDI CPV CMR CAF TCD COM COD COG CIV DJI EGY GNQ ERI SWZ "
              "ETH GAB GMB GHA GIN GNB KEN LSO LBR LBY MDG MWI MLI MRT MUS MAR MOZ NAM NER "
              "NGA RWA STP SEN SYC SLE SOM ZAF SSD SDN TZA TGO TUN UGA ZMB ZWE ESH").split())
# Ajustes a mano de la posición de algunos números (cm)
POS = {"MMR": (96, 21), "THA": (101, 15.5), "LAO": (102.8, 19.8), "KHM": (105, 12.5),
       "VNM": (108.2, 14.2), "MYS": (102, 4.3), "SGP": (104.5, 0.2), "BRN": (114.5, 7.6),
       "IDN": (113, -1), "PHL": (122.5, 12), "SEN": (-14.6, 15), "GNB": (-15.2, 11.6),
       "CIV": (-5.5, 7.5), "TGO": (0.6, 7.6), "BEN": (2.6, 10.8), "RWA": (29.4, -1.0),
       "BDI": (30.4, -4.2), "UGA": (32.4, 1.6), "KEN": (37.9, 0.5), "TZA": (35, -6.5),
       "COD": (23, -2), "SOM": (45, 4), "ZAF": (23, -30.5), "LSO": (28.3, -29.6),
       "SWZ": (32.0, -26.2), "BWA": (24, -22), "NAM": (17.5, -21), "ZWE": (29.8, -19),
       "ZMB": (26.5, -14), "MWI": (34.2, -12.6), "MDG": (46.8, -19.5), "COM": (43.5, -11.8),
       "MUS": (57.5, -20.3), "SYC": (55.5, -4.6), "LBY": (18, 27), "TUN": (9.5, 33.5),
       "BOL": (-64.5, -17), "COL": (-73, 4), "PER": (-75, -9.5), "CHL": (-69.6, -23.5),
       "MEX": (-102, 24), "BLZ": (-86.6, 17.6), "AUS": (145, -22), "NZL": (172, -41)}

if __name__ == "__main__":
    main()
