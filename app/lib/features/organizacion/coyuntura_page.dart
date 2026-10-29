import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/coyuntura.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/sincronizar.dart';

/// Periodo visto de cada indicador (id → periodo), para marcar los datos nuevos.
Map<String, String> periodosVistosCoyuntura() {
  if (!Hive.isBoxOpen(Cajas.app)) return const {};
  final m = Hive.box(Cajas.app).get(claveCoyunturaVista);
  return m is Map ? {for (final e in m.entries) e.key.toString(): e.value.toString()} : const {};
}

Future<void> _marcarVistos(Coyuntura c) async {
  if (!Hive.isBoxOpen(Cajas.app) || c.sinDatos) return;
  await Hive.box(Cajas.app).put(claveCoyunturaVista, {for (final i in c.indicadores) i.id: i.periodo});
}

/// Una línea para la fila de entrada: «IPC 5,0 % (sept.) · paro 10,0 % · 2 datos nuevos».
String resumenCoyuntura(Coyuntura c) {
  if (c.sinDatos) return 'PIB, precios, paro, déficit, deuda, tipos… con la zona del euro al lado';
  String? de(String id) {
    final i = c.indicadores.where((x) => x.id == id).firstOrNull;
    return i == null ? null : cifraCoyuntura(i.valor, decimales: decimalesCoyuntura(i));
  }
  final nuevos = c.nuevos(periodosVistosCoyuntura()).length;
  return [
    if (de('pib_ia') case final v?) 'PIB $v %',
    if (de('ipca') case final v?) 'IPCA $v %',
    if (de('paro') case final v?) 'paro $v %',
    if (nuevos > 0) '$nuevos ${nuevos == 1 ? 'dato nuevo' : 'datos nuevos'}',
  ].join(' · ');
}

/// Cuadro de coyuntura de España para el dictamen: último dato, cambio, zona
/// del euro, serie corta y cuándo sale el siguiente; y «Tápalo y adivina»
/// para memorizar las cifras.
class CoyunturaPage extends ConsumerStatefulWidget {
  const CoyunturaPage({super.key});
  @override
  ConsumerState<CoyunturaPage> createState() => _CoyunturaPageState();
}

class _CoyunturaPageState extends ConsumerState<CoyunturaPage> {
  bool _tapar = false;
  final _destapados = <String>{};
  late final Map<String, String> _vistosAlEntrar = periodosVistosCoyuntura();
  bool _marcado = false;

  @override
  Widget build(BuildContext context) {
    final c = ref.watch(coyunturaProvider);
    return Scaffold(
      appBar: BarraWeb(title: const Text('Cuadro de coyuntura')),
      body: c.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(coyunturaProvider)),
        data: (c) {
          if (c.sinDatos) return const VacioVista(icono: Icons.query_stats, texto: 'Sin datos todavía: el cuadro se descarga de la web; vuelve a intentarlo con conexión.');
          if (!_marcado) {
            _marcado = true;
            WidgetsBinding.instance.addPostFrameCallback((_) => _marcarVistos(c));
          }
          final nuevos = {for (final i in c.nuevos(_vistosAlEntrar)) i.id};
          return Refrescable(
            child: ListaAdaptable(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              children: [
                Text(
                  'España, con la zona del euro al lado. Datos de Eurostat y del Banco Central Europeo, que se actualizan solos cada día${c.actualizado == null ? '' : ' (última comprobación: ${DateFormat("d MMM., HH:mm", 'es').format(c.actualizado!.toLocal())})'}.',
                  style: context.textos.bodySmall,
                ),
                const SizedBox(height: 6),
                Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text('Tápalo y adivina', style: context.textos.titleSmall),
                    subtitle: Text('Las cifras salen tapadas: di de memoria cada una y toca para comprobarla.', style: context.textos.labelSmall),
                    value: _tapar,
                    onChanged: (v) => setState(() {
                      _tapar = v;
                      _destapados.clear();
                    }),
                  ),
                ),
                for (final g in c.porGrupo.entries) ...[
                  TituloSeccion(g.key),
                  for (final i in g.value)
                    _TarjetaIndicador(
                      indicador: i,
                      nuevo: nuevos.contains(i.id),
                      tapado: _tapar && !_destapados.contains(i.id),
                      alDestapar: () => setState(() => _destapados.add(i.id)),
                    ),
                ],
                const SizedBox(height: 8),
                Text('El «siguiente dato» es aproximado (el final del próximo periodo más lo que suele tardar cada fuente). Para el dictamen, contrasta con la fuente nacional (INE, Banco de España, IGAE).', style: context.textos.labelSmall),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TarjetaIndicador extends StatelessWidget {
  const _TarjetaIndicador({required this.indicador, required this.nuevo, required this.tapado, required this.alDestapar});
  final IndicadorCoyuntura indicador;
  final bool nuevo, tapado;
  final VoidCallback alDestapar;

  @override
  Widget build(BuildContext context) {
    final i = indicador;
    final dec = decimalesCoyuntura(i);
    final unidad = i.unidad == '%' ? ' %' : ' ${i.unidad}';
    final cambio = i.cambio;
    final siguiente = i.siguiente;
    return Tarjeta(
      onTap: tapado ? alDestapar : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Text(i.nombre, style: context.textos.titleSmall)),
          if (nuevo) Etiqueta('Dato nuevo', color: context.colores.dorado),
        ]),
        const SizedBox(height: 4),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
            child: tapado
                ? Text('Toca para ver la cifra (${i.etiqueta})', style: context.textos.bodyMedium?.copyWith(color: context.esquema.primary, fontStyle: FontStyle.italic))
                : Text.rich(TextSpan(children: [
                    TextSpan(text: cifraCoyuntura(i.valor, decimales: dec), style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
                    TextSpan(text: '$unidad · ${i.etiqueta}', style: context.textos.bodySmall),
                  ])),
          ),
          if (!tapado && i.serie.length >= 3) SizedBox(width: 96, height: 36, child: _Minigrafico(i.serie.map((e) => e.$2).toList())),
        ]),
        if (!tapado) ...[
          const SizedBox(height: 2),
          Text(
            [
              if (cambio != null) '${cambio > 0.005 ? '▲' : cambio < -0.005 ? '▼' : '='} ${cifraCoyuntura(cambio.abs(), decimales: dec)} frente al dato anterior',
              if (i.referenciaValor != null) '${i.referenciaNombre}: ${cifraCoyuntura(i.referenciaValor!, decimales: dec)}',
              if (i.primaRiesgo != null) 'prima de riesgo: ${i.primaRiesgo} p. b.',
            ].join(' · '),
            style: context.textos.labelSmall,
          ),
        ],
        const SizedBox(height: 4),
        Text(i.nota, style: context.textos.bodySmall),
        Text(
          '${i.fuente}${siguiente == null ? '' : ' · siguiente dato hacia el ${DateFormat("d 'de' MMMM", 'es').format(siguiente)}'}',
          style: context.textos.labelSmall,
        ),
      ]),
    );
  }
}

class _Minigrafico extends StatelessWidget {
  const _Minigrafico(this.valores);
  final List<double> valores;

  @override
  Widget build(BuildContext context) {
    final color = context.esquema.primary;
    return LineChart(LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineTouchData: const LineTouchData(enabled: false),
      lineBarsData: [
        LineChartBarData(
          spots: [for (var k = 0; k < valores.length; k++) FlSpot(k.toDouble(), valores[k])],
          isCurved: false,
          color: color,
          barWidth: 1.6,
          dotData: FlDotData(show: true, checkToShowDot: (s, _) => s.x == valores.length - 1, getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(radius: 2.4, color: color, strokeWidth: 0)),
        ),
      ],
    ));
  }
}
