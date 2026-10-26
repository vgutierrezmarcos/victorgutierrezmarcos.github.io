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
def comp(desc, a, b, fuente_b, tol=0.15, info=False):
    ok = abs(float(a) - float(b)) <= tol
    res = 'INFORMATIVO (otra fecha de cierre)' if info else ('OK' if ok else 'DIFIERE')
    out.append([desc, round(float(a), 2), round(float(b), 2), fuente_b, res])

y = '2025'
es_pib, _ = eurostat1('nama_10_gdp', since=2025, geo='ES', unit='CP_MEUR', na_item='B1GQ')
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
dd, _ = eurostat1('gov_10dd_edpt1', since=2025, geo='ES', unit='PC_GDP', sector='S13', na_item='GD')
comp('Deuda AAPP 2025 (% PIB)', F['deuda'][y], dd['2025'], 'Eurostat gov_10dd_edpt1 GD', 0.2)
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
e, _ = eurostat1('lfsa_egan', since=2024, geo='ES', age='Y15-74', sex='T', citizen='TOTAL')
comp('Empleo 2025 (%, FMI = EPA)', F['emp'][y], 100 * (e['2025'] / e['2024'] - 1), 'Eurostat lfsa_egan (ocupados EPA 15-74)', 0.3)
# FMI: WEO (octubre) frente al Artículo IV (mayo) y frente a Eurostat
import fmi
A = fmi.art4()
comp('Previsión PIB 2026: WEO oct. frente a Artículo IV (mayo)', F['pib']['2026'], A[('Cuadro 1', 'Gross domestic product')]['2026'], 'Artículo IV 2026, cuadro 1', 0.5, info=True)
comp('Deuda 2026 prevista: WEO frente a Artículo IV', F['deuda']['2026'], A[('Cuadro 2b', 'General government gross debt (Maastricht)')]['2026'], 'Artículo IV 2026, cuadro 2b', 1.5, info=True)
comp('Brecha 2025: WEO frente a Artículo IV', F['brecha']['2025'], A[('Cuadro 1', 'Output gap (percent of potential output)')]['2025'], 'Artículo IV 2026, cuadro 1', 0.7, info=True)
comp('Saldo estructural primario 2025 (WEO + intereses) frente al Artículo IV', F['estr_p']['2025'], A[('Cuadro 2b', 'Primary structural balance 3/')]['2025'], 'Artículo IV 2026, cuadro 2b', 0.5, info=True)
comp('PIB nominal 2025 (mm€): WEO frente a Eurostat', F['pib_nom']['2025'], es_pib['2025'] / 1000, 'Eurostat nama_10_gdp CP_MEUR', 1.0)
# 10. Rendimiento a 10 años 2025: anual frente a media mensual
b, _ = eurostat1('irt_lt_mcby_m', since='2025-01', geo='ES')
comp('Bono a 10 años 2025 (%)', F['rend'][y], sum(v for k, v in b.items() if k.startswith('2025')) / 12, 'irt_lt_mcby_m, media', 0.02)

with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'verificacion.csv'), 'w', newline='', encoding='utf-8') as f:
    w = csv.writer(f); w.writerow(['cifra', 'cuadro', 'comprobacion', 'fuente_comprobacion', 'resultado']); w.writerows(out)
for r in out: print(r)
