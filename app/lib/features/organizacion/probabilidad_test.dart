import 'dart:math';

import '../../data/models/frecuencia_test.dart';

/// Cálculo de la probabilidad de aprobar el test (el mismo que la página
/// oposicion/probabilidad-test.html): cada pregunta es un acierto, un fallo o
/// un blanco, con probabilidades que dependen de lo que se sabe.

/// Baremo y nota para aprobar.
class ReglasTest {
  const ReglasTest({this.preguntas = 50, this.opciones = 4, this.acierto = 1, this.fallo = 0.33, this.blanco = 0, this.notaMinima = 5});
  final int preguntas;
  final int opciones;
  final double acierto;
  final double fallo;
  final double blanco;

  /// Sobre 10.
  final double notaMinima;

  double get maximo => preguntas * acierto;
  double get umbral => notaMinima / 10 * maximo - 1e-9;
  double nota(double puntos) => maximo == 0 ? 0 : 10 * puntos / maximo;

  /// Lo que vale de media responder una pregunta que se acierta con probabilidad [p].
  double valorRespuesta(double p) => p * acierto - (1 - p) * fallo - blanco;

  ReglasTest copyWith({int? preguntas, int? opciones, double? acierto, double? fallo, double? blanco, double? notaMinima}) => ReglasTest(
        preguntas: preguntas ?? this.preguntas,
        opciones: opciones ?? this.opciones,
        acierto: acierto ?? this.acierto,
        fallo: fallo ?? this.fallo,
        blanco: blanco ?? this.blanco,
        notaMinima: notaMinima ?? this.notaMinima,
      );
}

/// Probabilidad de aprobar, nota esperada y distribución de notas (nota, probabilidad).
class Resultado {
  const Resultado(this.aprobar, this.media, this.notas);
  final double aprobar;
  final double media;
  final List<(double, double)> notas;

  /// Nota por debajo de la cual queda la fracción [q] de los intentos.
  double cuantil(double q) {
    final o = [...notas]..sort((a, b) => a.$1.compareTo(b.$1));
    var acum = 0.0;
    for (final (n, p) in o) {
      acum += p;
      if (acum >= q) return n;
    }
    return o.isEmpty ? 0 : o.last.$1;
  }
}

final List<double> _lf = () {
  final l = [0.0];
  for (var i = 1; i <= 400; i++) {
    l.add(l.last + log(i));
  }
  return l;
}();

/// Probabilidades de 0..n éxitos con probabilidad [p].
List<double> binomial(int n, double p) => [
      for (var i = 0; i <= n; i++)
        n == 0
            ? 1.0
            : exp(_lf[n] - _lf[i] - _lf[n - i] + (i == 0 ? 0 : i * log(max(p, 1e-300))) + (n - i == 0 ? 0 : (n - i) * log(max(1 - p, 1e-300)))),
    ];

List<double> _convolucion(List<double> x, List<double> y) {
  final o = List<double>.filled(x.length + y.length - 1, 0);
  for (var i = 0; i < x.length; i++) {
    if (x[i] == 0) continue;
    for (var j = 0; j < y.length; j++) {
      o[i + j] += x[i] * y[j];
    }
  }
  return o;
}

/// Grupos de preguntas de un mismo tipo: [n] preguntas que se aciertan con
/// probabilidad [p] si se responden ([responder]) o se dejan en blanco.
class GrupoPreguntas {
  const GrupoPreguntas(this.n, this.p, {this.responder = true});
  final int n;
  final double p;
  final bool responder;
}

Resultado evaluarGrupos(ReglasTest r, List<GrupoPreguntas> grupos) {
  var pmf = [1.0];
  var respondidas = 0, blancos = 0;
  for (final g in grupos) {
    if (g.n <= 0) continue;
    if (g.responder) {
      pmf = _convolucion(pmf, binomial(g.n, g.p));
      respondidas += g.n;
    } else {
      blancos += g.n;
    }
  }
  var aprobar = 0.0, media = 0.0;
  final notas = <(double, double)>[];
  for (var c = 0; c < pmf.length; c++) {
    final q = pmf[c];
    if (q < 1e-12) continue;
    final puntos = c * r.acierto - (respondidas - c) * r.fallo + blancos * r.blanco;
    if (puntos >= r.umbral) aprobar += q;
    final n = r.nota(puntos);
    media += q * n;
    notas.add((n, q));
  }
  return Resultado(aprobar, media, notas);
}

/// Un test en el que una parte [cobertura] de las preguntas es de lo que se
/// sabe (se acierta con [acierto]) y del resto se responde una parte
/// [alAzar] eligiendo entre [opcionesQueQuedan].
Resultado conCobertura(ReglasTest r, double cobertura, double acierto, double alAzar, int opcionesQueQuedan) {
  final pg = 1 / max(1, opcionesQueQuedan);
  final p1 = cobertura * acierto + (1 - cobertura) * alAzar * pg;
  final p2 = cobertura * (1 - acierto) + (1 - cobertura) * alAzar * (1 - pg);
  final p3 = max(0.0, 1 - p1 - p2);
  final n = r.preguntas;
  var aprobar = 0.0, media = 0.0;
  final notas = <(double, double)>[];
  double lg(double x) => x > 0 ? log(x) : double.negativeInfinity;
  for (var i = 0; i <= n; i++) {
    for (var j = 0; i + j <= n; j++) {
      final k = n - i - j;
      final lp = _lf[n] - _lf[i] - _lf[j] - _lf[k] + (i == 0 ? 0 : i * lg(p1)) + (j == 0 ? 0 : j * lg(p2)) + (k == 0 ? 0 : k * lg(p3));
      if (lp < -40) continue;
      final q = exp(lp), puntos = i * r.acierto - j * r.fallo + k * r.blanco, nota = r.nota(puntos);
      if (puntos >= r.umbral) aprobar += q;
      media += q * nota;
      notas.add((nota, q));
    }
  }
  return Resultado(aprobar, media, notas);
}

/// Lo mismo, mezclando lo que habría pasado en cada examen real (con su peso).
Resultado enExamenesReales(ReglasTest r, FrecuenciaTest f, PesoRecientes peso, Set<String> temas, double acierto, double alAzar, int opcionesQueQuedan) {
  final w = f.pesos(peso), cs = f.coberturas(temas), total = w.fold(0.0, (a, b) => a + b);
  var aprobar = 0.0, media = 0.0;
  final notas = <(double, double)>[];
  for (var i = 0; i < cs.length; i++) {
    final res = conCobertura(r, cs[i], acierto, alAzar, opcionesQueQuedan);
    aprobar += w[i] * res.aprobar / total;
    media += w[i] * res.media / total;
    for (final (n, q) in res.notas) {
      notas.add((n, q * w[i] / total));
    }
  }
  return Resultado(aprobar, media, notas);
}

/// La parte de las preguntas que no se saben que conviene responder al azar
/// (de 0, 25, 50, 75 o 100 %) para aprobar más a menudo.
(double, Resultado) mejorAlAzar(ReglasTest r, FrecuenciaTest f, PesoRecientes peso, Set<String> temas, double acierto, int opcionesQueQuedan) {
  (double, Resultado)? mejor;
  for (final g in const [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final res = enExamenesReales(r, f, peso, temas, acierto, g, opcionesQueQuedan);
    if (mejor == null || res.aprobar > mejor.$2.aprobar + 1e-9) mejor = (g, res);
  }
  return mejor!;
}
