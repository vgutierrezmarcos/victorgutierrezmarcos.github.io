/// Cronograma de una vuelta al temario: qué temas toca cada semana.
/// Se guarda en local (Hive) y, con sesión, en users/{uid}/cronogramas/{id}.
/// Si el opositor lo comparte, su preparador enlazado lo ve y puede proponer
/// cambios ([PropuestaCronograma]), que el opositor acepta o rechaza.
library;

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;
List<String> _textos(Object? l) => [for (final e in (l as List?) ?? const []) e.toString()];

/// Lunes (a las 0:00) de la semana de [d].
DateTime lunesDe(DateTime d) => DateTime(d.year, d.month, d.day - (d.weekday - 1));

/// Primer día de la semana del cronograma que contiene [d]. Con [diaCante]
/// (1 = lunes … 7 = domingo) cada semana va del día siguiente a un cante hasta
/// el cante siguiente, así que sus temas son los de ese cante; sin él, de
/// lunes a domingo.
DateTime inicioSemana(DateTime d, [int? diaCante]) {
  final empieza = diaCante == null ? 1 : diaCante % 7 + 1;
  return DateTime(d.year, d.month, d.day - (d.weekday - empieza + 7) % 7);
}

/// El cante de la semana que contiene [d] (o el mismo [d] si es día de cante).
DateTime canteDeLaSemana(DateTime d, int diaCante) {
  final i = inicioSemana(d, diaCante);
  return DateTime(i.year, i.month, i.day + 6);
}

/// Una semana del cronograma: los temas que tocan (vacía si es de descanso).
/// [lunes] es su primer día y [domingo], el último: con día de cante, el
/// siguiente a un cante y el del cante (ver [inicioSemana]).
class SemanaPlan {
  const SemanaPlan({required this.lunes, this.temas = const [], this.descanso = false});
  final DateTime lunes;
  final List<String> temas;
  final bool descanso;

  DateTime get domingo => DateTime(lunes.year, lunes.month, lunes.day + 6);

  Map<String, dynamic> toJson() => {'lunes': lunes.toIso8601String(), 'temas': temas, if (descanso) 'descanso': true};
  factory SemanaPlan.fromJson(Map<dynamic, dynamic> j) =>
      SemanaPlan(lunes: _fecha(j['lunes']) ?? DateTime(2026), temas: _textos(j['temas']), descanso: j['descanso'] as bool? ?? false);
}

/// Cambios que propone el preparador: nuevo orden y nuevo ritmo o fecha de fin.
class PropuestaCronograma {
  const PropuestaCronograma({required this.de, this.nombre = '', required this.fecha, this.nota = '', required this.temas, required this.temasPorSemana, this.fin});
  /// uid del preparador.
  final String de;
  final String nombre;
  final DateTime fecha;
  final String nota;
  final List<String> temas;
  final int temasPorSemana;
  final DateTime? fin;

  Map<String, dynamic> toJson() => {
        'de': de,
        'nombre': nombre,
        'fecha': fecha.toIso8601String(),
        'nota': nota,
        'temas': temas,
        'temasPorSemana': temasPorSemana,
        'fin': fin?.toIso8601String(),
      };

  factory PropuestaCronograma.fromJson(Map<dynamic, dynamic> j) => PropuestaCronograma(
        de: j['de'] as String? ?? '',
        nombre: j['nombre'] as String? ?? '',
        fecha: _fecha(j['fecha']) ?? DateTime(2026),
        nota: j['nota'] as String? ?? '',
        temas: _textos(j['temas']),
        temasPorSemana: (j['temasPorSemana'] as num?)?.toInt() ?? 3,
        fin: _fecha(j['fin']),
      );
}

class Cronograma {
  const Cronograma({
    required this.id,
    required this.ejercicio,
    required this.temas,
    required this.inicio,
    this.temasPorSemana = 3,
    this.fin,
    this.intercalar = true,
    this.cadaN,
    this.descansos = const {},
    this.semanas = const [],
    this.hechos = const {},
    this.desmarcados = const {},
    this.archivado = false,
    this.compartir = false,
    this.propuesta,
    this.propuestaResuelta,
    this.propuestas = const {},
    this.resueltas = const {},
    this.respuestas = const {},
    this.autor,
    this.autorNombre = '',
    this.creado,
    this.updatedAt,
    this.diaCante,
    this.manual = false,
  });

  final String id;
  /// Hecho o retocado a mano (semana a semana, importado o editado): sus
  /// semanas no se reparten solas; se reparte lo pendiente solo si se pide.
  final bool manual;
  /// Día de la semana en que canta (1 = lunes … 7 = domingo). Las semanas del
  /// cronograma acaban ese día: los temas de cada una son los de ese cante.
  /// null = semanas de lunes a domingo (cronogramas anteriores).
  final int? diaCante;
  /// 3 o 4.
  final int ejercicio;
  /// Temas de la vuelta en el orden en que se estudian.
  final List<String> temas;
  /// Primer día de la primera semana (el lunes o, con [diaCante], el siguiente
  /// al cante anterior al primero de la vuelta).
  final DateTime inicio;

  /// Fecha del primer cante de la vuelta (con [diaCante]).
  DateTime? get primerCante => diaCante == null ? null : DateTime(inicio.year, inicio.month, inicio.day + 6);

  /// Temas que lleva el opositor a [fecha] según el cronograma: los marcados
  /// como hechos y los de las semanas ya empezadas (lo que estudia esta
  /// semana es lo que canta en la clase de esta semana), sin los que desmarcó.
  /// Es lo que ve el preparador como «temas que lleva» aunque el opositor no
  /// los marque como estudiados uno a uno.
  Set<String> temasLlevados(DateTime fecha) {
    final dia = DateTime(fecha.year, fecha.month, fecha.day);
    return {
      ...hechos.keys,
      for (final s in semanas)
        if (!s.lunes.isAfter(dia)) ...s.temas,
    }..removeAll(desmarcados);
  }
  final int temasPorSemana;
  /// Fecha de fin que fijó el opositor (null = la que salga del ritmo).
  final DateTime? fin;
  /// Intercalar Mixto (3.º) o las dos partes (4.º) con el resto.
  final bool intercalar;
  /// Un tema intercalado «cada N» (null = en proporción a su peso).
  final int? cadaN;
  /// Primer día de las semanas de descanso.
  final Set<DateTime> descansos;
  /// Reparto de los temas por semanas.
  final List<SemanaPlan> semanas;
  /// Temas terminados y cuándo.
  final Map<String, DateTime> hechos;
  /// Temas que el opositor desmarcó aunque tengan una vuelta anotada en su agenda.
  final Set<String> desmarcados;
  final bool archivado;
  /// El preparador enlazado puede verlo y proponer cambios (desactivado por defecto).
  final bool compartir;
  /// Propuesta de las versiones anteriores (una sola para todos). Las nuevas
  /// van en [propuestas], una por preparador.
  final PropuestaCronograma? propuesta;
  /// Cuándo se aceptó o rechazó la última propuesta (la de [propuesta]).
  final DateTime? propuestaResuelta;
  /// Propuesta de cada preparador (por su uid): con varios, la de uno no
  /// pisa la del otro.
  final Map<String, PropuestaCronograma> propuestas;
  /// Cuándo resolvió el opositor la última propuesta de cada preparador.
  final Map<String, DateTime> resueltas;
  /// Qué contestó a la última de cada preparador ('aceptada' o 'rechazada'),
  /// para avisarle.
  final Map<String, String> respuestas;
  /// Quién lo hizo, si se lo mandó un preparador (uid y nombre); null = el opositor.
  final String? autor;
  final String autorNombre;

  /// Las propuestas pendientes, de la más antigua a la más reciente.
  List<PropuestaCronograma> get pendientes {
    final out = [...propuestas.values];
    final vieja = propuesta;
    if (vieja != null && !propuestas.containsKey(vieja.de)) out.add(vieja);
    return out..sort((a, b) => a.fecha.compareTo(b.fecha));
  }
  final DateTime? creado;
  final DateTime? updatedAt;

  Cronograma copyWith({
    List<String>? temas,
    DateTime? inicio,
    int? temasPorSemana,
    DateTime? fin,
    bool quitarFin = false,
    bool? intercalar,
    int? cadaN,
    bool proporcional = false,
    Set<DateTime>? descansos,
    List<SemanaPlan>? semanas,
    Map<String, DateTime>? hechos,
    Set<String>? desmarcados,
    bool? archivado,
    bool? compartir,
    PropuestaCronograma? propuesta,
    bool quitarPropuesta = false,
    DateTime? propuestaResuelta,
    Map<String, PropuestaCronograma>? propuestas,
    Map<String, DateTime>? resueltas,
    Map<String, String>? respuestas,
    bool? manual,
  }) =>
      Cronograma(
        id: id,
        ejercicio: ejercicio,
        temas: temas ?? this.temas,
        inicio: inicio ?? this.inicio,
        temasPorSemana: temasPorSemana ?? this.temasPorSemana,
        fin: quitarFin ? null : (fin ?? this.fin),
        intercalar: intercalar ?? this.intercalar,
        cadaN: proporcional ? null : (cadaN ?? this.cadaN),
        descansos: descansos ?? this.descansos,
        semanas: semanas ?? this.semanas,
        hechos: hechos ?? this.hechos,
        desmarcados: desmarcados ?? this.desmarcados,
        archivado: archivado ?? this.archivado,
        compartir: compartir ?? this.compartir,
        propuesta: quitarPropuesta ? null : (propuesta ?? this.propuesta),
        propuestaResuelta: propuestaResuelta ?? this.propuestaResuelta,
        propuestas: propuestas ?? this.propuestas,
        resueltas: resueltas ?? this.resueltas,
        respuestas: respuestas ?? this.respuestas,
        autor: autor,
        autorNombre: autorNombre,
        creado: creado,
        updatedAt: DateTime.now(),
        diaCante: diaCante,
        manual: manual ?? this.manual,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ejercicio': ejercicio,
        'temas': temas,
        'inicio': inicio.toIso8601String(),
        'temasPorSemana': temasPorSemana,
        'fin': fin?.toIso8601String(),
        'intercalar': intercalar,
        'cadaN': cadaN,
        'descansos': [for (final d in descansos) d.toIso8601String()],
        'semanas': [for (final s in semanas) s.toJson()],
        'hechos': hechos.map((k, v) => MapEntry(k, v.toIso8601String())),
        'desmarcados': desmarcados.toList(),
        'archivado': archivado,
        'compartir': compartir,
        'propuesta': propuesta?.toJson(),
        'propuestaResuelta': propuestaResuelta?.toIso8601String(),
        if (propuestas.isNotEmpty) 'propuestas': propuestas.map((k, v) => MapEntry(k, v.toJson())),
        if (resueltas.isNotEmpty) 'resueltas': resueltas.map((k, v) => MapEntry(k, v.toIso8601String())),
        if (respuestas.isNotEmpty) 'respuestas': respuestas,
        if (autor != null) 'autor': autor,
        if (autorNombre.isNotEmpty) 'autorNombre': autorNombre,
        'creado': (creado ?? DateTime.now()).toIso8601String(),
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
        if (diaCante != null) 'diaCante': diaCante,
        if (manual) 'manual': true,
      };

  factory Cronograma.fromJson(Map<dynamic, dynamic> j) => Cronograma(
        id: j['id'].toString(),
        ejercicio: (j['ejercicio'] as num?)?.toInt() ?? 3,
        temas: _textos(j['temas']),
        inicio: _fecha(j['inicio']) ?? DateTime(2026),
        temasPorSemana: (j['temasPorSemana'] as num?)?.toInt() ?? 3,
        fin: _fecha(j['fin']),
        intercalar: j['intercalar'] as bool? ?? true,
        cadaN: (j['cadaN'] as num?)?.toInt(),
        descansos: {for (final d in (j['descansos'] as List?) ?? const []) if (_fecha(d) != null) _fecha(d)!},
        semanas: [for (final s in (j['semanas'] as List?) ?? const []) if (s is Map) SemanaPlan.fromJson(s)],
        hechos: {
          for (final e in ((j['hechos'] as Map?) ?? const {}).entries)
            if (_fecha(e.value) != null) e.key.toString(): _fecha(e.value)!,
        },
        desmarcados: _textos(j['desmarcados']).toSet(),
        archivado: j['archivado'] as bool? ?? false,
        compartir: j['compartir'] as bool? ?? false,
        propuesta: j['propuesta'] is Map ? PropuestaCronograma.fromJson(j['propuesta'] as Map) : null,
        propuestaResuelta: _fecha(j['propuestaResuelta']),
        propuestas: {
          for (final e in ((j['propuestas'] as Map?) ?? const {}).entries)
            if (e.value is Map) e.key.toString(): PropuestaCronograma.fromJson(e.value as Map),
        },
        resueltas: {
          for (final e in ((j['resueltas'] as Map?) ?? const {}).entries)
            if (_fecha(e.value) != null) e.key.toString(): _fecha(e.value)!,
        },
        respuestas: {for (final e in ((j['respuestas'] as Map?) ?? const {}).entries) e.key.toString(): e.value.toString()},
        autor: j['autor'] as String?,
        autorNombre: j['autorNombre'] as String? ?? '',
        creado: _fecha(j['creado']),
        updatedAt: _fecha(j['updatedAt']),
        diaCante: (j['diaCante'] as num?)?.toInt(),
        manual: j['manual'] as bool? ?? false,
      );

  /// Gana la versión más reciente, pero una propuesta del preparador posterior
  /// a la última que resolvió el opositor no se pierde.
  static Cronograma fusionar(Cronograma a, Cronograma b) {
    final reciente = (a.updatedAt ?? DateTime(0)).isAfter(b.updatedAt ?? DateTime(0)) ? a : b;
    final otro = identical(reciente, a) ? b : a;
    final resuelta = [a.propuestaResuelta, b.propuestaResuelta].whereType<DateTime>().fold<DateTime?>(null, (m, d) => m == null || d.isAfter(m) ? d : m);
    PropuestaCronograma? p = reciente.propuesta;
    final q = otro.propuesta;
    if (q != null && (p == null || q.fecha.isAfter(p.fecha))) p = q;
    if (p != null && resuelta != null && !p.fecha.isAfter(resuelta)) p = null;
    // Las de cada preparador: la más reciente de las dos, salvo que el
    // opositor ya la hubiera resuelto.
    final resueltas = {...a.resueltas};
    final respuestas = {...a.respuestas};
    for (final e in b.resueltas.entries) {
      if (resueltas[e.key] == null || e.value.isAfter(resueltas[e.key]!)) {
        resueltas[e.key] = e.value;
        if (b.respuestas[e.key] != null) respuestas[e.key] = b.respuestas[e.key]!;
      }
    }
    final propuestas = <String, PropuestaCronograma>{};
    for (final x in [...a.propuestas.entries, ...b.propuestas.entries]) {
      final previa = propuestas[x.key];
      if (previa == null || x.value.fecha.isAfter(previa.fecha)) propuestas[x.key] = x.value;
    }
    propuestas.removeWhere((k, v) => resueltas[k] != null && !v.fecha.isAfter(resueltas[k]!));
    return Cronograma.fromJson({
      ...reciente.toJson(),
      'propuesta': p?.toJson(),
      'propuestaResuelta': resuelta?.toIso8601String(),
      'propuestas': propuestas.map((k, v) => MapEntry(k, v.toJson())),
      'resueltas': resueltas.map((k, v) => MapEntry(k, v.toIso8601String())),
      'respuestas': respuestas,
    });
  }
}

/// Cronograma que un preparador ha hecho para su alumno y le ha mandado: está
/// en `cronogramasRecibidos/{id}` de los datos del alumno hasta que este lo
/// acepta (pasa a ser su cronograma, compartido con ese preparador) o lo
/// rechaza.
class CronogramaRecibido {
  const CronogramaRecibido({required this.cronograma, required this.de, this.deNombre = '', required this.enviado, this.nota = '', this.respuesta, this.respondido});
  final Cronograma cronograma;
  /// uid del preparador.
  final String de;
  final String deNombre;
  final DateTime enviado;
  final String nota;

  /// Lo que contestó el opositor ('aceptado' o 'rechazado'; null = sin
  /// contestar). Se queda anotado para avisar al preparador.
  final String? respuesta;
  final DateTime? respondido;
  bool get pendiente => respuesta == null;

  Map<String, dynamic> toJson() => {
        ...cronograma.toJson(),
        'de': de,
        'deNombre': deNombre,
        'enviado': enviado.toIso8601String(),
        'nota': nota,
        if (respuesta != null) 'respuesta': respuesta,
        if (respondido != null) 'respondido': respondido!.toIso8601String(),
      };

  factory CronogramaRecibido.fromJson(Map<dynamic, dynamic> j) => CronogramaRecibido(
        cronograma: Cronograma.fromJson(j),
        de: j['de'] as String? ?? '',
        deNombre: j['deNombre'] as String? ?? '',
        enviado: _fecha(j['enviado']) ?? DateTime(2026),
        nota: j['nota'] as String? ?? '',
        respuesta: j['respuesta'] as String?,
        respondido: _fecha(j['respondido']),
      );
}
