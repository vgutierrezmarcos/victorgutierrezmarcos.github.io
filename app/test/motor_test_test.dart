import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/features/test/motor_test.dart';

Pregunta p(int id, {String tema = '3.A.1', List<String> resp = const ['a'], String? tipo, bool oficial = true, String examen = 'E1'}) =>
    Pregunta(id: id, examen: examen, numero: id, temas: [tema], enunciado: 'P$id',
        opciones: const {'a': 'A', 'b': 'B', 'c': 'C', 'd': 'D'}, respuesta: resp, oficial: oficial, tipoPregunta: tipo);

void main() {
  final banco = BancoPreguntas(
    preguntas: [p(1), p(2, tema: '3.B.5', examen: 'E2'), p(3, resp: ['b', 'c']), p(4, tipo: 'aceptada'), p(5, oficial: false)],
    examenes: const [],
    temas: const {},
  );

  group('corrección', () {
    test('nota con penalización -0,33 como en la web', () {
      final preguntas = [p(1), p(2), p(3, resp: ['b', 'c']), p(4, tipo: 'aceptada')];
      final r = MotorTest.corregir(
        preguntas: preguntas,
        respuestas: {1: 'a', 2: 'b', 3: 'c', 4: null},
        config: const ConfigTest(),
        tiempoSeconds: 60,
      );
      // 1 correcta (1), 2 fallo, 3 correcta (respuesta múltiple), 4 en blanco pero anulada → blanco
      expect(r.correctas, 2);
      expect(r.incorrectas, 1);
      expect(r.sinResponder, 1);
      expect(r.puntosBrutos, closeTo(2 - 0.33, 1e-9));
      expect(r.maxPuntos, 4);
      expect(r.notaSobre10, closeTo((1.67 / 4) * 10, 1e-9));
    });

    test('pregunta anulada respondida cuenta como acierto', () {
      final r = MotorTest.corregir(preguntas: [p(4, tipo: 'aceptada')], respuestas: {4: 'd'}, config: const ConfigTest(), tiempoSeconds: 0);
      expect(r.correctas, 1);
      expect(r.notaSobre10, 10);
    });
  });

  group('filtros', () {
    test('solo oficiales por defecto', () {
      expect(MotorTest.filtrar(banco, const ConfigTest()).map((e) => e.id), [1, 2, 3, 4]);
    });
    test('por tema y examen', () {
      expect(MotorTest.filtrar(banco, const ConfigTest(temas: {'3.B.5'})).map((e) => e.id), [2]);
      expect(MotorTest.filtrar(banco, const ConfigTest(examenes: {'E1'})).length, 3);
    });
    test('componer respeta numPreguntas e ids fijos', () {
      expect(MotorTest.componer(banco, const ConfigTest(numPreguntas: 2), random: Random(1)).length, 2);
      expect(MotorTest.componer(banco, const ConfigTest(idsFijos: [3, 1])).map((e) => e.id), [3, 1]);
    });
  });

  test('test diario es determinista por fecha', () {
    final a = MotorTest.testDiario(banco, DateTime(2026, 9, 8), n: 3).map((e) => e.id).toList();
    final b = MotorTest.testDiario(banco, DateTime(2026, 9, 8), n: 3).map((e) => e.id).toList();
    expect(a, b);
    expect(a.contains(4), isFalse, reason: 'las anuladas se excluyen');
    expect(a.contains(5), isFalse, reason: 'las no oficiales se excluyen');
  });

  test('por bloque agrupa según bloques.json', () {
    const bloques = Bloques(bloques: [], temaABloque: {'3.A.1': 'Pensamiento económico', '3.B.5': 'Comercio Internacional'});
    final m = MotorTest.porBloque([p(1), p(2, tema: '3.B.5'), p(3)], {1: 'a', 2: 'b', 3: 'a'}, bloques);
    expect(m['Pensamiento económico'], (aciertos: 2, total: 2));
    expect(m['Comercio Internacional'], (aciertos: 0, total: 1));
  });

  group('a partir de tus respuestas', () {
    ResultadoTest r(Map<int, String?> resp) => ResultadoTest(id: 'r', timestamp: DateTime(2026, 1, 1), puntosBrutos: 0, maxPuntos: 0, notaSobre10: 0, correctas: 0, incorrectas: 0, sinResponder: 0, totalPreguntas: resp.length, tiempoSeconds: 0, temas: const [], respuestas: resp);

    test('acierto por tema cuenta una pregunta para todos sus temas', () {
      final b = BancoPreguntas(preguntas: [p(1), p(2, tema: '3.B.5'), Pregunta(id: 3, examen: 'E1', numero: 3, temas: const ['3.A.1', '3.B.5'], enunciado: 'P3', opciones: const {'a': 'A', 'b': 'B'}, respuesta: const ['a'], oficial: true)], examenes: const [], temas: const {});
      final a = MotorTest.aciertoPorTema([r({1: 'a', 2: 'b', 3: 'a'}), r({1: 'b', 2: null})], b);
      expect(a['3.A.1'], (ok: 2, total: 3));
      expect(a['3.B.5'], (ok: 1, total: 3)); // 2 fallada, 3 acertada, 2 en blanco
    });

    test('las más falladas: en blanco no es fallo; a igual número, peor proporción primero', () {
      final f = MotorTest.masFalladas([r({1: 'b', 2: 'b', 3: null}), r({1: 'a', 2: 'b'}), r({2: 'a'})], banco);
      expect(f.map((e) => e.id).toList(), [2, 1]);
      expect(f.first, (id: 2, fallos: 2, intentos: 3));
      expect(f.last, (id: 1, fallos: 1, intentos: 2));
    });

    test('puntos flojos: pesan más los temas que peor se llevan, los que más caen y las ya falladas', () {
      final pesos = MotorTest.pesosPuntosFlojos(
        [p(1), p(2, tema: '3.B.5'), p(3, tema: '3.A.9')],
        aciertoPorTema: {'3.A.1': (ok: 9, total: 10), '3.B.5': (ok: 2, total: 10)},
        frecuencias: {'3.A.1': 0.02, '3.B.5': 0.02, '3.A.9': 0.06},
        falladas: {2},
      );
      expect(pesos[2]!, greaterThan(pesos[1]!)); // peor acierto y ya fallada
      expect(pesos[3]!, greaterThan(pesos[1]!)); // sin historial (acierto medio) pero cae el triple
      // Con menos de 3 respuestas el tema cuenta como acierto medio.
      final sinDatos = MotorTest.pesosPuntosFlojos([p(1)], aciertoPorTema: {'3.A.1': (ok: 0, total: 2)});
      expect(sinDatos[1], closeTo(0.15 + 0.5, 1e-9));
    });

    test('componer ponderado respeta numPreguntas y favorece las de más peso', () {
      final b = BancoPreguntas(preguntas: [for (var i = 1; i <= 20; i++) p(i)], examenes: const [], temas: const {});
      final pesos = {for (var i = 1; i <= 20; i++) i: i <= 2 ? 50.0 : 1.0};
      var veces = 0;
      for (var s = 0; s < 50; s++) {
        final t = MotorTest.componer(b, ConfigTest(numPreguntas: 5, pesos: pesos), random: Random(s));
        expect(t.length, 5);
        expect(t.map((e) => e.id).toSet().length, 5, reason: 'sin repetidas');
        if (t.any((e) => e.id == 1)) veces++;
      }
      expect(veces, greaterThan(40));
    });

    test('corregir guarda las marcadas del test y el test en curso va y vuelve', () {
      final r = MotorTest.corregir(preguntas: [p(1), p(2)], respuestas: {1: 'a', 2: null}, config: const ConfigTest(), tiempoSeconds: 5, marcadas: [2, 99]);
      expect(r.marcadas, [2]);
      final t = TestEnCurso(config: const ConfigTest(temas: {'3.A.1'}, minutos: 0, modoEstudio: true), ids: const [3, 1], respuestas: const {3: 'b', 1: null}, marcadas: const [1], indice: 1, segundos: 42, guardado: DateTime(2026, 10, 28));
      final v = TestEnCurso.fromJson(t.toJson());
      expect(v.ids, [3, 1]);
      expect(v.respuestas, {3: 'b', 1: null});
      expect(v.respondidas, 1);
      expect(v.marcadas, [1]);
      expect(v.indice, 1);
      expect(v.segundos, 42);
      expect(v.config.modoEstudio, isTrue);
      expect(v.config.temas, {'3.A.1'});
      expect(v.config.minutos, 0);
    });
  });
}
