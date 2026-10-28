import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/cache_http.dart';
import 'package:tcee_app/core/providers.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/repos/contenido_repo.dart';

/// La web responde con lo que haya en [cuerpo] (el mismo JSON para todo).
class _Web implements HttpClientAdapter {
  String cuerpo = '';

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async =>
      ResponseBody.fromString(cuerpo, 200, headers: {Headers.contentTypeHeader: ['application/json']});

  @override
  void close({bool force = false}) {}
}

/// Como la web de DCE vista desde el navegador: una petición con cabeceras
/// condicionales necesita una petición previa CORS que GitHub Pages rechaza
/// (405), así que falla; sin ellas, responde con [cuerpo] y su Last-Modified.
class _WebSinPreflight implements HttpClientAdapter {
  String cuerpo = '';
  int rechazadas = 0;

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final h = options.headers.keys.map((k) => k.toLowerCase());
    if (h.contains('if-modified-since') || h.contains('if-none-match')) {
      rechazadas++;
      throw DioException.connectionError(requestOptions: options, reason: 'CORS preflight 405');
    }
    return ResponseBody.fromString(cuerpo, 200, headers: {
      Headers.contentTypeHeader: ['application/json'],
      'last-modified': ['Tue, 27 Oct 2026 19:28:07 GMT'],
      'etag': ['"abc"'],
    });
  }

  @override
  void close({bool force = false}) {}
}

String _banco(int n) => jsonEncode({
      'examenes': [],
      'temas': {},
      'preguntas': [
        for (var i = 1; i <= n; i++)
          {'id': i, 'examen': 'x', 'numero': i, 'temas': ['3.A.1'], 'enunciado': 'P$i', 'opciones': {'a': '', 'b': '', 'c': '', 'd': ''}, 'respuesta': ['a'], 'oficial': true},
      ],
    });

void main() {
  test('las preguntas nuevas de la web salen sin reiniciar la app', () async {
    Oposiciones.actual = Oposiciones.tcee;
    final web = _Web()..cuerpo = _banco(1);
    final http = CacheHttp(Dio()..httpClientAdapter = web, await Hive.openBox('refresco', bytes: Uint8List(0)));
    final contenido = ContenidoRepo(http, Oposiciones.tcee);
    final c = ProviderContainer(overrides: [contenidoProvider.overrideWithValue(contenido)]);
    addTearDown(c.dispose);
    c.listen(preguntasProvider, (_, __) {});

    expect((await c.read(preguntasProvider.future)).preguntas, hasLength(1));

    // Se publican preguntas nuevas: la copia guardada sigue saliendo hasta el refresco silencioso.
    web.cuerpo = _banco(3);
    expect((await c.read(preguntasProvider.future)).preguntas, hasLength(1));
    await contenido.refrescarTodo();
    expect((await c.read(preguntasProvider.future)).preguntas, hasLength(3));

    // Sin cambios no se vuelve a leer nada.
    final antes = contenido.cambios.value;
    await contenido.refrescarTodo();
    expect(contenido.cambios.value, antes);
  });

  test('en el navegador, el contenido de otro dominio se actualiza (sin petición previa CORS)', () async {
    final web = _WebSinPreflight()..cuerpo = _banco(1);
    final caja = await Hive.openBox('refresco-navegador', bytes: Uint8List(0));
    final url = '${Oposiciones.dce.web}/oposicion/temario/temario.json';

    // Como antes del arreglo: con cabeceras condicionales se quedaba con la primera copia.
    final antes = CacheHttp(Dio()..httpClientAdapter = web, caja, condicional: true);
    await antes.texto(url);
    web.cuerpo = _banco(3);
    expect(await antes.refrescar(url), isFalse);
    expect(web.rechazadas, 1);

    // Como en el navegador ahora: sin ellas, trae la versión nueva.
    final navegador = CacheHttp(Dio()..httpClientAdapter = web, caja, condicional: false);
    expect(await navegador.refrescar(url), isTrue);
    expect(navegador.textoEnCache(url), _banco(3));
    expect(web.rechazadas, 1);
  });
}
