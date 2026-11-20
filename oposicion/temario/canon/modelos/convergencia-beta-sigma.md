# Convergencia β y σ (Barro y Sala i Martín)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.45 (convergencia económica internacional) — lo tiene en el título. **Revisado el 1/11/2026**: III.1 definiciones (con la 2.ª función clave del tema, `eq:convergencia-beta`) y III.2 evidencia.
- **Temas que lo usan:** 3.A.45 (desarrollo; hecho, 1/11/2026), 3.B.40 (resumen aplicado: regiones europeas; hoy desarrollo con otra notación), 4.A.17 (resumen aplicado: comunidades autónomas; hoy desarrollo con otra notación), 3.A.43 (mención; hecho, 31/10/2026: implicaciones teóricas de Solow —convergencia absoluta, condicional y en tasas— y λ = (1 − α)(n + g + δ) ≈ 4 %, (1 − α − β)(n + g + δ) ≈ 2 % en MRW y 7-10 % en el RCK; evidencia 1960-2023 con el gráfico `convergencia` (PWT 11.0) y Kremer, Willis y You, 2022; `\vertema{3.A.45}`), 3.A.44 (mención; hecho, 1/11/2026: la convergencia como prueba entre crecimiento exógeno y endógeno, `\vertema{3.A.45}`), 4.A.30 (mención, para ampliar), 3.B.28 (mención; hecho, 3/11/2026: II.1, «la renta por habitante de cada país converge a su propio estado estacionario», y I.2, la convergencia desde 2000, frágil, con Kremer, Willis y You, 2022, y `\vertema{3.A.45}`; clubes y trampas).
- **Manuales de referencia:** Barro y Sala i Martín (1991, *BPEA*; 1992, *JPE*); Barro y Sala i Martín (2004), caps. 11-12; Sala i Martín (1996), *EER*; Quah (1993, 1996); Durlauf y Johnson (1995); Baumol (1986); De Long (1988); Pritchett (1997); Johnson y Papageorgiou (2020), *JEL*; Kremer, Willis y You (2022), *NBER Macroeconomics Annual* 36; Acemoglu y Molina (2022).

## Presentación de referencia (3.A.45, III.1)

**Pregunta:** ¿tienden a igualarse las rentas por habitante de distintas economías? Convergencia **real** (la nominal es la de Maastricht, `\vertema{3.B.40}`); árbol `tipos-convergencia`. Nociones: Sala-i-Martín (tesis de 1990) y Barro y Sala-i-Martín (1991).

**Convergencia β** (función clave, renta por habitante **sin abreviar**, DK5; vectores con flecha):
$$\boxed{\gamma^{y}_{t,t-1}=\beta_0+\beta_1\ln y_{t-1}+\vect{\eta}\cdot\vect{z}_{t-1}+u_t}\qquad(\texttt{eq:convergencia-beta};\ \text{forma del 3.A.45 desde el 11/11/2026})$$
$y$ renta por habitante (minúscula sin virgulilla; $\tilde y$ es por unidad eficiente, regla 4), $\vect{z}_{t-1}$ determinantes del estado estacionario, $\vect{\eta}$ sus coeficientes; **absoluta** si $\beta_1<0$ con $\vect{\eta}=\vect{0}$; **condicional** si $\beta_1<0$ controlando por $\vect{z}_i$. $\beta_0$, $\beta_1$ con subíndice son coeficientes (β sola es la de MRW). Velocidad: $\beta_1=-(1-e^{-\lambda T})/T$ con $\lambda=(1-\alpha)(n+g+\delta)$ (≈ 4 %, semivida ≈ 17 años; con capital amplio de 2/3, ≈ 2 %, ≈ 35 años; `\vertema{3.A.43}`).

**Convergencia σ** (forma única, resuelve la divergencia de cronología):
$$\sigma^2_{y,t-1}>\sigma^2_{y,t},\qquad \sigma^2_{y,t}\equiv\text{varianza de }\ln y\text{ entre economías}\qquad(\texttt{eq:convergencia-sigma})$$
**σ ⇒ β, pero β ⇏ σ**: por el adelantamiento (2 economías, panel c de `beta-sigma`) y por las perturbaciones, con $\ln(Y/L)_{i,t}=a+(1-b)\ln(Y/L)_{i,t-1}+u_{i,t}$:
$$\sigma_t^2=(1-b)^2\sigma_{t-1}^2+\sigma_u^2\;\to\;\sigma^{*2}=\frac{\sigma_u^2}{1-(1-b)^2}\qquad(\texttt{eq:dispersion};\ a,\ b\ \text{locales})$$
(Sala-i-Martín, 1996). **Otras nociones**: clubes de convergencia (equilibrios múltiples, trampas, `\vertema{3.A.43}` `\vertema{3.B.28}`), convergencia en series temporales, **falacia de Galton** (regresión a la media; Quah, 1993, pide la dinámica de toda la distribución). Tabla `tab:teorias-convergencia` (neoclásica, endógena —con la nota de que el Sobelow y Jones sí predicen convergencia—, kaldorianos, nueva geografía; del Río Casasola, 2018).

**Ecuación de Barro y Sala-i-Martín** (caja de los estados de EE. UU.), con $y$ por unidad de trabajo eficiente sin marca y **λ** (no β) para la velocidad y **g** (no $x$) para el progreso técnico:
$$\frac{1}{T}\ln\frac{(Y/L)_{i,T}}{(Y/L)_{i,0}}=g+\frac{1-e^{-\lambda T}}{T}\ln\frac{y^*}{y_{i,0}}\qquad(\texttt{eq:bsm})$$

**Evidencia (III.2):** Baumol (1986) frente a De Long (1988, sesgo de selección); Summers y Heston (1988, 130 países desde 1950); sin convergencia absoluta en 98 países, 1960-1985 (MRW, 1992, tabla III); «divergencia a lo grande», ricos/pobres 8,7 (1870) → 45 (1990) (Pritchett, 1997). PWT 11.0: 1960-2000, pendiente +0,25 sin petroleros, OCDE −1,03 (λ ≈ 1,3 %); 2000-2023, −0,52 (182 países), −0,34 sin petroleros ni pequeños, λ ≈ 0,5 %, OCDE λ ≈ 1,8 %; con Maddison, casi nula. Condicional: MRW −0,14 (con $s$ y $n$), −0,29 (escolarización, λ 1,4 %), OCDE −0,34, coeficientes sobre 25 años; sesgo de variable omitida. Regiones: ≈ 2 % (BSM; pegatina «no se ganó Zamora en una hora»), estados de EE. UU. con el BEA 1929-2025: λ ≈ 1,4 %, R² 0,88. σ (PWT 11.0): mundo, 96 países, 0,96 (1960) → 1,34 (2000-2007) → 1,27 (2023); OCDE 0,61 → 0,44; UE-27 0,55 → 0,33; UE-14 sin Irlanda ni Luxemburgo 0,38 → 0,15 (2007) → 0,20 (2023). Clubes: picos gemelos (Quah, 1996), Durlauf y Johnson (1995), «Dios los cría y ellos se juntan»; Johnson y Papageorgiou (2020). Desde 2000: Kremer, Willis y You (2022), Patel, Sandefur y Subramanian (2021), frente a Acemoglu y Molina (2022, efectos fijos); manufacturas (Rodrik, 2013).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A45/graficos/`): `beta-sigma.tex` (3 paneles; el c, a mano alzada), `convergencia-periodos.tex` (1960-2000 y 2000-2023, OCDE resaltada; de pizarra, por capas), `convergencia-sigma.tex`, `estados-eeuu.tex`, `tipos-convergencia.tex` (de apoyo). El 3.A.43 tiene `convergencia` (1960-2023), que el 3.A.45 no repite.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.45 | Convergencia internacional | desarrollo (hecho, 1/11/2026) | Lo de arriba | — |
| 3.B.40 | Política regional / cohesión en la UE | resumen aplicado (hecho, 14/11/2026) | III.1 con la misma `eq:convergencia-beta` del 3.A.45 ($\gamma^{y}_{t,t-1}=\beta_0+\beta_1\ln y_{t-1}+\vect{\eta}\cdot\vect{z}_{t-1}+u_t$) y `eq:convergencia-sigma` ($\sigma^2_{y,t-1}>\sigma^2_{y,t}$), sin el gráfico `beta-sigma` (remite al 3.A.45); evidencia propia: 232 regiones NUTS 2, 2000-2024, $\hat\beta_1=-1{,}99$, λ ≃ 2,7 %; σ de los Estados 0,56 → 0,31 y de las regiones 0,46 → 0,34 (Eurostat; no coincide al decimal con el 0,55 → 0,33 del 3.A.45, que usa PWT 11.0 hasta 2023) | La derivación |
| 4.A.17 | Convergencia entre CC. AA. | resumen aplicado | Lo imprescindible para cantarse solo, con las mismas ecuaciones; evidencia para España desde 1955 | Idem |
| 3.A.43 | Solow, MRW y RCK | mención (hecho, 31/10/2026) | Las predicciones (absoluta, condicional, en tasas) y la velocidad λ de cada modelo (anexo C); la evidencia en una viñeta | La estimación de β y σ `\vertema{3.A.45}` |
| 3.A.44 | Crecimiento endógeno | mención (hecho, 1/11/2026) | La convergencia como prueba entre enfoques | Las definiciones |
| 3.B.28 | Economía de los países en desarrollo | mención (hecho, 3/11/2026) | Convergencia condicional como resultado de Solow que los teóricos del desarrollo pusieron en duda (II.1); convergencia desde 2000, frágil (I.2, Kremer, Willis y You, 2022); clubes y trampas (`\vertema{3.A.43}`) | Las definiciones formales (`\vertema{3.A.45}`) |
| 4.A.30 | Convergencia España-UE | mención | Con la notación de esta ficha (ficha `descomposicion-pib-per-capita`) | La teoría |
| 3.B.32 | Economía mundial | resumen aplicado (hecho, 14/11/2026) | III.1, `eq:convergencia-beta`: emergentes con WDI (NY.GDP.PCAP.PP.KD, 2000-2024, 189 países), pendiente −0,43 por unidad de log, R² 0,08; gráfico `convergencia`; coherente con la cifra de PWT (2000-2023, −0,52) | El gráfico `beta-sigma` |

## Divergencias encontradas en el temario actual
- Resuelto en el 3.A.45 (1/11/2026): $\gamma^y_{t,t-1}$ con $y$ per cápita (→ $(Y/L)_{i,t}$), $\sigma^2_{y,t-1}>\sigma^2_{y,t}$ (→ $\sigma_t<\sigma_{t-T}$), BSM con $\beta$, $x$, $\hat y$ (→ λ, g, $y$), «Heston y Summers» y su resultado (Summers y Heston, 1988; la regresión es de MRW), Johnson y Papageorgiou 2018 (2020), Kremer et al. en documento de trabajo y Acemoglu y Molina con título y críticas erróneos.
- 3.B.40 ($\sigma^2_{y,t}>\sigma^2_{y,t+k}$, con σ también elasticidad de la NGE) y 4.A.17 ($\sigma^2_{y,t-1}>\sigma^2_{y,t}$) desarrollan de nuevo las definiciones con otra notación y la misma imagen: resumir con la de esta ficha y remitir.

## Puesta al día de la pasada final (noviembre de 2026; manda sobre lo anterior)
- **Notación (3.A.45, 4.ª tanda, 11/11/2026):** vuelve la notación antigua del tema, $\gamma^{y}_{t,t-1}=\beta_0+\beta_1\ln y_{t-1}+\vect\eta\cdot\vect z_{t-1}+u_t$ y $\sigma^2_{y,t-1}>\sigma^2_{y,t}$, con $y$ renta por habitante y $\tilde y$ por unidad eficiente (regla 4); sustituye a la forma con $(Y/L)_{i,t}$ y $\vect x_i\cdot\vect\psi$ (CC3), que queda solo en las ecuaciones auxiliares de abajo (léase $y$ donde dice $Y/L$). El «Resuelto» de abajo sobre $(Y/L)_{i,t}$ queda superado. El 3.B.40 sigue al `.tex` vigente (hecho).
- **Clubes de convergencia** (3.A.45): mismos parámetros y estados estacionarios distintos según el punto de partida (Galor, 1996), frente a la convergencia condicional (parámetros distintos).

Autor: Víctor Gutiérrez Marcos
