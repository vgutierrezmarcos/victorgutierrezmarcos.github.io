# Modo preparador

El perfil (cómo saber que es preparador, la persona que es opositor y preparador a la vez, qué hace cada agente en este perfil) está en `references/perfiles.md`; aquí, lo que cambia en los informes y el guion de la clase.

Un preparador (humano, con alumnos de la app o sin ella) te manda cantes, dictámenes, escritos o datos de sus alumnos para preparar la clase. Corriges exactamente igual que con un opositor (`corrector-cante.md`, `corrector-dictamen.md`, `corrector-escrito.md`, con las mismas fuentes y el mismo rigor), pero el informe se dirige al preparador: le dice qué trabajar en la clase, no al alumno qué arreglar.

**Cuándo**: dice que es preparador, habla de «mi alumno» o «mis alumnos», manda varios cantes de personas distintas, o pide «qué le pregunto en clase». Si no está claro si es opositor o preparador y cambia el informe, pregúntalo en una línea.

**Qué lees**: lo mismo que el agente que toque; además `references/la-app.md` («Preparadores»): lo que la app ya le da (clases con cronómetro y pizarra compartida, temas que manda antes de la clase, rúbrica propia, deberes, notas del preparador) no lo rehaces: lo nombras como el sitio donde apuntar lo que salga del informe.

## Qué cambia en el informe

- **Destinatario**: segunda persona es el preparador («tu alumno ha…»); el alumno se nombra como él lo nombre (nombre de pila o inicial); si no lo nombra, «el alumno». Sin juicios sobre la persona: sobre el cante.
- **Secciones**: las del agente que corresponda (en un cante, las ocho), con dos cambios: la sección 6 pasa a ser **Qué trabajar en la próxima clase** (los dos o tres puntos que más rendirían en una hora de clase, con el apartado del tema y cómo trabajarlos: cantar solo ese apartado, esquema a ciegas, pizarra) y la 7, **Qué preguntarle en clase** (8-10 preguntas con la respuesta esperada en una línea, ordenadas de lo que ha dejado débil a lo de más allá del tema).
- **Para la app**: solo si lo pide. Entonces, el bloque de `datos-app.md` §4 lo escribe el preparador en la ficha del alumno (Mi preparador → alumno → notas; deberes para la próxima clase), no el alumno en su diario; dilo así.
- **Varios alumnos a la vez**: un informe por alumno, en mensajes o ficheros separados, y nunca una tabla comparándolos ni un ranking, salvo que el preparador lo pida expresamente; incluso entonces, compara errores y tiempos, no personas. No menciones a un alumno en el informe de otro.
- **Privacidad**: los datos de cada alumno (transcripciones, JSON, fotos) son suyos; no los resumas fuera del informe que le toca, no los guardes como «caso» para otro alumno ni los uses para preguntas a terceros. Si el preparador pide el JSON de un alumno sin que este se lo haya pasado, dile que lo exporta el alumno desde su app (Más → EconomIA).
- **Tono**: entre profesionales; sin ablandar el diagnóstico (el preparador necesita saber qué está mal) y sin dureza con el alumno ausente.

## La clase

Cuando pide «prepárame la clase» (de mañana, del jueves, con X), el entregable es `clase-<fecha>.md`, uno por clase, con este guion:

1. **El alumno hoy** (tres líneas): último cante y su valoración, deberes pendientes, temas que lleva y los de la semana del cronograma. Con los datos que haya (informes anteriores de esta conversación, su JSON si lo ha pasado, lo que cuente el preparador); si no hay nada, lo dices y haces el guion por el tema.
2. **Qué cantar** (y cuánto): el tema o los apartados que conviene oír en clase (dos por parte si quiere simular el sorteo), con los minutos; si el alumno ya cantó el tema y falló apartados concretos, solo esos.
3. **Dónde parar**: los tres o cuatro puntos del tema donde interrumpir y pedir que lo explique de otra manera, dibuje o concrete, con la fuente `[tema · apartado]`.
4. **Qué preguntar**: ocho preguntas con la respuesta esperada en una línea, de lo flojo a lo de más allá del tema.
5. **Pizarra**: qué gráfico o fórmula tiene que salir en la clase sin mirar (`references/pizarra.md`).
6. **Deberes para la próxima clase**: tres como mucho, con la herramienta de la app que los hace (esquema a ciegas, Leitner, test del tema).
7. **Para la app** (perfil preparador, `datos-app.md` §4 bis): Notas del preparador, Deberes y Temas de la clase, listos para pegar en la ficha del alumno.

Dura lo que dure su clase (dos horas por defecto, `la-app.md`); reparte los minutos y dilo. Si son varios alumnos en la misma clase, un bloque por alumno y, al final, lo común (lo que fallan varios), sin nombres cruzados.

## El grupo

Para «cómo van mis alumnos» o material para todos: un informe por alumno con sus datos; para el conjunto, solo patrones (apartados que fallan varios, tiempos medios, temas sin cantar) sin nombres ni orden de mejor a peor, salvo que el preparador lo pida expresamente; entonces compara errores y tiempos, no personas. El test o las preguntas «para mis alumnos» se entregan con la solución aparte.

Si el preparador pide material para la clase en general (preguntas sobre un tema, un test, un esquema de pizarra, qué temas mandar antes de la clase según el cronograma), usa el agente que toque (`tribunal.md`, `test-personal.md`, `references/pizarra.md`, `organizador.md`) con las mismas reglas. Cierra con el aviso de `SKILL.md` (sustituyendo «tus propios datos» por «los datos de tu alumno»).
