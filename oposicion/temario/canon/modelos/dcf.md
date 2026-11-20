# Valoración por descuento de flujos de caja (DCF) y múltiplos

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.4 (Métodos de valoración de empresas) — lo tiene en el título.
- **Temas que lo usan:** 3.B.4 (desarrollo; hecho, 8/11/2026), 3.B.23 (mención; hecho, 8/11/2026: el CAPE de Shiller y el análisis fundamental como valor intrínseco, con `\vertema{3.B.4}`; reparto K28: múltiplos, esquema de Vernimmen y tabla de Fernández en el 3.B.4, CAPE en el 3.B.23)
- **Manuales de referencia:** Koller, Goedhart y Wessels (McKinsey), *Valuation*; Damodaran, *Investment Valuation*; Fernández, *Valoración de empresas*; Brealey, Myers y Allen, cap. 19.

## Presentación de referencia
**Pregunta:** ¿cuánto vale una empresa?

**Ecuaciones (notación canónica):**
$$EV = \sum_{t=1}^{N}\frac{FCL_t}{(1+WACC)^t} + \frac{VT_N}{(1+WACC)^N}, \qquad VT_N = \frac{FCL_{N+1}}{WACC - g}, \qquad V_E = EV - \text{deuda neta}$$
(`eq:dcf`, función clave del 3.B.4.) Flujo para el accionista $FCLA_t=FCL_t-\text{intereses}_t(1-t_{IS})+\Delta\text{deuda neta}_t$ (FCFE), descontado a $r_E$; APV en una línea; deuda neta = deuda financiera − efectivo y activos financieros líquidos. **$EV$ frente a $V$:** $EV$ resta la caja; el $V=V_E+V_D$ del WACC, no: decirlo una vez (`valor-empresa.tex`). Mixtos y opciones reales (Myers, 1977), en mención.
Múltiplos: $PER = P/BPA$, $EV/EBITDA$, $EV/EBIT$, $EV/\text{ventas}$, valor contable.

**Resultado:** el DCF valora por fundamentos; los múltiplos valoran por comparables y dependen de la homogeneidad (apalancamiento, ciclo, contabilidad).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B04/graficos/metodos-valoracion.tex` (esquema de métodos: balance, cuenta de resultados y múltiplos, DCF, mixtos, opciones reales) y `valor-empresa.tex` (de $EV$ a $V_E$) (pasada final, nov. 2026).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.4 | Valoración de empresas | desarrollo (hecho, 8/11/2026) | $FCL$ y $FCLA$, valor terminal, $EV\to V_E$ con `valor-empresa.tex`, APV en una línea; múltiplos $PER$, $EV/EBITDA$, $EV/EBIT$; mixtos y opciones reales en mención; `eq:dcf` función clave | — |
| 3.B.23 | Renta variable: análisis fundamental | mención (hecho, 8/11/2026) | Análisis fundamental como estimación del valor intrínseco; CAPE; PER `\vertema{3.B.4}` | El bloque DCF y múltiplos |

## Divergencias encontradas en el temario actual
- **Resuelto (8/11/2026):** el duplicado 3.B.4/3.B.23 (reparto K28), el «¿qué método?» doble, $k$ → WACC, el FCFE como imagen y el valor terminal sin notación. Lo que sigue describe los originales.
- **Duplicado casi literal** del bloque de análisis fundamental (DCF, múltiplos, PER) en 3.B.4 y 3.B.23.
- 3.B.4: el apartado se titula «múltiplo EBITDA» y la fórmula usa EBIT; en 3.B.23 el título es «EBIT múltiplo». Canon: los dos múltiplos, cada uno con su nombre.
- 3.B.4: el apartado «¿Qué método utilizar?» aparece dos veces (3.1.2 y 3.1.3).
- Tasa de descuento $k$ en 3.B.4 y $WACC$ en 3.B.2: canon $WACC$ para el FCL y $r_E$ para dividendos.

Autor: Víctor Gutiérrez Marcos
