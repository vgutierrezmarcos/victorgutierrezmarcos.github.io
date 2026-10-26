"""Descarga la inflación interanual mensual del IPCA de España y de la zona del
euro desde 2007 (Eurostat prc_hicp_manr, ECOICOP ver. 1, hasta diciembre de 2025)
para el gráfico s07 de la solución (tipo de interés real a largo plazo). 2026 se
toma del gráfico 6 del cuadernillo (prc_hicp_minr, ECOICOP ver. 2), que coincide
con la anterior en 2025. Escribe datos/ipca-mensual-2007.csv.
Uso (desde esta carpeta): python3 descargar-ipca.py"""
import csv, datetime, os, sys
AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(AQUI, '..', 'datos'))
import fuentes_api as f  # noqa: E402

series, act = {}, None
for geo in ('ES', 'EA'):
    r, act = f.eurostat('prc_hicp_manr', since='2007-01', geo=geo, coicop='CP00', unit='RCH_A')
    series[geo] = list(r.values())[0]
with open(os.path.join(AQUI, '..', 'datos', 'g06-ipca-mensual.csv'), encoding='utf-8') as g:
    for fila in csv.reader(x for x in g if not x.startswith('#')):
        if fila[0].startswith('2026'):
            series['ES'][fila[0]] = float(fila[1]); series['EA'][fila[0]] = float(fila[3])
meses = sorted(set(series['ES']) & set(series['EA']))
with open(os.path.join(AQUI, 'datos', 'ipca-mensual-2007.csv'), 'w', encoding='utf-8', newline='\n') as g:
    g.write('# IPCA, tasa de variación interanual (%), índice general, España y zona del euro, mensual, 2007-01 a 2026-09.\n')
    g.write(f'# Eurostat prc_hicp_manr (ECOICOP ver. 1, CP00, RCH_A; actualizado el {act}) hasta 2025-12; 2026: gráfico 6 del cuadernillo (prc_hicp_minr, ECOICOP ver. 2).\n')
    g.write(f'# Consulta: {datetime.date.today().isoformat()}.\n')
    w = csv.writer(g, lineterminator='\n'); w.writerow(['mes', 'ipca_es', 'ipca_ze'])
    for m in meses:
        w.writerow([m, series['ES'][m], series['EA'][m]])
print(len(meses), meses[0], meses[-1])
