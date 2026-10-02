// Avisos de la red ya notificados. Se guardan en un fichero (móvil) o en el
// almacenamiento del navegador, y no en Hive, porque también los lee y escribe
// la comprobación en segundo plano, que corre en otro isolate.
export 'vistos_io.dart' if (dart.library.js_interop) 'vistos_web.dart';
