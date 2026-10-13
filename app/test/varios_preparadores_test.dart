import 'dart:math';
import 'dart:typed_data';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/features/cantar/pizarra_compartida.dart';
import 'package:tcee_app/features/cantar/pizarra_trazos.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';
import 'package:tcee_app/features/preparador/otros_preparadores.dart';

/// Pizarra para practicar sola, cronogramas que manda el preparador y lo que
/// ve cada preparador cuando el alumno tiene varios.
void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('varios${n++}', bytes: Uint8List(0));
  MockFirebaseAuth sesion(String uid, String nombre) => MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: uid, displayName: nombre, email: '$uid@example.org'));
  Future<PreparadorRepo> repo(FakeFirebaseFirestore db, MockFirebaseAuth auth) async =>
      PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);
  Future<void> verificar(FakeFirebaseFirestore db, String uid, String nombre) =>
      db.collection('preparadoresVerificados').doc(uid).set(PreparadorVerificado(uid: uid, nombre: nombre, avaladoPor: 'admin', desde: DateTime.now(), linkedin: 'https://www.linkedin.com/in/$uid').toJson());

  /// El alumno conecta con el código del preparador y este lo acepta.
  Future<Alumno> conectar(PreparadorRepo alumno, PreparadorRepo prep) async {
    await alumno.enlazarConCodigo((await prep.activar()).codigo!);
    await prep.sincronizarTodo();
    await prep.aceptarEnlace(prep.solicitudesEnlace().single);
    await alumno.sincronizarTodo();
    return prep.alumnos().single;
  }

  test('pizarra para practicar: dibuja, deshace, vacía y pasa de página sin red', () async {
    final p = PizarraLocal();
    final paginas = <List<PaginaPizarra>>[];
    final sub = p.escuchar().listen(paginas.add);
    Trazo t(String id) => Trazo(id: id, de: 'yo', grosor: 3, puntos: const [Point(1, 1), Point(5, 5)]);
    p.encolar('p1', 1, t('a'));
    p.encolar('p1', 1, t('b'));
    await pumpEventQueue();
    expect(paginas.last.single.trazos.map((x) => x.id), ['a', 'b']);
    await p.deshacer('p1', paginas.last.single.trazos.last.crudo!);
    await pumpEventQueue();
    expect(paginas.last.single.trazos.map((x) => x.id), ['a']);
    await p.nuevaPagina(2);
    await pumpEventQueue();
    expect(paginas.last.map((x) => x.n), [1, 2]);
    await p.borrarTodo('p1');
    await p.eliminarPagina('p2');
    await pumpEventQueue();
    expect(paginas.last.single.trazos, isEmpty);
    await sub.cancel();
  });

  test('el preparador manda un cronograma; el alumno lo acepta y queda compartido', () async {
    final db = FakeFirebaseFirestore();
    final authAlu = sesion('alu', 'Álex');
    final prep = await repo(db, sesion('prep', 'Paula')), alumno = await repo(db, authAlu);
    await verificar(db, 'prep', 'Paula');
    final a = await conectar(alumno, prep);
    final planAlu = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja(), firestore: db, auth: authAlu);
    await planAlu.empezarCronograma(crearCronograma(id: 'suyo', ejercicio: 3, temas: const ['3.A.1'], inicio: DateTime.now()));

    final c = crearCronograma(id: 'c1', ejercicio: 3, temas: [for (var i = 1; i <= 6; i++) '3.A.$i'], inicio: DateTime.now(), porSemana: 2);
    await prep.enviarCronograma(a, c, nota: 'Empieza por micro');
    final recibidos = await planAlu.cronogramasRecibidos();
    expect(recibidos.single.deNombre, isNotEmpty);
    expect(recibidos.single.nota, 'Empieza por micro');
    expect(planAlu.cronogramaActivo()!.id, 'suyo'); // hasta que lo acepte, nada cambia

    final nuevo = await planAlu.aceptarCronogramaRecibido(recibidos.single);
    expect(planAlu.cronogramaActivo()!.id, nuevo.id);
    expect(planAlu.cronogramaActivo()!.temas.length, 6);
    expect(planAlu.cronogramaActivo()!.compartir, isTrue);
    expect(planAlu.cronogramas().firstWhere((x) => x.id == 'suyo').archivado, isTrue);
    expect(await planAlu.cronogramasRecibidos(), isEmpty);
    expect((await prep.cronogramaDe(a))!.id, nuevo.id); // el preparador ya lo ve

    // Rechazar solo lo borra.
    await prep.enviarCronograma(a, crearCronograma(id: 'c2', ejercicio: 3, temas: const ['3.A.9'], inicio: DateTime.now()));
    await planAlu.rechazarCronogramaRecibido((await planAlu.cronogramasRecibidos()).single);
    expect(await planAlu.cronogramasRecibidos(), isEmpty);
    expect(planAlu.cronogramaActivo()!.id, nuevo.id);
  });

  test('dos preparadores: se ven, comparten WhatsApp y notas, y no ven la valoración del otro', () async {
    final db = FakeFirebaseFirestore();
    final paula = await repo(db, sesion('paula', 'Paula')), olga = await repo(db, sesion('olga', 'Olga')), alumno = await repo(db, sesion('alu', 'Álex'));
    await verificar(db, 'paula', 'Paula');
    await verificar(db, 'olga', 'Olga');
    final aPaula = await conectar(alumno, paula);
    final aOlga = await conectar(alumno, olga);
    expect((await db.doc('users/alu/preparadores/paula').get()).data()!['aceptado'], isTrue);

    // Cada una ve a la otra, con su LinkedIn; el WhatsApp, solo si lo comparte.
    var otros = await paula.otrosPreparadoresDe(aPaula);
    expect(otros.single.uid, 'olga');
    expect(otros.single.linkedin, contains('olga'));
    expect(otros.single.telefono, isEmpty);
    await olga.guardarPerfil(olga.perfil().copyWith(telefono: '600123456'));
    await olga.compartirContacto(aOlga, true);
    expect(await olga.comparteContacto(aOlga), isTrue);
    otros = await paula.otrosPreparadoresDe(aPaula);
    expect(otros.single.telefono, '600123456');

    // Notas entre ellas.
    await paula.anadirNotaPreparadores(aPaula, 'Flojea el 3.A.9');
    final notas = await olga.notasPreparadores(aOlga);
    expect(notas.single.texto, 'Flojea el 3.A.9');
    expect(notas.single.de, 'paula');

    // Olga valora una clase: Paula ve el tema, la fecha y con quién, no la nota.
    final hace = DateTime.now().subtract(const Duration(days: 12));
    await db.doc('users/alu/cantes/k1').set(Cante(id: 'k1', fecha: hace, preparador: 'olga', preparadorNombre: 'Olga', estado: EstadoCante.hecho, notas: 'Indicaciones de Olga', resultado: const ResultadoCante(temaCantado: '3.A.9', valoracion: 2, comentarios: 'Le falta el cierre'), updatedAt: hace).toJson());
    await db.doc('users/alu/cantes/k2').set(Cante(id: 'k2', fecha: hace, estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1', valoracion: 4), updatedAt: hace).toJson());
    final progreso = (await paula.progreso(aPaula))!;
    final deOlga = progreso.cantes.firstWhere((c) => c.id == 'k1');
    expect(deOlga.resultado!.temaCantado, '3.A.9');
    expect(deOlga.resultado!.valoracion, 0);
    expect(deOlga.resultado!.comentarios, isEmpty);
    expect(deOlga.notas, isEmpty);
    expect(progreso.cantes.firstWhere((c) => c.id == 'k2').resultado!.valoracion, 4); // los suyos, sí
    expect((await olga.progreso(aOlga))!.cantes.firstWhere((c) => c.id == 'k1').resultado!.valoracion, 2);

    // Por tema: cuál no ha cantado, cuándo y con quién.
    final t = temasCantados(const ['3.A.1', '3.A.9', '3.B.2'], progreso.cantes.where((c) => c.hecho).toList(), yo: 'paula', mias: const {});
    expect(t['3.B.2']!.veces, 0);
    expect(t['3.A.9']!.ultimaCon, 'con Olga');
    expect(t['3.A.9']!.conmigo, 0);
    expect(t['3.A.1']!.ultimaCon, 'por su cuenta');
    expect(haceCuanto(hace), 'hace 12 días');

    // Si el alumno deja a Olga, su contacto compartido desaparece.
    await alumno.desenlazar('olga');
    expect((await db.doc('users/alu/contactosPreparadores/olga').get()).exists, isFalse);
    expect(await paula.otrosPreparadoresDe(aPaula), isEmpty);
  });
}
