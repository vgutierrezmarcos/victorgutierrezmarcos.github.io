# Crisis de segunda generación: expectativas autocumplidas (Obstfeld, 1986, 1994, 1996)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.17** (Teorías explicativas de las crisis de balanza de pagos), **revisado el 12/11/2026**: lo desarrolla en I.2 (`sec:segunda`, «Segunda generación: crisis autocumplidas (Obstfeld, 1994, 1996)») con a)-e), la función clave `eq:escape`, el gráfico de las 3 regiones, el juego de 2 especuladores (`tab:juego-ataque`) y la derivación en el anexo A. Ficha nueva de la fase canon del 3.B.17 (12/11/2026; C3 de sus propuestas, **[decidir]**). El id estaba en el mapa sin fichero.
- **Atribución (fijada en el 3.B.17, duda 12):** el modelo es la **cláusula de escape de la sección 3 de Obstfeld (1996)**, que lleva a la economía abierta el de Barro y Gordon (Obstfeld, 1994); la presentación determinista sigue la síntesis de **Jeanne (2000)**. Nota al pie: «algunos exámenes lo llaman modelo de Jeanne y Obstfeld». Calvo (1988) es la deuda con equilibrios múltiples y Calvo (1998) las paradas súbitas: **no van en el título**.
- **Temas que lo usan:** 3.B.17 (desarrollo; hecho, 12/11/2026), 3.A.14 (mención; hecho, 19/10/2026: el ataque como juego de coordinación con varios equilibrios, III.1), 3.B.11 (mención; hecho, 5/11/2026: equilibrios múltiples, `Obstfeld1996`), 3.B.16 (mención; hecho, 11/11/2026: credibilidad del tipo fijo y SME 1992, paso entre equilibrios por las expectativas, II.4.2 c y III.2.1), 3.B.13 (mención; revisado el 8/11/2026, canon pendiente: Soros y la PNCI con prima como coste de defender), 3.B.15 (mención; hecho, 12/11/2026: I.2.3, el Gobierno abandona la paridad cuando defenderla cuesta más que soltarla, y basta con que el mercado lo crea; Krugman (1991) no explica el abandono de la banda, «terreno de las crisis de segunda generación», `\vertema{3.B.17}`; sin la etiqueta «crisis autocumplidas»), 3.B.43 (uso: SME 1992-1993), 3.B.21 (uso: SME 1992-1993 como «crisis de segunda generación»).
- **Fuentes de referencia** (fijadas en el 3.B.17): Obstfeld (1986, *AER*, `Obstfeld1986`); Obstfeld (1994, `Obstfeld1994Logic`); **Obstfeld (1996, *EER* 40, `Obstfeld1996`)**; Jeanne (2000, `Jeanne2000Currency`); Morris y Shin (1998, *AER*, `MorrisShin1998`); Jeanne (1997, `Jeanne1997Test`; franco francés); Eichengreen y Wyplosz (1993, `EichengreenWyplosz1993Unstable`); Bank of England (1992, `BoE1992Operation`); Riksbank (`Riksbank2026Ranta500`); Sarno y Taylor, *The Economics of Exchange Rates*, cap. 8.

## Presentación de referencia (3.B.17, I.2)

**Pregunta:** ¿por qué se ataca una paridad con fundamentos sanos, y por qué el ataque puede triunfar?

**Idea:** el gobierno puede defender la paridad, pero no quiere si le cuesta mucho; si el mercado espera la devaluación, defenderla cuesta más y la devaluación se cumple sola. Pegatina: «la fe mueve montañas».

**Supuestos:** el gobierno optimiza con una pérdida de 2 costes y un **coste fijo $\bar c>0$** si abandona la paridad (`eq:perdida-segunda`):
$$L=\bigl(Y^{\mathrm{obj}}-Y\bigr)^2+\gamma\,\pi^2\;\bigl(+\,\bar c\ \text{si devalúa}\bigr),\qquad\gamma>0$$
con **$Y^{\mathrm{obj}}$** la producción que quiere el gobierno (nunca $Y^*$, que es la renta exterior) y **γ el peso de la inflación** (como en `barro-gordon`; α queda para la participación del capital de Krugman, 1999, en el mismo tema); oferta de Lucas con pendiente 1 y **perturbación de oferta $u$**, $Y=Y^n+(\pi-\pi^e)+u$ (ficha `lucas-islas`, `\vertema{3.A.6}`); **$\Delta\equiv Y^{\mathrm{obj}}-Y^n>0$** (como el Δ del sesgo inflacionista, `\vertema{3.A.36}`); PPA relativa con inflación exterior nula, $\Delta E/E=\pi$ (escrito así y no $\gamma_E=\pi$, para no juntar 2 γ; `\vertema{3.B.14}`); orden de jugadas: el público fija $\pi^e$, se conoce $u$ y el gobierno decide.

**Ecuaciones (notación canónica):** con el **fundamento $x\equiv\Delta-u$** (cuanto mayor, peor) y $X\equiv x+\pi^e$, $Y^{\mathrm{obj}}-Y=X-\pi$ y (`eq:perdidas-segunda`)
$$L^{\mathrm{fijo}}=X^2,\qquad\pi^{\mathrm{flex}}=\frac{X}{1+\gamma},\qquad L^{\mathrm{flex}}=\frac{\gamma}{1+\gamma}X^2+\bar c$$
**Cláusula de escape**, función clave `eq:escape`:
$$L^{\mathrm{fijo}}-L^{\mathrm{flex}}=\frac{(x+\pi^e)^2}{1+\gamma}>\bar c$$
Con expectativas racionales, $\pi^e=0$ o $\pi^e=\pi^{\mathrm{flex}}$, que da $\pi^e=x/\gamma$; **3 regiones**: **cielo** $x<x_1\equiv\gamma\sqrt{\bar c/(1+\gamma)}$ (la paridad aguanta aunque se espere la devaluación), **purgatorio** $x_1\le x\le x_2$ (equilibrios múltiples: cae si y solo si se espera), **infierno** $x>x_2\equiv\sqrt{(1+\gamma)\bar c}$ (cae aunque nadie lo espere). En el equilibrio con devaluación, $\pi=x/\gamma$: el sesgo inflacionista de la discreción con perturbación de oferta.

**Implicaciones:** empeoran la paridad $\uparrow\Delta$, $\downarrow u$, $\downarrow\gamma$, $\downarrow\bar c$; las crisis son **evitables e impredecibles** (una «mancha solar» basta en el purgatorio); **defender cuesta más cuanto más se espera la devaluación**: $i-i^*\approx\gamma E^e+\rho$ (ficha `paridad-intereses`, `\vertema{3.B.13}`; con el aviso «$\gamma E^e$ es la depreciación esperada, no el peso γ»); Riksbank al 500 % el 16/9/1992 y corona flotante el 19/11/1992; es la **inconsistencia temporal aplicada a la paridad** (Kydland y Prescott, 1977; Barro y Gordon, 1983; `\vertema{3.A.36}`, ficha `barro-gordon`); la devaluación no tiene por qué ser una catástrofe (Reino Unido tras 1992).

**Extensiones:** juego de 2 especuladores (Obstfeld, 1996, sección 2): 6 unidades cada uno, coste de vender 1, devaluación del 50 %; reservas altas (20), nadie ataca; bajas (6), atacar es dominante; intermedias (10), 2 equilibrios de Nash (`tab:juego-ataque`, 3 matrices, `\vertema{3.A.14}`; ficha `equilibrio-nash`): «el cielo, el infierno y el purgatorio en pequeño»; juegos globales (Morris y Shin, 1998: umbral único); Obstfeld (1986); la misma lógica en la deuda pública (Calvo, 1988; `\vertema{3.B.16}`, `\vertema{3.A.39}`).

**Evidencia:** SME 1992-1993 (16/9/1992, la libra sale del mecanismo de cambios, `BoE1992Operation`; la lira; la peseta devaluada varias veces; `\vertema{3.B.16}`, `\vertema{3.B.43}`); Soros **sin cifra** (no hay fuente primaria de los «10.000 millones»); Jeanne (1997) con el franco francés; México 1994, **crisis mixta** (ficha `paradas-subitas`).

**Valoración:** predice poco; la pérdida es *ad hoc* y las expectativas, dadas; olvida los balances; no explica Asia 1997 (ficha `krugman-hojas-balance`).

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B17/graficos/segunda-generacion-regiones.tex`** (`fig:segunda-generacion`): beneficio neto de devaluar frente al fundamento $x$; parábola baja ($\pi^e=0$), $x^2/(1+\gamma)$, y alta ($\pi^e=x/\gamma$), $x^2(1+\gamma)/\gamma^2$; horizontal en $\bar c$; cortes $x_1$ y $x_2$; 3 bandas rotuladas cielo, purgatorio e infierno. Imprescindible en el cante del 3.B.17.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.17 | Crisis de BP | desarrollo (hecho, 12/11/2026) | I.2 a)-e) con `eq:perdida-segunda`, `eq:perdidas-segunda`, `eq:escape`, el gráfico de las 3 regiones, `tab:juego-ataque` y el anexo A | — |
| 3.A.14 | Teoría de juegos | mención (hecho, 19/10/2026) | El ataque como juego de coordinación con varios equilibrios | La pérdida |
| 3.B.16 | Integración monetaria | mención (hecho, 11/11/2026) | La paridad solo es creíble mientras defenderla cuesta poco; SME 1992 con las mismas fechas y fuentes | El modelo |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | Equilibrios múltiples (`Obstfeld1996`) como razón para el margen de seguridad | — |
| 3.B.13 | Mercado de divisas | mención (revisado, canon pendiente) | Soros sin cifra; la PNCI con prima como coste de defender | — |
| 3.B.15 | Regímenes | mención (hecho, 12/11/2026) | I.2.3, una viñeta (abandonar cuando defender cuesta más; expectativas que lo provocan) y II.1.3 e) (el abandono de una banda); `\vertema{3.B.17}`; la libra y la peseta en 1992-1993 con `BoE1992Operation` y `EichengreenWyplosz1993Unstable`. Falta la etiqueta «crisis autocumplidas» (cosmético) | — |
| 3.B.21, 3.B.43 | Historia; SME | uso | 1992-1993 como ejemplo, con las fechas del 3.B.16 y el 3.B.17 | El modelo |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.17 (12/11/2026):** $Y^*$ objetivo → $Y^{\mathrm{obj}}$ (D038); $Y_{TNP}$ → $Y^n$; $K$ brecha → Δ (K es el capital); α peso de la inflación → γ (α es la participación del capital en el mismo tema); $z$ → $u$; $C(\phi)$ → $\bar c$ (C es el consumo de Krugman, 1999); $\pi^*$ con flexible → $\pi^{\mathrm{flex}}$ (π* es la inflación exterior); simplificación $(\alpha+\alpha^2)/(1+\alpha)^2$ → $\gamma/(1+\gamma)$; «$Y^*-Y$» frente a «$Y-Y^*$»; π^e > 0 «sin valor» en el cielo; título con «Calvo y Jeanne»; Kydland-Prescott y Barro-Gordon «[ver tema 3.A.6]» → `\vertema{3.A.36}`; reunificación «a finales de los 80» → 1990; Soros con cifra → sin cifra.
- **3.B.19 (en revisión):** llama «modelos de coordinación de segunda generación» a los NOEM (`3B19.tex` l. 319): choque de vocabulario con esta ficha (`pendientes-coherencia.md`, «Pendiente del 3.B.17»).

Autor: Víctor Gutiérrez Marcos
