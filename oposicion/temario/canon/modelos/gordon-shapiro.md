# Modelo de Gordon-Shapiro (crecimiento constante de dividendos)

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.4 (Métodos de valoración de empresas) — es un método de valoración; 3.B.3 lo usa para la política de dividendos y 3.B.2 da la perpetuidad creciente.
- **Temas que lo usan:** 3.B.4 (desarrollo), 3.B.3 (desarrollo → resumen orientado a dividendos), 3.B.2 (resumen → mención)
- **Manuales de referencia:** Gordon y Shapiro (1956); Gordon (1959, 1962); Brealey, Myers y Allen, cap. 4; Bodie, Kane y Marcus, cap. 18.
- **Decisión D084 (13/10/2026):** ¿Cómo se escriben el crecimiento del dividendo y la rentabilidad de la reinversión en Gordon-Shapiro? g = b·ROE (g crecimiento, b tasa de retención)

## Presentación de referencia
**Pregunta:** ¿cuánto vale una acción si el dividendo crece a tasa constante?

**Supuestos:** dividendos que crecen a tasa constante $g < r_E$ para siempre; tasa de retención $b$ constante; la reinversión rinde $ROE$.

**Ecuaciones (notación canónica):**
$$P_0 = \frac{D_1}{r_E - g} = \frac{D_0(1+g)}{r_E - g}, \qquad g = b\cdot ROE, \qquad D_1 = (1-b)\,BPA_1$$
$$PER = \frac{P_0}{BPA_1} = \frac{1-b}{r_E - b\,ROE}, \qquad \frac{\partial P_0}{\partial b} \gtrless 0 \iff ROE \gtrless r_E$$
**Resultado:** retener beneficios crea valor solo si la reinversión rinde más que el coste de los fondos propios; si $ROE = r_E$, la política de dividendos es irrelevante (enlace con MM, 1961).

**Gráfico de referencia:** ninguno imprescindible.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.4 | Valoración | desarrollo | Fórmula, PER implícito, modelos por etapas | — |
| 3.B.3 | Política de dividendos | resumen | La tesis de relevancia de Gordon frente a MM (1961): $\partial P_0/\partial b$ | Derivación de la perpetuidad |
| 3.B.2 | Coste del capital | mención | Perpetuidad creciente $VP = FC_1/(k-g)$ y $r_E = D_1/P_0 + g$ | — |

## Divergencias encontradas en el temario actual
- **Tasa de crecimiento con tres letras**: $g$ en 3.B.2, $d$ en 3.B.4 e $y$ (rentabilidad de la reinversión) en 3.B.3. Canon: $g$ crecimiento, $ROE$ rentabilidad de la reinversión, $b$ retención (Brealey-Myers, Bodie-Kane-Marcus): $g=b\cdot ROE$.
- Tasa de descuento $k$ (3.B.4) frente a $r_E$ (3.B.3): canon $r_E$.
- Beneficio $B_0$ (3.B.3) frente a $BPA$ (3.B.4): canon $BPA$ por acción y $B$ para el total.

Autor: Víctor Gutiérrez Marcos
