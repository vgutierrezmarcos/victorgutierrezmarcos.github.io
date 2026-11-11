# Agendar una clase

Para «agéndame una clase con mi preparador el jueves», «pide clase para la semana que viene» o, si quien habla es preparador, «ponle una clase a Ana el martes a las seis». Solo con el conector (herramientas `preparar_clase` y `agendar_clase`); sin él, explica cómo hacerlo en la app (Agenda → Nuevo cante → «Con quién», o Mi preparador → Reservar) y no inventes nada.

## Cómo hacerlo

1. **Lee primero.** Llama a `preparar_clase` (con `oposicion` si es DCE; como preparador, con `con` = id del alumno en cuanto sepas cuál, y con `dia` cuando haya un día en juego). Te dice si es opositor, preparador o las dos cosas, con quién puede tener clase, los huecos libres del preparador, la duración habitual, sus próximas clases y los temas del cronograma.
2. **Pregunta solo lo que falte**, en un único mensaje corto, con tu propuesta ya puesta para que baste con decir «sí»:
   - **Día y hora.** Como opositor, propón dos o tres huecos libres de su preparador que encajen con lo que ha dicho («el jueves» → los del jueves); si el preparador no tiene huecos publicados, pregunta día y hora y avisa de que él tendrá que aceptarla. Como preparador, propón el día del cante del alumno si lo hay en su cronograma.
   - **Presencial u online.** Si es presencial y es el preparador quien agenda, pregunta dónde (si no lo sabes); si es online, no hace falta enlace: la app del preparador crea el de Meet.
   - **Temas.** Propón los del cronograma para ese día (`temas_del_cronograma`); si no hay, los de los próximos cantes. Di de dónde salen («los de tu cronograma para esa semana: 3.A.8 y 3.A.9»). Respeta cuántos se cantan por clase (TCEE suele ser uno; DCE, dos: uno de cada parte).
   - **Con quién.** Si tiene un solo preparador (o el preparador nombra a un alumno sin ambigüedad), no lo preguntes; si hay varios, enumera los nombres.
   - **Duración**, solo si quiere cambiar la habitual.
3. **Confirma antes de escribir.** Resume en una línea («Pido a Víctor una clase online el jueves 6 de marzo de 18:00 a 20:00 con el 3.A.8 y el 3.A.9. ¿La pido?») y espera un sí claro. Sin confirmación, no llames a `agendar_clase`.
4. **Agenda** con `agendar_clase` (`como`: «opositor» o «preparador», `con`, `dia`, `hora`, `modalidad`, `temas`, y `lugar`, `minutos` o `nota` si hacen falta). Si devuelve que **pisa otra clase**, díselo con la hora de la otra y pregunta si sigue; solo entonces repite con `aunque_choque: true`.
5. **Cuenta lo que ha pasado**, sin adornos:
   - Opositor: es una **petición**; su preparador la verá en su app y tiene que aceptarla. Cuando la acepte, aparecerá en su agenda con esos temas. Mientras esté pendiente, puede anularla en la app.
   - Preparador: la clase ya está en su agenda y, si el alumno está enlazado, en la del alumno, con los temas **propuestos** (el alumno los acepta o los cambia). El evento de Google Calendar y el enlace de Meet los crea su app al abrirla. Si no ha llegado a la agenda del alumno, di por qué (lo dice la respuesta).

## Reglas

- Fechas y horas siempre en **hora de Madrid**, y escritas como las diría una persona («el jueves 6 de marzo a las seis de la tarde»), no en ISO.
- No agendes nada en el pasado ni lo bastante pronto como para que el preparador no pueda verlo (si piden «hoy en una hora», avisa de que conviene escribirle también).
- Una clase por llamada. Para varias («todos los martes de noviembre»), confírmalas juntas y agéndalas una a una, contando al final cuántas han salido bien.
- Nunca pidas clase a quien no sale en `preparar_clase` ni la crees para un alumno que no es suyo: el conector lo rechaza, y las reglas de la app también.
- Si el usuario es preparador y opositor (en oposiciones distintas o en la misma), pregunta en qué papel la agenda si no está claro.
