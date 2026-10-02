import 'dart:math';

/// Una parte de un ejercicio en el sorteo: [total] temas, de los que el
/// opositor se sabe [sabidos], y de la que se extraen [bolas] temas.
class ParteSorteo {
  const ParteSorteo({required this.total, required this.sabidos, this.bolas = 2});
  final int total;
  final int sabidos;
  final int bolas;

  ParteSorteo con(int sabidos) => ParteSorteo(total: total, sabidos: sabidos.clamp(0, total), bolas: bolas);
}

/// Recomendación de la hoja "Ej. 3" / "Ej. 4" del Excel.
enum Consejo { ninguno, cambiarAporB, cambiarBporA }

/// Cálculos del sorteo de temas, réplica del Excel "Estrategia y organización"
/// (hojas "Ej. 3", "Ej. 4", "Ej. 5" y "Probabilidad de aprobar").
///
/// Tercer y cuarto ejercicio: se sacan 2 bolas de cada parte y hay que saberse
/// al menos una de cada parte, así que la probabilidad es P(A) · P(B).
/// Quinto ejercicio: una bola por parte y se redactan dos de los tres temas,
/// así que cuenta el mejor par de partes.
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

  /// Probabilidad de saberse al menos un tema de los que salen en una parte.
  /// Con 2 bolas equivale a la fórmula del Excel: x/N + (N−x)/N · x/(N−1).
  static double probParte(ParteSorteo p) => probAlMenosUno(total: p.total, estudiados: p.sabidos, extraidos: p.bolas);

  /// Probabilidad de aprobar un ejercicio. Si hay que defender todas las
  /// partes ([elegir] nulo) es el producto; si basta con [elegir] de ellas
  /// (quinto ejercicio: 2 de 3), es el mejor producto posible.
  static double probEjercicio(List<ParteSorteo> partes, {int? elegir}) {
    if (partes.isEmpty) return 0;
    final probs = partes.map(probParte).toList();
    if (elegir == null || elegir >= probs.length) return probs.fold(1.0, (a, b) => a * b);
    // Con probabilidades en [0, 1], el mejor producto es el de las mayores.
    probs.sort((a, b) => b.compareTo(a));
    return probs.take(elegir).fold(1.0, (a, b) => a * b);
  }

  /// "Probabilidad por número de temas": lo que rinde cada tema estudiado.
  static double porTema(List<ParteSorteo> partes, {int? elegir}) {
    final n = partes.fold(0, (s, p) => s + p.sabidos);
    return n == 0 ? 0 : probEjercicio(partes, elegir: elegir) / n;
  }

  /// Mayor rendimiento por tema alcanzable en el ejercicio (denominador de la eficiencia).
  static double maxPorTema(List<ParteSorteo> partes, {int? elegir}) {
    final clave = '${partes.map((p) => '${p.total}/${p.bolas}').join(',')}|$elegir';
    return _maximos[clave] ??= _calcularMaxPorTema(partes, elegir: elegir);
  }

  static final _maximos = <String, double>{};

  static double _calcularMaxPorTema(List<ParteSorteo> partes, {int? elegir}) {
    var mejor = 0.0;
    void recorrer(int i, List<ParteSorteo> actual) {
      if (i == partes.length) {
        final v = porTema(actual, elegir: elegir);
        if (v > mejor) mejor = v;
        return;
      }
      for (var s = 0; s <= partes[i].total; s++) {
        recorrer(i + 1, [...actual, partes[i].con(s)]);
      }
    }

    recorrer(0, const []);
    return mejor;
  }

  /// "Nivel de eficiencia": rendimiento por tema frente al máximo posible (0-1).
  static double eficiencia(List<ParteSorteo> partes, {int? elegir}) {
    final m = maxPorTema(partes, elegir: elegir);
    return m == 0 ? 0 : porTema(partes, elegir: elegir) / m;
  }

  /// Consejo del Excel para ejercicios de dos partes: con el mismo número de
  /// temas, ¿mejoraría la probabilidad cambiando uno de parte?
  static Consejo consejo(ParteSorteo a, ParteSorteo b) {
    final actual = probEjercicio([a, b]);
    if (a.sabidos > 0 && b.sabidos < b.total && probEjercicio([a.con(a.sabidos - 1), b.con(b.sabidos + 1)]) > actual + 1e-12) {
      return Consejo.cambiarAporB;
    }
    if (b.sabidos > 0 && a.sabidos < a.total && probEjercicio([a.con(a.sabidos + 1), b.con(b.sabidos - 1)]) > actual + 1e-12) {
      return Consejo.cambiarBporA;
    }
    return Consejo.ninguno;
  }

  /// Índice de la parte en la que estudiar un tema más sube más la probabilidad
  /// (null si ya se saben todos).
  static int? siguienteParte(List<ParteSorteo> partes, {int? elegir}) {
    int? mejor;
    var mejorP = -1.0;
    for (var i = 0; i < partes.length; i++) {
      if (partes[i].sabidos >= partes[i].total) continue;
      final p = probEjercicio([for (var j = 0; j < partes.length; j++) j == i ? partes[j].con(partes[j].sabidos + 1) : partes[j]], elegir: elegir);
      if (p > mejorP + 1e-12) {
        mejorP = p;
        mejor = i;
      }
    }
    return mejor;
  }

  /// Tabla del Excel: filas = temas sabidos de la parte B, columnas = de la parte A.
  static List<List<double>> tabla(ParteSorteo a, ParteSorteo b) => [
        for (var y = 0; y <= b.total; y++) [for (var x = 0; x <= a.total; x++) probEjercicio([a.con(x), b.con(y)])]
      ];

  /// Número mínimo de temas de una parte para alcanzar [objetivo] (0-1) en esa parte.
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

  /// Sorteo oficial: [bolas] temas de cada parte.
  static Map<String, List<T>> sorteoOficial<T>(Map<String, List<T>> porParte, int bolas, {Random? random}) =>
      {for (final e in porParte.entries) e.key: sortear(e.value, bolas, random: random)};

  /// Sorteo de [n] elementos distintos con probabilidad proporcional a su peso.
  static List<T> sortearPonderado<T>(List<T> bolsa, int n, double Function(T) peso, {Random? random}) {
    final r = random ?? Random();
    final resto = List<T>.from(bolsa);
    final out = <T>[];
    while (out.length < n && resto.isNotEmpty) {
      final pesos = resto.map((x) => max(peso(x), 0.0)).toList();
      final suma = pesos.fold(0.0, (a, b) => a + b);
      var i = 0;
      if (suma <= 0) {
        i = r.nextInt(resto.length);
      } else {
        var t = r.nextDouble() * suma;
        for (i = 0; i < resto.length - 1; i++) {
          t -= pesos[i];
          if (t < 0) break;
        }
      }
      out.add(resto.removeAt(i));
    }
    return out;
  }

  /// Peso de un tema para practicar: más cuanto menos se ha cantado y peor se valoró.
  static double pesoPractica({required int veces, required double valoracionMedia}) {
    final valoracion = valoracionMedia <= 0 ? 3.0 : valoracionMedia;
    return (6 - valoracion) / (1 + veces);
  }
}

/// Probabilidad conjunta de aprobar los tres ejercicios de temas
/// (hoja "Probabilidad de aprobar": pasando el test, la coyuntura y los idiomas).
class ProbabilidadAprobar {
  const ProbabilidadAprobar({required this.porEjercicio, required this.temasSabidos});

  /// Probabilidad de cada ejercicio (3, 4 y 5).
  final Map<int, double> porEjercicio;
  final int temasSabidos;

  double get total => porEjercicio.values.fold(1.0, (a, b) => a * b);
  double get porTema => temasSabidos == 0 ? 0 : total / temasSabidos;
}
