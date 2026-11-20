# Modelo de Black y Scholes (1973) y Merton (1973); griegas

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.25** (revisado el 8/11/2026, II.5 con a)-e), `eq:black-scholes` función clave; la integral en el anexo A; griegas en el anexo E) — desarrollo. Ficha creada en la pasada final (noviembre de 2026) a propuesta del 3.B.25 (§ 9, punto 4).
- **Temas que lo usan:** 3.B.25 (desarrollo; hecho, 8/11/2026), 3.B.4 (resumen; hecho, 8/11/2026: recuadro de opciones reales con esta notación), 3.B.26 (mención; hecho, 12/11/2026: griegas y cobertura en la gestión de riesgos; Merton, 1974, para el riesgo de crédito, ficha `riesgo-credito`), 3.A.34 y 3.B.2 (mención; ficha `opciones-reales`).
- **Manuales de referencia:** Black y Scholes (1973), *JPE*; Merton (1973), *Bell Journal* (`Merton1973Theory`); Black (1976); Hull (2022), caps. 15 y 19.

## Presentación de referencia (3.B.25, II.5)
**Pregunta:** ¿cuánto vale una opción europea cuando el subyacente se mueve de forma continua?

**Supuestos:** precio lognormal (movimiento browniano geométrico), $r$ y $\sigma$ constantes, sin dividendos, negociación continua sin costes, ventas en corto, sin arbitraje.

**Ecuaciones:** función clave
$$c=S_0\,N(d_1)-K\,e^{-rT}N(d_2),\qquad d_1=\frac{\ln(S_0/K)+(r+\sigma^2/2)T}{\sigma\sqrt T},\quad d_2=d_1-\sigma\sqrt T$$
(`eq:black-scholes`, `eq:d1-d2`); en el anexo A, $c=e^{-rT}\mathbb{E}^{\mathbb{Q}}[\max(S_T-K,0)]$ (`eq:neutral-riesgo`). $N(d_2)$ es la probabilidad neutral al riesgo de ejercer; $N(d_1)$, la delta. La *put*, por la paridad (ficha `put-call`).

**Extensiones:** dividendos ($S_0e^{-qT}$, Merton, 1973), opciones sobre futuros (Black, 1976), americanas por árboles. **Evidencia:** volatilidad implícita, sonrisa y sesgo tras 1987, el VIX («índice del miedo»), colas gruesas. **Valoración:** volatilidad no constante, saltos, no normalidad; se usa por la fórmula cerrada y las griegas. Black murió en 1995 (no Scholes).

**Notación:** griegas $\Delta$, $\Gamma$, $\mathcal{V}$ (vega), $\Theta$, $\rho$ (Hull; locales del anexo E; ν ya es la sensibilidad del saldo comercial en § 9); $\mathbb{E}^{\mathbb{Q}}$ medida neutral al riesgo.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B25/graficos/valor-call.tex`, `determinantes-bs.tex`, `griegas.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.25 | Valoración de opciones | desarrollo (hecho, 8/11/2026) | Todo lo anterior | — |
| 3.B.4 | Valoración de empresas | resumen (hecho, 8/11/2026) | Recuadro con la fórmula, aplicada a las opciones reales ($S_0\leftrightarrow V_0$, $K\leftrightarrow I_0$) | La derivación |
| 3.B.26 | Gestión de riesgos | mención (hecho, 12/11/2026) | Griegas y cobertura; Merton (1974) | La fórmula |
| 3.A.34, 3.B.2 | Opción de esperar | mención | La opción de invertir como *call* americana | — |

## Divergencias encontradas en el temario actual
- 3.B.25 (original): nota 27, «habría fallecido Scholes» (es Black); $N(d_1)$ presentada como probabilidad. **Resuelto** (8/11/2026).

Autor: Víctor Gutiérrez Marcos
