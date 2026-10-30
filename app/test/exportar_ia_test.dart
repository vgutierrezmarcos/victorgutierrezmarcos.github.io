import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/core/exportar_ia.dart';
import 'package:tcee_app/data/models/plan.dart';
import 'package:tcee_app/data/repos/usuario_repo.dart';

/// «Exportar mis datos para la IA»: el recorte que se sube al chat.
void main() {
  test('lleva los temas, los cantes hechos con su resultado y el examen, sin lo pendiente', () {
    final hecho = Cante(id: 'c1', fecha: DateTime(2026, 10, 10, 18), ejercicio: 3, estado: EstadoCante.hecho, resultado: const ResultadoCante(temaCantado: '3.A.8', segundos: 1781, valoracion: 3, comentarios: 'Bien la intro'));
    final pendiente = Cante(id: 'c2', fecha: DateTime(2026, 11, 10, 18));
    final d = datosParaIa(
      oposicion: 'tcee',
      generado: DateTime(2026, 10, 30, 10, 12),
      version: '1.21.0',
      ajustes: Ajustes(temasEstudiados: const {'3.A.2', '3.A.1'}, rubrica: const ['Esquema', 'Rigor']),
      plan: Plan(fechas: {3: DateTime(2027, 6, 15)}),
      cantes: [pendiente, hecho],
    );
    expect(d['oposicion'], 'tcee');
    expect(d['generado'], '2026-10-30T10:12:00');
    expect(d['app'], '1.21.0');
    expect((d['examen'] as Map)['fechas'], {'3': '2027-06-15'});
    expect((d['temas'] as Map)['estudiados'], ['3.A.1', '3.A.2']);
    final cantes = d['cantes'] as List;
    expect(cantes, hasLength(1));
    expect(cantes.first['fecha'], '2026-10-10');
    expect((cantes.first['resultado'] as Map)['temaCantado'], '3.A.8');
    expect((d['ajustes'] as Map)['rubrica'], ['Esquema', 'Rigor']);
    expect(d.containsKey('leitner'), isFalse);
    expect(nombreExportacionIa('dce'), 'oposicion_dce_para_ia.json');
    expect(jsonParaIa(d), contains('"temaCantado": "3.A.8"'));
  });
}
