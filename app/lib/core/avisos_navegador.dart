// Avisos de la app en el navegador (con la pestaña abierta): los muestra el
// service worker de los avisos (web/avisos-sw.js) a través de
// window.avisosApp (web/index.html). En el móvil no existen.
export 'avisos_navegador_io.dart' if (dart.library.js_interop) 'avisos_navegador_web.dart';
