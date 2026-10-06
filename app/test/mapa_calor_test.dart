import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/pregunta.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/features/organizacion/dominio_tema.dart';

/// Mapa de calor del temario: qué se sabe de cada tema y cómo se puntúa.
void main() {
  final ahora = DateTime(2026, 10, 6, 12);

  test('sin datos, gris; solo estudiado, en medio', () {
    expect(valorTema(const DatosTema(), LenteMapa.dominio, ahora), isNull);
    expect(valorTema(const DatosTema(estudiado: true), LenteMapa.dominio, ahora), closeTo(0.58, 1e-9));
    expect(valorTema(const DatosTema(estudiado: true), LenteMapa.cantes, ahora), isNull);
    expect(valorTema(const DatosTema(estudiado: true), LenteMapa.repaso, ahora), isNull);
  });

  test('los cantes flojos y un repaso viejo bajan el dominio', () {
    final bien = DatosTema(estudiado: true, valoracion: 5, cantes: 3, ultimo: ahora);
    final mal = DatosTema(estudiado: true, valoracion: 2, cantes: 2, ultimo: ahora.subtract(const Duration(days: 90)));
    expect(valorTema(bien, LenteMapa.dominio, ahora), closeTo(0.925, 1e-9));
    // Peor que un tema solo estudiado, del que no se sabe más.
    expect(valorTema(mal, LenteMapa.dominio, ahora)!, lessThan(0.5));
    expect(valorTema(mal, LenteMapa.cantes, ahora), 0.25);
    expect(frescura(ahora.subtract(const Duration(days: 30)), ahora), closeTo(0.5, 1e-9));
  });

  test('junta estudiados, cantes, vueltas y test por tema', () {
    final banco = BancoPreguntas.fromJson({
      'preguntas': [
        {'id': 1, 'temas': ['1.A.1'], 'enunciado': '¿?', 'opciones': {'a': 'x', 'b': 'y'}, 'respuesta': ['a']},
        {'id': 2, 'temas': ['1.A.1'], 'enunciado': '¿?', 'opciones': {'a': 'x', 'b': 'y'}, 'respuesta': ['b']},
        {'id': 3, 'temas': ['1.A.1'], 'enunciado': '¿?', 'opciones': {'a': 'x', 'b': 'y'}, 'respuesta': ['a']},
      ],
    });
    final test = ResultadoTest(
      id: 'r', timestamp: ahora, puntosBrutos: 0, maxPuntos: 3, notaSobre10: 6.7, correctas: 2, incorrectas: 1, sinResponder: 0, totalPreguntas: 3, tiempoSeconds: 60, temas: const ['1.A.1'],
      respuestas: const {1: 'a', 2: 'b', 3: 'b'},
    );
    final cantes = EstadisticaTema.desde([
      Cante(id: 'c', fecha: ahora.subtract(const Duration(days: 10)), estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1', valoracion: 4)),
    ]);
    final d = datosPorTema(
      codigos: ['1.A.1', '3.A.1', '3.A.2'],
      estudiados: {'3.A.1'},
      cantes: cantes,
      vueltas: {'3.A.1': [ahora.subtract(const Duration(days: 2))]},
      tests: [test],
      banco: banco,
    );
    expect(d['1.A.1']!.respuestas, 3);
    expect(d['1.A.1']!.aciertos, 2);
    expect(valorTema(d['1.A.1']!, LenteMapa.test, ahora), closeTo(2 / 3, 1e-9));
    expect(d['3.A.1']!.cantes, 1);
    expect(d['3.A.1']!.ultimo, ahora.subtract(const Duration(days: 2))); // la vuelta, más reciente que el cante
    expect(valorTema(d['3.A.2']!, LenteMapa.dominio, ahora), isNull);
  });
}
