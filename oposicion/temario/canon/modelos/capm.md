# CAPM (Sharpe, 1964; Lintner, 1965; Mossin, 1966)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (… modelo de valoración de los activos de capital (CAPM)) — lo tiene en el título.
- **Temas que lo usan:** 3.B.23 (desarrollo), 3.B.2 (resumen → mención), 3.B.3 (mención)
- **Manuales de referencia:** Sharpe (1964); Bodie, Kane y Marcus, *Investments*, cap. 9; Elton, Gruber, Brown y Goetzmann, *Modern Portfolio Theory and Investment Analysis*, cap. 13; Cochrane, *Asset Pricing*; Fama y French (2004, *JEP*).
- **Decisión D063 (13/10/2026):** ¿Mayúsculas o minúsculas para las rentabilidades (r_f, r_M, r_i)? Minúsculas r_f, r_M, r_i (Bodie-Kane-Marcus; coherente con r_E, r_D)

## Presentación de referencia
**Pregunta:** ¿qué rentabilidad debe exigirse a un activo según su riesgo?

**Supuestos:** inversores media-varianza con expectativas homogéneas, un periodo, activo libre de riesgo con préstamo y endeudamiento ilimitados a $r_f$, sin impuestos ni costes, activos divisibles.

**Ecuaciones (notación canónica):**
$$\beta_i = \frac{\mathrm{Cov}(r_i, r_M)}{\mathrm{Var}(r_M)}, \qquad SML:\; E(r_i) = r_f + \beta_i\,[E(r_M) - r_f], \qquad \beta_p = \sum_i w_i \beta_i$$
**Resultado:** solo se remunera el riesgo sistemático; todos mantienen la cartera de mercado (separación en dos fondos).

**Gráfico de referencia:** SML en $(\beta, E(r))$ con ordenada $r_f$ y pendiente $E(r_M) - r_f$; activos por encima (infravalorados, $\alpha > 0$) y por debajo. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras y CAPM | desarrollo | Derivación desde Tobin, SML frente a CML, contrastes (Roll, Fama-French) | — |
| 3.B.2 | Coste del capital | mención | $r_E = r_f + \beta_E[E(r_M) - r_f]$ para estimar $r_E$ y la beta del proyecto [ver tema 3.B.23] | Supuestos y derivación |
| 3.B.3 | Financiación | mención | Ídem, y beta apalancada (Hamada) | — |

## Divergencias encontradas en el temario actual
- **Mayúsculas y minúsculas**: $r_f$, $r_M$ en 3.B.2-3.B.3 y $R_f$, $R_M$ en 3.B.23. Canon: minúsculas $r_f$, $r_i$, $r_M$ (Bodie-Kane-Marcus; coherente con $r_E$, $r_D$ de 3.B.2-3.B.4).
- **Error en 3.B.23**: $\beta_i$ se define bien como $\mathrm{cov}(R_i,R_M)/\mathrm{var}(R_M)$ y después como $\mathrm{Cov}(E[R_i], E[R_M])/\mathrm{Var}(R_M)$ (covarianza de dos constantes = 0). Corregir la segunda.
- La prima de riesgo se escribe $\rho$ en 3.B.2 (y $\rho$ es el parámetro CES en comercio): canon $E(r_M) - r_f$ sin símbolo propio, o $\lambda_M$ como en 3.B.23.

Autor: Víctor Gutiérrez Marcos
