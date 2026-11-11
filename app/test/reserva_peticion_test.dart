import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/cronograma.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/red.dart';
import 'package:tcee_app/features/preparador/reservas.dart';

/// Pedir una clase desde la app con presencial u online y los temas, como el
/// conector de IA.
void main() {
  test('la reserva lleva la modalidad y los temas por JSON (y sin ellos no escribe nada)', () {
    final r = Reserva(id: 'r1', preparador: 'p', alumno: 'a', fecha: DateTime(2026, 11, 5, 17), modalidad: Modalidad.online, temas: const ['3.A.8', '3.B.1']);
    final j = r.toJson();
    expect(j['modalidad'], 'online');
    expect(j['temas'], ['3.A.8', '3.B.1']);
    final vuelta = Reserva.fromJson(j);
    expect(vuelta.modalidad, Modalidad.online);
    expect(vuelta.temas, ['3.A.8', '3.B.1']);

    final sin = Reserva(id: 'r2', preparador: 'p', alumno: 'a', fecha: DateTime(2026, 11, 5, 17)).toJson();
    expect(sin.containsKey('modalidad'), isFalse);
    expect(sin.containsKey('temas'), isFalse);
    expect(Reserva.fromJson(sin).modalidad, Modalidad.sinIndicar);
  });

  test('por defecto, los temas del cronograma para ese día, sin los que pide no cantar', () {
    final cronograma = Cronograma(
      id: 'c',
      ejercicio: 3,
      temas: const ['3.A.8', '3.A.9', '3.B.1'],
      inicio: DateTime(2026, 10, 16),
      diaCante: 4, // jueves
      semanas: [
        SemanaPlan(lunes: DateTime(2026, 10, 16), temas: const ['3.A.8', '3.A.9']), // cante del jueves 22
        SemanaPlan(lunes: DateTime(2026, 10, 23), temas: const ['3.B.1']), // cante del jueves 29
      ],
    );
    expect(temasPorDefectoReserva(cronograma, DateTime(2026, 10, 22, 17)), ['3.A.8', '3.A.9']);
    expect(temasPorDefectoReserva(cronograma, DateTime(2026, 10, 22, 17), noCantar: {'3.A.9': DateTime(2026, 10, 20)}), ['3.A.8']);
    expect(temasPorDefectoReserva(cronograma, DateTime(2026, 12, 1)), isEmpty);
    expect(temasPorDefectoReserva(null, DateTime(2026, 10, 22)), isEmpty);
    // La clase aceptada lleva el id con el que se fijan los temas.
    expect(idClaseDeReserva('r1'), 'res_r1');
  });
}
