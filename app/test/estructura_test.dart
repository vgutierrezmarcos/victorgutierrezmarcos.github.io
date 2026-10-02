import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/data/models/estructura.dart';
import 'package:tcee_app/data/models/temario.dart';

/// Comprueba el JSON real de la organización del temario (extraído del
/// PowerPoint) contra el temario y el código de colores.
void main() {
  late EstructuraTemario e;
  late Temario temario;

  setUpAll(() {
    e = EstructuraTemario.fromJson(jsonDecode(File('../oposicion/organizacion/estructura_temario.json').readAsStringSync()) as Map<String, dynamic>);
    temario = Temario.fromJson(jsonDecode(File('../oposicion/temario/temario.json').readAsStringSync()) as Map<String, dynamic>);
  });

  test('todos los temas del tercer y cuarto ejercicio tienen bloque, y solo uno', () {
    final delTemario = temario.todosLosTemas.where((t) => t.ejercicio == 3 || t.ejercicio == 4).map((t) => t.codigo).toSet();
    final enBloques = [for (final b in e.bloques) ...b.temas];
    expect(enBloques.toSet(), delTemario);
    expect(enBloques.length, delTemario.length);
  });

  test('código de colores del PowerPoint', () {
    expect(e.colorDe('3.A.8'), const Color(0xFF92D050)); // Modelo neoclásico básico
    expect(e.colorDe('3.A.38'), const Color(0xFFFFC000)); // Ciclo económico y políticas de demanda
    expect(e.colorDe('3.B.36'), const Color(0xFF325EEA)); // Unión Europea
    expect(e.colorDe('3.B.20'), const Color(0xFF002060)); // Historia económica
    expect(e.colorDe('4.A.1'), const Color(0xFFFF6699)); // Economía española
    expect(e.colorDe('4.B.1'), const Color(0xFF5F2987)); // Sector público
    expect(e.colorDe('5.A.1'), isNull);
    // Los catorce bloques del tercer ejercicio tienen colores distintos.
    final tercero = e.deEjercicio(3);
    expect(tercero.length, 14);
    expect(tercero.map((b) => b.color).toSet().length, 14);
    expect(e.categorias(3), ['Microeconomía', 'Macroeconomía', 'Mixto']);
    expect(e.bloqueDe('3.A.8')!.nombre, 'Modelo neoclásico básico');
    expect(e.bloqueDe('3.A.8')!.categoria, 'Microeconomía');
  });

  test('los esquemas solo usan temas y bloques que existen', () {
    expect(e.esquemas.map((x) => x.id), ['tercero', 'cuarto', 'combinado']);
    for (final esquema in e.esquemas) {
      for (final n in esquema.nodos) {
        expect(temario.tema(n.tema), isNotNull, reason: '${esquema.id}: ${n.tema}');
        expect(n.rect.left >= 0 && n.rect.right <= 1.001 && n.rect.top >= 0 && n.rect.bottom <= 1.001, isTrue, reason: '${esquema.id}: ${n.tema} fuera de la diapositiva');
      }
      for (final c in esquema.conexiones) {
        for (final x in [c.de, c.a]) {
          expect(x.esTema ? temario.tema(x.tema!) != null : e.bloque(x.bloque!) != null, isTrue, reason: '${esquema.id}: ${x.clave}');
          expect(esquema.rectDe(x), isNotNull, reason: '${esquema.id}: sin posición para ${x.clave}');
        }
      }
    }
    expect(e.esquemas.first.conexiones.length, greaterThan(50));
  });

  test('conexiones de un tema y de un bloque', () {
    // En el PowerPoint, 3.A.8 enlaza con 3.A.9, 3.A.10 y 3.A.25.
    final rel = e.relacionados('3.A.8').map((x) => x.clave).toSet();
    expect(rel, containsAll(['3.A.9', '3.A.10', '3.A.25']));
    final bloque = e.conexionesDeBloque('modelo-neoclasico-basico');
    expect(bloque, isNotEmpty);
    // Ninguna conexión «del bloque con el exterior» une dos temas del propio bloque.
    final temas = e.bloque('modelo-neoclasico-basico')!.temas;
    expect(bloque.every((c) => !(c.de.esTema && c.a.esTema && temas.contains(c.de.tema) && temas.contains(c.a.tema))), isTrue);
  });

  test('por dónde seguir: temas sin estudiar conectados con los estudiados', () {
    expect(e.sugeridos(const {}), isEmpty);
    final s = e.sugeridos(const {'3.A.8'});
    expect(s, containsAll(['3.A.9', '3.A.10', '3.A.25']));
    expect(s.contains('3.A.8'), isFalse);
    expect(e.sugeridos(const {'3.A.8', '3.A.9'}).contains('3.A.9'), isFalse);
    expect(e.sugeridos(const {'3.A.38'}, ejercicio: 4).every((t) => t.startsWith('4.')), isTrue);
  });

  test('ideas clave y contraste del texto', () {
    expect(e.ideas['3.A.11'], startsWith('Análisis de restricción técnica'));
    expect(e.ideas.keys.every((k) => temario.tema(k) != null), isTrue);
    expect(textoSobre(const Color(0xFF002060)), const Color(0xFFFFFFFF));
    expect(textoSobre(const Color(0xFF99FF99)), const Color(0xFF1F1F1F));
  });
}
