// La calculadora de probabilidad del test (todo lo que se elige se puede
// cambiar de verdad) y la tabla de preguntas por tema.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/frecuencia_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/theme/app_theme.dart';
import 'package:tcee_app/features/organizacion/probabilidad_test_page.dart';
import 'package:tcee_app/features/test/preguntas_por_tema_page.dart';

void main() {
  late FrecuenciaTest frecuencia;
  late List<Override> overrides;
  var n = 0;
  Future<Box> caja() => Hive.openBox('prob${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    frecuencia = FrecuenciaTest.fromJson(jsonDecode(File('../oposicion/temario/primer-ejercicio/test/frecuencia_temas.json').readAsStringSync()) as Map<String, dynamic>);
  });

  setUp(() async {
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja()),
        plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
        preparador: PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja()),
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_prob')),
        firebaseDisponible: false,
      )),
      frecuenciaTestProvider.overrideWith((ref) => frecuencia),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
    ];
  });

  Future<void> montar(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(800, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: MaterialApp(theme: AppTheme.claro, home: home)));
    await tester.pumpAndSettle();
  }

  bool conFoco(WidgetTester tester, Finder campo) => tester.state<EditableTextState>(find.descendant(of: campo, matching: find.byType(EditableText))).widget.focusNode.hasFocus;

  testWidgets('en «Pregunta a pregunta» se puede escribir un acierto propio sin perder el campo', (tester) async {
    await montar(tester, const ProbabilidadTestPage());
    expect(find.text('Pregunta a pregunta'), findsOneWidget);
    final acierto = find.widgetWithText(TextFormField, 'Aciertas (%)').first;
    await tester.tap(acierto);
    await tester.pump();
    // Carácter a carácter, como se teclea: el campo sigue siendo el mismo y con el foco.
    await tester.enterText(acierto, '7');
    await tester.pump();
    expect(conFoco(tester, acierto), isTrue, reason: 'al escribir el primer dígito el campo no se reconstruye');
    await tester.enterText(acierto, '70');
    await tester.pump();
    expect(conFoco(tester, acierto), isTrue);
    expect(find.descendant(of: acierto, matching: find.text('70')), findsOneWidget);
    // Borrarlo del todo vuelve a lo que diga el ajuste general, sin perder el foco.
    await tester.enterText(acierto, '');
    await tester.pump();
    expect(conFoco(tester, acierto), isTrue);
    // Lo demás que se elige también cambia: cuántas, qué hacer con ellas y el descarte.
    final cuantas = find.widgetWithText(TextFormField, 'Cuántas').first;
    await tester.enterText(cuantas, '30');
    await tester.pump();
    expect(find.descendant(of: cuantas, matching: find.text('30')), findsOneWidget);
    await tester.tap(find.text('2 opciones'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Con dos opciones descartadas'), findsOneWidget);
    await tester.tap(find.text('Mucho más'));
    await tester.pumpAndSettle();
    expect(find.textContaining('hace 5 años cuenta la mitad'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('el número de preguntas y las opciones del examen se cambian y la lista de grupos se rehace', (tester) async {
    await montar(tester, const ProbabilidadTestPage());
    final opciones = find.widgetWithText(TextFormField, 'Opciones por pregunta');
    await tester.enterText(opciones, '3');
    await tester.pumpAndSettle();
    expect(find.text('Ni idea (entre 3)'), findsOneWidget);
    expect(find.text('Dudo entre 3'), findsNothing);
    final preguntas = find.widgetWithText(TextFormField, 'Preguntas');
    await tester.enterText(preguntas, '40');
    await tester.pumpAndSettle();
    expect(find.textContaining('Preguntas que hay que saberse'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('la tabla de preguntas por tema se ordena, se filtra y enseña cada examen', (tester) async {
    await montar(tester, const PreguntasPorTemaPage());
    expect(find.text('Preguntas por tema'), findsOneWidget);
    List<String> codigos() => [for (final t in tester.widgetList<Text>(find.textContaining(RegExp(r'^3\.[AB]\.\d+$')))) t.data!];
    expect(codigos().length, frecuencia.temas.length);
    expect(frecuencia.masPreguntados(PesoRecientes.mas).first, codigos().first);
    await tester.tap(find.text('Por tema'));
    await tester.pumpAndSettle();
    expect(codigos().first, '3.A.1');
    await tester.tap(find.text('B').last);
    await tester.pumpAndSettle();
    expect(codigos().every((c) => c.startsWith('3.B.')), isTrue);
    expect(codigos().first, '3.B.1');
    await tester.tap(find.text('3.B.1'));
    await tester.pumpAndSettle();
    expect(find.textContaining('de ${frecuencia.examenes.length} exámenes.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
