import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// El último aviso mostrado (para esperar a que se vaya antes de contar el
/// tiempo del siguiente, que no sale hasta entonces).
Future<void>? _anterior;

/// Avisos (SnackBar) que se van solos. Flutter cierra los normales al acabar
/// su duración, pero en algunos dispositivos se han quedado fijos, y los que
/// tienen un botón («Ver», «Deshacer») no se cierran nunca. Un temporizador
/// propio los cierra: los normales, poco después de su duración; los de
/// botón, a los 8 s (para dar tiempo a tocarlo).
extension AvisosBreves on ScaffoldMessengerState {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mostrar(SnackBar aviso) {
    final c = showSnackBar(aviso);
    // En depuración (y en las pruebas, que no admiten temporizadores
    // pendientes) se deja a Flutter.
    if (kDebugMode) return c;
    final dura = aviso.action == null ? aviso.duration + const Duration(milliseconds: 1500) : const Duration(seconds: 8);
    Timer? respaldo;
    var cerrado = false;
    final anterior = _anterior;
    final cierre = c.closed.whenComplete(() {
      cerrado = true;
      respaldo?.cancel();
    });
    _anterior = cierre;
    final Future<void> mostrado = anterior == null ? Future.value() : anterior.catchError((_) {});
    mostrado.whenComplete(() {
      if (cerrado) return;
      respaldo = Timer(dura, () {
        if (!cerrado && mounted) hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
      });
    });
    return c;
  }
}
