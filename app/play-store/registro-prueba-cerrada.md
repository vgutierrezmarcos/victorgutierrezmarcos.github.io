# Registro de la prueba cerrada (Google Play)

Sirve para contestar el formulario **«Solicitar acceso a producción»** cuando se cumplan los 14 días con al menos 12 testers. Se va completando con cada versión, cada problema que aparezca y cada comentario de los testers.

## Datos de la prueba

| Dato | Valor |
|---|---|
| Pista | Prueba cerrada |
| Primera versión en la pista | 1.14.1 (22), aprobada el 7-8 oct. 2026; después 1.14.2 (23) y 1.15.0 (24) el 8 oct. y 1.15.1 (25) el 9 oct. |
| Día en que se llegó a 12 testers apuntados | 8 oct. 2026, 11:30 |
| Día en que se pueden pedir producción | 22 oct. 2026 (se solicitará el 21 o el 22; comprobar en el Panel de Play Console) |
| Testers apuntados | 12 el 8 oct.; 14-15 el 9 oct. (seguir sumando) |
| Cómo se reclutaron | Opositores y preparadores de TCEE y DCE del entorno de los dos autores (Víctor Gutiérrez Marcos, TCEE; Manuel Cabado García, DCE). |
| Cómo se recogen los comentarios | En persona y por WhatsApp a los autores; se anotan aquí con fecha. |
| Web pública | `https://www.victorgutierrezmarcos.es/app/` (desde el 8 oct. 2026), con la política de privacidad y las condiciones de uso |

## Pendiente

- Formulario **Seguridad de los datos**: se dejó como estaba (6 oct. 2026). Antes de pedir producción, revisarlo con lo nuevo: en *Información personal → Otra información*, la modalidad, la ciudad y la disponibilidad de los preparadores y lo que publica un opositor que busca preparador (ejercicio, modalidad, ciudad, tramos, nota; sin nombre ni teléfono); en *Actividad en la app → Otro contenido generado por el usuario*, las notas, los materiales (enlaces) y los trazos de la pizarra; en *Calendario*, el acceso a Google Calendar (opcional, solo preparadores).
- Cuando Google verifique el permiso de Calendar, abrirlo a todos los preparadores (hoy, lista de prueba).

## Versiones subidas

| Fecha | Versión | Qué traía |
|---|---|---|
| 6 oct. 2026 | 1.14.0 (21) | Primera versión en Play (no llegó a publicarse: ver 7 oct.): TCEE y DCE, papel de opositor o preparador, cinco pestañas, cronograma propio, preparadores y clases sueltas; novedades del proceso selectivo, cronómetro con el tiempo del examen y compartido, tema antes de la clase, mapa de calor, widget. |
| 7 oct. 2026 | 1.14.1 (22) | Lo de la 1.14.0 más el aviso de app no oficial con enlaces a las fuentes oficiales (lo que pidió Google). |
| 8 oct. 2026 | 1.14.2 (23) | Botón de oposición en la cabecera, alta de preparador directa, Ajustes en pantallas estrechas, cronómetro, preparador sin estudio personal, icono de notificaciones, foto de Google y Google Calendar (en pruebas). |
| 8 oct. 2026 | 1.15.0 (24) | Mejoras pedidas por los testers: permisos de avisos al abrir, cambios de clase en tiempo real con aviso, notificaciones que abren la clase, dos temas por clase, clases de 2 h, ficha de la clase editable, Meet o Teams, materiales del preparador, pizarra compartida, orden del directorio, sección Cantes más clara, actualizaciones desde Play. |
| 9 oct. 2026 | 1.15.1 (25) | Buscar preparador (el preparador dice si admite alumnos; el opositor publica lo que busca sin su nombre y escribe él a quien le interese; «encaja» en palabras, nunca una nota), fichas de alumno que se unen, temas en clases sueltas, «Empezar el esquema» arranca el cronómetro con cuenta atrás en el aviso (también al preparador), un tema por clase por defecto en TCEE, pizarra: trazo donde se toca, colores y borrador. |
| (pendiente) | 1.15.3 (27) | La 1.15.1 más: en la ficha de la clase lo principal es mandar los temas antes (desaparece «Sortear y cantar»); el botón «Ver» de algunos avisos abría una página «Not found» sin salida (arreglado; cualquier ruta desconocida lleva a Hoy). (La 1.15.2 (26) no se subió.) |
| (pendiente) | 1.15.4 (28) | La 1.15.3 más: clases sueltas que no convierten al alumno en tuyo y a las que siempre se pueden mandar temas, código de preparador fijo, solicitudes de verificación que no fallan, avisos en la versión web y protección frente a versiones antiguas. |
| (pendiente) | 1.15.5 (29) | La 1.15.4 más: «Más → Ayuda en vídeo» y un botón ▶ en la cabecera de las pantallas principales, que abren vídeos de menos de un minuto (cómo se reserva una clase, la clase suelta, el cronograma, la clase con el preparador…). |
| (pendiente) | 1.15.6 (30) | La 1.15.5 más: cancelar y borrar clases desde los dos lados, quitar relaciones, cantar los dos temas mandados sin elegir y «Simulación de examen real», cronómetro del alumno visible para el preparador (con notificación) y pizarra con cualquier color. |
| (pendiente) | 1.15.7 (31) | La 1.15.6 más: avisos al momento con la app abierta y los temas a su hora exacta con ella cerrada, aviso cuando el otro rompe la relación, eliminar páginas de la pizarra, cronómetro compartido en la ficha de la clase y clases de 2 h en todas partes. |
| (pendiente) | 1.15.8 (32) | La 1.15.7 más: calculadora «Probabilidad de aprobar el test» (al azar, pregunta a pregunta con dudas entre 2, 3…, con los temas estudiados y qué estudiar después), lo que cae de cada tema en el test (ficha del tema, mapa de calor, simulador y cronograma) y 8 exámenes oficiales más en el simulador (2002-2009). |

## Cambios durante la prueba (problema o comentario → qué se hizo)

### 6 oct. 2026
- **No se podía iniciar sesión con Google en la versión instalada desde Play** (error 10). Al publicar, Google vuelve a firmar la app con su propia clave, y su huella no estaba registrada en Firebase. Se añadieron las huellas SHA-1 y SHA-256 de la clave de firma de Play, y desde entonces funciona.
- **La hora, la batería y los botones del sistema no se leían en modo oscuro.** Ahora salen en blanco o en negro según el fondo.
- **Mapa de calor:** la vista de cantes solo aparece en los ejercicios que se cantan y la de test solo en el 3.º de TCEE.
- **Preparadores:** pueden indicar que preparan el 1.er ejercicio (la coyuntura en TCEE y el escrito en DCE).
- **Tema antes de la clase:** se aclaró que la antelación de los ajustes es solo la que se propone al programar el envío. Por defecto son 45 min (lo que dura el esquema de dos temas), con opciones de 22 min 30 s, 1 h u otra.
- **Foto de perfil de Google:** ahora se muestra al iniciar sesión.
- **Proceso selectivo:** si aún no hay datos, se avisa y se enlaza a la sección de empleo del Ministerio, en lugar de dar un error de conexión.
- **Probabilidades:** lo que suma cada tema estudiado pasa a mostrarse en puntos porcentuales, y al final hay un resumen con la probabilidad de cada ejercicio y la total.
- **Funciones nuevas de la 1.14.0** a partir de las peticiones de opositores y preparadores:
  - novedades del proceso selectivo con aviso;
  - cronómetro con el tiempo de esquema del examen;
  - cronómetro compartido alumno–preparador y pantalla grande;
  - el preparador puede mandar el tema antes de la clase;
  - recordatorios de clases para el preparador;
  - mapa de calor del temario;
  - widget de Android;
  - modalidad y ciudad en el directorio de preparadores.

### 7 oct. 2026
- **Google rechazó la versión por la política de afirmaciones engañosas**: la app muestra información de la Administración (proceso selectivo, preguntas de exámenes) y la ficha no enlazaba a las fuentes oficiales ni decía que la app no es oficial. Se añadió a la descripción un aviso de «app no oficial» y los enlaces al Ministerio (empleo y página de cada proceso) y al BOE; y en la app (1.14.1), el mismo aviso con enlaces en *Proceso selectivo* y en *Más → Acerca de*.

### 8 oct. 2026 (para la 1.14.2)
- **Cambiar de oposición era poco visible** (estaba en Más → Ajustes): ahora hay un botón arriba a la izquierda en la cabecera de las cinco pestañas.
- **Quien elegía «Preparo a opositores» no sabía qué hacer después:** ahora va directo a pedir la verificación, y se aclara que basta con poner el nombre y que un compañero verificado le verifica desde la app; lo demás es opcional.
- **En pantallas estrechas, «Tu papel» y «Modo» de Ajustes se montaban** sobre los botones: ahora los botones van debajo del título.
- **Cronómetro:** con un tema el esquema daba 23 min en vez de 22'30"; ahora es exacto. Por petición de opositores, cuenta **hacia delante por defecto** (con opción de cuenta atrás) y sigue contando en rojo si te pasas; al acabar el esquema la exposición espera a que la empieces; la pantalla grande tiene más controles (reiniciar la exposición o todo, ±1 min).
- **Preparadores:** sin las herramientas de estudio personal (marcar estudiados, vueltas, cronograma…), que no usaban; se quedan el temario, los test y las probabilidades.
- **Notificaciones** con el icono de la app (la diana).
- **Foto de perfil de Google:** se quedaba la del primer inicio de sesión; ahora se renueva.
- **Google Calendar y Meet (en pruebas, con unos pocos preparadores):** las clases van al calendario del preparador con su reunión de Meet y la invitación al alumno.

### 8 oct. 2026 (doce sugerencias de los testers, para la 1.15.0)
- **A algunos no les llegaban las notificaciones:** la app nunca pedía el permiso de notificaciones (solo al activar a mano un interruptor), así que en Android 13+ los avisos de clases y del tema no se mostraban. Ahora se pide al abrir la app la primera vez (con la explicación de para qué sirve cada aviso), cada interruptor lo comprueba y, si el sistema lo tiene denegado, lo dice con un botón a los ajustes; en Hoy sale un aviso si están desactivadas.
- **Un cambio de hora o una cancelación no le llegaban al alumno** (ni con «Sincronizar ahora»): la copia a la agenda del alumno se escribía una sola vez y en silencio, y una clase cancelada desaparecía de «Próximos». Ahora el alumno escucha los cambios en tiempo real, las copias que fallan se reintentan y se concilian al sincronizar, la ficha de la clase muestra si ha llegado, las canceladas se ven como tales (con «pedir clase suelta») y llega un aviso «ha movido tu clase» / «ha cancelado tu clase».
- **Las notificaciones no llevaban a ningún sitio:** ahora cada aviso abre su pantalla (la clase, el tablón, la semana, Mi preparador, el test diario) y en Android lleva el botón «Ver».
- **Recordatorio diario:** se explica qué recuerda (el test diario de 10 preguntas) y no llega si el test ya está hecho ese día.
- **Cerca del examen se cantan dos temas:** se pueden mandar y sortear dos temas por clase, elegidos por el preparador o a suerte entre los que lleva el alumno, con opción «uno de cada parte»; el esquema del alumno es el de dos temas, como en el examen. (El 9 oct. se dejó en **un tema por defecto en TCEE** y dos en DCE; el preparador lo cambia en Ajustes y por clase.)
- **Al alumno le salía «Sacar bola y cantar» en una clase del preparador:** ya no; él solo recibe los temas y canta (o cronometra).
- **Duración de las clases:** antes todo partía de 30 min (que era el tiempo de exposición). Ahora una clase dura 2 h por defecto (se cambia en Ajustes y en cada clase) y la exposición por tema va aparte en el cronómetro.
- **No era fácil ver que la clase se edita con el lápiz:** la ficha de la clase cambia al momento día y hora, duración, presencial u online (con crear la reunión de Meet o Teams y pegar el enlace al volver), temas que se cantan y exposición; sigue el «Editar todo».
- **Orden de los preparadores:** primero los del alumno, luego con los que ha tenido clase, luego quienes administran la red y el resto al azar.
- **Cantes más claro:** «Añadir» en la agenda ofrece un cante propio, reservar clase con el preparador, pedir una clase suelta o buscar preparador, sin ir a «Más»; tarjetas de ayuda en cada subpestaña y un icono de ayuda.
- **Compartir materiales:** el preparador comparte enlaces (Drive, PDF, vídeos) con título, nota y tema, para todos sus alumnos o para algunos; al alumno le llega un aviso y los ve en Mi preparador y en el tema.
- **Pizarra compartida:** durante la clase, preparador y alumno dibujan en una pizarra en blanco que se ve en los dos dispositivos al instante (solo se comparte lo dibujado), en el móvil, la tableta o el ordenador.
- **Teams además de Meet:** el preparador elige la videollamada que propone.
- **Actualizaciones:** instalada desde Play, la app ofrece la actualización dentro de la propia app; desde el APK, avisa con una notificación.
- **Google Calendar:** la tarjeta explica por qué no está disponible todavía (cuenta no apuntada en la lista de prueba) y la clase muestra si está en el calendario y el error de Google si lo hay.

### 8 oct. 2026 (para la 1.15.1)
- **Buscar preparador, no solo clases sueltas** (petición del autor): el preparador dice en Ajustes si admite alumnos nuevos (desde cuándo, disponibilidad por tramos de la semana, un mensaje y si deja su WhatsApp), visible solo para opositores, nunca para otros preparadores; el opositor ve quién admite alumnos, ordenado por lo que encaja (ejercicio, online o presencial y ciudad, tramos de la semana) y publica lo que busca **sin su nombre ni su teléfono**; al preparador al que le interese le deja su contacto y es el opositor quien escribe. Sin precios ni intermediación; la conexión en la app sigue siendo con el código. Se decidió que **nadie recibe una nota pública**: «encaja mucho / encaja / encaja poco / no encaja», nunca un número.
- **Alumno duplicado:** un preparador apuntó a mano a un alumno y, cuando este enlazó su app, salía dos veces y en la clase seguía «sin app enlazada». Ahora las dos fichas se unen solas (por correo o nombre) o desde la ficha con «Unir»; las clases pasan a la ficha enlazada.
- **Mandar los temas en una clase suelta:** un preparador que coge una clase suelta pedida desde la app no podía mandarle los temas al alumno (solo a alumnos enlazados). Ahora sí (reglas del servidor ampliadas).
- **«Empezar el esquema» desde el aviso** arranca el cronómetro directamente; el aviso lleva la cuenta atrás del esquema y el preparador recibe el mismo aviso con la misma cuenta atrás a esa hora.
- **Pizarra:** el trazo salía desplazado respecto al dedo (se restaba dos veces el margen); corregido. Se añadieron seis colores y un borrador que quita los trazos que se tocan.
- **Fórmulas del test:** se comprobó que las 599 preguntas (152 con fórmulas) se dibujan bien.

### 9 oct. 2026 (para la 1.15.3)
- **Verificación del permiso de Google Calendar enviada a Google** (marca verificada, permisos, justificación y vídeo de demostración), 9 oct.
- **Google Calendar probado por el autor** (cuenta en la lista de prueba): consentimiento superado (aviso de app no verificada), clase online sin enlace → evento con Meet, invitación al alumno y el enlace en la clase.
- **Ficha de la clase:** el preparador quiere, sobre todo, mandar los temas antes; la sección «Temas antes de la clase» va ahora justo bajo los botones y desaparece «Sortear y cantar» (en clase, «Cantar los temas mandados» o «Cronometrar»).
- **Permiso de Calendar retirado desde la cuenta de Google:** al volver a activar el interruptor, la app usaba el token guardado y Google respondía 401 sin volver a pedir el permiso. Ahora, ante un 401, cierra la sesión de Google de la app, vuelve a entrar y pide el permiso con la ventana de Google; la ficha de la clase lo explica si pasa al sincronizar.
- **Página «Not found» sin salida al tocar «Ver» en un aviso** (clase suelta pedida, reservas, búsquedas): el botón añadía el parámetro de la acción a una ruta sin parámetros y se pedía una ruta inexistente. Arreglado; además, cualquier ruta desconocida lleva a Hoy.

### 9 oct. 2026 (para la 1.15.4)
- **El preparador no podía mandar los temas en una clase suelta** («Alumno sin app enlazada»): una versión antigua de la app (en otro dispositivo o la web guardada en el navegador) tomaba al alumno de la clase suelta por un alumno que había roto el enlace y le quitaba la cuenta. Ahora esas fichas van aparte en la nube (las versiones antiguas no las leen) y la clase recupera sola al alumno desde la clase suelta cogida.
- **Coger una clase suelta convertía al alumno en «mi alumno»**: ya no sale en «Mis alumnos» (solo si escribe el código del preparador); se le siguen mandando temas. Una ficha apuntada a mano con el mismo teléfono ya no se toca.
- **El código del preparador cambiaba** al instalar la app en otro móvil o abrir la web: ahora se recupera el que ya tenía y la reserva es atómica (nunca dos códigos).
- **Solicitudes de verificación**: no se quedan colgadas sin conexión (se envían solas al volver), no se pierde el preparador propio si falla, la pantalla dice si ya estás verificado o tienes una pendiente (y deja cambiarla), y a quien se le retiró la verificación la revisa la administración. Las reglas comprueban cada campo, así que toda solicitud que llega se puede aprobar.
- **Versión web igual que la app**: avisos del navegador con la web abierta (los mismos que en el móvil), «Recargar» cuando hay versión nueva y nunca una versión vieja guardada (se veían las rachas, ya quitadas).
- **Versión mínima**: una versión demasiado antigua deja de sincronizar y pide actualizar (`versionMinima` en `app-config.json`).

### 9 oct. 2026 (para la 1.15.5)
- **Ayuda en vídeo**, para que todo sea fácil de seguir: once vídeos de ayuda, verticales y de menos de un minuto (reservar clase, pedir una clase suelta, conectar con el preparador, buscar preparador, cronograma, la clase con el preparador; y, para preparadores, alta, huecos y reservas, programar una clase y mandar los temas, coger una clase suelta y compartir materiales). Están en la página de la app («Cómo se usa») y la app los abre desde «Más → Ayuda en vídeo» y desde el botón ▶ de cada pantalla.

### 9 oct. 2026 (para la 1.15.6, pruebas de los autores con la app)
- **El alumno no podía cancelar una clase** de su preparador (ni una clase suelta que había pedido): ahora puede («No puedo ir: cancelar la clase»), le llega al preparador cancelada y con aviso, y no se le avisa a él mismo. Las clases canceladas se pueden quitar de la agenda (alumno) o borrar (preparador) con un toque, también desde la lista; lo que quita el alumno ya no le vuelve a aparecer.
- **Quitar relaciones**: el alumno puede dejar de compartir con su preparador cancelando a la vez sus clases pendientes, y quitar a los preparadores que le cogieron clases sueltas (pierden el acceso a esas clases); el preparador puede quitar a un alumno cancelando sus clases pendientes y a los alumnos de clases sueltas. Si el alumno deja de compartir, sus clases pendientes quedan canceladas en la agenda del preparador.
- **Dos temas mandados**: la app preguntaba cuál iba a cantar. Ahora se cantan todos, por orden («Tema 1 de 2», «Pasar al tema 2» al acabar la exposición), y el diario guarda los dos. Nuevo modo **«Simulación de examen real»**: dos bolas de cada parte, el opositor elige una de cada parte y canta las dos con el esquema de las dos.
- **El cronómetro compartido no le salía al preparador**: en una clase se comparte solo; el preparador tiene «Cronometrar» en cualquier clase, ve en la ficha cuánto le queda al alumno y, con la app abierta, una notificación con la cuenta atrás del esquema o de la exposición.
- **Pizarra**: cuatro colores a un toque (azul, negro, rojo, verde) y una paleta con cualquier color; cada trazo guarda su color, así el otro lo ve igual; el aviso «… ha borrado la pizarra» dura unos segundos.

### 9 oct. 2026 (para la 1.15.7)
- **Los avisos tardaban** (clase cancelada, temas): con la app abierta ahora llega todo al momento, en los dos sentidos (el preparador escucha en tiempo real las clases de sus alumnos); el aviso de los temas se programa en el móvil a la hora exacta, aunque la app esté cerrada. Sin servidor, con la app cerrada el resto se comprueba cada 15 minutos (el mínimo de Android): la app lo explica y recomienda abrirla si se espera algo.
- **Aviso cuando el otro rompe la relación**: «X ha dejado de compartir contigo» (al preparador) y «X ya no es tu preparador» (al alumno).
- **Pizarra**: «Vaciar la página» (borra lo escrito) y un botón aparte, «Eliminar la página», que la quita entera.
- **El cronómetro compartido no se veía**: ahora está en la ficha de la clase, a los dos lados, siempre sincronizado (cualquiera lo empieza, lo pausa o pasa a exponer) y avisa si no se puede leer; además, notificación con lo que queda también al alumno cuando lo lleva el preparador.
- **Duración de las clases**: las clases sueltas pedidas desde un cante propio y «Cantar ahora» del preparador salían de 30 min; ahora, 2 h como el resto.

### 9 oct. 2026 (para la 1.15.8)
- **Probabilidad de aprobar el test**: calculadora del primer ejercicio (Organización, Probabilidades y el test): al azar, pregunta a pregunta (las que te sabes, las que dudas entre 2, entre 3…), con tus temas estudiados y tu acierto en los tests, qué estudiar después y cómo te habría ido en 22 exámenes oficiales. Con los avisos de las «Claves para preparar el test». También en la web (oposicion/probabilidad-test.html).
- **Lo que cae en el test**: cada tema muestra qué parte del test suele ser suya y en cuántos exámenes salió (ficha del tema, mapa de calor con la vista «Lo que cae», selección rápida de los temas más preguntados en el simulador y un orden del cronograma que los pone primero).
- **Simulador**: 8 exámenes oficiales más (2002-2009, 361 preguntas) y 89 preguntas reclasificadas de tema tras cruzarlas con la clasificación de otro opositor.

### 10 oct. 2026 (para la 1.15.9)
- **Primeros pasos más claros** (una tester: «nada más entras tienes demasiadas cosas»):
  - En una instalación nueva, una bienvenida con la entrada con Google (se puede saltar) antes de elegir oposición y papel.
  - Una guía de la app con globos sobre las pestañas, distinta para opositor y preparador, que se puede saltar y volver a abrir desde Más → Guía de la app, con enlaces a los vídeos de ayuda.
  - En Hoy, «Para empezar» con los primeros pasos, que se tachan solos.
  - Hoy ya no muestra tarjetas vacías.
  - En Organización, lo menos usado queda plegado en «Más herramientas».
- **Correcciones del test**: notas en las respuestas oficiales desactualizadas o discutibles, y el examen de marzo de 2026 en el simulador.
- **Contenido nuevo sin reiniciar**: el contenido nuevo de la web se ve sin cerrar la app.

### 10 oct. 2026 (para la 1.15.10)
- **Avisos a su hora con la app cerrada**:
  - Al permitir los avisos, la app pide con el diálogo del sistema que la batería no la restrinja.
  - En los móviles con ahorro de batería propio (Xiaomi, Huawei, Honor, Samsung, OPPO, realme, OnePlus, vivo), indica qué tocar y abre esos ajustes.
  - A quien ya tenía la app se le pide una vez.

(Seguir añadiendo aquí, con fecha.)

## Borrador de respuestas para «Solicitar acceso a producción»

El formulario tiene tres bloques. Hay que adaptar los números y nombres al final de la prueba.

**Sobre la prueba cerrada**
- *¿Cómo de fácil fue reclutar testers?* Fácil: la app es para un colectivo concreto (opositores y preparadores de las oposiciones de Técnico Comercial y Economista del Estado y de Diplomado Comercial del Estado) y los testers salieron del entorno de preparación de los dos autores. Se llegó a 12 el primer día (8 oct.) y a 14-15 al día siguiente. [Poner el número final.]
- *Describe la participación de los testers.* Usaron la app a diario para el test, para programar y cronometrar cantes y para conectar alumnos con preparadores (código, clases programadas, temas antes de la clase, clases sueltas, pizarra). Los preparadores probaron el alta, la verificación y la gestión de clases, y uno de los autores probó la integración con Google Calendar. [Añadir lo observado.]
- *Resume los comentarios y cómo los recogiste.* En persona y por WhatsApp a los autores, anotados con fecha en este registro. En la primera semana los testers enviaron doce sugerencias (notificaciones que no llegaban o no abrían nada, cambios de clase que no se veían, duración de las clases, dos temas por clase, materiales, pizarra, Teams, orden del directorio, claridad de la sección Cantes, actualizaciones) y se publicaron tres versiones con ellas en dos días.

**Sobre la app**
- *Público:* opositores y preparadores de TCEE y DCE, mayores de edad.
- *Qué aporta:* reúne en una sola app gratuita y sin anuncios lo que hasta ahora estaba repartido: temario, test oficial, cantes con sorteo y cronómetro, cronograma, probabilidades, seguimiento del proceso selectivo y la relación entre opositor y preparador (incluida la búsqueda de preparador sin intermediarios). Los datos de cada usuario solo los ve él.
- *Instalaciones previstas el primer año:* [estimar: unos pocos cientos; cada convocatoria tiene del orden de cientos de opositores].

**Preparación para producción**
- *¿Qué cambiaste por lo aprendido en la prueba?* Ver «Cambios durante la prueba»: 4 versiones en la pista en una semana con los fallos corregidos (inicio de sesión, permisos de notificaciones, sincronización de clases, navegación desde los avisos) y las funciones pedidas.
- *¿Cómo decidiste que está lista?* Los testers la usan a diario sin errores bloqueantes, los fallos encontrados están corregidos y hay pruebas automáticas (más de 170) y pruebas de las reglas de seguridad de la base de datos (206 casos) que pasan en cada versión; la web pública, la política de privacidad y las condiciones de uso están publicadas.
