// Capturas de la app para la página app/index.html y el vídeo promocional.
//
//   flutter test tool/capturas_test.dart --update-goldens
//
// Arranca la app completa sin Firebase ni red, con datos de demostración
// ficticios, y guarda cada pantalla en promo/capturas/ a 1080 × 2340.
//
// El tema revisado (tema-revisado y tema-anotado) se dibuja con PyMuPDF
// (python3 con fitz) a partir del PDF de la rama revision-temario si está su
// carpeta junto a la del repositorio; si no, el de la web.

import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
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
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/revisado.dart';
import 'package:tcee_app/features/preparador/ajustes_preparador_page.dart';
import 'package:tcee_app/features/preparador/coordinacion.dart';
import 'package:tcee_app/features/temario/tema_page.dart';
import 'package:tcee_app/features/temario/visor_tema.dart';
import 'package:pdfx/pdfx.dart' show PlatformNotSupportedException;


import 'demo_comun.dart';

/// El PDF del tema revisado 3.A.9: el de la rama revision-temario (su
/// carpeta, junto a la del repositorio) o, si no está, el de la web.
String pdfRevisado() {
  const revisado = '../../victorgutierrezmarcos.github.io-revision/oposicion/temario/tercer-ejercicio/3A09.pdf';
  return File(revisado).existsSync() ? revisado : '../oposicion/temario/tercer-ejercicio/3A09.pdf';
}

/// Textos de la primera página del 3.A.9 revisado sobre los que se anota.
const _anotar = ['Cada mes de enero', 'interanuales del IPC', 'La utilidad es ordinal', 'función de gasto', 'Relevancia', 'índices de precios'];

void main() {
  late PdfDemo pdf;
  setUpAll(() async {
    await prepararCapturas();
    pdf = await PdfDemo.preparar(pdfRevisado(), buscar: _anotar);
  });

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
      await tocar(find.descendant(of: find.byType(BotonesPestanas), matching: find.textContaining(nombre, findRichText: true)));
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
    await buscar(find.text('Mapa del temario'));
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
    await tocar(find.widgetWithText(FilaEnlace, 'Mi preparador'));
    await captura('mi-preparador');
    // Buscar preparador: quién admite alumnos y a quién le interesa lo que busca Álex.
    await buscar(find.text('Buscar preparador'));
    await tocar(find.text('Buscar preparador'));
    await captura('buscar-preparador');
    await buscar(find.text('Preparadores que admiten alumnos'));
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

    // ------------------------------------------------- Temario revisado
    // El 3.A.9, revisado y exclusivo de la app (datos del manifiesto real),
    // con el PDF «ya descargado»: el visor lo abre con PdfDemo.
    final tema39 = demo.temario.tema('3.A.9')!;
    const dir = 'oposicion/temario/tercer-ejercicio';
    final rev = TemaRevisado(
      codigo: '3.A.9',
      archivo: '3A09',
      titulo: tema39.titulo,
      aprobado: DateTime(2026, 10, 17),
      version: '8824310',
      pdf: const FicheroRevisado(ruta: '$dir/3A09.pdf', tamano: 945523, sha: '42aa768580'),
      docx: const FicheroRevisado(ruta: '$dir/3A09.docx', tamano: 1363988, sha: '26e0b37e7e'),
      html: const FicheroRevisado(ruta: '$dir/3A09.html', tamano: 270117, sha: 'b5d78bbf32'),
      repaso: const FicheroRevisado(ruta: '$dir/3A09-repaso.pdf', tamano: 445402, sha: 'd128b0a1cf'),
    );
    demo.revisados = ManifiestoRevisados(temas: {'3.A.9': rev});
    container.invalidate(revisadosProvider);
    File(pdfRevisado()).copySync('${demo.carpetaDescargas.path}/${rev.nombreLocal(ClaseFichero.pdf)}');
    pdf.instalar();
    void sinAvisoDePdfx() {
      final e = tester.takeException();
      if (e != null) excepciones.add(e);
    }

    /// Deja que el visor dibuje las páginas (las imágenes se decodifican fuera del reloj del test).
    Future<void> esperarPaginas() async {
      for (var i = 0; i < 4; i++) {
        await tester.pump(const Duration(milliseconds: 200));
        sinAvisoDePdfx();
        for (final e in find.descendant(of: find.byType(VisorTema), matching: find.byType(Image)).evaluate()) {
          await tester.runAsync(() => precacheImage((e.widget as Image).image, e));
        }
      }
      await tester.pumpAndSettle();
    }

    // pdfx comprueba aparte (sin esperar) si la plataforma tiene PDF y en las
    // pruebas (Linux) dice que no: ese error, que haría fallar la prueba, se
    // recoge en una zona propia al abrir el tema.
    await runZonedGuarded(() => r.abrir(TemaPage(tema: tema39)), (e, s) {
      if (e is! PlatformNotSupportedException) excepciones.add(e);
    });
    sinAvisoDePdfx();
    await esperarPaginas();
    await captura('tema-revisado');
    // Anotar: fosforito amarillo y verde, y bolígrafo rojo, con el dedo.
    await tocar(find.byTooltip('Pintar y subrayar'));
    await esperarPaginas();
    final origen = tester.getTopLeft(find.byType(VisorTema));
    final ancho = tester.getSize(find.byType(VisorTema)).width - 16;
    final alto = ancho * pdf.tamanos.first.height / pdf.tamanos.first.width;
    Offset en(double x, double y) => origen + Offset(8 + x * ancho, 8 + y * alto);
    var reloj = Duration.zero;
    Future<void> trazar(Offset de, Offset a, {double onda = 0}) async {
      final g = await tester.startGesture(de, kind: PointerDeviceKind.touch);
      const pasos = 24;
      for (var i = 1; i <= pasos; i++) {
        reloj += const Duration(milliseconds: 16);
        final p = Offset.lerp(de, a, i / pasos)!;
        // Un poco de pulso, para que no parezca una regla.
        await g.moveTo(p + Offset(0, onda * ((i % 4) - 1.5) / 1.5), timeStamp: reloj);
        await tester.pump(const Duration(milliseconds: 16));
      }
      await g.up();
      await tester.pump();
    }

    final t = pdf.textos;
    const margenDerecho = 533 / 595.28;
    await tocar(find.byTooltip('Fosforito (mantén al acabar para que salga recto)'));
    if (t['Cada mes de enero'] case final r1?) await trazar(en(r1.left, r1.center.dy), en(margenDerecho, r1.center.dy));
    if (t['interanuales del IPC'] case final r2?) await trazar(en(r2.left, r2.center.dy), en(margenDerecho, r2.center.dy));
    await tocar(find.byTooltip('Verde'));
    if (t['La utilidad es ordinal'] case final r3?) await trazar(en(r3.left, r3.center.dy), en(r3.right, r3.center.dy));
    await tocar(find.byTooltip('Bolígrafo'));
    await tocar(find.byTooltip('Rojo'));
    if (t['función de gasto'] case final r4?) await trazar(en(r4.left, r4.bottom), en(r4.right, r4.bottom), onda: 0.6);
    if ((t['Relevancia'], t['índices de precios']) case (final de?, final hasta?)) {
      await trazar(en(0.085, de.top), en(0.085, hasta.bottom), onda: 0.8);
    }
    // La barra de herramientas, desde el principio (al tocar el rojo se ha desplazado).
    await tester.drag(find.descendant(of: find.byType(VisorTema), matching: find.byType(SingleChildScrollView)).last, const Offset(800, 0));
    await esperarPaginas();
    await captura('tema-anotado');
    await tocar(find.text('Listo'));
    await r.cerrar(find.byType(TemaPage));
    sinAvisoDePdfx();

    // ------------------------------------- Varios preparadores: el opositor
    // Álex tiene dos preparadoras: Paula Pérez (3.er ejercicio) y Olga Martín (4.º).
    await demo.conDosPreparadores();
    container.invalidate(vinculosPreparadorProvider);
    DateTime hace(int dias, int hora, int minuto) => demo.dia(-dias, hora, minuto);
    demo.tablonComun = [
      NotaEntrePreparadores(id: 'm4', de: 'paula', deNombre: 'Paula Pérez', texto: 'Perfecto. Para la próxima le mando el 3.A.14 y el 3.B.5; Olga, esos ya no hace falta que se los mandes.', fecha: hace(0, 10, 5)),
      NotaEntrePreparadores(id: 'm3', de: 'olga', deNombre: 'Olga Martín', texto: 'Sí. Yo sigo con el cuarto ejercicio y Paula con el tercero, como en el reparto.', fecha: hace(1, 21, 40)),
      NotaEntrePreparadores(id: 'm2', de: 'yo', deNombre: 'Álex Martín', texto: 'Me va bien. Olga, ¿mantenemos la nuestra a las 18:00?', fecha: hace(1, 20, 15)),
      NotaEntrePreparadores(id: 'm1', de: 'paula', deNombre: 'Paula Pérez', texto: 'Álex, esta semana tengo que cancelar nuestra clase. ¿La pasamos a la semana que viene, a la misma hora?', fecha: hace(1, 19, 2)),
    ];
    await r.abrir(TablonComunPage(alumnoUid: 'yo', nombreAlumno: 'Álex Martín', soyAlumno: true));
    await captura('tablon-comun');
    await r.cerrar(find.byType(TablonComunPage));
    await r.abrir(const QueVenMisPreparadoresPage());
    await captura('que-ven');
    await r.cerrar(find.byType(QueVenMisPreparadoresPage));
    // La agenda con las clases de las dos y el aviso al apuntar un cante que choca.
    await demo.plan.guardarCantes([
      Cante(id: 'o1', fecha: demo.dia(6, 18, 0), titulo: 'Con Olga Martín', preparador: 'olga', preparadorNombre: 'Olga Martín', minutos: 120, ejercicio: 4, bolsa: TipoBolsa.estudiados, modalidad: Modalidad.online, enlace: 'https://meet.google.com/oga-mrtn-lun', updatedAt: demo.hoy),
      Cante(id: 'o2', fecha: demo.dia(13, 18, 0), titulo: 'Con Olga Martín', preparador: 'olga', preparadorNombre: 'Olga Martín', minutos: 120, ejercicio: 4, bolsa: TipoBolsa.estudiados, updatedAt: demo.hoy),
      Cante(id: 'pv', fecha: demo.dia(10, 18, 0), titulo: 'Con Paula Pérez', preparador: 'paula', preparadorNombre: 'Paula Pérez', minutos: 120, bolsa: TipoBolsa.estudiados, updatedAt: demo.hoy),
    ]);
    container.invalidate(cantesProvider);
    await subpestana('Agenda');
    // Hasta los próximos cantes, cada clase con el color de su preparadora.
    await tester.drag(find.text('Próximos cantes'), const Offset(0, -650));
    await tester.pumpAndSettle();
    await captura('agenda-comun');
    final choques = choquesEnAgenda(container.read(cantesProvider), demo.dia(6, 19, 0), 30);
    unawaited(confirmarChoques(tester.element(find.byType(Scaffold).first), choques));
    await tester.pumpAndSettle();
    await captura('agenda-choque');
    await tocar(find.text('Cambiar la hora'));
    await bajar(-20000);

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
    // Desde la 1.19.2 la hoja ofrece los temas de esa clase, no todo el temario: los dos primeros.
    await tocar(find.textContaining(RegExp(r'^3\.[AB]\.\d+$')).at(0));
    await tocar(find.textContaining(RegExp(r'^3\.[AB]\.\d+$')).at(1));
    await captura('tema-programar');
    // El botón queda por debajo del borde de la hoja: se sube la hoja.
    await tester.drag(find.textContaining('Cuándo le llegan'), const Offset(0, -700));
    await tester.pumpAndSettle();
    await tocar(find.text('Programar el envío'));
    await captura('sesion-tema');
    // La ficha de la clase: todo se cambia desde aquí (y la reunión de Teams).
    // Ahora «Temas antes de la clase» va antes: los detalles quedan más abajo.
    await buscarEn<SesionPage>(find.text('Detalles de la clase'));
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
    Navigator.of(tester.element(find.byType(SesionPage))).pop();
    await tester.pumpAndSettle();

    // ----------------------------------- Varios preparadores: el preparador
    // Lucía también prepara el 4.º ejercicio con Olga Martín: se ven sus
    // clases (sin la valoración), las notas entre los dos y el reparto.
    demo.cantesDeAlumno = [
      ...demo.cantesDeAlumno,
      Cante(id: 'lo1', fecha: demo.dia(-5, 18, 0), titulo: '', preparador: 'olga', preparadorNombre: 'Olga Martín', estado: EstadoCante.hecho, ejercicio: 4, bolsa: TipoBolsa.estudiados, resultado: const ResultadoCante(sorteados: ['4.A.3'], temaCantado: '4.A.3', segundos: 1750), updatedAt: demo.hoy),
      Cante(id: 'lo2', fecha: demo.dia(2, 18, 0), titulo: '', preparador: 'olga', preparadorNombre: 'Olga Martín', ejercicio: 4, minutos: 120, bolsa: TipoBolsa.estudiados, updatedAt: demo.hoy),
    ];
    demo.otrosPreparadores = const [OtroPreparador(uid: 'olga', nombre: 'Olga Martín', linkedin: 'https://www.linkedin.com/in/olga-martin', telefono: '611 22 33 44')];
    demo.notasPreparadores = [
      NotaEntrePreparadores(id: 'n2', de: 'yo', deNombre: 'Víctor', texto: 'Hecho. Esta semana le mando el 3.A.17 (el monopolio natural sigue flojo) y no toco el cuarto.', fecha: demo.dia(0, 9, 30)),
      NotaEntrePreparadores(id: 'n1', de: 'olga', deNombre: 'Olga Martín', texto: 'Lucía va bien en el cuarto ejercicio; en micro me dice que le cuesta la discriminación de precios. ¿Lo refuerzas tú?', fecha: demo.dia(-1, 21, 10)),
    ];
    demo.reparto = {'yo': const RepartoPreparador(ejercicios: {3}, nota: 'micro y comercio'), 'olga': const RepartoPreparador(ejercicios: {4})};
    demo.mandadosPorOtros = {'lo2': ['4.A.9']};
    await demo.preparador.guardarPerfil(demo.preparador.perfil().copyWith(telefono: '600 11 22 33', calendarioGoogle: true));
    for (final p in [progresoAlumnoProvider, otrosPreparadoresProvider, notasPreparadoresProvider, comparteContactoProvider, repartoProvider, temasMandadosPorOtrosProvider]) {
      container.invalidate(p);
    }
    container.invalidate(perfilPreparadorProvider);
    await tester.pumpAndSettle();
    await bajarEn<AlumnoPage>(-20000);
    await buscarEn<AlumnoPage>(find.text('Notas entre preparadores'));
    // Desde el reparto («Qué lleva cada uno») hasta las notas.
    await bajarEn<AlumnoPage>(-480);
    await captura('otros-preparadores');
    await bajarEn<AlumnoPage>(-20000);
    // Google Calendar, conectado, en Ajustes de preparador.
    await r.abrir(const AjustesPreparadorPage());
    await buscarEn<AjustesPreparadorPage>(find.text('Mis clases en Google Calendar'));
    await captura('calendario');
    await r.cerrar(find.byType(AjustesPreparadorPage));

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
