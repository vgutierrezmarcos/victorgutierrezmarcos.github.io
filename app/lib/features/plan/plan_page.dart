import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/calendario.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cante_form_page.dart';
import 'cante_page.dart';
import 'cantes_util.dart';

/// Exporta los próximos cantes, las fechas de los ejercicios y los hitos a un
/// fichero .ics que se comparte con el calendario del móvil.
Future<void> exportarCalendario(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final cantes = ref.read(proximosCantesProvider);
  final fechas = ref.read(fechasEjerciciosProvider);
  final hitos = ref.read(planProvider).hitos;
  final eventos = [
    for (final c in cantes) eventoDeCante(c),
    for (final e in fechas.entries) eventoDeFecha('ej${e.key}', 'TCEE · ${nombreEjercicio(e.key)}', e.value),
    for (final h in hitos) eventoDeFecha(h.id, 'TCEE · ${h.titulo}', h.fecha),
  ];
  if (eventos.isEmpty) {
    messenger.showSnackBar(const SnackBar(content: Text('No hay cantes ni fechas que exportar')));
    return;
  }
  final dir = await getTemporaryDirectory();
  final f = File('${dir.path}/oposicion_tcee.ics');
  await f.writeAsString(Calendario.ics(eventos));
  await SharePlus.instance.share(ShareParams(files: [XFile(f.path, mimeType: 'text/calendar')], subject: 'Calendario de la oposición TCEE'));
}

/// Activa o desactiva los avisos de la víspera y de una hora antes de cada cante.
Future<void> alternarAvisosCante(WidgetRef ref) async {
  final activar = !ref.read(planProvider).avisosCante;
  if (activar && !await Notificaciones.pedirPermiso()) return;
  await ref.read(planProvider.notifier).actualizar((p) => p.copyWith(avisosCante: activar));
  await ref.read(cantesProvider.notifier).reprogramarAvisos();
}

/// Agenda de cantes (subpestaña de Cantes): próximo cante con su cuenta
/// atrás, calendario mensual y lo programado cada día.
class AgendaCantesVista extends ConsumerStatefulWidget {
  const AgendaCantesVista({super.key});
  @override
  ConsumerState<AgendaCantesVista> createState() => _AgendaCantesVistaState();
}

class _AgendaCantesVistaState extends ConsumerState<AgendaCantesVista> {
  DateTime _mes = DateTime.now();
  DateTime _dia = DateTime.now();
  Timer? _tic;

  @override
  void initState() {
    super.initState();
    // Refresca las cuentas atrás.
    _tic = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  void _nuevoCante([DateTime? dia]) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(diaInicial: dia)));
  void _abrir(Cante c) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: c.id)));

  @override
  Widget build(BuildContext context) {
    final cantes = ref.watch(cantesProvider);
    final proximos = ref.watch(proximosCantesProvider);
    final plan = ref.watch(planProvider);
    final fechas = ref.watch(fechasEjerciciosProvider);
    final ahora = DateTime.now();

    // Lo que hay cada día: cantes y fechas señaladas.
    List<Object> eventosDe(DateTime d) => [
          ...cantes.where((c) => !c.borrado && c.estado != EstadoCante.cancelado && isSameDay(c.fecha, d)),
          ...fechas.entries.where((e) => isSameDay(e.value, d)).map((e) => nombreEjercicio(e.key)),
          ...plan.hitos.where((h) => isSameDay(h.fecha, d)).map((h) => h.titulo),
        ];
    final delDia = eventosDe(_dia);
    final siguiente = proximos.isEmpty ? null : proximos.first;

    // Sin cabecera: va dentro de CantesPage, que pone el título y las subpestañas.
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _nuevoCante(_dia), icon: const Icon(Icons.add), label: const Text('Cante')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
        children: [
          if (siguiente != null)
            Tarjeta(
              color: context.colores.primarioPalido,
              onTap: () => _abrir(siguiente),
              child: Row(children: [
                Icon(Icons.record_voice_over, color: context.esquema.primary, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Próximo cante ${cuentaAtras(siguiente.fecha, ahora)}', style: context.textos.titleMedium),
                    Text('${fechaLarga(siguiente.fecha)}, ${horaDe(siguiente.fecha)}${siguiente.titulo.isEmpty ? '' : ' · ${siguiente.titulo}'}', style: context.textos.bodySmall),
                    Text(descripcionBolsa(siguiente), style: context.textos.labelSmall),
                  ]),
                ),
                const Icon(Icons.chevron_right),
              ]),
            )
          else
            Tarjeta(
              onTap: _nuevoCante,
              child: Row(children: [
                Icon(Icons.event_available_outlined, color: context.esquema.primary, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Programa tu próximo cante', style: context.textos.titleMedium),
                    Text('Apunta día, hora y los temas que entran: tendrás la cuenta atrás y un aviso la víspera.', style: context.textos.bodySmall),
                  ]),
                ),
              ]),
            ),
          const SizedBox(height: 10),
          Tarjeta(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: TableCalendar<Object>(
              locale: 'es_ES',
              firstDay: DateTime(ahora.year - 2),
              lastDay: DateTime(ahora.year + 5, 12, 31),
              focusedDay: _mes,
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
              selectedDayPredicate: (d) => isSameDay(d, _dia),
              eventLoader: eventosDe,
              onDaySelected: (dia, mes) => setState(() {
                _dia = dia;
                _mes = mes;
              }),
              onPageChanged: (mes) => _mes = mes,
              headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, titleTextStyle: context.textos.titleMedium!),
              daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: context.textos.labelSmall!, weekendStyle: context.textos.labelSmall!),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                defaultTextStyle: context.textos.bodySmall!.copyWith(color: context.esquema.onSurface),
                weekendTextStyle: context.textos.bodySmall!.copyWith(color: context.colores.textoSuave),
                todayDecoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: context.esquema.primary)),
                todayTextStyle: context.textos.bodySmall!.copyWith(color: context.esquema.primary, fontWeight: FontWeight.w700),
                selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: context.esquema.primary),
                selectedTextStyle: context.textos.bodySmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                markerDecoration: BoxDecoration(shape: BoxShape.circle, color: context.colores.dorado),
                markersMaxCount: 3,
              ),
            ),
          ),
          TituloSeccion(fechaLarga(_dia)),
          if (delDia.isEmpty)
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text('Nada programado este día.', style: context.textos.bodySmall))
          else
            for (final e in delDia)
              if (e is Cante) _filaCante(e, ahora) else _filaFecha(e.toString()),
          if (proximos.length > 1) ...[
            const TituloSeccion('Próximos cantes'),
            for (final c in proximos.take(6)) _filaCante(c, ahora, conFecha: true),
          ],
        ],
      ),
    );
  }

  Widget _filaCante(Cante c, DateTime ahora, {bool conFecha = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: EdgeInsets.zero,
          onTap: () => _abrir(c),
          child: ListTile(
            leading: Icon(c.hecho ? Icons.check_circle : Icons.record_voice_over_outlined, color: c.hecho ? Paleta.acierto : context.esquema.primary),
            title: Text('${conFecha ? '${fechaCorta(c.fecha)} · ' : ''}${horaDe(c.fecha)} · ${tituloCante(c)}', style: context.textos.titleSmall),
            subtitle: Text(c.hecho ? (c.resultado?.temaCantado ?? 'Hecho') : descripcionBolsa(c), style: context.textos.labelSmall),
            trailing: c.pendiente && c.fecha.isAfter(ahora) ? Etiqueta(cuentaAtras(c.fecha, ahora)) : const Icon(Icons.chevron_right),
          ),
        ),
      );

  Widget _filaFecha(String titulo) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: EdgeInsets.zero,
          onTap: () => context.go('/mas/convocatoria'),
          child: ListTile(leading: Icon(Icons.flag, color: context.colores.dorado), title: Text(titulo, style: context.textos.titleSmall)),
        ),
      );
}
