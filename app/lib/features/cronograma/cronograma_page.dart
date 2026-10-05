import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/cronograma.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cronograma_form_page.dart';
import 'cronograma_manual_page.dart';
import 'importar_cronograma.dart';
import '../../widgets/selector_temas.dart';
import 'cronograma_widgets.dart';
import 'planificador.dart';

/// Cronograma de la vuelta en curso: progreso, retraso con
/// replanificación, semanas con sus temas, propuestas del preparador y ajustes.
class CronogramaPage extends ConsumerWidget {
  const CronogramaPage({super.key});

  /// Tres formas de empezar uno: generarlo, hacerlo semana a semana o traer el propio.
  Future<void> _nuevo(BuildContext context) async {
    final ir = Navigator.of(context);
    final w = await showModalBottomSheet<Widget>(
      context: context,
      showDragHandle: true,
      builder: (d) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(leading: const Icon(Icons.auto_awesome_outlined), title: const Text('Generarlo'), subtitle: const Text('Eliges temas y ritmo; la app propone el orden'), onTap: () => Navigator.pop(d, const CronogramaFormPage())),
          ListTile(leading: const Icon(Icons.edit_calendar_outlined), title: const Text('Semana a semana'), subtitle: const Text('Pones tú los temas de cada cante'), onTap: () => Navigator.pop(d, const CronogramaManualPage())),
          ListTile(leading: const Icon(Icons.upload_file), title: const Text('Traer el tuyo'), subtitle: const Text('Desde un Excel, un Word, un PDF o un texto'), onTap: () => Navigator.pop(d, const ImportarCronogramaPage())),
          const SizedBox(height: 8),
        ]),
      ),
    );
    if (w != null) ir.push(MaterialPageRoute(builder: (_) => w));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(cronogramaProvider);
    final estado = ref.watch(estadoCronogramaProvider);
    final archivados = ref.watch(cronogramasArchivadosProvider);
    final notifier = ref.read(cronogramaProvider.notifier);
    final vinculos = ref.watch(misPreparadoresProvider);

    if (c == null || estado == null) {
      return Scaffold(
        appBar: BarraWeb(title: const Text('Cronograma')),
        body: ListaAdaptable(children: [
          const SizedBox(height: 10),
          Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Planifica una vuelta al temario', style: context.textos.titleMedium),
              const SizedBox(height: 4),
              Text(
                'Genéralo (eliges ${Oposiciones.actual.conCronograma.map((e) => 'el ${e.corto}').join(' o ')}, los temas y el ritmo, y la app propone un orden por bloques y conexiones), hazlo semana a semana o trae el tuyo desde un Excel, un Word o un PDF. Cada semana te dice lo que toca.',
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 12),
              FilledButton.icon(onPressed: () => _nuevo(context), icon: const Icon(Icons.event_note), label: const Text('Crear un cronograma')),
            ]),
          ),
          if (archivados.isNotEmpty) ...[
            const TituloSeccion('Cronogramas anteriores'),
            for (final a in archivados) _filaArchivado(context, ref, a),
          ],
        ]),
      );
    }

    final esta = inicioSemana(DateTime.now(), c.diaCante);
    final finObjetivo = c.fin ?? estado.fin ?? DateTime.now();
    final ritmoNecesario = ritmoPara(estado.pendientes, esta, finObjetivo, c.descansos, diaCante: c.diaCante);
    final finConRitmo = finEstimado(estado.pendientes, esta, c.temasPorSemana, c.descansos, diaCante: c.diaCante);
    final p = c.propuesta;

    Future<void> cambiarRitmo() async {
      final r = await elegirRitmo(context, pendientes: estado.pendientes, porSemana: c.temasPorSemana, fin: c.fin, descansos: c.descansos, diaCante: c.diaCante);
      if (r != null) await notifier.replanificar(porSemana: r.porSemana, fin: r.fin);
    }

    Future<void> reordenar() async {
      final orden = await Navigator.of(context).push<List<String>>(MaterialPageRoute(builder: (_) => ReordenarTemasPage(c: c, hechos: estado.hechos)));
      if (orden != null) await notifier.reordenar(orden);
    }

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Cronograma'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'ritmo':
                  await cambiarRitmo();
                case 'orden':
                  await reordenar();
                case 'nuevo':
                  if (context.mounted) _nuevo(context);
                case 'archivar':
                  await notifier.archivar();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'ritmo', child: Text(c.manual ? 'Repartir lo pendiente a un ritmo fijo' : 'Cambiar el ritmo o la fecha de fin')),
              if (!c.manual) const PopupMenuItem(value: 'orden', child: Text('Cambiar el orden de los temas')),
              const PopupMenuItem(value: 'nuevo', child: Text('Empezar otro cronograma')),
              const PopupMenuItem(value: 'archivar', child: Text('Archivar este cronograma')),
            ],
          ),
        ],
      ),
      body: ListaAdaptable(children: [
        const SizedBox(height: 10),
        ResumenCronograma(c: c, estado: estado),
        if (p != null) ...[
          const SizedBox(height: 10),
          Tarjeta(
            color: context.colores.primarioPalido,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${p.nombre.isEmpty ? 'Tu preparador' : p.nombre} te propone cambios', style: context.textos.titleMedium),
              const SizedBox(height: 4),
              Text(
                [
                  p.fin != null ? 'Acabar el ${fechaLargaCrono(p.fin!)}' : '${p.temasPorSemana} temas por semana',
                  if (p.temas.join() != c.temas.join()) 'con otro orden de temas',
                ].join(', '),
                style: context.textos.bodySmall,
              ),
              if (p.nota.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('«${p.nota}»', style: context.textos.bodyMedium?.copyWith(fontStyle: FontStyle.italic))),
              const SizedBox(height: 10),
              Wrap(spacing: 10, children: [
                FilledButton(onPressed: notifier.aceptarPropuesta, child: const Text('Aceptar')),
                TextButton(onPressed: notifier.rechazarPropuesta, child: const Text('Rechazar')),
              ]),
            ]),
          ),
        ],
        if (estado.atrasados.isNotEmpty) ...[
          const SizedBox(height: 10),
          Tarjeta(
            color: context.esquema.errorContainer.withValues(alpha: 0.35),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Vas ${estado.atrasados.length} ${estado.atrasados.length == 1 ? 'tema' : 'temas'} por detrás', style: context.textos.titleMedium),
              const SizedBox(height: 4),
              Text('Puedes repartir lo pendiente desde esta semana:', style: context.textos.bodySmall),
              const SizedBox(height: 8),
              // Si cabe sin cambiar nada, una sola opción; si no, elegir entre ritmo y fecha.
              if (ritmoNecesario == c.temasPorSemana && !finConRitmo.isAfter(finObjetivo))
                FilledButton.tonal(
                  onPressed: () => notifier.replanificar(porSemana: c.temasPorSemana),
                  child: Text('Repartirlo desde esta semana (sigues acabando el ${fechaLargaCrono(finObjetivo)})'),
                )
              else ...[
                FilledButton.tonal(
                  onPressed: () => notifier.replanificar(fin: finObjetivo),
                  child: Text('Mantener la fecha de fin (${fechaLargaCrono(finObjetivo)}): $ritmoNecesario por semana'),
                ),
                const SizedBox(height: 6),
                OutlinedButton(
                  onPressed: () => notifier.replanificar(porSemana: c.temasPorSemana),
                  child: Text('Mantener ${c.temasPorSemana} por semana: acabar el ${fechaLargaCrono(finConRitmo)}'),
                ),
              ],
            ]),
          ),
        ],
        TituloSeccion('Semanas', accion: c.manual ? null : TextButton.icon(onPressed: reordenar, icon: const Icon(Icons.swap_vert, size: 18), label: const Text('Orden'))),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Text('Mantén pulsado un tema para moverlo de semana o quitarlo.', style: context.textos.labelSmall),
        ),
        SemanasCronograma(
          c: c,
          estado: estado,
          onMarcar: (t, hecho) => notifier.marcar(t, hecho: hecho),
          onDescanso: (s, descansar) => notifier.descanso(s.lunes, descansar: descansar),
          onRetocar: (t, s) => _retocar(context, ref, c, t, s),
          onTemas: (s) => _temasDeSemana(context, ref, s),
        ),
        Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: notifier.semanaMas, icon: const Icon(Icons.add, size: 18), label: const Text('Una semana más'))),
        const TituloSeccion('Ajustes'),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('Ritmo'),
              subtitle: Text(c.fin != null ? 'Acabar el ${fechaLargaCrono(c.fin!)}' : '${c.temasPorSemana} temas por semana', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
              onTap: cambiarRitmo,
            ),
            if (vinculos.isNotEmpty)
              SwitchListTile(
                secondary: const Icon(Icons.share_outlined),
                value: c.compartir,
                onChanged: notifier.compartir,
                title: const Text('Compartirlo con mi preparador'),
                subtitle: Text('Lo verá y podrá proponerte cambios. Desactivado, no lo ve nadie.', style: context.textos.labelSmall),
              ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
          child: Text('Marcar un tema como hecho lo da por estudiado y anota una vuelta en su agenda. Una vuelta anotada desde el tema también cuenta aquí.', style: context.textos.labelSmall),
        ),
        if (archivados.isNotEmpty) ...[
          const TituloSeccion('Cronogramas anteriores'),
          for (final a in archivados) _filaArchivado(context, ref, a),
        ],
      ]),
    );
  }

  /// Mover un tema a otra semana (de las que quedan) o quitarlo.
  Future<void> _retocar(BuildContext context, WidgetRef ref, Cronograma c, String tema, SemanaPlan semana) async {
    final notifier = ref.read(cronogramaProvider.notifier);
    final esta = inicioSemana(DateTime.now(), c.diaCante);
    final destinos = c.semanas.where((s) => s.lunes != semana.lunes && !s.descanso && !s.lunes.isBefore(esta)).toList();
    final r = await showModalBottomSheet<Object>(
      context: context,
      showDragHandle: true,
      builder: (d) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 8), child: Text('Tema $tema', style: Theme.of(d).textTheme.titleMedium)),
          for (final s in destinos)
            ListTile(
              leading: const Icon(Icons.drive_file_move_outline),
              title: Text('Mover al ${c.diaCante == null ? 'semana del ${diaMes(s.lunes)}' : 'cante del ${diaSemanaYMes(s.domingo)}'}'),
              onTap: () => Navigator.pop(d, s.lunes),
            ),
          ListTile(leading: const Icon(Icons.remove_circle_outline), title: const Text('Quitarlo del cronograma'), onTap: () => Navigator.pop(d, 'quitar')),
        ]),
      ),
    );
    if (r is DateTime) await notifier.mover(tema, r);
    if (r == 'quitar') await notifier.quitar(tema);
  }

  Future<void> _temasDeSemana(BuildContext context, WidgetRef ref, SemanaPlan s) async {
    final temario = ref.read(temarioProvider).valueOrNull;
    if (temario == null) return;
    final r = await elegirTemas(context, temario: temario, seleccion: s.temas, titulo: 'Temas de esta semana');
    if (r != null) await ref.read(cronogramaProvider.notifier).fijarSemana(s.lunes, r);
  }

  Widget _filaArchivado(BuildContext context, WidgetRef ref, Cronograma a) {
    final e = estadoDe(a, DateTime.now(), vueltas: ref.watch(vueltasProvider));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: const Icon(Icons.inventory_2_outlined),
          title: Text(describirCronograma(a), style: context.textos.titleSmall),
          subtitle: Text('Desde el ${fechaLargaCrono(a.inicio)} · ${e.hechos.length} hechos', style: context.textos.labelSmall),
        ),
      ),
    );
  }
}

/// Tarjeta de Hoy: lo que toca esta semana.
class TarjetaCronogramaHoy extends ConsumerWidget {
  const TarjetaCronogramaHoy({super.key, required this.abrir});
  final VoidCallback abrir;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(cronogramaProvider);
    final estado = ref.watch(estadoCronogramaProvider);
    if (c == null || estado == null) return const SizedBox();
    final s = estado.semanaActual;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final hechosSemana = s == null ? 0 : s.temas.where(estado.hechos.contains).length;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Tarjeta(
        onTap: abrir,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.event_note, color: context.esquema.primary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                estado.terminado ? '¡Vuelta terminada!' : (s == null ? 'Tu cronograma empieza el ${fechaLargaCrono(c.inicio)}' : (s.descanso ? 'Esta semana descansas' : 'Esta semana te toca')),
                style: context.textos.titleMedium,
              ),
            ),
          ]),
          if (s != null && !s.descanso && s.temas.isNotEmpty) ...[
            const SizedBox(height: 6),
            for (final t in s.temas)
              Row(children: [
                Checkbox(value: estado.hechos.contains(t), visualDensity: VisualDensity.compact, onChanged: (v) => ref.read(cronogramaProvider.notifier).marcar(t, hecho: v ?? false)),
                CasillaTema(t, color: estructura?.colorDe(t) ?? context.esquema.primary),
                const SizedBox(width: 8),
                Expanded(child: Text(temario?.tema(t)?.titulo ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall)),
              ]),
            Text('$hechosSemana de ${s.temas.length} esta semana · ${estado.hechos.length} de ${estado.total} en la vuelta', style: context.textos.labelSmall),
          ],
          if (estado.atrasados.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('Vas ${estado.atrasados.length} ${estado.atrasados.length == 1 ? 'tema' : 'temas'} por detrás: toca para replanificar.', style: context.textos.labelSmall?.copyWith(color: context.esquema.error)),
            ),
        ]),
      ),
    );
  }
}
