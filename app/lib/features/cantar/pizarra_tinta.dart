import 'dart:math';
import 'dart:ui';

import 'pizarra_trazos.dart';

/// Tinta de la pizarra: el contorno relleno de un trazo con grosor variable
/// (la presión del lápiz o la velocidad del dedo), como la tinta de Notas.
///
/// El trazo que se está dibujando y el ya guardado salen de la misma función
/// y en las mismas unidades (las del lienzo): al levantar el lápiz no cambia.

/// Contorno de un trazo que pasa por [puntos] con el [anchos] de cada punto.
/// La línea se alisa (Catmull-Rom) y se parte en las esquinas cerradas, con
/// remates redondos; todos los trozos giran en el mismo sentido, así que se
/// rellenan juntos sin huecos donde se cruzan.
Path caminoTinta(List<Offset> puntos, List<double> anchos) {
  final camino = Path();
  for (final c in contornosTinta(puntos, anchos)) {
    camino.addPolygon(c, true);
  }
  return camino;
}

/// Los polígonos cerrados que forman la tinta (para pintarlos o llevarlos a
/// un PDF como vectores).
List<List<Offset>> contornosTinta(List<Offset> puntos, List<double> anchos) {
  final camino = <List<Offset>>[];
  if (puntos.isEmpty) return camino;
  if (puntos.length == 1 || _todosJuntos(puntos)) {
    camino.add(_circulo(puntos.first, anchos.reduce(max) / 2));
    return camino;
  }
  // Se parte donde el trazo da la vuelta (más de 75°): cada tramo con sus
  // remates, y la unión queda redonda. Se mira en los puntos de verdad (antes
  // de alisar, que redondearía las esquinas de las formas) y después en la
  // curva alisada (por las vueltas cerradas de la letra).
  var desde = 0;
  for (var i = 1; i < puntos.length - 1; i++) {
    if (_esquina(puntos[i - 1], puntos[i], puntos[i + 1])) {
      _tramoAlisado(camino, puntos.sublist(desde, i + 1), anchos.sublist(desde, i + 1));
      desde = i;
    }
  }
  _tramoAlisado(camino, puntos.sublist(desde), anchos.sublist(desde));
  return camino;
}

bool _esquina(Offset a, Offset b, Offset c) {
  final u = b - a, v = c - b;
  if (u.distance == 0 || v.distance == 0) return false;
  return (u.dx * v.dx + u.dy * v.dy) / (u.distance * v.distance) < 0.26;
}

void _tramoAlisado(List<List<Offset>> camino, List<Offset> puntos, List<double> anchos) {
  final (q, w) = _alisar(puntos, anchos);
  var desde = 0;
  for (var i = 1; i < q.length - 1; i++) {
    if (_esquina(q[i - 1], q[i], q[i + 1])) {
      _tramo(camino, q.sublist(desde, i + 1), w.sublist(desde, i + 1));
      desde = i;
    }
  }
  _tramo(camino, q.sublist(desde), w.sublist(desde));
}

bool _todosJuntos(List<Offset> q) => q.every((p) => (p - q.first).distance < 0.3);

/// Contorno cerrado de un tramo sin esquinas: un lado hacia delante, el
/// remate final, el otro lado hacia atrás y el remate inicial.
void _tramo(List<List<Offset>> camino, List<Offset> q, List<double> w) {
  // Sin puntos repetidos (no tienen dirección).
  final pts = <Offset>[q.first];
  final anchos = <double>[w.first];
  for (var i = 1; i < q.length; i++) {
    if ((q[i] - pts.last).distance < 0.05) continue;
    pts.add(q[i]);
    anchos.add(w[i]);
  }
  if (pts.length == 1) {
    camino.add(_circulo(pts.first, anchos.first / 2));
    return;
  }
  final izq = <Offset>[], der = <Offset>[];
  for (var i = 0; i < pts.length; i++) {
    final antes = pts[max(i - 1, 0)], despues = pts[min(i + 1, pts.length - 1)];
    var d = despues - antes;
    d = d / d.distance;
    final normal = Offset(-d.dy, d.dx) * (anchos[i] / 2);
    izq.add(pts[i] + normal);
    der.add(pts[i] - normal);
  }
  final contorno = <Offset>[
    ...izq,
    ..._mediaVuelta(pts.last, izq.last, anchos.last / 2),
    ...der.reversed,
    ..._mediaVuelta(pts.first, der.first, anchos.first / 2),
  ];
  camino.add(contorno);
}

/// Media circunferencia alrededor de [centro] desde [desde] (sin incluirlo),
/// por delante del trazo y en el mismo sentido de giro que el contorno (el
/// ángulo baja).
List<Offset> _mediaVuelta(Offset centro, Offset desde, double r) {
  final a0 = atan2(desde.dy - centro.dy, desde.dx - centro.dx);
  const n = 8;
  return [for (var k = 1; k < n; k++) centro + Offset(cos(a0 - pi * k / n), sin(a0 - pi * k / n)) * r];
}

/// Un punto: círculo con el mismo sentido de giro que los contornos.
List<Offset> _circulo(Offset c, double r) {
  final n = (r * 2).clamp(8, 24).round();
  return [for (var k = 0; k < n; k++) c + Offset(cos(-2 * pi * k / n), sin(-2 * pi * k / n)) * max(r, 0.5)];
}

/// Curva Catmull-Rom por los puntos (un punto cada ~2 unidades), con el ancho
/// repartido entre ellos. Los tramos largos (rectas de las formas, que llegan
/// con pocos puntos) van rectos: la curva se saldría de ellos.
(List<Offset>, List<double>) _alisar(List<Offset> p, List<double> w) {
  if (p.length < 3) return (List.of(p), List.of(w));
  final q = <Offset>[p.first];
  final a = <double>[w.first];
  for (var i = 0; i < p.length - 1; i++) {
    final p0 = p[max(i - 1, 0)], p1 = p[i], p2 = p[i + 1], p3 = p[min(i + 2, p.length - 1)];
    final pasos = ((p2 - p1).distance / 2).ceil().clamp(1, 16);
    final recto = (p2 - p1).distance > 24;
    for (var k = 1; k <= pasos; k++) {
      final t = k / pasos, t2 = t * t, t3 = t2 * t;
      if (recto) {
        q.add(Offset.lerp(p1, p2, t)!);
        a.add(w[i] + (w[i + 1] - w[i]) * t);
        continue;
      }
      q.add((p1 * 2 + (p2 - p0) * t + (p0 * 2 - p1 * 5 + p2 * 4 - p3) * t2 + (p1 * 3 - p0 - p2 * 3 + p3) * t3) * 0.5);
      a.add(w[i] + (w[i + 1] - w[i]) * t);
    }
  }
  return (q, a);
}

/// Contorno de un trazo guardado, en unidades del lienzo.
Path caminoDeTrazo(Trazo t) {
  final camino = Path();
  for (final c in contornosDeTrazo(t)) {
    camino.addPolygon(c, true);
  }
  return camino;
}

/// Los polígonos de un trazo guardado, en unidades del lienzo (un texto no
/// tiene tinta: se pinta aparte).
List<List<Offset>> contornosDeTrazo(Trazo t) => t.esTexto
    ? const []
    : contornosTinta(
      _sinRedondeo([for (final p in t.puntos) Offset(p.x.toDouble(), p.y.toDouble())]),
      [for (var i = 0; i < t.puntos.length; i++) t.grosor * (t.presiones == null ? 1.0 : factorDeDigito(t.presiones![i]))],
    );

/// Factor de grosor por la presión del lápiz (0,4 a 1,3).
double factorPresion(double presion, double minima, double maxima) {
  final rango = maxima - minima;
  final p = rango > 0 ? ((presion - minima) / rango).clamp(0.0, 1.0) : 0.5;
  return 0.4 + 0.9 * p;
}

/// Sin presión (dedo, ratón), el grosor según la velocidad en píxeles por
/// milisegundo: más deprisa, más fino.
double factorVelocidad(double velocidad) => (1.15 - 0.22 * velocidad).clamp(0.6, 1.15);

/// Los puntos se guardan redondeados a la unidad: cada punto vuelve hacia la
/// media de sus vecinos, pero como mucho media unidad (lo que pudo moverlo el
/// redondeo). Quita las muescas de un círculo sin tocar la forma de la letra.
List<Offset> _sinRedondeo(List<Offset> p) {
  if (p.length < 3) return p;
  return [
    p.first,
    for (var i = 1; i < p.length - 1; i++)
      if (_esquina(p[i - 1], p[i], p[i + 1]))
        p[i]
      else
        Offset(
          p[i].dx + ((p[i - 1].dx + 2 * p[i].dx + p[i + 1].dx) / 4 - p[i].dx).clamp(-0.5, 0.5),
          p[i].dy + ((p[i - 1].dy + 2 * p[i].dy + p[i + 1].dy) / 4 - p[i].dy).clamp(-0.5, 0.5),
        ),
    p.last,
  ];
}
