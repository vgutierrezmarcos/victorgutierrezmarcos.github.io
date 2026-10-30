/// Informe de corrección de un cante que escribe el conector de IA en
/// `users/{uid}[/oposiciones/dce]/cantes/{id}/informes/{informeId}`, en nombre
/// del opositor y solo cuando él lo confirma. El preparador enlazado los lee.
class InformeCante {
  const InformeCante({
    required this.id,
    required this.fecha,
    this.origen = 'ia',
    this.cliente = '',
    this.informe = '',
    this.valoracion = 0,
    this.valoraciones = const {},
    this.comentarios = '',
    this.criterios = const {},
    this.tareas = const [],
  });

  final String id;
  final DateTime? fecha;

  /// 'ia' (los antiguos, 'claude').
  final String origen;

  /// La IA que lo escribió, tal como se presenta al conectarse ('Claude', 'Le Chat'…).
  final String cliente;

  /// El informe en Markdown.
  final String informe;

  /// 1-5 (0 = sin valoración).
  final int valoracion;
  final Map<String, int> valoraciones;
  final String comentarios;
  final Map<String, int> criterios;
  final List<String> tareas;

  /// Quién lo escribió: el nombre de la IA o, si no lo dice, «Claude» en los
  /// antiguos y «tu IA» en los demás.
  String get autor {
    if (cliente.trim().isNotEmpty) return cliente.trim();
    return origen == 'claude' ? 'Claude' : 'tu IA';
  }

  /// La primera línea con texto, sin las marcas de título ni de negrita.
  String get primeraLinea {
    for (final l in informe.split('\n')) {
      final t = l.replaceAll(RegExp(r'^\s*(#+|>|[-*+])\s*'), '').replaceAll('**', '').replaceAll('__', '').trim();
      if (t.isNotEmpty) return t;
    }
    return comentarios;
  }

  static int _nota(Object? v) => v is num ? v.round().clamp(0, 5) : (int.tryParse('$v') ?? 0).clamp(0, 5);

  static Map<String, int> _notas(Object? v) => v is Map ? {for (final e in v.entries) '${e.key}': _nota(e.value)} : const {};

  /// Las tareas pueden llegar como texto o como objetos con `texto`.
  static List<String> _tareas(Object? v) => v is List
      ? [
          for (final t in v)
            if (t is Map && (t['texto'] ?? t['tarea']) != null) '${t['texto'] ?? t['tarea']}' else if (t is! Map && '$t'.trim().isNotEmpty) '$t',
        ]
      : const [];

  /// [fecha] puede venir como texto ISO o como Timestamp de Firestore (algo con `toDate()`).
  factory InformeCante.fromJson(String id, Map<String, dynamic> j) {
    final f = j['fecha'];
    DateTime? fecha;
    if (f is String) {
      fecha = DateTime.tryParse(f)?.toLocal();
    } else if (f != null) {
      try {
        fecha = (f as dynamic).toDate() as DateTime;
      } catch (_) {}
    }
    return InformeCante(
      id: id,
      fecha: fecha,
      origen: (j['origen'] as String?) ?? 'ia',
      cliente: (j['cliente'] as String?) ?? '',
      informe: (j['informe'] as String?) ?? '',
      valoracion: _nota(j['valoracion']),
      valoraciones: _notas(j['valoraciones']),
      comentarios: (j['comentarios'] as String?) ?? '',
      criterios: _notas(j['criterios']),
      tareas: _tareas(j['tareas']),
    );
  }

  /// Los más recientes primero (los que no tienen fecha, al final).
  static List<InformeCante> ordenar(Iterable<InformeCante> informes) => [...informes]..sort((a, b) {
        if (a.fecha == null) return b.fecha == null ? 0 : 1;
        if (b.fecha == null) return -1;
        return b.fecha!.compareTo(a.fecha!);
      });
}
