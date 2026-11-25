// Tiempo de esquema en los avisos de una clase (fallo visto en una clase el
// 25 nov.): la clase se había puesto con 30' de esquema y el cronómetro dio
// 30', pero la notificación de los temas decía 22'30" (el del examen para un
// tema) y su cuenta atrás no bajaba.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tcee_app/core/notificaciones.dart';
import 'package:tcee_app/core/temas_anticipados.dart';
import 'package:tcee_app/data/models/oposicion.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/features/cantar/esquema_clase.dart';
import 'package:tcee_app/features/cantar/reloj_cante.dart';
import 'package:tcee_app/features/cantar/relojes_alumnos.dart';
import 'package:tcee_app/features/preparador/tema_anticipado.dart';

void main() {
  final llegada = DateTime(2026, 11, 25, 17);
  setUpAll(() => initializeDateFormatting('es'));

  group('tiempo de esquema de la clase', () {
    test('manda el del cronómetro de la clase; si no, el de la clase; si no, el del examen', () {
      expect(segundosEsquemaVigente(reloj: {'esquema': 1800}, deLaClase: 1500, delExamen: 1350), 1800);
      expect(segundosEsquemaVigente(reloj: {'esquema': 0}, deLaClase: 1500, delExamen: 1350), 0); // sin esquema
      expect(segundosEsquemaVigente(reloj: null, deLaClase: 1800, delExamen: 1350), 1800);
      expect(segundosEsquemaVigente(reloj: {'otra': 1}, delExamen: 1350), 1350);
    });

    test('la clase guarda su esquema y lo usa; sin él, el del examen', () {
      final c = Cante(id: 'c', fecha: llegada, ejercicio: 3, temasMandados: const ['3.A.1'], temaA: llegada);
      expect(c.segundosDeEsquema(), 1350); // 22'30" para un tema de TCEE
      final con = c.copyWith(segundosEsquema: 1800);
      expect(con.segundosDeEsquema(), 1800);
      expect(Cante.fromJson(con.toJson()).segundosEsquema, 1800);
      expect(c.toJson().containsKey('segundosEsquema'), isFalse);
    });

    test('mensaje de WhatsApp con el esquema de la clase', () {
      final c = Cante(id: 'c', fecha: llegada.add(const Duration(minutes: 30)), ejercicio: 3, temasMandados: const ['3.A.1'], temaA: llegada, segundosEsquema: 1800);
      expect(mensajeTemasClase(c), contains('Tienes 30 min de esquema'));
      expect(mensajeTemasClase(c.copyWith(temasMandados: const ['3.A.1'])), isNot(contains('22 min 30 s')));
    });

    test('fin del esquema del aviso: desde que llegan los temas, o el del cronómetro si ya corre', () {
      final ahora = llegada.add(const Duration(minutes: 1));
      expect(finDelEsquema(llegada: llegada, segundos: 1800, ahora: ahora), llegada.add(const Duration(minutes: 30)));
      expect(finDelEsquema(llegada: llegada, segundos: 0, ahora: ahora), isNull);
      expect(finDelEsquema(llegada: llegada, segundos: 60, ahora: ahora.add(const Duration(minutes: 5))), isNull);
      // El cronómetro de la clase empezó a las 17:05 con 30': hasta las 17:35.
      final r = RelojCante(preparacion: const Duration(minutes: 30), exposicion: const Duration(minutes: 30))..iniciar(llegada.add(const Duration(minutes: 5)));
      expect(finDelEsquema(llegada: llegada, segundos: 1350, reloj: r, ahora: llegada.add(const Duration(minutes: 10))), llegada.add(const Duration(minutes: 35)));
      // Ya en la exposición: sin cuenta atrás de esquema.
      expect(finDelEsquema(llegada: llegada, segundos: 1350, reloj: r, ahora: llegada.add(const Duration(minutes: 40))), isNull);
    });

    test('el aviso de los temas usa el esquema que el preparador puso en el cronómetro de la clase', () async {
      final db = FakeFirebaseFirestore();
      final clase = db.doc('users/alu/cantes/c1');
      final datos = {'id': 'c1', 'ejercicio': 3, 'temaA': llegada.toIso8601String(), 'estado': 'pendiente'};
      await clase.set(datos);
      final ahora = llegada.add(const Duration(seconds: 20));
      // Sin cambiar nada: el del examen (22'30" para un tema).
      expect(await finEsquemaDeClase(clase, datos, temas: 1, oposicion: Oposiciones.tcee, llegada: llegada, ahora: ahora), llegada.add(const Duration(minutes: 22, seconds: 30)));
      // El preparador le puso 30' en el cronómetro antes de la clase (sin empezarlo).
      final r = RelojCante(preparacion: const Duration(minutes: 30), exposicion: const Duration(minutes: 30));
      await clase.collection('reloj').doc('estado').set({...r.aJson(llegada), 'activo': true, 'cambiado': Timestamp.fromDate(llegada)});
      expect(await finEsquemaDeClase(clase, datos, temas: 1, oposicion: Oposiciones.tcee, llegada: llegada, ahora: ahora), llegada.add(const Duration(minutes: 30)));
      // O lo dejó en la clase (sin cronómetro todavía).
      final otra = db.doc('users/alu/cantes/c2');
      final conEsquema = {...datos, 'id': 'c2', 'segundosEsquema': 1800};
      await otra.set(conEsquema);
      expect(await finEsquemaDeClase(otra, conEsquema, temas: 1, oposicion: Oposiciones.tcee, llegada: llegada, ahora: ahora), llegada.add(const Duration(minutes: 30)));
    });
  });

  group('cuenta atrás que baja', () {
    test('el aviso lleva el cronómetro nativo hacia atrás hasta el fin del esquema', () {
      final ahora = llegada;
      final hasta = llegada.add(const Duration(minutes: 30));
      final c = Notificaciones.cuentaAtrasAviso(hasta, ahora);
      expect(c.usesChronometer, isTrue);
      expect(c.chronometerCountDown, isTrue);
      expect(c.showWhen, isTrue);
      expect(c.when, hasta.millisecondsSinceEpoch);
      // Ya pasado: ni cronómetro ni hora (no cuenta en negativo).
      final pasado = Notificaciones.cuentaAtrasAviso(hasta, hasta.add(const Duration(seconds: 1)));
      expect(pasado.usesChronometer, isFalse);
      expect(pasado.when, isNull);
      expect(Notificaciones.hastaEsquema(hasta), 'Esquema hasta las 17:30');
    });

    test('el texto del aviso del cronómetro no lleva un «quedan» fijo mientras corre', () {
      final r = RelojCante(preparacion: const Duration(minutes: 30), exposicion: const Duration(minutes: 30))..iniciar(llegada);
      final texto = textoAvisoReloj(r, llegada.add(const Duration(minutes: 1)), elegido: '3.A.1');
      expect(texto, 'Esquema hasta las 17:30 · tema 3.A.1.');
      expect(texto, isNot(contains('quedan')));
      // Un minuto después sigue siendo verdad (el de antes decía «Le quedan 29:00» para siempre).
      expect(textoAvisoReloj(r, llegada.add(const Duration(minutes: 2)), elegido: '3.A.1'), texto);
      // En pausa sí se dice cuánto queda (no baja).
      r.pausar(llegada.add(const Duration(minutes: 10)));
      expect(textoAvisoReloj(r, llegada.add(const Duration(minutes: 12))), 'En pausa: le quedan 20:00.');
    });

    test('textos cortos', () {
      expect(textoEsquema(1350), '22 min 30 s');
      expect(textoEsquema(1800), '30 min');
    });
  });
}
