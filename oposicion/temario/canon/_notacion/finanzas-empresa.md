# Notación del área de finanzas y empresa (3.B.1-3.B.4, 3.B.23-3.B.27)

Paso 2 del canon (13 oct. 2026). Fuentes: `mapa.yaml`, `_inventario/resumen-por-area.md` (comprobado contra los Word originales de 3.B.1-3.B.4 y 3.B.23-3.B.25) e inventarios por tema. Manuales base: Brealey, Myers y Allen (*Principles of Corporate Finance*), Berk y DeMarzo, Bodie, Kane y Marcus (*Investments*), Hull (*Options, Futures and Other Derivatives*), Fabozzi (renta fija), Freixas y Rochet (*Microeconomics of Banking*) y, en español, Suárez Suárez. Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

## Tabla de símbolos

| Símbolo | Significado | Alternativas que aparecen (temas) | Canon | Motivo |
|---|---|---|---|---|
| $ROA$ | Rentabilidad económica | $EBIAT/AT$ (3.B.1); $EBIT/AT$ (3.B.2) | **$ROA = EBIT/AT$** (BAII/AT, la «rentabilidad económica» de Suárez Suárez) con $ROE = [ROA + (ROA - r_D)\,V_D/V_E](1-t)$ | La fórmula de apalancamiento de 3.B.1 ($ROE = ROA + (ROA - \text{costes financieros})\cdot$ pasivo/PN) solo es exacta con $ROA$ antes de impuestos y el resultado multiplicado por $(1-t)$; (b) es además la definición española habitual |
| $EBIT$, $EBITDA$, $EBIAT$ | Resultado de explotación; antes de amortizaciones; después de impuestos | Mezclados en 3.B.1, 3.B.4, 3.B.23 | Definir los tres una vez (3.B.1) y usarlos con su nombre | «Múltiplo EBITDA» con fórmula de EBIT (3.B.4) |
| $ROE$ | Rentabilidad financiera = beneficio neto / PN | 3.B.1, 3.B.2 | Mantener; también rentabilidad de la reinversión en Gordon | Sustituye a $y$ de 3.B.3 |
| $I_0$, $FC_t$, $VR$ | Desembolso, flujo de caja, valor residual | $A$, $Q_t$ (3.B.2); $FC$, $FCL$ (3.B.4); $B_t - C_t$ (4.B.6) | $I_0$, $FC_t$ ($FCL_t$ si es libre) | Coherencia 3.B.2-3.B.4 |
| $k$ | Tasa de descuento genérica | $k$, $WACC$, $r$ (3.B.2); $k$ = coste de los fondos propios (3.B.4) | $k$ genérica; $WACC$, $r_E$, $r_D$ cuando sean esos | — |
| $r_E$, $r_D$, $r_A$ | Coste de fondos propios, de la deuda y del activo | 3.B.2, 3.B.3, 4.B.10 | Mantener | — |
| $V_E$, $V_D$, $V$, $L$ | Valores de fondos propios, deuda y empresa; peso de la deuda $L = V_D/V$ | $L = V_D/(V_D+V_E)$ (3.B.2, 4.B.10); $V_D/V_E$ «apalancamiento» (3.B.3) | $L = V_D/V$; la ratio $V_D/V_E$ se escribe explícita | Dos conceptos con el mismo nombre |
| $t_{IS}$, $t_E$, $t_D$ | Tipo del IS; IRPF de acciones y de deuda | $t_{IRPF}^E$, $t_{IRPF}^D$ (4.B.10), $t_{IRPF_D}$ (3.B.3) | $t_{IS}$, $t_E$, $t_D$ | Más corto y sin ambigüedad |
| $g$, $b$ | Crecimiento del dividendo; tasa de retención; $g = b\cdot ROE$ | $g$ (3.B.2); $d$ (3.B.4); $y$ = rentabilidad de la reinversión (3.B.3) | **$g$** y $b$ | Gordon (1962), Brealey-Myers, Bodie-Kane-Marcus |
| $D_t$, $BPA$, $PER$ | Dividendo, beneficio por acción, ratio precio/beneficio | $B_0$ (3.B.3), $BPA$ (3.B.4) | $BPA$ por acción, $B$ total | — |
| $r_f$, $r_M$, $r_i$ | Tipo libre de riesgo; rentabilidad del mercado y del activo (aleatorias) | $r_f$, $r_M$ (3.B.2, 3.B.3, 3.B.25); $R_f$, $R_M$, $R_i$ (3.B.23) | **Minúsculas** | Coherencia con $r_E$, $r_D$; Bodie-Kane-Marcus; un solo criterio en el bloque |
| $E(r)$, $\sigma$, $\sigma_{ij}$, $\beta_i$ | Rentabilidad esperada, desviación típica, covarianza, beta | $E[R]$; $\beta_i$ definida dos veces (3.B.23) | Mantener; $\beta_i = \mathrm{Cov}(r_i,r_M)/\mathrm{Var}(r_M)$ | Error de 3.B.23 |
| $w_i$, $w$ | Pesos de la cartera; peso de la cartera con riesgo (Tobin) | $X_i$ (Markowitz), $w$ (Tobin), $w_i$ (Sharpe) en 3.B.23 | **$w_i$** | Un solo símbolo en el tema |
| $\lambda_M$ | Precio de mercado del riesgo $E(r_M) - r_f$ | $\lambda_M$ (3.B.23), $\rho$ = prima de riesgo (3.B.2) | $\lambda_M$ o sin símbolo; **no $\rho$** | $\rho$ es el parámetro CES en comercio |
| $P$, $C_t$, $VN$, $y$ | Precio del bono, cupón, nominal, TIR (*yield to maturity*) | $i$ = tipo del cupón (3.B.24); $YTM$ | $C_t$ cupón (o $c$ tipo de cupón), $y$ = TIR del bono | $i$ es tipo de interés en todo el temario; $y$ queda libre al pasar $y$ de 3.B.3 a $ROE$ |
| $r_t$ | Tipo de contado (*spot*) al plazo $t$ | 3.B.24 | Mantener | — |
| $D$, $D^{mod}$, $DV01$ | Duración de Macaulay, modificada, en unidades monetarias | «Precio · r · Duración modificada» (3.B.24) | $D^{mod} = D/(1+y)$; en unidades monetarias $P\cdot D^{mod}$ (por punto básico: $\times 0{,}0001$) | Error de 3.B.24 (sobra $r$) |
| $S_0$, $S_T$, $F_0$, $K$, $c$, $p$, $C$, $P$, $r$, $T$ | Subyacente hoy y al vencimiento; precio a plazo; precio de ejercicio; primas europeas (call, put) y americanas; tipo libre de riesgo; vencimiento | $X$ y $P_{ejercicio}$ para el ejercicio; $C_0$, $P_0$ primas (3.B.25) | **Notación de Hull** | Manual de referencia; $P_0$ choca con el precio de la acción de 3.B.4 |
| $\pi$, $R$, $L$, $c_1$, $c_2$ | Diamond-Dybvig: fracción de impacientes, rendimiento a largo, valor de liquidación, consumos | $\tau$, $r_1 < 1 < r_2$, $r_1^d$, $r_2^d$ (4.A.20); $c$ (3.A.10) | Freixas-Rochet | $\tau$ choca con iceberg y tipos impositivos |
| $APR$ | Activos ponderados por riesgo | 3.B.27 | Mantener | — |
| $\hat r$, $E[B]$ | Tipo del préstamo y beneficio esperado del banco (Stiglitz-Weiss en 3.B.27) | 3.B.27 | Mantener la de `stiglitz-weiss` (área de mercados) | — |

## Conflictos reales y cómo se resuelven
1. **ROA con EBIAT o con EBIT** (3.B.1 frente a 3.B.2): $ROA = EBIT/AT$ y fórmula de apalancamiento con $(1-t)$ al final.
2. **Crecimiento del dividendo $g$/$d$/$y$**: $g$, con $g = b\cdot ROE$.
3. **$r_f$/$R_f$**: minúsculas.
4. **$\varphi$, $\rho$, $\tau$, $P_0$, $i$**: símbolos que este bloque usa con significados de otras áreas (ver tabla).
5. **Precio de ejercicio** $X$/$P_{ejercicio}$ y primas $C_0$/$P_0$: Hull.

## Errores de contenido detectados (para la revisión de cada tema)
- 3.B.1: ROA con EBIAT pero ROCE, cobertura y GAF con EBIT sin aclarar; el GAO se define sobre el EBIAT (debería ser sobre el EBIT); estructura 3.3-3.5 que repite liquidez y solvencia.
- 3.B.2-3.B.4: $WACC$ sin $(1-t_{IS})$ en la deuda.
- 3.B.3: Miller (1977): las condiciones «si $1-t_D < 1-t_E$ el escudo es mayor que en MM (1963)» y la simétrica están **invertidas**. El inventario señala además un $r_E/(1+t_{IRPF})$ dudoso en $P_0$ con impuestos que no se ha localizado en la extracción de texto: comprobar en la revisión.
- 3.B.4: «múltiplo EBITDA» con fórmula de EBIT; apartado «¿Qué método utilizar?» duplicado.
- 3.B.23: $\beta_i = \mathrm{Cov}(E[R_i],E[R_M])/\mathrm{Var}(R_M)$ (covarianza de constantes).
- 3.B.24: duración en unidades monetarias $= P\cdot r\cdot D^{mod}$ (sobra $r$).
- 3.B.25: pago del futuro $S_T - P_{ejercicio}$ (es $S_T - F_0$); en el binomial se descuenta como $C_1(1-r_f)$ en lugar de $C_1/(1+r_f)$ ($10 \cdot 0{,}9 = 9$ frente a $9{,}09$); la valoración tipo Black-Scholes se escribe $\int \max(S_T - Xe^{-r_fT}, 0)\,g(S_T)\,dS_T$ (es $e^{-rT}\int \max(S_T - K,0)\,g^{RN}(S_T)\,dS_T$ con medida neutral al riesgo); beneficio de la put con los tramos mal escritos.
- 3.B.27: «modelo de Corunot»; epígrafe 3.4 «Capital humano de las cajas» fuera de lugar.
- 3.B.26: sin fuente; 3.B.3 remite a 3.B.26 por eurobonos (remisión errónea).

## Choques con otras áreas
- **Macro abierta**: $s_t$, $f_t$ de divisas en 3.B.25 (canon $E$, $F$; en derivados genéricos $S_0$, $F_0$ de Hull, diciendo que $S_0 \equiv E_0$ para divisas); $i$ (tipo de interés) frente a $i$ cupón.
- **Comercio**: $\rho$ (CES) y $\tau$ (iceberg).
- **Macro cerrada**: $r$ real frente a $r$ rentabilidad: en finanzas siempre con subíndice ($r_f$, $r_E$, $r_i$).

Autor: Víctor Gutiérrez Marcos
