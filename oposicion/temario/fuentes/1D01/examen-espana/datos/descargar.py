"""Descarga los datos del examen de ejemplo de España (1D01) de las API oficiales
(Eurostat, AMECO de la Comisión Europea y BCE) y escribe los CSV de esta carpeta.

    python3 -I descargar.py            (desde esta carpeta)

Cuadros: cuadro1.csv … cuadro7.csv (una fila por indicador; columnas 2007-2027;
2026 y 2027, previsiones de la Comisión, primavera de 2026, solo en las filas que
las tienen). Gráficos: g01-….csv … Cada CSV lleva en la cabecera (líneas «#») la
fuente, los códigos y la fecha de consulta. El detalle de cada serie está en
fuentes.md. Nada se inventa: si una serie no está, la celda queda vacía (n. d.).
"""
import csv, datetime, math, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fuentes_api import eurostat, eurostat1, ameco, ecb  # noqa: E402

AQUI = os.path.dirname(os.path.abspath(__file__))
HOY = datetime.date.today().isoformat()
A0, A1 = 2007, 2025              # serie histórica
P = [2026, 2027]                 # previsiones (AMECO, primavera de 2026)
ANIOS = [str(a) for a in range(A0, A1 + 1)]
TODOS = ANIOS + [str(a) for a in P]
ACTUALIZ = {}                    # dataset -> fecha de actualización


def es(ds, **f):
    v, upd = eurostat1(ds, since=A0 - 1, **f)
    ACTUALIZ[ds] = upd
    return {k: float(x) for k, x in v.items()}


def am(var):
    """AMECO (Comisión) ya no se usa: desde el 26/10/2026 las previsiones y los saldos ajustados son del FMI
    (aplicar_fmi). Se deja la función vacía para no tocar las definiciones de las filas."""
    return {}


def tasa(nivel):
    """Variación anual en % de una serie de niveles {año: valor}."""
    out = {}
    for a in nivel:
        b = str(int(a) - 1)
        if b in nivel and nivel[b]:
            out[a] = 100 * (nivel[a] / nivel[b] - 1)
    return out


def solo(d, anios):
    return {a: d[a] for a in anios if a in d}


def fila(id_, etiqueta, unidad, fuente, hist=None, prev=None, dec=1):
    vals = {}
    if hist:
        vals.update(solo(hist, ANIOS))
    if prev:
        vals.update(solo(prev, [str(a) for a in P]))
    return {'id': id_, 'indicador': etiqueta, 'unidad': unidad, 'fuente': fuente, 'dec': dec, **vals}


FILAS = {}


def guardar(titulo, filas, notas):
    """Guarda las filas por su id; ensamblar() las reparte en los cuadros del examen."""
    for r in filas:
        FILAS[r['id']] = r


def escribir_cuadro(nombre, titulo, filas, notas):
    ruta = os.path.join(AQUI, nombre)
    with open(ruta, 'w', newline='', encoding='utf-8') as f:
        f.write(f'# {titulo}\n')
        for n in notas:
            f.write(f'# {n}\n')
        f.write(f'# Consulta: {HOY}. Valores sin redondear salvo los que la fuente da redondeados.\n')
        w = csv.DictWriter(f, ['id', 'indicador', 'unidad', 'fuente', 'dec'] + TODOS)
        w.writeheader()
        for r in filas:
            w.writerow({k: (('%.4f' % v).rstrip('0').rstrip('.') if isinstance(v, float) else v)
                        for k, v in r.items()})
    print('escrito', nombre, len(filas), 'filas')


def escribir_serie(nombre, cabecera, columnas, filas):
    ruta = os.path.join(AQUI, nombre)
    with open(ruta, 'w', newline='', encoding='utf-8') as f:
        for c in cabecera:
            f.write(f'# {c}\n')
        f.write(f'# Consulta: {HOY}.\n')
        w = csv.writer(f)
        w.writerow(columnas)
        for r in filas:
            w.writerow(['' if v is None else (('%.4f' % v).rstrip('0').rstrip('.') if isinstance(v, float) else v)
                        for v in r])
    print('escrito', nombre, len(filas), 'filas')


# ---------------------------------------------------------------- Cuadro 1: demanda
def cuadro1():
    g = lambda item, u='CLV_PCH_PRE': es('nama_10_gdp', geo='ES', unit=u, na_item=item)
    c = lambda item: g(item, 'CON_PPCH_PRE')
    an6 = lambda a: es('nama_10_an6', geo='ES', unit='CLV_PCH_PRE', asset10=a)
    cint = {a: c('P3').get(a, math.nan) + c('P51G')[a] + c('P52_P53')[a] for a in ANIOS}
    cext = {a: c('P6')[a] + c('P7')[a] for a in ANIOS}
    pib_clv = g('B1GQ', 'CLV10_MEUR')
    pob = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='POP_NC')
    pib_pc = tasa({a: pib_clv[a] / pob[a] for a in pib_clv if a in pob})
    nominal = {a: v / 1000 for a, v in g('B1GQ', 'CP_MEUR').items()}
    pot = tasa(am('1.0.0.0.OVGDP'))
    brecha = am('1.0.0.0.AVGDGP')
    filas = [
        fila('pib', 'PIB', '%', 'Eurostat nama_10_gdp B1GQ CLV_PCH_PRE; prev. AMECO OVGD', g('B1GQ'), tasa(am('1.1.0.0.OVGD'))),
        fila('cpriv', 'Consumo privado (hogares e ISFLSH)', '%', 'nama_10_gdp P31_S14_S15; prev. AMECO OCPH', g('P31_S14_S15'), tasa(am('1.1.0.0.OCPH'))),
        fila('cpub', 'Consumo público', '%', 'nama_10_gdp P3_S13; prev. AMECO OCTG', g('P3_S13'), tasa(am('1.1.0.0.OCTG'))),
        fila('fbcf', 'Formación bruta de capital fijo', '%', 'nama_10_gdp P51G; prev. AMECO OIGT', g('P51G'), tasa(am('1.1.0.0.OIGT'))),
        fila('fbcf_viv', 'Viviendas', '%', 'nama_10_an6 N111G CLV_PCH_PRE', an6('N111G')),
        fila('fbcf_otc', 'Otras construcciones', '%', 'nama_10_an6 N112G', an6('N112G')),
        fila('fbcf_maq', 'Maquinaria, bienes de equipo y armamento', '%', 'nama_10_an6 N11MG', an6('N11MG')),
        fila('fbcf_pi', 'Productos de la propiedad intelectual', '%', 'nama_10_an6 N117G', an6('N117G')),
        fila('x', 'Exportaciones de bienes y servicios', '%', 'nama_10_gdp P6; prev. AMECO OXGS', g('P6'), tasa(am('1.1.0.0.OXGS'))),
        fila('m', 'Importaciones de bienes y servicios', '%', 'nama_10_gdp P7; prev. AMECO OMGS', g('P7'), tasa(am('1.1.0.0.OMGS'))),
        fila('c_int', 'Demanda nacional (contribución, pp)', 'pp', 'nama_10_gdp CON_PPCH_PRE: P3+P51G+P52_P53', cint, dec=1),
        fila('c_exist', 'de la cual, variación de existencias (pp)', 'pp', 'nama_10_gdp CON_PPCH_PRE P52_P53', c('P52_P53')),
        fila('c_ext', 'Demanda externa neta (contribución, pp)', 'pp', 'nama_10_gdp CON_PPCH_PRE: P6+P7', cext),
        fila('pib_pc', 'PIB real por habitante', '%', 'nama_10_gdp B1GQ CLV10_MEUR / nama_10_pe POP_NC', pib_pc),
        fila('pib_nom', 'PIB nominal (miles de millones de euros)', 'mm€', 'nama_10_gdp B1GQ CP_MEUR; prev. AMECO UVGD', nominal,
             {a: v for a, v in am('1.0.0.0.UVGD').items()}, dec=0),
        fila('pot', 'PIB potencial', '%', 'AMECO OVGDP (Comisión, función de producción)', pot, pot),
        fila('brecha', 'Brecha de producción (% del PIB potencial)', '%', 'AMECO AVGDGP', brecha, brecha),
    ]
    # comprobación: contribuciones = crecimiento del PIB
    for a in ANIOS:
        d = cint[a] + cext[a] - g('B1GQ')[a]
        if abs(d) > 0.15:
            print('  aviso contribuciones', a, round(d, 2))
    guardar( 'Cuadro 1. Demanda agregada y actividad (España)', filas, [
        'Eurostat (nama_10_gdp, nama_10_an6, nama_10_pe), actualizados el %s; contabilidad nacional del INE (SEC 2010).'
        % ACTUALIZ.get('nama_10_gdp'),
        'Previsiones 2026-2027 y PIB potencial/brecha: Comisión Europea, AMECO (previsiones de primavera de 2026). '
        'La serie de AMECO es anterior a la última revisión de la contabilidad nacional (en 2025, PIB +2,8 % en AMECO frente a +2,6 % en Eurostat).'])


# ---------------------------------------------------------------- Cuadro 2: oferta
def cuadro2():
    a10 = lambda n: es('nama_10_a10', geo='ES', unit='CLV_PCH_PRE', na_item='B1G', nace_r2=n)
    filas = [
        fila('vab', 'Valor añadido bruto total', '%', 'nama_10_a10 B1G TOTAL', a10('TOTAL')),
        fila('vab_a', 'Agricultura, ganadería, silvicultura y pesca', '%', 'nama_10_a10 B1G A', a10('A')),
        fila('vab_be', 'Industria', '%', 'nama_10_a10 B1G B-E', a10('B-E')),
        fila('vab_c', 'de la cual, manufacturas', '%', 'nama_10_a10 B1G C', a10('C')),
        fila('vab_f', 'Construcción', '%', 'nama_10_a10 B1G F', a10('F')),
        fila('vab_gi', 'Comercio, transporte y hostelería', '%', 'nama_10_a10 B1G G-I', a10('G-I')),
        fila('vab_j', 'Información y comunicaciones', '%', 'nama_10_a10 B1G J', a10('J')),
        fila('vab_mn', 'Actividades profesionales y administrativas', '%', 'nama_10_a10 B1G M_N', a10('M_N')),
        fila('vab_oq', 'Administración pública, educación y sanidad', '%', 'nama_10_a10 B1G O-Q', a10('O-Q')),
    ]
    guardar( 'Cuadro 2. Oferta: valor añadido bruto real por ramas (España)', filas, [
        'Eurostat nama_10_a10 (CLV_PCH_PRE), actualizado el %s.' % ACTUALIZ.get('nama_10_a10')])
    # Descomposición del PIB por habitante y por persona en edad de trabajar (tasas medias anuales, log)
    pib = es('nama_10_gdp', geo='ES', unit='CLV10_MEUR', na_item='B1GQ')
    pob = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='POP_NC')
    emp = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='EMP_DC')
    hor = es('nama_10_a10_e', geo='ES', unit='THS_HW', na_item='EMP_DC', nace_r2='TOTAL')
    p1564j = es('demo_pjanbroad', geo='ES', sex='T', age='Y15-64', unit='NR')
    # población 15-64 media del año: media de 1 de enero de t y de t+1 (si falta t+1, el 1 de enero de t)
    p1564 = {a: (p1564j[a] + p1564j.get(str(int(a) + 1), p1564j[a])) / 2 for a in p1564j}
    filas_d = []
    tramos = [('2007', '2013'), ('2013', '2019'), ('2019', '2025')]
    L = math.log
    def g(f, a, b):
        return 100 * (L(f(b)) - L(f(a))) / (int(b) - int(a))
    defs = [
        ('PIB', lambda t: pib[t]),
        ('Población', lambda t: pob[t]),
        ('Población en edad de trabajar (15-64) sobre población', lambda t: p1564[t] / 1000 / pob[t]),
        ('Tasa de ocupación (ocupados sobre población de 15-64)', lambda t: emp[t] / (p1564[t] / 1000)),
        ('Horas trabajadas por ocupado', lambda t: hor[t] / emp[t]),
        ('PIB por hora trabajada', lambda t: pib[t] / hor[t]),
        ('PIB por ocupado', lambda t: pib[t] / emp[t]),
        ('PIB por habitante', lambda t: pib[t] / pob[t]),
        ('PIB por persona en edad de trabajar', lambda t: pib[t] / p1564[t]),
        ('Horas trabajadas totales', lambda t: hor[t]),
    ]
    for nombre, f in defs:
        filas_d.append([nombre] + [g(f, a, b) for a, b in tramos])
    # comprobación de la identidad
    for k in range(3):
        assert abs(sum(filas_d[i][k + 1] for i in (3, 4, 5)) - filas_d[8][k + 1]) < 1e-9
        assert abs(sum(filas_d[i][k + 1] for i in (1, 2, 3, 4, 5)) - filas_d[0][k + 1]) < 1e-9
    escribir_serie('cuadro2b-descomposicion.csv', [
        'Cuadro 2 (bis). Descomposición del crecimiento del PIB (tasas medias anuales logarítmicas, en %).',
        'Identidades: PIB por persona en edad de trabajar = tasa de ocupación + horas por ocupado + PIB por hora (filas 4+5+6 = fila 9); '
        'PIB = población + peso de la población en edad de trabajar + filas 4, 5 y 6 (2+3+4+5+6 = 1).',
        'Eurostat: nama_10_gdp (B1GQ, CLV10_MEUR), nama_10_pe (POP_NC, EMP_DC; personas, contabilidad nacional), '
        'nama_10_a10_e (THS_HW, horas totales), demo_pjanbroad (población de 15-64 años a 1 de enero; media de 1 de enero de t y t+1).'],
        ['concepto', '2007-2013', '2013-2019', '2019-2025'], filas_d)


# ---------------------------------------------------------------- Cuadro 3: trabajo
def cuadro3():
    emp = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='EMP_DC')
    sal = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='SAL_DC')
    hor = es('nama_10_a10_e', geo='ES', unit='THS_HW', na_item='EMP_DC', nace_r2='TOTAL')
    d1 = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='D1')
    rem = tasa({a: d1[a] / sal[a] for a in d1 if a in sal})
    lp = lambda item, geo='ES': es('nama_10_lp_ulc', geo=geo, unit='PCH_PRE', na_item=item)
    lf = lambda ds, **f: es(ds, geo='ES', sex='T', **f)
    jv, upd = eurostat('jvs_q_r21', since='2006-Q1', geo='ES', s_adj='NSA', nace_r2_1='B-T', sizeclas='TOTAL', indic_em='JVR')
    ACTUALIZ['jvs_q_r21'] = upd
    jv = list(jv.values())[0]
    vac = {}
    for a in ANIOS:
        q = [jv[k] for k in jv if k.startswith(a)]
        if len(q) == 4:
            vac[a] = sum(q) / 4
    pop = es('migr_pop1ctz', geo='ES', sex='T', age='TOTAL', citizen='TOTAL', unit='NR')
    nat = es('migr_pop1ctz', geo='ES', sex='T', age='TOTAL', citizen='NAT', unit='NR')
    ext = {a: 100 * (pop[a] - nat[a]) / pop[a] for a in pop if a in nat}
    filas = [
        fila('emp', 'Empleo (personas, contabilidad nacional)', '%', 'nama_10_pe EMP_DC; prev. AMECO NETD', tasa(emp), tasa(am('1.0.0.0.NETD'))),
        fila('horas', 'Horas trabajadas', '%', 'nama_10_a10_e THS_HW TOTAL', tasa(hor)),
        fila('act', 'Tasa de actividad (15-64 años, % de la población)', '%', 'lfsa_argan Y15-64', lf('lfsa_argan', age='Y15-64', citizen='TOTAL')),
        fila('templeo', 'Tasa de empleo (15-64 años, % de la población)', '%', 'lfsa_ergan Y15-64', lf('lfsa_ergan', age='Y15-64', citizen='TOTAL')),
        fila('paro', 'Tasa de paro (15-74 años, % de los activos)', '%', 'lfsa_urgan Y15-74; prev. AMECO ZUTN',
             lf('lfsa_urgan', age='Y15-74', citizen='TOTAL'), am('1.0.0.0.ZUTN')),
        fila('paro_ze', 'Tasa de paro de la zona del euro (15-74 años)', '%', 'une_rt_a EA20 Y15-74',
             es('une_rt_a', geo='EA20', age='Y15-74', sex='T', unit='PC_ACT')),
        fila('paro_juv', 'Tasa de paro juvenil (15-24 años)', '%', 'lfsa_urgan Y15-24', lf('lfsa_urgan', age='Y15-24', citizen='TOTAL')),
        fila('paro_ld', 'Paro de larga duración (% de los activos)', '%', 'une_ltu_a LTU Y15-74 PC_ACT',
             es('une_ltu_a', geo='ES', age='Y15-74', sex='T', unit='PC_ACT', indic_em='LTU')),
        fila('temp', 'Asalariados con contrato temporal (% del total, 15-64)', '%', 'lfsa_etpgan Y15-64',
             lf('lfsa_etpgan', age='Y15-64', citizen='TOTAL')),
        fila('vac', 'Tasa de vacantes (% de los puestos de trabajo)', '%', 'jvs_q_r21 JVR B-T NSA, media de 4 trimestres', vac, dec=2),
        fila('prod_oc', 'Productividad por ocupado', '%', 'nama_10_lp_ulc RLPR_PER', lp('RLPR_PER')),
        fila('prod_h', 'Productividad por hora trabajada', '%', 'nama_10_lp_ulc RLPR_HW', lp('RLPR_HW')),
        fila('rem', 'Remuneración por asalariado', '%', 'nama_10_gdp D1 CP_MEUR / nama_10_pe SAL_DC', rem),
        fila('clu', 'Costes laborales unitarios nominales', '%', 'nama_10_lp_ulc NULC_PER', lp('NULC_PER')),
        fila('clu_ze', 'Costes laborales unitarios nominales, zona del euro', '%', 'nama_10_lp_ulc NULC_PER EA20', lp('NULC_PER', 'EA20')),
        fila('pob', 'Población', '%', 'nama_10_pe POP_NC', tasa(es('nama_10_pe', geo='ES', unit='THS_PER', na_item='POP_NC'))),
        fila('extr', 'Población de nacionalidad extranjera (% del total, 1 de enero)', '%', 'migr_pop1ctz TOTAL-NAT', ext),
        fila('dep', 'Tasa de dependencia de los mayores (65+ sobre 15-64, %)', '%', 'demo_pjanind OLDDEP1',
             es('demo_pjanind', geo='ES', indic_de='OLDDEP1')),
    ]
    guardar( 'Cuadro 3. Mercado de trabajo, costes y demografía (España)', filas, [
        'Eurostat: nama_10_pe, nama_10_a10_e, nama_10_gdp, nama_10_lp_ulc (contabilidad nacional); lfsa_* y une_* (encuesta de población activa); '
        'jvs_q_r21 (vacantes, NACE Rev. 2.1); migr_pop1ctz y demo_pjanind (población a 1 de enero). Previsiones: AMECO.'])


# ---------------------------------------------------------------- Cuadro 4: precios
def cuadro4():
    h = lambda c, geo='ES': es('prc_hicp_aind', geo=geo, unit='RCH_A_AVG', coicop=c)
    d = lambda item: es('nama_10_gdp', geo='ES', unit='PD_PCH_PRE_EUR', na_item=item)
    filas = [
        fila('ipca', 'IPCA: índice general', '%', 'prc_hicp_aind CP00 RCH_A_AVG; prev. AMECO ZCPIH', h('CP00'), tasa(am('1.0.0.0.ZCPIH'))),
        fila('ipca_sub', 'IPCA sin energía ni alimentos (subyacente)', '%', 'prc_hicp_aind TOT_X_NRG_FOOD', h('TOT_X_NRG_FOOD')),
        fila('ipca_nrg', 'IPCA: energía', '%', 'prc_hicp_aind NRG', h('NRG')),
        fila('ipca_food', 'IPCA: alimentos, bebidas y tabaco', '%', 'prc_hicp_aind FOOD', h('FOOD')),
        fila('ipca_ze', 'IPCA de la zona del euro: índice general', '%', 'prc_hicp_aind CP00 EA', h('CP00', 'EA')),
        fila('ipca_ze_sub', 'IPCA de la zona del euro: subyacente', '%', 'prc_hicp_aind TOT_X_NRG_FOOD EA', h('TOT_X_NRG_FOOD', 'EA')),
        fila('def_pib', 'Deflactor del PIB', '%', 'nama_10_gdp B1GQ PD_PCH_PRE_EUR', d('B1GQ')),
        fila('def_c', 'Deflactor del consumo privado', '%', 'nama_10_gdp P31_S14_S15 PD_PCH_PRE_EUR', d('P31_S14_S15')),
        fila('def_x', 'Deflactor de las exportaciones', '%', 'nama_10_gdp P6 PD_PCH_PRE_EUR', d('P6')),
        fila('def_m', 'Deflactor de las importaciones', '%', 'nama_10_gdp P7 PD_PCH_PRE_EUR', d('P7')),
        fila('viv', 'Precio de la vivienda (nominal)', '%', 'prc_hpi_a TOTAL RCH_A_AVG', es('prc_hpi_a', geo='ES', purchase='TOTAL', unit='RCH_A_AVG')),
        fila('viv_r', 'Precio de la vivienda deflactado (real)', '%', 'tipsho10 RCH_A_AVG', es('tipsho10', geo='ES', unit='RCH_A_AVG')),
    ]
    guardar( 'Cuadro 4. Precios (España y zona del euro)', filas, [
        'Eurostat: prc_hicp_aind (IPCA, ECOICOP ver. 1, medias anuales; actualizado el %s), nama_10_gdp (deflactores), '
        'prc_hpi_a y tipsho10 (precios de la vivienda). Previsión del IPCA: AMECO ZCPIH.' % ACTUALIZ.get('prc_hicp_aind')])


# ---------------------------------------------------------------- Cuadro 5: exterior
def cuadro5():
    pib = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='B1GQ')
    def bop(item, flow='BAL', s10='S1'):
        v = es('bop_c6_a', geo='ES', currency='MIO_EUR', partner='WRL_REST', sector10=s10, sectpart='S1',
               stk_flow=flow, bop_item=item)
        return {a: 100 * v[a] / pib[a] for a in v if a in pib}
    gdp6 = lambda item, flow: es('bop_gdp6_q', geo='ES', freq='A', unit='PC_GDP', partner='WRL_REST', s_adj='NSA',
                                 stk_flow=flow, bop_item=item)
    x = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='P6')
    m = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='P7')
    apert = {a: 100 * (x[a] + m[a]) / pib[a] for a in pib}
    reer = lambda r: es('ert_eff_ic_a', geo='ES', exch_rt=r, unit='I20')
    filas = [
        fila('cc', 'Cuenta corriente', '% PIB', 'bop_c6_a CA BAL; prev. AMECO UBCA (contabilidad nacional)', bop('CA'), am('1.0.310.0.UBCA')),
        fila('bie', 'Bienes', '% PIB', 'bop_c6_a G BAL', bop('G')),
        fila('ser', 'Servicios', '% PIB', 'bop_c6_a S BAL', bop('S')),
        fila('tur', 'de los cuales, viajes (turismo)', '% PIB', 'bop_c6_a SD BAL', bop('SD')),
        fila('rp', 'Rentas primarias', '% PIB', 'bop_c6_a IN1 BAL', bop('IN1')),
        fila('rs', 'Rentas secundarias', '% PIB', 'bop_c6_a IN2 BAL', bop('IN2')),
        fila('kap', 'Cuenta de capital', '% PIB', 'bop_c6_a KA BAL', bop('KA')),
        fila('cnf', 'Capacidad (+) o necesidad (-) de financiación', '% PIB', 'bop_c6_a CKA BAL', bop('CKA')),
        fila('fa', 'Cuenta financiera, saldo neto (+ = salida neta)', '% PIB', 'bop_c6_a FA NET', bop('FA', 'NET')),
        fila('fa_d', 'Inversión directa', '% PIB', 'bop_c6_a FA__D__F NET', bop('FA__D__F', 'NET')),
        fila('fa_p', 'Inversión de cartera', '% PIB', 'bop_c6_a FA__P__F NET', bop('FA__P__F', 'NET')),
        fila('fa_f', 'Derivados financieros', '% PIB', 'bop_c6_a FA__F__F7 NET', bop('FA__F__F7', 'NET')),
        fila('fa_o', 'Otra inversión', '% PIB', 'bop_c6_a FA__O__F NET', bop('FA__O__F', 'NET')),
        fila('fa_o_bde', 'de la cual, Banco de España', '% PIB', 'bop_c6_a FA__O__F NET sector S121', bop('FA__O__F', 'NET', 'S121')),
        fila('fa_r', 'Activos de reserva', '% PIB', 'bop_c6_a FA__R__F ASS sector S121', bop('FA__R__F', 'ASS', 'S121')),
        fila('eo', 'Errores y omisiones', '% PIB', 'bop_c6_a EO NET', bop('EO', 'NET')),
        fila('piin', 'Posición de inversión internacional neta', '% PIB', 'tipsii10 PC_GDP', es('tipsii10', geo='ES', unit='PC_GDP', partner='WRL_REST')),
        fila('piin_nendi', 'PIIN sin instrumentos que no generan impago', '% PIB', 'bop_gdp6_q FA__NENDI N_LE', gdp6('FA__NENDI', 'N_LE')),
        fila('den', 'Deuda externa neta', '% PIB', 'bop_gdp6_q FA__FNED NE_LE', gdp6('FA__FNED', 'NE_LE')),
        fila('tcer_ipc', 'Tipo de cambio efectivo real, IPC, 42 socios (2020 = 100)', 'índice', 'ert_eff_ic_a REER_IC42_CPI I20', reer('REER_IC42_CPI')),
        fila('tcer_clu', 'Tipo de cambio efectivo real, CLU, frente a la zona del euro (2020 = 100)', 'índice',
             'ert_eff_ic_a REER_EA20_ULCT I20', reer('REER_EA20_ULCT')),
        fila('cuota', 'Cuota en las exportaciones mundiales de bienes y servicios', '%', 'tipsex20 GS', es('tipsex20', geo='ES', bop_item='GS')),
        fila('apert', 'Grado de apertura ((X + M) / PIB)', '% PIB', 'nama_10_gdp P6+P7 / B1GQ CP_MEUR', apert),
    ]
    guardar( 'Cuadro 5. Sector exterior (España)', filas, [
        'Eurostat: bop_c6_a (balanza de pagos MBP6, millones de euros; actualizado el %s; aquí en %% del PIB nominal de nama_10_gdp), '
        'bop_gdp6_q, tipsii10 (cuadro de indicadores del procedimiento de desequilibrios), ert_eff_ic_a (un aumento del índice es una '
        'apreciación real), tipsex20, nama_10_gdp. Elaboradas por el Banco de España.' % ACTUALIZ.get('bop_c6_a'),
        'Cuenta financiera con el criterio del MBP6: saldo neto = variación neta de activos - variación neta de pasivos (+ = salida neta de capital).'])


# ---------------------------------------------------------------- Cuadro 6: sector público
def cuadro6():
    gv = lambda item: es('gov_10a_main', geo='ES', unit='PC_GDP', sector='S13', na_item=item)
    gm = lambda item: es('gov_10a_main', geo='ES', unit='MIO_EUR', sector='S13', na_item=item)
    deuda_m = es('gov_10dd_edpt1', geo='ES', unit='MIO_EUR', sector='S13', na_item='GD')
    int_m = gm('D41PAY')
    impl = {a: 100 * int_m[a] / deuda_m[str(int(a) - 1)] for a in int_m if str(int(a) - 1) in deuda_m}
    pibn = tasa(es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='B1GQ'))
    b9, d41 = gv('B9'), gv('D41PAY')
    prim = {a: b9[a] + d41[a] for a in b9}
    rend = es('irt_lt_mcby_a', geo='ES', int_rt='MCBY')
    rend_de = es('irt_lt_mcby_a', geo='DE', int_rt='MCBY')
    dif = {a: 100 * (rend[a] - rend_de[a]) for a in rend if a in rend_de}
    ublge, uyige = am('1.0.319.0.UBLGE'), am('1.0.319.0.UYIGE')
    filas = [
        fila('ing', 'Ingresos', '% PIB', 'gov_10a_main TR', gv('TR')),
        fila('gas', 'Gastos', '% PIB', 'gov_10a_main TE; prev. AMECO UUTGE', gv('TE'), am('1.0.319.0.UUTGE')),
        fila('int', 'de los cuales, intereses', '% PIB', 'gov_10a_main D41PAY; prev. AMECO UYIGE', d41, uyige),
        fila('saldo', 'Saldo (capacidad o necesidad de financiación)', '% PIB', 'gov_10a_main B9; prev. AMECO UBLGE', b9, ublge),
        fila('prim', 'Saldo primario', '% PIB', 'B9 + D41PAY; prev. AMECO UBLGE + UYIGE', prim, {a: ublge[a] + uyige[a] for a in ublge if a in uyige}),
        fila('cicl', 'Saldo ajustado de ciclo', '% PIB pot.', 'AMECO UBLGAP', am('1.0.319.0.UBLGAP'), am('1.0.319.0.UBLGAP')),
        fila('estr', 'Saldo estructural', '% PIB pot.', 'AMECO UBLGAPS', am('1.0.319.0.UBLGAPS'), am('1.0.319.0.UBLGAPS')),
        fila('estr_p', 'Saldo estructural primario', '% PIB pot.', 'AMECO UBLGBPS', am('1.0.319.0.UBLGBPS'), am('1.0.319.0.UBLGBPS')),
        fila('deuda', 'Deuda pública (definición del PDE)', '% PIB', 'gov_10dd_edpt1 GD; prev. AMECO UDGG',
             es('gov_10dd_edpt1', geo='ES', unit='PC_GDP', sector='S13', na_item='GD'), am('1.0.319.0.UDGG')),
        fila('impl', 'Tipo de interés implícito de la deuda (intereses / deuda del año anterior)', '%', 'D41PAY MIO_EUR / GD MIO_EUR (t-1)', impl),
        fila('pibn', 'PIB nominal', '%', 'nama_10_gdp B1GQ CP_MEUR; prev. AMECO UVGD', pibn, tasa(am('1.0.0.0.UVGD'))),
        fila('rend', 'Rendimiento de la deuda pública a 10 años (media anual)', '%', 'irt_lt_mcby_a MCBY ES', rend, dec=2),
        fila('dif', 'Diferencial frente al bono alemán a 10 años (pb)', 'pb', 'irt_lt_mcby_a ES - DE', dif, dec=0),
    ]
    guardar( 'Cuadro 6. Cuentas públicas (España)', filas, [
        'Eurostat: gov_10a_main y gov_10dd_edpt1 (notificación del procedimiento de déficit excesivo de octubre de 2026; actualizados el %s), '
        'irt_lt_mcby_a (rendimiento de convergencia). Saldos ajustados: Comisión Europea, AMECO (primavera de 2026). '
        % ACTUALIZ.get('gov_10a_main')])


# ---------------------------------------------------------------- Cuadro 7: monetario y financiero
def media_anual(d):
    out = {}
    for a in ANIOS:
        v = [d[k] for k in d if k.startswith(a)]
        if len(v) == 12:
            out[a] = sum(v) / 12
    return out


def diciembre(d):
    return {a: d[a + '-12'] for a in ANIOS if a + '-12' in d}


def fin_anio_diario(d):
    out = {}
    for a in ANIOS:
        ks = sorted(k for k in d if k.startswith(a))
        if ks:
            out[a] = d[ks[-1]]
    return out


def cuadro7():
    dfr, _ = ecb('FM.D.U2.EUR.4F.KR.DFR.LEV', '2006-01-01')
    mro, _ = ecb('FM.D.U2.EUR.4F.KR.MRR_RT.LEV', '2006-01-01')
    eur12, _ = ecb('FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA', '2006-01')
    hip, _ = ecb('MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N', '2006-01')
    hip_ze, _ = ecb('MIR.M.U2.B.A2C.AM.R.A.2250.EUR.N', '2006-01')
    snf, _ = ecb('MIR.M.ES.B.A2A.A.R.A.2240.EUR.N', '2006-01')
    phog, _ = ecb('BSI.M.ES.N.A.A20.A.I.U2.2250.Z01.A', '2006-01')
    psnf, _ = ecb('BSI.M.ES.N.A.A20.A.I.U2.2240.Z01.A', '2006-01')
    m3, _ = ecb('BSI.M.U2.Y.V.M30.X.I.U2.2300.Z01.A', '2006-01')
    ACTUALIZ['BCE'] = HOY
    cbd = lambda area, it, f='A': ecb(f'CBD2.A.{area}.W0.11._Z._Z.A.{f}.{it}._Z._Z._Z._Z._Z._Z.PC', '2006')[0]
    filas = [
        fila('dfr', 'Tipo de la facilidad de depósito del BCE (fin de año)', '%', 'BCE FM.D.U2.EUR.4F.KR.DFR.LEV', fin_anio_diario(dfr), dec=2),
        fila('mro', 'Tipo de las operaciones principales de financiación (fin de año)', '%', 'BCE FM.D.U2.EUR.4F.KR.MRR_RT.LEV', fin_anio_diario(mro), dec=2),
        fila('eur12', 'Euríbor a 12 meses (media anual)', '%', 'BCE FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA', media_anual(eur12), dec=2),
        fila('m3', 'M3 de la zona del euro (variación interanual en diciembre)', '%', 'BCE BSI.M.U2.Y.V.M30.X.I.U2.2300.Z01.A', diciembre(m3)),
        fila('hip', 'Tipo de los préstamos nuevos a hogares para vivienda (media anual)', '%', 'BCE MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N', media_anual(hip), dec=2),
        fila('hip_ze', 'Ídem, zona del euro', '%', 'BCE MIR.M.U2.B.A2C.AM.R.A.2250.EUR.N', media_anual(hip_ze), dec=2),
        fila('snf_t', 'Tipo de los préstamos nuevos a sociedades no financieras (media anual)', '%', 'BCE MIR.M.ES.B.A2A.A.R.A.2240.EUR.N', media_anual(snf), dec=2),
        fila('phog', 'Préstamos bancarios a hogares (variación interanual en diciembre)', '%', 'BCE BSI.M.ES.N.A.A20.A.I.U2.2250.Z01.A', diciembre(phog)),
        fila('psnf', 'Préstamos bancarios a sociedades no financieras (variación interanual en diciembre)', '%', 'BCE BSI.M.ES.N.A.A20.A.I.U2.2240.Z01.A', diciembre(psnf)),
        fila('dhog', 'Deuda de los hogares (consolidada)', '% PIB', 'Eurostat tipspd22', es('tipspd22', geo='ES', unit='PC_GDP')),
        fila('dsnf', 'Deuda de las sociedades no financieras (consolidada)', '% PIB', 'Eurostat tipspd30', es('tipspd30', geo='ES', unit='PC_GDP')),
        fila('cet1', 'Bancos: capital ordinario de nivel 1 (CET1, % de los APR)', '%', 'BCE CBD2 I4008 ES', cbd('ES', 'I4008')),
        fila('cet1_ue', 'Ídem, media de la UE', '%', 'BCE CBD2 I4008 B0', cbd('B0', 'I4008')),
        fila('solv', 'Bancos: ratio de capital total (% de los APR)', '%', 'BCE CBD2 I4001 ES', cbd('ES', 'I4001')),
        fila('npl', 'Bancos: préstamos dudosos (% de los préstamos brutos)', '%', 'BCE CBD2 I3632 (FINREP) ES', cbd('ES', 'I3632', 'F')),
        fila('npl_ue', 'Ídem, media de la UE', '%', 'BCE CBD2 I3632 (FINREP) B0', cbd('B0', 'I3632', 'F')),
        fila('roe', 'Bancos: rentabilidad sobre recursos propios (ROE)', '%', 'BCE CBD2 I2003 ES', cbd('ES', 'I2003')),
        fila('roe_ue', 'Ídem, media de la UE', '%', 'BCE CBD2 I2003 B0', cbd('B0', 'I2003')),
    ]
    guardar( 'Cuadro 7. Política monetaria, crédito y sistema bancario', filas, [
        'BCE, portal de datos (data-api.ecb.europa.eu): tipos oficiales (FM), tipos de interés de las IFM (MIR), balance de las IFM (BSI) y '
        'datos bancarios consolidados (CBD2, grupos bancarios nacionales y bancos independientes; datos de 2014 en adelante para CET1 y dudosos; '
        'ROE desde 2008 en España). Eurostat tipspd22 y tipspd30 (cuadro de indicadores del procedimiento de desequilibrios).'])


# ---------------------------------------------------------------- Filas añadidas (examen completo)
def filas_nuevas():
    pib = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='B1GQ')
    ki = lambda item, sector: es('nasa_10_ki', geo='ES', na_item=item, sector=sector, unit='PC')
    fbc = es('nama_10_gdp', geo='ES', unit='PC_GDP', na_item='P5G')
    try:
        b8g = es('nasa_10_nf_tr', geo='ES', unit='CP_MEUR', na_item='B8G', sector='S1', direct='PAID')
    except Exception:
        b8g = {}
    ahorro_nac = {a: 100 * b8g[a] / pib[a] for a in b8g if a in pib}
    ahorro_hog = ki('SRG_S14_S15', 'S14_S15')
    try:
        rdb = es('nasa_10_ki', geo='ES', na_item='B7G_R_HAB_GR', sector='S14_S15', unit='PC')
    except Exception:
        rdb = {}
    nuevas = [
        fila('ahorro_hog', 'Tasa de ahorro de los hogares (% de la renta disponible bruta)', '%', 'nasa_10_ki SRG_S14_S15', ahorro_hog),
        fila('rdb', 'Renta disponible bruta real ajustada por habitante (variación)', '%', 'nasa_10_ki B7G_R_HAB_GR', rdb),
        fila('inv_hog', 'Tasa de inversión de los hogares (% de la renta disponible)', '%', 'nasa_10_ki IRG_S14_S15', ki('IRG_S14_S15', 'S14_S15')),
        fila('inv_snf', 'Tasa de inversión de las empresas no financieras (% del VAB)', '%', 'nasa_10_ki IRG_S11', ki('IRG_S11', 'S11')),
        fila('ben_snf', 'Participación de los beneficios de las empresas (% del VAB)', '%', 'nasa_10_ki B2G_B3G_RAT_S11', ki('B2G_B3G_RAT_S11', 'S11')),
        fila('fbc', 'Formación bruta de capital (% del PIB)', '%', 'nama_10_gdp P5G PC_GDP', fbc),
        fila('ahorro_nac', 'Ahorro nacional bruto (% del PIB)', '%', 'nasa_10_nf_tr B8G S1 / nama_10_gdp B1GQ', ahorro_nac),
        fila('flujo_cred', 'Flujo de crédito al sector privado (% del PIB)', '%', 'tipspc10 PC_GDP', es('tipspc10', geo='ES', unit='PC_GDP')),
        fila('viv', 'Precio de la vivienda (variación)', '%', 'prc_hpi_a TOTAL RCH_A_AVG', es('prc_hpi_a', geo='ES', purchase='TOTAL', unit='RCH_A_AVG')),
        fila('viv_r', 'Precio de la vivienda deflactado (variación)', '%', 'tipsho10 RCH_A_AVG', es('tipsho10', geo='ES', unit='RCH_A_AVG')),
        fila('cuota_g', 'Cuota en las exportaciones mundiales de bienes', '%', 'tipsex20 G', es('tipsex20', geo='ES', bop_item='G')),
        fila('cuota_s', 'Cuota en las exportaciones mundiales de servicios', '%', 'tipsex20 S', es('tipsex20', geo='ES', bop_item='S')),
        fila('cuota_5a', 'Cuota de exportación: variación en 5 años', '%', 'tipsex10 GS WRL_REST', es('tipsex10', geo='ES', bop_item='GS', partner='WRL_REST')),
        fila('htec', 'Exportaciones de alta tecnología (% de las exportaciones)', '%', 'tipsex12', es('tipsex12', geo='ES')),
        fila('id', 'Gasto en I+D (% del PIB)', '%', 'rd_e_gerdtot TOTAL PC_GDP ES', es('rd_e_gerdtot', geo='ES', sectperf='TOTAL', unit='PC_GDP'), dec=2),
        fila('id_ue', 'Ídem, Unión Europea', '%', 'rd_e_gerdtot TOTAL PC_GDP EU27_2020', es('rd_e_gerdtot', geo='EU27_2020', sectperf='TOTAL', unit='PC_GDP'), dec=2),
    ]
    # Activo del Eurosistema en % del PIB nominal de la zona del euro (última semana del año)
    ilm, _ = ecb('ILM.W.U2.C.T000000.Z5.Z01', '2006-01')
    pib_ze = es('nama_10_gdp', geo='EA20', unit='CP_MEUR', na_item='B1GQ')
    act = {}
    for a in ANIOS:
        ks = sorted(k for k in ilm if k.startswith(a + '-W'))
        if ks and a in pib_ze:
            act[a] = 100 * ilm[ks[-1]] / pib_ze[a]
    cbd = lambda area, it: ecb(f'CBD2.A.{area}.W0.11._Z._Z.A.A.{it}._Z._Z._Z._Z._Z._Z.PC', '2006')[0]
    nuevas += [
        fila('eurosis', 'Activo del Eurosistema (% del PIB de la zona del euro, fin de año)', '%', 'BCE ILM.W.U2.C.T000000.Z5.Z01 / nama_10_gdp EA20', act),
        fila('roa', 'Bancos: rentabilidad del activo (ROA)', '%', 'BCE CBD2 I2004 ES', cbd('ES', 'I2004'), dec=2),
        fila('roa_ue', 'Ídem, media de la UE', '%', 'BCE CBD2 I2004 B0', cbd('B0', 'I2004'), dec=2),
    ]
    for r in nuevas:
        FILAS[r['id']] = r


# ---------------------------------------------------------------- FMI (decisión de Víctor, 26/10/2026)
def aplicar_fmi():
    """Las filas que da el FMI pasan a salir del FMI (como en los exámenes reales): serie completa
    del WEO de octubre de 2026 (historia y previsiones 2026-2027); donde el WEO no llega, historia de
    Eurostat y previsiones del Artículo IV de 2026. Lo demás sigue de Eurostat, el BCE o la EIA."""
    import fmi
    W, A = fmi.weo(), fmi.art4()
    ACTUALIZ['FMI WEO'] = 'octubre de 2026 (publicado el 13/10/2026; España, 25/09/2026)'
    ACTUALIZ['FMI Artículo IV'] = 'IMF Country Report 26/102, 21/05/2026'
    T = [str(a) for a in range(A0, 2028)]
    w = lambda ind: {a: v for a, v in W.get(ind, {}).items() if str(A0 - 1) <= a <= '2027'}   # 2006 para las tasas
    def poner(id_, etiqueta, vals, fuente, dec=None):
        r = {'id': id_, 'indicador': etiqueta, 'unidad': FILAS.get(id_, {}).get('unidad', '%'), 'fuente': fuente,
             'dec': dec if dec is not None else FILAS.get(id_, {}).get('dec', 1)}
        r.update({a: vals[a] for a in T if a in vals})
        FILAS[id_] = r
    def prev_art4(id_, tabla, fila, fuente_extra):
        r = FILAS[id_]
        for a in ('2026', '2027'):
            r[a] = A[(tabla, fila)][a]
        r['fuente'] = r['fuente'].split('; prev.')[0] + '; prev. ' + fuente_extra
    # Serie completa del WEO
    ngdp_r, gap = w('NGDP_R'), w('NGAP_NPGDP')
    pot = tasa({a: ngdp_r[a] / (1 + gap[a] / 100) for a in ngdp_r if a in gap})
    poner('pib', 'PIB', w('NGDP_RPCH'), 'FMI WEO oct. 2026 NGDP_RPCH')
    poner('x', 'Exportaciones de bienes y servicios', w('TX_RPCH'), 'FMI WEO TX_RPCH')
    poner('m', 'Importaciones de bienes y servicios', w('TM_RPCH'), 'FMI WEO TM_RPCH')
    poner('pib_pc', 'PIB real por habitante', tasa(w('NGDPRPC')), 'FMI WEO NGDPRPC (variación)')
    poner('pib_nom', 'PIB nominal (miles de millones de euros)', {a: v / 1e9 for a, v in w('NGDP').items()}, 'FMI WEO NGDP', 0)
    poner('pot', 'PIB potencial', pot, 'FMI WEO: NGDP_R / (1 + NGAP_NPGDP/100), variación')
    poner('brecha', 'Brecha de producción (% del PIB potencial)', gap, 'FMI WEO NGAP_NPGDP')
    poner('emp', 'Empleo (personas)', tasa(w('LE')), 'FMI WEO LE (variación)')
    poner('paro', 'Tasa de paro', w('LUR'), 'FMI WEO LUR')
    poner('pob', 'Población', tasa(w('LP')), 'FMI WEO LP (variación)')
    poner('ipca', 'IPCA: índice general', w('PCPIPCH'), 'FMI WEO PCPIPCH')
    poner('def_pib', 'Deflactor del PIB', tasa(w('NGDP_D')), 'FMI WEO NGDP_D (variación)')
    poner('cc', 'Cuenta corriente', w('BCA_NGDPD'), 'FMI WEO BCA_NGDPD')
    poner('fbc', 'Formación bruta de capital (% del PIB)', w('NID_NGDP'), 'FMI WEO NID_NGDP')
    poner('ahorro_nac', 'Ahorro nacional bruto (% del PIB)', w('NGSD_NGDP'), 'FMI WEO NGSD_NGDP')
    poner('ing', 'Ingresos', w('GGR_NGDP'), 'FMI WEO GGR_NGDP')
    poner('gas', 'Gastos', w('GGX_NGDP'), 'FMI WEO GGX_NGDP')
    poner('saldo', 'Saldo', w('GGXCNL_NGDP'), 'FMI WEO GGXCNL_NGDP')
    poner('prim', 'Saldo primario', w('GGXONLB_NGDP'), 'FMI WEO GGXONLB_NGDP (sin intereses cobrados)')
    poner('estr', 'Saldo estructural (% del PIB potencial)', w('GGSB_NPGDP'), 'FMI WEO GGSB_NPGDP')
    poner('deuda', 'Deuda pública bruta', w('GGXWDG_NGDP'), 'FMI WEO GGXWDG_NGDP')
    poner('deuda_neta', 'Deuda pública neta', w('GGXWDN_NGDP'), 'FMI WEO GGXWDN_NGDP')
    poner('pibn', 'PIB nominal', tasa(w('NGDP')), 'FMI WEO NGDP (variación)')
    # Historia de Eurostat y previsiones del Artículo IV (el WEO no da estas filas)
    for id_, fila in [('cpriv', 'Private consumption'), ('cpub', 'Public consumption'), ('fbcf', 'Gross fixed investment')]:
        prev_art4(id_, 'Cuadro 1', fila, 'FMI Artículo IV 2026, cuadro 1')
    prev_art4('c_ext', 'Cuadro 1', 'Net exports (contribution to growth)', 'FMI Artículo IV 2026, cuadro 1')
    prev_art4('int', 'Cuadro 2b', 'Interest', 'FMI Artículo IV 2026, cuadro 2b')
    for id_, fila in [('rp', 'Primary income (% del PIB)'), ('rs', 'Secondary income (% del PIB)'),
                      ('kap', 'Capital account (% del PIB)'), ('piin', 'Net international investment position')]:
        prev_art4(id_, 'Cuadro 4', fila, 'FMI Artículo IV 2026, cuadro 4')
    for id_, x, m in [('bie', 'Exports of goods (% del PIB)', 'Imports of goods (% del PIB)'),
                      ('ser', 'Exports of services (% del PIB)', 'Imports of services (% del PIB)')]:
        r = FILAS[id_]
        for a in ('2026', '2027'):
            r[a] = A[('Cuadro 4', x)][a] - A[('Cuadro 4', m)][a]
        r['fuente'] += '; prev. FMI Artículo IV 2026, cuadro 4 (exportaciones menos importaciones)'
    # Saldo estructural primario: estructural del WEO más intereses (Eurostat; 2026-2027, Artículo IV)
    estr, inte = w('GGSB_NPGDP'), dict(FILAS['int'])
    poner('estr_p', 'Saldo estructural primario (% del PIB potencial)',
          {a: estr[a] + float(inte[a]) for a in estr if a in inte and inte[a] not in ('', None)},
          'FMI WEO GGSB_NPGDP + intereses (Eurostat D41PAY; 2026-2027, Artículo IV)')
    # Lo que no tiene el FMI y no casa con su brecha: el saldo ajustado de ciclo de AMECO se retira
    FILAS.pop('cicl', None)
    ACTUALIZ.pop('AMECO', None)


ESTRUCTURA = [
    ('cuadro1.csv', 'Cuadro 1. Demanda agregada y actividad (España)',
     ['pib', 'cpriv', 'cpub', 'fbcf', 'fbcf_viv', 'fbcf_otc', 'fbcf_maq', 'fbcf_pi', 'x', 'm', 'c_int', 'c_exist', 'c_ext',
      'pib_pc', 'pib_nom', 'pot', 'brecha'],
     'FMI, WEO de octubre de 2026 (PIB, exportaciones, importaciones, PIB por habitante, PIB nominal, brecha y potencial, con previsiones 2026-2027); '
     'Eurostat (componentes de la demanda y contribuciones; nama_10_gdp, nama_10_an6); previsiones de los componentes: FMI, Artículo IV de 2026 (cuadro 1).'),
    ('cuadro2.csv', 'Cuadro 2. Oferta: valor añadido bruto real por ramas (España)',
     ['vab', 'vab_a', 'vab_be', 'vab_c', 'vab_f', 'vab_gi', 'vab_j', 'vab_mn', 'vab_oq'], 'Eurostat nama_10_a10 (CLV_PCH_PRE).'),
    ('cuadro3.csv', 'Cuadro 3. Mercado de trabajo, productividad, costes y demografía (España)',
     ['emp', 'horas', 'act', 'templeo', 'paro', 'paro_ze', 'paro_juv', 'paro_ld', 'temp', 'vac', 'prod_oc', 'prod_h', 'rem', 'clu', 'clu_ze',
      'pob', 'extr', 'dep'],
     'Eurostat: nama_10_pe, nama_10_a10_e, nama_10_gdp, nama_10_lp_ulc; lfsa_*, une_*; jvs_q_r21; migr_pop1ctz, demo_pjanind. Empleo, paro y población: FMI WEO de octubre de 2026.'),
    ('cuadro4.csv', 'Cuadro 4. Ahorro, inversión y financiación del sector privado (España)',
     ['ahorro_hog', 'rdb', 'inv_hog', 'inv_snf', 'ben_snf', 'fbc', 'ahorro_nac', 'flujo_cred', 'phog', 'psnf', 'hip', 'hip_ze', 'snf_t',
      'dhog', 'dsnf', 'viv', 'viv_r'],
     'Eurostat: nasa_10_ki (cuentas de los sectores), nasa_10_nf_tr, nama_10_gdp, tipspc10, tipspd22, tipspd30, prc_hpi_a, tipsho10. '
     'BCE: BSI (préstamos de las IFM) y MIR (tipos de las operaciones nuevas, media anual).'),
    ('cuadro5.csv', 'Cuadro 5. Precios (España y zona del euro)',
     ['ipca', 'ipca_sub', 'ipca_nrg', 'ipca_food', 'ipca_ze', 'ipca_ze_sub', 'def_pib', 'def_c', 'def_x', 'def_m'],
     'Eurostat: prc_hicp_aind (IPCA, ECOICOP ver. 1), nama_10_gdp (deflactores). IPCA general y deflactor del PIB: FMI WEO de octubre de 2026 (con previsiones).'),
    ('cuadro6.csv', 'Cuadro 6. Competitividad precio y no precio (España)',
     ['tcer_ipc', 'tcer_clu', 'cuota', 'cuota_g', 'cuota_s', 'cuota_5a', 'htec', 'id', 'id_ue', 'apert'],
     'Eurostat: ert_eff_ic_a (un aumento es una apreciación real), tipsex20, tipsex10, tipsex12 (hasta 2022), rd_e_gerdtot, nama_10_gdp.'),
    ('cuadro7.csv', 'Cuadro 7. Sector exterior (España)',
     ['cc', 'bie', 'ser', 'tur', 'rp', 'rs', 'kap', 'cnf', 'fa', 'fa_d', 'fa_p', 'fa_f', 'fa_o', 'fa_o_bde', 'fa_r', 'eo', 'piin', 'piin_nendi', 'den'],
     'Eurostat: bop_c6_a (balanza de pagos MBP6 del Banco de España, en % del PIB de nama_10_gdp), bop_gdp6_q, tipsii10. Cuenta corriente: FMI WEO de octubre de 2026; previsiones de las subcuentas y de la PIIN: FMI, Artículo IV de 2026 (cuadro 4). '
     'Cuenta financiera: variación neta de activos menos variación neta de pasivos (+ = salida neta de capital).'),
    ('cuadro8.csv', 'Cuadro 8. Política monetaria y sistema bancario',
     ['dfr', 'mro', 'eur12', 'm3', 'eurosis', 'cet1', 'cet1_ue', 'solv', 'npl', 'npl_ue', 'roe', 'roe_ue', 'roa', 'roa_ue'],
     'BCE: tipos oficiales (FM), Euríbor, M3 (BSI), estado financiero del Eurosistema (ILM) y datos bancarios consolidados (CBD2: CET1 y dudosos '
     'desde 2014; ROE y ROA de España desde 2008). Eurostat nama_10_gdp (PIB de la zona del euro).'),
    ('cuadro9.csv', 'Cuadro 9. Cuentas públicas (España)',
     ['ing', 'gas', 'int', 'saldo', 'prim', 'estr', 'estr_p', 'deuda', 'deuda_neta', 'impl', 'pibn', 'rend', 'dif'],
     'Eurostat: gov_10a_main, gov_10dd_edpt1 (notificación de octubre de 2026), irt_lt_mcby_a. Ingresos, gastos, saldos, saldo estructural, deuda y PIB nominal: FMI WEO de octubre de 2026; intereses: Eurostat (2026-2027, Artículo IV de 2026).'),
]


def ensamblar():
    for nombre, titulo, ids, nota in ESTRUCTURA:
        escribir_cuadro(nombre, titulo, [FILAS[i] for i in ids], [nota])


# ---------------------------------------------------------------- Gráficos
def graficos():
    # G1: contribuciones trimestrales
    items = ['B1GQ', 'P31_S14_S15', 'P3_S13', 'P51G', 'P52_P53', 'P6', 'P7']
    o, upd = eurostat('namq_10_gdp', since='2022-Q1', geo='ES', unit='CON_PPCH_PRE', s_adj='SCA', na_item=items)
    trims = sorted(o[('B1GQ',)])
    filas = []
    for t in trims:
        r = {k[0]: o[k].get(t) for k in o}
        filas.append([t, r['B1GQ'], r['P31_S14_S15'], r['P3_S13'], r['P51G'], r['P52_P53'], r['P6'] + r['P7']])
    escribir_serie('g01-contribuciones-trimestrales.csv', [
        'Contribuciones al crecimiento intertrimestral del PIB (pp), datos corregidos de estacionalidad y calendario.',
        'Eurostat namq_10_gdp, unit=CON_PPCH_PRE, s_adj=SCA, geo=ES; actualizado el %s. Demanda externa = P6 + P7.' % upd],
        ['trimestre', 'pib', 'cpriv', 'cpub', 'fbcf', 'existencias', 'externa'], filas)

    # G2: PIB real y PIB por habitante, España y zona del euro (2007 = 100)
    def idx(d):
        return {a: 100 * d[a] / d['2007'] for a in d}
    pib_es = es('nama_10_gdp', geo='ES', unit='CLV10_MEUR', na_item='B1GQ')
    pib_ea = es('nama_10_gdp', geo='EA20', unit='CLV10_MEUR', na_item='B1GQ')
    pob_es = es('nama_10_pe', geo='ES', unit='THS_PER', na_item='POP_NC')
    pob_ea = es('nama_10_pe', geo='EA20', unit='THS_PER', na_item='POP_NC')
    a, b = idx(pib_es), idx(pib_ea)
    c = idx({k: pib_es[k] / pob_es[k] for k in pib_es if k in pob_es})
    d = idx({k: pib_ea[k] / pob_ea[k] for k in pib_ea if k in pob_ea})
    escribir_serie('g02-pib-por-habitante.csv', [
        'PIB real y PIB real por habitante, España y zona del euro (20 países), índice 2007 = 100.',
        'Eurostat nama_10_gdp (B1GQ, CLV10_MEUR) y nama_10_pe (POP_NC), geo=ES y EA20.'],
        ['anio', 'pib_es', 'pib_ze', 'pibpc_es', 'pibpc_ze'], [[k, a[k], b[k], c[k], d[k]] for k in ANIOS])

    # G3: Beveridge España
    jv, upd = eurostat('jvs_q_r21', since='2009-Q1', geo='ES', s_adj='NSA', nace_r2_1='B-T', sizeclas='TOTAL', indic_em='JVR')
    jv = list(jv.values())[0]
    un, upd2 = eurostat('une_rt_q', since='2009-Q1', geo='ES', s_adj='SA', age='Y15-74', sex='T', unit='PC_ACT')
    un = list(un.values())[0]
    filas = []
    for anio in range(2009, 2027):
        q = [k for k in jv if k.startswith(str(anio)) and k in un]
        if q:
            filas.append([anio, sum(jv[k] for k in q) / len(q), sum(un[k] for k in q) / len(q), len(q)])
    escribir_serie('g03-beveridge.csv', [
        'Curva de Beveridge de España: medias anuales de la tasa de vacantes (JVR, B-T, todas las empresas, sin desestacionalizar) y la tasa de paro (15-74, desestacionalizada).',
        'Eurostat jvs_q_r21 (actualizado el %s) y une_rt_q (actualizado el %s). El último año solo con los trimestres disponibles (columna trimestres).' % (upd, upd2)],
        ['anio', 'vacantes', 'paro', 'trimestres'], filas)

    # G4: IPCA general y subyacente mensual, España y zona del euro
    o, upd = eurostat('prc_hicp_minr', since='2019-01', geo=['ES', 'EA'], unit='RCH_A', coicop18=['TOTAL', 'TOT_X_NRG_FOOD'])
    meses = sorted(o[('TOTAL', 'ES')]) if ('TOTAL', 'ES') in o else sorted(list(o.values())[0])
    def g(c, geo):
        for k, v in o.items():
            if c in k and geo in k:
                return v
    filas = [[mm, g('TOTAL', 'ES').get(mm), g('TOT_X_NRG_FOOD', 'ES').get(mm), g('TOTAL', 'EA').get(mm), g('TOT_X_NRG_FOOD', 'EA').get(mm)] for mm in meses]
    escribir_serie('g06-ipca-mensual.csv', [
        'IPCA, tasa de variación interanual (%), general y sin energía ni alimentos, alcohol y tabaco; España y zona del euro.',
        'Eurostat prc_hicp_minr (ECOICOP ver. 2), unit=RCH_A, coicop18=TOTAL y TOT_X_NRG_FOOD, geo=ES y EA; actualizado el %s.' % upd],
        ['mes', 'ipca_es', 'sub_es', 'ipca_ze', 'sub_ze'], filas)

    # G5: competitividad: TCER (IPC, 42) y TCER (CLU, frente a la ZE), 2007 = 100
    r1 = es('ert_eff_ic_a', geo='ES', exch_rt='REER_IC42_CPI', unit='I20')
    r2 = es('ert_eff_ic_a', geo='ES', exch_rt='REER_EA20_ULCT', unit='I20')
    x_es = es('nama_10_gdp', geo='ES', unit='CLV10_MEUR', na_item='P6')
    filas = [[k, 100 * r1[k] / r1['2007'], 100 * r2[k] / r2['2007'], 100 * x_es[k] / x_es['2007']] for k in ANIOS]
    escribir_serie('g08-competitividad.csv', [
        'Tipo de cambio efectivo real de España (un aumento es una apreciación real) y exportaciones reales, índices 2007 = 100.',
        'Eurostat ert_eff_ic_a (REER_IC42_CPI: deflactado con IPC, 42 socios; REER_EA20_ULCT: deflactado con CLU del total de la economía, '
        'frente a los 20 países de la zona del euro), rebasados a 2007 = 100 desde I20; nama_10_gdp P6 CLV10_MEUR.'],
        ['anio', 'tcer_ipc42', 'tcer_clu_ze', 'export_real'], filas)

    # G6: cuenta corriente por componentes (% PIB)
    pib = es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='B1GQ')
    def bop(item, flow='BAL'):
        v = es('bop_c6_a', geo='ES', currency='MIO_EUR', partner='WRL_REST', sector10='S1', sectpart='S1', stk_flow=flow, bop_item=item)
        return {k: 100 * v[k] / pib[k] for k in v if k in pib}
    G, S, SD, I1, I2, CA, CKA = (bop(i) for i in ['G', 'S', 'SD', 'IN1', 'IN2', 'CA', 'CKA'])
    filas = [[k, G[k], SD[k], S[k] - SD[k], I1[k] + I2[k], CA[k], CKA[k]] for k in ANIOS]
    escribir_serie('g10-cuenta-corriente.csv', [
        'Cuenta corriente de España por componentes y capacidad/necesidad de financiación (% del PIB).',
        'Eurostat bop_c6_a (MIO_EUR, BAL, sector S1) dividido por nama_10_gdp B1GQ CP_MEUR. rentas = IN1 + IN2; resto_servicios = S - SD.'],
        ['anio', 'bienes', 'turismo', 'resto_servicios', 'rentas', 'cc', 'cnf'], filas)

    # G7: PIIN y deuda externa neta (% PIB)
    piin = es('tipsii10', geo='ES', unit='PC_GDP', partner='WRL_REST')
    o, _ = eurostat('bop_gdp6_q', since=A0, geo='ES', freq='A', unit='PC_GDP', partner='WRL_REST', s_adj='NSA', stk_flow=['N_LE', 'NE_LE'], bop_item=['FA__NENDI', 'FA__FNED'])
    nendi = [v for k, v in o.items() if 'FA__NENDI' in k][0]
    fned = [v for k, v in o.items() if 'FA__FNED' in k][0]
    filas = [[k, piin.get(k), nendi.get(k), -fned[k] if k in fned else None] for k in ANIOS]
    escribir_serie('g11-piin.csv', [
        'Posición de inversión internacional neta, PIIN sin instrumentos que no generan impago (NENDI) y deuda externa neta con signo cambiado (% del PIB).',
        'Eurostat tipsii10 (PC_GDP) y bop_gdp6_q (FA__NENDI N_LE; FA__FNED NE_LE, que aquí se cambia de signo: negativo = deudor neto).'],
        ['anio', 'piin', 'piin_nendi', 'menos_deuda_ext_neta'], filas)

    # G8: exportaciones de bienes a EE. UU. y al total (Comext, mensual)
    import json, urllib.request
    def comext(partner):
        url = ('https://ec.europa.eu/eurostat/api/comext/dissemination/statistics/1.0/data/DS-045409?format=JSON&lang=EN'
               f'&reporter=ES&partner={partner}&product=TOTAL&flow=2&freq=M&indicators=VALUE_IN_EUROS&sinceTimePeriod=2022-01')
        from fuentes_api import _get
        d = json.loads(_get(url, timeout=120))
        t = d['dimension']['time']['category']['index']
        inv = {v: k for k, v in t.items()}
        return {inv[int(k)]: v for k, v in d['value'].items()}, d.get('updated')
    us, upd = comext('US')
    wr, _ = comext('WORLD')
    meses = sorted(us)
    filas = []
    for i, mm in enumerate(meses):
        if i >= 11 and all(meses[j] in wr for j in range(i - 11, i + 1)):
            su = sum(us[meses[j]] for j in range(i - 11, i + 1)) / 1e9
            sw = sum(wr[meses[j]] for j in range(i - 11, i + 1)) / 1e9
            yu = 100 * (us[mm] / us[str(int(mm[:4]) - 1) + mm[4:]] - 1) if str(int(mm[:4]) - 1) + mm[4:] in us else None
            yw = 100 * (wr[mm] / wr[str(int(mm[:4]) - 1) + mm[4:]] - 1) if str(int(mm[:4]) - 1) + mm[4:] in wr else None
            filas.append([mm, us[mm] / 1e6, wr[mm] / 1e6, su, sw, 100 * su / sw, yu, yw])
    # índice de la suma móvil de 12 meses, base media de 2024 = 100
    base_u = sum(r[3] for r in filas if r[0].startswith('2024')) / 12
    base_w = sum(r[4] for r in filas if r[0].startswith('2024')) / 12
    for r in filas:
        r += [100 * r[3] / base_u, 100 * r[4] / base_w]
    escribir_serie('g09-exportaciones-eeuu.csv', [
        'Exportaciones españolas de bienes a EE. UU. y al mundo (Comext, euros corrientes, mensual). sm12: suma móvil de 12 meses (miles de millones); '
        'idx: índice de la suma móvil, media de 2024 = 100; yoy: variación interanual del mes (%).',
        'Eurostat Comext DS-045409 (reporter=ES, partner=US / WORLD, product=TOTAL, flow=2 exportaciones, VALUE_IN_EUROS); actualizado el %s.' % upd],
        ['mes', 'eeuu_mill', 'mundo_mill', 'eeuu_sm12', 'mundo_sm12', 'cuota_eeuu_sm12', 'eeuu_yoy', 'mundo_yoy', 'eeuu_idx', 'mundo_idx'], filas)

    # G9: tipos de interés mensuales
    dfr, _ = ecb('FM.D.U2.EUR.4F.KR.DFR.LEV', '2007-01-01')
    eur12, _ = ecb('FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA', '2007-01')
    hip, _ = ecb('MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N', '2007-01')
    b10, upd = eurostat('irt_lt_mcby_m', since='2007-01', geo=['ES', 'DE'])
    b10es = [v for k, v in b10.items() if 'ES' in k][0]
    b10de = [v for k, v in b10.items() if 'DE' in k][0]
    dfr_m = {}
    for k in sorted(dfr):
        dfr_m[k[:7]] = dfr[k]   # último valor del mes
    meses = sorted(set(eur12) | set(b10es))
    filas = [[mm, dfr_m.get(mm), eur12.get(mm), hip.get(mm), b10es.get(mm), b10de.get(mm)] for mm in meses]
    escribir_serie('g12-tipos.csv', [
        'Tipos de interés (%), mensual: facilidad de depósito del BCE (último día del mes), Euríbor a 12 meses (media), coste de los préstamos nuevos '
        'a hogares para vivienda en España, rendimiento de la deuda pública a 10 años de España y Alemania (media).',
        'BCE FM.D.U2.EUR.4F.KR.DFR.LEV, FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA, MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N; Eurostat irt_lt_mcby_m (actualizado el %s).' % upd],
        ['mes', 'dfr', 'euribor12', 'hipotecas_es', 'bono10_es', 'bono10_de'], filas)

    # G10: orientación de la política fiscal: brecha y variación del saldo estructural primario
    br = {k: v for k, v in FILAS['brecha'].items() if k[:2] == '20'}
    sp = {k: float(v) for k, v in FILAS['estr_p'].items() if k[:2] == '20' and v not in ('', None)}
    filas = [[k, br[k], sp[k], sp[k] - sp[str(int(k) - 1)]] for k in TODOS if k in br and k in sp and str(int(k) - 1) in sp]
    escribir_serie('g13-orientacion-fiscal.csv', [
        'Brecha de producción (% del PIB potencial) y saldo estructural primario de las AAPP (% del PIB potencial) y su variación (pp), 2008-2027 (2026-2027, previsión).',
        'FMI, WEO de octubre de 2026: NGAP_NPGDP y GGSB_NPGDP; saldo estructural primario = GGSB_NPGDP + intereses (Eurostat gov_10a_main D41PAY; 2026-2027, Artículo IV de 2026, cuadro 2b).'],
        ['anio', 'brecha', 'saldo_estr_prim', 'var_saldo_estr_prim'], filas)

    # G11: deuda pública y diferencial i - g
    d41 = es('gov_10a_main', geo='ES', unit='MIO_EUR', sector='S13', na_item='D41PAY')
    gd = es('gov_10dd_edpt1', geo='ES', unit='MIO_EUR', sector='S13', na_item='GD')
    gdp = es('gov_10dd_edpt1', geo='ES', unit='PC_GDP', sector='S13', na_item='GD')
    pibn = tasa(es('nama_10_gdp', geo='ES', unit='CP_MEUR', na_item='B1GQ'))
    filas = []
    for k in ANIOS:
        km = str(int(k) - 1)
        i = 100 * d41[k] / gd[km]
        filas.append([k, gdp[k], i, pibn[k], i - pibn[k]])
    escribir_serie('g14-deuda-i-g.csv', [
        'Deuda pública (% del PIB), tipo de interés implícito (intereses del año / deuda del año anterior, %), crecimiento del PIB nominal (%) y diferencial i - g (pp).',
        'Eurostat gov_10dd_edpt1 (GD, MIO_EUR y PC_GDP), gov_10a_main (D41PAY, MIO_EUR), nama_10_gdp (B1GQ, CP_MEUR).'],
        ['anio', 'deuda', 'i_implicito', 'g_nominal', 'i_menos_g'], filas)

    # G12: deuda privada y precio real de la vivienda
    dh = es('tipspd22', geo='ES', unit='PC_GDP')
    ds = es('tipspd30', geo='ES', unit='PC_GDP')
    hp = es('tipsho10', geo='ES', unit='I15_A_AVG')
    filas = [[k, dh.get(k), ds.get(k), 100 * hp[k] / hp['2007'] if k in hp else None] for k in ANIOS]
    escribir_serie('g04-deuda-privada-vivienda.csv', [
        'Deuda consolidada de los hogares (con ISFLSH) y de las sociedades no financieras (% del PIB) y precio real de la vivienda (índice 2007 = 100).',
        'Eurostat tipspd22, tipspd30 (PC_GDP) y tipsho10 (precio de la vivienda deflactado, I15_A_AVG rebasado a 2007).'],
        ['anio', 'deuda_hogares', 'deuda_snf', 'vivienda_real'], filas)

    # G5: renta disponible real, consumo y tasa de ahorro de los hogares
    sr = es('nasa_10_ki', geo='ES', na_item='SRG_S14_S15', sector='S14_S15', unit='PC')
    rd = es('nasa_10_ki', geo='ES', na_item='B7G_R_HAB_GR', sector='S14_S15', unit='PC')
    cp = es('nama_10_gdp', geo='ES', unit='CLV_PCH_PRE', na_item='P31_S14_S15')
    escribir_serie('g05-ahorro-hogares.csv', [
        'Hogares (con ISFLSH): tasa de ahorro bruto (% de la renta disponible bruta), variación de la renta disponible bruta real ajustada por habitante (%) '
        'y del consumo privado en volumen (%).',
        'Eurostat nasa_10_ki (SRG_S14_S15, unit=PC; B7G_R_HAB_GR, unit=PC) y nama_10_gdp (P31_S14_S15, CLV_PCH_PRE).'],
        ['anio', 'tasa_ahorro', 'renta_real_hab', 'consumo_real'], [[k, sr.get(k), rd.get(k), cp.get(k)] for k in ANIOS])


if __name__ == '__main__':
    cuadro1(); cuadro2(); cuadro3(); cuadro4(); cuadro5(); cuadro6(); cuadro7(); filas_nuevas(); aplicar_fmi(); ensamblar(); graficos()
    with open(os.path.join(AQUI, 'actualizaciones.txt'), 'w', encoding='utf-8') as f:
        f.write(f'# Fecha de actualización de cada fuente según su API (consulta {HOY})\n')
        for k, v in sorted(ACTUALIZ.items()):
            f.write(f'{k}\t{v}\n')
    print(ACTUALIZ)
