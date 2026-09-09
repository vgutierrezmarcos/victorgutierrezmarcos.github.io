import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Cuenta: Google Sign-In, sincronización, exportación y borrado de datos.
class CuentaPage extends ConsumerWidget {
  const CuentaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    final ocupado = ref.watch(sesionProvider);
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final repo = ref.read(usuarioRepoProvider);
    final pendientes = repo.resultadosLocales().where((r) => !r.sincronizado).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!firebase)
            Tarjeta(child: Text('Esta compilación no incluye credenciales de Firebase: la app funciona solo en local.', style: context.textos.bodySmall))
          else if (usuario == null) ...[
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Sincroniza con la web', style: context.textos.titleMedium),
                const SizedBox(height: 6),
                Text('Con tu cuenta de Google, los tests que hagas aquí y en victorgutierrezmarcos.es se guardan en el mismo historial, junto con el repaso, tus notas y la fecha del examen.', style: context.textos.bodySmall),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: ocupado
                      ? null
                      : () async {
                          final err = await ref.read(sesionProvider.notifier).iniciarConGoogle();
                          if (err != null && context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No se pudo iniciar sesión: $err')));
                        },
                  icon: ocupado ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.login),
                  label: const Text('Iniciar sesión con Google'),
                ),
              ]),
            ),
          ] else ...[
            Tarjeta(
              child: Row(children: [
                if (usuario.photoURL != null) CircleAvatar(radius: 26, backgroundImage: NetworkImage(usuario.photoURL!)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(usuario.displayName ?? '', style: context.textos.titleMedium),
                  Text(usuario.email ?? '', style: context.textos.bodySmall),
                  if (pendientes > 0) Text('$pendientes resultados pendientes de subir', style: context.textos.labelSmall?.copyWith(color: context.colores.dorado)),
                ])),
              ]),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () async {
                await repo.sincronizarTodo();
                ref.invalidate(historialProvider);
                ref.invalidate(leitnerProvider);
                ref.invalidate(ajustesProvider);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sincronizado')));
              },
              icon: const Icon(Icons.sync),
              label: const Text('Sincronizar ahora'),
            ),
            TextButton.icon(onPressed: () => ref.read(sesionProvider.notifier).cerrarSesion(), icon: const Icon(Icons.logout), label: const Text('Cerrar sesión')),
          ],
          const TituloSeccion('Tus datos'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.file_download_outlined),
                title: const Text('Exportar datos (JSON)'),
                subtitle: Text('Resultados, repaso, ajustes y notas', style: context.textos.labelSmall),
                onTap: () => Share.share(repo.exportarJson(), subject: 'Datos TCEE App'),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: context.esquema.error),
                title: Text('Borrar historial de tests', style: TextStyle(color: context.esquema.error)),
                subtitle: Text(usuario == null ? 'Solo en este dispositivo' : 'En este dispositivo y en tu cuenta (también en la web)', style: context.textos.labelSmall),
                onTap: () => _confirmar(context, 'Se borrarán todos los resultados de tests. Esta acción no se puede deshacer.', () async {
                  await repo.borrarHistorial();
                  ref.invalidate(historialProvider);
                }),
              ),
              ListTile(
                leading: Icon(Icons.restart_alt, color: context.esquema.error),
                title: Text('Reiniciar repaso Leitner', style: TextStyle(color: context.esquema.error)),
                onTap: () => _confirmar(context, 'Se olvidarán las preguntas en seguimiento.', () => ref.read(leitnerProvider.notifier).reiniciar()),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmar(BuildContext context, String texto, Future<void> Function() accion) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('¿Seguro?'),
        content: Text(texto),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(c).colorScheme.error), onPressed: () => Navigator.pop(c, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (ok == true) {
      await accion();
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hecho')));
    }
  }
}
