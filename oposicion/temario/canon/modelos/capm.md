# CAPM (Sharpe, 1964; Lintner, 1965; Mossin, 1966)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.23 (… modelo de valoración de los activos de capital (CAPM)) — lo tiene en el título.
- **Temas que lo usan:** 3.B.23 (desarrollo; hecho, 8/11/2026), 3.B.2 (mención; hecho, 8/11/2026: $r_E=r_f+\beta_E\lambda_M$ y $r_A=r_f+\beta_A\lambda_M$ para el proyecto, con Hamada), 3.B.3 (mención; hecho, 8/11/2026: una línea con $\lambda_M$), 3.B.4 (mención: viñeta con `\vertema{3.B.23}`), 3.B.25 (mención: la prima de riesgo de un futuro depende de la beta del subyacente, Dusak, 1973; anexo C)
- **Manuales de referencia:** Sharpe (1964); Bodie, Kane y Marcus, *Investments*, cap. 9; Elton, Gruber, Brown y Goetzmann, *Modern Portfolio Theory and Investment Analysis*, cap. 13; Cochrane, *Asset Pricing*; Fama y French (2004, *JEP*).
- **Decisión D063 (13/10/2026):** ¿Mayúsculas o minúsculas para las rentabilidades (r_f, r_M, r_i)? Minúsculas r_f, r_M, r_i (Bodie-Kane-Marcus; coherente con r_E, r_D)

## Presentación de referencia
**Pregunta:** ¿qué rentabilidad debe exigirse a un activo según su riesgo?

**Supuestos:** inversores media-varianza con expectativas homogéneas, un periodo, activo libre de riesgo con préstamo y endeudamiento ilimitados a $r_f$, sin impuestos ni costes, activos divisibles.

**Ecuaciones (notación canónica):**
$$\beta_i = \frac{\mathrm{Cov}(r_i, r_M)}{\mathrm{Var}(r_M)}, \qquad SML:\; \mathbb{E}[r_i] = r_f + \beta_i\,\lambda_M,\quad \lambda_M\equiv\mathbb{E}[r_M] - r_f, \qquad \beta_p = \sum_i w_i \beta_i$$
Derivación (3.B.23): por la contribución marginal de cada activo al riesgo de la cartera de mercado $M$. Extensiones: CAPM de beta cero (Black, 1972), ICAPM (Merton, 1973), C-CAPM (ficha `ccapm`, `\vertema{3.A.33}`). Crítica de Roll (1977) y, para España, Rubio (1986). Covarianza y varianza con mayúscula, $\mathrm{Cov}$, $\mathrm{Var}$; correlación $\mathrm{corr}(r_i,r_j)$ (nunca ρ; `notacion.md` § 11).
**Resultado:** solo se remunera el riesgo sistemático; todos mantienen la cartera de mercado (separación en dos fondos).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B23/graficos/sml.tex` (`fig:sml`: SML en $(\beta,\mathbb{E}[r])$ con ordenada $r_f$ y pendiente $\lambda_M$; activos por encima, $\alpha>0$, y por debajo; pasada final, nov. 2026).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.23 | Teoría de carteras y CAPM | desarrollo | Derivación desde Tobin, SML frente a CML, contrastes (Roll, Fama-French) | — |
| 3.B.2 | Coste del capital | mención (hecho, 8/11/2026) | $r_E=r_f+\beta_E\lambda_M$ y $r_A=r_f+\beta_A\lambda_M$ para el proyecto, con Hamada `\vertema{3.B.23}` | Supuestos y derivación |
| 3.B.3 | Financiación | mención (hecho, 8/11/2026) | Una línea con $\lambda_M$; beta apalancada (Hamada) | — |
| 3.B.4 | Valoración | mención (hecho, 8/11/2026) | Viñeta con `\vertema{3.B.23}` para el $r_E$ del DCF | La derivación |
| 3.B.25 | Derivados | mención (hecho, 8/11/2026) | Anexo C: la prima de riesgo de un futuro depende de la beta del subyacente (Dusak, 1973) | — |

## Divergencias encontradas en el temario actual
- **Resuelto (3.B.23, 8/11/2026; pasada final):** la $E$ latina de la esperanza pasa a $\mathbb{E}[\cdot]$ con corchetes (canon § 0) en esta ficha; la segunda definición errónea de $\beta_i$ desaparece; $\lambda_M$ es el símbolo de la prima del mercado.
- **Mayúsculas y minúsculas**: $r_f$, $r_M$ en 3.B.2-3.B.3 y $R_f$, $R_M$ en 3.B.23. Canon: minúsculas $r_f$, $r_i$, $r_M$ (Bodie-Kane-Marcus; coherente con $r_E$, $r_D$ de 3.B.2-3.B.4).
- **Error en 3.B.23**: $\beta_i$ se define bien como $\mathrm{cov}(R_i,R_M)/\mathrm{var}(R_M)$ y después como $\mathrm{Cov}(E[R_i], E[R_M])/\mathrm{Var}(R_M)$ (covarianza de dos constantes = 0). Corregir la segunda.
- La prima de riesgo se escribe $\rho$ en 3.B.2 (y $\rho$ es el parámetro CES en comercio): canon $E(r_M) - r_f$ sin símbolo propio, o $\lambda_M$ como en 3.B.23.
- 3.B.23 (sin revisar): no tiene el C-CAPM; debe resumirlo como generalización del CAPM (beta de consumo, Breeden, 1979) con `\vertema{3.A.33}` (ficha `ccapm`, tema de referencia 3.A.33).
- **No confundir (fase canon del 3.B.19, 12/11/2026):** la «beta apalancada de Hamada» (3.B.2, 3.B.3, 3.B.23) es de **Robert Hamada (1972)**; el diagrama de la coordinación monetaria del 3.B.19 es de **Koichi Hamada (1974, 1976)** (ficha `hamada-coordinacion`). El 3.B.19 lo avisa en una nota al pie.

Autor: Víctor Gutiérrez Marcos
