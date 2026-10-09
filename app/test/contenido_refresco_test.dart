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
}
