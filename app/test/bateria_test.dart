import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/permisos.dart';
import 'package:tcee_app/features/inicio/permisos_sheet.dart';

/// Que los avisos lleguen con la app cerrada: la batería y el ahorro propio de
/// cada fabricante.
void main() {
  test('consejos según la marca del móvil', () {
    expect(consejoFabricante('xiaomi')?.nombre, 'Xiaomi');
    expect(consejoFabricante('poco')?.nombre, 'Xiaomi');
    expect(consejoFabricante('samsung')?.pasos, contains('nunca se suspenden'));
    expect(consejoFabricante('oneplus')?.nombre, 'OnePlus');
    expect(consejoFabricante('google'), isNull);
    expect(consejoFabricante(null), isNull);
  });

  test('batería restringida solo si el sistema lo dice', () {
    expect(const EstadoPermisos(bateriaSinOptimizar: false).bateriaRestringida, isTrue);
    expect(const EstadoPermisos(bateriaSinOptimizar: true).bateriaRestringida, isFalse);
    expect(const EstadoPermisos().bateriaRestringida, isFalse);
  });

  testWidgets('a quien ya vio los avisos se le pide solo lo de la batería', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: Scaffold(body: HojaPermisos(soloBateria: true)))));
    expect(find.text('Que los avisos lleguen a su hora'), findsOneWidget);
    expect(find.text('Permitir en segundo plano'), findsOneWidget);
    expect(find.text('Permitir los avisos'), findsNothing);
  });
}
