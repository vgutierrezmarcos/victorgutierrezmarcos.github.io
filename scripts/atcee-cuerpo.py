#!/usr/bin/env python3
"""El cuerpo de TCEE según la ATCEE: promociones desde 1930 y situación de los asociados.

Entra en atcee.es con la cuenta de asociado de ~/.config/oposicion-red/atcee.json
({"usuario": …, "clave": …}), descarga «TCEE por promociones» y el «Listado de
asociados» y guarda SOLO recuentos:

- oposicion/cuerpo.json (en el repositorio): número de nombramientos de cada
  promoción con su fecha, y la foto más reciente del listado de asociados por
  situación (activo, jubilado, excedente, servicios especiales) y por año de
  nombramiento, más el historial de totales por situación de cada descarga.
- ~/.local/share/oposicion-web/cifras/atcee/ (fuera del repositorio): el HTML
  descargado y un JSON de recuentos por fecha, para seguir la evolución.

Nunca se escriben nombres ni datos de personas. Uso, desde la raíz:
    python3 scripts/atcee-cuerpo.py [--sin-descargar]
"""
import argparse
import collections
import html
import http.cookiejar
import json
import os
import re
import ssl
import unicodedata
import urllib.parse
import urllib.request
from datetime import date
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]
SALIDA = RAIZ / 'oposicion' / 'cuerpo.json'
CACHE = Path(os.path.expanduser('~/.local/share/oposicion-web/cifras/atcee'))
CLAVE = Path(os.path.expanduser('~/.config/oposicion-red/atcee.json'))
PAGINAS = {'promociones': 'https://atcee.es/promociones/tecos-por-promociones/', 'asociados': 'https://atcee.es/directorio/listado-de-asociados/'}
MESES = {m: i + 1 for i, m in enumerate(['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'])}
MESES_EN = {m: i + 1 for i, m in enumerate(['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'])}
MESES_EN.update({m: i + 1 for i, m in enumerate(['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'])})
ROMANOS = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100}


def descargar():
    c = json.loads(CLAVE.read_text(encoding='utf-8'))
    cas = os.path.expanduser('~/.config/oposicion-red/cas.pem')
    ctx = ssl.create_default_context(cafile=cas) if os.path.exists(cas) else ssl.create_default_context()
    cj = http.cookiejar.CookieJar()
    op = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj), urllib.request.HTTPSHandler(context=ctx))
    op.addheaders = [('User-Agent', 'Mozilla/5.0')]
    op.open(PAGINAS['promociones'], timeout=60).read()
    datos = {'log': c['usuario'], 'pwd': c['clave'], 'wp-submit': 'Acceder', 'redirect_to': PAGINAS['promociones'], 'testcookie': '1'}
    op.open(urllib.request.Request('https://atcee.es/user/', urllib.parse.urlencode(datos).encode(), {'Referer': PAGINAS['promociones']}), timeout=60).read()
    CACHE.mkdir(parents=True, exist_ok=True)
    for n, u in PAGINAS.items():
        h = op.open(u, timeout=120).read().decode('utf-8', 'replace')
        if 'name="pwd"' in h:
            raise SystemExit(f'atcee.es no ha aceptado el acceso para {n}: revisa ~/.config/oposicion-red/atcee.json')
        (CACHE / f'{n}.html').write_text(h, encoding='utf-8')


def filas(h):
    tb = re.search(r'<table.*?</table>', h, re.S).group(0)
    out = []
    for f in re.findall(r'<tr.*?</tr>', tb, re.S):
        out.append([re.sub(r'\s+', ' ', html.unescape(re.sub(r'<[^>]+>', '', x))).strip() for x in re.findall(r'<t[dh][^>]*>(.*?)</t[dh]>', f, re.S)])
    return out


def romano(s):
    """Número de una promoción («LXXIII», con erratas como «LVXXIII»)."""
    s = re.sub(r'[^IVXLC]', '', s.upper())
    s = s.replace('LVXX', 'LXX')  # errata frecuente en la página
    total, prev = 0, 0
    for ch in reversed(s):
        v = ROMANOS.get(ch, 0)
        total += -v if v < prev else v
        prev = max(prev, v)
    return total


def fecha_es(s):
    m = re.search(r'(\d{1,2}) de (\w+) de (\d{4})', s.lower())
    if not m or m.group(2) not in MESES:
        return None
    d = min(int(m.group(1)), 28)
    return f'{m.group(3)}-{MESES[m.group(2)]:02d}-{d:02d}'


def fecha_en(s):
    """«25-Feb-25» → '2025-02-25' (años de dos cifras: hasta el actual son 20xx)."""
    m = re.match(r'(\d{1,2})-([A-Za-z]{3})\.?-(\d{2})$', s.strip())  # «25-Feb-25» o «01-ene.-23»
    if not m or m.group(2).lower() not in MESES_EN:
        return None
    yy = int(m.group(3))
    anio = 2000 + yy if yy <= date.today().year % 100 else 1900 + yy
    return f'{anio}-{MESES_EN[m.group(2).lower()]:02d}-{int(m.group(1)):02d}'


def promociones():
    f = filas((CACHE / 'promociones.html').read_text(encoding='utf-8'))
    grupos = collections.OrderedDict()
    for fila in f[1:]:
        if len(fila) < 3 or 'MOCI' not in fila[1].upper() or fila[1].upper() == 'PROMOCIÓN':  # «PORMOCIÓN» es una errata de la página
            continue
        g = grupos.setdefault(fila[1].strip(), {'n': 0, 'fechas': collections.Counter()})
        g['n'] += 1
        fd = fecha_es(fila[2])
        if fd:
            g['fechas'][fd] += 1
    out = []
    for etiqueta, g in grupos.items():
        fecha = g['fechas'].most_common(1)[0][0] if g['fechas'] else None
        out.append({'promocion': etiqueta.replace('LVXX', 'LXX').replace('PORMOCI', 'PROMOCI'), 'numero': romano(etiqueta.split()[0]), 'ampliacion': 'ampliaci' in etiqueta.lower(),
                    'fecha': fecha, 'anio': int(fecha[:4]) if fecha else None, 'nombramientos': g['n']})
    out.sort(key=lambda p: (p['fecha'] or '0000', p['numero']))
    return out


SITUACIONES = {'ACTIVO': 'activo', 'ACTIVA': 'activo', 'JUBILADO': 'jubilado', 'JUBILADA': 'jubilado', 'EXCEDENTE': 'excedente', 'SERVICIOS ESPECIALES': 'servicios_especiales'}


def nombre_clave(s):
    """Apellidos y nombre como conjunto de palabras, sin tratamiento (D., Dª., Dña.) ni acentos."""
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode().upper()
    palabras = [w for w in re.findall(r'[A-Z]+', s) if w not in ('D', 'DA', 'DNA', 'DON', 'DONA')]
    return frozenset(palabras), ' '.join(palabras)


def indice_promociones():
    """Nombre normalizado → etiqueta de promoción, con la tabla «TCEE por promociones» (solo en memoria)."""
    f = filas((CACHE / 'promociones.html').read_text(encoding='utf-8'))
    indice = {}
    for fila in f[1:]:
        if len(fila) < 3 or 'MOCI' not in fila[1].upper() or fila[1].upper() == 'PROMOCIÓN':
            continue
        etiqueta = fila[1].strip().replace('LVXX', 'LXX').replace('PORMOCI', 'PROMOCI')
        conjunto, texto = nombre_clave(fila[0])
        indice[conjunto] = etiqueta
    return indice


def promocion_por_nombre(apellidos, nombre, indice):
    conjunto, texto = nombre_clave(apellidos + ' ' + nombre)
    if conjunto in indice:
        return indice[conjunto]
    # Tolerancia: una lista lleva un segundo nombre o una partícula más que la otra
    if len(conjunto) >= 3:
        cands = {et for conj, et in indice.items() if conjunto <= conj and len(conj) <= len(conjunto) + 2}
        if len(cands) == 1:
            return cands.pop()
    cands = {et for conj, et in indice.items() if len(conj & conjunto) >= max(3, len(conjunto) - 1) and len(conj) <= len(conjunto) + 1}
    if len(cands) == 1:
        return cands.pop()
    # Dos palabras del asociado dentro de un nombre más largo, o una palabra con una errata (parecido ≥ 0,75)
    import difflib
    cands = set()
    for conj, et in indice.items():
        comunes = conj & conjunto
        if len(comunes) < 2 or len(conj) > len(conjunto) + 2:
            continue
        sobran_a, sobran_c = conjunto - conj, conj - conjunto
        if not sobran_a or all(any(difflib.SequenceMatcher(None, a, c).ratio() >= 0.75 for c in sobran_c) for a in sobran_a):
            cands.add(et)
    return cands.pop() if len(cands) == 1 else None


def promocion_de(fecha, proms):
    """La promoción de un asociado por su fecha de nombramiento: la de fecha más cercana
    (el listado trae fechas irregulares: desde tres meses antes hasta un año después)."""
    d = date.fromisoformat(fecha)
    mejor, dist = None, None
    for p in proms:
        if not p['fecha'] or p.get('ampliacion'):
            continue
        delta = (d - date.fromisoformat(p['fecha'])).days
        if -100 <= delta <= 400 and (dist is None or abs(delta) < dist):
            mejor, dist = p, abs(delta)
    return mejor


def asociados(proms=()):
    f = filas((CACHE / 'asociados.html').read_text(encoding='utf-8'))
    cab = [c.upper() for c in f[0]]
    i_sit, i_fec = cab.index('SITUACION'), next(i for i, c in enumerate(cab) if c.startswith('FEC'))
    i_ape, i_nom = cab.index('APELLIDOS'), next(i for i, c in enumerate(cab) if c.startswith('NOMBRE'))
    indice = indice_promociones()
    por_nombre = por_fecha_n = 0
    por_situacion = collections.Counter()
    por_anio = collections.defaultdict(collections.Counter)
    por_promocion = collections.defaultdict(collections.Counter)
    sin_fecha = sin_promocion = 0
    total = 0
    for fila in f[1:]:
        if len(fila) <= max(i_sit, i_fec):
            continue
        total += 1
        s = fila[i_sit].strip().upper()
        sit = SITUACIONES.get(s) or ('excedente' if 'EXCEDENTE' in s else 'servicios_especiales' if 'ESPECIAL' in s else 'sin_dato')
        por_situacion[sit] += 1
        fd = fecha_en(fila[i_fec])
        if fd:
            por_anio[int(fd[:4])][sit] += 1
        else:
            sin_fecha += 1
        # Promoción: primero por el nombre en «TCEE por promociones» (fiable); si no, por la fecha de nombramiento
        etiqueta = promocion_por_nombre(fila[i_ape], fila[i_nom], indice)
        if etiqueta:
            por_nombre += 1
        elif fd:
            p = promocion_de(fd, proms)
            etiqueta = p['promocion'] if p else None
            por_fecha_n += 1 if etiqueta else 0
        if etiqueta:
            por_promocion[etiqueta][sit] += 1
        else:
            sin_promocion += 1
    return {'total': total, 'por_situacion': dict(por_situacion), 'sin_fecha_nombramiento': sin_fecha, 'sin_promocion': sin_promocion,
            'asignados_por_nombre': por_nombre, 'asignados_por_fecha': por_fecha_n,
            'por_anio_nombramiento': {str(a): dict(c) for a, c in sorted(por_anio.items())},
            'por_promocion': {p['promocion']: dict(por_promocion[p['promocion']]) for p in proms if p['promocion'] in por_promocion}}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
    ap.add_argument('--sin-descargar', action='store_true', help='usar el HTML ya descargado')
    args = ap.parse_args()
    if not args.sin_descargar:
        descargar()
    hoy = date.today().isoformat()
    proms = promociones()
    aso = asociados(proms)
    historial_ruta = CACHE / 'historial.json'
    historial = json.loads(historial_ruta.read_text(encoding='utf-8')) if historial_ruta.exists() else {}
    historial[hoy] = {'asociados': aso, 'promociones': proms}
    historial_ruta.write_text(json.dumps(historial, ensure_ascii=False, indent=1), encoding='utf-8')
    evolucion = [{'fecha': f, 'total': v['asociados']['total'], **{k: v['asociados']['por_situacion'].get(k, 0) for k in ('activo', 'servicios_especiales', 'excedente', 'jubilado', 'sin_dato')}}
                 for f, v in sorted(historial.items())]
    SALIDA.write_text(json.dumps({'actualizado': hoy, 'fuente': 'Asociación de Técnicos Comerciales y Economistas del Estado (zona de asociados): «TCEE por promociones» y «Listado de asociados»; recuentos propios',
                                  'promociones': proms, 'asociados': {'fecha': hoy, **aso}, 'evolucion_asociados': evolucion}, ensure_ascii=False, indent=1), encoding='utf-8')
    print(f'{len(proms)} promociones ({proms[0]["anio"]}-{proms[-1]["anio"]}, {sum(p["nombramientos"] for p in proms)} nombramientos); '
          f'{aso["total"]} asociados: {aso["por_situacion"]}; historial con {len(historial)} fotos → {SALIDA.relative_to(RAIZ)}')


if __name__ == '__main__':
    main()
