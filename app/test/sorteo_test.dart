import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/sorteo.dart';

void main() {
  test('combinaciones', () {
    expect(Sorteo.combinaciones(5, 2), 10);
    expect(Sorteo.combinaciones(90, 3), 117480);
  });

  test('probabilidad de al menos un tema estudiado (hipergeométrica)', () {
    // 90 temas, 3 extraídos, 30 estudiados: 1 - C(60,3)/C(90,3)
    final p = Sorteo.probAlMenosUno(total: 90, estudiados: 30, extraidos: 3);
    expect(p, closeTo(1 - 34220 / 117480, 1e-9));
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: 0, extraidos: 3), 0);
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: 90, extraidos: 3), 1);
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: 88, extraidos: 3), 1);
  });

  test('mínimos para objetivo y tabla monótona', () {
    final t = Sorteo.tabla(total: 90, extraidos: 3);
    for (var i = 1; i < t.length; i++) {
      expect(t[i], greaterThanOrEqualTo(t[i - 1]));
    }
    final m = Sorteo.minimosPara(total: 90, extraidos: 3, objetivo: 0.9);
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: m, extraidos: 3), greaterThanOrEqualTo(0.9));
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: m - 1, extraidos: 3), lessThan(0.9));
  });

  test('sortear devuelve n distintos', () {
    final s = Sorteo.sortear(List.generate(10, (i) => i), 4);
    expect(s.length, 4);
    expect(s.toSet().length, 4);
  });
}
