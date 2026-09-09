import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:vibration/vibration.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'sorteo.dart';

/// Cantar un tema: sorteo (con probabilidades), cronómetro de exposición y grabación.
class CantarPage extends ConsumerStatefulWidget {
  const CantarPage({super.key});
  @override
  ConsumerState<CantarPage> createState() => _CantarPageState();
}

class _CantarPageState extends ConsumerState<CantarPage> with WidgetsBindingObserver {
  int _ejercicio = 3;
  List<Tema> _sorteados = [];
  Tema? _elegido;

  // Cronómetro
  int _duracion = 10 * 60;
  int _restante = 10 * 60;
  Timer? _timer;
  bool _corriendo = false;
  final _avisados = <int>{};

  // Grabación
  final _grabadora = AudioRecorder();
  final _reproductor = AudioPlayer();
  bool _grabando = false;
  String? _ultimaGrabacion;
  bool _reproduciendo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _reproductor.onPlayerComplete.listen((_) => setState(() => _reproduciendo = false));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _grabadora.dispose();
    _reproductor.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------ Cronómetro

  void _iniciar() {
    _timer?.cancel();
    setState(() => _corriendo = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (_restante <= 0) {
        _parar();
        await _aviso('¡Tiempo! Se han cumplido los ${_duracion ~/ 60} minutos.', largo: true);
        return;
      }
      setState(() => _restante--);
      for (final hito in [_duracion ~/ 2, 60]) {
        if (_restante == hito && !_avisados.contains(hito)) {
          _avisados.add(hito);
          await _aviso(hito == 60 ? 'Queda 1 minuto.' : 'Mitad del tiempo (${hito ~/ 60} min).');
        }
      }
    });
  }

  void _parar() {
    _timer?.cancel();
    setState(() => _corriendo = false);
  }

  void _reiniciar() {
    _parar();
    setState(() {
      _restante = _duracion;
      _avisados.clear();
    });
  }

  Future<void> _aviso(String texto, {bool largo = false}) async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: largo ? [0, 400, 200, 400, 200, 600] : [0, 300]);
    }
    await Notificaciones.avisoCronometro(texto);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
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
    final dir = await getApplicationDocumentsDirectory();
    final nombre = '${_elegido?.codigo.replaceAll('.', '') ?? 'tema'}_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _grabadora.start(const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 64000), path: '${dir.path}/$nombre');
    setState(() => _grabando = true);
    if (!_corriendo) _iniciar();
  }

  Future<void> _reproducir() async {
    if (_ultimaGrabacion == null) return;
    if (_reproduciendo) {
      await _reproductor.stop();
      setState(() => _reproduciendo = false);
      return;
    }
    await _reproductor.play(DeviceFileSource(_ultimaGrabacion!));
    setState(() => _reproduciendo = true);
  }

  // ------------------------------------------------------------ UI

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider);
    final ajustes = ref.watch(ajustesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cantar un tema'),
        actions: [
          IconButton(tooltip: 'Cómo cantar un tema (PDF)', icon: const Icon(Icons.help_outline), onPressed: () => abrirUrl(context, Urls.comoCantarUnTema)),
        ],
      ),
      body: temario.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider)),
        data: (t) {
          final ej = t.ejercicios.firstWhere((e) => e.id == _ejercicio, orElse: () => t.ejercicios[2]);
          final bolsa = ej.temas;
          final estudiados = bolsa.where((x) => ajustes.temasEstudiados.contains(x.codigo)).length;
          final k = ajustes.temasExtraidos;
          final prob = Sorteo.probAlMenosUno(total: bolsa.length, estudiados: estudiados, extraidos: k);
          final para90 = Sorteo.minimosPara(total: bolsa.length, extraidos: k, objetivo: 0.9);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            children: [
              TituloSeccion('Sorteo', accion: SegmentedButton<int>(
                segments: const [ButtonSegment(value: 3, label: Text('3.º')), ButtonSegment(value: 4, label: Text('4.º'))],
                selected: {_ejercicio},
                onSelectionChanged: (s) => setState(() {
                  _ejercicio = s.first;
                  _sorteados = [];
                  _elegido = null;
                }),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              )),
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text('Llevas $estudiados de ${bolsa.length} temas', style: context.textos.titleMedium)),
                    Text('${(100 * prob).toStringAsFixed(1)} %', style: context.textos.headlineSmall?.copyWith(color: prob >= 0.9 ? Paleta.acierto : (prob >= 0.6 ? context.colores.dorado : Paleta.fallo))),
                  ]),
                  Text('Probabilidad de que salga al menos un tema estudiado sacando $k. Para llegar al 90 % necesitas $para90 temas.', style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  Row(children: [
                    Text('Temas extraídos:', style: context.textos.labelMedium),
                    Expanded(
                      child: Slider(value: k.toDouble(), min: 1, max: 6, divisions: 5, label: '$k', onChanged: (v) => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(temasExtraidos: v.round()))),
                    ),
                  ]),
                  const Divider(),
                  Text('Distribución de temas estudiados en el sorteo', style: context.textos.labelMedium),
                  const SizedBox(height: 6),
                  for (var i = 0; i <= k; i++)
                    Row(children: [
                      SizedBox(width: 24, child: Text('$i', style: context.textos.labelMedium)),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(value: Sorteo.probExacto(total: bolsa.length, estudiados: estudiados, extraidos: k, k: i), minHeight: 6, backgroundColor: context.colores.fondoClaro),
                        ),
                      ),
                      SizedBox(width: 52, child: Text('${(100 * Sorteo.probExacto(total: bolsa.length, estudiados: estudiados, extraidos: k, k: i)).toStringAsFixed(1)} %', textAlign: TextAlign.end, style: context.textos.labelSmall)),
                    ]),
                ]),
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: bolsa.isEmpty ? null : () => setState(() {
                  _sorteados = Sorteo.sortear(bolsa, k);
                  _elegido = null;
                }),
                icon: const Icon(Icons.casino_outlined),
                label: Text('Sortear $k temas'),
              ),
              for (final x in _sorteados)
                Tarjeta(
                  color: _elegido == x ? context.colores.primarioPalido : null,
                  onTap: () => setState(() => _elegido = x),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(children: [
                    Icon(ajustes.temasEstudiados.contains(x.codigo) ? Icons.check_circle : Icons.circle_outlined, color: ajustes.temasEstudiados.contains(x.codigo) ? Paleta.acierto : context.colores.textoClaro, size: 20),
                    const SizedBox(width: 10),
                    Expanded(child: Text('${x.codigo} · ${x.titulo}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                    if (_elegido == x) Icon(Icons.mic, color: context.esquema.primary, size: 18),
                  ]),
                ),
              if (_sorteados.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Toca el tema que vas a cantar.', style: context.textos.labelSmall)),
              const TituloSeccion('Cronómetro de exposición'),
              Tarjeta(
                child: Column(children: [
                  if (_elegido != null) Text('${_elegido!.codigo} · ${_elegido!.titulo}', textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  Text(_reloj(_restante), style: context.textos.displayMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()], color: _restante <= 60 && _corriendo ? context.esquema.error : context.esquema.primary)),
                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: 1 - _restante / _duracion, minHeight: 6, backgroundColor: context.colores.fondoClaro)),
                  const SizedBox(height: 10),
                  Wrap(spacing: 6, alignment: WrapAlignment.center, children: [
                    for (final m in [5, 10, 12, 15, 20])
                      ChoiceChip(label: Text('$m min'), selected: _duracion == m * 60, onSelected: _corriendo ? null : (_) => setState(() { _duracion = m * 60; _restante = _duracion; _avisados.clear(); })),
                  ]),
                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    OutlinedButton.icon(onPressed: _reiniciar, icon: const Icon(Icons.restart_alt), label: const Text('Reiniciar')),
                    const SizedBox(width: 10),
                    FilledButton.icon(
                      onPressed: _corriendo ? _parar : (_restante == 0 ? null : _iniciar),
                      icon: Icon(_corriendo ? Icons.pause : Icons.play_arrow),
                      label: Text(_corriendo ? 'Pausar' : (_restante < _duracion ? 'Continuar' : 'Empezar')),
                    ),
                  ]),
                  Text('Avisos con vibración a la mitad, a 1 minuto y al final.', style: context.textos.labelSmall),
                ]),
              ),
              const TituloSeccion('Grabación para autoescucha'),
              Tarjeta(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    FilledButton.icon(
                      style: _grabando ? FilledButton.styleFrom(backgroundColor: context.esquema.error) : null,
                      onPressed: _alternarGrabacion,
                      icon: Icon(_grabando ? Icons.stop : Icons.mic),
                      label: Text(_grabando ? 'Detener' : 'Grabar (y arrancar el cronómetro)'),
                    ),
                    if (_ultimaGrabacion != null && !_grabando) ...[
                      const SizedBox(width: 10),
                      OutlinedButton.icon(onPressed: _reproducir, icon: Icon(_reproduciendo ? Icons.stop : Icons.play_arrow), label: Text(_reproduciendo ? 'Parar' : 'Escuchar')),
                    ],
                  ]),
                  if (_ultimaGrabacion != null && !_grabando)
                    TextButton.icon(
                      onPressed: () async {
                        await _reproductor.stop();
                        try { File(_ultimaGrabacion!).deleteSync(); } catch (_) {}
                        setState(() { _ultimaGrabacion = null; _reproduciendo = false; });
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Borrar grabación'),
                    ),
                  Text('Las grabaciones se guardan solo en este dispositivo.', style: context.textos.labelSmall),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  String _reloj(int s) => '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
}
