import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'comunes.dart';
import '../theme/app_theme.dart';

/// Markdown sencillo para leer los informes que escribe la IA (sin paquetes
/// nuevos): títulos, párrafos, listas, citas, código, separadores y tablas;
/// en línea, negrita, cursiva, `código` y enlaces.
enum TipoBloqueMd { titulo, parrafo, lista, numerada, cita, codigo, separador, tabla }

class BloqueMd {
  const BloqueMd(this.tipo, this.lineas, {this.nivel = 0});
  final TipoBloqueMd tipo;

  /// El texto de cada línea (cada elemento de una lista, cada fila de una
  /// tabla con sus celdas separadas por «|»).
  final List<String> lineas;

  /// Nivel del título (1-6).
  final int nivel;

  @override
  String toString() => '$tipo$nivel$lineas';
}

final _titulo = RegExp(r'^(#{1,6})\s+(.*?)\s*#*\s*$');
final _vineta = RegExp(r'^\s*[-*+]\s+(.*)$');
final _numero = RegExp(r'^\s*\d+[.)]\s+(.*)$');
final _separador = RegExp(r'^\s*([-*_])(\s*\1){2,}\s*$');
final _filaTabla = RegExp(r'^\s*\|.*\|\s*$');
final _lineaTabla = RegExp(r'^\s*\|?\s*:?-{2,}:?\s*(\|\s*:?-{2,}:?\s*)*\|?\s*$');

/// Separa [texto] en bloques.
List<BloqueMd> analizarMarkdown(String texto) {
  final lineas = texto.replaceAll('\r\n', '\n').split('\n');
  final out = <BloqueMd>[];
  var i = 0;
  while (i < lineas.length) {
    final l = lineas[i];
    if (l.trim().isEmpty) {
      i++;
      continue;
    }
    if (l.trimLeft().startsWith('```')) {
      final codigo = <String>[];
      i++;
      while (i < lineas.length && !lineas[i].trimLeft().startsWith('```')) {
        codigo.add(lineas[i++]);
      }
      i++;
      out.add(BloqueMd(TipoBloqueMd.codigo, codigo));
      continue;
    }
    final t = _titulo.firstMatch(l);
    if (t != null) {
      out.add(BloqueMd(TipoBloqueMd.titulo, [t.group(2)!], nivel: t.group(1)!.length));
      i++;
      continue;
    }
    if (_separador.hasMatch(l)) {
      out.add(const BloqueMd(TipoBloqueMd.separador, []));
      i++;
      continue;
    }
    if (_filaTabla.hasMatch(l)) {
      final filas = <String>[];
      while (i < lineas.length && _filaTabla.hasMatch(lineas[i])) {
        if (!_lineaTabla.hasMatch(lineas[i])) filas.add(lineas[i].trim());
        i++;
      }
      out.add(BloqueMd(TipoBloqueMd.tabla, filas));
      continue;
    }
    if (l.trimLeft().startsWith('>')) {
      final cita = <String>[];
      while (i < lineas.length && lineas[i].trimLeft().startsWith('>')) {
        cita.add(lineas[i].trimLeft().substring(1).trim());
        i++;
      }
      out.add(BloqueMd(TipoBloqueMd.cita, [cita.join(' ')]));
      continue;
    }
    if (_vineta.hasMatch(l) || _numero.hasMatch(l)) {
      final (patron, tipo) = _vineta.hasMatch(l) ? (_vineta, TipoBloqueMd.lista) : (_numero, TipoBloqueMd.numerada);
      final items = <String>[];
      while (i < lineas.length && lineas[i].trim().isNotEmpty) {
        final m = patron.firstMatch(lineas[i]);
        if (m != null) {
          items.add(m.group(1)!);
        } else if (lineas[i].startsWith(' ') || lineas[i].startsWith('\t')) {
          // Continuación del elemento anterior (o una sublista: va en línea).
          final sub = _vineta.firstMatch(lineas[i]) ?? _numero.firstMatch(lineas[i]);
          items[items.length - 1] = '${items.last}${sub == null ? ' ${lineas[i].trim()}' : '\n– ${sub.group(1)}'}';
        } else {
          break;
        }
        i++;
      }
      out.add(BloqueMd(tipo, items));
      continue;
    }
    final parrafo = <String>[];
    while (i < lineas.length) {
      final x = lineas[i];
      if (x.trim().isEmpty || _titulo.hasMatch(x) || x.trimLeft().startsWith('```') || x.trimLeft().startsWith('>') || _filaTabla.hasMatch(x) || _separador.hasMatch(x)) break;
      if (parrafo.isNotEmpty && (_vineta.hasMatch(x) || _numero.hasMatch(x))) break;
      // Dos espacios al final (o «\») fuerzan un salto de línea.
      parrafo.add(x.endsWith('  ') || x.endsWith(r'\') ? '${x.trimRight().replaceFirst(RegExp(r'\\$'), '')}\n' : '${x.trim()} ');
      i++;
    }
    out.add(BloqueMd(TipoBloqueMd.parrafo, [parrafo.join().trim()]));
  }
  return out;
}

/// Un trozo de texto en línea con su formato.
class TrozoMd {
  const TrozoMd(this.texto, {this.negrita = false, this.cursiva = false, this.codigo = false, this.enlace});
  final String texto;
  final bool negrita;
  final bool cursiva;
  final bool codigo;
  final String? enlace;

  @override
  bool operator ==(Object other) => other is TrozoMd && other.texto == texto && other.negrita == negrita && other.cursiva == cursiva && other.codigo == codigo && other.enlace == enlace;
  @override
  int get hashCode => Object.hash(texto, negrita, cursiva, codigo, enlace);
  @override
  String toString() => '${negrita ? 'N' : ''}${cursiva ? 'C' : ''}${codigo ? '`' : ''}${enlace == null ? '' : '@'}«$texto»';
}

final _enLinea = RegExp(r'`([^`]+)`|\[([^\]]+)\]\(([^)\s]+)\)|\*\*(.+?)\*\*|__(.+?)__|\*([^*\s][^*]*?)\*|(?<![\w])_([^_\s][^_]*?)_(?![\w])');

/// Formato en línea de [texto] (la negrita puede llevar cursiva dentro).
List<TrozoMd> analizarEnLinea(String texto, {bool negrita = false, bool cursiva = false}) {
  final out = <TrozoMd>[];
  var desde = 0;
  for (final m in _enLinea.allMatches(texto)) {
    if (m.start > desde) out.add(TrozoMd(texto.substring(desde, m.start), negrita: negrita, cursiva: cursiva));
    if (m.group(1) != null) {
      out.add(TrozoMd(m.group(1)!, codigo: true, negrita: negrita, cursiva: cursiva));
    } else if (m.group(2) != null) {
      out.add(TrozoMd(m.group(2)!, enlace: m.group(3), negrita: negrita, cursiva: cursiva));
    } else if (m.group(4) != null || m.group(5) != null) {
      out.addAll(analizarEnLinea(m.group(4) ?? m.group(5)!, negrita: true, cursiva: cursiva));
    } else {
      out.addAll(analizarEnLinea(m.group(6) ?? m.group(7)!, negrita: negrita, cursiva: true));
    }
    desde = m.end;
  }
  if (desde < texto.length) out.add(TrozoMd(texto.substring(desde), negrita: negrita, cursiva: cursiva));
  return out;
}

/// Las celdas de una fila de tabla «| a | b |».
List<String> celdasDeFila(String fila) {
  var f = fila.trim();
  if (f.startsWith('|')) f = f.substring(1);
  if (f.endsWith('|')) f = f.substring(0, f.length - 1);
  return [for (final c in f.split('|')) c.trim()];
}

/// El informe en Markdown, con los estilos de la app y el texto seleccionable.
class MarkdownSimple extends StatelessWidget {
  const MarkdownSimple(this.texto, {super.key});
  final String texto;

  @override
  Widget build(BuildContext context) {
    final base = context.textos.bodyMedium!;
    TextSpan linea(String s, TextStyle estilo) => TextSpan(children: [
          for (final t in analizarEnLinea(s))
            TextSpan(
              text: t.texto,
              style: estilo.copyWith(
                fontWeight: t.negrita ? FontWeight.w700 : null,
                fontStyle: t.cursiva ? FontStyle.italic : null,
                fontFamily: t.codigo ? 'monospace' : null,
                backgroundColor: t.codigo ? context.colores.fondoClaro : null,
                color: t.enlace != null ? context.esquema.primary : null,
                decoration: t.enlace != null ? TextDecoration.underline : null,
              ),
              recognizer: t.enlace == null ? null : (TapGestureRecognizer()..onTap = () => abrirUrl(context, t.enlace!)),
            ),
        ]);
    Widget bloque(BloqueMd b) => switch (b.tipo) {
          TipoBloqueMd.titulo => Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 4),
              child: Text.rich(linea(b.lineas.first, (b.nivel <= 1 ? context.textos.titleLarge : (b.nivel == 2 ? context.textos.titleMedium : context.textos.titleSmall))!.copyWith(color: context.esquema.primary))),
            ),
          TipoBloqueMd.parrafo => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text.rich(linea(b.lineas.first, base))),
          TipoBloqueMd.lista || TipoBloqueMd.numerada => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                for (final (i, item) in b.lineas.indexed)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(width: 22, child: Text(b.tipo == TipoBloqueMd.lista ? '•' : '${i + 1}.', style: base)),
                      Expanded(child: Text.rich(linea(item, base))),
                    ]),
                  ),
              ]),
            ),
          TipoBloqueMd.cita => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
              decoration: BoxDecoration(border: Border(left: BorderSide(color: context.colores.dorado, width: 3))),
              child: Text.rich(linea(b.lineas.first, base.copyWith(fontStyle: FontStyle.italic))),
            ),
          TipoBloqueMd.codigo => Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: context.colores.fondoClaro, borderRadius: BorderRadius.circular(6)),
              child: Text(b.lineas.join('\n'), style: base.copyWith(fontFamily: 'monospace', fontSize: (base.fontSize ?? 14) * 0.9)),
            ),
          TipoBloqueMd.separador => const Divider(height: 20),
          TipoBloqueMd.tabla => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  border: TableBorder.all(color: context.colores.textoClaro.withValues(alpha: 0.3)),
                  children: [
                    for (final (i, fila) in b.lineas.indexed)
                      TableRow(children: [
                        for (final celda in _completar(celdasDeFila(fila), b.lineas.map((f) => celdasDeFila(f).length).fold(0, (a, n) => n > a ? n : a)))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 260), child: Text.rich(linea(celda, i == 0 ? base.copyWith(fontWeight: FontWeight.w700) : base))),
                          ),
                      ]),
                  ],
                ),
              ),
            ),
        };
    return SelectionArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [for (final b in analizarMarkdown(texto)) bloque(b)]));
  }

  static List<String> _completar(List<String> celdas, int n) => [...celdas, for (var i = celdas.length; i < n; i++) ''];
}
