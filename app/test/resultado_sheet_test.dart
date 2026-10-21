import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/plan/resultado_sheet.dart';
import 'package:tcee_app/theme/app_theme.dart';
import 'package:tcee_app/widgets/comunes.dart';

/// La hoja de valoración de un cante: con varios temas, cada uno con sus
/// estrellas; y los temas se pueden cambiar, quitar y añadir a posteriori.
void main() {
  Tema tema(String codigo) => Tema(codigo: codigo, titulo: 'Tema $codigo', disponible: true, temarioAnterior: false);
  final bolsa = [tema('3.A.1'), tema('3.A.2'), tema('3.B.1'), tema('3.B.2')];

  /// Monta una pantalla con un botón que abre la hoja; lo que devuelve la hoja
  /// queda en [guardado].
  final guardado = <ResultadoCante?>[];
  Future<void> abrir(WidgetTester tester, ResultadoCante inicial, {List<Tema> opciones = const []}) async {
    tester.view.physicalSize = const Size(480, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    guardado.clear();
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.claro,
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async => guardado.add(await pedirResultadoCante(context, inicial: inicial, opciones: opciones)),
            child: const Text('Abrir'),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
  }

  /// Toca la estrella [n] (1-5) de la fila [fila] de estrellas editables.
  Future<void> estrella(WidgetTester tester, int fila, int n) async {
    final filas = find.byWidgetPredicate((w) => w is Estrellas && w.onChanged != null);
    final iconos = find.descendant(of: filas.at(fila), matching: find.byType(GestureDetector));
    await tester.tap(iconos.at(n - 1));
    await tester.pumpAndSettle();
  }

  testWidgets('dos temas: una fila de estrellas por tema y la media como valoración del cante', (tester) async {
    await abrir(tester, const ResultadoCante(temaCantado: '3.A.1', otrosCantados: ['3.B.2'], segundos: 2400), opciones: bolsa);
    expect(find.text('Tema 1'), findsOneWidget);
    expect(find.text('Tema 2'), findsOneWidget);
    expect(find.byWidgetPredicate((w) => w is Estrellas && w.onChanged != null), findsNWidgets(2));
    await estrella(tester, 0, 4);
    await estrella(tester, 1, 2);
    await tester.tap(find.text('Guardar en el diario'));
    await tester.pumpAndSettle();
    final res = guardado.single!;
    expect(res, isNotNull);
    expect(res.temasCantados, ['3.A.1', '3.B.2']);
    expect(res.valoraciones, {'3.A.1': 4, '3.B.2': 2});
    expect(res.valoracion, 3);
    expect(res.segundos, 2400, reason: 'sin tocar los minutos se conserva el tiempo exacto');
    expect(res.valoracionDe('3.B.2'), 2);
  });

  testWidgets('quitar un tema y cambiar el otro por uno de la bolsa', (tester) async {
    await abrir(tester, const ResultadoCante(temaCantado: '3.A.1', otrosCantados: ['3.B.2'], valoraciones: {'3.A.1': 5, '3.B.2': 1}, valoracion: 3), opciones: bolsa);
    // Se quita el segundo: queda uno solo, con su valoración como la del cante.
    await tester.tap(find.byTooltip('Quitar este tema').last);
    await tester.pumpAndSettle();
    expect(find.text('Tema cantado'), findsOneWidget);
    // Y se cambia por otro de la bolsa.
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3.A.2 · Tema 3.A.2').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar en el diario'));
    await tester.pumpAndSettle();
    final res = guardado.single!;
    expect(res.temasCantados, ['3.A.2']);
    expect(res.valoraciones, isEmpty);
    expect(res.valoracion, 5);
  });

  testWidgets('añadir un segundo tema a un cante de uno', (tester) async {
    await abrir(tester, const ResultadoCante(temaCantado: '3.A.1', valoracion: 4), opciones: bolsa);
    await tester.tap(find.text('Añadir tema'));
    await tester.pumpAndSettle();
    expect(find.text('Tema 2'), findsOneWidget);
    await estrella(tester, 1, 3);
    await tester.tap(find.text('Guardar en el diario'));
    await tester.pumpAndSettle();
    final res = guardado.single!;
    expect(res.temasCantados, ['3.A.1', '3.A.2']);
    expect(res.valoraciones, {'3.A.1': 4, '3.A.2': 3});
    expect(res.valoracion, 4); // media 3,5 → 4
  });

  test('ida y vuelta por JSON y compatibilidad', () {
    const r = ResultadoCante(temaCantado: '3.A.1', otrosCantados: ['3.B.2'], valoracion: 3, valoraciones: {'3.A.1': 4, '3.B.2': 2});
    final j = r.toJson();
    expect(j['valoracion'], 3, reason: 'las versiones anteriores leen la media');
    expect(ResultadoCante.fromJson(j).valoraciones, {'3.A.1': 4, '3.B.2': 2});
    expect(const ResultadoCante(temaCantado: '3.A.1', valoracion: 4).toJson().containsKey('valoraciones'), isFalse);
    expect(const ResultadoCante(temaCantado: '3.A.1', valoracion: 4).valoracionDe('3.A.1'), 4);
    expect(ResultadoCante.media([4, 2]), 3);
    expect(ResultadoCante.media([4, 0]), 4);
    expect(ResultadoCante.media([0, 0]), 0);
    // Las estadísticas de cada tema usan su valoración, no la del cante.
    final stats = EstadisticaTema.desde([Cante(id: 'x', fecha: DateTime(2026, 10, 1), estado: EstadoCante.hecho, resultado: r)]);
    expect(stats['3.A.1']!.valoracionMedia, 4);
    expect(stats['3.B.2']!.valoracionMedia, 2);
    expect(stats['3.B.2']!.flojo, isTrue);
  });
}
