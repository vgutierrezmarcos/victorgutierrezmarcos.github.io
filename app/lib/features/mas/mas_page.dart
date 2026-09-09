import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Más: blog, comunidad, enlaces, ajustes, cuenta y acerca de.
class MasPage extends ConsumerWidget {
  const MasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).value ?? AppConfig.porDefecto;
    final ajustes = ref.watch(ajustesProvider);
    final usuario = ref.watch(usuarioActualProvider);
    final enlaces = ref.watch(enlacesProvider).value ?? [];
    final hora = ajustes.horaRecordatorio;

    return Scaffold(
      appBar: AppBar(title: const Text('Más')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        children: [
          Tarjeta(
            padding: EdgeInsets.zero,
            onTap: () => context.go('/mas/cuenta'),
            child: ListTile(
              leading: usuario?.photoURL != null ? CircleAvatar(backgroundImage: NetworkImage(usuario!.photoURL!)) : const CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text(usuario?.displayName ?? 'Iniciar sesión con Google', style: context.textos.titleSmall),
              subtitle: Text(usuario?.email ?? 'Sincroniza tu historial y progreso con la web', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const TituloSeccion('Contenido'),
          _fila(context, Icons.article_outlined, 'Blog', 'Artículos sobre política económica y comercio', () => context.go('/mas/blog')),
          _fila(context, Icons.public, 'Simulador web', 'La misma cuenta, el mismo historial', () => abrirUrl(context, Urls.simuladorWeb)),
          const TituloSeccion('Comunidad'),
          _fila(context, Icons.forum_outlined, 'Discord / Telegram', config.urlDiscord == null && config.urlTelegram == null ? 'Disponible próximamente' : 'Únete al chat de opositores', () => abrirUrl(context, config.urlDiscord ?? config.urlTelegram)),
          _fila(context, Icons.mail_outline, 'Newsletter', 'Nuevos artículos y avisos de convocatoria', () => abrirUrl(context, config.urlNewsletter ?? '${Urls.base}/blog/index.html', enApp: true)),
          if (config.listaX != null) _fila(context, Icons.tag, 'Lista de X', 'Cuentas de referencia', () => abrirUrl(context, config.listaX)),
          if (enlaces.isNotEmpty) ...[
            const TituloSeccion('Enlaces útiles'),
            for (final c in enlaces)
              Tarjeta(
                padding: EdgeInsets.zero,
                child: ExpansionTile(
                  title: Text(c.nombre, style: context.textos.titleSmall),
                  children: [for (final e in c.enlaces) ListTile(dense: true, title: Text(e.titulo, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)), trailing: const Icon(Icons.open_in_new, size: 16), onTap: () => abrirUrl(context, e.url))],
                ),
              ),
          ],
          const TituloSeccion('Ajustes'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Recordatorio diario'),
                subtitle: Text(hora < 0 ? 'Desactivado' : 'A las ${(hora ~/ 60).toString().padLeft(2, '0')}:${(hora % 60).toString().padLeft(2, '0')}', style: context.textos.labelSmall),
                trailing: Switch(
                  value: hora >= 0,
                  onChanged: (v) async {
                    if (v && !await Notificaciones.pedirPermiso()) return;
                    await ref.read(ajustesProvider.notifier).fijarRecordatorio(v ? 20 * 60 : -1);
                  },
                ),
                onTap: hora < 0
                    ? null
                    : () async {
                        final t = await showTimePicker(context: context, initialTime: TimeOfDay(hour: hora ~/ 60, minute: hora % 60));
                        if (t != null) await ref.read(ajustesProvider.notifier).fijarRecordatorio(t.hour * 60 + t.minute);
                      },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text('Tema'),
                trailing: SegmentedButton<bool?>(
                  segments: const [ButtonSegment(value: null, label: Text('Auto')), ButtonSegment(value: false, label: Text('Claro')), ButtonSegment(value: true, label: Text('Oscuro'))],
                  selected: {ajustes.temaOscuro},
                  onSelectionChanged: (s) => ref.read(ajustesProvider.notifier).actualizar((a) => s.first == null ? a.copyWith(borrarTema: true) : a.copyWith(temaOscuro: s.first)),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.download_done_outlined),
                title: const Text('Descargas'),
                subtitle: Text('${(ref.read(descargasProvider).tamanoTotal() / 1048576).toStringAsFixed(1)} MB en PDFs', style: context.textos.labelSmall),
                trailing: TextButton(
                  onPressed: () async {
                    await ref.read(descargasProvider).borrarTodo();
                    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Descargas eliminadas')));
                  },
                  child: const Text('Liberar'),
                ),
              ),
            ]),
          ),
          const TituloSeccion('Acerca de'),
          _fila(context, Icons.person_outline, 'Sobre mí', 'Víctor Gutiérrez Marcos · TCEE, promoción LXXIII', () => abrirUrl(context, Urls.sobreMi, enApp: true)),
          _fila(context, Icons.privacy_tip_outlined, 'Privacidad', 'Qué datos guarda la app y cómo borrarlos', () => abrirUrl(context, Urls.politicaPrivacidad, enApp: true)),
          _fila(context, Icons.alternate_email, 'Contacto', config.email, () => abrirUrl(context, 'mailto:${config.email}')),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (_, s) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Oposición TCEE · versión ${s.data?.version ?? ''}${s.data == null ? '' : ' (${s.data!.buildNumber})'}\nContenido de victorgutierrezmarcos.es', textAlign: TextAlign.center, style: context.textos.labelSmall),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fila(BuildContext context, IconData icono, String titulo, String sub, VoidCallback onTap) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: EdgeInsets.zero,
          onTap: onTap,
          child: ListTile(leading: Icon(icono, color: context.esquema.primary), title: Text(titulo, style: context.textos.titleSmall), subtitle: Text(sub, style: context.textos.labelSmall), trailing: const Icon(Icons.chevron_right)),
        ),
      );
}
