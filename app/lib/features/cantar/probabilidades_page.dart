import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'probabilidades.dart';
import 'sorteo.dart';

/// Probabilidades de que salga un tema que te sabes, calculadas como en el
/// Excel "Estrategia y organización": por ejercicio, por tema estudiado,
/// eficiencia, consejo de reparto entre partes y probabilidad de aprobar.
class ProbabilidadesPage extends ConsumerStatefulWidget {
  const ProbabilidadesPage({super.key});
  @override
  ConsumerState<ProbabilidadesPage> createState() => _ProbabilidadesPageState();
}

class _ProbabilidadesPageState extends ConsumerState<ProbabilidadesPage> {
  /// Simulación "¿y si me supiera…?": temas sabidos por parte ("3.A" → n).
  final Map<String, int> _simulados = {};

  @override
  Widget build(BuildContext context) {
    final porParte = ref.watch(temasPorParteProvider);
    final temario = ref.watch(temarioProvider);
    final config = ref.watch(configProvider).value ?? AppConfig.porDefecto;
    final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));

    List<ParteSorteo> partes(int ej) => partesDeEjercicio(ej, porParte: porParte, estudiados: estudiados, config: config, sabidos: _simulados);
    final ejercicios = [for (final ej in ejerciciosConSorteo) if (partes(ej).isNotEmpty) ej];
    final probs = {for (final ej in ejercicios) ej: Sorteo.probEjercicio(partes(ej), elegir: config.partesARedactar[ej])};
    final total = ProbabilidadAprobar(porEjercicio: probs, temasSabidos: ejercicios.fold(0, (s, ej) => s + partes(ej).fold(0, (x, p) => x + p.sabidos)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Probabilidades'),
        actions: [if (_simulados.isNotEmpty) TextButton(onPressed: () => setState(_simulados.clear), child: const Text('Mis temas'))],
      ),
      body: temario.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider)),
        data: (t) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          children: [
            Tarjeta(
              color: context.colores.primarioPalido,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_simulados.isEmpty ? 'Con los temas que llevas estudiados' : 'Simulación', style: context.textos.labelMedium),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(porcentaje(total.total), style: context.textos.displaySmall?.copyWith(color: context.esquema.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: Padding(padding: const EdgeInsets.only(bottom: 6), child: Text('de aprobar los tres ejercicios de temas', style: context.textos.bodySmall))),
                ]),
                Text('${total.temasSabidos} temas · ${porcentaje(total.porTema, decimales: 2)} por tema estudiado. Supone pasar el test, la coyuntura y los idiomas.', style: context.textos.labelSmall),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Text('Mueve los deslizadores para ver qué pasaría si te supieras más o menos temas de cada parte.', style: context.textos.bodySmall),
            ),
            for (final ej in ejercicios) ..._ejercicio(context, ej, t, partes(ej), config),
          ],
        ),
      ),
    );
  }

  List<Widget> _ejercicio(BuildContext context, int ej, Temario t, List<ParteSorteo> partes, AppConfig config) {
    final elegir = config.partesARedactar[ej];
    final p = Sorteo.probEjercicio(partes, elegir: elegir);
    final eficiencia = Sorteo.eficiencia(partes, elegir: elegir);
    final nombres = t.ejercicios.firstWhere((e) => e.id == ej).partes;
    final siguiente = Sorteo.siguienteParte(partes, elegir: elegir);
    final consejo = partes.length == 2 ? Sorteo.consejo(partes[0], partes[1]) : Consejo.ninguno;
    final bolas = config.bolasPorParte[ej] ?? 2;

    return [
      TituloSeccion(nombreEjercicio(ej)),
      Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Text(
                elegir == null ? 'Salen $bolas temas de cada parte y hay que saberse al menos uno de cada una.' : 'Sale $bolas tema de cada parte y se desarrollan $elegir de las ${partes.length}.',
                style: context.textos.bodySmall,
              ),
            ),
            const SizedBox(width: 10),
            Text(porcentaje(p), style: context.textos.headlineSmall?.copyWith(color: p >= 0.9 ? Paleta.acierto : (p >= 0.6 ? context.colores.dorado : Paleta.fallo))),
          ]),
          const SizedBox(height: 6),
          for (var i = 0; i < partes.length; i++)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('Parte ${nombres[i].letra}: ${nombres[i].nombre}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelMedium)),
                Text('${partes[i].sabidos} de ${partes[i].total} · ${porcentaje(Sorteo.probParte(partes[i]), decimales: 0)}', style: context.textos.labelMedium?.copyWith(color: context.esquema.onSurface)),
              ]),
              Slider(
                value: partes[i].sabidos.toDouble(),
                max: partes[i].total.toDouble(),
                divisions: partes[i].total,
                label: '${partes[i].sabidos}',
                onChanged: (v) => setState(() => _simulados['$ej.${nombres[i].letra}'] = v.round()),
              ),
            ]),
          const Divider(),
          Row(children: [
            Expanded(child: _dato(context, 'Por tema estudiado', porcentaje(Sorteo.porTema(partes, elegir: elegir), decimales: 2))),
            Expanded(child: _dato(context, 'Eficiencia', porcentaje(eficiencia, decimales: 0))),
          ]),
          if (consejo != Consejo.ninguno || siguiente != null) const SizedBox(height: 8),
          if (consejo != Consejo.ninguno)
            _aviso(context, Icons.swap_horiz, consejo == Consejo.cambiarAporB ? 'Con los mismos temas, te rendiría más cambiar uno de la parte A por uno de la parte B.' : 'Con los mismos temas, te rendiría más cambiar uno de la parte B por uno de la parte A.'),
          if (siguiente != null) _aviso(context, Icons.trending_up, 'El siguiente tema que más sube tu probabilidad es uno de la parte ${nombres[siguiente].letra}.'),
          if (partes.length == 2) ...[
            const SizedBox(height: 10),
            Text('Probabilidad según los temas de cada parte', style: context.textos.labelMedium),
            const SizedBox(height: 6),
            AspectRatio(
              aspectRatio: (partes[0].total + 1) / (partes[1].total + 1),
              child: CustomPaint(
                painter: _MapaCalor(a: partes[0], b: partes[1], marcador: context.esquema.onSurface, base: context.esquema.primary, fondo: context.colores.fondoClaro),
              ),
            ),
            const SizedBox(height: 4),
            Text('Horizontal: temas de la parte A. Vertical: temas de la parte B. Cuanto más oscuro, más probabilidad; el punto eres tú.', style: context.textos.labelSmall),
          ],
        ]),
      ),
    ];
  }

  Widget _dato(BuildContext context, String etiqueta, String valor) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(valor, style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
        Text(etiqueta, style: context.textos.labelSmall),
      ]);

  Widget _aviso(BuildContext context, IconData icono, String texto) => Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icono, size: 16, color: context.colores.dorado),
          const SizedBox(width: 8),
          Expanded(child: Text(texto, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
        ]),
      );
}

/// Tabla del Excel dibujada como mapa de calor: columnas = temas sabidos de la
/// parte A, filas = de la parte B (0 abajo).
class _MapaCalor extends CustomPainter {
  _MapaCalor({required this.a, required this.b, required this.marcador, required this.base, required this.fondo});
  final ParteSorteo a;
  final ParteSorteo b;
  final Color marcador;
  final Color base;
  final Color fondo;

  @override
  void paint(Canvas canvas, Size size) {
    final ancho = size.width / (a.total + 1), alto = size.height / (b.total + 1);
    final pincel = Paint();
    for (var y = 0; y <= b.total; y++) {
      for (var x = 0; x <= a.total; x++) {
        pincel.color = Color.lerp(fondo, base, Sorteo.probEjercicio([a.con(x), b.con(y)]))!;
        canvas.drawRect(Rect.fromLTWH(x * ancho, size.height - (y + 1) * alto, ancho + 0.5, alto + 0.5), pincel);
      }
    }
    final centro = Offset((a.sabidos + 0.5) * ancho, size.height - (b.sabidos + 0.5) * alto);
    canvas.drawCircle(centro, 6, Paint()..color = Colors.white);
    canvas.drawCircle(centro, 4, Paint()..color = marcador);
  }

  @override
  bool shouldRepaint(_MapaCalor old) => old.a.sabidos != a.sabidos || old.b.sabidos != b.sabidos || old.base != base || old.fondo != fondo;
}
