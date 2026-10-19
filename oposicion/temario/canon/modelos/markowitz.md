# Selección de carteras media-varianza (Markowitz, 1952)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (… Teoría de la elección de cartera) — lo tiene en el título.
- **Temas que lo usan:** 3.B.23 (desarrollo), 3.A.10 (mención; hecho, 19/10/2026: anexo D «Aplicación: el modelo de media y varianza» y una frase en I.1.2 y I.2.2, con remisión a 3.B.23), 3.A.8 (mención; hecho: el activo como conjunto de 2 características en el anexo de Lancaster, l. 1638)
- **Manuales de referencia:** Markowitz (1952, *JF*); Bodie, Kane y Marcus, caps. 7-8; Elton, Gruber, Brown y Goetzmann, caps. 4-6; Mas-Colell, Whinston y Green, cap. 6 (fundamento de utilidad esperada).
- **Decisión D063 (13/10/2026):** ¿Mayúsculas o minúsculas para las rentabilidades (r_f, r_M, r_i)? Minúsculas r_f, r_M, r_i (Bodie-Kane-Marcus; coherente con r_E, r_D)

## Presentación de referencia
**Pregunta:** ¿cómo elige cartera un inversor averso al riesgo?

**Supuestos:** el inversor valora solo $\mathbb{E}(r_p)$ y $\sigma_p$ (utilidad cuadrática o rendimientos normales), aversión al riesgo, un periodo, solo activos con riesgo.

**Ecuaciones (notación canónica):**
$$\mathbb{E}(r_p) = \sum_i w_i\, \mathbb{E}(r_i), \qquad \sigma_p^2 = \sum_i\sum_j w_i w_j \sigma_{ij}, \qquad \sum_i w_i = 1$$
**Resultado:** diversificación (el riesgo de la cartera depende de las covarianzas); frontera eficiente; la cartera óptima es la tangencia con la curva de indiferencia más alta.

**Gráfico de referencia:** plano $(\sigma_p, \mathbb{E}(r_p))$ con el conjunto de oportunidades, la frontera eficiente y curvas de indiferencia. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras | desarrollo | Modelo, frontera eficiente, modelo de índice de Sharpe | — |
| 3.A.10 | Elección con riesgo | mención (hecho, 19/10/2026) | Anexo D: cuándo la utilidad esperada se reduce a media y varianza (u cuadrática, 𝔼[u] = 𝔼[W̃] − (b/2)(𝔼[W̃]² + σ²), o rendimientos normales o elípticos, Chamberlain, 1983; con CARA y normal, ξ = 𝔼[W̃] − (a/2)σ²), curvas de indiferencia crecientes y convexas en (σ, 𝔼) y **una frase** con la frontera eficiente y la tangencia, con `\vertema{3.B.23}`; Nobel de 1990 | La frontera eficiente desarrollada, Tobin, CAPM |
| 3.A.8 | Teoría de las características (Lancaster) | mención (hecho) | Un activo como 2 características (rentabilidad esperada y riesgo); la tangencia con la frontera eficiente remitida hoy a 3.A.10: añadir `\vertema{3.B.23}` (`pendientes-coherencia.md`) | El modelo |

## Divergencias encontradas en el temario actual
- Pesos $X_i$ (Markowitz), $w$ (Tobin) y $w_i$ (Sharpe) dentro de 3.B.23. Canon: $w_i$ en todo el tema.
- Rendimientos $R_i$ en 3.B.23: canon $r_i$ (ver `capm`).
- Esperanza: $\mathbb{E}(r_p)$, no $E(r_p)$ (`notacion.md` § 0 y § 11, D013; la E latina es la función de gasto y el tipo de cambio). Corregido en esta ficha el 19/10/2026.
- 3.A.8 (revisado, l. 1638) remite la frontera eficiente a 3.A.10, que solo la menciona: añadir `\vertema{3.B.23}` (`pendientes-coherencia.md`, 19/10/2026).
- 3.A.10 original: el anexo 4 de Markowitz estaba vacío y la media-varianza se justificaba por el teorema central del límite. **Resuelto** (19/10/2026).

Autor: Víctor Gutiérrez Marcos
