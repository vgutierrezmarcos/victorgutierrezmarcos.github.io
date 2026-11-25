import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../core/ia.dart';
import '../theme/app_theme.dart';
import 'comunes.dart';

String _dia(DateTime f) => DateFormat('d MMM', 'es').format(f.toLocal());

/// En qué IA está configurada EconomIA, dicho en una frase y su detalle
/// (Más → EconomIA y la hoja de la burbuja).
({String titulo, String detalle, bool lista}) estadoEconomia(EstadoIa estado, Map<Ia, DateTime> conexiones) {
  final elegida = iaElegida(estado, conexiones);
  if (elegida == null) return (titulo: 'Aún no has elegido tu IA', detalle: 'Elige abajo la que usas y conéctala con EconomIA.', lista: false);
  final uso = conexiones[elegida];
  if (uso != null) return (titulo: 'EconomIA está configurada en ${elegida.nombre}', detalle: 'Conectada · último uso el ${_dia(uso)}', lista: true);
  if (estado.aMano && estado.preferida == elegida) return (titulo: 'EconomIA está configurada en ${elegida.nombre}', detalle: 'La has marcado como conectada', lista: true);
  return (titulo: 'Has elegido ${elegida.nombre}, pero falta conectarla', detalle: 'Sigue los pasos de «Cómo se conecta» y toca «Ya lo he conectado».', lista: false);
}

/// La tarjeta con el estado de EconomIA: en qué IA está y si está conectada.
class EstadoEconomiaTarjeta extends ConsumerWidget {
  const EstadoEconomiaTarjeta({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = estadoEconomia(ref.watch(iaProvider), ref.watch(conectorProvider).valueOrNull ?? const {});
    return Tarjeta(
      color: e.lista ? context.colores.primarioPalido : null,
      child: Row(children: [
        Icon(e.lista ? Icons.check_circle_outline : Icons.auto_awesome_outlined, color: e.lista ? context.esquema.primary : context.colores.textoClaro, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.titulo, style: context.textos.titleSmall),
            const SizedBox(height: 2),
            Text(e.detalle, style: context.textos.labelSmall),
          ]),
        ),
      ]),
    );
  }
}

/// La lista para elegir IA (Claude, la recomendada, primero). Debajo de cada
/// una, si ya se ha usado con el conector, cuándo; si no, su nota.
class SelectorIa extends ConsumerWidget {
  const SelectorIa({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conexiones = ref.watch(conectorProvider).valueOrNull ?? const <Ia, DateTime>{};
    return RadioGroup<Ia>(
      groupValue: ref.watch(iaElegidaProvider),
      onChanged: (v) {
        if (v != null) ref.read(iaProvider.notifier).elegir(v);
      },
      child: GrupoFilas(children: [
        for (final ia in Ia.values)
          RadioListTile<Ia>(
            value: ia,
            title: Text(ia == Ia.claude ? '${ia.nombre} (recomendada)' : ia.nombre, style: context.textos.titleSmall),
            subtitle: Text(conexiones[ia] != null ? 'Conectada · último uso el ${_dia(conexiones[ia]!)}' : ia.nota, style: context.textos.labelSmall),
          ),
      ]),
    );
  }
}

/// La hoja que abre la burbuja mientras EconomIA no está configurada: elegir
/// IA, cómo conectarla y «Ya lo he conectado». Devuelve true si queda
/// configurada (la burbuja abre entonces su menú).
Future<bool> mostrarHojaConfigurarIa(BuildContext context) async {
  final r = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _HojaConfigurarIa(),
  );
  return r == true;
}

class _HojaConfigurarIa extends ConsumerWidget {
  const _HojaConfigurarIa();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elegida = ref.watch(iaElegidaProvider);
    final configurada = ref.watch(iaConfiguradaProvider);
    final notifier = ref.read(iaProvider.notifier);
    final router = GoRouter.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Espacio.e4, 0, Espacio.e4, Espacio.e4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
          Text('Configura EconomIA', style: context.textos.titleMedium),
          const SizedBox(height: 4),
          Text('Elige la IA que usas y conéctala. Después, esta burbuja la abrirá con el mensaje ya escrito: dudas del tema que estás leyendo, preguntas de repaso, tests…', style: context.textos.bodySmall),
          const SizedBox(height: 12),
          const SelectorIa(),
          const SizedBox(height: 12),
          if (configurada != null)
            FilledButton.icon(onPressed: () => Navigator.pop(context, true), icon: const Icon(Icons.check), label: Text('Listo: usar ${configurada.nombre}'))
          else if (elegida != null)
            Wrap(spacing: 8, runSpacing: 6, alignment: WrapAlignment.end, children: [
              OutlinedButton.icon(onPressed: () => abrirUrl(context, elegida.urlComoConectar), icon: const Icon(Icons.open_in_new, size: 18), label: const Text('Cómo se conecta')),
              FilledButton(
                onPressed: () async {
                  final nav = Navigator.of(context);
                  await notifier.conectadaAMano(true);
                  nav.pop(true);
                },
                child: const Text('Ya lo he conectado'),
              ),
            ]),
          const SizedBox(height: 4),
          Wrap(alignment: WrapAlignment.spaceBetween, children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                router.go('/mas/economia');
              },
              child: const Text('Más opciones de EconomIA'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                notifier.mostrarBurbuja(false);
              },
              child: Text('Ocultar la burbuja', style: TextStyle(color: context.colores.textoSuave)),
            ),
          ]),
        ]),
      ),
    );
  }
}
