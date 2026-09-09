/// Modelos del banco de preguntas (preguntas.json de la web).
class ImagenPregunta {
  const ImagenPregunta({required this.src, required this.alt});
  final String src;
  final String alt;

  factory ImagenPregunta.fromJson(Map<String, dynamic> j) =>
      ImagenPregunta(src: j['src'] as String, alt: (j['alt'] as String?) ?? '');
}

class Pregunta {
  const Pregunta({
    required this.id,
    required this.examen,
    required this.numero,
    required this.temas,
    required this.enunciado,
    required this.opciones,
    required this.respuesta,
    required this.oficial,
    this.tipoPregunta,
    this.imagenes = const [],
  });

  final int id;
  final String examen;
  final int numero;
  final List<String> temas;
  final String enunciado;
  final Map<String, String> opciones; // a, b, c, d
  final List<String> respuesta; // puede haber más de una válida
  final bool oficial;
  /// "aceptada" (anulada: se cuenta siempre como acierto) o "incorrecta".
  final String? tipoPregunta;
  final List<ImagenPregunta> imagenes;

  String get tema => temas.isEmpty ? '' : temas.first;
  bool get anulada => tipoPregunta == 'aceptada';

  /// Idéntico a simulador.html: anulada → acierto; si no, la letra debe estar en `respuesta`.
  bool esCorrecta(String? letra) {
    if (anulada) return true;
    if (letra == null) return false;
    return respuesta.contains(letra);
  }

  factory Pregunta.fromJson(Map<String, dynamic> j) {
    final ops = (j['opciones'] as Map<String, dynamic>? ?? {})
        .map((k, v) => MapEntry(k, v.toString()));
    return Pregunta(
      id: (j['id'] as num).toInt(),
      examen: j['examen'] as String? ?? '',
      numero: (j['numero'] as num?)?.toInt() ?? 0,
      temas: (j['temas'] as List? ?? []).map((e) => e.toString()).toList(),
      enunciado: j['enunciado'] as String? ?? '',
      opciones: ops,
      respuesta: (j['respuesta'] as List? ?? []).map((e) => e.toString()).toList(),
      oficial: j['oficial'] as bool? ?? true,
      tipoPregunta: j['tipo_pregunta'] as String?,
      imagenes: (j['imagenes'] as List? ?? [])
          .map((e) => ImagenPregunta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Examen {
  const Examen({required this.id, required this.nombre, required this.fecha, required this.convocatoria});
  final String id;
  final String nombre;
  final String fecha;
  final String convocatoria;

  factory Examen.fromJson(Map<String, dynamic> j) => Examen(
        id: j['id'] as String,
        nombre: j['nombre'] as String? ?? j['id'] as String,
        fecha: j['fecha'] as String? ?? '',
        convocatoria: j['convocatoria'] as String? ?? '',
      );
}

class BancoPreguntas {
  const BancoPreguntas({required this.preguntas, required this.examenes, required this.temas});
  final List<Pregunta> preguntas;
  final List<Examen> examenes;
  /// Código de tema (3.A.1) → enunciado oficial.
  final Map<String, String> temas;

  factory BancoPreguntas.fromJson(Map<String, dynamic> j) => BancoPreguntas(
        preguntas: (j['preguntas'] as List).map((e) => Pregunta.fromJson(e as Map<String, dynamic>)).toList(),
        examenes: (j['examenes'] as List? ?? []).map((e) => Examen.fromJson(e as Map<String, dynamic>)).toList(),
        temas: (j['temas'] as Map<String, dynamic>? ?? {}).map((k, v) => MapEntry(k, v.toString())),
      );

  Pregunta? porId(int id) {
    for (final p in preguntas) {
      if (p.id == id) return p;
    }
    return null;
  }
}

/// bloques.json: agrupación de temas del tercer ejercicio en bloques.
class Bloque {
  const Bloque({required this.id, required this.nombre, required this.parte, required this.temas});
  final int id;
  final String nombre;
  final String parte; // A / B
  final List<String> temas;

  factory Bloque.fromJson(Map<String, dynamic> j) => Bloque(
        id: (j['id'] as num).toInt(),
        nombre: j['nombre'] as String,
        parte: j['parte'] as String? ?? '',
        temas: (j['temas'] as List).map((e) => e.toString()).toList(),
      );
}

class Bloques {
  const Bloques({required this.bloques, required this.temaABloque});
  final List<Bloque> bloques;
  final Map<String, String> temaABloque;

  String bloqueDe(String tema) => temaABloque[tema] ?? 'Otros';

  factory Bloques.fromJson(Map<String, dynamic> j) => Bloques(
        bloques: (j['bloques'] as List).map((e) => Bloque.fromJson(e as Map<String, dynamic>)).toList(),
        temaABloque: (j['temaABloque'] as Map<String, dynamic>).map((k, v) => MapEntry(k, v.toString())),
      );

  static const vacio = Bloques(bloques: [], temaABloque: {});
}
