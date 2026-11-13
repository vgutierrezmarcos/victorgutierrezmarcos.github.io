# Crisis de primera generación (Krugman, 1979; Flood y Garber, 1984)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.17** (Teorías explicativas de las crisis de balanza de pagos), **revisado el 12/11/2026**: lo desarrolla en I.1 (`sec:primera`, «Primera generación: crisis por los fundamentos») con a)-e), la función clave `eq:momento-ataque`, el gráfico propio y la derivación en el anexo A. Es el único tema que lo tiene en el título y lo trata como modelo. Ficha nueva de la fase canon del 3.B.17 (12/11/2026; C3 y E5 de sus propuestas, **[decidir]**). El id estaba en el mapa sin fichero.
- **No confundir** con `krugman-1979` (Krugman, 1979, *Journal of International Economics*: competencia monopolística y comercio intraindustrial, 3.B.6). Aquí es Krugman (1979, *Journal of Money, Credit and Banking*), `Krugman1979Model`.
- **Temas que lo usan:** 3.B.17 (desarrollo; hecho, 12/11/2026), 3.A.32 (mención; hecho, 11/11/2026: el dilema del régimen, si se insiste en expandir con tipo fijo, `Krugman1979Model`), 3.A.39 (mención; hecho, 4/11/2026: nota de III.1, monetizar con tipo fijo lleva al ataque), 3.B.11 (mención; hecho, 5/11/2026: el ataque antes de agotar las reservas), 3.B.12 (mención; hecho, 11/11/2026: `Krugman1979Model`, el enfoque monetario como base; ficha `enfoque-monetario-bp`), 3.B.14 (mención; hecho, 11/11/2026: el tipo sombra $\tilde E$ en I.1, l. 163), 3.B.13 (mención; revisado el 8/11/2026, canon pendiente: el «problema del peso» de México 1976), 3.B.15 (mención; hecho, 12/11/2026: I.2.3, la primera generación como riesgo del tipo fijo, `Krugman1979Model`, `\vertema{3.B.17}`, sin la etiqueta «crisis por los fundamentos»), 3.B.20 (mención: Bretton Woods, el *pool* del oro en 1968 y la convertibilidad en 1971), 3.B.21 (uso: América Latina en los 70 y principios de los 80), 3.B.29 (mención: la crisis de la deuda de 1982).
- **Fuentes de referencia** (fijadas en el 3.B.17): Salant y Henderson (1978, *JPE*, `SalantHenderson1978Market`; ataques a las existencias públicas de oro); **Krugman (1979, *JMCB* 11(3), `Krugman1979Model`)**, fundacional; **Flood y Garber (1984, *JIE* 17, `FloodGarber1984`)**, versión lineal y momento del ataque; Flood, Garber y Kramer (1996, `FloodGarberKramer1996Collapsing`; esterilización); Blanco y Garber (1986, `BlancoGarber1986`; México); Cumby y van Wijnbergen (1989; Argentina); Garber (1993; Bretton Woods); Krugman (2001, `Krugman2001Next`; Bretton Woods como motivación); Obstfeld y Rogoff, *Foundations of International Macroeconomics* (1996), cap. 8; Gandolfo, *International Finance and Open-Economy Macroeconomics*, cap. 16.

## Presentación de referencia (3.B.17, I.1)

**Pregunta:** ¿por qué cae un tipo de cambio fijo cuando el banco central financia un déficit, y por qué cae de golpe y antes de que se agoten las reservas?

**Idea (3 pasos):** una política incompatible con la paridad (la monetaria financia el déficit) → las reservas se agotan y el tipo sombra $\tilde E$ se deprecia → el ataque, **predecible e inevitable**, llega antes de que se agoten, en cuanto $\tilde E$ alcanza a $\bar E$. Pegatina: «tanto va el cántaro a la fuente que al final se rompe».

**Supuestos:** economía pequeña y abierta, tipo fijo $\bar E$, libre movilidad del capital, defensa de la paridad **solo con reservas** (sin controles); PPA con el nivel de precios exterior normalizado a 1, $P_t=E_t$ (ficha `ppa`, `\vertema{3.B.14}`); PNCI con previsión perfecta, $i_t=i^*+\dot E_t/E_t$ (ficha `paridad-intereses`); demanda de dinero con la producción constante, $M_t/P_t=kY-h\,i_t$ (la $k$ y la $h$ de la LM, `\vertema{3.A.35}`); balance del banco central con el **multiplicador del dinero igual a 1, sin letra** (`\vertema{3.A.36}`), $M^S_t=\mathrm{CI}_t+R_t$ (`eq:balance-bc`; ficha `enfoque-monetario-bp`, `\vertema{3.B.12}`); el déficit se monetiza: $\dot{\mathrm{CI}}_t=\mu>0$ (**μ aumento por unidad de tiempo, local**: no es un margen); previsión perfecta.

**Ecuaciones (notación canónica):**
- Con $\ell\equiv kY-h\,i^*>0$ (**local**), el mercado de dinero es $M^S_t=\ell E_t-h\dot E_t$ (`eq:dinero-fg`).
- Mientras dura la paridad: $R_t=\ell\bar E-\mathrm{CI}_t$, la pérdida de reservas es **automática**, $\Delta R=-\Delta\mathrm{CI}$ (no es «esterilizar»), y sin ataque se agotarían en $T_N=R_0/\mu$.
- **Tipo de cambio sombra** (el que habría si el banco central, sin reservas, dejara flotar): $\tilde E_t=\mathrm{CI}_t/\ell+h\mu/\ell^2$ (`eq:tipo-sombra`, en `equation`, no recuadrado).
- **Momento del ataque** (no arbitraje, $\tilde E_T=\bar E$), **función clave** `eq:momento-ataque`:
$$T=\frac{R_0}{\mu}-\frac{h}{\ell}<T_N$$
- En $T$ los inversores compran de golpe las reservas que quedan, $h\mu/\ell$; la cantidad de dinero cae en esa cuantía (desde $T$ se espera depreciación, sube el tipo de interés y baja la demanda de dinero); después el tipo flota y se deprecia al ritmo $\mu/\ell$, sin salto.

**Resultado e implicaciones:** el ataque llega antes cuanto menores son $R_0$, mayor $\mu$, más apreciada la paridad ($\bar E$ bajo) y mayor $h$ (con $h=0$ coincidiría con el agotamiento). La causa es la política; solo la evita cambiarla. Fijar el tipo no disciplina: versión abierta de la **dominación fiscal** de Sargent y Wallace (1981) (`\vertema{3.A.39}`). La salida es renunciar a un vértice de la trinidad imposible (`\vertema{3.B.15}`, `\vertema{3.A.32}`; ficha `mundell-fleming`, dilema del régimen).

**Extensiones:** incertidumbre (la probabilidad de devaluación sube poco a poco y la recogen los tipos de interés: el «problema del peso», `\vertema{3.B.13}`); esterilización (Flood, Garber y Kramer, 1996, pasan a un modelo de cartera; México en diciembre de 1994).

**Evidencia:** México 1973-1982 (devaluaciones de 1976 y 1982; Blanco y Garber, 1986), Argentina 1979-1981 (*tablita*), Bretton Woods (*pool* del oro 1968, convertibilidad 1971; Garber, 1993; `\vertema{3.B.20}`). **Bretton Woods motivó el modelo** (Krugman, 2001); el antecedente es Salant y Henderson (1978).

**Valoración:** explica las crisis con déficits monetizados, pero en los 90 predecía mal el momento; información perfecta; trato asimétrico (el gobierno sigue su regla mecánicamente); **sin efectos reales**; el SME de 1992 pide otra explicación (ficha `obstfeld-segunda-generacion`).

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B17/graficos/primera-generacion.tex`** (`fig:primera-generacion`): 3 paneles con $t$ en abscisas; arriba, $\tilde E_t$ que alcanza a $\bar E$ en $T$; en medio, la cantidad de dinero que cae en $T$ y luego crece con el crédito interno; abajo, las reservas, que el ataque se lleva antes de $T_N$. Imprescindible en el cante del 3.B.17. Fuente: «elaboración propia a partir de Krugman (1979) y Flood y Garber (1984)» (nunca «Sahuquillo»).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.17 | Crisis de BP | desarrollo (hecho, 12/11/2026) | I.1 a)-e) con `eq:balance-bc`, `eq:tipo-sombra`, `eq:momento-ataque`, el gráfico y el ejemplo numérico en el anexo A; fila de `tab:tres-generaciones` | — |
| 3.A.32 | Mundell-Fleming, dilema del régimen | mención (hecho, 11/11/2026) | Si se insiste en expandir con tipo fijo, crisis de primera generación (`Krugman1979Model`) | El modelo |
| 3.A.39 | Déficit y señoreaje | mención (hecho, 4/11/2026) | Monetizar con tipo fijo agota las reservas y lleva al ataque | El modelo |
| 3.B.11, 3.B.12 | Balanza de pagos; ajuste | mención (hecho) | Las reservas se agotan y el ataque se anticipa; $M^S=\mathrm{CI}+R$ en el 3.B.12 | El momento del ataque |
| 3.B.14 | Determinación del tipo de cambio | mención (hecho, 11/11/2026) | Definición de $\tilde E$ (I.1); conviene que diga que el ataque se adelanta al agotamiento (`pendientes-coherencia.md`, «Pendiente del 3.B.17») | El modelo |
| 3.B.13 | Mercado de divisas | mención (revisado, canon pendiente) | El «problema del peso» de México 1976 | — |
| 3.B.15 | Regímenes cambiarios | mención (hecho, 12/11/2026) | I.2.3, una viñeta: una política incoherente con la paridad (un déficit financiado con crédito interno) agota las reservas hasta el ataque (`Krugman1979Model`), `\vertema{3.B.17}`. Falta la etiqueta «crisis por los fundamentos» (cosmético; `pendientes-coherencia.md`, «Pendiente del 3.B.15») | — |
| 3.B.29 | Deuda externa del desarrollo | mención (hecho, 12/11/2026) | La crisis de 1982 y las de los 90 con `\vertema{3.B.17}`, **sin la clasificación por generaciones** (paradas súbitas, descalces y crisis gemelas en una viñeta) | El modelo |
| 3.B.20, 3.B.21 | Historia | uso | Bretton Woods y América Latina 70-80 como ejemplos, con la clasificación de `tab:tres-generaciones` | El modelo |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.17 (12/11/2026):** $\tilde e$, $\bar e$ → $\tilde E$, $\bar E$ (D013); multiplicador $(e+1)/(e+q)=1$ → «multiplicador igual a 1» sin letras; «el banco central esteriliza» → pérdida automática $\Delta R=-\Delta\mathrm{CI}$; título sin Krugman (1979); «se ajusta a la ruptura de Bretton Woods» como caso del modelo → motivación (Krugman, 2001); gráfico escaneado con «Fuente: Sahuquillo» → TikZ propio.
- **3.B.20 (Word, sin revisar):** llama «crisis cambiaria de primera generación» a la de la libra en el patrón oro por «expectativas ligadas a la confianza»: si es por confianza, es de segunda generación (contradicción anotada en `mapa.yaml`, 3.B.17).
- **3.B.21 (Word, sin revisar):** México 1994 como «primera generación»: el canon lo lee como crisis **mixta** (ficha `paradas-subitas`).

Autor: Víctor Gutiérrez Marcos
