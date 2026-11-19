#!/usr/bin/env python3
"""Prepara los CSV de los gráficos de datos del 3.B.40 a partir de las
descargas JSON-stat de Eurostat guardadas en _trabajo/ (consulta 14/11/2026):
  gdp_nuts2.json  nama_10r_2gdp (PIB por habitante en PPA por región NUTS 2, UE-27 = 100), 2000-2024
  ppp1.json       prc_ppp_ind_1 (PIB por habitante en PPA, índice UE-27 = 100, por país), 1995-2025
  emp.json        lfsi_emp_a (tasa de empleo 20-64 años), arope.json ilc_peps01n y sdg.json sdg_01_10 (AROPE)
Uso: python3 datos/preparar-datos.py (desde fuentes/3B40).
Autor: Víctor Gutiérrez Marcos
"""
import json, math, os
import numpy as np

AQUI = os.path.dirname(os.path.abspath(__file__))
TRAB = os.path.join(AQUI, '..', '_trabajo')
EU = 'BE BG CZ DK DE EE IE EL ES FR HR IT CY LV LT LU HU MT NL AT PL PT RO SI SK FI SE'.split()
ESTE = set('BG CZ EE HR LV LT HU PL RO SI SK'.split())


def cargar(nombre):
    d = json.load(open(os.path.join(TRAB, nombre)))
    cats = []
    for i in d['id']:
        idx = d['dimension'][i]['category']['index']
        cats.append(sorted(idx, key=lambda k: idx[k]))
    out = {}
    for k, v in d['value'].items():
        k = int(k); co = []
        for s in reversed(d['size']):
            co.append(k % s); k //= s
        co = co[::-1]
        out[tuple(cats[j][c] for j, c in enumerate(co))] = v
    return d, out


def ols(x, y):
    A = np.vstack([np.ones_like(x), x]).T
    b = np.linalg.lstsq(A, y, rcond=None)[0]
    e = y - A @ b
    r2 = 1 - (e ** 2).sum() / ((y - y.mean()) ** 2).sum()
    se = math.sqrt((e ** 2).sum() / (len(y) - 2) * np.linalg.inv(A.T @ A)[1, 1])
    return b, se, r2


# --- Regiones NUTS 2 -------------------------------------------------------
d, out = cargar('gdp_nuts2.json')
geo = d['dimension']['geo']['category']['label']
def v(g, y):
    return out.get(('A', 'PPS_HAB_EU27_2020', g, str(y)))
regs = [g for g in geo if len(g) == 4 and g[:2] in EU and not g.endswith('ZZ')
        and v(g, 2000) and v(g, 2024)]
x = np.array([math.log(v(g, 2000)) for g in regs])
gr = np.array([100 * math.log(v(g, 2024) / v(g, 2000)) / 24 for g in regs])
b, se, r2 = ols(x, gr)
lam = -math.log(1 + b[1] / 100 * 24) / 24
res = [f'# Eurostat, nama_10r_2gdp (actualizado el 10/2/2026; consulta 14/11/2026): PIB por habitante en PPA, índice UE-27 = 100, regiones NUTS 2 (NUTS 2021) de la UE-27 con dato en 2000 y 2024 ({len(regs)}).',
       f'# g = crecimiento medio anual (%) del índice relativo 2000-2024 = 100*ln(idx2024/idx2000)/24. MCO: g = {b[0]:.3f} {b[1]:+.3f} ln(idx2000); ee(beta1) = {se:.3f}; R2 = {r2:.3f}; lambda = {100*lam:.2f} %.',
       '# grupo: este = Estados que entraron en 2004-2013 salvo Chipre y Malta; ue14 = el resto. es = 1 para las regiones españolas.',
       'nuts,pais,grupo,es,idx2000,idx2024,ln2000,g']
for g, xi, gi in zip(regs, x, gr):
    res.append(f'{g},{g[:2]},{"este" if g[:2] in ESTE else "ue14"},{int(g[:2]=="ES")},{v(g,2000)},{v(g,2024)},{xi:.4f},{gi:.4f}')
open(os.path.join(AQUI, 'convergencia-regional.csv'), 'w').write('\n'.join(res) + '\n')
# por grupos, para el gráfico (mismas columnas)
for nom, cond in [('este', lambda f: f.split(',')[2] == 'este'),
                  ('resto', lambda f: f.split(',')[2] == 'ue14' and f.split(',')[3] == '0'),
                  ('espana', lambda f: f.split(',')[3] == '1')]:
    filas_g = [f for f in res[4:] if cond(f)]
    open(os.path.join(AQUI, f'convergencia-{nom}.csv'), 'w').write(
        f'# Subconjunto «{nom}» de convergencia-regional.csv (ver su cabecera).\n' + res[3] + '\n' + '\n'.join(filas_g) + '\n')
# línea de ajuste
xs = [22, 280]
open(os.path.join(AQUI, 'convergencia-ajuste.csv'), 'w').write(
    '# Recta de la regresión de convergencia-regional.csv (idx2000 en escala logarítmica)\nidx2000,g\n' + ''.join(f'{t},{b[0]+b[1]*math.log(t):.4f}\n' for t in xs))
print('beta', b, se, r2, lam, len(regs))
for nom, cc in [('este', ESTE), ('ue14', set(EU) - ESTE - {'CY', 'MT'} | {'CY', 'MT'})]:
    m = np.array([g[:2] in cc for g in regs])
    bb, ss, rr = ols(x[m], gr[m])
    print(nom, m.sum(), bb, ss, rr)
    open(os.path.join(AQUI, f'convergencia-ajuste-{nom}.csv'), 'w').write(
        f'# Recta de MCO solo con las regiones «{nom}»: g = {bb[0]:.3f} {bb[1]:+.3f} ln(idx2000); ee = {ss:.3f}; R2 = {rr:.3f}; n = {m.sum()}.\nidx2000,g\n'
        + ''.join(f'{q},{bb[0]+bb[1]*math.log(q):.4f}\n' for q in ([22, 160] if nom == 'este' else [55, 280])))

# sigma con panel equilibrado
bal = [g for g in regs if all(v(g, y) for y in range(2000, 2025))]
filas = [f'# Desviación típica de ln(PIB por habitante en PPA, UE-27 = 100): {len(bal)} regiones NUTS 2 con dato en todos los años (nama_10r_2gdp) y 27 Estados (prc_ppp_ind_1). Sin ponderar.', 'anio,regiones,estados']
dp, op = cargar('ppp1.json')
def p(g, y):
    return op.get(('A', 'VI_PPS_EU27_2020_HAB', 'GDP', g, str(y)))
for y in range(2000, 2025):
    sr = np.std([math.log(v(g, y)) for g in bal])
    sp = np.std([math.log(p(c, y)) for c in EU])
    filas.append(f'{y},{sr:.4f},{sp:.4f}')
open(os.path.join(AQUI, 'sigma-regional.csv'), 'w').write('\n'.join(filas) + '\n')
print(filas[1], filas[2], filas[-1])

# --- Países 1995-2025 --------------------------------------------------------
paises = ['ES', 'IT', 'PT', 'EL', 'PL', 'CZ', 'RO', 'LT']
filas = ['# Eurostat, prc_ppp_ind_1 (actualizado el 9/7/2026; consulta 14/11/2026): PIB por habitante en PPA, índice UE-27 = 100.',
         'anio,' + ','.join(paises)]
for y in range(1995, 2026):
    filas.append(f'{y},' + ','.join(str(p(c, y)) for c in paises))
open(os.path.join(AQUI, 'pib-pc-paises.csv'), 'w').write('\n'.join(filas) + '\n')

# --- Pilar social ------------------------------------------------------------
de, oe = cargar('emp.json'); da, oa = cargar('arope.json'); ds, osd = cargar('sdg.json')
filas = ['# Eurostat: lfsi_emp_a (tasa de empleo 20-64 años, %, actualizado el 6/11/2026) ; AROPE de la UE en millones de sdg_01_10 (serie de seguimiento del objetivo, 20/10/2026) y AROPE en % de ilc_peps01n. Consulta 14/11/2026. Objetivos 2030: empleo 78 %; AROPE 15 millones menos que en 2019 (95,5 -> 80,5).',
         'anio,empleo_ue,empleo_es,arope_ue_mill,arope_ue_pc,arope_es_pc']
for y in range(2015, 2026):
    y = str(y)
    filas.append(','.join([y, str(oe[('A','EMP_LFS','T','Y20-64','PC_POP','EU27_2020',y)]),
                           str(oe[('A','EMP_LFS','T','Y20-64','PC_POP','ES',y)]),
                           f"{osd[('A','TOTAL','THS_PER','EU27_2020',y)]/1000:.1f}",
                           str(oa[('A','PC','TOTAL','T','EU27_2020',y)]),
                           str(oa[('A','PC','TOTAL','T','ES',y)])]))
open(os.path.join(AQUI, 'pilar-social.csv'), 'w').write('\n'.join(filas) + '\n')

# --- Mapa del PIB por habitante por regiones (NUTS 2024), 19/11/2026 ---------
# Todas las regiones NUTS 2 de la UE-27 con dato en 2024 (244); la variación
# 2000-2024 solo donde hay dato de 2000 (faltan Bélgica y Mayotte).
regs_m = sorted(g for g in geo if len(g) == 4 and g[:2] in EU and not g.endswith('ZZ') and v(g, 2024))
filas = [f'# Eurostat, nama_10r_2gdp (actualizado el 10/2/2026; consulta 14/11/2026): PIB por habitante en PPA, índice UE-27 = 100, regiones NUTS 2 (NUTS 2024) de la UE-27 ({len(regs_m)}).',
         '# idx2024: nivel en 2024; dif: variación en puntos 2000-2024 (vacía si no hay dato de 2000). Lo lee mapas-regiones.py.',
         'nuts;idx2024;idx2000;dif']
for g in regs_m:
    a, b0 = v(g, 2024), v(g, 2000)
    filas.append(f'{g};{a};{b0 if b0 else ""};{a - b0 if b0 else ""}')
open(os.path.join(AQUI, 'mapa-pib-regional.csv'), 'w').write('\n'.join(filas) + '\n')
print('regiones del mapa', len(regs_m), '<75:', sum(v(g, 2024) < 75 for g in regs_m))

# --- Cohesión por Estado, por habitante (19/11/2026) ---------------------------
# Mismos datos que cohesion-estados.csv, ordenados por euros por habitante, y la
# media de la UE (importe total entre la población implícita en pc).
lc = [l for l in open(os.path.join(AQUI, 'cohesion-estados.csv')).read().splitlines() if l and not l.startswith('#')]
cab, filas_c = lc[0].split(','), [dict(zip(lc[0].split(','), l.split(','))) for l in lc[1:]]
filas_c.sort(key=lambda f: int(f['pc']))
tot = sum(float(f['millones']) for f in filas_c)
pob = sum(float(f['millones']) / int(f['pc']) for f in filas_c)
media = tot / pob
salida = [f'# Mismos datos que cohesion-estados.csv (ver su cabecera), ordenados por euros por habitante (pc). Media de la UE-27: {media:.0f} euros por habitante ({tot:.1f} millones entre la población implícita).',
          'n,codigo,pais,millones,mm,pc,es']
for i, f in enumerate(filas_c):
    salida.append(f"{i},{f['codigo']},{f['pais']},{f['millones']},{f['mm']},{f['pc']},{f['es']}")
open(os.path.join(AQUI, 'cohesion-estados-hab.csv'), 'w').write('\n'.join(salida) + '\n')
print('media UE por habitante', round(media))
