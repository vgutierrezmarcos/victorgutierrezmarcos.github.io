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

  /// Da de alta como verificado (lo haría el administrador o un verificado).
  Future<void> verificar(FakeFirebaseFirestore db, String uid, String nombre) =>
      db.collection('preparadoresVerificados').doc(uid).set(PreparadorVerificado(uid: uid, nombre: nombre, avaladoPor: 'admin', desde: DateTime.now()).toJson());

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

  test('el código del preparador no cambia: otro dispositivo, llamadas a la vez y sincronización', () async {
    final db = FakeFirebaseFirestore();
    final auth = sesion('prep', 'Paula');
    await verificar(db, 'prep', 'Paula');
    final movil = await repo(db, auth);
    final codigo = (await movil.activar()).codigo!;
    expect((await db.doc('users/prep/progress/preparador').get()).data()!['codigo'], codigo);

    // Un dispositivo nuevo (o el navegador): sin nada en local, recupera el mismo.
    final web = await repo(db, auth);
    expect((await web.activar()).codigo, codigo);
    // Guardar el perfil sin código no borra el de la nube.
    final otro = await repo(db, auth);
    await otro.guardarPerfil(otro.perfil().copyWith(activo: true, telefono: '600'));
    expect((await db.doc('users/prep/progress/preparador').get()).data()!['codigo'], codigo);
    await otro.sincronizarTodo();
    expect(otro.perfil().codigo, codigo);
    expect(otro.perfil().telefono, '600');

    // Dos activaciones a la vez en un dispositivo vacío: un solo código.
    final db2 = FakeFirebaseFirestore();
    final auth2 = sesion('olga', 'Olga');
    await verificar(db2, 'olga', 'Olga');
    final r = await repo(db2, auth2);
    final ambos = await Future.wait([r.activar(), r.activar(), r.sincronizarTodo().then((_) => r.activar())]);
    expect(ambos.map((p) => p.codigo).toSet().length, 1);
    expect((await db2.collection('codigos').get()).docs.length, 1);
  });

  test('enlace por código: el alumno comparte y recibe las sesiones y valoraciones', () async {
    final db = FakeFirebaseFirestore();
    final authPrep = sesion('prep', 'Paula Preparadora'), authAlu = sesion('alu', 'Álex Alumno');
    final prep = await repo(db, authPrep), alumno = await repo(db, authAlu);
    await verificar(db, 'prep', 'Paula Preparadora');
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

    // Un tema antes de la clase: el alumno sabe la hora, pero no el tema; el
    // tema va aparte, en temasAnticipados (las reglas solo se lo dejan leer a su hora).
    await Future<void>.delayed(const Duration(milliseconds: 5));
    prep.tituloTema = (c) => c == '3.B.5' ? 'Política fiscal' : '';
    final hora = cuando.subtract(const Duration(hours: 24));
    await prep.guardarSesion(s.copyWith(temaA: hora, temasMandados: ['3.B.5'], temaSorteado: true));
    expect(prep.sesiones().single.temaMandado, '3.B.5');
    await planAlu.sincronizarCantes();
    final conTema = planAlu.cantes().firstWhere((c) => c.id == 's1');
    expect(conTema.temaA, hora);
    expect(conTema.temaMandado, isNull);
    expect((await db.doc('users/alu/cantes/s1').get()).data()!.containsKey('temaMandado'), isFalse);
    final anticipado = (await db.doc('temasAnticipados/s1').get()).data()!;
    expect(anticipado['tema'], '3.B.5');
    expect(anticipado['titulo'], 'Política fiscal');
    expect(anticipado['alumno'], 'alu');
    expect(anticipado['sorteado'], isTrue);
    // Lo que cambia el alumno no borra el tema del lado del preparador.
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await planAlu.guardarCante(conTema.copyWith(notas: 'Llevo el esquema'));
    await prep.sincronizarTodo();
    expect(prep.sesiones().single.temaMandado, '3.B.5');
    // Si se quita, se retira.
    await prep.guardarSesion(prep.sesiones().single.copyWith(sinTema: true));
    expect((await db.doc('temasAnticipados/s1').get()).exists, isFalse);

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
    await verificar(db, 'prep', 'Paula');
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

  test('lo que el alumno cambia en una sesión vuelve al preparador, sin perder su lado', () async {
    final db = FakeFirebaseFirestore();
    final authAlu = sesion('alu', 'Álex');
    final prep = await repo(db, sesion('prep', 'Paula')), alumno = await repo(db, authAlu);
    await verificar(db, 'prep', 'Paula');
    final planAlu = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), firestore: db, auth: authAlu);
    await alumno.enlazarConCodigo((await prep.activar()).codigo!);
    await prep.sincronizarTodo();
    final a = prep.alumnos().single;
    await prep.guardarSesion(Cante(id: 's1', fecha: DateTime(2026, 10, 8, 17), alumno: a.id, titulo: 'Simulacro del jueves', updatedAt: DateTime.now()));
    await planAlu.sincronizarCantes();

    // El alumno la retrasa una hora y, otro día, la quita de su agenda.
    await Future<void>.delayed(const Duration(milliseconds: 5));
    final suya = planAlu.cantes().single;
    await planAlu.guardarCante(suya.copyWith(fecha: DateTime(2026, 10, 8, 18), notas: 'Llego a las seis'));
    await prep.sincronizarTodo();
    var s = prep.sesiones().single;
    expect(s.fecha, DateTime(2026, 10, 8, 18));
    expect(s.notas, 'Llego a las seis');
    expect(s.alumno, a.id);
    expect(s.titulo, 'Simulacro del jueves');
    expect(s.preparador, isNull);
    expect((await db.doc('users/prep/sesiones/s1').get()).data()!['notas'], 'Llego a las seis');

    await Future<void>.delayed(const Duration(milliseconds: 5));
    await planAlu.borrarCante(planAlu.cantes().single);
    await prep.sincronizarTodo();
    s = prep.sesiones().single;
    expect(s.borrado, isFalse, reason: 'quitarla de la agenda del alumno no la borra del preparador');
  });

  test('borrar todos mis datos rompe los enlaces, libera el código y vacía la nube', () async {
    final db = FakeFirebaseFirestore();
    final authPrep = sesion('prep', 'Paula'), authAlu = sesion('alu', 'Álex');
    final prep = await repo(db, authPrep), alumno = await repo(db, authAlu);
    final usuarioPrep = UsuarioRepo(resultados: await caja(), leitner: await caja(), ajustes: await caja(), notas: await caja(), firestore: db, auth: authPrep);
    await verificar(db, 'prep', 'Paula');
    await verificar(db, 'otro', 'Olga');
    final codigo = (await prep.activar()).codigo!;
    await alumno.enlazarConCodigo(codigo);
    await prep.sincronizarTodo();
    await prep.guardarSesion(Cante(id: 's1', fecha: DateTime(2026, 10, 8, 17), alumno: prep.alumnos().single.id, updatedAt: DateTime.now()));
    await usuarioPrep.guardarAjustes(const Ajustes(temasEstudiados: {'3.A.1'}));
    await usuarioPrep.guardarNota('3.A.1', 'Repasar Keynes');
    // El preparador es a la vez alumno de otro preparador.
    final otro = await repo(db, sesion('otro', 'Olga'));
    await prep.enlazarConCodigo((await otro.activar()).codigo!);

    await prep.romperTodosLosEnlaces();
    await usuarioPrep.borrarTodoEnLaNube();

    expect((await db.doc('codigos/$codigo').get()).exists, isFalse);
    expect((await db.doc('users/alu/preparadores/prep').get()).exists, isFalse);
    expect((await db.collection('preparadores').doc('prep').collection('alumnos').get()).docs, isEmpty);
    expect((await db.doc('preparadores/otro/alumnos/prep').get()).exists, isFalse);
    for (final c in UsuarioRepo.coleccionesUsuario) {
      expect((await db.collection('users').doc('prep').collection(c).get()).docs, isEmpty, reason: c);
    }
    // Lo del alumno sigue siendo suyo: la sesión que recibió se queda en su agenda.
    expect((await db.doc('users/alu/cantes/s1').get()).exists, isTrue);
  });

  test('directorio: modalidad y ciudad', () {
    expect(describirModalidad('ambas', ' Madrid '), 'Online y presencial en Madrid');
    expect(describirModalidad('presencial', ''), 'Presencial');
    expect(describirModalidad('online', 'Sevilla'), 'Online');
    expect(describirModalidad('', 'Sevilla'), '');
    final v = PreparadorVerificado.fromJson(const {'uid': 'p', 'nombre': 'Paula', 'modalidad': 'ambas', 'ciudad': 'Madrid'});
    expect(v.daOnline && v.daPresencial, isTrue);
    expect(PreparadorVerificado.fromJson(v.toJson()).ciudad, 'Madrid');
    final perfil = PerfilPreparador.fromJson(const PerfilPreparador().copyWith(modalidad: 'online', avisosClase: [15]).toJson());
    expect(perfil.modalidad, 'online');
    expect(perfil.avisosClase, [15]);
    expect(const PerfilPreparador().avisosClase, [PerfilPreparador.avisoVispera, 60]);
  });
}
