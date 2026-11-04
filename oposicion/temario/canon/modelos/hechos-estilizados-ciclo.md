# Hechos estilizados del ciclo económico

- **Área:** macro-cerrada · **Tema de referencia:** **3.A.42** (I.2.2 `sec:hechos-ciclo` «¿Qué tienen en común los ciclos? Hechos estilizados», revisado el 4/11/2026, con `tab:hechos-ciclo` de datos propios y la evolución en I.3 `sec:gran-moderacion`) — es el único que los trata.
- **Temas que lo usan:** 3.A.42 (desarrollo; hecho, 4/11/2026: los 4 rasgos —volatilidad relativa, dirección con corr(·,·), desfase y persistencia—, los 5 hechos de Stock y Watson, el empleo frente a las horas, los 3 rasgos de España, la pandemia y la tabla de datos; la Gran Moderación en I.3), 3.A.33 y 3.A.34 (mención: consumo e inversión procíclicos; los 2 hechos, 31/10/2026: el 3.A.34 en la introducción con la desviación típica 1996-2019, FBCF 6,6 frente a PIB 2,3, y 2009-T2, FBCF −20,3 % frente a PIB −4,3 %, INE tabla 67824), 1D01 (resumen: tabla del anexo D, `tab:hechos-ciclo`, y lectura del cuadro en II.3) También 3.A.6 (mención; hecho, 4/11/2026: III.3 c), `tab:calibracion` con los datos de 1947-1991 y el modelo estándar de Hansen y Wright (1992) y una columna propia de 1984-2019 con FRED, filtro HP; corr(horas, productividad) −0,60 en 1984-2019; recesión media de un año con la definición de Rebelo, 2005; `\vertema{3.A.42}`).
- **Manuales de referencia:** Burns y Mitchell (1946); Kydland y Prescott (1990); Cooley y Prescott (1995); Stock y Watson (1999), «Business Cycle Fluctuations in US Macroeconomic Time Series», *Handbook of Macroeconomics*; Blinder y Maccini (1991) (existencias); Kaminsky, Reinhart y Végh (2004) (política fiscal procíclica en emergentes); Estrella y Mishkin (1998) (curva de tipos).

## Presentación de referencia
**Pregunta:** ¿cómo se mueven las principales variables con el ciclo?

Cada variable se caracteriza por 4 rasgos (3.A.42), con el componente cíclico $\hat x_t$ y el del PIB $\hat y_t$ (desviaciones logarítmicas respecto a la tendencia HP): **volatilidad** relativa $\sigma_X/\sigma_Y$; **dirección**, procíclica si $\mathrm{corr}(\hat x_t,\hat y_t)>0$, contracíclica si < 0, acíclica si ≈ 0 (siempre **corr(·,·)**, nunca ρ: ρ es la tasa de descuento y ρ_A la persistencia de la PTF); **desfase**, adelantada si $\mathrm{corr}(\hat x_{t-k},\hat y_t)$ es máxima con $k>0$; **persistencia**, $\mathrm{corr}(\hat x_t,\hat x_{t-1})$.

**Dos tablas canónicas, una cualitativa y otra con datos (A42-11):**

1. **Con datos** (3.A.42, `tab:hechos-ciclo`, **tabla de referencia del 3.er ejercicio**): España, zona del euro y EE. UU., **1995T1-2019T4**, HP con λ = 1600 del logaritmo de cada serie en volumen; volatilidad relativa, correlación contemporánea y autocorrelación de orden 1 (cálculo propio con Eurostat y FRED; segunda comprobación con el DO 2103 del Banco de España, Álvarez, Gadea y Gómez-Loscos, 2021). **Cifras canónicas**: σ_Y 1,20 / 1,12 / 1,03; consumo privado 1,18 / 0,60 / 0,79; inversión (FBCF) 2,89 / 2,49 / 4,38; consumo público 0,95 (corr 0,45) / 0,47 (−0,10) / 1,21 (−0,53); exportaciones 2,52 / 2,97 / 3,54; importaciones 3,65 / 2,90 / 3,68; **empleo (personas) 1,22 / 0,53 / 1,07**; **horas totales 1,25 / 0,72 / 1,71**; productividad por hora 0,54 (corr −0,26) / 0,49 (0,74) / 0,80 (−0,16); persistencia del PIB 0,94 / 0,90 / 0,88. La tabla se calcula hasta 2019 porque la pandemia la rompe (con 2020-2021, σ_Y de España pasa de 1,2 a 2,6 y la volatilidad relativa de la inversión de 2,9 a 1,6). CSV en `fuentes/3A42/_trabajo/datos/hechos-estilizados-espana-zona-euro.csv`.
2. **Cualitativa** (la de la 1D01, `tab:hechos-ciclo`, aprobada; coherente con el 3.A.42, que pone lo que no tiene dato en viñetas: vivienda adelantada, existencias muy volátiles, precios y tipos a corto detrás, bolsa y pendiente de la curva delante):

| Variable | Dirección | Volatilidad frente al PIB | Adelanto o retraso |
|---|---|---|---|
| Consumo privado | Procíclico | Menor (duraderos, mayor) | Contemporáneo |
| Inversión en equipo | Procíclica | Varias veces mayor | Contemporánea o algo retrasada |
| Inversión en vivienda | Procíclica | Varias veces mayor | Adelantada |
| Variación de existencias | Procíclica | Muy alta | Contemporánea |
| Consumo público | Acíclico (correlación ≈ 0); procíclico en muchos emergentes | Depende del país | Sin patrón claro |
| Importaciones | Procíclicas | Mayor (el comercio, 2-3 veces) | Contemporáneas |
| Demanda externa neta | Contracíclica | — | — |
| Empleo | Procíclico | Similar o algo menor | Contemporáneo o algo retrasado |
| Tasa de paro | Contracíclica | — | Retrasada |
| Productividad del trabajo | Procíclica (en España, a menudo contracíclica) | Menor | Algo adelantada |
| Salario real | Débilmente procíclico o acíclico | Mucho menor | Sin patrón claro |
| Inflación | Procíclica (contracíclica con choques de oferta) | — | Retrasada |
| Tipos de interés a corto | Procíclicos | — | Retrasados |
| Pendiente de la curva de tipos | — | — | Adelantada |
| Bolsa | Procíclica | Mucho mayor | Adelantada |

**El empleo frente a las horas (X3, aviso obligatorio en todo tema que dé las 2 cifras)**: el **empleo** (personas) fluctúa **similar o algo menos** que el PIB (Víctor, 24/10/2026; Stock y Watson, 1999): 0,53 en la zona del euro y 1,07 en EE. UU. en 1995-2019; **España, 1,22, más volátil** (con mucho empleo temporal se ajusta con personas, no con horas). Las **horas totales** de EE. UU. fluctúan **más** que la producción (1,71 en 1995-2019; 1,68 en 1984-2019 en `tab:calibracion` del 3.A.6 y del 3.A.42) por 2 razones: suman a los ocupados el ajuste de la jornada, y **desde 1984 la volatilidad del PIB bajó más que la de las horas** (en 1947-1991 eran casi igual de volátiles, 0,96). No es una contradicción, pero hay que decirlo cuando conviven (el 3.A.42 lo dice en I.2.2).

**España** (3.A.42, con el DO 2103): empleo (1,22) y consumo privado (1,18) más volátiles que el PIB; **productividad contracíclica** (en las recesiones se destruye empleo temporal y poco productivo); **consumo público procíclico** (sigue a la recaudación). **Productividad en EE. UU.**: desde mediados de los 80, débilmente contracíclica (−0,16 por hora en 1995-2019; la corr(horas, productividad) −0,60 en 1984-2019 de `tab:calibracion`): la fila «procíclica» de la tabla cualitativa vale para la zona del euro y la posguerra, no para EE. UU. desde 1984 (aviso, sin pendiente en la 1D01, que habla en general).

**Gráficos de referencia:** `fuentes/1D01/graficos/ciclo-tendencia.tex` (pico, valle, fases) y `fuentes/1D01/graficos/comovimientos.tex` (series procíclica, contracíclica y adelantada), copiados en el 3.A.42; `fuentes/3A42/graficos/filtro-hp-espana.tex` para la medición (ficha `brecha-produccion`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.42 | Teorías del ciclo | desarrollo (hecho, 4/11/2026) | Los 4 rasgos con corr(·,·); los 5 hechos; `tab:hechos-ciclo` con datos de 3 economías y persistencia; el empleo frente a las horas; España; la pandemia; la Gran Moderación (Kim y Nelson, 1999; McConnell y Pérez-Quirós, 2000; Stock y Watson, 2002; Bernanke, 2004; Lucas, 2003) | — |
| 3.A.33, 3.A.34 | Consumo, inversión | Mención (los 2 hechos, 31/10/2026; el 3.A.33 en III.3 a) con datos de España, 1996-2026, y `\vertema{3.A.42}`; el 3.A.34 en la introducción, con los datos de la CNTR) | Consumo menos volátil que el PIB; duraderos mucho más (desviación típica de la tasa interanual 10,6 frente a 3,9 del PIB); inversión varias veces más | La tabla |
| 1D01 | Dictamen de coyuntura | Resumen | Tabla sin persistencia, con existencias, vivienda, paro, curva de tipos y bolsa; lectura del cuadernillo | La teoría |
| 3.A.6 | NMC: ciclo real | mención (hecho, 4/11/2026) | `tab:calibracion` (σ_Y, σ_C/σ_Y, σ_I/σ_Y, σ_L/σ_Y, σ_L/σ_{Y/L} y corr(horas, productividad)) con 1984-2019 | Los hechos estilizados en general |

## Divergencias encontradas en el temario actual
- **Volatilidad del empleo** (Víctor, 24/10/2026, decidido para todo el temario): **similar o algo menor** que la del PIB (Stock y Watson, 1999; Cooley y Prescott, 1995), como la 1D01. El Word del 3.A.42 decía «el empleo es más volátil que el producto»: **resuelto** el 4/11/2026 (regla general «similar o algo menor», con la excepción de España y el aviso de las horas; K16, V13). Las horas por ocupado, mucho menos volátiles en las 3 economías (0,28-0,76), como decía el Word.
- La inversión residencial (adelantada) y las existencias, que faltaban en el Word del 3.A.42: **resuelto** (viñetas de I.2.2).
- El Word del 3.A.42 decía que el gasto público era más volátil en EE. UU. «por las guerras»: con 1995-2019 es más volátil (1,21) sin guerras y **contracíclico** (V12).
- Original de la 1D01 (corregido): gasto público «anticíclico, retardado» y «procíclico», comercio «anticíclico», inversión «adelantada», existencias con «efecto anticíclico».

Autor: Víctor Gutiérrez Marcos
