import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/proceso.dart';

/// Documentos del proceso selectivo (oposicion/proceso.json).
void main() {
  final json = {
    'tcee': {
      'procesos': [
        {
          'convocatoria': '2025',
          'url': 'https://portal/OEP2025TECOS.aspx',
          'documentos': [
            {'id': 'a', 'seccion': 'Convocatoria', 'titulo': 'Resolución', 'url': 'https://portal/a.pdf'},
            {'id': 'b', 'seccion': 'Tercer ejercicio', 'titulo': 'Convocatoria', 'url': 'https://portal/b.pdf', 'desde': '2026-09-20'},
            {'id': 'c', 'seccion': 'Tercer ejercicio', 'titulo': 'Lista de aprobados', 'url': 'https://portal/c.pdf', 'desde': '2026-10-05'},
          ],
        },
      ],
    },
  };

  test('secciones en orden y novedades de la más nueva a la más antigua', () {
    final p = ProcesoSelectivo.deOposicion(json, 'tcee').single;
    expect(p.secciones.map((s) => s.$1), ['Convocatoria', 'Tercer ejercicio']);
    expect(p.secciones.last.$2.map((d) => d.id), ['b', 'c']);
    expect(p.novedades.map((d) => d.id), ['c', 'b']);
    expect(p.documentos.first.reciente(DateTime(2026, 10, 6)), isFalse); // sin fecha
    expect(p.documentos.last.reciente(DateTime(2026, 10, 6)), isTrue);
    expect(ProcesoSelectivo.deOposicion(json, 'dce'), isEmpty);
  });

  test('la primera vez no hay novedades; después, solo lo nuevo', () {
    final p = ProcesoSelectivo.deOposicion(json, 'tcee');
    final r1 = novedadesProceso('tcee', p, {});
    expect(r1.nuevos, isEmpty);
    expect(r1.vistos, containsAll(['tcee:base', 'tcee:a', 'tcee:b', 'tcee:c']));
    final mas = Map<String, dynamic>.from(jsonDecode(jsonEncode(json)) as Map);
    (((mas['tcee'] as Map)['procesos'] as List).first['documentos'] as List).add({'id': 'd', 'seccion': 'Cuarto ejercicio', 'titulo': 'Convocatoria', 'url': 'https://portal/d.pdf', 'desde': '2026-10-06'});
    final r2 = novedadesProceso('tcee', ProcesoSelectivo.deOposicion(mas, 'tcee'), r1.vistos);
    expect(r2.nuevos.map((d) => d.id), ['d']);
    expect(novedadesProceso('tcee', ProcesoSelectivo.deOposicion(mas, 'tcee'), r2.vistos).nuevos, isEmpty);
  });

  test('TCEE y DCE van por separado: seguir una no marca nada de la otra', () {
    // El mismo documento (mismo id) en las dos oposiciones.
    final dos = {
      'tcee': json['tcee'],
      'dce': {
        'procesos': [
          {
            'convocatoria': '2025',
            'url': 'https://portal/OEP2025DIPLOS.aspx',
            'documentos': [
              {'id': 'a', 'seccion': 'Convocatoria', 'titulo': 'Resolución', 'url': 'https://portal/a.pdf'},
            ],
          },
        ],
      },
    };
    final tcee = novedadesProceso('tcee', ProcesoSelectivo.deOposicion(dos, 'tcee'), {});
    expect(tcee.vistos.where((v) => v.startsWith('dce:')), isEmpty);
    // DCE empieza de cero aunque TCEE ya hubiera visto ese documento.
    final dce = novedadesProceso('dce', ProcesoSelectivo.deOposicion(dos, 'dce'), tcee.vistos);
    expect(dce.nuevos, isEmpty, reason: 'la primera vez es la base');
    expect(dce.vistos, containsAll(['dce:base', 'dce:a', 'tcee:a']));
    final mas = Map<String, dynamic>.from(jsonDecode(jsonEncode(dos)) as Map);
    (((mas['dce'] as Map)['procesos'] as List).first['documentos'] as List).add({'id': 'z', 'seccion': 'Primer ejercicio', 'titulo': 'Convocatoria', 'url': 'https://portal/z.pdf'});
    expect(novedadesProceso('dce', ProcesoSelectivo.deOposicion(mas, 'dce'), dce.vistos).nuevos.map((d) => d.id), ['z']);
    expect(novedadesProceso('tcee', ProcesoSelectivo.deOposicion(mas, 'tcee'), dce.vistos).nuevos, isEmpty);
  });

  test('el JSON publicado se lee entero', () {
    final j = jsonDecode(File('../oposicion/proceso.json').readAsStringSync()) as Map<String, dynamic>;
    for (final op in ['tcee', 'dce']) {
      final procesos = ProcesoSelectivo.deOposicion(j, op);
      expect(procesos, isNotEmpty);
      expect(procesos.first.documentos, isNotEmpty);
      expect(procesos.first.url, startsWith('https://portal.mineco.gob.es/'));
    }
  });
}
