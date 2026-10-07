import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../core/red_providers.dart';
import '../data/models/oposicion.dart';
import '../features/inicio/elegir_oposicion.dart';
import '../theme/app_theme.dart';

/// Elegir otra oposición. Los datos de cada una se quedan guardados.
Future<void> elegirOtraOposicion(BuildContext context, WidgetRef ref) async {
  final actual = ref.read(oposicionProvider);
  final visibles = ref.read(oposicionesVisiblesProvider).valueOrNull ?? Oposiciones.disponibles;
  final nueva = await showDialog<Oposicion>(
    context: context,
    builder: (d) => AlertDialog(
      title: const Text('¿A qué te presentas?'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          for (final o in visibles)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TarjetaOposicion(oposicion: o, elegida: o.id == actual.id, onTap: () => Navigator.pop(d, o)),
            ),
          Text('Cada una tiene su temario, sus cantes, sus tests y sus preparadores. Lo que lleves en ${actual.siglas} se queda guardado y vuelve si cambias otra vez.', style: Theme.of(d).textTheme.bodySmall),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar'))],
    ),
  );
  if (nueva == null || nueva.id == actual.id) return;
  await ref.read(cambiarOposicionProvider)(nueva);
}

/// Arriba a la izquierda en la cabecera de las cinco pestañas: las siglas de
/// la oposición actual con el icono de cambiar, para pasar a otra con un
/// toque. Solo si se puede elegir entre varias.
class BotonOposicion extends ConsumerWidget {
  const BotonOposicion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibles = ref.watch(oposicionesVisiblesProvider).valueOrNull ?? Oposiciones.disponibles;
    if (visibles.length < 2) return const SizedBox.shrink();
    final siglas = ref.watch(oposicionProvider).siglas;
    return Tooltip(
      message: 'Cambiar de oposición',
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => elegirOtraOposicion(context, ref),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.swap_horiz, color: Colors.white, size: 22),
            Text(siglas, maxLines: 1, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: Colors.white)),
          ]),
        ),
      ),
    );
  }
}
