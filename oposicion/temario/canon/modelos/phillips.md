# Curva de Phillips: original, Lipsey, Samuelson-Solow y aumentada con expectativas (Friedman-Phelps)

- **Área:** macro cerrada · **Tema de referencia:** 3.A.28 (La tasa natural de paro y la NAIRU) — la curva aumentada y la tasa natural son el título.
- **Temas que lo usan:** 3.A.28 (desarrollo), 3.A.5 (resumen: la Phillips como pieza de la síntesis y la crítica monetarista; hoy mención con epígrafe vacío), 3.A.4 (hoy desarrollo de la historia de la curva, que pasa a 3.A.5), 3.A.37 (resumen), 3.A.41 (resumen: inflación de demanda y de costes). La NKPC está en `nek-3-ecuaciones`.
- **Manuales de referencia:** Phillips (1958), *Economica*; Lipsey (1960); Samuelson y Solow (1960), *AER*; Friedman (1968), *AER*; Phelps (1967, 1968); Romer (2019), cap. 6; Blanchard, *Macroeconomics*, cap. 8; Gordon (1997) para el triángulo.

## Presentación de referencia

**Pregunta:** ¿existe una relación estable entre inflación y paro que la política pueda explotar?

**Secuencia y ecuaciones:**

1. Phillips (1958): relación empírica entre crecimiento de los salarios nominales y paro (Reino Unido 1861-1957), ln(ΔW/W + 0,9) = 0,984 − 1,394 ln U.
2. Lipsey (1960): fundamento de exceso de demanda, ΔW/W = f[(L^D − L^S)/L^S] y, con el paro como aproximación, ΔW/W = f(U), f' < 0.
3. Samuelson y Solow (1960): versión en precios con margen constante, π_t = π̄ − a U_t: «menú» de política estable entre inflación y paro.
4. Friedman (1968) y Phelps (1967): curva **aumentada con expectativas**

$$\pi_t = \pi^e_t - a\,(U_t - U^n) + \varepsilon_t,\qquad a > 0$$

con π^e_t ≡ E_{t−1}[π_t]. Con expectativas adaptativas (π^e_t = π_{t−1}) es la curva **aceleracionista** (NAIRU): Δπ_t = −a(U_t − U^n). A largo plazo (π = π^e) es vertical en U^n.

**Gráfico de referencia:** plano (U, π): curvas de Phillips de corto plazo decrecientes, una por nivel de π^e, y curva de largo plazo vertical en U^n; trayectoria de un intento de mantener U < U^n (aceleración). Hoy en 3.A.28 («curvas de Phillips a corto y largo plazo»).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.28 | Tasa natural y NAIRU | Desarrollo | Secuencia 1-4, gráfico, NAIRU frente a tasa natural, enlace con WS-PS (`nairu-layard-nickell`) y con la histéresis | — |
| 3.A.5 | Síntesis y monetarismo | Resumen | Samuelson-Solow como pieza de la síntesis; Friedman-Phelps como crítica monetarista y estanflación de los setenta | La ecuación original de Phillips y Lipsey |
| 3.A.4 | Keynes | Mención o nada | Solo si se cita la evolución posterior de la síntesis | Todo (pasa a 3.A.5) |
| 3.A.37 | Transmisión monetaria | Mención | La curva aumentada como razón de la neutralidad a largo plazo | — |
| 3.A.41 | Inflación | Resumen | Inflación de demanda (U < U^n), de costes (ε_t) e inercial (π^e); triángulo de Gordon | La historia de la curva |

## Divergencias encontradas en el temario actual

- **Pendiente h en 3.A.41** (π_t = π^e_t − h(U_t − U^n) + ε_t): h es la sensibilidad de la demanda de dinero al tipo en la LM. Propuesta **a** **[decidir]**. En Barro-Gordon la misma relación se escribe despejando U, U_t = U^n − α(π_t − π^e_t), con α = 1/a (ficha `barro-gordon`).
- **Cruce 3.A.4/3.A.5:** 3.A.4 desarrolla la curva (epígrafe «IV.3. Curva de Phillips Tema 3.A.28») y 3.A.5 tiene vacío el epígrafe de Friedman-Phelps. Propuesta: resumen en 3.A.5 y nada o mención en 3.A.4 **[decidir]**.
- **Desarrollo duplicado** en 3.A.4 y 3.A.28: con la propuesta, solo 3.A.28.

Autor: Víctor Gutiérrez Marcos
