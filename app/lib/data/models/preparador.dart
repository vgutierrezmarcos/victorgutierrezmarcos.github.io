import 'dart:math';

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
    this.clasesFijas = const [],
    this.creado,
    this.updatedAt,
    this.borrado = false,
  });

  final String id;
  final String nombre;
  /// Ejercicio que prepara: 3, 4 o 5; 0 = tercero y cuarto.
  final int ejercicio;
  /// Notas privadas del preparador (no se comparten con el alumno).
  final String notas;
  /// Temas que lleva preparados. En un alumno enlazado se actualizan con los
  /// que él marca como estudiados; en uno sin app los apunta el preparador.
  final List<String> temas;
  /// uid del alumno si ha enlazado su app (null = alumno sin app).
  final String? uid;
  /// Teléfono para hablar por WhatsApp (lo apunta el preparador, o llega al coger una sustitución).
  final String telefono;
  /// Clases que se repiten (p. ej. los martes a las 18:00): generan las sesiones solas.
  final List<ClaseFija> clasesFijas;
  final DateTime? creado;
  final DateTime? updatedAt;
  final bool borrado;

  bool get enlazado => uid != null;

  Alumno copyWith({String? nombre, int? ejercicio, String? notas, List<String>? temas, String? uid, bool desenlazar = false, String? telefono, List<ClaseFija>? clasesFijas, bool? borrado}) => Alumno(
        id: id,
        nombre: nombre ?? this.nombre,
        ejercicio: ejercicio ?? this.ejercicio,
        notas: notas ?? this.notas,
        temas: temas ?? this.temas,
        uid: desenlazar ? null : (uid ?? this.uid),
        telefono: telefono ?? this.telefono,
        clasesFijas: clasesFijas ?? this.clasesFijas,
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
        if (clasesFijas.isNotEmpty) 'clasesFijas': clasesFijas.map((c) => c.toJson()).toList(),
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
        clasesFijas: [for (final c in (j['clasesFijas'] as List?) ?? const []) if (c is Map) ClaseFija.fromJson(c)],
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
  const ClaseFija({required this.id, required this.diaSemana, required this.minutoDelDia, this.minutos = 30, this.cadaSemanas = 1, required this.desde});
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
class PerfilPreparador {
  const PerfilPreparador({
    this.activo = false,
    this.codigo,
    this.nombre = '',
    this.telefono = '',
    this.avisosSustitucion = true,
    this.reservas = false,
    this.huecos = const [],
    this.linkedin = '',
    this.updatedAt,
  });

  /// El usuario ha activado «Soy preparador».
  final bool activo;
  /// Código que da a sus alumnos para enlazar (null hasta que está verificado).
  final String? codigo;
  /// Nombre con el que le ven sus alumnos.
  final String nombre;
  /// Teléfono que se da al alumno cuando este preparador coge una sustitución.
  final String telefono;
  /// Avisar de las peticiones de sustitución nuevas (activado por defecto).
  final bool avisosSustitucion;
  /// Sus alumnos pueden reservar en sus huecos libres (desactivado por defecto).
  final bool reservas;
  /// Huecos semanales en los que acepta reservas.
  final List<Hueco> huecos;
  /// Perfil de LinkedIn que sale en el directorio de preparadores.
  final String linkedin;
  final DateTime? updatedAt;

  PerfilPreparador copyWith({bool? activo, String? codigo, String? nombre, String? telefono, bool? avisosSustitucion, bool? reservas, List<Hueco>? huecos, String? linkedin}) => PerfilPreparador(
        activo: activo ?? this.activo,
        codigo: codigo ?? this.codigo,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        avisosSustitucion: avisosSustitucion ?? this.avisosSustitucion,
        reservas: reservas ?? this.reservas,
        huecos: huecos ?? this.huecos,
        linkedin: linkedin ?? this.linkedin,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'activo': activo,
        'codigo': codigo,
        'nombre': nombre,
        'telefono': telefono,
        'avisosSustitucion': avisosSustitucion,
        'reservas': reservas,
        'huecos': huecos.map((h) => h.toJson()).toList(),
        'linkedin': linkedin,
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
          reservas: j['reservas'] as bool? ?? false,
          huecos: [for (final h in (j['huecos'] as List?) ?? const []) if (h is Map) Hueco.fromJson(h)],
          linkedin: j['linkedin'] as String? ?? '',
          updatedAt: _fecha(j['updatedAt']),
        );
}

/// Hueco semanal en el que un preparador acepta reservas de sus alumnos.
class Hueco {
  const Hueco({required this.diaSemana, required this.minutoDelDia, this.minutos = 30});
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
    if (r?.temaCantado != null) 'Tema ${r!.temaCantado}${tituloDe == null || tituloDe(r.temaCantado!).isEmpty ? '' : ' · ${tituloDe(r.temaCantado!)}'}',
    if ((r?.valoracion ?? 0) > 0) 'Valoración: ${'★' * r!.valoracion}${'☆' * (5 - r.valoracion)}',
    if ((r?.segundos ?? 0) > 0) 'Tiempo: ${r!.segundos ~/ 60}:${dos(r.segundos % 60)} (previsto: ${c.minutos} min)',
    if (r != null && r.sorteados.length > 1) 'Salieron en el sorteo: ${r.sorteados.join(', ')}',
    if (r != null && r.comentarios.isNotEmpty) ...['', r.comentarios],
  ];
  return lineas.join('\n');
}
