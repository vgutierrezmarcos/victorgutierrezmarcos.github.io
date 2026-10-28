import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/fases.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../escrito/escritos.dart';
import 'cronograma_widgets.dart';
import 'fases.dart';

/// Las fases de un cronograma por fases (ejercicio escrito): en cuál está,
/// sus fechas y lo que toca en ella (temas de la primera vuelta, simulacros
/// o los temas flojos de la semana con el porqué).
class PanelFases extends ConsumerWidget {
  const PanelFases({super.key, required this.c});
  final Cronograma c;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cfg = ref.watch(fasesCronogramaProvider) ?? const FasesEscrito();
    final flojos = ref.watch(flojosEscritoProvider);
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final hoy = DateTime.now();
    final actual = c.faseEn(hoy);
    final examen = c.examen;
    final deSemana = actual?.tipo == TipoFase.revision ? flojosDeSemana(flojos, cfg) : const <TemaFlojo>[];

    void simulacro() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SimulacroEscritoPage(ejercicio: c.ejercicio, minutos: cfg.minutosSimulacro)));

    return Tarjeta(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(actual == null ? 'Fases hasta el examen' : actual.tipo.nombre, style: context.textos.titleMedium),
        if (actual != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(actual.tipo.explicacion, style: context.textos.bodySmall)),
        const SizedBox(height: 10),
        for (final f in c.fases)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(children: [
              Icon(
                f.saltada ? Icons.remove_circle_outline : (identical(f, actual) ? Icons.radio_button_checked : (f.fin.isBefore(hoy) ? Icons.check_circle_outline : Icons.radio_button_unchecked)),
                size: 18,
                color: identical(f, actual) ? context.esquema.primary : context.esquema.outline,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  f.saltada ? '${f.tipo.nombre}: te la saltas' : '${f.tipo.nombre}: del ${fechaLargaCrono(f.inicio)} al ${fechaLargaCrono(f.fin)} (${f.semanas} ${f.semanas == 1 ? 'semana' : 'semanas'})',
                  style: context.textos.bodySmall?.copyWith(fontWeight: identical(f, actual) ? FontWeight.w600 : null),
                ),
              ),
            ]),
          ),
        if (examen != null) Text('Examen: ${diaSemanaYMes(examen)}', style: context.textos.labelSmall),
        if (actual?.tipo == TipoFase.simulacros || actual?.tipo == TipoFase.revision) ...[
          const SizedBox(height: 10),
          Text(
            cfg.simulacrosPorSemana == 1 ? 'Esta semana: un simulacro.' : 'Esta semana: ${cfg.simulacrosPorSemana} simulacros.',
            style: context.textos.bodyMedium,
          ),
        ],
        if (deSemana.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text('Temas flojos para volver a escribir esta semana', style: context.textos.labelLarge),
          const SizedBox(height: 4),
          for (final f in deSemana)
            InkWell(
              onTap: () => apuntarTemaEscrito(context, ref, ejercicio: c.ejercicio, tema: f.codigo),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TextoTema(f.codigo, temario?.tema(f.codigo)?.titulo ?? '', color: estructura?.colorDe(f.codigo), maxLines: 1),
                  Text(f.explicacion, style: context.textos.labelSmall),
                ]),
              ),
            ),
          if (flojos.length > deSemana.length)
            Text('Hay ${flojos.length} temas flojos; entran primero los peor valorados y los que hace más que no escribes.', style: context.textos.labelSmall),
        ] else if (actual?.tipo == TipoFase.revision)
          Padding(padding: const EdgeInsets.only(top: 8), child: Text('No tienes temas flojos: sigue con los simulacros.', style: context.textos.bodySmall)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          if (actual?.tipo != TipoFase.vuelta) FilledButton.icon(onPressed: simulacro, icon: const Icon(Icons.timer_outlined), label: const Text('Hacer un simulacro')),
          OutlinedButton.icon(onPressed: () => apuntarTemaEscrito(context, ref, ejercicio: c.ejercicio), icon: const Icon(Icons.edit_note), label: const Text('Apuntar un tema escrito')),
          if (actual?.tipo == TipoFase.vuelta) TextButton.icon(onPressed: simulacro, icon: const Icon(Icons.timer_outlined), label: const Text('Simulacro')),
        ]),
        if (actual?.tipo == TipoFase.vuelta)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Según avanzas, escribe cada tema al menos una vez y apúntalo: así la app sabe cuáles llevas flojos.', style: context.textos.labelSmall),
          ),
      ]),
    );
  }
}
