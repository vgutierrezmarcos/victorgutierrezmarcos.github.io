import '../../core/cache_http.dart';
import '../models/estructura.dart';
import '../models/oposicion.dart';
import '../models/pregunta.dart';
import '../models/temario.dart';

/// Acceso al contenido que publica la web de una oposición (con caché offline).
class ContenidoRepo {
  ContenidoRepo(this._http, this.oposicion);
  final CacheHttp _http;
  final Oposicion oposicion;

  Future<BancoPreguntas> preguntas({bool forzar = false}) async =>
      BancoPreguntas.fromJson(await _http.json(oposicion.urlPreguntas, preferirCache: !forzar, forzar: forzar));

  Future<Bloques> bloques({bool forzar = false}) async {
    try {
      return Bloques.fromJson(await _http.json(oposicion.urlBloques, preferirCache: !forzar, forzar: forzar));
    } catch (_) {
      return Bloques.vacio;
    }
  }

  Future<Temario> temario({bool forzar = false}) async =>
      Temario.fromJson(await _http.json(oposicion.urlTemario, preferirCache: !forzar, forzar: forzar));

  Future<List<CategoriaEnlaces>> enlaces({bool forzar = false}) async =>
      CategoriaEnlaces.listaFromJson(await _http.json(oposicion.urlEnlaces, preferirCache: !forzar, forzar: forzar));

  /// Organización del temario. Si aún no se ha podido descargar, se devuelve
  /// vacía: la app funciona igual, sin colores de bloque ni esquemas.
  Future<EstructuraTemario> estructura({bool forzar = false}) async {
    try {
      return EstructuraTemario.fromJson(await _http.json(oposicion.urlEstructura, preferirCache: !forzar, forzar: forzar));
    } catch (_) {
      return EstructuraTemario.vacia;
    }
  }

  Future<AppConfig> config() async {
    try {
      // La configuración remota se revalida siempre que hay red.
      return AppConfig.fromJson(await _http.json(oposicion.urlAppConfig));
    } catch (_) {
      return AppConfig.porDefecto;
    }
  }

  /// Refresco silencioso de todo el contenido (al arrancar con red).
  Future<void> refrescarTodo() async {
    for (final u in [oposicion.urlPreguntas, oposicion.urlBloques, oposicion.urlTemario, oposicion.urlEnlaces, oposicion.urlEstructura]) {
      await _http.refrescar(u);
    }
  }
}
