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
import 'package:tcee_app/features/temario/temario_page.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/constants.dart';
import 'package:tcee_app/core/invitacion.dart';
import 'package:tcee_app/features/guia/guia.dart';
import 'package:tcee_app/features/inicio/permisos_sheet.dart';
import 'package:tcee_app/features/preparador/tema_anticipado.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/esquema.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/data/models/revisado.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/models/frecuencia_test.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/cantar/sorteo.dart';
import 'package:tcee_app/features/plan/cante_page.dart';
import 'package:tcee_app/widgets/comunes.dart';

/// Pruebas de humo de la app completa, sin Firebase ni red: usa los JSON
/// reales de la web (temario.json y app-config.json del repositorio).
void main() {
  late Temario temario;
  late AppConfig config;
  late EstructuraTemario estructura;
  late UsuarioRepo usuario;
  late PlanRepo plan;
  late PreparadorRepo preparador;
  late List<Override> overrides;
  late BancoPreguntas banco;
  var n = 0;

  Future<Box> caja() => Hive.openBox('prueba${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    estructura = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
  });

  setUp(() async {
    banco = const BancoPreguntas(preguntas: [], examenes: [], temas: {});
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    plan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja());
    preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja());
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: usuario,
        plan: plan,
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_test')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      estructuraProvider.overrideWith((ref) => estructura),
      preguntasProvider.overrideWith((ref) => banco),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
    ];
  });

  /// Arranca la app en un móvil alto (480 × 3200) o, con [tamano], en un
  /// ordenador, donde el menú pasa a un raíl lateral.
  Future<void> arrancar(WidgetTester tester, {Size tamano = const Size(480, 3200)}) async {
    tester.view.physicalSize = tamano;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
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

  /// Subpestaña del bloque Cantes: Agenda, Cantar o Diario.
  Future<void> subpestana(WidgetTester tester, String nombre) async {
    await pestana(tester, 'Cantes');
    await tester.tap(find.descendant(of: find.byType(BotonesPestanas), matching: find.textContaining(nombre, findRichText: true)));
    await tester.pumpAndSettle();
  }

  /// Subpestaña del bloque Estudiar: Temas o Test.
  Future<void> estudiar(WidgetTester tester, String nombre) async {
    await pestana(tester, 'Estudiar');
    await tester.tap(find.descendant(of: find.byType(BotonesPestanas), matching: find.textContaining(nombre, findRichText: true)).first);
    await tester.pumpAndSettle();
  }

  /// Abre «Más herramientas» en Organización (si no está ya abierto).
  Future<void> masHerramientas(WidgetTester tester) async {
    if (find.text('Horario de estudio').evaluate().isNotEmpty || find.text('Mapa del temario').evaluate().isNotEmpty) return;
    await tester.tap(find.text('Más herramientas'));
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

  testWidgets('en el ordenador la app ocupa toda la pantalla, con raíl y dos columnas', (tester) async {
    await arrancar(tester, tamano: const Size(1600, 1000));
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(tester.getTopLeft(find.byType(NavigationRail)).dx, 0);
    await tester.tap(find.descendant(of: find.byType(NavigationRail), matching: find.text('Más')));
    await tester.pumpAndSettle();
    // Las secciones de Más se reparten en dos columnas.
    final izquierda = tester.getTopLeft(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Mi preparador'))).dx;
    final derecha = tester.getTopLeft(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Acerca de'))).dx;
    expect(derecha - izquierda, greaterThan(500));
    await tester.tap(find.text('Iniciar sesión con Google').first);
    await tester.pumpAndSettle();
    expect(find.text('Tus datos solo los ves tú'), findsOneWidget);
    expect(find.textContaining('ni otros opositores', findRichText: true), findsOneWidget);
  });

  testWidgets('empieza en modo claro y se cambia desde cualquier cabecera', (tester) async {
    await arrancar(tester);
    BuildContext ctx() => tester.element(find.byType(NavigationBar));
    expect(Theme.of(ctx()).brightness, Brightness.light);
    await tester.tap(find.byTooltip('Modo oscuro').first);
    await tester.pumpAndSettle();
    expect(Theme.of(ctx()).brightness, Brightness.dark);
    expect(usuario.ajustes().temaOscuro, isTrue);
    await estudiar(tester, 'Test');
    await tester.tap(find.byTooltip('Modo claro').first);
    await tester.pumpAndSettle();
    expect(Theme.of(ctx()).brightness, Brightness.light);
  });

  testWidgets('cronograma: se crea con el asistente, sale en Hoy y marcar un tema cuenta como vuelta', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Organización');
    await tocar(tester, find.text('Cronograma'));
    expect(find.textContaining('En prueba'), findsNothing);
    await tocar(tester, find.text('Crear un cronograma'));
    await tocar(tester, find.text('Generarlo'));
    expect(find.text('Intercalar los temas de Mixto'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Crear el cronograma'), 300, scrollable: find.byType(Scrollable).first);
    await tocar(tester, find.text('Crear el cronograma'));
    expect(find.text('Vuelta al 3.er ejercicio'), findsOneWidget);
    final c = plan.cronogramaActivo()!;
    expect(c.temas.length, 90);
    expect(c.temasPorSemana, 3);
    await pestana(tester, 'Hoy');
    expect(find.text('Esta semana te toca'), findsOneWidget);
    final primero = c.semanas.first.temas.first;
    await tocar(tester, find.byType(Checkbox));
    expect(plan.cronogramaActivo()!.hechos.containsKey(primero), isTrue);
    expect(usuario.ajustes().temasEstudiados, contains(primero));
    expect(plan.agenda(primero).vueltas, hasLength(1));
  });

  testWidgets('recorre los cinco bloques', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Hoy');
    // Sin datos, nada de tarjetas vacías: los primeros pasos, en «Para empezar».
    expect(find.text('Sin cantes programados'), findsNothing);
    expect(find.text('Para empezar'), findsOneWidget);
    expect(find.text('Pon la fecha del examen'), findsOneWidget);
    expect(find.text('Haz tu primer test'), findsOneWidget);

    await estudiar(tester, 'Temas');
    // Temas: una tarjeta por ejercicio; dentro, sus partes.
    expect(find.text('Primer ejercicio'), findsOneWidget);
    expect(find.text('Quinto ejercicio'), findsOneWidget);
    await tocar(tester, find.text('Tercer ejercicio'));
    expect(find.textContaining('Parte A: Economía general'), findsOneWidget);
    Navigator.of(tester.element(find.byType(EjercicioPage))).pop();
    await tester.pumpAndSettle();
    await tocar(tester, find.text('Quinto ejercicio'));
    expect(find.textContaining('Parte B: Econometría'), findsOneWidget);
    Navigator.of(tester.element(find.byType(EjercicioPage))).pop();
    await tester.pumpAndSettle();
    // El primer ejercicio: el simulador, el test diario y el dictamen.
    await tocar(tester, find.text('Primer ejercicio'));
    expect(find.text('Simulador de test'), findsOneWidget);
    expect(find.text('Test diario'), findsOneWidget);
    expect(find.text('Dictamen de coyuntura'), findsOneWidget);
    Navigator.of(tester.element(find.byType(EjercicioPage))).pop();
    await tester.pumpAndSettle();

    await subpestana(tester, 'Agenda');
    expect(find.text('Programa tu próximo cante'), findsOneWidget);
    expect(find.byType(TableCalendar<Object>), findsOneWidget);
    await subpestana(tester, 'Cantar');
    expect(find.text('Sacar 2 bolas de cada parte'), findsOneWidget);
    await subpestana(tester, 'Diario');
    expect(find.textContaining('Aún no hay cantes anotados'), findsOneWidget);

    await estudiar(tester, 'Test');

    await pestana(tester, 'Organización');
    for (final t in ['Cronograma', 'Proceso selectivo', 'Convocatoria']) {
      expect(find.text(t), findsOneWidget);
    }
    // Lo demás, plegado en «Más herramientas».
    expect(find.text('Horario de estudio'), findsNothing);
    await masHerramientas(tester);
    for (final t in ['Probabilidades', 'Horario de estudio', 'Mapa de calor', 'Mapa del temario']) {
      expect(find.text(t), findsOneWidget);
    }

    await pestana(tester, 'Más');
    expect(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Mi preparador')), findsOneWidget);
    expect(find.text('Cronograma de temas'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('convocatoria, horario y probabilidades', (tester) async {
    await usuario.guardarAjustes(Ajustes(temasEstudiados: {
      for (var i = 1; i <= 30; i++) ...['3.A.$i', '3.B.$i'],
    }));
    await arrancar(tester);

    await pestana(tester, 'Organización');
    await tocar(tester, find.text('Convocatoria'));
    expect(find.text('Tercer ejercicio'), findsOneWidget);
    expect(find.text('Toca para poner la fecha'), findsNWidgets(5));

    await pestana(tester, 'Organización');
    await masHerramientas(tester);
    await tocar(tester, find.text('Horario de estudio'));
    expect(find.text('52,0 horas de estudio a la semana.'), findsOneWidget);

    await pestana(tester, 'Organización');
    await masHerramientas(tester);
    await tocar(tester, find.text('Probabilidades'));
    // 30 + 30 del tercero; del cuarto y del quinto, nada: probabilidad conjunta 0.
    expect(find.text('Tercer ejercicio'), findsOneWidget);
    final p3 = Sorteo.probEjercicio([const ParteSorteo(total: 45, sabidos: 30), const ParteSorteo(total: 45, sabidos: 30)]);
    // Cada probabilidad sale en su ejercicio y otra vez en el resumen del final.
    expect(find.text('${(100 * p3).toStringAsFixed(1).replaceAll('.', ',')} %'), findsWidgets);
    expect(find.text('0,0 %'), findsAtLeastNWidgets(3)); // total, cuarto y quinto
    await tester.scrollUntilVisible(find.text('En resumen'), 400, scrollable: find.byType(Scrollable).last);
    expect(find.textContaining('Total, en los tres ejercicios'), findsOneWidget);
    // Gráfico: por eficiencia y en 3D.
    await tocar(tester, find.descendant(of: find.byType(SegmentedButton<bool>), matching: find.text('Eficiencia')));
    expect(find.text('Eficiencia según los temas de cada parte'), findsNWidgets(2)); // tercer y cuarto ejercicio
    await tocar(tester, find.text('3D'));
    expect(find.textContaining('Arrastra a los lados para girar'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('un cante programado aparece en la agenda y se puede sortear y cantar', (tester) async {
    await usuario.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.1', '3.A.2', '3.B.1'}));
    final cuando = DateTime.now().add(const Duration(days: 3));
    await plan.guardarCante(Cante(id: 'c1', fecha: cuando, titulo: 'Preparador', minutos: 12, exposicion: 12, bolsa: TipoBolsa.lista, temas: const ['3.A.1', '3.A.2', '3.B.1'], updatedAt: DateTime.now()));
    await plan.guardarAgenda(const AgendaTema(codigo: '3.A.2').anadir('Actualizar los datos del PIB'));
    await arrancar(tester);

    await pestana(tester, 'Hoy');
    expect(find.textContaining('Próximo cante en'), findsOneWidget);

    await subpestana(tester, 'Agenda');
    await tocar(tester, find.textContaining('Próximo cante en'));
    expect(find.byType(CantePage), findsOneWidget);
    expect(find.text('Temas que entran (3)'), findsOneWidget);
    expect(find.text('• Actualizar los datos del PIB'), findsOneWidget);

    await tocar(tester, find.text('Sacar bola y cantar'));
    expect(find.text('Sacar 3 bolas'), findsOneWidget); // ha saltado a la subpestaña Cantar
    expect(find.textContaining('3 temas en la bolsa. Al terminar'), findsOneWidget);
    // Por defecto, cronómetro hacia delante (desde 00:00); en cuenta atrás se
    // ve el esquema del examen para un tema (en TCEE se canta uno) y lo que
    // dura el cante.
    expect(find.text('00:00'), findsOneWidget);
    await tocar(tester, find.text('Cuenta atrás'));
    expect(find.text('22:30'), findsOneWidget);
    await tocar(tester, find.text('Sin esquema'));
    expect(find.text('12:00'), findsOneWidget);
    await tocar(tester, find.text('Sacar 3 bolas'));
    expect(find.text('Toca el tema que vas a cantar.'), findsOneWidget);
    expect(find.text('3.A.2'), findsOneWidget); // casilla con el color de su bloque

    // Salir del cante vuelve al sorteo normal.
    await tocar(tester, find.byTooltip('Salir del cante'));
    expect(find.text('Sacar 2 bolas de cada parte'), findsOneWidget);
    await tocar(tester, find.text('Sacar 2 bolas de cada parte'));
    expect(find.textContaining(RegExp(r'^3\.A\.\d+$')), findsNWidgets(2));
    expect(find.textContaining(RegExp(r'^3\.B\.\d+$')), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('programar un cante desde el formulario', (tester) async {
    await arrancar(tester);
    await subpestana(tester, 'Agenda');
    // El «+» explica qué se puede añadir: un cante propio, reservar o pedir una clase suelta.
    await tocar(tester, find.widgetWithText(FloatingActionButton, 'Añadir'));
    expect(find.text('¿Qué quieres apuntar?'), findsOneWidget);
    expect(find.text('Reservar clase con mi preparador'), findsOneWidget);
    await tocar(tester, find.text('Un cante por mi cuenta'));
    expect(find.text('Nuevo cante'), findsOneWidget);
    // «Con quién»: solo, con el preparador (no hay ninguno en esta prueba) o con otra persona.
    expect(find.text('Con quién'), findsOneWidget);
    expect(tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, 'Yo solo').first).selected, isTrue);
    expect(find.widgetWithText(TextField, 'Un compañero, un simulacro…'), findsNothing);
    await tocar(tester, find.text('Otra persona'));
    await tester.enterText(find.widgetWithText(TextField, 'Un compañero, un simulacro…'), 'Simulacro del jueves');
    await tocar(tester, find.text('Todo el ejercicio'));
    // Duración por defecto (2 h, lo que dura una clase) y exposición por tema aparte.
    expect(tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, '2 h').first).selected, isTrue);
    expect(find.text('Exposición por tema'), findsOneWidget);
    await tocar(tester, find.text('Otra'));
    await tester.enterText(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)), '40');
    await tocar(tester, find.text('Aceptar'));
    expect(tester.widget<ChoiceChip>(find.widgetWithText(ChoiceChip, '40 min').first).selected, isTrue);
    await tocar(tester, find.text('Guardar'));

    final c = plan.cantes().single;
    expect(c.titulo, 'Simulacro del jueves');
    expect(c.bolsa, TipoBolsa.ejercicio);
    expect(c.minutos, 40);
    expect(c.fecha.hour, 17);
    expect(c.pendiente, isTrue);
    expect(find.text('Nuevo cante'), findsNothing);
    // De vuelta en la agenda, el cante está en el día elegido (hoy), sea la hora que sea.
    expect(find.textContaining('17:00 · Simulacro del jueves'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sortear, cronometrar y guardar el cante en el diario', (tester) async {
    await arrancar(tester);
    await subpestana(tester, 'Cantar');
    await tocar(tester, find.text('Sacar 2 bolas de cada parte'));
    await tocar(tester, find.textContaining(RegExp(r'^3\.A\.\d+$')));
    // Primero el esquema: por defecto el de un tema en el 3.º de TCEE (la
    // mitad exacta de los 45 min de dos: 22 min 30 s); con dos, los 45.
    await tocar(tester, find.text('Cuenta atrás'));
    expect(find.text('22:30'), findsOneWidget);
    await tocar(tester, find.text('2 temas · 45 min'));
    expect(find.text('45:00'), findsOneWidget);
    await tocar(tester, find.text('Sin esquema'));
    expect(find.text('30:00'), findsOneWidget); // 30 minutos de exposición por defecto
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

    await subpestana(tester, 'Diario');
    expect(find.text('Historial'), findsOneWidget);
    expect(find.textContaining(c.resultado!.temaCantado!), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('simulador: configurar, responder, finalizar y revisar', (tester) async {
    Pregunta p(int id, String tema, String correcta) => Pregunta(
        id: id, examen: 'Examen 2024', numero: id, temas: [tema], enunciado: 'Enunciado de la pregunta $id',
        opciones: {'a': 'Opción A de $id', 'b': 'Opción B de $id', 'c': 'Opción C de $id', 'd': 'Opción D de $id'}, respuesta: [correcta], oficial: true);
    banco = BancoPreguntas(preguntas: [p(1, '3.A.1', 'a'), p(2, '3.A.1', 'b'), p(3, '3.B.2', 'c')], examenes: const [], temas: const {'3.A.1': 'Objeto y métodos', '3.B.2': 'Comercio'});
    await arrancar(tester);
    await estudiar(tester, 'Test');
    expect(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Configuración del examen')), findsNothing); // es un subtítulo, no un título de sección
    expect(find.text('Configuración del examen'), findsOneWidget);
    expect(find.text('Disponibles'), findsOneWidget);
    await tocar(tester, find.text('Comenzar test'));

    expect(find.text('Pregunta 1 de 3'), findsOneWidget);
    // Responde la opción a) de las tres preguntas: acierta solo la que tenga la «a» como correcta.
    for (var i = 0; i < 3; i++) {
      await tocar(tester, find.textContaining('Opción A de'));
      if (i < 2) await tocar(tester, find.text('Siguiente'));
    }
    await tocar(tester, find.byTooltip('Navegador de preguntas'));
    expect(find.textContaining('3 respondidas'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10)); // cierra la rejilla
    await tester.pumpAndSettle();
    await tocar(tester, find.widgetWithText(FilledButton, 'Finalizar'));
    expect(find.text('Has respondido todas las preguntas.'), findsOneWidget);
    await tocar(tester, find.descendant(of: find.byType(AlertDialog), matching: find.text('Finalizar')));

    expect(find.text('Correctas'), findsOneWidget);
    expect(find.text('Revisión'), findsOneWidget);
    expect(find.text('Tu respuesta'), findsNWidgets(3));
    final r = usuario.resultadosLocales().single;
    expect(r.correctas, 1);
    expect(r.incorrectas, 2);
    await tocar(tester, find.text('Nuevo test'));
    expect(find.text('Comenzar test'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('organización del temario: bloques, detalle de bloque y esquema', (tester) async {
    await usuario.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.8', '3.A.9'}));
    await arrancar(tester);
    await pestana(tester, 'Organización');
    await masHerramientas(tester);
    await tocar(tester, find.text('Mapa del temario'));
    expect(find.text('Microeconomía'), findsOneWidget);
    expect(find.text('Macroeconomía'), findsOneWidget);
    expect(find.text('Mixto'), findsOneWidget);
    expect(find.text('Por dónde seguir'), findsOneWidget);
    expect(find.text('Modelo neoclásico básico'), findsOneWidget);
    expect(find.text('2 / 6'), findsOneWidget); // 3.A.8 y 3.A.9 estudiados

    // Detalle del bloque.
    await tocar(tester, find.text('Modelo neoclásico básico'));
    expect(find.text('2 de 6 temas estudiados'), findsOneWidget);
    expect(find.text('Temas del bloque'), findsOneWidget);
    expect(find.text('Teoría de la demanda'), findsOneWidget); // idea clave de 3.A.8
    expect(find.text('Conexiones con el resto del temario'), findsOneWidget);
    await tocar(tester, find.byType(BackButton));

    // Cuarto ejercicio: dos categorías, una por parte.
    await tocar(tester, find.text('Cuarto ejercicio'));
    expect(find.text('Economía española'), findsOneWidget);
    expect(find.text('Economía del sector público'), findsOneWidget);

    // Esquema interactivo.
    await tocar(tester, find.text('Esquema'));
    expect(find.textContaining('Toca un tema o el nombre de un bloque'), findsOneWidget);
    expect(find.text('Tercer y cuarto ejercicio'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('agenda por tema: apuntar algo para la próxima vuelta', (tester) async {
    await arrancar(tester);
    await estudiar(tester, 'Temas');
    await tocar(tester, find.text('Quinto ejercicio'));
    await tocar(tester, find.textContaining('Parte C: Derecho'));
    // Tema sin PDF: se abre directamente su agenda.
    await tocar(tester, find.textContaining('5.C.4 ·'));
    expect(find.text('Para la próxima vuelta'), findsOneWidget);
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

  testWidgets('temario revisado: distintivo en la lista y, sin sesión, invitación a entrar', (tester) async {
    overrides.add(revisadosProvider.overrideWith((ref) => ManifiestoRevisados.fromJson({
          'temas': [
            {'codigo': '5.C.4', 'aprobado': '2026-10-17', 'pdf': {'ruta': 'oposicion/temario/quinto-ejercicio/5C04.pdf', 'sha': 'abc'}},
          ],
        })));
    await arrancar(tester);
    await estudiar(tester, 'Temas');
    // Aprobado desde el 1 oct. 2026: exclusivo (uso personal); el chip del filtro cuenta uno.
    expect(find.text('Materiales exclusivos · 1'), findsOneWidget);
    await tocar(tester, find.text('Quinto ejercicio'));
    await tocar(tester, find.textContaining('Parte C: Derecho'));
    expect(find.text('Exclusivo · revisado'), findsOneWidget);
    // Sin cuenta: se ve la versión anterior (aquí, la agenda: no tiene PDF) y la invitación.
    await tocar(tester, find.textContaining('5.C.4 ·'));
    expect(find.text('Versión revisada disponible: inicia sesión para leerla'), findsOneWidget);
    expect(find.text('Para la próxima vuelta'), findsOneWidget);
    expect(find.text('Ver versión anterior'), findsNothing);
    await tocar(tester, find.text('Entrar'));
    expect(find.text('Versión revisada disponible: inicia sesión para leerla'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('preparador: alta, alumno, cante con sorteo y valoración en su ficha', (tester) async {
    await arrancar(tester);
    // El opositor ve «Mi preparador» y, desde ahí, puede darse de alta como preparador.
    await pestana(tester, 'Más');
    await tocar(tester, find.widgetWithText(FilaEnlace, 'Mi preparador'));
    expect(find.text('Conecta con tu preparador'), findsOneWidget);
    await tocar(tester, find.text('¿Preparas a opositores?'));
    await tocar(tester, find.text('Darme de alta como preparador'));
    expect(find.text('Prepara con la app'), findsOneWidget);
    await tocar(tester, find.text('Empezar sin cuenta')); // sin Firebase
    expect(preparador.perfil().activo, isTrue);
    expect(preparador.perfil().papelElegido, isTrue);
    expect(find.text('Tus clases'), findsOneWidget);
    expect(find.text('Sin código para alumnos'), findsOneWidget); // sin Firebase no hay código
    expect(find.textContaining('Todavía no tienes alumnos'), findsOneWidget);

    // Alta de un alumno sin app.
    await tocar(tester, find.text('Alumno'));
    await tester.enterText(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)).first, 'Lucía');
    await tocar(tester, find.text('Guardar'));
    expect(preparador.alumnos().single.nombre, 'Lucía');

    // Ficha del alumno y cante inmediato: sorteo, cronómetro y valoración.
    await tocar(tester, find.text('Lucía'));
    expect(find.text('Temas que lleva (0)'), findsOneWidget);
    await tocar(tester, find.text('Cantar ahora'));
    expect(find.textContaining('temas en la bolsa. Al terminar se guarda en su ficha.'), findsOneWidget);
    // En una clase se sacan los temas de la clase (dos, como cerca del examen).
    await tocar(tester, find.text('Sacar 2 bolas'));
    await tocar(tester, find.textContaining(RegExp(r'^3\.[AB]\.\d+$')));
    await tocar(tester, find.text('Empezar'));
    await tester.pump(const Duration(milliseconds: 600));
    await tocar(tester, find.text('Pausar'));
    await tocar(tester, find.text('Valorar y guardar'));
    expect(find.text('¿Cómo ha ido el cante de Lucía?'), findsOneWidget);
    await tocar(tester, find.byIcon(Icons.star_border).at(1)); // dos estrellas
    await tocar(tester, find.text('Guardar valoración'));

    final s = preparador.sesiones().single;
    expect(s.hecho, isTrue);
    expect(s.alumno, preparador.alumnos().single.id);
    expect(s.resultado!.valoracion, 2);
    expect(plan.cantes(), isEmpty); // no se mezcla con el diario propio
    // De vuelta en la ficha: un cante y el tema, flojo.
    expect(find.text('Historial de cantes'), findsOneWidget);
    expect(find.text('Temas flojos'), findsOneWidget);
    expect(find.text('cante'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('preparador: programar una clase (un solo alumno por clase)', (tester) async {
    await preparador.activar();
    await preparador.guardarAlumno(Alumno(id: 'a1', nombre: 'Lucía', temas: const ['3.A.1', '3.A.2'], updatedAt: DateTime.now()));
    await preparador.guardarAlumno(Alumno(id: 'a2', nombre: 'Pablo', updatedAt: DateTime.now()));
    await arrancar(tester);
    // Hoy: primero su panel de preparador.
    await pestana(tester, 'Hoy');
    expect(find.text('Preparador de TCEE'), findsOneWidget);
    expect(find.text('Hoy no tienes clases'), findsOneWidget);
    await pestana(tester, 'Más');
    await tocar(tester, find.widgetWithText(FilaEnlace, 'Preparador'));
    await tocar(tester, find.widgetWithText(TextButton, 'Clase'));
    expect(find.text('Nueva clase'), findsOneWidget);
    // Elegir a Pablo y luego a Lucía deja solo a Lucía: las clases son individuales.
    await tocar(tester, find.widgetWithText(ChoiceChip, 'Pablo'));
    await tocar(tester, find.widgetWithText(ChoiceChip, 'Lucía'));
    await tocar(tester, find.text('Guardar'));

    final sesiones = preparador.sesiones();
    expect(sesiones.map((s) => s.alumno).toList(), ['a1']);
    expect(find.text('Tus clases'), findsOneWidget);

    // Detalle de la clase de Lucía: entran los dos temas que lleva.
    await tocar(tester, find.textContaining('· Lucía'));
    expect(find.text('Temas que entran (2)'), findsOneWidget);
    expect(find.text('Alumno sin app enlazada'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('probabilidad de aprobar el test: se abre desde Organización y calcula', (tester) async {
    final f = FrecuenciaTest.fromJson(jsonDecode(File('../oposicion/temario/primer-ejercicio/test/frecuencia_temas.json').readAsStringSync()) as Map<String, dynamic>);
    overrides = [...overrides, frecuenciaTestProvider.overrideWith((ref) => f)];
    await arrancar(tester);
    await pestana(tester, 'Organización');
    await masHerramientas(tester);
    await tocar(tester, find.text('Probabilidad de aprobar el test'));
    expect(find.text('Sin saber ninguna pregunta'), findsOneWidget);
    expect(find.text('Pregunta a pregunta'), findsOneWidget);
    expect(find.textContaining('de aprobar'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  test('las rutas de antes de los cinco bloques llevan a su sitio nuevo', () {
    expect(rutaNueva('/temario'), '/estudiar');
    expect(rutaNueva('/test/estadisticas'), '/estudiar/test/estadisticas');
    expect(rutaNueva('/temario/cronograma'), '/organizacion/cronograma');
    expect(rutaNueva('/mas/convocatoria'), '/organizacion/convocatoria');
    expect(rutaNueva('/mas/preparador'), isNull);
  });

  testWidgets('papel: el preparador vuelve a opositor desde Ajustes', (tester) async {
    await preparador.activar();
    await arrancar(tester);
    await pestana(tester, 'Más');
    expect(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Preparador')), findsOneWidget);
    await tocar(tester, find.descendant(of: find.byType(SegmentedButton<Papel>), matching: find.text('Opositor')));
    await tocar(tester, find.text('Cambiar'));
    expect(preparador.perfil().activo, isFalse);
    expect(preparador.perfil().papelElegido, isTrue);
    expect(find.descendant(of: find.byType(TituloSeccion), matching: find.text('Mi preparador')), findsOneWidget);
    await pestana(tester, 'Hoy');
    expect(find.text('Preparador de TCEE'), findsNothing);
    expect(find.text('¿Cómo usas la app en TCEE?'), findsNothing);
  });

  testWidgets('cronograma propio: pegar el texto, revisarlo, crearlo y retocarlo', (tester) async {
    await arrancar(tester);
    await pestana(tester, 'Organización');
    await tocar(tester, find.text('Cronograma'));
    await tocar(tester, find.text('Crear un cronograma'));
    await tocar(tester, find.text('Traer el tuyo'));
    final hoy = DateTime.now();
    String f(int dias) {
      final d = hoy.add(Duration(days: dias));
      return '${d.day}/${d.month}/${d.year}';
    }

    await tester.enterText(find.byType(TextField), 'Mi plan\n${f(7)}: 3A1, 3A2\n${f(14)}: 3B1');
    await tester.pumpAndSettle();
    await tocar(tester, find.text('Leer el texto'));
    expect(find.text('Revisa tu cronograma'), findsOneWidget);
    expect(find.text('Semanas · 3 temas'), findsOneWidget);
    expect(find.text('Líneas que no he entendido (1)'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Crear el cronograma'), 300, scrollable: find.byType(Scrollable).first);
    await tocar(tester, find.text('Crear el cronograma'));

    final c = plan.cronogramaActivo()!;
    expect(c.manual, isTrue);
    expect(c.semanas.map((s) => s.temas), [['3.A.1', '3.A.2'], ['3.B.1']]);
    expect(find.text('Cronograma'), findsWidgets); // de vuelta en su pantalla

    // Retoque: el 3.A.2 pasa a la segunda semana.
    await tester.longPress(find.text('3.A.2').first);
    await tester.pumpAndSettle();
    await tocar(tester, find.textContaining('Mover al'));
    expect(plan.cronogramaActivo()!.semanas.map((s) => s.temas), [['3.A.1'], ['3.B.1', '3.A.2']]);
    expect(tester.takeException(), isNull);
  });
  testWidgets('invitación de un preparador: la app abre Mi preparador con el código puesto', (tester) async {
    // Como si la app se hubiera abierto desde el enlace de invitación (o
    // instalado desde él): la invitación queda pendiente en la caja `app`.
    final app = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : await Hive.openBox(Cajas.app, bytes: Uint8List(0));
    await app.clear();
    await app.putAll({clavePermisosPedidos: true, claveBateriaPedida: true, claveGuiaVista('tcee', Papel.opositor): true});
    await const Invitacion(codigo: 'ABC234', oposicion: 'tcee').guardar();
    expect(Invitacion.pendiente()?.codigo, 'ABC234');
    await arrancar(tester);
    expect(find.text('Mi preparador'), findsWidgets);
    expect(find.text('Tu preparador te invita a conectar'), findsOneWidget);
    expect(find.text('Descartar la invitación'), findsOneWidget);
    // Sin Firebase no se puede conectar; descartarla la quita.
    await tocar(tester, find.text('Descartar la invitación'));
    expect(Invitacion.pendiente(), isNull);
    expect(find.text('Conecta con tu preparador'), findsOneWidget);
    // La caja queda abierta para las pruebas siguientes: que no salga la hoja de permisos ni la guía.
    await app.clear();
    await app.putAll({clavePermisosPedidos: true, claveBateriaPedida: true, claveGuiaVista('tcee', Papel.opositor): true, claveGuiaVista('tcee', Papel.preparador): true});
    expect(tester.takeException(), isNull);
  });

  testWidgets('invitación de otra oposición: se ofrece cambiar a ella', (tester) async {
    final app = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : await Hive.openBox(Cajas.app, bytes: Uint8List(0));
    await app.clear();
    await app.putAll({clavePermisosPedidos: true, claveBateriaPedida: true, claveGuiaVista('tcee', Papel.opositor): true});
    await const Invitacion(codigo: 'XYZ789', oposicion: 'dce').guardar();
    await arrancar(tester);
    expect(find.text('Cambiar a DCE'), findsOneWidget);
    // Sin Firebase ni invitación no hay nada más que hacer; el toque cambia de
    // oposición (en las pruebas, nada) y deja pasar los temporizadores del arranque.
    await tocar(tester, find.text('Cambiar a DCE'));
    // La caja queda abierta para las pruebas siguientes: que no salga la hoja de permisos ni la guía.
    await app.clear();
    await app.putAll({clavePermisosPedidos: true, claveBateriaPedida: true, claveGuiaVista('tcee', Papel.opositor): true, claveGuiaVista('tcee', Papel.preparador): true});
    expect(tester.takeException(), isNull);
  });
  testWidgets('alumno sin app: los temas de la clase se le mandan por WhatsApp a la hora programada', (tester) async {
    await preparador.activar();
    await preparador.guardarAlumno(Alumno(id: 'a1', nombre: 'Lucía', telefono: '600 000 000', temas: const ['3.A.1', '3.A.2'], updatedAt: DateTime.now()));
    final clase = DateTime.now().add(const Duration(days: 2));
    // Clase con un tema elegido que «se manda» una hora antes: como el alumno
    // no tiene la app, se lo manda el preparador.
    await preparador.guardarSesion(Cante(id: 's1', fecha: clase, alumno: 'a1', minutos: 120, temaA: clase.subtract(const Duration(hours: 1)), temasMandados: const ['3.A.1'], numTemas: 1, updatedAt: DateTime.now()));
    await arrancar(tester);
    await pestana(tester, 'Más');
    await tocar(tester, find.widgetWithText(FilaEnlace, 'Preparador'));
    await tocar(tester, find.textContaining('· Lucía'));
    expect(find.text('Alumno sin app enlazada'), findsOneWidget);
    expect(find.textContaining('Se lo mandas tú'), findsOneWidget);
    expect(find.text('Enviar por WhatsApp'), findsOneWidget);
    expect(find.text('Copiar'), findsOneWidget);
    // El mensaje lleva el tema con su título y el tiempo de esquema del examen.
    final msg = mensajeTemasClase(preparador.sesiones().single, titulo: (t) => temario.tema(t)?.titulo);
    expect(msg, contains('· 3.A.1 '));
    expect(msg, contains('Tienes 22 min 30 s de esquema'));
    expect(tester.takeException(), isNull);
  });
  testWidgets('Hoy te toca: test diario y, si se activan, la racha (congelable) y el tema más frío', (tester) async {
    await usuario.guardarAjustes(const Ajustes(racha: true, temaFrio: true, temasEstudiados: {'3.A.1', '3.A.2'}));
    // Ayer hubo test: racha de 1 día en juego hoy.
    final ayer = DateTime.now().subtract(const Duration(days: 1));
    await usuario.guardarResultado(ResultadoTest(id: 'r1', timestamp: ayer, puntosBrutos: 5, maxPuntos: 10, notaSobre10: 5, correctas: 5, incorrectas: 5, sinResponder: 0, totalPreguntas: 10, tiempoSeconds: 60, temas: const []));
    await plan.guardarAgenda(AgendaTema(codigo: '3.A.2', vueltas: [DateTime.now().subtract(const Duration(days: 40))], updatedAt: DateTime.now()));
    await arrancar(tester);
    await pestana(tester, 'Hoy'); // el enrutador conserva la pantalla de la prueba anterior
    expect(find.text('Hoy te toca'), findsOneWidget);
    expect(find.text('Test diario'), findsOneWidget);
    expect(find.text('1 día seguidos'), findsOneWidget);
    // El más frío es el 3.A.1: estudiado y sin vuelta (el 3.A.2 tiene una, aunque vieja).
    expect(find.text('Repasa 3.A.1, el tema más frío'), findsOneWidget);
    // Congelar 7 días desde la etiqueta de la racha.
    await tocar(tester, find.text('1 día seguidos'));
    expect(find.text('Congelar la racha'), findsOneWidget);
    await tocar(tester, find.text('7 días'));
    expect(usuario.ajustes().rachaCongelaciones.length, 1);
    expect(find.textContaining('Congelada hasta el'), findsOneWidget);
    // Descongelar.
    await tocar(tester, find.textContaining('Congelada hasta el'));
    await tocar(tester, find.text('Descongelar'));
    expect(find.text('1 día seguidos'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('esquema a ciegas: desde Cantar, se compara con el esquema del tema y va al diario como esquema', (tester) async {
    // Un esquema para el PDF del 3.A.1 (como el de esquemas.json).
    final url = temario.tema('3.A.1')!.url ?? '';
    final fichero = Uri.parse(url).pathSegments.last;
    overrides = [
      ...overrides,
      esquemasProvider.overrideWith((ref) => Esquemas({
            fichero: const [EntradaEsquema(nivel: 0, titulo: '1. OBJETO', pagina: 1), EntradaEsquema(nivel: 1, titulo: '1.1. Definiciones', pagina: 2), EntradaEsquema(nivel: 0, titulo: '2. MÉTODO', pagina: 5), EntradaEsquema(nivel: 1, titulo: '2.1. Ciencia', pagina: 5)],
          })),
    ];
    await usuario.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.1'}));
    await arrancar(tester);
    await subpestana(tester, 'Cantar');
    await tocar(tester, find.text('Sacar un esquema de memoria'));
    expect(find.textContaining('los que llevas más tiempo sin repasar'), findsOneWidget);
    await tocar(tester, find.descendant(of: find.byType(ListTile), matching: find.textContaining('3.A.1')));
    expect(find.text('Ya está: comparar'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '1. Objeto\n2. Método');
    await tocar(tester, find.text('Ya está: comparar'));
    expect(find.text('0 de 4 apartados'), findsOneWidget);
    await tocar(tester, find.text('1. OBJETO'));
    await tocar(tester, find.text('2. MÉTODO'));
    expect(find.text('2 de 4 apartados'), findsOneWidget);
    await tocar(tester, find.byIcon(Icons.star_border).at(2)); // tres estrellas
    await tocar(tester, find.text('Guardar en el diario'));
    final c = plan.cantes().single;
    expect(c.esquema, isTrue);
    expect(c.hecho, isTrue);
    expect(c.resultado!.valoracion, 3);
    expect(c.resultado!.cubiertos, {'3.A.1': ['1. OBJETO', '2. MÉTODO']});
    expect(c.resultado!.apartados, {'3.A.1': 4});
    expect(c.resultado!.comentarios, contains('1. Objeto'));
    // En el diario, como esquema con su cobertura.
    await subpestana(tester, 'Diario');
    expect(find.textContaining('esquema a ciegas · 2/4 apartados'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
