import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/plan/cantes_util.dart';

/// Lo que el opositor pide no cantar, lo que lleva según su cronograma y el
/// día de clase que se propone al preparador.
void main() {
  test('los temas que pide no cantar van y vuelven por JSON, con su fecha', () {
    final a = Ajustes(temasEstudiados: const {'3.A.1'}, noCantar: {'3.A.4': DateTime(2026, 10, 20, 9, 30)});
    final j = a.toJson();
    // Lista y no mapa: con merge en la nube, un mapa no borraría lo que se quita.
    expect(j['noCantar'], ['3.A.4@2026-10-20T09:30:00.000']);
    expect(Ajustes.fromJson(j).noCantar, {'3.A.4': DateTime(2026, 10, 20, 9, 30)});
    expect(Ajustes.noCantarDe(j), {'3.A.4': DateTime(2026, 10, 20, 9, 30)});
    expect(Ajustes.noCantarDe(const {'noCantar': {'3.B.1': '2026-10-19T10:00:00.000'}}), {'3.B.1': DateTime(2026, 10, 19, 10)});
    expect(Ajustes.noCantarDe(const {'noCantar': 'nada'}), isEmpty);
    expect(Ajustes.noCantarDe(const {'noCantar': ['sin fecha', '3.A.1@ayer']}), isEmpty);
    expect(Ajustes.noCantarDe(null), isEmpty);
    expect(const Ajustes().toJson()['noCantar'], isEmpty);
  });

  test('temas que lleva según el cronograma: hechos y semanas empezadas, sin los desmarcados', () {
    final c = Cronograma(
      id: 'c',
      ejercicio: 3,
      temas: const ['3.A.1', '3.A.2', '3.A.3', '3.A.4', '3.A.5'],
      inicio: DateTime(2026, 10, 5),
      diaCante: 3, // miércoles
      semanas: [
        SemanaPlan(lunes: DateTime(2026, 10, 5), temas: const ['3.A.1', '3.A.2']),
        SemanaPlan(lunes: DateTime(2026, 10, 12), temas: const ['3.A.3']),
        SemanaPlan(lunes: DateTime(2026, 10, 19), temas: const ['3.A.4']),
        SemanaPlan(lunes: DateTime(2026, 10, 26), temas: const ['3.A.5']),
      ],
      hechos: {'3.A.5': DateTime(2026, 10, 18)},
      desmarcados: const {'3.A.2'},
    );
    // El 21 de octubre va por la semana del 19: entra lo de esa semana (es lo
    // que canta en la clase de esa semana), lo hecho por adelantado y no lo
    // que desmarcó ni la semana que viene.
    expect(c.temasLlevados(DateTime(2026, 10, 21, 18)), {'3.A.1', '3.A.3', '3.A.4', '3.A.5'});
    expect(c.temasLlevados(DateTime(2026, 10, 18)), {'3.A.1', '3.A.3', '3.A.5'});
    expect(c.temasLlevados(DateTime(2026, 10, 4)), {'3.A.5'});
  });

  test('en una clase del preparador, el alumno ve la misma bolsa que él: estudiados más cronograma, sin los que pide no cantar', () {
    final cronograma = Cronograma(
      id: 'c',
      ejercicio: 3,
      temas: const ['3.A.1', '3.A.2', '3.A.3'],
      inicio: DateTime(2020, 1, 6),
      diaCante: 3,
      semanas: [SemanaPlan(lunes: DateTime(2020, 1, 6), temas: const ['3.A.1', '3.A.2']), SemanaPlan(lunes: DateTime(2099, 1, 4), temas: const ['3.A.3'])],
      hechos: const {},
    );
    final ajustes = Ajustes(temasEstudiados: const {'3.A.5', '3.A.2'}, noCantar: {'3.A.2': DateTime(2026, 10, 21)});
    expect(temasQueLleva(ajustes, cronograma), {'3.A.1', '3.A.5'});
    expect(temasQueLleva(ajustes, null), {'3.A.5'});
  });

  test('el próximo día de la semana para la clase, nunca el mismo día', () {
    final miercoles = DateTime(2026, 10, 21, 11);
    expect(proximoDiaDeSemana(miercoles, 3), DateTime(2026, 10, 28, 17));
    expect(proximoDiaDeSemana(miercoles, 4), DateTime(2026, 10, 22, 17));
    expect(proximoDiaDeSemana(miercoles, 1, hora: 18, minuto: 30), DateTime(2026, 10, 26, 18, 30));
    expect(proximoDiaDeSemana(miercoles, 7), DateTime(2026, 10, 25, 17));
  });
}
