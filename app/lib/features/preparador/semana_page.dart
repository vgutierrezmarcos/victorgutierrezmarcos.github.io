import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cante_form_page.dart';
import '../plan/cantes_util.dart';
import 'ajustes_preparador_page.dart';
import 'red_widgets.dart';
import 'reservas.dart';
import 'sesion_page.dart';

/// Agenda del preparador: todas las sesiones de todos sus alumnos por semana
/// (o por mes), cada alumno con su color, con aviso de solapes, las reservas
/// por aceptar y, si las ofrece, los huecos libres.
class SemanaPage extends ConsumerStatefulWidget {
  const SemanaPage({super.key});
  @override
  ConsumerState<SemanaPage> createState() => _SemanaPageState();
}

class _SemanaPageState extends ConsumerState<SemanaPage> {
  late DateTime _lunes = _lunesDe(DateTime.now());
  bool _mes = false;
  DateTime _diaMes = DateTime.now();

  static DateTime _lunesDe(DateTime d) => DateTime(d.year, d.month, d.day - (d.weekday - 1));

  @override
  Widget build(BuildContext context) {
    final sesiones = ref.watch(sesionesProvider);
    final alumnos = {for (final a in ref.watch(alumnosProvider)) a.id: a};
    final solapadas = sesionesSolapadas(sesiones);
    final perfil = ref.watch(perfilPreparadorProvider);
    final reservas = (ref.watch(reservasRecibidasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(DateTime.now())).toList();
    final fin = _lunes.add(const Duration(days: 7));
    final deLaSemana = sesiones.where((s) => !s.fecha.isBefore(_lunes) && s.fecha.isBefore(fin)).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
    final horas = deLaSemana.where((s) => !s.cancelado).fold<int>(0, (t, s) => t + s.minutos);
    final ahora = DateTime.now();

    Widget filaSesion(Cante s) {
      final a = alumnos[s.alumno];
      final fin = s.fecha.add(Duration(minutes: s.minutos));
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Tarjeta(
          padding: EdgeInsets.zero,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: s.id))),
          child: IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(width: 6, decoration: BoxDecoration(color: Color(colorDePersona(s.alumno ?? '')), borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                  child: Row(children: [
                    SizedBox(
                      width: 92,
                      child: Text('${horaDe(s.fecha)}–${horaDe(fin)}', style: context.textos.labelMedium?.copyWith(decoration: s.cancelado ? TextDecoration.lineThrough : null)),
                    ),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(a?.nombre ?? 'Alumno', style: context.textos.titleSmall?.copyWith(decoration: s.cancelado ? TextDecoration.lineThrough : null)),
                        Text(
                          [
                            if (s.cancelado) 'Cancelada${s.motivo.isEmpty ? '' : ': ${s.motivo}'}',
                            if (s.hecho) 'Valorada',
                            if (s.sustitucion != null) 'Sustitución',
                            if (s.serie?.startsWith('fija_') ?? false) 'Clase fija',
                            if (!s.cancelado && !s.hecho) detalleCante(s),
                          ].join(' · '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textos.labelSmall,
                        ),
                      ]),
                    ),
                    if (solapadas.contains(s.id)) Tooltip(message: 'Se solapa con otra sesión', child: Icon(Icons.warning_amber_rounded, color: context.esquema.error)),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      );
    }

    Widget filaHueco(DateTime f, int minutos) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            decoration: BoxDecoration(border: Border.all(color: context.colores.borde), borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              SizedBox(width: 92, child: Text(franja(f, minutos), style: context.textos.labelMedium?.copyWith(color: context.colores.textoClaro))),
              Expanded(child: Text('Hueco libre (tus alumnos pueden reservarlo)', style: context.textos.labelSmall)),
            ]),
          ),
        );

    List<Widget> dia(DateTime d) {
      final del = deLaSemana.where((s) => DateUtils.isSameDay(s.fecha, d)).toList();
      final res = reservas.where((r) => DateUtils.isSameDay(r.fecha, d)).toList();
      final libres = perfil.reservas
          ? HuecosPublicos(
              preparador: '',
              huecos: perfil.huecos,
              ocupados: [for (final s in sesiones.where((s) => !s.cancelado && !s.borrado)) (inicio: s.fecha, minutos: s.minutos)],
            ).libres(desde: d.isBefore(ahora) ? ahora : d, semanas: 1, pedidos: reservas.map((r) => r.fecha)).where((f) => DateUtils.isSameDay(f, d)).toList()
          : const <DateTime>[];
      final hoy = DateUtils.isSameDay(d, ahora);
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 14, 4, 6),
          child: Row(children: [
            Text(DateFormat('EEEE d', 'es').format(d), style: context.textos.titleSmall?.copyWith(color: hoy ? context.esquema.primary : null, fontWeight: hoy ? FontWeight.w700 : null)),
            const Spacer(),
            IconButton(
              tooltip: 'Nueva sesión este día',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.add, size: 20),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: ref.read(alumnosProvider), diaInicial: d))),
            ),
          ]),
        ),
        if (del.isEmpty && res.isEmpty && libres.isEmpty) Padding(padding: const EdgeInsets.only(left: 4, bottom: 4), child: Text('Libre', style: context.textos.labelSmall)),
        for (final s in del) filaSesion(s),
        for (final r in res) FilaReservaPedida(reserva: r),
        for (final f in libres) filaHueco(f, perfil.huecos.firstWhere((h) => h.diaSemana == f.weekday && h.minutoDelDia == f.hour * 60 + f.minute, orElse: () => const Hueco(diaSemana: 1, minutoDelDia: 0)).minutos),
      ];
    }

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Mi semana'),
        actions: [
          IconButton(
            tooltip: _mes ? 'Ver semana' : 'Ver mes',
            icon: Icon(_mes ? Icons.view_week_outlined : Icons.calendar_month_outlined),
            onPressed: () => setState(() => _mes = !_mes),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: ref.read(alumnosProvider)))),
        icon: const Icon(Icons.add),
        label: const Text('Sesión'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(alumnosProvider.notifier).refrescar(),
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: _mes
              ? [_vistaMes(sesiones, alumnos)]
              : [
                  Row(children: [
                    IconButton(tooltip: 'Semana anterior', icon: const Icon(Icons.chevron_left), onPressed: () => setState(() => _lunes = _lunes.subtract(const Duration(days: 7)))),
                    Expanded(
                      child: Column(children: [
                        Text('${DateFormat("d MMM", 'es').format(_lunes)} – ${DateFormat("d MMM", 'es').format(fin.subtract(const Duration(days: 1)))}', style: context.textos.titleMedium, textAlign: TextAlign.center),
                        Text('${deLaSemana.where((s) => !s.cancelado).length} sesiones · ${(horas / 60).toStringAsFixed(horas % 60 == 0 ? 0 : 1)} h${solapadas.any((id) => deLaSemana.any((s) => s.id == id)) ? ' · hay solapes' : ''}', style: context.textos.labelSmall),
                      ]),
                    ),
                    IconButton(tooltip: 'Semana siguiente', icon: const Icon(Icons.chevron_right), onPressed: () => setState(() => _lunes = _lunes.add(const Duration(days: 7)))),
                  ]),
                  if (!DateUtils.isSameDay(_lunes, _lunesDe(ahora)))
                    Center(child: TextButton(onPressed: () => setState(() => _lunes = _lunesDe(ahora)), child: const Text('Volver a esta semana'))),
                  for (var i = 0; i < 7; i++) ...dia(DateTime(_lunes.year, _lunes.month, _lunes.day + i)),
                  const SizedBox(height: 12),
                  _leyenda(alumnos.values.where((a) => deLaSemana.any((s) => s.alumno == a.id)).toList()),
                ],
        ),
      ),
    );
  }

  Widget _leyenda(List<Alumno> lista) => lista.isEmpty
      ? const SizedBox()
      : Wrap(spacing: 14, runSpacing: 6, children: [
          for (final a in lista)
            Row(mainAxisSize: MainAxisSize.min, children: [PuntoPersona(a.id), const SizedBox(width: 6), Text(a.nombre, style: context.textos.labelSmall)]),
        ]);

  Widget _vistaMes(List<Cante> sesiones, Map<String, Alumno> alumnos) {
    final vivas = sesiones.where((s) => !s.borrado && !s.cancelado).toList();
    final ahora = DateTime.now();
    final delDia = vivas.where((s) => isSameDay(s.fecha, _diaMes)).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Tarjeta(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: TableCalendar<Cante>(
          locale: 'es_ES',
          firstDay: DateTime(ahora.year - 1),
          lastDay: DateTime(ahora.year + 3, 12, 31),
          focusedDay: _diaMes,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
          selectedDayPredicate: (d) => isSameDay(d, _diaMes),
          eventLoader: (d) => vivas.where((s) => isSameDay(s.fecha, d)).toList(),
          onDaySelected: (d, _) => setState(() => _diaMes = d),
          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, titleTextStyle: context.textos.titleMedium!),
          calendarBuilders: CalendarBuilders<Cante>(
            markerBuilder: (context, dia, eventos) => eventos.isEmpty
                ? null
                : Positioned(
                    bottom: 4,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      for (final s in eventos.take(4)) Padding(padding: const EdgeInsets.symmetric(horizontal: 1), child: PuntoPersona(s.alumno ?? '', tamano: 6)),
                    ]),
                  ),
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.esquema.primary)),
            todayTextStyle: context.textos.bodySmall!.copyWith(color: context.esquema.primary, fontWeight: FontWeight.w700),
            selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: context.esquema.primary),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
        child: Row(children: [
          Expanded(child: Text(fechaLarga(_diaMes), style: context.textos.titleSmall)),
          TextButton(onPressed: () => setState(() {
                _lunes = _lunesDe(_diaMes);
                _mes = false;
              }), child: const Text('Ver la semana')),
        ]),
      ),
      if (delDia.isEmpty) Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text('Sin sesiones.', style: context.textos.bodySmall)),
      for (final s in delDia)
        ListTile(
          dense: true,
          leading: PuntoPersona(s.alumno ?? ''),
          title: Text('${horaDe(s.fecha)} · ${alumnos[s.alumno]?.nombre ?? 'Alumno'}'),
          subtitle: Text('${s.minutos} min', style: context.textos.labelSmall),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: s.id))),
        ),
    ]);
  }
}
