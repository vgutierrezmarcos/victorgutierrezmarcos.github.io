# Tipos de cambio nominal y real, bilateral y efectivo

- **Área:** macro-abierta · **Tema de referencia:** 3.B.13 (Mercados de divisas) — define las convenciones (directo/indirecto, nominal/real, bilateral/efectivo) que usan todos los demás temas.
- **Temas que lo usan:** 3.B.13 (desarrollo), 4.A.22 (desarrollo aplicado: ITC del Banco de España), 1D01 (uso: IV.2, con la advertencia sobre la convención de los datos; umbral del PDM ±3 %/±10 % en 3 años), 3.B.11 (uso; hecho, 5/11/2026: II.2, $q^{ef}$ como indicador de competitividad-precio y, en una unión monetaria, $\gamma_q\simeq\pi^*-\pi$ y la devaluación interna, lo que le remite el 3.A.41); de hecho, todos los de 3.B.12-3.B.19 usan $E$ y el tipo real También 3.A.32 (uso; hecho, 11/11/2026), 3.B.16 (uso; hecho, 11/11/2026: $q\equiv EP^*/P$ en la introducción, `\vertema{3.B.13}`; $q=P^*/P$ entre los socios en Mundell; en tasas, `eq:magnifico` $\gamma_q\simeq\gamma_E+\gamma_{P^*}-\pi$ con **$\gamma_{P^*}$** porque $\pi^*$ es allí el objetivo de Barro-Gordon, A32-08, **[decidir]**) También 3.B.14 (uso; hecho, 11/11/2026).
- **Manuales de referencia:** Krugman, Obstfeld y Melitz, caps. 14 y 16; Obstfeld y Rogoff, *Foundations…*, cap. 4; BCE y Banco de España (metodología de tipos de cambio efectivos e Índices de Tendencia de Competitividad).
- **Decisión D015 (13/10/2026):** ¿Cómo se escribe el tipo de cambio real? q = EP*/P (↑q = depreciación real), como Krugman-Obstfeld y Obstfeld-Rogoff; κ queda libre (desutilidad del trabajo en Corsetti-Pesenti)

## Presentación de referencia
**Pregunta:** ¿cómo se mide el precio de una moneda y la competitividad-precio de un país?

**Convenciones canónicas:**
- $E$: tipo de cambio nominal **directo** (unidades de moneda nacional por unidad de moneda extranjera); $\uparrow E$ = depreciación.
- Tipo real: $q = \dfrac{E P^*}{P}$; $\uparrow q$ = depreciación real (ganancia de competitividad). Símbolo $q$ (Krugman-Obstfeld, Obstfeld-Rogoff); $\varkappa$, que hoy usan 3.B.12-3.B.19, deja de usarse.
- Efectivo: media geométrica ponderada por comercio, $E^{ef} = \prod_i E_i^{\omega_i}$, $\sum_i \omega_i = 1$; real efectivo $q^{ef} = \prod_i \left(E_i P^*_i/P\right)^{\omega_i}$. Con los CLU en lugar de los precios, competitividad en costes.
- Las estadísticas oficiales (BCE, Banco de España, ITC) publican tipos **indirectos** (subida = apreciación = pérdida de competitividad): decirlo siempre al pasar a datos.

**Gráfico de referencia:** ninguno teórico; en 4.A.22, evolución del ITC frente a UEM y OCDE.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.13 | Convenciones del mercado de divisas | desarrollo | Definiciones, directo/indirecto, cruzados, efectivos y reales | — |
| 4.A.22 | Competitividad del comercio español | desarrollo aplicado | ITC: deflactores (IPC, IVU, CLU), ponderaciones, convención inversa y descomposición $\gamma_{\mathrm{CLU}} = \gamma_W - \gamma_{\mathrm{PAT}}$ ($W$ remuneración nominal por asalariado, § 6 y § 13) | Definiciones generales (remitir a 3.B.13) |
| 1D01 | Dictamen de coyuntura | Uso | $E$ directo, $q=EP^*/P$, $q^{ef}$ geométrico; el BCE y el Banco de España publican al revés (en 2026 el tribunal tuvo que rectificar unidades) | Las definiciones del mercado de divisas |
| 3.B.11 | Interpretación del saldo de bienes y servicios | uso (hecho, 5/11/2026) | $q=EP^*/P$, $q^{ef}=\prod_i(E_iP_i^*/P)^{\omega_i}$ (subida = depreciación real = ganancia de competitividad-precio), `\vertema{3.B.13}`; en tasas $\gamma_q\simeq\gamma_E+\pi^*-\pi$ y, con el tipo nominal fijo frente a los socios, $\gamma_q\simeq\pi^*-\pi$: una inflación mayor que la de los socios es una apreciación real (cumple la remisión del 3.A.41, l. 420); competitividad en costes con $\gamma_{\mathrm{CLU}}=\gamma_W-\gamma_{\mathrm{PAT}}$; devaluación interna (`\vertema{3.B.16}`, `\vertema{4.A.22}`); Balassa-Samuelson en una línea; la advertencia de la convención inversa de los datos | Las definiciones del mercado de divisas; los ITC de España (4.A.22) |
| 3.B.12, 3.B.14-3.B.19 | Ajuste, determinación, regímenes, crisis, coordinación | uso | Usar $E$ y $q$ con estas convenciones | Volver a definir |
| 3.A.32 | OA-DA abierta | uso (hecho, 11/11/2026) | $q\equiv EP^*/P$ (↑ depreciación real) en la IS, la BP y la DA (efecto competitividad); $P_C/P=q^{\alpha}$ en la cuña exterior; en tasas, `eq:inflacion-abierta` con $\gamma_{P^*,t}$ (no $\pi^*$, que es el objetivo: A32-08, **[decidir]**); en logaritmos en Galí-Monacelli, $\tau_t=e_t+p^*_t-p_{H,t}$ y $e_t+p^*_t-p_t=(1-\alpha)\tau_t$ (avisado) | Las convenciones |
| 3.B.16 | Integración monetaria | uso (hecho, 11/11/2026) | $q\equiv EP^*/P$; con $E\equiv1$ entre los socios, $q=P^*/P$ (Mundell, `fig:mundell`); Magnifico en tasas, `eq:magnifico`: $\gamma_q\simeq\gamma_E+\gamma_{P^*}-\pi\to\gamma_{P^*}-\pi$ en la unión, con la misma frase que el 3.B.11 («una inflación mayor que la de los socios es una apreciación real»), `\vertema{3.B.11}`; nota: γ con subíndice es tasa, sin subíndice el peso de la inflación de Barro-Gordon | Volver a definir |
| 3.B.14 | Determinación del tipo de cambio | uso (hecho, 11/11/2026) | Caja de notación con la misma redacción que el 3.B.13 ($E$ directo, $q=EP^*/P$, $\uparrow q$ depreciación real, `\vertema{3.B.13}`); $\gamma_q\simeq\gamma_E+\pi^*-\pi$ (`\vertema{3.B.11}`) en la PPA relativa; $q\equiv e+p^*-p$ en logaritmos (Balassa-Samuelson, Roll); tipo real de equilibrio (III.1.3: PPA, FEER, BEER, EBA, `tab:equilibrio-real`; *External Sector Report* 2026, `FMI2026ESR`, `\vertema{3.B.22}`) | Las definiciones y los tipos efectivos |

## Divergencias encontradas en el temario actual
- Tipo efectivo como **media aritmética** $\sum \alpha_i E_i$ en 3.B.13; los índices oficiales son geométricos. Corregir.
- Tipo real: $\varkappa$ en 3.B.12-3.B.19, pero 3.B.19 escribe también $e = E P_H^*/P_F$ en Corsetti-Pesenti y usa $\kappa$ para la desutilidad del trabajo (se confunde con $\varkappa$). Canon: $q$.
- ~~El Word del **3.B.16** escribe el tipo real $e=E\cdot P^*/P$ y $\gamma_e=\gamma_E+(\pi^*-\pi)$~~: **resuelto al revisar el 3.B.16 (11/11/2026)**, $q$ y $\gamma_q$ con $\gamma_{P^*}$.
- Tipo nominal: $E$ en definiciones y $s_t$ en paridades; $e$ en 3.B.17 (tipo sombra $\tilde e$, fijo $\bar e$) mientras $e$ es también el coeficiente de efectivo del multiplicador. Canon: $E$ (sombra $\tilde E$, fijo $\bar E$), minúscula solo para logaritmos.
- 4.A.22 usa $\beta_i$ para pesos y $\gamma$ para tasas: canon $\omega_i$ para pesos de comercio; $\gamma_X$ tasa de variación.

- **Esta ficha** (corregido el 24/10/2026, C6 de la 1D01): la fila del 4.A.22 escribía $\gamma_{CLU}=\gamma_w-\gamma_{PAT}$ con $w$ minúscula, que es el salario **real** (§ 6): es $\gamma_W$ (nominal); y el real efectivo escribía $P_i$ en lugar de $P^*_i$.

Autor: Víctor Gutiérrez Marcos
