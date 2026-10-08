# Verificación del permiso de Google Calendar (OAuth)

La app pide el permiso **`https://www.googleapis.com/auth/calendar.events`** (ver, crear, cambiar y borrar eventos del calendario del usuario), que Google clasifica como *sensible*. Hasta que Google lo verifique, solo pueden usarlo las cuentas de prueba (lista `pruebasCalendario`) y aparece el aviso «Google no ha verificado esta aplicación». Verificado, se abre a todos poniendo `"calendarioParaTodos": true` en `oposicion/app-config.json`.

Proyecto de Google Cloud: `web-vgm` (número 1092815793613). Cliente OAuth de Android de la app Flutter (paquete `es.victorgutierrezmarcos.tcee_app`).

## Antes de enviar (lista)

1. Google Auth Platform → **Marca**: nombre «Oposición TCEE · DCE», logo, correo de asistencia, página de inicio `https://www.victorgutierrezmarcos.es/app/`, política de privacidad `https://www.victorgutierrezmarcos.es/politica-cookies.html`, condiciones `https://www.victorgutierrezmarcos.es/app/condiciones.html`, dominio autorizado `victorgutierrezmarcos.es`. **Hecho (9 oct. 2026).**
2. Search Console: `victorgutierrezmarcos.es` verificado con la misma cuenta de Google que es propietaria del proyecto (propiedad de dominio). **Hecho.**
3. Google Auth Platform → **Acceso a datos** (permisos): que el único permiso sensible declarado sea `calendar.events` (sin `calendar` completo ni otros). Justificación: la de abajo.
4. Vídeo de demostración en YouTube, **no listado** (oculto, con enlace), con el guion de abajo. Duración: 2-4 minutos.
5. Google Auth Platform → **Centro de verificación** → Enviar a verificación. Google responde por correo (días o semanas); suele pedir aclaraciones: contestar en el mismo hilo.

## Justificación del permiso (en inglés, para el formulario)

**App name:** Oposición TCEE · DCE

**What the app does:** A free, ad-free study companion for candidates preparing the Spanish civil-service exams for *Técnico Comercial y Economista del Estado* (TCEE) and *Diplomado Comercial del Estado* (DCE). Candidates ("students") study the syllabus, take practice tests and rehearse oral presentations ("cantes") with a timer. Tutors ("preparadores") schedule classes with their students inside the app.

**Scope requested:** `https://www.googleapis.com/auth/calendar.events`

**Why the app needs it:** Tutors schedule classes with their students in the app (date, time, duration, online or in person). Tutors asked for those classes to appear automatically in their own Google Calendar and for their students to receive the calendar invitation, so they do not have to copy every class by hand. The feature is optional: it is off by default and the tutor turns it on in Settings → "My classes in Google Calendar". Only tutors ever see this option; students never connect their calendar.

**How the scope is used (and nothing else):**
- When the tutor saves a class, the app **creates** one event in the tutor's primary calendar (title "Clase de TCEE/DCE: tutor and student", start and end time, place or video-call link, the topics to prepare, and the student as an attendee if the tutor has the student's e-mail). If the class is online and has no link, the app asks Google Calendar to add a Google Meet link and shows it in the class.
- When the tutor moves a class, the app **updates** that same event; when the tutor cancels or deletes the class, the app **deletes** that event. The app stores the event id with the class to do this.
- The app **never reads** other events of the calendar, never lists the calendar, never creates or deletes calendars, and does not access any calendar of the student. The narrower scope `calendar.events` is the minimum that allows creating, updating and deleting the events the app itself creates and adding a Meet conference to them. The `calendar.app.created` scope was considered, but it does not allow inviting attendees or adding Meet conferences, which are the two things tutors asked for.

**Data handling:** Calendar data is used only on the user's device, at the moment the class is saved, to call the Google Calendar API over HTTPS. The only values the app keeps are the event id and the Meet link of each class, stored with that class in the user's own data (Firestore, under the user's account; Firestore security rules restrict access to the owner and the student of that class). No calendar data is sent to any other third party, used for advertising, sold, or used to train models. The user can disconnect at any time from the same setting; the app then stops touching the calendar and the token is revoked. Privacy policy: https://www.victorgutierrezmarcos.es/politica-cookies.html (section on the app and Google Calendar).

**Where the user grants access:** Settings → "Preparador" → "Mis clases en Google Calendar" (a switch). The Google consent screen is shown at that moment, with the single `calendar.events` scope.

## Guion del vídeo (YouTube, no listado)

Grabar la pantalla del móvil (o la del ordenador con la versión web, `https://www.victorgutierrezmarcos.es/app/abrir/`) con una cuenta de preparador verificado que esté en la lista de prueba. Narración o rótulos en inglés (basta con rótulos). No enseñar datos reales de alumnos: usa un alumno de prueba con un correo tuyo.

1. **Portada (10 s).** Rótulo: *"Oposición TCEE · DCE — Google Calendar integration demo. Project: web-vgm (1092815793613). Scope: calendar.events."* Mostrar el icono y el nombre de la app en el móvil.
2. **Quién la usa (15 s).** Abrir la app como preparador: pestaña *Cantes* → *Clases* con la semana. Rótulo: *"Tutors schedule classes with their students in the app."*
3. **Dónde se activa (30 s).** *Más → Preparador → Ajustes* → sección *Google Calendar* → interruptor *"Mis clases en Google Calendar"*. Rótulo: *"The feature is optional and off by default. The tutor turns it on in Settings."* Activarlo: aparece la pantalla de consentimiento de Google. Mostrarla entera, despacio: el nombre de la app, el único permiso pedido («Ver y editar eventos en todos tus calendarios» = `calendar.events`), y aceptar. Rótulo: *"Only the calendar.events scope is requested."*
4. **Crear (40 s).** Volver a *Clases* → nueva clase con el alumno de prueba, online, enlace vacío, guardar. Abrir Google Calendar (app o web) en la misma cuenta: el evento está, con la hora, el alumno invitado y el enlace de Meet. Volver a la app: en la ficha de la clase, el enlace de Meet y la fila *"Google Calendar: en tu calendario"*. Rótulo: *"Saving a class creates one event in the tutor's calendar, invites the student and adds a Meet link."*
5. **Cambiar (25 s).** En la ficha, *Cambiar hora* → otra hora. En Google Calendar, el evento se ha movido. Rótulo: *"Moving the class updates the same event."*
6. **Cancelar (20 s).** *Cancelar* la clase. En Google Calendar, el evento ha desaparecido. Rótulo: *"Cancelling the class deletes the event. The app never reads or lists other events."*
7. **Desconectar (15 s).** Volver a *Ajustes* y apagar el interruptor. Rótulo: *"The tutor can disconnect at any time."*
8. **Cierre (10 s).** Rótulo con la política de privacidad: *https://www.victorgutierrezmarcos.es/politica-cookies.html*.

Consejos: grabar en horizontal si es con el ordenador, sin música, sin cortes bruscos; que se lea bien la pantalla de consentimiento (es lo que más miran). Subir a YouTube como **No listado** y pegar el enlace en el formulario.

## Qué contestar si Google pide más

- *"Why not `calendar.app.created`?"* → Because that scope cannot add attendees (the student's invitation) nor a Google Meet conference, both of which are the purpose of the feature.
- *"Does the app read the user's calendar?"* → No. It only creates, updates and deletes the events it created itself, identified by the event id it stored.
- *"Where is calendar data stored?"* → Only the event id and the Meet link, with the class, in the user's own Firestore data; nothing else is stored or shared.
- *"Is the app published?"* → Google Play (closed testing until production), web version at https://www.victorgutierrezmarcos.es/app/abrir/, public page https://www.victorgutierrezmarcos.es/app/.
