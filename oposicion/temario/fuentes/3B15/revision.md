# Revisión del 3.B.15 — Análisis comparado de los distintos regímenes cambiarios. Intervención y regulación de los mercados de cambio

Fase 3 (integrar), 11/11/2026, en 2 partes (parte 1: introducción, esquema y I; parte 2: II, III, conclusión, anexos, `seo.json` y este informe).

## 1. Resumen

- Tema reescrito en `3B15.tex` (LaTeX para LyX) con 3 apartados en lugar de 2: el antiguo 2.3 «Intervención y regulación» sube a III con sus 2 subapartados del original. Reparto: 2′30″ / 10′30″ / 6′ / 10′ / 1′ = 30′.
- Se completan los epígrafes del título que estaban vacíos o en borrador: determinantes y evidencia de la elección (I.3), canales y eficacia de la intervención esterilizada, Marco de Política Integrado, formas de los controles, Visión institucional del FMI (2012 y 2022), experiencias y evidencia (III).
- Errores de fondo corregidos (BP vertical = movilidad nula; uniones monetarias y dolarización mal clasificadas; ejemplos caducados: kuna, libra egipcia, Nicaragua, DICOM; Friedman 1969; Rey 2015; modelo de los controles con β = 1 y pendientes mal) y datos al día (AREAER 2023 y avance de 2026, COFER junio de 2026, BIS 2025, series de 7 monedas hasta octubre de 2026).
- 14 gráficos pedidos (2 de la parte 1 y 12 de la parte 2), 5 tablas en LaTeX, 4 anexos (regímenes uno a uno, Krugman paso a paso, controles paso a paso, test). Bibliografía de 110 entradas.
- Compila (`construir-tema.py 3B15 --solo pdf --no-publicar`, con gráficos provisionales que se han borrado): 34 páginas de tema, 6 de anexos y 7 de bibliografía; sin referencias sin definir; `\minutos` suman 30.

## 2. Errores corregidos

### Apartado I e introducción (parte 1)

| Dónde | Decía | Dice ahora |
|---|---|---|
| Mundell-Fleming (l. 264) | «movilidad perfecta, β = 0, BP vertical» | movilidad **nula**, $\beta_K=0$ (C7, C8, K11) |
| I (l. 170) | «cuanto mayor la movilidad, más efectivas las políticas» | más eficaz la que funciona en cada régimen y menos la otra; la monetaria con tipo fijo, ineficaz con cualquier movilidad (C7) |
| Trilema (l. 322) | «descrito por Mundell en 1961» | se deduce de Fleming (1962) y Mundell (1963); el nombre, de Obstfeld y Taylor (1997) (C9) |
| Dilema (l. 378) | «Rey (2015)» | Rey (2013), Jackson Hole; NBER w21162 como enlace (C10, V25) |
| Dornbusch (l. 430) | «precios fijos a corto plazo pero flexibles a corto plazo»; «el *overshooting* motivó el SME» | «a largo»; la frase del SME se quita (sin fuente) (C11) |
| Friedman (l. 470) | «The case for flexible exchange rates» (1969) | 1953 (C12, V23) |
| Nota 3 | bandas de ±2,5 % en 1972-1976 | ±1 % hasta 1971; Smithsonian ±2,25 % hasta marzo de 1973 (C4, V22) |
| Gopinath | «economista jefe del FMI» | «entonces economista jefe» (V20) |
| Obstfeld y Ostry (2018) | — | Obstfeld, Ostry y Qureshi (2019) (V32); Georgiadis y Mehl 2015 → 2016 (V33) |
| l. 251 | margen «menor a un año» | sin la cifra (no encontrada) (V34) |
| Keynes (1925) | atribuido a la frase de los sindicatos | se quita de esa frase (C18) |

### Apartados II y III (parte 2)

| Dónde | Decía | Dice ahora |
|---|---|---|
| II.1 (l. 773) | AREAER 2022 «73.ª edición» | AREAER 2023 (publicado el 19/12/2024), el último; y el avance a 30/4/2026 del Informe Anual del FMI (V1, V2) |
| II.1, *hard pegs* | la unión monetaria como subcategoría de «sin moneda propia»; «Eurozona y CEMAC» como anclaje duro | el FMI clasifica a los miembros de una unión por el régimen de la moneda común: euro en libre flotación, UEMOA y CEMAC en convencional, Caribe Oriental en caja de conversión (C20.1) |
| Nota 24 y Anexo 3 frente al Anexo 1 | dolarización oficial «Mónaco», extraoficial «Montenegro» | Montenegro y Kosovo: dolarización **oficial** y unilateral; San Marino y Andorra, con acuerdo; la no oficial es otra cosa (C20.2, K11) |
| Nota 25 | El Salvador, bitcoin de curso legal «desde noviembre de 2021» | desde septiembre de 2021; aceptación voluntaria desde la reforma de enero de 2025 (V17) |
| Caja de conversión | «doble circulación monetaria» como rasgo; conversión de la «oferta monetaria»; $B^M$; Letonia | sin la doble circulación; la **base monetaria**; $\mathrm{BM}=\mathrm{CI}+R$; Estonia y Lituania (Letonia tenía un anclaje convencional, V39); Argentina con su final (C23) |
| Nota 27 | riyal oficial «desde el 1/1/2003» | 3,75 desde 1986; la fecha de 2003 se quita (no comprobada) (V10) |
| Estabilizado | kuna croata | denar macedonio (Croacia en el euro desde 2023) (V11) |
| *Crawling peg* | «senda preestablecida de depreciación»; Nicaragua al 3 % desde 2019 | ajustes pequeños a ritmo anunciado o según indicadores; Nicaragua al 0 % desde el 1/1/2024; Botsuana, el único hoy (C20.6, V13) |
| *Crawl-like* | libra egipcia | Egipto flota desde marzo de 2024; ejemplo, el renminbi (V14) |
| Nota 29 | China *crawl-like* desde julio de 2020 | «otros gestionados» desde 3/2022 y *crawl-like* en el avance de 2026 (V5) |
| Anexo 3 | flotación libre «una vez cada 6 meses» | 3 veces en 6 meses, de no más de 3 días hábiles (como el cuerpo) (V6) |
| Krugman | $s_t$, $f_t$, «parte del modelo monetario visto antes»; Imagen 9 con fuente Crespo (2016) | $e_t=\ln E_t$, fundamentos $m_t+v_t$, $\alpha$ de Cagan, banda $e^{\min}$-$e^{\max}$; enfoque monetario con `\vertema{3.B.14}`; fuente Krugman (1991) y Bertola y Caballero (1992) (C24, K12, K30) |
| II.2, nota 22 | Calvo y Reinhart (1999) | (2002) (V26) |
| Conclusión (l. 1723) | «hechos estilizados (Rose, 2010)» | Rose (2011, *JEL*) y Klein y Shambaugh (2010), subidos a II.2 (V36, C25) |
| Reservas (nota 30, l. 1363) | «1,8 billones en 2000 y 12 en 2014», «multiplicado por 9», «China, unos 3 billones» | 1,8 en 1999 y 13,2 en junio de 2026 (COFER); China 3,4 (SAFE) (V8) |
| Esterilización (l. 1475) | «reducir el crédito interno» | el banco central **vende** títulos (o emite los suyos) (K34, C27) |
| Costes (l. 1485-1495) | «Summers o Rodrick»; «Corsetti (2016)» | Rodrik (2006); Corsetti (2016) sin obra localizable: se sustituye por Dedola *et al.* (2021), la clave del 3.B.13 (C27, V37) |
| Tipos múltiples | DICOM de Venezuela como vigente; Chile 1973 «80 veces» | Venezuela como ejemplo histórico; Chile con 15 tipos (Hudson, 1994), sin el «80 veces» ni el detalle del cobre (no encontrados) (V18, V19) |
| Modelo de los controles | «factor de descuento nulo (β = 1)»; FPP lineal con traslado «únicamente por la inversión»; pendiente $1+r^*$; puntos $A$, $B$, $C$; «Rogoff, Obstfeld y Sachs»; «Samuelson (1937)» | $\beta$ general (factor de descuento); dotación sin inversión; pendiente $-(1+r^*)$; puntos $A$, $C$, $D$ como en el 3.B.12; Obstfeld y Rogoff (1996) y Schmitt-Grohé, Uribe y Woodford (2022) (C30, K39) |

**Control de calidad (12/11/2026)**:

- `tab:areaer`: «Residual» pasa del gris (`tceegris`, que en la web y el Word parece una remisión sin enlace) al verde de la paleta, como las tablas del 3.A.28.
- `datos/tc-cordoba-nicaragua-crawling-peg.csv`: julio y agosto de 2001 eran 13,039 y 13,104 (error de la media mensual del BPI, M.NI.NIO.A); ahora 13,474 y 13,540, media de los fines de mes del BPI (M.NI.NIO.E), con nota en la cabecera. Gráfico `cordoba-deslizamiento` recompilado.
- Relevancia: fuera la cita de Volcker (ya en el 3.B.13 y el 3.B.14); la idea queda con `\vertema{3.B.13}`.
- Experiencias de controles: cita de Forbes, Fratzscher y Straub (2015) para Brasil 2009-2013 (DOI comprobado en Crossref y añadido) y de la revisión de 2022 de la Visión institucional del FMI para Islandia, Chipre y Grecia.
- Trilema: «en un documento de trabajo de 1997, publicado en 1998» para Obstfeld y Taylor.
- `fig:zona-objetivo`: el pie define $\pm\bar f$, los bordes de los fundamentos.
- Resumen: «6 de anexos», no 7.

## 3. Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 | «Introducción Economía Internacional…» (comentario) | nota de trabajo: no se publica; el enganche común es el refrán y Hillel/Klein |
| P2, P3 | Hillel y Michael Klein en amarillo | enganche, sin comillas en la frase de Klein, con `Economist2016Trilema` (V31) |
| P4 | «meter lo del 3.B.13 del mercado de divisas» | una línea en la relevancia con el dato del BIS 2025 y `\vertema{3.B.13}` |
| P5 | encabezados vacíos de política fiscal | Mundell-Fleming en resumen con `tab:mundell-fleming` |
| P6, P16, P23 | Barro-Gordon y Giavazzi-Pagano con escaneos de De Grauwe | 2 líneas con `eq:apreciacion-real` y remisión al 3.B.16 y al 3.A.36; escaneos fuera |
| P7 | párrafo amarillo de crisis por régimen | con Ghosh, Ostry y Qureshi (2015); la parte de la intervención contra la sobrevaloración y la macroprudencial, rechazada (no comprobada) |
| P8, P9, P10 | «Fuente: …» vacías (Imágenes 8, 10 y 12) | Imagen 8 sustituida por el gráfico de la zona objetivo y el texto; 10 y 12, por series del BPI y de la Reserva Federal (denar y renminbi) con su fuente |
| P11 | 10 tramos de «usos de las reservas» | caja gris «Para qué sirven las reservas», en 4 grupos, con `\vertema{3.B.22}` (no se ha podido leer la guía del FMI de 2013: sin cita literal) |
| P12 | amarillo vacío en el pie de la Imagen 15 | fuera; el enlace a las diapositivas de Uribe se conserva como entrada propia (`Uribe2022DiapositivasControles`) en una caja |
| P13 | notas al opositor del cambio de temario | fuera (nota de trabajo) |
| P14 | «solo cantar las 2 políticas eficaces» | `notaopositor` en I.2.1 |
| P15 | cómo demostrar el trilema | `notaopositor` de 2 líneas |
| P17 | «Del informe de 2020 ver págs. 48 y ss.» | fuera; AREAER puesto al día |
| P18, P66 | comentarios privados (clases, preparadores, «esquema de Ángel») | no se publican |
| P19 | cajas con enlaces (VoxEU de Rey, NBER w7418, Wolters Kluwer) | VoxEU con la dirección de cepr.org y NBER w21162 en `Rey2013Dilema`; NBER w7418 conservado; Wolters Kluwer (404) sustituido por la definición del FMI (art. VIII y AREAER) |
| Comentarios con enlaces | FMI 2004 (clasificación), *F&D* 2023 de Singh (Malasia) | `FMI2004Clasificacion` (nota en I.3.3 y caja del anexo A); `Singh2023Malaysia` en las experiencias de III.2.4 |
| Comentario IntechOpen | — | material de apoyo: no se publica |
| Imagen de Policonomics | enlace roto (500) | fuera; su idea va al gráfico `regimenes-espectro` y a `tab:intermedios` |
| Vídeo del FMI (pies de imagen) | youtu.be/4xcEfd35XRU | `FMIInstitute2021Clasificacion`, en la caja del anexo A |
| Nota 25 (Funcas) | enlace al newsletter | `Funcas2022ODF77`, en la nota de la dolarización |
| Enlace a quia.com | — | fuera; enlace genérico al simulador en el anexo de test |
| «Preguntas de otros exámenes» vacío | — | fuera |

## 4. Datos actualizados

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Mercado de divisas | 7,5 billones $/día (2022) | 9,5 billones (abril de 2025) | `BIS2026TrienalDatos` | bis.org/statistics/rpfx25.htm | 11/11/2026 | 3.B.13 |
| Comercio mundial | 27,4 billones (2021) | 34,65 billones (2025), «menos de 4 días» | `OMC2026GTOS` | wto.org | 11/11/2026 | 3.B.13 |
| Regímenes del FMI | AREAER 2022 | 44,8 / 32,5 / 13,4 / 9,3 % (30/4/2023); avance 47 / 33 / 14 / 6 % (30/4/2026) | `FMI2024AREAER2023`, `FMI2026InformeAnual` | elibrary.imf.org; imf.org/annual-report/2026 | 11/11/2026 | tabla 4 del AREAER (recuentos) |
| Evolución 2015-2026 | Imagen 14 (2011-2022) | `datos/areaer-regimenes-2015-2026.csv` | ídem | ídem | 11/11/2026 | recuentos de 2023 |
| Reservas | 1,8 (2000), 12 (2014), China ≈3 | 13,2 billones (jun. 2026), 56,7 % en dólares, 20,6 % en euros; China 3,4 | `FMI2026COFER`, `SAFE2026Reservas` | data.imf.org (COFER) | 11/11/2026 | nota del FMI del 30/9/2026 |
| Hong Kong | gráfico de 2021 | banda 7,75-7,85; 7,846 (oct. 2026) | `Fed2026H10`, `HKMA2005Refinamientos` | fred.stlouisfed.org/series/EXHKUS | 11/11/2026 | BPI |
| Riyal | 3,75 «desde 2003» | 3,75 desde 1986 | `SAMA2016TipoCambio`, `BIS2026TiposBilaterales` | data.bis.org | 11/11/2026 | FMI 2026 |
| Denar | (kuna) | ≈61,5 por euro desde 2002 (61,58 oct. 2026) | `BIS2026TiposBilaterales` | data.bis.org | 11/11/2026 | FMI 2024 y 2026 |
| Córdoba | 3 % desde 2019 | 0 % desde 1/1/2024; 36,6243 | `BCN2023Deslizamiento`, BPI | bcn.gob.ni/node/1271 | 11/11/2026 | BPI hasta sept. 2026 |
| Renminbi | (libra egipcia) | *crawl-like* (2026); 6,68 (oct. 2026) | `FMI2026InformeAnual`, `Fed2026H10` | FRED EXCHUS | 11/11/2026 | BPI |
| NZD y BRL | gráficos de 2021 | 1,774 y 5,13 por dólar (oct. 2026) | `Fed2026H10` | FRED | 11/11/2026 | BPI |
| Libra egipcia | — | flotación desde el 6/3/2024; 50,3 (ago. 2026) | `CBE2024Flotacion`, BPI | — | 11/11/2026 | informe del FMI |
| Argentina | — | fin de casi todo el cepo y bandas (abril de 2025) | `BCRA2025Fase3`, `FMI2025ArgentinaEFF` | bcra.gob.ar | 11/11/2026 | FMI |
| Japón | — | 9,8 billones de yenes (abril-mayo de 2024) y 5,5 (julio) | `MOF2024Intervencion` | mof.go.jp | 11/11/2026 | — (una sola fuente oficial) |
| Flotan | «algo más de 60» | 65 de 195 economías (2026) | `FMI2026InformeAnual` | — | 11/11/2026 | 61 en 2023 |

Todos los datos que caducan están en `datos-actualizables.yaml` (17 entradas; los CSV pasan de `_trabajo/datos/` a `datos/`).

## 5. Contenido añadido

- **I.3** (parte 1): determinantes (AMO, Poole en economía abierta con `eq:poole-abierta`, credibilidad, miedo a flotar, Frieden) y evidencia (clasificaciones *de facto*; Ghosh, Gulde y Wolf; Levy-Yeyati y Sturzenegger; Rogoff *et al.*; Rose; Frankel).
- **Trilema y dilema** como modelos a)-e) (referencia del canon, D2), con 2 gráficos.
- **II.1**: `fig:regimenes-espectro`, `tab:areaer` (10 regímenes, criterios, % de 2023 y ejemplos de 2026), anclajes duros con la caja de conversión ($\mathrm{BM}=\mathrm{CI}+R$) y caja gris de sus condiciones, anclajes blandos con ejemplos vigentes, **zonas objetivo de Krugman (1991)** con a)-e), luna de miel y divorcio (Bertola y Caballero, 1992) y anexo con la solución, flotación y otros gestionados, `tab:intermedios`.
- **II.2**: visión bipolar (Eichengreen, 1994; Obstfeld y Rogoff, 1995; Fischer, 2001) frente al miedo a flotar, `fig:regimenes-evolucion`, hechos estilizados, perspectiva histórica (de la conclusión antigua), unificaciones de Egipto y Argentina.
- **III.1**: definición, motivos en una línea con caja gris, balance (`tab:balance-intervencion`), persuasión, Plaza y Louvre, *swaps*, Japón 2024; **3 canales** de la esterilizada (cartera: Branson, Gabaix y Maggiori; señales: Mussa, 1981; coordinación: Sarno y Taylor, Evans y Lyons) y evidencia (Domínguez y Frankel; Fratzscher *et al.*; Blanchard, Adler y Carvalho); coste cuasifiscal (Calvo, 1991), coste social (Rodrik, 2006), reservas COFER con `fig:reservas-mundiales`, QE como intervención implícita (Dedola *et al.*; Draghi-Mnuchin, 2018) y **Marco de Política Integrado** (Basu *et al.*, 2020; FMI 2020 y 2023).
- **III.2**: medidas de gestión de flujos frente a macroprudenciales; formas cuantitativas, de precio (Tobin; encaje chileno) y tipos múltiples (España 1959, Chile 1973, Venezuela); justificación (*second best*, externalidad pecuniaria de Korinek, deuda, trilema, país grande); marco (Convenio del FMI, Visión institucional 2012 y 2022, TFUE, OCDE); **modelo intertemporal con τ** a)-d) con `eq:euler-controles` y `fig:controles-capital`, y anexo paso a paso (hogares, equilibrio, bienestar, país grande y represalias, nota 31); experiencias (Chile, Malasia, Brasil, Islandia, Chipre, Grecia, España 1992) y evidencia (Magud, Reinhart y Rogoff; Forbes, Fratzscher y Straub).
- **Conclusión** con sus 5 bloques y el refrán del enganche.
- **Anexos**: A regímenes uno a uno con 7 series (sustituye a los Anexos 1 y 3 y a las fichas vacías del cuerpo), B Krugman, C controles, D test.

### Propuestas de contenido (C)

- C1-C18: ver parte 1 (aplicadas, con los cambios de `_trabajo/notas-editor.md`: estructura del coordinador; C9 y C10 como modelos; C31-C34 en 3 `\subsubsection`; rechazadas la BP como función clave y la parte no comprobada de P7).
- C19: aplicada en C31-C34.
- **C20**: aplicada, con el título del original para II.1 (decisión del coordinador) y la tabla con % de 2023 y ejemplos de 2026.
- **C21**: aplicada con cambios: en vez de pequeños múltiples, un gráfico por régimen en el anexo A, junto a su ficha (como el original); sin Botsuana (dato del BPI anómalo, V-aviso) ni Singapur (sin serie); **rechazado** el esquema de bandas en 3 paneles (`bandas-esquema`): lo cubren el texto, el espectro y la zona objetivo; la evolución es 2015-2026 (los datos disponibles), no 2008-2023.
- C22, C23, C25, C26, C27, C28: aplicadas (C27 con Mussa, 1981, añadido para el canal de señales, como pedía K35).
- **C24**: aplicada con la notación de K12 ($\alpha$, $e^{\min}$, $e^{\max}$, fundamentos $m+v$) en lugar de $f$, $h$, $\underline e$; la solución del anexo, derivada de nuevo (Itô y *smooth pasting*).
- **C29**: aplicada; remisión del mercado único al **3.B.39** (el 3.B.37 es el presupuesto de la UE); `Singh2023Malaysia` (clave verificada) en vez de `Singh2023Malasia`; Brasil, Islandia, Chipre y Grecia con fechas pero sin fuente propia (duda).
- **C30**: aplicada en el reparto que pidió el coordinador: resultado en el cuerpo (a)-d), con gráfico, porque es imprescindible en el cante) y desarrollo en el anexo C; punto $D$ (K13) en vez de $C^{\tau}$; $\beta$ sin $\beta\equiv1/(1+\rho)$, porque aquí $\rho$ es la prima de riesgo de `eq:trilema`.
- C35, C36, C37: aplicadas (C36 con el enlace al simulador en caja, como el 3.B.12).

### Propuestas de datos (V)

V1-V6 aplicadas (V2: opción A con una frase de la B, decisión del coordinador); V7 parte 1; V8-V18 aplicadas; V19 aplicada (15 tipos con Hudson, sin el «80 veces»); V20-V23 parte 1; V24-V26 aplicadas; V27 parte 1 (`IlzetzkiReinhartRogoff2022` no se usa: basta la de 2019 y los datos); V28-V29 aplicadas; V30-V35 parte 1; V36-V41 aplicadas (V39: fuera Letonia; V40: Bulgaria solo como caja hasta 2025); V42 parte 1.

### Propuestas de coherencia (K)

K1-K26 en la parte 1 (K3 con los títulos del original; K6 aplicada como subapartados de nivel 3 de III). K27-K40 aplicadas (K30 en un `\subsubsection` propio, II.1.3, en lugar de dentro de II.1.2; K39 con cuerpo y anexo). K41-K43 (mapa y fichas del canon) quedan para la fase canon; K44: todas las remisiones que otros temas hacen al 3.B.15 quedan cumplidas.

## 6. Coherencia

- Notación del canon: $E$ directo, $q\equiv EP^*/P$, $\beta_K$ (movilidad) frente a $\beta$ (descuento), $i-i^*\approx\gamma E^e+\rho$, $\mathrm{BM}=\mathrm{CI}+R$, $e_t=\ln E_t$ y $\alpha$ de Cagan en Krugman, $\tau$ local (impuesto por unidad de deuda exterior), puntos $A$, $C$, $D$ y curvas $U_0<U_2<U_1$ como en el 3.B.12.
- Mismas cifras y clave del AREAER que el 3.A.32 y el 3.B.16 (`FMI2024AREAER2023`), mismas palabras para el euro en libre flotación; COFER y China como el 3.B.11 y el 3.B.13; mercado de divisas como el 3.B.13; libra en 1992 con las claves del 3.B.16; pegatinas del 3.A.32 y del 3.A.37 a propósito; nuevas «ni chicha ni limonada» (intermedios) y «más vale una palabra a tiempo que cien a destiempo» (persuasión), sin usar en otros temas.
- Paleta de los regímenes común en tabla y gráficos: anclaje duro azul, blando dorado, flotación rojo, otros gris.
- **Para `canon/pendientes-coherencia.md`** (no se tocan esos temas):
  - **PC1** [menor] **3.A.32, l. 403**: el dilema de Rey remite a `\vertema{3.A.37}`; debe remitir (o remitir también) a `\vertema{3.B.15}`, que lo desarrolla.
  - **PC2** [menor] **Ficha `ciclo-financiero`, sección 5**: «(`\vertema{3.B.14}`)» → `\vertema{3.B.15}`, y fila del 3.B.15 como desarrollo (referencia del ciclo financiero global, D2).
  - **PC3** [dato] **3.A.36: `GiavazziPagano1988Advantage` con pp. 1077-1082** (el comentario de Obstfeld) frente a pp. 1055-1075 y DOI 10.1016/0014-2921(88)90065-7 en el 3.B.16 y aquí: unificar en el artículo.
  - **PC4** [dato, cuando salga el AREAER 2026 definitivo] 3.A.32 (l. 408) y 3.B.16 (l. 41, 95): las mismas cifras y clave que el 3.B.15; Bulgaria ya en el euro.
  - **PC5** [nota] **3.B.14, l. 1097**: la esterilizada «solo funciona» con sustitutos imperfectos; el canal de señales no lo exige. Y 1D01 (aprobada), l. 1083 y 2455: controles «como último recurso» sin la revisión de 2022 de la Visión institucional (compatible como regla general).
- Otros: el Word del 3.B.19 copia el IS-LM-BP del 3.B.15 con «β = 0, movilidad perfecta»; el del 3.B.22 data el fin del patrón dólar-oro en 1975 (Jamaica es 1976, Segunda Enmienda en vigor en 1978). Para el 3.B.17 y el 3.B.19: que remitan al 3.B.15 por el trilema, Rey, el miedo a flotar y los controles.
- Canon (para `tema-canon`): fichas nuevas `trilema` (referencia 3.B.15, gráfico `graficos/trilema.tex`), `intervencion-cambiaria` y `controles-capital` (**[decidir]**), id `zonas-objetivo` sin ficha, `giavazzi-pagano` como alias de `barro-gordon`, filas nuevas de `notacion.md` § 9 (CC7).

## 7. Dudas abiertas

1. **Títulos** de II.1, III.1 y III.2 tomados del original frente a los de K3. *Aplicado*: los del original.
2. **Volcker** en la relevancia (es también el enganche del 3.B.13). *Aplicado* (control de calidad, 12/11/2026): fuera la cita; queda la idea con `\vertema{3.B.13}`.
3. **Friedman (1953) y el horario de verano**: comprobar la página.
4. **«La flexibilidad sigue ayudando… turismo… materias primas»** (Gopinath sin obra): *aplicado*, sin cita.
5. **Entradas sin comprobar en Crossref** (`Williamson1976Benefits`, `ReinhartRogoff2004Modern`, `LevyYeyatiSturzenegger2005Classifying`, `Shambaugh2004Effect`, `GhoshGuldeWolf2002Exchange`, `Frankel1999NoSingle`, `Frieden2015Currency`, `Eichengreen1994International`, `Williamson2000Exchange` —no se cita—, `Mussa1981Role`, `Funcas2022ODF77` con título aproximado).
6. **Frieden (2015)** y las devaluaciones retrasadas hasta después de las elecciones: página sin ver.
7. **AREAER**: *aplicado*, % de 2023 (iguales al 3.A.32 y al 3.B.16) más una frase con el avance de 2026, y ejemplos de 2026; *alternativa*, pasar todo a 2026 y actualizar los 3 temas (PC4).
8. **Criterios numéricos de cada régimen** (Habermeier *et al.*, 2009): el documento no se pudo leer (403); son los del original y los conocidos del sistema de 2009.
9. **Fechas finas de los controles** sin fuente propia: encaje chileno (20 % y 30 %); Brasil 2009-2013 lleva ahora `ForbesFratzscherStraub2015Capital` e Islandia, Chipre y Grecia `FMI2022RevisionVI` (12/11/2026), pero el texto del FMI no se pudo abrir (403) para ver que nombre los 3 casos y las fechas; y los controles de España, Irlanda y Portugal en septiembre de 1992, atribuidos a Eichengreen y Wyplosz (1993): comprobar la página.
10. **España 1959, 60 pesetas por dólar** y **Venezuela, control de cambios desde 2003**: sin cita (el 4.A.27 no está revisado).
11. **Número del Policy Paper** de `FMI2020IPF` (D8 de contenido).
12. **Solución de Krugman** del anexo B: derivada aquí, no cotejada con el artículo. El nombre «efecto divorcio» es el habitual en la literatura de preparación; no está en Krugman (1991), y Bertola y Caballero (1992) no se ha podido leer.
13. **Fratzscher *et al.* (2019)**, «más del 80 % de los casos según algunos criterios»: del resumen, sin ver la tabla.
14. **Gráficos de las monedas**: un gráfico por régimen en el anexo A (7) en lugar de pequeños múltiples; *alternativa*, uno solo de 6 paneles.
15. **Control de calidad (12/11/2026)**: la caída del córdoba en julio y agosto de 2001 (13,039 y 13,104) es un error de la serie de medias del BPI (M.NI.NIO.A): la serie de fin de mes del propio BPI (M.NI.NIO.E) sigue el deslizamiento sin saltos (13,4401 en junio, 13,5068 en julio, 13,5738 en agosto y 13,639 en septiembre). No se ha podido abrir la web del Banco Central de Nicaragua (la bloquea un antirrobots), así que no se ha cotejado con la fuente nacional. **Volcker**: con este tema aparece en 3 temas seguidos (el enganche del 3.B.13, una nota del 3.B.14 y la relevancia del 3.B.15). Se pide al editor que lo quite aquí; si Víctor prefiere conservarlo, basta con no aplicar esa corrección.
16. **`CBE2024Flotacion`**: no se ha encontrado el comunicado en cbe.org.eg (la web del Banco Central de Egipto rechaza las peticiones automáticas y el Internet Archive estaba fuera de servicio); sigue la copia en Amwal Al Ghad. Falta cambiarla por el enlace oficial a mano.

## 8. Instrucciones para el vídeo

- **Enganche**: el refrán «cada uno sabe dónde le aprieta el zapato» y Hillel a la pata coja / Klein («los Gobiernos se enfrentan al trilema; todo lo demás es comentario»). **Idea final**: Frankel (1999), el zapato otra vez y «eso es el trilema, y todo lo demás es comentario». Introducción y conclusión, sin pizarra.
- **Pizarra (imprescindibles)**:
  1. I: tabla de 2 columnas «tipo fijo / tipo flexible» que se va llenando por filas (políticas, perturbaciones reales y monetarias, inflación, comercio, crisis, reservas, sistema financiero, economía política), como `tab:fijo-flexible`; bajo ella, la lista de determinantes en I.3.
  2. El **triángulo del trilema** con un régimen en cada lado; después, el mismo triángulo con el vértice del tipo fijo en gris y la doble flecha roja del **dilema**.
  3. II.1: el **eje de los regímenes** (`regimenes-espectro`) con las 4 familias y su %; se dibuja por bloques de izquierda a derecha. En II.2, 2 flechas sobre ese mismo eje: hacia los extremos (visión bipolar) y hacia el centro (miedo a flotar).
  4. II.1.3: la **zona objetivo**, por partes: ejes, recta de 45°, bordes $e^{\min}$ y $e^{\max}$, la S aplanada (luna de miel) y al final la S invertida (divorcio).
  5. III.1: el **balance en T** del banco central ($\mathrm{BM}=\mathrm{CI}+R$) con la compra de 100 sin esterilizar y esterilizada, y la lista de los 3 canales.
  6. III.2: el **gráfico $(C_t, C_{t+1})$** por partes: ejes, $A$ y $U_0$, recta nacional y $C$ con $U_1$, déficit corriente, $D$ con la recta privada más inclinada y $U_2$.
- **Funciones clave que se conservan**: `eq:trilema` (PNCI con $\rho=0$) toda la exposición, porque vuelve en III.1.2 (canal de cartera, $\rho>0$); `eq:poole-abierta` en I.3. En III.2, la ecuación de Euler con $\tau$ junto al gráfico.
- **Como apoyo (no se dibujan)**: `tab:mundell-fleming` (de palabra, 2 casillas), `tab:areaer`, `tab:intermedios`, `fig:regimenes-evolucion`, `fig:reservas-mundiales` y las 7 series del anexo A.
- **España** vuelve como ejemplo en cada apartado con «Volvamos a España»: euro y trilema (I), SME y divorcio de la banda y el menú recorrido (II), tipos múltiples hasta 1959 y controles de 1992 (III), euro en la relevancia de la conclusión.
- Pegatinas: «no se puede nadar y guardar la ropa» (trilema), «cuando Estados Unidos estornuda, el mundo se resfría» (dilema), «más vale doblarse que quebrarse» (Friedman), la de Poole, «ni chicha ni limonada» (intermedios) y «más vale una palabra a tiempo que cien a destiempo» (persuasión).
