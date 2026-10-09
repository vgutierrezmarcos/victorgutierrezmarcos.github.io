import 'dart:math';

/// Un examen oficial del test con las preguntas que tuvo cada tema.
class ExamenFrecuencia {
  const ExamenFrecuencia({required this.id, required this.nombre, required this.anio, required this.preguntas, required this.temas, this.sinTexto = false});
  final String id;
  final String nombre;
  final int anio;
  final int preguntas;
  final Map<String, int> temas;

  /// Clasificado por tema pero sin el texto de las preguntas (no está en el simulador).
  final bool sinTexto;

  factory ExamenFrecuencia.fromJson(Map<String, dynamic> j) => ExamenFrecuencia(
        id: j['id'] as String,
        nombre: (j['nombre'] as String).replaceFirst(RegExp(r'^Examen oficial de '), ''),
        anio: (j['anio'] as num).toInt(),
        preguntas: (j['preguntas'] as num).toInt(),
        temas: {for (final e in ((j['temas'] as Map?) ?? {}).entries) e.key as String: (e.value as num).toInt()},
        sinTexto: j['sinTexto'] == true,
      );
}

/// Peso de los exámenes recientes en las frecuencias: un examen de hace
/// [vidaMedia] años cuenta la mitad que uno de este año (0 = todos igual).
enum PesoRecientes {
  igual(0, 'Igual'),
  mas(10, 'Más'),
  muchoMas(5, 'Mucho más');

  const PesoRecientes(this.vidaMedia, this.etiqueta);
  final int vidaMedia;
  final String etiqueta;
}

/// Frecuencia de cada tema en el test del primer ejercicio
/// (frecuencia_temas.json, de scripts/frecuencia-test.py).
class FrecuenciaTest {
  const FrecuenciaTest({required this.temas, required this.examenes});

  /// Temas que entran en el test (código → título).
  final Map<String, String> temas;
  final List<ExamenFrecuencia> examenes;

  factory FrecuenciaTest.fromJson(Map<String, dynamic> j) => FrecuenciaTest(
        temas: {for (final e in ((j['temas'] as Map?) ?? {}).entries) e.key as String: e.value as String},
        examenes: [for (final e in (j['examenes'] as List? ?? const [])) ExamenFrecuencia.fromJson(Map<String, dynamic>.from(e as Map))],
      );

  int get totalPreguntas => examenes.fold(0, (s, e) => s + e.preguntas);

  List<double> pesos(PesoRecientes peso, {int? anioActual}) {
    final hoy = anioActual ?? DateTime.now().year;
    return [for (final e in examenes) peso.vidaMedia == 0 ? 1.0 : pow(0.5, (hoy - e.anio) / peso.vidaMedia).toDouble()];
  }

  /// Parte de cada test que es de cada tema (media ponderada de los exámenes).
  Map<String, double> frecuencias(PesoRecientes peso) {
    final w = pesos(peso), total = w.fold(0.0, (a, b) => a + b);
    final f = {for (final c in temas.keys) c: 0.0};
    for (var i = 0; i < examenes.length; i++) {
      final e = examenes[i];
      for (final t in e.temas.entries) {
        if (f.containsKey(t.key)) f[t.key] = f[t.key]! + w[i] * t.value / e.preguntas;
      }
    }
    return {for (final e in f.entries) e.key: total == 0 ? 0 : e.value / total};
  }

  /// En cuántos exámenes ha salido alguna pregunta del tema.
  int examenesConTema(String codigo) => examenes.where((e) => (e.temas[codigo] ?? 0) > 0).length;

  /// Preguntas del tema en todos los exámenes.
  int preguntasDeTema(String codigo) => examenes.fold(0, (s, e) => s + (e.temas[codigo] ?? 0));

  /// Temas ordenados de más a menos preguntados.
  List<String> masPreguntados(PesoRecientes peso) {
    final f = frecuencias(peso);
    return f.keys.toList()..sort((a, b) => f[b]!.compareTo(f[a]!));
  }

  /// Parte de cada examen que es de los temas [sel].
  List<double> coberturas(Set<String> sel) => [
        for (final e in examenes) e.preguntas == 0 ? 0 : e.temas.entries.where((t) => sel.contains(t.key)).fold(0, (s, t) => s + t.value) / e.preguntas,
      ];
}

/// «2,4 % de las preguntas · salió en 18 de 22 exámenes» (con más peso los recientes).
String textoFrecuencia(FrecuenciaTest f, String codigo) {
  final p = (f.frecuencias(PesoRecientes.mas)[codigo] ?? 0) * 100;
  return '${p.toStringAsFixed(1).replaceAll('.', ',')} % de las preguntas · salió en ${f.examenesConTema(codigo)} de ${f.examenes.length} exámenes';
}
