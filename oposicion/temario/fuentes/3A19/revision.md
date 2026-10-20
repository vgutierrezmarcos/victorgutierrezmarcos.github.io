# Revisión del tema 3.A.19 — Análisis de mercados (IV). Teoría del oligopolio: soluciones no cooperativas y soluciones cooperativas.

Fecha: 20/10/2026. Integración en 2 partes: la 1 escribió el preámbulo, la introducción y los bloques I y II; la 2, el bloque III, la conclusión, los anexos A-E, `seo.json` y este informe.

Fuentes de la integración: `_trabajo/original.md` (Word de Víctor, escrito para el título antiguo «análisis estático y dinámico; teoría de juegos»), `pendientes.md` (P1-P99), `propuestas-contenido.md` (C1-C28), `propuestas-datos.md` (V1-V61) con `bib-datos.bib` y `propuestas-coherencia.md` (K1-K34, estructura final, D1-D8). Material de contraste (no se cita en el tema): temas de Miquel Tebar (3A19) y de Manuel Cabado (DCE 3.A.9) y el PDF de ICEX-CECO del temario nuevo; lo que se tomó de ellos (la distinción entre los 2 sentidos de «cooperativo», el apéndice de Cournot con n empresas y costes distintos de Cabado, el tratamiento de Bertrand con rendimientos decrecientes, las variaciones conjeturales y los factores de la colusión del material de ICEX-CECO) se redactó de nuevo y se apoya en las obras originales. Criterio ante discrepancias: estructura, minutos, etiquetas y notación, de coherencia (y del coordinador); teoría y ejemplos, de contenido; cifras, de datos.

## Resumen

- Nueva fuente `3A19.tex` en 3 bloques que siguen el título: **I. Soluciones no cooperativas: análisis estático** (11′: caracterización con la tabla común, Cournot, Stackelberg, Bertrand y sus salidas, liderazgo en precios); **II. Análisis dinámico: de la competencia a la colusión tácita** (7′); **III. Soluciones cooperativas: el cártel y el reparto de sus ganancias** (8′30″: cártel, reparto con Nash, núcleo y Shapley, límites). Introducción 2′30″ y conclusión 1′ (suma 30′).
- El bloque 3 del original, «Barreras de entrada», pasa al 3.A.15 (lo pedía el propio Víctor en sus comentarios); aquí queda un resumen en III.3. La mitad cooperativa del título, que el original apenas tenía (unas 250 palabras), es ahora un bloque entero.
- Funciones clave: el índice de Lerner con la cuota `eq:lerner-cournot` y la condición de la colusión `eq:colusion`; el cártel `eq:cartel` es una ecuación numerada.
- Enganche con Adam Smith y el cártel europeo de camiones (2016, MAN exento por clemencia); la idea final lo retoma.
- `3A19.bib` con 108 entradas; 9 gráficos pedidos (TikZ) y 7 tablas en LaTeX; 5 anexos (Cournot lineal, Stackelberg lineal, Cournot con costes privados, condición del gatillo, test).

## Errores corregidos

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| l. 87 (P85) | El oligopolio «constituye un caso de información imperfecta» | Es interdependencia estratégica con pocas empresas; se mantiene la información perfecta (supuesto 2) |
| l. 91 (P85) | «independencia estratégica» | «interdependencia estratégica» |
| l. 113 y nota 5 (P67) | *The Theory of Games* «[ver tema 3.A.10]» | *Theory of Games and Economic Behavior* (sin «The») con `\vertema{3.A.14}`; la nota remite la decisión con incertidumbre al 3.A.10 y la teoría de juegos al 3.A.14 |
| l. 115 (P96) | Nash «desarrolla los juegos en forma extensiva y los repetidos» | Forma extensiva de Kuhn (1953), repetidos de Aumann (1959) |
| l. 129 y nota 10 (P19) | «haremos uso de la teoría de juegos no cooperativa»; juegos cooperativos «colaboran para conseguir la victoria» | Los 2 sentidos de «cooperativo» (resultado colusorio / acuerdos vinculantes); el tema usa las 2 teorías |
| l. 185-187 (P64) | Barreras «por parte del monopolista» y lista de supuestos propia | Tabla común `tab:supuestos` con las filas 4 y 5 «Se levanta»; barreras de las empresas instaladas |
| l. 255-259 (P1, P89) | Condiciones de las funciones de reacción mal enunciadas; «pendiente negativa y menor que uno» | Condiciones de Hahn (1962) H1 y H2; R_i′ ∈ (−1, 0), |R_i′| < 1 en valor absoluto |
| Nota 22 (P89) | El EN «da igual la estrategia que tome la otra empresa» | Mejor respuesta a lo que de verdad hace la otra; no es un equilibrio en estrategias dominantes |
| Notas 25 y 55 (P89) | Unicidad por la concavidad y «Gale-Nikaido» | Unicidad por contracción (|R_i′| < 1); fuera Gale-Nikaido |
| Notas 27 y 58 (P89) | La solución «viene de la eliminación iterada de estrategias dominadas» | Solo en el duopolio lineal (Gibbons, § 1.2.A); con 3 o más empresas, no |
| l. 251, 450, 529 (P74) | φ para la función de reacción | R_i (D016) |
| Todo el tema (P97) | π, Π, π^colusión, π^free rider, π^castigo, P(Q), p^cp, P_M… | B; B^C, B^D, B^N (redonda); p(Q) = a − bQ; p^c, p^M, q^C, p^S, p^B |
| l. 317 | «El EN es tajante: no, no existen incentivos a desviarse» (sentido invertido) | El acuerdo **no** es un EN porque **sí** hay incentivo a desviarse (−p′q_2 > 0) |
| l. 323 (P86) | «la causa de que no se llegue a la finitud… es la finitud» | Frase puente: las 2 ganarían produciendo menos, pero a cada una le conviene producir más (dilema); la repetición y el cártel pueden resolverlo |
| l. 440, 442 y anexo 3 (P88) | Variación conjetural de la líder «positiva»; ventaja «informacional» | Negativa (R_2′ = −1/2) y correcta; ventaja de compromiso |
| Nota 34 (P88) | Stackelberg «juego estático secuencial» | Juego dinámico en 2 etapas, ENPS (nota del bloque I sobre qué significa «estático») |
| Nota 35 (P88) | «al fijar el precio» | La cantidad |
| l. 529-533 (P90) | Mejor respuesta «c si p_j < c» y «p_j − ε» | Mejores respuestas bien definidas («un céntimo menos»; sin ε, que es la elasticidad); EN único demostrado por descarte |
| l. 571 (P67) | Eficiencia de Bertrand «[ver tema 3.A.23]» | `\vertema{3.A.22}` |
| l. 597 | P_1 = CMg_2 − ε | c_1 < c_2: un céntimo por debajo de c_2 |
| l. 607-613 (P2-P5) | Rendimientos decrecientes ilustrados con 2 hoteles con habitaciones fijas | Separadas 3 salidas: costes convexos (con y sin obligación de servir: Vives, Dastidar), capacidad limitada (Edgeworth; ahí van los hoteles) y capacidad elegida antes (Kreps-Scheinkman) |
| l. 643 (P6) | *The Pure Theory of Monopoly* (1897) | «La teoria pura del monopolio», *Giornale degli Economisti* (1897); la versión inglesa es una retraducción de 1925 |
| l. 649-653 (P7-P9) | Las empresas empiezan coludiendo y los precios «suben poco a poco» | Lógica de Edgeworth: precio de monopolio de la demanda residual, rebajas hasta p̲, salto a p̄; sin equilibrio en puras (Levitan-Shubik), ciclos como equilibrio con turnos (Maskin-Tirole) |
| l. 781 (P87) | «existen 2 ENPS» | Infinitos ENPS (teorema de tradición oral aplicado); son 2 tipos de estrategias |
| l. 783 (P87) | «al igual que bajo un horizonte infinito» | Finito |
| l. 798 | Tit for tat, tit for two tats y win-stay-lose-shift como ENPS | No lo son en general; el ojo por ojo solo con β muy concretos (Kalai, Samet y Stanford, 1988) |
| l. 928 | Stigler (1961) | Stigler (1964), «A Theory of Oligopoly» |
| Nota 45 (P93) | Green y Porter (1994) | Green y Porter (1984); guerras de precios en equilibrio aunque nadie se desvíe |
| Notas 43-44 (P93) | Abreu sin año; «Maskin» | Abreu (1986, 1988); Farrell y Maskin (1989) |
| Nota 40 (P94) | Bonn 1978: «Estados Unidos incumplió… política fiscal contractiva» | Quitada: la contracción fiscal de EE. UU. estaba en el acuerdo (declaración de Bonn, V29) |
| Nota 6 (P94) | Sócrates «aplicó» la teoría de juegos en la batalla de Delio | Quitada (D6 de contenido) |
| Nota 17 (V8) | Cournot «amigo» de Auguste Walras, «a quien introdujo en el pensamiento marginalista» | Condiscípulo en la Escuela Normal; Léon Walras lo tuvo por precursor (anacronismo del marginalismo fuera) |
| Nota 48 (P67) | Control de concentraciones «[tema 3.B.4]» | `\vertema{3.B.39}` |
| l. 1188-1194 (P95) | A corto plazo predomina Bertrand porque la producción es fija | Con capacidades fijas y competencia en precios sale Cournot (Kreps-Scheinkman) |
| Conclusión (V26) | Clemencia = «exención del pago» | Exención solo para la primera; reducciones del 30-50 %, 20-30 % y hasta el 20 % (arts. 65-66 LDC) |
| Mercados contestables (P91, en el resumen de III.3) | Supuestos «rendimientos constantes» y «costes de menú» | Sin costes hundidos, misma tecnología y retardo de reacción de la instalada |
| Bibliografía y pies (V43-V52) | Policonomics (rotos), «Fayerman Aragón», Pindyck-Rubinfeld 2010, Schlag 2022, Gaviotis 2015 | Manuales; Cerdá, Pérez y Jimeno (2004); Pindyck y Rubinfeld (2009); figuras rehechas como elaboración propia |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1, amarillo | «y menor que uno» (Cournot) | En valor absoluto, de las condiciones de Hahn; unicidad y estabilidad en la caja de I.2 |
| P2-P5, amarillo | Bloque «Rendimientos decrecientes a escala» | Reescrito y separado de la capacidad (I.4, c) |
| P6-P9, amarillo | Cita y descripción de Edgeworth (Policonomics) | Cita corregida y lógica rehecha según el comentario de Víctor (l. 646) |
| P10, amarillo | «Juegos cooperativos» (anexo 1) | Aplicados al reparto del cártel (III.2): negociación de Nash, núcleo y Shapley con 2 ejemplos calculados |
| P11, amarillo | «[Ver Clase Juan Carlos 24/10/2021]» | No se publica; lo que pedía (reacciones lineales) está en el anexo A |
| P12, P14, notas al opositor | Cambio de temario (con captura) y nota del 3.A.14 | Desaparecen; sus peticiones (Shapley, teoría de juegos al 3.A.14) se cumplen |
| P13, nota al opositor | «Mencionar y dar una idea… posiblemente llevarlo a los anexos» (Cournot bayesiano) | Idea e implicaciones en I.2 (c); desarrollo y ejemplo en el anexo C |
| P15-P27, comentarios | Barreras de entrada, «agenda del tema», Shapley, predación/colusión perfecta, Edgeworth, liderazgo, «alianzas sostenibles», contestables | No se publican; resueltos: barreras al 3.A.15 con resumen en III.3; colusión perfecta e imperfecta (II.2 y III.1); predación y *killer acquisitions*, mención en III.3; liderazgo desarrollado (I.5); alianzas sostenibles con núcleo, Shapley y estabilidad (III.1-III.2) |
| P28, P32, cajas | Caja del tema antiguo de teoría de juegos; imágenes decorativas | Fuera con el anexo 1 |
| P29, caja | Vídeo de Edgeworth | Funciona: se conserva en `anotaciones` |
| P30, cajas | 10 escaneos de Cerdá et al. | No se publican; anexo C redactado de nuevo |
| P31, caja | «Ineficiencia del oligopolio» | Caja de comparación al final de I.5 con `figuracaja` y `tablacaja` (cifras comprobadas, con fila de n empresas) |
| P33, «No cantar» | Nota 20 (Lerner con la cuota) | Resultado al cuerpo como función clave; derivación en el anexo A |
| P84 | Enlace a quia.com | Enlace genérico al simulador (anexo E) |

## Datos actualizados

El tema no tenía series de datos; todo lo nuevo es de fuentes oficiales, consulta del 20/10/2026.

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Cártel de camiones (enganche, idea final) | — | 2.926 M€ a 4 fabricantes (Daimler, DAF, Iveco, Volvo/Renault), 1997-2011, MAN exento | Comisión Europea, IP/16/2582 | https://ec.europa.eu/commission/presscorner/detail/en/IP_16_2582 | 20/10/2026 (API de presscorner, por el editor) | «Cartel Statistics»: camiones 2016/2017, 3.807 M€, la mayor multa a un cártel (V41) |
| Multas de cárteles de la Comisión | — | 162 decisiones y > 33.000 M€ desde 1990; 859,5 M€ en 2025 (4 decisiones), 48,7 M€ en 2024 | Comisión Europea, «Cartel Statistics» | https://competition-policy.ec.europa.eu/antitrust-and-cartels/cartels-cases-and-statistics_en | 20/10/2026 | Suma de las notas de prensa de 2025 (V38) |
| Vehículos al final de su vida útil | — | ≈458 M€, 15 fabricantes y ACEA, Mercedes-Benz exenta; Stellantis 50 %, Mitsubishi 30 %, Ford 20 % | Comisión, IP/25/881 | https://ec.europa.eu/commission/presscorner/detail/en/ip_25_881 | 20/10/2026 | «Cartel Statistics» 2025 (V39) |
| Delivery Hero y Glovo | — | 329 M€ (223,3 + 105,7) | Comisión, IP/25/1356 | https://ec.europa.eu/commission/presscorner/detail/en/ip_25_1356 | 20/10/2026 | Suma del desglose (V40) |
| Agencias de viajes | — | 2,91 M€ a 4 agencias (Complutense, Banco de España) | CNMC, 29/12/2025 | https://www.cnmc.es/prensa/multa-agencias-viajes-20251229 | 20/10/2026 | Memoria 2025, pp. 18-19 (V34) |
| Multas de la CNMC por conductas colusorias | — | 4,1 M€ en 2025; > 200 M€ en 2022 y 2023 | CNMC, Memoria 2025, anexo X | https://www.cnmc.es/sites/default/files/editor_contenidos/CNMC/Memorias/CNMC_Memoria%2025_web.pdf | 20/10/2026 | Misma memoria, pp. 18-19 (V33) |
| Constructoras | — | 203,6 M€, 6 empresas, 25 años; **recurrida** | CNMC, 7/7/2022 | https://www.cnmc.es/prensa/sancionador-obra-civil-20220707 | 20/10/2026 | Memoria 2025, anexo X (V35); firmeza no comprobada: el texto dice «está recurrida» |
| Clemencia en España | — | 53 de 116 cárteles (46 %) hasta 2022; desde 2018, mayoría detectados de oficio | CNMC, 11/7/2023; Memoria 2025 | https://www.cnmc.es/prensa/cuestionario-programa-clemencia-cnmc-20230711 | 20/10/2026 | *Revista e-Mercatoria* (2024), vista solo en búsqueda (V36) |
| Reducciones por clemencia | «exención» | Exención a la primera; 30-50 %, 20-30 %, hasta 20 % | BOE, Ley 15/2007, arts. 65-66 | https://www.boe.es/buscar/act.php?id=BOE-A-2007-12946 | 20/10/2026 | IP/25/881 (mismo esquema en la UE) (V26) |
| Telefonía móvil (IHH) | — | 4 operadores, 96,8 % de las líneas; IHH ≈ 2.770 (2T2026) | CNMC, nota del 14/10/2026 | https://www.cnmc.es/prensa/trimestral/telecos/2T26/20261014 | 20/10/2026 | Nota del 1T2026: CR4 96,6 % (V42) |
| Margen precio-coste en EE. UU. | — | 21 % (1980) → 61 % (2016) | De Loecker, Eeckhout y Unger (2020) | https://doi.org/10.1093/qje/qjz041 | clave del 3.A.17/3.A.18 | Como en el 3.A.18 |
| Cita de Smith | — | Libro I, cap. X, parte II; paráfrasis en el texto y el original en nota | Project Gutenberg | https://www.gutenberg.org/cache/epub/3300/pg3300.txt | 20/10/2026 | Ubicación en el mismo texto (V37) |

No usados: Pepephone y MasOrange (V31, iban con los impugnables, al 3.A.15), cifras de baterías de arranque (CE2025Baterias, en el `.bib` sin citar), DIGI como entrante, Bonn como ejemplo alternativo (V29), la cifra exacta de la mayor multa a una empresa (Daimler, V41), el caso de montaje industrial de la CNMC de 2019 propuesto por contenido (no lo comprobó datos; en el `.bib` sin citar), la excepción agraria del Reglamento 1308/2013 (V27, sin comprobar: se dejó solo la OPEP como cártel de Estados).

## Contenido añadido

- **Introducción**: los 5 bloques; enganche Smith + camiones; relevancia empírica, teórica y normativa; cronología corregida; los 2 sentidos de «cooperativo»; 4 preguntas; estructura; esquema y reparto del cante.
- **I.1**: tabla común con las filas 4 y 5 «Se levanta» (igual que el 3.A.17); EN y ENPS; sustitutos y complementos estratégicos (Bulow, Geanakoplos y Klemperer, 1985) con gráfico en nota; rejilla 2×2 de los modelos.
- **I.2 Cournot**: n empresas, condiciones de Hahn, caja de existencia, unicidad y estabilidad (Novshek, Theocharis), Lerner con la cuota e IHH (Cowling y Waterson, 1976), ineficiencias asignativa y productiva, convergencia; extensiones: variaciones conjeturales (Bowley, Bresnahan, crítica de Tirole) y costes privados; evidencia (Brander y Zhang, 1990).
- **I.3-I.5**: Stackelberg como ENPS, amenaza no creíble, Gal-Or (1985); Bertrand con las 5 salidas (Dastidar, Levitan-Shubik, Maskin-Tirole, Byrne-de Roos, Kreps-Scheinkman, Davidson-Deneckere, Singh-Vives); liderazgo en precios con franja (Forchheimer, Landes-Posner); caja de comparación.
- **II**: horizonte finito (Benoit-Krishna); gatillo con `eq:colusion`, β ≥ 1 − 1/n, 9/17, retraso τ; teorema de tradición oral aplicado; tabla de estrategias; Green-Porter, Rotemberg-Saloner, Haltiwanger-Harrington, Abreu, Farrell-Maskin; evidencia (Porter, 1983; Calvano et al., 2020); tabla de 13 factores (Ivaldi et al., 2003; Motta, 2004).
- **III.1**: cártel multiplanta (`eq:cartel`, \vertema{3.A.17}), curva de colusión, colusión perfecta e imperfecta, el acuerdo como dilema con una tabla propia, la OPEP; extensiones: paradoja de las fusiones (Salant, Switzer y Reynolds, 1983), ventaja de quedarse fuera (Stigler, 1950), estabilidad interna y externa (d'Aspremont et al., 1983), formación (Selten, 1973).
- **III.2**: negociación de Nash con desacuerdo en Cournot (ejemplo con costes 1 y 4: 25 + 4 → 36, pagos laterales); núcleo y Shapley con 3 empresas (v = 1, 16/9, 4; φ_i = 4/3 en el núcleo; 16/9 > 4/3 fuera del cártel).
- **III.3**: barreras, precio límite y compromiso (Bain, Modigliani, Dixit), mercados impugnables con sus 3 condiciones, predación; art. 101 TFUE y art. 1 LDC, prueba (pasta de papel), clemencia ligada a `eq:colusion` (Motta y Polo, 2003), casos y estadísticas oficiales, efectos coordinados.
- **Conclusión**: 5 bloques, empieza por «En conclusión,»; la idea final responde al enganche con Smith, los 14 años del cártel de camiones y MAN.
- **Anexos**: A Cournot lineal (n empresas, costes distintos, Lerner con `\findemo`, estabilidad); B Stackelberg lineal; C costes privados con tabla; D derivación de `eq:colusion`, retraso, horizonte incierto, Bertrand y 9/17; E test, preguntas del tribunal con respuestas y enlace al simulador.

### Estado de cada propuesta

- **Coherencia (K1-K34)**: K1-K6 aplicadas (estructura K2 con sus etiquetas y minutos, por decisión del coordinador: I 11′, II 7′, III 8′30″). K7 aplicada en la conclusión. K8-K9 aplicadas. K10-K11 aplicadas. K12 aplicada (diferenciación en una línea, sin gráfico). K13-K17 aplicadas; en K15, la condición del cártel es una ecuación numerada y no una tercera función clave. K18-K19 aplicadas (la remisión a 4.A.15 solo para ampliar). K20-K21 aplicadas. K22 aplicada (anexo 1 fuera; juego de la gallina fuera, D5). K23 aplicada (enganche Smith + camiones, por decisión del coordinador). K24-K27 aplicadas. K28 aplicada salvo que la tabla de estrategias va en el cuerpo y no en un anexo F. K29: gráficos con los nombres de coherencia salvo `colusion-tiempo`, `bertrand-reaccion` y `sustitutos-complementos`; `cartel` y además `cartel-multiplanta` (de contenido). K30: anexos A-E con las etiquetas de contenido (`anexo:cournot-lineal`, `anexo:stackelberg-lineal`, `anexo:cournot-bayesiano`, `anexo:gatillo`, `anexo:test`), por decisión del coordinador; sin anexo de capacidad (Edgeworth y Kreps-Scheinkman en el cuerpo) ni de núcleo (los cálculos caben en III.2). K31-K34: para `tema-canon`.
- **Contenido (C1-C28)**: C1 aplicada con la estructura y los títulos de K2 (no «competencia en un solo periodo»: una nota explica qué es «estático»). C2 aplicada con el enganche de K23 en lugar de la cifra agregada de la Comisión, que pasa a la relevancia. C3-C13 aplicadas (C3 con la fila 5 en rojo «Se levanta», como el 3.A.17, y no en dorado). C14 aplicada, sin el art. 42 TFUE sobre cárteles agrarios (no comprobado por datos). C15 aplicada. C16 aplicada con los datos de la fase de datos (agencias de viajes, vehículos, Glovo, estadísticas) en lugar del caso de montaje industrial de 2019. C17 aplicada (sin el `\clearpage` antes de la conclusión que traía: va después). C18-C22 aplicadas. C23-C28 aplicadas; nota 39 (Axelrod) conservada abreviada; la nota 21 (IMg = CMg, Cournot pionero) conservada.
- **Datos (V1-V61)**: V2-V5, V7, V9-V20, V22, V24-V26, V28, V32-V40, V42-V52, V54, V57-V58 aplicadas; V1 no (Marshall sale con el enganche común); V6 y V55 no (nota de Delio fuera); V8 aplicada sin cita; V21 y V23 en el resumen de III.3; V27 no; V29 nota fuera; V30 en nota (desregulación aérea); V31 no (al 3.A.15); V41 en el enganche; V53 no (nota 2 fuera); V56 no (vídeo de la nota 39 fuera); V59 en nota como lectura; V60 y V61 sustituidos por el simulador y los manuales.
- **Añadido por el editor**: comprobación directa de la nota de prensa del cártel de camiones (2.926.499.000 €; MAN no multado; 14 años, 1997-2011; 9 de cada 10 camiones medianos y pesados); fila de Cournot con n empresas en la tabla comparativa; frase de las condiciones de impugnabilidad que pidió el coordinador.

## Coherencia

- **Notación (canon)**: R_i (nunca φ); B (nunca π ni Π); B^C, B^D, B^N en redonda (como u^C, u^D, u^N del 3.A.14) con nota que los distingue del superíndice de Cournot; β ≡ 1/(1 + ρ); p(Q) = a − bQ, q_i, Q, Q_{−i}; q^M, p^M, q^c, p^c, q^C, Q^C, p^C, q^S, p^S, p^B en cursiva; 𝓛 solo para Lerner, sin lagrangianas; c_A, c_B y π en Cournot con costes privados; N, T, v(T), 𝒞(v), φ_i(v), γ y punto de desacuerdo B_i^0 en III.2.
- **Notación nueva, para `cambios.md`** (K33 y contenido § 9): ε_{Q,p} elasticidad de la demanda de mercado en el oligopolio; s_i ≡ q_i/Q cuota (local, con aviso frente a la estrategia s_i); IHH ≡ Σ s_i² y Σ s_i𝓛_i = IHH/|ε_{Q,p}|; v_i variación conjetural; k capacidad (local, Edgeworth); x_R(p) = x(p) − q_f(p), q_f, ε_f, CMg_L en el liderazgo; S_i(p) oferta competitiva (local); p̄, p̲ (Edgeworth); τ retraso de detección; B_i^0.
- **Tabla común de supuestos**: idéntica a la del 3.A.17 (filas 4 y 5 en salmón, «Se levanta»), como pide CRITERIOS § 6 y `pendientes-coherencia.md` (l. 71 y 143).
- **Promesas de temas revisados que se cumplen**: 3.A.14 (el oligopolio como juego; R_i como mejor respuesta; Cournot y Bertrand como EN; Stackelberg como ENPS; el cártel como dilema; colusión tácita con el teorema aplicado y β ≥ 1/2; Cournot con costes privados con c_A, c_B, π); 3.A.17 (el cártel como monopolio multiplanta); 3.A.18 (los 5 supuestos de la paradoja con las mismas palabras; oligopolio diferenciado en una línea; colusión con diferenciación ±); 3.A.16 (tabla común; escala mínima eficiente → oligopolio natural).
- **Al 3.A.15** (revisado en paralelo): recibe barreras, precio límite, juego de entrada con la condición de credibilidad rehecha con Dixit (P92) y mercados impugnables con los supuestos corregidos (P91), más las notas 47 y 49-52; aquí solo el resumen de III.3 con `\vertema{3.A.15}`.
- **Cambios opcionales a temas revisados** (para `pendientes-coherencia.md`, de coherencia § I): 3.A.14, añadir en la negociación «y el reparto del beneficio de un cártel, con el beneficio de Cournot como punto de desacuerdo \vertema{3.A.19}» y en Shapley «estudiar qué cárteles y alianzas entre empresas son estables \vertema{3.A.19}»; 3.A.18, en `anexo:colusion`, la frase de la diferenciación horizontal ambigua (Ross, 1992; clave por crear).
- **Contradicciones con otros temas** (no se tocan): 3.B.39 y 4.A.15 remiten la clemencia como dilema al 3.A.19 (o al 3.A.16): lo correcto es «\vertema{3.A.14} \vertema{3.A.19}», que matiza la entrada de `pendientes-coherencia.md` (l. 148); 3.B.8 usa φ_A(q_B) (→ R_A) y remite Johnson (1953) al 3.A.19 (→ 3.A.14); 3.A.23 tiene una lista de supuestos distinta de la común; 3.A.6, 3.A.36, 3.A.41 y 3.A.44 remiten los juegos repetidos de Barro-Gordon al 3.A.19 (→ 3.A.14).

## Dudas abiertas

Mientras Víctor no conteste en el artifact, se aplica la opción recomendada (o la que decidió el coordinador).

**De coherencia (D1-D8)**:

1. **D1, tercer bloque**: aplicada la sustitución de «Barreras de entrada» (al 3.A.15) por «Soluciones cooperativas», con resumen de las barreras en III.3. Alternativa: III «Barreras» resumido y lo cooperativo en II.
2. **D2, «agenda del tema»**: no está en el material. ¿Hay algo en ella que deba entrar?
3. **D3, enganche**: Smith + cártel de camiones (aplicado). Alternativa: «La unión hace la fuerza».
4. **D4, superíndices**: B^C, B^D, B^N en redonda, sin escribir nunca el beneficio de Cournot como B^C (aplicado). Alternativa: B^col.
5. **D5, juego de la gallina España-BCE**: fuera con el anexo 1 (aplicado).
6. **D6, función clave**: Lerner con la cuota y, además, la condición de la colusión (aplicado). ¿Solo una?
7. **D7, bibliografía**: fuera «Apuntes Sahuquillo», «Apuntes ICEX-CECO» y «Tema Juan Luis Cordero Tarifa», y las 2 webs de Policonomics, sustituidas por manuales (aplicado).
8. **D8, liderazgo en precios**: en el cante 1′30″ con la caja de comparación (aplicado). ¿Solo profundización, para dar más tiempo a III.2?

**De contenido (D1-D10)**:

1. **D1**: = D1 de coherencia (aplicada la sustitución).
2. **D2, títulos**: aplicados los de coherencia («análisis estático», con nota) en lugar de «competencia en un solo periodo».
3. **D3, unidad monetaria mínima en Bertrand**: con palabras, «un céntimo menos» (aplicado), sin ϵ.
4. **D4, «Apuntes ICEX-CECO»**: fuera (aplicado).
5. **D5, «agenda del tema»**: = D2 de coherencia.
6. **D6, nota de Platón y Delio**: fuera (aplicado).
7. **D7, nota de Cournot y Auguste Walras**: conservada como «condiscípulo», sin cita (la fuente es el *Dictionary of Scientific Biography*, que no está en el `.bib`). ¿Se quita?
8. **D8, Forchheimer (1908)**: citado sin volumen ni páginas (no comprobados en la fuente primaria).
9. **D9, páginas de Edgeworth (1897)**: «13-31, 307-320, 405-414», reconstruidas de una cita secundaria; conviene comprobarlas en la revista.
10. **D10, Cournot bayesiano**: viñeta en el cuerpo y desarrollo en el anexo C (aplicado).

**Datos sin verificar o con una sola fuente**: firmeza de la multa a las constructoras (el texto dice que está recurrida); 116/53 de clemencia (una sola fuente oficial); mayor multa de cártel de la UE (solo la tabla de la Comisión); volumen de Edgeworth (1897) y de Forchheimer (1908); páginas finales de varios artículos (marcadas en `bib-datos.bib`). **Otras**: la excepción agraria de la nota 29 (art. 42 TFUE, Reglamento 1308/2013) se dejó fuera por no estar comprobada; Ross (1992), que coherencia cita para la diferenciación horizontal, no está en ningún `.bib`: el factor «diferenciación» de la tabla se dejó sin cita.

## Instrucciones para el vídeo

- **Introducción y conclusión, sin pizarra** (`modo: guion`). Enganche: la frase de Smith (en castellano, como paráfrasis) y el cártel de camiones (2.926 millones, 14 años, MAN exento). Pregunta: «Si a las empresas les conviene ponerse de acuerdo, ¿por qué compiten? ¿Y por qué un acuerdo de 14 años se rompe?». La idea final la responde: a cada una le conviene romper el acuerdo; la repetición lo sostiene y la clemencia usa el mismo dilema para que al primero que confiesa (MAN) le salga a cuenta.
- **Funciones clave que se conservan** (`conservar:`): `eq:lerner-cournot` (𝓛_i = s_i/|ε_{Q,p}|) desde I.2 hasta el final; `eq:colusion` desde II.2 hasta el final (se señala en III.3 al explicar la clemencia). Las 2, en la columna izquierda de la rejilla.
- **I.1**: la tabla de supuestos, como **apoyo** (fila 4 resaltada); en la pizarra solo la rejilla 2×2 (cantidades/precios × simultáneo/secuencial), que se queda arriba y se rellena con cada modelo (C, S, B, L). El gráfico de sustitutos y complementos, nada.
- **Gráfico conjunto por partes** (CRITERIOS § 8): `cournot-stackelberg` se construye por capas en la columna derecha en I.2 (ejes, R_1, isobeneficios, R_2, C, lente, rectas de Q total) y en I.3 se añade la capa de S sobre el mismo gráfico, sin borrarlo. En III.1, `cartel` es la continuación sobre la misma base (curva de colusión, punto K, flecha de desviación): si la pizarra se ha borrado entre bloques, se redibujan solo ejes, R_1, R_2 y C deprisa y se añaden las capas nuevas.
- **I.2**: el problema de la empresa y la CPO escritos; R_i(q_j) lineal; después 𝓛_i = s_i/|ε| recuadrada y, debajo, Σs_i𝓛_i = IHH/|ε|. La caja de estabilidad, las variaciones conjeturales y el Cournot bayesiano, nada (de palabra, una frase si sobra tiempo).
- **I.4**: lista vertical de los 5 supuestos de la paradoja, cada uno con su salida al lado (c_1 < c_2 → p ≈ c_2; convexos; Edgeworth; Kreps-Scheinkman → Cournot; diferenciación; dinámico → II; cooperación → III); `bertrand-reaccion` y `edgeworth` como **apoyo**.
- **I.5**: liderazgo de palabra, `liderazgo-precios` como apoyo; cierre con la columna de cantidades 1, 3/4, 2/3, 1/2 escrita a mano bajo la rejilla; `ineficiencia-oligopolio` y la tabla, como apoyo.
- **II**: `colusion-tiempo` por capas (B^C, pico B^D, caída a B^N, áreas descontadas) mientras se dice la condición; `eq:colusion` recuadrada; debajo, β ≥ 1 − 1/n (y 9/17 de palabra). Las tablas de estrategias y de factores, como apoyo (los signos + y − pueden leerse en voz alta).
- **III.1**: `eq:cartel` escrita; capas de `cartel`; la tabla del dilema escrita a mano en 2×2 con los subrayados por pasos (como la del 3.A.14); `cartel-multiplanta` como apoyo.
- **III.2**: la fórmula del reparto de Nash en una línea; v({i}) = 1, v({i,j}) = 16/9, v(N) = 4 en una línea y debajo φ_i = 4/3 y «16/9 > 4/3».
- **III.3**: de palabra; en la pizarra, solo una flecha desde `eq:colusion` («multa ↓B^C; exención ↑B^D») y las 3 condiciones de impugnabilidad como apoyo.
- **Pronunciación** (si hace falta): Cournot, Bertrand, Stackelberg, Edgeworth, Scheinkman, Rotemberg, Saloner, d'Aspremont, Shapley.
