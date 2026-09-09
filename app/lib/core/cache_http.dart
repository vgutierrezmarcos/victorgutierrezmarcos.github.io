import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';

/// Descarga JSON/XML de la web con caché persistente (Hive) y revalidación
/// por ETag / Last-Modified. Estrategia "stale-while-revalidate": devuelve
/// la copia en caché al instante y actualiza en segundo plano.
class CacheHttp {
  CacheHttp(this._dio, this._caja);

  final Dio _dio;
  final Box _caja;

  static Future<CacheHttp> crear() async {
    final caja = await Hive.openBox(Cajas.cacheHttp);
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'User-Agent': 'TCEE-App/1.0 (+https://www.victorgutierrezmarcos.es)'},
    ));
    return CacheHttp(dio, caja);
  }

  String? textoEnCache(String url) => _caja.get('$url#body') as String?;

  bool tieneCache(String url) => _caja.containsKey('$url#body');

  DateTime? fechaCache(String url) {
    final ms = _caja.get('$url#ts') as int?;
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  /// Obtiene el texto del recurso. Si [preferirCache] y hay copia, la
  /// devuelve sin red. Si no hay red y hay copia, devuelve la copia.
  Future<String> texto(String url, {bool preferirCache = false, bool forzar = false}) async {
    final cacheado = textoEnCache(url);
    if (preferirCache && cacheado != null && !forzar) return cacheado;

    final headers = <String, String>{};
    final etag = _caja.get('$url#etag') as String?;
    final lastMod = _caja.get('$url#lastmod') as String?;
    if (!forzar && cacheado != null) {
      if (etag != null) headers['If-None-Match'] = etag;
      if (lastMod != null) headers['If-Modified-Since'] = lastMod;
    }

    try {
      final resp = await _dio.get<String>(
        url,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
          validateStatus: (s) => s != null && (s == 304 || (s >= 200 && s < 300)),
        ),
      );
      if (resp.statusCode == 304 && cacheado != null) {
        await _caja.put('$url#ts', DateTime.now().millisecondsSinceEpoch);
        return cacheado;
      }
      final cuerpo = resp.data ?? '';
      await _caja.putAll({
        '$url#body': cuerpo,
        '$url#etag': resp.headers.value('etag'),
        '$url#lastmod': resp.headers.value('last-modified'),
        '$url#ts': DateTime.now().millisecondsSinceEpoch,
      });
      return cuerpo;
    } on DioException {
      if (cacheado != null) return cacheado;
      rethrow;
    }
  }

  Future<Map<String, dynamic>> json(String url, {bool preferirCache = false, bool forzar = false}) async {
    final t = await texto(url, preferirCache: preferirCache, forzar: forzar);
    return jsonDecode(t) as Map<String, dynamic>;
  }

  /// Refresca en segundo plano sin bloquear (ignora errores).
  Future<void> refrescar(String url) async {
    try {
      await texto(url);
    } catch (_) {}
  }

  Future<void> limpiar() => _caja.clear();
}
