import 'dart:math';

import 'oposicion.dart';

/// Modelos de planificación: cantes, convocatoria, horario y agenda por tema. Se guardan en local (Hive) y, con sesión, en Firestore
/// bajo users/{uid}/cantes, users/{uid}/progress/plan y users/{uid}/notes.

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;

/// Identificador corto y único (no hace falta que sea criptográfico).
///
/// Ojo con la versión web: dart2js devuelve 0 en `1 << 32` (solo llega a 31
/// bits), y `nextInt(0)` lanza un RangeError que tiraba cada pantalla o botón
/// que creaba un id (cronogramas, clases, cantes…). Por eso el tope se escribe
/// como número y no como desplazamiento.
String nuevoId([Random? random]) {
  final r = random ?? Random();
  return '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}${r.nextInt(_topeAleatorio).toRadixString(36)}';
}

/// 2^30: cabe en un entero de la web y en el rango de [Random.nextInt].
const _topeAleatorio = 1073741824;

// ---------------------------------------------------------------------- Cantes

/// De dónde salen los temas que entran en el sorteo de un cante.
enum TipoBolsa { lista, estudiados, ejercicio }

enum EstadoCante { pendiente, hecho, cancelado }

/// Cómo fue un cante (diario de cantes).
class ResultadoCante {
  const ResultadoCante({
    this.sorteados = const [],
    this.temaCantado,
    this.otrosCantados = const [],
    this.segundos = 0,
    this.valoracion = 0,
    this.valoraciones = const {},
    this.comentarios = '',
    this.descartados = const [],
    this.cubiertos = const {},
    this.apartados = const {},
    this.criterios = const {},
  });

  /// Rúbrica: valoración 1-5 de cada criterio (nombre → estrellas), si quien
  /// valora la usa; la de siempre ([valoracion]) sigue siendo la agregada.
  final Map<String, int> criterios;

  /// «Esquema ★★★★ · Rigor ★★» (vacío si no hay criterios).
  String textoCriterios({String separador = ' · '}) => [for (final e in criterios.entries) if (e.value > 0) '${e.key} ${'★' * e.value}${'☆' * (5 - e.value)}'].join(separador);

  /// Lista de control: por tema, los apartados del esquema que se tocaron
  /// (sus títulos) y cuántos tenía el esquema ([apartados]). Lo marca el
  /// opositor al valorar (o en el esquema a ciegas) o el preparador mientras
  /// escucha. Las versiones anteriores lo ignoran.
  final Map<String, List<String>> cubiertos;
  final Map<String, int> apartados;

  /// «14/19 apartados» del tema, o null si no se marcó la lista.
  String? textoCobertura(String tema) {
    final total = apartados[tema] ?? 0;
    return total == 0 ? null : '${(cubiertos[tema] ?? const []).length}/$total apartados';
  }

  /// La cobertura de todos los temas cantados («14/19 · 9/12 apartados»), o null.
  String? get textoCoberturaTotal {
    final partes = [for (final t in temasCantados) if (apartados[t] case final n? when n > 0) '${(cubiertos[t] ?? const []).length}/$n'];
    return partes.isEmpty ? null : '${partes.join(' · ')} apartados';
  }

  final List<String> sorteados;
  /// En un simulacro escrito, el tema que se dejó de cada par sorteado. Si
  /// un tema se descarta casi siempre, es que no se domina (temas flojos).
  final List<String> descartados;
  final String? temaCantado;
  /// Cuando se cantan varios (los dos que manda el preparador o los dos de un
  /// simulacro): los demás, en orden, después de [temaCantado]. Va aparte para
  /// que las versiones anteriores sigan leyendo [temaCantado].
  final List<String> otrosCantados;
  List<String> get temasCantados => [if (temaCantado != null) temaCantado!, ...otrosCantados];
  final int segundos;
  /// 1-5; 0 = sin valorar. Con varios temas, la media de [valoraciones]
  /// redondeada (lo que leen las versiones anteriores y las estadísticas
  /// del cante entero).
  final int valoracion;
  /// Con varios temas, la valoración de cada uno (1-5), por código.
  final Map<String, int> valoraciones;
  /// Comentarios propios o del preparador.
  final String comentarios;

  /// La valoración de [tema]: la suya si se valoró aparte; si no, la del cante.
  int valoracionDe(String tema) => valoraciones[tema] ?? valoracion;

  /// Media redondeada de las valoraciones dadas (0 si ninguna).
  static int media(Iterable<int> valores) {
    final dadas = valores.where((v) => v > 0).toList();
    return dadas.isEmpty ? 0 : (dadas.fold<int>(0, (s, v) => s + v) / dadas.length).round();
  }

  ResultadoCante copyWith({List<String>? sorteados, String? temaCantado, List<String>? otrosCantados, int? segundos, int? valoracion, Map<String, int>? valoraciones, String? comentarios, List<String>? descartados, Map<String, List<String>>? cubiertos, Map<String, int>? apartados, Map<String, int>? criterios}) =>
      ResultadoCante(
        sorteados: sorteados ?? this.sorteados,
        temaCantado: temaCantado ?? this.temaCantado,
        otrosCantados: otrosCantados ?? this.otrosCantados,
        segundos: segundos ?? this.segundos,
        valoracion: valoracion ?? this.valoracion,
        valoraciones: valoraciones ?? this.valoraciones,
        comentarios: comentarios ?? this.comentarios,
        descartados: descartados ?? this.descartados,
        cubiertos: cubiertos ?? this.cubiertos,
        apartados: apartados ?? this.apartados,
        criterios: criterios ?? this.criterios,
      );

  Map<String, dynamic> toJson() => {
        'sorteados': sorteados,
        'temaCantado': temaCantado,
        if (otrosCantados.isNotEmpty) 'otrosCantados': otrosCantados,
        'segundos': segundos,
        'valoracion': valoracion,
        if (valoraciones.isNotEmpty) 'valoraciones': valoraciones,
        'comentarios': comentarios,
        if (descartados.isNotEmpty) 'descartados': descartados,
        if (cubiertos.isNotEmpty) 'cubiertos': cubiertos,
        if (apartados.isNotEmpty) 'apartados': apartados,
        if (criterios.isNotEmpty) 'criterios': criterios,
      };

  factory ResultadoCante.fromJson(Map<dynamic, dynamic> j) => ResultadoCante(
        sorteados: ((j['sorteados'] as List?) ?? []).map((e) => e.toString()).toList(),
        temaCantado: j['temaCantado'] as String?,
        otrosCantados: ((j['otrosCantados'] as List?) ?? []).map((e) => e.toString()).toList(),
        segundos: (j['segundos'] as num?)?.toInt() ?? 0,
        valoracion: (j['valoracion'] as num?)?.toInt() ?? 0,
        valoraciones: j['valoraciones'] is Map ? {for (final e in (j['valoraciones'] as Map).entries) if (e.value is num) e.key.toString(): (e.value as num).toInt()} : const {},
        comentarios: j['comentarios'] as String? ?? '',
        descartados: ((j['descartados'] as List?) ?? []).map((e) => e.toString()).toList(),
        cubiertos: j['cubiertos'] is Map ? {for (final e in (j['cubiertos'] as Map).entries) if (e.value is List) e.key.toString(): [for (final x in e.value as List) x.toString()]} : const {},
        apartados: j['apartados'] is Map ? {for (final e in (j['apartados'] as Map).entries) if (e.value is num) e.key.toString(): (e.value as num).toInt()} : const {},
        criterios: j['criterios'] is Map ? {for (final e in (j['criterios'] as Map).entries) if (e.value is num && (e.value as num) > 0) e.key.toString(): (e.value as num).toInt().clamp(1, 5)} : const {},
      );
}

/// Criterios de valoración por defecto (la web puede dar otros en
/// app-config.json → `rubrica`; cada preparador u opositor, los suyos).
const rubricaPorDefecto = ['Esquema', 'Rigor', 'Tiempo', 'Exposición', 'Actualidad'];

/// Evolución de cada criterio: media de los últimos [n] cantes valorados con
/// él frente a los [n] anteriores (null si no hay anteriores). [cantes] van
/// de más reciente a más antiguo.
Map<String, ({double ultimos, double? anteriores, int veces})> evolucionCriterios(Iterable<Cante> cantes, {int n = 5}) {
  final porCriterio = <String, List<int>>{};
  for (final c in cantes) {
    final r = c.resultado;
    if (!c.hecho || c.borrado || r == null) continue;
    for (final e in r.criterios.entries) {
      if (e.value > 0) porCriterio.putIfAbsent(e.key, () => []).add(e.value);
    }
  }
  double media(List<int> v) => v.fold<int>(0, (s, x) => s + x) / v.length;
  return {
    for (final e in porCriterio.entries)
      e.key: (
        ultimos: media(e.value.take(n).toList()),
        anteriores: e.value.length > n ? media(e.value.skip(n).take(n).toList()) : null,
        veces: e.value.length,
      ),
  };
}

/// Lee «28», «28:30» o «28,5» como segundos (minutos, minutos:segundos o
/// minutos con decimales); null si no se entiende o es cero.
int? leerDuracionCante(String texto) {
  final t = texto.trim().replaceAll(',', '.');
  if (t.isEmpty) return null;
  final partes = t.split(':');
  if (partes.length == 2) {
    final m = int.tryParse(partes[0].trim()), s = int.tryParse(partes[1].trim());
    if (m == null || s == null || s < 0 || s > 59) return null;
    final total = m * 60 + s;
    return total <= 0 ? null : total;
  }
  final m = double.tryParse(t);
  if (m == null || m <= 0) return null;
  return (m * 60).round();
}

/// «28:30» (o «28» si son minutos justos).
String textoDuracionCante(int segundos) => segundos % 60 == 0 ? '${segundos ~/ 60}' : '${segundos ~/ 60}:${(segundos % 60).toString().padLeft(2, '0')}';

/// Qué apartados de un tema se cuentan y cuáles no, a partir de las listas de
/// control de sus cantes y esquemas a ciegas: título → (veces tocado, veces
/// que estuvo en la lista).
class CoberturaApartados {
  const CoberturaApartados(this.porApartado);
  final Map<String, ({int cubierto, int ofrecido})> porApartado;

  static CoberturaApartados desde(Iterable<Cante> cantes, String tema, {Iterable<String>? apartados}) {
    final out = <String, ({int cubierto, int ofrecido})>{for (final a in apartados ?? const <String>[]) a: (cubierto: 0, ofrecido: 0)};
    for (final c in cantes) {
      final r = c.resultado;
      if (!c.hecho || c.borrado || r == null || (r.apartados[tema] ?? 0) == 0) continue;
      final marcados = (r.cubiertos[tema] ?? const <String>[]).toSet();
      // Lo que no se marcó también cuenta como ofrecido: solo se sabe de los
      // apartados que aparecen en alguna lista (los marcados) o en [apartados].
      for (final a in {...out.keys, ...marcados}) {
        final p = out[a] ?? (cubierto: 0, ofrecido: 0);
        out[a] = (cubierto: p.cubierto + (marcados.contains(a) ? 1 : 0), ofrecido: p.ofrecido + 1);
      }
    }
    return CoberturaApartados(out);
  }

  /// Apartados que en dos o más cantes con lista nunca se han tocado.
  List<String> get nuncaCubiertos => [for (final e in porApartado.entries) if (e.value.ofrecido >= 2 && e.value.cubierto == 0) e.key];
}

/// Dónde es un cante: en persona o por videollamada.
enum Modalidad { sinIndicar, presencial, online }

/// Abre una reunión nueva de Google Meet (con la cuenta de Google del navegador
/// o de la app de Meet); su enlace se copia y se pega en el cante.
const urlNuevaReunionMeet = 'https://meet.google.com/new';

/// Reunión nueva de Microsoft Teams (Teams personal; con una cuenta del
/// trabajo se crea en su Teams y se pega el enlace).
const urlNuevaReunionTeams = 'https://teams.live.com/meet';

/// Plataformas de videollamada que propone la app. El enlace vale de
/// cualquiera; esto solo cambia el botón de crear la reunión y el texto.
const plataformaMeet = 'meet';
const plataformaTeams = 'teams';

/// 'meet' o 'teams' según el enlace, o '' si no se reconoce.
String plataformaDeEnlace(String enlace) {
  final e = enlace.toLowerCase();
  if (e.contains('meet.google.com')) return plataformaMeet;
  if (e.contains('teams.microsoft.com') || e.contains('teams.live.com')) return plataformaTeams;
  return '';
}

/// «Meet», «Teams» o «videollamada».
String nombrePlataforma(String plataforma) => switch (plataforma) {
      plataformaMeet => 'Meet',
      plataformaTeams => 'Teams',
      _ => 'videollamada',
    };

/// El enlace de una videollamada escrito o pegado por el usuario, completo
/// (añade https:// si falta), o null si no parece un enlace. Vale cualquiera
/// (Meet, Zoom, Teams…), aunque la app propone Meet.
String? enlaceReunion(String texto) {
  var t = texto.trim();
  if (t.isEmpty) return null;
  final m = RegExp(r'(https?://)?[\w.-]+\.[a-z]{2,}(/[^\s]*)?', caseSensitive: false).firstMatch(t);
  if (m == null) return null;
  t = m.group(0)!;
  return t.startsWith('http') ? t : 'https://$t';
}

class Cante {
  const Cante({
    required this.id,
    required this.fecha,
    this.titulo = '',
    this.minutos = 30,
    this.exposicion = 30,
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
    this.canceladoPor,
    this.ocultaAlAlumno = false,
    this.sustitucion,
    this.updatedAt,
    this.borrado = false,
    this.modalidad = Modalidad.sinIndicar,
    this.lugar = '',
    this.enlace = '',
    this.temaA,
    this.temasMandados = const [],
    this.temaSorteado = false,
    this.numTemas = 2,
    this.unoPorParte = false,
    this.plataforma = '',
    this.eventoGoogle = '',
    this.eventoGoogleAlumno = '',
    this.notasCompartidas = false,
    this.temasPropuestos = const [],
    this.propuestaTemasA,
    this.esquema = false,
  });

  final String id;

  /// Esquema a ciegas (sacar el esquema de memoria y compararlo), no un cante
  /// entero: cuenta aparte en las estadísticas y las versiones anteriores lo
  /// ven como un cante corto.
  final bool esquema;

  /// Temas que el preparador propone para esta clase (vacío si no propone
  /// nada). Los temas de la clase los decide el opositor
  /// ([TemasClase] en sus ajustes); el preparador solo propone y el opositor
  /// acepta o rechaza. Van en la copia del alumno.
  final List<String> temasPropuestos;

  /// Cuándo hizo el preparador la propuesta: está pendiente mientras el
  /// opositor no haya respondido después.
  final DateTime? propuestaTemasA;

  /// El preparador ha compartido con el alumno sus notas de la clase (su
  /// segunda pizarra): el alumno las ve en cuanto las comparte.
  final bool notasCompartidas;

  /// La clase ya ha pasado (o se dio por hecha).
  bool get terminada => hecho || fecha.add(Duration(minutes: minutos)).isBefore(DateTime.now());

  /// Evento del Google Calendar del preparador que corresponde a esta clase
  /// (vacío si no está en su calendario). Solo lo usa el preparador: no va en
  /// la copia del alumno.
  final String eventoGoogle;

  /// Evento del Google Calendar del propio opositor (si tiene conectado «Mis
  /// cantes en Google Calendar»): el de sus cantes y el de las clases cuyo
  /// preparador no las lleva a su calendario. Nunca es el del preparador, que
  /// va en [eventoGoogle] y se pisaría al copiar la clase.
  final String eventoGoogleAlumno;

  /// Hora a la que el preparador manda un tema al alumno antes de la clase
  /// (la ve el alumno; el tema no, hasta esa hora).
  final DateTime? temaA;

  /// Los temas que se mandan (uno o dos). Solo los tiene el preparador: nunca
  /// van en la copia del alumno (se le entregan aparte, en temasAnticipados,
  /// a su hora).
  final List<String> temasMandados;

  /// El primero de los temas mandados (compatibilidad con las clases antiguas,
  /// que mandaban uno solo).
  String? get temaMandado => temasMandados.firstOrNull;

  /// Los temas los ha sacado la app al azar: tampoco el preparador los ve antes.
  final bool temaSorteado;

  /// Cuántos temas se cantan en esta clase (lo normal cerca del examen: 2).
  final int numTemas;

  /// Al sortearlos, uno de cada parte del ejercicio (como en el examen).
  final bool unoPorParte;

  /// Videollamada que propone el preparador ('meet' o 'teams'; vacío = la
  /// que diga el enlace). La elige siempre el preparador.
  final String plataforma;

  /// 'meet', 'teams' o '': la plataforma dicha o la que se deduce del enlace.
  String get plataformaEfectiva => plataforma.isNotEmpty ? plataforma : plataformaDeEnlace(enlace);

  bool get mandaTema => temaA != null && temasMandados.isNotEmpty;
  /// Presencial u online.
  final Modalidad modalidad;
  /// Dónde, si es presencial (opcional).
  final String lugar;
  /// Enlace de la videollamada (Google Meet u otra), si es online.
  final String enlace;
  /// Fecha y hora del cante (hora local).
  final DateTime fecha;
  /// Con quién o dónde ("Preparador", "Simulacro"…).
  final String titulo;
  /// Duración de la clase o del cante, en minutos (lo que ocupa en la agenda
  /// y en el calendario).
  final int minutos;

  /// Minutos de exposición por tema: lo que cuenta el cronómetro al cantar.
  /// Quien crea el cante lo toma de [Oposicion.minutosExposicion] (TCEE 30,
  /// DCE 20); el 30 del constructor es solo el de las versiones anteriores.
  final int exposicion;
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
  /// Quién la canceló (uid): el alumno o el preparador. Así cada uno sabe si
  /// la canceló el otro (y se le avisa).
  final String? canceladoPor;
  /// Solo en el lado del preparador: el alumno la ha quitado de su agenda
  /// (cancelada); al preparador le sigue saliendo, pero no se le vuelve a mandar.
  final bool ocultaAlAlumno;
  /// Cante que coge un preparador sustituto: id de la petición de sustitución.
  final String? sustitucion;
  final DateTime? updatedAt;
  /// Borrado lógico, para que la eliminación llegue a los demás dispositivos.
  final bool borrado;

  bool get hecho => estado == EstadoCante.hecho;
  bool get pendiente => estado == EstadoCante.pendiente;
  bool get dePreparador => preparador != null;
  bool get cancelado => estado == EstadoCante.cancelado;
  bool get online => modalidad == Modalidad.online;
  bool get presencial => modalidad == Modalidad.presencial;
  /// «Online · meet.google.com/abc-defg-hij», «Presencial · Calle…» o vacío.
  String get descripcionModalidad => switch (modalidad) {
        Modalidad.online => enlace.isEmpty ? 'Online${plataforma.isEmpty ? '' : ' · ${nombrePlataforma(plataforma)}'}' : 'Online · ${enlace.replaceFirst(RegExp(r'^https?://'), '')}',
        Modalidad.presencial => lugar.isEmpty ? 'Presencial' : 'Presencial · $lugar',
        Modalidad.sinIndicar => '',
      };

  Cante copyWith({
    DateTime? fecha,
    String? titulo,
    int? minutos,
    int? exposicion,
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
    String? canceladoPor,
    bool? ocultaAlAlumno,
    String? sustitucion,
    bool? borrado,
    Modalidad? modalidad,
    String? lugar,
    String? enlace,
    DateTime? temaA,
    bool? notasCompartidas,
    List<String>? temasMandados,
    bool? temaSorteado,
    bool sinTema = false,
    int? numTemas,
    bool? unoPorParte,
    String? plataforma,
    bool? esquema,
    String? eventoGoogle,
    String? eventoGoogleAlumno,
    List<String>? temasPropuestos,
    DateTime? propuestaTemasA,
    bool sinPropuesta = false,
  }) =>
      Cante(
        id: id,
        fecha: fecha ?? this.fecha,
        titulo: titulo ?? this.titulo,
        minutos: minutos ?? this.minutos,
        exposicion: exposicion ?? this.exposicion,
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
        canceladoPor: canceladoPor ?? this.canceladoPor,
        ocultaAlAlumno: ocultaAlAlumno ?? this.ocultaAlAlumno,
        notasCompartidas: notasCompartidas ?? this.notasCompartidas,
        sustitucion: sustitucion ?? this.sustitucion,
        updatedAt: DateTime.now(),
        borrado: borrado ?? this.borrado,
        modalidad: modalidad ?? this.modalidad,
        lugar: lugar ?? this.lugar,
        enlace: enlace ?? this.enlace,
        temaA: sinTema ? null : (temaA ?? this.temaA),
        temasMandados: sinTema ? const [] : (temasMandados ?? this.temasMandados),
        temaSorteado: sinTema ? false : (temaSorteado ?? this.temaSorteado),
        numTemas: numTemas ?? this.numTemas,
        unoPorParte: unoPorParte ?? this.unoPorParte,
        plataforma: plataforma ?? this.plataforma,
        esquema: esquema ?? this.esquema,
        eventoGoogle: eventoGoogle ?? this.eventoGoogle,
        eventoGoogleAlumno: eventoGoogleAlumno ?? this.eventoGoogleAlumno,
        temasPropuestos: sinPropuesta ? const [] : (temasPropuestos ?? this.temasPropuestos),
        propuestaTemasA: sinPropuesta ? null : (propuestaTemasA ?? this.propuestaTemasA),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fecha': fecha.toIso8601String(),
        'titulo': titulo,
        if (modalidad != Modalidad.sinIndicar) 'modalidad': modalidad.name,
        if (lugar.isNotEmpty) 'lugar': lugar,
        if (enlace.isNotEmpty) 'enlace': enlace,
        'minutos': minutos,
        'exposicion': exposicion,
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
        if (canceladoPor != null) 'canceladoPor': canceladoPor,
        if (ocultaAlAlumno) 'ocultaAlAlumno': true,
        if (notasCompartidas) 'notasCompartidas': true,
        if (sustitucion != null) 'sustitucion': sustitucion,
        'updatedAt': (updatedAt ?? DateTime.now()).toIso8601String(),
        'borrado': borrado,
        if (temaA != null) 'temaA': temaA!.toIso8601String(),
        // El primero también como temaMandado, que es lo que leen las versiones anteriores.
        if (temasMandados.isNotEmpty) 'temaMandado': temasMandados.first,
        if (temasMandados.isNotEmpty) 'temasMandados': temasMandados,
        if (temaSorteado) 'temaSorteado': true,
        if (numTemas != 2) 'numTemas': numTemas,
        if (unoPorParte) 'unoPorParte': true,
        if (plataforma.isNotEmpty) 'plataforma': plataforma,
        if (esquema) 'esquema': true,
        if (eventoGoogle.isNotEmpty) 'eventoGoogle': eventoGoogle,
        if (eventoGoogleAlumno.isNotEmpty) 'eventoGoogleAlumno': eventoGoogleAlumno,
        if (temasPropuestos.isNotEmpty) 'temasPropuestos': temasPropuestos,
        if (propuestaTemasA != null) 'propuestaTemasA': propuestaTemasA!.toIso8601String(),
      };

  factory Cante.fromJson(Map<dynamic, dynamic> j) {
    final ejercicio = (j['ejercicio'] as num?)?.toInt() ?? 3;
    return Cante(
        id: j['id'].toString(),
        fecha: _fecha(j['fecha']) ?? DateTime.now(),
        titulo: j['titulo'] as String? ?? '',
        minutos: (j['minutos'] as num?)?.toInt() ?? 30,
        // Las versiones anteriores no guardaban la exposición por defecto (30
        // en todas las oposiciones): se lee como la del examen de cada una.
        exposicion: (j['exposicion'] as num?)?.toInt() ?? Oposiciones.actual.minutosExposicion(ejercicio),
        ejercicio: ejercicio,
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
        canceladoPor: j['canceladoPor'] as String?,
        ocultaAlAlumno: j['ocultaAlAlumno'] == true,
        notasCompartidas: j['notasCompartidas'] == true,
        sustitucion: j['sustitucion'] as String?,
        updatedAt: _fecha(j['updatedAt']),
        borrado: j['borrado'] as bool? ?? false,
        modalidad: Modalidad.values.firstWhere((m) => m.name == j['modalidad'], orElse: () => Modalidad.sinIndicar),
        lugar: j['lugar'] as String? ?? '',
        enlace: j['enlace'] as String? ?? '',
        temaA: _fecha(j['temaA']),
        temasMandados: j['temasMandados'] is List
            ? [for (final t in j['temasMandados'] as List) t.toString()]
            : [if (j['temaMandado'] is String) j['temaMandado'] as String],
        temaSorteado: j['temaSorteado'] as bool? ?? false,
        numTemas: (j['numTemas'] as num?)?.toInt() ?? 2,
        unoPorParte: j['unoPorParte'] as bool? ?? false,
        plataforma: j['plataforma'] as String? ?? '',
        esquema: j['esquema'] == true,
        eventoGoogle: j['eventoGoogle'] as String? ?? '',
        eventoGoogleAlumno: j['eventoGoogleAlumno'] as String? ?? '',
        temasPropuestos: ((j['temasPropuestos'] as List?) ?? []).map((e) => e.toString()).toList(),
        propuestaTemasA: _fecha(j['propuestaTemasA']),
      );
  }

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
  const EstadisticaTema({required this.codigo, required this.veces, required this.segundosMedios, required this.valoracionMedia, this.ultimo, this.esquemas = 0});
  final String codigo;
  /// Cantes enteros (sin los esquemas a ciegas).
  final int veces;
  /// Esquemas a ciegas hechos del tema.
  final int esquemas;
  final int segundosMedios;
  /// Media de las valoraciones (0 si ninguna vez se valoró).
  final double valoracionMedia;
  final DateTime? ultimo;

  /// Flojo: valorado por debajo de 3 de media.
  bool get flojo => valoracionMedia > 0 && valoracionMedia < 3;

  static Map<String, EstadisticaTema> desde(Iterable<Cante> cantes) {
    final porTema = <String, List<Cante>>{};
    for (final c in cantes) {
      if (!c.hecho || c.borrado) continue;
      for (final t in c.resultado?.temasCantados ?? const <String>[]) {
        porTema.putIfAbsent(t, () => []).add(c);
      }
    }
    return porTema.map((codigo, lista) {
      // Los esquemas a ciegas cuentan aparte (y refrescan el tema); la
      // valoración y el tiempo medios son de los cantes enteros.
      final enteros = lista.where((c) => !c.esquema).toList();
      // La valoración de ese tema en cada cante (la suya, si se valoró aparte).
      final valorados = enteros.where((c) => c.resultado!.valoracionDe(codigo) > 0).toList();
      final conTiempo = enteros.where((c) => c.resultado!.segundos > 0).toList();
      return MapEntry(
        codigo,
        EstadisticaTema(
          codigo: codigo,
          veces: enteros.length,
          esquemas: lista.length - enteros.length,
          segundosMedios: conTiempo.isEmpty ? 0 : conTiempo.fold<int>(0, (s, c) => s + c.resultado!.segundos) ~/ conTiempo.length,
          valoracionMedia: valorados.isEmpty ? 0 : valorados.fold<int>(0, (s, c) => s + c.resultado!.valoracionDe(codigo)) / valorados.length,
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
