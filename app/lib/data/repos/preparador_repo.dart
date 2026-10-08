import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../models/oposicion.dart';
import '../models/cronograma.dart';
import '../models/plan.dart';
import '../models/preparador.dart';
import '../models/red.dart';
import 'calendario_google.dart';

/// Sección de preparadores. Igual que [PlanRepo]: siempre en local (Hive) y,
/// si hay sesión, también en Firestore.
///
/// Lado del preparador (subárbol propio, users/{uid}):
///   users/{uid}/progress/preparador   perfil (activo, código, nombre)
///   users/{uid}/alumnos/{id}          alumnos
///   users/{uid}/sesiones/{id}         sesiones de cante con sus alumnos
///
/// Enlace entre un alumno y su preparador (ver firestore.rules):
///   codigos/{codigo}                           código → uid y nombre del preparador
///   users/{alumno}/preparadores/{preparador}   permiso que da el alumno
///   preparadores/{preparador}/alumnos/{alumno} para que el preparador vea quién se ha enlazado
///   users/{alumno}/cantes/{id}                 copia de cada sesión, en la agenda y el diario del alumno
/// Motivo por el que no se pudo reservar el código de preparador.
enum ErrorCodigo { permiso, red, otro }

class PreparadorRepo {
  PreparadorRepo({
    required Box alumnos,
    required Box sesiones,
    required Box perfil,
    this.oposicion = Oposiciones.tcee,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _alumnos = alumnos,
        _sesiones = sesiones,
        _perfil = perfil,
        _db = firestore,
        _auth = auth;

  final Oposicion oposicion;
  final Box _alumnos;
  final Box _sesiones;
  final Box _perfil;
  final FirebaseFirestore? _db;
  final FirebaseAuth? _auth;

  static Future<PreparadorRepo> crear({Oposicion oposicion = Oposiciones.tcee, FirebaseFirestore? firestore, FirebaseAuth? auth}) async => PreparadorRepo(
        oposicion: oposicion,
        alumnos: await Hive.openBox(oposicion.caja(Cajas.alumnos)),
        sesiones: await Hive.openBox(oposicion.caja(Cajas.sesiones)),
        perfil: await Hive.openBox(oposicion.caja(Cajas.preparador)),
        firestore: firestore,
        auth: auth,
      );

  /// Google Calendar del preparador (lo pone la app al crear los servicios;
  /// sin él, o con la opción apagada, las clases no van al calendario).
  CalendarioGoogle? calendario;

  String? get uid => _auth?.currentUser?.uid;
  bool get conSesion => uid != null && _db != null;

  DocumentReference<Map<String, dynamic>>? get _docUsuario => conSesion ? oposicion.raizUsuario(_db!, uid!) : null;

  // -------------------------------------------------------------------- Perfil

  PerfilPreparador perfil() => PerfilPreparador.fromJson(_perfil.get('perfil') as Map?);

  Future<void> guardarPerfil(PerfilPreparador p) async {
    await _perfil.put('perfil', p.toJson());
    try {
      await _docUsuario?.collection('progress').doc('preparador').set(p.toJson());
    } catch (_) {
      // Sin red: se sube en la próxima sincronización.
    }
  }

  /// Activa «Soy preparador». Con sesión reserva además el código que se da
  /// a los alumnos; sin sesión, la herramienta funciona solo en este dispositivo.
  Future<PerfilPreparador> activar({String? nombre}) async {
    var p = perfil().copyWith(activo: true, nombre: nombre ?? (perfil().nombre.isEmpty ? (_auth?.currentUser?.displayName ?? '') : null));
    await guardarPerfil(p);
    if (conSesion && p.codigo == null) {
      final codigo = await _reservarCodigo(p.nombre);
      if (codigo != null) {
        p = p.copyWith(codigo: codigo);
        await guardarPerfil(p);
      }
    }
    return p;
  }

  Future<void> desactivar() => guardarPerfil(perfil().copyWith(activo: false));

  /// Cambia el nombre con el que los alumnos ven al preparador.
  Future<PerfilPreparador> renombrar(String nombre) async {
    final p = perfil().copyWith(nombre: nombre.trim());
    await guardarPerfil(p);
    try {
      if (conSesion && p.codigo != null) await oposicion.red(_db!, 'codigos').doc(p.codigo).set({'uid': uid, 'nombre': p.nombre}, SetOptions(merge: true));
    } catch (_) {}
    return p;
  }

  /// Por qué falló la última reserva del código (null si no falló).
  ErrorCodigo? errorCodigo;

  Future<String?> _reservarCodigo(String nombre) async {
    errorCodigo = null;
    try {
      for (var i = 0; i < 6; i++) {
        final codigo = generarCodigo();
        final doc = oposicion.red(_db!, 'codigos').doc(codigo);
        // Del servidor: con la caché sin conexión, un get() sin red diría que el código está libre.
        if ((await doc.get(const GetOptions(source: Source.server))).exists) continue;
        await doc.set({'uid': uid, 'nombre': nombre, 'creado': DateTime.now().toIso8601String()});
        return codigo;
      }
      errorCodigo = ErrorCodigo.otro;
    } on FirebaseException catch (e) {
      // Se reintenta la próxima vez que se abra la sección o con «Reintentar».
      errorCodigo = e.code == 'permission-denied' ? ErrorCodigo.permiso : (e.code == 'unavailable' ? ErrorCodigo.red : ErrorCodigo.otro);
    } catch (_) {
      errorCodigo = ErrorCodigo.otro;
    }
    return null;
  }

  // ------------------------------------------------------------------- Alumnos

  List<Alumno> _todosLosAlumnos() => _alumnos.values.map((v) => Alumno.fromJson(v as Map)).toList();

  /// Alumnos visibles, por orden alfabético.
  List<Alumno> alumnos() => _todosLosAlumnos().where((a) => !a.borrado).toList()..sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));

  Alumno? alumno(String id) {
    final j = _alumnos.get(id) as Map?;
    return j == null ? null : Alumno.fromJson(j);
  }

  Future<void> guardarAlumno(Alumno a) async {
    await _alumnos.put(a.id, a.toJson());
    try {
      await _docUsuario?.collection('alumnos').doc(a.id).set(a.toJson());
    } catch (_) {}
  }

  /// Borrado lógico. Si el alumno estaba enlazado, se rompe también el enlace.
  Future<void> borrarAlumno(Alumno a) async {
    if (a.enlazado) await romperEnlaceConAlumno(a);
    await guardarAlumno(a.copyWith(borrado: true, desenlazar: true));
  }

  // ------------------------------------------------------------------ Sesiones

  List<Cante> _todasLasSesiones() => _sesiones.values.map((v) => Cante.fromJson(v as Map)).toList();

  /// Sesiones visibles, ordenadas por fecha.
  List<Cante> sesiones() => _todasLasSesiones().where((c) => !c.borrado).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));

  Future<void> guardarSesion(Cante s) async {
    final antes = _sesiones.get(s.id) as Map?;
    await _sesiones.put(s.id, s.toJson());
    try {
      await _docUsuario?.collection('sesiones').doc(s.id).set(s.toJson());
    } catch (_) {}
    await _copiarAlAlumno(s);
    await _entregarTema(s, antes: antes == null ? null : Cante.fromJson(antes));
    // Al calendario en segundo plano: guardar no espera a Google.
    if (calendario != null && perfil().calendarioGoogle) {
      unawaited(llevarAlCalendario(s.id).then((cambio) {
        if (cambio) alCambiarSesiones?.call();
      }));
    }
  }

  /// Se llama cuando el calendario cambia una clase (su enlace de Meet), para
  /// que la pantalla la vuelva a leer.
  void Function()? alCambiarSesiones;

  /// Lo que se está mandando al calendario, por clase: cada envío espera al
  /// anterior de la misma clase (si no, una clase guardada dos veces seguidas
  /// podría crear dos eventos).
  final Map<String, Future<bool>> _colaCalendario = {};

  /// Si el preparador tiene conectado Google Calendar, lleva la clase a su
  /// calendario (crea, cambia o borra el evento, con su Meet y la invitación
  /// al alumno) y guarda lo que cambie: el evento y el enlace de la reunión,
  /// que llega también al alumno. Sin red o sin permiso no pasa nada: la clase
  /// ya está guardada y se reintenta al volver a guardarla.
  /// Devuelve si ha cambiado la clase guardada.
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
    final j = _sesiones.get(id) as Map?;
    if (cal == null || j == null || !perfil().calendarioGoogle) return false;
    // La versión de ahora (con el evento que dejara el envío anterior).
    final s = Cante.fromJson(j);
    if (s.alumno == null) return false;
    final a = alumno(s.alumno!);
    try {
      final nuevo = await cal.sincronizar(s, alumno: a?.nombre ?? '', email: a?.email ?? '', preparador: perfil().nombre, siglas: oposicion.siglas);
      if (nuevo == null) return false;
      // Sobre la última versión (por si se ha cambiado mientras tanto): solo
      // el evento y, si no tenía, el enlace de la reunión.
      final ultimo = Cante.fromJson(_sesiones.get(id) as Map? ?? j);
      final guardar = ultimo.copyWith(eventoGoogle: nuevo.eventoGoogle, enlace: ultimo.enlace.isEmpty ? nuevo.enlace : null);
      await _sesiones.put(id, guardar.toJson());
      try {
        await _docUsuario?.collection('sesiones').doc(id).set(guardar.toJson());
      } catch (_) {}
      if (guardar.enlace != s.enlace) await _copiarAlAlumno(guardar);
      return true;
    } catch (e) {
      cal.ultimoError = e is DioException ? (e.response?.data?.toString() ?? e.message ?? e.type.name) : e.toString();
      return false;
    }
  }

  /// Al conectar el calendario: lleva todas las clases pendientes que vienen.
  /// Devuelve cuántas se han llevado.
  Future<int> llevarClasesAlCalendario({DateTime? ahora}) async {
    final hoy = ahora ?? DateTime.now();
    var n = 0;
    for (final s in sesiones().where((s) => s.pendiente && s.alumno != null && s.fecha.isAfter(hoy))) {
      await llevarAlCalendario(s.id);
      if ((Cante.fromJson(_sesiones.get(s.id) as Map)).eventoGoogle.isNotEmpty) n++;
    }
    return n;
  }

  /// Título de un tema (lo pone la app con el temario cargado), para que el
  /// aviso del alumno lo lleve completo.
  String Function(String codigo)? tituloTema;

  /// Tema que se manda al alumno antes de la clase: va aparte, en
  /// temasAnticipados/{id}, que el alumno solo puede leer a partir de su hora
  /// (lo comprueban las reglas del servidor). Si se quita, se cancela o se
  /// borra la clase, se retira.
  Future<void> _entregarTema(Cante s, {Cante? antes}) async {
    final a = s.alumno == null ? null : alumno(s.alumno!);
    if (!conSesion || a?.uid == null) return;
    final doc = oposicion.red(_db!, 'temasAnticipados').doc(s.id);
    try {
      if (s.mandaTema && s.pendiente && !s.borrado) {
        await doc.set({
          'alumno': a!.uid,
          'preparador': uid,
          'preparadorNombre': perfil().nombre,
          'tema': s.temaMandado,
          'titulo': tituloTema?.call(s.temaMandado!) ?? '',
          'sorteado': s.temaSorteado,
          'visibleDesde': Timestamp.fromDate(s.temaA!),
          'updatedAt': DateTime.now().toIso8601String(),
        });
      } else if (antes?.mandaTema ?? false) {
        await doc.delete();
      }
    } catch (_) {
      // Sin red: se reintenta al volver a guardar la clase.
    }
  }

  /// El tema que se manda, ya en el servidor (null si aún no se ha subido).
  Future<bool> temaEntregado(Cante s) async {
    if (!conSesion) return false;
    try {
      return (await oposicion.red(_db!, 'temasAnticipados').doc(s.id).get()).exists;
    } catch (_) {
      return false;
    }
  }

  Future<void> guardarSesiones(Iterable<Cante> lista) async {
    for (final s in lista) {
      await guardarSesion(s);
    }
  }

  Future<void> borrarSesion(Cante s) => guardarSesion(s.copyWith(borrado: true));

  /// Lo que ve el alumno enlazado en su agenda: el mismo cante, firmado por el preparador.
  Map<String, dynamic> copiaParaAlumno(Cante s) {
    final nombre = perfil().nombre;
    return {
      // El tema que se manda antes de la clase no va en la copia: el alumno
      // solo sabe a qué hora le llegará.
      ...s.toJson()
        ..remove('alumno')
        ..remove('eventoGoogle')
        ..remove('temaMandado')
        ..remove('temaSorteado'),
      'titulo': s.titulo.isNotEmpty ? s.titulo : (nombre.isEmpty ? 'Preparador' : 'Con $nombre'),
      'preparador': uid,
      'preparadorNombre': nombre,
    };
  }

  Future<void> _copiarAlAlumno(Cante s) async {
    final a = s.alumno == null ? null : alumno(s.alumno!);
    if (!conSesion || a?.uid == null) return;
    try {
      await oposicion.raizUsuario(_db!, a!.uid!).collection('cantes').doc(s.id).set(copiaParaAlumno(s));
    } catch (_) {
      // Sin red o enlace roto: la sesión queda guardada en el lado del preparador.
    }
  }

  /// Si la cuenta puede usar Google Calendar mientras Google no verifica el
  /// permiso: la apunta el administrador en pruebasCalendario/{correo o uid}.
  Future<bool> calendarioPermitido() async {
    if (!conSesion) return false;
    final yo = _auth!.currentUser!;
    try {
      final col = Oposiciones.tcee.red(_db!, 'pruebasCalendario');
      if ((await col.doc(yo.uid).get()).exists) return true;
      final email = yo.email?.toLowerCase();
      return email != null && (await col.doc(email).get()).exists;
    } catch (_) {
      return false;
    }
  }

  // ----------------------------------------------------- Enlace: lado del alumno

  /// Preparadores con los que este usuario ha enlazado su app (copia local).
  List<VinculoPreparador> misPreparadores() =>
      ((_perfil.get('vinculos') as List?) ?? []).map((e) => VinculoPreparador.fromJson(e as Map)).toList();

  Future<void> _guardarVinculos(List<VinculoPreparador> v) => _perfil.put('vinculos', v.map((e) => e.toJson()).toList());

  /// Enlaza la app del alumno con el preparador que tiene ese código.
  Future<VinculoPreparador> enlazarConCodigo(String texto) async {
    final codigo = normalizarCodigo(texto);
    if (codigo == null) throw const ErrorEnlace('El código tiene seis letras o cifras. Revísalo con tu preparador.');
    if (!conSesion) throw const ErrorEnlace('Inicia sesión con Google para enlazar con tu preparador.');
    final yo = _auth!.currentUser!;
    final DocumentSnapshot<Map<String, dynamic>> doc;
    try {
      doc = await oposicion.red(_db!, 'codigos').doc(codigo).get();
    } catch (_) {
      throw const ErrorEnlace('No se pudo comprobar el código. Revisa la conexión e inténtalo de nuevo.');
    }
    final prep = doc.data()?['uid'] as String?;
    if (!doc.exists || prep == null) throw const ErrorEnlace('No hay ningún preparador con ese código.');
    if (prep == yo.uid) throw const ErrorEnlace('Ese es tu propio código de preparador.');
    try {
      final v = await oposicion.red(_db, 'preparadoresVerificados').doc(prep).get();
      if (!v.exists || v.data()?['activo'] != true) throw const ErrorEnlace('Ese preparador no está verificado. Pídele que se verifique en la app antes de enlazar.');
    } on ErrorEnlace {
      rethrow;
    } catch (_) {
      throw const ErrorEnlace('No se pudo comprobar el código. Revisa la conexión e inténtalo de nuevo.');
    }
    final vinculo = VinculoPreparador(uid: prep, nombre: doc.data()?['nombre'] as String? ?? '', codigo: codigo, desde: DateTime.now());
    try {
      final lote = _db.batch()
        ..set(_docUsuario!.collection('preparadores').doc(prep), vinculo.toJson())
        ..set(oposicion.red(_db, 'preparadores').doc(prep).collection('alumnos').doc(yo.uid), {
          'uid': yo.uid,
          'nombre': yo.displayName ?? '',
          'email': yo.email,
          'desde': DateTime.now().toIso8601String(),
        });
      await lote.commit();
    } catch (_) {
      throw const ErrorEnlace('No se pudo completar el enlace. Inténtalo de nuevo más tarde.');
    }
    await _guardarVinculos([...misPreparadores().where((v) => v.uid != prep), vinculo]);
    return vinculo;
  }

  /// El alumno deja de compartir su progreso con ese preparador.
  Future<void> desenlazar(String preparador) async {
    await _guardarVinculos(misPreparadores().where((v) => v.uid != preparador).toList());
    if (!conSesion) return;
    try {
      final lote = _db!.batch()
        ..delete(_docUsuario!.collection('preparadores').doc(preparador))
        ..delete(oposicion.red(_db, 'preparadores').doc(preparador).collection('alumnos').doc(uid));
      await lote.commit();
    } catch (_) {}
  }

  Future<void> _sincronizarVinculos() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection('preparadores').get();
      await _guardarVinculos([for (final d in snap.docs) VinculoPreparador.fromJson({...d.data(), 'uid': d.id})]);
    } catch (_) {}
  }

  // ------------------------------------------------- Enlace: lado del preparador

  /// Da de alta como alumnos a quienes han enlazado con el código y quita el
  /// enlace a los que lo han roto desde su app.
  Future<void> _sincronizarAlumnosEnlazados() async {
    if (!conSesion || !perfil().activo) return;
    try {
      final snap = await oposicion.red(_db!, 'preparadores').doc(uid).collection('alumnos').get();
      final enlazados = {for (final d in snap.docs) d.id: d.data()};
      final locales = _todosLosAlumnos();
      for (final e in enlazados.entries) {
        final existente = locales.where((a) => a.uid == e.key).firstOrNull;
        final email = (e.value['email'] as String?)?.trim() ?? '';
        if (existente != null && !existente.borrado) {
          // El correo de su cuenta, para invitarle a las clases en Google Calendar.
          if (existente.email.isEmpty && email.isNotEmpty) await guardarAlumno(existente.copyWith(email: email));
          continue;
        }
        final nombre = (e.value['nombre'] as String?)?.trim() ?? '';
        await guardarAlumno(Alumno(id: e.key, uid: e.key, nombre: nombre.isEmpty ? (email.isEmpty ? 'Alumno' : email) : nombre, email: email, creado: DateTime.now(), updatedAt: DateTime.now()));
      }
      for (final a in locales.where((a) => a.enlazado && !a.borrado && !enlazados.containsKey(a.uid))) {
        await guardarAlumno(a.copyWith(desenlazar: true));
      }
    } catch (_) {}
  }

  /// Trae los cambios que un alumno enlazado ha hecho en las sesiones que le
  /// programó este preparador (cambio de hora, su valoración, notas): el más
  /// reciente gana. Se conservan el alumno, el título y el borrado del lado del
  /// preparador, así que si el alumno quita una sesión de su agenda, el
  /// preparador no la pierde.
  Future<void> _traerCambiosDeAlumnos() async {
    if (!conSesion || !perfil().activo) return;
    final locales = {for (final s in _todasLasSesiones()) s.id: s};
    for (final a in alumnos().where((a) => a.enlazado)) {
      try {
        final snap = await oposicion.raizUsuario(_db!, a.uid!).collection('cantes').where('preparador', isEqualTo: uid).get();
        for (final d in snap.docs) {
          final mia = locales[d.id];
          if (mia == null) continue;
          final suya = Cante.fromJson({...d.data(), 'id': d.id});
          if (!(suya.updatedAt ?? DateTime(0)).isAfter(mia.updatedAt ?? DateTime(0))) continue;
          final json = {
            ...suya.toJson(),
            'alumno': mia.alumno,
            'titulo': mia.titulo,
            'borrado': mia.borrado,
            if (mia.temaA != null) 'temaA': mia.temaA!.toIso8601String(),
            if (mia.temaMandado != null) 'temaMandado': mia.temaMandado,
            if (mia.temaSorteado) 'temaSorteado': true,
          }
            ..remove('preparador')
            ..remove('preparadorNombre');
          await _sesiones.put(d.id, json);
          await _docUsuario?.collection('sesiones').doc(d.id).set(json);
        }
      } catch (_) {
        // Sin red o enlace roto: se intenta en la próxima sincronización.
      }
    }
  }

  /// Progreso que comparte un alumno enlazado (null si no lo está o no hay red).
  Future<ProgresoAlumno?> progreso(Alumno a) async {
    if (!conSesion || a.uid == null) return null;
    try {
      final usuario = oposicion.raizUsuario(_db!, a.uid!);
      final ajustes = (await usuario.collection('progress').doc('settings').get()).data() ?? const {};
      final cantes = await usuario.collection('cantes').get();
      final estudiados = ((ajustes['temasEstudiados'] as List?) ?? []).map((e) => e.toString()).toSet();
      // Se guarda la lista para poder sortear sin conexión.
      final ordenados = estudiados.toList()..sort();
      if (ordenados.join(',') != (List.of(a.temas)..sort()).join(',')) await guardarAlumno(a.copyWith(temas: ordenados));
      return ProgresoAlumno(
        estudiados: estudiados,
        enRepaso: ((ajustes['temasEnRepaso'] as List?) ?? []).map((e) => e.toString()).toSet(),
        cantes: [for (final d in cantes.docs) Cante.fromJson({...d.data(), 'id': d.id})].where((c) => !c.borrado).toList()..sort((x, y) => x.fecha.compareTo(y.fecha)),
      );
    } catch (_) {
      return null;
    }
  }

  /// Cronograma activo que el alumno enlazado comparte con sus preparadores (o null).
  Future<Cronograma?> cronogramaDe(Alumno a) async {
    if (!conSesion || a.uid == null) return null;
    try {
      final snap = await oposicion.raizUsuario(_db!, a.uid!).collection('cronogramas').where('compartir', isEqualTo: true).get();
      final lista = [for (final d in snap.docs) Cronograma.fromJson({...d.data(), 'id': d.id})].where((c) => !c.archivado).toList()
        ..sort((x, y) => (y.creado ?? DateTime(0)).compareTo(x.creado ?? DateTime(0)));
      return lista.firstOrNull;
    } catch (_) {
      return null;
    }
  }

  /// El preparador propone cambios en el cronograma del alumno: solo escribe la
  /// propuesta, que el alumno acepta o rechaza en su app.
  Future<void> proponerCambios(Alumno a, Cronograma c, PropuestaCronograma p) async {
    if (!conSesion || a.uid == null) return;
    await oposicion.raizUsuario(_db!, a.uid!).collection('cronogramas').doc(c.id).update({'propuesta': p.toJson(), 'updatedAt': DateTime.now().toIso8601String()});
  }

  /// El preparador deja de llevar a un alumno enlazado: pierde el acceso a su progreso.
  Future<void> romperEnlaceConAlumno(Alumno a) async {
    if (!conSesion || a.uid == null) return;
    try {
      final lote = _db!.batch()
        ..delete(oposicion.red(_db, 'preparadores').doc(uid).collection('alumnos').doc(a.uid))
        ..delete(oposicion.raizUsuario(_db, a.uid!).collection('preparadores').doc(uid));
      await lote.commit();
    } catch (_) {}
  }

  // ------------------------------------------------------------ Sincronización

  Future<void> _sincronizarPerfil() async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final local = perfil();
      final snap = await doc.collection('progress').doc('preparador').get();
      final nube = snap.exists ? PerfilPreparador.fromJson(snap.data()) : null;
      if (nube != null && (nube.updatedAt ?? DateTime(0)).isAfter(local.updatedAt ?? DateTime(0))) {
        await _perfil.put('perfil', nube.toJson());
      } else if (local.updatedAt != null) {
        await guardarPerfil(local);
      }
      // Activado sin sesión: ahora que la hay, se reserva el código.
      if (perfil().activo && perfil().codigo == null) await activar();
    } catch (_) {}
  }

  Future<void> _sincronizarColeccion<T>({
    required String nombre,
    required Box caja,
    required T Function(Map<dynamic, dynamic>) leer,
    required Map<String, dynamic> Function(T) escribir,
    required DateTime? Function(T) marca,
    required String Function(T) id,
  }) async {
    final doc = _docUsuario;
    if (doc == null) return;
    try {
      final snap = await doc.collection(nombre).get();
      final nube = {for (final d in snap.docs) d.id: leer({...d.data(), 'id': d.id})};
      final locales = {for (final v in caja.values) id(leer(v as Map)): leer(v)};
      for (final k in {...nube.keys, ...locales.keys}) {
        final n = nube[k], l = locales[k];
        final mn = n == null ? null : (marca(n) ?? DateTime(0)), ml = l == null ? null : (marca(l) ?? DateTime(0));
        if (l == null || (mn != null && mn.isAfter(ml!))) {
          await caja.put(k, escribir(n as T));
        } else if (n == null || ml!.isAfter(mn!)) {
          await doc.collection(nombre).doc(k).set(escribir(l));
        }
      }
    } catch (_) {}
  }

  Future<void> sincronizarTodo() async {
    if (!conSesion) return;
    await _sincronizarVinculos();
    await _sincronizarPerfil();
    await _sincronizarColeccion<Alumno>(nombre: 'alumnos', caja: _alumnos, leer: Alumno.fromJson, escribir: (a) => a.toJson(), marca: (a) => a.updatedAt, id: (a) => a.id);
    await _sincronizarColeccion<Cante>(nombre: 'sesiones', caja: _sesiones, leer: Cante.fromJson, escribir: (c) => c.toJson(), marca: (c) => c.updatedAt, id: (c) => c.id);
    await _sincronizarAlumnosEnlazados();
    await _traerCambiosDeAlumnos();
  }

  /// Antes de borrar la cuenta: rompe los enlaces con preparadores y alumnos y
  /// libera el código, para que nadie conserve acceso a nada.
  Future<void> romperTodosLosEnlaces() async {
    if (!conSesion) return;
    await _sincronizarVinculos();
    for (final v in misPreparadores()) {
      await desenlazar(v.uid);
    }
    final snap = await oposicion.red(_db!, 'preparadores').doc(uid).collection('alumnos').get();
    for (final d in snap.docs) {
      final lote = _db.batch()
        ..delete(d.reference)
        ..delete(oposicion.raizUsuario(_db, d.id).collection('preparadores').doc(uid));
      await lote.commit();
    }
    final codigo = perfil().codigo;
    if (codigo != null) await oposicion.red(_db, 'codigos').doc(codigo).delete();
  }

  // ------------------------------------------------------------- Clases fijas

  /// Crea las sesiones de las clases fijas de cada alumno para las próximas
  /// [semanas]. Cada sesión tiene un id que sale de la clase y del día, así que
  /// no se duplica y, si el preparador borra o cancela una, no vuelve a salir.
  Future<int> generarClasesFijas({DateTime? ahora, int semanas = 6}) async {
    final hoy = ahora ?? DateTime.now();
    final fin = DateTime(hoy.year, hoy.month, hoy.day + 7 * semanas);
    var nuevas = 0;
    for (final a in alumnos()) {
      for (final c in a.clasesFijas) {
        for (final f in c.fechasEntre(hoy, fin)) {
          final id = idClaseFija(a, c, f);
          if (_sesiones.containsKey(id)) continue;
          await guardarSesion(Cante(
            id: id,
            fecha: f,
            minutos: c.minutos,
            ejercicio: a.ejercicio,
            bolsa: TipoBolsa.estudiados,
            alumno: a.id,
            serie: 'fija_${a.id}_${c.id}',
            updatedAt: DateTime.now(),
          ));
          nuevas++;
        }
      }
    }
    return nuevas;
  }

  static String idClaseFija(Alumno a, ClaseFija c, DateTime f) =>
      'fija_${a.id}_${c.id}_${f.year}${f.month.toString().padLeft(2, '0')}${f.day.toString().padLeft(2, '0')}';

  /// Al quitar una clase fija se borran sus sesiones futuras aún pendientes.
  Future<void> quitarClaseFija(Alumno a, ClaseFija c, {DateTime? ahora}) async {
    final desde = ahora ?? DateTime.now();
    await guardarAlumno(a.copyWith(clasesFijas: a.clasesFijas.where((x) => x.id != c.id).toList()));
    for (final s in sesiones().where((s) => s.serie == 'fija_${a.id}_${c.id}' && s.pendiente && s.fecha.isAfter(desde))) {
      await borrarSesion(s);
    }
  }

  // ------------------------------------------------- Reservas y sustituciones

  /// Alumno enlazado con ese uid (o null).
  Alumno? alumnoConUid(String uidAlumno) => alumnos().where((a) => a.uid == uidAlumno).firstOrNull;

  /// El preparador acepta una reserva: se crea la sesión (y llega a la agenda del alumno).
  Future<Cante> sesionDeReserva(Reserva r) async {
    var a = alumnoConUid(r.alumno);
    if (a == null) {
      a = Alumno(id: r.alumno, uid: r.alumno, nombre: r.alumnoNombre.isEmpty ? 'Alumno' : r.alumnoNombre, creado: DateTime.now(), updatedAt: DateTime.now());
      await guardarAlumno(a);
    }
    final s = Cante(id: 'res_${r.id}', fecha: r.fecha, minutos: r.minutos, ejercicio: a.ejercicio, bolsa: TipoBolsa.estudiados, alumno: a.id, notas: r.nota, updatedAt: DateTime.now());
    await guardarSesion(s);
    return s;
  }

  /// El preparador ha cogido una sustitución: el alumno pasa a su lista (sin
  /// enlace, con su teléfono) y el cante, a sus sesiones.
  Future<Cante> sesionDeSustitucion(Sustitucion sust, ContactoRed alumno) async {
    final id = 'sust_${sust.id}';
    final existente = this.alumno(id) ?? alumnos().where((a) => a.telefono.isNotEmpty && telefonoWhatsApp(a.telefono) == telefonoWhatsApp(alumno.telefono)).firstOrNull;
    final a = (existente ?? Alumno(id: id, nombre: alumno.nombre.isEmpty ? 'Alumno' : alumno.nombre, creado: DateTime.now(), updatedAt: DateTime.now()))
        .copyWith(telefono: alumno.telefono, ejercicio: sust.ejercicio, temas: existente == null ? sust.temas : null);
    await guardarAlumno(a);
    final s = Cante(
      id: id,
      fecha: sust.inicio,
      minutos: sust.minutos,
      ejercicio: sust.ejercicio,
      bolsa: TipoBolsa.lista,
      temas: sust.temas,
      notas: sust.notas,
      titulo: 'Clase suelta',
      alumno: a.id,
      sustitucion: sust.id,
      modalidad: sust.modalidad,
      updatedAt: DateTime.now(),
    );
    await guardarSesion(s);
    return s;
  }

  // ------------------------------------------------------------------- General

  Future<void> borrarDatosLocales() async {
    await Future.wait([_alumnos.clear(), _sesiones.clear(), _perfil.clear()]);
  }

  /// Datos para la exportación en JSON (portabilidad RGPD).
  Map<String, dynamic> exportar() => {
        'preparador': {
          'perfil': perfil().toJson(),
          'misPreparadores': misPreparadores().map((v) => v.toJson()).toList(),
          'alumnos': alumnos().map((a) => a.toJson()).toList(),
          'sesiones': sesiones().map((s) => s.toJson()).toList(),
        },
      };
}
