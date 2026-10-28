import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/reto.dart';

/// Reto diario (agregado anónimo del test diario): lectura, media, posición y textos.
void main() {
  test('se lee del documento del día y se describe', () {
    final r = RetoDia.fromJson({'hechos': 10, 'sumaNotas': 64, 'c4': 2, 'c6': 3, 'c7': 4, 'c9': 1});
    expect(r.hechos, 10);
    expect(r.media, closeTo(6.4, 1e-9));
    expect(r.cubos.length, 11);
    expect(r.cubos[7], 4);
    expect(r.suficiente, isTrue);
    // Con un 7: por debajo están los 2 cuatros y los 3 seises, de 9 otros.
    expect(r.porDebajo(7), closeTo(5 / 9, 1e-9));
    expect(r.porDebajo(0), 0);
    expect(r.porDebajo(10), closeTo(9 / 9, 1e-9));
    expect(r.texto(7), 'Hoy lo han hecho 10 personas · nota media 6,4 · estás por encima del 56 %');
  });

  test('con pocos participantes no se dan cifras', () {
    expect(RetoDia.fromJson({'hechos': 1, 'sumaNotas': 8, 'c8': 1}).texto(8), 'Hoy lo has hecho tú: sois pocos todavía para dar cifras.');
    expect(RetoDia.fromJson({'hechos': 3, 'sumaNotas': 20}).texto(8), 'Hoy lo habéis hecho 3: sois pocos todavía para dar cifras.');
    expect(RetoDia.fromJson(null).hechos, 0);
    expect(RetoDia.fromJson(null).porDebajo(5), 0);
  });

  test('id del día y nota redondeada', () {
    expect(RetoDia.id(DateTime(2026, 10, 28, 23)), '2026-10-28');
    expect(RetoDia.cubo(6.49), 6);
    expect(RetoDia.cubo(6.5), 7);
    expect(RetoDia.cubo(-1), 0);
    expect(RetoDia.cubo(11), 10);
  });
}
