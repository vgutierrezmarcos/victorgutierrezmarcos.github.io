import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/constants.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import 'pizarra_barra.dart';
import 'pizarra_compartida.dart';
import 'pizarra_formas.dart';
import 'pizarra_pdf.dart';
import 'pizarra_plataforma.dart';
import 'pizarra_registro.dart';
import 'pizarra_texto.dart';
import 'pizarra_tinta.dart';
import 'pizarra_trazos.dart';

/// Abre la pizarra de la clase [canteId] del alumno [alumnoUid] a pantalla
/// completa, con [otroNombre] (el otro: el alumno o el preparador).
Future<void> abrirPizarra(BuildContext context, {required String alumnoUid, required String canteId, required String otroNombre, String etiqueta = '', FirebaseFirestore? db}) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => PizarraPage(alumnoUid: alumnoUid, canteId: canteId, otroNombre: otroNombre, etiqueta: etiqueta, db: db)));

/// Abre la pizarra para practicar sola (sin clase): no se comparte ni se guarda.
Future<void> abrirPizarraIndividual(BuildContext context) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => const PizarraPage.individual()));

/// Abre las notas del preparador de la clase [canteId]: la escribe el
/// preparador [preparadorUid] y el alumno [alumnoUid] la ve, sin poder tocarla
/// ([soloLectura]), cuando el preparador la comparte. [alCompartir] guarda en
/// la clase que está compartida (o deja de estarlo).
Future<void> abrirNotas(BuildContext context, {required String alumnoUid, required String canteId, required String preparadorUid, required String otroNombre, required bool soloLectura, Future<void> Function(bool)? alCompartir, String etiqueta = '', FirebaseFirestore? db}) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => PizarraPage.notas(alumnoUid: alumnoUid, canteId: canteId, preparadorUid: preparadorUid, otroNombre: otroNombre, soloLectura: soloLectura, alCompartir: alCompartir, etiqueta: etiqueta, db: db),
    ));

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
  const PizarraPage({super.key, required this.alumnoUid, required this.canteId, required this.otroNombre, this.db, this.etiqueta = ''})
      : individual = false,
        notas = false,
        preparadorUid = '',
        soloLectura = false,
        alCompartir = null,
        fuente = null,
        eventosDom = null;

  /// Para practicar el cante sola: los trazos se quedan en el móvil, en
  /// memoria, y se pierden al cerrarla.
  const PizarraPage.individual({super.key, @visibleForTesting this.fuente, @visibleForTesting this.eventosDom})
      : alumnoUid = '',
        canteId = '',
        otroNombre = '',
        db = null,
        etiqueta = '',
        individual = true,
        notas = false,
        preparadorUid = '',
        soloLectura = false,
        alCompartir = null;

  /// Las notas del preparador de una clase: una segunda pizarra, igual que
  /// la compartida, que solo escribe el preparador y que el alumno ve (sin
  /// tocarla) cuando el preparador la comparte y la clase ha terminado.
  const PizarraPage.notas({super.key, required this.alumnoUid, required this.canteId, required this.preparadorUid, required this.otroNombre, required this.soloLectura, this.alCompartir, this.etiqueta = '', this.db, @visibleForTesting this.fuente})
      : individual = false,
        notas = true,
        eventosDom = null;

  final String alumnoUid;
  final String canteId;
  final String otroNombre;
  final bool individual;

  /// Las notas del preparador (ver [PizarraPage.notas]).
  final bool notas;
  final String preparadorUid;

  /// Solo mirar: sin paleta, sin escribir (el alumno con las notas).
  final bool soloLectura;

  /// Al compartir las notas con el alumno (o dejar de hacerlo).
  final Future<void> Function(bool compartidas)? alCompartir;

  /// Para el nombre del PDF (la fecha de la clase, por ejemplo).
  final String etiqueta;

  /// Base de datos (por defecto, la de Firebase; en las capturas, una simulada).
  final FirebaseFirestore? db;

  /// Para las pruebas: dónde van los trazos de la pizarra individual y los
  /// eventos del navegador que simula la prueba.
  final FuentePizarra? fuente;
  final Stream<EventoDom>? eventosDom;

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
const _claveAvisoScribble = 'pizarraAvisoScribble';

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
  final Map<HerramientaPizarra, int> _grosor = {HerramientaPizarra.boligrafo: 1, HerramientaPizarra.rotulador: 1, HerramientaPizarra.fosforito: 1, HerramientaPizarra.texto: 1};
  bool _borrarPorPartes = false;
  Regla? _regla;

  // ------------------------------------------------------------ Texto a máquina
  // El toque con la herramienta de texto: si se levanta sin moverse, se escribe ahí.
  (int, Offset)? _toqueTexto;

  // ------------------------------------------------------------ Notas del preparador
  // Si las notas están compartidas con el alumno.
  bool _compartida = false;

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

  // ------------------------------------------------------------ Navegador
  // En la web, el navegador avisa de los eventos del lápiz antes que el motor
  // de Flutter, que a veces los pierde (ver pizarra_web.dart).
  void Function()? _desenganchar;
  StreamSubscription<EventoDom>? _escuchaDom;
  // El navegador apoyó el lápiz con un trazo abierto: el move que venga lo cierra.
  bool _corteDomPendiente = false;
  // El navegador levantó el lápiz: si Flutter no lo dice, se cierra el trazo.
  Timer? _cierreDom;

  // ------------------------------------------------------------ Registro
  final RegistroPizarra _registro = RegistroPizarra();
  String _versionApp = '';
  int _nTrazos = 0;
  Duration? _tsAnterior;
  TimingsCallback? _fotogramas;

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
    _registro.activo = depuracionPedidaEnUrl;
    if (_registro.activo) {
      String ms(Duration d) => (d.inMicroseconds / 1000).toStringAsFixed(1);
      _fotogramas = (timings) {
        for (final t in timings) {
          if (t.totalSpan.inMilliseconds > 32) _registro.anotar('FR', 'build=${ms(t.buildDuration)} raster=${ms(t.rasterDuration)} total=${ms(t.totalSpan)}');
        }
      };
      SchedulerBinding.instance.addTimingsCallback(_fotogramas!);
      PackageInfo.fromPlatform().then((p) => _versionApp = '${p.version} (${p.buildNumber})').catchError((_) => '');
    }
    _desenganchar = engancharPizarraWeb(evitarScribble: parcheScribblePedido, alEvento: _eventoDom, volcarRegistro: () => _registro.volcar(cabecera: _cabeceraRegistro()));
    _escuchaDom = widget.eventosDom?.listen(_eventoDom);
    if (widget.individual || widget.fuente != null) {
      _pizarra = widget.fuente ?? PizarraLocal();
      _escucha = _pizarra!.escuchar().listen(_alLlegar);
    } else if (ref.read(serviciosProvider).firebaseDisponible && _miUid.isNotEmpty) {
      final db = widget.db ?? FirebaseFirestore.instance;
      _pizarra = widget.notas
          ? PizarraCompartida.notasDeClase(db, ref.read(oposicionProvider), preparadorUid: widget.preparadorUid, alumnoUid: widget.alumnoUid, canteId: widget.canteId, miUid: _miUid)
          : PizarraCompartida.deClase(db, ref.read(oposicionProvider), alumnoUid: widget.alumnoUid, canteId: widget.canteId, miUid: _miUid);
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
    _cierreDom?.cancel();
    _escuchaDom?.cancel();
    _desenganchar?.call();
    if (_fotogramas != null) SchedulerBinding.instance.removeTimingsCallback(_fotogramas!);
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
    final cron = _registro.activo ? (Stopwatch()..start()) : null;
    if (cron != null) {
      // Se mide después de aplicar el cambio (al final del fotograma, lo que
      // cuesta reconstruir con las páginas nuevas).
      WidgetsBinding.instance.addPostFrameCallback((_) => _registro.anotar('MED', 'llegan ${paginas.length} páginas y ${paginas.fold(0, (n, p) => n + p.trazos.length)} trazos: ms=${(cron.elapsedMicroseconds / 1000).toStringAsFixed(1)}'));
    }
    _cambiaTrazos(() {
      _paginas = paginas;
      if (widget.notas && paginas.isNotEmpty) _compartida = paginas.every((p) => p.visible);
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

  // ---- Registro (solo con ?depurar=1)

  void _log(String texto) => _registro.anotar('LOG', texto);

  void _anotarEvento(String tipo, PointerEvent e) {
    if (!_registro.activo) return;
    final dt = _tsAnterior == null ? '' : ' dt=${((e.timeStamp - _tsAnterior!).inMicroseconds / 1000).toStringAsFixed(1)}';
    _tsAnterior = e.timeStamp;
    _registro.anotar('FL', '$tipo ${e.kind.name} ptr=${e.pointer} dev=${e.device} b=${e.buttons} p=${e.pressure.toStringAsFixed(2)} x=${e.localPosition.dx.toStringAsFixed(1)} y=${e.localPosition.dy.toStringAsFixed(1)} ts=${(e.timeStamp.inMicroseconds / 1000).toStringAsFixed(1)}$dt');
  }

  String _cabeceraRegistro() => [
        'Registro de la pizarra ${widget.individual ? 'individual' : 'de clase'} · versión $_versionApp · ${kIsWeb ? 'web' : 'móvil'} · parche Scribble: ${parcheScribblePedido ? 'sí' : 'no'}',
        if (kIsWeb) agenteNavegador(),
        'área=${_area.width.toStringAsFixed(0)}x${_area.height.toStringAsFixed(0)} escala=${_escala.toStringAsFixed(3)} z=${_z.toStringAsFixed(2)} trazos=$_nTrazos dedoDibuja=$_dedoDibuja formas=$_formas',
        'Flutter: ptr=puntero dev=dispositivo (-4 es el lápiz en la web) b=botones p=presión dt=ms desde el evento anterior',
      ].join('\n');

  void _copiarRegistro() => compartirTexto(context, _registro.volcar(cabecera: _cabeceraRegistro()));

  // ---- El navegador (web)

  /// Lo que ve el navegador antes que el motor de Flutter, para cerrar los
  /// trazos que el motor no cierra: con un trazo del lápiz aún abierto, un
  /// `pointerdown` le sale al motor como un move (y uniría dos letras con una
  /// raya), y un `pointerup` después de un `pointerleave` no le sale.
  void _eventoDom(EventoDom e) {
    if (_registro.activo) _registro.anotar('DOM', e.linea);
    if (e.puntero != 'pen' || _sinAcceso) return;
    switch (e.tipo) {
      case 'pointerdown':
        _cierreDom?.cancel();
        if (_punteroDibujo != null && _esLapiz(_tipoDibujo!)) _corteDomPendiente = true;
      case 'pointerup' || 'pointercancel':
        // Un Timer, no un microtask: tiene que correr después de que el motor
        // y Flutter hayan despachado este mismo evento.
        _cierreDom?.cancel();
        _cierreDom = Timer(const Duration(milliseconds: 30), _cerrarSiSigueAbierto);
    }
  }

  /// En el iPad, Scribble se queda con las letras rápidas del Apple Pencil
  /// antes de que lleguen al navegador y no hay forma de evitarlo desde la
  /// web: la primera vez que un lápiz toca la pizarra en un navegador de
  /// Apple se explica cómo desactivarlo (y no se vuelve a decir).
  void _avisarScribble() {
    if (!kIsWeb || !navegadorApple()) return;
    bool visto;
    try {
      visto = _caja?.get(_claveAvisoScribble) == true;
    } catch (_) {
      visto = true;
    }
    if (visto) return;
    try {
      _caja?.put(_claveAvisoScribble, true);
    } catch (_) {}
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog<void>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Apple Pencil en el navegador'),
          content: const Text('Si Scribble está activado, el iPad se queda con las letras rápidas y en la pizarra faltan trazos. Desactívalo en Ajustes → Apple Pencil → Scribble.'),
          actions: [FilledButton(onPressed: () => Navigator.pop(d), child: const Text('Entendido'))],
        ),
      );
    });
  }

  void _cerrarSiSigueAbierto() {
    if (!mounted || _punteroDibujo == null || !_esLapiz(_tipoDibujo!)) return;
    _log('el navegador levantó el lápiz y Flutter no lo dijo: terminar');
    _terminar();
  }

  void _bajar(PointerDownEvent e) {
    _anotarEvento('down', e);
    _corteDomPendiente = false;
    _cierreDom?.cancel();
    if (_sinAcceso) return;
    final k = e.kind;
    if (widget.soloLectura) {
      // Solo mirar: cualquier puntero mueve la página y dos dedos la amplían.
      if (k == PointerDeviceKind.mouse && e.buttons & kPrimaryMouseButton == 0) return;
      _toques[e.pointer] = e.localPosition;
      _toquesInicio[e.pointer] = e.localPosition;
      _empezarGesto(e.timeStamp);
      return;
    }
    if (_esLapiz(k) && !_dedoElegido && _dedoDibuja) setState(() => _dedoDibuja = false);
    if (_esLapiz(k)) _avisarScribble();
    if (k == PointerDeviceKind.touch) {
      _toques[e.pointer] = e.localPosition;
      _toquesInicio[e.pointer] = e.localPosition;
      // Escribiendo con el lápiz, los dedos (la palma) no hacen nada.
      if (_punteroDibujo != null && _esLapiz(_tipoDibujo!)) {
        _log('dedo con el lápiz escribiendo: ignorado (palma)');
        return;
      }
      if (_herramienta == HerramientaPizarra.texto && _toques.length == 1) {
        // Con el texto, un toque escribe donde se toca; arrastrar, mueve.
        _toqueTexto = (e.pointer, e.localPosition);
        _empezarGesto(e.timeStamp);
        return;
      }
      _toqueTexto = null;
      if (_toques.length >= 2) {
        // Un segundo dedo: el primero no estaba dibujando, sino empezando a
        // mover o ampliar (si el trazo era muy corto, se anula).
        if (_punteroDibujo != null && _tipoDibujo == PointerDeviceKind.touch) {
          if (e.timeStamp - _inicioTrazo < const Duration(milliseconds: 350) || _largoEnCurso() < 30) {
            _log('segundo dedo: se anula el trazo corto del primero');
            _anularTrazo();
          } else {
            _log('segundo dedo: se guarda el trazo del primero');
            _terminar();
          }
        }
        _log('gesto con ${_toques.length} dedos');
        _empezarGesto(e.timeStamp);
        return;
      }
      final v = _virtual(e.localPosition);
      if (_regla != null && _regla!.contiene(v) && (_regla!.cantoJunto(v, 0) == null)) {
        _log('dedo sobre la regla: gesto');
        _empezarGesto(e.timeStamp);
        return;
      }
      if (_dedoDibuja) {
        _log('empezar trazo con el dedo');
        _empezar(e);
      } else {
        _log('dedo que no dibuja: gesto');
        _empezarGesto(e.timeStamp);
      }
      return;
    }
    if (k == PointerDeviceKind.mouse && e.buttons & kPrimaryMouseButton == 0) return;
    // El lápiz manda: si había un dedo (la palma) dibujando, se anula.
    if (_punteroDibujo != null) {
      if (_tipoDibujo == PointerDeviceKind.touch && _esLapiz(k)) {
        _log('lápiz: se anula el trazo del dedo (palma)');
        _anularTrazo();
      } else if (_esLapiz(_tipoDibujo!) && _esLapiz(k)) {
        // El lápiz solo toca una vez a la vez: si aún figuraba un trazo suyo
        // (se perdió el aviso de levantarlo al escribir deprisa), se guarda y
        // se empieza el nuevo, en vez de ignorarlo.
        _log('lápiz con un trazo suyo abierto (se perdió el levantar): terminar y empezar');
        _terminar();
      } else {
        _log('ignorado: ya dibuja otro puntero (${_tipoDibujo!.name})');
        return;
      }
    }
    _gesto = null;
    final v = _virtual(e.localPosition);
    if (_herramienta == HerramientaPizarra.texto) {
      _toqueTexto = (e.pointer, e.localPosition);
      return;
    }
    if (k == PointerDeviceKind.mouse && _regla != null && _regla!.contiene(v) && _regla!.cantoJunto(v, 0) == null) {
      // Con el ratón, arrastrar la regla.
      _toques[e.pointer] = e.localPosition;
      _toquesInicio[e.pointer] = e.localPosition;
      _empezarGesto(e.timeStamp);
      return;
    }
    _log('empezar trazo (${k.name})');
    _empezar(e);
  }

  void _mover(PointerMoveEvent e) {
    _anotarEvento('move', e);
    if (_toques.containsKey(e.pointer)) {
      _toques[e.pointer] = e.localPosition;
      if (_gesto != null) {
        _seguirGesto();
        return;
      }
    }
    if (e.pointer != _punteroDibujo) {
      if (_registro.activo && _esLapiz(e.kind)) _log('move del lápiz con otro puntero (dibuja ${_punteroDibujo ?? '-'}): ignorado');
      return;
    }
    if (_corteDomPendiente) {
      _corteDomPendiente = false;
      if (_esLapiz(e.kind)) {
        // El motor dio el pointerdown del navegador como un move: aquí
        // empieza el trazo nuevo, sin la raya desde el anterior.
        _log('el navegador apoyó el lápiz y Flutter lo dio como move: terminar y empezar aquí');
        _terminar();
        _empezar(e);
        return;
      }
    }
    // Con ratón, solo con el botón pulsado.
    if (e.kind == PointerDeviceKind.mouse && e.buttons == 0) return;
    _seguir(e);
  }

  void _levantar(PointerEvent e) {
    _anotarEvento(e is PointerCancelEvent ? 'cancel' : 'up', e);
    if (_registro.activo && e.pointer == _punteroDibujo) _log('${e is PointerCancelEvent ? 'cancel' : 'up'}: terminar (puntos=${_enCurso.length})');
    final eraToque = _toques.remove(e.pointer) != null;
    _toquesInicio.remove(e.pointer);
    final toqueTexto = _toqueTexto;
    if (toqueTexto != null && toqueTexto.$1 == e.pointer) {
      _toqueTexto = null;
      if (e is! PointerCancelEvent && (e.localPosition - toqueTexto.$2).distance < 10 && _gesto?.maxDedos != 2) {
        if (eraToque) _gesto = null;
        _editarTextoEn(_dentro(_virtual(toqueTexto.$2)));
        return;
      }
    }
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

  /// Empieza un trazo en [e] (un down o, si el motor se comió el down, el
  /// primer move).
  void _empezar(PointerEvent e) {
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
    // WebKit en el iPad manda muchos puntos del lápiz dos veces (el mismo
    // instante, los mismos puntos): el tiempo nunca va hacia atrás.
    if (_esLapiz(e.kind) && e.timeStamp <= _ultimoTiempo) {
      if (_registro.activo) _log('punto repetido (ts=${(e.timeStamp.inMicroseconds / 1000).toStringAsFixed(1)}): ignorado');
      return;
    }
    // Un punto nuevo en cuanto se mueve medio píxel: nada de saltos.
    if ((e.localPosition - _ultimaPantalla).distance < 0.5) return;
    if (_esLapiz(e.kind) && _cantoRegla == null && cortaTrazoLapiz(e.timeStamp - _ultimoTiempo, (e.localPosition - _ultimaPantalla).distance)) {
      // Una pausa y un salto a la vez no son un trazo: el navegador se tragó
      // el levantar y el apoyar (ver pizarra_registro.dart).
      _log('corte: ${(e.timeStamp - _ultimoTiempo).inMilliseconds} ms y ${(e.localPosition - _ultimaPantalla).distance.toStringAsFixed(0)} px sin puntos: trazo nuevo');
      _terminar();
      _empezar(e);
      return;
    }
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
    _log('anular trazo (puntos=${_enCurso.length})');
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
    final cron = _registro.activo ? (Stopwatch()..start()) : null;
    final nPuntos = _enCurso.length;
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
    _nTrazos++;
    _aplicar(_Cambio(const [], [trazo]));
    if (cron != null) _log('terminar: trazo $_nTrazos puntos=$nPuntos simplificados=${idx.length} ms=${(cron.elapsedMicroseconds / 1000).toStringAsFixed(1)}');
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
      final g = t.esTexto ? 0 : t.grosor;
      final r = Rectangle<double>(c.left - g / 2, c.top - g / 2, c.width + g.toDouble(), c.height + g.toDouble());
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

  // ------------------------------------------------------------- Texto a máquina

  /// Escribe un cuadro de texto en [v] o, si ahí ya hay uno, lo corrige.
  Future<void> _editarTextoEn(Point<double> v) async {
    if (_sinAcceso) return;
    final existente = _visibles.where((t) => t.esTexto && t.cerca(v, 4)).lastOrNull;
    if (existente == null && (_actual?.llena ?? false)) {
      setState(() => _avisar('Página llena: abre otra'));
      return;
    }
    final texto = await _dialogoTexto(existente?.texto ?? '');
    if (texto == null || !mounted) return;
    if (texto.isEmpty) {
      if (existente != null) _aplicar(_Cambio([existente], const []));
      return;
    }
    final posicion = existente?.puntos.first ?? Point(v.x.round(), v.y.round());
    final tamano = existente?.tamano ?? tamanosTexto[_grosor[HerramientaPizarra.texto] ?? 1];
    final medida = medirTexto(texto, tamano, anchoMax: min(anchoMaxTexto, anchoLienzo - posicion.x - 10).toDouble());
    final nuevo = Trazo.texto(
      id: nuevoIdTrazo(),
      de: _miUid,
      posicion: posicion,
      texto: texto,
      tamano: tamano,
      ancho: medida.width.ceil(),
      alto: medida.height.ceil(),
      color: existente?.color ?? _miColor.toARGB32(),
    );
    _aplicar(_Cambio(existente == null ? const [] : [existente], [nuevo]));
  }

  /// El cuadro para escribir: devuelve el texto (vacío para quitarlo) o null
  /// si se cancela.
  Future<String?> _dialogoTexto(String inicial) {
    final control = TextEditingController(text: inicial);
    return showDialog<String>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text(inicial.isEmpty ? 'Escribir en la pizarra' : 'Corregir el texto'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: TextField(
            controller: control,
            autofocus: true,
            minLines: 2,
            maxLines: 8,
            maxLength: maxCaracteresTexto,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Se ve en la pizarra, con tu color', border: OutlineInputBorder()),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          if (inicial.isNotEmpty) TextButton(onPressed: () => Navigator.pop(d, ''), child: const Text('Quitar')),
          FilledButton(onPressed: () => Navigator.pop(d, control.text.trim()), child: const Text('Poner')),
        ],
      ),
      // El cuadro aún se pinta mientras se cierra: se libera después (sin
      // esperar a ello para devolver el texto).
    ).whenComplete(() {
      Future<void>.delayed(const Duration(seconds: 1), control.dispose);
    });
  }

  // ------------------------------------------------------------- PDF

  /// Lo que se ve de cada página (lo del servidor menos lo quitado aquí, más
  /// lo pendiente), para el PDF.
  List<Trazo> _trazosDe(PaginaPizarra p) {
    final ids = {for (final t in p.trazos) t.id};
    return [
      for (final t in p.trazos)
        if (!_borrados.contains(t.id)) t,
      for (final (id, t) in _pendientes)
        if (id == p.id && !_borrados.contains(t.id) && !ids.contains(t.id)) t,
    ];
  }

  /// Todas las páginas en un PDF, para guardarlo o compartirlo.
  Future<void> _guardarPdf() async {
    final paginas = [for (final p in _paginas) PaginaPizarra(id: p.id, n: p.n, trazos: _trazosDe(p), fondo: p.fondo)];
    if (paginas.every((p) => p.trazos.isEmpty)) {
      setState(() => _avisar('No hay nada que guardar'));
      return;
    }
    setState(() => _avisar('Preparando el PDF…'));
    try {
      final titulo = widget.notas ? 'Notas del preparador' : 'Pizarra';
      final bytes = await pdfPizarra(paginas, colorDe: (t) => _colorDe(t).toARGB32(), letra: await letraParaPdf(), titulo: titulo);
      await guardarBytes(nombre: '$titulo${widget.etiqueta.isEmpty ? '' : ' ${widget.etiqueta}'}.pdf', bytes: bytes, mime: 'application/pdf', asunto: titulo);
      if (mounted) setState(() => _aviso = null);
    } catch (e) {
      if (mounted) setState(() => _avisar('No se ha podido preparar el PDF'));
    }
  }

  // ------------------------------------------------------------- Notas del preparador

  /// Comparte las notas con el alumno (todas las páginas, y las que vengan) o
  /// deja de compartirlas, y lo anota en la clase.
  Future<void> _compartir(bool v) async {
    final pizarra = _pizarra;
    if (pizarra is! PizarraCompartida) return;
    setState(() => _compartida = v);
    try {
      await pizarra.ponerEnTodas({'visible': v});
      await widget.alCompartir?.call(v);
      if (mounted) setState(() => _avisar(v ? 'Compartidas: ${widget.otroNombre} las verá cuando acabe la clase' : 'Ya no se comparten'));
    } catch (_) {
      if (mounted) {
        setState(() {
          _compartida = !v;
          _avisar('No se ha podido cambiar. ¿Hay conexión?');
        });
      }
    }
  }

  // ------------------------------------------------------------- Barra

  void _elegir(HerramientaPizarra h) {
    if (_herramienta == h) {
      _abrirAjustes(h);
      return;
    }
    setState(() {
      _herramienta = h;
      if (h != HerramientaPizarra.borrador && h != HerramientaPizarra.lazo && h != HerramientaPizarra.texto) _ultimaTinta = h;
    });
    if (h != HerramientaPizarra.lazo) _quitarSeleccion();
    if (h == HerramientaPizarra.texto) setState(() => _avisar('Toca donde quieras escribir'));
  }

  void _elegirColor(int argb) {
    setState(() {
      if (!_esTinta && _herramienta != HerramientaPizarra.lazo && _herramienta != HerramientaPizarra.texto) _herramienta = _ultimaTinta;
      _color[_ultimaTinta] = argb;
    });
    if (_herramienta == HerramientaPizarra.lazo && _seleccion.isNotEmpty) _colorearSeleccion();
  }

  /// Ajustes de la herramienta (al tocarla otra vez): el grosor (o el tamaño
  /// de la letra) o, en el borrador, cómo borra.
  Future<void> _abrirAjustes(HerramientaPizarra h) async {
    if (h == HerramientaPizarra.lazo) return;
    final borrador = h == HerramientaPizarra.borrador;
    final texto = h == HerramientaPizarra.texto;
    final elegido = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      constraints: const BoxConstraints(maxWidth: 420),
      builder: (d) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (borrador) ...[
            _Opcion(elegida: !_borrarPorPartes, alTocar: () => Navigator.pop(d, 0), titulo: 'Borrar trazos enteros', subtitulo: 'Quita el trazo que tocas'),
            _Opcion(elegida: _borrarPorPartes, alTocar: () => Navigator.pop(d, 1), titulo: 'Borrar por partes', subtitulo: 'Como una goma: solo lo que tocas'),
          ] else if (texto)
            for (var i = 0; i < 3; i++)
              _Opcion(
                elegida: _grosor[h] == i,
                alTocar: () => Navigator.pop(d, i),
                titulo: ['Letra pequeña', 'Letra mediana', 'Letra grande'][i],
                secondary: Text('Aa', style: TextStyle(fontFamily: letraTexto, fontSize: 12 + 5.0 * i, color: _miColor)),
              )
          else
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

  /// Cualquier color: una paleta de colores con nombre a un toque y, debajo,
  /// el tono, la intensidad y la luz para afinarlo. Cabe en un móvil apaisado
  /// (el contenido se desplaza) y los deslizadores van compactos.
  Future<void> _otroColor() async {
    var hsv = HSVColor.fromColor(_miColor);
    final elegido = await showDialog<Color>(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (d, set) {
          final actual = hsv.toColor().toARGB32() | 0xFF000000;
          final enPaleta = coloresPaleta.indexOf(actual);
          Widget deslizador(String nombre, List<Color> degradado, double valor, double max, void Function(double) cambio) => Row(children: [
                SizedBox(width: 76, child: Text(nombre, style: const TextStyle(fontSize: 13))),
                Expanded(
                  child: Stack(alignment: Alignment.center, children: [
                    _BarraColor(colores: degradado),
                    SliderTheme(
                      data: SliderTheme.of(d).copyWith(trackHeight: 0, activeTrackColor: Colors.transparent, inactiveTrackColor: Colors.transparent, overlayShape: SliderComponentShape.noOverlay),
                      child: Slider(value: valor, min: 0, max: max, onChanged: (v) => set(() => cambio(v))),
                    ),
                  ]),
                ),
              ]);
          return AlertDialog(
            scrollable: true,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            title: const Text('Elige un color'),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                // La paleta: cada color con su nombre (sale al mantenerlo pulsado).
                Wrap(alignment: WrapAlignment.center, children: [
                  for (var i = 0; i < coloresPaleta.length; i++)
                    MuestraColor(color: Color(coloresPaleta[i]), nombre: nombresPaleta[i], elegido: actual == coloresPaleta[i], alTocar: () => set(() => hsv = HSVColor.fromColor(Color(coloresPaleta[i])))),
                ]),
                const SizedBox(height: 6),
                Row(children: [
                  Container(width: 44, height: 32, decoration: BoxDecoration(color: hsv.toColor(), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0x33000000)))),
                  const SizedBox(width: 10),
                  Expanded(child: Text(enPaleta < 0 ? 'Afínalo con los deslizadores' : nombresPaleta[enPaleta], style: const TextStyle(fontSize: 13))),
                ]),
                deslizador('Tono', [for (var h = 0; h <= 360; h += 30) HSVColor.fromAHSV(1, h.toDouble(), 1, 0.9).toColor()], hsv.hue, 360, (v) {
                  // Desde un gris o un negro, al mover el tono tiene que verse el color.
                  hsv = hsv.withHue(v).withSaturation(hsv.saturation < 0.15 ? 0.85 : hsv.saturation).withValue(hsv.value < 0.25 ? 0.85 : hsv.value);
                }),
                deslizador('Intensidad', [hsv.withSaturation(0).toColor(), hsv.withSaturation(1).toColor()], hsv.saturation, 1, (v) => hsv = hsv.withSaturation(v)),
                deslizador('Luz', [hsv.withValue(0).toColor(), hsv.withValue(1).toColor()], hsv.value, 1, (v) => hsv = hsv.withValue(v)),
              ]),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(d, hsv.toColor()), child: const Text('Usar este color')),
            ],
          );
        },
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
        case 'rotulador' || 'fosforito' || 'lazo' || 'texto':
          final h = HerramientaPizarra.values.byName(extra);
          if (puesto) {
            _herramienta = h;
            if (h != HerramientaPizarra.lazo && h != HerramientaPizarra.texto) _ultimaTinta = h;
            if (h == HerramientaPizarra.texto) _avisar('Toca donde quieras escribir');
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
          color: h == HerramientaPizarra.texto ? _miColor : (_color[h] == null ? tintaBarra : Color(_color[h]!)),
          grosor: _grosor[h] ?? 0,
          nombre: nombre,
          alTocar: _sinAcceso ? () {} : () => _elegir(h),
          alMantener: () => _abrirAjustes(h),
        );
    final navegacion = Row(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(width: 12),
      BotonBarra(icono: Icons.chevron_left, tooltip: 'Página anterior', alTocar: _pagina > 0 ? () => _irAPagina(_pagina - 1) : null),
      Text('${_pagina + 1}/$paginas', style: const TextStyle(color: tintaBarra)),
      BotonBarra(icono: Icons.chevron_right, tooltip: 'Página siguiente', alTocar: _pagina < _paginas.length - 1 ? () => _irAPagina(_pagina + 1) : null),
      if (widget.soloLectura) ...[
        BotonBarra(icono: Icons.picture_as_pdf_outlined, tooltip: 'Guardar como PDF', alTocar: _paginas.isEmpty ? null : _guardarPdf),
        if (_z > 1.01) BotonBarra(icono: Icons.fit_screen_outlined, tooltip: 'Ver la página entera', alTocar: _ajustarPagina),
      ] else ...[
        BotonBarra(icono: Icons.note_add_outlined, tooltip: 'Nueva página', alTocar: _sinAcceso || _paginas.length >= maxPaginas ? null : _nuevaPagina),
        _menu(),
      ],
    ]);
    if (widget.soloLectura) {
      // Solo mirar: sin paleta.
      return Container(
        color: fondoPizarra,
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            BotonBarra(icono: Icons.close, tooltip: 'Salir', alTocar: () => Navigator.of(context).pop()),
            Text('Notas de ${widget.otroNombre}', style: const TextStyle(color: tintaBarra, fontSize: 12), overflow: TextOverflow.ellipsis),
          ]),
          navegacion,
        ]),
      );
    }
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
              // Solo con ?depurar=1: el registro del lápiz, para mandarlo.
              if (_registro.activo)
                TextButton.icon(
                  onPressed: _copiarRegistro,
                  icon: const Icon(Icons.copy_outlined, size: 18),
                  label: Text('Copiar registro (${_registro.lineas})', style: const TextStyle(fontSize: 12)),
                ),
              if (widget.individual)
                const Text('Para practicar: no se guarda', style: TextStyle(color: Color(0x99000000), fontSize: 12))
              else if (widget.notas)
                // Las notas: solo las escribe el preparador; el chip las comparte.
                Tooltip(
                  message: 'El alumno las ve cuando las compartes y la clase ha terminado',
                  child: FilterChip(
                    label: Text(_compartida ? 'Compartidas con ${widget.otroNombre}' : 'Compartir con ${widget.otroNombre}', style: const TextStyle(fontSize: 12)),
                    avatar: Icon(_compartida ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 16),
                    selected: _compartida,
                    showCheckmark: false,
                    visualDensity: VisualDensity.compact,
                    onSelected: _sinAcceso ? null : _compartir,
                  ),
                )
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
              if (_extras.contains('texto')) punta(HerramientaPizarra.texto, 'Texto: toca donde quieras escribir con el teclado'),
              if (_extras.contains('regla')) BotonBarra(icono: Icons.straighten, tooltip: _regla == null ? 'Poner la regla' : 'Quitar la regla', activo: _regla != null, alTocar: () => setState(() => _regla = _regla == null ? Regla(centro: _virtual(Offset(_area.width / 2, _area.height / 2))) : null)),
              const SeparadorPaleta(),
              for (var i = 0; i < coloresRapidos.length; i++)
                MuestraColor(color: Color(coloresRapidos[i]), nombre: nombresColoresRapidos[i], elegido: _esTinta && colorElegido == coloresRapidos[i], alTocar: () => _elegirColor(coloresRapidos[i])),
              RuedaColor(elegido: _esTinta && !hayColorRapido, color: Color(colorElegido), alTocar: _otroColor),
              const SeparadorPaleta(),
              BotonBarra(icono: Icons.undo, tooltip: 'Deshacer (o dos toques con dos dedos)', alTocar: _puedeDeshacer && !_sinAcceso ? _deshacer : null),
              BotonBarra(icono: Icons.redo, tooltip: 'Rehacer', alTocar: _puedeRehacer && !_sinAcceso ? _rehacer : null),
            ]),
            navegacion,
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
          ('texto', 'Texto (escribir con el teclado)', Icons.keyboard_outlined),
          ('regla', 'Regla', Icons.straighten),
        ])
          CheckboxMenuButton(value: _extras.contains(extra), onChanged: (v) => _cambiarExtra(extra, v ?? false), trailingIcon: Icon(icono), child: Text(nombre)),
        const Divider(),
        if (!widget.individual) MenuItemButton(leadingIcon: const Icon(Icons.picture_as_pdf_outlined), onPressed: _paginas.isEmpty ? null : _guardarPdf, child: const Text('Guardar como PDF')),
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
        if (t.esTexto) {
          pintarTexto(canvas, t, colorDe(t));
        } else {
          canvas.drawPath(caminoDe(t), pintura..color = colorDe(t));
        }
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
      if (t.esTexto) {
        pintarTexto(canvas, t, colorDe(t));
      } else {
        canvas.drawPath(_PintorTrazos.caminoDe(t), Paint()..color = colorDe(t));
      }
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
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: colores), border: Border.all(color: const Color(0x22000000))),
      );
}
