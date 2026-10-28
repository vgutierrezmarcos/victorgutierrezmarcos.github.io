import 'dart:io';

import 'package:flutter/services.dart';

// Los mismos canales de MainActivity.kt que usa permisos_io.dart.
const _canal = MethodChannel('es.victorgutierrezmarcos.tcee_app/sistema');
const _entrantes = EventChannel('es.victorgutierrezmarcos.tcee_app/enlaces');

/// El enlace con el que se abrió la app (o null si se abrió desde el icono).
Future<Uri?> enlaceInicial() async {
  if (!Platform.isAndroid) return null;
  try {
    final s = await _canal.invokeMethod<String>('enlaceInicial');
    return s == null ? null : Uri.tryParse(s);
  } catch (_) {
    return null;
  }
}

/// Enlaces que llegan con la app ya abierta.
Stream<Uri> enlacesEntrantes() {
  if (!Platform.isAndroid) return const Stream.empty();
  try {
    return _entrantes.receiveBroadcastStream().map((e) => Uri.tryParse('$e')).where((u) => u != null).cast<Uri>();
  } catch (_) {
    return const Stream.empty();
  }
}

/// El `referrer` con el que Google Play instaló la app (texto libre que lleva
/// el enlace de la ficha, p. ej. `codigo=ABC234&op=tcee`), o null si no lo
/// hay, la app no viene de Play o Play no contesta a tiempo.
Future<String?> referrerInstalacion() async {
  if (!Platform.isAndroid) return null;
  try {
    return await _canal.invokeMethod<String>('referrerInstalacion').timeout(const Duration(seconds: 4));
  } catch (_) {
    return null;
  }
}
