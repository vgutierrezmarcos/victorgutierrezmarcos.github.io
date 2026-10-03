import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';

/// Cronograma (en prueba): orden por bloques y conexiones del PowerPoint,
/// intercalado de Mixto (3.º) o de las dos partes (4.º), reparto por semanas,
/// retraso y replanificación. Con la organización real del temario.
void main() {
  late EstructuraTemario e;
  late Temario temario;
  setUpAll(() {
    e = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
  });
  Set<String> temasDe(int ej) => temario.todosLosTemas.where((t) => t.ejercicio == ej).map((t) => t.codigo).toSet();

  test('orden sugerido: todos los temas, una vez, y los de un bloque seguidos', () {
    final todos = temasDe(3);
    final orden = ordenSugerido(e, 3, todos);
    expect(orden.toSet(), todos);
    expect(orden.length, todos.length);
    // Cada bloque aparece en un único tramo seguido.
    final tramos = <String>[];
    for (final t in orden) {
      final b = e.bloqueDe(t)?.id ?? 'suelto';
      if (tramos.isEmpty || tramos.last != b) tramos.add(b);
    }
    expect(tramos.length, tramos.toSet().length, reason: 'un bloque partido en dos tramos: $tramos');
    // Empieza por el primer bloque del PowerPoint.
    expect(e.bloqueDe(orden.first)!.id, e.deEjercicio(3).first.id);
  });

  test('solo los temas elegidos', () {
    final elegidos = {'3.A.2', '3.A.4', '3.B.7', '3.B.8', '3.A.30'};
    expect(ordenSugerido(e, 3, elegidos).toSet(), elegidos);
  });

  test('intercalado: Mixto repartido a lo largo de la vuelta, no amontonado', () {
    final orden = ordenInicial(e, 3, temasDe(3));
    final mixto = temaSecundario(e, 3, orden);
    final n = orden.where(mixto).length;
    expect(n, greaterThan(20)); // los cuatro bloques de Mixto
    // En cada tramo de 4 temas hay como mucho 2 de Mixto, y casi siempre 1.
    for (var i = 0; i + 4 <= orden.length; i += 4) {
      expect(orden.sublist(i, i + 4).where(mixto).length, lessThanOrEqualTo(2));
    }
    expect(unoDeCada(e, 3, orden), inInclusiveRange(3, 4));
    // Sin intercalar, los de Mixto van juntos en sus bloques.
    final seguidos = ordenSugerido(e, 3, temasDe(3));
    var maximo = 0, racha = 0;
    for (final t in seguidos) {
      racha = mixto(t) ? racha + 1 : 0;
      if (racha > maximo) maximo = racha;
    }
    expect(maximo, greaterThan(5));
  });

  test('intercalado «1 de cada N» y respeto del orden de cada grupo', () {
    final orden = ['a1', 'a2', 'a3', 'a4', 'a5', 'm1', 'm2'];
    bool m(String t) => t.startsWith('m');
    expect(intercalarTemas(orden, m, cadaN: 3), ['a1', 'a2', 'm1', 'a3', 'a4', 'm2', 'a5']);
    expect(intercalarTemas(orden, m), ['a1', 'a2', 'm1', 'a3', 'a4', 'm2', 'a5']);
    expect(intercalarTemas(['a1', 'a2'], m), ['a1', 'a2']);
  });

  test('cuarto: alterna las dos partes', () {
    final orden = ordenInicial(e, 4, temasDe(4));
    expect(orden.toSet(), temasDe(4));
    var maximo = 0, racha = 0;
    String? previa;
    for (final t in orden) {
      final parte = t.substring(0, 3);
      racha = parte == previa ? racha + 1 : 1;
      previa = parte;
      if (racha > maximo) maximo = racha;
    }
    expect(maximo, lessThanOrEqualTo(3), reason: 'demasiados temas seguidos de la misma parte');
  });

  test('reparto por ritmo y por fecha de fin, con descansos', () {
    final temas = [for (var i = 1; i <= 10; i++) '3.A.$i'];
    final inicio = DateTime(2026, 10, 7); // miércoles → semana del lunes 5
    final c = crearCronograma(id: 'c', ejercicio: 3, temas: temas, inicio: inicio, porSemana: 3);
    expect(c.inicio, DateTime(2026, 10, 5));
    expect(c.semanas.map((s) => s.temas.length), [3, 3, 3, 1]);
    // Acabar en la semana del 26 de octubre: 4 semanas → 3 por semana.
    final f = crearCronograma(id: 'f', ejercicio: 3, temas: temas, inicio: inicio, fin: DateTime(2026, 10, 30));
    expect(f.temasPorSemana, 3);
    expect(ritmoPara(10, DateTime(2026, 10, 5), DateTime(2026, 10, 30), {DateTime(2026, 10, 12)}), 4);
    final conDescanso = repartir(temas, DateTime(2026, 10, 5), 4, {DateTime(2026, 10, 12)});
    expect(conDescanso.map((s) => s.descanso), [false, true, false, false]);
    expect(finEstimado(10, DateTime(2026, 10, 5), 3, const {}), DateTime(2026, 11, 1));
  });

  test('retraso y replanificación: mantener el ritmo o la fecha de fin', () {
    final temas = [for (var i = 1; i <= 12; i++) '3.A.$i'];
    var c = crearCronograma(id: 'c', ejercicio: 3, temas: temas, inicio: DateTime(2026, 10, 5), porSemana: 3);
    // Primera semana: solo dos de tres; ahora es la segunda.
    c = c.copyWith(hechos: {'3.A.1': DateTime(2026, 10, 6), '3.A.2': DateTime(2026, 10, 7)});
    final hoy = DateTime(2026, 10, 14);
    final e1 = estadoDe(c, hoy);
    expect(e1.atrasados, ['3.A.3']);
    expect(e1.semanaActual!.temas, ['3.A.4', '3.A.5', '3.A.6']);
    expect(e1.fin, DateTime(2026, 11, 1));

    // Mismo ritmo: lo atrasado pasa delante y la fecha de fin se va una semana.
    final ritmo = replanificarCronograma(c, hoy, porSemana: 3);
    expect(ritmo.semanas.first.temas, ['3.A.1', '3.A.2']);
    expect(ritmo.semanas[1].temas, ['3.A.3', '3.A.4', '3.A.5']);
    expect(estadoDe(ritmo, hoy).atrasados, isEmpty);
    expect(estadoDe(ritmo, hoy).fin, DateTime(2026, 11, 8));

    // Misma fecha de fin (1 de noviembre): sube el ritmo.
    final mismaFecha = replanificarCronograma(c, hoy, fin: DateTime(2026, 11, 1));
    expect(mismaFecha.temasPorSemana, 4);
    expect(estadoDe(mismaFecha, hoy).fin, DateTime(2026, 11, 1));
  });

  test('una vuelta anotada en la agenda cuenta como hecho, salvo si se desmarca', () {
    final c = crearCronograma(id: 'c', ejercicio: 3, temas: ['3.A.1', '3.A.2'], inicio: DateTime(2026, 10, 5));
    final vueltas = {'3.A.1': [DateTime(2026, 10, 8)], '3.A.2': [DateTime(2026, 9, 1)]};
    expect(estadoDe(c, DateTime(2026, 10, 9), vueltas: vueltas).hechos, {'3.A.1'});
    expect(estadoDe(c.copyWith(desmarcados: {'3.A.1'}), DateTime(2026, 10, 9), vueltas: vueltas).hechos, isEmpty);
  });

  test('fusión: gana lo más reciente sin perder la propuesta del preparador', () {
    final base = crearCronograma(id: 'c', ejercicio: 3, temas: ['3.A.1'], inicio: DateTime(2026, 10, 5));
    final propuesta = PropuestaCronograma(de: 'p', nombre: 'Paula', fecha: DateTime(2026, 10, 10), temas: const ['3.A.1'], temasPorSemana: 2);
    final nube = Cronograma.fromJson({...base.toJson(), 'propuesta': propuesta.toJson(), 'updatedAt': DateTime(2026, 10, 10).toIso8601String()});
    final local = Cronograma.fromJson({...base.toJson(), 'compartir': true, 'updatedAt': DateTime(2026, 10, 11).toIso8601String()});
    final f = Cronograma.fusionar(local, nube);
    expect(f.compartir, isTrue);
    expect(f.propuesta!.nombre, 'Paula');
    // Una vez resuelta, no vuelve.
    final resuelta = Cronograma.fromJson({...local.toJson(), 'propuestaResuelta': DateTime(2026, 10, 12).toIso8601String(), 'updatedAt': DateTime(2026, 10, 12).toIso8601String()});
    expect(Cronograma.fusionar(resuelta, nube).propuesta, isNull);
    expect(Cronograma.fromJson(jsonDecode(jsonEncode(f.toJson())) as Map).propuesta!.temasPorSemana, 2);
  });

  group('día de cante', () {
    // Jueves 8 de octubre de 2026.
    final jueves = DateTime(2026, 10, 8);

    test('cada semana va del viernes al jueves del cante', () {
      expect(inicioSemana(DateTime(2026, 10, 8), 4), DateTime(2026, 10, 2)); // el jueves es el último día
      expect(inicioSemana(DateTime(2026, 10, 9), 4), DateTime(2026, 10, 9)); // el viernes empieza otra
      expect(inicioSemana(DateTime(2026, 10, 5), 4), DateTime(2026, 10, 2));
      expect(canteDeLaSemana(DateTime(2026, 10, 5), 4), jueves);
      expect(inicioSemana(DateTime(2026, 10, 7)), DateTime(2026, 10, 5)); // sin día: lunes
    });

    test('la primera semana acaba en el primer cante y las demás, en los siguientes', () {
      final c = crearCronograma(id: 'x', ejercicio: 3, temas: ['3.A.1', '3.A.2', '3.A.3', '3.A.4', '3.A.5'], inicio: jueves, porSemana: 2, diaCante: 4);
      expect(c.primerCante, jueves);
      expect([for (final s in c.semanas) s.domingo], [jueves, DateTime(2026, 10, 15), DateTime(2026, 10, 22)]);
      expect(c.semanas.first.temas, ['3.A.1', '3.A.2']);
      // El día del cante aún es su semana; al día siguiente, la siguiente.
      expect(estadoDe(c, jueves).semanaActual?.temas, ['3.A.1', '3.A.2']);
      expect(estadoDe(c, DateTime(2026, 10, 9)).semanaActual?.temas, ['3.A.3', '3.A.4']);
      expect(Cronograma.fromJson(c.toJson()).diaCante, 4);
    });

    test('con fecha de fin, cuenta los cantes hasta ella', () {
      final c = crearCronograma(id: 'x', ejercicio: 3, temas: List.generate(6, (i) => '3.A.${i + 1}'), inicio: jueves, fin: DateTime(2026, 10, 22), diaCante: 4);
      expect(c.temasPorSemana, 2); // tres cantes: 8, 15 y 22
    });
  });
}
