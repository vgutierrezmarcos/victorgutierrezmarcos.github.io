// Descarga de PDFs: en el móvil se guardan para leerlos sin conexión; en el
// navegador se leen al momento (la caché del navegador hace el resto).
export 'descargas_io.dart' if (dart.library.js_interop) 'descargas_web.dart';
