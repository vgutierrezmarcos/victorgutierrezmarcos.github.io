import 'dart:math';

import '../../data/models/plan.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';

/// Lo que se sabe de un tema para el mapa de calor del temario.
class DatosTema {
  const DatosTema({this.estudiado = false, this.enRepaso = false, this.valoracion = 0, this.cantes = 0, this.aciertos = 0, this.respuestas = 0, this.ultimo});

  final bool estudiado;
  final bool enRepaso;

  /// Media de las valoraciones de sus cantes (1-5; 0 si no hay).
  final double valoracion;
  final int cantes;

  /// Preguntas de test de este tema acertadas y contestadas.
  final int aciertos;
  final int respuestas;

  /// Última vez que se repasó (una vuelta) o se cantó.
  final DateTime? ultimo;

  bool get conTest => respuestas >= minimoRespuestas;
  double get acierto => respuestas == 0 ? 0 : aciertos / respuestas;

  /// Respuestas de test que hacen falta para que el acierto cuente.
  static const minimoRespuestas = 3;
}

/// Cómo se colorea el mapa.
enum LenteMapa {
  dominio('Dominio'),
  cantes('Cantes'),
  test('Test'),
  repaso('Repaso'),
  /// Lo que cae en el test (frecuencia en los exámenes oficiales; se calcula aparte).
  cae('Lo que cae');

  const LenteMapa(this.nombre);
  final String nombre;
}

/// Días para que un repaso «se enfríe» a la mitad.
const _vidaMedia = 30;

/// Lo fresco que está un tema (1 = hoy; 0,5 a los 30 días).
double frescura(DateTime ultimo, DateTime ahora) => pow(0.5, max(0, ahora.difference(ultimo).inHours / 24) / _vidaMedia).toDouble();

/// Valor de 0 a 1 de un tema con la [lente], o null si no hay datos.
///
/// El dominio pondera si está estudiado (30 %), los cantes (40 %), el test
/// (15 %) y lo reciente del último repaso o cante (15 %). Lo que no se sabe
/// cuenta como regular si el tema está estudiado (cantes 0,4; test 0,5;
/// repaso 0,3) y como nada si no: un tema solo marcado como estudiado se
/// queda a medias (58), no «dominado». Sin estudiar y sin nada más, sin dato.
double? valorTema(DatosTema d, LenteMapa lente, DateTime ahora) {
  switch (lente) {
    case LenteMapa.cantes:
      return d.valoracion > 0 ? (d.valoracion - 1) / 4 : null;
    case LenteMapa.test:
      return d.conTest ? d.acierto : null;
    case LenteMapa.repaso:
      return d.ultimo == null ? null : frescura(d.ultimo!, ahora);
    case LenteMapa.cae:
      return null;
    case LenteMapa.dominio:
      if (!d.estudiado && d.valoracion == 0 && !d.conTest && d.ultimo == null) return null;
      final e = d.estudiado ? 1.0 : 0.0;
      final cantes = d.valoracion > 0 ? (d.valoracion - 1) / 4 : 0.4 * e;
      final test = d.conTest ? d.acierto : 0.5 * e;
      final fresco = d.ultimo != null ? frescura(d.ultimo!, ahora) : 0.3 * e;
      return 0.3 * e + 0.4 * cantes + 0.15 * test + 0.15 * fresco;
  }
}

/// Junta, para cada tema, lo que se sabe de él: temas estudiados y en
/// repaso, estadísticas de los cantes, vueltas y respuestas de los tests.
Map<String, DatosTema> datosPorTema({
  required Iterable<String> codigos,
  Set<String> estudiados = const {},
  Set<String> enRepaso = const {},
  Map<String, EstadisticaTema> cantes = const {},
  Map<String, List<DateTime>> vueltas = const {},
  List<ResultadoTest> tests = const [],
  BancoPreguntas? banco,
}) {
  final aciertos = <String, int>{};
  final respuestas = <String, int>{};
  if (banco != null) {
    for (final r in tests) {
      r.respuestas.forEach((id, letra) {
        final p = banco.porId(id);
        if (p == null) return;
        for (final t in p.temas.toSet()) {
          respuestas[t] = (respuestas[t] ?? 0) + 1;
          if (letra != null && p.esCorrecta(letra)) aciertos[t] = (aciertos[t] ?? 0) + 1;
        }
      });
    }
  }
  return {
    for (final c in codigos)
      c: () {
        final e = cantes[c];
        final fechas = [...?vueltas[c], if (e?.ultimo != null) e!.ultimo!];
        return DatosTema(
          estudiado: estudiados.contains(c),
          enRepaso: enRepaso.contains(c),
          valoracion: e?.valoracionMedia ?? 0,
          cantes: e?.veces ?? 0,
          aciertos: aciertos[c] ?? 0,
          respuestas: respuestas[c] ?? 0,
          ultimo: fechas.isEmpty ? null : fechas.reduce((a, b) => a.isAfter(b) ? a : b),
        );
      }(),
  };
}
