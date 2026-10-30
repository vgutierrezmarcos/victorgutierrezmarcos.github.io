import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../data/models/coordinacion.dart';
import '../plan/cantes_util.dart';
import 'coordinacion.dart';
import 'ajustes_preparador_page.dart';
import '../mas/ayuda_videos.dart';

/// Reserva pedida por un alumno, con Aceptar / Rechazar (lado del preparador).
class FilaReservaPedida extends ConsumerStatefulWidget {
  const FilaReservaPedida({super.key, required this.reserva});
  final Reserva reserva;
  @override
  ConsumerState<FilaReservaPedida> createState() => _FilaReservaPedidaState();
}

class _FilaReservaPedidaState extends ConsumerState<FilaReservaPedida> {
  bool _ocupado = false;

  Future<void> _responder(bool aceptar) async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _ocupado = true);
    try {
      final r = widget.reserva;
      if (aceptar) {
        await ref.read(preparadorRepoProvider).sesionDeReserva(r);
        ref.invalidate(sesionesProvider);
        ref.invalidate(alumnosProvider);
      }
      await ref.read(redRepoProvider).cambiarReserva(r, aceptar ? EstadoReserva.aceptada : EstadoReserva.rechazada);
      ref.invalidate(reservasRecibidasProvider);
      messenger.mostrar(SnackBar(content: Text(aceptar ? 'Reserva aceptada: ya está en tu agenda y en la del alumno' : 'Reserva rechazada')));
    } catch (e) {
      messenger.mostrar(SnackBar(content: Text('No se pudo: $e')));
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.reserva;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Reserva por confirmar', style: context.textos.labelSmall?.copyWith(color: context.colores.dorado, fontWeight: FontWeight.w700)),
              Text('${fechaCorta(r.fecha)} · ${describirReserva(r)}', style: context.textos.titleSmall),
              if (r.modalidad != Modalidad.sinIndicar || r.temas.isNotEmpty)
                Text([if (r.modalidad == Modalidad.presencial) 'Presencial', if (r.modalidad == Modalidad.online) 'Online', if (r.temas.isNotEmpty) 'Temas: ${r.temas.join(', ')}'].join(' · '), style: context.textos.labelSmall),
              if (r.nota.isNotEmpty) Text(r.nota, style: context.textos.labelSmall),
            ]),
          ),
          if (_ocupado)
            const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
          else ...[
            IconButton(tooltip: 'Rechazar', icon: Icon(Icons.close, color: context.esquema.error), onPressed: () => _responder(false)),
            IconButton(tooltip: 'Aceptar', icon: const Icon(Icons.check, color: Paleta.acierto), onPressed: () => _responder(true)),
          ],
        ]),
      ),
    );
  }
}

/// Las clases que el alumno ha pedido a sus preparadores y están sin
/// contestar (tarjetas para la agenda): día, hora y «Anular».
class TarjetasReservasPedidas extends ConsumerWidget {
  const TarjetasReservasPedidas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ahora = DateTime.now();
    final pedidas = (ref.watch(misReservasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(ahora)).toList();
    if (pedidas.isEmpty) return const SizedBox.shrink();
    final nombres = {for (final v in ref.watch(misPreparadoresProvider)) v.uid: v.nombre};
    return Column(children: [
      for (final r in pedidas)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Tarjeta(
            color: context.colores.dorado.withValues(alpha: 0.12),
            padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
            child: Row(children: [
              Icon(Icons.hourglass_top, color: context.colores.dorado, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Clase pedida a ${(nombres[r.preparador] ?? '').isEmpty ? 'tu preparador' : nombres[r.preparador]}', style: context.textos.titleSmall),
                  Text('${fechaCorta(r.fecha)} · ${franja(r.fecha, r.minutos)} · pendiente de que la confirme', style: context.textos.labelSmall),
                ]),
              ),
              TextButton(
                onPressed: () async {
                  await ref.read(redRepoProvider).cambiarReserva(r, EstadoReserva.cancelada);
                  ref.invalidate(misReservasProvider);
                },
                child: const Text('Anular'),
              ),
            ]),
          ),
        ),
    ]);
  }
}

/// El alumno elige un hueco libre de su preparador y pide la clase. Si el
/// preparador no tiene las reservas abiertas (o ningún hueco le viene bien),
/// propone él un día y una hora.
class ReservarPage extends ConsumerWidget {
  const ReservarPage({super.key, required this.preparador});
  final VinculoPreparador preparador;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final huecos = ref.watch(huecosDeProvider(preparador.uid));
    final mias = (ref.watch(misReservasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.preparador == preparador.uid).toList();
    final pedidas = mias.where((r) => r.pedida || r.estado == EstadoReserva.aceptada).map((r) => r.fecha);
    final nombre = preparador.nombre.isEmpty ? 'tu preparador' : preparador.nombre;

    Future<void> pedir(DateTime f, int minutos, {bool propuesta = false}) async {
      final nota = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: Text('¿Pedir clase el ${DateFormat("EEEE d 'a las' HH:mm", 'es').format(f)}?'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            if (propuesta) Padding(padding: const EdgeInsets.only(bottom: 10), child: Text('${textoDuracion(minutos)}. $nombre la ve como una petición y la acepta o te propone otra hora.', style: context.textos.bodySmall)),
            TextField(controller: nota, decoration: const InputDecoration(labelText: 'Nota (opcional)', hintText: 'Qué quieres cantar, si llegas tarde…')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Pedir')),
          ],
        ),
      );
      if (ok != true) return;
      final yo = ref.read(usuarioActualProvider);
      final red = ref.read(redRepoProvider);
      await red.pedirReserva(Reserva(id: nuevoId(), preparador: preparador.uid, alumno: red.uid!, alumnoNombre: yo?.displayName ?? '', fecha: f, minutos: minutos, nota: nota.text.trim(), creada: DateTime.now()));
      ref.invalidate(misReservasProvider);
      if (context.mounted) ScaffoldMessenger.of(context).mostrar(SnackBar(content: Text('Pedida. Te avisaremos cuando $nombre la acepte.')));
    }

    /// Un día y una hora cualesquiera (sin huecos publicados o fuera de ellos).
    Future<void> proponer() async {
      final manana = DateTime.now().add(const Duration(days: 1));
      final d = await showDatePicker(context: context, initialDate: manana, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)), helpText: 'Día de la clase');
      if (d == null || !context.mounted) return;
      final t = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 17, minute: 0), helpText: 'Hora de la clase');
      if (t == null || !context.mounted) return;
      final f = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      if (!f.isAfter(DateTime.now())) {
        ScaffoldMessenger.of(context).mostrar(const SnackBar(content: Text('Esa hora ya ha pasado.')));
        return;
      }
      final minutos = huecos.valueOrNull?.huecos.firstOrNull?.minutos ?? PerfilPreparador.minutosClasePorDefecto;
      final choques = choquesEnAgenda(ref.read(cantesProvider), f, minutos);
      if (!await confirmarChoques(context, choques)) return;
      await pedir(f, minutos, propuesta: true);
    }

    final botonProponer = Padding(
      padding: const EdgeInsets.only(top: 12),
      child: OutlinedButton.icon(onPressed: proponer, icon: const Icon(Icons.edit_calendar_outlined, size: 18), label: const Text('Proponer otro día y hora')),
    );

    return Scaffold(
      appBar: BarraWeb(title: Text('Reservar con $nombre'), actions: const [BotonVideoAyuda('reservar-clase')]),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(huecosDeProvider(preparador.uid));
          ref.invalidate(misReservasProvider);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            ...switch (huecos) {
              AsyncData(:final value) when value == null || !value.activo => [
                  Text('$nombre no tiene abiertas las reservas por huecos. Puedes proponerle tú el día y la hora: le llega como una petición y la acepta o te dice otra.', style: context.textos.bodySmall),
                  botonProponer,
                ],
              AsyncData(:final value) => () {
                  // Sin los que chocan con mi agenda (clases con otros
                  // preparadores o cantes con hora).
                  final agenda = ref.watch(cantesProvider);
                  int minutosDe(DateTime f) => value!.huecos.where((h) => h.diaSemana == f.weekday && h.minutoDelDia == f.hour * 60 + f.minute).firstOrNull?.minutos ?? 60;
                  final libres = value!.libres(desde: DateTime.now(), semanas: 4, pedidos: pedidas).where((f) => choquesEnAgenda(agenda, f, minutosDe(f)).isEmpty).toList();
                  if (libres.isEmpty) return [Text('No quedan huecos libres en las próximas cuatro semanas.', style: context.textos.bodySmall), botonProponer];
                  final porDia = <DateTime, List<DateTime>>{};
                  for (final f in libres) {
                    porDia.putIfAbsent(DateTime(f.year, f.month, f.day), () => []).add(f);
                  }
                  return [
                    Text('Huecos libres de $nombre en las próximas cuatro semanas. Toca uno para pedirlo.', style: context.textos.bodySmall),
                    for (final e in porDia.entries) ...[
                      Padding(padding: const EdgeInsets.fromLTRB(4, 14, 4, 6), child: Text(fechaLarga(e.key), style: context.textos.titleSmall)),
                      Wrap(spacing: 8, runSpacing: 8, children: [
                        for (final f in e.value)
                          () {
                            final h = value.huecos.firstWhere((h) => h.diaSemana == f.weekday && h.minutoDelDia == f.hour * 60 + f.minute, orElse: () => const Hueco(diaSemana: 1, minutoDelDia: 0));
                            return ActionChip(label: Text(franja(f, h.minutos)), onPressed: () => pedir(f, h.minutos));
                          }(),
                      ]),
                    ],
                    Padding(padding: const EdgeInsets.only(top: 14), child: Text('¿Ninguno te viene bien?', style: context.textos.bodySmall)),
                    botonProponer,
                  ];
                }(),
              AsyncError() => [Text('No se han podido cargar los huecos.', style: context.textos.bodySmall), botonProponer],
              _ => [const Center(child: CircularProgressIndicator())],
            },
            if (mias.any((r) => r.fecha.isAfter(DateTime.now()))) ...[
              const TituloSeccion('Mis reservas'),
              for (final r in mias.where((r) => r.fecha.isAfter(DateTime.now()))) FilaMiReserva(reserva: r),
            ],
          ],
        ),
      ),
    );
  }
}

/// Reserva del alumno con su estado (y cancelar mientras está pedida).
class FilaMiReserva extends ConsumerWidget {
  const FilaMiReserva({super.key, required this.reserva});
  final Reserva reserva;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = reserva;
    final (texto, color) = switch (r.estado) {
      EstadoReserva.pedida => ('Pendiente de confirmar', context.colores.dorado),
      EstadoReserva.aceptada => ('Aceptada', Paleta.acierto),
      EstadoReserva.rechazada => ('Rechazada', context.esquema.error),
      EstadoReserva.cancelada => ('Cancelada', context.colores.textoClaro),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Tarjeta(
        padding: EdgeInsets.zero,
        child: ListTile(
          dense: true,
          title: Text('${fechaCorta(r.fecha)} · ${franja(r.fecha, r.minutos)}', style: context.textos.titleSmall),
          subtitle: Text(texto, style: context.textos.labelSmall?.copyWith(color: color)),
          trailing: r.pedida
              ? TextButton(
                  onPressed: () async {
                    await ref.read(redRepoProvider).cambiarReserva(r, EstadoReserva.cancelada);
                    ref.invalidate(misReservasProvider);
                  },
                  child: const Text('Anular'),
                )
              : null,
        ),
      ),
    );
  }
}
