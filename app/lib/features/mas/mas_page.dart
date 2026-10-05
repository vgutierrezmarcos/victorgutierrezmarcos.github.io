import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../inicio/elegir_oposicion.dart';
import '../plan/plan_page.dart';
import '../preparador/red_widgets.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Más: lo que no es del día a día. Preparador (o Mi preparador), cuenta,
/// contenido, ajustes y acerca de. (Convocatoria y horario están en Organización.)
class MasPage extends ConsumerWidget {
  const MasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).valueOrNull ?? AppConfig.porDefecto;
    final ajustes = ref.watch(ajustesProvider);
    final usuario = ref.watch(usuarioActualProvider);
    final enlaces = ref.watch(enlacesProvider).valueOrNull ?? [];
    final hora = ajustes.horaRecordatorio;
    final avisosCante = ref.watch(planProvider.select((p) => p.avisosCante));
    final papel = ref.watch(papelProvider);
    final alumnos = ref.watch(alumnosProvider);
    final estadoRed = papel == Papel.preparador ? ref.watch(estadoRedProvider).valueOrNull : null;
    final pendientesPreparador = papel == Papel.preparador ? ref.watch(pendientesPreparadorProvider) : 0;
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
          // El apartado de cada papel: el preparador, lo suyo; el opositor, su preparador.
          if (papel == Papel.preparador) ...[
            const TituloSeccion('Preparador'),
            FilaEnlace(
              icono: Icons.groups_outlined,
              titulo: 'Preparador',
              subtitulo: [
                if (estadoRed?.verificado ?? false) 'Verificado' else if (estadoRed?.solicitud != null) 'Verificación pendiente' else if (usuario != null) 'Termina tu alta',
                alumnos.isEmpty ? 'sin alumnos todavía' : '${alumnos.length} ${alumnos.length == 1 ? 'alumno' : 'alumnos'}',
              ].join(' · '),
              final_: globo(context, pendientesPreparador),
              onTap: () => context.go('/mas/preparador'),
            ),
          ] else ...[
            const TituloSeccion('Mi preparador'),
            FilaEnlace(
              icono: Icons.groups_outlined,
              titulo: 'Mi preparador',
              subtitulo: vinculos.isEmpty ? 'Conecta con tu preparador o pide una clase suelta' : 'Compartes tu progreso con ${vinculos.map((v) => v.nombre.isEmpty ? 'tu preparador' : v.nombre).join(', ')}',
              onTap: () => context.go('/mas/mi-preparador'),
            ),
          ],
          const TituloSeccion('Contenido'),
          // El simulador web guarda en el historial de su propia oposición.
          if (!ref.read(oposicionProvider).testVoluntario) _fila(context, Icons.public, 'Simulador web', 'La misma cuenta, el mismo historial', () => abrirUrl(context, ref.read(oposicionProvider).urlSimuladorWeb)),
          if (!ref.read(oposicionProvider).esPrincipal) _fila(context, Icons.public, 'Apuntes en la web', ref.read(oposicionProvider).dominio, () => abrirUrl(context, ref.read(oposicionProvider).web)),
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
              if (Notificaciones.disponibles) ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Avisar antes de cada cante'),
                subtitle: Text('La víspera y una hora antes', style: context.textos.labelSmall),
                trailing: Switch(value: avisosCante, onChanged: (_) => alternarAvisosCante(ref)),
              ),
              if ((ref.watch(oposicionesVisiblesProvider).valueOrNull ?? Oposiciones.disponibles).length > 1)
                ListTile(
                  leading: const Icon(Icons.school_outlined),
                  title: const Text('Oposición'),
                  subtitle: Text(ref.read(oposicionProvider).nombre, style: context.textos.labelSmall),
                  trailing: Text(ref.read(oposicionProvider).siglas, style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                  onTap: () => _cambiarOposicion(context, ref),
                ),
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: Text('Tu papel en ${ref.read(oposicionProvider).siglas}'),
                trailing: SegmentedButton<Papel>(
                  showSelectedIcon: false,
                  segments: const [ButtonSegment(value: Papel.opositor, label: Text('Opositor')), ButtonSegment(value: Papel.preparador, label: Text('Preparador'))],
                  selected: {papel},
                  onSelectionChanged: (s) => cambiarPapel(context, ref, s.first),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
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
          if (ref.read(oposicionProvider).autor case (final nombre, final quien, final url?))
            _fila(context, Icons.person_outline, 'Sobre el autor', '$nombre · $quien', () => abrirUrl(context, url, enApp: true)),
          _fila(context, Icons.privacy_tip_outlined, 'Privacidad', 'Qué datos guarda la app y cómo borrarlos', () => abrirUrl(context, Urls.politicaPrivacidad, enApp: true)),
          _fila(context, Icons.alternate_email, 'Contacto', config.email, () => abrirUrl(context, 'mailto:${config.email}')),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (_, s) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset('assets/icon/icon.png', width: 40, height: 40, semanticLabel: 'Logo de la app'),
                ),
                const SizedBox(height: 8),
                Text('${Creditos.nombreApp} · ${kIsWeb ? 'versión web' : 'versión ${s.data?.version ?? ''}${s.data == null ? '' : ' (${s.data!.buildNumber})'}'}\nDesarrollada por ${Creditos.desarrolladores}\nContenido de ${ref.read(oposicionProvider).dominio}', textAlign: TextAlign.center, style: context.textos.labelSmall),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Elegir otra oposición. Los datos de cada una se quedan guardados.
  Future<void> _cambiarOposicion(BuildContext context, WidgetRef ref) async {
    final actual = ref.read(oposicionProvider);
    final visibles = ref.read(oposicionesVisiblesProvider).valueOrNull ?? Oposiciones.disponibles;
    final nueva = await showDialog<Oposicion>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿A qué te presentas?'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            for (final o in visibles)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TarjetaOposicion(oposicion: o, elegida: o.id == actual.id, onTap: () => Navigator.pop(d, o)),
              ),
            Text('Cada una tiene su temario, sus cantes, sus tests y sus preparadores. Lo que lleves en ${actual.siglas} se queda guardado y vuelve si cambias otra vez.', style: Theme.of(d).textTheme.bodySmall),
          ]),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar'))],
      ),
    );
    if (nueva == null || nueva.id == actual.id) return;
    await ref.read(cambiarOposicionProvider)(nueva);
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

/// Cambia el papel en la oposición actual. A preparador se pasa por el alta
/// (presentación y verificación); a opositor, tras confirmarlo.
Future<void> cambiarPapel(BuildContext context, WidgetRef ref, Papel papel) async {
  if (papel == ref.read(papelProvider)) return;
  if (papel == Papel.preparador) {
    context.go('/mas/preparador');
    return;
  }
  final siglas = ref.read(oposicionProvider).siglas;
  final ok = await showDialog<bool>(
    context: context,
    builder: (d) => AlertDialog(
      title: Text('Opositor en $siglas'),
      content: Text('Dejarás de ver la sección de preparador de $siglas. Tus alumnos, sus clases y tu código se quedan guardados y vuelven si cambias otra vez.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Cambiar')),
      ],
    ),
  );
  if (ok == true) await ref.read(perfilPreparadorProvider.notifier).fijarPapel(Papel.opositor);
}
