import 'dart:math';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Valores de la tabla del Excel listos para dibujar: [valores][y][x] con
/// x = temas sabidos de la parte A e y = de la parte B, entre 0 y 1.
class TablaGrafico {
  const TablaGrafico({required this.valores, required this.x, required this.y});
  final List<List<double>> valores;
  /// Posición del opositor (temas que se sabe de cada parte).
  final int x;
  final int y;

  int get columnas => valores.first.length;
  int get filas => valores.length;
}

/// Mapa de calor en 2D: columnas = parte A, filas = parte B (0 abajo).
class MapaCalor extends StatelessWidget {
  const MapaCalor({super.key, required this.tabla});
  final TablaGrafico tabla;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: tabla.columnas / tabla.filas,
        child: CustomPaint(painter: _PintorCalor(tabla: tabla, marcador: context.esquema.onSurface, base: context.esquema.primary, fondo: context.colores.fondoClaro)),
      );
}

class _PintorCalor extends CustomPainter {
  _PintorCalor({required this.tabla, required this.marcador, required this.base, required this.fondo});
  final TablaGrafico tabla;
  final Color marcador;
  final Color base;
  final Color fondo;

  @override
  void paint(Canvas canvas, Size size) {
    final ancho = size.width / tabla.columnas, alto = size.height / tabla.filas;
    final pincel = Paint();
    for (var y = 0; y < tabla.filas; y++) {
      for (var x = 0; x < tabla.columnas; x++) {
        pincel.color = Color.lerp(fondo, base, tabla.valores[y][x].clamp(0, 1))!;
        canvas.drawRect(Rect.fromLTWH(x * ancho, size.height - (y + 1) * alto, ancho + 0.5, alto + 0.5), pincel);
      }
    }
    final centro = Offset((tabla.x + 0.5) * ancho, size.height - (tabla.y + 0.5) * alto);
    canvas.drawCircle(centro, 6, Paint()..color = Colors.white);
    canvas.drawCircle(centro, 4, Paint()..color = marcador);
  }

  @override
  bool shouldRepaint(_PintorCalor old) => old.tabla != tabla || old.base != base || old.fondo != fondo;
}

/// La misma tabla como superficie en 3D: la altura es el valor. Se gira
/// arrastrando en horizontal.
class Superficie3D extends StatefulWidget {
  const Superficie3D({super.key, required this.tabla, this.etiquetaX = 'Parte A', this.etiquetaY = 'Parte B'});
  final TablaGrafico tabla;
  final String etiquetaX;
  final String etiquetaY;

  @override
  State<Superficie3D> createState() => _Superficie3DState();
}

class _Superficie3DState extends State<Superficie3D> {
  double _giro = -0.65; // radianes alrededor del eje vertical

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.25,
        child: GestureDetector(
          // Solo el arrastre horizontal: el vertical sigue desplazando la página.
          onHorizontalDragUpdate: (d) => setState(() => _giro += d.delta.dx * 0.01),
          child: CustomPaint(
            painter: _PintorSuperficie(
              tabla: widget.tabla,
              giro: _giro,
              base: context.esquema.primary,
              fondo: context.colores.fondoClaro,
              tinta: context.esquema.onSurface,
              suave: context.colores.textoSuave,
              etiquetaX: widget.etiquetaX,
              etiquetaY: widget.etiquetaY,
            ),
          ),
        ),
      );
}

class _PintorSuperficie extends CustomPainter {
  _PintorSuperficie({required this.tabla, required this.giro, required this.base, required this.fondo, required this.tinta, required this.suave, required this.etiquetaX, required this.etiquetaY});
  final TablaGrafico tabla;
  final double giro;
  final Color base;
  final Color fondo;
  final Color tinta;
  final Color suave;
  final String etiquetaX;
  final String etiquetaY;

  static const _inclinacion = 0.5; // radianes sobre el plano del suelo
  static const _altura = 0.55;     // altura de la superficie respecto al lado de la base

  @override
  void paint(Canvas canvas, Size size) {
    final nx = tabla.columnas - 1, ny = tabla.filas - 1;
    final escala = size.width * 0.6;
    final origen = Offset(size.width / 2, size.height * 0.66);
    final c = cos(giro), s = sin(giro);

    // (x, y) en [-0,5; 0,5] sobre el suelo y z hacia arriba → pantalla y profundidad.
    ({Offset p, double fondo}) proyectar(double x, double y, double z) {
      final xr = x * c - y * s, yr = x * s + y * c;
      return (p: origen + Offset(xr * escala, (yr * sin(_inclinacion) - z * _altura * cos(_inclinacion)) * escala), fondo: yr);
    }

    ({Offset p, double fondo}) punto(int i, int j) => proyectar(i / nx - 0.5, j / ny - 0.5, tabla.valores[j][i].clamp(0, 1));

    // Suelo.
    final suelo = [proyectar(-0.5, -0.5, 0).p, proyectar(0.5, -0.5, 0).p, proyectar(0.5, 0.5, 0).p, proyectar(-0.5, 0.5, 0).p];
    canvas.drawPath(Path()..addPolygon(suelo, true), Paint()..color = fondo.withValues(alpha: 0.6));
    canvas.drawPath(Path()..addPolygon(suelo, true), Paint()
      ..style = PaintingStyle.stroke
      ..color = suave.withValues(alpha: 0.5));

    // Caras de la superficie, de la más lejana a la más cercana.
    final caras = <({double fondo, Path camino, double valor})>[];
    for (var j = 0; j < ny; j++) {
      for (var i = 0; i < nx; i++) {
        final a = punto(i, j), b = punto(i + 1, j), d = punto(i + 1, j + 1), e = punto(i, j + 1);
        caras.add((
          fondo: (a.fondo + b.fondo + d.fondo + e.fondo) / 4,
          camino: Path()..addPolygon([a.p, b.p, d.p, e.p], true),
          valor: (tabla.valores[j][i] + tabla.valores[j][i + 1] + tabla.valores[j + 1][i + 1] + tabla.valores[j + 1][i]) / 4,
        ));
      }
    }
    caras.sort((p, q) => p.fondo.compareTo(q.fondo));
    final relleno = Paint();
    final malla = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4
      ..color = Colors.white.withValues(alpha: 0.35);
    for (final cara in caras) {
      relleno.color = Color.lerp(fondo, base, cara.valor.clamp(0, 1))!;
      canvas.drawPath(cara.camino, relleno);
      canvas.drawPath(cara.camino, malla);
    }

    // Posición del opositor: un poste desde el suelo hasta la superficie.
    final px = tabla.x / nx - 0.5, py = tabla.y / ny - 0.5;
    final pie = proyectar(px, py, 0).p, cima = punto(tabla.x, tabla.y).p;
    canvas.drawLine(pie, cima, Paint()
      ..color = tinta
      ..strokeWidth = 1.5);
    canvas.drawCircle(cima, 6, Paint()..color = Colors.white);
    canvas.drawCircle(cima, 4, Paint()..color = tinta);

    // Rótulos de los ejes en el centro de dos lados del suelo.
    void rotulo(String texto, Offset p) {
      final tp = TextPainter(text: TextSpan(text: texto, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11.5, fontWeight: FontWeight.w600, color: suave)), textDirection: TextDirection.ltr)..layout();
      final fuera = p - origen;
      final d = fuera.distance == 0 ? Offset.zero : fuera / fuera.distance * 16;
      tp.paint(canvas, p + d - Offset(tp.width / 2, tp.height / 2));
    }

    // Se rotula el lado de cada eje que queda más cerca del espectador.
    final ladoX = proyectar(0, -0.5, 0).fondo > proyectar(0, 0.5, 0).fondo ? -0.5 : 0.5;
    final ladoY = proyectar(-0.5, 0, 0).fondo > proyectar(0.5, 0, 0).fondo ? -0.5 : 0.5;
    rotulo('$etiquetaX →', proyectar(0, ladoX, 0).p);
    rotulo('$etiquetaY →', proyectar(ladoY, 0, 0).p);
  }

  @override
  bool shouldRepaint(_PintorSuperficie old) => old.tabla != tabla || old.giro != giro || old.base != base;
}
