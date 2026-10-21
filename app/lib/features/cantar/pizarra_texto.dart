import 'dart:math';

import 'package:flutter/painting.dart';

import 'pizarra_trazos.dart';

/// Texto escrito a máquina en la pizarra: cómo se mide y cómo se pinta. La
/// letra es siempre la misma (Source Sans 3, la que lleva la app) en el
/// móvil, la tableta, el ordenador y el PDF, para que cada cuadro mida lo
/// mismo en todos.

const letraTexto = 'SourceSans3';

/// Interlineado del texto (en veces el tamaño de letra).
const interlineadoTexto = 1.25;

/// La letra de un texto de [tamano] unidades del lienzo.
TextStyle estiloTexto(int tamano, Color color) => TextStyle(fontFamily: letraTexto, fontSize: tamano.toDouble(), color: color, height: interlineadoTexto);

/// Mide un texto con letra de [tamano], partiendo las líneas a [anchoMax]
/// (unidades del lienzo): el ancho y el alto de su caja.
Size medirTexto(String texto, int tamano, {double anchoMax = anchoMaxTexto * 1.0}) {
  final tp = TextPainter(text: TextSpan(text: texto, style: estiloTexto(tamano, const Color(0xFF000000))), textDirection: TextDirection.ltr)..layout(maxWidth: max(anchoMax, tamano.toDouble()));
  final s = Size(tp.width.ceilToDouble(), tp.height.ceilToDouble());
  tp.dispose();
  return s;
}

final Map<String, TextPainter> _cache = {};

/// Pinta el texto [t] con [color] en un lienzo que ya va en unidades del
/// lienzo (escalado), con las líneas partidas al ancho de su caja.
void pintarTexto(Canvas canvas, Trazo t, Color color) {
  if (!t.esTexto || t.puntos.isEmpty) return;
  final clave = '${t.id}|${color.toARGB32()}';
  final tp = _cache.putIfAbsent(clave, () => TextPainter(text: TextSpan(text: t.texto, style: estiloTexto(t.tamano, color)), textDirection: TextDirection.ltr)..layout(maxWidth: max(t.ancho.toDouble(), t.tamano.toDouble())));
  tp.paint(canvas, Offset(t.puntos.first.x.toDouble(), t.puntos.first.y.toDouble()));
  if (_cache.length > 500) {
    for (final p in _cache.values) {
      p.dispose();
    }
    _cache.clear();
  }
}
