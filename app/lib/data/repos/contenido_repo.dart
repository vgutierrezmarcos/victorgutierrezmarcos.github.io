import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

import '../../core/cache_http.dart';
import '../../core/constants.dart';
import '../models/articulo.dart';
import '../models/pregunta.dart';
import '../models/temario.dart';

/// Acceso al contenido publicado en la web (con caché offline).
class ContenidoRepo {
  ContenidoRepo(this._http);
  final CacheHttp _http;

  Future<BancoPreguntas> preguntas({bool forzar = false}) async =>
      BancoPreguntas.fromJson(await _http.json(Urls.preguntas, preferirCache: !forzar, forzar: forzar));

  Future<Bloques> bloques({bool forzar = false}) async {
    try {
      return Bloques.fromJson(await _http.json(Urls.bloques, preferirCache: !forzar, forzar: forzar));
    } catch (_) {
      return Bloques.vacio;
    }
  }

  Future<Temario> temario({bool forzar = false}) async =>
      Temario.fromJson(await _http.json(Urls.temario, preferirCache: !forzar, forzar: forzar));

  Future<List<CategoriaEnlaces>> enlaces({bool forzar = false}) async =>
      CategoriaEnlaces.listaFromJson(await _http.json(Urls.enlaces, preferirCache: !forzar, forzar: forzar));

  Future<AppConfig> config() async {
    try {
      // La configuración remota se revalida siempre que hay red.
      return AppConfig.fromJson(await _http.json(Urls.appConfig));
    } catch (_) {
      return AppConfig.porDefecto;
    }
  }

  Future<List<Articulo>> articulos({bool forzar = false}) async {
    final xml = await _http.texto(Urls.rss, preferirCache: !forzar, forzar: forzar);
    final doc = XmlDocument.parse(xml);
    final vistos = <String>{};
    final out = <Articulo>[];
    for (final it in doc.findAllElements('item')) {
      String campo(String n) => it.getElement(n)?.innerText.trim() ?? '';
      final link = campo('link');
      final guid = campo('guid').isEmpty ? link : campo('guid');
      if (link.isEmpty || !vistos.add(guid)) continue; // el RSS de la web repite items
      out.add(Articulo(
        titulo: campo('title'),
        url: link,
        descripcion: campo('description'),
        fecha: _fechaRfc822(campo('pubDate')),
        guid: guid,
      ));
    }
    out.sort((a, b) => (b.fecha ?? DateTime(0)).compareTo(a.fecha ?? DateTime(0)));
    return out;
  }

  static DateTime? _fechaRfc822(String s) {
    if (s.isEmpty) return null;
    try {
      return DateFormat('EEE, dd MMM yyyy HH:mm:ss', 'en_US').parseUtc(s.replaceAll(RegExp(r'\s[+-]\d{4}$|\sGMT$|\sUTC$'), ''));
    } catch (_) {
      return DateTime.tryParse(s);
    }
  }

  /// Refresco silencioso de todo el contenido (al arrancar con red).
  Future<void> refrescarTodo() async {
    for (final u in [Urls.preguntas, Urls.bloques, Urls.temario, Urls.enlaces, Urls.rss]) {
      await _http.refrescar(u);
    }
  }
}
