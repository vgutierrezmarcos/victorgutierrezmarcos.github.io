import 'dart:math';

import 'pizarra_trazos.dart';

/// Herramientas de la pizarra que no dependen de Flutter: formas al mantener
/// el lápiz, el lazo y la regla. Todo en unidades del lienzo.

typedef P = Point<double>;

double _largo(List<P> p) {
  var l = 0.0;
  for (var i = 1; i < p.length; i++) {
    l += p[i].distanceTo(p[i - 1]);
  }
  return l;
}

double _distanciaASegmento(P p, P a, P b) {
  final dx = b.x - a.x, dy = b.y - a.y;
  final l2 = dx * dx + dy * dy;
  if (l2 == 0) return p.distanceTo(a);
  final t = (((p.x - a.x) * dx + (p.y - a.y) * dy) / l2).clamp(0.0, 1.0);
  return p.distanceTo(P(a.x + t * dx, a.y + t * dy));
}

/// Endereza [b] respecto a [a] si la recta está a menos de [grados] de la
/// horizontal o la vertical (como en los ejes de un gráfico).
P _enderezar(P a, P b, {double grados = 7}) {
  final ang = ((atan2(b.y - a.y, b.x - a.x) * 180 / pi) % 180 + 180) % 180;
  if (ang < grados || ang > 180 - grados) return P(b.x, a.y);
  if ((ang - 90).abs() < grados) return P(a.x, b.y);
  return b;
}

/// Qué forma limpia corresponde a un trazo hecho a mano (al dejar el lápiz
/// quieto al final, como en Notas): recta, ejes o línea quebrada, triángulo,
/// rectángulo, círculo o elipse, o, si es una curva abierta, la misma curva
/// alisada (para las curvas de los gráficos). Null si es muy pequeño.
List<P>? reconocerForma(List<P> trazo) {
  if (trazo.length < 3) return null;
  final largo = _largo(trazo);
  if (largo < 30) return null;
  final a = trazo.first, b = trazo.last;

  // Recta: nada se aparta mucho de la cuerda.
  final cuerda = a.distanceTo(b);
  var desvio = 0.0;
  for (final p in trazo) {
    desvio = max(desvio, _distanciaASegmento(p, a, b));
  }
  if (cuerda > 20 && desvio < max(4.0, cuerda * 0.06)) return [a, _enderezar(a, b)];

  final cerrada = cuerda < largo * 0.15;
  final xs = trazo.map((p) => p.x), ys = trazo.map((p) => p.y);
  final x0 = xs.reduce(min), x1 = xs.reduce(max), y0 = ys.reduce(min), y1 = ys.reduce(max);
  final diagonal = P(x0, y0).distanceTo(P(x1, y1));
  final vertices = simplificar(trazo, tolerancia: diagonal * 0.07);

  if (cerrada) {
    // Cuánto se aparta de una elipse que llene la caja: un círculo a mano,
    // poco (< 0,09); un cuadrado, mucho (~0,15), y un triángulo, más.
    final cx = (x0 + x1) / 2, cy = (y0 + y1) / 2;
    var rx = (x1 - x0) / 2, ry = (y1 - y0) / 2;
    if (rx < 5 || ry < 5) return null;
    var error = 0.0;
    for (final p in trazo) {
      error += (sqrt(pow((p.x - cx) / rx, 2) + pow((p.y - cy) / ry, 2)) - 1).abs();
    }
    error /= trazo.length;
    List<P> elipse() {
      if ((rx - ry).abs() < max(rx, ry) * 0.12) rx = ry = (rx + ry) / 2;
      const n = 48;
      return [for (var k = 0; k <= n; k++) P(cx + rx * cos(2 * pi * k / n), cy + ry * sin(2 * pi * k / n))];
    }

    if (error < 0.09) return elipse();
    // Sin el último vértice si cierra sobre el primero.
    final v = List.of(vertices);
    if (v.length > 2 && v.last.distanceTo(v.first) < diagonal * 0.2) v.removeLast();
    _quitarAlineados(v, diagonal * 0.07);
    if (v.length == 3) return [...v, v.first];
    if (v.length == 4) {
      // Casi recto: rectángulo con los lados horizontales y verticales.
      if ([for (var i = 0; i < 4; i++) _casiRecto(v[i], v[(i + 1) % 4])].every((r) => r)) return [P(x0, y0), P(x1, y0), P(x1, y1), P(x0, y1), P(x0, y0)];
      return [...v, v.first];
    }
    return error < 0.15 ? elipse() : null;
  }

  // Abierta con pocas esquinas de verdad (el trazo gira de golpe en cada
  // una): ejes en L, ángulo o quebrada, enderezada. En una curva suave el
  // giro se reparte y no hay esquinas.
  final tolerancia = max(4.0, diagonal * 0.035);
  final idx = indicesSimplificados(trazo, tolerancia: tolerancia);
  if (idx.length <= 4 && [for (var k = 1; k < idx.length - 1; k++) _esEsquina(trazo, idx[k - 1], idx[k], idx[k + 1], largo)].every((e) => e)) {
    final out = [trazo[idx.first]];
    for (final i in idx.skip(1)) {
      out.add(_enderezar(out.last, trazo[i]));
    }
    return out;
  }
  // Curva: la misma, alisada.
  return alisarCurva(trazo);
}

/// Ángulo (radianes, 0-π) entre dos direcciones.
double _giro(P u, P v) {
  final c = (u.x * v.x + u.y * v.y) / (u.magnitude * v.magnitude);
  return acos(c.clamp(-1.0, 1.0));
}

/// Si el vértice [k] (entre [a] y [b]) es una esquina: la dirección del trazo
/// justo antes y justo después cambia casi tanto como entre los dos tramos.
bool _esEsquina(List<P> t, int a, int k, int b, double largo) {
  final tramos = _giro(t[k] - t[a], t[b] - t[k]);
  if (tramos < 25 * pi / 180) return false;
  int hasta(int desde, int paso) {
    var l = 0.0, i = desde;
    while (i + paso >= 0 && i + paso < t.length && l < largo * 0.06) {
      l += t[i].distanceTo(t[i + paso]);
      i += paso;
    }
    return i;
  }

  final antes = t[k] - t[hasta(k, -1)], despues = t[hasta(k, 1)] - t[k];
  if (antes.magnitude == 0 || despues.magnitude == 0) return true;
  return _giro(antes, despues) >= tramos * 0.6;
}

bool _casiRecto(P a, P b) {
  final ang = (atan2(b.y - a.y, b.x - a.x) * 180 / pi).abs() % 90;
  return ang < 12 || ang > 78;
}

/// Quita los vértices intermedios que están casi en la recta de sus vecinos.
void _quitarAlineados(List<P> v, double tolerancia) {
  var cambiado = true;
  while (cambiado && v.length > 3) {
    cambiado = false;
    for (var i = 1; i < v.length - 1; i++) {
      if (_distanciaASegmento(v[i], v[i - 1], v[i + 1]) < tolerancia) {
        v.removeAt(i);
        cambiado = true;
        break;
      }
    }
  }
}

/// Media móvil sobre la curva remuestreada cada 6 unidades: quita el temblor
/// de la mano y deja los extremos donde estaban.
List<P> alisarCurva(List<P> trazo) {
  final largo = _largo(trazo);
  final n = max(8, (largo / 6).round());
  // Remuestreo uniforme.
  final r = <P>[trazo.first];
  var acumulado = 0.0, siguiente = largo / n;
  for (var i = 1; i < trazo.length && r.length < n; i++) {
    final a = trazo[i - 1], b = trazo[i];
    final d = a.distanceTo(b);
    while (d > 0 && acumulado + d >= siguiente && r.length < n) {
      final t = (siguiente - acumulado) / d;
      r.add(P(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t));
      siguiente += largo / n;
    }
    acumulado += d;
  }
  r.add(trazo.last);
  var actual = r;
  for (var pasada = 0; pasada < 12; pasada++) {
    actual = [
      actual.first,
      for (var i = 1; i < actual.length - 1; i++) P((actual[i - 1].x + 2 * actual[i].x + actual[i + 1].x) / 4, (actual[i - 1].y + 2 * actual[i].y + actual[i + 1].y) / 4),
      actual.last,
    ];
  }
  return actual;
}

/// Si [p] está dentro del polígono [poligono] (regla par-impar).
bool dentroDePoligono(P p, List<P> poligono) {
  var dentro = false;
  for (var i = 0, j = poligono.length - 1; i < poligono.length; j = i++) {
    final a = poligono[i], b = poligono[j];
    if ((a.y > p.y) != (b.y > p.y) && p.x < (b.x - a.x) * (p.y - a.y) / (b.y - a.y) + a.x) dentro = !dentro;
  }
  return dentro;
}

/// Los trazos que rodea el lazo: los que tienen dentro al menos el 60 % de sus
/// puntos (rellenando los tramos largos, para que una recta cuente entera).
List<Trazo> rodeados(List<Trazo> trazos, List<P> lazo) {
  if (lazo.length < 3) return const [];
  return [
    for (final t in trazos)
      if (_fraccionDentro(t, lazo) >= 0.6) t,
  ];
}

double _fraccionDentro(Trazo t, List<P> lazo) {
  var total = 0, dentro = 0;
  for (var i = 0; i < t.puntos.length; i++) {
    final a = t.puntos[i];
    final b = i + 1 < t.puntos.length ? t.puntos[i + 1] : a;
    final pasos = max(1, (a.distanceTo(b) / 8).ceil());
    for (var k = 0; k < (i + 1 < t.puntos.length ? pasos : 1); k++) {
      final p = P(a.x + (b.x - a.x) * k / pasos, a.y + (b.y - a.y) * k / pasos);
      total++;
      if (dentroDePoligono(p, lazo)) dentro++;
    }
  }
  return total == 0 ? 0 : dentro / total;
}

/// Regla flotante: rectángulo de [largo] × [ancho] centrado en [centro] y
/// girado [angulo] radianes. Los trazos que empiezan junto a uno de sus dos
/// cantos largos se dibujan rectos sobre ese canto.
class Regla {
  const Regla({required this.centro, this.angulo = 0, this.largo = 1300, this.ancho = 90});

  final P centro;
  final double angulo;
  final double largo;
  final double ancho;

  P get direccion => P(cos(angulo), sin(angulo));
  P get normal => P(-sin(angulo), cos(angulo));

  /// Coordenadas de [p] en el sistema de la regla (a lo largo, a lo ancho).
  (double, double) local(P p) {
    final d = p - centro;
    return (d.x * direccion.x + d.y * direccion.y, d.x * normal.x + d.y * normal.y);
  }

  /// Si [p] está sobre la regla (para moverla).
  bool contiene(P p) {
    final (u, v) = local(p);
    return u.abs() <= largo / 2 && v.abs() <= ancho / 2;
  }

  /// El canto (-1 o 1) junto al que empieza un trazo en [p], si está a menos
  /// de [margen] por fuera de él, o null.
  int? cantoJunto(P p, double margen) {
    final (u, v) = local(p);
    if (u.abs() > largo / 2 + margen) return null;
    if (v.abs() >= ancho / 2 - margen / 3 && v.abs() <= ancho / 2 + margen) return v.sign.toInt();
    return null;
  }

  /// [p] llevado al canto [canto], separado [separacion] (medio grosor).
  P sobreCanto(P p, int canto, double separacion) {
    final (u, _) = local(p);
    final v = canto * (ancho / 2 + separacion);
    return P(centro.x + direccion.x * u + normal.x * v, centro.y + direccion.y * u + normal.y * v);
  }

  Regla movida(P delta) => Regla(centro: centro + delta, angulo: angulo, largo: largo, ancho: ancho);

  /// Girada [giro] radianes alrededor de [eje]; se queda en 0°, 45°, 90°…
  /// si pasa a menos de 2°.
  Regla girada(double giro, P eje) {
    var nuevo = angulo + giro;
    final grados = nuevo * 180 / pi;
    final cercano = (grados / 45).round() * 45;
    if ((grados - cercano).abs() < 2) nuevo = cercano * pi / 180;
    final real = nuevo - angulo;
    final d = centro - eje;
    final c = eje + P(d.x * cos(real) - d.y * sin(real), d.x * sin(real) + d.y * cos(real));
    return Regla(centro: c, angulo: nuevo, largo: largo, ancho: ancho);
  }

  /// Grados para enseñar (0-180).
  int get grados => (((angulo * 180 / pi) % 180 + 180) % 180).round() % 180;
}
