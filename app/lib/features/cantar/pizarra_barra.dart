import 'dart:math';

import 'package:flutter/material.dart';

/// Piezas de la barra de la pizarra, al estilo de Notas del iPad: una paleta
/// clara y flotante con las puntas de las herramientas y los colores.

/// Colores de la barra (clara, para que se vean el negro y el blanco).
const fondoPizarra = Color(0xFFF2F2F7);
const fondoPaleta = Colors.white;
const tintaBarra = Color(0xFF1C1C1E);

/// Herramientas que se eligen en la paleta.
enum HerramientaPizarra { boligrafo, rotulador, fosforito, borrador, lazo }

/// La paleta: blanca, redondeada y con sombra.
class PaletaFlotante extends StatelessWidget {
  const PaletaFlotante({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: fondoPaleta,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, 2))],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: children),
      );
}

/// Separador vertical fino dentro de la paleta.
class SeparadorPaleta extends StatelessWidget {
  const SeparadorPaleta({super.key});
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 28, margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12), color: const Color(0x1F000000));
}

/// Una herramienta como la punta de un lápiz que asoma de la paleta; la
/// elegida sube. Tocar la elegida otra vez abre sus ajustes ([alVolverATocar]).
class PuntaHerramienta extends StatelessWidget {
  const PuntaHerramienta({
    super.key,
    required this.herramienta,
    required this.elegida,
    required this.color,
    required this.grosor,
    required this.nombre,
    required this.alTocar,
    this.alMantener,
  });

  final HerramientaPizarra herramienta;
  final bool elegida;
  final Color color;

  /// 0, 1 o 2 (fino, medio, grueso): la banda de la punta lo enseña.
  final int grosor;
  final String nombre;
  final VoidCallback alTocar;
  final VoidCallback? alMantener;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: nombre,
        child: Semantics(
          button: true,
          selected: elegida,
          label: nombre,
          child: InkWell(
            onTap: alTocar,
            onLongPress: alMantener,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 34,
              height: 52,
              child: ClipRect(
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  offset: Offset(0, elegida ? 0.04 : 0.32),
                  child: CustomPaint(painter: _PintorPunta(herramienta, color, grosor)),
                ),
              ),
            ),
          ),
        ),
      );
}

class _PintorPunta extends CustomPainter {
  _PintorPunta(this.h, this.color, this.grosor);
  final HerramientaPizarra h;
  final Color color;
  final int grosor;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, alto = size.height;
    final cuerpo = Paint()..color = const Color(0xFFFAFAFA);
    final borde = Paint()
      ..color = const Color(0x33000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final x0 = w * 0.22, x1 = w * 0.78;
    switch (h) {
      case HerramientaPizarra.boligrafo:
      case HerramientaPizarra.rotulador:
      case HerramientaPizarra.fosforito:
        final arriba = h == HerramientaPizarra.boligrafo ? alto * 0.30 : alto * 0.26;
        // Cuerpo y cono.
        final r = RRect.fromLTRBR(x0, arriba, x1, alto + 4, const Radius.circular(3));
        canvas.drawRRect(r, cuerpo);
        canvas.drawRRect(r, borde);
        final cono = Path();
        if (h == HerramientaPizarra.fosforito) {
          // Punta biselada.
          cono
            ..moveTo(x0 + 2, arriba)
            ..lineTo(x0 + 4, alto * 0.08)
            ..lineTo(x1 - 2, alto * 0.02)
            ..lineTo(x1 - 2, arriba)
            ..close();
        } else {
          final ancho = h == HerramientaPizarra.rotulador ? w * 0.18 : w * 0.06;
          cono
            ..moveTo(x0, arriba)
            ..lineTo(w / 2 - ancho, alto * 0.06)
            ..lineTo(w / 2 + ancho, alto * 0.06)
            ..lineTo(x1, arriba)
            ..close();
        }
        canvas.drawPath(cono, cuerpo);
        canvas.drawPath(cono, borde);
        // La tinta: la punta y una banda del color (más ancha cuanto más grueso).
        final tinta = Paint()..color = color.withValues(alpha: 1);
        final punta = Path()
          ..moveTo(w / 2 - 3.5, alto * 0.13)
          ..lineTo(w / 2, alto * 0.02)
          ..lineTo(w / 2 + 3.5, alto * 0.13)
          ..close();
        if (h == HerramientaPizarra.fosforito) {
          canvas.drawRect(Rect.fromLTRB(x0 + 4, alto * 0.03, x1 - 2, alto * 0.09), tinta);
        } else {
          canvas.drawPath(punta, tinta);
        }
        canvas.drawRect(Rect.fromLTRB(x0, alto * 0.48, x1, alto * 0.48 + 3.0 + 2.5 * grosor), tinta);
      case HerramientaPizarra.borrador:
        final r = RRect.fromLTRBR(x0 - 1, alto * 0.08, x1 + 1, alto + 4, const Radius.circular(5));
        canvas.drawRRect(r, cuerpo);
        canvas.drawRRect(r, borde);
        canvas.drawRRect(RRect.fromLTRBR(x0 - 1, alto * 0.08, x1 + 1, alto * 0.34, const Radius.circular(5)), Paint()..color = const Color(0xFFF4A7B9));
        canvas.drawRRect(RRect.fromLTRBR(x0 - 1, alto * 0.08, x1 + 1, alto * 0.34, const Radius.circular(5)), borde);
      case HerramientaPizarra.lazo:
        final r = RRect.fromLTRBR(x0, alto * 0.30, x1, alto + 4, const Radius.circular(3));
        canvas.drawRRect(r, cuerpo);
        canvas.drawRRect(r, borde);
        // Un lazo discontinuo encima.
        final lazo = Paint()
          ..color = tintaBarra
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6;
        const n = 10;
        for (var k = 0; k < n; k += 2) {
          canvas.drawArc(Rect.fromCenter(center: Offset(w / 2, alto * 0.16), width: w * 0.62, height: alto * 0.22), 2 * pi * k / n, 2 * pi / n, false, lazo);
        }
    }
  }

  @override
  bool shouldRepaint(_PintorPunta old) => old.h != h || old.color != color || old.grosor != grosor;
}

/// Un color a un toque: con un borde fino (para el blanco y el negro) y un
/// aro cuando está elegido.
class MuestraColor extends StatelessWidget {
  const MuestraColor({super.key, required this.color, required this.elegido, required this.nombre, required this.alTocar});
  final Color color;
  final bool elegido;
  final String nombre;
  final VoidCallback alTocar;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: nombre,
        child: Semantics(
          button: true,
          selected: elegido,
          label: nombre,
          child: InkResponse(
            onTap: alTocar,
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 13),
              child: Container(
                width: 26,
                height: 26,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: elegido ? color.withValues(alpha: 1) : Colors.transparent, width: 2)),
                child: DecoratedBox(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 1), border: Border.all(color: const Color(0x33000000))),
                ),
              ),
            ),
          ),
        ),
      );
}

/// La rueda de todos los colores (abre el selector).
class RuedaColor extends StatelessWidget {
  const RuedaColor({super.key, required this.elegido, required this.color, required this.alTocar});
  final bool elegido;
  final Color color;
  final VoidCallback alTocar;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: 'Otro color',
        child: Semantics(
          button: true,
          label: 'Otro color',
          child: InkResponse(
            onTap: alTocar,
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 13),
              child: Container(
                width: 26,
                height: 26,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: elegido ? color.withValues(alpha: 1) : Colors.transparent, width: 2)),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: elegido
                        ? null
                        : const SweepGradient(colors: [Colors.red, Colors.yellow, Colors.green, Colors.cyan, Colors.blue, Colors.purple, Colors.red]),
                    color: elegido ? color.withValues(alpha: 1) : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

/// Botón de icono oscuro para la barra clara.
class BotonBarra extends StatelessWidget {
  const BotonBarra({super.key, required this.icono, required this.tooltip, required this.alTocar, this.activo = false});
  final IconData icono;
  final String tooltip;
  final VoidCallback? alTocar;
  final bool activo;

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: tooltip,
        isSelected: activo,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(backgroundColor: activo ? const Color(0x1A000000) : null),
        icon: Icon(icono, color: alTocar == null ? const Color(0x55000000) : tintaBarra),
        onPressed: alTocar,
      );
}
