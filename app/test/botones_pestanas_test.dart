import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/theme/app_theme.dart';
import 'package:tcee_app/widgets/comunes.dart';

/// Las subpestañas como botones ([BotonesPestanas]): pintan texto, icono y
/// cifra, cambian de índice al tocarlos y en estrecho se quedan con la cifra corta.
void main() {
  Widget envuelto(Widget hijo, {double ancho = 411}) => MaterialApp(
        theme: AppTheme.claro,
        home: Scaffold(body: Center(child: SizedBox(width: ancho, child: hijo))),
      );

  final pestanas = [
    const PestanaBoton(texto: 'Temas', icono: Icons.menu_book_outlined, cifra: '177', descripcion: 'Temas del temario: 177'),
    const PestanaBoton(texto: 'Test', icono: Icons.fact_check_outlined, cifra: '1.004 preguntas', cifraCorta: '1.004', descripcion: 'Simulador de test'),
  ];

  testWidgets('pinta las pestañas con su icono y su cifra, y al tocar cambia el índice', (tester) async {
    var indice = 0;
    await tester.pumpWidget(envuelto(StatefulBuilder(builder: (c, set) => BotonesPestanas(indice: indice, pestanas: pestanas, onCambiar: (i) => set(() => indice = i)))));
    expect(find.text('Temas · 177', findRichText: true), findsOneWidget);
    expect(find.text('Test · 1.004 preguntas', findRichText: true), findsOneWidget);
    expect(find.byIcon(Icons.menu_book_outlined), findsOneWidget);
    expect(find.byIcon(Icons.fact_check_outlined), findsOneWidget);
    expect(find.byTooltip('Simulador de test'), findsOneWidget);

    await tester.tap(find.text('Test · 1.004 preguntas', findRichText: true));
    await tester.pumpAndSettle();
    expect(indice, 1);
    final boton = tester.widget<SegmentedButton<int>>(find.byType(SegmentedButton<int>));
    expect(boton.selected, {1});
  });

  testWidgets('en estrecho usa la cifra corta', (tester) async {
    await tester.pumpWidget(envuelto(BotonesPestanas(indice: 0, pestanas: pestanas, onCambiar: (_) {}), ancho: 300));
    expect(find.text('Test · 1.004', findRichText: true), findsOneWidget);
    expect(find.text('Test · 1.004 preguntas', findRichText: true), findsNothing);
  });

  testWidgets('sin cifra, solo el texto; y un índice fuera de rango no rompe', (tester) async {
    await tester.pumpWidget(envuelto(BotonesPestanas(
      indice: 5,
      pestanas: const [PestanaBoton(texto: 'Clases', icono: Icons.school_outlined), PestanaBoton(texto: 'Cantar', icono: Icons.mic_none)],
      onCambiar: (_) {},
    )));
    expect(find.text('Clases', findRichText: true), findsOneWidget);
    expect(find.text('Cantar', findRichText: true), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('las cifras llevan el punto de los miles en español', () {
    expect(cifraEs(1004), '1.004');
    expect(cifraEs(177), '177');
  });
}
