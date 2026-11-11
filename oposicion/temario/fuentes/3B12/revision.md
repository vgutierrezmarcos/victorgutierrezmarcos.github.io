# Revisión del 3.B.12 (11/11/2026)

*Mecanismos de ajuste de la balanza de pagos. Especial referencia al enfoque intertemporal de balanza de pagos. Análisis de sostenibilidad del déficit y de la deuda exterior.*

Base: Word de Víctor (`Tema 3.B.12.docx`, PDF publicado del 10/08/2024, 47 páginas). Fuente nueva: `3B12.tex` (35 páginas de tema, 6 de anexos y 6 de bibliografía), `3B12.bib`, 8 gráficos TikZ/pgfplots en `graficos/`, 2 CSV en `datos/`, `datos-actualizables.yaml` y `seo.json`. Cante: 2′30″ + 10′ + 5′ + 11′30″ + 1′ = 30′.

## 1. Resumen

- Se mantiene la estructura del Word en 3 apartados (flujos, *stocks*, intertemporal y sostenibilidad), con los títulos retocados y un **I.4 nuevo** (IS-LM-BP, asignación de Mundell y el tipo flexible) que pedían la ficha de ICEX-CECO, el 3.A.32 y el correo.
- Se corrigen errores de teoría (implicación del enfoque monetario al revés, «BP ≡ R», multiplicador con $q$, distancia vertical del modelo intertemporal, determinantes de la sostenibilidad con «más inflación», errata $P_{t+1}Y_{t+1}$) y de datos (España 2007, 2015 y 2019: en 2015 y 2019 hubo **superávit**).
- Se completa lo que faltaba: introducción y conclusión con sus 5 bloques, suavización del consumo con la ecuación fundamental de la cuenta corriente, puzles, solvencia frente a sostenibilidad, deuda en divisas con $\gamma_q$, indicadores, DSA del FMI, efectos de valoración, *risk sharing* (estaba vacío) y superávits excesivos.
- Gráficos nuevos en TikZ: curva J, OA en L de la absorción, flujo-especie, modelo intertemporal (sobre el Robinson Crusoe del 3.A.29), dinámica de la deuda exterior (sobre el del 3.A.39) y uno de datos de España (cuenta corriente y PIIN, 1995-2025); se reutilizan los del IS-LM-BP (3.A.32) y del mercado de divisas (3.B.13).
- Lo que no se canta pasa a 6 anexos (Marshall-Lerner en divisas y BRM; multiplicador paso a paso; modelo intertemporal; deuda exterior paso a paso; ajuste con tipo flexible y Friedman; test).

## 2. Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| I.1, título y l. 130 | «Robinson (1937)» y «Robinson (1947)» | Robinson (1937), *Essays in the Theory of Employment* (1947 es la 2.ª ed.) |
| I.1, nota 3 | «Bickerdicke (1920)» | Bickerdike (1920), *EJ* 30(117) |
| I.1, l. 134-138 | Efectos precio y volumen con numeración rota | Efecto valor (o precio) y efecto volumen, numerados (nombres de la 1D01) |
| I.1, l. 203 y 223 | «demanda de importaciones y **oferta** de exportaciones» | Las **demandas** de exportaciones e importaciones (las ofertas son infinitamente elásticas) |
| I.1 | $\varkappa=EP_M/P_X$, condición sin valores absolutos | $q=EP^*/P$, $\mathrm{XN}=X-qM$, $\lvert\varepsilon_{X,q}\rvert+\lvert\varepsilon_{M,q}\rvert>1$ (canon) |
| I.1, nota 10 | *Pass-through* «anula lo positivo de la devaluación» | Traspaso en sus 2 sentidos (a precios de exportación en divisas y a precios interiores) |
| I.2, l. 342 | «propensión marginal al consumo, $m$» | $m$, propensión marginal a **importar** |
| I.2, l. 482 | «Deardoff» | Deardorff y Stern (1979) |
| I.2, l. 510 (amarillo) | Harberger con «[ver tema 3.B.5]» y elasticidades críticas «mayores» | Efecto Harberger-Laursen-Metzler bien atribuido (relación de intercambio y gasto); con efectos renta keynesianos puros el signo sigue siendo el de Marshall-Lerner (ecuación de 2 países en el anexo B); sin remisión al 3.B.5 |
| I.3, l. 591-595 | «efecto indirecto» / «efecto directo» mezclados | Efecto renta y efecto directo sobre la absorción (Alexander) |
| I.3, nota 19 | La progresividad en frío baja la presión fiscal | La presión fiscal **sube** |
| II.1 | Supuestos con numeración rota (1, 3, 4…) | Lista de la ficha `flujo-especie` |
| II.2, l. 791-793 | $M^S=B^m\cdot m^m$, $m^m=\frac{e+1}{e+q}=1$ | «Multiplicador del dinero igual a 1», sin letra; $M^S=\mathrm{CI}+R$ |
| II.2 | $\mathrm{BP}\equiv R$ | $\Delta R=\Delta M^D-\Delta\mathrm{CI}$ (función clave) |
| II.2, l. 857 | «La política monetaria no tiene efectos en la balanza de pagos» | Una expansión del crédito **sí** produce una pérdida de reservas igual y no cambia la oferta monetaria, la renta ni los precios |
| II.2 | Regla del $k$ % atribuida a Phelps | Friedman (1960) |
| III.2, l. 1092 y 1120 | $C^B$, $P^B$ sin periodo; $r^*<r$ | Puntos $A$, $P$, $C$ del 3.A.29, coordenadas $C^P_t$, $C^C_t$…; $r^A$ de autarquía |
| III.2, l. 1136 | La distancia vertical es el «superávit por cuenta corriente» de $t+1$ y «superávit en la cuenta financiera» | Es el superávit **comercial** de $t+1$, $\mathrm{XN}_{t+1}=-(1+r^*)\mathrm{CC}_t$; la cuenta financiera negativa es entrada neta de capital (MBP6) |
| III.2, implicación 3 | Los flujos de capital dependen «exclusivamente de los diferenciales de tipos»; «siempre» se alcanza un bienestar superior | Dependen de lo que hay detrás de $r^A$ (productividad, impaciencia, renta esperada); con $r^*=r^A$ el bienestar no cambia |
| III.2, nota 25 | FPP con 2 sectores e intensidades factoriales | Fuera (el modelo tiene un bien) |
| III.3 | Atribuye a Gourinchas y Rey que «el capital fluye menos a los países en desarrollo» | Paradoja de Lucas (1990); puzle de la asignación de Gourinchas y Jeanne (2013); desequilibrios globales con Gourinchas y Rey (2014) |
| III.4, nota 33 | «Sostenibilidad = solvencia; la liquidez se arregla reestructurando» | 3 conceptos: liquidez, solvencia y sostenibilidad (Milesi-Ferretti y Razin, 1996; FMI, 2002) |
| III.4, l. 1289 | $B_t/(P_{t+1}Y_{t+1})$ | $B_t/(P_tY_t)$ (anexo D) |
| III.4, l. 1262-1295 | Divide por el PIB nominal nacional y deflacta con la inflación exterior $\pi^*$; $\gamma^Y$ | Forma nominal con $\gamma^N$, real con $r^*$ y $\gamma_Y$ (deuda en moneda nacional) y en divisas con $\gamma_q$ |
| III.4, l. 1334-1350 | La sostenibilidad mejora con «mayor inflación» y «menor tipo nominal» | Tipo **real**, crecimiento real y tipo de cambio real si la deuda está en divisas; la inflación es ambigua (determinantes de la 1D01) |
| III.4.4, l. 1460 | Volcker «produjo una fuerte apreciación de la deuda» | Apreció el dólar y, con él, la carga de la deuda en dólares |
| III.4.4 | Numeración rota («1. Tipo de cambio», «1. Spillovers») | Lista numerada |
| III.4.5, España | 2007: «déficit comercial del 9,2 %», crecimiento 3,8 %, deuda 80 %, tipo real 3 % supuesto; 2015 y 2019: «déficit» de 2,4 % y 2,78 %, 2019 «no sostenible» | 2007: CC −9,4 %, bienes y servicios −5,8 %, SX −6,0 %, $b$ 73 %, $\gamma^N$ 7,2 %, rendimiento implícito 4,3 % → saldo estabilizador −2,0 %. 2015 y 2019: **superávits** y la PIIN bajó 7,5 y 6 puntos (sostenible). 2025 añadido |
| Anexo 1, l. 1668 | Si la moneda se devalúa «disminuye la demanda de divisas» (hablando de la oferta) | Fuera (el anexo se reduce; la oferta y la demanda de divisas están en el 3.B.13) |

### Control de calidad (11/11/2026)

- España (III.5): fuera «sin pausa» en el aumento del déficit desde 1998 (en 2002-2003 se redujo, de −4,3 a −3,7 % del PIB).
- Efecto Harberger-Laursen-Metzler (valoración del multiplicador y anexo del multiplicador): «el ahorro cae y la absorción baja menos que la renta» en lugar de «la absorción sube».
- Valoración del multiplicador: $k$ y $h$ definidos con la LM del 3.A.32, $M/P=kY-hi$.
- `FMIAnalyzeThisGopinath`: fecha de publicación del vídeo, 17/07/2019 (comprobada en la propia página de YouTube, `uploadDate`).
- Enfoque monetario: «solo la composición de la base monetaria» en lugar de «solo su composición».
- España 2015 y 2019: «superávits sin rentas de la inversión del 3,1 y el 2,8 %», como en la tabla de sostenibilidad (antes «de bienes y servicios de en torno al 3 %»).
- Superíndice $P$: en el modelo de 2 periodos se aclara que $C^P_t$, $C^P_{t+1}$ son las coordenadas del punto de producción; en las extensiones, que $X^P$ es el valor permanente, como la renta permanente $Y^P$ del 3.A.33.
- Maquetación: el gráfico de la oferta agregada de la absorción pasa de los supuestos a tras el primer punto del desarrollo, para que la página no quede medio vacía.

## 3. Marcas resueltas

| Marca | Qué era | Qué se hizo |
|---|---|---|
| P1 (amarillo) | Harberger en la valoración del multiplicador | Ver «Errores»; en negro, en I.2 d) y anexo B, con Laursen y Metzler (1950) |
| P2 (amarillo) | Párrafo del BBVA en la nota 31 | Fuera; queda una frase sobre la demanda de activos seguros (Caballero, Farhi y Gourinchas, 2017) en la nota de Lucas, con Gertler y Rogoff (1990) |
| P3 (rojo) | «registro sistemático» (definición de la BP) | Una frase con `\vertema{3.B.11}` en la contextualización; la nota 2 sale |
| P4 | Nota: cambio de temario, mencionar IS-LM-BP | Desaparece; I.4 nuevo |
| P5, P34 | Captura de la ficha de ICEX-CECO | No se publica; su estructura confirma la del tema |
| P6 | «Este enfoque de palabra» (multiplicador) | `notaopositor` de I.2 |
| P7, P8 | Notas con capítulos de Gandolfo | Citas `\parencite[cap.~n]{Gandolfo2016International}`; la «pág. 457» era el cap. 18 (intertemporal), que se cita en III.1 |
| P9-P21 | Comentarios internos (clase, Juan Luis, Ángel, correo de José Luis) | No se publican; sus peticiones se cumplen (I.4, tipo flexible, DSA, *risk sharing*, recortes de los modelos antiguos) |
| P12 | ECB WP 308 | Es Corsetti, Dedola y Leduc (2004), publicado en *RES* (2008): citado en *risk sharing*, con el enlace al WP en el `.bib` |
| P17 | «No hay tipo de cambio» (modelo intertemporal) | Supuesto explícito «Un modelo real» en III.1 |
| P18 | Texto «copiado de Juan Luis» (estabilización, fuentes de financiación, superávit excesivo, en inglés) | Redactado de nuevo con fuentes propias (III.4 c) iv, v y viii) |
| P19, P46 | *Risk sharing* vacío | III.4 c) vii, con Asdrubali, Sørensen y Yosha (1996), BCE (Cimadomo et al., 2018), Lewis (1999), Corsetti, Dedola y Leduc, Shiller (1993) y Borensztein y Mauro (2004) |
| P22 | Cajas de resumen del multiplicador | Pasan a texto subrayado y «En palabras» |
| P23 | Enlace antiguo del BdE | `anotaciones` de III.4 con la dirección nueva (`BdE2026EstadExteriores`) |
| P24 | 4 cajas del anexo 1 (por qué tipo fijo) | Una frase en la introducción y otra en el anexo E (la caja está en el 3.B.13) |
| P25-P29, P31, P33 | Imágenes 1-5 y gráficos sin título | Rehechos en TikZ (ver «Contenido añadido»); los 2 de la nota 37 se integran en `fig:cc-intertemporal` (llaves $\Delta I$ y $\Delta C$) y en el anexo C de palabra |
| P30 | Fórmula de la FPP como imagen | Ecuación en el anexo C |
| P32 | Tabla del *scoreboard* de 2011 | Fuera; quedan los 2 indicadores exteriores del PDM con `\vertema{3.B.45}` |
| P35 | Tablas de maquetación | Ecuaciones en el texto; la cartera, sin funciones (ficha `branson`) |
| P37, P38 | Introducción y conclusión incompletas | 5 bloques cada una |
| P66 | Nota 4 (*disclaimer* del tipo directo) | Viñeta «Convención» en la contextualización y frase en la `notaopositor` del reparto |
| P69 | Enlaces: quia, `file:///`, `urldefense` | quia fuera (enlace al simulador en el anexo F); Moosa y Bhatti con DOI; DSA del FMI, nota de 2008 y BICE limpios, en la `anotaciones` de III.4 y en el `.bib`; vídeo del FMI en la caja de I.1 |
| P71 | «Preguntas de otros exámenes» | Respuesta modelo en el anexo E (`anexo:tipo-flexible`) |

## 4. Datos actualizados

Fecha de consulta de todo: 11/11/2026 (salvo lo que viene del 3.B.11, consultado el 05/11/2026). Detalle y fuentes en `_trabajo/propuestas-datos.md` (V1-V45) y en `datos-actualizables.yaml`.

| Dato | Anterior | Nuevo | Fuente | URL | Segunda comprobación |
|---|---|---|---|---|---|
| CC de España 2007 | «déficit comercial» 9,2 % | CC −9,4 %; bienes y servicios −5,8 % | BdE, BE cap. 17 | https://www.bde.es/webbe/es/estadisticas/compartido/datos/zip/be17.zip | Eurostat tipsbp11 (igual) |
| Crecimiento 2007 | 3,8 % | 3,5 % real; 7,2 % nominal | Eurostat nama_10_gdp | https://ec.europa.eu/eurostat/databrowser/view/nama_10_gdp/default/table | AMECO (igual) |
| Deuda exterior neta fin de 2006 / 2007 | 80 % | PIIN −73,0 % / −85,0 % | Eurostat tipsii10 (= BdE) | https://ec.europa.eu/eurostat/databrowser/view/tipsii10/default/table | Cálculo propio con el PIB (igual) |
| Tipo de 2007 | 3 % real supuesto | Rendimiento implícito de la posición neta 4,3 % (real ≈ 0,7 %) | Eurostat bop_c6_a | https://ec.europa.eu/eurostat/databrowser/view/bop_c6_a/default/table | Forma real = nominal (±0,1) |
| Saldo estabilizador 2007 | −0,6 % | −2,0 % (registrado −6,0 %) | Cálculo propio | — | Forma real |
| España 2015 | «déficit» 2,4 %, crecimiento 3,2 %, deuda 90 % | Superávit (CC +2,0 %, SX +3,1 %), crecimiento 4,1 %, PIIN −95,2 → −87,7 %, estabilizador −3,8 % | BdE, Eurostat | (las de arriba) | AMECO; forma real |
| España 2019 | «déficit» 2,78 %, «no sostenible» | Superávit (CC +2,1 %, SX +2,8 %), PIIN −78,0 → −72,0 %, estabilizador −2,2 % | BdE, Eurostat | (las de arriba) | AMECO; forma real |
| España 2025 (nuevo) | — | CC +3,2 %, SX +4,5 %, PIIN −39,9 → −42,7 % (revalorizaciones ≈ −10 puntos), estabilizador −1,9 %; PIIN 2T2026 −40,7 % | BdE (BE 17 y nota del 23/09/2026), Eurostat | https://www.bde.es/wbe/es/noticias-eventos/actualidad-banco-espana/bop-pii-2t2026.html | 3.B.11 (mismas cifras) |
| PDM, España 2025 (nuevo) | — | CC media 3 años 3,1 %; PIIN −42,7 % | Eurostat tipsbp10, tipsii10 | https://ec.europa.eu/eurostat/databrowser/view/tipsii10/default/table | 3.B.11 (V28) |
| Umbrales del PDM | +6/−4 %, −35 % | Sin cambios (IMA 2026) | CE, COM(2025) 956 | https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=CELEX:52025DC0956 | Ficha `semestre-europeo`, 1D01 |
| Marcos de DSA del FMI | Marco MAC de 2002/2008 | SRDSF (2021, aplicado desde 2022) para acceso a mercados; LIC DSF revisado en sept. de 2026, aplicación en el verano de 2027 | FMI | https://www.imf.org/en/About/Factsheets/Sheets/2023/IMF-World-Bank-debt-sustainability-framework-for-low-income-countries | PR 21/31 del FMI; nota de 2022 |
| Evidencia de las elasticidades (nuevo) | Solo Hooper et al. (2000) | FMI (WEO oct. 2015): depreciación real del 10 % → +1,5 puntos de exportaciones netas | FMI | https://www.imf.org/en/Publications/WEO/Issues/2016/12/31/Adjusting-to-Lower-Commodity-Prices | Rueda de prensa y VoxEU |
| Tailandia 1995-1996 (nuevo) | — | Déficit corriente ≈ 8 % del PIB | FMI, WEO dic. 1997 | (en `3B12.bib`) | — |

## 5. Contenido añadido

- **Introducción** con enganche «De aquellos polvos, estos lodos» (España 2007-2025: ajuste sin devaluación), relevancia (crisis, supervisión, plan de Keynes y la asimetría del ajuste), contextualización con definiciones y la evolución de las ideas, problemática (las 3 preguntas del título) y estructura.
- **I.1**: derivación con la notación del canon, déficit inicial y en divisas, BRM (anexo A), FMI (2015), curva J con *dominant currency pricing* (Gopinath et al., 2020), traspaso en 2 sentidos, vista desde el mercado de divisas (`\vertema{3.B.13}`). Gráfico `curva-j`.
- **I.2**: nota de las transferencias de Keynes y Ohlin (para la remisión del 3.B.5), ecuación de 2 países y casos paso a paso (anexo B).
- **I.3**: gráfico `absorcion-oa`, ilusión monetaria, políticas de Johnson (1958), España sin devaluación.
- **I.4 nuevo**: IS-LM-BP (gráfico del 3.A.32), Meade, Tinbergen, clasificación eficaz de los mercados (Mundell, 1960; Boughton, 2003), asignación de Mundell (1962), Friedman (1953) y por qué el tipo flexible no basta.
- **II**: Tailandia como ejemplo del enfoque «cabeza abajo»; flujo-especie con las reglas del juego (Bloomfield, 1959), Mill y el tipo de descuento, gráfico `flujo-especie`; enfoque monetario con Frenkel y Johnson (1976) y la regla de crédito; cartera con Branson (1977); tabla resumen `tab:mecanismos-ajuste`.
- **III.1**: origen (Sachs, 1981; Obstfeld, 1982; Svensson y Razin, 1983; Obstfeld y Rogoff, 1995 y 1996), modelo real válido con cualquier régimen.
- **III.2**: problema con `\optim`, Euler e inversión con la forma del 3.A.29, $\mathrm{XN}_{t+1}=-(1+r^*)\mathrm{CC}_t$, gráfico `cc-intertemporal` (déficit repartido entre $\Delta I$ y $\Delta C$), implicaciones corregidas, España.
- **III.3**: ecuación fundamental de la cuenta corriente (Obstfeld y Rogoff, 1996, cap. 2), «lo temporal se financia; lo permanente se ajusta» (frase de la 1D01), Glick y Rogoff (1995), Harberger-Laursen-Metzler con optimización, restricciones de crédito y paradas súbitas, NOEM; evidencia: Feldstein-Horioka resumido, Lucas, puzle de la asignación, desequilibrios globales, poco reparto del riesgo.
- **III.4**: liquidez, solvencia y sostenibilidad; restricción de solvencia; forma nominal, real (función clave `eq:deuda-externa`) y en divisas; gráfico `dinamica-deuda-externa`; determinantes de la 1D01; efectos de valoración (Gourinchas y Rey, 2007; Lane y Milesi-Ferretti); tabla de indicadores; DSA del FMI con sus 2 marcos; tabla de vulnerabilidad de las fuentes de financiación; tipo de cambio, pecado original, Volcker, ciclo financiero mundial; *risk sharing*; superávits excesivos; España con el gráfico `cc-piin-espana` y la tabla `tab:sostenibilidad-espana`.
- **Conclusión** con sus 5 bloques; la idea final cierra con el refrán.
- **Anexos**: A (Marshall-Lerner en moneda nacional y en divisas con un ejemplo numérico, BRM), B (multiplicador: 3 casos y 2 países, Harberger y Laursen-Metzler), C (lagrangiano, FPP, autarquía, déficit de inversión frente a consumo de la nota 37, ecuación fundamental), D (deuda: identidad, nominal, real, estabilizador, solvencia, divisas, error frecuente, España 2007 con la forma real y con el 3 % supuesto), E (¿resuelve el tipo flexible el ajuste?, Friedman, 1953), F (test).
- Ideas de estructura tomadas de otros preparadores (no se citan en el tema): orden de los 3 puzles y determinantes (Tebar); restricción intertemporal y gráfico de la dinámica (Luis de Fuentes).

### Propuestas: aplicadas y no aplicadas

- **Contenido (C1-C39)**: aplicadas C3-C39 con estos cambios: C1 (esquema de K2 en su lugar); C2 (enganche del coordinador; su contenido útil en la relevancia); C4 (`eq:saldo-comercial` como `equation`, no función clave); C9 (ecuación de 2 países al anexo B; las 3 viñetas sin fuente de la condición de Harberger no se publican); C17-C19 (la suavización va a III.3 a) y no a III.2 e); bloques de III.2 como a) Supuestos, b) Desarrollo, c) Implicaciones, porque III.1 es la Idea y III.3 la Valoración); C20 (Gertler y Rogoff, 1990, en la nota de Lucas); C22-C23 (una sola función clave, `eq:deuda-externa`, por decisión del coordinador: `eq:dinamica-deuda-exterior` y `eq:saldo-estabilizador-exterior` pasan a `equation` con las etiquetas `eq:deuda-externa` y `eq:saldo-estabilizador`); C29 (sin la perturbación del 30 % ni la afirmación del optimismo del FMI, no comprobadas; el SRDSF descrito como marco de deuda pública, V15); C31 (Tequila sin la cifra); C34 (sin «Volviendo al tango»); C35 (con el rendimiento implícito de la posición neta, no el bono a 10 años; ver «Dudas»); C36 (la idea final con el refrán del enganche, no el tango); C37 (el anexo de divisas se funde en el E); C38-C39 aplicadas.
- **Datos (V1-V45, L1-L12)**: aplicadas todas las frases de V1-V12 (V11: solo los 2 indicadores exteriores, no la tabla del PDM), V14-V43 y L1-L12. No aplicada: V13 (España en el examen exhaustivo de 2026: sin segunda comprobación) y V22 (la nota 1 sale; el MBP7 está en el 3.B.11).
- **Coherencia (K1-K39)**: aplicadas K1-K34 con la estructura final. K35-K39 (mapa y canon) son para `tema-canon` y se recogen en «Coherencia». K19: puntos $A$, $P$, $C$ del 3.A.29 con aviso de que $P$ no es el nivel de precios (D6, alternativa $Q$ descartada). K23: el umbral del gráfico se llama $\overline b$ y no $b^*$ (el asterisco es del resto del mundo en este tema).
- **Pendientes (P1-P71)**: todos resueltos o anotados aquí.

## 6. Coherencia

- **Misma forma que los temas de referencia**: el modelo intertemporal con el gráfico y las letras del 3.A.29 (`robinson-crusoe.tex`, con $\delta=0$); la dinámica de la deuda exterior con la forma, el gráfico y los casos 3 y 4 del 3.A.39 (`dinamica-deuda.tex`), con las letras del §9 ($b$, $d$, $r^*$, $\gamma_Y$, $\gamma^N$, $\gamma_q$); la forma nominal, la de `eq:pii-deuda` del 3.B.11 (sin $\mathrm{ov}_t$); los determinantes, los de la 1D01; las 4 políticas de ajuste, las del anexo E del 3.B.11; IS-LM-BP y mercado de divisas, los gráficos del 3.A.32 y del 3.B.13 sin cambios; Marshall-Lerner con $q$ y valores absolutos (ficha); multiplicador del dinero sin letra; $M^D=P\,L(Y,i)$.
- **Mismas cifras que el 3.B.11 y el 3.A.32**: CC 2007 −9,4 %; CC 2025 +3,2 %; PIIN 2024 −39,9 %, 2025 −42,7 %, 2T2026 −40,7 %; umbrales del PDM. El gráfico de España no rotula 2009 (discrepancia −97,0/−97,2, ver «Dudas»).
- **Remisiones cumplidas para otros temas**:
  - **3.B.5** (l. 975, problema de las transferencias): se cumple con la nota al pie de la Idea de I.2 (Keynes y Ohlin, 1929). Marcar como resuelto en `canon/pendientes-coherencia.md`.
  - **3.A.32** (l. 455, clasificación eficaz de los mercados; l. 124, Marshall-Lerner): se cumplen en I.4 y I.1.
  - **3.B.13** (l. 599, Marshall-Lerner en el mercado de divisas; caja «por qué con tipo fijo»): viñeta en I.1 y frase en el anexo E, sin repetir la caja.
  - **3.A.2** (Mill y el tipo de descuento), **3.A.5** (Frenkel y Johnson), **3.A.29** (enfoque intertemporal), **3.A.39** (deuda externa): recogidos.
- **Cambios para otros temas o para el canon (no se han tocado)**:
  - **Ficha `sostenibilidad-deuda-externa` frente a `restriccion-gobierno`**: la fila «4.B (deuda pública): usar idéntica forma y notación ($b$, $d$, $r$, $\gamma_Y$)» choca con el 3.A.39, donde $d$ es la **deuda** pública y el saldo primario es $g-\tau$. Proponer: «misma forma; las letras de `restriccion-gobierno`; $b$ y $d$ de esta ficha son solo de la deuda exterior». Añadir a la ficha la forma en divisas con $\gamma_q$ y el gráfico de referencia `fuentes/3B12/graficos/dinamica-deuda-externa.tex` (umbral $\overline b$).
  - **3.B.13**: `oferta-demanda-divisas` usa $E^*$ para el tipo de vaciado; el canon evita el asterisco de equilibrio en macro abierta. Si se unifica, cambiarlo en el 3.B.13 y volver a copiar el gráfico aquí.
  - **3.B.11** (opcional): una línea en su anexo E: «con la deuda en divisas, la depreciación real entra en $\mathrm{ov}_t$» (`eq:deuda-divisas` de aquí).
  - **Fichas nuevas propuestas** (K/C1-C3): `absorcion`, `multiplicador-comercio-exterior`, `cuenta-corriente-intertemporal`, con el 3.B.12 de referencia y sus gráficos (`absorcion-oa`, `cc-intertemporal`).
  - **`mapa.yaml`** (K35): la remisión del anexo de divisas es al 3.B.13 (no al 3.B.14); quitar la de Harberger al 3.B.5; añadir las remisiones nuevas (3.B.5, 3.B.13, 3.A.37, 3.A.5, 3.A.2, 3.A.33, 3.B.15, 3.B.16, 3.B.22, 3.B.29, 3.B.44, 3.B.45).
  - **Temas sin revisar del bloque** (para cuando se revisen): 3.B.14 (cartera con las 3 curvas y enfoque monetario del tipo de cambio: aquí solo resumen); 3.B.15 (su «modelo simplificado de equilibrio intertemporal» debe resumirse con la notación de aquí y `\vertema{3.B.12}`); 3.B.16 (devaluación interna y *risk sharing* en la unión); 3.B.17 (mismo error del multiplicador con $q$ y $D^*$ para la deuda); 3.B.19 ($\varkappa$ y $\phi$ → $q$ y $\nu$); 3.B.20 (remite el flujo-especie al 3.B.13: debe ser al 3.B.12); 3.B.22 (programación financiera sobre la absorción y el enfoque monetario de aquí); 3.B.29 (deuda externa y DSA de renta baja).

## 7. Dudas abiertas

Opción aplicada entre corchetes.

1. **I.4 nuevo** (IS-LM-BP, Mundell y tipo flexible) en lugar de repartirlo como extensiones de I.3 y II.2. [I.4]
2. **Títulos retocados** respecto al Word (K2), p. ej. «Enfoque absorción» → «El enfoque de la absorción»; el de I.1 se corta tras «elasticidades». [Retocados]
3. **Notación de la 1D01** ($D^*$ y $\mathrm{CC}^{\text{sin int.}}$) frente a $b$ y $-d$ de aquí y del 3.B.11: decisión pendiente en el canon. [$b$, $d$]
4. **Coste de la deuda en el ejemplo de España**: rendimiento implícito de la posición neta (dato) frente al bono a 10 años (C35) o a un tipo real supuesto del 3 % (Word). Con el bono, 2007 da −2,0 % igual, pero 2015, 2019 y 2025 cambian algo. [Rendimiento implícito; el 3 % supuesto, en el anexo D: no cambia la conclusión]
5. **Forma nominal frente a real en el ejemplo** (el tipo real de 2007 sería ≈ 0,7 %). [Nominal en el cuerpo y la tabla; la real como comprobación en el anexo D]
6. **Gandolfo (2016)**: comprobar que cita a Hooper et al. con la excepción de Francia y Alemania (V17 la comprobó en el original de Princeton), la referencia de **Ferrara y Rotondi (1989)** (atribuidos a Gandolfo, cap. 8, sin comprobar) y el capítulo de la absorción (¿cap. 9?).
7. **Condición de Harberger**: la forma habitual $\lvert\varepsilon_X\rvert+\lvert\varepsilon_M\rvert>1+m+m^*$ podría añadirse si se confirma en Gandolfo (cap. 9). [No se publica]
8. **Gertler y Rogoff de la nota 31**: se ha supuesto que es Gertler y Rogoff (1990), *JME* 26(2), «North-South Lending…» (una sola fuente, Crossref). [Citado así en la nota de Lucas]
9. **Revalorización de 2025** (−10 puntos): se atribuye a «las revalorizaciones», sin decir que fuera la subida de la bolsa española (no comprobado). [Sin atribución]
10. **PIIN de 2009**: −97,0 % en el 3.B.11 (l. 618) frente a −97,2 % de Eurostat y del cálculo con el PIB actual. No se usa en el 3.B.12 (el gráfico no rotula 2009); conviene unificar en el 3.B.11.
11. **Indicadores del PDM**: solo los 2 exteriores frente a la tabla completa del *scoreboard* (V11). [Los 2, con `\vertema{3.B.45}`]
12. **Crisis del Tequila**: la cifra «una quinta parte fue inversión directa» no tiene fuente. [Sin la cifra]
13. **DSA**: la perturbación normalizada de una depreciación real del 30 % y que el SRDSF no tenga módulo de deuda externa (V15, deducido de la nota de 2022) no están comprobados. [Sin el 30 %; el SRDSF como marco de deuda pública y la exterior en la evaluación del sector exterior]
14. **La ilusión monetaria** como mecanismo de Alexander: está en Alexander (1952), sin página comprobada.
15. **Enganche** parecido al del 3.B.11 (mismas cifras de 2007 y 2025; aquí el ángulo es el ajuste sin devaluación). La pegatina «lo temporal se financia; lo permanente se ajusta» es de la 1D01 (frase, no refrán). [Aplicados]
16. **Longitud**: el tema ocupa 35 páginas (el Word, 47 con anexos); el cante cuadra en 30′, pero III.4 c) tiene 8 extensiones que en el cante son solo títulos.
17. **Fichas nuevas** `absorcion`, `multiplicador-comercio-exterior` (¿ficha propia o alias de `mundell-fleming`?) y `cuenta-corriente-intertemporal`.

## 8. Instrucciones para el vídeo

- **Enganche e idea final**: «De aquellos polvos, estos lodos» (España 2007: déficit del 9,4 %; desde 2012, superávit). La idea final vuelve al refrán: los polvos, un déficit que pagaba vivienda con deuda; los lodos, una década de ajuste sin poder devaluar. Introducción y conclusión, sin pizarra. La conclusión empieza por «En conclusión,».
- **Funciones clave que se conservan en la pizarra** (recuadradas): `eq:marshall-lerner` (de I.1 al final de I), `eq:absorcion` (de I.3 al final de II), `eq:enfoque-monetario` (II.2 y la recapitulación de II) y `eq:deuda-externa` (III.4 hasta el final).
- **I** (10′):
  - I.1: a la pizarra `eq:saldo-comercial` y la condición `eq:marshall-lerner`; la curva J dibujada en 6 trazos (capas de `curva-j`). Los 2 sentidos del traspaso, de palabra (apoyo: tarjeta «exportación en divisas / precios interiores»). El vídeo del FMI no se enseña.
  - I.2: de palabra; a la pizarra solo `eq:multiplicador-xn`.
  - I.3: `eq:absorcion` y `eq:absorcion-devaluacion` con sus 2 llaves; «reducir y desviar el gasto» junto a la ecuación; `absorcion-oa` como apoyo. España, de palabra.
  - I.4: de palabra; `is-lm-bp` y `oferta-demanda-divisas` como apoyo.
- **II** (5′): el circuito del déficit de `flujo-especie` (capas 1-6) a mano y el del superávit como apoyo; `eq:oferta-monetaria` y la función clave `eq:enfoque-monetario`; cartera de palabra; la tabla `tab:mecanismos-ajuste` como apoyo en la recapitulación.
- **III** (11′30″):
  - III.1 (1′): de palabra.
  - III.2 (4′): **gráfico conjunto por partes** `cc-intertemporal`: primero la autarquía (capas 1-3: ejes, frontera, $U_0$ y $A$ con $-(1+r^A)$); después la apertura (capas 4-5: recta $-(1+r^*)$, $P$, $U_1$, $C$) y, al final, las llaves (capas 6-8: déficit en $t$, su reparto entre $\Delta I$ y $\Delta C$, superávit comercial en $t+1$). Al lado, `eq:euler-abierta` y `eq:inversion-abierta`. Decir una vez que $P$ es un punto y no el nivel de precios.
  - III.3 (1′30″): de palabra; la pegatina «lo temporal se financia; lo permanente se ajusta» se escribe junto al gráfico intertemporal. `eq:cc-fundamental` como apoyo, no se escribe.
  - III.4 (5′): a la pizarra la función clave `eq:deuda-externa` y debajo `eq:saldo-estabilizador`; el gráfico `dinamica-deuda-externa` en sus 2 paneles (caso 3: capas 1-3; caso 4: capas 4-5); la lista de determinantes con sus signos. Las extensiones, como lista de títulos con una frase cada una (valoración, indicadores, DSA, fuentes de financiación, pecado original, *risk sharing*, superávits). España: se dicen las cifras de 2007 (estabilizador −2 %, déficit del 6 %) y de 2025; `cc-piin-espana` y las tablas `tab:indicadores-externos`, `tab:fuentes-financiacion` y `tab:sostenibilidad-espana`, como apoyo.
- No se dicen números de temas en voz alta.

## Respuestas de Víctor (12/11/2026)

- Se mantiene el I.4 nuevo (IS-LM-BP, asignación de Mundell y ajuste con tipo flexible).
- Enganche «De aquellos polvos, estos lodos» aprobado.
