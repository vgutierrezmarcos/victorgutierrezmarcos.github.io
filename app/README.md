# Oposición TCEE · DCE · app móvil

App Flutter (Android, iOS y navegador) complementaria de [victorgutierrezmarcos.es](https://www.victorgutierrezmarcos.es). La versión para el navegador es la misma app compilada para web y se sirve en [victorgutierrezmarcos.es/app/abrir/](https://www.victorgutierrezmarcos.es/app/abrir/) (ver «Versión web»). Todo el contenido (preguntas, temario, configuración) se descarga de la web, así que actualizar la web actualiza la app sin republicarla. Usa el mismo proyecto Firebase que la web (`web-vgm`): el historial de tests se comparte entre web y app, y el resto de datos del opositor (repaso, notas, cantes, planificación) se sincroniza entre sus dispositivos.

## Qué hace

Cinco bloques, iguales para opositores y preparadores, uno por cada cosa que se hace con la app (rutas en `lib/app.dart`; las de antes se redirigen con `rutaNueva`). La página pública que la explica, con capturas y vídeo, es [`app/index.html`](index.html) (victorgutierrezmarcos.es/app/).

| Bloque | Funciones |
|---|---|
| **Hoy** | Lo que toca. Al opositor: cuenta atrás al próximo ejercicio y al próximo cante, racha diaria, semana del cronograma, test diario (10 preguntas, iguales para todos cada día), repaso pendiente y probabilidad de aprobar. Al preparador, primero su panel (`PanelPreparadorHoy`): clases de hoy, reservas por confirmar, clases sueltas del tablón y verificaciones; después, test diario y repaso. Avisa cuando hay una versión nueva. |
| **Estudiar** | Dos subpestañas. **Temas**: ejercicios → partes → temas, búsqueda, visor PDF con descarga para offline, marcar estudiado / en repaso y agenda de cada tema (apuntes para la próxima vuelta, vueltas dadas, cómo fue al cantarlo, test de sus preguntas y nota libre). **Test**: simulador con los mismos filtros y baremo que la web (1 / -0,33 / 0), resultados por bloque, revisión, estadísticas e historial unificado con la web. |
| **Cantes** | Al opositor, tres subpestañas. **Agenda**: calendario mensual, cuenta atrás, avisos la víspera y una hora antes, repetición semanal y exportación a Google Calendar o `.ics`. **Cantar**: sacar bola como en el examen o de una bolsa propia (estudiados, en repaso, lista o los temas de un cante), con prioridad opcional a los flojos; cronómetro de preparación y exposición con avisos en segundo plano y grabación. **Diario**: cómo fue cada cante, estadísticas por tema y temas flojos. Al preparador: **Clases** (su semana) y **Cantar**. |
| **Organización** | Como la sección de la web: **cronograma** (generado, semana a semana o importado de texto, Excel, Word, PDF o CSV; se retoca a mano), **probabilidades** (como en el Excel de organización, por probabilidad o eficiencia, en 2D o 3D), **convocatoria** (fechas que pone el usuario e hitos propios), **horario** de estudio, **mapa del temario** (bloques con el código de colores y esquema de conexiones) y documentos de organización. |
| **Más** | **Preparador** (si ese es su papel) o **Mi preparador** (si es opositor). Cuenta (Google), ajustes (oposición y papel, avisos, tema claro/oscuro, descargas), contenido, enlaces útiles y acerca de. |

### Papel en cada oposición

En cada oposición se es **opositor o preparador**, no las dos cosas (`Papel`, guardado en `PerfilPreparador.activo`, con `papelElegido`). Se elige al empezar (`ElegirOposicionApp`, segundo paso), se cambia en *Más → Ajustes → Tu papel* y a quien venía de una versión anterior se le pregunta una vez en Hoy (`TarjetaElegirPapel`). Pasar a preparador deja de compartir el progreso con los preparadores propios de esa oposición; los datos se conservan.

## Estructura

```
lib/
├── main.dart                  # Firebase + Hive + servicios; funciona sin credenciales Firebase (modo local)
├── app.dart                   # go_router: 5 bloques (/hoy, /temario, /cantes, /test, /mas); /examen y /resultados a pantalla completa
├── theme/app_theme.dart       # paleta, tipografías y componentes de styles.css (claro y oscuro)
├── core/                      # constants (URLs), cache_http (ETag + Hive), notificaciones, calendario (.ics), providers (Riverpod),
│                              # plataforma (ficheros y grabaciones: _io móvil / _web navegador), firebase_web (configuración web)
├── data/models/               # pregunta, resultado (esquema exam_results), temario, plan (cantes, horario, agenda), preparador (alumnos, enlace)
├── data/repos/                # contenido (web), usuario, plan y preparador (Hive + Firestore), descargas (PDF: _io guarda, _web en memoria)
├── features/test/             # motor_test (lógica pura), leitner (réplica de spaced-repetition.js), páginas
├── features/cantes/           # bloque Cantes: cabecera con las subpestañas Agenda, Cantar y Diario
├── features/cantar/           # sorteo (probabilidades del Excel y sorteos), reloj_cante, vista Cantar, probabilidades
├── features/plan/             # vistas Agenda y Diario, cante, convocatoria, horario
├── features/preparador/       # Preparador (alta, panel de Hoy, semana, alumnos, tablón) y Mi preparador
├── features/organizacion/     # bloques, detalle de bloque y esquema interactivo del temario
├── features/{inicio,temario,mas}/
└── widgets/comunes.dart       # piezas de la web: cabecera, títulos de sección, tarjetas, grupos desplegables
test/                          # lógica (motor, Leitner, sorteo, plan, preparadores) y pruebas de humo de la app completa
tool/capturas_test.dart        # capturas de la app con datos de demostración (para la página y el vídeo)
promo/                         # capturas ligeras (.webp), vídeo de presentación y su póster
index.html                     # página pública de la app (victorgutierrezmarcos.es/app/)
web/                           # plantilla de la versión web (index.html con pantalla de carga y pdf.js, manifiesto, iconos)
abrir/                         # versión web compilada (la genera scripts/publicar-app-web.py; se sube al repositorio)
android/, ios/                 # proyectos nativos (generados con flutter create y configurados)
```

Datos compartidos con la web (generados en el repo raíz):

- `oposicion/temario/primer-ejercicio/test/preguntas.json` y `bloques.json`
- `oposicion/temario/temario.json` y `oposicion/enlaces.json` (los crea `node build-app-data.js` en CI). Los temas del quinto ejercicio se mantienen a mano en `build-app-data.js` (`TEMAS_QUINTO`).
- `oposicion/organizacion/estructura_temario.json`: bloques, colores, esquemas y conexiones del temario. Se genera con `python3 scripts/extraer-estructura-temario.py` a partir de `estructura_temario.ppsx` (y del Excel para los bloques del cuarto ejercicio; las conexiones que no están en el PowerPoint se añaden en `CONEXIONES_EXTRA`); hay que repetirlo cuando cambie el PowerPoint.
- `oposicion/app-config.json`: versión publicada (`versionActual`), URL de descarga, reglas del sorteo (`sorteo`) y avisos. Editar a mano. La app no muestra el nombre de ninguna convocatoria ni trae fechas oficiales: las fechas las pone el usuario.

Firestore (`users/{uid}/…`, reglas en `firestore.rules` del repo raíz):

- `exam_results/{id}`: mismo esquema que la web; la app añade `respuestas`, `origen`, `tipo`.
- `progress/spaced_repetition`: mismo formato que `localStorage.vgm_spaced_repetition` de la web.
- `progress/settings`: temas estudiados/en repaso, racha, recordatorio, tema.
- `progress/plan`: fechas de los ejercicios, hitos y horario.
- `cantes/{id}`: cantes programados y hechos (diario). El borrado es lógico (`borrado: true`). Los que programa o valora un preparador enlazado llevan `preparador` (su uid) y `preparadorNombre`.
- `progress/preparador`, `alumnos/{id}` y `sesiones/{id}`: perfil de preparador (código), sus alumnos y sus sesiones de cante.
- `preparadores/{uidPreparador}`: preparadores a los que el usuario da acceso.
- `notes/{tema}`: nota libre (`texto`) y agenda del tema (`pendientes`, `vueltas`).

## Varias oposiciones

La app sirve a dos oposiciones independientes, TCEE y DCE (Diplomado Comercial del Estado), cada una con su web (de la que sale el contenido), su examen, los datos de sus opositores y su red de preparadores con sus administradores. Una oposición con `lanzada: false` solo la ven, en *Más → Ajustes → Oposición*, sus administradores y el administrador general (`oposicionesVisiblesProvider`), para probarla antes de lanzarla. El opositor la elige al abrir la app por primera vez (`features/inicio/elegir_oposicion.dart`) y la cambia en *Más → Ajustes → Oposición* (`cambiarOposicionProvider`, que vuelve a crear los servicios en `RaizApp` de `main.dart`). Lo que necesita la web de DCE y los pasos del lanzamiento están en [`DCE.md`](DCE.md).

- **Descripción de cada oposición**: `data/models/oposicion.dart` (`Oposicion`, `EjercicioDef`, `Oposiciones.todas`). Lleva la web y las rutas del contenido, los ejercicios (cuáles se cantan, si es un dictamen sin temas, cuáles tienen sorteo, temas por parte, partes que hay que desarrollar, PDF por parte, qué se intercala en el cronograma) y, si su examen no tiene test, de qué oposición se practica el test de forma voluntaria (`testDe`). Las pantallas no llevan números de ejercicio fijos: los sacan de aquí.
- **La oposición elegida** se guarda en la caja Hive `app` (`oposicion`). Con ella `main()` crea los servicios y fija `Oposiciones.actual`; no cambia con la app abierta (`oposicionProvider` en los widgets). Las reglas del sorteo de `app-config.json` → `sorteo`, si las trae la web de esa oposición, mandan sobre las del examen (`Oposicion.bolasPorParte`).
- **Datos separados**: los de TCEE siguen donde estaban (`users/{uid}/…` y cajas Hive sin sufijo); los de otra oposición van en `users/{uid}/oposiciones/{id}/…` y en cajas con sufijo (`cantes_dce`); los PDF descargados, en su carpeta (`Oposicion.raizUsuario`, `Oposicion.caja`). La web hace lo mismo con `docUsuario` y `OPOSICION_WEB` de `firebase-config.js`.
- **Red de preparadores por oposición**: TCEE en las colecciones de la raíz y las demás en `oposiciones/{id}/…` (`Oposicion.red`), cada una con sus `admins`. Un preparador de las dos se verifica en cada una y tiene un código por oposición. `firestore.rules` se genera con `tool/reglas/generar.py` (ver su README).

## Cronograma

`data/models/cronograma.dart`, `features/cronograma/` (`planificador.dart` es la lógica pura, probada en `test/cronograma_test.dart`) y `core/cronograma_providers.dart`. Una vuelta al 3.º o al 4.º, con todos los temas o una selección, a N temas por semana o hasta una fecha (una sale de la otra), con semanas de descanso. Solo hay uno activo; al empezar otro, el anterior se archiva.

- **Orden sugerido** (`ordenSugerido`): los bloques del PowerPoint en su orden, eligiendo como siguiente el más conectado con lo ya puesto, y dentro de cada bloque un recorrido por las conexiones entre sus temas. El opositor lo reordena a mano (`ReordenarTemasPage`). No se reintroduce un reparto genérico: el anterior se retiró por ignorar bloques y conexiones.
- **Intercalado** (activado por defecto): en el 3.º, los temas de Mixto (historia, pensamiento, organismos internacionales y UE, más memorísticos) se reparten entre los demás en proporción a su peso (≈1 de cada 4) o «1 de cada N»; en el 4.º, se alternan las dos partes.
- **Hecho = estudiado + vuelta**: marcar un tema lo da por estudiado y anota una vuelta en su agenda; una vuelta anotada desde el tema también cuenta. Desmarcar no borra la vuelta (`desmarcados`).
- **Día de cante** (`Cronograma.diaCante`): el opositor elige qué día canta y la fecha del primer cante de la vuelta. Cada semana del cronograma va del día siguiente a un cante hasta el cante siguiente (`inicioSemana`), así que sus temas son los de ese cante, y los cálculos (ritmo, fin, retraso) cuentan cantes. Sin día fijo, semanas de lunes a domingo (como los cronogramas anteriores).
- **Retraso**: lo de semanas pasadas sin hacer. `replanificarCronograma` reparte lo pendiente desde esta semana manteniendo la fecha de fin (sube el ritmo) o el ritmo (se retrasa el fin). En Hoy, la tarjeta «Esta semana te toca».
- **Preparador**: el opositor puede compartirlo (desactivado por defecto). El preparador enlazado lo ve en la ficha del alumno y puede proponer otro ritmo, fecha u orden con una nota (`propuesta`), que el alumno acepta o rechaza. Firestore: `users/{uid}/cronogramas/{id}`; el preparador solo lee si `compartir == true` y solo escribe `propuesta` firmada por él.

## LinkedIn y directorio de preparadores

Los preparadores pueden poner su perfil de LinkedIn (ajustes de preparador y solicitud de verificación; `enlaceLinkedin` lo deja en la forma `https://www.linkedin.com/in/…`, y las reglas solo aceptan esa forma). Sale en el directorio de preparadores verificados (`features/preparador/directorio_page.dart`, Más → Preparadores), filtrable por ejercicio, en la lista al pedir una sustitución y en las solicitudes de verificación.

## Red de preparadores

`data/models/red.dart`, `data/repos/red_repo.dart`, `core/red_providers.dart` y `features/preparador/` (semana, sustituciones, reservas, verificación, ajustes). Colecciones fuera de `users/{uid}` y sus reglas, en `firestore.rules`:

- **Verificación** (`admins/{uid}`, `preparadoresVerificados/{uid}`, `solicitudesPreparador/{uid}`). Para tener código de alumnos, ver el tablón de sustituciones, publicar huecos y verificar a otros hay que estar verificado. Verifica el administrador o un preparador ya verificado, nunca uno mismo; queda registrado quién avaló a quién, y el administrador puede retirar a alguien (`activo: false`), también en cadena. Si se retira a alguien, sus alumnos enlazados dejan de compartir con él (`esPreparadorDe` exige la verificación). Los administradores se crean a mano en la consola: un documento `admins/{uid}` (o con el correo como ID) en TCEE y `oposiciones/{id}/admins/{…}` en las demás. Con el campo `general: true` en `admins/` de la raíz, es **administrador general**: lo es de todas las oposiciones y ve las que aún no se han lanzado. El administrador se verifica a sí mismo desde la app (*Preparadores → Administración → Verificarme*).
- **Sustituciones** (`sustituciones/{id}` y `privado/{alumno|preparador}`). El alumno pide que le cojan un cante (desde un cante cancelado por su preparador o desde cero), a todos los verificados o a los que elija. Da un día y una franja de horas (`fecha`–`hasta`) o una hora fija, y elige los temas que lleva; no se pide duración. Quien la coge elige la hora (`hora`) dentro de la franja, y las reglas comprueban que cae dentro. Hay cantes del 1.er ejercicio (dictamen de coyuntura, sin temas), del 3.º y del 4.º; el 5.º no se canta. Las solicitudes de verificación pueden ir a un preparador concreto (`destinatario`): solo la ven él y el administrador. Los preparadores ven día, horas, ejercicio, temas y nota; el nombre y el teléfono del alumno, solo quien la coge, que deja los suyos. Coger es una transacción (gana el primero). El cante pasa a la semana del sustituto (alumno sin enlace, con teléfono) y a la agenda del alumno (`sust_{id}`). WhatsApp con `wa.me`.
- **Huecos y reservas** (`huecos/{preparador}`, `reservas/{id}`), desactivado por defecto. El preparador publica sus huecos semanales y las horas ocupadas (sin nombres); sus alumnos enlazados piden un hueco y él la acepta (se crea la sesión) o la rechaza.
- **Clases fijas** (`Alumno.clasesFijas`): generan las sesiones de las seis semanas siguientes, con un id por día, así que no se duplican ni vuelven si se borran.
- **Avisos**: `core/avisos_red.dart` comprueba lo nuevo al sincronizar (cada 3 min con la app abierta) y lo notifica una vez (`core/vistos.dart`). En Android, además, una tarea de WorkManager lo comprueba cada ~15 min con la app cerrada (`core/avisos_fondo_io.dart`). En el navegador, notificaciones del navegador con la pestaña abierta.
- **Colores**: cada alumno y cada preparador tienen su color (`colorDePersona`); en la agenda del alumno se puede filtrar por preparador.

Las reglas se generan y se prueban con el emulador: `tool/reglas/` (ver su README).

## Cantes presenciales u online

Cada cante (y cada sesión de un preparador) puede ser presencial, con el lugar, u online, con el enlace de la videollamada (`Cante.modalidad`, `lugar`, `enlace`; `features/plan/modalidad.dart`). Para online, «Crear reunión en Meet» abre `meet.google.com/new` con la cuenta de Google del usuario; se copia el enlace y se pega (botón de pegar, que reconoce el enlace con `enlaceReunion`). Sin permisos extra de Google ni servidor. El enlace va en la copia del cante que llega al alumno, en el aviso de una hora antes, en Google Calendar y en el `.ics` (`LOCATION`), y la ficha del cante tiene «Entrar a la clase», «Copiar enlace» y, en la sesión del preparador, «Enviar por WhatsApp» al alumno. Las peticiones de sustitución dicen si son presenciales, online o «me da igual», y el cante del sustituto lo hereda.

## Sincronización y privacidad

Sin cuenta, todo vive en Hive (en el navegador, IndexedDB). Con cuenta, cada repositorio sube lo que cambia en cuanto se guarda y `sincronizarTodo` fusiona nube y local (por elemento y por `updatedAt`). Se sincroniza al arrancar, al iniciar sesión, al volver a la app (`AppLifecycleListener` en `app.dart`) y, con la app abierta, cada 3 minutos (`SesionNotifier.sincronizarSiToca`, como mucho una vez por minuto). Así lo que se hace en el móvil aparece en el ordenador, lo que programa el preparador llega al alumno y lo que el alumno cambia en una sesión (hora, notas, valoración) vuelve al preparador (`_traerCambiosDeAlumnos`, que conserva el alumno, el título y el borrado del lado del preparador).

Privacidad, tal como se explica en la app (`TarjetaPrivacidad` en Cuenta), en `index.html` y en la política: los datos de cada cuenta solo los puede leer esa cuenta (`firestore.rules`), salvo lo que el alumno comparte con el preparador que elige; ni otros opositores ni otros alumnos del mismo preparador ven nada. Las grabaciones no salen del dispositivo. «Borrar todos mis datos» (Cuenta) rompe los enlaces, libera el código de preparador y borra `users/{uid}/…` entero (`PreparadorRepo.romperTodosLosEnlaces` + `UsuarioRepo.borrarTodoEnLaNube`).

## Preparadores

`data/repos/preparador_repo.dart` y `features/preparador/`. Cada papel tiene su pantalla:

- **Preparador** (`preparador_page.dart`, *Más → Preparador*): sin alta, presenta la sección y lleva a `AltaPreparadorPage`, que fija el papel y pide la verificación en un solo paso. Ya dado de alta, por grupos: estado y código, tus clases (semana; cada clase es un `Cante` con `alumno`, una por alumno aunque se programen en grupo), tus alumnos (enlazados o a mano; ficha con temas, cantados y flojos, historial, notas privadas, clases fijas, sacar bola con `CantarPage(sesion: …)`, valoración e informe), clases sueltas (tablón), la red (directorio, verificar, gestionar) y ajustes. Funciona sin cuenta, en local.
- **Mi preparador** (`mi_preparador_page.dart`): el opositor escribe el código de seis caracteres de su preparador (`codigos/{codigo}` → uid). Al conectar crea `users/{alumno}/preparadores/{preparador}` (el permiso) y `preparadores/{preparador}/alumnos/{alumno}` (para que el preparador lo vea en su lista). Desde entonces el preparador lee `users/{alumno}/progress/settings` (temas estudiados y en repaso) y `users/{alumno}/cantes`, y cada clase que guarda se copia a `users/{alumno}/cantes/{id}`: aparece en la agenda del alumno y, una vez valorada, en su diario. No se comparten tests, notas ni grabaciones. Cualquiera de los dos puede romper el enlace. Desde aquí también se pide una clase suelta, se reserva clase y se ve el directorio.

En la interfaz se dice «clase» (nunca «sesión») y «clase suelta» (nunca «sustitución»); los identificadores internos (`Sesion…`, `sustitucion`) no cambian.

El enlace exige que ambos hayan iniciado sesión con Google y que las reglas de `firestore.rules` estén aplicadas en la consola de Firebase. `test/preparador_test.dart` comprueba el flujo completo con Firestore simulado; las reglas no se pueden probar ahí (el simulador no admite funciones), así que hay que verificarlas con dos cuentas reales.

## Versión web

La misma app compilada con `flutter build web`. Diferencias, todas resueltas con `kIsWeb` o con importaciones condicionales (`core/plataforma.dart`, `data/repos/descargas_repo.dart`):

- Firebase se inicia con `opcionesFirebaseWeb` (la app web de `web-vgm`, la misma de `firebase-config.js`) y el inicio de sesión es `signInWithPopup`. Como comparte origen con la web, si ya se ha entrado en victorgutierrezmarcos.es suele estar dentro sin volver a iniciar sesión.
- El contenido se pide al mismo origen (`Urls.base` = `Uri.base.origin`), sin cabeceras propias: así no hay peticiones entre dominios. En pruebas locales se lee el repositorio servido en localhost.
- Sin notificaciones (`Notificaciones.disponibles`): se ocultan el recordatorio y los avisos de cantes. Los PDF se leen en memoria con pdf.js (cargado en `web/index.html`; su versión debe coincidir con la de `pdfx`), sin descargas para leer sin conexión. La grabación usa el primer formato que admita el navegador y vive en memoria. El `.ics` y la exportación JSON se descargan; los textos para compartir se copian al portapapeles.
- En pantallas de 720 px o más el menú pasa a un raíl lateral (con la foto de la cuenta arriba) y la app ocupa toda la pantalla: `ListaAdaptable` (widgets/comunes.dart) reparte las secciones de cada página en dos columnas a partir de 900 px, o centra la página si tiene una sola sección.

Publicar una versión nueva (cada vez que cambie `lib/` o `web/`):

```bash
python3 scripts/publicar-app-web.py   # desde la raíz: compila y copia a app/abrir/ (~9 MB)
```

y subir `app/abrir/`. El motor gráfico (canvaskit) no se copia: lo sirve www.gstatic.com. El script renombra `main.dart.js` con una huella de su contenido (`main.<huella>.dart.js`) y la añade a `flutter_bootstrap.js?v=` en `index.html`: GitHub Pages deja guardar los ficheros 10 minutos y, con el nombre fijo, el navegador podía seguir con la versión anterior.

## Diseño

Modo claro por defecto; el botón de sol y luna de la cabecera (`BotonTema`, en todas las pantallas) y *Más → Ajustes → Modo* cambian entre claro y oscuro. En oscuro, el lila (`dPrimario`) es para texto e iconos, y los rellenos con texto blanco (cabecera, botones, menú, selectores) usan `dRelleno`, con contraste de 7:1. La foto de la cuenta de Google sale en Hoy, Más, Cuenta y el raíl (`AvatarUsuario`).


La app reproduce la estética de la web (`styles.css` y los estilos de `simulador.html`):

- Tipografías incluidas en `assets/fonts` (no se descargan en tiempo de ejecución): TeX Gyre Pagella, equivalente libre de Palatino, para títulos y texto, y Source Sans 3 para la interfaz.
- `BarraWeb`: cabecera con degradado morado, título en blanco y línea dorada (`.site-header`). `TituloSeccion`: título morado con subrayado y rombo (`.section-title`). `Tarjeta`, `GrupoDesplegable` (`.tema-group-header`), `Contador` y `Estadistica` replican las cajas de la web y del simulador.
- El menú inferior sigue el de la web: etiquetas en mayúsculas y la sección activa en blanco sobre morado.

Sin blog: la app no enlaza ni muestra artículos. Sin cronograma: el reparto automático de temas se retiró; cuando se rehaga deberá apoyarse en los bloques y conexiones de la organización del temario.

## Organización del temario

`data/models/estructura.dart` lee `estructura_temario.json`. El código de colores es el del PowerPoint: catorce bloques en el tercer ejercicio (Microeconomía, Macroeconomía y Mixto), y rosa y morado para las dos partes del cuarto. `CasillaTema` pinta el código de un tema sobre el color de su bloque en el temario, la agenda de cada tema, el sorteo y los esquemas. `EsquemaVista` dibuja las casillas en la posición que tienen en la diapositiva, con sus marcos y flechas; al tocar un tema o un bloque se resaltan sus conexiones. «Por dónde seguir» propone los temas aún no estudiados que conectan con alguno ya estudiado.

## Probabilidades (réplica del Excel de organización)

`features/cantar/sorteo.dart` reproduce las hojas «Ej. 3», «Ej. 4», «Ej. 5» y «Probabilidad de aprobar» de `oposicion/organizacion/preparacion_oposicion_tcee.xlsm`, y `test/sorteo_test.dart` lo comprueba contra la fórmula literal de la hoja:

- Tercer y cuarto ejercicio: salen 2 temas de cada parte; probabilidad de una parte `x/N + (N−x)/N · x/(N−1)` y del ejercicio `P(A) · P(B)`. Rendimiento por tema, nivel de eficiencia y consejo de cambiar un tema de parte.
- Quinto ejercicio: un tema por parte y se desarrollan dos de los tres, así que cuenta el mejor par de partes.
- Las bolas por parte se pueden cambiar sin republicar en `app-config.json` → `sorteo`.

## Puesta en marcha

1. Instalar [Flutter](https://docs.flutter.dev/get-started/install) (stable) y Android Studio. Comprobar con `flutter doctor`.
2. `cd app && flutter pub get`. Las carpetas nativas ya están en el repositorio.
3. Firebase (consola del proyecto **web-vgm**). Sin este paso la app funciona, pero sin inicio de sesión:
   - Añadir app Android con id `es.victorgutierrezmarcos.tcee_app` y las huellas SHA-1 y SHA-256 de la clave de firma (`keytool -list -v -keystore android/tcee-upload.jks`). Descargar `google-services.json` a `android/app/`.
   - Añadir app iOS con bundle id `es.victorgutierrezmarcos.tceeApp`. Descargar `GoogleService-Info.plist` a `ios/Runner/` y añadir a `ios/Runner/Info.plist` el `CFBundleURLTypes` con su `REVERSED_CLIENT_ID` (Google Sign-In).
   - En Authentication → Google debe estar habilitado (ya lo está para la web).
   - Aplicar `firestore.rules` (Firestore → Reglas) si aún no están.
   Estos ficheros están en `.gitignore`; no se suben al repositorio.
4. Firma de Android: `android/key.properties` y el almacén `android/tcee-upload.jks` (ambos fuera del repositorio; **guardar copia**, porque es también la clave de subida a Google Play). Con ellos se firman las compilaciones de depuración y de publicación, de modo que la huella registrada en Firebase no cambia. Sin ellos se usa la clave de depuración de cada máquina y el inicio de sesión con Google no funcionará.
   ```
   storeFile=tcee-upload.jks
   storePassword=…
   keyAlias=tcee
   keyPassword=…
   ```
5. Ejecutar: `flutter run` (emulador Android o dispositivo), o `flutter build apk --release` para obtener `build/app/outputs/flutter-apk/app-release.apk`.

Para regenerar el icono: `dart run flutter_launcher_icons`.

## Comprobaciones

```bash
flutter analyze
flutter test
```

`test/app_test.dart` arranca la app completa sin Firebase ni red, con el `temario.json` y el `app-config.json` reales del repositorio, comprueba el diseño de ordenador (raíl y 1000 px) y recorre los cinco bloques y los flujos principales (programar un cante, sortear, cronometrar, guardar en el diario, hacer un test completo, agenda por tema, alta de un alumno y sesión de preparador).

Pruebas manuales en el móvil: programar un cante semanal y recibir el aviso; sortear y cantar con el cronómetro con la pantalla apagada; grabar y escucharse; apuntar algo en un tema y verlo al volver a abrirlo; hacer un test sin sesión, iniciar sesión y comprobar que aparece en el historial de la web y en `users/{uid}/exam_results`; modo avión con un PDF descargado; claro y oscuro.

## Capturas, vídeo y página de la app

```bash
flutter test tool/capturas_test.dart --update-goldens   # capturas en promo/capturas/ (no se suben)
python3 ../scripts/montar-video-app.py --ffmpeg RUTA     # promo/*.webp, promo/oposicion-tcee.mp4 y promo/poster.jpg
```

`tool/capturas_test.dart` arranca la app con datos de demostración ficticios y guarda cada pantalla a 1080 × 2340. `scripts/montar-video-app.py` (Pillow + ffmpeg) exporta las capturas ligeras que usa `index.html` y monta el vídeo de un minuto. Hay que repetir los dos pasos cuando cambie el aspecto de la app.

## Compilación en GitHub Actions

`.github/workflows/build-app.yml` analiza, pasa los tests y compila el APK en cada tag `app-v*` (lo adjunta a una release) y en ejecución manual (lo deja como artefacto). Secretos opcionales:

- `GOOGLE_SERVICES_JSON`: `google-services.json` en base64.
- `KEYSTORE_BASE64` y `KEYSTORE_PASSWORD`: almacén `tcee-upload.jks` en base64 y su contraseña (alias `tcee`).

## Distribución del APK

El APK se publica como release `app-latest` del repositorio, y la web lo enlaza desde `urlApk`. Para publicar una versión nueva:

1. Subir `version` en `pubspec.yaml` (nombre y número de compilación), para que Android la acepte como actualización.
2. Compilar y sustituir el fichero de la release:
   ```bash
   flutter build apk --release
   cp build/app/outputs/flutter-apk/app-release.apk /tmp/oposicion-tcee.apk
   gh release upload app-latest /tmp/oposicion-tcee.apk --clobber
   ```
3. Poner esa versión en `app.versionActual` de `oposicion/app-config.json` y subir el cambio. Las apps instaladas con una versión anterior muestran entonces en Inicio el aviso «Hay una versión nueva», con un botón que abre la descarga (o la ficha de Google Play cuando exista `urlPlayStore`).

Las actualizaciones automáticas solo existen a través de las tiendas: al publicar en Google Play, es Play quien actualiza la app.

## Publicación

- **Android**: `flutter build appbundle --release` y subir a Play Console (25 $ una vez). Las cuentas personales nuevas deben pasar una prueba cerrada con 12 testers durante 14 días antes de producción. Al publicar, registrar también en Firebase la huella SHA-1 de la clave de firma de Google Play (Play Console → Integridad de la app).
- **iOS**: Apple Developer Program (99 $/año). Sin Mac se puede compilar y firmar con [Codemagic](https://codemagic.io) o con un runner macOS de GitHub Actions. Subir a TestFlight y enviar a revisión.
- Ficha: icono 1024 px, capturas (iPhone 6,7" y 6,5"; teléfono Android), descripción, URL de privacidad `https://www.victorgutierrezmarcos.es/politica-cookies.html`.
- La web ya muestra el aviso de descarga en la portada y en `oposicion/index.html` (`app-banner.js`), con el APK de `urlApk` de `oposicion/app-config.json`. Cuando existan las fichas de las tiendas, rellenar `urlPlayStore` y `urlAppStore` y poner `urlApk` a `null`.
