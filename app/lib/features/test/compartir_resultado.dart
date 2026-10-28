import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/plataforma.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';

/// La imagen de un resultado para compartirla (WhatsApp, Instagram…): nota,
/// aciertos, fecha y, si la hay, la línea del reto, con la marca de la app y
/// la estética «edición académica» (morado como tinta, salvia como papel,
/// filete dorado). Se dibuja con `dart:ui` (no hace falta montar widgets) y
/// sale como PNG cuadrado de 1080 px.
Future<Uint8List> imagenResultado(ResultadoTest r, {required String siglas, String? reto, String titulo = 'Test'}) async {
  const lado = 1080.0;
  const morado = Color(0xFF5F2987), salvia = Color(0xFFE2EFD9), dorado = Color(0xFFB8860B), tinta = Color(0xFF2B1B3D);
  final rec = ui.PictureRecorder();
  final c = Canvas(rec, const Rect.fromLTWH(0, 0, lado, lado));
  c.drawRect(const Rect.fromLTWH(0, 0, lado, lado), Paint()..color = salvia);
  c.drawRect(const Rect.fromLTWH(0, 0, lado, 300), Paint()..color = morado);
  c.drawRect(const Rect.fromLTWH(0, 300, lado, 6), Paint()..color = dorado);

  void texto(String s, {required double y, required double tamano, Color color = tinta, String? familia, FontWeight peso = FontWeight.w400, double? x, double ancho = lado - 120, TextAlign alinear = TextAlign.center}) {
    final pb = ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: alinear, fontFamily: familia ?? Fuentes.sans, fontSize: tamano, fontWeight: peso))
      ..pushStyle(ui.TextStyle(color: color, fontFamily: familia ?? Fuentes.sans, fontSize: tamano, fontWeight: peso))
      ..addText(s);
    final p = pb.build()..layout(ui.ParagraphConstraints(width: ancho));
    c.drawParagraph(p, Offset(x ?? (lado - ancho) / 2, y));
  }

  texto('$titulo · $siglas', y: 70, tamano: 44, color: Colors.white, familia: Fuentes.serif, peso: FontWeight.w700);
  texto(DateFormat("d 'de' MMMM 'de' y", 'es').format(r.timestamp), y: 140, tamano: 30, color: Colors.white.withValues(alpha: 0.85));
  texto(r.correctas * 2 >= r.totalPreguntas ? 'Aprobado' : 'Resultado', y: 200, tamano: 34, color: Colors.white.withValues(alpha: 0.9), familia: Fuentes.serif);
  texto('${r.notaSobre10.toStringAsFixed(2).replaceAll('.', ',')} / 10', y: 360, tamano: 170, color: morado, peso: FontWeight.w600);
  texto('${r.correctas} aciertos · ${r.incorrectas} fallos · ${r.sinResponder} en blanco', y: 580, tamano: 40);
  texto('${r.totalPreguntas} preguntas${r.tiempoSeconds > 0 ? ' · ${r.tiempoSeconds ~/ 60} min' : ''}', y: 640, tamano: 34, color: tinta.withValues(alpha: 0.7));
  if (reto != null) {
    c.drawRect(const Rect.fromLTWH(140, 720, lado - 280, 2), Paint()..color = dorado);
    texto(reto, y: 745, tamano: 32, color: morado, ancho: lado - 200);
  }
  c.drawRect(const Rect.fromLTWH(0, lado - 130, lado, 130), Paint()..color = morado);
  texto('Oposición TCEE · DCE', y: lado - 108, tamano: 36, color: Colors.white, familia: Fuentes.serif, peso: FontWeight.w700);
  texto('victorgutierrezmarcos.es/app', y: lado - 60, tamano: 28, color: dorado);

  final img = await rec.endRecording().toImage(lado.toInt(), lado.toInt());
  final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
  img.dispose();
  return bytes!.buffer.asUint8List();
}

/// Genera la imagen y la comparte (hoja del sistema en el móvil; descarga en el navegador).
Future<void> compartirImagenResultado(BuildContext context, ResultadoTest r, {required String siglas, String? reto, String titulo = 'Test'}) async {
  final bytes = await imagenResultado(r, siglas: siglas, reto: reto, titulo: titulo);
  final dia = DateFormat('yyyy-MM-dd').format(r.timestamp);
  await guardarBytes(nombre: '${titulo == 'Test diario' ? 'test-diario' : 'test'}-$siglas-$dia.png', bytes: bytes, mime: 'image/png', asunto: '$titulo $siglas: ${r.notaSobre10.toStringAsFixed(1).replaceAll('.', ',')}/10');
}
