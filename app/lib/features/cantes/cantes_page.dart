import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/comunes.dart';
import '../cantar/cantar_page.dart';
import '../plan/diario_page.dart';
import '../plan/plan_page.dart';

/// Cantes: todo lo que rodea a cantar un tema, en tres subpestañas que siguen
/// el orden natural: Agenda (cuándo), Cantar (sorteo y cronómetro) y Diario
/// (cómo fue).
class CantesPage extends ConsumerStatefulWidget {
  const CantesPage({super.key});
  @override
  ConsumerState<CantesPage> createState() => _CantesPageState();
}

class _CantesPageState extends ConsumerState<CantesPage> with SingleTickerProviderStateMixin {
  late final TabController _pestanas = TabController(length: 3, vsync: this, initialIndex: ref.read(subpestanaCantesProvider));

  @override
  void dispose() {
    _pestanas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indice = ref.watch(subpestanaCantesProvider);
    // Otras pantallas cambian de subpestaña (p. ej. «Sacar bola y cantar» desde un cante).
    ref.listen(subpestanaCantesProvider, (_, i) {
      if (_pestanas.index != i) _pestanas.animateTo(i);
    });

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Cantes'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'exportar':
                  await exportarCalendario(context, ref);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'exportar', child: Text(kIsWeb ? 'Descargar para tu calendario (.ics)' : 'Exportar al calendario del móvil')),
            ],
          ),
        ],
        bottom: barraPestanas(context, controller: _pestanas, textos: const ['AGENDA', 'CANTAR', 'DIARIO'], onTap: (i) => ref.read(subpestanaCantesProvider.notifier).state = i),
      ),
      // IndexedStack y no TabBarView: el cronómetro sigue vivo al mirar la agenda o el diario.
      body: IndexedStack(
        index: indice,
        children: const [AgendaCantesVista(), CantarPage(), DiarioVista()],
      ),
    );
  }
}
