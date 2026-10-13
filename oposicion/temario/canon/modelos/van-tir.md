# Criterios VAN y TIR

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.2 (La empresa y las decisiones de inversión: criterios de valoración de proyectos) — lo tiene en el título; 4.B.6 lo aplica al análisis coste-beneficio público.
- **Temas que lo usan:** 3.B.2 (desarrollo), 4.B.6 (desarrollo → resumen con la tasa social de descuento)
- **Manuales de referencia:** Brealey, Myers y Allen, *Principles of Corporate Finance*, caps. 2, 5-6; Berk y DeMarzo, *Corporate Finance*, caps. 4 y 7; Suárez Suárez, *Decisiones óptimas de inversión y financiación en la empresa*; Boardman et al., *Cost-Benefit Analysis* (para 4.B.6).

## Presentación de referencia
**Pregunta:** ¿qué proyectos debe acometer la empresa?

**Supuestos:** flujos de caja ciertos (o en equivalente cierto), tasa de descuento = coste de oportunidad del capital ($WACC$ si el proyecto tiene el riesgo medio de la empresa), mercado de capitales perfecto (Fisher).

**Ecuaciones (notación canónica):**
$$VAN = -I_0 + \sum_{t=1}^{n}\frac{FC_t}{(1+k)^t} + \frac{VR}{(1+k)^n}, \qquad -I_0 + \sum_{t=1}^{n}\frac{FC_t}{(1+TIR)^t} + \frac{VR}{(1+TIR)^n} = 0$$
TIR modificada: $\big(\sum_t FC_t(1+k)^{n-t}\big)/I_0 = (1+TIRM)^n$; *payback* $= I_0/FC$ con flujos constantes.

**Resultado:** el VAN es el criterio coherente con maximizar el valor; la TIR puede ordenar mal proyectos excluyentes (escala, calendario: punto de Fisher) y puede ser múltiple o no existir.

**Gráfico de referencia:** VAN en función de $k$ para dos proyectos, con las TIR (cortes con el eje) y el punto de Fisher (cruce). Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.2 | Criterios de valoración de proyectos | desarrollo | VAN, TIR, TIRM, *payback*, índice de rentabilidad; riesgo (tasa ajustada, equivalente cierto) | — |
| 4.B.6 | Análisis coste-beneficio | resumen aplicado | $VAN = \sum_t (B_t - C_t)/(1+\delta)^t$ con tasa social de descuento $\delta$; TIR y sus problemas en una línea [ver tema 3.B.2] | Punto de Fisher y TIRM completos |

## Divergencias encontradas en el temario actual
- Desembolso $A$ y flujos $Q_t$ en 3.B.2 frente a $B_t - C_t$ en 4.B.6 y $FC_t$/$FCL_t$ en 3.B.4. Canon: $I_0$ y $FC_t$ en finanzas; $B_t$, $C_t$ y $\delta$ en ACB público.
- Tasa de descuento $k$, $WACC$ o $r$ usados indistintamente en 3.B.2: canon $k$ (genérica) y $WACC$ cuando se use el coste medio ponderado.

Autor: Víctor Gutiérrez Marcos
