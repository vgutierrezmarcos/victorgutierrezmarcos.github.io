import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/esquema.dart';
import 'package:tcee_app/data/models/temario.dart';
import 'package:tcee_app/features/cantar/esquema_ciegas_page.dart';
import 'package:tcee_app/features/temario/esquema_tema.dart';

void main() {
  const a = Tema(codigo: '3.B.10', titulo: 'Movimientos de capital', disponible: true, temarioAnterior: false);
  const b = Tema(codigo: '3.A.40', titulo: 'Economía abierta', disponible: true, temarioAnterior: false);
  final esquemas = {
    a: const [
      EntradaEsquema(nivel: 0, titulo: '1. Movilidad del capital', pagina: 2),
      EntradaEsquema(nivel: 1, titulo: '1.2. La paradoja de Feldstein–Horioka', pagina: 5),
    ],
    b: const [
      EntradaEsquema(nivel: 1, titulo: 'Modelo Mundell-Fleming con tipos fijos', pagina: 9),
    ],
  };

  test('encuentra el epígrafe sin tildes, mayúsculas ni guiones, con su página', () {
    final r = buscarEpigrafes(esquemas, 'feldstein horioka');
    expect(r, hasLength(1));
    expect(r.single.tema.codigo, '3.B.10');
    expect(r.single.entrada.pagina, 5);
    expect(buscarEpigrafes(esquemas, 'Mundell-Fleming').single.tema.codigo, '3.A.40');
    expect(buscarEpigrafes(esquemas, 'movílidad').single.entrada.pagina, 2);
  });

  test('todas las palabras, en cualquier orden; nada con consultas cortas', () {
    expect(buscarEpigrafes(esquemas, 'fijos mundell'), hasLength(1));
    expect(buscarEpigrafes(esquemas, 'mundell flotantes'), isEmpty);
    expect(buscarEpigrafes(esquemas, 'mo'), isEmpty);
  });

  test('huecos: un tercio al azar, al menos dos y nunca el primero', () {
    final esquema = [for (var i = 0; i < 9; i++) EntradaEsquema(nivel: i == 0 ? 0 : 1, titulo: 'Apartado $i', pagina: i + 1)];
    for (var semilla = 0; semilla < 20; semilla++) {
      final h = tapadosAlAzar(esquema, azar: math.Random(semilla));
      expect(h, hasLength(3));
      expect(h, isNot(contains('Apartado 0')));
    }
    expect(tapadosAlAzar(esquema.take(4).toList()), hasLength(2));
  });
}
