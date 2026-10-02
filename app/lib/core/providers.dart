import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/models/estructura.dart';
import '../data/models/plan.dart';
import '../data/models/pregunta.dart';
import '../data/models/temario.dart';
import '../data/repos/contenido_repo.dart';
import '../data/repos/descargas_repo.dart';
import '../data/repos/plan_repo.dart';
import '../data/repos/usuario_repo.dart';
import '../features/test/leitner.dart';
import 'cache_http.dart';
import 'notificaciones.dart';

/// Servicios creados en main() antes de arrancar la app.
class Servicios {
  const Servicios({
    required this.http,
    required this.contenido,
    required this.usuario,
    required this.plan,
    required this.descargas,
    required this.firebaseDisponible,
  });
  final CacheHttp http;
  final ContenidoRepo contenido;
  final UsuarioRepo usuario;
  final PlanRepo plan;
  final DescargasRepo descargas;
  /// false si no hay google-services.json / GoogleService-Info.plist (modo sin cuenta).
  final bool firebaseDisponible;
}

final serviciosProvider = Provider<Servicios>((ref) => throw UnimplementedError('Se inyecta en main()'));

final contenidoProvider = Provider((ref) => ref.watch(serviciosProvider).contenido);
final usuarioRepoProvider = Provider((ref) => ref.watch(serviciosProvider).usuario);
final planRepoProvider = Provider((ref) => ref.watch(serviciosProvider).plan);
final descargasProvider = Provider((ref) => ref.watch(serviciosProvider).descargas);

// ------------------------------------------------------------------ Contenido

final preguntasProvider = FutureProvider<BancoPreguntas>((ref) => ref.watch(contenidoProvider).preguntas());
final bloquesProvider = FutureProvider<Bloques>((ref) => ref.watch(contenidoProvider).bloques());
final temarioProvider = FutureProvider<Temario>((ref) => ref.watch(contenidoProvider).temario());
final estructuraProvider = FutureProvider<EstructuraTemario>((ref) => ref.watch(contenidoProvider).estructura());
final enlacesProvider = FutureProvider<List<CategoriaEnlaces>>((ref) => ref.watch(contenidoProvider).enlaces());
final configProvider = FutureProvider<AppConfig>((ref) => ref.watch(contenidoProvider).config());

/// Versión nueva disponible (o null): la publicada en app-config.json si es
/// posterior a la instalada.
final actualizacionProvider = FutureProvider<String?>((ref) async {
  final config = await ref.watch(configProvider.future);
  final publicada = config.versionActual;
  if (publicada == null) return null;
  try {
    final instalada = (await PackageInfo.fromPlatform()).version;
    return AppConfig.esPosterior(publicada, instalada) ? publicada : null;
  } catch (_) {
    return null;
  }
});

// ------------------------------------------------------------------ Sesión

final authStateProvider = StreamProvider<User?>((ref) {
  if (!ref.watch(serviciosProvider).firebaseDisponible) return Stream.value(null);
  return FirebaseAuth.instance.authStateChanges();
});

final usuarioActualProvider = Provider<User?>((ref) => ref.watch(authStateProvider).value);

class SesionNotifier extends Notifier<bool> {
  @override
  bool build() => false; // ocupado

  Future<String?> iniciarConGoogle() async {
    state = true;
    try {
      final google = await GoogleSignIn(scopes: const ['email']).signIn();
      if (google == null) return null; // cancelado
      final auth = await google.authentication;
      final cred = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
      await FirebaseAuth.instance.signInWithCredential(cred);
      await sincronizarTodo(ref);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? e.code;
    } catch (e) {
      return e.toString();
    } finally {
      state = false;
    }
  }

  Future<void> sincronizar() => sincronizarTodo(ref);

  Future<void> cerrarSesion() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
    ref.invalidate(historialProvider);
  }
}

final sesionProvider = NotifierProvider<SesionNotifier, bool>(SesionNotifier.new);

/// Sincroniza todos los datos del usuario con la nube y refresca la interfaz.
Future<void> sincronizarTodo(Ref ref) async {
  await ref.read(usuarioRepoProvider).sincronizarTodo();
  await ref.read(planRepoProvider).sincronizarTodo();
  ref.invalidate(leitnerProvider);
  ref.invalidate(ajustesProvider);
  ref.invalidate(historialProvider);
  ref.invalidate(cantesProvider);
  ref.invalidate(planProvider);
  ref.invalidate(agendasProvider);
  await ref.read(cantesProvider.notifier).reprogramarAvisos();
}

// ------------------------------------------------------------------ Usuario

final historialProvider = FutureProvider((ref) {
  ref.watch(authStateProvider);
  return ref.watch(usuarioRepoProvider).historial();
});

class LeitnerNotifier extends Notifier<EstadoLeitner> {
  @override
  EstadoLeitner build() => ref.read(usuarioRepoProvider).leitner();

  Future<void> registrarExamen(Map<int, bool> resultados) async {
    final e = EstadoLeitner.fromJson(state.toJson())..registrarExamen(resultados);
    state = e;
    await ref.read(usuarioRepoProvider).guardarLeitner(e);
  }

  Future<void> reiniciar() async {
    state = EstadoLeitner();
    await ref.read(usuarioRepoProvider).guardarLeitner(state);
  }
}

final leitnerProvider = NotifierProvider<LeitnerNotifier, EstadoLeitner>(LeitnerNotifier.new);

class AjustesNotifier extends Notifier<Ajustes> {
  @override
  Ajustes build() => ref.read(usuarioRepoProvider).ajustes();

  Future<void> actualizar(Ajustes Function(Ajustes) f) async {
    final nuevo = f(state);
    state = nuevo;
    await ref.read(usuarioRepoProvider).guardarAjustes(nuevo);
  }

  Future<void> registrarActividad() => actualizar((a) => a.conActividadHoy());

  Future<void> alternarEstudiado(String codigo) => actualizar((a) {
        final s = {...a.temasEstudiados};
        s.contains(codigo) ? s.remove(codigo) : s.add(codigo);
        return a.copyWith(temasEstudiados: s);
      });

  Future<void> alternarRepaso(String codigo) => actualizar((a) {
        final s = {...a.temasEnRepaso};
        s.contains(codigo) ? s.remove(codigo) : s.add(codigo);
        return a.copyWith(temasEnRepaso: s);
      });

  Future<void> fijarRecordatorio(int minutos) async {
    await actualizar((a) => a.copyWith(horaRecordatorio: minutos));
    await Notificaciones.programarRecordatorio(minutos);
  }
}

final ajustesProvider = NotifierProvider<AjustesNotifier, Ajustes>(AjustesNotifier.new);

final modoTemaProvider = Provider<ThemeMode>((ref) {
  final t = ref.watch(ajustesProvider.select((a) => a.temaOscuro));
  return t == null ? ThemeMode.system : (t ? ThemeMode.dark : ThemeMode.light);
});

/// Marca de "test diario hecho hoy" (según historial local).
final testDiarioHechoProvider = Provider<bool>((ref) {
  ref.watch(historialProvider);
  final hoy = Ajustes.claveDia(DateTime.now());
  return ref
      .read(usuarioRepoProvider)
      .resultadosLocales()
      .any((r) => r.tipo == 'diario' && Ajustes.claveDia(r.timestamp) == hoy);
});

// ------------------------------------------------------------------ Planificación

class CantesNotifier extends Notifier<List<Cante>> {
  @override
  List<Cante> build() => ref.read(planRepoProvider).cantes();

  Future<void> guardar(Cante c) => guardarVarios([c]);

  Future<void> guardarVarios(List<Cante> lista) async {
    final repo = ref.read(planRepoProvider);
    await repo.guardarCantes(lista);
    state = repo.cantes();
    await reprogramarAvisos();
  }

  Future<void> borrar(Cante c) async {
    final repo = ref.read(planRepoProvider);
    await repo.borrarCante(c);
    state = repo.cantes();
    await reprogramarAvisos();
  }

  /// Borra un cante y los siguientes de su misma serie semanal.
  Future<void> borrarSerieDesde(Cante c) async {
    final repo = ref.read(planRepoProvider);
    for (final x in state.where((x) => x.serie != null && x.serie == c.serie && !x.fecha.isBefore(c.fecha) && x.pendiente)) {
      await repo.borrarCante(x);
    }
    state = repo.cantes();
    await reprogramarAvisos();
  }

  Future<void> reprogramarAvisos() async {
    try {
      await Notificaciones.programarCantes(ref.read(planProvider).avisosCante ? state : const []);
    } catch (_) {}
  }
}

final cantesProvider = NotifierProvider<CantesNotifier, List<Cante>>(CantesNotifier.new);

/// Próximos cantes pendientes, del más cercano al más lejano.
final proximosCantesProvider = Provider<List<Cante>>((ref) {
  final ahora = DateTime.now();
  // Un cante sigue contando como próximo hasta dos horas después de su hora.
  return ref.watch(cantesProvider).where((c) => c.pendiente && c.fecha.isAfter(ahora.subtract(const Duration(hours: 2)))).toList();
});

/// Diario: cantes ya hechos, del más reciente al más antiguo.
final diarioProvider = Provider<List<Cante>>((ref) => ref.watch(cantesProvider).where((c) => c.hecho).toList().reversed.toList());

final estadisticasCantesProvider = Provider<Map<String, EstadisticaTema>>((ref) => EstadisticaTema.desde(ref.watch(cantesProvider)));

/// Cante de la agenda que se está cantando ahora en la pestaña Cantar.
final canteEnCursoProvider = StateProvider<String?>((ref) => null);

class PlanNotifier extends Notifier<Plan> {
  @override
  Plan build() => ref.read(planRepoProvider).plan();

  Future<void> actualizar(Plan Function(Plan) f) async {
    final nuevo = f(state);
    state = nuevo;
    await ref.read(planRepoProvider).guardarPlan(nuevo);
  }
}

final planProvider = NotifierProvider<PlanNotifier, Plan>(PlanNotifier.new);

/// Fecha de cada ejercicio. Las pone siempre el usuario: la app no trae
/// fechas oficiales de ninguna convocatoria.
final fechasEjerciciosProvider = Provider<Map<int, DateTime>>((ref) {
  final legado = ref.watch(ajustesProvider.select((a) => a.fechaConvocatoria));
  return {
    if (legado != null) 1: legado,
    ...ref.watch(planProvider.select((p) => p.fechas)),
  };
});

class AgendasNotifier extends Notifier<Map<String, AgendaTema>> {
  @override
  Map<String, AgendaTema> build() => ref.read(planRepoProvider).agendas();

  AgendaTema de(String codigo) => state[codigo] ?? AgendaTema(codigo: codigo);

  Future<void> actualizar(String codigo, AgendaTema Function(AgendaTema) f) async {
    final nueva = f(de(codigo));
    state = {...state, codigo: nueva};
    await ref.read(planRepoProvider).guardarAgenda(nueva);
  }
}

/// Agenda de cada tema (apuntes para la próxima vuelta), por código.
final agendasProvider = NotifierProvider<AgendasNotifier, Map<String, AgendaTema>>(AgendasNotifier.new);

/// Temas por parte ("3.A" → temas) de los ejercicios con sorteo.
final temasPorParteProvider = Provider<Map<String, List<Tema>>>((ref) {
  final t = ref.watch(temarioProvider).value;
  if (t == null) return const {};
  return {
    for (final e in t.ejercicios)
      for (final p in e.partes)
        if (p.temas.isNotEmpty) '${e.id}.${p.letra}': p.temas,
  };
});
