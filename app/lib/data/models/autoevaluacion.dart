/// Autoevaluación de un tema revisado: 24 preguntas cortas (definición,
/// fórmula, predicción del modelo y verdadero o falso) para responder de
/// memoria. Las publica la web en oposicion/temario/app/autoevaluacion/
/// (scripts/autoevaluacion.py); son materiales exclusivos, como el tema.
class PreguntaAuto {
  const PreguntaAuto({required this.id, required this.tipo, required this.apartado, required this.pregunta, required this.respuesta, this.verdadero});
  final String id, tipo, apartado, pregunta, respuesta;

  /// Solo en las de verdadero o falso.
  final bool? verdadero;

  bool get esVf => tipo == 'vf';

  String get etiquetaTipo => switch (tipo) { 'definicion' => 'Concepto', 'formula' => 'Fórmula', 'prediccion' => '¿Qué predice?', 'vf' => 'Verdadero o falso', _ => 'Pregunta' };

  static PreguntaAuto? deJson(Object? j) {
    if (j is! Map) return null;
    final id = j['id'], p = j['pregunta'], r = j['respuesta'];
    if (id is! String || p is! String || r is! String) return null;
    return PreguntaAuto(id: id, tipo: (j['tipo'] as String?) ?? '', apartado: (j['apartado'] as String?) ?? '', pregunta: p, respuesta: r, verdadero: j['verdadero'] as bool?);
  }
}

class Autoevaluacion {
  const Autoevaluacion({required this.codigo, required this.preguntas});
  final String codigo;
  final List<PreguntaAuto> preguntas;

  factory Autoevaluacion.fromJson(Map<dynamic, dynamic> j) => Autoevaluacion(
        codigo: (j['codigo'] as String?) ?? '',
        preguntas: [for (final x in (j['preguntas'] as List?) ?? const []) PreguntaAuto.deJson(x)].whereType<PreguntaAuto>().toList(),
      );
}

/// Qué temas tienen autoevaluación (código → nombre de fichero).
class IndiceAutoevaluacion {
  const IndiceAutoevaluacion(this.archivos);
  final Map<String, String> archivos;
  static const vacio = IndiceAutoevaluacion({});

  factory IndiceAutoevaluacion.fromJson(Map<dynamic, dynamic> j) {
    final t = (j['temas'] as Map?) ?? const {};
    return IndiceAutoevaluacion({
      for (final e in t.entries)
        if (e.value is Map && (e.value as Map)['archivo'] is String) e.key.toString(): (e.value as Map)['archivo'] as String,
    });
  }

  String? archivoDe(String codigo) => archivos[codigo];
}

/// Leitner de la autoevaluación de un tema: caja 1-5 por pregunta y cuándo se
/// respondió. Vence a los 1, 3, 7 y 15 días (la caja 5 ya está dominada).
class LeitnerAuto {
  const LeitnerAuto(this.estado);

  /// id → (caja, última vez).
  final Map<String, ({int caja, DateTime ultima})> estado;

  static const intervalos = {1: 1, 2: 3, 3: 7, 4: 15};

  factory LeitnerAuto.fromJson(Object? j) {
    if (j is! Map) return const LeitnerAuto({});
    return LeitnerAuto({
      for (final e in j.entries)
        if (e.value is Map)
          e.key.toString(): (
            caja: (((e.value as Map)['c'] as num?)?.toInt() ?? 1).clamp(1, 5),
            ultima: DateTime.fromMillisecondsSinceEpoch(((e.value as Map)['u'] as num?)?.toInt() ?? 0),
          ),
    });
  }

  Map<String, dynamic> toJson() => {for (final e in estado.entries) e.key: {'c': e.value.caja, 'u': e.value.ultima.millisecondsSinceEpoch}};

  bool vencida(String id, DateTime ahora) {
    final e = estado[id];
    if (e == null) return true; // nueva
    if (e.caja >= 5) return false;
    final dias = intervalos[e.caja] ?? 1;
    final vence = DateTime(e.ultima.year, e.ultima.month, e.ultima.day + dias);
    return !vence.isAfter(ahora);
  }

  /// Las de esta sesión: primero las vencidas ya vistas (las de caja más baja),
  /// luego las nuevas, como mucho [maximo].
  List<PreguntaAuto> sesion(List<PreguntaAuto> preguntas, DateTime ahora, {int maximo = 12}) {
    final vistas = preguntas.where((p) => estado.containsKey(p.id) && vencida(p.id, ahora)).toList()..sort((a, b) => estado[a.id]!.caja.compareTo(estado[b.id]!.caja));
    final nuevas = preguntas.where((p) => !estado.containsKey(p.id));
    return [...vistas, ...nuevas].take(maximo).toList();
  }

  LeitnerAuto responder(String id, bool sabia, DateTime ahora) {
    final caja = estado[id]?.caja ?? 1;
    return LeitnerAuto({...estado, id: (caja: sabia ? (caja + 1).clamp(1, 5) : 1, ultima: ahora)});
  }

  int dominadas(Iterable<PreguntaAuto> preguntas) => preguntas.where((p) => (estado[p.id]?.caja ?? 0) >= 5).length;
  int pendientes(Iterable<PreguntaAuto> preguntas, DateTime ahora) => preguntas.where((p) => vencida(p.id, ahora)).length;
}
