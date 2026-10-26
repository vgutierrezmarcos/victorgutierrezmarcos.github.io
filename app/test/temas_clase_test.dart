import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/temas_clase.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

/// Los temas de cada clase: los mismos para el opositor y su preparador.
void main() {
  final cronograma = Cronograma(
    id: 'c',
    ejercicio: 3,
    temas: const ['3.A.8', '3.A.9', '3.B.1', '3.B.2'],
    inicio: DateTime(2026, 10, 16),
    diaCante: 4, // jueves
    semanas: [
      SemanaPlan(lunes: DateTime(2026, 10, 16), temas: const ['3.A.8', '3.A.9']),
      SemanaPlan(lunes: DateTime(2026, 10, 23), temas: const ['3.B.1', '3.B.2']),
    ],
  );
  final clase = Cante(id: 'k1', fecha: DateTime(2026, 10, 29, 17), preparador: 'p');

  test('se guardan en los ajustes como lista y vuelven igual', () {
    final a = Ajustes(temasClases: {'k1': TemasClase(temas: const ['3.A.1', '3.A.2'], fecha: DateTime(2026, 10, 23, 9))});
    final j = a.toJson();
    expect(j['temasClases'], ['k1@2026-10-23T09:00:00.000@3.A.1,3.A.2']);
    final b = Ajustes.fromJson(j);
    expect(b.temasClases['k1']!.temas, ['3.A.1', '3.A.2']);
    expect(TemasClase.deLista(['mal', 'x@ayer@3.A.1']), isEmpty);
  });

  test('sin elegir: la semana del cronograma de ese día, sin los que pide no cantar', () {
    final r = temasDeLaClase(clase, elegidos: const {}, cronograma: cronograma, noCantar: {'3.B.2': DateTime(2026, 10, 20)});
    expect(r.origen, OrigenTemas.cronograma);
    expect(r.temas, ['3.B.1']);
  });

  test('lo que elige el opositor manda sobre el cronograma', () {
    final r = temasDeLaClase(clase, elegidos: {'k1': TemasClase(temas: const ['3.A.40'], fecha: DateTime(2026, 10, 24))}, cronograma: cronograma);
    expect(r.origen, OrigenTemas.opositor);
    expect(r.temas, ['3.A.40']);
  });

  test('sin cronograma para ese día ni temas elegidos: pendiente y vacía, nunca los estudiados', () {
    final fuera = Cante(id: 'k2', fecha: DateTime(2026, 12, 3, 17), preparador: 'p');
    expect(temasDeLaClase(fuera, elegidos: const {}, cronograma: cronograma).pendiente, isTrue);
    expect(temasDeLaClase(fuera, elegidos: const {}).temas, isEmpty);
  });

  test('la propuesta del preparador está pendiente hasta que el opositor responde después', () {
    final propuesta = clase.copyWith(temasPropuestos: const ['3.A.1'], propuestaTemasA: DateTime(2026, 10, 25));
    expect(propuestaPendiente(propuesta, const {}), isTrue);
    expect(propuestaPendiente(propuesta, {'k1': TemasClase(temas: const ['3.B.1'], fecha: DateTime(2026, 10, 24))}), isTrue);
    expect(propuestaPendiente(propuesta, {'k1': TemasClase(temas: const ['3.B.1'], fecha: DateTime(2026, 10, 26))}), isFalse);
    expect(propuestaPendiente(clase, const {}), isFalse);
    final j = Cante.fromJson(propuesta.toJson());
    expect(j.temasPropuestos, ['3.A.1']);
    expect(j.copyWith(sinPropuesta: true).temasPropuestos, isEmpty);
  });

  group('clasesParaFijar (1.20.4): las clases cuyos temas salen del cronograma se fijan solas', () {
    final ahora = DateTime(2026, 10, 26, 10);
    test('la clase de la semana del cronograma, sin temas fijados: se fija', () {
      final r = clasesParaFijar([clase], elegidos: const {}, cronograma: cronograma, noCantar: {'3.B.2': DateTime(2026, 10, 20)}, ahora: ahora);
      expect(r, {'k1': ['3.B.1']});
    });
    test('no se toca lo ya fijado, lo pendiente de una propuesta, lo pasado, lo lejano, lo hecho ni los cantes propios', () {
      expect(clasesParaFijar([clase], elegidos: {'k1': TemasClase(temas: const ['3.A.40'], fecha: DateTime(2026, 10, 24))}, cronograma: cronograma, ahora: ahora), isEmpty);
      expect(clasesParaFijar([clase.copyWith(temasPropuestos: const ['3.A.1'], propuestaTemasA: DateTime(2026, 10, 25))], elegidos: const {}, cronograma: cronograma, ahora: ahora), isEmpty);
      expect(clasesParaFijar([clase], elegidos: const {}, cronograma: cronograma, ahora: DateTime(2026, 11, 2)), isEmpty);
      expect(clasesParaFijar([clase], elegidos: const {}, cronograma: cronograma, ahora: DateTime(2026, 9, 1)), isEmpty);
      expect(clasesParaFijar([clase.copyWith(estado: EstadoCante.hecho)], elegidos: const {}, cronograma: cronograma, ahora: ahora), isEmpty);
      expect(clasesParaFijar([Cante(id: 'propio', fecha: DateTime(2026, 10, 29, 17))], elegidos: const {}, cronograma: cronograma, ahora: ahora), isEmpty);
      expect(clasesParaFijar([clase], elegidos: const {}, cronograma: null, ahora: ahora), isEmpty);
    });
    test('fuera del cronograma queda pendiente: no hay nada que fijar', () {
      final fuera = Cante(id: 'k2', fecha: DateTime(2026, 11, 5, 17), preparador: 'p');
      expect(clasesParaFijar([fuera], elegidos: const {}, cronograma: cronograma, ahora: ahora), isEmpty);
    });
  });
}
