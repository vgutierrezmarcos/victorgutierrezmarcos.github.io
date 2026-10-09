import 'dart:math';

import 'oposicion.dart';
import 'plan.dart';

/// Modelos de la sección de preparadores. El preparador guarda a sus alumnos
/// y sus sesiones en local (Hive) y, con sesión, en Firestore bajo
/// users/{uid}/alumnos y users/{uid}/sesiones. Si el alumno ha enlazado su
/// app con el código del preparador, las sesiones se copian además a
/// users/{alumno}/cantes para que aparezcan en su agenda y en su diario.

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;

/// Alumno de un preparador.
class Alumno {
  const Alumno({
    required this.id,
    required this.nombre,
    this.ejercicio = 3,
    this.notas = '',
    this.temas = const [],
    this.uid,
    this.telefono = '',
    this.email = '',
    this.clasesFijas = const [],
    this.suelto = false,
    this.creado,
    this.updatedAt,
    this.borrado = false,
  });

  final String id;
  final String nombre;
  /// Correo de Google del alumno (el de su cuenta, si se ha enlazado, o el que
  /// apunte el preparador): se le invita a las clases en Google Calendar.
  final String email;
  /// Ejercicio que prepara: 3, 4 o 5; 0 = tercero y cuarto.
  final int ejercicio;
  /// Notas privadas del preparador (no se comparten con el alumno).
  final String notas;
  /// Temas que lleva preparados. En un alumno enlazado se actualizan con los
  /// que él marca como estudiados; en uno sin app los apunta el preparador.
  final List<String> temas;
  /// uid del alumno si ha enlazado su app (null = alumno sin app) o si es el
  /// alumno de una clase suelta que se cogió ([suelto]).
  final String? uid;
  /// Alumno de una clase suelta: tiene [uid] (para que le lleguen los cambios
  /// de esa clase), pero no ha enlazado su app con este preparador.
  final bool suelto;
  /// Teléfono para hablar por WhatsApp (lo apunta el preparador, o llega al coger una sustitución).
  final String telefono;
  /// Clases que se repiten (p. ej. los martes a las 18:00): generan las sesiones solas.
  final List<ClaseFija> clasesFijas;
  final DateTime? creado;
  final DateTime? updatedAt;
  final bool borrado;

  bool get enlazado => uid != null && !suelto;

  Alumno copyWith({String? nombre, int? ejercicio, String? notas, List<String>? temas, String? uid, bool desenlazar = false, String? telefono, String? email, List<ClaseFija>? clasesFijas, bool? suelto, bool? borrado}) => Alumno(
        id: id,
        nombre: nombre ?? this.nombre,
        ejercicio: ejercicio ?? this.ejercicio,
        notas: notas ?? this.notas,
        temas: temas ?? this.temas,
        uid: desenlazar ? null : (uid ?? this.uid),
        telefono: telefono ?? this.telefono,
        email: email ?? this.email,
        clasesFijas: clasesFijas ?? this.clasesFijas,
        suelto: desenlazar ? false : (suelto ?? this.suelto),
        creado: creado,
        updatedAt: DateTime.now(),
        borrado: borrado ?? this.borrado,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'ejercicio': ejercicio,
        'notas': notas,
        'temas': temas,
        'uid': uid,
        if (telefono.isNotEmpty) 'telefono': telefono,
        if (email.isNotEmpty) 'email': email,
        if (clasesFijas.isNotEmpty) 'clasesFijas': clasesFijas.map((c) => c.toJson()).toList(),
        if (suelto) 'suelto': true,
        'creado': (creado ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
        'borrado': borrado,
      };

  factory Alumno.fromJson(Map<dynamic, dynamic> j) => Alumno(
        id: j['id'].toString(),
        nombre: j['nombre'] as String? ?? '',
        ejercicio: (j['ejercicio'] as num?)?.toInt() ?? 3,
        notas: j['notas'] as String? ?? '',
        temas: ((j['temas'] as List?) ?? []).map((e) => e.toString()).toList(),
        uid: j['uid'] as String?,
        telefono: j['telefono'] as String? ?? '',
        email: j['email'] as String? ?? '',
        clasesFijas: [for (final c in (j['clasesFijas'] as List?) ?? const []) if (c is Map) ClaseFija.fromJson(c)],
        suelto: j['suelto'] as bool? ?? false,
        creado: _fecha(j['creado']),
        updatedAt: _fecha(j['updatedAt']),
        borrado: j['borrado'] as bool? ?? false,
      );

  /// Fusiona dos listas por id quedándose con la versión más reciente.
  static List<Alumno> fusionar(Iterable<Alumno> a, Iterable<Alumno> b) {
    final out = <String, Alumno>{};
    for (final x in [...a, ...b]) {
      final otro = out[x.id];
      if (otro == null || (x.updatedAt ?? DateTime(0)).isAfter(otro.updatedAt ?? DateTime(0))) out[x.id] = x;
    }
    return out.values.toList();
  }
}

/// Clase que se repite con un alumno: un día de la semana a una hora, cada
/// [cadaSemanas] semanas desde [desde]. La app genera las sesiones de las
/// próximas semanas (ver [ClaseFija.fechasEntre]).
class ClaseFija {
  const ClaseFija({required this.id, required this.diaSemana, required this.minutoDelDia, this.minutos = PerfilPreparador.minutosClasePorDefecto, this.cadaSemanas = 1, required this.desde});
  final String id;
  /// 1 = lunes … 7 = domingo (como [DateTime.weekday]).
  final int diaSemana;
  /// Hora de inicio en minutos desde medianoche.
  final int minutoDelDia;
  final int minutos;
  /// 1 = cada semana, 2 = cada quince días.
  final int cadaSemanas;
  final DateTime desde;

  Map<String, dynamic> toJson() => {'id': id, 'diaSemana': diaSemana, 'minutoDelDia': minutoDelDia, 'minutos': minutos, 'cadaSemanas': cadaSemanas, 'desde': desde.toIso8601String()};

  factory ClaseFija.fromJson(Map<dynamic, dynamic> j) => ClaseFija(
        id: j['id']?.toString() ?? '',
        diaSemana: (j['diaSemana'] as num?)?.toInt() ?? 1,
        minutoDelDia: (j['minutoDelDia'] as num?)?.toInt() ?? 18 * 60,
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
        cadaSemanas: (j['cadaSemanas'] as num?)?.toInt() ?? 1,
        desde: _fecha(j['desde']) ?? DateTime(2026),
      );

  /// Fechas de la clase en [inicio, fin), respetando el ritmo desde [desde].
  List<DateTime> fechasEntre(DateTime inicio, DateTime fin) {
    final base = DateTime(desde.year, desde.month, desde.day);
    // Primer día de la semana elegido a partir de [desde].
    var d = base.add(Duration(days: (diaSemana - base.weekday) % 7));
    final out = <DateTime>[];
    while (d.isBefore(fin)) {
      final f = DateTime(d.year, d.month, d.day, minutoDelDia ~/ 60, minutoDelDia % 60);
      if (!f.isBefore(inicio)) out.add(f);
      d = DateTime(d.year, d.month, d.day + 7 * cadaSemanas);
    }
    return out;
  }
}

/// Perfil de preparador del usuario (documento users/{uid}/progress/preparador).
/// Es privado: lo que ven los demás se publica aparte (ver data/models/red.dart).
/// Papel del usuario en una oposición: la prepara (opositor) o prepara a
/// otros (preparador). Se guarda en [PerfilPreparador.activo].
enum Papel { opositor, preparador }

class PerfilPreparador {
  const PerfilPreparador({
    this.activo = false,
    this.codigo,
    this.nombre = '',
    this.telefono = '',
    this.avisosSustitucion = true,
    this.avisosReservas = true,
    this.reservas = false,
    this.huecos = const [],
    this.linkedin = '',
    this.papelElegido = false,
    this.segundosTemaAntes,
    this.avisosClase = const [avisoVispera, 60],
    this.modalidad = '',
    this.ciudad = '',
    this.calendarioGoogle = false,
    this.minutosClase = minutosClasePorDefecto,
    int? temasPorClase,
    this.plataforma = plataformaMeet,
    this.updatedAt,
  }) : _temasPorClase = temasPorClase;

  /// Valor de [avisosClase] que significa «la víspera a las 20:00».
  static const avisoVispera = -1;

  /// Lo que dura una clase con el preparador si no se dice otra cosa: 2 h
  /// (esquema, exposición de los temas y comentarios).
  static const minutosClasePorDefecto = 120;

  /// Antelación que se propone (ya elegida) al programar el envío del tema
  /// en cada clase, en segundos. Si es null, el tiempo de esquema del examen
  /// para los temas de la clase (45 min para dos en TCEE, 30 en DCE). Es solo
  /// una propuesta: se cambia en cada clase.
  final int? segundosTemaAntes;

  /// Antelación propuesta para mandar [temas] temas en el ejercicio [ejercicio].
  int antelacionTema({int temas = 2, int? ejercicio}) {
    if (segundosTemaAntes != null) return segundosTemaAntes!;
    final o = Oposiciones.actual;
    final e = o.ejercicio(ejercicio ?? o.primerConTemas);
    final s = e == null || e.minutosEsquema <= 0 ? 0 : e.segundosEsquemaPara(temas);
    return s > 0 ? s : 2700;
  }

  /// Duración habitual de sus clases, en minutos (clases nuevas, fijas,
  /// huecos para reservas y clases sueltas).
  final int minutosClase;

  /// Cuántos temas se cantan en cada clase, salvo que se cambie en la clase.
  /// Temas por clase; si no se ha fijado, el de la oposición (TCEE 1, DCE 2).
  final int? _temasPorClase;
  int get temasPorClase => _temasPorClase ?? Oposiciones.actual.temasPorClase;

  /// Videollamada que propone para sus clases online ('meet' o 'teams').
  final String plataforma;

  /// Recordatorios de sus clases: minutos antes (o [avisoVispera]). Vacío, ninguno.
  final List<int> avisosClase;

  /// Cómo da clase (online, presencial o ambas; vacío si no lo dice) y dónde.
  /// Salen en el directorio de preparadores.
  final String modalidad;
  final String ciudad;
  /// Las clases van a su Google Calendar (con reunión de Meet si son online
  /// e invitación al alumno). En este dispositivo, con el permiso de Google.
  final bool calendarioGoogle;

  /// Su papel en esta oposición es el de preparador (si no, es opositor). En
  /// una misma oposición no se puede ser las dos cosas.
  final bool activo;
  /// Ha elegido su papel en esta oposición (al empezar, en Ajustes o en Hoy).
  /// Mientras no lo elija, se le pregunta una vez.
  final bool papelElegido;
  /// Código que da a sus alumnos para enlazar (null hasta que está verificado).
  final String? codigo;
  /// Nombre con el que le ven sus alumnos.
  final String nombre;
  /// Teléfono que se da al alumno cuando este preparador coge una sustitución.
  final String telefono;
  /// Avisar de las peticiones de sustitución nuevas (activado por defecto).
  final bool avisosSustitucion;
  /// Avisar de las reservas de sus alumnos (activado por defecto).
  final bool avisosReservas;
  /// Sus alumnos pueden reservar en sus huecos libres (desactivado por defecto).
  final bool reservas;
  /// Huecos semanales en los que acepta reservas.
  final List<Hueco> huecos;
  /// Perfil de LinkedIn que sale en el directorio de preparadores.
  final String linkedin;
  final DateTime? updatedAt;

  PerfilPreparador copyWith({bool? activo, String? codigo, String? nombre, String? telefono, bool? avisosSustitucion, bool? avisosReservas, bool? reservas, List<Hueco>? huecos, String? linkedin, bool? papelElegido, int? segundosTemaAntes, bool antelacionDelExamen = false, List<int>? avisosClase, String? modalidad, String? ciudad, bool? calendarioGoogle, int? minutosClase, int? temasPorClase, String? plataforma}) => PerfilPreparador(
        activo: activo ?? this.activo,
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        avisosSustitucion: avisosSustitucion ?? this.avisosSustitucion,
        avisosReservas: avisosReservas ?? this.avisosReservas,
        reservas: reservas ?? this.reservas,
        huecos: huecos ?? this.huecos,
        linkedin: linkedin ?? this.linkedin,
        papelElegido: papelElegido ?? this.papelElegido,
        segundosTemaAntes: antelacionDelExamen ? null : (segundosTemaAntes ?? this.segundosTemaAntes),
        avisosClase: avisosClase ?? this.avisosClase,
        modalidad: modalidad ?? this.modalidad,
        ciudad: ciudad ?? this.ciudad,
        calendarioGoogle: calendarioGoogle ?? this.calendarioGoogle,
        minutosClase: minutosClase ?? this.minutosClase,
        temasPorClase: temasPorClase ?? _temasPorClase,
        plataforma: plataforma ?? this.plataforma,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'activo': activo,
        'codigo': codigo,
        'nombre': nombre,
        'telefono': telefono,
        'avisosSustitucion': avisosSustitucion,
        'avisosReservas': avisosReservas,
        'reservas': reservas,
        'huecos': huecos.map((h) => h.toJson()).toList(),
        'linkedin': linkedin,
        'papelElegido': papelElegido,
        if (segundosTemaAntes != null) 'segundosTemaAntes': segundosTemaAntes,
        'avisosClase': avisosClase,
        'minutosClase': minutosClase,
        'temasPorClase': _temasPorClase,
        'plataforma': plataforma,
        if (modalidad.isNotEmpty) 'modalidad': modalidad,
        if (ciudad.isNotEmpty) 'ciudad': ciudad,
        if (calendarioGoogle) 'calendarioGoogle': true,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory PerfilPreparador.fromJson(Map<dynamic, dynamic>? j) => j == null
      ? const PerfilPreparador()
      : PerfilPreparador(
          activo: j['activo'] as bool? ?? false,
          codigo: j['codigo'] as String?,
          nombre: j['nombre'] as String? ?? '',
          telefono: j['telefono'] as String? ?? '',
          avisosSustitucion: j['avisosSustitucion'] as bool? ?? true,
          avisosReservas: j['avisosReservas'] as bool? ?? true,
          reservas: j['reservas'] as bool? ?? false,
          huecos: [for (final h in (j['huecos'] as List?) ?? const []) if (h is Map) Hueco.fromJson(h)],
          linkedin: j['linkedin'] as String? ?? '',
          papelElegido: j['papelElegido'] as bool? ?? false,
          segundosTemaAntes: (j['segundosTemaAntes'] as num?)?.toInt(),
          avisosClase: j['avisosClase'] is List ? [for (final x in j['avisosClase'] as List) (x as num).toInt()] : const [avisoVispera, 60],
          modalidad: j['modalidad'] as String? ?? '',
          ciudad: j['ciudad'] as String? ?? '',
          calendarioGoogle: j['calendarioGoogle'] as bool? ?? false,
          minutosClase: (j['minutosClase'] as num?)?.toInt() ?? minutosClasePorDefecto,
          temasPorClase: (j['temasPorClase'] as num?)?.toInt(),
          plataforma: j['plataforma'] as String? ?? plataformaMeet,
          updatedAt: _fecha(j['updatedAt']),
        );
}

/// Hueco semanal en el que un preparador acepta reservas de sus alumnos.
class Hueco {
  const Hueco({required this.diaSemana, required this.minutoDelDia, this.minutos = PerfilPreparador.minutosClasePorDefecto});
  /// 1 = lunes … 7 = domingo.
  final int diaSemana;
  final int minutoDelDia;
  final int minutos;

  Map<String, dynamic> toJson() => {'diaSemana': diaSemana, 'minutoDelDia': minutoDelDia, 'minutos': minutos};
  factory Hueco.fromJson(Map<dynamic, dynamic> j) => Hueco(
        diaSemana: (j['diaSemana'] as num?)?.toInt() ?? 1,
        minutoDelDia: (j['minutoDelDia'] as num?)?.toInt() ?? 18 * 60,
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
      );

  @override
  bool operator ==(Object other) => other is Hueco && other.diaSemana == diaSemana && other.minutoDelDia == minutoDelDia && other.minutos == minutos;
  @override
  int get hashCode => Object.hash(diaSemana, minutoDelDia, minutos);
}

/// Preparador con el que el usuario (alumno) ha enlazado su app
/// (documento users/{uid}/preparadores/{uidPreparador}).
class VinculoPreparador {
  const VinculoPreparador({required this.uid, required this.nombre, this.codigo, this.desde});
  final String uid;
  final String nombre;
  final String? codigo;
  final DateTime? desde;

  Map<String, dynamic> toJson() => {'uid': uid, 'nombre': nombre, 'codigo': codigo, 'desde': (desde ?? DateTime.now()).toIso8601String()};

  factory VinculoPreparador.fromJson(Map<dynamic, dynamic> j) =>
      VinculoPreparador(uid: j['uid'].toString(), nombre: j['nombre'] as String? ?? '', codigo: j['codigo'] as String?, desde: _fecha(j['desde']));
}

/// Lo que un alumno enlazado comparte con su preparador: los temas que marca
/// y sus cantes. No incluye tests, notas ni grabaciones.
class ProgresoAlumno {
  const ProgresoAlumno({this.estudiados = const {}, this.enRepaso = const {}, this.cantes = const []});
  final Set<String> estudiados;
  final Set<String> enRepaso;
  /// Cantes del alumno (los suyos y los programados por preparadores).
  final List<Cante> cantes;
}

/// Error al enlazar con un preparador, con un mensaje para el usuario.
class ErrorEnlace implements Exception {
  const ErrorEnlace(this.mensaje);
  final String mensaje;
  @override
  String toString() => mensaje;
}

/// Letras y cifras del código de preparador, sin las que se confunden (0/O, 1/I).
const _alfabetoCodigo = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

/// Código de seis caracteres que el preparador da a sus alumnos.
String generarCodigo([Random? random]) {
  final r = random ?? Random.secure();
  return [for (var i = 0; i < 6; i++) _alfabetoCodigo[r.nextInt(_alfabetoCodigo.length)]].join();
}

/// Deja un código tecleado por el alumno en su forma canónica (sin espacios
/// ni guiones, en mayúsculas). Devuelve null si no tiene la forma de un código.
String? normalizarCodigo(String texto) {
  final c = texto.toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');
  return c.length == 6 && c.split('').every(_alfabetoCodigo.contains) ? c : null;
}

/// Informe de un cante en texto, para enviarlo al alumno por mensaje o correo.
String informeCante(Cante c, {String? alumno, String Function(String codigo)? tituloDe}) {
  final r = c.resultado;
  String dos(int n) => n.toString().padLeft(2, '0');
  final lineas = <String>[
    'Cante del ${c.fecha.day}/${c.fecha.month}/${c.fecha.year}${alumno == null || alumno.isEmpty ? '' : ' · $alumno'}',
    for (final t in r?.temasCantados ?? const <String>[]) 'Tema $t${tituloDe == null || tituloDe(t).isEmpty ? '' : ' · ${tituloDe(t)}'}',
    if ((r?.valoracion ?? 0) > 0) 'Valoración: ${'★' * r!.valoracion}${'☆' * (5 - r.valoracion)}',
    if ((r?.segundos ?? 0) > 0) 'Tiempo: ${r!.segundos ~/ 60}:${dos(r.segundos % 60)} (previsto: ${c.minutos} min)',
    if (r != null && r.sorteados.length > 1) 'Salieron en el sorteo: ${r.sorteados.join(', ')}',
    if (r != null && r.comentarios.isNotEmpty) ...['', r.comentarios],
  ];
  return lineas.join('\n');
}
