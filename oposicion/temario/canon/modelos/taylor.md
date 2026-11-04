# Regla de Taylor (Taylor, 1993) y principio de Taylor

- **Área:** macro cerrada · **Tema de referencia:** 3.A.36 (Política monetaria I: diseño e instrumentación) — es una regla de instrumentación y el título pide el diseño; 3.A.7 la usa para cerrar el modelo NEK.
- **Temas que lo usan:** 3.A.36 (desarrollo), 3.A.7 (resumen; hecho, 4/11/2026: II.2, la forma canónica `eq:taylor` como función clave que cierra el modelo, con ρ; la suavización en una viñeta; la original en una línea; el principio exacto `eq:determinacion` en las implicaciones; III.1.1, la regla con datos de la zona del euro en una frase), 3.A.37, 3.A.38, 3.A.42 (dentro del modelo NEK), 4.B.4 (resumen; hoy mención), 1D01 (uso: VI.1, tono de la política monetaria). También 3.A.5 (mención; hecho, 3/11/2026: III.2 y conclusión, de palabra: la regla de Taylor como sucesora de la del k % tras Goodhart y Poole, `\vertema{3.A.36}`; sin la forma canónica); 3.A.3 (mención; hecho, 4/11/2026: III.2, la regla de Wicksell como antecedente, `\vertema{3.A.36}`).
- **Manuales de referencia:** Taylor (1993), *Carnegie-Rochester Conference Series* 39; Clarida, Galí y Gertler (1999, 2000); Galí (2015), cap. 4; Walsh (2017), cap. 8; Woodford (2003), cap. 4.
- **Decisión D021 (13/10/2026):** ¿Qué forma de la regla de Taylor se usa en los modelos? La canónica i_t = r^n + φ_π π_t + φ_x x_t (+ suavización ν i_{t−1} con (1−ν) en la respuesta) en todos los modelos; la original de 1993 solo como cita histórica en 3.A.36, con la equivalencia φ_π = 1 + 0,5
- **Lectura de D021 fijada en el 3.A.7 (4/11/2026, CC2):** el r^n de la regla es el tipo natural **del estado estacionario**, r^n = ρ ≡ −ln β: en el modelo, $i_t=\rho+\phi_\pi\pi_t+\phi_x x_t+\varepsilon_t$ (Galí, 2015, cap. 3), que deja que las perturbaciones de demanda muevan la DA. La variante $i_t=r^n_t+\phi_\pi\pi_t+\phi_x x_t$, con el tipo natural **de cada periodo**, es la que replica la asignación eficiente (divina coincidencia, Galí, 2015, cap. 4; ficha `divina-coincidencia`) y solo se escribe para explicar ese resultado.

## Presentación de referencia

**Pregunta:** ¿cómo debe fijar el banco central el tipo de interés para estabilizar la inflación y la actividad?

**Forma original (descriptiva, Taylor 1993):**

$$i_t = r^* + \pi_t + 0{,}5\,(\pi_t - \pi^*) + 0{,}5\,(y_t - y^n_t),\qquad r^* = \pi^* = 2\,\%$$

**Forma canónica (la que se usa en los modelos):**

$$i_t = r^* + \pi^* + \phi_\pi(\pi_t - \pi^*) + \phi_x x_t + \varepsilon_t,\qquad x_t \equiv y_t - y^n_t$$

Las dos son la misma regla: φ_π = 1 + 0,5 = 1,5 y φ_x = 0,5. En el modelo NEK linealizado alrededor de π* = 0 y r* = ρ, i_t = ρ + φ_π π_t + φ_x x_t + ε_t. Con **suavización**: i_t = ν i_{t−1} + (1−ν)[r* + π* + φ_π(π_t − π*) + φ_x x_t] + ε_t.

**Principio de Taylor:** el tipo nominal debe subir más que la inflación, **φ_π > 1** en la forma canónica (equivale a coeficiente 0,5 > 0 sobre (π − π*) en la original), para que suba el tipo real y haya equilibrio determinado. En el modelo canónico la **condición exacta** es $\kappa(\phi_\pi-1)+(1-\beta)\phi_x>0$ (`eq:determinacion` del 3.A.7; Bullard y Mitra, 2002; Galí, 2015, cap. 3): φ_π > 1 con φ_x ≥ 0 es **suficiente pero no necesaria** (con φ_x > 0 basta un φ_π algo menor que 1), y φ_π = 1 con φ_x = 0 no la cumple (pregunta de marzo de 2025, nota al opositor del 3.A.7). Pegatina del 3.A.7: «más vale pasarse que quedarse corto». Evidencia: la Reserva Federal anterior a Volcker no lo cumplía (Clarida, Galí y Gertler, 2000).

**Forma original en el 3.A.7 (una línea):** $i_t=2+\pi_t+0{,}5(\pi_t-2)+0{,}5\,x_t$ (en %), es decir, $i_t=1+1{,}5\,\pi_t+0{,}5\,x_t$, propuesta en la conferencia Carnegie-Rochester de noviembre de 1992 y publicada como Taylor (**1993**), p. 202. **Con datos** (3.A.7, III.1.1; gráfico para el 3.A.36, A07-13, CSV en `fuentes/3A07/_trabajo/datos/regla-taylor-zona-euro.csv`): en la zona del euro pedía −1,6 % en 2020 y 14 % en 2022, con inflación media del 8,4 %.

**Gráfico de referencia:** tipo de interés efectivo frente al prescrito por la regla (serie temporal, Fed o BCE; lo hará el 3.A.36 con el CSV del 3.A.7); en el modelo, la regla está dentro de la curva DA dinámica del plano $(x_t,\pi_t)$, `oposicion/temario/fuentes/3A07/graficos/nek-xpi.tex` (ficha `nek-3-ecuaciones`).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.36 | Diseño e instrumentación | Desarrollo | Las dos formas y su equivalencia; principio de Taylor; reglas frente a discreción; reglas instrumentales frente a reglas objetivo (Svensson); problemas (r* no observable, datos en tiempo real, ELB); evidencia (Clarida-Galí-Gertler 2000: φ_π < 1 antes de Volcker) | — |
| 3.A.7 | NEK de 2.ª generación | resumen (hecho, 4/11/2026) | Forma canónica con ρ como cierre del modelo (`\funcionclave` `eq:taylor`), suavización con (1 − ν), la original en una línea con `\vertema{3.A.36}`; el principio exacto `eq:determinacion`; la variante con $r^n_t$ para la divina coincidencia; la regla con datos en una frase | Las ventajas e inconvenientes y el debate reglas/discreción (`\vertema{3.A.36}`) |
| 3.A.37, 3.A.38, 3.A.42 | Transmisión, política fiscal, ciclos | Mención | Forma canónica (con ν si interesa la persistencia) | — |
| 4.B.4 | Multiplicadores fiscales | Resumen (hoy mención; D139 (13/10/2026)) | Forma canónica $i_t=\rho+\phi_\pi\pi_t+\phi_x x_t+\varepsilon_t$ (CC2 del 3.A.7: ρ, no $r^n_t$) y principio de Taylor ($\phi_\pi>1$); el multiplicador es mayor si el banco central no sube el tipo (ELB, φ_π bajo) | — |
| 1D01 | Dictamen de coyuntura | Uso | Forma de Taylor (1993) escrita como $i_t=r^*+\pi^*+1{,}5(\pi_t-\pi^*)+0{,}5\,\mathrm{OG}_t$ con $r^*=\pi^*=2\,\%$ (la misma que la canónica con $\phi_\pi=1{,}5$, $\phi_x=0{,}5$ y la brecha OG en lugar de $x_t$); el tono por $r_t$ frente a $r^n$ | El principio de Taylor y el NEK |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | De palabra, la regla de tipo de interés que sustituye a la del k % (Poole, 1970), con `\vertema{3.A.36}` | La ecuación |
| 3.A.3 | Los neoclásicos | mención (hecho, 4/11/2026) | III.2: como el tipo natural no se observa, Wicksell (1898) propone subir el tipo si los precios suben y bajarlo si bajan: un antecedente de las reglas de tipos de interés, `\vertema{3.A.36}`, y del modelo de la NEK, `\vertema{3.A.7}` | La regla de Taylor |

## Divergencias encontradas en el temario actual

- **Dos formas sin relacionar:** 3.A.7 (resuelto el 4/11/2026) y 4.B.4 usan la original (r* + π_t + φ_y(y − y*) + φ_π(π − π*)), y 3.A.36 i_t = ρ + φ_π(π − π*) + φ_y ŷ_t. Con la original, el principio de Taylor es φ_π > 0; con la canónica, φ_π > 1: si no se dice cuál se usa, el principio queda mal enunciado. Canon: forma canónica $i_t=\rho+\phi_\pi\pi_t+\phi_x x_t+\varepsilon_t$ en todos los modelos (ρ = $r^n$ del estado estacionario; $r^n_t$ solo en la variante de la divina coincidencia, CC2 del 3.A.7; antes esta línea decía $r^n_t$) (con suavización $\nu i_{t-1}$ y $(1-\nu)$ en la respuesta) y la original solo como cita histórica en 3.A.36, con la equivalencia φ_π = 1 + 0,5.
- **Sin coeficiente en la brecha:** i_t = ν i_{t−1} + ϕπ_t + x_t + ε_t (3.A.37, 3.A.38, 3.A.42, 4.B.4; en el 3.A.7, resuelto el 4/11/2026) impone φ_x = 1 y no pondera la respuesta por (1−ν). Corregir a la forma con suavización de arriba.
- **Notación:** φ_y y ŷ_t (3.A.36), y − y* (3.A.7, 4.B.4), ϕ (3.A.37): uniformar a **φ_π, φ_x, x_t**; r* (regla original) frente a ρ (modelo): decir que en el modelo sin shocks r* = ρ.

Autor: Víctor Gutiérrez Marcos
