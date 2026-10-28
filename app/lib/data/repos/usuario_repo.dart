import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../models/temas_clase.dart';
import '../models/oposicion.dart';
import '../../features/test/leitner.dart';
import '../../features/test/motor_test.dart' show TestEnCurso;
import '../models/resultado.dart';
import '../models/reto.dart';

/// Ajustes del usuario (locales y, con sesión, en users/{uid}/progress/settings).
class Ajustes {
  const Ajustes({
    this.fechaConvocatoria,
    this.temasEstudiados = const {},
    this.temasEnRepaso = const {},
    this.horaRecordatorio = -1, // minutos desde medianoche; -1 = desactivado (valor por defecto)
    this.temaOscuro, // null = sistema
    this.temasExtraidos = 3,
    this.noCantar = const {},
    this.temasClases = const {},
    this.estadisticas,
    this.calendarioGoogle = false,
    this.racha = false,
    this.temaFrio = false,
    this.mejorRacha = 0,
    this.rachaCongelaciones = const [],
    this.avisosPreparador = const {},
    this.ultimoUso,
    this.rubrica = const [],
    this.aportarReto = false,
    this.updatedAt,
  });

  /// Tipos de actividad de los que el preparador puede recibir aviso, si el
  /// opositor los comparte (apagados por defecto): temas fijados para una
  /// clase, cantes por su cuenta, temas marcados como estudiados, último día
  /// de uso de la app (solo el día) y cercanía del examen.
  static const avisosPreparadorTipos = ['temas', 'cantes', 'estudiados', 'uso', 'examen'];

  final DateTime? fechaConvocatoria;
  final Set<String> temasEstudiados;
  final Set<String> temasEnRepaso;
  final int horaRecordatorio;
  final bool? temaOscuro;
  /// Nº de temas que se extraen en el sorteo real.
  final int temasExtraidos;
  /// Temas que el opositor pide no cantar por ahora en las clases con sus
  /// preparadores (aunque los lleve o estén en su cronograma), y desde cuándo.
  /// Los preparadores lo ven y los dejan fuera del sorteo.
  final Map<String, DateTime> noCantar;
  /// Temas que lleva a cada clase con su preparador (por id de clase), si los
  /// ha elegido o aceptado; si no, cuentan los de su cronograma
  /// ([temasDeLaClase]). Los lee también el preparador.
  final Map<String, TemasClase> temasClases;
  /// Estadísticas de uso anónimas e informes de errores (Firebase): true si
  /// lo activó, false si dijo que no, null si aún no se le ha preguntado.
  final bool? estadisticas;
  /// «Mis cantes en Google Calendar»: el opositor lleva sus cantes y las
  /// clases con su preparador a su propio calendario (solo en Android).
  final bool calendarioGoogle;
  /// Racha de días con actividad en Hoy (la activa el opositor).
  final bool racha;
  /// En Hoy, el tema estudiado que lleva más tiempo sin repasar (lo activa el opositor).
  final bool temaFrio;
  final int mejorRacha;
  /// Días en que la racha está congelada (descansos), como «desde|hasta» en
  /// claves de día (ver features/inicio/racha.dart).
  final List<String> rachaCongelaciones;
  /// Qué avisos de su actividad recibe el preparador (ver [avisosPreparadorTipos]).
  final Set<String> avisosPreparador;
  /// Último día en que usó la app (clave de día), solo si comparte `uso`.
  final String? ultimoUso;
  /// Criterios con los que valora sus propios cantes (vacío = solo estrellas).
  final List<String> rubrica;
  /// Aportar la nota del test diario al agregado anónimo (y ver el de los demás).
  final bool aportarReto;
  final DateTime? updatedAt;

  Ajustes copyWith({
    DateTime? fechaConvocatoria,
    bool borrarFecha = false,
    Set<String>? temasEstudiados,
    Set<String>? temasEnRepaso,
    int? horaRecordatorio,
    bool? temaOscuro,
    bool borrarTema = false,
    int? temasExtraidos,
    Map<String, DateTime>? noCantar,
    Map<String, TemasClase>? temasClases,
    bool? estadisticas,
    bool? calendarioGoogle,
    bool? racha,
    bool? temaFrio,
    int? mejorRacha,
    List<String>? rachaCongelaciones,
    Set<String>? avisosPreparador,
    String? ultimoUso,
    List<String>? rubrica,
    bool? aportarReto,
    DateTime? updatedAt,
  }) =>
      Ajustes(
        fechaConvocatoria: borrarFecha ? null : (fechaConvocatoria ?? this.fechaConvocatoria),
        temasEstudiados: temasEstudiados ?? this.temasEstudiados,
        temasEnRepaso: temasEnRepaso ?? this.temasEnRepaso,
        horaRecordatorio: horaRecordatorio ?? this.horaRecordatorio,
        temaOscuro: borrarTema ? null : (temaOscuro ?? this.temaOscuro),
        temasExtraidos: temasExtraidos ?? this.temasExtraidos,
        noCantar: noCantar ?? this.noCantar,
        temasClases: temasClases ?? this.temasClases,
        estadisticas: estadisticas ?? this.estadisticas,
        calendarioGoogle: calendarioGoogle ?? this.calendarioGoogle,
        racha: racha ?? this.racha,
        temaFrio: temaFrio ?? this.temaFrio,
        mejorRacha: mejorRacha ?? this.mejorRacha,
        rachaCongelaciones: rachaCongelaciones ?? this.rachaCongelaciones,
        avisosPreparador: avisosPreparador ?? this.avisosPreparador,
        ultimoUso: ultimoUso ?? this.ultimoUso,
        rubrica: rubrica ?? this.rubrica,
        aportarReto: aportarReto ?? this.aportarReto,
        updatedAt: updatedAt ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'fechaConvocatoria': fechaConvocatoria?.toIso8601String(),
        'temasEstudiados': temasEstudiados.toList()..sort(),
        'temasEnRepaso': temasEnRepaso.toList()..sort(),
        'recordatorio': horaRecordatorio,
        'temaOscuro': temaOscuro,
        'temasExtraidos': temasExtraidos,
        // Como lista («código@fecha»), no como mapa: el documento se guarda con
        // merge y un mapa no borraría en la nube lo que se quita aquí.
        'noCantar': [for (final e in noCantar.entries) '${e.key}@${e.value.toIso8601String()}']..sort(),
        'temasClases': TemasClase.aLista(temasClases),
        'estadisticas': estadisticas,
        'calendarioGoogle': calendarioGoogle,
        'racha': racha,
        'temaFrio': temaFrio,
        'mejorRacha': mejorRacha,
        'rachaCongelaciones': rachaCongelaciones,
        'avisosPreparador': avisosPreparador.toList()..sort(),
        if (ultimoUso != null) 'ultimoUso': ultimoUso,
        'rubrica': rubrica,
        'aportarReto': aportarReto,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  /// Lo que pide no cantar, leído del JSON de los ajustes (también lo lee el
  /// preparador del documento del alumno).
  static Map<String, DateTime> noCantarDe(Map<dynamic, dynamic>? j) {
    final v = j?['noCantar'];
    return {
      if (v is List)
        for (final s in v)
          if (s.toString().split('@') case [final codigo, final fecha] when DateTime.tryParse(fecha) != null) codigo: DateTime.parse(fecha),
      if (v is Map)
        for (final e in v.entries)
          if (DateTime.tryParse(e.value.toString()) case final d?) e.key.toString(): d,
    };
  }

  factory Ajustes.fromJson(Map<dynamic, dynamic>? j) {
    if (j == null) return const Ajustes();
    DateTime? f(String? s) => s == null ? null : DateTime.tryParse(s);
    return Ajustes(
      fechaConvocatoria: f(j['fechaConvocatoria'] as String?),
      temasEstudiados: ((j['temasEstudiados'] as List?) ?? []).map((e) => e.toString()).toSet(),
      temasEnRepaso: ((j['temasEnRepaso'] as List?) ?? []).map((e) => e.toString()).toSet(),
      // Clave nueva: la antigua ('horaRecordatorio') guardaba las 20:00 aunque el
      // usuario nunca lo hubiera activado, así que se ignora.
      horaRecordatorio: (j['recordatorio'] as num?)?.toInt() ?? -1,
      temaOscuro: j['temaOscuro'] as bool?,
      temasExtraidos: (j['temasExtraidos'] as num?)?.toInt() ?? 3,
      noCantar: noCantarDe(j),
      temasClases: TemasClase.deLista(j['temasClases']),
      estadisticas: j['estadisticas'] as bool?,
      calendarioGoogle: j['calendarioGoogle'] == true,
      racha: j['racha'] == true,
      temaFrio: j['temaFrio'] == true,
      mejorRacha: (j['mejorRacha'] as num?)?.toInt() ?? 0,
      rachaCongelaciones: ((j['rachaCongelaciones'] as List?) ?? []).map((e) => e.toString()).toList(),
      avisosPreparador: ((j['avisosPreparador'] as List?) ?? []).map((e) => e.toString()).toSet(),
      ultimoUso: j['ultimoUso'] as String?,
      rubrica: ((j['rubrica'] as List?) ?? []).map((e) => e.toString()).toList(),
      aportarReto: j['aportarReto'] == true,
      updatedAt: f(j['updatedAt'] as String?),
    );
  }

  static String claveDia(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
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
    this.oposicion = Oposiciones.tcee,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _resultados = resultados,
        _leitner = leitner,
        _ajustes = ajustes,
        _notas = notas,
        _db = firestore,
        _auth = auth;

  final Oposicion oposicion;
  final Box _resultados;
  final Box _leitner;
  final Box _ajustes;
  final Box _notas;
  final FirebaseFirestore? _db;
  final FirebaseAuth? _auth;

  static Future<UsuarioRepo> crear({Oposicion oposicion = Oposiciones.tcee, FirebaseFirestore? firestore, FirebaseAuth? auth}) async => UsuarioRepo(
        oposicion: oposicion,
        resultados: await Hive.openBox(oposicion.caja(Cajas.resultados)),
        leitner: await Hive.openBox(oposicion.caja(Cajas.leitner)),
        ajustes: await Hive.openBox(oposicion.caja(Cajas.ajustes)),
        notas: await Hive.openBox(oposicion.caja(Cajas.notas)),
        firestore: firestore,
        auth: auth,
      );

  String? get uid => _auth?.currentUser?.uid;
  bool get conSesion => uid != null;

  DocumentReference<Map<String, dynamic>>? get _docUsuario =>
      uid == null || _db == null ? null : oposicion.raizUsuario(_db, uid!);

  // ---------------------------------------------------------------- Reportes

  /// «Reportar respuesta» en la revisión de un test: va a `reportesTest` (en la
  /// raíz: el banco es común) y una Action se lo manda por correo al
  /// administrador. Hace falta cuenta; sin red, Firestore lo envía al volver.
  Future<void> reportarPregunta({required int pregunta, required String examen, required int numero, String? elegida, required String motivo, required String comentario}) async {
    final usuario = _auth?.currentUser;
    if (usuario == null || _db == null) throw StateError('Sin sesión');
    await _db.collection('reportesTest').add({
      'uid': usuario.uid,
      'correo': usuario.email ?? '',
      'nombre': usuario.displayName ?? '',
      'oposicion': oposicion.id,
      'pregunta': pregunta,
      'examen': examen,
      'numero': numero,
      'elegida': elegida ?? '',
      'motivo': motivo,
      'comentario': comentario,
      'version': (await PackageInfo.fromPlatform()).version,
      'creado': FieldValue.serverTimestamp(),
      'enviado': false,
    });
  }

  // --------------------------------------------------------------- Reto diario

  /// Suma la nota del test diario de [dia] al agregado anónimo (una vez por
  /// persona y día: la marca `participantes/{uid}` y el contador van en la
  /// misma transacción, como exigen las reglas). Sin sesión o ya aportada, no
  /// hace nada. Devuelve si se ha aportado ahora.
  Future<bool> aportarReto(double notaSobre10, {DateTime? dia}) async {
    final uid = _auth?.currentUser?.uid;
    if (uid == null || _db == null) return false;
    final id = RetoDia.id(dia ?? DateTime.now());
    final clave = 'reto_aportado_${oposicion.id}_$id';
    if (_ajustes.get(clave) == true) return false;
    final nota = RetoDia.cubo(notaSobre10);
    final col = oposicion.red(_db, 'retoDiario');
    try {
      final lote = _db.batch()
        ..set(col.doc(id).collection('participantes').doc(uid), {'nota': nota})
        ..set(col.doc(id), {'hechos': FieldValue.increment(1), 'sumaNotas': FieldValue.increment(nota), 'c$nota': FieldValue.increment(1)}, SetOptions(merge: true));
      await lote.commit();
      await _ajustes.put(clave, true);
      return true;
    } on FirebaseException catch (e) {
      // Ya aportada desde otro dispositivo: se recuerda para no insistir.
      if (e.code == 'permission-denied') await _ajustes.put(clave, true);
      return false;
    } catch (_) {
      return false;
    }
  }

  /// El agregado de [dia] (null sin sesión o sin red).
  Future<RetoDia?> leerReto({DateTime? dia}) async {
    if (_auth?.currentUser == null || _db == null) return null;
    try {
      final d = await oposicion.red(_db, 'retoDiario').doc(RetoDia.id(dia ?? DateTime.now())).get();
      return RetoDia.fromJson(d.data());
    } catch (_) {
      return null;
    }
  }

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

  // ------------------------------------------------------------ Test en curso

  /// Test a medias guardado en este dispositivo (no se sincroniza: las
  /// preguntas son las de este banco y el tiempo, el de este reloj).
  TestEnCurso? testEnCurso() {
    final m = _ajustes.get('test_en_curso') as Map?;
    if (m == null) return null;
    try {
      return TestEnCurso.fromJson(m);
    } catch (_) {
      return null;
    }
  }

  Future<void> guardarTestEnCurso(TestEnCurso? t) => t == null ? _ajustes.delete('test_en_curso') : _ajustes.put('test_en_curso', t.toJson());

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
      // Con merge, una lista vacía no siempre borra la de la nube (y un mapa
      // vacío nunca): lo que se quita de «no cantar» se borra de verdad.
      await doc.collection('progress').doc('settings').set({...a.toJson(), if (a.noCantar.isEmpty) 'noCantar': FieldValue.delete()}, SetOptions(merge: true));
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
        mejorRacha: local.mejorRacha > nube.mejorRacha ? local.mejorRacha : nube.mejorRacha,
        rachaCongelaciones: {...local.rachaCongelaciones, ...nube.rachaCongelaciones}.toList()..sort(),
        ultimoUso: [local.ultimoUso, nube.ultimoUso].whereType<String>().fold<String?>(null, (m, v) => m == null || v.compareTo(m) > 0 ? v : m),
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
      // merge: el mismo documento guarda la agenda del tema (PlanRepo), así que
      // una nota vacía se guarda como texto vacío en vez de borrar el documento.
      await doc.collection('notes').doc(codigoTema.replaceAll('.', '_')).set(
        {'tema': codigoTema, 'texto': texto.trim().isEmpty ? '' : texto, 'updatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
    } catch (_) {}
  }

  Future<void> sincronizarNotas() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('notes').get();
      for (final d in snap.docs) {
        final tema = d.data()['tema'] as String? ?? d.id.replaceAll('_', '.');
        final texto = d.data()['texto'] as String? ?? '';
        if (texto.isNotEmpty && !_notas.containsKey(tema)) await _notas.put(tema, texto);
      }
      for (final e in todasLasNotas().entries) {
        final id = e.key.replaceAll('.', '_');
        if (!snap.docs.any((d) => d.id == id)) {
          await doc.collection('notes').doc(id).set({'tema': e.key, 'texto': e.value, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
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

  /// Subcolecciones de users/{uid} (ver firestore.rules).
  static const coleccionesUsuario = ['exam_results', 'progress', 'notes', 'cantes', 'alumnos', 'sesiones', 'preparadores', 'cronogramas'];

  /// Borra todo lo que el usuario tiene en la nube (users/{uid}/…). Los enlaces
  /// con preparadores y alumnos se rompen antes en [PreparadorRepo].
  Future<void> borrarTodoEnLaNube() async {
    final doc = _docUsuario;
    if (doc == null) return;
    for (final c in coleccionesUsuario) {
      final snap = await doc.collection(c).get();
      // Las clases de preparador llevan debajo el cronómetro y la pizarra
      // compartidos: también se borran (borrar el documento no los borra).
      final refs = [
        for (final d in snap.docs) ...[
          if (c == 'cantes' && d.data()['preparador'] != null)
            for (final sub in const ['reloj', 'pizarra']) ...(await d.reference.collection(sub).get()).docs.map((x) => x.reference),
          d.reference,
        ],
      ];
      // Un lote admite 500 operaciones.
      for (var i = 0; i < refs.length; i += 400) {
        final lote = _db!.batch();
        for (final r in refs.skip(i).take(400)) {
          lote.delete(r);
        }
        await lote.commit();
      }
    }
  }

  /// Borra todos los datos locales (cerrar sesión no los borra; esto es explícito).
  Future<void> borrarDatosLocales() async {
    await Future.wait([_resultados.clear(), _leitner.clear(), _ajustes.clear(), _notas.clear()]);
  }

  /// Exporta todo en JSON (portabilidad RGPD). [extra] añade los datos de
  /// otros repositorios (planificación).
  String exportarJson({Map<String, dynamic> extra = const {}}) => const JsonEncoder.withIndent('  ').convert({
        'resultados': resultadosLocales().map((r) => r.toLocal()).toList(),
        'leitner': leitner().toJson(),
        'ajustes': ajustes().toJson(),
        'notas': todasLasNotas(),
        ...extra,
      });
}
