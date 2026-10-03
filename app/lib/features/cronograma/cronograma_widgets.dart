import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models/oposicion.dart';
import '../../core/providers.dart';
import '../../data/models/cronograma.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'planificador.dart';

String diaMes(DateTime d) => DateFormat('d MMM', 'es').format(d);
String fechaLargaCrono(DateTime d) => DateFormat("d 'de' MMMM", 'es').format(d);
/// «jueves 9 oct.».
String diaSemanaYMes(DateTime d) => DateFormat('EEEE d MMM', 'es').format(d);

/// Nombre del día de la semana (1 = lunes … 7 = domingo).
String nombreDiaSemana(int dia) => const ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'][dia - 1];

String nombreVuelta(int ejercicio) => 'Vuelta al ${EjercicioDef.ordinalAbreviado(ejercicio)} ejercicio';

/// Aviso de que el cronograma está en prueba.
class AvisoPrueba extends StatelessWidget {
  const AvisoPrueba({super.key});
  @override
  Widget build(BuildContext context) => Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.science_outlined, color: context.esquema.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text('En prueba. El cronograma es nuevo: puede cambiar y nos ayuda mucho que nos cuentes qué mejorarías (Más → Contacto).', style: context.textos.bodySmall),
          ),
        ]),
      );
}

/// Resumen: progreso, ritmo y fecha de fin.
class ResumenCronograma extends StatelessWidget {
  const ResumenCronograma({super.key, required this.c, required this.estado});
  final Cronograma c;
  final EstadoCronograma estado;
  @override
  Widget build(BuildContext context) => Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(nombreVuelta(c.ejercicio), style: context.textos.titleMedium)),
            const Etiqueta('EN PRUEBA'),
          ]),
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: estado.progreso, minHeight: 8)),
          const SizedBox(height: 6),
          Text(
            [
              '${estado.hechos.length} de ${estado.total} temas',
              '${c.temasPorSemana} por semana',
              if (estado.terminado) '¡vuelta terminada!' else if (estado.fin != null) 'acabas el ${fechaLargaCrono(estado.fin!)}',
            ].join(' · '),
            style: context.textos.bodySmall,
          ),
        ]),
      );
}

/// Las semanas del cronograma con sus temas. Con [onMarcar] se pueden marcar
/// los temas; con [onDescanso], convertir una semana en descanso.
class SemanasCronograma extends ConsumerWidget {
  const SemanasCronograma({super.key, required this.c, required this.estado, this.onMarcar, this.onDescanso, this.soloDesdeActual = false});
  final Cronograma c;
  final EstadoCronograma estado;
  final void Function(String tema, bool hecho)? onMarcar;
  final void Function(SemanaPlan semana, bool descansar)? onDescanso;
  final bool soloDesdeActual;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temario = ref.watch(temarioProvider).value;
    final estructura = ref.watch(estructuraProvider).value;
    final esta = inicioSemana(DateTime.now(), c.diaCante);
    final semanas = soloDesdeActual ? c.semanas.where((s) => !s.lunes.isBefore(esta)).toList() : c.semanas;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final s in semanas)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Tarjeta(
            color: s.lunes == esta ? context.colores.primarioPalido : null,
            padding: const EdgeInsets.fromLTRB(14, 8, 6, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(
                    '${c.diaCante == null ? 'Semana del ${diaMes(s.lunes)} al ${diaMes(s.domingo)}' : 'Cante del ${diaSemanaYMes(s.domingo)}'}${s.lunes == esta ? ' · esta semana' : ''}',
                    style: context.textos.titleSmall?.copyWith(color: s.lunes == esta ? context.esquema.primary : null),
                  ),
                ),
                if (onDescanso != null && !s.lunes.isBefore(esta) && (s.descanso || s.temas.every((t) => !estado.hechos.contains(t))))
                  TextButton(
                    onPressed: () => onDescanso!(s, !s.descanso),
                    child: Text(s.descanso ? 'Quitar descanso' : 'Descanso'),
                  ),
              ]),
              if (s.descanso)
                Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('Semana de descanso', style: context.textos.bodySmall))
              else
                for (final t in s.temas)
                  InkWell(
                    onTap: onMarcar == null ? null : () => onMarcar!(t, !estado.hechos.contains(t)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(children: [
                        if (onMarcar != null)
                          Checkbox(value: estado.hechos.contains(t), visualDensity: VisualDensity.compact, onChanged: (v) => onMarcar!(t, v ?? false))
                        else
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(estado.hechos.contains(t) ? Icons.check_circle : Icons.circle_outlined, size: 18, color: estado.hechos.contains(t) ? Paleta.acierto : context.colores.textoClaro),
                          ),
                        CasillaTema(t, color: estructura?.colorDe(t) ?? context.esquema.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            temario?.tema(t)?.titulo ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textos.bodySmall?.copyWith(
                              decoration: estado.hechos.contains(t) ? TextDecoration.lineThrough : null,
                              color: estado.atrasados.contains(t) ? context.esquema.error : null,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
            ]),
          ),
        ),
    ]);
  }
}

/// Elige ritmo: temas por semana o fecha de fin. Devuelve (porSemana, fin).
Future<({int? porSemana, DateTime? fin})?> elegirRitmo(BuildContext context, {required int pendientes, required int porSemana, DateTime? fin, Set<DateTime> descansos = const {}, int? diaCante}) {
  var porFecha = fin != null;
  var k = porSemana;
  var f = fin ?? finEstimado(pendientes, DateTime.now(), porSemana, descansos, diaCante: diaCante);
  return showDialog(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) => AlertDialog(
        title: const Text('Ritmo'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [ButtonSegment(value: false, label: Text('Temas por semana')), ButtonSegment(value: true, label: Text('Fecha de fin'))],
            selected: {porFecha},
            onSelectionChanged: (v) => set(() => porFecha = v.first),
          ),
          const SizedBox(height: 14),
          if (!porFecha) ...[
            SelectorNumero(valor: k, onChanged: (v) => set(() => k = v)),
            Text('Acabarías el ${fechaLargaCrono(finEstimado(pendientes, DateTime.now(), k, descansos, diaCante: diaCante))}.', style: Theme.of(d).textTheme.bodySmall),
          ] else ...[
            OutlinedButton.icon(
              icon: const Icon(Icons.event, size: 18),
              label: Text('Acabar el ${fechaLargaCrono(f)}'),
              onPressed: () async {
                final x = await showDatePicker(context: d, initialDate: f, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 730)));
                if (x != null) set(() => f = x);
              },
            ),
            const SizedBox(height: 6),
            Text('Unos ${ritmoPara(pendientes, DateTime.now(), f, descansos, diaCante: diaCante)} temas por semana.', style: Theme.of(d).textTheme.bodySmall),
          ],
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, porFecha ? (porSemana: null, fin: f) : (porSemana: k, fin: null)), child: const Text('Aplicar')),
        ],
      ),
    ),
  );
}

/// Número con botones de menos y más (temas por semana).
class SelectorNumero extends StatelessWidget {
  const SelectorNumero({super.key, required this.valor, required this.onChanged, this.minimo = 1, this.maximo = 20, this.unidad = 'temas por semana'});
  final int valor;
  final ValueChanged<int> onChanged;
  final int minimo, maximo;
  final String unidad;
  @override
  Widget build(BuildContext context) => Row(children: [
        IconButton.outlined(tooltip: 'Menos', onPressed: valor > minimo ? () => onChanged(valor - 1) : null, icon: const Icon(Icons.remove)),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text('$valor', style: context.textos.headlineSmall)),
        IconButton.outlined(tooltip: 'Más', onPressed: valor < maximo ? () => onChanged(valor + 1) : null, icon: const Icon(Icons.add)),
        const SizedBox(width: 10),
        Flexible(child: Text(unidad, style: context.textos.bodySmall)),
      ]);
}

/// Reordenar los temas pendientes de una vuelta. Devuelve el orden completo
/// (lo ya hecho delante, sin moverse) o null.
class ReordenarTemasPage extends ConsumerStatefulWidget {
  const ReordenarTemasPage({super.key, required this.c, required this.hechos, this.titulo = 'Orden de los temas'});
  final Cronograma c;
  final Set<String> hechos;
  final String titulo;
  @override
  ConsumerState<ReordenarTemasPage> createState() => _ReordenarTemasPageState();
}

class _ReordenarTemasPageState extends ConsumerState<ReordenarTemasPage> {
  late List<String> _pendientes = widget.c.temas.where((t) => !widget.hechos.contains(t)).toList();

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).value;
    final estructura = ref.watch(estructuraProvider).value;
    return Scaffold(
      appBar: BarraWeb(
        title: Text(widget.titulo),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, [...widget.c.temas.where(widget.hechos.contains), ..._pendientes]),
            child: const Text('Guardar'),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(children: [
            Expanded(child: Text('Arrastra los temas para cambiar el orden. Los ya hechos no se mueven.', style: context.textos.bodySmall)),
            if (estructura != null)
              TextButton(
                onPressed: () => setState(() {
                  _pendientes = ordenInicial(estructura, widget.c.ejercicio, _pendientes.toSet(), intercalar: widget.c.intercalar, cadaN: widget.c.cadaN);
                }),
                child: const Text('Orden sugerido'),
              ),
          ]),
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            itemCount: _pendientes.length,
            onReorderItem: (a, b) => setState(() => _pendientes.insert(b, _pendientes.removeAt(a))),
            itemBuilder: (_, i) {
              final t = _pendientes[i];
              return ListTile(
                key: ValueKey(t),
                dense: true,
                leading: CasillaTema(t, color: estructura?.colorDe(t) ?? context.esquema.primary),
                title: Text(temario?.tema(t)?.titulo ?? t, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(estructura?.bloqueDe(t)?.nombre ?? '', style: context.textos.labelSmall),
                trailing: const Icon(Icons.drag_handle),
              );
            },
          ),
        ),
      ]),
    );
  }
}
