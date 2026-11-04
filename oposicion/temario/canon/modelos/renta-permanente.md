# Renta permanente (Friedman, 1957)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: I.2.2 `sec:renta-permanente`) — lo tiene en el título.
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.5 (mención; hecho, 3/11/2026: II.2.1 a), `eq:renta-permanente` con $C^P_t\propto Y^P_t$ y $Y^P_t=r\overline W_t$; la $C^P_t=kY^P_t$ de Friedman, en nota, porque en el 3.A.5 $k$ es la de la LM), 3.A.35 (mención: la renta permanente en la demanda de dinero de Friedman), 3.A.39 (mención: la equivalencia ricardiana como implicación vecina), 1D01 (mención aplicada; hecho: el consumo, menos volátil porque se suaviza según la renta permanente, l. 411).
- **Manuales de referencia:** Friedman, *A Theory of the Consumption Function* (1957); Romer (2019), cap. 8; Blanchard y Fischer (1989), cap. 6.

## Presentación de referencia (3.A.33, I.2.2)

Pregunta: ¿por qué la propensión media a consumir es constante a largo plazo y decreciente en cortes transversales y series cortas? Estructura a)-d) (idea; modelo con supuestos, desarrollo e implicaciones; evidencia; valoración).

- **Supuestos:** Y_t = Y^P_t + Y^T_t y C_t = C^P_t + C^T_t; los transitorios con media cero, sin correlación entre sí ni con los permanentes; la renta permanente es el rendimiento de la riqueza total, humana y no humana, **Y^P_t = rW̄_t**.
- **Desarrollo:**
$$C^P_t=k\,Y^P_t\qquad(\texttt{eq:renta-permanente})$$
  k no depende del nivel de la renta (homotecia), sino del tipo de interés, de la composición de la riqueza y de los gustos; **de palabra** (sin k = f(r, W_L/W)): crece con el peso de la riqueza no humana (Friedman, 1957, pp. 16-17); efecto de r ambiguo. Expectativas adaptativas sobre la renta **observada** (`eq:expectativas-adaptativas`):
$$Y^P_t=Y^P_{t-1}+\gamma\,(Y_t-Y^P_{t-1})=\gamma\sum_{j=0}^{\infty}(1-\gamma)^j\,Y_{t-j},\qquad \gamma\in(0,1]$$
  (nota: horizonte de unos 3 años, estimado «con cautela», p. 226).
- **Implicaciones:** lo transitorio apenas mueve el consumo; rebaja transitoria de impuestos poco eficaz y multiplicador menor que el keynesiano (nota aparte: la **equivalencia ricardiana** va más allá, con `\vertema{3.A.39}`); política monetaria por el efecto riqueza; consumo más estable que la renta, sin estancamiento secular: base de la crítica monetarista (`\vertema{3.A.5}`).
- **Evidencia: solución del enigma de Kuznets:**
$$\hat b=\frac{\operatorname{cov}(C,Y)}{\operatorname{var}(Y)}=k\,\frac{\operatorname{var}(Y^P)}{\operatorname{var}(Y^P)+\operatorname{var}(Y^T)}<k\qquad(\texttt{eq:sesgo-friedman})$$
  corte transversal (suerte y mala suerte), series cortas (de E a F^T y, si persiste, a F^P) y largas (b̂ → k).
- **Valoración:** Y^P no se observa; contradicción interna (mira hacia delante para consumir y hacia atrás para estimar la renta) que resuelve Hall con expectativas racionales (ficha `hall`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A33/graficos/kuznets-duesenberry-friedman.tex` (**imprescindible**): el plano (Y, C) de `consumo-renta.tex` (ficha `keynes-renta-absoluta`) con C^P = kY^P desde el origen, la recta de corto plazo más plana y los puntos E, F^T, F^P. Es **un solo plano compartido** por Keynes, Kuznets, Duesenberry y Friedman, que se construye por capas en la pizarra (DC11/A33-11).

**Notación:** Y^P, Y^T, C^P, C^T; k; W̄_t riqueza total (§ 1: W es el salario nominal); **γ** de las expectativas adaptativas (la de Nerlove del canon, § 1; DC6/A33-06, **[decidir]**: la ficha decía λ, que queda para Campbell y Mankiw); b̂ pendiente estimada (local; no es b_t ni la b de la cuadrática).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Teorías del consumo | desarrollo (hecho, 31/10/2026) | Todo lo anterior en 2′30″, sobre el plano (Y, C) | — |
| 3.A.5 | Crítica monetarista a la síntesis | mención (hecho, 3/11/2026) | La función keynesiana $C_t=\overline C+c\,Y^d_t$ frente a **$C^P_t\propto Y^P_t$** («el consumo permanente es una proporción de la renta permanente que no depende de su nivel»), con la $k$ de Friedman en nota y el aviso frente a la $k$ de la LM (K13, **[decidir]**); lo transitorio apenas mueve el consumo, multiplicador menor y más estable, efecto riqueza de la política monetaria; la advertencia de Keynes citada igual (cap. 10, apdo. III); `\vertema{3.A.33}` y sin el gráfico `kuznets-duesenberry-friedman` | El modelo y el gráfico |
| 3.A.35 | Demanda de dinero | mención | La renta permanente como variable de escala de Friedman; **W̄** (no W_L/W) para la riqueza y `\vertema{3.A.33}` | El modelo de consumo |
| 3.A.39 | Déficit | mención (hecho, 4/11/2026) | Renta permanente frente a equivalencia ricardiana con la frase del 3.A.33 (l. 360): lo transitorio apenas mueve el consumo; la ER va más allá; la suavización impositiva es la suavización del consumo aplicada a los impuestos; `\vertema{3.A.33}` | — |
| 1D01 | Dictamen | mención aplicada (hecho) | El consumo se suaviza según la renta permanente | — |

## Divergencias encontradas en el temario actual
- 3.A.33 original: renta permanente estimada «con la renta permanente en el pasado» (circular), k = f(r, W_L/W), nota 14 que confundía renta permanente y equivalencia ricardiana, «1950s». **Resuelto** (31/10/2026).
- 3.A.5 escribía la función keynesiana C = C̄ + cY^d como si fuera la de Friedman: **resuelto** (3/11/2026), contrapone $C_t=\overline C+c\,Y^d_t$ y $C^P_t\propto Y^P_t$. **Variante de notación**: en un tema con LM, la renta permanente se escribe con ∝ y la $k$ de Friedman va en nota; donde no hay LM (3.A.33), $C^P_t=kY^P_t$.
- 3.A.35 (sin revisar): demanda de dinero de Friedman con W_L/W (W es el salario nominal en el canon) y sin `\vertema{3.A.33}`.

Autor: Víctor Gutiérrez Marcos
