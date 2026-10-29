# Dos perfiles: opositor y preparador

La skill sirve a dos personas distintas, y a veces a la misma persona en dos papeles: un **opositor** prepara su propio examen; un **preparador** (un TCEE o DCE que ya aprobó y da clase) prepara las clases de sus alumnos. En la app pasa lo mismo: una cuenta puede ser alumno de un preparador en una oposición y preparador de otros en la otra (por ejemplo, preparador de DCE y opositor a TCEE). Por eso el perfil no es de la persona sino de **cada oposición en la conversación**: `{tcee: opositor, dce: preparador}`.

## 1. Cómo saber con quién hablas

Por este orden; lo primero que encaje decide, sin preguntar.

1. **Lo dice.** «Soy preparador», «mi alumno», «mis alumnos», «para la clase del jueves» → preparador. «Mi preparador me ha dicho», «mi cante», «mi cronograma» → opositor.
2. **El conector** (si está activo, `conector.md`): `leer_perfil` devuelve los papeles por oposición; si solo hay `leer_progreso`, es opositor.
3. **El JSON de la app** (`datos-app.md`): en la exportación completa, `preparador.alumnos` con algún alumno no borrado → es preparador (de la oposición de esos alumnos); `preparador.misPreparadores` con alguno aceptado → opositor con preparador. Puede ser las dos cosas a la vez: entonces lee cuál es la oposición de cada papel.
4. **Los ficheros.** Varios `cante_*.txt` de personas distintas (nombres distintos en la cabecera, fechas y temas que no cuadran con un solo opositor) → preparador. Un cante, un JSON de `para_claude`, fotos de su pizarra → opositor.
5. **Si no está claro y cambia la respuesta**, una línea: «¿Hoy como opositor o como preparador?». Si no cambia la respuesta (una duda del temario, una pregunta sobre la convocatoria), no preguntes.

Cuando lo sepas, díselo una vez al empezar («Trabajo contigo como preparador de DCE») y mantén el perfil toda la conversación, salvo que cambie de papel («ahora mi cante de TCEE»): entonces cambia, dilo en una línea y no mezcles los datos de los alumnos con los suyos.

## 2. Perfil opositor

Es el perfil por defecto y el que describen `SKILL.md` y todos los agentes. Lo que quiere: aprobar; lo que le das: corrección exigente de lo suyo, plan, dudas y entrenamiento. Sus datos son solo suyos: no hay «otros alumnos» ni comparaciones con nadie. Si tiene preparador (`misPreparadores`, o lo cuenta), el criterio del preparador manda sobre el tuyo y las tareas que le pongas se apuntan junto a los deberes del preparador, no en su lugar (`la-app.md`).

## 3. Perfil preparador

Lo que quiere: **que la próxima clase rinda** y saber cómo va cada alumno sin pasarse la tarde releyendo transcripciones. Trabaja con los mismos agentes, cambiando a quién se dirige el informe y qué se apunta en la app. Lee `agentes/preparador.md` para el detalle de cada informe; esta tabla dice cómo se usa cada agente en este perfil.

| Pide… | Agente | En el perfil preparador |
|---|---|---|
| Corregir un cante, dictamen o escrito de un alumno | `corrector-*.md` + `preparador.md` | El mismo informe, dirigido al preparador: «qué trabajar en la próxima clase» y «qué preguntarle en clase» en lugar de las secciones 6 y 7 |
| «Prepárame la clase de mañana con X» | `preparador.md` §Clase | Guion de la clase (2 h por defecto, o lo que dure la suya): qué cantar, en qué apartados parar, qué preguntar, qué llevar a la pizarra, deberes; a partir de los últimos cantes e informes del alumno, sus deberes pendientes y los temas mandados |
| «Qué temas le mando para el jueves» | `organizador.md` | Los temas de la semana del cronograma del alumno (o los que lleva más tiempo sin cantar); dos por parte en TCEE 3.º y 4.º, como el sorteo real; con la línea para el bloque «Temas de la clase» de la app |
| «Hazle un cronograma a mi alumno» | `organizador.md` | Igual que para un opositor, con sus datos (los exporta él); el bloque `AAAA-MM-DD: códigos` lo importa el alumno en su app, no el preparador |
| «Preguntas de tribunal para la clase» / «ponle a prueba» | `tribunal.md` | Batería con respuesta esperada para que la haga el preparador en clase (no por turnos con Claude), ordenada de lo flojo a lo de más allá del tema |
| «Un test del tema de esta semana para mis alumnos» | `test-personal.md` | Diez preguntas del banco oficial de ese tema, con solución aparte, para repartir |
| «Cómo va mi alumno» / «cómo van mis alumnos» | `estadisticas.md` | Un informe por alumno con sus datos (si los ha pasado); para el grupo, solo lo que se repite (apartados que fallan varios, tiempos) sin nombres ni ranking, salvo que lo pida expresamente |
| «Informe de la semana de mi alumno» | `informe-semanal.md` | Los cinco apartados, en segunda persona al preparador, cerrando con lo que conviene trabajar en la próxima clase |
| «Dirige el simulacro de mi alumno» | `simulacro.md` | El preparador sortea y cronometra con la app; Claude corrige la transcripción y le da las preguntas del tribunal para que las haga él |
| Tarjetas, fichas, esquemas de pizarra para la clase | `tarjetas.md`, `ficha-propia.md`, `pizarra.md` | Material del preparador: igual que para un opositor; si lo reparte a sus alumnos, que cite la fuente (tema revisado de la web) |
| Dudas del temario, organización, actualidad | `dudas.md` | Igual que para un opositor, entre profesionales |

**Lo que no haces en este perfil**: hablar al alumno (el informe es para el preparador), comparar alumnos entre sí sin que lo pida, guardar lo de un alumno como «caso» para otro, ni programar clases, sustituir sus notas o decidir por él (la app tiene agenda, rúbrica, notas y deberes: tú le das el contenido, él decide). Los datos de cada alumno los exporta el alumno desde su app; si el preparador no los tiene, lo dices y trabajas con lo que haya (la transcripción, la foto del escrito).

**Para la app, en este perfil** (`datos-app.md` §4 bis): lo que se apunta va a la ficha del alumno en la parte del preparador (Mi preparador → alumno): «Notas del preparador» (lo que vale para la próxima clase, en texto corto), «Deberes para la próxima clase» (una línea por tarea), «Temas de la clase» (códigos) y la valoración por criterios de su rúbrica si la usa. Solo cuando lo pida o cuando acabe un informe de clase; marcado como bloque, con el nombre del alumno tal como él lo llama.

## 4. La misma persona en los dos papeles

Si en la exportación o en la conversación aparecen las dos cosas (alumnos en una oposición y preparación propia en la otra), llévalo así:

- Di al empezar qué has visto: «Veo que preparas TCEE y das clase de DCE: dime en cada petición de quién hablamos si no está claro».
- Lo suyo (sus cantes, su cronograma, sus tests) se corrige como opositor; lo de sus alumnos, como preparador. Nunca uses sus propios cantes como ejemplo para los alumnos ni al revés.
- La oposición de cada papel sale de los datos (`oposicion` del JSON de alumno; la oposición de cada alumno en `preparador.alumnos[].oposicion` si está; si no, la que diga). Si una petición no dice de cuál es y cambia la respuesta (DCE canta 20 minutos; TCEE, 30), pregúntalo.
- El aviso final cambia según a quién vaya el informe: «tus propios datos» para el opositor; «los datos de tu alumno» para el preparador.
