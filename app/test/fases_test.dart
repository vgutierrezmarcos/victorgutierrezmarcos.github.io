import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/fases.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/cronograma/fases.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';

/// Cronograma por fases del 1.º de DCE (escrito): reparto 55/30/15 hasta el
/// examen, aviso si no da tiempo, fases saltadas o con otras fechas, temas
/// flojos (mal o regular, sin escribir, descartados) y tope por semana.
/// También la organización del temario de DCE (estructura_temario.json).
void main() {
  const cfg = FasesEscrito();
  final lunes = DateTime(2026, 11, 2); // lunes

  Cante escrito(DateTime fecha, Map<String, NotaEscrito> notas, {List<String> descartados = const []}) => Cante(
        id: '${fecha.toIso8601String()}${notas.keys.join()}',
        fecha: fecha,
        ejercicio: 1,
        estado: EstadoCante.hecho,
        resultado: ResultadoCante(
          temaCantado: notas.keys.first,
          otrosCantados: notas.keys.skip(1).toList(),
          valoraciones: notas.map((k, v) => MapEntry(k, v.valor)),
          descartados: descartados,
        ),
      );

  group('reparto de fases', () {
    test('20 semanas: 11 de primera vuelta, 6 de simulacros y 3 de revisión, en orden', () {
      final r = repartoFases(desde: lunes, examen: lunes.add(const Duration(days: 140)), cfg: cfg, temas: 36);
      expect(r.semanas, 20);
      expect([for (final f in r.fases) f.semanas], [11, 6, 3]);
      expect(r.fases.map((f) => f.tipo), TipoFase.values);
      expect(r.fases[0].inicio, lunes);
      expect(r.fases[1].inicio, r.fases[0].fin.add(const Duration(days: 1)));
      expect(r.fases[2].inicio, r.fases[1].fin.add(const Duration(days: 1)));
      // La revisión acaba la víspera del examen.
      expect(r.fases[2].fin, DateTime(2026, 11, 2 + 139));
      expect(r.ritmo, 4);
      expect(r.aviso, isNull);
    });

    test('poco tiempo: avisa en vez de comprimir sin decir nada', () {
      final r = repartoFases(desde: lunes, examen: lunes.add(const Duration(days: 28)), cfg: cfg, temas: 36);
      expect(r.semanas, 4);
      expect(r.fases.every((f) => !f.saltada), isTrue, reason: 'cada fase, al menos una semana');
      expect(r.ritmo, greaterThan(cfg.maxTemasSemana));
      expect(r.aviso, contains('No da tiempo'));
    });

    test('examen ya pasado: sin semanas y con aviso', () {
      final r = repartoFases(desde: lunes, examen: lunes, cfg: cfg, temas: 36);
      expect(r.semanas, 0);
      expect(r.aviso, isNotNull);
    });

    test('saltarse los simulacros reparte sus semanas entre las otras dos', () {
      final r = repartoFases(desde: lunes, examen: lunes.add(const Duration(days: 140)), cfg: cfg, temas: 36, saltadas: {TipoFase.simulacros});
      expect(r.fase(TipoFase.simulacros), isNull);
      expect(r.fases[1].saltada, isTrue);
      expect(r.fases[0].semanas + r.fases[2].semanas, 20);
      expect(r.fases[0].semanas, 16); // 20 · 0,55 / 0,70
      expect(r.fases[2].inicio, r.fases[0].fin.add(const Duration(days: 1)));
    });

    test('saltarse la primera vuelta: sin ritmo ni aviso', () {
      final r = repartoFases(desde: lunes, examen: lunes.add(const Duration(days: 70)), cfg: cfg, temas: 36, saltadas: {TipoFase.vuelta});
      expect(r.ritmo, 0);
      expect(r.aviso, isNull);
      expect(r.fase(TipoFase.simulacros)!.inicio, lunes);
    });

    test('las fechas se pueden cambiar, sin solaparse', () {
      final examen = lunes.add(const Duration(days: 140));
      final r = repartoFases(desde: lunes, examen: examen, cfg: cfg, temas: 36, inicios: {TipoFase.simulacros: lunes.add(const Duration(days: 7 * 8 + 3))});
      expect(r.fases[0].semanas, 8);
      expect(r.fases[1].inicio, lunes.add(const Duration(days: 56)));
      // Una revisión pedida antes que los simulacros se queda después.
      final s = repartoFases(desde: lunes, examen: examen, cfg: cfg, temas: 36, inicios: {TipoFase.simulacros: lunes.add(const Duration(days: 70)), TipoFase.revision: lunes.add(const Duration(days: 14))});
      expect(s.fases[2].inicio.isAfter(s.fases[1].inicio), isTrue);
    });

    test('cronograma por fases: primera vuelta A y luego B, hasta el final de la fase', () {
      final temas = ordenPorPartes(['1.B.2', '1.A.10', '1.A.2', '1.B.1', '1.A.1']);
      expect(temas, ['1.A.1', '1.A.2', '1.A.10', '1.B.1', '1.B.2']);
      final r = repartoFases(desde: lunes, examen: lunes.add(const Duration(days: 140)), cfg: cfg, temas: 36);
      final todos = ordenPorPartes([for (final p in 'AB'.split('')) for (var i = 1; i <= 18; i++) '1.$p.$i']);
      final c = crearCronograma(id: 'x', ejercicio: 1, temas: todos, inicio: lunes, fin: r.fase(TipoFase.vuelta)!.fin, fases: r.fases, examen: lunes.add(const Duration(days: 140)));
      expect(c.temasPorSemana, 4);
      expect(c.semanas.length, 9);
      expect(c.semanas.last.domingo.isAfter(r.fase(TipoFase.vuelta)!.fin), isFalse);
      expect(c.faseEn(lunes.add(const Duration(days: 80)))!.tipo, TipoFase.simulacros);
      // Ida y vuelta por JSON.
      final otra = Cronograma.fromJson(jsonDecode(jsonEncode(c.toJson())) as Map);
      expect(otra.fases.map((f) => f.toJson()), c.fases.map((f) => f.toJson()));
      expect(otra.examen, c.examen);
      expect(Cronograma.fromJson(jsonDecode(jsonEncode(crearCronograma(id: 'y', ejercicio: 3, temas: ['3.A.1'], inicio: lunes).toJson())) as Map).porFases, isFalse);
    });
  });

  group('temas flojos', () {
    final hoy = DateTime(2027, 3, 1);
    DateTime hace(int dias) => hoy.subtract(Duration(days: dias));

    test('mal o regular la última vez; sale tras dos veces seguidas bien y vuelve a entrar', () {
      var cantes = [escrito(hace(20), {'1.A.1': NotaEscrito.mal}), escrito(hace(10), {'1.A.2': NotaEscrito.regular}), escrito(hace(5), {'1.A.3': NotaEscrito.bien})];
      var f = temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg);
      expect(f.map((x) => x.codigo), ['1.A.1', '1.A.2']);
      expect(f.first.razones, [RazonFlojo.mal]);
      expect(f.first.explicacion, 'salió mal');

      cantes = [...cantes, escrito(hace(4), {'1.A.1': NotaEscrito.bien})];
      expect(temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg).map((x) => x.codigo), contains('1.A.1'), reason: 'una sola vez bien puede ser suerte');
      cantes = [...cantes, escrito(hace(3), {'1.A.1': NotaEscrito.bien})];
      expect(temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg).map((x) => x.codigo), isNot(contains('1.A.1')));
      cantes = [...cantes, escrito(hace(1), {'1.A.1': NotaEscrito.regular})];
      expect(temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg).map((x) => x.codigo), contains('1.A.1'));
    });

    test('más de seis semanas sin escribir (o sin escribirlo desde que se estudió)', () {
      final cantes = [escrito(hace(50), {'1.B.1': NotaEscrito.bien}), escrito(hace(30), {'1.B.2': NotaEscrito.bien})];
      final f = temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg, estudiados: {'1.B.3': hace(60), '1.B.4': hace(10)});
      expect(f.map((x) => x.codigo).toSet(), {'1.B.1', '1.B.3'});
      expect(f.firstWhere((x) => x.codigo == '1.B.1').explicacion, '7 semanas sin escribir');
    });

    test('descartado casi siempre en los simulacros, aunque nunca salga mal', () {
      final cantes = [
        escrito(hace(9), {'1.A.5': NotaEscrito.bien, '1.B.5': NotaEscrito.bien}, descartados: ['1.A.9', '1.B.9']),
        escrito(hace(6), {'1.A.6': NotaEscrito.bien, '1.B.9': NotaEscrito.bien}, descartados: ['1.A.9', '1.B.6']),
        escrito(hace(3), {'1.A.9': NotaEscrito.bien, '1.B.7': NotaEscrito.bien}, descartados: ['1.A.7', '1.B.9']),
        escrito(hace(2), {'1.A.8': NotaEscrito.bien, '1.B.8': NotaEscrito.bien}, descartados: ['1.A.9', '1.B.1']),
      ];
      final f = temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg);
      // 1.A.9: 3 de 4. 1.B.9: 2 de 3 (justo el umbral).
      expect(f.map((x) => x.codigo).toSet(), {'1.A.9', '1.B.9'});
      expect(f.firstWhere((x) => x.codigo == '1.A.9').explicacion, 'descartado 3 de 4');
      // Otros ejercicios no cuentan.
      expect(temasFlojos(cantes: cantes, ejercicio: 4, hoy: hoy, cfg: cfg), isEmpty);
    });

    test('orden: peor valorados primero; a igualdad, los que hace más que no se escriben', () {
      final cantes = [
        escrito(hace(5), {'1.A.1': NotaEscrito.regular}),
        escrito(hace(9), {'1.A.2': NotaEscrito.regular}),
        escrito(hace(2), {'1.A.3': NotaEscrito.mal}),
      ];
      expect(temasFlojos(cantes: cantes, ejercicio: 1, hoy: hoy, cfg: cfg).map((x) => x.codigo), ['1.A.3', '1.A.2', '1.A.1']);
    });

    test('tope por semana: como mucho 3 y nunca más de un tercio de la semana', () {
      expect(topeFlojos(4, cfg), 2); // 2 de 6
      expect(topeFlojos(6, cfg), 3); // 3 de 9
      expect(topeFlojos(20, cfg), 3);
      expect(topeFlojos(1, cfg), 0);
      final muchos = [for (var i = 1; i <= 6; i++) TemaFlojo(codigo: '1.A.$i', razones: const [RazonFlojo.mal])];
      expect(flojosDeSemana(muchos, cfg).length, 2);
      expect(flojosDeSemana(muchos, cfg.conCambios({'simulacrosPorSemana': 3})).length, 3);
    });

    test('notas: bien, regular y mal se guardan como 5, 3 y 1', () {
      expect([for (final n in NotaEscrito.values) NotaEscrito.de(n.valor)], NotaEscrito.values);
      expect(NotaEscrito.de(0), isNull);
      expect(NotaEscrito.de(4), NotaEscrito.bien);
      final r = ResultadoCante.fromJson(jsonDecode(jsonEncode(const ResultadoCante(temaCantado: '1.A.1', descartados: ['1.A.2']).toJson())) as Map);
      expect(r.descartados, ['1.A.2']);
      expect(ResultadoCante.fromJson(const {}).descartados, isEmpty);
    });

    test('app-config.json cambia los umbrales', () {
      final c = cfg.conCambios({'diasSinEscribir': 28, 'reparto': {'vuelta': 0.6, 'simulacros': 0.3, 'revision': 0.1}});
      expect(c.diasSinEscribir, 28);
      expect(c.reparto[TipoFase.vuelta], 0.6);
      expect(c.maxFlojosSemana, 3);
    });
  });

  group('organización del temario de DCE', () {
    late EstructuraTemario e;
    late Temario temario;
    setUpAll(() {
      e = EstructuraTemario.fromJson(jsonDecode(File('para-manuel/oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
      temario = Temario.fromJson(jsonDecode(File('para-manuel/oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    });

    test('cada tema del 1.º y del 3.º tiene bloque y color', () {
      for (final t in temario.todosLosTemas.where((t) => t.ejercicio == 1 || t.ejercicio == 3)) {
        expect(e.bloqueDe(t.codigo), isNotNull, reason: t.codigo);
      }
      expect(e.categorias(1), ['Economía española', 'Economía pública', 'Políticas comunitarias', 'Instituciones multilaterales']);
      expect(e.categorias(3), ['Microeconomía', 'Macroeconomía', 'Economía internacional', 'Mixto']);
      expect(e.esquemas.map((x) => x.id), ['primero', 'tercero']);
    });

    test('las conexiones de las fichas sin dibujar también cuentan', () {
      // 3.A.11 conecta con 3.A.5 en su ficha, pero no hay línea en el esquema.
      expect(e.relacionados('3.A.11').where((r) => r.esTema).map((r) => r.tema), contains('3.A.5'));
      expect(e.relacionados('3.A.5').where((r) => r.esTema).map((r) => r.tema), contains('3.A.11'));
      expect(e.esquemas.firstWhere((x) => x.id == 'tercero').conexiones.any((c) => {c.de.tema, c.a.tema}.containsAll(['3.A.11', '3.A.5'])), isFalse);
    });

    test('una vuelta suelta al 1.º, como en TCEE: por bloques, con las partes intercaladas y sin fases', () {
      final todos = temario.todosLosTemas.where((t) => t.ejercicio == 1).map((t) => t.codigo).toSet();
      final orden = ordenInicial(e, 1, todos);
      expect(orden.toSet(), todos);
      // Intercaladas: la parte B no espera a que acabe la A.
      expect(orden.take(18).any((t) => t.startsWith('1.B.')), isTrue);
      final c = crearCronograma(id: 'v', ejercicio: 1, temas: orden, inicio: lunes, porSemana: 3);
      expect(c.porFases, isFalse);
      expect(c.semanas.length, 12);
    });

    test('el orden sugerido del 3.º recorre los bloques de la presentación', () {
      final todos = temario.todosLosTemas.where((t) => t.ejercicio == 3).map((t) => t.codigo).toSet();
      final orden = ordenSugerido(e, 3, todos);
      expect(orden.toSet(), todos);
      final tramos = <String>[];
      for (final t in orden) {
        final b = e.bloqueDe(t)!.id;
        if (tramos.isEmpty || tramos.last != b) tramos.add(b);
      }
      expect(tramos.length, tramos.toSet().length);
    });
  });
}
