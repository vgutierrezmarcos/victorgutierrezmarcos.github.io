import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../core/permiso_calendario.dart';
import '../models/oposicion.dart';
import '../models/cronograma.dart';
import '../models/plan.dart';
import 'calendario_google.dart';

/// Planificación del opositor: cantes, plan (convocatoria,
/// horario) y agenda por tema. Igual que [UsuarioRepo]: siempre en local
/// (Hive) y, si hay sesión, también en Firestore bajo users/{uid}.
class PlanRepo {
  PlanRepo({
    required Box cantes,
    required Box plan,
    required Box agenda,
    Box? cronogramas,
    this.oposicion = Oposiciones.tcee,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _cantes = cantes,
        _plan = plan,
        _agenda = agenda,
        _cronogramas = cronogramas,
        _db = firestore,
        _auth = auth;

  final Oposicion oposicion;
  final Box _cantes;
  final Box _plan;
  final Box _agenda;
  /// Sin caja (pruebas antiguas), los cronogramas viven en memoria.
  final Box? _cronogramas;
  final _cronogramasEnMemoria = <String, Map<dynamic, dynamic>>{};
  final FirebaseFirestore? _db;
  final FirebaseAuth? _auth;

  /// Google Calendar del propio opositor (lo pone la app al crear los
  /// servicios; sin él, o con [calendarioActivo] apagado, nada va al calendario).
  CalendarioGoogle? calendario;
  /// Si el opositor tiene activado «Mis cantes en Google Calendar» (lo lee de
  /// sus ajustes; lo pone la app).
  bool Function()? calendarioActivo;
  /// Se llama cuando el calendario cambia un cante (su evento o el enlace de
  /// Meet), para que la pantalla lo vuelva a leer.
  void Function()? alCambiarCantes;

  static Future<PlanRepo> crear({Oposicion oposicion = Oposiciones.tcee, FirebaseFirestore? firestore, FirebaseAuth? auth}) async => PlanRepo(
        oposicion: oposicion,
        cantes: await Hive.openBox(oposicion.caja(Cajas.cantes)),
        plan: await Hive.openBox(oposicion.caja(Cajas.plan)),
        agenda: await Hive.openBox(oposicion.caja(Cajas.agendaTemas)),
        cronogramas: await Hive.openBox(oposicion.caja(Cajas.cronogramas)),
        firestore: firestore,
        auth: auth,
      );

  DocumentReference<Map<String, dynamic>>? get _docUsuario {
    final uid = _auth?.currentUser?.uid;
    return uid == null || _db == null ? null : oposicion.raizUsuario(_db, uid);
  }

  // -------------------------------------------------------------------- Cantes

  /// Todos los cantes guardados, incluidos los borrados (para sincronizar).
  List<Cante> _todos() => _cantes.values.map((v) => Cante.fromJson(v as Map)).toList();

  /// Si existe el cante [id], aunque esté borrado (para no volver a crearlo).
  bool tieneCante(String id) => _cantes.containsKey(id);

  /// Cantes visibles, ordenados por fecha.
  List<Cante> cantes() => _todos().where((c) => !c.borrado).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));

  Future<void> guardarCante(Cante c) async {
    await _guardar(c);
    _alCalendario(c.id);
  }

  Future<void> _guardar(Cante c) async {
    await _cantes.put(c.id, c.toJson());
    try {
      await _docUsuario?.collection('cantes').doc(c.id).set(c.toJson());
    } catch (_) {
      // Sin red: se sube en la próxima sincronización.
    }
  }

  // ------------------------------------------------- Google Calendar del opositor

  bool get _conCalendario => calendario != null && (calendarioActivo?.call() ?? false);

  /// Al calendario en segundo plano: guardar no espera a Google.
  void _alCalendario(String id) {
    if (!_conCalendario) return;
    unawaited(llevarAlCalendario(id).then((cambio) {
      if (cambio) alCambiarCantes?.call();
    }));
  }

  /// Si el cante va al calendario del opositor: los suyos siempre; las clases
  /// de un preparador, solo si él no las lleva a su calendario (si las lleva,
  /// el alumno va invitado por correo y no hace falta otro evento).
  static bool vaAlCalendarioDelAlumno(Cante c) => !c.dePreparador || c.eventoGoogle.isEmpty;

  /// Cada envío espera al anterior del mismo cante (si no, un cante guardado
  /// dos veces seguidas podría crear dos eventos).
  final Map<String, Future<bool>> _colaCalendario = {};

  /// Lleva el cante [id] al Google Calendar del opositor (crea, cambia o
  /// borra su evento) y guarda el evento en [Cante.eventoGoogleAlumno]. Sin
  /// red o sin permiso no pasa nada: se reintenta al volver a guardarlo.
  /// Devuelve si ha cambiado el cante guardado.
  Future<bool> llevarAlCalendario(String id) {
    final previo = _colaCalendario[id] ?? Future.value(false);
    final f = previo.then((_) => _llevarAlCalendario(id));
    _colaCalendario[id] = f;
    return f.whenComplete(() {
      if (identical(_colaCalendario[id], f)) _colaCalendario.remove(id);
    });
  }

  Future<bool> _llevarAlCalendario(String id) async {
    final cal = calendario;
    final j = _cantes.get(id) as Map?;
    if (cal == null || j == null || !_conCalendario) return false;
    final c = Cante.fromJson(j);
    if (!vaAlCalendarioDelAlumno(c)) return false;
    final siglas = oposicion.siglas;
    final quien = (c.preparadorNombre ?? '').trim();
    final titulo = c.dePreparador ? 'Clase de $siglas${quien.isEmpty ? '' : ' con $quien'}' : 'Cante de $siglas';
    try {
      // El evento del opositor va aparte del del preparador.
      final nuevo = await cal.sincronizar(c.copyWith(eventoGoogle: c.eventoGoogleAlumno), siglas: siglas, titulo: titulo);
      if (nuevo == null) return false;
      // Sobre la última versión (por si ha cambiado mientras tanto): solo el
      // evento y, si no tenía, el enlace de la reunión.
      final ultimo = Cante.fromJson(_cantes.get(id) as Map? ?? j);
      final guardar = ultimo.copyWith(eventoGoogleAlumno: nuevo.eventoGoogle, enlace: ultimo.enlace.isEmpty ? nuevo.enlace : null);
      await _guardar(guardar);
      return true;
    } catch (e) {
      cal.ultimoError = permisoRetirado(e)
          ? 'Google ha retirado el permiso del calendario (o ha caducado): apaga y vuelve a encender «Mis cantes en Google Calendar» en Más → Ajustes.'
          : (e is DioException ? (e.response?.data?.toString() ?? e.message ?? e.type.name) : e.toString());
      return false;
    }
  }

  /// Al conectar el calendario: lleva todos los cantes pendientes que vienen.
  /// Devuelve cuántos se han llevado.
  Future<int> llevarCantesAlCalendario({DateTime? ahora}) async {
    final hoy = ahora ?? DateTime.now();
    var n = 0;
    for (final c in cantes().where((c) => c.pendiente && c.fecha.isAfter(hoy) && vaAlCalendarioDelAlumno(c))) {
      await llevarAlCalendario(c.id);
      if (Cante.fromJson(_cantes.get(c.id) as Map).eventoGoogleAlumno.isNotEmpty) n++;
    }
    return n;
  }

  Future<void> guardarCantes(Iterable<Cante> lista) async {
    for (final c in lista) {
      await guardarCante(c);
    }
  }

  /// Borrado lógico: el cante deja de verse y la baja llega a otros dispositivos.
  Future<void> borrarCante(Cante c) => guardarCante(c.copyWith(borrado: true));

  /// Devuelve si se pudo (sin red, false). Con [delServidor] no vale la
  /// caché: es lo que hace «Sincronizar ahora».
  Future<bool> sincronizarCantes({bool delServidor = false}) async {
    final doc = _docUsuario;
    if (doc == null) return true;
    try {
      final snap = await doc.collection('cantes').get(delServidor ? const GetOptions(source: Source.server) : null);
      final nube = {for (final d in snap.docs) d.id: Cante.fromJson({...d.data(), 'id': d.id})};
      final locales = {for (final c in _todos()) c.id: c};
      final nuevos = <String>[];
      for (final c in Cante.fusionar(locales.values, nube.values)) {
        final marca = c.updatedAt ?? DateTime(0);
        if (locales[c.id] == null || marca.isAfter(locales[c.id]!.updatedAt ?? DateTime(0))) {
          await _cantes.put(c.id, c.toJson());
          nuevos.add(c.id);
        }
        if (nube[c.id] == null || marca.isAfter(nube[c.id]!.updatedAt ?? DateTime(0))) await doc.collection('cantes').doc(c.id).set(c.toJson());
      }
      // Lo que llega de la nube (p. ej. las clases que copia el preparador)
      // también va al calendario del opositor.
      for (final id in nuevos) {
        _alCalendario(id);
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Las clases que programan los preparadores, en tiempo real (mientras la
  /// app está abierta): cada cambio llega al momento. Null sin sesión.
  Stream<List<Cante>>? escucharCantesDePreparadores() {
    final doc = _docUsuario;
    if (doc == null) return null;
    return doc
        .collection('cantes')
        .where('preparador', isNull: false)
        .snapshots()
        .map((snap) => [for (final d in snap.docs) Cante.fromJson({...d.data(), 'id': d.id})])
        .handleError((_) {});
  }

  /// Guarda en local los cantes de [nube] más recientes que los que hay.
  /// Devuelve cuántos han cambiado.
  Future<int> incorporar(List<Cante> nube) async {
    var n = 0;
    for (final c in nube) {
      final local = _cantes.get(c.id) as Map?;
      final marca = local == null ? null : Cante.fromJson(local).updatedAt;
      if (local == null || (c.updatedAt ?? DateTime(0)).isAfter(marca ?? DateTime(0))) {
        await _cantes.put(c.id, c.toJson());
        _alCalendario(c.id);
        n++;
      }
    }
    return n;
  }

  // ---------------------------------------------------------------------- Plan

  Plan plan() => Plan.fromJson(_plan.get('plan') as Map?);

  Future<void> guardarPlan(Plan p) async {
    await _plan.put('plan', p.toJson());
    try {
      await _docUsuario?.collection('progress').doc('plan').set(p.toJson());
    } catch (_) {}
  }

  /// Gana la versión más reciente (el plan se edita entero desde un dispositivo).
  Future<Plan> sincronizarPlan() async {
    final local = plan();
    final doc = _docUsuario;
    if (doc == null) return local;
    try {
      final snap = await doc.collection('progress').doc('plan').get();
      if (!snap.exists) {
        if (local.updatedAt != null) await guardarPlan(local);
        return local;
      }
      final nube = Plan.fromJson(snap.data());
      if ((nube.updatedAt ?? DateTime(0)).isAfter(local.updatedAt ?? DateTime(0))) {
        await _plan.put('plan', nube.toJson());
        return nube;
      }
      if ((local.updatedAt ?? DateTime(0)).isAfter(nube.updatedAt ?? DateTime(0))) await guardarPlan(local);
      return local;
    } catch (_) {
      return local;
    }
  }

  // ----------------------------------------------------------- Agenda por tema

  static String _idDoc(String codigoTema) => codigoTema.replaceAll('.', '_');

  AgendaTema agenda(String codigoTema) => AgendaTema.fromJson(codigoTema, _agenda.get(codigoTema) as Map?);

  /// Agendas con algún apunte o vuelta, por código de tema.
  Map<String, AgendaTema> agendas() => {
        for (final k in _agenda.keys) k.toString(): AgendaTema.fromJson(k.toString(), _agenda.get(k) as Map?),
      }..removeWhere((_, a) => a.vacia);

  Future<void> guardarAgenda(AgendaTema a) async {
    await _agenda.put(a.codigo, a.toJson());
    try {
      // merge: el mismo documento guarda también la nota libre del tema.
      await _docUsuario?.collection('notes').doc(_idDoc(a.codigo)).set(a.toJson(), SetOptions(merge: true));
    } catch (_) {}
  }

  Future<void> sincronizarAgendas() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('notes').get();
      final vistos = <String>{};
      for (final d in snap.docs) {
        final codigo = d.data()['tema'] as String? ?? d.id.replaceAll('_', '.');
        vistos.add(codigo);
        if (d.data()['pendientes'] == null && d.data()['vueltas'] == null && !_agenda.containsKey(codigo)) continue;
        final nube = AgendaTema.fromJson(codigo, d.data());
        final fusion = AgendaTema.fusionar(agenda(codigo), nube);
        await _agenda.put(codigo, fusion.toJson());
        String huella(AgendaTema a) => '${a.toJson()['pendientes']}${a.toJson()['vueltas']}';
        if (huella(fusion) != huella(nube)) await d.reference.set(fusion.toJson(), SetOptions(merge: true));
      }
      for (final k in _agenda.keys.map((k) => k.toString()).where((k) => !vistos.contains(k)).toList()) {
        await doc.collection('notes').doc(_idDoc(k)).set(agenda(k).toJson(), SetOptions(merge: true));
      }
    } catch (_) {}
  }

  // --------------------------------------------------------------- Cronogramas

  List<Cronograma> cronogramas() {
    final valores = _cronogramas?.values ?? _cronogramasEnMemoria.values;
    return [for (final v in valores) Cronograma.fromJson(v as Map)]..sort((a, b) => (b.creado ?? DateTime(0)).compareTo(a.creado ?? DateTime(0)));
  }

  /// El cronograma activo (solo hay uno; los demás están archivados).
  Cronograma? cronogramaActivo() => cronogramas().where((c) => !c.archivado).firstOrNull;

  Future<void> guardarCronograma(Cronograma c) async {
    if (_cronogramas != null) {
      await _cronogramas.put(c.id, c.toJson());
    } else {
      _cronogramasEnMemoria[c.id] = c.toJson();
    }
    try {
      await _docUsuario?.collection('cronogramas').doc(c.id).set(c.toJson());
    } catch (_) {}
  }

  /// Empieza un cronograma nuevo: el que hubiera activo pasa a archivado.
  Future<void> empezarCronograma(Cronograma c) async {
    for (final viejo in cronogramas().where((x) => !x.archivado && x.id != c.id)) {
      await guardarCronograma(viejo.copyWith(archivado: true));
    }
    await guardarCronograma(c);
  }

  /// Cronogramas que le han mandado sus preparadores y aún no ha aceptado ni
  /// rechazado (solo con cuenta y red).
  Future<List<CronogramaRecibido>> cronogramasRecibidos() async {
    final doc = _docUsuario;
    if (doc == null) return const [];
    try {
      final snap = await doc.collection('cronogramasRecibidos').get();
      // Los contestados se quedan para avisar al preparador; aquí, solo los pendientes.
      return [for (final d in snap.docs) if (CronogramaRecibido.fromJson({...d.data(), 'id': d.id}) case final r when r.pendiente) r]..sort((a, b) => b.enviado.compareTo(a.enviado));
    } catch (_) {
      return const [];
    }
  }

  /// Acepta un cronograma recibido: pasa a ser el activo (el anterior se
  /// archiva), compartido con el preparador que lo mandó.
  Future<Cronograma> aceptarCronogramaRecibido(CronogramaRecibido r) async {
    final c = Cronograma.fromJson({
      ...r.cronograma.toJson(),
      'id': nuevoId(),
      'archivado': false,
      'compartir': true,
      // Consta quién lo hizo (con varios preparadores, para saber de quién es).
      'autor': r.de,
      'autorNombre': r.deNombre,
      'creado': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
    await empezarCronograma(c);
    await _responderRecibido(r, 'aceptado');
    return c;
  }

  Future<void> rechazarCronogramaRecibido(CronogramaRecibido r) => _responderRecibido(r, 'rechazado');

  /// El recibido se queda con la respuesta (no se borra): así se avisa al
  /// preparador de que lo ha aceptado o rechazado.
  Future<void> _responderRecibido(CronogramaRecibido r, String respuesta) async {
    // Con plazo: sin red, mejor decirlo que quedarse esperando.
    await _docUsuario?.collection('cronogramasRecibidos').doc(r.cronograma.id).set({'respuesta': respuesta, 'respondido': DateTime.now().toIso8601String()}, SetOptions(merge: true)).timeout(const Duration(seconds: 20));
  }

  Future<void> sincronizarCronogramas() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('cronogramas').get();
      final nube = {for (final d in snap.docs) d.id: Cronograma.fromJson({...d.data(), 'id': d.id})};
      final locales = {for (final c in cronogramas()) c.id: c};
      for (final id in {...nube.keys, ...locales.keys}) {
        final n = nube[id], l = locales[id];
        final f = n == null ? l! : (l == null ? n : Cronograma.fusionar(l, n));
        if (l == null || jsonEncode(f.toJson()) != jsonEncode(l.toJson())) {
          _cronogramas != null ? await _cronogramas.put(id, f.toJson()) : _cronogramasEnMemoria[id] = f.toJson();
        }
        if (n == null || jsonEncode(f.toJson()) != jsonEncode(n.toJson())) await doc.collection('cronogramas').doc(id).set(f.toJson());
      }
    } catch (_) {}
  }

  // ------------------------------------------------------------------- General

  /// Devuelve si los cantes se pudieron sincronizar (lo demás se intenta igual).
  Future<bool> sincronizarTodo({bool delServidor = false}) async {
    final ok = await sincronizarCantes(delServidor: delServidor);
    await sincronizarPlan();
    await sincronizarAgendas();
    await sincronizarCronogramas();
    return ok;
  }

  Future<void> borrarDatosLocales() async {
    await Future.wait([_cantes.clear(), _plan.clear(), _agenda.clear(), if (_cronogramas != null) _cronogramas.clear()]);
    _cronogramasEnMemoria.clear();
  }

  /// Datos para la exportación en JSON (portabilidad RGPD).
  Map<String, dynamic> exportar() => {
        'cantes': cantes().map((c) => c.toJson()).toList(),
        'plan': plan().toJson(),
        'agendaTemas': agendas().map((k, a) => MapEntry(k, a.toJson())),
        'cronogramas': cronogramas().map((c) => c.toJson()).toList(),
      };
}
