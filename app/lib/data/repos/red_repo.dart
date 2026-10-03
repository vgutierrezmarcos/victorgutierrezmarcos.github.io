import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/oposicion.dart';
import '../models/preparador.dart';
import '../models/red.dart';

/// Aviso de la red (sustitución nueva, cogida, reserva…) para notificar una vez.
class AvisoRed {
  const AvisoRed({required this.id, required this.titulo, required this.texto});
  /// Identificador estable: el mismo aviso no se repite (ver [RedRepo.avisosNuevos]).
  final String id;
  final String titulo;
  final String texto;
}

/// Resultado de comprobar si el usuario es administrador.
///  - [si]: existe admins/{uid}.
///  - [no]: no existe ese documento (o se creó con otro identificador).
///  - [sinPermiso]: el servidor no deja leerlo: faltan por publicar las reglas.
///  - [sinRed]: no se pudo comprobar.
enum DiagnosticoAdmin { si, no, sinPermiso, sinRed }

/// Error con un mensaje para el usuario.
class ErrorRed implements Exception {
  const ErrorRed(this.mensaje);
  final String mensaje;
  @override
  String toString() => mensaje;
}

/// Red de preparadores en Firestore (modelos en data/models/red.dart y reglas
/// en firestore.rules). Sin sesión no hace nada: todo necesita cuenta.
class RedRepo {
  RedRepo({FirebaseFirestore? firestore, FirebaseAuth? auth, this.oposicion = Oposiciones.tcee})
      : _db = firestore,
        _auth = auth;

  /// La red es de una oposición: sus verificados, administradores y peticiones.
  final Oposicion oposicion;
  final FirebaseFirestore? _db;
  final FirebaseAuth? _auth;

  String? get uid => _auth?.currentUser?.uid;
  bool get conSesion => uid != null && _db != null;
  String get _miNombre => _auth?.currentUser?.displayName ?? '';

  CollectionReference<Map<String, dynamic>> get _verificados => oposicion.red(_db!, 'preparadoresVerificados');
  CollectionReference<Map<String, dynamic>> get _solicitudes => oposicion.red(_db!, 'solicitudesPreparador');
  CollectionReference<Map<String, dynamic>> get _sustituciones => oposicion.red(_db!, 'sustituciones');
  CollectionReference<Map<String, dynamic>> get _reservas => oposicion.red(_db!, 'reservas');

  // -------------------------------------------------------------- Verificación

  /// El usuario es administrador de la red de esta oposición (documento
  /// admins/{uid} —en DCE, oposiciones/dce/admins/{uid}—, creado en la consola)
  /// o administrador general (admins/{uid} de la raíz con `general: true`).
  Future<bool> esAdmin() async => await diagnosticoAdmin() == DiagnosticoAdmin.si;

  /// Si es administrador de [otra] oposición (para dejarle verla antes de que
  /// se lance).
  Future<bool> esAdminEn(Oposicion otra) async =>
      await RedRepo(firestore: _db, auth: _auth, oposicion: otra).diagnosticoAdmin() == DiagnosticoAdmin.si;

  /// Su documento de administrador en [admins] (llamado como su uid o como su
  /// correo de Google), o null.
  Future<DocumentSnapshot<Map<String, dynamic>>?> _docAdmin(CollectionReference<Map<String, dynamic>> admins) async {
    final porUid = await admins.doc(uid).get(const GetOptions(source: Source.server));
    if (porUid.exists) return porUid;
    final correo = _auth!.currentUser?.email?.trim().toLowerCase();
    if (correo == null || correo.isEmpty) return null;
    final porCorreo = await admins.doc(correo).get(const GetOptions(source: Source.server));
    return porCorreo.exists ? porCorreo : null;
  }

  /// Por qué el usuario es o no es administrador, para explicárselo.
  Future<DiagnosticoAdmin> diagnosticoAdmin() async {
    if (!conSesion) return DiagnosticoAdmin.no;
    try {
      if (await _docAdmin(oposicion.red(_db!, 'admins')) != null) return DiagnosticoAdmin.si;
      // El administrador general lo es de todas las oposiciones.
      if (!oposicion.esPrincipal && (await _docAdmin(_db.collection('admins')))?.data()?['general'] == true) return DiagnosticoAdmin.si;
      return DiagnosticoAdmin.no;
    } on FirebaseException catch (e) {
      return e.code == 'permission-denied' ? DiagnosticoAdmin.sinPermiso : DiagnosticoAdmin.sinRed;
    } catch (_) {
      return DiagnosticoAdmin.sinRed;
    }
  }

  /// Verificación del usuario (null si no está verificado o se la retiraron).
  Future<PreparadorVerificado?> miVerificacion() async {
    if (!conSesion) return null;
    final d = await _verificados.doc(uid).get();
    final v = d.exists ? PreparadorVerificado.fromJson({...d.data()!, 'uid': d.id}) : null;
    return v != null && v.activo ? v : null;
  }

  /// Preparadores verificados en activo, por nombre.
  Future<List<PreparadorVerificado>> verificados({bool incluirRetirados = false}) async {
    if (!conSesion) return const [];
    final snap = await _verificados.get();
    return [for (final d in snap.docs) PreparadorVerificado.fromJson({...d.data(), 'uid': d.id})]
        .where((v) => incluirRetirados || v.activo)
        .toList()
      ..sort((a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()));
  }

  Future<SolicitudPreparador?> miSolicitud() async {
    if (!conSesion) return null;
    final d = await _solicitudes.doc(uid).get();
    return d.exists ? SolicitudPreparador.fromJson({...d.data()!, 'uid': d.id}) : null;
  }

  /// Pide la verificación al administrador y a cualquier verificado o, con
  /// [destinatario], solo a ese preparador (y al administrador).
  Future<void> solicitar({required String nombre, required List<int> ejercicios, required String presentacion, String linkedin = '', String? destinatario, String destinatarioNombre = ''}) async {
    if (!conSesion) throw const ErrorRed('Inicia sesión con Google para pedir la verificación.');
    await _solicitudes.doc(uid).set(SolicitudPreparador(
      uid: uid!,
      nombre: nombre.trim(),
      email: _auth!.currentUser!.email ?? '',
      ejercicios: ejercicios,
      presentacion: presentacion.trim(),
      linkedin: enlaceLinkedin(linkedin) ?? '',
      destinatario: destinatario,
      destinatarioNombre: destinatarioNombre,
      creada: DateTime.now(),
    ).toJson());
  }

  Future<void> retirarSolicitud() async {
    if (conSesion) await _solicitudes.doc(uid).delete();
  }

  /// Solicitudes pendientes: el administrador las ve todas; un verificado,
  /// las abiertas a cualquiera y las que le piden a él.
  Future<List<SolicitudPreparador>> solicitudesPendientes({bool admin = false}) async {
    if (!conSesion) return const [];
    final docs = admin
        ? (await _solicitudes.get()).docs
        : [...(await _solicitudes.where('paraTodos', isEqualTo: true).get()).docs, ...(await _solicitudes.where('destinatario', isEqualTo: uid).get()).docs];
    final porId = {for (final d in docs) d.id: SolicitudPreparador.fromJson({...d.data(), 'uid': d.id})};
    return porId.values.where((s) => s.uid != uid).toList()..sort((a, b) => (a.creada ?? DateTime(0)).compareTo(b.creada ?? DateTime(0)));
  }

  /// Verifica a quien lo pidió, avalado por el usuario (verificado o administrador).
  Future<void> aprobar(SolicitudPreparador s, {String? avalNombre}) async {
    final v = PreparadorVerificado(uid: s.uid, nombre: s.nombre, ejercicios: s.ejercicios, linkedin: s.linkedin, avaladoPor: uid, avaladoPorNombre: avalNombre ?? _miNombre, desde: DateTime.now());
    final lote = _db!.batch()
      ..set(_verificados.doc(s.uid), v.toJson())
      ..delete(_solicitudes.doc(s.uid));
    await lote.commit();
  }

  Future<void> rechazar(SolicitudPreparador s) => _solicitudes.doc(s.uid).delete();

  /// Solo el administrador: se verifica a sí mismo (primer preparador de la red).
  Future<void> verificarme({required String nombre, List<int>? ejercicios}) =>
      _verificados.doc(uid).set(PreparadorVerificado(uid: uid!, nombre: nombre, ejercicios: ejercicios ?? ejerciciosConCante, avaladoPor: uid, avaladoPorNombre: nombre, desde: DateTime.now()).toJson());

  /// Solo el administrador: retira (o devuelve) la verificación. Con [cascada]
  /// retira también a quienes verificó esa persona.
  Future<int> cambiarActivo(PreparadorVerificado v, {required bool activo, bool cascada = false}) async {
    final afectados = <String>{v.uid};
    if (cascada && !activo) {
      final todos = await verificados(incluirRetirados: true);
      // Toda la cadena de avales que cuelga de él.
      var nuevos = {v.uid};
      while (nuevos.isNotEmpty) {
        nuevos = {for (final x in todos) if (nuevos.contains(x.avaladoPor) && !afectados.contains(x.uid) && x.uid != x.avaladoPor) x.uid};
        afectados.addAll(nuevos);
      }
    }
    final lote = _db!.batch();
    for (final u in afectados) {
      lote.update(_verificados.doc(u), {'activo': activo});
    }
    await lote.commit();
    return afectados.length;
  }

  /// El preparador cambia cómo aparece en la lista (no su verificación).
  Future<void> actualizarMiFicha({String? nombre, List<int>? ejercicios, String? linkedin}) => _verificados.doc(uid).update({
        if (nombre != null) 'nombre': nombre,
        if (ejercicios != null) 'ejercicios': ejercicios,
        if (linkedin != null) 'linkedin': linkedin.isEmpty ? '' : (enlaceLinkedin(linkedin) ?? ''),
      });

  // ------------------------------------------------------------- Sustituciones

  /// El alumno publica la petición con su contacto, que solo verá quien la coja.
  Future<void> publicarSustitucion(Sustitucion s, ContactoRed contacto) async {
    if (!conSesion) throw const ErrorRed('Inicia sesión con Google para buscar sustituto.');
    if (telefonoWhatsApp(contacto.telefono) == null) throw const ErrorRed('Escribe un teléfono válido para que el sustituto pueda escribirte por WhatsApp.');
    final ref = _sustituciones.doc(s.id);
    final lote = _db!.batch()
      ..set(ref, s.toJson())
      ..set(ref.collection('privado').doc('alumno'), contacto.toJson());
    await lote.commit();
  }

  Future<void> cancelarSustitucion(Sustitucion s) => _sustituciones.doc(s.id).update({'estado': EstadoSustitucion.cancelada.name, 'updatedAt': DateTime.now().toIso8601String()});

  /// Peticiones del usuario como alumno (las más recientes primero).
  Future<List<Sustitucion>> misPeticiones() async {
    if (!conSesion) return const [];
    final snap = await _sustituciones.where('alumno', isEqualTo: uid).get();
    return [for (final d in snap.docs) Sustitucion.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => b.fecha.compareTo(a.fecha));
  }

  /// Tablón del preparador verificado: peticiones abiertas y futuras dirigidas
  /// a todos o a él, salvo las suyas propias.
  Future<List<Sustitucion>> tablon() async {
    if (!conSesion) return const [];
    final todas = await _sustituciones.where('paraTodos', isEqualTo: true).get();
    final mias = await _sustituciones.where('destinatarios', arrayContains: uid).get();
    final porId = {for (final d in [...todas.docs, ...mias.docs]) d.id: Sustitucion.fromJson({...d.data(), 'id': d.id})};
    final ahora = DateTime.now();
    return porId.values.where((s) => s.abierta && s.vigente(ahora) && s.alumno != uid).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  /// Sustituciones que ha cogido el usuario.
  Future<List<Sustitucion>> cogidasPorMi() async {
    if (!conSesion) return const [];
    final snap = await _sustituciones.where('cogidaPor', isEqualTo: uid).get();
    return [for (final d in snap.docs) Sustitucion.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => b.fecha.compareTo(a.fecha));
  }

  /// El preparador coge la petición (gana el primero), a una [hora] dentro de
  /// la franja que dio el alumno, y deja su contacto. Devuelve el del alumno.
  Future<ContactoRed> coger(Sustitucion s, ContactoRed yo, {DateTime? hora}) async {
    if (telefonoWhatsApp(yo.telefono) == null) throw const ErrorRed('Escribe un teléfono válido para que el alumno pueda escribirte por WhatsApp.');
    final h = hora ?? s.fecha;
    if (h.isBefore(s.fecha) || h.isAfter(s.hasta ?? s.fecha)) throw const ErrorRed('Elige una hora dentro de la franja que ha dado el alumno.');
    final ref = _sustituciones.doc(s.id);
    await _db!.runTransaction((t) async {
      final d = await t.get(ref);
      final actual = d.exists ? Sustitucion.fromJson({...d.data()!, 'id': d.id}) : null;
      if (actual == null || !actual.abierta) throw const ErrorRed('Otro preparador ya ha cogido este cante o el alumno lo ha retirado.');
      t.update(ref, {'estado': EstadoSustitucion.cogida.name, 'cogidaPor': uid, 'cogidaPorNombre': yo.nombre, 'hora': h.toIso8601String(), 'updatedAt': DateTime.now().toIso8601String()});
    });
    await ref.collection('privado').doc('preparador').set(yo.toJson());
    return (await contacto(s.id, 'alumno'))!;
  }

  /// Contacto del alumno ('alumno') o del sustituto ('preparador').
  Future<ContactoRed?> contacto(String sustitucion, String quien) async {
    final d = await _sustituciones.doc(sustitucion).collection('privado').doc(quien).get();
    return d.exists ? ContactoRed.fromJson(d.data()!) : null;
  }

  // ------------------------------------------------------------ Huecos y reservas

  Future<void> publicarHuecos(HuecosPublicos h) async {
    if (conSesion) await oposicion.red(_db!, 'huecos').doc(uid).set(h.toJson());
  }

  Future<HuecosPublicos?> huecosDe(String preparador) async {
    if (!conSesion) return null;
    final d = await oposicion.red(_db!, 'huecos').doc(preparador).get();
    return d.exists ? HuecosPublicos.fromJson(d.data()!) : null;
  }

  Future<void> pedirReserva(Reserva r) => _reservas.doc(r.id).set(r.toJson());

  Future<List<Reserva>> reservasRecibidas() async {
    if (!conSesion) return const [];
    final snap = await _reservas.where('preparador', isEqualTo: uid).get();
    return [for (final d in snap.docs) Reserva.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  Future<List<Reserva>> misReservas() async {
    if (!conSesion) return const [];
    final snap = await _reservas.where('alumno', isEqualTo: uid).get();
    return [for (final d in snap.docs) Reserva.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => a.fecha.compareTo(b.fecha));
  }

  Future<void> cambiarReserva(Reserva r, EstadoReserva estado) => _reservas.doc(r.id).update({'estado': estado.name, 'updatedAt': DateTime.now().toIso8601String()});

  // ------------------------------------------------------------------- Avisos

  /// Lo que merece una notificación y aún no se ha notificado ([vistos]).
  /// [preparador]: el usuario es preparador verificado con los avisos de
  /// sustitución activados.
  Future<List<AvisoRed>> avisosNuevos({required Set<String> vistos, required bool preparador, bool admin = false, String Function(DateTime)? cuando}) async {
    if (!conSesion) return const [];
    String f(DateTime d) => cuando?.call(d) ?? '${d.day}/${d.month} a las ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    final out = <AvisoRed>[];
    final ahora = DateTime.now();
    try {
      // Solicitudes de verificación: al preparador al que se la piden y, las
      // abiertas, solo al administrador (no a todos los preparadores).
      if (admin || (await miVerificacion()) != null) {
        for (final sol in await solicitudesPendientes(admin: admin)) {
          if (sol.destinatario == uid || (admin && sol.destinatario == null)) {
            out.add(AvisoRed(id: 'sol:${sol.uid}', titulo: '${sol.nombre} pide que le verifiques', texto: 'Como preparador o preparadora. Revísalo en Preparadores → Verificar preparadores.'));
          }
        }
      }
      if (preparador) {
        for (final s in await tablon()) {
          out.add(AvisoRed(id: 'sust:${s.id}', titulo: 'Buscan preparador para un cante', texto: '${f(s.fecha)}${s.conFranja ? ' – ${_hm(s.hasta!)}' : ''} · ${s.descripcion}'));
        }
        for (final r in (await reservasRecibidas()).where((r) => r.pedida && r.fecha.isAfter(ahora))) {
          out.add(AvisoRed(id: 'res:${r.id}', titulo: 'Reserva de ${r.alumnoNombre.isEmpty ? 'un alumno' : r.alumnoNombre}', texto: 'Quiere clase el ${f(r.fecha)}. Acéptala o recházala en Preparadores.'));
        }
      }
      for (final s in (await misPeticiones()).where((s) => s.cogida && s.vigente(ahora))) {
        out.add(AvisoRed(id: 'cog:${s.id}', titulo: '${s.cogidaPorNombre.isEmpty ? 'Un preparador' : s.cogidaPorNombre} te coge el cante', texto: 'El ${f(s.inicio)}. Abre la app para escribirle por WhatsApp.'));
      }
      for (final r in (await misReservas()).where((r) => !r.pedida && r.estado != EstadoReserva.cancelada && r.fecha.isAfter(ahora))) {
        out.add(AvisoRed(id: 'resp:${r.id}:${r.estado.name}', titulo: r.estado == EstadoReserva.aceptada ? 'Reserva aceptada' : 'Reserva rechazada', texto: 'Tu clase del ${f(r.fecha)}.'));
      }
    } catch (_) {
      // Sin red o sin permiso: se intenta en la próxima.
    }
    return out.where((a) => !vistos.contains(a.id)).toList();
  }

  /// ¿Tiene activados los avisos de sustitución? (lo lee la tarea en segundo plano).
  Future<bool> quiereAvisosDeSustitucion() async {
    if (!conSesion) return false;
    try {
      final v = await miVerificacion();
      if (v == null) return false;
      final d = await oposicion.raizUsuario(_db!, uid!).collection('progress').doc('preparador').get();
      return PerfilPreparador.fromJson(d.data()).avisosSustitucion;
    } catch (_) {
      return false;
    }
  }
}

String _hm(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
