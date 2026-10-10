import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/constants.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/guia/guia.dart';
import 'package:tcee_app/features/inicio/elegir_oposicion.dart';
import 'package:tcee_app/features/inicio/para_empezar.dart';
import 'package:tcee_app/features/inicio/permisos_sheet.dart';

/// Primeros pasos: la bienvenida con la entrada con Google, la guía de la app
/// (una vez por oposición y papel, se salta y se vuelve a abrir desde Más) y
/// «Para empezar» en Hoy.
void main() {
  late Temario temario;
  late AppConfig config;
  late EstructuraTemario estructura;
  late UsuarioRepo usuario;
  late PreparadorRepo preparador;
  late List<Override> overrides;
  late Box app;
  var n = 0;

  Future<Box> caja() => Hive.openBox('guia${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    estructura = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
    app = await Hive.openBox(Cajas.app, bytes: Uint8List(0));
  });

  setUp(() async {
    await app.clear();
    // La hoja de los permisos de avisos ya se vio (si no, la guía espera a que se cierre).
    await app.putAll({clavePermisosPedidos: true, claveBateriaPedida: true});
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja());
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: usuario,
        plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_guia')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      estructuraProvider.overrideWith((ref) => estructura),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
      avisosProcesoActivosProvider.overrideWith((ref) => false),
    ];
  });

  void pantallaAlta(WidgetTester tester) {
    tester.view.physicalSize = const Size(480, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  /// Arranca la app y deja pasar la espera antes de la guía.
  Future<void> arrancar(WidgetTester tester) async {
    tester.view.physicalSize = const Size(480, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    // El enrutador es global: se vuelve a Hoy por si otra prueba lo dejó en otra pestaña.
    if (find.byType(CapaGuia).evaluate().isEmpty) {
      await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('HOY')));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('la bienvenida se puede saltar y lleva a elegir oposición y papel', (tester) async {
    (Oposicion, Papel?)? elegido;
    pantallaAlta(tester);
    await tester.pumpWidget(ElegirOposicionApp(conBienvenida: true, alElegir: (o, p) async => elegido = (o, p)));
    await tester.pumpAndSettle();
    expect(find.text('Entrar con Google'), findsOneWidget);
    expect(find.text('Te damos la bienvenida'), findsOneWidget);

    await tester.tap(find.text('Ahora no'));
    await tester.pumpAndSettle();
    expect(app.get(claveBienvenidaVista), isTrue);
    expect(find.text('¿Qué oposición?'), findsOneWidget);

    await tester.tap(find.byType(TarjetaOposicion).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Me preparo la oposición'));
    await tester.pump(); // se queda cargando mientras arranca la app
    expect(elegido?.$2, Papel.opositor);
  });

  testWidgets('con una sola oposición, tras la bienvenida se entra directamente', (tester) async {
    (Oposicion, Papel?)? elegido;
    pantallaAlta(tester);
    await tester.pumpWidget(ElegirOposicionApp(conBienvenida: true, conOposicion: false, alElegir: (o, p) async => elegido = (o, p)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ahora no'));
    await tester.pump();
    await tester.pump();
    expect(elegido?.$1, Oposiciones.disponibles.first);
    expect(elegido?.$2, isNull);
  });

  testWidgets('la guía sale la primera vez, se salta y se vuelve a abrir desde Más', (tester) async {
    await arrancar(tester);
    final pasos = pasosGuia(Papel.opositor);
    expect(find.text('1 de ${pasos.length}'), findsOneWidget);
    expect(find.byType(CapaGuia), findsOneWidget);

    // Recorre los pasos: cada uno abre su pestaña.
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Estudiar › Temas'), findsOneWidget);
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Estudiar › Test'), findsOneWidget);

    await tester.tap(find.text('Saltar la guía'));
    await tester.pumpAndSettle();
    expect(find.byType(CapaGuia), findsNothing);
    expect(app.get(claveGuiaVista(Oposiciones.tcee.id, Papel.opositor)), isTrue);

    // No vuelve a salir sola…
    await arrancar(tester);
    expect(find.byType(CapaGuia), findsNothing);

    // …pero se abre desde Más.
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('MÁS')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guía de la app'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guía de la app'));
    await tester.pumpAndSettle();
    expect(find.text('1 de ${pasos.length}'), findsOneWidget);
    for (var i = 1; i < pasos.length; i++) {
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Terminar'));
    await tester.pumpAndSettle();
    expect(find.byType(CapaGuia), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cada papel tiene su guía: vista de opositor, sale la de preparador', (tester) async {
    await app.put(claveGuiaVista(Oposiciones.tcee.id, Papel.opositor), true);
    await preparador.activar();
    await arrancar(tester);
    expect(find.text('Cantes › Clases'), findsNothing);
    expect(find.text('1 de ${pasosGuia(Papel.preparador).length}'), findsOneWidget);
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Cantes › Clases'), findsOneWidget);
  });

  testWidgets('«Para empezar» tacha lo hecho y se puede ocultar', (tester) async {
    await app.put(claveGuiaVista(Oposiciones.tcee.id, Papel.opositor), true);
    await usuario.guardarAjustes(Ajustes(fechaConvocatoria: DateTime.now().add(const Duration(days: 200))));
    await arrancar(tester);
    expect(find.text('Para empezar'), findsOneWidget);
    // Ya tiene fecha: ese paso no sale y la cuenta atrás, sí.
    expect(find.text('Pon la fecha del examen'), findsNothing);
    expect(find.textContaining('PARA EL PRIMER EJERCICIO'), findsOneWidget);
    expect(find.text('Haz tu primer test'), findsOneWidget);

    await tester.tap(find.text('Ocultar'));
    await tester.pumpAndSettle();
    expect(find.text('Para empezar'), findsNothing);
    expect(app.get(claveParaEmpezarOculta(Oposiciones.tcee.id, Papel.opositor)), isTrue);
  });
}
