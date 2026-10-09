import 'dart:typed_data';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/preparador.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/data/repos/plan_repo.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';
import 'package:tcee_app/data/repos/preparador_repo.dart';
import 'package:tcee_app/data/repos/red_repo.dart';
import 'package:tcee_app/widgets/comunes.dart';

/// Red de preparadores: verificación, sustituciones, reservas, clases fijas y
/// avisos. Firestore y la sesión son simulados; las reglas (firestore.rules)
/// se prueban aparte con el emulador (tool/reglas/).
void main() {
  var n = 0;
  Future<Box> caja() => Hive.openBox('red${n++}', bytes: Uint8List(0));
  MockFirebaseAuth sesion(String uid, String nombre) => MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: uid, displayName: nombre, email: '$uid@example.org'));
  Future<PreparadorRepo> prepRepo(FakeFirebaseFirestore db, MockFirebaseAuth auth) async =>
      PreparadorRepo(alumnos: await caja(), sesiones: await caja(), perfil: await caja(), firestore: db, auth: auth);

  group('cálculos', () {
    test('clase fija: cada semana y cada quince días, desde su fecha', () {
      // Martes a las 18:00 desde el jueves 1 de octubre de 2026.
      final c = ClaseFija(id: 'c', diaSemana: 2, minutoDelDia: 18 * 60, desde: DateTime(2026, 10, 1));
      final f = c.fechasEntre(DateTime(2026, 10, 1), DateTime(2026, 10, 29));
      expect(f, [DateTime(2026, 10, 6, 18), DateTime(2026, 10, 13, 18), DateTime(2026, 10, 20, 18), DateTime(2026, 10, 27, 18)]);
      final quincena = ClaseFija(id: 'q', diaSemana: 2, minutoDelDia: 18 * 60, cadaSemanas: 2, desde: DateTime(2026, 10, 1));
      // Las fechas no dependen de desde cuándo se miren: el ritmo empieza en «desde».
      expect(quincena.fechasEntre(DateTime(2026, 10, 10), DateTime(2026, 11, 10)), [DateTime(2026, 10, 20, 18), DateTime(2026, 11, 3, 18)]);
    });

    test('huecos libres: quita los ocupados, los pedidos y los ya pasados', () {
      final h = HuecosPublicos(
        preparador: 'p',
        activo: true,
        huecos: const [Hueco(diaSemana: 2, minutoDelDia: 18 * 60), Hueco(diaSemana: 2, minutoDelDia: 19 * 60, minutos: 60)],
        ocupados: [(inicio: DateTime(2026, 10, 6, 18, 15), minutos: 30)],
      );
      final libres = h.libres(desde: DateTime(2026, 10, 5, 12), semanas: 2, pedidos: [DateTime(2026, 10, 13, 19)]);
      expect(libres, [DateTime(2026, 10, 6, 19), DateTime(2026, 10, 13, 18)]);
    });

    test('solapes entre sesiones (sin contar las canceladas)', () {
      Cante s(String id, int h, int m, {int min = 30, EstadoCante e = EstadoCante.pendiente}) => Cante(id: id, fecha: DateTime(2026, 10, 6, h, m), minutos: min, estado: e);
      final ids = sesionesSolapadas([s('a', 18, 0), s('b', 18, 15), s('c', 18, 30), s('d', 19, 0, e: EstadoCante.cancelado), s('e', 19, 10)]);
      expect(ids, {'a', 'b', 'c'});
    });

    test('teléfono para WhatsApp', () {
      expect(telefonoWhatsApp('600 12 34 56'), '34600123456');
      expect(telefonoWhatsApp('+34 600-123-456'), '34600123456');
      expect(telefonoWhatsApp('0033 6 12 34 56 78'), '33612345678');
      expect(telefonoWhatsApp('1234'), isNull);
      expect(enlaceWhatsApp('600123456', 'Hola, ¿qué tal?'), 'https://wa.me/34600123456?text=Hola%2C%20%C2%BFqu%C3%A9%20tal%3F');
    });
  });

  test('avisos: verificado, alumno conectado y clase cancelada o programada por el preparador', () async {
    final db = FakeFirebaseFirestore();
    final admin = RedRepo(firestore: db, auth: sesion('admin', 'Víctor'));
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    await db.collection('admins').doc('admin').set({'desde': 'consola'});
    await admin.verificarme(nombre: 'Víctor');
    await paula.solicitar(nombre: 'Paula', ejercicios: [3], presentacion: 'Preparo el tercero desde 2020');
    await admin.aprobar((await admin.solicitudesPendientes()).single);
    expect((await paula.avisosNuevos(vistos: {}, preparador: false)).map((a) => a.id), ['verif:tcee']);

    // Un alumno conecta con su código.
    await db.collection('preparadores').doc('paula').collection('alumnos').doc('alu').set({'uid': 'alu', 'nombre': 'Álex', 'desde': DateTime.now().toIso8601String()});
    final avisos = await paula.avisosNuevos(vistos: {'verif:tcee'}, preparador: false);
    expect(avisos.map((a) => a.id), ['enl:alu']);
    expect(avisos.single.titulo, 'Álex se ha conectado contigo');

    // Al alumno: una clase que le programa y otra que le cancela.
    final alumno = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final dentro = DateTime.now().add(const Duration(days: 2));
    Cante clase(String id, EstadoCante e) => Cante(id: id, fecha: dentro, estado: e, preparador: 'paula', preparadorNombre: 'Paula', updatedAt: DateTime.now());
    await db.collection('users').doc('alu').collection('cantes').doc('c1').set(clase('c1', EstadoCante.pendiente).toJson());
    await db.collection('users').doc('alu').collection('cantes').doc('c2').set(clase('c2', EstadoCante.cancelado).toJson());
    final delAlumno = await alumno.avisosNuevos(vistos: {}, preparador: false);
    expect(delAlumno.map((a) => a.titulo), containsAll(['Paula te ha programado una clase', 'Paula ha cancelado tu clase']));
  });

  test('verificación: se pide, la aprueba un verificado y el administrador la retira en cadena', () async {
    final db = FakeFirebaseFirestore();
    final admin = RedRepo(firestore: db, auth: sesion('admin', 'Víctor'));
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    final olga = RedRepo(firestore: db, auth: sesion('olga', 'Olga'));
    await db.collection('admins').doc('admin').set({'desde': 'consola'});

    expect(await admin.esAdmin(), isTrue);
    expect(await paula.esAdmin(), isFalse);
    await admin.verificarme(nombre: 'Víctor');
    expect((await admin.miVerificacion())!.avaladoPor, 'admin');

    // Paula lo pide y el administrador la verifica.
    await paula.solicitar(nombre: 'Paula Pérez', ejercicios: [3, 4], presentacion: 'TCEE promoción LXX, preparo el tercero');
    expect(await paula.miVerificacion(), isNull);
    expect((await paula.miSolicitud())!.presentacion, contains('promoción'));
    final pendientes = await admin.solicitudesPendientes();
    expect(pendientes.single.nombre, 'Paula Pérez');
    await admin.aprobar(pendientes.single);
    expect((await paula.miVerificacion())!.avaladoPorNombre, 'Víctor');
    expect(await paula.miSolicitud(), isNull);

    // Olga la avala Paula (red de confianza).
    await olga.solicitar(nombre: 'Olga', ejercicios: [5], presentacion: 'Preparo el quinto desde 2020');
    await paula.aprobar((await paula.solicitudesPendientes()).single);
    expect((await olga.miVerificacion())!.avaladoPor, 'paula');
    expect((await olga.verificados()).map((v) => v.nombre), ['Olga', 'Paula Pérez', 'Víctor']);

    // El administrador retira a Paula y, en cadena, a quien ella verificó.
    final v = (await admin.verificados()).firstWhere((v) => v.uid == 'paula');
    expect(await admin.cambiarActivo(v, activo: false, cascada: true), 2);
    expect(await paula.miVerificacion(), isNull);
    expect(await olga.miVerificacion(), isNull);
    expect((await admin.verificados()).map((v) => v.uid), ['admin']);
    expect((await admin.verificados(incluirRetirados: true)).length, 3);
    // Olga, retirada, la vuelve a pedir: va solo a la administración.
    await olga.solicitar(nombre: 'Olga', ejercicios: [5], presentacion: 'Otra vez');
    final re = (await olga.miSolicitud())!;
    expect(re.reverificacion, isTrue);
    expect(re.destinatario, isNull);
    expect((await db.doc('solicitudesPreparador/olga').get()).data()!['paraTodos'], isFalse);
    expect((await admin.solicitudesPendientes(admin: true)).single.reverificacion, isTrue);
    await admin.aprobar((await admin.solicitudesPendientes(admin: true)).single);
    expect((await olga.miVerificacion())!.avaladoPor, 'admin');

    await admin.cambiarActivo(v, activo: true);
    expect(await paula.miVerificacion(), isNotNull);
    // Ya verificada, no puede pedirla otra vez.
    expect(() => paula.solicitar(nombre: 'Paula', ejercicios: [3], presentacion: ''), throwsA(isA<ErrorRed>()));
  });

  test('solicitud: se reenvía cambiada, se retira, se pide tras un rechazo y vuelve a avisar', () async {
    final db = FakeFirebaseFirestore();
    final admin = RedRepo(firestore: db, auth: sesion('admin', 'Víctor'));
    final pepe = RedRepo(firestore: db, auth: sesion('pepe', 'Pepe'));
    await db.doc('admins/admin').set({'desde': 'consola'});
    expect(await pepe.solicitar(nombre: 'Pepe', ejercicios: [3], presentacion: 'Uno', modalidad: 'por carta', ciudad: 'x' * 80), isTrue);
    final primera = (await pepe.miSolicitud())!;
    expect(primera.modalidad, '', reason: 'una modalidad desconocida no se guarda (las reglas la rechazarían)');
    expect(primera.ciudad.length, 60);
    final aviso1 = (await admin.avisosNuevos(vistos: {}, preparador: false, admin: true)).single.id;
    await pepe.solicitar(nombre: 'Pepe', ejercicios: [3, 4], presentacion: 'Dos');
    expect((await pepe.miSolicitud())!.presentacion, 'Dos');
    await admin.rechazar((await admin.solicitudesPendientes(admin: true)).single);
    expect(await pepe.miSolicitud(), isNull);
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await pepe.solicitar(nombre: 'Pepe', ejercicios: [3], presentacion: 'Tres');
    final aviso2 = (await admin.avisosNuevos(vistos: {aviso1}, preparador: false, admin: true)).single.id;
    expect(aviso2, isNot(aviso1), reason: 'la nueva solicitud vuelve a avisar');
    await pepe.retirarSolicitud();
    expect(await pepe.miSolicitud(), isNull);
  });

  test('un alumno no puede enlazar con alguien que no está verificado', () async {
    final db = FakeFirebaseFirestore();
    final falso = await prepRepo(db, sesion('falso', 'Falso'));
    final alumno = await prepRepo(db, sesion('alu', 'Álex'));
    // Un código suelto (las reglas no le dejarían crearlo, pero aquí no se aplican).
    await db.collection('codigos').doc('ABCDEF').set({'uid': 'falso', 'nombre': 'Falso'});
    await falso.activar();
    expect(() => alumno.enlazarConCodigo('ABCDEF'), throwsA(isA<ErrorEnlace>().having((e) => e.mensaje, 'mensaje', contains('no está verificado'))));
  });

  test('sustitución: el alumno pide, la coge el primero y se intercambian el contacto', () async {
    final db = FakeFirebaseFirestore();
    for (final (uid, nombre) in [('paula', 'Paula'), ('olga', 'Olga')]) {
      await db.collection('preparadoresVerificados').doc(uid).set(PreparadorVerificado(uid: uid, nombre: nombre, avaladoPor: 'admin').toJson());
    }
    final alumno = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final authPaula = sesion('paula', 'Paula');
    final paula = RedRepo(firestore: db, auth: authPaula);
    final olga = RedRepo(firestore: db, auth: sesion('olga', 'Olga'));
    final cuando = DateTime.now().add(const Duration(days: 2));

    // Sin teléfono válido no se publica.
    final s = Sustitucion(id: 's1', alumno: 'alu', fecha: cuando, minutos: 30, ejercicio: 3, temas: const ['3.A.1', '3.B.2'], notas: 'Por videollamada', cante: 'c1');
    expect(() => alumno.publicarSustitucion(s, const ContactoRed(nombre: 'Álex', telefono: '12')), throwsA(isA<ErrorRed>()));
    await alumno.publicarSustitucion(s, const ContactoRed(nombre: 'Álex', telefono: '600123456'));
    // Otra solo para Olga.
    await alumno.publicarSustitucion(Sustitucion(id: 's2', alumno: 'alu', fecha: cuando, paraTodos: false, destinatarios: const ['olga'], temas: const ['3.A.1']), const ContactoRed(nombre: 'Álex', telefono: '600123456'));

    expect((await paula.tablon()).map((x) => x.id), ['s1']);
    expect((await olga.tablon()).map((x) => x.id).toSet(), {'s1', 's2'});
    expect(await alumno.tablon(), isEmpty, reason: 'las propias no salen en el tablón');

    // Avisos: Paula se entera una vez.
    final avisos = await paula.avisosNuevos(vistos: {'verif:tcee'}, preparador: true);
    expect(avisos.map((a) => a.id), ['sust:s1']);
    expect(await paula.avisosNuevos(vistos: {'verif:tcee', 'sust:s1'}, preparador: true), isEmpty);

    // Paula la coge; Olga llega tarde.
    final contactoAlumno = await paula.coger(s, const ContactoRed(nombre: 'Paula', telefono: '611222333'));
    expect(contactoAlumno.telefono, '600123456');
    expect(() => olga.coger(s, const ContactoRed(nombre: 'Olga', telefono: '622333444')), throwsA(isA<ErrorRed>()));
    expect((await olga.tablon()).map((x) => x.id), ['s2']);
    expect((await paula.cogidasPorMi()).single.id, 's1');

    // El alumno ve quién se la coge y su teléfono, y recibe el aviso.
    final mia = (await alumno.misPeticiones()).firstWhere((x) => x.id == 's1');
    expect(mia.cogida, isTrue);
    expect(mia.cogidaPorNombre, 'Paula');
    expect((await alumno.contacto('s1', 'preparador'))!.telefono, '611222333');
    expect((await alumno.avisosNuevos(vistos: {}, preparador: false)).map((a) => a.id), ['cog:s1']);
    final enAgenda = mia.canteDelAlumno();
    expect(enAgenda.id, 'sust_s1');
    expect(enAgenda.bolsa, TipoBolsa.lista);
    expect(enAgenda.temas, ['3.A.1', '3.B.2']);
    expect(enAgenda.titulo, 'Clase suelta · Paula');

    // Paula tiene al alumno (sin enlace, con teléfono) y la sesión en su semana.
    final prep = await prepRepo(db, authPaula);
    final sesion1 = await prep.sesionDeSustitucion(s, contactoAlumno);
    final a = prep.alumno(sesion1.alumno!)!;
    expect(a.nombre, 'Álex');
    expect(a.telefono, '600123456');
    expect(a.enlazado, isFalse);
    expect(prep.sesiones().single.temas, ['3.A.1', '3.B.2']);
    expect(prep.sesiones().single.sustitucion, 's1');

    // El alumno retira la otra.
    await alumno.cancelarSustitucion((await alumno.misPeticiones()).firstWhere((x) => x.id == 's2'));
    expect(await olga.tablon(), isEmpty);
  });

  test('reservas: el alumno pide un hueco y el preparador la acepta', () async {
    final db = FakeFirebaseFirestore();
    final authPrep = sesion('paula', 'Paula');
    final red = RedRepo(firestore: db, auth: authPrep);
    final alumno = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final prep = await prepRepo(db, authPrep);
    final cuando = DateTime.now().add(const Duration(days: 3));

    await red.publicarHuecos(HuecosPublicos(preparador: 'paula', nombre: 'Paula', activo: true, huecos: [Hueco(diaSemana: cuando.weekday, minutoDelDia: 18 * 60)]));
    final h = await alumno.huecosDe('paula');
    expect(h!.activo, isTrue);
    final libre = h.libres(desde: DateTime.now(), semanas: 1).single;

    await alumno.pedirReserva(Reserva(id: 'r1', preparador: 'paula', alumno: 'alu', alumnoNombre: 'Álex', fecha: libre, nota: 'El 3.A.7'));
    final recibida = (await red.reservasRecibidas()).single;
    expect((await red.avisosNuevos(vistos: {}, preparador: true)).map((a) => a.id), ['res:r1']);

    final s = await prep.sesionDeReserva(recibida);
    await red.cambiarReserva(recibida, EstadoReserva.aceptada);
    expect(s.fecha, libre);
    expect(prep.alumnoConUid('alu')!.nombre, 'Álex');
    expect((await alumno.misReservas()).single.estado, EstadoReserva.aceptada);
    expect((await alumno.avisosNuevos(vistos: {}, preparador: false)).map((a) => a.id), ['resp:r1:aceptada']);
  });

  test('clases fijas: generan las sesiones sin duplicar ni resucitar las borradas', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    final hoy = DateTime(2026, 10, 1, 9);
    final clase = ClaseFija(id: 'c1', diaSemana: 2, minutoDelDia: 18 * 60, minutos: 45, desde: hoy);
    await prep.guardarAlumno(Alumno(id: 'lucia', nombre: 'Lucía', clasesFijas: [clase], updatedAt: DateTime.now()));

    expect(await prep.generarClasesFijas(ahora: hoy), 6);
    expect(await prep.generarClasesFijas(ahora: hoy), 0);
    final primera = prep.sesiones().first;
    expect(primera.fecha, DateTime(2026, 10, 6, 18));
    expect(primera.minutos, 45);
    expect(primera.alumno, 'lucia');

    // Una que se borra no vuelve a salir.
    await prep.borrarSesion(primera);
    expect(await prep.generarClasesFijas(ahora: hoy), 0);
    expect(prep.sesiones().length, 5);

    // Al quitar la clase fija se van sus sesiones futuras.
    await prep.quitarClaseFija(prep.alumno('lucia')!, clase, ahora: hoy);
    expect(prep.sesiones(), isEmpty);
    expect(prep.alumno('lucia')!.clasesFijas, isEmpty);
  });

  test('solicitud dirigida: solo la ve y la recibe ese preparador (y el administrador)', () async {
    final db = FakeFirebaseFirestore();
    await db.collection('admins').doc('admin').set({'x': 1});
    for (final (uid, nombre) in [('paula', 'Paula'), ('olga', 'Olga')]) {
      await db.collection('preparadoresVerificados').doc(uid).set(PreparadorVerificado(uid: uid, nombre: nombre, avaladoPor: 'admin').toJson());
    }
    final admin = RedRepo(firestore: db, auth: sesion('admin', 'Víctor'));
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    final olga = RedRepo(firestore: db, auth: sesion('olga', 'Olga'));
    final nuevo = RedRepo(firestore: db, auth: sesion('nuevo', 'Nuevo'));
    final abierto = RedRepo(firestore: db, auth: sesion('abierto', 'Abierto'));

    await nuevo.solicitar(nombre: 'Nuevo', ejercicios: [1], presentacion: 'Preparo el dictamen de coyuntura', destinatario: 'olga', destinatarioNombre: 'Olga');
    await abierto.solicitar(nombre: 'Abierto', ejercicios: [3], presentacion: 'Preparo el tercero desde 2021');
    expect((await nuevo.miSolicitud())!.destinatarioNombre, 'Olga');

    expect((await paula.solicitudesPendientes()).map((s) => s.uid), ['abierto']);
    expect((await olga.solicitudesPendientes()).map((s) => s.uid).toSet(), {'nuevo', 'abierto'});
    expect((await admin.solicitudesPendientes(admin: true)).map((s) => s.uid).toSet(), {'nuevo', 'abierto'});

    // Avisos: la dirigida, solo a Olga; la abierta, solo al administrador.
    expect((await olga.avisosNuevos(vistos: {}, preparador: true)).map((a) => a.id.split(':').take(2).join(':')), ['verif:tcee', 'sol:nuevo']);
    expect(await paula.avisosNuevos(vistos: {'verif:tcee'}, preparador: true), isEmpty);
    expect((await admin.avisosNuevos(vistos: {}, preparador: false, admin: true)).map((a) => a.id.split(':').take(2).join(':')), ['sol:abierto']);

    await olga.aprobar((await olga.solicitudesPendientes()).firstWhere((s) => s.uid == 'nuevo'));
    expect((await nuevo.miVerificacion())!.ejercicios, [1]);
    expect(describirEjercicios([1, 3]), '1.º (coyuntura), 3.º');
  });

  test('materiales: el preparador los comparte y los ve el alumno al que van', () async {
    final db = FakeFirebaseFirestore();
    await db.collection('preparadoresVerificados').doc('paula').set(PreparadorVerificado(uid: 'paula', nombre: 'Paula', avaladoPor: 'admin').toJson());
    await db.doc('users/alu/preparadores/paula').set({'uid': 'paula'});
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    final alu = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final otro = RedRepo(firestore: db, auth: sesion('otro', 'Otro'));
    await paula.guardarMaterial(const MaterialCompartido(id: 'm1', preparador: 'paula', preparadorNombre: 'Paula', titulo: 'Esquemas', url: 'https://drive.google.com/x', tema: '3.A.1'));
    await paula.guardarMaterial(const MaterialCompartido(id: 'm2', preparador: 'paula', preparadorNombre: 'Paula', titulo: 'Para Álex', url: 'https://ejemplo.org/a.pdf', paraTodos: false, alumnos: ['alu']));
    await paula.guardarMaterial(const MaterialCompartido(id: 'm3', preparador: 'paula', preparadorNombre: 'Paula', titulo: 'Para otro', url: 'https://ejemplo.org/b.pdf', paraTodos: false, alumnos: ['otro']));
    expect((await paula.misMateriales()).length, 3);
    expect((await alu.materialesDe('paula')).map((m) => m.id).toSet(), {'m1', 'm2'});
    expect((await otro.materialesDe('paula')).map((m) => m.id).toSet(), {'m1', 'm3'});
    // Con los vínculos de la nube (como la tarea en segundo plano) y con los locales.
    expect((await alu.materialesParaMi()).length, 2);
    expect((await alu.materialesParaMi(preparadores: ['paula'])).length, 2);
    // El aviso llega una vez.
    final avisos = await alu.avisosNuevos(vistos: {}, preparador: false);
    expect(avisos.where((a) => a.id.startsWith('mat:')).map((a) => a.id).toSet(), {'mat:m1', 'mat:m2'});
    expect(avisos.firstWhere((a) => a.id == 'mat:m1').ruta, '/mas/mi-preparador');
    expect((await alu.avisosNuevos(vistos: {'mat:m1', 'mat:m2'}, preparador: false)).where((a) => a.id.startsWith('mat:')), isEmpty);
    // Tipo y dominio por el enlace; enlaces válidos.
    final m = (await alu.materialesDe('paula')).firstWhere((m) => m.id == 'm1');
    expect(m.tipo, TipoMaterial.drive);
    expect(m.dominio, 'drive.google.com');
    expect(MaterialCompartido.fromJson(m.toJson()).alumnos, isEmpty);
    expect(enlaceMaterial('drive.google.com/file/d/1'), 'https://drive.google.com/file/d/1');
    expect(enlaceMaterial('javascript:alert(1)'), isNull);
    expect(enlaceMaterial('hola'), isNull);
    // Al borrar la cuenta se van con ella.
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.romperTodosLosEnlaces();
    expect((await db.collection('materiales').get()).docs, isEmpty);
  });

  test('clase movida o cancelada por el preparador: el alumno recibe el aviso que toca', () async {
    final db = FakeFirebaseFirestore();
    final alu = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final f = DateTime.now().add(const Duration(days: 3));
    Future<void> clase(DateTime fecha, {String estado = 'pendiente'}) =>
        db.doc('users/alu/cantes/c1').set({'id': 'c1', 'fecha': fecha.toIso8601String(), 'preparador': 'paula', 'preparadorNombre': 'Paula', 'estado': estado, 'updatedAt': DateTime.now().toIso8601String()});
    await clase(f);
    var avisos = await alu.avisosNuevos(vistos: {}, preparador: false);
    expect(avisos.single.id, 'prog:c1:${f.toIso8601String()}');
    expect(avisos.single.ruta, '/cantes?cante=c1');
    // La mueve: ya se había avisado de esa clase, así que es un cambio de hora.
    final vistos = {avisos.single.id};
    final f2 = f.add(const Duration(hours: 2));
    await clase(f2);
    avisos = await alu.avisosNuevos(vistos: vistos, preparador: false);
    expect(avisos.single.id, 'mov:c1:${f2.toIso8601String()}');
    expect(avisos.single.titulo, contains('ha movido'));
    vistos.add(avisos.single.id);
    await clase(f2, estado: 'cancelado');
    avisos = await alu.avisosNuevos(vistos: vistos, preparador: false);
    expect(avisos.single.id, 'canc:c1');
  });

  test('el alumno cancela una clase del preparador: le llega cancelada, con aviso, y no se le avisa a él mismo', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await db.collection('preparadoresVerificados').doc('paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula', avaladoPor: 'admin').toJson());
    await prep.activar(nombre: 'Paula');
    await db.doc('preparadores/paula/alumnos/alu').set({'uid': 'alu', 'nombre': 'Álex'});
    await prep.sincronizarTodo();
    final cuando = DateTime.now().add(const Duration(days: 2));
    await prep.guardarSesion(Cante(id: 'c1', fecha: cuando, alumno: 'alu', updatedAt: DateTime.now()));
    expect((await db.doc('users/alu/cantes/c1').get()).data()!['estado'], 'pendiente');
    // El alumno la cancela en su agenda.
    final copia = Cante.fromJson({...(await db.doc('users/alu/cantes/c1').get()).data()!, 'id': 'c1'});
    await Future<void>.delayed(const Duration(milliseconds: 5));
    final cancelada = copia.copyWith(estado: EstadoCante.cancelado, motivo: 'Estoy enfermo', canceladoPor: 'alu');
    await db.doc('users/alu/cantes/c1').set(cancelada.toJson());
    expect((await RedRepo(firestore: db, auth: sesion('alu', 'Álex')).avisosNuevos(vistos: {}, preparador: false)).where((a) => a.id.startsWith('canc:')), isEmpty);
    await prep.sincronizarTodo();
    final mia = prep.sesiones().singleWhere((s) => s.id == 'c1');
    expect(mia.cancelado, isTrue);
    expect(mia.canceladoPor, 'alu');
    expect(mia.motivo, 'Estoy enfermo');
    expect(prep.canceladasPorAlumnos.single.alumno, 'Álex');

    // El alumno la quita de su agenda: el preparador la conserva, pero no se la vuelve a mandar.
    prep.canceladasPorAlumnos.clear();
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await db.doc('users/alu/cantes/c1').set(cancelada.copyWith(borrado: true).toJson());
    await prep.sincronizarTodo();
    final oculta = prep.sesiones().singleWhere((s) => s.id == 'c1');
    expect(oculta.ocultaAlAlumno, isTrue);
    expect(oculta.borrado, isFalse);
    await prep.guardarSesion(oculta.copyWith(notas: 'otra cosa'));
    expect((await db.doc('users/alu/cantes/c1').get()).data()!['borrado'], isTrue);
  });

  test('el alumno deja de compartir: sus clases pendientes quedan canceladas en la agenda del preparador', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await db.collection('preparadoresVerificados').doc('paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula', avaladoPor: 'admin').toJson());
    await prep.activar(nombre: 'Paula');
    await db.doc('preparadores/paula/alumnos/alu').set({'uid': 'alu', 'nombre': 'Álex'});
    await prep.sincronizarTodo();
    await prep.guardarSesion(Cante(id: 'c2', fecha: DateTime.now().add(const Duration(days: 3)), alumno: 'alu', updatedAt: DateTime.now()));
    await db.doc('preparadores/paula/alumnos/alu').delete();
    await prep.sincronizarTodo();
    final c = prep.sesiones().singleWhere((s) => s.id == 'c2');
    expect(c.cancelado, isTrue);
    expect(c.canceladoPor, 'alu');
  });

  test('el preparador quita a un alumno de clase suelta: se cancela lo pendiente y sale de su semana', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.activar(nombre: 'Paula');
    final cuando = DateTime.now().add(const Duration(days: 2));
    final s = Sustitucion(id: 's6', alumno: 'luis', fecha: cuando, estado: EstadoSustitucion.cogida, cogidaPor: 'paula', cogidaPorNombre: 'Paula');
    final clase = await prep.sesionDeSustitucion(s, const ContactoRed(nombre: 'Luis', telefono: '600111222'));
    await prep.olvidarAlumnoSuelto(prep.alumno(clase.alumno!)!);
    expect(prep.sesiones(), isEmpty);
    expect(prep.alumnos(), isEmpty);
    expect((await db.doc('users/luis/cantes/sust_s6').get()).data()!['estado'], 'cancelado');
    // No vuelve a aparecer al sincronizar.
    await db.doc('sustituciones/s6').set({'id': 's6', 'alumno': 'luis', 'estado': 'cogida', 'cogidaPor': 'paula', 'fecha': cuando.toIso8601String()});
    await prep.sincronizarTodo();
    expect(prep.sesiones(), isEmpty);
  });

  test('el alumno quita al preparador de sus clases sueltas: se borran esas peticiones', () async {
    final db = FakeFirebaseFirestore();
    final alu = RedRepo(firestore: db, auth: sesion('luis', 'Luis'));
    await db.doc('sustituciones/s1').set({'id': 's1', 'alumno': 'luis', 'estado': 'cogida', 'cogidaPor': 'paula', 'fecha': DateTime.now().toIso8601String()});
    await db.doc('sustituciones/s2').set({'id': 's2', 'alumno': 'luis', 'estado': 'cogida', 'cogidaPor': 'olga', 'fecha': DateTime.now().toIso8601String()});
    expect(await alu.olvidarSustituto('paula'), 1);
    expect((await db.doc('sustituciones/s1').get()).exists, isFalse);
    expect((await db.doc('sustituciones/s2').get()).exists, isTrue);
  });

  test('varios temas cantados: se guardan aparte y cuentan en las estadísticas de cada uno', () {
    const r = ResultadoCante(sorteados: ['3.A.1', '3.B.2'], temaCantado: '3.A.1', otrosCantados: ['3.B.2'], valoracion: 4);
    final j = r.toJson();
    expect(j['temaCantado'], '3.A.1', reason: 'las versiones anteriores siguen leyendo el primero');
    expect(ResultadoCante.fromJson(j).temasCantados, ['3.A.1', '3.B.2']);
    final stats = EstadisticaTema.desde([Cante(id: 'x', fecha: DateTime(2026, 10, 1), estado: EstadoCante.hecho, resultado: r)]);
    expect(stats.keys, containsAll(['3.A.1', '3.B.2']));
    expect(const ResultadoCante(temaCantado: '3.A.1').toJson().containsKey('otrosCantados'), isFalse);
  });

  test('clase suelta cogida: el alumno queda con uid (suelto) y los cambios le llegan', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.activar(nombre: 'Paula');
    final cuando = DateTime.now().add(const Duration(days: 2));
    final s = Sustitucion(id: 's9', alumno: 'luis', fecha: cuando, estado: EstadoSustitucion.cogida, cogidaPor: 'paula', cogidaPorNombre: 'Paula', temas: const ['3.A.1']);
    final clase = await prep.sesionDeSustitucion(s, const ContactoRed(nombre: 'Luis', telefono: '600111222'));
    final a = prep.alumno(clase.alumno!)!;
    expect(a.uid, 'luis');
    expect(a.suelto, isTrue);
    expect(a.enlazado, isFalse);
    expect(clase.minutos, PerfilPreparador.minutosClasePorDefecto);
    // La copia va a la agenda del alumno, firmada por la sustituta.
    final copia = (await db.doc('users/luis/cantes/sust_s9').get()).data()!;
    expect(copia['preparador'], 'paula');
    expect(copia['sustitucion'], 's9');
    expect(prep.estadoCopia(clase.id), EstadoCopia.enviada);
    // Un cambio de hora también.
    final nueva = cuando.add(const Duration(hours: 1));
    await prep.guardarSesion(clase.copyWith(fecha: nueva));
    expect((await db.doc('users/luis/cantes/sust_s9').get()).data()!['fecha'], nueva.toIso8601String());
    // En el lado del alumno, el cante de la clase suelta lleva al sustituto.
    final enAgenda = s.canteDelAlumno();
    expect(enAgenda.preparador, 'paula');
    expect(enAgenda.dePreparador, isTrue);
  });

  test('clase suelta: el alumno no pasa a «Mis alumnos» ni toca una ficha apuntada a mano', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.activar(nombre: 'Paula');
    // Ficha a mano con el mismo teléfono que el alumno de la clase suelta.
    await prep.guardarAlumno(Alumno(id: 'mano', nombre: 'Luis (a mano)', telefono: '600 111 222', creado: DateTime.now(), updatedAt: DateTime.now()));
    final cuando = DateTime.now().add(const Duration(days: 2));
    final s = Sustitucion(id: 's7', alumno: 'luis', fecha: cuando, estado: EstadoSustitucion.cogida, cogidaPor: 'paula', cogidaPorNombre: 'Paula', temas: const ['3.A.1']);
    final clase = await prep.sesionDeSustitucion(s, const ContactoRed(nombre: 'Luis', telefono: '600111222'));
    expect(clase.alumno, 'sust_s7');
    expect(prep.misAlumnos().map((a) => a.id), ['mano']);
    final mano = prep.alumno('mano')!;
    expect(mano.uid, isNull);
    expect(mano.suelto, isFalse);
    // Otra clase suelta del mismo alumno va a la misma ficha suelta.
    final s2 = Sustitucion(id: 's8', alumno: 'luis', fecha: cuando.add(const Duration(days: 7)), estado: EstadoSustitucion.cogida, cogidaPor: 'paula', cogidaPorNombre: 'Paula');
    expect((await prep.sesionDeSustitucion(s2, const ContactoRed(nombre: 'Luis', telefono: '600111222'))).alumno, 'sust_s7');
    expect(prep.alumnos().where((a) => a.suelto).length, 1);
    // Las clases fijas no se generan para fichas sueltas.
    await prep.guardarAlumno(prep.alumno('sust_s7')!.copyWith(clasesFijas: [ClaseFija(id: 'c', diaSemana: 2, minutoDelDia: 18 * 60, desde: DateTime.now())]));
    expect(await prep.generarClasesFijas(), 0);
    // Solo si escribe el código pasa a ser alumno suyo (enlazado).
    await db.doc('preparadores/paula/alumnos/luis').set({'uid': 'luis', 'nombre': 'Luis'});
    await prep.sincronizarTodo();
    expect(prep.alumno('sust_s7')!.enlazado, isTrue);
    expect(prep.misAlumnos().map((a) => a.id), containsAll(['mano', 'sust_s7']));
  });

  test('clase suelta: una versión antigua no le quita el alumno, y si se lo quitó, se recupera', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.activar(nombre: 'Paula');
    final cuando = DateTime.now().add(const Duration(days: 2));
    await db.doc('sustituciones/s3').set({'id': 's3', 'alumno': 'luis', 'estado': 'cogida', 'cogidaPor': 'paula', 'fecha': cuando.toIso8601String()});
    final s = Sustitucion(id: 's3', alumno: 'luis', fecha: cuando, estado: EstadoSustitucion.cogida, cogidaPor: 'paula', cogidaPorNombre: 'Paula');
    final clase = await prep.sesionDeSustitucion(s, const ContactoRed(nombre: 'Luis', telefono: '600111222'));
    // En la nube, en su propia colección (las versiones antiguas no la leen).
    expect((await db.doc('users/paula/alumnosSueltos/sust_s3').get()).exists, isTrue);
    expect((await db.doc('users/paula/alumnos/sust_s3').get()).exists, isFalse);

    // Una versión antigua sube a «alumnos» la ficha sin uid y más reciente.
    final viejo = {...prep.alumno('sust_s3')!.toJson(), 'uid': null, 'updatedAt': DateTime.now().add(const Duration(minutes: 5)).toIso8601String()}..remove('suelto');
    await db.doc('users/paula/alumnos/sust_s3').set(viejo);
    await prep.sincronizarTodo();
    expect(prep.alumno('sust_s3')!.uid, 'luis');
    expect((await db.doc('users/paula/alumnos/sust_s3').get()).exists, isFalse, reason: 'la copia de la versión antigua se borra');

    // Un dispositivo nuevo que solo encuentra la copia estropeada: la clase
    // suelta recupera al alumno desde la sustitución.
    await db.doc('users/paula/alumnosSueltos/sust_s3').delete();
    await db.doc('users/paula/alumnos/sust_s3').set(viejo);
    final otro = await prepRepo(db, sesion('paula', 'Paula'));
    await otro.sincronizarTodo();
    expect(otro.alumno(clase.alumno!)!.uid, 'luis');
    expect(otro.alumno(clase.alumno!)!.suelto, isTrue);
    expect(otro.misAlumnos(), isEmpty);
    expect((await db.doc('users/luis/cantes/sust_s3').get()).data()!['preparador'], 'paula');
  });

  test('clase suelta: se separa la ficha a mano que la 1.15.3 convirtió en suelta', () async {
    final db = FakeFirebaseFirestore();
    final prep = await prepRepo(db, sesion('paula', 'Paula'));
    await prep.activar(nombre: 'Paula');
    await prep.guardarAlumno(Alumno(id: 'mano', nombre: 'Luis', telefono: '600111222', uid: 'luis', suelto: true, notas: 'Lleva 40 temas', creado: DateTime.now(), updatedAt: DateTime.now()));
    await prep.guardarSesion(Cante(id: 'sust_s5', fecha: DateTime.now().add(const Duration(days: 1)), alumno: 'mano', sustitucion: 's5', titulo: 'Clase suelta', updatedAt: DateTime.now()));
    await prep.guardarSesion(Cante(id: 'propia', fecha: DateTime.now().add(const Duration(days: 3)), alumno: 'mano', updatedAt: DateTime.now()));
    await prep.sincronizarTodo();
    final mano = prep.alumno('mano')!;
    expect(mano.suelto, isFalse);
    expect(mano.uid, isNull);
    expect(mano.notas, 'Lleva 40 temas');
    expect(prep.misAlumnos().map((a) => a.id), ['mano']);
    final suelta = prep.alumno('sust_s5')!;
    expect(suelta.uid, 'luis');
    expect(suelta.suelto, isTrue);
    expect(prep.sesiones().firstWhere((x) => x.id == 'sust_s5').alumno, 'sust_s5');
    expect(prep.sesiones().firstWhere((x) => x.id == 'propia').alumno, 'mano');
  });

  test('buscar preparador: compatibilidad entre lo que busca el opositor y la ficha y las plazas del preparador', () {
    final b = Busqueda(id: 'b', alumno: 'alu', ejercicios: const [3], modalidad: Modalidad.online, disponibilidad: const ['2-t', '4-t'], desde: null);
    const paula = PreparadorVerificado(uid: 'paula', nombre: 'Paula', ejercicios: [3, 4], modalidad: 'online');
    const olga = PreparadorVerificado(uid: 'olga', nombre: 'Olga', ejercicios: [4], modalidad: 'online');
    const luis = PreparadorVerificado(uid: 'luis', nombre: 'Luis', ejercicios: [3], modalidad: 'presencial', ciudad: 'Sevilla');
    expect(compatibilidad(b, olga), 0, reason: 'no prepara el 3.º');
    expect(compatibilidad(b, luis), 0, reason: 'solo presencial y el opositor quiere online');
    expect(compatibilidad(b, paula), 40 + 25 + 17, reason: 'sin plazas no se sabe la disponibilidad');
    expect(compatibilidad(b, paula, plazas: const Plazas(preparador: 'paula', admite: true, disponibilidad: ['2-t', '3-t'])), 40 + 25 + 18, reason: 'un tramo de dos en común');
    expect(compatibilidad(b, paula, plazas: const Plazas(preparador: 'paula', admite: true, disponibilidad: ['2-t', '4-t'])), 100);
    // Empieza mucho después de lo que quiere el opositor: resta.
    final dentroDe4Meses = DateTime.now().add(const Duration(days: 120));
    expect(compatibilidad(b, paula, plazas: Plazas(preparador: 'paula', admite: true, disponibilidad: const ['2-t', '4-t'], desde: dentroDe4Meses)), 85);
    // Si el opositor también empieza entonces, no resta.
    expect(compatibilidad(b.copyWith(desde: dentroDe4Meses), paula, plazas: Plazas(preparador: 'paula', admite: true, disponibilidad: const ['2-t', '4-t'], desde: dentroDe4Meses)), 100);
    // Presencial en la misma ciudad (sin distinguir mayúsculas) encaja; en otra, no.
    final sevilla = b.copyWith(modalidad: Modalidad.presencial, ciudad: 'sevilla');
    expect(compatibilidad(sevilla, luis), greaterThan(0));
    expect(compatibilidad(sevilla.copyWith(ciudad: 'Madrid'), luis), 0);
    expect(describirDisponibilidad(['2-t', '4-t', '1-m']), 'lunes por la mañana; martes y jueves por la tarde');
    expect(b.descripcion, '3.º · Online · 1 clase por semana');
  });

  test('buscar preparador: el opositor publica sin nombre, el preparador se interesa y deja su contacto; plazas', () async {
    final db = FakeFirebaseFirestore();
    await db.collection('preparadoresVerificados').doc('paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula', ejercicios: [3], modalidad: 'online', avaladoPor: 'admin').toJson());
    final alu = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    final b = Busqueda(id: 'b1', alumno: 'alu', ejercicios: const [3], modalidad: Modalidad.online, disponibilidad: const ['2-t'], creada: DateTime.now());
    await alu.guardarBusqueda(b);
    expect((await db.doc('busquedas/b1').get()).data()!.containsKey('nombre'), isFalse);
    expect((await alu.misBusquedas()).single.abierta, isTrue);
    expect((await paula.busquedasAbiertas()).single.id, 'b1');
    expect((await alu.busquedasAbiertas()), isEmpty, reason: 'las propias no salen');
    // Aviso al preparador, una vez.
    final avisosPaula = await paula.avisosNuevos(vistos: {}, preparador: true);
    expect(avisosPaula.where((a) => a.id == 'busq:b1').single.ruta, '/busquedas');
    // Le interesa: deja su contacto; el opositor lo ve y recibe el aviso.
    await paula.interesarme('b1', Interesado(uid: 'paula', nombre: 'Paula', telefono: '611222333', mensaje: 'Tengo hueco los martes', creado: DateTime.now()));
    expect(await paula.misIntereses(['b1']), {'b1'});
    final interesados = await alu.interesados('b1');
    expect(interesados.single.telefono, '611222333');
    final avisosAlu = await alu.avisosNuevos(vistos: {}, preparador: false);
    expect(avisosAlu.where((a) => a.id == 'int:b1:paula').single.ruta, '/buscar-preparador');
    expect((await alu.avisosNuevos(vistos: {'int:b1:paula'}, preparador: false)).where((a) => a.id.startsWith('int:')), isEmpty);
    await paula.retirarInteres('b1');
    expect(await alu.interesados('b1'), isEmpty);
    // Cerrada, deja de verse en el tablón.
    await alu.guardarBusqueda(b.copyWith(estado: 'cerrada'));
    expect(await paula.busquedasAbiertas(), isEmpty);
    // Plazas: las publica el preparador y las ven los opositores.
    await paula.guardarPlazas(const Plazas(preparador: 'paula', admite: true, disponibilidad: ['2-t'], telefono: '611222333'));
    expect((await paula.misPlazas())!.admite, isTrue);
    expect((await alu.plazasAbiertas()).single.preparador, 'paula');
    await paula.guardarPlazas((await paula.misPlazas())!.copyWith(admite: false));
    expect(await alu.plazasAbiertas(), isEmpty);
  });

  test('primer ejercicio: el cante es un dictamen de coyuntura, sin temas', () {
    final s = Sustitucion(id: 'c', alumno: 'a', fecha: DateTime(2026, 11, 3, 18), ejercicio: 1);
    expect(s.coyuntura, isTrue);
    expect(s.descripcion, 'Dictamen de coyuntura (1.er ejercicio)');
    expect(s.canteDelAlumno(nombreSustituto: 'Olga').ejercicio, 1);
    expect(ejerciciosConCante, [1, 3, 4]);
  });

  test('franja de horas: quien coge el cante elige la hora dentro de ella', () async {
    final db = FakeFirebaseFirestore();
    await db.collection('preparadoresVerificados').doc('paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula', avaladoPor: 'admin').toJson());
    final alumno = RedRepo(firestore: db, auth: sesion('alu', 'Álex'));
    final paula = RedRepo(firestore: db, auth: sesion('paula', 'Paula'));
    final dia = DateTime.now().add(const Duration(days: 3));
    final desde = DateTime(dia.year, dia.month, dia.day, 16), hasta = DateTime(dia.year, dia.month, dia.day, 21);
    final s = Sustitucion(id: 'f1', alumno: 'alu', fecha: desde, hasta: hasta, temas: const ['3.A.4']);
    expect(s.conFranja, isTrue);
    expect(horasDe(s), 'de 16:00 a 21:00');
    await alumno.publicarSustitucion(s, const ContactoRed(nombre: 'Álex', telefono: '600123456'));

    expect(() => paula.coger(s, const ContactoRed(nombre: 'Paula', telefono: '611222333'), hora: DateTime(dia.year, dia.month, dia.day, 22)), throwsA(isA<ErrorRed>()));
    await paula.coger(s, const ContactoRed(nombre: 'Paula', telefono: '611222333'), hora: DateTime(dia.year, dia.month, dia.day, 18, 30));
    final cogida = (await alumno.misPeticiones()).single;
    expect(cogida.hora, DateTime(dia.year, dia.month, dia.day, 18, 30));
    expect(horasDe(cogida), 'a las 18:30');
    expect(cogida.canteDelAlumno().fecha, DateTime(dia.year, dia.month, dia.day, 18, 30));
  });

  test('el administrador se reconoce por su uid o por su correo de Google', () async {
    final db = FakeFirebaseFirestore();
    await db.collection('admins').doc('jefe@example.org').set({'x': 1});
    final porCorreo = RedRepo(firestore: db, auth: MockFirebaseAuth(signedIn: true, mockUser: MockUser(uid: 'u1', displayName: 'Jefe', email: 'Jefe@Example.org')));
    final otro = RedRepo(firestore: db, auth: sesion('u2', 'Otro'));
    expect(await porCorreo.esAdmin(), isTrue);
    expect(await otro.esAdmin(), isFalse);
    await porCorreo.verificarme(nombre: 'Jefe');
    expect((await porCorreo.miVerificacion())!.avaladoPorNombre, 'Jefe');
  });

  test('avatar: la foto de Google, con buen tamaño, también si solo la trae el proveedor', () {
    expect(AvatarUsuario.fotoDe(MockUser(uid: 'a', photoURL: 'https://lh3.googleusercontent.com/a/xyz=s96-c')), 'https://lh3.googleusercontent.com/a/xyz=s256-c');
    expect(AvatarUsuario.fotoDe(MockUser(uid: 'b', photoURL: '')), isNull);
    expect(AvatarUsuario.fotoDe(null), isNull);
  });

  test('LinkedIn: enlace canónico, en la solicitud y luego en el directorio', () async {
    expect(enlaceLinkedin('linkedin.com/in/paula-perez/'), 'https://www.linkedin.com/in/paula-perez');
    expect(enlaceLinkedin('https://es.linkedin.com/in/paula?trk=x'), 'https://www.linkedin.com/in/paula');
    expect(enlaceLinkedin('https://ejemplo.com/in/paula'), isNull);
    final db = FakeFirebaseFirestore();
    await db.collection('admins').doc('admin').set({'x': 1});
    final admin = RedRepo(firestore: db, auth: sesion('admin', 'Víctor'));
    final nuevo = RedRepo(firestore: db, auth: sesion('nuevo', 'Nuevo'));
    await nuevo.solicitar(nombre: 'Nuevo', ejercicios: [3], presentacion: 'Preparo el tercero desde 2021', linkedin: 'linkedin.com/in/nuevo');
    await admin.aprobar((await admin.solicitudesPendientes(admin: true)).single);
    expect((await admin.verificados()).firstWhere((v) => v.uid == 'nuevo').linkedin, 'https://www.linkedin.com/in/nuevo');
    await nuevo.actualizarMiFicha(linkedin: 'https://www.linkedin.com/in/otro/');
    expect((await nuevo.miVerificacion())!.linkedin, 'https://www.linkedin.com/in/otro');
  });

  test('cronograma compartido: el preparador lo ve, propone y el alumno acepta', () async {
    final db = FakeFirebaseFirestore();
    final authAlu = sesion('alu', 'Álex'), authPrep = sesion('paula', 'Paula');
    await db.collection('preparadoresVerificados').doc('paula').set(const PreparadorVerificado(uid: 'paula', nombre: 'Paula', avaladoPor: 'admin').toJson());
    final planAlu = PlanRepo(cantes: await caja(), plan: await caja(), agenda: await caja(), cronogramas: await caja(), firestore: db, auth: authAlu);
    final prep = await prepRepo(db, authPrep);
    final alumno = await prepRepo(db, authAlu);
    await alumno.enlazarConCodigo((await prep.activar()).codigo!);
    await prep.sincronizarTodo();
    final a = prep.alumnos().single;

    final c = crearCronograma(id: 'c1', ejercicio: 3, temas: [for (var i = 1; i <= 9; i++) '3.A.$i'], inicio: DateTime.now(), porSemana: 3);
    await planAlu.empezarCronograma(c);
    expect(await prep.cronogramaDe(a), isNull, reason: 'sin compartir no lo ve');
    await planAlu.guardarCronograma(c.copyWith(compartir: true));
    final visto = (await prep.cronogramaDe(a))!;
    expect(visto.temas.length, 9);

    await Future<void>.delayed(const Duration(milliseconds: 5));
    final orden = visto.temas.reversed.toList();
    await prep.proponerCambios(a, visto, PropuestaCronograma(de: 'paula', nombre: 'Paula', fecha: DateTime.now(), nota: 'Mejor al revés', temas: orden, temasPorSemana: 2));
    await planAlu.sincronizarCronogramas();
    final conPropuesta = planAlu.cronogramaActivo()!;
    expect(conPropuesta.propuesta!.nota, 'Mejor al revés');
    expect(conPropuesta.compartir, isTrue);

    // Solo uno activo: empezar otro archiva el anterior.
    await planAlu.empezarCronograma(crearCronograma(id: 'c2', ejercicio: 4, temas: const ['4.A.1'], inicio: DateTime.now()));
    expect(planAlu.cronogramaActivo()!.id, 'c2');
    expect(planAlu.cronogramas().firstWhere((x) => x.id == 'c1').archivado, isTrue);
    expect(await prep.cronogramaDe(a), isNull, reason: 'los archivados no se muestran');
  });
}
