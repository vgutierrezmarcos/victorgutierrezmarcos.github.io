// Capturas de la app para la página app/index.html y el vídeo promocional.
//
//   flutter test tool/capturas_test.dart --update-goldens
//
// Arranca la app completa sin Firebase ni red, con datos de demostración
// ficticios, y guarda cada pantalla en promo/capturas/ a 1080 × 2340.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/app.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';
import 'package:tcee_app/features/cantar/reloj_grande_page.dart';
import 'package:tcee_app/features/inicio/permisos_sheet.dart';
import 'package:tcee_app/features/preparador/materiales_page.dart';
import 'package:tcee_app/features/preparador/buscar_preparador_page.dart';
import 'package:tcee_app/features/preparador/busquedas_page.dart';
import 'package:tcee_app/features/preparador/sesion_page.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/features/cronograma/cronograma_form_page.dart';
import 'package:tcee_app/features/cronograma/cronograma_manual_page.dart';
import 'package:tcee_app/features/cronograma/importar_cronograma.dart';
import 'package:tcee_app/features/preparador/alta_page.dart';
import 'package:tcee_app/features/preparador/alumno_page.dart';
import 'package:tcee_app/features/preparador/preparador_page.dart';
import 'package:tcee_app/features/test/config_test_page.dart';
import 'package:tcee_app/widgets/comunes.dart';
import 'package:tcee_app/features/plan/cante_page.dart';
import 'package:tcee_app/features/preparador/semana_page.dart';
import 'package:tcee_app/features/preparador/sustituciones.dart';
import 'package:tcee_app/data/models/preparador.dart';


import 'demo_comun.dart';

void main() {
  setUpAll(prepararCapturas);

  testWidgets('capturas', (tester) async {
    final demo = await Demo.crear();
    Recorrido.vistaMovil(tester);
    await tester.pumpWidget(ProviderScope(overrides: demo.overrides, child: const TceeApp()));
    await tester.pumpAndSettle();

    final excepciones = <Object>[];
    Future<void> captura(String nombre) async {
      await tester.pumpAndSettle();
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('../promo/capturas/$nombre.png'));
      // Si una pantalla ha fallado (p. ej. un desbordamiento), que se sepa en cuál.
      final e = tester.takeException();
      if (e != null) {
        debugPrint('Excepción en la captura «$nombre»: $e');
        excepciones.add(e);
      }
    }

    final r = Recorrido(tester);
    final tocar = r.tocar, pestana = r.pestana, subpestana = r.subpestana, bajar = r.bajar, buscar = r.buscar, buscarEn = r.buscarEn, bajarEn = r.bajarEn, atras = r.atras;

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
    await bajar(20000);
    await captura('probabilidades-resumen');
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
    String f(int d) => '${demo.dia(d).day}/${demo.dia(d).month}';
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
    // El «+»: un cante propio, reservar clase o pedir una clase suelta.
    await tocar(find.text('Añadir'));
    await captura('cantes-anadir');
    Navigator.of(tester.element(find.text('¿Qué quieres apuntar?'))).pop();
    await tester.pumpAndSettle();
    await tocar(find.textContaining('Próximo cante'));
    await captura('cante');
    await atras();
    await subpestana('Cantar');
    await tocar(find.byTooltip('Entendido'));
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
    await tocar(find.byTooltip('Entendido'));
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
    // La pizarra de esa clase, apaisada (como se usa).
    tester.view.physicalSize = const Size(2340, 1080);
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => PizarraPage(alumnoUid: 'yo', canteId: 'pt', otroNombre: 'Paula Pérez', db: demo.dbRed)));
    await tester.pumpAndSettle();
    await captura('pizarra');
    Navigator.of(tester.element(find.byType(PizarraPage))).pop();
    await tester.pumpAndSettle();
    tester.view.physicalSize = const Size(1080, 2340);
    await tester.pumpAndSettle();
    // Los avisos: lo que pide la app al abrirla por primera vez.
    showModalBottomSheet<void>(context: tester.element(find.byType(Scaffold).first), isScrollControlled: true, showDragHandle: true, builder: (_) => const HojaPermisos());
    await tester.pumpAndSettle();
    await captura('avisos-permiso');
    Navigator.of(tester.element(find.byType(HojaPermisos))).pop();
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
    demo.peticiones = [
      Sustitucion(id: 'c1', alumno: 'yo', fecha: demo.dia(1, 16, 0), hasta: demo.dia(1, 21, 0), hora: demo.dia(1, 18, 30), estado: EstadoSustitucion.cogida, cogidaPor: 'olga', cogidaPorNombre: 'Olga Martín', cante: 'pc', temas: [for (var i = 1; i <= 20; i++) '3.A.$i']),
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
    // Buscar preparador: quién admite alumnos y a quién le interesa lo que busca Álex.
    await buscar(find.text('Buscar preparador'));
    await tocar(find.text('Buscar preparador'));
    await captura('buscar-preparador');
    await buscar(find.text('PREPARADORES QUE ADMITEN ALUMNOS'));
    await captura('buscar-preparador-plazas');
    await bajar(-20000);
    await tocar(find.text('Cambiar'));
    await captura('busqueda-form');
    Navigator.of(tester.element(find.byType(BusquedaFormPage))).pop();
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(BuscarPreparadorPage))).pop();
    await tester.pumpAndSettle();
    await bajar(-20000);
    // Alta de preparador: la presentación y el formulario.
    await buscar(find.text('¿Preparas a opositores?'));
    await tocar(find.text('¿Preparas a opositores?'));
    await captura('preparador-presentacion');
    await tocar(find.text('Darme de alta como preparador'));
    await captura('alta-preparador');
    Navigator.of(tester.element(find.byType(AltaPreparadorPage))).pop();
    await tester.pumpAndSettle();

    // Hasta aquí, la app de un opositor; a partir de aquí, la de un preparador.
    await demo.preparador.guardarPerfil(PerfilPreparador(activo: true, papelElegido: true, codigo: 'K7M3PQ', nombre: 'Víctor', updatedAt: demo.hoy));
    container.invalidate(perfilPreparadorProvider);
    await pestana('Hoy');
    await captura('hoy-preparador');
    await subpestana('Clases');
    await tocar(find.byTooltip('Entendido'));
    await captura('cantes-clases');
    await pestana('Más');
    await captura('mas-preparador');
    await tocar(find.widgetWithText(FilaEnlace, 'Preparador'));
    await captura('preparador');
    await tocar(find.text('Mi semana'));
    await captura('semana');
    Navigator.of(tester.element(find.byType(SemanaPage))).pop();
    await tester.pumpAndSettle();
    // Opositores que buscan preparador, y las plazas en Ajustes.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const BusquedasPage()));
    await tester.pumpAndSettle();
    await captura('busquedas');
    Navigator.of(tester.element(find.byType(BusquedasPage))).pop();
    await tester.pumpAndSettle();
    // Los materiales que comparte con sus alumnos.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const MaterialesPage()));
    await tester.pumpAndSettle();
    await captura('materiales');
    Navigator.of(tester.element(find.byType(MaterialesPage))).pop();
    await tester.pumpAndSettle();
    // Mandar a Lucía los dos temas antes de la clase de la semana que viene.
    Navigator.of(tester.element(find.byType(Scaffold).first)).push(MaterialPageRoute(builder: (_) => const SesionPage(id: 's4')));
    await tester.pumpAndSettle();
    await buscarEn<SesionPage>(find.text('Mandarle los temas antes'));
    await tocar(find.text('Mandarle los temas antes'));
    // En TCEE, por defecto, un tema: para la captura, dos (como cerca del examen).
    // El de la hoja es el último «2 temas» (la fila «Temas que se cantan» de la
    // ficha, debajo, también lo dice y tocarla abriría su diálogo).
    await tester.tap(find.text('2 temas').last);
    await tester.pumpAndSettle();
    // Dos temas de los primeros de la lista de la hoja (el código va solo en
    // su casilla; en la ficha, detrás, va con el título, así que no se confunden).
    await tocar(find.textContaining(RegExp(r'^3\.A\.2$')));
    await tocar(find.textContaining(RegExp(r'^3\.A\.3$')));
    await captura('tema-programar');
    // El botón queda por debajo del borde de la hoja: se sube la hoja.
    await tester.drag(find.textContaining('CUÁNDO LE LLEGAN'), const Offset(0, -700));
    await tester.pumpAndSettle();
    await tocar(find.text('Programar el envío'));
    await captura('sesion-tema');
    // La ficha de la clase: todo se cambia desde aquí (y la reunión de Teams).
    // Ahora «Temas antes de la clase» va antes: los detalles quedan más abajo.
    await buscarEn<SesionPage>(find.text('DETALLES DE LA CLASE'));
    await captura('clase-detalles');
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
    if (error != null) excepciones.add(error);
    expect(excepciones.where((e) => e is! NetworkImageLoadException), isEmpty, reason: '$excepciones');
  });
}
