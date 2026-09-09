import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Estadísticas: tarjetas, evolución de los últimos 15 tests, rendimiento por bloque y cajas Leitner.
class EstadisticasPage extends ConsumerWidget {
  const EstadisticasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historial = ref.watch(historialProvider);
    final leitner = ref.watch(leitnerProvider);
    final banco = ref.watch(preguntasProvider).value;
    final bloques = ref.watch(bloquesProvider).value ?? Bloques.vacio;

    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: historial.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(historialProvider)),
        data: (lista) {
          final tests = lista.where((r) => r.tipo != 'repaso').toList();
          if (tests.isEmpty) {
            return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Aún no has hecho ningún test.')));
          }
          final media = tests.map((r) => r.notaSobre10).reduce((a, b) => a + b) / tests.length;
          final mejor = tests.map((r) => r.notaSobre10).reduce((a, b) => a > b ? a : b);
          final totalPreg = tests.fold(0, (n, r) => n + r.totalPreguntas);
          final totalOk = tests.fold(0, (n, r) => n + r.correctas);
          // Tendencia: media de los últimos 3 frente a los 3 anteriores (como simulator-stats.js)
          String tendencia = '';
          if (tests.length >= 6) {
            final ult = tests.take(3).map((r) => r.notaSobre10).reduce((a, b) => a + b) / 3;
            final ant = tests.skip(3).take(3).map((r) => r.notaSobre10).reduce((a, b) => a + b) / 3;
            tendencia = ult > ant + 0.1 ? ' ↑' : (ult < ant - 0.1 ? ' ↓' : ' →');
          }
          final ultimos = tests.take(15).toList().reversed.toList();

          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(historialProvider),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    Estadistica(valor: '${tests.length}', etiqueta: 'Tests realizados', icono: Icons.fact_check_outlined),
                    Estadistica(valor: formatoNota(media) + tendencia, etiqueta: 'Nota media', icono: Icons.trending_up),
                    Estadistica(valor: formatoNota(mejor), etiqueta: 'Mejor nota', icono: Icons.emoji_events_outlined, color: context.colores.dorado),
                    Estadistica(valor: '${totalPreg == 0 ? 0 : (100 * totalOk / totalPreg).round()} %', etiqueta: 'Tasa de acierto', icono: Icons.percent),
                  ],
                ),
                const TituloSeccion('Evolución (últimos 15)'),
                Tarjeta(child: SizedBox(height: 180, child: _graficoEvolucion(context, ultimos))),
                if (banco != null && bloques.bloques.isNotEmpty) ...[
                  const TituloSeccion('Rendimiento por bloque'),
                  Tarjeta(child: _porBloque(context, tests, banco, bloques)),
                ],
                const TituloSeccion('Repaso Leitner'),
                Tarjeta(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${leitner.questions.length} preguntas en seguimiento · ${leitner.pendientes().length} pendientes · sesión ${leitner.sessionCount}', style: context.textos.bodySmall),
                    const SizedBox(height: 10),
                    Row(children: [
                      for (final e in leitner.porCaja.entries)
                        Expanded(
                          child: Column(children: [
                            Container(
                              height: 44,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: e.key == 5 ? Paleta.acierto.withValues(alpha: 0.15) : context.colores.primarioPalido,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('${e.value}', style: context.textos.titleMedium),
                            ),
                            const SizedBox(height: 4),
                            Text(e.key == 5 ? 'Dominadas' : 'Caja ${e.key}', style: context.textos.labelSmall),
                          ]),
                        ),
                    ]),
                  ]),
                ),
                const TituloSeccion('Historial'),
                Tarjeta(
                  padding: EdgeInsets.zero,
                  child: Column(children: [
                    for (final r in tests.take(30))
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: (r.notaSobre10 >= 5 ? Paleta.acierto : Paleta.fallo).withValues(alpha: 0.15),
                          child: Text(formatoNota(r.notaSobre10), style: context.textos.labelMedium?.copyWith(color: r.notaSobre10 >= 5 ? Paleta.acierto : Paleta.fallo)),
                        ),
                        title: Text(DateFormat('d MMM y, HH:mm', 'es').format(r.timestamp), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                        subtitle: Text('${r.correctas}/${r.totalPreguntas} aciertos · ${formatoTiempo(r.tiempoSeconds)}${r.origen == 'web' ? ' · web' : ''}${r.tipo == 'diario' ? ' · diario' : ''}', style: context.textos.labelSmall),
                        trailing: r.sincronizado ? null : Icon(Icons.cloud_upload_outlined, size: 18, color: context.colores.textoClaro),
                      ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _graficoEvolucion(BuildContext context, List<ResultadoTest> ultimos) {
    return BarChart(
      BarChartData(
        maxY: 10,
        minY: 0,
        gridData: FlGridData(show: true, horizontalInterval: 2.5, getDrawingHorizontalLine: (v) => FlLine(color: context.colores.bordeClaro, strokeWidth: 1)),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 28, interval: 2.5, getTitlesWidget: (v, _) => Text(v.toStringAsFixed(0), style: context.textos.labelSmall))),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        extraLinesData: ExtraLinesData(horizontalLines: [HorizontalLine(y: 5, color: context.colores.dorado, strokeWidth: 1, dashArray: [4, 4])]),
        barGroups: [
          for (var i = 0; i < ultimos.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: ultimos[i].notaSobre10.clamp(0, 10),
                width: 12,
                color: ultimos[i].notaSobre10 >= 5 ? context.esquema.primary : Paleta.fallo,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
              ),
            ]),
        ],
        barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(getTooltipItem: (g, _, rod, __) => BarTooltipItem(formatoNota(rod.toY), const TextStyle(color: Colors.white)))),
      ),
    );
  }

  /// Agrega aciertos por bloque usando `respuestas` (solo tests hechos en la app: la web no guarda el detalle).
  Widget _porBloque(BuildContext context, List<ResultadoTest> tests, BancoPreguntas banco, Bloques bloques) {
    final acum = <String, ({int ok, int total})>{};
    for (final r in tests) {
      r.respuestas.forEach((id, letra) {
        final p = banco.porId(id);
        if (p == null) return;
        final b = bloques.bloqueDe(p.tema);
        final prev = acum[b] ?? (ok: 0, total: 0);
        acum[b] = (ok: prev.ok + (letra != null && p.esCorrecta(letra) ? 1 : 0), total: prev.total + 1);
      });
    }
    if (acum.isEmpty) {
      return Text('Se calcula con los tests hechos en la app.', style: context.textos.bodySmall);
    }
    final entradas = acum.entries.toList()..sort((a, b) => (a.value.ok / a.value.total).compareTo(b.value.ok / b.value.total));
    return Column(children: [
      for (final e in entradas)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [
            Expanded(flex: 5, child: Text(e.key, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface), overflow: TextOverflow.ellipsis)),
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(value: e.value.ok / e.value.total, minHeight: 8, backgroundColor: context.colores.fondoClaro, color: e.value.ok / e.value.total >= 0.5 ? Paleta.acierto : Paleta.fallo),
              ),
            ),
            SizedBox(width: 52, child: Text('${(100 * e.value.ok / e.value.total).round()} %', textAlign: TextAlign.end, style: context.textos.labelMedium)),
          ]),
        ),
    ]);
  }
}
