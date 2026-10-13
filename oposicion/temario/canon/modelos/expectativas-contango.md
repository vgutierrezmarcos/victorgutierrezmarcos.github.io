# Hipótesis de expectativas, normal backwardation y contango

- **Área:** macro-abierta (comparte con finanzas) · **Tema de referencia:** 3.B.25 (Instrumentos y mercados de derivados): el mapa lo asignaba a 3.B.13 porque ninguno lo desarrolla, pero es una teoría del precio de los futuros (Keynes, 1930; Hicks, 1939) y encaja en el título de 3.B.25; 3.B.13 solo necesita su versión para el *forward* de divisas.
- **Temas que lo usan:** 3.B.13 (resumen → mención), 3.B.25 (resumen → desarrollo); relacionado con 3.B.24 (teoría de expectativas de la ETTI)
- **Manuales de referencia:** Hull, *Options, Futures and Other Derivatives*, cap. 5 (*Futures prices and expected future spot prices*); Keynes, *Treatise on Money* (1930); Hicks, *Value and Capital* (1939); Bodie, Kane y Marcus, *Investments*, cap. 22.
- **Decisión D116 (13/10/2026):** ¿Cuál es el tema de referencia de la teoría de las expectativas y el contango (Keynes, Hicks)? 3.B.25 (derivados), con mención en 3.B.13 y el anexo duplicado solo en 3.B.25

## Presentación de referencia
**Pregunta:** ¿es el precio futuro un predictor insesgado del precio de contado esperado?

**Ecuaciones (notación canónica):**
- Hipótesis de expectativas: $F_0 = E^e(S_T)$.
- *Normal backwardation* (Keynes-Hicks: los coberturistas son vendedores y pagan una prima): $F_0 < E^e(S_T)$.
- *Contango* (coberturistas compradores): $F_0 > E^e(S_T)$.
- Con precio por coste de mantenimiento: $F_0 = S_0 e^{(r+u-y)T}$; en divisas, $F_0 = S_0 e^{(i-i^*)T}$ (la PCI en tiempo continuo).

Aviso de terminología: en el uso de mercado, *contango* y *backwardation* se refieren a menudo a $F_0$ frente a $S_0$ (pendiente de la curva de futuros), no frente a $E^e(S_T)$; hay que decir cuál se usa.

**Gráfico de referencia:** trayectoria de $F_t$ hasta $T$ convergiendo a $S_T$ en los tres casos (recta horizontal, creciente, decreciente). Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Derivados | desarrollo | Las tres hipótesis con el gráfico, relación con el coste de mantenimiento y la evidencia | — |
| 3.B.13 | Mercados de divisas | mención | El sesgo del *forward* como prima de riesgo (Fama, 1984) dentro de la paradoja del margen *forward*; remitir a 3.B.25 | El anexo con los tres gráficos |
| 3.B.24 | Renta fija y ETTI | mención | Analogía con la teoría de expectativas y la prima de liquidez de la ETTI | — |

## Divergencias encontradas en el temario actual
- **Anexo duplicado** literalmente en 3.B.13 y 3.B.25 (mismo título y gráficos). Reparto: un único desarrollo en 3.B.25 y mención en 3.B.13.
- Los anexos no fijan si comparan $F$ con $S_0$ o con $E^e(S_T)$; el canon exige decirlo.
- En 3.B.25 el *forward* de divisas se escribe $f_t$ y el spot $s_t$ (heredado de 3.B.13); canon de área: $F$ y $E$ (ver `_notacion/macro-abierta.md`) y, dentro de derivados genéricos, $F_0$ y $S_0$ como en Hull.

Autor: Víctor Gutiérrez Marcos
