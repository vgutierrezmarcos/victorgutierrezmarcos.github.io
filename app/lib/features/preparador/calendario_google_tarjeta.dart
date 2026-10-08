import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/permiso_calendario.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/repos/preparador_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Si la cuenta puede conectar Google Calendar (mientras Google no verifica
/// el permiso, solo las que apunta el administrador) y, si no, por qué.
final calendarioPermitidoProvider = FutureProvider<PermisoCalendario>((ref) async {
  ref.watch(usuarioActualProvider);
  // Verificado el permiso por Google, se abre a todos desde app-config.json
  // (`app.calendarioParaTodos`) sin publicar una versión nueva.
  if (await ref.watch(calendarioParaTodosProvider.future)) return PermisoCalendario.permitido;
  return ref.watch(preparadorRepoProvider).calendarioPermitido();
});

/// Si Google Calendar ya está abierto a todos los preparadores.
final calendarioParaTodosProvider = FutureProvider<bool>((ref) async {
  try {
    return (await ref.watch(configProvider.future)).calendarioParaTodos;
  } catch (_) {
    return false;
  }
});

/// El último error de Google al llevar una clase al calendario (null si no hay).
final errorCalendarioProvider = Provider<String?>((ref) {
  // Se vuelve a leer cuando cambian las sesiones (es cuando se habla con Google).
  ref.watch(sesionesProvider);
  return ref.watch(preparadorRepoProvider).calendario?.ultimoError;
});

/// En Ajustes del preparador: llevar las clases a su Google Calendar, con la
/// reunión de Meet de las online y la invitación al alumno. Si la cuenta no
/// puede todavía, dice por qué.
class TarjetaCalendarioGoogle extends ConsumerStatefulWidget {
  const TarjetaCalendarioGoogle({super.key});

  @override
  ConsumerState<TarjetaCalendarioGoogle> createState() => _TarjetaCalendarioGoogleState();
}

class _TarjetaCalendarioGoogleState extends ConsumerState<TarjetaCalendarioGoogle> {
  bool _ocupado = false;

  Future<void> _alternar(bool si) async {
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(perfilPreparadorProvider.notifier);
    final repo = ref.read(preparadorRepoProvider);
    if (!si) {
      await notifier.guardar(ref.read(perfilPreparadorProvider).copyWith(calendarioGoogle: false));
      messenger.showSnackBar(const SnackBar(content: Text('Las clases nuevas ya no irán a tu calendario. Las que ya están se quedan.')));
      return;
    }
    setState(() => _ocupado = true);
    try {
      if (!await pedirPermisoCalendario()) {
        messenger.showSnackBar(const SnackBar(content: Text('Google no ha dado acceso a tu calendario. Si sale «aplicación no verificada», entra en «Configuración avanzada» y continúa.')));
        return;
      }
      final cal = repo.calendario;
      if (cal == null) return;
      try {
        await cal.comprobar();
      } catch (e) {
        // Permiso retirado desde la cuenta de Google (o token caducado): se
        // vuelve a pedir desde cero, con la ventana de Google, y se reintenta.
        if (permisoRetirado(e) && await renovarPermisoCalendario()) {
          try {
            await cal.comprobar();
          } catch (e2) {
            cal.ultimoError = e2.toString();
            messenger.showSnackBar(SnackBar(content: Text('Google no deja usar tu calendario desde la app todavía: $e2')));
            return;
          }
        } else {
          cal.ultimoError = e.toString();
          messenger.showSnackBar(SnackBar(content: Text(permisoRetirado(e) ? 'Google ha retirado el permiso del calendario y no se ha podido volver a pedir. Prueba otra vez.' : 'Google no deja usar tu calendario desde la app todavía: $e')));
          return;
        }
      }
      cal.ultimoError = null;
      await notifier.guardar(ref.read(perfilPreparadorProvider).copyWith(calendarioGoogle: true));
      final n = await repo.llevarClasesAlCalendario();
      ref.invalidate(sesionesProvider);
      messenger.showSnackBar(SnackBar(content: Text(n == 0 ? 'Conectado. Las clases que programes irán a tu Google Calendar.' : 'Conectado: $n ${n == 1 ? 'clase' : 'clases'} en tu Google Calendar.')));
    } finally {
      if (mounted) setState(() => _ocupado = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final permiso = ref.watch(calendarioPermitidoProvider);
    final verificado = ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false;
    final usuario = ref.watch(usuarioActualProvider);
    // Sin sesión o sin verificar no tiene sentido; con sesión se enseña siempre,
    // aunque sea para decir por qué no se puede todavía.
    if (usuario == null || !verificado) return const SizedBox.shrink();
    final activo = ref.watch(perfilPreparadorProvider).calendarioGoogle;
    final error = ref.watch(errorCalendarioProvider);
    final p = permiso.valueOrNull;
    final puede = p == PermisoCalendario.permitido;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const TituloSeccion('Google Calendar'),
      Tarjeta(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (puede && calendarioDisponible)
            SwitchListTile(
              value: activo,
              onChanged: _ocupado ? null : _alternar,
              secondary: _ocupado
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4))
                  : Icon(Icons.event_available_outlined, color: context.esquema.primary),
              title: const Text('Mis clases en Google Calendar'),
              subtitle: Text(
                'Cada clase va a tu Google Calendar y al alumno le llega la invitación. Si es online, sin enlace y con Meet, se crea su reunión. '
                'Al cambiarla o cancelarla, se cambia o se quita del calendario.',
                style: context.textos.labelSmall,
              ),
            )
          else if (puede)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Text('Se conecta desde la app del móvil. Después, las clases que programes aquí también irán a tu calendario cuando el móvil sincronice.', style: context.textos.bodySmall),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.event_busy_outlined, color: context.colores.textoClaro),
                  const SizedBox(width: 10),
                  Expanded(child: Text('Mis clases en Google Calendar', style: context.textos.titleSmall)),
                ]),
                const SizedBox(height: 6),
                Text(
                  switch (p) {
                    null => permiso.isLoading ? 'Comprobando si tu cuenta puede usarlo…' : 'No se ha podido comprobar.',
                    PermisoCalendario.noEnLista => 'Todavía en pruebas: tu cuenta (${usuario.email ?? 'sin correo'}) no está en la lista de prueba. Se abrirá a todos los preparadores cuando Google verifique el permiso.',
                    PermisoCalendario.sinPermiso => 'No se ha podido comprobar: el servidor no deja leer la lista de prueba (faltan por publicar las reglas nuevas).',
                    PermisoCalendario.sinRed => 'No se ha podido comprobar: sin conexión.',
                    PermisoCalendario.sinSesion => 'Inicia sesión con Google.',
                    PermisoCalendario.permitido => '',
                  },
                  style: context.textos.bodySmall,
                ),
                Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => ref.invalidate(calendarioPermitidoProvider), child: const Text('Volver a comprobar'))),
              ]),
            ),
          if (puede)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Text(
                '${ref.watch(calendarioParaTodosProvider).valueOrNull ?? false ? '' : 'En pruebas. '}Al alumno se le invita con el correo de su cuenta de Google si ha enlazado su app, o con el que apuntes en su ficha.',
                style: context.textos.labelSmall,
              ),
            ),
          if (activo && error != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text('La última vez Google respondió con un error (se reintenta al guardar la clase): $error', style: context.textos.labelSmall?.copyWith(color: context.esquema.error)),
            ),
        ]),
      ),
    ]);
  }
}
