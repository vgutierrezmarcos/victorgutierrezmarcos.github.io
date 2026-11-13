# Revisión del 3.A.2 — Los economistas clásicos y Marx

Revisión autónoma del 4/11/2026 (Víctor fuera hasta el 9/11). Las dudas se resuelven con la opción recomendada y se anotan como **A02-NN** en «Dudas abiertas». Este informe se escribió en 2 partes: la **parte 1** cubre la introducción, el esquema, la nota del reparto y el apartado I; la **parte 2** (marcada así en cada sección) añade II, III, la conclusión y los 4 anexos. El tema está completo: 30 páginas de cuerpo, 6 de anexos y 6 de bibliografía (compilación de prueba del 4/11/2026, sin referencias indefinidas).

## Resumen

- Tema sin cambio de título («Los economistas clásicos y Marx.»), con los 3 apartados del Word (I caracterización, II autores, III Marx) y sus títulos de 2.º nivel; se añade **II.2 Say** y el III.3 vacío pasa a «Valoración y legado de Marx».
- Reparto: introducción 2′30″; I, 5′30″; II, 13′; III, 8′; conclusión, 1′. Marx pasa de 1.730 palabras con errores de concepto a 8′ del cante.
- Parte 1: introducción nueva con sus 5 bloques (enganche con refrán y hechos de 2018 y 2023), esquema, `notaopositor` con el plan de la pizarra y el apartado I reescrito (sin los pasajes de Landreth y Colander ni la caja traducida de hetwebsite), con la teoría monetaria clásica y las 4 leyes en I.3 y el método completo en I.4.
- Una sola figura nueva (cronología + árbol de influencias) en TikZ; 4 gráficos más ya hechos y 3 pedidos (`_trabajo/graficos-pedidos.json`).
- `3A02.bib` con 125 entradas (las del verificador, las nuevas de contenido sin duplicados y 3 añadidas), `seo.json` nuevo.

- Parte 2: II con 5 autores (Say nuevo) y los modelos de Ricardo y Malthus con estructura a)-e); III rehecho (plusvalía con $W=c+v+\mathit{pl}$, tasas con primas, reproducción, tasa decreciente con Okishio, transformación con ejemplo propio y sus críticos); conclusión con la «nueva clásica»; anexos A (preclásica), B (tabla por líneas), C (ventaja comparativa en extenso, sin FPP) y de test (las 12 preguntas del simulador).

## Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Contextualización, I.1, I.2, I.3 | La escuela clásica «(1776-1850)», «más de 100 años… hasta la última parte del siglo XIX» y «entre 1776 y la década de 1870» | Un solo intervalo: de la *Riqueza* (1776) a los *Principios* de Mill (1848), que dominan hasta la revolución marginalista de los años 70; el núcleo se deshace hacia 1870 (Mill se retracta del fondo de salarios en 1869) (V1, K5) |
| I.1 | «Malthus y Marx… aunque se pueden considerar clásicos en algunos aspectos»; en III.1, Marx «el último clásico» y a la vez «no es un clásico» | Malthus, clásico en la población y la renta y crítico en la demanda; Marx «no es un clásico más, sino su crítico» (K4, P38) |
| I.1 (objeto) | Leyes de los clásicos: «ley de hierro de los salarios… ley de rendimientos decrecientes de Turgot» | 4 leyes con su autor y fecha (Turgot, 1767; West, Malthus, Ricardo y Torrens, 1815); el nombre «ley de hierro» es de Lassalle (1863) y no se atribuye a los clásicos (V40, V53, P47, P54) |
| Caja «Contexto histórico» | «en 1973, el rey Luis XVI fue decapitado» | 1793 (V10) |
| Caja | En 1776 «Turgot y el marqués de Condorcet abandonaron sus puestos» | Solo Turgot; Condorcet siguió en la Moneda hasta 1791 (V8) |
| Caja | «En 1810… Malthus entró en contacto con… Ricardo» | Se conocen en la controversia bullionista (1810-1811), sin año exacto, por la discrepancia entre Bonar (1810) y Sraffa-Dorfman (1811) (V11) |
| Caja | Frase de Kant («Dios encontró un destino similar…») y nota 3 (*Crítica de la razón práctica*) | Fuera: traducción de hetwebsite y fuera de lugar (V10, P49) |
| I.3 | «ciencia lúgubre» por las tendencias seculares de Smith y Ricardo y por Malthus | Nota: la etiqueta es de Carlyle (1849), en un artículo a favor de la esclavitud, contra la igualdad que defendían los economistas (V6) |
| I.3 (nota 33 del original, adelantada) | Ricardo «apoya las tesis de la *currency school*» | Anacronismo: Ricardo murió en 1823 y el debate es de los años 40; fue bullionista y precursor de la *currency school* (*Proposals*, 1816; *Plan*, 1824) (V48) |
| I.4 / conclusión | Senior distingue «economía positiva» y «normativa» | Senior (1836) separa ciencia y arte; la tripartición positiva-normativa-arte es de J. N. Keynes (1891) (V90, K11, P21) |
| I.4 / Mill | «Mill introduce el concepto de *homo economicus*» | La idea es de Mill (1836); el nombre se lo ponen sus críticos a finales del XIX (Persky, 1995) (K12) |
| I.4 | Enlace «ilustración escocesa» a `file:///C:\Users\UX533FD\…` | URL pública de hetwebsite (`HET2026Scottish`) (P67, L12) |
| Contextualización | El nombre «clásicos», sin lugar | Marx (1867, cap. 1, nota 33) y Keynes (1936, cap. 1) (V4) |

### Parte 2

| Dónde | Decía | Dice ahora |
|---|---|---|
| II.1 | *Teoría de los sentimientos morales* «(1959)»; calendario gregoriano «en 1763»; «Génova»; madre «de 17 años» muerta «en 1782» | 1759; 1752; Ginebra; sin la edad, muere en 1784 (V16, V17, V22, V24, V29) |
| II.1 | Anécdotas (incapacidad de ser ladrón, uniforme del hermanastro, cátedra rechazada); Franklin, Diderot y d'Alembert en París | Solo el robo a los 3 años; en París, Quesnay y Turgot (V18, V19, V25, V28) |
| II.1 | La mano invisible, una idea de la *Riqueza* «ya desarrollada» en los *Sentimientos* | Sus 3 apariciones (astronomía, 1795; *Sentimientos*, 1759; *Riqueza*, 1776), con Rothschild (1994) (V31) |
| II.1 | Cita del panadero incompleta; «trabajo ordenado»; 3 principios de los impuestos; «Do what you do best…» | Carnicero, cervecero y panadero (libro I, cap. II); trabajo comandado; 4 máximas; la frase en inglés fuera (V32, V38, V41, V43) |
| II.1 | «Ley de hierro de los salarios» como término de Smith | El nombre es de Lassalle (1863) (V40, K10) |
| II.3 Ricardo | Cita del valor que mezcla 2 pasajes; «sesgo ricardiano»; «Sir Thomas Peel»; «Thomas Barro»; apoyo a la *currency school* | 2 citas separadas con capítulo; vicio ricardiano; Robert Peel; Robert Barro; bullionista y precursor (V47-V50, V59) |
| II.3 | Gráfico de distribución tomado de YouTube; «ley de hierro»; «Solow y Swan influidos por Ricardo» (nota 19) | Gráfico propio a partir de Kaldor (1956), con el aviso de que Ricardo no dibujó gráficos; salario de subsistencia; la valoración remite al estado estacionario de Solow con matiz (V54, K20) |
| II.4 Malthus | «1978»; 7 ediciones; «Condorecet»; «freno moral = completa abstención del matrimonio»; cita «miseria y vicio» literal; Keynes «le dedica la *Teoría general*»; Franklin como precursor | 1798; 6 en vida; Condorcet; contención moral = retrasar el matrimonio; paráfrasis con lo literal («insuperable»); cap. 23 y *Essays in Biography* (1933); Hume, Smith y Wallace (V70-V77, K13) |
| II.4 | «Los economistas nunca han desarrollado una teoría del desarrollo tecnológico» | En su tiempo no la había; hoy, el crecimiento endógeno (K14) |
| II.5 Mill | «Defectos del mercado rebautizados por Pigou como fallos de mercado»; cita del estado estacionario no literal; Mill entre *currency* y *banking* según la coyuntura; retractación repetida 2 veces | Bator (1958); cita real del libro IV, cap. VI; *banking school*; retractación de 1869 una vez (V83, V85, V86, V88) |
| III | $c$ como «trabajo vivo / valor de cambio», $w$ como capital variable, «$\mathit{pl}=c-w$», «$c+w+\mathit{pl}=V$, el valor del trabajo»; trabajo concreto = capital variable y abstracto = plusvalor; fetichismo como «relaciones contractuales falsas» | $W=c+v+\mathit{pl}$, el valor de la mercancía; doble carácter del trabajo; fuerza de trabajo frente a trabajo; fetichismo con la cita de libro I, cap. 1, § 4 (P6-P9, P48, K8, K9, V94, V95) |
| III | Tasa decreciente por «presiones salariales»; «crítica» que es una contratendencia de Marx | Ley con la fórmula, contratendencias, tope $(v+\mathit{pl})/c$ y Okishio (1961) |
| III | 5 medidas del *Manifiesto*; «trabajadores de todos los países, uníos»; máxima de Gotha al revés; «Stalin – Gran Salto Adelante» | 10 medidas; «¡Proletarios de todos los países, uníos!»; la máxima de 1875; Mao (1958) (V91, V99-V101) |
| III | «Último clásico» y «no es un clásico» a la vez | Postura única: su crítico (K4, P38) |
| Anexo A | «12 veces» los 250 años; «Ibd Khaldun»; 2 clases de Quesnay; Turgot 1765; Gournay «fisiócrata» | Más de 9 veces; Ibn Jaldún; 3 clases (1766); Turgot 1767; Gournay, intendente próximo a los fisiócratas (V44, V45, V103) |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo, enganche) | «Para rastrear la historia de las ideas… identificar el objeto de la ciencia económica» | Integrado en la 1.ª viñeta de la contextualización, con `\vertema{3.A.1}` |
| P2 (amarillo, enganche) | «…encontrar un punto de partida en el tiempo…» | Integrado: 1776 como punto de partida y las 3 limitaciones de los escritos anteriores |
| P14 (4 «Nota al opositor», portada) | Aviso del cambio de temario y ficha del tribunal | Fuera (aviso de cambio de temario). La ficha del tribunal inspira el anexo B (parte 2) |
| P17 (comentario, I.2) | «Cronología con sucesos, autores y obras… crisis del 1929…» | Figura nueva `fig:clasicos-tiempo` (cronología 1750-1875, sin 1929, que no es del periodo) |
| P18 (comentario, I.2) | Smith, viaje a Francia y obras | Pasa al contexto de Smith (parte 2); el comentario no se publica |
| P19 (comentario, I.2) | «J.S. Mill y su padre…» | Pasa al contexto de Mill (parte 2); el comentario no se publica |
| P21 (advertencia) | «Cuidado con los términos economía positiva y normativa» | Resuelta en I.4 (Senior y J. N. Keynes); el III.3 cambia de título (parte 2) |
| P25 (Imagen 1, captura de Landreth y Colander) | Árbol de influencias | Redibujado en TikZ y fundido con la cronología en una sola figura |
| P39 (estructura vacía) | Tabla vacía | Estructura con los 3 apartados y su orden |
| P41 (I.4, 3 viñetas sin desarrollar y 1.200 palabras de Smith) | «¿Qué es la economía política?», «Empleo del ensayo», «Diferencias entre autores» | Desarrolladas; lo de Smith (valor, política) pasa a II.1 (parte 2) |
| P49 (caja «Contexto histórico») | Traducción casi literal de hetwebsite («The Ricardian Era») | Redactada de nuevo, corta, en `anotaciones` y citada (`HET2026Ricardian`) |
| P50 (lo que deja el 3.A.3) | Dinámica frente a estática; tabla de rasgos; Chang | Dinámica en I.3 con remisión a la tabla de rasgos del 3.A.3 (sin copiarla); Chang en nota de los mercantilistas (contextualización) |

### Parte 2

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P3 (Smith, «[ver documental]») | Estudios sin datos | Glasgow con 14 años (1737), Hutcheson, Balliol (1740-1746) |
| P4 (Smith, beneficios) | Interés y riesgo dentro del beneficio | Comprobado y citado (libro I, cap. IX); fuera «el capital en términos de trabajo» |
| P5 (Malthus) | Frase de enlace de Landreth y Colander | Reescrita como nexo Ricardo → Malthus |
| P6-P9 (Marx, amarillos y comentario privado) | Fórmulas y conceptos erróneos; nota con nombres de preparadores | Rehecho con la notación de *El capital*; el comentario no se publica (sin nombres) |
| P10-P12 (transformación, Steedman, Roemer) | Mencionados sin desarrollo | Tabla propia, Böhm-Bawerk, Bortkiewicz, Samuelson, Steedman, Morishima y Roemer |
| P13, P15, P16, P42 (anexo 1) | Mercantilismo con «pág. 46»; «ver libro en francés»; «buscar sobre escuela de Salamanca»; precursores y fisiocracia vacíos | Completados (sin página de Landreth y Colander, no comprobada); escolásticos con Daniel (2021) y Grice-Hutchinson (1952) |
| P20 (advertencia del gráfico de Ricardo) | «No fue elaborado por el autor» | En el pie y en «Extensiones»: versión de Kaldor (1956) y Pasinetti (1960) |
| P21 (III.3 vacío) | «Economía positiva» y «normativa» | III.3 «Valoración y legado de Marx», abierto con la distinción avisada como posterior |
| P22 (cajas de anotaciones) | 6 enlaces | Quedan los 2 documentales de Smith, Escartín y HET, en una caja del anexo de test; fuera Rallo (privado), VisualEconomik y el de Ricardo en un minuto |
| P26-P34 (figuras) | Capturas de manuales, YouTube, Policonomics, Escartín, TED-Ed | 7 gráficos propios o de dominio público; fuera Pandora y las 3 FPP de la nota 27 |
| P40 (conclusión, preguntas de exámenes) | Opinión y recapitulación vacías; «Preguntas de otros exámenes» vacío | Conclusión completa; anexo de test con las 12 preguntas oficiales |
| P43 (anexo 2) | Índice alternativo | `tab:lineas` (6 autores × 6 líneas) |
| P44-P48, P68 (fechas, nombres, atribuciones, notas de opinión) | Ver «Errores corregidos» | Corregidas; fuera la nota 55 (opinión) y la cita de Lenin (no encontrada) |
| P65, P66 | Bibliografía con nombres de preparadores; quia.com | Fuera; enlace genérico al simulador |

## Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Estatua de Marx en Tréveris (enganche nuevo) | — | Descubierta el 5/5/2018, bicentenario del nacimiento; bronce, 5,5 m con el pedestal; regalo de China (escultor Wu Weishan) | Der Spiegel, 5/5/2018 (`Spiegel2018Marx`) | https://www.spiegel.de/wirtschaft/soziales/karl-marx-statue-in-trier-enthuellt-geschenk-aus-china-a-1206388.html | 04/11/2026 | Wikipedia, «Karl Marx statue» (con FAZ, 5/5/2018: 5,50 m con la base). La cifra de 4,4 m de la propuesta K25 (la estatua sin pedestal) no la he encontrado en una fuente primaria: no se usa |
| Tricentenario de Smith (enganche nuevo) | — | 2023, «Adam Smith 300» de la Universidad de Glasgow | University of Glasgow (`Glasgow2023Smith300`) | https://www.gla.ac.uk/explore/adamsmith300/ | 04/11/2026 | Wikipedia, «Adam Smith» (adoquines con sus citas en High Street, Glasgow, diciembre de 2023, por el 300 aniversario). Kirkcaldy y Edimburgo (K25) no los he comprobado: no se citan |
| *Bullion Report* | sin fecha | 8/6/1810 | `BullionReport1810` (verificador, V48) | https://www.gold.org/sites/default/files/documents/1810jun8.pdf | 04/11/2026 | HET, «The Bullionist Controversies» |
| Parte 2: población y producción agraria de Inglaterra, 1700-1850 | — | Población ×3,3 y producción agraria ×3,1 (gráfico `malthus-datos`) | Bank of England, *A millennium of macroeconomic data* v3.1, hojas A2 y A3 (`BoE2017Millennium`), con Broadberry *et al.* (2015) | https://www.bankofengland.co.uk/statistics/research-datasets | 04/11/2026 | Población de 1701 y 1801 cotejada con Wrigley *et al.* (verificador); producción agraria sin segunda fuente independiente |

El resto de datos del tema son fechas y atribuciones comprobadas por el verificador (V1-V116), aplicadas tal cual.

## Contenido añadido

- **Introducción**: enganche con refrán («Cada uno habla de la feria según le va en ella») y 2 hechos recientes (Tréveris 2018, Glasgow 2023) y la pregunta que responde la idea final; relevancia en 4 viñetas (teoría, política, temario y la pieza común de Schumpeter con su nota, idénticas a las del 3.A.3-3.A.7); contextualización con los 3 precedentes (mercantilistas con la nota de Chang, 2002; Escuela de Salamanca, con Azpilcueta, 1556, antes que Bodin; fisiócratas, Quesnay, 1758) y el nombre «clásicos»; problemática en 4 preguntas; estructura (K25, C3, C4, K27).
- **Esquema y `notaopositor`**: reparto, refranes pegatina y plan de la pizarra en 3 zonas (K29 con los minutos y las pegatinas del coordinador).
- **I.1**: la pieza común de Schumpeter con la variante «escuela con líder» (Smith), seguidores, Malthus y Marx como críticos, y el objeto con la cita del prefacio de Ricardo (K23).
- **I.2**: periodo, antecedentes, 3 tratados, 2 críticos desde dentro, el final de la escuela (Mill, 1869; Jevons, 1871), la figura `clasicos-tiempo` y la caja de contexto redactada de nuevo (C7, K39, K40).
- **I.3**: 3 rasgos (armonía, crecimiento con la dinámica frente a la estática y la frase común del bloque, desconfianza del gobernante) (C8, K24, K28); las 4 leyes de los clásicos y el fondo de salarios (C9); **la teoría monetaria clásica entera** (Hume, controversia bullionista, *currency* frente a *banking school*, Ley de Peel de 1844 y sus suspensiones) (C11).
- **I.4**: economía política como ciencia moral, el ensayo, las diferencias entre autores (Smith y la Ilustración escocesa; el vicio ricardiano; Malthus y los datos; Senior y Mill, 1836; Marx), positiva y normativa, recapitulación y puente a II (C13, K32).
- **Gráfico**: `clasicos-tiempo` (fusión de `linea-tiempo-clasicos` y `clasicos-influencias` de la fase de contenido). Copiados a `graficos/` con la ruta de `tikz-tcee` corregida: `smith-riqueza`, `ricardo-distribucion`, `malthus-poblacion`, `materialismo-historico` (para la parte 2).

- **Parte 2**:
  - **II.1 Smith**: vida con fechas comprobadas, las 3 apariciones de la mano invisible, la fábrica de alfileres con las cifras del 3.A.11, valor (trabajo comandado, castor y ciervo, precio natural), salarios (fondo y salario natural), beneficios, rentas, ahorro y letras reales, comercio (ventaja absoluta, defensa) y política (3 deberes, 4 máximas). Gráficos `smith-riqueza` y `alfileres`.
  - **II.2 Say** (nuevo, 1′): *Traité*, ley de los mercados (paráfrasis del cap. XV, sin comillas), James Mill (1808, paráfrasis), Lange (1942) con `eq:say` y las palabras del 3.A.21, identidad frente a igualdad (Becker y Baumol, 1952) y el *general glut*.
  - **II.3 Ricardo**: valor (citas reales, el «93 %» de Stigler, Sraffa), el modelo de distribución a)-e) con `eq:reparto-ricardo` (`\funcionclave`), `eq:beneficio-ricardo` ($B/K$) y `fig:ricardo`; Say y bullionismo; ventaja comparativa con `tab:pano-vino` y `eq:ventaja-comparativa`; política y la equivalencia ricardiana en nota.
  - **II.4 Malthus**: el principio de la población a)-e), con `fig:malthus` y la evidencia de Inglaterra (`fig:malthus-datos`); la demanda efectiva y Keynes.
  - **II.5 Mill**: vida, valor, leyes de producción y distribución, fondo de salarios y su abandono (1869), estado estacionario, Say como igualdad, flujo-especie y *banking school*, demanda recíproca, industria naciente, Estado e impuestos.
  - **III Marx**: contexto y `tab:clasicos-marx`; materialismo histórico (`fig:materialismo`); valor y plusvalía con `eq:valor-marx` (`\funcionclave`), `eq:tasas-marx` y `fig:jornada`; acumulación y esquemas de reproducción (`eq:reproduccion-simple`); 5 leyes, contratendencias, Okishio y 3 teorías de la crisis; política; transformación (`tab:transformacion`) y sus críticos; legado (Kalecki, Robinson, Piketty).
  - **Conclusión** (K30, con «En conclusión,», la «nueva clásica» y la idea final con el refrán).
  - **Anexos**: A (comienzos, Salamanca, mercantilismo con la nota de Chang, precursores y fisiocracia con 3 clases y Turgot 1767), B (`tab:lineas`), C (ventaja comparativa en extenso, sin FPP) y test (`tab:test`, las 12 preguntas oficiales).

### Propuestas: aplicadas y no aplicadas (parte 1)

**Contenido (C)**
- C1 (esquema y reparto): **no** en su reparto (I 5′, II 12′, III 9′30″), ni con sus pegatinas («poderoso caballero…», «el dinero no da la felicidad», «el pez grande…»): manda la estructura de coherencia (K29) por decisión del coordinador. Sí el formato del esquema y de la nota.
- C2 (enganche «donde comen dos, comen tres» con la ONU y la FAO): **no**; enganche de coherencia (D3 de coherencia, decisión del coordinador). El refrán queda como pegatina de Malthus.
- C3 (relevancia): aplicada en parte (viñeta de Schumpeter y su nota, P1); las 3 primeras viñetas son las de K25.
- C4 (contextualización y problemática): aplicada fundida con K25 (3 limitaciones, punto de partida, nombre de «clásicos» con la cita de V4 en lugar de `Marx1859Kritik`).
- C5 (estructura y gráfico de influencias): estructura de K25 (con Say en II); el gráfico, fundido con la cronología (D7).
- C6 (I.1): aplicada con el texto de K23.
- C7 (I.2 y caja): aplicada; la caja se conserva como `anotaciones` corta (K40) en lugar de desaparecer.
- C8 (rasgos): aplicada con la corrección de V6 (Carlyle, en nota) y sin la frase de las libertades que «se fecundaban mutuamente».
- C9 (4 leyes): aplicada (con el flujo-especie, como Tebar); el fondo de salarios, en viñeta aparte (A02-08).
- C10 (Say en I.3): **no** en I.3; Say va a II.2 (decisión del coordinador, D1). Su texto se usa en la parte 2.
- C11 (teoría monetaria en I.3): aplicada.
- C12 (tabla clásicos-Marx en I.3): **no** en I.3; va a III.1 (K33, D8; parte 2).
- C13 (I.4): aplicada; el ensayo de Mill con `Mill1836Definition` en lugar de `Mill1844Essays`; el vicio ricardiano sin página (V49: no cotejada).
- C14-C54: parte 2.

**Datos (V, L)**: aplicadas en la parte 1 V1, V2 (viñeta común sin cambiar), V3 (sin cita literal de Schumpeter), V4, V5, V6, V7, V8, V10, V11, V12, V14, V40, V48, V53, V90 y L11-L12. V9 (obras de 1776 de Condillac, Bentham y Paine) no se usa: la caja se acorta. V13: en I.3 (bullionistas y exceso de billetes). El resto, parte 2.

**Coherencia (K, CC)**: aplicadas K1 (Say añadido), K3, K4, K5, K6, K7 (rendimientos decrecientes con los márgenes intensivo y extensivo, en I.3), K11, K12, K16 (introducción), K17 (etiquetas), K21 (las remisiones de la introducción y de I), K22, K23, K24, K25, K26 (refranes comprobados con `grep` el 4/11: ninguno en otro tema ni en las propuestas del 3.A.1), K27, K28 (frase común), K29 (con la lista de pegatinas del coordinador, sin «los productos se pagan con productos»), K32, K33 (en parte: ver A02-08), K38 (sin copiar `tab:rasgos`), K40. K10 y K13-K15, K18-K20, K30-K31, K34-K37, K39 (salvo `fig:clasicos-tiempo`), K41-K44: parte 2. CC1-CC10 son cambios al canon: no los aplica el editor.

**Pendientes (P)**: resueltos en la parte 1 P1, P2, P14, P17 (y P18-P19 trasladados), P21 (en I.4), P25, P38, P39, P41, P47, P49, P50 (en parte), P53, P54, P62, P64 (P17-P19 no se publican), P67.

### Propuestas: aplicadas y no aplicadas (parte 2)

**Contenido (C)**
- C14-C21: aplicadas, con los datos de V15-V43 (sin `Ross2010Life` ni `Rae1895Life`: las fechas son las de Otteson y Glasgow, comprobadas por el verificador). En C21, **sin** `\vertema{4.B.1}`: no comprobado (instrucción del coordinador). C22: aplicada (el método de Smith se recorta).
- C10 (Say): aplicado en II.2 en lugar de I.3, **sin** la anécdota de Napoleón (no comprobada) y sin la frase literal de Say (paráfrasis).
- C23-C28: aplicadas con notación del canon: $\bar w$, $B/K$ (no $g$) y estructura a)-e) completa (se añaden «Extensiones» y «Evidencia»). C27: la tabla se llama `tab:pano-vino` (K36), no `tab:ricardo`. C28: `Barro1974`, nota con `\vertema{3.A.39}` (no 3.A.38, K22).
- C29-C31: aplicadas; sin los datos de la ONU y la FAO (claves no incorporadas; la evidencia es la de Inglaterra, por decisión del coordinador). Darwin y Wallace, sin cita.
- C32-C35: aplicadas, con V80-V89 (Mill en la *banking school*, V88, frente a la postura matizada de C34: se dan las 2 cosas). Industria naciente con `\vertema{3.B.8}` (K21), no 3.B.28.
- C36-C43: aplicadas con la notación de coherencia (K8, K41: $\mathit{pl}'$, $c/v$, $g'$ con primas) y no la de contenido ($e$, $k$, $g$); el ejemplo de la jornada es el de K9 (10 h = 5 + 5), no el de 4 + 4. C40: sin la tabla de los esquemas (solo las cifras de la simple en el texto) para no alargar III. C42: las 10 medidas resumidas en una viñeta (5 citadas), no la lista entera.
- C44-C45: aplicadas (fuera la nota 51 errónea y la caja de Rallo).
- C46: **no** la de contenido (idea final con «donde comen dos, comen tres»): se usa K30, con la feria del enganche (decisión del coordinador); se toma de C46 la opinión sobre el pesimismo. La frase de Say sobre la historia (V114), fuera.
- C47: la caja de lecturas pasa al anexo de test (la idea final queda como última frase del tema).
- C48: aplicada y completada con un resumen propio de los comienzos del original (Guan Zhong, griegos, árabes, escolásticos), sin Pandora ni la imagen de TED-Ed. Fisiocracia sin intervalo de años (A02-13).
- C49: aplicada, traspuesta (autores en filas) y con Say; Malthus en dinero, «---» (A02-14).
- C50: ampliada a una tabla con las 12 preguntas oficiales y dónde se tratan.
- C51-C54: aplicadas las erratas; C54 (notación al canon) es de la fase de canon.

**Datos (V)**: aplicadas V15-V116 en lo que toca a II, III, la conclusión y los anexos. Sin comprobar y por eso fuera o sin comillas: V19, V62 (James Mill, paráfrasis), V66 (DLE, fuera), V78 (Simon, sin cita textual), V101 (Lenin, fuera), V105 («casi mil años», sin cifra), V106 (sin página), V114 (Say, fuera).

**Coherencia (K)**: aplicadas K8-K10, K13-K15, K18 (sin títulos vacíos), K19 (todas las promesas de los temas revisados: precio natural, mano invisible, alfileres con las cifras del 3.A.11, Turgot, Böhm-Bawerk, Lange y Becker-Baumol, Kalecki, nueva clásica, Chang, Malthus y el Club de Roma), K20, K21 (las 17 remisiones), K22, K30, K31, K34-K39, K41, K42. K43-K44 y CC1-CC10 son del canon.

**Pendientes (P)**: con la parte 2 quedan resueltos P3-P13, P15, P16, P19, P20, P22, P24-P36 (P24, retratos de la portada: no se ponen; la plantilla no los usa), P37, P40, P42-P48, P51, P52, P55-P61, P63, P65, P66, P68.

## Coherencia

- Con el **3.A.3**: dinámica frente a estática con remisión a su tabla de rasgos (sin copiarla); la viñeta y la nota de Schumpeter, idénticas; «de Smith (1776) a Mill (1848)».
- Con el **3.A.4, 3.A.5 y 3.A.7**: la frase común «con precios y salarios flexibles los mercados se vacían y el dinero solo determina el nivel de precios»; el nombre «clásicos» de Marx y su extensión por Keynes.
- Con el **3.A.11**: Turgot (1767) y West, Malthus, Ricardo y Torrens (1815), con `Turgot1767Observations` y `Humphrey1997Algebraic` (copiada de `3A11.bib`). Queda resuelta la contradicción de la nota 38 (1765) anotada en `mapa.yaml`.
- Con el **3.A.1** (en revisión a la vez, no se toca): positiva y normativa (Senior, 1836; J. N. Keynes, 1891) y la figura del *homo oeconomicus* con las mismas palabras que propone su coherencia («la figura que después se llamará *homo oeconomicus*»).
- Con el **3.B.28**: la nota de Chang (2002) y List (1841), con `\vertema{3.B.28}` y `\vertema{3.B.8}`.
- **Pieza común del bloque**: variante «escuela con líder indiscutido» (Smith), como la NMC (Lucas) en el 3.A.6 (CC7 de coherencia, [decidir] para el canon).

- **Parte 2**: el 3.A.2 cumple lo que le remiten el 3.A.3 (Böhm-Bawerk, paradoja, bienes no reproducibles, cita de Mill idéntica), el 3.A.4 (Kalecki, Malthus en el cap. 23, maquinaria de 1821), el 3.A.6 (la «nueva clásica»: cierra la entrada de `canon/pendientes-coherencia.md`, l. 721), el 3.A.11 (alfileres, Turgot), el 3.A.16, el 3.A.21, el 3.A.22-3.A.23, el 3.A.34, el 3.B.28 y el 3.B.31. Con el 3.B.5 y el 3.B.20 (sin revisar): Robert Peel y la notación $a_X^A$ los tendrán que adoptar al revisarlos. La notación de Marx ($W$, $\mathit{pl}'$, $c/v$, $g'$) es local y está avisada en una nota; falta llevarla a `notacion.md` (CC3).

## Comentarios de Víctor (9/11/2026)

Aplicados en la fuente (`3A02.tex`, `3A02.bib`, `graficos/smith-riqueza.tex`, `graficos/clasicos-tiempo.tex` y, para que no contradiga, `repaso/3A02-repaso.tex`); sin construir el tema (lo hará el coordinador).

### Del 3.A.2

| Comentario | Qué se hizo |
|---|---|
| «La ciudad de Tréveris inauguró…», no «descubrió» | Enganche: «la ciudad de Tréveris inauguró una estatua…». |
| Mantener los documentales de Smith y las anécdotas de su vida (tartamudo, los vagabundos que lo devuelven porque no sirve para ladrón…), que vienen de Jean-Marc Daniel, *Histoire vivante de la pensée économique* (3.ª ed.); todo breve en un recuadro gris, sin perder nada | Nueva caja gris «La vida de Adam Smith, con sus anécdotas» en II.1, que junta lo de la revisión (Otteson, Glasgow) con todo lo del tema antiguo: niño introvertido, de físico desgraciado y tartamudo; el robo (3 años, 4 según Daniel; lo devuelven porque no sirve para ladrón, según Daniel; su tío lo recupera, según otras biografías); la separación del medio hermano; las clases pese al tartamudeo; Townshend y los hijastros; Toulouse y el libro «para pasar el tiempo» (carta a Hume); Ginebra y Voltaire; París con Quesnay, Turgot, Hume, Franklin, Diderot y d'Alembert («según Daniel»); la muerte de Hew Scott; la cátedra rechazada y el uniforme del medio hermano en la aduana; la vida excéntrica tras morir su madre (1784) y la muerte en un relativo olvido. Los 2 documentales de Free To Choose Network van al final de la caja con `\href` y su título («The Real Adam Smith: Morality and Markets» y «… Ideas That Changed The World»), y salen de la caja «Para ampliar» del anexo de test, que ahora remite a la de Smith. En el cuerpo quedan 4 viñetas de vida. `Daniel2021Histoire` comprobada: 3.ª edición, Pearson France, mayo de 2021, ISBN 978-2-326-00281-4 (Fnac, Eyrolles, Decitre); se añaden el ISBN y la editorial al `.bib`. Se deshacen así V18, V19, V25 y V28 de la revisión (que quitaban esas anécdotas por no encontrarlas), ahora con la fuente que da Víctor. |
| La mano invisible en los 6 puntos numerados del tema antiguo, en lugar de los 4, manteniendo «la gente del mismo oficio…» | `\paragraph{La mano invisible}` con `enumerate` de 6 puntos (individuo en el centro; sentimientos; interés propio, con la cita del carnicero; interés individual → beneficio social, con la cita de la mano invisible y el precio natural; la armonía se rompe con las prácticas empresariales, con la cita de «la gente del mismo oficio…»; los principios morales sostienen la armonía, con *Sentimientos*, parte I, cap. I). Vuelven como notas al pie las del antiguo (Rousseau, Galbraith). Las 3 apariciones de la metáfora y el 1TFEB siguen detrás. |
| Gráfico 2: que se vea que la extensión del mercado también depende de la acumulación de capital | `smith-riqueza`: nueva flecha de «Acumulación de capital» a «Extensión del mercado» con el rótulo «amplía el mercado» (capa 5); compilado (PDF, SVG, PNG) y revisado. En el texto, una viñeta nueva en «Los límites» (la acumulación hace crecer la renta y paga caminos, canales y puertos). |
| Teoría del valor: base de lo que había antes, con la frase explícita «Smith distingue entre valor de intercambio y valor de uso»; viñetas que se entiendan solas | Reescrito con el orden del antiguo: la frase literal y las 2 definiciones; la paradoja del agua y los diamantes en 2 viñetas; la medida (trabajo comandado, que corrige el «trabajo ordenado» del antiguo); la causa (costes de producción, teoría de oferta) en el estado primitivo (con la dureza y la destreza) y en la sociedad avanzada; precio natural y de mercado en 3 viñetas (con la gravitación de la nota 12 del antiguo), y el problema de la circularidad. Se aplicó la misma regla de viñetas autónomas al resto de II. |
| Cada autor con «Contexto, método y obra», «Líneas de investigación» y «Recomendaciones»; los subapartados de dentro, con títulos de menor nivel; Say sin subapartados (puede desarrollarse en Smith) y con caja gris | Smith, Ricardo, Malthus y Mill tienen ahora 3 `\subsubsection` iguales (Contexto, método y obra; Líneas de investigación; Recomendaciones de política económica); las líneas van en `\paragraph` (la mano invisible, la riqueza, el valor, crecimiento y distribución, el ahorro y el dinero o la ley de Say y el dinero, el comercio). Los modelos de Ricardo y Malthus pasan a `\paragraph` con el nombre del modelo y sus bloques a)-e) en `\subparagraph` (como el 3.A.9); i)-iii) van como rótulos en negrita y cursiva, solos en su línea. Dentro de «Contexto, método y obra», los rótulos Vida, Contexto, Obra, Método y Lugar en la escuela, solos en su línea y con viñetas debajo (también en Marx, III.1). Say queda en II.2 (el esquema no cambia) en viñetas, sin bloques; lo que no se canta (James Mill, la frase de Keynes, la formulación de Lange con `eq:say`, Becker y Baumol) pasa a una caja gris, y la «ley de Say antes de Say» de Smith enlaza con él. El arranque de II y la estructura de la introducción anuncian los 3 bloques; III añade una viñeta que dice que Marx sigue el mismo patrón. |
| Gráfico 4: que quede claro el aviso «aunque los gráficos sirven para ilustrar… no fue elaborado de forma original por el autor» y el enlace https://www.youtube.com/watch?v=wVbG39oIcpI | Viñeta «Un aviso sobre el gráfico» al final del desarrollo del modelo, con el texto de Víctor, y nota al pie con el enlace (`\href`, título del vídeo: «Renta diferencial de la tierra. David Ricardo»). El pie del gráfico repite que lo ilustra pero no es de Ricardo. |
| Tabla 1: quitar la última fila y marcar en qué tiene ventaja comparativa cada uno; enlazar con una tabla de ventaja absoluta como en el 3.B.5 antiguo, con la pizarra eficiente y diciendo en Smith que el ejemplo es el de Ricardo | Nueva `tab:ventaja-absoluta` en Smith (la del 3.B.5 revisado: paño 100/110, vino 120/80, ventaja absoluta de cada país en azul), presentada como «el ejemplo con el que Ricardo explicará la ventaja comparativa en sus *Principles*, con una sola cifra cambiada», y la indicación de dejarla en la pizarra. En Ricardo, `tab:pano-vino` sin la fila del coste relativo; la ventaja comparativa de cada país (Inglaterra, paño; Portugal, vino), sombreada y en azul, y 2 viñetas que explican por qué (desventaja menor 100/90 < 120/80; ventaja mayor 80/120 < 90/100, con los costes comparativos 0,83/1,125 y 0,89/1,2). En la pizarra solo se tacha el 110 y se escribe el 90 (también en `notaopositor`). La tabla del paño y el vino pasa a ser la tabla 2. |
| Malthus: la insuficiencia de la demanda con la estructura del antiguo (corrigiendo errores y sumando lo nuevo); recuperar «Recomendaciones de política económica» (Smith y Franklin precursores, Carlyle); lo largo, en cajas grises | `\paragraph{Problemas de la insuficiencia de la demanda: Principios de economía política (1820)}` con el orden del antiguo: punto de partida (Smith y Ricardo, solo oferta) → rechazo de la ley de Say en la versión de James Mill → ¿quién crea la demanda? (trabajadores, capitalistas, consumidores improductivos, sobre todo terratenientes) → polémica con Ricardo y eco en Keynes (lo nuevo). Correcciones: el antiguo decía que Malthus pensaba que parte del ahorro se «atesora»; su argumento es el exceso de ahorro *invertido* (sobreacumulación), y precisamente no tenía teoría del atesoramiento (se deja dicho); el antiguo enlazaba la crítica a las leyes de pobres con la demanda, y es un argumento de población (va a Recomendaciones); el «avaro que cierra bajo llave» no se ha podido localizar en Malthus y no se incluye. Nueva `\subsubsection{Recomendaciones de política económica}`: de dónde sale la tesis (Smith y Franklin, según Landreth y Colander; Hume, Smith y Wallace, citados por Malthus en 1798; Cantillon), leyes de pobres, contención moral y protección de la demanda (Leyes de Granos, gasto improductivo). Lo largo del antiguo (los 3 factores del origen, la 1.ª y la 2.ª edición, la «ciencia lúgubre» de Carlyle con su contexto real y la aplicación con el fondo de salarios) va en una caja gris. El «Lugar en la escuela» de Malthus recupera la relevancia del antiguo (1.ª teoría de la población, adjetivo «maltusiano», Keynes). |
| J. S. Mill: el apartado de relevancia como antes («Lugar en la escuela»), con el patrón visible | «Lugar en la escuela» con la estructura del antiguo: consolida el pensamiento clásico; en el método, el *homo oeconomicus* (con la nota del positivismo del antiguo); en la teoría, la demanda recíproca y el primer economista del bienestar (fallos de mercado, Bator 1958, no Pigou). Vuelven también del antiguo: el *Principles* como manual con objetivo político; «influido por el socialismo, escribe contra él»; renuncia a la medida invariable del valor y por qué importan sus 3 casos; renta y beneficio (abstinencia, riesgo, dirección, que corrige la nota 44); herencia; ahorro de los trabajadores; funciones necesarias y facultativas; igualdad de oportunidades, sufragio femenino y condena de la esclavitud. |

### Generales que tocan al 3.A.2

| Comentario | Qué se hizo |
|---|---|
| Nombres enteros en versalitas | Revisado tras la pasada mecánica: «Jean-\autor{Baptiste Say}» (título de II.2 y gráfico `clasicos-tiempo`, recompilado) pasa a `\autor{Jean-Baptiste Say}`; en la ficha, `J.\,\autor{S. Mill}` y `J.\,\autor{N. Keynes}` pasan a `\autor{J. S. Mill}` y `\autor{J. N. Keynes}`; los nombres nuevos van enteros (Jean-Marc Daniel, Hew Scott, Daniel Malthus, Ludwig Feuerbach, Karl Kautsky, Pedro Scaron…), también en los títulos de los documentales. |
| Remisiones al margen de la frase; ningún gráfico con otro tema como fuente | Ninguna figura ni tabla cita otro tema en `\fuente{}`. Reescritas 2 frases que hacían de `\vertema` parte de la gramática: «se resumen en la tabla de rasgos de los neoclásicos \vertema{3.A.3}» y «el modelo de referencia… es del tema del comercio internacional \vertema{3.B.5}» (anexo C). |
| Introducción y conclusión con rótulos solos y viñetas indentadas | Ya estaban (pasada mecánica); se comprobó. |
| Viñetas que se entienden solas; patrones visibles | Aplicado en todo II y en III.1 (cada bloque de autor y cada rótulo de «Contexto, método y obra» solo en su línea; listas largas partidas). |
| Datos que no se cantan, en cajas grises | Cajas nuevas: la vida de Smith, la ley de Say en lenguaje moderno y los orígenes del *Ensayo* de Malthus. |
| Notas del antiguo interesantes, aunque sea como anexo (pensamiento) | Recuperadas como notas o viñetas: contexto de Smith (guerra de los Siete Años, monopolios, burguesía; nota 7), Rousseau (nota 8), Galbraith (nota 9), servicios como trabajo improductivo (nota 10), gravitación del precio natural (nota 12), Smith contra la protección de la industria naciente (nota 14), Toulouse y Ginebra (nota 6, en la caja), Simon y la «ciencia feliz» (nota 42), Mill positivista (nota 43). No se recupera la nota 11 («los fisiócratas distinguían 2 clases»): es un error, Quesnay distingue 3 (anexo A). |

### Comprobaciones

- Llaves y entornos cuadran; ningún `\ref` sin `\label` (los 2 «que faltan» son las etiquetas opcionales de `\funcionclave`); todas las citas están en el `.bib`.
- `verificar-tema.py 3A02` (sin construir): solo los errores de PDF, HTML, Word y ficha anteriores a la fuente; minutos 30, 3 apartados, sin apellidos sin `\autor{}`.
- Gráficos recompilados (solo los del tema): `smith-riqueza` y `clasicos-tiempo`.
- La ficha de repaso suma texto (los 6 puntos de la mano invisible, el valor de uso y de cambio, las 2 ventajas): hay que comprobar al construirla que sigue en 4 páginas.

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Pizarra: Reparto: quitado el plan de pizarra del reparto del cante (zonas izquierda/centro/derecha, qué se borra y qué se queda); se conservan tiempos, refranes, gráficos y funciones clave; «el tribunal espera ver su ecuación en la pizarra» → «oír»; las 2 viñetas «En la pizarra… tachar el 110 y escribir 90» reescritas («basta con cambiar el 110 por el 90») (7 frases). Títulos: ninguno en 2 líneas. Ficha de repaso: su apartado «Pizarra» (plan del cante) se mantiene. |


## Comentarios de Víctor (11/11/2026, 5.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Tema aprobado; solo regla de citas (fuentes secundarias fuera del texto) | `\textcite` → texto sin la cita + `\nocite`: Schumpeter (1954) en la introducción («los 4 motivos que da Schumpeter») y en el «vicio ricardiano» («Schumpeter llamó…», sin año); Landreth y Colander (2006) en el anexo de la economía preclásica. Blaug (1997), Landreth y Colander y el Banco de Inglaterra solo quedan en líneas `\fuente{…}`. Las obras originales (Smith, Ricardo, Malthus, Marx, Mill, Sraffa…) se mantienen. Los `\textcite` de las líneas `\fuente{…}` bajo gráficos y tablas se mantienen (no interrumpen la lectura, igual que en el resto del temario). |

## Dudas abiertas

Ninguna bloquea el tema: todas se han resuelto con la opción recomendada.

- **A02-01 (D1, Say)** — *resuelta por Víctor (9/11/2026)*: Say se queda con poco desarrollo, sin subapartados y con caja gris. II.2 propio de 1′ entre Smith y Ricardo (decisión del coordinador); los títulos de 2.º nivel del Word siguen en su orden, solo cambia su número.
- **A02-02 (D2, III.3)**: «Valoración y legado de Marx» en lugar de «“Economía positiva” y “Economía normativa”» (vacío en el Word).
- **A02-03 (D3, enganche)** — *resuelta por Víctor (9/11/2026)*: se mantiene, con «inauguró». la feria, con Tréveris (2018) y Glasgow (2023). La altura de la estatua va con el pedestal (5,5 m), que es lo que dan las fuentes de 2018; no la de 4,4 m.
- **A02-04 (D4, Schumpeter)**: variante «escuela con líder» (Smith), con la cita del prefacio de Ricardo en el objeto.
- **A02-05 (D7, línea del tiempo)**: una sola figura con 2 paneles (cronología arriba, influencias abajo), hecha por el editor a partir de los 2 TikZ de contenido. Si Víctor aprueba la línea común del bloque (CC8 del 3.A.7), el panel (a) sería su tramo 1750-1875.
- **A02-06 (D8)**: las similitudes y diferencias de Marx con los clásicos salen de I.3 y van a III.1, en `tab:clasicos-marx` (parte 2).
- **A02-07 (C1 frente a K29)**: reparto y pegatinas de coherencia; las de contenido no se usan.
- **A02-08 (las 4 leyes)**: coherencia (K33) proponía población, rendimientos decrecientes, fondo de salarios y Say; contenido (C9), Tebar y Cabado, con el flujo-especie en lugar del fondo de salarios. Se usan las de contenido y el fondo de salarios va en una viñeta aparte, para no perder ninguna.
- **A02-09 (teoría monetaria)**: entera en I.3 (C11), con la postura de cada autor en II en una frase; así no se cuenta 4 veces.
- **A02-10 (citas de hetwebsite)**: salen como «The History of Economic Thought Website, 2026a/b/c», largas en el texto. Se podría dar a las entradas un `shortauthor = {HET}`; no lo he hecho para no tocar las claves de otros temas que usan el mismo autor.

- **A02-11 (notación de Marx)**: la de coherencia, con primas ($\mathit{pl}'$, $c/v$, $g'$), no la de contenido ($e$, $k$, $g$), para no chocar con el canon; la de Sweezy ($q=c/(c+v)$) no se usa.
- **A02-12 (Mill y la Ley de Peel)**: se dice que se alinea con la *banking school* (verificador, V88) y que concede a la ley cierto éxito pero cree que agrava las crisis (contenido, C34, libro III, cap. XXIV): son compatibles.
- **A02-13 (fisiocracia)**: sin intervalo de años en el título (contenido proponía 1756-1776; el original, 1750-1780).
- **A02-14 (Malthus y el dinero en `tab:lineas`)**: «---» en lugar de «antibullionista moderado», que no está comprobado.
- **A02-15 (esquemas de reproducción)**: solo las cifras de la reproducción simple en el texto; la tabla de 2 casos de contenido (C40) no se incluye para no alargar III.
- **A02-16 (lecturas)**: la caja «Para ampliar» va al final del anexo de test, para que la idea final sea la última frase del cuerpo.
- **A02-17 (Smith y el test de 2014)**: el tribunal dio por buena «el valor se basa en el trabajo que incorporan los bienes»; en la tabla del test se matiza (solo en el estado primitivo; la medida es el trabajo comandado).
- **A02-18 (control de calidad, 4/11/2026: iniciales en el HTML y el Word)**: cuando hay 2 autores con el mismo apellido (John Stuart y James Mill; John Maynard y John Neville Keynes), el HTML y el Word añaden las iniciales a la cita («John Stuart J. S. Mill (1848)», «James J. Mill (1808)», «John Neville J. N. Keynes (1891)», «J. M. Keynes (1936)»), y el PDF no. En este tema el editor lo evita en el texto, pero el origen está en la conversión con pandoc y citeproc, que añade el nombre para distinguir a los autores; al 3.A.1 también le pasa. Hay que decidir si se desactiva para todos los temas (`disambiguate-add-givenname`/`givenname-disambiguation-rule` en el CSL) o se acepta.
- **A02-19 (control de calidad, 4/11/2026: evidencia de Malthus)**: según el gráfico `malthus-datos`, la producción agraria por habitante de Inglaterra cae de 125 (años 1770) a 88 (años 1860). El texto lo presentaba solo como una refutación, y la pregunta oficial de 2016 (enero) da por falsa que la evolución del siglo XIX «confirmó» a Malthus. Se pide al editor que matice el texto (la importación de grano cubre la diferencia y el salario real sube). Víctor tiene que decidir si añade en el gráfico una serie de importaciones o de salario real.

- **A02-20 (anécdotas de Smith frente a otras biografías)**: donde Daniel y las biografías anglosajonas no coinciden (3 o 4 años; lo devuelven los vagabundos o lo recupera su tío; Franklin en París), la caja da las 2 versiones y atribuye la de Daniel. Opción aplicada: las 2; si Víctor prefiere solo la de Daniel, basta borrar «según otras biografías…».
- **A02-21 (Malthus, «el avaro que cierra bajo llave»)**: no lo he encontrado en los *Principles* de Malthus ni en las fuentes del tema, y su argumento no es el atesoramiento sino el exceso de ahorro invertido. Opción aplicada: fuera, con la corrección explicada. Si Víctor tiene la fuente (¿Landreth y Colander?), se puede recuperar en la caja.
- **A02-22 (dónde va «De dónde sale la tesis» de Malthus)**: Víctor lo quiere en «Recomendaciones de política económica», como en el antiguo, aunque no es una recomendación. Opción aplicada: primera viñeta de ese bloque, como introducción de las recomendaciones («de ella salen sus recomendaciones»).
- **A02-23 (Say)**: Víctor permite integrarlo en Smith. Opción aplicada: se mantiene II.2 propio (1′), en viñetas y con caja gris, para no tocar el esquema ni el reparto; la «ley de Say antes de Say» de Smith remite a él. Integrarlo en II.1 cambiaría la numeración de II.
- **A02-24 (rótulos de los modelos dentro de las líneas)**: como el nombre del modelo ocupa el `\paragraph`, a)-e) van en `\subparagraph` y i)-iii) como rótulos en negrita y cursiva (no hay un nivel de título más bajo). Es lo que admite `verificar-tema.py` (como el 3.A.9).

## Enlaces del original (9/11/2026)

Revisados los enlaces del tema original que no estaban en la versión revisada (CRITERIOS § 4).

- **Restaurados**:
  - Nota al pie de Hesíodo (anexo de los comienzos): el mito de la caja de Pandora (TED-Ed), que era la nota 57 del original.
  - Nota al pie de Sancho de Moncada (anexo de precursores): su entrada de Wikipedia (nota 61 del original).
  - Caja de la ley de Say: la entrada «Ley de Say» de Wikipedia (estaba en la nota de James Mill).
  - Caja del *Ensayo* de Malthus: vídeo de VisualEconomik sobre el colapso demográfico (estaba en «Contexto, método y obra» de Malthus).
  - Caja «Para ampliar» del final: vídeos «Classical Economics» (Rethinking Economics Norge) y «David Ricardo in One Minute» (este último enlazado en el original desde el nombre de Ricardo).
- **Ya cubiertos por otra vía**: la *Riqueza de las naciones* (PDF de ibiblio.org) y los *Principles* de Ricardo (Google Books) ya llevan enlace al texto completo en Project Gutenberg (`Smith1776Wealth`, `Ricardo1817Principles`).
- **No restaurados**: el vídeo de Juan Ramón Rallo sobre el valor trabajo (youtu.be/F0eJgIcDNo4) es hoy privado y no se ha encontrado otra copia; la fuente de Policonomics de la imagen de Malthus devuelve error 500 en todo el sitio (9/11/2026) y la imagen se ha sustituido por un gráfico propio.

## Instrucciones para el vídeo

- **Enganche e idea final**: el refrán «cada uno habla de la feria según le va en ella», arriba a la izquierda de la pizarra, con la estatua de Tréveris (2018) y el tricentenario de Smith (2023) como apoyo (fotos de dominio público si se encuentran; si no, solo texto). La pregunta: ¿de dónde sale la riqueza de una nación y quién se la queda? La idea final (parte 2) la responde con el mismo refrán: Smith y Ricardo hablan desde el capitalista que ahorra, Malthus desde el terrateniente y Marx desde el obrero.
- **Introducción**: sin pizarra (`modo: guion`), con sus 5 bloques nombrados.
- **Apartado I** (5′30″):
  - I.1, de palabra: líder, seguidores y cuerpo doctrinal; en la pizarra, como mucho, «Smith → Ricardo → Mill» en una línea.
  - I.2: la figura `clasicos-tiempo` se construye por partes: primero el eje con los años y las 3 obras grandes (1776, 1817, 1848) y los 2 críticos (Malthus 1798, Marx 1867); después, los sucesos (1789, 1797-1821, 1815-1846, 1844) y, si da tiempo, el árbol de influencias del panel (b) como **apoyo** (no se dibuja). La caja de contexto, como apoyo o fuera.
  - I.3: en la pizarra solo la columna de las 4 leyes (rendimientos decrecientes, población, flujo-especie, Say), que se borra al acabar I. La teoría monetaria, de palabra y en una frase por debate (bullionistas, *currency* frente a *banking*); el detalle es de profundización.
  - I.4: de palabra; en apoyo, «Senior 1836: ciencia / arte → J. N. Keynes 1891: positiva / normativa / arte».
- **Funciones clave**: las 2 del tema (el reparto de Ricardo y el valor de Marx) llegan en la parte 2; se escriben en la columna derecha y se conservan hasta la conclusión (`conservar:`).
- **Pegatinas** (una vez, junto a su concepto): «aprendiz de mucho, maestro de nada» (II.1), «quien tiene tierra tiene guerra» (II.3), «donde comen dos, comen tres» (II.4), «trabajar para el obispo» y «cría cuervos y te sacarán los ojos» (III.2). Ninguna en el apartado I.
- **Parte 2**:
  - II.1: `smith-riqueza` en la pizarra (5 cajas y flechas, de la riqueza a sus causas, con la flecha de la acumulación al mercado); la tabla 2×2 de `tab:ventaja-absoluta`, que se queda para Ricardo, con la pegatina «aprendiz de mucho, maestro de nada»; `alfileres` como apoyo, con las cifras (18 operaciones, 10 operarios, 48.000 alfileres).
  - II.2: de palabra; en la pizarra, como mucho, $\sum_k p_k z_k(\vect p)\equiv0$ y «identidad / igualdad».
  - II.3: `ricardo-distribucion` por capas (ejes, $\mathrm{PMe}_L$, $\mathrm{PMg}_L$, $\bar w$, las 3 áreas en $L_0$, $L^*$) y, en la columna derecha, la función clave `eq:reparto-ricardo`, que se conserva hasta la conclusión; `tab:pano-vino` sobre la misma tabla 2×2 de `tab:ventaja-absoluta`, que se dibuja en II.1 (se tacha el 110, se escribe el 90 y se rodea la ventaja comparativa de cada país), con la desigualdad `eq:ventaja-comparativa`; pegatina «quien tiene tierra tiene guerra».
  - II.4: `malthus-poblacion` (2 curvas) con la pegatina «donde comen dos, comen tres»; `malthus-datos` como apoyo.
  - II.5: de palabra.
  - III: `materialismo-historico` (base y superestructura) y, borrado este, la barra de `jornada-laboral` (10 h = 5 + 5) con «trabajar para el obispo»; la función clave `eq:valor-marx` en la columna derecha, junto a la de Ricardo, y `eq:tasas-marx` debajo; la tabla de la transformación, como apoyo; pegatina «cría cuervos y te sacarán los ojos» con la frase de los sepultureros.
  - Conclusión: sin pizarra; se señalan las 2 funciones clave (el beneficio residual de Ricardo frente a la plusvalía de Marx) y se cierra con el refrán de la feria y la respuesta a la pregunta del enganche.
- Pizarra: izquierda refrán y pegatinas; centro, el gráfico de cada bloque (se borra al pasar al siguiente); la tabla 2×2 de Smith se reutiliza para Ricardo tachando el 110 y escribiendo el 90; derecha, las 2 funciones clave hasta el final. (11/11/2026)

## Correcciones del control de calidad (4/11/2026)

- Ley de Say: la advertencia «no debe confundirse con la ley de Walras… y es la que Keynes critica» va tras `eq:say`, referida a la formulación de Lange, como la nota de la l. 342 del 3.A.21; la viñeta de Becker y Baumol queda solo con identidad frente a igualdad.
- Malthus, evidencia: las 2 series crecen de forma geométrica, pero la producción agraria interior por habitante cae de 125 (años 70 del XVIII) a 93 (1850); la cubren las importaciones de grano y la industria, y el salario real sube sin frenos maltusianos (coherente con la pregunta oficial de enero de 2016). Pie del gráfico: 1700-1869.
- I.2: Malthus, clásico en parte; Marx, crítico desde dentro del aparato clásico (coherente con I.1 y III.1); «unos 70 años (casi 100 hasta la revolución marginalista)».
- Marx: vida en orden (París 1843, Engels 1844, expulsiones de París 1845, Bruselas 1848 y Colonia 1849, Londres desde 1849); la numeración inglesa de *El capital* suma 2 desde el cap. 5.
- Sin nombre de pila delante de `\textcite` (las iniciales salían duplicadas en la web y en Word): Chang, List, Azpilcueta, Bodin, Mill, J. N. Keynes, James Mill, Barro, Robinson, Mercado, Molina, Moncada y Simon.
- Mill (1836): «publicado en 1836 y recogido en 1844».
- `BoE2017Millennium`: nota «Hojas A2 (población) y A3 (producción agraria)».
- `tab:lineas`: «Los 3 deberes…», «Los 3 casos…» y columnas más estrechas (13,2 cm en total) para el Word.
- Peel deroga las Leyes de Granos «en plena hambruna irlandesa (1845-1849)»; las preguntas de `tab:test`, por fecha.

## Revisión transversal (13/11/2026)

- **Premios Nobel** (nota al pie con año y motivo oficial en la primera mención, y su `\nocite`; entradas copiadas al `.bib`): Gary Becker (1992, en la identidad e igualdad de Say), George Stigler (1982, el valor trabajo «del 93 %»), Robert Solow (1987, estado estacionario), James Buchanan (1986, añadido a la nota de la equivalencia ricardiana, porque ya estaba dentro de otra nota), Michael Kremer (2019, con Banerjee y Duflo; «más población, más ideas») y Paul Samuelson (1970, crítica de la transformación). Ninguno de los premios recientes tiene aquí su tema de referencia (Mokyr, 2025, va en el 3.A.44).
- **4.º ejercicio**: 2 remisiones nuevas: las 4 máximas de Smith como base de los principios impositivos \vertema{4.B.7} y la transición demográfica que Malthus no previó \vertema{4.A.2}.
- **Refranes y dichos** (el temario antiguo no traía ninguno): se conserva el refrán del enganche («cada uno habla de la feria…»), «donde comen dos, comen tres» (Malthus, al revés), «trabajar para el obispo» (plustrabajo) y «cría cuervos…» (la burguesía cría a sus sepultureros). «Aprendiz de mucho, maestro de nada» se queda, pero bien integrado: el texto decía «es lo contrario del refrán», cuando la división del trabajo le da la razón; ahora es el operario que hiciera las 18 operaciones. **Fuera** «quien tiene tierra tiene guerra» (Ricardo): el refrán habla de los problemas del propietario, y en Ricardo el terrateniente es quien gana, así que podía confundir. Mismos cambios en la ficha de repaso.
- Compilados el PDF y la ficha (4 páginas); `verificar-tema.py` solo marca los ficheros publicados anteriores a la fuente (se publican aparte).
