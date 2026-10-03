import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/cronograma.dart';
import '../data/models/preparador.dart';
import '../features/cronograma/planificador.dart';
import 'providers.dart';

/// Vueltas anotadas en la agenda de cada tema (cuentan como hechas en el cronograma).
final vueltasProvider = Provider<Map<String, List<DateTime>>>((ref) => {for (final e in ref.watch(agendasProvider).entries) e.key: e.value.vueltas});

/// Cronograma activo del opositor. Solo hay uno; al empezar otro,
/// el anterior se archiva.
class CronogramaNotifier extends Notifier<Cronograma?> {
  @override
  Cronograma? build() => ref.read(planRepoProvider).cronogramaActivo();

  Future<void> _guardar(Cronograma c) async {
    await ref.read(planRepoProvider).guardarCronograma(c);
    state = c.archivado ? null : c;
  }

  Future<void> empezar(Cronograma c) async {
    await ref.read(planRepoProvider).empezarCronograma(c);
    state = c;
  }

  /// Marca o desmarca un tema. Marcarlo lo da por estudiado y anota una vuelta
  /// en su agenda; desmarcarlo no borra esa vuelta.
  Future<void> marcar(String tema, {required bool hecho}) async {
    final c = state;
    if (c == null) return;
    if (hecho) {
      await _guardar(c.copyWith(hechos: {...c.hechos, tema: DateTime.now()}, desmarcados: {...c.desmarcados}..remove(tema)));
      await ref.read(ajustesProvider.notifier).actualizar((a) => a.temasEstudiados.contains(tema) ? a : a.copyWith(temasEstudiados: {...a.temasEstudiados, tema}));
      await ref.read(agendasProvider.notifier).actualizar(tema, (a) => a.vueltaCompletada());
    } else {
      await _guardar(c.copyWith(hechos: {...c.hechos}..remove(tema), desmarcados: {...c.desmarcados, tema}));
    }
  }

  /// Reparte de nuevo lo pendiente desde esta semana: con [porSemana] temas o
  /// para acabar en la semana de [fin].
  Future<void> replanificar({int? porSemana, DateTime? fin}) async {
    final c = state;
    if (c == null) return;
    await _guardar(replanificarCronograma(c, DateTime.now(), porSemana: porSemana, fin: fin, vueltas: ref.read(vueltasProvider)));
  }

  /// Nuevo orden de los temas (la parte ya hecha no se mueve).
  Future<void> reordenar(List<String> temas) async {
    final c = state;
    if (c == null) return;
    await _guardar(replanificarCronograma(c.copyWith(temas: temas), DateTime.now(), vueltas: ref.read(vueltasProvider)));
  }

  Future<void> descanso(DateTime lunes, {required bool descansar}) async {
    final c = state;
    if (c == null) return;
    final d = {...c.descansos};
    descansar ? d.add(inicioSemana(lunes, c.diaCante)) : d.remove(inicioSemana(lunes, c.diaCante));
    await _guardar(replanificarCronograma(c.copyWith(descansos: d), DateTime.now(), vueltas: ref.read(vueltasProvider)));
  }

  Future<void> compartir(bool si) async {
    final c = state;
    if (c != null) await _guardar(c.copyWith(compartir: si));
  }

  Future<void> aceptarPropuesta() async {
    final c = state;
    final p = c?.propuesta;
    if (c == null || p == null) return;
    // Mismo conjunto de temas: los que propone, en su orden, y los que faltaran, al final.
    final orden = [...p.temas.where(c.temas.contains), ...c.temas.where((t) => !p.temas.contains(t))];
    final base = c.copyWith(temas: orden, quitarFin: p.fin == null);
    final nuevo = replanificarCronograma(base, DateTime.now(), porSemana: p.fin == null ? p.temasPorSemana : null, fin: p.fin, vueltas: ref.read(vueltasProvider));
    await _guardar(nuevo.copyWith(quitarPropuesta: true, propuestaResuelta: DateTime.now()));
  }

  Future<void> rechazarPropuesta() async {
    final c = state;
    if (c != null) await _guardar(c.copyWith(quitarPropuesta: true, propuestaResuelta: DateTime.now()));
  }

  Future<void> archivar() async {
    final c = state;
    if (c != null) await _guardar(c.copyWith(archivado: true));
  }

  void recargar() => state = ref.read(planRepoProvider).cronogramaActivo();
}

final cronogramaProvider = NotifierProvider<CronogramaNotifier, Cronograma?>(CronogramaNotifier.new);

/// Situación del cronograma activo hoy.
final estadoCronogramaProvider = Provider<EstadoCronograma?>((ref) {
  final c = ref.watch(cronogramaProvider);
  return c == null ? null : estadoDe(c, DateTime.now(), vueltas: ref.watch(vueltasProvider));
});

/// Cronogramas anteriores (archivados).
final cronogramasArchivadosProvider = Provider<List<Cronograma>>((ref) {
  ref.watch(cronogramaProvider);
  return ref.read(planRepoProvider).cronogramas().where((c) => c.archivado).toList();
});

/// Cronograma que comparte un alumno enlazado (lado del preparador).
final cronogramaAlumnoProvider = FutureProvider.autoDispose.family<Cronograma?, String>((ref, idAlumno) async {
  final repo = ref.watch(preparadorRepoProvider);
  final Alumno? a = repo.alumno(idAlumno);
  return a == null ? null : repo.cronogramaDe(a);
});
