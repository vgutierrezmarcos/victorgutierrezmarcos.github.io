# Modelo IS-LM-BP (Mundell-Fleming)

- **Área:** macro-abierta · **Tema de referencia:** **3.A.32** (OA-DA en economía abierta: renta, inflación, políticas monetaria y fiscal; sin fuente): es su sitio natural en el temario de 2023 (hereda el antiguo 3.A.28, como recuerda la nota de 3.B.12) y es donde se analizan las políticas en economía abierta con carácter general. Se escribe a partir de 3.B.15, hoy el desarrollo más completo (ecuaciones, tres casos de $\beta$, políticas con tipo fijo y flexible), que pasa a resumen.
- **Temas que lo usan:** 3.A.32 (desarrollo, sin fuente), 3.B.15 (desarrollo → resumen), 3.B.19 (desarrollo → variante de dos países), 3.A.37 (desarrollo → resumen), 3.A.38 (resumen → mención), 3.B.14 (borrador → mención), 4.B.4 (resumen)
- **Manuales de referencia:** Mundell (1963), Fleming (1962); Krugman, Obstfeld y Melitz, cap. 17 (modelo $DD$-$AA$, equivalente); Blanchard, *Macroeconomía*, caps. 19-20; Gandolfo, *International Finance…*, caps. 10-11; Dornbusch, Fischer y Startz, *Macroeconomía*, cap. 12.
- **Decisión D014 (13/10/2026):** ¿Cuál es el tema de referencia de Mundell-Fleming (IS-LM-BP)? 3.A.32 (OA-DA en economía abierta), escribiéndolo a partir de 3.B.15, que pasa a resumen
- **Decisión D016 (13/10/2026):** ¿Se reserva φ para la productividad de Melitz (y la inversa de Frisch en macro) y se cambian sus otros usos en comercio y macro abierta? Sí: función de reacción R_A(q_B), coeficiente técnico de la protección efectiva a_ij, sensibilidad del saldo comercial al tipo real ν

## Presentación de referencia
**Pregunta:** ¿qué eficacia tienen las políticas fiscal y monetaria según el régimen cambiario y la movilidad del capital?

**Supuestos:** precios fijos ($P = P^* = 1$, luego $i = r$ y $q = E$), expectativas estáticas ($\gamma E^e = 0$), condición de Marshall-Lerner, país pequeño (salvo en la versión de dos países), movilidad del capital $\beta \in [0, \infty]$.

**Ecuaciones (notación canónica):**
$$IS:\; Y = \frac{\bar C + \bar I - b\,i + \bar G + x Y^* + \nu q}{1 - c(1-t) + m}$$
$$LM:\; \frac{M^S}{P} = kY - h\,i$$
$$BP:\; \underbrace{xY^* - mY + \nu q}_{\text{balanza comercial}} + \beta\,(i - i^*) = 0 \;\;\Rightarrow\;\; \left.\frac{\partial i}{\partial Y}\right|_{BP} = \frac{m}{\beta}$$
($\nu$ = sensibilidad del saldo comercial al tipo real; antes $\phi$/$\varphi$). Casos: $\beta = 0$ movilidad **nula** (BP vertical); $0<\beta<\infty$ imperfecta (BP creciente); $\beta \to \infty$ movilidad **perfecta** (BP horizontal en $i = i^*$).

**Resultado:** con movilidad perfecta, la política monetaria es ineficaz con tipo fijo y máxima con flexible; la fiscal, al revés.

**Gráfico de referencia:** plano $(Y, i)$ con IS, LM y BP en los tres casos de $\beta$; cuadro de doble entrada régimen × movilidad con la eficacia de cada política. Sin `.tex` aún.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.32 | OA-DA en economía abierta | desarrollo (si se elige) | Modelo completo, tres casos de $\beta$, políticas con tipo fijo y flexible y derivación de la DA abierta | — |
| 3.B.15 | Comparación de regímenes | resumen | Solo el cuadro régimen × movilidad y el trilema; Poole abierto; remitir | La derivación de IS, LM y BP |
| 3.B.19 | Coordinación internacional | desarrollo de la variante | **Dos países** A y B con $Y^*$ endógeno: efectos desbordamiento (locomotora, *beggar-thy-neighbour*) y juego de políticas | La versión de país pequeño |
| 3.A.37 | Nueva economía keynesiana | resumen | Solo como punto de partida antes de Corsetti-Pesenti | Las ecuaciones |
| 3.A.38 | Políticas / síntesis | mención | Referencia | — |
| 3.B.14 | Determinación del tipo de cambio | mención | Como teoría de flujos del tipo de cambio en dos líneas; **eliminar el borrador marcado** | El apartado IS-LM-BP sin terminar |
| 4.B.4 | Política fiscal | resumen | Solo la eficacia de la política fiscal según régimen y movilidad (cuadro) | Derivación |

## Divergencias encontradas en el temario actual
- **Copia literal** en 3.B.15 y 3.B.19 (mismas ecuaciones, gráficos y texto), y borrador sin terminar en 3.B.14 con notas del autor («Modelo comodín…»).
- **Error en 3.B.15 (y copiado en 3.B.19)**: «Si existe movilidad perfecta de capital, $\beta = 0$, la curva BP será totalmente vertical»: es movilidad **nula**.
- 3.B.15: el supuesto 5 fija movilidad perfecta pero luego se analizan los tres casos de $\beta$; separar «supuesto» de «casos».
- Notación: $\phi$ (o $\varphi$) para la sensibilidad de XN a $\varkappa$ choca con $\varphi$ productividad de Melitz (3.B.6) y con $\varphi$ de otros temas de comercio; 3.B.14 escribe $Y = A(r) + BC(Y,Y^*,E)$ con $r$, frente a $i$ en el resto; 3.B.12 escribe la IS con $r$, inversión inducida $zY$ y sin impuestos. Canon: la forma de arriba.
- $Y^*$ es renta extranjera aquí y PIB objetivo del Gobierno en 3.B.17: ver `_notacion/macro-abierta.md`.

Autor: Víctor Gutiérrez Marcos
