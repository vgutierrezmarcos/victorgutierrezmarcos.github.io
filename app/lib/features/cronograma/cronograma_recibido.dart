import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/cronograma_providers.dart';
import '../../data/models/cronograma.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cronograma_widgets.dart';
import 'planificador.dart';

/// Cronogramas que le han mandado sus preparadores al opositor: una tarjeta
/// por cada uno, que lleva a verlo y aceptarlo o rechazarlo.
class TarjetasCronogramasRecibidos extends ConsumerWidget {
  const TarjetasCronogramasRecibidos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recibidos = ref.watch(cronogramasRecibidosProvider).valueOrNull ?? const <CronogramaRecibido>[];
    return Column(children: [
      for (final r in recibidos)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Tarjeta(
            color: context.colores.primarioPalido,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CronogramaRecibidoPage(recibido: r))),
            child: Row(children: [
              Icon(Icons.forward_to_inbox_outlined, color: context.esquema.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${r.deNombre.isEmpty ? 'Tu preparador' : r.deNombre} te ha mandado un cronograma', style: context.textos.titleSmall),
                  Text('${r.cronograma.temas.length} temas desde el ${fechaLargaCrono(r.cronograma.inicio)}. Toca para verlo y decidir si lo usas.', style: context.textos.labelSmall),
                ]),
              ),
              const Icon(Icons.chevron_right),
            ]),
          ),
        ),
    ]);
  }
}

/// Un cronograma recibido: la nota del preparador, el resumen y sus semanas,
/// con «Usarlo» (pasa a ser el activo; el que hubiera se archiva) o «No».
class CronogramaRecibidoPage extends ConsumerStatefulWidget {
  const CronogramaRecibidoPage({super.key, required this.recibido});
  final CronogramaRecibido recibido;
  @override
  ConsumerState<CronogramaRecibidoPage> createState() => _CronogramaRecibidoPageState();
}

class _CronogramaRecibidoPageState extends ConsumerState<CronogramaRecibidoPage> {
  bool _ocupado = false;

  Future<void> _responder(bool aceptar) async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (aceptar && ref.read(cronogramaProvider) != null) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Ya tienes un cronograma'),
          content: const Text('Solo hay uno activo: el que tienes ahora se archivará y podrás seguir viéndolo más abajo en la pantalla del cronograma.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Usar el nuevo')),
          ],
        ),
      );
      if (ok != true) return;
    }
    setState(() => _ocupado = true);
    try {
      await responderCronogramaRecibido(ref, widget.recibido, aceptar: aceptar);
      messenger.mostrar(SnackBar(content: Text(aceptar ? 'Ya es tu cronograma. Lo compartes con tus preparadores, que pueden proponerte cambios.' : 'Descartado.')));
      nav.pop();
    } catch (_) {
      if (mounted) setState(() => _ocupado = false);
      messenger.mostrar(const SnackBar(content: Text('No se pudo. Revisa la conexión.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recibido;
    final c = r.cronograma;
    final estado = estadoDe(c, DateTime.now());
    final de = r.deNombre.isEmpty ? 'Tu preparador' : r.deNombre;
    return Scaffold(
      appBar: const BarraWeb(title: Text('Cronograma recibido')),
      body: ListaAdaptable(children: [
        const SizedBox(height: 10),
        Text('$de te lo ha mandado el ${fechaLargaCrono(r.enviado)}.', style: context.textos.bodyMedium),
        if (r.nota.isNotEmpty) ...[
          const SizedBox(height: 8),
          Tarjeta(child: Text('«${r.nota}»', style: context.textos.bodyMedium?.copyWith(fontStyle: FontStyle.italic))),
        ],
        const SizedBox(height: 10),
        ResumenCronograma(c: c, estado: estado),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: _ocupado ? null : () => _responder(false), child: const Text('No lo quiero'))),
          const SizedBox(width: 10),
          Expanded(child: FilledButton(onPressed: _ocupado ? null : () => _responder(true), child: const Text('Usarlo'))),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('Si lo usas, lo compartes con $de, que podrá verlo y proponerte cambios. Después puedes retocarlo como cualquier otro.', style: context.textos.labelSmall),
        ),
        const TituloSeccion('Semanas'),
        SemanasCronograma(c: c, estado: estado),
      ]),
    );
  }
}
