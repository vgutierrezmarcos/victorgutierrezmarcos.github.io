import 'dart:convert';

import '../data/models/cronograma.dart';
import '../data/models/plan.dart';
import '../data/models/resultado.dart';
import '../data/repos/usuario_repo.dart';
import '../features/test/leitner.dart';

/// El resumen de la preparación que el opositor sube a su IA (Más → EconomIA
/// → «Exportar mis datos para la IA»): un recorte de la exportación completa
/// de Cuenta, con el formato de `claude/prepara-con-claude/references/datos-app.md`
/// (§2). Con el conector conectado no hace falta: la IA lee lo mismo de la app.
Map<String, dynamic> datosParaIa({
  required String oposicion,
  required DateTime generado,
  String? version,
  required Ajustes ajustes,
  required Plan plan,
  Map<String, AgendaTema> agendas = const {},
  Cronograma? cronograma,
  List<Cante> cantes = const [],
  List<ResultadoTest> tests = const [],
  EstadoLeitner? leitner,
  int maxTests = 30,
}) {
  String dia(DateTime d) => d.toIso8601String().substring(0, 10);
  final hechos = cantes.where((c) => c.hecho && !c.borrado).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
  final ultimos = [...tests]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  final porCaja = leitner?.porCaja ?? const <int, int>{};
  return {
    'oposicion': oposicion,
    'generado': generado.toIso8601String().substring(0, 19),
    if (version != null) 'app': version,
    'examen': {
      'fechas': {for (final e in plan.fechas.entries) '${e.key}': dia(e.value)},
      if (plan.hitos.isNotEmpty) 'hitos': [for (final h in plan.hitos) {'titulo': h.titulo, 'fecha': dia(h.fecha)}],
    },
    'temas': {
      'estudiados': ajustes.temasEstudiados.toList()..sort(),
      'enRepaso': ajustes.temasEnRepaso.toList()..sort(),
      if (ajustes.noCantar.isNotEmpty) 'noCantar': ajustes.noCantar.keys.toList()..sort(),
      if (agendas.isNotEmpty)
        'agenda': {
          for (final e in agendas.entries)
            if (e.value.vueltas.isNotEmpty || e.value.apuntes.isNotEmpty) e.key: {'vueltas': [for (final v in e.value.vueltas) dia(v)], 'apuntes': e.value.apuntes.length},
        },
    },
    if (cronograma != null) 'cronograma': cronograma.toJson(),
    'cantes': [
      for (final c in hechos)
        {
          'fecha': dia(c.fecha),
          'ejercicio': c.ejercicio,
          if (c.temas.isNotEmpty) 'temas': c.temas,
          'exposicion': c.exposicion,
          'esquema': c.esquema,
          if (c.dePreparador) 'conPreparador': true,
          if (c.resultado != null) 'resultado': c.resultado!.toJson(),
        },
    ],
    if (ajustes.rubrica.isNotEmpty) 'ajustes': {'rubrica': ajustes.rubrica},
    'tests': [
      for (final t in ultimos.take(maxTests))
        {
          'fecha': dia(t.timestamp),
          'tipo': t.tipo,
          'notaSobre10': double.parse(t.notaSobre10.toStringAsFixed(2)),
          'correctas': t.correctas,
          'incorrectas': t.incorrectas,
          'sinResponder': t.sinResponder,
          'totalPreguntas': t.totalPreguntas,
          'tiempoSeconds': t.tiempoSeconds,
          if (t.temas.isNotEmpty) 'temas': t.temas,
        },
    ],
    if (porCaja.values.any((n) => n > 0)) 'leitner': {'porCaja': {for (final e in porCaja.entries) '${e.key}': e.value}, 'vencidas': leitner!.pendientes().length},
  };
}

/// Nombre del fichero: `oposicion_tcee_para_ia.json`.
String nombreExportacionIa(String oposicion) => 'oposicion_${oposicion}_para_ia.json';

String jsonParaIa(Map<String, dynamic> datos) => const JsonEncoder.withIndent('  ').convert(datos);
