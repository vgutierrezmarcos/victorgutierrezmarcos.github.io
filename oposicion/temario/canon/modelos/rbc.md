# Modelo de ciclo real (RBC; Kydland y Prescott 1982; versión de McCallum 1989)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.42 (teorías de los ciclos: nominales y reales) — los ciclos reales están en su título.
- **Temas que lo usan:** 3.A.42 (desarrollo), 3.A.6 (desarrollo → resumen), 4.A.29 (mención), 3.A.25 (mención; hecho, 31/10/2026: II.3, el mecanismo de Lucas-Rapping en Kydland y Prescott, efecto riqueza frente a sustitución intertemporal según la persistencia, trabajo indivisible de Hansen y Rogerson, y la Frisch de 2,8 que piden frente a la micro; ficha `lucas-rapping`)
- **Manuales de referencia:** Romer (2019), cap. 5; McCallum (1989); King y Rebelo (1999); Bénassy (2011); Galí (2015), cap. 2.
- **Decisión D001 (13/10/2026):** ¿Qué letra lleva el coeficiente de aversión relativa al riesgo (CRRA) de u(c)=c^{1−θ}/(1−θ), y cómo se escribe la elasticidad de sustitución intertemporal? θ para la CRRA en todo el temario y la ESI como 1/θ, sin símbolo propio; σ queda para la elasticidad de sustitución intratemporal (CES, Dixit-Stiglitz) y la desviación típica
- **Decisión D004 (13/10/2026):** ¿Cómo se escriben los parámetros de la oferta de trabajo en las preferencias macro (inversa de la elasticidad de Frisch y peso de la desutilidad del trabajo)? φ para la inversa de la elasticidad de Frisch y χ para el peso de la desutilidad del trabajo (Galí, Walsh)

## Presentación de referencia
Pregunta: ¿pueden los shocks de productividad en un modelo de equilibrio general competitivo con agentes optimizadores explicar las fluctuaciones? Supuestos: agente representativo con horizonte infinito; Cobb-Douglas; mercados competitivos y precios flexibles; shocks tecnológicos persistentes.

$$Y_t = A_t K_t^{\alpha}L_t^{1-\alpha},\qquad \ln A_t = \rho_A \ln A_{t-1} + \varepsilon_t$$
$$W_t = (1-\alpha)A_t\left(\frac{K_t}{L_t}\right)^{\alpha},\qquad R_t = \alpha A_t\left(\frac{K_t}{L_t}\right)^{\alpha-1}$$
$$C_t^{-\theta} = \beta\,\mathbb{E}_t\!\left[C_{t+1}^{-\theta}(1 + R_{t+1} - \delta)\right],\qquad \chi L_t^{\varphi} = C_t^{-\theta}w_t$$
$$K_{t+1} = (1-\delta)K_t + Y_t - C_t$$
Versión de McCallum (solución cerrada): δ = 1, utilidad logarítmica (θ = 1) y trabajo fijo → tasa de ahorro constante s = αβ y $K_{t+1} = \alpha\beta A_t K_t^{\alpha}$; en logaritmos, el capital y la producción heredan y propagan la persistencia del shock.
Resultado: con calibración, el modelo reproduce la volatilidad relativa de consumo (menor) e inversión (mayor) y la prociclicidad de la productividad; las fluctuaciones son respuestas óptimas, no fallos de mercado. Críticas: medición del residuo de Solow, escasa propagación interna, elasticidad de la oferta de trabajo implausible, papel nulo del dinero.
Gráficos de referencia: funciones impulso-respuesta a un shock tecnológico desde el estado estacionario (Y, C, I, L, w, r); tabla de momentos simulados frente a datos.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.42 | Ciclos reales | desarrollo | Modelo, McCallum, calibración, impulso-respuesta, críticas y evidencia | — |
| 3.A.6 | Surgimiento de los EGDE en la NMC | resumen | Características del RBC como primer EGDE y su método (calibración); transición a Smets-Wouters | Derivación [ver tema 3.A.42] |
| 3.A.25 | Oferta de trabajo intertemporal | mención (hecho, 31/10/2026) | La sustitución intertemporal como mecanismo de propagación: un choque transitorio genera ciclo; uno permanente apenas cambia la oferta relativa y se transmite por la inversión (nunca «no hay ciclo»); trabajo indivisible (Hansen, 1985; Rogerson, 1988); la elasticidad de Frisch agregada que piden (≈ 2,8) frente a la micro (Chetty et al., 2011); remite a 3.A.42 | El modelo |
| 4.A.29 | Política de estabilización en España | mención | No todas las fluctuaciones deben eliminarse | — |

## Divergencias encontradas en el temario actual
- **Errores** en 3.A.6: las expresiones recuadradas W_t = A_t(K/L)^α y R_t = A_t(K/L)^{α−1} omiten los factores (1−α) y α (que sí están en la tabla de condiciones de equilibrio).
- **Error** en 3.A.6: la PTF se escribe A_t = A_0 + e^{gt+Ã_t} (suma) y a la vez ln A_t = ln A_0 + gt + Ã_t (producto): la correcta es **A_t = A_0 e^{gt+Ã_t}**. En McCallum, ln(A_t) = ρ_A A_{t−1} mezcla niveles y logaritmos: **ln A_t = ρ_A ln A_{t−1} + ε_t**.
- CRRA: θ en 3.A.6 y σ en 3.A.42: canon **θ**. Desutilidad del trabajo ζ (3.A.6): canon **χ**; inversa de Frisch **φ**.
- En 3.A.6, θ y β cambian de significado entre el modelo de Lucas y el RBC.
- La segunda ecuación de 3.A.42 (1 = β𝔼_t[(C_t/C_{t+1})αA_{t+1}K_{t+1}^{α−1}]) es la Euler con θ = 1 y δ = 1: decirlo explícitamente.

Autor: Víctor Gutiérrez Marcos
