import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/comunes.dart';
import '../cantar/cantar_page.dart';
import 'nuevo_cante_sheet.dart';
import '../plan/diario_page.dart';
import '../plan/plan_page.dart';
import '../preparador/semana_page.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';

/// Cantes: todo lo que rodea a cantar un tema, en tres subpestañas que siguen
/// el orden natural: Agenda (cuándo), Cantar (sacar bola y cronómetro) y Diario
/// (cómo fue). Al preparador: Clases (su semana con sus alumnos) y Cantar. Las
/// subpestañas son botones ([BotonesPestanas]) bajo la cabecera.
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
    _pestanas(n, indice);
    // Las cifras de los botones: cantes que vienen, cantes hechos y, al preparador, clases próximas.
    final hoy = DateTime.now();
    final inicioHoy = DateTime(hoy.year, hoy.month, hoy.day);
    final cantes = ref.watch(cantesProvider);
    final proximos = cantes.where((c) => !c.borrado && c.estado == EstadoCante.pendiente && !c.fecha.isBefore(inicioHoy)).length;
    final hechos = cantes.where((c) => !c.borrado && c.hecho).length;
    final proximas = preparador ? ref.watch(sesionesProvider).where((c) => !c.borrado && c.estado == EstadoCante.pendiente && !c.fecha.isBefore(inicioHoy)).length : 0;
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
          IconButton(tooltip: 'Para qué sirve cada parte', icon: const Icon(Icons.help_outline), onPressed: () => mostrarAyudasCantes(ref)),
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
      ),
      body: Column(children: [
        BotonesPestanas(
          indice: indice,
          onCambiar: (i) => ref.read(subpestanaCantesProvider.notifier).state = i,
          pestanas: preparador
              ? [
                  PestanaBoton(texto: 'Clases', icono: Icons.school_outlined, cifra: proximas > 0 ? cifraEs(proximas) : null, descripcion: 'Clases con tus alumnos${proximas > 0 ? ': $proximas próximas' : ''}'),
                  const PestanaBoton(texto: 'Cantar', icono: Icons.mic_none, descripcion: 'Sacar bola y cronómetro'),
                ]
              : [
                  PestanaBoton(texto: 'Agenda', icono: Icons.event_note_outlined, cifra: proximos > 0 ? cifraEs(proximos) : null, descripcion: 'Agenda de cantes${proximos > 0 ? ': $proximos próximos' : ''}'),
                  const PestanaBoton(texto: 'Cantar', icono: Icons.mic_none, descripcion: 'Sacar bola y cronómetro'),
                  PestanaBoton(texto: 'Diario', icono: Icons.history, cifra: hechos > 0 ? cifraEs(hechos) : null, descripcion: 'Diario de cantes${hechos > 0 ? ': $hechos hechos' : ''}'),
                ],
        ),
        // IndexedStack y no TabBarView: el cronómetro sigue vivo al mirar la agenda o el diario.
        Expanded(
          child: IndexedStack(
            index: indice,
            children: preparador ? const [SemanaPage(embebida: true), CantarPage()] : const [AgendaCantesVista(), CantarPage(), DiarioVista()],
          ),
        ),
      ]),
    );
  }
}
