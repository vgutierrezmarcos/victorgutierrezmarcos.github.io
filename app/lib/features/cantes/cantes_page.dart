import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
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
    final avisos = ref.watch(planProvider.select((p) => p.avisosCante));
    // Otras pantallas cambian de subpestaña (p. ej. «Sortear y cantar» desde un cante).
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
                case 'avisos':
                  await alternarAvisosCante(ref);
                case 'ayuda':
                  abrirUrl(context, Urls.comoCantarUnTema);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'exportar', child: Text(kIsWeb ? 'Descargar para tu calendario (.ics)' : 'Exportar al calendario del móvil')),
              if (Notificaciones.disponibles) CheckedPopupMenuItem(value: 'avisos', checked: avisos, child: const Text('Avisar antes de cada cante')),
              const PopupMenuItem(value: 'ayuda', child: Text('Cómo cantar un tema (PDF)')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _pestanas,
          onTap: (i) => ref.read(subpestanaCantesProvider.notifier).state = i,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
          indicatorColor: context.colores.dorado,
          indicatorWeight: 3,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.8),
          unselectedLabelStyle: const TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.8),
          tabs: const [Tab(text: 'AGENDA'), Tab(text: 'CANTAR'), Tab(text: 'DIARIO')],
        ),
      ),
      // IndexedStack y no TabBarView: el cronómetro sigue vivo al mirar la agenda o el diario.
      body: IndexedStack(
        index: indice,
        children: const [AgendaCantesVista(), CantarPage(), DiarioVista()],
      ),
    );
  }
}
