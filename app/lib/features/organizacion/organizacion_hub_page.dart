import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../widgets/comunes.dart';
import '../cantar/probabilidades.dart';
import '../plan/cantes_util.dart';
import '../temario/tema_page.dart';
import 'probabilidad_test_page.dart';

/// Organización: lo que sirve para planificar la oposición, como la sección
/// «Organización» de la web. Tu plan (cronograma, probabilidades, convocatoria
/// y horario) y el temario visto desde arriba (estructura y documentos).
/// En la caja [Cajas.app]: «Más herramientas» abierto.
const claveMasHerramientas = 'mas_herramientas_abierto';

class OrganizacionHubPage extends ConsumerWidget {
  const OrganizacionHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oposicion = ref.watch(oposicionProvider);
    final cronograma = ref.watch(cronogramaProvider);
    final estado = ref.watch(estadoCronogramaProvider);
    final prob = ref.watch(probabilidadAprobarProvider);
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final fechas = ref.watch(fechasEjerciciosProvider).entries.where((e) => diasHasta(e.value) >= 0).toList()..sort((a, b) => a.value.compareTo(b.value));
    final proximo = fechas.firstOrNull;
    final documentos = temario?.organizacion ?? const <Recurso>[];
    final ultimo = (ref.watch(procesoProvider).valueOrNull ?? const []).expand((p) => p.novedades).firstOrNull;
    // «Cómo cantar un tema» suele estar ya entre los documentos de la web.
    final conComoCantar = documentos.any((r) => r.url == oposicion.urlComoCantarUnTema);

    final semana = estado?.semanaActual;
    final resumenCronograma = cronograma == null || estado == null
        ? 'Planifica una vuelta: genéralo o trae el tuyo'
        : estado.terminado
            ? 'Vuelta terminada'
            : semana == null
                ? '${estado.hechos.length} de ${estado.total} temas'
                : semana.descanso
                    ? 'Esta semana descansas · ${estado.hechos.length} de ${estado.total}'
                    : 'Esta semana: ${semana.temas.length} ${semana.temas.length == 1 ? 'tema' : 'temas'} · ${estado.hechos.length} de ${estado.total}';

    // El preparador no lleva un plan de estudio propio: sin cronograma,
    // horario ni mapa de calor propio (el de cada alumno está en su ficha).
    final preparador = ref.watch(papelProvider) == Papel.preparador;

    return Scaffold(
      appBar: const BarraWeb(title: Text('Organización'), conOposicion: true),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 32),
        children: [
          TituloSeccion(preparador ? 'La oposición' : 'Tu plan'),
          if (!preparador) FilaEnlace(
            icono: Icons.event_note_outlined,
            titulo: 'Cronograma',
            subtitulo: resumenCronograma,
            onTap: () => context.go('/organizacion/cronograma'),
          ),
          FilaEnlace(
            icono: Icons.gavel_outlined,
            titulo: 'Proceso selectivo',
            subtitulo: ultimo == null ? 'Lo que publica el Ministerio: listas, calendario, convocatorias…' : 'Lo último: ${ultimo.seccion.toLowerCase()} · ${ultimo.titulo}',
            onTap: () => context.go('/organizacion/proceso'),
          ),
          FilaEnlace(
            icono: Icons.flag_outlined,
            titulo: 'Convocatoria',
            subtitulo: proximo == null
                ? (preparador ? 'Las fechas de cada ejercicio' : 'Las fechas de cada ejercicio y tus propios hitos')
                : '${diasHasta(proximo.value)} ${diasHasta(proximo.value) == 1 ? 'día' : 'días'} para el ${nombreEjercicio(proximo.key).toLowerCase()}',
            onTap: () => context.go('/organizacion/convocatoria'),
          ),
          // Lo demás, plegado para no abrumar al principio (se recuerda abierto).
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key: const PageStorageKey('mas_herramientas'),
              initiallyExpanded: Hive.isBoxOpen(Cajas.app) && Hive.box(Cajas.app).get(claveMasHerramientas) == true,
              onExpansionChanged: (abierto) {
                if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put(claveMasHerramientas, abierto);
              },
              tilePadding: const EdgeInsets.symmetric(horizontal: 4),
              childrenPadding: EdgeInsets.zero,
              leading: Icon(Icons.handyman_outlined, color: Theme.of(context).colorScheme.primary),
              title: Text('Más herramientas', style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text(preparador ? 'Probabilidades y el temario desde arriba' : 'Probabilidades, horario, mapa de calor y el temario desde arriba', style: Theme.of(context).textTheme.bodySmall),
              children: [
              FilaEnlace(
                icono: Icons.percent,
                titulo: 'Probabilidades',
                subtitulo: preparador
                    ? 'Cuánto sube la probabilidad de que salga un tema con cada uno que se lleva'
                    : (prob == null || prob.temasSabidos == 0 ? 'Qué probabilidad tienes según los temas que te sabes' : 'De que salga un tema que llevas: ${porcentaje(prob.total)}'),
                onTap: () => context.go('/organizacion/probabilidades'),
              ),
              if (oposicion.esPrincipal)
                FilaEnlace(
                  icono: Icons.fact_check_outlined,
                  titulo: 'Probabilidad de aprobar el test',
                  subtitulo: 'Al azar, pregunta a pregunta o con tus temas, y qué temas caen más',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProbabilidadTestPage())),
                ),
              if (!preparador) FilaEnlace(
                icono: Icons.schedule_outlined,
                titulo: 'Horario de estudio',
                subtitulo: 'Las horas que dedicas a cada cosa, semana a semana',
                onTap: () => context.go('/organizacion/horario'),
              ),
              const TituloSeccion('El temario, desde arriba'),
              if (!preparador) FilaEnlace(
                icono: Icons.grid_view_rounded,
                titulo: 'Mapa de calor',
                subtitulo: 'Qué temas dominas y cuáles están flojos, de un vistazo',
                onTap: () => context.go('/organizacion/mapa-calor'),
              ),
              if (estructura != null && estructura.bloques.isNotEmpty)
                FilaEnlace(
                  icono: Icons.account_tree_outlined,
                  titulo: 'Mapa del temario',
                  subtitulo: 'Bloques por colores, esquemas y conexiones entre temas',
                  onTap: () => context.go('/organizacion/estructura'),
                ),
              if (!conComoCantar)
                FilaEnlace(
                  icono: Icons.record_voice_over_outlined,
                  titulo: 'Cómo cantar un tema',
                  subtitulo: 'Guía en PDF',
                  onTap: () => abrirUrl(context, oposicion.urlComoCantarUnTema),
                ),
              for (final r in documentos)
                FilaEnlace(
                  icono: switch (r.tipo) { 'pdf' => Icons.picture_as_pdf_outlined, 'app' => Icons.web, 'xlsm' => Icons.table_chart_outlined, _ => Icons.description_outlined },
                  titulo: r.titulo,
                  subtitulo: r.descripcion.isEmpty ? (r.tipo == 'pdf' ? 'PDF' : 'Se abre en la web') : r.descripcion,
                  onTap: () {
                    if (r.tipo == 'pdf') {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => TemaPage(tema: Tema(codigo: r.id, titulo: r.titulo, disponible: true, temarioAnterior: false, url: r.url), esRecurso: true)));
                    } else {
                      abrirUrl(context, r.url);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
