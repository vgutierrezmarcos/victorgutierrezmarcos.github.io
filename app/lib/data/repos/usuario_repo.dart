import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../features/test/leitner.dart';
import '../models/resultado.dart';

/// Ajustes del usuario (locales y, con sesión, en users/{uid}/progress/settings).
class Ajustes {
  const Ajustes({
    this.fechaConvocatoria,
    this.temasEstudiados = const {},
    this.temasEnRepaso = const {},
    this.racha = 0,
    this.mejorRacha = 0,
    this.ultimoDia,
    this.horaRecordatorio = 20 * 60, // minutos desde medianoche; -1 = desactivado
    this.temaOscuro, // null = sistema
    this.temasExtraidos = 3,
    this.updatedAt,
  });

  final DateTime? fechaConvocatoria;
  final Set<String> temasEstudiados;
  final Set<String> temasEnRepaso;
  final int racha;
  final int mejorRacha;
  /// Día (yyyy-mm-dd) de la última actividad que cuenta para la racha.
  final String? ultimoDia;
  final int horaRecordatorio;
  final bool? temaOscuro;
  /// Nº de temas que se extraen en el sorteo real.
  final int temasExtraidos;
  final DateTime? updatedAt;

  Ajustes copyWith({
    DateTime? fechaConvocatoria,
    bool borrarFecha = false,
    Set<String>? temasEstudiados,
    Set<String>? temasEnRepaso,
    int? racha,
    int? mejorRacha,
    String? ultimoDia,
    int? horaRecordatorio,
    bool? temaOscuro,
    bool borrarTema = false,
    int? temasExtraidos,
    DateTime? updatedAt,
  }) =>
      Ajustes(
        fechaConvocatoria: borrarFecha ? null : (fechaConvocatoria ?? this.fechaConvocatoria),
        temasEstudiados: temasEstudiados ?? this.temasEstudiados,
        temasEnRepaso: temasEnRepaso ?? this.temasEnRepaso,
        racha: racha ?? this.racha,
        mejorRacha: mejorRacha ?? this.mejorRacha,
        ultimoDia: ultimoDia ?? this.ultimoDia,
        horaRecordatorio: horaRecordatorio ?? this.horaRecordatorio,
        temaOscuro: borrarTema ? null : (temaOscuro ?? this.temaOscuro),
        temasExtraidos: temasExtraidos ?? this.temasExtraidos,
        updatedAt: updatedAt ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'fechaConvocatoria': fechaConvocatoria?.toIso8601String(),
        'temasEstudiados': temasEstudiados.toList()..sort(),
        'temasEnRepaso': temasEnRepaso.toList()..sort(),
        'racha': racha,
        'mejorRacha': mejorRacha,
        'ultimoDia': ultimoDia,
        'horaRecordatorio': horaRecordatorio,
        'temaOscuro': temaOscuro,
        'temasExtraidos': temasExtraidos,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Ajustes.fromJson(Map<dynamic, dynamic>? j) {
    if (j == null) return const Ajustes();
    DateTime? f(String? s) => s == null ? null : DateTime.tryParse(s);
    return Ajustes(
      fechaConvocatoria: f(j['fechaConvocatoria'] as String?),
      temasEstudiados: ((j['temasEstudiados'] as List?) ?? []).map((e) => e.toString()).toSet(),
      temasEnRepaso: ((j['temasEnRepaso'] as List?) ?? []).map((e) => e.toString()).toSet(),
      racha: (j['racha'] as num?)?.toInt() ?? 0,
      mejorRacha: (j['mejorRacha'] as num?)?.toInt() ?? 0,
      ultimoDia: j['ultimoDia'] as String?,
      horaRecordatorio: (j['horaRecordatorio'] as num?)?.toInt() ?? 20 * 60,
      temaOscuro: j['temaOscuro'] as bool?,
      temasExtraidos: (j['temasExtraidos'] as num?)?.toInt() ?? 3,
      updatedAt: f(j['updatedAt'] as String?),
    );
  }

  static String claveDia(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// Actualiza la racha con actividad hoy.
  Ajustes conActividadHoy([DateTime? ahora]) {
    final hoy = ahora ?? DateTime.now();
    final claveHoy = claveDia(hoy);
    if (ultimoDia == claveHoy) return this;
    final ayer = claveDia(hoy.subtract(const Duration(days: 1)));
    final nueva = ultimoDia == ayer ? racha + 1 : 1;
    return copyWith(racha: nueva, mejorRacha: nueva > mejorRacha ? nueva : mejorRacha, ultimoDia: claveHoy);
  }

  /// Racha vigente (0 si se rompió ayer).
  int rachaVigente([DateTime? ahora]) {
    final hoy = ahora ?? DateTime.now();
    if (ultimoDia == claveDia(hoy) || ultimoDia == claveDia(hoy.subtract(const Duration(days: 1)))) return racha;
    return 0;
  }
}

/// Datos del usuario: resultados, Leitner, ajustes y notas.
/// Siempre se guardan en local (Hive); si hay sesión, también en Firestore
/// bajo users/{uid}, con el mismo esquema que la web.
class UsuarioRepo {
  UsuarioRepo({
    required Box resultados,
    required Box leitner,
    required Box ajustes,
    required Box notas,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _resultados = resultados,
        _leitner = leitner,
        _ajustes = ajustes,
        _notas = notas,
        _db = firestore,
        _auth = auth;

  final Box _resultados;
  final Box _leitner;
  final Box _ajustes;
  final Box _notas;
  final FirebaseFirestore? _db;
  final FirebaseAuth? _auth;

  static Future<UsuarioRepo> crear({FirebaseFirestore? firestore, FirebaseAuth? auth}) async => UsuarioRepo(
        resultados: await Hive.openBox(Cajas.resultados),
        leitner: await Hive.openBox(Cajas.leitner),
        ajustes: await Hive.openBox(Cajas.ajustes),
        notas: await Hive.openBox(Cajas.notas),
        firestore: firestore,
        auth: auth,
      );

  String? get uid => _auth?.currentUser?.uid;
  bool get conSesion => uid != null;

  DocumentReference<Map<String, dynamic>>? get _docUsuario =>
      uid == null || _db == null ? null : _db.collection('users').doc(uid);

  // ---------------------------------------------------------------- Resultados

  Future<void> guardarResultado(ResultadoTest r) async {
    await _resultados.put(r.id, r.toLocal());
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final ref = await doc.collection('exam_results').add({
        'timestamp': FieldValue.serverTimestamp(),
        ...r.toFirestore(),
      });
      await _resultados.delete(r.id);
      await _resultados.put(ref.id, r.copyWith(sincronizado: true, id: ref.id).toLocal());
    } catch (_) {
      // Sin red: queda pendiente; se reintenta en sincronizarPendientes().
    }
  }

  List<ResultadoTest> resultadosLocales() {
    final out = _resultados.values
        .map((v) => ResultadoTest.fromMap((v as Map)['id'].toString(), v))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return out;
  }

  /// Historial unificado: resultados en la nube (web + app) fusionados con los
  /// locales aún no sincronizados.
  Future<List<ResultadoTest>> historial({int limite = 200}) async {
    final locales = resultadosLocales();
    final doc = _docUsuario;
    if (doc == null) return locales;
    try {
      final snap = await doc.collection('exam_results').orderBy('timestamp', descending: true).limit(limite).get();
      final nube = snap.docs.map((d) {
        final data = d.data();
        final ts = (data['timestamp'] as Timestamp?)?.toDate();
        return ResultadoTest.fromMap(d.id, data, ts: ts);
      }).toList();
      final idsNube = nube.map((e) => e.id).toSet();
      final pendientes = locales.where((l) => !l.sincronizado && !idsNube.contains(l.id));
      final todo = [...nube, ...pendientes]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return todo;
    } catch (_) {
      return locales;
    }
  }

  Future<void> sincronizarPendientes() async {
    final doc = _docUsuario;
    if (doc == null) return;
    for (final r in resultadosLocales().where((r) => !r.sincronizado)) {
      try {
        final ref = await doc.collection('exam_results').add({
          'timestamp': Timestamp.fromDate(r.timestamp),
          ...r.toFirestore(),
        });
        await _resultados.delete(r.id);
        await _resultados.put(ref.id, r.copyWith(sincronizado: true, id: ref.id).toLocal());
      } catch (_) {
        return;
      }
    }
  }

  Future<void> borrarHistorial() async {
    await _resultados.clear();
    final doc = _docUsuario;
    if (doc == null) return;
    final snap = await doc.collection('exam_results').get();
    final batch = _db!.batch();
    for (final d in snap.docs) {
      batch.delete(d.reference);
    }
    await batch.commit();
  }

  // ---------------------------------------------------------------- Leitner

  EstadoLeitner leitner() => EstadoLeitner.fromJson(_leitner.get('estado') as Map?);

  Future<void> guardarLeitner(EstadoLeitner e) async {
    await _leitner.put('estado', e.toJson());
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      await doc.collection('progress').doc('spaced_repetition').set({
        ...e.toJson(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }

  /// Fusiona el Leitner de la nube con el local (al iniciar sesión / arrancar).
  Future<EstadoLeitner> sincronizarLeitner() async {
    final local = leitner();
    final doc = _docUsuario;
    if (doc == null) return local;
    try {
      final snap = await doc.collection('progress').doc('spaced_repetition').get();
      if (!snap.exists) {
        await guardarLeitner(local);
        return local;
      }
      final nube = EstadoLeitner.fromJson(snap.data());
      final fusion = EstadoLeitner.fusionar(local, nube);
      await guardarLeitner(fusion);
      return fusion;
    } catch (_) {
      return local;
    }
  }

  // ---------------------------------------------------------------- Ajustes

  Ajustes ajustes() => Ajustes.fromJson(_ajustes.get('ajustes') as Map?);

  Future<void> guardarAjustes(Ajustes a) async {
    await _ajustes.put('ajustes', a.toJson());
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      await doc.collection('progress').doc('settings').set(a.toJson(), SetOptions(merge: true));
    } catch (_) {}
  }

  Future<Ajustes> sincronizarAjustes() async {
    final local = ajustes();
    final doc = _docUsuario;
    if (doc == null) return local;
    try {
      final snap = await doc.collection('progress').doc('settings').get();
      if (!snap.exists) {
        await guardarAjustes(local);
        return local;
      }
      final nube = Ajustes.fromJson(snap.data());
      final ganador = (nube.updatedAt ?? DateTime(0)).isAfter(local.updatedAt ?? DateTime(0)) ? nube : local;
      // Los conjuntos de temas se unen para no perder marcas de ningún dispositivo.
      final fusion = ganador.copyWith(
        temasEstudiados: {...local.temasEstudiados, ...nube.temasEstudiados},
        temasEnRepaso: {...local.temasEnRepaso, ...nube.temasEnRepaso},
        racha: local.racha > nube.racha ? local.racha : nube.racha,
        mejorRacha: local.mejorRacha > nube.mejorRacha ? local.mejorRacha : nube.mejorRacha,
      );
      await _ajustes.put('ajustes', fusion.toJson());
      return fusion;
    } catch (_) {
      return local;
    }
  }

  // ---------------------------------------------------------------- Notas

  String nota(String codigoTema) => (_notas.get(codigoTema) as String?) ?? '';

  Map<String, String> todasLasNotas() =>
      {for (final k in _notas.keys) k.toString(): (_notas.get(k) as String?) ?? ''};

  Future<void> guardarNota(String codigoTema, String texto) async {
    if (texto.trim().isEmpty) {
      await _notas.delete(codigoTema);
    } else {
      await _notas.put(codigoTema, texto);
    }
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final ref = doc.collection('notes').doc(codigoTema.replaceAll('.', '_'));
      if (texto.trim().isEmpty) {
        await ref.delete();
      } else {
        await ref.set({'tema': codigoTema, 'texto': texto, 'updatedAt': FieldValue.serverTimestamp()});
      }
    } catch (_) {}
  }

  Future<void> sincronizarNotas() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('notes').get();
      for (final d in snap.docs) {
        final tema = d.data()['tema'] as String? ?? d.id.replaceAll('_', '.');
        if (!_notas.containsKey(tema)) await _notas.put(tema, d.data()['texto'] as String? ?? '');
      }
      for (final e in todasLasNotas().entries) {
        final id = e.key.replaceAll('.', '_');
        if (!snap.docs.any((d) => d.id == id)) {
          await doc.collection('notes').doc(id).set({'tema': e.key, 'texto': e.value, 'updatedAt': FieldValue.serverTimestamp()});
        }
      }
    } catch (_) {}
  }

  /// Sincronización completa tras iniciar sesión o al arrancar con sesión.
  Future<void> sincronizarTodo() async {
    await sincronizarPendientes();
    await sincronizarLeitner();
    await sincronizarAjustes();
    await sincronizarNotas();
  }

  /// Borra todos los datos locales (cerrar sesión no los borra; esto es explícito).
  Future<void> borrarDatosLocales() async {
    await Future.wait([_resultados.clear(), _leitner.clear(), _ajustes.clear(), _notas.clear()]);
  }

  /// Exporta todo en JSON (portabilidad RGPD).
  String exportarJson() => const JsonEncoder.withIndent('  ').convert({
        'resultados': resultadosLocales().map((r) => r.toLocal()).toList(),
        'leitner': leitner().toJson(),
        'ajustes': ajustes().toJson(),
        'notas': todasLasNotas(),
      });
}
