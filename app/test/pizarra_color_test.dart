// Los colores de la pizarra: el color elegido (a un toque o en el selector)
// es el del trazo que se pinta después, y «Pintar del color» cambia el de los
// trazos rodeados con el lazo.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';
import 'package:tcee_app/features/cantar/pizarra_trazos.dart';

const _lienzo = Offset(600, 500);

Future<PizarraLocal> montar(WidgetTester tester, {Size tamano = const Size(1200, 800)}) async {
  tester.view.physicalSize = tamano;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final fuente = PizarraLocal();
  await tester.pumpWidget(ProviderScope(child: MaterialApp(home: PizarraPage.individual(fuente: fuente))));
  await tester.pumpAndSettle();
  return fuente;
}

List<Trazo> trazos(PizarraLocal f) => [for (final p in f.paginas) ...p.trazos];

Future<void> raya(WidgetTester tester, Offset desde, {Offset paso = const Offset(6, 2), int puntos = 8}) async {
  final g = await tester.createGesture(kind: PointerDeviceKind.touch, pointer: 7);
  var t = const Duration(seconds: 1);
  await g.down(desde, timeStamp: t);
  for (var i = 1; i <= puntos; i++) {
    t += const Duration(milliseconds: 16);
    await g.moveTo(desde + paso * i.toDouble(), timeStamp: t);
    await tester.pump(const Duration(milliseconds: 16));
  }
  await g.up(timeStamp: t + const Duration(milliseconds: 16));
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  testWidgets('un color a un toque pinta el trazo de ese color', (tester) async {
    final fuente = await montar(tester);
    await tester.tap(find.bySemanticsLabel('Rojo'));
    await tester.pumpAndSettle();
    await raya(tester, _lienzo);
    expect(trazos(fuente).single.color, 0xFFC62828);
  });

  testWidgets('el selector de cualquier color pinta el trazo del color elegido', (tester) async {
    final fuente = await montar(tester);
    await tester.tap(find.bySemanticsLabel('Otro color'));
    await tester.pumpAndSettle();
    expect(find.text('Elige un color'), findsOneWidget);
    // Un color concreto de la paleta del selector.
    await tester.tap(find.bySemanticsLabel('Naranja'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Usar este color'));
    await tester.pumpAndSettle();
    await raya(tester, _lienzo);
    final c = trazos(fuente).single.color!;
    expect(coloresRapidos.contains(c), isFalse);
  });

  testWidgets('el selector de color cabe en un móvil apaisado', (tester) async {
    await montar(tester, tamano: const Size(740, 360));
    await tester.tap(find.bySemanticsLabel('Otro color'));
    await tester.pumpAndSettle();
    expect(find.text('Elige un color'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
  });

  testWidgets('pintar del color cambia los trazos rodeados con el lazo', (tester) async {
    final fuente = await montar(tester);
    await raya(tester, _lienzo);
    expect(trazos(fuente).single.color, coloresRapidos[0]);
    // Se activa el lazo desde el menú y se rodea el trazo.
    await tester.tap(find.byTooltip('Más herramientas y opciones'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lazo (seleccionar y mover)'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Lazo: rodea trazos para moverlos'));
    await tester.pumpAndSettle();
    final g = await tester.createGesture(kind: PointerDeviceKind.touch, pointer: 9);
    var t = const Duration(seconds: 3);
    final esquinas = [const Offset(560, 460), const Offset(700, 460), const Offset(700, 560), const Offset(560, 560), const Offset(560, 460)];
    await g.down(esquinas.first, timeStamp: t);
    for (final e in esquinas.skip(1)) {
      t += const Duration(milliseconds: 16);
      await g.moveTo(e, timeStamp: t);
      await tester.pump(const Duration(milliseconds: 16));
    }
    await g.up(timeStamp: t + const Duration(milliseconds: 16));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Verde'));
    await tester.pumpAndSettle();
    expect(trazos(fuente).single.color, 0xFF2E7D32);
  });
}
