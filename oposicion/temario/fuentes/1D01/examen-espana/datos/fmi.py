"""Datos del FMI para los cuadros del examen de España (1D01).

- World Economic Outlook (WEO), octubre de 2026: API SDMX del FMI
  (https://api.imf.org/external/sdmx/2.1/data/IMF.RES,WEO/ESP..A), serie histórica y
  previsiones. Se guarda un extracto en fmi-weo-2026-10.csv (indicador, año, valor).
- Spain: 2026 Article IV Consultation (IMF Country Report 26/102, 21/05/2026): tablas
  estadísticas del informe del staff (cuadro 1, cuadro 2b y cuadro 4), extraídas del PDF
  oficial con PyMuPDF. Se guarda un extracto en fmi-articulo-iv-2026.csv.

python3 -I fmi.py vuelve a descargar ambos y reescribe los extractos (necesita PyMuPDF:
~/.local/share/oposicion-web/venv-ocr/bin/python -I fmi.py). descargar.py solo lee los extractos.
"""
import csv, io, os, re, sys, urllib.request

AQUI = os.path.dirname(os.path.abspath(__file__))
WEO_URL = 'https://api.imf.org/external/sdmx/2.1/data/IMF.RES,WEO/ESP..A?startPeriod=2006'
ART4_URL = 'https://www.imf.org/-/media/files/publications/cr/2026/english/1espea2026001.pdf'
CACHE = os.path.expanduser('~/.local/share/oposicion-web/fmi')
WEO_CSV = os.path.join(AQUI, 'fmi-weo-2026-10.csv')
ART4_CSV = os.path.join(AQUI, 'fmi-articulo-iv-2026.csv')
ANIOS_ART4 = [str(a) for a in range(2023, 2032)]


def _get(url, binario=False):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (examen-espana 1D01)',
                                               'Accept': 'application/vnd.sdmx.data+csv;version=1.0.0'})
    with urllib.request.urlopen(req, timeout=180) as r:
        b = r.read()
    return b if binario else b.decode('utf-8')


def descargar_weo():
    filas = list(csv.DictReader(io.StringIO(_get(WEO_URL))))
    with open(WEO_CSV, 'w', newline='', encoding='utf-8') as f:
        f.write('# FMI, World Economic Outlook de octubre de 2026 (publicación 13/10/2026; datos de España actualizados el '
                '%s; último dato observado: %s). API SDMX: %s. Consulta: 26/10/2026.\n'
                % (filas[0]['COUNTRY_UPDATE_DATE'], filas[0].get('LATEST_ACTUAL_ANNUAL_DATA', ''), WEO_URL))
        f.write('# Valores tal como los da el FMI, en unidades (NGDP en euros, LE y LP en personas); escala: la potencia de 10 con que el FMI los muestra.\n')
        w = csv.writer(f)
        w.writerow(['indicador', 'anio', 'valor', 'escala', 'unidad'])
        for r in sorted(filas, key=lambda r: (r['INDICATOR'], r['TIME_PERIOD'])):
            materia_prima = r['INDICATOR'].startswith('P') and not r['INDICATOR'].startswith(('PCPI', 'PPP'))
            if r['OBS_VALUE'] not in ('', 'NaN') and not materia_prima:
                w.writerow([r['INDICATOR'], r['TIME_PERIOD'], r['OBS_VALUE'], r['SCALE'], r['UNIT']])


def descargar_art4():
    import fitz
    os.makedirs(CACHE, exist_ok=True)
    pdf = os.path.join(CACHE, '1espea2026001.pdf')
    if not os.path.exists(pdf):
        open(pdf, 'wb').write(_get(ART4_URL, binario=True))
    d = fitz.open(pdf)
    out = []
    for n_pag, tabla, sufijo_segunda in [(49, 'Cuadro 1', ''), (51, 'Cuadro 2b', ''), (53, 'Cuadro 4', ' (% del PIB)')]:
        lineas = [l.strip() for l in d[n_pag - 1].get_text().split('\n')]
        vistos = {}
        i = 0
        while i < len(lineas):
            etq = lineas[i]
            vals = lineas[i + 1:i + 10]
            num = re.compile(r'^-?\d+(\.\d+)?$|^…$')
            if etq and not num.match(etq) and len(vals) == 9 and all(num.match(v) for v in vals):
                k = etq
                if k in vistos:
                    k = etq + sufijo_segunda
                vistos[etq] = 1
                for a, v in zip(ANIOS_ART4, vals):
                    if v != '…':
                        out.append([tabla, n_pag, k, a, v])
                i += 10
            else:
                i += 1
    with open(ART4_CSV, 'w', newline='', encoding='utf-8') as f:
        f.write('# FMI, Spain: 2026 Article IV Consultation, IMF Country Report No. 26/102 (21/05/2026), tablas del informe del staff: '
                'cuadro 1 (Main Economic Indicators, p. 44 del informe, 49 del PDF), cuadro 2b (General Government Operations, %% del PIB, '
                'p. 46/51) y cuadro 4 (Balance of Payments, p. 48/53; las filas repetidas en %% del PIB llevan el sufijo). 2026-2031: '
                'previsiones del staff. PDF: %s. Consulta: 26/10/2026.\n' % ART4_URL)
        w = csv.writer(f)
        w.writerow(['tabla', 'pagina_pdf', 'fila', 'anio', 'valor'])
        w.writerows(out)
    return len(out)


def weo():
    """{indicador: {año: valor (float, ya escalado)}}"""
    out = {}
    for r in csv.DictReader(l for l in open(WEO_CSV, encoding='utf-8') if not l.startswith('#')):
        # (el valor ya viene en unidades; la escala del FMI solo indica cómo mostrarlo)
        out.setdefault(r['indicador'], {})[r['anio']] = float(r['valor'])
    return out


def art4():
    """{(tabla, fila): {año: valor}}"""
    out = {}
    for r in csv.DictReader(l for l in open(ART4_CSV, encoding='utf-8') if not l.startswith('#')):
        out.setdefault((r['tabla'], r['fila']), {})[r['anio']] = float(r['valor'])
    return out


if __name__ == '__main__':
    descargar_weo()
    print('WEO:', len(weo()), 'indicadores')
    print('Artículo IV:', descargar_art4(), 'datos')
    a = art4()
    for k in [('Cuadro 1', 'Gross domestic product'), ('Cuadro 1', 'Private consumption'), ('Cuadro 2b', 'Interest'),
              ('Cuadro 4', 'Current account (% del PIB)'), ('Cuadro 4', 'Net international investment position')]:
        print(k, a.get(k))
    sys.exit(0)
