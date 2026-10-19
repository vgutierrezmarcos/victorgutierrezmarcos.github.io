// La pizarra con el lápiz: letras rápidas (levantar y apoyar enseguida) y lo
// que pasa cuando el navegador se traga el levantar o el apoyar (en el iPad,
// Scribble), que el motor de Flutter en la web convierte en un move del
// trazo anterior o en un levantar que nunca llega.
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_page.dart';
import 'package:tcee_app/features/cantar/pizarra_registro.dart';

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
