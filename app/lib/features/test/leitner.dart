/// Repetición espaciada (modelo Leitner). Réplica de spaced-repetition.js
/// de la web para que el estado sea intercambiable:
///   `{ questions: { "<id>": {box, lastSession, timesCorrect, timesFailed} }, sessionCount }`
/// La app añade a cada pregunta `lastDate` (milisegundos): así una pregunta
/// también vence por días, no solo por sesiones, y vuelve aunque no se hagan
/// tests. La web lo ignora y lo conserva (cambia las entradas en el sitio).
class EntradaLeitner {
  EntradaLeitner({required this.box, required this.lastSession, this.timesCorrect = 0, this.timesFailed = 0, this.lastDate});
  int box;
  int lastSession;
  int timesCorrect;
  int timesFailed;
  /// Última vez que se respondió (milisegundos desde 1970), o null si viene
  /// de la web o de antes de guardarse la fecha.
  int? lastDate;

  Map<String, dynamic> toJson() => {
        'box': box,
        'lastSession': lastSession,
        'timesCorrect': timesCorrect,
        'timesFailed': timesFailed,
        if (lastDate != null) 'lastDate': lastDate,
      };

  factory EntradaLeitner.fromJson(Map<dynamic, dynamic> j) => EntradaLeitner(
        box: (j['box'] as num?)?.toInt() ?? 1,
        lastSession: (j['lastSession'] as num?)?.toInt() ?? 0,
        timesCorrect: (j['timesCorrect'] as num?)?.toInt() ?? 0,
        timesFailed: (j['timesFailed'] as num?)?.toInt() ?? 0,
        lastDate: (j['lastDate'] as num?)?.toInt(),
      );
}

class EstadoLeitner {
  EstadoLeitner({Map<int, EntradaLeitner>? questions, this.sessionCount = 0})
      : questions = questions ?? {};

  final Map<int, EntradaLeitner> questions;
  int sessionCount;

  /// Intervalo de cada caja en sesiones (tests terminados), como en la web.
  static const intervalos = {1: 1, 2: 2, 3: 4, 4: 8};

  /// Y en días: una pregunta vence también cuando pasan estos días desde la
  /// última vez que se respondió, aunque no se hagan tests.
  static const intervalosDias = {1: 1, 2: 3, 3: 7, 4: 15};

  /// Registrar el resultado de una pregunta (recordAnswer en JS).
  void registrar(int id, bool correcta, {DateTime? ahora}) {
    final fecha = (ahora ?? DateTime.now()).millisecondsSinceEpoch;
    final e = questions[id];
    if (e == null) {
      // Solo se añade si fue incorrecta la primera vez
      if (!correcta) {
        questions[id] = EntradaLeitner(box: 1, lastSession: sessionCount, timesFailed: 1, lastDate: fecha);
      }
      return;
    }
    if (correcta) {
      e.box = e.box + 1 > 5 ? 5 : e.box + 1;
      e.timesCorrect++;
    } else {
      e.box = 1;
      e.timesFailed++;
    }
    e.lastSession = sessionCount;
    e.lastDate = fecha;
  }

  /// Registrar un examen completo e incrementar la sesión (recordExamResults en JS).
  /// [resultados]: id → acertada (sin responder cuenta como fallo).
  void registrarExamen(Map<int, bool> resultados, {DateTime? ahora}) {
    resultados.forEach((id, ok) => registrar(id, ok, ahora: ahora));
    sessionCount++;
  }

  /// Preguntas cuyo intervalo ha vencido (getDueQuestionIds en JS), en
  /// sesiones o en días.
  List<int> pendientes({DateTime? ahora}) {
    final hoy = (ahora ?? DateTime.now()).millisecondsSinceEpoch;
    final due = <int>[];
    questions.forEach((id, e) {
      if (e.box >= 5) return;
      final intervalo = intervalos[e.box] ?? 1;
      if (sessionCount - e.lastSession >= intervalo) {
        due.add(id);
        return;
      }
      final dias = intervalosDias[e.box] ?? 1;
      if (e.lastDate != null && hoy - e.lastDate! >= dias * Duration.millisecondsPerDay) due.add(id);
    });
    due.sort();
    return due;
  }

  Map<int, int> get porCaja {
    final boxes = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final e in questions.values) {
      boxes[e.box] = (boxes[e.box] ?? 0) + 1;
    }
    return boxes;
  }

  Map<String, dynamic> toJson() => {
        'questions': questions.map((k, v) => MapEntry(k.toString(), v.toJson())),
        'sessionCount': sessionCount,
      };

  factory EstadoLeitner.fromJson(Map<dynamic, dynamic>? j) {
    if (j == null) return EstadoLeitner();
    final q = (j['questions'] as Map?) ?? {};
    return EstadoLeitner(
      questions: q.map((k, v) => MapEntry(int.parse(k.toString()), EntradaLeitner.fromJson(v as Map))),
      sessionCount: (j['sessionCount'] as num?)?.toInt() ?? 0,
    );
  }

  /// Fusión para sincronizar local ↔ nube: gana el estado con más sesiones;
  /// para cada pregunta se conserva la entrada con más intentos.
  static EstadoLeitner fusionar(EstadoLeitner a, EstadoLeitner b) {
    final base = a.sessionCount >= b.sessionCount ? a : b;
    final otro = identical(base, a) ? b : a;
    final out = EstadoLeitner(sessionCount: base.sessionCount);
    for (final id in {...a.questions.keys, ...b.questions.keys}) {
      final ea = base.questions[id];
      final eb = otro.questions[id];
      if (ea == null) {
        out.questions[id] = eb!;
      } else if (eb == null) {
        out.questions[id] = ea;
      } else {
        final ia = ea.timesCorrect + ea.timesFailed;
        final ib = eb.timesCorrect + eb.timesFailed;
        out.questions[id] = ib > ia ? eb : ea;
      }
    }
    return out;
  }
}
