# Revisión del tema 3.A.30 · Magnitudes macroeconómicas y contabilidad nacional

Fase integrar, 11/11/2026 (revisión autónoma: en cada duda se aplica la opción recomendada y se
anota como A30-NN). Escrito en 2 partes: la 1 (cabecera, introducción, esquema, I y II) y la 2 (III,
conclusión, 7 anexos y bibliografía); cada sección recoge las 2.

## 1. Resumen

- Base: el Word de Víctor (antiguo 3.A.26, agosto de 2024), con su estructura y sus títulos; la
  estructura y los minutos son los de coherencia (K) que fija el coordinador: introducción 2′30″;
  I 6′30″; II 13′30″; III 6′30″; conclusión 1′.
- Escritos la introducción (5 bloques, refrán «a ojo de buen cubero»), el esquema, el bloque I (las
  magnitudes y el flujo circular dentro de I.1, el SEC 2010 y sus principios) y el bloque II (las 6
  partes de la sucesión de cuentas con un patrón fijo de 4 rótulos por cuenta).
- 3 funciones clave en esta parte: `eq:cadena-agregados`, `eq:pib-tres-vias` (forma de la 1D01, con
  RA) y `eq:ahorro-inversion`; la 4.ª, `eq:contribuciones`, va en III.1 (parte 2).
- Datos de 2025 de España (INE y Banco de España vía Eurostat): PIB por las 3 vías, RNB > PIB,
  participación del trabajo, ahorro nacional, capacidad por sectores y cuenta financiera con su
  discrepancia (12.933 millones ≈ errores y omisiones de la balanza, 12.940, como el 3.B.11).
- Las 11 cuentas en T pasan al anexo `anexo:sucesion` (parte 2); en el cuerpo quedan la cascada, la
  tabla de agregados y las cajas grises de datos.
- III (compacto): del valor al volumen (volúmenes encadenados, deflactor como Paasche encadenado con la
  frase del 3.A.9, `eq:contribuciones` igual que la 1D01, gráfico de España), fuentes y alta
  frecuencia, y el PIB y el bienestar. Conclusión con opinión, que vuelve al «ojo de buen cubero».
  Anexos A-G. El tema ocupa 32 páginas (introducción-conclusión), 8 de anexos y 4 de bibliografía.
- Construido con `construir-tema.py 3A30` (PDF, HTML y Word publicados en la rama, en
  `tercer-ejercicio/`) y `verificar-tema.py`: 0 errores; los avisos son el guion y el vídeo, que
  faltan, y falsos positivos de «cifra sin cita» (los años de «SEC 2010» o «SCN 2025»).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| I.1 (l. ~95) | «En 1993, diversos organismos (ONU, FMI, OCDE, Banco Mundial) participan en la elaboración del SCN» | Primer SCN de 1953; revisiones de 1968, 1993, 2008 y 2025; desde 1993 lo firman 5 organismos, con la Comisión (V3) |
| Intro e I.1 | «última versión… SCN-2008» | SCN 2025, adoptado en marzo de 2025; nuevo SEC con cambios desde 2030 (V4, V5) |
| I.1 | «se ha adoptado en 2014» | Se aplica desde septiembre de 2014; reformado por el Reglamento 2023/734 (V2) |
| Bibliografía | «Reglamento 459/2013» | Reglamento (UE) n.º 549/2013 (V1) |
| Nota 3 | Kuznets «aconsejó al presidente… de manera decisiva a la derrota del eje», «muy pocas divisiones» | Nota del 3.A.31/3.B.11: Kuznets y Nathan (1942), tesis de Lacey (2011) «discutida» (V20) |
| Nota 18 | «El PIB, creado por Kuznets en 1932… Plan Marshall» | Encargo del Senado en 1932, informe de renta nacional en enero de 1934; lo del Plan Marshall sale (sin fuente, D7) |
| Lista de operaciones | Letras a), c), d), e) | Lista numerada 1-4 |
| Notas 7-8 | Productor de mercado: solo el 50 % | 50 % «de forma continuada durante varios años» y criterios cualitativos (V9) |
| Nota 12 | «6MBP» | MBP6, en una frase con remisión al 3.B.11 |
| Valoración (l. 416-418) | Los precios básicos excluyen «los impuestos sobre la producción» (contradecía la caja) | Definición única del 3.A.31: incluyen los otros impuestos netos sobre la producción |
| Devengo | Los impuestos se registran «a menudo según el criterio de caja» | Por devengo, con la caja ajustada en el tiempo como método |
| Residencia (texto rojo copiado del 3.B.11) | Sucursales residentes «excepcionalmente»; organismos internacionales «territorio económico en sí mismos» | Como el 3.B.11 revisado: sucursales con producción significativa, residentes como regla; organismos internacionales, de ninguna economía |
| C.0 | Exportaciones «a precios de adquisición»; «suma de todos los empleos y recursos» | FOB; equilibrio entre oferta y usos de productos, sin saldo |
| C.I | «VAB / PIB (a precios de adquisición)» | VAB a precios básicos; PIB a precios de mercado |
| PIB por la renta | «Salarios (W) + Rentas (O.I.P.) + Beneficios (EBE/RMB)» | RA + EBE + RMB + impuestos netos sobre la producción y las importaciones (`eq:pib-tres-vias`) |
| C.II.1.1 | EBE tras deducir «impuestos menos subvenciones a productos» | Impuestos netos sobre la producción y las importaciones (en un sector, solo D.29 − D.39) |
| Nota 16 | Participación del trabajo «del 66 % al 62 %» por la I+D, sin fuente | Koh, Santaeulàlia-Llopis y Zheng (2020), de palabra, para EE. UU. (V19, D-11) |
| C.II.1.2 / C.II.2 | Otras transferencias corrientes «afectan al ingreso primario»; saldos sectoriales llamados RNB | Afectan a la renta disponible; saldo de rentas primarias (sectores) y RNB (total) |
| C.II.4.1 | Tabla titulada «distribución de la renta en especie», con la RNDB en un sector; «RNBD» | Cuenta de utilización de la renta disponible; RDB en los sectores, RNDB en el total |
| Consumo colectivo | Mezclaba no exclusión y no rivalidad | Los 2 rasgos, separados |
| FBC | Sin objetos valiosos | 3 partidas (como el 3.A.34) |
| Activos | «Intangibles (marcas, patentes…)» | Productos de la propiedad intelectual (producidos) frente a marcas y fondo de comercio (no producidos) |
| Nota 30 | «Controversia semántica»: en el SEC 2010 la cuenta financiera no tendría saldo | SEC 2010, §5.17 y §1.126: su saldo es otra vez B.9; la diferencia es discrepancia estadística (V11) |
| Cuentas del resto del mundo | Numeración propia C.V.1-C.V.3.2 (y vacías) | V.I, V.II, V.III.1 y V.III.2 del SEC, con sus saldos B.11, B.12 y B.9 |
| Relevancia | «[ver Anexo A.6]» (matriz de contabilidad social) para el PIB y el bienestar | `\ref{sec:pib-bienestar}` (III.3) |


**Parte 2**

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| Anexo 1 y conclusión | «No tiene en cuenta la economía sumergida aunque sí prostitución y drogas»; «estas cuentas no incluyen la economía sumergida» | El SEC 2010 obliga a estimar la economía no observada, también la ilegal; el INE lo hace desde 2014 (V24) |
| Anexo 7 | Paradoja de Easterlin «basada en el *World Happiness Report*» | Easterlin (1974); el informe empezó en 2012 (V26), y Stevenson y Wolfers (2008) la matizan |
| Anexo 7 | MEW = «Valor del PIB + …», fórmula en inglés | En palabras: parte del consumo, no del PIB (V28) |
| Anexo 7 | «Índice de Crecimiento Inclusivo Davos 2018… Italia, Portugal e Italia» | Índice de Desarrollo Inclusivo; por delante solo de Italia, Portugal y Grecia (V29), en el anexo como dato histórico |
| Anexo 7 | Jones y Klenow: el PIB «adecuado para aproximar el bienestar» | Muy correlacionado, con desviaciones grandes (V27) |
| Anexo 8 | «RNBD»; «distribución y utilización de la renta de la renta»; subcuentas de la renta primaria con saldos cambiados | RNDB; nombres del SEC; B.4g renta empresarial y B.5g saldo de rentas primarias (`tab:sinoptica`) |
| Anexo 6 | «Las matrices de contabilidad han sido ignoradas» (sin fuente) | Fuera |
| 2.5.2 | 3 tablas *input-output* con 5 ecuaciones que mezclaban niveles (ET sin definir, $E$ para exportaciones) | Un párrafo en II.6 con las 2 identidades del 3.A.31 |

## 3. Marcas resueltas

- **Notas al opositor del cambio de temario (P7) e imagen de la ficha (P17)**: fuera.
- **Comentarios privados (P10, P11, P12, P13, P14)**: fuera, sin nombres. P12 (ordenar los
  principios como el 3.B.11): hecho (registro, momento, valoración, residencia). P13 («Juan Luis
  dice que es la suma…»): Víctor tenía razón, la cuenta 0 es el equilibrio de productos (C14). P14:
  la cuenta 0 va antes de las corrientes. P11: la delimitación del S.13, en una viñeta con
  `\vertema{4.B.1}`.
- **P1-P2 (UAE locales, amarillo)**: integradas en 2 viñetas con las palabras del 3.A.31; fuera
  «[Relevante en 3.A.31]» y «Lo dejo aquí pero no se mira».
- **P3 (partida cuádruple, amarillo)**: correcto; reescrito con el ejemplo de la prestación.
- **P4-P5 (residencia, amarillo y rojo «copiado del 3.B.11… creo que sí»)**: el criterio es el mismo
  en los 2 sistemas, pero el texto copiado tenía 2 errores que el 3.B.11 ya corrigió; corregidos.
- **P6 y P16 (estructura vacía y marca vacía)**: bloque Estructura escrito.
- **P8 (nota «dar intuiciones de los agregados»)**: patrón «Qué mide y para qué sirve» en cada cuenta y
  `tab:agregados`.
- **P15 (caja de impuestos y subvenciones)**: integrada en la valoración; la tabla D.21/D.29/D.31/D.39
  sustituye a la imagen 7 sin fuente, en caja gris con `\vertema{4.B.7}`.
- **Imágenes**: portada del SEC (P18), bañera (P19), CIF/FOB de Investopedia (P22) y cuadro de 2018
  (P31), fuera; imagen 1 (P20) → TikZ `sectores-sec`; image5 (P21) → `valoracion-precios` del 3.A.31;
  image8, imágenes 2, 4 y 6 (P24, P25, P28, P30) → TikZ `sucesion-cuentas`; imagen 3 (P26) →
  `triangulo-pib` y `tab:pib-espana-2025` con datos de 2025 (se conserva la cita de Gutiérrez
  Hernández, 2021); cuentas en T (P27) → anexo `anexo:sucesion` (parte 2); imagen 5 (P29) → anexo.
- **P45 (4 cuentas del resto del mundo vacías)**: `tab:resto-mundo`.
- **P46-P47 (población y empleo, trimestrales, regionales, satélite)**: en II.6.
- **Notas al pie**: se conservan la 1 (neutralidad), la 2 y la 4 (Nobel, con la de Kuznets y Nathan
  del 3.A.31/3.B.11), la 6, la 13 (alquiler imputado), la 14 (volumen frente a cantidad), la 16
  (corregida), la 24 (PNB → RNB) y la 26 (pensiones). Integradas en el texto: 5, 7-11, 15, 17, 19-21,
  23, 25, 27-29, 31. Fuera: 3 y 18 (sustituidas), 12 (una frase), 22 (sueldo/salario), 30 (error).

- **Parte 2**: nota al opositor de 2.5.2 (P9, «no explayarse… 3.A.31»): cumplida y fuera. Bibliografía
  (P57-P59): fuera «Tema ICEX-CECO», «Tema Juan Luis Cordero Tarifa», las rutas `file:///` y quia.com;
  las obras del Word se conservan (Muñoz Cidad et al., FMI 2013, SEC 2010 con su anexo A «muy
  explicativo», Lequiller y Blades) en el anexo `anexo:lecturas`, con el enlace genérico al simulador.
  Anexos 4, 5 y 8 e imágenes 18 y 19 (P35-P37) → `tab:cuentas-corrientes`, `tab:cuentas-acumulacion` y
  `tab:sinoptica`; imagen 5 (P29) → viñetas de la RNDB y la RNDBA; imagen 7 (P38) → `tab:mcs` con la
  cita de Cardenete y Moniche (2001); imágenes 15 y 16 (P32-P33) → `tab:cei` esquemática. Enlaces del
  Word (D-13, CRITERIOS §4): los 2 vídeos se conservan (Prados de la Escosura en la caja del anexo F;
  VisualPolitik en nota, con Chen et al., 2019, al lado); IGAE (2014) y Muriel de la Riva (2015), con
  su dirección nueva. Notas 18 (Plan Marshall) y 30 fuera; 32 conservada.

## 4. Datos actualizados

Todos de `propuestas-datos.md` (consulta del 11/11/2026, doble comprobación que cuadra salvo lo
anotado); entradas en `datos-actualizables.yaml`.

| Dato | Antes | Ahora | Fuente (clave) | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Avance del PIB | — | 3T2026: +0,6 % trimestral (30/10/2026) | INE2026avCNTR3T26 | https://www.ine.es/dyngs/Prensa/avCNTR3T26.htm | 11/11/2026 | 3.A.42 |
| Nuevo SEC | — | Propuesta a finales de 2026; cambios desde 2030 (V5) | Eurostat2026ESA2030, Verrinder2026SCN2025 | https://ec.europa.eu/eurostat/web/esa-2010 | 11/11/2026 | BCE (3.B.11): «finales de la década» |
| PIB por las 3 vías, 2025 | Imagen sin cifras | 1.690.012 millones; las 3 vías cuadran (V14) | INE2026CNA2025, Eurostat2026nama10gdp, Eurostat2026nasa10nftr | https://www.ine.es/dyngs/Prensa/CNA2025.htm | 11/11/2026 | INE, nota CNA 2025 |
| PIB y deflactor 2025 | — | +2,6 % y +3,0 % (V13) | INE2026CNA2025 | https://www.ine.es/dyngs/Prensa/CNA2025.htm | 11/11/2026 | 3.A.9, 3.A.42 |
| Participación del trabajo | 62 % / 66 % sin fuente | 48,4 % y 56,6 % ajustada (V19) | Eurostat2026nama10gdp, CE2026AMECO | https://ec.europa.eu/eurostat/databrowser/view/nama_10_gdp/default/table | 11/11/2026 | 3.A.45 |
| RNB frente a PIB | — | RNB > PIB en un 0,2 % (V18) | INE2026CNA2025, Eurostat2026nasa10nftr | https://www.ine.es/dyngs/Prensa/CNA2025.htm | 11/11/2026 | INE |
| RNDB y ahorro nacional | — | 1.679.739 millones; ahorro 25,0 % del PIB | Eurostat2026nasa10nftr | https://ec.europa.eu/eurostat/databrowser/view/nasa_10_nf_tr/default/table | 11/11/2026 | 3.A.38 |
| Capacidad por sectores | — | Nación 4,3 %; hogares 2,8; IF 2,7; SNF 1,2; AAPP −2,4; 2007: −9,0 (V16, V12) | Eurostat2026nasa10nftr | https://ec.europa.eu/eurostat/databrowser/view/nasa_10_nf_tr/default/table | 11/11/2026 | INE tabla 80333; 3.B.11; 3.A.39 |
| Cuenta financiera | Cuadro de 2018 | 2025 por sectores, B.9F 85.151 frente a B.9 72.218 (V11, V17) | Eurostat2026nasa10ftr | https://ec.europa.eu/eurostat/databrowser/view/nasa_10_f_tr/default/table | 11/11/2026 | nasq_10_f_tr; BP del BdE (3.B.11) |
| Contribuciones 2025 y 3T2026 | — | 2025: PIB 2,6 %, nacional 3,4 pp, externa −0,8; 3T2026: 2,7 % interanual (V15) | INE2026CNA2025, INE2026avCNTR3T26, Eurostat2026nama10gdp | https://www.ine.es/dyngs/Prensa/avCNTR3T26.htm | 11/11/2026 | Eurostat CON_PPCH_PRE |
| Revisión estadística | — | RE-2024 elevó el PIB de 2023 un 2,5 %; la siguiente, en 2027 (V7) | INE2024CNARE2024, INE2026avCNTR3T26 | https://www.ine.es/dyngs/Prensa/avCNTR3T26.htm | 11/11/2026 | INE |
| Registros contables | — | Cerca de 1,35 millones de empresas en la CNA 2025 (V31) | INE2026CNA2025 | https://www.ine.es/dyngs/Prensa/CNA2025.htm | 11/11/2026 | Sin segunda fuente (solo la nota del INE) |
| IDH | — | España, puesto 28 en 2023 (V29) | PNUD2025IDH | https://hdr.undp.org/content/human-development-report-2025 | 11/11/2026 | 3.B.28 |
| Más allá del PIB | Davos 2018 | Panel de 31 indicadores de la ONU (2026) | ONU2026BeyondGDP | https://www.un.org/sites/un2.un.org/files/high-level_expert_group_on_beyond_gdp_final_report.pdf | 11/11/2026 | UNCTAD y nota de la ONU |
| Umbral de los fondos estructurales | — | 75 % del PIB per cápita (PPA) medio de la UE-27, regiones NUTS 2 | RegUE2021Disposiciones (art. 108.2.a) | https://eur-lex.europa.eu/eli/reg/2021/1060/oj | 11/11/2026 | Leído en EUR-Lex el 11/11/2026; el Fondo de Cohesión usa la RNB per cápita (< 90 %) |

## 5. Contenido añadido

- **Magnitudes y flujo circular** (I.1.1, C5 condensado): definición de magnitud, flujo circular
  con el gráfico `triangulo-pib`, las 3 vías en una economía sencilla, S ≡ I, y la cadena de saldos
  `eq:cadena-agregados` (función clave). Orden tomado de Tebar (A.30, apartado 2) y Luis de Fuentes
  (3A_26, apartado I), redactado de nuevo.
- **Interior/nacional y bruto/neto** al final de I.2.3 (K13).
- **PIB por las 3 vías** como función clave, idéntica en forma a la 1D01 con RA (K16), y la lectura de
  C, I (3 partidas), G y X − M (3.A.33, 3.A.34, 1D01).
- **Identidad ahorro-inversión por sectores** (`eq:ahorro-inversion`, K19), B.9 de las AAPP como
  déficit (3.A.39), caja «Dos cuentas de capital» (K20).
- **Datos de España** de 2025 en cajas grises y el gráfico `capacidad-financiacion-sectores-espana`.
- **Cuentas del resto del mundo** con el signo cambiado y su equivalencia en la balanza (C25/K23).
- **II.6**: CEI, marco *input-output* en un párrafo, población y empleo (SEC, cap. 11), trimestrales,
  regionales (umbral del 75 % de los fondos de cohesión) y satélite.

- **Parte 2**: III.1 (volúmenes encadenados, deflactor, `eq:contribuciones`, no aditividad, lectura,
  PIB per cápita y PPA; gráfico `contribuciones-pib-espana`); III.2 (quién elabora qué, fuentes,
  revisiones, alta frecuencia y *nowcasting*); III.3 (ventajas, limitaciones, indicadores
  alternativos); anexos de no aditividad con ejemplo (`anexo:encadenados`), de CEI y MCS, y de
  lecturas.

### Estado de las propuestas (parte 1)

- **Contenido**: C1 no (estructura de coherencia por decisión del coordinador: las magnitudes van
  dentro de I.1, no como I.1 nuevo, y III es «Uso y límites»); C2 sí (cuentas en T al anexo); C3 sí
  (con las claves de datos y el avance del 3T2026); C4 sí; C5 sí, condensado (sin `eq:pib-gasto`
  como función clave, para no duplicar `eq:pib-tres-vias`; sin $(T-G)$; el gráfico `flujo-circular`
  se funde con el triángulo de K5); C6 sí (2029 → 2030, manda datos; la RE-2024 pasa a III.2); C7-C11
  sí; C12 sí; C13 sí (`tab:agregados` al cierre de II.2); C14-C16 sí sin tablas en T (al anexo; la
  tabla de las 3 vías se sustituye por `tab:pib-espana-2025` con datos); C17 a III.1 (parte 2); C18-C26
  sí; C28-C31 condensadas en II.6 (K24; el SCN 2025 con detalle, en la parte 2).
- **Coherencia**: K1-K4 sí; K5-K6 sí (instrucciones del vídeo, abajo); K9 en parte (sin el hecho de
  Grecia de 2009, que no comprobó datos y no encaja con el refrán del coordinador); K10-K14 sí; K15
  sustituida por el patrón de 4 rótulos del coordinador; K16-K22 sí; K23 como tabla (D-14); K24 sí;
  K29-K31 sí en la parte 1; K42: pegatinas «gota a gota se llena la bota» (I.2.1) y «no es de donde
  naces, sino de donde paces» (residencia); las de III, en la parte 2.
- **Datos**: todas aplicadas (V1-V31, B1-B4), con estos matices: V8, V10, V22 y V25 sin cambio, con cita;
  V20 y V23 como en el 3.A.31/3.B.11; V29 (Davos 2018) solo en el anexo, como dato histórico; V30 dice
  «algo menos de 2 puntos»; B4 (la cascada con cifras) se usa en el texto, no como tabla aparte; B3, en
  la caja de la cuenta financiera por sectores (sin el detalle por instrumentos).
- **Parte 2 (contenido)**: C17 sí en III.1 (con la notación vectorial del 3.A.9 y de la 1D01); C27 sí;
  C28-C31 en II.6 y en el anexo A; C32 sí, más corto (sin el «trimestre en curso y los 2 siguientes»
  del MIPred, que no se pudo comprobar); C33 sí, con las claves de datos y el Davos al anexo; C34-C35
  sí (opinión de K28 y C35 fundidas); C36 sí (2029 → 2030); C37 sí (`anexo:scn2008`, no
  `anexo:sec-scn`); C38 sí; C39 sí, con el anexo 3 del Word; C40 sí (2 tablas en T y la sinóptica;
  códigos B.4g, B.101-B.103 y B.90 del cap. 8); C41 sí; C42-C43 sí.
- **Parte 2 (coherencia)**: K8 con un anexo G de lecturas y test; K25-K28 sí; K42: «a buen entendedor,
  pocas palabras bastan» (III.2) y «no solo de pan vive el hombre» (III.3).

## 6. Coherencia

- **Mismas fórmulas y etiquetas**: `eq:pib-tres-vias` con la forma de la 1D01 (`sec:pib`) salvo las
  letras (RA y «impuestos − subvenciones» en palabras; C2 de coherencia); `eq:rndb` con la forma del
  3.B.11; S = RNDB − C − G como el 3.B.11; precios básicos y de adquisición con las palabras del
  3.A.31 y su gráfico `valoracion-precios` copiado sin cambios; residencia, sectores y partida
  cuádruple como el 3.B.11; cifras de 2025 idénticas a las del 3.A.9, 3.A.38, 3.A.39, 3.A.45 y 3.B.11.
- **Contradicciones (no se tocan los otros temas; para `canon/pendientes-coherencia.md`)**:
  - C1: el 3.B.11 escribe $(T-G)$ con $G$ = gasto público total en la misma ecuación en que $G$ es el
    consumo público; el 3.A.30 escribe $(S_G-I_G)$ con nota.
  - C2: la 1D01 usa $W$ (total) y $(T-Sub)$ en el PIB por la renta; el canon reserva $W$ para la
    remuneración por asalariado.
  - E2 de datos: la 1D01 da «RNB < PIB: deudor neto» como regla; en 2025 España, deudora neta, tiene
    RNB > PIB (el 3.A.30 lo dice).
- **Unificación de claves bibliográficas (para el canon)**:
  - Reglamento 549/2013: el 3.A.30 usa `SEC2010` como **@online** con `note` (la forma del 3.B.11 y
    del 3.A39), porque `@legislation` sale vacía en biblatex (1D01 y 3A31 la tienen así). Proponer
    `SEC2010` @online en todos y retirar `UE2013SEC2010` (3A09) y `RegUE2013SEC2010` (3A34).
    `RegUE2023SEC2010` y `RegUE2011Ambientales`, también @online.
  - `Eurostat2026nama10gdp` (1D01, 3A31, 3B11 y aquí) frente a `Eurostat2026Nama10gdp` (3A08, 3A09,
    3A33, 3A38, 3A45…); `INE2026CNA2025` frente a `INE2026CNA` (3A28, 3B23); `CE2026AMECO` con títulos
    distintos según el tema. Unificar en `/actualizartemario`.
  - Precios básicos: se cita `Eurostat2013SEC2010` (la del 3.A.31) donde la frase es la del 3.A.31, y
    `SEC2010` en el resto.

## 7. Dudas abiertas

- **A30-01 · Estructura de I**: las magnitudes y el flujo circular van como I.1.1, dentro de «Concepto y
  características generales» (coordinador), en lugar de un I.1 nuevo (contenido D-02). Así se
  conservan los 2 títulos de segundo nivel del Word.
- **A30-02 · Refrán del enganche**: «A ojo de buen cubero» (contenido D-06, coordinador), libre en todo
  el temario; alternativa de coherencia, «Cuentas claras, amistades largas» (choca con la pegatina del
  3.A.41).
- **A30-03 · Nombre del nuevo SEC**: «SEC 2030» (web de Eurostat) frente a «SEC 2026» (título de la
  presentación de junio de 2026). El texto dice «que Eurostat llama provisionalmente SEC 2030».
- **A30-04 · Letras del PIB por la renta**: RA y «(impuestos − subvenciones)_prod. e import.» en lugar
  de $W$ y $(T-Sub)$ de la 1D01 (C2).
- **A30-05 · $(S_G-I_G)$ en `eq:ahorro-inversion`** en lugar del $(T-G)$ del 3.B.11, con nota (C1).
- **A30-06 · Cuatro funciones clave** (cadena, 3 vías, ahorro-inversión, contribuciones), una más que
  las 3 de K6: la cadena es la propuesta de contenido para la ficha nueva del canon.
- **A30-07 · Sin cuentas en T en el cuerpo**: las 11 van al anexo (coordinador); el cuerpo da cada
  cuenta con 4 rótulos y remite al anexo.
- **A30-08 · Meade y Stone «animados por Keynes»**: la autobiografía Nobel de Meade da las fechas y el
  Gabinete de Guerra; el papel de Keynes es el del Word (nota 1), en forma suave.
- **A30-09 · Umbral del 75 % de los fondos de cohesión**: citado con el Reglamento (UE) 2021/1060
  (clave nueva `RegUE2021Disposiciones`, art. 108), que el agente de datos dejó como ⟨verificador⟩;
  comprobar el artículo.
- **A30-10 · Gutiérrez Hernández (2021)**: sin nombre de pila (se cita como autor corporativo); el
  documento no está publicado.
- **A30-11 · Cuenta financiera del Banco de España**: leída en Eurostat (`nasa_10_f_tr`); bde.es no
  respondió (D1 de datos). Mirar a mano antes de publicar.

- **A30-12 · MIPred**: airef.es no respondió (tampoco hoy); se cita el modelo con la portada de la
  AIReF, sin la descripción de sus horizontes. Spain-STING sí se comprobó (Crossref).
- **A30-13 · Davos 2018**: contenido proponía quitarlo (D-10); se conserva en el anexo F, corregido,
  como dato histórico, para no perder contenido del Word.
- **A30-14 · Códigos del SEC en las tablas del anexo C**: resuelta; códigos contrastados con el
  Reglamento 549/2013 en EUR-Lex: B.4g, B.101-B.103, B.90 y B.9F (§5.17).
- **A30-15 · Año de referencia de los volúmenes**: no se da (la propuesta decía 2021 y el agente de
  datos no lo comprobó).
- **Control de calidad (11/11/2026)**: patentes → marcas en la caja de las 2 cuentas de capital; PIB en
  PPA para la cohesión y RNB per cápita en PPA para el IDH; `tab:cei` con el orden del cuadro 8.18 y «·»;
  cajas de las 2 cuentas de capital y de la cuenta financiera irrompibles; pregunta «¿Pueden unas pocas
  cifras…?» en la problemática; 2009: −6,6 puntos; Nobel de Meade (1977) en la nota 2; nombres oficiales
  de V.I y V.II; deflactor con `\dfrac`; `\clearpage` antes del anexo C (la tabla de las cuentas corrientes ya no deja la A-2 medio vacía).
- **A30-16 · Remisiones a la guía del dictamen**: `\vertema{1D01}` no enlaza (la 1D01 no está en
  temario.json); se nombra «el dictamen de coyuntura» sin enlace. Las cuentas del anexo C llevan el
  prefijo «C.» (C.II.2…) para que no parezcan remisiones a apartados.
- **A30-09 resuelta**: el umbral del 75 % se ha comprobado en EUR-Lex (art. 108.2.a del Reglamento
  2021/1060); el texto habla ahora de los fondos estructurales (el Fondo de Cohesión usa la RNB).

## 8. Instrucciones para el vídeo

- **Introducción** (sin pizarra, modo guion): enganche con el refrán «a ojo de buen cubero», el encargo
  del Senado de 1932 y el informe de Kuznets de 1934, y el contraste con el avance del INE a 30 días
  (3T2026, +0,6 %); el aforismo «no se puede gestionar lo que no se puede medir» detrás. La idea final
  (parte 2) retoma el refrán.
- **Bloque I** (rejilla de 2 celdas): a la izquierda, el **triángulo** `triangulo-pib` por capas 1-5
  (vértices, flechas, «PIB» en el centro) mientras se cuenta el flujo circular; debajo,
  `eq:cadena-agregados` como función clave (se conserva hasta el final de II). A la derecha, en I.2,
  la fila de sectores «S.11 S.12 S.13 S.14 S.15 | S.2» escrita a mano (el árbol `sectores-sec` va de
  apoyo) y la escalera de valoración `valoracion-precios` de apoyo. Pegatinas, una vez y junto a su
  concepto: «gota a gota se llena la bota» (flujos y stocks) y «no es de donde naces, sino de donde
  paces» (residencia).
- **Bloque II** (rejilla «30|70»): a la derecha, la **cascada** `sucesion-cuentas`, construida capa a
  capa a la vez que se cuentan las cuentas (capa 1 en II.1; capas 2-8 en II.2; 9-12 en II.3; 13-14 en
  II.4; 15, la columna del resto del mundo con el «−», en II.5); nunca se escribe 2 veces. A la
  izquierda, el triángulo conservado: en II.2.1 se escriben junto a sus vértices las 3 fórmulas de
  `eq:pib-tres-vias` (capas 6-8 del triángulo), y en II.3, bajo la caja de B.9 de la cascada,
  `eq:ahorro-inversion`. De apoyo (no se escriben): `tab:pib-espana-2025`, `tab:agregados`,
  `capacidad-financiacion-sectores-espana`, `tab:cuenta-financiera-2025` y `tab:resto-mundo`.
- **Funciones clave que se conservan** al pasar de II a III: `eq:cadena-agregados`,
  `eq:pib-tres-vias` y `eq:ahorro-inversion`; se borra la cascada.
- Nada de esto va en el texto del tema (CRITERIOS §2, 11/11/2026).
- **Bloque III** (rejilla «35|65»): a la izquierda, `eq:contribuciones` (función clave, se escribe
  entera) con `eq:pib-tres-vias` conservada encima; a la derecha, un boceto de barras apiladas con la
  línea del PIB, por partes (barras de la demanda interna, externa, línea). De apoyo: el gráfico
  `contribuciones-pib-espana`, el ejemplo numérico (2,4 − 0,6 = 1,8) y la tabla del anexo E. III.2 y
  III.3, en modo guion (sin pizarra), con las pegatinas «a buen entendedor, pocas palabras bastan» y «no
  solo de pan vive el hombre».
- **Conclusión** (sin pizarra): empieza por «En conclusión,»; la idea final vuelve al refrán («ya no se
  hace la política económica a ojo de buen cubero») y responde a la pregunta del principio.
