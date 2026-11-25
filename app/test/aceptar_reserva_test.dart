// Aceptar una reserva desde «Mi semana» (fallo visto en una clase el 25 nov.):
// el primer toque en el visto parecía no hacer nada y el segundo la aceptaba,
// con la clase dos veces en el Google Calendar del preparador.
//
// Causa: al aceptarla, la clase nueva sale en la lista justo encima de la
// reserva; la lista (ListView) empareja las filas por posición, así que la
// fila de la reserva perdía su estado (el indicador de «trabajando»), volvía
// a salir con el visto y su `ref` ya no servía para refrescar las reservas.
// El segundo toque guardaba la clase otra vez desde cero, sin el evento de
// Google, y el calendario creaba otro.
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/frecuencia_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/red_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/preparador/semana_page.dart';
import 'package:tcee_app/theme/app_theme.dart';

void main() {
  late Temario temario;
  late AppConfig config;
  late EstructuraTemario estructura;
  late FrecuenciaTest frecuencia;
  var n = 0;
  Future<Box> caja() => Hive.openBox('reserva${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    estructura = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
    frecuencia = FrecuenciaTest.fromJson(jsonDecode(File('../oposicion/temario/primer-ejercicio/test/frecuencia_temas.json').readAsStringSync()) as Map<String, dynamic>);
  });

  Future<({PreparadorRepo prep, RedRepo red, RedRepo alumno, List<Override> overrides})> preparar() async {
    final db = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'prep', displayName: 'Paula', email: 'prep@example.org'));
    final prep = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
    await prep.activar(nombre: 'Paula');
    await prep.guardarAlumno(const Alumno(id: 'a1', nombre: 'Álex', uid: 'alu'));
    final red = RedRepo(firestore: db, auth: auth);
    final alumno = RedRepo(firestore: db, auth: MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'alu', displayName: 'Álex', email: 'alu@example.org')));
    final http = CacheHttp(Dio(), await caja());
    final overrides = <Override>[
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja()),
        plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
        preparador: prep,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_reserva')),
        firebaseDisponible: false,
      )),
      redRepoProvider.overrideWithValue(red),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      estructuraProvider.overrideWith((ref) => estructura),
      frecuenciaTestProvider.overrideWith((ref) => frecuencia),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
    ];
    return (prep: prep, red: red, alumno: alumno, overrides: overrides);
  }

  test('aceptar dos veces la misma reserva no rehace la clase (se queda con su evento)', () async {
    final f = await preparar();
    final r = Reserva(id: 'r1', preparador: 'prep', alumno: 'alu', alumnoNombre: 'Álex', fecha: DateTime.now().add(const Duration(days: 2)));
    final primera = await f.prep.sesionDeReserva(r);
    // El calendario le pone su evento y el preparador le cambia la nota.
    await f.prep.guardarSesion(primera.copyWith(eventoGoogle: 'evento-1', notas: 'Traer el esquema'));
    final segunda = await f.prep.sesionDeReserva(r);
    expect(segunda.eventoGoogle, 'evento-1');
    expect(segunda.notas, 'Traer el esquema');
    expect(f.prep.sesiones().where((s) => s.id == 'res_r1').single.eventoGoogle, 'evento-1');
  });

  testWidgets('un solo toque en el visto acepta la reserva y no deja volver a tocarlo', (tester) async {
    final f = await tester.runAsync(preparar);
    // Hoy dentro de un rato (la semana que se ve al abrir).
    final cuando = DateTime.now().add(const Duration(minutes: 30));
    await tester.runAsync(() => f!.alumno.pedirReserva(Reserva(id: 'r1', preparador: 'prep', alumno: 'alu', alumnoNombre: 'Álex', fecha: cuando)));

    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      overrides: f!.overrides,
      child: MaterialApp(
        theme: AppTheme.claro,
        locale: const Locale('es', 'ES'),
        supportedLocales: const [Locale('es', 'ES')],
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: const SemanaPage(),
      ),
    ));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Aceptar'), findsOneWidget);

    await tester.tap(find.byTooltip('Aceptar'));
    await tester.pump();
    // Trabajando: sin botones que volver a tocar.
    expect(find.byTooltip('Aceptar'), findsNothing);
    for (var i = 0; i < 5; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
    }
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    // Aceptada al primer toque: la clase en la agenda, la reserva contestada
    // y el visto ya no está (antes volvía a salir).
    expect(f.prep.sesiones().where((s) => s.id == 'res_r1'), hasLength(1));
    expect((await tester.runAsync(f.alumno.misReservas))!.single.estado, EstadoReserva.aceptada);
    expect(find.byTooltip('Aceptar'), findsNothing);
    expect(find.textContaining('No se pudo'), findsNothing);
  });
}
