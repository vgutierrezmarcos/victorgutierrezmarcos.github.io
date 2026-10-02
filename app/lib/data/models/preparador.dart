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
  final DateTime? creado;
  final DateTime? updatedAt;
  final bool borrado;

  bool get enlazado => uid != null;

  Alumno copyWith({String? nombre, int? ejercicio, String? notas, List<String>? temas, String? uid, bool desenlazar = false, bool? borrado}) => Alumno(
        id: id,
        nombre: nombre ?? this.nombre,
        ejercicio: ejercicio ?? this.ejercicio,
        notas: notas ?? this.notas,
        temas: temas ?? this.temas,
        uid: desenlazar ? null : (uid ?? this.uid),
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

/// Perfil de preparador del usuario (documento users/{uid}/progress/preparador).
class PerfilPreparador {
  const PerfilPreparador({this.activo = false, this.codigo, this.nombre = '', this.updatedAt});

  /// El usuario ha activado «Soy preparador».
  final bool activo;
  /// Código que da a sus alumnos para enlazar (null hasta que inicia sesión).
  final String? codigo;
  /// Nombre con el que le ven sus alumnos.
  final String nombre;
  final DateTime? updatedAt;

  PerfilPreparador copyWith({bool? activo, String? codigo, String? nombre}) =>
      PerfilPreparador(activo: activo ?? this.activo, codigo: codigo ?? this.codigo, nombre: nombre ?? this.nombre, updatedAt: DateTime.now());

  Map<String, dynamic> toJson() => {
        'activo': activo,
        'codigo': codigo,
        'nombre': nombre,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory PerfilPreparador.fromJson(Map<dynamic, dynamic>? j) => j == null
      ? const PerfilPreparador()
      : PerfilPreparador(
          activo: j['activo'] as bool? ?? false,
          codigo: j['codigo'] as String?,
          nombre: j['nombre'] as String? ?? '',
          updatedAt: _fecha(j['updatedAt']),
        );
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
