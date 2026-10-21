import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;

import 'pizarra_texto.dart';
import 'pizarra_tinta.dart';
import 'pizarra_trazos.dart';

/// La pizarra (y las anotaciones de un tema) en un PDF: los trazos como
/// vectores, el fosforito multiplicado con el papel y el texto a máquina con
/// la misma letra que en pantalla.

/// La letra del texto a máquina, para incrustarla en el PDF (null si no se
/// puede leer: el texto se dibuja entonces con la letra estándar del PDF).
Future<ByteData?> letraParaPdf() async {
  try {
    return await rootBundle.load('assets/fonts/SourceSans3-Regular.ttf');
  } catch (_) {
    return null;
  }
}

/// La letra de un documento: la incrustada si hay bytes, si no Helvetica.
pdf.PdfFont letraDe(pdf.PdfDocument documento, ByteData? letra) => letra == null ? pdf.PdfFont.helvetica(documento) : pdf.PdfTtfFont(documento, letra);

/// Dibuja [trazos] en [g]: [escala] pasa de unidades del lienzo a puntos del
/// PDF y [alto] es la altura de la página (el PDF cuenta desde abajo).
void dibujarTrazosPdf(pdf.PdfGraphics g, List<Trazo> trazos, {required double escala, required double alto, required int Function(Trazo t) colorDe, required pdf.PdfFont letra}) {
  for (final fosforito in [true, false]) {
    for (final t in trazos) {
      if (t.esFosforito != fosforito) continue;
      final argb = colorDe(t);
      g.saveContext();
      g.setGraphicState(pdf.PdfGraphicState(opacity: ((argb >> 24) & 0xff) / 255, blendMode: fosforito ? pdf.PdfBlendMode.multiply : pdf.PdfBlendMode.normal));
      g.setFillColor(pdf.PdfColor.fromInt(argb | 0xFF000000));
      if (t.esTexto) {
        _texto(g, t, letra, escala, alto);
      } else {
        for (final c in contornosDeTrazo(t)) {
          g.moveTo(c.first.dx * escala, alto - c.first.dy * escala);
          for (final p in c.skip(1)) {
            g.lineTo(p.dx * escala, alto - p.dy * escala);
          }
          g.closePath();
        }
        g.fillPath();
      }
      g.restoreContext();
    }
  }
}

/// El texto, línea a línea, partido al ancho de su caja con la métrica de la
/// letra del PDF (puede partir en otro sitio que en pantalla, pero no se sale
/// de la caja).
void _texto(pdf.PdfGraphics g, Trazo t, pdf.PdfFont letra, double escala, double alto) {
  final tamano = t.tamano * escala;
  final anchoCaja = t.ancho * escala;
  final x = t.puntos.first.x * escala;
  var y = t.puntos.first.y * escala + tamano * 0.9;
  double ancho(String s) => letra.stringMetrics(s).advanceWidth * tamano;
  for (final parrafo in t.texto!.split('\n')) {
    var linea = '';
    for (final palabra in parrafo.split(' ')) {
      final prueba = linea.isEmpty ? palabra : '$linea $palabra';
      if (linea.isNotEmpty && ancho(prueba) > anchoCaja) {
        g.drawString(letra, tamano, linea, x, alto - y);
        y += tamano * interlineadoTexto;
        linea = palabra;
      } else {
        linea = prueba;
      }
    }
    g.drawString(letra, tamano, linea, x, alto - y);
    y += tamano * interlineadoTexto;
  }
}

/// Las páginas de una pizarra en un PDF apaisado (una por página, con su
/// papel). [colorDe] da el color ARGB de cada trazo.
Future<Uint8List> pdfPizarra(List<PaginaPizarra> paginas, {required int Function(Trazo t) colorDe, ByteData? letra, String titulo = 'Pizarra'}) async {
  final salida = pw.Document(title: titulo, creator: 'Oposición TCEE');
  final fuente = letraDe(salida.document, letra);
  // A4 apaisado de ancho; el alto, el del lienzo (16:10).
  const ancho = 842.0;
  const alto = ancho * altoLienzo / anchoLienzo;
  const escala = ancho / anchoLienzo;
  for (final p in paginas) {
    salida.addPage(pw.Page(
      pageFormat: const pdf.PdfPageFormat(ancho, alto),
      margin: pw.EdgeInsets.zero,
      build: (_) => pw.CustomPaint(
        size: const pdf.PdfPoint(ancho, alto),
        painter: (g, size) {
          _fondo(g, p.fondo, escala, alto);
          dibujarTrazosPdf(g, p.trazos, escala: escala, alto: alto, colorDe: colorDe, letra: fuente);
        },
      ),
    ));
  }
  return salida.save();
}

/// Las rayas o la cuadrícula del papel.
void _fondo(pdf.PdfGraphics g, String fondo, double escala, double alto) {
  if (fondo == fondoBlanco) return;
  g.saveContext();
  g.setStrokeColor(pdf.PdfColor.fromInt(fondo == fondoRayas ? 0xFFB9CDE5 : 0xFFDADDE2));
  g.setLineWidth(0.6);
  for (var y = pasoFondo; y < altoLienzo; y += pasoFondo) {
    g.drawLine(0, alto - y * escala, anchoLienzo * escala, alto - y * escala);
  }
  if (fondo == fondoCuadricula) {
    for (var x = pasoFondo; x < anchoLienzo; x += pasoFondo) {
      g.drawLine(x * escala, 0, x * escala, alto);
    }
  }
  g.strokePath();
  g.restoreContext();
}
