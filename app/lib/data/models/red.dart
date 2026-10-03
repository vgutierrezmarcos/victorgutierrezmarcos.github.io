import 'plan.dart';
import 'preparador.dart';

/// Red de preparadores: verificación, sustituciones y reservas. Todo vive en
/// colecciones de Firestore fuera de users/{uid} (ver firestore.rules):
///
///   admins/{uid}                         administradores (se crean a mano en la consola)
///   preparadoresVerificados/{uid}        preparadores verificados, visibles para quien tenga cuenta
///   solicitudesPreparador/{uid}          peticiones de verificación
///   sustituciones/{id}                   cantes que un alumno necesita que le coja otro preparador
///   sustituciones/{id}/privado/{quien}   contacto del alumno y del sustituto (solo los dos)
///   huecos/{uidPreparador}               huecos libres que ven sus alumnos enlazados
///   reservas/{id}                        reservas de un alumno en los huecos de su preparador

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;
List<int> _enteros(Object? l) => [for (final e in (l as List?) ?? const []) if (e is num) e.toInt()];
List<String> _textos(Object? l) => [for (final e in (l as List?) ?? const []) e.toString()];

/// Preparador verificado. Lo da de alta el administrador o un preparador ya
/// verificado ([avaladoPor]); el administrador puede retirarlo ([activo]).
class PreparadorVerificado {
  const PreparadorVerificado({required this.uid, required this.nombre, this.ejercicios = const [3, 4], this.avaladoPor, this.avaladoPorNombre = '', this.desde, this.activo = true, this.linkedin = ''});
  final String uid;
  final String nombre;
  /// Ejercicios que prepara (3, 4, 5).
  final List<int> ejercicios;
  /// uid de quien lo verificó.
  final String? avaladoPor;
  final String avaladoPorNombre;
  final DateTime? desde;
  final bool activo;
  /// Perfil de LinkedIn (opcional), para que los opositores vean quién es.
  final String linkedin;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'ejercicios': ejercicios,
        'linkedin': linkedin,
        'avaladoPor': avaladoPor,
        'avaladoPorNombre': avaladoPorNombre,
        'desde': (desde ?? DateTime.now()).toIso8601String(),
        'activo': activo,
      };

  factory PreparadorVerificado.fromJson(Map<dynamic, dynamic> j) => PreparadorVerificado(
        uid: j['uid'].toString(),
        nombre: j['nombre'] as String? ?? '',
        ejercicios: _enteros(j['ejercicios']),
        avaladoPor: j['avaladoPor'] as String?,
        avaladoPorNombre: j['avaladoPorNombre'] as String? ?? '',
        desde: _fecha(j['desde']),
        activo: j['activo'] as bool? ?? true,
        linkedin: j['linkedin'] as String? ?? '',
      );

  String get descripcionEjercicios => describirEjercicios(ejercicios);
}

/// Petición para que verifiquen a alguien como preparador.
class SolicitudPreparador {
  const SolicitudPreparador({required this.uid, required this.nombre, this.email = '', this.ejercicios = const [3, 4], this.presentacion = '', this.linkedin = '', this.destinatario, this.destinatarioNombre = '', this.creada});
  final String uid;
  final String nombre;
  final String email;
  final List<int> ejercicios;
  /// Quién es: promoción, cuerpo, academia, alumnos que lleva…
  final String presentacion;
  /// LinkedIn (opcional): ayuda a quien la revisa y pasa al directorio.
  final String linkedin;
  /// Preparador concreto al que se la pide (null = al administrador y a
  /// cualquier verificado). Solo la ven él y el administrador.
  final String? destinatario;
  final String destinatarioNombre;
  final DateTime? creada;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'email': email,
        'ejercicios': ejercicios,
        'presentacion': presentacion,
        'linkedin': linkedin,
        'paraTodos': destinatario == null,
        'destinatario': destinatario,
        'destinatarioNombre': destinatarioNombre,
        'creada': (creada ?? DateTime.now()).toIso8601String(),
      };

  factory SolicitudPreparador.fromJson(Map<dynamic, dynamic> j) => SolicitudPreparador(
        uid: j['uid'].toString(),
        nombre: j['nombre'] as String? ?? '',
        email: j['email'] as String? ?? '',
        ejercicios: _enteros(j['ejercicios']),
        presentacion: j['presentacion'] as String? ?? '',
        linkedin: j['linkedin'] as String? ?? '',
        destinatario: j['destinatario'] as String?,
        destinatarioNombre: j['destinatarioNombre'] as String? ?? '',
        creada: _fecha(j['creada']),
      );
}

enum EstadoSustitucion { abierta, cogida, cancelada }

/// Cante para el que un alumno busca otro preparador. Los preparadores a los
/// que va dirigida ven todo menos el nombre y el teléfono del alumno, que
/// están en privado/alumno y solo lee quien la coge.
class Sustitucion {
  const Sustitucion({
    required this.id,
    required this.alumno,
    required this.fecha,
    this.hasta,
    this.hora,
    this.minutos = 30,
    this.ejercicio = 3,
    this.temas = const [],
    this.notas = '',
    this.paraTodos = true,
    this.destinatarios = const [],
    this.estado = EstadoSustitucion.abierta,
    this.cogidaPor,
    this.cogidaPorNombre = '',
    this.cante,
    this.creada,
    this.updatedAt,
  });

  final String id;
  /// uid del alumno que la pide.
  final String alumno;
  /// Día y hora desde la que el alumno puede (inicio de la franja).
  final DateTime fecha;
  /// Hora hasta la que puede ese día (null = a la hora de [fecha] justa).
  final DateTime? hasta;
  /// Hora a la que queda el cante: la elige dentro de la franja quien lo coge.
  final DateTime? hora;
  /// Duración del cronómetro (no se pide ni se muestra: las clases duran lo que duran).
  final int minutos;
  final int ejercicio;
  /// Temas que entran en el cante.
  final List<String> temas;
  final String notas;
  /// Va a todos los preparadores verificados (por defecto) o solo a [destinatarios].
  final bool paraTodos;
  final List<String> destinatarios;
  final EstadoSustitucion estado;
  final String? cogidaPor;
  final String cogidaPorNombre;
  /// Cante del alumno del que sale la petición (si sale de uno).
  final String? cante;
  final DateTime? creada;
  final DateTime? updatedAt;

  bool get abierta => estado == EstadoSustitucion.abierta;
  bool get cogida => estado == EstadoSustitucion.cogida;
  bool vigente([DateTime? ahora]) => (hora ?? hasta ?? fecha).isAfter(ahora ?? DateTime.now());
  /// Hay una franja de horas (y no una hora fija).
  bool get conFranja => hasta != null && hasta!.isAfter(fecha);
  /// Hora del cante: la acordada al cogerlo o, si no, el inicio de la franja.
  DateTime get inicio => hora ?? fecha;
  bool vaA(String uid) => paraTodos || destinatarios.contains(uid);
  /// Primer ejercicio: dictamen de coyuntura, sin temas.
  bool get coyuntura => ejercicio == 1;
  String get descripcion => coyuntura ? 'Dictamen de coyuntura (1.er ejercicio)' : '$ejercicio.º ejercicio · ${temas.length} temas';

  Map<String, dynamic> toJson() => {
        'id': id,
        'alumno': alumno,
        'fecha': fecha.toIso8601String(),
        'hasta': hasta?.toIso8601String(),
        'hora': hora?.toIso8601String(),
        'minutos': minutos,
        'ejercicio': ejercicio,
        'temas': temas,
        'notas': notas,
        'paraTodos': paraTodos,
        'destinatarios': destinatarios,
        'estado': estado.name,
        'cogidaPor': cogidaPor,
        'cogidaPorNombre': cogidaPorNombre,
        'cante': cante,
        'creada': (creada ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Sustitucion.fromJson(Map<dynamic, dynamic> j) => Sustitucion(
        id: j['id'].toString(),
        alumno: j['alumno'] as String? ?? '',
        fecha: _fecha(j['fecha']) ?? DateTime.now(),
        hasta: _fecha(j['hasta']),
        hora: _fecha(j['hora']),
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
        ejercicio: (j['ejercicio'] as num?)?.toInt() ?? 3,
        temas: _textos(j['temas']),
        notas: j['notas'] as String? ?? '',
        paraTodos: j['paraTodos'] as bool? ?? true,
        destinatarios: _textos(j['destinatarios']),
        estado: EstadoSustitucion.values.firstWhere((e) => e.name == j['estado'], orElse: () => EstadoSustitucion.abierta),
        cogidaPor: j['cogidaPor'] as String?,
        cogidaPorNombre: j['cogidaPorNombre'] as String? ?? '',
        cante: j['cante'] as String?,
        creada: _fecha(j['creada']),
        updatedAt: _fecha(j['updatedAt']),
      );

  /// Cante que aparece en la agenda del alumno cuando alguien la coge.
  Cante canteDelAlumno({String? nombreSustituto}) => Cante(
        id: 'sust_$id',
        fecha: inicio,
        minutos: minutos,
        ejercicio: ejercicio,
        bolsa: TipoBolsa.lista,
        temas: temas,
        notas: notas,
        titulo: 'Sustitución · ${nombreSustituto ?? cogidaPorNombre}',
        sustitucion: id,
        updatedAt: DateTime.now(),
      );
}

/// Nombre y teléfono que se intercambian el alumno y el sustituto.
class ContactoRed {
  const ContactoRed({required this.nombre, required this.telefono});
  final String nombre;
  final String telefono;
  Map<String, dynamic> toJson() => {'nombre': nombre, 'telefono': telefono};
  factory ContactoRed.fromJson(Map<dynamic, dynamic> j) => ContactoRed(nombre: j['nombre'] as String? ?? '', telefono: j['telefono'] as String? ?? '');
}

/// Huecos libres que un preparador publica para sus alumnos enlazados, con
/// las horas que ya tiene ocupadas (sin decir con quién).
class HuecosPublicos {
  const HuecosPublicos({required this.preparador, this.nombre = '', this.activo = false, this.huecos = const [], this.ocupados = const [], this.updatedAt});
  final String preparador;
  final String nombre;
  final bool activo;
  final List<Hueco> huecos;
  /// Intervalos ocupados: inicio y minutos.
  final List<({DateTime inicio, int minutos})> ocupados;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'preparador': preparador,
        'nombre': nombre,
        'activo': activo,
        'huecos': huecos.map((h) => h.toJson()).toList(),
        'ocupados': [for (final o in ocupados) {'inicio': o.inicio.toIso8601String(), 'minutos': o.minutos}],
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory HuecosPublicos.fromJson(Map<dynamic, dynamic> j) => HuecosPublicos(
        preparador: j['preparador'] as String? ?? '',
        nombre: j['nombre'] as String? ?? '',
        activo: j['activo'] as bool? ?? false,
        huecos: [for (final h in (j['huecos'] as List?) ?? const []) if (h is Map) Hueco.fromJson(h)],
        ocupados: [
          for (final o in (j['ocupados'] as List?) ?? const [])
            if (o is Map && _fecha(o['inicio']) != null) (inicio: _fecha(o['inicio'])!, minutos: (o['minutos'] as num?)?.toInt() ?? 30),
        ],
        updatedAt: _fecha(j['updatedAt']),
      );

  /// Huecos libres concretos entre [desde] y [semanas] semanas después: los
  /// semanales que no se solapan con nada ocupado ni con [pedidos] por el alumno.
  List<DateTime> libres({required DateTime desde, int semanas = 4, Iterable<DateTime> pedidos = const []}) {
    final inicio = DateTime(desde.year, desde.month, desde.day);
    final out = <DateTime>[];
    for (var d = 0; d < 7 * semanas; d++) {
      final dia = DateTime(inicio.year, inicio.month, inicio.day + d);
      for (final h in huecos.where((h) => h.diaSemana == dia.weekday)) {
        final f = DateTime(dia.year, dia.month, dia.day, h.minutoDelDia ~/ 60, h.minutoDelDia % 60);
        if (!f.isAfter(desde)) continue;
        final fin = f.add(Duration(minutes: h.minutos));
        final choca = ocupados.any((o) => seSolapan(f, fin, o.inicio, o.inicio.add(Duration(minutes: o.minutos))));
        if (!choca && !pedidos.contains(f)) out.add(f);
      }
    }
    return out..sort();
  }
}

enum EstadoReserva { pedida, aceptada, rechazada, cancelada }

/// Reserva de un alumno en un hueco de su preparador. El preparador la acepta
/// (y entonces se crea la sesión) o la rechaza.
class Reserva {
  const Reserva({required this.id, required this.preparador, required this.alumno, this.alumnoNombre = '', required this.fecha, this.minutos = 30, this.nota = '', this.estado = EstadoReserva.pedida, this.creada, this.updatedAt});
  final String id;
  final String preparador;
  final String alumno;
  final String alumnoNombre;
  final DateTime fecha;
  final int minutos;
  final String nota;
  final EstadoReserva estado;
  final DateTime? creada;
  final DateTime? updatedAt;

  bool get pedida => estado == EstadoReserva.pedida;

  Map<String, dynamic> toJson() => {
        'id': id,
        'preparador': preparador,
        'alumno': alumno,
        'alumnoNombre': alumnoNombre,
        'fecha': fecha.toIso8601String(),
        'minutos': minutos,
        'nota': nota,
        'estado': estado.name,
        'creada': (creada ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Reserva.fromJson(Map<dynamic, dynamic> j) => Reserva(
        id: j['id'].toString(),
        preparador: j['preparador'] as String? ?? '',
        alumno: j['alumno'] as String? ?? '',
        alumnoNombre: j['alumnoNombre'] as String? ?? '',
        fecha: _fecha(j['fecha']) ?? DateTime.now(),
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
        nota: j['nota'] as String? ?? '',
        estado: EstadoReserva.values.firstWhere((e) => e.name == j['estado'], orElse: () => EstadoReserva.pedida),
        creada: _fecha(j['creada']),
        updatedAt: _fecha(j['updatedAt']),
      );
}

bool seSolapan(DateTime a0, DateTime a1, DateTime b0, DateTime b1) => a0.isBefore(b1) && b0.isBefore(a1);

/// Ids de las sesiones que se solapan con alguna otra (sin contar canceladas ni borradas).
Set<String> sesionesSolapadas(Iterable<Cante> sesiones) {
  final vivas = sesiones.where((s) => !s.borrado && !s.cancelado).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
  final out = <String>{};
  for (var i = 0; i < vivas.length; i++) {
    final a = vivas[i];
    final finA = a.fecha.add(Duration(minutes: a.minutos));
    for (var j = i + 1; j < vivas.length && vivas[j].fecha.isBefore(finA); j++) {
      out..add(a.id)..add(vivas[j].id);
    }
  }
  return out;
}

/// Teléfono en el formato que entiende wa.me: solo cifras y con prefijo de
/// país (34 si se escribe un número español de nueve cifras).
String? telefonoWhatsApp(String telefono) {
  var t = telefono.replaceAll(RegExp(r'[^\d+]'), '');
  if (t.startsWith('+')) t = t.substring(1);
  if (t.startsWith('00')) t = t.substring(2);
  if (t.length == 9 && RegExp(r'^[6789]').hasMatch(t)) t = '34$t';
  return t.length >= 10 && t.length <= 15 ? t : null;
}

/// Enlace para abrir una conversación de WhatsApp con [telefono] y un mensaje.
String? enlaceWhatsApp(String telefono, [String mensaje = '']) {
  final t = telefonoWhatsApp(telefono);
  if (t == null) return null;
  return 'https://wa.me/$t${mensaje.isEmpty ? '' : '?text=${Uri.encodeComponent(mensaje)}'}';
}

/// Ejercicios en los que hay cantes: el primero (dictamen de coyuntura), el
/// tercero y el cuarto. El quinto no se canta.
const ejerciciosConCante = [1, 3, 4];

String describirEjercicios(List<int> ejercicios) => ejercicios.isEmpty ? '' : ejercicios.map((e) => e == 1 ? '1.º (coyuntura)' : '$e.º').join(', ');

String _hm(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

/// «de 16:00 a 21:00» o «a las 18:00».
String horasDe(Sustitucion s) => s.hora != null ? 'a las ${_hm(s.hora!)}' : (s.conFranja ? 'de ${_hm(s.fecha)} a ${_hm(s.hasta!)}' : 'a las ${_hm(s.fecha)}');

/// Enlace a un perfil de LinkedIn en su forma canónica
/// (https://www.linkedin.com/in/…), o null si no lo es. Acepta lo que se copia
/// del navegador o de la app, con o sin https://, www. o barra final.
String? enlaceLinkedin(String texto) {
  final t = texto.trim();
  final m = RegExp(r'^(?:https?://)?(?:[a-z]{2,3}\.)?(?:www\.)?linkedin\.com/in/([^/?#\s]+)/?(?:[?#].*)?$', caseSensitive: false).firstMatch(t);
  return m == null ? null : 'https://www.linkedin.com/in/${m.group(1)}';
}
