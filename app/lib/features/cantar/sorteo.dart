import 'dart:math';

/// Cálculos del sorteo de temas (réplica de la hoja "Estrategia y organización").
class Sorteo {
  Sorteo._();

  /// Combinaciones C(n, k) en double (n hasta ~200 sin desbordar).
  static double combinaciones(int n, int k) {
    if (k < 0 || k > n) return 0;
    if (k == 0 || k == n) return 1;
    k = min(k, n - k);
    var r = 1.0;
    for (var i = 1; i <= k; i++) {
      r = r * (n - k + i) / i;
    }
    return r;
  }

  /// Probabilidad de que, sacando [extraidos] temas de [total], al menos uno
  /// esté entre los [estudiados] (distribución hipergeométrica).
  static double probAlMenosUno({required int total, required int estudiados, required int extraidos}) {
    if (total <= 0 || extraidos <= 0) return 0;
    if (estudiados <= 0) return 0;
    if (estudiados >= total) return 1;
    if (extraidos > total) extraidos = total;
    final noEstudiados = total - estudiados;
    if (extraidos > noEstudiados) return 1;
    return 1 - combinaciones(noEstudiados, extraidos) / combinaciones(total, extraidos);
  }

  /// Probabilidad de que salgan exactamente [k] temas estudiados.
  static double probExacto({required int total, required int estudiados, required int extraidos, required int k}) {
    if (total <= 0) return 0;
    return combinaciones(estudiados, k) * combinaciones(total - estudiados, extraidos - k) /
        combinaciones(total, extraidos);
  }

  /// Tabla: temas estudiados (0..total) → probabilidad de al menos uno.
  static List<double> tabla({required int total, required int extraidos}) =>
      List.generate(total + 1, (s) => probAlMenosUno(total: total, estudiados: s, extraidos: extraidos));

  /// Número mínimo de temas a estudiar para alcanzar [objetivo] (0-1).
  static int minimosPara({required int total, required int extraidos, required double objetivo}) {
    for (var s = 0; s <= total; s++) {
      if (probAlMenosUno(total: total, estudiados: s, extraidos: extraidos) >= objetivo) return s;
    }
    return total;
  }

  /// Sorteo aleatorio de [n] elementos distintos de [bolsa].
  static List<T> sortear<T>(List<T> bolsa, int n, {Random? random}) {
    final copia = List<T>.from(bolsa)..shuffle(random ?? Random());
    return copia.take(n).toList();
  }
}
