// Pantallas del preparador con un alumno enlazado (Firestore simulado):
// hacerle un cronograma desde su ficha y programarle una clase desde fuera
// de la ficha. Reproducen dos fallos contados por los testers: la pantalla
// gris al hacer el cronograma y el «Guardar» que no hacía nada en la web.
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
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/frecuencia_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/theme/app_theme.dart';
import 'package:tcee_app/features/plan/cante_form_page.dart';
import 'package:tcee_app/features/preparador/alumno_page.dart';

void main() {
  late Temario temario;
  late AppConfig config;
  late EstructuraTemario estructura;
  late FrecuenciaTest frecuencia;
  late PreparadorRepo preparador;
  late FakeFirebaseFirestore db;
  late List<Override> overrides;
  var n = 0;

  Future<Box> caja() => Hive.openBox('prep${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    estructura = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    config = AppConfig.fromJson(jsonDecode(File('../oposicion/app-config.json').readAsStringSync()) as Map<String, dynamic>);
    frecuencia = FrecuenciaTest.fromJson(jsonDecode(File('../oposicion/temario/primer-ejercicio/test/frecuencia_temas.json').readAsStringSync()) as Map<String, dynamic>);
  });

  setUp(() async {
    db = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'prep', displayName: 'Paula', email: 'prep@example.org'));
    preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
    await preparador.activar(nombre: 'Paula');
    // Un alumno con la app enlazada, con temas estudiados y un cante por su cuenta.
    await preparador.guardarAlumno(const Alumno(id: 'a1', nombre: 'Álex', uid: 'alu'));
    await db.doc('users/alu/progress/settings').set({'temasEstudiados': ['3.A.1', '3.A.2', '3.B.1']});
    final manana = DateTime.now().add(const Duration(days: 1));
    await db.doc('users/alu/cantes/k1').set(Cante(id: 'k1', fecha: DateTime(manana.year, manana.month, manana.day, 10), minutos: 60, updatedAt: DateTime.now()).toJson());
    final http = CacheHttp(Dio(), await caja());
    overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja()),
        plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_prep')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      estructuraProvider.overrideWith((ref) => estructura),
      frecuenciaTestProvider.overrideWith((ref) => frecuencia),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
    ];
  });

  /// Pantalla alta (para no tener que desplazar) y ancha como un ordenador.
  Future<void> montar(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(1200, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: AppTheme.claro,
        locale: const Locale('es', 'ES'),
        supportedLocales: const [Locale('es', 'ES')],
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        home: home,
      ),
    ));
    await tester.pumpAndSettle();
  }

  Future<void> tocar(WidgetTester tester, Finder f) async {
    await tester.tap(f.first);
    await tester.pumpAndSettle();
  }

  testWidgets('hacerle un cronograma a un alumno desde su ficha y mandárselo', (tester) async {
    await montar(tester, const AlumnoPage(id: 'a1'));
    expect(tester.takeException(), isNull);
    expect(find.text('Álex'), findsWidgets);
    await tocar(tester, find.text('Hacerle un cronograma'));
    expect(tester.takeException(), isNull);
    expect(find.text('Cronograma para Álex'), findsOneWidget);
    expect(find.text('Primeras semanas'), findsOneWidget);
    // Todo lo que se puede tocar en el formulario, sin que nada falle.
    await tocar(tester, find.text('Fecha de fin'));
    expect(find.textContaining('Acabar el'), findsOneWidget);
    await tocar(tester, find.text('Temas por semana'));
    await tocar(tester, find.widgetWithText(ChoiceChip, 'M'));
    expect(find.textContaining('Primer cante:'), findsOneWidget);
    await tocar(tester, find.textContaining('Primer cante:'));
    expect(find.text('Primer cante de la vuelta'), findsOneWidget);
    await tocar(tester, find.text('Cancelar'));
    await tocar(tester, find.text('Sin día fijo'));
    expect(find.text('Empiezo esta semana'), findsOneWidget);
    await tocar(tester, find.text('Primero lo que más cae en el test'));
    await tocar(tester, find.text('Primero lo que más cae en el test'));
    await tocar(tester, find.text('Solo los que elija'));
    expect(find.text('Elige al menos un tema.'), findsOneWidget);
    await tocar(tester, find.textContaining('Todos los temas'));
    expect(tester.takeException(), isNull);
    await tester.enterText(find.widgetWithText(TextField, 'Por qué este orden, qué priorizar… (opcional)'), 'Empieza por micro');
    await tocar(tester, find.textContaining('Mandárselo a Álex'));
    expect(tester.takeException(), isNull);
    expect(find.textContaining('No se pudo enviar'), findsNothing);
    expect(find.text('Cronograma para Álex'), findsNothing);
    final recibidos = await db.collection('users/alu/cronogramasRecibidos').get();
    expect(recibidos.docs.single.data()['nota'], 'Empieza por micro');
  });

  testWidgets('programar una clase a un alumno sin tener abierta su ficha guarda y vuelve', (tester) async {
    await montar(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: preparador.alumnos(), alumnosIniciales: const {'a1'}))),
              child: const Text('Abrir'),
            ),
          ),
        ),
      ),
    );
    await tocar(tester, find.text('Abrir'));
    expect(find.text('Nueva clase'), findsOneWidget);
    await tocar(tester, find.text('Guardar'));
    expect(tester.takeException(), isNull);
    expect(preparador.sesiones().length, 1, reason: 'la clase se guarda');
    expect(find.text('Nueva clase'), findsNothing, reason: 'y el formulario se cierra');
  });
}
