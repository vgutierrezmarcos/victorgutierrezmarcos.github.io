# Hipótesis de expectativas, normal backwardation y contango

- **Área:** finanzas-empresa (comparte con macro abierta) · **Tema de referencia:** 3.B.25 (Instrumentos y mercados de derivados): el mapa lo asignaba a 3.B.13 porque ninguno lo desarrolla, pero es una teoría del precio de los futuros (Keynes, 1930; Hicks, 1939) y encaja en el título de 3.B.25; 3.B.13 solo necesita su versión para el *forward* de divisas.
- **Temas que lo usan:** 3.B.25 (desarrollo; hecho, 8/11/2026: I.5 en el cuerpo y anexo C `anexo:contango`), 3.B.13 (mención; hecho, 8/11/2026: sin anexo, en la salida de la prima de riesgo de la paradoja del *forward*, con `\vertema{3.B.25}`), 3.B.24 (mención; hecho, 13/11/2026: una línea, la analogía con la teoría de las expectativas de la ETTI; ni $F_0$ ni $S_T$ ni el gráfico; ficha `ett-expectativas`)
- **Manuales de referencia:** Hull, *Options, Futures and Other Derivatives*, cap. 5 (*Futures prices and expected future spot prices*); Keynes, *Treatise on Money* (1930); Hicks, *Value and Capital* (1939); Bodie, Kane y Marcus, *Investments*, cap. 22.
- **Decisión D116 (13/10/2026):** ¿Cuál es el tema de referencia de la teoría de las expectativas y el contango (Keynes, Hicks)? 3.B.25 (derivados), con mención en 3.B.13 y el anexo duplicado solo en 3.B.25

## Presentación de referencia
**Pregunta:** ¿es el precio futuro un predictor insesgado del precio de contado esperado?

**Ecuaciones (notación canónica):**
- Hipótesis de expectativas: $F_0 = \mathbb{E}_0[S_T]$.
- *Normal backwardation* (Keynes-Hicks: los coberturistas son vendedores y pagan una prima): $F_0 < \mathbb{E}_0[S_T]$.
- *Contango* (coberturistas compradores): $F_0 > \mathbb{E}_0[S_T]$.
- Con precio por coste de mantenimiento: $F_0 = S_0 e^{(r+u-y)T}$; en divisas, $F_0 = S_0 e^{(i-i^*)T}$ (la PCI en tiempo continuo; ficha `spot-futuros`).
- Relación con el coste de mantenimiento (3.B.25, anexo C): $F_0=\mathbb{E}_0[S_T]\,e^{(r-k)T}$, con $k$ la rentabilidad exigida al subyacente: *backwardation* si $k>r$ (Hull, cap. 5). Enfoque moderno con el CAPM: la prima del futuro depende de la beta del subyacente (Dusak, 1973; Bodie, Kane y Marcus, cap. 22; ficha `capm`). Evidencia: el sesgo del *forward* en divisas (Fama, 1984, `\vertema{3.B.13}`) y la prima de riesgo en materias primas.

Aviso de terminología: en el uso de mercado, *contango* y *backwardation* se refieren a menudo a $F_0$ frente a $S_0$ (pendiente de la curva de futuros), no frente a $\mathbb{E}_0[S_T]$; hay que decir cuál se usa.

**Gráfico de referencia:** `oposicion/temario/fuentes/3B25/graficos/contango.tex` (`fig:contango`: $F_t$ de 0 a $T$ en los 3 casos, convergiendo a $\mathbb{E}_0[S_T]$) (pasada final, nov. 2026). **Notación:** esperanza $\mathbb{E}_0[S_T]$ (canon § 0; la $E$ latina es el tipo de cambio en el 3.B.13), nunca $E^e(S_T)$ ni $E_T[S_T]$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Derivados | desarrollo (hecho, 8/11/2026; cuerpo 1′15″ y anexo C) | Las tres hipótesis con el gráfico, relación con el coste de mantenimiento y la evidencia | — |
| 3.B.13 | Mercados de divisas | mención (hecho, 8/11/2026) | El sesgo del *forward* como prima de riesgo (Fama, 1984) dentro de la paradoja del margen *forward*; remitir a 3.B.25 | El anexo con los tres gráficos |
| 3.B.24 | Renta fija y ETTI | mención (hecho, 13/11/2026) | Analogía con la teoría de expectativas y la prima de liquidez de la ETTI | — |

## Divergencias encontradas en el temario actual
- **Resuelto (8/11/2026):** el anexo duplicado del 3.B.13 desaparece (mención con `\vertema{3.B.25}`); el 3.B.25 dice con qué compara $F_0$.
- **Anexo duplicado** (originales) literalmente en 3.B.13 y 3.B.25 (mismo título y gráficos). Reparto: un único desarrollo en 3.B.25 y mención en 3.B.13.
- Los anexos no fijan si comparan $F$ con $S_0$ o con $\mathbb{E}_0[S_T]$; el canon exige decirlo.
- En 3.B.25 el *forward* de divisas se escribe $f_t$ y el spot $s_t$ (heredado de 3.B.13); canon de área: $F$ y $E$ (ver `_notacion/macro-abierta.md`) y, dentro de derivados genéricos, $F_0$ y $S_0$ como en Hull.

Autor: Víctor Gutiérrez Marcos
