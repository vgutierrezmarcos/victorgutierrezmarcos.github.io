import 'dart:math';

/// Pizarra compartida: los trazos y cómo se guardan (sin Flutter ni
/// Firestore, para poder probarlo).
///
/// El lienzo es virtual y fijo (apaisado, 16:10): cada dispositivo lo escala
/// a su pantalla. Los puntos van en un texto compacto: el primero absoluto y
/// el resto como diferencias («812,420 3,-2 5,0…»), 4-6 bytes por punto.

const anchoLienzo = 1600;
const altoLienzo = 1000;

/// Grosores del bolígrafo, en unidades del lienzo.
const grosores = [3, 6, 12];

/// Herramientas que pintan. El bolígrafo (`b`) es la de siempre (y la de los
/// trazos antiguos, sin herramienta); el rotulador (`r`) es más grueso y sin
/// presión, y el fosforito (`f`), ancho y translúcido para subrayar.
const herramientaBoligrafo = 'b';
const herramientaRotulador = 'r';
const herramientaFosforito = 'f';

/// Grosores de cada herramienta (fino, medio y grueso).
const grosoresHerramienta = {
  herramientaBoligrafo: grosores,
  herramientaRotulador: [8, 14, 22],
  herramientaFosforito: [18, 28, 40],
};

/// Opacidad del fosforito (va en el alfa del color, así las versiones
/// anteriores de la app también lo pintan translúcido).
const alfaFosforito = 0x66;

/// Papel de una página: en blanco, rayado o cuadriculado (lo ven los dos).
const fondoBlanco = 'blanco';
const fondoRayas = 'rayas';
const fondoCuadricula = 'cuadricula';

/// Separación de las rayas y de la cuadrícula, en unidades del lienzo.
const pasoFondo = 40;

/// La presión (o, con el dedo y el ratón, la velocidad) se guarda por punto
/// como un dígito 0-9 que multiplica el grosor: 0,4 (muy suave) a 1,3.
double factorDeDigito(int d) => 0.4 + 0.1 * d.clamp(0, 9);
int digitoDeFactor(double f) => ((f - 0.4) / 0.1).round().clamp(0, 9);

/// Colores que se pueden elegir (ARGB). Los dos primeros son los de cada
/// papel por defecto (alumno y preparador).
const coloresPizarra = [0xFF2E7D9A, 0xFFC0662B, 0xFF1F1F1F, 0xFF5F2987, 0xFF2E7D32, 0xFFC62828];

/// Los cuatro colores a un toque: azul, negro, rojo y verde. Por defecto, el
/// alumno escribe en azul y el preparador en rojo; cualquier otro color se
/// elige con la paleta. Cada trazo guarda su color, así el otro lo ve igual.
const coloresRapidos = [0xFF1E5AA8, 0xFF1F1F1F, 0xFFC62828, 0xFF2E7D32];
const nombresColoresRapidos = ['Azul', 'Negro', 'Rojo', 'Verde'];

/// Páginas como mucho por clase.
const maxPaginas = 10;

/// A partir de este tamaño (aproximado) una página no admite más trazos: el
/// documento de Firestore no puede pasar de 1 MiB.
const bytesMaxPagina = 700 * 1024;

/// Un trazo de alguien ([de], su uid) con un [grosor] y sus [puntos].
class Trazo {
  const Trazo({required this.id, required this.de, required this.grosor, required this.puntos, this.color, this.presiones, this.herramienta, this.crudo});

  final String id;
  final String de;
  final int grosor;
  final List<Point<int>> puntos;

  /// Un dígito 0-9 por punto (ver [factorDeDigito]); null = grosor fijo (los
  /// trazos antiguos, el rotulador, el fosforito y las formas).
  final List<int>? presiones;

  /// [herramientaBoligrafo], [herramientaRotulador] o [herramientaFosforito];
  /// null = bolígrafo.
  final String? herramienta;

  bool get esFosforito => herramienta == herramientaFosforito;

  /// El mismo trazo con otro id, movido [dx], [dy] o con otro [color].
  Trazo copia({required String id, int dx = 0, int dy = 0, int? color, List<Point<int>>? puntos, List<int>? presiones}) => Trazo(
        id: id,
        de: de,
        grosor: grosor,
        color: color ?? this.color,
        herramienta: herramienta,
        presiones: puntos != null ? presiones : this.presiones,
        puntos: [for (final p in puntos ?? this.puntos) Point(p.x + dx, p.y + dy)],
      );

  /// Color ARGB elegido; null = el color del papel de quien lo pintó.
  final int? color;

  /// Si el trazo pasa a menos de [radio] (en unidades del lienzo) del punto.
  bool cerca(Point<double> p, double radio) {
    final r = radio + grosor / 2;
    Point<double> d(Point<int> q) => Point(q.x.toDouble(), q.y.toDouble());
    if (puntos.length == 1) return p.distanceTo(d(puntos.first)) <= r;
    for (var i = 0; i < puntos.length - 1; i++) {
      if (_distanciaASegmento(p, d(puntos[i]), d(puntos[i + 1])) <= r) return true;
    }
    return false;
  }

  /// El elemento tal como vino de Firestore: para quitarlo (arrayRemove) hace
  /// falta exactamente el mismo mapa.
  final Map<String, dynamic>? crudo;

  Map<String, dynamic> toJson() => {
        'i': id,
        'u': de,
        'g': grosor,
        'p': codificarPuntos(puntos),
        if (color != null) 'c': color,
        if (presiones != null && presiones!.length == puntos.length) 'w': presiones!.join(),
        if (herramienta != null && herramienta != herramientaBoligrafo) 'h': herramienta,
      };

  factory Trazo.fromJson(Map<dynamic, dynamic> j) {
    final puntos = decodificarPuntos(j['p']?.toString() ?? '');
    final w = j['w']?.toString();
    final presiones = w == null || w.length != puntos.length ? null : [for (final c in w.codeUnits) (c - 48).clamp(0, 9)];
    return Trazo(
      id: j['i']?.toString() ?? '',
      de: j['u']?.toString() ?? '',
      grosor: (j['g'] as num?)?.toInt() ?? grosores[1],
      puntos: puntos,
      color: (j['c'] as num?)?.toInt(),
      presiones: presiones,
      herramienta: j['h']?.toString(),
      crudo: Map<String, dynamic>.from(j),
    );
  }

  /// El rectángulo que lo contiene (sin el grosor).
  Rectangle<int> get caja {
    if (puntos.isEmpty) return const Rectangle(0, 0, 0, 0);
    var x0 = puntos.first.x, x1 = x0, y0 = puntos.first.y, y1 = y0;
    for (final p in puntos) {
      x0 = min(x0, p.x);
      x1 = max(x1, p.x);
      y0 = min(y0, p.y);
      y1 = max(y1, p.y);
    }
    return Rectangle(x0, y0, x1 - x0, y1 - y0);
  }

  /// Bytes aproximados que ocupa guardado.
  int get bytesAprox => 40 + (crudo?['p']?.toString().length ?? codificarPuntos(puntos).length);
}

/// Una página de la pizarra (documento pizarra/{id}).
class PaginaPizarra {
  const PaginaPizarra({required this.id, required this.n, required this.trazos, this.borradoPor, this.fondo = fondoBlanco});

  final String id;
  final int n;
  final List<Trazo> trazos;

  /// Quién la borró entera la última vez (null si nunca).
  final String? borradoPor;

  /// [fondoBlanco], [fondoRayas] o [fondoCuadricula].
  final String fondo;

  int get bytesAprox => trazos.fold(0, (s, t) => s + t.bytesAprox);
  bool get llena => bytesAprox >= bytesMaxPagina;

  factory PaginaPizarra.fromJson(String id, Map<dynamic, dynamic> j) => PaginaPizarra(
        id: id,
        n: (j['n'] as num?)?.toInt() ?? int.tryParse(id.replaceFirst('p', '')) ?? 1,
        trazos: [for (final t in (j['trazos'] as List?) ?? const []) if (t is Map) Trazo.fromJson(t)],
        borradoPor: j['borradoPor'] as String?,
        fondo: j['fondo']?.toString() ?? fondoBlanco,
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
  final quedan = indicesSimplificados(puntos, tolerancia: tolerancia);
  return [for (final i in quedan) puntos[i]];
}

/// Los índices de los puntos que deja [simplificar] (para quedarse también con
/// la presión de cada uno).
List<int> indicesSimplificados(List<Point<double>> puntos, {double tolerancia = 1.5}) {
  if (puntos.length < 3) return [for (var i = 0; i < puntos.length; i++) i];
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
  return [for (var i = 0; i < puntos.length; i++) if (conservar[i]) i];
}

/// Borrador por partes: quita de [t] lo que queda a menos de [radio] de [p] y
/// devuelve los trozos que quedan (con id nuevo), o null si no lo toca. Los
/// tramos largos se rellenan de puntos antes, para poder cortarlos por en medio.
List<Trazo>? trocear(Trazo t, Point<double> p, double radio, {Random? random}) {
  if (!t.cerca(p, radio)) return null;
  final r = radio + t.grosor / 2;
  final puntos = <Point<int>>[];
  final presiones = t.presiones == null ? null : <int>[];
  for (var i = 0; i < t.puntos.length; i++) {
    final a = t.puntos[i];
    puntos.add(a);
    presiones?.add(t.presiones![i]);
    if (i == t.puntos.length - 1) break;
    final b = t.puntos[i + 1];
    final pasos = (a.distanceTo(b) / 3).floor();
    for (var k = 1; k < pasos; k++) {
      puntos.add(Point((a.x + (b.x - a.x) * k / pasos).round(), (a.y + (b.y - a.y) * k / pasos).round()));
      presiones?.add(t.presiones![i]);
    }
  }
  final trozos = <Trazo>[];
  var desde = -1;
  void cerrar(int hasta) {
    if (desde < 0) return;
    // Un trozo de un solo punto que queda de un trazo largo no se ve: fuera.
    if (hasta - desde >= 2 || t.puntos.length == 1) {
      final pts = puntos.sublist(desde, hasta);
      final idx = indicesSimplificados([for (final q in pts) Point(q.x.toDouble(), q.y.toDouble())], tolerancia: 0.5);
      trozos.add(t.copia(id: nuevoIdTrazo(random), puntos: [for (final i in idx) pts[i]], presiones: presiones == null ? null : [for (final i in idx) presiones[desde + i]]));
    }
    desde = -1;
  }

  for (var i = 0; i < puntos.length; i++) {
    final q = puntos[i];
    final dentro = Point(q.x.toDouble(), q.y.toDouble()).distanceTo(p) <= r;
    if (dentro) {
      cerrar(i);
    } else if (desde < 0) {
      desde = i;
    }
  }
  cerrar(puntos.length);
  return trozos;
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
