import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/pregunta.dart';
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
}
