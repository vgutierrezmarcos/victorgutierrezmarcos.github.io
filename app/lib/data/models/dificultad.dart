import 'dart:math' as math;

/// Cuántos fallan cada pregunta del test, con los tests de todos los usuarios
/// (app y simulador web). Lo escribe `scripts/dificultad-test.py` en
/// `oposicion/temario/primer-ejercicio/test/dificultad.json`: solo recuentos
/// por pregunta, nada de nadie. Las cifras se enseñan a partir de [minimo]
/// vistas.
class DatoDificultad {
  const DatoDificultad({required this.vistas, required this.aciertos, required this.fallos, required this.blancos});
  final int vistas, aciertos, fallos, blancos;

  /// Parte de quienes la han hecho que la fallan o la dejan en blanco (0-1).
  double get mal => vistas == 0 ? 0 : (fallos + blancos) / vistas;
}

class Dificultad {
  const Dificultad({this.minimo = 5, this.tests = 0, this.preguntas = const {}});

  final int minimo;
  final int tests;
  final Map<int, DatoDificultad> preguntas;

  static const vacia = Dificultad();

  bool get vacio => preguntas.isEmpty;

  factory Dificultad.fromJson(Map<dynamic, dynamic> j) {
    final p = (j['preguntas'] as Map?) ?? const {};
    return Dificultad(
      minimo: (j['minimo'] as num?)?.toInt() ?? 5,
      tests: (j['tests'] as num?)?.toInt() ?? 0,
      preguntas: {
        for (final e in p.entries)
          if (int.tryParse(e.key.toString()) != null && e.value is Map)
            int.parse(e.key.toString()): DatoDificultad(
              vistas: ((e.value as Map)['v'] as num?)?.toInt() ?? 0,
              aciertos: ((e.value as Map)['a'] as num?)?.toInt() ?? 0,
              fallos: ((e.value as Map)['f'] as num?)?.toInt() ?? 0,
              blancos: ((e.value as Map)['b'] as num?)?.toInt() ?? 0,
            ),
      },
    );
  }

  /// El dato de [id] si tiene vistas suficientes para enseñarlo.
  DatoDificultad? de(int id) {
    final d = preguntas[id];
    return d != null && d.vistas >= minimo ? d : null;
  }

  /// «La fallan o dejan en blanco 7 de cada 10» (null sin vistas suficientes).
  String? texto(int id) {
    final d = de(id);
    if (d == null) return null;
    final n = (10 * d.mal).round();
    if (n <= 0) return 'Casi todos la aciertan';
    if (n >= 10) return 'Casi nadie la acierta';
    return 'La fallan o dejan en blanco $n de cada 10 que la han hecho';
  }

  /// Las más falladas por todos (con vistas suficientes), de más a menos;
  /// con [ids], solo entre esas.
  List<({int id, DatoDificultad dato})> masFalladas({Iterable<int>? ids}) {
    final conjunto = ids?.toSet();
    final l = [
      for (final e in preguntas.entries)
        if (e.value.vistas >= minimo && (conjunto == null || conjunto.contains(e.key)) && e.value.mal > 0) (id: e.key, dato: e.value),
    ];
    l.sort((a, b) {
      final c = b.dato.mal.compareTo(a.dato.mal);
      return c != 0 ? c : b.dato.vistas.compareTo(a.dato.vistas);
    });
    return l;
  }

  /// Pesos para componer un test con «las que más falla todo el mundo»:
  /// con vistas suficientes, la parte que falla (suavizada); las demás, poco
  /// (para que el test salga aunque haya pocas con dato).
  Map<int, double> pesos(Iterable<int> candidatas) => {
        for (final id in candidatas)
          id: switch (de(id)) {
            null => 0.05,
            final d => math.max(0.05, math.pow(d.mal, 2).toDouble()),
          },
      };
}
