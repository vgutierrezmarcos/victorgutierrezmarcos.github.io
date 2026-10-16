import 'dart:math';
import 'dart:typed_data';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/core/red_providers.dart';
import 'package:tcee_app/data/models/cronograma.dart';
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

  test('coordinación: tablón, notas editables, reparto, propuestas sin pisarse y temas mandados', () async {
    final db = FakeFirebaseFirestore();
    final authAlu = sesion('alu', 'Álex');
    final paula = await repo(db, sesion('paula', 'Paula')), olga = await repo(db, sesion('olga', 'Olga')), alumno = await repo(db, authAlu);
    await verificar(db, 'paula', 'Paula');
    await verificar(db, 'olga', 'Olga');
    final aPaula = await conectar(alumno, paula);
    final aOlga = await conectar(alumno, olga);
    // Al aceptar, cada preparadora lo anota también en el lado del alumno.
    expect((await db.doc('users/alu/preparadores/olga').get()).data()!['aceptadoEn'], isNotNull);

    // Tablón común: escriben el alumno y las dos; cada una cambia lo suyo.
    await alumno.escribirMensaje('alu', PreparadorRepo.tablonComun, '¿Podemos pasar la del martes al miércoles?');
    await paula.escribirMensaje('alu', PreparadorRepo.tablonComun, 'Por mí, sí');
    var tablon = await olga.mensajes('alu', PreparadorRepo.tablonComun);
    expect(tablon.map((m) => m.de), ['paula', 'alu']);
    expect(tablon.last.deNombre, 'Álex');
    await paula.editarMensaje('alu', PreparadorRepo.tablonComun, tablon.first, 'Por mí, sí, a las 18:00');
    tablon = await alumno.mensajes('alu', PreparadorRepo.tablonComun);
    expect(tablon.first.texto, 'Por mí, sí, a las 18:00');
    expect(tablon.first.editado, isNotNull);

    // Notas entre preparadoras, editables.
    await paula.anadirNotaPreparadores(aPaula, 'Flojea el 3.A.9');
    final nota = (await olga.notasPreparadores(aOlga)).single;
    await paula.editarMensaje('alu', PreparadorRepo.notasEntrePreparadores, nota, 'Flojea el 3.A.9 y el 3.B.2');
    expect((await olga.notasPreparadores(aOlga)).single.texto, 'Flojea el 3.A.9 y el 3.B.2');

    // Reparto: cada una anota lo suyo; el alumno lo ve todo.
    await paula.guardarReparto('alu', 'paula', const RepartoPreparador(ejercicios: {3}));
    await olga.guardarReparto('alu', 'olga', const RepartoPreparador(ejercicios: {4}, nota: 'Comercio'));
    final reparto = await alumno.repartoDe('alu');
    expect(reparto['paula']!.ejercicios, {3});
    expect(reparto['olga']!.nota, 'Comercio');
    expect((await paula.progreso(aPaula))!.reparto['olga']!.ejercicios, {4});
    await olga.guardarReparto('alu', 'olga', const RepartoPreparador());
    expect((await alumno.repartoDe('alu')).containsKey('olga'), isFalse);

    // Propuestas de cronograma: cada una la suya, sin pisar la de la otra.
    final authPlan = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja(), firestore: db, auth: authAlu);
    final c = crearCronograma(id: 'cr', ejercicio: 3, temas: [for (var i = 1; i <= 6; i++) '3.A.$i'], inicio: DateTime.now(), porSemana: 2).copyWith(compartir: true);
    await authPlan.empezarCronograma(c);
    await authPlan.sincronizarCronogramas();
    PropuestaCronograma propuesta(String de) => PropuestaCronograma(de: de, nombre: de, fecha: DateTime.now(), temas: c.temas.reversed.toList(), temasPorSemana: 3);
    await paula.proponerCambios(aPaula, c, propuesta('paula'));
    await olga.proponerCambios(aOlga, c, propuesta('olga'));
    final enNube = Cronograma.fromJson((await db.doc('users/alu/cronogramas/cr').get()).data()!);
    expect(enNube.pendientes.map((p) => p.de).toSet(), {'paula', 'olga'});
    // Al fusionar con la copia local, siguen las dos; resuelta la de Paula, queda la de Olga.
    final resuelta = enNube.copyWith(propuestas: {...enNube.propuestas}..remove('paula'), resueltas: {'paula': DateTime.now()}, respuestas: {'paula': 'aceptada'}, quitarPropuesta: enNube.propuesta?.de == 'paula');
    final fusion = Cronograma.fusionar(resuelta, enNube);
    expect(fusion.pendientes.map((p) => p.de), ['olga']);
    expect(fusion.respuestas['paula'], 'aceptada');

    // El cronograma que manda una preparadora: al responder queda anotado (para avisarla).
    await paula.enviarCronograma(aPaula, crearCronograma(id: 'c9', ejercicio: 3, temas: const ['3.A.1'], inicio: DateTime.now()));
    await authPlan.rechazarCronogramaRecibido((await authPlan.cronogramasRecibidos()).single);
    expect((await db.doc('users/alu/cronogramasRecibidos/c9').get()).data()!['respuesta'], 'rechazado');
    expect(await authPlan.cronogramasRecibidos(), isEmpty);

    // Temas mandados: Olga ve el que Paula ya ha mandado para su próxima clase.
    final manana = DateTime.now().add(const Duration(days: 1));
    final clase = Cante(id: 'k3', fecha: manana, preparador: 'paula', preparadorNombre: 'Paula', updatedAt: DateTime.now());
    await db.doc('users/alu/cantes/k3').set(clase.toJson());
    await db.doc('temasAnticipados/k3').set({'alumno': 'alu', 'preparador': 'paula', 'temas': ['3.A.4'], 'visibleDesde': manana.toIso8601String()});
    expect(await olga.temasMandadosPorOtros(aOlga, [clase]), {'k3': ['3.A.4']});
  });

  test('el alumno decide qué ven: un preparador oculto no ve a los demás ni ellos a él', () async {
    final db = FakeFirebaseFirestore();
    final paula = await repo(db, sesion('paula', 'Paula')), olga = await repo(db, sesion('olga', 'Olga')), alumno = await repo(db, sesion('alu', 'Álex'));
    await verificar(db, 'paula', 'Paula');
    await verificar(db, 'olga', 'Olga');
    final aPaula = await conectar(alumno, paula);
    final aOlga = await conectar(alumno, olga);
    final ayer = DateTime.now().subtract(const Duration(days: 1));
    await db.doc('users/alu/cantes/dePaula').set(Cante(id: 'dePaula', fecha: ayer, preparador: 'paula', preparadorNombre: 'Paula', estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.2', valoracion: 3), updatedAt: ayer).toJson());
    await db.doc('users/alu/cantes/deOlga').set(Cante(id: 'deOlga', fecha: ayer, preparador: 'olga', preparadorNombre: 'Olga', estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.3', valoracion: 2), updatedAt: ayer).toJson());
    await db.doc('users/alu/cantes/propio').set(Cante(id: 'propio', fecha: ayer, estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1', valoracion: 4), updatedAt: ayer).toJson());

    // Oculta a Olga que tiene otros preparadores, y sus cantes por su cuenta a todos.
    await alumno.guardarAjustesCoordinacion(const AjustesCoordinacion(aislados: {'olga'}, verCantesPropios: false));
    expect(await olga.otrosPreparadoresDe(aOlga), isEmpty);
    expect(await paula.otrosPreparadoresDe(aPaula), isEmpty, reason: 'Paula tampoco ve a Olga');
    final deOlga = (await olga.progreso(aOlga))!;
    expect(deOlga.yoAislado, isTrue);
    expect(deOlga.cantes.map((c) => c.id), ['deOlga'], reason: 'ni las clases con Paula ni los cantes por su cuenta');
    final dePaula = (await paula.progreso(aPaula))!;
    final otra = dePaula.cantes.firstWhere((c) => c.id == 'deOlga');
    expect(otra.preparador, preparadorOculto);
    expect(otra.preparadorNombre, isEmpty);
    expect(conQuienEs(otra, yo: 'paula'), 'otra clase');
    expect(otra.resultado!.valoracion, 0);
    expect(dePaula.cantes.any((c) => c.id == 'propio'), isFalse);

    // Al quitar a un preparador, su marca de oculto, su reparto y sus notas se van.
    await olga.anadirNotaPreparadores(aOlga, 'nota');
    await alumno.desenlazar('olga');
    expect((await alumno.ajustesCoordinacionDe('alu')).aislados, isEmpty);
    expect((await db.collection('users/alu/notasPreparadores').get()).docs, isEmpty);
  });

  test('choques en la agenda, temas que no repetir y colores distintos', () {
    final base = DateTime(2026, 10, 20, 18);
    final agenda = [
      Cante(id: 'olga', fecha: base, minutos: 120, preparador: 'olga', preparadorNombre: 'Olga'),
      Cante(id: 'propio', fecha: base.add(const Duration(hours: 3)), minutos: 30),
      Cante(id: 'sinHora', fecha: DateTime(2026, 10, 20), minutos: 30),
      Cante(id: 'cancelada', fecha: base, minutos: 120, preparador: 'olga', estado: EstadoCante.cancelado),
    ];
    expect(choquesEnAgenda(agenda, base.add(const Duration(hours: 1)), 120).map((c) => c.id), ['olga']);
    expect(choquesEnAgenda(agenda, base.add(const Duration(hours: 2)), 60), isEmpty, reason: 'empieza justo al acabar');
    expect(choquesEnAgenda(agenda, base.add(const Duration(hours: 3, minutes: 15)), 60).map((c) => c.id), ['propio']);
    expect(choquesEnAgenda(agenda, base, 120, excluir: 'olga'), isEmpty);
    expect(conQuienEs(agenda.first, yo: 'paula'), 'con Olga');
    expect(conQuienEs(agenda[1]), 'por tu cuenta');

    final ahora = DateTime(2026, 10, 20, 12);
    final hechos = [
      Cante(id: 'h1', fecha: ahora.subtract(const Duration(days: 3)), preparador: 'olga', preparadorNombre: 'Olga', estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1')),
      Cante(id: 'h2', fecha: ahora.subtract(const Duration(days: 30)), estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.2')),
      Cante(id: 'p1', fecha: ahora.add(const Duration(days: 2)), preparador: 'olga', preparadorNombre: 'Olga'),
    ];
    final evitar = temasAEvitar(hechos, mandados: {'p1': ['3.A.3']}, ahora: ahora, yo: 'paula');
    expect(evitar.keys.toSet(), {'3.A.1', '3.A.3'});
    expect(evitar['3.A.1'], 'cantado hace 3 días con Olga');
    expect(evitar['3.A.3'], contains('con Olga'));
    final bolsa = ['3.A.1', '3.A.2', '3.A.3', '3.A.4'];
    expect(sinRepetir(bolsa, evitar.keys.toSet(), 2, (t) => t), ['3.A.2', '3.A.4']);
    expect(sinRepetir(bolsa, evitar.keys.toSet(), 3, (t) => t), bolsa, reason: 'si no quedan bastantes, entran todos');

    // Tres preparadores, tres colores distintos, aunque su clave coincida.
    final claves = ['paula', 'olga', 'marta', 'luis', 'ana'];
    asignarColoresDistintos(claves);
    expect({for (final c in claves) colorDePersona(c)}.length, claves.length);
  });
}
