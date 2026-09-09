import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../test/motor_test.dart';

/// Portada: countdown, racha, test diario, último artículo y accesos rápidos.
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
    final fecha = ajustes.fechaConvocatoria ?? config?.fechaPrimerEjercicio;
    final dias = fecha?.difference(DateTime.now()).inDays;
    final racha = ajustes.rachaVigente();

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario == null ? 'Oposición TCEE' : 'Hola, ${usuario.displayName?.split(' ').first ?? ''}'),
        actions: [
          IconButton(
            icon: usuario?.photoURL != null ? CircleAvatar(radius: 14, backgroundImage: NetworkImage(usuario!.photoURL!)) : const Icon(Icons.account_circle_outlined),
            onPressed: () => context.go('/mas/cuenta'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(configProvider);
          ref.invalidate(articulosProvider);
          ref.invalidate(historialProvider);
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
                  onTap: () => _elegirFecha(context, ref, fecha),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.event_outlined, color: context.esquema.primary, size: 20),
                    const SizedBox(height: 6),
                    Text(dias == null ? '—' : (dias < 0 ? '0' : '$dias'), style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
                    Text(dias == null ? 'Fija la fecha del examen' : 'días para el primer ejercicio', style: context.textos.labelMedium),
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
                _acceso(context, Icons.menu_book_outlined, 'Temario', () => context.go('/temario')),
                _acceso(context, Icons.casino_outlined, 'Sortear temas', () => context.go('/cantar')),
                _acceso(context, Icons.insights_outlined, 'Estadísticas', () => context.go('/test/estadisticas')),
              ],
            ),
            if (articulos.isNotEmpty) ...[
              TituloSeccion('Último artículo', accion: TextButton(onPressed: () => context.go('/mas/blog'), child: const Text('Ver blog'))),
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

  Future<void> _elegirFecha(BuildContext context, WidgetRef ref, DateTime? actual) async {
    final f = await showDatePicker(
      context: context,
      initialDate: actual ?? DateTime.now().add(const Duration(days: 180)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      helpText: 'Fecha del primer ejercicio',
    );
    if (f != null) await ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(fechaConvocatoria: f));
  }
}

String _sinHtml(String s) => s.replaceAll(RegExp(r'<[^>]+>'), '').replaceAll('&nbsp;', ' ').trim();
