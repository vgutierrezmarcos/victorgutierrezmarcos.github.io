import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/analitica.dart';
import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/autoevaluacion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/texto_formulas.dart';

LeitnerAuto leitnerAutoDe(String codigo) =>
    Hive.isBoxOpen(Cajas.app) ? LeitnerAuto.fromJson(Hive.box(Cajas.app).get('$prefijoAutoevaluacion$codigo')) : const LeitnerAuto({});

Future<void> _guardarLeitner(String codigo, LeitnerAuto l) async {
  if (Hive.isBoxOpen(Cajas.app)) await Hive.box(Cajas.app).put('$prefijoAutoevaluacion$codigo', l.toJson());
}

/// Abre la autoevaluación del tema [codigo] (si la tiene).
Future<void> abrirAutoevaluacion(BuildContext context, String codigo, String titulo) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AutoevaluacionPage(codigo: codigo, titulo: titulo)));

/// «Autoevalúate»: tarjetas del tema revisado para responder de memoria y
/// calificarse; lo que no se sabe vuelve antes (Leitner por tema, en este
/// dispositivo).
class AutoevaluacionPage extends ConsumerStatefulWidget {
  const AutoevaluacionPage({super.key, required this.codigo, required this.titulo});
  final String codigo, titulo;
  @override
  ConsumerState<AutoevaluacionPage> createState() => _AutoevaluacionPageState();
}

class _AutoevaluacionPageState extends ConsumerState<AutoevaluacionPage> {
  late LeitnerAuto _leitner = leitnerAutoDe(widget.codigo);
  List<PreguntaAuto>? _sesion;
  int _i = 0;
  bool _vista = false;
  bool? _eleccionVf;
  int _sabidas = 0;

  void _empezar(Autoevaluacion a, {bool todas = false}) => setState(() {
        _sesion = todas ? (List.of(a.preguntas)..shuffle()) : _leitner.sesion(a.preguntas, DateTime.now());
        _i = 0;
        _vista = false;
        _eleccionVf = null;
        _sabidas = 0;
      });

  Future<void> _calificar(bool sabia) async {
    final p = _sesion![_i];
    _leitner = _leitner.responder(p.id, sabia, DateTime.now());
    await _guardarLeitner(widget.codigo, _leitner);
    if (sabia) _sabidas++;
    if (_i + 1 >= _sesion!.length) Analitica.instancia.evento('autoevaluacion', parametros: {'tema': widget.codigo, 'preguntas': _sesion!.length, 'sabidas': _sabidas});
    setState(() {
      _i++;
      _vista = false;
      _eleccionVf = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final a = ref.watch(autoevaluacionProvider(widget.codigo));
    return Scaffold(
      appBar: BarraWeb(title: Text('Autoevalúate · ${widget.codigo}')),
      body: a.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(autoevaluacionProvider(widget.codigo))),
        data: (a) {
          if (a == null || a.preguntas.isEmpty) return const VacioVista(icono: Icons.quiz_outlined, texto: 'Este tema aún no tiene autoevaluación, o no se ha podido descargar.');
          final s = _sesion;
          if (s == null) return _inicio(a);
          if (_i >= s.length) return _final(a, s);
          return _tarjeta(s[_i], s.length);
        },
      ),
    );
  }

  Widget _inicio(Autoevaluacion a) {
    final ahora = DateTime.now();
    final pendientes = _leitner.pendientes(a.preguntas, ahora);
    final dominadas = _leitner.dominadas(a.preguntas);
    return ListaAdaptable(padding: const EdgeInsets.fromLTRB(16, 14, 16, 32), children: [
      Text(widget.titulo, style: context.textos.titleMedium),
      const SizedBox(height: 8),
      Text('${a.preguntas.length} preguntas cortas del tema revisado: conceptos, fórmulas, qué predice cada modelo y verdadero o falso. Responde de memoria, destapa la respuesta y califícate con sinceridad: las que no sabías vuelven antes (al día siguiente; las que sabías, a los 3, 7 y 15 días).', style: context.textos.bodySmall),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: Estadistica(valor: '$pendientes', etiqueta: 'para hoy', icono: Icons.today_outlined)),
        const SizedBox(width: 10),
        Expanded(child: Estadistica(valor: '$dominadas', etiqueta: 'dominadas', icono: Icons.verified_outlined, color: Paleta.acierto)),
      ]),
      const SizedBox(height: 16),
      FilledButton.icon(
        onPressed: pendientes == 0 ? null : () => _empezar(a),
        icon: const Icon(Icons.play_arrow),
        label: Text(pendientes == 0 ? 'Nada pendiente hoy' : 'Empezar (${pendientes.clamp(0, 12)})'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(onPressed: () => _empezar(a, todas: true), icon: const Icon(Icons.shuffle), label: const Text('Repasar todas, en desorden')),
      const SizedBox(height: 14),
      Text('Material exclusivo de uso personal, como el tema revisado. El progreso se guarda en este dispositivo.', style: context.textos.labelSmall),
    ]);
  }

  Widget _tarjeta(PreguntaAuto p, int total) {
    final vf = p.esVf;
    final acertoVf = vf && _eleccionVf != null && _eleccionVf == p.verdadero;
    return ListaAdaptable(padding: const EdgeInsets.fromLTRB(16, 14, 16, 32), children: [
      ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: _i / total, minHeight: 6, backgroundColor: context.colores.borde)),
      const SizedBox(height: 6),
      Text('${_i + 1} de $total · ${p.etiquetaTipo}', style: context.textos.labelSmall),
      const SizedBox(height: 10),
      Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (p.apartado.isNotEmpty) Text(p.apartado, style: context.textos.labelSmall?.copyWith(color: context.esquema.primary)),
          const SizedBox(height: 4),
          TextoConFormulas(p.pregunta, style: context.textos.titleMedium),
        ]),
      ),
      const SizedBox(height: 12),
      if (!_vista && vf)
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () => setState(() { _eleccionVf = true; _vista = true; }), child: const Text('Verdadero'))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(onPressed: () => setState(() { _eleccionVf = false; _vista = true; }), child: const Text('Falso'))),
        ])
      else if (!_vista)
        FilledButton.tonalIcon(onPressed: () => setState(() => _vista = true), icon: const Icon(Icons.visibility_outlined), label: const Text('Ver la respuesta')),
      if (_vista) ...[
        Tarjeta(
          color: vf ? (acertoVf ? Paleta.acierto.withValues(alpha: 0.10) : Paleta.fallo.withValues(alpha: 0.10)) : context.colores.primarioPalido,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (vf) Text(acertoVf ? 'Bien' : 'No', style: context.textos.titleSmall?.copyWith(color: acertoVf ? Paleta.acierto : Paleta.fallo)),
            TextoConFormulas(p.respuesta, style: context.textos.bodyMedium),
          ]),
        ),
        const SizedBox(height: 12),
        if (vf)
          FilledButton(onPressed: () => _calificar(acertoVf), child: const Text('Siguiente'))
        else
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () => _calificar(false), icon: Icon(Icons.close, color: Paleta.fallo), label: const Text('No la sabía'))),
            const SizedBox(width: 10),
            Expanded(child: FilledButton.icon(onPressed: () => _calificar(true), icon: const Icon(Icons.check), label: const Text('La sabía'))),
          ]),
      ],
    ]);
  }

  Widget _final(Autoevaluacion a, List<PreguntaAuto> s) => ListaAdaptable(padding: const EdgeInsets.fromLTRB(16, 24, 16, 32), children: [
        Icon(Icons.task_alt, size: 48, color: context.esquema.primary),
        const SizedBox(height: 10),
        Text('$_sabidas de ${s.length}', textAlign: TextAlign.center, style: context.textos.headlineSmall),
        Text('Las que no sabías vuelven mañana. Llevas ${_leitner.dominadas(a.preguntas)} de ${a.preguntas.length} dominadas.', textAlign: TextAlign.center, style: context.textos.bodySmall),
        const SizedBox(height: 16),
        FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Terminar')),
        TextButton(onPressed: () => setState(() => _sesion = null), child: const Text('Volver al inicio')),
      ]);
}
