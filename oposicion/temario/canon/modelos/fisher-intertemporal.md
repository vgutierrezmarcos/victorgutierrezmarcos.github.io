# Elección intertemporal de Fisher (dos periodos)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.33 (teorías del consumo) — es la base microeconómica de ciclo vital y renta permanente.
- **Temas que lo usan:** 3.A.33 (desarrollo), 3.A.29 (desarrollo → resumen), 4.B.9 (desarrollo: impuestos y ahorro), 4.B.10 (desarrollo: impuestos)
- **Manuales de referencia:** Fisher, *The Theory of Interest* (1930); Romer (2019), cap. 8; Heijdra (2017); Mas-Colell, Whinston y Green (1995), cap. 20; Rosen y Gayer (imposición del ahorro).
- **Decisión D001 (13/10/2026):** ¿Qué letra lleva el coeficiente de aversión relativa al riesgo (CRRA) de u(c)=c^{1−θ}/(1−θ), y cómo se escribe la elasticidad de sustitución intertemporal? θ para la CRRA en todo el temario y la ESI como 1/θ, sin símbolo propio; σ queda para la elasticidad de sustitución intratemporal (CES, Dixit-Stiglitz) y la desviación típica
- **Decisión D099 (13/10/2026):** ¿Dónde se desarrolla el modelo de Fisher con impuestos (consumo-ahorro)? En 4.B.10 (efectos incentivo sobre el ahorro); 4.B.9 lo resume

## Presentación de referencia
Pregunta: ¿cómo reparte un hogar el consumo entre hoy y mañana? Supuestos: dos periodos; rentas Y_1, Y_2; mercado de capitales perfecto (presta y pide prestado al tipo real r); preferencias U(C_1, C_2) = u(C_1) + β u(C_2), con β ≡ 1/(1+ρ).

$$\max\; u(C_1) + \beta\,u(C_2)\quad\text{s.a.}\quad C_1 + \frac{C_2}{1+r} = Y_1 + \frac{Y_2}{1+r}$$
$$u'(C_1) = \beta\,(1+r)\,u'(C_2) = \frac{1+r}{1+\rho}\,u'(C_2)\quad(\text{ecuación de Euler})$$
Con CRRA, u(C) = C^{1−θ}/(1−θ): $\;C_2/C_1 = [(1+r)/(1+\rho)]^{1/\theta}$, y 1/θ es la elasticidad de sustitución intertemporal.
Resultado: el consumo depende de la riqueza (valor actual de las rentas), no de la renta corriente; un cambio de r tiene efecto sustitución (más ahorro) y efecto renta (de signo opuesto si el hogar es prestamista).
Gráfico de referencia: plano (C_1, C_2); restricción presupuestaria con pendiente −(1+r) que pasa por el punto de dotación (Y_1, Y_2); curva de indiferencia tangente; un aumento de r gira la recta sobre el punto de dotación (prestamista frente a prestatario).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Microfundamentos del consumo | desarrollo | Modelo completo, Euler, efectos del tipo de interés, restricciones de liquidez; puente a ciclo vital y renta permanente | — |
| 3.A.29 | Modelización dinámica | resumen | Euler como piedra angular; generalización a T periodos y a horizonte infinito | La derivación gráfica [ver tema 3.A.33] |
| 4.B.9 | Imposición y ahorro | desarrollo (aplicación) | Mismo gráfico con impuestos de suma fija (traslación), sobre el consumo y sobre los intereses (giro: r(1−t_r)) | La derivación básica |
| 4.B.10 | Efectos de los impuestos | desarrollo (aplicación) | Igual que 4.B.9 con ahorro privado, público y nacional; giro en el punto de ahorro nulo | Idem; coordinar con 4.B.9 para no duplicar |

## Divergencias encontradas en el temario actual
- Desarrollado en cuatro temas con notaciones distintas: c_t, r_t (3.A.29); C_1, C_2, r (4.B.9, 4.B.10). Propuesta: **C_1, C_2, r** en el modelo de dos periodos; C_t en la generalización.
- 3.A.29 llama σ a la ESI («ESI ≡ σ = 1/θ»): canon **1/θ** sin símbolo propio (σ queda para la elasticidad de sustitución intratemporal).
- 4.B.9 y 4.B.10 desarrollan el mismo bloque casi igual: el desarrollo (efectos incentivo sobre el ahorro) va en 4.B.10 y 4.B.9 lo resume.

Autor: Víctor Gutiérrez Marcos
