import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants.dart';

/// Descarga y gestión de PDFs para lectura offline.
class DescargasRepo {
  DescargasRepo(this._caja, this._dir);
  final Box _caja;
  final Directory _dir;
  final _dio = Dio();

  static Future<DescargasRepo> crear() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/pdf');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return DescargasRepo(await Hive.openBox(Cajas.descargas), dir);
  }

  String _nombre(String url) => url.split('/').last;

  File fichero(String url) => File('${_dir.path}/${_nombre(url)}');

  bool descargado(String url) => fichero(url).existsSync();

  int tamano(String url) => descargado(url) ? fichero(url).lengthSync() : 0;

  int tamanoTotal() =>
      _dir.listSync().whereType<File>().fold(0, (n, f) => n + f.lengthSync());

  Future<File> descargar(String url, {void Function(int recibido, int total)? progreso, CancelToken? cancel}) async {
    final destino = fichero(url);
    final tmp = File('${destino.path}.part');
    await _dio.download(url, tmp.path, onReceiveProgress: progreso, cancelToken: cancel);
    if (destino.existsSync()) destino.deleteSync();
    tmp.renameSync(destino.path);
    await _caja.put(_nombre(url), DateTime.now().millisecondsSinceEpoch);
    return destino;
  }

  /// Devuelve el fichero local, descargándolo si hace falta.
  Future<File> obtener(String url, {void Function(int, int)? progreso}) async {
    if (descargado(url)) return fichero(url);
    return descargar(url, progreso: progreso);
  }

  Future<void> borrar(String url) async {
    final f = fichero(url);
    if (f.existsSync()) f.deleteSync();
    await _caja.delete(_nombre(url));
  }

  Future<void> borrarTodo() async {
    for (final f in _dir.listSync().whereType<File>()) {
      f.deleteSync();
    }
    await _caja.clear();
  }
}
