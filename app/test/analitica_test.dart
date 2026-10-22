// Estadísticas de uso anónimas e informes de errores: apagadas hasta que el
// usuario dice que sí; se le pregunta una sola vez y lo cambia en Ajustes.
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/analitica.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/inicio/estadisticas_dialogo.dart';

/// Apunta lo que se le pide, sin Firebase.
class AnaliticaDePrueba extends AnaliticaNula {
  final llamadas = <String>[];
  bool? activada;
  @override
  bool get disponible => true;
  @override
  bool get activa => activada ?? false;
  @override
  Future<void> activar(bool activo) async {
    activada = activo;
    llamadas.add('activar:$activo');
  }

  @override
  void pantalla(String nombre) => llamadas.add('pantalla:$nombre');
  @override
  void evento(String nombre, {Map<String, Object> parametros = const {}}) => llamadas.add('evento:$nombre');
}

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('analitica${n++}', bytes: Uint8List(0));

  late AnaliticaDePrueba analitica;
  late UsuarioRepo usuario;

  setUp(() async {
    analitica = AnaliticaDePrueba();
    Analitica.instancia = analitica;
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
  });
  tearDown(() => Analitica.instancia = AnaliticaNula());

  Future<ProviderContainer> arrancar(WidgetTester tester) async {
    late ProviderContainer contenedor;
    await tester.pumpWidget(ProviderScope(
      overrides: [usuarioRepoProvider.overrideWithValue(usuario)],
      child: MaterialApp(
        home: Consumer(builder: (context, ref, _) {
          contenedor = ProviderScope.containerOf(context);
          return Scaffold(body: TextButton(onPressed: () => preguntarEstadisticasSiToca(context, ref), child: const Text('Arrancar')));
        }),
      ),
    ));
    await tester.tap(find.text('Arrancar'));
    await tester.pumpAndSettle();
    return contenedor;
  }

  test('el ajuste se guarda y se lee (null = sin contestar)', () {
    expect(const Ajustes().estadisticas, isNull);
    expect(Ajustes.fromJson(const Ajustes().copyWith(estadisticas: true).toJson()).estadisticas, isTrue);
    expect(Ajustes.fromJson({'estadisticas': false}).estadisticas, isFalse);
  });

  test('el nombre de pantalla no lleva consulta ni identificadores', () {
    expect(Analitica.nombreDePantalla('/hoy'), '/hoy');
    expect(Analitica.nombreDePantalla('/organizacion/cronograma?semana=3'), '/organizacion/cronograma');
    expect(Analitica.nombreDePantalla('/cantes/a1b2c3d4'), '/cantes/_');
    expect(Analitica.nombreDePantalla('/'), '/');
  });

  testWidgets('sin contestar, pregunta; «Sí, ayudar» lo guarda y lo enciende', (tester) async {
    final c = await arrancar(tester);
    expect(find.text('¿Nos ayudas a mejorar la app?'), findsOneWidget);
    expect(analitica.llamadas, isEmpty);
    await tester.tap(find.text('Sí, ayudar'));
    await tester.pumpAndSettle();
    expect(c.read(ajustesProvider).estadisticas, isTrue);
    expect(usuario.ajustes().estadisticas, isTrue);
    expect(analitica.llamadas, ['activar:true']);
  });

  testWidgets('«No, gracias» lo deja apagado y no vuelve a preguntar', (tester) async {
    final c = await arrancar(tester);
    await tester.tap(find.text('No, gracias'));
    await tester.pumpAndSettle();
    expect(c.read(ajustesProvider).estadisticas, isFalse);
    expect(analitica.llamadas, ['activar:false']);
    await tester.tap(find.text('Arrancar'));
    await tester.pumpAndSettle();
    expect(find.text('¿Nos ayudas a mejorar la app?'), findsNothing);
  });

  testWidgets('con el ajuste en false no sale el diálogo ni se llama a nada', (tester) async {
    await usuario.guardarAjustes(const Ajustes(estadisticas: false));
    await arrancar(tester);
    expect(find.text('¿Nos ayudas a mejorar la app?'), findsNothing);
    expect(analitica.llamadas, isEmpty);
  });

  testWidgets('si no se puede medir (sin Firebase, pruebas), no se pregunta', (tester) async {
    Analitica.instancia = AnaliticaNula();
    await arrancar(tester);
    expect(find.text('¿Nos ayudas a mejorar la app?'), findsNothing);
  });

  test('la nula no hace nada aunque se le pida', () async {
    final nula = AnaliticaNula();
    await nula.iniciar(true);
    nula.pantalla('/hoy');
    nula.evento('test_terminado', parametros: {'preguntas': 10});
    nula.error(StateError('x'), null);
    expect(nula.activa, isFalse);
  });
}
