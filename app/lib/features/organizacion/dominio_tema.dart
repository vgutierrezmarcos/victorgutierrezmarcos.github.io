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
  repaso('Repaso');

  const LenteMapa(this.nombre);
  final String nombre;
}

/// Días para que un repaso «se enfríe» a la mitad.
const _vidaMedia = 30;

/// Lo fresco que está un tema (1 = hoy; 0,5 a los 30 días).
double frescura(DateTime ultimo, DateTime ahora) => pow(0.5, max(0, ahora.difference(ultimo).inHours / 24) / _vidaMedia).toDouble();

/// Valor de 0 a 1 de un tema con la [lente], o null si no hay datos.
///
/// El dominio pondera lo que haya: los cantes (40 %), el test (20 %), si está
/// estudiado (20 %) y lo reciente del último repaso o cante (20 %). Un tema
/// sin estudiar y sin nada más queda sin dato (gris).
double? valorTema(DatosTema d, LenteMapa lente, DateTime ahora) {
  switch (lente) {
    case LenteMapa.cantes:
      return d.valoracion > 0 ? (d.valoracion - 1) / 4 : null;
    case LenteMapa.test:
      return d.conTest ? d.acierto : null;
    case LenteMapa.repaso:
      return d.ultimo == null ? null : frescura(d.ultimo!, ahora);
    case LenteMapa.dominio:
      if (!d.estudiado && d.valoracion == 0 && !d.conTest && d.ultimo == null) return null;
      var suma = 0.2 * (d.estudiado ? 1 : 0);
      var pesos = 0.2;
      if (d.valoracion > 0) {
        suma += 0.4 * (d.valoracion - 1) / 4;
        pesos += 0.4;
      }
      if (d.conTest) {
        suma += 0.2 * d.acierto;
        pesos += 0.2;
      }
      if (d.ultimo != null) {
        suma += 0.2 * frescura(d.ultimo!, ahora);
        pesos += 0.2;
      }
      return suma / pesos;
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
