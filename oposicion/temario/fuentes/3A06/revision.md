# Revisión del tema 3.A.6 (4/11/2026)

La nueva macroeconomía clásica. La hipótesis de las expectativas racionales; la crítica de Lucas; el surgimiento de los modelos dinámicos estocásticos de equilibrio general.

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026): las dudas llevan aplicada la opción recomendada y se anotan como **A06-NN** en «Dudas abiertas». Integración en 2 partes: la parte 1 escribió el preámbulo, la introducción, el esquema, la nota del reparto y el bloque I; la parte 2, los bloques II y III, la conclusión y los anexos A-D y de test.

## 1. Resumen

- Fuente nueva en LaTeX (`3A06.tex`), con la estructura final de la coherencia (K4-K5, § 9): se conservan los 3 bloques y los títulos de segundo nivel del original, y se añaden I.2 (expectativas racionales), la crítica de Lucas como tercer nivel de II.2 y III.4 (surgimiento de los EGDE). Minutos: 2′30″ + 8′ + 10′30″ + 8′ + 1′ = 30′.
- Introducción propia (el enganche y la contextualización del original estaban copiados del 3.A.5): refrán «A otro perro con ese hueso» con la inflación del 10,6 % de octubre de 2022 y las expectativas a 5 años de la encuesta del BCE (2,2 %), ambas comprobadas en 2 fuentes.
- Bloque I reescrito: Schumpeter con universidades en el cuerpo, Barro como converso del desequilibrio, la hipótesis de las expectativas racionales con su estructura de modelo a)-e) y la tabla 10.1 de De Vroey traducida entera.
- Bloque II: Lucas-Rapping en resumen; II.2 con 3 terceros niveles (modelo de islas con ω y ψ, demanda, equilibrio e inefectividad de Sargent y Wallace una sola vez y con ecuaciones, y la crítica de Lucas con un ejemplo sacado del propio modelo y su evidencia, con Ball, Mankiw y Romer bien contados); Kydland-Prescott y Barro-Gordon, equivalencia ricardiana y aritmética monetarista en resumen, con el desarrollo en los anexos B y C.
- Bloque III, titulado ahora «… teoría de los ciclos reales y el surgimiento de los modelos EGDE» (A06-01): idea con la cita de Lucas vía De Vroey y el residuo de Solow con datos de Fernald; características de los EGDE con la cita de Kocherlakota; ciclo real con las ecuaciones canónicas (w_t, r_t + δ), la tabla de Hansen y Wright corregida y con datos de 1984-2019, y el surgimiento de los EGDE remitiendo al 3.A.7. Los 15 errores del McCallum, corregidos en el anexo D.
- 11 gráficos pedidos (los dibuja tema-tikz); 43 páginas (26 de tema), sin referencias indefinidas.

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| I, líder | Nobel de Lucas «Por desarrollar la hipótesis…» (faltaba «y aplicar») | Motivación oficial completa (V1) |
| Nota 6 | Nobel de Kydland y Prescott «Por sus contribuciones a la teoría de la macroeconomía dinámica» | Motivación completa: «… la consistencia temporal de la política económica y las fuerzas que impulsan los ciclos económicos» (V2, C31) |
| Nota 4 | Pennsylvania entre las universidades de agua dulce | Fuera: Chicago, Minnesota, Rochester y Carnegie Mellon (V18, C29); Hall (1976) con año |
| I, frente a Keynes | Lucas: «La teoría económica equivale a un análisis matemático. Lo demás no es un análisis riguroso» (sin fuente, mal traducida) | «La teoría económica es análisis matemático; todo lo demás son dibujos y palabras» (Lucas, 2001, p. 9, vía De Vroey, 2010; V25, C30) |
| I, frente a Friedman | «Lucas se declara monetarista…» (no se encuentra) | Fuera; Lucas (1994) elogia la *Historia monetaria* de Friedman y Schwartz, sin cita entre comillas (V30, K6) |
| I, HER | Usada por Lucas «por primera vez» en 1972; título «Expectations and Neutrality of Money» | Lucas y Prescott (1971) en la inversión; Lucas (1972) la primera en un modelo macro de equilibrio general; «… and **the** Neutrality of Money» (C33, V33) |
| Nota 13 | Error de previsión ε ∼ N(0, σ²), «normalidad» y «homocedasticidad» | Solo media nula, ortogonalidad, eficiencia y expectativas iteradas; la normalidad y la varianza dependen del modelo (C32) |
| Notas 12-13 | ṗ y α de las adaptativas; β_i, γ_i y κ en las extrapolativas y regresivas | π_t, γ (forma canónica del 3.A.5); a_i, b_i y π̄ locales en la caja gris (K22) |
| I, valoración | «Tobin o Schiller» | Shiller (1978) (C50) |
| I, método | Características EGDE repetidas en I y en III.2; crítica de Lucas contada en I y en II.2 | Una línea con `\ref` en I; el desarrollo, solo en III.2 y en II.2 (K25) |
| Nota 53 | Davidson y la ergodicidad colgados de la «nueva síntesis» atribuida a Solow | En la valoración de la HER (I.2 e), con Davidson (1982) (K7) |
| II.1 | «Lo original es su foco en la oferta… y no en la demanda» | Microfundamenta la oferta *de trabajo* con sustitución intertemporal; ε_{L,w} de Frisch = 1/φ (C34) |
| II.2 | θ, «probabilidad de que el shock sea real», con σ²_{p_i} en el numerador; β; y_TNP | ω = σ²_z/(σ²_z + σ²_p), coeficiente de proyección; ψ ≡ ωε_S; y^n (C35, D036) |
| II.2 | Demanda agregada (una línea) y equilibrio (vacío) | y_t = m_t − p_t; `eq:produccion-lucas` y `eq:precios-lucas`, con −y^n (P24) |
| II.2 | «Economía habituada a niveles altos de inflación (σ²_p grande)» y BMR «obteniendo igualmente» el resultado de Lucas | Importa la **varianza**; BMR: −1,639 con la volatilidad sola, pero con la inflación media deja de ser significativa (C36, V5); Lucas (1973) con 18 países, 1952-1967 |
| II.2 y II.5 | Inefectividad 3 veces, 1975/1976 mezclados, «superneutralidad», «cambian los supuestos tecnológicos» | Una sola vez con ecuaciones, las 2 obras, la cita de 1976 completa (V27); superneutralidad distinguida; extienden a Lucas (C37, C38) |
| II.2 | «Tal y como muestran Cooley y Hansen…» | Fuera (V42) |
| II.3 | CPO con cuadrados y π = π* + (α/γ)(Ū − U*)²; sin U* < U^n; orden de las jugadas al revés; «juego de información imperfecta»; KP con juegos repetidos; «cóncavas»; «hard-nosed/wet nosed»; 3.A.17 y 3.A.19 | γ(π − π*) = α(U − U*), π^D = π* + (α/γ)(U^n − U*), U* < U^n, primero el público; información completa, falta compromiso; reputación de Barro y Gordon (1983, *JME*); elipses centradas en (U*, π*); banquero conservador de Rogoff; `\vertema{3.A.14}` (C39-C41) |
| II.3 | «Más de 16.000 citas» | Fuera (V6) |
| II.3 | Fed con inflación media vigente (nota 26) | Historia 2020-2025 y vuelta al objetivo flexible el 22/8/2025 (V9) |
| II.4 | «Net **Worth**»; la monetización como parte del teorema | «Net **Wealth**»; fuera la monetización (C42) |
| II.4 | Schmitt-Grohé *et al.* (2016) | Uribe y Schmitt-Grohé (2017), el manual, sin capítulo |
| III.1 | Cita «That 1975 paper was a dead end…» sin fuente; Barro (1989) | Entrevista de Usabiaga (1999, p. 181) vía De Vroey (2010) (V26); Barro (1989) fuera, Sims (1980, *AER*) (V41) |
| III.1 | Kydland y Prescott con datos de 1950-1975 | Sin fechas (V15) |
| III.3 y anexo D | W_t = A_t(K/L)^α y R_t sin (1 − α) y α; A_t = A_0 + e^{…}; Ã_t = ρ_A A_{t−1}; ln A_t = ρ_A A_{t−1}; A_0 = 0; trabajo «perfectamente elástico»; «en ausencia de depreciación» con δ = 1; ecuación (8) de McCallum; «7 endógenas, 1 endógena (A_t)»; s = αβ con 𝔼_t[1/s]; *time to build* en este modelo; ρ_A ∈ (−1, 1); tabla de perturbaciones mezclada con Lucas (1975); «domina el efecto sustitución»; ζ | w_t = (1 − α)A_t(K/L)^α y r_t + δ = αA_t(K/L)^{α−1}; A_t = A_0e^{g^At + Ã_t}; Ã_t = ρ_AÃ_{t−1} + ε^A_t; ln A_t = ρ_A ln A_{t−1} + ε^A_t; ln A_0 = 0; inelástico; depreciación completa; la (8) sobra; A_t exógena; conjetura y Euler; acumulación estándar; 0 ≤ ρ_A < 1; respuesta según la persistencia; χ (C43, los 15) |
| III.3 | Tabla de calibración: última fila «horas y PIB per cápita»; ρ_A = 0,95 y «ε^A = 0,011»; «Rebelo (22005)» | corr(horas, productividad); σ_ε = 0,007 (Hansen y Wright, p. 6); fila σ_L/σ_{Y/L} y columna 1984-2019 (V11, V12, C44); Rebelo (2005) (V13) |
| III.3 | 75 % de Prescott sin matiz | «Más de la mitad… mejor estimación cercana al 75 %», de «Response to a Skeptic» (V14) |
| Anexo D | Ecuación de San Luis: PIB real, M2, 0,25 | PNB nominal sobre M1 y gasto de pleno empleo; unos 5,8 dólares por dólar en un año (V16, C49) |
| Anexo D | Galí (1999) «única fuente de fluctuación a largo plazo» | Las únicas que mueven la productividad del trabajo a largo plazo (C51) |
| Anexo D | Campbell (1994) para impuestos distorsionadores | Fuera (V54) |
| Valoración del ciclo real | Obstfeld y Rogoff y los terremotos, entre comillas | La idea, sin comillas ni autor (V29), y Bernanke (1995), comprobada |
| Conclusión | «Nueva síntesis» de Solow; Prescott «en 2006», «describe to you» | Goodfriend y King (1997) (C47, V19); conferencia del 8/12/2004, publicada en 2006 (C48, V4) |

## 3. Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P1 (amarillo) | Bloque «Estructura» vacío | Escrito con los 3 apartados y por qué ese orden (K17) |
| P2 (amarillo, conclusión) | Borrador George Lucas / Robert Lucas | Nota al pie en I.1 (líder), sin cantar, con la fecha de estreno comprobada (25/5/1977, V20); el enganche es el refrán (A06-03) |
| P3 (nota al opositor) | Aviso del cambio de temario | Fuera (nota interna) |
| P4 (nota con imagen) | Ficha del tribunal | Fuera; su contenido se cubre así: contexto y autores → contextualización e I.1; HER → I.2; crítica de Lucas → II.2; EGDE → III.2 y III.4; oferta de Lucas → II.2; ciclo real y 1TFEB → III.3; política → II.2-II.5 (K2) |
| P5, P6 (comentarios) | «El tema de Juan Luis… copiado», «copiar y adaptar ICEX-CECO» | Todo el bloque I redactado de nuevo con fuentes primarias; sin nombres de preparadores en el tema (n-gramas contra Tebar y el original: solo el título del tema y frases del propio original de Víctor) |
| P7 (nota al opositor) | «Dedicar mucho tiempo a este apartado» | Reformulada en la `notaopositor` del reparto: la caracterización no baja de 3′; el bloque I tiene 8′ (K3) |
| P22 | «Según Ángel…», «Recomendado por Ángel» | Fuera |
| P29 | Relevancia, enganche y contextualización copiados del 3.A.5 | Enganche y contextualización propios (K14, K16); la viñeta de Schumpeter, con las mismas palabras que el 3.A.7 (pieza común, A06-04) |
| P50 | Pieza común de Schumpeter | Igual que el 3.A.5 y el 3.A.7 («Schumpeter reconoce una escuela de pensamiento por 3 rasgos…») |
| P52 | Bibliografía con temas de preparadores | Fuera: ni «Tema ICEX-CECO» ni temas de compañeros (decisión del coordinador) |
| Fotos de la portada (P40n) | 7 fotos con «Llungqvist» | Fuera: la plantilla no lleva fotos y Ljungqvist no sale en el tema (C61) |
| P8, P14-P17, P19 (comentarios) | «Coordinar con…» | Resuelto con el canon: islas, crítica, inefectividad y EGDE desarrollados aquí; Barro-Gordon, equivalencia ricardiana, aritmética y ciclo real en resumen con anexos y `\vertema` a 3.A.36, 3.A.39 y 3.A.42. P17 («3.A.38, modelo de Sims»): el gasto público en el ciclo real, `\vertema{3.A.38}` en el anexo D |
| P9, P10, P11 | Folio, escaneos de Romer, «clase Juan Carlos» | Fuera; la derivación, en el anexo A |
| P12 | Demanda y equilibrio vacíos | II.2.2 y anexo A |
| P13 | Heijdra (2017), cap. 5, p. 157 | Nota del anexo A, con el capítulo y sin página (V60) |
| P18, P21 | «Copiado de…» | III redactado de nuevo |
| P19 | 9 enlaces a *Everything Econ* | Fuera |
| P20 | «Pensar cómo reestructurar» | Supuestos y ecuaciones una sola vez (III.3 y anexo D) |
| P23-P25 | Oferta, demanda, equilibrio, inefectividad | II.2 y anexo A |
| P26 | Evidencia de KP vacía | Alesina y Summers (1993) |
| P27 | Conclusión incompleta | Los 5 bloques (K18) |
| P28 | Preguntas y quia.com | Anexo de test con las trampas de las 17 preguntas del banco y el enlace genérico al simulador |
| P30-P36 | Errores de BG, RBC, tabla, BMR, equivalencia, aritmética | Ver § 2 |
| P37 | Citas | Ver § 2 y § 4 |
| P38 | BCE y Fed | Anexo B y valoración de II.3 |
| P39 | Duplicados | Una sola versión de cada cosa |
| P40a-o | Figuras | 11 gráficos pedidos (§ 8); imágenes privadas fuera |
| P43, P44 | Crítica y EGDE | II.2.3 y III.2-III.4 |
| P45-P47 | Remisiones | § 6 |
| P49 | Fechas de SW | 1975 y 1976 juntas |
| P51 | Notas privadas | Fuera |
| P53 | Ficha `expectativas-racionales` | Para la fase canon (A06-07) |
| P54 | Profundidad | Resumen y anexos |

## 4. Datos actualizados

| Dato | Valor anterior | Valor nuevo | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Inflación de la zona del euro, octubre de 2022 (enganche) | — (nuevo) | 10,6 % | Eurostat, `prc_hicp_minr` (`Eurostat2026IAPC`) | https://ec.europa.eu/eurostat/databrowser/view/prc_hicp_minr/default/table | 4/11/2026 | API del BCE (ICP.M.U2.N.000000.4.ANR): 10,6 % |
| Expectativas de inflación a 5 años de la encuesta a expertos del BCE (SPF), 4.º trim. de 2022 | — (nuevo) | 2,2 % de media | BCE, SPF.Q.U2.HICP.POINT.LT.Q.AVG (`BCE2026SPF`) | https://data.ecb.europa.eu/data/datasets/SPF | 4/11/2026 | Media recalculada con las 44 respuestas individuales: 2,175 (mediana 2,0) |
| Muerte de Robert Lucas | — | 15/5/2023 | Nobel Prize Outreach, ficha (`NobelPrize2026LucasDatos`) | https://www.nobelprize.org/prizes/economic-sciences/1995/lucas/facts/ | 4/11/2026 | Propuestas de contenido (Universidad de Chicago, 4/11/2026) |
| Estreno de *La guerra de las galaxias* (nota) | 1977 | 25/5/1977 | TCM (`TCM2026StarWars`) | https://www.tcm.com/tcmdb/title/22123/star-wars | 4/11/2026 | Box Office Mojo (V20) |
| Nobel de Lucas, Kydland-Prescott y Sargent-Sims | Motivaciones cortadas | Literales (V1-V3) | nobelprize.org | (en el `.bib`) | 4/11/2026 | 3.A.43 (V13) |
| Universidades de agua dulce | Con Pennsylvania | Sin ella; Hall (1976) | `Hall2026Perfil`, `Kocherlakota2010Modern` | (en el `.bib`) | 4/11/2026 | 3.A.7 (V6) |
| Kydland-Prescott y Barro-Gordon: citas | «16.000» | Sin cifra | OpenAlex/Crossref no cuadran (V6) | — | 4/11/2026 | — |
| Nueva Zelanda, primer objetivo de inflación | 1990 | Marzo de 1990 | `BernankeEtAl1997NuevaZelanda` | (en el `.bib`) | 4/11/2026 | RBNZ (V7) |
| Estrategia del BCE | Julio de 2021 | Confirmada el 30/6/2025; siguiente evaluación en 2030 | `BCE2025Estrategia`, `BCE2025Evaluacion` | (en el `.bib`) | 4/11/2026 | Rueda de prensa (V8) |
| Fed | Inflación media de 2020 | Objetivo flexible desde el 22/8/2025 | `Fed2025Prensa` | (en el `.bib`) | 4/11/2026 | Powell en Jackson Hole (V9) |
| Calibración de la tecnología | σ = 0,011 | σ_ε = 0,007 | `HansenWright1992Labor` | (en el `.bib`) | 4/11/2026 | Prescott (1986), Hansen (1985) (V11) |
| Tabla de hechos estilizados | 1947-1991 | Más σ_L/σ_{Y/L} y columna 1984-2019 (σ_Y 1,00; corr(L, Y/L) −0,60) | `FRED2026CicloEEUU` | FRED | 4/11/2026 | Réplica de 1947-1991 (V12, G1) |
| Residuo de Solow y ciclo | — | corr 0,82; corregido −0,15 | `Fernald2026TFP` | frbsf.org | 4/11/2026 | BLS MFPNFBS (G3) |
| Curva de Phillips de EE. UU. 1960-1985 | — | Gráfico nuevo | `FRED2026PhillipsEEUU` | FRED | 4/11/2026 | API del BLS (G4) |
| Prescott (1986): 75 % | Sin fuente | «Response to a Skeptic» | `Prescott1986Response` | (en el `.bib`) | 4/11/2026 | «Theory Ahead…» (V14) |
| Ecuación de San Luis | 0,25, PIB real, M2 | ≈ 5,8 dólares de PNB nominal por dólar de M1 | `AndersenJordan1968Monetary` | FRASER | 4/11/2026 | Tabla II del mismo artículo (V16) |
| Romer y Romer (1989) | — | 6 episodios; el paro sube unos 2 puntos | `RomerRomer1989Does` | NBER | 4/11/2026 | OpenAlex (V17) |
| Volcker | — | 1979-1987 | `FedHistory2026Volcker` | federalreservehistory.org | 4/11/2026 | `Medley2013Volcker` (V10) |

G2 (ciclo trimestral) no se usa (decisión del coordinador).

## 5. Contenido añadido

- **I.1**: universidades en el cuerpo (no en 2 notas duplicadas); Barro (1979) como converso del desequilibrio (lo promete el 3.A.4); Phelps como precursor; el origen del nombre «nueva clásica» con `\vertema{3.A.2}` y `\vertema{3.A.3}`; la línea del tiempo de la escuela (gráfico nuevo `linea-tiempo-nmc`, que es la franja de la pizarra).
- **I.2 La hipótesis de las expectativas racionales** (nuevo; P42, K7, C10): Muth desde la telaraña (`\vertema{3.A.16}`) con su cita literal (p. 316), la forma canónica de las adaptativas (`eq:adaptativas`, γ, como el 3.A.5), la definición como función clave (`eq:her`, K19), las propiedades del error, la versión fuerte y la débil (Snowdon y Vane, 2005), el ejemplo de la inflación que sube con su gráfico (`expectativas`, nuevo), la caja gris con las extrapolativas y regresivas, implicaciones, extensiones (aprendizaje, información rígida, equilibrios múltiples), evidencia (Coibion y Gorodnichenko, 2015) y valoración (Grossman y Stiglitz, Shiller, Modigliani, Davidson, racionalidad limitada; por qué se impuso).
- **I.3**: las 4 críticas a la síntesis en viñetas, la calibración en una línea, frente a Friedman con la paradoja de De Vroey, frente a los keynesianos del desequilibrio (K33), el concepto de equilibrio de Lucas y Sargent (1979) y la nota 10 (modelos como instrumentos, `\vertema{3.A.1}`); la tabla 10.1 de De Vroey (2016) traducida entera (era una imagen en inglés en el anexo 1).
- Fuentes: las del `.bib` (bib-datos.bib, BibTeX nuevo de las propuestas de contenido y claves de los temas revisados).

- **II.2**: el modelo de islas completo (extracción de señales `eq:extraccion`, oferta `eq:oferta-lucas`, demanda, equilibrio `eq:produccion-lucas` y `eq:precios-lucas`), la inefectividad con su regla (`eq:inefectividad`) y respuesta de Fischer y Taylor, la evidencia de Barro (1977) y Mishkin (1982), y la crítica de Lucas como modelo a)-e) con la forma reducida `eq:forma-reducida`, la curva de Phillips de EE. UU. (gráfico nuevo con FRED), Favero y Hendry, Lindé, Rudebusch, Sims y Leeper y Zha, y Chari, Kehoe y McGrattan.
- **II.3**: Alesina y Summers (1993); Nueva Zelanda; BCE 2025 y Fed 2025. **II.4-II.5**: dominación monetaria y fiscal con su nombre (el del título del 3.A.39) y la restricción consolidada en el anexo C.
- **III**: el residuo de Solow frente al ciclo (Fernald); las 4 letras de Kocherlakota; la calibración en 5 pasos; el 1TFEB; la simulación propia de las respuestas (`irf-rbc`); la columna de 1984-2019; Rebelo (2005); la secuencia RBC → NEK → modelos estimados (Smets-Wouters, NAWM) → HANK.
- **Anexos**: A (extracción de señales, oferta, equilibrio, inefectividad con inercia), B (Barro-Gordon completo con las pérdidas L^T < L^R < L^D, formas de llegar al óptimo, bancos centrales, objetivo de inflación frente a nivel de precios), C (equivalencia ricardiana con las 5 razones del incumplimiento y la aritmética con la restricción), D (modelo general, tabla de equilibrio, McCallum con la conjetura, persistencia α^k y la joroba con ρ_A > 0, limitaciones y extensiones), test.

## 6. Coherencia

- Estructura de K4-K5 y minutos de la tabla § 9 de la coherencia; la `notaopositor` del reparto y de la pizarra es la de la coherencia, con las remisiones a los anexos que existen (A, B, C y D; no hay anexo E: las limitaciones del ciclo real van dentro del D, por decisión del coordinador).
- Pieza común del bloque de historia del pensamiento: la viñeta de los 4 motivos de Schumpeter y su nota, idénticas a las del 3.A.7; la frase «Schumpeter reconoce una escuela de pensamiento por 3 rasgos…», igual que el 3.A.5 y el 3.A.7.
- Definición común de la HER (K31), la que usan el 3.A.29 y el 3.A.33: «los agentes usan de forma eficiente toda la información de que disponen, incluido el modelo de la economía, y no cometen errores sistemáticos».
- Notación del canon: 𝔼, x^e_t ≡ 𝔼_{t−1}[x_t], π^e_t y γ de las adaptativas (§ 0, § 8 y la forma canónica del 3.A.5); ε_t como error de previsión, avisado («aquí no es una elasticidad»); a_i, b_i y π̄ locales en la caja.
- Promesas cumplidas en esta parte: 3.A.4 (Barro, 1979, y la crítica al desequilibrio), 3.A.5 (Muth y los errores sistemáticos de las adaptativas), 3.A.16 (Muth parte de la telaraña), 3.A.29 y 3.A.33 (definición de la HER), 3.A.7 (la NEK adopta las expectativas racionales y discute el vaciado de los mercados).
- Remisiones de esta parte: 3.A.1, 3.A.2, 3.A.3, 3.A.4, 3.A.5, 3.A.7, 3.A.16, 3.A.28, 3.A.29, 3.A.33, 3.A.36.

- Remisiones de la parte 2: 3.A.7, 3.A.14 (Barro-Gordon, en lugar de 3.A.17 y 3.A.19), 3.A.20 (una sola vez), 3.A.22 (1TFEB), 3.A.25, 3.A.28, 3.A.29, 3.A.33, 3.A.34, 3.A.35, 3.A.36, 3.A.37, 3.A.38 (solo el gasto en el ciclo real), 3.A.39 (las razones del incumplimiento de la equivalencia van aquí, no al 3.A.38), 3.A.40, 3.A.41, 3.A.42, 3.A.43, 3.A.45 y 3.B.16. En total, 88 remisiones `\vertema` y 74 internas, todas enlazadas.
- Notación: ω, ψ ≡ ωε_S, y^n, p^e_t (D036); U_t, U^n, U*, π*, π^D (ficha `barro-gordon`), con los puntos R, T y D; θ, χ, φ, ε^F_{L,w} = 1/φ; w_t real con P_t = 1 y r_t + δ el alquiler (como el 3.A.43); ε^A_t la tecnológica y ε_t la sorpresa monetaria, que es un error de previsión como el de `eq:her` (coherente con § 8 del canon).
- «Inefectividad», como la ficha y el 3.A.7, con «o de ineficacia» una vez (nombre del 3.A.28).
- Promesas cumplidas: 3.A.5 (Lucas, 1972, más duro contra la estabilización; crítica al IS-LM), 3.A.7 (inefectividad y Fischer-Taylor; EGDE como reglas del juego; Kydland-Prescott y credibilidad), 3.A.25 (mercado que se vacía), 3.A.28 (la Phillips de los 60 no era un menú estable), 3.A.33 (la Euler de Hall frente a la crítica).
- **Pendiente para temas sin revisar**: el 3.A.36 (Barro-Gordon), el 3.A.39 (equivalencia y aritmética) y el 3.A.42 (ciclo real) deben desarrollar lo que aquí va en resumen; el gráfico `barro-gordon` puede reutilizarse en el 3.A.36. Sin contradicciones con temas revisados.

## 7. Dudas abiertas

Víctor está fuera: se ha aplicado en cada una la opción recomendada.

- **A06-01 (K4).** Títulos de primer nivel: los del original (I acortado con `\newline`: «… según Schumpeter»). El III, por decisión del coordinador, pasa a «Consolidación de la revolución: teoría de los ciclos reales y el surgimiento de los modelos EGDE» (aplicado; ver más abajo).
- **A06-02 (K5).** II.2 se titula «Modelo de información imperfecta de Lucas (1972) y crítica de Lucas (1976)» para que el tercer epígrafe del título se vea en el esquema; la crítica es su último tercer nivel. *Alternativa*: subapartado propio II.3 (C1 de contenido), que desplaza la numeración de Kydland-Prescott y de los 2 resultados fiscales.
- **A06-03 (K14, K18)** — *resuelta por Víctor (9/11/2026)*: el refrán pasa a ser «Si me engañas una vez, tuya es la culpa; si me engañas dos, la culpa es mía», con la misma idea. Texto anterior: enganche con el refrán «A otro perro con ese hueso» y datos de 2022 (coherencia), no con los 2 Lucas (C3 de contenido). La analogía de George Lucas va en una nota al pie de I.1, sin cantar. *Alternativas*: quitarla; usarla como enganche sin refrán.
- **A06-04 (CC6).** Pieza común de Schumpeter: copiada sin cambios del 3.A.7.
- **A06-05.** Tabla de De Vroey: entera (15 filas, como la tabla 10.1 del libro), en vez de las 12 de C8 (que quitaba «tipo de economía», «equilibrio general» y «síntesis neoclásica»). *Alternativa*: la versión corta.
- **A06-06 (K7, C10).** Expectativas extrapolativas y regresivas: en una caja gris con letras locales (coherencia K7), no recortadas (contenido C10).
- **A06-07 (D5 de contenido, CC1, P53).** Ficha nueva `expectativas-racionales` con I.2 como presentación de referencia: para la fase canon.
- **A06-08.** La cifra del enganche: «2,2 % de media» (media de las respuestas puntuales del SPF del 4.º trimestre de 2022, la publicada por el BCE), en lugar de «en torno al 2 %» de la propuesta; la mediana era el 2,0 %.

- **A06-01 aplicada (coordinador)**: el título del III pasa a «Consolidación de la revolución: teoría de los ciclos reales y el surgimiento de los modelos EGDE» (con `\newline` en la banda), en el esquema y en la estructura de la introducción.
- **A06-09.** La crítica de Lucas lleva la evidencia del modelo de islas (Lucas, 1973; Ball, Mankiw y Romer, 1988), como pidió el coordinador, en lugar de ir en la evidencia del modelo (C12).
- **A06-10.** Pegatinas: solo las 4 de la coherencia; fuera las de contenido («no confundir churras con merinas», «quien avisa no es traidor», «no se conduce mirando por el retrovisor», «donde dije digo…», «tanto monta…», «más vale una vez colorado…»).
- **A06-11.** σ_ε = 0,007 (Hansen y Wright, fuente primaria) frente al 0,011 del original atribuido a Romer, que no se ha podido ver.
- **A06-12.** La cita de Lucas sobre el «callejón sin salida» va con una sola fuente (Usabiaga, 1999, a través de De Vroey, 2010); se descarta el pasaje de Bald Peak (C18).
- **A06-13.** Uribe y Schmitt-Grohé (2017) sustituye a «Schmitt-Grohé *et al.* (2016)» para la economía abierta, sin capítulo.
- **A06-14.** Ecuación de San Luis corregida y conservada en el anexo D (anexo B desde el 9/11/2026) (alternativa: quitarla).
- **A06-15** — *resuelta por Víctor (9/11/2026)*: la línea del tiempo es de seguimiento, no de pizarra, y distingue en verde claro lo más propio de la NEK. Texto anterior: el gráfico `egde-secuencia` de contenido no se pide: la secuencia completa la línea del tiempo de I.1 (`linea-tiempo-nmc`).
- **A06-16.** El art. 127.1 TFUE se cita sin el literal (EUR-Lex no se pudo leer; V21).
- **A06-17.** Citas de Lucas (2003) y Bernanke (1995) comprobadas por el agente de contenido, no por el de datos.
- **A06-18 (control de calidad, 4/11/2026).** El aviso de `verificar-tema.py` «cifra sin cita» (anexo de test: 17 preguntas de 2002 a 2025) es un falso positivo: la cifra se ha comprobado contra `preguntas.json` (17 preguntas, de 16 exámenes entre 2002 y 2025) y no necesita cita.
- **A06-19 (control de calidad, 4/11/2026).** La tabla de hechos estilizados (1984-2019) sale de `_trabajo/datos/hechos-estilizados-eeuu.csv`, que no se sube (está en `.gitignore`). **Aplicado**: copiado a `datos/hechos-estilizados-eeuu.csv`; la tabla está escrita en LaTeX con esas cifras (no lee el CSV) y su fuente cita `FRED2026CicloEEUU`.
- Control de calidad (4/11/2026): correcciones de texto aplicadas (ejemplo de las expectativas con γ = 0,5 y 6 periodos de subida, pies de las 2 IRF con una desviación típica, σ_ε en la calibración, circunferencias con γ = 1, títulos del esquema iguales a los del cuerpo, Usabiaga y Hall); los gráficos `persistencia-mccallum` y `oferta-lucas` los corrige el agente de gráficos.

- **A06-20 (9/11/2026).** Rótulos del gráfico `barro-gordon`: «0 = R», «1 = T», 2, 3 y «F = D», para seguir el desarrollo antiguo (pasos 0 a F) sin perder los nombres regla, tentación y discreción del canon (que decía «nunca 0, 1, 2, F»; anotado en `_trabajo/canon-pendiente.md`). *Alternativa*: solo 0-F, como en el tema antiguo.
- **A06-21 (9/11/2026).** Equivalencia ricardiana: el tema antiguo ponía la monetización como tercera forma de financiación equivalente («aumento del ahorro en previsión del impuesto inflacionario»). El teorema compara deuda e impuestos, así que se mantiene la idea pero diciendo que la monetización queda fuera del teorema y remite a la aritmética monetarista. *Alternativa*: el texto antiguo literal.
- **A06-22 (9/11/2026).** Kydland y Prescott, correcciones al texto antiguo: (a) el orden de las jugadas (el antiguo decía «primera etapa, la autoridad; segunda, el sector privado»; ahora: primero el público fija π^e y luego la autoridad elige π, como en el original de 1977); (b) «juego de información imperfecta» pasa a información completa con falta de compromiso; (c) la condición de primer orden y π^D tenían cuadrados de más ((U − U*)² y (Ū − U*)²): corregidas, π^D = π* + (α/γ)(U^n − U*); (d) «curvas de indiferencia cóncavas» pasa a «con forma de elipse»; (e) la cifra de «más de 16.000 citas» se quita (no comprobada); (f) la nota 23 antigua, (U*, π*) = (0, 0), se sustituye por la regla de Víctor: U* < U^n y π* no tiene por qué ser 0.
- **A06-23 (9/11/2026).** Reparto nuevo: I, 7′ (I.2 3′, I.3 1′); II, 12′ (II.3 3′, II.4 y II.5 1′30″ cada uno); III, 7′30″ (III.2 1′30″). Para que quepa, pasan a cajas grises (no se cantan) las cifras de la evidencia de la crítica de Lucas, las del residuo de Solow, la tabla de calibración (tabla 2) y los objetivos del BCE y de la Reserva Federal. *Alternativa*: quitar minutos a III.3.
- **A06-24 (9/11/2026).** La ficha de repaso solo se ha tocado en el enganche, la idea final, los minutos y la línea de la pizarra; las líneas nuevas son un poco más largas: comprobar al construirla que sigue en 4 páginas.
- **A06-25 (9/11/2026).** Thaler, que el tema antiguo citaba junto a Campbell y Mankiw en la miopía de los consumidores, no se cita (no hay obra en el .bib); queda solo Campbell y Mankiw (1989).

## 8. Instrucciones para el vídeo

- **Introducción** (sin pizarra; solo el refrán arriba a la izquierda): tras el título, el refrán y los 2 datos (10,6 % de inflación en octubre de 2022 frente al 2,2 % esperado a 5 años); después, los 70 al revés y la pregunta: ¿puede la política económica engañar de forma sistemática a quien la ve venir? La idea final la responde retomando el refrán.
- **Línea del tiempo** (`linea-tiempo-nmc`): *cambio del 9/11/2026*: no se dibuja en la pizarra (Víctor: no es realista); sale como **apoyo** en I.1 y, por capas, en II, III y la conclusión, para que el oyente siga la exposición.
- **I.1** (3′): de palabra, con la franja; líder, seguidores (Barro converso), agua dulce, objeto en 2 etapas y método en 3 ideas. Apunte: las 3 motivaciones de los Nobel.
- **I.2** (3′): a la derecha, recuadrada y **conservada hasta el final**, `eq:her`. En el centro, boceto de `expectativas` (capas 1 a 4). A la izquierda, la pegatina «nadie da duros a cuatro pesetas». Apoyo: la caja de las otras reglas de expectativas (no se escribe).
- **I.3** (1′): se borra el centro y se conserva la derecha; la tabla de De Vroey va como apoyo y se cuenta de palabra (4 o 5 filas: expectativas, microfundamentos, motor de la economía, efectos del dinero, conclusión de política).

- **II** (12′): se borra el centro y se conserva `eq:her`. II.1 de palabra. II.2.1: a la derecha, recuadrada y **conservada hasta el final**, `eq:oferta-lucas`; en el centro, `oferta-lucas` capas 1-4. II.2.2: `eq:produccion-lucas` bajo la oferta y las capas 5-6 (no anticipada y anticipada) del mismo gráfico; la regla y `eq:inefectividad`, en una línea. II.2.3: la forma reducida `eq:forma-reducida` escrita bajo la producción; pegatina «otros tiempos, otras costumbres»; `phillips-eeuu-1960-1985` como **apoyo**. II.3 (3′): se borra el centro; primero `phillips-ampliada` (capas 1-6: la vertical de largo plazo y 3 curvas de corto plazo), las preferencias `barro-gordon-preferencias` como apoyo, y después `barro-gordon` por capas (ejes, U^n, curvas de pérdida —circunferencias, con γ = 1—, 0 = R, 1 = T, los pasos 2 y 3, F = D), con π^D escrita debajo; pegatina «cría fama y échate a dormir»; `objetivo-precios` como apoyo. II.4 y II.5 (1′30″ cada uno) de palabra, con la restricción de solvencia escrita en II.5 (apoyo: los nombres de los 2 regímenes).
- **III** (7′30″): la línea del tiempo (apoyo) llega a 1982-1986. III.1: `residuo-solow` como apoyo (ahora en la caja gris, no se dibuja). III.2 de palabra (apoyo: las 4 palabras de Kocherlakota, una por viñeta). III.3: se borran las 2 funciones de la derecha y se escribe el bloque `eq:rbc-*` (sin recuadro); boceto de `irf-rbc` (Y, C, I); pegatina «al mal tiempo, buena cara»; la tabla de calibración (ahora en caja gris) como apoyo, sin cantar cifras. III.4: la línea del tiempo completa como apoyo (1997, 2003-2007, 2018, en verde claro).
- **Conclusión** (1′), sin pizarra: retoma el refrán («si me engañas dos, la culpa es mía»); idea final: la política no puede engañar de forma sistemática a quien la ve venir, porque el público aprende del primer engaño, y por eso se diseña como reglas creíbles; matiz neokeynesiano (mientras los precios tardan en moverse, hasta el engaño que se ve venir tiene efectos un tiempo).
- Funciones clave conservadas: `eq:her` (de I.2 al final del bloque II) y `eq:oferta-lucas` (de II.2 al final del bloque II).

## 9. Propuestas aplicadas y rechazadas (parte 1)

- **Coherencia**: aplicadas K1-K7, K14-K17, K19 (`eq:her`), K22 (parte de I), K25 (parte de I), K27, K29 (Nobel y Muth), K30, K31 (definición de la HER), K32-K35, K51 (pedido), K52 (pedido) y la nota del reparto de § 9 (con los anexos A-D). K15: la relevancia de la teoría lleva además los 3 Nobel (C4).
- **Contenido**: aplicadas C8 (con los ajustes de K6: universidades sin Pennsylvania, la tabla en I.3 y entera), C9, C10 (con la caja de K7), C29-C33, C50, C52, C53, C55, C56, C61, C63 (sin «Tema ICEX-CECO», decisión del coordinador). Rechazadas: C1 (estructura de 6 subapartados en II y título del III: manda la coherencia), C2 (reparto 7′/11′/8′30″ y sus 8 pegatinas: manda la coherencia), C3 (enganche de los 2 Lucas: queda en nota), C4 en parte (Phelps 2006 entre los Nobel de la escuela, Glandon y el NAWM: se usan los 3 Nobel y la relevancia de K15), C5 (contextualización con Kuhn al principio y las cifras del BLS: se usa K16, que no repite el 3.A.5; Kuhn va al final), C6 y C7 (problemática y estructura: K17).
- **Datos**: aplicados V1-V3, V18, V20, V25, V30, V33 (V24, la cita de Kocherlakota, queda para III.2); nuevos el IAPC de octubre de 2022 y el SPF (comprobados aquí).
- **Marcas tratadas en esta parte**: P1-P7, P22, P29, P32 (notación de I), P39 (duplicados de I), P41, P42, P50, P52.

## 10. Propuestas aplicadas y rechazadas (parte 2)

- **Coherencia**: aplicadas K8-K13 (con los anexos A-D y test; sin anexo E: las limitaciones van en el D), K18 (conclusión entera, con la cita de Prescott y Lucas, 2003, en la opinión), K20, K21, K22-K25 (II y III), K26, K36, K37 (para la fase canon), K53-K56. K4 sustituida por A06-01 (título largo del III).
- **Contenido**: aplicadas C11, C12 (repartida en II.2.1 y II.2.2, sin la pegatina), C13 (como II.2.3, con la evidencia del modelo de islas), C14 (como modelo a)-e) con R/T/D), C15, C16 (sin la ecuación de la restricción en el cuerpo: pasa al anexo C), C17, C18 (con Usabiaga en lugar de Bald Peak), C19, C20 (con r_t + δ en lugar de R_t, y la tabla ampliada; la tabla de perturbaciones transitoria/permanente queda de palabra), C21 (sin el gráfico `egde-secuencia`), C23 (en parte: la idea final es la de K18), C24-C28, C34-C51, C54, C57-C60. Rechazadas: C22 en su forma (título más corto «los ciclos reales y el surgimiento de los EGDE»: se usa el del coordinador), las pegatinas de C12-C16, el Lucas (1975) como extensión propia (va en una línea en las implicaciones y en III.1).
- **Datos**: aplicados V4-V17, V19, V21 (sin literal), V24, V26-V29, V34-V62 y G1, G3 y G4; G2 no.
- **Marcas tratadas en esta parte**: P8-P21, P23-P28, P30-P49, P51, P53, P54.

## Comentarios de Víctor (9/11/2026)

Aplicados en la fuente (`3A06.tex`, gráficos y ficha); el tema no se ha construido (lo hace el coordinador).

**Generales**
- *Nombres de economistas enteros en versalitas*: repasado; corregidos «Paul \textcite{Romer…}» (ahora \autor{Paul Romer}) y «otro \autor{Lucas}, George» (ahora \autor{George Lucas}). Donde solo se nombra el apellido, el apellido. `verificar-tema.py`: 0 apellidos sin \autor.
- *Gráficos que citan otros temas como fuente y \vertema al margen*: ninguna \fuente cita un tema (se quitó el \vertema{3.A.42} de la fuente de la tabla 2). Reescritas las frases «la estocástica del \vertema{3.A.29}; … del \vertema{3.A.25}», «El debate se desarrolla en \vertema{3.A.7} y \vertema{3.A.1}», «Las limitaciones se desarrollan en el anexo…» y «(…, \vertema{3.A.25})».
- *Introducción y conclusión con el rótulo solo y viñetas indentadas*: ya estaba; el enganche se parte en 4 viñetas y la idea final en 4; viñetas de la conclusión con sujeto propio (opinión, relevancia, extensiones, Lakatos).
- *Viñetas que se entienden solas y patrones visibles*: los modelos nuevos de II.3, II.4 y II.5 siguen a)-e) con i)-iii); enumeraciones en viñetas propias (pasos 0-F, formas de llegar al óptimo, 4 rasgos de los objetivos de inflación, 5 razones del incumplimiento, disyuntiva de la aritmética).
- *Datos no memorizables en cajas grises*: tabla 2 (calibración) dentro de una caja (`tablacaja`), con sus cifras; cifras de Lucas (1973) y Ball, Mankiw y Romer (1988) (18 y 43 países, −1,639, la regresión en 2 pasos del tema antiguo); correlaciones del residuo de Solow (0,82 y −0,15) y el «75 %» de Prescott; objetivos del BCE (2021, 2025) y de la Reserva Federal (2020-2025).
- *Notas al pie del tema antiguo*: recuperadas como notas las del paro natural, la autoridad que elige la inflación, Rotemberg y Woodford (función de pérdida), Volcker, Buchanan, los efectos no keynesianos en la zona del euro y los shocks monetarios no anticipados de las islas.

**Del 3.A.6**
- *Enganche*: «Si me engañas una vez, tuya es la culpa; si me engañas dos, la culpa es mía» (comprobado con grep que no lo usa ningún otro tema), con la misma idea (inflación de 2022 con expectativas ancladas frente a los 70). La idea final lo retoma y responde a la pregunta del enganche. Cambiado también en la ficha.
- *Gráfico 1* (`linea-tiempo-nmc`, recompilado): las aportaciones más propias de la NEK (Goodfriend y King 1997, Smets y Wouters 2003-2007, HANK 2018) en verde claro, con una leyenda bajo la llave. En el texto de I.1 y en la nota al opositor: es un gráfico de seguimiento, no para la pizarra (y en las instrucciones del vídeo pasa a apoyo).
- *Interpretación de la curva de oferta agregada de Lucas*: recuperado el párrafo antiguo con sus 3 viñetas, en II.2.1, con la notación del tema (ω, ε_S, y^n), y su nota al pie.
- *Efectividad limitada de la política monetaria*: recuperado tal cual (3 condiciones a)-c), la intuición, la PIP, la dependencia de β —ahora ε_S— y «¿Qué opina la literatura?») como implicaciones de II.2.2, tras el equilibrio; la cita de Sargent y Wallace va en la condición b). Para no repetir, sale de II.2.1 la viñeta de los efectos transitorios (ahora es la condición a).
- *Kydland y Prescott (II.3)*: vuelve al desarrollo del tema antiguo (págs. 18-24): idea con la evidencia de Barro (1977), la importancia teórica y práctica y la esencia del problema; supuestos del juego, del sector privado (curva de Phillips ampliada con expectativas, **gráfico nuevo `phillips-ampliada`**, antigua imagen 1) y de la autoridad (pérdida, elipses, hard-nosed/wet-nosed con `barro-gordon-preferencias`, antigua imagen 2); derivación gráfica paso a paso 0 → 1 → 2 → 3 → F (**`barro-gordon` rehecho** con los pasos 2 y 3, antigua imagen 3); derivación analítica (corregida, A06-22); óptimo social; formas de llegar (reputación con Volcker, reglas con «atarse las manos», independencia con Rogoff, Walsh y la dominancia monetaria); valoración con los 4 rasgos de los objetivos de inflación y la **antigua imagen 4** (`objetivo-precios`, ya en TikZ, ahora en el cuerpo). Del nuevo se conserva que U* < U^n y π* pueden ser distintos de 0. Del anexo B se integra con mesura: el orden de las jugadas y la información completa, la función de reacción explícita, la ordenación de pérdidas L^T < L^R < L^D, Rogoff con γ′ y Walsh, y la actualización BCE 2025 / Fed 2025 (en caja gris).
- *Equivalencia ricardiana (II.4)*: vuelve al tema antiguo con a)-e): idea (Ricardo 1817, Barro 1974, nota de Buchanan), supuestos, qué implica y qué no, efectos no keynesianos con su nota, economía abierta, evidencia y las 5 razones del incumplimiento (Heijdra, pág. 192). Del anexo C: el mecanismo de la restricción intertemporal, Baxter y King y Giavazzi y Pagano (1990). Monetización: A06-21.
- *Aritmética monetarista desagradable (II.5)*: vuelve al tema antiguo (idea, disyuntiva monetizar/deuda con la bola de nieve, anticipación con HER, conclusión) con a)-c); del anexo C, la restricción de solvencia y los regímenes de dominación; extensión: Leeper (1991).
- *Anexos B y C*: quitados. Los anexos quedan A (oferta de Lucas), B (ciclo real, antes D) y C (test, antes E). Revisadas todas las remisiones (`anexo:kydland-prescott` y `anexo:fiscal` ya no se usan; ninguna \ref rota).
- *III.2*: la definición de EGDE de Kocherlakota (2010), una viñeta por palabra (equilibrio, general, dinámico, estocástico), sin comillas (es una paráfrasis partida).
- *Tabla 2 y datos no memorizables*: en cajas grises (ver arriba).
- *Anexo D (McCallum), ahora anexo B*: caja «Para verlo» con los 8 vídeos de Everything Econ del tema antiguo, con su título y enlace; los 8 comprobados el 9/11/2026 (oEmbed de YouTube responde con el título).
- *30 minutos*: el reparto suma 30 (A06-23); II gana 1′30″ (II.3 3′, II.4 y II.5 1′30″), I pierde 1′ y III 30″; lo que no se canta va a cajas grises.

**Gráficos**: nuevo `phillips-ampliada`; rehechos `barro-gordon` (pasos 2 y 3, rótulos 0 = R, 1 = T, F = D) y `linea-tiempo-nmc` (NEK en verde claro). Los 3 compilados y revisados en PNG.

## Enlaces del original (9/11/2026)

Revisados los enlaces del tema original que no estaban en la versión revisada (CRITERIOS § 4).

- **Restaurados**: nota al pie en el objetivo simétrico del BCE con las 2 páginas del Banco de España que enlazaba el original (nota 25 y el enlace de «instrumentos de política monetaria»), con sus direcciones nuevas (`bde.es/wbe/…`). La de la estrategia ya estaba en el `.bib` (`BdE2026EstrategiaBCE`) pero no se citaba; la de los instrumentos es la entrada nueva `BdE2026InstrumentosBCE`.
- **Ya cubierto**: la página de la Reserva Federal sobre la revisión de su estrategia redirige hoy a la de 2025, que ya se cita (`Fed2025Revision`).
- **Descartado**: el enlace de Forvo del retrato de Thomas Sargent apuntaba por error a la pronunciación de Kalecki.

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Pizarra: Reparto: quitado el plan de pizarra del reparto del cante (zonas izquierda/centro/derecha, qué se borra y qué se queda); se conservan tiempos, refranes, gráficos y funciones clave; «no es realista dibujarla en la pizarra» y «no para dibujarla en la pizarra» reescritos; «(caja de abajo)» → «en la tabla» (4 frases). Títulos: II: corte tras «revolución:» (antes «política / económica»); II.3: corte tras «discrecionalidad:» (antes «(1983)» solo); `\newline` → `\cortetitulo{}`. Ficha de repaso: su apartado «Pizarra» (plan del cante) se mantiene. |


## Comentarios de Víctor (11/11/2026, 5.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| «El gráfico 9 en caja gris.» | El gráfico 9 (`residuo-solow`, residuo de Solow y ciclo de EE. UU.) pasa a `figuracaja` dentro de la caja gris de III.1, junto a las cifras de Prescott y de la correlación («Las cifras y el gráfico (para consultar, no para cantar)»). La viñeta del texto que lo resume (el residuo sigue al ciclo, pero corregido por la utilización la relación desaparece) se queda en el cuerpo porque es contenido de cante; remite al gráfico. |
| Regla de citas (fuentes secundarias fuera del texto) | `\textcite` → texto sin la cita + `\nocite`: Schumpeter (1954) en la introducción («los 4 motivos que da Schumpeter»); De Vroey (2016) en la introducción (revolución de Lucas), en «Método y diferencias con sus predecesores» (paradoja del monetarismo) y en el surgimiento de los EGDE (lectura del programa); De Vroey (2010) en la cita de Lucas (se mantiene la entrevista de Usabiaga, 1999, que es la fuente de la cita literal); Romer (2019) en 2 notas y Heijdra (2017) en una nota del anexo. Los `\textcite` de las líneas `\fuente{…}` bajo gráficos y tablas se mantienen (no interrumpen la lectura, igual que en el resto del temario). |
| (verificar-tema) | «figura~\ref» → «gráfico~\ref» en las 15 remisiones del texto (regla nueva del verificador: no se dice «figura»). |

## Instrucciones para el vídeo

- Pizarra: izquierda refrán y pegatinas; centro gráficos (expectativas, oferta de Lucas, plano (U,π), shock de productividad); derecha expectativas racionales y oferta de Lucas recuadradas. (11/11/2026)
