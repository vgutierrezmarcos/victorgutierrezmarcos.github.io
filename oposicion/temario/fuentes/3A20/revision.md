# Revisión del tema 3.A.20 — Poder de mercado y regulación óptima. Definición del mercado relevante. Desarrollos en presencia de información asimétrica. Aplicaciones prácticas

Revisión del 22/10/2026 (`/revisartema`, fase integrar). **Tema sin original de Víctor**
(CRITERIOS §5): todo el texto es nuevo.

## Resumen

- **Estructura**: sale del tema de **Miquel Tebar Barbero** («A.20 Poder de mercado y regulación
  óptima»), completada con el tema DCE 3.A.18 de **Manuel Cabado García** (Loeb-Magat,
  Baron-Myerson, teoría positiva, acceso, aplicaciones y la idea de la tabla de instrumentos). Se
  añadieron las fichas del canon y el anexo A del 3.A.17. No se copia texto de ninguno de los 2: los pasajes que el control de calidad encontró casi literales del tema de Cabado se reescribieron (ver «Contenido añadido»).
  Tres apartados: I. Poder de mercado, mercado relevante y regulación con información completa
  (8′: I.1 2′30″, I.2 2′30″, I.3 3′); II. Desarrollos en presencia de información asimétrica (11′:
  II.1 2′, II.2 2′, II.3 3′30″, II.4 2′, II.5 1′30″); III. Regulación con varias empresas y
  aplicaciones prácticas (7′30″: III.1 2′, III.2 1′30″, III.3 1′30″, III.4 2′30″). La introducción
  dura 2′30″ y la conclusión, 1′ (reparto decidido por Víctor el 23/10/2026, A20-02).
- **Tema de referencia**: el 3.A.20 pasa a serlo (P21-02, D092) de Averch-Johnson, Loeb-Magat,
  Baron-Myerson, el menú de Laffont-Tirole, el *price cap*, el *yardstick*, la captura del regulador
  y la definición del mercado relevante. Se usa la misma notación, las mismas ecuaciones y los
  mismos gráficos que el anexo A del 3.A.17, y cada modelo lleva sus bloques a)–e).
- **Ejemplo conductor**: *Redes del Valle*, una distribuidora eléctrica ficticia. Sale en la
  medida del poder, el SSNIP, la tarifa en dos partes, Averch-Johnson, Baron-Myerson,
  Laffont-Tirole (e* = 20, ē = 18, renta 6,5), *price cap*, captura, *yardstick* (20/22/24 →
  23/22/21), la concesión, el acceso y las aplicaciones.
- **Refranes**: el enganche es «Tener la sartén por el mango» y la idea final lo retoma. Pegatinas:
  «Más sabe el loco en su casa…» (información asimétrica), «El que algo quiere, algo le cuesta»
  (incentivos frente a rentas), «Las comparaciones son odiosas» (*yardstick*) y «Poner al zorro a
  cuidar de las gallinas» (captura).
- **Tamaño**: 35 páginas de tema, 8 de anexos y 7 de bibliografía (132 entradas en el .bib).
  Gráficos: 9, todos en TikZ (3 copiados del 3.A.17 y 6 nuevos, hechos y revisados por tema-tikz a partir de `_trabajo/graficos-pedidos.json`).

## Errores corregidos

No hay original, así que no hay errores de un tema anterior. Estos son los errores de las
referencias que **no** se han heredado (C27, P5-P13):

| Dónde (referencia) | Qué decía | Qué dice el tema |
|---|---|---|
| Tebar 2.2 | Monopolio natural «fuerte/débil»; en el tramo de deseconomías, «CMg < CMe» | Sostenible / no sostenible (3.A.17); con CMe creciente, CMg > CMe (I.3) |
| Tebar 3.2 | Ramsey con elasticidades cruzadas sin el margen del otro bien | Solo el caso de demandas independientes, \eqref{eq:ramsey-boiteux}, con remisión al 3.A.17 |
| Tebar 3 | «Precios óptimos de 1.er/2.º orden» | Primer, segundos y terceros óptimos, con nota (I.3) |
| Tebar 4.1 | La tasa de rentabilidad responde a «no conocer la demanda»; «p = CMe» | Responde a no conocer los costes eficientes; cubre costes de operación más s sobre la base de activos (II.1) |
| Tebar 4.2 | ψ'(e) = q con información completa | ψ'(e*) = 1 con proyecto de tamaño dado; ψ'(e) = q solo con C = (β − e)q (anexo) |
| Tebar 4.2 | IC con el esfuerzo donde va el coste | Forma reducida con Φ(e) = ψ(e) − ψ(e − Δβ) (II.3 y anexo) |
| Tebar 4.2 | Contrato de la ineficiente «b = 0 y a = 0» | a tiene que cubrir ψ(ē) (8,1 en el ejemplo; nota de II.3) |
| Tebar 4.2 | Probabilidad «p» del tipo eficiente | ν (canon) |
| Cabado 18.3 | TR = a + b(C − C^a), b = 0 precio fijo | t(C) = a − b(C − C^a), b = 1 precio fijo, b → 0 coste incrementado |
| Tebar 5.1 | *Yardstick* en la generación eléctrica | En las redes de distribución (III.1) |
| Tebar 6 | Guardianes de la DMA = «GAFAM» | 7 guardianes (Alphabet, Amazon, Apple, ByteDance, Meta, Microsoft y Booking), 23 servicios |
| Tebar 6 | «Los WhatsApp llegan a Telegram» | Interoperabilidad gratuita de las funciones básicas, a petición de otro proveedor (art. 7) |
| Tebar 2.1 | 40 % «para posición dominante»; 30 % sin norma | 50 % presunción (AKZO), por debajo del 40 % improbable (Directrices de 2026); 30 % del Reglamento 2022/720 |
| Tebar 4.3 | Reparto de beneficios de la telefónica de Florida | Quitado (sin fuente) |
| Tebar 4.3 | *Price cap* de «las llamadas telefónicas» en España | Cuota de abono de Telefónica hasta 2012 |
| Tebar 4.3 | Valor de la información mal explicado | Con ν mayor se distorsiona más a la ineficiente y baja Φ(ē) (II.3) |

## Marcas resueltas

El tema no tiene Word original: no hay marcas amarillas ni rojas, texto oculto, notas, comentarios
ni «Fuente:» vacías (`inventario.json` vacío). Los pendientes P1-P50 de `pendientes.md` quedan así:

- **P1-P4** (epígrafes del título): poder de mercado en I.1 e I.3, mercado relevante en I.2 y en el
  anexo B, información asimétrica en todo el bloque II y aplicaciones en III.4, con un ejemplo
  español en cada modelo de II.
- **P5-P13** (errores de las referencias): ver «Errores corregidos».
  - P8: ADIF va con la tarifa de la corriente de tracción (CNMC 2018) y con los cánones de la Ley
    38/2015.
  - P12: Autor *et al.* (2020) comprobado.
  - P13: Braeutigam y Armstrong-Sappington se citan sin páginas. Laffont-Martimort se cita sin la
    p. 41-43. Medicare se ha quitado.
- **P14-P21** (modelos del canon): todos desarrollados con su ficha; ver «Contenido añadido».
- **P22-P33** (coherencia): ver «Coherencia».
- **P34-P45** (figuras y tablas):
  - Hechos: `ssnip`, `regulacion-monopolio-natural`, `algoritmo-regulacion`, `averch-johnson`,
    `baron-myerson` (en lugar de `renta-informativa`), `menu-contratos` y `price-cap`, más
    `escala-potencia` y `peltzman` (pedidos de coherencia).
  - Tablas: `tab:instrumentos` (P43), `tab:supuestos-1tfeb`, `tab:que-observa` y
    `tab:ejemplo-laffont-tirole`.
  - No se hacen: P35 (el celofán va con la regla de Lerner y la derivación del anexo B); P36
    (Harberger con fórmula y remisión); P44 (la DMA va en viñetas); P45 (la serie de la tasa de
    retribución solo tiene 3 valores; los CSV están en `_trabajo/datos/` por si se quiere).
- **P46-P50**:
  - P46, refrán: «Tener la sartén por el mango».
  - P47, ejemplo conductor: Redes del Valle.
  - P48, bibliografía: `3A20.bib`.
  - P49: `seo.json`.
  - P50: las referencias de Cerezal y de Fuentes eran de otro tema y no se usan.

## Datos actualizados

Todos se han consultado el 22/10/2026. No hay «valor anterior» porque el tema es nuevo: en esa
columna va lo que decían las referencias.

| Dato | Valor anterior (referencias) | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Comunicación de definición de mercado | no citada | C/2024/1645, DO C de 22/2/2024; sustituye a la de 1997 (punto 116) | Comisión Europea | https://eur-lex.europa.eu/eli/C/2024/1645/oj | 22/10/2026 | CMS y Gibson Dunn |
| SSNIP | 5-10 % (3.A.18) | 5-10 %, «pequeño, pero significativo y no transitorio» (punto 29, nota 53) | Comisión Europea | ídem | 22/10/2026 | Comunicación de 1997, punto 17 |
| SSNDQ y plataformas | «desde Google Android», sin cita | Punto 30, nota 54 (Google Android); puntos 94-98 | Comisión Europea | ídem | 22/10/2026 | Noerr, Mondaq |
| Falacia del celofán | — | Nota 55; du Pont, 351 U.S. 377 (1956) | Comisión Europea | ídem | 22/10/2026 | Tirole (1988) |
| Umbrales de dominancia | 40 % | ≥ 50 % presunción (AKZO); < 40 % improbable (punto 24) | Directrices art. 102, C(2026) 6118 | página de la Comisión | 22/10/2026 | Página del art. 102 (retirada de la Orientación de 2009) |
| Acuerdos verticales | 30 % sin norma | 30 % (art. 3 del Reglamento 2022/720) | DOUE | https://eur-lex.europa.eu/eli/reg/2022/720/oj | 22/10/2026 | Considerandos 8-9 |
| *De minimis* | — | 10 % entre competidores, 15 % entre no competidores (puntos 8-9) | Comunicación 2014/C 291/01 | EUR-Lex | 22/10/2026 | Una sola lectura |
| IHH de concentraciones | — | < 1.000; 1.000-2.000 y Δ < 250; > 2.000 y Δ < 150 (apdos. 19-20); revisión prevista para el 4.º trimestre de 2026 | Directrices de 2004 | EUR-Lex | 22/10/2026 | 3.A.15 (V2) |
| Tasa de retribución eléctrica | Cabado, sin fecha | 6,58 % en 2026-2031 (antes 5,58 %) | Circular 9/2025, BOE-A-2025-27019 | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-27019 | 22/10/2026 | Nota de prensa de la CNMC de 22/12/2025 |
| Tasa de retribución gasista | — | 6,46 % en 2027-2032 (transporte y regasificación) | Circular 5/2026, BOE-A-2026-19426 | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-19426 | 22/10/2026 | Nota de prensa de la CNMC |
| DORA 2027-2031 | Aena, sin datos | IMAP 10,52 € (2026) → 10,69 € (2031); X = +0,33 % (se suma); CNMC −0,59 %, Aena +3,82 % | BOE-A-2026-19507; informe de la CNMC | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2026-19507 | 22/10/2026 | Nota del Ministerio de 15/9/2026 |
| Cánones de ADIF | sin norma | Coste directamente imputable más recargos «si el mercado puede aceptarlo» | Ley 38/2015 | https://www.boe.es/buscar/act.php?id=BOE-A-2015-10440 | 22/10/2026 | Directiva 2012/34/UE, arts. 31-32 |
| RIIO-3 | sin periodo | Abril de 2026-marzo de 2031; rentabilidad de los fondos propios del 5,70 % (electricidad) y del 6,12 % (gas), reales; eficiencia del 1 % anual | Ofgem, Final Determinations (4/12/2025) | ofgem.gov.uk (anexo financiero y ET) | 22/10/2026 | Ashurst, Oxera |
| Excepción ibérica | — | Desde el 14/6/2022, 40 €/MWh con senda creciente; prorrogada hasta el 31/12/2023 | RDL 10/2022 (BOE-A-2022-7843), Orden TED/517/2022, RDL 3/2023 (BOE-A-2023-7937) | boe.es | 22/10/2026 | Informe de la CNMC, GA_P |
| Telecomunicaciones | — | Recomendación 2020/2245: 2 mercados mayoristas (acceso local fijo y capacidad dedicada) | DOUE L 439 | https://eur-lex.europa.eu/eli/reco/2020/2245/oj | 22/10/2026 | Comunicación de 2024, nota 36 |
| Desregulación de NEBA | — | Desde octubre de 2021 solo el 30 % de la población; retirada el 13/8/2025 con 6 meses de transición; se mantiene la infraestructura física | Nota de prensa de la CNMC | https://cnmc.es/prensa/desregulacion-banda-ancha-fija-20250813 | 22/10/2026 (leída por el editor) | Propuesta de contenido C18 |
| DMA, guardianes | «GAFAM» | 7 guardianes y 23 servicios | Comisión, portal DMA | https://digital-markets-act.ec.europa.eu/gatekeepers-portal_en | 22/10/2026 | Comunicado de 6/9/2023 (SEAE) |
| DMA, umbrales y multas | — | 7.500 / 75.000 millones, 45 millones de usuarios y 10.000 profesionales; 10 % y 20 % | Reglamento 2022/1925 | https://eur-lex.europa.eu/eli/reg/2022/1925/oj | 22/10/2026 | eu-digital-markets-act.com |
| Multas de la DMA | — | Apple 500 M€ y Meta 200 M€ (23/4/2025); Google 890 M€ (23/7/2026) | Comisión Europea | digital-markets-act.ec.europa.eu | 22/10/2026 | Brussels Times; Concurrences |
| Google Shopping y Android | — | 2.424 M€ (TJUE, 10/9/2024) y 4.125 M€ (TJUE, 2/7/2026); mismas cifras y claves que el 3.A.15 | TJUE | curia.europa.eu | 22/10/2026 | 3.A.15 |
| Nobel de Tirole | — | 2014, «por su análisis del poder de mercado y la regulación» | nobelprize.org | https://www.nobelprize.org/prizes/economic-sciences/2014/press-release/ | 22/10/2026 | 3.A.13, 3.A.15 |
| Autor *et al.* (2020) | sin páginas | *QJE* 135(2), 645-709 | Harvard, LSE | — | 22/10/2026 | RePEc |
| Guasch, Laffont y Straub (2008) | — | 307 concesiones de agua y transporte en América Latina, 1989-2000; alta incidencia de renegociaciones | *IJIO* 26(2), 421-442 | https://ideas.repec.org/a/eee/indorg/v26y2008i2p421-442.html | 22/10/2026 (leído por el editor) | — |

## Contenido añadido

Todo el tema es contenido nuevo. Estado de cada propuesta:

- **Propuestas de contenido (C1-C33)**: aplicadas de C1 a C24, C28, C29, C30 y C33, con estos
  cambios:
  - **C2**: sin la cifra de «algo más de 2.000 millones» del enganche, que solo daba *Forbes*.
  - **C3**: refrán aceptado; se quitan «Ojos que no ven…» y «No mezclar churras con merinas».
  - **C4**: su tabla de supuestos de las estructuras de mercado se sustituye por la del 1TFEB (K7,
    como en el 3.A.22 y el 3.A.23): el supuesto 3 se levanta en el bloque I y el 5 en el II.
  - **C5**: la Orientación de 2009 está retirada. La definición del poder de mercado se cita con las
    Directrices de 2004 (apdo. 8) y el 40 % con las Directrices de 2026.
  - **C7**: punta y valle solo de palabra (K12), sin p_p = b + β.
  - **C9 y C18**: el TOTEX de la Circular 8/2025 va sin «desde 2029», porque no se leyó la circular.
  - **C11**: la pegatina «Ojos que no ven» se cambia por «El que algo quiere, algo le cuesta».
  - **C15**: Medicare quitado (no comprobado en Shleifer, 1985).
  - **C16**: Guasch, Laffont y Straub solo con lo que dice su resumen; fuera «más de la mitad» y
    «3,5 años».
  - **C18**: fuera Google Adtech (solo prensa), el recurso contra la Circular 9/2025 (el anuncio
    del BOE no se pudo leer) y las *killer acquisitions* (sin cita). La excepción ibérica pasa al
    texto, con los datos del BOE.
  - **C18, tabla de instrumentos**: la idea es de la tabla 18.1 de Manuel Cabado. En el tema se
    cita como elaboración propia a partir de Laffont-Tirole (1993) y Armstrong-Sappington (2007),
    porque CRITERIOS no permite nombres de preparadores; el crédito queda aquí.
  - **C21-C23**: claves cambiadas por las de los datos, y el 40 % citado con las Directrices de
    2026.
  - **C25-C27 y C31-C32**: son informativas; se recogen en este informe.
- **Propuestas de datos (V1-V27)**:
  - Aplicadas: V1-V13, V15 (Shopping y Android), V16, V17, V19, V21-V26.
  - No aplicadas: V14 (nube de AWS y Azure, sin fuente primaria); la parte de Adtech de V15 (solo
    prensa); V18 (el límite del 0,13 % del PIB, sin segunda comprobación); V20 (el DORA anterior no
    hacía falta); V27 (no se hace el gráfico de datos).
- **Propuestas de coherencia (K1-K34)**:
  - Aplicadas: K1-K3, K4 (con a)–e) en todos los modelos), K5-K28, K29 (sin el enganche propuesto),
    K30-K34.
  - Cambio: Víctor decidió el refrán «Tener la sartén por el mango» en lugar de «Más sabe el loco…»,
    que pasa a pegatina.
  - K6: el ejemplo de la distribuidora se hace con los números de C11 (e* = 20, ē = 18, renta 6,5),
    no con los de K6.
  - K16: el gráfico de la renta informativa es `baron-myerson`.
- **Lo nuevo frente al temario**:
  - Baron-Myerson como modelo propio, con su derivación.
  - El mercado relevante desarrollado: pérdida crítica, celofán, SSNDQ y Comunicación de 2024.
  - El modelo de Peltzman con su condición de primer orden y un gráfico de iso-apoyo (anexo C).
  - La escala de la potencia de los incentivos, como mapa de los instrumentos.
  - La regla del precio eficiente de los componentes con Armstrong-Doyle-Vickers.
  - Las aplicaciones de 2025-2026: tasas de la CNMC, DORA III, RIIO-3, NEBA y multas de la DMA.
- **Anexos**:
  - A. Derivaciones: Averch-Johnson, Baron-Myerson, Laffont-Tirole, *yardstick* y acceso.
  - B. Mercado relevante en la práctica.
  - C. Peltzman.
  - D. Marco normativo e instituciones: CNMC, Comisión y Ofgem.
  - E. Qué estudia cada tema del bloque.
  - F. Test, con el enlace único al simulador.

- **Reescritura tras el control de calidad** (22/10/2026). Se compararon todas las líneas del tema
  con el tema DCE 3.A.18 de Cabado buscando 8 palabras seguidas iguales, y se reescribieron con
  otra sintaxis y otro orden las que coincidían:
  - definiciones de la introducción y de I.1 a I.2;
  - riesgo moral y renta informativa;
  - efecto Averch-Johnson, Baron-Myerson, *price cap*, esquemas intermedios e inconsistencia
    temporal;
  - captura (Laffont-Tirole 1991), apertura de III, Demsetz y Laffont-Tirole 1987;
  - la regla del precio eficiente de los componentes entera, que además pasa a ser un modelo con
    a) Idea, b) Modelo (i, ii, iii) y c) Valoración, y su anexo A.5;
  - redes en III.4, excepción ibérica, RIIO, telecomunicaciones y NEBA;
  - la DMA, cuya nota de umbrales pasa a ser la lista del art. 3.2 del Reglamento 2022/1925, y su
    lectura teórica;
  - las instituciones del anexo D y varias frases de las derivaciones.

  En una segunda pasada se reescribieron otras 12 frases y se rehízo la tabla de instrumentos
  (`tab:instrumentos`), que ahora compara los instrumentos por sus propiedades.
  Solo quedan coincidencias en nombres propios (la CNMC), títulos oficiales de normas, datos y
  fórmulas. RIIO ya no dice «desde 2013», porque esa fecha no está en las fuentes citadas. Se han
  añadido citas a las viñetas de umbrales y de la DMA del anexo de test.

## Coherencia

- **Supuestos**: tabla del 1TFEB con la misma numeración que el 3.A.22 y el 3.A.23 (el 3 es la
  precio-aceptación y el 5, la información).
- **Notación**: la del canon.
  - 𝓛 es el índice de Lerner, así que ningún problema se escribe con lagrangiana.
  - IHH ≡ Σ(100 s_i)² ∈ (0; 10.000].
  - w_K, s y μ en Averch-Johnson, con nota de que s no es la cuota s_i.
  - β̲, β̄, ν, Φ y λ en Laffont-Tirole, con la nota de la λ común con Ramsey; b = 1 es el precio
    fijo; p_{t+1} ≤ p_t(1 + IPC_t − X).
  - Letras nuevas locales, que hay que proponer al canon (C31): S(q), α (Baron-Myerson),
    𝒜 (Peltzman), A, c_a, c_I, c_E y d (acceso), τ y ℓ^c (pérdida crítica).
- **Promesas de otros temas que se cumplen aquí**:
  - 3.A.12: el *yardstick* con DEA y frontera estocástica y el regulador alemán.
  - 3.A.15: competencia por el mercado, acceso y mercados de 2 lados, con las mismas palabras y
    claves.
  - 3.A.16 y 3.A.17: monopolio natural resumido.
  - 3.A.18: el SSNIP «entre un 5 y un 10 % … no transitoria».
  - 3.A.19: el IHH y Cowling-Waterson.
  - 3.A.22: *second best* y monopolio contaminante.
  - 3.A.23: menú de contratos, Peltzman y captura, sin su refrán.
- **Cambios que esto pide en otros temas** (no se tocan ahora; las entradas están en
  `canon/pendientes-coherencia.md`, texto listo en `_trabajo/propuestas-coherencia.md`, C8):
  - **3.A.13**: las 4 remisiones de Laffont-Tirole y de la regulación con información asimétrica
    (relevancia, selección adversa, riesgo moral y conclusión) pasan de `\vertema{3.A.17}` a
    `\vertema{3.A.20}`; en la relevancia y en la conclusión pueden quedar las 2.
  - **3.A.14**: la regulación como diseño de mecanismos (l. 1089 y 1150) pasa a
    `\vertema{3.A.20}`.
  - **3.A.17, anexo A**:
    - `anexo:nueva-teoria-regulacion` se resume en una viñeta por instrumento, con
      `\vertema{3.A.20}`.
    - Se quitan `fig:averch-johnson` y `anexo:aj`, que ahora están aquí con la misma etiqueta.
    - La teoría positiva pasa a 2 viñetas, y la anotación de ProMarket y Stigler Center se puede
      mover aquí.
    - La notaopositor de la l. 1126 pasa de «se desarrollan» a «se resumen».
  - **3.A.12** (l. 1132): basta `\vertema{3.A.20}` para el *yardstick* (opcional).
  - **3.A.22**: la fila 3 de la tabla del 1TFEB puede añadir `\vertema{3.A.20}` (opcional).
- **Canon** (C1-C7 de coherencia):
  - Las fichas `averch-johnson`, `laffont-tirole`, `price-cap`, `yardstick` y `captura-regulador`
    pasan a «tema de referencia: 3.A.20».
  - En `mapa.yaml`, el nombre «tasa de rentabilidad».
  - Gráfico de referencia nuevo `menu-contratos` y Baron-Myerson dentro de `laffont-tirole`.
  - En `price-cap`, la X del DORA ya está comprobada (+0,33 %).
- **Sin revisar**:
  - 4.A.12 escribe ṗ ≤ IPC − X.
  - 4.B.15 escribe t = a + b(C − C^a) y remite al «3.A.15» antiguo.
  - 3.A.6, 3.A.36 y 3.A.41 duplican «[ver tema 3.A.20]».

## Dudas abiertas

**Decididas por Víctor el 23/10/2026**:

1. **Refrán del enganche** (A20-01): **decidido**, se mantienen «Tener la sartén por el mango» y
   las pegatinas «Más sabe el loco…», «El que algo quiere…», «Las comparaciones son odiosas» y
   «Poner al zorro…». Hay que añadirlos a la lista de CRITERIOS §8.
2. **Baron-Myerson en el cuerpo** (A20-02): **decidido**, sigue en el cuerpo (II.2, 2′ con
   Loeb-Magat, con gráfico).
3. **Reparto** (A20-02, opción c): **decidido**, 8′ / 11′ / 7′30″. Se pasa medio minuto de II a I:
   II.5 (compromiso y captura) baja de 2′ a 1′30″ y I.3 (información completa) sube de 2′30″ a 3′.
   Cambiados los `\minutos{}` de I y II, la nota del reparto y los `\tiempo{}` de los párrafos
   «En el cante» de I y II.
4. **Fichas nuevas del canon** (A20-03): **decidido**, se aprueban `mercado-relevante` (SSNIP,
   celofán, pérdida crítica, SSNDQ), `competencia-por-mercado` (Demsetz, Williamson,
   Laffont-Tirole 1987) y `precio-acceso` (regla del precio eficiente de los componentes,
   Armstrong-Doyle-Vickers), con el 3.A.20 como tema de referencia, y Baron-Myerson dentro de
   `laffont-tirole`.
5. **El DORA como *price cap*** (A20-04): **decidido**, se presenta así, con la advertencia de que
   su X (+0,33 %) se suma y cuadra ingresos con costes.
6. **Lo quitado por no estar comprobado** (A20-05): **decidido**, se queda fuera:
   - Google Adtech (2.950 M€, solo prensa).
   - La designación de AWS y Azure en la DMA.
   - El recurso contra la Circular 9/2025.
   - Medicare en Shleifer (1985).
   - «Más de la mitad, a los 3,5 años» de Guasch *et al.*
   - La cifra de Forbes del enganche.
   - El «desde 2029» del TOTEX y el 0,13 % del PIB de la Circular 8/2025.
   - Las *killer acquisitions*.

**Siguen abiertas**:

7. **Referencias por verificar**:
   - Los identificadores del BOE de los RDL 10/2022 (BOE-A-2022-7843) y 3/2023 (BOE-A-2023-7937)
     los dio el agente de datos con las URL del BOE; conviene confirmarlos al publicar.
   - El de la Ley 11/2022 (BOE-A-2022-10757).
   - Las páginas de Willig (1979), que no están en el .bib.
   - Las Directrices del art. 102 de 2026, que no tienen referencia del DO (se cita
     C(2026) 6118).
   - Si las directrices europeas de concentraciones se aprueban antes de publicar, hay que
     revisar los umbrales del IHH.
8. **Directrices de concentraciones de EE. UU.**: van en una nota (IHH > 1.800 y Δ > 100). Sirve
   como dato del 3.A.15, sin segunda comprobación propia aquí.

9. **Control de calidad (22/10/2026)**: los identificadores del BOE de la duda 7 están comprobados en boe.es (BOE-A-2022-7843 es el RDL 10/2022; BOE-A-2023-7937, el RDL 3/2023; BOE-A-2022-9435, la Orden TED/517/2022; BOE-A-2022-10757, la Ley 11/2022), igual que el 6,58 %, el 6,46 % y el DORA (10,52 → 10,69 €, X = +0,33 %) y los 23 servicios de la DMA. Quedan correcciones de redacción pendientes (texto demasiado cercano al tema DCE 3.A.18).

10. **Control de calidad, segunda pasada (22/10/2026)**: 0 errores en `verificar-tema.py`; las correcciones (ECPR con a)–c), citas del anexo de test, RIIO sin «desde 2013», nota de umbrales de la DMA) se ven bien en el PDF y el HTML, y las cifras de Redes del Valle cuadran (IHH 10.000; 90 M€; Baron-Myerson 80/60/40, rentas 800 y 1.200; Laffont-Tirole e* = 20, ē = 18, Φ(18) = 6,5, ψ(18) = 8,1, pagos 96,5 y 100,1; *price cap* 40,40; *yardstick* 23/22/21). Sigue habiendo pasajes de 8 palabras o más iguales al tema DCE 3.A.18 de Cabado que no son nombres, normas, datos ni fórmulas, en las líneas del .tex 86 y 261 («el regulador conoce los costes y la demanda»), 269 («una sola empresa preserva la eficiencia productiva, pero»), 275 («Cada euro de subvención cuesta a la sociedad»), 404 («se traslada al precio en la siguiente revisión»), 480 («solo es aceptable si los fondos públicos no…»), 628 («y la extracción de rentas se resuelve con…»), 677 («Como el precio no depende de los costes… cada euro que la empresa ahorra es un euro de beneficio»), 678 («…Ramsey-Boiteux que el regulador no necesita calcular»), 970 («y el resto del servicio, c_I. Un entrante con…»), 1011 («los efectos de red, los costes hundidos y…») y 1115 («la transición energética exige grandes inversiones en redes, que solo llegarán…»). Además, la tabla resumen de instrumentos (líneas 1076-1098, «elaboración propia») sigue la de Cabado («Efectos y limitaciones de los instrumentos de regulación»): mismas filas, columna «Limitación principal» y celdas casi iguales («óptima / débil / coste de los fondos públicos», «pérdida pequeña», «precios sin la lógica de Ramsey», «sobrecapitalización», «distorsión en el tipo ineficiente», «alta en el eficiente», «alta al pujar», «colusión y heterogeneidad»). Con Tebar solo coinciden el título y «la inversa de la elasticidad de la demanda». **Resuelto (22/10/2026, editor)**: reescritas las 12 líneas con otras palabras y rehecha la tabla de instrumentos con otra organización: grupos por información (completa, asimétrica, varias empresas) y columnas por propiedad (potencia $b$, si empuja a abaratar, renta para la empresa, qué tiene que saber el regulador, qué puede salir mal), con celdas propias. El cotejo con un script (secuencias de 8 palabras, sin tildes) solo encuentra coincidencias en nombres propios (CNMC, «primer teorema fundamental de la economía del bienestar», «regla del precio eficiente de los componentes»), títulos de normas (DMA, Directiva 2018/1972, Comunicación de 2024), el título del tema, la cita del Nobel, datos (10,52 euros por pasajero; 45 millones de usuarios y 10.000) y fórmulas.

## Instrucciones para el vídeo

- **Introducción y conclusión**, sin pizarra (`modo: guion`).
  - Enganche: «Tener la sartén por el mango» y la tasa de retribución eléctrica del 6,58 % («¿es
    mucho o es poco? quien mejor lo sabe es la empresa»).
  - Idea final: la regulación óptima no le quita la sartén al monopolista natural; le paga lo justo
    para que nos deje ver lo que hay dentro, la renta informativa.
- **Funciones clave que se conservan** (`\funcionclave`, `conservar:`):
  - El índice de Lerner `eq:lerner`, en la esquina superior izquierda todo el cante.
  - La condición del esfuerzo de Laffont-Tirole `eq:laffont-tirole`, debajo, desde II.3.
  - La regla del *price cap* `eq:price-cap`, que se escribe en II.4 y se deja en una esquina.
- **Bloque I** (rejilla «35|65»):
  - Lerner a la izquierda.
  - A la derecha, `ssnip` por capas mientras se aplica a Redes del Valle.
  - Después, `regulacion-monopolio-natural`, que ya conoce quien estudió el 3.A.17.
  - La regla de Ramsey-Boiteux se escribe junto a la de Lerner («Lerner amortiguado»).
  - Como apoyo: la tabla del 1TFEB (iluminando las filas 3 y 5) y el esquema
    `algoritmo-regulacion`.
- **Bloque II** (rejilla «35|65(55/45)», con la franja de abajo para la escala):
  - `averch-johnson` trazado entero, con 5 capas.
  - `baron-myerson`, con el ejemplo 80/60/40 y la renta de 800.
  - El menú a mano, 2 rectas (`menu-contratos`).
  - La tabla del ejemplo de Laffont-Tirole como apoyo.
  - `price-cap` como apoyo que se mueve por capas.
  - **Gráfico conjunto por partes**: la **escala de la potencia** (`escala-potencia`) crece con la
    exposición. Tasa de rentabilidad en b = 0 (II.1), menú (II.3), *price cap* en b = 1 (II.4),
    esquemas intermedios (II.4) y *yardstick* en b = 1 sin rentas (III.1). No se escribe 2 veces.
  - Refranes pegatina junto a su concepto: «Más sabe el loco…» al empezar II, «El que algo
    quiere…» junto a Φ(ē) y «Poner al zorro…» junto a Stigler (1971).
  - La condición de Peltzman (B'(p) > 0) se escribe en una línea; su gráfico es solo de anexo.
- **Bloque III** (rejilla «50|50»):
  - El *yardstick* a mano: p_i = c̄_{−i} y los números 20-22-24 → 23-22-21, con «Las
    comparaciones son odiosas».
  - La regla del precio eficiente de los componentes en una línea: A = p − c_I.
  - Las aplicaciones de palabra, cada una con su «lectura teórica».
  - La tabla `tab:instrumentos` como apoyo al final; la escala, completa.
- **Ejemplo conductor**: se intercala siempre con frases naturales («Volvamos a Redes del
  Valle…»), nunca con la palabra «hilo».
- **Gráficos**:
  - En la pizarra: `ssnip`, `regulacion-monopolio-natural`, `averch-johnson`, `baron-myerson`,
    `menu-contratos` y `escala-potencia`.
  - Como apoyo: `algoritmo-regulacion`, `price-cap`, `peltzman`, las tablas del 1TFEB y de lo que
    observa el regulador, y `tab:instrumentos`.
