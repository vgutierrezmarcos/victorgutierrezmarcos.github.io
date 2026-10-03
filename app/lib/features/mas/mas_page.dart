import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';

/// Más: lo que no es del día a día. Convocatoria y horario, preparadores,
/// cuenta, ajustes, enlaces y acerca de.
class MasPage extends ConsumerWidget {
  const MasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).value ?? AppConfig.porDefecto;
    final ajustes = ref.watch(ajustesProvider);
    final usuario = ref.watch(usuarioActualProvider);
    final enlaces = ref.watch(enlacesProvider).value ?? [];
    final hora = ajustes.horaRecordatorio;
    final plan = ref.watch(planProvider);
    final proximaFecha = (ref.watch(fechasEjerciciosProvider).entries.where((e) => diasHasta(e.value) >= 0).toList()..sort((a, b) => a.value.compareTo(b.value))).firstOrNull;
    final perfil = ref.watch(perfilPreparadorProvider);
    final alumnos = ref.watch(alumnosProvider);
    final vinculos = ref.watch(misPreparadoresProvider);

    return Scaffold(
      appBar: BarraWeb(title: const Text('Más')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Tarjeta(
            padding: EdgeInsets.zero,
            onTap: () => context.go('/mas/cuenta'),
            child: ListTile(
              leading: const AvatarUsuario(),
              title: Text(usuario?.displayName ?? 'Iniciar sesión con Google', style: context.textos.titleSmall),
              subtitle: Text(usuario?.email ?? 'Sincroniza tu historial y progreso con la web', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const TituloSeccion('Mi oposición'),
          FilaEnlace(
            icono: Icons.flag_outlined,
            titulo: 'Convocatoria',
            subtitulo: proximaFecha == null ? 'Fechas de los ejercicios e hitos' : '${nombreEjercicio(proximaFecha.key)}: faltan ${diasHasta(proximaFecha.value)} días',
            onTap: () => context.go('/mas/convocatoria'),
          ),
          FilaEnlace(
            icono: Icons.schedule,
            titulo: 'Horario de estudio',
            subtitulo: '${(plan.horario ?? Horario.porDefecto()).horasEstudioSemana.toStringAsFixed(0)} horas de estudio a la semana',
            onTap: () => context.go('/mas/horario'),
          ),
          const TituloSeccion('Preparadores'),
          FilaEnlace(
            icono: Icons.groups_outlined,
            titulo: perfil.activo ? 'Mis alumnos' : 'Preparadores',
            subtitulo: perfil.activo
                ? (alumnos.isEmpty ? 'Añade a tus alumnos y programa sus cantes' : '${alumnos.length} ${alumnos.length == 1 ? 'alumno' : 'alumnos'} · sesiones, sorteos y valoraciones')
                : (vinculos.isEmpty ? 'Enlaza con tu preparador o lleva a tus alumnos' : 'Compartes tu progreso con ${vinculos.map((v) => v.nombre.isEmpty ? 'tu preparador' : v.nombre).join(', ')}'),
            onTap: () => context.go('/mas/preparador'),
          ),
          const TituloSeccion('Contenido'),
          _fila(context, Icons.public, 'Simulador web', 'La misma cuenta, el mismo historial', () => abrirUrl(context, Urls.simuladorWeb)),
          if (config.listaX != null) _fila(context, Icons.tag, 'Lista de X', 'Cuentas de referencia', () => abrirUrl(context, config.listaX)),
          if (enlaces.isNotEmpty) ...[
            const TituloSeccion('Enlaces útiles'),
            for (final c in enlaces)
              GrupoDesplegable(
                titulo: c.nombre,
                children: [for (final e in c.enlaces) ListTile(dense: true, title: Text(e.titulo, style: context.textos.titleSmall?.copyWith(color: context.esquema.primary)), trailing: const Icon(Icons.open_in_new, size: 16), onTap: () => abrirUrl(context, e.url))],
              ),
          ],
          const TituloSeccion('Ajustes'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              if (Notificaciones.disponibles) ListTile(
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
                title: const Text('Modo'),
                trailing: SegmentedButton<bool>(showSelectedIcon: false, 
                  segments: const [ButtonSegment(value: false, label: Text('Claro')), ButtonSegment(value: true, label: Text('Oscuro'))],
                  selected: {ajustes.temaOscuro == true},
                  onSelectionChanged: (s) => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(temaOscuro: s.first)),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ),
              if (ref.read(descargasProvider).guardaSinConexion) ListTile(
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
          _fila(context, Icons.phone_android, kIsWeb ? 'La app en el móvil' : 'La app, explicada', kIsWeb ? 'Descárgala para Android: avisos, grabación y PDF sin conexión' : 'Qué hace, capturas y vídeo', () => abrirUrl(context, Urls.paginaApp)),
          if (!kIsWeb) _fila(context, Icons.computer, 'En el ordenador', 'La misma app en el navegador, con tu cuenta', () => abrirUrl(context, Urls.appWeb)),
          _fila(context, Icons.person_outline, 'Sobre mí', 'Víctor Gutiérrez Marcos · TCEE, promoción LXXIII', () => abrirUrl(context, Urls.sobreMi, enApp: true)),
          _fila(context, Icons.privacy_tip_outlined, 'Privacidad', 'Qué datos guarda la app y cómo borrarlos', () => abrirUrl(context, Urls.politicaPrivacidad, enApp: true)),
          _fila(context, Icons.alternate_email, 'Contacto', config.email, () => abrirUrl(context, 'mailto:${config.email}')),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (_, s) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Oposición TCEE · ${kIsWeb ? 'versión web' : 'versión ${s.data?.version ?? ''}${s.data == null ? '' : ' (${s.data!.buildNumber})'}'}\nContenido de victorgutierrezmarcos.es', textAlign: TextAlign.center, style: context.textos.labelSmall),
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
