# Paradoja de Condorcet y manipulación de la agenda

- **Área:** sector público · **Tema de referencia:** doble, uno por ejercicio, como Borda. **3.A.24** (3.er ejercicio; elección social; **hecho, 22/10/2026**, III.2.1 `sec:renuncia-universalidad`, tabla `tab:condorcet` y gráfico `fig:condorcet`): el ejemplo canónico, el ciclo de votaciones, la intransitividad de la mayoría como antesala del teorema de Arrow, la manipulación de la agenda en una frase y los gráficos de preferencias multimodales y unimodales (enlace con Black). **4.B.2** (4.º ejercicio; reglas de votación): lo mismo con la manipulación de la agenda, el voto estratégico y el *logrolling*. Cada uno, completo para su examen.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio; hecho, 22/10/2026), 4.B.2 (desarrollo, 4.º ejercicio), 3.A.23 (mención; hecho, 21/10/2026: «la mayoría puede preferir $x$ a $y$, $y$ a $z$ y $z$ a $x$», l. 1076, con `\vertema{3.A.24}`), 3.A.8 (mención: Condorcet, prometido al 3.A.24 y cumplido).
- **Manuales de referencia:** Condorcet (1785); Black (1948, 1958); Mueller, *Public Choice III*, cap. 5; Mas-Colell, Whinston y Green, cap. 21.
- **Decisión D121 (13/10/2026):** ¿Cómo se reparten la paradoja de Condorcet y el teorema de Arrow entre 3.A.24 y 4.B.2? Arrow en desarrollo en 3.A.24 y en resumen aplicado a la votación en 4.B.2. (La parte de Condorcet, «resumen en 3.A.24», la sustituye D135.)
- **Decisión D135 (13/10/2026):** Condorcet con referencia doble, 3.A.24 y 4.B.2, como Borda (D120): en 3.A.24 es la antesala de Arrow y no puede depender de 4.B.2.

## Presentación de referencia (3.A.24, III.2.1)

**Idea:** Condorcet (1785) defiende comparar las alternativas por parejas, por mayoría, y descubre que, aunque cada individuo sea transitivo, la mayoría puede no serlo. Es el problema que generaliza Arrow.

**Ejemplo canónico (común con el 4.B.2; CC4 del 3.A.24):** la comunidad de 3 vecinos decide cuánto gastar en reformar el portal: poco ($x$), algo ($y$) o mucho ($z$) (**[decidir]** D2 del 3.A.24: letras $x$, $y$, $z$, aplicadas, frente a $A$, $B$, $C$ de la versión anterior de esta ficha; pendiente de Víctor). Tabla `tab:condorcet`:

| Vecino | 1.ª | 2.ª | 3.ª |
|---|---|---|---|
| 1 | $x$ (poco) | $y$ (algo) | $z$ (mucho) |
| 2 | $y$ (algo) | $z$ (mucho) | $x$ (poco) |
| 3 | $z$ (mucho) | $x$ (poco) | $y$ (algo) |

Por mayoría, $x$ gana a $y$ (vecinos 1 y 3), $y$ a $z$ (1 y 2) y $z$ a $x$ (2 y 3): $x\succ_Gy\succ_Gz\succ_Gx$, la preferencia social es **intransitiva** (ciclo). No hay **ganador de Condorcet** (la alternativa que gana a todas por parejas).

**Manipulación de la agenda** (en una frase en el 3.A.24; el detalle, en nota): votando por eliminación, gana siempre la que entra en la última votación; quien fija el orden fija el resultado ($x$ contra $y$ y luego $z$: gana $z$; $y$ contra $z$ y luego $x$: gana $x$; $x$ contra $z$ y luego $y$: gana $y$).

**Por qué ocurre:** las alternativas tienen un orden natural (de menos a más gasto) y el vecino 3 prefiere los extremos al centro: preferencias **multimodales** (2 picos). **3 formas de romper el ciclo:** preferencias idénticas (no haría falta votar), fijar el orden de votación (decide quien controla la agenda) o restringir el dominio a preferencias **unimodales** (Black, 1948; ficha `votante-mediano`): basta con que el vecino 3 pase a $z\succ y\succ x$.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A24/graficos/condorcet.tex` (3.A.24, 22/10/2026; el 4.B.2 debe usar el mismo), 2 paneles. Eje horizontal: las alternativas $x$, $y$, $z$ en su orden natural; eje vertical: el puesto en la ordenación (3.ª abajo, 1.ª arriba). **Izquierda** (multimodales, ciclo): vecino 1 $x\succ y\succ z$, vecino 2 $y\succ z\succ x$, vecino 3 $z\succ x\succ y$ (en V, 2 picos). **Derecha** (unimodales): vecinos 1 y 2 igual, vecino 3 $z\succ y\succ x$; picos en $x$, $y$, $z$; el mediano es el vecino 2, con pico en $y$. En la pizarra, por partes: primero el panel izquierdo; al cambiar al vecino 3, el derecho con el pico del mediano.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Elección social | desarrollo (referencia del 3.º; hecho, 22/10/2026) | a) Idea; b) Modelo con la tabla de los 3 vecinos y el ciclo; agenda en una frase (detalle en nota); c) las 3 formas de romper el ciclo; gráfico `condorcet` de 2 paneles (enlace con `votante-mediano`) | Voto estratégico y *logrolling* en detalle (van con la IAI, ficha `logrolling`) |
| 4.B.2 | Reglas de votación | desarrollo (referencia del 4.º) | El mismo ejemplo de los vecinos con las mismas letras, la misma tabla y el mismo gráfico; agenda, voto estratégico, *logrolling* | — |
| 3.A.23 | Las reglas de votación como fallo del sector público | mención (hecho, 21/10/2026) | Ciclo $x$, $y$, $z$ en una frase; `\vertema{3.A.24}` | El ejemplo |

## Divergencias encontradas en el temario actual
- Letras: el 3.A.24 revisado y el 3.A.23 usan $x$, $y$, $z$; el 4.B.2, $A$, $B$, $C$ con otro orden. Canon: el ejemplo de los vecinos con $x$, $y$, $z$ si Víctor aprueba la D2 del 3.A.24; si elige $A$, $B$, $C$, cambian esta ficha, el 3.A.24 y el 3.A.23 (`pendientes-coherencia.md`, condicional).
- La ficha decía que no había `.tex`: lo creó el 3.A.24 (`condorcet.tex`).
- 4.B.2 (sin revisar): el teorema de May está mal enunciado en la nota 20 (ficha `may`); la nota 23 sobre Gibbard-Satterthwaite habla de regla «inmune a la manipulación», contradiciendo el texto (ficha `gibbard-satterthwaite`).
