import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Pantalla de arranque de la app (Android): sigue a la del sistema
/// (res/drawable/arranque_animado.xml) con la misma diana en el mismo sitio,
/// mientras se crean los servicios. Si tarda, aparece el nombre debajo. Al
/// estar [listo], la diana crece un poco y se desvanece sobre la app, y se
/// llama a [alTerminar] para quitarla.
class Arranque extends StatefulWidget {
  const Arranque({super.key, required this.listo, required this.alTerminar});
  final bool listo;
  final VoidCallback alTerminar;

  @override
  State<Arranque> createState() => _ArranqueState();
}

class _ArranqueState extends State<Arranque> with TickerProviderStateMixin {
  late final _salida = AnimationController(vsync: this, duration: const Duration(milliseconds: 420))
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.alTerminar();
    });
  // El nombre solo si la carga se alarga (sin red, buscando la oposición de la cuenta…).
  late final _nombre = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    if (widget.listo) {
      _salida.forward();
    } else {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted && !widget.listo) _nombre.forward();
      });
    }
  }

  @override
  void didUpdateWidget(Arranque antes) {
    super.didUpdateWidget(antes);
    if (widget.listo && !antes.listo) _salida.forward();
  }

  @override
  void dispose() {
    _salida.dispose();
    _nombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Va por encima de MaterialApp (sin MediaQuery): el tema del sistema, como el arranque nativo.
    final oscuro = View.of(context).platformDispatcher.platformBrightness == Brightness.dark;
    // Los mismos que res/values*/colors.xml (arranque_fondo).
    final fondo = oscuro ? const Color(0xFF16131A) : PaletaNeutra.fondo;
    final tinta = oscuro ? const Color(0xFFECE6EF) : PaletaNeutra.tinta;
    return IgnorePointer(
      ignoring: widget.listo,
      child: AnimatedBuilder(
        animation: Listenable.merge([_salida, _nombre]),
        builder: (context, _) {
          final t = Curves.easeInCubic.transform(_salida.value);
          final n = Curves.easeOut.transform(_nombre.value) * (1 - t);
          return Opacity(
            opacity: 1 - t,
            child: ColoredBox(
              color: fondo,
              child: Stack(alignment: Alignment.center, children: [
                Transform.scale(scale: 1 + 0.18 * t, child: const CustomPaint(size: Size.square(240), painter: _Diana())),
                // Debajo del disco (160 de diámetro, centrado).
                Transform.translate(
                  offset: Offset(0, 118 + 6 * (1 - n)),
                  child: Opacity(
                    opacity: n,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('Oposición TCEE · DCE',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontFamily: 'Pagella', fontSize: 20, letterSpacing: 0.3, color: tinta, decoration: TextDecoration.none)),
                      const SizedBox(height: 10),
                      Container(width: 40, height: 1.5, color: oscuro ? const Color(0xFFD9AE45) : PaletaNeutra.dorado),
                    ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

/// La diana del icono (assets/icon/icon.svg) a escala 0,15: disco de 160 en un
/// lienzo de 240, mitad TCEE (morado) y mitad DCE (granate). La misma
/// geometría que res/drawable/diana_arranque.xml.
class _Diana extends CustomPainter {
  const _Diana();

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final k = size.width / 240;
    for (final (izq, disco, aro) in [(true, const Color(0xFF5F2987), const Color(0xFFE2EFD9)), (false, const Color(0xFF7A1F4B), const Color(0xFFF7F4EC))]) {
      canvas.save();
      canvas.clipRect(izq ? Rect.fromLTRB(0, 0, c.dx, size.height) : Rect.fromLTRB(c.dx, 0, size.width, size.height));
      canvas.drawCircle(c, 80 * k, Paint()..color = disco);
      final trazo = Paint()
        ..color = aro
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9 * k;
      canvas.drawCircle(c, 43.5 * k, trazo);
      canvas.drawCircle(c, 24 * k, trazo);
      canvas.drawCircle(c, 8.7 * k, Paint()..color = aro);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_Diana antes) => false;
}
