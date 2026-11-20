# Coste medio ponderado del capital (WACC)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.2 (… Rentabilidad, riesgo y coste del capital) — lo tiene en el título.
- **Temas que lo usan:** 3.B.2 (desarrollo; hecho, 8/11/2026: `eq:wacc`), 3.B.3 (mención; hecho, 8/11/2026: recordatorio de 1′ con `eq:wacc` sin recuadro y `\vertema{3.B.2}`), 3.B.4 (uso en DCF; hecho, 8/11/2026: recuadro con $(1-t_{IS})$, sin `\funcionclave`, y `\vertema{3.B.2}`)
- **Manuales de referencia:** Brealey, Myers y Allen, caps. 9 y 19; Berk y DeMarzo, cap. 12; Damodaran, *Investment Valuation*, cap. 8.

## Presentación de referencia
**Pregunta:** ¿a qué tasa se descuentan los proyectos de riesgo medio de la empresa?

**Ecuaciones (notación canónica):** $V = V_E + V_D$, $L = V_D/V$ (peso de la deuda).
$$WACC = r_E\,\frac{V_E}{V} + r_D\,(1 - t_{IS})\,\frac{V_D}{V} = r_E(1-L) + r_D(1-t_{IS})\,L$$
$r_E$ por CAPM ($r_E = r_f + \beta_E\lambda_M$, $\lambda_M\equiv\mathbb{E}[r_M]-r_f$, como el 3.B.23) o por Gordon ($r_E = D_1/P_0 + g$, vía implícita); $r_D$ = rentabilidad a vencimiento de la deuda, estimada con su valor de mercado $V_{D,0}$ y el servicio $S_t$ ($V_{D,0}=\sum_t S_t/(1+r_D)^t$; ni $I_0$ ni $D_0$). Pesos **a valor de mercado**. Beta del proyecto con Hamada (Robert Hamada, 1972): $\beta_E=\beta_A[1+(1-t_{IS})V_D/V_E]$. La presentación de referencia es `eq:wacc` del 3.B.2, igual al recuadro del 3.B.4.

**Resultado:** el WACC es la tasa correcta solo si el proyecto tiene el riesgo económico y la estructura financiera de la empresa; en otro caso, $r_A$ del sector desapalancando betas.

**Gráfico de referencia:** ninguno propio (el de coste de capital frente a apalancamiento está en `modigliani-miller`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.2 | Coste del capital | desarrollo (hecho, 8/11/2026) | Fórmula, estimación de $r_E$ (CAPM con $\lambda_M$, Gordon) y $r_D$ (con $V_{D,0}$ y $S_t$), escudo fiscal, Hamada | — |
| 3.B.3 | Decisiones de financiación | mención (hecho, 8/11/2026) | Recordatorio de 1′ con `eq:wacc` sin recuadro; sin impuestos, WACC = $r_A$ (MM) `\vertema{3.B.2}` | La estimación de $r_E$ y $r_D$ |
| 3.B.4 | Valoración de empresas | uso (hecho, 8/11/2026) | Tasa de descuento del FCL, recuadro con $(1-t_{IS})$ y `\vertema{3.B.2}` | La estimación |

## Divergencias encontradas en el temario actual
- **Resuelto (8/11/2026) en 3.B.2, 3.B.3 y 3.B.4.** **Omisión** (originales): 3.B.2, 3.B.3 y 3.B.4 escribían $WACC = r_E(1-L) + r_D L$ **sin** $(1-t_{IS})$, aunque luego tratan el escudo fiscal. Canon: con $(1 - t_{IS})$ y decir que sin impuestos coincide con MM (1958).
- **Copia casi literal** del apartado de coste de capital (CAPM, WACC) en 3.B.2 y 3.B.3.
- $L$ es «deuda pública» según el inventario de 3.B.2 (ruido) y $V_D/(V_D+V_E)$; 3.B.3 usa también $V_D/V_E$ como apalancamiento. Canon: $L = V_D/V$; si se usa la ratio deuda/fondos propios, escribir $V_D/V_E$ explícitamente.

Autor: Víctor Gutiérrez Marcos
