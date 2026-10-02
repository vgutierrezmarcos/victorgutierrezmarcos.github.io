import 'dart:math';
import 'dart:typed_data';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

/// Sección de preparadores: código, enlace entre el preparador y su alumno,
/// sesiones copiadas a la agenda del alumno y ruptura del enlace. Firestore y
/// la sesión son simulados; las cajas de Hive, en memoria. Las reglas de
/// firestore.rules no se comprueban aquí: el simulador no admite funciones.
void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('prep${n++}', bytes: Uint8List(0));

  MockFirebaseAuth sesion(String uid, String nombre) => MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: uid, displayName: nombre, email: '$uid@example.org'));

  Future<PreparadorRepo> repo(FakeFirebaseFirestore? db, MockFirebaseAuth? auth) async =>
      PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);

  test('códigos: forma, normalización e informe del cante', () {
    final codigo = generarCodigo(Random(7));
    expect(codigo, matches(RegExp(r'^[A-HJ-NP-Z2-9]{6}$')));
    expect(normalizarCodigo(' ${codigo.toLowerCase().substring(0, 3)}-${codigo.toLowerCase().substring(3)} '), codigo);
    expect(normalizarCodigo('ABC'), isNull);
    expect(normalizarCodigo('ABCDE0'), isNull); // el cero no forma parte del alfabeto

    final informe = informeCante(
      Cante(id: 'c', fecha: DateTime(2026, 10, 8, 17), minutos: 30, resultado: const ResultadoCante(sorteados: ['3.A.7', '3.B.2'], temaCantado: '3.A.7', segundos: 1725, valoracion: 4, comentarios: 'Buen arranque; falta el cierre.')),
      alumno: 'Lucía',
      tituloDe: (c) => c == '3.A.7' ? 'La nueva economía keynesiana' : '',
    );
    expect(informe, contains('Cante del 8/10/2026 · Lucía'));
    expect(informe, contains('Tema 3.A.7 · La nueva economía keynesiana'));
    expect(informe, contains('★★★★☆'));
    expect(informe, contains('Tiempo: 28:45 (previsto: 30 min)'));
    expect(informe, contains('Buen arranque; falta el cierre.'));
  });

  test('sin sesión, el preparador lleva a sus alumnos en local', () async {
    final prep = await repo(null, null);
    final perfil = await prep.activar();
    expect(perfil.activo, isTrue);
    expect(perfil.codigo, isNull);

    await prep.guardarAlumno(Alumno(id: 'a1', nombre: 'Marta', temas: const ['3.A.1'], updatedAt: DateTime.now()));
    await prep.guardarSesion(Cante(id: 's1', fecha: DateTime.now().add(const Duration(days: 1)), alumno: 'a1', updatedAt: DateTime.now()));
    expect(prep.alumnos().single.nombre, 'Marta');
    expect(prep.sesiones().single.alumno, 'a1');
    expect(() => prep.enlazarConCodigo('ABCDEF'), throwsA(isA<ErrorEnlace>()));

    await prep.borrarAlumno(prep.alumnos().single);
    expect(prep.alumnos(), isEmpty);
  });

  test('enlace por código: el alumno comparte y recibe las sesiones y valoraciones', () async {
    final db = FakeFirebaseFirestore();
    final authPrep = sesion('prep', 'Paula Preparadora'), authAlu = sesion('alu', 'Álex Alumno');
    final prep = await repo(db, authPrep), alumno = await repo(db, authAlu);
    final ajustesAlu = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja(), firestore: db, auth: authAlu);
    final planAlu = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), firestore: db, auth: authAlu);

    // El preparador activa la sección y obtiene su código.
    final perfil = await prep.activar();
    final codigo = perfil.codigo!;
    expect(perfil.nombre, 'Paula Preparadora');
    expect((await db.collection('codigos').doc(codigo).get()).data()!['uid'], 'prep');

    // Errores al enlazar.
    expect(() => alumno.enlazarConCodigo('ZZZ999'), throwsA(isA<ErrorEnlace>().having((e) => e.mensaje, 'mensaje', contains('ningún preparador'))));
    expect(() => prep.enlazarConCodigo(codigo), throwsA(isA<ErrorEnlace>().having((e) => e.mensaje, 'mensaje', contains('propio código'))));

    // El alumno enlaza tecleando el código en minúsculas.
    final vinculo = await alumno.enlazarConCodigo(codigo.toLowerCase());
    expect(vinculo.nombre, 'Paula Preparadora');
    expect(alumno.misPreparadores().single.uid, 'prep');
    expect((await db.doc('users/alu/preparadores/prep').get()).exists, isTrue);
    expect((await db.doc('preparadores/prep/alumnos/alu').get()).data()!['nombre'], 'Álex Alumno');

    // Al sincronizar, el preparador lo ve en su lista.
    await prep.sincronizarTodo();
    var a = prep.alumnos().single;
    expect(a.nombre, 'Álex Alumno');
    expect(a.uid, 'alu');

    // Ve los temas que el alumno marca y sus cantes; la lista queda guardada para sortear sin red.
    await ajustesAlu.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.1', '3.A.2', '3.B.5'}, temasEnRepaso: {'3.A.2'}));
    await planAlu.guardarCante(Cante(id: 'propio', fecha: DateTime(2026, 9, 1, 10), estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.1', valoracion: 2), updatedAt: DateTime.now()));
    final progreso = (await prep.progreso(a))!;
    expect(progreso.estudiados, {'3.A.1', '3.A.2', '3.B.5'});
    expect(progreso.enRepaso, {'3.A.2'});
    expect(progreso.cantes.single.id, 'propio');
    a = prep.alumnos().single;
    expect(a.temas, ['3.A.1', '3.A.2', '3.B.5']);

    // Una sesión programada por el preparador llega a la agenda del alumno.
    final cuando = DateTime.now().add(const Duration(days: 2));
    final s = Cante(id: 's1', fecha: cuando, alumno: a.id, bolsa: TipoBolsa.estudiados, notas: 'Trae el tema 3.B.5 repasado', updatedAt: DateTime.now());
    await prep.guardarSesion(s);
    await planAlu.sincronizarCantes();
    final enAgenda = planAlu.cantes().firstWhere((c) => c.id == 's1');
    expect(enAgenda.dePreparador, isTrue);
    expect(enAgenda.preparador, 'prep');
    expect(enAgenda.preparadorNombre, 'Paula Preparadora');
    expect(enAgenda.titulo, 'Con Paula Preparadora');
    expect(enAgenda.alumno, isNull);
    expect(enAgenda.pendiente, isTrue);

    // La valoración llega a su diario.
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await prep.guardarSesion(s.copyWith(estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.B.5', segundos: 1700, valoracion: 4, comentarios: 'Muy bien el esquema.')));
    await planAlu.sincronizarCantes();
    final enDiario = planAlu.cantes().firstWhere((c) => c.id == 's1');
    expect(enDiario.hecho, isTrue);
    expect(enDiario.resultado!.valoracion, 4);
    expect(enDiario.resultado!.comentarios, 'Muy bien el esquema.');

    // Las sesiones del preparador viajan a su otro dispositivo.
    final otroMovil = await repo(db, authPrep);
    await otroMovil.sincronizarTodo();
    expect(otroMovil.perfil().codigo, codigo);
    expect(otroMovil.alumnos().single.uid, 'alu');
    expect(otroMovil.sesiones().single.hecho, isTrue);

    // El alumno deja de compartir: el preparador pierde el enlace y ya no se le copian sesiones.
    await alumno.desenlazar('prep');
    expect(alumno.misPreparadores(), isEmpty);
    expect((await db.doc('users/alu/preparadores/prep').get()).exists, isFalse);
    expect((await db.doc('preparadores/prep/alumnos/alu').get()).exists, isFalse);
    await prep.sincronizarTodo();
    a = prep.alumnos().single;
    expect(a.enlazado, isFalse);
    await prep.guardarSesion(Cante(id: 's2', fecha: cuando, alumno: a.id, updatedAt: DateTime.now()));
    expect((await db.doc('users/alu/cantes/s2').get()).exists, isFalse);
    expect(prep.sesiones().length, 2); // en su lado siguen las dos
  });

  test('el preparador puede dejar de llevar a un alumno enlazado', () async {
    final db = FakeFirebaseFirestore();
    final prep = await repo(db, sesion('prep', 'Paula')), alumno = await repo(db, sesion('alu', 'Álex'));
    final codigo = (await prep.activar()).codigo!;
    await alumno.enlazarConCodigo(codigo);
    await prep.sincronizarTodo();

    await prep.borrarAlumno(prep.alumnos().single);
    expect(prep.alumnos(), isEmpty);
    expect((await db.doc('users/alu/preparadores/prep').get()).exists, isFalse);
    expect((await db.doc('preparadores/prep/alumnos/alu').get()).exists, isFalse);
    // El alumno se entera al sincronizar.
    await alumno.sincronizarTodo();
    expect(alumno.misPreparadores(), isEmpty);
  });
}
