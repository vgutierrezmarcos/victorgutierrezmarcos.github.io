import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'ajustes_preparador_page.dart';

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
      messenger.showSnackBar(SnackBar(content: Text(aceptar ? 'Reserva aceptada: ya está en tu agenda y en la del alumno' : 'Reserva rechazada')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo: $e')));
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

/// El alumno elige un hueco libre de su preparador y pide la clase.
class ReservarPage extends ConsumerWidget {
  const ReservarPage({super.key, required this.preparador});
  final VinculoPreparador preparador;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final huecos = ref.watch(huecosDeProvider(preparador.uid));
    final mias = (ref.watch(misReservasProvider).value ?? const <Reserva>[]).where((r) => r.preparador == preparador.uid).toList();
    final pedidas = mias.where((r) => r.pedida || r.estado == EstadoReserva.aceptada).map((r) => r.fecha);
    final nombre = preparador.nombre.isEmpty ? 'tu preparador' : preparador.nombre;

    Future<void> pedir(DateTime f, int minutos) async {
      final nota = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: Text('¿Pedir clase el ${DateFormat("EEEE d 'a las' HH:mm", 'es').format(f)}?'),
          content: TextField(controller: nota, decoration: const InputDecoration(labelText: 'Nota (opcional)', hintText: 'Qué quieres cantar, si llegas tarde…')),
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
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pedida. Te avisaremos cuando $nombre la acepte.')));
    }

    return Scaffold(
      appBar: BarraWeb(title: Text('Reservar con $nombre')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(huecosDeProvider(preparador.uid));
          ref.invalidate(misReservasProvider);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            ...switch (huecos) {
              AsyncData(:final value) when value == null || !value.activo => [Text('$nombre no ofrece reservas ahora mismo.', style: context.textos.bodySmall)],
              AsyncData(:final value) => () {
                  final libres = value!.libres(desde: DateTime.now(), semanas: 4, pedidos: pedidas);
                  if (libres.isEmpty) return [Text('No quedan huecos libres en las próximas cuatro semanas.', style: context.textos.bodySmall)];
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
                  ];
                }(),
              AsyncError() => [Text('No se han podido cargar los huecos.', style: context.textos.bodySmall)],
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
