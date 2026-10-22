// La pizarra con el lápiz: letras rápidas (levantar y apoyar enseguida) y lo
// que pasa cuando el navegador se traga el levantar o el apoyar (en el iPad,
// Scribble), que el motor de Flutter en la web convierte en un move del
// trazo anterior o en un levantar que nunca llega.
import 'dart:async';
import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';
import 'package:tcee_app/features/cantar/pizarra_registro.dart';
import 'package:tcee_app/features/cantar/pizarra_trazos.dart';

const _lienzo = Offset(600, 500);

Future<PizarraLocal> montar(WidgetTester tester, {Stream<EventoDom>? eventosDom}) async {
  tester.view.physicalSize = const Size(1200, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final fuente = PizarraLocal();
  await tester.pumpWidget(ProviderScope(child: MaterialApp(home: PizarraPage.individual(fuente: fuente, eventosDom: eventosDom))));
  await tester.pumpAndSettle();
  return fuente;
}

int trazos(PizarraLocal f) => f.paginas.fold(0, (n, p) => n + p.trazos.length);

/// Una letra: apoyar, ocho puntos en zigzag cada 8 ms y, si [up], levantar.
/// Devuelve el instante del último punto.
Future<Duration> letra(WidgetTester tester, TestGesture g, Offset p, Duration t, {bool up = true}) async {
  await g.down(p, timeStamp: t);
  for (var i = 1; i <= 8; i++) {
    t += const Duration(milliseconds: 8);
    await g.moveTo(p + Offset(3.0 * i, i.isEven ? 6 : 0), timeStamp: t);
    await tester.pump(const Duration(milliseconds: 8));
  }
  if (up) await g.up(timeStamp: t + const Duration(milliseconds: 8));
  // Que se guarde (microtask de PizarraLocal) y pase el plazo de cierre del navegador.
  await tester.pump(const Duration(milliseconds: 50));
  return t;
}

void main() {
  testWidgets('dos letras seguidas con el lápiz son dos trazos', (tester) async {
    final fuente = await montar(tester);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    var t = await letra(tester, g, _lienzo, const Duration(seconds: 1));
    t = await letra(tester, g, _lienzo + const Offset(40, 0), t + const Duration(milliseconds: 30));
    expect(trazos(fuente), 2);
  });

  testWidgets('un apoyar nuevo sin levantar el anterior guarda el anterior y empieza otro', (tester) async {
    final fuente = await montar(tester);
    final g1 = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    final t = await letra(tester, g1, _lienzo, const Duration(seconds: 1), up: false);
    final g2 = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 2);
    await letra(tester, g2, _lienzo + const Offset(40, 0), t + const Duration(milliseconds: 30));
    expect(trazos(fuente), 2);
    await g1.up();
  });

  testWidgets('una pausa y un salto en el mismo puntero cortan el trazo (el motor unió dos letras)', (tester) async {
    final fuente = await montar(tester);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    var t = await letra(tester, g, _lienzo, const Duration(seconds: 1), up: false);
    // El pointerdown que el navegador entregó llega a Flutter como un move
    // lejos y tarde.
    t += const Duration(milliseconds: 120);
    final p = _lienzo + const Offset(60, 40);
    await g.moveTo(p, timeStamp: t);
    for (var i = 1; i <= 4; i++) {
      t += const Duration(milliseconds: 8);
      await g.moveTo(p + Offset(3.0 * i, 0), timeStamp: t);
      await tester.pump(const Duration(milliseconds: 8));
    }
    await g.up(timeStamp: t);
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 2);
  });

  testWidgets('una pausa sin salto, o un salto sin pausa, no cortan el trazo', (tester) async {
    final fuente = await montar(tester);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    var t = await letra(tester, g, _lienzo, const Duration(seconds: 1), up: false);
    // Se para 120 ms y sigue cerca (5 px).
    t += const Duration(milliseconds: 120);
    await g.moveTo(_lienzo + const Offset(29, 0), timeStamp: t);
    // Va muy deprisa (60 px en 8 ms) sin pararse.
    t += const Duration(milliseconds: 8);
    await g.moveTo(_lienzo + const Offset(89, 0), timeStamp: t);
    await tester.pump(const Duration(milliseconds: 8));
    await g.up(timeStamp: t);
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 1);
  });

  testWidgets('los puntos que el navegador manda dos veces no se añaden dos veces', (tester) async {
    final fuente = await montar(tester);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    var t = const Duration(seconds: 1);
    await g.down(_lienzo, timeStamp: t);
    // Cuatro puntos y, como hace WebKit en el iPad, los mismos cuatro otra vez.
    for (var vuelta = 0; vuelta < 2; vuelta++) {
      t = const Duration(seconds: 1);
      for (var i = 1; i <= 4; i++) {
        t += const Duration(milliseconds: 4);
        await g.moveTo(_lienzo + Offset(10.0 * i, 0), timeStamp: t);
      }
      await tester.pump(const Duration(milliseconds: 16));
    }
    await g.up(timeStamp: t + const Duration(milliseconds: 4));
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 1);
    // Un trazo recto: cinco puntos, sin ir y volver (simplificado quedan los dos extremos).
    final puntos = fuente.paginas.first.trazos.first.puntos;
    expect(puntos.length, 2);
    expect(puntos.last.x > puntos.first.x, isTrue);
  });

  testWidgets('un cancel guarda el trazo', (tester) async {
    final fuente = await montar(tester);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    final t = await letra(tester, g, _lienzo, const Duration(seconds: 1), up: false);
    await g.cancel(timeStamp: t);
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 1);
  });

  testWidgets('el pointerdown del navegador con un trazo abierto cierra el trazo en el move siguiente', (tester) async {
    final dom = StreamController<EventoDom>();
    final fuente = await montar(tester, eventosDom: dom.stream);
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    var t = await letra(tester, g, _lienzo, const Duration(seconds: 1), up: false);
    dom.add(const EventoDom(tipo: 'pointerdown', puntero: 'pen', id: 9, botones: 1));
    await tester.pump();
    // Un move cerca y enseguida: solo el aviso del navegador lo corta.
    for (var i = 1; i <= 4; i++) {
      t += const Duration(milliseconds: 8);
      await g.moveTo(_lienzo + Offset(24 + 3.0 * i, 10), timeStamp: t);
      await tester.pump(const Duration(milliseconds: 8));
    }
    await g.up(timeStamp: t);
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 2);
    await dom.close();
  });

  testWidgets('el pointerup del navegador sin levantar de Flutter guarda el trazo', (tester) async {
    final dom = StreamController<EventoDom>();
    final fuente = await montar(tester, eventosDom: dom.stream);
    final g1 = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    final t = await letra(tester, g1, _lienzo, const Duration(seconds: 1), up: false);
    dom.add(const EventoDom(tipo: 'pointerup', puntero: 'pen', id: 9));
    await tester.pump(const Duration(milliseconds: 50));
    expect(trazos(fuente), 1);
    // Y el siguiente apoyar empieza limpio.
    final g2 = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 2);
    await letra(tester, g2, _lienzo + const Offset(40, 0), t + const Duration(milliseconds: 60));
    expect(trazos(fuente), 2);
    await g1.up();
    await dom.close();
  });

  testWidgets('texto a máquina: con la herramienta, un toque abre el cuadro y el texto se guarda; otro toque lo corrige o lo quita', (tester) async {
    final fuente = await montar(tester);
    // La herramienta se pone desde el menú ··· y queda elegida.
    await tester.tap(find.byTooltip('Más herramientas y opciones'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Texto (escribir con el teclado)'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Texto: toca donde quieras escribir con el teclado'), findsOneWidget);
    // Un toque con el ratón en el lienzo.
    final g = await tester.createGesture(kind: PointerDeviceKind.mouse, pointer: 1);
    await g.addPointer(location: _lienzo);
    await g.down(_lienzo);
    await g.up();
    await tester.pumpAndSettle();
    expect(find.text('Escribir en la pizarra'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Oferta y demanda');
    await tester.tap(find.text('Poner'));
    await tester.pumpAndSettle();
    expect(trazos(fuente), 1);
    final t = fuente.paginas.single.trazos.single;
    expect(t.esTexto, isTrue);
    expect(t.texto, 'Oferta y demanda');
    expect(t.ancho, greaterThan(0));
    expect(t.alto, greaterThan(0));
    // Tocar sobre el texto lo corrige.
    await g.down(_lienzo + const Offset(10, 5));
    await g.up();
    await tester.pumpAndSettle();
    expect(find.text('Corregir el texto'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Oferta, demanda y equilibrio');
    await tester.tap(find.text('Poner'));
    await tester.pumpAndSettle();
    expect(fuente.paginas.single.trazos.single.texto, 'Oferta, demanda y equilibrio');
    expect(fuente.paginas.single.trazos.single.puntos, t.puntos, reason: 'se queda donde estaba');
    // Y «Quitar» lo quita.
    await g.down(_lienzo + const Offset(10, 5));
    await g.up();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quitar'));
    await tester.pumpAndSettle();
    expect(trazos(fuente), 0);
    // Arrastrar con la herramienta de texto no escribe.
    await g.down(_lienzo);
    await g.moveTo(_lienzo + const Offset(80, 0));
    await g.up();
    await tester.pumpAndSettle();
    expect(find.text('Escribir en la pizarra'), findsNothing);
    await g.removePointer();
    // El cuadro libera su controlador un segundo después de cerrarse.
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('las notas del preparador, para el alumno: solo mirar, sin paleta y con el PDF', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final fuente = PizarraLocal();
    fuente.encolar('p1', 1, Trazo.texto(id: 'tx', de: 'paula', posicion: const Point(100, 100), texto: 'Repasa el tema 3', tamano: 36, ancho: 300, alto: 45));
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: PizarraPage.notas(alumnoUid: 'alu', canteId: 'c1', preparadorUid: 'paula', otroNombre: 'Paula', soloLectura: true, fuente: fuente))));
    await tester.pumpAndSettle();
    expect(find.text('Notas de Paula'), findsOneWidget);
    expect(find.byTooltip('Bolígrafo'), findsNothing);
    expect(find.byTooltip('Guardar como PDF'), findsOneWidget);
    expect(find.byTooltip('Más herramientas y opciones'), findsNothing);
    // Dibujar no hace nada.
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    await letra(tester, g, _lienzo, const Duration(seconds: 1));
    expect(fuente.paginas.single.trazos.length, 1);
  });

  testWidgets('las notas con permiso de edición: al alumno le sale la paleta y dibuja, pero no crea ni elimina páginas', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final db = FakeFirebaseFirestore();
    final prep = PizarraCompartida.notasDeClase(db, Oposiciones.tcee, preparadorUid: 'paula', alumnoUid: 'alu', canteId: 'c1', miUid: 'paula');
    await prep.nuevaPagina(1);
    await prep.ponerEnTodas({'visible': true, 'editable': true});
    final alu = PizarraCompartida.notasDeClase(db, Oposiciones.tcee, preparadorUid: 'paula', alumnoUid: 'alu', canteId: 'c1', miUid: 'alu');
    await tester.pumpWidget(ProviderScope(child: MaterialApp(home: PizarraPage.notas(alumnoUid: 'alu', canteId: 'c1', preparadorUid: 'paula', otroNombre: 'Paula', soloLectura: true, fuente: alu))));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byTooltip('Bolígrafo'), findsOneWidget, reason: 'con permiso, la paleta de siempre');
    expect(find.text('Notas de Paula'), findsNothing);
    expect(find.byTooltip('Nueva página'), findsNothing, reason: 'las páginas las crea el preparador');
    final g = await tester.createGesture(kind: PointerDeviceKind.stylus, pointer: 1);
    await letra(tester, g, _lienzo, const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));
    final pagina = (await prep.escuchar().firstWhere((p) => p.isNotEmpty && p.first.trazos.isNotEmpty)).first;
    expect(pagina.trazos.single.de, 'alu');
    expect(pagina.editable, isTrue);
    await tester.pump(const Duration(seconds: 1));
  });

  test('corte del trazo: solo con pausa y salto a la vez', () {
    expect(cortaTrazoLapiz(const Duration(milliseconds: 80), 20), isTrue);
    expect(cortaTrazoLapiz(const Duration(milliseconds: 200), 60), isTrue);
    expect(cortaTrazoLapiz(const Duration(milliseconds: 79), 60), isFalse);
    expect(cortaTrazoLapiz(const Duration(milliseconds: 200), 19), isFalse);
    expect(cortaTrazoLapiz(const Duration(milliseconds: 8), 60), isFalse);
  });

  test('el registro acota las líneas y lleva cabecera', () {
    final r = RegistroPizarra(maximo: 3);
    r.anotar('LOG', 'apagado');
    expect(r.lineas, 0);
    r.activo = true;
    for (var i = 0; i < 5; i++) {
      r.anotar('LOG', 'línea $i');
    }
    expect(r.lineas, 3);
    final texto = r.volcar(cabecera: 'Cabecera');
    expect(texto, startsWith('Cabecera\nt='));
    expect(texto, contains('LOG línea 4'));
    expect(texto, isNot(contains('línea 1')));
  });
}
