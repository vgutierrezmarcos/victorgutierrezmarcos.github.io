#!/usr/bin/env python3
"""
Datos de los gráficos del 3.B.32 (perspectivas económicas mundiales y
estructura de los flujos comerciales y financieros). Este tema se actualiza
cada año: basta con volver a ejecutar este script tras cada WEO de octubre
del FMI y revisar las cifras del texto con datos-actualizables.yaml.

    python3 datos-3B32.py            # baja todo y reescribe ../datos/*.csv y centro-gravedad.tex
    python3 datos-3B32.py --solo X   # solo una serie (crecimiento, ppa, centro, comercio,
                                     # productos, regiones, servicios, ied, bancos, gravedad,
                                     # convergencia)

Fuentes (todas públicas, sin clave):
- FMI, World Economic Outlook (DataMapper API): crecimiento, PIB en PPA.
- Banco Mundial, World Development Indicators (API v2): comercio por productos
  (CUCI), por regiones, servicios, IED, PIB por habitante en PPA.
- BPI, estadísticas bancarias territoriales (SDMX): activos transfronterizos.
- Naciones Unidas, Comtrade (API pública de consulta): exportaciones de España
  por país de destino.
- Natural Earth 1:110 millones (dominio público): fronteras y centroides.

Solo la biblioteca estándar de Python.

Autor: Víctor Gutiérrez Marcos
"""
import csv
import datetime
import io
import json
import math
import os
import sys
import subprocess
import time

AQUI = os.path.dirname(os.path.abspath(__file__))
DATOS = os.path.join(AQUI, '..', 'datos')
GEO = os.path.join(DATOS, 'ne_110m_paises.geojson')
HOY = datetime.date.today().strftime('%d/%m/%Y')
IMF = 'https://www.imf.org/external/datamapper/api/v1/'
WB = 'https://api.worldbank.org/v2/country/{p}/indicator/{i}?format=json&per_page=20000&date={d}'
BIS = ('https://stats.bis.org/api/v2/data/dataflow/BIS/WS_LBS_D_PUB/1.0/'
       'Q.S.C.A.TO1.A.5J.A.5A.A.{c}.N?startPeriod=1999&format=csv')
CT = ('https://comtradeapi.un.org/public/v1/preview/C/A/HS?reporterCode=724&period={a}'
      '&flowCode=X&cmdCode=TOTAL')
CT_REF = 'https://comtradeapi.un.org/files/v1/app/reference/partnerAreas.json'

_cache = {}


def bajar(url, intentos=4):
    if url in _cache:
        return _cache[url]
    for k in range(intentos):
        try:
            # curl, porque el servidor del FMI rechaza urllib (403)
            r = subprocess.run(['curl', '-s', '-f', '-L', '-m', '600', url], capture_output=True, check=True)
            _cache[url] = r.stdout
            return _cache[url]
        except Exception as e:  # noqa: BLE001
            print('  reintento', k + 1, url[:90], e, file=sys.stderr)
            time.sleep(5 * (k + 1))
    raise RuntimeError('no se pudo bajar ' + url)


def fmi(ind):
    return json.loads(bajar(IMF + ind))['values'][ind]


def bm(ind, paises='WLD', fechas='1980:2026'):
    d = json.loads(bajar(WB.format(p=paises, i=ind, d=fechas)))
    out = {}
    for x in d[1] or []:
        if x['value'] is not None:
            # algunos agregados (renta alta, XD) vienen sin código ISO3
            cod = x['countryiso3code'] or {'XD': 'HIC'}.get(x['country']['id'], x['country']['id'])
            out.setdefault(cod, {})[int(x['date'])] = x['value']
    return out


def escribir(nombre, cabecera, columnas, filas):
    ruta = os.path.join(DATOS, nombre)
    with open(ruta, 'w', encoding='utf-8', newline='\n') as f:
        f.write('# ' + cabecera + f' Fecha de consulta: {HOY}\n')
        w = csv.writer(f, lineterminator='\n')
        w.writerow(columnas)
        for fila in filas:
            w.writerow(fila)
    print('escrito', ruta, len(filas), 'filas')


def r1(x):
    return '' if x is None else f'{x:.2f}'


# --------------------------------------------------------------------------
def crecimiento():
    v = fmi('NGDP_RPCH')
    filas = [[a] + [r1(v[g].get(str(a))) for g in ('WEOWORLD', 'ADVEC', 'OEMDC')] for a in range(2000, 2032)]
    escribir('crecimiento-mundial.csv',
             'Crecimiento del PIB real (%), 2000-2031: mundo, economías avanzadas y economías de mercados '
             'emergentes y en desarrollo. FMI, World Economic Outlook de octubre de 2026 (DataMapper, '
             'NGDP_RPCH; grupos WEOWORLD, ADVEC, OEMDC), https://www.imf.org/external/datamapper/NGDP_RPCH . '
             'Desde 2026, previsiones.', ['anio', 'mundo', 'avanzadas', 'emergentes'], filas)
    regiones = [('USA', 'EE. UU.'), ('EURO', 'Zona del euro'), ('ESP', 'España'), ('JPN', 'Japón'),
                ('CHN', 'China'), ('IND', 'India'), ('AS5', 'ASEAN-5'), ('WE', 'América Latina'),
                ('MECA', 'Oriente Medio y Asia Central'), ('SSA', 'África subsahariana'),
                ('ADVEC', 'Avanzadas'), ('OEMDC', 'Emergentes y en desarrollo'), ('WEOWORLD', 'Mundo')]
    filas = [[c, e] + [r1(v[c].get(str(a))) for a in (2025, 2026, 2027)] for c, e in regiones]
    escribir('crecimiento-regiones.csv',
             'Crecimiento del PIB real (%) por economías y regiones, 2025 (estimación) y previsiones de 2026 y '
             '2027. FMI, World Economic Outlook de octubre de 2026 (DataMapper, NGDP_RPCH). ASEAN-5: '
             'Filipinas, Indonesia, Malasia, Singapur y Tailandia (grupo AS5).',
             ['codigo', 'nombre', 'c2025', 'c2026', 'c2027'], filas)
    p = fmi('PCPIPCH')
    filas = [[a] + [r1(p[g].get(str(a))) for g in ('WEOWORLD', 'ADVEC', 'OEMDC')] for a in range(2000, 2032)]
    escribir('inflacion-mundial.csv',
             'Inflación (IPC, media anual, %), 2000-2031. FMI, World Economic Outlook de octubre de 2026 '
             '(DataMapper, PCPIPCH). Desde 2026, previsiones.', ['anio', 'mundo', 'avanzadas', 'emergentes'], filas)


def ppa():
    v = fmi('PPPSH')
    filas = []
    for a in range(1980, 2032):
        s = str(a)
        x = [v[g].get(s) for g in ('USA', 'EU', 'JPN', 'CHN', 'IND')]
        resto = 100 - sum(x)
        filas.append([a] + [r1(y) for y in x] + [r1(resto), r1(v['ADVEC'].get(s)), r1(v['OEMDC'].get(s))])
    escribir('peso-pib-ppa.csv',
             'Peso en el PIB mundial en paridad de poder adquisitivo (%), 1980-2031. FMI, World Economic '
             'Outlook de octubre de 2026 (DataMapper, PPPSH), https://www.imf.org/external/datamapper/PPPSH . '
             'UE: los 27 actuales en toda la serie. resto = 100 - suma de los 5. avanzadas y emergentes: '
             'grupos ADVEC y OEMDC. Desde 2026, previsiones.',
             ['anio', 'eeuu', 'ue', 'japon', 'china', 'india', 'resto', 'avanzadas', 'emergentes'], filas)


# --------------------------------------------------------------------------
# Natural Earth: centroides y proyección Equal Earth (como el 3.B.28)
A1, A2, A3, A4 = 1.340264, -0.081106, 0.000893, 0.003796
M = math.sqrt(3) / 2


def equal_earth(lon, lat):
    l, p = math.radians(lon), math.radians(lat)
    t = math.asin(M * math.sin(p))
    t2 = t * t
    t6 = t2 * t2 * t2
    x = 2 * math.sqrt(3) * l * math.cos(t) / 3 / (9 * A4 * t6 * t2 + 7 * A3 * t6 + 3 * A2 * t2 + A1)
    y = t * (A4 * t6 * t2 + A3 * t6 + A2 * t2 + A1)
    return x, y


def geo():
    g = json.load(open(GEO, encoding='utf-8'))
    paises = {}
    for f in g['features']:
        pr = f['properties']
        iso = pr['ISO_A3'] if pr['ISO_A3'] not in ('-99', None) else pr['ADM0_A3']
        iso = {'SDS': 'SSD', 'KOS': 'XKX', 'SAH': 'ESH'}.get(iso, iso)
        geom = f['geometry']
        polis = geom['coordinates'] if geom['type'] == 'MultiPolygon' else [geom['coordinates']]
        paises[iso] = (pr.get('NAME_ES') or pr['NAME'], polis)
    return paises


def centroide(polis):
    """Centroide del polígono de mayor superficie (en grados), para que
    Alaska o los territorios de ultramar no desplacen el del país."""
    mejor, area_max = None, -1
    for poli in polis:
        anillo = poli[0]
        a = cx = cy = 0.0
        for (x0, y0), (x1, y1) in zip(anillo, anillo[1:]):
            c = x0 * y1 - x1 * y0
            a += c
            cx += (x0 + x1) * c
            cy += (y0 + y1) * c
        if abs(a) > area_max and a != 0:
            area_max, mejor = abs(a), (cx / (3 * a), cy / (3 * a))
    return mejor


def centro():
    v = fmi('PPPGDP')
    paises = geo()
    cent = {iso: centroide(p) for iso, (_, p) in paises.items()}
    anios = [1980, 1990, 2000, 2010, 2020, 2025, 2031]
    filas = []
    for a in anios:
        sx = sy = sz = tot = 0.0
        for iso, c in cent.items():
            y = v.get(iso, {}).get(str(a))
            if not y or not c:
                continue
            lon, lat = map(math.radians, c)
            sx += y * math.cos(lat) * math.cos(lon)
            sy += y * math.cos(lat) * math.sin(lon)
            sz += y * math.sin(lat)
            tot += y
        lat = math.degrees(math.atan2(sz, math.hypot(sx, sy)))
        lon = math.degrees(math.atan2(sy, sx))
        prof = 6371 * (1 - math.sqrt(sx * sx + sy * sy + sz * sz) / tot)
        x, yy = equal_earth(lon, lat)
        filas.append([a, f'{lat:.2f}', f'{lon:.2f}', f'{prof:.0f}', f'{x:.4f}', f'{yy:.4f}'])
    escribir('centro-gravedad.csv',
             'Centro de gravedad económico del mundo (método de Quah, 2011): media de los centroides de los '
             'países sobre la esfera, ponderada por el PIB en PPA (FMI, WEO de octubre de 2026, PPPGDP), '
             'proyectada sobre la superficie. Centroide de cada país: el de su polígono mayor en Natural '
             'Earth 1:110m. profundidad_km: distancia del centro de masas a la superficie. x, y: proyección '
             'Equal Earth (radio 1). 2031, previsión.',
             ['anio', 'lat', 'lon', 'profundidad_km', 'x', 'y'], filas)
    mapa_centro(paises, filas)


def mapa_centro(paises, filas):
    esc = 15.0 / (2 * equal_earth(180, 0)[0])
    # recorte: Europa, África, Asia (de 30° O a 150° E; de 15° S a 75° N)
    x0, _ = equal_earth(-60, 0)
    x1, _ = equal_earth(140, 0)
    _, y0 = equal_earth(0, 12)
    _, y1 = equal_earth(0, 84)
    esc = 15.0 / (x1 - x0)

    def P(lon, lat):
        x, y = equal_earth(lon, lat)
        return (x - (x0 + x1) / 2) * esc, (y - (y0 + y1) / 2) * esc
    w, h = (x1 - x0) * esc / 2, (y1 - y0) * esc / 2
    out = ['% Centro de gravedad económico del mundo, 1980-2031 (método de Quah, 2011), con el PIB en PPA',
           '% del FMI (WEO de octubre de 2026): ../datos/centro-gravedad.csv. Generado por datos-3B32.py',
           '% (no editar a mano). Proyección Equal Earth, fronteras de Natural Earth 1:110m (dominio',
           '% público), recortada a 60° O-140° E y 12° N-84° N.',
           '% Capas: 1 el mapa; 2 los puntos de 1980 a 2000; 3 los de 2010 a 2025; 4 la previsión de 2031.',
           '% Autor: Víctor Gutiérrez Marcos',
           '\\documentclass[tikz,border=4pt]{standalone}',
           '\\input{../../../latex/tikz-tcee}',
           '\\begin{document}',
           '\\begin{tikzpicture}[tcee,line join=round]',
           f'  \\clip ({-w:.2f},{-h:.2f}) rectangle ({w:.2f},{h:.2f});',
           '  \\capa{1}{']
    for iso, (_, polis) in paises.items():
        if iso == 'ATA':
            continue
        for poli in polis:
            pts = [P(lon, lat) for lon, lat in poli[0]]
            if all(abs(x) > w + 1 or abs(y) > h + 1 for x, y in pts):
                continue
            # quita los saltos de la línea de cambio de fecha
            camino = ' -- '.join(f'({x:.2f},{y:.2f})' for x, y in pts[::2] + [pts[-1]])
            out.append(f'    \\fill[tceegris!22,draw=white,line width=0.15pt] {camino} -- cycle;')
    out.append(f'    \\draw[tceegris!60] ({-w:.2f},{-h:.2f}) rectangle ({w:.2f},{h:.2f});')
    out.append('  }')
    pts = [(int(f[0]), *P(float(f[2]), float(f[1]))) for f in filas]
    grupos = [(2, [p for p in pts if p[0] <= 2000]), (3, [p for p in pts if 2000 <= p[0] <= 2025]),
              (4, [p for p in pts if p[0] >= 2025])]
    for capa, g in grupos:
        out.append(f'  \\capa{{{capa}}}{{')
        if len(g) > 1:
            estilo = 'dashed,-{Latex[length=2.2mm]}' if capa == 4 else ''
            out.append(f'    \\draw[tceemorado,very thick,{estilo}] ' +
                       ' -- '.join(f'({x:.2f},{y:.2f})' for _, x, y in g) + ';')
        for a, x, y in g:
            if capa == 3 and a == 2000:
                continue
            if capa == 4 and a == 2025:
                continue
            col = 'tceedorado' if a == 2031 else 'tceemorado'
            ancla = {1980: 'above', 1990: 'below', 2000: 'above', 2010: 'below', 2020: 'above',
                     2025: 'below left', 2031: 'right'}.get(a, 'above')
            out.append(f'    \\fill[{col}] ({x:.2f},{y:.2f}) circle (1.6pt) node[{ancla},font=\\scriptsize,'
                       f'text={col}] {{{a}}};')
        out.append('  }')
    out += ['\\end{tikzpicture}', '\\end{document}']
    ruta = os.path.join(AQUI, 'centro-gravedad.tex')
    open(ruta, 'w', encoding='utf-8', newline='\n').write('\n'.join(out) + '\n')
    print('escrito', ruta)


# --------------------------------------------------------------------------
def comercio():
    x = bm('NE.EXP.GNFS.KD.ZG', fechas='1981:2025').get('WLD', {})
    y = bm('NY.GDP.MKTP.KD.ZG', fechas='1981:2025').get('WLD', {})
    filas = [[a, r1(x.get(a)), r1(y.get(a))] for a in range(1981, 2026) if a in x and a in y]
    escribir('comercio-pib.csv',
             'Crecimiento real (%) del volumen de las exportaciones mundiales de bienes y servicios y del PIB '
             'mundial, 1981 al último año disponible. Banco Mundial, World Development Indicators '
             '(NE.EXP.GNFS.KD.ZG y NY.GDP.MKTP.KD.ZG, agregado WLD), https://data.worldbank.org/indicator/NE.EXP.GNFS.KD.ZG .',
             ['anio', 'exportaciones', 'pib'], filas)


def productos():
    ser = [('TX.VAL.FOOD.ZS.UN', 'alimentos'), ('TX.VAL.AGRI.ZS.UN', 'agricolas'),
           ('TX.VAL.FUEL.ZS.UN', 'combustibles'), ('TX.VAL.MMTL.ZS.UN', 'minerales'),
           ('TX.VAL.MANF.ZS.UN', 'manufacturas')]
    d = {c: bm(i, fechas='1995:2025').get('WLD', {}) for i, c in ser}
    filas = []
    for a in range(1995, 2026):
        if all(a in d[c] for _, c in ser):
            v = [d[c][a] for _, c in ser]
            filas.append([a] + [r1(z) for z in v] + [r1(max(0.0, 100 - sum(v)))])
    escribir('comercio-productos.csv',
             'Composición de las exportaciones mundiales de mercancías por productos (% del total), según la '
             'CUCI (Clasificación Uniforme para el Comercio Internacional) rev. 3: alimentos (secciones 0, 1, '
             '4 y división 22), materias primas agrícolas (2 sin 22, 27, 28), combustibles (3), minerales y '
             'metales (27, 28, 68), manufacturas (5 a 8 sin 68). sin_clasificar = 100 - suma. Banco Mundial, '
             'WDI a partir de UN Comtrade (TX.VAL.FOOD.ZS.UN, TX.VAL.AGRI.ZS.UN, TX.VAL.FUEL.ZS.UN, '
             'TX.VAL.MMTL.ZS.UN, TX.VAL.MANF.ZS.UN; agregado WLD).',
             ['anio', 'alimentos', 'agricolas', 'combustibles', 'minerales', 'manufacturas', 'sin_clasificar'], filas)


def regiones():
    cods = [('EAS', 'Asia oriental y Pacífico'), ('ECS', 'Europa y Asia central'), ('NAC', 'América del Norte'),
            ('LCN', 'América Latina y Caribe'), ('MEA', 'Oriente Medio y Norte de África'),
            ('SAS', 'Asia meridional'), ('SSF', 'África subsahariana'), ('CHN', 'China'), ('USA', 'EE. UU.')]
    d = bm('TX.VAL.MRCH.CD.WT', 'WLD;' + ';'.join(c for c, _ in cods), '1990:2025')
    w = d['WLD']
    ult = max(a for a in w if all(a in d.get(c, {}) for c, _ in cods))
    filas = [[c, n] + [r1(100 * d[c][a] / w[a]) for a in (1990, 2000, ult)] for c, n in cods]
    escribir('exportaciones-regiones.csv',
             f'Cuota en las exportaciones mundiales de mercancías (%), 1990, 2000 y {ult}, por regiones del Banco '
             'Mundial (todas las economías, también las de renta alta) y 2 países. Banco Mundial, WDI '
             f'(TX.VAL.MRCH.CD.WT, a partir de la OMC). Las regiones incluyen el comercio dentro de cada región.',
             ['codigo', 'region', 'c1990', 'c2000', f'c{ult}'], filas)


def servicios():
    ser = [('BX.GSR.TRAN.ZS', 'transporte'), ('BX.GSR.TRVL.ZS', 'viajes'), ('BX.GSR.INSF.ZS', 'seguros_finanzas'),
           ('BX.GSR.CCIS.ZS', 'tic')]
    d = {c: bm(i, fechas='2005:2025').get('WLD', {}) for i, c in ser}
    filas = []
    for a in range(2005, 2026):
        if all(a in d[c] for _, c in ser):
            v = [d[c][a] for _, c in ser]
            filas.append([a] + [r1(z) for z in v] + [r1(max(0.0, 100 - sum(v)))])
    escribir('servicios-composicion.csv',
             'Composición de las exportaciones mundiales de servicios comerciales (% del total), MBP6: '
             'transporte, viajes, seguros y servicios financieros, y servicios TIC (telecomunicaciones, '
             'informática e información). resto = 100 - suma: otros servicios empresariales, cargos por '
             'propiedad intelectual, servicios personales, culturales y recreativos, servicios relacionados '
             'con bienes y construcción. Banco Mundial, WDI (BX.GSR.TRAN.ZS, BX.GSR.TRVL.ZS, BX.GSR.INSF.ZS, '
             'BX.GSR.CCIS.ZS; WLD), a partir del FMI.',
             ['anio', 'transporte', 'viajes', 'seguros_finanzas', 'tic', 'resto'], filas)


def ied():
    d = bm('BX.KLT.DINV.CD.WD', 'WLD;HIC;LMY;CHN', '1990:2025')
    filas = []
    for a in range(1990, 2026):
        if a in d.get('WLD', {}) and a in d.get('HIC', {}) and a in d.get('LMY', {}):
            filas.append([a] + [f'{d[c][a] / 1e9:.1f}' if a in d.get(c, {}) else '' for c in ('WLD', 'HIC', 'LMY', 'CHN')])
    escribir('ied-mundial.csv',
             'Entradas netas de inversión extranjera directa (miles de millones de dólares corrientes), '
             '1990 al último año. Banco Mundial, WDI (BX.KLT.DINV.CD.WD, a partir de la balanza de pagos del '
             'FMI): mundo, renta alta (HIC), renta baja y media (LMY) y China. La UNCTAD (World Investment '
             'Report) da cifras algo distintas (otra fuente y tratamiento de las entidades de propósito especial).',
             ['anio', 'mundo', 'renta_alta', 'renta_baja_media', 'china'], filas)


def bancos():
    series = {}
    for c in ('5J', '5R', '4T'):
        texto = bajar(BIS.format(c=c)).decode('utf-8')
        for fila in csv.DictReader(io.StringIO(texto)):
            if fila['TIME_PERIOD'].endswith('Q4') or fila['TIME_PERIOD'] >= '2026':
                series.setdefault(fila['TIME_PERIOD'], {})[c] = float(fila['OBS_VALUE']) / 1e6
    filas = []
    for per in sorted(series):
        s = series[per]
        if len(s) == 3:
            anio = int(per[:4]) + {'Q1': 0.25, 'Q2': 0.5, 'Q3': 0.75, 'Q4': 0.0}[per[-2:]]
            filas.append([per, f'{anio:.2f}', f"{s['5R']:.2f}", f"{s['4T']:.2f}",
                          f"{s['5J'] - s['5R'] - s['4T']:.2f}", f"{s['5J']:.2f}"])
    escribir('bancos-transfronterizos.csv',
             'Activos transfronterizos de los bancos declarantes al BPI (billones de dólares), al cierre de '
             'cada año y último trimestre publicado: frente a economías avanzadas (5R), frente a economías '
             'emergentes y en desarrollo (4T) y resto (organismos internacionales y sin asignar); total (5J). '
             'BPI, estadísticas bancarias territoriales (LBS), dataflow WS_LBS_D_PUB, serie '
             'Q.S.C.A.TO1.A.5J.A.5A.A.<contraparte>.N, https://data.bis.org/topics/LBS . anio: posición en '
             'el eje (el cierre de cada año, en el año; 2026T2, en 2026,5).',
             ['periodo', 'anio', 'avanzadas', 'emergentes', 'resto', 'total'], filas)


def gravedad(anio=2024):
    ref = {r['PartnerCode']: r['PartnerCodeIsoAlpha3'] for r in json.loads(bajar(CT_REF))['results']
           if not r.get('isGroup')}
    datos = json.loads(bajar(CT.format(a=anio)))['data']
    pib = fmi('NGDPD')
    paises = geo()
    cent = {iso: centroide(p) for iso, (_, p) in paises.items()}
    esp = cent['ESP']
    filas = []
    for x in datos:
        iso = ref.get(x['partnerCode'])
        if not iso or iso == 'ESP' or x['partnerCode'] == 0:
            continue
        c = cent.get(iso)
        y = pib.get(iso, {}).get(str(anio))
        if not c or not y or not x.get('primaryValue'):
            continue
        la1, lo1, la2, lo2 = map(math.radians, (esp[1], esp[0], c[1], c[0]))
        dist = 6371 * 2 * math.asin(math.sqrt(math.sin((la2 - la1) / 2) ** 2 +
                                              math.cos(la1) * math.cos(la2) * math.sin((lo2 - lo1) / 2) ** 2))
        if dist < 300:
            dist = 300
        ue = iso in UE27
        filas.append([iso, f'{x["primaryValue"] / 1e6:.1f}', f'{y:.1f}', f'{dist:.0f}',
                      f'{math.log(dist):.4f}', f'{math.log(x["primaryValue"] / (y * 1e9)):.4f}', int(ue)])
    filas.sort(key=lambda f: -float(f[1]))
    escribir('gravedad-espana.csv',
             f'Exportaciones de mercancías de España por país de destino en {anio} (millones de dólares, UN '
             'Comtrade, API pública, reporterCode=724, flowCode=X, cmdCode=TOTAL), PIB del destino (miles de '
             'millones de dólares, FMI, WEO de octubre de 2026, NGDPD) y distancia en km entre los centroides '
             '(polígono mayor de Natural Earth; mínimo 300 km). ln_dist = ln(km); ln_x_pib = ln(exportaciones / '
             'PIB del destino). ue = 1 si el destino es de la UE-27.',
             ['iso3', 'export_musd', 'pib_mmusd', 'dist_km', 'ln_dist', 'ln_x_pib', 'ue'], filas)


UE27 = {'AUT', 'BEL', 'BGR', 'HRV', 'CYP', 'CZE', 'DNK', 'EST', 'FIN', 'FRA', 'DEU', 'GRC', 'HUN', 'IRL',
        'ITA', 'LVA', 'LTU', 'LUX', 'MLT', 'NLD', 'POL', 'PRT', 'ROU', 'SVK', 'SVN', 'ESP', 'SWE'}


def convergencia():
    d = bm('NY.GDP.PCAP.PP.KD', 'all', '2000:2024')
    meta = json.loads(bajar('https://api.worldbank.org/v2/country?format=json&per_page=400'))[1]
    reg = {m['id']: (m['region']['id'], m['incomeLevel']['id']) for m in meta}
    filas = []
    for iso, s in d.items():
        if iso not in reg or reg[iso][0] == 'NA' or 2000 not in s or 2024 not in s:
            continue
        g = 100 * ((s[2024] / s[2000]) ** (1 / 24) - 1)
        filas.append([iso, f'{s[2000]:.0f}', f'{s[2024]:.0f}', f'{math.log(s[2000]):.4f}', f'{g:.2f}',
                      reg[iso][1], {'HIC': 1, 'UMC': 2, 'LMC': 3, 'LIC': 4}.get(reg[iso][1], 0)])
    filas.sort(key=lambda f: float(f[3]))
    escribir('convergencia.csv',
             'PIB por habitante en PPA (dólares internacionales constantes de 2021) en 2000 y 2024 y su '
             'crecimiento medio anual (%) por país. Banco Mundial, WDI (NY.GDP.PCAP.PP.KD). grupo: '
             'clasificación por renta vigente del Banco Mundial (HIC alta, UMC media-alta, LMC media-baja, LIC baja); grupo_n, lo mismo en número (1 a 4).',
             ['iso3', 'y2000', 'y2024', 'ln_y2000', 'crec_anual', 'grupo', 'grupo_n'], filas)


TAREAS = {'crecimiento': crecimiento, 'ppa': ppa, 'centro': centro, 'comercio': comercio,
          'productos': productos, 'regiones': regiones, 'servicios': servicios, 'ied': ied,
          'bancos': bancos, 'gravedad': gravedad, 'convergencia': convergencia}

if __name__ == '__main__':
    solo = sys.argv[sys.argv.index('--solo') + 1:] if '--solo' in sys.argv else list(TAREAS)
    for t in solo:
        print('==', t)
        try:
            TAREAS[t]()
        except Exception as e:  # noqa: BLE001
            print('ERROR en', t, e, file=sys.stderr)
