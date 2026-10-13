# Regla de Taylor (Taylor, 1993) y principio de Taylor

- **Área:** macro cerrada · **Tema de referencia:** 3.A.36 (Política monetaria I: diseño e instrumentación) — es una regla de instrumentación y el título pide el diseño; 3.A.7 la usa para cerrar el modelo NEK.
- **Temas que lo usan:** 3.A.36 (desarrollo), 3.A.7 (resumen: cierre del modelo; hoy desarrollo), 3.A.37, 3.A.38, 3.A.42 (dentro del modelo NEK), 4.B.4 (mención).
- **Manuales de referencia:** Taylor (1993), *Carnegie-Rochester Conference Series* 39; Clarida, Galí y Gertler (1999, 2000); Galí (2015), cap. 4; Walsh (2017), cap. 8; Woodford (2003), cap. 4.
- **Decisión D021 (13/10/2026):** ¿Qué forma de la regla de Taylor se usa en los modelos? La canónica i_t = r^n + φ_π π_t + φ_x x_t (+ suavización ν i_{t−1} con (1−ν) en la respuesta) en todos los modelos; la original de 1993 solo como cita histórica en 3.A.36, con la equivalencia φ_π = 1 + 0,5

## Presentación de referencia

**Pregunta:** ¿cómo debe fijar el banco central el tipo de interés para estabilizar la inflación y la actividad?

**Forma original (descriptiva, Taylor 1993):**

$$i_t = r^* + \pi_t + 0{,}5\,(\pi_t - \pi^*) + 0{,}5\,(y_t - y^n_t),\qquad r^* = \pi^* = 2\,\%$$

**Forma canónica (la que se usa en los modelos):**

$$i_t = r^* + \pi^* + \phi_\pi(\pi_t - \pi^*) + \phi_x x_t + \varepsilon_t,\qquad x_t \equiv y_t - y^n_t$$

Las dos son la misma regla: φ_π = 1 + 0,5 = 1,5 y φ_x = 0,5. En el modelo NEK linealizado alrededor de π* = 0 y r* = ρ, i_t = ρ + φ_π π_t + φ_x x_t + ε_t. Con **suavización**: i_t = ν i_{t−1} + (1−ν)[r* + π* + φ_π(π_t − π*) + φ_x x_t] + ε_t.

**Principio de Taylor:** el tipo nominal debe subir más que la inflación, **φ_π > 1** en la forma canónica (equivale a coeficiente 0,5 > 0 sobre (π − π*) en la original), para que suba el tipo real y haya equilibrio determinado.

**Gráfico de referencia:** tipo de interés efectivo frente al prescrito por la regla (serie temporal, Fed o BCE); en el modelo, la regla está dentro de la curva DA del plano (x, π) de la ficha `nek-3-ecuaciones`.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.36 | Diseño e instrumentación | Desarrollo | Las dos formas y su equivalencia; principio de Taylor; reglas frente a discreción; reglas instrumentales frente a reglas objetivo (Svensson); problemas (r* no observable, datos en tiempo real, ELB); evidencia (Clarida-Galí-Gertler 2000: φ_π < 1 antes de Volcker) | — |
| 3.A.7 | NEK de 2.ª generación | Resumen | Forma canónica como cierre del modelo y el principio de Taylor como condición de determinación | La forma original y el debate reglas/discreción |
| 3.A.37, 3.A.38, 3.A.42 | Transmisión, política fiscal, ciclos | Mención | Forma canónica (con ν si interesa la persistencia) | — |
| 4.B.4 | Multiplicadores fiscales | Mención | El multiplicador es mayor si el banco central no sube el tipo (ELB, φ_π bajo) | — |

## Divergencias encontradas en el temario actual

- **Dos formas sin relacionar:** 3.A.7 y 4.B.4 usan la original (r* + π_t + φ_y(y − y*) + φ_π(π − π*)), y 3.A.36 i_t = ρ + φ_π(π − π*) + φ_y ŷ_t. Con la original, el principio de Taylor es φ_π > 0; con la canónica, φ_π > 1: si no se dice cuál se usa, el principio queda mal enunciado. Canon: forma canónica $i_t=r^n_t+\phi_\pi\pi_t+\phi_x x_t$ en todos los modelos (con suavización $\nu i_{t-1}$ y $(1-\nu)$ en la respuesta) y la original solo como cita histórica en 3.A.36, con la equivalencia φ_π = 1 + 0,5.
- **Sin coeficiente en la brecha:** i_t = ν i_{t−1} + ϕπ_t + x_t + ε_t (3.A.7, 3.A.37, 3.A.38, 3.A.42, 4.B.4) impone φ_x = 1 y no pondera la respuesta por (1−ν). Corregir a la forma con suavización de arriba.
- **Notación:** φ_y y ŷ_t (3.A.36), y − y* (3.A.7, 4.B.4), ϕ (3.A.37): uniformar a **φ_π, φ_x, x_t**; r* (regla original) frente a ρ (modelo): decir que en el modelo sin shocks r* = ρ.

Autor: Víctor Gutiérrez Marcos
