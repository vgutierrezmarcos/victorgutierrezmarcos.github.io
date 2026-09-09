/// Artículo del blog (a partir de rss.xml).
class Articulo {
  const Articulo({
    required this.titulo,
    required this.url,
    required this.descripcion,
    required this.fecha,
    required this.guid,
  });
  final String titulo;
  final String url;
  final String descripcion;
  final DateTime? fecha;
  final String guid;

  String get urlPdf => url.replaceAll(RegExp(r'\.html$'), '.pdf');
}
