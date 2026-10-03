import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Cuenta: Google Sign-In, sincronización, privacidad, exportación y borrado de datos.
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
      appBar: BarraWeb(title: const Text('Cuenta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!firebase)
            Tarjeta(child: Text('Esta compilación no incluye credenciales de Firebase: la app funciona solo en local.', style: context.textos.bodySmall))
          else if (usuario == null) ...[
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(kIsWeb ? 'Lo mismo en el móvil y en el ordenador' : 'Sincroniza con la web y el ordenador', style: context.textos.titleMedium),
                const SizedBox(height: 6),
                Text('Con tu cuenta de Google tienes lo mismo en la app del móvil, en la versión para el navegador y en el simulador de victorgutierrezmarcos.es: historial de tests, repaso, temas, notas, cantes, planificación y, si eres preparador, tus alumnos y sesiones.', style: context.textos.bodySmall),
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
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(children: [
                Expanded(child: SelectableText('Tu identificador: ${usuario.uid}', style: context.textos.labelSmall)),
                IconButton(
                  tooltip: 'Copiar identificador',
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.copy, size: 16),
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await Clipboard.setData(ClipboardData(text: usuario.uid));
                    messenger.showSnackBar(const SnackBar(content: Text('Identificador copiado')));
                  },
                ),
              ]),
            ),
            const SizedBox(height: 4),
            OutlinedButton.icon(
              onPressed: () async {
                await ref.read(sesionProvider.notifier).sincronizar();
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sincronizado')));
              },
              icon: const Icon(Icons.sync),
              label: const Text('Sincronizar ahora'),
            ),
            TextButton.icon(onPressed: () => ref.read(sesionProvider.notifier).cerrarSesion(), icon: const Icon(Icons.logout), label: const Text('Cerrar sesión')),
          ],
          const TituloSeccion('Tus datos solo los ves tú'),
          const TarjetaPrivacidad(),
          const TituloSeccion('Tus datos'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.file_download_outlined),
                title: const Text('Exportar datos (JSON)'),
                subtitle: Text('Resultados, repaso, ajustes, notas, cantes, planificación y alumnos', style: context.textos.labelSmall),
                onTap: () => guardarFichero(
                  nombre: 'oposicion_tcee_datos.json',
                  contenido: repo.exportarJson(extra: {...ref.read(planRepoProvider).exportar(), ...ref.read(preparadorRepoProvider).exportar()}),
                  mime: 'application/json',
                  asunto: 'Datos TCEE App',
                ),
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
              if (usuario != null)
                ListTile(
                  leading: Icon(Icons.cloud_off_outlined, color: context.esquema.error),
                  title: Text('Borrar todos mis datos', style: TextStyle(color: context.esquema.error)),
                  subtitle: Text('De la nube y de este dispositivo; rompe los enlaces con preparadores y alumnos', style: context.textos.labelSmall),
                  onTap: () => _confirmar(
                    context,
                    'Se borrarán de la nube y de este dispositivo tus tests, repaso, temas, notas, cantes, planificación, alumnos y sesiones, y se romperán los enlaces con tus preparadores y alumnos. Después se cerrará la sesión. Tu cuenta de Google no se toca. Esta acción no se puede deshacer.',
                    () => borrarTodosMisDatos(ref),
                  ),
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

/// Qué se guarda, quién lo ve y quién no. Se muestra en Cuenta y en la
/// pantalla de inicio de sesión.
class TarjetaPrivacidad extends StatelessWidget {
  const TarjetaPrivacidad({super.key});

  @override
  Widget build(BuildContext context) {
    Widget punto(IconData icono, String titulo, String texto) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icono, size: 20, color: context.esquema.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: '$titulo ', style: context.textos.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: context.esquema.onSurface)),
                TextSpan(text: texto, style: context.textos.bodySmall),
              ])),
            ),
          ]),
        );
    return Tarjeta(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        punto(Icons.lock_outline, 'Nadie más los ve.', 'Tus tests, temas, notas, cantes y planificación quedan guardados a nombre de tu cuenta, y las reglas de la base de datos impiden que nadie más los lea: ni otros opositores ni ningún otro usuario de la app o de la web.'),
        punto(Icons.person_pin_outlined, 'Tu preparador, solo si tú quieres.', 'Si enlazas con su código, verá los temas que marcas y tus cantes. Nunca tus tests, tus notas ni tus grabaciones. Puedes quitarle el acceso cuando quieras.'),
        punto(Icons.mic_off_outlined, 'Las grabaciones no salen de tu dispositivo.', 'No se suben a ningún sitio.'),
        punto(Icons.block, 'Sin publicidad ni analítica.', 'Tus datos no se venden, no se ceden y no se usan para nada más que para que la app funcione. Tampoco yo, que hago la app, los consulto.'),
        punto(Icons.delete_outline, 'Son tuyos.', 'Puedes descargarlos o borrarlos todos desde aquí.'),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(onPressed: () => abrirUrl(context, Urls.politicaPrivacidad, enApp: true), child: const Text('Política de privacidad completa')),
        ),
      ]),
    );
  }
}
