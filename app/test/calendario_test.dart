import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/repos/calendario_google.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';

/// Google Calendar simulado: guarda las peticiones y responde como la API.
class _GoogleFalso implements HttpClientAdapter {
  final peticiones = <({String metodo, String ruta, Map<String, dynamic> query, Map<String, dynamic>? cuerpo, String? auth})>[];
  final eventos = <String, Map<String, dynamic>>{};
  var siguiente = 1;
  /// Respuesta forzada para la siguiente petición (p. ej. 404).
  int? forzar;

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final cuerpo = o.data is Map ? Map<String, dynamic>.from(o.data as Map) : null;
    peticiones.add((metodo: o.method, ruta: o.uri.path, query: o.queryParameters, cuerpo: cuerpo, auth: o.headers['Authorization'] as String?));
    ResponseBody json(int codigo, Object? datos) =>
        ResponseBody.fromString(jsonEncode(datos ?? {}), codigo, headers: {Headers.contentTypeHeader: ['application/json']});
    if (forzar != null) {
      final c = forzar!;
      forzar = null;
      return json(c, {'error': {'code': c}});
    }
    final partes = o.uri.pathSegments;
    final id = partes.last == 'events' ? null : partes.last;
    switch (o.method) {
      case 'POST':
        final nuevo = 'ev${siguiente++}';
        final ev = {...?cuerpo, 'id': nuevo};
        if (cuerpo?['conferenceData'] != null) ev['hangoutLink'] = 'https://meet.google.com/abc-defg-${nuevo.padLeft(3, '0')}';
        eventos[nuevo] = ev;
        return json(200, ev);
      case 'PATCH':
        if (!eventos.containsKey(id)) return json(404, {'error': {'code': 404}});
        eventos[id!] = {...eventos[id]!, ...?cuerpo};
        if (cuerpo?['conferenceData'] != null) eventos[id]!['hangoutLink'] = 'https://meet.google.com/xyz-$id';
        return json(200, eventos[id]);
      case 'DELETE':
        if (eventos.remove(id) == null) return json(410, {'error': {'code': 410}});
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
  Future<Box> caja() => Hive.openBox('cal${n++}', bytes: Uint8List(0));
  final ahora = DateTime(2026, 10, 9, 12);

  Cante clase({Modalidad modalidad = Modalidad.online, String enlace = '', DateTime? fecha}) =>
      Cante(id: 'c1', fecha: fecha ?? DateTime(2026, 10, 15, 18), minutos: 90, alumno: 'lucia', temas: const ['3.A.7'], modalidad: modalidad, enlace: enlace);

  ({CalendarioGoogle cal, _GoogleFalso google}) calendario({String? token = 'tok', Box? huellas}) {
    final google = _GoogleFalso();
    final dio = Dio()..httpClientAdapter = google;
    return (cal: CalendarioGoogle(token: () async => token, dio: dio, huellas: huellas), google: google);
  }

  group('evento', () {
    test('online sin enlace: pide la reunión de Meet e invita al alumno', () {
      final c = calendario().cal;
      final e = c.evento(clase(), alumno: 'Lucía', email: 'lucia@gmail.com', preparador: 'Víctor', siglas: 'TCEE');
      expect(e['summary'], 'Clase de TCEE: Víctor y Lucía');
      expect(e['conferenceData']['createRequest']['conferenceSolutionKey']['type'], 'hangoutsMeet');
      expect(e['attendees'], [{'email': 'lucia@gmail.com', 'displayName': 'Lucía'}]);
      expect(e['start']['timeZone'], 'Europe/Madrid');
      expect(DateTime.parse(e['start']['dateTime'] as String).toLocal(), DateTime(2026, 10, 15, 18));
      expect(DateTime.parse(e['end']['dateTime'] as String).toLocal(), DateTime(2026, 10, 15, 19, 30));
      expect(e['description'], contains('3.A.7'));
    });

    test('con enlace propio o presencial, sin Meet nuevo', () {
      final c = calendario().cal;
      final propio = c.evento(clase(enlace: 'https://zoom.us/j/1'));
      expect(propio.containsKey('conferenceData'), isFalse);
      expect(propio['location'], 'https://zoom.us/j/1');
      final presencial = c.evento(Cante(id: 'p', fecha: DateTime(2026, 10, 15, 18), modalidad: Modalidad.presencial, lugar: 'Calle Mayor 1'));
      expect(presencial.containsKey('conferenceData'), isFalse);
      expect(presencial['location'], 'Calle Mayor 1');
      expect(presencial['attendees'], isEmpty); // sin correo no se invita a nadie
    });
  });

  group('sincronizar', () {
    test('crea, no repite, cambia y borra', () async {
      final f = calendario(huellas: await caja());
      // Crear: POST con Meet; vuelve el evento y el enlace de la reunión.
      final creada = await f.cal.sincronizar(clase(), alumno: 'Lucía', email: 'lucia@gmail.com', siglas: 'TCEE', ahora: ahora);
      expect(f.google.peticiones.single.metodo, 'POST');
      expect(f.google.peticiones.single.auth, 'Bearer tok');
      expect(f.google.peticiones.single.query, {'conferenceDataVersion': 1, 'sendUpdates': 'all'});
      expect(creada!.eventoGoogle, 'ev1');
      expect(creada.enlace, startsWith('https://meet.google.com/'));
      // Igual que lo mandado: no se vuelve a llamar a Google.
      expect(await f.cal.sincronizar(creada, alumno: 'Lucía', email: 'lucia@gmail.com', siglas: 'TCEE', ahora: ahora), isNull);
      expect(f.google.peticiones.length, 1);
      // Otra hora: PATCH del mismo evento, sin pedir otro Meet (ya tiene enlace).
      final movida = creada.copyWith(fecha: DateTime(2026, 10, 16, 18));
      expect(await f.cal.sincronizar(movida, alumno: 'Lucía', email: 'lucia@gmail.com', siglas: 'TCEE', ahora: ahora), isNull);
      expect(f.google.peticiones.last.metodo, 'PATCH');
      expect(f.google.peticiones.last.ruta, endsWith('/events/ev1'));
      expect(f.google.peticiones.last.cuerpo!.containsKey('conferenceData'), isFalse);
      expect(DateTime.parse(f.google.eventos['ev1']!['start']['dateTime'] as String).toLocal(), DateTime(2026, 10, 16, 18));
      // Cancelada: DELETE con aviso al alumno y la clase sin evento.
      final cancelada = await f.cal.sincronizar(movida.copyWith(estado: EstadoCante.cancelado), ahora: ahora);
      expect(f.google.peticiones.last.metodo, 'DELETE');
      expect(f.google.peticiones.last.query, {'sendUpdates': 'all'});
      expect(cancelada!.eventoGoogle, isEmpty);
      expect(f.google.eventos, isEmpty);
    });

    test('si se borró a mano en el calendario, se vuelve a crear', () async {
      final f = calendario();
      final creada = (await f.cal.sincronizar(clase(enlace: 'https://meet.google.com/aaa-bbbb-ccc'), ahora: ahora))!;
      f.google.eventos.clear(); // borrado a mano
      final otra = await f.cal.sincronizar(creada.copyWith(minutos: 120), ahora: ahora);
      expect(f.google.peticiones.map((p) => p.metodo), ['POST', 'PATCH', 'POST']);
      expect(otra!.eventoGoogle, 'ev2');
    });

    test('sin permiso, hecha o pasada: no llama a Google', () async {
      final sin = calendario(token: null);
      expect(await sin.cal.sincronizar(clase(), ahora: ahora), isNull);
      expect(sin.google.peticiones, isEmpty);
      final f = calendario();
      expect(await f.cal.sincronizar(clase().copyWith(estado: EstadoCante.hecho), ahora: ahora), isNull);
      expect(await f.cal.sincronizar(clase(fecha: DateTime(2026, 10, 1, 18)), ahora: ahora), isNull);
      expect(await f.cal.sincronizar(clase().copyWith(estado: EstadoCante.cancelado), ahora: ahora), isNull); // sin evento, nada que borrar
      expect(f.google.peticiones, isEmpty);
    });

    test('un error de Google llega a quien llama', () async {
      final f = calendario();
      f.google.forzar = 403;
      expect(() => f.cal.sincronizar(clase(), ahora: ahora), throwsA(isA<DioException>()));
    });
  });

  group('en el preparador', () {
    Future<(PreparadorRepo, _GoogleFalso)> preparar({required bool activo}) async {
      final db = FakeFirebaseFirestore();
      final auth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'prep', displayName: 'Víctor', email: 'prep@gmail.com'));
      final repo = PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
      final f = calendario(huellas: await caja());
      repo.calendario = f.cal;
      await repo.guardarPerfil(const PerfilPreparador(activo: true, nombre: 'Víctor').copyWith(calendarioGoogle: activo));
      await repo.guardarAlumno(Alumno(id: 'lucia', nombre: 'Lucía', uid: 'alu', email: 'lucia@gmail.com', creado: DateTime.now(), updatedAt: DateTime.now()));
      return (repo, f.google);
    }

    test('al guardar la clase va al calendario y el enlace de Meet llega al alumno', () async {
      final (repo, google) = await preparar(activo: true);
      final futura = clase(fecha: DateTime.now().add(const Duration(days: 3)));
      await repo.guardarSesion(futura);
      await repo.llevarAlCalendario(futura.id); // espera a lo que se manda en segundo plano
      final guardada = repo.sesiones().single;
      expect(guardada.eventoGoogle, isNotEmpty);
      expect(guardada.enlace, startsWith('https://meet.google.com/'));
      expect(google.peticiones.where((p) => p.metodo == 'POST').length, 1); // un solo evento
      expect(google.eventos.values.single['attendees'], [{'email': 'lucia@gmail.com', 'displayName': 'Lucía'}]);
      // La copia del alumno lleva el enlace, pero no el evento del calendario del preparador.
      final copia = repo.copiaParaAlumno(guardada);
      expect(copia['enlace'], guardada.enlace);
      expect(copia.containsKey('eventoGoogle'), isFalse);
      // Borrarla la quita del calendario.
      await repo.borrarSesion(guardada);
      await repo.llevarAlCalendario(guardada.id);
      expect(google.eventos, isEmpty);
    });

    test('con la opción apagada no se toca el calendario', () async {
      final (repo, google) = await preparar(activo: false);
      await repo.guardarSesion(clase(fecha: DateTime.now().add(const Duration(days: 3))));
      await repo.llevarAlCalendario('c1');
      expect(google.peticiones, isEmpty);
      expect(repo.sesiones().single.eventoGoogle, isEmpty);
    });

    test('al conectarlo, lleva las clases pendientes que vienen', () async {
      final (repo, google) = await preparar(activo: false);
      await repo.guardarSesion(clase(fecha: DateTime.now().add(const Duration(days: 2))));
      await repo.guardarSesion(Cante(id: 'c2', fecha: DateTime.now().add(const Duration(days: 9)), alumno: 'lucia', modalidad: Modalidad.presencial));
      await repo.guardarSesion(Cante(id: 'vieja', fecha: DateTime.now().subtract(const Duration(days: 2)), alumno: 'lucia'));
      await repo.guardarPerfil(repo.perfil().copyWith(calendarioGoogle: true));
      expect(await repo.llevarClasesAlCalendario(), 2);
      expect(google.eventos.length, 2);
    });

    test('lista de prueba: solo las cuentas apuntadas', () async {
      final db = FakeFirebaseFirestore();
      PreparadorRepo con(String uid) => PreparadorRepo(alumnos: Hive.box('x'), sesiones: Hive.box('x'), perfil: Hive.box('x'), firestore: db, auth: MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: uid, email: '$uid@gmail.com')));
      await Hive.openBox('x', bytes: Uint8List(0));
      await db.collection('pruebasCalendario').doc('victor@gmail.com').set({'desde': 'consola'});
      expect(await con('victor').calendarioPermitido(), PermisoCalendario.permitido);
      expect(await con('otro').calendarioPermitido(), PermisoCalendario.noEnLista);
    });
  });
}
