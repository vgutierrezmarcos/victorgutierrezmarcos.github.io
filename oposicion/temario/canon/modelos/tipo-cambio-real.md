# Tipos de cambio nominal y real, bilateral y efectivo

- **Área:** macro-abierta · **Tema de referencia:** 3.B.13 (Mercados de divisas) — define las convenciones (directo/indirecto, nominal/real, bilateral/efectivo) que usan todos los demás temas.
- **Temas que lo usan:** 3.B.13 (desarrollo), 4.A.22 (desarrollo aplicado: ITC del Banco de España); de hecho, todos los de 3.B.12-3.B.19 usan $E$ y el tipo real
- **Manuales de referencia:** Krugman, Obstfeld y Melitz, caps. 14 y 16; Obstfeld y Rogoff, *Foundations…*, cap. 4; BCE y Banco de España (metodología de tipos de cambio efectivos e Índices de Tendencia de Competitividad).
- **Decisión D015 (13/10/2026):** ¿Cómo se escribe el tipo de cambio real? q = EP*/P (↑q = depreciación real), como Krugman-Obstfeld y Obstfeld-Rogoff; κ queda libre (desutilidad del trabajo en Corsetti-Pesenti)

## Presentación de referencia
**Pregunta:** ¿cómo se mide el precio de una moneda y la competitividad-precio de un país?

**Convenciones canónicas:**
- $E$: tipo de cambio nominal **directo** (unidades de moneda nacional por unidad de moneda extranjera); $\uparrow E$ = depreciación.
- Tipo real: $q = \dfrac{E P^*}{P}$; $\uparrow q$ = depreciación real (ganancia de competitividad). Símbolo $q$ (Krugman-Obstfeld, Obstfeld-Rogoff); $\varkappa$, que hoy usan 3.B.12-3.B.19, deja de usarse.
- Efectivo: media geométrica ponderada por comercio, $E^{ef} = \prod_i E_i^{\omega_i}$, $\sum_i \omega_i = 1$; real efectivo $q^{ef} = \prod_i \left(E_i P_i/P\right)^{\omega_i}$.
- Las estadísticas oficiales (BCE, Banco de España, ITC) publican tipos **indirectos** (subida = apreciación = pérdida de competitividad): decirlo siempre al pasar a datos.

**Gráfico de referencia:** ninguno teórico; en 4.A.22, evolución del ITC frente a UEM y OCDE.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.13 | Convenciones del mercado de divisas | desarrollo | Definiciones, directo/indirecto, cruzados, efectivos y reales | — |
| 4.A.22 | Competitividad del comercio español | desarrollo aplicado | ITC: deflactores (IPC, IVU, CLU), ponderaciones, convención inversa y descomposición $\gamma_{CLU} = \gamma_w - \gamma_{PAT}$ | Definiciones generales (remitir a 3.B.13) |
| 3.B.12, 3.B.14-3.B.19 | Ajuste, determinación, regímenes, crisis, coordinación | uso | Usar $E$ y $q$ con estas convenciones | Volver a definir |

## Divergencias encontradas en el temario actual
- Tipo efectivo como **media aritmética** $\sum \alpha_i E_i$ en 3.B.13; los índices oficiales son geométricos. Corregir.
- Tipo real: $\varkappa$ en 3.B.12-3.B.19, pero 3.B.19 escribe también $e = E P_H^*/P_F$ en Corsetti-Pesenti y usa $\kappa$ para la desutilidad del trabajo (se confunde con $\varkappa$). Canon: $q$.
- Tipo nominal: $E$ en definiciones y $s_t$ en paridades; $e$ en 3.B.17 (tipo sombra $\tilde e$, fijo $\bar e$) mientras $e$ es también el coeficiente de efectivo del multiplicador. Canon: $E$ (sombra $\tilde E$, fijo $\bar E$), minúscula solo para logaritmos.
- 4.A.22 usa $\beta_i$ para pesos y $\gamma$ para tasas: canon $\omega_i$ para pesos de comercio; $\gamma_X$ tasa de variación.

Autor: Víctor Gutiérrez Marcos
