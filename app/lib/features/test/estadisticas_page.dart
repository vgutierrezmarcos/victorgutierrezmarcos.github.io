import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/texto_formulas.dart';
import 'motor_test.dart';
import 'resultados_page.dart';

/// Estadísticas: tarjetas, evolución de los últimos 15 tests, rendimiento por bloque y cajas Leitner.
class EstadisticasPage extends ConsumerWidget {
  const EstadisticasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historial = ref.watch(historialProvider);
    final leitner = ref.watch(leitnerProvider);
    final banco = ref.watch(preguntasProvider).valueOrNull;
    final bloques = ref.watch(bloquesProvider).valueOrNull ?? Bloques.vacio;

    return Scaffold(
      appBar: BarraWeb(title: const Text('Estadísticas')),
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
            child: ListaAdaptable(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
              children: [
                GridView.count(
                  crossAxisCount: MediaQuery.sizeOf(context).width >= 720 ? 4 : 2,
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
                if (banco != null) ...[
                  const TituloSeccion('Acierto por tema'),
                  Tarjeta(child: _porTema(context, tests, banco)),
                  const TituloSeccion('Las que más fallas'),
                  Tarjeta(child: _masFalladas(context, tests, banco)),
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
                        // Con el detalle (tests de la app) se vuelve a revisar pregunta a pregunta.
                        onTap: banco == null || !r.conDetalle ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ResultadosPage(datos: DatosResultado.deHistorial(r, banco)))),
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: (r.notaSobre10 >= 5 ? Paleta.acierto : Paleta.fallo).withValues(alpha: 0.15),
                          child: Text(formatoNota(r.notaSobre10), style: context.textos.labelMedium?.copyWith(color: r.notaSobre10 >= 5 ? Paleta.acierto : Paleta.fallo)),
                        ),
                        title: Text(DateFormat('d MMM y, HH:mm', 'es').format(r.timestamp), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                        subtitle: Text('${r.correctas}/${r.totalPreguntas} aciertos · ${formatoTiempo(r.tiempoSeconds)}${r.origen == 'web' ? ' · web' : ''}${r.tipo == 'diario' ? ' · diario' : ''}${r.conDetalle ? '' : ' · sin detalle'}', style: context.textos.labelSmall),
                        trailing: !r.sincronizado ? Icon(Icons.cloud_upload_outlined, size: 18, color: context.colores.textoClaro) : (r.conDetalle && banco != null ? const Icon(Icons.chevron_right, size: 20) : null),
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

  /// Acierto por tema (tests de la app), de peor a mejor: los 15 peores con
  /// al menos 3 respuestas; cada fila abre un test de ese tema.
  Widget _porTema(BuildContext context, List<ResultadoTest> tests, BancoPreguntas banco) {
    const minimo = 3;
    final acum = MotorTest.aciertoPorTema(tests, banco).entries.where((e) => e.value.total >= minimo).toList()
      ..sort((a, b) => (a.value.ok / a.value.total).compareTo(b.value.ok / b.value.total));
    if (acum.isEmpty) {
      return Text('Se calcula con los tests hechos en la app, a partir de $minimo respuestas por tema.', style: context.textos.bodySmall);
    }
    final peores = acum.take(15).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(acum.length > peores.length ? 'Los ${peores.length} temas con peor acierto (de ${acum.length} con datos). Toca uno para hacer un test de sus preguntas.' : 'De peor a mejor. Toca un tema para hacer un test de sus preguntas.', style: context.textos.labelSmall),
      const SizedBox(height: 6),
      for (final e in peores)
        InkWell(
          onTap: () => context.push('/examen', extra: ConfigTest(temas: {e.key}, numPreguntas: 20, minutos: 0)),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(children: [
              Expanded(flex: 5, child: TextoTema(e.key, banco.temas[e.key] ?? '')),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: e.value.ok / e.value.total, minHeight: 8, backgroundColor: context.colores.fondoClaro, color: e.value.ok / e.value.total >= 0.5 ? Paleta.acierto : Paleta.fallo),
                ),
              ),
              SizedBox(width: 64, child: Text('${(100 * e.value.ok / e.value.total).round()} % · ${e.value.total}', textAlign: TextAlign.end, style: context.textos.labelMedium)),
            ]),
          ),
        ),
    ]);
  }

  /// Las diez preguntas más falladas, con «Hacer test con ellas».
  Widget _masFalladas(BuildContext context, List<ResultadoTest> tests, BancoPreguntas banco) {
    final lista = MotorTest.masFalladas(tests, banco).take(10).toList();
    if (lista.isEmpty) {
      return Text('Todavía no has fallado ninguna pregunta en los tests hechos en la app.', style: context.textos.bodySmall);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      for (final f in lista)
        Builder(builder: (context) {
          final p = banco.porId(f.id)!;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: 44, child: Text('${f.fallos}/${f.intentos}', style: context.textos.labelMedium?.copyWith(color: Paleta.fallo))),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  TextoConFormulas(p.enunciado, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                  Text('${p.tema} · ${p.examen}', style: context.textos.labelSmall),
                ]),
              ),
            ]),
          );
        }),
      const SizedBox(height: 6),
      Align(
        alignment: Alignment.centerLeft,
        child: FilledButton.tonalIcon(
          onPressed: () => context.push('/examen', extra: ConfigTest(idsFijos: [for (final f in lista) f.id], minutos: 0, modoEstudio: true)),
          icon: const Icon(Icons.replay, size: 18),
          label: const Text('Hacer test con ellas (corrigiendo cada una)'),
        ),
      ),
    ]);
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
