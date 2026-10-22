# Preferencias unimodales de Black y teorema del votante mediano

- **Área:** sector público · **Tema de referencia:** doble, uno por ejercicio. **3.A.24** (3.er ejercicio; **hecho, 22/10/2026**, III.2.1 `sec:renuncia-universalidad` con a)-d) y gráfico `fig:condorcet`, panel derecho): las preferencias unimodales de Black y el teorema del votante mediano son la salida clásica a Arrow restringiendo el dominio («desarrollos posteriores» del título). **4.B.2** (4.º ejercicio; reglas de votación): además Downs-Hotelling en desarrollo, multidimensionalidad y agenda. 4.B.5 lo aplica al gasto.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio; hecho, 22/10/2026), 4.B.2 (desarrollo, 4.º ejercicio), 4.B.5 (resumen: gasto redistributivo), 3.A.18 (mención con Hotelling; hecho, 19/10/2026, ficha `hotelling`); 3.A.23 (mención; hecho, 21/10/2026).
- **Manuales de referencia:** Black (1948), *JPE*, y *The Theory of Committees and Elections* (1958); Mueller, *Public Choice III*, cap. 5; Persson y Tabellini, *Political Economics*, cap. 2; Meltzer y Richard (1981), *JPE*; Romer (1975) y Roberts (1977); Moulin (1980), *Public Choice*.
- **Decisión D137 (13/10/2026):** referencia doble, 3.A.24 y 4.B.2, cada uno completo para su examen.

## Presentación de referencia (3.A.24, III.2.1)

**Pregunta:** ¿cuándo la mayoría simple da una ordenación transitiva y qué alternativa gana?

**Idea:** la paradoja de Condorcet solo aparece con algunos perfiles; excluyéndolos (renunciando a U) la mayoría vuelve a ser transitiva. Preferencias **unimodales** (de un solo pico): las alternativas se ordenan en una línea y cada votante prefiere menos cuanto más se aleja de su favorita.

**Supuestos** (lista completa, en este orden): alternativas en una sola dimensión; preferencias unimodales; número impar de votantes; votación por parejas con mayoría simple y voto sincero.

**Desarrollo:** **teorema del votante mediano** (Black, 1948, 1958): la favorita del votante mediano (el que deja la mitad de los picos a cada lado) gana por mayoría a cualquier otra; es el **ganador de Condorcet** y la mayoría es transitiva. **Ejemplo común** (el de los vecinos de la ficha `paradoja-condorcet`): basta con que el vecino 3 pase a $z\succ y\succ x$; picos en $x$, $y$, $z$; el mediano es el vecino 2 y su favorita, $y$, gana a $x$ (vecinos 2 y 3) y a $z$ (1 y 2).

**Implicaciones:** se cumplen T, P, IAI y D a costa de U; la teoría de la votación gana capacidad de predicción.

**Extensiones (menciones en el 3.A.24):** competencia electoral de Downs-Hotelling (Hotelling, 1929; Downs, 1957): la ciudad lineal con precios fijos (\vertema{3.A.18}; fichas `downs-hotelling` y `hotelling`); **varias dimensiones**: el equilibrio exige simetría (Plott, 1967) u homogeneidad (Kramer, 1973) muy restrictivas, y sin él quien controla la agenda lleva la votación a casi cualquier alternativa (McKelvey, 1976) (\vertema{4.B.2}). Con información privada: la regla de la mediana de los picos declarados no es manipulable (Moulin, 1980; ficha `gibbard-satterthwaite`).

**Valoración:** ¿es restrictivo? Poco si se vota una cantidad, mucho si la alternativa es cualitativa o tiene varias dimensiones. ¿Es eficiente? No tiene por qué: con un bien público financiado con cuotas iguales, cada votante quiere $\mathrm{RMS}^i_{GX}(G)=\mathrm{RMT}_{GX}/I$ y gana el del mediano, $G^m$; la eficiencia pide $\sum_i\mathrm{RMS}^i_{GX}(G^*)=\mathrm{RMT}_{GX}$ (\vertema{3.A.23}). **Condición de Bowen** (1943):
$$G^m=G^*\iff \mathrm{RMS}^m_{GX}(G^*)=\frac1I\sum_{i=1}^{I}\mathrm{RMS}^i_{GX}(G^*)$$
(la valoración del mediano igual a la media). La causa: la mayoría cuenta cabezas, no intensidades.

**Aplicación al tamaño del gasto (Meltzer-Richard, 1981; 4.B.5):** si la renta mediana es menor que la media, el votante mediano prefiere más redistribución; extender el sufragio hace crecer el gasto.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A24/graficos/condorcet.tex`, **panel derecho** (unimodales; ficha `paradoja-condorcet`): eje horizontal con las alternativas en su orden natural, vertical con el puesto en la ordenación; los 3 picos y el del mediano. El gráfico de Bowen (suma vertical de las RMS frente a CMg_G) es el de `3A23/graficos/bowen.tex` (ficha `samuelson-bienes-publicos`).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Elección social | desarrollo (referencia del 3.º; hecho, 22/10/2026) | a) Idea; b) Modelo con i) los 5 supuestos, ii) el teorema con el ejemplo de los vecinos, iii) implicaciones; c) extensiones (Downs-Hotelling y varias dimensiones, una línea cada una); d) valoración con la condición de Bowen y `\vertema{3.A.23}` | Meltzer-Richard; Downs-Hotelling y Plott-McKelvey en detalle |
| 4.B.2 | Reglas de votación | desarrollo (referencia del 4.º) | Los mismos supuestos y el mismo ejemplo y gráfico; eficiencia (Bowen), multidimensionalidad (Plott, Kramer, McKelvey), Downs-Hotelling | — |
| 4.B.5 | Crecimiento del gasto | resumen | Meltzer-Richard | El teorema |
| 3.A.18 | Diferenciación de productos | mención (hecho, 19/10/2026) | Con precios fijos, el efecto demanda lleva a los 2 partidos a la posición del votante mediano (ciudad lineal); remite a 3.A.24 | El teorema |
| 3.A.23 | Otras formas de revelar las preferencias | mención (hecho, 21/10/2026) | Con mayoría simple gana la cantidad de bien público preferida por el votante mediano, que en general no cumple la condición de Samuelson; la unanimidad de Wicksell da poder de veto; `\vertema{3.A.24}` | El teorema |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): teorema en resumen sin la lista de supuestos → desarrollo con los 5; Bowen con $|\mathrm{RMT}^G_X|=\sum|\mathrm{RMS}^G_X|$ → $\mathrm{RMS}^i_{GX}$, $\mathrm{RMT}_{GX}$; Plott-McKelvey (antes «no repetir en 3.A.24») pasan a mención en una línea, con el desarrollo en el 4.B.2 (N5 del 3.A.24).
- La ficha decía que no había `.tex`: el gráfico es el panel derecho de `condorcet.tex` (3.A.24).
- 4.B.5 atribuye el «gasto público como redistribuidor» a **Romer y Rosenthal (1980)** describiendo en realidad **Meltzer y Richard (1981)**. Romer y Rosenthal (1978-1979) es el modelo del establecimiento de agenda (*agenda setter*) con punto de reversión. **Corregir.**
- Notación de preferencias: $R_i$ (4.B.2) frente a $\succsim_i$ (3.A.24, 3.A.8). Canon: $R_i$ como nombre de la ordenación y $\succsim_i$ para la relación (ficha `arrow-imposibilidad`).
