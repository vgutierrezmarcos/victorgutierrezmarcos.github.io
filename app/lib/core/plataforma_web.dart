import 'dart:convert';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Descarga un fichero de texto (.ics, .json) desde el navegador.
Future<void> guardarFichero({required String nombre, required String contenido, required String mime, String? asunto}) async {
  final bytes = utf8.encode(contenido);
  final blob = web.Blob([bytes.toJS].toJS, web.BlobPropertyBag(type: '$mime;charset=utf-8'));
  final url = web.URL.createObjectURL(blob);
  final a = web.HTMLAnchorElement()
    ..href = url
    ..download = nombre;
  web.document.body?.append(a);
  a.click();
  a.remove();
  // Algunos navegadores leen el blob después del clic: se libera más tarde.
  Future.delayed(const Duration(seconds: 30), () => web.URL.revokeObjectURL(url));
}

/// En el navegador la grabación vive en memoria: la grabadora devuelve una URL
/// blob: al parar, y no hace falta ruta.
Future<String> rutaNuevaGrabacion(String nombre) async => '';

void borrarGrabacion(String ruta) {
  if (ruta.startsWith('blob:')) web.URL.revokeObjectURL(ruta);
}
