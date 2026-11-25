// Mini reloj flotante: con una clase en curso y el cronómetro en marcha o en
// pausa, se ve desde cualquier pantalla (aunque se cierre la ficha de la
// clase), se pausa y se continúa desde él igual que con el botón del reloj
// grande (y lo ve el otro por Firestore) y desaparece al terminar la clase.
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
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/cantar/reloj_compartido.dart';
import 'package:tcee_app/features/cantar/reloj_flotante.dart';
import 'package:tcee_app/features/cantar/reloj_grande_page.dart';
import 'package:tcee_app/features/cantar/relojes_alumnos.dart';
import 'package:tcee_app/theme/app_theme.dart';

/// Un reloj cualquiera que se maneja a mano (como Cantar).
class _Fuente implements FuenteReloj {
  @override
  final RelojCante reloj = RelojCante(preparacion: const Duration(minutes: 30), exposicion: const Duration(minutes: 30));
  var alternados = 0;
  @override
  String? get temaActual => null;
  @override
  String? get compartidoCon => null;
  @override
  ModoReloj get modo => ModoReloj.atras;
  @override
  void alternar() {
    alternados++;
    final ahora = DateTime.now();
    reloj.corriendo ? reloj.pausar(ahora) : reloj.iniciar(ahora);
  }

  @override
  void ajustarMinutos(int minutos) {}
  @override
  void pasarAExponer() {}
  @override
  void empezarExposicion() {}
  @override
  void reiniciarExposicion() {}
  @override
  void reiniciarTodo() {}
  @override
  void alternarModo() {}
}

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('flotante${n++}', bytes: Uint8List(0));

  setUpAll(() => initializeDateFormatting('es'));

  Widget app(List<Override> overrides, Widget home, {ThemeMode modo = ThemeMode.light}) => ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.claro,
          darkTheme: AppTheme.oscuro,
          themeMode: modo,
          locale: const Locale('es', 'ES'),
          supportedLocales: const [Locale('es', 'ES')],
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
          // Como en la app: el mini reloj encima de todas las pantallas.
          builder: (context, child) => Stack(children: [child!, const Positioned.fill(child: MiniRelojFlotante())]),
          home: home,
        ),
      );

  Future<void> esperar(WidgetTester tester, {int veces = 4}) async {
    for (var i = 0; i < veces; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 30)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  final alternar = find.byKey(const ValueKey('mini-reloj-alternar'));

  testWidgets('cronómetro compartido de la clase: sale al cerrar la ficha, pausa y continúa, y se va al acabar la clase', (tester) async {
    final db = FakeFirebaseFirestore();
    var ahora = DateTime.now();
    final registro = RelojesEnCurso(reloj: () => ahora);
    final prep = await tester.runAsync(() async {
      final auth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'prep', displayName: 'Paula'));
      final p = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
      await p.activar(nombre: 'Paula');
      return p;
    });
    final http = CacheHttp(Dio(), (await tester.runAsync(caja))!);
    final servicios = (await tester.runAsync(() async => Servicios(
          oposicion: Oposiciones.tcee,
          http: http,
          contenido: ContenidoRepo(http, Oposiciones.tcee),
          usuario: UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja()),
          plan: PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja()),
          preparador: prep!,
          descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_flotante')),
          firebaseDisponible: true,
        )))!;
    final overrides = <Override>[
      serviciosProvider.overrideWithValue(servicios),
      usuarioActualProvider.overrideWithValue(MockUser(uid: 'prep', displayName: 'Paula')),
      firestoreRelojProvider.overrideWithValue(db),
      relojesEnCursoProvider.overrideWithValue(registro),
    ];
    final fin = ahora.add(const Duration(hours: 2));
    final doc = db.doc('users/alu/cantes/c1/reloj/estado');

    await tester.pumpWidget(app(
      overrides,
      Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: FilledButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(title: const Text('Clase con Álex')),
                  body: ListView(children: [
                    RelojDeClaseTarjeta(alumnoUid: 'alu', claseId: 'c1', otroNombre: 'Álex', esquema: const Duration(minutes: 30), exposicion: const Duration(minutes: 30), onAbrir: () {}, fin: fin),
                  ]),
                ),
              )),
              child: const Text('Abrir la clase'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('Abrir la clase'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await esperar(tester);

    // Sin empezar: no hay mini reloj.
    expect(alternar, findsNothing);
    await tester.tap(find.text('Empezar'));
    await esperar(tester);
    expect((await tester.runAsync(doc.get))!.data()!['corriendo'], isTrue);
    // Con la ficha de la clase delante, tampoco.
    expect(alternar, findsNothing);

    // Se cierra la ficha (se va al temario, a un test…): aparece.
    tester.state<NavigatorState>(find.byType(Navigator)).pop();
    await tester.pump(const Duration(milliseconds: 400));
    await esperar(tester);
    expect(find.text('Abrir la clase'), findsOneWidget);
    expect(alternar, findsOneWidget);
    expect(find.descendant(of: find.byType(MiniRelojFlotante), matching: find.textContaining('Esquema')), findsOneWidget);

    // Pausar: igual que el botón del reloj grande, y lo ve el otro.
    await tester.tap(alternar);
    await esperar(tester);
    expect((await tester.runAsync(doc.get))!.data()!['corriendo'], isFalse);
    expect(find.descendant(of: find.byType(MiniRelojFlotante), matching: find.textContaining('en pausa')), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    // Continuar.
    await tester.tap(alternar);
    await esperar(tester);
    expect((await tester.runAsync(doc.get))!.data()!['corriendo'], isTrue);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Acaba la clase (más de una hora después de su fin): desaparece.
    ahora = fin.add(const Duration(hours: 2));
    await tester.pump(const Duration(seconds: 1));
    await esperar(tester);
    expect(alternar, findsNothing);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    await esperar(tester);
  });

  testWidgets('Cantar: el mini reloj usa su mismo reloj, se oculta con su pantalla o el reloj grande a la vista, y en modo oscuro', (tester) async {
    final registro = RelojesEnCurso();
    final fuente = _Fuente()..reloj.iniciar(DateTime.now());
    var abierto = 0;
    await tester.pumpWidget(app([relojesEnCursoProvider.overrideWithValue(registro)], const Scaffold(body: Text('Temario')), modo: ThemeMode.dark));
    registro.poner(fuente, RelojFlotante(clave: 'c1', fuente: fuente, abrir: () => abierto++, visible: true));
    await tester.pump();
    await tester.pump();
    expect(alternar, findsNothing); // su pantalla está a la vista

    registro.poner(fuente, RelojFlotante(clave: 'c1', fuente: fuente, abrir: () => abierto++));
    await tester.pump();
    await tester.pump();
    expect(alternar, findsOneWidget);
    expect(Theme.of(tester.element(alternar)).brightness, Brightness.dark);

    await tester.tap(alternar);
    await tester.pump();
    expect(fuente.alternados, 1);
    expect(fuente.reloj.corriendo, isFalse);
    await tester.tap(alternar);
    await tester.pump();
    expect(fuente.reloj.corriendo, isTrue);

    // Tocarlo (o Intro con el foco en él) vuelve a la clase.
    await tester.tap(find.byKey(const ValueKey('mini-reloj-abrir')));
    await tester.pump();
    expect(abierto, 1);

    // Arrastrable: se mueve y no se sale de la pantalla.
    final antes = tester.getTopLeft(alternar);
    await tester.drag(find.byKey(const ValueKey('mini-reloj-abrir')), const Offset(-200, 300));
    await tester.pump();
    final despues = tester.getTopLeft(alternar);
    expect(despues.dx, lessThan(antes.dx));
    expect(despues.dy, greaterThan(antes.dy));

    // Con el reloj grande abierto no hace falta.
    registro.pantallaGrande(fuente, true);
    await tester.pump();
    await tester.pump();
    expect(alternar, findsNothing);
    registro.pantallaGrande(fuente, false);
    await tester.pump();
    await tester.pump();
    expect(alternar, findsOneWidget);

    // Al salir de la clase (se quita), desaparece.
    registro.poner(fuente, null);
    await tester.pump();
    await tester.pump();
    expect(alternar, findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  test('vigente: empezado, sin parar con el tiempo cumplido y dentro de la hora de la clase', () {
    final ahora = DateTime(2026, 11, 25, 18);
    final r = RelojCante(exposicion: const Duration(minutes: 60));
    expect(RelojesEnCurso.vigente(r, ahora), isFalse); // sin empezar
    r.iniciar(ahora);
    expect(RelojesEnCurso.vigente(r, ahora.add(const Duration(minutes: 5)), fin: ahora.add(const Duration(hours: 2))), isTrue);
    r.pausar(ahora.add(const Duration(minutes: 70)));
    expect(RelojesEnCurso.vigente(r, ahora.add(const Duration(minutes: 71))), isFalse); // parado con el tiempo cumplido
    final otro = RelojCante(exposicion: const Duration(minutes: 30))..iniciar(ahora);
    expect(RelojesEnCurso.vigente(otro, ahora.add(const Duration(hours: 4)), fin: ahora.add(const Duration(hours: 2))), isFalse);
  });
}
