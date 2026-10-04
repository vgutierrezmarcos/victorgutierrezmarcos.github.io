import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcee_app/widgets/texto_formulas.dart';

/// Fórmulas LaTeX de las preguntas del test, como las dibuja MathJax en el
/// simulador de la web.
void main() {
  group('separar el texto de las fórmulas', () {
    test('en línea, destacadas y dólares escapados', () {
      expect(separarFormulas(r'Si $x_1 > x_2$, entonces'), const [TrozoTexto('Si '), TrozoTexto('x_1 > x_2', formula: true), TrozoTexto(', entonces')]);
      expect(separarFormulas(r'Sea $$\frac{a}{b}$$ fin'), const [TrozoTexto('Sea '), TrozoTexto(r'\frac{a}{b}', formula: true, destacada: true), TrozoTexto(' fin')]);
      expect(separarFormulas(r'Con \(\alpha\) y \[\beta\]'), const [TrozoTexto('Con '), TrozoTexto(r'\alpha', formula: true), TrozoTexto(' y '), TrozoTexto(r'\beta', formula: true, destacada: true)]);
      expect(separarFormulas(r'Cuesta 5 \$ y $p$'), const [TrozoTexto(r'Cuesta 5 $ y '), TrozoTexto('p', formula: true)]);
      expect(separarFormulas('Sin fórmulas'), const [TrozoTexto('Sin fórmulas')]);
      // Un dólar suelto sin cierre se deja como texto.
      expect(separarFormulas(r'Precio: 3 $'), const [TrozoTexto(r'Precio: 3 $')]);
    });
  });

  test('todas las fórmulas del banco de preguntas se pueden dibujar', () {
    final j = jsonDecode(File('../oposicion/temario/primer-ejercicio/test/preguntas.json').readAsStringSync()) as Map<String, dynamic>;
    final preguntas = j['preguntas'] as List;
    final fallos = <String>[];
    var n = 0;
    for (final p in preguntas) {
      final textos = [p['enunciado'] as String, ...(p['opciones'] as Map).values.cast<String>()];
      for (final t in textos) {
        for (final f in separarFormulas(t).where((x) => x.formula)) {
          n++;
          final error = Math.tex(f.texto).parseError;
          if (error != null) fallos.add('${p['id']}: ${f.texto} → ${error.message}');
        }
      }
    }
    expect(n, greaterThan(500));
    expect(fallos, isEmpty, reason: fallos.join('\n'));
  });

  testWidgets('se dibujan dentro del texto', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: TextoConFormulas(r'La utilidad $U = \sqrt{x \cdot y}$ es cóncava'))));
    expect(find.byType(Math), findsOneWidget);
    expect(find.textContaining(r'$'), findsNothing);
  });
}
