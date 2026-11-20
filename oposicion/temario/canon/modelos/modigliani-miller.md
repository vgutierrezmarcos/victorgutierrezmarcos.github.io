# Modigliani-Miller y extensiones (impuestos, quiebra, Miller 1977)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.3 (Decisiones de financiación: estructura del capital) — lo tiene en el título; 4.B.10 lo usa para el efecto de los impuestos.
- **Temas que lo usan:** 3.B.3 (desarrollo; hecho, 8/11/2026: `eq:mm` y `eq:trade-off` como funciones clave), 3.B.2 (mención; hecho, 8/11/2026: «con impuestos y costes de insolvencia, hay un endeudamiento óptimo \vertema{3.B.3}»), 3.B.4 (mención; hecho, 8/11/2026: irrelevancia de MM y APV con el coste de la insolvencia, `\vertema{3.B.3}`), 3.B.1 (mención; hecho, 13/11/2026: la relación ROE-ROA es la versión contable y *ex post* de la proposición II, en nota), 4.B.10 (desarrollo → resumen centrado en IS e IRPF), 4.B.12 (mención), 3.A.34 (mención; hecho, 31/10/2026: III.4 a), con mercados perfectos la decisión de invertir se separa de la de financiarse, `\vertema{3.B.3}`; y en la nota de Hayashi, para medir la q media en bolsa) También 3.A.37 (mención; hecho, 5/11/2026: II.3, sin fricciones se cumple Modigliani-Miller y la financiación no importa, `\vertema{3.A.34}`; III.3, Wallace, 1981, como «un teorema de Modigliani y Miller para el balance del banco central», `\vertema{3.A.39}`).
- **Manuales de referencia:** Modigliani y Miller (1958, 1961, 1963); Miller (1977); Kim (1978); Myers (1984); Brealey, Myers y Allen, caps. 17-18; Berk y DeMarzo, caps. 14-16; Tirole, *The Theory of Corporate Finance*.

## Presentación de referencia
**Pregunta:** ¿existe una estructura financiera óptima?

**Supuestos (MM 1958):** mercados perfectos (sin impuestos, costes de quiebra ni de agencia), **información simétrica**, mismas condiciones de endeudamiento para empresas e inversores, **clases de riesgo** (no «neutralidad»: los inversores no tienen por qué ser neutrales al riesgo).

**Notación (3.B.3, 8/11/2026):** $V_U$ y $V_L$ valor sin y con deuda (aviso: $L$ sin subíndice es el peso $V_D/V$); $V_E$, $V_D$ de mercado; $V_D/V_E$ ratio deuda/fondos propios (nunca α, que es el alfa de Jensen); $\mathrm{VA}(\cdot)$ en redonda; $(V_D/V_E)^*$ y $V_D^*$ para el óptimo; $t_{IS}$, $t_E$, $t_D$.

**Ecuaciones (notación canónica):**
- Proposición I: $V_L = V_U$. Proposición II: $r_E = r_A + (r_A - r_D)\,\dfrac{V_D}{V_E}$, con $r_A = WACC$ sin impuestos.
- Con IS (1963): $V_L = V_U + t_{IS} V_D$.
- Con IS e IRPF (Miller, 1977): $V_L = V_U + \Big[1 - \dfrac{(1-t_{IS})(1-t_{E})}{1-t_{D}}\Big] V_D$, con $t_E$ y $t_D$ los tipos del IRPF sobre rendimientos de acciones y de deuda.
- Con costes de quiebra (Kim, 1978): *trade-off* entre escudo fiscal y coste esperado de insolvencia, `eq:trade-off`: $V_L=V_U+\mathrm{VA}(\text{escudo fiscal})-\mathrm{VA}(\text{costes de insolvencia})$.
- El **caso español de Miller**: con $t_D\approx t_E$ (base del ahorro del IRPF), la ventaja de la deuda vuelve a ser $t_{IS}$.

**Resultado:** sin fricciones la estructura es irrelevante; los impuestos favorecen la deuda; Miller (1977) puede anular la ventaja; la teoría del equilibrio (*trade-off*) da un óptimo interior; *pecking order* como alternativa.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B03/graficos/coste-capital.tex` ($r_E$, $r_D$ y WACC frente a $V_D/V_E$ en 4 paneles: tesis tradicional, MM sin impuestos, MM con IS, con quiebra; colores $r_E$/$r_D$/WACC fijos) y `valor-tradeoff.tex` ($V_L$ frente a $V_D$, con $V_D^*$) (pasada final, nov. 2026).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.3 | Estructura del capital | desarrollo (hecho, 8/11/2026) | Tesis tradicional, MM I y II (con $r_A$, no el WACC), IS, Miller y el caso español, quiebra (`eq:trade-off`), *pecking order* | — |
| 3.B.2 | Coste del capital | mención (hecho, 8/11/2026) | Con impuestos y costes de insolvencia hay un endeudamiento óptimo `\vertema{3.B.3}` | Las proposiciones |
| 3.B.4 | Valoración y crecimiento | mención (hecho, 8/11/2026) | Irrelevancia, APV con el coste de la insolvencia, LBO `\vertema{3.B.3}` | Las proposiciones |
| 3.B.1 | Análisis financiero | mención (hecho, 13/11/2026) | En nota: `eq:roe-roa` es la versión contable de la proposición II | — |
| 4.B.10 | Impuesto sobre sociedades | resumen | Escudo fiscal y Miller (1977); sesgo deuda-fondos propios (ACE/CBIT) | MM sin impuestos y su arbitraje |
| 4.B.12 | Imposición y dividendos | mención | El IS rompe la irrelevancia | — |
| 3.A.34 | Teorías de la inversión | mención (hecho, 31/10/2026) | Separación de inversión y financiación como punto de partida de las fricciones financieras; jerarquía financiera (ficha `pecking-order`) | Las proposiciones y los impuestos |
| 3.A.37 | Transmisión: fricciones financieras y compras de activos | mención (hecho, 5/11/2026) | II.3: el punto de partida sin fricciones; III.3: la irrelevancia de Wallace (1981) como Modigliani-Miller del balance del banco central | La estructura del capital |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.3 (8/11/2026):** supuestos (clases de riesgo, información simétrica, sin «neutralidad»), Miller con los casos bien, $r_A$ en la proposición II, $L$ y $V_D/V_E$ separados, $V_U$/$V_L$ en lugar de $A$/$B$. Lo que sigue describe el original.
- **Error en 3.B.3**: «Si $1-t_D < 1-t_E$, el escudo fiscal es mayor que en MM (1963)» y su simétrico están **invertidos**: si $t_D > t_E$, el cociente $(1-t_E)/(1-t_D) > 1$ y la ventaja de la deuda es **menor** que $t_{IS}$.
- 4.B.10 y 4.B.12: los Word disponibles son del temario antiguo y no tratan MM ni la imposición de dividendos; no se ha podido contrastar.
- Apalancamiento: $V_D/V_E$ en 3.B.3 frente a $L = V_D/(V_D+V_E)$ en 4.B.10. Canon: $L = V_D/V$ (peso) y $V_D/V_E$ (ratio) con nombres distintos.
- Tipos del IRPF: $t_{IRPF}^D$, $t_{IRPF}^E$ en 4.B.10 y $t_{IRPF_D}$ en 3.B.3: canon $t_D$, $t_E$ (y $t_{IS}$).

Autor: Víctor Gutiérrez Marcos
