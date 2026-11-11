# Enfoque de cartera del tipo de cambio (Branson, 1977)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.14 (Teorías de la determinación del tipo de cambio), **revisado el 11/11/2026**: único desarrollo, con a)-e), las 3 curvas, la tabla de perturbaciones y el anexo `anexo:cartera` con las pendientes.
- **Temas que lo usan:** 3.B.14 (desarrollo; hecho, 11/11/2026), 3.A.32 (mención; hecho, 11/11/2026), 3.B.12 (resumen breve; hecho, 11/11/2026), 3.B.15 (mención).
- **Obra y año** (fijados en el 3.B.14): **Branson (1977)** (`Branson1977Asset`) y Branson, Halttunen y Masson (1977) (`BransonHalttunenMasson1977`); síntesis de referencia, **Branson y Henderson (1985)** (`BransonHenderson1985`, *Handbook of International Economics*). Precedente en la balanza de pagos: McKinnon y Oates (1966) (`McKinnonOates1966Implications`). Base: la cartera de Tobin (1958, `Tobin1958Liquidity`; 1969, `Tobin1969General`) del 3.A.35. El Word decía 1976; el Word del 3.B.12, «Branson, 1968», que es otro artículo (flujos de capital de EE. UU.). **Resuelto en el 3.B.12 (11/11/2026):** cita a McKinnon y Oates (1966) (`McKinnonOates1966`) y Branson (1968) (`Branson1968Financial`) para la cartera en la balanza de pagos, y **Branson (1977)** (`Branson1977Asset`) para el modelo del tipo de cambio, con `\vertema{3.B.14}`. Ojo: la clave del precedente es `McKinnonOates1966` en el 3.B.12 y `McKinnonOates1966Implications` en esta ficha: unificar al reconstruir (cosmético, `pendientes-coherencia.md`).
- **Manuales de referencia:** Gandolfo, *International Finance and Open-Economy Macroeconomics*, cap. 13 (`Gandolfo2002International`); Sarno y Taylor, cap. 4.

## Presentación de referencia (3.B.14, II.2)

**Pregunta:** ¿cómo se determina el tipo de cambio cuando los bonos nacionales y extranjeros no son sustitutos perfectos?

**Supuestos:** país pequeño con 3 activos en manos de los residentes: dinero $M$, bonos nacionales $B$ (rinden $i$) y bonos extranjeros $B^*$ en divisa (rinden $i^*+\gamma E^e$ en moneda nacional); **sustituibilidad imperfecta** (no se cumple la PNCI: prima de riesgo); demanda de cada activo como parte de la **riqueza**; a corto plazo, precios, renta y saldos dados y expectativas estáticas ($\gamma E^e=0$); a medio plazo, $B^*$ cambia con la cuenta corriente.

**Ecuaciones (notación canónica):**
$$W=M+B+E\,B^{*}\quad(\texttt{eq:riqueza-branson})$$
$$M=w_{\mathrm M}\big(\underset{-}{i},\underset{-}{i^{*}+\gamma E^e}\big)W,\quad B=w_{\mathrm B}\big(\underset{+}{i},\underset{-}{i^{*}+\gamma E^e}\big)W,\quad E\,B^{*}=w_{\mathrm B^*}\big(\underset{-}{i},\underset{+}{i^{*}+\gamma E^e}\big)W\quad(\texttt{eq:demandas-branson})$$
con $w_{\mathrm M}+w_{\mathrm B}+w_{\mathrm B^*}=1$ las partes de la riqueza (las $w$ de la cartera de Tobin del 3.A.35; avisado: «aquí $w$ no es el salario») y ley de Walras ($w'_{\mathrm M}+w'_{\mathrm B}+w'_{\mathrm B^*}=0$). $W$ riqueza financiera, local del modelo.
- Prima de riesgo: $i=i^*+\gamma E^e+\rho$, **ρ** creciente en la oferta relativa de activos nacionales (la misma ρ del 3.B.13).
- Medio plazo: $E\,\dot B^{*}=\mathrm{CC}=XN(q)+i^{*}E\,B^{*}$ (`eq:acumulacion-branson`); largo plazo con $\mathrm{CC}=0$: $XN(q)=-i^*EB^*$.
- Pendientes (anexo C): $\left.\frac{dE}{di}\right|_{MM}=-\frac{w'_{\mathrm M}W}{w_{\mathrm M}B^*}>0$, $\left.\frac{dE}{di}\right|_{BB}=-\frac{w'_{\mathrm B}W}{w_{\mathrm B}B^*}<0$, $\left.\frac{dE}{di}\right|_{B^*B^*}=\frac{w'_{\mathrm B^*}W}{(1-w_{\mathrm B^*})B^*}<0$.

**Resultado:** el tipo de cambio y el tipo de interés vacían los mercados de activos a corto plazo; la acumulación de $B^*$ vía cuenta corriente mueve $E$ a medio plazo (sobrerreacción sin rigidez de precios); la **intervención esterilizada funciona** (canal de cartera); la compra de bonos extranjeros deprecia más que la de nacionales.

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B14/graficos/branson.tex`**: plano **$(i,E)$ con $i$ en abscisas y $E$ en ordenadas** (el mismo que el panel de la PNCI de `dornbusch-mercados`), curvas **$MM$** (creciente), **$BB$** (decreciente) y **$B^*B^*$** (decreciente y menos inclinada que $BB$; nunca $FF$, que choca con el tipo a plazo); punto $A$ (equilibrio), $B$ (compra de bonos nacionales: $MM$ y $BB$ a la izquierda) y $C$ (compra de bonos extranjeros: $MM$ a la izquierda y $B^*B^*$ arriba). Regla para mover las curvas: $MM$ y $BB$ a izquierda o derecha (a cada $E$, ¿qué $i$?); $B^*B^*$ arriba o abajo (a cada $i$, ¿qué $E$?). En el cante bastan $MM$ y $B^*B^*$ (Walras). Tabla de referencia `tab:branson` con 6 perturbaciones (más dinero, compra de $B$, compra de $B^*$, intervención esterilizada, déficit con deuda —$E$ ambiguo—, superávit corriente —aprecia—).

**Evidencia (3.B.14):** algo de apoyo a la cuenta corriente (Branson, Halttunen y Masson, 1977); la prima de riesgo no aparece (Frankel, 1982, `Frankel1982Search`); canal de cartera en la intervención (Dominguez y Frankel, 1993; Blanchard, Adler y Carvalho, 2015); microfundamentos en Gabaix y Maggiori (2015).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.14 | Determinación del tipo de cambio | desarrollo (hecho, 11/11/2026) | II.2 con a)-e), `eq:riqueza-branson`, `eq:demandas-branson`, `eq:acumulacion-branson`, `branson.tex`, `tab:branson`; pendientes en el anexo C | — |
| 3.A.32 | OA-DA abierta | mención (hecho, 11/11/2026) | l. 185: fondos frente a flujos, `\vertema{3.B.14}` (y `\vertema{3.B.12}` para el enfoque monetario de la BP: pendiente C3 del 3.B.14) | El modelo |
| 3.B.12 | Ajuste de la BP | resumen breve (hecho, 11/11/2026) | II.3 como subapartado propio (estructura del Word) sin ecuaciones salvo $W=M+B+EB^*$ en los supuestos: Idea (McKinnon y Oates, 1966; Branson, 1968 y 1977; *home bias*), mecanismo de palabra (una expansión monetaria recompone la cartera y sale capital), 2 implicaciones (ajuste automático pero parcial y más lento; algo de autonomía monetaria), 3 críticas (riqueza exógena —el modelo de Branson del tipo de cambio sí une *stocks* y cuenta corriente, `\vertema{3.B.14}`—, mercados eficientes, estático); fila «Cartera» de `tab:mecanismos-ajuste`; en el cante, 1′ de palabra | Las demandas $w(\cdot)W$, las 3 curvas y la tabla de perturbaciones |
| 3.B.15 | Intervención en los mercados de cambio | mención | Por qué la intervención esterilizada puede funcionar (canal de cartera) `\vertema{3.B.14}` | Las curvas |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: pesos $w_{\mathrm M}$, $w_{\mathrm B}$, $w_{\mathrm B^*}$ en lugar de $m(\cdot)$, $b(\cdot)$, $f(\cdot)$ de la ficha anterior (chocaban con $m$ propensión a importar y dinero en logaritmos, y con $f$ tipo a plazo en logaritmos) (CC2, D-3, **[decidir]**; *alternativa*: $m$, $b$, $f$); curva $B^*B^*$ (no $FF$); plano $(i,E)$ con $i$ en abscisas (el Word dibujaba $(E,i)$ con el aviso «ejes al revés que en Dornbusch»); «cuenta comercial» → cuenta corriente; «inspiración friedmaniana» → la cartera de Tobin; la lámina escaneada de 4 casos (otro autor) → `tab:branson`.
- El mapa daba al 3.B.12 «resumen» y la ficha «mención»: **fijado en la fase canon del 3.B.12 (11/11/2026): «resumen breve»** en los 2 (el 3.B.12 mantiene el II.3 del Word como subapartado, sin las funciones de demanda; K18 de su coherencia).

Autor: Víctor Gutiérrez Marcos
