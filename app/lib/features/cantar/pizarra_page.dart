import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import 'pizarra_barra.dart';
import 'pizarra_compartida.dart';
import 'pizarra_formas.dart';
import 'pizarra_tinta.dart';
import 'pizarra_trazos.dart';

/// Abre la pizarra de la clase [canteId] del alumno [alumnoUid] a pantalla
/// completa, con [otroNombre] (el otro: el alumno o el preparador).
Future<void> abrirPizarra(BuildContext context, {required String alumnoUid, required String canteId, required String otroNombre, FirebaseFirestore? db}) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => PizarraPage(alumnoUid: alumnoUid, canteId: canteId, otroNombre: otroNombre, db: db)));

/// Abre la pizarra para practicar sola (sin clase): no se comparte ni se guarda.
Future<void> abrirPizarraIndividual(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => const PizarraPage.individual()));

/// Pizarra compartida de una clase: un lienzo en blanco en el que dibujan el
/// preparador y el alumno, cada uno con su color, y lo que pinta uno le llega
/// al otro al instante. Solo se comparte lo que se dibuja aquí, nada más del
/// móvil. Sirve en el móvil, la tableta y el ordenador (versión web).
///
/// Se parece a Notas del iPad: tinta con presión, la palma no pinta cuando se
/// usa un lápiz, dos dedos amplían y mueven la página (y dos toques con dos
/// dedos deshacen), y una paleta clara. A la vista solo está lo de la pizarra
/// del examen (bolígrafo, borrador, colores, deshacer); el rotulador, el
/// fosforito, el lazo, la regla, el papel y las formas, en el menú ···.
class PizarraPage extends ConsumerStatefulWidget {
  const PizarraPage({super.key, required this.alumnoUid, required this.canteId, required this.otroNombre, this.db}) : individual = false;

  /// Para practicar el cante sola: los trazos se quedan en el móvil, en
  /// memoria, y se pierden al cerrarla.
  const PizarraPage.individual({super.key})
      : alumnoUid = '',
        canteId = '',
        otroNombre = '',
        db = null,
        individual = true;

  final String alumnoUid;
  final String canteId;
  final String otroNombre;
  final bool individual;

  /// Base de datos (por defecto, la de Firebase; en las capturas, una simulada).
  final FirebaseFirestore? db;

  @override
  ConsumerState<PizarraPage> createState() => _PizarraPageState();
}

/// Un cambio en una página: quitar unos trazos y poner otros. Así se guardan
/// para deshacer (al revés) y rehacer.
class _Cambio {
  const _Cambio(this.quitar, this.poner);
  final List<Trazo> quitar;
  final List<Trazo> poner;
  _Cambio get inverso => _Cambio(poner, quitar);
}

/// Dedos sobre la pizarra que mueven o amplían la página (o la regla).
class _Gesto {
  _Gesto({required this.z, required this.t, required this.foco, required this.dist, required this.angulo, required this.inicio, this.regla});
  final double z;
  final Offset t;
  final Offset foco;
  final double dist;
  final double angulo;
  final Duration inicio;

  /// La regla al empezar, si el gesto la mueve a ella.
  final Regla? regla;
  int dedos = 0;

  /// Los dedos que llegó a haber a la vez (para los dos toques de deshacer).
  int maxDedos = 0;
  bool movido = false;
}

const _claveExtras = 'pizarraExtras';
const _claveFormas = 'pizarraFormas';

class _PizarraPageState extends ConsumerState<PizarraPage> {
  FuentePizarra? _pizarra;
  StreamSubscription<List<PaginaPizarra>>? _escucha;
  List<PaginaPizarra> _paginas = const [];
  int _pagina = 0;
  bool _sinAcceso = false;
  String? _aviso;
  late final String _miUid = widget.individual ? 'yo' : (ref.read(usuarioActualProvider)?.uid ?? '');

  // ------------------------------------------------------------ Herramientas
  HerramientaPizarra _herramienta = HerramientaPizarra.boligrafo;
  HerramientaPizarra _ultimaTinta = HerramientaPizarra.boligrafo;
  late final Map<HerramientaPizarra, int> _color = {
    HerramientaPizarra.boligrafo: _colorPorDefecto,
    HerramientaPizarra.rotulador: _colorPorDefecto,
    HerramientaPizarra.fosforito: 0xFFFFD60A,
  };
  final Map<HerramientaPizarra, int> _grosor = {HerramientaPizarra.boligrafo: 1, HerramientaPizarra.rotulador: 1, HerramientaPizarra.fosforito: 1};
  bool _borrarPorPartes = false;
  Regla? _regla;

  /// Herramientas extra puestas en la paleta (se recuerdan en el móvil).
  Set<String> _extras = {};
  bool _formas = true;

  /// Si el dedo dibuja: sí hasta que aparece un lápiz (entonces el dedo solo
  /// mueve y amplía, y la palma apoyada no pinta), salvo que se elija a mano.
  bool _dedoDibuja = true;
  bool _dedoElegido = false;

  // ------------------------------------------------------------ Trazo en curso
  // En unidades del lienzo, con el factor de grosor de cada punto.
  final List<Point<double>> _enCurso = [];
  final List<double> _factores = [];
  // Avisa al pintor del trazo en curso: cada punto repinta solo ese trazo, sin reconstruir la pantalla (con la letra rápida iba con retraso).
  final ValueNotifier<int> _puntos = ValueNotifier(0);
  int? _punteroDibujo;
  PointerDeviceKind? _tipoDibujo;
  Duration _inicioTrazo = Duration.zero;
  Duration _ultimoTiempo = Duration.zero;
  Offset _ultimaPantalla = Offset.zero;
  double _factor = 1;
  int? _cantoRegla;
  Timer? _temporizadorForma;
  bool _formaHecha = false;
  Offset? _anclaQuieto;
  HerramientaPizarra _herramientaTrazo = HerramientaPizarra.boligrafo;

  // ------------------------------------------------------------ Borrador
  // Lo que quita y pone la pasada del borrador (se guarda al levantar).
  final Map<String, Trazo> _gestoQuitar = {};
  final Map<String, Trazo> _gestoPoner = {};
  Point<double>? _ultimoBorrado;
  bool _borrando = false;

  // ------------------------------------------------------------ Lazo
  List<Point<double>>? _lazo;
  Set<String> _seleccion = {};
  Point<double>? _inicioArrastre;
  Point<double> _arrastre = const Point(0, 0);
  bool _arrastrando = false;

  // ------------------------------------------------------------ Sin confirmar
  // Trazos puestos aquí que el servidor aún no ha devuelto (con su página) y
  // trazos quitados aquí que aún vienen en el servidor.
  final List<(String, Trazo)> _pendientes = [];
  final Set<String> _borrados = {};

  // ------------------------------------------------------------ Historial
  final Map<String, List<_Cambio>> _hechos = {};
  final Map<String, List<_Cambio>> _deshechos = {};

  // ------------------------------------------------------------ Vista
  // Geometría del lienzo en pantalla (la calcula el LayoutBuilder) y el zoom.
  double _escala = 1;
  Offset _origen = Offset.zero;
  Size _area = Size.zero;
  double _z = 1;
  Offset _t = Offset.zero;
  final Map<int, Offset> _toques = {};
  final Map<int, Offset> _toquesInicio = {};
  _Gesto? _gesto;

  /// Cambia cada vez que cambian los trazos que se ven (para no repintarlos
  /// con cada punto del trazo en curso).
  int _version = 0;

  bool get _soyAlumno => _miUid == widget.alumnoUid;

  /// Mi color por defecto: azul el alumno, rojo el preparador.
  int get _colorPorDefecto => coloresRapidos[_soyAlumno || widget.individual ? 0 : 2];
  bool get _esTinta => _herramienta == HerramientaPizarra.boligrafo || _herramienta == HerramientaPizarra.rotulador || _herramienta == HerramientaPizarra.fosforito;
  Color get _miColor => Color(_color[_ultimaTinta]!);

  /// El color con el que el otro escribió por última vez en esta página.
  Color get _colorOtro {
    final suyo = _actual?.trazos.where((t) => t.de != _miUid).lastOrNull;
    return suyo == null ? Color(coloresRapidos[_soyAlumno ? 2 : 0]) : _colorDe(suyo).withValues(alpha: 1);
  }

  // Los trazos de versiones anteriores sin color: el del papel de quien los hizo.
  Color _colorDe(Trazo t) => Color(t.color ?? (t.de == widget.alumnoUid ? coloresPizarra[0] : coloresPizarra[1]));

  PaginaPizarra? get _actual => _pagina < _paginas.length ? _paginas[_pagina] : null;
  String get _idPaginaActual => _actual?.id ?? PizarraCompartida.idPagina(_pagina + 1);
  int get _nPaginaActual => _actual?.n ?? _pagina + 1;

  Box<dynamic>? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      WakelockPlus.enable().catchError((_) {});
    }
    try {
      _extras = {...((_caja?.get(_claveExtras) as List?) ?? const []).map((e) => e.toString())};
      _formas = _caja?.get(_claveFormas) as bool? ?? true;
    } catch (_) {}
    if (widget.individual) {
      _pizarra = PizarraLocal();
      _escucha = _pizarra!.escuchar().listen(_alLlegar);
    } else if (ref.read(serviciosProvider).firebaseDisponible && _miUid.isNotEmpty) {
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
    _temporizadorForma?.cancel();
    _escucha?.cancel();
    _puntos.dispose();
    _pizarra?.vaciar();
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      WakelockPlus.disable().catchError((_) {});
    }
    super.dispose();
  }

  /// setState que además avisa de que han cambiado los trazos que se ven.
  void _cambiaTrazos(VoidCallback f) => setState(() {
        f();
        _version++;
      });

  void _alLlegar(List<PaginaPizarra> paginas) {
    if (!mounted) return;
    _cambiaTrazos(() {
      _paginas = paginas;
      if (_pagina >= paginas.length && paginas.isNotEmpty) _pagina = paginas.length - 1;
      // Lo que ya ha confirmado el servidor deja de estar pendiente.
      final ids = {for (final p in paginas) for (final t in p.trazos) t.id};
      _pendientes.removeWhere((e) => ids.contains(e.$2.id));
      _borrados.removeWhere((id) => !ids.contains(id));
      // Aviso de que el otro la ha borrado entera: solo si pasa con la
      // pizarra abierta (no al abrirla) y unos segundos.
      final a = _actual;
      final borrada = a != null && a.trazos.isEmpty && a.borradoPor != null && a.borradoPor != _miUid;
      if (borrada && _habiaTrazos.contains(a.id)) _avisar('${widget.otroNombre} ha borrado la pizarra');
      _habiaTrazos
        ..clear()
        ..addAll([for (final p in paginas) if (p.trazos.isNotEmpty) p.id]);
    });
  }

  /// Páginas con algo escrito en la última lectura (para saber si se acaban de borrar).
  final Set<String> _habiaTrazos = {};
  Timer? _quitarAviso;

  void _avisar(String texto) {
    _aviso = texto;
    _quitarAviso?.cancel();
    _quitarAviso = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _aviso = null);
    });
  }

  /// Los trazos que se ven en la página actual: los del servidor menos los
  /// quitados aquí, más los puestos aquí que aún no han vuelto.
  List<Trazo> get _visibles {
    final ocultos = {..._borrados, ..._gestoQuitar.keys, if (_arrastrando) ..._seleccion};
    final servidor = _actual?.trazos ?? const <Trazo>[];
    final idsServidor = {for (final t in servidor) t.id};
    return [
      for (final t in servidor)
        if (!ocultos.contains(t.id)) t,
      for (final (p, t) in _pendientes)
        if (p == _idPaginaActual && !ocultos.contains(t.id) && !idsServidor.contains(t.id)) t,
      for (final t in _gestoPoner.values)
        if (!ocultos.contains(t.id)) t,
    ];
  }

  void _guardarPreferencias() {
    try {
      _caja?.put(_claveExtras, _extras.toList());
      _caja?.put(_claveFormas, _formas);
    } catch (_) {}
  }

  // ------------------------------------------------------------- Cambios

  /// Aplica un cambio aquí al momento y lo manda al servidor. Si [historial],
  /// se puede deshacer.
  Future<void> _aplicar(_Cambio c, {bool historial = true}) async {
    if (c.quitar.isEmpty && c.poner.isEmpty) return;
    final pagina = _idPaginaActual, n = _nPaginaActual;
    final idsPoner = {for (final t in c.poner) t.id};
    _cambiaTrazos(() {
      _borrados
        ..addAll(c.quitar.map((t) => t.id))
        ..removeAll(idsPoner);
      final quitar = {for (final t in c.quitar) t.id};
      _pendientes.removeWhere((e) => quitar.contains(e.$2.id));
      _pendientes.addAll([for (final t in c.poner) (pagina, t)]);
      if (historial) {
        (_hechos[pagina] ??= []).add(c);
        _deshechos[pagina]?.clear();
      }
    });
    // Lo que aún está en la cola se quita de ella sin escribir.
    final enServidor = [for (final t in c.quitar) if (!_pizarra!.quitarDeCola(t.id)) t];
    try {
      if (enServidor.isEmpty) {
        for (final t in c.poner) {
          _pizarra!.encolar(pagina, n, t);
        }
      } else {
        await _pizarra!.reemplazar(pagina, n, enServidor, c.poner);
      }
    } catch (_) {
      if (!mounted) return;
      _cambiaTrazos(() {
        _borrados.removeAll(c.quitar.map((t) => t.id));
        _pendientes.removeWhere((e) => idsPoner.contains(e.$2.id));
        if (historial) _hechos[pagina]?.remove(c);
        _avisar('No se ha podido guardar el cambio. ¿Hay conexión?');
      });
    }
  }

  bool get _puedeDeshacer => (_hechos[_idPaginaActual] ?? const []).isNotEmpty;
  bool get _puedeRehacer => (_deshechos[_idPaginaActual] ?? const []).isNotEmpty;

  void _deshacer() {
    final hechos = _hechos[_idPaginaActual];
    if (_sinAcceso || hechos == null || hechos.isEmpty) return;
    final c = hechos.removeLast();
    (_deshechos[_idPaginaActual] ??= []).add(c);
    _quitarSeleccion();
    _aplicar(c.inverso, historial: false);
  }

  void _rehacer() {
    final deshechos = _deshechos[_idPaginaActual];
    if (_sinAcceso || deshechos == null || deshechos.isEmpty) return;
    final c = deshechos.removeLast();
    (_hechos[_idPaginaActual] ??= []).add(c);
    _quitarSeleccion();
    _aplicar(c, historial: false);
  }

  // ------------------------------------------------------------- Vista

  /// De la pantalla (local al área) al lienzo.
  Point<double> _virtual(Offset p) {
    final q = (p - _t) / _z - _origen;
    return Point(q.dx / _escala, q.dy / _escala);
  }

  Point<double> _dentro(Point<double> v) => Point(v.x.clamp(0, anchoLienzo.toDouble()), v.y.clamp(0, altoLienzo.toDouble()));

  /// Del lienzo a la pantalla (local al área).
  Offset _pantalla(Point<double> v) => _t + (_origen + Offset(v.x, v.y) * _escala) * _z;

  /// Encaja el desplazamiento: sin ampliar, la página centrada; ampliada, sin
  /// dejar ver más allá de sus bordes.
  Offset _encajar(Offset t, double z) {
    double eje(double t, double area, double origen, double largo) {
      if (z * largo <= area) return (area - z * largo) / 2 - z * origen;
      return t.clamp(area - z * (origen + largo), -z * origen);
    }

    return Offset(eje(t.dx, _area.width, _origen.dx, anchoLienzo * _escala), eje(t.dy, _area.height, _origen.dy, altoLienzo * _escala));
  }

  void _ajustarPagina() => setState(() {
        _z = 1;
        _t = _encajar(Offset.zero, 1);
      });

  void _ampliarEn(Offset foco, double nuevoZ) {
    final z = nuevoZ.clamp(1.0, 5.0);
    setState(() {
      _t = _encajar(foco - (foco - _t) * (z / _z), z);
      _z = z;
    });
  }

  // ------------------------------------------------------------- Punteros

  bool _esLapiz(PointerDeviceKind k) => k == PointerDeviceKind.stylus || k == PointerDeviceKind.invertedStylus;

  void _bajar(PointerDownEvent e) {
    if (_sinAcceso) return;
    final k = e.kind;
    if (_esLapiz(k) && !_dedoElegido && _dedoDibuja) setState(() => _dedoDibuja = false);
    if (k == PointerDeviceKind.touch) {
      _toques[e.pointer] = e.localPosition;
      _toquesInicio[e.pointer] = e.localPosition;
      // Escribiendo con el lápiz, los dedos (la palma) no hacen nada.
      if (_punteroDibujo != null && _esLapiz(_tipoDibujo!)) return;
      if (_toques.length >= 2) {
        // Un segundo dedo: el primero no estaba dibujando, sino empezando a
        // mover o ampliar (si el trazo era muy corto, se anula).
        if (_punteroDibujo != null && _tipoDibujo == PointerDeviceKind.touch) {
          if (e.timeStamp - _inicioTrazo < const Duration(milliseconds: 350) || _largoEnCurso() < 30) {
            _anularTrazo();
          } else {
            _terminar();
          }
        }
        _empezarGesto(e.timeStamp);
        return;
      }
      final v = _virtual(e.localPosition);
      if (_regla != null && _regla!.contiene(v) && (_regla!.cantoJunto(v, 0) == null)) {
        _empezarGesto(e.timeStamp);
        return;
      }
      if (_dedoDibuja) {
        _empezar(e);
      } else {
        _empezarGesto(e.timeStamp);
      }
      return;
    }
    if (k == PointerDeviceKind.mouse && e.buttons & kPrimaryMouseButton == 0) return;
    // El lápiz manda: si había un dedo (la palma) dibujando, se anula.
    if (_punteroDibujo != null) {
      if (_tipoDibujo == PointerDeviceKind.touch && _esLapiz(k)) {
        _anularTrazo();
      } else if (_esLapiz(_tipoDibujo!) && _esLapiz(k)) {
        // El lápiz solo toca una vez a la vez: si aún figuraba un trazo suyo
        // (se perdió el aviso de levantarlo al escribir deprisa), se guarda y
        // se empieza el nuevo, en vez de ignorarlo.
        _terminar();
      } else {
        return;
      }
    }
    _gesto = null;
    final v = _virtual(e.localPosition);
    if (k == PointerDeviceKind.mouse && _regla != null && _regla!.contiene(v) && _regla!.cantoJunto(v, 0) == null) {
      // Con el ratón, arrastrar la regla.
      _toques[e.pointer] = e.localPosition;
      _toquesInicio[e.pointer] = e.localPosition;
      _empezarGesto(e.timeStamp);
      return;
    }
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
    // Con ratón, solo con el botón pulsado.
    if (e.kind == PointerDeviceKind.mouse && e.buttons == 0) return;
    _seguir(e);
  }

  void _levantar(PointerEvent e) {
    final eraToque = _toques.remove(e.pointer) != null;
    _toquesInicio.remove(e.pointer);
    if (eraToque && _gesto != null) {
      final g = _gesto!;
      // Dos dedos que tocan y se levantan enseguida sin moverse: deshacer.
      if (g.maxDedos >= 2 && !g.movido && e.timeStamp - g.inicio < const Duration(milliseconds: 300) && _toques.isEmpty) {
        _deshacer();
        HapticFeedback.lightImpact();
      }
      if (_toques.isEmpty) {
        _gesto = null;
      } else if (_toques.length != g.dedos) {
        _empezarGesto(e.timeStamp, movido: g.movido, maxDedos: g.maxDedos);
      }
    }
    if (e.pointer == _punteroDibujo) _terminar();
  }

  // ------------------------------------------------------------- Gestos

  void _empezarGesto(Duration ahora, {bool movido = false, int maxDedos = 0}) {
    final puntos = _toques.values.take(2).toList();
    if (puntos.isEmpty) return;
    final foco = puntos.length == 1 ? puntos.first : (puntos[0] + puntos[1]) / 2;
    final dist = puntos.length == 1 ? 0.0 : (puntos[0] - puntos[1]).distance;
    final angulo = puntos.length == 1 ? 0.0 : atan2(puntos[1].dy - puntos[0].dy, puntos[1].dx - puntos[0].dx);
    final sobreRegla = _regla != null && _regla!.contiene(_virtual(puntos.first));
    _gesto = _Gesto(z: _z, t: _t, foco: foco, dist: dist, angulo: angulo, inicio: _gesto?.inicio ?? ahora, regla: sobreRegla ? _regla : null)
      ..dedos = puntos.length
      ..maxDedos = max(maxDedos, max(puntos.length, _gesto?.maxDedos ?? 0))
      ..movido = movido || (_gesto?.movido ?? false);
  }

  void _seguirGesto() {
    final g = _gesto!;
    final puntos = _toques.values.take(2).toList();
    if (puntos.length != g.dedos) return;
    for (final id in _toques.keys) {
      if (((_toques[id]! - (_toquesInicio[id] ?? _toques[id]!))).distance > 12) g.movido = true;
    }
    final foco = puntos.length == 1 ? puntos.first : (puntos[0] + puntos[1]) / 2;
    if (g.regla != null) {
      // Mover (un dedo) o mover y girar (dos) la regla.
      final delta = _virtual(foco) - _virtual(g.foco);
      var r = g.regla!.movida(delta);
      if (puntos.length == 2) {
        final angulo = atan2(puntos[1].dy - puntos[0].dy, puntos[1].dx - puntos[0].dx);
        r = r.girada(angulo - g.angulo, _virtual(foco));
      }
      setState(() => _regla = r);
      return;
    }
    var z = g.z;
    if (puntos.length == 2 && g.dist > 0) z = (g.z * (puntos[0] - puntos[1]).distance / g.dist).clamp(1.0, 5.0);
    setState(() {
      _t = _encajar(foco - (g.foco - g.t) * (z / g.z), z);
      _z = z;
    });
  }

  void _rueda(PointerSignalEvent e) {
    if (e is! PointerScrollEvent) return;
    final v = _virtual(e.localPosition);
    if (_regla != null && _regla!.contiene(v)) {
      // La rueda sobre la regla la gira grado a grado.
      setState(() => _regla = _regla!.girada(e.scrollDelta.dy.sign * pi / 180, v));
      return;
    }
    final teclado = HardwareKeyboard.instance;
    if (teclado.isControlPressed || teclado.isMetaPressed) {
      _ampliarEn(e.localPosition, _z * exp(-e.scrollDelta.dy / 300));
    } else if (_z > 1) {
      setState(() => _t = _encajar(_t - e.scrollDelta, _z));
    }
  }

  // ------------------------------------------------------------- Dibujar

  double _largoEnCurso() {
    var l = 0.0;
    for (var i = 1; i < _enCurso.length; i++) {
      l += _enCurso[i].distanceTo(_enCurso[i - 1]);
    }
    return l * _escala * _z;
  }

  void _empezar(PointerDownEvent e) {
    final v = _dentro(_virtual(e.localPosition));
    _punteroDibujo = e.pointer;
    _tipoDibujo = e.kind;
    _inicioTrazo = e.timeStamp;
    _ultimoTiempo = e.timeStamp;
    _ultimaPantalla = e.localPosition;
    // La goma del lápiz (el otro extremo) borra.
    if (_herramienta == HerramientaPizarra.borrador || e.kind == PointerDeviceKind.invertedStylus) {
      _borrando = true;
      _ultimoBorrado = null;
      _borrarEn(v);
      return;
    }
    _borrando = false;
    if (_herramienta == HerramientaPizarra.lazo) {
      final sel = _cajaSeleccion();
      final margen = 12 / (_escala * _z);
      if (sel != null && Rectangle(sel.left - margen, sel.top - margen, sel.width + 2 * margen, sel.height + 2 * margen).containsPoint(v)) {
        _inicioArrastre = v;
        setState(() {
          _arrastrando = true;
          _arrastre = const Point(0, 0);
          _version++;
        });
      } else {
        _cambiaTrazos(() {
          _seleccion = {};
          _lazo = [v];
        });
      }
      return;
    }
    if (_actual?.llena ?? false) {
      _punteroDibujo = null;
      setState(() => _avisar('Página llena: abre otra'));
      return;
    }
    _herramientaTrazo = _herramienta;
    final grosor = _grosorActual;
    _cantoRegla = _regla?.cantoJunto(v, 30 / (_escala * _z) + grosor);
    _formaHecha = false;
    _anclaQuieto = e.localPosition;
    _factor = _esLapiz(e.kind) ? _factorPresion(e) : 1.0;
    setState(() {
      _enCurso
        ..clear()
        ..add(_sobreRegla(v, grosor));
      _factores
        ..clear()
        ..add(_conPresion ? _factor : 1);
    });
  }

  int get _grosorActual => grosoresHerramienta[_codigo(_herramientaTrazo)]![_grosor[_herramientaTrazo]!];

  /// El bolígrafo varía con la presión; el rotulador y el fosforito, no.
  bool get _conPresion => _herramientaTrazo == HerramientaPizarra.boligrafo;

  Point<double> _sobreRegla(Point<double> v, int grosor) => _cantoRegla == null ? v : _dentro(_regla!.sobreCanto(v, _cantoRegla!, grosor / 2));

  double _factorPresion(PointerEvent e) => factorPresion(e.pressure, e.pressureMin, e.pressureMax);

  void _seguir(PointerMoveEvent e) {
    final v = _dentro(_virtual(e.localPosition));
    if (_borrando) {
      _borrarEn(v);
      return;
    }
    if (_herramienta == HerramientaPizarra.lazo && _punteroDibujo != null) {
      if (_arrastrando && _inicioArrastre != null) {
        setState(() => _arrastre = v - _inicioArrastre!);
      } else if (_lazo != null && (_lazo!.isEmpty || v.distanceTo(_lazo!.last) * _escala * _z > 3)) {
        setState(() => _lazo!.add(v));
      }
      return;
    }
    if (_enCurso.isEmpty || _formaHecha) return;
    // Un punto nuevo en cuanto se mueve medio píxel: nada de saltos.
    if ((e.localPosition - _ultimaPantalla).distance < 0.5) return;
    final dt = max(1, (e.timeStamp - _ultimoTiempo).inMicroseconds) / 1000;
    final velocidad = (e.localPosition - _ultimaPantalla).distance / dt;
    _ultimaPantalla = e.localPosition;
    _ultimoTiempo = e.timeStamp;
    if (_conPresion) {
      // Con lápiz, la presión; con el dedo o el ratón, la velocidad (más
      // deprisa, más fino), suavizada.
      final objetivo = _esLapiz(e.kind) ? _factorPresion(e) : factorVelocidad(velocidad);
      _factor += (objetivo - _factor) * (_esLapiz(e.kind) ? 0.5 : 0.25);
    }
    _enCurso.add(_sobreRegla(v, _grosorActual));
    _factores.add(_conPresion ? _factor : 1);
    _puntos.value++;
    // Formas: si el lápiz se queda quieto un momento al final del trazo.
    if (_formas && _cantoRegla == null && (_anclaQuieto == null || (e.localPosition - _anclaQuieto!).distance > 3)) {
      _anclaQuieto = e.localPosition;
      _temporizadorForma?.cancel();
      _temporizadorForma = Timer(const Duration(milliseconds: 600), _convertirEnForma);
    }
  }

  void _convertirEnForma() {
    if (!mounted || _punteroDibujo == null || _enCurso.length < 3 || _formaHecha || !_esTinta) return;
    final forma = reconocerForma(_enCurso);
    if (forma == null) return;
    HapticFeedback.selectionClick();
    final medio = _factores.reduce((a, b) => a + b) / _factores.length;
    setState(() {
      _formaHecha = true;
      _enCurso
        ..clear()
        ..addAll(forma.map(_dentro));
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
      _lazo = null;
      _arrastrando = false;
    });
  }

  void _terminar() {
    _temporizadorForma?.cancel();
    _punteroDibujo = null;
    if (_borrando) {
      _borrando = false;
      final c = _Cambio(_gestoQuitar.values.toList(), _gestoPoner.values.toList());
      _cambiaTrazos(() {
        _gestoQuitar.clear();
        _gestoPoner.clear();
      });
      _aplicar(c);
      return;
    }
    if (_herramienta == HerramientaPizarra.lazo) {
      _terminarLazo();
      return;
    }
    if (_enCurso.isEmpty) return;
    // Las formas ya vienen limpias: todos sus puntos (simplificarlas dejaría
    // los puntos a saltos y el círculo, abollado).
    final idx = _formaHecha ? [for (var i = 0; i < _enCurso.length; i++) i] : indicesSimplificados(_enCurso, tolerancia: 0.5);
    final h = _herramientaTrazo;
    final color = h == HerramientaPizarra.fosforito ? (_color[h]! & 0x00FFFFFF) | (alfaFosforito << 24) : _color[h]!;
    final trazo = Trazo(
      id: nuevoIdTrazo(),
      de: _miUid,
      grosor: _grosorActual,
      // Siempre con su color (también el de por defecto): el otro lo ve tal cual.
      color: color,
      herramienta: _codigo(h),
      presiones: _conPresion && !_formaHecha ? [for (final i in idx) digitoDeFactor(_factores[i])] : null,
      puntos: [for (final i in idx) Point(_enCurso[i].x.round(), _enCurso[i].y.round())],
    );
    _enCurso.clear();
    _factores.clear();
    _aplicar(_Cambio(const [], [trazo]));
  }

  String _codigo(HerramientaPizarra h) => switch (h) {
        HerramientaPizarra.rotulador => herramientaRotulador,
        HerramientaPizarra.fosforito => herramientaFosforito,
        _ => herramientaBoligrafo,
      };

  /// Borrador: quita los trazos (de los dos) que toca o, por partes, solo el
  /// trozo que toca. Se guarda todo junto al levantar.
  void _borrarEn(Point<double> v) {
    if (_ultimoBorrado != null && v.distanceTo(_ultimoBorrado!) * _escala * _z < 3) return;
    _ultimoBorrado = v;
    final radio = (_borrarPorPartes ? 10 : 14) / (_escala * _z);
    var cambio = false;
    for (final t in _visibles) {
      if (_borrarPorPartes) {
        final trozos = trocear(t, v, radio);
        if (trozos == null) continue;
        cambio = true;
        if (_gestoPoner.remove(t.id) == null) _gestoQuitar[t.id] = t;
        for (final tr in trozos) {
          _gestoPoner[tr.id] = tr;
        }
      } else if (t.cerca(v, radio)) {
        cambio = true;
        if (_gestoPoner.remove(t.id) == null) _gestoQuitar[t.id] = t;
      }
    }
    if (cambio) _cambiaTrazos(() {});
  }

  // ------------------------------------------------------------- Lazo

  /// Lo seleccionado con el lazo (también mientras se arrastra).
  List<Trazo> get _seleccionados {
    if (_seleccion.isEmpty) return const [];
    final servidor = _actual?.trazos ?? const <Trazo>[];
    final idsServidor = {for (final t in servidor) t.id};
    return [
      for (final t in servidor)
        if (_seleccion.contains(t.id) && !_borrados.contains(t.id)) t,
      for (final (p, t) in _pendientes)
        if (p == _idPaginaActual && _seleccion.contains(t.id) && !idsServidor.contains(t.id)) t,
    ];
  }

  /// Caja de lo seleccionado, en unidades del lienzo (con el grosor).
  Rectangle<double>? _cajaSeleccion() {
    Rectangle<double>? caja;
    for (final t in _seleccionados) {
      final c = t.caja;
      final r = Rectangle<double>(c.left - t.grosor / 2, c.top - t.grosor / 2, c.width + t.grosor.toDouble(), c.height + t.grosor.toDouble());
      caja = caja == null ? r : caja.boundingBox(r);
    }
    return caja;
  }

  void _terminarLazo() {
    if (_arrastrando) {
      final d = _arrastre;
      final sel = _seleccionados;
      setState(() {
        _arrastrando = false;
        _arrastre = const Point(0, 0);
        _version++;
      });
      if (d.magnitude * _escala * _z < 2 || sel.isEmpty) return;
      final movidos = [for (final t in sel) t.copia(id: nuevoIdTrazo(), dx: d.x.round(), dy: d.y.round())];
      _seleccion = {for (final t in movidos) t.id};
      _aplicar(_Cambio(sel, movidos));
      return;
    }
    final lazo = _lazo;
    _cambiaTrazos(() {
      _lazo = null;
      _seleccion = lazo == null ? {} : {for (final t in rodeados(_visibles, lazo)) t.id};
    });
  }

  void _quitarSeleccion() {
    if (_seleccion.isEmpty && _lazo == null) return;
    _cambiaTrazos(() {
      _seleccion = {};
      _lazo = null;
    });
  }

  void _borrarSeleccion() {
    final sel = _seleccionados;
    _quitarSeleccion();
    _aplicar(_Cambio(sel, const []));
  }

  void _duplicarSeleccion() {
    final copias = [for (final t in _seleccionados) t.copia(id: nuevoIdTrazo(), dx: 30, dy: 30)];
    _seleccion = {for (final t in copias) t.id};
    _aplicar(_Cambio(const [], copias));
  }

  void _colorearSeleccion() {
    final sel = _seleccionados;
    final nuevos = [
      for (final t in sel) t.copia(id: nuevoIdTrazo(), color: t.esFosforito ? (_miColor.toARGB32() & 0x00FFFFFF) | (alfaFosforito << 24) : _miColor.toARGB32()),
    ];
    _seleccion = {for (final t in nuevos) t.id};
    _aplicar(_Cambio(sel, nuevos));
  }

  // ------------------------------------------------------------- Barra

  void _elegir(HerramientaPizarra h) {
    if (_herramienta == h) {
      _abrirAjustes(h);
      return;
    }
    setState(() {
      _herramienta = h;
      if (h != HerramientaPizarra.borrador && h != HerramientaPizarra.lazo) _ultimaTinta = h;
    });
    if (h != HerramientaPizarra.lazo) _quitarSeleccion();
  }

  void _elegirColor(int argb) {
    setState(() {
      if (!_esTinta && _herramienta != HerramientaPizarra.lazo) _herramienta = _ultimaTinta;
      _color[_ultimaTinta] = argb;
    });
    if (_herramienta == HerramientaPizarra.lazo && _seleccion.isNotEmpty) _colorearSeleccion();
  }

  /// Ajustes de la herramienta (al tocarla otra vez): el grosor o, en el
  /// borrador, cómo borra.
  Future<void> _abrirAjustes(HerramientaPizarra h) async {
    if (h == HerramientaPizarra.lazo) return;
    final borrador = h == HerramientaPizarra.borrador;
    final elegido = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 420),
      builder: (d) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (borrador) ...[
            _Opcion(elegida: !_borrarPorPartes, alTocar: () => Navigator.pop(d, 0), titulo: 'Borrar trazos enteros', subtitulo: 'Quita el trazo que tocas'),
            _Opcion(elegida: _borrarPorPartes, alTocar: () => Navigator.pop(d, 1), titulo: 'Borrar por partes', subtitulo: 'Como una goma: solo lo que tocas'),
          ] else
            for (var i = 0; i < 3; i++)
              _Opcion(
                elegida: _grosor[h] == i,
                alTocar: () => Navigator.pop(d, i),
                titulo: ['Fino', 'Medio', 'Grueso'][i],
                secondary: Container(
                  width: 44,
                  height: grosoresHerramienta[_codigo(h)]![i] / 2 + 1,
                  decoration: BoxDecoration(color: Color(_color[h]!).withValues(alpha: h == HerramientaPizarra.fosforito ? 0.5 : 1), borderRadius: BorderRadius.circular(8)),
                ),
              ),
        ]),
      ),
    );
    if (elegido == null) return;
    setState(() {
      if (borrador) {
        _borrarPorPartes = elegido == 1;
      } else {
        _grosor[h] = elegido;
      }
    });
  }

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
    if (elegido != null) _elegirColor(elegido.toARGB32());
  }

  void _cambiarExtra(String extra, bool puesto) {
    setState(() {
      if (puesto) {
        _extras.add(extra);
      } else {
        _extras.remove(extra);
      }
      switch (extra) {
        case 'regla':
          _regla = puesto ? Regla(centro: _virtual(Offset(_area.width / 2, _area.height / 2))) : null;
        case 'rotulador' || 'fosforito' || 'lazo':
          final h = HerramientaPizarra.values.byName(extra);
          if (puesto) {
            _herramienta = h;
            if (h != HerramientaPizarra.lazo) _ultimaTinta = h;
          } else if (_herramienta == h) {
            _herramienta = HerramientaPizarra.boligrafo;
            _ultimaTinta = HerramientaPizarra.boligrafo;
          }
      }
    });
    if (extra == 'lazo' && !puesto) _quitarSeleccion();
    _guardarPreferencias();
  }

  Future<void> _borrarTodo() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Vaciar esta página?'),
        content: Text(widget.individual ? 'Se borra lo escrito en esta página; la página se queda, en blanco.' : 'Se borra lo escrito en esta página para los dos (también para ${widget.otroNombre}); la página se queda, en blanco.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (ok != true) return;
    final pagina = _idPaginaActual;
    _cambiaTrazos(() {
      _pendientes.removeWhere((e) => e.$1 == pagina);
      _seleccion = {};
      _hechos.remove(pagina);
      _deshechos.remove(pagina);
    });
    try {
      await _pizarra!.borrarTodo(pagina);
    } catch (_) {}
  }

  /// Elimina la página entera (para los dos) y se pasa a la anterior.
  Future<void> _eliminarPagina() async {
    final actual = _actual;
    if (actual == null) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('¿Eliminar la página ${_pagina + 1}?'),
        content: Text(widget.individual ? 'Desaparece la página entera, con lo escrito.' : 'Desaparece la página entera, con lo escrito, para los dos (también para ${widget.otroNombre}).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Eliminar la página')),
        ],
      ),
    );
    if (ok != true) return;
    _cambiaTrazos(() {
      _pendientes.removeWhere((e) => e.$1 == actual.id);
      _hechos.remove(actual.id);
      _deshechos.remove(actual.id);
      _seleccion = {};
      if (_pagina > 0) _pagina--;
    });
    try {
      await _pizarra!.eliminarPagina(actual.id);
    } catch (_) {}
  }

  Future<void> _nuevaPagina() async {
    final n = (_paginas.isEmpty ? 1 : _paginas.last.n) + 1;
    if (n > maxPaginas) return;
    try {
      await _pizarra!.nuevaPagina(n);
      _irAPagina(n - 1);
    } catch (_) {}
  }

  void _irAPagina(int i) {
    _cambiaTrazos(() {
      _pagina = i;
      _seleccion = {};
      _lazo = null;
    });
  }

  Future<void> _cambiarFondo(String fondo) async {
    try {
      await _pizarra!.cambiarFondo(_idPaginaActual, _nPaginaActual, fondo);
    } catch (_) {}
  }

  // ------------------------------------------------------------- UI

  @override
  Widget build(BuildContext context) {
    final actual = _actual;
    final visibles = _visibles;
    final sel = _arrastrando ? _seleccionados : const <Trazo>[];
    final cajaSel = _seleccion.isEmpty ? null : _cajaSeleccion();
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true): _deshacer,
        const SingleActivator(LogicalKeyboardKey.keyZ, meta: true): _deshacer,
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true): _rehacer,
        const SingleActivator(LogicalKeyboardKey.keyZ, meta: true, shift: true): _rehacer,
        const SingleActivator(LogicalKeyboardKey.keyY, control: true): _rehacer,
        const SingleActivator(LogicalKeyboardKey.delete): () => _seleccion.isEmpty ? null : _borrarSeleccion(),
        const SingleActivator(LogicalKeyboardKey.backspace): () => _seleccion.isEmpty ? null : _borrarSeleccion(),
        const SingleActivator(LogicalKeyboardKey.escape): _quitarSeleccion,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          backgroundColor: fondoPizarra,
          body: SafeArea(
            child: Column(children: [
              Expanded(
                child: LayoutBuilder(builder: (context, c) {
                  final area = Size(c.maxWidth, c.maxHeight);
                  // Un pequeño margen alrededor del papel, como una hoja.
                  final escala = min((c.maxWidth - 16) / anchoLienzo, (c.maxHeight - 16) / altoLienzo);
                  final ancho = anchoLienzo * escala, alto = altoLienzo * escala;
                  final origen = Offset((c.maxWidth - ancho) / 2, (c.maxHeight - alto) / 2);
                  if (area != _area || escala != _escala) {
                    _area = area;
                    _escala = escala;
                    _origen = origen;
                    _t = _encajar(_t, _z);
                  }
                  final matriz = Matrix4.translationValues(_t.dx, _t.dy, 0)..multiply(Matrix4.diagonal3Values(_z, _z, 1));
                  return Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: _bajar,
                    onPointerMove: _mover,
                    onPointerUp: _levantar,
                    onPointerCancel: _levantar,
                    onPointerSignal: _rueda,
                    child: ClipRect(
                      child: Stack(children: [
                        Positioned.fill(
                          child: Transform(
                            transform: matriz,
                            child: Stack(children: [
                              Positioned(
                                left: origen.dx,
                                top: origen.dy,
                                width: ancho,
                                height: alto,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x26000000), blurRadius: 8, offset: Offset(0, 1))]),
                                  child: ClipRect(
                                    child: Stack(fit: StackFit.expand, children: [
                                      RepaintBoundary(child: CustomPaint(painter: _PintorFondo(actual?.fondo ?? fondoBlanco, escala))),
                                      RepaintBoundary(child: CustomPaint(painter: _PintorTrazos(visibles, escala, _colorDe, _version))),
                                      if (cajaSel != null || _lazo != null || sel.isNotEmpty) CustomPaint(painter: _PintorSeleccion(sel, _arrastre, cajaSel, _lazo, escala, _colorDe)),
                                      CustomPaint(
                                        painter: _PintorEnCurso(
                                          _enCurso,
                                          _factores,
                                          _enCurso.isEmpty ? 0 : _grosorActual,
                                          _herramientaTrazo == HerramientaPizarra.fosforito ? Color((_color[HerramientaPizarra.fosforito]! & 0x00FFFFFF) | (alfaFosforito << 24)) : Color(_color[_herramientaTrazo]!),
                                          escala,
                                          _puntos,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              if (_regla != null)
                                Positioned(left: origen.dx, top: origen.dy, width: ancho, height: alto, child: IgnorePointer(child: CustomPaint(painter: _PintorRegla(_regla!, escala)))),
                            ]),
                          ),
                        ),
                        if (cajaSel != null && !_arrastrando && _herramienta == HerramientaPizarra.lazo) _accionesSeleccion(cajaSel),
                        if (_sinAcceso)
                          Positioned.fill(
                            child: ColoredBox(
                              color: Colors.black54,
                              child: Center(child: Text('No tienes acceso a la pizarra de esta clase.', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white))),
                            ),
                          ),
                        if (_z > 1.01)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: ActionChip(
                              avatar: const Icon(Icons.fit_screen_outlined, size: 18),
                              label: Text('${(_z * 100).round()} %'),
                              tooltip: 'Ver la página entera',
                              onPressed: _ajustarPagina,
                            ),
                          ),
                        if (_aviso != null)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 8,
                            child: Center(
                              child: ActionChip(label: Text(_aviso!), avatar: const Icon(Icons.info_outline, size: 18), onPressed: () => setState(() => _aviso = null)),
                            ),
                          ),
                      ]),
                    ),
                  );
                }),
              ),
              _barra(),
            ]),
          ),
        ),
      ),
    );
  }

  /// Botones sobre lo seleccionado con el lazo.
  Widget _accionesSeleccion(Rectangle<double> caja) {
    final arriba = _pantalla(Point(caja.left, caja.top));
    final abajo = _pantalla(Point(caja.left, caja.bottom));
    final y = arriba.dy > 56 ? arriba.dy - 52 : min(abajo.dy + 8, _area.height - 52);
    return Positioned(
      left: arriba.dx.clamp(8.0, max(8.0, _area.width - 340)),
      top: y,
      child: Material(
        elevation: 3,
        color: tintaBarra,
        borderRadius: BorderRadius.circular(12),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          for (final (texto, accion) in [('Borrar', _borrarSeleccion), ('Duplicar', _duplicarSeleccion), ('Pintar del color', _colorearSeleccion)])
            TextButton(onPressed: accion, child: Text(texto, style: const TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }

  Widget _barra() {
    final colorElegido = _color[_ultimaTinta]! | 0xFF000000;
    final hayColorRapido = coloresRapidos.contains(colorElegido);
    final paginas = max(_paginas.length, 1);
    PuntaHerramienta punta(HerramientaPizarra h, String nombre) => PuntaHerramienta(
          herramienta: h,
          elegida: _herramienta == h,
          color: _color[h] == null ? tintaBarra : Color(_color[h]!),
          grosor: _grosor[h] ?? 0,
          nombre: nombre,
          alTocar: _sinAcceso ? () {} : () => _elegir(h),
          alMantener: () => _abrirAjustes(h),
        );
    return Container(
      color: fondoPizarra,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: max(0, MediaQuery.sizeOf(context).width - 8)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              BotonBarra(icono: Icons.close, tooltip: 'Salir', alTocar: () => Navigator.of(context).pop()),
              if (widget.individual)
                const Text('Para practicar: no se guarda', style: TextStyle(color: Color(0x99000000), fontSize: 12))
              else ...[
                _Leyenda(color: _miColor.withValues(alpha: 1), texto: 'Tú'),
                const SizedBox(width: 8),
                _Leyenda(color: _colorOtro, texto: widget.otroNombre),
              ],
              const SizedBox(width: 12),
            ]),
            PaletaFlotante(children: [
              punta(HerramientaPizarra.boligrafo, 'Bolígrafo'),
              if (_extras.contains('rotulador')) punta(HerramientaPizarra.rotulador, 'Rotulador'),
              if (_extras.contains('fosforito')) punta(HerramientaPizarra.fosforito, 'Fosforito'),
              punta(HerramientaPizarra.borrador, _borrarPorPartes ? 'Borrador (por partes)' : 'Borrador (trazos enteros)'),
              if (_extras.contains('lazo')) punta(HerramientaPizarra.lazo, 'Lazo: rodea trazos para moverlos'),
              if (_extras.contains('regla')) BotonBarra(icono: Icons.straighten, tooltip: _regla == null ? 'Poner la regla' : 'Quitar la regla', activo: _regla != null, alTocar: () => setState(() => _regla = _regla == null ? Regla(centro: _virtual(Offset(_area.width / 2, _area.height / 2))) : null)),
              const SeparadorPaleta(),
              for (var i = 0; i < coloresRapidos.length; i++)
                MuestraColor(color: Color(coloresRapidos[i]), nombre: nombresColoresRapidos[i], elegido: _esTinta && colorElegido == coloresRapidos[i], alTocar: () => _elegirColor(coloresRapidos[i])),
              RuedaColor(elegido: _esTinta && !hayColorRapido, color: Color(colorElegido), alTocar: _otroColor),
              const SeparadorPaleta(),
              BotonBarra(icono: Icons.undo, tooltip: 'Deshacer (o dos toques con dos dedos)', alTocar: _puedeDeshacer && !_sinAcceso ? _deshacer : null),
              BotonBarra(icono: Icons.redo, tooltip: 'Rehacer', alTocar: _puedeRehacer && !_sinAcceso ? _rehacer : null),
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(width: 12),
              BotonBarra(icono: Icons.chevron_left, tooltip: 'Página anterior', alTocar: _pagina > 0 ? () => _irAPagina(_pagina - 1) : null),
              Text('${_pagina + 1}/$paginas', style: const TextStyle(color: tintaBarra)),
              BotonBarra(icono: Icons.chevron_right, tooltip: 'Página siguiente', alTocar: _pagina < _paginas.length - 1 ? () => _irAPagina(_pagina + 1) : null),
              BotonBarra(icono: Icons.note_add_outlined, tooltip: 'Nueva página', alTocar: _sinAcceso || _paginas.length >= maxPaginas ? null : _nuevaPagina),
              _menu(),
            ]),
          ]),
        ),
      ),
    );
  }

  /// Menú ···: las herramientas extra, el papel, las formas, el dedo y
  /// vaciar o eliminar la página.
  Widget _menu() {
    final fondo = _actual?.fondo ?? fondoBlanco;
    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.info_outline),
          onPressed: null,
          child: const Text('En la paleta, además de lo de siempre:'),
        ),
        for (final (extra, nombre, icono) in [
          ('rotulador', 'Rotulador', Icons.brush_outlined),
          ('fosforito', 'Fosforito', Icons.border_color_outlined),
          ('lazo', 'Lazo (seleccionar y mover)', Icons.gesture),
          ('regla', 'Regla', Icons.straighten),
        ])
          CheckboxMenuButton(value: _extras.contains(extra), onChanged: (v) => _cambiarExtra(extra, v ?? false), trailingIcon: Icon(icono), child: Text(nombre)),
        const Divider(),
        CheckboxMenuButton(
          value: _formas,
          onChanged: (v) {
            setState(() => _formas = v ?? false);
            _guardarPreferencias();
          },
          child: const Text('Formas: mantén el lápiz al acabar'),
        ),
        CheckboxMenuButton(
          value: _dedoDibuja,
          onChanged: (v) => setState(() {
            _dedoDibuja = v ?? false;
            _dedoElegido = true;
          }),
          child: const Text('Dibujar con el dedo'),
        ),
        SubmenuButton(
          leadingIcon: const Icon(Icons.grid_4x4),
          menuChildren: [
            for (final (valor, nombre) in [(fondoBlanco, 'En blanco'), (fondoRayas, 'Rayas'), (fondoCuadricula, 'Cuadrícula')])
              MenuItemButton(
                leadingIcon: Icon(fondo == valor ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                onPressed: _sinAcceso ? null : () => _cambiarFondo(valor),
                child: Text(nombre),
              ),
          ],
          child: const Text('Papel de esta página'),
        ),
        if (_z > 1.01) MenuItemButton(leadingIcon: const Icon(Icons.fit_screen_outlined), onPressed: _ajustarPagina, child: const Text('Ver la página entera')),
        const Divider(),
        MenuItemButton(leadingIcon: const Icon(Icons.layers_clear_outlined), onPressed: _sinAcceso ? null : _borrarTodo, child: const Text('Vaciar la página')),
        MenuItemButton(leadingIcon: const Icon(Icons.delete_outline), onPressed: _sinAcceso || _actual == null ? null : _eliminarPagina, child: const Text('Eliminar la página')),
      ],
      builder: (context, controller, _) => BotonBarra(
        icono: Icons.more_horiz,
        tooltip: 'Más herramientas y opciones',
        alTocar: () => controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }
}

/// Una opción de los ajustes de la herramienta, marcada si es la elegida.
class _Opcion extends StatelessWidget {
  const _Opcion({required this.elegida, required this.alTocar, required this.titulo, this.subtitulo, this.secondary});
  final bool elegida;
  final VoidCallback alTocar;
  final String titulo;
  final String? subtitulo;
  final Widget? secondary;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(elegida ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: elegida ? Theme.of(context).colorScheme.primary : null),
        title: Text(titulo),
        subtitle: subtitulo == null ? null : Text(subtitulo!),
        trailing: secondary,
        selected: elegida,
        onTap: alTocar,
      );
}

class _Leyenda extends StatelessWidget {
  const _Leyenda({required this.color, required this.texto});
  final Color color;
  final String texto;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(width: 4),
        Text(texto, style: const TextStyle(color: tintaBarra, fontSize: 12), overflow: TextOverflow.ellipsis),
      ]);
}

/// Rayas o cuadrícula de la página.
class _PintorFondo extends CustomPainter {
  _PintorFondo(this.fondo, this.escala);
  final String fondo;
  final double escala;

  @override
  void paint(Canvas canvas, Size size) {
    if (fondo == fondoBlanco) return;
    final linea = Paint()
      ..color = fondo == fondoRayas ? const Color(0xFFB9CDE5) : const Color(0xFFDADDE2)
      ..strokeWidth = 1;
    for (var y = pasoFondo; y < altoLienzo; y += pasoFondo) {
      canvas.drawLine(Offset(0, y * escala), Offset(size.width, y * escala), linea);
    }
    if (fondo == fondoCuadricula) {
      for (var x = pasoFondo; x < anchoLienzo; x += pasoFondo) {
        canvas.drawLine(Offset(x * escala, 0), Offset(x * escala, size.height), linea);
      }
    }
  }

  @override
  bool shouldRepaint(_PintorFondo old) => old.fondo != fondo || old.escala != escala;
}

/// Trazos de la página, con los caminos en caché por id. El fosforito va
/// debajo, para no tapar lo escrito.
class _PintorTrazos extends CustomPainter {
  _PintorTrazos(this.trazos, this.escala, this.colorDe, this.version);
  final List<Trazo> trazos;
  final double escala;
  final Color Function(Trazo t) colorDe;
  final int version;

  static final Map<String, Path> _cache = {};

  static Path caminoDe(Trazo t) => _cache.putIfAbsent(t.id, () => caminoDeTrazo(t));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(escala);
    final pintura = Paint()..style = PaintingStyle.fill;
    for (final fosforito in [true, false]) {
      for (final t in trazos) {
        if (t.esFosforito != fosforito) continue;
        canvas.drawPath(caminoDe(t), pintura..color = colorDe(t));
      }
    }
    // La caché no crece sin límite.
    if (_cache.length > 6000) _cache.clear();
  }

  @override
  bool shouldRepaint(_PintorTrazos old) => old.escala != escala || old.version != version;
}

/// Lo seleccionado con el lazo (moviéndose) y el propio lazo.
class _PintorSeleccion extends CustomPainter {
  _PintorSeleccion(this.trazos, this.desplazamiento, this.caja, this.lazo, this.escala, this.colorDe);
  final List<Trazo> trazos;
  final Point<double> desplazamiento;
  final Rectangle<double>? caja;
  final List<Point<double>>? lazo;
  final double escala;
  final Color Function(Trazo t) colorDe;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(escala);
    final azul = Paint()
      ..color = const Color(0xFF0A84FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 / escala;
    canvas.save();
    canvas.translate(desplazamiento.x, desplazamiento.y);
    for (final t in trazos) {
      canvas.drawPath(_PintorTrazos.caminoDe(t), Paint()..color = colorDe(t));
    }
    if (caja != null) {
      final r = Rect.fromLTWH(caja!.left, caja!.top, caja!.width, caja!.height).inflate(6);
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(6)), Paint()..color = const Color(0x140A84FF));
      _discontinua(canvas, Path()..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(6))), azul);
    }
    canvas.restore();
    if (lazo != null && lazo!.length > 1) {
      final p = Path()..moveTo(lazo!.first.x, lazo!.first.y);
      for (final q in lazo!.skip(1)) {
        p.lineTo(q.x, q.y);
      }
      _discontinua(canvas, p, azul);
    }
  }

  void _discontinua(Canvas canvas, Path p, Paint pintura) {
    final paso = 8 / escala;
    for (final m in p.computeMetrics()) {
      for (var d = 0.0; d < m.length; d += paso * 2) {
        canvas.drawPath(m.extractPath(d, min(d + paso, m.length)), pintura);
      }
    }
  }

  @override
  bool shouldRepaint(_PintorSeleccion old) => true;
}

/// El trazo que se está dibujando: la misma tinta que el guardado.
class _PintorEnCurso extends CustomPainter {
  _PintorEnCurso(this.puntos, this.factores, this.grosor, this.color, this.escala, Listenable repintar) : super(repaint: repintar);
  final List<Point<double>> puntos;
  final List<double> factores;
  final int grosor;
  final Color color;
  final double escala;

  @override
  void paint(Canvas canvas, Size size) {
    if (puntos.isEmpty || factores.length != puntos.length) return;
    canvas.scale(escala);
    canvas.drawPath(
      caminoTinta([for (final p in puntos) Offset(p.x, p.y)], [for (final f in factores) grosor * f]),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_PintorEnCurso old) => true;
}

/// La regla: translúcida, con sus marcas y los grados en medio.
class _PintorRegla extends CustomPainter {
  _PintorRegla(this.regla, this.escala);
  final Regla regla;
  final double escala;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(escala);
    canvas.translate(regla.centro.x, regla.centro.y);
    canvas.rotate(regla.angulo);
    final r = Rect.fromCenter(center: Offset.zero, width: regla.largo, height: regla.ancho);
    canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(10)), Paint()..color = const Color(0xC83A3A3C));
    final marca = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1.5;
    for (var u = -regla.largo / 2 + 10; u < regla.largo / 2; u += 10) {
      final k = ((u + regla.largo / 2) / 10).round();
      final l = k % 10 == 0 ? 22.0 : (k % 5 == 0 ? 15.0 : 8.0);
      canvas.drawLine(Offset(u, -regla.ancho / 2), Offset(u, -regla.ancho / 2 + l), marca);
      canvas.drawLine(Offset(u, regla.ancho / 2), Offset(u, regla.ancho / 2 - l), marca);
    }
    final texto = TextPainter(
      text: TextSpan(text: '${regla.grados}°', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600, fontFamily: Fuentes.sans)),
      textDirection: TextDirection.ltr,
    )..layout();
    texto.paint(canvas, Offset(-texto.width / 2, -texto.height / 2));
  }

  @override
  bool shouldRepaint(_PintorRegla old) => old.regla != regla || old.escala != escala;
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
