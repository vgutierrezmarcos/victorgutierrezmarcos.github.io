# Ventaja absoluta (Smith) y comparativa (Ricardo-Torrens)

- **Área:** comercio · **Tema de referencia:** 3.B.5 (Teoría del comercio internacional (I): teoría ricardiana) — lo tiene en el título.
- **Temas que lo usan:** 3.B.5 (desarrollo; hecho, 10/11/2026: I.1 `sec:smith` con `tab:ventaja-absoluta`, I.2 `sec:ricardo` con `tab:pano-vino`, `eq:ventaja-comparativa` y `fig:ricardo-fpp`; DFS y Eaton-Kortum en I.2 y en el anexo `anexo:ricardo-extensiones`; la RRI del ejemplo en `anexo:ricardo-rri`), 3.A.2 (resumen; hecho, 4/11/2026: II.3.4 `sec:ricardo-comercio` con `tab:pano-vino` y `eq:ventaja-comparativa` en el cuerpo, sin gráficos; el desarrollo del Word, en clave de historia del pensamiento, en el anexo C `anexo:ricardo-comercio`, sin las 3 FPP; la ventaja absoluta de Smith en II.1.6; la demanda recíproca de Mill en II.5.4, que recoge el id `mill-demanda-reciproca`, alias), 3.B.34 (mención), 3.B.39 (mención), 3.B.41 (mención)
- **Manuales de referencia:** Ricardo, *Principles* (1817), cap. 7; Krugman, Obstfeld y Melitz, cap. 3; Feenstra, *Advanced International Trade*, cap. 1; Dornbusch, Fischer y Samuelson (1977) para el continuo de bienes.

## Presentación de referencia
**Pregunta:** ¿por qué comercian los países con tecnologías distintas y quién gana?

**Supuestos:** 2 países (A y B), 2 bienes ($X$, $Y$), un factor (trabajo) inmóvil entre países, coeficientes técnicos constantes, competencia perfecta, pleno empleo.

**Ecuaciones (notación canónica):** $a_{X}^{A}$, $a_{Y}^{A}$ = horas de trabajo por unidad en A (ídem B).
$$\text{A tiene ventaja comparativa en } X \iff \frac{a_X^A}{a_Y^A} < \frac{a_X^B}{a_Y^B}, \qquad \frac{a_X^A}{a_Y^A} \le RRI = \frac{p_X}{p_Y} \le \frac{a_X^B}{a_Y^B}$$
Ejemplo de Ricardo (Inglaterra-Portugal; paño 100/90, vino 120/80).

**Resultado:** el comercio es beneficioso aunque un país sea más productivo en todo; la RRI queda entre los precios de autarquía y la determina la demanda (Mill).

**Ventaja absoluta (Smith) como paso previo** (3.B.5, `tab:ventaja-absoluta`): paño 100/110, vino 120/80 (Inglaterra más productiva en paño, Portugal en vino); al bajar el paño portugués a 90 queda el ejemplo de Ricardo (Portugal mejor en los 2, ventaja comparativa de Inglaterra en paño y de Portugal en vino). FPP lineales con $\overline L^A=\overline L^B=2.400$ horas (24 paño o 20 vino en Inglaterra; 26,7 paño o 30 vino en Portugal). **País grande:** con la oferta relativa escalonada y la demanda relativa, si la demanda corta en el tramo horizontal de un país, la RRI coincide con su coste de autarquía y ese país no gana (anexo `anexo:ricardo-rri`).

**Extensiones (alias de esta ficha):** `dornbusch-fischer-samuelson` (continuo de bienes $z\in[0,1]$, $\omega\equiv w^A/w^B$, $A(z)$ y $B(z)$; `eq:dfs-oferta`, `eq:dfs-demanda`, `fig:dfs`; $z$ local, avisada) y `eaton-kortum` (Ricardo probabilístico con Fréchet, `eq:frechet`, `eq:ek-gravedad`, `eq:ek-ganancias`; el 3.B.6 lo resume con la gravedad). Si un tema escribe la fórmula de las ganancias de Arkolakis, Costinot y Rodríguez-Clare, la cuota del gasto nacional no puede ser λ (multiplicador), ni el parámetro de Fréchet θ (CRRA), ni $T_i$ (frontera de transformación): hoy el 3.B.5 y el 3.B.6 la dicen de palabra o con su notación local avisada.

**Implicaciones (regla de Víctor, 10/11/2026, para todos los modelos del 3.B.5 y el 3.B.6):** responden a las 4 preguntas, en este orden: ¿por qué se comercia?, ¿qué produce cada país?, ¿a qué relación real de intercambio?, ¿quién gana?

**Gráficos de referencia:** `oposicion/temario/fuentes/3B05/graficos/ricardo-fpp.tex` y `ricardo-fpp-conjunto.tex` (FPP lineales y RRI), `ricardo-oferta-relativa.tex` y `ricardo-oferta-exportacion.tex` (oferta relativa escalonada, anexo), `dfs.tex`, `cadena-ventaja.tex` y `frontera-mundial.tex` (extensiones).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.5 | Teoría clásica del comercio | desarrollo (hecho, 10/11/2026) | Ventaja absoluta → comparativa con el mismo ejemplo; `eq:ventaja-comparativa`, FPP, RRI con Mill; DFS y Eaton-Kortum; las 4 preguntas en las implicaciones | — |
| 3.A.2 | Pensamiento clásico | resumen (hecho, 4/11/2026) | La pregunta («¿puede comerciar con provecho un país que lo produce todo peor que otro?»); `tab:pano-vino` con A = Inglaterra, B = Portugal, $X$ = paño, $Y$ = vino y la fila del coste relativo (0,83 frente a 1,125); `eq:ventaja-comparativa` $a_X^A/a_Y^A<\mathrm{RRI}=p_X/p_Y<a_X^B/a_Y^B$ (estricta: los 2 ganan; la ficha escribe ≤ para los límites); con RRI = 1, 100 frente a 120 y 80 frente a 90; la autoría (folleto anónimo de 1814, Torrens, 1815; Ruffin, 2002); las Leyes de Granos como contexto; la demanda recíproca de Mill (ensayo I de 1844; Marshall, 1879, la dibuja) cierra la RRI; anexo C en extenso, con `\vertema{3.B.5}` | Gráficos (FPP) y extensiones ($n$ bienes, DFS) |
| 3.B.34, 3.B.39, 3.B.41 | OMC, política comercial UE | mención | Justificación teórica del librecambio | — |

## Divergencias encontradas en el temario actual
- En 3.B.5 los países son 1 y 2 y los bienes «a/b» (paño, vino) en Ricardo, pero A/B y $X$/$Y$ en Haberler y H-O-S del mismo tema. Canon: países A y B, bienes $X$ e $Y$, coeficientes $a_X^A$; el ejemplo de Ricardo se cuenta con paño = $X$ y vino = $Y$.
- 3.B.39 atribuye la ventaja comparativa a Haberler (fue quien la reformuló con costes de oportunidad): matizar.
- **3.A.2 (Word)**: 3 gráficos de FPP capturados, una tabla de una web, «*Do what you do best and trade for the rest*» atribuido a Smith y la notación $a_1, a_2, b_1, b_2$. **Resuelto** en la revisión (4/11/2026): notación canónica en el cuerpo y en el anexo C. El **3.B.5** (sin revisar) usa todavía $a_1, a_2, b_1, b_2$ y «Sir Thomas Peel» (nota 11): al revisarlo, la notación de esta ficha (la del 3.A.2) y Robert Peel (`mapa.yaml`, contradicciones del 3.A.2).
- **Id `mill-demanda-reciproca`** (fase canon del 3.A.2, CC9, **[decidir]**): alias de esta ficha; la demanda recíproca de Mill (la RRI la fija la demanda de cada país por el bien del otro: «gana más quien menos necesita al otro») es la frase del Resultado.
- **Resuelto en el 3.B.5 (10/11/2026):** la notación $a_1, a_2, b_1, b_2$ pasa a la canónica y «Sir Thomas Peel» a Robert Peel.

## Puesta al día de la pasada final: el 3.A.2 (noviembre de 2026)
- **`tab:ventaja-absoluta` del 3.A.2** copia la del 3.B.5 (mismas cifras y colores). En `tab:pano-vino`, Víctor quitó en el 3.A.2 (9/11/2026) la fila del coste relativo y pidió marcar la ventaja comparativa de cada país (Inglaterra, paño; Portugal, vino); el 3.B.5 la conserva. **[decidir]**: recomendado igualar el 3.B.5 a la forma del 3.A.2 (la última que ha visto Víctor), sin tocar las cifras (`pendientes-coherencia.md`).

Autor: Víctor Gutiérrez Marcos
