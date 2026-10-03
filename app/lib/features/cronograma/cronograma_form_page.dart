import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'cronograma_widgets.dart';
import 'planificador.dart';

/// Crear un cronograma (en prueba): qué ejercicio, qué temas, a qué ritmo o
/// hasta cuándo, si se intercalan Mixto (3.º) o las dos partes (4.º), y la
/// vista previa de las primeras semanas.
class CronogramaFormPage extends ConsumerStatefulWidget {
  const CronogramaFormPage({super.key});
  @override
  ConsumerState<CronogramaFormPage> createState() => _CronogramaFormPageState();
}

class _CronogramaFormPageState extends ConsumerState<CronogramaFormPage> {
  int _ejercicio = Oposiciones.actual.conCronograma.first.numero;
  bool _todos = true;
  List<String> _elegidos = const [];
  bool _porFecha = false;
  int _porSemana = 3;
  DateTime _fin = DateTime.now().add(const Duration(days: 120));
  bool _estaSemana = true;
  bool _intercalar = true;
  int? _cadaN;
  bool _compartir = false;

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).value;
    final estructura = ref.watch(estructuraProvider).value;
    final vinculos = ref.watch(misPreparadoresProvider);
    if (temario == null || estructura == null) return Scaffold(appBar: BarraWeb(title: const Text('Nuevo cronograma')), body: const Cargando());

    final delEjercicio = {for (final t in temario.todosLosTemas.where((t) => t.ejercicio == _ejercicio)) t.codigo};
    final temas = _todos ? delEjercicio : _elegidos.where(delEjercicio.contains).toSet();
    final orden = ordenInicial(estructura, _ejercicio, temas, intercalar: _intercalar, cadaN: _cadaN);
    final inicio = lunesDe(_estaSemana ? DateTime.now() : DateTime.now().add(const Duration(days: 7)));
    final c = crearCronograma(id: nuevoId(), ejercicio: _ejercicio, temas: orden, inicio: inicio, porSemana: _porSemana, fin: _porFecha ? _fin : null, intercalar: _intercalar, cadaN: _cadaN, compartir: _compartir);
    final estado = estadoDe(c, DateTime.now());
    final auto = unoDeCada(estructura, _ejercicio, orden);

    Future<void> crear() async {
      final nav = Navigator.of(context);
      if (ref.read(cronogramaProvider) != null) {
        final ok = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text('Ya tienes un cronograma'),
            content: const Text('Solo hay uno activo: el que tienes ahora se archivará y podrás seguir viéndolo más abajo en la pantalla del cronograma.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Empezar el nuevo')),
            ],
          ),
        );
        if (ok != true) return;
      }
      await ref.read(cronogramaProvider.notifier).empezar(c);
      nav.pop();
    }

    return Scaffold(
      appBar: BarraWeb(title: const Text('Nuevo cronograma')),
      body: ListaAdaptable(children: [
        const AvisoPrueba(),
        const TituloSeccion('Qué vuelta'),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: [for (final e in Oposiciones.actual.conCronograma) ButtonSegment(value: e.numero, label: Text(e.abreviado))],
          selected: {_ejercicio},
          onSelectionChanged: (s) => setState(() {
            _ejercicio = s.first;
            _elegidos = const [];
            _cadaN = null;
          }),
        ),
        const SizedBox(height: 10),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: RadioGroup<bool>(
            groupValue: _todos,
            onChanged: (v) => setState(() => _todos = v ?? true),
            child: Column(children: [
              RadioListTile<bool>(value: true, title: Text('Todos los temas (${delEjercicio.length})')),
              RadioListTile<bool>(
                value: false,
                title: Text(_elegidos.isEmpty ? 'Solo los que elija' : 'Solo los que elija (${temas.length})'),
                secondary: TextButton(
                  onPressed: () async {
                    final r = await elegirTemas(context, temario: temario, seleccion: _elegidos.isEmpty ? delEjercicio : _elegidos, ejercicios: {_ejercicio}, titulo: 'Temas de la vuelta');
                    if (r != null) {
                      setState(() {
                        _elegidos = r;
                        _todos = false;
                      });
                    }
                  },
                  child: const Text('Elegir'),
                ),
              ),
            ]),
          ),
        ),
        const TituloSeccion('Ritmo'),
        SegmentedButton<bool>(
          showSelectedIcon: false,
          segments: const [ButtonSegment(value: false, label: Text('Temas por semana')), ButtonSegment(value: true, label: Text('Fecha de fin'))],
          selected: {_porFecha},
          onSelectionChanged: (s) => setState(() => _porFecha = s.first),
        ),
        const SizedBox(height: 10),
        Tarjeta(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (!_porFecha)
              SelectorNumero(valor: _porSemana, onChanged: (v) => setState(() => _porSemana = v))
            else
              OutlinedButton.icon(
                icon: const Icon(Icons.event, size: 18),
                label: Text('Acabar el ${fechaLargaCrono(_fin)}'),
                onPressed: () async {
                  final x = await showDatePicker(context: context, initialDate: _fin, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 730)));
                  if (x != null) setState(() => _fin = x);
                },
              ),
            const SizedBox(height: 8),
            Text(
              temas.isEmpty
                  ? 'Elige al menos un tema.'
                  : (_porFecha ? 'Unos ${c.temasPorSemana} temas por semana; acabas el ${fechaLargaCrono(estado.fin!)}.' : 'Acabas el ${fechaLargaCrono(estado.fin!)} (${c.semanas.length} semanas).'),
              style: context.textos.bodySmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [ButtonSegment(value: true, label: Text('Empiezo esta semana')), ButtonSegment(value: false, label: Text('La semana que viene'))],
              selected: {_estaSemana},
              onSelectionChanged: (s) => setState(() => _estaSemana = s.first),
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
          ]),
        ),
        const TituloSeccion('Orden'),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: Column(children: [
            SwitchListTile(
              value: _intercalar,
              onChanged: (v) => setState(() => _intercalar = v),
              title: Text(Oposiciones.actual.ejercicio(_ejercicio)?.intercalar?.$1 ?? 'Intercalar las partes'),
              subtitle: Text(
                Oposiciones.actual.ejercicio(_ejercicio)?.intercalar?.$2 ?? 'Alternadas para no pasar semanas seguidas con una sola parte.',
                style: context.textos.labelSmall,
              ),
            ),
            if (_intercalar && auto != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: DropdownButtonFormField<int?>(
                  initialValue: _cadaN,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Proporción'),
                  items: [
                    DropdownMenuItem(value: null, child: Text('Proporcional (≈1 de cada $auto)')),
                    for (final n in [2, 3, 4, 5, 6]) DropdownMenuItem(value: n, child: Text('1 de cada $n')),
                  ],
                  onChanged: (v) => setState(() => _cadaN = v),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text('El orden sale de los bloques y las conexiones de la organización del temario. Podrás cambiarlo después.', style: context.textos.labelSmall),
            ),
          ]),
        ),
        if (vinculos.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Tarjeta(
              padding: EdgeInsets.zero,
              child: SwitchListTile(
                value: _compartir,
                onChanged: (v) => setState(() => _compartir = v),
                title: const Text('Compartirlo con mi preparador'),
                subtitle: Text('Lo verá y podrá proponerte cambios, que tú aceptas o no.', style: context.textos.labelSmall),
              ),
            ),
          ),
        const TituloSeccion('Primeras semanas'),
        if (temas.isNotEmpty) SemanasCronograma(c: c.copyWith(semanas: c.semanas.take(3).toList()), estado: estado),
        const SizedBox(height: 10),
        FilledButton.icon(onPressed: temas.isEmpty ? null : crear, icon: const Icon(Icons.event_note), label: const Text('Crear el cronograma')),
      ]),
    );
  }
}

/// Nombre corto del cronograma para listas.
String describirCronograma(Cronograma c) => '${nombreVuelta(c.ejercicio)} · ${c.temas.length} temas';
