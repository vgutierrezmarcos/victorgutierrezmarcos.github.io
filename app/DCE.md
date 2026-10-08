# DCE en la app: guía para la web de Manuel

La app «Oposición TCEE · DCE» sirve a dos oposiciones independientes. Cada usuario elige la suya al abrirla, y su papel en ella (opositor o preparador); las dos cosas se cambian en *Más → Ajustes*, y cada oposición tiene su contenido, los datos de sus opositores y su propia red de preparadores. La app es una sola, para no duplicar nada: la versión para Android, la del navegador ([victorgutierrezmarcos.es/app/abrir/](https://www.victorgutierrezmarcos.es/app/abrir/)) y su página ([victorgutierrezmarcos.es/app/](https://www.victorgutierrezmarcos.es/app/)). **El contenido de DCE lo descarga de la web de Manuel, [manuelcabadogarcia.es](https://manuelcabadogarcia.es)**, así que actualizar su web actualiza la app sin publicar una versión nueva.

**Aspecto**: con DCE elegida, la app usa los colores y la tipografía de su web: granate `#7a1f4b`, crema `#f7f4ec` y azul `#234a6b` (en oscuro, fondo `#1e1d1b` y verde menta `#3ee6a8`), con Latin Modern Roman (`PaletaMarca.dce` en `lib/theme/app_theme.dart`). El logo es la diana partida: la mitad izquierda con los colores de TCEE y la derecha con los de DCE.

**Temas en la web**: los apuntes de Manuel son páginas web, no PDF. La ficha del tema muestra «Leer el tema», que abre la página dentro de la app (`Tema.esPaginaWeb`).

Desarrolladores: Víctor Gutiérrez Marcos (TCEE) y Manuel Cabado García (DCE).

## El examen de DCE en la app

Según la convocatoria de la OEP 2025 ([BOE-A-2025-26896](https://www.boe.es/diario_boe/txt.php?id=BOE-A-2025-26896)). Está en `lib/data/models/oposicion.dart` (`Oposiciones.dce`):

| Ejercicio | Qué es | En la app |
|---|---|---|
| 1.º | Escrito: dos temas, uno de cada par extraído de cada parte (A, Economía española, 18 temas; B, Economía pública, políticas comunitarias e instituciones multilaterales, 18) | Sorteo y probabilidad (2 temas por parte), cronograma |
| 2.º | Idiomas | Solo la fecha |
| 3.º | Oral: dos temas, uno de cada par de cada parte (A, Microeconomía y economía del sector público, 22; B, Macroeconomía y economía internacional, 22). 30 min de preparación y 40 de exposición | Cantes, sorteo, probabilidad, cronograma, preparadores y sustituciones |
| 4.º | Escrito: dos temas, uno de cada par de cada parte (A, Técnicas comerciales y marketing internacional, 10; B, Organización del Estado, 9) y ocho preguntas prácticas | Sorteo y probabilidad (2 temas por parte), cronograma |

La probabilidad de aprobar se calcula como en el Excel de organización de TCEE: en cada parte, la de saberse al menos uno de los dos temas del par, `x/N + (N−x)/N · x/(N−1)`, y en cada ejercicio, el producto de sus partes. Da por hechos los idiomas y las preguntas prácticas del 4.º.

**DCE no tiene test**, pero la app deja practicar el de TCEE de forma voluntaria (con un aviso que lo explica). Los resultados se guardan en el historial de DCE, no en el de TCEE.

## Qué tiene que publicar la web de DCE

Ya están generados en [`para-manuel/`](para-manuel/), con instrucciones para él en [`para-manuel/LEEME.md`](para-manuel/LEEME.md): copiar la carpeta `oposicion/` a su web y añadirla a `resources` de su `_quarto.yml`. El temario se genera con `python3 scripts/generar-temario-dce.py` (títulos del programa oficial del BOE y enlaces de los temas que ya ha publicado, sacados de su «Índice de temas»).


Con el mismo formato que la web de TCEE, en la carpeta `/oposicion/` de su web (se puede cambiar con `rutaContenido`):

| Fichero | Para qué | Cómo se hace en TCEE |
|---|---|---|
| `oposicion/temario/temario.json` | Ejercicios, partes, temas y enlaces a los PDF | `node build-app-data.js` |
| `oposicion/organizacion/estructura_temario.json` | Bloques con colores, esquemas y conexiones (opcional: sin él, la app funciona sin colores ni esquemas) | `python3 scripts/extraer-estructura-temario.py` a partir del PowerPoint |
| `oposicion/enlaces.json` | Enlaces útiles (opcional) | `node build-app-data.js` |
| `oposicion/app-config.json` | Contacto, avisos y, si hiciera falta, otras reglas de sorteo (`sorteo`) sin publicar la app | A mano |
| `oposicion/organizacion/como_cantar_un_tema.pdf` | Ayuda de la pantalla Cantar (opcional) | — |

Los **códigos de tema** siguen la forma `ejercicio.parte.número`, con los ejercicios de DCE: `1.A.1`–`1.A.18`, `1.B.1`–`1.B.18`, `3.A.1`–`3.A.22`, `3.B.1`–`3.B.22`, `4.A.1`–`4.A.10` y `4.B.1`–`4.B.9`. Pueden coincidir con códigos de TCEE: los datos de cada oposición van aparte.

GitHub Pages permite que la app pida estos ficheros desde otro dominio, así que no hay que configurar nada más.

## Inicio de sesión e historial (mismo Firebase)

La app y las dos webs usan el mismo proyecto de Firebase (`web-vgm`), para que haya un solo inicio de sesión.

1. Víctor da acceso a Manuel al proyecto en la consola de Firebase y añade el dominio de su web en *Authentication → Settings → Authorized domains*.
2. La web de DCE usa el mismo `firebase-config.js`, pero con `const OPOSICION_WEB = 'dce';`. Así su simulador y su cuenta guardan en `users/{uid}/oposiciones/dce/…` (con `docUsuario(db, uid)`), sin mezclarse con TCEE.

## Administrador de la red de preparadores de DCE

Cada oposición tiene su red: un preparador verificado en TCEE no lo está en DCE, y quien prepare las dos tiene que verificarse en cada una. Manuel es el administrador de DCE y Víctor, el de TCEE.

- En la consola de Firestore, crear el documento `oposiciones/dce/admins/{correo de Google de Manuel}` (con cualquier campo, p. ej. `desde: "consola"`).
- Después, en la app: *Más → Ajustes → Oposición → DCE* (le aparece por ser administrador, aunque no esté lanzada), *Más → Ajustes → Tu papel → Preparador* y *Más → Preparador → Verificarme*.

Víctor es además **administrador general**: su documento `admins/{…}` de la raíz lleva el campo `general: true`, y con él administra también la red de DCE.

Las reglas (`firestore.rules`, generadas con `tool/reglas/generar.py`) ya separan las dos redes y sus administradores.

## Enlazar la app desde su web

- Página de la app: `https://www.victorgutierrezmarcos.es/app/`
- App en el navegador: `https://www.victorgutierrezmarcos.es/app/abrir/`
- Descarga para Android: la `urlApk` de `https://www.victorgutierrezmarcos.es/oposicion/app-config.json` (o copiar `app-banner.js`, que la rellena sola).

## Lanzamiento: 12 de octubre de 2026

El día que manuelcabadogarcia.es se hace público. Google Play aún no estará en producción (prueba cerrada de 14 días), así que en Android se descarga el **APK universal firmado por Google** (Play Console → Explorador de App Bundle → versión 23, la 1.14.2): tiene la misma firma que la de Play y, cuando salga allí, se pasa sin desinstalar. iPhone y ordenador, por el navegador (`app/instalar.html`).

**Hecho antes (7 oct.):** rosetones en todas las páginas, aviso de la app oculto en la portada y en /oposicion de `main` (sin `app-banner.js`), `oposicion/proceso.json` y su workflow en `main`, reglas probadas (128 casos), versión web 1.14.2 en `app/abrir/`, textos de instalación y `versionActual: "1.14.2"` en `dce`.

**Pendiente antes del día 12:**
- [x] Víctor: subir la 1.14.2 (23) a la prueba cerrada (8 oct.) y preparar Firebase (reglas nuevas y `pruebasCalendario`).
- [x] Víctor: comprobar `general: true` en su documento de `admins` (8 oct.).
- [x] Víctor: descargar el **APK universal firmado** de la versión 23 (8 oct.). Comprobado: 1.14.2 (23), firmado por Google (SHA-1 `11:1D:E2:24:6D:64:C0:62:E9:20:37:DD:1D:42:C2:6A:33:4C:3D:88`). Guardado en el Escritorio como `oposicion-tcee-1.14.2-google.apk`.
- [x] Víctor: probar la 1.14.2 en el móvil (8 oct.): va bien.
- [ ] Víctor: probar **Google Calendar** (ver abajo, «Google Calendar y Meet»): la tarjeta dice «Todavía en pruebas: tu cuenta no está en la lista de prueba» → falta el documento `pruebasCalendario/{tu Gmail en minúsculas}` en la raíz de Firestore (TCEE).
- [ ] Manuel (se lo ha dicho Víctor; lo lleva él): su web pública con `oposicion/temario/temario.json`, `app-config.json` y `enlaces.json`; `manuelcabadogarcia.es` en Firebase → Authentication → Dominios autorizados; su administrador en `oposiciones/dce/admins/{su Gmail}`.
- [x] 12 testers apuntados a la prueba cerrada desde el 8 oct. a las 11:30 (enlace: `https://play.google.com/apps/testing/es.victorgutierrezmarcos.tcee_app`). Conviene llegar a 15-20 por si alguien se sale.

**Lanzado el 8 oct. (18:50), antes de lo previsto, a petición de Víctor:** `dce` fusionada con `main` y publicada (`484cae3`), APK 1.14.2 firmado por Google en `app-latest`, versión web 1.15.1 en `/app/abrir/`, política y condiciones públicas. Por decisión de Víctor, **la portada y /oposicion no enlazan a la app** (sin `app-banner.js`; la app se llega por `/app/` y por la web de Manuel). Los pasos de abajo quedan como referencia para futuras publicaciones.

**El día de publicar (unos 20 minutos):**
1. Comprobar que la web de Manuel es pública y sirve `temario.json` (si cambió el temario, regenerar con `scripts/generar-temario-dce.py`).
2. Fusionar `origin/main` en `dce` (trae los `proceso.json` automáticos; en portada, /oposicion y estilos se queda lo de `dce`) y pasar `dart analyze` y `flutter test`.
3. Subir el APK de Google (Escritorio, `oposicion-tcee-1.14.2-google.apk`, renombrado a `oposicion-tcee.apk`): `gh release upload app-latest oposicion-tcee.apk --clobber`.
4. Publicar: `git push origin dce:main` (sin forzar; hace falta una cuenta con el permiso `workflow`).
5. Comprobar en vivo: portada y /oposicion con el aviso, /app/, /app/instalar.html, /app/abrir/ en 1.14.2, `proceso.json`, la descarga del APK.
6. Si algo sale mal: `git revert -m 1 <fusión>` y push; volver a subir el APK anterior.

**Cuando Google Play esté en producción:** `urlPlayStore` en `oposicion/app-config.json`; unas semanas después, `urlApk: null`.

## Próximos días

**Prueba cerrada de Google Play**
- [ ] 14 días seguidos con 12 o más testers: desde el 8 oct. a las 11:30 hasta el **22 oct.** Que no bajen de 12.
- [ ] Ir anotando comentarios y cambios en `app/play-store/registro-prueba-cerrada.md` (rellenar fechas y número de testers).
- [ ] Cumplidos los 14 días: Play Console → Panel → **Solicitar acceso a producción**, con el borrador del registro.
- [ ] Aprobado el acceso: subir la última versión a **Producción** y, publicada, `urlPlayStore` en `oposicion/app-config.json` (la web y la app pasan a enlazar a Play). Unas semanas después, `urlApk: null`.

**Versión 1.15.0 (24): mejoras de los testers (8 oct.)**
- [x] Víctor: reglas nuevas (`firestore.rules`, 180 casos) publicadas (8 oct.).

**Versión 1.15.1 (25): buscar preparador y arreglos del móvil (8 oct.)**
- [ ] Víctor: **volver a publicar las reglas** (`firestore.rules`, ahora 206 casos): la búsqueda de preparador añade `busquedas`, `interesados` y `plazas`, y los temas de las clases sueltas. Sin esto, «Buscar preparador» y «Alumnos nuevos» dan «sin permiso».
- [ ] Víctor: subir el `.aab` 1.15.1 (25) (`Escritorio\oposicion-tcee-dce-1.15.1.aab`) a la prueba cerrada y anotarlo en el registro.
- [ ] Víctor: en el móvil, comprobar: el alumno duplicado («Unir fichas» en la clase o en su ficha), mandar temas en una clase suelta, «Empezar el esquema» arranca el cronómetro y el aviso con cuenta atrás (al alumno y a ti), la pizarra (trazo donde se toca, colores, borrador), buscar preparador en los dos lados.
- [x] Víctor: exención de índice `pizarra` → `trazos` creada (8 oct.).
- [x] Víctor: `.aab` 1.15.0 (24) subido a la prueba cerrada (8 oct.).
- [ ] Probar con una cuenta de alumno y otra de preparador: permiso pedido al abrir; cambiar hora y cancelar una clase → el alumno lo ve al instante y recibe «ha movido tu clase»; tocar el aviso abre la clase; mandar 2 temas; pizarra entre los dos; material enlazado; Teams; actualización desde Play.

**Google Calendar y Meet (en pruebas)**
- [x] Google Cloud (`web-vgm`): Google Calendar API activada y permiso `calendar.events` en la pantalla de consentimiento (8 oct.).
- [x] Firebase: reglas con `pruebasCalendario` publicadas y las cuentas de prueba dadas de alta (8 oct.).
- [ ] La tarjeta no aparecía (8 oct.): en la 1.15.0 dice por qué (cuenta no en `pruebasCalendario` —el id es el Gmail en minúsculas o el uid—, reglas sin publicar o sin red). Comprobar en Preparador → Ajustes qué dice y, si es la lista, revisar el id del documento.
- [ ] Probar en el móvil: Preparador → Ajustes → «Mis clases en Google Calendar» (aceptar el aviso de app no verificada en «Configuración avanzada»); clase online con el enlace vacío → evento en el calendario con su Meet, invitación al alumno y el enlace en la clase; cambiarla de hora y cancelarla. La ficha de la clase muestra el estado en el calendario y el error exacto si lo hay.
- [ ] Después del 12 (con la política de privacidad ya publicada): comprobar `victorgutierrezmarcos.es` en Google Search Console con la cuenta del proyecto; rellenar la marca en Google Auth Platform (nombre, logo, correo, página `https://www.victorgutierrezmarcos.es/app/`, política `https://www.victorgutierrezmarcos.es/politica-cookies.html`, dominio autorizado).
- [ ] Claude prepara la justificación del permiso (en inglés) y el guion del vídeo; Víctor graba el vídeo (YouTube, oculto) y envía la verificación en el Centro de verificación.
- [ ] Verificado el permiso: actualización de la app que abra la opción a todos los preparadores (sin la lista `pruebasCalendario`).
- [ ] Mejora pendiente: si el alumno cambia o cancela la clase desde su app, que el calendario del preparador se actualice sin que este vuelva a guardarla.

**Protección de datos (RGPD y LOPDGDD)**
- [x] Política de privacidad completada (bases legales de la app, corresponsables, encargados, plazos, menores, derechos) y condiciones de uso con el encargo para preparadores (`app/condiciones.html`), enlazadas en la app (8 oct.). Se publican el día 12 con el lanzamiento.
- [x] Registro de actividades de tratamiento y acuerdo de corresponsabilidad con Manuel, en Claude Docs (8 oct.). Manuel no tiene acceso a Firebase.
- [x] Acuerdo con Manuel: aceptado por correo el 8 oct. (guardar su respuesta).
- [ ] Aceptar los términos de tratamiento de datos de Firebase (Configuración del proyecto → Privacidad) y de Google Analytics.
- [ ] Mirar dónde está la base de datos de Firestore (región) y anotarlo en el registro.
- [ ] Verificación en dos pasos en la cuenta de Google del proyecto (y en la de Manuel).
- [x] Siguiente versión de la app (1.15.0): lleva los enlaces a las condiciones de uso (Más, inicio de sesión y alta de preparador) y las mejoras de los testers.

