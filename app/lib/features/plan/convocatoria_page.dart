import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/calendario.dart';
import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cantes_util.dart';

/// Convocatoria: fecha de cada ejercicio (la pone el opositor), hitos propios
/// y cuenta atrás de cada uno.
class ConvocatoriaPage extends ConsumerWidget {
  const ConvocatoriaPage({super.key});

  static const _descripciones = {
    1: 'Test y dictamen de coyuntura',
    2: 'Idiomas',
    3: 'Economía general e internacional (oral)',
    4: 'Economía española y sector público (oral)',
    5: 'Marketing, econometría y derecho (escrito)',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).value ?? AppConfig.porDefecto;
    final plan = ref.watch(planProvider);
    final fechas = ref.watch(fechasEjerciciosProvider);
    final notifier = ref.read(planProvider.notifier);
    final formato = DateFormat("EEEE d 'de' MMMM 'de' y", 'es');
    final hitos = [...plan.hitos]..sort((a, b) => a.fecha.compareTo(b.fecha));

    Future<void> fijar(int ej) async {
      final f = await showDatePicker(
        context: context,
        initialDate: fechas[ej] ?? DateTime.now().add(const Duration(days: 120)),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 6),
        helpText: 'Fecha del ${nombreEjercicio(ej).toLowerCase()}',
      );
      if (f == null) return;
      await notifier.actualizar((p) => p.copyWith(fechas: {...p.fechas, ej: f}));
      // La fecha del primer ejercicio también alimenta la portada de versiones anteriores.
      if (ej == 1) await ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(fechaConvocatoria: f));
    }

    Future<void> quitar(int ej) async {
      await notifier.actualizar((p) => p.copyWith(fechas: {...p.fechas}..remove(ej)));
      if (ej == 1) await ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(borrarFecha: true));
    }

    Future<void> nuevoHito() async {
      final ctrl = TextEditingController();
      final titulo = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Nuevo hito'),
          content: TextField(controller: ctrl, autofocus: true, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Simulacro, publicación de listas…')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, ctrl.text.trim()), child: const Text('Elegir fecha')),
          ],
        ),
      );
      if (titulo == null || titulo.isEmpty || !context.mounted) return;
      final f = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year - 1), lastDate: DateTime(DateTime.now().year + 6), helpText: titulo);
      if (f == null) return;
      await notifier.actualizar((p) => p.copyWith(hitos: [...p.hitos, Hito(id: nuevoId(), titulo: titulo, fecha: f)]));
    }

    Widget cuenta(DateTime f) {
      final dias = diasHasta(f);
      return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(dias < 0 ? '✓' : '$dias', style: context.textos.headlineSmall?.copyWith(color: dias < 0 ? Paleta.acierto : context.esquema.primary)),
        Text(dias < 0 ? 'pasado' : (dias == 1 ? 'día' : 'días'), style: context.textos.labelSmall),
      ]);
    }

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Convocatoria'),
        actions: [
          if (config.urlBoe != null) IconButton(tooltip: 'Convocatoria en el BOE', icon: const Icon(Icons.description_outlined), onPressed: () => abrirUrl(context, config.urlBoe)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: nuevoHito, icon: const Icon(Icons.add), label: const Text('Hito')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: Text('Pon la fecha de cada ejercicio, o la que estimes mientras no se conozca, para ver las cuentas atrás y planificar.', style: context.textos.bodySmall),
          ),
          const TituloSeccion('Ejercicios'),
          for (var ej = 1; ej <= 5; ej++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Tarjeta(
                padding: EdgeInsets.zero,
                onTap: () => fijar(ej),
                child: ListTile(
                  title: Text(nombreEjercicio(ej), style: context.textos.titleSmall),
                  subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(_descripciones[ej]!, style: context.textos.labelSmall),
                    Row(children: [
                      Flexible(child: Text(fechas[ej] == null ? 'Toca para poner la fecha' : formato.format(fechas[ej]!), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                    ]),
                  ]),
                  trailing: fechas[ej] == null
                      ? const Icon(Icons.edit_calendar_outlined)
                      : Row(mainAxisSize: MainAxisSize.min, children: [
                          cuenta(fechas[ej]!),
                          PopupMenuButton<String>(
                            onSelected: (v) => v == 'quitar' ? quitar(ej) : abrirUrl(context, Calendario.urlGoogle(eventoDeFecha('ej$ej', 'TCEE · ${nombreEjercicio(ej)}', fechas[ej]!))),
                            itemBuilder: (_) => [
                              const PopupMenuItem(value: 'google', child: Text('Añadir a Google Calendar')),
                              const PopupMenuItem(value: 'quitar', child: Text('Quitar la fecha')),
                            ],
                          ),
                        ]),
                ),
              ),
            ),
          if (hitos.isNotEmpty) const TituloSeccion('Hitos propios'),
          for (final h in hitos)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Tarjeta(
                padding: EdgeInsets.zero,
                child: ListTile(
                  leading: Icon(Icons.flag_outlined, color: context.colores.dorado),
                  title: Text(h.titulo, style: context.textos.titleSmall),
                  subtitle: Text(formato.format(h.fecha), style: context.textos.labelSmall),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    cuenta(h.fecha),
                    IconButton(icon: const Icon(Icons.close, size: 18), tooltip: 'Borrar', onPressed: () => notifier.actualizar((p) => p.copyWith(hitos: p.hitos.where((x) => x.id != h.id).toList()))),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
