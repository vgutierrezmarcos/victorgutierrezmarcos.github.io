# Revisión de 1D01 · Guía para el dictamen de coyuntura económica

Editor de /revisartema, 23-24/10/2026. Escrita en 4 partes (método y perfil cíclico; mercados de factores y competitividad; sector exterior,
políticas y recomendaciones; anexos). Este informe recoge las 4.

## Aportaciones de la guía v24 (25/10/2026)

Del inventario `_trabajo/v24-comparacion.md` se ha metido en el **cuerpo** todo el apartado (b) pedido, cada cosa en su
bloque y con fuente propia (no se cita la guía de otro preparador); nada del apartado (c).

- **Método (introducción y I.4)**: «los gráficos no suelen ser gratuitos» y «ser perspicaz, no descriptivo», con un cuadro
  «Ejemplo de redacción: descriptivo frente a perspicaz» antes del del motor del crecimiento.
- **II.2**: fuentes de financiación (crédito bancario, valores, capital riesgo, banca pública) (encuesta SAFE del BCE).
- **III.1**: por qué es mala la deflación de demanda (aplazamiento de compras, deflación por deudas de Fisher, tipo real
  con tipos en el límite) y la «buena» de oferta (Bordo y Filardo, 2005). Antes solo estaba la recomendación con deflación.
- **III.2**: nuevo párrafo «Efectos de una devaluación para corregir el déficit exterior» (Marshall-Lerner, curva J,
  casos en que no mejora, efecto inflacionista con sus 4 determinantes, deuda en divisas, paro friccional, empleo según la
  intensidad factorial; Krugman, Obstfeld y Melitz; Campa y Goldberg; pecado original).
- **IV.1**: tasa de cobertura y comercio inter e intraindustrial (índice de Grubel y Lloyd).
- **IV.2**: factores de la inversión directa y de cartera, huida hacia la liquidez o la seguridad, falta de consenso sobre
  abrir la cuenta financiera (FMI, 2012); las partidas de la balanza son **flujos**; ajuste con tipo fijo (reservas y
  agregados monetarios, riesgo de crisis cambiaria) o flexible (tipo de cambio), sin la frase errónea de que «la balanza
  estaría siempre en equilibrio».
- **V.1**: desequilibrios a vigilar: liquidez, monetización y *liquidity crunch* (Taylor y Williams, 2009).
- **V.3**: aviso de deuda bruta frente a neta y tipo a corto frente a tipo medio de la deuda viva (FMI, Fiscal Monitor
  2018; Reinhart et al., 2003); gasto corriente frente a gasto de capital (SEC 2010).
- **VI**: recomendaciones para el déficit exterior según su causa (precio, no precio, entradas de capital con controles
  temporales y excepcionales; visión institucional del FMI).
- Bibliografía: 8 entradas nuevas (BCE2026SAFE, Fisher1933, BordoFilardo2005Deflacion, KrugmanObstfeldMelitz2018,
  FMI2012VisionInstitucional, GrubelLloyd1975, TaylorWilliams2009, FMI2018FiscalMonitor).

**Lo que se ha llevado a los anexos para compensar (≈ 2 páginas), con remisión desde el cuerpo**: los gráficos de la
inflación de la zona del euro, de los tipos y el balance del BCE, de la curva de Beveridge, de las 4 fases del ciclo y de
los cuadrantes del *policy mix* (a los anexos de series y de gráficos de lectura); la ley de Okun y la curva de Phillips
(al anexo de casos, con una línea en el cuerpo); la volatilidad y el comovimiento del consumo y la inversión, condensados
con remisión a la tabla de hechos estilizados; el ejemplo del FMI para España de la recomendación de gasto (está en el
anexo de España); y el texto largo de «rigidez del sistema financiero» de VI, que ya está en V.2.

Resultado: **cuerpo 50 páginas**, anexos 39, bibliografía 9 (98 en total). `verificar-tema.py 1D01`: 0 errores,
11 avisos (cifras sin cita en anexos y guion/vídeo pendientes). Para evitar falsos «títulos al pie», en el esquema de la
introducción los números de apartado van sin punto y la función de importaciones va en línea.

## Segunda vuelta 24/10/2026

Aplicados los comentarios de Víctor del 24/10 (`_trabajo/comentarios-victor-24oct.md`), CRITERIOS §7 y §11 actualizados e
inventario `_trabajo/recuperar.md` (R-01 a R-122). Fuente `1D01.tex` + `1D01.bib` (161 entradas) y `1D01.lyx` sincronizado
por `construir-tema.py`. Compila sin errores; `verificar-tema.py 1D01`: **0 errores, 11 avisos** (9 «cifra sin cita» en
anexos, que son fechas de exámenes o datos del recuadro de Beveridge ya citados en su párrafo, y guion y vídeo pendientes).

### Páginas

- **Cuerpo: 50 páginas** (introducción con esquema, I-VI y conclusión). **Anexos: 37** (A-J). **Bibliografía: 9.** Total 96.
- Anexos: A El ejercicio y el método · B Indicadores y umbrales · C Qué se ha preguntado · D Expresiones (D.1 Párrafos
  modelo por bloque) · E Análisis de casos frecuentes · F Lectura de series · G Cálculos tipo · H FMI (programación y
  programas) · I España · J Temas.

### Qué se ha hecho, punto por punto

- **Método al anexo A**: «El ejercicio y el método» sale del cuerpo entero (etiquetas `anexo:metodo`, `anexo:tiempo`,
  `anexo:leer`…), con la **matriz completa de 9 columnas** de la guía antigua (tabla 8, R-05), la tabla antigua de minutos
  por número de preguntas (tabla 5, R-03, con sus supuestos), las normas de la sala del examen de 2022 (R-01, con el pie
  corregido: era 2022, no 2021), el matiz «no suelen ser países de renta baja, sí emergentes» (R-02), «releer cada
  pregunta» y «si el dictamen es libre, anunciar la estructura», y «dónde practicar y leer ejemplos» (R-106).
- **Lo de exámenes, en notas al opositor**: todas las menciones a años de examen del texto corrido («se preguntó en…»,
  «(2021)», «(2016, 2019 y 2024)») pasan a 14 recuadros `notaopositor`, uno por bloque. Ninguna idea teórica queda atada a
  un año suelto; los efectos no keynesianos ya no dicen «(2022)».
- **Esquema (índice) al final de la introducción**, numerado desde I (Perfil cíclico = I … Recomendaciones = VI), con
  enlaces a cada apartado y el segundo nivel, inspirado en el índice de la pág. 2 del PDF antiguo (R-04).
- **Reparto del tiempo**: en la introducción, 4 reglas ligeras y orientativas (no se sabe cuántas preguntas habrá; ~10 %
  de lectura y ~5 % de repaso; más tiempo a las preguntas donde están los retos reales de la economía; ninguna en blanco).
  La regla, la tabla por convocatoria y la tabla antigua, en el anexo A.3.
- **Balanza de pagos desarrollada** (R-80): 2 fórmulas recuadradas (`\funcionclave`): la identidad completa con llaves
  (CC + CK = capacidad/necesidad; + EO = CF = ID + IC + D + OI + ΔR), numerada como `eq:identidad-bp`, y la cadena
  CC = (X − M) + RP + RS = (Y − A) + RP + RS = S − I = (S_P − I_P) + (T − G), con su lectura en palabras. Nota 33 antigua
  reescrita con la forma alternativa bien explicada.
- **IPC y deflactor** (R-68 a R-73): 2 cuadros grises paralelos, «El IPC, un índice de Laspeyres» y «El deflactor del PIB,
  un índice de Paasche», con qué compara cada uno, la fórmula con sumatorios (y en vectores), cesta fija o variable,
  encadenamiento (INE base 2025) y el sesgo. **Nota 30 corregida**: el IPC no recoge que los consumidores sustituyen los
  bienes *más caros por otros más baratos* (la antigua lo decía al revés). Las 2 diferencias entre índices, en lista.
  Índices especializados (IPP/IPRI, IPRIX/IPRIM, costes laborales), las 3 familias de subyacente y el triángulo de Gordon.
- **Política fiscal** (págs. 19-20 antiguas, R-91 a R-101, R-119): consenso y política discrecional; las 5 variables del
  saldo en lista con su definición; tono; ejemplo del Consejo Fiscal Europeo; **efectos no keynesianos** con texto completo,
  Giavazzi y Pagano (1990) y la evidencia posterior (Guajardo et al., 2014), sin años de examen; **la inflación y las
  cuentas públicas** punto por punto (ingresos, intereses, gasto indexado, compras, denominador) y el esquema del FMI
  «Repercusiones inmediatas de la inflación en las finanzas públicas» **redibujado como tabla** (tabla 1: 4 canales → 4
  efectos); otros análisis: nivel de ingresos y gastos con el esquema de la ficha 4 (más impuestos / ingresos no
  tributarios), estabilizadores automáticos ($b-b^{ca}=\varepsilon\cdot\mathrm{OG}$), deuda a corto, vida media, deuda
  regional y corresponsabilidad, calidad crediticia.
- **Tabla de calificaciones** (antigua tabla 11, hoy tabla 14, anexo B): S&P, Moody's y Fitch en las primeras columnas;
  DBRS en cursiva y discreta; Scope en la fuente; una fila por escalón de AAA a D, cada celda en una línea, con el bloque
  (inversión, especulativo, impago) y el nivel del Eurosistema.
- **Nuevo V.2 «Estabilidad financiera y política macroprudencial»** (R-50 a R-62, R-118, R-120), justo después de la
  monetaria: endeudamiento y ciclo financiero (umbrales del PDM, brecha crédito-PIB, bucle bancario-soberano); solvencia
  (APR explicados, CET1/Tier 1/total, *fully loaded* y *phased-in*, apalancamiento, regla antigua del 12 % con su
  advertencia); calidad de los activos (dudosos explicados); liquidez (LCR, NSFR, LTD alta y baja); rentabilidad (por qué
  importa, ROE/ROA, eficiencia, coste del capital); riesgos (vivienda, crédito, divisas, tipos bajos, bolsa, externos);
  regulación microprudencial (Basilea III y sus 3 pilares, MREL/TLAC); supervisión y unión bancaria (MUS, MUR, garantía
  de depósitos pendiente; euro de 21); política macroprudencial (colchones, LTV/LTI/DSTI, fase alcista y bajista con
  «operar por debajo de los colchones»). Nota al opositor: pregunta propia (2020, 2022) o coletilla de la monetaria
  (2023, Meridia). En II.2 «Mercado de capitales» queda el capital físico (R-49) y el crédito y la financiación como
  factor, con remisión a V.2.
- **Anexo C**: quitada la transcripción de los exámenes; queda hasta la tabla de bloques por año (hoy tabla 16).
- **Cálculos (anexo G)**: tabla visual de las fórmulas imprescindibles por bloque (la del A.5 antiguo, con la fórmula 10
  corregida: el CLU real es la participación salarial; y la 14: $\mathrm{PIIN}_t=\mathrm{PIIN}_{t-1}+\mathrm{CF}_t+
  \mathrm{OV}_t$), y cuadros por bloque con la fórmula recuadrada, sus términos y un ejemplo: la derivación de las
  contribuciones paso a paso (R-13), brecha y potencial, tasas trimestrales, deflactor, tipos reales, salario real,
  índices, PAT-CLU-margen (con tabla de ejemplo), ahorro e inversión, PIIN, exportaciones, saldos y esfuerzo, saldo
  estabilizador. Fuera «desde 2022 no se piden cálculos» (y el «sin cálculos» de la tabla de formatos).
- **Recuperado de la guía antigua** (además de lo anterior): A.8 en I.1 «Conceptos generales: el PIB» (3 enfoques con
  fórmulas, RNB y RNDB, 5 problemas de medida, R-115); funciones del consumo, la renta disponible, la inversión, las
  exportaciones, las importaciones y la sostenibilidad con sus signos (R-17, R-24, R-30, R-87); SEC 2010 de la inversión
  (R-22, en nota); nota 12 de la curva de tipos completa (R-19); nota 17 con la hipótesis de inflación de los *swaps*
  (R-26); nota 18 completa (R-27); definiciones del mercado de trabajo, fuga de cerebros, pleno empleo con la OIT, cadena
  CLU-beneficios-bolsa-precios, usos de los CLU nominales, Calmfors y Driffill (R-40 a R-46); nota 27 de Beveridge como
  lectura de la curva española 1994-2022 (R-48); RRI, preguntas guía del saldo, cuenta de capital, reservas, monedas y
  valoración de la PIIN (R-31, R-82 a R-88); tipos de interés (R-89); políticas de oferta por tipo de paro con su
  diagnóstico (R-103, en V.5); recomendaciones que faltaban (R-36, R-105, R-121, R-122); anexos A.1 y A.3 completos
  (tipos de datos, tendencias, frecuencia, cointegración, los rasgos del comovimiento; proporciones, porcentajes, índices,
  tasas; R-107, R-110), A.4 (R-111) y el contexto 2020-2022 de A.6 (R-113, con la fecha de recuperación corregida).
- **Ejemplos de redacción** (22 entradas de la antigua): `tcee.sty` no tiene entorno propio, así que van en cajas grises
  `anotaciones` con el rótulo en negrita «Ejemplo de redacción: …», con años y cifras genéricos (20xx). Corregidos al
  recuperarlos: tipo real «contractivo» con el nominal en cero (ahora: el tipo real cercano a cero no recoge todo el
  estímulo; R-90), «Numitor» → «esta economía» (R-90, R-99), coste del capital frente a «tipos de mercado» (R-52), punto
  iv) vacío (R-52, ahora liquidez), erratas. **15 cuadros en el cuerpo y 11 en el anexo D.1** (ver abajo).
- **Gráfico de comovimientos**: pie y ancho nuevos (`\textwidth`, panel d del Conference Board) según
  `pies-graficos-24oct.md`. Ningún pie nombra colores, así que no hubo que ajustarlos a la paleta.
- `seo.json` al día (estabilidad financiera, balanza de pagos, IPC y deflactor).

### Lo que se ha llevado a los anexos para no pasar de 50 páginas (con remisión en el cuerpo)

- Tablas de consulta: indicadores del sistema financiero, Basilea III, ratios de la banca (con una columna nueva de 2021,
  R-61) y calificaciones → anexo B.
- Gráficos de lectura: consumo-renta-ahorro, PIB y comercio mundial, empleo y horas, PIB por persona en edad de trabajar,
  impulso fiscal y el gráfico de la inflación en las cuentas públicas (la tabla del FMI sí está en el cuerpo) → anexo F.
- Casos concretos → anexo E: un sector dominante (petróleo), demografía/visados/salario mínimo, aranceles, la curva de
  Beveridge española, los fondos europeos en la balanza de pagos, el brote de inflación (resistencia, cambio de tendencia,
  «última milla») y el detalle de las reglas fiscales (en el cuerpo queda un resumen de 2 líneas).
- Ejemplos de redacción largos → anexo D.1: frase del FMI de 2022, sector dominante y tejido productivo, el párrafo del
  BCE sobre el mercado de trabajo, demanda de trabajo y paro persistente, exportaciones e importaciones, relación con el
  ciclo de la monetaria, endeudamiento, banca bien capitalizada, macroprudencial con tipos bajos, tono fiscal con déficit
  alto y paquetes de estímulo.
- El programa del FMI (antiguo VI.3) → anexo H.
- Para evitar huecos, la tabla de recomendaciones y el gráfico de tipos del BCE van con `[tbp]` (pueden moverse a la
  página siguiente); el resto, `[H]`.

### Dudas nuevas para Víctor

1. **Ejemplos junto al indicador frente a las 50 páginas**: para no pasar del límite, 11 ejemplos largos están en el
   anexo D.1 con remisión. ¿Prefiere subir el límite (todos en el cuerpo serían unas 53 páginas) o así vale?
2. **Tablas de la banca y de calificaciones en el anexo B** (el texto de regulación sí está en el cuerpo, V.2). ¿Las
   quiere en el cuerpo aunque haya que mover otra cosa?
3. **Anexo E de casos** (petróleo, aranceles, demografía, reglas fiscales en detalle, brote de inflación): ¿le parece bien
   sacarlos del cuerpo?
4. **Método del Banco de España para el tipo real a largo** (nota 17 antigua: *swaps* de inflación a 15, 10 y 5 años
   según el préstamo): no he podido comprobar que siga usando esos plazos; en la nota queda la idea sin los plazos.
5. **Regla del 33 % de esfuerzo en vivienda**: se mantiene como orientativa, sin fuente (junto a la de sobrecarga de
   Eurostat, 40 %).
6. **Curso del FMI en español (edX)**: el enlace de la guía antigua da error 404; se mantiene la referencia con la nota
   «enlace de la guía anterior». La entrada de Bankinter no tiene fecha (la web bloquea la consulta automática).
7. **Imagen 2 antigua** (descomposición del consumo por fuentes de renta, BCE): no se ha rehecho; ¿pedimos un gráfico
   nuevo con las cuentas sectoriales de Eurostat?
8. **Vídeos de YouTube del anexo A.6 antiguo**: no se han recuperado (no se sabe qué son).
9. La numeración de tablas ha cambiado: la antigua «tabla 11» es la 14 y la «tabla 13» es la 16.


## 1. Resumen

- Guía nueva en LaTeX (`1D01.tex`, sin `\minutos`, CRITERIOS §11): **cuerpo de 44 páginas** (introducción, método,
  perfil cíclico, mercados de factores, competitividad, sector exterior, políticas, recomendaciones y conclusión),
  **20 de anexos** (A-H) y 8 de bibliografía (149 entradas).
- Aplicadas casi todas las propuestas (C, K, V) y las decisiones de Víctor D-01 a D-05: reparto del tiempo como regla
  con tabla de convocatorias, umbrales oficiales y orientativos separados, anexo de España reescrito, $Y^p$.
- Corregidos unos 60 errores del Word (PIIN al revés, déficits gemelos, tono monetario y fiscal, margen, CLU, IPC
  frente a deflactor, hechos estilizados, tasa de actividad…) y resueltas las 22 marcas amarillas y las notas.
- Datos al último dato oficial (BOE de 2025, Eurostat, BCE, Banco de España, ABE, FMI octubre de 2026, PDM de 2025);
  15 gráficos pedidos (8 en el cuerpo, 7 en los anexos) con CSV y «qué hay que ver».
- Compila sin errores ni «??» (PDF de 72 páginas con los gráficos reales: cuerpo de 44); verificar-tema solo pide los
  productos de construir-tema.py.

### Detalle por partes

- Fuente nueva `1D01.tex` (LaTeX de `tcee.sty`, sin `\minutos`, CRITERIOS §11) con introducción breve,
  capítulo I de método (8 apartados) y capítulo II de perfil cíclico (5 apartados), en la estructura K1
  de `propuestas-coherencia.md` ajustada a `decisiones-victor.md`.
- Reparto del tiempo convertido en **regla** según duración y número de preguntas, con tabla de las
  convocatorias de 2016 a 2026 y 10-12′ de lectura (D-02); umbrales no regulatorios marcados como
  orientativos (D-03); PIB potencial con $Y^p$ (D-05).
- Corregidos los errores de concepto de estos capítulos (brecha de producción «tendencial» del FMI,
  inversión y brecha, existencias, consumo público, población joven, equivalencia ricardiana, PMI,
  recesión, umbrales de crecimiento y de país desarrollado) y actualizados sus datos (convocatoria de
  2025, consumo, FBCF, crecimiento y renta per cápita 2025, artículo IV de 2026).
- `1D01.bib` (149 entradas al final; 145 en la parte 1: `bib-datos.bib`, C90 sin duplicados, bibliografía del original y 3 clásicos),
  4 gráficos pedidos y PDF de prueba de la parte 1: 22 páginas (aún sin los gráficos reales).

**Parte 2.** Capítulos III (mercado de trabajo; mercado de capitales: endeudamiento y ciclo financiero,
banca, vivienda, bolsa, macroprudencial) y IV (precios e inflación, tipo de cambio, no precio y aranceles),
en ≈ 13 páginas (el PDF de prueba pasa de 22 a 33 páginas: la parte 1 baja a ≈ 20 al llevar a los anexos
las tablas de temas por bloque y de economía avanzada/emergente). Lo de ampliación (tablas de Basilea y de
ratios bancarios, párrafos modelo, gráficos de horas, empleo y Brent) queda en comentarios «% A ANEXO»
para la parte 4. 2 gráficos nuevos en el cuerpo (Beveridge, IAPC) y 3 pedidos para los anexos.

**Parte 3.** Capítulos V (sector exterior), VI (políticas monetaria, fiscal, *policy mix* y de oferta) y VII
(recomendaciones por desequilibrio y programa del FMI) y una conclusión breve sobre cómo cerrar el
dictamen. El cuerpo termina en la página 44 del PDF de prueba (V-VII y conclusión, ≈ 12 páginas). En la
curva de Phillips de III.1 se usa ahora $U_t$/$U^n$, como fija el canon (§ 6), con una nota que lo
distingue de $u=U/A$ de la EPA (§ 13).

## 2. Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 390-393 y nota 7 (brecha) | OCDE: frente al PIB potencial; FMI: frente al PIB «tendencial» | Un solo concepto (frente al potencial), 2 métodos de estimación: función de producción (Comisión, OCDE, FMI; Havik et al., 2014) y filtro estadístico (Hodrick-Prescott) (C9, K13) |
| l. 407 | «γ Output gap = γ PIB obs. − γ PIB pot.» | $\Delta\mathrm{OG}_t\approx\gamma_{Y,t}-\gamma_{Y^p,t}$, en puntos (K13) |
| Nota 6 | `[ver tema 4.B.5]` (numeración antigua) | `\vertema{4.B.4}` y además 3.A.42, 3.A.45 y 3.A.28 (P61) |
| l. 368-376 y l. 1036 | Tramos 0/1/1,5/3,5 % y «PD: 2-4 %» (contradictorios) | Un solo juego, orientativo: <0, 0-1, 1-2, >2,5-3 %, con el dato del FMI (avanzadas 2,0 %, emergentes 4,5 % en 2025) (C22, V21) |
| l. 1040-1044 | Renta per cápita EE. UU. 50.000 $, Alemania 36.000, España 30.000; primario ~10 % en PD | 90.000, 61.000 y 39.000 $ (2025, FMI); primario 1,8 % del VAB de la UE; tabla avanzada/emergente (C22, C59, V21) |
| l. 547, 555 | Consumo 60-70 % del PIB | 53 % en la UE (2025), en torno a 2 tercios en EE. UU. (V18) |
| l. 565 | Consumo «ligeramente atrasado» | Contemporáneo (Stock y Watson, 1999; 3.A.42) (K12) |
| l. 699 | Existencias con «efecto anticíclico» | Procíclicas y muy volátiles; amortiguan a muy corto plazo pero amplifican el ciclo (C10, Blinder y Maccini, 1991) |
| l. 717 | Inversión «adelantada» | Equipo contemporáneo o algo retrasado; residencial adelantada (C10, K12) |
| l. 755 | *Output gap* entre los determinantes negativos de la inversión | Positivo (acelerador), junto a la utilización de la capacidad (C11, K15) |
| l. 787 | Consumo público «generalmente procíclico» | Acíclico o algo contracíclico en avanzadas; procíclico en muchos emergentes (C10; Kaminsky et al., 2004) |
| l. 619 | «Población joven (−): los jóvenes ahorran más de cara a la vejez» | Efecto ambiguo: ahorra la población en edad de trabajar; más dependientes, más consumo (C12; Modigliani y Brumberg, 1954; Leff, 1969) |
| l. 639 | Política fiscal futura expansiva reduce el consumo «–equivalencia ricardiana–» | Equivalencia ricardiana bien definida (Barro, 1974), remisión a 3.A.39 (C12) |
| l. 779-799 | «C + I + G» con la inversión pública en G | En la CN, G es el consumo público; la inversión pública está en I (K9) |
| l. 942 | «γY = s_L·γL + s_K·γK + γA» | $\gamma_Y=\gamma_A+\alpha\gamma_K+(1-\alpha)\gamma_L$ (canon, K16) |
| l. 836-858 | $e=EP^*/P$ | $q=EP^*/P$, subida = depreciación real (canon D013/D015, K10) |
| Nota 13 | PMI > 50 «denota optimismo» | Índice de difusión: >50, la actividad crece respecto al mes anterior (C8) |
| Nota 5 | Recesión = 2 trimestres, sin matiz | Regla práctica (Shiskin, 1974); NBER y CEPR usan un criterio más amplio; depresión según *The Economist* (C26, P104) |
| l. 51 | «No usar abreviaturas (salvo PIB e IPC)» | Regla de 2026: solo las del enunciado y las convencionales (P73, V6) |
| l. 25 | «Generalmente, no se han venido realizando preguntas» | Quitado (sin fuente; la convocatoria prevé hasta 15 minutos): consejo para la lectura (C45, V4) |
| l. 348 | «huego» y otras erratas del bloque | Corregidas al redactar de nuevo (P110) |

### Parte 2

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 1124 | «junto con la tierra y el trabajo» | «junto con el capital» (C1, P96) |
| l. 1128-1138 | 16-64 años; «tasa de participación» = activos/población total; OCDE 70 % frente a España 60 % | EPA: $A/P_{16}$, $L/P_{16}$, $u=U/A$; mismas edades para comparar: España 74,9 % (15-64, 2025), OCDE 73,9 % (2024), España 58 % (16+) (K17, C21, V16-V17) |
| l. 1186, 1271 | «γ CLU = γ w_nominales − γ PAT_real» (w minúscula) | $\gamma_{\mathrm{CLU}}=\gamma_W-\gamma_{\mathrm{PAT}}$, $W$ nominal (canon §6, K18) |
| l. 1199 | «CLU = P·s_L» | $\mathrm{CLU}=P\cdot WL/(PY)$; CLU real = participación salarial (K16, K18) |
| l. 1283-1287 | Margen ≈ PQ − WL y tasas de una diferencia | $P=(1+\mu)\mathrm{CLU}$, $\gamma_{1+\mu}\approx\gamma_P-\gamma_{\mathrm{CLU}}$; EBE ≠ margen (C7, K18) |
| l. 1265 | Demanda de trabajo función de los CLU nominales | De los CLU reales (C31) |
| l. 1305 | NAIRU: «punto en el cual el empleo para de crecer» | Paro compatible con inflación estable, no techo al empleo; NAWRU de la Comisión (C25); quitado el ejemplo de Suecia (sin fuente) |
| Nota 24 | «Paradoja de Kaldor» = ausencia de relación CLU-PIB | Kaldor (1978): CLU al alza y cuota al alza; Felipe y Kumar (2011) para la zona del euro (C28) |
| l. 1376, 1484 | ROE frente a «tipos de interés de mercado» | Frente al coste del capital (8-12 %, ABE) (C5, C36) |
| l. 1378 | «RWA» | APR (canon §11, K23) |
| l. 1430 | Euro de 20 países | Párrafo de Unicaja quitado (C81); no hace falta la cifra |
| l. 1460-1474 | Apalancamiento en «Liquidez»; LCR de «flujos esperados»; LTD alto = falta de liquidez para «requisitos de capital»; dato de 3,921 billones sin fecha | Apalancamiento en solvencia; LCR con escenario de tensión; NSFR añadido; LTD como riesgo de financiación; dato quitado (C4, P99) |
| l. 1581 | Ponderaciones del IPC «revisadas en cada período» | Actualización anual, base 2025 desde enero de 2026 (C30, K21, coherente con 3.A.9) |
| l. 1577, 1603 | Laspeyres y Paasche con $q_i$ | $\vect{p}\cdot\vect{x}$ (canon §0, K21) |
| l. 1594 | «PIB a precios fijos» | PIB en volumen encadenado; deflactor = Paasche encadenado (K21) |
| l. 1628 | IPC < deflactor = «aumento del precio de los activos financieros» | Mejora de la RRI, bienes de inversión o servicios públicos; ninguno incluye activos financieros (C13, K21) |
| l. 886 | Deflactor de M < IPC = «falta de competitividad exterior» | Las importaciones se abaratan frente a lo nacional (C13) |
| l. 1648 | «efectos de segunda ronda de la política monetaria» | De los choques de oferta (C14) |
| Nota 32 | Subyacente «sin comida y energía» | INE: sin alimentos no elaborados ni energía; Eurostat/BCE: IAPC sin energía ni alimentos (K22) |
| l. 1684-1690 | *Bid-ask spread* como liquidez; salarios como *demand-pull* | Quitado; salarios en *cost-push* (C16) |
| l. 1720, 1738 | «Si la inflación se acelera, no hay duda: PM contractiva»; «BCE sólo utiliza el pilar económico» | Según el origen; estrategia del BCE de 2021 confirmada en 2025 (C15, V25) |

### Parte 3

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 1768, 1792, 1860, 1890 | La identidad de la BP 4 veces, con «Y − A + rentas» (A choca con activos y PTF del canon) | Una vez, `eq:identidad-bp`, con la notación del canon: CC + CK + EO = CF (K11, C85) |
| l. 1832 | «¿Deuda interna anémica?» | Demanda interna débil (C2, P97) |
| l. 1852-1856 | «↑(T − G) ⇒ ↑i…» y «enfoque fiscal de la BP» | ↓(T − G), hipótesis de los déficits gemelos (C6, K25) |
| l. 1926 | PIIN = pasivos − activos | Activos − pasivos; negativa si deudor neto (C3, K26, P98) |
| Nota 34 | «Cobertura de la base monetaria»: 20 % de M2 | Dinero en sentido amplio (M2) (C29) |
| Nota 35 | ΔPIIN ≈ PIIN·(i − g) + CC + CK (intereses contados 2 veces; g del canon es progreso técnico) | `eq:dinamica-piin` con γ^N y otras variaciones (C20, K27, P107) |
| l. 1942-1946 | Inflación siempre (+); depreciación siempre (−) | Inflación solo licúa la deuda en moneda nacional; pecado original (C19) |
| l. 1950 | Deuda externa preocupante > 100 %, muy preocupante > 200 % | Regla práctica orientativa que no sirve para el euro; PIIN −35 % (PDM) y composición (C19, D-03) |
| l. 1974 | Tipos «lo normal en países de desarrollo» | Desarrollados (K28) |
| l. 1984 | Interbancario «ligeramente superior» | Con exceso de liquidez, el tipo a un día cotiza por debajo de la facilidad de depósito (C17) |
| l. 1996-2000 | Expansiva si el tipo baja mucho; acomodaticia «algo intermedio» | Nivel del tipo real frente al natural; acomodaticia = expansiva; regla de Taylor (K28, C17, P101) |
| l. 2018-2020 | «Análisis opcionales» fiscales dentro de la política monetaria | Llevados a VI.2 (P87) |
| l. 2047 | Política fiscal neutral = saldo estructural en equilibrio | Neutral = Δb^pe ≈ 0, sea cual sea el nivel (C18, K29) |
| l. 2085 | Sostenibilidad con «γ PIB real» y el coste de la deuda | Dinámica del canon (`eq:dinamica-deuda`): i − γ^N o r − γ_Y (C18, C62) |
| Nota 38 | ERTE de 25.000 M€ como *one-off* | Sin el ejemplo (no comprobado, V28, C27): definición general de medida puntual y aviso de que las medidas COVID se trataron como temporales |
| l. 2155 | Policy mix coherente = «ambas contractivas o expansivas» | Coherente si cada política ayuda a la otra (K30, C64) |
| l. 2316 | «Rigidez del sistema financiero» (texto repetido de la matriz) | Fila «Fragilidad financiera» con medidas (C75) |

### Parte 4 (anexos)

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Anexo 1 | «tendencia linear», «sin empiezan»; conformidad repetida 3 veces | Resumido en `anexo:series` (conceptos), con persistencia (K12) |
| Anexo 2 | Gasto público «anticíclico, retardado»; comercio «anticíclico»; inversión «adelantada»; 5 filas vacías | `tab:hechos-ciclo` completa y alineada con el 3.A.42: consumo público acíclico, importaciones procíclicas, demanda externa neta contracíclica, inversión en equipo contemporánea y residencial adelantada (K12, C10, P21, P22, P109) |
| Anexo 5 | «γ Output gap = …», «γ PIIN = γ saldo CF + …», «Spread… = fórmula» | `anexo:calculos` con la notación del canon y ejemplos resueltos (C78, P107, P108) |
| Anexo 4 | Equilibrio interno y externo vacíos | Completados; las 4 cuentas y sus vínculos (`anexo:fmi`) |
| Anexo 6 | España 2020-2022, en parte copiado del Banco de España | Reescrito como caso de diagnóstico con datos de 2024-2026 (D-04, `anexo:espana`) |

## 3. Marcas resueltas

| Marca | Qué hacía | Qué se ha hecho |
|---|---|---|
| Notas al opositor 1-7 (l. 1-27, BOE de 30/12/2024) | Cita de la convocatoria | Actualizada a la Resolución de 22/12/2025 (BOE de 29/12/2025, texto idéntico) y llevada a I.1 con la calificación (P23, V1-V3) |
| `image1.png` «Examen oficial 2021» | Instrucciones del examen | Era el de 9/7/2022; sustituida por la tabla de formato 2011-2026 (`tab:formato`) (P35, V5) |
| Nota 8 «la más larga y siempre aparece» | | Matizada: 13 de 14 dictámenes, no en 2025; `notaopositor` de hacerla primero sin pasarse (P24, C46) |
| Nota 9 «hay preparadores que recomiendan…» | | Decidido: primero (Claves); sin nombres de preparadores (P24) |
| Caja C1 «¿?» (perfil cíclico) | Hueco | Recuadro `ideaclave` «Qué hay que contestar» (P31, P32, C48) |
| Cajas C3-C4 «¿Cuál es el motor…?» | Preguntas guía | Integradas en los recuadros «Qué hay que contestar» (P32) |
| Nota 10 «¡A veces pueden parecer contradictorios!» y nota 4 | | Integradas en el texto de II.2 con un ejemplo (P25, C47) |
| C2 «el output-gap se cierra/se abre» | Terminología | En II.2 y remitida al anexo de expresiones (parte 3) (P34) |
| Nota 11 «Nota 27/09/2021: El manual dice…» | Nota privada | Quitada (P26, P67, C82) |
| «Poco que contar, gastos de personal…» (l. 785) | Apunte | Sustituido por el texto de C10 (C82) |
| Nota 12 «Comentar brevemente…» (demanda externa) | | `notaopositor` (P27, C47) |
| «Si no tuviéramos nada, nos lo inventamos usando condicionales» (l. 777) | | «se pueden mencionar como posible factor, con condicionales» (C82) |
| Nota 13 «problemas estructurales… difíciles de localizar» | | `notaopositor` en II.5, ampliada (P28) |
| Matriz de fortalezas y debilidades (l. 147-288) | 9 columnas, la mitad vacías | Plantilla de 4 columnas con ejemplos en I.7 (`tab:matriz`); la tabla desequilibrio → recomendación irá en VII.2 (P57, C49) |
| `[Desarrollo coyuntura]` del perfil cíclico | Frases modelo con «20xx», «x,x %» | Las útiles quedan como ejemplos «Cómo se escribe» sin datos inventados; el resto, al anexo de expresiones (parte 3) |
| Frase de turismo «10,1 % de media en la UE» (l. 930) | Cifra sin fuente | Quitada (V39) |

### Parte 2

| Marca | Qué se ha hecho |
|---|---|
| P1-P3 (huecos del párrafo modelo del sistema financiero: moratorias y dividendos; política monetaria; ahorro precautorio y forzoso) | Completados en el párrafo modelo de C34, que va al anexo de expresiones (comentario «% A ANEXO»); en III.2 queda el análisis |
| P4 (Tier 1 > 12 %) | Mínimos regulatorios (7/8,5/10,5 %), requisitos totales del MUS (11 % CET1, 16 % total) y, aparte y como orientativos, los tramos de la ABE (CET1 > 14 % holgado) (D-03) |
| P5 (ROE > 10 %) | Se mantiene como referencia orientativa de la ABE (> 10 % favorable) junto al coste del capital (8-12 %) |
| P6 (efecto precio y volumen de los tipos) | Integrado en «Cómo se lee» del sector bancario |
| P7 (Precio de la vivienda, título vacío) | Escrito (C38): fundamentos frente a burbuja, umbral del PDM (+9 % nominal), sobrecarga de Eurostat (40 %, orientativo) en lugar del «33 %» sin fuente de l. 1014 |
| P8 (Índice bursátil, título vacío) | Escrito (C39) |
| P9-P13 (macroprudencial, duplicado) | Reescrito en general por fases del ciclo (C40); una copia del párrafo modelo, al anexo de expresiones |
| Notas 14 («incidir al cantar») | `notaopositor` con «leer» (P29) |
| Cajas C5 («¿Es flexible…?»), C7 («¿Está controlada?…»), C6 y C18 («¿?») | Recuadros «Qué hay que contestar» (P31, P32); «Mercado de capital físico» quitado (C72, P80) |
| Cajas C8-C17 (IPC, Laspeyres, Paasche) | Una caja `anotaciones` con las 2 fórmulas y remisión a 3.A.9 (P33) |
| `image10` (Rankia) e `image11` (Unicaja, 2T2021) | Tablas con fuente primaria y datos de 2T2026, en el comentario del anexo (P44, P45, V12-V15) |
| Texto copiado del blog de Unicaja (l. 1428-1498) y del Informe Anual del BCE 2022 (l. 1337-1339) | Redactado de nuevo (C81, C83); el párrafo del BCE se quita |
| `image7` (captura del FMI en inglés), `image8`-`image9` (Boscá et al.) | Sustituidas por el gráfico de Beveridge con Eurostat (P41-P43) |
| `image12`, `image13` (duplicada), `image14` (datosmacro, «Percio») | IAPC con Eurostat en el cuerpo; image13 quitada; Brent con la EIA al anexo (P46-P48) |
| Nota 27 (curva de Beveridge de España, Boscá et al., 2023) | Sustituida por el pie del gráfico con datos de Eurostat hasta 2026 |

### Parte 3

| Marca | Qué se ha hecho |
|---|---|
| Caja C19 «desequilibrios externos suelen ser síntoma de internos» | Al principio de V |
| P14 «Vida media de la deuda [ver Sahuquillo 2023]» | Explicada en VI.2 con `\parencite{Sahuquillo2023}`; sin el dato del Tesoro (no verificado) |
| P15-P17 (viñetas vacías de políticas de oferta, activas y pasivas) | Desarrolladas en VII.2 por tipo de paro (C42) |
| P18 (párrafo posiblemente copiado del BCE, fuente no localizada) | Redactado de nuevo con el Ageing Report y el Art. IV de España de 2026 (C43, V30) |
| Notas al opositor 15 (recomendaciones al final) y cajas C20-C21 | `notaopositor` y «Cómo se plantea la pregunta» (C46, P30) |
| Enlaces de Wikipedia y elEconomista (l. 1968-1970) | Quitados (P68) |
| «Numitor» y párrafos modelo con cifras de un examen (l. 2022-2030, 2141-2151) | Sin el nombre ni las cifras; las ideas, en VI.1 y VI.2; los párrafos, al anexo de expresiones si se quieren (V40) |
| `image15`-`image16` | Gráfico `tipos-balance-bce` con datos del BCE hasta octubre de 2026 |
| `image17`, `image18`, `image19` | Al anexo (comentarios «% A ANEXO»): impulso fiscal (FMI), esquema TikZ de la inflación y las cuentas públicas, escala de calificaciones del Eurosistema (no la del blog de Bankinter) |
| `image20` (FMI, en inglés) | Esquema TikZ `policy-mix` |
| Recuadro del FMI | Ampliado con tipos de programa y condicionalidad (C69, P92) |
| «Conclusión» del Word | Conclusión breve de la guía con el ejemplo de cierre del original |

### Parte 4

| Marca | Qué se ha hecho |
|---|---|
| P19 («Buscar imagen buena del ciclo», salió publicada en 2024) | Gráfico TikZ `ciclo-tendencia` pedido |
| P20 («Buscar imagen buena de comovimientos») e `image22` (tuit con marca de redistribución prohibida) | Gráfico TikZ `comovimientos` pedido; citado el Conference Board |
| P21, P22 (gasto público anticíclico, retardado) | Resueltas en `tab:hechos-ciclo` |
| C2 y C19 (terminología; desequilibrios externos como síntoma) | En el anexo de expresiones (y C19 al principio de V) |
| Párrafos modelo `[Desarrollo coyuntura]` (≈ 60) | Plantillas sin datos inventados en `anexo:expresiones`, con 2 ejemplos de respuesta (sistema bancario en una crisis; estabilidad financiera con tipos bajos, una sola copia, erratas corregidas) |
| Recuadro de Claves sobre NGEU en la BP | Caja en `anexo:expresiones` con `\parencite{BdE2021NGEU}` |
| Anexo 3 (estadísticas derivadas) | Lo útil (índices, cambio de base) en `anexo:calculos`; el resto se quita (C79) |
| Lista «Temas relevantes» | `tab:donde-se-estudia` en `anexo:temas` (K6, C80) |

## 4. Datos actualizados

Todos consultados el 23/10/2026 por el verificador de datos (`propuestas-datos.md`), con su segunda
comprobación allí.

| Dato | Anterior | Nuevo | Fuente | URL | 2.ª comprobación |
|---|---|---|---|---|---|
| Convocatoria vigente | BOE 30/12/2024 | BOE 29/12/2025 (BOE-A-2025-26902), mismo texto; mínimo 4 en el dictamen, 12/30 en el ejercicio, nota del test ≥ 8 fijada por el tribunal | BOE | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26902 | BOE-A-2024-27439 |
| Formato del examen 2011-2026 | — | Tabla `tab:formato` | Enunciados oficiales (ATCEE) | https://atcee.es/la-oposicion-tcee/examenes-anteriores/ | `examenes.md` |
| Consumo privado / PIB | 60-70 % | UE 53 % (2025); EE. UU. ≈ 68 % (2024) | Eurostat nama_10_gdp; Banco Mundial | ver `bib-datos.bib` | WDI |
| FBCF / PIB | ≈ 20 % | 21,5 % UE (2025) | Eurostat nama_10_gdp | ídem | pendiente (V19) |
| Crecimiento de avanzadas / emergentes | PD 2-4 %, PED > 5 % | 2,0 % / 4,5 % (2025); inflación avanzadas 2,5 % | FMI, WEO oct. 2026 | https://www.imf.org/en/publications/weo/issues/2026/10/13/world-economic-outlook-october-2026 | publicación WEO |
| PIB per cápita | 50.000 / 36.000 / 30.000 $ | 90.267 / 61.255 / 38.595 $ (2025) | FMI WEO | ídem | — |
| Sector primario | ~10 % en PD | 1,8 % del VAB UE (2025); agricultura > 25 % del PIB en renta baja | Eurostat nama_10_a10; Banco Mundial WDI | ver bib | WDI |
| Frase ejecutiva de ejemplo | Art. IV España 2022 (feb. 2023) | Art. IV España 2026 (nota de 22/5/2026) | FMI | https://www.imf.org/en/news/articles/2026/05/22/pr26163-spain-imf-executive-board-concludes-2026-article-iv-consultation | Country Report 26/102 |
| Gráfico de contribuciones (image2) | BCE 2012-2022 | Eurostat EA21 2012-2025 | `datos/image2-…csv` | | |
| Consumo, renta y ahorro (image3) | Modelo del BCE | Eurostat EA21 2012-2025 | `datos/image3-…csv` | | |
| PIB y comercio mundiales (image4) | BCE | FMI WEO oct. 2026, 2005-2027 | `datos/image4-…csv` | | |

### Parte 2

| Dato | Anterior | Nuevo | Fuente |
|---|---|---|---|
| Tasa de actividad | OCDE 70 %, España 60 % | España 74,9 % (15-64, 2025), OCDE 73,9 % (2024), España 58 % (16+) | OCDE; Eurostat lfsa_argan; INE |
| NAWRU | «muy superior al 5 %» (Claves) | Zona del euro ≈ 6,6 %, España ≈ 12,1 % (2025) | Comisión, AMECO (sin 2.ª fuente: V37) |
| Umbrales del PDM | Cuadro anterior a 2024 | Cuadro de 2025: paro 10 %, actividad −0,2 pp, CLU por hora +9/+12 %, deuda hogares 55 %, SNF 85 %, crédito 14/13 %, vivienda nominal +9 %, TCER ±3/±10 %, exportaciones −3 % | CE, AMR 2026; Eurostat (MIP) |
| Requisitos de capital | Tabla de Rankia | 7/8,5/10,5 % + colchones; requisitos totales MUS 11,2 % CET1 y 15,6 % total | BCBS; CRR/CRD; BCE, SREP 2025 |
| Ratios de la banca española | 2T2021 | 2T2026: ROE 16,05 %, CET1 14,11 % (UE: 11,3 % y 16,1 %) | BdE (5/10/2026); ABE Risk Dashboard 2T2026 |
| Coste del capital bancario | — | 8-12 % | ABE, Risk Assessment Report dic. 2025 |
| Curva de Beveridge | España 1994-2022 (Boscá et al.) | España 2010-2026 y zona del euro 2009-2026 | Eurostat jvs_q_r21, une_rt_q |
| IAPC | 2017-2022 (BCE) | Hasta septiembre de 2026: 3,8 %, subyacente 2,5 % | Eurostat |

### Parte 3

| Dato | Anterior | Nuevo | Fuente |
|---|---|---|---|
| Tipos oficiales del BCE | hasta 2023 | Facilidad de depósito 2,50 %, OPF 2,65 %, marginal 2,90 % desde el 16/9/2026 | BCE (FM; tabla de tipos oficiales) |
| Balance del Eurosistema | hasta 2023 | 5,9 billones (16/10/2026); máximo de 8,8 a mediados de 2022 | BCE (ILM) |
| Reglas fiscales | PEC 3 % y 60 % | Marco de 2024: gasto primario neto, salvaguardas de 1 y 0,5 pp y 1,5 % estructural; cláusula de defensa en 17 Estados | Reglamentos (UE) 2024/1263 y 2024/1264; Consejo |
| Umbrales del PDM exterior | CC −4/+6 %; PIIN −35 % | Sin cambios (confirmados) | CE, AMR 2026 |
| MBP | MBP6 | MBP6 vigente; MBP7 publicado en 2025 | FMI |
| Ajuste fiscal recomendado a España | — | ≈ 0,5 pp del PIB al año en 2026-2030 | FMI, Art. IV 2026 |
| Grado de inversión | escala de Bankinter | BBB−/Baa3/BBBL (CQS 3 del Eurosistema) | BCE, ECAF |

### Parte 4

- Tablas de anexos con los datos ya verificados: indicadores y umbrales (PDM 2025, Tratado, reglamentos de 2024,
  Basilea III, SREP 2025, ABE 2T2026), ratios de la banca (2T2026), escala de calificaciones del Eurosistema
  (1/4/2026), gráficos de PIB por PET de España (2T2026), empleo y horas de la zona del euro (2T2026), Brent
  (septiembre de 2026) e impulso fiscal (FMI, octubre de 2026).
- Anexo de España: crecimiento 3,5 % (2024) y 2,8 % (2025), déficit 2,5 % (2025), ajuste recomendado de 0,5 pp
  anuales (FMI, Art. IV 2026); nivel prepandemia en el 2T2022 (Eurostat; sin 2.ª fuente independiente, V22);
  tasa de actividad 74,9 %, apertura ≈ 70 %, paro 10,5 % (Eurostat); ROE 16 % y CET1 14 % (BdE).

## 5. Contenido añadido

- **Capítulo I completo** (C50, P71-P73, Claves): calificación, 4 capacidades y 2 principios, regla del
  tiempo con tabla por convocatoria (`tab:reparto`, elaboración propia con la regla), 7 pasos de lectura
  del cuadernillo con un cuadro de ejemplo marcado (`tab:cuadernillo`, inventado y dicho así), cómo
  redactar, errores típicos y la lectura, matriz y tabla de temas por bloque (`tab:donde-se-estudia`,
  K6/C80; el «3.A.27 Análisis macroeconómico del mercado de trabajo» antiguo se sustituye por
  3.A.25-3.A.28).
- **II.2** PIB frente a RNB (P74, C51; 2023 y 2026) e indicadores adelantados y de alta frecuencia
  (P75, C52; sustituye la imagen del Conference Board, que no se puede publicar).
- **II.4** Sector dominante: petróleo y materias primas (P77, C54; 2016 y 2025), con enfermedad
  holandesa (Corden y Neary, 1982).
- **II.5** Tabla avanzada/emergente (C59).
- Paseo aleatorio del consumo con su fuente (Hall, 1978; Friedman, 1957) y *animal spirits* (Keynes,
  1936): entradas añadidas por el editor al `.bib`.
- Cada indicador del capítulo II con el esquema de §11 (qué mide · cómo se calcula · umbral · cómo se
  lee y con qué se cruza · tema).

### Parte 2

- III.1: definiciones de la EPA con la advertencia de las edades, salario real de consumo y de producto,
  margen bien derivado, demanda y oferta de trabajo, tipos de paro (ficha 5 de Claves), Okun y Phillips y
  cuándo usarlos (C66; 2021), Beveridge con gráfico (C68), demografía (C65; 2026), visados (2020) y
  salario mínimo (C67; 2019).
- III.2: endeudamiento con los umbrales del PDM, brecha crédito-PIB, préstamos en divisas (C73), sector
  bancario completo pero compacto (C4, C5, C35-C37), vivienda (C38), bolsa (C39) y macroprudencial (C40).
- IV.1: IPC frente a deflactor e inflación importada (C13), subyacente y segunda ronda (C14, K22), origen
  de la inflación (C16), efecto base y persistencia (C55; 2023, 2025, 2026), política según el origen
  (C15).
- IV.2: tipo de cambio con la convención del canon y aviso de las estadísticas (K10), traspaso,
  Marshall-Lerner y curva J, régimen e intervención (C56; 2021, 2022, 2026). La adecuación de reservas,
  a V.2 (parte 3).
- IV.3: competitividad no precio (C57) y aranceles: medias simple y ponderada, efectos de aranceles de un
  tercero (C58; 2026 y Meridia).

### Parte 3

- V: saldos sectoriales y volatilidad de la capacidad de financiación (C53; 2018, 2023), superávit (C2),
  apertura, penetración y RRI (llevadas aquí desde la demanda externa), NGEU en la BP (nota; el recuadro
  de Claves, al anexo), reservas en el texto (C29, P85), métricas de vulnerabilidad (nota 35), dinámica
  de la PIIN (C20).
- VI.1: diseño, instrumentos, tono con Taylor, canales, eficacia, balance, dominancia fiscal y «última
  milla» (C60; 2020, 2021, 2024, 2025, 2026).
- VI.2: tono y esfuerzo (C63), reglas de 2024 (C61, V29), dinámica de la deuda y saldo estabilizador
  (C62), riesgos y estrategias (2026), vida media (C41), ingresos bajos y tamaño (C71), inflación y
  cuentas públicas, efectos no keynesianos.
- VI.3 y VI.4: *policy mix* (C64, K30) y políticas de oferta con diagnóstico previo (C70).
- VII: tabla desequilibrio → indicios → recomendaciones (C75, ficha 7 de Claves; base de la ficha de
  repaso), políticas de empleo (C42), presiones de gasto (C43), programa del FMI (C69).

### Parte 4

- Anexo A (`anexo:indicadores`): 3 tablas de indicadores con columnas separadas de referencia oficial y
  orientativa (D-03, C74, K7), Basilea III, ratios bancarios, calificaciones y avanzada/emergente.
- Anexo B (`anexo:preguntas`): tabla de bloques por examen y las preguntas literales de los 14 dictámenes
  (C77, P94), generadas de `examenes.md`.
- Anexos C (expresiones), D (series, hechos estilizados y 7 gráficos de lectura), E (cálculos tipo), F
  (programación financiera del FMI), G (España) y H (dónde se estudia cada bloque).

## 6. Coherencia

- Notación del canon: $\gamma_X$ con subíndice (D012), $Y^p$ potencial (D-05; la ficha
  `saldo-estructural` usa $Y^*$, ya anotado como C3), $\mathrm{OG}$, $q=EP^*/P$ (D013, D015),
  $\alpha$ participación del capital (ficha `contabilidad-crecimiento`), PAT $=Y/L$.
- Hechos estilizados alineados con el 3.A.42 (K12): consumo contemporáneo, consumo público acíclico,
  importaciones procíclicas y demanda externa neta contracíclica. La tabla completa irá en el anexo de
  series (parte 3).
- Remisiones: todas con `\vertema`, con la numeración de `temario.json` (comprobados los 85 códigos);
  primero 3.er ejercicio, luego 4.º (K5). Las internas con `\ref`.
- Contradicciones con otros temas (no se tocan): las 11 de `propuestas-coherencia.md` («Contradicciones
  con otros temas») siguen vigentes; las que afectan a esta parte: 3.A.42 (volatilidad del empleo,
  inversión residencial y existencias), ficha `saldo-estructural` ($Y^*$) y 4.B.4 (filtro HP remitido al
  3.A.41).
- Cambios al canon propuestos (C1-C14) los aplica `tema-canon`; esta parte usa C1 (brecha), C3 ($Y^p$) y
  C10 (hechos estilizados).

### Propuestas de esta parte: aplicadas y rechazadas

- **Aplicadas**: K1 (I y II), K2 (lo de I-II), K4 (remisiones de l. 535, 659, nota 6, nota 7), K5, K6,
  K8, K9, K10 (solo la convención, el texto completo va en IV.2), K13, K14, K15, K16; C8, C9 (con $Y^p$),
  C10 (texto; la tabla, en la parte 3), C11, C12, C22, C26, C45, C46, C47, C48, C50 (con la regla del
  tiempo en lugar de la tabla fija), C51, C52, C54, C59, C80, C82, C83 (FBCF resumida con cita al SEC
  2010), C86; V1-V6, V18, V19, V21, V31, V33, V34, V39.
- **Modificadas**: C49 (la matriz no se va al anexo: queda en I.7 simplificada, como pide K1; la tabla
  desequilibrio → recomendación irá en VII.2); C50 (tabla de reparto fija → regla y tabla por
  convocatoria, D-02; 12′ de lectura → 10-12′); C51 (sin la cifra de Irlanda, «25 % [VERIFICAR]», que el
  verificador no comprobó: se deja el ejemplo sin cifra); C86/V33 (la cita de Peter va como «atribuida»
  con `\parencite{Peter1977}`, sin página).
- **Aplazadas a otras partes**: C13 y el bloque «opcionales» de la demanda externa (apertura,
  penetración, inflación importada, RRI) → V.1; C53 (saldos sectoriales) → V.1; C23 y las
  «Recomendaciones» del perfil cíclico (l. 1078-1110) → VII.2; C44 (gráficos del ciclo y comovimientos)
  y la tabla de C10 → anexo de series.
- **Rechazadas**: la afirmación de la nota 17 de que el Banco de España calcula los tipos reales con
  *swaps* de inflación a 15, 10 y 5 años (V38, no comprobada): queda la idea general sin atribuirla.

### Parte 2

- Notación: $u=U/A$ en las fórmulas de la EPA (canon § 13) y, desde la parte 3, $U_t$/$U^n$ en la curva de Phillips (canon § 6); pendiente $a$ en la curva de Phillips (D060);
  $W$ nominal, $\mu$ margen (canon §6); $q=EP^*/P$ y $q^{ef}$ (D013, D015); APR (canon §11); ROA
  bancario distinto del ROA = EBIT/AT de D062 (C11 del canon).
- IPC y deflactor dichos como en el 3.A.9 revisado (base 2025, Laspeyres encadenado, Paasche
  encadenado) y con su misma fuente (`INE2026IPCMetodologia`, copiada de `3A09.bib`).
- Aplicadas: K17-K23, K10 (IV.2), C1, C4, C5, C7, C13-C16, C21, C25, C28, C30, C31, C34-C40 (C34 y el
  duplicado de C40, al anexo), C55-C58, C65-C68, C72, C73, C81, C83; V7-V17, V25, V37.
- Modificadas: C56 (las reservas pasan a V.2, como en K1); C58 (sin las fechas de los aranceles de 2025
  ni el rango 0,2-7 % de Aiyar et al., que el verificador no comprobó); C66 (en la parte 3 se vuelve a $U_t$/$U^n$, como fija el canon); C67 (sin la
  cifra del SMI, para no duplicar el 3.A.17).
- Aplazadas a la parte 3: C42 (políticas de empleo, a VII.2) y adecuación de reservas (V.2). A la parte 4
  (anexos): tablas de Basilea y de ratios bancarios, párrafos modelo de C34 y C40, gráficos de horas,
  empleo y Brent, y las tablas de temas por bloque y de economía avanzada/emergente movidas desde la
  parte 1.
- Rechazado: el ejemplo de la nota 38 y similares no tocan esta parte.

### Parte 3

- **Tasa de paro**: el canon fija $U_t$, $U^n$ para la tasa de paro y la tasa natural (§ 6, D057; como
  en el 3.A.28) y $u=U/A$ con $U$ parados en las fórmulas de la EPA (§ 13, D048, D065). La guía usa
  ahora las 2 según el contexto (EPA en los indicadores; Phillips con $U_t$) y avisa en nota. Propuesta
  al canon (C9 de coherencia): fijar una regla para los textos que usan las 2 cosas (1D01, 4.A.16,
  4.A.29), p. ej. $u$ tasa y $U$ parados, o una nota estándar como la de la guía.
- Notación aplicada: identidad de la BP de la ficha `identidad-balanza-pagos`; dinámica de la deuda de
  `restriccion-gobierno` (g − τ, i − γ^N, r − γ_Y, ADD, bola de nieve); saldos de `saldo-estructural`
  (b, b^p, b^{ca} = b − ε·OG, b^e, b^{pe}; ε, no η); Taylor de la ficha `taylor` en la forma con
  φ_π = 1,5 y φ_x = 0,5 aplicada a OG; $r^n$ natural (D037); 𝔼 (§ 0).
- Aplicadas: K11, K24-K30, C2, C3, C6, C17-C20, C29, C41-C43, C53, C60-C64, C69-C71, C75; V26, V27, V29,
  V30.
- Modificadas: C17 (Taylor con OG en vez de $x_t$); C19 (sin la cifra de Reinhart, 30-40 %, que no se
  ha comprobado); C27 (sin el ejemplo de la recapitalización de 2012 ni su cifra [VERIFICAR]); C41 (sin
  la vida media del Tesoro); C61 (17 Estados con la cláusula de defensa, según V29, en lugar de «unos 15»).
- A la parte 4 (comentarios «% A ANEXO»): impulso fiscal, inflación y cuentas públicas, escala de
  calificaciones, recuadro NGEU de Claves.

### Parte 4

- Hechos estilizados alineados con el 3.A.42 (K12, C10 del canon: ficha nueva `hechos-estilizados-ciclo`
  propuesta). La volatilidad del empleo queda «similar o algo menor» que la del PIB, distinta de lo que dice
  el Word del 3.A.42 («más volátil»): contradicción anotada para cuando se revise ese tema.
- Anexo de España remite a \vertema{4.A.29} y no repite su contenido.

## 7. Dudas abiertas

1. **Frase cortada de Claves** («en estas estructuras, debe predominar la…», P127): no se ha usado. ¿Qué decía?
2. **Regla del tiempo**: **Resuelta (D-06, 24/10/2026)**: sí; lectura ≈ 10 %, repaso ≈ 5 %, perfil cíclico con peso 1,25.
3. **Umbrales orientativos de crecimiento**: **Resuelta (D-07)**: tramos 0/1/2/3 % con «sólido» desde el 3 % (aplicado en II.2 y en `tab:indicadores-ciclo`).
4. **Cita de Laurence J. Peter**: atribución dudosa (versiones de 1949-1973); queda «atribuida», citando
   *Peter's Quotations* (1977) sin página.
5. **Irlanda 2015**: ¿quieres la cifra de crecimiento del PIB (hay que verificarla en la CSO)?
6. **Guías de preparadores** (Vich Gadella, Cordero Tarifa, Sahuquillo): en la bibliografía con `\nocite` y
   Sahuquillo citado en la vida media de la deuda; ninguna está en local. ¿Bien así?
7. **Ejemplo inventado del cuadernillo**: **Resuelta (D-08)**: `tab:cuadernillo` usa ahora filas reales del dictamen de 2026 (versión rectificada), con fases y fortalezas y debilidades en salvia y salmón; los ejemplos de redacción de II.1 y II.3 pasan a años reales.
8. **Brecha crédito-PIB**: el umbral de 2 puntos (BCBS, 2010) no lo comprobó el verificador (U39).
9. **Sobrecarga del coste de la vivienda** (40 % de la renta, Eurostat), en lugar del «33 %» sin fuente: no
   comprobado en esta revisión (U47).
10. **Regla práctica de deuda externa**: **Resuelta (D-10)**: se queda como orientativa, con su advertencia.
11. **Ejemplo de medida puntual**: **Resuelta (D-11)**: ejemplo de la banca en 2012, en la nota de VI.2: déficit del 10,6 % del PIB, 111.641 M€ (Eurostat, euro indicators 64/2013, primaria, verificada en el PDF); ayudas de 38.343 M€ y déficit sin ellas del 6,98 % (Secretaría de Estado de Presupuestos, 24/4/2013, vía INAP). Comprobación aritmética: 111.641 − 38.343 = 73.298 M€ = 6,98 % del PIB de 1.049.525 M€; ayudas = 3,65 pp.
12. **Notación de la tasa de paro**: **Resuelta (D-12)**: $U_t$/$U^n$ en los modelos y $u=U/A$ en la EPA, con nota; regla para todo el temario (a `canon/pendientes-coherencia.md` por el coordinador).
13. **Tipos reales con *swaps* de inflación del Banco de España** (nota 17): quitado por no localizar la fuente
    (V38). ¿Lo tienes?
14. **Volatilidad del empleo**: **Resuelta (D-09)**: «similar o algo menor» que la del PIB en todo el temario (ya así en `tab:hechos-ciclo`); queda pendiente de coherencia para el 3.A.42.
15. **Pendiente de 2.ª comprobación** (verificador): FBCF de la UE (V19), España prepandemia con INE (V22),
    impulso fiscal de España en 2020 con AMECO, NAWRU con otra fuente (V37), métrica ARA del FMI.
16. **Extensión**: con los gráficos reales el PDF tiene 72 páginas y el cuerpo, 44 (máximo, 50). Si hubiera que recortar, lo primero que podría ir a anexos es la tabla de reparto por convocatoria (I.3) o el apartado de demografía, migración y salario mínimo (III.1).
17. **Tabla de temas por bloque**: **Resuelta (D-13)**: nueva orden `\vertemacorto{código}` (mismo enlace que `\vertema`, texto solo el código, en gris) en `tcee-comun.sty`, `pandoc-macros.tex`, `tcee.module` (LyX), `tcee.lua` (comentario), `construir-tema.py` (enlaces en HTML y Word y `data-app`) y `verificar-tema.py`; usada en `tab:donde-se-estudia`. Los temas ya revisados no la usan, así que no cambian.

## 8. Instrucciones para el vídeo (explicativo, unos 15 minutos, sin voz por ahora)

- **Formato**: explicativo, no un cante (§11): ≈ 2.350 palabras; modo `guion` en la introducción y el cierre y
  `pizarra` + `apoyo` en el resto. Mismas reglas de pizarra que §8 (solo fórmulas y esquemas a mano).
- **Enganche y cierre**: el dicho «Lo bueno, si breve, dos veces bueno» (Gracián) y la pregunta «¿Cómo se analiza
  una economía entera en 105 minutos?». La idea final la responde: con un método fijo (leer, repartir,
  diagnosticar, anotar) y frases que analizan, no describen.
- **Caso conductor**: el dictamen de 2026 (formato vigente, 5 preguntas; enunciado en `anexo:preguntas`). Su
  cuadernillo sale como apoyo y se marca en pantalla, paso a paso, lo que dice I.4 (líneas de fases, verde y
  rojo, «P1-P5» al lado de cada gráfico). No se dice qué país es.
- **Reparto y escenas**:
  1. *Introducción* (1′): qué es el ejercicio, la tabla de formato como apoyo.
  2. *El tiempo* (1′30″): en la pizarra, $W=T-\text{lectura}-\text{repaso}$, $t=W/(n+0{,}25)$, perfil $1{,}25\,t$
     y el resultado para 105′ y 5 preguntas (12′, 21′, 17′, 4′). Se conserva en una esquina todo el vídeo.
  3. *Leer el cuadernillo* (2′30″): el caso de 2026 marcado; apoyo `tab:cuadernillo`.
  4. *Redactar* (1′): frase de diagnóstico; ejemplo «descriptivo frente a analítico» como apoyo.
  5. *Perfil cíclico* (2′30″): `fases-ciclo-brecha` por capas en la pizarra; fórmula de las contribuciones;
     $\Delta\mathrm{OG}\approx\gamma_Y-\gamma_{Y^p}$; apoyo: gráfico de contribuciones de la zona del euro.
  6. *Trabajo y competitividad* (2′): $\gamma_{\mathrm{CLU}}=\gamma_W-\gamma_{\mathrm{PAT}}$ y el margen; boceto de
     Beveridge; $q=EP^*/P$ con «sube = depreciación»; caso 2026, preguntas 2 y 3.
  7. *Sector exterior* (1′30″): `eq:identidad-bp` por partes; PIIN = activos − pasivos.
  8. *Políticas* (2′): tono monetario (tipo real frente a natural) y fiscal ($\Delta b^{pe}$); `eq:dinamica-deuda`
     con la bola de nieve rodeada; `policy-mix` por cuadrantes; caso 2026, preguntas 4 y 5; apoyo: gráfico de
     tipos y balance del BCE.
  9. *Recomendaciones y cierre* (1′): `tab:recomendaciones` como apoyo (resumen final) y la idea final.
- **Al final la pizarra** queda con la regla del tiempo en la esquina y el esquema de fases: lo que hay que llevar
  memorizado.
- **Apoyo, nunca pizarra**: tablas de umbrales, de bancos y de preguntas, y los gráficos de datos.

### Decisiones de Víctor sobre la segunda vuelta (24/10/2026)

- Los 11 «Ejemplo de redacción» largos se quedan en el anexo D.1, con remisión desde su indicador.
- La tabla de calificaciones (S&P, Moody's, Fitch; DBRS en cursiva) pasa al cuerpo, en el apartado de política fiscal, junto a la calidad crediticia de la deuda; las tablas bancarias siguen en el anexo B.
- El anexo E («Análisis de casos frecuentes») se mantiene.
- Para que el cuerpo siga en 50 páginas, la conclusión se compacta (el «qué hay que llevarse» ya está en el índice de la introducción) y la tabla de desequilibrios comparte página con ella. Resultado: cuerpo 50, anexos 38, bibliografía 9 (97 págs.).

### Tercera vuelta (25/10/2026)

- Anexos reordenados a petición de Víctor: A Hechos estilizados del ciclo económico y lectura de series; B Indicadores y umbrales; C Cálculos tipo; D Gráficos de lectura (anexo nuevo, separado del de series); E Análisis de casos frecuentes; F FMI; G Un caso: la economía española; H El ejercicio y el método; I Qué se ha preguntado; J Dónde se estudia cada bloque; K Expresiones útiles para redactar (al final). Primero la economía y después el examen. La introducción describe este orden.
- Capas de todos los gráficos rehechas con capas de pgfplots (cuadrícula al fondo; barras y áreas; ejes, cero y umbrales; líneas; puntos; rótulos).
- (25/10) El esquema de la guía va en la caja `esquema` de los temas («Esquema de la guía») al final de la introducción; se quita la conclusión (la guía se cierra con el apartado VI de recomendaciones); la tabla de desequilibrios pasa al principio de VI.2. Cuerpo 50, anexos 37, bibliografía 9.
