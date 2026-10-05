import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'semana_page.dart';
import 'sustituciones.dart';
import 'verificacion_page.dart';

/// Lo primero que ve un preparador en Hoy: sus clases de hoy, lo que espera
/// respuesta (reservas, clases sueltas, verificaciones) y el acceso a su sección.
class PanelPreparadorHoy extends ConsumerWidget {
  const PanelPreparadorHoy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final estado = ref.watch(estadoRedProvider).valueOrNull ?? const EstadoRed();
    final ahora = DateTime.now();
    final hoy = ref.watch(sesionesProvider).where((s) => s.pendiente && s.fecha.year == ahora.year && s.fecha.month == ahora.month && s.fecha.day == ahora.day).toList()
      ..sort((a, b) => a.fecha.compareTo(b.fecha));
    final nombres = {for (final a in ref.watch(alumnosProvider)) a.id: a.nombre};
    final reservas = (ref.watch(reservasRecibidasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(ahora)).length;
    final tablon = ref.watch(tablonProvider).valueOrNull?.length ?? 0;
    final solicitudes = ref.watch(solicitudesPendientesProvider).valueOrNull?.length ?? 0;
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    Widget fila(IconData icono, String texto, VoidCallback onTap, {String? detalle}) => InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(children: [
              Icon(icono, size: 22, color: context.esquema.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(texto, style: context.textos.titleSmall),
                  if (detalle != null) Text(detalle, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                ]),
              ),
              const Icon(Icons.chevron_right, size: 20),
            ]),
          ),
        );

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (firebase && usuario != null && !estado.verificado)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Tarjeta(
            color: context.colores.dorado.withValues(alpha: 0.12),
            onTap: () => context.go('/mas/preparador'),
            child: Row(children: [
              Icon(Icons.how_to_reg_outlined, color: context.colores.dorado, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(estado.solicitud == null ? 'Termina tu alta de preparador' : 'Verificación pendiente', style: context.textos.titleMedium),
                  Text(
                    estado.solicitud == null
                        ? 'Pide la verificación para dar tu código a tus alumnos y coger clases sueltas.'
                        : 'Te avisaremos cuando te verifiquen. Mientras, puedes llevar a tus alumnos a mano.',
                    style: context.textos.bodySmall,
                  ),
                ]),
              ),
              const Icon(Icons.chevron_right),
            ]),
          ),
        ),
      Tarjeta(
        color: context.colores.primarioPalido,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Icon(Icons.groups_outlined, color: context.esquema.primary, size: 30),
            const SizedBox(width: 12),
            Expanded(child: Text('Preparador de ${Oposiciones.actual.siglas}', style: context.textos.titleMedium)),
          ]),
          const SizedBox(height: 6),
          if (hoy.isEmpty)
            fila(Icons.view_week_outlined, 'Hoy no tienes clases', () => ir(const SemanaPage()), detalle: 'Tu semana, con todas tus clases')
          else
            fila(
              Icons.view_week_outlined,
              hoy.length == 1 ? 'Hoy tienes 1 clase' : 'Hoy tienes ${hoy.length} clases',
              () => ir(const SemanaPage()),
              detalle: [for (final s in hoy) '${horaDe(s.fecha)} ${nombres[s.alumno] ?? ''}'.trim()].join(' · '),
            ),
          if (reservas > 0) fila(Icons.event_available_outlined, reservas == 1 ? '1 reserva por confirmar' : '$reservas reservas por confirmar', () => ir(const SemanaPage())),
          if (tablon > 0) fila(Icons.campaign_outlined, tablon == 1 ? '1 alumno busca preparador' : '$tablon alumnos buscan preparador', () => ir(const TablonPage()), detalle: 'Tablón de clases sueltas'),
          if (solicitudes > 0) fila(Icons.how_to_reg_outlined, solicitudes == 1 ? '1 preparador pide que le verifiques' : '$solicitudes preparadores piden que les verifiques', () => ir(const VerificarPreparadoresPage())),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(onPressed: () => context.go('/mas/preparador'), icon: const Icon(Icons.arrow_forward, size: 18), label: const Text('Ir a Preparador')),
          ),
        ]),
      ),
    ]);
  }
}

/// Tarjeta de Hoy para elegir el papel en esta oposición, una vez: a quien
/// acaba de actualizar desde una versión sin papeles y a quien cambia a una
/// oposición en la que aún no lo ha elegido.
class TarjetaElegirPapel extends ConsumerWidget {
  const TarjetaElegirPapel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfil = ref.watch(perfilPreparadorProvider);
    if (perfil.papelElegido) return const SizedBox.shrink();
    final siglas = Oposiciones.actual.siglas;
    final notifier = ref.read(perfilPreparadorProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        color: context.colores.dorado.withValues(alpha: 0.12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('¿Cómo usas la app en $siglas?', style: context.textos.titleMedium),
          const SizedBox(height: 4),
          Text(
            perfil.activo
                ? 'Ahora en cada oposición se es opositor o preparador. En $siglas tienes la sección de preparador: si sigues como preparador, dejarás de compartir tu progreso con tus propios preparadores de $siglas (tus datos se quedan).'
                : 'En cada oposición se es opositor o preparador. Si preparas a opositores de $siglas, date de alta como preparador.',
            style: context.textos.bodySmall,
          ),
          const SizedBox(height: 10),
          Wrap(spacing: 10, runSpacing: 8, children: [
            if (perfil.activo) ...[
              FilledButton(onPressed: () => notifier.fijarPapel(Papel.preparador), child: const Text('Sigo como preparador')),
              OutlinedButton(onPressed: () => notifier.fijarPapel(Papel.opositor), child: const Text('Soy opositor')),
            ] else ...[
              FilledButton(onPressed: () => notifier.fijarPapel(Papel.opositor), child: const Text('Me preparo la oposición')),
              OutlinedButton(onPressed: () => context.go('/mas/preparador'), child: const Text('Soy preparador')),
            ],
          ]),
        ]),
      ),
    );
  }
}
