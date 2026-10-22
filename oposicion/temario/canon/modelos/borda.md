# Recuento de Borda y otras reglas de votación

- **Área:** equilibrio general y bienestar · **Tema de referencia:** doble, uno por ejercicio. **4.B.2** (4.º ejercicio; reglas de votación en el título): Borda con ejemplo, comparación con la mayoría y las demás reglas, manipulación. **3.A.24** (3.er ejercicio; **hecho, 22/10/2026**, III.2.2 `sec:renuncia-iai` con a)-c) y tabla `tab:borda`): la regla, un ejemplo breve y por qué es una salida a Arrow que renuncia a la independencia de las alternativas irrelevantes. Cada uno, completo para su examen.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio; hecho, 22/10/2026), 4.B.2 (desarrollo, 4.º ejercicio; hoy mención).
- **Manuales de referencia:** Borda (1781); Mueller, *Public Choice III*, cap. 7; Saari (1995).
- **Decisión D120 (13/10/2026):** ¿Cuál es el tema de referencia del recuento de Borda? Desarrollo en los dos ejercicios: se desarrolla en 4.B.2 (más propio del 4.º) y también en 3.A.24, lo bastante para que quien estudia el 3.er ejercicio lo entienda.

## Presentación de referencia (3.A.24, III.2.2)

**Idea:** para que la intensidad cuente hay que usar más información que la ordenación de cada par: renunciar a la IAI. Borda (1781) puntúa a los candidatos por su puesto en cada ordenación; la distancia en la ordenación es una medida **ordinal** de la intensidad.

**Regla:** con $m$ alternativas ($m$ local), cada votante da $m$ puntos a su favorita, $m-1$ a la siguiente… y 1 a la última; gana la que suma más. Es una regla **ordinal posicional**, no cardinal (no mide utilidades). Cumple U, T, P y D; **viola la IAI** y es **manipulable**.

**Ejemplo común** (K34 del 3.A.24; propuesto como común con el 4.B.2, CC4): una comunidad mayor, de 5 vecinos, y las 3 opciones de gasto en el portal ($x$ poco, $y$ algo, $z$ mucho; letras pendientes de la D2 del 3.A.24). 3 vecinos: $x\succ y\succ z$; 2 vecinos: $y\succ z\succ x$; 3, 2 y 1 puntos. Tabla `tab:borda`:

| Caso | $x$ | $y$ | $z$ | Gana |
|---|---|---|---|---|
| Preferencias verdaderas | 11 | 12 | 7 | $y$ |
| Sin $z$ (2 y 1 puntos) | 8 | 7 | — | $x$ |
| Los 3 de $x$ declaran $x\succ z\succ y$ | 11 | 9 | 10 | $x$ |
| Mayoría por parejas | $x$ gana a $y$ y a $z$ por 3 a 2 | | | $x$ |

Lecturas: Borda no elige al ganador de Condorcet ($x$); al retirar $z$, que nadie mueve respecto a $x$ e $y$, cambia el orden social de $x$ e $y$ (**viola la IAI**); a los 3 de $x$ les basta con *enterrar* a la rival poniendo $z$ segunda (**manipulable**). En la pizarra, 3 líneas: 11-12-7; sin $z$, 8-7; manipulado, 11-9-10.

**Valoración:** «Cada maestrillo tiene su librillo» (refrán del 3.A.24): con las mismas preferencias, la mayoría elige $x$ y Borda, $y$; el ganador depende de la regla. Deja entrar la intensidad a través de lo que se **declara**: abre la puerta a mentir (enlace con Gibbard-Satterthwaite, III.3 del 3.A.24). Otras reglas también invitan al voto estratégico: la segunda vuelta y D'Hondt con circunscripciones pequeñas (voto útil), en nota; D'Hondt reparte escaños, no elige una alternativa. El voto ponderado (Shapley-Shubik) va en nota de III.2.4 (ficha `nucleo-shapley`), no con Borda.

**Gráfico de referencia:** no tiene; la tabla `tab:borda`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.2 | Reglas de votación | desarrollo (referencia del 4.º) | La regla con el mismo ejemplo de 5 vecinos y la misma tabla; comparación con la mayoría y las demás reglas (segunda vuelta, aprobación, D'Hondt, clones), manipulación | — |
| 3.A.24 | Salidas a Arrow | desarrollo (referencia del 3.º; hecho, 22/10/2026) | a) Idea; b) la regla y el ejemplo `tab:borda` (Condorcet, IAI, manipulación); c) valoración con el refrán y el enlace con Gibbard-Satterthwaite; segunda vuelta y D'Hondt en nota | Las demás reglas de votación |

## Divergencias encontradas en el temario actual
- Resueltas en el 3.A.24 revisado (22/10/2026): Borda «cardinal» y «voto ponderado» → regla ordinal posicional (el voto ponderado, en nota aparte); salía 2 veces → una, con el ejemplo común; errata «D'Hont» → D'Hondt; ejemplo con 4 alternativas y 4, 3, 2, 1 puntos → $m$ alternativas en general y el ejemplo de 3.
- 4.B.2 (sin revisar): debe usar el mismo ejemplo de 5 vecinos (K34) y las mismas letras que el 3.A.24.
