import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/permisos.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// En el navegador, el permiso se cambia desde el candado de la barra de direcciones.
const _textoBloqueadosNavegador = 'El navegador no deja a la web mostrar avisos. Para recibirlos (clases, temas del preparador, recordatorios), permite las notificaciones de esta web: en el candado o el icono de ajustes junto a la dirección → Notificaciones → Permitir.';

/// Clave (caja `app`) de que ya se pidieron los permisos la primera vez.
const clavePermisosPedidos = 'permisos_pedidos';

/// Lo que permite el sistema ahora (se vuelve a mirar al volver a la app).
final permisosProvider = FutureProvider<EstadoPermisos>((ref) => comprobarPermisos());

/// Pide el permiso de notificaciones y, si está denegado en el sistema, lo
/// explica con un botón a los ajustes. Devuelve si los avisos pueden llegar.
Future<bool> asegurarAvisos(BuildContext context) async {
  if (!Notificaciones.disponibles) return true;
  if (await Notificaciones.pedirPermiso()) return true;
  if (!context.mounted) return false;
  if (kIsWeb) {
    await showDialog<void>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Los avisos están bloqueados'),
        content: const Text(_textoBloqueadosNavegador),
        actions: [FilledButton(onPressed: () => Navigator.pop(d), child: const Text('Entendido'))],
      ),
    );
    return false;
  }
  final abrir = await showDialog<bool>(
    context: context,
    builder: (d) => AlertDialog(
      title: const Text('Los avisos están desactivados'),
      content: const Text('El sistema no deja a la app mostrar notificaciones. Para recibir los avisos (clases, temas del preparador, recordatorios), actívalas en los ajustes del sistema.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Ahora no')),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Abrir ajustes')),
      ],
    ),
  );
  if (abrir == true) await abrirAjustesNotificaciones();
  return false;
}

/// La primera vez que se abre la app (o la primera con esta versión): para
/// qué sirven los avisos y el permiso para mostrarlos; en Android 12+,
/// también el de alarmas exactas (los avisos del cronómetro a su segundo).
Future<void> mostrarHojaPermisosSiToca(BuildContext context) async {
  if (!Notificaciones.disponibles || !Hive.isBoxOpen(Cajas.app)) return;
  final caja = Hive.box(Cajas.app);
  if (caja.get(clavePermisosPedidos) == true) return;
  await caja.put(clavePermisosPedidos, true);
  if (!context.mounted) return;
  await showModalBottomSheet<void>(context: context, isScrollControlled: true, showDragHandle: true, builder: (_) => const HojaPermisos());
}

class HojaPermisos extends ConsumerStatefulWidget {
  const HojaPermisos({super.key});
  @override
  ConsumerState<HojaPermisos> createState() => _HojaPermisosState();
}

class _HojaPermisosState extends ConsumerState<HojaPermisos> {
  bool _ocupado = false;
  bool? _notificaciones;
  bool? _exactas;

  Future<void> _permitir() async {
    setState(() => _ocupado = true);
    final n = await Notificaciones.pedirPermiso();
    var e = await Notificaciones.alarmasExactas();
    if (e == false) e = await pedirAlarmasExactas();
    ref.invalidate(permisosProvider);
    if (!mounted) return;
    setState(() {
      _ocupado = false;
      _notificaciones = n;
      _exactas = e;
    });
    if (n && e != false) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final denegado = _notificaciones == false;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Avisos de la app', style: context.textos.titleLarge),
          const SizedBox(height: 6),
          Text(
            kIsWeb
                ? 'En el navegador llegan mientras tengas la web abierta (aunque estés en otra pestaña o la ventana esté minimizada), si el navegador lo permite. Solo se usan para esto:'
                : 'Para que te lleguen aunque la app esté cerrada, el sistema tiene que permitir que muestre notificaciones. Solo se usan para esto:',
            style: context.textos.bodySmall,
          ),
          const SizedBox(height: 10),
          for (final (icono, texto) in const [
            (Icons.event_outlined, 'Clases que tu preparador programa, mueve o cancela (o, si eres preparador, las que reservan o piden tus alumnos).'),
            (Icons.forward_to_inbox_outlined, 'El tema que te manda tu preparador antes de la clase, a su hora.'),
            (Icons.timer_outlined, 'Los avisos del cronómetro al cantar, y el recordatorio del test diario si lo activas.'),
            (Icons.system_update_outlined, 'Cuando hay una versión nueva.'),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(icono, size: 20, color: context.esquema.primary),
                const SizedBox(width: 10),
                Expanded(child: Text(texto, style: context.textos.bodySmall)),
              ]),
            ),
          if (denegado) ...[
            const SizedBox(height: 6),
            Text(kIsWeb ? _textoBloqueadosNavegador : 'El sistema ha denegado el permiso. Puedes activarlo en los ajustes de la app.', style: context.textos.bodySmall?.copyWith(color: context.esquema.error)),
          ],
          if (_notificaciones == true && _exactas == false) ...[
            const SizedBox(height: 6),
            Text('Sin «alarmas exactas», los avisos del cronómetro pueden llegar con algo de retraso. Se activan en los ajustes de la app.', style: context.textos.bodySmall),
          ],
          const SizedBox(height: 14),
          if (kIsWeb && denegado)
            FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Entendido'))
          else if (denegado || (_notificaciones == true && _exactas == false))
            FilledButton.icon(
              onPressed: () async {
                await abrirAjustesNotificaciones();
                if (context.mounted) Navigator.of(context).pop();
              },
              icon: const Icon(Icons.settings_outlined),
              label: const Text('Abrir ajustes de la app'),
            )
          else
            FilledButton.icon(
              onPressed: _ocupado ? null : _permitir,
              icon: _ocupado ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.notifications_active_outlined),
              label: const Text('Permitir los avisos'),
            ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
        ]),
      ),
    );
  }
}

/// Tarjeta de Hoy cuando el sistema no deja mostrar notificaciones: los
/// avisos activados no pueden llegar.
class TarjetaAvisosDesactivados extends ConsumerWidget {
  const TarjetaAvisosDesactivados({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permisos = ref.watch(permisosProvider).valueOrNull;
    if (permisos == null || !permisos.avisosBloqueados) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        color: context.esquema.errorContainer.withValues(alpha: 0.35),
        child: Row(children: [
          Icon(Icons.notifications_off_outlined, color: context.esquema.error, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Los avisos no pueden llegar', style: context.textos.titleMedium),
              Text(kIsWeb ? 'El navegador bloquea los avisos de esta web: no te enterarás de las clases ni de los temas de tu preparador mientras la tengas abierta.' : 'El sistema tiene desactivadas las notificaciones de la app: no te enterarás de las clases ni de los temas de tu preparador.', style: context.textos.bodySmall),
            ]),
          ),
          const SizedBox(width: 8),
          FilledButton(onPressed: () => kIsWeb ? asegurarAvisos(context).then((_) => ref.invalidate(permisosProvider)) : abrirAjustesNotificaciones(), child: const Text('Activar')),
        ]),
      ),
    );
  }
}

/// Fila de Más → Ajustes: estado de los avisos en el sistema y batería.
class FilasAvisosSistema extends ConsumerWidget {
  const FilasAvisosSistema({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!Notificaciones.disponibles) return const SizedBox.shrink();
    final p = ref.watch(permisosProvider).valueOrNull;
    final activadas = p?.notificaciones;
    return Column(children: [
      ListTile(
        leading: Icon(activadas == false ? Icons.notifications_off_outlined : Icons.notifications_none, color: activadas == false ? context.esquema.error : null),
        title: Text(kIsWeb ? 'Avisos del navegador' : 'Avisos del sistema'),
        subtitle: Text(
          kIsWeb
              ? switch (activadas) {
                  false => 'Bloqueados por el navegador. Toca para ver cómo permitirlos.',
                  true => 'Activados: llegan mientras tengas la web abierta (aunque sea en otra pestaña). Con la web cerrada, solo en la app del móvil.',
                  null => 'Toca para permitirlos. Llegan mientras tengas la web abierta.',
                }
              : activadas == false
                  ? 'Desactivados: la app no puede mostrar notificaciones. Toca para activarlos.'
                  : 'Activados.${p?.alarmasExactas == false ? ' Sin alarmas exactas: los avisos del cronómetro pueden retrasarse.' : ''}',
          style: context.textos.labelSmall,
        ),
        trailing: Icon(kIsWeb ? Icons.chevron_right : Icons.open_in_new, size: 18),
        onTap: () async {
          kIsWeb ? await asegurarAvisos(context) : await abrirAjustesNotificaciones();
          ref.invalidate(permisosProvider);
        },
      ),
      if (p?.bateriaSinOptimizar == false)
        ListTile(
          leading: const Icon(Icons.battery_saver_outlined),
          title: const Text('Avisos con la app cerrada'),
          subtitle: Text('Si llegan tarde, quita la app de la optimización de batería del sistema.', style: context.textos.labelSmall),
          trailing: const Icon(Icons.open_in_new, size: 18),
          onTap: () async {
            await abrirAjustesBateria();
            ref.invalidate(permisosProvider);
          },
        ),
    ]);
  }
}
