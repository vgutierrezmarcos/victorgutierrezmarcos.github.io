# Modelo de búsqueda y emparejamiento de Diamond, Mortensen y Pissarides (DMP)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.26 (desempleo friccional, curva de Beveridge, DMP) — lo tiene en el título.
- **Temas que lo usan:** 3.A.26 (desarrollo), 3.A.28 (resumen), 3.A.7 (mención)
- **Manuales de referencia:** Pissarides, *Equilibrium Unemployment Theory* (2.ª ed., 2000), cap. 1; Cahuc, Carcillo y Zylberberg (2014), cap. 9; Romer (2019), cap. 11.
- **Decisión D008 (13/10/2026):** ¿Se reserva δ para la tasa de depreciación y se cambian sus otros usos? Sí: pendiente de la NKPC κ, tasa de separación s (DMP y Shapiro-Stiglitz) y tasa social de descuento r_s (4.B.6); δ solo depreciación (y el factor exponencial del modelo β-δ de Laibson)
- **Decisión D020 (13/10/2026):** ¿Se reserva λ para multiplicadores y precios sombra? Sí: factor de escala t (3.A.11), tasas de búsqueda f(θ) y q(θ) (DMP), persistencia de la histéresis λ_h con subíndice; se admite λ local en Laffont-Tirole (coste de los fondos públicos) y en Kahneman-Tversky
- **Decisión D023 (13/10/2026):** ¿Se reserva M para el dinero (y las importaciones) y se cambian sus otros usos? Sí: número de variedades de Romer (1990) N_t, función de emparejamiento m(U,V), renta no laboral W̄
- **Decisión D056 (13/10/2026):** ¿Se mantiene θ ≡ V/U para la tensión del mercado de trabajo aunque θ sea la CRRA? Sí, avisándolo: es la notación universal de la búsqueda (Pissarides, Cahuc) y 3.A.26 y 3.A.28 no usan la CRRA

## Presentación de referencia
Pregunta: ¿por qué hay paro y vacantes a la vez en equilibrio? Supuestos: fricciones de búsqueda; función de emparejamiento con rendimientos constantes; trabajadores y empresas idénticos; libre entrada de vacantes; salario por negociación de Nash; tasa exógena de separación.

$$m(U,V) = A\,U^{\alpha}V^{1-\alpha},\qquad \theta \equiv \frac{V}{U}$$
$$f(\theta) = \frac{m}{U} = A\,\theta^{1-\alpha},\qquad q(\theta) = \frac{m}{V} = A\,\theta^{-\alpha},\qquad f(\theta) = \theta\,q(\theta)$$
$$\text{flujos estacionarios:}\quad s\,(1-U) = f(\theta)\,U \;\Rightarrow\; U = \frac{s}{s+f(\theta)}\quad\text{(curva de Beveridge)}$$
Creación de empleo (libre entrada): coste esperado de la vacante = valor del empleo, $\frac{c}{q(\theta)} = \frac{y-w}{r+s}$. Curva salarial (Nash, poder negociador γ): $w = (1-\gamma)z + \gamma\,(y + c\,\theta)$.

Resultado: la tensión θ* sale de cruzar creación de empleo y curva salarial en (θ, w); con θ* la curva de Beveridge da U* y V*. El paro friccional es de equilibrio; la eficiencia exige la condición de Hosios (γ = α).
Gráficos de referencia: (1) plano (θ, w): curva de creación de empleo decreciente y curva salarial creciente; (2) plano (U, V): curva de Beveridge convexa y rayo V = θ*U desde el origen; los shocks agregados mueven a lo largo de la curva, los de eficiencia del emparejamiento o de separación la desplazan.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.26 | Paro friccional; curva de Beveridge | desarrollo | Modelo completo, estática comparativa, Hosios, evidencia (Shimer puzzle) | — |
| 3.A.28 | Tasa natural de paro y su persistencia | resumen | La tasa natural como resultado de flujos U = s/(s+f(θ)); desplazamientos de la curva de Beveridge | Derivación de la curva salarial [ver tema 3.A.26] |
| 3.A.7 | Fricciones en el mercado de trabajo en la NEK | mención | Citar como fuente de rigidez real en los EGDE con fricciones | Ecuaciones |

## Divergencias encontradas en el temario actual
- 3.A.26 usa δ para la tasa de separación (choca con δ = depreciación): canon **s** (igual en Shapiro-Stiglitz).
- λ(θ) y μ(θ) para las tasas de encontrar empleo y cubrir vacantes: canon **f(θ)** y **q(θ)** (λ es precio sombra en 3.A.29 y 3.A.43; μ es margen).
- M para la función de emparejamiento: propuesta **m(U,V)** (M es dinero).
- θ = tensión choca con θ = CRRA: se mantiene por ser universal en la literatura de búsqueda (Pissarides, Cahuc), avisándolo; 3.A.26 y 3.A.28 no usan la CRRA.

Autor: Víctor Gutiérrez Marcos
