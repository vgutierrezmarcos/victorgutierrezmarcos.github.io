import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/resenas.dart';

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('resenas${n++}', bytes: Uint8List(0));
  tearDown(Resenas.reiniciar);

  test('sin caja no hace nada', () {
    Resenas.momento();
    expect(Resenas.pendiente.value, isFalse);
  });

  test('al tercer momento bueno queda pendiente, y una sola vez', () async {
    Resenas.iniciar(await caja());
    Resenas.momento();
    Resenas.momento();
    expect(Resenas.pendiente.value, isFalse);
    Resenas.momento();
    expect(Resenas.pendiente.value, isTrue);
    expect(Resenas.estado, 'pendiente');
    Resenas.resuelta();
    expect(Resenas.pendiente.value, isFalse);
    expect(Resenas.estado, 'hecha');
    for (var i = 0; i < 5; i++) {
      Resenas.momento();
    }
    expect(Resenas.pendiente.value, isFalse);
    expect(Resenas.momentos, 3);
  });

  test('lo pendiente sobrevive al reinicio', () async {
    final c = await caja();
    Resenas.iniciar(c);
    for (var i = 0; i < 3; i++) {
      Resenas.momento();
    }
    Resenas.reiniciar();
    Resenas.iniciar(c);
    expect(Resenas.pendiente.value, isTrue);
  });
}
