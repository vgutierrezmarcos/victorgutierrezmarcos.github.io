import 'dart:convert';

import 'package:web/web.dart' as web;

/// Ids guardados en la [lista] (por defecto, los avisos de la red ya vistos).
Future<Set<String>> leerVistos({String lista = 'avisos_red'}) async {
  try {
    final t = web.window.localStorage.getItem('tcee_$lista');
    return t == null ? {} : {for (final e in jsonDecode(t) as List) e.toString()};
  } catch (_) {
    return {};
  }
}

Future<void> guardarVistos(Set<String> vistos, {String lista = 'avisos_red', int maximo = 500}) async {
  try {
    final l = vistos.toList();
    web.window.localStorage.setItem('tcee_$lista', jsonEncode(l.length > maximo ? l.sublist(l.length - maximo) : l));
  } catch (_) {}
}
