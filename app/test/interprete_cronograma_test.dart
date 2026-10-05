import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/cronograma/interprete_cronograma.dart';
import 'package:tcee_app/features/cronograma/lector_ficheros.dart';
import 'package:tcee_app/features/cronograma/lector_pdf.dart';

/// Cronogramas hechos fuera de la app: texto pegado y tablas.
void main() {
  late Set<String> codigos;
  final hoy = DateTime(2026, 10, 6);

  setUpAll(() {
    final t = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
    codigos = {for (final x in t.todosLosTemas) x.codigo};
  });

  test('fechas de cante y códigos en distintos formatos', () {
    final l = interpretarCronograma('''
Cronograma de Ana
13/10: 3A1, 3.A.2 y 3-a-3
20 de octubre: 3B4 – Comercio
27/10/2026  3A10
''', codigos: codigos, hoy: hoy);
    expect(l.semanas.map((s) => s.fecha), [DateTime(2026, 10, 13), DateTime(2026, 10, 20), DateTime(2026, 10, 27)]);
    expect(l.semanas.map((s) => s.temas), [
      ['3.A.1', '3.A.2', '3.A.3'],
      ['3.B.4'],
      ['3.A.10'],
    ]);
    expect(l.noReconocidas, ['Cronograma de Ana']);
  });

  test('sin ejercicio, rangos y semanas numeradas', () {
    final l = interpretarCronograma('''
Semana 1: A1-A3
Semana 2: A4, B1
  B2
Semana 3: A5 al A6
''', codigos: codigos, ejercicioPorDefecto: 3, hoy: hoy);
    expect(l.conFechas, isFalse);
    expect(l.semanas.map((s) => s.temas), [
      ['3.A.1', '3.A.2', '3.A.3'],
      ['3.A.4', '3.B.1', '3.B.2'],
      ['3.A.5', '3.A.6'],
    ]);
  });

  test('sin marcas: cada línea con temas es una semana; el ejercicio se deduce', () {
    final l = interpretarCronograma('4A1 4A2\nA3, A4\nnada que ver\n', codigos: codigos, hoy: hoy);
    expect(l.semanas.map((s) => s.temas), [
      ['4.A.1', '4.A.2'],
      ['4.A.3', '4.A.4'],
    ]);
    expect(l.noReconocidas, ['nada que ver']);
  });

  test('códigos que no existen, repetidos y años que cambian', () {
    final l = interpretarCronograma('22/12: 3A1, 3Z9, 3A99\n29/12: 3A1 3A2\n5/1: 3A3', codigos: codigos, hoy: DateTime(2026, 12, 1));
    expect(l.semanas.map((s) => s.temas), [
      ['3.A.1'],
      ['3.A.2'],
      ['3.A.3'],
    ]);
    expect(l.semanas.last.fecha, DateTime(2027, 1, 5));
  });

  test('una tabla (Excel): fecha en una columna y temas en las demás', () {
    final l = interpretarTabla([
      ['Fecha', 'Tema 1', 'Tema 2'],
      ['2026-10-13', '3A1', '3A2'],
      ['2026-10-20', '', '3B1'],
      ['', '', ''],
      ['2026-11-03', '3B2', ''],
    ], codigos: codigos, hoy: hoy);
    final s = semanasDesdeLeido(l, primerCante: hoy);
    expect(s.diaCante, DateTime.tuesday);
    // 27/10 no tiene cante: semana de descanso.
    expect(s.semanas.map((x) => x.descanso ? 'descanso' : x.temas.join(' ')), ['3.A.1 3.A.2', '3.B.1', 'descanso', '3.B.2']);
    expect(s.semanas.first.domingo, DateTime(2026, 10, 13));
  });

  test('sin fechas, las semanas van seguidas desde el primer cante', () {
    final l = interpretarCronograma('3A1\n3A2', codigos: codigos, hoy: hoy);
    final s = semanasDesdeLeido(l, primerCante: DateTime(2026, 10, 15));
    expect(s.diaCante, DateTime.thursday);
    expect(s.semanas.map((x) => x.domingo), [DateTime(2026, 10, 15), DateTime(2026, 10, 22)]);
  });

  test('nada reconocible', () {
    final l = interpretarCronograma('Hola\nEsto no es un cronograma', codigos: codigos, hoy: hoy);
    expect(l.vacio, isTrue);
    expect(l.noReconocidas, hasLength(2));
  });

  group('ficheros', () {
    List<List<String>> temasDe(CronogramaLeido? l) => [for (final s in l!.semanas) s.temas];
    const esperado = [
      ['3.A.1', '3.A.2'],
      ['3.B.4'],
      ['3.A.10', '3.A.11'],
    ];

    test('Excel con fechas en una columna', () {
      final l = leerFicheroCronograma('crono.xlsx', File('test/fixtures/cronograma.xlsx').readAsBytesSync(), codigos: codigos, hoy: hoy);
      expect(temasDe(l), esperado);
      expect(l!.semanas.map((s) => s.fecha), [DateTime(2026, 10, 13), DateTime(2026, 10, 20), DateTime(2026, 11, 3)]);
    });

    test('Word con una tabla', () {
      final l = leerFicheroCronograma('crono.docx', File('test/fixtures/cronograma.docx').readAsBytesSync(), codigos: codigos, hoy: hoy);
      expect(temasDe(l), esperado);
      expect(l!.noReconocidas, containsAll(['Mi cronograma', 'Plan del tercer ejercicio']));
    });

    test('PDF de un navegador (fuentes con ToUnicode)', () {
      final bytes = File('test/fixtures/cronograma.pdf').readAsBytesSync();
      expect(textoDePdf(bytes), contains('Cronograma de Lucía'));
      final l = leerFicheroCronograma('crono.pdf', bytes, codigos: codigos, hoy: hoy);
      expect(temasDe(l), esperado);
    });

    test('PDF con flujos de objetos (como los de Word)', () {
      final t = textoDePdf(File('test/fixtures/cronograma_objstm.pdf').readAsBytesSync());
      expect(t, 'Semana del 13/10: 3A1 y 3A2\n20/10/2026 3B4\nÁnimo');
    });

    test('CSV en Latin-1 y un fichero que no es lo que dice', () {
      final csv = latin1.encode('Fecha;Temas\n13/10/2026;3A1 3A2\n20/10/2026;3B4\n03/11/2026;3A10;3A11\nNotas: después del puente');
      expect(temasDe(leerFicheroCronograma('c.csv', csv, codigos: codigos, hoy: hoy)), esperado);
      expect(leerFicheroCronograma('c.pdf', utf8.encode('no soy un pdf'), codigos: codigos, hoy: hoy), isNull);
    });
  });
}
