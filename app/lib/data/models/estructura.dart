import 'dart:ui';

/// Organización del temario (estructura_temario.json), extraída del
/// PowerPoint de organización con scripts/extraer-estructura-temario.py:
/// bloques con su color, idea clave de cada tema y los esquemas con las
/// conexiones entre temas y bloques.

Color _color(String? hex) => hex == null || hex.length != 6 ? const Color(0xFF9E9E9E) : Color(0xFF000000 | int.parse(hex, radix: 16));

Rect _rect(List<dynamic> r) => Rect.fromLTWH((r[0] as num).toDouble(), (r[1] as num).toDouble(), (r[2] as num).toDouble(), (r[3] as num).toDouble());

/// Bloque temático con el color que tiene en el PowerPoint.
class BloqueTemario {
  const BloqueTemario({required this.id, required this.nombre, required this.ejercicio, required this.categoria, required this.color, required this.temas});
  final String id;
  final String nombre;
  final int ejercicio;
  /// Microeconomía, Macroeconomía o Mixto (3.º); nombre de la parte (4.º).
  final String categoria;
  final Color color;
  final List<String> temas;

  factory BloqueTemario.fromJson(Map<String, dynamic> j) => BloqueTemario(
        id: j['id'] as String,
        nombre: j['nombre'] as String,
        ejercicio: (j['ejercicio'] as num).toInt(),
        categoria: j['categoria'] as String? ?? '',
        color: _color(j['color'] as String?),
        temas: (j['temas'] as List).map((e) => e.toString()).toList(),
      );
}

/// Extremo de una conexión: un tema concreto o un bloque entero.
class Extremo {
  const Extremo.tema(String this.tema) : bloque = null;
  const Extremo.bloque(String this.bloque) : tema = null;
  final String? tema;
  final String? bloque;

  bool get esTema => tema != null;
  String get clave => tema ?? bloque!;

  factory Extremo.fromJson(Map<String, dynamic> j) => j['tema'] != null ? Extremo.tema(j['tema'] as String) : Extremo.bloque(j['bloque'] as String);

  @override
  bool operator ==(Object other) => other is Extremo && other.tema == tema && other.bloque == bloque;
  @override
  int get hashCode => Object.hash(tema, bloque);
}

class Conexion {
  const Conexion({required this.de, required this.a, required this.flechaDe, required this.flechaA, required this.color, required this.discontinua});
  final Extremo de;
  final Extremo a;
  final bool flechaDe;
  final bool flechaA;
  final Color color;
  final bool discontinua;

  bool toca(Extremo e) => de == e || a == e;
  Extremo otro(Extremo e) => de == e ? a : de;

  factory Conexion.fromJson(Map<String, dynamic> j) => Conexion(
        de: Extremo.fromJson(j['de'] as Map<String, dynamic>),
        a: Extremo.fromJson(j['a'] as Map<String, dynamic>),
        flechaDe: j['flechaDe'] as bool? ?? false,
        flechaA: j['flechaA'] as bool? ?? false,
        color: _color(j['color'] as String?),
        discontinua: j['discontinua'] as bool? ?? false,
      );
}

/// Casilla de un tema en un esquema. Coordenadas normalizadas (0-1).
class NodoEsquema {
  const NodoEsquema({required this.tema, required this.rect, this.repetido = false});
  final String tema;
  final Rect rect;
  /// Casilla tramada en el PowerPoint: el tema ya aparece en otro sitio o es de otro ejercicio.
  final bool repetido;
}

class MarcoEsquema {
  const MarcoEsquema({required this.bloque, required this.rect});
  final String bloque;
  final Rect rect;
}

class Esquema {
  const Esquema({required this.id, required this.titulo, required this.nodos, required this.marcos, required this.etiquetas, required this.conexiones});
  final String id;
  final String titulo;
  final List<NodoEsquema> nodos;
  final List<MarcoEsquema> marcos;
  /// Rótulos con el nombre de cada bloque.
  final List<MarcoEsquema> etiquetas;
  final List<Conexion> conexiones;

  factory Esquema.fromJson(Map<String, dynamic> j) => Esquema(
        id: j['id'] as String,
        titulo: j['titulo'] as String,
        nodos: [for (final n in j['nodos'] as List) NodoEsquema(tema: n['tema'] as String, rect: _rect(n['r'] as List), repetido: n['repetido'] as bool? ?? false)],
        marcos: [for (final m in j['marcos'] as List) MarcoEsquema(bloque: m['bloque'] as String, rect: _rect(m['r'] as List))],
        etiquetas: [for (final m in j['etiquetas'] as List) MarcoEsquema(bloque: m['bloque'] as String, rect: _rect(m['r'] as List))],
        conexiones: [for (final c in j['conexiones'] as List) Conexion.fromJson(c as Map<String, dynamic>)],
      );

  /// Zona del esquema que ocupa un extremo: la casilla del tema o el marco del bloque.
  Rect? rectDe(Extremo e) {
    if (e.esTema) {
      NodoEsquema? mejor;
      for (final n in nodos) {
        if (n.tema == e.tema && (mejor == null || (mejor.repetido && !n.repetido))) mejor = n;
      }
      return mejor?.rect;
    }
    // Para un bloque, su rótulo (los marcos pueden contener a otros bloques).
    for (final m in etiquetas) {
      if (m.bloque == e.bloque) return m.rect;
    }
    for (final m in marcos) {
      if (m.bloque == e.bloque) return m.rect;
    }
    return null;
  }
}

class EstructuraTemario {
  EstructuraTemario({required this.proporcion, required this.bloques, required this.ideas, required this.esquemas}) {
    for (final b in bloques) {
      _porId[b.id] = b;
      for (final t in b.temas) {
        _bloqueDeTema[t] = b;
      }
    }
    // Todas las conexiones de todos los esquemas, sin repetir.
    final vistas = <String>{};
    for (final e in esquemas) {
      for (final c in e.conexiones) {
        final claves = [c.de.clave, c.a.clave]..sort();
        if (vistas.add(claves.join('|'))) _conexiones.add(c);
      }
    }
  }

  /// Ancho / alto de las diapositivas.
  final double proporcion;
  final List<BloqueTemario> bloques;
  /// Idea clave de cada tema (texto que lo acompaña en el PowerPoint).
  final Map<String, String> ideas;
  final List<Esquema> esquemas;

  final _porId = <String, BloqueTemario>{};
  final _bloqueDeTema = <String, BloqueTemario>{};
  final _conexiones = <Conexion>[];

  static final vacia = EstructuraTemario(proporcion: 16 / 9, bloques: const [], ideas: const {}, esquemas: const []);

  factory EstructuraTemario.fromJson(Map<String, dynamic> j) => EstructuraTemario(
        proporcion: (j['proporcion'] as num?)?.toDouble() ?? 16 / 9,
        bloques: [for (final b in j['bloques'] as List) BloqueTemario.fromJson(b as Map<String, dynamic>)],
        ideas: ((j['ideas'] as Map?) ?? {}).map((k, v) => MapEntry(k.toString(), v.toString())),
        esquemas: [for (final e in j['esquemas'] as List) Esquema.fromJson(e as Map<String, dynamic>)],
      );

  BloqueTemario? bloque(String id) => _porId[id];
  BloqueTemario? bloqueDe(String tema) => _bloqueDeTema[tema];
  Color? colorDe(String tema) => _bloqueDeTema[tema]?.color;

  List<BloqueTemario> deEjercicio(int ejercicio) => bloques.where((b) => b.ejercicio == ejercicio).toList();

  /// Categorías de un ejercicio en el orden del PowerPoint.
  List<String> categorias(int ejercicio) {
    final out = <String>[];
    for (final b in bloques) {
      if (b.ejercicio == ejercicio && !out.contains(b.categoria)) out.add(b.categoria);
    }
    return out;
  }

  /// Conexiones en las que participa un tema, directas o a través de su bloque.
  List<Conexion> conexionesDeTema(String tema) => _conexiones.where((c) => c.toca(Extremo.tema(tema))).toList();

  /// Temas y bloques con los que conecta un tema.
  List<Extremo> relacionados(String tema) {
    final yo = Extremo.tema(tema);
    final out = <Extremo>[];
    for (final c in _conexiones) {
      if (c.toca(yo) && !out.contains(c.otro(yo))) out.add(c.otro(yo));
    }
    return out;
  }

  /// Conexiones de un bloque con el exterior: las de sus temas con temas de
  /// otros bloques y las que llegan al bloque como conjunto.
  List<Conexion> conexionesDeBloque(String id) {
    final b = _porId[id];
    if (b == null) return const [];
    bool dentro(Extremo e) => e.esTema ? b.temas.contains(e.tema) : e.bloque == id;
    return _conexiones.where((c) => dentro(c.de) != dentro(c.a)).toList();
  }

  /// Temas aún no estudiados que conectan con alguno ya estudiado: por dónde
  /// seguir aprovechando lo que ya se sabe. Ordenados por número de conexiones.
  List<String> sugeridos(Set<String> estudiados, {int? ejercicio}) {
    final puntos = <String, int>{};
    for (final c in _conexiones) {
      if (!c.de.esTema || !c.a.esTema) continue;
      final a = c.de.tema!, b = c.a.tema!;
      if (estudiados.contains(a) && !estudiados.contains(b)) puntos[b] = (puntos[b] ?? 0) + 1;
      if (estudiados.contains(b) && !estudiados.contains(a)) puntos[a] = (puntos[a] ?? 0) + 1;
    }
    final out = puntos.keys.where((t) => ejercicio == null || t.startsWith('$ejercicio.')).toList()
      ..sort((x, y) => puntos[y]!.compareTo(puntos[x]!));
    return out;
  }
}

/// Color del texto que se lee bien sobre un color de bloque (negro o blanco).
Color textoSobre(Color fondo) => fondo.computeLuminance() > 0.42 ? const Color(0xFF1F1F1F) : const Color(0xFFFFFFFF);
