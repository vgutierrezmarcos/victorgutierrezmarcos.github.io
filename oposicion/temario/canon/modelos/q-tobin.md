# q de Tobin con costes de ajuste (Tobin 1969; Summers 1981; Abel 1982; Hayashi 1982)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.34 (teorías de la inversión) — único tema que lo desarrolla.
- **Temas que lo usan:** 3.A.34 (desarrollo), 3.A.29 (resumen: optimización dinámica), 3.A.37 (resumen: canal de transmisión)
- **Manuales de referencia:** Romer (2019), cap. 9; Blanchard y Fischer (1989), cap. 2; Hayashi (1982).

## Presentación de referencia
Pregunta: ¿cómo invierte una empresa que mira al futuro si ajustar el capital es costoso? Supuestos: empresa competitiva, beneficio π(K) con π' > 0 > π''; coste de ajuste convexo Φ(I) con Φ(0) = Φ'(0) = 0, Φ'' > 0 (propuesta Φ en lugar de C(I) **[decidir]**); sin depreciación en la versión de Romer; precio del bien de capital = 1.

$$\max \int_0^\infty e^{-rt}\,[\pi(K_t) - I_t - \Phi(I_t)]\,dt\quad\text{s.a.}\quad \dot K_t = I_t$$
$$q_t = 1 + \Phi'(I_t),\qquad r\,q_t = \pi'(K_t) + \dot q_t$$
Resultado: la inversión es creciente en q (valor sombra de una unidad de capital); se invierte si q > 1. Con rendimientos constantes y coste de ajuste homogéneo (Hayashi), la q marginal es igual a la q media (valor de mercado / coste de reposición), observable en bolsa.
Gráfico de referencia: diagrama de fases en (K, q): locus K̇ = 0 horizontal en q = 1; locus q̇ = 0 decreciente; senda de silla. Una subida permanente de la demanda desplaza q̇ = 0 hacia arriba: q salta y converge.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.34 | Teorías de la inversión | desarrollo | Modelo, diagrama de fases, q marginal y media, evidencia (débil poder explicativo de q) | — |
| 3.A.29 | Modelización dinámica | resumen | Ejemplo de hamiltoniano con precio sombra | El diagrama completo; el propio autor dice que «está mucho mejor en el tema 3.A.34» |
| 3.A.37 | Transmisión de la política monetaria | resumen | Canal de q: tipo ↓ → precio de las acciones ↑ → q ↑ → inversión ↑ | Derivación |

## Divergencias encontradas en el temario actual
- El coste de ajuste se escribe C(I) en 3.A.34: C es consumo en el resto del bloque; propuesta **Φ(I)** **[decidir]**.
- 3.A.29 repite el bloque (hamiltoniano y precio sombra) de forma menos completa; 3.A.29 tiene además un anexo de optimización dinámica que el autor quiere común con 3.A.33, 3.A.34 y 3.A.43.

Autor: Víctor Gutiérrez Marcos
