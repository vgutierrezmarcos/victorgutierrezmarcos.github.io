# Dinámica y sostenibilidad de la deuda exterior

- **Área:** macro-abierta · **Tema de referencia:** 3.B.12 (… Análisis de sostenibilidad del déficit y de la deuda exterior) — lo tiene en el título.
- **Temas que lo usan:** 3.B.12 (desarrollo), 3.B.11 (resumen; hecho, 5/11/2026: `eq:dinamica-piin` en el cuerpo, III.3, y la derivación en el anexo E con `eq:pii-deuda` y `eq:saldo-estabilizador` en nominal), 3.B.22 (resumen), 1D01 (uso: V.4, dinámica de la PIIN `eq:dinamica-piin`)
- **Manuales de referencia:** Obstfeld y Rogoff, *Foundations…*, caps. 1-2 (restricción intertemporal); Milesi-Ferretti y Razin (1996), *Current-Account Sustainability*; FMI, *Staff Guidance Note for Public Debt Sustainability Analysis* (MAC DSA, 2013 y 2021) y el marco LIC DSF FMI-Banco Mundial.

## Presentación de referencia
**Pregunta:** ¿qué déficit exterior es compatible con una ratio de deuda exterior estable?

**Supuestos:** todo el déficit se financia con deuda; tipo de interés real exterior $r^*$ y crecimiento real $\gamma_Y$ constantes (D012; el nominal es $\gamma^N$, con $1+\gamma^N=(1+\pi)(1+\gamma_Y)$, como en `restriccion-gobierno`).

**Ecuaciones (notación canónica; minúsculas = % del PIB):**
$$B_t = (1+i^*)B_{t-1} + D_t \;\Rightarrow\; b_t = \frac{1+r^*}{1+\gamma_Y}\,b_{t-1} + d_t$$
Ratio estable ($b_t = b_{t-1} = b$): $\; -d = b\,\dfrac{r^* - \gamma_Y}{1+\gamma_Y}$, es decir, el superávit comercial (no financiero) necesario crece con $b$ y con $r^* - \gamma_Y$.

**Resultado:** si $r^* > \gamma_Y$ hace falta superávit primario exterior para estabilizar la deuda; si $r^* < \gamma_Y$ se puede mantener un déficit.

**Forma nominal en términos de la PIIN** (anexo E del 3.B.11, 5/11/2026; equivalente a la de arriba): con $\mathrm{CF}_t=\mathrm{SX}_t+\mathrm{RI}_t$ ($\mathrm{SX}$ saldo exterior sin las rentas de la inversión, $\mathrm{RI}$ rentas netas de la inversión, locales), $\mathrm{RI}_t=i^A\,\mathrm{AE}_{t-1}-i^P\,\mathrm{PE}_{t-1}$ ($\mathrm{AE}$, $\mathrm{PE}$ activos y pasivos exteriores **en redonda**, nunca $A$, absorción, ni $P$; $i^A$, $i^P$ rendimientos implícitos, locales) y, si $i^A=i^P=i^*$, $\mathrm{PIIN}_t=(1+i^*)\mathrm{PIIN}_{t-1}+\mathrm{SX}_t+\mathrm{OV}_t$. Con $b_t\equiv-\mathrm{PIIN}_t/\mathrm{PIB}_t$ (deuda exterior neta) y $d_t\equiv-\mathrm{SX}_t/\mathrm{PIB}_t$:
$$b_t=\frac{1+i^*}{1+\gamma^N}\,b_{t-1}+d_t-\mathrm{ov}_t\quad(\texttt{eq:pii-deuda}),\qquad -d=\frac{i^*-\gamma^N}{1+\gamma^N}\,b\quad(\texttt{eq:saldo-estabilizador})$$
**$\gamma^N$ nominal**, porque $i^*$ es nominal (el Word del 3.B.11 escribía $\gamma^Y_t$ sin decirlo). $d$ minúscula es un déficit en % del PIB (no los derivados D de la cuenta financiera, avisado). Lectura: si $i^*>\gamma^N$, hace falta un superávit sin rentas de la inversión solo para que la deuda neta no crezca (la «bola de nieve»); con rendimientos distintos, un deudor neto puede cobrar rentas netas positivas (Estados Unidos). Equivalencia con `eq:dinamica-piin`: dividir $\mathrm{PIIN}_t=\mathrm{PIIN}_{t-1}+\mathrm{CF}_t+\mathrm{OV}_t$ por $\mathrm{PIB}_t$ (allí las rentas de la inversión van dentro de la CF).

**Gráfico de referencia:** $b_t$ frente a $b_{t-1}$ con la recta de pendiente $(1+r^*)/(1+\gamma_Y)$ y la bisectriz (estabilidad o explosión). Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.12 | Sostenibilidad del déficit y de la deuda exterior | desarrollo | Dinámica, condición de estabilidad, solvencia frente a sostenibilidad (Milesi-Ferretti y Razin) e indicadores | — |
| 3.B.22 | El FMI | resumen | El DSA como herramienta: escenarios, *fan charts*, umbrales; remitir a la ecuación de 3.B.12 | La derivación |
| 1D01 | Dictamen de coyuntura | Uso | En términos de PIIN y con la capacidad de financiación, que ya incluye los intereses: $\mathrm{PIIN}_t-\mathrm{PIIN}_{t-1}\approx\mathrm{CF}_t+\mathrm{OV}_t-\frac{\gamma^N_t}{1+\gamma^N_t}\mathrm{PIIN}_{t-1}$ (OV otras variaciones: valoración); equivale a la de arriba con $b=-\mathrm{PIIN}$ si se separan los intereses | La condición de estabilidad derivada |
| 3.B.11 | Interpretación del saldo agregado (hoja de balance) | resumen (hecho, 5/11/2026) | En el cuerpo (III.3), `eq:dinamica-piin` como la 1D01 y la condición de palabra («no se puede estirar el brazo más que la manga»: la manga es el crecimiento, el brazo el tipo); en el anexo E, la forma nominal de arriba con $b\equiv-\mathrm{PIIN}/\mathrm{PIB}$, $d$ sin rentas de la inversión, $i^A$, $i^P$, $\mathrm{AE}$, $\mathrm{PE}$ locales, un ejemplo numérico ilustrativo (deuda neta del 41 %, 2 puntos de diferencia: déficit estabilizador de unos 0,8 puntos; B11-18) y las políticas de ajuste en resumen; `\vertema{3.B.12}` | La solvencia frente a la sostenibilidad y los indicadores (3.B.12); el gráfico de referencia |
| 4.B (deuda pública) | Sostenibilidad de la deuda pública | (paralelo) | Misma ecuación con saldo primario público: usar idéntica forma y notación ($b$, $d$, $r$, $\gamma_Y$) | — |

## Divergencias encontradas en el temario actual
- En 3.B.12 $B$ es deuda externa y $D$ déficit comercial, mientras en 3.B.17 $D^*$ es deuda y en macro cerrada $B$ son bonos y $D$ depósitos/deuda pública. Canon: $B$ deuda (exterior o pública según el tema), $D$ déficit (comercial o primario), minúsculas en % del PIB, y siempre definirlas.
- La ecuación usa $i^*$ en niveles y $r^*$ en ratios; canon: escribir ambas versiones explícitamente (nominal con $i^*$ y $\gamma^N$, real con $r^*$ y $\gamma_Y$) para no mezclar.
- **Esta ficha** escribía $\gamma^Y$ (superíndice) y «$\gamma^{Y}_{nom}$»: corregido el 24/10/2026 a $\gamma_Y$ (D012) y $\gamma^N$ (C5 de la 1D01).
- **1D01 (aprobada, no se toca sin Víctor)**: el saldo que estabiliza la deuda externa (l. 1322-1326) usa $D^*$ para la deuda externa sobre el PIB y $\mathrm{CC}^{\text{sin int.}}$ para el saldo corriente sin intereses: $\mathrm{CC}^{\text{sin int.}}=\frac{i^*-\gamma^N}{1+\gamma^N}D^*$. Es la misma condición que `eq:saldo-estabilizador` con $D^*=b$ y $\mathrm{CC}^{\text{sin int.}}=-d$, pero choca con la regla del § 9 (D, d déficit; B, b deuda) y con $D^*$ de la deuda del 3.B.17. Propuesta en `pendientes-coherencia.md` («Pendiente del 3.B.11», **[decidir]**): cambiar a $b$ y $-d$ o añadir una nota que diga que $D^*$ es la $b$ de esta ficha (3.B.11, contradicción 6 de su fase de contenido).
- Original de la 1D01 (corregido en la guía): «PIIN_t − PIIN_{t−1} ≈ PIIN_{t−1}(i_t − g_t) + CC_t + CK_t» contaba dos veces los intereses (ya están en la CC) y usaba g, que es el progreso técnico (D010).

Autor: Víctor Gutiérrez Marcos
