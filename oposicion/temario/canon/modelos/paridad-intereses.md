# Paridades de intereses (cubierta y no cubierta)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.13 (Mercados de divisas: operaciones e instrumentos) — la PCI es la condición de no arbitraje de las operaciones a plazo y la PNCI la de la especulación; ambas y su contraste (paradoja del margen *forward*) ya se desarrollan allí. 3.B.14 las usa como teoría de determinación.
- **Temas que lo usan:** 3.B.13 (desarrollo), 3.B.14 (desarrollo → resumen), 3.B.25 (mención: precio del *forward* de divisas), 3.B.12, 3.B.15, 3.B.17 (uso de $i = i^* + \gamma E^e$)
- **Manuales de referencia:** Krugman, Obstfeld y Melitz, cap. 14 y apéndice (paridad de intereses); Sarno y Taylor, *The Economics of Exchange Rates*, cap. 2; Obstfeld y Rogoff, *Foundations…*, cap. 8; Fama (1984); Froot y Thaler (1990).
- **Decisión D013 (13/10/2026):** ¿Cómo se escribe el tipo de cambio nominal en niveles, a plazo, en logaritmos y esperado? E (directo, ↑E = depreciación), F a plazo, minúsculas e, f para logaritmos, E^e_{t+1} para el esperado; la esperanza se escribe 𝔼_t[·]
- **Decisión D082 (13/10/2026):** ¿Cómo se llama la paridad de intereses sin cobertura? Paridad no cubierta de intereses (PNCI), citando PDI («descubierta») como sinónimo

## Presentación de referencia
**Pregunta:** ¿qué relación impone el arbitraje (o la especulación) entre tipos de interés y tipos de cambio?

**Supuestos:** movilidad perfecta de capitales, sustituibilidad perfecta de activos (mismo riesgo de impago), sin costes de transacción; para la PNCI además neutralidad al riesgo.

**Ecuaciones (notación canónica; $E$ tipo de cambio directo al contado, $F$ a plazo):**
$$\text{PCI:}\quad 1+i = (1+i^*)\,\frac{F_t^{t+1}}{E_t} \;\;\Rightarrow\;\; i - i^* \approx \frac{F_t^{t+1}-E_t}{E_t}\;(\text{margen } forward)$$
$$\text{PNCI:}\quad 1+i = (1+i^*)\,\frac{E^e_{t+1}}{E_t} \;\;\Rightarrow\;\; i - i^* \approx \frac{E^e_{t+1}-E_t}{E_t} \equiv \gamma E^e$$
La aproximación se obtiene tomando logaritmos: $\ln(1+i) = \ln(1+i^*) + \ln F - \ln E$ (suma, no producto) y $\ln(1+x)\approx x$.
Contraste (Fama, 1984): $\Delta e_{t+1} = \beta_0 + \beta_1 (f_t - e_t) + \varepsilon_{t+1}$ con minúsculas en logaritmos; la PNCI con expectativas racionales exige $\beta_1 = 1$ y se estima $\beta_1 < 0$ (paradoja del margen *forward*).

**Resultado:** la PCI se cumple casi siempre (salvo tensiones de liquidez: *cross-currency basis* desde 2008); la PNCI falla, lo que se explica por prima de riesgo, expectativas no racionales o *peso problem*.

**Gráfico de referencia:** ninguno imprescindible; opcional: dispersión de $\Delta e_{t+1}$ frente a $f_t-e_t$ con la recta de 45° y la estimada.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.13 | Operaciones e instrumentos; eficiencia del mercado | desarrollo | PCI como arbitraje (con su ajuste de $i$, $i^*$, $E$, $F$), PNCI como especulación, contraste de Fama y salidas a la paradoja | — |
| 3.B.14 | Determinación del tipo de cambio | resumen | Las dos ecuaciones y su lectura como teoría de $E$; la PNCI como pieza de Dornbusch y del enfoque monetario | Derivación completa y evidencia empírica (remitir a 3.B.13) |
| 3.B.25 | Derivados | mención | Precio del *forward* de divisas por PCI: $F_0 = S_0 e^{(i-i^*)T}$ | El razonamiento de arbitraje paso a paso |
| 3.B.15, 3.B.17 | Regímenes; crisis | mención | $i = i^* + \gamma E^e$ (+ prima de riesgo) como restricción de la política monetaria con tipo fijo | — |

## Divergencias encontradas en el temario actual
- **Repetición**: el bloque de paridades está casi literal en 3.B.13 y 3.B.14 (el Word lo admite: «Es parecido en los temas 3.B.13 y 3.B.14») y la PCI vuelve en 3.B.25.
- **Notación del tipo de cambio**: $E$ en el resto de ambos temas y $s_t$, $f_t^{t+1}$ en las paridades (dentro de 3.B.13 y dentro de 3.B.14). Canon: $E_t$, $F_t^{t+1}$ en niveles, $e_t$, $f_t$ solo para logaritmos y $E^e_{t+1}$ para el tipo esperado (ver `_notacion/macro-abierta.md`).
- **Nombre**: «paridad descubierta (PDI)» en 3.B.13 y «paridad no cubierta (PNCI)» en 3.B.14. Canon: «paridad no cubierta de intereses» (PNCI), citando PDI como sinónimo.
- **Errores en 3.B.13**: (i) paso «$\ln(1+i) = \ln(1+i^*)\cdot\ln(\dots)$» (es una suma de logaritmos); (ii) en la PCI, el margen *forward* se etiqueta «tasa de depreciación esperada» (solo coinciden si además se cumple la PNCI); (iii) «el arbitraje garantiza el cumplimiento continuo de la PDI»: la PNCI es una condición de especulación y no se cumple continuamente (lo dice el propio tema en el apartado 3.3).
- En 3.B.14 el apartado «Implicaciones» repite $1+i = (1+i^*)s_{t+1}/s_t$ sin expectativa: debe ser $E^e_{t+1}$.

Autor: Víctor Gutiérrez Marcos
