# Coste medio ponderado del capital (WACC)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.2 (… Rentabilidad, riesgo y coste del capital) — lo tiene en el título.
- **Temas que lo usan:** 3.B.2 (desarrollo), 3.B.3 (resumen → mención), 3.B.4 (uso en DCF)
- **Manuales de referencia:** Brealey, Myers y Allen, caps. 9 y 19; Berk y DeMarzo, cap. 12; Damodaran, *Investment Valuation*, cap. 8.

## Presentación de referencia
**Pregunta:** ¿a qué tasa se descuentan los proyectos de riesgo medio de la empresa?

**Ecuaciones (notación canónica):** $V = V_E + V_D$, $L = V_D/V$ (peso de la deuda).
$$WACC = r_E\,\frac{V_E}{V} + r_D\,(1 - t_{IS})\,\frac{V_D}{V} = r_E(1-L) + r_D(1-t_{IS})\,L$$
$r_E$ por CAPM ($r_E = r_f + \beta_E (E(r_M) - r_f)$) o por Gordon ($r_E = D_1/P_0 + g$); $r_D$ = rentabilidad a vencimiento de la deuda.

**Resultado:** el WACC es la tasa correcta solo si el proyecto tiene el riesgo económico y la estructura financiera de la empresa; en otro caso, $r_A$ del sector desapalancando betas.

**Gráfico de referencia:** ninguno propio (el de coste de capital frente a apalancamiento está en `modigliani-miller`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.2 | Coste del capital | desarrollo | Fórmula, estimación de $r_E$ y $r_D$, escudo fiscal | — |
| 3.B.3 | Decisiones de financiación | mención | El WACC como función del apalancamiento (MM) [ver tema 3.B.2] | La estimación de $r_E$ y $r_D$ (hoy copiada casi literal) |
| 3.B.4 | Valoración de empresas | uso | Tasa de descuento del FCL | La fórmula |

## Divergencias encontradas en el temario actual
- **Omisión**: 3.B.2, 3.B.3 y 3.B.4 escriben $WACC = r_E(1-L) + r_D L$ **sin** $(1-t_{IS})$, aunque luego tratan el escudo fiscal. Canon: con $(1 - t_{IS})$ y decir que sin impuestos coincide con MM (1958).
- **Copia casi literal** del apartado de coste de capital (CAPM, WACC) en 3.B.2 y 3.B.3.
- $L$ es «deuda pública» según el inventario de 3.B.2 (ruido) y $V_D/(V_D+V_E)$; 3.B.3 usa también $V_D/V_E$ como apalancamiento. Canon: $L = V_D/V$; si se usa la ratio deuda/fondos propios, escribir $V_D/V_E$ explícitamente.

Autor: Víctor Gutiérrez Marcos
