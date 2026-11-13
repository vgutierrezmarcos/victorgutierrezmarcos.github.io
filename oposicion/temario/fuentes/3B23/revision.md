# Revisión del tema 3.B.23 (8/11/2026)

## Resumen

- Tema reescrito en LaTeX a partir del Word de Víctor (última versión del
  10/08/2024), con la estructura de 3 apartados de la fase de coherencia: el
  bloque 0 del Word (definición y tipos de acciones) pasa a ser I.1, y los
  bloques 1, 2 y 3 son I, II y III, en el orden de Víctor (cartera →
  valoración → eficiencia → fundamental y técnico).
- Introducción con sus 5 bloques y enganche nuevo («Nadie da nada por nada»
  y el 52 % de fondos indexados); I (instrumentos; Markowitz, Tobin y Sharpe;
  CAPM y APT con la estructura a)-e)); II (eficiencia y finanzas
  conductuales); III (fundamental, enlazado con la SML por Gordon-Shapiro, y
  técnico, con datos reales del S&P 500); conclusión completa (relevancia,
  extensiones y opinión estaban vacías); 4 anexos (acciones, derivaciones con
  `\findemo`, indicadores técnicos, test). Minutos: 2′30″ + 14′ + 4′30″ + 8′ +
  1′ = 30′.
- Corregidas las fórmulas de fondo: la beta (escrita en 6 sitios como la
  covarianza de 2 esperanzas), la varianza de la cartera en el modelo de la
  diagonal ($\beta_P^2$), los supuestos de la APT (copiados del CAPM) y su
  ecuación de valoración, que faltaba.
- La crítica de Roll, que estaba 2 veces en comentarios y notas copiados de
  Rubio (1986), queda una sola vez, redactada de nuevo, con Shanken (1987) y
  Rubio (1986) para España.
- Funciones clave: la varianza de la cartera, la SML y la ecuación de la APT.

## Errores corregidos

| Dónde (Word) | Decía | Dice ahora |
|---|---|---|
| CAPM, caja de la beta, tabla CML/SML, notas 17 y 19 | $\beta_i=\mathrm{Cov}(E[R_i],E[R_M])/\mathrm{Var}(R_M)$ (covarianza de 2 constantes, que vale 0) | $\beta_i=\mathrm{Cov}(r_i,r_M)/\mathrm{Var}(r_M)=\mathrm{corr}(r_i,r_M)\,\sigma_i/\sigma_M$ (C23) |
| Modelo de la diagonal (l. 587) | $\beta_P^2=\sum_i w_i^2\beta_i^2$; con ella el límite daría 0, no «un número real positivo» | $\beta_p=\sum_iw_i\beta_i$ y $\beta_p^2\sigma_M^2$; el límite, bien hecho, va al anexo B con `\findemo` (C19, K15) |
| Modelo de la diagonal (l. 529) | la matriz de varianzas y covarianzas «de los rendimientos» es diagonal | es diagonal la de los **residuos**; la de las rentabilidades tiene $\sigma_{ij}=\beta_i\beta_j\sigma_M^2$ (C18) |
| Modelo de la diagonal (l. 564) | $\alpha_i$ «muestra el riesgo de otros factores» | modelo de índice en excesos de rentabilidad: $\alpha_i$ es la parte de la rentabilidad esperada que no explica el mercado y es el alfa de Jensen (K12) |
| Modelo de la diagonal (l. 521) | Sharpe, «doctorando» de Markowitz | tesis en UCLA; Markowitz, en la RAND, hizo de director de hecho sin estar en el tribunal (V16, C18) |
| Markowitz (l. 321) | curvas de indiferencia «de pendiente negativa» (contradice l. 236) | crecientes y convexas en $(\sigma,\mathbb{E})$, una sola redacción en los supuestos (C14, K13) |
| Markowitz (l. 283, 289) | con $\rho=1$ las variaciones de los 2 títulos son «iguales» | relación lineal exacta y creciente (C13) |
| Markowitz (l. 240-263) | problema anidado «max U s.a. frontera eficiente: {max E s.a. σ² = …}» | 2 etapas; la primera con `\optim` (mín. varianza con rentabilidad dada) y las restricciones debajo (K13) |
| Markowitz (l. 317) | «maximización del beneficio esperado» | rentabilidad esperada |
| Nota 7 | covarianza «del rendimiento esperado» de $i$ con el de $j$ | covarianza de los rendimientos |
| Tobin (título y l. 413, 445) | «Tobin, Sharpe, Lintner y Fama»; la tangencia es «la cartera de mercado»; $\sigma_P$ como media ponderada de las desviaciones típicas | Tobin (1958); cartera de tangencia $T$, que solo en equilibrio es $M$; la recta sale de que el activo seguro no tiene varianza ni covaría (C17) |
| CAPM (l. 709) | el riesgo que se paga es «la volatilidad del activo» | la covarianza con la cartera de mercado, medida por la beta (K16) |
| CAPM, derivación (l. 719-723) | «se distribuyen como una normal»; «para evitar arbitraje» | basta media y varianza; el argumento es de equilibrio, no de arbitraje (C28) |
| CAPM, supuesto 5 | «la diversificación permite eliminar el riesgo idiosincrático» como supuesto | es una conclusión; supuestos de la ficha `capm` con expectativas homogéneas y oferta fija (C24, K16) |
| CAPM (l. 721, 725) | «función linear»; «Securities Maket Line» | lineal; *security market line* |
| Nota 18 | «la prima de riesgo será igual para todos los activos» | lo igual es el precio del riesgo $\lambda_M$; la prima, $\beta_i\lambda_M$, es distinta (C30) |
| Caja de la beta | $\beta>1$, más «rentabilidad»; $\beta=1$, «la misma rentabilidad y riesgo»; $\beta=0$, «activo libre de riesgo y dinero en efectivo»; $\beta<0$ por «el efecto diversificador» | rentabilidad *esperada*; $\beta=1$ mismo riesgo sistemático, no total; $\beta=0$ rinde $r_f$ aunque tenga riesgo; $\beta<0$ rinde menos que $r_f$ porque asegura la cartera (C27) |
| Evidencia del CAPM | Jagannathan y Wang (1999), «el CAPM está vivo y bien»; Fama y French (2003) con una cita entre comillas; Bartholdy y Peare (2002), «puede ser apropiado declarar muerta a la beta» | Jagannathan y Wang (1996), con el título del documento de 1993; Fama y French (2004) parafraseado; Bartholdy y Peare (2005), sin la cita literal (no se encuentra), con su resultado (V19-V21, C32) |
| Valoración del CAPM (l. 851, 873, 875) | la cartera de mercado incluye «bonos, derivados»; préstamos «a cualquier tasa de interés»; «falta de consideración de factores no financieros» | todos los activos con riesgo, también no cotizados y capital humano; al tipo sin riesgo; se quita el tercer párrafo (los factores sistemáticos entran por la covarianza) (C34) |
| APT, supuestos (l. 923-947) | los 7 del CAPM (media-varianza, préstamo a $R_f$…) más 2 propios; «supuestos menos restrictivos» (contradicción interna) | 5 supuestos propios (modelo factorial, muchos activos, sin fricciones, no arbitraje) (K19, C36) |
| APT, desarrollo | solo el proceso generador; $F_{jt}$ «probabilidad de acaecimiento»; $E_i$ | ecuación de valoración $\mathbb{E}[r_i]=r_f+\sum_j\beta_{ij}\lambda_j$; $F_j$ sorpresa de media nula (K19, C36) |
| APT, Fama y French | esperanza como constante de una regresión de rentabilidades realizadas; HML «mayor valor contable» | regresión en excesos con $\alpha_i$; HML por valor contable *en relación con el de mercado* (C37) |
| APT, valoración | Ross «3 a 5 factores»; «falta de fundamento teórico» | Roll y Ross (1980), 3 o 4; el fundamento es el no arbitraje, falta una teoría de los factores (C39) |
| Tabla CAPM-APT | «ambas asumen que el mercado es eficiente» (informativamente) | ninguna supone eficiencia informativa; la APT supone no arbitraje (K19, C39) |
| Hipótesis conjunta (l. 1064) | «modelo de valoración de activos por arbitraje (por ejemplo, el CAPM)» | de equilibrio (CAPM) o de arbitraje (APT) (K20, C40) |
| Nobel de 2013 (l. 1062, nota 26) | «análisis empírico de precios de posesiones capitales» | «por su análisis empírico de los precios de los activos» (V26) |
| Nobel de 1990 (nota 3) | «para establecer la teoría» | «en la teoría de la economía financiera» (V12) |
| Nota 2 | tesis de Markowitz «tutorizada por Milton Friedman» | director, Jacob Marschak; Friedman, en el tribunal (V10, C4) |
| Gestión pasiva y activa (l. 1052) | «sin embargo» entre 2 frases que dicen lo mismo | reescrito (C41) |
| Formas de eficiencia | de fuerte a débil, con nombres sin el mismo patrón; información histórica «en bases de datos y medios» | de débil a fuerte (cada una implica la anterior), con Roberts (1967) y Fama (1970, 1991) (C42) |
| Grossman y Stiglitz (l. 1098) | como argumento sobre los costes del arbitraje | paradoja de los incentivos a informarse (C45) |
| Sesgo (c) (l. 1126) | «descuento parabólico» y remisión al 3.A.29 | descuento exponencial frente a cuasihiperbólico, `\vertema{3.A.1}` (C47, K21) |
| Dividendos (l. 1139) | «por lo menos hasta ahora» tributan más | hasta 2003 (IRS) (V30) |
| Orden de prelación (l. 164) | tras pagar a los «deudores» | a los **acreedores** (C7) |
| Introducción, nota 1 | «esperanza» de recibir beneficios (rojo) | expectativa (C2) |
| Análisis fundamental (l. 1181) | Gordon-Shapiro remitido al 3.B.3, sin fórmula; coste del capital propio «[ver tema 3.B.3]» | \eqref{eq:gordon} y PER teórico \eqref{eq:per-teorico} con $r_E$ de la SML, `\vertema{3.B.4}` (K27, C49) |
| Análisis fundamental (l. 1176) | «*down-top*» | *bottom-up* (de abajo arriba) |
| Múltiplos (l. 1236) | «EBIT múltiplo» en el título y «EBITDA» en la imagen; *Entreprise Value* | EV/EBIT; *enterprise value* (C50) |
| CAPE (l. 1283) | párrafo en inglés; CAPE solo de Shiller | traducido (exceso de rentabilidad del CAPE); Campbell y Shiller (1988, 1998) (C51, V2) |
| Análisis técnico (l. 1291) | «completamente en contra de la EMH», mientras la premisa 1 de Murphy es una frase de eficiencia | acepta que el precio lo descuenta todo y niega la forma débil (paseo aleatorio) (K23) |
| Análisis técnico, cita (l. 1289) | «La palabra "técnico" implica…» como cita sin fuente | sin comillas: la idea queda en la definición (no se localiza la cita literal, C52) |
| Interés abierto | como fuente de información de las acciones | solo existe en futuros y opciones (`\vertema{3.B.25}`) |
| RSI (l. 1366) | precio de un activo entre un índice de la industria | eso es la fuerza relativa; el RSI es el de Wilder (1978), con su fórmula (C52) |
| *Put-call* y sentimiento | frases incompletas | completadas (lectura contraria; índice de confianza de *Barron's*) |
| Conclusión, recapitulación | efectos riqueza, política monetaria y macroprudencial que el cuerpo no trata; «fondo índice como Vanguard o Amundi» | a extensiones con remisión; sin marcas comerciales; «bastaría con una gestión pasiva» solo si además se cumple la EMH (K11, K23) |
| Anexo 1 | defensivos y cíclicos sin criterio | ligados a la beta; añadidos crecimiento y valor (C11) |
| Tipos de acciones | «bajo la par» respecto al valor en libros; *private equity* como mercado | prohibido emitir bajo el nominal (LSC, art. 59.2); el capital riesgo es la financiación de no cotizadas (C8) |

## Marcas resueltas

| Marca | Texto original | Qué se hizo |
|---|---|---|
| P6, rojo (nota 1) | «esperanza», «riesgo» | «expectativa» (Bodie, Kane y Marcus, cap. 1); «riesgo» era correcto: pasa a negro |
| P1, amarillo (tipos de acciones) | «Según […]: Nuevas, liberadas, […]» | el criterio es el origen; faltaban las de pago y parcialmente liberadas; en el anexo A |
| P2, amarillo (límite del riesgo sistemático) | «NOTA (no cantar): a qué tiende el primer componente…» | fórmula corregida en el cuerpo; la demostración, al anexo B |
| P3, amarillo (diversificación internacional) | «el riesgo sistemático también puede reducirse… otros países» | confirmado con Solnik (1974): 27 % y 11,7 % (no 25 %), sesgo doméstico (French y Poterba, 1991) y gráfico con los datos |
| P4, amarillo (4 sesgos) | exceso de confianza, extrapolación, preferencias inconsistentes, contabilidad mental | reescritos con fuentes (Barber y Odean; De Bondt y Thaler; Laibson; Thaler; Barberis y Huang) y ordenados en creencias, preferencias y decisiones; nota 33 (pensamiento ilusorio, Pigmalión) fuera |
| P5, rojo (caja «La BETA») | título en rojo y clasificación | caja gris con tabla de la beta y el triángulo de riesgos, errores corregidos |
| P7, notas al opositor iniciales | cambio de temario y tabla de la nota inicial | fuera (eran notas de trabajo) |
| P8, «Ver Sharpe Ch. 9» | nota al opositor del CAPM | derivación en el cuerpo y en el anexo B |
| P9, «Ver Sharpe Ch. 11» | nota al opositor de la APT | supuestos y ecuación de Ross; derivación con un factor en el anexo B |
| P11, comentarios y notas sobre Roll (12) | «Buscar crítica de Roll, ver correo de […]» y 4 párrafos repetidos | una sola vez, en la valoración del CAPM, redactada de nuevo; el enlace de AECA es Rubio Irigoyen (1986), *REFC* 50; Shanken (1985 b) se publicó como Shanken (1987). Wikipedia e Investopedia fuera; el nombre y el correo no se publican |
| P12, comentario | «¿Por qué se unen el activo de riesgo y la cartera de mercado mediante una línea recta?» | respondido en el texto de Tobin y en el anexo `anexo:cml-recta`  |
| P13, nota al opositor | la crítica conductual no refuta la eficiencia; burbujas | viñeta de los límites al arbitraje (con la redacción del anexo C del 3.A.1) y Abreu y Brunnermeier (2003) en II.1.4, y `notaopositor` al final de II.2 |
| P14, cajas de anotaciones | 4 enlaces de YouTube sin título | con título; el 1.º en el CAPM y los otros 3 en la APT (el 2.º es de factores) |
| Notas al pie 5-12 | | se mantienen (5 y 6 juntas; 7 en el cuerpo; 8 como texto; 9, 10 y 11 en notas; 12 reescrita y citada, V11). El gráfico de la nota 5 (utilidad cóncava) no se rehace: remite al 3.A.10 |
| Notas 13, 14, 16, 17, 20-24 | | 13 y 14 absorbidas en Tobin; 16 en la idea y la valoración del CAPM; 17 en la caja de la beta; 20 en la nota de Treynor; 21 (4 «maneras» de estimar la beta, 2 iguales) sustituida por la estimación por regresión y el ajuste de Blume; 22 en la valoración del CAPM y del modelo de índice; 23 en el ejemplo de arbitraje; 24 fuera (trivial) |
| Notas 25-30 | | 25 (Repsol) como ejemplo sin marca («una petrolera»); 26 en el texto; 27 reescrita (Fox, Quiggin y el Nobel compartido); 28-30 se mantienen, la 30 con Harrison y Kreps |
| Nota 31 | PPA de mercados eficientes de Roll (1979), atribuida a Roll (1977) | fuera: es de tipo de cambio (3.B.14) y confundía las 2 obras; una viñeta remite la eficiencia del mercado de divisas al 3.B.13 |
| P10, nota al opositor («Ver manual Sharpe 22.4 o capítulo 1 del manual de Pablo Fernández») | | resuelta: métodos estáticos, dinámicos y múltiplos con Gordon-Shapiro; la clasificación completa y la tabla de múltiplos, en el 3.B.4 (D4) |
| P28, capturas de texto (FN-0462) | 2 imágenes de texto | no se copian; la idea (PER recoge la estructura financiera, EV/EBIT no) va redactada y la tabla de ventajas, en el 3.B.4. La nota técnica es de Badenes y Santos (1999), bajo la supervisión de Pablo Fernández |
| P29-P31, imágenes 10-12 y vela suelta | gráficos de webs divulgativas | esquema propio (`soporte-resistencia`), serie real del S&P 500 con medias de 50 y 200 sesiones (`sp500-soporte-medias`) y velas en TikZ (anexo C); la vela decorativa sale |
| Notas 34-42 | | 34 y 35 en una nota (inversión en valor, Buffett bien escrito, sin Bestinver); 36 se mantiene (EBIT); 37-39 en una nota del PER; 40 fuera (el Nobel ya está en II.1.2); 41 en el texto; 42 en una nota (media simple y exponencial) |
| Anexo 2 (rentabilidad de las acciones) | | sube a I.1.2 \eqref{eq:rentabilidad-accion}; la venta en corto, al final del anexo A |
| Bibliografía, preguntas y test | «Tema ICEX-CECO», «Tema A. Sahuquillo», «Tema Juan Luis Cordero Tarifa», 2 rutas `file:///`, Comín (2014), «Preguntas de otros exámenes» vacío, quia.com | fuera los temas de preparadores, las rutas locales y Comín; Mascareñas se mantiene; el test, con el enlace genérico al simulador y un anexo de fechas y trampas |
| Nota 4 | «IPO y SPAC» como modalidades de salida a bolsa | OPS, OPV y SPAC bien distinguidas (C10) |

## Datos actualizados

| Dato | Antes | Ahora | Fuente | URL | Consulta | Segunda comprobación |
|---|---|---|---|---|---|---|
| Fondos indexados en EE. UU. (enganche) | — | 52 % del patrimonio de los fondos a largo plazo a fin de 2025 (19 % en 2010) | ICI, *2026 Fact Book*, cap. 2 | https://icifactbook.org/pdf/2026-factbook-ch2.pdf | 08/11/2026 | serie mensual del ICI; Morningstar (resumen) |
| Fondos indexados, último mes (II.1.1) | — | 54,5 % en septiembre de 2026 | ICI, *Active and Index Investing* | https://www.ici.org/research/stats/combined_active_index | 08/11/2026 | coherente con la anual |
| Bolsa española (relevancia) | — | 1,10 billones de euros a 31/12/2025, ≈ 2/3 del PIB, +40 %; IBEX 35 +49 % | BME, *Informe de mercado 2025*; INE, CNA 2025 | ver `3B23.bib` | 08/11/2026 | CNMV (1,091 billones, mercados regulados); Banco de España, cuadro 22.27 |
| Bolsas del mundo (relevancia) | — | 152 billones de dólares a fin de 2025 | WFE, nota del 27/02/2026 | ver `3B23.bib` | 08/11/2026 | **solo la reproducción de la misma nota**: no es independiente |
| Prima de las acciones (I.1.2 y tabla de enigmas) | «más de 6 puntos» sobre la deuda pública, sin fuente | 6,6 puntos sobre letras y 5,5 sobre bonos a 10 años, 1928-2025, media geométrica | Damodaran (2026) | ver `3B23.bib` | 08/11/2026 | recálculo con las 98 rentabilidades anuales; UBS *Yearbook* 2026 (orden de magnitud) |
| Diversificación internacional | 25 % (EE. UU.) y 11,7 %, sin fuente | 27 % y 11,7 % de la varianza de una acción típica | Solnik (1974) | https://doi.org/10.2469/faj.v30.n4.48 | 08/11/2026 | Bennink (2009) y Hanna, McCormack y Perdue (2000) |
| CAPE del S&P 500 (III.1) | sin dato | 40,7 en oct. 2026 (provisional); media desde 1881, 17,8; máximo 44,2 (dic. 1999) | Shiller, *Online Data* | https://shillerdata.com/ | 08/11/2026 | Multpl (40,60 en oct. 2026) |
| S&P 500 para el análisis técnico (III.2) | gráficos de webs | serie diaria ene. 2025-5 nov. 2026, MM50 y MM200; resistencia de 6.980 rota el 15/4/2026 | S&P DJI vía FRED | https://fred.stlouisfed.org/series/SP500 | 08/11/2026 | media de oct. 2026 frente al fichero de Shiller (0,05 %) |
| Dividendos en EE. UU. | «por lo menos hasta ahora» tributan más | hasta 2003 | IRS, *Topic 404* | https://www.irs.gov/taxtopics/tc404 | 08/11/2026 | Jobs and Growth Tax Relief Reconciliation Act (2003) |

Datos de las propuestas que **no** se han usado: el porcentaje del SPIVA
(79 %; la fuente devolvió 403 y no hay segunda comprobación, V4); la
Morningstar de 2023 (fuente secundaria); y, del informe de BME, las
ampliaciones de capital (11.015 millones), los dividendos (42.600 millones),
la propiedad de las acciones (48,7 % extranjeros), la volatilidad del IBEX
(16,2 %) y el PER de la bolsa española (13 veces), que leyó la fase de contenido pero que no tienen segunda
comprobación (C3, C9). Comín (2014) sale de la bibliografía: no apoya ningún
dato del tema.

## Contenido añadido

- **Introducción**: enganche nuevo con el 52 % de fondos indexados (K7);
  relevancia con datos (K9, V5, V6); definiciones de inversión y de las 3
  familias de activos (K8, C2); contextualización en hitos que anuncian los
  apartados, con los Nobel de 1990, 2013 y 2017 y Modigliani (1985) (K9, K23);
  problemática y estructura, que estaba vacía (K10); esquema; nota del
  reparto del cante y de la pizarra; caja de notación.
- **I.1** (primer epígrafe del título, el más flojo del Word, P51): acción
  según la LSC (art. 91), tabla de 5 diferencias con la renta fija, derechos
  mínimos del accionista (art. 93), mercados primario y secundario (BME,
  SIX, CNMV, Ley 6/2023), rentabilidad de una acción (sube del anexo 2) y los
  3 enfoques de análisis (K5, C7, C9).
- **Markowitz**: coherencia de la media y la varianza con la utilidad
  esperada (K13), fórmula de 2 activos y peso de la cartera sin riesgo con
  correlación $-1$, contribución marginal de un activo al riesgo de la
  cartera, sensibilidad a los errores de estimación (Michaud, 1989) (C13,
  C15, C16).
- **Tobin**: CAL, ratio de Sharpe, cartera de tangencia frente a cartera de
  mercado, peso óptimo $w^*$ con aversión $a$ en nota (C17).
- **Sharpe**: $3n+2$ parámetros frente a $n(n+3)/2$; diversificación
  internacional con Solnik y el sesgo doméstico (C18, C20, V7); modelo
  estadístico frente a modelo de equilibrio (C21).
- **CAPM**: derivación por la contribución marginal al riesgo de $M$ (K17);
  extensiones nuevas (beta cero, ICAPM, C-CAPM con el enigma de la prima,
  `\vertema{3.A.33}`) (K18, C35); evidencia con Black, Jensen y Scholes
  (1972), Fama y MacBeth (1973), Fama y French (1992, 2004), Jagannathan y
  Wang (1996), Bartholdy y Peare (2005), Fernández (2015) y Graham y Harvey
  (2001) (C32); Jensen (1968) con sus 115 fondos; ajuste de Blume y beta de
  Hamada (C34); crítica de Roll con Shanken (1987) y Rubio (1986) (C33).
- **APT**: supuestos de Ross, ecuación de valoración como función clave,
  Chen, Roll y Ross (1986), Fama y French en excesos, *momentum*
  (Jegadeesh y Titman, 1993; Carhart, 1997) y 5 factores (2015) (C36-C39).
- **III**: Gordon-Shapiro y PER teórico con $r_E$ de la SML (el puente
  entre los 2 bloques del título); métodos estáticos; PER y EV/EBIT con el
  criterio para elegir; CAPE con el dato de octubre de 2026; teoría de Dow;
  ejemplo real de soporte, resistencia y cruces de medias en el S&P 500;
  evidencia del análisis técnico (Brock, Lakonishok y LeBaron, 1992;
  Sullivan, Timmermann y White, 1999; Lo, Mamaysky y Wang, 2000) (K27-K29,
  C49-C53, V2, V8).
- **Conclusión**: relevancia, extensiones y opinión, que estaban vacías; la
  idea final retoma el refrán del enganche y la de Víctor (canalizar el
  ahorro) (K11, C55).
- **Anexos**: A (tipos e instrumentos, LSC); B (límite de la diversificación,
  CML como recta, derivación del CAPM de Sharpe, APT con un factor, CML
  frente a SML), todos con `\findemo`; C (interés abierto, velas, RSI, fuerza
  relativa, *put-call*, *Barron's*, las 2 posturas); test (fechas, trampas y
  simulador).
- **II**: antecedentes de la HME (Bachelier, Kendall, Samuelson); hipótesis
  conjunta con Fama (2014); Fama (1991); tabla de formas de eficiencia y
  técnicas de gestión activa (K20); exceso de volatilidad, anomalías, límites
  al arbitraje y burbujas (Abreu y Brunnermeier, 2003); sesgos con fuentes y
  tabla de los 4 enigmas con las cifras del 3.A.1 (K21, C47, C48).
- Origen: propuestas de contenido (C1-C48) y de coherencia (K1-K30); de las
  referencias de otros preparadores se ha tomado, redactado de nuevo, la
  derivación del CAPM por la contribución al riesgo de la cartera de mercado
  (de Fuentes) y los determinantes de la beta (Tebar).

## Coherencia

- Notación del canon: rentabilidades en minúscula, $\mathbb{E}[\cdot]$ con
  corchetes, $w_i$ en todo el tema, $\mathrm{corr}(\cdot,\cdot)$ en lugar de
  $\rho$, $\mathrm{Cov}$ y $\mathrm{Var}$ con mayúscula, un solo $\alpha_i$
  (modelo de índice en excesos = alfa de Jensen), $\lambda_M$, y en la APT
  $F_j$, $\beta_{ij}$, $\lambda_j$ con $J$ factores (K12). Lo que el canon
  aún no recoge está en `_trabajo/canon-pendiente.md`.
- Etiquetas `sec:markowitz` y `sec:emh` como las usa el 3.B.4.
- **Prima de las acciones**: el 3.B.23 pone 6,6 puntos sobre letras con la
  hoja actual de Damodaran; el 3.A.1 (y la caja del 3.A.10) dicen 6,7 con la
  misma clave. Corregir el 3.A.1 a 6,6 (anotado en `canon-pendiente.md`, punto
  12).
- Remisiones corregidas: descuento hiperbólico al 3.A.1 (no al 3.A.29);
  nuevas a 3.A.1, 3.A.6, 3.A.21, 3.A.33, 3.A.34, 3.A.37, 3.B.13, 3.B.27 y
  4.A.20 (K30).
- Contradicciones con otros temas (no se tocan): el 3.B.24 y el 3.B.25 tienen
  el mismo enganche del ahorrador y la empresa; el 3.B.13 copia el bloque de
  eficiencia con los mismos errores («posesiones capitales», CAPM «por
  arbitraje»); el 3.B.2 y el 3.B.3 escriben el CAPM sin esperanza y con $k$;
  el 3.A.6 cita a Fama (1970) sin `\vertema{3.B.23}`; la pegatina de los
  huevos y la cesta es también la de Tobin en el 3.A.35 (D5). Detalle en
  `_trabajo/propuestas-coherencia.md`, «Contradicciones con otros temas».

## Comentarios de Víctor (11/11/2026, 4.ª tanda)

| Comentario | Cómo se ha aplicado |
|---|---|
| Reglas generales del 11/11 (pizarra, títulos) | Quitadas o reescritas 7 indicaciones de pizarra o de caja («se borra», «recuadrada en la esquina», «(caja gris)»…) en el texto del tema, conservando tiempos y orden del cante; su contenido va a «Instrucciones para el vídeo». Títulos largos (PDF actual): I: corte tras «renta variable,» (antes, «la elección / de cartera»); anexo A: corte antes de «y otros», con `\cortetitulo`. Sin `c_K` en el tema. |

## Dudas abiertas

El artifact de dudas no estaba disponible en esta sesión: en cada duda se ha
aplicado la opción recomendada, y Víctor puede cambiarla.

- **D1** (orden): **aplicada la recomendada**, el orden de Víctor
  (fundamental al final, junto al técnico, como herramienta de la gestión
  activa; la introducción lo explica). Alternativa: el orden del título
  (fundamental en I).
- **D2** (bloque 0): **aplicada la recomendada**, el bloque 0 es I.1, con
  pizarra. Alternativa: llevarlo a la introducción.
- **D3** (Joan Robinson): **no se usa** (reservada). Encajaría en la
  valoración de la APT, tras la multiplicación de factores.
- **D4** (múltiplos): **aplicada la recomendada**: aquí solo el PER y el
  EV/EBIT; el esquema de Vernimmen y la tabla de ventajas e inconvenientes,
  en el 3.B.4.
- **D5** (dicho): **aplicada la recomendada**: «no poner todos los huevos
  en la misma cesta» se reutiliza para Markowitz (en el 3.A.35 es de Tobin),
  como «Cada loco con su tema».
- **Machado**: «todo necio confunde valor y precio» no se ha podido
  localizar en *Proverbios y cantares*; se atribuye de forma prudente («en
  palabras que suelen atribuirse a Antonio Machado»). Si Víctor tiene la
  fuente, se puede afirmar; si prefiere, otra dicho.
- **Fuentes de III**: la página 390 de Vernimmen (se cita la obra sin
  página); el manual de Pablo Fernández que citaba la nota al opositor
  («Valoración de empresas y sensatez») no se cita: los métodos se apoyan en
  Mascareñas, Vernimmen y Badenes y Santos (1999).
- Sin comprobar en la fuente: la obra y la página de Duffie con los 3 sentidos
  de la eficiencia (se cita su *Dynamic Asset Pricing Theory*, 3.ª ed., como
  en el original); el 3 % y el 5 % de Bartholdy y Peare (2005), del resumen
  del artículo; «casi 3 de cada 4» directores financieros de Graham y Harvey
  (2001, el 73,5 % según la fase de contenido); el periodo de los datos de
  Solnik.
- No hay CSV del CAPE de Shiller: el gráfico `fig:cape` que sugería la fase
  de coherencia no se pide (el dato de octubre de 2026 sí va en el texto).
- Artículos de la LSC: en el anexo A solo se citan los arts. 59.2 y 98-103;
  los de las rescatables y la representación de las cotizadas (500-501 y
  496, según la fase de contenido) se dicen sin número.
- Control de calidad (8/11/2026): Rubio Irigoyen (1986) llama a lo que
  rechaza «modelo de equilibrio de Sharpe y Lintner» (resumen, p. 380, y
  cuadro 2), aunque en la sección 4 estima el CAPM de beta cero; el tema
  dirá solo «el CAPM» para no afirmar más que la fuente. La página 11 del PDF
  queda medio vacía porque el gráfico 3 no cabe tras su párrafo: se acepta el
  hueco (CRITERIOS §2). Desde esta red no se han podido abrir FRED (sin
  respuesta) ni la página del ICI (403 por bloqueo de robots); el fichero de
  Damodaran (6,6) no se ha recalculado en el control.
  Aplicadas por el coordinador las 4 correcciones del control (Rubio, «el CAPM»;
  `Markowitz, Harry M.` unificado en el .bib; espacio normal en el pie del
  gráfico del S\&P 500, que dejaba un carácter roto en el texto alternativo;
  rótulo «frontera eficiente» en `cml`). Reconstruido: 0 errores.

## Enlaces del original (9/11/2026)

- **Restaurados** (todos con `\href`):
  - Wikipedia, «Markowitz model»: en el `\fuente` del gráfico de la frontera eficiente (era la fuente de la imagen del original).
  - Economipedia, «Riesgo sistemático»: en el `\fuente` del gráfico del riesgo y el número de títulos.
  - Comparativa de Bancos, «Soportes, resistencias y falsas rupturas», y Admirals, «Qué son las medias móviles en trading» (`admiralmarkets.com/es/…/media-movil-simple`): en el `\fuente` del esquema de soporte, resistencia y media móvil.
  - Wikipedia («Roll's critique») e Investopedia («Roll's Critique»): nota al pie de la crítica de Roll (el original los tenía en una nota y en un comentario).
  - Economipedia y Admirals no dejan comprobarlos con un robot (403); existen según el buscador.
- **No restaurado**: Análisis técnico street, «Gráfico de velas japonesas» (pie de una imagen del anexo de indicadores): el dominio ya no responde y el buscador no lo encuentra.

## Instrucciones para el vídeo

- *Pizarra (sacado del texto del tema el 11/11/2026)*: 3 columnas en I; la SML recuadrada pasa a la esquina; tabla de eficiencia que sigue en III.

- **Enganche e idea final**: «Nadie da nada por nada» y el 52 % de fondos
  indexados; vuelve en la APT (no arbitraje) y en la idea final. Introducción
  y conclusión sin pizarra, con el refrán apuntado en una esquina.
- **Bloque I, pizarra en 3 columnas** (`rejilla: "30|40|30"`):
  - izquierda: la tabla mínima de renta fija y variable (5 filas × 2
    columnas), la \eqref{eq:rentabilidad-accion} y, debajo, la varianza de la
    cartera recuadrada (`\funcionclave`), que se conserva todo el bloque;
  - centro: el gráfico `markowitz` por capas (frontera, MVG, curvas de los 2
    inversores, tangencias) con el dicho de los huevos y las gallinas; sin
    borrar, sobre él se dibuja `cml` (r_f, una CAL, la tangente, T = M,
    prestar y endeudarse). No se
    escribe dos veces la frontera: el gráfico conjunto se construye por
    partes;
  - derecha: `diversificacion` y la \eqref{eq:riesgo-sistematico};
  - `correlaciones` solo si va sobrado de tiempo (si no, de palabra);
    `diversificacion-internacional` y `triangulo-riesgo` son de apoyo.
- **I.3**: se borra el centro y se dibuja `sml` por capas (r_f, recta, M,
  pendiente, A con α > 0 y B con α < 0), con «cuando llueve, todos se
  mojan»; la SML recuadrada (`\funcionclave`) pasa a la esquina superior
  derecha y se **conserva hasta el final** (el bloque III la usa para $r_E$);
  la ecuación de la APT recuadrada en una línea debajo, señalando que con un
  factor es la SML. La tabla CAPM-APT y la caja de la beta, de apoyo.
- **Bloque II**: en el centro, la tabla de formas de eficiencia (3 filas),
  con «a buenas horas, mangas verdes»; se **conserva** para el bloque III. La
  primera fila de la tabla de enigmas, de palabra o como apoyo.
- **Bloque III** (rejilla de 2 columnas, con la SML en la esquina y la tabla
  de eficiencia conservadas): a la izquierda, \eqref{eq:gordon} y
  \eqref{eq:per-teorico} con una flecha desde la SML (de ahí sale $r_E$), con
  «todo necio confunde valor y precio» (dicho atribuido a Machado; en el
  vídeo, sin afirmar la obra); el PER, el EV/EBIT y el CAPE, de palabra. A la
  derecha, `soporte-resistencia` por capas (serie, soporte, resistencia,
  ruptura, media móvil); en la tabla de eficiencia se
  marca qué forma desafía cada análisis (técnico, la débil; fundamental, la
  semifuerte). `sp500-soporte-medias` es de apoyo; `velas` y `cml-sml`, de
  los anexos, no salen.
- Funciones clave que se conservan: la varianza de la cartera (bloque I), la
  SML (hasta el final) y la APT (hasta el final del bloque I).
- Al terminar, la pizarra queda con la SML, la tabla de eficiencia, Gordon y
  el esquema técnico: el recorrido del tema de un vistazo.

## Revisión transversal (13/11/2026)

- **Nobel añadidos o completados**: Tobin (1981), en su primera mención ($q$ de Tobin); Friedman (1976), en la nota de la tesis de Markowitz; Modigliani (1985) con su motivo; Thaler (2017) con su motivo y su cita; Koopmans (1975, con Kantoróvich) con su motivo; Kahneman (2002) en la teoría de las perspectivas; Stiglitz (2001) en la paradoja de Grossman y Stiglitz; Robert Merton (1997) en el anexo de fechas. Ya estaban Markowitz-Miller-Sharpe (1990) y Fama-Hansen-Shiller (2013).
- **4.º ejercicio**: sin cambios; ya remite a \vertema{4.A.20} (mercados de valores en España).
- **Dichos**: se conservan «nadie da nada por nada» (enganche, APT y cierre), «no poner todos los huevos en la misma cesta» (del temario antiguo), «cuando llueve, todos se mojan» (riesgo sistemático) y «a buenas horas, mangas verdes» (eficiencia), más la cita «todo necio confunde valor y precio». Se quitan «todos los caminos llevan a Roma» (separación de Tobin: forzado) y «quien tuvo, retuvo» (memoria del mercado: el refrán significa otra cosa), en el tema, la ficha y las instrucciones del vídeo.
