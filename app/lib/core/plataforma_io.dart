import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Entrega un fichero de texto (.ics, .json) con el menú de compartir del móvil.
Future<void> guardarFichero({required String nombre, required String contenido, required String mime, String? asunto}) async {
  final dir = await getTemporaryDirectory();
  final f = File('${dir.path}/$nombre');
  await f.writeAsString(contenido, encoding: utf8);
  await SharePlus.instance.share(ShareParams(files: [XFile(f.path, mimeType: mime)], subject: asunto));
}

/// Ruta donde guardar una grabación nueva (en el móvil, en sus documentos).
Future<String> rutaNuevaGrabacion(String nombre) async {
  final dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/$nombre';
}

void borrarGrabacion(String ruta) {
  try {
    File(ruta).deleteSync();
  } catch (_) {}
}
