# Modelo de Ramsey-Cass-Koopmans

- **Área:** macro cerrada · **Tema de referencia:** 3.A.43 (crecimiento I: Solow, MRW y Ramsey-Cass-Koopmans) — lo tiene en el título.
- **Temas que lo usan:** 3.A.43 (desarrollo), 3.A.29 (resumen: horizonte infinito), 3.A.42 (resumen: base del RBC), 3.A.6 (mención), 3.B.31 (resumen; hecho, 31/10/2026: base del DICE en tiempo discreto, con $\beta\equiv1/(1+\rho)$, $\theta$, $\alpha$, $\delta$, $A_t$, $c_t\equiv C_t/L_t$; la fórmula de Ramsey del descuento $r_s=\rho+\theta\gamma_c$ como la ecuación de Euler leída al revés, $\gamma_c\simeq(r-\rho)/\theta$, en caja gris; ficha `dice`)
- **Manuales de referencia:** Ramsey (1928), Cass (1965), Koopmans (1965); Romer (2019), cap. 2A; Barro y Sala i Martín (2004), cap. 2; Acemoglu (2009), cap. 8; Blanchard y Fischer (1989), cap. 2.
- **Decisión D010 (13/10/2026):** ¿Qué letras llevan la tasa de progreso técnico, el crecimiento del PIB y el gasto público en ratio? g = progreso técnico (regla de oro n+g+δ); γ_Y = crecimiento del PIB (también en las ecuaciones de deuda: r − γ_Y, y «r − g» solo como nombre del debate de Blanchard); g = G/Y en sector público
- **Decisión D026 (13/10/2026):** ¿Cómo se distinguen el salario real y el nominal en macro? w real y W nominal en todo el temario (como en WS-PS)

## Presentación de referencia
Pregunta: ¿qué pasa en el modelo neoclásico de crecimiento si el ahorro es una decisión óptima? Supuestos: hogares con horizonte infinito, utilidad CRRA (θ), descuento ρ, población que crece a n; empresas competitivas con F(K, AL) de rendimientos constantes, progreso técnico g; tiempo continuo; variables por unidad de trabajo eficiente (c, k).

$$\max \int_0^\infty e^{-(\rho-n)t}\,\frac{C_t^{1-\theta}}{1-\theta}\,dt\quad\text{s.a.}\quad \dot b_t = w_t + (r_t - n)\,b_t - C_t$$
$$\frac{\dot c_t}{c_t} = \frac{f'(k_t) - \delta - \rho - \theta g}{\theta},\qquad \dot k_t = f(k_t) - c_t - (n+g+\delta)\,k_t$$
$$r_t = f'(k_t) - \delta,\qquad w_t = A_t\,[f(k_t) - k_t f'(k_t)],\qquad \lim_{t\to\infty} \lambda_t k_t e^{-\rho t} = 0\ (\text{transversalidad})$$
Resultado: senda de silla única hacia el estado estacionario con **regla de oro modificada** $f'(k^*) = \rho + \delta + \theta g$ (k* menor que el de la regla de oro de Solow: no hay ineficiencia dinámica); el equilibrio descentralizado coincide con el del planificador (1.er teorema del bienestar).
Gráfico de referencia: diagrama de fases en (k, c): locus ċ = 0 vertical en k*, locus k̇ = 0 en forma de U invertida (máximo en la regla de oro), senda de silla; ejercicios: aumento de ρ, gasto público permanente/temporal.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.43 | Crecimiento con ahorro endógeno | desarrollo | Modelo completo, diagrama de fases, regla de oro modificada, comparación con Solow | — |
| 3.A.29 | Modelos de horizonte infinito | resumen | Como ejemplo de horizonte infinito frente a OLG; condición de transversalidad | Diagrama de fases [ver tema 3.A.43] |
| 3.A.42 | Ciclos reales | resumen | Punto de partida del RBC (añadiendo ocio y shocks) | Idem |
| 3.A.6 | NMC y EGDE | mención | Base del RBC | — |
| 3.B.31 | Modelos integrados de evaluación (DICE) | resumen (hecho, 31/10/2026) | El RCK en tiempo discreto, con periodos de 5 años, planificador mundial, daños $\Omega(T_t)$ y reducción $\mu_t$ (ficha `dice`); Euler → $r_s=\rho+\theta\gamma_c$ (`eq:ramsey-descuento`); los supuestos del RCK en una línea con `\vertema{3.A.43}` | El diagrama de fases |

## Divergencias encontradas en el temario actual
- 3.A.43 escribe la regla de oro modificada ∂y/∂k = δ + ρ, que solo vale sin progreso técnico: la general es **f'(k*) = ρ + δ + θg**.
- 3.A.43 usa W_t para el salario (real) y 3.A.29 w_t: canon **w** real (W nominal).
- 3.A.43 escribe la tasa de progreso técnico g en el cuerpo y m en el anexo: canon **g** (se elimina m).
- **Tiempo discreto en el 3.B.31** (DICE): $W=\sum_t\beta^tL_t\,c_t^{1-\theta}/(1-\theta)$ con $\beta\equiv1/(1+\rho)$, la misma $\theta$ y la misma $\rho$ que aquí; el 3.A.43, al revisarse, puede citar el DICE como extensión (ficha `dice`).
- El anexo de optimización dinámica de 3.A.29 debe coincidir con los de 3.A.33, 3.A.34 y 3.A.43 (nota del autor).

Autor: Víctor Gutiérrez Marcos
