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
- Para Google, el texto del enlace cuenta: mejor «app para la oposición a DCE» o «app de la oposición a Diplomado Comercial del Estado» que «instala la app». Lo ideal: portada y menú de su web, `temario.html` y el pie de cada tema (pedido el 20 oct. 2026).

## Lanzamiento: 12 de octubre de 2026

El día que manuelcabadogarcia.es se hace público. Google Play aún no estará en producción (prueba cerrada de 14 días), así que en Android se descarga el **APK universal firmado por Google** (Play Console → Explorador de App Bundle → versión 23, la 1.14.2): tiene la misma firma que la de Play y, cuando salga allí, se pasa sin desinstalar. iPhone y ordenador, por el navegador (`app/instalar.html`).

**Hecho antes (7 oct.):** rosetones en todas las páginas, aviso de la app oculto en la portada y en /oposicion de `main` (sin `app-banner.js`), `oposicion/proceso.json` y su workflow en `main`, reglas probadas (128 casos), versión web 1.14.2 en `app/abrir/`, textos de instalación y `versionActual: "1.14.2"` en `dce`.

**Pendiente antes del día 12:**
- [x] Víctor: subir la 1.14.2 (23) a la prueba cerrada (8 oct.) y preparar Firebase (reglas nuevas y `pruebasCalendario`).
- [x] Víctor: comprobar `general: true` en su documento de `admins` (8 oct.).
- [x] Víctor: descargar el **APK universal firmado** de la versión 23 (8 oct.). Comprobado: 1.14.2 (23), firmado por Google (SHA-1 `11:1D:E2:24:6D:64:C0:62:E9:20:37:DD:1D:42:C2:6A:33:4C:3D:88`). Guardado en el Escritorio como `oposicion-tcee-1.14.2-google.apk`.
- [x] Víctor: probar la 1.14.2 en el móvil (8 oct.): va bien.
- [x] Víctor: probar **Google Calendar** (ver abajo, «Google Calendar y Meet»): la tarjeta dice «Todavía en pruebas: tu cuenta no está en la lista de prueba» → falta el documento `pruebasCalendario/{tu Gmail en minúsculas}` en la raíz de Firestore (TCEE). — **13 oct.: probado; a la espera de que Google verifique los permisos.**
- [x] Manuel: su web pública con `oposicion/temario/temario.json` (99 temas, 44 con enlace, todos responden), `app-config.json` y `enlaces.json` (comprobado el 13 oct.; enlaza a /app/ desde la barra). Su web no usa el inicio de sesión de Firebase, así que no hace falta el dominio autorizado. Su `app-config.json` no lleva `email`, así que el contacto de DCE es el de `Oposiciones.dce.correo`: **`contacto@manuelcabadogarcia.es`** desde el 13 oct. (antes su Gmail). «Cómo cantar un tema» es su página `como-cantar-un-tema.html` (no un PDF): la app la abre desde Cantar y Organización (`comoCantarUnTema`). En `main` y en la versión web; en el móvil, con el próximo `.aab`.
- [x] Su administrador en `oposiciones/dce/admins/{su Gmail}` (consola de Firestore) si va a verificar preparadores de DCE. — **13 oct.: hecho por Manuel.**
- [x] 12 testers apuntados a la prueba cerrada desde el 8 oct. a las 11:30 (enlace: `https://play.google.com/apps/testing/es.victorgutierrezmarcos.tcee_app`). Conviene llegar a 15-20 por si alguien se sale.

**Desde el 9 oct. todo se trabaja en `main`** (por decisión de Víctor): la rama `dce` quedó igual que `main` (`ba0d78c`) y ya no se usa. Las referencias a `dce` de abajo son históricas.

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

**SEO para DCE (20 oct. 2026)**: hasta hoy Google no mostraba la web para ninguna búsqueda con «dce» o «diplomado» (Search Console, 16 meses). `/app/` lleva ahora h2, la sección «Si preparas la oposición a Diplomado Comercial del Estado», JSON-LD con las dos oposiciones y enlaces desde portada, `/oposicion/`, la guía y los pies.
- [x] Víctor: mandar a Manuel el correo pidiendo los enlaces (resumen arriba, en «Enlazar la app desde su web»). — **20 oct.: enviado; esperar su respuesta y comprobar los enlaces en su web.**
- [ ] Víctor: Search Console → Inspección de URL → Solicitar indexación de `/app/`, `/`, `/oposicion/` y `/oposicion/por-que-tcee.html`. — **20 oct.: publicado a las 23:40 e `indexnow.yml` lanzado a mano (sitemap entero); `/app/` estaba indexada con el último rastreo del 15 oct., falta pedir el nuevo.**
- [ ] 22 oct., al poner `urlPlayStore`: en el JSON-LD de `app/index.html`, `downloadUrl` → URL de Play y `"sameAs": ["<URL de Play>"]`; `softwareVersion` = `versionActual`.
- [ ] A las 2 y 4 semanas: `python3 scripts/estadisticas-web.py --dias 28` (ya saca «Búsquedas con «dce» o «diplomado»»).
- [ ] Decidir si se hace una guía informativa de DCE (`oposicion/…`), hermana de `por-que-tcee.html`: es el tipo de página que Google premia para «Diplomado Comercial del Estado»; Víctor la descartó el 20 oct. (sin páginas nuevas), queda apuntada.

**Prueba cerrada de Google Play**
- [ ] 14 días seguidos con 12 o más testers: desde el 8 oct. a las 11:30 hasta el **22 oct.** Que no bajen de 12. — **13 oct.: en marcha, solo queda esperar.**
- [x] Ir anotando comentarios y cambios en `app/play-store/registro-prueba-cerrada.md` (rellenar fechas y número de testers). — **13 oct.: en curso.**
- [ ] Cumplidos los 14 días: Play Console → Panel → **Solicitar acceso a producción**, con el borrador del registro.
- [ ] Aprobado el acceso: subir la última versión a **Producción** y, publicada, `urlPlayStore` en `oposicion/app-config.json` (la web y la app pasan a enlazar a Play). Unas semanas después, `urlApk: null`.

**Versión 1.15.0 (24): mejoras de los testers (8 oct.)**
- [x] Víctor: reglas nuevas (`firestore.rules`, 180 casos) publicadas (8 oct.).

**Versión 1.15.2 (26): buscar preparador y arreglos del móvil (8-9 oct.)**
- [x] Víctor: reglas publicadas (206 casos) el 9 oct.
- [x] Víctor: subir el `.aab` **1.15.3 (27)** (`Escritorio\oposicion-tcee-dce-1.15.3.aab`; la 25 y la 26 no hacen falta) a la prueba cerrada (ya anotado en el registro). Hasta que el móvil tenga la 26, el tema de una clase suelta no se puede mandar (la 24 lo bloquea en la app). Cuando Play lo procese, bajar su **APK universal firmado** (Explorador de App Bundle → versión 27), dejarlo en el Escritorio como `oposicion-tcee.apk`: Claude lo sube a `app-latest` (`gh auth switch -u vgutierrezmarcos`) y pone `versionActual: "1.15.3"` en `oposicion/app-config.json`. Hasta entonces, el APK público es el 1.14.2. — **13 oct.: superado por versiones posteriores (34).**
- [x] Víctor: en el móvil, comprobar: el alumno duplicado («Unir fichas» en la clase o en su ficha), mandar temas en una clase suelta, «Empezar el esquema» arranca el cronómetro y el aviso con cuenta atrás (al alumno y a ti), la pizarra (trazo donde se toca, colores, borrador), buscar preparador en los dos lados. — **13 oct.: funciona.**
- [x] Víctor: exención de índice `pizarra` → `trazos` creada (8 oct.).
- [x] Víctor: `.aab` 1.15.0 (24) subido a la prueba cerrada (8 oct.).
- [x] Probar con una cuenta de alumno y otra de preparador: permiso pedido al abrir; cambiar hora y cancelar una clase → el alumno lo ve al instante y recibe «ha movido tu clase»; tocar el aviso abre la clase; mandar 2 temas; pizarra entre los dos; material enlazado; Teams; actualización desde Play. — **13 oct.: funciona.**

**Versión 1.15.4 (28): clase suelta, código fijo, solicitudes y web (9 oct.)**
- [x] Víctor: publicar las reglas nuevas (`firestore.rules`, 233 casos; publicadas el 9 oct.): solicitudes de verificación validadas (siempre aprobables), reverificación solo por la administración, correo del administrador sin mayúsculas.
- [x] ~~Subir el `.aab` 1.15.4 (28)~~: no se subió; va dentro de la 1.15.6 (30), ver abajo.
- [x] Víctor: en el navegador, abrir `/app/abrir/` y comprobar que ya no salen rachas (se quita la versión vieja guardada); permitir los avisos y ver que llegan con la web abierta. — **13 oct.: funciona.**
- [x] Cuando la 1.15.6 esté en Play y en `app-latest`: poner `"versionMinima": "1.15.6"` en `oposicion/app-config.json` (las versiones anteriores dejan de sincronizar y piden actualizar). Las 1.15.3 y anteriores no leen ese campo: para ellas, las fichas de clase suelta ya van aparte (`alumnosSueltos`) y la clase recupera al alumno sola. — **13 oct.: superado: ya hay versiones posteriores (34).**

**Vídeos de ayuda (9 oct.)**: 11 vídeos verticales de menos de un minuto en `promo/ayuda/` (guiones en `promo/ayuda/GUIONES.md`; cómo se rehacen, en el README).
- [x] Los 11 vídeos montados (28-47 s cada uno) y botón ▶ en las pantallas (9 oct.).
- [x] Tests (181) y prueba en la versión web; versión web 1.15.5 (29) en `app/abrir/`; vídeos publicados con la sección «Cómo se usa» de `/app/` (9 oct.).
- [x] Sin «grupos» (la preparación es individual) y una clase = un solo opositor; vídeos y capturas rehechos (9 oct.).
- [x] 4 vídeos de instalación con DCE elegida (Android con Google Play y APK, iPhone, Windows, Mac) en `/app/#ayuda` y en `instalar.html` (9 oct.).
- [x] Publicados en la web (9 oct.).
- [x] ~~Rehacer el vídeo promocional con las capturas nuevas (lo hace la sesión del promocional).~~ — **13 oct.: ya no hace falta; se rehará cuando haya cambios significativos.**

**Versión 1.15.6 (30): cancelar y borrar clases, relaciones, dos temas, simulacro, cronómetro y pizarra (9 oct.)**
- [x] Víctor: subir el `.aab` **1.15.6 (30)** a la prueba cerrada (lleva también la 1.15.4 y la 1.15.5) y, cuando Play lo procese, bajar el APK universal firmado por Google al Escritorio (`oposicion-tcee.apk`) para subirlo a `app-latest` con `versionActual: "1.15.6"`. — **13 oct.: superado: ya está subida la 34.**
- [x] Probar con alumno y preparador: el alumno cancela una clase (al preparador le llega con aviso) y la quita de su agenda; quitar relaciones desde los dos lados; mandar 2 temas y cantarlos por orden; «Simulación de examen real»; el cronómetro del alumno en el móvil del preparador (ficha de la clase y notificación con cuenta atrás); pizarra con colores entre los dos. — **13 oct.: funciona.**

**Test: probabilidad y frecuencia de temas (9 oct.)**: clasificación de Álvaro cruzada con la nuestra (89 reclasificadas), 8 exámenes de 2002-2009 transcritos del PDF escaneado, `frecuencia_temas.json` (`scripts/frecuencia-test.py`), calculadora en la web (`oposicion/probabilidad-test.html`) y en la app 1.15.8 (32).
- [x] Lecturas dudosas del escaneo comprobadas con las cuentas (2007 n.º 8, 2002 n.º 4, 2005 n.º 8, 10, 15, 16 y 23 cuadran con la plantilla). Queda la fecha de 2004 (26 o 28 de junio), sin importancia.
- [x] Revisión de todo el banco (9 oct.): 6 temas, 19 fórmulas, 4 preguntas con «<» que la web cortaba, saltos de línea en la web y asteriscos sueltos; notas (`nota`, se ven al corregir) en 8 respuestas oficiales desactualizadas o discutibles (2006 n.º 35, 41 y 44; 2011 n.º 21; 2013 n.º 4 y 11; 2005 n.º 22; 2023 n.º 7); quitada la 15 de 2014 (anulada).
- [x] Examen de marzo de 2026 (OEP 2025) en el simulador (`2026-marzo`, 45 preguntas, 3 y 28 anuladas, 42 «B y C») y en la recopilación `examenes_oficiales_test.pdf`.
- [x] Víctor: subir el `.aab` 1.15.8 (32) a la prueba cerrada (está en el Escritorio; web y `app/abrir` ya publicados). La siguiente versión llevará además la nota de las preguntas al corregir y que el contenido nuevo de la web (preguntas, temario…) se vea sin cerrar la app; la versión web ya lo tiene. — **13 oct.: superado: ya está subida la 34.**

**Versión 1.15.10 (34): batería sin restricciones (10 oct.)**
Al permitir los avisos, el diálogo del sistema para que la batería no restrinja la app (permiso `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS`) y, en Xiaomi, Huawei, Honor, Samsung, OPPO, realme, OnePlus y vivo, el paso de su ahorro de batería propio. A quien ya tenía la app, una vez. También (13 oct.): **el preparador tiene que aceptar** la conexión de cada opositor que escribe su código (hasta entonces no ve nada suyo; reglas de Firestore nuevas, vídeos de ayuda «conectar-preparador» y «empezar-preparador» rehechos); el **modo noche de DCE** con los colores del de manuelcabadogarcia.es (carbón, crema y verde menta); la **pizarra para practicar** sola (Cantar → Pizarra, no se guarda); el **preparador hace y manda cronogramas** a su alumno, que los acepta o no; con **varios preparadores**, «Temas cantados» (cuáles no ha cantado, cuándo y con quién, sin la valoración de los otros), quiénes son los demás (LinkedIn y WhatsApp si lo comparten) y notas entre preparadores; y la entrada con Google en el móvil se recupera de un token revocado («Invalid Value»: pasaba al quitar el acceso de la app en la cuenta de Google). También (12 oct.) repetir clases y cantes cada N semanas (de 1 a 12), no solo cada semana, y lo mismo en las clases fijas. Versión web publicada; `.aab` compilado el 13 oct. (`Escritorio\oposicion-tcee-dce-1.15.10.aab`).
- [x] Reglas nuevas de Firestore publicadas y `.aab` 1.15.10 (34) enviado a revisión en la prueba cerrada (13 oct.). Hasta que se apruebe, la 33 no puede conectar con un preparador por código. **Publicada en la prueba cerrada el 13 oct.**: APK universal firmado por Google (sin protección automática) en `app-latest` y `versionActual` 1.15.10. `versionMinima` sigue en 1.0.0 (subirla solo si la 33 da problemas con las conexiones pendientes).
- [x] Probar en el móvil: el diálogo del sistema, el paso del fabricante y Más → Ajustes («La batería restringe la app» desaparece al permitirlo). — **13 oct.: funciona.**
- [ ] Si Google Play pone pegas al permiso en la revisión: quitarlo del manifiesto (ver README, «Avisos y permisos del sistema»).

**Versión 1.15.11 (35): invitar, aviso por Play y DCE (14 oct.)**
- **Invitar en un toque:** «Invitar a mis alumnos por WhatsApp» en la tarjeta del código del preparador, e «Invitar a … a la app» en la ficha de un alumno sin la app que tenga teléfono.
- **Aviso de versión nueva:** al tocar la notificación se actualiza por Play si la app viene de Play. Solo abre el APK si se instaló desde la web; antes lo abría siempre, porque `urlPlayStore` no está puesta.
- **DCE:** «Cómo cantar un tema» abre la página de Manuel, y el contacto pasa a `contacto@manuelcabadogarcia.es`.
- **Estado:** versión web publicada; `.aab` compilado el 14 oct. (`Escritorio\oposicion-tcee-dce-1.15.11.aab`).
- [x] ~~Subir el `.aab` 1.15.11 (35)~~: no se subió; va dentro de la 1.16.0 (36), ver abajo.
- [ ] Hasta entonces, decir a los testers que actualicen desde Play o con «Actualizar» en Hoy, no con la notificación.
- [ ] Probar en el móvil: invitar por WhatsApp (a un contacto y a un grupo) y el aviso de versión nueva por Play.

**Versión 1.16.0 (36): pizarra como Notas, temas anotados, avisos del proceso al momento y coordinación entre preparadores (16 oct.)**
Lleva también todo lo de la 1.15.11. Lo pidieron Manuel y los testers tras probar la pizarra en el iPad, y Víctor después.
- **Pizarra como Notas del iPad:**
  - El trazo no cambia al levantar el lápiz (era el «autocorrector»).
  - Tinta con presión. Con lápiz, la palma no pinta y los dedos mueven y amplían.
  - Barra clara: bolígrafo, borrador, colores, deshacer y rehacer.
  - En «···», las herramientas extra: rotulador, fosforito, lazo, regla, formas al mantener y papel rayado o cuadriculado.
- **Pintar y subrayar los temas (PDF):**
  - Bolígrafo, fosforito y borrador, guardados en la cuenta.
  - «Descargar con mis anotaciones» genera el PDF anotado.
  - Visor de PDF nuevo: un dedo desplaza, dos amplían; en el ordenador, rueda y Ctrl+rueda.
- **Avisos que se quitan solos:** respaldo propio y ✕. También los de botón («Ver»), que antes no se iban nunca.
- **Avisos del proceso:**
  - TCEE y DCE por separado (probado).
  - Push al momento: la acción `leer-proceso` lee cada 2 minutos en horario de oficina (cron-job.org) y avisa por Firebase Cloud Messaging.
  - Ver la memoria del push: pausa y aviso si el portal falla.
- **Varios preparadores del mismo opositor:**
  - **Agenda común:** cada preparador ve las próximas clases de los demás. Hay aviso de choque al programar o mover una clase y al apuntar un cante, y las reservas no ofrecen huecos que choquen.
  - **Temas sin repetir:** el sorteo del tema que se manda y el de la clase dejan fuera lo cantado en dos semanas y lo ya mandado por otros, que los preparadores ven (el alumno no).
  - **Reparto opcional** de qué lleva cada uno, por ejercicios y con nota.
  - **Cronograma:** consta quién lo hizo; cada preparador deja su propia propuesta y el opositor las acepta una a una.
  - **Comunicación:** tablón común opositor-preparadores; notas entre preparadores editables; avisos de nota o mensaje nuevo, de preparador nuevo y de cronograma o propuesta aceptados o rechazados.
  - **Pasar una clase a otro preparador:** cancelar y pedírsela en un toque, también si la cancela el preparador.
  - **Qué ven tus preparadores:** el opositor oculta sus cantes por su cuenta o hace que un preparador no sepa que tiene otros. Por defecto, se ve todo lo que ayuda a coordinarse.
  - **Colores distintos** para cada preparador.
- **Reglas de Firestore nuevas:** tablón, reparto, ajustes, propuestas por preparador, temas mandados entre preparadores y preparador oculto. 303 casos con el emulador.
- [x] Víctor: publicar `firestore.rules` en la consola de Firebase **antes** de subir el `.aab` (hecho el 16 oct.). Sin ellas no funcionan el tablón, el reparto ni las propuestas de cada preparador.
- [x] Víctor: subir el `.aab` 1.16.0 (36) (`Escritorio\oposicion-tcee-dce-1.16.0.aab`) a la prueba cerrada **antes del 22 oct.**: enviado a revisión el 16 oct.
- [x] **Aprobada y publicada en la prueba cerrada el 17 oct.**: APK universal 36 firmado por Google (sin la protección automática) en `app-latest` y `"versionActual": "1.16.0"`.
- [ ] Probar en el móvil:
  - Pizarra con lápiz y palma.
  - Anotar un tema y descargarlo.
  - Push del proceso cuando haya una novedad.
  - Con dos preparadores de prueba: tablón, choques, pasar una clase, propuestas y ocultar a uno.
- Ojo: con `.aab` de versiones anteriores, el opositor no ve las propuestas nuevas de cada preparador (sí la última, en el campo antiguo).

**Red: crecimiento y estadísticas privadas (14 oct.)**
- **Script:** `scripts/estadisticas-red.py` cuenta, sin nombres, las cuatro partes de la red (opositores y preparadores de TCEE y DCE).
  - Lee con la cuenta de servicio `estadisticas-lectura@web-vgm.iam.gserviceaccount.com` («Lector de Cloud Datastore»), cuya clave está en `~/.config/oposicion-red/clave.json` (14 oct.).
  - Guarda una foto diaria en `~/.local/share/oposicion-red/`.
  - Las cifras no se publican. La política de privacidad tiene la fila «Estadísticas agregadas de la app» (interés legítimo).
- **Primera foto (14 oct.):**
  - **TCEE:** 59 cuentas (44 activas en 7 días); 11 preparadores verificados, ninguno con alumnos conectados por código. Las 20 clases y las 12 fichas de alumnos sin la app parecen pruebas, según Víctor.
  - **DCE:** 23 cuentas y 10 preparadores verificados, con 1 conexión.
  - **Conclusión:** hay preparadores, pero todavía no se usa para las clases reales.
- **Prioridad:** que los preparadores que ya están inviten a sus alumnos actuales y programen en la app su próxima clase real.
- [ ] Víctor: mandar un WhatsApp a los preparadores pidiéndoselo, con el botón «Invitar a mis alumnos por WhatsApp» cuando llegue la 35.
- [ ] Repetir las estadísticas cada semana (Claude las ejecuta) y fijarse en las conexiones aceptadas y las clases programadas.
- [ ] Post de LinkedIn el día que salga en Play, sin cifras («ya la usan varios preparadores y opositores»). Pedir a la ATCEE que lo comparta, y a Manuel que lo haga en DCE.
- [ ] Mostrar la actividad de la red en público solo cuando crezca de verdad (decisión de Víctor).

**Versión 1.15.9 (33): primeros pasos (10 oct.)**
Bienvenida con entrada con Google, guía de la app con globos (Más → Guía de la app), «Para empezar» en Hoy, Hoy sin tarjetas vacías y «Más herramientas» en Organización. Además, la nota de las preguntas y el contenido nuevo sin cerrar la app. Versión web publicada.
- [x] Víctor: subir el `.aab` **1.15.9 (33)** (`Escritorio\oposicion-tcee-dce-1.15.9.aab`, lleva también la 32) a la prueba cerrada.
- [x] APK universal 33 firmado por Google, **sin la protección automática de Play** (la 23 y la 30 sí la llevaban), en `app-latest` (10 oct.); vuelve la descarga en la web (`urlApk`).
- [x] Cuando Play apruebe la revisión de la 33: `"versionActual": "1.15.9"` en `oposicion/app-config.json` (la app avisa a todos de que actualicen). — **13 oct.: hecho, subido y publicado.**
- [x] Probar en el móvil: instalación nueva (bienvenida → oposición → papel → hoja de avisos → guía), saltar la guía y abrirla desde Más, «Para empezar» tachándose y «Ocultar». — **13 oct.: funciona.**

**Google Calendar y Meet (en pruebas)**
Enlaces (proyecto `web-vgm`): [Google Auth Platform](https://console.cloud.google.com/auth/overview?project=web-vgm) · [Marca](https://console.cloud.google.com/auth/branding?project=web-vgm) · [Público (estado de publicación y usuarios de prueba)](https://console.cloud.google.com/auth/audience?project=web-vgm) · [Acceso a datos (permisos)](https://console.cloud.google.com/auth/scopes?project=web-vgm) · [Centro de verificación](https://console.cloud.google.com/auth/verification?project=web-vgm) · [YouTube Studio](https://studio.youtube.com/) · guion y justificación en `app/google-calendar-verificacion.md`.
- [x] Google Cloud (`web-vgm`): Google Calendar API activada y permiso `calendar.events` en la pantalla de consentimiento (8 oct.).
- [x] Firebase: reglas con `pruebasCalendario` publicadas y las cuentas de prueba dadas de alta (8 oct.).
- [x] La tarjeta no aparecía: faltaba el documento `pruebasCalendario/{gmail}`; creado el 8 oct. y la tarjeta sale. Consentimiento de Google superado (app no verificada → «Configuración avanzada») y **conectado** (8 oct., 19:30).
- [x] Probar en el móvil (ya conectado): clase online con el enlace vacío → evento en el calendario con su Meet, invitación al alumno y el enlace en la clase; cambiarla de hora y cancelarla. La ficha de la clase muestra el estado en el calendario y el error exacto si lo hay. — **13 oct.: probado.**
- [x] Marca en Google Auth Platform rellenada (9 oct.) y `victorgutierrezmarcos.es` verificado en Search Console (propiedad de dominio, ya existía). Antes: comprobar `victorgutierrezmarcos.es` en Google Search Console con la cuenta del proyecto; rellenar la marca en Google Auth Platform (nombre, logo, correo, página `https://www.victorgutierrezmarcos.es/app/`, política `https://www.victorgutierrezmarcos.es/politica-cookies.html`, dominio autorizado).
- [x] Permisos revisados (solo `calendar.events`) y justificación pegada en Acceso a datos (9 oct.); guion y justificación en `app/google-calendar-verificacion.md`.
- [x] Vídeo montado (`scripts/montar-video-calendar.py`, YouTube no listado `https://youtu.be/1U4rrKdOzrU`) y **verificación enviada** el 9 oct. 2026 (02:55). Google contesta por correo a victorgutierrezmarcos@gmail.com; si pide algo, se responde en el mismo hilo. No cambiar el estado de publicación ni el tipo de usuario del proyecto mientras tanto. El 10 oct. sigue «en proceso de verificación» (Centro de verificación). El 11 oct. Google pidió que la política de privacidad diga a qué datos de Google se accede, cómo se usan y su conservación y eliminación: añadido el apartado «Datos de usuario de Google» (`politica-cookies.html#datos-google`, 12 oct.); Google también pidió que el vídeo muestre el flujo de consentimiento: regrabado en inglés y montado (`Escritorio\google-calendar-demo-v2.mp4`, 12 oct.); subido a YouTube como no listado (`https://youtu.be/1WmPutIwKz8`, 13 oct.) y enviado a Google; a la espera de su respuesta. Google pidió además los permisos desplegados en el vídeo, justificar por qué no vale un permiso más estrecho y credenciales de prueba: grabado con la cuenta `tcee.revision@gmail.com` (en `pruebasCalendario`, preparador verificado) y montado el vídeo v3 (`scripts/montar-video-calendar-v3.py`, `Escritorio\google-calendar-demo-v3.mp4`); subido como no listado (`https://youtu.be/HyrSX2RJNT4`), justificación nueva en Acceso a datos y verificación reenviada desde la consola (13 oct.). El 14 oct. Google contestó en el hilo mirando aún el v2 (pedía desplegar «3 services», minuto 1:02): respondido en el hilo el 15 oct. con el enlace del v3 y los minutos (0:52 consentimiento, 1:08–1:26 «See the 3 services»); en revisión.
- [x] **Google aprobó la verificación el 16 oct.** (correo del 16 oct., 12:40; proyecto en producción): `"calendarioParaTodos": true` puesto el 17 oct. Antes: poner `"calendarioParaTodos": true` en `oposicion/app-config.json` (bloque `app`) y publicar; la app (desde la 1.15.3) lo lee y abre la opción a todos los preparadores sin versión nueva. Hasta entonces, la lista `pruebasCalendario`. — **13 oct.: lo único pendiente; a la espera de la verificación de Google (Víctor avisa).**
- [ ] Mejora pendiente: si el alumno cambia o cancela la clase desde su app, que el calendario del preparador se actualice sin que este vuelva a guardarla.

**Protección de datos (RGPD y LOPDGDD)**
- [x] Política de privacidad completada (bases legales de la app, corresponsables, encargados, plazos, menores, derechos) y condiciones de uso con el encargo para preparadores (`app/condiciones.html`), enlazadas en la app (8 oct.). Se publican el día 12 con el lanzamiento.
- [x] Registro de actividades de tratamiento y acuerdo de corresponsabilidad con Manuel, en Claude Docs (8 oct.). Manuel no tiene acceso a Firebase.
- [x] Acuerdo con Manuel: aceptado por correo el 8 oct.; respuesta guardada (9 oct.).
- [x] Términos de tratamiento de datos de Firebase aceptados (9 oct.).
- [x] Google Analytics: condiciones de tratamiento de datos aceptadas (9 oct.). (Antes: analytics.google.com → Administrar (engranaje abajo a la izquierda) → columna Cuenta → **Configuración de la cuenta** → «Condiciones de tratamiento de datos» / «Enmienda sobre el tratamiento de datos» → Revisar y aceptar (y en la misma pantalla, los ajustes de uso compartido de datos que quieras dejar). Si pide país, España.
- [x] Región de Firestore: **eur3** (multirregión Europa: Bélgica y Países Bajos, Unión Europea); anotada en el registro de actividades (9 oct.).
- [x] Verificación en dos pasos en la cuenta del proyecto (9 oct.); Manuel, en la suya.
- [x] Siguiente versión de la app (1.15.0): lleva los enlaces a las condiciones de uso (Más, inicio de sesión y alta de preparador) y las mejoras de los testers.


## Peticiones de Manuel del 21 oct. 2026

Hechas el 21 oct.: valoración por tema, temas y minutos corregibles a posteriori (1.17.8), tiempos del cronómetro de DCE (1.17.6) y, en la 1.17.9, las tres de la pizarra:
- [x] **Pizarra: escribir a máquina**: herramienta «Texto» en el menú ··· (`pizarra_texto.dart`, elemento `h: 't'` en `pizarra_trazos.dart`).
- [x] **«Notas del preparador» en la clase**: segunda pizarra en los datos del preparador (`users/{prep}/sesiones/{id}/notas/{p}`, páginas con `alumno` y `visible`), botón en la ficha de la clase (preparador, con el chip «Compartir») y en el cante del alumno cuando están compartidas y la clase ha terminado. Reglas publicadas en la consola de Firebase el 21 oct. 2026.
- [x] **Exportar las pizarras**: «Guardar como PDF» en el menú ··· de la pizarra de la clase y de las notas (`pizarra_pdf.dart`). No caducan: se guardan con la cuenta del alumno (la de la clase) o del preparador (las notas); si algún día pesan, borrado automático a los N días.
- [ ] Probar `tool/reglas/prueba.mjs` con el emulador (aquí no hay Java ni emulador) antes de publicar las reglas.
