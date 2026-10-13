# Selección de carteras media-varianza (Markowitz, 1952)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (… Teoría de la elección de cartera) — lo tiene en el título.
- **Temas que lo usan:** 3.B.23 (desarrollo), 3.A.10 (mención: aplicación de la elección con incertidumbre)
- **Manuales de referencia:** Markowitz (1952, *JF*); Bodie, Kane y Marcus, caps. 7-8; Elton, Gruber, Brown y Goetzmann, caps. 4-6; Mas-Colell, Whinston y Green, cap. 6 (fundamento de utilidad esperada).

## Presentación de referencia
**Pregunta:** ¿cómo elige cartera un inversor averso al riesgo?

**Supuestos:** el inversor valora solo $E(r_p)$ y $\sigma_p$ (utilidad cuadrática o rendimientos normales), aversión al riesgo, un periodo, solo activos con riesgo.

**Ecuaciones (notación canónica):**
$$E(r_p) = \sum_i w_i E(r_i), \qquad \sigma_p^2 = \sum_i\sum_j w_i w_j \sigma_{ij}, \qquad \sum_i w_i = 1$$
**Resultado:** diversificación (el riesgo de la cartera depende de las covarianzas); frontera eficiente; la cartera óptima es la tangencia con la curva de indiferencia más alta.

**Gráfico de referencia:** plano $(\sigma_p, E(r_p))$ con el conjunto de oportunidades, la frontera eficiente y curvas de indiferencia. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras | desarrollo | Modelo, frontera eficiente, modelo de índice de Sharpe | — |
| 3.A.10 | Elección con incertidumbre | mención | Media-varianza como caso particular de utilidad esperada (cuadrática o normalidad) [ver tema 3.B.23] | La frontera eficiente |

## Divergencias encontradas en el temario actual
- Pesos $X_i$ (Markowitz), $w$ (Tobin) y $w_i$ (Sharpe) dentro de 3.B.23. Canon: $w_i$ en todo el tema.
- Rendimientos $R_i$ en 3.B.23: canon $r_i$ (ver `capm`) **[decidir]**.

Autor: Víctor Gutiérrez Marcos
