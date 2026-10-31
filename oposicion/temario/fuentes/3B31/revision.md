# Revisión del tema 3.B.31 — El cambio climático y su impacto en la economía. Evidencia y modelos integrados de evaluación. Acuerdos internacionales y principales medidas adoptadas para hacer frente al cambio climático

Revisión del 31/10/2026 (`/revisartema`, fase integrar, en 3 partes). Víctor está fuera hasta el
9/11: en cada decisión se ha aplicado la opción recomendada, y las que necesitan su visto bueno
están en «Dudas abiertas» (B31-01 a B31-12).

## Resumen

- **Tema sin original de Víctor** (`inventario.json`: `sin_original: true`). Según CRITERIOS §5, la
  **estructura sale del tema de Miquel Tebar Barbero** («B.31 El cambio climático y su impacto en la
  economía», ≈ 6.960 palabras en esquema), reordenada y ampliada con las fichas del canon, los temas
  revisados del bloque (3.A.14, 3.A.20-3.A.24) y la decisión D072 (el 3.B.31 es el tema de
  referencia del MAFC). Ninguna otra referencia servía: Cabado no tiene un tema parecido y los
  «3B31» de Cerezal y De Fuentes son del temario anterior (Banco Mundial). Todo está redactado de
  nuevo; de Tebar se toman el orden y algunas ideas, no el texto.
- **Estructura**: los 3 epígrafes del título, en su orden. I. El cambio climático y su impacto en
  la economía (7′30″: I.1 1′30″, I.2 2′, I.3 4′); II. Evidencia y modelos integrados de evaluación
  (9′: II.1 2′30″, II.2 1′30″, II.3 5′); III. Acuerdos internacionales y principales medidas (9′30″:
  III.1 1′30″, III.2 1′30″, III.3 2′30″, III.4 4′). Introducción 2′30″ y conclusión 1′30″: 30′.
- **Hilo conductor**: «la tonelada de la acería», una tonelada de CO₂ que se sigue por los 3 bloques
  (qué hace en la atmósfera, cuánto daño causa y cuánto vale, quién la paga: RCDE, club, MAFC).
  Enganche y cierre con «Quien siembra vientos recoge tempestades».
- **Modelos con a)-e)**: el DICE de Nordhaus (II.3), los clubes climáticos (III.2) y el MAFC
  (III.4, en desarrollo); 2 funciones clave (`eq:dice` y `eq:ramsey-descuento`), la
  definición del CSC (`eq:csc`) y 4 anexos (DICE-2023 completo, cronología, temas del bloque, test).
- **Tamaño**: 46 páginas (32 de tema, 6 de anexos y 8 de bibliografía); 143 entradas en el
  `.bib`; los 7 gráficos (4 de teoría y 3 de datos) ya están hechos, y hay 7 tablas.

## Errores corregidos

No hay Word de Víctor, así que no hay errores «del original». Lo que sigue son los errores de la
referencia de estructura (Tebar) que **no** han pasado al tema (P8; `propuestas-contenido.md`,
C1-C24), con lo que dice el tema.

| Dónde (Tebar) | Qué decía | Qué dice el tema |
|---|---|---|
| Introducción | «2.ª Cumbre del Clima de la ONU en Río» | Cumbre de la Tierra de Río (1992), donde se abrió a la firma la CMNUCC (adoptada en Nueva York el 9/5/1992, en vigor en 1994); la COP1 es la de Berlín (1995) |
| 4.1 | «Social Cost of Capital» | Coste social del carbono (CSC; *social cost of carbon*) |
| 3.1 | «El SCC no indica el impuesto óptimo» | El impuesto óptimo **es** el CSC de la senda óptima (50 $ en 2020); lo que no coincide es el CSC de la senda sin política (66 $) |
| 3.3 | ρ = 1,5 % y φ = 1,45 → «tasa de descuento del 1,5 %» | ρ es la preferencia temporal pura; el descuento de los bienes es $r_s=\rho+\theta\gamma_c$ (fórmula de Ramsey del descuento); DICE-2023 se calibra para un rendimiento real del 4,5 % en 2020 |
| 3.2 | φ como «la sigma de la aversión al riesgo» | θ (canon) es la aversión a la desigualdad entre generaciones; Barrage y Nordhaus dicen que no representa la aversión al riesgo |
| 3.1 | Supuestos del RCK: «sin crecimiento de la población ni tecnológico»; «no Ponzi (= transversalidad)» | Población y PTF exógenas y crecientes; los supuestos del RCK no se repiten (una línea con `\vertema{3.A.43}`) |
| 3.2 | $\Lambda=\sigma\mu^{\psi}$ | $\Lambda(\mu_t)=\vartheta_{1,t}\mu_t^{\vartheta_2}$, $\vartheta_2=2{,}6$, con la tecnología de respaldo (anexo) |
| 3.2 | $Q=(1-D)(1-\Lambda)Y$ | Correcta en su forma (Barrage y Nordhaus, 2024, ec. 2): $Q_t=[1-\Lambda(\mu_t)][1-\Omega(T_t)]Y_t$, con Ω para los daños (D es deuda en el canon) |
| 3.3 | Óptimo ≈ 3 °C; impuesto de 43 $ en 2020 y 300 $ en 2100 | Son de DICE-2016. DICE-2023: 2,6 °C en 2100 en el óptimo (3,6 °C sin política), 50 $ en 2020 y 115 $ en 2050 |
| 3.3 | «PRICE: probabilistic RICE» | Quitado (no documentado); extensiones documentadas: RICE, R&DICE, ENTICE, C-DICE |
| 4.1 | «El impuesto no requiere ajustes porque el SCC es constante» | El CSC crece con el tiempo: el precio óptimo es una rampa |
| 4.1 | *Cap and trade* «similar al teorema de Coase» | Dales (1968) y Montgomery (1972), un mercado creado por el Estado |
| 4.1 | La adaptación como bien público | La mitigación es un bien público global; la adaptación, casi siempre privada o pública local |
| 4.3 | Kioto «obliga a reducir emisiones a todos» | Solo a los países desarrollados y las economías en transición |
| 4.3 | Kioto, «5 %» | Es lo que dice el art. 3.1 («al menos un 5 %»); el 5,2 % es la suma de los compromisos. El tema da las 2 cifras, cada una con su sentido (la corrección de P8 no era exacta) |
| 4.3 | EE. UU. «salió» de Kioto | Lo firmó y nunca lo ratificó; Canadá sí salió (2012) |
| 4.3 | Copenhague «establece» los 2 °C | Acuerdo político del que la COP «toma nota»; los 2 °C se formalizan en Cancún (2010) |
| 4.3 | París «en vigor desde 2020», «195 firmantes», «objetivo formal de 2 grados» | En vigor el 4/11/2016; 194 partes; «muy por debajo de 2 °C» y esfuerzos para 1,5 °C |
| 4.3 | EE. UU. «abandonó en 2017 y volvió en 2021» | Salida efectiva el 4/11/2020, vuelta el 19/2/2021, nueva salida el 27/1/2026 y salida de la CMNUCC notificada (efectiva el 27/2/2027) |
| 4.3 | COFIDES acreditada «en 2017» (P8) | Desde octubre de 2018 (nota al pie de III.3) |
| 4.4 | El MAFC «es un arancel… fundado en los clubes de Nordhaus» | Es un ajuste en frontera que iguala el precio del carbono; se compara con el club en su valoración |
| 2.2 | Dell, Jones y Olken (2012): «1,4 % del PIB per cápita» | 1,3 puntos de crecimiento en el año, solo en los países pobres |
| 2.2 | Nordhaus (2010): «0,1 % del PIB en 1950-2008» | Lo comprobable: unos 10.000 M$ al año, en torno al 0,08 % del PIB, con daños que crecen con la novena potencia del viento |
| Varios | CO₂ «+40 % desde 1800»; «+1 grado desde 1900»; «España, el país europeo más vulnerable»; «Arrow y Debrow»; «políticas contractivas» en el dilema; RCDE «−2,2 % anual»; fondo de pérdidas y daños «de la COP28» | +53 % (OMM, 2026); 1,47 °C en 2025 (Copernicus); el sur de Europa, zona de más riesgo (AEMA, sin ranking); Debreu (no se usa aquí); «no reducir»; 4,3 % y 4,4 %; creado en la COP27 y puesto en marcha en la COP28 |
| Bibliografía | Colmer *et al.* citado por un enlace a X | *Review of Economic Studies* 92(3), 2025 (`Colmer2025Pricing`) |

Una errata propia, corregida antes de cerrar: en la bibliografía, la entrada de Ramsey (1928)
desbordaba 2,5 pt; ahora lleva el nombre completo de la revista (*The Economic Journal*) y su DOI
(10.2307/2224098, comprobado en Crossref), y ya no desborda.

Del control de calidad (31/10/2026): `\Bigl(`/`\Bigr)` y `\bigl[`/`\bigr]` pasan a
`\left`/`\right` (pandoc no los acepta; caja de la fórmula de Ramsey del descuento, `eq:csc`,
`eq:dice` y anexo del DICE); las fuentes de los gráficos de emisiones (España incluye Andorra),
temperatura (2026 hasta el 29 de octubre) y precio del RCDE (qué es la banda) se completan, y el
paso 3 del MAFC remite al rectángulo sombreado del gráfico; en Solow (1974) y Stiglitz (1974) el
nombre del simposio pasa de `number` a `issuetitle`.

## Marcas resueltas

No hay marcas amarillas ni rojas, notas al opositor, comentarios ni texto oculto (no hay Word). Sus
veces las hacen los pendientes P1-P35 de `_trabajo/pendientes.md`:

| P | Qué pedía | Dónde se resuelve |
|---|---|---|
| P1 | Cubrir el impacto en la economía | I.1-I.3 |
| P2 | Cubrir la evidencia | II.1 (corte transversal, panel, temperatura global, desastres, límites) |
| P3 | Cubrir los modelos integrados | II.2-II.3 y `anexo:dice` |
| P4 | Cubrir los acuerdos | III.2-III.3 y `anexo:cronologia` |
| P5 | Cubrir las medidas | III.1 y III.4 |
| P6 | MAFC en desarrollo (D072) | III.4, con a)-e), `eq:mafc` y `fig:mafc` |
| P7 | Otras referencias | Ninguna de preparadores; manuales y artículos (parte F de las propuestas) |
| P8 | Errores de Tebar | Ver «Errores corregidos» |
| P9 | Canon (fichas) | Fichas nuevas `dice` y `clubes-climaticos` propuestas (B31-02) |
| P10 | Ficha `cbam` frente a `mapa.yaml` (3.B.37 y 3.B.41) | Resumen en los 2 (recomendada; anotado en «Coherencia») |
| P11-P17 | Gráficos y tablas | `fig:temperatura-co2`, `fig:emisiones-paises`, `fig:mafc`, `fig:dice-esquema`, `tab:dice-resultados` (en lugar de un gráfico, P15), `tab:dilema-clima`, `fig:precio-rcde` |
| P18 | Tabla de las COP | `tab:cop` en `anexo:cronologia` |
| P19 | Tabla de instrumentos | `tab:instrumentos-clima` |
| P20 | No repetir el gráfico de la externalidad | Se remite al 3.A.23; en su lugar, `fig:emisiones-optimas` (en emisiones y con la suma de daños) |
| P21 | Evidencia en II.1 o en I.3 | II.1 (recomendada, D1) |
| P22 | Externalidad en I.2 o en III.1 | I.2 (D2) |
| P23 | Profundidad de Pigou, *cap and trade* y Weitzman | Resumen con tabla (D3) |
| P24 | Cuánta España | Exposición en I.3 y una línea en III.4 con `\vertema{4.A.6}` (D4) |
| P25 | Módulo climático del DICE | En palabras y con el esquema en el cuerpo; ecuaciones en el anexo (D5) |
| P26 | Reparto del cante | 7′30″ / 9′ / 9′30″ (B31-03) |
| P27-P34 | Coherencia con 3.A.14, 3.A.20-3.A.24, 3.A.43, 3.B.30, 3.B.37 y remisiones | Ver «Coherencia» |
| P35 | Notas privadas y enlaces | No hay notas; Colmer *et al.* por el artículo publicado |

## Datos actualizados

Todos los datos son nuevos (no hay Word). Fecha de consulta: 31/10/2026 salvo que se diga otra.
Detalle completo, con frases y discrepancias, en `_trabajo/propuestas-datos.md` (V1-V49).

| Dato | Valor anterior (Tebar) | Valor nuevo | Fuente | URL | Segunda comprobación |
|---|---|---|---|---|---|
| Temperatura de 2025 y 2024 sobre 1850-1900 | «+1 grado» | 1,47 °C (3.º más cálido); 2024, 1,60 °C (récord); 2023-2025, primer trienio sobre 1,5 °C | Copernicus, GCH 2025 | https://climate.copernicus.eu/copernicus-2025-was-third-hottest-year-record | Serie diaria ERA5 recalculada (cuadra); OMM: 1,43 °C |
| Calentamiento de origen humano | — | 1,37 °C en 2025; 0,27 °C por década | Forster *et al.* (2026), ESSD | https://doi.org/10.5194/essd-18-3889-2026 | AR6: 1,1 °C en 2011-2020 |
| Presupuesto de carbono (1,5 °C, 50 %) | — | ≈ 130 GtCO₂ a principios de 2026 (≈ 3 años); AR6: 500 desde 2020 | Forster *et al.* (2026); IPCC (2023) | ídem | GCB 2025: 170 Gt (otra base; anotado) |
| Concentración de CO₂ | «+40 %» | 426,8 ppm en 2025, +53 % sobre 1750 | OMM, Boletín de GEI n.º 22 | https://wmo.int/news/media-centre/greenhouse-gas-levels-once-again-reach-record-high | NOAA: 425,6 (global) y 427,4 (Mauna Loa) |
| Emisiones de GEI y reparto | — | 54.149 MtCO₂e en 2025 (+0,7 %); China 29,5 %, EE. UU. 11,1 %, India 8,3 %, UE 5,8 %; por habitante 17,5 / 7,1 / 3,1 t | JRC, EDGAR 2026 | https://edgar.jrc.ec.europa.eu/report_2026 | Nota del JRC (7/9/2026); prensa con otro denominador |
| CO₂ fósil | — | ≈ 38.100 Mt en 2025 (récord) | Global Carbon Project 2025 | https://globalcarbonbudget.org/fossil-fuel-co2-emissions-hit-record-high-in-2025/ | VLIZ, Reading, NIES |
| Arrecifes de coral | — | Punto de inflexión cruzado (≈ 1,2 °C) | Global Tipping Points Report 2025 | https://global-tipping-points.org/ | NOC y ZSL |
| Proyección a 2100 | «2,5-5 °C» | ≈ 2,8 °C con las políticas actuales; 2,3-2,5 °C con todas las contribuciones | PNUMA, *Emissions Gap Report 2025* | (en el `.bib`) | — (unep.org da 403 a los robots) |
| Daños por grado (corte transversal) | 8,5 % | 8,5 % (correcto, entre países) | Dell, Jones y Olken (2009) | https://doi.org/10.1257/aer.99.2.198 | Citado en DJO (2012), p. 66 |
| Daños por grado (panel) | «1,4 % del PIB» | 1,3 puntos de crecimiento, países pobres | Dell, Jones y Olken (2012) | https://doi.org/10.1257/mac.4.3.66 | OpenAlex; NBER (versión previa: 1,1) |
| Óptimo de temperatura | — | 13 °C; −23 % de renta media en 2100 | Burke, Hsiang y Miguel (2015) | https://doi.org/10.1038/nature15725 | PubMed |
| Temperatura global y PIB | ≈ 12 % (apuntes) | > 20 % del PIB mundial a largo plazo; CSC > 1.200 $ | Bilal y Känzig (2026), *QJE* | https://doi.org/10.1093/qje/qjag011 | NBER w32450 (ene. 2026) |
| Kotz, Levermann y Wenz (2024) | citado | Retirado por *Nature* el 3/12/2025 | *Nature*, nota de retractación | https://www.nature.com/articles/s41586-025-09726-0 | Crossref, Retraction Watch |
| DICE-2023: CSC de 2020 | 43 $ (DICE-2016) | 66 $ (políticas actuales), 50 $ (óptimo), 76 $ (2 °C), 61 $ (París ampliado), 124 $ (daños de Howard y Sterner) | Barrage y Nordhaus (2024), *PNAS* | https://doi.org/10.1073/pnas.2312030121 | PMC10990119; texto del PDF releído hoy (tablas 1 y 2): la tabla da 75 $ para 2 °C (B31-05) |
| DICE-2023: temperatura y precio | ≈ 3 °C; 300 $ en 2100 | 3,6 °C / 2,6 °C en 2100; 115 $ (óptimo), 63 $ (París), 200 $ (2 °C) en 2050; 1,5 °C inalcanzable | ídem | ídem | ídem (§5 y tabla 1) |
| DICE-2023: daños, control y ganancia | — | 3,1 % del producto con 3 °C; daños en 2100: 4,4 / 2,3 / 1,4 / 3,1 %; control en 2050: 10 / 39 / 55 / 27 %; ganancia 119,7 / 107,3 / 85,4 billones | ídem | ídem | ídem |
| CSC oficial de EE. UU. | — | 190 $ (EPA, 2023, al 2 %); desde 2025, sin cifra oficial | EPA; OMB M-25-27 | https://www.epa.gov/system/files/documents/2023-12/epa_scghg_2023_report_final.pdf | Texto del OMB; E&E News, RFF |
| Clubes (C-DICE) | 50 $ y 5 % | 12,5-25 $ con arancel ≥ 2 %; 50 $ con ≥ 5 %; 100 $, poco | Nordhaus (2015), *AER* | https://doi.org/10.1257/aer.15000001 | Resumen de la AER |
| CMNUCC, Kioto, París, Montreal | 195 firmantes, etc. | 198 / 192 / 194 / 198 partes; fechas de vigor | ONU, Colección de Tratados | https://treaties.un.org | Notificaciones C.N.71.2025 y C.N.102.2026 |
| Retiradas de EE. UU. | 2017-2021 | 4/11/2020, 19/2/2021, 27/1/2026; CMNUCC, 27/2/2027 | ONU (C.N.71.2025, C.N.102.2026) | https://treaties.un.org/doc/Publication/CN/2026/CN.102.2026-Eng.pdf | Harvard EELP, Climate Home News |
| Financiación climática | — | 115.900 M$ en 2022; Bakú: 300.000 M$ en 2035 (1,3 billones de todas las fuentes) | OCDE (2024); CMNUCC | (en el `.bib`) | IISD; WRI |
| Balance mundial (COP28) | — | −43 % en 2030 y −60 % en 2035 sobre 2019; abandonar los fósiles | CMNUCC | https://unfccc.int/topics/global-stocktake | METI, Parlamento Europeo |
| COP30 y COP31 | — | Belém: triplicar la adaptación en 2035, sin hoja de ruta de los fósiles; COP31 en Antalya del 9 al 20/11/2026 | C2ES (2026) | https://www.c2es.org/wp-content/uploads/2026/02/COP30-Summary-FINAL5.pdf | SEI; Climate Home News |
| Ley Europea del Clima y 2040 | — | −55 % en 2030, neutralidad en 2050; −90 % en 2040 (Reglamento 2026/667), hasta 5 puntos con créditos desde 2036 | EUR-Lex; Comisión | https://climate.ec.europa.eu/eu-action/european-climate-law_en | Linklaters; 3.A.23 |
| Emisiones netas de la UE | — | −37 % en 2024 sobre 1990 | AEMA | https://www.eea.europa.eu/en/analysis/indicators/total-greenhouse-gas-emission-trends | Carbon Pulse; EDGAR (−35,6 % en 2025, otro ámbito) |
| Precio del RCDE | «2,2 % anual» (tope) | ≈ 85 € (media de oct. de 2026: 85,96 €); tope −4,3 %/−4,4 %; emisiones cubiertas a la mitad desde 2005 | EEX; Comisión | https://public.eex-group.com/eex/eua-auction-report/emission-spot-primary-market-auction-report-2026-data.xlsx | Precio del certificado MAFC del T3; 3.A.23 |
| MAFC | — | Definitivo desde el 1/1/2026; certificados desde feb. de 2027; T3 2026: 82,32 €; umbral de 50 t (Reglamento 2025/2083); propuesta aguas abajo (≈ 180 productos, en trílogo) | Comisión (DG TAXUD); EUR-Lex; Mayer Brown | https://taxation-customs.ec.europa.eu/carbon-border-adjustment-mechanism/price-cbam-certificates_en | EEX (82,18 de media simple); Herbert Smith Freehills |
| Reino Unido | 2027 | Ajuste propio desde el 1/1/2027, como impuesto y sin electricidad | HMRC | https://www.gov.uk/government/publications/factsheet-carbon-border-adjustment-mechanism-cbam/factsheet-carbon-border-adjustment-mechanism | DLA Piper, Clifford Chance |
| Precio del carbono en el mundo | — | 87 instrumentos, ≈ 30 % de las emisiones, > 107.000 M$ en 2025 | Banco Mundial (2026) | https://www.worldbank.org/en/news/press-release/2026/05/19/direct-carbon-pricing-covers-nearly-one-third-of-global-emissions | WAM, Polity |
| China | — | Mercado ampliado en 2025 a acero, cemento y aluminio (≈ 8.000 Mt), tope por intensidad | ICAP | https://icapcarbonaction.com/en/news/china-officially-expands-national-ets-cement-steel-and-aluminum-sectors | SCMP, Eco-Business |
| España | — | Ley 7/2021; PNIEC 2023-2030: −32 % sobre 1990 y 81 % de electricidad renovable en 2030 | BOE; MITECO | https://www.miteco.gob.es/es/prensa/ultimas-noticias/2024/septiembre/el-gobierno-aprueba-la-actualizacion-del-plan-nacional-integrado.html | Construible, Smartgrids |

Los gráficos de datos salen de `_trabajo/datos/` (temperatura ERA5 y HadCRUT5, CO₂ de la NOAA,
emisiones de EDGAR y precio del RCDE de EEX), con la fuente y el último dato en la cabecera de cada
CSV.

## Contenido añadido

Todo el tema es nuevo. Lo que no está en Tebar (o está en una línea) y de dónde sale:

- **I.1**: evidencia física con datos de 2025-2026 (Copernicus, OMM, Forster *et al.*, EDGAR), el
  CO₂ como stock y las emisiones netas nulas, el presupuesto de carbono, los puntos de inflexión
  (Armstrong McKay *et al.*, 2022; Lenton *et al.*, 2025) y las proyecciones (PNUMA).
- **I.2**: gráfico propio de las emisiones óptimas con la suma vertical de los daños de los países
  ($E^c>E^{\mathrm N}>E^*$, polizón entre Estados), sobre el de Coase del 3.A.23; los 5 rasgos de
  la externalidad climática (Hirshleifer, Kindleberger, Arrow y Fisher) y el dilema de Westfalia
  (Nordhaus, 2015).
- **I.3**: tabla de canales (riesgos físicos y de transición; Carney, NGFS, Schnabel), efecto nivel
  frente a efecto crecimiento, activos varados (McGlade y Ekins, 2015), desigualdad (Chancel, 2022)
  y España (AEMA; PNACC).
- **II.1**: la evidencia ordenada por método, con la U invertida de Burke, Hsiang y Miguel, Bilal y
  Känzig (2026) y los límites de la evidencia (con la retractación de Kotz *et al.*).
- **II.2**: tipos de modelos integrados, definición formal del CSC (`eq:csc`) y su uso oficial (EPA,
  OMB).
- **II.3**: el DICE como RCK con clima, con su problema de optimización (`eq:dice`), la condición
  del impuesto óptimo (`eq:csc-impuesto`), la fórmula de Ramsey del descuento con su derivación
  desde la ecuación de Euler (caja), los resultados de DICE-2023, Golosov *et al.* (2014) en caja,
  el cambio técnico dirigido (Acemoglu *et al.*, 2012), la tabla del descuento (Stern, expertos,
  DICE-2023, Nordhaus) y las críticas de Weitzman (2009) y Pindyck (2013).
- **III.1**: precio frente a cantidad para un contaminante de stock (Pizer, 2002), credibilidad,
  paradoja verde (Sinn) y efecto rebote (Jevons); tabla de instrumentos.
- **III.2**: el dilema entre países con los pagos del 3.A.14, el gatillo ($\beta\geq1/5$), Barrett
  (1994) y Montreal, y el club climático de Nordhaus como modelo a)-e).
- **III.3**: CMNUCC, Kioto, Copenhague y Cancún, París, balance mundial, financiación (Bakú, Belém,
  COP31) y las retiradas de EE. UU.
- **III.4**: Ley del Clima y objetivo de 2040, RCDE y RCDE 2, Fondo Social para el Clima, MAFC en
  desarrollo (diseño, `eq:mafc`, gráfico del mercado del acero, ingresos, extensión aguas abajo,
  Reino Unido, evidencia de Colmer *et al.*, 2025, OMC y comparación con el club), y el resto del
  mundo (Banco Mundial, China, EE. UU., España).
- **Conclusión** con sus 5 bloques; la relevancia cita la conferencia Nobel de Nordhaus (2019).
- **Anexos**: el DICE-2023 completo (bienestar, producción neta, daños, coste de reducción y
  tecnología de respaldo, con la derivación del precio óptimo; ciclo del carbono, forzamiento y
  temperatura de 2 cajas, con la calibración de la sensibilidad climática; tabla de resultados en 4
  escenarios), la cronología 1896-2026 (`tab:cop`), los temas del bloque (texto de K14) y el anexo
  de test con trampas, preguntas del tribunal y el enlace al simulador.

### Decisiones aplicadas (opción recomendada)

- **De contenido** (`propuestas-contenido.md`, A): D1 evidencia en II.1; D2 externalidad en I.2;
  D3 Pigou y *cap and trade* en resumen; D4 España, solo exposición y una línea; D5 módulo
  climático en palabras y esquema, ecuaciones en el anexo; D6 fichas `dice` y `clubes-climaticos`;
  D7 gráfico del precio del RCDE aquí; D8 ejemplo conductor de la tonelada de la acería; D9
  refranes («Quien siembra vientos…» y 3 pegatinas); D10 Bilal y Känzig con la cifra publicada y
  nota sobre la de 2024; D11 Kotz *et al.* solo como retirado; D12 notación del canon con letras
  locales avisadas; D13 Golosov *et al.* en caja.
- **De coherencia** (`propuestas-coherencia.md`, § 9): P21-P25 como D1-D5; P26/D3 reparto 7′30″ /
  9′ / 9′30″; P9/D4 las 2 fichas; P10 MAFC en resumen en el 3.B.37 y el 3.B.41; P17 gráfico del
  RCDE; D5 hilo de la tonelada; D6 el club no se queda el arancel (juego de coordinación) y el caso
  contrario en nota; D7 letras de Nordhaus como locales avisadas; D8 sin la frase de Joan Robinson;
  D9 el 37 % del MRR con `\vertema{3.B.45}`.

### Propuestas rechazadas o cambiadas

- **Pagos del dilema (C35/C50: 2, 3, −1, 0, con A y B)**: se usan los del 3.A.14 (5, 6, 0, 1, con
  Reducir y Emitir), como pide K10, para que el dilema se reconozca en todo el temario; el gatillo
  da $\beta\geq1/5$, igual que en el 3.A.14. El club resta 3 al que emite.
- **Ecuación del MAFC (K12)**: K12 la daba sin número, `\[a=(p_E-p_E^*)\sigma^M\]`; va numerada
  (`eq:mafc`) porque el gráfico y el anexo la citan. En el gráfico, $p^*$ y $a$ en lugar de
  $p^{\mathrm w}$ y $t^{\mathrm{MAFC}}$ de C51, para que coincida con el texto.
- **Producción neta del DICE (K8)**: K8 proponía la forma aditiva $Q=[1-\Omega-\Lambda]Y$; se deja
  la **multiplicativa** $Q_t=[1-\Lambda(\mu_t)][1-\Omega(T_t)]Y_t$, que es la ecuación 2 de
  Barrage y Nordhaus (2024) (comprobado hoy en el texto). El anexo dice que el código del modelo
  resta el coste de reducir de la producción neta de daños y que la diferencia es de segundo
  orden. Las 2 funciones clave de K8 (`eq:dice-bienestar`, `eq:dice-produccion`) se juntan en
  una, el problema del planificador `eq:dice`.
- **Sin remisión al 3.A.29 para la regla de Hotelling** (tabla de remisiones de coherencia): con
  el temario actual, el 3.A.29 es «Modelización dinámica de las tomas de decisiones»; la regla se
  explica en una línea en la paradoja verde, con la cita de Hotelling (1931).
- **ρ y θ del DICE-2023 sin cifra** (C39 y C49 daban ρ = 1 % y θ = 1,5 del documento de trabajo):
  no están en el texto del artículo publicado, sino en su apéndice, que no se ha leído (V18). El
  cuerpo y el anexo dicen que el descuento se calibra para un rendimiento del 4,5 % en 2020, y la
  tabla del descuento lleva la fila de DICE-2023 sin ρ ni θ. Tampoco se dan la población (≈ 10.800
  millones), el precio de respaldo (515 $) ni los ritmos de $\sigma_t$, que el anexo de C39 traía
  sin segunda comprobación; sí la función de daños de Howard y Sterner (124 $), comprobada hoy en
  la tabla 2 del artículo.
- **Kotz, Levermann y Wenz (2024)**: no como evidencia, sino como artículo **retirado** (límites de
  la evidencia, II.1, y una pregunta del tribunal), con la nota de retractación.
- **Gráfico de los resultados del DICE (C48, P15)**: no se pide; basta la tabla del anexo (los
  datos de las sendas están en el apéndice del artículo, sin leer).
- **Notación de C46**: el esquema del DICE se pide sin $\psi_2$ (Ω(T_t) a secas) y con el
  bienestar en $\beta^t$, como `eq:dice`.

### Frases sin cita (resueltas el 31/10/2026)

- III.2 d), Club del Clima del G-7: se cita la declaración de líderes del G-7 de 12/12/2022
  (`G72022ClimateClub`), que crea un club «abierto y cooperativo»; se añade la fecha al texto.
- III.4, marco europeo: el 37 % del Mecanismo de Recuperación y Resiliencia se cita al Reglamento
  (UE) 2021/241, art. 18.4.e) (`UE2021Reglamento241`). El reglamento habla de la «transición
  ecológica» y de la «dotación total del plan», no de «objetivos climáticos»: se ajusta la frase.
- III.4, resto del mundo: «la Administración actual ha recortado» la IRA se sustituye por lo que
  hace la Public Law 119-21 de 4/7/2025 (`EEUU2025PL11921`, secs. 70501-70515, comprobado en el
  texto publicado): suprime el crédito a los vehículos eléctricos desde el 30/9/2025 (sec. 70502)
  y el de eficiencia energética de las viviendas desde 2026 (sec. 70505), y retira el crédito a
  la electricidad eólica y solar a las plantas que entren en servicio después de 2027 (sec.
  70512, salvo excepciones). La IRA se cita a la Public Law 117-169 de 16/8/2022 (`EEUU2022IRA`).
- I.3: *fossilflation* «como en 2022» → `Schnabel2022New`; Ley de Reducción de la Inflación →
  `EEUU2022IRA`; estrategia del BCE de 2021 → nota de prensa del BCE de 8/7/2021 sobre el plan de
  acción climático (`BCE2021Clima`); «chalecos amarillos» → Douenne y Fabre (2022), *AEJ: Economic
  Policy* 14(1), 81-110 (`DouenneFabre2022Yellow`, comprobado en Crossref).
- II.3 b) iii): la lista de resultados del DICE se abre con «Según Barrage y Nordhaus (2024):»,
  que cubre todas las viñetas (incluida la del CSC de 76 $ para 2 °C).
- Queda sin tocar la nota del bloque III (los 5 hitos de la línea de tiempo).
- **«Martin» sin `\autor`**: el aviso de `verificar-tema.py` es por «Martin `\textcite{Weitzman2009Modeling}`»
  (II.3 e): «Martin» es el nombre de pila de Weitzman, no un apellido; se deja así.

## Coherencia

- **Con el 3.A.23** (K17): mismos datos y claves del RCDE (≈ 85 € en octubre de 2026, tope
  −4,3 %/−4,4 %, emisiones a la mitad desde 2005), del objetivo de 2040 y del RCDE 2 en 2028
  (`UE2026Reglamento667`), del MAFC (`UE2023Reglamento956`, 82,32 € en el T3 de 2026) y la misma
  traducción de la cita de Stern. El gráfico de las emisiones óptimas parte del de Coase del
  3.A.23. La media de octubre del RCDE (85,96 €) confirma la cifra del 3.A.23: no hay que tocarlo.
- **Con el 3.A.14**: mismos pagos del dilema (5, 6, 0, 1), estrategias con palabras, gatillo
  $\beta\geq1/5$.
- **Con el 3.A.21**: DICE-2023 con `BarrageNordhaus2024DICE` y `Nobel2018Nordhaus`; el DICE no es un
  MEGC multisectorial, sino un modelo integrado de crecimiento óptimo.
- **Con el 3.A.20, 3.A.22 y 3.A.24**: las generaciones futuras como motivo de la intervención
  (`\vertema{3.A.20}`), el MAFC como segundo óptimo (`\vertema{3.A.22}`), θ como aversión a la
  desigualdad entre generaciones (`\vertema{3.A.24}`) y el anexo del bloque con el mismo texto que
  el de los demás (K14).
- **Canon**: notación de `notacion.md` (θ, ρ, β, $r_s$, $\gamma_c$, $c_t$, α, δ, $A_t$, $t^*$,
  $p_E$, $\overline{E}$); letras locales avisadas en el texto ($T_t$, $\sigma_t$, $\mu_t$, $\Omega$,
  $\Lambda$, $\vartheta_1$, $\vartheta_2$, y en el anexo $M^{AT}_t$, $F_t$, $R_{i,t}$, $\xi_i$,
  $\ell_i$, $a_t$, $d_j$, $\kappa_j$). «Fórmula de Ramsey del descuento», nunca «regla de Ramsey»
  (que en el canon es la de la imposición óptima). Propuestas al canon: fichas nuevas `dice` y
  `clubes-climaticos` (CC1, CC2), `cbam` en resumen en el 3.B.37 y el 3.B.41 (CC3), términos y
  notación nuevos (CC4), y correcciones de las fichas `dilema-prisionero` e `impuestos-especiales`
  (CC6). Están en `propuestas-coherencia.md`, § 7; **no se han copiado aún** a
  `canon/pendientes-coherencia.md`, que no tiene entradas del 3.B.31.
- **Contradicciones con otros temas** (no se tocan; `propuestas-coherencia.md`, § 8 y § 10):
  1. 3.A.22 y 3.A.23 usan 2 claves para el mismo Reglamento (UE) 2023/956 (`UE2023CBAM` y
     `UE2023Reglamento956`); este tema usa la segunda.
  2. El 3.A.23 (conclusión y repaso) remite el MAFC al 4.A.6; su tema de referencia es el 3.B.31.
  3. El anexo del bloque del 3.A.22 no lista el 3.B.31 (los del 3.A.20, 3.A.23 y 3.A.24, sí).
  4. El 3.A.21 dice «modelo de evaluación integrada» y el título, «modelos integrados de
     evaluación» (sinónimos; el tema dice los 2 nombres).
  5. Sin revisar: el 3.A.43 remite al 3.B.31 un «Solow con recurso natural» que aquí no se
     desarrolla; el 3.A.29 (numeración antigua) le remite los recursos naturales; el 3.B.37 tiene
     el transitorio del MAFC mal fechado y el RCDE como «sistema de Coase»; el 4.B.18 está
     desactualizado; el 3.B.20 remite al 3.B.31 lo que es del 3.B.30.

## Dudas abiertas

Todas tienen aplicada la opción recomendada (★); basta con confirmarla o elegir otra.

- **B31-01. Enganche y refranes.** El tema no tiene original y los 2 agentes propusieron enganches
  distintos. (a) ★ «Quien siembra vientos recoge tempestades» con el dato de 2024 por encima de
  1,5 °C y la salida de EE. UU. de París; pegatinas «Pan para hoy, hambre para mañana»
  (descuento), «Más vale prevenir que curar» (mitigación y adaptación) y «Allá donde fueres, haz
  lo que vieres» (MAFC); la idea final vuelve al refrán. (b) «Pan para hoy, hambre para mañana»
  como enganche (lo propuso el agente de coherencia) y «Quien siembra…» fuera. (c) La cita de
  Stern como enganche (ya es la relevancia del 3.A.23). Ninguno de los 4 refranes está en otro
  tema (comprobado con `grep`).
- **B31-02. Fichas nuevas del canon `dice` y `clubes-climaticos`.** (a) ★ Las 2, con el 3.B.31
  como tema de referencia (los clubes ya los usa el 3.A.23 y los usarán el 3.B.19 y el 3.B.41).
  (b) Solo `dice`, y los clubes como apartado de `cbam`. (c) Ninguna: todo local del tema.
- **B31-03. Reparto de minutos.** (a) ★ I 7′30″, II 9′, III 9′30″ (I.1 baja a 1′30″ y III.4 sube a
  4′, para que el MAFC tenga unos 2′). (b) I 8′, II 9′, III 9′, como la estructura inicial (con
  III.4 en 3′30″ y el MAFC en 1′30″).
- **B31-04. Nivel de detalle del MAFC.** (a) ★ Desarrollo completo con a)-e), la fórmula
  $a=(p_E-p_E^*)\sigma^M$ y el gráfico del mercado del acero en la pizarra por capas (D072: el
  3.B.31 es su tema de referencia). (b) Resumen de 1′ con el gráfico como apoyo y el detalle
  (Ómnibus, aguas abajo, Reino Unido, OMC) solo en el documento.
- **B31-05. CSC del escenario de 2 °C: 76 o 75 $.** El texto de Barrage y Nordhaus (2024) dice 76 $
  y su tabla 2, 75 $. (a) ★ 76 $ en el cuerpo y en la tabla del anexo, con la discrepancia en la
  fuente de la tabla. (b) 75 $ en los 2 sitios.
- **B31-06. ρ y θ de DICE-2023.** (a) ★ Sin cifras (no están en el texto del artículo) y el
  rendimiento del 4,5 % en su lugar. (b) Leer el apéndice SI y añadir los valores al anexo y a
  la tabla del descuento (el documento de trabajo daba ρ = 1 % y θ = 1,5).
- **B31-07. Bilal y Känzig.** (a) ★ La cifra publicada (*QJE*, 2026: más del 20 % del PIB y CSC de
  más de 1.200 $), con una nota sobre el 12 % del documento de 2024. (b) Solo el 12 %, que es lo
  que traen los apuntes.
- **B31-08. Kotz, Levermann y Wenz (2024).** (a) ★ Citarlo solo como artículo retirado. (b) No
  citarlo.
- **B31-09. Frase de Joan Robinson (mapa a escala 1:1).** (a) ★ No ponerla. (b) Ponerla en la
  valoración de los modelos integrados, frente a la crítica de Pindyck.
- **B31-10. Frases sin cita** (G-7 Club del Clima, recorte de la IRA, 37 % del MRR). Resuelta
  el 31/10/2026: las 3 llevan ya su fuente primaria (declaración del G-7 de 12/12/2022, Reglamento
  (UE) 2021/241 art. 18.4.e) y Public Law 119-21); no hubo que quitar ninguna.
- **B31-11. Datos de noviembre de 2026.** El Global Carbon Budget 2026 y la COP31 (9-20/11) salen
  durante la revisión. (a) ★ Volver a mirar V8 y V32 antes de publicar y añadir el resultado de
  la COP31 a III.3 y a la cronología. (b) Publicar con los datos de hoy.
- **B31-12. Importe del Fondo Social para el Clima.** Las fuentes discrepan tras el retraso del
  RCDE 2 (65.000 M€ del Reglamento; máximo de 54.600 M€ según la Comisión). (a) ★ 65.000 M€ y
  «su retraso los reduce», sin cifra cerrada. (b) Dar el máximo revisado.

Otras cosas que no se han podido comprobar (sin decisión): el texto de las decisiones de la COP28 y
la COP29 (cifras cotejadas en fuentes secundarias), la financiación climática de 2023, las
emisiones de la UE en 2025 (AEMA), el número del real decreto del PNIEC y la vinculación de los
mercados de emisiones de la UE y el Reino Unido.

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra** (`modo: guion`), con sus 5 bloques nombrados.
  - Enganche: «Quien siembra vientos recoge tempestades»; 2024, primer año por encima de 1,5 °C, y
    EE. UU. fuera de París desde el 27 de enero de 2026; se presenta «nuestra tonelada de la
    acería».
  - Pregunta de arranque: ¿por qué, si a todos nos conviene emitir menos, el mundo sigue emitiendo
    más?
  - Idea final: la tonelada ya tiene precio en una parte del mundo; el reto es que lo tenga en todo
    él. Última frase: el refrán. Sin despedida.
  - El esquema del tema se escribe al empezar en la esquina superior izquierda y se queda.
- **Funciones clave que se conservan** (`conservar:`): el problema del DICE `eq:dice` y la fórmula
  de Ramsey del descuento `eq:ramsey-descuento` ($r_s=\rho+\theta\gamma_c$), desde II.3 hasta la
  conclusión, en una esquina. El CSC `eq:csc` se escribe en II.2 y se borra al acabar II.
- **Gráfico central de todo el cante**: `emisiones-optimas`, abajo a la izquierda. Se construye por
  capas en I.2 (CMgR, $E^c$, $\mathrm{DMg}_i$, $E^{\mathrm N}$, la suma vertical $\mathrm{DMg}$,
  $E^*$ y $t^*$, la llave del polizón) y **no se vuelve a dibujar**: en II.3 se señala el corte
  $\mathrm{CMgR}=\mathrm{DMg}$ al hablar del impuesto óptimo, y en III.1 se añaden los rótulos
  «impuesto $t^*$» y «tope $\overline{E}=E^*$» (capa 9). Los 5 rasgos de la externalidad, de
  palabra.
- **Bloque I**: 3 cifras en una esquina (1,47 °C en 2025, 426,8 ppm, ≈ 130 Gt de presupuesto);
  `temperatura-co2` y `emisiones-paises` como **apoyo**. La tabla de canales, en la pizarra en
  forma reducida (2 columnas × 5 filas, palabras sueltas) y se borra al acabar I.
- **Bloque II**:
  - `temperatura-productividad` a mano, en unos segundos, con España y el país tropical (capas 1-5);
    se vuelve a la tonelada.
  - Definición del CSC con `eq:csc`; los 3 tipos de modelos, de palabra.
  - `dice-esquema` por capas (8), en el centro; luego `eq:dice` como función clave; la condición del
    óptimo se dice sobre `emisiones-optimas`; `eq:ramsey-descuento` con la tabla del descuento como
    **apoyo** (Stern 1,4 % frente a Nordhaus 5,5 %: 25 $ frente a 50 céntimos). Pegatina «Pan para
    hoy, hambre para mañana» junto a la fórmula.
  - Las cajas grises (Euler → Ramsey, Golosov *et al.*) y la tabla de resultados del anexo, como
    **apoyo** si acaso; no se escriben.
  - Weitzman (2009) y Pindyck (2013), de palabra.
- **Bloque III**:
  - III.1, de palabra sobre `emisiones-optimas`; pegatina «Más vale prevenir que curar» junto a
    mitigación y adaptación; `tab:instrumentos-clima` como apoyo.
  - III.2: la matriz del dilema a la derecha (`tab:dilema-clima`, se escribe a mano); para el club
    se **tachan las 2 celdas de fuera de la diagonal y se reescriben** con el arancel (no se dibuja
    una segunda tabla); el gatillo $\beta\geq1/5$ en una línea.
  - III.3: línea de tiempo en una franja de abajo con 5 hitos (1992, 1997, 2015, 2023, 2024-2025);
    la cronología completa del anexo, como apoyo.
  - III.4: el RCDE de palabra con su precio; `precio-rcde` como apoyo. **El MAFC con `mafc` en la
    pizarra por capas (7)**, que es el gráfico conjunto del bloque: primero la situación sin
    política, luego el RCDE y la fuga (llave de 1,5 a 3), luego el ajuste $p^*+a$ y el nuevo
    equilibrio (llave de las importaciones de 3 a 4,5). Debajo, $a=(p_E-p_E^*)\sigma^M$ y el
    calendario 2023-2026-2034. Pegatina «Allá donde fueres, haz lo que vieres» junto al gráfico.
    Unos 2′ para el MAFC.
- **Ejemplo conductor**: siempre con frases naturales («Volvamos a nuestra tonelada…»), nunca
  «hilo». Aparece al menos una vez por subapartado; la última, en la recapitulación de III.
- **Al final** queda en la pizarra: el esquema, `emisiones-optimas`, las 2 funciones clave y el
  gráfico del MAFC.
- **Gráficos**:
  - en la pizarra: `emisiones-optimas`, `temperatura-productividad`, `dice-esquema` y `mafc`, y las
    matrices `tab:dilema-clima` y `tab:club-clima` (la segunda, tachando la primera);
  - como apoyo: `temperatura-co2`, `emisiones-paises`, `precio-rcde`, `tab:canales` (completa),
    `tab:descuento`, `tab:instrumentos-clima` y `tab:cop`;
  - solo en el documento: `tab:dice-resultados` y las ecuaciones del anexo del DICE.
- **No se dicen números de temas** en voz alta: «la teoría de las externalidades», «el modelo de
  Ramsey, Cass y Koopmans», «la teoría de juegos».
