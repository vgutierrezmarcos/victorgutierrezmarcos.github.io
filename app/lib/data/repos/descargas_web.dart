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

  bool descargado(String url) => false;

  int tamanoTotal() => 0;

  bool get guardaSinConexion => false;

  Future<PdfLocal> abrir(String url, {void Function(int, int)? progreso}) async {
    final guardado = _memoria[url];
    if (guardado != null) return PdfLocal(bytes: guardado);
    final r = await _dio.get<List<int>>(url, options: Options(responseType: ResponseType.bytes), onReceiveProgress: progreso);
    final bytes = Uint8List.fromList(r.data ?? const []);
    _memoria[url] = bytes;
    return PdfLocal(bytes: bytes);
  }

  Future<void> borrar(String url) async => _memoria.remove(url);

  Future<void> borrarTodo() async => _memoria.clear();
}
