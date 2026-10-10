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

/// Clave (caja `app`) de que ya se pidió que la batería no restrinja la app
/// (a quien ya había visto la hoja de los avisos se le pide una vez aparte).
const claveBateriaPedida = 'bateria_pedida';

/// Lo que permite el sistema ahora (se vuelve a mirar al volver a la app).
final permisosProvider = FutureProvider<EstadoPermisos>((ref) => comprobarPermisos());

/// Fabricante del móvil (para los consejos de su ahorro de batería).
final fabricanteProvider = FutureProvider<String?>((ref) => fabricanteMovil());

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

/// La primera vez que se abre la app: para qué sirven los avisos, el permiso
/// para mostrarlos y, en Android, el de alarmas exactas (los avisos del
/// cronómetro a su segundo) y que la batería no restrinja la app. A quien ya
/// la había visto antes de que se pidiera lo de la batería, se le pide eso solo
/// (una vez y si la batería la restringe).
Future<void> mostrarHojaPermisosSiToca(BuildContext context) async {
  if (!Notificaciones.disponibles || !Hive.isBoxOpen(Cajas.app)) return;
  final caja = Hive.box(Cajas.app);
  if (caja.get(clavePermisosPedidos) == true) {
    if (kIsWeb || caja.get(claveBateriaPedida) == true) return;
    final p = await comprobarPermisos();
    if (!p.bateriaRestringida || p.notificaciones != true) return;
    await caja.put(claveBateriaPedida, true);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(context: context, isScrollControlled: true, showDragHandle: true, builder: (_) => const HojaPermisos(soloBateria: true));
    return;
  }
  await caja.putAll({clavePermisosPedidos: true, claveBateriaPedida: true});
  if (!context.mounted) return;
  await showModalBottomSheet<void>(context: context, isScrollControlled: true, showDragHandle: true, builder: (_) => const HojaPermisos());
}

class HojaPermisos extends ConsumerStatefulWidget {
  const HojaPermisos({super.key, this.soloBateria = false});
  /// Solo lo de la batería (los avisos ya se pidieron antes).
  final bool soloBateria;
  @override
  ConsumerState<HojaPermisos> createState() => _HojaPermisosState();
}

class _HojaPermisosState extends ConsumerState<HojaPermisos> {
  bool _ocupado = false;
  bool? _notificaciones;
  bool? _exactas;
  /// Último paso: el ahorro de batería propio del fabricante del móvil.
  ({String nombre, String pasos})? _fabricante;

  /// Que la batería no restrinja la app (diálogo del sistema) y, si el móvil
  /// tiene su propio ahorro de batería, el paso de su fabricante. Devuelve si
  /// la hoja se queda abierta para ese paso.
  Future<bool> _bateria() async {
    if (kIsWeb) return false;
    final p = await comprobarPermisos();
    if (p.bateriaRestringida) await pedirSinRestriccionBateria();
    final consejo = consejoFabricante(await fabricanteMovil());
    ref.invalidate(permisosProvider);
    if (consejo == null || !mounted) return false;
    setState(() => _fabricante = consejo);
    return true;
  }

  Future<void> _permitir() async {
    setState(() => _ocupado = true);
    final n = await Notificaciones.pedirPermiso();
    var e = await Notificaciones.alarmasExactas();
    if (e == false) e = await pedirAlarmasExactas();
    ref.invalidate(permisosProvider);
    if (!mounted) return;
    setState(() {
      _notificaciones = n;
      _exactas = e;
    });
    final sigue = n && await _bateria();
    if (!mounted) return;
    setState(() => _ocupado = false);
    if (n && e != false && !sigue) Navigator.of(context).pop();
  }

  Future<void> _soloBateria() async {
    setState(() => _ocupado = true);
    final sigue = await _bateria();
    if (!mounted) return;
    setState(() => _ocupado = false);
    if (!sigue) Navigator.of(context).pop();
  }

  /// El paso del fabricante (Xiaomi, Samsung…): qué tocar y un botón a sus ajustes.
  Widget _pasoFabricante(({String nombre, String pasos}) f) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Un paso más en tu ${f.nombre}', style: context.textos.titleLarge),
            const SizedBox(height: 6),
            Text('Los móviles ${f.nombre} tienen su propio ahorro de batería, aparte del de Android, que también puede retrasar los avisos con la app cerrada. Para que lleguen a su hora:', style: context.textos.bodySmall),
            const SizedBox(height: 10),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.battery_charging_full, size: 20, color: context.esquema.primary),
              const SizedBox(width: 10),
              Expanded(child: Text(f.pasos, style: context.textos.bodyMedium)),
            ]),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () async {
                await abrirAjustesFabricante();
                if (mounted) Navigator.of(context).pop();
              },
              icon: const Icon(Icons.settings_outlined),
              label: Text('Abrir los ajustes de ${f.nombre}'),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ya está o más tarde')),
            Text('Lo tienes también en Más → Ajustes.', textAlign: TextAlign.center, style: context.textos.labelSmall),
          ]),
        ),
      );

  /// Solo lo de la batería, a quien ya había visto la hoja de los avisos.
  Widget _pasoBateria() => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Que los avisos lleguen a su hora', style: context.textos.titleLarge),
            const SizedBox(height: 6),
            Text(
              'El sistema está ahorrando batería con la app: con ella cerrada, los avisos de tus clases y de los temas que te mandan pueden llegar tarde o no llegar. Permite que funcione en segundo plano; gasta muy poca batería, porque solo mira lo nuevo cada 15 minutos más o menos.',
              style: context.textos.bodySmall,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: _ocupado ? null : _soloBateria,
              icon: _ocupado ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.battery_charging_full),
              label: const Text('Permitir en segundo plano'),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Ahora no')),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_fabricante case final f?) return _pasoFabricante(f);
    if (widget.soloBateria) return _pasoBateria();
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
                : 'Para que te lleguen aunque la app esté cerrada, el sistema tiene que permitir que muestre notificaciones y que funcione en segundo plano (gasta muy poca batería). Con la app abierta llega todo al momento; cerrada, el móvil mira lo nuevo cada 15 minutos más o menos (los temas, a su hora exacta). Solo se usan para esto:',
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
                  : 'Activados. Con la app abierta llega todo al momento; cerrada, cada 15 minutos más o menos: si esperas algo, ábrela.${p?.alarmasExactas == false ? ' Sin alarmas exactas: los avisos del cronómetro pueden retrasarse.' : ''}',
          style: context.textos.labelSmall,
        ),
        trailing: Icon(kIsWeb ? Icons.chevron_right : Icons.open_in_new, size: 18),
        onTap: () async {
          kIsWeb ? await asegurarAvisos(context) : await abrirAjustesNotificaciones();
          ref.invalidate(permisosProvider);
        },
      ),
      if (p?.bateriaRestringida ?? false)
        ListTile(
          leading: Icon(Icons.battery_saver_outlined, color: context.esquema.error),
          title: const Text('La batería restringe la app'),
          subtitle: Text('Con la app cerrada, los avisos pueden llegar tarde. Toca para permitir que funcione en segundo plano.', style: context.textos.labelSmall),
          trailing: const Icon(Icons.chevron_right, size: 18),
          onTap: () async {
            await pedirSinRestriccionBateria();
            ref.invalidate(permisosProvider);
          },
        ),
      if (consejoFabricante(kIsWeb ? null : ref.watch(fabricanteProvider).valueOrNull) case final f?)
        ListTile(
          leading: const Icon(Icons.battery_charging_full),
          title: Text('Ahorro de batería de ${f.nombre}'),
          subtitle: Text('Para que los avisos lleguen con la app cerrada: ${f.pasos}', style: context.textos.labelSmall),
          trailing: const Icon(Icons.open_in_new, size: 18),
          onTap: abrirAjustesFabricante,
        ),
    ]);
  }
}
