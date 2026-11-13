import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../data/models/fases.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/reloj_cante.dart';
import '../cantar/sorteo.dart';

/// Práctica de un ejercicio escrito (1.º de DCE): apuntar un tema escrito con
/// su valoración (bien, regular o mal) y el simulacro como en el examen (dos
/// bolas de cada parte, un tema de cada par, 3 horas sin apuntes). Todo va al
/// diario como un cante hecho del ejercicio, con los temas descartados del
/// simulacro: de ahí salen los temas flojos del cronograma por fases.

/// Bien, regular o mal.
class SelectorNota extends StatelessWidget {
  const SelectorNota({super.key, required this.valor, required this.onChanged});
  final NotaEscrito? valor;
  final ValueChanged<NotaEscrito> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<NotaEscrito>(
        showSelectedIcon: false,
        emptySelectionAllowed: true,
        segments: [for (final n in NotaEscrito.values) ButtonSegment(value: n, label: Text(n.nombre))],
        selected: valor == null ? const {} : {valor!},
        onSelectionChanged: (s) {
          if (s.isNotEmpty) onChanged(s.first);
        },
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      );
}

/// Guarda en el diario los temas escritos con su nota (y, en un simulacro,
/// los sorteados y los descartados).
Future<void> guardarEscrito(
  WidgetRef ref, {
  required int ejercicio,
  required Map<String, NotaEscrito> notas,
  List<String> sorteados = const [],
  List<String> descartados = const [],
  int segundos = 0,
  String comentarios = '',
}) async {
  final temas = notas.keys.toList();
  final simulacro = descartados.isNotEmpty;
  await ref.read(cantesProvider.notifier).guardar(Cante(
        id: nuevoId(),
        fecha: DateTime.now(),
        titulo: simulacro ? 'Simulacro escrito' : 'Tema escrito',
        minutos: segundos == 0 ? 60 : (segundos / 60).ceil(),
        exposicion: segundos ~/ 60,
        ejercicio: ejercicio,
        bolsa: TipoBolsa.lista,
        temas: sorteados.isEmpty ? temas : sorteados,
        estado: EstadoCante.hecho,
        resultado: ResultadoCante(
          sorteados: sorteados,
          temaCantado: temas.firstOrNull,
          otrosCantados: temas.skip(1).toList(),
          segundos: segundos,
          valoracion: ResultadoCante.media(notas.values.map((n) => n.valor)),
          valoraciones: {for (final e in notas.entries) e.key: e.value.valor},
          comentarios: comentarios,
          descartados: descartados,
        ),
      ));
}

/// Hoja para apuntar un tema escrito suelto (fuera de un simulacro).
Future<void> apuntarTemaEscrito(BuildContext context, WidgetRef ref, {required int ejercicio, String? tema}) async {
  final temario = ref.read(temarioProvider).valueOrNull;
  if (temario == null) return;
  final temas = temario.todosLosTemas.where((t) => t.ejercicio == ejercicio).toList();
  final messenger = ScaffoldMessenger.of(context);
  final r = await showModalBottomSheet<(String, NotaEscrito, int, String)>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => _HojaTemaEscrito(temas: temas, tema: tema),
  );
  if (r == null) return;
  await guardarEscrito(ref, ejercicio: ejercicio, notas: {r.$1: r.$2}, segundos: r.$3 * 60, comentarios: r.$4);
  messenger.mostrar(SnackBar(content: Text('${r.$1} apuntado: ${r.$2.nombre.toLowerCase()}')));
}

class _HojaTemaEscrito extends StatefulWidget {
  const _HojaTemaEscrito({required this.temas, this.tema});
  final List<Tema> temas;
  final String? tema;
  @override
  State<_HojaTemaEscrito> createState() => _HojaTemaEscritoState();
}

class _HojaTemaEscritoState extends State<_HojaTemaEscrito> {
  late String? _tema = widget.tema;
  NotaEscrito? _nota;
  final _minutos = TextEditingController();
  final _comentarios = TextEditingController();

  @override
  void dispose() {
    _minutos.dispose();
    _comentarios.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('¿Qué tema has escrito?', style: context.textos.titleMedium),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _tema,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Tema', isDense: true),
              items: [for (final t in widget.temas) DropdownMenuItem(value: t.codigo, child: Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis))],
              onChanged: (v) => setState(() => _tema = v),
            ),
            const SizedBox(height: 14),
            Text('¿Cómo te ha salido?', style: context.textos.labelMedium),
            const SizedBox(height: 6),
            SelectorNota(valor: _nota, onChanged: (n) => setState(() => _nota = n)),
            const SizedBox(height: 12),
            SizedBox(
              width: 160,
              child: TextField(controller: _minutos, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minutos (opcional)', isDense: true)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _comentarios,
              minLines: 2,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Qué faltó, qué mejorar… (opcional)'),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(spacing: 8, children: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                FilledButton(
                  onPressed: _tema == null || _nota == null ? null : () => Navigator.pop(context, (_tema!, _nota!, int.tryParse(_minutos.text.trim()) ?? 0, _comentarios.text.trim())),
                  child: const Text('Guardar en el diario'),
                ),
              ]),
            ),
          ]),
        ),
      );
}

// ------------------------------------------------------------- Simulacro

enum _Paso { sorteo, elegir, escribir, valorar }

/// Simulacro escrito como en el examen: la app saca [bolas] temas de cada
/// parte, el opositor elige uno de cada par y los escribe en el tiempo del
/// examen, sin apuntes, con el cronómetro de la app. Al acabar valora cada
/// tema y se guarda en el diario con los descartados.
class SimulacroEscritoPage extends ConsumerStatefulWidget {
  const SimulacroEscritoPage({super.key, required this.ejercicio, this.minutos = 180});
  final int ejercicio;
  final int minutos;
  @override
  ConsumerState<SimulacroEscritoPage> createState() => _SimulacroEscritoPageState();
}

class _SimulacroEscritoPageState extends ConsumerState<SimulacroEscritoPage> {
  _Paso _paso = _Paso.sorteo;
  /// Temas sacados de cada parte («1.A», «1.B»).
  Map<String, List<Tema>> _pares = const {};
  final _elegidos = <String, String>{};
  final _notas = <String, NotaEscrito>{};
  late final _reloj = RelojCante(exposicion: Duration(minutes: widget.minutos));
  Timer? _tic;

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  void _sortear(Temario temario) {
    final config = ref.read(configProvider).valueOrNull ?? AppConfig.porDefecto;
    final bolas = Oposiciones.actual.bolasPorParte(widget.ejercicio, config);
    final porParte = <String, List<Tema>>{};
    for (final t in temario.todosLosTemas.where((t) => t.ejercicio == widget.ejercicio)) {
      porParte.putIfAbsent(t.claveParte, () => []).add(t);
    }
    setState(() {
      _pares = Sorteo.sorteoOficial(porParte, bolas);
      _elegidos.clear();
      _paso = _Paso.elegir;
    });
  }

  void _empezar() {
    setState(() => _paso = _Paso.escribir);
    _reloj.iniciar(DateTime.now());
    _tic = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  void _terminar() {
    _reloj.pausar(DateTime.now());
    _tic?.cancel();
    setState(() => _paso = _Paso.valorar);
  }

  Future<void> _guardar() async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final escritos = [for (final p in _pares.keys) _elegidos[p]!];
    await guardarEscrito(
      ref,
      ejercicio: widget.ejercicio,
      notas: {for (final t in escritos) t: _notas[t]!},
      sorteados: [for (final l in _pares.values) ...l.map((t) => t.codigo)],
      descartados: [for (final e in _pares.entries) ...e.value.map((t) => t.codigo).where((c) => c != _elegidos[e.key])],
      segundos: _reloj.expuesto(DateTime.now()).inSeconds,
    );
    messenger.mostrar(const SnackBar(content: Text('Simulacro guardado en el diario')));
    nav.pop();
  }

  static String _hms(Duration d) {
    String dos(int n) => n.toString().padLeft(2, '0');
    return '${d.inHours}:${dos(d.inMinutes % 60)}:${dos(d.inSeconds % 60)}';
  }

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final titulo = 'Simulacro del ${EjercicioDef.ordinalAbreviado(widget.ejercicio)} ejercicio';
    if (temario == null) return Scaffold(appBar: BarraWeb(title: Text(titulo)), body: const Cargando());
    Color? color(String t) => estructura?.colorDe(t);
    final ahora = DateTime.now();

    final hijos = <Widget>[
      if (_paso == _Paso.sorteo) ...[
        Tarjeta(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Como en el examen', style: context.textos.titleMedium),
            const SizedBox(height: 6),
            Text(
              'La app saca dos temas de cada parte. Eliges uno de cada par y escribes los dos en ${widget.minutos ~/ 60} horas, sin apuntes. '
              'Al acabar, valoras cada tema: los que salen mal o regular y los que descartas una y otra vez vuelven a tu cronograma.',
              style: context.textos.bodySmall,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(onPressed: () => _sortear(temario), icon: const Icon(Icons.casino_outlined), label: const Text('Sacar las bolas')),
          ]),
        ),
      ],
      if (_paso == _Paso.elegir) ...[
        for (final e in _pares.entries) ...[
          TituloSeccion('Parte ${e.key.split('.').last}: elige uno'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: RadioGroup<String>(
              groupValue: _elegidos[e.key],
              onChanged: (v) => setState(() => _elegidos[e.key] = v!),
              child: Column(children: [for (final t in e.value) RadioListTile<String>(value: t.codigo, title: TextoTema(t.codigo, t.titulo, color: color(t.codigo)))]),
            ),
          ),
        ],
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          FilledButton.icon(
            onPressed: _elegidos.length == _pares.length ? _empezar : null,
            icon: const Icon(Icons.timer_outlined),
            label: Text('Empezar (${widget.minutos ~/ 60} h)'),
          ),
          TextButton(onPressed: () => _sortear(temario), child: const Text('Sacar otras')),
        ]),
      ],
      if (_paso == _Paso.escribir) ...[
        Tarjeta(
          child: Column(children: [
            Text(_reloj.terminado(ahora) ? 'Tiempo cumplido' : 'Queda', style: context.textos.labelLarge),
            Text(
              _reloj.terminado(ahora) ? '+${_hms(_reloj.exceso(ahora))}' : _hms(_reloj.restanteFase(ahora)),
              style: context.textos.displayMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _reloj.progresoFase(ahora), minHeight: 6),
            const SizedBox(height: 12),
            Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _reloj.corriendo ? _reloj.pausar(DateTime.now()) : _reloj.iniciar(DateTime.now())),
                icon: Icon(_reloj.corriendo ? Icons.pause : Icons.play_arrow),
                label: Text(_reloj.corriendo ? 'Pausar' : 'Seguir'),
              ),
              FilledButton.icon(onPressed: _terminar, icon: const Icon(Icons.flag_outlined), label: const Text('He terminado')),
            ]),
          ]),
        ),
        const TituloSeccion('Escribes'),
        for (final t in _elegidos.values) Padding(padding: const EdgeInsets.only(bottom: 6), child: TextoTema(t, temario.tema(t)?.titulo ?? '', color: color(t))),
      ],
      if (_paso == _Paso.valorar) ...[
        Text('Has escrito ${_hms(_reloj.expuesto(ahora))}. ¿Cómo te ha salido cada tema?', style: context.textos.bodyMedium),
        for (final t in _elegidos.values) ...[
          const SizedBox(height: 14),
          TextoTema(t, temario.tema(t)?.titulo ?? '', color: color(t)),
          const SizedBox(height: 6),
          SelectorNota(valor: _notas[t], onChanged: (n) => setState(() => _notas[t] = n)),
        ],
        const SizedBox(height: 16),
        FilledButton(onPressed: _elegidos.values.every(_notas.containsKey) ? _guardar : null, child: const Text('Guardar en el diario')),
      ],
    ];
    return PopScope(
      canPop: _paso == _Paso.sorteo || _paso == _Paso.elegir,
      onPopInvokedWithResult: (hecho, _) async {
        if (hecho) return;
        final salir = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text('¿Dejar el simulacro?'),
            content: const Text('No se guardará en el diario.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Seguir')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Dejarlo')),
            ],
          ),
        );
        if (salir == true && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(appBar: BarraWeb(title: Text(titulo)), body: ListaAdaptable(children: hijos)),
    );
  }
}
