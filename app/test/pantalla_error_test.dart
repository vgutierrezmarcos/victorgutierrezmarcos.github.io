// La pantalla que sustituye al rectángulo gris de Flutter cuando algo falla
// al construirse: explica, enseña el error y deja volver o ir al inicio.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/pantalla_error.dart';

void main() {
  testWidgets('explica el fallo, enseña el error y permite volver o ir al inicio', (tester) async {
    var alInicio = 0;
    PantallaError.alInicio = () => alInicio++;
    addTearDown(() => PantallaError.alInicio = null);
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PantallaError(FlutterErrorDetails(exception: StateError('No element'))))),
              child: const Text('Romper'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('Romper'));
    await tester.pumpAndSettle();
    expect(find.text('Esta pantalla ha fallado'), findsOneWidget);
    expect(find.textContaining('Bad state: No element'), findsOneWidget);
    await tester.tap(find.text('Ir al inicio'));
    await tester.pump();
    expect(alInicio, 1);
    await tester.tap(find.text('Volver'));
    await tester.pumpAndSettle();
    expect(find.text('Romper'), findsOneWidget);
  });

  testWidgets('sin tema ni navegador también se pinta (si falla la raíz de la app)', (tester) async {
    await tester.pumpWidget(PantallaError(FlutterErrorDetails(exception: Exception('raíz'))));
    expect(find.text('Esta pantalla ha fallado'), findsOneWidget);
    expect(find.text('Volver'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
