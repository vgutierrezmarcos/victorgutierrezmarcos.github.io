import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/probabilidades.dart';
import '../plan/cante_page.dart';
import '../plan/cantes_util.dart';
import '../test/motor_test.dart';

/// Portada: cuentas atrás (examen y próximo cante), racha, test diario, temas
/// de la semana, probabilidad de aprobar, último artículo y accesos rápidos.
class InicioPage extends ConsumerWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ajustes = ref.watch(ajustesProvider);
    final config = ref.watch(configProvider).value;
    final usuario = ref.watch(usuarioActualProvider);
    final diarioHecho = ref.watch(testDiarioHechoProvider);
    final articulos = ref.watch(articulosProvider).value ?? [];
    final banco = ref.watch(preguntasProvider);
    final leitner = ref.watch(leitnerProvider);
    // Próxima fecha de examen: el primer ejercicio que aún no ha pasado.
    final fechas = ref.watch(fechasEjerciciosProvider).entries.where((e) => diasHasta(e.value) >= 0).toList()..sort((a, b) => a.value.compareTo(b.value));
    final proximo = fechas.firstOrNull;
    final fecha = proximo?.value;
    final dias = fecha == null ? null : diasHasta(fecha);
    final racha = ajustes.rachaVigente();
    final cante = ref.watch(proximosCantesProvider).firstOrNull;
    final crono = ref.watch(planProvider.select((p) => p.cronograma));
    final semana = crono.semanaDe(DateTime.now());
    final temasSemana = crono.deSemana(semana);
    final temario = ref.watch(temarioProvider).value;
    final prob = ref.watch(probabilidadAprobarProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario == null ? 'Oposición TCEE' : 'Hola, ${usuario.displayName?.split(' ').first ?? ''}'),
        actions: [
          IconButton(
            tooltip: 'Cuenta',
            icon: usuario?.photoURL != null ? CircleAvatar(radius: 14, backgroundImage: NetworkImage(usuario!.photoURL!)) : const Icon(Icons.account_circle_outlined),
            onPressed: () => context.push('/mas/cuenta'),
          ),
          IconButton(tooltip: 'Más: blog, comunidad, enlaces y ajustes', icon: const Icon(Icons.menu), onPressed: () => context.push('/mas')),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(configProvider);
          ref.invalidate(articulosProvider);
          ref.invalidate(historialProvider);
          ref.invalidate(temarioProvider);
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          children: [
            if (config != null && config.avisos.isNotEmpty)
              for (final a in config.avisos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(color: context.colores.dorado.withValues(alpha: 0.12), child: Row(children: [Icon(Icons.campaign_outlined, color: context.colores.dorado), const SizedBox(width: 10), Expanded(child: Text(a, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)))])),
                ),
            Row(children: [
              Expanded(
                child: Tarjeta(
                  onTap: () => context.go('/plan/convocatoria'),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.event_outlined, color: context.esquema.primary, size: 20),
                    const SizedBox(height: 6),
                    Text(dias == null ? '—' : '$dias', style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
                    Text(dias == null ? 'Fija la fecha del examen' : '${dias == 1 ? 'día' : 'días'} para el ${nombreEjercicio(proximo!.key).toLowerCase()}', style: context.textos.labelMedium),
                    if (fecha != null) Text(DateFormat('d MMM y', 'es').format(fecha), style: context.textos.labelSmall),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Estadistica(
                  valor: '$racha',
                  etiqueta: racha == 1 ? 'día de racha' : 'días de racha',
                  icono: Icons.local_fire_department_outlined,
                  color: racha > 0 ? context.colores.dorado : null,
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Tarjeta(
              onTap: cante == null ? () => context.go('/plan') : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: cante.id))),
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
            if (temasSemana.isNotEmpty) ...[
              TituloSeccion('Esta semana', accion: TextButton(onPressed: () => context.go('/plan/cronograma'), child: const Text('Cronograma'))),
              Tarjeta(
                onTap: () => context.go('/plan/cronograma'),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  for (final e in temasSemana)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(children: [
                        Icon(e.hecho ? Icons.check_circle : Icons.circle_outlined, size: 16, color: e.hecho ? Paleta.acierto : context.colores.textoClaro),
                        const SizedBox(width: 8),
                        Expanded(child: Text('${e.codigo} · ${temario?.tema(e.codigo)?.titulo ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                      ]),
                    ),
                  if (crono.desfase(DateTime.now()) < 0) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Llevas ${-crono.desfase(DateTime.now())} temas de retraso de semanas anteriores.', style: context.textos.labelSmall?.copyWith(color: Paleta.fallo))),
                ]),
              ),
            ],
            if (prob != null && prob.temasSabidos > 0) ...[
              const SizedBox(height: 10),
              Tarjeta(
                onTap: () => context.go('/cantar/probabilidades'),
                child: Row(children: [
                  Icon(Icons.percent, color: context.esquema.primary),
                  const SizedBox(width: 14),
                  Expanded(child: Text('Probabilidad de aprobar los ejercicios de temas con lo que llevas estudiado', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                  Text(porcentaje(prob.total), style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                ]),
              ),
            ],
            const TituloSeccion('Accesos rápidos'),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _acceso(context, Icons.quiz_outlined, 'Nuevo test', () => context.go('/test')),
                _acceso(context, Icons.casino_outlined, 'Sortear temas', () => context.go('/cantar')),
                _acceso(context, Icons.view_week_outlined, 'Cronograma', () => context.go('/plan/cronograma')),
                _acceso(context, Icons.insights_outlined, 'Estadísticas', () => context.go('/test/estadisticas')),
              ],
            ),
            if (articulos.isNotEmpty) ...[
              TituloSeccion('Último artículo', accion: TextButton(onPressed: () => context.push('/mas/blog'), child: const Text('Ver blog'))),
              Tarjeta(
                onTap: () => abrirUrl(context, articulos.first.url, enApp: true),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(articulos.first.titulo, style: context.textos.titleMedium),
                  if (articulos.first.fecha != null) Text(DateFormat('d MMMM y', 'es').format(articulos.first.fecha!), style: context.textos.labelSmall),
                  const SizedBox(height: 6),
                  Text(_sinHtml(articulos.first.descripcion), maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
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

String _sinHtml(String s) => s.replaceAll(RegExp(r'<[^>]+>'), '').replaceAll('&nbsp;', ' ').trim();
