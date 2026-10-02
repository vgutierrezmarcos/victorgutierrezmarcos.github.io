import 'dart:convert';

import 'package:web/web.dart' as web;

const _clave = 'tcee_avisos_red';

Future<Set<String>> leerVistos() async {
  try {
    final t = web.window.localStorage.getItem(_clave);
    return t == null ? {} : {for (final e in jsonDecode(t) as List) e.toString()};
  } catch (_) {
    return {};
  }
}

Future<void> guardarVistos(Set<String> vistos) async {
  try {
    final lista = vistos.toList();
    web.window.localStorage.setItem(_clave, jsonEncode(lista.length > 500 ? lista.sublist(lista.length - 500) : lista));
  } catch (_) {}
}
