# Novedades de la app pendientes de publicar

Las mejoras de la app no van una a una a `novedades.json`: se apuntan aquí y se
publican **juntas, en una sola novedad**, cada vez que una versión llega a Google
Play (solo con lo que importe al opositor). La app está en producción en Google
Play desde el 26 oct. 2026 (1.19.2, 57); esa novedad ya salió. Norma de Víctor del 21 oct. 2026: en Novedades solo lo relevante.

## Para la siguiente versión en Google Play (1.27.0 publicada el 25 nov.)

Confirmado en `main` (c65b55d6 y 40b5e8b0), sin versión nueva ni AAB todavía:

- (25 nov., siguiente versión) Pizarra: la barra de herramientas se puede poner arriba, lejos de la mano que apoyas al escribir, o suelta, para arrastrarla donde moleste menos (··· → Barra de herramientas; se recuerda). Mientras escribes con el lápiz, la barra no hace caso a la palma que la roce: ya no se cambia de herramienta, se borra ni se deshace sin querer
- (25 nov., siguiente versión) Clases: el aviso de que te han llegado los temas dice el tiempo de esquema de esa clase (el que haya puesto tu preparador en el cronómetro, p. ej. 30'), no siempre el del examen (22'30"); si lo cambia antes de la clase, el aviso se vuelve a programar con el nuevo
- (25 nov., siguiente versión) Clases: en los avisos del cronómetro (esquema y exposición) la cuenta atrás baja sola en Android, y el texto dice hasta qué hora («Esquema hasta las 17:35») en vez de un «quedan 30:00» que se quedaba fijo; el aviso de los temas se quita solo al acabar el esquema
- (25 nov., siguiente versión) Preparadores: aceptar una reserva se hace con un solo toque (se ve que está trabajando y no se puede tocar dos veces) y la clase sale una sola vez en tu Google Calendar, aunque se mande dos veces
- (25 nov., siguiente versión) Clases: con el cronómetro de la clase en marcha o en pausa, un mini reloj flotante se ve desde cualquier pantalla (un tema, el temario, un test…), en el móvil y en el ordenador: enseña el esquema o la exposición y el tiempo, se pausa y se continúa desde él (lo ve igual tu alumno o tu preparador) y, al tocarlo, vuelves a la clase; se arrastra a donde moleste menos y se recuerda el sitio
## Publicado el 25 nov. 2026 (1.27.0 en producción)

Novedad en `novedades.json`: «Versión 1.27.0 de la app: el banco de más de 1.000 preguntas de EconomIA ya sale en el test con tu cuenta, te presentas al buscar preparador, presencial u online por separado e «Informe de mi último cante» en la burbuja de EconomIA». Resumía:

- (25 nov., 1.27.0) Test: con tu cuenta, las más de 1.000 preguntas del banco de EconomIA (no oficiales, revisadas y con explicación) junto a las oficiales, desmarcando «Solo preguntas de exámenes oficiales» (la 1.26.0 lo anunciaba en sus notas, pero no lo traía)
- (25 nov., 1.27.0) Buscar preparador: al publicar lo que buscas puedes presentarte (opcional) con la vuelta en la que vas, los ejercicios aprobados, las convocatorias, tu formación, tu dedicación y si has tenido preparador, más lo que quieras contarles; lo leen todos los preparadores antes de escribirte, y ves cómo te verán
- (25 nov., 1.27.0) Online y presencial se marcan por separado y puedes decir «prefiero presencial, pero acepto online»; si pides solo presencial, la app te avisa de que fuera de Madrid es muy difícil encontrarlo (y en Madrid, de que con online tienes más donde elegir) y, si en dos semanas nadie te ha escrito, te sugiere añadir online
- (25 nov., 1.27.0) EconomIA en la app: «Informe de mi último cante» en la burbuja y textos que dejan claro que complementa a tu preparador
- Reglas de Firestore con `aceptaOnline` y `perfil` en las búsquedas: publicadas por Víctor el 25 nov.

## Publicado el 25 nov. 2026 (1.26.0 en producción)

Novedad en `novedades.json`: «Nueva versión de la app «Oposición TCEE · DCE» (1.26.0 en Google Play): EconomIA integrada y un banco de más de 1.000 preguntas de test revisadas de los 90 temas, además de las de los exámenes oficiales». Resumía:

- (20 nov., siguiente versión) La burbuja de EconomIA sale desde el principio en Inicio, los temas, los tests, el cronograma y los cantes: la primera vez te ayuda a elegir y conectar tu IA, y luego la abre con el mensaje ya escrito (en un tema, «Tengo una duda de este tema»). Se oculta en Más → EconomIA, que ahora dice arriba en qué IA lo tienes configurado
- (20 nov., siguiente versión) Los temas revisados (exclusivos) piden iniciar sesión con Google para leerlos, en vez de abrir la versión antigua
- (11 nov., siguiente versión) Tu IA a un toque: en Más → EconomIA eliges tu IA (Claude, Le Chat, ChatGPT o Gemini) y, cuando la tienes conectada, una burbuja pequeña en Inicio, los temas, los tests, el cronograma y los cantes la abre con el mensaje ya escrito («Tengo una duda de este tema», «Pregúntame como el tribunal», «Repasa conmigo los fallos»…); se puede cambiar de esquina u ocultar
- (11 nov., web; **no sale en la novedad**: decisión de Víctor del 20 nov., de momento solo en la app; se activa con `scripts/temas-web-visible.py --mostrar`) Los temas revisados se leen también en la web con la sesión iniciada (Temario → Materiales exclusivos): página, PDF y ficha de repaso
- (11 nov., siguiente versión) «Sugerir una mejora» en cada tema y en su ficha de repaso: si algo no se entiende, falta o está mal, lo dices en dos toques (qué le pasa, dónde y qué cambiarías) y le llega al autor de forma anónima; en Más → Mis sugerencias ves en qué ha quedado cada una y cuántos materiales has ayudado a mejorar, y Hoy te avisa cuando te contestan. Con EconomIA, tu IA lo propone sola cuando una duda destapa algo que el tema no aclara, y tú lo envías con un botón
- (10 nov., 1.25.0) Más → Cuenta → «Borrar mis datos de una oposición»: eliges TCEE o DCE y se borra todo lo tuyo de esa (nube y dispositivo), sin tocar la otra ni cerrar la sesión; hay que escribir «BORRAR DCE» para confirmarlo. También se lo puedes pedir a tu IA con el conector
- (30 oct., siguiente versión) Las clases pedidas al preparador llevan presencial u online y los temas que quieres cantar (desde el conector de IA, EconomIA); al aceptarlas, la clase sale ya con ellos y el preparador los ve en la reserva
- (30 oct., siguiente versión) También desde la app: al pedir clase (Reservar o «Con quién» en Nuevo cante) eliges presencial u online y los temas, que por defecto son los de tu cronograma para ese día
- (30 oct., siguiente versión) El cronómetro de la clase con el preparador cuenta hacia delante desde 0 (o cuenta atrás, si lo prefieres), se pone a pantalla completa y tiene todo lo del de Cantar: más o menos minutos, pasar a exponer, reiniciar, pasar al tema siguiente, avisos y la pantalla encendida mientras corre
- (30 oct., siguiente versión) Más → EconomIA: tu IA (Claude, Le Chat, ChatGPT o Gemini) como equipo de preparación, con el conector de la app: cómo se añade, «Exportar mis datos para la IA» si no usas el conector y «Desconectar la IA»
- (30 oct., siguiente versión) Transcribir el cante: en Cantar, «Transcribir» pasa a texto lo que dices, con una marca por minuto; se queda en tu móvil, se guarda con el cante en el diario y «Enviar a la IA» saca el fichero para que tu IA lo corrija
- (30 oct., siguiente versión) La pizarra se graba con el cante: con el cronómetro en marcha, Cantar apunta el minuto en que dibujas cada cosa; se guarda con el cante en el diario (solo en tu móvil) y «Enviar a la IA» manda juntos la transcripción y la pizarra en PDF, una página por minuto, para que tu IA corrija también los gráficos y las fórmulas
- (30 oct., siguiente versión) Los informes de corrección que guarda tu IA salen en el cante del diario (quién lo escribió, la valoración y el informe entero), y tu preparador los lee en la ficha de la clase

## Publicado el 29 oct. 2026 (1.22.0 en producción)

Novedad en `novedades.json`: «Versión 1.22.0 de la app en Google Play: autoevaluación de los 15 temas revisados, cuadro de coyuntura que se actualiza solo, cuántos fallan cada pregunta del test, buscador por epígrafes dentro de los temas, grabaciones unidas al diario, esquema con huecos, reto diario anónimo y, en DCE, el cronograma por fases del primer ejercicio». Resumía:

- (28 oct., siguiente versión) Reto diario: si lo activas en Ajustes, al terminar el test diario ves cuántos lo han hecho hoy, la nota media y tu posición (solo cifras, nunca nombres); y cualquier resultado se puede compartir como imagen
- (28 oct., siguiente versión) Si tu móvil pierde la sesión al cerrar la app del todo (le pasaba a Víctor en un Galaxy S24), o la cierra en pleno uso, la app vuelve a entrar sola con tu cuenta de Google; «Cerrar sesión» sigue siendo la única forma de salir
- (28 oct., siguiente versión) DCE: la organización del temario de Manuel (bloques con colores y esquemas del 1.º y del 3.º) y el cronograma por fases del 1.er ejercicio. La primera vuelta, después simulacros escritos de 3 horas como en el examen y, al final, la revisión de los temas flojos. Cada tema escrito se apunta como bien, regular o mal
- (29 oct., 1.22.0) Autoevalúate: en los 15 temas revisados con ficha de repaso, 24 preguntas cortas (conceptos, fórmulas, qué predice cada modelo y verdadero o falso) para responder de memoria, con repaso espaciado
- (29 oct., 1.22.0) Cuadro de coyuntura de España para el dictamen (Organización y junto a la guía del dictamen): PIB, inflación, paro, déficit, deuda, cuenta corriente, bono, tipos del BCE, euríbor y dólar, con la zona del euro al lado, el siguiente dato y «Tápalo y adivina»; se actualiza solo cada día
- (29 oct., 1.22.0) El test dice cuántos fallan cada pregunta (con los tests de todos, sin nombres), «Las que más falla todo el mundo» en Estadísticas, por tema, y el modo «Puntos flojos · los de todos»; el simulador de la web también lo enseña y guarda el detalle de cada test
- (29 oct., 1.22.0) El buscador del temario busca también dentro de los temas, en sus epígrafes, y abre el PDF en la página
- (29 oct., 1.22.0) Mis grabaciones: cada grabación de Cantar queda unida a su cante del diario; se escucha, se manda al preparador por WhatsApp o se borra (solo en el móvil)
- (29 oct., 1.22.0) Esquema con huecos (apartados tapados que hay que adivinar) y deberes aunque no haya otra clase programada («para la próxima clase»)

## Publicado el 29 oct. 2026 (1.21.0 en producción)

Novedad en `novedades.json`: «Versión 1.21.0 de la app en Google Play: explicación de las 1004 preguntas del test, test que aprende de tus fallos, «Hoy te toca» con racha opcional, esquema a ciegas con lista de control, guía del dictamen y temas por ejercicios; para el preparador, invitación de un toque, deberes, valoración por criterios y temas por WhatsApp a los alumnos sin app». Resumía lo acumulado del 24 al 28 oct. (1.20.3 a 1.21.0):

- (24 oct.) «¿Por qué?» en la revisión del test: las 1004 preguntas oficiales tienen explicación de la respuesta correcta y de por qué falla cada opción, con el tema donde se estudia y, en más de 200, un gráfico que se amplía al tocarlo; y «Reportar respuesta» para avisar de un error
- (25 oct.) Al entrar con tu cuenta en otro móvil o en el navegador, la app recuerda tu oposición y tu papel y no vuelve a preguntarlos
- (26 oct.) La app se llama «Oposición TCEE · DCE» también en el móvil, para encontrarla en el buscador, y tiene una animación de arranque nueva
- (26 oct.) Si la instalaste con el fichero descargado de la web, la app te lleva a Google Play para actualizarla desde allí; desde entonces se actualiza sola
- (26 oct., 1.20.4) Una sola vez, cuando ya le has sacado partido a la app, te pide una valoración en Google Play o una sugerencia por correo
- (27 oct., 1.20.5) La versión de Google Play vuelve a dejar iniciar sesión con Google (desde la 1.19.2 no conectaba con la cuenta)
- (27 oct., 1.20.4) Estudiar → Temas, por ejercicios: una tarjeta por ejercicio con su progreso; el primero con el simulador de test, el test diario, los exámenes oficiales y la guía del dictamen de coyuntura revisada (con su resumen de repaso), que antes no estaba en la app
- (27 oct., 1.20.4) Los temas revisados y la guía del dictamen son materiales exclusivos de uso personal: llevan su aviso, se leen dentro de la app y el temario tiene el filtro «Materiales exclusivos»
- (28 oct., siguiente versión) Deberes para la próxima clase: el preparador los deja (estudiar un tema, esquema a ciegas, cantar por tu cuenta, un test o lo que sea) y tú los ves en Hoy y en la clase; los cuatro primeros se tachan solos cuando los haces, y el preparador ve lo que traes hecho
- (28 oct., siguiente versión) Valorar por criterios (opcional, en Ajustes): esquema, rigor, tiempo, exposición y actualidad (o los tuyos) además de las estrellas de siempre, con la evolución de cada criterio en la ficha del alumno y en el diario; y el tiempo del cante se puede escribir en minutos y segundos
- (28 oct., siguiente versión) Esquema a ciegas: saca el esquema de un tema de memoria con el tiempo del examen y compáralo apartado a apartado con el del tema (desde Cantar, la ficha del tema o Hoy); y al valorar cualquier cante, la lista de control de los apartados tocados, que el preparador puede ir marcando en clase mientras escucha; la agenda del tema dice qué apartados no cuentas nunca
- (28 oct., siguiente versión) Si tienes preparador, puedes elegir en «Qué ven tus preparadores» de qué actividad tuya recibe avisos (los temas que fijas para una clase, un cante por tu cuenta, temas marcados como estudiados, una semana sin usar la app o la cercanía del examen); todo apagado hasta que lo actives, y él elige a su vez cuáles quiere
- (28 oct., siguiente versión) «Hoy te toca»: lo primero de Hoy es qué hacer ahora (test diario, repaso, los temas de la semana, el tema de la próxima clase) y, si lo activas en Ajustes, el tema que llevas más tiempo sin repasar y una racha de días seguidos que admite un día suelto de descanso y se puede congelar cuando descansas más
- (28 oct., siguiente versión) El test aprende de tus fallos: «Repetir las falladas» al terminar, revisar cualquier test antiguo del historial, acierto por tema y las preguntas que más fallas en Estadísticas, el modo «Mis puntos flojos» (preguntas de los temas que peor llevas y de los que más caen), el modo estudio (cada pregunta corregida al responder, con su explicación) y guardar un test a medias para seguirlo luego; el repaso Leitner vence también por días y el recordatorio diario lo dice
- (28 oct., siguiente versión) Si preparas a opositores, ya puedes mandar los temas antes de la clase también a los alumnos que no tienen la app: a la hora elegida la app te avisa y se los envías por WhatsApp con un toque
- (28 oct., siguiente versión) Invitación de un toque: el preparador manda un enlace (o enseña un QR en clase) y el alumno instala la app y conecta con él sin teclear ningún código; al preparador, la petición le sale en Hoy para aceptarla
- (26 oct., 1.20.4) Los temas de tus clases con el preparador se fijan solos desde tu cronograma, de modo que él ve la misma lista aunque no compartas el cronograma; y mientras no haya temas fijados, el preparador puede mandarte o sortear cualquiera de los que llevas

## Publicado el 26 oct. 2026 (salida en Google Play, 1.19.2)

Novedad en `novedades.json`: «La app ya está en Google Play, para TCEE y DCE: agenda de cantes y clases con tu preparador, cronograma, pizarra compartida, test con los exámenes oficiales, temario y avisos del proceso selectivo». Resumía lo acumulado del 19 al 23 oct. (pizarra con Apple Pencil, texto y PDF; notas del preparador; tabla de preguntas por tema; pedir clase; cronómetro por oposición; valoración por tema; no cantar un tema; sincronizar a mano; esquema del tema; estadísticas opcionales; Google Calendar para todos; subpestañas como botones; temas de cada clase iguales en las dos apps).
