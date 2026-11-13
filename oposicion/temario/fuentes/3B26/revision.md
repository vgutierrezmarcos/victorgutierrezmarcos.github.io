# Revisión del 3.B.26: Crisis financieras y pánicos bancarios; especial referencia a la crisis financiera internacional iniciada en 2007-2008. Gestión de riesgos de las instituciones financieras

12/11/2026. **Tema sin original de Víctor** (`inventario.json`: `sin_original: true`): escrito desde cero en 2 partes (preámbulo, esquema, introducción y I; II, III, conclusión y anexos). Estructura de partida: el tema B.26 de Miquel Tebar Barbero (`_trabajo/estructura.md`), con todo redactado de nuevo. Ficheros: `3B26.tex`, `3B26.bib` (114 entradas, todas citadas), `seo.json`, `datos-actualizables.yaml` (6 datos), `_trabajo/graficos-pedidos.json` (6 gráficos, ya compilados por la fase de gráficos). Comprobación de n-gramas de 8 palabras contra Tebar, los 4 ficheros de Cerezal y los 2 de Luis de Fuentes elegidos por número: en la parte 2, 0 coincidencias; en la 1, solo el título oficial y una frase genérica («si el tipo de interés es menor que»). Nada calcado.

## 1. Resumen

- 3 apartados con los minutos de coherencia (K4-K6): **I. Crisis financieras: qué son y por qué ocurren** (7′), **II. Pánicos bancarios y la crisis de 2007-2008** (12′30″) y **III. Gestión de riesgos de las instituciones financieras** (7′), con introducción de 2′30″ y conclusión de 1′ (30′; `construir-tema.py` y `verificar-tema.py` lo confirman). 28 páginas de tema, 3 págs. de anexos (A-D) y 7 de bibliografía.
- **Diamond y Dybvig (1983) en desarrollo completo** (el 3.B.26 es su tema de referencia, D042), con la notación y el gráfico del 3.A.10 ampliados con el contrato de depósito y el pánico; extensiones de Gorton, Allen y Gale, Chari y Jagannathan, Goldstein y Pauzner, Calomiris y Kahn, y la red de seguridad (suspensión, garantía, Bagehot) con su riesgo moral.
- **2007-2008 contada con las 5 fases de Kindleberger** como pánico mayorista (Gorton y Metrick, 2012; Bernanke, 2018) y el **círculo vicioso banca-soberano** con a)-e) (referencia del 3.er ejercicio, D136) y el gráfico del 3.B.16.
- **Gestión de riesgos hecha de nuevo** (en Tebar, 1.100 palabras): mapa de riesgos y marco de gestión, VaR como cuantil (función clave), *expected shortfall*, pruebas de resistencia, PE = PD × LGD × EAD, Merton (1974) con la notación del 3.B.25, brecha de duración y Silicon Valley Bank.
- 2 funciones clave (`eq:dd-optimo`, `eq:var`), 4 gráficos imprescindibles (`fig:balance-banco`, `fig:diamond-dybvig`, `fig:circulo-vicioso`, `fig:var`) y 2 de datos de apoyo (`fig:vivienda-eeuu`, `fig:diferenciales-soberanos`).

## 2. Errores corregidos

No hay original, así que no hay errores del tema que corregir. Lo que sigue son los errores de las referencias que **no se han heredado** y los de las propuestas que se han quitado al integrar.

| Dónde | Decía | Dice ahora |
|---|---|---|
| Tebar 3.3 | CDO = «collateralized-mortgage-obligation» | *collateralized debt obligation*, obligación de deuda garantizada (II.4 a), como el 3.B.25 |
| Tebar 4.3 | «Calomiris & Charles, 1991» | Calomiris y Kahn (1991), *AER* (II.2) |
| Tebar 4.1 | Visión del ciclo de «Kaufman 1988» | Gorton (1988), *OEP* (II.2); Kaufman (1988, *Cato Journal*) existe, pero trata de los costes y del diseño del seguro: no se cita |
| Tebar 3.1 | «Claessens y Köse, 2013» | Claessens y Kose (2013), IMF WP 13/28 (I.1) |
| Tebar 3.2 | Deflación de Fisher por $MV=PY$; «Minsky 1982 y Bernanke 1983» como autores del mecanismo | La cadena de Fisher (1933); Bernanke (1983) como extensión; Minsky aparte (I.2-I.3) |
| Tebar 4.3 | Seguro de depósitos = «3.er pilar de la Unión Bancaria, 100.000 €» | 100.000 € en fondos nacionales (Directiva 2014/49/UE, reformada por la 2026/804); el sistema europeo (EDIS), propuesto en 2015, **sin aprobar** (II.3 b) |
| Tebar 3.1 y 5.1 | «El acelerador explica el 50 % de la caída de la actividad (Gertler, 2007)» | Gertler, Gilchrist y Natalucci (2007): «cerca de la mitad» **en Corea, 1997-1998**, con un modelo calibrado (I.3) |
| Tebar 3.1 | Queraltó (2020) «sobre el mayor impacto de las crisis bancarias» | Recuperaciones lentas por la caída de la financiación de la innovación (I.3) |
| Tebar 2 | «40 % bancarios, 50 % NBFI, 10 % públicos», sin fuente | FSB (2025): 51 % no bancarios y 38 % bancos a finales de 2024 (conclusión) |
| Tebar 3.3 | «Aumento de los tipos de la Fed durante 2006» | Del 1 % (mediados de 2004) al 5,25 % (junio de 2006) en 17 pasos (II.4 a; anexo B) |
| Tebar 4.2 | Utilidad logarítmica, θ para el tipo, liquidación a 1 | CRRA con aversión relativa > 1 (con la logarítmica, $c_1^*=1$ y el banco no mejora el mercado), π, $L\le1$ (II.1; anexo A) |
| Tebar 5.2 | El VaR «nos dice la probabilidad de la pérdida máxima» | Un cuantil: la pérdida que solo se supera con probabilidad $1-\alpha$ (`eq:var`) |
| Tebar 5.3 | En Merton la PD «depende positivamente del tiempo» | No es general: se dicen el apalancamiento y la volatilidad (III.3) |
| Tebar, introducción | SVB «sufrió una retirada masiva el 10 de marzo» | La retirada fue el 9 (más de 40.000 millones); el cierre, el 10 |
| Tebar 4.1 | Chari y Jagannathan como «posición intermedia» | Modelo de pánicos por información, con Jacklin y Bhattacharya (1988) (II.2) |
| Tebar 3.3 | «Blanchard (2010)» | Blanchard, Dell'Ariccia y Mauro (2010), IMF SPN/10/03 (II.4 e) |
| Cerezal 18B | 7 fases de Kindleberger tomadas de un artículo de prensa | Las 5 de Kindleberger (1978), con las palabras del 3.A.42 (I.2) |
| Cerezal 18B | *This Time Is Different* «en 2011» | 2009 |
| Propuesta C2 (introducción) | SVB, «el 16.º banco de Estados Unidos» | Quitado: no está en el informe de la Reserva Federal (leído hoy en PDF). El «cerca del 85 % de sus depósitos» **sí está** («roughly 85 percent of the bank's deposit base») y se queda |
| Propuesta C9 (II.3) | La Reserva Federal abrió un programa que aceptaba los bonos «por su valor nominal» (`FED2023Joint`) | «Abrió una línea de liquidez para el resto de los bancos», con el comunicado conjunto del 12/3/2023 (`TreasuryFedFDIC2023Joint`), que es lo comprobado |
| Propuesta C10 (II.5) | Irlanda «garantizó todos los pasivos de sus grandes bancos» | «Los depósitos y casi toda la deuda» (la garantía excluía parte de la deuda subordinada) |
| Propuesta C15 (III.4) | Credit Suisse, «uno de los 30 bancos de importancia sistémica mundial»; sentencia del Tribunal Administrativo Federal suizo de octubre de 2025 sobre los AT1 | «Un banco de importancia sistémica mundial»; la sentencia no se usa (sin comprobar en la fase de datos y recurrible) |
| Propuesta C13 (III.2) | FRTB «en la Unión Europea se aplicará desde 2027» | Sin fecha (V25: aplazamiento con un acto delegado en escrutinio y fuentes contradictorias) |
| Ficha `diamond-dybvig` (canon) | Autarquía «entre $(1,R)$ y $(L,R)$» | En el tema, «de $(1,1)$, todo guardado, a $(L,R)$, todo invertido», como el `.tex` del 3.A.10 (la ficha se corrige en la fase canon: § 6) |

## 3. Marcas resueltas

Ninguna: el tema no tiene original con marcas, notas ni comentarios. Las preguntas de la referencia se han resuelto en las propuestas (P1-P31 de `_trabajo/pendientes.md`).

## 4. Datos actualizados

Todas las consultas, del 12/11/2026 (detalle en `_trabajo/propuestas-datos.md`). «Anterior» es lo que decía la referencia (Tebar), porque no hay original.

| Dato | Anterior | Nuevo (en el tema) | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| V1 Precio de la vivienda en EE. UU. | sin cifras | casi se duplicó de 2000 a mediados de 2006; −27 % hasta 2012 (−35 % en 20 ciudades); gráfico `vivienda-eeuu` | S&P vía FRED (`FRED2026CaseShiller`) | https://fred.stlouisfed.org/series/CSUSHPINSA | 12/11/2026 | FHFA (otro índice, misma cronología) |
| V2 Tipos de la Reserva Federal | «durante 2006» | 1 % hasta mediados de 2004; 17 pasos hasta el 5,25 % (junio de 2006) | FRED (`FRED2026ObjetivoFed`) | https://fred.stlouisfed.org/series/DFEDTAR | 12/11/2026 | Fed, *Open Market Operations* |
| V3 9/8/2007 | — | BNP Paribas suspende 3 fondos; el BCE presta 95.000 M€ a un día | FRASER; BCE, Informe anual 2007 | https://fraser.stlouisfed.org/timeline/financial-crisis | 12/11/2026 | BoE, *FSR* oct. 2007 |
| V4 Northern Rock | — | Liquidez del BoE (14/9/2007), colas, nacionalización (feb. 2008); sin «primera desde 1866» | BoE; FRASER | https://www.bankofengland.co.uk/news/2007/september/liquidity-support-facility-for-northern-rock-plc | 12/11/2026 | BoE, *FSR* |
| V5 Bear Stearns | — | marzo de 2008 | FRASER | ídem | 12/11/2026 | **sin segunda** |
| V6 Fannie Mae y Freddie Mac | — | 7/9/2008 (anexo B) | FRASER | ídem | 12/11/2026 | **sin segunda** |
| V7 Lehman | «en 2008» | 15/9/2008 | FRASER | ídem | 12/11/2026 | FCIC (2011) |
| V8 AIG | — | hasta 85.000 M$ a cambio del 79,9 % | Fed (`Fed2008AIG`) | https://www.federalreserve.gov/newsevents/pressreleases/other20080916a.htm | 12/11/2026 | FRASER |
| V9 Reserve Primary Fund | — | 16/9/2008, no devuelve el dólar | FRASER; FCIC | ídem | 12/11/2026 | FCIC |
| V10 TARP | — | 700.000 M$; 444.000 desembolsados; coste neto de unos 31.000 M$ | CBO (2024) | https://fraser.stlouisfed.org/files/docs/historical/fct/cbo_report_20240419.pdf | 12/11/2026 | FRASER; OMB («similar») |
| V11 Fed al 0-0,25 % | — | diciembre de 2008 | Fed (`Fed2026OpenMarket`) | https://fred.stlouisfed.org/series/DFEDTAR | 12/11/2026 | FRED |
| V12 Ayudas de Estado a bancos en la UE | — | 665.000 M€ en capital (2008-2017); garantías de más de 800.000 M€ en 2009 | Comisión, *Scoreboard 2018* | https://ec.europa.eu/competition-policy/system/files/2021-04/state_aid_scoreboard_2018.pdf | 12/11/2026 | Cleary Gottlieb; LUISS |
| V13 Crisis bancarias sistémicas | — | 164 (1970-2025); 24 en 2007-2008 (introducción) | Laeven y Valencia (2026, 2020) | https://www.imf.org/en/publications/wp/issues/2026/05/14/systemic-banking-crises-database-1970-2025-576036 | 12/11/2026 | fichero de 2020; 3.B.17 |
| V14 Coste mediano (renta alta) | — | 32 % del PIB en producción y 6,7 % en ayudas (I.1) | Laeven y Valencia (2026) | ídem | 12/11/2026 | **sin segunda independiente** |
| V15 Coste fiscal de 2008 | — | 4,5 % del PIB en EE. UU.; 37,6 % en Irlanda (II.5 d) | Laeven y Valencia (2020), fichero | https://static-content.springer.com/esm/art%3A10.1057%2Fs41308-020-00107-3/MediaObjects/41308_2020_107_MOESM1_ESM.xlsx | 12/11/2026 | **sin segunda** |
| V16 Reinhart y Rogoff | — | −35 % vivienda, −55 % bolsa, +7 puntos de paro, +86 % deuda (introducción) | *AER* (2009) | https://doi.org/10.1257/aer.99.2.466 | 12/11/2026 | NBER w14656 |
| V17 Acelerador financiero | «50 %» sin país | «cerca de la mitad», Corea 1997-1998 (I.3) | GGN (2007) | https://doi.org/10.1111/j.0022-2879.2007.00027.x | 12/11/2026 | NBER w10128 |
| V18 Queraltó (2020) | «más impacto de las bancarias» | recuperaciones lentas por la innovación (I.3) | *JME* | https://doi.org/10.1016/j.jmoneco.2019.03.008 | 12/11/2026 | Fed IFDP 1097 |
| V19 Intermediación no bancaria | 40/50/10 % | 51 % no bancarios, 38 % bancos (fin de 2024; conclusión) | FSB (2025) | https://www.fsb.org/2025/12/global-monitoring-report-on-nonbank-financial-intermediation-2025/ | 12/11/2026 | PDF del informe |
| V20 Silicon Valley Bank | «retirada el 10 de marzo» | más de 40.000 M$ el 9/3/2023, 100.000 más esperados, ≈ 85 % de los depósitos, cierre el 10; 94 % sin garantía; pérdida de 1.800 M$ el 8/3 | Fed (2023), *Review* | https://www.federalreserve.gov/publications/files/svb-review-20230428.pdf | 12/11/2026 (PDF leído hoy por el editor: 85 % y 94 %) | comunicado conjunto del 12/3/2023 |
| SVB, pérdidas latentes | — | unos 15.000 M$ en la cartera a vencimiento frente a un patrimonio de unos 16.000 M$ (III.4) | 10-K de 2022 (`SVB2023Form10K`) | https://www.sec.gov/Archives/edgar/data/719739/000071973923000021/sivb-20221231.htm | 12/11/2026 (propuesta de contenido) | ICAEW (no oficial): **duda 8** |
| V21 Credit Suisse | — | 19/3/2023, absorción por UBS, AT1 de unos 16.000 M CHF | FINMA | https://www.finma.ch/en/news/2023/03/20230319-mm-cs-ubs/ | 12/11/2026 | Consejo Federal |
| V22 Garantía de depósitos en la UE | EDIS como pilar existente | 100.000 €, fijados tras 2008 (Directiva 2009/14/CE); EDIS sin aprobar | EUR-Lex; Comisión | https://eur-lex.europa.eu/eli/dir/2014/49/oj | 12/11/2026 | página del EDIS (julio de 2026); 3.B.16, 1D01 |
| V23 Garantía en EE. UU. | 250.000 $ | sin cambios | FDIC | https://www.fdic.gov/resources/deposit-insurance | 12/11/2026 | 12 U.S.C. § 1821 |
| V24 Nobel de 2022 | — | Bernanke, Diamond y Dybvig (introducción; II.1 e) | Academia Sueca | https://www.nobelprize.org/prizes/economic-sciences/2022/press-release/ | 12/11/2026 | 3.A.5 |
| V25 VaR de Basilea y FRTB | sin parámetros | 99 %, 10 días, × 3 mínimo (1996); ES al 97,5 % (FRTB); sin fecha de la UE | BCBS | https://www.bis.org/basel_framework/chapter/MAR/33.htm | 12/11/2026 | PDF de la enmienda de 1996 |
| V26 OMT | — | 26/7/2012 y 6/9/2012 | BCE (claves del 3.A.39) | — | 4/11/2026 | 3.B.16 |
| V27 Grecia 2015 | — | unos 40.000 M€ en el 1.er semestre | BCE (BSI), BIS (claves del 3.A.10) | — | 19/10/2026 | 3.B.17 |
| V28 Diferenciales soberanos | — | 555 pb en España y más de 2.700 en Grecia (2012); gráfico `diferenciales-soberanos` | BCE, IRS | https://data.ecb.europa.eu/data/datasets/IRS | 12/11/2026 | Eurostat (difunde la misma serie) |

`datos-actualizables.yaml`: los «texto» son ya las frases literales del tema (vivienda, diferenciales, crisis bancarias, costes, intermediación no bancaria y garantía de depósitos). Los hechos de 2007-2012 y 2023 no caducan y no se inventarían.

## 5. Contenido añadido

Todo el tema es nuevo. Por apartados, y con la propuesta de la que sale (C de contenido, K de coherencia, V de datos):

- **Introducción** (C2, K8, K43, V13, V16, V20, V24): enganche «El miedo es libre» con Northern Rock (2007) y SVB (2023); relevancia (frecuencia, coste, Nobel); 6 definiciones; 4 preguntas; estructura. Esquema y nota al opositor (K6).
- **I.1** (C3, K21, P9): tipos de Claessens y Kose con la definición de crisis bancaria del 3.B.17, crisis sistémica de Laeven y Valencia, gemelas y triples, `tab:tipos-crisis` con color y regularidades. **I.2** (C4, K18): las 5 fases de Kindleberger y Minsky. **I.3** (C5, K7): deflación por deudas, burbujas (Blanchard y Watson, Tirole, Abreu y Brunnermeier, Shiller) y fricciones financieras (Stiglitz y Weiss, Holmström y Tirole, BGG, Korinek), cada una con a)-e).
- **II.1** (C6, K34, K35): Diamond y Dybvig con a)-e); 4 asignaciones; `\optim`; `eq:dd-optimo`; contrato del banco; 2 equilibrios; ordenación `eq:dd-orden`; pánico por orden de llegada (71 %/29 %) y a prorrata (punto $P=(0{,}83;\,0{,}83)$: con las reservas del contrato, cada uno recibe 0,83; $(L,L)$ sería un banco con todo invertido); evidencia de 1930-1933 (Friedman y Schwartz, K25, sin la cifra de bancos sin comprobar), Northern Rock, Grecia, SVB e Iyer y Puri (2012). `fig:balance-banco` (K13, K40) y `fig:diamond-dybvig`.
- **II.2** (C8): fundamentos (Gorton; Allen y Gale, 1998), información (Chari y Jagannathan; Jacklin y Bhattacharya), juegos globales (Goldstein y Pauzner), contagio (Allen y Gale, 2000), disciplina (Calomiris y Kahn; Diamond y Rajan) y banca en la sombra.
- **II.3** (C9, K14, K15, V22, V23): suspensión, garantía (cifras de la UE y EE. UU., la *put* de Merton, 1977, Demirgüç-Kunt y Detragiache), EDIS sin aprobar, Bagehot, ambigüedad constructiva, SVB y *bail-in*. dicho «pagan justos por pecadores».
- **II.4** (C10, K16, K18, K21, K23, K26, V1-V12): las 5 fases; causas (tipos, exceso de ahorro, vivienda, *subprime*, titulización, MBS y CDO, banca en la sombra, CDS y AIG, regulación, FCIC); estallido y pánico mayorista con su cronología; transmisión; respuesta (liquidez, *swaps*, tipos, TARP, SCAP, ayudas de Estado en la UE, G-20, regulación); valoración. `fig:vivienda-eeuu`.
- **II.5** (C11, K20, K36, V15, V26, V28): círculo vicioso con a)-e), los 2 sentidos y los 5 pasos con las palabras del 3.B.16, agravantes de la unión, Farhi y Tirole, evidencia (Acharya, Drechsler y Schnabl; Acharya y Steffen; costes de Irlanda y EE. UU.; diferenciales), respuestas (unión bancaria, OMT y TPI, MEDE). dicho «estar en el mismo barco». `fig:circulo-vicioso` y `fig:diferenciales-soberanos`.
- **III.1** (C12, P10): 5 riesgos y los nuevos (climático), apetito de riesgo, 3 líneas de defensa, `tab:riesgos` con color. dicho «acordarse de Santa Bárbara cuando truena».
- **III.2** (C13, K7, V25): VaR con a)-e), `eq:var`, 3 métodos, Basilea 1996, ES y FRTB, pruebas de resistencia (SCAP), griegas, críticas (Adrian y Shin). dicho «nunca digas de esta agua no beberé». `fig:var`.
- **III.3** (C14, K24): PD, LGD, EAD y `eq:perdida-esperada`, NIIF 9, IRB (Vasicek, Gordy), gestión (Altman, *covenants*, retención del 5 %), dudosos y cobertura; Merton (1974) con a)-d).
- **III.4** (C15, C17): espiral de liquidez (Brunnermeier y Pedersen), LCR y NSFR, brecha de duración con la prueba de valores atípicos, SVB y Credit Suisse; recapitulación.
- **Conclusión** (C16, K9): 5 bloques, «A modo de conclusión», idea final con el refrán del enganche.
- **Anexos**: A (C18, K41) cuentas de Diamond y Dybvig, prorrata, suspensión y juegos globales; B (C19) cronología 2004-2012 con fuentes; C (C20) ejemplo del VaR, no subaditividad y capital IRB; D enlace al simulador de test.

**Propuestas no aplicadas** (con el motivo):

- C1 (estructura, títulos y minutos de contenido: II 11′30″, III 8′): manda coherencia (K4-K6), por decisión del coordinador.
- C1, C2, C6, C10: dichos «¡sálvese quien pueda!» y «entre todos la mataron…»: se usan las 6 del coordinador. K44 «una manzana podrida pudre el cesto» y «hacer la vista gorda»: por lo mismo.
- C2: «casi siempre desde el teléfono móvil» (no es literal del informe de la Fed) y C16 «ahora desde el teléfono móvil»: quitados.
- C4 y C5: dichos del 3.A.4 y el 3.A.42 (K38). C5 d) crisis gemelas como modelo propio: pasa a una viñeta de I.1 (K2, K21).
- C7: el pánico como lotería en el gráfico (flecha de $O$ al eje): se dibuja $P=(0{,}83;\,0{,}83)$, el reparto a prorrata (K35; corregido en el control de calidad); la lotería queda en el texto y en el anexo A (duda 3).
- C13: `graficos/var-es.tex` y `fig:var-es`: sustituido por `fig:var` (K40, con la cola gruesa); Jorion (2007) no se cita (edición sin comprobar): el método se cita con Hull (2023).
- C14: PE como `\funcionclave`: queda como ecuación numerada (K11: la nota al opositor promete 2 funciones clave).
- K19: Lorenzoni (2008), sin entrada comprobada. K25: «unos 9.000 bancos» de 1930-1933 [comprobar]: sin la cifra.
- K37: capas 7-8 en `circulo-vicioso`: el coordinador lo copió idéntico del 3.B.16; el texto dice que el círculo puede empezar en los bancos.
- K40.5: copia de `crisis-frecuencia` del 3.B.17: no (repetiría el gráfico; basta la cifra).
- K41: anexo D con Merton: Merton se queda en el cuerpo (III.3, 2′), con su valoración.
- C28: entradas `svb-*`, `frtb-ue-aplicacion` y `credito-privado-eeuu`: los hechos de 2023 no caducan, el FRTB no lleva fecha y el crédito de EE. UU. es histórico.

## 6. Coherencia

**Promesas de otros temas que se cumplen aquí** (todas con `\vertema{}` detrás de la idea):

| Tema | Qué prometía | Dónde se cumple |
|---|---|---|
| 3.A.10 | Desarrollo de Diamond y Dybvig, garantía, resolución y casos recientes | II.1 (misma notación, $T=0,1,2$, gráfico ampliado, Grecia y SVB con las mismas claves), II.3 (100.000 €, 0,8 %, Directiva 2026/804) |
| 3.A.13 | Riesgo moral del prestamista y del rescate, con SVB | II.3 c) |
| 3.A.36 | Crédito y vivienda con inflación baja | II.4 a) |
| 3.A.39 | Equilibrios múltiples de la deuda; OMT y TPI | II.5 b) ii) y e), con `Calvo1988Servicing`, `DeGrauwe2011Governance`, `Draghi2012Speech`, `BCE2012OMT`, `BCE2022TPI` |
| 3.A.42 | Las 5 fases de Kindleberger | I.2 (mismas palabras) y II.4 (la crisis contada con ellas) |
| 3.B.13 | Externalidad pecuniaria (Korinek, 2011) | I.3 |
| 3.B.16 | Mecanismo del círculo vicioso | II.5 (5 pasos con sus palabras, mismo gráfico) |
| 3.B.17 | Crisis bancaria por el pasivo y el activo; Diamond y Dybvig en desarrollo; 9/8/2007; *swaps*; parada súbita | I.1, II.1, II.4 b)-d) |
| 3.B.23 | Burbujas | I.3 |
| 3.B.25 | CDS, CDO, AIG, Bernanke (2018), griegas, Merton | II.4 a)-b), III.2 c), III.3 |
| 1D01 | Indicadores bancarios | III.3 (dudosos y cobertura) y `tab:riesgos` |

**Contradicciones con otros temas** (se anotan; no se tocan esos temas):

- **Ficha `diamond-dybvig`** (canon): el «Gráfico de referencia» dice «autarquía entre $(1,R)$ y $(L,R)$»; debe ser «entre $(1,1)$ y $(L,R)$», como el `.tex` y el texto del 3.A.10 (el $(1,R)$ es el mercado). Además: pasar el 3.B.26 a «desarrollo (hecho, 12/11/2026)», con `fuentes/3B26/graficos/diamond-dybvig.tex` como gráfico de referencia (capas 1-5 = las del 3.A.10 y el 3.B.17; 6-8, contrato y pánico), quitar la «referencia rota» y la nota de que el desarrollo estaba en el 3.B.27, y añadir que la ordenación $U^{\text{pánico}}<U^{\text{autarquía}}$ exige la aversión relativa > 1 ($u(0)=-\infty$) o el reparto a prorrata (CC1, C22).
- **Ficha `union-bancaria`**: dice que la reforma CMDI está «en negociación (verificar)»; ya está aprobada: **Directiva (UE) 2026/804**, que el 3.A.10 y este tema citan (`UE2026Dir804`). El EDIS sigue sin aprobar (CC9).
- **Claves de Diamond y Dybvig**: la 1D01 usa `DiamondDybvig1983` y el 3.A.10, el 3.B.17 y este tema, `DiamondDybvig1983Bank`, para la misma obra. Unificar en `DiamondDybvig1983Bank` cuando se toque la 1D01.
- **3.A.10** dice «unos 42.000 millones» para SVB (la orden de cierre de California, no consultada); aquí, «más de 40.000 millones» (informe de la Reserva Federal). Compatibles.
- **3.B.17** escribe Diamond y Dybvig con $t=0,1,2$ (allí $T$ es el momento del ataque); aquí y en el 3.A.10, $T$ (duda 1).
- **3.B.21** (Word sin revisar): da las subidas de la Fed «entre 2004 y 2007»; son de junio de 2004 a junio de 2006.
- **4.A.20** usa τ, $r_1$, $r_2$ para Diamond y Dybvig; al revisarse, π, $R$, $L$, $c_1$, $c_2$ y resumen con `\vertema{3.B.26}`.
- **Temas que deben remitir aquí al revisarse**: 3.B.20 (pánicos de 1930-1933), 3.B.21 (2007-2008), 3.B.27 (Diamond y Dybvig en resumen), 4.A.18 (titulización, círculo vicioso), 4.A.20 y 4.A.28. Para `mapa.yaml` (K45-K46): entrada del 3.B.26 con sus 22 remisiones; el 3.B.17 y el 3.B.25 ya remiten aquí (quitar de `faltan`); añadir como referencias al 3.B.26 las del 3.B.13 (l. 996), el 3.B.23 (l. 922) y la 1D01 (l. 2669).
- **Canon, notación** (CC2, C27): filas nuevas en § 11 para $T=0,1,2$ y el punto $P$; $\mathrm{VaR}_\alpha$, $\mathrm{ES}_\alpha$, α nivel de confianza; $\Pi$, $\tilde\ell\equiv-\Delta\tilde\Pi$, $\mu_\ell$, $h$; PD, LGD, EAD y PE en redonda; Merton con $V$, $\sigma_V$, VN, $V_E$, $V_D$, $d_1$, $d_2$, $N(\cdot)$, $N'(\cdot)$; $D^{\mathrm{mod}}_{\mathrm A}$, $D^{\mathrm{mod}}_{\mathrm P}$ y $\Delta V_E$; ρ local del anexo C (en el canon, ρ es la tasa de descuento); $P^{\mathrm b}_t$ y $P^{\mathrm f}_t$ de la burbuja.
- **Canon, fichas**: `doom-loop` (3.B.26 en desarrollo, gráfico del 3.B.16 copiado sin cambios; CC7), `ciclo-financiero` (fila 3.B.26 hecha; CC8), `historia-economica-espana` (crisis global desde el 9/8/2007; CC10).

## Puesta al día con las reglas de esta rama (13/11/2026)

Tema traído de la rama `revision-temario`; adaptado a las reglas de las tandas 4.ª-9.ª y de la revisión transversal, sin quitar contenido.

| Regla | Cómo se ha aplicado |
|---|---|
| Citas | 118 `\parencite`/`\parencites` pasan a `\nocite` (script); quedan 2 dentro de `\fuente{}` de gráficos de datos (FRED, BCE), como en los demás temas. La cita literal de Fisher queda «en palabras de \autor{Fisher}» con `\nocite` (se pierde la indicación «pág. 344; traducción propia», que sigue en la entrada del `.bib`) |
| Anexo de test | Caja estándar con `?tema=3.B.26`; fuera `GutierrezMarcos2026Simulador` del texto y del `.bib` |
| Figura / Gráfico | `balance-banco` (balance en T) y `circulo-vicioso` (cajas y flechas) pasan a `infografia`, `figu:`, «figura». `diamond-dybvig`, `var`, `vivienda-eeuu` y `diferenciales-soberanos` siguen como gráfico. No hay imágenes pegadas |
| Dichos (8.ª, 9.ª) | Se queda el refrán del enganche («El miedo es libre», que vuelve en la idea final). De los 6 dichos con etiqueta (ninguno del tema antiguo: el tema no tenía original de Víctor), se quedan 3 integradas sin etiqueta, porque explican bien la idea: «gato escaldado, del agua fría huye» (racionamiento tras las pérdidas), «pagan justos por pecadores» (quién paga el rescate) y «acordarse de Santa Bárbara cuando truena» (gestionar el riesgo antes). Se quitan «todo lo que sube, baja», «estar en el mismo barco» y «nunca digas de esta agua no beberé»; la idea que acompañaban se conserva. Corregida también la `notaopositor` y este informe |
| Estructura rígida de modelo | Fisher, burbujas, fricciones y Merton (modelos de nivel `\paragraph` con bloques en `\subparagraph`): los «Supuestos / Desarrollo / Implicaciones» que eran viñetas pasan a bloques i)-iii) con rótulo propio (`\hspace*{3.6em}\emph{i) Supuestos}`, como el 3.A.9). Círculo vicioso: «b) Mecanismo» (i Los 2 sentidos, ii Agravantes, iii Implicaciones) pasa a «b) Modelo» con i) Supuestos (sesgo doméstico y garantía implícita, y los 2 agravantes de la unión monetaria), ii) Desarrollo (los 2 sentidos y los 5 pasos) y iii) Implicaciones; «e) Valoración y respuestas» pasa a «e) Valoración». VaR: «b) Medida» (i Definición, ii Cálculo) pasa a «b) Modelo» con i) Supuestos (cartera, horizonte, nivel de confianza), ii) Desarrollo (definición y los 3 métodos) y iii) Implicaciones |
| Resultados clave en morado | Además de `eq:dd-optimo` y `eq:var`, pasan a `\funcionclave` el resultado del modelo de burbujas (`eq:burbuja`, Blanchard y Watson) y la fórmula de Merton (`eq:merton`) |
| Nobel | Bernanke, Diamond y Dybvig (2022) ya estaban en el texto (relevancia y valoración del modelo, con la contribución contada). Notas nuevas: \autor{Tirole} (2014; ahora se le nombra en las burbujas racionales), \autor{Shiller} (2013; se le nombra en las burbujas conductuales), \autor{Stiglitz} (2001; Stiglitz y Weiss), \autor{Holmström} (2016; Holmström y Tirole), \autor{Milton Friedman} (1976; Friedman y Schwartz en los pánicos de 1930-1933) y \autor{Robert Merton} (1997, con Scholes). Entradas copiadas de otros temas |
| CMDI de 2026 | El texto decía solo «la Directiva (UE) 2026/804». Ahora dice que la reforma consta de 3 actos de 30 de marzo de 2026 (DO L de 20/4/2026), con aplicación general desde mayo de 2028: Directiva (UE) 2026/804 (garantía de depósitos), Directiva (UE) 2026/806 (modifica la BRRD: resolución ampliada a bancos medianos y preferencia general de los depositantes) y Reglamento (UE) 2026/808 (modifica el Reglamento del MUR). Entradas nuevas `UE2026Dir806` y `UE2026Reg808`. Igual que en el 3.B.27 |
| Términos en inglés | Ya estaban; se añade CMDI (\emph{crisis management and deposit insurance}) |
| 4.º ejercicio | Ya había \vertema{4.A.18} y \vertema{4.A.19}; se añade \vertema{4.A.28} en las extensiones de la conclusión (la crisis en España) |
| Pizarra / vídeo, NEK, identidad contable | No aparecen en el texto del tema |
| Compilación | `construir-tema.py 3B26 --solo pdf --no-publicar`: 29 páginas de tema, 3 de anexos, 7 de bibliografía; `verificar-tema.py`: solo los 3 errores de los formatos publicados anteriores a la fuente y avisos de «cifra sin cita» |

Dudas nuevas: 13 y 14 (abajo).

## 7. Dudas abiertas

Aplicada en cada una la opción recomendada o la que dio el coordinador.

1. **Fechas de Diamond y Dybvig: $T$ o $t$.** Aplicado $T=0,1,2$, como el 3.A.10 (decisión del coordinador). `pendientes-coherencia.md` (l. 1216 y 1226) propone pasar la ficha y el 3.A.10 a $t$ por el 3.B.17; es cosmético. Si se elige $t$, cambiar II.1, II.2 y el anexo A (y la nota al pie de Merton, que avisa del $T$ de vencimiento).
2. **2007-2008 dentro del II** (aplicado, K4) o en un III junto a la gestión de riesgos (no recomendado: deja la gestión sin apartado propio).
3. **Cerrada (control de calidad, 12/11/2026).** El punto $P$ pasa a $(0{,}83;\,0{,}83)$, el reparto a prorrata con las reservas del contrato, en el texto (II.1), el anexo A y el gráfico; $(L,L)$ queda solo como el caso de un banco con todo invertido. Planteamiento anterior: **Pánico en el gráfico de Diamond y Dybvig: $P=(L,L)$ a prorrata** (aplicado, decisión del coordinador). **Ojo**: con las reservas del contrato ($\pi c_1^*$ guardado), el reparto a prorrata da a cada uno 0,83, no $L=0{,}6$; $(L,L)$ es el caso de un banco con todo invertido. El texto y el anexo A lo dicen así («cota inferior»). Recomendado: mover $P$ a $(0{,}83;\,0{,}83)$ y cambiar el rótulo a «pánico a prorrata: todos reciben 0,83» (la curva de la capa 8 pasa a $1/c_1+1/c_2=2/0{,}8343$); la ordenación no cambia. Alternativa: dejarlo como está.
4. **Gráfico del círculo vicioso**: el del 3.B.16, copiado sin cambios (aplicado, decisión del coordinador), o con las capas 7-8 de K37 (la entrada por los bancos y el sesgo doméstico).
5. **Fichas nuevas** (CC3-CC6): `var-expected-shortfall` (referencia 3.B.26, III.2), `riesgo-credito` (referencia 3.B.26, III.3 y anexo C), `prestamista-ultima-instancia` (referencia 3.B.26, II.3, con `Bagehot1873`) y `contagio` (referencia 3.B.17; aquí, resumen con Allen y Gale, 2000). Recomendado: crearlas.
6. **Notación de la burbuja**: $P^{\mathrm b}_t$ (aplicada, avisada en nota) en lugar de $B_t$, que es el beneficio en el canon.
7. **Enganche y dichos**: «El miedo es libre» y 6 dichos («todo lo que sube, baja», «gato escaldado, del agua fría huye», «pagan justos por pecadores», «estar en el mismo barco», «acordarse de Santa Bárbara cuando truena», «nunca digas de esta agua no beberé»). Comprobado que ninguna está en otro tema. Para CRITERIOS § 8 cuando se aprueben.
8. **Datos con una sola fuente**: V5 (Bear Stearns), V6 (Fannie Mae y Freddie Mac, anexo B), V14 (coste mediano), V15 (costes de Irlanda y EE. UU.) y las pérdidas latentes de SVB (15.000 frente a 16.000 millones, 10-K; la segunda, ICAEW, no es oficial). Recomendado: mantener (son fuentes oficiales o primarias).
9. **Notación del bloque III**: $\tilde\ell\equiv-\Delta\tilde\Pi$ para la pérdida (el gráfico `var` tiene $\Delta\tilde\Pi$ en el eje y $-\mathrm{VaR}$ a la izquierda, así que los 2 casan); PE en castellano junto a PD, LGD y EAD en inglés (como el Banco de España); $T$ de vencimiento en Merton con nota al pie. Alternativa para Merton: «a un año» sin $T$.
10. **`\vertema{3.B.13}` para Korinek** (I.3): cumple la remisión del 3.B.13 (l. 996), aunque el título del 3.B.13 es «Mercados de divisas».
11. **Cerrada (12/11/2026)**: arreglada con `\AtBeginBibliography{\emergencystretch=1.5em}` en el preámbulo del 3.B.26 (solo este tema; 0 líneas desbordadas). Planteamiento anterior: **Línea desbordada de 10 pt en la bibliografía**: es la entrada `Tirole1985Asset` (parte 1, copiada del 3.A.29), que no se parte bien con el DOI; no es de la parte 2 y no se ha tocado. Si molesta, se arregla en `tcee.sty` (cortes de los DOI en la bibliografía) para todos los temas.
12. **Control de calidad (12/11/2026)**: aplicado en el `.tex`: `Operacional` en `tceeverde` en `tab:riesgos` (el gris es el de las remisiones); punto $P=(0{,}83;\,0{,}83)$ (duda 3); la ES definida como $\frac{1}{1-\alpha}\int_\alpha^1\mathrm{VaR}_u\,du$, que con una distribución continua es $\mathbb E[\tilde\ell\mid\tilde\ell\geq\mathrm{VaR}_\alpha]$ (el ejemplo discreto del anexo C, 80 y 103,2, cuadra con esta definición, no con la esperanza condicionada, que daría 4 para un préstamo); `circulo-vicioso` a todo el ancho; citas nuevas: SVB 2020-2021 (`FED2023SVB`), supervisión en el BCE desde 2014 (`RegUE2013MUS`, art. 33.2, comprobado en EUR-Lex: «a más tardar el 4 de noviembre de 2014») y el MEDE en España en 2012 (`MEDE2026Espana`, página del MEDE comprobada: préstamo para recapitalizar los bancos aprobado en julio de 2012, desembolsado de diciembre de 2012 a febrero de 2013). Correcciones devueltas al editor y a `tema-tikz` (tabla de riesgos, punto $P$ de Diamond y Dybvig, definición de la ES, tamaño del círculo vicioso). Para Víctor, fuera de este tema: el 3.B.16 tiene el mismo `circulo-vicioso` a 0,6 del ancho, con letra de unos 5 pt; conviene ponerlo a todo el ancho cuando se toque ese tema. Las URL de FRED no respondían desde aquí, y las del FMI y la AEA dan 403 a los programas, así que no se han podido abrir. Las cifras sí casan con los CSV de `datos/`.

13. **Dichos** (13/11/2026): se quedan 3 de los 6, integrados («gato escaldado…», «pagan justos por pecadores», «acordarse de Santa Bárbara…»). Alternativas: (a) quedarse solo con el refrán del enganche; (b) recuperar alguno de los quitados. **Aplicada: 3 integrados (recomendada).**
14. **CMDI: comprobación** (13/11/2026): las fechas y los títulos de la Directiva 2026/806 y del Reglamento 2026/808 se han comprobado con el 3.B.27 y con notas de despachos y del Parlamento Europeo (la página de EUR-Lex no devolvió el texto al programa): **[comprobar]** en EUR-Lex el título en español de las 2 entradas nuevas del `.bib`. **Aplicada: citar los 3 actos.**

## 8. Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra.** Enganche: «El miedo es libre», dice el refrán; las colas de Northern Rock (septiembre de 2007) y los más de 40.000 millones que salieron de Silicon Valley Bank en un día (9 de marzo de 2023), sin colas. Idea final: volver al refrán («el miedo es libre, y en un banco se convierte en realidad si nadie lo frena») y responder a la problemática: lo que impide el pánico no es que nadie tenga miedo, sino que nadie tenga motivos para tenerlo.
- **Gráfico conjunto por partes: el balance del banco** (`balance-banco`, hilo conductor del tema). Se dibuja al empezar II.1 y se queda en una esquina de la pizarra: capas 1-3 (la cuenta en T con sus partidas) y 4 (la flecha de la transformación de plazos) en II.1; capa 5 (vehículo de titulización y financiación mayorista resaltada) en II.4; capa 6 (los 5 riesgos junto a su partida) en III.1. En III.4 se vuelve a él para señalar el desajuste de duraciones de SVB.
- **A la pizarra, imprescindibles**:
  - `diamond-dybvig` en II.1, por capas: 1-5 (ejes, autarquía de $(1,1)$ a $(L,R)$, mercado $M$, recta del planificador y óptimo $O$) mientras se cuenta el desarrollo; 6 (el depósito alcanza $O$); 7-8 (el pánico $P$ y su curva, por debajo de la autarquía) al llegar al pánico.
  - `circulo-vicioso` en II.5, por capas, siguiendo los 5 pasos.
  - `var` en III.2: eje y densidad, cola del 1 % con $-\mathrm{VaR}$, $-\mathrm{ES}$ y, al final, las colas gruesas.
- **Funciones clave que se conservan en la pizarra todo el apartado**: `eq:dd-optimo` ($u'(c_1^*)=R\,u'(c_2^*)$, $1<c_1^*<c_2^*<R$) en II y `eq:var` ($\Pr(\tilde\ell>\mathrm{VaR}_\alpha)=1-\alpha$) en III. En una línea, sin destacar: $\mathrm{PE}=\mathrm{PD}\times\mathrm{LGD}\times\mathrm{EAD}$ (III.3) y la brecha de duración (III.4).
- **En una línea o de palabra**: la cadena de las 5 fases de Kindleberger como 5 flechas de palabras (I.2, y se repite en II.4 con los hechos de 2007-2008); `tab:tipos-crisis` resumida; 5 hitos de la crisis (9/8/2007, Northern Rock, Bear Stearns, Lehman, AIG y el Reserve Primary Fund).
- **De apoyo, en pantalla y sin dibujar**: `vivienda-eeuu` (II.4 a), `diferenciales-soberanos` (II.5 d), `tab:riesgos` (III.1) y la cronología del anexo B.
- **Dichos** (13/11/2026), dichos una vez dentro de la frase que explican: «gato escaldado, del agua fría huye» (fricciones), «pagan justos por pecadores» (riesgo moral del rescate, II.3) y «acordarse de Santa Bárbara cuando truena» (III.1). Los otros 3 se han quitado.
- **Lo que no se canta**: los anexos A-C (cuentas de Diamond y Dybvig, cronología, ejemplo del VaR e IRB), la evidencia de Iyer y Puri y de Acharya y Steffen, las cifras de las ayudas de Estado y del TARP (basta con «700.000 millones»).
- **Reparto**: introducción 2′30″; I 7′ (2′, 1′, 4′); II 12′30″ (II.1 4′30″, II.2 1′30″, II.3 1′30″, II.4 3′30″, II.5 1′30″); III 7′ (1′30″, 2′, 2′, 1′30″); conclusión 1′. Los números de tema no se dicen en voz alta.
