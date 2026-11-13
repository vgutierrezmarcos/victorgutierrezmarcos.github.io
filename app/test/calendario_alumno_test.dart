// Google Calendar del opositor: sus cantes y las clases con su preparador van
// a su propio calendario (si lo activa), con el evento aparte del del preparador.
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/repos/calendario_google.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

/// Google Calendar simulado: guarda las peticiones y responde como la API.
class _GoogleFalso implements HttpClientAdapter {
  final peticiones = <({String metodo, String ruta, Map<String, dynamic>? cuerpo})>[];
  final eventos = <String, Map<String, dynamic>>{};
  var siguiente = 1;

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final cuerpo = o.data is Map ? Map<String, dynamic>.from(o.data as Map) : null;
    peticiones.add((metodo: o.method, ruta: o.uri.path, cuerpo: cuerpo));
    ResponseBody json(int codigo, Object? datos) =>
        ResponseBody.fromString(jsonEncode(datos ?? {}), codigo, headers: {Headers.contentTypeHeader: ['application/json']});
    final id = o.uri.pathSegments.last == 'events' ? null : o.uri.pathSegments.last;
    switch (o.method) {
      case 'POST':
        final nuevo = 'ev${siguiente++}';
        eventos[nuevo] = {...?cuerpo, 'id': nuevo};
        return json(200, eventos[nuevo]);
      case 'PATCH':
        if (!eventos.containsKey(id)) return json(404, {'error': {'code': 404}});
        eventos[id!] = {...eventos[id]!, ...?cuerpo};
        return json(200, eventos[id]);
      case 'DELETE':
        eventos.remove(id);
        return json(204, null);
      case 'GET':
        return json(200, {'items': []});
    }
    return json(400, null);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('cala${n++}', bytes: Uint8List(0));
  // Relativas a hoy: el código compara con DateTime.now() y una fecha fija acaba quedando en el pasado.
  final hoy = DateTime.now();
  final ahora = DateTime(hoy.year, hoy.month, hoy.day, 12);
  final futuro = DateTime(hoy.year, hoy.month, hoy.day + 7, 17);

  test('el evento del opositor va en su propio campo y en los ajustes se guarda si lo activa', () {
    final c = Cante(id: 'c', fecha: futuro, eventoGoogle: 'evp', eventoGoogleAlumno: 'eva');
    final j = c.toJson();
    expect(j['eventoGoogle'], 'evp');
    expect(j['eventoGoogleAlumno'], 'eva');
    final leido = Cante.fromJson(j);
    expect(leido.eventoGoogleAlumno, 'eva');
    expect(leido.eventoGoogle, 'evp');
    expect(Cante(id: 'c', fecha: futuro).toJson().containsKey('eventoGoogleAlumno'), isFalse);
    expect(const Ajustes().calendarioGoogle, isFalse);
    expect(const Ajustes().toJson()['calendarioGoogle'], isFalse);
    expect(Ajustes.fromJson(const Ajustes().copyWith(calendarioGoogle: true).toJson()).calendarioGoogle, isTrue);
    expect(Ajustes.fromJson({'calendarioGoogle': 'sí'}).calendarioGoogle, isFalse);
  });

  Future<({PlanRepo repo, _GoogleFalso google})> repo({bool activo = true, String? token = 'tok'}) async {
    final google = _GoogleFalso();
    final dio = Dio()..httpClientAdapter = google;
    final r = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja())
      ..calendario = CalendarioGoogle(token: () async => token, dio: dio, huellas: await caja(), prefijo: 'cala:')
      ..calendarioActivo = () => activo;
    return (repo: r, google: google);
  }

  test('un cante propio va al calendario como «Cante de TCEE», con el evento en eventoGoogleAlumno', () async {
    final f = await repo();
    final c = Cante(id: 'p1', fecha: futuro, temas: const ['3.A.8'], titulo: 'Simulacro');
    await f.repo.guardarCante(c);
    await f.repo.llevarAlCalendario(c.id);
    expect(f.google.peticiones.map((p) => p.metodo), ['POST']);
    expect(f.google.peticiones.single.cuerpo!['summary'], 'Cante de TCEE');
    expect(f.google.peticiones.single.cuerpo!['attendees'], isEmpty);
    final guardado = f.repo.cantes().single;
    expect(guardado.eventoGoogleAlumno, 'ev1');
    expect(guardado.eventoGoogle, isEmpty);
    // Sin cambios, no se vuelve a mandar; borrado, se quita.
    await f.repo.guardarCante(guardado);
    await f.repo.llevarAlCalendario(c.id);
    expect(f.google.peticiones.length, 1);
    await f.repo.borrarCante(guardado);
    await f.repo.llevarAlCalendario(c.id);
    expect(f.google.peticiones.last.metodo, 'DELETE');
    expect(f.google.eventos, isEmpty);
  });

  test('una clase del preparador va solo si él no la lleva a su calendario', () async {
    final f = await repo();
    final sinEvento = Cante(id: 'k1', fecha: futuro, preparador: 'uidprep', preparadorNombre: 'Manuel', alumno: 'yo', temas: const ['3.B.1']);
    final conEvento = Cante(id: 'k2', fecha: futuro.add(const Duration(days: 7)), preparador: 'uidprep', preparadorNombre: 'Manuel', alumno: 'yo', eventoGoogle: 'evp');
    expect(PlanRepo.vaAlCalendarioDelAlumno(sinEvento), isTrue);
    expect(PlanRepo.vaAlCalendarioDelAlumno(conEvento), isFalse);
    await f.repo.guardarCantes([sinEvento, conEvento]);
    await f.repo.llevarAlCalendario('k1');
    await f.repo.llevarAlCalendario('k2');
    expect(f.google.peticiones.length, 1);
    expect(f.google.peticiones.single.cuerpo!['summary'], 'Clase de TCEE con Manuel');
    final guardadas = {for (final c in f.repo.cantes()) c.id: c};
    expect(guardadas['k1']!.eventoGoogleAlumno, 'ev1');
    expect(guardadas['k2']!.eventoGoogleAlumno, isEmpty);
    expect(guardadas['k2']!.eventoGoogle, 'evp'); // el del preparador no se toca
  });

  test('las que llegan de la nube (incorporar) también van, y con la opción apagada no va nada', () async {
    final f = await repo();
    await f.repo.incorporar([Cante(id: 'n1', fecha: futuro, preparador: 'uidprep', alumno: 'yo', updatedAt: ahora)]);
    await f.repo.llevarAlCalendario('n1');
    expect(f.google.peticiones.length, 1);
    expect(f.google.peticiones.single.cuerpo!['summary'], 'Clase de TCEE');

    final apagado = await repo(activo: false);
    await apagado.repo.guardarCante(Cante(id: 'p2', fecha: futuro));
    await apagado.repo.llevarAlCalendario('p2');
    expect(apagado.google.peticiones, isEmpty);
    expect(apagado.repo.cantes().single.eventoGoogleAlumno, isEmpty);
  });

  test('al conectar se llevan los pendientes que vienen (no los pasados ni los que ya lleva el preparador)', () async {
    final f = await repo();
    await f.repo.guardarCantes([
      Cante(id: 'a', fecha: futuro),
      Cante(id: 'b', fecha: futuro.add(const Duration(days: 1)), preparador: 'uidprep', alumno: 'yo'),
      Cante(id: 'c', fecha: futuro.add(const Duration(days: 2)), preparador: 'uidprep', alumno: 'yo', eventoGoogle: 'evp'),
      Cante(id: 'd', fecha: DateTime(2026, 10, 1)),
    ]);
    // Lo que los guardados ya hayan mandado en segundo plano cuenta igual.
    final n = await f.repo.llevarCantesAlCalendario(ahora: ahora);
    expect(n, 2);
    expect(f.google.eventos.length, 2);
  });
}
