import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/notificaciones.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'red_widgets.dart';

/// Ajustes del preparador: nombre, teléfono para las sustituciones, avisos y
/// huecos libres que sus alumnos pueden reservar (desactivado por defecto).
class AjustesPreparadorPage extends ConsumerWidget {
  const AjustesPreparadorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfil = ref.watch(perfilPreparadorProvider);
    final notifier = ref.read(perfilPreparadorProvider.notifier);
    final verificado = ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false;
    final huecos = [...perfil.huecos]..sort((a, b) => a.diaSemana != b.diaSemana ? a.diaSemana.compareTo(b.diaSemana) : a.minutoDelDia.compareTo(b.minutoDelDia));

    Future<void> editarNombre() async {
      final ctrl = TextEditingController(text: perfil.nombre);
      final n = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Tu nombre'),
          content: TextField(controller: ctrl, autofocus: true, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(helperText: 'Así te ven tus alumnos y los demás preparadores')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, ctrl.text.trim()), child: const Text('Guardar')),
          ],
        ),
      );
      if (n == null || n.isEmpty) return;
      await notifier.renombrar(n);
      if (verificado) {
        try {
          await ref.read(redRepoProvider).actualizarMiFicha(nombre: n);
        } catch (_) {}
      }
    }

    Future<void> nuevoHueco() async {
      final f = await elegirFranja(context, titulo: 'Hueco libre');
      if (f == null) return;
      final h = Hueco(diaSemana: f.dia, minutoDelDia: f.minuto, minutos: f.minutos);
      if (!perfil.huecos.contains(h)) await notifier.guardar(perfil.copyWith(huecos: [...perfil.huecos, h]));
    }

    return Scaffold(
      appBar: BarraWeb(title: const Text('Ajustes de preparador')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Nombre'),
                subtitle: Text(perfil.nombre.isEmpty ? 'Sin nombre' : perfil.nombre, style: context.textos.labelSmall),
                trailing: const Icon(Icons.edit_outlined, size: 18),
                onTap: editarNombre,
              ),
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Perfil de LinkedIn'),
                subtitle: Text(perfil.linkedin.isEmpty ? 'Opcional: sale en el directorio de preparadores' : perfil.linkedin, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
                trailing: const Icon(Icons.edit_outlined, size: 18),
                onTap: () async {
                  final ctrl = TextEditingController(text: perfil.linkedin);
                  final t = await showDialog<String>(
                    context: context,
                    builder: (d) => StatefulBuilder(
                      builder: (d, set) {
                        final valido = ctrl.text.trim().isEmpty || enlaceLinkedin(ctrl.text) != null;
                        return AlertDialog(
                          title: const Text('Perfil de LinkedIn'),
                          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Los opositores lo verán en el directorio de preparadores verificados. Déjalo vacío para quitarlo.', style: Theme.of(d).textTheme.bodySmall),
                            const SizedBox(height: 10),
                            TextField(
                              controller: ctrl,
                              autofocus: true,
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(hintText: 'linkedin.com/in/tu-perfil', errorText: valido ? null : 'Pega el enlace a tu perfil (linkedin.com/in/…)'),
                              onChanged: (_) => set(() {}),
                            ),
                          ]),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
                            FilledButton(onPressed: valido ? () => Navigator.pop(d, ctrl.text.trim().isEmpty ? '' : enlaceLinkedin(ctrl.text)!) : null, child: const Text('Guardar')),
                          ],
                        );
                      },
                    ),
                  );
                  if (t == null) return;
                  await notifier.guardar(perfil.copyWith(linkedin: t));
                  if (verificado) {
                    try {
                      await ref.read(redRepoProvider).actualizarMiFicha(linkedin: t);
                      ref.invalidate(verificadosProvider);
                    } catch (_) {}
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Teléfono para WhatsApp'),
                subtitle: Text(perfil.telefono.isEmpty ? 'Se pide al coger una clase suelta' : '${perfil.telefono} · solo lo ve el alumno cuyo cante coges', style: context.textos.labelSmall),
                trailing: const Icon(Icons.edit_outlined, size: 18),
                onTap: () async {
                  final t = await pedirTelefono(context, inicial: perfil.telefono, explicacion: 'Cuando cojas una clase suelta, el alumno lo recibirá para escribirte. Nadie más lo ve.');
                  if (t != null) await notifier.guardar(perfil.copyWith(telefono: t));
                },
              ),
            ]),
          ),
          const TituloSeccion('Avisos'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
            SwitchListTile(
              value: perfil.avisosSustitucion,
              title: const Text('Clases sueltas: cuando un alumno pide una'),
              subtitle: Text(
                kIsWeb
                    ? 'En el navegador, mientras tengas la app abierta en una pestaña. En el móvil llegan también con la app cerrada.'
                    : 'También con la app cerrada: se comprueba cada 15 minutos aproximadamente, con conexión.',
                style: context.textos.labelSmall,
              ),
              onChanged: (v) async {
                if (v) {
                  kIsWeb ? await pedirPermisoNotificacionesNavegador() : await Notificaciones.pedirPermiso();
                }
                await notifier.guardar(perfil.copyWith(avisosSustitucion: v));
              },
            ),
            SwitchListTile(
              value: perfil.avisosReservas,
              title: const Text('Reservas: cuando un alumno reserva clase'),
              onChanged: (v) async {
                if (v) {
                  kIsWeb ? await pedirPermisoNotificacionesNavegador() : await Notificaciones.pedirPermiso();
                }
                await notifier.guardar(perfil.copyWith(avisosReservas: v));
              },
            ),
            ]),
          ),
          const TituloSeccion('Reservas de tus alumnos'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: SwitchListTile(
              value: perfil.reservas,
              title: const Text('Mis alumnos pueden reservar clase'),
              subtitle: Text('Ven tus huecos libres (no con quién estás el resto del tiempo) y piden clase; tú la aceptas o la rechazas.', style: context.textos.labelSmall),
              onChanged: verificado ? (v) => notifier.guardar(perfil.copyWith(reservas: v)) : null,
            ),
          ),
          if (!verificado) Padding(padding: const EdgeInsets.only(top: 6), child: Text('Disponible cuando estés verificado.', style: context.textos.labelSmall)),
          if (perfil.reservas) ...[
            TituloSeccion('Huecos semanales', accion: TextButton.icon(onPressed: nuevoHueco, icon: const Icon(Icons.add, size: 18), label: const Text('Hueco'))),
            if (huecos.isEmpty)
              Text('Añade los huecos de la semana en los que aceptas cantes (por ejemplo, martes a las 18:00).', style: context.textos.bodySmall)
            else
              Tarjeta(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  for (final h in huecos)
                    ListTile(
                      dense: true,
                      leading: const Icon(Icons.event_available_outlined),
                      title: Text('${nombresDias[h.diaSemana - 1]} · ${horaMinutos(h.minutoDelDia)}'),
                      subtitle: Text('${h.minutos} min', style: context.textos.labelSmall),
                      trailing: IconButton(
                        tooltip: 'Quitar',
                        icon: const Icon(Icons.close),
                        onPressed: () => notifier.guardar(perfil.copyWith(huecos: perfil.huecos.where((x) => x != h).toList())),
                      ),
                    ),
                ]),
              ),
            Padding(padding: const EdgeInsets.only(top: 6), child: Text('Un hueco deja de ofrecerse cuando ya tienes una clase a esa hora.', style: context.textos.labelSmall)),
          ],
        ],
      ),
    );
  }
}

/// Para mostrar la franja de una reserva o hueco concreto.
String franja(DateTime f, int minutos) => '${horaMinutos(f.hour * 60 + f.minute)}–${horaMinutos(f.hour * 60 + f.minute + minutos)}';

/// [Reserva] legible en una línea.
String describirReserva(Reserva r) => '${r.alumnoNombre.isEmpty ? 'Alumno' : r.alumnoNombre} · ${franja(r.fecha, r.minutos)}';
