import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/plan.dart';
import '../data/models/red.dart';
import '../data/repos/red_repo.dart';
import 'avisos_fondo.dart';
import 'avisos_red.dart';
import 'providers.dart';

/// Red de preparadores: verificación, sustituciones, huecos y reservas.
final redRepoProvider = Provider<RedRepo>((ref) {
  final firebase = ref.watch(serviciosProvider).firebaseDisponible;
  return firebase ? RedRepo(firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance) : RedRepo();
});

/// Situación del usuario en la red.
class EstadoRed {
  const EstadoRed({this.diagnostico = DiagnosticoAdmin.no, this.verificacion, this.solicitud});
  final DiagnosticoAdmin diagnostico;
  bool get esAdmin => diagnostico == DiagnosticoAdmin.si;
  final PreparadorVerificado? verificacion;
  final SolicitudPreparador? solicitud;
  bool get verificado => verificacion != null;
}

final estadoRedProvider = FutureProvider<EstadoRed>((ref) async {
  ref.watch(usuarioActualProvider);
  final red = ref.watch(redRepoProvider);
  if (!red.conSesion) return const EstadoRed();
  try {
    final diagnostico = await red.diagnosticoAdmin();
    PreparadorVerificado? v;
    SolicitudPreparador? sol;
    try {
      v = await red.miVerificacion();
      sol = await red.miSolicitud();
    } catch (_) {}
    return EstadoRed(diagnostico: diagnostico, verificacion: v, solicitud: sol);
  } catch (_) {
    return const EstadoRed(diagnostico: DiagnosticoAdmin.sinRed);
  }
});

/// Lo que se pide a la red y puede fallar sin red: devuelve vacío.
Future<List<T>> _seguro<T>(Future<List<T>> Function() f) async {
  try {
    return await f();
  } catch (_) {
    return const [];
  }
}

final verificadosProvider = FutureProvider<List<PreparadorVerificado>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(ref.watch(redRepoProvider).verificados);
});

final verificadosConRetiradosProvider = FutureProvider<List<PreparadorVerificado>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(() => ref.watch(redRepoProvider).verificados(incluirRetirados: true));
});

final solicitudesPendientesProvider = FutureProvider<List<SolicitudPreparador>>((ref) async {
  final e = await ref.watch(estadoRedProvider.future);
  if (!e.verificado && !e.esAdmin) return const [];
  return _seguro(() => ref.watch(redRepoProvider).solicitudesPendientes(admin: e.esAdmin));
});

final tablonProvider = FutureProvider<List<Sustitucion>>((ref) async {
  final e = await ref.watch(estadoRedProvider.future);
  if (!e.verificado) return const [];
  return _seguro(ref.watch(redRepoProvider).tablon);
});

final cogidasPorMiProvider = FutureProvider<List<Sustitucion>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(ref.watch(redRepoProvider).cogidasPorMi);
});

final misPeticionesProvider = FutureProvider<List<Sustitucion>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(ref.watch(redRepoProvider).misPeticiones);
});

final reservasRecibidasProvider = FutureProvider<List<Reserva>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(ref.watch(redRepoProvider).reservasRecibidas);
});

final misReservasProvider = FutureProvider<List<Reserva>>((ref) {
  ref.watch(usuarioActualProvider);
  return _seguro(ref.watch(redRepoProvider).misReservas);
});

/// Huecos que publica un preparador para sus alumnos.
final huecosDeProvider = FutureProvider.family<HuecosPublicos?, String>((ref, preparador) async {
  try {
    return await ref.watch(redRepoProvider).huecosDe(preparador);
  } catch (_) {
    return null;
  }
});

/// Petición de sustitución que sale de un cante del alumno (la última no cancelada).
final peticionDeCanteProvider = Provider.family<Sustitucion?, String>((ref, cante) {
  final todas = ref.watch(misPeticionesProvider).value ?? const [];
  return todas.where((s) => s.cante == cante && s.estado != EstadoSustitucion.cancelada).firstOrNull;
});

/// Vuelve a pedir a la red todo lo que se muestra.
void refrescarRed(Ref ref) {
  for (final p in <ProviderOrFamily>[estadoRedProvider, verificadosProvider, verificadosConRetiradosProvider, solicitudesPendientesProvider, tablonProvider, cogidasPorMiProvider, misPeticionesProvider, reservasRecibidasProvider, misReservasProvider, huecosDeProvider]) {
    ref.invalidate(p);
  }
}

/// Parte de la sincronización que toca la red: lo hace [sincronizarTodo].
///  - Alumno: las sustituciones que alguien ha cogido pasan a su agenda.
///  - Preparador: genera las sesiones de las clases fijas y publica sus huecos.
///  - Todos: notifica lo nuevo y deja programada la comprobación en segundo plano.
Future<void> sincronizarRed(Ref ref) async {
  final red = ref.read(redRepoProvider);
  final preparador = ref.read(preparadorRepoProvider);
  final plan = ref.read(planRepoProvider);
  final perfil = preparador.perfil();
  if (perfil.activo) await preparador.generarClasesFijas();
  if (!red.conSesion) return;
  try {
    for (final s in await red.misPeticiones()) {
      if (!s.cogida || plan.cantes().any((c) => c.id == 'sust_${s.id}')) continue;
      final contacto = await red.contacto(s.id, 'preparador');
      final c = s.canteDelAlumno(nombreSustituto: contacto?.nombre);
      await plan.guardarCante(c.copyWith(notas: [if (s.notas.isNotEmpty) s.notas, if (contacto != null) 'Contacto: ${contacto.nombre} · ${contacto.telefono}'].join('\n')));
    }
  } catch (_) {}
  final estado = await ref.read(estadoRedProvider.future);
  if (estado.verificado && perfil.activo) {
    try {
      final ahora = DateTime.now();
      final ocupadas = preparador.sesiones().where((s) => s.pendiente && s.fecha.isAfter(ahora) && s.fecha.isBefore(ahora.add(const Duration(days: 60))));
      await red.publicarHuecos(HuecosPublicos(
        preparador: red.uid!,
        nombre: perfil.nombre,
        activo: perfil.reservas,
        huecos: perfil.reservas ? perfil.huecos : const [],
        ocupados: [for (final s in ocupadas) (inicio: s.fecha, minutos: s.minutos)],
      ));
    } catch (_) {}
  }
  await comprobarAvisosRed(red, preparador: estado.verificado && perfil.activo && perfil.avisosSustitucion, admin: estado.esAdmin);
  await programarAvisosEnSegundoPlano(activar: true);
  refrescarRed(ref);
}

/// Color de una persona (alumno o preparador) para distinguirla en agendas y calendarios.
const coloresPersonas = [0xFF2E7D9A, 0xFFC0662B, 0xFF3C8D4E, 0xFFB8436A, 0xFF7A5C2E, 0xFF4F5FB5, 0xFF8E8E2B, 0xFF2B8C83];

int colorDePersona(String clave) {
  var h = 0;
  for (final c in clave.codeUnits) {
    h = (h * 31 + c) & 0x7fffffff;
  }
  return coloresPersonas[h % coloresPersonas.length];
}

/// Cante del alumno según quién lo da: el preparador (uid), una sustitución o él mismo.
String origenDeCante(Cante c) => c.preparador ?? (c.sustitucion != null ? 'sustitucion' : 'propio');
