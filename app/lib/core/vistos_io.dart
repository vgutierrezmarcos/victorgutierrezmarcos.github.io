import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> _fichero(String lista) async => File('${(await getApplicationDocumentsDirectory()).path}/$lista.json');

/// Ids guardados en la [lista] (por defecto, los avisos de la red ya vistos).
Future<Set<String>> leerVistos({String lista = 'avisos_red'}) async {
  try {
    final f = await _fichero(lista);
    if (!f.existsSync()) return {};
    return {for (final e in jsonDecode(await f.readAsString()) as List) e.toString()};
  } catch (_) {
    return {};
  }
}

Future<void> guardarVistos(Set<String> vistos, {String lista = 'avisos_red', int maximo = 500}) async {
  try {
    // Solo los últimos: los avisos viejos ya no vuelven a salir.
    final l = vistos.toList();
    await (await _fichero(lista)).writeAsString(jsonEncode(l.length > maximo ? l.sublist(l.length - maximo) : l));
  } catch (_) {}
}
