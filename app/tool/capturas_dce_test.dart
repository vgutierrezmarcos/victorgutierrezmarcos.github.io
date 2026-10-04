// Capturas de la parte de DCE para la página de la app y el vídeo, con los
// colores y la tipografía de la web de Manuel Cabado García y su temario
// (app/para-manuel/oposicion/temario/temario.json, que se regenera con
// scripts/generar-temario-dce.py). Desde app/:
//
//   flutter test tool/capturas_dce_test.dart --update-goldens
//
// Escribe en promo/capturas/: elegir-oposicion, dce-hoy, dce-temario,
// dce-tema y dce-probabilidades.
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/inicio/elegir_oposicion.dart';
import 'package:tcee_app/features/temario/tema_page.dart';
import 'package:tcee_app/theme/app_theme.dart';

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

  testWidgets('elegir oposición', (tester) async {
    movil(tester);
    Paleta.usar('tcee');
    // Con las dos lanzadas, como quedará la app.
    await tester.pumpWidget(ElegirOposicionApp(alElegir: (_) async {}));
    // El logo de la cabecera se carga fuera del reloj del test.
    await tester.runAsync(() => precacheImage(const AssetImage('assets/icon/icon.png'), tester.element(find.byType(Scaffold))));
    await tester.pump();
    await captura(tester, 'elegir-oposicion');
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

    final temario = Temario.fromJson(jsonDecode(File('para-manuel/oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    final usuario = UsuarioRepo(oposicion: Oposiciones.dce, resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    final plan = PlanRepo(oposicion: Oposiciones.dce, cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja());
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
    ]);
    final http = CacheHttp(Dio(), await caja());
    final overrides = [
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.dce,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.dce),
        usuario: usuario,
        plan: plan,
        preparador: PreparadorRepo(oposicion: Oposiciones.dce, alumnos: await caja(), sesiones: await caja(), perfil: await caja()),
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('dce_capturas')),
        firebaseDisponible: false,
      )),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => AppConfig.porDefecto),
      estructuraProvider.overrideWith((ref) => EstructuraTemario.vacia),
      preguntasProvider.overrideWith((ref) => const BancoPreguntas(preguntas: [], examenes: [], temas: {})),
      bloquesProvider.overrideWith((ref) => Bloques.vacio),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
      actualizacionProvider.overrideWith((ref) => null),
    ];
    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pumpAndSettle();

    Future<void> pestana(String nombre) async {
      await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text(nombre.toUpperCase())));
      await tester.pumpAndSettle();
    }

    await captura(tester, 'dce-hoy');
    await pestana('Temario');
    final parte = find.textContaining('Parte A: Microeconom');
    await tester.scrollUntilVisible(parte, 300, scrollable: find.descendant(of: find.byType(ListView).first, matching: find.byType(Scrollable)).first);
    // Que no quede detrás del menú inferior al tocarla.
    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pumpAndSettle();
    await tester.tap(parte.first);
    await tester.pumpAndSettle();
    await captura(tester, 'dce-temario');
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => TemaPage(tema: temario.tema('3.A.9')!)));
    await captura(tester, 'dce-tema');
    Navigator.of(tester.element(find.byType(TemaPage))).pop();
    await tester.pumpAndSettle();
    await pestana('Temario');
    await tester.drag(find.byType(ListView).first, const Offset(0, 20000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Probabilidades').first);
    await captura(tester, 'dce-probabilidades');
    finCaptura();
  });
}
