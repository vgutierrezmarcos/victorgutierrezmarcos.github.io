import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/features/cantar/sorteo.dart';

/// Fórmula literal de las hojas "Ej. 3" y "Ej. 4" del Excel de organización.
double excel(int x, int n) => x / n + ((n - x) / n) * (x / (n - 1));

ParteSorteo parte(int total, int sabidos, {int bolas = 2}) => ParteSorteo(total: total, sabidos: sabidos, bolas: bolas);

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

  group('como el Excel', () {
    test('la probabilidad de una parte coincide con la fórmula de la hoja para todos los valores', () {
      for (final n in [45, 30, 26]) {
        for (var x = 0; x <= n; x++) {
          expect(Sorteo.probParte(parte(n, x)), closeTo(excel(x, n), 1e-12), reason: '$x de $n');
        }
      }
    });

    test('tercer ejercicio: 30 + 30 de 45 + 45', () {
      final partes = [parte(45, 30), parte(45, 30)];
      expect(Sorteo.probEjercicio(partes), closeTo(0.7991276400367308, 1e-12));
      expect(Sorteo.porTema(partes), closeTo(0.013318794000612179, 1e-12));
      // 30 + 30 es justo el reparto más eficiente del tercer ejercicio.
      expect(Sorteo.eficiencia(partes), closeTo(1, 1e-12));
    });

    test('cuarto ejercicio: el máximo rendimiento por tema está en 19 + 17', () {
      expect(Sorteo.maxPorTema([parte(30, 0), parte(26, 0)]), closeTo(0.021577758129482268, 1e-12));
      expect(Sorteo.eficiencia([parte(30, 19), parte(26, 17)]), closeTo(1, 1e-12));
      expect(Sorteo.probEjercicio([parte(30, 26), parte(26, 23)]), closeTo(0.977103448275862, 1e-12));
    });

    test('quinto ejercicio: una bola por parte y cuentan las dos mejores partes', () {
      List<ParteSorteo> quinto(int a, int b, int c) => [parte(10, a, bolas: 1), parte(6, b, bolas: 1), parte(15, c, bolas: 1)];
      expect(Sorteo.probEjercicio(quinto(10, 6, 0), elegir: 2), 1);
      expect(Sorteo.probEjercicio(quinto(5, 3, 15), elegir: 2), closeTo(0.5, 1e-12)); // máx(0,25; 0,5; 0,5)
      expect(Sorteo.probEjercicio(quinto(0, 0, 15), elegir: 2), 0);
      expect(Sorteo.maxPorTema(quinto(0, 0, 0), elegir: 2), closeTo(0.0625, 1e-12)); // 10 + 6 temas
    });

    test('probabilidad de aprobar con los valores de la hoja', () {
      final p = ProbabilidadAprobar(porEjercicio: {
        3: Sorteo.probEjercicio([parte(45, 38), parte(45, 38)]),
        4: Sorteo.probEjercicio([parte(30, 26), parte(26, 23)]),
        5: 1,
      }, temasSabidos: 38 + 38 + 26 + 23 + 16);
      expect(p.total, closeTo(0.9360902264019505, 1e-12));
      expect(p.porTema, closeTo(0.00663893777590036, 1e-12));
    });

    test('consejo de cambiar un tema de parte', () {
      expect(Sorteo.consejo(parte(45, 30), parte(45, 30)), Consejo.ninguno);
      expect(Sorteo.consejo(parte(45, 40), parte(45, 20)), Consejo.cambiarAporB);
      expect(Sorteo.consejo(parte(45, 20), parte(45, 40)), Consejo.cambiarBporA);
      expect(Sorteo.consejo(parte(45, 45), parte(45, 10)), Consejo.cambiarAporB);
      expect(Sorteo.consejo(parte(45, 0), parte(45, 0)), Consejo.ninguno);
    });

    test('siguiente parte y tabla', () {
      expect(Sorteo.siguienteParte([parte(45, 40), parte(45, 20)]), 1);
      expect(Sorteo.siguienteParte([parte(45, 45), parte(45, 45)]), isNull);
      final t = Sorteo.tabla(parte(45, 0), parte(45, 0));
      expect(t.length, 46);
      expect(t[30][30], closeTo(0.7991276400367308, 1e-12));
      expect(t[45][45], 1);
      expect(t[0][45], 0);
    });
  });

  test('mínimos para objetivo', () {
    final m = Sorteo.minimosPara(total: 90, extraidos: 3, objetivo: 0.9);
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: m, extraidos: 3), greaterThanOrEqualTo(0.9));
    expect(Sorteo.probAlMenosUno(total: 90, estudiados: m - 1, extraidos: 3), lessThan(0.9));
  });

  group('sorteos', () {
    test('sortear devuelve n distintos', () {
      final s = Sorteo.sortear(List.generate(10, (i) => i), 4);
      expect(s.length, 4);
      expect(s.toSet().length, 4);
    });

    test('oficial: tantas bolas de cada parte', () {
      final s = Sorteo.sorteoOficial({'3.A': List.generate(45, (i) => 'A$i'), '3.B': List.generate(45, (i) => 'B$i')}, 2, random: Random(1));
      expect(s.keys, ['3.A', '3.B']);
      expect(s['3.A']!.length, 2);
      expect(s['3.B']!.toSet().length, 2);
      expect(s['3.A']!.every((x) => x.startsWith('A')), isTrue);
    });

    test('ponderado: sin repetidos y favorece los pesos altos', () {
      final bolsa = List.generate(10, (i) => i);
      final r = Random(7);
      var vecesDelPesado = 0;
      for (var i = 0; i < 500; i++) {
        final s = Sorteo.sortearPonderado(bolsa, 2, (x) => x == 0 ? 20.0 : 1.0, random: r);
        expect(s.toSet().length, 2);
        if (s.contains(0)) vecesDelPesado++;
      }
      expect(vecesDelPesado, greaterThan(350)); // sin ponderar saldría ~100 veces
      expect(Sorteo.sortearPonderado(bolsa, 20, (_) => 0, random: r).length, 10);
    });

    test('peso de práctica: más para lo poco cantado y lo mal valorado', () {
      final nuevo = Sorteo.pesoPractica(veces: 0, valoracionMedia: 0);
      final flojo = Sorteo.pesoPractica(veces: 2, valoracionMedia: 1.5);
      final dominado = Sorteo.pesoPractica(veces: 2, valoracionMedia: 5);
      expect(nuevo, greaterThan(flojo));
      expect(flojo, greaterThan(dominado));
    });
  });
}
