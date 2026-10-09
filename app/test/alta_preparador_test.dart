import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/red_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/preparador/alta_page.dart';
import 'package:tcee_app/theme/app_theme.dart';

/// Alta de preparador con cuenta: pedir la verificación, cambiar la que ya
/// está pendiente y volver a preparador estando ya verificado (sin pedir nada).
void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('alta${n++}', bytes: Uint8List(0));

  late FakeFirebaseFirestore db;
  late PreparadorRepo prep;
  late RedRepo red;

  Future<void> abrir(WidgetTester tester) async {
    tester.view.physicalSize = const Size(480, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final auth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'pepe', displayName: 'Pepe', email: 'pepe@example.org'));
    prep = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
    red = RedRepo(firestore: db, auth: auth);
    final http = CacheHttp(Dio(), await caja());
    await tester.pumpWidget(ProviderScope(
      overrides: [
        serviciosProvider.overrideWithValue(Servicios(
          oposicion: Oposiciones.tcee,
          http: http,
          contenido: ContenidoRepo(http, Oposiciones.tcee),
          usuario: UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja()),
          plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
          preparador: prep,
          descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_alta')),
          firebaseDisponible: true,
        )),
        usuarioActualProvider.overrideWithValue(auth.currentUser),
        redRepoProvider.overrideWithValue(red),
      ],
      child: MaterialApp(
        theme: AppTheme.claro,
        home: Builder(builder: (c) => Scaffold(body: Center(child: TextButton(onPressed: () => Navigator.of(c).push(MaterialPageRoute(builder: (_) => const AltaPreparadorPage())), child: const Text('abrir'))))),
      ),
    ));
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  setUp(() => db = FakeFirebaseFirestore());

  testWidgets('nuevo: envía la solicitud y fija el papel de preparador', (tester) async {
    await abrir(tester);
    await tester.tap(find.text('Darme de alta como preparador'));
    await tester.pumpAndSettle();
    expect((await db.doc('solicitudesPreparador/pepe').get()).data()!['nombre'], 'Pepe');
    expect(prep.perfil().activo, isTrue);
    expect(find.text('Solicitud enviada. Te avisaremos cuando te verifiquen.'), findsOneWidget);
  });

  testWidgets('con una solicitud pendiente: sale rellena y se actualiza', (tester) async {
    await db.doc('solicitudesPreparador/pepe').set(SolicitudPreparador(uid: 'pepe', nombre: 'Pepe Pérez', presentacion: 'Promoción 2015', creada: DateTime(2026, 10, 1)).toJson());
    await abrir(tester);
    expect(find.textContaining('Ya pediste la verificación el 1/10'), findsOneWidget);
    expect(find.text('Pepe Pérez'), findsOneWidget);
    await tester.tap(find.text('Actualizar la solicitud'));
    await tester.pumpAndSettle();
    final d = (await db.doc('solicitudesPreparador/pepe').get()).data()!;
    expect(d['presentacion'], 'Promoción 2015');
    expect(find.text('Solicitud actualizada. Te avisaremos cuando te verifiquen.'), findsOneWidget);
  });

  testWidgets('ya verificado: no pide nada, solo vuelve a ser preparador', (tester) async {
    await db.doc('preparadoresVerificados/pepe').set(PreparadorVerificado(uid: 'pepe', nombre: 'Pepe', avaladoPor: 'admin', desde: DateTime.now()).toJson());
    await abrir(tester);
    expect(find.textContaining('Ya estás verificado en TCEE'), findsOneWidget);
    await tester.tap(find.text('Seguir como preparador'));
    await tester.pumpAndSettle();
    expect((await db.doc('solicitudesPreparador/pepe').get()).exists, isFalse);
    expect(prep.perfil().activo, isTrue);
  });
}
