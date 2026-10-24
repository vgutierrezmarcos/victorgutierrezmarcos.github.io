# Dinámica y sostenibilidad de la deuda exterior

- **Área:** macro-abierta · **Tema de referencia:** 3.B.12 (… Análisis de sostenibilidad del déficit y de la deuda exterior) — lo tiene en el título.
- **Temas que lo usan:** 3.B.12 (desarrollo), 3.B.22 (resumen), 1D01 (uso: V.4, dinámica de la PIIN `eq:dinamica-piin`)
- **Manuales de referencia:** Obstfeld y Rogoff, *Foundations…*, caps. 1-2 (restricción intertemporal); Milesi-Ferretti y Razin (1996), *Current-Account Sustainability*; FMI, *Staff Guidance Note for Public Debt Sustainability Analysis* (MAC DSA, 2013 y 2021) y el marco LIC DSF FMI-Banco Mundial.

## Presentación de referencia
**Pregunta:** ¿qué déficit exterior es compatible con una ratio de deuda exterior estable?

**Supuestos:** todo el déficit se financia con deuda; tipo de interés real exterior $r^*$ y crecimiento real $\gamma_Y$ constantes (D012; el nominal es $\gamma^N$, con $1+\gamma^N=(1+\pi)(1+\gamma_Y)$, como en `restriccion-gobierno`).

**Ecuaciones (notación canónica; minúsculas = % del PIB):**
$$B_t = (1+i^*)B_{t-1} + D_t \;\Rightarrow\; b_t = \frac{1+r^*}{1+\gamma_Y}\,b_{t-1} + d_t$$
Ratio estable ($b_t = b_{t-1} = b$): $\; -d = b\,\dfrac{r^* - \gamma_Y}{1+\gamma_Y}$, es decir, el superávit comercial (no financiero) necesario crece con $b$ y con $r^* - \gamma_Y$.

**Resultado:** si $r^* > \gamma_Y$ hace falta superávit primario exterior para estabilizar la deuda; si $r^* < \gamma_Y$ se puede mantener un déficit.

**Gráfico de referencia:** $b_t$ frente a $b_{t-1}$ con la recta de pendiente $(1+r^*)/(1+\gamma_Y)$ y la bisectriz (estabilidad o explosión). Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.12 | Sostenibilidad del déficit y de la deuda exterior | desarrollo | Dinámica, condición de estabilidad, solvencia frente a sostenibilidad (Milesi-Ferretti y Razin) e indicadores | — |
| 3.B.22 | El FMI | resumen | El DSA como herramienta: escenarios, *fan charts*, umbrales; remitir a la ecuación de 3.B.12 | La derivación |
| 1D01 | Dictamen de coyuntura | Uso | En términos de PIIN y con la capacidad de financiación, que ya incluye los intereses: $\mathrm{PIIN}_t-\mathrm{PIIN}_{t-1}\approx\mathrm{CF}_t+\mathrm{OV}_t-\frac{\gamma^N_t}{1+\gamma^N_t}\mathrm{PIIN}_{t-1}$ (OV otras variaciones: valoración); equivale a la de arriba con $b=-\mathrm{PIIN}$ si se separan los intereses | La condición de estabilidad derivada |
| 4.B (deuda pública) | Sostenibilidad de la deuda pública | (paralelo) | Misma ecuación con saldo primario público: usar idéntica forma y notación ($b$, $d$, $r$, $\gamma_Y$) | — |

## Divergencias encontradas en el temario actual
- En 3.B.12 $B$ es deuda externa y $D$ déficit comercial, mientras en 3.B.17 $D^*$ es deuda y en macro cerrada $B$ son bonos y $D$ depósitos/deuda pública. Canon: $B$ deuda (exterior o pública según el tema), $D$ déficit (comercial o primario), minúsculas en % del PIB, y siempre definirlas.
- La ecuación usa $i^*$ en niveles y $r^*$ en ratios; canon: escribir ambas versiones explícitamente (nominal con $i^*$ y $\gamma^N$, real con $r^*$ y $\gamma_Y$) para no mezclar.
- **Esta ficha** escribía $\gamma^Y$ (superíndice) y «$\gamma^{Y}_{nom}$»: corregido el 24/10/2026 a $\gamma_Y$ (D012) y $\gamma^N$ (C5 de la 1D01).
- Original de la 1D01 (corregido en la guía): «PIIN_t − PIIN_{t−1} ≈ PIIN_{t−1}(i_t − g_t) + CC_t + CK_t» contaba dos veces los intereses (ya están en la CC) y usaba g, que es el progreso técnico (D010).

Autor: Víctor Gutiérrez Marcos
