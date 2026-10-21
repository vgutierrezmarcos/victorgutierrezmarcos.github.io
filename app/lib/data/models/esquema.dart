/// Esquema de un tema: los marcadores de su PDF (título, nivel y página),
/// para verlo al lado del tema y saltar de bloque. Lo genera
/// `scripts/esquemas-temario.py` (oposicion/temario/esquemas.json, por nombre
/// de fichero del PDF); en los temas revisados viene en el manifiesto.
class EntradaEsquema {
  const EntradaEsquema({required this.nivel, required this.titulo, required this.pagina});

  /// 0 = capítulo; 1, 2, 3 = apartados cada vez más hondos.
  final int nivel;
  final String titulo;

  /// Página del PDF (desde 1).
  final int pagina;

  /// `[nivel, título, página]`; lo que no se entiende se ignora.
  static EntradaEsquema? deJson(Object? j) {
    if (j is! List || j.length < 3) return null;
    final nivel = j[0], titulo = j[1], pagina = j[2];
    if (nivel is! num || titulo is! String || pagina is! num || titulo.trim().isEmpty || pagina < 1) return null;
    return EntradaEsquema(nivel: nivel.toInt().clamp(0, 6), titulo: titulo.trim(), pagina: pagina.toInt());
  }

  /// Una lista de entradas (vacía si el JSON no vale).
  static List<EntradaEsquema> listaDeJson(Object? j) => j is! List ? const [] : [for (final e in j) if (deJson(e) case final x?) x];
}

/// Los esquemas de todos los PDF del temario, por nombre de fichero.
class Esquemas {
  const Esquemas(this.porFichero);
  final Map<String, List<EntradaEsquema>> porFichero;

  static const vacio = Esquemas({});

  factory Esquemas.fromJson(Object? j) {
    if (j is! Map) return vacio;
    return Esquemas({
      for (final e in j.entries)
        if (e.key is String && EntradaEsquema.listaDeJson(e.value).isNotEmpty) e.key as String: EntradaEsquema.listaDeJson(e.value),
    });
  }

  /// El esquema del PDF de [url] (por su nombre de fichero), o null.
  List<EntradaEsquema>? de(String? url) {
    if (url == null) return null;
    final nombre = Uri.tryParse(url)?.pathSegments.lastOrNull ?? url.split('/').last;
    final e = porFichero[nombre];
    return e == null || e.isEmpty ? null : e;
  }
}

/// La entrada del esquema en la que cae la página [pagina] (la última que
/// empieza en ella o antes), o -1.
int entradaEnPagina(List<EntradaEsquema> esquema, int pagina) {
  var i = -1;
  for (var k = 0; k < esquema.length; k++) {
    if (esquema[k].pagina <= pagina) i = k;
  }
  return i;
}
