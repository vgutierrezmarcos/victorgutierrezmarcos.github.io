import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/test/leitner.dart';

void main() {
  test('solo se añaden las falladas; aciertos suben de caja, fallos vuelven a 1', () {
    final e = EstadoLeitner();
    e.registrarExamen({1: true, 2: false, 3: false});
    expect(e.questions.keys, [2, 3]);
    expect(e.sessionCount, 1);
    expect(e.questions[2]!.box, 1);
    expect(e.questions[2]!.timesFailed, 1);

    e.registrarExamen({2: true, 3: false});
    expect(e.questions[2]!.box, 2);
    expect(e.questions[2]!.timesCorrect, 1);
    expect(e.questions[3]!.box, 1);
    expect(e.questions[3]!.timesFailed, 2);
  });

  test('pendientes según intervalos 1/2/4/8 y dominadas en caja 5', () {
    final e = EstadoLeitner(sessionCount: 10, questions: {
      1: EntradaLeitner(box: 1, lastSession: 10), // intervalo 1 → no (0 sesiones)
      2: EntradaLeitner(box: 2, lastSession: 8), // intervalo 2 → sí
      3: EntradaLeitner(box: 3, lastSession: 7), // intervalo 4 → no (3)
      4: EntradaLeitner(box: 4, lastSession: 2), // intervalo 8 → sí
      5: EntradaLeitner(box: 5, lastSession: 0), // dominada
    });
    expect(e.pendientes(), [2, 4]);
    expect(e.porCaja, {1: 1, 2: 1, 3: 1, 4: 1, 5: 1});
  });

  test('json ida y vuelta compatible con la web', () {
    final e = EstadoLeitner(sessionCount: 3, questions: {7: EntradaLeitner(box: 2, lastSession: 1, timesCorrect: 1, timesFailed: 1)});
    final j = e.toJson();
    expect(j['questions'], {'7': {'box': 2, 'lastSession': 1, 'timesCorrect': 1, 'timesFailed': 1}});
    final back = EstadoLeitner.fromJson(j);
    expect(back.sessionCount, 3);
    expect(back.questions[7]!.box, 2);
  });

  test('fusionar conserva la entrada con más intentos y el mayor sessionCount', () {
    final a = EstadoLeitner(sessionCount: 5, questions: {1: EntradaLeitner(box: 3, lastSession: 4, timesCorrect: 2)});
    final b = EstadoLeitner(sessionCount: 2, questions: {1: EntradaLeitner(box: 1, lastSession: 1, timesFailed: 1), 2: EntradaLeitner(box: 1, lastSession: 1)});
    final f = EstadoLeitner.fusionar(a, b);
    expect(f.sessionCount, 5);
    expect(f.questions[1]!.box, 3);
    expect(f.questions.containsKey(2), isTrue);
  });
}
