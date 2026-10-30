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

/// Entrega un fichero binario (un PDF) con el menú de compartir del móvil.
Future<void> guardarBytes({required String nombre, required List<int> bytes, required String mime, String? asunto}) async {
  final dir = await getTemporaryDirectory();
  final f = File('${dir.path}/$nombre');
  await f.writeAsBytes(bytes);
  await SharePlus.instance.share(ShareParams(files: [XFile(f.path, mimeType: mime)], subject: asunto));
}

/// Entrega varios ficheros juntos con el menú de compartir del móvil (la
/// transcripción y la pizarra de un cante, para adjuntarlos a la vez).
Future<void> guardarVarios(List<({String nombre, List<int> bytes, String mime})> ficheros, {String? asunto}) async {
  final dir = await getTemporaryDirectory();
  final xs = <XFile>[];
  for (final f in ficheros) {
    final fichero = File('${dir.path}/${f.nombre}');
    await fichero.writeAsBytes(f.bytes);
    xs.add(XFile(fichero.path, mimeType: f.mime));
  }
  await SharePlus.instance.share(ShareParams(files: xs, subject: asunto));
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


/// Si existe el fichero [ruta] (las grabaciones guardadas en el móvil).
bool existeFichero(String ruta) {
  try {
    return File(ruta).existsSync();
  } catch (_) {
    return false;
  }
}
