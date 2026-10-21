import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/oposicion.dart';

import 'pdf_local.dart';

export 'pdf_local.dart';

/// PDFs en el navegador: se descargan al abrirlos y se guardan en memoria
/// mientras la pestaña siga abierta. No hay lectura sin conexión.
class DescargasRepo {
  DescargasRepo();
  final _dio = Dio();
  final _memoria = <String, Uint8List>{};

  static Future<DescargasRepo> crear({Oposicion oposicion = Oposiciones.tcee}) async => DescargasRepo();

  bool descargado(String url, {String? nombre}) => false;

  int tamanoTotal() => 0;

  bool get guardaSinConexion => false;

  /// [nombre] y [reemplaza] (nombre local y versiones viejas en el móvil) no
  /// hacen falta aquí: la URL ya distingue cada versión.
  Future<PdfLocal> abrir(String url, {String? nombre, String? reemplaza, void Function(int, int)? progreso}) async =>
      PdfLocal(bytes: await bytes(url, progreso: progreso));

  /// El contenido del fichero (en memoria mientras la pestaña siga abierta).
  Future<Uint8List> bytes(String url, {String? nombre, String? reemplaza, void Function(int, int)? progreso}) async {
    // Siempre una copia: pdf.js transfiere a su worker el búfer que recibe y
    // lo deja «detached», y al volver a abrir el mismo tema fallaba con
    // «Cannot perform Construct on a detached ArrayBuffer».
    final guardado = _memoria[url];
    if (guardado != null) return Uint8List.fromList(guardado);
    final r = await _dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes), onReceiveProgress: progreso);
    final bytes = Uint8List.fromList(r.data ?? const []);
    _memoria[url] = bytes;
    return Uint8List.fromList(bytes);
  }

  Future<void> borrar(String url, {String? nombre}) async => _memoria.remove(url);

  Future<void> borrarTodo() async => _memoria.clear();
}
