import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:record/record.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../data/repos/usuario_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import '../cantes/nuevo_cante_sheet.dart';
import '../plan/cantes_util.dart';
import '../plan/resultado_sheet.dart';
import '../preparador/tema_anticipado.dart' show leerAntelacion, textoAntelacion;
import 'probabilidades.dart';
import 'reloj_cante.dart';
import 'reloj_compartido.dart';
import 'pizarra_page.dart';
import 'reloj_grande_page.dart';
import 'sorteo.dart';

enum _Modo { oficial, bolsa }

enum _Fuente { estudiados, repaso, lista }

/// Sesión de un preparador con uno de sus alumnos: el cante se sortea entre
/// los temas del alumno y se guarda en su ficha, no en el diario propio.
class SesionAlumno {
  const SesionAlumno({required this.cante, required this.alumno});
  final Cante cante;
  final Alumno alumno;
}

/// Cantar un tema: sorteo (oficial o de una bolsa propia), cronómetro de
/// preparación y exposición, grabación y registro en el diario de cantes.
///
/// Sin [sesion] es la subpestaña «Cantar» del bloque Cantes (sin cabecera
/// propia). Con [sesion] es una pantalla completa del preparador.
class CantarPage extends ConsumerStatefulWidget {
  const CantarPage({super.key, this.sesion});
  final SesionAlumno? sesion;
  @override
  ConsumerState<CantarPage> createState() => _CantarPageState();
}

class _CantarPageState extends ConsumerState<CantarPage> implements FuenteReloj {
  // Sorteo
  int _ejercicio = Oposiciones.actual.primerConTemas;
  _Modo _modo = _Modo.oficial;
  _Fuente _fuente = _Fuente.estudiados;
  List<String> _lista = const [];
  bool _ponderar = false;
  List<Tema> _sorteados = [];
  Tema? _elegido;

  // Cronómetro
  /// Esquema en segundos (22 min 30 s para un tema de TCEE); exposición en minutos.
  int _segEsquema = 0;
  int _minExposicion = 30;
  late RelojCante _reloj = RelojCante(exposicion: Duration(minutes: _minExposicion));
  /// Hacia delante desde 0 (por defecto) o cuenta atrás; se recuerda en cada dispositivo.
  ModoReloj _modoReloj = _modoGuardado();
  Timer? _tic;
  int _hitosAvisados = 0;

  // Cronómetro compartido con el preparador (o con el alumno).
  RelojCompartido? _compartido;
  String? _claveCompartido;
  StreamSubscription<EstadoRelojCompartido?>? _escucha;
  EstadoRelojCompartido? _remoto;
  bool _compartiendo = false;

  // Grabación (la grabadora y el reproductor se crean al usarlos por primera vez)
  AudioRecorder? _grabadoraPerezosa;
  AudioPlayer? _reproductorPerezoso;
  AudioRecorder get _grabadora => _grabadoraPerezosa ??= AudioRecorder();
  AudioPlayer get _reproductor => _reproductorPerezoso ??= AudioPlayer()
    ..onPlayerComplete.listen((_) {
      if (mounted) setState(() => _reproduciendo = false);
    });
  bool _grabando = false;
  String? _ultimaGrabacion;
  bool _reproduciendo = false;

  @override
  void initState() {
    super.initState();
    // Si se llega desde la agenda con un cante, el cronómetro toma su duración.
    final id = ref.read(canteEnCursoProvider);
    final cante = widget.sesion?.cante ?? ref.read(cantesProvider).where((c) => c.id == id).firstOrNull;
    if (cante != null) _minExposicion = cante.exposicion;
    // El preparador sin alumno no tiene temas estudiados propios: su bolsa es una lista.
    if (widget.sesion == null && ref.read(papelProvider) == Papel.preparador) _fuente = _Fuente.lista;
    _segEsquema = _esquemaPorDefecto(cante?.ejercicio ?? _ejercicio);
    _nuevoReloj();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tomarTemaMandado());
  }

  /// Si se llega con los temas que ha mandado el preparador (uno o dos,
  /// separados por comas), quedan como sorteados y el cronómetro con el
  /// esquema de esos temas (45 min para dos en TCEE, como en el examen).
  void _tomarTemaMandado() {
    final codigos = ref.read(temaParaCantarProvider);
    if (codigos == null) return;
    final temario = ref.read(temarioProvider).valueOrNull;
    final temas = [for (final c in codigos.split(',')) if (temario?.tema(c.trim()) != null) temario!.tema(c.trim())!];
    if (!mounted || temas.isEmpty) return;
    ref.read(temaParaCantarProvider.notifier).state = null;
    _ponerTemasMandados(temas);
  }

  void _ponerTemasMandados(List<Tema> temas) {
    final def = Oposiciones.actual.ejercicio(temas.first.ejercicio);
    setState(() {
      _sorteados = temas;
      _elegido = temas.length == 1 ? temas.first : null;
      if (!_reloj.empezado && def != null && def.minutosEsquema > 0) {
        _segEsquema = def.segundosEsquemaPara(temas.length);
        _nuevoReloj();
      }
    });
    _publicar();
  }

  // ------------------------------------------------------------ Esquema

  /// Clave de la última duración de esquema elegida en un ejercicio, en
  /// segundos (la de antes, `esquema:`, guardaba minutos enteros).
  String _claveEsquema(int ejercicio) => 'esquema_s:${Oposiciones.actual.id}:$ejercicio';

  /// La última que se usó en ese ejercicio o, si no, la del examen (segundos).
  int _esquemaPorDefecto(int ejercicio) {
    final caja = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;
    final guardado = caja?.get(_claveEsquema(ejercicio));
    if (guardado is int) return guardado;
    final antiguo = caja?.get('esquema:${Oposiciones.actual.id}:$ejercicio');
    if (antiguo is int) return antiguo * 60;
    return (Oposiciones.actual.ejercicio(ejercicio)?.minutosEsquema ?? 0) * 60;
  }

  void _elegirEsquema(int segundos, int ejercicio) {
    setState(() {
      _segEsquema = segundos;
      _nuevoReloj();
    });
    if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put(_claveEsquema(ejercicio), segundos);
  }

  static ModoReloj _modoGuardado() {
    final v = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app).get('reloj_modo') : null;
    return v == 'atras' ? ModoReloj.atras : ModoReloj.adelante;
  }

  void _alternarModo() {
    setState(() => _modoReloj = _modoReloj == ModoReloj.adelante ? ModoReloj.atras : ModoReloj.adelante);
    if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put('reloj_modo', _modoReloj.name);
  }

  /// Cambia el reloj en marcha (más o menos tiempo, pasar a exponer, empezar
  /// o reiniciar la exposición): los avisos se rehacen y se comparte.
  void _cambiarReloj(void Function(RelojCante r, DateTime ahora) cambio) {
    final ahora = DateTime.now();
    setState(() => cambio(_reloj, ahora));
    _hitosAvisados = _reloj.hitosPasados(ahora);
    if (_reloj.corriendo) {
      Notificaciones.programarCronometro(_reloj.avisosPendientes(ahora)).catchError((_) {});
      _pantallaEncendida(true);
      if (_tic == null || !_tic!.isActive) _tic = Timer.periodic(const Duration(milliseconds: 250), (_) => _alTic());
    } else {
      Notificaciones.cancelarCronometro().catchError((_) {});
    }
    _publicar();
  }

  void _cambiarFase({bool saltar = false, int minutos = 5}) =>
      _cambiarReloj((r, ahora) => saltar ? r.saltarFase(ahora) : r.ampliarFase(ahora, Duration(minutes: minutos)));

  void _empezarExposicion() => _cambiarReloj((r, ahora) => r.empezarExposicion(ahora));

  void _reiniciarExposicion() {
    _tic?.cancel();
    _pantallaEncendida(false);
    _cambiarReloj((r, _) => r.reiniciarExposicion());
  }

  // ------------------------------------------------------------ Reloj compartido

  /// Con quién se puede compartir el reloj de este cante: el alumno enlazado
  /// (para el preparador) o el preparador que lo ha programado (para el alumno).
  ({String alumnoUid, String canteId, String otro})? _destinoCompartido(Cante? cante) {
    if (!ref.read(serviciosProvider).firebaseDisponible || ref.read(usuarioActualProvider) == null || cante == null) return null;
    final sesion = widget.sesion;
    if (sesion != null) {
      final uid = sesion.alumno.uid;
      return uid == null ? null : (alumnoUid: uid, canteId: cante.id, otro: sesion.alumno.nombre);
    }
    if (!cante.dePreparador) return null;
    return (alumnoUid: ref.read(usuarioActualProvider)!.uid, canteId: cante.id, otro: cante.preparadorNombre ?? 'tu preparador');
  }

  /// Se escucha el reloj de la clase en curso (aunque no se comparta, para
  /// saber si el otro lo está usando).
  void _prepararCompartido(Cante? cante) {
    final d = _destinoCompartido(cante);
    final clave = d == null ? null : '${d.alumnoUid}/${d.canteId}';
    if (clave == _claveCompartido) return;
    _escucha?.cancel();
    if (_compartiendo) _compartido?.dejar();
    _claveCompartido = clave;
    _compartido = null;
    _remoto = null;
    _compartiendo = false;
    if (d == null) return;
    final yo = ref.read(usuarioActualProvider)!;
    final nombre = widget.sesion != null ? ref.read(perfilPreparadorProvider).nombre : (yo.displayName ?? 'Tu alumno');
    _compartido = RelojCompartido.deClase(FirebaseFirestore.instance, ref.read(oposicionProvider), alumnoUid: d.alumnoUid, canteId: d.canteId, miUid: yo.uid, miNombre: nombre.isEmpty ? 'Preparador' : nombre);
    _escucha = _compartido!.escuchar().listen(_alCambiarRemoto);
  }

  void _alCambiarRemoto(EstadoRelojCompartido? e) {
    if (!mounted) return;
    final mio = e?.por == _compartido?.miUid;
    setState(() => _remoto = e);
    if (e == null || !_compartiendo || mio) return;
    if (!e.activo) {
      setState(() => _compartiendo = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.porNombre} ha dejado de compartir el cronómetro')));
      return;
    }
    _adoptar(e);
  }

  /// Toma el reloj (y el sorteo) que ha dejado el otro.
  void _adoptar(EstadoRelojCompartido e) {
    final temario = ref.read(temarioProvider).valueOrNull;
    final ahora = DateTime.now();
    setState(() {
      _reloj = e.reloj;
      _segEsquema = e.reloj.preparacion.inSeconds;
      _minExposicion = (e.reloj.exposicion.inSeconds / 60).round();
      if (temario != null && e.temas.isNotEmpty) {
        _sorteados = [for (final c in e.temas) if (temario.tema(c) != null) temario.tema(c)!];
        _elegido = e.elegido == null ? null : temario.tema(e.elegido!);
      }
    });
    _hitosAvisados = _reloj.hitosPasados(ahora);
    _tic?.cancel();
    if (_reloj.corriendo) {
      _pantallaEncendida(true);
      Notificaciones.programarCronometro(_reloj.avisosPendientes(ahora)).catchError((_) {});
      _tic = Timer.periodic(const Duration(milliseconds: 250), (_) => _alTic());
    } else {
      _pantallaEncendida(false);
      Notificaciones.cancelarCronometro().catchError((_) {});
    }
  }

  Future<void> _alternarCompartir(bool si) async {
    final c = _compartido;
    if (c == null) return;
    if (!si) {
      setState(() => _compartiendo = false);
      await c.dejar();
      return;
    }
    await c.medirDesfase();
    if (!mounted) return;
    final r = _remoto;
    setState(() => _compartiendo = true);
    // Si el otro ya lo estaba usando, se toma su reloj; si no, se le pasa el nuestro.
    if (r != null && r.activo && r.por != c.miUid) {
      _adoptar(r);
    } else {
      _publicar();
    }
  }

  void _publicar() {
    if (!_compartiendo) return;
    _compartido?.publicar(_reloj, temas: [for (final t in _sorteados) t.codigo], elegido: _elegido?.codigo);
  }

  // FuenteReloj (pantalla grande)
  @override
  RelojCante get reloj => _reloj;
  @override
  String? get temaActual => _elegido == null ? null : '${_elegido!.codigo} · ${_elegido!.titulo}';
  @override
  String? get compartidoCon => _compartiendo ? (_destinoOtro ?? 'el otro') : null;
  String? _destinoOtro;
  @override
  ModoReloj get modo => _modoReloj;
  @override
  void alternar() => _reloj.esperandoExposicion(DateTime.now()) ? _empezarExposicion() : (_reloj.corriendo ? _parar() : _iniciar());
  @override
  void ajustarMinutos(int minutos) => _cambiarFase(minutos: minutos);
  @override
  void pasarAExponer() => _cambiarFase(saltar: true);
  @override
  void empezarExposicion() => _empezarExposicion();
  @override
  void reiniciarExposicion() => _reiniciarExposicion();
  @override
  void reiniciarTodo() => _reiniciar();
  @override
  void alternarModo() => _alternarModo();

  @override
  void dispose() {
    if (_compartiendo && !_reloj.corriendo) _compartido?.dejar();
    _escucha?.cancel();
    _tic?.cancel();
    _pantallaEncendida(false);
    _grabadoraPerezosa?.dispose();
    _reproductorPerezoso?.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------ Cronómetro

  void _pantallaEncendida(bool si) {
    // Sin plugin (tests, escritorio) no pasa nada.
    (si ? WakelockPlus.enable() : WakelockPlus.disable()).catchError((_) {});
  }

  void _nuevoReloj() {
    _tic?.cancel();
    _reloj = RelojCante(preparacion: Duration(seconds: _segEsquema), exposicion: Duration(minutes: _minExposicion));
    _hitosAvisados = 0;
    _publicar();
  }

  void _iniciar() {
    final ahora = DateTime.now();
    setState(() => _reloj.iniciar(ahora));
    _pantallaEncendida(true);
    // Los avisos se programan también como notificaciones por si la app pasa a segundo plano.
    Notificaciones.programarCronometro(_reloj.avisosPendientes(ahora)).catchError((_) {});
    _tic?.cancel();
    _tic = Timer.periodic(const Duration(milliseconds: 250), (_) => _alTic());
    _publicar();
  }

  void _alTic() {
    if (!mounted) return;
    final ahora = DateTime.now();
    final t = _reloj.transcurrido(ahora);
    final hitos = _reloj.hitos;
    while (_hitosAvisados < hitos.length && t >= hitos[_hitosAvisados].en) {
      _aviso(hitos[_hitosAvisados].texto, largo: hitos[_hitosAvisados].fin);
      _hitosAvisados++;
    }
    // Al cumplirse el tiempo no se para: sigue contando (en rojo) lo que se pasa.
    setState(() {});
  }

  void _parar({bool cancelarAvisos = true}) {
    _tic?.cancel();
    setState(() => _reloj.pausar(DateTime.now()));
    _pantallaEncendida(false);
    if (cancelarAvisos) Notificaciones.cancelarCronometro().catchError((_) {});
    _publicar();
  }

  void _reiniciar() {
    _parar();
    setState(_nuevoReloj);
  }

  Future<void> _aviso(String texto, {bool largo = false}) async {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
    try {
      if (await Vibration.hasVibrator()) Vibration.vibrate(pattern: largo ? [0, 400, 200, 400, 200, 600] : [0, 300]);
    } catch (_) {}
  }

  Future<void> _otraDuracion({required bool preparacion}) async {
    final actual = preparacion ? '${_segEsquema ~/ 60}${_segEsquema % 60 == 0 ? '' : ':${(_segEsquema % 60).toString().padLeft(2, '0')}'}' : '$_minExposicion';
    final ctrl = TextEditingController(text: actual);
    final texto = await showDialog<String>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(preparacion ? 'Tiempo de esquema' : 'Minutos de exposición'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: preparacion ? TextInputType.text : TextInputType.number,
          decoration: InputDecoration(suffixText: 'min', helperText: preparacion ? 'Minutos, o minutos:segundos (22:30)' : null),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(c, ctrl.text), child: const Text('Aceptar')),
        ],
      ),
    );
    if (texto == null) return;
    if (preparacion) {
      final seg = texto.trim() == '0' ? 0 : leerAntelacion(texto);
      if (seg == null || seg > 180 * 60) return;
      _elegirEsquema(seg, _ejercicioDelCante());
      return;
    }
    final min = int.tryParse(texto.trim());
    if (min == null || min <= 0 || min > 180) return;
    setState(() {
      _minExposicion = min;
      _nuevoReloj();
    });
  }

  int _ejercicioDelCante() {
    final id = ref.read(canteEnCursoProvider);
    final c = widget.sesion?.cante ?? ref.read(cantesProvider).where((x) => x.id == id).firstOrNull;
    final e = c?.ejercicio ?? 0;
    return e == 0 ? _ejercicio : e;
  }

  // ------------------------------------------------------------ Grabación

  Future<void> _alternarGrabacion() async {
    if (_grabando) {
      final ruta = await _grabadora.stop();
      setState(() {
        _grabando = false;
        _ultimaGrabacion = ruta;
      });
      return;
    }
    if (!await _grabadora.hasPermission()) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sin permiso de micrófono')));
      return;
    }
    final nombre = '${_elegido?.codigo.replaceAll('.', '') ?? 'tema'}_${DateTime.now().millisecondsSinceEpoch}.m4a';
    // En el navegador no todos admiten AAC: se usa el primer formato disponible.
    var formato = AudioEncoder.aacLc;
    if (kIsWeb) {
      for (final f in const [AudioEncoder.opus, AudioEncoder.aacLc, AudioEncoder.wav]) {
        if (await _grabadora.isEncoderSupported(f)) {
          formato = f;
          break;
        }
      }
    }
    await _grabadora.start(RecordConfig(encoder: formato, bitRate: 64000), path: await rutaNuevaGrabacion(nombre));
    setState(() => _grabando = true);
    if (!_reloj.corriendo) _iniciar();
  }

  Future<void> _reproducir() async {
    if (_ultimaGrabacion == null) return;
    if (_reproduciendo) {
      await _reproductor.stop();
      setState(() => _reproduciendo = false);
      return;
    }
    await _reproductor.play(kIsWeb ? UrlSource(_ultimaGrabacion!) : DeviceFileSource(_ultimaGrabacion!));
    setState(() => _reproduciendo = true);
  }

  // ------------------------------------------------------------ Sorteo y diario

  /// Temas de la bolsa propia según la fuente elegida (o el cante en curso).
  List<Tema> _bolsa(Temario t, Cante? cante) {
    final ajustes = _ajustesDeLaBolsa();
    if (cante != null) return temasDeCante(cante, t, ajustes);
    final delEjercicio = t.todosLosTemas.where((x) => x.ejercicio == _ejercicio);
    return switch (_fuente) {
      _Fuente.estudiados => delEjercicio.where((x) => ajustes.temasEstudiados.contains(x.codigo)).toList(),
      _Fuente.repaso => delEjercicio.where((x) => ajustes.temasEnRepaso.contains(x.codigo)).toList(),
      _Fuente.lista => [for (final c in _lista) if (t.tema(c) != null) t.tema(c)!],
    };
  }

  /// En una sesión de preparador, «los temas estudiados» son los del alumno.
  Ajustes _ajustesDeLaBolsa() {
    final propios = ref.read(ajustesProvider);
    final alumno = widget.sesion?.alumno;
    return alumno == null ? propios : Ajustes(temasEstudiados: alumno.temas.toSet(), temasExtraidos: propios.temasExtraidos);
  }

  void _sortear(Temario t, Cante? cante, AppConfig config) {
    final List<Tema> resultado;
    if (_modo == _Modo.oficial && cante == null) {
      final porParte = ref.read(temasPorParteProvider);
      final partes = {for (final e in porParte.entries) if (e.key.startsWith('$_ejercicio.')) e.key: e.value};
      resultado = Sorteo.sorteoOficial(partes, Oposiciones.actual.bolasPorParte(_ejercicio, config)).values.expand((x) => x).toList();
    } else {
      final bolsa = _bolsa(t, cante);
      // En una clase del preparador se sacan los temas que diga la clase.
      final n = widget.sesion != null && cante != null ? cante.numTemas : ref.read(ajustesProvider).temasExtraidos;
      if (widget.sesion != null && cante != null) {
        resultado = Sorteo.sortearClase(bolsa, n, unoPorParte: cante.unoPorParte, parte: (x) => x.codigo.split('.').take(2).join('.'));
      } else if (_ponderar) {
        final stats = ref.read(estadisticasCantesProvider);
        resultado = Sorteo.sortearPonderado(bolsa, n, (x) => Sorteo.pesoPractica(veces: stats[x.codigo]?.veces ?? 0, valoracionMedia: stats[x.codigo]?.valoracionMedia ?? 0));
      } else {
        resultado = Sorteo.sortear(bolsa, n);
      }
    }
    setState(() {
      _sorteados = resultado;
      _elegido = resultado.length == 1 ? resultado.first : null;
    });
    _publicar();
  }

  Future<void> _guardarEnDiario(Cante? cante, List<Tema> opciones) async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    final sesion = widget.sesion;
    final res = await pedirResultadoCante(
      context,
      titulo: sesion == null ? null : '¿Cómo ha ido el cante de ${sesion.alumno.nombre}?',
      textoGuardar: sesion == null ? null : 'Guardar valoración',
      inicial: ResultadoCante(
        sorteados: _sorteados.map((x) => x.codigo).toList(),
        temaCantado: _elegido?.codigo,
        segundos: _reloj.expuesto(DateTime.now()).inSeconds,
      ),
      opciones: opciones,
    );
    if (res == null) return;
    if (sesion != null) {
      // Sesión de preparador: se guarda en la ficha del alumno (y en su diario, si está enlazado).
      await ref.read(sesionesProvider.notifier).guardar((cante ?? sesion.cante).copyWith(estado: EstadoCante.hecho, resultado: res));
      messenger.showSnackBar(const SnackBar(content: Text('Valoración guardada')));
      nav.pop();
      return;
    }
    final base = cante ?? Cante(id: nuevoId(), fecha: DateTime.now(), titulo: 'Práctica', minutos: _minExposicion, exposicion: _minExposicion, ejercicio: _elegido?.ejercicio ?? _ejercicio, bolsa: TipoBolsa.lista);
    await ref.read(cantesProvider.notifier).guardar(base.copyWith(estado: EstadoCante.hecho, resultado: res));
    ref.read(canteEnCursoProvider.notifier).state = null;
    if (!mounted) return;
    setState(() {
      _sorteados = [];
      _elegido = null;
      _nuevoReloj();
    });
    messenger.showSnackBar(const SnackBar(content: Text('Cante guardado en el diario')));
  }

  // ------------------------------------------------------------ UI

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider);
    final sesion = widget.sesion;
    final ajustes = ref.watch(ajustesProvider);
    final estudiados = sesion == null ? ajustes.temasEstudiados : sesion.alumno.temas.toSet();
    // Preparador cantando sin alumno: sin probabilidad propia, sin «estudiados» ni diario.
    final soloPreparador = sesion == null && ref.watch(papelProvider) == Papel.preparador;
    final config = ref.watch(configProvider).valueOrNull ?? AppConfig.porDefecto;
    final oposicion = ref.watch(oposicionProvider);
    final idCante = ref.watch(canteEnCursoProvider);
    final cante = sesion != null
        ? (ref.watch(sesionesProvider).where((c) => c.id == sesion.cante.id).firstOrNull ?? sesion.cante)
        : (idCante == null ? null : ref.watch(cantesProvider).where((c) => c.id == idCante && c.pendiente).firstOrNull);

    // Reloj compartido de la clase en curso (si la hay y es con preparador).
    final destino = _destinoCompartido(cante);
    _destinoOtro = destino?.otro;
    if ((destino == null ? null : '${destino.alumnoUid}/${destino.canteId}') != _claveCompartido) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _prepararCompartido(cante));
      });
    }

    // El tema que ha mandado el preparador: elegido y el esquema listo.
    ref.listen(temaParaCantarProvider, (_, codigo) {
      if (codigo != null) WidgetsBinding.instance.addPostFrameCallback((_) => _tomarTemaMandado());
    });

    // Al llegar desde la agenda, el cronómetro toma la duración del cante.
    ref.listen(canteEnCursoProvider, (_, id) {
      final c = sesion != null ? null : ref.read(cantesProvider).where((x) => x.id == id).firstOrNull;
      if (c == null) return;
      setState(() {
        _sorteados = [];
        _elegido = null;
        _minExposicion = c.exposicion;
        _segEsquema = _esquemaPorDefecto(c.ejercicio == 0 ? _ejercicio : c.ejercicio);
        _nuevoReloj();
      });
    });

    // Clase del preparador (el alumno): los temas los manda él, no se sortean
    // aquí. Si ya han llegado, quedan puestos.
    final clasePreparador = sesion == null && cante != null && cante.dePreparador;
    if (clasePreparador && cante.temaA != null && !cante.temaA!.isAfter(DateTime.now())) {
      ref.listen(temaAnticipadoProvider(cante.id), (_, t) {
        final temario = ref.read(temarioProvider).valueOrNull;
        final temas = [for (final c in t.valueOrNull?.temas ?? const <String>[]) if (temario?.tema(c) != null) temario!.tema(c)!];
        if (temas.isNotEmpty && _sorteados.isEmpty) WidgetsBinding.instance.addPostFrameCallback((_) => _ponerTemasMandados(temas));
      });
    }

    final cuerpo = temario.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider)),
        data: (t) {
          // Dictamen (1.º de TCEE: coyuntura), sin sorteo de temas.
          final ejercicioActual = cante?.ejercicio ?? _ejercicio;
          final coyuntura = oposicion.esDictamen(ejercicioActual);
          final oficial = _modo == _Modo.oficial && cante == null && !coyuntura;
          final bolsa = oficial ? const <Tema>[] : _bolsa(t, cante);
          final k = ajustes.temasExtraidos;
          final bolas = oposicion.bolasPorParte(_ejercicio, config);
          final ahora = DateTime.now();
          final enPreparacion = _reloj.preparacion > Duration.zero && _reloj.enPreparacion(ahora);
          final esperando = _reloj.esperandoExposicion(ahora);
          final terminado = _reloj.terminado(ahora);
          final lectura = lecturaReloj(_reloj, ahora, _modoReloj);
          final ultimoMinuto = !enPreparacion && !esperando && _reloj.empezado && _reloj.restanteFase(ahora).inSeconds <= 60;

          return ListaAdaptable(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            children: [
              if (sesion == null && soloPreparador)
                TarjetaAyudaCantes(clave: 'cantar_preparador', icono: Icons.record_voice_over_outlined, titulo: ayudasCantes['cantar_preparador']!.$1, texto: ayudasCantes['cantar_preparador']!.$2)
              else if (sesion == null)
                TarjetaAyudaCantes(clave: 'cantar', icono: Icons.record_voice_over_outlined, titulo: ayudasCantes['cantar']!.$1, texto: ayudasCantes['cantar']!.$2),
              if (cante != null)
                Tarjeta(
                  color: context.colores.primarioPalido,
                  padding: const EdgeInsets.fromLTRB(14, 6, 4, 6),
                  child: Row(children: [
                    Icon(Icons.event_available, color: context.esquema.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${sesion?.alumno.nombre ?? tituloCante(cante)} · ${fechaCorta(cante.fecha)}, ${horaDe(cante.fecha)}', style: context.textos.titleSmall),
                        Text('${bolsa.length} temas en la bolsa. Al terminar se guarda en ${sesion == null ? 'el diario' : 'su ficha'}.', style: context.textos.labelSmall),
                      ]),
                    ),
                    if (sesion == null)
                      IconButton(tooltip: 'Salir del cante', icon: const Icon(Icons.close), onPressed: () => ref.read(canteEnCursoProvider.notifier).state = null)
                    else
                      const SizedBox(height: 40),
                  ]),
                ),
              TituloSeccion(
                coyuntura ? (oposicion.ejercicio(ejercicioActual)?.etiquetaCante ?? 'Cante') : (clasePreparador ? 'Temas de la clase' : 'Sacar bola'),
                accion: cante != null
                    ? null
                    : SegmentedButton<int>(showSelectedIcon: false, 
                        segments: segmentosEjercicio(),
                        selected: {_ejercicio},
                        onSelectionChanged: (s) => setState(() {
                          _ejercicio = s.first;
                          _sorteados = [];
                          _elegido = null;
                          if (!_reloj.empezado) {
                            _segEsquema = _esquemaPorDefecto(_ejercicio);
                            _nuevoReloj();
                          }
                        }),
                        style: const ButtonStyle(visualDensity: VisualDensity.compact),
                      ),
              ),
              if (coyuntura)
                Tarjeta(child: Text('${oposicion.avisoDictamen(ejercicioActual)} No hay sorteo de temas; prepáralo y cronométralo.', style: context.textos.bodySmall)),
              if (cante == null && !coyuntura)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SegmentedButton<_Modo>(showSelectedIcon: false, 
                    segments: const [ButtonSegment(value: _Modo.oficial, label: Text('Como en el examen')), ButtonSegment(value: _Modo.bolsa, label: Text('Mi bolsa'))],
                    selected: {_modo},
                    onSelectionChanged: (s) => setState(() {
                      _modo = s.first;
                      _sorteados = [];
                      _elegido = null;
                    }),
                    style: const ButtonStyle(visualDensity: VisualDensity.compact),
                  ),
                ),
              if (oficial && !soloPreparador) _resumenProbabilidad(context, config, bolas),
              if (clasePreparador && !coyuntura)
                Tarjeta(
                  child: Text(
                    cante.temaA == null
                        ? 'Los temas los saca o elige ${cante.preparadorNombre ?? 'tu preparador'} en la clase: aquí tienes el cronómetro (y el reloj compartido, si lo activáis).'
                        : (cante.temaA!.isAfter(ahora)
                            ? '${cante.preparadorNombre ?? 'Tu preparador'} te manda los temas ${DateFormat("EEEE d 'a las' HH:mm", 'es').format(cante.temaA!)}. Entonces aparecerán aquí, con el esquema listo.'
                            : (_sorteados.isEmpty ? 'Cargando los temas que te ha mandado…' : 'Los temas que te ha mandado ${cante.preparadorNombre ?? 'tu preparador'}. Toca el que vayas a exponer.')),
                    style: context.textos.bodySmall,
                  ),
                ),
              if (!oficial && !coyuntura && !clasePreparador)
                Tarjeta(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (cante == null) ...[
                      Wrap(spacing: 6, children: [
                        for (final (f, texto) in [if (!soloPreparador) ...[(_Fuente.estudiados, 'Estudiados'), (_Fuente.repaso, 'En repaso')], (_Fuente.lista, 'Lista propia')])
                          ChoiceChip(label: Text(texto), selected: _fuente == f, onSelected: (_) => setState(() => _fuente = f)),
                      ]),
                      if (_fuente == _Fuente.lista)
                        TextButton.icon(
                          onPressed: () async {
                            final r = await elegirTemas(context, temario: t, seleccion: _lista, titulo: 'Temas del sorteo');
                            if (r != null) setState(() => _lista = r);
                          },
                          icon: const Icon(Icons.checklist, size: 18),
                          label: Text(_lista.isEmpty ? 'Elegir temas' : 'Cambiar temas'),
                        ),
                    ],
                    Text(bolsa.isEmpty ? 'La bolsa está vacía.' : '${bolsa.length} temas en la bolsa.', style: context.textos.bodySmall),
                    Row(children: [
                      Text('Temas a sacar:', style: context.textos.labelMedium),
                      Expanded(
                        child: Slider(value: k.toDouble(), min: 1, max: 6, divisions: 5, label: '$k', onChanged: (v) => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(temasExtraidos: v.round()))),
                      ),
                      Text('$k', style: context.textos.titleSmall),
                    ]),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('Dar prioridad a los temas flojos'),
                      subtitle: Text('Salen más los menos cantados y los peor valorados en el diario', style: context.textos.labelSmall),
                      value: _ponderar,
                      onChanged: (v) => setState(() => _ponderar = v),
                    ),
                  ]),
                ),
              const SizedBox(height: 10),
              if (!coyuntura && !clasePreparador)
              FilledButton.icon(
                onPressed: (oficial ? ref.watch(temasPorParteProvider).keys.any((p) => p.startsWith('$_ejercicio.')) : bolsa.isNotEmpty) ? () => _sortear(t, cante, config) : null,
                icon: const Icon(Icons.casino_outlined),
                label: Text(oficial
                    ? 'Sacar $bolas ${bolas == 1 ? 'bola' : 'bolas'} de cada parte'
                    : (sesion != null && cante != null ? 'Sacar ${cante.numTemas} ${cante.numTemas == 1 ? 'bola' : 'bolas'}${cante.unoPorParte && cante.numTemas > 1 ? ' (una de cada parte)' : ''}' : 'Sacar $k ${k == 1 ? 'bola' : 'bolas'}')),
              ),
              if (_sorteados.isNotEmpty) const SizedBox(height: 4),
              for (final x in _sorteados)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Tarjeta(
                    color: _elegido == x ? context.colores.primarioPalido : null,
                    onTap: () {
                      setState(() => _elegido = x);
                      _publicar();
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(children: [
                      Icon(estudiados.contains(x.codigo) ? Icons.check_circle : Icons.circle_outlined, color: estudiados.contains(x.codigo) ? Paleta.acierto : context.colores.textoClaro, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: TextoTema(x.codigo, x.titulo, color: ref.watch(estructuraProvider).valueOrNull?.colorDe(x.codigo))),
                      if (_elegido == x) Icon(Icons.mic, color: context.esquema.primary, size: 18),
                    ]),
                  ),
                ),
              if (_sorteados.length > 1) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Toca el tema que vas a cantar.', style: context.textos.labelSmall)),
              TituloSeccion(
                'Cronómetro',
                accion: Wrap(spacing: 2, children: [
                  if (destino != null)
                    TextButton.icon(
                      onPressed: () => abrirPizarra(context, alumnoUid: destino.alumnoUid, canteId: destino.canteId, otroNombre: destino.otro),
                      icon: const Icon(Icons.draw_outlined, size: 20),
                      label: const Text('Pizarra'),
                    ),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => RelojGrandePage(fuente: this))),
                    icon: const Icon(Icons.fullscreen, size: 20),
                    label: const Text('Pantalla grande'),
                  ),
                ]),
              ),
              if (_compartido != null && !_compartiendo && _remoto != null && _remoto!.activo && _remoto!.por != _compartido!.miUid)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                    color: context.colores.primarioPalido,
                    padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
                    child: Row(children: [
                      Icon(Icons.sync, color: context.esquema.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text('${_remoto!.porNombre} está usando el cronómetro compartido', style: context.textos.bodySmall)),
                      FilledButton(onPressed: () => _alternarCompartir(true), child: const Text('Unirme')),
                    ]),
                  ),
                ),
              Tarjeta(
                child: Column(children: [
                  if (_compartido != null)
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      secondary: Icon(Icons.sync, color: _compartiendo ? context.esquema.primary : context.colores.textoClaro),
                      title: Text('Compartir con ${destino?.otro ?? ''}'),
                      subtitle: Text('Los dos veis el mismo tiempo, juntos o a distancia, y cualquiera lo maneja', style: context.textos.labelSmall),
                      value: _compartiendo,
                      onChanged: _alternarCompartir,
                    ),
                  if (_elegido != null) Text('${_elegido!.codigo} · ${_elegido!.titulo}', textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  SegmentedButton<ModoReloj>(
                    showSelectedIcon: false,
                    style: const ButtonStyle(visualDensity: VisualDensity.compact),
                    segments: const [
                      ButtonSegment(value: ModoReloj.adelante, icon: Icon(Icons.timer_outlined, size: 18), label: Text('Cronómetro')),
                      ButtonSegment(value: ModoReloj.atras, icon: Icon(Icons.hourglass_bottom, size: 18), label: Text('Cuenta atrás')),
                    ],
                    selected: {_modoReloj},
                    onSelectionChanged: (_) => _alternarModo(),
                  ),
                  const SizedBox(height: 8),
                  Text(terminado ? 'Tiempo cumplido' : (esperando ? 'Esquema terminado' : (enPreparacion ? 'Esquema' : 'Exposición')), style: context.textos.labelMedium),
                  Text(
                    lectura.texto,
                    style: context.textos.displayMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: lectura.pasado || ultimoMinuto ? context.esquema.error : (enPreparacion || esperando ? context.colores.dorado : context.esquema.primary),
                    ),
                  ),
                  if (lectura.demas != null) Text('${lectura.demas} de más', style: context.textos.titleSmall?.copyWith(color: context.esquema.error, fontFeatures: const [FontFeature.tabularFigures()])),
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: _reloj.progresoFase(ahora).clamp(0, 1), minHeight: 6, backgroundColor: context.colores.fondoClaro)),
                  const SizedBox(height: 10),
                  if (esperando)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: FilledButton.icon(
                        onPressed: _empezarExposicion,
                        icon: const Icon(Icons.record_voice_over_outlined),
                        label: const Text('Empezar la exposición'),
                        style: FilledButton.styleFrom(minimumSize: const Size(240, 52)),
                      ),
                    ),
                  if (_reloj.empezado)
                    Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 4, children: [
                      ActionChip(label: const Text('−1 min'), onPressed: () => _cambiarFase(minutos: -1)),
                      ActionChip(label: const Text('+1 min'), onPressed: () => _cambiarFase(minutos: 1)),
                      ActionChip(avatar: const Icon(Icons.more_time, size: 18), label: const Text('+5 min'), onPressed: () => _cambiarFase()),
                      if (enPreparacion) ActionChip(avatar: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Pasar a exponer'), onPressed: () => _cambiarFase(saltar: true)),
                      if (!enPreparacion && !esperando && _reloj.preparacion > Duration.zero)
                        ActionChip(avatar: const Icon(Icons.replay, size: 18), label: const Text('Reiniciar la exposición'), onPressed: _reiniciarExposicion),
                    ]),
                  _esquema(context, cante == null || cante.ejercicio == 0 ? _ejercicio : cante.ejercicio),
                  _duraciones(context, 'Exposición', [15, 20, 30], _minExposicion, preparacion: false),
                  const SizedBox(height: 12),
                  Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 8, children: [
                    OutlinedButton.icon(onPressed: _reiniciar, icon: const Icon(Icons.restart_alt), label: const Text('Reiniciar todo')),
                    if (!esperando)
                      FilledButton.icon(
                        onPressed: _reloj.corriendo ? _parar : _iniciar,
                        icon: Icon(_reloj.corriendo ? Icons.pause : Icons.play_arrow),
                        label: Text(_reloj.corriendo ? 'Pausar' : (_reloj.empezado ? 'Continuar' : 'Empezar')),
                      ),
                  ]),
                  const SizedBox(height: 6),
                  Text('Avisa al acabar el esquema (la exposición espera a que la empieces), a mitad de la exposición, a 1 minuto del final y al cumplirse, también con la pantalla apagada. Si te pasas, sigue contando.', textAlign: TextAlign.center, style: context.textos.labelSmall),
                  if (!soloPreparador && _reloj.empezado && !_reloj.corriendo && (_elegido != null || cante != null || coyuntura)) ...[
                    const Divider(),
                    FilledButton.tonalIcon(
                      onPressed: () => _guardarEnDiario(cante, _sorteados.isNotEmpty ? _sorteados : (cante != null ? bolsa : [if (_elegido != null) _elegido!])),
                      icon: const Icon(Icons.menu_book_outlined),
                      label: Text(sesion == null ? 'Guardar en el diario de cantes' : 'Valorar y guardar'),
                    ),
                  ],
                ]),
              ),
              if (sesion == null) const TituloSeccion('Grabación para autoescucha'),
              if (sesion == null) Tarjeta(
                child: Column(children: [
                  Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 8, children: [
                    FilledButton.icon(
                      style: _grabando ? FilledButton.styleFrom(backgroundColor: context.esquema.error) : null,
                      onPressed: _alternarGrabacion,
                      icon: Icon(_grabando ? Icons.stop : Icons.mic),
                      label: Text(_grabando ? 'Detener' : 'Grabar (y arrancar el cronómetro)'),
                    ),
                    if (_ultimaGrabacion != null && !_grabando)
                      OutlinedButton.icon(onPressed: _reproducir, icon: Icon(_reproduciendo ? Icons.stop : Icons.play_arrow), label: Text(_reproduciendo ? 'Parar' : 'Escuchar')),
                  ]),
                  if (_ultimaGrabacion != null && !_grabando)
                    TextButton.icon(
                      onPressed: () async {
                        await _reproductor.stop();
                        borrarGrabacion(_ultimaGrabacion!);
                        setState(() { _ultimaGrabacion = null; _reproduciendo = false; });
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Borrar grabación'),
                    ),
                  Text(kIsWeb ? 'La grabación no sale de este navegador y se pierde al cerrar la pestaña.' : 'Las grabaciones se guardan solo en este dispositivo y no se envían a ningún sitio.', style: context.textos.labelSmall),
                ]),
              ),
            ],
          );
        },
    );
    // Dentro del bloque Cantes la cabecera la pone CantesPage.
    if (sesion == null) return cuerpo;
    return Scaffold(
      appBar: BarraWeb(
        title: Text(sesion.alumno.nombre),
        subtitulo: 'Sortear y cronómetro',
        actions: [IconButton(tooltip: 'Cómo cantar un tema (PDF)', icon: const Icon(Icons.help_outline), onPressed: () => abrirUrl(context, ref.read(oposicionProvider).urlComoCantarUnTema))],
      ),
      body: cuerpo,
    );
  }

  /// Resumen de la probabilidad del ejercicio con los temas estudiados (sorteo oficial).
  Widget _resumenProbabilidad(BuildContext context, AppConfig config, int bolas) {
    final porParte = ref.watch(temasPorParteProvider);
    // Con un alumno, los temas que lleva él (no los del preparador).
    final propios = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
    final estudiados = widget.sesion?.alumno.temas.toSet() ?? propios;
    final oposicion = ref.watch(oposicionProvider);
    final partes = partesDeEjercicio(_ejercicio, porParte: porParte, estudiados: estudiados, config: config, oposicion: oposicion);
    if (partes.isEmpty) return const SizedBox.shrink();
    final elegir = oposicion.partesARedactar(_ejercicio, config);
    final p = Sorteo.probEjercicio(partes, elegir: elegir);
    final letras = [for (final k in porParte.keys.where((k) => k.startsWith('$_ejercicio.')).toList()..sort()) k.split('.').last];
    return Tarjeta(
      onTap: () => context.go('/organizacion/probabilidades'),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text([for (var i = 0; i < partes.length; i++) '${letras[i]}: ${partes[i].sabidos} de ${partes[i].total}'].join(' · '), style: context.textos.titleMedium)),
          Text(porcentaje(p), style: context.textos.headlineSmall?.copyWith(color: p >= 0.9 ? Paleta.acierto : (p >= 0.6 ? context.colores.dorado : Paleta.fallo))),
        ]),
        Text(
          elegir == null
              ? 'Probabilidad de saberte al menos un tema de cada parte, sacando $bolas de cada una. Toca para ver el detalle.'
              : 'Probabilidad de saberte $elegir de los ${partes.length} temas que salen (uno por parte). Toca para ver el detalle.',
          style: context.textos.bodySmall,
        ),
      ]),
    );
  }

  /// Tiempo de esquema: el del examen para todos sus temas o para uno, sin
  /// esquema u otro a medida.
  Widget _esquema(BuildContext context, int ejercicio) {
    final def = Oposiciones.actual.ejercicio(ejercicio);
    if (def == null || def.minutosEsquema == 0) {
      return _duraciones(context, 'Esquema', [0, 5, 10, 15], _segEsquema % 60 == 0 ? _segEsquema ~/ 60 : -1, preparacion: true);
    }
    final opciones = <(int, String)>[
      (0, 'Sin esquema'),
      for (var n = 1; n <= def.temasEsquema; n++) (def.segundosEsquemaPara(n), '$n ${n == 1 ? 'tema' : 'temas'} · ${textoAntelacion(def.segundosEsquemaPara(n))}'),
    ];
    final propio = !opciones.any((o) => o.$1 == _segEsquema);
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(children: [
        Text('Esquema (en el examen, ${def.minutosEsquema} min para ${def.temasEsquema} temas)', textAlign: TextAlign.center, style: context.textos.labelMedium),
        Wrap(alignment: WrapAlignment.center, spacing: 4, children: [
          for (final (m, texto) in opciones)
            ChoiceChip(
              label: Text(texto),
              selected: _segEsquema == m,
              visualDensity: VisualDensity.compact,
              onSelected: _reloj.corriendo ? null : (_) => _elegirEsquema(m, ejercicio),
            ),
          if (propio) ChoiceChip(label: Text(textoAntelacion(_segEsquema)), selected: true, visualDensity: VisualDensity.compact, onSelected: null),
          ActionChip(label: const Text('Otro'), visualDensity: VisualDensity.compact, onPressed: _reloj.corriendo ? null : () => _otraDuracion(preparacion: true)),
        ]),
      ]),
    );
  }

  Widget _duraciones(BuildContext context, String etiqueta, List<int> opciones, int actual, {required bool preparacion}) => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Column(children: [
          Text('$etiqueta (min)', style: context.textos.labelMedium),
          Wrap(alignment: WrapAlignment.center, spacing: 4, children: [
            for (final m in {...opciones, if (actual >= 0) actual}.toList()..sort())
              ChoiceChip(
                label: Text(m == 0 ? 'No' : '$m'),
                selected: actual == m,
                visualDensity: VisualDensity.compact,
                onSelected: _reloj.corriendo
                    ? null
                    : (_) => setState(() {
                          preparacion ? _segEsquema = m * 60 : _minExposicion = m;
                          _nuevoReloj();
                        }),
              ),
            ActionChip(label: const Text('Otro'), visualDensity: VisualDensity.compact, onPressed: _reloj.corriendo ? null : () => _otraDuracion(preparacion: preparacion)),
          ]),
        ]),
      );
}
