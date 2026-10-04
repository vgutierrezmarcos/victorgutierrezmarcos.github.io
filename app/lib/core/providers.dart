import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/models/estructura.dart';
import '../data/models/oposicion.dart';
import '../data/models/plan.dart';
import '../data/models/pregunta.dart';
import '../data/models/preparador.dart';
import '../data/models/temario.dart';
import '../data/repos/contenido_repo.dart';
import '../data/repos/descargas_repo.dart';
import '../data/repos/plan_repo.dart';
import '../data/repos/preparador_repo.dart';
import '../data/repos/usuario_repo.dart';
import '../features/test/leitner.dart';
import 'cache_http.dart';
import 'avisos_fondo.dart';
import 'notificaciones.dart';
import 'cronograma_providers.dart';
import 'red_providers.dart';

/// Servicios creados en main() antes de arrancar la app.
class Servicios {
  const Servicios({
    required this.oposicion,
    required this.http,
    required this.contenido,
    required this.usuario,
    required this.plan,
    required this.preparador,
    required this.descargas,
    required this.firebaseDisponible,
  });
  /// La oposición que prepara el usuario. Fija mientras la app está abierta:
  /// al cambiarla se vuelven a crear los servicios con sus datos.
  final Oposicion oposicion;
  final CacheHttp http;
  final ContenidoRepo contenido;
  final UsuarioRepo usuario;
  final PlanRepo plan;
  final PreparadorRepo preparador;
  final DescargasRepo descargas;
  /// false si no hay google-services.json / GoogleService-Info.plist (modo sin cuenta).
  final bool firebaseDisponible;
}

final serviciosProvider = Provider<Servicios>((ref) => throw UnimplementedError('Se inyecta en main()'));

final oposicionProvider = Provider<Oposicion>((ref) => ref.watch(serviciosProvider).oposicion);

/// Cambia de oposición: se guarda y la app se vuelve a cargar con sus datos
/// (lo pone RaizApp en main.dart).
final cambiarOposicionProvider = Provider<Future<void> Function(Oposicion)>((ref) => (_) async {});
final contenidoProvider = Provider((ref) => ref.watch(serviciosProvider).contenido);
final usuarioRepoProvider = Provider((ref) => ref.watch(serviciosProvider).usuario);
final planRepoProvider = Provider((ref) => ref.watch(serviciosProvider).plan);
final preparadorRepoProvider = Provider((ref) => ref.watch(serviciosProvider).preparador);
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
  // En el navegador siempre se carga la última versión publicada.
  if (publicada == null || kIsWeb) return null;
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

final usuarioActualProvider = Provider<User?>((ref) => ref.watch(authStateProvider).valueOrNull);

class SesionNotifier extends Notifier<bool> {
  @override
  bool build() => false; // ocupado

  Future<String?> iniciarConGoogle() async {
    state = true;
    try {
      if (kIsWeb) {
        // En el navegador, la ventana de Google de Firebase (como en la web).
        await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider()..addScope('email'));
      } else {
        final google = await GoogleSignIn(scopes: const ['email']).signIn();
        if (google == null) return null; // cancelado
        final auth = await google.authentication;
        final cred = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);
        await FirebaseAuth.instance.signInWithCredential(cred);
      }
      await sincronizarTodo(ref);
      return null;
    } on FirebaseAuthException catch (e) {
      // Ventana cerrada por el usuario: no es un error.
      if (e.code == 'popup-closed-by-user' || e.code == 'cancelled-popup-request') return null;
      if (e.code == 'popup-blocked') return 'el navegador ha bloqueado la ventana de Google. Permite las ventanas emergentes de esta página.';
      return e.message ?? e.code;
    } catch (e) {
      return e.toString();
    } finally {
      state = false;
    }
  }

  Future<void> sincronizar() => sincronizarTodo(ref);

  DateTime? _ultima;
  bool _sincronizando = false;

  /// Sincronización automática (al volver a la app y cada pocos minutos):
  /// solo con sesión, sin solaparse y como mucho una vez por minuto.
  Future<void> sincronizarSiToca({bool forzar = false}) async {
    if (_sincronizando || !ref.read(usuarioRepoProvider).conSesion) return;
    final ahora = DateTime.now();
    if (!forzar && _ultima != null && ahora.difference(_ultima!) < const Duration(minutes: 1)) return;
    _sincronizando = true;
    _ultima = ahora;
    try {
      await sincronizarTodo(ref);
    } catch (_) {
      // Sin red: se intenta en la próxima.
    } finally {
      _sincronizando = false;
    }
  }

  Future<void> cerrarSesion() async {
    try {
      if (!kIsWeb) await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
    await programarAvisosEnSegundoPlano(activar: false);
    ref.invalidate(historialProvider);
  }
}

final sesionProvider = NotifierProvider<SesionNotifier, bool>(SesionNotifier.new);

/// Borra todos los datos del usuario en la nube y en este dispositivo y cierra
/// la sesión. La cuenta de Google no se toca.
Future<void> borrarTodosMisDatos(WidgetRef ref) async {
  await ref.read(preparadorRepoProvider).romperTodosLosEnlaces();
  await ref.read(usuarioRepoProvider).borrarTodoEnLaNube();
  await ref.read(usuarioRepoProvider).borrarDatosLocales();
  await ref.read(planRepoProvider).borrarDatosLocales();
  await ref.read(preparadorRepoProvider).borrarDatosLocales();
  await ref.read(sesionProvider.notifier).cerrarSesion();
  for (final p in <ProviderOrFamily>[cronogramaProvider, leitnerProvider, ajustesProvider, historialProvider, cantesProvider, planProvider, agendasProvider, perfilPreparadorProvider, alumnosProvider, sesionesProvider, misPreparadoresProvider]) {
    ref.invalidate(p);
  }
}

/// Elimina la cuenta: los datos de todas las oposiciones (nube y dispositivo),
/// los enlaces con preparadores y alumnos, y la cuenta de la app (Firebase
/// Auth). La cuenta de Google no se toca. Lo exige Google Play. Si Firebase
/// pide un inicio de sesión reciente, se vuelve a pedir el de Google.
/// Devuelve un mensaje de error o null.
Future<String?> eliminarMiCuenta(WidgetRef ref) async {
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) return 'No has iniciado sesión.';
  try {
    for (final o in Oposiciones.todas) {
      final db = FirebaseFirestore.instance;
      final preparador = await PreparadorRepo.crear(oposicion: o, firestore: db, auth: auth);
      final usuario = await UsuarioRepo.crear(oposicion: o, firestore: db, auth: auth);
      final plan = await PlanRepo.crear(oposicion: o, firestore: db, auth: auth);
      await preparador.romperTodosLosEnlaces();
      await usuario.borrarTodoEnLaNube();
      await usuario.borrarDatosLocales();
      await plan.borrarDatosLocales();
      await preparador.borrarDatosLocales();
    }
    try {
      await auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code != 'requires-recent-login') rethrow;
      if (kIsWeb) {
        await auth.currentUser!.reauthenticateWithPopup(GoogleAuthProvider());
      } else {
        final google = await GoogleSignIn(scopes: const ['email']).signIn();
        if (google == null) return 'Para eliminar la cuenta hay que volver a entrar con Google.';
        final a = await google.authentication;
        await auth.currentUser!.reauthenticateWithCredential(GoogleAuthProvider.credential(accessToken: a.accessToken, idToken: a.idToken));
      }
      await auth.currentUser!.delete();
    }
  } on FirebaseException catch (e) {
    return e.message ?? e.code;
  }
  await ref.read(sesionProvider.notifier).cerrarSesion();
  for (final p in <ProviderOrFamily>[cronogramaProvider, leitnerProvider, ajustesProvider, historialProvider, cantesProvider, planProvider, agendasProvider, perfilPreparadorProvider, alumnosProvider, sesionesProvider, misPreparadoresProvider]) {
    ref.invalidate(p);
  }
  return null;
}

/// Sincroniza todos los datos del usuario con la nube y refresca la interfaz.
Future<void> sincronizarTodo(Ref ref) async {
  await ref.read(usuarioRepoProvider).sincronizarTodo();
  await ref.read(planRepoProvider).sincronizarTodo();
  await ref.read(preparadorRepoProvider).sincronizarTodo();
  await sincronizarRed(ref);
  ref.invalidate(leitnerProvider);
  ref.invalidate(ajustesProvider);
  ref.invalidate(historialProvider);
  ref.invalidate(cantesProvider);
  ref.invalidate(planProvider);
  ref.invalidate(agendasProvider);
  ref.invalidate(perfilPreparadorProvider);
  ref.invalidate(alumnosProvider);
  ref.invalidate(sesionesProvider);
  ref.invalidate(misPreparadoresProvider);
  ref.invalidate(cronogramaProvider);
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
  // Claro salvo que el usuario elija el oscuro (no se sigue el del sistema).
  return t == true ? ThemeMode.dark : ThemeMode.light;
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

/// Cante de la agenda que se está cantando ahora en «Cantes → Cantar».
final canteEnCursoProvider = StateProvider<String?>((ref) => null);

/// Subpestaña visible del bloque Cantes: 0 = agenda, 1 = cantar, 2 = diario.
final subpestanaCantesProvider = StateProvider<int>((ref) => 0);

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
  final t = ref.watch(temarioProvider).valueOrNull;
  if (t == null) return const {};
  return {
    for (final e in t.ejercicios)
      for (final p in e.partes)
        if (p.temas.isNotEmpty) '${e.id}.${p.letra}': p.temas,
  };
});

// ------------------------------------------------------------------ Preparadores

class PerfilPreparadorNotifier extends Notifier<PerfilPreparador> {
  @override
  PerfilPreparador build() => ref.read(preparadorRepoProvider).perfil();

  Future<void> activar() async {
    final repo = ref.read(preparadorRepoProvider);
    state = await repo.activar();
    await repo.sincronizarTodo();
    ref.invalidate(alumnosProvider);
    ref.invalidate(sesionesProvider);
  }

  Future<void> guardar(PerfilPreparador p) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.guardarPerfil(p);
    state = repo.perfil();
  }

  /// Vuelve a intentar reservar el código para alumnos.
  Future<void> reintentarCodigo() async {
    state = await ref.read(preparadorRepoProvider).activar();
  }

  Future<void> desactivar() async {
    await ref.read(preparadorRepoProvider).desactivar();
    state = ref.read(preparadorRepoProvider).perfil();
  }

  Future<void> renombrar(String nombre) async => state = await ref.read(preparadorRepoProvider).renombrar(nombre);
}

/// Perfil de preparador del usuario («Soy preparador», código para alumnos).
final perfilPreparadorProvider = NotifierProvider<PerfilPreparadorNotifier, PerfilPreparador>(PerfilPreparadorNotifier.new);

class AlumnosNotifier extends Notifier<List<Alumno>> {
  @override
  List<Alumno> build() => ref.read(preparadorRepoProvider).alumnos();

  Future<void> guardar(Alumno a) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.guardarAlumno(a);
    state = repo.alumnos();
  }

  Future<void> borrar(Alumno a) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.borrarAlumno(a);
    state = repo.alumnos();
  }

  /// Trae de la nube a los alumnos que han enlazado desde la última vez.
  Future<void> refrescar() async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.sincronizarTodo();
    state = repo.alumnos();
    // La sincronización puede haber reservado el código o traído el perfil de otro dispositivo.
    ref.invalidate(perfilPreparadorProvider);
    ref.invalidate(sesionesProvider);
  }
}

final alumnosProvider = NotifierProvider<AlumnosNotifier, List<Alumno>>(AlumnosNotifier.new);

/// Sesiones de cante del preparador con sus alumnos (son [Cante] con `alumno`).
class SesionesNotifier extends Notifier<List<Cante>> {
  @override
  List<Cante> build() => ref.read(preparadorRepoProvider).sesiones();

  Future<void> guardar(Cante s) => guardarVarias([s]);

  Future<void> guardarVarias(List<Cante> lista) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.guardarSesiones(lista);
    state = repo.sesiones();
  }

  Future<void> borrar(Cante s) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.borrarSesion(s);
    state = repo.sesiones();
  }
}

final sesionesProvider = NotifierProvider<SesionesNotifier, List<Cante>>(SesionesNotifier.new);

/// Próximas sesiones del preparador, de la más cercana a la más lejana.
final proximasSesionesProvider = Provider<List<Cante>>((ref) {
  final ahora = DateTime.now();
  return ref.watch(sesionesProvider).where((c) => c.pendiente && c.fecha.isAfter(ahora.subtract(const Duration(hours: 2)))).toList();
});

class MisPreparadoresNotifier extends Notifier<List<VinculoPreparador>> {
  @override
  List<VinculoPreparador> build() => ref.read(preparadorRepoProvider).misPreparadores();

  /// Enlaza con el preparador de ese código. Devuelve el mensaje de error, o null si ha ido bien.
  Future<String?> enlazar(String codigo) async {
    final repo = ref.read(preparadorRepoProvider);
    try {
      await repo.enlazarConCodigo(codigo);
      state = repo.misPreparadores();
      return null;
    } on ErrorEnlace catch (e) {
      return e.mensaje;
    }
  }

  Future<void> desenlazar(String preparador) async {
    final repo = ref.read(preparadorRepoProvider);
    await repo.desenlazar(preparador);
    state = repo.misPreparadores();
  }
}

/// Preparadores con los que el usuario comparte su progreso.
final misPreparadoresProvider = NotifierProvider<MisPreparadoresNotifier, List<VinculoPreparador>>(MisPreparadoresNotifier.new);

/// Progreso que comparte un alumno enlazado (null si no lo está o no hay red).
final progresoAlumnoProvider = FutureProvider.autoDispose.family<ProgresoAlumno?, String>((ref, idAlumno) async {
  final repo = ref.watch(preparadorRepoProvider);
  final alumno = repo.alumno(idAlumno);
  return alumno == null ? null : repo.progreso(alumno);
});
