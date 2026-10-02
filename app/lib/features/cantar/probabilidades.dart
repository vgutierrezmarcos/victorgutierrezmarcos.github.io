import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/temario.dart';
import 'sorteo.dart';

/// Ejercicios con sorteo de temas.
const ejerciciosConSorteo = [3, 4, 5];

/// Partes de un ejercicio con lo que se sabe el opositor de cada una.
/// [sabidos] permite simular ("¿y si me supiera…?") por clave de parte ("3.A").
List<ParteSorteo> partesDeEjercicio(
  int ejercicio, {
  required Map<String, List<Tema>> porParte,
  required Set<String> estudiados,
  required AppConfig config,
  Map<String, int> sabidos = const {},
}) {
  final claves = porParte.keys.where((k) => k.startsWith('$ejercicio.')).toList()..sort();
  return [
    for (final k in claves)
      ParteSorteo(
        total: porParte[k]!.length,
        sabidos: (sabidos[k] ?? porParte[k]!.where((t) => estudiados.contains(t.codigo)).length).clamp(0, porParte[k]!.length),
        bolas: config.bolasPorParte[ejercicio] ?? 2,
      ),
  ];
}

/// Probabilidad de aprobar los ejercicios de temas con los temas marcados como estudiados.
final probabilidadAprobarProvider = Provider<ProbabilidadAprobar?>((ref) {
  final porParte = ref.watch(temasPorParteProvider);
  if (porParte.isEmpty) return null;
  final config = ref.watch(configProvider).value ?? AppConfig.porDefecto;
  final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
  final porEjercicio = <int, double>{};
  var temas = 0;
  for (final ej in ejerciciosConSorteo) {
    final partes = partesDeEjercicio(ej, porParte: porParte, estudiados: estudiados, config: config);
    if (partes.isEmpty) continue;
    porEjercicio[ej] = Sorteo.probEjercicio(partes, elegir: config.partesARedactar[ej]);
    temas += partes.fold(0, (s, p) => s + p.sabidos);
  }
  return ProbabilidadAprobar(porEjercicio: porEjercicio, temasSabidos: temas);
});

String porcentaje(double p, {int decimales = 1}) => '${(100 * p).toStringAsFixed(decimales).replaceAll('.', ',')} %';
