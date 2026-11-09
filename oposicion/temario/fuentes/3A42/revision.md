# Revisión del tema 3.A.42 (4/11/2026)

Teorías de los ciclos económicos: ciclos nominales y reales. Referencia al ciclo financiero y sus interrelaciones con el ciclo real.

Revisión autónoma (Víctor fuera del 31/10 al 9/11/2026): las dudas llevan aplicada la opción recomendada y se anotan como **A42-NN** en «Dudas abiertas». Integración en 2 partes: la parte 1 escribió el preámbulo, la introducción, el esquema, la nota del reparto y el bloque I (más el `.bib`, `seo.json` y todos los gráficos pedidos); la parte 2, los bloques II y III, la conclusión y los anexos.

## 1. Resumen

- Fuente nueva en LaTeX (`3A42.tex`). El Word era el del antiguo 3.A.41 (5 apartados, 0-3, sin ciclo financiero). Estructura final de la coherencia (K19, A42-02): **I** = apartados 0 y 1 del original (medición, hechos y perspectiva histórica), **II** = apartados 2 y 3 (ciclo real y ciclos nominales), **III** nuevo (ciclo financiero). Minutos: 2′30″ + 8′ + 11′30″ + 7′ + 1′ = 30′.
- Título oficial comprobado en el BOE de la convocatoria vigente (BOE-A-2025-26902): «**Referencia al** ciclo financiero…», como `temario.json` (V1, C2, K1). La nota del Word y el título de Tebar copiaban el borrador de 2023.
- Introducción nueva: refrán «Siempre que llovió, escampó» con España 2008-2016 frente a 2020-2022 y el dato de hoy (2026T3, +2,7 % interanual; ningún comité de fechado ve recesión); los 5 bloques; la clasificación endógeno/exógeno, real/nominal y el ciclo financiero como tercer plano (K2).
- Bloque I: definición de Burns y Mitchell; datación con los 3 comités (NBER, CEPR, AEE), Bry-Boschan y Harding-Pagan, PMI y ESI; tendencia determinista y estocástica (Nelson y Plosser), función de producción de la Comisión, filtro HP con λ discrecional (1600 frente a 400 000) y sus problemas, paso banda de 6 a 32 trimestres; caja de variables no observables (Y^p, y^n_t, r^n_t, Laubach y Williams); tabla de hechos estilizados **con datos propios** de España, la zona del euro y EE. UU. (1995-2019), con la aclaración del empleo frente a las horas; Gran Moderación con fuentes; las 4 etapas de la historia con el **multiplicador-acelerador de Samuelson y Hicks desarrollado** (función clave, raíces, condiciones, regiones, ejemplo numérico, techo y suelo), el ciclo endógeno (Kalecki, Kaldor, Goodwin) en resumen y el ciclo político.
- Bloque II: el ciclo real como tema de referencia (presentación del 3.A.6 ampliada: problema del hogar con `\optim`, ecuaciones `eq:rbc-*`, recuento de variables, tabla transitoria/permanente corregida, McCallum como función clave `eq:mccallum` con $s=\alpha\beta$ como resultado, a)-e) completo con extensiones —trabajo indivisible, gasto público, impuestos de McGrattan, varios sectores, dinero— y evidencia con `tab:calibracion`); nota con la tendencia ($A_t=A_0e^{g^At+\tilde A_t}$, $g^A=(1-\alpha)g$) para lo que pide el 3.A.43. Ciclos nominales: *plucking model* (Friedman, 1964 y 1993; Dupraz, Nakamura y Steinsson, 2025), Lucas (1972) en resumen, evidencia de que el dinero importa, y el modelo canónico de la NEK en resumen con la notación del 3.A.7 (`nek-xpi` y `nek-esquema` copiados), divina coincidencia con su atribución fija, Blanchard y Galí (2007 y 2010), Smets y Wouters como antecedente del NAWM II, caja HANK.
- Bloque III (nuevo): concepto (Borio, 2014), hechos (unos 16 años; 8-30 años en el filtro; picos en crisis), brecha crédito-PIB y colchón anticíclico con datos de España (BIS: +47,3 en 2007T2, −55,6 en 2017T4, −24,3 en 2026T1; colchón del 1 % desde el 1/10/2026), ciclo financiero de España (elaboración propia con el método DBT); Fisher, Minsky y Kindleberger; acelerador financiero de BGG como función clave `eq:bgg` con estructura a)-e), Kiyotaki y Moore, bancos (Gertler y Karadi; Gertler y Kiyotaki; Cúrdia y Woodford; Sims y Wu), EREMS en una línea, evidencia (Schularick y Taylor, Jordà-Schularick-Taylor, Mian-Sufi-Verner, Reinhart y Rogoff, Cerra y Saxena), macroprudencial y *leaning* frente a *cleaning*. Cierra con la tabla hilo conductor `tab:teorias-ciclo` (7 teorías × origen, propagación, persistencia, ¿estabilizar?).
- Conclusión con sus 5 bloques (Relevancia y Opinión, vacías en el Word, rellenas); idea final que vuelve a «Siempre que llovió, escampó» y la matiza con la histéresis; nota al opositor con las 3 preguntas de reflexión del Word.
- Anexos: A historia (anexos 1-2 del Word redactados de nuevo, sin perder autores), B ciclo real paso a paso (del 3.A.6, con el *time to build* y la evidencia de no neutralidad, San Luis corregida), C filtros (HP, una cola, Hamilton, paso banda), D Kaldor y Goodwin con sus ecuaciones, E test con el enlace genérico al simulador. Fuera el anexo EREMS (una frase en III.3).
- 20 gráficos pedidos (9 copiados de 1D01, 3.A.6 y 3.A.7; 6 nuevos de teoría; 5 nuevos de datos). En la prueba de la parte 1: compila sin errores ni referencias o citas indefinidas.

## 2. Errores corregidos

| Dónde | Decía | Dice ahora |
|---|---|---|
| Introducción, amarillo (P4) | PIB de España: +2 % (2019), −11,2 % (2020), +6,4 % (2021) | +2,0 %, −10,9 %, +6,7 % (serie revisada del INE; Eurostat igual), y +6,4 % en 2022 (V2) |
| Nota 3 (Lucas, 1977) | «no hay ninguna lógica teórica para anticipar los ciclos» | No hay razón teórica para *esperar* que todos se parezcan; «los ciclos son todos iguales» (C5) |
| 0.1 | Burns y Mitchell, «los econometristas», empezaron «en la década de 1930» | Economistas empíricos del NBER, desde los años 20; la definición toma una de Mitchell (1927) (V7, C9) |
| Nota 9 (P49) | Juglar de 3-5 años; Kuznets 16-22; Kondratieff 50 | Juglar 7-11; Kitchin unos 40 meses; Kuznets 15-25; Kondratieff unos 50; nombres de Schumpeter (1939) (V20) |
| Nota 12 | «propiedades» del filtro HP (un valle seguido de un pico…) | Son las reglas de fechado de Bry y Boschan (1971) y Harding y Pagan (2002) (C10) |
| Anexo 3 / 0.2.1 | «la elección de λ es aleatoria» | Discrecional; razón de Hodrick y Prescott (5 % frente a 1/8 de punto: λ = 1600); Ravn y Uhlig para otras frecuencias (C11, V18) |
| Anexo 3 | paso banda «entre 6 y 32 cuatrimestres» | 6 a 32 **trimestres** (Baxter y King, 1999; V19) |
| 0.2.2 (P57) | «El empleo es más volátil que el producto» | Similar o algo menor (Stock y Watson, 1999; decisión del 24/10), con los datos: 0,53 en la zona del euro, 1,07 en EE. UU., 1,22 en España (más volátil por la temporalidad); horas frente a personas y antes/después de 1984 (K16, V13) |
| 0.2.2 (P58) | Gasto público más volátil en EE. UU. «por las guerras» | Consumo público: más volátil en EE. UU. (1,21) pero contracíclico; casi acíclico en la zona del euro; procíclico en España (V12) |
| 0.2.2 | correlaciones con ρ | `corr(·,·)` (ρ es la tasa de descuento y ρ_A la persistencia de la PTF) |
| 1.1 (P51) | *general glut* 1819-1821, «Malthus a la cabeza» | 1819-1824, Sismondi (1819), Malthus (1820) y Say (1820), como el 3.A.2 |
| 1.2 a) y nota 23 (P50) | Manchas solares de Jevons enlazadas a los «equilibrios de manchas solares» | Jevons en sentido literal; los *sunspot equilibria* (Azariadis, 1981; Cass y Shell, 1983) en nota aparte, con `\vertema{3.A.3}` |
| 1.2 c) | acelerador de Clark (1934) | Clark (1917) (C15) |
| 1.2 f) | enlace a Wiktionary en el nombre de Slutsky | Fuera |
| 1.3 a) | Duesenberry (1949) unió ciclo y crecimiento | Duesenberry (1958), *Business Cycles and Economic Growth* (el de 1949 es la renta relativa) (C15) |
| 1.3 a) | «*Oxbridge*» como nombre del programa keynesiano | Fuera (sin fuente) |
| 1.3 b) (P52) | Goodwin (1951) como ciclo de lucha de clases | Goodwin (1967), «A Growth Cycle»; el de 1951 es el acelerador no lineal (K5) |
| 1.4 (K6) | «modelo de Lucas-Phelps» | Modelo de información imperfecta de Lucas (1972) |
| Introducción (P48) | «Benhavid y Nishimura»; nota 84 «Benhavid y Galí» | Benhabib y Nishimura (1979, 1985), con Grandmont (1985) y Farmer (2010) (V33) |
| Nota 31 (Lucas, 1976) | cita entrecomillada sin página | Paráfrasis sin comillas (página sin comprobar) |
| Imagen 1 | Gráfico de un vídeo de la UNED | `ciclo-tendencia` de la guía del dictamen (copiado) |

## 3. Marcas resueltas

| Marca (P) | Texto original | Qué se hizo |
|---|---|---|
| P3, amarillo (l. 48) | Idea alternativa: «En el largo plazo todos muertos» (Keynes) | No se usa: es el enganche del 3.A.4. Enganche nuevo con refrán (A42-04) |
| P4, amarillo (l. 52) | PIB de España 2019-2021 | Corregido y llevado a 2026T3 en el enganche (V2) |
| P9, comentario (l. 55-84) | Cita de Bernanke («If you want to understand geology…») y una introducción alternativa sobre el crecimiento | La cita, en la relevancia, con su fuente real: la cuenta Gertler en *The Wall Street Journal* (Ip, 2005), solo la frase de la geología entre comillas (V5). Lo del crecimiento es del 3.A.43: fuera |
| P5, amarillo (l. 234) | «Fuente: […]» de la Imagen 2 | La Imagen 2 (HP de EE. UU.) y la 3 (UE, «ICEX-CECO») se sustituyen por `filtro-hp-espana`, con datos de Eurostat y cálculo propio |
| P15, notas al opositor (l. 1-15) | Aviso del cambio de temario y captura del título | Fuera; el encargo se cumple con el bloque III |
| P16, nota (l. 162) | «Aunque sea apartado 0, conviene dedicar el mismo tiempo que al 1» | Fuera; recogido en el reparto (I.1-I.3, 4′30″; I.4, 3′30″) |
| P17, nota (l. 374) | «Este apartado es candidato a recortar… Sintetizar» | Fuera; I.4.1 y I.4.2 resumidos y desarrollados en el anexo A |
| P10, comentario (l. 484) | Desarrollar las teorías keynesianas (y las «de Juan Luis») | Hecho: multiplicador-acelerador desarrollado, Kalecki-Kaldor-Goodwin en resumen; el *plucking model* y Lucas van en II.2 (parte 2); Minsky y los austriacos en III.2 (parte 2) y en nota de I.4.2. El nombre del preparador no se publica |
| Caja de anotaciones (l. 20, L1) | *The Economist*, 19/4/2018 | Se conserva tras la introducción (403 a robots, pero el título y la fecha coinciden con la URL) |
| Caja de anotaciones (l. 200-204, L2) | *The Conversation* (francés), 22/6/2021 | Se conserva en la caja de I.2.1 (enlace activo) |
| Pie de la Imagen 1 (L6) | Vídeo de la UNED | Fuera con la imagen |
| Pie de la Imagen 4 | Tabla del BdE (DO 2103) como imagen | Sustituida por `tab:hechos-ciclo` con datos propios; el DO se cita para España y como segunda comprobación (V15) |
| Notas al pie de I | — | Se mantienen, reescritas: 6 (términos), 8 (definición, traducida de nuevo), 9 (corregida), 11 (TRAMO-SEATS), 15 (no duraderos), 21-22 (Lowe; precios frente a producción), 24-25 (Spiethoff y Robertson), 26 (austriaca, según la ficha `escuela-austriaca`), 28 (Harrod, 1939). La 2 (gráfico de EE. UU.) se cubre con `filtro-hp-espana`; la 3 pasa a la relevancia; la 10 (NBER en inglés) se resume en el texto; la 13 (indicadores de confianza) se integra con el PMI y el ESI; la 16 (productividad de España) pasa al texto con el DO 2103; la 17 (cita de Say) se sustituye por la remisión al 3.A.2; la 23 se quita (error); 29-30 van a la valoración del multiplicador-acelerador; 31-34 se integran en I.4.4 |
| P6-P8, amarillos (regla de Taylor) | Tres «[…]» tras el tipo pasado, la inflación y el *output gap* | Nota al pie de `eq:taylor`: suavización con ν, principio de Taylor φ_π > 1, φ_x ≥ 0; regla canónica en el cuerpo (C28) |
| P11, P12, P14 (comentarios) | Coordinar con el 3.A.6, 3.A.7, 3.A.29, 3.A.36, 3.A.37 (y «el tema de Juan Luis») | Fuera; resuelto con las fichas `rbc` y `nek-3-ecuaciones` |
| P13 (comentario) | «A partir de aquí, está sacado del tema de ICEX-CECO» | Fuera; calibración, limitaciones y neutralidad reescritas con fuentes primarias |
| P18, P33, P37, P39, P40a | Figuras de Romer, Imagen 5 duplicada, figura de ICEX-CECO, 4 de Salazar | Sustituidas por `irf-rbc`, `irf-rbc-completo`, `persistencia-mccallum` (3.A.6); el gasto público, en mención con `\vertema{3.A.38}` |
| P19 (nota) | «Pensar cómo reestructurar para no repetirse» | Hecho: un solo bloque a)-e) del ciclo real y una síntesis en II.1.3 |
| P20 (nota y captura) | Sims y Wu (2019), con 4 ecuaciones de aspecto generado | Fuera la nota y la captura; mención en III.3 c) de Sims y Wu (2019) y Sims, Wu y Zhang (2023), cuarta ecuación = compras de activos |
| P23 (caja) | 9 vídeos de Everything Econ, el primero duplicado | Se conservan 8 en una caja de II.1.1 |
| P24 (caja) | Vídeo de Galí | Se conserva en II.2.2 |
| P25 (caja HANK) | 5 párrafos sin fuente | Reescrita en 3 líneas con Kaplan, Moll y Violante (2018) |
| P34 (tabla) | Perturbación permanente/temporal con «inventarios» y la inversión «invariante» | `tab:permanente-transitoria` corregida (C24) |
| P35-P38 | Tablas de equilibrio, persistencia y Hansen y Wright | `tab:equilibrio-rbc` (anexo B), persistencia en `eq:mccallum`, `tab:calibracion` con la última fila corregida (horas y productividad) |
| P40b | Imagen 11 (esquema i-x-π con δ) | `nek-esquema` del 3.A.7 |
| P40d, P40e | Imágenes 12 y 13 | `filtro-hp-espana` (cuerpo) y `hp-paso-banda` (anexo C), con datos propios |
| P40f, P78 | Anexo 4 (EREMS) con captura y observatorio de 2023 | Fuera; una frase en III.3 c) con la edición de octubre de 2026 |
| P76 | «Preguntas de otros exámenes» vacío, quia.com, Relevancia y Opinión vacías | Enlace genérico al simulador; conclusión completa |
| Notas al pie de II-III | — | Se mantienen o se integran según C46: Buiter (*castration*) en II.1.1; Cooley y Hansen y otras perturbaciones en c); nota 47 (*time to build*) en el anexo B; 53 (ahorro «constante») fuera por error; 54 (Lucas y los terremotos de Obstfeld y Rogoff) fuera: en su lugar Fisher (1933, § 17) y Bernanke (1995); 62 corregida (Hall, 1988, y 1/θ); 64 corregida (NAWM II); 76 corregida (Blanchard y Galí, 2010); 83 (Minsky) al cuerpo de III.2; 84 corregida en nota de I.4.3; 85 (Petty) en el anexo A; 86 y 87 fuera |

## 4. Datos actualizados

| Dato | Antes | Ahora | Fuente (consulta 4/11/2026) |
|---|---|---|---|
| Enganche | Informe Anual 2022 del BdE | PIB de España 2019-2022, 2025 y 2026T3; caída de 2008-2013 (−8,9 %) y recuperación en 2016T4; caída de 2020 y recuperación en 2022T2; ningún comité ve recesión | INE CNTR (`INE2026CNTRVolumen`, `INE2026avCNTR3T26`); NBER, CEPR-EABCN, AEE (V2, V3, V8-V10). Recuperaciones: cálculo propio con la serie del INE y la de Eurostat (coinciden) |
| Fechado | Solo el NBER, con la FAQ en inglés | NBER (medias de 10 y 64 meses; febrero-abril de 2020), CEPR (6 recesiones desde 1970) y AEE (6 recesiones; 10 trimestres en 2011-2013) | V8-V10. La tabla del CEPR solo se pudo leer a través del buscador (bloquea robots): conviene que Víctor la abra una vez |
| Hechos estilizados | Cualitativos, con la tabla del DO 2103 como imagen | Tabla de España, zona del euro y EE. UU., 1995-2019, con volatilidad relativa, correlación y persistencia; una línea sobre la pandemia | Cálculo propio con Eurostat y FRED; segunda comprobación con el DO 2103 y statsmodels (V11-V15) |
| Ciclo de España con HP | — | +3,1 % en 2008 con λ = 1600 y +10,1 % con λ = 400 000; +5,0 % a finales de 2019 | V16-V17 |
| Gran Moderación | Sin fuentes | Kim y Nelson (1999), McConnell y Pérez-Quirós (2000), Stock y Watson (2002), Bernanke (2004); Lucas (2003) | C13, V28 |
| Petty | «*Treaties on Taxes*» | *A Treatise of Taxes and Contributions* (1662), sin página | V21 |
| Brecha crédito-PIB de España | — | +47,3 pp (2007T2), −55,6 (2017T4), −24,3 (2026T1); ratio 233,8 % en 2010T2 y 119,4 % en 2026T1 | BIS, Credit-to-GDP gaps (V39) |
| Colchón anticíclico | — | 0,5 % desde 10/2025 y 1 % desde el 1/10/2026, con el marco de 2024 (positivo en riesgo «estándar») | BOE-A-2025-19516 y BdE (V40). Ojo: la web del BdE aún no estaba actualizada |
| Ciclo financiero de España | — | Picos en 1991T2 y 2008T4; en 2009T2, con el PIB en su valle, aún cerca de su máximo | Elaboración propia, método DBT (V38); sin serie oficial con la que cuadrarla |
| Duración del ciclo financiero | «16-20 años» (propuestas) | Unos 16 años de media; filtro de 8 a 30 años | Borio (2014), DBT (2012) (V36-V37) |
| Prescott (1986) | «hasta el 75 %» | «más de la mitad», mejor estimación cercana al 75 % (V26) | `Prescott1986Response` |
| Ecuación de San Luis | PIB real sobre M2, efecto de 0,25 | PNB nominal sobre M1, unos 5,8 dólares por dólar | Andersen y Jordan (1968), como el 3.A.6 |
| Sims y Wu (2019) | Sin fecha de publicación | DT del NBER de 2019 y Sims, Wu y Zhang (2023, *REStat*) (V32) | — |
| Smets y Wouters (2003) | «modelo base del BCE» | Antecedente del NAWM II (V27) | `CoenenEtAl2018NAWM` |
| Observatorio BBVA Research-Fedea | Edición de 27/4/2023 | Edición de 20/10/2026 (V43) | `BoscaEtAl2026Observatorio` |

## 5. Contenido añadido

- Introducción: los 5 bloques completos; la clasificación de las teorías con el ciclo financiero (K2); la relevancia con Lucas (1977), Bernanke (vía Gertler), Reinhart y Rogoff (2009) y Blanchard (2009).
- I.2.1: comités del CEPR y de la AEE; Bry-Boschan y Harding-Pagan; PMI y ESI (lo pide la 1D01); Nelson y Plosser (lo pide el 3.A.6); función de producción de la Comisión en una línea (lo piden el 3.A.28 y el 4.B.4); HP con su problema de optimización (`eq:hp`), el porqué de λ = 1600, λ = 400 000 del crédito y los 3 problemas (Hamilton, 2018); brecha $\mathrm{OG}_t$ con $Y^p$; caja de variables no observables (lo piden el 3.A.7 y el 3.A.36).
- I.2.2: persistencia como 4.º rasgo; vivienda adelantada, existencias, bolsa y curva de tipos; tabla con datos de 3 economías; España (empleo, consumo, productividad y consumo público).
- I.4.3: el **multiplicador-acelerador desarrollado** con la estructura a)-d) (idea, modelo con supuestos/desarrollo/implicaciones, extensiones, valoración), la ecuación de Samuelson como función clave con la $v$ del 3.A.34, raíces $z_1$, $z_2$, condiciones $c(1+v)^2<4v$ y $cv<1$, ejemplo numérico comprobado y la nota que lo reconcilia con el multiplicador de impacto $1/(1-c-v)$ del 3.A.34 (X4); el techo y el suelo de Hicks; Metzler, Goodwin (1951), Duesenberry y Pasinetti. El ciclo endógeno (Kalecki, Kaldor, Goodwin 1967) en resumen, con remisión al anexo D; los ciclos endógenos modernos en nota. El ciclo político de Nordhaus en mención (lo pide el 4.B.2).
- I.4.4: la cuarta etapa ordenada en 3 pasos (Lucas, 1972; ciclo real; NEK con la evidencia de los VAR), que anuncia el bloque II.
- II.1: recuento de variables, tabla transitoria/permanente corregida, McCallum como función clave, extensiones (gasto público para el 3.A.38, impuestos de McGrattan), residuo de Solow con datos de Fernald, críticas con Fisher (1933, § 17) y Bernanke (1995), síntesis origen-propagación-persistencia.
- II.2: *plucking model* (lo pide el 3.A.5), Lucas (1972) en resumen con la oferta del 3.A.6, la evidencia de no neutralidad, la NEK canónica en resumen, la divina coincidencia bien atribuida, las variables naturales no observables (3.A.7, 3.A.36), el NAWM II y HANK.
- III entero (no estaba): concepto, medición, hechos, España, Fisher, Minsky, Kindleberger, BGG, Kiyotaki-Moore, bancos, EREMS, evidencia, macroprudencial, *leaning* frente a *cleaning*, crisis; `tab:teorias-ciclo`.
- Conclusión completa; anexos A-E.

## 6. Coherencia

- **Remisiones** con `\vertema` en la parte 1: 3.A.2, 3.A.3, 3.A.4, 3.A.6, 3.A.7, 3.A.28, 3.A.33, 3.A.34, 3.A.36, 3.A.43, 3.A.44, 4.B.2, 4.B.4. La 1D01 no se puede enlazar con `\vertema` (no está en `temario.json`): sus 3 gráficos se citan como «gráfico de la guía del dictamen».
- **Lo que otros temas prometen al 3.A.42 y ya se cumple en I**: 1D01 (ciclo y tendencia, HP, hechos con persistencia, PMI y ESI), 3.A.1 (Grandmont, en nota), 3.A.2 (*general glut* 1819-1824 y las 3 crisis de Marx, con sus mismas palabras), 3.A.3 (Jevons frente a los *sunspot equilibria*; teoría austriaca), 3.A.6 (Nelson y Plosser), 3.A.7 y 3.A.36 (variables naturales no observables, Laubach y Williams), 3.A.28 (función de producción), 3.A.33 (consumo y duraderos), 3.A.34 (multiplicador-acelerador con su $v$ y su ecuación), 4.B.2 (Nordhaus, 1975). (lo de la parte 2, en la viñeta siguiente)
- **Notación**: $y^p_t$ para la tendencia HP y $\mathrm{OG}_t$ con $Y^p$ (ficha `brecha-produccion`); λ local del filtro, avisado en nota; $\hat x_t$, $\hat y_t$ para los componentes cíclicos (coherente con $\hat y_t$ del ciclo real); `corr(·,·)`; $c$, $v$, $G$, $Y^*$ del acelerador (D009); $z_1$, $z_2$, $A_1$, $A_2$ locales.
- **X3 (empleo)**: la ficha `hechos-estilizados-ciclo` y la 1D01 dicen «similar o algo menor»; la `tab:calibracion` del 3.A.6, 1,68 para las horas de 1984-2019. El tema lo explica (personas frente a horas; antes y después de 1984). Propuesta CC5 para la ficha, pendiente de `tema-canon`.
- **X4 (3.A.34)**: multiplicador de impacto frente a estabilidad de Samuelson, reconciliados en nota.
- **Parte 2**: cumple lo que piden 3.A.4 (Minsky con sus 3 posiciones y la misma pegatina; Kalecki), 3.A.5 (*plucking*, 1964 y 1993), 3.A.25 (Lucas-Rapping con $\varepsilon^F_{L,w}=1/\varphi$; trabajo indivisible), 3.A.26 (Blanchard y Galí, 2010), 3.A.29 (Euler estocástica, Bellman), 3.A.33 (hábitos, ESI 1/θ con Hall, 1988), 3.A.34 (BGG con RN y s(·)), 3.A.36 (tipo natural, Taylor, macroprudencial como primera línea), 3.A.37 (HANK, canal del crédito, bancos), 3.A.38 (RBC base con gasto público y las mismas etiquetas `eq:rbc-*`), 3.A.43 (RCK de partida y nota de la tendencia, X6), 3.A.45 (residuo de Solow). Remisiones nuevas: 3.A.11, 3.A.13, 3.A.22, 3.A.35, 3.A.40, 3.A.41, 3.B.26, 3.B.27.
- **Contradicciones con otros temas** (no se tocan):
  - X1: Keynes («a largo plazo, todos muertos») es el enganche del 3.A.4 y «vacas gordas», el del 3.A.33: no se usan.
  - X3: empleo frente a horas (ficha `hechos-estilizados-ciclo` frente a `tab:calibracion`): explicado en I.2.2; CC5 para `tema-canon`.
  - X5: el 3.A.6 podrá adelgazar su anexo D y remitir al anexo B de aquí (P74).
  - X6: el mapa del 3.A.43 pide «n + g + δ» al 3.A.42; resuelto con la nota de la tendencia (CC10 para el mapa).
  - X7: tema de referencia del acelerador financiero sin decidir (3.A.37, 3.A.34 o 3.A.42); aquí se resume en III.3 con estructura a)-e).
  - X9: el 4.B.4 (sin revisar) remite el filtro HP al «3.A.41» (numeración antigua): es el 3.A.42.
  - X10: el 3.A.37 tiene que remitir aquí el ciclo financiero; el 3.A.38 usar el RBC base de II.1 con las mismas etiquetas.
  - Canon: CC1 (ficha `ciclo-financiero`), CC2 (`multiplicador-acelerador`), CC3 (`ciclos-endogenos`), CC4 (Kiyotaki-Moore en `bernanke-gertler`), CC6-CC9 (HP, brecha de crédito, Nordhaus, notación local de Goodwin y Kaldor) y CC11 (pegatinas) quedan para `tema-canon`.

## 7. Dudas abiertas

| Id | Duda | Aplicado (recomendada) | Alternativa |
|---|---|---|---|
| A42-01 | Título: «Referencia al» o «El» ciclo financiero | «Referencia al»: comprobado en el BOE de 29/12/2025 (V1); queda resuelta | — |
| A42-02 | Estructura en 3 apartados | I = 0 + 1 del original; II = 2 + 3; III nuevo | I = 0; II = 1 + 2 + 3 |
| A42-04 | Enganche | «Siempre que llovió, escampó» con España 2008-2016 frente a 2020-2022 y el dato de 2026T3 (decisión del coordinador; contenido proponía «No hay mal que cien años dure») | «No hay mal que cien años dure»; la cita de Bernanke como enganche (va en la relevancia) |
| A42-05 | Pegatinas del ciclo real y de Minsky | Reutilizadas del 3.A.6 y del 3.A.4 (en la nota del reparto) | Nuevas |
| A42-06 | Ficha propia del multiplicador-acelerador con el 3.A.42 de referencia | Presentación desarrollada en I.4.3 lista para la ficha (CC2) | Alias de `acelerador` |
| A42-09 | Orden en II | El del original (ciclo real antes que nominal), explicado en la estructura | NEK antes que RBC |
| A42-10 | Título de II.2 | «Los ciclos nominales: del monetarismo a la nueva economía keynesiana», porque el coordinador lleva ahí el *plucking model* y Lucas; los 3 títulos de tercer nivel del original (descripción, modelo canónico, resultados) se conservan | «La nueva economía keynesiana: los modelos neokeynesianos» (el del Word) |
| A42-11 | Tabla de hechos estilizados | Una sola tabla con datos de España, zona del euro y EE. UU. (1995-2019) en vez de la cualitativa de la 1D01 con columna de persistencia; lo cualitativo que no tiene dato (vivienda, existencias, precios, tipos, bolsa, curva de tipos) va en viñetas | La tabla cualitativa de la 1D01 ampliada (C12) además de la de datos |
| A42-12 | Kaldor y Goodwin | En el cuerpo, solo de palabra; las ecuaciones (con ω_t, U_t, v, g, n y la velocidad a, locales) en el anexo D | Ecuaciones de Goodwin en el cuerpo (C16) |
| A42-03 | Derivación de la NEK del Word | Resumen sin anexo (la derivación corregida está en el anexo A del 3.A.7) | Anexo con su copia |
| A42-07 | Fichas de Kaldor y Goodwin | Una sola ficha `ciclos-endogenos` (propuesta para `tema-canon`) | Ninguna |
| A42-08 | Tema de referencia de Kiyotaki y Moore | 3.A.42, dentro de `bernanke-gertler` | 3.A.37 |
| A42-13 | Funciones clave | 3: Samuelson, McCallum y BGG (C3); el bloque `eq:rbc-*` en `align` sin recuadro, como el 3.A.6 | Recuadrar también la Euler y la intratemporal (K23) |
| A42-14 | Estructura de III | 3 subapartados de la coherencia; las implicaciones de política (C35, que contenido ponía como III.4) van como bloque final de III.3, tras e) Valoración | III.4 propio (rompe el reparto de 7′) |
| A42-15 | Cifras del Banco de España sobre la brecha ajustada (−30,8 frente a −2,4 en 2025T2, C32) | No se usan: la fase de datos no las comprobó; se usa la brecha del BIS y el colchón del BOE | Incluirlas tras comprobarlas en la resolución del CCA |
| A42-16 | Pegatina de C33 («tanto va el cántaro a la fuente…») | No se usa: el coordinador fijó 5 pegatinas y Minsky lleva la del 3.A.4 | Añadirla a la teoría del ciclo financiero en general |
| A42-17 | Cifras de Reinhart y Rogoff (35 % vivienda, 55 % bolsa, 86 % deuda) | Se usan (comprobadas en contenido con el resumen del NBER WP 14656; la fase de datos no comprobó cifras de esos trabajos) | Quitarlas hasta leer el artículo |
| A42-18 | `tab:calibracion`: σL/σ(Y/L) del modelo estándar de Hansen y Wright | Control de calidad (4/11/2026): el 0,53 del tema es σ(Y/L)/σY; el artículo da **0,94** («σh/σw has increased from 0.94», p. 10 del QR 16(2)), y solo 0,94 es compatible con σL/σY = 0,49 y corr = 0,93. Corrección pedida al editor aquí; **el 3.A.6 (l. 814) y su CSV `hechos-estilizados-eeuu.csv` (fila sh_sw) tienen el mismo error** y hay que corregirlos en su propia revisión | — |
| A42-19 | Avisos de verificar-tema «cifra sin cita» (4) | Control de calidad: los 4 son falsos positivos (fechas de los enlaces de *The Economist* y *The Conversation*, «2008 y 2020» en la nota al opositor y la lista de fechas del anexo de test); no requieren cita | — |

## Enlaces del original (9/11/2026)

Restaurados:
- *The History of Economic Thought Website*, «Business Cycle Theory» (fuente del apartado I en el original) y las clases de la UNED de Sonia Benito Muela («Tema 6. Los ciclos económicos» y la serie «Macroeconomía. Demanda agregada», de donde salía un gráfico del original): caja de anotaciones de la introducción.
- BBVA Research, «(Im)productividad: ¿la enfermedad española?» (2020): entrada `BBVA2020Improductividad`, citada en la productividad contracíclica de España (I.2).
- «Equilibrio de manchas solares» (Wikipedia): al final de la nota al pie de las manchas solares de Jevons.
- «Slutsky» (Wiktionary, pronunciación): nota al pie nueva en Slutsky (1937).
- Repositorio DSGE_mod de Johannes Pfeifer (GitHub): caja de anotaciones del ciclo real, para simular el modelo en Dynare (en el original era la fuente de unos gráficos de otro preparador; los del tema son de simulación propia).
- Nota de la OCDE sobre filtros de paso banda (oecd-ilibrary ya no existe): entrada `Yamada2011Note` con su DOI, citada en el anexo del filtro HP.
- JSTOR 2646708: como `url` de `BaxterKing1999Measuring`. *Duda*: JSTOR no se deja abrir desde aquí; por el contexto (nota del filtro de paso banda) y el número es el artículo de Baxter y King (1999), pero conviene comprobarlo.
- Sims, Wu y Zhang, «The Four Equation New Keynesian Model» (dirección nueva en sites.nd.edu): entrada `SimsWuZhang2023Four`, citada en los bancos del ciclo financiero (en el original era una nota al opositor).

No restaurados:
- Tema 3A-41 de otro preparador (fabiansalazar.es): CRITERIOS § 5.
- Galí (2018) en la AEA: ya enlazado por el DOI de `Gali2018State`.
- *Informe Anual 2022* del Banco de España y BBVA Research, «La economía española en el primer año de la guerra de Ucrania» (observatorio del ciclo de abril de 2023): el tema revisado ya no habla de 2022 y cita la edición de octubre de 2026 del observatorio (`BoscaEtAl2026Observatorio`). Si Víctor quiere la de 2023 como lectura, iría en la caja de III.

## 8. Instrucciones para el vídeo

- **Pizarra** (parte 1): arriba, la franja `historia-ciclo`, que crece con el cante; a la izquierda, el refrán y las pegatinas; en el centro, `ciclo-tendencia` (I.1) y el panel izquierdo de `multiplicador-acelerador` (regiones); a la derecha, recuadrada y conservada hasta el final, la ecuación de Samuelson `eq:samuelson`. Apoyo (no se dibujan): `filtro-hp-espana`, `fases-ciclo-brecha`, `comovimientos` y la tabla de hechos.
- **Gráfico conjunto por partes**: `multiplicador-acelerador` (ejes → curva de oscilación → curva de estabilidad → regiones → panel de Hicks); `historia-ciclo` por etapas.
- **Pizarra** (II y III): en el centro, `irf-rbc` (Y, C, I y L con ρ_A = 0,95), el panel de demanda de `nek-xpi`, `ciclo-financiero-esquema` y `acelerador-financiero`; debajo, a la derecha, la tabla `tab:teorias-ciclo`, que se rellena fila a fila al acabar cada teoría. Apoyo (no se dibujan): `persistencia-mccallum`, `residuo-solow`, `nek-esquema`, `brecha-credito-pib-espana`, `ciclo-financiero-espana`, `recesiones-espana`, `tab:calibracion` y `tab:permanente-transitoria`.
- **Funciones clave que se conservan**: `eq:samuelson`, `eq:mccallum` y `eq:bgg`, recuadradas a la derecha; el bloque `eq:rbc-*` también se deja escrito durante II.1.
- **Enganche**: «Siempre que llovió, escampó» con los datos de 2020-2022 frente a 2008-2016. **Idea final**: vuelve al refrán («siempre que llovió, escampó, pero no da igual cuánto tarde») y lo matiza con la histéresis.

## 9. Propuestas aplicadas y rechazadas (parte 1)

- **Coherencia**: K1, K2, K5, K6, K8 (introducción), K9-K10 (figuras y remisiones con `\label`/`\ref`), K11 a), K14 (I), K15, K16, K17, K18 (Lucas, 2003, en I.3), K19, K20, K21 (adaptada: el *plucking model* y Lucas, en II.2), K22 (lo de I), K24, K25, K26 (Kalecki, Kaldor y Goodwin; el *plucking model* pasa a II.2 por decisión del coordinador), K28, K36 (el cuerpo no usa letras; las del anexo D, parte 2), K37 (con λ local avisado), K39-K42, K45 (la tabla se referencia desde I y se escribe en la parte 2). **Rechazada en parte** K27 (Lucas en I.4.4): Lucas queda en una viñeta de I.4.4 y su resumen va a II.2 (coordinador).
- **Contenido**: C2, C5 (con la cita de Bernanke en vez de Lucas, 2003, que va a I.3), C6, C7 (con las preguntas de K42), C8 (adaptada a la estructura final), C9, C10 (con los comités del CEPR y la AEE, que la fase de datos sí comprobó), C11, C12 (con datos; ver A42-11), C13, C14, C15, C16 (de palabra en el cuerpo; ecuaciones al anexo D), C17 (en I.4.2 f), C18, C19, C20 (en nota). **Rechazadas**: C1 (estructura y reparto: manda la coherencia) y C4 en el refrán («No hay mal que cien años dure»; manda el coordinador), aunque sus datos sí se usan. C3 (3 funciones clave) queda para la parte 2.
- **Datos**: V1-V3, V5, V7-V24, V28, V33, V34 aplicadas en I; V4 no se usa (Keynes es el enganche del 3.A.4); V6 (Fisher, 1933, § 17) y el resto, en la parte 2.

## 10. Propuestas aplicadas y rechazadas (parte 2)

- **Coherencia**: K3 y K45 (`tab:teorias-ciclo`), K4 (sin duplicaciones), K7 (CGG 1999 y 2000), K11 b) y c), K12, K13, K14 (II y III), K18 (Obstfeld y Rogoff fuera), K21, K23 (ver A42-13), K29 (resumen sin anexo), K30, K31, K32, K33-K35 (con el reparto del coordinador), K36 (letras locales en el anexo D), K38, K43, K44. **Rechazadas en parte**: K33 «16-20 años» (los datos dicen unos 16, V37); K26 *plucking* en I.4.3 (va a II.2, coordinador).
- **Contenido**: C21 (en II.2.1), C22-C31, C32 (sin las cifras del BdE, A42-15), C33 (sin la pegatina del cántaro y con los austriacos en una línea, porque ya estaban en I.4.2), C34, C35 (como bloque final de III.3), C36 (con el refrán del coordinador en vez de «No hay mal que cien años dure»), C37, C38 (con `hp-paso-banda` en vez de `hp-lambda`, porque el gráfico del cuerpo ya compara λ), C39, C40 (integrado en el anexo B, como en el 3.A.6), C41 (frase en III.3 con la edición de 2026), C42-C47. **Rechazadas**: el anexo D de neutralidad como anexo propio (va en el B) y `hp-lambda`.
- **Datos**: V6, V25-V27, V29-V32, V35-V43 aplicadas en II y III. V4 no se usa.
- **Gráficos**: 20 pedidos (9 copiados, 11 nuevos: los dibuja `tema-tikz`); `coste-fondos` del 3.A.34 no se usa.
