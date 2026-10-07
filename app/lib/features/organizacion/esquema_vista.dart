import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/models/estructura.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Esquema interactivo del temario: las casillas, marcos y flechas del
/// PowerPoint de organización, con zoom y desplazamiento. Al tocar un tema o
/// el rótulo de un bloque se resaltan sus conexiones.
class EsquemaVista extends StatefulWidget {
  const EsquemaVista({
    super.key,
    required this.estructura,
    required this.esquema,
    required this.temario,
    required this.estudiados,
    required this.verProgreso,
    required this.alAbrirTema,
    required this.alAbrirBloque,
    this.alAlternarEstudiado,
    this.seleccionInicial,
  });

  final EstructuraTemario estructura;
  final Esquema esquema;
  final Temario? temario;
  final Set<String> estudiados;
  /// Apaga los temas aún no estudiados.
  final bool verProgreso;
  final ValueChanged<String> alAbrirTema;
  final ValueChanged<String> alAbrirBloque;
  /// Sin él (preparador) no se marca nada como estudiado.
  final ValueChanged<String>? alAlternarEstudiado;
  final Extremo? seleccionInicial;

  @override
  State<EsquemaVista> createState() => _EsquemaVistaState();
}

class _EsquemaVistaState extends State<EsquemaVista> {
  static const _ancho = 1500.0;
  final _control = TransformationController();
  late Extremo? _sel = widget.seleccionInicial;
  Size? _encajadoPara;
  bool _encajadoAlgunaVez = false;

  double get _alto => _ancho / widget.estructura.proporcion;

  @override
  void didUpdateWidget(EsquemaVista old) {
    super.didUpdateWidget(old);
    if (old.esquema.id != widget.esquema.id) {
      _sel = null;
      _encajadoPara = null;
    }
  }

  @override
  void dispose() {
    _control.dispose();
    super.dispose();
  }

  /// Encaja el esquema en la pantalla: a lo alto en vertical, entero en horizontal.
  void _encajar(Size vista) {
    if (_encajadoPara != null) return;
    final primera = !_encajadoAlgunaVez;
    _encajadoPara = vista;
    _encajadoAlgunaVez = true;
    final escala = max(vista.width / _ancho, min(vista.height / _alto, 0.62));
    final matriz = Matrix4.diagonal3Values(escala, escala, 1);
    if (primera) {
      _control.value = matriz;
    } else {
      // Al cambiar de esquema el visor ya escucha al controlador: se espera al final del fotograma.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _control.value = matriz;
      });
    }
  }

  void _tocar(Offset p) {
    final n = Offset(p.dx / _ancho, p.dy / _alto);
    Extremo? nuevo;
    for (final nodo in widget.esquema.nodos) {
      if (nodo.rect.inflate(0.004).contains(n) && (nuevo == null || !nodo.repetido)) nuevo = Extremo.tema(nodo.tema);
    }
    if (nuevo == null) {
      for (final e in widget.esquema.etiquetas) {
        if (e.rect.inflate(0.006).contains(n)) nuevo = Extremo.bloque(e.bloque);
      }
    }
    setState(() => _sel = nuevo == _sel ? null : nuevo);
  }

  /// Claves (temas o bloques) que se mantienen encendidos con la selección actual.
  Set<String> _encendidos() {
    final sel = _sel;
    if (sel == null) return const {};
    final out = <String>{sel.clave};
    if (!sel.esTema) out.addAll(widget.estructura.bloque(sel.bloque!)?.temas ?? const []);
    for (final c in widget.esquema.conexiones) {
      if (c.toca(sel)) out.add(c.otro(sel).clave);
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final encendidos = _encendidos();
    return Column(children: [
      Expanded(
        child: LayoutBuilder(builder: (context, c) {
          final vista = Size(c.maxWidth, c.maxHeight);
          _encajar(vista);
          return ClipRect(
            child: ColoredBox(
              color: context.colores.superficie,
              child: InteractiveViewer(
                transformationController: _control,
                constrained: false,
                minScale: min(vista.width / _ancho, 0.2),
                maxScale: 4,
                boundaryMargin: const EdgeInsets.all(120),
                child: GestureDetector(
                  onTapUp: (d) => _tocar(d.localPosition),
                  child: CustomPaint(
                    size: Size(_ancho, _alto),
                    painter: _PintorEsquema(
                      estructura: widget.estructura,
                      esquema: widget.esquema,
                      seleccion: _sel,
                      encendidos: encendidos,
                      estudiados: widget.estudiados,
                      verProgreso: widget.verProgreso,
                      tinta: context.esquema.onSurface,
                      oscuro: context.temaOscuro,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
      _panel(context),
    ]);
  }

  /// Ficha de lo seleccionado, bajo el esquema.
  Widget _panel(BuildContext context) {
    final sel = _sel;
    final e = widget.estructura;
    Widget contenido;
    if (sel == null) {
      contenido = Text('Toca un tema o el nombre de un bloque para ver con qué conecta. Pellizca para ampliar.', style: context.textos.bodySmall);
    } else if (sel.esTema) {
      final codigo = sel.tema!;
      final bloque = e.bloqueDe(codigo);
      final estudiado = widget.estudiados.contains(codigo);
      final otros = [for (final c in widget.esquema.conexiones) if (c.toca(sel)) c.otro(sel)];
      contenido = Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CasillaTema(codigo, color: bloque?.color ?? context.esquema.primary, grande: true),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.temario?.tema(codigo)?.titulo ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
              if (bloque != null) Text(bloque.nombre, style: context.textos.labelSmall),
            ]),
          ),
          if (widget.alAlternarEstudiado != null) IconButton(
            tooltip: estudiado ? 'Estudiado' : 'Marcar estudiado',
            visualDensity: VisualDensity.compact,
            icon: Icon(estudiado ? Icons.check_circle : Icons.circle_outlined, color: estudiado ? Paleta.acierto : context.colores.textoClaro),
            onPressed: () => widget.alAlternarEstudiado!(codigo),
          ),
        ]),
        if (e.ideas[codigo] != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(e.ideas[codigo]!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 14, color: context.colores.textoSuave))),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
            child: otros.isEmpty
                ? Text('Sin conexiones en este esquema.', style: context.textos.labelSmall)
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      Text('Conecta con  ', style: context.textos.labelSmall),
                      for (final o in otros) Padding(padding: const EdgeInsets.only(right: 6), child: _casilla(context, o)),
                    ]),
                  ),
          ),
          TextButton(onPressed: () => widget.alAbrirTema(codigo), child: const Text('Abrir')),
        ]),
      ]);
    } else {
      final bloque = e.bloque(sel.bloque!);
      final hechos = bloque == null ? 0 : bloque.temas.where(widget.estudiados.contains).length;
      contenido = Row(children: [
        if (bloque != null) Container(width: 14, height: 36, decoration: BoxDecoration(color: bloque.color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(bloque?.nombre ?? '', style: context.textos.titleSmall),
            Text('${bloque?.categoria ?? ''} · $hechos de ${bloque?.temas.length ?? 0} estudiados', style: context.textos.labelSmall),
          ]),
        ),
        TextButton(onPressed: () => widget.alAbrirBloque(sel.bloque!), child: const Text('Ver bloque')),
      ]);
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
      decoration: BoxDecoration(color: context.colores.crema, border: Border(top: BorderSide(color: context.colores.borde))),
      child: AnimatedSize(duration: const Duration(milliseconds: 150), alignment: Alignment.topCenter, child: contenido),
    );
  }

  Widget _casilla(BuildContext context, Extremo o) {
    final e = widget.estructura;
    if (o.esTema) {
      return CasillaTema(o.tema!, color: e.colorDe(o.tema!) ?? context.esquema.primary, onTap: () => setState(() => _sel = o));
    }
    final b = e.bloque(o.bloque!);
    return GestureDetector(
      onTap: () => setState(() => _sel = o),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(border: Border.all(color: b?.color ?? context.colores.borde, width: 1.5), borderRadius: BorderRadius.circular(3)),
        child: Text(b?.nombre ?? '', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w600, color: context.esquema.onSurface)),
      ),
    );
  }
}

class _PintorEsquema extends CustomPainter {
  _PintorEsquema({
    required this.estructura,
    required this.esquema,
    required this.seleccion,
    required this.encendidos,
    required this.estudiados,
    required this.verProgreso,
    required this.tinta,
    required this.oscuro,
  });

  final EstructuraTemario estructura;
  final Esquema esquema;
  final Extremo? seleccion;
  final Set<String> encendidos;
  final Set<String> estudiados;
  final bool verProgreso;
  final Color tinta;
  final bool oscuro;

  /// Los colores muy claros del PowerPoint se oscurecen para rótulos y líneas.
  Color _legible(Color c) {
    final hsl = HSLColor.fromColor(c);
    if (oscuro) return hsl.lightness < 0.55 ? hsl.withLightness(0.6).toColor() : c;
    return hsl.lightness > 0.5 ? hsl.withLightness(0.42).toColor() : c;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect abs(Rect r) => Rect.fromLTWH(r.left * size.width, r.top * size.height, r.width * size.width, r.height * size.height);
    final haySeleccion = seleccion != null;

    // Marcos de bloque (discontinuos) y sus rótulos.
    for (final m in esquema.marcos) {
      final b = estructura.bloque(m.bloque);
      if (b == null) continue;
      final vivo = !haySeleccion || encendidos.contains(m.bloque);
      final pincel = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..color = _legible(b.color).withValues(alpha: vivo ? 0.9 : 0.2);
      _discontinuo(canvas, Path()..addRRect(RRect.fromRectAndRadius(abs(m.rect), const Radius.circular(8))), pincel, 7, 4);
    }
    for (final m in esquema.etiquetas) {
      final b = estructura.bloque(m.bloque);
      if (b == null) continue;
      final r = abs(m.rect);
      final vivo = !haySeleccion || encendidos.contains(m.bloque);
      final tp = TextPainter(
        text: TextSpan(text: b.nombre, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12.5, fontWeight: seleccion?.bloque == m.bloque ? FontWeight.w700 : FontWeight.w600, height: 1.1, color: _legible(b.color).withValues(alpha: vivo ? 1 : 0.3))),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: max(r.width, 90));
      tp.paint(canvas, Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2));
    }

    // Conexiones.
    for (final c in esquema.conexiones) {
      final ra = esquema.rectDe(c.de), rb = esquema.rectDe(c.a);
      if (ra == null || rb == null) continue;
      final a = abs(ra), b = abs(rb);
      final vivo = !haySeleccion || c.toca(seleccion!);
      final p1 = _borde(a, b.center), p2 = _borde(b, a.center);
      if ((p2 - p1).distance < 2) continue;
      final pincel = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = haySeleccion && vivo ? 2.6 : 1.4
        ..color = _legible(c.color).withValues(alpha: vivo ? 0.95 : 0.1);
      final camino = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy);
      if (c.discontinua) {
        _discontinuo(canvas, camino, pincel, 8, 5);
      } else {
        canvas.drawPath(camino, pincel);
      }
      final relleno = Paint()..color = pincel.color;
      if (c.flechaA) _punta(canvas, p1, p2, relleno);
      if (c.flechaDe) _punta(canvas, p2, p1, relleno);
    }

    // Casillas de los temas.
    for (final n in esquema.nodos) {
      final r = abs(n.rect);
      final color = estructura.colorDe(n.tema) ?? const Color(0xFF9E9E9E);
      final elegido = seleccion?.tema == n.tema;
      double opacidad = n.repetido ? 0.45 : 1;
      if (haySeleccion) {
        if (!encendidos.contains(n.tema)) opacidad = 0.14;
      } else if (verProgreso && !estudiados.contains(n.tema)) {
        opacidad = 0.22;
      }
      final caja = RRect.fromRectAndRadius(r, const Radius.circular(3));
      canvas.drawRRect(caja, Paint()..color = color.withValues(alpha: opacidad));
      if (elegido) {
        canvas.drawRRect(caja.inflate(2.5), Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = tinta);
      } else if (n.repetido || opacidad < 0.5) {
        canvas.drawRRect(caja, Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = color.withValues(alpha: min(1, opacidad + 0.35)));
      }
      final sobre = opacidad < 0.5 ? tinta.withValues(alpha: haySeleccion ? 0.3 : 0.6) : textoSobre(color);
      final tp = TextPainter(
        text: TextSpan(text: n.tema, style: TextStyle(fontFamily: Fuentes.sans, fontSize: min(r.height * 0.58, r.width * 0.26), fontWeight: FontWeight.w600, height: 1, color: sobre)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(r.center.dx - tp.width / 2, r.center.dy - tp.height / 2));
    }
  }

  /// Punto del borde de [r] en la dirección de [hacia].
  Offset _borde(Rect r, Offset hacia) {
    final c = r.center;
    final d = hacia - c;
    if (d.distance == 0) return c;
    final tx = d.dx == 0 ? double.infinity : (r.width / 2) / d.dx.abs();
    final ty = d.dy == 0 ? double.infinity : (r.height / 2) / d.dy.abs();
    return c + d * min(min(tx, ty), 1);
  }

  void _punta(Canvas canvas, Offset desde, Offset hasta, Paint pincel) {
    final v = hasta - desde;
    if (v.distance < 5) return;
    final u = v / v.distance;
    final n = Offset(-u.dy, u.dx);
    // En conexiones muy cortas (casillas contiguas) las puntas se encogen para no pisarse.
    final largo = min(9.0, v.distance * 0.42), ancho = largo * 0.45;
    canvas.drawPath(
      Path()
        ..moveTo(hasta.dx, hasta.dy)
        ..lineTo(hasta.dx - u.dx * largo + n.dx * ancho, hasta.dy - u.dy * largo + n.dy * ancho)
        ..lineTo(hasta.dx - u.dx * largo - n.dx * ancho, hasta.dy - u.dy * largo - n.dy * ancho)
        ..close(),
      pincel,
    );
  }

  void _discontinuo(Canvas canvas, Path camino, Paint pincel, double trazo, double hueco) {
    for (final m in camino.computeMetrics()) {
      for (var d = 0.0; d < m.length; d += trazo + hueco) {
        canvas.drawPath(m.extractPath(d, min(d + trazo, m.length)), pincel);
      }
    }
  }

  @override
  bool shouldRepaint(_PintorEsquema old) =>
      old.esquema != esquema || old.seleccion != seleccion || old.verProgreso != verProgreso || old.estudiados != estudiados || old.oscuro != oscuro;
}
