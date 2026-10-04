import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// Un trozo de texto: normal o una fórmula LaTeX (en línea o destacada).
class TrozoTexto {
  const TrozoTexto(this.texto, {this.formula = false, this.destacada = false});
  final String texto;
  final bool formula;
  final bool destacada;

  @override
  bool operator ==(Object other) => other is TrozoTexto && other.texto == texto && other.formula == formula && other.destacada == destacada;
  @override
  int get hashCode => Object.hash(texto, formula, destacada);
  @override
  String toString() => formula ? (destacada ? '\$\$$texto\$\$' : '\$$texto\$') : texto;
}

/// Separa el texto de las fórmulas con las mismas reglas que MathJax en el
/// simulador de la web: en línea `$…$` y `\(…\)`, destacadas `$$…$$` y
/// `\[…\]`, y `\$` es un dólar normal.
List<TrozoTexto> separarFormulas(String s) {
  final trozos = <TrozoTexto>[];
  final texto = StringBuffer();
  void cerrarTexto() {
    if (texto.isNotEmpty) trozos.add(TrozoTexto(texto.toString()));
    texto.clear();
  }

  var i = 0;
  while (i < s.length) {
    // Dólar escapado.
    if (s.startsWith(r'\$', i)) {
      texto.write(r'$');
      i += 2;
      continue;
    }
    String? cierre;
    var destacada = false;
    var largo = 0;
    if (s.startsWith(r'$$', i)) {
      cierre = r'$$';
      destacada = true;
      largo = 2;
    } else if (s.startsWith(r'\[', i)) {
      cierre = r'\]';
      destacada = true;
      largo = 2;
    } else if (s.startsWith(r'\(', i)) {
      cierre = r'\)';
      largo = 2;
    } else if (s[i] == r'$') {
      cierre = r'$';
      largo = 1;
    }
    if (cierre != null) {
      final fin = s.indexOf(cierre, i + largo);
      if (fin > i + largo) {
        cerrarTexto();
        trozos.add(TrozoTexto(s.substring(i + largo, fin).trim(), formula: true, destacada: destacada));
        i = fin + cierre.length;
        continue;
      }
    }
    texto.write(s[i]);
    i++;
  }
  cerrarTexto();
  return trozos;
}

/// Texto con fórmulas LaTeX dibujadas (enunciados y opciones del test). Si una
/// fórmula no se puede dibujar, se deja tal cual.
class TextoConFormulas extends StatelessWidget {
  const TextoConFormulas(this.texto, {super.key, this.style});
  final String texto;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final estilo = DefaultTextStyle.of(context).style.merge(style);
    final trozos = separarFormulas(texto);
    if (trozos.every((t) => !t.formula)) return Text(texto, style: style);
    return Text.rich(TextSpan(style: style, children: [
      for (final t in trozos)
        if (!t.formula)
          TextSpan(text: t.texto)
        else
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: t.destacada ? const EdgeInsets.symmetric(vertical: 6) : EdgeInsets.zero,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  t.texto,
                  mathStyle: t.destacada ? MathStyle.display : MathStyle.text,
                  textStyle: estilo.copyWith(fontSize: (estilo.fontSize ?? 14) * 1.05),
                  onErrorFallback: (_) => Text(t.toString(), style: estilo),
                ),
              ),
            ),
          ),
    ]));
  }
}
