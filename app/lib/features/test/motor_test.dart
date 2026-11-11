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
    this.modoEstudio = false,
    this.pesos,
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
  /// test | diario | repaso
  final String tipo;
  /// Corregir cada pregunta al responder, con su explicación (sin tiempo).
  final bool modoEstudio;
  /// «Mis puntos flojos»: peso de cada pregunta (id → peso) para componer el
  /// test; sin él, al azar (ver [MotorTest.pesosPuntosFlojos]).
  final Map<int, double>? pesos;

  bool get ponderado => pesos != null && pesos!.isNotEmpty;

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
    bool? modoEstudio,
    Map<int, double>? pesos,
    bool sinPesos = false,
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
        modoEstudio: modoEstudio ?? this.modoEstudio,
        pesos: sinPesos ? null : (pesos ?? this.pesos),
      );

  /// Para guardar un test a medias (sin los pesos: las preguntas ya están elegidas).
  Map<String, dynamic> toJson() => {
        'temas': temas.toList(),
        'examenes': examenes.toList(),
        'soloOficiales': soloOficiales,
        'numPreguntas': numPreguntas,
        'minutos': minutos,
        'puntosAcierto': puntosAcierto,
        'puntosFallo': puntosFallo,
        'puntosBlanco': puntosBlanco,
        if (idsFijos != null) 'idsFijos': idsFijos,
        'tipo': tipo,
        'modoEstudio': modoEstudio,
      };

  factory ConfigTest.fromJson(Map<dynamic, dynamic> j) => ConfigTest(
        temas: ((j['temas'] as List?) ?? []).map((e) => e.toString()).toSet(),
        examenes: ((j['examenes'] as List?) ?? []).map((e) => e.toString()).toSet(),
        soloOficiales: j['soloOficiales'] as bool? ?? true,
        numPreguntas: (j['numPreguntas'] as num?)?.toInt() ?? DefaultsTest.numPreguntas,
        minutos: (j['minutos'] as num?)?.toInt() ?? DefaultsTest.minutos,
        puntosAcierto: (j['puntosAcierto'] as num?)?.toDouble() ?? DefaultsTest.puntosAcierto,
        puntosFallo: (j['puntosFallo'] as num?)?.toDouble() ?? DefaultsTest.puntosFallo,
        puntosBlanco: (j['puntosBlanco'] as num?)?.toDouble() ?? DefaultsTest.puntosBlanco,
        idsFijos: (j['idsFijos'] as List?)?.map((e) => (e as num).toInt()).toList(),
        tipo: j['tipo'] as String? ?? 'test',
        modoEstudio: j['modoEstudio'] as bool? ?? false,
      );
}

/// Un test a medias, guardado en el dispositivo para seguirlo después (al
/// salir del examen con «Guardar y seguir luego», y en cada respuesta).
class TestEnCurso {
  const TestEnCurso({required this.config, required this.ids, required this.respuestas, this.marcadas = const [], this.indice = 0, this.segundos = 0, required this.guardado});

  final ConfigTest config;
  /// Las preguntas del test, en su orden.
  final List<int> ids;
  final Map<int, String?> respuestas;
  final List<int> marcadas;
  final int indice;
  final int segundos;
  final DateTime guardado;

  int get respondidas => respuestas.values.where((v) => v != null).length;

  Map<String, dynamic> toJson() => {
        'config': config.toJson(),
        'ids': ids,
        'respuestas': respuestas.map((k, v) => MapEntry(k.toString(), v)),
        'marcadas': marcadas,
        'indice': indice,
        'segundos': segundos,
        'guardado': guardado.millisecondsSinceEpoch,
      };

  factory TestEnCurso.fromJson(Map<dynamic, dynamic> j) => TestEnCurso(
        config: ConfigTest.fromJson((j['config'] as Map?) ?? const {}),
        ids: ((j['ids'] as List?) ?? []).map((e) => (e as num).toInt()).toList(),
        respuestas: ((j['respuestas'] as Map?) ?? {}).map((k, v) => MapEntry(int.parse(k.toString()), v as String?)),
        marcadas: ((j['marcadas'] as List?) ?? []).map((e) => (e as num).toInt()).toList(),
        indice: (j['indice'] as num?)?.toInt() ?? 0,
        segundos: (j['segundos'] as num?)?.toInt() ?? 0,
        guardado: DateTime.fromMillisecondsSinceEpoch((j['guardado'] as num?)?.toInt() ?? 0),
      );
}

/// Acierto acumulado en una clave (tema, pregunta…).
typedef Acierto = ({int ok, int total});

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

  /// Compone el test: baraja las candidatas y toma [numPreguntas]. Con
  /// [ConfigTest.pesos], muestreo sin reposición proporcional al peso (las
  /// candidatas sin peso cuentan como peso 1).
  static List<Pregunta> componer(BancoPreguntas banco, ConfigTest c, {Random? random}) {
    if (c.idsFijos != null) {
      return c.idsFijos!.map(banco.porId).whereType<Pregunta>().toList();
    }
    final candidatas = filtrar(banco, c);
    final rnd = random ?? Random();
    if (c.ponderado) {
      // Clave exponencial: -ln(u)/peso; las de clave menor salen primero.
      final claves = {for (final p in candidatas) p.id: -log(1 - rnd.nextDouble()) / max(c.pesos![p.id] ?? 1.0, 1e-6)};
      candidatas.sort((a, b) => claves[a.id]!.compareTo(claves[b.id]!));
      final elegidas = candidatas.take(c.numPreguntas).toList()..shuffle(rnd);
      return elegidas;
    }
    candidatas.shuffle(rnd);
    return candidatas.take(c.numPreguntas).toList();
  }

  /// Pesos de «Mis puntos flojos»: más probable cuanto peor se lleva el tema
  /// ([aciertoPorTema], de los tests hechos), cuanto más cae en el examen
  /// ([frecuencias], parte de cada test que es de ese tema) y si la pregunta
  /// ya se ha fallado ([falladas]). Sin historial de un tema, acierto medio.
  static Map<int, double> pesosPuntosFlojos(
    Iterable<Pregunta> candidatas, {
    Map<String, Acierto> aciertoPorTema = const {},
    Map<String, double>? frecuencias,
    Set<int> falladas = const {},
    int minimoRespuestas = 3,
  }) {
    double? aciertoDe(Pregunta p) {
      var ok = 0, total = 0;
      for (final t in p.temas.toSet()) {
        final a = aciertoPorTema[t];
        if (a != null) {
          ok += a.ok;
          total += a.total;
        }
      }
      return total >= minimoRespuestas ? ok / total : null;
    }

    final lista = candidatas.toList();
    // La frecuencia, normalizada a media 1 entre las candidatas, para que no
    // aplaste al acierto; los temas sin dato valen la media.
    var frec = <int, double>{};
    if (frecuencias != null && frecuencias.isNotEmpty) {
      final f = {for (final p in lista) p.id: p.temas.map((t) => frecuencias[t] ?? 0.0).fold(0.0, (a, b) => a + b)};
      final conDato = f.values.where((v) => v > 0).toList();
      final media = conDato.isEmpty ? 0.0 : conDato.reduce((a, b) => a + b) / conDato.length;
      if (media > 0) frec = f.map((id, v) => MapEntry(id, v > 0 ? v / media : 1.0));
    }
    return {
      for (final p in lista)
        p.id: (0.15 + (1 - (aciertoDe(p) ?? 0.5))) * (frec[p.id] ?? 1.0).clamp(0.25, 4.0) * (falladas.contains(p.id) ? 2.0 : 1.0),
    };
  }

  /// Acierto por tema con el detalle de los tests ([ResultadoTest.respuestas]);
  /// una pregunta de varios temas cuenta para todos.
  static Map<String, Acierto> aciertoPorTema(Iterable<ResultadoTest> tests, BancoPreguntas banco) {
    final out = <String, Acierto>{};
    for (final r in tests) {
      r.respuestas.forEach((id, letra) {
        final p = banco.porId(id);
        if (p == null) return;
        final ok = letra != null && p.esCorrecta(letra);
        for (final t in p.temas.toSet()) {
          final prev = out[t] ?? (ok: 0, total: 0);
          out[t] = (ok: prev.ok + (ok ? 1 : 0), total: prev.total + 1);
        }
      });
    }
    return out;
  }

  /// Fallos por pregunta (en blanco no cuenta como fallo), de más a menos
  /// fallada; a igual número, la de peor proporción.
  static List<({int id, int fallos, int intentos})> masFalladas(Iterable<ResultadoTest> tests, BancoPreguntas banco) {
    final fallos = <int, int>{}, intentos = <int, int>{};
    for (final r in tests) {
      r.respuestas.forEach((id, letra) {
        final p = banco.porId(id);
        if (p == null) return;
        intentos[id] = (intentos[id] ?? 0) + 1;
        if (letra != null && !p.esCorrecta(letra)) fallos[id] = (fallos[id] ?? 0) + 1;
      });
    }
    final out = [for (final e in fallos.entries) (id: e.key, fallos: e.value, intentos: intentos[e.key] ?? e.value)];
    out.sort((a, b) {
      final c = b.fallos.compareTo(a.fallos);
      return c != 0 ? c : (b.fallos / b.intentos).compareTo(a.fallos / a.intentos);
    });
    return out;
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
    Iterable<int> marcadas = const [],
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
    final ids = {for (final p in preguntas) p.id};
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
      marcadas: marcadas.where(ids.contains).toList()..sort(),
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
