"""Segunda comprobación de las cifras clave con una fuente o un cálculo distinto
(python3 -I verificar.py). Escribe verificacion.csv."""
import csv, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fuentes_api import eurostat1, ameco, ecb

def leer(f):
    rows = [l for l in open(os.path.join(os.path.dirname(os.path.abspath(__file__)), f), encoding='utf-8') if not l.startswith('#')]
    return {r['id']: r for r in csv.DictReader(rows)}

F = {}
for k in range(1, 10):
    F.update(leer(f'cuadro{k}.csv'))
out = []
def comp(desc, a, b, fuente_b, tol=0.15):
    ok = abs(float(a) - float(b)) <= tol
    out.append([desc, round(float(a), 2), round(float(b), 2), fuente_b, 'OK' if ok else 'DIFIERE'])

y = '2025'
# 1. PIB 2025: crecimiento anual frente a la media de los trimestres (CLV, namq)
q, _ = eurostat1('namq_10_gdp', since='2024-Q1', geo='ES', unit='CLV10_MEUR', s_adj='NSA', na_item='B1GQ')
g = 100 * (sum(v for k, v in q.items() if k.startswith('2025')) / sum(v for k, v in q.items() if k.startswith('2024')) - 1)
comp('PIB real 2025 (%)', F['pib'][y], g, 'namq_10_gdp, suma de trimestres NSA')
# 2. Paro 2025: lfsa_urgan frente a une_rt_a
u, _ = eurostat1('une_rt_a', since=2025, geo='ES', age='Y15-74', sex='T', unit='PC_ACT')
comp('Tasa de paro 2025 (%)', F['paro'][y], u['2025'], 'une_rt_a')
# 3. IPCA 2025: media anual (ECOICOP 1) frente a la media de las tasas mensuales (ECOICOP 2)
m, _ = eurostat1('prc_hicp_minr', since='2025-01', geo='ES', unit='I25', coicop18='TOTAL')
m24, _ = eurostat1('prc_hicp_minr', since='2024-01', geo='ES', unit='I25', coicop18='TOTAL')
a25 = sum(v for k, v in m24.items() if k.startswith('2025')) / 12
a24 = sum(v for k, v in m24.items() if k.startswith('2024')) / 12
comp('IPCA 2025 (%)', F['ipca'][y], 100 * (a25 / a24 - 1), 'prc_hicp_minr, índices medios')
# 4. Déficit y deuda 2025 frente a AMECO (otra vintage) y gov_10dd_edpt1
d, _ = eurostat1('gov_10dd_edpt1', since=2025, geo='ES', unit='PC_GDP', sector='S13', na_item='B9')
comp('Saldo AAPP 2025 (% PIB)', F['saldo'][y], d['2025'], 'gov_10dd_edpt1 B9')
comp('Deuda AAPP 2025 (% PIB)', F['deuda'][y], ameco('1.0.319.0.UDGG')[0]['2025'], 'AMECO UDGG (primavera 2026)', 0.5)
# 5. Cuenta corriente 2025: bop_c6_a / PIB frente a bop_gdp6_q
cc, _ = eurostat1('bop_gdp6_q', since=2025, geo='ES', freq='A', unit='PC_GDP', partner='WRL_REST', s_adj='NSA', stk_flow='BAL', bop_item='CA')
comp('Cuenta corriente 2025 (% PIB)', F['cc'][y], cc['2025'], 'bop_gdp6_q CA')
cka, _ = eurostat1('bop_gdp6_q', since=2025, geo='ES', freq='A', unit='PC_GDP', partner='WRL_REST', s_adj='NSA', stk_flow='BAL', bop_item='CKA')
comp('Capacidad de financiación 2025 (% PIB)', F['cnf'][y], cka['2025'], 'bop_gdp6_q CKA')
# 6. PIIN 2025: tipsii10 frente a bop_gdp6_q
p, _ = eurostat1('bop_gdp6_q', since=2025, geo='ES', freq='A', unit='PC_GDP', partner='WRL_REST', s_adj='NSA', stk_flow='N_LE', bop_item='FA')
comp('PIIN 2025 (% PIB)', F['piin'][y], p['2025'], 'bop_gdp6_q FA N_LE', 0.5)
# 7. Contribuciones: suma = PIB
for a in ['2020', '2022', '2025']:
    comp(f'Contribuciones {a}: interna + externa = PIB', float(F['c_int'][a]) + float(F['c_ext'][a]), F['pib'][a], 'cuadro 1', 0.15)
# 8. Facilidad de depósito: fin de 2025 y hoy
dfr, _ = ecb('FM.D.U2.EUR.4F.KR.DFR.LEV', '2025-12-01')
comp('Facilidad de depósito, 31/12/2025 (%)', F['dfr'][y], dfr['2025-12-31'], 'BCE, dato diario')
# 9. Empleo 2025 frente a AMECO NETD
n = ameco('1.0.0.0.NETD')[0]
comp('Empleo 2025 (%)', F['emp'][y], 100 * (n['2025'] / n['2024'] - 1), 'AMECO NETD (otra vintage)', 0.3)
# 10. Rendimiento a 10 años 2025: anual frente a media mensual
b, _ = eurostat1('irt_lt_mcby_m', since='2025-01', geo='ES')
comp('Bono a 10 años 2025 (%)', F['rend'][y], sum(v for k, v in b.items() if k.startswith('2025')) / 12, 'irt_lt_mcby_m, media', 0.02)

with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'verificacion.csv'), 'w', newline='', encoding='utf-8') as f:
    w = csv.writer(f); w.writerow(['cifra', 'cuadro', 'comprobacion', 'fuente_comprobacion', 'resultado']); w.writerows(out)
for r in out: print(r)
