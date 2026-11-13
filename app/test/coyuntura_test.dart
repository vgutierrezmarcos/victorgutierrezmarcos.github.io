import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/coyuntura.dart';

void main() {
  test('lee el cuadro publicado por scripts/coyuntura.py', () {
    final c = Coyuntura.fromJson(jsonDecode(File('../oposicion/coyuntura.json').readAsStringSync()) as Map);
    expect(c.indicadores.length, greaterThanOrEqualTo(10));
    expect(c.porGrupo.keys, containsAll(['Actividad', 'Precios', 'Mercado de trabajo', 'Sector público', 'Financiero']));
    final pib = c.indicadores.firstWhere((i) => i.id == 'pib_ia');
    expect(pib.referenciaNombre, 'Zona del euro');
    expect(pib.serie, isNotEmpty);
    expect(pib.siguiente, isNotNull);
    expect(c.indicadores.firstWhere((i) => i.id == 'bono10').primaRiesgo, isNotNull);
  });

  test('datos nuevos: los que cambian de periodo desde la última visita', () {
    final c = Coyuntura.fromJson({
      'indicadores': [
        {'id': 'ipca', 'valor': 2.1, 'periodo': '2026-10'},
        {'id': 'paro', 'valor': 10.0, 'periodo': '2026-08'},
      ],
    });
    expect(c.nuevos(const {}), isEmpty, reason: 'la primera vez no hay nada nuevo');
    expect(c.nuevos(const {'ipca': '2026-09', 'paro': '2026-08'}).map((i) => i.id), ['ipca']);
    expect(cifraCoyuntura(-2.44), '−2,4');
  });
}
