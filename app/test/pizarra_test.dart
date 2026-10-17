import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_formas.dart';
import 'package:tcee_app/features/cantar/pizarra_tinta.dart';
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

  group('tinta y herramientas', () {
    test('presión y herramienta van en campos que las versiones anteriores ignoran', () {
      const t = Trazo(id: 'a', de: 'yo', grosor: 6, color: 0x66FFD60A, herramienta: herramientaFosforito, presiones: [3, 9], puntos: [Point(10, 10), Point(40, 10)]);
      final j = t.toJson();
      expect(j['w'], '39');
      expect(j['h'], 'f');
      expect(j['p'], '10,10 30,0', reason: 'los puntos, como siempre');
      final otra = Trazo.fromJson(j);
      expect(otra.presiones, [3, 9]);
      expect(otra.esFosforito, isTrue);
      // El bolígrafo no se escribe (es lo de siempre) y una presión que no
      // cuadra con los puntos se ignora.
      expect(const Trazo(id: 'b', de: 'yo', grosor: 3, herramienta: herramientaBoligrafo, puntos: [Point(0, 0)]).toJson().containsKey('h'), isFalse);
      expect(Trazo.fromJson({'i': 'c', 'u': 'yo', 'g': 3, 'p': '0,0 1,1', 'w': '5'}).presiones, isNull);
      expect(factorDeDigito(digitoDeFactor(0.83)), closeTo(0.8, 1e-9));
    });

    test('el contorno de la tinta cubre el trazo y un punto suelto se ve', () {
      final recta = caminoTinta([const Offset(0, 0), const Offset(50, 0), const Offset(100, 0)], [6, 6, 6]);
      expect(recta.contains(const Offset(50, 0)), isTrue);
      expect(recta.contains(const Offset(50, 2.5)), isTrue);
      expect(recta.contains(const Offset(50, 4)), isFalse);
      expect(recta.contains(const Offset(102, 0)), isTrue, reason: 'remate redondo');
      // Una esquina cerrada (ida y vuelta) no deja huecos.
      final v = caminoTinta([const Offset(0, 0), const Offset(50, 0), const Offset(0, 4)], [6, 6, 6]);
      expect(v.contains(const Offset(25, 1)), isTrue);
      expect(caminoTinta([const Offset(5, 5)], [6]).contains(const Offset(6, 5)), isTrue);
      // La presión ensancha.
      final presion = caminoDeTrazo(const Trazo(id: 'p', de: 'yo', grosor: 10, presiones: [9, 9], puntos: [Point(0, 0), Point(100, 0)]));
      expect(presion.contains(const Offset(50, 6)), isTrue);
    });

    test('borrar por partes corta el trazo en dos y deja lo que no se toca', () {
      const t = Trazo(id: 'a', de: 'yo', grosor: 4, presiones: [5, 5], puntos: [Point(0, 0), Point(200, 0)]);
      expect(trocear(t, const Point(100, 50), 10), isNull, reason: 'no lo toca');
      final trozos = trocear(t, const Point(100, 0), 10, random: Random(1))!;
      expect(trozos, hasLength(2));
      expect(trozos.first.puntos.first, const Point(0, 0));
      expect(trozos.last.puntos.last, const Point(200, 0));
      expect(trozos.first.puntos.last.x, lessThan(90));
      expect(trozos.last.puntos.first.x, greaterThan(110));
      expect(trozos.every((x) => x.presiones!.length == x.puntos.length && x.id != 'a'), isTrue);
      // Por un extremo, queda uno; si se toca entero, nada.
      expect(trocear(t, const Point(0, 0), 10), hasLength(1));
      expect(trocear(const Trazo(id: 'b', de: 'yo', grosor: 4, puntos: [Point(5, 5)]), const Point(5, 5), 10), isEmpty);
    });

    test('simplificar conserva la presión de los puntos que quedan', () {
      final puntos = [for (var i = 0; i <= 20; i++) Point<double>(i.toDouble(), 0)];
      expect(indicesSimplificados(puntos, tolerancia: 0.5), [0, 20]);
    });
  });

  group('formas al mantener', () {
    List<Point<double>> mano(Iterable<Point<double>> pts) {
      final r = Random(7);
      return [for (final p in pts) Point(p.x + r.nextDouble() * 2 - 1, p.y + r.nextDouble() * 2 - 1)];
    }

    test('una recta casi horizontal sale recta y horizontal', () {
      final f = reconocerForma(mano([for (var i = 0; i <= 50; i++) Point(100.0 + 4 * i, 300 + i * 0.12)]))!;
      expect(f, hasLength(2));
      expect(f.first.y, f.last.y);
    });

    test('unos ejes en L salen con un lado vertical y otro horizontal', () {
      final f = reconocerForma(mano([
        for (var i = 0; i <= 40; i++) Point(100.0 + i * 0.1, 100.0 + 5 * i),
        for (var i = 1; i <= 50; i++) Point(104.0 + 5 * i, 300.0 + i * 0.1),
      ]))!;
      expect(f, hasLength(3));
      expect(f[0].x, f[1].x);
      expect(f[1].y, f[2].y);
    });

    test('un círculo, un rectángulo y un triángulo', () {
      final circulo = reconocerForma(mano([for (var k = 0; k <= 60; k++) Point(400 + 100 * cos(2 * pi * k / 60), 400 + 98 * sin(2 * pi * k / 60))]))!;
      expect(circulo.length, greaterThan(40));
      for (final p in circulo) {
        expect(p.distanceTo(const Point(400, 400)), closeTo(100, 4));
      }
      final rect = reconocerForma(mano([
        for (var i = 0; i < 30; i++) Point(100.0 + 10 * i, 100),
        for (var i = 0; i < 20; i++) Point(400, 100.0 + 10 * i),
        for (var i = 0; i < 30; i++) Point(400.0 - 10 * i, 300),
        for (var i = 0; i <= 20; i++) Point(100, 300.0 - 10 * i),
      ]))!;
      expect(rect, hasLength(5));
      expect(rect.first, rect.last);
      final tri = reconocerForma(mano([
        for (var i = 0; i < 30; i++) Point(100.0 + 10 * i, 400),
        for (var i = 0; i < 30; i++) Point(400.0 - 5 * i, 400.0 - 8 * i),
        for (var i = 0; i <= 30; i++) Point(250.0 - 5 * i, 160.0 + 8 * i),
      ]))!;
      expect(tri, hasLength(4));
    });

    test('una curva de oferta sale alisada, con sus extremos', () {
      final curva = [for (var i = 0; i <= 80; i++) Point<double>(100.0 + 5 * i, 600 - 0.04 * pow(i * 5, 1.6).toDouble())];
      final f = reconocerForma(mano(curva))!;
      expect(f.length, greaterThan(10));
      expect(f.first.distanceTo(curva.first), lessThan(2));
      expect(f.last.distanceTo(curva.last), lessThan(2));
      expect(reconocerForma([const Point(0, 0), const Point(3, 3), const Point(5, 0)]), isNull, reason: 'demasiado pequeño');
    });
  });

  test('el lazo coge los trazos que rodea', () {
    const dentro = Trazo(id: 'a', de: 'yo', grosor: 3, puntos: [Point(50, 50), Point(80, 60)]);
    const fuera = Trazo(id: 'b', de: 'yo', grosor: 3, puntos: [Point(300, 300), Point(320, 310)]);
    const mitad = Trazo(id: 'c', de: 'yo', grosor: 3, puntos: [Point(90, 50), Point(190, 50)]);
    final lazo = [const Point<double>(0, 0), const Point<double>(100, 0), const Point<double>(100, 100), const Point<double>(0, 100)];
    expect(rodeados([dentro, fuera, mitad], lazo).map((t) => t.id), ['a']);
  });

  test('la regla endereza sobre su canto y se queda en los ángulos redondos', () {
    const regla = Regla(centro: Point(800, 500), ancho: 100);
    expect(regla.cantoJunto(const Point(700, 445), 20), -1);
    expect(regla.cantoJunto(const Point(700, 560), 20), 1);
    expect(regla.cantoJunto(const Point(700, 500), 20), isNull, reason: 'en medio de la regla');
    final p = regla.sobreCanto(const Point(650, 540), 1, 2);
    expect(p.y, closeTo(552, 1e-9));
    expect(p.x, closeTo(650, 1e-9));
    expect(regla.girada(pi / 4 + 0.01, const Point(800, 500)).grados, 45);
    expect(regla.girada(0.3, const Point(800, 500)).grados, 17);
    expect(regla.contiene(const Point(800, 520)), isTrue);
  });

  test('reemplazar quita y pone de una vez, y el papel lo ven los dos', () async {
    final db = FakeFirebaseFirestore();
    final alumno = PizarraCompartida.deClase(db, Oposiciones.tcee, alumnoUid: 'alu', canteId: 'c1', miUid: 'alu');
    final preparador = PizarraCompartida.deClase(db, Oposiciones.tcee, alumnoUid: 'alu', canteId: 'c1', miUid: 'paula');
    await alumno.anadirTrazos('p1', 1, [
      const Trazo(id: 'a', de: 'alu', grosor: 3, puntos: [Point(0, 0), Point(10, 10)]),
      const Trazo(id: 'b', de: 'alu', grosor: 3, presiones: [4, 6], puntos: [Point(5, 5), Point(20, 20)]),
    ]);
    // Mover «b» con el lazo: sale «b» y entra «b2», en otro sitio.
    final b = (await preparador.escuchar().first).single.trazos.last;
    await preparador.reemplazar('p1', 1, [b], [b.copia(id: 'b2', dx: 100, dy: 0)]);
    await preparador.cambiarFondo('p1', 1, fondoCuadricula);
    final pagina = (await alumno.escuchar().firstWhere((p) => p.single.fondo == fondoCuadricula)).single;
    expect(pagina.trazos.map((t) => t.id), ['a', 'b2']);
    expect(pagina.trazos.last.puntos.first, const Point(105, 5));
    expect(pagina.trazos.last.presiones, [4, 6]);

    // En la de practicar, igual.
    final local = PizarraLocal();
    // Escuchando desde antes (los avisos llegan en una microtarea).
    final ultima = local.escuchar().firstWhere((p) => p.isNotEmpty && p.single.fondo == fondoRayas);
    local.encolar('p1', 1, const Trazo(id: 'x', de: 'yo', grosor: 3, puntos: [Point(1, 1)]));
    await local.reemplazar('p1', 1, [const Trazo(id: 'x', de: 'yo', grosor: 3, puntos: [Point(1, 1)])], [const Trazo(id: 'y', de: 'yo', grosor: 3, puntos: [Point(2, 2)])]);
    await local.cambiarFondo('p1', 1, fondoRayas);
    expect((await ultima).single.trazos.map((t) => t.id), ['y']);
  });
}
