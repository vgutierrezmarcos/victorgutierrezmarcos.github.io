// Capturas de la app para la página app/index.html y el vídeo promocional.
//
//   flutter test tool/capturas_test.dart --update-goldens
//
// Arranca la app completa sin Firebase ni red, con datos de demostración
// ficticios, y guarda cada pantalla en promo/capturas/ a 1080 × 2340.
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/core/temas_anticipados.dart';
import 'package:tcee_app/features/cantar/reloj_grande_page.dart';
import 'package:tcee_app/features/preparador/sesion_page.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/data/repos/red_repo.dart';
import 'package:tcee_app/features/cronograma/cronograma_form_page.dart';
import 'package:tcee_app/features/cronograma/cronograma_manual_page.dart';
import 'package:tcee_app/features/cronograma/importar_cronograma.dart';
import 'package:tcee_app/features/preparador/alta_page.dart';
import 'package:tcee_app/features/preparador/alumno_page.dart';
import 'package:tcee_app/features/preparador/preparador_page.dart';
import 'package:tcee_app/features/test/config_test_page.dart';
import 'package:tcee_app/widgets/comunes.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';
import 'package:tcee_app/features/plan/cante_page.dart';
import 'package:tcee_app/features/preparador/semana_page.dart';
import 'package:tcee_app/features/preparador/sustituciones.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';
import 'package:tcee_app/data/repos/descargas_repo.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

Map<String, dynamic> _json(String ruta) => jsonDecode(File(ruta).readAsStringSync()) as Map<String, dynamic>;

/// Versión de pubspec.yaml, para el pie de la pantalla Más.
String _version() => RegExp(r'^version:\s*([\d.]+)', multiLine: true).firstMatch(File('pubspec.yaml').readAsStringSync())!.group(1)!;

Future<void> _fuente(String familia, List<String> rutas) async {
  final cargador = FontLoader(familia);
  for (final r in rutas) {
    cargador.addFont(Future.value(ByteData.view(Uint8List.fromList(File(r).readAsBytesSync()).buffer)));
  }
  await cargador.load();
}

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('captura${n++}', bytes: Uint8List(0));

  setUpAll(() async {
    await initializeDateFormatting('es');
    // Este fichero es un test, aunque viva en tool/ para no ejecutarse con el resto.
    // ignore: invalid_use_of_visible_for_testing_member
    PackageInfo.setMockInitialValues(appName: 'Oposición TCEE', packageName: 'es.victorgutierrezmarcos.tcee_app', version: _version(), buildNumber: '', buildSignature: '');
    await _fuente('Pagella', [for (final v in ['regular', 'italic', 'bold', 'bolditalic']) 'assets/fonts/texgyrepagella-$v.otf']);
    await _fuente('SourceSans3', [for (final v in ['Regular', 'Medium', 'Semibold', 'Bold']) 'assets/fonts/SourceSans3-$v.ttf']);
    await _fuente('MaterialIcons', ['${Platform.environment['FLUTTER_ROOT']}/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf']);
  });

  testWidgets('capturas', (tester) async {
    final hoy = DateTime.now();
    DateTime dia(int desplazamiento, [int hora = 17, int minuto = 30]) => DateTime(hoy.year, hoy.month, hoy.day + desplazamiento, hora, minuto);

    final temario = Temario.fromJson(_json('../oposicion/temario/temario.json'));
    final estructura = EstructuraTemario.fromJson(_json('../oposicion/organizacion/estructura_temario.json'));
    final config = AppConfig.fromJson(_json('../oposicion/app-config.json'));
    final banco = BancoPreguntas.fromJson(_json('../oposicion/temario/primer-ejercicio/test/preguntas.json'));
    final bloques = Bloques.fromJson(_json('../oposicion/temario/primer-ejercicio/test/bloques.json'));

    final usuario = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja());
    final plan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja());
    final preparador = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja());

    // ------------------------------------------------- Datos de demostración
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
      temasEnRepaso: const {'3.A.4', '3.A.12', '3.B.7'},
    ));
    await preparador.guardarPerfil(PerfilPreparador(papelElegido: true, updatedAt: hoy));
    // Sin fechas de los ejercicios: no se conocen y una fecha de ejemplo en la
    // página o en el vídeo podría tomarse por oficial (decisión del usuario).
    await plan.guardarPlan(Plan(updatedAt: hoy));
    Cante hecho(String id, int hace, String tema, int estrellas, int minutos, String comentario, {String titulo = 'Preparador'}) => Cante(
          id: id,
          fecha: dia(-hace),
          titulo: titulo,
          estado: EstadoCante.hecho,
          bolsa: TipoBolsa.estudiados,
          resultado: ResultadoCante(sorteados: [tema], temaCantado: tema, segundos: minutos * 60 + 20, valoracion: estrellas, comentarios: comentario),
          updatedAt: hoy,
        );
    await plan.guardarCantes([
      Cante(id: 'p1', fecha: dia(2), titulo: 'Preparador', bolsa: TipoBolsa.lista, temas: const ['3.A.12', '3.A.13', '3.A.14', '3.B.7', '3.B.8', '3.B.9'], notas: 'Llevar repasadas las subastas (3.A.14) y la política comercial estratégica (3.B.8).', updatedAt: hoy),
      Cante(id: 'p2', fecha: dia(5, 18, 0), titulo: 'Grupo de cante', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 'p3', fecha: dia(9), titulo: 'Preparador', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 'p4', fecha: dia(16), titulo: 'Preparador', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      // La preparadora cancela el de mañana: el alumno buscará quién se lo coja.
      Cante(id: 'pc', fecha: dia(1, 18, 0), titulo: 'Con Paula Pérez', preparador: 'paula', preparadorNombre: 'Paula Pérez', estado: EstadoCante.cancelado, motivo: 'Estoy de viaje', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      // La preparadora le ha mandado ya el tema de la clase del jueves.
      Cante(id: 'pt', fecha: dia(3, 18, 0), titulo: 'Con Paula Pérez', preparador: 'paula', preparadorNombre: 'Paula Pérez', temaA: hoy.subtract(const Duration(minutes: 40)), bolsa: TipoBolsa.estudiados, modalidad: Modalidad.online, enlace: 'https://meet.google.com/xqe-ptwd-kbn', updatedAt: hoy),
      hecho('h1', 3, '3.A.7', 4, 29, 'Buen ritmo. Falta explicar las rigideces nominales de la segunda generación (Mankiw, Akerlof y Yellen).'),
      hecho('h2', 6, '3.B.2', 5, 30, 'Muy completo.', titulo: 'Grupo de cante'),
      hecho('h3', 10, '3.A.21', 2, 24, 'Se queda corto de tiempo y no llega a los teoremas del bienestar.'),
      hecho('h4', 13, '3.A.4', 3, 31, 'Correcto; diferenciar mejor a los postkeynesianos (Kalecki, Robinson).'),
      hecho('h5', 17, '3.B.11', 4, 28, ''),
      hecho('h6', 20, '3.A.21', 2, 26, 'Mejor que la vez anterior; falta la existencia y estabilidad del equilibrio (Arrow-Debreu).'),
      hecho('h7', 24, '3.A.15', 5, 30, ''),
    ]);
    await plan.guardarAgenda(const AgendaTema(codigo: '3.A.2').anadir('Añadir la teoría del valor-trabajo de Ricardo').anadir('Repasar la ley de Say'));
    await plan.guardarAgenda(const AgendaTema(codigo: '3.A.4').anadir('Distinguir la Teoría General de la síntesis IS-LM de Hicks').anadir('Añadir la preferencia por la liquidez'));
    // Cronograma de ejemplo: empezó hace dos semanas y va un tema por detrás.
    final ordenVuelta = ordenInicial(estructura, 3, {for (final t in temario.todosLosTemas.where((t) => t.ejercicio == 3)) t.codigo});
    final crono = crearCronograma(id: 'crono', ejercicio: 3, temas: ordenVuelta, inicio: hoy.subtract(const Duration(days: 14)), porSemana: 3);
    await plan.empezarCronograma(crono.copyWith(hechos: {
      for (final t in crono.semanas[0].temas) t: hoy.subtract(const Duration(days: 12)),
      for (final t in crono.semanas[1].temas.take(2)) t: hoy.subtract(const Duration(days: 5)),
      crono.semanas[2].temas.first: hoy,
    }));
    for (final (i, nota) in [6.8, 7.4, 5.9, 8.1, 7.7, 8.4].indexed) {
      await usuario.guardarResultado(ResultadoTest(
        id: 'r$i',
        timestamp: dia(-12 + 2 * i, 20, 0),
        puntosBrutos: nota * 5,
        maxPuntos: 50,
        notaSobre10: nota,
        correctas: (nota * 4.6).round(),
        incorrectas: 50 - (nota * 4.6).round() - 4,
        sinResponder: 4,
        totalPreguntas: 50,
        tiempoSeconds: 5400 + 120 * i,
        temas: const [],
        sincronizado: true,
      ));
    }
    await preparador.guardarAlumno(Alumno(id: 'lucia', uid: 'lucia', nombre: 'Lucía', temas: [for (var i = 1; i <= 22; i++) '3.A.$i', for (var i = 1; i <= 15; i++) '3.B.$i'], updatedAt: hoy));
    await preparador.guardarAlumno(Alumno(id: 'pablo', nombre: 'Pablo', temas: [for (var i = 1; i <= 12; i++) '3.A.$i', for (var i = 1; i <= 8; i++) '3.B.$i'], updatedAt: hoy));
    await preparador.guardarAlumno(Alumno(id: 'marta', uid: 'marta', nombre: 'Marta', ejercicio: 4, temas: [for (var i = 1; i <= 16; i++) '4.A.$i', for (var i = 1; i <= 11; i++) '4.B.$i'], updatedAt: hoy));
    Cante sesionHecha(String id, String alumno, int hace, String tema, int estrellas, int minutos, String comentario) =>
        hecho(id, hace, tema, estrellas, minutos, comentario, titulo: '').copyWith(alumno: alumno);
    await preparador.guardarSesiones([
      Cante(id: 's1', fecha: dia(0, 18, 0), alumno: 'lucia', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 's2', fecha: dia(0, 18, 45), alumno: 'pablo', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 's3', fecha: dia(3, 17, 0), alumno: 'marta', ejercicio: 4, bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 's4', fecha: dia(7, 18, 0), alumno: 'lucia', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 's5', fecha: dia(1, 18, 0), alumno: 'pablo', bolsa: TipoBolsa.estudiados, estado: EstadoCante.cancelado, motivo: 'Viaje', updatedAt: hoy),
      Cante(id: 's6', fecha: dia(3, 17, 15), alumno: 'lucia', bolsa: TipoBolsa.estudiados, updatedAt: hoy),
      Cante(id: 's7', fecha: dia(5, 10, 0), alumno: 'marta', ejercicio: 4, bolsa: TipoBolsa.estudiados, serie: 'fija_marta_c1', updatedAt: hoy),
      sesionHecha('v1', 'lucia', 7, '3.A.9', 4, 29, 'Muy bien estructurado. Añade el sistema AIDS y las variaciones compensatoria y equivalente.'),
      sesionHecha('v2', 'lucia', 14, '3.B.4', 5, 30, 'Excelente.'),
      sesionHecha('v3', 'lucia', 21, '3.A.17', 2, 23, 'Corto de tiempo; la discriminación de precios de tercer grado hay que llevarla más rodada.'),
      sesionHecha('v4', 'lucia', 28, '3.A.3', 4, 28, ''),
      sesionHecha('v5', 'lucia', 35, '3.A.17', 2, 25, 'Mejora, pero el monopolio natural sigue flojo.'),
      sesionHecha('v6', 'pablo', 7, '3.A.2', 3, 27, 'Correcto.'),
      sesionHecha('v7', 'marta', 4, '4.A.6', 4, 30, 'Buen uso de los objetivos del PNIEC.'),
    ]);

    // Red de demostración: el alumno (Álex) y el contacto de quien le coge el cante.
    final yo = MockUser(uid: 'yo', displayName: 'Álex Martín', email: 'alex@example.org', photoURL: '');
    final dbRed = FakeFirebaseFirestore();
    await dbRed.doc('sustituciones/c1/privado/preparador').set(const ContactoRed(nombre: 'Olga Martín', telefono: '611 22 33 44').toJson());
    var peticiones = <Sustitucion>[];
    final http = CacheHttp(Dio(), await caja());
    // Lo publicado en el proceso selectivo (el JSON de la web), con las tres
    // últimas novedades de esta semana para que se vean como tales.
    final proceso = _json('../oposicion/proceso.json');
    final docsTcee = ((proceso['tcee'] as Map)['procesos'] as List).first['documentos'] as List;
    for (final (i, d) in docsTcee.reversed.take(3).indexed) {
      (d as Map)['desde'] = DateTime(hoy.year, hoy.month, hoy.day - 1 - 2 * i).toIso8601String().substring(0, 10);
    }
    final overrides = [
      procesoJsonProvider.overrideWith((ref) async => proceso),
      temaAnticipadoProvider.overrideWith((ref, id) async => id == 'pt' ? const TemaAnticipado(tema: '3.A.18', titulo: 'Teoría de juegos. Equilibrio de Nash. Juegos repetidos y secuenciales', preparadorNombre: 'Paula Pérez', sorteado: false) : null),
      serviciosProvider.overrideWithValue(Servicios(
        oposicion: Oposiciones.tcee,
        http: http,
        contenido: ContenidoRepo(http, Oposiciones.tcee),
        usuario: usuario,
        plan: plan,
        preparador: preparador,
        descargas: DescargasRepo(await caja(), Directory.systemTemp.createTempSync('tcee_capturas')),
        firebaseDisponible: true,
      )),
      authStateProvider.overrideWith((ref) => Stream<User?>.value(yo)),
      redRepoProvider.overrideWithValue(RedRepo(firestore: dbRed, auth: MockFirebaseAuth(signedIn: true, mockUser: yo))),
      verificadosProvider.overrideWith((ref) async => const [
            PreparadorVerificado(uid: 'olga', nombre: 'Olga Martín', ejercicios: [3, 4], avaladoPor: 'yo', modalidad: 'ambas', ciudad: 'Madrid'),
            PreparadorVerificado(uid: 'luis', nombre: 'Luis Gómez', ejercicios: [1, 3], avaladoPor: 'yo', modalidad: 'online'),
          ]),
      temarioProvider.overrideWith((ref) => temario),
      configProvider.overrideWith((ref) => config),
      estructuraProvider.overrideWith((ref) => estructura),
      preguntasProvider.overrideWith((ref) => banco),
      bloquesProvider.overrideWith((ref) => bloques),
      enlacesProvider.overrideWith((ref) => <CategoriaEnlaces>[]),
      actualizacionProvider.overrideWith((ref) => null),
      // Red de preparadores de demostración: verificado, con dos peticiones en el tablón y una reserva.
      estadoRedProvider.overrideWith((ref) async => const EstadoRed(verificacion: PreparadorVerificado(uid: 'yo', nombre: 'Víctor', avaladoPor: 'yo'))),
      solicitudesPendientesProvider.overrideWith((ref) async => const <SolicitudPreparador>[]),
      cogidasPorMiProvider.overrideWith((ref) async => const <Sustitucion>[]),
      misPeticionesProvider.overrideWith((ref) async => peticiones),
      tablonProvider.overrideWith((ref) async => [
            Sustitucion(id: 't1', alumno: 'x', fecha: dia(1, 16, 0), hasta: dia(1, 21, 0), ejercicio: 3, temas: [for (var i = 1; i <= 18; i++) '3.A.$i', for (var i = 1; i <= 10; i++) '3.B.$i'], notas: 'Mi preparadora ha cancelado. Por videollamada.'),
            Sustitucion(id: 't2', alumno: 'y', fecha: dia(4, 17, 30), minutos: 45, ejercicio: 4, temas: [for (var i = 1; i <= 12; i++) '4.A.$i'], paraTodos: false, destinatarios: const ['yo']),
          ]),
      reservasRecibidasProvider.overrideWith((ref) async => [Reserva(id: 'r1', preparador: 'yo', alumno: 'marta', alumnoNombre: 'Marta', fecha: dia(2, 19, 0), nota: 'Quiero cantar el 4.A.9')]),
      // Lo que comparte un alumno enlazado: sus temas y un cante por su cuenta.
      progresoAlumnoProvider.overrideWith((ref, id) async => ProgresoAlumno(
            estudiados: preparador.alumno(id)!.temas.toSet(),
            enRepaso: const {'3.A.5', '3.B.3'},
            cantes: [hecho('x1', 2, '3.B.10', 3, 27, 'Me he quedado sin tiempo antes de llegar a las uniones monetarias.', titulo: '')],
          )),
    ];

    // Móvil de 1080 × 2340 a 2,625 de densidad (411 × 891 puntos).
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    // En los tests las sombras se pintan como bloques negros si no se activan.
    debugDisableShadows = false;

    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const TceeApp()));
    await tester.pumpAndSettle();

    Future<void> captura(String nombre) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('../promo/capturas/$nombre.png'));
    }

    Future<void> tocar(Finder f) async {
      await tester.tap(f.first);
      await tester.pumpAndSettle();
    }

    Future<void> pestana(String nombre) async {
      for (var i = 0; i < 2; i++) {
        await tocar(find.descendant(of: find.byType(NavigationBar), matching: find.text(nombre.toUpperCase())));
      }
    }

    Future<void> subpestana(String nombre) async {
      await pestana('Cantes');
      await tocar(find.descendant(of: find.byType(TabBar), matching: find.text(nombre.toUpperCase())));
    }

    Future<void> bajar(double puntos) async {
      await tester.drag(find.byType(ListView).first, Offset(0, -puntos));
      await tester.pumpAndSettle();
    }

    /// Desplaza la lista de la pantalla hasta que se vea [f].
    Future<void> buscar(Finder f) async {
      await tester.scrollUntilVisible(f, 250, scrollable: find.descendant(of: find.byType(ListView).first, matching: find.byType(Scrollable)).first);
      await tester.pumpAndSettle();
    }

    /// Como [buscar] y [bajar], pero en la lista de la pantalla [T] (con
    /// Cantes del preparador hay otra lista más en la pila de pestañas).
    Future<void> buscarEn<T>(Finder f, {double paso = 250}) async {
      await tester.scrollUntilVisible(f, paso, scrollable: find.descendant(of: find.byType(T), matching: find.byType(Scrollable)).first);
      await tester.pumpAndSettle();
    }

    Future<void> bajarEn<T>(double puntos) async {
      await tester.drag(find.descendant(of: find.byType(T), matching: find.byType(ListView)).first, Offset(0, -puntos));
      await tester.pumpAndSettle();
    }

    Future<void> atras() => tocar(find.byType(BackButton));

    // ------------------------------------------------------------------ Hoy
    await pestana('Hoy');
    await captura('hoy');

    // ------------------------------------------------------------- Estudiar
    Future<void> estudiar(String nombre) async {
      await pestana('Estudiar');
      await tocar(find.descendant(of: find.byType(TabBar), matching: find.text(nombre.toUpperCase())));
    }

    await estudiar('Temas');
    await captura('temario');
    await buscar(find.textContaining('Parte A: Economía general'));
    await tocar(find.textContaining('Parte A: Economía general'));
    await bajar(330);
    await captura('temario-temas');
    await bajar(-20000); // de vuelta arriba
    await estudiar('Test');
    await captura('test');
    await tocar(find.byTooltip('Estadísticas'));
    await captura('test-estadisticas');
    await atras();

    // --------------------------------------------------------- Organización
    await pestana('Organización');
    await captura('organizacion-hub');
    await tocar(find.text('Proceso selectivo'));
    await captura('proceso');
    await pestana('Organización');
    await buscar(find.text('Mapa de calor'));
    await tocar(find.text('Mapa de calor'));
    await captura('mapa-calor');
    await pestana('Organización');
    await bajar(-20000);
    await tocar(find.text('Mapa del temario'));
    await captura('organizacion');
    await tocar(find.text('Esquema'));
    await captura('esquema');
    await pestana('Organización');
    await tocar(find.text('Probabilidades'));
    await captura('probabilidades');
    await tocar(find.text('3D'));
    await bajar(430);
    await captura('probabilidades-3d');
    await pestana('Organización');
    await tocar(find.text('Cronograma'));
    await captura('cronograma');
    await bajar(700);
    await captura('cronograma-semanas');
    await atras();
    await tocar(find.text('Cronograma'));
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const CronogramaFormPage()));
    await tester.pumpAndSettle();
    await captura('cronograma-nuevo');
    Navigator.of(tester.element(find.byType(CronogramaFormPage))).pop();
    await tester.pumpAndSettle();
    // Traer el tuyo: un texto pegado y su revisión.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const ImportarCronogramaPage()));
    await tester.pumpAndSettle();
    String f(int d) => '${dia(d).day}/${dia(d).month}';
    await tester.enterText(find.byType(TextField), 'Cronograma de Paula (tercer ejercicio)\n${f(7)}: 3A22, 3A23 y 3A24\n${f(14)}: 3B16 – 3B18\n${f(28)}: 3A25, 3A26, 3B19');
    await tester.pumpAndSettle();
    await captura('cronograma-traer');
    await buscar(find.text('Leer el texto'));
    await tocar(find.text('Leer el texto'));
    await captura('cronograma-revisar');
    Navigator.of(tester.element(find.byType(CronogramaManualPage))).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(ImportarCronogramaPage))).pop();
    await tester.pumpAndSettle();
    await atras();

    // --------------------------------------------------------------- Cantes
    await subpestana('Agenda');
    await captura('cantes-agenda');
    await tocar(find.textContaining('Próximo cante'));
    await captura('cante');
    await atras();
    await subpestana('Cantar');
    await tocar(find.text('Sacar 2 bolas de cada parte'));
    await tocar(find.textContaining(RegExp(r'^3\.A\.\d+$')));
    await bajar(232);
    await captura('cantes-cantar');
    await bajar(-20000);
    await tocar(find.text('Pantalla grande'));
    await captura('reloj-grande');
    Navigator.of(tester.element(find.byType(RelojGrandePage))).pop();
    await tester.pumpAndSettle();
    await subpestana('Diario');
    await captura('cantes-diario');

    // ------------------------------------------- Clase cancelada: sustituto
    final container = ProviderScope.containerOf(tester.element(find.byType(MaterialApp)));
    Future<void> abrirCante(String id) async {
      Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => CantePage(id: id)));
      await tester.pumpAndSettle();
    }
    await abrirCante('pt');
    await captura('tema-recibido');
    Navigator.of(tester.element(find.byType(CantePage))).pop();
    await tester.pumpAndSettle();
    await abrirCante('pc');
    await captura('cante-cancelado');
    await tocar(find.text('Pedir una clase suelta'));
    await captura('buscar-preparador');
    Navigator.of(tester.element(find.byType(PedirSustitucionPage))).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(CantePage))).pop();
    await tester.pumpAndSettle();
    // La coge Olga dentro de la franja: el alumno ve su contacto y el WhatsApp.
    peticiones = [
      Sustitucion(id: 'c1', alumno: 'yo', fecha: dia(1, 16, 0), hasta: dia(1, 21, 0), hora: dia(1, 18, 30), estado: EstadoSustitucion.cogida, cogidaPor: 'olga', cogidaPorNombre: 'Olga Martín', cante: 'pc', temas: [for (var i = 1; i <= 20; i++) '3.A.$i']),
    ];
    container.invalidate(misPeticionesProvider);
    await abrirCante('pc');
    await captura('peticion-cogida');
    Navigator.of(tester.element(find.byType(CantePage))).pop();
    await tester.pumpAndSettle();

    // ------------------------------------------------------------------ Más
    await pestana('Más');
    await captura('mas');
    await tocar(find.text('Mi preparador'));
    await captura('mi-preparador');
    // Alta de preparador: la presentación y el formulario.
    await buscar(find.text('¿Preparas a opositores?'));
    await tocar(find.text('¿Preparas a opositores?'));
    await captura('preparador-presentacion');
    await tocar(find.text('Darme de alta como preparador'));
    await captura('alta-preparador');
    Navigator.of(tester.element(find.byType(AltaPreparadorPage))).pop();
    await tester.pumpAndSettle();

    // Hasta aquí, la app de un opositor; a partir de aquí, la de un preparador.
    await preparador.guardarPerfil(PerfilPreparador(activo: true, papelElegido: true, codigo: 'K7M3PQ', nombre: 'Víctor', updatedAt: hoy));
    container.invalidate(perfilPreparadorProvider);
    await pestana('Hoy');
    await captura('hoy-preparador');
    await subpestana('Clases');
    await captura('cantes-clases');
    await pestana('Más');
    await captura('mas-preparador');
    await tocar(find.widgetWithText(FilaEnlace, 'Preparador'));
    await captura('preparador');
    await tocar(find.text('Mi semana'));
    await captura('semana');
    Navigator.of(tester.element(find.byType(SemanaPage))).pop();
    await tester.pumpAndSettle();
    // Mandar a Lucía un tema antes de la clase de la semana que viene.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const SesionPage(id: 's4')));
    await tester.pumpAndSettle();
    await buscarEn<SesionPage>(find.text('Mandarle un tema antes'));
    await tocar(find.text('Mandarle un tema antes'));
    await tocar(find.textContaining('3.A.12'));
    await tocar(find.text('1 día antes'));
    await captura('tema-programar');
    await tocar(find.text('Programar el envío'));
    await captura('sesion-tema');
    Navigator.of(tester.element(find.byType(SesionPage))).pop();
    await tester.pumpAndSettle();
    await buscarEn<PreparadorPage>(find.text('Tablón de clases sueltas'));
    await tocar(find.text('Tablón de clases sueltas'));
    await captura('sustituciones');
    Navigator.of(tester.element(find.byType(TablonPage))).pop();
    await tester.pumpAndSettle();
    await buscarEn<PreparadorPage>(find.text('Lucía'), paso: -250); // está más arriba
    await tocar(find.text('Lucía'));
    await captura('alumno');
    await bajarEn<AlumnoPage>(520);
    await captura('alumno-historial');
    await buscarEn<AlumnoPage>(find.textContaining('3.A.9 ·'));
    await tocar(find.textContaining('3.A.9 ·'));
    await captura('sesion');

    // Una pregunta del simulador (pantalla completa: se deja para el final).
    await estudiar('Test');
    await bajarEn<ConfigTestPage>(20000);
    await tocar(find.text('Comenzar test'));
    await tocar(find.textContaining('b)'));
    await captura('test-pregunta');

    debugDisableShadows = true;
    // Las imágenes de algunas preguntas se piden a la web y en la prueba no hay red.
    final error = tester.takeException();
    expect(error == null || error is NetworkImageLoadException, isTrue, reason: '$error');
  });
}
