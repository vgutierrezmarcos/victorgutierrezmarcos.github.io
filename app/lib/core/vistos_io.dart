import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File> _fichero() async => File('${(await getApplicationDocumentsDirectory()).path}/avisos_red.json');

Future<Set<String>> leerVistos() async {
  try {
    final f = await _fichero();
    if (!f.existsSync()) return {};
    return {for (final e in jsonDecode(await f.readAsString()) as List) e.toString()};
  } catch (_) {
    return {};
  }
}

Future<void> guardarVistos(Set<String> vistos) async {
  try {
    // Solo los últimos: los avisos viejos ya no vuelven a salir.
    final lista = vistos.toList();
    await (await _fichero()).writeAsString(jsonEncode(lista.length > 500 ? lista.sublist(lista.length - 500) : lista));
  } catch (_) {}
}
