import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

/// DCE sin lanzar y sin contenido (su web aún no lo publica): ninguna pestaña
/// se rompe, Hoy explica por qué está vacía y en Más se puede volver a TCEE.
void main() {
  late AppConfig config;
  late UsuarioRepo usuario;
  late PlanRepo plan;
  late PreparadorRepo preparador;
  late List<Override> overrides;
  late BancoPreguntas banco;
  var n = 0;

  Future<Box> caja() => Hive.openBox('prueba${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
  });

  setUp(() async {
    Oposiciones.actual = Oposiciones.dce;
    banco = const BancoPreguntas(preguntas: [], examenes: [], temas: {});
    usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    plan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja());
    preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja());
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.dce,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.dce),
        usuario: usuario,
        plan: plan,
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_test')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => Future<Temario>.error('sin red')),
      estructuraProvider.overrideWith((ref) => EstructuraTemario.vacia),
      configProvider.overrideWith((ref) => config),
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


  tearDown(() => Oposiciones.actual = Oposiciones.tcee);

  for (final p in ['Hoy', 'Estudiar', 'Cantes', 'Organización', 'Más']) {
    testWidgets('DCE sin contenido: $p', (tester) async {
      await arrancar(tester);
      await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(p.toUpperCase())));
      await tester.pumpAndSettle();
      if (p == 'Hoy') expect(find.textContaining(RegExp('aún no está publicado|No se ha podido descargar el temario')), findsOneWidget);
      // Desde la oposición sin lanzar siempre se puede volver a las demás.
      if (p == 'Más') expect(find.text('Oposición'), findsOneWidget);
    });
  }
}
