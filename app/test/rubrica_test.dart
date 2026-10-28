import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';

/// Rúbrica de valoración (criterios) y tiempo del cante en minutos:segundos.
void main() {
  test('los criterios van y vuelven del JSON y se describen', () {
    const r = ResultadoCante(temaCantado: '3.A.1', valoracion: 4, criterios: {'Esquema': 4, 'Rigor': 2, 'Tiempo': 0});
    final v = ResultadoCante.fromJson(r.toJson());
    expect(v.criterios, {'Esquema': 4, 'Rigor': 2}, reason: 'los de cero no se guardan');
    expect(v.textoCriterios(), 'Esquema ★★★★☆ · Rigor ★★☆☆☆');
    expect(const ResultadoCante().toJson().containsKey('criterios'), isFalse);
    // Fuera de rango se recorta.
    expect(ResultadoCante.fromJson({'criterios': {'Esquema': 9}}).criterios, {'Esquema': 5});
  });

  test('evolución por criterio: últimos cinco frente a los cinco anteriores', () {
    final hoy = DateTime(2026, 10, 28);
    Cante c(int i, int esquema, [int? rigor]) => Cante(id: 'c$i', fecha: hoy.subtract(Duration(days: i)), estado: EstadoCante.hecho, resultado: ResultadoCante(valoracion: 3, criterios: {'Esquema': esquema, if (rigor != null) 'Rigor': rigor}), updatedAt: hoy);
    // Del más reciente al más antiguo: cinco con 4 y cinco con 2.
    final cantes = [for (var i = 0; i < 5; i++) c(i, 4, 3), for (var i = 5; i < 10; i++) c(i, 2)];
    final ev = evolucionCriterios(cantes);
    expect(ev['Esquema'], (ultimos: 4.0, anteriores: 2.0, veces: 10));
    expect(ev['Rigor'], (ultimos: 3.0, anteriores: null, veces: 5));
    expect(evolucionCriterios(cantes.take(3)), {'Esquema': (ultimos: 4.0, anteriores: null, veces: 3), 'Rigor': (ultimos: 3.0, anteriores: null, veces: 3)});
    expect(evolucionCriterios([Cante(id: 'x', fecha: hoy, estado: EstadoCante.hecho, resultado: const ResultadoCante(valoracion: 3), updatedAt: hoy)]), isEmpty);
  });

  test('el tiempo del cante se lee en minutos, minutos:segundos o con decimales', () {
    expect(leerDuracionCante('28'), 28 * 60);
    expect(leerDuracionCante('28:30'), 28 * 60 + 30);
    expect(leerDuracionCante(' 28 : 05 '), 28 * 60 + 5);
    expect(leerDuracionCante('28,5'), 28 * 60 + 30);
    expect(leerDuracionCante('0'), isNull);
    expect(leerDuracionCante(''), isNull);
    expect(leerDuracionCante('28:75'), isNull);
    expect(leerDuracionCante('abc'), isNull);
    expect(textoDuracionCante(28 * 60), '28');
    expect(textoDuracionCante(28 * 60 + 5), '28:05');
  });

  test('el informe lleva los criterios y la rúbrica del preparador se guarda', () {
    final c = Cante(id: 'c', fecha: DateTime(2026, 10, 28), estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1', valoracion: 3, criterios: {'Esquema': 3, 'Tiempo': 5}), updatedAt: DateTime(2026, 10, 28));
    expect(informeCante(c), contains('Esquema ★★★☆☆'));
    expect(informeCante(c), contains('Tiempo ★★★★★'));
    final p = PerfilPreparador.fromJson(const PerfilPreparador(rubrica: ['Esquema', 'Gráficos']).toJson());
    expect(p.rubrica, ['Esquema', 'Gráficos']);
    expect(const PerfilPreparador().toJson().containsKey('rubrica'), isFalse);
    expect(rubricaPorDefecto.length, 5);
  });
}
