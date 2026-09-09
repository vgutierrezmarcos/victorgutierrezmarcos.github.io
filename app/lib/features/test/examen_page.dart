import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/pregunta.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'motor_test.dart';
import 'resultados_page.dart';

/// Fase de examen: una pregunta por pantalla, rejilla de navegación y temporizador.
class ExamenPage extends ConsumerStatefulWidget {
  const ExamenPage({super.key, required this.config});
  final ConfigTest config;
  @override
  ConsumerState<ExamenPage> createState() => _ExamenPageState();
}

class _ExamenPageState extends ConsumerState<ExamenPage> {
  List<Pregunta>? _preguntas;
  final _respuestas = <int, String?>{};
  final _marcadas = <int>{};
  int _idx = 0;
  int _segundos = 0;
  Timer? _timer;
  final _inicio = DateTime.now();

  int get _limite => widget.config.minutos * 60;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _segundos = DateTime.now().difference(_inicio).inSeconds);
      if (_limite > 0 && _segundos >= _limite) _finalizar(porTiempo: true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _finalizar({bool porTiempo = false}) async {
    _timer?.cancel();
    final preguntas = _preguntas!;
    final resultado = MotorTest.corregir(
      preguntas: preguntas,
      respuestas: _respuestas,
      config: widget.config,
      tiempoSeconds: _segundos,
    );
    final repo = ref.read(usuarioRepoProvider);
    await repo.guardarResultado(resultado);
    await ref.read(leitnerProvider.notifier).registrarExamen({
      for (final p in preguntas) p.id: _respuestas[p.id] != null && p.esCorrecta(_respuestas[p.id]),
    });
    await ref.read(ajustesProvider.notifier).registrarActividad();
    ref.invalidate(historialProvider);
    if (!mounted) return;
    context.pushReplacement('/resultados',
        extra: DatosResultado(resultado: resultado, preguntas: preguntas, respuestas: Map.of(_respuestas), porTiempo: porTiempo));
  }

  Future<bool> _confirmarSalida() async {
    final r = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('¿Abandonar el test?'),
        content: const Text('Se perderán las respuestas de este test.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Seguir')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Abandonar')),
        ],
      ),
    );
    return r ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final banco = ref.watch(preguntasProvider);
    return banco.when(
      loading: () => const Scaffold(body: Cargando()),
      error: (e, _) => Scaffold(appBar: AppBar(), body: ErrorVista(error: e)),
      data: (b) {
        _preguntas ??= MotorTest.componer(b, widget.config);
        final preguntas = _preguntas!;
        if (preguntas.isEmpty) {
          return Scaffold(appBar: AppBar(), body: const Center(child: Text('No hay preguntas para este test.')));
        }
        final p = preguntas[_idx];
        final restante = _limite > 0 ? _limite - _segundos : _segundos;
        final apurado = _limite > 0 && restante < 300;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (await _confirmarSalida() && context.mounted) context.pop();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('${_idx + 1} / ${preguntas.length}'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Text(
                      formatoReloj(restante),
                      style: context.textos.titleMedium?.copyWith(
                        fontFeatures: const [FontFeature.tabularFigures()],
                        color: apurado ? context.esquema.error : null,
                      ),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.grid_view), tooltip: 'Navegador', onPressed: _mostrarRejilla),
              ],
            ),
            body: Column(children: [
              LinearProgressIndicator(value: (_idx + 1) / preguntas.length, minHeight: 3),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(children: [
                      Etiqueta(p.tema),
                      const SizedBox(width: 6),
                      Expanded(child: Text(p.examen, style: context.textos.labelSmall, overflow: TextOverflow.ellipsis)),
                      if (p.anulada) const Etiqueta('ANULADA', color: Colors.orange),
                      IconButton(
                        icon: Icon(_marcadas.contains(p.id) ? Icons.flag : Icons.outlined_flag),
                        color: _marcadas.contains(p.id) ? context.colores.dorado : null,
                        tooltip: 'Marcar para revisar',
                        onPressed: () => setState(() => _marcadas.contains(p.id) ? _marcadas.remove(p.id) : _marcadas.add(p.id)),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    Text(p.enunciado, style: context.textos.bodyLarge?.copyWith(fontSize: 17)),
                    for (final img in p.imagenes)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => Dialog(child: InteractiveViewer(child: Image.network('${Urls.imagenesTest}/${img.src.split('/').last}'))),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network('${Urls.imagenesTest}/${img.src.split('/').last}', semanticLabel: img.alt),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    for (final e in p.opciones.entries) _opcion(p, e.key, e.value),
                    if (_respuestas[p.id] != null)
                      TextButton.icon(
                        onPressed: () => setState(() => _respuestas[p.id] = null),
                        icon: const Icon(Icons.backspace_outlined, size: 18),
                        label: const Text('Dejar en blanco'),
                      ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(children: [
                    OutlinedButton(onPressed: _idx == 0 ? null : () => setState(() => _idx--), child: const Icon(Icons.chevron_left)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _idx < preguntas.length - 1
                          ? FilledButton(onPressed: () => setState(() => _idx++), child: const Text('Siguiente'))
                          : FilledButton.icon(onPressed: _confirmarFin, icon: const Icon(Icons.check), label: const Text('Finalizar')),
                    ),
                    const SizedBox(width: 8),
                    TextButton(onPressed: _confirmarFin, child: const Text('Terminar')),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget _opcion(Pregunta p, String letra, String texto) {
    final sel = _respuestas[p.id] == letra;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: sel ? context.colores.primarioPalido : context.colores.superficie,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() => _respuestas[p.id] = letra),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: sel ? context.esquema.primary : context.colores.borde, width: sel ? 2 : 1),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: sel ? context.esquema.primary : context.colores.fondoClaro,
                child: Text(letra, style: context.textos.labelLarge?.copyWith(color: sel ? Colors.white : context.esquema.primary)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(texto, style: context.textos.bodyMedium)),
            ]),
          ),
        ),
      ),
    );
  }

  void _mostrarRejilla() {
    final preguntas = _preguntas!;
    showModalBottomSheet(
      context: context,
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('${_respuestas.values.where((v) => v != null).length} respondidas · ${_marcadas.length} marcadas', style: context.textos.bodySmall),
            const SizedBox(height: 12),
            Flexible(
              child: GridView.count(
                crossAxisCount: 8,
                shrinkWrap: true,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  for (var i = 0; i < preguntas.length; i++)
                    InkWell(
                      onTap: () {
                        setState(() => _idx = i);
                        Navigator.pop(c);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: _respuestas[preguntas[i].id] != null ? context.esquema.primary : context.colores.fondoClaro,
                          border: Border.all(color: i == _idx ? context.colores.dorado : (_marcadas.contains(preguntas[i].id) ? context.colores.dorado : context.colores.borde), width: i == _idx ? 2 : 1),
                        ),
                        child: Text('${i + 1}', style: TextStyle(color: _respuestas[preguntas[i].id] != null ? Colors.white : context.esquema.onSurface, fontSize: 12)),
                      ),
                    ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _confirmarFin() async {
    final blanco = _preguntas!.where((p) => _respuestas[p.id] == null).length;
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('¿Finalizar el test?'),
        content: Text(blanco == 0 ? 'Has respondido todas las preguntas.' : 'Quedan $blanco preguntas en blanco.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Volver')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Finalizar')),
        ],
      ),
    );
    if (ok == true) _finalizar();
  }
}

String formatoReloj(int s) {
  final h = s ~/ 3600, m = (s % 3600) ~/ 60, seg = s % 60;
  String dos(int n) => n.toString().padLeft(2, '0');
  return h > 0 ? '${dos(h)}:${dos(m)}:${dos(seg)}' : '${dos(m)}:${dos(seg)}';
}
