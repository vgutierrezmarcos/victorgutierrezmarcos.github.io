import 'dart:math';

import '../../data/models/plan.dart';

/// Reparto automático de temas por semanas (hoja "Cronograma" del Excel,
/// pero rellenada sola). Lógica pura, sin dependencias de Flutter.
class Planificador {
  Planificador._();

  /// Lunes de la semana de [d] (a medianoche).
  static DateTime lunes(DateTime d) => DateTime(d.year, d.month, d.day - (d.weekday - 1));

  /// Semanas completas disponibles entre el lunes de [inicio] y [fin] (mínimo 1).
  static int semanasHasta(DateTime inicio, DateTime fin) {
    final dias = DateTime(fin.year, fin.month, fin.day).difference(lunes(inicio)).inHours / 24;
    return max(1, dias.round() ~/ 7);
  }

  /// Intercala las partes (3.A, 3.B, 4.A…) para no estudiar una parte entera
  /// de seguido: A1, B1, A2, B2…
  static List<String> alternarPartes(List<String> temas) {
    final grupos = <String, List<String>>{};
    for (final t in temas) {
      final p = t.split('.');
      grupos.putIfAbsent(p.length >= 2 ? '${p[0]}.${p[1]}' : t, () => []).add(t);
    }
    final colas = grupos.values.toList();
    final out = <String>[];
    for (var i = 0; out.length < temas.length; i++) {
      for (final c in colas) {
        if (i < c.length) out.add(c[i]);
      }
    }
    return out;
  }

  /// Reparte [temas] en semanas a partir del lunes de [inicio].
  ///
  /// - Con [temasPorSemana], cada semana lleva ese número de temas y el
  ///   cronograma dura lo que haga falta.
  /// - Sin él, hace falta [fin]: los temas se reparten por igual entre las
  ///   semanas disponibles.
  ///
  /// Con varias [vueltas], cada vuelta va el doble de rápido que la anterior.
  static Cronograma repartir({
    required List<String> temas,
    required DateTime inicio,
    DateTime? fin,
    int? temasPorSemana,
    int vueltas = 1,
  }) {
    assert(fin != null || temasPorSemana != null, 'Hace falta fecha de fin o temas por semana');
    final lunesInicio = lunes(inicio);
    if (temas.isEmpty) return Cronograma(inicio: lunesInicio);
    vueltas = max(1, vueltas);

    // Semanas que ocupa cada vuelta.
    final semanasVuelta = <int>[];
    if (temasPorSemana != null && temasPorSemana > 0) {
      for (var v = 0; v < vueltas; v++) {
        semanasVuelta.add((temas.length / (temasPorSemana * pow(2, v))).ceil());
      }
    } else {
      final disponibles = max(vueltas, semanasHasta(inicio, fin!));
      // Pesos 1, 1/2, 1/4… normalizados; cada vuelta ocupa al menos una semana.
      final pesos = [for (var v = 0; v < vueltas; v++) 1 / pow(2, v)];
      final suma = pesos.fold(0.0, (a, b) => a + b);
      var usadas = 0;
      for (var v = 0; v < vueltas; v++) {
        final restantes = vueltas - v - 1;
        final s = v == vueltas - 1 ? disponibles - usadas : (disponibles * pesos[v] / suma).round().clamp(1, disponibles - usadas - restantes);
        semanasVuelta.add(s);
        usadas += s;
      }
    }

    final entradas = <EntradaCronograma>[];
    var semanaBase = 0;
    for (var v = 0; v < vueltas; v++) {
      final n = semanasVuelta[v];
      for (var i = 0; i < temas.length; i++) {
        // Reparto uniforme: el tema i cae en la semana ⌊i·n/N⌋ de la vuelta.
        entradas.add(EntradaCronograma(codigo: temas[i], semana: semanaBase + (i * n ~/ temas.length) + 1, vuelta: v + 1));
      }
      semanaBase += n;
    }
    return Cronograma(inicio: lunesInicio, entradas: entradas);
  }
}
