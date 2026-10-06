import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/temario.dart';
import 'sorteo.dart';

/// Partes de un ejercicio con lo que se sabe el opositor de cada una.
/// [sabidos] permite simular ("¿y si me supiera…?") por clave de parte ("3.A").
List<ParteSorteo> partesDeEjercicio(
  int ejercicio, {
  required Map<String, List<Tema>> porParte,
  required Set<String> estudiados,
  required AppConfig config,
  required Oposicion oposicion,
  Map<String, int> sabidos = const {},
}) {
  final claves = porParte.keys.where((k) => k.startsWith('$ejercicio.')).toList()..sort();
  return [
    for (final k in claves)
      ParteSorteo(
        total: porParte[k]!.length,
        sabidos: (sabidos[k] ?? porParte[k]!.where((t) => estudiados.contains(t.codigo)).length).clamp(0, porParte[k]!.length),
        bolas: oposicion.bolasPorParte(ejercicio, config),
      ),
  ];
}

/// Probabilidad de aprobar los ejercicios de temas con los temas marcados como estudiados.
final probabilidadAprobarProvider = Provider<ProbabilidadAprobar?>((ref) {
  final porParte = ref.watch(temasPorParteProvider);
  if (porParte.isEmpty) return null;
  final config = ref.watch(configProvider).valueOrNull ?? AppConfig.porDefecto;
  final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
  final oposicion = ref.watch(oposicionProvider);
  final porEjercicio = <int, double>{};
  var temas = 0;
  for (final ej in oposicion.conSorteo.map((e) => e.numero)) {
    final partes = partesDeEjercicio(ej, porParte: porParte, estudiados: estudiados, config: config, oposicion: oposicion);
    if (partes.isEmpty) continue;
    porEjercicio[ej] = Sorteo.probEjercicio(partes, elegir: oposicion.partesARedactar(ej, config));
    temas += partes.fold(0, (s, p) => s + p.sabidos);
  }
  return ProbabilidadAprobar(porEjercicio: porEjercicio, temasSabidos: temas);
});

String porcentaje(double p, {int decimales = 1}) => '${(100 * p).toStringAsFixed(decimales).replaceAll('.', ',')} %';

/// Lo mismo en puntos porcentuales («1,32 p.p.»): lo que suma a la
/// probabilidad cada tema estudiado se mide así, no en tanto por ciento.
String puntos(double p, {int decimales = 1}) => '${(100 * p).toStringAsFixed(decimales).replaceAll('.', ',')} p.p.';
