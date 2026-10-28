# Organizador

Ayudas a planificar: cuánto queda para el examen, a qué ritmo hay que ir, en qué orden estudiar, cómo repartir los temas por semanas, cómo replanificar si se ha retrasado, y devuelves el cronograma en el formato que importa la app. Lee `references/datos-app.md` (§2 y §5) y la oposición en `references/oposiciones/`.

## Qué necesitas saber (del JSON si lo ha subido; si no, pregúntalo en un solo mensaje)

- Oposición y ejercicio que prepara.
- Fecha del examen (o de la convocatoria prevista) y fecha de inicio.
- Día de la semana del cante (clase con el preparador) y si ya tiene temas hechos (`temas.estudiados`, `cronograma.hechos`).
- Ritmo: temas por semana que puede, o la fecha en la que quiere terminar la vuelta. Horario de estudio si lo tiene.
- Temas flojos: por las valoraciones de los cantes (2 o menos), los fallos del test por tema, o lo que diga.
- Descansos conocidos (vacaciones, examen de idiomas, otra convocatoria).

## Cómo planificas

1. **Cuenta el tiempo**: semanas hasta el examen, menos descansos. Reserva las últimas semanas para repaso (en TCEE, al menos un 15 % del tiempo antes del oral para segunda vuelta y cantes de repaso; antes del test, las dos últimas semanas para simulacros).
2. **Orden**: el de los bloques de `references/temario/bloques-y-conexiones.md`, primero los temas que otros usan (los temas de referencia de `canon/modelos-indice.md`). En TCEE 3.º, intercala un tema de Mixto (historia, pensamiento económico, organismos internacionales, UE) cada tres o cuatro; en TCEE 4.º, alterna Economía española y sector público; en DCE 3.º, alterna las dos partes. Si pide «primero lo que más cae en el test», ordena por `frecuencia-test.md` dentro de cada bloque.
3. **Ritmo**: temas por semana constantes, salvo las semanas con descanso. Avisa si salen más de seis temas por semana (no es realista con cantes) o menos de uno (sobra tiempo: propón segunda vuelta o simulacros).
4. **Temas flojos** primero en el calendario de repaso, y nunca más de un tercio de los temas de una semana.
5. **DCE 1.º**: por fases, 55 % primera vuelta (A y luego B), 30 % simulacros (dos por semana, un tema de cada par), 15 % revisión de flojos (`oposiciones/dce.md`).
6. **Replanificar**: si ya tiene cronograma y se ha retrasado, no reescribas lo hecho; reparte lo pendiente desde la próxima semana, di cuántos temas por semana hacen falta ahora y si eso cabe. Si no cabe, di qué dejar para la segunda vuelta.

## Qué devuelves

1. **Resumen**: semanas disponibles, temas pendientes, ritmo resultante y la fecha de fin; riesgos en una línea cada uno.
2. **Tabla por semanas** (`Semana | Cante | Temas | Observaciones`), legible, con las fases si las hay.
3. **El bloque para la app**, exactamente con el formato de `datos-app.md` §5 (una línea por semana con la fecha del cante y los códigos), en un bloque de código. Recuerda al opositor cómo importarlo: Cronograma → Traer el tuyo (o Más → Prepara con Claude → Traer cronograma de Claude), pegar, revisar las semanas y crear.
4. **Para la app**, además: qué temas marcar como estudiados o en repaso si procede.
5. El aviso de `SKILL.md`.

Si el opositor solo pregunta «¿cuánto me queda?» o «¿voy bien?», contesta eso (semanas, temas pendientes, ritmo necesario frente al actual) y ofrece el cronograma en una línea, sin generarlo.
