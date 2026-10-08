import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/oposicion.dart';
import '../data/models/plan.dart';
import '../data/models/red.dart';
import '../data/repos/red_repo.dart';
import 'avisos_fondo.dart';
import 'avisos_red.dart';
import 'providers.dart';

/// Red de preparadores: verificación, sustituciones, huecos y reservas.
final redRepoProvider = Provider<RedRepo>((ref) {
  final firebase = ref.watch(serviciosProvider).firebaseDisponible;
  final oposicion = ref.watch(oposicionProvider);
  return firebase ? RedRepo(firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance, oposicion: oposicion) : RedRepo(oposicion: oposicion);
});

/// Oposiciones que puede elegir el usuario: las lanzadas, la que tiene
/// abierta y las aún sin lanzar de las que es administrador (o todas, si es el
/// administrador general), para probarlas.
final oposicionesVisiblesProvider = FutureProvider<List<Oposicion>>((ref) async {
  final actual = ref.watch(oposicionProvider);
  ref.watch(usuarioActualProvider);
  final red = ref.watch(redRepoProvider);
  final visibles = [...Oposiciones.disponibles];
  for (final o in Oposiciones.sinLanzar) {
    if (o.id == actual.id || await red.esAdminEn(o).catchError((_) => false)) visibles.add(o);
  }
  if (!visibles.any((o) => o.id == actual.id)) visibles.add(actual);
  return [for (final o in Oposiciones.todas) if (visibles.any((v) => v.id == o.id)) o];
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

/// Lo que busca el opositor (la más reciente abierta, o null).
final miBusquedaProvider = FutureProvider<Busqueda?>((ref) async {
  ref.watch(usuarioActualProvider);
  final lista = await _seguro(ref.watch(redRepoProvider).misBusquedas);
  return lista.where((b) => b.abierta).firstOrNull;
});

/// Preparadores interesados en la búsqueda del opositor.
final interesadosProvider = FutureProvider.family<List<Interesado>, String>((ref, busqueda) {
  ref.watch(usuarioActualProvider);
  return _seguro(() => ref.watch(redRepoProvider).interesados(busqueda));
});

/// Plazas del preparador (las suyas; null si nunca las ha puesto).
final misPlazasProvider = FutureProvider<Plazas?>((ref) async {
  final e = await ref.watch(estadoRedProvider.future);
  if (!e.verificado) return null;
  try {
    return await ref.watch(redRepoProvider).misPlazas();
  } catch (_) {
    return null;
  }
});

/// Para el opositor: preparadores verificados que admiten alumnos, con su
/// ficha y sus plazas, ordenados por compatibilidad con lo que busca (si ha
/// publicado algo) o, si no, por nombre.
final preparadoresConPlazasProvider = FutureProvider<List<(PreparadorVerificado, Plazas, int)>>((ref) async {
  ref.watch(usuarioActualProvider);
  final red = ref.watch(redRepoProvider);
  final verificados = await ref.watch(verificadosProvider.future);
  final plazas = await _seguro(red.plazasAbiertas);
  final busqueda = await ref.watch(miBusquedaProvider.future);
  final out = <(PreparadorVerificado, Plazas, int)>[];
  for (final p in plazas) {
    final v = verificados.where((v) => v.uid == p.preparador).firstOrNull;
    if (v == null || v.uid == red.uid) continue;
    out.add((v, p, busqueda == null ? -1 : compatibilidad(busqueda, v, plazas: p)));
  }
  out.sort((a, b) => b.$3 != a.$3 ? b.$3.compareTo(a.$3) : a.$1.nombre.toLowerCase().compareTo(b.$1.nombre.toLowerCase()));
  return out;
});

/// Para el preparador: lo que buscan los opositores, con la compatibilidad
/// con su ficha y sus plazas, y si ya se ha interesado.
final busquedasProvider = FutureProvider<List<(Busqueda, int, bool)>>((ref) async {
  final e = await ref.watch(estadoRedProvider.future);
  if (!e.verificado) return const [];
  final red = ref.watch(redRepoProvider);
  final lista = await _seguro(red.busquedasAbiertas);
  final plazas = await ref.watch(misPlazasProvider.future);
  final mios = await red.misIntereses(lista.map((b) => b.id));
  final out = [for (final b in lista) (b, compatibilidad(b, e.verificacion!, plazas: plazas), mios.contains(b.id))];
  out.sort((a, b) => b.$2 != a.$2 ? b.$2.compareTo(a.$2) : (b.$1.creada ?? DateTime(0)).compareTo(a.$1.creada ?? DateTime(0)));
  return out;
});

/// Grupo en el que sale cada preparador en el directorio.
enum GrupoDirectorio { mios, conClase, autoverificados, resto }

/// Directorio ordenado para el usuario: primero sus preparadores, luego con
/// los que ya ha tenido clase (fueron su preparador o le cogieron una clase
/// suelta), luego los autoverificados (quienes administran la red, sin
/// llamarlos así) y el resto al azar (mismo orden mientras dura la sesión).
final directorioOrdenadoProvider = Provider<List<(GrupoDirectorio, PreparadorVerificado)>>((ref) {
  final lista = ref.watch(verificadosProvider).valueOrNull ?? const <PreparadorVerificado>[];
  final yo = ref.watch(usuarioActualProvider)?.uid;
  final mios = {for (final v in ref.watch(misPreparadoresProvider)) v.uid};
  final conClase = {
    for (final c in ref.watch(cantesProvider)) if (c.preparador != null && !c.borrado) c.preparador!,
    for (final s in ref.watch(misPeticionesProvider).valueOrNull ?? const <Sustitucion>[]) if (s.cogidaPor != null) s.cogidaPor!,
  }..removeAll(mios);
  GrupoDirectorio grupo(PreparadorVerificado v) {
    if (mios.contains(v.uid)) return GrupoDirectorio.mios;
    if (conClase.contains(v.uid)) return GrupoDirectorio.conClase;
    if (v.avaladoPor == v.uid) return GrupoDirectorio.autoverificados;
    return GrupoDirectorio.resto;
  }

  final semilla = ref.watch(semillaDirectorioProvider);
  final porGrupo = <GrupoDirectorio, List<PreparadorVerificado>>{};
  for (final v in lista) {
    if (v.uid == yo) continue;
    porGrupo.putIfAbsent(grupo(v), () => []).add(v);
  }
  final out = <(GrupoDirectorio, PreparadorVerificado)>[];
  for (final g in GrupoDirectorio.values) {
    final vs = porGrupo[g] ?? const [];
    final ordenados = g == GrupoDirectorio.resto ? (List.of(vs)..shuffle(Random(semilla))) : (List.of(vs)..sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase())));
    out.addAll(ordenados.map((v) => (g, v)));
  }
  return out;
});

/// Semilla del orden al azar del directorio: cambia en cada arranque de la app.
final semillaDirectorioProvider = Provider<int>((ref) => Random().nextInt(1 << 30));

/// Materiales que ha compartido el preparador con sus alumnos.
final misMaterialesProvider = FutureProvider<List<MaterialCompartido>>((ref) async {
  final e = await ref.watch(estadoRedProvider.future);
  if (!e.verificado) return const [];
  return _seguro(ref.watch(redRepoProvider).misMateriales);
});

/// Materiales que los preparadores del alumno le han compartido.
final materialesParaMiProvider = FutureProvider<List<MaterialCompartido>>((ref) {
  ref.watch(usuarioActualProvider);
  final vinculos = ref.watch(misPreparadoresProvider);
  if (vinculos.isEmpty) return Future.value(const []);
  return _seguro(() => ref.watch(redRepoProvider).materialesParaMi(preparadores: vinculos.map((v) => v.uid)));
});

/// Los materiales de un tema concreto.
final materialesDeTemaProvider = Provider.family<List<MaterialCompartido>, String>((ref, codigo) {
  return (ref.watch(materialesParaMiProvider).valueOrNull ?? const []).where((m) => m.tema == codigo).toList();
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
  final todas = ref.watch(misPeticionesProvider).valueOrNull ?? const [];
  return todas.where((s) => s.cante == cante && s.estado != EstadoSustitucion.cancelada).firstOrNull;
});

/// Vuelve a pedir a la red todo lo que se muestra.
void refrescarRed(Ref ref) {
  for (final p in <ProviderOrFamily>[estadoRedProvider, verificadosProvider, verificadosConRetiradosProvider, solicitudesPendientesProvider, tablonProvider, cogidasPorMiProvider, misPeticionesProvider, reservasRecibidasProvider, misReservasProvider, huecosDeProvider, misMaterialesProvider, materialesParaMiProvider, miBusquedaProvider, interesadosProvider, misPlazasProvider, preparadoresConPlazasProvider, busquedasProvider]) {
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
  await comprobarAvisosRed(red, preparador: estado.verificado && perfil.activo && perfil.avisosSustitucion, reservas: estado.verificado && perfil.activo && perfil.avisosReservas, admin: estado.esAdmin);
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
String origenDeCante(Cante c) => c.sustitucion != null ? 'sustitucion' : (c.preparador ?? 'propio');

/// Lo que espera al preparador: reservas por confirmar, clases sueltas en el
/// tablón y solicitudes de verificación por revisar.
final pendientesPreparadorProvider = Provider<int>((ref) {
  final ahora = DateTime.now();
  final reservas = (ref.watch(reservasRecibidasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(ahora)).length;
  return reservas + (ref.watch(tablonProvider).valueOrNull?.length ?? 0) + (ref.watch(solicitudesPendientesProvider).valueOrNull?.length ?? 0) + (ref.watch(busquedasProvider).valueOrNull?.where((b) => !b.$3 && b.$2 > 0).length ?? 0);
});
