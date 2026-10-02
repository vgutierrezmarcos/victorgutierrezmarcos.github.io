import '../../core/cache_http.dart';
import '../../core/constants.dart';
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

  /// Refresco silencioso de todo el contenido (al arrancar con red).
  Future<void> refrescarTodo() async {
    for (final u in [Urls.preguntas, Urls.bloques, Urls.temario, Urls.enlaces]) {
      await _http.refrescar(u);
    }
  }
}
