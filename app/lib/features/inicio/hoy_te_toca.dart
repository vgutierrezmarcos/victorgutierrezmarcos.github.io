import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../organizacion/dominio_tema.dart';
import '../plan/cante_page.dart';
import '../plan/cantes_util.dart';
import '../temario/abrir_tema.dart';
import '../test/motor_test.dart';
import '../cantar/esquema_ciegas_page.dart';
import '../preparador/deberes.dart';
import '../temario/esquema_tema.dart';
import 'racha.dart';

/// Una línea de «Hoy te toca»: qué hacer, con un toque que lo abre.
class _Linea {
  const _Linea(this.icono, this.texto, this.onTap, {this.hecho = false, this.detalle});
  final IconData icono;
  final String texto;
  final String? detalle;
  final VoidCallback? onTap;
  final bool hecho;
}

/// Lo primero de Hoy para el opositor: qué hacer en los próximos minutos, en
/// orden (test diario o el que está a medias, repaso vencido, los temas de la
/// semana, el tema de la próxima clase, el tema más frío si lo activa y, sin
/// cronograma, el tema sugerido), y la racha de días si la tiene activada.
class TarjetaHoyTeToca extends ConsumerWidget {
  const TarjetaHoyTeToca({super.key, this.opositor = true});
  /// Al preparador solo el test diario, el test a medias y el repaso.
  final bool opositor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ajustes = ref.watch(ajustesProvider);
    final banco = ref.watch(preguntasProvider).valueOrNull;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final ahora = DateTime.now();
    final lineas = <_Linea>[];

    // Test diario o test a medias.
    final enCurso = ref.watch(testEnCursoProvider);
    final diarioHecho = ref.watch(testDiarioHechoProvider);
    if (enCurso != null) {
      lineas.add(_Linea(Icons.play_circle_outline, 'Continuar el test', () => context.push('/examen', extra: enCurso), detalle: '${enCurso.respondidas} de ${enCurso.ids.length} respondidas'));
    } else if (banco != null) {
      lineas.add(_Linea(
        Icons.today,
        'Test diario',
        diarioHecho ? null : () => context.push('/examen', extra: ConfigTest(idsFijos: MotorTest.testDiario(banco, ahora).map((p) => p.id).toList(), minutos: 15, tipo: 'diario')),
        hecho: diarioHecho,
        detalle: diarioHecho ? 'Hecho' : '10 preguntas, 15 minutos',
      ));
    }

    // Repaso vencido (Leitner, por sesiones o por días).
    final pendientes = ref.watch(leitnerProvider).pendientes();
    if (pendientes.isNotEmpty) {
      lineas.add(_Linea(Icons.replay, '${pendientes.length} ${pendientes.length == 1 ? 'pregunta' : 'preguntas'} de repaso', () => context.push('/examen', extra: ConfigTest(idsFijos: pendientes, minutos: 0, tipo: 'repaso')), detalle: 'Las que fallaste y ya toca volver a ver'));
    }

    // Candidato para el esquema a ciegas: el tema más frío (si lo activa) o,
    // si no, el primero que falta de la semana.
    String? paraEsquema;
    // Los temas de esta semana del cronograma que faltan.
    final estado = opositor ? ref.watch(estadoCronogramaProvider) : null;
    final semana = estado?.semanaActual;
    if (estado != null && semana != null && !semana.descanso) {
      final faltan = semana.temas.where((t) => !estado.hechos.contains(t)).toList();
      paraEsquema ??= faltan.firstOrNull;
      if (faltan.isNotEmpty) {
        lineas.add(_Linea(
          Icons.event_note,
          'Esta semana: ${faltan.take(3).join(', ')}${faltan.length > 3 ? '…' : ''}',
          () => context.go('/organizacion/cronograma'),
          detalle: '${semana.temas.length - faltan.length} de ${semana.temas.length} hechos${estado.atrasados.isNotEmpty ? ' · vas ${estado.atrasados.length} por detrás' : ''}',
        ));
      } else if (semana.temas.isNotEmpty) {
        lineas.add(_Linea(Icons.event_note, 'Los temas de esta semana', null, hecho: true, detalle: '${semana.temas.length} de ${semana.temas.length}'));
      }
    }

    // Deberes de la próxima clase con preparador que aún tiene alguno sin hacer.
    final conDeberes = opositor ? ref.watch(proximosCantesProvider).where((c) => c.dePreparador && c.tareas.any((t) => !t.hecha)).firstOrNull : null;
    if (conDeberes != null) {
      lineas.add(_Linea(
        Icons.checklist,
        'Deberes para la clase de ${cuentaAtras(conDeberes.fecha, ahora)}: ${resumenDeberes(conDeberes)}',
        () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: conDeberes.id))),
        detalle: conDeberes.tareas.where((t) => !t.hecha).take(2).map((t) => t.etiqueta(tituloDe: (c) => '')).join(' · '),
      ));
    }

    // El próximo cante o clase (hoy o mañana) con temas: para repasarlos.
    final cante = opositor ? ref.watch(proximosCantesProvider).where((c) => c.fecha.isAfter(ahora)).firstOrNull : null;
    if (cante != null && cante.fecha.difference(ahora).inHours < 48 && cante.temas.isNotEmpty) {
      final t = cante.temas.first;
      lineas.add(_Linea(
        Icons.record_voice_over_outlined,
        'Repasa ${cante.temas.take(2).join(' y ')} para ${cante.dePreparador ? 'la clase' : 'el cante'} de ${cuentaAtras(cante.fecha, ahora)}',
        temario?.tema(t) != null ? () => abrirTema(context, temario, t) : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: cante.id))),
        detalle: '${fechaCorta(cante.fecha)} a las ${horaDe(cante.fecha)}',
      ));
    }

    // El tema estudiado que lleva más tiempo sin repasar (si lo activa).
    if (opositor && ajustes.temaFrio && temario != null && ajustes.temasEstudiados.isNotEmpty) {
      final datos = datosPorTema(codigos: ajustes.temasEstudiados, estudiados: ajustes.temasEstudiados, cantes: ref.watch(estadisticasCantesProvider), vueltas: ref.watch(vueltasProvider));
      String? frio;
      DateTime? cuando;
      for (final e in datos.entries) {
        if (temario.tema(e.key) == null) continue;
        final u = e.value.ultimo;
        if (frio == null || (u == null && cuando != null) || (u != null && cuando != null && u.isBefore(cuando))) {
          frio = e.key;
          cuando = u;
        }
      }
      if (frio != null) {
        paraEsquema = frio;
        final dias = cuando == null ? null : ahora.difference(cuando).inDays;
        lineas.add(_Linea(
          Icons.ac_unit_outlined,
          'Repasa $frio, el tema más frío',
          () => abrirTema(context, temario, frio!),
          detalle: dias == null ? 'Estudiado, pero sin ninguna vuelta ni cante apuntados' : 'Sin repasar desde hace $dias ${dias == 1 ? 'día' : 'días'}',
        ));
      }
    }

    // Sin cronograma: por dónde seguir (temas conectados con lo ya estudiado).
    if (opositor && estado == null && temario != null) {
      final sugerido = ref.watch(estructuraProvider).valueOrNull?.sugeridos(ajustes.temasEstudiados, ejercicio: Oposiciones.actual.primerConTemas).firstOrNull;
      if (sugerido != null && temario.tema(sugerido) != null) {
        lineas.add(_Linea(Icons.auto_awesome_outlined, 'Siguiente tema sugerido: $sugerido', () => abrirTema(context, temario, sugerido), detalle: temario.tema(sugerido)!.titulo));
      }
    }

    // Esquema a ciegas del candidato, si tiene esquema.
    final temaEsquema = paraEsquema == null ? null : temario?.tema(paraEsquema);
    if (temaEsquema != null && listaControlDisponible(esquemaDelTema(ref, temaEsquema))) {
      final t = temaEsquema.codigo;
      lineas.add(_Linea(Icons.psychology_outlined, 'Esquema a ciegas de $t', () => abrirEsquemaCiegas(context, t), detalle: 'Sácalo de memoria con el tiempo del examen y compáralo'));
    }

    final racha = opositor ? ref.watch(rachaProvider) : null;
    if (lineas.isEmpty && racha == null) return const SizedBox.shrink();
    // La mejor racha se recuerda (se sincroniza con la cuenta).
    if (racha != null && racha.dias > ajustes.mejorRacha) {
      WidgetsBinding.instance.addPostFrameCallback((_) => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(mejorRacha: racha.dias)));
    }
    final todoHecho = lineas.every((l) => l.hecho);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(todoHecho ? 'Todo hecho por hoy' : 'Hoy te toca', style: context.textos.titleMedium)),
            if (racha != null) _ChipRacha(racha: racha, mejor: ajustes.mejorRacha),
          ]),
          const SizedBox(height: 4),
          for (final l in lineas)
            InkWell(
              onTap: l.onTap,
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(l.hecho ? Icons.check_circle : l.icono, size: 20, color: l.hecho ? Paleta.acierto : context.esquema.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.texto, style: context.textos.titleSmall?.copyWith(decoration: l.hecho ? TextDecoration.lineThrough : null, color: l.hecho ? context.colores.textoSuave : null)),
                      if (l.detalle != null) Text(l.detalle!, style: context.textos.labelSmall),
                    ]),
                  ),
                  if (l.onTap != null) Icon(Icons.chevron_right, size: 18, color: context.colores.textoClaro),
                ]),
              ),
            ),
        ]),
      ),
    );
  }
}

/// «12 días seguidos» (o «Congelada hasta el 3 nov»), con el menú para congelar.
class _ChipRacha extends ConsumerWidget {
  const _ChipRacha({required this.racha, required this.mejor});
  final Racha racha;
  final int mejor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texto = racha.congelada
        ? 'Congelada hasta el ${DateFormat('d MMM', 'es').format(racha.congeladaHasta!)}'
        : racha.dias == 0
            ? 'Sin racha'
            : '${racha.dias} ${racha.dias == 1 ? 'día' : 'días'} seguidos';
    return Tooltip(
      message: 'Días seguidos con test, cante o vuelta. Un día suelto no la rompe; si descansas más, congélala.${mejor > 0 ? ' Mejor racha: $mejor.' : ''}',
      child: InkWell(
        onTap: () => congelarRachaDialogo(context, ref, racha),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 4, 8, 4),
          decoration: BoxDecoration(color: context.colores.superficie, borderRadius: BorderRadius.circular(14), border: Border.all(color: context.colores.borde)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(racha.congelada ? Icons.ac_unit : Icons.local_fire_department_outlined, size: 16, color: racha.congelada ? context.colores.textoSuave : context.colores.dorado),
            const SizedBox(width: 4),
            Text(texto, style: context.textos.labelMedium),
            const SizedBox(width: 2),
            Icon(Icons.arrow_drop_down, size: 18, color: context.colores.textoClaro),
          ]),
        ),
      ),
    );
  }
}

/// Congelar la racha unos días (descanso) o descongelarla.
Future<void> congelarRachaDialogo(BuildContext context, WidgetRef ref, Racha racha) async {
  final hoy = DateTime.now();
  final r = await showDialog<int>(
    context: context,
    builder: (d) => AlertDialog(
      title: Text(racha.congelada ? 'Racha congelada' : 'Congelar la racha'),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          racha.congelada
              ? 'Hasta el ${DateFormat('d MMMM', 'es').format(racha.congeladaHasta!)} los días no cuentan ni la rompen. Puedes alargarla o descongelarla.'
              : 'Mientras esté congelada, los días sin actividad no la rompen (ni suman). Para un día suelto no hace falta: la racha ya lo permite.',
          style: Theme.of(d).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final n in const [2, 3, 7, 14])
            ActionChip(label: Text('$n días'), onPressed: () => Navigator.pop(d, n)),
          ActionChip(
            avatar: const Icon(Icons.edit_calendar_outlined, size: 18),
            label: const Text('Hasta un día'),
            onPressed: () async {
              final f = await showDatePicker(context: d, initialDate: hoy.add(const Duration(days: 3)), firstDate: hoy, lastDate: hoy.add(const Duration(days: 30)), helpText: 'Congelada hasta');
              if (f != null && d.mounted) Navigator.pop(d, f.difference(DateTime(hoy.year, hoy.month, hoy.day)).inDays + 1);
            },
          ),
        ]),
      ]),
      actions: [
        if (racha.congelada) TextButton(onPressed: () => Navigator.pop(d, 0), child: const Text('Descongelar')),
        TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cerrar')),
      ],
    ),
  );
  if (r == null) return;
  await ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(
        rachaCongelaciones: r == 0 ? descongelar(a.rachaCongelaciones, hoy) : congelar(descongelar(a.rachaCongelaciones, hoy), hoy, r),
      ));
}
