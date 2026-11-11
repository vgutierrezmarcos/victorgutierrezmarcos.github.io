# Enfoque de la absorción (Alexander, 1952)

- **Área:** macro-abierta · **Tema de referencia:** **3.B.12** (Mecanismos de ajuste de la balanza de pagos), **revisado el 11/11/2026**: lo desarrolla en I.3 (`sec:absorcion`) con a)-c), la función clave `eq:absorcion`, `eq:absorcion-devaluacion` y un gráfico propio. Es el único tema que lo trata como modelo; los demás usan la identidad $Y-A$ o las políticas de Johnson. Ficha nueva de la fase canon del 3.B.12 (11/11/2026; C1 de sus propuestas de coherencia, D2, **[decidir]**; *alternativa*: sin ficha, con la identidad en `identidad-balanza-pagos` y las políticas en `policy-mix`). Recoge el id `absorcion`, que estaba en el mapa sin fichero.
- **Temas que lo usan:** 3.B.12 (desarrollo; hecho, 11/11/2026), 3.B.11 (mención; hecho, 5/11/2026: III.1, $A=C+I+G$ y la lectura renta menos absorción de `eq:cc-ahorro-inversion`; `fig:cuentas-nacionales-bp`, de la absorción a la RNDB), 1D01 (uso; aprobada: la lectura $(Y-A)$ de la identidad, l. 1131, «exceso de absorción», y las políticas reductoras y desviadoras del gasto con `Johnson1958`, l. 1352), 3.A.5 (mención; hecho, 3/11/2026: l. 680 y `tab` de l. 777, la síntesis trata la balanza con «elasticidades y absorción»), 3.B.22 (mención: la absorción y el enfoque monetario como base de la programación financiera de Polak, 1957), 3.A.32 (mención: la DA abierta con $\overline A$).
- **Fuentes de referencia** (fijadas en el 3.B.12): **Alexander (1952)** (`Alexander1952Effects`, *IMF Staff Papers*); **Johnson (1958)** (`Johnson1958`, políticas que reducen y que desvían el gasto); Gandolfo, *International Finance and Open-Economy Macroeconomics*, cap. 9 (`Gandolfo2016International`; capítulo por comprobar, duda 6 del 3.B.12). La síntesis con las elasticidades (Tsiang, 1961) no está comprobada: no se cita.

## Presentación de referencia (3.B.12, I.3)

**Pregunta:** ¿qué tiene que pasar con el gasto para que una devaluación mejore el saldo exterior, sobre todo con pleno empleo?

**Idea:** el multiplicador supone recursos ociosos; Alexander escribe en la «edad dorada», con pleno empleo: la mayor demanda de exportaciones sube los precios y aprecia el tipo real, de modo que la devaluación solo funciona si mueve otras variables.

**Supuestos:** los del multiplicador, pero con pleno empleo posible: **precios rígidos con paro y flexibles en el pleno empleo** (oferta agregada en L invertida, con el tramo vertical en $Y_F$).

**Ecuaciones (notación canónica):**
- $A\equiv C+I+G$ la absorción (gasto interior, también el que va a importaciones; § 9), $Y=A+\mathrm{XN}$; **función clave** `eq:absorcion`:
$$\mathrm{XN}=Y-A$$
En palabras: el saldo mejora solo si la renta sube más que la absorción; es la identidad $\mathrm{CC}=S-I$ leída como teoría (`\vertema{3.B.11}`).
- Con $A=\overline A-b\,i+(c+z)\,Y$ ($\overline A\equiv\overline C+\overline I+\overline G$ como el 3.A.32; $c+z$ **propensión marginal a absorber, sin letra**; $z$ propensión marginal a invertir, local del 3.B.12; $b$ la de la IS), una devaluación cambia el saldo en (`eq:absorcion-devaluacion`):
$$\mathrm d\,\mathrm{XN}=\underbrace{[1-(c+z)]\,\mathrm dY}_{\text{efecto renta}}-\underbrace{\mathrm d(\overline A-b\,i)}_{\text{efecto directo sobre la absorción}}$$
- **Efecto renta**: con paro, sube la producción y mejora el saldo en la parte no absorbida (poco si $c+z\approx1$); con pleno empleo, nulo (salvo un tipo desalineado o una mejora de la relación real de intercambio).
- **Efecto directo sobre la absorción** (con pleno empleo la devaluación sube los precios): **efecto saldos reales (Pigou-Patinkin)**, **efecto Keynes** (los nombres del 3.A.5, `\vertema{3.A.5}`), redistribución hacia el sector público (la progresividad en frío **sube** la presión fiscal), redistribución de salarios a beneficios, ilusión monetaria.

**Implicaciones:** el ajuste depende de si hay pleno empleo; **una devaluación sola puede no bastar**: con pleno empleo hay que acompañarla de políticas que **reduzcan el gasto** (fiscal y monetaria contractivas) mientras la devaluación lo **desvía** hacia lo nacional (Johnson, 1958); es la base de los programas del FMI (`\vertema{3.B.22}`). Ejemplo: España 2008-2013, ajuste por las 2 vías sin tipo de cambio (absorción hundida y devaluación interna, `\vertema{3.B.16}`).

**Valoración:** el debate absorción-elasticidades de los 50 acabó en una síntesis pobre; lo nuevo (que nadie vio entonces) es que los determinantes de la absorción, el ahorro y la inversión, deciden el saldo: la intuición del enfoque intertemporal (ficha `cuenta-corriente-intertemporal`). No mira la financiación del saldo.

**Gráfico de referencia:** **`oposicion/temario/fuentes/3B12/graficos/absorcion-oa.tex`** (`fig:absorcion-oa`): plano $(Y,P)$, OA en L invertida (horizontal en $P=2$ hasta $Y_F$, vertical en $Y_F$), DA, DA′ y DA″; con paro la devaluación sube la renta sin subir los precios (de $A$ a $B$); en el pleno empleo, más demanda solo sube los precios (de $B$ a $C$). Mismos estilos y colores que `fuentes/3A32/graficos/da-oa-abierta.tex` (DA morada, OA azul, lo desplazado en rojo discontinuo).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.12 | Mecanismos de ajuste de la BP | desarrollo (hecho, 11/11/2026) | I.3 a)-c) con `eq:absorcion`, `eq:absorcion-devaluacion`, `absorcion-oa.tex`, los mecanismos de Alexander, las políticas de Johnson y España; fila de `tab:mecanismos-ajuste` | — |
| 3.B.11 | Balanza de pagos | mención (hecho, 5/11/2026) | La lectura renta menos absorción de `eq:cc-ahorro-inversion`, $A=C+I+G$ | El modelo y los efectos de una devaluación |
| 1D01 | Dictamen de coyuntura | uso (aprobada) | $(Y-A)$ en la identidad; «exceso de absorción»; políticas reductoras y desviadoras del gasto (Johnson, 1958) como guía del ajuste | El modelo |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | La síntesis trata la balanza con elasticidades y absorción; el monetarismo, con el enfoque monetario | — |
| 3.B.22 | El FMI | mención | Absorción (Alexander, 1952) y enfoque monetario (Johnson, 1972) como base de la programación financiera, `\vertema{3.B.12}` | La derivación |
| 3.A.32 | OA-DA abierta | mención | La DA abierta con $\overline A$ y la misma geometría de OA (su `da-oa-abierta.tex` es la base del gráfico) | — |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.12 (11/11/2026):** «Enfoque absorción» → «El enfoque de la absorción» (`notacion.md` § 14); «efecto indirecto» y «efecto directo» mezclados → efecto renta y efecto directo sobre la absorción; la progresividad en frío «baja» la presión fiscal → la sube; gráfico de la OA en L como imagen → TikZ propio.
- La letra $z$ (propensión marginal a invertir) es local del 3.B.12 (en otros temas $z$ es el valor del desempleo del DMP o una variable genérica): avisada allí.

Autor: Víctor Gutiérrez Marcos
