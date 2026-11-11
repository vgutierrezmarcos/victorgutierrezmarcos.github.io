import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// «Cómo les ha ido hoy a los demás»: el agregado anónimo del test diario,
/// con la posición de [miNota] y un histograma; si el opositor no aporta su
/// nota, la invitación a activarlo. Solo tras el test diario y en Hoy.
class TarjetaReto extends ConsumerWidget {
  const TarjetaReto({super.key, required this.miNota, this.compacta = false});
  final int miNota;
  final bool compacta;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aporta = ref.watch(ajustesProvider.select((a) => a.aportarReto));
    final conSesion = ref.watch(usuarioActualProvider) != null;
    if (!aporta) {
      if (compacta || !conSesion) return const SizedBox.shrink();
      return Tarjeta(
        onTap: () => context.go('/mas'),
        child: Row(children: [
          Icon(Icons.groups_outlined, color: context.esquema.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('¿Cómo les ha ido hoy a los demás?', style: context.textos.titleSmall),
              Text('Activa «Aportar mi nota del test diario» en Más → Ajustes: verás cuántos lo han hecho hoy, la media y tu posición. Nunca nombres ni ranking.', style: context.textos.labelSmall),
            ]),
          ),
          const Icon(Icons.chevron_right),
        ]),
      );
    }
    final reto = ref.watch(retoDiarioProvider);
    return reto.when(
      loading: () => compacta ? const SizedBox.shrink() : const Padding(padding: EdgeInsets.all(8), child: Center(child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)))),
      error: (_, __) => const SizedBox.shrink(),
      data: (r) {
        if (r == null) return const SizedBox.shrink();
        if (compacta) return Text(r.texto(miNota), style: context.textos.labelSmall);
        final max = r.cubos.isEmpty ? 0 : r.cubos.reduce((a, b) => a > b ? a : b);
        return Tarjeta(
          color: context.colores.primarioPalido,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(Icons.groups_outlined, color: context.esquema.primary),
              const SizedBox(width: 10),
              Expanded(child: Text('Hoy, los demás', style: context.textos.titleMedium)),
            ]),
            const SizedBox(height: 4),
            Text(r.texto(miNota), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            if (r.suficiente && max > 0) ...[
              const SizedBox(height: 8),
              // Histograma 0-10, con mi nota marcada en dorado.
              SizedBox(
                height: 44,
                child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  for (var n = 0; n <= 10; n++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Container(
                            height: 4 + 30 * (r.cubos[n] / max),
                            decoration: BoxDecoration(color: n == miNota ? context.colores.dorado : context.esquema.primary.withValues(alpha: 0.45), borderRadius: BorderRadius.circular(2)),
                          ),
                          Text('$n', style: context.textos.labelSmall?.copyWith(fontSize: 9)),
                        ]),
                      ),
                    ),
                ]),
              ),
            ],
            const SizedBox(height: 4),
            Text('Solo cifras agregadas: nadie ve a nadie.', style: context.textos.labelSmall),
          ]),
        );
      },
    );
  }
}
