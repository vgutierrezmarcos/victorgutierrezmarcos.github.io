# Teoría cuantitativa del dinero (Fisher; escuela de Cambridge) y neocuantitativismo de Friedman

- **Área:** macro cerrada · **Tema de referencia:** 3.A.35 (Teorías de la demanda de dinero) — primera teoría de la demanda de dinero; único tema que la desarrolla.
- **Temas que lo usan:** 3.A.35 (desarrollo), 3.A.2 (mención: clásicos, currency frente a banking school), 3.A.5 (resumen; hecho, 3/11/2026: II.2.1 c) con `eq:demanda-dinero-friedman`, la LM de Cambridge como caso clásico $h=0$ en I.2 y `eq:cuantitativa` con la regla del k % en III.1), 3.A.37 (resumen: transmisión clásica), 3.A.41 (resumen: inflación como fenómeno monetario).
- **Manuales de referencia:** Fisher (1911), *The Purchasing Power of Money*; Pigou (1917), Marshall; Friedman (1956), «The Quantity Theory of Money: A Restatement»; Walsh (2017), cap. 2; Mishkin (2013), cap. 19.

## Presentación de referencia

**Pregunta:** ¿qué determina la demanda de dinero y el nivel de precios?

**Ecuaciones:**

$$\text{Fisher (ecuación de cambio):}\quad M V = P T \ \ (\text{o } MV = PY);\qquad M^D = \frac{PT}{V}$$

$$\text{Cambridge:}\quad \frac{M^D}{P} = k\,Y,\qquad k = 1/V$$

$$\text{Friedman (1956):}\quad \frac{M^D}{P} = f\!\left(\underset{+}{Y^P},\ \underset{-}{r_b - r_m},\ \underset{-}{r_e - r_m},\ \underset{-}{\pi^e - r_m},\ \underset{+}{\overline W_H/\overline W}\right)$$

con $Y^P$ la renta permanente, variable de escala ($Y^P=r\,\overline W$, el rendimiento de la riqueza total; ficha `renta-permanente`), $r_m$, $r_b$, $r_e$ los rendimientos esperados del dinero, los bonos y las acciones, $\pi^e$ el de los bienes físicos y **$\overline W_H/\overline W$ el peso de la riqueza humana** en la riqueza total (no se puede vender ni pignorar con facilidad). Nunca **$w$** (es el salario real, D026) ni $W_L/W$ ($W$ es el salario nominal): forma fijada en el 3.A.5 (3/11/2026, CC3, C52), `eq:demanda-dinero-friedman`. Es estable y poco sensible al tipo ($h$ pequeño): LM inclinada y velocidad predecible.

En tasas (`eq:cuantitativa` del 3.A.5): γ_M + γ_V = π + γ_Y; con V y Y exógenas, la inflación la determina el crecimiento del dinero. **Regla del k %** (Friedman, 1960; `eq:regla-k`): **γ_M = γ̄_M**, constante (del 3 al 5 % anual), sin escribir $k$, que es la de Cambridge y la LM; no confundir con la **regla de Friedman (1969)** de la cantidad óptima de dinero, i = 0 y π = −r (ficha `regla-friedman`, 3.A.41). **Cambridge es la LM con h = 0**: el caso clásico del IS-LM, Y = (1/k)M/P (ficha `is-lm`).

**Resultado:** neutralidad del dinero y dicotomía clásica; Friedman: demanda estable en función de la renta permanente → regla de crecimiento constante del dinero (ficha `monetarismo`, 3.A.5).

**Gráfico de referencia:** no imprescindible; si se usa, la velocidad observada: `oposicion/temario/fuentes/3A05/graficos/velocidad-dinero.tex` (FRED, M2V y M1V, 1959-2026, con 1979-1982 y 1993 marcados).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.35 | Demanda de dinero | Desarrollo | Fisher, Cambridge (k como decisión), Friedman 1956, evidencia sobre la estabilidad de V | — |
| 3.A.2 | Clásicos | Mención | Hume, Ricardo; currency frente a banking school | Las ecuaciones de Cambridge y Friedman |
| 3.A.5 | Monetarismo | resumen (hecho, 3/11/2026) | Friedman (1956) con $\overline W_H/\overline W$, estabilidad, LM inclinada y velocidad predecible (II.2.1 c); Cambridge como LM con $h=0$ (I.2); $\gamma_M+\gamma_V=\pi+\gamma_Y$ y la regla del k % $\gamma_M=\overline\gamma_M$, con la regla de Friedman (1969) separada en nota (III.1); la velocidad deja de ser estable (gráfico `velocidad-dinero`, Goodhart) | La ecuación de Fisher en extenso |
| 3.A.37 | Transmisión | Resumen | Transmisión directa (efecto saldos reales) en el modelo clásico | — |
| 3.A.41 | Inflación | Resumen | γ_M + γ_V = π + γ_Y; inflación a largo plazo como fenómeno monetario | — |

## Divergencias encontradas en el temario actual

- k de Cambridge choca con k capital por trabajador solo de forma nominal (no conviven). Por la k de la LM, en el 3.A.5 la renta permanente se escribe $C^P_t\propto Y^P_t$ (ficha `renta-permanente`) y la regla del k % no lleva $k$ en la fórmula.
- **Esta ficha escribía $w$** para la composición de la riqueza en Friedman (1956), que en la macro es el salario real: corregido a $\overline W_H/\overline W$ (3.A.5, 3/11/2026, CC3).
- **3.A.35 (sin revisar)**: la demanda de Friedman con $W_L/W$ → $\overline W_H/\overline W$, con `\vertema{3.A.33}` para la renta permanente y `\vertema{3.A.5}` para el monetarismo.
- **Resuelto en el 3.A.5** (3/11/2026): el epígrafe de la demanda de dinero estaba vacío.

Autor: Víctor Gutiérrez Marcos
