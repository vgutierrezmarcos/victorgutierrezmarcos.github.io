# Registro de la prueba cerrada (Google Play)

Sirve para contestar el formulario **«Solicitar acceso a producción»** cuando se cumplan los 14 días con al menos 12 testers. Se va completando con cada versión, cada problema que aparezca y cada comentario de los testers.

## Datos de la prueba

| Dato | Valor |
|---|---|
| Pista | Prueba cerrada |
| Primera versión en la pista | (rellenar: número y fecha) |
| Día en que se llegó a 12 testers apuntados | (rellenar: lo dice el Panel de Play Console) |
| Día en que se pueden pedir producción | (el anterior + 14 días) |
| Testers apuntados | (rellenar) |
| Cómo se reclutaron | (rellenar: opositores y preparadores de TCEE y DCE, conocidos, alumnos de Manuel…) |
| Cómo se recogen los comentarios | (rellenar: WhatsApp, correo de contacto, en persona…) |

## Pendiente

- Formulario **Seguridad de los datos**: se dejó como estaba (6 oct. 2026). Cuando haya que tocarlo por otra cosa, añadir en *Información personal → Otra información* la modalidad y la ciudad de los preparadores, y en *Actividad en la app → Otro contenido generado por el usuario* las notas.

## Versiones subidas

| Fecha | Versión | Qué traía |
|---|---|---|
| (rellenar) | (la primera de la prueba) | Primera versión en Play: TCEE y DCE, papel de opositor o preparador, cinco pestañas, cronograma propio, preparadores y clases sueltas. |
| 7 oct. 2026 | 1.14.1 (22) | Lo de la 1.14.0 (21), que no llegó a publicarse, y el aviso de app no oficial. Ver «Cambios durante la prueba». |
| (al enviarla) | 1.14.2 (23) | Botón de oposición en la cabecera, alta de preparador directa, Ajustes en pantallas estrechas, cronómetro, preparador sin estudio personal, icono de notificaciones, foto de Google y Google Calendar (en pruebas). |

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

### 8 oct. 2026
- **Cambiar de oposición era poco visible** (estaba en Más → Ajustes): ahora hay un botón arriba a la izquierda en la cabecera de las cinco pestañas.
- **Quien elegía «Preparo a opositores» no sabía qué hacer después:** ahora va directo a pedir la verificación, y se aclara que basta con poner el nombre y que un compañero verificado le verifica desde la app; lo demás es opcional.
- **En pantallas estrechas, «Tu papel» y «Modo» de Ajustes se montaban** sobre los botones: ahora los botones van debajo del título.

### 8-9 oct. 2026 (más para la 1.14.2)
- **Cronómetro:** con un tema el esquema daba 23 min en vez de 22'30"; ahora es exacto. Por petición de opositores, cuenta **hacia delante por defecto** (con opción de cuenta atrás) y sigue contando en rojo si te pasas; al acabar el esquema la exposición espera a que la empieces; la pantalla grande tiene más controles (reiniciar la exposición o todo, ±1 min).
- **Preparadores:** sin las herramientas de estudio personal (marcar estudiados, vueltas, cronograma…), que no usaban; se quedan el temario, los test y las probabilidades.
- **Notificaciones** con el icono de la app (la diana).
- **Foto de perfil de Google:** se quedaba la del primer inicio de sesión; ahora se renueva.
- **Google Calendar y Meet (en pruebas, con unos pocos preparadores):** las clases van al calendario del preparador con su reunión de Meet y la invitación al alumno.

(Seguir añadiendo aquí, con fecha.)

## Borrador de respuestas para «Solicitar acceso a producción»

El formulario tiene tres bloques. Hay que adaptar los números y nombres al final de la prueba.

**Sobre la prueba cerrada**
- *¿Cómo de fácil fue reclutar testers?* Fácil: la app es para un colectivo concreto (opositores y preparadores de las oposiciones de Técnico Comercial y Economista del Estado y de Diplomado Comercial del Estado) y los testers salieron de nuestro entorno de preparación. [Añadir número y perfiles.]
- *Describe la participación de los testers.* Usaron la app a diario para el test, para programar y cronometrar cantes y para conectar alumnos con preparadores. Los preparadores probaron el alta, la verificación y la gestión de clases. [Añadir lo observado.]
- *Resume los comentarios y cómo los recogiste.* Por [WhatsApp, correo de contacto o en persona]. Lo principal: el inicio de sesión desde Play, la legibilidad en modo oscuro, ajustes en el mapa de calor, en las probabilidades y en el tema antes de la clase, y peticiones de funciones (proceso selectivo, cronómetro compartido, widget).

**Sobre la app**
- *Público:* opositores y preparadores de TCEE y DCE, mayores de edad.
- *Qué aporta:* reúne en una sola app gratuita y sin anuncios lo que hasta ahora estaba repartido: temario, test oficial, cantes con sorteo y cronómetro, cronograma, probabilidades, seguimiento del proceso selectivo y la relación entre opositor y preparador. Los datos de cada usuario solo los ve él.
- *Instalaciones previstas el primer año:* [estimar: unos pocos cientos; cada convocatoria tiene del orden de cientos de opositores].

**Preparación para producción**
- *¿Qué cambiaste por lo aprendido en la prueba?* Ver «Cambios durante la prueba».
- *¿Cómo decidiste que está lista?* Los testers la usan a diario sin errores bloqueantes, los fallos encontrados están corregidos y hay pruebas automáticas (147) y pruebas de las reglas de seguridad de la base de datos (128 casos) que pasan en cada versión.
