import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/comunes.dart';
import '../cantar/cantar_page.dart';
import '../plan/diario_page.dart';
import '../plan/plan_page.dart';
import '../preparador/semana_page.dart';
import '../../data/models/preparador.dart';

/// Cantes: todo lo que rodea a cantar un tema, en tres subpestañas que siguen
/// el orden natural: Agenda (cuándo), Cantar (sacar bola y cronómetro) y Diario
/// (cómo fue). Al preparador: Clases (su semana con sus alumnos) y Cantar.
class CantesPage extends ConsumerStatefulWidget {
  const CantesPage({super.key});
  @override
  ConsumerState<CantesPage> createState() => _CantesPageState();
}

class _CantesPageState extends ConsumerState<CantesPage> with TickerProviderStateMixin {
  TabController? _controlador;

  /// El número de subpestañas cambia con el papel: se rehace el controlador.
  TabController _pestanas(int n, int indice) {
    if (_controlador?.length != n) {
      _controlador?.dispose();
      _controlador = TabController(length: n, vsync: this, initialIndex: indice);
    }
    return _controlador!;
  }

  @override
  void dispose() {
    _controlador?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preparador = ref.watch(papelProvider) == Papel.preparador;
    // El preparador no tiene diario propio: dos subpestañas.
    final n = preparador ? 2 : 3;
    final indice = ref.watch(subpestanaCantesProvider).clamp(0, n - 1);
    final pestanas = _pestanas(n, indice);
    // Otras pantallas cambian de subpestaña (p. ej. «Sacar bola y cantar» desde un cante).
    ref.listen(subpestanaCantesProvider, (_, i) {
      final j = i.clamp(0, (_controlador?.length ?? 1) - 1);
      if (_controlador != null && _controlador!.index != j) _controlador!.animateTo(j);
    });

    return Scaffold(
      appBar: BarraWeb(
        conOposicion: true,
        title: const Text('Cantes'),
        actions: [
          if (!preparador) PopupMenuButton<String>(
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
        bottom: barraPestanas(context, controller: pestanas, textos: preparador ? const ['CLASES', 'CANTAR'] : const ['AGENDA', 'CANTAR', 'DIARIO'], onTap: (i) => ref.read(subpestanaCantesProvider.notifier).state = i),
      ),
      // IndexedStack y no TabBarView: el cronómetro sigue vivo al mirar la agenda o el diario.
      body: IndexedStack(
        index: indice,
        children: preparador ? const [SemanaPage(embebida: true), CantarPage()] : const [AgendaCantesVista(), CantarPage(), DiarioVista()],
      ),
    );
  }
}
