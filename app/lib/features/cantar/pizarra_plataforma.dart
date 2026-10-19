// Lo que la pizarra necesita del navegador y no existe en el móvil: ver los
// eventos del lápiz antes que el motor de Flutter y evitar que iPadOS se los
// quede (Scribble).
export 'pizarra_io.dart' if (dart.library.js_interop) 'pizarra_web.dart';
