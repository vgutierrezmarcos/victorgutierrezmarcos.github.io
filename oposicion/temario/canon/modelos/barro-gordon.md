# Inconsistencia temporal: Kydland y Prescott (1977), Barro y Gordon (1983)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.36 (Política monetaria I: diseño) — reglas frente a discrecionalidad, credibilidad e independencia del banco central son el núcleo del diseño.
- **Temas que lo usan:** 3.A.36 (desarrollo), 3.A.6 (resumen: aportación de la NMC; hoy desarrollo), 3.A.41 (mención: sesgo inflacionista como causa de la inflación; hoy desarrollo), 3.B.17 (mención: crisis cambiarias de 2.ª generación). 3.A.14 (mención; hecho, 19/10/2026: la discreción como EN de un juego entre la autoridad y el público; la regla no es creíble, inconsistencia temporal; reputación en juegos repetidos; de palabra, sin la derivación, porque allí γ es el poder de negociación); 3.A.23 (mención; hecho, 21/10/2026: inconsistencia temporal de Kydland y Prescott como fallo de compromiso del sector público, III.1.3).
- **Manuales de referencia:** Kydland y Prescott (1977), *JPE* 85(3); Barro y Gordon (1983a, *JPE*; 1983b, *JME*); Rogoff (1985); Walsh (1995); Romer (2019), cap. 12; Walsh (2017), cap. 7.

## Presentación de referencia

**Pregunta:** ¿por qué una autoridad monetaria que optimiza periodo a periodo genera más inflación sin reducir el paro, y cómo se corrige?

**Supuestos:** curva de Phillips con expectativas racionales; la autoridad quiere un paro U* por debajo del natural U^n (distorsiones en el mercado de trabajo) y una inflación π*; el público fija π^e_t antes de que la autoridad elija π_t y conoce sus preferencias.

**Ecuaciones:**

$$\min_{\pi_t}\ L_t = (U_t - U^*)^2 + \gamma(\pi_t - \pi^*)^2 \quad \text{s.a.}\quad U_t = U^n - \alpha(\pi_t - \pi^e_t),\qquad U^* < U^n$$

Condición de primer orden (discreción, π^e_t dada):

$$-2\alpha(U_t - U^*) + 2\gamma(\pi_t - \pi^*) = 0 \ \Longrightarrow\ \gamma(\pi_t - \pi^*) = \alpha(U_t - U^*)$$

Con expectativas racionales π^e_t = π_t, luego U_t = U^n y

$$\pi^D = \pi^* + \frac{\alpha}{\gamma}\,(U^n - U^*)\qquad \text{(sesgo inflacionista } \tfrac{\alpha}{\gamma}(U^n-U^*) > 0\text{)}$$

Con una regla creíble π = π*: mismo paro U^n y menor pérdida. El equilibrio discrecional es el de Nash; la regla no es creíble porque, si el público espera π*, a la autoridad le conviene incumplirla: con π^e_t = π* elige π^E = π* + α(U^n − U*)/(γ + α²) y logra U < U^n (equilibrio de engaño, con menor pérdida para ella que la regla). Anticipándolo, el público no cree la regla.

**Soluciones:** reputación en juegos repetidos (Barro y Gordon 1983b), delegación en un banquero central conservador con γ' > γ (Rogoff 1985), contratos de incentivos (Walsh 1995), independencia y objetivos de inflación.

**Gráfico de referencia:** plano (U, π) (paro en abscisas): curvas de Phillips de corto plazo (pendiente −1/α), una por cada π^e; curvas de indiferencia de la autoridad (elipses centradas en (U*, π*)); vertical en U^n; punto de regla (U^n, π*) y equilibrio discrecional (U^n, π^D) donde la curva de Phillips con π^e = π^D es tangente a una curva de indiferencia. Hoy en 3.A.6 («equilibrio de Nash F») y 3.A.36.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.36 | Diseño de la política monetaria | Desarrollo | Modelo completo, gráfico, soluciones (reputación, Rogoff, Walsh, independencia), evidencia (Alesina y Summers 1993) | — |
| 3.A.6 | Aportaciones de la NMC | Resumen | Kydland-Prescott como consecuencia de las expectativas racionales: reglas frente a discreción; resultado π^D > π* sin ganancia de paro | La derivación (remitir a 3.A.36) |
| 3.A.41 | Causas de la inflación | Mención | El sesgo inflacionista como causa institucional de la inflación; independencia | La derivación |
| 3.B.17 | Crisis cambiarias de 2.ª generación | Mención | Misma lógica de credibilidad aplicada a la paridad (Obstfeld 1994) | El modelo |
| 3.A.14 | Teoría de juegos: compromiso y repetición | mención (hecho, 19/10/2026) | Kydland-Prescott (1977) y Barro-Gordon (1983): la discreción es el EN del juego entre la autoridad y el público; la promesa de inflación baja no es creíble (inconsistencia temporal); se resuelve con reglas, reputación (juegos repetidos) o independencia; `\vertema{3.A.36}` | La pérdida y la derivación |
| 3.A.23 | Fallos del sector público (compromiso) | mención (hecho, 21/10/2026) | Kydland y Prescott (1977) como fallo de compromiso del Estado, con su ejemplo de las zonas inundables (la mota del río) y las condiciones con y sin compromiso (`eq:kp-optima`, `eq:kp-discrecion`; $a_t$, $x_t$, $X_t(\cdot)$, $S(\cdot)$ locales); capital, patentes, precio del carbono, rescates y la inflación de Barro y Gordon (1983) con `\vertema{3.A.36}`; sesgo deficitario (`\vertema{3.A.39}`); soluciones: reglas, reputación (`\vertema{3.A.14}`) e instituciones independientes | La derivación de Barro-Gordon y su gráfico |

## Divergencias encontradas en el temario actual

- **Error algebraico copiado en 3.A.6, 3.A.36 y 3.A.41:** la condición de primer orden aparece con términos al cuadrado («α²(π−π^e)² + γ(π−π*) = α(U−U*)²») y la solución como π = π* + (α/γ)(Ū − U*)². Con pérdida cuadrática la CPO es lineal y la solución es π^D = π* + (α/γ)(U^n − U*). Corregir en los tres (párrafos idénticos).
- **Desarrollo en tres temas:** propuesta, desarrollo solo en 3.A.36; resumen en 3.A.6 y mención en 3.A.41 con «[ver tema 3.A.36]».
- **Notación:** paro natural Ū (3.A.6) frente a U^n_t (3.A.36); U frente a U_t. Canon: **U_t, U^n, U*** (U^n sin subíndice temporal salvo que varíe).

Autor: Víctor Gutiérrez Marcos
