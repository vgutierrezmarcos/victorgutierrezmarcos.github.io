# Revisión del tema 3.A.18 — Análisis de mercados (III). Diferenciación de productos: la teoría de la competencia monopolística y otros desarrollos.

Fecha: 19/10/2026. Integración en tres partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III y la conclusión; la 3, los anexos, la bibliografía, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md` (Word de `oculto/`, 10/08/2024), `pendientes.md` (P1-P76), `estructura.md`, `propuestas-contenido.md` (C1-C29) y `propuestas-coherencia.md` (K1-K60, estructura final). Integradas también `propuestas-datos.md` (V1-V45, E1-E6) y `bib-datos.bib`, llegadas al final: las entradas comunes del `.bib` se sustituyen por las comprobadas por datos. Se aplican las decisiones del orquestador (estructura, enganche, Dixit-Stiglitz con Cobb-Douglas, notación del canon y ninguna cita a ICEX-CECO ni a preparadores).

## Resumen

- Nueva fuente `3A18.tex` en **3 bloques** (el original tenía 2): I. Competencia monopolística, enfoque de no direcciones (caracterización con la tabla común, Chamberlin, Dixit-Stiglitz); II. Oligopolio con diferenciación horizontal (caracterización; sin direcciones: Bertrand y Cournot con producto diferenciado, nuevo; con direcciones: Lancaster, Hotelling con localización dada y elegida, Salop); III. Diferenciación vertical y otros desarrollos (Shaked-Sutton; publicidad, con Dorfman-Steiner, y proliferación de marcas, nuevos en el cuerpo). Minutos: 2'30" + 10'30" + 10'30" + 5'30" + 1' = 30'. Con marcadores de gráficos, 30 páginas de tema.
- Hilo conductor: el margen sobre el coste marginal depende de lo distintas que sean las variedades (𝓛 = 1/σ, p = μc, función clave que se queda en la pizarra; debajo, p^B − c, t, t/n, ∝ Δs y la regla de Dorfman-Steiner) y el mercado no garantiza la variedad óptima.
- Corregidos unos 25 errores de teoría y fórmulas (Dixit-Stiglitz sin renta, signo del *mark-up*, σ > 1 «por convexidad», demanda de B con localizaciones generales, costes «cuadráticos» por lineales, captura de Salop con n° > n*, corto plazo de Chamberlin sin beneficios, atribución de Shaked-Sutton…); resueltas las 2 marcas amarillas (P1, P2).
- Datos integrados (V1-V45): cita de Joan Robinson corregida (*Essays in the Theory of Economic Growth*, 1962, p. 33), CNAE-2025, Foltyn 2012, «Rey (2007)» → Ivaldi et al. (2003), cereales y FTC, y 3 datos nuevos breves (comercio intraindustrial de turismos con Alemania, inversión publicitaria y marcas de la OEPM en 2025).
- 11 anexos (Chamberlin, derivaciones de Dixit-Stiglitz, bienestar y número de variedades, Hotelling, finitud, Lancaster, mercado relevante, empírica y elección discreta, colusión, publicidad, test y preguntas del tribunal); las capturas en inglés de Foltyn (anexo 8) se sustituyen por derivaciones propias.
- `3A18.bib` con 68 entradas (todas citadas); 11 gráficos pedidos en `_trabajo/graficos-pedidos.json`; `seo.json` nuevo.

## Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Intro, relevancia | El poder de mercado «conduce a pérdidas de bienestar (no se alcanza el óptimo social de Pareto)» | Falla un supuesto del 1TFEB y el equilibrio no tiene por qué ser eficiente, pero hay que contar el valor de la variedad (K15) |
| Intro, contextualización | «Hasta la década de 1930»; Sraffa solo en nota y sin fecha | Hasta los años 20; Sraffa (1926) → Robinson y Chamberlin (1933) (P53) |
| Nota 2 | «Kevin Lancaster» | Kelvin (P71) |
| I.1 | «Información perfecta» sin «simétrica»; frase duplicada; «inoperancia del 1TFEB» | Lista común con la fila 3 levantada; falla un supuesto del 1TFEB (C3, K24) |
| I.2, corto plazo (l. 223) | «En nuestro ejemplo, no hay beneficios» y luego entrada por beneficios | Corto plazo con beneficios (P66, K16) |
| I.2 (l. 242) | La estructura de costes «varía» a largo plazo y permite bajar precios | Ajuste por entrada y desplazamiento de d y D (anexo A) |
| I.2 (l. 204) | Demanda efectiva: «el mejor precio y la mayor cantidad posible» | Demanda de cuota con todos los precios iguales |
| I.2 (l. 293) | «2 fuentes de ineficiencia asignatoria» | Ineficiencia asignativa (p > CMg) y productiva (p = CMe > min CMe) |
| I.2, valoración (l. 321, 325) | «Los resultados perfectamente competitivos pueden ser alcanzados… es deseable»; comparación con mercados impugnables | Quitado: contradice p > CMg y el exceso de capacidad |
| Nota 10 | Demanda de cuota mal escrita (S·[(1/n)·b·(p_i − p*)], b y B mezclados) | q_i = S[1/n − b(p_i − p̄)] (Krugman, Obstfeld y Melitz, 2018) |
| I.3 (l. 512) | y = (1−α)/[Σp_j^{1−σ}]^{1/(1−σ)}, sin la renta | P·y = αW̄ (α es ahora la parte del gasto en el grupo) (P67a) |
| I.3 (l. 581) | El *mark-up* depende **negativamente** de la preferencia por la variedad | Positivamente: menor σ, mayor μ (P67b) |
| Nota 13 | «A mayor σ, mayor preferencia por la variedad» | A mayor σ, menor (y = n^{1/(σ−1)}X) (P67c) |
| l. 399 y nota 14 | σ > 1 «implícito en curvas convexas» | La convexidad solo exige σ > 0; σ > 1 hace la demanda de cada variedad elástica (P46) |
| P1 (l. 530) | La demanda de cada variedad depende **positivamente** de σ | σ no la desplaza en un sentido fijo: la hace más elástica (P1) |
| I.3 (l. 488) | Las 2 etapas por ser U homotética | Por la separabilidad débil con agregador homogéneo de grado 1 |
| I.3 (l. 634) | Las empresas «no operan en el mínimo del CMe» | Con c constante el CMe no tiene mínimo: economías de escala sin agotar (CMe > CMg) |
| I.3 (l. 638) frente a anexo 3 | «No sabremos si el mercado genera la cantidad óptima» / «el mercado genera la cantidad óptima» | Óptimo restringido = equilibrio con CES; el primer óptimo tiene la misma escala y más variedades (derivación propia en el anexo C) (P67g, K15) |
| I.3, valoración y extensiones | Valoración antes que extensiones; enlace HAL de Galí que apunta a otro documento | Orden a)–e); Galí (2015) |
| Nota 25 | Teoría de juegos «[tema 3.A.10]» | \vertema{3.A.14} (P48) |
| II (l. 716-720) | Barreras «por parte del monopolista» copiadas del 3.A.17 | Remisión al 3.A.15 |
| II.3.1 (l. 865, 1054, 1183) | «Producto homogéneo, solo se diferencia en la localización» | El mismo bien salvo en la característica que mide la localización (P68) |
| Nota 29 | «Con costes **cuadráticos** puede no haber equilibrio» | Con costes **lineales** (d'Aspremont, Gabszewicz y Thisse, 1979) (P68) |
| II.3.2 (l. 987) | D_B = (p_A − p_B − tb² + ta²)/(2t(b−a)), que no es 1 − x̃ | x_2 = 1 − x̃ con x̃ = (a+b)/2 + (p_2 − p_1)/(2t(b−a)) |
| Nota 34 | «= 0» en un término que no se anula | Solo se anula el efecto a través del propio precio (envolvente); efectos demanda (b−5a+2)/(6Δ) y estratégico (2a−4)/(6Δ) (anexo D) |
| II.3.2 | Sin decir que Hotelling (1929) concluyó la diferenciación mínima | Mínima (Hotelling) frente a máxima (d'Aspremont et al.) |
| II.3.3 Salop (l. 1052, 1072, notas 37, 38) | Localización elegida / equidistante / exógena / «es un resultado» | Equidistancia como supuesto; nota de Economides (1989) (P69) |
| Imagen sin título de Salop (p. 29) | n_S = ½√(t/F) > √(t/F) = n* (captura ajena) | n° = ½√(t/CF) = n*/2: entrada excesiva (P35) |
| II.3.3, valoración | «Comprender mercados disputados» | Valoración nueva (localización simétrica supuesta, demanda unitaria) |
| II.3.4 | Duopolio de calidades atribuido a Shaked y Sutton (1983); «compiten simultáneamente»; intervalo «de tamaño unitario» sin θ̄ − θ̲ = 1; nota 43 confusa | Gabszewicz y Thisse (1979) y Shaked y Sutton (1982); finitud de 1983; 2 etapas; θ̄ − θ̲ = 1; nota reescrita (P70) |
| Nota 49 | «La CES es una variante del logit» | El logit puede dar fundamento a la CES (Anderson, de Palma y Thisse, 1992) |
| Nota 4 | CNAE-2009 | CNAE-2025 (Real Decreto 10/2025) (V1) |
| Pie de la Imagen 5 y bibliografía | Foltyn (2009) y (2012) | Foltyn (2012), revisado en 2026; el anexo 8 eran capturas de su § 2.1.2 (V9) |
| I.3, extensiones | Enlace HAL atribuido a Galí | Es Poutineau, Sobczak y Vermandel (2015): se quita; Galí (2015) y Calvo (1983) (V10) |
| II.2 Lancaster | «En su obra» y las «3 cuestiones» atribuidas a Lancaster | Artículo de 1966; las 3 cuestiones como lo que el enfoque permite explicar, sin atribuírselas (V13) |
| Anexo 6 | «Rey (2007)» | Ivaldi, Jullien, Rey, Seabright y Tirole (2003), § III.11 y III.5 (V30) |
| Nota 50 | Marshall (1890) y la publicidad | Quitada: lo conocido de Marshall está en *Industry and Trade* (1919) (V32) |
| Conclusión (l. 1281) | Errata «tienen un efecto de productos tienen un efecto ambiguo»; extensiones y opinión vacías | Conclusión completa (C14) |

## Marcas resueltas

| Marca | Original | Qué se hizo |
|---|---|---|
| P1 (amarillo) | Demanda de cada variedad «positivamente» de σ | Corregido en I.3, punto d) de la demanda |
| P2 (amarillo) | «Tirole, págs. 279 y ss.» | Tirole (1988, cap. 7) citado en II.3 y III.1, y pp. 12-13 en el anexo G; la página 279 no se ha podido comprobar |
| P3, P4 | Notas de cambio de temario y ficha del tribunal | No se publican; la ficha se cumple con la estructura (C1) |
| P5 (comentario) | «¿Qué pasaría en Cournot con diferenciación?» | II.2, Bertrand y Cournot con producto diferenciado (Singh y Vives, 1984) |
| P6 | «Apartado 0» ligado al primer bloque | Desaparece (estructura nueva) |
| P7, P10, P13, P15 | Notas al opositor (Chamberlin breve; basta el problema; explicar direcciones; Lancaster breve) | Reescritas en las `notaopositor` de I y II |
| P8, P14, P16-P21 | Comentarios internos (esquemas a mano, coordinación, apuntes en papel) | No se publican; los de coordinación, en «Coherencia» |
| P9 | Caja con el enlace a Foltyn | Enlace en la bibliografía (`Foltyn2012Results`), citado en el anexo B |
| P11, P12 | Notas de Galí-Monacelli, 3.B.19 y Krugman | \vertema{3.A.7}, \vertema{3.A.32}, \vertema{3.B.19}, \vertema{3.B.6} en c) Extensiones |
| P22-P36 | Imágenes de Policonomics, Foltyn, Besanko, Gandolfo, Pindyck-Rubinfeld, «Sahuquillo» y capturas | Se rehacen en TikZ (`graficos-pedidos.json`); la comparación con competencia perfecta es una capa de `chamberlin`; la de Hotelling en precios usa `reaccion-diferenciado` |
| P37 | 3 gráficos a mano del anexo 1 | `lancaster-diferenciacion` (cuerpo) y `lancaster-estrategias` (anexo F) |
| P38 | Anexo 8: capturas en inglés de Foltyn | Anexo B redactado de nuevo |
| P39, P40, P43, P44 | Estructura vacía, sin tabla de supuestos, problemática pobre, enganche común | Introducción nueva, `tab:supuestos`, enganche propio |
| P41, P42 | Cobertura del título | III: vertical y otros desarrollos; bienestar unificado |
| P45-P63 | Referencias cruzadas | Ver «Coherencia» |
| P65 | Nombres de preparadores y Policonomics en la bibliografía y las fuentes | Quitados; solo obras originales |
| P66-P72 | Errores de Chamberlin, Dixit-Stiglitz, Hotelling, Salop, Shaked-Sutton, Lancaster, introducción | Ver «Errores corregidos» |
| P73 | Bibliografía incompleta | `3A18.bib` completo |
| P74 | Anexos 4-7 | Anexos H, I, J reescritos y citados |
| P75, P76 | 2 apartados y reparto desequilibrado | 3 apartados; 10'30" + 10'30" + 5'30" |

## Datos actualizados

Consultas del 19/10/2026 (`_trabajo/propuestas-datos.md`; series en `_trabajo/datos/`).

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Marcas de Coca-Cola (enganche) | — | más de 200 marcas | The Coca-Cola Company, «Our Company» | https://www.coca-colacompany.com/about-us | 19/10/2026 | FAQ de coca-cola.com (EE. UU.): «more than 200 brands» (solo fuentes de la empresa) (V35) |
| Clasificación de actividades (nota 4) | CNAE-2009 | CNAE-2025, RD 10/2025, de 14 de enero | BOE | https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-587 | 19/10/2026 | Documento de la CNAE-2025 del INE (V1) |
| Valor de la variedad importada (relevancia, I.3 d) | — | 2,6 % del PIB (EE. UU., 1972-2001); variedades ×3; sesgo de 1,2 puntos al año | Broda y Weinstein (2006), *QJE* | https://doi.org/10.1162/qjec.2006.121.2.541 | 19/10/2026 | IDEAS, mismo resumen (V38) |
| Márgenes precio-coste (relevancia) | — | 21 % (1980) → 61 % (2016) | De Loecker, Eeckhout y Unger (2020), *QJE* | https://doi.org/10.1093/qje/qjz041 | 19/10/2026 | IDEAS (V39) |
| Comercio intraindustrial de turismos España-Alemania (I.3, c) | — | 2025: exportaciones 6.722 M€, importaciones 7.157 M€; Grubel-Lloyd 0,97 (en el texto, «unos 6.700 y 7.200 millones») | Eurostat, Comext | https://ec.europa.eu/eurostat/databrowser/view/ds-045409/default/table | 19/10/2026 | Espejo alemán (GL 0,92) y ONU Comtrade (GL 0,99) (V41) |
| Inversión publicitaria en España (III.2, a) | — | 12.745 M€ en 2025 (−2,6 %), 0,75 % del PIB | InfoAdex (2026); PIB de Eurostat (1.690.012 M€) | https://media.timtul.com/media/lafede/Resumen%20Estudio%20de%20Inversiones%202026_20260211151142.pdf | 19/10/2026 | Reason Why (11/2/2026). No hay estadística oficial (V42) |
| Marcas nacionales solicitadas en la OEPM (III.2, a) | — | 57.158 en 2025 (+11,5 %), avance | OEPM, Estadísticas 2025 | https://www.oepm.es/export/sites/portal/comun/documentos_relacionados/PDF/Estadisticas-OEPM-2025.pdf | 19/10/2026 | Nota de prensa de la OEPM (17/2/2026) (V43) |
| Cereales (III.2, d) | — | Más de 80 marcas lanzadas por los 6 mayores fabricantes entre 1950 y 1972 | Schmalensee (1978); cifra en el documento de trabajo de 1977, p. 3 | https://hdl.handle.net/1721.1/1935 | 19/10/2026 | Resumen del artículo en IDEAS; página del artículo publicado sin cotejar (V36) |
| Caso de la FTC (III.2, d) | — | Demanda de abril de 1972 contra Kellogg, General Mills, General Foods y Quaker Oats; desestimada en 1981 | Schmalensee (1977), p. 1 | https://hdl.handle.net/1721.1/1935 | 19/10/2026 | Prensa (*Christian Science Monitor*, 11/9/1981); el cierre de 1982 por la Comisión, sin cotejar (V37) |
| Frase de Joan Robinson (contextualización) | *Economic Philosophy* (1962) | *Essays in the Theory of Economic Growth* (Macmillan, 1962), p. 33 | Búsqueda en el texto de Open Library | https://openlibrary.org/search/inside?q=%22variegation+of+reality%22 | 19/10/2026 | 8 obras la citan como «Robinson, 1962, p. 33» (V40) |
| Dixit y Stiglitz (1977), relevancia | «uno de los más citados» | Entre los 20 mejores artículos de los cien años de la *AER* | Arrow et al. (2011) | https://doi.org/10.1257/aer.101.1.1 | 19/10/2026 | Copia de la Universidad de Boston (V6) |
| Enlaces | Foltyn, HAL, Policonomics, quia, forvo | Foltyn funciona; HAL no es de Galí; Policonomics roto; quia y forvo fuera; simulador | — | — | 19/10/2026 | E1-E6 |

## Contenido añadido

- Introducción con los 5 bloques, enganche con refrán y dato actual, definiciones de diferenciación horizontal y vertical y de los enfoques de direcciones y no direcciones, contextualización con Sraffa, los años 70 y la frase de Joan Robinson; esquema y nota con el reparto.
- I.1: tabla común `tab:supuestos` con la fila 3 levantada y la 4 «se mantiene en parte», Lerner por variedad, tecnología CF + cq. I.2: Chamberlin a)–c) con demanda de cuota en nota, gráfico por capas con q̄. I.3: Dixit-Stiglitz «lite» (Neary, 2004) a)–e), nota cuasilineal, elasticidad exacta y las 2 demandas de Chamberlin, óptimo restringido y primer óptimo, extensiones (Krugman, Melitz, Blanchard-Kiyotaki, Galí, Romer), evidencia (Broda-Weinstein).
- II.2 (nuevo): Singh-Vives con funciones de reacción, sustitutos y complementos estratégicos, p^B < p^C, contratos, evidencia (Gasmi, Laffont y Vuong, 1992). II.3: Lancaster a)–c); Hotelling con localización dada y elegida (efectos demanda y estratégico, t/12 frente a t/48, Downs); Salop con los 2 efectos de la entrada (Spence; Mankiw-Whinston) y Economides (1989).
- III.1: Shaked-Sutton a)–e) con duopolio natural, Falvey, Mussa-Rosen y evidencia de Sutton (1991). III.2 (nuevo): Dorfman-Steiner a)–e), 3 visiones de la publicidad, señal (Nelson; Milgrom-Roberts), proliferación de marcas (Schmalensee; Judd).
- Anexos: A Chamberlin (costes de venta, ajuste paso a paso, demanda de cuota); B derivaciones de Dixit-Stiglitz; C bienestar (primer óptimo derivado, Hotelling, Salop); D Hotelling (costes lineales con `\graficonota`, precios y efectos); E finitud y duopolio natural; F Lancaster aplicado; G mercado relevante (Tirole; SSNIP); H empírica y elección discreta; I colusión (Ivaldi et al., 2003); J publicidad (resto del antiguo anexo 7); K test y preguntas del tribunal con el simulador.

### Estado de cada propuesta

- **Contenido**: C1 aplicada con la estructura de la decisión 1 (II.2 Bertrand-Cournot, II.3 con direcciones con Lancaster como II.3.1; III.1 vertical y III.2 publicidad) y minutos 10'30"/10'30"/5'30". C2-C14 aplicadas, sin ninguna cita a ICEX-CECO (las ideas que venían solo de allí van redactadas sin cita o se apoyan en la obra original). C4: sin `\funcionclave` de Chamberlin. C5: con P (índice de precios) en lugar de p_y. C7, C9, C11: ecuaciones numeradas en lugar de `\funcionclave` (pocas por tema, K30). C9: empresas 1 y 2 con x_1, x_2 (K29), no A y B. C8: a_{ki} (K29) en lugar de ψ_{ki}. C13: «más de 80 marcas» (1950-1972) y la FTC (abril de 1972, desestimada en 1981), con el documento de trabajo de Schmalensee (1977) y el artículo de 1978. C15-C24 aplicadas en los anexos A-K (C15 sin la crítica tomada de ICEX; C19 citando a Shaked y Sutton, 1982 y 1983; C22 sin la nota de ICEX sobre el consumidor representativo de la ciudad circular). Añadido un anexo J de publicidad para no perder el resto del antiguo anexo 7. C25-C29 aplicadas (C27: la Imagen 4 es una capa de `chamberlin`; `fig:cp-cm` e `indice-n` no se piden).
- **Datos**: V1, V3-V7, V9-V10 (sin Poutineau et al.), V12-V16, V19, V21-V23, V26, V28-V31, V35-V43 aplicadas (V41-V43, en una frase cada una: I.3 c y III.2 a). V2 no procede (sin Marshall en el enganche). V8 no procede (el gráfico 3D de Foltyn se quita; `ces-variedad` solo con σ ≥ 1). V11: Galí-Monacelli y Corsetti-Pesenti solo con \vertema (sin cita). V17 sin cambios. V18 cap. 7 sin página. V20, V27 con la duda. V24-V25 no proceden (gráficos rehechos). V32: nota quitada. V33 resuelta por contenido (anexo C). V34 no procede. V44-V45 = V38-V39. E1-E6 aplicados.
- **Coherencia**: K1-K3 aplicadas. K4-K5: la partición de la decisión 1 (Bertrand-Cournot en II.2 y no en III.2; Shaked-Sutton en III.1) y títulos propios. K6-K9 aplicadas con el reparto de la decisión 1. K10-K15 aplicadas (enganche «En la variedad está el gusto» y la frase de Joan Robinson en la contextualización). K16-K23 aplicadas. K24-K25 aplicadas (tabla común idéntica a la del 3.A.17). K26-K28 aplicadas. K29-K32 aplicadas (θ y t locales con nota). K33-K42 aplicadas. K43-K44 aplicadas como menciones. K45: anexos con otras letras y 2 más (test, publicidad). K46 aplicada. K47-K51 y PC1-PC3: para `tema-canon` y `pendientes-coherencia.md` (no se tocan otros temas). K52-K60: aplicadas sin citar a ICEX-CECO.

## Coherencia

- **Notación**: B beneficio; W̄ renta; CF y c (C = CF + cq), siglas en redonda; y agregador, P ≡ [Σp_j^{1−σ}]^{1/(1−σ)}, ρ ≡ (σ−1)/σ, μ ≡ σ/(σ−1); 𝓛 solo índice de Lerner (ninguna lagrangiana con 𝓛; multiplicador λ); ε_{x_i,p_i} con signo y |·| en Lerner; R_i(·) funciones de reacción; Hotelling con empresas 1 y 2 en a ≤ b, x_1, x_2, x̃; Salop x_i, n; vertical θ ∈ [θ̲, θ̄], s_A > s_B con A y B en redonda, θ̃; Singh-Vives α, β, γ locales; Dorfman-Steiner A y ε_{q,A} locales; n número de variedades (= empresas; nota sobre la J del 3.A.16).
- **Lista común de supuestos** (CRITERIOS § 6): idéntica a la del 3.A.17, fila 3 en salmón con «Se levanta», fila 4 «Se mantiene en parte»; II.1 remite a ella y levanta además el 4 y el 5 (salvo en Salop). Queda el 3.A.19.
- **3.A.16**: su nota de I.2 dice que en los modelos de diferenciación «sigue sin efecto renta»; aquí la Cobb-Douglas sí lo tiene, con una nota sobre la cuasilineal (sin efecto renta) y Singh-Vives cuasilineal. Propuesta PC1 (matiz opcional en el 3.A.16) para `pendientes-coherencia.md`.
- **3.A.17**: remisión para el Lerner de cada variedad; PC2 opcional (remitir aquí en «sin sustitutivos cercanos»).
- **3.A.21**: PC3 opcional (remitir aquí en la clasificación de los modelos de equilibrio general).
- **3.A.8 y 3.A.11**: se cumplen sus remisiones (Lancaster en la diferenciación, publicidad, Sraffa → Robinson y Chamberlin, CES con σ > 1).
- **Contradicciones con otros temas** (no se tocan): 3.A.19 repite el gráfico de Bertrand diferenciado y remite aquí el oligopolio diferenciado (debe resumir y remitir a II.2 y II.3.2); 3.B.6 repite la demanda de Dixit-Stiglitz y usa F (admitido en comercio); 3.A.7 usa Dixit-Stiglitz sin remitir aquí; 3.A.15 debería remitir aquí la proliferación de marcas; 3.A.20 tiene el mercado relevante (aquí solo resumen); 4.B.2 data Downs-Hotelling en 1947 (Hotelling, 1929; Downs, 1957); el 3.A.19 conserva el enganche antiguo común.
- **Canon** (para `tema-canon`): fichas nuevas `dixit-stiglitz`, `hotelling`, `salop`, `shaked-sutton` y, opcionales, `oligopolio-diferenciado` (Singh-Vives) y `dorfman-steiner`; cambios en `chamberlin` (corto plazo con beneficios, gráfico por capas) y `ces` (P, divergencia corregida); `notacion.md` (P, t, x̃, θ, s_A/s_B, α-β-γ locales, A, ε_{q,A}); `mapa.yaml` del 3.A.18 (K51).

## Dudas abiertas

1. **α en Dixit-Stiglitz**: se usa U = x_0^{1−α} y^α, con α la parte del gasto en el grupo (como Foltyn y Neary); el original y K30 lo ponían al otro lado (x_0^α y^{1−α}, gasto (1−α)W̄). Cambiarlo es mecánico. ¿Lo dejo así?
2. **Frase de Joan Robinson** (contextualización): ahora con la obra correcta, *Essays in the Theory of Economic Growth* (1962), p. 33 (V40). La traducción es la tuya, con el inglés en nota. ¿Te vale aquí?
3. **Cereales y FTC** (III.2, d): «más de 80 marcas» (1950-1972) se cita con el documento de trabajo de 1977 (p. 3) y el artículo de 1978, sin página de este último, que no se ha cotejado; la FTC demandó en abril de 1972 y el caso se desestimó en 1981 (el cierre por la Comisión en 1982, sin cotejar).
4. **Coca-Cola**: «más de 200 marcas» solo tiene fuentes de la propia empresa (2 páginas). Se ha quitado «nació en 1886» (sin comprobar): queda «famosa por un solo refresco».
5. **Páginas, capítulos y atribuciones sin comprobar**: Koutsoyiannis (1979, p. 209); Tirole (1988, pp. 12-13 y cap. 7, que empieza en la p. 277; la «pág. 279» de P2, una sola fuente, V18); los ejemplos de su introducción (carbón, coches, eléctricas; V27); la crítica de Andrews (1949) (V20); el texto de Neary (2004) con «Dixit-Stiglitz lite» (V7; la atribución está en Foltyn); la cita de Ekelund y Hébert (V22, sin comillas); Belleflamme y Peitz (2015, cap. 3); Cabral (2000, pp. 211-212; V28); Krugman, Obstfeld y Melitz (2018, cap. 8; edición); Eaton y Lipsey (1989) y Bagwell (2007), páginas del capítulo de memoria.
6. **Óptimo restringido de Dixit-Stiglitz** (D8 de contenido): comprobado en resúmenes, no en la sección I del artículo (la AEA dio error 403). La comparación con el primer óptimo (anexo C) es derivación propia.
7. **Duopolio natural** (anexo E): las condiciones 2θ̲ < θ̄ < 4θ̲ se atribuyen a Shaked y Sutton (1982), que las dan con rentas uniformes en [a, b]; la traducción a θ es directa con el modelo del tema, pero conviene cotejarla.
8. **Furlanetto (2006)** (nota al opositor del original): no identificado (V11); no se cita.
9. **Gasmi, Laffont y Vuong (1992)** (D10 de contenido): citado solo como aplicación, sin su conclusión (no se pudo leer el texto completo). Opción aplicada: se mantiene.
10. **Dudas de contenido y coherencia con la opción aplicada**: tercer bloque (D1/D2: sí, con la partición de la decisión 1); Bertrand-Cournot en el cuerpo (D3 de contenido, D2 de coherencia: en II.2, 2'); Salop en II (D3 de coherencia: sí); publicidad en el cuerpo (D4 de coherencia: III.2, 2'); índice P (D6: P); calidades s_A > s_B y θ local (D7: A/B); Dixit-Stiglitz con Cobb-Douglas (D8/D4: sí, con nota cuasilineal); títulos de II y III (D9: «El oligopolio con diferenciación horizontal» y «Diferenciación vertical y otros desarrollos»); Chamberlin 3' (D5/D10); letras θ y t con nota (D6 de contenido); anexo de finitud (D12: sí, anexo E); `3A-18_v11.doc` es el 3.A.18 antiguo (mercado de trabajo, hoy 3.A.25): ¿anotarlo en `referencias.md` del 3.A.25?
11. **ICEX-CECO**: por la decisión del orquestador no se cita; ideas que solo venían de allí (la caracterización de la tecnología con costes fijos, el orden entrada-variedad-precio, la competencia global frente a local de la opinión, la nota de los 2 enfoques compatibles) van redactadas sin cita o se han quitado. CRITERIOS § 2 dice que las lecturas de preparadores se citan «como en el tema original»: ¿confirmas que en este tema no se cite?
12. **Control de calidad (19/10/2026), Word, común a todos los temas** (no se arregla en este tema, es de `construir-tema.py`/plantilla Word; pasa igual en el 3.A.17): la caja «Esquema del tema» y las bandas de título largas salen justificadas línea a línea, con huecos enormes, y la caja del esquema se parte entre páginas; las listas numeradas de segundo nivel salen como a., b., c. (en «Supuesto a supuesto» no casan con los números 1-5 de la tabla 1), y la tabla 1 parte la fila 3 entre páginas con el salmón solo detrás del texto. ¿Lo encargo aparte para todos los temas?

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra**: enganche «En la variedad está el gusto» con las más de 200 marcas de Coca-Cola y la pregunta «¿por qué las empresas no venden todas lo mismo al mismo precio? ¿cuánto pagamos por la variedad? ¿ofrece el mercado la justa?»; la idea final la responde («en la variedad está el gusto, y también el poder de mercado…»). La frase de Joan Robinson (mapa 1:1) puede ir como apunte en la contextualización.
- **Función clave que se conserva**: `eq:lerner-variedad` (𝓛 = 1/σ ⟺ p* = μc) se escribe en I.3 y se queda en una esquina todo el cante (`conservar:`); debajo se va añadiendo la **columna de márgenes**, sin escribir nada dos veces: p^B − c (II.2), t (II.3.2), t/n (II.3.4), ∝ Δs (III.1) y A/(pq) = 𝓛ε_{q,A} (III.2). `eq:demanda-variedad` solo en I.3.
- **Pizarra (trazo a trazo)**: `chamberlin` por capas (d y D → corto plazo con beneficio → tangencia con q* < q̄ y la llave del exceso de capacidad); `dixit-stiglitz` (3 paneles, el c es el imprescindible); `reaccion-diferenciado` (cantidades a la izquierda, precios a la derecha); `hotelling` y luego **el mismo segmento** con las capas de `hotelling-localizacion` (efectos, 0 y 1 frente a ¼ y ¾, centro con precios fijos): no se dibuja otro segmento; `salop`; `shaked-sutton`.
- **Apoyo, no pizarra**: la tabla `tab:supuestos` (I.1 y II.1), `ces-variedad`, `lancaster-diferenciacion`, las fórmulas largas (precios con localizaciones cualesquiera, derivada de los 2 efectos, precios de Shaked-Sutton), y los gráficos de los anexos (`hotelling-lineal`, `lancaster-estrategias`).
- **Ritmo**: Chamberlin breve (intuiciones), Dixit-Stiglitz con el problema escrito y la resolución de palabra; Lancaster en 1'; el consumidor indiferente es la pieza que se repite en los 3 modelos espaciales y en la vertical: decirlo.
