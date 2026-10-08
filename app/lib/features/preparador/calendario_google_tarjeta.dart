import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/permiso_calendario.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Si la cuenta puede conectar Google Calendar (mientras Google no verifica
/// el permiso, solo las que apunta el administrador).
final calendarioPermitidoProvider = FutureProvider<bool>((ref) async {
  ref.watch(usuarioActualProvider);
  return ref.watch(preparadorRepoProvider).calendarioPermitido();
});

/// En Ajustes del preparador: llevar las clases a su Google Calendar, con la
/// reunión de Meet de las online y la invitación al alumno.
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
        messenger.showSnackBar(const SnackBar(content: Text('Google no ha dado acceso a tu calendario.')));
        return;
      }
      final cal = repo.calendario;
      if (cal == null) return;
      try {
        await cal.comprobar();
      } catch (_) {
        messenger.showSnackBar(const SnackBar(content: Text('Google no deja usar tu calendario desde la app todavía. Vuelve a intentarlo más tarde.')));
        return;
      }
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
    final permitido = ref.watch(calendarioPermitidoProvider).valueOrNull ?? false;
    if (!permitido) return const SizedBox.shrink();
    final activo = ref.watch(perfilPreparadorProvider).calendarioGoogle;
    final error = ref.read(preparadorRepoProvider).calendario?.ultimoError;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const TituloSeccion('Google Calendar'),
      Tarjeta(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (calendarioDisponible)
            SwitchListTile(
              value: activo,
              onChanged: _ocupado ? null : _alternar,
              secondary: _ocupado
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4))
                  : Icon(Icons.event_available_outlined, color: context.esquema.primary),
              title: const Text('Mis clases en Google Calendar'),
              subtitle: Text(
                'Cada clase va a tu Google Calendar y al alumno le llega la invitación. Si es online y no tiene enlace, se crea su reunión de Meet. '
                'Al cambiarla o cancelarla, se cambia o se quita del calendario.',
                style: context.textos.labelSmall,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Text('Se conecta desde la app del móvil. Después, las clases que programes aquí también irán a tu calendario cuando las abras en el móvil.', style: context.textos.bodySmall),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Text(
              'En pruebas. Al alumno se le invita con el correo de su cuenta de Google si ha enlazado su app, o con el que apuntes en su ficha.',
              style: context.textos.labelSmall,
            ),
          ),
          if (activo && error != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text('La última vez Google respondió con un error; se reintenta al guardar la clase.', style: context.textos.labelSmall?.copyWith(color: context.esquema.error)),
            ),
        ]),
      ),
    ]);
  }
}
