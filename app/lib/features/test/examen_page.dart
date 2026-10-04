import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      error: (e, _) => Scaffold(appBar: BarraWeb(), body: ErrorVista(error: e)),
      data: (b) {
        _preguntas ??= MotorTest.componer(b, widget.config);
        final preguntas = _preguntas!;
        if (preguntas.isEmpty) {
          return Scaffold(appBar: BarraWeb(), body: const Center(child: Text('No hay preguntas para este test.')));
        }
        final p = preguntas[_idx];
        final restante = _limite > 0 ? _limite - _segundos : _segundos;
        // Como el temporizador de la web: naranja en los últimos 5 minutos y rojo en el último.
        final colorReloj = _limite > 0 && restante < 60 ? Paleta.falloWeb : (_limite > 0 && restante < 300 ? Paleta.avisoWeb : Colors.white.withValues(alpha: 0.15));

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (await _confirmarSalida() && context.mounted) context.pop();
          },
          child: Scaffold(
            // .examen-header: barra morada con la pregunta en curso y el temporizador.
            appBar: BarraWeb(
              title: Text('Pregunta ${_idx + 1} de ${preguntas.length}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              actions: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: colorReloj, borderRadius: BorderRadius.circular(6)),
                    child: Text(formatoReloj(restante), style: TextStyle(fontFamily: Fuentes.sans, fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFeatures: [FontFeature.tabularFigures()])),
                  ),
                ),
                IconButton(icon: const Icon(Icons.grid_view), tooltip: 'Navegador de preguntas', onPressed: _mostrarRejilla),
              ],
            ),
            body: Column(children: [
              LinearProgressIndicator(value: (_idx + 1) / preguntas.length, minHeight: 3),
              Expanded(
                child: ListaAdaptable(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // .pregunta-container
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      decoration: BoxDecoration(color: context.colores.superficie, borderRadius: BorderRadius.circular(8), boxShadow: context.sombraSuave),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Row(children: [
                          Text('PREGUNTA ${_idx + 1}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 13.5, fontWeight: FontWeight.w600, letterSpacing: 0.7, color: context.esquema.primary)),
                          const SizedBox(width: 8),
                          Etiqueta(p.tema),
                          if (p.anulada) const Padding(padding: EdgeInsets.only(left: 6), child: Etiqueta('ANULADA', color: Paleta.avisoWeb)),
                          const Spacer(),
                          IconButton(
                            icon: Icon(_marcadas.contains(p.id) ? Icons.flag : Icons.outlined_flag),
                            color: _marcadas.contains(p.id) ? context.colores.dorado : context.colores.textoClaro,
                            tooltip: 'Marcar para revisar',
                            onPressed: () => setState(() => _marcadas.contains(p.id) ? _marcadas.remove(p.id) : _marcadas.add(p.id)),
                          ),
                        ]),
                        // .pregunta-enunciado
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.colores.fondoClaro,
                            border: Border(left: BorderSide(color: context.esquema.primary, width: 4)),
                          ),
                          child: Text(p.enunciado, style: context.textos.bodyLarge?.copyWith(fontSize: 16.5)),
                        ),
                        for (final img in p.imagenes)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => Dialog(child: InteractiveViewer(child: Image.network('${ref.read(oposicionProvider).urlImagenesTest}/${img.src.split('/').last}'))),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network('${ref.read(oposicionProvider).urlImagenesTest}/${img.src.split('/').last}', semanticLabel: img.alt),
                              ),
                            ),
                          ),
                        const SizedBox(height: 14),
                        for (final e in p.opciones.entries) _opcion(p, e.key, e.value),
                        Row(children: [
                          Expanded(child: Text(p.examen, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontStyle: FontStyle.italic, color: context.colores.textoClaro), overflow: TextOverflow.ellipsis)),
                          if (_respuestas[p.id] != null)
                            TextButton.icon(
                              onPressed: () => setState(() => _respuestas[p.id] = null),
                              icon: const Icon(Icons.backspace_outlined, size: 18),
                              label: const Text('Dejar en blanco'),
                            ),
                        ]),
                      ]),
                    ),
                  ],
                ),
              ),
              // .navegacion-btns: anterior y siguiente con borde morado; finalizar en dorado.
              Container(
                decoration: BoxDecoration(color: context.colores.superficie, border: Border(top: BorderSide(color: context.colores.borde))),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Row(children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13), minimumSize: const Size(48, 44)),
                        onPressed: _idx == 0 ? null : () => setState(() => _idx--),
                        child: const Icon(Icons.chevron_left),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: context.colores.dorado),
                          onPressed: _confirmarFin,
                          child: const Text('Finalizar'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _idx < preguntas.length - 1 ? () => setState(() => _idx++) : null,
                          child: const Text('Siguiente'),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  /// .opcion-btn: caja blanca con borde de 2 px; elegida, morado pálido con borde morado.
  Widget _opcion(Pregunta p, String letra, String texto) {
    final sel = _respuestas[p.id] == letra;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: sel ? context.colores.primarioPalido : context.colores.superficie,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => setState(() => _respuestas[p.id] = letra),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: sel ? context.esquema.primary : context.colores.borde, width: 2),
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('$letra)', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 16.5, fontWeight: FontWeight.w600, color: context.esquema.primary, height: 1.4)),
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
            Text('${_respuestas.values.where((v) => v != null).length} respondidas · ${_marcadas.length} marcadas (borde dorado)', style: context.textos.bodySmall),
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
                      child: Builder(builder: (context) {
                        final respondida = _respuestas[preguntas[i].id] != null;
                        final actual = i == _idx;
                        final marcada = _marcadas.contains(preguntas[i].id);
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: actual ? context.esquema.primary : (respondida ? context.colores.primarioPalido : context.colores.superficie),
                            border: Border.all(color: marcada ? context.colores.dorado : (actual || respondida ? context.esquema.primary : context.colores.borde), width: 2),
                          ),
                          child: Text('${i + 1}', style: TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w600, fontSize: 13, color: actual ? Colors.white : context.esquema.onSurface)),
                        );
                      }),
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
