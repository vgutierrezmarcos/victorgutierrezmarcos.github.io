import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../cronograma/cronograma_page.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/probabilidades.dart';
import '../plan/cante_page.dart';
import '../plan/cantes_util.dart';
import '../test/motor_test.dart';

/// Hoy: lo que toca cada día. Cuentas atrás (examen y próximo cante), racha,
/// test diario, repaso pendiente, probabilidad de aprobar y accesos rápidos.
class InicioPage extends ConsumerWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ajustes = ref.watch(ajustesProvider);
    final config = ref.watch(configProvider).value;
    final usuario = ref.watch(usuarioActualProvider);
    final diarioHecho = ref.watch(testDiarioHechoProvider);
    final banco = ref.watch(preguntasProvider);
    final leitner = ref.watch(leitnerProvider);
    // Próxima fecha de examen: el primer ejercicio que aún no ha pasado.
    final fechas = ref.watch(fechasEjerciciosProvider).entries.where((e) => diasHasta(e.value) >= 0).toList()..sort((a, b) => a.value.compareTo(b.value));
    final proximo = fechas.firstOrNull;
    final fecha = proximo?.value;
    final dias = fecha == null ? null : diasHasta(fecha);
    final racha = ajustes.rachaVigente();
    final cante = ref.watch(proximosCantesProvider).firstOrNull;
    final prob = ref.watch(probabilidadAprobarProvider);
    final versionNueva = ref.watch(actualizacionProvider).value;
    // Preparador: sus sesiones de hoy con alumnos.
    final hoy = DateTime.now();
    final sesionesHoy = ref.watch(perfilPreparadorProvider).activo
        ? ref.watch(sesionesProvider).where((s) => s.pendiente && s.fecha.year == hoy.year && s.fecha.month == hoy.month && s.fecha.day == hoy.day).toList()
        : const <Cante>[];
    final nombres = {for (final a in ref.watch(alumnosProvider)) a.id: a.nombre};

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Oposición TCEE'),
        subtitulo: usuario == null ? 'Técnico Comercial y Economista del Estado' : 'Hola, ${usuario.displayName?.split(' ').first ?? ''}',
        actions: [
          IconButton(
            tooltip: 'Cuenta',
            icon: usuario != null ? const AvatarUsuario(radio: 14) : const Icon(Icons.account_circle_outlined),
            onPressed: () => context.go('/mas/cuenta'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(configProvider);
          ref.invalidate(historialProvider);
          ref.invalidate(temarioProvider);
          // Con sesión, trae también lo nuevo de la nube (p. ej. un cante que ha puesto el preparador).
          if (usuario != null) await ref.read(sesionProvider.notifier).sincronizar();
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            if (versionNueva != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Tarjeta(
                  color: context.colores.primarioPalido,
                  child: Row(children: [
                    Icon(Icons.system_update_outlined, color: context.esquema.primary, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Hay una versión nueva ($versionNueva)', style: context.textos.titleMedium),
                        Text('Se instala encima de la actual, sin perder tus datos.', style: context.textos.bodySmall),
                      ]),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(onPressed: () => abrirUrl(context, config?.urlPlayStore ?? config?.urlApk), child: const Text('Actualizar')),
                  ]),
                ),
              ),
            if (config != null && config.avisos.isNotEmpty)
              for (final a in config.avisos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(color: context.colores.dorado.withValues(alpha: 0.12), child: Row(children: [Icon(Icons.campaign_outlined, color: context.colores.dorado), const SizedBox(width: 10), Expanded(child: Text(a, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)))])),
                ),
            IntrinsicHeight(
              child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Expanded(
                  child: Estadistica(
                    onTap: () => context.go('/mas/convocatoria'),
                    valor: dias == null ? '—' : '$dias',
                    etiqueta: dias == null ? 'Fija la fecha del examen' : '${dias == 1 ? 'día' : 'días'} para el ${nombreEjercicio(proximo!.key).toLowerCase()}',
                    detalle: fecha == null ? null : DateFormat('d MMM y', 'es').format(fecha),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Estadistica(
                    valor: '$racha',
                    etiqueta: racha == 1 ? 'día de racha' : 'días de racha',
                    color: racha > 0 ? context.colores.dorado : null,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Tarjeta(
              onTap: cante == null ? () => _irACantes(context, ref, 0) : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: cante.id))),
              child: Row(children: [
                Icon(Icons.record_voice_over_outlined, color: context.esquema.primary, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(cante == null ? 'Sin cantes programados' : 'Próximo cante ${cuentaAtras(cante.fecha)}', style: context.textos.titleMedium),
                    Text(cante == null ? 'Apunta cuándo es el siguiente para tener la cuenta atrás y un aviso.' : '${fechaLarga(cante.fecha)}, ${horaDe(cante.fecha)} · ${descripcionBolsa(cante)}', style: context.textos.bodySmall),
                  ]),
                ),
                const Icon(Icons.chevron_right),
              ]),
            ),
            const SizedBox(height: 10),
            Tarjeta(
              color: diarioHecho ? null : context.colores.primarioPalido,
              onTap: diarioHecho || banco.value == null
                  ? null
                  : () {
                      final ids = MotorTest.testDiario(banco.value!, DateTime.now()).map((p) => p.id).toList();
                      context.push('/examen', extra: ConfigTest(idsFijos: ids, minutos: 15, tipo: 'diario'));
                    },
              child: Row(children: [
                Icon(diarioHecho ? Icons.check_circle : Icons.today, color: diarioHecho ? Paleta.acierto : context.esquema.primary, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Test diario', style: context.textos.titleMedium),
                    Text(diarioHecho ? 'Hecho. ¡Hasta mañana!' : '10 preguntas oficiales, las mismas para todos hoy. 15 minutos.', style: context.textos.bodySmall),
                  ]),
                ),
                if (!diarioHecho) const Icon(Icons.chevron_right),
              ]),
            ),
            TarjetaCronogramaHoy(abrir: () => context.go('/temario/cronograma')),
            if (sesionesHoy.isNotEmpty) ...[
              const SizedBox(height: 10),
              Tarjeta(
                onTap: () => context.go('/mas/preparador'),
                child: Row(children: [
                  Icon(Icons.groups_outlined, color: context.esquema.primary, size: 32),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(sesionesHoy.length == 1 ? 'Hoy tienes 1 sesión con tus alumnos' : 'Hoy tienes ${sesionesHoy.length} sesiones con tus alumnos', style: context.textos.titleMedium),
                      Text([for (final s in sesionesHoy) '${horaDe(s.fecha)} ${nombres[s.alumno] ?? ''}'.trim()].join(' · '), maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                    ]),
                  ),
                  const Icon(Icons.chevron_right),
                ]),
              ),
            ],
            if (leitner.pendientes().isNotEmpty) ...[
              const SizedBox(height: 10),
              Tarjeta(
                onTap: () => context.push('/examen', extra: ConfigTest(idsFijos: leitner.pendientes(), minutos: 0, tipo: 'repaso')),
                child: Row(children: [
                  Icon(Icons.replay, color: context.esquema.primary),
                  const SizedBox(width: 14),
                  Expanded(child: Text('${leitner.pendientes().length} preguntas pendientes de repaso', style: context.textos.bodyMedium)),
                  const Icon(Icons.chevron_right),
                ]),
              ),
            ],
            if (prob != null && prob.temasSabidos > 0) ...[
              const SizedBox(height: 10),
              Tarjeta(
                onTap: () => context.go('/temario/probabilidades'),
                child: Row(children: [
                  Icon(Icons.percent, color: context.esquema.primary),
                  const SizedBox(width: 14),
                  Expanded(child: Text('Probabilidad de que salga un tema que llevas con los temas que llevas estudiados', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                  const SizedBox(width: 12),
                  Text(porcentaje(prob.total), style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                ]),
              ),
            ],
            const TituloSeccion('Accesos rápidos'),
            GridView.count(
              // En pantalla ancha (ordenador) van los cuatro en una fila.
              crossAxisCount: MediaQuery.sizeOf(context).width >= 720 ? 4 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _acceso(context, Icons.quiz_outlined, 'Nuevo test', () => context.go('/test')),
                _acceso(context, Icons.casino_outlined, 'Sortear temas', () => _irACantes(context, ref, 1)),
                _acceso(context, Icons.percent, 'Probabilidades', () => context.go('/temario/probabilidades')),
                _acceso(context, Icons.insights_outlined, 'Estadísticas', () => context.go('/test/estadisticas')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Abre el bloque Cantes en una de sus subpestañas (0 agenda, 1 cantar, 2 diario).
  void _irACantes(BuildContext context, WidgetRef ref, int subpestana) {
    ref.read(subpestanaCantesProvider.notifier).state = subpestana;
    context.go('/cantes');
  }

  Widget _acceso(BuildContext context, IconData icono, String texto, VoidCallback onTap) => Tarjeta(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(children: [
          Icon(icono, color: context.esquema.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(texto, style: context.textos.titleSmall)),
        ]),
      );

}
