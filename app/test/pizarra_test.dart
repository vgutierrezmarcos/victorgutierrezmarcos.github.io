import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_trazos.dart';

/// Pizarra compartida: cómo se guardan los trazos y que lo que dibuja uno lo
/// ve el otro.
void main() {
  test('trazo con color: ida y vuelta en JSON, y si pasa cerca de un punto (para el borrador)', () {
    const t = Trazo(id: 'a', de: 'yo', grosor: 6, color: 0xFFC62828, puntos: [Point(100, 100), Point(300, 100)]);
    final j = t.toJson();
    expect(j['c'], 0xFFC62828);
    expect(Trazo.fromJson(j).color, 0xFFC62828);
    expect(Trazo.fromJson({'i': 'b', 'u': 'yo', 'g': 3, 'p': '0,0'}).color, isNull, reason: 'los trazos de antes no llevan color');
    expect(t.cerca(const Point(200, 110), 10), isTrue);
    expect(t.cerca(const Point(200, 140), 10), isFalse);
    expect(t.cerca(const Point(320, 100), 10), isFalse, reason: 'más allá del extremo');
  });

  group('trazos', () {
    test('los puntos van como diferencias y vuelven iguales', () {
      final puntos = [const Point(812, 420), const Point(815, 418), const Point(820, 418), const Point(824, 419)];
      final texto = codificarPuntos(puntos);
      expect(texto, '812,420 3,-2 5,0 4,1');
      expect(decodificarPuntos(texto), puntos);
      expect(decodificarPuntos(''), isEmpty);
      expect(decodificarPuntos('basura 1,x'), isEmpty);
    });

    test('un trazo guarda y recupera lo mismo', () {
      final t = Trazo(id: 'abc', de: 'paula', grosor: 6, puntos: [const Point(1, 1), const Point(10, 10)]);
      final otra = Trazo.fromJson(t.toJson());
      expect(otra.id, 'abc');
      expect(otra.de, 'paula');
      expect(otra.grosor, 6);
      expect(otra.puntos, t.puntos);
      expect(otra.crudo, t.toJson());
    });

    test('la simplificación deja una recta en sus dos extremos y conserva las esquinas', () {
      final recta = [for (var i = 0; i <= 100; i++) Point<double>(i.toDouble(), i * 0.5)];
      expect(simplificar(recta), [recta.first, recta.last]);
      final esquina = [for (var i = 0; i <= 50; i++) Point<double>(i.toDouble(), 0), for (var i = 1; i <= 50; i++) Point<double>(50, i.toDouble())];
      expect(simplificar(esquina), [const Point(0, 0), const Point(50, 0), const Point(50, 50)]);
      expect(simplificar([const Point(1, 1)]), [const Point(1, 1)]);
    });

    test('una página sabe cuándo está llena', () {
      final poca = PaginaPizarra(id: 'p1', n: 1, trazos: [Trazo(id: 'a', de: 'x', grosor: 3, puntos: [const Point(1, 1)])]);
      expect(poca.llena, isFalse);
      final largo = Trazo(id: 'b', de: 'x', grosor: 3, puntos: [for (var i = 0; i < 200000; i++) Point(i % 1600, i % 1000)]);
      expect(PaginaPizarra(id: 'p1', n: 1, trazos: [largo]).llena, isTrue);
    });
  });

  test('lo que dibuja el preparador lo ve el alumno, y al revés; deshacer y borrar', () async {
    final db = FakeFirebaseFirestore();
    for (final op in [Oposiciones.tcee, Oposiciones.dce]) {
      final alumno = PizarraCompartida.deClase(db, op, alumnoUid: 'alu', canteId: 'c1', miUid: 'alu');
      final preparador = PizarraCompartida.deClase(db, op, alumnoUid: 'alu', canteId: 'c1', miUid: 'paula');

      // Una ráfaga de tres trazos es una sola escritura con los tres.
      for (var i = 0; i < 3; i++) {
        preparador.encolar('p1', 1, Trazo(id: 't$i', de: 'paula', grosor: 6, puntos: [Point(i, i), Point(i + 5, i + 5)]));
      }
      expect(preparador.conPendientes, isTrue);
      await preparador.vaciar();
      expect(preparador.conPendientes, isFalse);

      var paginas = await alumno.escuchar().firstWhere((p) => p.isNotEmpty);
      expect(paginas.single.id, 'p1');
      expect(paginas.single.trazos.map((t) => t.id), ['t0', 't1', 't2']);
      expect(paginas.single.trazos.first.de, 'paula');

      // El alumno dibuja encima y el preparador lo ve.
      await alumno.anadirTrazos('p1', 1, [Trazo(id: 'a1', de: 'alu', grosor: 3, puntos: [const Point(100, 100)])]);
      paginas = await preparador.escuchar().firstWhere((p) => p.isNotEmpty && p.single.trazos.length == 4);
      expect(paginas.single.trazos.last.de, 'alu');

      // Deshacer quita solo ese trazo (con el elemento tal como vino).
      final mio = paginas.single.trazos.firstWhere((t) => t.id == 't1');
      await preparador.deshacer('p1', mio.crudo!);
      paginas = await alumno.escuchar().firstWhere((p) => p.single.trazos.length == 3);
      expect(paginas.single.trazos.map((t) => t.id), ['t0', 't2', 'a1']);

      // Otra página y borrar todo la primera.
      await preparador.nuevaPagina(2);
      await alumno.borrarTodo('p1');
      paginas = await preparador.escuchar().firstWhere((p) => p.length == 2 && p.first.trazos.isEmpty);
      expect(paginas.map((p) => p.n), [1, 2]);
      expect(paginas.first.borradoPor, 'alu');
    }
  });
}
