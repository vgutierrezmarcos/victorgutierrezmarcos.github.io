import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/avisos_breves.dart';
import '../core/providers.dart';

/// Sincronizar a mano: el botón de la cabecera (en las pestañas principales)
/// y el gesto de deslizar hacia abajo en las listas. Los dos hacen lo mismo
/// que «Sincronizar ahora» de la cuenta: traen de la nube lo del usuario (y
/// lo que le han puesto su preparador o sus alumnos) y vuelven a leer el
/// contenido de la web (configuración y temario).

/// Si hay una sincronización a mano en marcha (para que el botón gire).
final sincronizandoProvider = StateProvider<bool>((_) => false);

/// Sincroniza todo. Con [avisar], dice cómo ha ido en un SnackBar (el botón);
/// sin él, calla (el gesto de deslizar ya se ve).
Future<void> sincronizarAMano(BuildContext context, WidgetRef ref, {bool avisar = true}) async {
  if (ref.read(sincronizandoProvider)) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  ref.read(sincronizandoProvider.notifier).state = true;
  try {
    // El contenido de la web, con o sin sesión.
    ref.invalidate(configProvider);
    ref.invalidate(temarioProvider);
    if (ref.read(usuarioActualProvider) == null) {
      ref.invalidate(historialProvider);
      return;
    }
    final ok = await ref.read(sesionProvider.notifier).sincronizar();
    if (avisar) messenger?.mostrar(SnackBar(content: Text(ok ? 'Sincronizado con la nube' : 'No se ha podido sincronizar: comprueba la conexión')));
  } catch (_) {
    if (avisar) messenger?.mostrar(const SnackBar(content: Text('No se ha podido sincronizar: comprueba la conexión')));
  } finally {
    ref.read(sincronizandoProvider.notifier).state = false;
  }
}

/// Botón de sincronizar de la cabecera (solo con sesión): gira mientras trabaja.
class BotonSincronizar extends ConsumerWidget {
  const BotonSincronizar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(usuarioActualProvider) == null) return const SizedBox.shrink();
    final ocupado = ref.watch(sincronizandoProvider);
    return IconButton(
      tooltip: 'Sincronizar con la nube',
      icon: ocupado
          ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: IconTheme.of(context).color))
          : const Icon(Icons.sync),
      onPressed: ocupado ? null : () => sincronizarAMano(context, ref),
    );
  }
}

/// Deslizar hacia abajo sincroniza (el hijo debe ser una lista que siempre
/// se pueda desplazar, como [ListaAdaptable]).
class Refrescable extends ConsumerWidget {
  const Refrescable({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => RefreshIndicator(onRefresh: () => sincronizarAMano(context, ref, avisar: false), child: child);
}
