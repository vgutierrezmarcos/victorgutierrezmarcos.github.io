import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/oposicion.dart';
import '../models/plan.dart';
import '../models/preparador.dart';
import '../models/red.dart';

/// Aviso de la red (sustitución nueva, cogida, reserva…) para notificar una vez.
class AvisoRed {
  const AvisoRed({required this.id, required this.titulo, required this.texto, this.ruta});
  /// Identificador estable: el mismo aviso no se repite (ver [RedRepo.avisosNuevos]).
  final String id;
  final String titulo;
  final String texto;
  /// Pantalla de la app que se abre al tocar el aviso (`/cantes?cante=…`,
  /// `/clase?id=…`, `/tablon`, `/semana`, `/mas/preparador`…).
  final String? ruta;
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

/// Explicación corta de un error de la red para el usuario.
String textoError(Object e) {
  if (e is ErrorRed) return e.mensaje;
  if (e is FirebaseException) {
    return switch (e.code) {
      'permission-denied' => 'sin permiso; comprueba que has iniciado sesión',
      'unavailable' || 'deadline-exceeded' => 'sin conexión',
      'unauthenticated' => 'la sesión ha caducado; vuelve a iniciarla',
      _ => e.code,
    };
  }
  if (e is TimeoutException) return 'sin conexión';
  return 'error inesperado';
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
  CollectionReference<Map<String, dynamic>> get _materiales => oposicion.red(_db!, 'materiales');
  CollectionReference<Map<String, dynamic>> get _busquedas => oposicion.red(_db!, 'busquedas');
  CollectionReference<Map<String, dynamic>> get _plazas => oposicion.red(_db!, 'plazas');

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
    final v = await miFicha();
    return v != null && v.activo ? v : null;
  }

  /// Su ficha de verificado, también si se la retiraron (activo = false).
  Future<PreparadorVerificado?> miFicha() async {
    if (!conSesion) return null;
    final d = await _verificados.doc(uid).get();
    return d.exists ? PreparadorVerificado.fromJson({...d.data()!, 'uid': d.id}) : null;
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
  /// [destinatario], solo a ese preparador (y al administrador). Si ya estuvo
  /// verificado y se la retiraron, la pide solo a la administración. Sin red,
  /// la petición queda en cola y se envía sola al volver la conexión: entonces
  /// devuelve false (true = ya ha llegado).
  Future<bool> solicitar({required String nombre, required List<int> ejercicios, required String presentacion, String linkedin = '', String modalidad = '', String ciudad = '', String? destinatario, String destinatarioNombre = '', Duration espera = const Duration(seconds: 10)}) async {
    if (!conSesion) throw const ErrorRed('Inicia sesión con Google para pedir la verificación.');
    PreparadorVerificado? ficha;
    try {
      ficha = await miFicha();
    } catch (_) {}
    if (ficha != null && ficha.activo) throw const ErrorRed('Ya estás verificado: no hace falta pedirlo otra vez.');
    final ciudadCorta = ciudad.trim();
    final escritura = _solicitudes.doc(uid).set(SolicitudPreparador(
      uid: uid!,
      nombre: _corta(nombre.trim(), 100),
      email: _auth!.currentUser!.email ?? '',
      ejercicios: ejercicios,
      presentacion: _corta(presentacion.trim(), 2000),
      linkedin: enlaceLinkedin(linkedin) ?? '',
      modalidad: const ['online', 'presencial', 'ambas'].contains(modalidad) ? modalidad : '',
      ciudad: _corta(ciudadCorta, 60),
      destinatario: destinatario,
      destinatarioNombre: _corta(destinatarioNombre, 100),
      creada: DateTime.now(),
      reverificacion: ficha != null,
    ).toJson());
    try {
      await escritura.timeout(espera);
      return true;
    } on TimeoutException {
      // Sigue en la cola de Firestore; si luego la rechazara el servidor, se
      // vería al abrir la sección (no aparecería como pendiente).
      unawaited(escritura.catchError((_) {}));
      return false;
    }
  }

  static String _corta(String s, int max) => s.length <= max ? s : s.substring(0, max);

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
    final v = PreparadorVerificado(uid: s.uid, nombre: s.nombre, ejercicios: s.ejercicios, linkedin: s.linkedin, modalidad: s.modalidad, ciudad: s.ciudad.length > 60 ? s.ciudad.substring(0, 60) : s.ciudad, avaladoPor: uid, avaladoPorNombre: avalNombre ?? _miNombre, desde: DateTime.now());
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
  Future<void> actualizarMiFicha({String? nombre, List<int>? ejercicios, String? linkedin, String? modalidad, String? ciudad}) => _verificados.doc(uid).update({
        if (nombre != null) 'nombre': nombre,
        if (ejercicios != null) 'ejercicios': ejercicios,
        if (linkedin != null) 'linkedin': linkedin.isEmpty ? '' : (enlaceLinkedin(linkedin) ?? ''),
        if (modalidad != null) 'modalidad': modalidad,
        if (ciudad != null) 'ciudad': ciudad.trim().length > 60 ? ciudad.trim().substring(0, 60) : ciudad.trim(),
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

  /// El alumno quita al preparador que le cogió clases sueltas: se borran esas
  /// peticiones, y con ellas el acceso de ese preparador a esas clases (su
  /// cronómetro, su pizarra y los temas). Devuelve cuántas.
  Future<int> olvidarSustituto(String preparador) async {
    if (!conSesion) return 0;
    final suyas = (await misPeticiones()).where((s) => s.cogidaPor == preparador).toList();
    for (final s in suyas) {
      await _sustituciones.doc(s.id).delete();
    }
    return suyas.length;
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

  // --------------------------------------------------------- Buscar preparador

  /// El opositor publica (o cambia) lo que busca.
  Future<void> guardarBusqueda(Busqueda b) async {
    if (!conSesion) throw const ErrorRed('Inicia sesión con Google para buscar preparador.');
    await _busquedas.doc(b.id).set(b.toJson());
  }

  Future<void> borrarBusqueda(String id) => _busquedas.doc(id).delete();

  /// Las búsquedas del opositor (abiertas y cerradas, la más reciente primero).
  Future<List<Busqueda>> misBusquedas() async {
    if (!conSesion) return const [];
    final snap = await _busquedas.where('alumno', isEqualTo: uid).get();
    return [for (final d in snap.docs) Busqueda.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => (b.creada ?? DateTime(0)).compareTo(a.creada ?? DateTime(0)));
  }

  /// Tablón del preparador verificado: lo que buscan los opositores.
  Future<List<Busqueda>> busquedasAbiertas() async {
    if (!conSesion) return const [];
    final snap = await _busquedas.where('estado', isEqualTo: 'abierta').get();
    return [for (final d in snap.docs) Busqueda.fromJson({...d.data(), 'id': d.id})].where((b) => b.alumno != uid).toList()..sort((a, b) => (b.creada ?? DateTime(0)).compareTo(a.creada ?? DateTime(0)));
  }

  /// El preparador dice que le interesa una búsqueda y deja su contacto.
  Future<void> interesarme(String busqueda, Interesado yo) => _busquedas.doc(busqueda).collection('interesados').doc(uid).set(yo.toJson());

  Future<void> retirarInteres(String busqueda) => _busquedas.doc(busqueda).collection('interesados').doc(uid).delete();

  /// Búsquedas en las que este preparador ya se ha interesado.
  Future<Set<String>> misIntereses(Iterable<String> busquedas) async {
    if (!conSesion) return const {};
    final out = <String>{};
    for (final b in busquedas) {
      try {
        if ((await _busquedas.doc(b).collection('interesados').doc(uid).get()).exists) out.add(b);
      } catch (_) {}
    }
    return out;
  }

  /// Los preparadores interesados en una búsqueda del opositor.
  Future<List<Interesado>> interesados(String busqueda) async {
    if (!conSesion) return const [];
    final snap = await _busquedas.doc(busqueda).collection('interesados').get();
    return [for (final d in snap.docs) Interesado.fromJson({...d.data(), 'uid': d.id})]..sort((a, b) => (a.creado ?? DateTime(0)).compareTo(b.creado ?? DateTime(0)));
  }

  /// Plazas del preparador (las suyas).
  Future<Plazas?> misPlazas() async {
    if (!conSesion) return null;
    final d = await _plazas.doc(uid).get();
    return d.exists ? Plazas.fromJson(d.data()!) : null;
  }

  Future<void> guardarPlazas(Plazas p) => _plazas.doc(uid).set(p.toJson());

  /// Preparadores que admiten alumnos nuevos (solo lo pueden leer los
  /// opositores: a un preparador verificado las reglas no se lo dejan).
  Future<List<Plazas>> plazasAbiertas() async {
    if (!conSesion) return const [];
    final snap = await _plazas.where('admite', isEqualTo: true).get();
    return [for (final d in snap.docs) Plazas.fromJson(d.data())];
  }

  // --------------------------------------------------------------- Materiales

  /// El preparador comparte (o cambia) un material.
  Future<void> guardarMaterial(MaterialCompartido m) async {
    if (!conSesion) throw const ErrorRed('Inicia sesión con Google para compartir materiales.');
    await _materiales.doc(m.id).set(m.toJson());
  }

  Future<void> borrarMaterial(String id) => _materiales.doc(id).delete();

  /// Los materiales que ha compartido el preparador (los más recientes primero).
  Future<List<MaterialCompartido>> misMateriales() async {
    if (!conSesion) return const [];
    final snap = await _materiales.where('preparador', isEqualTo: uid).get();
    return [for (final d in snap.docs) MaterialCompartido.fromJson({...d.data(), 'id': d.id})]..sort((a, b) => (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
  }

  /// Los materiales de [preparador] que van al alumno: los de todos sus
  /// alumnos y los dirigidos a él (dos consultas, que son las que las reglas
  /// dejan hacer).
  Future<List<MaterialCompartido>> materialesDe(String preparador) async {
    if (!conSesion) return const [];
    final todos = await _materiales.where('preparador', isEqualTo: preparador).where('paraTodos', isEqualTo: true).get();
    final mios = await _materiales.where('preparador', isEqualTo: preparador).where('alumnos', arrayContains: uid).get();
    final porId = {for (final d in [...todos.docs, ...mios.docs]) d.id: MaterialCompartido.fromJson({...d.data(), 'id': d.id})};
    return porId.values.toList()..sort((a, b) => (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
  }

  /// Los materiales de todos los preparadores con los que el alumno ha
  /// enlazado. Sin [preparadores] los lee de la nube (la tarea en segundo
  /// plano no tiene la lista local).
  Future<List<MaterialCompartido>> materialesParaMi({Iterable<String>? preparadores}) async {
    if (!conSesion) return const [];
    final lista = preparadores?.toList() ?? [for (final d in (await oposicion.raizUsuario(_db!, uid!).collection('preparadores').get()).docs) d.id];
    final out = <MaterialCompartido>[];
    for (final p in lista) {
      try {
        out.addAll(await materialesDe(p));
      } catch (_) {}
    }
    return out..sort((a, b) => (b.updatedAt ?? DateTime(0)).compareTo(a.updatedAt ?? DateTime(0)));
  }

  // ------------------------------------------------------------------- Avisos

  /// Lo que merece una notificación y aún no se ha notificado ([vistos]).
  /// [preparador]: el usuario es preparador verificado con los avisos de
  /// clases sueltas activados; [reservas], con los de reservas (por defecto,
  /// los mismos). Solo cuenta lo reciente (dos días), para no avisar de golpe
  /// de lo de antes.
  Future<List<AvisoRed>> avisosNuevos({required Set<String> vistos, required bool preparador, bool? reservas, bool admin = false, String Function(DateTime)? cuando}) async {
    if (!conSesion) return const [];
    String f(DateTime d) => cuando?.call(d) ?? '${d.day}/${d.month} a las ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    final out = <AvisoRed>[];
    final ahora = DateTime.now();
    try {
      // Solicitudes de verificación: al preparador al que se la piden y, las
      // abiertas, solo al administrador (no a todos los preparadores).
      final verificacion = await miVerificacion();
      final reciente = ahora.subtract(const Duration(days: 2));
      // Al aprobarse su verificación.
      if (verificacion != null && (verificacion.desde?.isAfter(reciente) ?? false)) {
        out.add(AvisoRed(id: 'verif:${oposicion.id}', titulo: 'Ya estás verificado como preparador', texto: 'Ya puedes dar tu código a tus alumnos y coger clases sueltas. Lo tienes en Más → Preparador.', ruta: '/mas/preparador'));
      }
      if (verificacion != null) {
        // Alumnos que acaban de conectar con su código.
        final enlazados = await oposicion.red(_db!, 'preparadores').doc(uid).collection('alumnos').get();
        for (final d in enlazados.docs) {
          final desde = DateTime.tryParse(d.data()['desde'] as String? ?? '');
          if (desde == null || desde.isBefore(reciente)) continue;
          final nombre = (d.data()['nombre'] as String?)?.trim() ?? '';
          out.add(AvisoRed(id: 'enl:${d.id}', titulo: '${nombre.isEmpty ? 'Un alumno' : nombre} se ha conectado contigo', texto: 'Ya ves sus temas y sus cantes en Más → Preparador.', ruta: '/mas/preparador'));
        }
      }
      if (admin || verificacion != null) {
        for (final sol in await solicitudesPendientes(admin: admin)) {
          if (sol.destinatario == uid || (admin && sol.destinatario == null)) {
            out.add(AvisoRed(id: 'sol:${sol.uid}:${sol.creada?.millisecondsSinceEpoch ?? 0}', titulo: '${sol.nombre} pide que le verifiques', texto: 'Como preparador o preparadora. Revísalo en Más → Preparador → Verificar preparadores.', ruta: '/mas/preparador'));
          }
        }
      }
      if (preparador) {
        for (final s in await tablon()) {
          out.add(AvisoRed(id: 'sust:${s.id}', titulo: 'Un alumno pide una clase suelta', texto: '${f(s.fecha)}${s.conFranja ? ' – ${_hm(s.hasta!)}' : ''} · ${s.descripcion}. Toca para verla y cogerla.', ruta: '/tablon'));
        }
      }
      if (reservas ?? preparador) {
        for (final r in (await reservasRecibidas()).where((r) => r.pedida && r.fecha.isAfter(ahora))) {
          out.add(AvisoRed(id: 'res:${r.id}', titulo: 'Reserva de ${r.alumnoNombre.isEmpty ? 'un alumno' : r.alumnoNombre}', texto: 'Quiere clase el ${f(r.fecha)}. Toca para aceptarla o rechazarla.', ruta: '/semana'));
        }
      }
      // Al alumno: clases que su preparador acaba de cancelar, programar o mover.
      final cantes = await oposicion.raizUsuario(_db!, uid!).collection('cantes').where('preparador', isNull: false).get();
      for (final d in cantes.docs) {
        final c = Cante.fromJson(d.data());
        // Las de reservas ya tienen su propio aviso; las clases sueltas, al
        // cogerse (sus cambios de hora o cancelación sí se avisan).
        final suelta = c.id.startsWith('sust_');
        if (c.id.startsWith('res_')) continue;
        if (c.borrado || !c.fecha.isAfter(ahora) || !(c.updatedAt?.isAfter(reciente) ?? false) || c.preparador == uid) continue;
        final quien = (c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre!;
        final ruta = '/cantes?cante=${c.id}';
        // Se sabe que es un cambio de hora porque ya se avisó de la misma clase con otra fecha.
        final avisada = vistos.any((v) => v.startsWith('prog:${c.id}:') || v.startsWith('mov:${c.id}:') || v == 'cog:${c.sustitucion ?? ''}');
        // La ha cancelado el propio alumno: no hay nada que avisarle.
        if (c.cancelado && c.canceladoPor == uid) continue;
        if (c.cancelado) {
          out.add(AvisoRed(id: 'canc:${c.id}', titulo: '$quien ha cancelado tu clase', texto: 'La del ${f(c.fecha)}${c.motivo.isEmpty ? '' : ' (${c.motivo})'}. Toca para verla o pedir una clase suelta.', ruta: ruta));
        } else if (!c.hecho && avisada) {
          out.add(AvisoRed(id: 'mov:${c.id}:${c.fecha.toIso8601String()}', titulo: '$quien ha movido tu clase', texto: 'Ahora es el ${f(c.fecha)}. Toca para verla.', ruta: ruta));
        } else if (!c.hecho && !suelta) {
          out.add(AvisoRed(id: 'prog:${c.id}:${c.fecha.toIso8601String()}', titulo: '$quien te ha programado una clase', texto: 'El ${f(c.fecha)}. Toca para verla.', ruta: ruta));
        }
      }
      for (final s in (await misPeticiones()).where((s) => s.cogida && s.vigente(ahora))) {
        out.add(AvisoRed(id: 'cog:${s.id}', titulo: '${s.cogidaPorNombre.isEmpty ? 'Un preparador' : s.cogidaPorNombre} te coge el cante', texto: 'El ${f(s.inicio)}. Toca para verlo y escribirle por WhatsApp.', ruta: '/cantes?cante=sust_${s.id}'));
      }
      for (final r in (await misReservas()).where((r) => !r.pedida && r.estado != EstadoReserva.cancelada && r.fecha.isAfter(ahora))) {
        out.add(AvisoRed(id: 'resp:${r.id}:${r.estado.name}', titulo: r.estado == EstadoReserva.aceptada ? 'Reserva aceptada' : 'Reserva rechazada', texto: 'Tu clase del ${f(r.fecha)}.', ruta: r.estado == EstadoReserva.aceptada ? '/cantes?cante=res_${r.id}' : '/mas/mi-preparador'));
      }
      // Al preparador: opositores que buscan preparador (si prepara ese ejercicio).
      if (preparador) {
        for (final b in await busquedasAbiertas()) {
          if (!(b.creada?.isAfter(reciente) ?? false)) continue;
          if (verificacion != null && compatibilidad(b, verificacion) == 0) continue;
          out.add(AvisoRed(id: 'busq:${b.id}', titulo: 'Un opositor busca preparador', texto: '${b.descripcion}. Toca para verlo y, si te interesa, dejarle tu contacto.', ruta: '/busquedas'));
        }
      }
      // Al opositor: preparadores a los que les interesa su búsqueda.
      for (final b in (await misBusquedas()).where((b) => b.abierta)) {
        for (final i in await interesados(b.id)) {
          if (!(i.creado?.isAfter(reciente) ?? false)) continue;
          out.add(AvisoRed(id: 'int:${b.id}:${i.uid}', titulo: 'A ${i.nombre.isEmpty ? 'un preparador' : i.nombre} le interesa prepararte', texto: 'Toca para ver su perfil y escribirle.', ruta: '/buscar-preparador'));
        }
      }
      // Materiales que un preparador acaba de compartir conmigo.
      for (final m in await materialesParaMi()) {
        if (m.preparador == uid || !(m.updatedAt?.isAfter(reciente) ?? false)) continue;
        out.add(AvisoRed(id: 'mat:${m.id}', titulo: '${m.preparadorNombre.isEmpty ? 'Tu preparador' : m.preparadorNombre} te ha compartido material', texto: '${m.titulo}${m.tema == null ? '' : ' · Tema ${m.tema}'}. Toca para abrirlo.', ruta: '/mas/mi-preparador'));
      }
    } catch (_) {
      // Sin red o sin permiso: se intenta en la próxima.
    }
    return out.where((a) => !vistos.contains(a.id)).toList();
  }

  /// ¿Tiene activados los avisos de reservas? (lo lee la tarea en segundo plano).
  Future<bool> quiereAvisosDeReservas() async {
    if (!conSesion) return false;
    try {
      if (await miVerificacion() == null) return false;
      final d = await oposicion.raizUsuario(_db!, uid!).collection('progress').doc('preparador').get();
      return PerfilPreparador.fromJson(d.data()).avisosReservas;
    } catch (_) {
      return false;
    }
  }

  /// ¿Tiene activados los avisos de clases sueltas? (lo lee la tarea en segundo plano).
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
