import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/dificultad.dart';

void main() {
  final d = Dificultad.fromJson({
    'minimo': 5,
    'tests': 40,
    'preguntas': {
      '1': {'v': 10, 'a': 3, 'f': 5, 'b': 2},
      '2': {'v': 6, 'a': 6, 'f': 0, 'b': 0},
      '3': {'v': 4, 'a': 0, 'f': 4, 'b': 0},
      '4': {'v': 5, 'a': 0, 'f': 5, 'b': 0},
    },
  });

  test('solo enseña cifras con vistas suficientes', () {
    expect(d.texto(1), 'La fallan o dejan en blanco 7 de cada 10 que la han hecho');
    expect(d.texto(2), 'Casi todos la aciertan');
    expect(d.texto(3), isNull);
    expect(d.texto(4), 'Casi nadie la acierta');
    expect(d.texto(99), isNull);
  });

  test('las más falladas, de más a menos, sin las que nadie falla', () {
    expect(d.masFalladas().map((e) => e.id), [4, 1]);
    expect(d.masFalladas(ids: [1, 2, 3]).map((e) => e.id), [1]);
  });

  test('pesos: más a las más falladas, poco a las que no tienen dato', () {
    final p = d.pesos([1, 2, 3, 4]);
    expect(p[4]!, greaterThan(p[1]!));
    expect(p[1]!, greaterThan(p[3]!));
    expect(p[3], 0.05);
  });
}
