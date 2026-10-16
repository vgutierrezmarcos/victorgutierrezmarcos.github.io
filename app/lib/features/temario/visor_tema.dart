import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';

import '../cantar/pizarra_barra.dart';
import '../cantar/pizarra_compartida.dart';
import '../cantar/pizarra_formas.dart';
import '../cantar/pizarra_tinta.dart';
import '../cantar/pizarra_trazos.dart';
import 'anotaciones.dart';

/// Para mover el visor desde fuera (la barra de páginas del tema).
class ControladorVisor {
  _VisorTemaState? _estado;
  void irAPagina(int n) => _estado?._irAPagina(n);

  /// Las anotaciones de cada página (para descargar el tema anotado).
  Map<int, List<Trazo>> get anotaciones => _estado?._anotacionesVisibles ?? const {};
}

/// Visor del PDF de un tema con sus anotaciones encima. Las páginas van una
/// debajo de otra; se mueve con un dedo y se amplía con dos. Con [anotando],
/// se pinta y se subraya como en Notas: el lápiz pinta y, si hay lápiz, los
/// dedos mueven la página (la palma no pinta); sin lápiz, pinta el dedo y se
/// mueve con dos dedos.
class VisorTema extends StatefulWidget {
  const VisorTema({
    super.key,
    required this.documento,
    required this.fuente,
    required this.miUid,
    required this.controlador,
    this.anotando = false,
    this.alCambiarPagina,
    this.alCargar,
    this.alAcabar,
  });

  final PdfDocument documento;

  /// Dónde se guardan las anotaciones (null: sin cuenta, solo se leen... nada).
  final FuentePizarra? fuente;
  final String miUid;
  final ControladorVisor controlador;
  final bool anotando;
  final ValueChanged<int>? alCambiarPagina;
  final ValueChanged<int>? alCargar;

  /// «Listo»: salir de anotar.
  final VoidCallback? alAcabar;

  @override
  State<VisorTema> createState() => _VisorTemaState();
}

class _Cambio {
  const _Cambio(this.pagina, this.quitar, this.poner);
  final int pagina;
  final List<Trazo> quitar;
  final List<Trazo> poner;
  _Cambio get inverso => _Cambio(pagina, poner, quitar);
}

enum _Herramienta { boligrafo, fosforito, borrador }

/// Opacidad del fosforito sobre el tema: se multiplica con el papel, así que
/// puede ser más intenso que en la pizarra sin tapar el texto.
const _alfaFosforito = 0xA0;

class _VisorTemaState extends State<VisorTema> {
  // ------------------------------------------------------------- Páginas
  List<Size> _tamanos = const [];
  final Map<int, (double, MemoryImage)> _imagenes = {};
  final Set<int> _renderizando = {};
  bool _colaEnMarcha = false;
  Timer? _revisar;

  // Geometría (la calcula el LayoutBuilder), en coordenadas del contenido.
  Size _vista = Size.zero;
  double _ancho = 0, _izquierda = 0;
  List<double> _arriba = const [];
  double _altoTotal = 0;
  static const _hueco = 12.0;
  final _tc = TransformationController();
  int _paginaActual = 1;

  // ------------------------------------------------------------- Anotaciones
  StreamSubscription<List<PaginaPizarra>>? _escucha;
  Map<int, PaginaPizarra> _servidor = {};
  final List<(int, Trazo)> _pendientes = [];
  final Set<String> _borrados = {};
  final List<_Cambio> _hechos = [], _deshechos = [];
  int _version = 0;

  _Herramienta _herramienta = _Herramienta.boligrafo;
  int _colorBoli = coloresBoligrafo[1];
  int _colorFosfo = coloresFosforito[0];
  final Map<_Herramienta, int> _grosor = {_Herramienta.boligrafo: 1, _Herramienta.fosforito: 1};
  bool _dedoDibuja = true, _dedoElegido = false;

  // Trazo en curso, en unidades de su página.
  int? _punteroDibujo;
  PointerDeviceKind? _tipoDibujo;
  int _paginaTrazo = 0;
  final List<Point<double>> _enCurso = [];
  final List<double> _factores = [];
  double _factor = 1;
  Offset _ultimaPantalla = Offset.zero;
  Duration _ultimoTiempo = Duration.zero, _inicioTrazo = Duration.zero;
  Timer? _temporizadorForma;
  Offset? _anclaQuieto;
  bool _formaHecha = false;
  bool _borrando = false;
  final Map<String, (int, Trazo)> _gestoQuitar = {};
  Point<double>? _ultimoBorrado;

  // Dedos que mueven o amplían (anotando).
  final Map<int, Offset> _toques = {};
  ({double z, Offset t, Offset foco, double dist})? _gesto;

  @override
  void initState() {
    super.initState();
    widget.controlador._estado = this;
    _tc.addListener(_alMover);
    _medirPaginas();
    _escucha = widget.fuente?.escuchar().listen((paginas) {
      if (!mounted) return;
      setState(() {
        _servidor = {for (final p in paginas) p.n: p};
        final ids = {for (final p in paginas) for (final t in p.trazos) t.id};
        _pendientes.removeWhere((e) => ids.contains(e.$2.id));
        _borrados.removeWhere((id) => !ids.contains(id));
        _version++;
      });
    }, onError: (_) {});
  }

  @override
  void didUpdateWidget(VisorTema old) {
    super.didUpdateWidget(old);
    widget.controlador._estado = this;
    if (old.anotando && !widget.anotando) _anularTrazo();
  }

  @override
  void dispose() {
    _revisar?.cancel();
    _temporizadorForma?.cancel();
    _escucha?.cancel();
    widget.fuente?.vaciar();
    _tc.dispose();
    super.dispose();
  }

  /// El tamaño de cada página (se abren de una en una: en Android solo puede
  /// haber una abierta).
  Future<void> _medirPaginas() async {
    final tamanos = <Size>[];
    for (var n = 1; n <= widget.documento.pagesCount; n++) {
      final p = await widget.documento.getPage(n);
      tamanos.add(Size(p.width, p.height));
      await p.close();
    }
    if (!mounted) return;
    setState(() => _tamanos = tamanos);
    widget.alCargar?.call(tamanos.length);
    _programarRevision();
  }

  // ------------------------------------------------------------- Geometría

  void _maquetar(Size vista) {
    if (vista == _vista && _arriba.length == _tamanos.length) return;
    // Con la maqueta nueva, a renderizar lo que se ve (al abrir, al girar).
    WidgetsBinding.instance.addPostFrameCallback((_) => _programarRevision());
    _vista = vista;
    _ancho = min(vista.width - 16, 1100);
    _izquierda = (vista.width - _ancho) / 2;
    var y = 8.0;
    _arriba = [
      for (final s in _tamanos) ...[
        () {
          final top = y;
          y += _ancho * s.height / s.width + _hueco;
          return top;
        }(),
      ],
    ];
    _altoTotal = y;
  }

  double _altoPagina(int i) => _ancho * _tamanos[i].height / _tamanos[i].width;
  double get _escalaUnidad => _ancho / anchoPaginaAnotada;
  double get _z => _tc.value.getMaxScaleOnAxis();

  /// Del punto de la vista al contenido.
  Offset _contenido(Offset p) => MatrixUtils.transformPoint(Matrix4.inverted(_tc.value), p);

  /// La página (índice) bajo un punto del contenido, o null.
  int? _paginaEn(Offset c) {
    for (var i = 0; i < _arriba.length; i++) {
      if (c.dy >= _arriba[i] && c.dy <= _arriba[i] + _altoPagina(i) && c.dx >= _izquierda && c.dx <= _izquierda + _ancho) return i;
    }
    return null;
  }

  Point<double> _enPagina(Offset c, int i) {
    final alto = anchoPaginaAnotada * _tamanos[i].height / _tamanos[i].width;
    return Point(((c.dx - _izquierda) / _escalaUnidad).clamp(0, anchoPaginaAnotada.toDouble()), ((c.dy - _arriba[i]) / _escalaUnidad).clamp(0, alto));
  }

  void _alMover() {
    if (_arriba.isEmpty) return;
    final centro = _contenido(Offset(_vista.width / 2, _vista.height / 3));
    var n = 1;
    for (var i = 0; i < _arriba.length; i++) {
      if (_arriba[i] <= centro.dy) n = i + 1;
    }
    if (n != _paginaActual) {
      _paginaActual = n;
      widget.alCambiarPagina?.call(n);
    }
    _programarRevision();
  }

  void _irAPagina(int n) {
    if (_arriba.isEmpty) return;
    final z = _z;
    final y = -_arriba[(n - 1).clamp(0, _arriba.length - 1)] * z;
    _ponerVista(z, Offset(_tc.value.getTranslation().x, y));
  }

  /// Pone el zoom [z] y el desplazamiento [t] sin salirse del contenido.
  void _ponerVista(double z, Offset t) {
    double eje(double t, double vista, double contenido) => contenido * z <= vista ? (vista - contenido * z) / 2 : t.clamp(vista - contenido * z, 0);
    final x = eje(t.dx, _vista.width, _vista.width), y = eje(t.dy, _vista.height, _altoTotal);
    _tc.value = Matrix4.translationValues(x, y, 0)..multiply(Matrix4.diagonal3Values(z, z, 1));
  }

  // ------------------------------------------------------------- Imágenes

  void _programarRevision() {
    _revisar?.cancel();
    _revisar = Timer(const Duration(milliseconds: 120), _renderizarVisibles);
  }

  /// Renderiza las páginas que se ven (y la de antes y la de después) con la
  /// resolución del zoom actual, y olvida las lejanas.
  Future<void> _renderizarVisibles() async {
    if (!mounted || _arriba.isEmpty || _colaEnMarcha) return;
    _colaEnMarcha = true;
    try {
      while (mounted) {
        final arriba = _contenido(Offset.zero).dy, abajo = _contenido(Offset(0, _vista.height)).dy;
        final visibles = [for (var i = 0; i < _arriba.length; i++) if (_arriba[i] + _altoPagina(i) >= arriba && _arriba[i] <= abajo) i];
        if (visibles.isEmpty) break;
        final cerca = {...visibles, max(0, visibles.first - 1), min(_arriba.length - 1, visibles.last + 1)};
        final dpr = MediaQuery.devicePixelRatioOf(context);
        final z = _z;
        final nivel = z < 1.6 ? 1.0 : (z < 3 ? 2.0 : 3.2);
        final resolucion = min(_ancho * dpr * nivel, 3000.0);
        final falta = cerca.where((i) => (_imagenes[i]?.$1 ?? 0) < resolucion * 0.95).toList()..sort((a, b) => (visibles.contains(a) ? 0 : 1) - (visibles.contains(b) ? 0 : 1));
        // Fuera de la vista y lejos: se olvidan.
        _imagenes.removeWhere((i, _) => (i - visibles.first).abs() > 6 && (i - visibles.last).abs() > 6);
        if (falta.isEmpty) break;
        final i = falta.first;
        _renderizando.add(i);
        final p = await widget.documento.getPage(i + 1);
        final img = await p.render(width: resolucion, height: resolucion * _tamanos[i].height / _tamanos[i].width, format: PdfPageImageFormat.jpeg, quality: 92, backgroundColor: '#FFFFFF');
        await p.close();
        _renderizando.remove(i);
        if (!mounted || img == null) break;
        setState(() => _imagenes[i] = (resolucion, MemoryImage(img.bytes)));
      }
    } catch (_) {
      // Un fallo al renderizar una página: se reintenta al moverse.
    } finally {
      _colaEnMarcha = false;
    }
  }

  // ------------------------------------------------------------- Anotaciones

  /// Lo que se ve de cada página: lo del servidor menos lo quitado aquí, más
  /// lo puesto aquí que aún no ha vuelto.
  Map<int, List<Trazo>> get _anotacionesVisibles {
    final ocultos = {..._borrados, ..._gestoQuitar.keys};
    final out = <int, List<Trazo>>{};
    for (final e in _servidor.entries) {
      out[e.key] = [for (final t in e.value.trazos) if (!ocultos.contains(t.id)) t];
    }
    for (final (n, t) in _pendientes) {
      final lista = out.putIfAbsent(n, () => []);
      if (!ocultos.contains(t.id) && !lista.any((x) => x.id == t.id)) lista.add(t);
    }
    return out;
  }

  void _aplicar(_Cambio c, {bool historial = true}) {
    final fuente = widget.fuente;
    if (fuente == null || (c.quitar.isEmpty && c.poner.isEmpty)) return;
    final pagina = PizarraCompartida.idPagina(c.pagina);
    setState(() {
      _borrados
        ..addAll(c.quitar.map((t) => t.id))
        ..removeAll(c.poner.map((t) => t.id));
      final quitar = {for (final t in c.quitar) t.id};
      _pendientes.removeWhere((e) => quitar.contains(e.$2.id));
      _pendientes.addAll([for (final t in c.poner) (c.pagina, t)]);
      if (historial) {
        _hechos.add(c);
        _deshechos.clear();
      }
      _version++;
    });
    // Quitar y poner elemento a elemento (arrayRemove y arrayUnion): funciona
    // sin conexión y se sube al volver.
    for (final t in c.quitar) {
      if (!fuente.quitarDeCola(t.id)) fuente.deshacer(pagina, t.crudo ?? t.toJson()).catchError((_) {});
    }
    for (final t in c.poner) {
      fuente.encolar(pagina, c.pagina, t);
    }
  }

  void _deshacer() {
    if (_hechos.isEmpty) return;
    final c = _hechos.removeLast();
    _deshechos.add(c);
    _aplicar(c.inverso, historial: false);
  }

  void _rehacer() {
    if (_deshechos.isEmpty) return;
    final c = _deshechos.removeLast();
    _hechos.add(c);
    _aplicar(c, historial: false);
  }

  // ------------------------------------------------------------- Punteros (anotando)

  bool _esLapiz(PointerDeviceKind k) => k == PointerDeviceKind.stylus || k == PointerDeviceKind.invertedStylus;

  void _bajar(PointerDownEvent e) {
    if (!widget.anotando || widget.fuente == null) return;
    if (_esLapiz(e.kind) && !_dedoElegido && _dedoDibuja) setState(() => _dedoDibuja = false);
    if (e.kind == PointerDeviceKind.touch) {
      _toques[e.pointer] = e.localPosition;
      if (_punteroDibujo != null && _esLapiz(_tipoDibujo!)) return;
      if (_toques.length >= 2) {
        // Segundo dedo: mover y ampliar (el trazo recién empezado se anula).
        if (_punteroDibujo != null) {
          if (e.timeStamp - _inicioTrazo < const Duration(milliseconds: 350)) {
            _anularTrazo();
          } else {
            _terminar();
          }
        }
        _empezarGesto();
        return;
      }
      if (_dedoDibuja) {
        _empezar(e);
      } else {
        _empezarGesto();
      }
      return;
    }
    if (e.kind == PointerDeviceKind.mouse && e.buttons & kPrimaryMouseButton == 0) return;
    if (_punteroDibujo != null) {
      if (_tipoDibujo == PointerDeviceKind.touch && _esLapiz(e.kind)) {
        _anularTrazo();
      } else {
        return;
      }
    }
    _gesto = null;
    _empezar(e);
  }

  void _mover(PointerMoveEvent e) {
    if (_toques.containsKey(e.pointer)) {
      _toques[e.pointer] = e.localPosition;
      if (_gesto != null) {
        _seguirGesto();
        return;
      }
    }
    if (e.pointer != _punteroDibujo) return;
    if (e.kind == PointerDeviceKind.mouse && e.buttons == 0) return;
    _seguir(e);
  }

  void _levantar(PointerEvent e) {
    if (_toques.remove(e.pointer) != null && _gesto != null) {
      _toques.isEmpty ? _gesto = null : _empezarGesto();
    }
    if (e.pointer == _punteroDibujo) _terminar();
  }

  void _empezarGesto() {
    final p = _toques.values.take(2).toList();
    if (p.isEmpty) return;
    final foco = p.length == 1 ? p.first : (p[0] + p[1]) / 2;
    _gesto = (z: _z, t: Offset(_tc.value.getTranslation().x, _tc.value.getTranslation().y), foco: foco, dist: p.length == 1 ? 0.0 : (p[0] - p[1]).distance);
  }

  void _seguirGesto() {
    final g = _gesto!;
    final p = _toques.values.take(2).toList();
    final foco = p.length == 1 ? p.first : (p[0] + p[1]) / 2;
    var z = g.z;
    if (p.length == 2 && g.dist > 0) z = (g.z * (p[0] - p[1]).distance / g.dist).clamp(1.0, 5.0);
    _ponerVista(z, foco - (g.foco - g.t) * (z / g.z));
  }

  /// La rueda del ratón desplaza (y con Ctrl, amplía), como en un lector de
  /// PDF. Se escucha dentro del InteractiveViewer para adelantarse a él, que
  /// con la rueda solo amplía. [e] viene en coordenadas del contenido.
  void _rueda(PointerSignalEvent e) {
    if (e is! PointerScrollEvent) return;
    GestureBinding.instance.pointerSignalResolver.register(e, (_) {
      final teclado = HardwareKeyboard.instance;
      final t = Offset(_tc.value.getTranslation().x, _tc.value.getTranslation().y);
      final enVista = MatrixUtils.transformPoint(_tc.value, e.localPosition);
      if (teclado.isControlPressed || teclado.isMetaPressed) {
        final z = (_z * exp(-e.scrollDelta.dy / 300)).clamp(1.0, 5.0);
        _ponerVista(z, enVista - (enVista - t) * (z / _z));
      } else {
        _ponerVista(_z, t - e.scrollDelta);
      }
    });
  }

  int get _grosorActual => grosoresAnotacion[_herramienta == _Herramienta.fosforito ? herramientaFosforito : herramientaBoligrafo]![_grosor[_herramienta] ?? 1];

  void _empezar(PointerDownEvent e) {
    final c = _contenido(e.localPosition);
    final i = _paginaEn(c);
    if (i == null) return;
    _punteroDibujo = e.pointer;
    _tipoDibujo = e.kind;
    _paginaTrazo = i;
    _inicioTrazo = e.timeStamp;
    _ultimoTiempo = e.timeStamp;
    _ultimaPantalla = e.localPosition;
    final v = _enPagina(c, i);
    if (_herramienta == _Herramienta.borrador || e.kind == PointerDeviceKind.invertedStylus) {
      _borrando = true;
      _ultimoBorrado = null;
      _borrarEn(v);
      return;
    }
    _borrando = false;
    _formaHecha = false;
    _anclaQuieto = e.localPosition;
    _factor = _esLapiz(e.kind) ? factorPresion(e.pressure, e.pressureMin, e.pressureMax) : 1.0;
    setState(() {
      _enCurso
        ..clear()
        ..add(v);
      _factores
        ..clear()
        ..add(_conPresion ? _factor : 1);
    });
  }

  bool get _conPresion => _herramienta == _Herramienta.boligrafo;

  void _seguir(PointerMoveEvent e) {
    final v = _enPagina(_contenido(e.localPosition), _paginaTrazo);
    if (_borrando) {
      _borrarEn(v);
      return;
    }
    if (_enCurso.isEmpty || _formaHecha) return;
    if ((e.localPosition - _ultimaPantalla).distance < 0.5) return;
    final dt = max(1, (e.timeStamp - _ultimoTiempo).inMicroseconds) / 1000;
    final velocidad = (e.localPosition - _ultimaPantalla).distance / dt;
    _ultimaPantalla = e.localPosition;
    _ultimoTiempo = e.timeStamp;
    if (_conPresion) {
      final objetivo = _esLapiz(e.kind) ? factorPresion(e.pressure, e.pressureMin, e.pressureMax) : factorVelocidad(velocidad);
      _factor += (objetivo - _factor) * (_esLapiz(e.kind) ? 0.5 : 0.25);
    }
    setState(() {
      _enCurso.add(v);
      _factores.add(_conPresion ? _factor : 1);
    });
    // Mantener el lápiz quieto al acabar: recta (el subrayado) o forma limpia.
    if (_anclaQuieto == null || (e.localPosition - _anclaQuieto!).distance > 3) {
      _anclaQuieto = e.localPosition;
      _temporizadorForma?.cancel();
      _temporizadorForma = Timer(const Duration(milliseconds: 600), _convertirEnForma);
    }
  }

  void _convertirEnForma() {
    if (!mounted || _punteroDibujo == null || _enCurso.length < 3 || _formaHecha || _borrando) return;
    final forma = reconocerForma(_enCurso);
    if (forma == null) return;
    HapticFeedback.selectionClick();
    final medio = _factores.reduce((a, b) => a + b) / _factores.length;
    setState(() {
      _formaHecha = true;
      _enCurso
        ..clear()
        ..addAll(forma);
      _factores
        ..clear()
        ..addAll(List.filled(forma.length, medio));
    });
  }

  void _anularTrazo() {
    _temporizadorForma?.cancel();
    _punteroDibujo = null;
    if (_borrando) {
      _terminar();
      return;
    }
    setState(() {
      _enCurso.clear();
      _factores.clear();
    });
  }

  void _terminar() {
    _temporizadorForma?.cancel();
    _punteroDibujo = null;
    if (_borrando) {
      _borrando = false;
      final porPagina = <int, List<Trazo>>{};
      for (final (n, t) in _gestoQuitar.values) {
        porPagina.putIfAbsent(n, () => []).add(t);
      }
      setState(() => _gestoQuitar.clear());
      for (final e in porPagina.entries) {
        _aplicar(_Cambio(e.key, e.value, const []));
      }
      return;
    }
    if (_enCurso.isEmpty) return;
    final idx = _formaHecha ? [for (var i = 0; i < _enCurso.length; i++) i] : indicesSimplificados(_enCurso, tolerancia: 0.4);
    final fosforito = _herramienta == _Herramienta.fosforito;
    final trazo = Trazo(
      id: nuevoIdTrazo(),
      de: widget.miUid,
      grosor: _grosorActual,
      color: fosforito ? (_colorFosfo & 0x00FFFFFF) | (_alfaFosforito << 24) : _colorBoli,
      herramienta: fosforito ? herramientaFosforito : null,
      presiones: _conPresion && !_formaHecha ? [for (final i in idx) digitoDeFactor(_factores[i])] : null,
      puntos: [for (final i in idx) Point(_enCurso[i].x.round(), _enCurso[i].y.round())],
    );
    final n = _paginaTrazo + 1;
    _enCurso.clear();
    _factores.clear();
    _aplicar(_Cambio(n, const [], [trazo]));
  }

  void _borrarEn(Point<double> v) {
    if (_ultimoBorrado != null && v.distanceTo(_ultimoBorrado!) * _escalaUnidad * _z < 3) return;
    _ultimoBorrado = v;
    final n = _paginaTrazo + 1;
    final radio = 12 / (_escalaUnidad * _z);
    var cambio = false;
    for (final t in _anotacionesVisibles[n] ?? const <Trazo>[]) {
      if (t.cerca(v, radio)) {
        _gestoQuitar[t.id] = (n, t);
        cambio = true;
      }
    }
    if (cambio) setState(() => _version++);
  }

  // ------------------------------------------------------------- UI

  @override
  Widget build(BuildContext context) {
    if (_tamanos.isEmpty) return const Center(child: CircularProgressIndicator());
    final anotaciones = _anotacionesVisibles;
    return Column(children: [
      Expanded(
        child: LayoutBuilder(builder: (context, c) {
          _maquetar(Size(c.maxWidth, c.maxHeight));
          final contenido = SizedBox(
            width: _vista.width,
            height: _altoTotal,
            child: Stack(children: [
              for (var i = 0; i < _tamanos.length; i++)
                Positioned(
                  left: _izquierda,
                  top: _arriba[i],
                  width: _ancho,
                  height: _altoPagina(i),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 1))]),
                    child: CustomPaint(
                      // Encima de la imagen y en la misma capa: el fosforito se
                      // multiplica con el papel y el texto se sigue leyendo.
                      foregroundPainter: _PintorAnotaciones(
                        anotaciones[i + 1] ?? const [],
                        _escalaUnidad,
                        _version,
                        enCurso: _punteroDibujo != null && _paginaTrazo == i && !_borrando ? _enCurso : null,
                        factores: _factores,
                        grosor: _grosorActual,
                        color: _herramienta == _Herramienta.fosforito ? Color((_colorFosfo & 0x00FFFFFF) | (_alfaFosforito << 24)) : Color(_colorBoli),
                        fosforito: _herramienta == _Herramienta.fosforito,
                      ),
                      child: _imagenes[i] == null
                          ? Center(child: Text('${i + 1}', style: const TextStyle(color: Color(0x33000000), fontSize: 28)))
                          : Image(image: _imagenes[i]!.$2, fit: BoxFit.fill, gaplessPlayback: true, filterQuality: FilterQuality.medium),
                    ),
                  ),
                ),
            ]),
          );
          return Listener(
            onPointerDown: _bajar,
            onPointerMove: _mover,
            onPointerUp: _levantar,
            onPointerCancel: _levantar,
            child: ColoredBox(
              color: const Color(0xFFE9E9EE),
              child: InteractiveViewer(
                transformationController: _tc,
                constrained: false,
                minScale: 1,
                maxScale: 5,
                // Anotando, los gestos los lleva el Listener (lápiz, palma, dos dedos).
                panEnabled: !widget.anotando,
                scaleEnabled: !widget.anotando,
                child: Listener(onPointerSignal: _rueda, child: contenido),
              ),
            ),
          );
        }),
      ),
      if (widget.anotando) _barra(),
    ]);
  }

  Widget _barra() {
    final fosforito = _herramienta == _Herramienta.fosforito;
    final colores = fosforito ? coloresFosforito : coloresBoligrafo;
    final nombres = fosforito ? nombresFosforito : nombresBoligrafo;
    final elegido = fosforito ? _colorFosfo : _colorBoli;
    PuntaHerramienta punta(_Herramienta h, HerramientaPizarra dibujo, String nombre, int color) => PuntaHerramienta(
          herramienta: dibujo,
          elegida: _herramienta == h,
          color: Color(color),
          grosor: _grosor[h] ?? 0,
          nombre: nombre,
          alTocar: () => _herramienta == h && h != _Herramienta.borrador ? _elegirGrosor(h) : setState(() => _herramienta = h),
          alMantener: h == _Herramienta.borrador ? null : () => _elegirGrosor(h),
        );
    return Container(
      color: fondoPizarra,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: max(0, MediaQuery.sizeOf(context).width - 8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PaletaFlotante(children: [
                punta(_Herramienta.boligrafo, HerramientaPizarra.boligrafo, 'Bolígrafo', _colorBoli),
                punta(_Herramienta.fosforito, HerramientaPizarra.fosforito, 'Fosforito (mantén al acabar para que salga recto)', _colorFosfo),
                punta(_Herramienta.borrador, HerramientaPizarra.borrador, 'Borrador', 0),
                const SeparadorPaleta(),
                for (var i = 0; i < colores.length; i++)
                  MuestraColor(
                    color: Color(colores[i]),
                    nombre: nombres[i],
                    elegido: _herramienta != _Herramienta.borrador && elegido == colores[i],
                    alTocar: () => setState(() {
                      if (_herramienta == _Herramienta.borrador) _herramienta = _Herramienta.boligrafo;
                      _herramienta == _Herramienta.fosforito ? _colorFosfo = colores[i] : _colorBoli = colores[i];
                    }),
                  ),
                const SeparadorPaleta(),
                BotonBarra(icono: Icons.undo, tooltip: 'Deshacer', alTocar: _hechos.isEmpty ? null : _deshacer),
                BotonBarra(icono: Icons.redo, tooltip: 'Rehacer', alTocar: _deshechos.isEmpty ? null : _rehacer),
                BotonBarra(
                  icono: Icons.touch_app_outlined,
                  tooltip: _dedoDibuja ? 'El dedo pinta (toca para que solo mueva)' : 'El dedo mueve la página (toca para que pinte)',
                  activo: _dedoDibuja,
                  alTocar: () => setState(() {
                    _dedoDibuja = !_dedoDibuja;
                    _dedoElegido = true;
                  }),
                ),
              ]),
              const SizedBox(width: 12),
              FilledButton(onPressed: widget.alAcabar, child: const Text('Listo')),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _elegirGrosor(_Herramienta h) async {
    final codigo = h == _Herramienta.fosforito ? herramientaFosforito : herramientaBoligrafo;
    final elegido = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 420),
      builder: (d) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (var i = 0; i < 3; i++)
            ListTile(
              leading: Icon(_grosor[h] == i ? Icons.radio_button_checked : Icons.radio_button_unchecked),
              title: Text(['Fino', 'Medio', 'Grueso'][i]),
              trailing: Container(
                width: 44,
                height: grosoresAnotacion[codigo]![i] / 2 + 1,
                decoration: BoxDecoration(color: Color(h == _Herramienta.fosforito ? _colorFosfo : _colorBoli), borderRadius: BorderRadius.circular(8)),
              ),
              onTap: () => Navigator.pop(d, i),
            ),
        ]),
      ),
    );
    if (elegido != null) setState(() => _grosor[h] = elegido);
  }
}

/// Las anotaciones de una página (y el trazo en curso), en unidades de la
/// página. El fosforito va debajo y se multiplica con el papel.
class _PintorAnotaciones extends CustomPainter {
  _PintorAnotaciones(this.trazos, this.escala, this.version, {this.enCurso, required this.factores, required this.grosor, required this.color, required this.fosforito});
  final List<Trazo> trazos;
  final double escala;
  final int version;
  final List<Point<double>>? enCurso;
  final List<double> factores;
  final int grosor;
  final Color color;
  final bool fosforito;

  static final Map<String, Path> _cache = {};

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.scale(escala);
    for (final f in [true, false]) {
      for (final t in trazos) {
        if (t.esFosforito != f) continue;
        canvas.drawPath(
          _cache.putIfAbsent(t.id, () => caminoDeTrazo(t)),
          Paint()
            ..color = Color(t.color ?? coloresBoligrafo.first)
            ..blendMode = f ? BlendMode.multiply : BlendMode.srcOver,
        );
      }
    }
    final p = enCurso;
    if (p != null && p.isNotEmpty && factores.length == p.length) {
      canvas.drawPath(
        caminoTinta([for (final q in p) Offset(q.x, q.y)], [for (final f in factores) grosor * f]),
        Paint()
          ..color = color
          ..blendMode = fosforito ? BlendMode.multiply : BlendMode.srcOver,
      );
    }
    canvas.restore();
    if (_cache.length > 8000) _cache.clear();
  }

  @override
  bool shouldRepaint(_PintorAnotaciones old) => old.version != version || old.escala != escala || old.enCurso != null || enCurso != null || old.trazos.length != trazos.length;
}
