import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/frecuencia_test.dart';
import 'package:tcee_app/features/cronograma/planificador.dart';
import 'package:tcee_app/features/organizacion/probabilidad_test.dart';

void main() {
  final f = FrecuenciaTest.fromJson(jsonDecode(File('../oposicion/temario/primer-ejercicio/test/frecuencia_temas.json').readAsStringSync()) as Map<String, dynamic>);

  test('la frecuencia de temas trae los 90 temas del test y suma 1', () {
    expect(f.temas.length, 90);
    expect(f.examenes.length, greaterThanOrEqualTo(22));
    for (final p in PesoRecientes.values) {
      expect(f.frecuencias(p).values.reduce((a, b) => a + b), closeTo(1, 1e-9));
    }
    expect(f.masPreguntados(PesoRecientes.igual).take(2), containsAll(['3.A.32', '3.A.43']));
    expect(textoFrecuencia(f, '3.A.43'), contains('de ${f.examenes.length} exámenes'));
  });

  test('al azar: la nota esperada con +1 / −0,33 y 4 opciones es casi cero y no se aprueba', () {
    const r = ReglasTest();
    final res = evaluarGrupos(r, [GrupoPreguntas(50, 0.25)]);
    expect(res.media, closeTo(0.025, 0.001));
    expect(res.aprobar, lessThan(1e-4));
    expect(r.valorRespuesta(0.5), closeTo(0.335, 1e-9));
  });

  test('pregunta a pregunta: lo sabido suma, lo que se deja en blanco no resta', () {
    const r = ReglasTest();
    final todasBien = evaluarGrupos(r, [GrupoPreguntas(50, 1)]);
    expect(todasBien.aprobar, 1);
    expect(todasBien.media, closeTo(10, 1e-9));
    // 30 sabidas al 100 % y 20 en blanco: un 6 seguro.
    final seis = evaluarGrupos(r, [GrupoPreguntas(30, 1), GrupoPreguntas(20, 0.25, responder: false)]);
    expect(seis.media, closeTo(6, 1e-9));
    expect(seis.aprobar, 1);
    // Las probabilidades de la distribución suman 1.
    final mix = evaluarGrupos(r, [GrupoPreguntas(25, 0.85), GrupoPreguntas(10, 0.5), GrupoPreguntas(15, 0.25)]);
    expect(mix.notas.fold(0.0, (s, e) => s + e.$2), closeTo(1, 1e-9));
  });

  test('con más temas estudiados la probabilidad de aprobar no baja', () {
    const r = ReglasTest();
    final orden = f.masPreguntados(PesoRecientes.mas);
    var anterior = -1.0;
    for (final n in [0, 20, 45, 70, 90]) {
      final p = mejorAlAzar(r, f, PesoRecientes.mas, orden.take(n).toSet(), 0.85, 4).$2.aprobar;
      expect(p, greaterThanOrEqualTo(anterior - 1e-9));
      anterior = p;
    }
    expect(anterior, greaterThan(0.95));
  });

  test('cronograma: primero lo que más cae, y a igualdad el orden que traía', () {
    expect(primeroLoQueMasCae(['a', 'b', 'c', 'd'], {'c': 0.3, 'b': 0.1, 'd': 0.1}), ['c', 'b', 'd', 'a']);
  });
}
