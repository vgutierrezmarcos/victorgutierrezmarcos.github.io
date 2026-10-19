# Modelo neokeynesiano canónico de tres ecuaciones (Clarida, Galí y Gertler, 1999)

- **Área:** pensamiento (se usa sobre todo en macro cerrada) · **Tema de referencia:** 3.A.7 (La nueva economía keynesiana) — es el modelo que define la NEK de 2.ª generación y el título lo pide; los temas de política monetaria y fiscal y de ciclos lo **aplican**, no lo vuelven a derivar.
- **Temas que lo usan:** 3.A.7 (desarrollo), 3.A.36 (resumen + desarrollo de la política óptima), 3.A.37 (resumen: transmisión), 3.A.38 (resumen: gasto público), 3.A.42 (resumen: ciclos nominales), 4.B.4 (resumen: multiplicador), 3.A.41 (mención: NKPC adelantada). Hoy lo **desarrollan** seis temas con notación casi idéntica (copia). 3.A.18 (mención; hecho, 19/10/2026: Dixit-Stiglitz con rigideces à la Calvo es el modelo canónico de la NEK, Galí, 2015; Blanchard y Kiyotaki, 1987; ficha `dixit-stiglitz`).
- **Manuales de referencia:** Galí, *Monetary Policy, Inflation, and the Business Cycle* (2.ª ed., 2015), caps. 3-5; Clarida, Galí y Gertler (1999), *JEL* 37(4); Walsh, *Monetary Theory and Policy* (4.ª ed., 2017), cap. 8; Woodford, *Interest and Prices* (2003); Romer (2019), cap. 7; Carlin y Soskice (2015) para la versión gráfica IS-PC-MR; Cuerpo y Quesada (2016), ICEX-CECO.
- **Decisión D001 (13/10/2026):** ¿Qué letra lleva el coeficiente de aversión relativa al riesgo (CRRA) de u(c)=c^{1−θ}/(1−θ), y cómo se escribe la elasticidad de sustitución intertemporal? θ para la CRRA en todo el temario y la ESI como 1/θ, sin símbolo propio; σ queda para la elasticidad de sustitución intratemporal (CES, Dixit-Stiglitz) y la desviación típica
- **Decisión D008 (13/10/2026):** ¿Se reserva δ para la tasa de depreciación y se cambian sus otros usos? Sí: pendiente de la NKPC κ, tasa de separación s (DMP y Shapiro-Stiglitz) y tasa social de descuento r_s (4.B.6); δ solo depreciación (y el factor exponencial del modelo β-δ de Laibson)
- **Decisión D021 (13/10/2026):** ¿Qué forma de la regla de Taylor se usa en los modelos? La canónica i_t = r^n + φ_π π_t + φ_x x_t (+ suavización ν i_{t−1} con (1−ν) en la respuesta) en todos los modelos; la original de 1993 solo como cita histórica en 3.A.36, con la equivalencia φ_π = 1 + 0,5

## Presentación de referencia

**Pregunta:** ¿cómo afectan la política monetaria y los shocks a la inflación y a la brecha de producción cuando los precios son rígidos pero los agentes optimizan y tienen expectativas racionales?

**Supuestos:** hogar representativo con utilidad CRRA en el consumo (θ) y desutilidad del trabajo (inversa de Frisch φ); continuo de empresas en competencia monopolística (Dixit-Stiglitz) que fijan precios à la Calvo (probabilidad η de **no** poder revisarlos cada periodo); sin capital ni sector público (en la versión básica, Y = C); log-linealización alrededor de un estado estacionario con inflación nula.

**Ecuaciones** (variables en logaritmos; x_t ≡ y_t − y^n_t):

$$x_t = \mathbb{E}_t[x_{t+1}] - \frac{1}{\theta}\left(i_t - \mathbb{E}_t[\pi_{t+1}] - r^n_t\right) \qquad \text{(IS dinámica: ecuación de Euler)}$$

$$\pi_t = \beta \mathbb{E}_t[\pi_{t+1}] + \kappa\, x_t + u_t,\qquad \kappa = \frac{(1-\eta)(1-\beta\eta)}{\eta}\,(\theta+\varphi) \qquad \text{(NKPC)}$$

$$i_t = \rho + \phi_\pi \pi_t + \phi_x x_t + \varepsilon_t \qquad \text{(regla de Taylor; véase la ficha \texttt{taylor})}$$

con r^n_t = ρ + θ 𝔼_t[Δy^n_{t+1}] (tipo real natural), u_t shock de costes y ε_t shock de política. Resolviendo hacia delante, π_t = κ Σ_{k≥0} β^k 𝔼_t[x_{t+k}] + … (la inflación depende de las brechas futuras esperadas).

**Resultados:** (1) el dinero no es neutral a corto plazo; (2) **principio de Taylor**: hay equilibrio único si φ_π > 1 (condición exacta κ(φ_π − 1) + (1 − β)φ_x > 0); (3) **divina coincidencia** (Blanchard y Galí, 2007): sin u_t, estabilizar la inflación cierra la brecha; con u_t aparece el dilema; (4) con política óptima, discreción frente a compromiso (sesgo de estabilización, ganancia del compromiso).

**Gráfico de referencia:** plano (x_t, π_t): curva NKPC con pendiente positiva κ y curva de demanda agregada dinámica (IS + regla) con pendiente negativa; un shock de costes desplaza la NKPC hacia arriba, uno de demanda o de política desplaza la DA. Alternativa para 3.A.36: diagrama IS-PC-MR de Carlin y Soskice. No existe aún `.tex` en ningún tema revisado.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.7 | Qué aporta la NEK de 2.ª generación | Desarrollo | Microfundamentos (Dixit-Stiglitz, Calvo), derivación resumida de las tres ecuaciones, resultados (1)-(3), extensiones (Smets-Wouters, salarios rígidos de Erceg-Henderson-Levin), críticas | — |
| 3.A.36 | Diseño de la política monetaria | Resumen del modelo + desarrollo de la política óptima | Pérdida L = Σβ^t(π_t² + λ_x x_t²); discreción (x_t = −(κ/λ_x)π_t) frente a compromiso; reglas de Taylor e instrumentales; objetivos de inflación | La derivación de la NKPC |
| 3.A.37 | Mecanismos de transmisión | Resumen | La IS dinámica como canal del tipo de interés; respuesta a ε_t; ELB y forward guidance (paradoja del forward guidance) | La derivación; la regla de Taylor en detalle (remitir a 3.A.36) |
| 3.A.38 | Efectos de la política fiscal | Resumen | IS con gasto: y_t = (1 − s_G)c_t + g_t; el multiplicador depende de la respuesta monetaria (φ_π) | La NKPC y la regla completas |
| 3.A.41 | Causas de la inflación | Mención | NKPC adelantada: la inflación como valor presente de brechas futuras; inflación por shocks de costes u_t | El modelo entero |
| 3.A.42 | Ciclos nominales | Resumen | Respuestas a shocks de demanda, de costes y monetarios; comparación con el RBC | La derivación |
| 4.B.4 | Política fiscal y multiplicadores | Resumen | Variante con g_t (Galí 2008, cap. 7 de la 1.ª ed.); multiplicador en el ELB (Christiano, Eichenbaum y Rebelo, 2011) | La derivación; la restricción del gobierno (ver `restriccion-gobierno`) |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | Las empresas monopolísticamente competitivas fijan un precio con margen μ; con costes de cambiarlo, el dinero no es neutral (Blanchard y Kiyotaki, 1987); con Calvo, el modelo canónico (Galí, 2015); `\vertema{3.A.7}`, `\vertema{3.A.32}`, `\vertema{3.B.19}` | Las 3 ecuaciones |

## Divergencias encontradas en el temario actual

- **Copia en seis temas** (3.A.7, 3.A.36, 3.A.37, 3.A.38, 3.A.42, 4.B.4) con las mismas ecuaciones: propuesta, desarrollo solo en 3.A.7 y resumen de 4-6 líneas con «[ver tema 3.A.7]» en los demás, cada uno con su variante.
- **Pendiente de la NKPC llamada δ** (3.A.7, 3.A.36, 3.A.37, 3.A.41), que choca con la depreciación: canon **κ** (Galí, Woodford); δ es la depreciación.
- **Pendiente mal definida:** 3.A.7, 3.A.36 y 4.B.4 escriben δ = (1−η)(1−βη)/η como coeficiente de x_t; ese es el coeficiente del **coste marginal real**; el de la brecha es κ = [(1−η)(1−βη)/η](θ + φ). 3.A.36 dice además que x_t es «brecha y también desviación del coste marginal». Corregir.
- **Regla de Taylor sin coeficiente en x_t** (i_t = ν i_{t−1} + ϕπ_t + x_t + ε_t en 3.A.7, 3.A.37, 3.A.38, 3.A.42, 4.B.4) y sin (1−ν) en el término de respuesta: canon: la forma de la ficha `taylor`, $i_t=r^n_t+\phi_\pi\pi_t+\phi_x x_t$ (con suavización, $i_t=\nu i_{t-1}+(1-\nu)(\ldots)$).
- **CRRA θ frente a σ:** 3.A.37 escribe la IS con −1/θ y con −σ en el mismo tema; 3.A.42 usa σ. Canon θ (ver `_notacion/macro-cerrada.md`): la IS dinámica con $-1/\theta$.
- **4.B.4** mezcla y_t, c_{t+1} y ρ en la IS (y_t = g_t − (1/θ)(i_t − 𝔼_tπ_{t+1} − ρ) + 𝔼_t[c_{t+1}]): escribir en brechas con g_t explícito.
- **Tipo natural:** r^n_t (3.A.7, 3.A.37), r^n (3.A.36), ρ (4.B.4): uniformar a r^n_t y decir que r^n = ρ sin shocks.
- **Nombre:** «modelo de 3 ecuaciones» también designa el IS-PC-MR de Carlin y Soskice: citar ambos y no confundirlos.

Autor: Víctor Gutiérrez Marcos
