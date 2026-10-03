import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../models/oposicion.dart';
import '../models/cronograma.dart';
import '../models/plan.dart';

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

  /// Cantes visibles, ordenados por fecha.
  List<Cante> cantes() => _todos().where((c) => !c.borrado).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));

  Future<void> guardarCante(Cante c) async {
    await _cantes.put(c.id, c.toJson());
    try {
      await _docUsuario?.collection('cantes').doc(c.id).set(c.toJson());
    } catch (_) {
      // Sin red: se sube en la próxima sincronización.
    }
  }

  Future<void> guardarCantes(Iterable<Cante> lista) async {
    for (final c in lista) {
      await guardarCante(c);
    }
  }

  /// Borrado lógico: el cante deja de verse y la baja llega a otros dispositivos.
  Future<void> borrarCante(Cante c) => guardarCante(c.copyWith(borrado: true));

  Future<void> sincronizarCantes() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('cantes').get();
      final nube = {for (final d in snap.docs) d.id: Cante.fromJson({...d.data(), 'id': d.id})};
      final locales = {for (final c in _todos()) c.id: c};
      for (final c in Cante.fusionar(locales.values, nube.values)) {
        final marca = c.updatedAt ?? DateTime(0);
        if (locales[c.id] == null || marca.isAfter(locales[c.id]!.updatedAt ?? DateTime(0))) await _cantes.put(c.id, c.toJson());
        if (nube[c.id] == null || marca.isAfter(nube[c.id]!.updatedAt ?? DateTime(0))) await doc.collection('cantes').doc(c.id).set(c.toJson());
      }
    } catch (_) {}
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

  Future<void> sincronizarTodo() async {
    await sincronizarCantes();
    await sincronizarPlan();
    await sincronizarAgendas();
    await sincronizarCronogramas();
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
