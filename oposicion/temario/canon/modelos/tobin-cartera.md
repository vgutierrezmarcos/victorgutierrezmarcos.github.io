# Carteras mixtas y separación (Tobin, 1958); línea del mercado de capitales

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (Teoría de la elección de cartera) — lo desarrolla con ecuaciones y gráficos; 3.A.35 (revisado el 5/11/2026) desarrolla la **variante monetaria** de Tobin (1958) en II.1.2 «La cartera de Tobin (1958)», a)-c), con `eq:tobin` y el gráfico de 2 cuadrantes `tobin-cartera`: es la referencia de esa variante (la CML y la separación siguen en el 3.B.23).
- **Temas que lo usan:** 3.B.23 (desarrollo), 3.A.35 (desarrollo de la variante monetaria; hecho, 5/11/2026), 3.A.10 (mención; hecho, 19/10/2026: demanda de un activo con riesgo de Arrow en I.2.2, «no se canta», con la extensión a varios activos y al dinero como activo seguro, y Tobin (1958) en el anexo D para las condiciones de la media-varianza)
- **Manuales de referencia:** Tobin (1958, *RES*), «Liquidity Preference as Behavior Towards Risk»; Bodie, Kane y Marcus, cap. 6-7; Walsh, *Monetary Theory and Policy*, cap. 4 (dinero y cartera).

## Presentación de referencia
**Pregunta:** ¿cómo reparte el inversor entre un activo seguro y una cartera con riesgo?

**Ecuaciones (notación canónica):** $w$ = peso de la cartera con riesgo.
$$E(r_p) = (1-w)\,r_f + w\,E(r_M), \qquad \sigma_p = w\,\sigma_M, \qquad CML:\; E(r_p) = r_f + \frac{E(r_M) - r_f}{\sigma_M}\,\sigma_p$$
**Resultado:** teorema de separación: la composición de la cartera con riesgo (cartera de tangencia) no depende de las preferencias; la aversión al riesgo solo decide $w$.

**Variante monetaria (3.A.35, II.1.2; la de referencia para la demanda de dinero):** riqueza $\overline W$ entre dinero (sin rendimiento ni riesgo) y bonos perpetuos que rinden $i$ más una ganancia de capital $\tilde g$ de media nula y desviación típica **$\sigma_{\mathrm B}$** (avisado: «aquí $\tilde g$ no es el progreso técnico»); el inversor, averso al riesgo, pone en bonos la fracción **$w_{\mathrm B}$** (avisado: «aquí $w$ no es el salario»; D9 del 3.A.35):
$$r_p=w_{\mathrm B}(i+\tilde g),\quad \mathbb{E}[r_p]=w_{\mathrm B}\,i,\quad \sigma_p=w_{\mathrm B}\,\sigma_{\mathrm B}\ \Longrightarrow\ \mathbb{E}[r_p]=\frac{i}{\sigma_{\mathrm B}}\,\sigma_p\quad(\texttt{eq:tobin});\qquad w^*_{\mathrm B}=\frac{\sigma^*_p}{\sigma_{\mathrm B}},\quad M^D=(1-w^*_{\mathrm B})\,\overline W.$$
Curvas de indiferencia crecientes y convexas porque es averso; si sube $i$, la recta gira hacia arriba: **efecto sustitución** (menos dinero) y **efecto renta** (misma rentabilidad con menos riesgo: más dinero, si es muy averso); Tobin supone que domina el primero. Valoración: el dinero está **dominado** (letras, depósitos a plazo): explica la demanda de activos seguros, no la de dinero. Pegatina: «no poner todos los huevos en la misma cesta».

**Gráfico de referencia:** CML tangente a la frontera eficiente en $M$, con tramos de préstamo y endeudamiento (3.B.23, sin `.tex` aún). **Variante monetaria:** `oposicion/temario/fuentes/3A35/graficos/tobin-cartera.tex` (2 cuadrantes: arriba, la recta `eq:tobin` y la curva de indiferencia; abajo, $\sigma_p=w_{\mathrm B}\sigma_{\mathrm B}$).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras | desarrollo | Separación y CML como paso al CAPM | — |
| 3.A.10 | Elección con riesgo: demanda de un activo con riesgo | mención (hecho, 19/10/2026) | Problema de Arrow con un activo seguro r_f y uno con riesgo r̃: max 𝔼[u(W̄(1 + r_f) + α(r̃ − r_f))], α* > 0 si 𝔼[r̃] > r_f, normal con DARA, proporción constante con CRRA; «con el dinero como activo seguro, a la demanda de dinero por motivo especulación» (`\vertema{3.A.35}`) y a la cartera de Tobin (`\vertema{3.B.23}`). Allí α es la inversión en euros en el activo con riesgo (no el peso w) | La separación, la CML |
| 3.A.35 | Demanda de dinero (depósito de valor) | desarrollo de la variante monetaria (hecho, 5/11/2026) | a)-c) con `eq:tobin`, $w_{\mathrm B}$, $\sigma_{\mathrm B}$, $\mathbb{E}[r_p]$, $M^D=(1-w^*_{\mathrm B})\overline W$; efectos sustitución y renta de una subida de $i$; transmisión por carteras (`\vertema{3.A.37}`); dinero dominado; `\vertema{3.B.23}` (Markowitz) y `\vertema{3.A.10}` (aversión al riesgo) | La CML, la separación y el CAPM |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.A.35** (5/11/2026): el Word decía «Arrow y Tobin (1958)», escribía $\alpha$ (choca con la semielasticidad de Cagan en el mismo tema), $\sigma_g$ y $\sigma_B$, explicaba la convexidad «porque la aversión al riesgo es creciente» y el efecto renta con deudores y acreedores, y cerraba con el Reino Unido en 1992 (fuera, A35-09).
- **Esperanza:** esta ficha escribía $E(r_p)$; el canon es **$\mathbb{E}[r_p]$** (§ 0). El 3.B.23, al revisarse, con $\mathbb{E}[\cdot]$, $r_f$ y $w$ (peso de la cartera con riesgo; en la variante monetaria, $w_{\mathrm B}$) y la CML como `\funcionclave`.
- 3.B.23 con $R_f$ y $w$: unificar con $r_f$ y $w$.
- Id fusionado `tobin-separacion`: correcto.

Autor: Víctor Gutiérrez Marcos
