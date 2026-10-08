import 'oposicion.dart';
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
///   busquedas/{id}                       lo que busca un opositor que necesita preparador (sin nombre)
///   busquedas/{id}/interesados/{uid}     preparadores a los que les interesa, con su contacto (solo lo lee el opositor)
///   plazas/{uidPreparador}               si admite alumnos nuevos, desde cuándo y su disponibilidad (solo lo ven opositores)

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;
List<int> _enteros(Object? l) => [for (final e in (l as List?) ?? const []) if (e is num) e.toInt()];
List<String> _textos(Object? l) => [for (final e in (l as List?) ?? const []) e.toString()];

/// Preparador verificado. Lo da de alta el administrador o un preparador ya
/// verificado ([avaladoPor]); el administrador puede retirarlo ([activo]).
class PreparadorVerificado {
  const PreparadorVerificado({required this.uid, required this.nombre, this.ejercicios = const [3, 4], this.avaladoPor, this.avaladoPorNombre = '', this.desde, this.activo = true, this.linkedin = '', this.modalidad = '', this.ciudad = ''});
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

  /// Cómo da clase: 'online', 'presencial', 'ambas' o '' (sin indicar).
  final String modalidad;

  /// Ciudad en la que da clase presencial (opcional).
  final String ciudad;

  bool get daOnline => modalidad == 'online' || modalidad == 'ambas';
  bool get daPresencial => modalidad == 'presencial' || modalidad == 'ambas';

  /// «Online y presencial en Madrid», «Presencial en Sevilla», «Online» o ''.
  String get descripcionModalidad => describirModalidad(modalidad, ciudad);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nombre': nombre,
        'ejercicios': ejercicios,
        'linkedin': linkedin,
        if (modalidad.isNotEmpty) 'modalidad': modalidad,
        if (ciudad.isNotEmpty) 'ciudad': ciudad,
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
        modalidad: j['modalidad'] as String? ?? '',
        ciudad: j['ciudad'] as String? ?? '',
      );

  String get descripcionEjercicios => describirEjercicios(ejercicios);
}

/// «Online y presencial en Madrid», «Presencial en Sevilla», «Online» o ''.
String describirModalidad(String modalidad, String ciudad) {
  final en = ciudad.trim().isEmpty ? '' : ' en ${ciudad.trim()}';
  return switch (modalidad) {
    'online' => 'Online',
    'presencial' => 'Presencial$en',
    'ambas' => 'Online y presencial$en',
    _ => '',
  };
}

/// Petición para que verifiquen a alguien como preparador.
class SolicitudPreparador {
  const SolicitudPreparador({required this.uid, required this.nombre, this.email = '', this.ejercicios = const [3, 4], this.presentacion = '', this.linkedin = '', this.modalidad = '', this.ciudad = '', this.destinatario, this.destinatarioNombre = '', this.creada});
  final String uid;
  final String nombre;
  final String email;
  final List<int> ejercicios;
  /// Quién es: promoción, cuerpo, academia, alumnos que lleva…
  final String presentacion;
  /// LinkedIn (opcional): ayuda a quien la revisa y pasa al directorio.
  final String linkedin;
  /// Modalidad y ciudad, que pasan al directorio al verificarlo.
  final String modalidad;
  final String ciudad;
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
        if (modalidad.isNotEmpty) 'modalidad': modalidad,
        if (ciudad.isNotEmpty) 'ciudad': ciudad,
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
        modalidad: j['modalidad'] as String? ?? '',
        ciudad: j['ciudad'] as String? ?? '',
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
    this.minutos = PerfilPreparador.minutosClasePorDefecto,
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
    this.modalidad = Modalidad.sinIndicar,
  });

  /// Presencial u online (sin indicar = le da igual).
  final Modalidad modalidad;
  final String id;
  /// uid del alumno que la pide.
  final String alumno;
  /// Día y hora desde la que el alumno puede (inicio de la franja).
  final DateTime fecha;
  /// Hora hasta la que puede ese día (null = a la hora de [fecha] justa).
  final DateTime? hasta;
  /// Hora a la que queda el cante: la elige dentro de la franja quien lo coge.
  final DateTime? hora;
  /// Duración prevista de la clase (no se pide ni se muestra: unas 2 h).
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
  /// Dictamen (1.º de TCEE: coyuntura), sin temas.
  bool get coyuntura => Oposiciones.actual.esDictamen(ejercicio);
  /// «Presencial», «Online» o «Presencial u online».
  String get textoModalidad => switch (modalidad) {
        Modalidad.presencial => 'Presencial',
        Modalidad.online => 'Online',
        Modalidad.sinIndicar => 'Presencial u online',
      };

  String get descripcion => [_descripcionEjercicio(), if (modalidad != Modalidad.sinIndicar) textoModalidad.toLowerCase()].join(' · ');

  String _descripcionEjercicio() {
    if (!coyuntura) return '$ejercicio.º ejercicio · ${temas.length} temas';
    final que = Oposiciones.actual.ejercicio(ejercicio)?.queSeCanta ?? 'cante';
    return '${que[0].toUpperCase()}${que.substring(1)} (${ejercicio == 1 ? '1.er' : '$ejercicio.º'} ejercicio)';
  }

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
        if (modalidad != Modalidad.sinIndicar) 'modalidad': modalidad.name,
        'creada': (creada ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Sustitucion.fromJson(Map<dynamic, dynamic> j) => Sustitucion(
        id: j['id'].toString(),
        alumno: j['alumno'] as String? ?? '',
        fecha: _fecha(j['fecha']) ?? DateTime.now(),
        hasta: _fecha(j['hasta']),
        hora: _fecha(j['hora']),
        minutos: (j['minutos'] as num?)?.toInt() ?? PerfilPreparador.minutosClasePorDefecto,
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
        modalidad: Modalidad.values.firstWhere((m) => m.name == j['modalidad'], orElse: () => Modalidad.sinIndicar),
      );

  /// Cante que aparece en la agenda del alumno cuando alguien la coge. Va
  /// firmado por el sustituto, que desde entonces puede cambiarlo (hora,
  /// enlace, cancelación) como una clase más.
  Cante canteDelAlumno({String? nombreSustituto}) => Cante(
        id: 'sust_$id',
        fecha: inicio,
        minutos: minutos,
        ejercicio: ejercicio,
        bolsa: TipoBolsa.lista,
        temas: temas,
        notas: notas,
        titulo: 'Clase suelta · ${nombreSustituto ?? cogidaPorNombre}',
        sustitucion: id,
        preparador: cogidaPor,
        preparadorNombre: nombreSustituto ?? cogidaPorNombre,
        modalidad: modalidad,
        updatedAt: DateTime.now(),
      );
}

/// Qué es un material, por su enlace (para el icono).
enum TipoMaterial { drive, video, pdf, web }

/// Enlace (Drive, PDF en la web, vídeo…) que un preparador comparte con todos
/// sus alumnos enlazados o con algunos, con un título, una nota y, si va de
/// un tema, el tema. Vive en materiales/{id} de la red de la oposición.
class MaterialCompartido {
  const MaterialCompartido({
    required this.id,
    required this.preparador,
    this.preparadorNombre = '',
    required this.titulo,
    required this.url,
    this.texto = '',
    this.tema,
    this.paraTodos = true,
    this.alumnos = const [],
    this.creado,
    this.updatedAt,
  });

  final String id;
  final String preparador;
  final String preparadorNombre;
  final String titulo;
  final String url;
  /// Nota del preparador (qué es, cómo usarlo).
  final String texto;
  /// Código del tema del temario al que va (null si es general).
  final String? tema;
  /// Para todos sus alumnos enlazados o solo para los uids de [alumnos].
  final bool paraTodos;
  final List<String> alumnos;
  final DateTime? creado;
  final DateTime? updatedAt;

  bool vaA(String uid) => paraTodos || alumnos.contains(uid);

  /// «drive.google.com», «youtube.com»…
  String get dominio {
    final h = Uri.tryParse(url)?.host ?? '';
    return h.startsWith('www.') ? h.substring(4) : h;
  }

  TipoMaterial get tipo {
    final u = url.toLowerCase();
    if (u.contains('drive.google.com') || u.contains('docs.google.com') || u.contains('dropbox.com') || u.contains('onedrive')) return TipoMaterial.drive;
    if (u.contains('youtube.com') || u.contains('youtu.be') || u.contains('vimeo.com')) return TipoMaterial.video;
    if (u.endsWith('.pdf') || u.contains('.pdf?')) return TipoMaterial.pdf;
    return TipoMaterial.web;
  }

  MaterialCompartido copyWith({String? titulo, String? url, String? texto, String? tema, bool sinTema = false, bool? paraTodos, List<String>? alumnos, String? preparadorNombre}) => MaterialCompartido(
        id: id,
        preparador: preparador,
        preparadorNombre: preparadorNombre ?? this.preparadorNombre,
        titulo: titulo ?? this.titulo,
        url: url ?? this.url,
        texto: texto ?? this.texto,
        tema: sinTema ? null : (tema ?? this.tema),
        paraTodos: paraTodos ?? this.paraTodos,
        alumnos: alumnos ?? this.alumnos,
        creado: creado,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'preparador': preparador,
        'preparadorNombre': preparadorNombre,
        'titulo': titulo,
        'url': url,
        'texto': texto,
        'tema': tema,
        'paraTodos': paraTodos,
        'alumnos': paraTodos ? const [] : alumnos,
        'creado': (creado ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory MaterialCompartido.fromJson(Map<dynamic, dynamic> j) => MaterialCompartido(
        id: j['id'].toString(),
        preparador: j['preparador'] as String? ?? '',
        preparadorNombre: j['preparadorNombre'] as String? ?? '',
        titulo: j['titulo'] as String? ?? '',
        url: j['url'] as String? ?? '',
        texto: j['texto'] as String? ?? '',
        tema: j['tema'] as String?,
        paraTodos: j['paraTodos'] as bool? ?? true,
        alumnos: _textos(j['alumnos']),
        creado: _fecha(j['creado']),
        updatedAt: _fecha(j['updatedAt']),
      );
}

/// Enlace de un material tal como lo escribe o pega el preparador, completo
/// (añade https:// si falta), o null si no es un enlace http(s).
String? enlaceMaterial(String texto) {
  var t = texto.trim();
  if (t.isEmpty || t.contains(' ')) return null;
  if (!RegExp(r'^https?://', caseSensitive: false).hasMatch(t)) {
    if (t.contains(':')) return null;
    t = 'https://$t';
  }
  final u = Uri.tryParse(t);
  return u == null || !u.host.contains('.') ? null : t;
}

// ------------------------------------------------------- Buscar preparador

/// Tramos del día de la disponibilidad semanal (clave: «2-t» = martes por la tarde).
const tramosDia = [('m', 'Mañana', 'hasta las 14'), ('t', 'Tarde', 'de 14 a 20'), ('n', 'Noche', 'desde las 20')];

String claveTramo(int diaSemana, String tramo) => '$diaSemana-$tramo';

/// «lunes y martes por la tarde, jueves por la mañana».
String describirDisponibilidad(Iterable<String> claves) {
  const dias = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
  final porTramo = <String, List<String>>{};
  for (final c in claves) {
    final partes = c.split('-');
    if (partes.length != 2) continue;
    final d = int.tryParse(partes[0]);
    if (d == null || d < 1 || d > 7) continue;
    porTramo.putIfAbsent(partes[1], () => []).add(dias[d - 1]);
  }
  final out = <String>[];
  for (final (t, nombre, _) in tramosDia) {
    final ds = porTramo[t];
    if (ds == null || ds.isEmpty) continue;
    final lista = ds.length == 1 ? ds.first : '${ds.take(ds.length - 1).join(', ')} y ${ds.last}';
    out.add('$lista por la ${nombre.toLowerCase()}');
  }
  return out.join('; ');
}

/// Lo que busca un opositor que necesita preparador. Va sin nombre ni
/// teléfono: la ven los preparadores verificados, y es el opositor quien
/// escribe a los que le interesen.
class Busqueda {
  const Busqueda({
    required this.id,
    required this.alumno,
    this.ejercicios = const [3],
    this.modalidad = Modalidad.sinIndicar,
    this.ciudad = '',
    this.disponibilidad = const [],
    this.clasesPorSemana = 1,
    this.temas = 0,
    this.desde,
    this.nota = '',
    this.estado = 'abierta',
    this.creada,
    this.updatedAt,
  });

  final String id;
  final String alumno;
  final List<int> ejercicios;
  /// Online, presencial o le da igual ([Modalidad.sinIndicar]).
  final Modalidad modalidad;
  final String ciudad;
  /// Claves «día-tramo» en las que puede dar clase.
  final List<String> disponibilidad;
  final int clasesPorSemana;
  /// Temas que lleva preparados (orientativo).
  final int temas;
  /// Cuándo quiere empezar (null = cuanto antes; si no, el mes).
  final DateTime? desde;
  final String nota;
  final String estado;
  final DateTime? creada;
  final DateTime? updatedAt;

  bool get abierta => estado == 'abierta';
  bool get empiezaMasAdelante => desde != null && desde!.isAfter(DateTime.now().add(const Duration(days: 30)));

  String get textoModalidad => switch (modalidad) {
        Modalidad.presencial => 'Presencial${ciudad.isEmpty ? '' : ' en $ciudad'}',
        Modalidad.online => 'Online',
        Modalidad.sinIndicar => ciudad.isEmpty ? 'Online o presencial' : 'Online o presencial en $ciudad',
      };

  /// «3.º · Online · 1 clase por semana · desde enero».
  String get descripcion => [
        ejercicios.map((e) => '$e.º').join(' y '),
        textoModalidad,
        '$clasesPorSemana ${clasesPorSemana == 1 ? 'clase' : 'clases'} por semana',
        if (desde != null) 'desde ${_mes(desde!)}',
      ].join(' · ');

  Busqueda copyWith({List<int>? ejercicios, Modalidad? modalidad, String? ciudad, List<String>? disponibilidad, int? clasesPorSemana, int? temas, DateTime? desde, bool cuantoAntes = false, String? nota, String? estado}) => Busqueda(
        id: id,
        alumno: alumno,
        ejercicios: ejercicios ?? this.ejercicios,
        modalidad: modalidad ?? this.modalidad,
        ciudad: ciudad ?? this.ciudad,
        disponibilidad: disponibilidad ?? this.disponibilidad,
        clasesPorSemana: clasesPorSemana ?? this.clasesPorSemana,
        temas: temas ?? this.temas,
        desde: cuantoAntes ? null : (desde ?? this.desde),
        nota: nota ?? this.nota,
        estado: estado ?? this.estado,
        creada: creada,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'alumno': alumno,
        'ejercicios': ejercicios,
        'modalidad': modalidad == Modalidad.sinIndicar ? '' : modalidad.name,
        'ciudad': ciudad,
        'disponibilidad': disponibilidad,
        'clasesPorSemana': clasesPorSemana,
        'temas': temas,
        'desde': desde?.toIso8601String(),
        'nota': nota,
        'estado': estado,
        'creada': (creada ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Busqueda.fromJson(Map<dynamic, dynamic> j) => Busqueda(
        id: j['id'].toString(),
        alumno: j['alumno'] as String? ?? '',
        ejercicios: _enteros(j['ejercicios']),
        modalidad: Modalidad.values.firstWhere((m) => m.name == j['modalidad'], orElse: () => Modalidad.sinIndicar),
        ciudad: j['ciudad'] as String? ?? '',
        disponibilidad: _textos(j['disponibilidad']),
        clasesPorSemana: (j['clasesPorSemana'] as num?)?.toInt() ?? 1,
        temas: (j['temas'] as num?)?.toInt() ?? 0,
        desde: _fecha(j['desde']),
        nota: j['nota'] as String? ?? '',
        estado: j['estado'] as String? ?? 'abierta',
        creada: _fecha(j['creada']),
        updatedAt: _fecha(j['updatedAt']),
      );
}

String _mes(DateTime d) => const ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'][d.month - 1] + (d.year != DateTime.now().year ? ' de ${d.year}' : '');

/// Preparador al que le interesa una búsqueda: deja su contacto para que el
/// opositor le escriba (él no puede escribir al opositor).
class Interesado {
  const Interesado({required this.uid, required this.nombre, this.telefono = '', this.linkedin = '', this.mensaje = '', this.creado});
  final String uid;
  final String nombre;
  final String telefono;
  final String linkedin;
  final String mensaje;
  final DateTime? creado;

  Map<String, dynamic> toJson() => {'uid': uid, 'nombre': nombre, 'telefono': telefono, 'linkedin': linkedin, 'mensaje': mensaje, 'creado': (creado ?? DateTime.now()).toIso8601String()};
  factory Interesado.fromJson(Map<dynamic, dynamic> j) => Interesado(
        uid: j['uid'].toString(),
        nombre: j['nombre'] as String? ?? '',
        telefono: j['telefono'] as String? ?? '',
        linkedin: j['linkedin'] as String? ?? '',
        mensaje: j['mensaje'] as String? ?? '',
        creado: _fecha(j['creado']),
      );
}

/// Plazas de un preparador: si admite alumnos nuevos, desde cuándo, su
/// disponibilidad y cómo contactarle. Solo lo ven los opositores.
class Plazas {
  const Plazas({required this.preparador, this.admite = false, this.desde, this.disponibilidad = const [], this.mensaje = '', this.telefono = '', this.updatedAt});
  final String preparador;
  final bool admite;
  /// A partir de cuándo (null = ya).
  final DateTime? desde;
  final List<String> disponibilidad;
  final String mensaje;
  /// Teléfono para que le escriban por WhatsApp (vacío = solo LinkedIn).
  final String telefono;
  final DateTime? updatedAt;

  Plazas copyWith({bool? admite, DateTime? desde, bool ya = false, List<String>? disponibilidad, String? mensaje, String? telefono}) => Plazas(
        preparador: preparador,
        admite: admite ?? this.admite,
        desde: ya ? null : (desde ?? this.desde),
        disponibilidad: disponibilidad ?? this.disponibilidad,
        mensaje: mensaje ?? this.mensaje,
        telefono: telefono ?? this.telefono,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'preparador': preparador,
        'admite': admite,
        'desde': desde?.toIso8601String(),
        'disponibilidad': disponibilidad,
        'mensaje': mensaje,
        'telefono': telefono,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Plazas.fromJson(Map<dynamic, dynamic> j) => Plazas(
        preparador: j['preparador'] as String? ?? '',
        admite: j['admite'] as bool? ?? false,
        desde: _fecha(j['desde']),
        disponibilidad: _textos(j['disponibilidad']),
        mensaje: j['mensaje'] as String? ?? '',
        telefono: j['telefono'] as String? ?? '',
        updatedAt: _fecha(j['updatedAt']),
      );
}

/// Compatibilidad (0-100) entre lo que busca un opositor y un preparador (su
/// ficha y sus plazas): 0 si no prepara ese ejercicio o no coinciden en
/// online/presencial; suma por la modalidad, por los tramos de la semana en
/// común y resta si el preparador empieza mucho después que el opositor.
int compatibilidad(Busqueda b, PreparadorVerificado v, {Plazas? plazas}) {
  if (b.ejercicios.isNotEmpty && v.ejercicios.isNotEmpty && !b.ejercicios.any(v.ejercicios.contains)) return 0;
  var s = 40;
  final mismaCiudad = b.ciudad.trim().isEmpty || v.ciudad.trim().isEmpty || b.ciudad.trim().toLowerCase() == v.ciudad.trim().toLowerCase();
  final online = b.modalidad != Modalidad.presencial && v.daOnline;
  final presencial = b.modalidad != Modalidad.online && v.daPresencial && mismaCiudad;
  if (v.modalidad.isEmpty) {
    s += 12;
  } else if (online || presencial) {
    s += 25;
  } else {
    return 0;
  }
  final suya = plazas?.disponibilidad ?? const <String>[];
  if (b.disponibilidad.isEmpty || suya.isEmpty) {
    s += 17;
  } else {
    final comunes = b.disponibilidad.where(suya.contains).length;
    s += (35 * comunes / b.disponibilidad.length).round();
  }
  final empieza = plazas?.desde;
  if (empieza != null) {
    final quiere = b.desde ?? DateTime.now();
    if (empieza.isAfter(quiere.add(const Duration(days: 45)))) s -= 15;
  }
  return s.clamp(0, 100);
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
  const Reserva({required this.id, required this.preparador, required this.alumno, this.alumnoNombre = '', required this.fecha, this.minutos = PerfilPreparador.minutosClasePorDefecto, this.nota = '', this.estado = EstadoReserva.pedida, this.creada, this.updatedAt});
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
        minutos: (j['minutos'] as num?)?.toInt() ?? PerfilPreparador.minutosClasePorDefecto,
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

/// Ejercicios en los que hay cantes (en TCEE, el 1.º —dictamen de coyuntura—,
/// el 3.º y el 4.º; el 5.º no se canta).
List<int> get ejerciciosConCante => [for (final e in Oposiciones.actual.conCante) e.numero];

/// «1.º (coyuntura)» para un ejercicio con cante.
/// Ejercicios que puede preparar un preparador: los que se cantan y el
/// primero (en TCEE, el dictamen de coyuntura; en DCE, el escrito).
List<int> get ejerciciosPreparables => ({if (Oposiciones.actual.ejercicio(1) != null) 1, ...ejerciciosConCante}.toList()..sort());

String etiquetaEjercicioCante(int e) => Oposiciones.actual.ejercicio(e)?.cortoConCante ?? '$e.º';

String describirEjercicios(List<int> ejercicios) => ejercicios.isEmpty ? '' : ejercicios.map(etiquetaEjercicioCante).join(', ');

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
