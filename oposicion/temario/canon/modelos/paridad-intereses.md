# Paridades de intereses (cubierta y no cubierta)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.13 (Mercados de divisas: operaciones e instrumentos) — la PCI es la condición de no arbitraje de las operaciones a plazo y la PNCI la de la especulación; ambas y su contraste (paradoja del margen *forward*) ya se desarrollan allí. 3.B.14 las usa como teoría de determinación.
- **Temas que lo usan:** 3.B.13 (desarrollo), 3.B.14 (resumen; hecho, 11/11/2026), 3.B.25 (mención: precio del *forward* de divisas), 3.B.12, 3.B.15 (uso de $i = i^* + \gamma E^e$); 3.B.17 (mención; hecho, 12/11/2026: en continuo, $i_t=i^*+\dot E_t/E_t$ con previsión perfecta en la primera generación, y $i-i^*\approx\gamma E^e+\rho$ como coste de defender la paridad en la segunda, con el aviso «$\gamma E^e$ es la depreciación esperada, no el peso γ de la pérdida»; cumple el 3.B.13) También 3.A.37 (mención; hecho, 5/11/2026: I.2, el canal del tipo de cambio con la PNCI $i=i^*+\gamma E^e$ y $E$ directo, euros por dólar, `\vertema{3.B.14}`). También 3.A.32 (supuesto de Mundell-Fleming; hecho, 11/11/2026); 3.B.19 (supuesto; hecho, 12/11/2026: Hamada y Mundell-Fleming con 2 países, `\vertema{3.B.13}`).
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
| 3.B.14 | Determinación del tipo de cambio | resumen (hecho, 11/11/2026) | I.3: `eq:pci` y `eq:pnci` con la forma del 3.B.13 ($E_t$, $F_t^{t+1}$, $E^e_{t+1}$, $\gamma E^e$), su lectura como teoría de $E$, el **cuadro de las paridades** (gráfico `fuentes/3B14/graficos/paridades.tex`: PPA relativa, Fisher internacional, PNCI y PCI; el *forward* como predictor insesgado), la PNCI con prima ρ, la PCI «casi exacta hasta 2008; desde entonces, base de los *swaps*» (`DuTepperVerdelhan2018Deviations`, las palabras del 3.B.13 y el 3.B.25); Keynes (1923), `Keynes1923Tract`; en Dornbusch, en logaritmos y tiempo continuo, $i=i^*+\dot e^{\,e}$; con prima financiera, `eq:pnci-prima` $i_t-i^*_t=\mathbb E_t[e_{t+1}]-e_t+\rho_t$ (Itskhoki y Mukhin, 2021); la paradoja del *forward* en resumen (`eq:fama-tc`), `\vertema{3.B.13}` | Derivación completa, evidencia y los 3 sentidos de la eficiencia (3.B.13) |
| 3.B.25 | Derivados | mención | Precio del *forward* de divisas por PCI: $F_0 = S_0 e^{(i-i^*)T}$ | El razonamiento de arbitraje paso a paso |
| 3.B.15 | Regímenes | mención | $i = i^* + \gamma E^e$ (+ prima de riesgo) como restricción de la política monetaria con tipo fijo | — |
| 3.A.37 | Transmisión por el tipo de cambio | mención (hecho, 5/11/2026) | I.2: $i=i^*+\gamma E^e$; si el BCE sube y la Reserva Federal no, el euro se aprecia hoy lo bastante para que se espere una depreciación que iguale los rendimientos; el tipo real, sin letra (la $q$ es la de Tobin en el mismo tema) | La PCI y los mercados a plazo |
| 3.A.32 | Mundell-Fleming | supuesto (hecho, 11/11/2026) | Expectativas estáticas: la PNCI $i=i^*+\gamma E^e$ se reduce a $i=i^*$ con movilidad perfecta, la BP horizontal (como dice el 3.B.13, l. 864), `\vertema{3.B.13}` | — |
| 3.B.17 | Crisis de BP | mención (hecho, 12/11/2026) | PNCI con previsión perfecta en Flood y Garber, $i_t=i^*+\dot E_t/E_t$; en la 2.ª generación, $i-i^*\approx\gamma E^e+\rho$ como coste de defender la paridad (Riksbank, 500 % en 1992), `\vertema{3.B.13}` | La derivación |
| 3.B.19 | Coordinación internacional | supuesto (hecho, 12/11/2026) | Supuesto de Hamada: los tipos de los 2 países difieren en la depreciación esperada, `\vertema{3.B.13}`; en Mundell-Fleming con 2 países, $i=i^*$ con $\beta_K\to\infty$ | La derivación |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: el bloque de paridades ya no repite el del 3.B.13 (resumen con remisión); $s_t$, $f_t^{t+1}$ y $E_t[s_{t+1}]$ → $E_t$, $F_t^{t+1}$, $E^e_{t+1}$ y $\mathbb E_t$; la etiqueta del margen *forward* ya no es «depreciación esperada»; PNCI con PDI como sinónimo.
- **Repetición**: el bloque de paridades está casi literal en 3.B.13 y 3.B.14 (el Word lo admite: «Es parecido en los temas 3.B.13 y 3.B.14») y la PCI vuelve en 3.B.25.
- **Notación del tipo de cambio**: $E$ en el resto de ambos temas y $s_t$, $f_t^{t+1}$ en las paridades (dentro de 3.B.13 y dentro de 3.B.14). Canon: $E_t$, $F_t^{t+1}$ en niveles, $e_t$, $f_t$ solo para logaritmos y $E^e_{t+1}$ para el tipo esperado (ver `_notacion/macro-abierta.md`).
- **Nombre**: «paridad descubierta (PDI)» en 3.B.13 y «paridad no cubierta (PNCI)» en 3.B.14. Canon: «paridad no cubierta de intereses» (PNCI), citando PDI como sinónimo.
- **Errores en 3.B.13**: (i) paso «$\ln(1+i) = \ln(1+i^*)\cdot\ln(\dots)$» (es una suma de logaritmos); (ii) en la PCI, el margen *forward* se etiqueta «tasa de depreciación esperada» (solo coinciden si además se cumple la PNCI); (iii) «el arbitraje garantiza el cumplimiento continuo de la PDI»: la PNCI es una condición de especulación y no se cumple continuamente (lo dice el propio tema en el apartado 3.3).
- En 3.B.14 el apartado «Implicaciones» repite $1+i = (1+i^*)s_{t+1}/s_t$ sin expectativa: debe ser $E^e_{t+1}$.

Autor: Víctor Gutiérrez Marcos
