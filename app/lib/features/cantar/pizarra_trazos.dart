import 'dart:math';

/// Pizarra compartida: los trazos y cómo se guardan (sin Flutter ni
/// Firestore, para poder probarlo).
///
/// El lienzo es virtual y fijo (apaisado, 16:10): cada dispositivo lo escala
/// a su pantalla. Los puntos van en un texto compacto: el primero absoluto y
/// el resto como diferencias («812,420 3,-2 5,0…»), 4-6 bytes por punto.

const anchoLienzo = 1600;
const altoLienzo = 1000;

/// Grosores del lápiz, en unidades del lienzo.
const grosores = [3, 6, 12];

/// Páginas como mucho por clase.
const maxPaginas = 10;

/// A partir de este tamaño (aproximado) una página no admite más trazos: el
/// documento de Firestore no puede pasar de 1 MiB.
const bytesMaxPagina = 700 * 1024;

/// Un trazo de alguien ([de], su uid) con un [grosor] y sus [puntos].
class Trazo {
  const Trazo({required this.id, required this.de, required this.grosor, required this.puntos, this.crudo});

  final String id;
  final String de;
  final int grosor;
  final List<Point<int>> puntos;

  /// El elemento tal como vino de Firestore: para quitarlo (arrayRemove) hace
  /// falta exactamente el mismo mapa.
  final Map<String, dynamic>? crudo;

  Map<String, dynamic> toJson() => {'i': id, 'u': de, 'g': grosor, 'p': codificarPuntos(puntos)};

  factory Trazo.fromJson(Map<dynamic, dynamic> j) => Trazo(
        id: j['i']?.toString() ?? '',
        de: j['u']?.toString() ?? '',
        grosor: (j['g'] as num?)?.toInt() ?? grosores[1],
        puntos: decodificarPuntos(j['p']?.toString() ?? ''),
        crudo: Map<String, dynamic>.from(j),
      );

  /// Bytes aproximados que ocupa guardado.
  int get bytesAprox => 40 + (crudo?['p']?.toString().length ?? codificarPuntos(puntos).length);
}

/// Una página de la pizarra (documento pizarra/{id}).
class PaginaPizarra {
  const PaginaPizarra({required this.id, required this.n, required this.trazos, this.borradoPor});

  final String id;
  final int n;
  final List<Trazo> trazos;

  /// Quién la borró entera la última vez (null si nunca).
  final String? borradoPor;

  int get bytesAprox => trazos.fold(0, (s, t) => s + t.bytesAprox);
  bool get llena => bytesAprox >= bytesMaxPagina;

  factory PaginaPizarra.fromJson(String id, Map<dynamic, dynamic> j) => PaginaPizarra(
        id: id,
        n: (j['n'] as num?)?.toInt() ?? int.tryParse(id.replaceFirst('p', '')) ?? 1,
        trazos: [for (final t in (j['trazos'] as List?) ?? const []) if (t is Map) Trazo.fromJson(t)],
        borradoPor: j['borradoPor'] as String?,
      );
}

/// «812,420 3,-2 5,0»: el primer punto y las diferencias con el anterior.
String codificarPuntos(List<Point<int>> puntos) {
  final b = StringBuffer();
  for (var i = 0; i < puntos.length; i++) {
    final p = puntos[i];
    final x = i == 0 ? p.x : p.x - puntos[i - 1].x;
    final y = i == 0 ? p.y : p.y - puntos[i - 1].y;
    if (i > 0) b.write(' ');
    b.write('$x,$y');
  }
  return b.toString();
}

List<Point<int>> decodificarPuntos(String texto) {
  final out = <Point<int>>[];
  var x = 0, y = 0;
  for (final par in texto.split(' ')) {
    final xy = par.split(',');
    if (xy.length != 2) continue;
    final dx = int.tryParse(xy[0]), dy = int.tryParse(xy[1]);
    if (dx == null || dy == null) continue;
    x = out.isEmpty ? dx : x + dx;
    y = out.isEmpty ? dy : y + dy;
    out.add(Point(x, y));
  }
  return out;
}

/// Simplificación de Ramer–Douglas–Peucker (sin recursión): quita los puntos
/// que se desvían menos de [tolerancia] de la recta entre sus vecinos.
List<Point<double>> simplificar(List<Point<double>> puntos, {double tolerancia = 1.5}) {
  if (puntos.length < 3) return List.of(puntos);
  final conservar = List<bool>.filled(puntos.length, false);
  conservar[0] = true;
  conservar[puntos.length - 1] = true;
  final pila = <(int, int)>[(0, puntos.length - 1)];
  while (pila.isNotEmpty) {
    final (a, b) = pila.removeLast();
    var mayor = 0.0;
    var indice = -1;
    for (var i = a + 1; i < b; i++) {
      final d = _distanciaASegmento(puntos[i], puntos[a], puntos[b]);
      if (d > mayor) {
        mayor = d;
        indice = i;
      }
    }
    if (indice >= 0 && mayor > tolerancia) {
      conservar[indice] = true;
      pila.add((a, indice));
      pila.add((indice, b));
    }
  }
  return [for (var i = 0; i < puntos.length; i++) if (conservar[i]) puntos[i]];
}

double _distanciaASegmento(Point<double> p, Point<double> a, Point<double> b) {
  final dx = b.x - a.x, dy = b.y - a.y;
  final l2 = dx * dx + dy * dy;
  if (l2 == 0) return p.distanceTo(a);
  final t = (((p.x - a.x) * dx + (p.y - a.y) * dy) / l2).clamp(0.0, 1.0);
  return p.distanceTo(Point(a.x + t * dx, a.y + t * dy));
}

const _alfabeto = 'abcdefghijklmnopqrstuvwxyz0123456789';

/// Identificador corto de un trazo (único de sobra dentro de una clase).
String nuevoIdTrazo([Random? random]) {
  final r = random ?? Random();
  return [for (var i = 0; i < 7; i++) _alfabeto[r.nextInt(_alfabeto.length)]].join();
}
