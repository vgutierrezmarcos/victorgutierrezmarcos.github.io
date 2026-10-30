import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

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

/// Descarga un fichero binario (un PDF) desde el navegador.
Future<void> guardarBytes({required String nombre, required List<int> bytes, required String mime, String? asunto}) async {
  final blob = web.Blob([Uint8List.fromList(bytes).toJS].toJS, web.BlobPropertyBag(type: mime));
  final url = web.URL.createObjectURL(blob);
  final a = web.HTMLAnchorElement()
    ..href = url
    ..download = nombre;
  web.document.body?.append(a);
  a.click();
  a.remove();
  Future.delayed(const Duration(seconds: 30), () => web.URL.revokeObjectURL(url));
}

/// Descarga varios ficheros desde el navegador, uno tras otro.
Future<void> guardarVarios(List<({String nombre, List<int> bytes, String mime})> ficheros, {String? asunto}) async {
  for (final f in ficheros) {
    await guardarBytes(nombre: f.nombre, bytes: f.bytes, mime: f.mime.startsWith('text/') ? '${f.mime};charset=utf-8' : f.mime, asunto: asunto);
    // Algunos navegadores ignoran la segunda descarga si va pegada a la primera.
    await Future.delayed(const Duration(milliseconds: 400));
  }
}

/// En el navegador la grabación vive en memoria: la grabadora devuelve una URL
/// blob: al parar, y no hace falta ruta.
Future<String> rutaNuevaGrabacion(String nombre) async => '';

void borrarGrabacion(String ruta) {
  if (ruta.startsWith('blob:')) web.URL.revokeObjectURL(ruta);
}


/// En el navegador no hay ficheros propios: nunca existen.
bool existeFichero(String ruta) => false;
