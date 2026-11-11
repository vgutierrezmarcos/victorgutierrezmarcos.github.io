# Oferta y demanda de divisas (el modelo de la balanza de pagos o de flujos)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.13** (Mercados de divisas: operaciones e instrumentos), revisado el 8/11/2026: el mercado de divisas es su título y lo presenta en II.2 (`sec:op-comerciales`) con `eq:vaciado` y el gráfico de referencia, y la forma reducida de Kallianiotis en su anexo `anexo:flujos-activos`. El **3.B.14** (revisado el 11/11/2026) lo usa **como teoría del tipo de cambio** (I.1, con a)-c)). Ficha nueva del 11/11/2026 (CC6 del 3.B.14, D-4, **[decidir]**; *alternativa*: referencia el 3.B.14, que en el Word lo desarrolla como 1.1, con el gráfico del 3.B.13). Recoge el id `oferta-demanda-divisas`, que estaba en el mapa sin fichero.
- **Temas que lo usan:** 3.B.13 (desarrollo; hecho, 8/11/2026), 3.B.14 (resumen; hecho, 11/11/2026), 3.B.12 (mención), 3.B.17 (mención: tipo sombra).
- **Fuentes de referencia:** Kallianiotis (2013), *Exchange Rates and International Financial Economics*, cap. 3 (`Kallianiotis2013Exchange`); Mussa (1984) para la crítica (`Mussa1984Theory`); Krugman, Obstfeld y Melitz; Gandolfo.

## Presentación de referencia (3.B.13, II.2; 3.B.14, I.1)

**Pregunta:** ¿quién ofrece y quién demanda divisas, y qué tipo de cambio vacía el mercado?

**Supuestos:** la **demanda** de divisas la generan las importaciones y las salidas de capital (decreciente en $E$); la **oferta**, las exportaciones y las entradas de capital (creciente en $E$ **si se cumple Marshall-Lerner**, $|\varepsilon_{X,q}|+|\varepsilon_{M,q}|>1$, `\vertema{3.B.12}`; si no, el mercado puede ser inestable; el 3.B.13 lo matiza con el valor en divisa $PX/E$).

**Ecuaciones (notación canónica, $E$ directo):**
- `eq:vaciado`: $\underbrace{X+\text{entradas de capital}}_{\text{oferta}}=\underbrace{M+\text{salidas de capital}}_{\text{demanda}}\Longleftrightarrow\underbrace{X-M}_{\mathrm{CC}}=\underbrace{\text{salidas}-\text{entradas}}_{\mathrm{CF}}$ (sin variación de reservas; signos del MBP6).
- Como teoría del tipo de cambio (`eq:kallianiotis-e` del 3.B.13 = `eq:flujos-e` del 3.B.14): de $XN_t(q_t,Y_t,Y^*_t,Z_t,Z^*_t)=SK_t(i_t-i^*_t)$, $e_t=\beta_0+\beta_1(p_t-p^*_t)+\beta_2(y_t-y^*_t)+\beta_3(i_t-i^*_t)+\beta_4(z_t-z^*_t)+\varepsilon_t$, $\beta_1,\beta_2>0$, $\beta_3,\beta_4<0$; **$Z_t$, $Z^*_t$** distorsiones al comercio (nunca χ, que es la desutilidad del trabajo).
- Tipo de vaciado **$E_0$** (no $E^*$: en macro abierta el asterisco es el resto del mundo, `notacion.md` § 9); tipo fijo $\bar E$; **tipo sombra $\tilde E$**, el que vaciaría el mercado sin intervención (el tipo fijo cae si $\tilde E>\bar E$ al agotarse las reservas, `\vertema{3.B.17}`).

**Resultado:** con tipo flexible, $E_0$ equilibra la balanza de pagos, no cada cuenta; sin capitales, la cuenta corriente; con capitales móviles, déficits corrientes persistentes financiados por la cuenta financiera. Con tipo fijo infravalorado ($\bar E>E_0$), exceso de oferta de divisas que el banco central compra (gana reservas); sobrevalorado, las pierde. Como teoría: deprecia la moneda del país con más inflación, más crecimiento y menos tipo de interés. **Crítica:** trata los capitales como flujos y no como ajustes de *stocks*; no hay relación fuerte entre la cuenta corriente y el tipo de cambio (Mussa, 1984): de ahí el enfoque de activos.

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B13/graficos/oferta-demanda-divisas.tex`** (ejes $E$ y cantidad de divisas; oferta creciente, demanda decreciente, equilibrio y tipo fijo $\bar E$ con el exceso de oferta). Copia literal en **`fuentes/3B14/graficos/oferta-demanda-divisas.tex`**, con el tipo de vaciado rotulado **$E_0$** (la del 3.B.13 dice aún $E^*$: pendiente C1 del 3.B.14; tras corregirlo, las 2 copias quedan idénticas).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.13 | Mercado de divisas | desarrollo (hecho, 8/11/2026) | II.2: oferta, demanda, `eq:vaciado`, `fig:oferta-demanda-divisas`, caja de por qué las teorías del ajuste se plantean con tipo fijo; Kallianiotis y la tabla de factores en `anexo:flujos-activos`; la teoría, `\vertema{3.B.14}` | — |
| 3.B.14 | Determinación del tipo de cambio | resumen (hecho, 11/11/2026) | I.1 a)-c): Marshall-Lerner, `eq:vaciado`, `eq:flujos-e` en una línea con $Z_t$, la copia del gráfico con $E_0$, tipo sombra $\tilde E$; valoración con la crítica de los *stocks*; `\vertema{3.B.13}` | La tabla de signos y la caja del ajuste con tipo fijo (nota al pie) |
| 3.B.12 | Ajuste de la BP | mención | Su anexo 1 (equilibrio con tipo flexible) duplica: remitir al 3.B.13 (mercado) y al 3.B.14 (teoría) | El gráfico y la ecuación |
| 3.B.17 | Crisis cambiarias | mención | El tipo de cambio sombra $\tilde E$ de los modelos de primera generación, `\vertema{3.B.14}` | — |

## Divergencias encontradas en el temario actual
- **3.B.13** (revisado): rotula $E^{*}$ el tipo de vaciado (l. 453, 601, 611 y el gráfico, l. 18): $E_0$ (pendiente C1 del 3.B.14).
- **Resuelto en el 3.B.14 (11/11/2026)**: «al depreciarse, disminuye la demanda de divisas» (por las exportaciones) → **aumenta la oferta**; $\chi_t$ → $Z_t$; las 3 cajas del ajuste con tipo fijo, que repetían la del 3.B.13, a una nota.

Autor: Víctor Gutiérrez Marcos
