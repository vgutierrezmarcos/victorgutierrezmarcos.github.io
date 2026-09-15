# Oposición TCEE · app móvil

App Flutter (Android e iOS) complementaria de [victorgutierrezmarcos.es](https://www.victorgutierrezmarcos.es). Todo el contenido (preguntas, temario, artículos, configuración) se descarga de la web, así que actualizar la web actualiza la app sin republicarla. Usa el mismo proyecto Firebase que la web (`web-vgm`): el historial de tests, el repaso Leitner, las notas y los ajustes se comparten entre web y app.

## Qué hace

| Pestaña | Funciones |
|---|---|
| **Inicio** | Countdown al examen (fecha editable), racha diaria, test diario (10 preguntas, iguales para todos cada día), repaso pendiente, último artículo. |
| **Test** | Simulador con los mismos filtros y baremo que la web (temas, bloques, exámenes, nº de preguntas, tiempo, 1 / -0,33 / 0). Rejilla de navegación, imágenes, marcar preguntas. Resultados con puntuación por bloque y revisión. Estadísticas (media, tendencia, evolución, rendimiento por bloque, cajas Leitner) e historial unificado con la web. |
| **Temario** | Ejercicios → partes → temas, búsqueda, visor PDF con descarga para offline, marcar estudiado / en repaso, notas propias por tema. Recursos de organización. |
| **Cantar** | Sorteo de temas con probabilidad hipergeométrica (réplica del Excel), cronómetro de exposición con avisos por vibración/notificación y grabación de audio para autoescucha. |
| **Más** | Blog (RSS, lectura, favoritos), comunidad, enlaces útiles, recordatorio diario, tema claro/oscuro, descargas, cuenta (Google), exportar/borrar datos. |

## Estructura

```
lib/
├── main.dart                  # Firebase + Hive + servicios; funciona sin credenciales Firebase (modo local)
├── app.dart                   # go_router con 5 pestañas; /examen y /resultados a pantalla completa
├── theme/app_theme.dart       # paleta y tipografías de styles.css (claro y oscuro)
├── core/                      # constants (URLs), cache_http (ETag + Hive), notificaciones, providers (Riverpod)
├── data/models/               # pregunta, resultado (esquema exam_results), temario, articulo
├── data/repos/                # contenido (web), usuario (Hive + Firestore), descargas (PDF)
├── features/test/             # motor_test (lógica pura), leitner (réplica de spaced-repetition.js), páginas
├── features/cantar/sorteo.dart# probabilidades y sorteo
└── features/{inicio,temario,blog,mas}/
test/                          # motor, Leitner y sorteo
```

Datos compartidos con la web (generados en el repo raíz):

- `oposicion/temario/primer-ejercicio/test/preguntas.json` y `bloques.json`
- `oposicion/temario/temario.json` y `oposicion/enlaces.json` (los crea `node build-app-data.js` en CI)
- `oposicion/app-config.json`: fecha del examen por defecto, URLs de comunidad y tiendas, avisos. Editar a mano.

Firestore (`users/{uid}/…`, reglas en `firestore.rules` del repo raíz):

- `exam_results/{id}`: mismo esquema que la web; la app añade `respuestas`, `origen`, `tipo`.
- `progress/spaced_repetition`: mismo formato que `localStorage.vgm_spaced_repetition` de la web.
- `progress/settings`: fecha, temas estudiados/en repaso, racha, recordatorio, tema.
- `notes/{tema}`: notas por tema.

## Puesta en marcha (una vez)

1. Instalar [Flutter](https://docs.flutter.dev/get-started/install) (stable ≥ 3.24) y Android Studio. Comprobar con `flutter doctor`.
2. Generar las carpetas nativas (no están en el repo):
   ```bash
   cd app
   flutter create --org es.victorgutierrezmarcos --project-name tcee_app --platforms android,ios .
   flutter pub get
   ```
   `flutter create` respeta los ficheros existentes (`lib/`, `pubspec.yaml`, `test/`).
3. Firebase (consola del proyecto **web-vgm**):
   - Añadir app Android con id `es.victorgutierrezmarcos.tcee_app` y las huellas SHA-1/SHA-256 (`cd android && ./gradlew signingReport`). Descargar `google-services.json` a `android/app/`.
   - Añadir app iOS con bundle id `es.victorgutierrezmarcos.tceeApp`. Descargar `GoogleService-Info.plist` a `ios/Runner/`.
   - En Authentication → Google debe estar habilitado (ya lo está para la web).
   - Aplicar `firestore.rules` (Firestore → Reglas) si aún no están.
   - Alternativa: `dart pub global activate flutterfire_cli && flutterfire configure --project=web-vgm` genera `lib/firebase_options.dart`; en ese caso cambiar `Firebase.initializeApp()` por `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
   Estos ficheros están en `.gitignore`; no se suben al repositorio.
4. Configuración nativa:
   - **Android** `android/app/build.gradle`: `minSdkVersion 23`, `multiDexEnabled true`; añadir el plugin `com.google.gms.google-services`. En `android/app/src/main/AndroidManifest.xml`: permisos `INTERNET`, `RECORD_AUDIO`, `POST_NOTIFICATIONS`, `VIBRATE`, `SCHEDULE_EXACT_ALARM` (opcional) y `RECEIVE_BOOT_COMPLETED` (para reprogramar el recordatorio).
   - **iOS** `ios/Runner/Info.plist`: `NSMicrophoneUsageDescription` ("Grabar tu exposición para escucharla después"), `CFBundleURLTypes` con el `REVERSED_CLIENT_ID` del plist de Firebase (Google Sign-In), `UIBackgroundModes` → `audio` si se quiere seguir grabando en segundo plano. `ios/Podfile`: `platform :ios, '13.0'`.
5. Icono: `dart run flutter_launcher_icons`.
6. Ejecutar: `flutter run` (emulador Android o dispositivo).

## Comprobaciones

```bash
flutter analyze
flutter test
```

Pruebas manuales: hacer un test de 10 preguntas sin sesión (queda en local), iniciar sesión y comprobar que aparece en el historial de la web y en `users/{uid}/exam_results`; modo avión con un PDF descargado; comparar con la web en claro y oscuro.

## Publicación

- **Android**: crear keystore (`keytool -genkey -v -keystore ~/tcee.jks -alias tcee -keyalg RSA -keysize 2048 -validity 10000`), `android/key.properties` (ignorado por git) y `flutter build appbundle --release`. Play Console: 25 $ una vez; las cuentas personales nuevas deben pasar una prueba cerrada con 12 testers durante 14 días antes de producción.
- **iOS**: Apple Developer Program (99 $/año). Sin Mac se puede compilar y firmar con [Codemagic](https://codemagic.io) (plan gratuito) o con un runner macOS de GitHub Actions. Subir a TestFlight y enviar a revisión.
- Ficha: icono 1024 px, capturas (iPhone 6,7" y 6,5"; teléfono Android), descripción, URL de privacidad `https://www.victorgutierrezmarcos.es/politica-cookies.html`.
- Cuando existan las URLs de las tiendas, ponerlas en `oposicion/app-config.json` (`urlPlayStore`, `urlAppStore`) y pegar el banner de descarga al principio de `oposicion/index.html`: el snippet y las instrucciones están en la cabecera de `app-banner.js`. Hasta entonces la web no menciona la app.
- El workflow `.github/workflows/build-app.yml` compila un APK de depuración en cada tag `app-v*` y lo adjunta a una release, útil para probar sin tiendas.
