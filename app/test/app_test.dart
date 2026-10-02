import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/cantar/sorteo.dart';
import 'package:tcee_app/features/plan/cante_page.dart';

/// Pruebas de humo de la app completa, sin Firebase ni red: usa los JSON
/// reales de la web (temario.json y app-config.json del repositorio).
void main() {
  late Temario temario;
  late AppConfig config;
  late UsuarioRepo usuario;
  late PlanRepo plan;
  late List<Override> overrides;
  var n = 0;

  Future<Box> caja() => Hive.openBox('prueba${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
  });

  setUp(() async {
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    plan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja());
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        http: http,
        contenido: ContenidoRepo(http),
        usuario: usuario,
        plan: plan,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_test')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
      articulosProvider.overrideWith((ref) => []),
    ];
  });

  Future<void> arrancar(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(480, 3200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pumpAndSettle();
  }

  Future<void> pestana(WidgetTester tester, String nombre) async {
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(nombre)));
    await tester.pumpAndSettle();
    // Segundo toque: vuelve a la raíz de la pestaña si se quedó en una subpágina.
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(nombre)));
    await tester.pumpAndSettle();
  }

  Future<void> tocar(WidgetTester tester, Finder f) async {
    await tester.tap(f.first);
    await tester.pumpAndSettle();
  }

  test('los datos reales de la web tienen las partes y temas que espera el sorteo', () {
    int temas(int ej, String parte) => temario.ejercicios.firstWhere((e) => e.id == ej).partes.firstWhere((p) => p.letra == parte).temas.length;
    expect([temas(3, 'A'), temas(3, 'B'), temas(4, 'A'), temas(4, 'B')], [45, 45, 30, 26]);
    expect([temas(5, 'A'), temas(5, 'B'), temas(5, 'C')], [10, 6, 15]);
    expect(temario.tema('5.B.6')!.pdfDeParte, isTrue);
    expect(config.bolasPorParte, {3: 2, 4: 2, 5: 1});
    expect(config.partesARedactar, {5: 2});
  });

  testWidgets('recorre las cinco pestañas', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Inicio');
    expect(find.text('Sin cantes programados'), findsOneWidget);
    expect(find.text('Fija la fecha del examen'), findsOneWidget);

    await pestana(tester, 'Plan');
    expect(find.text('Programa tu próximo cante'), findsOneWidget);
    expect(find.byType(TableCalendar<Object>), findsOneWidget);
    expect(find.text('Cronograma de temas'), findsOneWidget);

    await pestana(tester, 'Temario');
    expect(find.textContaining('Parte A: Economía general'), findsOneWidget);
    expect(find.textContaining('Parte B: Econometría'), findsOneWidget);

    await pestana(tester, 'Test');
    await pestana(tester, 'Cantar');
    expect(find.text('Sortear 2 temas de cada parte'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('plan: convocatoria, cronograma, horario, diario y probabilidades', (tester) async {
    await usuario.guardarAjustes(Ajustes(temasEstudiados: {
      for (var i = 1; i <= 30; i++) ...['3.A.$i', '3.B.$i'],
    }));
    await arrancar(tester);

    await pestana(tester, 'Plan');
    await tocar(tester, find.text('Convocatoria'));
    expect(find.text('Tercer ejercicio'), findsOneWidget);
    expect(find.text('Toca para poner la fecha'), findsNWidgets(5));

    await pestana(tester, 'Plan');
    await tocar(tester, find.text('Cronograma de temas'));
    // Faltan 15 + 15 del tercero y 30 + 26 del cuarto = 86 temas, a 3 por semana.
    expect(find.textContaining('86 temas en 29 semanas'), findsOneWidget);
    await tocar(tester, find.text('Crear cronograma'));
    expect(find.text('0 de 86 temas'), findsOneWidget);
    expect(find.text('Semana 1 · esta semana'), findsOneWidget);
    // Alternando partes, la primera semana empieza por 3.A.31, 3.B.31 y 4.A.1.
    expect(find.textContaining('3.A.31 ·'), findsOneWidget);
    expect(find.textContaining('4.A.1 ·'), findsOneWidget);
    await tocar(tester, find.byTooltip('Hecho'));
    expect(find.text('1 de 86 temas'), findsOneWidget);
    expect(plan.plan().cronograma.hechos, 1);
    expect(usuario.ajustes().temasEstudiados.contains('3.A.31'), isTrue);

    await pestana(tester, 'Plan');
    expect(find.textContaining('Semana 1 de 29 · 1 de 86 temas'), findsOneWidget);
    await tocar(tester, find.text('Horario de estudio'));
    expect(find.text('52,0 horas de estudio a la semana.'), findsOneWidget);

    await pestana(tester, 'Plan');
    await tocar(tester, find.text('Diario de cantes'));
    expect(find.textContaining('Aún no hay cantes anotados'), findsOneWidget);

    await pestana(tester, 'Plan');
    await tocar(tester, find.text('Probabilidades'));
    // 31 + 30 del tercero; del cuarto y del quinto, nada: probabilidad conjunta 0.
    expect(find.text('TERCER EJERCICIO'), findsOneWidget);
    final p3 = Sorteo.probEjercicio([const ParteSorteo(total: 45, sabidos: 31), const ParteSorteo(total: 45, sabidos: 30)]);
    expect(find.text('${(100 * p3).toStringAsFixed(1).replaceAll('.', ',')} %'), findsOneWidget);
    expect(find.text('0,0 %'), findsNWidgets(3)); // total, cuarto y quinto
    expect(tester.takeException(), isNull);
  });

  testWidgets('un cante programado aparece en la agenda y se puede sortear y cantar', (tester) async {
    await usuario.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.1', '3.A.2', '3.B.1'}));
    final cuando = DateTime.now().add(const Duration(days: 3));
    await plan.guardarCante(Cante(id: 'c1', fecha: cuando, titulo: 'Preparador', minutos: 12, bolsa: TipoBolsa.lista, temas: const ['3.A.1', '3.A.2', '3.B.1'], updatedAt: DateTime.now()));
    await plan.guardarAgenda(const AgendaTema(codigo: '3.A.2').anadir('Actualizar los datos del PIB'));
    await arrancar(tester);

    await pestana(tester, 'Inicio');
    expect(find.textContaining('Próximo cante en'), findsOneWidget);

    await pestana(tester, 'Plan');
    await tocar(tester, find.textContaining('Próximo cante en'));
    expect(find.byType(CantePage), findsOneWidget);
    expect(find.text('TEMAS QUE ENTRAN (3)'), findsOneWidget);
    expect(find.text('• Actualizar los datos del PIB'), findsOneWidget);

    await tocar(tester, find.text('Sortear y cantar'));
    expect(find.text('Cantar un tema'), findsOneWidget);
    expect(find.textContaining('3 temas en la bolsa. Al terminar'), findsOneWidget);
    expect(find.text('12:00'), findsOneWidget); // el cronómetro toma la duración del cante
    await tocar(tester, find.text('Sortear 3 temas'));
    expect(find.text('Toca el tema que vas a cantar.'), findsOneWidget);
    expect(find.textContaining('3.A.2 ·'), findsOneWidget);

    // Salir del cante vuelve al sorteo normal.
    await tocar(tester, find.byTooltip('Salir del cante'));
    expect(find.text('Sortear 2 temas de cada parte'), findsOneWidget);
    await tocar(tester, find.text('Sortear 2 temas de cada parte'));
    expect(find.textContaining(RegExp(r'^3\.A\.\d+ ·')), findsNWidgets(2));
    expect(find.textContaining(RegExp(r'^3\.B\.\d+ ·')), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('programar un cante desde el formulario', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Plan');
    await tocar(tester, find.widgetWithText(FloatingActionButton, 'Cante'));
    expect(find.text('Nuevo cante'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Preparador, grupo de cante… (opcional)'), 'Grupo de los jueves');
    await tocar(tester, find.text('Todo el ejercicio'));
    await tocar(tester, find.text('20 min'));
    await tocar(tester, find.text('Guardar'));

    final c = plan.cantes().single;
    expect(c.titulo, 'Grupo de los jueves');
    expect(c.bolsa, TipoBolsa.ejercicio);
    expect(c.minutos, 20);
    expect(c.fecha.hour, 17);
    expect(c.pendiente, isTrue);
    expect(find.text('Nuevo cante'), findsNothing);
    expect(find.textContaining('Próximo cante en'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sortear, cronometrar y guardar el cante en el diario', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Cantar');
    await tocar(tester, find.text('Sortear 2 temas de cada parte'));
    await tocar(tester, find.textContaining(RegExp(r'^3\.A\.\d+ ·')));
    expect(find.text('15:00'), findsOneWidget);
    await tocar(tester, find.text('Empezar'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Pausar'), findsOneWidget);
    await tocar(tester, find.text('Pausar'));
    expect(find.text('Continuar'), findsOneWidget);

    await tocar(tester, find.text('Guardar en el diario de cantes'));
    expect(find.text('¿Cómo ha ido el cante?'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Comentarios del preparador, fallos, qué mejorar…'), 'Me faltó el cierre');
    await tocar(tester, find.byIcon(Icons.star_border).at(3)); // cuatro estrellas
    await tocar(tester, find.text('Guardar en el diario'));

    final c = plan.cantes().single;
    expect(c.hecho, isTrue);
    expect(c.resultado!.temaCantado, startsWith('3.A.'));
    expect(c.resultado!.sorteados.length, 4);
    expect(c.resultado!.valoracion, 4);
    expect(c.resultado!.comentarios, 'Me faltó el cierre');
    expect(usuario.ajustes().racha, 1); // cantar cuenta para la racha

    await pestana(tester, 'Plan');
    await tocar(tester, find.text('Diario de cantes'));
    expect(find.text('HISTORIAL'), findsOneWidget);
    expect(find.textContaining(c.resultado!.temaCantado!), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('agenda por tema: apuntar algo para la próxima vuelta', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Temario');
    await tocar(tester, find.textContaining('Parte C: Derecho'));
    // Tema sin PDF: se abre directamente su agenda.
    await tocar(tester, find.textContaining('5.C.4 ·'));
    expect(find.text('Para la próxima vuelta'.toUpperCase()), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Añadir apunte…'), 'Repasar los plazos del recurso de alzada');
    await tocar(tester, find.byTooltip('Añadir'));
    expect(find.text('Repasar los plazos del recurso de alzada'), findsOneWidget);
    expect(plan.agenda('5.C.4').pendientes.single.texto, 'Repasar los plazos del recurso de alzada');

    await tocar(tester, find.text('Vuelta completada hoy'));
    expect(plan.agenda('5.C.4').vueltas.length, 1);
    expect(plan.agenda('5.C.4').pendientes.length, 1); // sigue pendiente para la siguiente vuelta
    expect(usuario.ajustes().temasEstudiados, contains('5.C.4'));

    await tocar(tester, find.byTooltip('Hecho'));
    expect(plan.agenda('5.C.4').pendientes, isEmpty);
    expect(find.text('1 apunte resuelto'), findsOneWidget);

    await tocar(tester, find.byType(BackButton));
    expect(find.text('1 apunte resuelto'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
