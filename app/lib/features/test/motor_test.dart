import 'dart:math';

import '../../core/constants.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';

/// Configuración de un test (equivale a la fase de selección de simulador.html).
class ConfigTest {
  const ConfigTest({
    this.temas = const {},
    this.examenes = const {},
    this.soloOficiales = true,
    this.numPreguntas = DefaultsTest.numPreguntas,
    this.minutos = DefaultsTest.minutos,
    this.puntosAcierto = DefaultsTest.puntosAcierto,
    this.puntosFallo = DefaultsTest.puntosFallo,
    this.puntosBlanco = DefaultsTest.puntosBlanco,
    this.idsFijos,
    this.tipo = 'test',
  });

  /// Temas seleccionados (vacío = todos).
  final Set<String> temas;
  /// Exámenes seleccionados (vacío = todos).
  final Set<String> examenes;
  final bool soloOficiales;
  final int numPreguntas;
  /// 0 = sin límite de tiempo.
  final int minutos;
  final double puntosAcierto;
  final double puntosFallo;
  final double puntosBlanco;
  /// Si se indica, el test se compone exactamente de estas preguntas (repaso, test diario).
  final List<int>? idsFijos;
  final String tipo;

  ConfigTest copyWith({
    Set<String>? temas,
    Set<String>? examenes,
    bool? soloOficiales,
    int? numPreguntas,
    int? minutos,
    double? puntosAcierto,
    double? puntosFallo,
    double? puntosBlanco,
    List<int>? idsFijos,
    String? tipo,
  }) =>
      ConfigTest(
        temas: temas ?? this.temas,
        examenes: examenes ?? this.examenes,
        soloOficiales: soloOficiales ?? this.soloOficiales,
        numPreguntas: numPreguntas ?? this.numPreguntas,
        minutos: minutos ?? this.minutos,
        puntosAcierto: puntosAcierto ?? this.puntosAcierto,
        puntosFallo: puntosFallo ?? this.puntosFallo,
        puntosBlanco: puntosBlanco ?? this.puntosBlanco,
        idsFijos: idsFijos ?? this.idsFijos,
        tipo: tipo ?? this.tipo,
      );
}

class MotorTest {
  MotorTest._();

  /// Preguntas que cumplen los filtros de la configuración.
  static List<Pregunta> filtrar(BancoPreguntas banco, ConfigTest c) {
    return banco.preguntas.where((p) {
      if (c.soloOficiales && !p.oficial) return false;
      if (c.temas.isNotEmpty && !p.temas.any(c.temas.contains)) return false;
      if (c.examenes.isNotEmpty && !c.examenes.contains(p.examen)) return false;
      return true;
    }).toList();
  }

  /// Compone el test: baraja las candidatas y toma [numPreguntas].
  static List<Pregunta> componer(BancoPreguntas banco, ConfigTest c, {Random? random}) {
    if (c.idsFijos != null) {
      return c.idsFijos!.map(banco.porId).whereType<Pregunta>().toList();
    }
    final candidatas = filtrar(banco, c);
    candidatas.shuffle(random ?? Random());
    return candidatas.take(c.numPreguntas).toList();
  }

  /// Test diario: [n] preguntas oficiales elegidas de forma determinista por fecha,
  /// de modo que todos los usuarios reciben el mismo test cada día.
  static List<Pregunta> testDiario(BancoPreguntas banco, DateTime dia, {int n = DefaultsTest.preguntasTestDiario}) {
    final semilla = dia.year * 10000 + dia.month * 100 + dia.day;
    final candidatas = banco.preguntas.where((p) => p.oficial && !p.anulada).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    candidatas.shuffle(Random(semilla));
    return candidatas.take(n).toList();
  }

  /// Corrige el test. `respuestas`: id de pregunta → letra (null / ausente = en blanco).
  /// Reproduce el cálculo de simulador.html (finalizarExamen).
  static ResultadoTest corregir({
    required List<Pregunta> preguntas,
    required Map<int, String?> respuestas,
    required ConfigTest config,
    required int tiempoSeconds,
    DateTime? ahora,
  }) {
    var correctas = 0, incorrectas = 0, blanco = 0;
    for (final p in preguntas) {
      final r = respuestas[p.id];
      if (r == null) {
        blanco++;
      } else if (p.esCorrecta(r)) {
        correctas++;
      } else {
        incorrectas++;
      }
    }
    final puntos = correctas * config.puntosAcierto +
        incorrectas * config.puntosFallo +
        blanco * config.puntosBlanco;
    final max = preguntas.length * config.puntosAcierto;
    final nota = max == 0 ? 0.0 : (puntos / max) * 10;
    final ts = ahora ?? DateTime.now();
    return ResultadoTest(
      id: 'local_${ts.millisecondsSinceEpoch}',
      timestamp: ts,
      puntosBrutos: puntos,
      maxPuntos: max,
      notaSobre10: nota,
      correctas: correctas,
      incorrectas: incorrectas,
      sinResponder: blanco,
      totalPreguntas: preguntas.length,
      tiempoSeconds: tiempoSeconds,
      temas: config.temas.toList()..sort(),
      respuestas: {for (final p in preguntas) p.id: respuestas[p.id]},
      tipo: config.tipo,
    );
  }

  /// Puntuación por bloque (para el gráfico de resultados y estadísticas).
  static Map<String, ({int aciertos, int total})> porBloque(
    List<Pregunta> preguntas,
    Map<int, String?> respuestas,
    Bloques bloques,
  ) {
    final out = <String, ({int aciertos, int total})>{};
    for (final p in preguntas) {
      final b = bloques.bloqueDe(p.tema);
      final prev = out[b] ?? (aciertos: 0, total: 0);
      final ok = respuestas[p.id] != null && p.esCorrecta(respuestas[p.id]);
      out[b] = (aciertos: prev.aciertos + (ok ? 1 : 0), total: prev.total + 1);
    }
    return out;
  }
}
