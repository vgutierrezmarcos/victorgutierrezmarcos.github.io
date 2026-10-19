import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants.dart';
import '../models/oposicion.dart';
import 'pdf_local.dart';

export 'pdf_local.dart';

/// Descarga y gestión de PDFs para lectura offline.
class DescargasRepo {
  DescargasRepo(this._caja, this._dir);
  final Box _caja;
  final Directory _dir;
  final _dio = Dio();

  static Future<DescargasRepo> crear({Oposicion oposicion = Oposiciones.tcee}) async {
    final base = await getApplicationDocumentsDirectory();
    // Cada oposición, en su carpeta: los PDF se llaman por el código del tema.
    final dir = Directory('${base.path}/${oposicion.caja('pdf')}');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return DescargasRepo(await Hive.openBox(oposicion.caja(Cajas.descargas)), dir);
  }

  /// [nombre] fija el nombre local (el temario revisado lleva en él el hash
  /// del contenido); si no, el último tramo de la URL.
  String _nombre(String url, [String? nombre]) => nombre ?? url.split('/').last;

  File fichero(String url, {String? nombre}) => File('${_dir.path}/${_nombre(url, nombre)}');

  bool descargado(String url, {String? nombre}) => fichero(url, nombre: nombre).existsSync();

  int tamano(String url, {String? nombre}) => descargado(url, nombre: nombre) ? fichero(url, nombre: nombre).lengthSync() : 0;

  int tamanoTotal() =>
      _dir.listSync().whereType<File>().fold(0, (n, f) => n + f.lengthSync());

  Future<File> descargar(String url, {String? nombre, String? reemplaza, void Function(int recibido, int total)? progreso, CancelToken? cancel}) async {
    final destino = fichero(url, nombre: nombre);
    final tmp = File('${destino.path}.part');
    await _dio.download(url, tmp.path, onReceiveProgress: progreso, cancelToken: cancel);
    if (destino.existsSync()) destino.deleteSync();
    tmp.renameSync(destino.path);
    await _caja.put(_nombre(url, nombre), DateTime.now().millisecondsSinceEpoch);
    if (reemplaza != null) await _borrarVersionesViejas(reemplaza, destino);
    return destino;
  }

  /// Borra las otras versiones de un fichero (las que empiezan por [prefijo]).
  Future<void> _borrarVersionesViejas(String prefijo, File actual) async {
    for (final f in _dir.listSync().whereType<File>()) {
      final n = f.uri.pathSegments.last;
      if (n.startsWith(prefijo) && f.path != actual.path) {
        try {
          f.deleteSync();
        } catch (_) {}
        await _caja.delete(n);
      }
    }
  }

  /// Devuelve el fichero local, descargándolo si hace falta. Con [reemplaza]
  /// (prefijo común de sus versiones) se borran las versiones anteriores.
  Future<File> obtener(String url, {String? nombre, String? reemplaza, void Function(int, int)? progreso}) async {
    if (descargado(url, nombre: nombre)) return fichero(url, nombre: nombre);
    return descargar(url, nombre: nombre, reemplaza: reemplaza, progreso: progreso);
  }

  /// PDF listo para el visor: en el móvil, el fichero descargado.
  Future<PdfLocal> abrir(String url, {String? nombre, String? reemplaza, void Function(int, int)? progreso}) async =>
      PdfLocal(ruta: (await obtener(url, nombre: nombre, reemplaza: reemplaza, progreso: progreso)).path);

  /// El contenido del fichero (descargado y guardado para leerlo sin red).
  Future<Uint8List> bytes(String url, {String? nombre, String? reemplaza, void Function(int, int)? progreso}) async =>
      (await obtener(url, nombre: nombre, reemplaza: reemplaza, progreso: progreso)).readAsBytes();

  /// En el móvil los PDF se guardan para leerlos sin conexión.
  bool get guardaSinConexion => true;

  Future<void> borrar(String url, {String? nombre}) async {
    final f = fichero(url, nombre: nombre);
    if (f.existsSync()) f.deleteSync();
    await _caja.delete(_nombre(url, nombre));
  }

  Future<void> borrarTodo() async {
    for (final f in _dir.listSync().whereType<File>()) {
      f.deleteSync();
    }
    await _caja.clear();
  }
}
