import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/models/resultado.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';
import 'package:tcee_app/features/inicio/racha.dart';

/// La racha de días (features/inicio/racha.dart): un día suelto no la rompe,
/// dos seguidos sí, y los días congelados no cuentan ni rompen.
void main() {
  final hoy = DateTime(2026, 10, 28, 15);
  String d(int haceDias) => Ajustes.claveDia(hoy.subtract(Duration(days: haceDias)));

  test('cuenta los días seguidos; hoy sin nada no rompe (está en juego)', () {
    final r = calcularRacha(activos: {d(1), d(2), d(3)}, congelados: const {}, hoy: hoy);
    expect(r.dias, 3);
    expect(r.hoyActivo, isFalse);
    expect(r.enJuego, isTrue);
    final conHoy = calcularRacha(activos: {d(0), d(1), d(2)}, congelados: const {}, hoy: hoy);
    expect(conHoy.dias, 3);
    expect(conHoy.enJuego, isFalse);
    expect(calcularRacha(activos: const {}, congelados: const {}, hoy: hoy).dias, 0);
  });

  test('un día suelto de descanso no la rompe; dos seguidos, sí', () {
    // Hoy, hace 2 y hace 3 (ayer libre): 3 días.
    expect(calcularRacha(activos: {d(0), d(2), d(3)}, congelados: const {}, hoy: hoy).dias, 3);
    // Dos huecos seguidos (ayer y anteayer): solo hoy.
    expect(calcularRacha(activos: {d(0), d(3), d(4)}, congelados: const {}, hoy: hoy).dias, 1);
    // Varios huecos sueltos, cada uno entre días activos: todos valen.
    expect(calcularRacha(activos: {d(0), d(2), d(4), d(6)}, congelados: const {}, hoy: hoy).dias, 4);
  });

  test('los días congelados no cuentan ni rompen, y se juntan con el día suelto', () {
    final rangos = congelar(const [], hoy.subtract(const Duration(days: 5)), 4); // hace 5, 4, 3 y 2
    expect(rangos, ['2026-10-23|2026-10-26']);
    final congelados = diasCongelados(rangos);
    expect(congelados, {d(5), d(4), d(3), d(2)});
    // Activo hace 6 y hoy; ayer libre (día suelto) y 4 congelados en medio: 2 días.
    final r = calcularRacha(activos: {d(0), d(6)}, congelados: congelados, hoy: hoy, rangos: rangos);
    expect(r.dias, 2);
    expect(r.congelada, isFalse);
    // Un hueco antes y otro después de la congelación son dos seguidos: rompe.
    expect(calcularRacha(activos: {d(0), d(7)}, congelados: congelados, hoy: hoy).dias, 1);
  });

  test('congelar desde hoy y descongelar (lo descansado se conserva)', () {
    var rangos = congelar(const [], hoy, 7);
    expect(rangos, ['2026-10-28|2026-11-03']);
    var r = calcularRacha(activos: {d(1), d(2)}, congelados: diasCongelados(rangos), hoy: hoy, rangos: rangos);
    expect(r.congeladaHasta, DateTime(2026, 11, 3));
    expect(r.enJuego, isFalse, reason: 'congelada: nada que perder hoy');
    // Dentro de la congelación, días después, la racha sigue.
    final dentro = hoy.add(const Duration(days: 4));
    expect(calcularRacha(activos: {d(1), d(2)}, congelados: diasCongelados(rangos), hoy: dentro, rangos: rangos).dias, 2);
    // Descongelar el 31: el rango se queda hasta el 30.
    rangos = descongelar(rangos, DateTime(2026, 10, 31));
    expect(rangos, ['2026-10-28|2026-10-30']);
    expect(congeladaHasta(rangos, DateTime(2026, 10, 31)), isNull);
    // Un rango ya pasado no se toca; uno futuro que no ha empezado desaparece.
    expect(descongelar(['2026-10-01|2026-10-03', '2026-11-10|2026-11-12'], DateTime(2026, 10, 31)), ['2026-10-01|2026-10-03']);
    // Como mucho 30 días.
    expect(congelar(const [], hoy, 90), ['2026-10-28|2026-11-26']);
  });

  test('los días activos salen de tests, cantes hechos y vueltas; sin activar, no hay racha', () {
    ResultadoTest t(DateTime f) => ResultadoTest(id: 'x', timestamp: f, puntosBrutos: 0, maxPuntos: 0, notaSobre10: 0, correctas: 0, incorrectas: 0, sinResponder: 0, totalPreguntas: 0, tiempoSeconds: 0, temas: const []);
    final cantes = [
      Cante(id: 'c1', fecha: hoy.subtract(const Duration(days: 1)), estado: EstadoCante.hecho, updatedAt: hoy),
      Cante(id: 'c2', fecha: hoy.subtract(const Duration(days: 2)), updatedAt: hoy), // pendiente: no cuenta
    ];
    final activos = diasActivos(tests: [t(hoy)], cantes: cantes, vueltas: [hoy.subtract(const Duration(days: 3))]);
    expect(activos, {d(0), d(1), d(3)});
    expect(rachaDe(const Ajustes(), tests: [t(hoy)], hoy: hoy), isNull);
    final r = rachaDe(const Ajustes(racha: true), tests: [t(hoy)], cantes: cantes, vueltas: [hoy.subtract(const Duration(days: 3))], hoy: hoy)!;
    expect(r.dias, 3); // hoy, ayer, (anteayer suelto), hace 3
  });
}
