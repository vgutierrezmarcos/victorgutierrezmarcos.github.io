import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import '../plan/cantes_util.dart';
import '../plan/resultado_sheet.dart';
import 'probabilidades.dart';
import 'reloj_cante.dart';
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

class _CantarPageState extends ConsumerState<CantarPage> {
  // Sorteo
  int _ejercicio = Oposiciones.actual.primerConTemas;
  _Modo _modo = _Modo.oficial;
  _Fuente _fuente = _Fuente.estudiados;
  List<String> _lista = const [];
  bool _ponderar = false;
  List<Tema> _sorteados = [];
  Tema? _elegido;

  // Cronómetro
  int _minEsquema = 0;
  int _minExposicion = 30;
  late RelojCante _reloj = RelojCante(exposicion: Duration(minutes: _minExposicion));
  Timer? _tic;
  int _hitosAvisados = 0;

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
    if (cante != null) _minExposicion = cante.minutos;
    _minEsquema = _esquemaPorDefecto(cante?.ejercicio ?? _ejercicio);
    _nuevoReloj();
  }

  // ------------------------------------------------------------ Esquema

  /// Clave de la última duración de esquema elegida en un ejercicio.
  String _claveEsquema(int ejercicio) => 'esquema:${Oposiciones.actual.id}:$ejercicio';

  /// La última que se usó en ese ejercicio o, si no, la del examen.
  int _esquemaPorDefecto(int ejercicio) {
    final guardado = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app).get(_claveEsquema(ejercicio)) : null;
    return guardado is int ? guardado : (Oposiciones.actual.ejercicio(ejercicio)?.minutosEsquema ?? 0);
  }

  void _elegirEsquema(int minutos, int ejercicio) {
    setState(() {
      _minEsquema = minutos;
      _nuevoReloj();
    });
    if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put(_claveEsquema(ejercicio), minutos);
  }

  /// +5 minutos a la fase en curso, o pasar ya a exponer: los avisos se rehacen.
  void _cambiarFase({bool saltar = false}) {
    final ahora = DateTime.now();
    setState(() => saltar ? _reloj.saltarFase(ahora) : _reloj.ampliarFase(ahora, const Duration(minutes: 5)));
    _hitosAvisados = _reloj.hitosPasados(ahora);
    if (_reloj.corriendo) Notificaciones.programarCronometro(_reloj.avisosPendientes(ahora)).catchError((_) {});
  }

  @override
  void dispose() {
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
    _reloj = RelojCante(preparacion: Duration(minutes: _minEsquema), exposicion: Duration(minutes: _minExposicion));
    _hitosAvisados = 0;
  }

  void _iniciar() {
    final ahora = DateTime.now();
    setState(() => _reloj.iniciar(ahora));
    _pantallaEncendida(true);
    // Los avisos se programan también como notificaciones por si la app pasa a segundo plano.
    Notificaciones.programarCronometro(_reloj.avisosPendientes(ahora)).catchError((_) {});
    _tic?.cancel();
    _tic = Timer.periodic(const Duration(milliseconds: 250), (_) => _alTic());
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
    if (_reloj.terminado(ahora)) {
      _parar(cancelarAvisos: false);
      return;
    }
    setState(() {});
  }

  void _parar({bool cancelarAvisos = true}) {
    _tic?.cancel();
    setState(() => _reloj.pausar(DateTime.now()));
    _pantallaEncendida(false);
    if (cancelarAvisos) Notificaciones.cancelarCronometro().catchError((_) {});
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
    final ctrl = TextEditingController(text: '${preparacion ? _minEsquema : _minExposicion}');
    final min = await showDialog<int>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(preparacion ? 'Minutos de esquema' : 'Minutos de exposición'),
        content: TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number, decoration: const InputDecoration(suffixText: 'min')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(c, int.tryParse(ctrl.text.trim())), child: const Text('Aceptar')),
        ],
      ),
    );
    if (min == null || min < 0 || min > 180 || (!preparacion && min == 0)) return;
    if (preparacion) {
      _elegirEsquema(min, _ejercicioDelCante());
      return;
    }
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
      final n = ref.read(ajustesProvider).temasExtraidos;
      if (_ponderar) {
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
    final base = cante ?? Cante(id: nuevoId(), fecha: DateTime.now(), titulo: 'Práctica', minutos: _minExposicion, ejercicio: _elegido?.ejercicio ?? _ejercicio, bolsa: TipoBolsa.lista);
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
    final config = ref.watch(configProvider).valueOrNull ?? AppConfig.porDefecto;
    final oposicion = ref.watch(oposicionProvider);
    final idCante = ref.watch(canteEnCursoProvider);
    final cante = sesion != null
        ? (ref.watch(sesionesProvider).where((c) => c.id == sesion.cante.id).firstOrNull ?? sesion.cante)
        : (idCante == null ? null : ref.watch(cantesProvider).where((c) => c.id == idCante && c.pendiente).firstOrNull);

    // Al llegar desde la agenda, el cronómetro toma la duración del cante.
    ref.listen(canteEnCursoProvider, (_, id) {
      final c = sesion != null ? null : ref.read(cantesProvider).where((x) => x.id == id).firstOrNull;
      if (c == null) return;
      setState(() {
        _sorteados = [];
        _elegido = null;
        _minExposicion = c.minutos;
        _minEsquema = _esquemaPorDefecto(c.ejercicio == 0 ? _ejercicio : c.ejercicio);
        _nuevoReloj();
      });
    });

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
          final restante = _reloj.restanteFase(ahora);
          final enPreparacion = _reloj.preparacion > Duration.zero && _reloj.enPreparacion(ahora);
          final terminado = _reloj.terminado(ahora);

          return ListaAdaptable(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
            children: [
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
                coyuntura ? (oposicion.ejercicio(ejercicioActual)?.etiquetaCante ?? 'Cante') : 'Sacar bola',
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
                            _minEsquema = _esquemaPorDefecto(_ejercicio);
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
              if (oficial) _resumenProbabilidad(context, config, bolas),
              if (!oficial && !coyuntura)
                Tarjeta(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (cante == null) ...[
                      Wrap(spacing: 6, children: [
                        for (final (f, texto) in [(_Fuente.estudiados, 'Estudiados'), (_Fuente.repaso, 'En repaso'), (_Fuente.lista, 'Lista propia')])
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
              if (!coyuntura)
              FilledButton.icon(
                onPressed: (oficial ? ref.watch(temasPorParteProvider).keys.any((p) => p.startsWith('$_ejercicio.')) : bolsa.isNotEmpty) ? () => _sortear(t, cante, config) : null,
                icon: const Icon(Icons.casino_outlined),
                label: Text(oficial ? 'Sacar $bolas ${bolas == 1 ? 'bola' : 'bolas'} de cada parte' : 'Sacar $k ${k == 1 ? 'bola' : 'bolas'}'),
              ),
              if (_sorteados.isNotEmpty) const SizedBox(height: 4),
              for (final x in _sorteados)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Tarjeta(
                    color: _elegido == x ? context.colores.primarioPalido : null,
                    onTap: () => setState(() => _elegido = x),
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
              const TituloSeccion('Cronómetro'),
              Tarjeta(
                child: Column(children: [
                  if (_elegido != null) Text('${_elegido!.codigo} · ${_elegido!.titulo}', textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  Text(terminado ? 'Tiempo cumplido' : (enPreparacion ? 'Esquema' : 'Exposición'), style: context.textos.labelMedium),
                  Text(
                    _formatoReloj(restante),
                    style: context.textos.displayMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: !enPreparacion && restante.inSeconds <= 60 && _reloj.empezado ? context.esquema.error : (enPreparacion ? context.colores.dorado : context.esquema.primary),
                    ),
                  ),
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: _reloj.progresoFase(ahora).clamp(0, 1), minHeight: 6, backgroundColor: context.colores.fondoClaro)),
                  const SizedBox(height: 10),
                  if (_reloj.empezado && !terminado)
                    Wrap(alignment: WrapAlignment.center, spacing: 8, children: [
                      ActionChip(avatar: const Icon(Icons.more_time, size: 18), label: const Text('+5 min'), onPressed: () => _cambiarFase()),
                      if (enPreparacion) ActionChip(avatar: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Pasar a exponer'), onPressed: () => _cambiarFase(saltar: true)),
                    ]),
                  _esquema(context, cante == null || cante.ejercicio == 0 ? _ejercicio : cante.ejercicio),
                  _duraciones(context, 'Exposición', [15, 20, 30], _minExposicion, preparacion: false),
                  const SizedBox(height: 12),
                  Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 8, children: [
                    OutlinedButton.icon(onPressed: _reiniciar, icon: const Icon(Icons.restart_alt), label: const Text('Reiniciar')),
                    FilledButton.icon(
                      onPressed: _reloj.corriendo ? _parar : (terminado ? null : _iniciar),
                      icon: Icon(_reloj.corriendo ? Icons.pause : Icons.play_arrow),
                      label: Text(_reloj.corriendo ? 'Pausar' : (_reloj.empezado ? 'Continuar' : 'Empezar')),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Text('Avisa al acabar el esquema, a mitad de la exposición, a 1 minuto del final y al terminar, también con la pantalla apagada.', textAlign: TextAlign.center, style: context.textos.labelSmall),
                  if (_reloj.empezado && !_reloj.corriendo && (_elegido != null || cante != null || coyuntura)) ...[
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
        subtitulo: 'Sacar bola y cronómetro',
        actions: [IconButton(tooltip: 'Cómo cantar un tema (PDF)', icon: const Icon(Icons.help_outline), onPressed: () => abrirUrl(context, ref.read(oposicionProvider).urlComoCantarUnTema))],
      ),
      body: cuerpo,
    );
  }

  /// Resumen de la probabilidad del ejercicio con los temas estudiados (sorteo oficial).
  Widget _resumenProbabilidad(BuildContext context, AppConfig config, int bolas) {
    final porParte = ref.watch(temasPorParteProvider);
    final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
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
    if (def == null || def.minutosEsquema == 0) return _duraciones(context, 'Esquema', [0, 5, 10, 15], _minEsquema, preparacion: true);
    final opciones = <(int, String)>[
      (0, 'Sin esquema'),
      for (var n = 1; n <= def.temasEsquema; n++) (def.minutosEsquemaPara(n), '$n ${n == 1 ? 'tema' : 'temas'} · ${def.minutosEsquemaPara(n)} min'),
    ];
    final propio = !opciones.any((o) => o.$1 == _minEsquema);
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(children: [
        Text('Esquema (en el examen, ${def.minutosEsquema} min para ${def.temasEsquema} temas)', textAlign: TextAlign.center, style: context.textos.labelMedium),
        Wrap(alignment: WrapAlignment.center, spacing: 4, children: [
          for (final (m, texto) in opciones)
            ChoiceChip(
              label: Text(texto),
              selected: _minEsquema == m,
              visualDensity: VisualDensity.compact,
              onSelected: _reloj.corriendo ? null : (_) => _elegirEsquema(m, ejercicio),
            ),
          if (propio) ChoiceChip(label: Text('$_minEsquema min'), selected: true, visualDensity: VisualDensity.compact, onSelected: null),
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
            for (final m in {...opciones, actual}.toList()..sort())
              ChoiceChip(
                label: Text(m == 0 ? 'No' : '$m'),
                selected: actual == m,
                visualDensity: VisualDensity.compact,
                onSelected: _reloj.corriendo
                    ? null
                    : (_) => setState(() {
                          preparacion ? _minEsquema = m : _minExposicion = m;
                          _nuevoReloj();
                        }),
              ),
            ActionChip(label: const Text('Otro'), visualDensity: VisualDensity.compact, onPressed: _reloj.corriendo ? null : () => _otraDuracion(preparacion: preparacion)),
          ]),
        ]),
      );

  String _formatoReloj(Duration d) {
    // Se redondea hacia arriba para que el reloj no marque 00:00 antes de tiempo.
    final s = (d.inMilliseconds / 1000).ceil();
    return '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
  }
}
