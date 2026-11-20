# Estructura temporal de los tipos de interés: tipos de contado y a plazo; expectativas, prima por liquidez, segmentación y hábitat preferente

- **Área:** finanzas-empresa (comparte con macro cerrada) · **Tema de referencia:** **3.B.24** (lo tiene en el título; revisado el 13/11/2026, II.1-II.3) — da la derivación de `eq:tipo-largo` que usan el 3.A.37 y el 3.A.40. Ficha creada en la pasada final (noviembre de 2026) con el borrador KC1 del 3.B.24.
- **Temas que lo usan:** 3.B.24 (desarrollo; hecho, 13/11/2026), 3.A.37 (resumen; hecho, 5/11/2026: `eq:tipo-largo` como función clave, hábitat preferente con Vayanos y Vila, 2021), 3.A.40 (resumen; hecho, 5/11/2026: `eq:tipo-largo`), 3.A.36 (mención; hecho, 4/11/2026: control de la curva y operación *Twist*), 3.B.25 (mención; hecho, 8/11/2026: la ETTI detrás de los FRA y los *swaps*; la misma pregunta que la *normal backwardation*), 3.B.13 (mención; hecho, 8/11/2026: la paradoja del *forward*), 3.A.42 (mención; hecho, 4/11/2026: la pendiente como indicador adelantado; Estrella y Mishkin, 1998), 1D01 (uso; hecho, 24/10/2026: pendiente y formas de la curva).
- **Manuales de referencia:** Hicks (1939); Lutz (1940); Culbertson (1957); Modigliani y Sutch (1966); Kessel (1965); Vayanos y Vila (2021); Campbell y Shiller (1991); Fama y Bliss (1987); Adrian, Crump y Moench (2013); Nelson y Siegel (1987); Svensson (1994); Mishkin, Matthews y Giuliodori, cap. 6.

## Presentación de referencia (3.B.24, II)
**Pregunta:** ¿por qué los tipos de interés dependen del plazo?

**Tipos de contado y a plazo (`eq:forward`):** $(1+r_t)^t=(1+r_{t-1})^{t-1}(1+f_t)$, con $f_t$ el tipo a plazo implícito hoy para el periodo de $t-1$ a $t$; *bootstrapping*; Nelson-Siegel-Svensson (nivel, pendiente, curvatura) en caja gris (`eq:svensson`, con $\beta_0,\beta_1,\beta_2,\tau$ locales que no son la beta del CAPM).

**Teorías:** con a)-e) solo la de las **expectativas** (`eq:expectativas-exacta` y, en logaritmos, la función clave **`eq:tipo-largo`** $i^{(n)}_t=\frac1n\sum_{k=0}^{n-1}\mathbb{E}_t[i_{t+k}]+\text{prima por plazo}_t$, con la forma, la etiqueta y la prima sin letra comunes al 3.A.37 y el 3.A.40); las demás, como un valor de la prima: nula (expectativas puras), positiva y creciente (**teoría de la prima por liquidez**, Hicks, 1939; Kessel, 1965), de cualquier signo según la oferta por plazos (segmentación, Culbertson, 1957; **hábitat preferente**, Modigliani y Sutch, 1966; Vayanos y Vila, 2021). Formas y movimientos de la curva (paralelo, *twist*, *butterfly* = nivel, pendiente, curvatura); predictor del ciclo; *Twist*, compras de activos y control de la curva (ficha `limite-inferior-tipos`).

**Notación:** $r_t$ contado, $f_t$ a plazo; $i_t$ tipo a un periodo, $i^{(n)}_t$ a $n$ periodos en $t$; **$r_n\equiv i^{(n)}_0$** como puente entre las finanzas y § 8.

**Terminología:** «estructura temporal de los tipos de interés (ETTI)» o «curva de tipos»; «tipo de contado» (*spot*) y «tipo a plazo» (*forward*); «prima por plazo» para el sumando y «teoría de la prima por liquidez» para la de Hicks (no es la preferencia por la liquidez de Keynes); «hábitat preferente», nunca «preferido».

**Gráficos de referencia** (`oposicion/temario/fuentes/3B24/graficos/`): `estrategias-expectativas.tex` (las 2 líneas temporales), `prima-liquidez.tex`, `formas-curva.tex`, `movimientos-curva.tex`; de datos, `curvas-espana-eeuu.tex`, `curva-bce-zona-euro.tex`, `nss-factores.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.24 | Estructura temporal de los tipos | desarrollo (hecho, 13/11/2026) | Todo lo anterior | — |
| 3.A.37 | Transmisión de la política monetaria | resumen (hecho, 5/11/2026) | `eq:tipo-largo` como función clave; hábitat preferente con Vayanos y Vila | Los tipos a plazo, Nelson-Siegel |
| 3.A.40 | Política monetaria y fiscal | resumen (hecho, 5/11/2026) | `eq:tipo-largo` | — |
| 3.A.36 | Instrumentos del BCE | mención (hecho, 4/11/2026) | Control de la curva, *Twist* | — |
| 3.B.25 | Derivados | mención (hecho, 8/11/2026) | La ETTI detrás de FRA y *swaps* | — |
| 3.B.13 | Mercado de divisas | mención (hecho, 8/11/2026) | La paradoja del *forward*, la misma pregunta | — |
| 3.A.42, 1D01 | Ciclo; dictamen | mención; uso (hechos) | La pendiente como indicador adelantado | — |

## Divergencias encontradas en el temario actual
- La 1D01 (aprobada) dice «prima de liquidez»: compatible, sin pendiente.
- 3.B.24 (original): «hábitat preferido», «Hicks, 1946», «Culberston»; el 3.B.24 (Word) y el 3.B.25 databan a Hicks en los años 40. **Resuelto** (13/11/2026): Hicks (1939).

Autor: Víctor Gutiérrez Marcos
