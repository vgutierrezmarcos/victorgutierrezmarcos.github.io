# Oposición TCEE · app móvil

App Flutter (Android e iOS) complementaria de [victorgutierrezmarcos.es](https://www.victorgutierrezmarcos.es). Todo el contenido (preguntas, temario, configuración) se descarga de la web, así que actualizar la web actualiza la app sin republicarla. Usa el mismo proyecto Firebase que la web (`web-vgm`): el historial de tests se comparte entre web y app, y el resto de datos del opositor (repaso, notas, cantes, planificación) se sincroniza entre sus dispositivos.

## Qué hace

Cinco bloques, uno por cada cosa que se hace con la app. La página pública que la explica, con capturas y vídeo, es [`app/index.html`](index.html) (victorgutierrezmarcos.es/app/).

| Bloque | Funciones |
|---|---|
| **Hoy** | Lo que toca: cuenta atrás al próximo ejercicio y al próximo cante, racha diaria, test diario (10 preguntas, iguales para todos cada día), repaso pendiente y probabilidad de aprobar. Avisa cuando hay una versión nueva. A un preparador le recuerda las sesiones del día con sus alumnos. |
| **Temario** | Ejercicios → partes → temas, búsqueda, visor PDF con descarga para offline, marcar estudiado / en repaso. Organización del temario (bloques con el código de colores del PowerPoint, esquemas interactivos con las conexiones entre temas y «por dónde seguir»). Agenda de cada tema: apuntes para la próxima vuelta, vueltas dadas, cómo fue al cantarlo, test de las preguntas de ese tema y nota libre. Probabilidades calculadas como en el Excel de organización, con mapa de calor por probabilidad o por eficiencia, en 2D o en 3D. Recursos de organización. |
| **Cantes** | Tres subpestañas. **Agenda**: cantes con calendario mensual, cuenta atrás y avisos la víspera y una hora antes; repetición semanal; exportación a Google Calendar o a un `.ics`. **Cantar**: sorteo como en el examen (2 temas de cada parte; 1 por parte en el quinto) o de una bolsa propia (estudiados, en repaso, lista o los temas de un cante), con opción de dar prioridad a los temas flojos; cronómetro de preparación y exposición con avisos también en segundo plano, y grabación de audio. **Diario**: cómo fue cada cante, estadísticas por tema y temas flojos. Los cantes duran 30 minutos por defecto. |
| **Test** | Simulador con los mismos filtros y baremo que la web (temas, bloques, exámenes, nº de preguntas, tiempo, 1 / -0,33 / 0). Rejilla de navegación, imágenes, marcar preguntas. Resultados con puntuación por bloque y revisión. Estadísticas e historial unificado con la web. |
| **Más** | Convocatoria (fecha de cada ejercicio, que introduce siempre el usuario, e hitos propios) y horario de estudio semanal. **Preparadores** (ver más abajo). Cuenta (Google), recordatorio diario (desactivado por defecto), tema claro/oscuro, descargas, enlaces útiles y exportar/borrar datos. |

## Estructura

```
lib/
├── main.dart                  # Firebase + Hive + servicios; funciona sin credenciales Firebase (modo local)
├── app.dart                   # go_router: 5 bloques (/hoy, /temario, /cantes, /test, /mas); /examen y /resultados a pantalla completa
├── theme/app_theme.dart       # paleta, tipografías y componentes de styles.css (claro y oscuro)
├── core/                      # constants (URLs), cache_http (ETag + Hive), notificaciones, calendario (.ics), providers (Riverpod)
├── data/models/               # pregunta, resultado (esquema exam_results), temario, plan (cantes, horario, agenda), preparador (alumnos, enlace)
├── data/repos/                # contenido (web), usuario, plan y preparador (Hive + Firestore), descargas (PDF)
├── features/test/             # motor_test (lógica pura), leitner (réplica de spaced-repetition.js), páginas
├── features/cantes/           # bloque Cantes: cabecera con las subpestañas Agenda, Cantar y Diario
├── features/cantar/           # sorteo (probabilidades del Excel y sorteos), reloj_cante, vista Cantar, probabilidades
├── features/plan/             # vistas Agenda y Diario, cante, convocatoria, horario
├── features/preparador/       # «Tengo preparador» / «Soy preparador», ficha del alumno y sesión
├── features/organizacion/     # bloques, detalle de bloque y esquema interactivo del temario
├── features/{inicio,temario,mas}/
└── widgets/comunes.dart       # piezas de la web: cabecera, títulos de sección, tarjetas, grupos desplegables
test/                          # lógica (motor, Leitner, sorteo, plan, preparadores) y pruebas de humo de la app completa
tool/capturas_test.dart        # capturas de la app con datos de demostración (para la página y el vídeo)
promo/                         # capturas ligeras (.webp), vídeo de presentación y su póster
index.html                     # página pública de la app (victorgutierrezmarcos.es/app/)
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

## Preparadores

`data/repos/preparador_repo.dart` y `features/preparador/`. La sección tiene dos lados:

- **Soy preparador**: alumnos (enlazados o dados de alta a mano), sesiones de cante (un `Cante` con `alumno`; una por alumno aunque se programen en grupo), sorteo y cronómetro con la bolsa de temas del alumno (`CantarPage(sesion: …)`), valoración, ficha del alumno (temas que lleva, cantados y flojos, historial, notas privadas) e informe en texto para enviar (`informeCante`). Funciona sin cuenta, en local.
- **Tengo preparador**: el alumno escribe el código de seis caracteres de su preparador (`codigos/{codigo}` → uid). Al enlazar crea `users/{alumno}/preparadores/{preparador}` (el permiso) y `preparadores/{preparador}/alumnos/{alumno}` (para que el preparador lo vea en su lista). Desde entonces el preparador lee `users/{alumno}/progress/settings` (temas estudiados y en repaso) y `users/{alumno}/cantes`, y cada sesión que guarda se copia a `users/{alumno}/cantes/{id}`: aparece en la agenda del alumno y, una vez valorada, en su diario. No se comparten tests, notas ni grabaciones. Cualquiera de los dos puede romper el enlace.

El enlace exige que ambos hayan iniciado sesión con Google y que las reglas de `firestore.rules` estén aplicadas en la consola de Firebase. `test/preparador_test.dart` comprueba el flujo completo con Firestore simulado; las reglas no se pueden probar ahí (el simulador no admite funciones), así que hay que verificarlas con dos cuentas reales.

## Diseño

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

`test/app_test.dart` arranca la app completa sin Firebase ni red, con el `temario.json` y el `app-config.json` reales del repositorio, y recorre los cinco bloques y los flujos principales (programar un cante, sortear, cronometrar, guardar en el diario, hacer un test completo, agenda por tema, alta de un alumno y sesión de preparador).

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

## Distribución del APK de prueba

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
