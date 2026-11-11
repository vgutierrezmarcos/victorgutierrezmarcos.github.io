/// Gráfico de una explicación: `explicaciones/graficos/<archivo>.webp`.
class GraficoExplicacion {
  const GraficoExplicacion({required this.archivo, this.pie = '', this.alt = ''});
  final String archivo;
  final String pie;
  final String alt;

  factory GraficoExplicacion.fromJson(Map<String, dynamic> j) =>
      GraficoExplicacion(archivo: j['archivo'] as String, pie: j['pie'] as String? ?? '', alt: j['alt'] as String? ?? '');
}

/// Explicación de una pregunta del test: por qué la respuesta oficial es la
/// correcta y por qué fallan las demás. Se publican por examen en
/// `explicaciones/<examen>.json`, junto a preguntas.json (solo las lee la app).
class Explicacion {
  const Explicacion({required this.clave, required this.desarrollo, required this.opciones, this.graficos = const [], this.temas = const [], this.fuentes = const []});

  /// Una o dos frases con la idea que resuelve la pregunta.
  final String clave;

  /// Razonamiento completo (párrafos separados por una línea en blanco, con fórmulas).
  final String desarrollo;

  /// Por qué cada opción es (o no es) la que hay que marcar.
  final Map<String, String> opciones;

  /// Gráficos que ayudan a entenderla (se ven antes del desarrollo).
  final List<GraficoExplicacion> graficos;
  final List<String> temas;
  final List<String> fuentes;

  /// Párrafos del desarrollo; los que empiezan por «Ojo:» avisan de que la clave
  /// oficial ha quedado desfasada o es discutible.
  List<String> get parrafos => desarrollo.split(RegExp(r'\n\s*\n')).map((p) => p.trim()).where((p) => p.isNotEmpty).toList();

  factory Explicacion.fromJson(Map<String, dynamic> j) => Explicacion(
        clave: j['clave'] as String? ?? '',
        desarrollo: j['desarrollo'] as String? ?? '',
        opciones: (j['opciones'] as Map<String, dynamic>? ?? {}).map((k, v) => MapEntry(k, v is Map ? (v['texto'] ?? '').toString() : v.toString())),
        graficos: (j['graficos'] as List? ?? []).map((e) => GraficoExplicacion.fromJson(e as Map<String, dynamic>)).toList(),
        temas: (j['temas'] as List? ?? []).map((e) => e.toString()).toList(),
        fuentes: (j['fuentes'] as List? ?? []).map((e) => e.toString()).toList(),
      );

  /// `{"explicaciones": {"<id>": {...}}}` → explicaciones por id de pregunta.
  static Map<int, Explicacion> deExamen(Map<String, dynamic> j) {
    final m = j['explicaciones'] as Map<String, dynamic>? ?? {};
    return {for (final e in m.entries) int.parse(e.key): Explicacion.fromJson(e.value as Map<String, dynamic>)};
  }
}
