#!/usr/bin/env python3
"""
Mapas coropléticos del 3.B.28: grupos de renta del Banco Mundial (julio de
2026) y niveles de desarrollo humano del PNUD (IDH de 2023, Informe 2025).

    python3 mapas-desarrollo.py              # escribe mapa-renta.tex y mapa-idh.tex
    python3 mapas-desarrollo.py --descargar  # además, vuelve a bajar los datos

Lee los CSV de ../datos/ (clasificacion-renta-bm.csv e idh-paises.csv) y las
fronteras de Natural Earth 1:110 millones (dominio público,
../datos/ne_110m_paises.geojson), proyecta con la proyección Equal Earth
(Šavrič, Patterson y Jenny, 2018) y escribe un TikZ standalone por mapa, con
una capa por grupo para el vídeo. Después se compilan como los demás
gráficos (construir-tema.py). Sin dependencias fuera de la biblioteca estándar.

Autor: Víctor Gutiérrez Marcos
"""
import csv
import json
import math
import os
import sys
import urllib.request

AQUI = os.path.dirname(os.path.abspath(__file__))
DATOS = os.path.join(AQUI, '..', 'datos')
GEO = os.path.join(DATOS, 'ne_110m_paises.geojson')
RENTA = os.path.join(DATOS, 'clasificacion-renta-bm.csv')
IDH = os.path.join(DATOS, 'idh-paises.csv')

URL_GEO = ('https://raw.githubusercontent.com/nvkelso/natural-earth-vector/'
           'master/geojson/ne_110m_admin_0_countries.geojson')
URL_BM = 'https://api.worldbank.org/v2/country?format=json&per_page=400'
URL_IDH = ('https://hdr.undp.org/sites/default/files/2025_HDR/'
           'HDR25_Composite_indices_complete_time_series.csv')

# Territorios de Natural Earth sin código ISO propio: se pintan con el país al
# que los asignan el Banco Mundial y el PNUD.
EQUIVALENCIAS = {'KOS': 'XKX', 'SOL': 'SOM', 'CYN': 'CYP', 'SAH': 'ESH'}

ANCHO = 15.0   # cm


def abrir(url):
    return urllib.request.urlopen(urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'}), timeout=120)


def descargar():
    with abrir(URL_GEO) as r, open(GEO, 'wb') as f:
        f.write(r.read())
    with abrir(URL_BM) as r:
        paises = json.load(r)[1]
    fecha = __import__('datetime').date.today().strftime('%d/%m/%Y')
    with open(RENTA, 'w', encoding='utf-8', newline='\n') as f:
        f.write('# Clasificación de las economías por renta del Banco Mundial, ejercicio 2027 '
                '(vigente desde el 1 de julio de 2026; RNB por habitante de 2025, método Atlas). '
                f'Fuente: API del Banco Mundial, {URL_BM} (campo incomeLevel). '
                'Umbrales: renta baja hasta 1.175 $; media-baja 1.176-4.635 $; media-alta '
                '4.636-14.375 $; alta más de 14.375 $. Recuento: 25 baja, 47 media-baja, '
                f'59 media-alta, 86 alta. Fecha de consulta: {fecha}\n')
        w = csv.writer(f)
        w.writerow(['iso3', 'pais', 'grupo'])
        for p in paises:
            if p['region']['id'] == 'NA':      # agregados
                continue
            w.writerow([p['id'], p['name'].replace(',', ' -'), p['incomeLevel']['id']])
    with abrir(URL_IDH) as r:
        texto = r.read().decode('latin-1')
    filas = list(csv.DictReader(texto.splitlines()))
    with open(IDH, 'w', encoding='utf-8', newline='\n') as f:
        f.write('# Índice de desarrollo humano de 2023 por país y su nivel (PNUD: muy alto '
                '>= 0,800; alto 0,700-0,799; medio 0,550-0,699; bajo < 0,550). Fuente: PNUD, '
                f'Informe sobre Desarrollo Humano 2025, {URL_IDH} . Fecha de consulta: {fecha}\n')
        w = csv.writer(f)
        w.writerow(['iso3', 'pais', 'idh_2023', 'nivel'])
        for r in filas:
            if r['iso3'].startswith('ZZ') or not r['hdi_2023']:
                continue
            v = float(r['hdi_2023'])
            nivel = 'muy_alto' if v >= 0.8 else 'alto' if v >= 0.7 else 'medio' if v >= 0.55 else 'bajo'
            w.writerow([r['iso3'], r['country'].replace(',', ' -'), f'{v:.3f}', nivel])


def leer(ruta, col):
    with open(ruta, encoding='utf-8') as f:
        lineas = [l for l in f if not l.startswith('#')]
    return {r['iso3']: r[col] for r in csv.DictReader(lineas)}


def equal_earth(lon, lat):
    a1, a2, a3, a4 = 1.340264, -0.081106, 0.000893, 0.003796
    m = math.sqrt(3) / 2
    lam, phi = math.radians(lon), math.radians(lat)
    t = math.asin(m * math.sin(phi))
    t2, t6 = t * t, t ** 6
    x = 2 * math.sqrt(3) * lam * math.cos(t) / (3 * (a1 + 3 * a2 * t2 + t6 * (7 * a3 + 9 * a4 * t2)))
    y = t * (a1 + a2 * t2 + t6 * (a3 + a4 * t2))
    return x, y


def poligonos(geom):
    if geom['type'] == 'Polygon':
        return [geom['coordinates']]
    return geom['coordinates']


def caminos(geom, escala):
    """Un camino TikZ por anillo exterior (los lagos interiores se omiten)."""
    salida = []
    for pol in poligonos(geom):
        anillo = pol[0]
        pts = []
        for lon, lat in anillo:
            x, y = equal_earth(lon, lat)
            p = f'({x * escala:.2f},{y * escala:.2f})'
            if not pts or pts[-1] != p:
                pts.append(p)
        if len(pts) > 3:
            salida.append(' -- '.join(pts) + ' -- cycle')
    return salida


def escribir(nombre, titulo_com, clases, asignacion, leyenda_titulo):
    geo = json.load(open(GEO, encoding='utf-8'))
    escala = ANCHO / (2 * equal_earth(180, 0)[0])
    grupos = {c: [] for c, _, _ in clases}
    sin = []
    for f in geo['features']:
        p = f['properties']
        if p['ADM0_A3'] == 'ATA':      # sin la Antártida
            continue
        cod = p['ISO_A3_EH'] if p['ISO_A3_EH'] != '-99' else p['ADM0_A3']
        cod = EQUIVALENCIAS.get(cod, cod)
        g = asignacion.get(cod)
        (grupos[g] if g in grupos else sin).extend(caminos(f['geometry'], escala))
    l = []
    l.append(titulo_com)
    l.append('% Generado por mapas-desarrollo.py (no editar a mano). Proyección Equal Earth,')
    l.append('% fronteras de Natural Earth 1:110 millones (dominio público), sin la Antártida.')
    l.append('% Capas: 1 todos los países en gris (sin datos); 2 a 5, un grupo cada una,')
    l.append('% de menor a mayor; 6 la leyenda.')
    l.append('% Autor: Víctor Gutiérrez Marcos')
    l.append('\\documentclass[tikz,border=4pt]{standalone}')
    l.append('\\input{../../../latex/tikz-tcee}')
    l.append('\\begin{document}')
    l.append('\\begin{tikzpicture}[tcee,line join=round]')
    ymin = equal_earth(0, -58)[1] * escala
    ymax = equal_earth(0, 84)[1] * escala
    l.append(f'  \\path ({-ANCHO / 2 - 0.1:.2f},{ymin - 1.6:.2f}) rectangle ({ANCHO / 2 + 0.1:.2f},{ymax + 0.1:.2f});')
    pais = 'draw=white,line width=0.15pt'
    todos = sin + [c for k in grupos for c in grupos[k]]
    l.append('  % 1: el mapa en gris')
    l.append('  \\capa{1}{')
    for c in todos:
        l.append(f'    \\fill[tceegris!25,{pais}] {c};')
    l.append('  }')
    for i, (clave, color, rotulo) in enumerate(clases, start=2):
        l.append(f'  % {i}: {rotulo}')
        l.append(f'  \\capa{{{i}}}{{')
        for c in grupos[clave]:
            l.append(f'    \\fill[{color},{pais}] {c};')
        l.append('  }')
    # leyenda debajo, en una fila
    n = len(clases) + 1
    paso = ANCHO / n
    y = ymin - 0.9
    l.append(f'  % {len(clases) + 2}: la leyenda')
    l.append(f'  \\capa{{{len(clases) + 2}}}{{')
    l.append(f'    \\node[font=\\footnotesize\\itshape,text=tceegris,anchor=south] at (0,{y + 0.35:.2f}) {{{leyenda_titulo}}};')
    items = [(color, rotulo) for _, color, rotulo in clases] + [('tceegris!25', 'sin datos')]
    for j, (color, rotulo) in enumerate(items):
        x0 = -ANCHO / 2 + j * paso + 0.2
        l.append(f'    \\fill[{color}] ({x0:.2f},{y - 0.15:.2f}) rectangle ({x0 + 0.45:.2f},{y + 0.15:.2f});')
        l.append(f'    \\node[anchor=west,font=\\footnotesize,align=left] at ({x0 + 0.5:.2f},{y:.2f}) {{{rotulo}}};')
    l.append('  }')
    l.append('\\end{tikzpicture}')
    l.append('\\end{document}')
    with open(os.path.join(AQUI, nombre + '.tex'), 'w', encoding='utf-8', newline='\n') as f:
        f.write('\n'.join(l) + '\n')


def main():
    if '--descargar' in sys.argv or not all(os.path.exists(x) for x in (GEO, RENTA, IDH)):
        descargar()
    # Paleta secuencial en morado (el color del temario): más oscuro, más renta
    # o más desarrollo humano.
    escribir('mapa-renta',
             '% Grupos de renta del Banco Mundial desde el 1 de julio de 2026 (ejercicio 2027;\n'
             '% RNB por habitante de 2025, método Atlas): ../datos/clasificacion-renta-bm.csv.',
             [('LIC', 'tceemorado!18', 'renta baja\\\\(hasta 1.175 \\$)'),
              ('LMC', 'tceemorado!42', 'renta media-baja\\\\(1.176-4.635 \\$)'),
              ('UMC', 'tceemorado!68', 'renta media-alta\\\\(4.636-14.375 \\$)'),
              ('HIC', 'tceemorado', 'renta alta\\\\(más de 14.375 \\$)')],
             leer(RENTA, 'grupo'),
             'RNB por habitante de 2025, en dólares corrientes (método Atlas)')
    escribir('mapa-idh',
             '% Niveles de desarrollo humano del PNUD, IDH de 2023 (Informe 2025):\n'
             '% ../datos/idh-paises.csv.',
             [('bajo', 'tceemorado!18', 'bajo\\\\(menos de 0,550)'),
              ('medio', 'tceemorado!42', 'medio\\\\(0,550-0,699)'),
              ('alto', 'tceemorado!68', 'alto\\\\(0,700-0,799)'),
              ('muy_alto', 'tceemorado', 'muy alto\\\\(0,800 o más)')],
             leer(IDH, 'nivel'),
             'índice de desarrollo humano de 2023')


if __name__ == '__main__':
    main()
