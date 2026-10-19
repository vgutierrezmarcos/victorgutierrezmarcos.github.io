# Carteras mixtas y separación (Tobin, 1958); línea del mercado de capitales

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (Teoría de la elección de cartera) — lo desarrolla con ecuaciones y gráficos; 3.A.35 usa Tobin (1958) como teoría del motivo especulación de la demanda de dinero.
- **Temas que lo usan:** 3.B.23 (desarrollo), 3.A.35 (desarrollo → resumen en clave monetaria), 3.A.10 (mención; hecho, 19/10/2026: demanda de un activo con riesgo de Arrow en I.2.2, «no se canta», con la extensión a varios activos y al dinero como activo seguro, y Tobin (1958) en el anexo D para las condiciones de la media-varianza)
- **Manuales de referencia:** Tobin (1958, *RES*), «Liquidity Preference as Behavior Towards Risk»; Bodie, Kane y Marcus, cap. 6-7; Walsh, *Monetary Theory and Policy*, cap. 4 (dinero y cartera).

## Presentación de referencia
**Pregunta:** ¿cómo reparte el inversor entre un activo seguro y una cartera con riesgo?

**Ecuaciones (notación canónica):** $w$ = peso de la cartera con riesgo.
$$E(r_p) = (1-w)\,r_f + w\,E(r_M), \qquad \sigma_p = w\,\sigma_M, \qquad CML:\; E(r_p) = r_f + \frac{E(r_M) - r_f}{\sigma_M}\,\sigma_p$$
**Resultado:** teorema de separación: la composición de la cartera con riesgo (cartera de tangencia) no depende de las preferencias; la aversión al riesgo solo decide $w$.

**Gráfico de referencia:** CML tangente a la frontera eficiente en $M$, con tramos de préstamo y endeudamiento; en 3.A.35, demanda de dinero (activo seguro) frente al bono con riesgo y efectos renta y sustitución de un $\uparrow i$. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras | desarrollo | Separación y CML como paso al CAPM | — |
| 3.A.10 | Elección con riesgo: demanda de un activo con riesgo | mención (hecho, 19/10/2026) | Problema de Arrow con un activo seguro r_f y uno con riesgo r̃: max 𝔼[u(W̄(1 + r_f) + α(r̃ − r_f))], α* > 0 si 𝔼[r̃] > r_f, normal con DARA, proporción constante con CRRA; «con el dinero como activo seguro, a la demanda de dinero por motivo especulación» (`\vertema{3.A.35}`) y a la cartera de Tobin (`\vertema{3.B.23}`). Allí α es la inversión en euros en el activo con riesgo (no el peso w) | La separación, la CML |
| 3.A.35 | Demanda de dinero | resumen | Variante monetaria: dinero como activo seguro, bonos con riesgo, elasticidad de la demanda de dinero al tipo de interés | La CML y el CAPM |

## Divergencias encontradas en el temario actual
- 3.A.35 lo presenta sin ecuaciones y 3.B.23 con $R_f$ y $w$: unificar con $r_f$ y $w$.
- Id fusionado `tobin-separacion`: correcto.

Autor: Víctor Gutiérrez Marcos
