import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import 'pizarra_compartida.dart';
import 'pizarra_trazos.dart';

/// Abre la pizarra de la clase [canteId] del alumno [alumnoUid] a pantalla
/// completa, con [otroNombre] (el otro: el alumno o el preparador).
Future<void> abrirPizarra(BuildContext context, {required String alumnoUid, required String canteId, required String otroNombre, FirebaseFirestore? db}) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => PizarraPage(alumnoUid: alumnoUid, canteId: canteId, otroNombre: otroNombre, db: db)));

/// Pizarra compartida de una clase: un lienzo en blanco en el que dibujan el
/// preparador y el alumno, cada uno con su color, y lo que pinta uno le llega
/// al otro al instante. Solo se comparte lo que se dibuja aquí, nada más del
/// móvil. Sirve en el móvil, la tableta y el ordenador (versión web).
class PizarraPage extends ConsumerStatefulWidget {
  const PizarraPage({super.key, required this.alumnoUid, required this.canteId, required this.otroNombre, this.db});
  final String alumnoUid;
  final String canteId;
  final String otroNombre;

  /// Base de datos (por defecto, la de Firebase; en las capturas, una simulada).
  final FirebaseFirestore? db;

  @override
  ConsumerState<PizarraPage> createState() => _PizarraPageState();
}

class _PizarraPageState extends ConsumerState<PizarraPage> {
  PizarraCompartida? _pizarra;
  StreamSubscription<List<PaginaPizarra>>? _escucha;
  List<PaginaPizarra> _paginas = const [];
  int _pagina = 0;
  bool _sinAcceso = false;
  String? _aviso;

  // Trazo propio en curso (en píxeles de pantalla) y los terminados que aún
  // no ha confirmado el servidor (se pintan algo transparentes).
  final List<Offset> _enCurso = [];
  final List<Trazo> _pendientes = [];
  int? _punteroActivo;
  int _grosor = 1;
  /// Color elegido (null = el del papel) y si está puesto el borrador.
  int? _colorElegido;
  bool _borrador = false;
  // Trazos que ya se han borrado aquí y aún no ha confirmado el servidor.
  final Set<String> _borrados = {};
  Point<double>? _ultimoBorrado;
  late final String _miUid = ref.read(usuarioActualProvider)?.uid ?? '';

  // Geometría del lienzo en pantalla (la calcula el LayoutBuilder).
  double _escala = 1;
  Offset _origen = Offset.zero;

  bool get _soyAlumno => _miUid == widget.alumnoUid;
  /// Mi color por defecto: azul el alumno, rojo el preparador.
  int get _colorPorDefecto => coloresRapidos[_soyAlumno ? 0 : 2];
  Color get _miColor => Color(_colorElegido ?? _colorPorDefecto);
  /// El color con el que el otro escribió por última vez en esta página.
  Color get _colorOtro {
    final suyo = _actual?.trazos.lastWhere((t) => t.de != _miUid, orElse: () => Trazo(id: '', de: '', grosor: 0, puntos: const []));
    return suyo == null || suyo.id.isEmpty ? Color(coloresRapidos[_soyAlumno ? 2 : 0]) : _colorDe(suyo);
  }
  // Los trazos de versiones anteriores sin color: el del papel de quien los hizo.
  Color _colorDe(Trazo t) => Color(t.color ?? (t.de == widget.alumnoUid ? coloresPizarra[0] : coloresPizarra[1]));

  PaginaPizarra? get _actual => _pagina < _paginas.length ? _paginas[_pagina] : null;
  String get _idPaginaActual => _actual?.id ?? PizarraCompartida.idPagina(_pagina + 1);
  int get _nPaginaActual => _actual?.n ?? _pagina + 1;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      WakelockPlus.enable().catchError((_) {});
    }
    if (ref.read(serviciosProvider).firebaseDisponible && _miUid.isNotEmpty) {
      _pizarra = PizarraCompartida.deClase(widget.db ?? FirebaseFirestore.instance, ref.read(oposicionProvider), alumnoUid: widget.alumnoUid, canteId: widget.canteId, miUid: _miUid);
      _escucha = _pizarra!.escuchar().listen(_alLlegar, onError: (Object e) {
        if (mounted) setState(() => _sinAcceso = true);
      });
    } else {
      _sinAcceso = true;
    }
  }

  @override
  void dispose() {
    _quitarAviso?.cancel();
    _escucha?.cancel();
    _pizarra?.vaciar();
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      WakelockPlus.disable().catchError((_) {});
    }
    super.dispose();
  }

  void _alLlegar(List<PaginaPizarra> paginas) {
    if (!mounted) return;
    setState(() {
      _paginas = paginas;
      if (_pagina >= paginas.length && paginas.isNotEmpty) _pagina = paginas.length - 1;
      // Lo que ya ha confirmado el servidor deja de estar pendiente.
      final ids = {for (final p in paginas) for (final t in p.trazos) t.id};
      _pendientes.removeWhere((t) => ids.contains(t.id));
      _borrados.removeWhere((id) => !ids.contains(id));
      // Aviso de que el otro la ha borrado entera: solo si pasa con la
      // pizarra abierta (no al abrirla) y unos segundos.
      final a = _actual;
      final borrada = a != null && a.trazos.isEmpty && a.borradoPor != null && a.borradoPor != _miUid;
      if (borrada && _habiaTrazos.contains(a.id)) {
        _aviso = '${widget.otroNombre} ha borrado la pizarra';
        _quitarAviso?.cancel();
        _quitarAviso = Timer(const Duration(seconds: 4), () {
          if (mounted) setState(() => _aviso = null);
        });
      }
      _habiaTrazos
        ..clear()
        ..addAll([for (final p in paginas) if (p.trazos.isNotEmpty) p.id]);
    });
  }

  /// Páginas con algo escrito en la última lectura (para saber si se acaban de borrar).
  final Set<String> _habiaTrazos = {};
  Timer? _quitarAviso;

  /// Cualquier color: el tono y la luminosidad, con la muestra.
  Future<void> _otroColor() async {
    var hsv = HSVColor.fromColor(_miColor);
    final elegido = await showDialog<Color>(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (d, set) => AlertDialog(
          title: const Text('Elige un color'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(height: 44, decoration: BoxDecoration(color: hsv.toColor(), borderRadius: BorderRadius.circular(8))),
            const SizedBox(height: 14),
            const Text('Tono'),
            _BarraColor(colores: [for (var h = 0; h <= 360; h += 30) HSVColor.fromAHSV(1, h.toDouble(), 1, 0.9).toColor()]),
            Slider(value: hsv.hue, min: 0, max: 360, onChanged: (v) => set(() => hsv = hsv.withHue(v).withSaturation(hsv.saturation == 0 ? 0.85 : hsv.saturation))),
            const Text('Intensidad'),
            _BarraColor(colores: [hsv.withSaturation(0).toColor(), hsv.withSaturation(1).toColor()]),
            Slider(value: hsv.saturation, min: 0, max: 1, onChanged: (v) => set(() => hsv = hsv.withSaturation(v))),
            const Text('Luz'),
            _BarraColor(colores: [hsv.withValue(0).toColor(), hsv.withValue(1).toColor()]),
            Slider(value: hsv.value, min: 0, max: 1, onChanged: (v) => set(() => hsv = hsv.withValue(v))),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, hsv.toColor()), child: const Text('Usar este color')),
          ],
        ),
      ),
    );
    if (elegido != null) {
      setState(() {
        _borrador = false;
        _colorElegido = elegido.toARGB32();
      });
    }
  }

  // ------------------------------------------------------------- Dibujar

  // [p] viene en píxeles del lienzo (el Listener ya está en su origen).
  Point<double> _virtual(Offset p) => Point((p.dx / _escala).clamp(0, anchoLienzo.toDouble()), (p.dy / _escala).clamp(0, altoLienzo.toDouble()));

  void _bajar(PointerDownEvent e) {
    if (_punteroActivo != null || _sinAcceso || (!_borrador && (_actual?.llena ?? false))) return;
    _punteroActivo = e.pointer;
    if (_borrador) {
      _ultimoBorrado = null;
      _borrarEn(e.localPosition);
      return;
    }
    setState(() => _enCurso
      ..clear()
      ..add(e.localPosition));
  }

  void _mover(PointerMoveEvent e) {
    if (e.pointer != _punteroActivo) return;
    // Con ratón, solo con el botón pulsado.
    if (e.kind == PointerDeviceKind.mouse && e.buttons == 0) return;
    if (_borrador) {
      _borrarEn(e.localPosition);
      return;
    }
    // Muestreo: un punto nuevo solo si se ha movido al menos 2 px.
    if (_enCurso.isNotEmpty && (e.localPosition - _enCurso.last).distance < 2) return;
    setState(() => _enCurso.add(e.localPosition));
  }

  /// Borrador: quita los trazos (de los dos) que pasan por donde se toca.
  void _borrarEn(Offset p) {
    final v = _virtual(p);
    if (_ultimoBorrado != null && v.distanceTo(_ultimoBorrado!) < 4) return;
    _ultimoBorrado = v;
    final radio = 14 / _escala;
    final pendientes = _pendientes.where((t) => t.cerca(v, radio)).toList();
    final subidos = (_actual?.trazos ?? const <Trazo>[]).where((t) => !_borrados.contains(t.id) && t.cerca(v, radio)).toList();
    if (pendientes.isEmpty && subidos.isEmpty) return;
    setState(() {
      for (final t in pendientes) {
        _pizarra?.quitarDeCola(t.id);
        _pendientes.remove(t);
      }
      _borrados.addAll(subidos.map((t) => t.id));
    });
    for (final t in subidos) {
      if (t.crudo != null) _pizarra?.deshacer(_idPaginaActual, t.crudo!).catchError((_) {});
    }
  }

  void _soltar(int puntero) {
    if (puntero != _punteroActivo) return;
    _punteroActivo = null;
    if (_borrador || _enCurso.isEmpty) return;
    final virtuales = simplificar([for (final p in _enCurso) _virtual(p)]);
    // Siempre con su color (también el de por defecto): el otro lo ve tal cual.
    final trazo = Trazo(id: nuevoIdTrazo(), de: _miUid, grosor: grosores[_grosor], color: _miColor.toARGB32(), puntos: [for (final p in virtuales) Point(p.x.round(), p.y.round())]);
    setState(() {
      _enCurso.clear();
      _pendientes.add(trazo);
    });
    _pizarra?.encolar(_idPaginaActual, _nPaginaActual, trazo);
  }

  Future<void> _deshacer() async {
    // El último trazo mío de esta página: si aún no se ha subido, se quita
    // de la cola; si no, se pide al servidor que lo quite.
    final pendiente = _pendientes.lastOrNull;
    if (pendiente != null && _pizarra!.quitarDeCola(pendiente.id)) {
      setState(() => _pendientes.remove(pendiente));
      return;
    }
    final mio = _actual?.trazos.where((t) => t.de == _miUid).lastOrNull;
    if (mio?.crudo == null) return;
    try {
      await _pizarra!.deshacer(_idPaginaActual, mio!.crudo!);
    } catch (_) {}
  }

  Future<void> _borrarTodo() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Borrar la pizarra?'),
        content: Text('Se borra esta página para los dos (también para ${widget.otroNombre}).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _pendientes.clear());
    try {
      await _pizarra!.borrarTodo(_idPaginaActual);
    } catch (_) {}
  }

  Future<void> _nuevaPagina() async {
    final n = (_paginas.isEmpty ? 1 : _paginas.last.n) + 1;
    if (n > maxPaginas) return;
    try {
      await _pizarra!.nuevaPagina(n);
      setState(() => _pagina = n - 1);
    } catch (_) {}
  }

  // ------------------------------------------------------------- UI

  @override
  Widget build(BuildContext context) {
    final actual = _actual;
    final llena = actual?.llena ?? false;
    final puedeDeshacer = _pendientes.isNotEmpty || (actual?.trazos.any((t) => t.de == _miUid) ?? false);
    return Scaffold(
      backgroundColor: const Color(0xFF16101C),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: LayoutBuilder(builder: (context, c) {
              _escala = min(c.maxWidth / anchoLienzo, c.maxHeight / altoLienzo);
              final ancho = anchoLienzo * _escala, alto = altoLienzo * _escala;
              _origen = Offset((c.maxWidth - ancho) / 2, (c.maxHeight - alto) / 2);
              return Stack(children: [
                Positioned(
                  left: _origen.dx,
                  top: _origen.dy,
                  width: ancho,
                  height: alto,
                  child: Listener(
                    onPointerDown: _bajar,
                    onPointerMove: _mover,
                    onPointerUp: (e) => _soltar(e.pointer),
                    onPointerCancel: (e) => _soltar(e.pointer),
                    child: ClipRect(
                      child: Container(
                        color: Colors.white,
                        child: Stack(fit: StackFit.expand, children: [
                          RepaintBoundary(child: CustomPaint(painter: _PintorTrazos(_borrados.isEmpty ? (actual?.trazos ?? const []) : [for (final t in actual?.trazos ?? const <Trazo>[]) if (!_borrados.contains(t.id)) t], _pendientes, _escala, _colorDe))),
                          CustomPaint(painter: _PintorEnCurso(_enCurso, _miColor, grosores[_grosor] * _escala)),
                        ]),
                      ),
                    ),
                  ),
                ),
                if (_sinAcceso)
                  Positioned.fill(
                    child: ColoredBox(
                      color: Colors.black54,
                      child: Center(child: Text('No tienes acceso a la pizarra de esta clase.', style: context.textos.titleMedium?.copyWith(color: Colors.white))),
                    ),
                  ),
                if (llena && !_sinAcceso)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: _origen.dy + 8,
                    child: Center(child: Chip(label: const Text('Página llena: abre otra'), backgroundColor: context.esquema.errorContainer)),
                  ),
                if (_aviso != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: _origen.dy + 8,
                    child: Center(
                      child: ActionChip(label: Text(_aviso!), avatar: const Icon(Icons.info_outline, size: 18), onPressed: () => setState(() => _aviso = null)),
                    ),
                  ),
              ]);
            }),
          ),
          // Barra de herramientas.
          Container(
            color: const Color(0xFF221830),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                IconButton(tooltip: 'Salir', icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                const SizedBox(width: 4),
                _Leyenda(color: _miColor, texto: 'Tú'),
                const SizedBox(width: 8),
                _Leyenda(color: _colorOtro, texto: widget.otroNombre),
                const SizedBox(width: 12),
                // Colores a un toque (azul, negro, rojo, verde) y la paleta con todos.
                for (var i = 0; i < coloresRapidos.length; i++)
                  IconButton(
                    tooltip: nombresColoresRapidos[i],
                    visualDensity: VisualDensity.compact,
                    isSelected: !_borrador && _miColor.toARGB32() == coloresRapidos[i],
                    style: IconButton.styleFrom(backgroundColor: !_borrador && _miColor.toARGB32() == coloresRapidos[i] ? Colors.white30 : null),
                    icon: Icon(Icons.circle, size: 18, color: Color(coloresRapidos[i])),
                    onPressed: () => setState(() {
                      _borrador = false;
                      _colorElegido = coloresRapidos[i];
                    }),
                  ),
                IconButton(
                  tooltip: 'Otro color',
                  visualDensity: VisualDensity.compact,
                  isSelected: !_borrador && !coloresRapidos.contains(_miColor.toARGB32()),
                  style: IconButton.styleFrom(backgroundColor: !_borrador && !coloresRapidos.contains(_miColor.toARGB32()) ? Colors.white30 : null),
                  icon: Icon(Icons.palette_outlined, color: coloresRapidos.contains(_miColor.toARGB32()) ? Colors.white : _miColor),
                  onPressed: _otroColor,
                ),
                const SizedBox(width: 8),
                for (var i = 0; i < grosores.length; i++)
                  IconButton(
                    tooltip: ['Fino', 'Medio', 'Grueso'][i],
                    isSelected: !_borrador && _grosor == i,
                    style: IconButton.styleFrom(backgroundColor: !_borrador && _grosor == i ? Colors.white24 : null),
                    icon: Icon(Icons.circle, size: 8.0 + 6 * i, color: Colors.white),
                    onPressed: () => setState(() {
                      _borrador = false;
                      _grosor = i;
                    }),
                  ),
                IconButton(
                  tooltip: 'Borrador: quita los trazos que toques',
                  isSelected: _borrador,
                  style: IconButton.styleFrom(backgroundColor: _borrador ? Colors.white24 : null),
                  icon: const Icon(Icons.auto_fix_high_outlined, color: Colors.white),
                  onPressed: _sinAcceso ? null : () => setState(() => _borrador = !_borrador),
                ),
                const SizedBox(width: 8),
                IconButton(tooltip: 'Deshacer mi último trazo', icon: const Icon(Icons.undo, color: Colors.white), onPressed: puedeDeshacer && !_sinAcceso ? _deshacer : null),
                IconButton(tooltip: 'Borrar todo', icon: const Icon(Icons.delete_outline, color: Colors.white), onPressed: _sinAcceso ? null : _borrarTodo),
                const SizedBox(width: 8),
                IconButton(tooltip: 'Página anterior', icon: const Icon(Icons.chevron_left, color: Colors.white), onPressed: _pagina > 0 ? () => setState(() => _pagina--) : null),
                Text('${_pagina + 1}/${max(_paginas.length, 1)}', style: const TextStyle(color: Colors.white)),
                IconButton(tooltip: 'Página siguiente', icon: const Icon(Icons.chevron_right, color: Colors.white), onPressed: _pagina < _paginas.length - 1 ? () => setState(() => _pagina++) : null),
                TextButton.icon(
                  onPressed: _sinAcceso || _paginas.length >= maxPaginas ? null : _nuevaPagina,
                  icon: const Icon(Icons.note_add_outlined, color: Colors.white, size: 18),
                  label: const Text('Nueva página', style: TextStyle(color: Colors.white)),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Leyenda extends StatelessWidget {
  const _Leyenda({required this.color, required this.texto});
  final Color color;
  final String texto;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(width: 4),
        Text(texto, style: const TextStyle(color: Colors.white, fontSize: 12), overflow: TextOverflow.ellipsis),
      ]);
}

/// Trazos consolidados (y los míos pendientes, algo transparentes), con los
/// caminos en caché por id.
class _PintorTrazos extends CustomPainter {
  _PintorTrazos(this.trazos, this.pendientes, this.escala, this.colorDe);
  final List<Trazo> trazos;
  final List<Trazo> pendientes;
  final double escala;
  final Color Function(Trazo t) colorDe;

  static final Map<String, Path> _cache = {};

  static Path caminoDe(Trazo t) => _cache.putIfAbsent(t.id, () {
        final p = Path();
        final pts = t.puntos;
        if (pts.isEmpty) return p;
        p.moveTo(pts.first.x.toDouble(), pts.first.y.toDouble());
        if (pts.length == 1) {
          p.lineTo(pts.first.x.toDouble(), pts.first.y.toDouble());
          return p;
        }
        for (var i = 1; i < pts.length - 1; i++) {
          final a = pts[i], b = pts[i + 1];
          p.quadraticBezierTo(a.x.toDouble(), a.y.toDouble(), (a.x + b.x) / 2, (a.y + b.y) / 2);
        }
        p.lineTo(pts.last.x.toDouble(), pts.last.y.toDouble());
        return p;
      });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(escala);
    final pintura = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final t in trazos) {
      pintura
        ..color = colorDe(t)
        ..strokeWidth = t.grosor.toDouble();
      canvas.drawPath(caminoDe(t), pintura);
    }
    for (final t in pendientes) {
      pintura
        ..color = colorDe(t).withValues(alpha: 0.6)
        ..strokeWidth = t.grosor.toDouble();
      canvas.drawPath(caminoDe(t), pintura);
    }
    // La caché no crece sin límite.
    if (_cache.length > 6000) _cache.clear();
  }

  @override
  bool shouldRepaint(_PintorTrazos old) =>
      old.escala != escala || old.trazos.length != trazos.length || old.pendientes.length != pendientes.length || !identical(old.trazos, trazos) || !identical(old.pendientes, pendientes);
}

/// El trazo que se está dibujando ahora (en píxeles de pantalla).
class _PintorEnCurso extends CustomPainter {
  _PintorEnCurso(this.puntos, this.color, this.grosor);
  final List<Offset> puntos;
  final Color color;
  final double grosor;

  @override
  void paint(Canvas canvas, Size size) {
    if (puntos.isEmpty) return;
    final pintura = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = grosor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final p = Path()..moveTo(puntos.first.dx, puntos.first.dy);
    if (puntos.length == 1) p.lineTo(puntos.first.dx, puntos.first.dy);
    for (var i = 1; i < puntos.length - 1; i++) {
      final a = puntos[i], b = puntos[i + 1];
      p.quadraticBezierTo(a.dx, a.dy, (a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
    }
    if (puntos.length > 1) p.lineTo(puntos.last.dx, puntos.last.dy);
    canvas.drawPath(p, pintura);
  }

  @override
  bool shouldRepaint(_PintorEnCurso old) => true;
}

/// Degradado de muestra bajo cada deslizador del color.
class _BarraColor extends StatelessWidget {
  const _BarraColor({required this.colores});
  final List<Color> colores;
  @override
  Widget build(BuildContext context) => Container(
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), gradient: LinearGradient(colors: colores)),
      );
}
