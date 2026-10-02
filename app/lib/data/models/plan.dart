import 'dart:math';

/// Modelos de planificación: cantes, convocatoria, horario y agenda por tema. Se guardan en local (Hive) y, con sesión, en Firestore
/// bajo users/{uid}/cantes, users/{uid}/progress/plan y users/{uid}/notes.

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;

/// Identificador corto y único (no hace falta que sea criptográfico).
String nuevoId([Random? random]) {
  final r = random ?? Random();
  return '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}${r.nextInt(1 << 32).toRadixString(36)}';
}

// ---------------------------------------------------------------------- Cantes

/// De dónde salen los temas que entran en el sorteo de un cante.
enum TipoBolsa { lista, estudiados, ejercicio }

enum EstadoCante { pendiente, hecho, cancelado }

/// Cómo fue un cante (diario de cantes).
class ResultadoCante {
  const ResultadoCante({
    this.sorteados = const [],
    this.temaCantado,
    this.segundos = 0,
    this.valoracion = 0,
    this.comentarios = '',
  });

  final List<String> sorteados;
  final String? temaCantado;
  final int segundos;
  /// 1-5; 0 = sin valorar.
  final int valoracion;
  /// Comentarios propios o del preparador.
  final String comentarios;

  ResultadoCante copyWith({List<String>? sorteados, String? temaCantado, int? segundos, int? valoracion, String? comentarios}) => ResultadoCante(
        sorteados: sorteados ?? this.sorteados,
        temaCantado: temaCantado ?? this.temaCantado,
        segundos: segundos ?? this.segundos,
        valoracion: valoracion ?? this.valoracion,
        comentarios: comentarios ?? this.comentarios,
      );

  Map<String, dynamic> toJson() => {
        'sorteados': sorteados,
        'temaCantado': temaCantado,
        'segundos': segundos,
        'valoracion': valoracion,
        'comentarios': comentarios,
      };

  factory ResultadoCante.fromJson(Map<dynamic, dynamic> j) => ResultadoCante(
        sorteados: ((j['sorteados'] as List?) ?? []).map((e) => e.toString()).toList(),
        temaCantado: j['temaCantado'] as String?,
        segundos: (j['segundos'] as num?)?.toInt() ?? 0,
        valoracion: (j['valoracion'] as num?)?.toInt() ?? 0,
        comentarios: j['comentarios'] as String? ?? '',
      );
}

class Cante {
  const Cante({
    required this.id,
    required this.fecha,
    this.titulo = '',
    this.minutos = 30,
    this.ejercicio = 3,
    this.bolsa = TipoBolsa.estudiados,
    this.temas = const [],
    this.notas = '',
    this.estado = EstadoCante.pendiente,
    this.resultado,
    this.serie,
    this.alumno,
    this.preparador,
    this.preparadorNombre,
    this.motivo = '',
    this.sustitucion,
    this.updatedAt,
    this.borrado = false,
  });

  final String id;
  /// Fecha y hora del cante (hora local).
  final DateTime fecha;
  /// Con quién o dónde ("Preparador", "Grupo de cante"…).
  final String titulo;
  /// Duración prevista del cante, en minutos.
  final int minutos;
  /// 3, 4 o 5; 0 = cualquiera.
  final int ejercicio;
  final TipoBolsa bolsa;
  /// Temas que entran (solo con [TipoBolsa.lista]).
  final List<String> temas;
  final String notas;
  final EstadoCante estado;
  final ResultadoCante? resultado;
  /// Identificador común de los cantes creados con repetición semanal.
  final String? serie;
  /// Sesión de un preparador: identificador del alumno que canta.
  final String? alumno;
  /// Cante programado o valorado por un preparador enlazado: su uid y su nombre.
  final String? preparador;
  final String? preparadorNombre;
  /// Por qué se canceló (lo escribe quien cancela; el alumno lo ve en su agenda).
  final String motivo;
  /// Cante que coge un preparador sustituto: id de la petición de sustitución.
  final String? sustitucion;
  final DateTime? updatedAt;
  /// Borrado lógico, para que la eliminación llegue a los demás dispositivos.
  final bool borrado;

  bool get hecho => estado == EstadoCante.hecho;
  bool get pendiente => estado == EstadoCante.pendiente;
  bool get dePreparador => preparador != null;
  bool get cancelado => estado == EstadoCante.cancelado;

  Cante copyWith({
    DateTime? fecha,
    String? titulo,
    int? minutos,
    int? ejercicio,
    TipoBolsa? bolsa,
    List<String>? temas,
    String? notas,
    EstadoCante? estado,
    ResultadoCante? resultado,
    String? serie,
    String? alumno,
    String? preparador,
    String? preparadorNombre,
    String? motivo,
    String? sustitucion,
    bool? borrado,
  }) =>
      Cante(
        id: id,
        fecha: fecha ?? this.fecha,
        titulo: titulo ?? this.titulo,
        minutos: minutos ?? this.minutos,
        ejercicio: ejercicio ?? this.ejercicio,
        bolsa: bolsa ?? this.bolsa,
        temas: temas ?? this.temas,
        notas: notas ?? this.notas,
        estado: estado ?? this.estado,
        resultado: resultado ?? this.resultado,
        serie: serie ?? this.serie,
        alumno: alumno ?? this.alumno,
        preparador: preparador ?? this.preparador,
        preparadorNombre: preparadorNombre ?? this.preparadorNombre,
        motivo: motivo ?? this.motivo,
        sustitucion: sustitucion ?? this.sustitucion,
        updatedAt: DateTime.now(),
        borrado: borrado ?? this.borrado,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fecha': fecha.toIso8601String(),
        'titulo': titulo,
        'minutos': minutos,
        'ejercicio': ejercicio,
        'bolsa': bolsa.name,
        'temas': temas,
        'notas': notas,
        'estado': estado.name,
        'resultado': resultado?.toJson(),
        'serie': serie,
        if (alumno != null) 'alumno': alumno,
        if (preparador != null) 'preparador': preparador,
        if (preparadorNombre != null) 'preparadorNombre': preparadorNombre,
        if (motivo.isNotEmpty) 'motivo': motivo,
        if (sustitucion != null) 'sustitucion': sustitucion,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
        'borrado': borrado,
      };

  factory Cante.fromJson(Map<dynamic, dynamic> j) => Cante(
        id: j['id'].toString(),
        fecha: _fecha(j['fecha']) ?? DateTime.now(),
        titulo: j['titulo'] as String? ?? '',
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
        ejercicio: (j['ejercicio'] as num?)?.toInt() ?? 3,
        bolsa: TipoBolsa.values.firstWhere((b) => b.name == j['bolsa'], orElse: () => TipoBolsa.estudiados),
        temas: ((j['temas'] as List?) ?? []).map((e) => e.toString()).toList(),
        notas: j['notas'] as String? ?? '',
        estado: EstadoCante.values.firstWhere((e) => e.name == j['estado'], orElse: () => EstadoCante.pendiente),
        resultado: j['resultado'] is Map ? ResultadoCante.fromJson(j['resultado'] as Map) : null,
        serie: j['serie'] as String?,
        alumno: j['alumno'] as String?,
        preparador: j['preparador'] as String?,
        preparadorNombre: j['preparadorNombre'] as String?,
        motivo: j['motivo'] as String? ?? '',
        sustitucion: j['sustitucion'] as String?,
        updatedAt: _fecha(j['updatedAt']),
        borrado: j['borrado'] as bool? ?? false,
      );

  /// Fusiona dos listas de cantes por id quedándose con la versión más reciente.
  static List<Cante> fusionar(Iterable<Cante> a, Iterable<Cante> b) {
    final out = <String, Cante>{};
    for (final c in [...a, ...b]) {
      final otro = out[c.id];
      if (otro == null || (c.updatedAt ?? DateTime(0)).isAfter(otro.updatedAt ?? DateTime(0))) out[c.id] = c;
    }
    return out.values.toList()..sort((x, y) => x.fecha.compareTo(y.fecha));
  }
}

/// Estadísticas de un tema en el diario de cantes.
class EstadisticaTema {
  const EstadisticaTema({required this.codigo, required this.veces, required this.segundosMedios, required this.valoracionMedia, this.ultimo});
  final String codigo;
  final int veces;
  final int segundosMedios;
  /// Media de las valoraciones (0 si ninguna vez se valoró).
  final double valoracionMedia;
  final DateTime? ultimo;

  /// Flojo: valorado por debajo de 3 de media.
  bool get flojo => valoracionMedia > 0 && valoracionMedia < 3;

  static Map<String, EstadisticaTema> desde(Iterable<Cante> cantes) {
    final porTema = <String, List<Cante>>{};
    for (final c in cantes) {
      final t = c.resultado?.temaCantado;
      if (!c.hecho || c.borrado || t == null) continue;
      porTema.putIfAbsent(t, () => []).add(c);
    }
    return porTema.map((codigo, lista) {
      final valorados = lista.where((c) => c.resultado!.valoracion > 0).toList();
      final conTiempo = lista.where((c) => c.resultado!.segundos > 0).toList();
      return MapEntry(
        codigo,
        EstadisticaTema(
          codigo: codigo,
          veces: lista.length,
          segundosMedios: conTiempo.isEmpty ? 0 : conTiempo.fold<int>(0, (s, c) => s + c.resultado!.segundos) ~/ conTiempo.length,
          valoracionMedia: valorados.isEmpty ? 0 : valorados.fold<int>(0, (s, c) => s + c.resultado!.valoracion) / valorados.length,
          ultimo: lista.map((c) => c.fecha).reduce((x, y) => x.isAfter(y) ? x : y),
        ),
      );
    });
  }
}

// --------------------------------------------------------------------- Horario

/// Categorías de la hoja "Horario de estudio" del Excel.
enum Actividad {
  dormir('Dormir'),
  desayuno('Desayuno'),
  comida('Comida'),
  cena('Cena'),
  estudiar('Estudiar'),
  idioma('Idioma'),
  ejercicio('Ejercicio'),
  descanso('Descanso');

  const Actividad(this.etiqueta);
  final String etiqueta;
}

/// Semana tipo en franjas de media hora. [dias][0] es el lunes; cada día tiene 48 franjas.
class Horario {
  const Horario(this.dias);
  final List<List<Actividad>> dias;

  static const franjasPorDia = 48;
  static const nombresDias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

  /// Horario de partida, igual que el de la hoja del Excel.
  factory Horario.porDefecto() {
    List<Actividad> dia(Map<int, Actividad> cambios, Actividad base) {
      final d = List<Actividad>.filled(franjasPorDia, base, growable: false);
      cambios.forEach((i, a) => d[i] = a);
      return d;
    }

    Map<int, Actividad> rango(int desde, int hasta, Actividad a) => {for (var i = desde; i < hasta; i++) i: a};

    // Día de estudio (domingo a viernes en el Excel): franja = hora × 2.
    Map<int, Actividad> laborable({bool idiomaMediodia = false, bool idiomaTarde = false}) => {
          ...rango(0, 15, Actividad.dormir),
          ...rango(15, 17, Actividad.desayuno),
          ...rango(17, 22, Actividad.estudiar),
          22: Actividad.descanso,
          ...rango(23, 29, Actividad.estudiar),
          if (idiomaMediodia) ...rango(27, 29, Actividad.idioma),
          ...rango(29, 32, Actividad.comida),
          ...rango(32, 36, Actividad.estudiar),
          if (idiomaTarde) ...rango(32, 34, Actividad.idioma),
          36: Actividad.descanso,
          ...rango(37, 40, Actividad.estudiar),
          ...rango(40, 43, Actividad.ejercicio),
          43: Actividad.cena,
          ...rango(44, 48, Actividad.descanso),
        };

    final sabado = {
      ...rango(0, 20, Actividad.dormir),
      20: Actividad.desayuno,
      ...rango(29, 32, Actividad.comida),
      43: Actividad.cena,
    };

    return Horario([
      dia(laborable(), Actividad.descanso), // lunes
      dia(laborable(), Actividad.descanso),
      dia(laborable(idiomaMediodia: true), Actividad.descanso), // miércoles
      dia(laborable(), Actividad.descanso),
      dia(laborable(), Actividad.descanso),
      dia(sabado, Actividad.descanso),
      dia(laborable(idiomaTarde: true), Actividad.descanso), // domingo
    ]);
  }

  Horario con(int dia, int franja, Actividad a) {
    final copia = [for (final d in dias) List<Actividad>.from(d)];
    copia[dia][franja] = a;
    return Horario(copia);
  }

  /// Horas medias por día de cada actividad. Con [sinSabado] se calcula de
  /// domingo a viernes (segundo cuadro de estadísticas del Excel).
  Map<Actividad, double> horasPorDia({bool sinSabado = false}) {
    final indices = [for (var i = 0; i < 7; i++) if (!sinSabado || i != 5) i];
    final out = {for (final a in Actividad.values) a: 0.0};
    for (final i in indices) {
      for (final a in dias[i]) {
        out[a] = out[a]! + 0.5;
      }
    }
    return out.map((a, h) => MapEntry(a, h / indices.length));
  }

  /// Horas de estudio (sin idioma) de toda la semana.
  double get horasEstudioSemana => dias.fold(0.0, (s, d) => s + d.where((a) => a == Actividad.estudiar).length * 0.5);

  /// Cada día se guarda como una cadena de 48 caracteres (índice de la actividad).
  List<String> toJson() => [for (final d in dias) d.map((a) => a.index.toString()).join()];

  factory Horario.fromJson(Object? j) {
    if (j is! List || j.length != 7) return Horario.porDefecto();
    try {
      return Horario([
        for (final d in j)
          [for (final c in (d as String).split('')) Actividad.values[int.parse(c)]]
      ].map((d) => d.length == franjasPorDia ? d : throw const FormatException()).toList());
    } catch (_) {
      return Horario.porDefecto();
    }
  }
}

// ------------------------------------------------------------------------ Plan

/// Hito propio de la convocatoria (publicación de listas, simulacro…).
class Hito {
  const Hito({required this.id, required this.titulo, required this.fecha});
  final String id;
  final String titulo;
  final DateTime fecha;

  Map<String, dynamic> toJson() => {'id': id, 'titulo': titulo, 'fecha': fecha.toIso8601String()};

  factory Hito.fromJson(Map<dynamic, dynamic> j) =>
      Hito(id: j['id'].toString(), titulo: j['titulo'] as String? ?? '', fecha: _fecha(j['fecha']) ?? DateTime.now());
}

/// Planificación del opositor (documento users/{uid}/progress/plan).
class Plan {
  const Plan({
    this.fechas = const {},
    this.hitos = const [],
    this.horario,
    this.avisosCante = true,
    this.telefono = '',
    this.updatedAt,
  });

  /// Fecha de cada ejercicio (1-5) fijada por el usuario.
  final Map<int, DateTime> fechas;
  final List<Hito> hitos;
  /// null = aún no personalizado (se muestra el horario por defecto).
  final Horario? horario;
  /// Avisar la víspera y una hora antes de cada cante.
  final bool avisosCante;
  /// Teléfono del opositor para las sustituciones (lo recuerda la app; solo
  /// lo recibe el preparador que coge su cante).
  final String telefono;
  final DateTime? updatedAt;

  Plan copyWith({Map<int, DateTime>? fechas, List<Hito>? hitos, Horario? horario, bool? avisosCante, String? telefono}) => Plan(
        fechas: fechas ?? this.fechas,
        hitos: hitos ?? this.hitos,
        horario: horario ?? this.horario,
        avisosCante: avisosCante ?? this.avisosCante,
        telefono: telefono ?? this.telefono,
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'fechas': fechas.map((k, v) => MapEntry('$k', v.toIso8601String())),
        'hitos': hitos.map((h) => h.toJson()).toList(),
        'horario': horario?.toJson(),
        'avisosCante': avisosCante,
        if (telefono.isNotEmpty) 'telefono': telefono,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory Plan.fromJson(Map<dynamic, dynamic>? j) {
    if (j == null) return const Plan();
    final fechas = <int, DateTime>{};
    ((j['fechas'] as Map?) ?? {}).forEach((k, v) {
      final n = int.tryParse(k.toString());
      final f = _fecha(v);
      if (n != null && f != null) fechas[n] = f;
    });
    return Plan(
      fechas: fechas,
      hitos: ((j['hitos'] as List?) ?? []).map((e) => Hito.fromJson(e as Map)).toList(),
      horario: j['horario'] == null ? null : Horario.fromJson(j['horario']),
      avisosCante: j['avisosCante'] as bool? ?? true,
      telefono: j['telefono'] as String? ?? '',
      updatedAt: _fecha(j['updatedAt']),
    );
  }
}

// ------------------------------------------------------------- Agenda por tema

/// Algo que apuntarse para la próxima vuelta de un tema.
class Apunte {
  const Apunte({required this.id, required this.texto, required this.creado, this.hecho, this.borrado = false});
  final String id;
  final String texto;
  final DateTime creado;
  /// Cuándo se resolvió (null = pendiente).
  final DateTime? hecho;
  final bool borrado;

  bool get pendiente => hecho == null && !borrado;

  Apunte copyWith({DateTime? hecho, bool reabrir = false, bool? borrado}) =>
      Apunte(id: id, texto: texto, creado: creado, hecho: reabrir ? null : (hecho ?? this.hecho), borrado: borrado ?? this.borrado);

  Map<String, dynamic> toJson() => {'id': id, 'texto': texto, 'creado': creado.toIso8601String(), 'hecho': hecho?.toIso8601String(), 'borrado': borrado};

  factory Apunte.fromJson(Map<dynamic, dynamic> j) => Apunte(
        id: j['id'].toString(),
        texto: j['texto'] as String? ?? '',
        creado: _fecha(j['creado']) ?? DateTime.now(),
        hecho: _fecha(j['hecho']),
        borrado: j['borrado'] as bool? ?? false,
      );
}

/// Agenda de un tema: apuntes para la próxima vuelta y fechas de las vueltas dadas.
class AgendaTema {
  const AgendaTema({required this.codigo, this.apuntes = const [], this.vueltas = const [], this.updatedAt});
  final String codigo;
  final List<Apunte> apuntes;
  final List<DateTime> vueltas;
  final DateTime? updatedAt;

  List<Apunte> get pendientes => apuntes.where((a) => a.pendiente).toList();
  List<Apunte> get resueltos => apuntes.where((a) => a.hecho != null && !a.borrado).toList();
  bool get vacia => apuntes.every((a) => a.borrado) && vueltas.isEmpty;

  AgendaTema copyWith({List<Apunte>? apuntes, List<DateTime>? vueltas}) =>
      AgendaTema(codigo: codigo, apuntes: apuntes ?? this.apuntes, vueltas: vueltas ?? this.vueltas, updatedAt: DateTime.now());

  AgendaTema anadir(String texto) =>
      copyWith(apuntes: [...apuntes, Apunte(id: nuevoId(), texto: texto.trim(), creado: DateTime.now())]);

  AgendaTema alternar(String id) => copyWith(apuntes: [
        for (final a in apuntes) a.id == id ? (a.hecho == null ? a.copyWith(hecho: DateTime.now()) : a.copyWith(reabrir: true)) : a
      ]);

  AgendaTema borrar(String id) => copyWith(apuntes: [for (final a in apuntes) a.id == id ? a.copyWith(borrado: true) : a]);

  /// Registra una vuelta al tema. Los apuntes pendientes siguen pendientes
  /// para la siguiente; los resueltos quedan en el historial.
  AgendaTema vueltaCompletada([DateTime? cuando]) => copyWith(vueltas: [...vueltas, cuando ?? DateTime.now()]);

  Map<String, dynamic> toJson() => {
        'tema': codigo,
        'pendientes': apuntes.map((a) => a.toJson()).toList(),
        'vueltas': vueltas.map((v) => v.toIso8601String()).toList(),
        'agendaUpdatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
      };

  factory AgendaTema.fromJson(String codigo, Map<dynamic, dynamic>? j) => j == null
      ? AgendaTema(codigo: codigo)
      : AgendaTema(
          codigo: codigo,
          apuntes: ((j['pendientes'] as List?) ?? []).map((e) => Apunte.fromJson(e as Map)).toList(),
          vueltas: ((j['vueltas'] as List?) ?? []).map(_fecha).whereType<DateTime>().toList(),
          updatedAt: _fecha(j['agendaUpdatedAt']),
        );

  /// Une dos versiones sin perder apuntes de ningún dispositivo: se quedan
  /// todos los apuntes y, si uno está en ambas, gana el borrado o resuelto.
  static AgendaTema fusionar(AgendaTema a, AgendaTema b) {
    final porId = <String, Apunte>{};
    for (final x in [...a.apuntes, ...b.apuntes]) {
      final y = porId[x.id];
      if (y == null) {
        porId[x.id] = x;
      } else {
        porId[x.id] = Apunte(id: x.id, texto: x.texto, creado: x.creado, hecho: x.hecho ?? y.hecho, borrado: x.borrado || y.borrado);
      }
    }
    final vueltas = {...a.vueltas.map((v) => v.toIso8601String()), ...b.vueltas.map((v) => v.toIso8601String())}.map(DateTime.parse).toList()..sort();
    final reciente = (a.updatedAt ?? DateTime(0)).isAfter(b.updatedAt ?? DateTime(0)) ? a.updatedAt : b.updatedAt;
    return AgendaTema(
      codigo: a.codigo,
      apuntes: porId.values.toList()..sort((x, y) => x.creado.compareTo(y.creado)),
      vueltas: vueltas,
      updatedAt: reciente,
    );
  }
}
