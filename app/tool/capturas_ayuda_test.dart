// Pantallas de los vídeos de ayuda (app/promo/ayuda/GUIONES.md).
//
//   flutter test tool/capturas_ayuda_test.dart --update-goldens
//
// Un recorrido por vídeo, con los datos de demostración de demo_comun.dart.
// Cada pantalla se guarda en promo/ayuda/capturas/<vídeo>/<paso>.png y, en
// pasos.json, el rectángulo (en píxeles de la captura) de lo que se toca en
// ella, para que scripts/montar-videos-ayuda.py ponga el dedo encima.
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/features/cantar/reloj_compartido.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';
import 'package:tcee_app/features/cantar/reloj_grande_page.dart';
import 'package:tcee_app/features/cronograma/cronograma_form_page.dart';
import 'package:tcee_app/features/plan/cante_form_page.dart';
import 'package:tcee_app/features/plan/cante_page.dart';
import 'package:tcee_app/features/preparador/alta_page.dart';
import 'package:tcee_app/features/preparador/preparador_page.dart';
import 'package:tcee_app/features/preparador/semana_page.dart';
import 'package:tcee_app/features/preparador/sesion_page.dart';
import 'package:tcee_app/features/preparador/sustituciones.dart';
import 'package:tcee_app/widgets/comunes.dart';

import 'demo_comun.dart';

/// Recorrido de un vídeo: fotos de cada paso y dónde se toca.
class Video {
  Video(this.id, this.tester);
  final String id;
  final WidgetTester tester;
  final _pasos = <Map<String, dynamic>>[];
  final excepciones = <Object>[];

  String get _carpeta => '../promo/ayuda/capturas/$id';

  /// Guarda la pantalla actual como el paso [nombre].
  /// Con [asentar] a false (un cronómetro en marcha no deja de pintar), solo
  /// se deja pasar un instante.
  Future<void> foto(String nombre, {bool asentar = true}) async {
    asentar ? await tester.pumpAndSettle() : await tester.pump(const Duration(milliseconds: 600));
    await expectLater(find.byType(MaterialApp), matchesGoldenFile('$_carpeta/$nombre.png'));
    final e = tester.takeException();
    if (e != null) {
      debugPrint('Excepción en «$id/$nombre»: $e');
      excepciones.add(e);
    }
    _pasos.add({'paso': nombre});
  }

  /// Anota en el último paso el rectángulo de [f] (lo que se va a tocar) y,
  /// salvo con [tocar] a false, lo toca.
  Future<void> toque(Finder f, {bool tocar = true, bool asentar = true}) async {
    final r = tester.getRect(f.first);
    final k = tester.view.devicePixelRatio;
    _pasos.last['toque'] = [for (final v in [r.left, r.top, r.width, r.height]) (v * k).round()];
    if (tocar) {
      await tester.tap(f.first);
      asentar ? await tester.pumpAndSettle() : await tester.pump(const Duration(milliseconds: 600));
    }
  }

  /// Escribe [texto] en el campo [f] (anotando el toque en el último paso).
  Future<void> escribir(Finder f, String texto) async {
    await toque(f, tocar: false);
    await tester.enterText(f.first, texto);
    await tester.pumpAndSettle();
  }

  /// Escribe pasos.json y comprueba que no ha fallado ninguna pantalla.
  void terminar() {
    final dir = Directory('tool/$_carpeta')..createSync(recursive: true);
    File('${dir.path}/pasos.json').writeAsStringSync(const JsonEncoder.withIndent('  ').convert(_pasos));
    debugDisableShadows = true;
    expect(excepciones, isEmpty, reason: '$excepciones');
  }
}

/// Mis preparadores, fijos (sin pasar por el código).
class _Vinculos extends MisPreparadoresNotifier {
  _Vinculos(this.lista);
  final List<VinculoPreparador> lista;
  @override
  List<VinculoPreparador> build() => lista;
}

void main() {
  setUpAll(prepararCapturas);

  Future<(Demo, Recorrido)> arrancar(WidgetTester tester, {bool preparadorEnRed = false, bool conCronograma = true, List<Override> extra = const [], Future<void> Function(Demo)? antes}) async {
    final demo = await Demo.crear(preparadorEnRed: preparadorEnRed, conCronograma: conCronograma);
    if (antes != null) await antes(demo);
    Recorrido.vistaMovil(tester);
    await tester.pumpWidget(ProviderScope(overrides: [...demo.overrides, firestoreRelojProvider.overrideWithValue(demo.dbRed), ...extra], child: const TceeApp()));
    await tester.pumpAndSettle();
    return (demo, Recorrido(tester));
  }

  final paula = VinculoPreparador(uid: 'paula', nombre: 'Paula Pérez', codigo: 'P4UL4X', desde: DateTime(2026, 9, 1));

  // ------------------------------------------------------------ Opositor
  testWidgets('reservar-clase', (tester) async {
    final (demo, r) = await arrancar(tester,
        extra: [misPreparadoresProvider.overrideWith(() => _Vinculos([paula]))],
        antes: (d) => d.dbRed.doc('huecos/paula').set(const HuecosPublicos(preparador: 'paula', nombre: 'Paula Pérez', activo: true, huecos: [
              Hueco(diaSemana: 2, minutoDelDia: 17 * 60),
              Hueco(diaSemana: 2, minutoDelDia: 19 * 60 + 30),
              Hueco(diaSemana: 4, minutoDelDia: 18 * 60),
              Hueco(diaSemana: 6, minutoDelDia: 10 * 60),
            ]).toJson()));
    final v = Video('reservar-clase', tester);
    await r.subpestana('Agenda');
    await r.tocar(find.byTooltip('Entendido'));
    // La hoja del «+» mira los huecos ya cargados.
    await r.container.read(huecosDeProvider('paula').future);
    await v.foto('agenda');
    await v.toque(find.text('Añadir'));
    await v.foto('hoja');
    await v.toque(find.text('Reservar clase con mi preparador'));
    await v.foto('huecos');
    await v.toque(find.byType(ActionChip));
    await v.foto('pedir');
    await v.escribir(find.byType(TextField), 'Quiero cantar el 3.A.14');
    await v.foto('nota');
    await v.toque(find.text('Pedir'));
    await tester.pump(const Duration(seconds: 5)); // que se vaya el aviso de abajo
    await tester.pumpAndSettle();
    await r.buscar(find.text('MIS RESERVAS'));
    await r.bajar(400);
    await v.foto('pendiente');
    // Paula la acepta.
    final reservas = await demo.dbRed.collection('reservas').get();
    for (final d in reservas.docs) {
      await d.reference.update({'estado': EstadoReserva.aceptada.name});
    }
    r.container.invalidate(misReservasProvider);
    await v.foto('aceptada');
    v.terminar();
  });

  testWidgets('conectar-preparador', (tester) async {
    final (demo, r) = await arrancar(tester, preparadorEnRed: true, antes: (d) async {
      await d.dbRed.doc('codigos/P4UL4X').set({'uid': 'paula', 'nombre': 'Paula Pérez'});
      await d.dbRed.doc('preparadoresVerificados/paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula Pérez', ejercicios: [3, 4], avaladoPor: 'olga').toJson());
    });
    // Sin preparador todavía, tampoco hay materiales suyos.
    final materiales = demo.materialesParaMi;
    demo.materialesParaMi = [];
    r.container.invalidate(materialesParaMiProvider);
    final v = Video('conectar-preparador', tester);
    await r.pestana('Más');
    await v.foto('mas');
    await v.toque(find.text('Mi preparador'));
    await v.foto('mi-preparador');
    await v.escribir(find.byType(TextField), 'P4UL4X');
    await v.foto('codigo');
    await v.toque(find.text('Conectar'));
    demo.materialesParaMi = materiales;
    r.container.invalidate(materialesParaMiProvider);
    await v.foto('conectado');
    await r.buscar(find.text('QUÉ VE TU PREPARADOR'));
    await v.foto('que-ve');
    v.terminar();
    expect(demo.preparador.misPreparadores().map((p) => p.nombre), ['Paula Pérez']);
  });

  testWidgets('clase-suelta', (tester) async {
    final (demo, r) = await arrancar(tester, extra: [misPreparadoresProvider.overrideWith(() => _Vinculos([paula]))]);
    final v = Video('clase-suelta', tester);
    await r.subpestana('Agenda');
    await r.tocar(find.byTooltip('Entendido'));
    await v.foto('agenda');
    await v.toque(find.textContaining('ha cancelado la clase'));
    await v.foto('cancelada');
    await v.toque(find.text('Pedir una clase suelta'));
    await v.foto('franja');
    await v.toque(find.text('Igual'));
    await v.foto('modalidad');
    await r.bajar(330);
    await v.foto('temas');
    await r.buscar(find.text('Enviar la petición'));
    await v.foto('contacto');
    await v.escribir(find.widgetWithText(TextField, 'Teléfono (WhatsApp)'), '600 12 34 56');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await v.foto('a-todos');
    await v.toque(find.text('Enviar la petición'));
    await v.foto('enviada');
    await tester.pump(const Duration(seconds: 5));
    // La coge Olga dentro de la franja: el alumno ve su contacto y el WhatsApp.
    demo.peticiones = [
      Sustitucion(id: 'c1', alumno: 'yo', fecha: demo.dia(1, 16, 0), hasta: demo.dia(1, 21, 0), hora: demo.dia(1, 18, 30), estado: EstadoSustitucion.cogida, cogidaPor: 'olga', cogidaPorNombre: 'Olga Martín', cante: 'pc', temas: [for (var i = 1; i <= 20; i++) '3.A.$i']),
    ];
    r.container.invalidate(misPeticionesProvider);
    await r.abrir(const CantePage(id: 'pc'));
    await v.foto('cogida');
    await v.toque(find.text('Escribir por WhatsApp'), tocar: false);
    v.terminar();
  });

  testWidgets('buscar-preparador', (tester) async {
    final (demo, r) = await arrancar(tester, antes: (d) async => d.miBusqueda = null);
    final v = Video('buscar-preparador', tester);
    await r.pestana('Más');
    await r.tocar(find.text('Mi preparador'));
    await r.buscar(find.text('Buscar preparador'));
    await v.foto('mi-preparador');
    await v.toque(find.text('Buscar preparador'));
    await v.foto('buscar');
    await r.buscar(find.text('PREPARADORES QUE ADMITEN ALUMNOS'));
    await r.bajar(150);
    await v.foto('admiten');
    await r.bajar(-20000);
    await v.foto('cuenta');
    await v.toque(find.text('Cuenta lo que buscas'));
    await v.foto('formulario');
    await r.buscar(find.text('CUÁNDO PUEDES'));
    await r.bajar(250);
    await v.foto('cuando');
    await v.toque(find.text('Publicar'));
    // Lo publicado y, al rato, Olga se interesa.
    demo.miBusqueda = Busqueda(id: 'bq1', alumno: 'yo', ejercicios: const [3], modalidad: Modalidad.sinIndicar, ciudad: 'Madrid', disponibilidad: const ['1-t', '2-t', '4-t', '6-m'], clasesPorSemana: 1, temas: 57, nota: 'Voy por la segunda vuelta del tercer ejercicio.', creada: demo.hoy);
    r.container.invalidate(miBusquedaProvider);
    await tester.pump(const Duration(seconds: 5));
    await v.foto('interesados');
    await v.toque(find.text('Escribirle'), tocar: false);
    v.terminar();
  });

  testWidgets('cronograma', (tester) async {
    final (_, r) = await arrancar(tester, conCronograma: false);
    final v = Video('cronograma', tester);
    await r.pestana('Organización');
    await v.foto('organizacion');
    await v.toque(find.text('Cronograma'));
    await v.foto('vacio');
    await v.toque(find.text('Crear un cronograma'));
    await v.foto('como');
    await v.toque(find.text('Generarlo'));
    await v.foto('vuelta');
    await r.buscarEn<CronogramaFormPage>(find.text('Fecha de fin'));
    await r.bajarEn<CronogramaFormPage>(150);
    await v.foto('ritmo');
    await r.buscarEn<CronogramaFormPage>(find.text('Crear el cronograma'));
    await v.foto('orden');
    await v.toque(find.text('Crear el cronograma'));
    await v.foto('creado');
    await r.pestana('Hoy');
    await r.buscar(find.textContaining('te toca'));
    await v.foto('hoy');
    v.terminar();
  });

  testWidgets('clase', (tester) async {
    final (demo, r) = await arrancar(tester, extra: [misPreparadoresProvider.overrideWith(() => _Vinculos([paula]))]);
    final v = Video('clase', tester);
    await r.abrir(const CantePage(id: 'pt'));
    await v.foto('clase');
    await v.toque(find.text('Entrar a la clase (Meet)'), tocar: false);
    await r.buscar(find.textContaining('Empezar el esquema'));
    await v.foto('temas');
    await v.toque(find.textContaining('Empezar el esquema'));
    await r.tocar(find.byTooltip('Entendido'));
    await v.foto('esquema');
    await r.buscar(find.textContaining('Compartir con'));
    await r.bajar(120);
    await v.foto('compartir');
    await v.toque(find.byType(Switch));
    await v.foto('compartido');
    await v.toque(find.text('Empezar'), asentar: false);
    await tester.pump(const Duration(minutes: 3, seconds: 12));
    await v.foto('corriendo', asentar: false);
    await r.bajar(-300);
    await tester.pump(const Duration(seconds: 1));
    await v.foto('arriba', asentar: false);
    await v.toque(find.text('Pantalla grande'), asentar: false);
    await tester.pump(const Duration(seconds: 2));
    await v.foto('grande', asentar: false);
    await r.cerrar(find.byType(RelojGrandePage));
    // Se para el cronómetro (si no, el test no acaba nunca de asentarse).
    await r.buscar(find.text('Pausar'));
    await r.tocar(find.text('Pausar'));
    // La pizarra, apaisada (como se usa).
    tester.view.physicalSize = const Size(2340, 1080);
    await r.abrir(PizarraPage(alumnoUid: 'yo', canteId: 'pt', otroNombre: 'Paula Pérez', db: demo.dbRed));
    await v.foto('pizarra', asentar: false);
    await r.cerrar(find.byType(PizarraPage));
    tester.view.physicalSize = const Size(1080, 2340);
    await tester.pumpAndSettle();
    // Al acabar, la valoración de Paula queda en el diario.
    await r.subpestana('Diario');
    await r.tocar(find.byTooltip('Entendido'));
    await v.foto('diario', asentar: false);
    v.terminar();
  });

  // ---------------------------------------------------------- Preparador
  Future<void> serPreparador(Demo d) => d.preparador.guardarPerfil(PerfilPreparador(activo: true, papelElegido: true, codigo: 'K7M3PQ', nombre: 'Víctor', telefono: '600 11 22 33', updatedAt: d.hoy));

  Future<void> irAPreparador(Recorrido r) async {
    await r.pestana('Más');
    await r.tocar(find.widgetWithText(FilaEnlace, 'Preparador'));
  }

  testWidgets('empezar-preparador', (tester) async {
    final (demo, r) = await arrancar(tester, antes: (d) async => d.estadoRed = const EstadoRed());
    final v = Video('empezar-preparador', tester);
    await r.pestana('Más');
    await r.tocar(find.text('Mi preparador'));
    await r.buscar(find.text('¿Preparas a opositores?'));
    await v.foto('mi-preparador');
    await v.toque(find.text('¿Preparas a opositores?'));
    await v.foto('presentacion');
    await v.toque(find.text('Darme de alta como preparador'));
    await v.foto('alta');
    await r.buscar(find.widgetWithText(TextField, 'Nombre y apellidos'));
    await v.foto('nombre');
    await v.escribir(find.widgetWithText(TextField, 'Nombre y apellidos'), 'Víctor Gutiérrez Marcos');
    await v.foto('datos');
    await r.buscar(find.text('Darme de alta como preparador'));
    await r.bajar(150);
    await v.foto('enviar');
    await v.toque(find.text('Darme de alta como preparador'), tocar: false);
    // Ya verificado, con su código.
    demo.estadoRed = const EstadoRed(verificacion: PreparadorVerificado(uid: 'yo', nombre: 'Víctor', avaladoPor: 'yo'));
    await serPreparador(demo);
    r.container
      ..invalidate(perfilPreparadorProvider)
      ..invalidate(estadoRedProvider);
    await r.cerrar(find.byType(AltaPreparadorPage));
    await irAPreparador(r);
    await v.foto('codigo');
    await v.toque(find.byIcon(Icons.ios_share), tocar: false);
    v.terminar();
  });

  testWidgets('huecos-reservas', (tester) async {
    final (_, r) = await arrancar(tester, antes: (d) async {
      await serPreparador(d);
      for (final x in d.reservasRecibidas) {
        await d.dbRed.doc('reservas/${x.id}').set(x.toJson());
      }
    });
    final v = Video('huecos-reservas', tester);
    await irAPreparador(r);
    await r.buscarEn<PreparadorPage>(find.text('Ajustes de preparador'));
    await v.foto('preparador');
    await v.toque(find.text('Ajustes de preparador'));
    await r.buscar(find.text('Mis alumnos pueden reservar clase'));
    await r.bajar(200);
    await v.foto('reservas');
    await v.toque(find.text('Mis alumnos pueden reservar clase'));
    await r.buscar(find.text('HUECOS SEMANALES'));
    await r.bajar(250);
    await v.foto('activadas');
    await v.toque(find.text('Hueco'));
    await v.foto('hueco');
    await v.toque(find.text('lunes'));
    await v.foto('dia');
    await v.toque(find.text('martes').last);
    await v.foto('martes');
    await v.toque(find.text('Aceptar'));
    await v.foto('huecos');
    await r.abrir(const SemanaPage());
    await r.buscarEn<SemanaPage>(find.text('Reserva por confirmar'));
    await v.foto('por-confirmar');
    await v.toque(find.byTooltip('Aceptar'));
    await v.foto('aceptada');
    v.terminar();
  });

  testWidgets('programar-clase', (tester) async {
    final (_, r) = await arrancar(tester, antes: serPreparador);
    final v = Video('programar-clase', tester);
    await irAPreparador(r);
    await v.foto('preparador');
    await v.toque(find.text('Clase'));
    await v.foto('nueva');
    await v.toque(find.text('Lucía'));
    await v.foto('alumna');
    await r.buscar(find.text('Online'));
    await v.foto('cuando');
    await v.toque(find.text('Online'));
    await v.foto('online');
    await r.cerrar(find.byType(CanteFormPage));
    await r.abrir(const SesionPage(id: 's4'));
    await v.foto('ficha');
    await r.buscarEn<SesionPage>(find.text('Mandarle los temas antes'));
    await v.foto('mandar');
    await v.toque(find.text('Mandarle los temas antes'));
    await v.foto('cuantos');
    await v.toque(find.text('A suerte'));
    await v.foto('suerte');
    await tester.drag(find.textContaining('CUÁNDO LE LLEGAN'), const Offset(0, -700));
    await tester.pumpAndSettle();
    await v.foto('cuando-llegan');
    await v.toque(find.textContaining('programar'));
    await v.foto('programado');
    v.terminar();
  });

  testWidgets('coger-clase', (tester) async {
    final (demo, r) = await arrancar(tester, antes: (d) async {
      await serPreparador(d);
      for (final s in d.tablon) {
        await d.dbRed.doc('sustituciones/${s.id}').set(s.toJson());
      }
      await d.dbRed.doc('sustituciones/t1/privado/alumno').set(const ContactoRed(nombre: 'Andrea', telefono: '622 33 44 55').toJson());
    });
    final v = Video('coger-clase', tester);
    await irAPreparador(r);
    await r.buscarEn<PreparadorPage>(find.text('Tablón de clases sueltas'));
    await v.foto('preparador');
    await v.toque(find.text('Tablón de clases sueltas'));
    await v.foto('tablon');
    await v.toque(find.text('Lo cojo'));
    await v.foto('confirmar');
    await v.toque(find.descendant(of: find.byType(AlertDialog), matching: find.text('Lo cojo')));
    await v.foto('hora');
    await v.toque(find.descendant(of: find.byType(Dialog), matching: find.byType(TextButton)).last);
    demo.tablon = [demo.tablon.last];
    r.container.invalidate(tablonProvider);
    await v.foto('cogida');
    await tester.pump(const Duration(seconds: 5));
    await r.cerrar(find.byType(TablonPage));
    await r.abrir(const SemanaPage());
    await v.foto('semana');
    v.terminar();
  });

  testWidgets('materiales', (tester) async {
    final (_, r) = await arrancar(tester, antes: serPreparador);
    final v = Video('materiales', tester);
    await irAPreparador(r);
    await r.buscarEn<PreparadorPage>(find.text('Materiales para tus alumnos'));
    await v.foto('preparador');
    await v.toque(find.text('Materiales para tus alumnos'));
    await v.foto('lista');
    await v.toque(find.text('Material'));
    await v.foto('nuevo');
    await v.escribir(find.widgetWithText(TextField, 'Título'), 'Esquema del tema 3.B.5 (comercio internacional)');
    await v.foto('titulo');
    await v.escribir(find.widgetWithText(TextField, 'Enlace'), 'https://drive.google.com/file/d/3b5-esquema');
    await v.foto('enlace');
    await v.toque(find.textContaining('Sin tema'));
    await v.foto('elegir-tema');
    await v.escribir(find.widgetWithText(TextField, 'Buscar por número o título'), '3.B.5');
    await v.foto('buscar-tema');
    await v.toque(find.textContaining('3.B.5 ·'));
    await v.foto('tema');
    await v.toque(find.text('Compartir'), tocar: false);
    v.terminar();
  });
}
