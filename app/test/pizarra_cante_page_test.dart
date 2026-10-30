// La pizarra de Cantar: dura lo que el cante aunque se cierre y, con una
// cronología, anota cada trazo con el tiempo de exposición.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/pizarra_cante.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';

Future<void> raya(WidgetTester tester, Offset desde) async {
  final g = await tester.createGesture(kind: PointerDeviceKind.touch, pointer: 7);
  var t = const Duration(seconds: 1);
  await g.down(desde, timeStamp: t);
  for (var i = 1; i <= 8; i++) {
    t += const Duration(milliseconds: 16);
    await g.moveTo(desde + const Offset(6, 2) * i.toDouble(), timeStamp: t);
    await tester.pump(const Duration(milliseconds: 16));
  }
  await g.up(timeStamp: t + const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 50));
}

Future<void> abrir(WidgetTester tester, PizarraLocal fuente, CronologiaPizarra c) async {
  await tester.pumpWidget(ProviderScope(child: MaterialApp(home: PizarraPage.individual(key: UniqueKey(), fuente: fuente, cronologia: c))));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('cada trazo queda anotado con el tiempo de exposición, y al volver a abrirla sigue ahí', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    var expuesto = const Duration(minutes: 2, seconds: 5);
    final c = CronologiaPizarra(reloj: (_) => expuesto, tema: () => '3.A.8');
    final fuente = PizarraLocal();
    await abrir(tester, fuente, c);
    await raya(tester, const Offset(600, 500));
    await tester.pumpAndSettle();
    expect(c.eventos.map((e) => (e.tipo, e.en, e.tema)), [(TipoEventoPizarra.poner, const Duration(minutes: 2, seconds: 5), '3.A.8')]);
    // Se cierra y se vuelve a abrir: el trazo sigue y no se anota otra vez.
    await tester.pumpWidget(const SizedBox());
    expuesto = const Duration(minutes: 4);
    await abrir(tester, fuente, c);
    expect(c.eventos, hasLength(1));
    await raya(tester, const Offset(300, 300));
    await tester.pumpAndSettle();
    expect(c.eventos.map((e) => e.en), const [Duration(minutes: 2, seconds: 5), Duration(minutes: 4)]);
    expect(c.paginas(fecha: DateTime(2026, 11, 3)).map((p) => p.trazos.length), [1, 2]);
  });
}
