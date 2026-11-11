/// Cronograma por fases de un ejercicio escrito (1.º de DCE): primera vuelta,
/// simulacros y revisión de temas flojos (semiarrastre). Las fases son una
/// sugerencia: el opositor cambia sus fechas o se salta alguna.
///
/// Los números se pueden cambiar sin publicar la app en `app-config.json`
/// → `fasesEscrito` de la web de la oposición (ver [FasesEscrito.conCambios]).
library;

DateTime? _fecha(Object? s) => s is String ? DateTime.tryParse(s) : null;

enum TipoFase {
  vuelta('Primera vuelta', 'Estudiar todos los temas una vez, en orden, y escribir cada uno al menos una vez.'),
  simulacros('Simulacros', 'Simulacros escritos como en el examen: dos bolas de cada parte, un tema de cada par, 3 horas y sin apuntes.'),
  revision('Revisión de temas flojos', 'Se siguen haciendo simulacros y se vuelven a meter los temas flojos (semiarrastre).');

  const TipoFase(this.nombre, this.explicacion);
  final String nombre;
  final String explicacion;
}

/// Configuración de las fases de un ejercicio escrito.
class FasesEscrito {
  const FasesEscrito({
    this.reparto = const {TipoFase.vuelta: 0.55, TipoFase.simulacros: 0.30, TipoFase.revision: 0.15},
    this.minutosSimulacro = 180,
    this.simulacrosPorSemana = 2,
    this.maxFlojosSemana = 3,
    this.diasSinEscribir = 42,
    this.minSalidasDescarte = 3,
    this.proporcionDescarte = 2 / 3,
    this.maxTemasSemana = 6,
  });

  /// Parte de las semanas hasta el examen que se lleva cada fase, en este orden.
  final Map<TipoFase, double> reparto;
  /// Lo que dura el examen (y el cronómetro del simulacro).
  final int minutosSimulacro;
  /// Simulacros que se proponen cada semana en las fases de simulacros y revisión.
  final int simulacrosPorSemana;
  /// Temas flojos que entran como mucho en una semana de revisión (y nunca
  /// más de un tercio de los temas de esa semana).
  final int maxFlojosSemana;
  /// Un tema es flojo si lleva más de estos días sin escribirse.
  final int diasSinEscribir;
  /// … o si, habiendo salido al menos [minSalidasDescarte] veces en
  /// simulacros, se descartó en [proporcionDescarte] de ellas o más.
  final int minSalidasDescarte;
  final double proporcionDescarte;
  /// Ritmo de la primera vuelta a partir del cual se avisa de que no da tiempo.
  final int maxTemasSemana;

  /// Esta configuración con lo que cambie la web (`fasesEscrito.{ejercicio}`).
  FasesEscrito conCambios(Map<dynamic, dynamic>? j) {
    if (j == null) return this;
    double? num_(String k) => j[k] is num ? (j[k] as num).toDouble() : null;
    final r = j['reparto'];
    return FasesEscrito(
      reparto: r is Map
          ? {for (final t in TipoFase.values) t: r[t.name] is num ? (r[t.name] as num).toDouble() : reparto[t] ?? 0}
          : reparto,
      minutosSimulacro: num_('minutosSimulacro')?.round() ?? minutosSimulacro,
      simulacrosPorSemana: num_('simulacrosPorSemana')?.round() ?? simulacrosPorSemana,
      maxFlojosSemana: num_('maxFlojosSemana')?.round() ?? maxFlojosSemana,
      diasSinEscribir: num_('diasSinEscribir')?.round() ?? diasSinEscribir,
      minSalidasDescarte: num_('minSalidasDescarte')?.round() ?? minSalidasDescarte,
      proporcionDescarte: num_('proporcionDescarte') ?? proporcionDescarte,
      maxTemasSemana: num_('maxTemasSemana')?.round() ?? maxTemasSemana,
    );
  }
}

/// Una fase de un cronograma: del primer día de su primera semana
/// ([inicio]) al último de la última ([fin]).
class FaseCronograma {
  const FaseCronograma({required this.tipo, required this.inicio, required this.fin, this.saltada = false});
  final TipoFase tipo;
  final DateTime inicio;
  final DateTime fin;
  /// El opositor se la salta: no ocupa semanas.
  final bool saltada;

  bool contiene(DateTime d) {
    final dia = DateTime(d.year, d.month, d.day);
    return !saltada && !dia.isBefore(inicio) && !dia.isAfter(fin);
  }

  /// Semanas que ocupa (redondeando hacia arriba).
  int get semanas => saltada ? 0 : ((fin.difference(inicio).inDays + 1) / 7).ceil();

  Map<String, dynamic> toJson() => {'tipo': tipo.name, 'inicio': inicio.toIso8601String(), 'fin': fin.toIso8601String(), if (saltada) 'saltada': true};

  factory FaseCronograma.fromJson(Map<dynamic, dynamic> j) => FaseCronograma(
        tipo: TipoFase.values.firstWhere((t) => t.name == j['tipo'], orElse: () => TipoFase.vuelta),
        inicio: _fecha(j['inicio']) ?? DateTime(2026),
        fin: _fecha(j['fin']) ?? DateTime(2026),
        saltada: j['saltada'] as bool? ?? false,
      );
}

/// Valoración de un tema escrito. Se guarda en las valoraciones del diario
/// (1-5) como 5, 3 y 1, para que las estadísticas y el sorteo ponderado de
/// los cantes la entiendan.
enum NotaEscrito {
  bien('Bien', 5),
  regular('Regular', 3),
  mal('Mal', 1);

  const NotaEscrito(this.nombre, this.valor);
  final String nombre;
  final int valor;

  /// La nota de una valoración de 1 a 5 (null si no se valoró).
  static NotaEscrito? de(int valor) => valor <= 0 ? null : (valor >= 4 ? bien : (valor >= 3 ? regular : mal));
}
