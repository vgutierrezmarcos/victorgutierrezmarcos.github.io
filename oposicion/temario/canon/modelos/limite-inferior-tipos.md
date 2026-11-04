# Límite inferior de los tipos de interés, orientación de la política (*forward guidance*) y tipo sombra

- **Área:** macro cerrada · **Tema de referencia:** **3.A.37** (Política monetaria (II)…: «los mecanismos de transmisión de la política monetaria no convencional», en el título; sin revisar) — es donde se desarrollan los instrumentos no convencionales y su transmisión; el 3.A.7 lo resume como implicación del modelo canónico y el 3.A.40 lo aplica a los multiplicadores. Ficha creada en la fase canon del 3.A.7 (**[decidir]**: alternativa, el 3.A.36, que trata el diseño y los instrumentos). Recoge los ids `zlb`, `elb`, `forward-guidance` y `tipo-sombra` (alias); la `trampa-liquidez` del 4.A.28 queda aparte (episodio histórico; la trampa de Keynes es de la ficha `keynes-teoria-general`).
- **Temas que lo usan:** 3.A.37 (desarrollo), 3.A.7 (resumen; hecho, 4/11/2026: III.1.1 `sec:politica-monetaria` y III.2), 3.A.36 (resumen: el objetivo del 2 % como colchón; reglas en el límite; la regla de Taylor con datos), 3.A.40 (resumen: el multiplicador fiscal en el límite inferior; ficha `multiplicadores-fiscales`), 3.A.41 (mención: deflación y límite inferior), 4.B.4 (mención: el multiplicador en el ELB; Christiano, Eichenbaum y Rebelo, 2011), 1D01 (uso; hecho, 24/10/2026: con los tipos en su límite inferior, expectativas, compras de activos y política fiscal; el tono por el balance del banco central). Relacionadas: `nek-3-ecuaciones`, `taylor`, `divina-coincidencia`, `hank`, `estancamiento-secular`. También 3.A.6 (mención; hecho, 4/11/2026: III.4 y la opinión de la conclusión, el límite inferior de los tipos en los EGDE tras 2008).
- **Manuales de referencia:** Krugman (1998), «It's Baaack», *BPEA*; Eggertsson y Woodford (2003), *BPEA* (`EggertssonWoodford2003Zero`); Del Negro, Giannoni y Patterson (2023), «The Forward Guidance Puzzle», *JPE Macro* (`DelNegroGiannoniPatterson2023`); McKay, Nakamura y Steinsson (2016), *AER* (`McKayNakamuraSteinsson2016`); Wu y Xia (2016), *JMCB* (`WuXia2016Measuring`), con la serie de la zona del euro en la web de Wu (`Wu2022Sombra`); Sims, Wu y Zhang (2023), «The Four-Equation New Keynesian Model», *REStat* (`SimsWuZhang2023`); Woodford (2011), *AEJ: Macro* (`Woodford2011Simple`); Christiano, Eichenbaum y Rebelo (2011), *JPE* (`ChristianoEichenbaumRebelo2011`); Galí (2015), cap. 5.

## Presentación de referencia (lo que fija el 3.A.7, III.1.1; el desarrollo, en el 3.A.37)

**Pregunta:** ¿qué puede hacer el banco central cuando el tipo nominal que pediría el modelo es negativo?

- **Límite inferior** (ZLB; ELB, *effective lower bound*, cuando el límite efectivo es negativo): con inflación baja, el tipo natural $r^n_t$ puede caer tanto que el tipo nominal que lo sigue tendría que ser negativo. Es un argumento para un objetivo de inflación positivo (en torno al 2 %: el BCE, simétrico a medio plazo desde 2021, confirmado en 2025). La regla de Taylor con datos lo muestra: con sus coeficientes originales pedía en la zona del euro un $-1{,}6$ % en 2020 y un 14 % en 2022 (inflación media del 8,4 %), con la facilidad de depósito cerca de cero (3.A.7; el gráfico, para el 3.A.36, A07-13).
- **Orientación de la política** (*forward guidance*): prometer tipos bajos durante más tiempo, aunque luego no haga falta, baja hoy los tipos reales esperados (Eggertsson y Woodford, 2003). En el modelo canónico la IS es prospectiva ($x_t=-\frac1\theta\sum_{k\geq0}\mathbb{E}_t[i_{t+k}-\pi_{t+k+1}-r^n_{t+k}]$), de modo que las promesas tienen efectos desmesurados, mayores cuanto más lejana la fecha: **paradoja de la orientación** (*forward guidance puzzle*; Del Negro, Giannoni y Patterson, 2023), que no se ve en los datos; con mercados incompletos y riesgo de paro se modera (McKay, Nakamura y Steinsson, 2016; ficha `hank`).
- **Compras de activos**: Sims, Wu y Zhang (2023) añaden una 4.ª ecuación al modelo; Gertler y Karadi (2011) y Gertler y Kiyotaki (2010) las justifican con bancos con restricciones de capital (ficha `bernanke-gertler`).
- **Tipo sombra**: el tipo a corto plazo que reproduciría la curva de rendimientos sin el límite (Wu y Xia, 2016); en la zona del euro, $-7{,}8$ % en agosto de 2019 con la facilidad de depósito en el $-0{,}4$ % (una frase; serie terminada en 2022 y sin segunda fuente, A07-14).
- **Política fiscal en el límite**: si el tipo nominal no sube, el multiplicador del gasto puede superar con creces la unidad (Woodford, 2011; Christiano, Eichenbaum y Rebelo, 2011; `\vertema{3.A.40}`).

**Gráfico de referencia:** ninguno fijado (el 3.A.37 decidirá; candidatos, la regla de Taylor con datos —CSV preparado en `fuentes/3A07/_trabajo/datos/regla-taylor-zona-euro.csv`— y el tipo sombra).

**Terminología:** «límite inferior de los tipos (de interés)» con ZLB entre paréntesis la primera vez (la ficha `nek-3-ecuaciones` decía ELB: se admite para el límite efectivo negativo); «orientación de la política (*forward guidance*)», nunca «guía futura» ni «indicaciones prospectivas» sin el inglés; «paradoja de la orientación (*forward guidance puzzle*)»; «tipo sombra»; «compras de activos».

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.37 | Transmisión de la política no convencional | desarrollo | Todo lo anterior, con los canales de las compras de activos (cartera, señalización, crédito), la evidencia y el tipo sombra | El modelo canónico (`\vertema{3.A.7}`) |
| 3.A.7 | Implicaciones del modelo canónico | resumen (hecho, 4/11/2026) | 4 viñetas en III.1.1 (límite, orientación y su paradoja, compras de activos, tipo sombra), la regla de Taylor con datos en una frase; III.2, el límite como lección de 2008; `\vertema{3.A.37}` | Los canales y la evidencia |
| 3.A.36 | Diseño de la política monetaria | resumen | El 2 % como colchón; reglas en el límite; el gráfico de la regla de Taylor con datos (A07-13) | — |
| 3.A.40 | Multiplicadores desde 2008 | resumen | El multiplicador en el límite (Woodford, 2011; Christiano, Eichenbaum y Rebelo, 2011) | La orientación |
| 3.A.41 | Inflación y deflación | mención | La deflación hace más probable el límite; `\vertema{3.A.37}` | — |
| 4.B.4 | Política fiscal y multiplicadores | mención | El multiplicador en el ELB, con `\vertema{3.A.40}` | — |
| 1D01 | Dictamen de coyuntura | uso (hecho, 24/10/2026) | Con los tipos en su límite inferior: expectativas, compras de activos y política fiscal; el tono por el balance | El modelo |
| 3.A.6 | NMC: surgimiento de los EGDE | mención (hecho, 4/11/2026) | El límite inferior entre los arreglos de los EGDE tras 2008 | El ZLB |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.7 (4/11/2026)**: «[ver tema 3.A.38]» para el multiplicador en el límite inferior (es el 3.A.40); el borrador de Sims y Wu sustituido por Sims, Wu y Zhang (2023).
- **3.A.36, 3.A.37, 3.A.41 (sin revisar)**: usan «*forward guidance*» y «límite inferior» con varias formas (16 menciones en el Word del 3.A.37): al revisarlos, la terminología de arriba; un solo desarrollo, en el 3.A.37.

Autor: Víctor Gutiérrez Marcos
