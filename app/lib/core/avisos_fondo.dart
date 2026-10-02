// Comprobación de avisos de la red con la app cerrada: en Android, una tarea
// periódica (WorkManager, cada ~15 minutos con red); en el navegador no existe.
export 'avisos_fondo_io.dart' if (dart.library.js_interop) 'avisos_fondo_web.dart';
