// Capturas de la parte de DCE para la página de la app y el vídeo, con los
// colores y la tipografía de la web de Manuel Cabado García y su temario
// (app/para-manuel/oposicion/temario/temario.json, que se regenera con
// scripts/generar-temario-dce.py). Desde app/:
//
//   flutter test tool/capturas_dce_test.dart --update-goldens
//
// Escribe en promo/capturas/: elegir-oposicion, tema-base (la ficha de un tema
// de TCEE, sobre la que scripts/componer-capturas-temas.py pone su PDF),
// escritorio (la app en el ordenador) y, de DCE, dce-hoy, dce-temario,
// dce-tema, dce-cantar, dce-test, dce-probabilidades, dce-buscar-preparador,
// dce-preparador, dce-sustituciones y dce-escritorio.
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/plan.dart';
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
import 'package:tcee_app/features/inicio/elegir_oposicion.dart';
import 'package:tcee_app/features/plan/cante_page.dart';
import 'package:tcee_app/features/preparador/preparador_page.dart';
import 'package:tcee_app/features/preparador/sustituciones.dart';
import 'package:tcee_app/widgets/comunes.dart';
import 'package:tcee_app/features/temario/tema_page.dart';
import 'package:tcee_app/theme/app_theme.dart';

Map<String, dynamic> _json(String ruta) => jsonDecode(File(ruta).readAsStringSync()) as Map<String, dynamic>;

Future<void> _fuente(String familia, List<String> rutas) async {
  final cargador = FontLoader(familia);
  for (final r in rutas) {
    cargador.addFont(Future.value(ByteData.view(Uint8List.fromList(File(r).readAsBytesSync()).buffer)));
  }
  await cargador.load();
}

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('capturadce${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    // ignore: invalid_use_of_visible_for_testing_member
    PackageInfo.setMockInitialValues(appName: 'Oposición TCEE · DCE', packageName: 'es.victorgutierrezmarcos.tcee_app', version: '', buildNumber: '', buildSignature: '');
    await _fuente('Pagella', [for (final v in ['regular', 'italic', 'bold', 'bolditalic']) 'assets/fonts/texgyrepagella-$v.otf']);
    await _fuente('SourceSans3', [for (final v in ['Regular', 'Medium', 'Semibold', 'Bold']) 'assets/fonts/SourceSans3-$v.ttf']);
    await _fuente('LMRoman', [for (final v in ['regular', 'italic', 'bold', 'bolditalic']) 'assets/fonts/lmroman10-$v.otf']);
    await _fuente('MaterialIcons', ['${Platform.environment['FLUTTER_ROOT']}/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf']);
  });

  /// Móvil de 1080 × 2340 a 2,625 de densidad, como en capturas_test.dart.
  void movil(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    debugDisableShadows = false;
  }

  /// Las sombras se activan para las capturas; el test tiene que dejarlas como estaban.
  void finCaptura() => debugDisableShadows = true;

  Future<void> captura(WidgetTester tester, String nombre) async {
    await tester.pumpAndSettle();
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('../promo/capturas/$nombre.png'));
  }

  Future<List<Override>> base(Oposicion o, Temario temario, UsuarioRepo usuario, PlanRepo plan, PreparadorRepo preparador) async {
    final http = CacheHttp(Dio(), await caja());
    return [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: o,
        http: http,
        contenido: ContenidoRepo(http, o),
        usuario: usuario,
        plan: plan,
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('dce_capturas')),
        firebaseDisponible: true,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => AppConfig.porDefecto),
      estructuraProvider.overrideWith((ref) => EstructuraTemario.vacia),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
      actualizacionProvider.overrideWith((ref) => null),
    ];
  }

  testWidgets('elegir oposición', (tester) async {
    movil(tester);
    Paleta.usar('tcee');
    // Con las dos lanzadas, como quedará la app.
    await tester.pumpWidget(ElegirOposicionApp(alElegir: (_, __) async {}));
    // El logo de la cabecera se carga fuera del reloj del test.
    await tester.runAsync(() => precacheImage(const AssetImage('assets/icon/icon.png'), tester.element(find.byType(Scaffold))));
    await tester.pump();
    await captura(tester, 'elegir-oposicion');
    finCaptura();
  });

  testWidgets('TCEE: ficha de un tema y la app en el ordenador', (tester) async {
    movil(tester);
    Oposiciones.actual = Oposiciones.tcee;
    Paleta.usar('tcee');
    final temario = Temario.fromJson(_json('../oposicion/temario/temario.json'));
    final usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    final hoy = DateTime.now();
    await usuario.guardarAjustes(Ajustes(
      temasEstudiados: {
        for (var i = 1; i <= 31; i++) '3.A.$i',
        for (var i = 1; i <= 26; i++) '3.B.$i',
        for (var i = 1; i <= 14; i++) '4.A.$i',
        for (var i = 1; i <= 9; i++) '4.B.$i',
        for (var i = 1; i <= 8; i++) '5.A.$i',
        for (var i = 1; i <= 5; i++) '5.B.$i',
        for (var i = 1; i <= 11; i++) '5.C.$i',
      },
      racha: 12,
      mejorRacha: 21,
      ultimoDia: Ajustes.claveDia(hoy),
    ));
    final plan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja());
    await plan.guardarCantes([
      Cante(id: 'p1', fecha: DateTime(hoy.year, hoy.month, hoy.day + 2, 17, 30), titulo: 'Preparador', bolsa: TipoBolsa.lista, temas: const ['3.A.12', '3.A.13', '3.A.14', '3.B.7', '3.B.8'], modalidad: Modalidad.online, enlace: 'https://meet.google.com/abc-defg-hij', updatedAt: hoy),
    ]);
    final overrides = await base(Oposiciones.tcee, temario, usuario, plan, PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja()));
    final yo = MockUser(uid: 'yo', displayName: 'Álex Martín', email: 'alex@example.org', photoURL: '');
    overrides.addAll([
      preguntasProvider.overrideWith((ref) => BancoPreguntas.fromJson(_json('../oposicion/temario/primer-ejercicio/test/preguntas.json'))),
      authStateProvider.overrideWith((ref) => Stream<User?>.value(yo)),
    ]);
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pumpAndSettle();
    // La ficha del tema: su PDF lo pone después componer-capturas-temas.py.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => TemaPage(tema: temario.tema('3.A.9')!)));
    await captura(tester, 'tema-base');
    Navigator.of(tester.element(find.byType(TemaPage))).pop();
    await tester.pumpAndSettle();
    // En el ordenador: ventana de 1440 × 900 puntos, con el menú en un raíl.
    tester.view.physicalSize = const Size(2880, 1800);
    tester.view.devicePixelRatio = 2;
    await tester.pumpAndSettle();
    await captura(tester, 'escritorio');
    tester.takeException();
    finCaptura();
  });

  testWidgets('DCE', (tester) async {
    movil(tester);
    final hoy = DateTime.now();
    DateTime dia(int desplazamiento, [int hora = 17, int minuto = 30]) => DateTime(hoy.year, hoy.month, hoy.day + desplazamiento, hora, minuto);
    Oposiciones.actual = Oposiciones.dce;
    Paleta.usar('dce');
    addTearDown(() {
      Oposiciones.actual = Oposiciones.tcee;
      Paleta.usar('tcee');
    });

    final temario = Temario.fromJson(_json('para-manuel/oposicion/temario/temario.json'));
    final usuario = UsuarioRepo(oposicion: Oposiciones.dce, resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    final plan = PlanRepo(oposicion: Oposiciones.dce, cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja());
    final preparador = PreparadorRepo(oposicion: Oposiciones.dce, alumnos: await caja(), sesiones: await caja(), perfil: await caja());
    await usuario.guardarAjustes(Ajustes(
      temasEstudiados: {
        for (var i = 1; i <= 12; i++) '3.A.$i',
        for (var i = 1; i <= 8; i++) '3.B.$i',
        for (var i = 1; i <= 7; i++) '1.A.$i',
        for (var i = 1; i <= 6; i++) '1.B.$i',
        for (var i = 1; i <= 5; i++) '4.A.$i',
        for (var i = 1; i <= 4; i++) '4.B.$i',
      },
      racha: 9,
      mejorRacha: 15,
      ultimoDia: Ajustes.claveDia(hoy),
    ));
    await plan.guardarCantes([
      Cante(
        id: 'd1',
        fecha: dia(1, 18, 0),
        titulo: 'Preparador',
        ejercicio: 3,
        bolsa: TipoBolsa.lista,
        temas: const ['3.A.7', '3.A.8', '3.A.9', '3.B.1', '3.B.2'],
        notas: 'Llevar el oligopolio (3.A.9): Cournot, Bertrand y Stackelberg.',
        modalidad: Modalidad.online,
        enlace: 'https://meet.google.com/abc-defg-hij',
        updatedAt: hoy,
      ),
      // Su preparadora cancela el de pasado mañana: buscará quién se lo coja.
      Cante(id: 'dc', fecha: dia(2, 18, 0), titulo: 'Con Diana Ruiz', preparador: 'diana', preparadorNombre: 'Diana Ruiz', estado: EstadoCante.cancelado, motivo: 'Tengo un juicio', ejercicio: 3, bolsa: TipoBolsa.estudiados, modalidad: Modalidad.presencial, updatedAt: hoy),
    ]);
    await preparador.guardarAlumno(Alumno(id: 'irene', uid: 'irene', nombre: 'Irene', ejercicio: 3, temas: [for (var i = 1; i <= 15; i++) '3.A.$i', for (var i = 1; i <= 9; i++) '3.B.$i'], updatedAt: hoy));
    await preparador.guardarAlumno(Alumno(id: 'jorge', nombre: 'Jorge', ejercicio: 3, temas: [for (var i = 1; i <= 10; i++) '3.A.$i', for (var i = 1; i <= 6; i++) '3.B.$i'], updatedAt: hoy));
    await preparador.guardarSesiones([
      Cante(id: 's1', fecha: dia(0, 19, 0), alumno: 'irene', bolsa: TipoBolsa.estudiados, modalidad: Modalidad.online, enlace: 'https://meet.google.com/xyz-abcd-efg', updatedAt: hoy),
      Cante(id: 's2', fecha: dia(2, 18, 0), alumno: 'jorge', bolsa: TipoBolsa.estudiados, modalidad: Modalidad.presencial, updatedAt: hoy),
      Cante(id: 's3', fecha: dia(7, 19, 0), alumno: 'irene', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
    ]);

    final yo = MockUser(uid: 'yo', displayName: 'Ana López', email: 'ana@example.org', photoURL: '');
    final overrides = await base(Oposiciones.dce, temario, usuario, plan, preparador);
    overrides.addAll([
      // El test de DCE es el de TCEE, voluntario.
      preguntasProvider.overrideWith((ref) => BancoPreguntas.fromJson(_json('../oposicion/temario/primer-ejercicio/test/preguntas.json'))),
      authStateProvider.overrideWith((ref) => Stream<User?>.value(yo)),
      redRepoProvider.overrideWithValue(RedRepo(firestore: FakeFirebaseFirestore(), auth: MockFirebaseAuth(signedIn: true, mockUser: yo), oposicion: Oposiciones.dce)),
      verificadosProvider.overrideWith((ref) async => const [
            PreparadorVerificado(uid: 'tomas', nombre: 'Tomás Herrero', ejercicios: [3], avaladoPor: 'yo'),
            PreparadorVerificado(uid: 'elena', nombre: 'Elena Sanz', ejercicios: [3], avaladoPor: 'yo'),
          ]),
      estadoRedProvider.overrideWith((ref) async => const EstadoRed(verificacion: PreparadorVerificado(uid: 'yo', nombre: 'Ana López', avaladoPor: 'yo', ejercicios: [3]))),
      solicitudesPendientesProvider.overrideWith((ref) async => const <SolicitudPreparador>[]),
      cogidasPorMiProvider.overrideWith((ref) async => const <Sustitucion>[]),
      misPeticionesProvider.overrideWith((ref) async => const <Sustitucion>[]),
      tablonProvider.overrideWith((ref) async => [
            Sustitucion(id: 't1', alumno: 'x', fecha: dia(1, 17, 0), hasta: dia(1, 21, 0), ejercicio: 3, temas: [for (var i = 1; i <= 14; i++) '3.A.$i', for (var i = 1; i <= 8; i++) '3.B.$i'], notas: 'Mi preparador ha cancelado.', modalidad: Modalidad.online),
            Sustitucion(id: 't2', alumno: 'y', fecha: dia(3, 18, 30), ejercicio: 3, temas: [for (var i = 1; i <= 9; i++) '3.B.$i'], modalidad: Modalidad.presencial, paraTodos: false, destinatarios: const ['yo']),
          ]),
      reservasRecibidasProvider.overrideWith((ref) async => const <Reserva>[]),
      progresoAlumnoProvider.overrideWith((ref, id) async => ProgresoAlumno(estudiados: preparador.alumno(id)!.temas.toSet(), enRepaso: const {'3.A.9'}, cantes: const [])),
    ]);
    await preparador.guardarPerfil(PerfilPreparador(papelElegido: true, updatedAt: hoy));
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pumpAndSettle();

    Future<void> tocar(Finder f) async {
      await tester.tap(f.first);
      await tester.pumpAndSettle();
    }

    Future<void> pestana(String nombre) async {
      for (var i = 0; i < 2; i++) {
        await tocar(find.descendant(of: find.byType(NavigationBar), matching: find.text(nombre.toUpperCase())));
      }
    }

    Future<void> bajar(double puntos) async {
      await tester.drag(find.byType(ListView).first, Offset(0, -puntos));
      await tester.pumpAndSettle();
    }

    // ------------------------------------------------------------------ Hoy
    await pestana('Hoy');
    await captura(tester, 'dce-hoy');

    // ------------------------------------------------------------- Estudiar
    Future<void> estudiar(String nombre) async {
      await pestana('Estudiar');
      await tocar(find.descendant(of: find.byType(TabBar), matching: find.text(nombre.toUpperCase())));
    }

    await estudiar('Temas');
    final parte = find.textContaining('Parte A: Microeconom');
    await tester.scrollUntilVisible(parte, 300, scrollable: find.descendant(of: find.byType(ListView).first, matching: find.byType(Scrollable)).first);
    // Que no quede detrás del menú inferior al tocarla.
    await bajar(350);
    await tocar(parte);
    await captura(tester, 'dce-temario');
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => TemaPage(tema: temario.tema('3.A.9')!)));
    await captura(tester, 'dce-tema');
    Navigator.of(tester.element(find.byType(TemaPage))).pop();
    await tester.pumpAndSettle();
    await pestana('Organización');
    await tocar(find.text('Probabilidades'));
    await captura(tester, 'dce-probabilidades');

    // --------------------------------------------------------------- Cantes
    await pestana('Cantes');
    await tocar(find.descendant(of: find.byType(TabBar), matching: find.text('CANTAR')));
    await tocar(find.text('Sacar 2 bolas de cada parte'));
    // Sin organización por bloques, cada tema sale como «3.A.9 · título».
    await tocar(find.textContaining(RegExp(r'^3\.A\.\d+ ·')));
    await bajar(150);
    await captura(tester, 'dce-cantar');

    // ------------------------------------------- Clase cancelada: sustituto
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const CantePage(id: 'dc')));
    await tester.pumpAndSettle();
    await tocar(find.text('Pedir una clase suelta'));
    await captura(tester, 'dce-buscar-preparador');
    Navigator.of(tester.element(find.byType(PedirSustitucionPage))).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(CantePage))).pop();
    await tester.pumpAndSettle();

    // ----------------------------------------------------------------- Test
    await estudiar('Test');
    await captura(tester, 'dce-test');

    // ------------------------------------------------------- Preparadora
    await preparador.guardarPerfil(PerfilPreparador(activo: true, papelElegido: true, codigo: 'D4C9RT', nombre: 'Ana', updatedAt: hoy));
    ProviderScope.containerOf(tester.element(find.byType(MaterialApp))).invalidate(perfilPreparadorProvider);
    await pestana('Hoy');
    await captura(tester, 'dce-hoy-preparador');
    await pestana('Más');
    await tocar(find.widgetWithText(FilaEnlace, 'Preparador'));
    await captura(tester, 'dce-preparador');
    final tablon = find.text('Tablón de clases sueltas');
    await tester.scrollUntilVisible(tablon, 250, scrollable: find.descendant(of: find.byType(PreparadorPage), matching: find.byType(Scrollable)).first);
    await tester.pumpAndSettle();
    await tocar(tablon);
    await captura(tester, 'dce-sustituciones');
    Navigator.of(tester.element(find.byType(TablonPage))).pop();
    await tester.pumpAndSettle();

    // ---------------------------------------- En el ordenador, como opositora
    await preparador.guardarPerfil(PerfilPreparador(activo: false, papelElegido: true, updatedAt: hoy));
    ProviderScope.containerOf(tester.element(find.byType(MaterialApp))).invalidate(perfilPreparadorProvider);
    // En el móvil hay menú inferior; en el ordenador, un raíl: se elige antes.
    await pestana('Hoy');
    tester.view.physicalSize = const Size(2880, 1800);
    tester.view.devicePixelRatio = 2;
    await tester.pumpAndSettle();
    await captura(tester, 'dce-escritorio');

    finCaptura();
    final error = tester.takeException();
    expect(error == null || error is NetworkImageLoadException, isTrue, reason: '$error');
  });
}
