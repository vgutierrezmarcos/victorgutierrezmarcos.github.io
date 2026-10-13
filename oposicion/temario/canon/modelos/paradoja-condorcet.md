# Paradoja de Condorcet y manipulación de la agenda

- **Área:** sector público · **Tema de referencia:** doble, uno por ejercicio, como Borda. **3.A.24** (3.er ejercicio; elección social): el ejemplo canónico, el ciclo de votaciones, la intransitividad de la mayoría como antesala del teorema de Arrow, la manipulación de la agenda en una frase y los gráficos de preferencias multimodales y unimodales (enlace con Black). **4.B.2** (4.º ejercicio; reglas de votación): lo mismo con la manipulación de la agenda, el voto estratégico y el *logrolling*. Cada uno, completo para su examen.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio), 4.B.2 (desarrollo, 4.º ejercicio)
- **Manuales de referencia:** Condorcet (1785); Mueller, *Public Choice III*, cap. 5; Mas-Colell, Whinston y Green, cap. 21.
- **Decisión D121 (13/10/2026):** ¿Cómo se reparten la paradoja de Condorcet y el teorema de Arrow entre 3.A.24 y 4.B.2? Arrow en desarrollo en 3.A.24 y en resumen aplicado a la votación en 4.B.2. (La parte de Condorcet, «resumen en 3.A.24», la sustituye D135.)
- **Decisión D135 (13/10/2026):** Condorcet con referencia doble, 3.A.24 y 4.B.2, como Borda (D120): en 3.A.24 es la antesala de Arrow y no puede depender de 4.B.2.

## Presentación de referencia
**Ejemplo canónico:** tres votantes y tres alternativas: $1: A\succ B\succ C$; $2: B\succ C\succ A$; $3: C\succ A\succ B$. Por mayoría $A\succ_G B$, $B\succ_G C$ y $C\succ_G A$: la preferencia social es **intransitiva** (ciclo). **Manipulación de agenda:** quien fija el orden de las votaciones por pares decide el ganador. La paradoja desaparece si las preferencias son unimodales (ficha `votante-mediano`): el votante 3 tiene preferencias multimodales.

**Gráficos de referencia:** utilidad de los tres votantes sobre $A$, $B$, $C$ (preferencias multimodales del votante 3); el mismo gráfico tras modificar al votante 3 (unimodales). No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.24 | Elección social | Desarrollo (referencia del 3.º) | Ejemplo canónico, ciclo e intransitividad como motivación de Arrow; agenda en una frase; gráficos multimodal y unimodal (enlace con `votante-mediano`) | Voto estratégico y *logrolling* en detalle |
| 4.B.2 | Reglas de votación | Desarrollo (referencia del 4.º) | Ejemplo, agenda, voto estratégico, *logrolling* | — |

## Divergencias encontradas en el temario actual
- Mismo ejemplo con letras y orden distintos en 3.A.24 y 4.B.2: usar el de arriba en los dos.
- 4.B.2: el teorema de May está mal enunciado en la nota 20 (con dos alternativas, la mayoría simple es la única regla anónima, neutral, decisiva y con respuesta positiva); la nota 23 sobre Gibbard-Satterthwaite habla de regla «inmune a la manipulación», contradiciendo el texto (toda regla no dictatorial con tres o más alternativas y dominio universal es manipulable).
