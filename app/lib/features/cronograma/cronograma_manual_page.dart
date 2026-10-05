import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'planificador.dart';

/// Un cronograma hecho por tu cuenta, semana a semana: la fecha del primer
/// cante y, para cada semana, sus temas (o descanso). Sirve también para
/// revisar uno importado ([semanas], [primerCante] y lo que no se entendió).
class CronogramaManualPage extends ConsumerStatefulWidget {
  const CronogramaManualPage({super.key, this.semanas, this.primerCante, this.noReconocidas = const [], this.titulo = 'Semana a semana'});
  final List<SemanaPlan>? semanas;
  final DateTime? primerCante;
  final List<String> noReconocidas;
  final String titulo;

  @override
  ConsumerState<CronogramaManualPage> createState() => _CronogramaManualPageState();
}

class _Semana {
  _Semana({List<String>? temas, this.descanso = false}) : temas = temas ?? [];
  List<String> temas;
  bool descanso;
}

class _CronogramaManualPageState extends ConsumerState<CronogramaManualPage> {
  late DateTime _primerCante;
  late final List<_Semana> _semanas;

  @override
  void initState() {
    super.initState();
    final hoy = DateTime.now();
    _primerCante = widget.primerCante ?? DateTime(hoy.year, hoy.month, hoy.day + 7);
    _semanas = widget.semanas == null || widget.semanas!.isEmpty
        ? [_Semana()]
        : [for (final s in widget.semanas!) _Semana(temas: [...s.temas], descanso: s.descanso)];
  }

  DateTime _cante(int i) => DateTime(_primerCante.year, _primerCante.month, _primerCante.day + 7 * i);

  Future<void> _elegirFecha() async {
    final f = await showDatePicker(context: context, initialDate: _primerCante, firstDate: DateTime(2020), lastDate: DateTime(2035), helpText: 'Fecha del primer cante');
    if (f != null) setState(() => _primerCante = f);
  }

  Future<void> _elegirTemas(int i) async {
    final temario = ref.read(temarioProvider).valueOrNull;
    if (temario == null) return;
    final r = await elegirTemas(context, temario: temario, seleccion: _semanas[i].temas, titulo: 'Temas del cante del ${DateFormat("d 'de' MMMM", 'es').format(_cante(i))}');
    if (r == null) return;
    setState(() {
      // Un tema está en una sola semana: si estaba en otra, pasa a esta.
      for (final (j, s) in _semanas.indexed) {
        if (j != i) s.temas.removeWhere(r.contains);
      }
      _semanas[i]
        ..temas = r
        ..descanso = false;
    });
  }

  Future<void> _crear() async {
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
    final c = cronogramaManual(
      id: nuevoId(),
      inicio: _primerCante,
      diaCante: _primerCante.weekday,
      semanas: [for (final s in _semanas) SemanaPlan(lunes: _primerCante, temas: s.temas, descanso: s.descanso)],
    );
    await ref.read(cronogramaProvider.notifier).empezar(c);
    // De vuelta a la pantalla del cronograma (las de crear e importar se cierran).
    nav.popUntil((r) => r is! MaterialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final total = _semanas.fold<int>(0, (t, s) => t + s.temas.length);
    final formato = DateFormat("EEEE d 'de' MMMM", 'es');

    return Scaffold(
      appBar: BarraWeb(title: Text(widget.titulo)),
      body: ListaAdaptable(children: [
        const SizedBox(height: 10),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Primer cante'),
            subtitle: Text('${formato.format(_primerCante)}. Cada semana acaba el día en que cantas.', style: context.textos.labelSmall),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: _elegirFecha,
          ),
        ),
        if (widget.noReconocidas.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GrupoDesplegable(
              titulo: 'Líneas que no he entendido (${widget.noReconocidas.length})',
              subtitulo: 'Revísalas por si falta algún tema',
              children: [for (final l in widget.noReconocidas) ListTile(dense: true, title: Text(l, style: context.textos.bodySmall))],
            ),
          ),
        TituloSeccion('Semanas · $total ${total == 1 ? 'tema' : 'temas'}'),
        for (final (i, s) in _semanas.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Tarjeta(
              padding: const EdgeInsets.fromLTRB(14, 8, 4, 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text('Cante del ${DateFormat("EEE d MMM", 'es').format(_cante(i))}', style: context.textos.titleSmall)),
                  TextButton(onPressed: () => setState(() => s.descanso = !s.descanso), child: Text(s.descanso ? 'Quitar descanso' : 'Descanso')),
                  IconButton(
                    tooltip: 'Quitar la semana',
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: _semanas.length == 1 ? null : () => setState(() => _semanas.removeAt(i)),
                  ),
                ]),
                if (s.descanso)
                  Text('Semana de descanso', style: context.textos.bodySmall)
                else ...[
                  for (final t in s.temas)
                    Row(children: [
                      CasillaTema(t, color: estructura?.colorDe(t) ?? context.esquema.primary),
                      const SizedBox(width: 8),
                      Expanded(child: Text(temario?.tema(t)?.titulo ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall)),
                      IconButton(tooltip: 'Quitar', visualDensity: VisualDensity.compact, icon: const Icon(Icons.remove_circle_outline, size: 18), onPressed: () => setState(() => s.temas.remove(t))),
                    ]),
                  Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: () => _elegirTemas(i), icon: const Icon(Icons.add, size: 18), label: Text(s.temas.isEmpty ? 'Elegir temas' : 'Cambiar temas'))),
                ],
              ]),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(onPressed: () => setState(() => _semanas.add(_Semana())), icon: const Icon(Icons.add), label: const Text('Una semana más')),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(onPressed: total == 0 ? null : _crear, icon: const Icon(Icons.check), label: const Text('Crear el cronograma')),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 24),
          child: Text('Después lo puedes retocar: mover un tema de semana, quitarlo o añadir otros. Si te retrasas, la app te ofrece repartir lo pendiente.', style: context.textos.labelSmall),
        ),
      ]),
    );
  }
}
