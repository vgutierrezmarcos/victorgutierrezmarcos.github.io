# Revisión del 3.A.1. Objeto y métodos de la ciencia económica. Cuestiones y debates actuales, con especial referencia a la economía conductual

Revisión autónoma del 4/11/2026 (Víctor fuera). Integración en 2 partes: la **parte 1** escribió la introducción y los bloques I (objeto) y II (métodos); la **parte 2**, el bloque III, la conclusión y los 5 anexos. Las dudas se resuelven con la opción recomendada y se anotan como **A01-NN** (sección «Dudas abiertas»).

## Resumen

1. El tema pasa de 2 bloques a 3 apartados con los títulos de 2.º nivel del original (K2): I. Objeto (6′), II. Métodos (9′), III. Debates actuales y economía conductual (11′30″); introducción de 2′30″ con el enganche «A toro pasado, todos somos Manolete» (la reina en la LSE) y conclusión de 1′.
2. Todo redactado de nuevo, sin los pasajes traducidos de Landreth y Colander, con las correcciones de datos: Robbins (págs. 15 y 132), la «ciencia moral» de Keynes (1938), Friedman 1953, *Methodenstreit* como el 3.A.3, praxeología de Mises, Duhem, Mannheim, Lakatos 1970/1978, Card y Krueger 1994, ultimátum de Güth *et al.* (1982).
3. Huecos rellenados: tabla de escuelas según Kuhn y Lakatos, el otro lado de las matemáticas, la econometría, las 7 cualidades de un modelo, individualismo y pluralismo, y todo el III (credibilidad, EGDE tras 2008, HANK, complejidad, aprendizaje automático, replicación).
4. El 3.A.1 es el tema de referencia del descuento cuasihiperbólico: `\funcionclave` `eq:beta-delta`, D105, bloques a)-e), ejemplo numérico y evidencia; *nudges* con la inscripción automática británica (55 % → 90 %), perspectivas en resumen, experimentos y anexos A-D y de test.
5. 7 gráficos (5 nuevos de tema-tikz, 2 copiados del 3.A.29 y del 3.A.10), 2 tablas con color, `.bib` de 219 entradas, todas citadas; compila sin referencias ni citas indefinidas.

## Errores corregidos

Bloques I y II (parte 1) y III, conclusión y anexos (parte 2).

| Dónde (original) | Decía | Dice ahora |
|---|---|---|
| Contextualización, l. 65 | *Oikonomikos* «alrededor del año 400 a. C.» | «en el siglo IV a. C.» (V1) |
| I.1, l. 122 | Steuart, primera aparición de «economía política» | Montchrestien (1615); Steuart (1767), primer tratado en inglés (V4) |
| I.1, l. 122 | Smith y Steuart, «máximo bienestar… ingresos públicos», sin cita | Los 2 objetos de Smith (libro IV, introducción), con la cita (V5) |
| I.1, l. 126-132 | Mill, paráfrasis sin fuente | Definición de Mill (1836), ensayo V (V6) |
| I.1, l. 134 | Marshall «introduce» el término *economics*; «nivel máximo de bienestar»; «retorna al debe ser» | Marshall lo **populariza**; definición literal («asuntos ordinarios de la vida», «requisitos materiales del bienestar») (V7) |
| I.1, l. 142 | «Robbins primero y posteriormente Samuelson»; «recursos escasos a fines alternativos» | Solo Robbins (1932, pág. 15): «medios escasos que tienen **usos alternativos**»; Samuelson la lleva a los manuales (V8) |
| I.1, l. 164 | «tercera ley de Gossen (1854)» | Fuera; la escasez se explica sin autor (V9) |
| I.1, l. 168 | Lipsey, «aprovechamiento óptimo de los recursos» | Fuera: no se ha encontrado (V10) |
| I.1, l. 190 | Viner, «economía es lo que hacen los economistas» | Atribución sin fuente escrita: la recoge Boulding (1941, pág. 1) sin nombrarlo (V3; Backhouse y Medema, 2009) |
| Nota 7 | Levitt, «discípulo de Becker» | Colega de Becker en Chicago (V75) |
| Nota 9 | Tirole, «poder y las regulaciones del mercado» | «poder de mercado y de la regulación» (V14) |
| I.2, l. 228 | Friedman, *The Methodology of Positive Economics* (1966) | 1953 (V16) |
| Nota 11 | Myrdal y Hayek, «independencia de los fenómenos» | «interdependencia» (V17) |
| Nota 12 | Friedman, «triunfos… estabilización política» | «logros… política de estabilización» (V18) |
| I.2, l. 232 | Thaler, *Towards a positive theory…*, sin año | *Toward…*, 1980 (V19) |
| I.2, l. 240 | Robbins, «economics deals with facts; ethics with valuations» | Literal: «hechos comprobables… valoraciones y obligaciones» (1932, pág. 132) (V20) |
| I.2, l. 242 | Atkinson: «economics is essentially a moral science» | La frase es de Keynes (carta a Harrod, 4/7/1938); Atkinson (2009) la toma como título. Va en II.1 (V21) |
| I.2, l. 246 | Arrow buscaba un sistema alternativo al mercado | Fuera: sin fuente (V22) |
| I.3, notas 13-14 | Cita de «de Vroey, 2018» vía apuntes de 2023; Athreya (2013) en inglés | Fuera; la idea con De Vroey (2016) en el cuerpo (V23, C9) |
| I.3, l. 298 | «[ver temas 3.B.15-3.B.16]» (NOEM) | `\vertema{3.B.14}` (K16) |
| I.3, l. 278 | «[ver temas 3.B.23-3.B.25]» (Markowitz) | `\vertema{3.B.23}` (K16) |
| II, l. 310 | Platón, «el camino para alcanzar el saber» | Fuera; solo la etimología (V25) |
| II.1, l. 320 | 3 requisitos «siguiendo a Raj Chetty», el 3.º «no entrar en juicios de valor» | Chetty (2013) solo defiende que la economía contrasta hipótesis; los requisitos, sin Chetty, y el 3.º es «distinguir lo positivo de lo normativo» (V26, K7.1) |
| Nota 15 | Cita de Gell-Mann (de segunda mano) | Fuera la atribución; la idea del electrón que no piensa, sin comillas (V27) |
| II.2, nota 16 | Descartes, método en 2 fases («heurística» y «dialéctica») | Fuera: no es de Descartes (C14) |
| II.2, l. 482 | Kant: «es imposible demostrar nada que no haya sido previamente enunciado» | Fuera: sin fuente (C14) |
| II.2, l. 410 | Axiomas como «verdades evidentes»; teoremas «verdades evidentes» | Axiomas como puntos de partida aceptados (C14) |
| II.2, l. 426 | Mill introduce el concepto de *homo economicus* | La figura es de Mill (1836); el nombre lo pusieron sus críticos (Persky, 1995) (V30) |
| II.2, l. 462 | Mill, representante de la concepción empírica | Empirista en lógica (1843), deductivo *a priori* para la economía política (C14) |
| II.2, l. 488-498 | *Methodenstreit*: historicismo (Schmoller, Hildebrand, List) frente a «Menger y Walras» | Menger (1883) frente a Schmoller (1883) y réplica de Menger (1884), con el texto del 3.A.3; Walras fuera de la disputa (V32) |
| Nota 18 | Cournot, profesor de Auguste Walras | «compañero y amigo» de Auguste Walras, como el 3.A.3 (V33) |
| Nota 19 | «Hutchinson», sin año | Hutchison (1938); respuesta de Machlup (1955) (V34) |
| II.2, l. 552 | «crítica de Durhem» | Tesis de Duhem-Quine (Duhem, 1906; Quine, 1951) (V37) |
| II.2, l. 528 | Friedman, «translación a la economía del criterio de Popper» | Afín a Popper pero instrumentalista, con las palabras del 3.A.5 (K11) |
| II.2, l. 596 y 700 | Lakatos «(1978)», «(1970s)», *Proofs and Refutations* (1970) | Lakatos (1970), recopilación de 1978; *Proofs*, 1976 (V41) |
| II.2, l. 704 | La heurística positiva dentro del núcleo | Negativa: no tocar el núcleo; positiva: cómo desarrollar el cinturón (K7.3) |
| II.2, l. 752-756 | Numeración rota «1., 9.» | Corregida |
| II.2, l. 766 | «Manheim» | Mannheim (1929) (V44) |
| II.3, l. 830 | Praxeología de Menger | De Mises (1949) (V45) |
| II.3, l. 846 | Harsanyi «[ver tema 3.A.13]» | `\vertema{3.A.14}` (K16) |
| II.3, l. 826-830 | Tinbergen y Klein sin años | Tinbergen (1939), Klein y Goldberger (1955) (V47) |
| II.3, l. 856-870 | Anécdota de Friedman y las condiciones de segundo orden; respuesta de «Heymann» | Fuera: sin fuente (V48) |
| II.3, nota 33 | *Mathiness* de Romer, sin año | Romer (2015) (V48) |
| II.3, l. 868 | Samuelson, sin año | «Giro F», Samuelson (1963) (V49) |
| II.3, nota 28 | Brunner apoya a Friedman contra Walras | Fuera: contradice al 3.A.5 (Brunner y Meltzer, tradición walrasiana) (C24) |
| II.3, nota 29 | Molina 1592; Azpilcueta 13 años antes que Bodin | Molina 1597; 12 años; citas literales fuera (V74) |
| Nota 22 | Los marginalistas y Newton «100 años antes» | Fuera (C28) |
| III, l. 880 | «El mayor exponente de la racionalidad ha sido la HER» con notas 34-35 (≈ 1.000 palabras, notación $\dot p^e_t$, Ω*) | Una frase con las palabras del 3.A.6 y el anexo B breve con la notación canónica (C49, K7.6) |
| III, l. 888-896 | Simon: los 2 límites son «conocimiento parcial» y «objetivos individuales… de la organización»; «profesor de psicología» | Conocimiento parcial y capacidad de cálculo limitada; busca lo satisfactorio, como el 3.A.15 (C36) |
| Nota 37 | Motivación del Nobel de 2002 mezclada (Kahneman y Smith) | 2 motivaciones; Tversky murió en 1996; Kahneman, en 2024 (V51, V63) |
| III, l. 906 y 932 | Descuento hiperbólico «[ver tema 3.A.29]», «de Thaler» | Desarrollado aquí (tema de referencia): Strotz (1955), Thaler (1981), Loewenstein y Prelec (1992), Laibson (1997) (C38, P47) |
| III, l. 940-948 | $\mathrm V(c)=\sum\beta^t u(c_t)$ y $(1+\alpha t)^{-\gamma/\alpha}$ | `eq:beta-delta` con δ exponencial y β sesgo por el presente (D105, con aviso) y $D(t)=(1+at)^{-\gamma/a}$ (K5) |
| Nota 39 | Frase en inglés atribuida a «Strotz, 1956 REStud» | Paráfrasis sin comillas, Strotz (1955) (V56) |
| Imagen 3 y nota 40 | Fuente OCW del MIT; Wikipedia y apuntes | Gráfico del 3.A.29 con la fuente de Angeletos *et al.* (2001) (V57) |
| III, l. 928 | Ultimátum «de Thaler»; «[ver tema 3.A.24]» | Güth, Schmittberger y Schwarze (1982); `\vertema{3.A.14}` para el juego y `\vertema{3.A.24}` para la equidad (V55, K16) |
| III, l. 1014 | «Vacas locas en 1996, OGM en 1997» | Fuera: sin fuente (V60) |
| III, l. 1022 | Prima de las acciones «más de 6 puntos» sin referencia | Más de 6 puntos frente a las letras y unos 5 frente a los bonos (Damodaran, 2026); Mehra y Prescott (1985); Benartzi y Thaler (1995) (V61) |
| III, l. 1016-1028 | Finanzas conductuales con giros de un texto ajeno no localizado y la cita de Maquiavelo | Reescrito: 2 viñetas en III.1 y anexo C, sin la cita (P38, V62) |
| III, l. 1050 y nota 41 | «Kahneman y Tversky (2002)», Smith y Plott | Fuera (C46, V63) |
| III, l. 1062 | Preferencias sociales «Bolton, 1991» | Fehr y Schmidt (1999) y Bolton y Ockenfels (2000) (V64) |
| III, l. 1064-1095 | Card y Krueger «1992», «Allan», sube «ligeramente» | 1994; Alan; de 4,25 a 5,05 dólares (un 19 %) (V65) |
| Nota 42 | Nobel 2021 solo para Card | Card, y Angrist e Imbens, con las 2 motivaciones; Krueger murió en 2019 (V66) |
| RCT, l. 1161 | Intervenciones muy particulares «a nivel macroeconómico» | Microeconómico (anexo D) |
| RCT, l. 1110-1118 y nota 44 | 2 citas de Deaton («matar a una avispa», «A finding from a study in Kenya…») | Sin comillas: Deaton (2010) y Deaton y Cartwright (2018) (V68) |
| III, l. 686 | Leijonhufvud (1990); «Ries» | Leijonhufvud (1993, 2006); Reis (2018) (V40) |
| Conclusión, l. 1192 | Cita de Walsh (pág. xviii) | Fuera: no localizada (V70) |
| Bibliografía | Landreth y Colander (2010); temas de preparadores | 2006 (V71); los temas de preparadores fuera |
| Enlace de test | quia.com | Enlace único al simulador |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo) | «Fuente: …» del ciclo de Kuhn | Gráfico nuevo en TikZ (`kuhn`), «elaboración propia a partir de Kuhn (1962)» |
| P2 (amarillo) | «Fuente: …» del programa de Lakatos | Gráfico nuevo en TikZ (`lakatos`), «elaboración propia a partir de Lakatos (1970)» |
| P3-P4 (amarillo) | «Por otro lado, …» vacío y nota «No pone nada en ningún lado…» | Escrito el otro lado del debate de las matemáticas: Leontief (1971), Krugman (2009), *mathiness* de Romer (2015), lo que no se formaliza; término medio de Marshall (carta a Bowley) |
| P5-P6 (amarillo) | Viñeta vacía y «[seguir copiando de la página 11… desde NMC hasta Piketty]» | Econometría como método, redactada de nuevo: Tinbergen, Keynes (1939), Haavelmo, Cowles, Koopmans, Granger, crítica de Lucas, VAR, calibración; la revolución de la credibilidad y Piketty pasan al III (parte 2) |
| P10 (amarillo) | «IMPORTANTE, muy cortito… puede quedar bien» (Gabaix y Laibson) | Las 7 propiedades, desarrolladas en II.3 |
| P11 | Notas al opositor del cambio de temario y captura | Fuera; la propuesta del Ministerio guía los epígrafes (grandes debates en I.3, econometría en II.3) |
| P12 | Nota «a modo casi de comodín» y títulos vacíos de otros debates | Fuera la nota; escritos individualismo y holismo, monismo y pluralismo |
| P13-P18 | Comentarios internos (preparadores, Zapico, Salazar, valoraciones) | No se publican; los pasajes con giros de traducción de Landreth y Colander, reescritos (positivismo, Popper, Kuhn, Feyerabend, retórico y sociológico, 4 mecanismos de asignación) |
| P15 | «Aquí quedaría bien… las distintas escuelas en términos de Kuhn y Lakatos» | Tabla `tab:escuelas` en el cuerpo (II.2.4), redactada sin el tema del preparador; las aplicaciones en detalle, al anexo A (parte 2) |
| P41 (cajas) | 7 enlaces | Shiller (2013) y Chetty (2013) en una caja de II.1, como citas; Wikipedia «hombros de gigantes» fuera; los 2 vídeos de YouTube y el de Ha-Joon Chang, fuera (no son fuentes; funcionan, se pueden recuperar); la ruta local de Gabaix y Laibson, sustituida por la cita (Harvard DASH en el `.bib`) |
| P7-P9 (amarillo, RCT) | «Imaginamos población: todos los colegios en Kenia…» | Redactado como validez externa (Allcott, 2015; Deaton y Cartwright, 2018) en III.2 y en el anexo D |
| P16-P17 (comentarios) | «Coordinar…», stringfixer.com, Wikipedia | No se publican; fuentes académicas del 3.A.29 |
| P22-P23 | Imagen 3 (OCW del MIT) y pie roto | Gráfico `descuento` copiado del 3.A.29, con su pie |
| P38 | Texto de finanzas conductuales de fuente ajena | Reescrito (III.1 y anexo C) con las claves del 3.A.10 |
| P40 | «Anexo 1:» vacío, quia.com y «Preguntas de otros exámenes» | Anexo de test con el enlace al simulador y las 9 preguntas del tribunal (las 12 del original, con las repetidas juntas), con el apartado donde se contesta cada una (la de Romer, con la cita en vez de la ruta local) |
| P41 (resto de cajas) | *The Economist* (2019) | Caja «Para leer más» en III.2 con `Economist2019Nobel` |


## Datos actualizados

Es un tema de metodología: lo que cambia son fechas, obras, atribuciones, citas literales y motivaciones de los Nobel. Fuente y comprobación de cada fila en `_trabajo/propuestas-datos.md` (consultas del 4/11/2026).

| Dato | Anterior | Nuevo | Fuente | URL | Consulta | 2.ª comprobación |
|---|---|---|---|---|---|---|
| Premio de Economía | Sin fecha | Desde 1969 (creado en 1968) | nobelprize.org (V2) | https://www.nobelprize.org/prizes/economic-sciences/ | 4/11/2026 | Wikipedia |
| Becker, Nobel | 1992 | 1992 (motivación literal); conferencia «The Economic Way of Looking at Life» (*JPE*, 1993) | nobelprize.org (V11) | https://www.nobelprize.org/prizes/economic-sciences/1992/summary/ | 4/11/2026 | Crossref |
| Robbins (1932) | Sin página | Págs. 15 y 132 de la 1.ª ed. | mises.org (V8, V20) | https://cdn.mises.org/Essay%20on%20the%20Nature%20and%20Significance%20of%20Economic%20Science_2.pdf | 4/11/2026 | Backhouse y Medema (2009); ORA |
| Keynes a Harrod | — | 4/7/1938, *Collected Writings* XIV | V21 | https://economicsociology.org/2018/04/03/what-is-economics-read-keynes-definition/ | 4/11/2026 | 2 fuentes secundarias |
| Vicio ricardiano | Sin página | Schumpeter (1954, pág. 473) | V29 | — (libro) | 4/11/2026 | Blancas (2012) |
| Popper | 1934 | *Logik der Forschung* (1934, con fecha de 1935) | V36 | https://openlibrary.org/search?q=Logik+der+Forschung | 4/11/2026 | Open Library |
| Nobel 1994 y 2005 | Motivaciones traducidas | Motivaciones literales | V46 | https://www.nobelprize.org/prizes/economic-sciences/ | 4/11/2026 | nobelprize.org |
| Inscripción automática en el Reino Unido | — | 55 % (2012) → 90 % (2025) de los asalariados con derecho ahorran en un plan de empresa | DWP (2017, 2026) | https://www.gov.uk/government/statistics/workplace-pension-participation-and-savings-trends-2009-to-2025/workplace-pension-participation-and-savings-trends-of-employees-2009-to-2025 | 4/11/2026 | 90 %: gov.uk de nuevo (4/11/2026); 55 %: informe de 2017 (fase de contenido) |
| Prima de las acciones | «más de 6 puntos» | Más de 6 frente a las letras, unos 5 frente a los bonos (6,7 y 5,5, 1928-2025) | Damodaran (2026) (V61) | https://pages.stern.nyu.edu/~adamodar/New_Home_Page/datafile/histretSP.html | 4/11/2026 | 3.A.10 |
| Card y Krueger | 1992 | 1994; 4,25 → 5,05 $ (+19 %), 1/4/1992 | V65 | https://www.jstor.org/stable/2118030 | 4/11/2026 | *AER* 84(4) |
| Replicación | — | Psicología 36 % de 100; economía experimental 61 % de 18 (efecto, 66 %); macro, un tercio reproducible | V77 | https://doi.org/10.1126/science.aaf0918 | 4/11/2026 | Resúmenes de los artículos |
| Metodología de las revistas | — | Teoría pura 51 % (1963) → 19 % (2011); datos propios 9 % → 34 % | Hamermesh (2013) (V78) | https://www.nber.org/system/files/working_papers/w18635/w18635.pdf | 4/11/2026 | Parcial (Angrist *et al.*, 2017, confirma la dirección) |
| Gimnasio, compromiso, SMarT, *nudge units* | — | > 70 $/mes, 4,3 visitas, > 17 $ por visita; +81 puntos (Ashraf *et al.*); 3,5 % → 13,6 % en 40 meses; 1,4 frente a 8,7 puntos | C38, C42, C44 | https://doi.org/10.1257/aer.96.3.694 (y los DOI del `.bib`) | 4/11/2026 | Resúmenes de los artículos |
| Ultimátum y dictador | — | 40 %, 16 %, 28 % | 3.A.24 | — (claves del 3.A.24) | 4/11/2026 | Oosterbeek *et al.* (2004), Engel (2011) |

## Contenido añadido

- **Introducción**: enganche de la reina en la LSE (Besley y Hennessy, 2009) con el refrán; relevancia con los Nobel de 2002, 2017, 2019 y 2021 y la viñeta común de los 4 motivos de Schumpeter (idéntica a la del 3.A.3); contextualización con Montchrestien y Steuart; problemática y estructura de K3.
- **I**: definición de objeto y método y la frase de Schumpeter común al bloque (K21); los 4 mecanismos de asignación redactados de nuevo, con el cálculo socialista en nota (Mises, Lange, Hayek); Becker (1976); Viner con Boulding; tabla `tab:positiva-normativa` (J. N. Keynes, 1891; Colander, 1992) con el ejemplo del salario mínimo; Weber y la *Werturteilsstreit* en nota; imperialismo económico (Lazear, 2000; K8); grandes debates que atraviesan las ramas (K9); caja de campos con su tema.
- **II**: Chetty (2013) y Shiller (2013); Keynes y Atkinson (ciencia moral); Hume; el pollo de Russell (1912); preferencia revelada (Samuelson, 1938); método de Marx; Machlup (1955); Weber y los tipos ideales; positivismo lógico; Popper con Duhem-Quine y las estratagemas inmunizadoras; Kuhn con inconmensurabilidad y la frase de Planck (que cita el propio Kuhn) y Azoulay *et al.* (2019); Lakatos con la NMC del 3.A.6; Latsis (1976); McCloskey (1983); Schumpeter (1949), ciencia e ideología; tabla `tab:escuelas`; matemáticas y teoría de juegos; econometría (Granger, 1969, bien planteada como precedencia predictiva); cualidades de un modelo; individualismo y holismo (Kirman, 1992); pluralismo (Caldwell, 1982; Rodrik, 2015).
- **Gráficos** (`_trabajo/graficos-pedidos.json`): `metodologia-tiempo`, `kuhn`, `lakatos` (nuevos, TikZ), `descuento` y `funcion-valor` (copiados del 3.A.29 y del 3.A.10, ya en `graficos/`), `metodologia-revistas` y `replicacion-experimentos` (datos, para la parte 2).

- **III** (parte 2): idea de la economía conductual (elección racional y HER con las palabras del 3.A.6; Simon con las del 3.A.15; Kahneman y Tversky; Thaler; sistemas 1 y 2; clasificación de DellaVigna, 2009); **descuento cuasihiperbólico** con la estructura a)-e) completa, la RMS que muestra la inconsistencia, el ejemplo $\beta=0{,}7$, $\delta=0{,}99$ (76,2 y 108,9), las cifras de Angeletos *et al.* (2001) y la evidencia de DellaVigna y Malmendier (2006), Ashraf, Karlan y Yin (2006) y Duflo, Kremer y Robinson (2011); perspectivas en resumen con `funcion-valor`; preferencias sociales (Fehr y Schmidt; Bolton y Ockenfels); heurísticas, sesgo retrospectivo (Fischhoff, 1975, que enlaza con el refrán), marco y cuentas mentales; paternalismo libertario y empujones (Madrian y Shea, Johnson y Goldstein sin cifras; SMarT; DWP); finanzas conductuales en 2 viñetas; críticas (Fudenberg, List, replicación, DellaVigna y Linos, Gigerenzer, paternalismo). Experimentos: Vernon Smith, ultimátum y dictador, Card y Krueger, RCT con la notación de la ficha `rct` y la frase del 3.B.28. Innovaciones: giro empírico (Hamermesh), credibilidad (Leamer; Angrist y Pischke), EGDE tras 2008 (Romer, Stiglitz, Blanchard, Reis, Galí, Vines y Wills, Blanchard y Summers, Farmer, Leijonhufvud) leído con Kuhn y Lakatos, HANK y microdatos, complejidad y redes, aprendizaje automático y replicación.
- **Conclusión** (K20) con sus 5 bloques; la opinión, con la visión acumulativa (Roncaglia) y el pluralismo (Rodrik), sin repetir los 4 motivos de Schumpeter de la introducción.
- **Anexos**: A, Kuhn y Lakatos aplicados a las escuelas (con la crítica de Lucas, los EGDE y la frase de Prescott del 8/12/2004); B, expectativas (breve, remite al 3.A.5 y al 3.A.6); C, finanzas conductuales (4 enigmas, reescritos); D, ventajas y límites de los RCT; E, test con trampas y las preguntas del tribunal.

### Propuestas aplicadas y rechazadas (parte 1)

- **C (contenido)**: aplicadas C4-C30 salvo: **C1** (estructura) y **C2** (enganche de la inscripción automática británica) sustituidas por K2 y K19, que mandan en estructura y enganche; el dato de la inscripción automática (DWP) puede ir en los *nudges* de la parte 2; **C3** (caja de notación) se aplaza a la primera fórmula del III (nota al pie de K13); **C8**: el individualismo y el holismo van a II.3 (K2), no a I.3; **C17**: Lipsey (1963) fuera (no comprobado; el coordinador lo excluye); **C29** (Prescott) pasa a la parte 2. C12 se aplica dentro de I.3.
- **V (datos)**: aplicadas V1-V49 en lo que toca a I y II (V24 Shapiro-Stiglitz no se usa: el ejemplo sale con C8; V35, V43 sin cambios). V50-V78, en la parte 2.
- **K (coherencia)**: aplicadas K2, K3, K6, K7 (1-4, 6 y 8), K8-K11, K15 (sin la frase de Joan Robinson, reservada), K16-K17 en lo que toca a I y II, K18 (pedidos), K19 (enganche y pegatinas, **sin** «No se puede estar en misa y repicando», del 3.A.28) y K21. K5 y K13-K14, K20, en la parte 2.


### Propuestas aplicadas y rechazadas (parte 2)

- **C**: aplicadas C31-C44 y C46-C72 con estos cambios: la estructura de C31-C44 (4 subapartados en III) se adapta a la de K2 (III.1 conductual, III.2 experimentos, III.3 innovaciones) con sus textos; la etiqueta del β-δ es `eq:beta-delta`, no `eq:cuasihiperbolico`; la descomposición del sesgo de selección (C31) va **de palabra**, no como ecuación (K5: mejor de palabra; la ecuación es la `\funcionclave` del 3.B.28); Gabaix (2011) sin cifra (no comprobada); Ioannidis *et al.* (2017) sin las cifras de C35 (datos no las comprobó); Johnson y Goldstein y Madrian y Shea sin cifras (como pide el coordinador); C45 (la defensa de Thaler) integrada en las críticas con *Misbehaving*, sin comillas; C48: Easterlin en las implicaciones de las perspectivas y Schelling fuera; C51 sustituida por K20 (manda coherencia); C52 y C53 juntas en el anexo de test; C66: la nota de Molina y Azpilcueta se **mantiene** (corregida, 1597 y 12 años) en el equilibrio parcial, como pidió el coordinador.
- **V**: aplicadas V50-V78; V60 (vacas locas) y V62 (Maquiavelo) fuera; V70 (Walsh) fuera; V76 (Libertad González) fuera; V77 y V78, en los 2 gráficos de datos.
- **K**: aplicadas K5 (aviso de notación en nota al pie, λ avisada, RCT con $Y_i(1)$, $Y_i(0)$, $D_i$), K12 (con la clasificación de DellaVigna y el β-δ como subapartado propio con a)-e)), K13 completa, K13 bis, K14 (III.3.2 como `sec:evolucion-revolucion`) y K20 (sin los 4 motivos de Schumpeter, que ya están en la introducción).
## Coherencia

- *Methodenstreit*: primera viñeta y pegatina «Cada loco con su tema» idénticas a las del 3.A.3; Cournot «compañero y amigo» de Auguste Walras, como el 3.A.3.
- Kuhn: la frase del 3.A.3, 3.A.4 y 3.A.5 («un paradigma domina hasta que acumula anomalías…») y Blaug (1972) para la marginalista; la revolución de Lucas con las palabras del 3.A.6 (De Vroey, 2016).
- Popper y Friedman: «afín al falsacionismo de Popper, aunque con un instrumentalismo que Popper no compartía» (Boland, 1979), billar y «giro F», como el anexo del 3.A.5, que es la referencia de la metodología de Friedman.
- Lakatos: la NMC como programa progresivo con las palabras del 3.A.6 (conclusión).
- Lucas (1980): «economía artificial», como la nota del 3.A.6; la crítica de Lucas como «crítica de método», como el 3.A.6.
- Friedman (1949): «máquina para descubrir verdades concretas», como el 3.A.5.
- Schumpeter: la frase de los 3 rasgos de una escuela y la viñeta de los 4 motivos, idénticas a las del 3.A.3 y el 3.A.5.
- Claves: `Samuelson1937` (la del 3.A.29) y `CardKrueger1994` (la de la 1D01) en lugar de `Samuelson1937Note` y `CardKrueger1994Minimum` de `bib-datos.bib`.
- β-δ: la misma fórmula, las mismas palabras del aviso de notación y el mismo gráfico (con su pie) que la nota del 3.A.29 y la del 3.A.33; el 3.A.1 ya no remite el descuento hiperbólico al 3.A.29 (solo el exponencial y Strotz).
- Ultimátum y dictador con las palabras y cifras del 3.A.24 (40 %, 16 %, 28 %) y la cita de Kahneman, Knetsch y Thaler (1986) con su traducción; el juego, con `\vertema{3.A.14}`.
- Simon con las palabras del 3.A.15; la teoría de las perspectivas en resumen, con el gráfico y el pie del 3.A.10; la frase «modelos estructurales… trabajo experimental» del 3.B.28, literal; la frase de Prescott, idéntica a la conclusión del 3.A.6.
- La economía «conductual» (la del título) en todo el tema (CC3); el 3.A.13, el 3.A.26 y el 3.A.29 dicen «del comportamiento».
- 3.A.26 (revisado) menciona el descuento hiperbólico sin `\vertema{3.A.1}` (CC2, opcional, no se toca).
- Contradicciones con otros temas (no se tocan): 3.A.2 (Word) atribuye a Mill el término *homo economicus*; 3.A.10 y 3.A.22 citan `Robbins1935Essay` con un PDF que es la edición de 1932 (ya en `pendientes-coherencia.md`); el resto, en `_trabajo/propuestas-coherencia.md` («Contradicciones»).

## Comentarios de Víctor (9/11/2026)

Aplicados en la fuente (`3A01.tex`, `3A01.bib`, `graficos/mapa-temario.tex`) y en la ficha (`repaso/3A01-repaso.tex`), sin construir el tema.

**Del 3.A.1**

1. *«Las definiciones históricas … numeradas como en la versión antigua, aunque sea agrupando autores como en la nueva … orden coherente … negrita, cursiva y subrayado»*. I.1 rehecho: 8 definiciones numeradas en el orden del tema antiguo (1 Steuart y Smith, 2 Say, Senior, Ricardo y Malthus, 3 Mill, 4 Marshall, 5 Robbins y Samuelson, 6 la crítica del aprovechamiento de los recursos, 7 Becker, 8 Viner), agrupadas en 5 etapas con rótulo en su línea (la riqueza, las personas, la elección, un modo de razonar, lo que hacen los economistas); la numeración sigue de un grupo al siguiente (`\setcounter{enumi}`, que pandoc pasa a `<ol start>`). Patrón fijo de formato (A01-22) explicado en una `notaopositor`; subrayado con `\uline` (A01-23: pasa a la web y a Word). Se recupera la caja con el vídeo de Ha-Joon Chang (enlace comprobado), la viñeta de Markowitz, Miller y Sharpe (Nobel 1990) en la de Viner y 4 notas del tema antiguo (individualismo y holismo, la escasez en las demás ciencias sociales, los 4 mecanismos no excluyentes y la revisión por pares). Lipsey, sin atribuir (A01-21).
2. *«Las ramas … más desarrollado y coherente con la estructura del temario … diagrama en anexo con colores … mapa de la oposición»*. I.3 rehecho con la estructura del tema antiguo puesta al día para el temario nuevo (A01-24): introducción micro/macro (nota de De Vroey; nota sobre el alcance de las preguntas; Shapiro y Stiglitz), `\subsubsection` de microeconomía (cimientos y 8 campos numerados con sus temas), de macroeconomía (origen, método y 5 ramas numeradas) y de ramas aplicadas (historia, instituciones, 4.A, 4.B, econometría) con los grandes debates y la recapitulación. Anexo nuevo `anexo:mapa` con el gráfico TikZ `mapa-temario` (A01-25), compilado (PDF, SVG y PNG en `graficos/`).

**Generales**

3. *Nombres enteros en versalitas*: quedaban 16 casos de «Nombre \textcite{…}» (John Neville Keynes, Myrdal, Shiller, Chetty, Russell, McCloskey, Mannheim, Azpilcueta, Simon, Thaler, Gigerenzer, Vernon Smith, Leamer, Leijonhufvud, Farmer y 2 de Paul Romer): pasan a `\autor{Nombre Apellido} \parencite*{…}`; «padre de John Maynard» pasa a `\autor{John Maynard Keynes}`. Los nombres nuevos del I.1 y el I.3 van enteros.
4. *Remisiones al margen y ningún gráfico con otro tema como fuente*: el pie del gráfico de Lakatos ya no remite al 3.A.6; reescritas las 5 frases que hacían gramática con `\vertema` («el desarrollo está en…», «el desarrollo, con sus fórmulas, en…», «el desarrollo, en…», «con la misma forma que en…», «en resumen \vertema»).
5. *Introducción y conclusión con el rótulo en su línea y viñetas*: ya estaban (pasada del 9/11); revisadas, sin cambios.
6. *Viñetas que se entienden solas y patrones visibles*: aplicados en I.1 (patrón de las definiciones) y en I.3 (rótulos en cursiva, listas numeradas de campos y ramas).
7. *Cajas grises para lo que no se canta*: sin tablas de datos nuevas; la caja de lectura de I.1 es la del vídeo de Chang.
8. *Notas del tema antiguo (bloque de pensamiento)*: además de las de I.1, se recuperan como notas al pie la de la verdad absolutista o relativista (II.2), la de los marginalistas y la mecánica (con Mirowski, 1989, en lugar de «Newton 100 años antes»), la de De Vroey sobre la *Teoría general* y la del alcance de las preguntas (I.3), la de los avances matemáticos de los EGDE y el ejemplo econométrico de la crítica de Lucas (anexo de Kuhn y Lakatos). No se recuperan: Libertad González (nota 6: cita de un blog sin comprobar), Descartes y la «heurística y dialéctica» (no es suya), Brunner (contradice al 3.A.5), Condorcet y Borda (encaja en el 3.A.24, no aquí) y las notas de solo enlaces o de motivaciones del Nobel ya integradas.

`verificar-tema.py 3A01` (sin construir): sin errores de fuente; solo pide volver a construir el PDF, el HTML, el Word y la ficha. Llaves, entornos, `\ref` y `\label` cuadran; las 4 claves nuevas del `.bib` (Akerlof, 1970; Shapiro y Stiglitz, 1984; Nobel 1990; Mirowski, 1989) están añadidas. Copia de las fuentes anteriores en `_trabajo/`.

## Dudas abiertas

Todas resueltas con la opción recomendada; Víctor puede cambiarlas.

- **A01-01** (D1). Tres apartados (I, II, III) en lugar de los 2 bloques del original. *Aplicada*; la alternativa es volver a 2 bloques con III dentro de II.
- **A01-02** (D2). Enganche: la reina en la LSE con «A toro pasado, todos somos Manolete». *Aplicado*; alternativa: la inscripción automática en planes de pensiones del Reino Unido (C2).
- **A01-03** (D5). La metodología de Friedman tiene su referencia en el 3.A.5; aquí, resumen. *Aplicado*.
- **A01-04** (D4). La frase de Joan Robinson (mapa a escala 1:1) **no** se usa: reservada.
- **A01-05** (D6). Anexos A-D: sí (esqueleto en la parte 1; texto en la parte 2).
- **A01-06**. Materia de `seo.json`: «Historia del pensamiento económico», la recomendada para el bloque 3.A.1-3.A.7 (pendiente de decisión en `pendientes-coherencia.md`).
- **A01-07**. La carta de la British Academy (Besley y Hennessy, 22/7/2009) se cita sin comillas. La URL del `.bib` (`thebritishacademy.ac.uk/documents/1238/03-Besley.pdf`) no se puede comprobar: la web bloquea las descargas automáticas, la Wayback Machine no tiene copia de ese PDF (sí de la página del número 14 de la *British Academy Review*, del 8/10/2025, sin el texto de la carta) y las búsquedas siguientes devolvieron «429». Se mantiene la URL con la fecha de consulta; conviene que Víctor la abra en el navegador. La fecha de la visita (5/11/2008) va solo en la nota del `.bib`.
- **A01-08**. La *Werturteilsstreit* va sin año («a principios del siglo XX»): la fecha de 1909 no se ha comprobado.
- **A01-09**. Páginas sin comprobar: Tirole (2017), analogía del médico; J. N. Keynes (1891), cap. II (se cita el capítulo); la cita de Lakatos sobre la heurística positiva va sin página. Ferreira (2013): año de una sola fuente.
- **A01-10**. Pegatinas nuevas de K19 en I y II; la de Kuhn, «La ciencia avanza de funeral en funeral», con la frase de Planck que cita Kuhn (paráfrasis, sin comillas; `Planck1950Scientific`). El ejemplo de la inducción es el pollo de Russell (1912), no el «pavo inductivista», que es una versión posterior.
- **A01-11**. La tabla de escuelas añade una fila de la economía conductual y una columna de «anomalía de partida» (K18), redactadas aquí; conviene que Víctor las mire.

- **A01-12**. El dato de la inscripción automática británica (55 % en 2012, 90 % en 2025) va en los empujones, no en el enganche; el 90 % se ha comprobado de nuevo en gov.uk; el 55 % viene del informe del DWP de 2017 que comprobó la fase de contenido.
- **A01-13**. El β-δ es un subapartado propio (III.1.2) con sus bloques a)-e) en `\paragraph`, y no un apartado dentro de una lista de desviaciones, para cumplir la estructura de modelo de CRITERIOS § 2.
- **A01-14**. La descomposición del sesgo de selección de los RCT se cuenta de palabra (K5) y no se escribe: la ecuación es la función clave del 3.B.28.
- **A01-15**. Sin cifras (no comprobadas en los originales): Madrian y Shea (2001), Johnson y Goldstein (2003), Kahneman, Knetsch y Thaler (1990) («en torno al doble»), Gabaix (2011) e Ioannidis *et al.* (2017).
- **A01-16**. «Una cosa es predicar y otra dar trigo», «Virgencita, que me quede como estoy», «El que se quema con leche…», «El que calla otorga» y «Ver para creer» (esta, la del 3.B.28) son las pegatinas del III (K19).
- **A01-17**. La nota de Molina y Azpilcueta se mantiene en el equilibrio parcial (corregida), aunque C66 proponía quitarla: la teoría cuantitativa de Salamanca es del bloque monetario, y conviene revisar allí si se repite.
- **A01-18**. *Resuelta*: tema-tikz ha hecho el gráfico `replicacion-experimentos`; los 7 gráficos están en `graficos/`.
- **A01-19** (control de calidad, 4/11/2026; *en parte superada por Víctor, 9/11/2026*: pide desarrollar más I.3, así que la caja de campos no se recorta sino que pasa al cuerpo, A01-24). Extensión: 33 páginas de tema para 30 minutos, muy por encima de lo habitual. Sin perder ningún epígrafe del título, se podrían pasar a anexo (o recortar): la caja de campos y temas de I.3; la historia de la econometría de II.3.2 (Tinbergen, Haavelmo, Cowles, Koopmans, VAR, calibración: quedarse con Granger, la crítica de Lucas y la credibilidad); los ejemplos numéricos de heurísticas, marco y cuentas mentales de III.1.3 (anclaje, epidemia, teatro); las finanzas conductuales del cuerpo, que repiten el anexo C; la validez externa de los RCT, que repite el anexo D; las extensiones c) del β-δ, y III.3.3-III.3.5 (heterogeneidad, complejidad, aprendizaje automático y replicación) fundidos en un solo subapartado más corto; también la nota 1 de la introducción. Decide Víctor. *Aplicado lo seguro* (4/11/2026): las finanzas conductuales del cuerpo quedan en una línea que remite al anexo~C; la validez externa de los RCT, en una línea que remite al anexo~D; la caja de campos de I.3 pasa a nota al pie. *Queda como propuesta para Víctor*: recortar la historia de la econometría de II.3.2, los ejemplos numéricos de III.1.3 (anclaje, epidemia, teatro), las extensiones c) del β-δ y fundir III.3.3-III.3.5 en un solo subapartado.
- **A01-20** (control de calidad). La tabla de escuelas pone a los marginalistas en dorado («no revolución») y el gráfico de Kuhn los cuenta entre las revoluciones; se pide al gráfico marcarla como «discutida». Si Víctor prefiere leerla como revolución, habría que cambiar la tabla. *Aplicada la recomendada*: la marginalista, «discutida», como en el 3.A.3 (Blaug, 1972: más un proceso que un vuelco), en la tabla de escuelas y en el pie del gráfico de Kuhn del `.tex`.
- **A01-21** (9/11/2026). La definición 6 del tema antiguo (Lipsey: «estudio del aprovechamiento óptimo de los recursos», que incluye los recursos no escasos) se recupera para mantener la numeración 1-8, pero **sin atribuirla a Lipsey**: no se ha encontrado esa definición en sus obras (búsqueda del 9/11/2026, sin acceso al texto de *An Introduction to Positive Economics*, 1963, ni a Lipsey, 2009, *Economica*, «Some Legacies of Robbins' *An Essay*…»). Va como «la crítica a Robbins» con el argumento de los recursos ociosos de una depresión. *Aplicada*; si Víctor tiene la página de Lipsey, basta con añadir `\autor{Richard Lipsey}` y la cita.
- **A01-22** (9/11/2026). Patrón de las definiciones: **negrita** = la idea que resume cada definición (la escalera de la pizarra); versalitas = autor y año; *cursiva* = la definición; subrayado (`\uline`, de `ulem`, que ya carga `tcee-comun.sty`) = sus elementos, que se repiten subrayados como rótulo de las viñetas de debajo, en el mismo orden. Se explica al opositor en una `notaopositor` al principio de I.1. Las definiciones parafraseadas (Steuart y Smith, Say y Senior, Becker) van en cursiva **sin comillas**; solo llevan comillas las literales que ya estaban comprobadas (Smith, Marshall, Robbins, Viner-Boulding). *Aplicado*; alternativa: las definiciones en redonda y solo los elementos subrayados.
- **A01-23** (9/11/2026). Subrayado en la web y en Word: comprobado con el pandoc de Quarto que `\uline{…}` pasa a `<u>…</u>` en HTML y a `<w:u w:val="single"/>` en Word, también dentro de `\emph` y de `\textbf`; `tcee.lua` y `tema.css` no lo tocan (el navegador subraya `<u>` por defecto). No hace falta cambiar nada. Conviene mirarlo en el primer render.
- **A01-24** (9/11/2026). Ramas: se recupera la estructura del tema antiguo (primera clasificación micro/macro con el aviso de la microfundamentación y el ejemplo de Shapiro y Stiglitz, 1984; microeconomía con sus cimientos y una lista numerada de campos; macroeconomía con sus ramas numeradas y Fisher frente a Keynes), con los temas del temario nuevo y ampliada a los 5 bloques micro, los 5 macro, los mixtos, el 4.º ejercicio y la econometría del 5.º (nuevo I.3.3, «Ramas aplicadas y el mapa de la oposición»). Para I.3 siguen los \tiempo{1,5} del cante: se cantan las 2 ramas, sus cimientos y 2-3 campos de cada lista; las listas completas son para el tribunal. Esto **alarga I.3** (≈1 página), en contra de A01-19, que proponía recortarla: manda el comentario de Víctor. La antigua nota «Campos de la economía y temas del temario» desaparece porque su contenido está ahora en el cuerpo.
- **A01-25** (9/11/2026). Mapa de la oposición (`graficos/mapa-temario`, anexo nuevo `anexo:mapa`, gráfico `fig:mapa-temario`): 3.A.1-3.A.7 arriba; 3.er ejercicio en 2 columnas con los colores de `estructura_temario.json` (micro, verdes; macro, cálidos) y una relación por fila en el pasillo central (microfundamentación, rigideces y salarios, el Estado, ahorro e inversión, lo real y lo monetario); los mixtos debajo; al pie, 4.A, 4.B y la econometría (5.B, en gris: no tiene color en la organización del temario). Cada bloque lleva su lista de temas. Decisiones propias: el trabajo (3.A.25-3.A.28) va en «Demanda agregada y oferta agregada», como en la organización; el 5.º ejercicio solo con la econometría (el marketing y el derecho no son ramas de la economía en el sentido del tema). El anexo va el primero, porque es el mapa de todo el temario. Fuente: «elaboración propia a partir de los títulos oficiales del temario y de la organización por bloques de Víctor Gutiérrez Marcos». En el vídeo no se dibuja: es apoyo.
- **A01-26** (9/11/2026). La reina Isabel II del enganche no va en versalitas: la regla de nombres enteros se aplica a economistas y autores; si Víctor quiere todas las personas, es un cambio de una línea.

## Enlaces del original (9/11/2026)

Revisados los enlaces del tema original que no estaban en la versión revisada (CRITERIOS § 4).

- **Restaurados**:
  - Caja «Para ver» al final de la introducción (donde estaban en el original): vídeo de Skidelsky (New Economic Thinking), vídeo de Óscar Vara sobre Menger, Hayek y Keynes y la entrada de Wikipedia «Pararse sobre hombros de gigantes».
  - Nota al pie en la contextualización (Premio Nobel): portal del Premio Nobel de Economía de Wikipedia (el de nobelprize.org ya estaba en `NobelPrize2026Economia`).
  - Nota al pie en el imperialismo económico: las entradas de Libertad González en Nada es Gratis (era la nota 6 del original).
  - Nota al pie en «predice peor» (el electrón): cita de Gell-Mann en Page (1999), entrada nueva `Page1999Computational` con DOI y `url`.
  - Nota al pie en el descuento hiperbólico generalizado: Wikipedia «Hyperbolic discounting», diapositivas de Mark Hurlstone y la lección 3 del MIT OCW (antes fuente de la imagen del original).
- **Descartados**: stringfixer.com (espejo de Wikipedia; hoy redirige a una tienda) y la versión fijada de Wikipedia (`oldid=1038908957`), que duplica el artículo ya enlazado; ambos estaban en comentarios internos, no en el texto.

## Instrucciones para el vídeo

- **Enganche y cierre**: tras el título, el refrán «A toro pasado, todos somos Manolete» y la pregunta de la reina en la LSE; la pregunta de la exposición: ¿qué estudia la economía, cómo sabe lo que sabe y qué hace cuando la realidad la desmiente? La idea final (parte 2) retoma el refrán y responde con Lakatos: ante 2008, un cinturón protector más ancho y más realista. El hilo de la reina vuelve en I.2, II.1, II.2 (Popper y Kuhn) y II.3 (supuestos), siempre en su propia viñeta.
- **Introducción y conclusión**, sin pizarra (`modo: guion`).
- **Bloque I** (rejilla 50|50): a la izquierda, la escalera de las 8 definiciones numeradas, con su idea en negrita (1 Steuart y Smith → 2 Say y Senior → 3 Mill → 4 Marshall → 5 Robbins → 6 la crítica del aprovechamiento → 7 Becker → 8 Viner; cambio del 9/11/2026); a la derecha, la tabla positiva, normativa y arte, que **se escribe** columna a columna con el ejemplo del salario mínimo; abajo, el árbol micro/macro con la flecha de la microfundamentación. Pegatinas: «Al pan, pan, y al vino, vino» y «Quien mucho abarca poco aprieta».
- **Bloque II** (rejilla 33|33|33): arriba, 5 hitos de la línea del tiempo (el gráfico completo `metodologia-tiempo` va como **apoyo**); debajo, el **ciclo de Kuhn** y el **núcleo y cinturón de Lakatos**, imprescindibles, trazados por capas; cada pegatina junto a su concepto («A todo cerdo le llega su San Martín», «La excepción confirma la regla», «Cada loco con su tema», «La ciencia avanza de funeral en funeral», «Sostenella y no enmendalla», «Todo vale»). La tabla de escuelas, de **apoyo**. Al pasar a II.3 se borra todo; II.3 va de palabra, con las 7 cualidades de un modelo en una lista vertical y las pegatinas «Los árboles no dejan ver el bosque», «Mucho ruido y pocas nueces» y «Gato blanco o gato negro…».
- **Bloque III** (rejilla 40|60): la `\funcionclave` β-δ `eq:beta-delta`, recuadrada arriba a la izquierda, con `conservar: [1]` hasta el final de III.1; a su lado, el gráfico `descuento` trazado por capas (imprescindible) y la RMS de palabra, con el ejemplo de 100 y 110 euros en 3 líneas; después, el boceto de la `funcion-valor` (imprescindible, con λ ≈ 2,25); la lista de desviaciones en columna (preferencias, creencias, decisiones), con sus pegatinas («Una cosa es predicar y otra dar trigo», «Virgencita, que me quede como estoy», «El que se quema con leche…», «El que calla otorga»); el gráfico de replicación, de **apoyo**. En III.2, de palabra con «Ver para creer» en la pizarra; en III.3, de palabra, con el gráfico de Hamermesh como **apoyo** y la palabra «¿evolución o revolución?» junto al dibujo de Lakatos, que se recupera como boceto.
- **Funciones clave que se conservan**: ninguna en I y II; en el III, la del descuento cuasihiperbólico, desde que sale hasta el final de III.1.
- **Conclusión**: empieza por «En conclusión,»; la idea final retoma el refrán y la reina y responde con Lakatos (un cinturón protector más ancho y más realista).
