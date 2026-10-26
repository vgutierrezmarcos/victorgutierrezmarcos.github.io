# Fuentes de los datos del examen de ejemplo de España (1D01)

Consulta de todas las series: **26/10/2026** (salvo el Brent, copiado de la guía: 23/10/2026). Todo se descarga con `descargar.py` de las API oficiales; ninguna cifra se ha tecleado a mano. Las cifras clave se comprobaron dos veces con otra fuente o con otro cálculo (`verificar.py` → `verificacion.csv`: 14 comprobaciones, todas «OK»).

## Accesos (API)

- **Eurostat**, API de difusión: `https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/<código>?<filtros>` (navegador: `https://ec.europa.eu/eurostat/databrowser/view/<código>/default/table`). Comercio de bienes: API de Comext, `https://ec.europa.eu/eurostat/api/comext/dissemination/statistics/1.0/data/DS-045409`.
- **Comisión Europea, AMECO** (previsiones de primavera de 2026, publicadas el 21/05/2026; versión de 03/06/2026; la siguiente, de otoño, el 17/11/2026): `https://ec.europa.eu/economy_finance/ameco/wq/series?fullVariable=<código>&countries=ESP`.
- **Banco Central Europeo**, portal de datos: `https://data-api.ecb.europa.eu/service/data/<flujo>/<clave>` (navegador: `https://data.ecb.europa.eu/data/datasets/<flujo>`).
- **EIA** (Brent, serie RBRTE), vía la guía 1D01 (`fuentes/1D01/datos/brent.csv`); comprobado con FRED (MCOILBRENTEU) el 26/10/2026.

## Última actualización de cada conjunto de datos (según su API)

| Conjunto | Actualizado |
|---|---|
| `AMECO` | previsiones de primavera de 2026 (21/05/2026; versión de 03/06/2026) |
| `BCE` | 2026-10-26 |
| `bop_c6_a` | 2026-10-02 |
| `bop_gdp6_q` | 2026-10-02 |
| `demo_pjanbroad` | 2026-09-25 |
| `demo_pjanind` | 2026-09-25 |
| `ert_eff_ic_a` | 2026-10-14 |
| `gov_10a_main` | 2026-10-21 |
| `gov_10dd_edpt1` | 2026-10-21 |
| `irt_lt_mcby_a` | 2026-02-25 |
| `jvs_q_r21` | 2026-09-15 |
| `lfsa_argan` | 2026-09-10 |
| `lfsa_ergan` | 2026-09-10 |
| `lfsa_etpgan` | 2026-09-10 |
| `lfsa_urgan` | 2026-09-10 |
| `migr_pop1ctz` | 2026-09-25 |
| `nama_10_a10` | 2026-10-22 |
| `nama_10_a10_e` | 2026-10-21 |
| `nama_10_an6` | 2026-10-22 |
| `nama_10_gdp` | 2026-10-22 |
| `nama_10_lp_ulc` | 2026-10-22 |
| `nama_10_pe` | 2026-10-21 |
| `prc_hicp_aind` | 2026-02-06 |
| `prc_hpi_a` | 2026-10-01 |
| `tipsex20` | 2026-07-15 |
| `tipsho10` | 2026-10-01 |
| `tipsii10` | 2026-10-02 |
| `tipspd22` | 2026-10-24 |
| `tipspd30` | 2026-10-24 |
| `une_ltu_a` | 2026-09-10 |
| `une_rt_a` | 2026-09-10 |

## Cuadros: serie a serie

Columnas: identificador de la fila en `cuadroN.csv`, indicador, código y filtros, último dato.

### Cuadro 1. Demanda agregada y actividad (España) (`cuadro1.csv`)

- Eurostat (nama_10_gdp, nama_10_an6, nama_10_pe), actualizados el 2026-10-22T23:00:00+0200; contabilidad nacional del INE (SEC 2010).
- Previsiones 2026-2027 y PIB potencial/brecha: Comisión Europea, AMECO (previsiones de primavera de 2026). La serie de AMECO es anterior a la última revisión de la contabilidad nacional (en 2025, PIB +2,8 % en AMECO frente a +2,6 % en Eurostat).
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `pib` | PIB | Eurostat nama_10_gdp B1GQ CLV_PCH_PRE; prev. AMECO OVGD | 2025 (+ previsión 2026-2027) |
| `cpriv` | Consumo privado (hogares e ISFLSH) | nama_10_gdp P31_S14_S15; prev. AMECO OCPH | 2025 (+ previsión 2026-2027) |
| `cpub` | Consumo público | nama_10_gdp P3_S13; prev. AMECO OCTG | 2025 (+ previsión 2026-2027) |
| `fbcf` | Formación bruta de capital fijo | nama_10_gdp P51G; prev. AMECO OIGT | 2025 (+ previsión 2026-2027) |
| `fbcf_viv` | Viviendas | nama_10_an6 N111G CLV_PCH_PRE | 2025 |
| `fbcf_otc` | Otras construcciones | nama_10_an6 N112G | 2025 |
| `fbcf_maq` | Maquinaria, bienes de equipo y armamento | nama_10_an6 N11MG | 2025 |
| `fbcf_pi` | Productos de la propiedad intelectual | nama_10_an6 N117G | 2025 |
| `x` | Exportaciones de bienes y servicios | nama_10_gdp P6; prev. AMECO OXGS | 2025 (+ previsión 2026-2027) |
| `m` | Importaciones de bienes y servicios | nama_10_gdp P7; prev. AMECO OMGS | 2025 (+ previsión 2026-2027) |
| `c_int` | Demanda nacional (contribución, pp) | nama_10_gdp CON_PPCH_PRE: P3+P51G+P52_P53 | 2025 |
| `c_exist` | de la cual, variación de existencias (pp) | nama_10_gdp CON_PPCH_PRE P52_P53 | 2025 |
| `c_ext` | Demanda externa neta (contribución, pp) | nama_10_gdp CON_PPCH_PRE: P6+P7 | 2025 |
| `pib_pc` | PIB real por habitante | nama_10_gdp B1GQ CLV10_MEUR / nama_10_pe POP_NC | 2025 |
| `pib_nom` | PIB nominal (miles de millones de euros) | nama_10_gdp B1GQ CP_MEUR; prev. AMECO UVGD | 2025 (+ previsión 2026-2027) |
| `pot` | PIB potencial | AMECO OVGDP (Comisión, función de producción) | 2025 (+ previsión 2026-2027) |
| `brecha` | Brecha de producción (% del PIB potencial) | AMECO AVGDGP | 2025 (+ previsión 2026-2027) |

### Cuadro 2. Oferta: valor añadido bruto real por ramas (España) (`cuadro2.csv`)

- Eurostat nama_10_a10 (CLV_PCH_PRE), actualizado el 2026-10-22T23:00:00+0200.
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `vab` | Valor añadido bruto total | nama_10_a10 B1G TOTAL | 2025 |
| `vab_a` | Agricultura, ganadería, silvicultura y pesca | nama_10_a10 B1G A | 2025 |
| `vab_be` | Industria | nama_10_a10 B1G B-E | 2025 |
| `vab_c` | de la cual, manufacturas | nama_10_a10 B1G C | 2025 |
| `vab_f` | Construcción | nama_10_a10 B1G F | 2025 |
| `vab_gi` | Comercio, transporte y hostelería | nama_10_a10 B1G G-I | 2025 |
| `vab_j` | Información y comunicaciones | nama_10_a10 B1G J | 2025 |
| `vab_mn` | Actividades profesionales y administrativas | nama_10_a10 B1G M_N | 2025 |
| `vab_oq` | Administración pública, educación y sanidad | nama_10_a10 B1G O-Q | 2025 |

### Cuadro 3. Mercado de trabajo, costes y demografía (España) (`cuadro3.csv`)

- Eurostat: nama_10_pe, nama_10_a10_e, nama_10_gdp, nama_10_lp_ulc (contabilidad nacional); lfsa_* y une_* (encuesta de población activa); jvs_q_r21 (vacantes, NACE Rev. 2.1); migr_pop1ctz y demo_pjanind (población a 1 de enero). Previsiones: AMECO.
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `emp` | Empleo (personas, contabilidad nacional) | nama_10_pe EMP_DC; prev. AMECO NETD | 2025 (+ previsión 2026-2027) |
| `horas` | Horas trabajadas | nama_10_a10_e THS_HW TOTAL | 2025 |
| `act` | Tasa de actividad (15-64 años, % de la población) | lfsa_argan Y15-64 | 2025 |
| `templeo` | Tasa de empleo (15-64 años, % de la población) | lfsa_ergan Y15-64 | 2025 |
| `paro` | Tasa de paro (15-74 años, % de los activos) | lfsa_urgan Y15-74; prev. AMECO ZUTN | 2025 (+ previsión 2026-2027) |
| `paro_ze` | Tasa de paro de la zona del euro (15-74 años) | une_rt_a EA20 Y15-74 | 2025 |
| `paro_juv` | Tasa de paro juvenil (15-24 años) | lfsa_urgan Y15-24 | 2025 |
| `paro_ld` | Paro de larga duración (% de los activos) | une_ltu_a LTU Y15-74 PC_ACT | 2025 |
| `temp` | Asalariados con contrato temporal (% del total, 15-64) | lfsa_etpgan Y15-64 | 2025 |
| `vac` | Tasa de vacantes (% de los puestos de trabajo) | jvs_q_r21 JVR B-T NSA, media de 4 trimestres | 2025 |
| `prod_oc` | Productividad por ocupado | nama_10_lp_ulc RLPR_PER | 2025 |
| `prod_h` | Productividad por hora trabajada | nama_10_lp_ulc RLPR_HW | 2025 |
| `rem` | Remuneración por asalariado | nama_10_gdp D1 CP_MEUR / nama_10_pe SAL_DC | 2025 |
| `clu` | Costes laborales unitarios nominales | nama_10_lp_ulc NULC_PER | 2025 |
| `clu_ze` | Costes laborales unitarios nominales, zona del euro | nama_10_lp_ulc NULC_PER EA20 | 2025 |
| `pob` | Población | nama_10_pe POP_NC | 2025 |
| `extr` | Población de nacionalidad extranjera (% del total, 1 de enero) | migr_pop1ctz TOTAL-NAT | 2025 |
| `dep` | Tasa de dependencia de los mayores (65+ sobre 15-64, %) | demo_pjanind OLDDEP1 | 2025 |

### Cuadro 4. Precios (España y zona del euro) (`cuadro4.csv`)

- Eurostat: prc_hicp_aind (IPCA, ECOICOP ver. 1, medias anuales; actualizado el 2026-02-06T23:00:00+0100), nama_10_gdp (deflactores), prc_hpi_a y tipsho10 (precios de la vivienda). Previsión del IPCA: AMECO ZCPIH.
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `ipca` | IPCA: índice general | prc_hicp_aind CP00 RCH_A_AVG; prev. AMECO ZCPIH | 2025 (+ previsión 2026-2027) |
| `ipca_sub` | IPCA sin energía ni alimentos (subyacente) | prc_hicp_aind TOT_X_NRG_FOOD | 2025 |
| `ipca_nrg` | IPCA: energía | prc_hicp_aind NRG | 2025 |
| `ipca_food` | IPCA: alimentos, bebidas y tabaco | prc_hicp_aind FOOD | 2025 |
| `ipca_ze` | IPCA de la zona del euro: índice general | prc_hicp_aind CP00 EA | 2025 |
| `ipca_ze_sub` | IPCA de la zona del euro: subyacente | prc_hicp_aind TOT_X_NRG_FOOD EA | 2025 |
| `def_pib` | Deflactor del PIB | nama_10_gdp B1GQ PD_PCH_PRE_EUR | 2025 |
| `def_c` | Deflactor del consumo privado | nama_10_gdp P31_S14_S15 PD_PCH_PRE_EUR | 2025 |
| `def_x` | Deflactor de las exportaciones | nama_10_gdp P6 PD_PCH_PRE_EUR | 2025 |
| `def_m` | Deflactor de las importaciones | nama_10_gdp P7 PD_PCH_PRE_EUR | 2025 |
| `viv` | Precio de la vivienda (nominal) | prc_hpi_a TOTAL RCH_A_AVG | 2025 |
| `viv_r` | Precio de la vivienda deflactado (real) | tipsho10 RCH_A_AVG | 2025 |

### Cuadro 5. Sector exterior (España) (`cuadro5.csv`)

- Eurostat: bop_c6_a (balanza de pagos MBP6, millones de euros; actualizado el 2026-10-02T11:00:00+0200; aquí en % del PIB nominal de nama_10_gdp), bop_gdp6_q, tipsii10 (cuadro de indicadores del procedimiento de desequilibrios), ert_eff_ic_a (un aumento del índice es una apreciación real), tipsex20, nama_10_gdp. Elaboradas por el Banco de España.
- Cuenta financiera con el criterio del MBP6: saldo neto = variación neta de activos - variación neta de pasivos (+ = salida neta de capital).
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `cc` | Cuenta corriente | bop_c6_a CA BAL; prev. AMECO UBCA (contabilidad nacional) | 2025 (+ previsión 2026-2027) |
| `bie` | Bienes | bop_c6_a G BAL | 2025 |
| `ser` | Servicios | bop_c6_a S BAL | 2025 |
| `tur` | de los cuales, viajes (turismo) | bop_c6_a SD BAL | 2025 |
| `rp` | Rentas primarias | bop_c6_a IN1 BAL | 2025 |
| `rs` | Rentas secundarias | bop_c6_a IN2 BAL | 2025 |
| `kap` | Cuenta de capital | bop_c6_a KA BAL | 2025 |
| `cnf` | Capacidad (+) o necesidad (-) de financiación | bop_c6_a CKA BAL | 2025 |
| `fa` | Cuenta financiera, saldo neto (+ = salida neta) | bop_c6_a FA NET | 2025 |
| `fa_d` | Inversión directa | bop_c6_a FA__D__F NET | 2025 |
| `fa_p` | Inversión de cartera | bop_c6_a FA__P__F NET | 2025 |
| `fa_f` | Derivados financieros | bop_c6_a FA__F__F7 NET | 2025 |
| `fa_o` | Otra inversión | bop_c6_a FA__O__F NET | 2025 |
| `fa_o_bde` | de la cual, Banco de España | bop_c6_a FA__O__F NET sector S121 | 2025 |
| `fa_r` | Activos de reserva | bop_c6_a FA__R__F ASS sector S121 | 2025 |
| `eo` | Errores y omisiones | bop_c6_a EO NET | 2025 |
| `piin` | Posición de inversión internacional neta | tipsii10 PC_GDP | 2025 |
| `piin_nendi` | PIIN sin instrumentos que no generan impago | bop_gdp6_q FA__NENDI N_LE | 2025 |
| `den` | Deuda externa neta | bop_gdp6_q FA__FNED NE_LE | 2025 |
| `tcer_ipc` | Tipo de cambio efectivo real, IPC, 42 socios (2020 = 100) | ert_eff_ic_a REER_IC42_CPI I20 | 2025 |
| `tcer_clu` | Tipo de cambio efectivo real, CLU, frente a la zona del euro (2020 = 100) | ert_eff_ic_a REER_EA20_ULCT I20 | 2025 |
| `cuota` | Cuota en las exportaciones mundiales de bienes y servicios | tipsex20 GS | 2025 |
| `apert` | Grado de apertura ((X + M) / PIB) | nama_10_gdp P6+P7 / B1GQ CP_MEUR | 2025 |

### Cuadro 6. Cuentas públicas (España) (`cuadro6.csv`)

- Eurostat: gov_10a_main y gov_10dd_edpt1 (notificación del procedimiento de déficit excesivo de octubre de 2026; actualizados el 2026-10-21T11:00:00+0200), irt_lt_mcby_a (rendimiento de convergencia). Saldos ajustados: Comisión Europea, AMECO (primavera de 2026).
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `ing` | Ingresos | gov_10a_main TR | 2025 |
| `gas` | Gastos | gov_10a_main TE; prev. AMECO UUTGE | 2025 (+ previsión 2026-2027) |
| `int` | de los cuales, intereses | gov_10a_main D41PAY; prev. AMECO UYIGE | 2025 (+ previsión 2026-2027) |
| `saldo` | Saldo (capacidad o necesidad de financiación) | gov_10a_main B9; prev. AMECO UBLGE | 2025 (+ previsión 2026-2027) |
| `prim` | Saldo primario | B9 + D41PAY; prev. AMECO UBLGE + UYIGE | 2025 (+ previsión 2026-2027) |
| `cicl` | Saldo ajustado de ciclo | AMECO UBLGAP | 2025 (+ previsión 2026-2027) |
| `estr` | Saldo estructural | AMECO UBLGAPS | 2025 (+ previsión 2026-2027) |
| `estr_p` | Saldo estructural primario | AMECO UBLGBPS | 2025 (+ previsión 2026-2027) |
| `deuda` | Deuda pública (definición del PDE) | gov_10dd_edpt1 GD; prev. AMECO UDGG | 2025 (+ previsión 2026-2027) |
| `impl` | Tipo de interés implícito de la deuda (intereses / deuda del año anterior) | D41PAY MIO_EUR / GD MIO_EUR (t-1) | 2025 |
| `pibn` | PIB nominal | nama_10_gdp B1GQ CP_MEUR; prev. AMECO UVGD | 2025 (+ previsión 2026-2027) |
| `rend` | Rendimiento de la deuda pública a 10 años (media anual) | irt_lt_mcby_a MCBY ES | 2025 |
| `dif` | Diferencial frente al bono alemán a 10 años (pb) | irt_lt_mcby_a ES - DE | 2025 |

### Cuadro 7. Política monetaria, crédito y sistema bancario (`cuadro7.csv`)

- BCE, portal de datos (data-api.ecb.europa.eu): tipos oficiales (FM), tipos de interés de las IFM (MIR), balance de las IFM (BSI) y datos bancarios consolidados (CBD2, grupos bancarios nacionales y bancos independientes; datos de 2014 en adelante para CET1 y dudosos; ROE desde 2008 en España). Eurostat tipspd22 y tipspd30 (cuadro de indicadores del procedimiento de desequilibrios).
- Consulta: 2026-10-26. Valores sin redondear salvo los que la fuente da redondeados.

| id | Indicador | Fuente y código | Último dato |
|---|---|---|---|
| `dfr` | Tipo de la facilidad de depósito del BCE (fin de año) | BCE FM.D.U2.EUR.4F.KR.DFR.LEV | 2025 |
| `mro` | Tipo de las operaciones principales de financiación (fin de año) | BCE FM.D.U2.EUR.4F.KR.MRR_RT.LEV | 2025 |
| `eur12` | Euríbor a 12 meses (media anual) | BCE FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA | 2025 |
| `m3` | M3 de la zona del euro (variación interanual en diciembre) | BCE BSI.M.U2.Y.V.M30.X.I.U2.2300.Z01.A | 2025 |
| `hip` | Tipo de los préstamos nuevos a hogares para vivienda (media anual) | BCE MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N | 2025 |
| `hip_ze` | Ídem, zona del euro | BCE MIR.M.U2.B.A2C.AM.R.A.2250.EUR.N | 2025 |
| `snf_t` | Tipo de los préstamos nuevos a sociedades no financieras (media anual) | BCE MIR.M.ES.B.A2A.A.R.A.2240.EUR.N | 2025 |
| `phog` | Préstamos bancarios a hogares (variación interanual en diciembre) | BCE BSI.M.ES.N.A.A20.A.I.U2.2250.Z01.A | 2025 |
| `psnf` | Préstamos bancarios a sociedades no financieras (variación interanual en diciembre) | BCE BSI.M.ES.N.A.A20.A.I.U2.2240.Z01.A | 2025 |
| `dhog` | Deuda de los hogares (consolidada) | Eurostat tipspd22 | 2025 |
| `dsnf` | Deuda de las sociedades no financieras (consolidada) | Eurostat tipspd30 | 2025 |
| `cet1` | Bancos: capital ordinario de nivel 1 (CET1, % de los APR) | BCE CBD2 I4008 ES | 2025 |
| `cet1_ue` | Ídem, media de la UE | BCE CBD2 I4008 B0 | 2025 |
| `solv` | Bancos: ratio de capital total (% de los APR) | BCE CBD2 I4001 ES | 2025 |
| `npl` | Bancos: préstamos dudosos (% de los préstamos brutos) | BCE CBD2 I3632 (FINREP) ES | 2025 |
| `npl_ue` | Ídem, media de la UE | BCE CBD2 I3632 (FINREP) B0 | 2025 |
| `roe` | Bancos: rentabilidad sobre recursos propios (ROE) | BCE CBD2 I2003 ES | 2025 |
| `roe_ue` | Ídem, media de la UE | BCE CBD2 I2003 B0 | 2025 |

### Cuadro 2 bis (`cuadro2b-descomposicion.csv`)

- Cuadro 2 (bis). Descomposición del crecimiento del PIB (tasas medias anuales logarítmicas, en %).
- Identidades: PIB por persona en edad de trabajar = tasa de ocupación + horas por ocupado + PIB por hora (filas 4+5+6 = fila 9); PIB = población + peso de la población en edad de trabajar + filas 4, 5 y 6 (2+3+4+5+6 = 1).
- Eurostat: nama_10_gdp (B1GQ, CLV10_MEUR), nama_10_pe (POP_NC, EMP_DC; personas, contabilidad nacional), nama_10_a10_e (THS_HW, horas totales), demo_pjanbroad (población de 15-64 años a 1 de enero; media de 1 de enero de t y t+1).
- Consulta: 2026-10-26.

## Gráficos

| Gráfico | CSV | Fuente, códigos y último dato |
|---|---|---|
| 1 | `g01-contribuciones-trimestrales.csv` | Contribuciones al crecimiento intertrimestral del PIB (pp), datos corregidos de estacionalidad y calendario. Eurostat namq_10_gdp, unit=CON_PPCH_PRE, s_adj=SCA, geo=ES; actualizado el 2026-10-22T23:00:00+0200. Demanda externa = P6 + P7. Consulta: 2026-10-26. Último dato: 2026-Q2. |
| 2 | `g02-pib-por-habitante.csv` | PIB real y PIB real por habitante, España y zona del euro (20 países), índice 2007 = 100. Eurostat nama_10_gdp (B1GQ, CLV10_MEUR) y nama_10_pe (POP_NC), geo=ES y EA20. Consulta: 2026-10-26. Último dato: 2025. |
| 3 | `g03-beveridge.csv` | Curva de Beveridge de España: medias anuales de la tasa de vacantes (JVR, B-T, todas las empresas, sin desestacionalizar) y la tasa de paro (15-74, desestacionalizada). Eurostat jvs_q_r21 (actualizado el 2026-09-15T11:00:00+0200) y une_rt_q (actualizado el 2026-09-10T23:00:00+0200). El último año solo con los trimestres disponibles (columna trimestres). Consulta: 2026-10-26. Último dato: 2026. |
| 4 | `g04-ipca-mensual.csv` | IPCA, tasa de variación interanual (%), general y sin energía ni alimentos, alcohol y tabaco; España y zona del euro. Eurostat prc_hicp_minr (ECOICOP ver. 2), unit=RCH_A, coicop18=TOTAL y TOT_X_NRG_FOOD, geo=ES y EA; actualizado el 2026-10-16T23:00:00+0200. Consulta: 2026-10-26. Último dato: 2026-09. |
| 5 | `g05-brent.csv` | Gráfico 5. Precio del petróleo Brent (media mensual del precio al contado, FOB Europa): dólares y euros por barril, enero 2005-septiembre 2026. Fuente: U.S. Energy Information Administration (EIA), serie RBRTE, https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=PET&s=RBRTE&f=M (publicada el 21/10/2026; copia en FRED, serie MCOILBRENTEU, https://fred.stlouisfed.org/series/MCOILBRENTEU); conversión a euros con el tipo de cambio de referencia del BCE, media mensual (EXR.M.USD.EUR.SP00.A, https://data.ecb.europa.eu/data/datasets/EXR). Consulta: 23/10/2026. Copia de oposicion/temario/fuentes/1D01/datos/brent.csv (guía 1D01; consulta 23/10/2026); se usa desde 2019-01. Último dato: 2026-09. |
| 6 | `g06-cuenta-corriente.csv` | Cuenta corriente de España por componentes y capacidad/necesidad de financiación (% del PIB). Eurostat bop_c6_a (MIO_EUR, BAL, sector S1) dividido por nama_10_gdp B1GQ CP_MEUR. rentas = IN1 + IN2; resto_servicios = S - SD. Consulta: 2026-10-26. Último dato: 2025. |
| 7 | `g07-piin.csv` | Posición de inversión internacional neta, PIIN sin instrumentos que no generan impago (NENDI) y deuda externa neta con signo cambiado (% del PIB). Eurostat tipsii10 (PC_GDP) y bop_gdp6_q (FA__NENDI N_LE; FA__FNED NE_LE, que aquí se cambia de signo: negativo = deudor neto). Consulta: 2026-10-26. Último dato: 2025. |
| 8 | `g08-competitividad.csv` | Tipo de cambio efectivo real de España (un aumento es una apreciación real) y exportaciones reales, índices 2007 = 100. Eurostat ert_eff_ic_a (REER_IC42_CPI: deflactado con IPC, 42 socios; REER_EA20_ULCT: deflactado con CLU del total de la economía, frente a los 20 países de la zona del euro), rebasados a 2007 = 100 desde I20; nama_10_gdp P6 CLV10_MEUR. Consulta: 2026-10-26. Último dato: 2025. |
| 9 | `g09-exportaciones-eeuu.csv` | Exportaciones españolas de bienes a EE. UU. y al mundo (Comext, euros corrientes, mensual). sm12: suma móvil de 12 meses (miles de millones); idx: índice de la suma móvil, media de 2024 = 100; yoy: variación interanual del mes (%). Eurostat Comext DS-045409 (reporter=ES, partner=US / WORLD, product=TOTAL, flow=2 exportaciones, VALUE_IN_EUROS); actualizado el 2026-10-16T11:00:00+0200. Consulta: 2026-10-26. Último dato: 2026-08. |
| 10 | `g10-orientacion-fiscal.csv` | Brecha de producción (% del PIB potencial) y saldo estructural primario de las AAPP (% del PIB potencial) y su variación (pp), 2007-2027 (2026-2027, previsión). Comisión Europea, AMECO: AVGDGP, UBLGBPS (previsiones de primavera de 2026). Consulta: 2026-10-26. Último dato: 2027. |
| 11 | `g11-deuda-i-g.csv` | Deuda pública (% del PIB), tipo de interés implícito (intereses del año / deuda del año anterior, %), crecimiento del PIB nominal (%) y diferencial i - g (pp). Eurostat gov_10dd_edpt1 (GD, MIO_EUR y PC_GDP), gov_10a_main (D41PAY, MIO_EUR), nama_10_gdp (B1GQ, CP_MEUR). Consulta: 2026-10-26. Último dato: 2025. |
| 12 | `g12-tipos.csv` | Tipos de interés (%), mensual: facilidad de depósito del BCE (último día del mes), Euríbor a 12 meses (media), coste de los préstamos nuevos a hogares para vivienda en España, rendimiento de la deuda pública a 10 años de España y Alemania (media). BCE FM.D.U2.EUR.4F.KR.DFR.LEV, FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA, MIR.M.ES.B.A2C.AM.R.A.2250.EUR.N; Eurostat irt_lt_mcby_m (actualizado el 2026-10-13T11:00:00+0200). Consulta: 2026-10-26. Último dato: 2026-09. |
| — | `extra-deuda-privada-vivienda.csv` | Deuda consolidada de los hogares (con ISFLSH) y de las sociedades no financieras (% del PIB) y precio real de la vivienda (índice 2007 = 100). Eurostat tipspd22, tipspd30 (PC_GDP) y tipsho10 (precio de la vivienda deflactado, I15_A_AVG rebasado a 2007). Consulta: 2026-10-26. Último dato: 2025. |

## Lo que no se encontró o se cambió

- **Saldo estructural 2007-2009**: AMECO solo lo da desde 2010 para España (celdas en blanco).
- **CET1 y préstamos dudosos antes de 2014**: los datos bancarios consolidados del BCE (CBD2) empiezan en 2014 con la definición de Basilea III y FINREP; para 2008-2013 habría que acudir al Boletín Estadístico del Banco de España (otra definición: dudosos del crédito a otros sectores residentes), que no se ha descargado ni se mezcla. ROE de España desde 2008.
- **Tasa de vacantes 2007-2009**: la serie de Eurostat (jvs_q_r21) salta de 0,7 % (4T2009) a 1,4 % (1T2010) sin marca de ruptura; el cuadro la da desde 2010 y el gráfico de Beveridge también.
- **Paro de la zona del euro y paro de larga duración 2007-2008**: une_rt_a y une_ltu_a empiezan en 2009 (celdas en blanco).
- **Previsiones 2026-2027**: solo en las filas que AMECO publica (PIB y componentes, empleo, paro, IPCA, cuenta corriente, saldos, deuda, gastos, intereses, PIB nominal y potencial). No hay previsión de contribuciones ni de la balanza por componentes. Las previsiones del Banco de España de septiembre de 2026 no se descargaron (la web no dio un enlace legible por programa): se usa una sola fuente, la Comisión.
- **AMECO frente a Eurostat**: AMECO (mayo de 2026) es anterior a la última revisión del INE: PIB de 2025 +2,8 % en AMECO y +2,6 % en Eurostat; deuda de 2025, 100,7 % frente a 100,5 %. Los saldos ajustados de ciclo y estructurales son de AMECO para toda la serie (coherentes entre sí).
- **IPCA anual**: prc_hicp_aind (ECOICOP ver. 1, hasta 2025); el mensual de 2026 sale de prc_hicp_minr (ECOICOP ver. 2). La media anual de 2025 coincide (2,7 %).
- **Calificación crediticia, vida media de la deuda y tenedores**: no hay API oficial (las agencias no son fuente oficial; el Tesoro publica la vida media en PDF). No se incluyen.
- **Exportaciones a EE. UU. (sql_comex)**: la base interna de DataComex no estaba accesible desde la herramienta (tabla no encontrada); se usó Comext de Eurostat.
