import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../core/permiso_calendario.dart';
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

/// Si la cuenta puede conectar Google Calendar y, si no, por qué.
enum PermisoCalendario { permitido, sinSesion, noEnLista, sinPermiso, sinRed }

/// Cómo quedó la copia de una clase en la agenda del alumno.
enum EstadoCopia { enviada, sinRed, sinPermiso, otro }

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

  /// Sin red, Firestore no termina la escritura hasta que vuelve la conexión
  /// (la deja en cola y la sube sola): no se espera más que esto.
  static const _esperaNube = Duration(seconds: 8);

  DocumentReference<Map<String, dynamic>>? get _docPerfil => _docUsuario?.collection('progress').doc('preparador');

  /// Claves del perfil que solo se escriben cuando tienen valor.
  static const _clavesOpcionales = ['segundosTemaAntes', 'modalidad', 'ciudad', 'calendarioGoogle'];

  Future<void> guardarPerfil(PerfilPreparador p) async {
    await _perfil.put('perfil', p.toJson());
    try {
      final doc = _docPerfil;
      if (doc == null) return;
      if (p.codigo != null) {
        await doc.set(p.toJson()).timeout(_esperaNube);
      } else {
        // Sin código en este dispositivo (p. ej. recién instalado): no se
        // borra el que haya en la nube, que es el que tienen los alumnos.
        final datos = p.toJson()..remove('codigo');
        for (final k in _clavesOpcionales) {
          datos.putIfAbsent(k, FieldValue.delete);
        }
        await doc.set(datos, SetOptions(merge: true)).timeout(_esperaNube);
      }
    } catch (_) {
      // Sin red: se sube en la próxima sincronización.
    }
  }

  /// Si este dispositivo no tiene el código pero la nube sí (otro móvil, el
  /// navegador, una reinstalación), se usa ese: el código no cambia nunca.
  Future<void> _traerCodigoDeLaNube() async {
    final doc = _docPerfil;
    if (doc == null || perfil().codigo != null) return;
    try {
      DocumentSnapshot<Map<String, dynamic>> snap;
      try {
        snap = await doc.get(const GetOptions(source: Source.server));
      } catch (_) {
        snap = await doc.get();
      }
      final nube = snap.exists ? PerfilPreparador.fromJson(snap.data()) : null;
      if (nube?.codigo == null) return;
      final local = perfil();
      final masNueva = (nube!.updatedAt ?? DateTime(0)).isAfter(local.updatedAt ?? DateTime(0));
      await _perfil.put('perfil', masNueva ? nube.toJson() : {...local.toJson(), 'codigo': nube.codigo});
    } catch (_) {}
  }

  Future<void>? _activacionEnCurso;

  /// Activa «Soy preparador». Con sesión reserva además el código que se da
  /// a los alumnos (o recupera el que ya tenía); sin sesión, la herramienta
  /// funciona solo en este dispositivo. Las llamadas van de una en una para
  /// que dos a la vez no reserven dos códigos.
  Future<PerfilPreparador> activar({String? nombre}) async {
    while (_activacionEnCurso != null) {
      await _activacionEnCurso;
    }
    final hecho = Completer<void>();
    _activacionEnCurso = hecho.future;
    try {
      return await _activar(nombre: nombre);
    } finally {
      _activacionEnCurso = null;
      hecho.complete();
    }
  }

  Future<PerfilPreparador> _activar({String? nombre}) async {
    await _traerCodigoDeLaNube();
    var p = perfil();
    final nuevoNombre = nombre ?? (p.nombre.isEmpty ? (_auth?.currentUser?.displayName ?? '') : null);
    if (!p.activo || (nuevoNombre != null && nuevoNombre != p.nombre)) {
      p = p.copyWith(activo: true, nombre: nuevoNombre);
      await guardarPerfil(p);
    }
    if (conSesion && p.codigo == null) {
      final codigo = await _reservarCodigo(p.nombre);
      if (codigo != null) {
        p = perfil().copyWith(codigo: codigo);
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
      final docPerfil = _docPerfil!;
      for (var i = 0; i < 6; i++) {
        final codigo = generarCodigo();
        final doc = oposicion.red(_db!, 'codigos').doc(codigo);
        // En una transacción (siempre contra el servidor): si otro dispositivo
        // ya ha reservado el código de este preparador, se usa ese; si el
        // código nuevo ya es de otro, se prueba otro.
        final r = await _db.runTransaction<String?>((tx) async {
          final yaTenia = (await tx.get(docPerfil)).data()?['codigo'];
          if (yaTenia is String && yaTenia.isNotEmpty) return yaTenia;
          if ((await tx.get(doc)).exists) return null;
          tx.set(doc, {'uid': uid, 'nombre': nombre, 'creado': DateTime.now().toIso8601String()});
          tx.set(docPerfil, {'codigo': codigo}, SetOptions(merge: true));
          return codigo;
        });
        if (r != null) return r;
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

  /// Los alumnos del preparador: sin los de las clases sueltas que ha cogido,
  /// que no son alumnos suyos hasta que escriban su código.
  List<Alumno> misAlumnos() => alumnos().where((a) => !a.suelto).toList();

  Alumno? alumno(String id) {
    final j = _alumnos.get(id) as Map?;
    return j == null ? null : Alumno.fromJson(j);
  }

  Future<void> guardarAlumno(Alumno a) async {
    await _alumnos.put(a.id, a.toJson());
    try {
      await _docUsuario?.collection('alumnos').doc(a.id).set(a.toJson()).timeout(_esperaNube);
    } catch (_) {}
  }

  /// Une dos fichas del mismo alumno: la que se apuntó a mano ([sinApp]) y la
  /// que apareció al enlazar su app ([enlazado]). Las clases, las clases
  /// fijas, las notas, el teléfono y los temas pasan a la enlazada (y las
  /// clases se le copian a su agenda); la de a mano desaparece.
  Future<Alumno> unirAlumnos(Alumno sinApp, Alumno enlazado) async {
    if (sinApp.id == enlazado.id) return enlazado;
    final unido = enlazado.copyWith(
      ejercicio: enlazado.ejercicio == 3 && sinApp.ejercicio != 3 ? sinApp.ejercicio : null,
      notas: [enlazado.notas, sinApp.notas].where((n) => n.trim().isNotEmpty).join('\n'),
      temas: enlazado.temas.isEmpty ? sinApp.temas : null,
      telefono: enlazado.telefono.isEmpty ? sinApp.telefono : null,
      email: enlazado.email.isEmpty ? sinApp.email : null,
      clasesFijas: [...enlazado.clasesFijas, ...sinApp.clasesFijas],
    );
    await guardarAlumno(unido);
    for (final s in _todasLasSesiones().where((s) => s.alumno == sinApp.id)) {
      await guardarSesion(s.copyWith(alumno: unido.id));
    }
    await guardarAlumno(sinApp.copyWith(borrado: true, desenlazar: true, clasesFijas: const []));
    return unido;
  }

  /// Hasta la 1.15.3, coger una clase suelta de alguien con el mismo teléfono
  /// que una ficha apuntada a mano convertía esa ficha en «suelta» (y salía de
  /// «Mis alumnos»). Se separan otra vez: la de a mano vuelve a ser como era y
  /// las clases sueltas pasan a una ficha suelta propia.
  Future<void> _separarFichasSueltas() async {
    for (final a in _todosLosAlumnos().where((a) => a.suelto && !a.borrado && !a.id.startsWith('sust_'))) {
      final sueltas = _todasLasSesiones().where((s) => s.alumno == a.id && s.sustitucion != null).toList();
      if (sueltas.isNotEmpty) {
        final suelta = Alumno(id: 'sust_${sueltas.first.sustitucion}', nombre: a.nombre, ejercicio: a.ejercicio, telefono: a.telefono, uid: a.uid, suelto: true, creado: DateTime.now(), updatedAt: DateTime.now());
        await guardarAlumno(suelta);
        for (final s in sueltas) {
          await guardarSesion(s.copyWith(alumno: suelta.id));
        }
      }
      await guardarAlumno(a.copyWith(desenlazar: true));
    }
  }

  /// Clases sueltas cuya ficha ha perdido el uid del alumno (p. ej. una
  /// versión antigua de la app, que no conocía las fichas «sueltas», la tomó
  /// por un alumno que había roto el enlace y se lo quitó): sin uid, la clase
  /// no llega a su agenda y no se le pueden mandar temas. El uid se recupera
  /// de la sustitución cogida (la puede leer quien la cogió). Con [soloId],
  /// solo esa clase. Devuelve cuántas se han arreglado.
  Future<int> repararClasesSueltas({String? soloId}) async {
    if (!conSesion) return 0;
    var arregladas = 0;
    final sueltas = _todasLasSesiones().where((s) => s.sustitucion != null && !s.borrado && (soloId == null || s.id == soloId)).toList();
    for (final s in sueltas) {
      final a = s.alumno == null ? null : alumno(s.alumno!);
      if (a != null && a.uid != null && !a.borrado) continue;
      String? uidAlumno;
      try {
        final d = await oposicion.red(_db!, 'sustituciones').doc(s.sustitucion).get().timeout(_esperaNube);
        if (d.data()?['cogidaPor'] != uid) continue;
        uidAlumno = d.data()?['alumno'] as String?;
      } catch (_) {
        continue;
      }
      if (uidAlumno == null || uidAlumno.isEmpty) continue;
      // Si ya es alumno suyo (enlazado) o tiene otra ficha suelta, va a esa.
      final destino = alumnoConUid(uidAlumno) ??
          (a != null && a.id.startsWith('sust_') ? a.copyWith(uid: uidAlumno, suelto: true, borrado: false) : null) ??
          Alumno(id: 'sust_${s.sustitucion}', nombre: a?.nombre ?? 'Alumno', ejercicio: s.ejercicio, telefono: a?.telefono ?? '', uid: uidAlumno, suelto: true, creado: DateTime.now(), updatedAt: DateTime.now());
      if (alumno(destino.id)?.uid != destino.uid || alumno(destino.id)?.borrado == true) await guardarAlumno(destino);
      await guardarSesion(s.copyWith(alumno: destino.id));
      arregladas++;
    }
    return arregladas;
  }

  /// La ficha apuntada a mano que parece ser la misma persona que [uid]
  /// (mismo correo o mismo nombre), para unirlas al enlazarse.
  Alumno? _fichaSinAppDe(String nombre, String email) {
    final n = nombre.trim().toLowerCase(), e = email.trim().toLowerCase();
    final sinApp = _todosLosAlumnos().where((a) => !a.borrado && a.uid == null);
    return sinApp.where((a) => e.isNotEmpty && a.email.trim().toLowerCase() == e).firstOrNull ?? sinApp.where((a) => n.isNotEmpty && a.nombre.trim().toLowerCase() == n).firstOrNull;
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
      cal.ultimoError = permisoRetirado(e)
          ? 'Google ha retirado el permiso del calendario (o ha caducado): apaga y vuelve a encender «Mis clases en Google Calendar» en Ajustes de preparador.'
          : (e is DioException ? (e.response?.data?.toString() ?? e.message ?? e.type.name) : e.toString());
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
    // A un alumno con app: enlazado o el de una clase suelta (las reglas
    // dejan escribirlo a quien cogió la clase).
    if (!conSesion || a == null || a.uid == null) return;
    final doc = oposicion.red(_db!, 'temasAnticipados').doc(s.id);
    try {
      if (s.mandaTema && s.pendiente && !s.borrado) {
        await doc.set({
          'alumno': a.uid,
          'preparador': uid,
          'preparadorNombre': perfil().nombre,
          // El primero también en singular, para las versiones anteriores de la app.
          'tema': s.temasMandados.first,
          'titulo': tituloTema?.call(s.temasMandados.first) ?? '',
          'temas': s.temasMandados,
          'titulos': [for (final t in s.temasMandados) tituloTema?.call(t) ?? ''],
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
        ..remove('temasMandados')
        ..remove('temaSorteado'),
      'titulo': s.titulo.isNotEmpty ? s.titulo : (nombre.isEmpty ? 'Preparador' : 'Con $nombre'),
      'preparador': uid,
      'preparadorNombre': nombre,
    };
  }

  /// Copias que no llegaron al alumno (sin red, sin permiso…), por id de clase,
  /// con el motivo. Se reintentan en cada sincronización.
  Map<String, EstadoCopia> copiasPendientes() => {
        for (final e in ((_perfil.get('copiasPendientes') as Map?) ?? const {}).entries)
          e.key.toString(): EstadoCopia.values.firstWhere((x) => x.name == e.value, orElse: () => EstadoCopia.otro),
      };

  Future<void> _anotarCopia(String id, EstadoCopia? estado) async {
    final m = {for (final e in copiasPendientes().entries) e.key: e.value.name};
    estado == null ? m.remove(id) : m[id] = estado.name;
    await _perfil.put('copiasPendientes', m);
  }

  /// Estado de la copia de una clase en la agenda del alumno: enviada si no
  /// consta como pendiente.
  EstadoCopia estadoCopia(String id) => copiasPendientes()[id] ?? EstadoCopia.enviada;

  /// Lleva la clase a la agenda del alumno (si tiene uid). Devuelve cómo quedó
  /// y, si no llegó, lo deja anotado para reintentarlo al sincronizar.
  Future<EstadoCopia> _copiarAlAlumno(Cante s) async {
    final a = s.alumno == null ? null : alumno(s.alumno!);
    if (!conSesion || a?.uid == null) return EstadoCopia.enviada;
    try {
      await oposicion.raizUsuario(_db!, a!.uid!).collection('cantes').doc(s.id).set(copiaParaAlumno(s));
      await _anotarCopia(s.id, null);
      return EstadoCopia.enviada;
    } on FirebaseException catch (e) {
      final estado = e.code == 'permission-denied' ? EstadoCopia.sinPermiso : (e.code == 'unavailable' ? EstadoCopia.sinRed : EstadoCopia.otro);
      await _anotarCopia(s.id, estado);
      return estado;
    } catch (_) {
      await _anotarCopia(s.id, EstadoCopia.otro);
      return EstadoCopia.otro;
    }
  }

  /// Vuelve a intentar la copia de una clase al alumno. Devuelve cómo quedó.
  Future<EstadoCopia> reintentarCopia(String id) async {
    final j = _sesiones.get(id) as Map?;
    if (j == null) return EstadoCopia.otro;
    return _copiarAlAlumno(Cante.fromJson(j));
  }

  /// Reintenta las copias que quedaron pendientes.
  Future<void> _reintentarCopiasPendientes() async {
    for (final id in copiasPendientes().keys.toList()) {
      final j = _sesiones.get(id) as Map?;
      if (j == null) {
        await _anotarCopia(id, null);
        continue;
      }
      await _copiarAlAlumno(Cante.fromJson(j));
    }
  }

  /// Si la cuenta puede usar Google Calendar mientras Google no verifica el
  /// permiso: la apunta el administrador en pruebasCalendario/{correo o uid}.
  /// Si no puede, dice por qué (para enseñarlo en Ajustes).
  Future<PermisoCalendario> calendarioPermitido() async {
    if (!conSesion) return PermisoCalendario.sinSesion;
    final yo = _auth!.currentUser!;
    try {
      final col = Oposiciones.tcee.red(_db!, 'pruebasCalendario');
      // Del servidor: la caché podría no tener el documento recién creado.
      if ((await col.doc(yo.uid).get(const GetOptions(source: Source.server))).exists) return PermisoCalendario.permitido;
      final email = yo.email?.toLowerCase();
      if (email != null && (await col.doc(email).get(const GetOptions(source: Source.server))).exists) return PermisoCalendario.permitido;
      return PermisoCalendario.noEnLista;
    } on FirebaseException catch (e) {
      return e.code == 'permission-denied' ? PermisoCalendario.sinPermiso : PermisoCalendario.sinRed;
    } catch (_) {
      return PermisoCalendario.sinRed;
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
      await lote.commit().timeout(_esperaNube);
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
    await _separarFichasSueltas();
    await repararClasesSueltas();
    try {
      final snap = await oposicion.red(_db!, 'preparadores').doc(uid).collection('alumnos').get();
      final enlazados = {for (final d in snap.docs) d.id: d.data()};
      final locales = _todosLosAlumnos();
      for (final e in enlazados.entries) {
        final existente = locales.where((a) => a.uid == e.key).firstOrNull;
        final email = (e.value['email'] as String?)?.trim() ?? '';
        if (existente != null && !existente.borrado) {
          // El correo de su cuenta, para invitarle a las clases en Google
          // Calendar; y si era un alumno de clase suelta, ya está enlazado.
          if ((existente.email.isEmpty && email.isNotEmpty) || existente.suelto) await guardarAlumno(existente.copyWith(email: email.isEmpty ? null : email, suelto: false));
          continue;
        }
        final nombre = (e.value['nombre'] as String?)?.trim() ?? '';
        final nuevo = Alumno(id: e.key, uid: e.key, nombre: nombre.isEmpty ? (email.isEmpty ? 'Alumno' : email) : nombre, email: email, creado: DateTime.now(), updatedAt: DateTime.now());
        await guardarAlumno(nuevo);
        // Si ya estaba apuntado a mano (mismo correo o nombre), es la misma
        // ficha: sus clases pasan a la enlazada y no queda duplicado.
        final aMano = _fichaSinAppDe(nombre, email);
        if (aMano != null) await unirAlumnos(aMano, nuevo);
      }
      for (final a in locales.where((a) => a.enlazado && !a.borrado && !enlazados.containsKey(a.uid))) {
        await guardarAlumno(a.copyWith(desenlazar: true));
      }
    } catch (_) {}
  }

  /// Concilia las clases con la agenda de cada alumno que tiene uid (enlazado
  /// o de clase suelta), en los dos sentidos:
  /// - lo que el alumno ha cambiado en su copia (su valoración, notas) y es
  ///   más reciente, se trae; se conservan el alumno, el título, el borrado y
  ///   los temas mandados del lado del preparador, así que si el alumno quita
  ///   una clase de su agenda, el preparador no la pierde;
  /// - lo que el preparador cambió y no llegó (la copia falta o es más
  ///   antigua), se vuelve a copiar.
  Future<void> _traerCambiosDeAlumnos() async {
    if (!conSesion || !perfil().activo) return;
    final locales = {for (final s in _todasLasSesiones()) s.id: s};
    final ahora = DateTime.now();
    for (final a in alumnos().where((a) => a.uid != null)) {
      final mias = locales.values.where((s) => s.alumno == a.id).toList();
      try {
        final List<DocumentSnapshot<Map<String, dynamic>>> docs;
        if (a.enlazado) {
          docs = (await oposicion.raizUsuario(_db!, a.uid!).collection('cantes').where('preparador', isEqualTo: uid).get()).docs;
        } else {
          // Alumno de clase suelta: las reglas solo dejan leer esa clase, una a una.
          docs = [for (final s in mias.where((s) => s.sustitucion != null)) await oposicion.raizUsuario(_db!, a.uid!).collection('cantes').doc(s.id).get()];
        }
        final suyas = {for (final d in docs) if (d.exists) d.id: Cante.fromJson({...d.data()!, 'id': d.id})};
        for (final d in docs) {
          final mia = locales[d.id];
          final suya = suyas[d.id];
          if (mia == null || suya == null) continue;
          if (!(suya.updatedAt ?? DateTime(0)).isAfter(mia.updatedAt ?? DateTime(0))) continue;
          final json = {
            ...suya.toJson(),
            'alumno': mia.alumno,
            'titulo': mia.titulo,
            'borrado': mia.borrado,
            if (mia.temaA != null) 'temaA': mia.temaA!.toIso8601String(),
            if (mia.temasMandados.isNotEmpty) 'temaMandado': mia.temasMandados.first,
            if (mia.temasMandados.isNotEmpty) 'temasMandados': mia.temasMandados,
            if (mia.temaSorteado) 'temaSorteado': true,
            if (mia.eventoGoogle.isNotEmpty) 'eventoGoogle': mia.eventoGoogle,
          }
            ..remove('preparador')
            ..remove('preparadorNombre');
          await _sesiones.put(d.id, json);
          await _docUsuario?.collection('sesiones').doc(d.id).set(json);
          locales[d.id] = Cante.fromJson(json);
        }
        // Lo mío que no ha llegado: clases que vienen (o canceladas hace poco)
        // cuya copia falta o es más antigua que la mía.
        for (final s in mias) {
          if (s.borrado && !suyas.containsKey(s.id)) continue;
          final cuenta = s.fecha.isAfter(ahora.subtract(const Duration(days: 2)));
          if (!cuenta) continue;
          final suya = suyas[s.id];
          final mia = locales[s.id]!;
          if (suya == null || (mia.updatedAt ?? DateTime(0)).isAfter(suya.updatedAt ?? DateTime(0))) await _copiarAlAlumno(mia);
        }
      } catch (_) {
        // Sin red o enlace roto: se intenta en la próxima sincronización.
      }
    }
  }

  /// Progreso que comparte un alumno enlazado (null si no lo está o no hay red).
  Future<ProgresoAlumno?> progreso(Alumno a) async {
    if (!conSesion || !a.enlazado) return null;
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
    if (!conSesion || !a.enlazado) return null;
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
    if (!conSesion || !a.enlazado) return;
    await oposicion.raizUsuario(_db!, a.uid!).collection('cronogramas').doc(c.id).update({'propuesta': p.toJson(), 'updatedAt': DateTime.now().toIso8601String()});
  }

  /// El preparador deja de llevar a un alumno enlazado: pierde el acceso a su progreso.
  Future<void> romperEnlaceConAlumno(Alumno a) async {
    if (!conSesion || !a.enlazado) return;
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
      // El código no se pierde nunca: si un lado no lo tiene, vale el del otro.
      final codigo = local.codigo ?? nube?.codigo;
      if (nube != null && (nube.updatedAt ?? DateTime(0)).isAfter(local.updatedAt ?? DateTime(0))) {
        await _perfil.put('perfil', {...nube.toJson(), 'codigo': nube.codigo ?? codigo});
        if (nube.codigo == null && codigo != null) await guardarPerfil(perfil());
      } else if (local.updatedAt != null) {
        if (local.codigo == null && codigo != null) await _perfil.put('perfil', {...local.toJson(), 'codigo': codigo});
        await guardarPerfil(perfil());
      }
      // Activado sin sesión: ahora que la hay, se reserva el código.
      if (perfil().activo && perfil().codigo == null) await activar();
    } catch (_) {}
  }

  /// La última sincronización de las sesiones con la nube falló: mientras
  /// tanto no se regeneran las clases fijas (se crearían encima de las
  /// movidas o canceladas en otro dispositivo).
  bool sincronizacionFallida = false;

  Future<bool> _sincronizarColeccion<T>({
    required String nombre,
    required Box caja,
    required T Function(Map<dynamic, dynamic>) leer,
    required Map<String, dynamic> Function(T) escribir,
    required DateTime? Function(T) marca,
    required String Function(T) id,
  }) async {
    final doc = _docUsuario;
    if (doc == null) return false;
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
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> sincronizarTodo() async {
    if (!conSesion) return;
    await _sincronizarVinculos();
    await _sincronizarPerfil();
    await _sincronizarColeccion<Alumno>(nombre: 'alumnos', caja: _alumnos, leer: Alumno.fromJson, escribir: (a) => a.toJson(), marca: (a) => a.updatedAt, id: (a) => a.id);
    sincronizacionFallida = !await _sincronizarColeccion<Cante>(nombre: 'sesiones', caja: _sesiones, leer: Cante.fromJson, escribir: (c) => c.toJson(), marca: (c) => c.updatedAt, id: (c) => c.id);
    await _sincronizarAlumnosEnlazados();
    await _reintentarCopiasPendientes();
    await _traerCambiosDeAlumnos();
    // Las clases que llegaron de otro dispositivo (o de la web) van también
    // al calendario, si está conectado en este.
    if (calendario != null && perfil().calendarioGoogle) {
      final ahora = DateTime.now();
      for (final s in sesiones().where((s) => s.pendiente && s.alumno != null && s.eventoGoogle.isEmpty && s.fecha.isAfter(ahora))) {
        if (await llevarAlCalendario(s.id)) alCambiarSesiones?.call();
      }
    }
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
    // Los materiales que compartió con sus alumnos.
    try {
      final mats = await oposicion.red(_db, 'materiales').where('preparador', isEqualTo: uid).get();
      for (var i = 0; i < mats.docs.length; i += 400) {
        final lote = _db.batch();
        for (final d in mats.docs.skip(i).take(400)) {
          lote.delete(d.reference);
        }
        await lote.commit();
      }
    } catch (_) {}
    final codigo = perfil().codigo;
    if (codigo != null) await oposicion.red(_db, 'codigos').doc(codigo).delete();
  }

  // ------------------------------------------------------------- Clases fijas

  /// Crea las sesiones de las clases fijas de cada alumno para las próximas
  /// [semanas]. Cada sesión tiene un id que sale de la clase y del día, así que
  /// no se duplica y, si el preparador borra o cancela una, no vuelve a salir.
  Future<int> generarClasesFijas({DateTime? ahora, int semanas = 6}) async {
    // Si no se han podido traer las sesiones de la nube, se espera: si no,
    // una clase movida o cancelada en otro dispositivo volvería a salir.
    if (sincronizacionFallida) return 0;
    final hoy = ahora ?? DateTime.now();
    final fin = DateTime(hoy.year, hoy.month, hoy.day + 7 * semanas);
    var nuevas = 0;
    for (final a in misAlumnos()) {
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

  /// El preparador ha cogido una sustitución: el cante pasa a sus sesiones.
  /// El alumno no pasa a ser alumno suyo: queda una ficha «suelta» (oculta en
  /// «Mis alumnos») con su uid y su teléfono, para que la clase y los temas
  /// mandados le lleguen a su agenda. Solo si ya era alumno enlazado, la clase
  /// va a su ficha de siempre. Una ficha apuntada a mano no se toca nunca.
  Future<Cante> sesionDeSustitucion(Sustitucion sust, ContactoRed alumno) async {
    final id = 'sust_${sust.id}';
    final existente = alumnoConUid(sust.alumno) ?? this.alumno(id);
    // Con el uid del alumno (sin enlazar: «suelto»), para que los cambios de
    // la clase le lleguen a su agenda.
    final a = (existente ?? Alumno(id: id, nombre: alumno.nombre.isEmpty ? 'Alumno' : alumno.nombre, creado: DateTime.now(), updatedAt: DateTime.now()))
        .copyWith(telefono: alumno.telefono, ejercicio: sust.ejercicio, temas: existente == null ? sust.temas : null, uid: existente?.uid ?? sust.alumno, suelto: existente?.enlazado == true ? false : true);
    await guardarAlumno(a);
    final s = Cante(
      id: id,
      fecha: sust.inicio,
      minutos: sust.minutos,
      ejercicio: sust.ejercicio,
      bolsa: TipoBolsa.lista,
      temas: sust.temas,
      // El alumno ve en la clase quién se la da y su teléfono (la copia de la
      // clase lleva estas notas).
      notas: [if (sust.notas.isNotEmpty) sust.notas, 'Te la da ${perfil().nombre.isEmpty ? 'un preparador' : perfil().nombre}${telefonoWhatsApp(perfil().telefono) == null ? '' : ' · ${perfil().telefono}'}'].join('\n'),
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
