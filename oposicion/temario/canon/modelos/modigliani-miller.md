# Modigliani-Miller y extensiones (impuestos, quiebra, Miller 1977)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.3 (Decisiones de financiación: estructura del capital) — lo tiene en el título; 4.B.10 lo usa para el efecto de los impuestos.
- **Temas que lo usan:** 3.B.3 (desarrollo), 4.B.10 (desarrollo → resumen centrado en IS e IRPF), 4.B.12 (mención)
- **Manuales de referencia:** Modigliani y Miller (1958, 1961, 1963); Miller (1977); Kim (1978); Myers (1984); Brealey, Myers y Allen, caps. 17-18; Berk y DeMarzo, caps. 14-16; Tirole, *The Theory of Corporate Finance*.

## Presentación de referencia
**Pregunta:** ¿existe una estructura financiera óptima?

**Supuestos (MM 1958):** mercados perfectos (sin impuestos, costes de quiebra ni de agencia), mismas condiciones de endeudamiento para empresas e inversores, clases de riesgo.

**Ecuaciones (notación canónica):**
- Proposición I: $V_L = V_U$. Proposición II: $r_E = r_A + (r_A - r_D)\,\dfrac{V_D}{V_E}$, con $r_A = WACC$ sin impuestos.
- Con IS (1963): $V_L = V_U + t_{IS} V_D$.
- Con IS e IRPF (Miller, 1977): $V_L = V_U + \Big[1 - \dfrac{(1-t_{IS})(1-t_{E})}{1-t_{D}}\Big] V_D$, con $t_E$ y $t_D$ los tipos del IRPF sobre rendimientos de acciones y de deuda.
- Con costes de quiebra (Kim, 1978): *trade-off* entre escudo fiscal y coste esperado de insolvencia.

**Resultado:** sin fricciones la estructura es irrelevante; los impuestos favorecen la deuda; Miller (1977) puede anular la ventaja; la teoría del equilibrio (*trade-off*) da un óptimo interior; *pecking order* como alternativa.

**Gráfico de referencia:** $r_E$, $r_D$ y $WACC$ frente a $V_D/V_E$ en cuatro paneles (tesis tradicional, MM sin impuestos, MM con IS, con quiebra). Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.3 | Estructura del capital | desarrollo | Tesis tradicional, MM I y II, IS, Miller, quiebra, *pecking order* | — |
| 4.B.10 | Impuesto sobre sociedades | resumen | Escudo fiscal y Miller (1977); sesgo deuda-fondos propios (ACE/CBIT) | MM sin impuestos y su arbitraje |
| 4.B.12 | Imposición y dividendos | mención | El IS rompe la irrelevancia | — |

## Divergencias encontradas en el temario actual
- **Error en 3.B.3**: «Si $1-t_D < 1-t_E$, el escudo fiscal es mayor que en MM (1963)» y su simétrico están **invertidos**: si $t_D > t_E$, el cociente $(1-t_E)/(1-t_D) > 1$ y la ventaja de la deuda es **menor** que $t_{IS}$.
- Apalancamiento: $V_D/V_E$ en 3.B.3 frente a $L = V_D/(V_D+V_E)$ en 4.B.10. Canon: $L = V_D/V$ (peso) y $V_D/V_E$ (ratio) con nombres distintos.
- Tipos del IRPF: $t_{IRPF}^D$, $t_{IRPF}^E$ en 4.B.10 y $t_{IRPF_D}$ en 3.B.3: canon $t_D$, $t_E$ (y $t_{IS}$).

Autor: Víctor Gutiérrez Marcos
