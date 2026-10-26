"""Cálculos de la solución de máximos del examen de España (1D01, entregable 5).

Lee los CSV del cuadernillo (../datos) y escribe en datos/ los CSV de los
gráficos propios de la solución (s01-s08) y en calculos.txt todos los cálculos
que cita el texto, para comprobarlos. Sin dependencias externas.
Uso (desde esta carpeta): python3 -I calculos.py
"""
import csv
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
CUAD = os.path.join(AQUI, '..', 'datos')
SAL = os.path.join(AQUI, 'datos')
FECHA = 'Consulta de los datos del cuadernillo: 26/10/2026.'


def filas(nombre):
    with open(os.path.join(CUAD, nombre), encoding='utf-8') as f:
        return [r for r in csv.reader(f) if r and not r[0].startswith('#')]


def cuadro(n):
    rs = filas(f'cuadro{n}.csv')
    cab = rs[0]
    anios = [int(a) for a in cab[5:]]
    return {r[0]: {a: (float(v) if v != '' else None) for a, v in zip(anios, r[5:])} for r in rs[1:]}


C = {}
for n in (1, 3, 4, 5, 6, 7, 8, 9):
    for k, v in cuadro(n).items():
        C[f'c{n}.{k}'] = v


def serie(nombre):
    rs = filas(nombre)
    return rs[0], rs[1:]


def acum(k, a, b):
    p = 1.0
    for y in range(a + 1, b + 1):
        p *= 1 + C[k][y] / 100
    return (p - 1) * 100


def escribir(nombre, cabecera, comentario, datos):
    with open(os.path.join(SAL, nombre), 'w', encoding='utf-8', newline='\n') as f:
        for linea in comentario:
            f.write(f'# {linea}\n')
        f.write(f'# {FECHA}\n')
        w = csv.writer(f, lineterminator='\n')
        w.writerow(cabecera)
        w.writerows(datos)


out = []
def p(*a):
    out.append(' '.join(str(x) for x in a))


R = lambda x, n=2: round(x, n)

# --- s01: fases del ciclo -------------------------------------------------------
d = [[y, C['c1.pib'][y], C['c1.brecha'][y], 1 if y >= 2026 else 0] for y in range(2007, 2028)]
escribir('s01-fases.csv', ['anio', 'pib', 'brecha', 'prevision'],
         ['Solución, gráfico s01: crecimiento del PIB real (%) y brecha de producción (% del PIB potencial), 2007-2027.',
          'Cuadro 1 del cuadernillo (Eurostat; brecha y previsiones 2026-2027: Comisión Europea, AMECO, primavera de 2026).'], d)
p('== P1. Fases (medias)')
for a, b in [(2007, 2008), (2009, 2013), (2014, 2019), (2020, 2020), (2021, 2023), (2024, 2025)]:
    ys = range(a, b + 1)
    m = lambda k: R(sum(C[k][y] for y in ys) / len(ys))
    p(a, b, 'PIB', m('c1.pib'), 'interna', m('c1.c_int'), 'externa', m('c1.c_ext'),
      'brecha final', C['c1.brecha'][b], 'paro final', C['c3.paro'][b])
q = [0.48, 0.67, 0.57, 0.73, 0.63, 0.68]  # G1, 1T2025-2T2026
niv = [100.0]
for g in q:
    niv.append(niv[-1] * (1 + g / 100))
m25 = sum(niv[1:5]) / 4
for g in (0.0, 0.4, 0.5):
    q3 = niv[6] * (1 + g / 100); q4 = q3 * (1 + g / 100)
    p('PIB medio 2026 si 3T y 4T crecen', g, '% trimestral:', R((sum([niv[5], niv[6], q3, q4]) / 4 / m25 - 1) * 100))
p('anualizada 1T2026', R(((1.0063) ** 4 - 1) * 100), '2T2026', R(((1.0068) ** 4 - 1) * 100))
for y in (2023, 2024, 2025):
    p(y, 'ΔOG', R(C['c1.brecha'][y] - C['c1.brecha'][y - 1]), 'γY-γYp', R(C['c1.pib'][y] - C['c1.pot'][y]))

# --- s02: descomposición del crecimiento -----------------------------------------
cab, rs = serie('cuadro2b-descomposicion.csv')
dd = {r[0]: [float(x) for x in r[1:]] for r in rs}
orden = ['Población', 'Población en edad de trabajar (15-64) sobre población',
         'Tasa de ocupación (ocupados sobre población de 15-64)', 'Horas trabajadas por ocupado',
         'PIB por hora trabajada', 'PIB']
d = []
for i, per in enumerate(cab[1:]):
    d.append([i, per] + [R(dd[k][i]) for k in orden])
    p('Descomposición', per, 'suma', R(sum(dd[k][i] for k in orden[:5])), 'PIB', R(dd['PIB'][i]))
escribir('s02-descomposicion.csv', ['x', 'periodo', 'poblacion', 'pet', 'ocupacion', 'horas', 'pibhora', 'pib'],
         ['Solución, gráfico s02: descomposición del crecimiento del PIB (tasas medias anuales logarítmicas, pp).',
          'Cuadro 2 bis del cuadernillo (Eurostat).'], d)

# --- s03: Okun -----------------------------------------------------------------
d = []
for y in range(2008, 2026):
    du = R(C['c3.paro'][y] - C['c3.paro'][y - 1], 1)
    gap = R(C['c1.pib'][y] - C['c1.pot'][y], 1)
    grupo = 'rec' if y <= 2013 else ('exp1' if y <= 2019 else ('cov' if y <= 2021 else 'exp2'))
    d.append([y, gap, du, grupo])
escribir('s03-okun.csv', ['anio', 'crec_sobre_pot', 'var_paro', 'grupo'],
         ['Solución, gráfico s03: ley de Okun. Crecimiento del PIB real menos el del potencial (pp) y variación de la tasa de paro (pp).',
          'Cuadros 1 y 3 del cuadernillo (Eurostat; PIB potencial: AMECO).'], d)
p('== P2. Okun')
for a, b in [(2014, 2019), (2022, 2025)]:
    ys = range(a, b + 1); n = len(ys)
    du = sum(C['c3.paro'][y] - C['c3.paro'][y - 1] for y in ys) / n
    gy = sum(C['c1.pib'][y] for y in ys) / n
    gp = sum(C['c1.pot'][y] for y in ys) / n
    p(a, b, 'ΔU medio', R(du), 'γY medio', R(gy), 'γYp medio', R(gp), 'coeficiente', R(du / (gy - gp)))
p('vacantes/paro 2019', R(C['c3.vac'][2019] / C['c3.paro'][2019], 3), '2025', R(C['c3.vac'][2025] / C['c3.paro'][2025], 3))
for k in ('c3.prod_h', 'c3.prod_oc'):
    for a, b in [(2007, 2013), (2013, 2019), (2019, 2025)]:
        p(k, a, b, 'acumulada', R(acum(k, a, b), 1))

# --- s04: CLU, deflactor y margen -------------------------------------------------
d = []
p('== P4. CLU y margen')
for y in range(2019, 2026):
    clu = C['c3.clu'][y]; df = C['c5.def_pib'][y]
    d.append([y, R(clu, 1), R(df, 1), R(df - clu, 1)])
    p(y, 'W', R(C['c3.rem'][y], 1), 'PAT', R(C['c3.prod_oc'][y], 1), 'CLU', R(clu, 1), 'deflactor', R(df, 1),
      'margen', R(df - clu, 1), 'salario real (IPCA)', R(C['c3.rem'][y] - C['c5.ipca'][y], 1),
      'beneficios % VAB', C['c4.ben_snf'][y])
escribir('s04-margen.csv', ['anio', 'clu', 'deflactor', 'margen'],
         ['Solución, gráfico s04: CLU nominales, deflactor del PIB (variación anual, %) y margen aproximado (deflactor menos CLU, pp).',
          'Cuadros 3 y 5 del cuadernillo (Eurostat).'], d)
for k in ('c3.clu', 'c3.clu_ze', 'c5.ipca', 'c5.ipca_ze'):
    p(k, *[f'{a}-{b}: {R(acum(k, a, b), 1)}' for a, b in [(2007, 2013), (2013, 2019), (2019, 2025)]])

# --- s05: saldos sectoriales -----------------------------------------------------
d = []
for y in range(2007, 2026):
    nac = C['c7.cnf'][y]; pub = C['c9.saldo'][y]
    d.append([y, R(nac - pub, 1), R(pub, 1), R(nac, 1)])
escribir('s05-saldos.csv', ['anio', 'privado', 'publico', 'nacion'],
         ['Solución, gráfico s05: capacidad (+) o necesidad (-) de financiación de la nación, de las AAPP y del sector privado (por diferencia), % del PIB.',
          'Cuadros 7 y 9 del cuadernillo (Eurostat: balanza de pagos del Banco de España y cuentas de las AAPP).'], d)
p('== P6. Saldos y balanza')
for y in (2007, 2012, 2013, 2019, 2025):
    p(y, 'nación', R(C['c7.cnf'][y], 1), 'AAPP', C['c9.saldo'][y], 'privado', R(C['c7.cnf'][y] - C['c9.saldo'][y], 1),
      'S-I', R(C['c4.ahorro_nac'][y] - C['c4.fbc'][y], 1), 'CC', R(C['c7.cc'][y], 1))
for a, b in [(2007, 2013), (2013, 2025)]:
    p('cambio', a, b, {k: R(C['c7.' + k][b] - C['c7.' + k][a], 1) for k in ('cc', 'bie', 'ser', 'rp', 'rs')},
      'ahorro', R(C['c4.ahorro_nac'][b] - C['c4.ahorro_nac'][a], 1), 'inversión', R(C['c4.fbc'][b] - C['c4.fbc'][a], 1))
for y in (2011, 2012, 2013):
    p(y, 'CF', R(C['c7.fa'][y]), 'BdE', R(C['c7.fa_o_bde'][y]), 'resto (privado y AAPP)',
      R(C['c7.fa'][y] - C['c7.fa_o_bde'][y] - C['c7.fa_r'][y]))

# --- s06: PIIN 2024-2025 -----------------------------------------------------------
gn = C['c9.pibn'][2025] / 100
piin0, piin1, cf = C['c7.piin'][2024], C['c7.piin'][2025], C['c7.fa'][2025]
crec = -gn / (1 + gn) * piin0
ov = (piin1 - piin0) - cf - crec
escribir('s06-piin.csv', ['x', 'concepto', 'desde', 'hasta'],
         ['Solución, gráfico s06: de la PIIN de 2024 a la de 2025 (% del PIB): cuenta financiera, crecimiento del PIB nominal y otras variaciones (residuo).',
          'Cuadros 7 y 9 del cuadernillo (Eurostat; Banco de España). PIIN(t) - PIIN(t-1) = CF + OV - g/(1+g) PIIN(t-1).'],
         [[0, 'PIIN 2024', 0, R(piin0, 1)], [1, 'Cuenta financiera', R(piin0, 1), R(piin0 + cf, 1)],
          [2, 'Crecimiento nominal', R(piin0 + cf, 1), R(piin0 + cf + crec, 1)],
          [3, 'Otras variaciones', R(piin0 + cf + crec, 1), R(piin1, 1)], [4, 'PIIN 2025', 0, R(piin1, 1)]])
pn = C['c1.pib_nom']
p('PIIN mill. 2024', R(piin0 * pn[2024] * 10, 0), '2025', R(piin1 * pn[2025] * 10, 0), 'CF', R(cf * pn[2025] * 10, 0),
  'OV mill.', R((piin1 * pn[2025] - piin0 * pn[2024] - cf * pn[2025]) * 10, 0))
p('PIIN % PIB: CF', R(cf), 'crecimiento', R(crec), 'OV', R(ov))
for i in (2.0, 3.0, 3.5):
    p('CC sin intereses que estabiliza la deuda externa (D*=42,7), i*=', i, ':', R((i / 100 - gn) / (1 + gn) * C['c7.den'][2025]))

# --- s07: tipo de interés real (2007-2026) -----------------------------------------
# IPCA mensual largo: datos/ipca-mensual-2007.csv (descargar-ipca.py; 2026 = gráfico 6)
with open(os.path.join(SAL, 'ipca-mensual-2007.csv'), encoding='utf-8') as fi:
    rs = [r for r in csv.reader(fi) if r and not r[0].startswith('#')][1:]
ipca = {r[0]: (float(r[1]), float(r[2])) for r in rs}
_, tp = serie('g12-tipos.csv')
d = []
for r in tp:
    mes = r[0]
    if mes in ipca and r[1] != '':
        dfr = float(r[1])
        d.append([mes, R(int(mes[:4]) + (int(mes[5:]) - 0.5) / 12, 3), dfr, R(dfr - ipca[mes][0], 1), R(dfr - ipca[mes][1], 1)])
escribir('s07-tipo-real.csv', ['mes', 'x', 'dfr', 'r_es', 'r_ze'],
         ['Solución, gráfico s07: facilidad de depósito del BCE (%) y tipo real ex post: facilidad de depósito menos la inflación interanual del IPCA de España y de la zona del euro (pp), enero de 2007-septiembre de 2026.',
          'Gráfico 12 del cuadernillo (BCE) y datos/ipca-mensual-2007.csv (Eurostat prc_hicp_manr hasta 2025; 2026, gráfico 6 del cuadernillo).'], d)
p('== P4. tipos reales (septiembre de 2026):', d[-1])
media = lambda a, b, k: R(sum(x[k] for x in d if a <= x[0][:4] <= b) / len([x for x in d if a <= x[0][:4] <= b]), 1)
for a_, b_ in [('2007', '2008'), ('2009', '2013'), ('2014', '2021'), ('2022', '2022'), ('2023', '2024'), ('2025', '2026')]:
    p('tipo real medio', a_, b_, 'España', media(a_, b_, 3), 'zona', media(a_, b_, 4))
taylor = lambda pi, og: 4 + 1.5 * (pi - 2) + 0.5 * og
p('Taylor España (π 2026 ene-sep 3,6; OG 1,7):', R(taylor(3.61, 1.75)), 'con subyacente 3,5:', R(taylor(3.5, 1.75)))
p('Taylor zona del euro sin brecha (π sep 3,8):', R(taylor(3.8, 0)), 'subyacente 2,5:', R(taylor(2.5, 0)))

# --- s08: dinámica de la deuda pública --------------------------------------------
d = []
p('== P9. Deuda')
tot = [0, 0, 0]
for y in range(2021, 2026):
    d0, d1 = C['c9.deuda'][y - 1], C['c9.deuda'][y]
    i, g = C['c9.impl'][y] / 100, C['c9.pibn'][y] / 100
    prim = -C['c9.prim'][y]; bola = (i - g) / (1 + g) * d0; add = (d1 - d0) - prim - bola
    tot = [tot[0] + prim, tot[1] + bola, tot[2] + add]
    d.append([y, R(prim), R(bola), R(add), R(d1 - d0), 0])
    p(y, 'Δd', R(d1 - d0), 'déficit primario', R(prim), 'bola de nieve', R(bola), 'ADD', R(add),
      'saldo primario estabilizador', R(-bola))
for y in (2026, 2027):
    d0, d1 = C['c9.deuda'][y - 1], C['c9.deuda'][y]
    i, g = C['c9.int'][y] / d0, C['c9.pibn'][y] / 100
    prim = -C['c9.prim'][y]; bola = (i - g) / (1 + g) * d0; add = (d1 - d0) - prim - bola
    d.append([y, R(prim), R(bola), R(add), R(d1 - d0), 1])
    p(y, '(previsión) Δd', R(d1 - d0), 'déficit primario', R(prim), 'bola de nieve', R(bola), 'ADD implícito', R(add))
p('Total 2021-2025: déficits primarios', R(tot[0]), 'bola de nieve', R(tot[1]), 'ADD', R(tot[2]),
  'Δd', R(C['c9.deuda'][2025] - C['c9.deuda'][2020]))
escribir('s08-deuda.csv', ['anio', 'primario', 'bola', 'add', 'var_deuda', 'prevision'],
         ['Solución, gráfico s08: variación de la deuda pública (pp del PIB) y sus 3 componentes: déficit primario, efecto bola de nieve (i-g)/(1+g)·d(t-1) y ajuste déficit-deuda (residuo).',
          'Cuadro 9 del cuadernillo (Eurostat; previsiones de 2026-2027: AMECO, primavera de 2026; tipo implícito previsto = intereses / deuda del año anterior).'], d)
for i, g in [(2.5, 5.7), (2.5, 4.5), (3.5, 4.0), (3.5, 3.5), (4.0, 3.0)]:
    p('saldo primario que estabiliza una deuda del 100 %: i', i, 'g', g, '->', R((i - g) / (100 + g) * 100))
for y in range(2019, 2028):
    p(y, 'b', C['c9.saldo'][y], 'b^ca', R(C['c9.cicl'][y]), 'b^e', R(C['c9.estr'][y]), 'b^pe', R(C['c9.estr_p'][y]),
      'Δb^pe', R(C['c9.estr_p'][y] - C['c9.estr_p'][y - 1]), 'OG', R(C['c1.brecha'][y]),
      'ε implícita', R((C['c9.saldo'][y] - C['c9.cicl'][y]) / C['c1.brecha'][y]))

with open(os.path.join(AQUI, 'calculos.txt'), 'w', encoding='utf-8', newline='\n') as f:
    f.write('\n'.join(out) + '\n')
print('\n'.join(out))
