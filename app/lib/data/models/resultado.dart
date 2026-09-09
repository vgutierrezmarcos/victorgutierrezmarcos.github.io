/// Resultado de un test. Mismo esquema que users/{uid}/exam_results en la web
/// (simulador.html → saveExamResult). La app añade `respuestas` (id → letra)
/// y `origen`, que la web ignora.
class ResultadoTest {
  const ResultadoTest({
    required this.id,
    required this.timestamp,
    required this.puntosBrutos,
    required this.maxPuntos,
    required this.notaSobre10,
    required this.correctas,
    required this.incorrectas,
    required this.sinResponder,
    required this.totalPreguntas,
    required this.tiempoSeconds,
    required this.temas,
    this.respuestas = const {},
    this.origen = 'app',
    this.tipo = 'test',
    this.sincronizado = false,
  });

  final String id;
  final DateTime timestamp;
  final double puntosBrutos;
  final double maxPuntos;
  final double notaSobre10;
  final int correctas;
  final int incorrectas;
  final int sinResponder;
  final int totalPreguntas;
  final int tiempoSeconds;
  final List<String> temas;
  final Map<int, String?> respuestas;
  final String origen;
  /// test | diario | repaso
  final String tipo;
  final bool sincronizado;

  double get tasaAcierto => totalPreguntas == 0 ? 0 : correctas / totalPreguntas;

  Map<String, dynamic> toFirestore() => {
        'puntosBrutos': puntosBrutos,
        'maxPuntos': maxPuntos,
        'notaSobre10': notaSobre10,
        'correctas': correctas,
        'incorrectas': incorrectas,
        'sinResponder': sinResponder,
        'totalPreguntas': totalPreguntas,
        'tiempoSeconds': tiempoSeconds,
        'temas': temas,
        'respuestas': respuestas.map((k, v) => MapEntry(k.toString(), v)),
        'origen': origen,
        'tipo': tipo,
      };

  Map<String, dynamic> toLocal() => {
        ...toFirestore(),
        'id': id,
        'timestamp': timestamp.millisecondsSinceEpoch,
        'sincronizado': sincronizado,
      };

  factory ResultadoTest.fromMap(String id, Map<dynamic, dynamic> m, {DateTime? ts}) {
    final rawResp = (m['respuestas'] as Map?) ?? {};
    return ResultadoTest(
      id: id,
      timestamp: ts ??
          (m['timestamp'] is int
              ? DateTime.fromMillisecondsSinceEpoch(m['timestamp'] as int)
              : DateTime.now()),
      puntosBrutos: (m['puntosBrutos'] as num?)?.toDouble() ?? 0,
      maxPuntos: (m['maxPuntos'] as num?)?.toDouble() ?? 0,
      notaSobre10: (m['notaSobre10'] as num?)?.toDouble() ?? 0,
      correctas: (m['correctas'] as num?)?.toInt() ?? 0,
      incorrectas: (m['incorrectas'] as num?)?.toInt() ?? 0,
      sinResponder: (m['sinResponder'] as num?)?.toInt() ?? 0,
      totalPreguntas: (m['totalPreguntas'] as num?)?.toInt() ?? 0,
      tiempoSeconds: (m['tiempoSeconds'] as num?)?.toInt() ?? 0,
      temas: ((m['temas'] as List?) ?? []).map((e) => e.toString()).toList(),
      respuestas: rawResp.map((k, v) => MapEntry(int.tryParse(k.toString()) ?? 0, v as String?)),
      origen: m['origen'] as String? ?? 'web',
      tipo: m['tipo'] as String? ?? 'test',
      sincronizado: m['sincronizado'] as bool? ?? true,
    );
  }

  ResultadoTest copyWith({bool? sincronizado, String? id}) => ResultadoTest(
        id: id ?? this.id,
        timestamp: timestamp,
        puntosBrutos: puntosBrutos,
        maxPuntos: maxPuntos,
        notaSobre10: notaSobre10,
        correctas: correctas,
        incorrectas: incorrectas,
        sinResponder: sinResponder,
        totalPreguntas: totalPreguntas,
        tiempoSeconds: tiempoSeconds,
        temas: temas,
        respuestas: respuestas,
        origen: origen,
        tipo: tipo,
        sincronizado: sincronizado ?? this.sincronizado,
      );
}
