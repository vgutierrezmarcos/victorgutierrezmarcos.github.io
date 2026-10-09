import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../plan/cantes_util.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'busquedas_page.dart';
import 'calendario_google_tarjeta.dart';
import 'red_widgets.dart';
import 'tema_anticipado.dart';
import '../inicio/permisos_sheet.dart';

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

    // Ficha del directorio: se guarda en el perfil y, si está verificado, en la ficha pública.
    Future<void> guardarFicha({String? modalidad, String? ciudad, List<int>? ejercicios}) async {
      await notifier.guardar(perfil.copyWith(modalidad: modalidad, ciudad: ciudad));
      if (!verificado) return;
      try {
        await ref.read(redRepoProvider).actualizarMiFicha(modalidad: modalidad, ciudad: ciudad, ejercicios: ejercicios);
        ref.invalidate(verificadosProvider);
      } catch (_) {}
    }

    Future<void> editarCiudad() async {
      final ctrl = TextEditingController(text: perfil.ciudad);
      final c = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('Ciudad'),
          content: TextField(controller: ctrl, autofocus: true, maxLength: 60, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(hintText: 'Madrid', helperText: 'Donde das clase presencial')),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, ctrl.text.trim()), child: const Text('Guardar')),
          ],
        ),
      );
      if (c != null) await guardarFicha(ciudad: c);
    }

    Future<void> nuevoHueco() async {
      final f = await elegirFranja(context, titulo: 'Hueco libre', minutos: perfil.minutosClase);
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
          const TituloSeccion('En el directorio'),
          Tarjeta(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Cómo das clase', style: context.textos.titleSmall),
              const SizedBox(height: 6),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final (m, t) in const [('online', 'Online'), ('presencial', 'Presencial'), ('ambas', 'Las dos'), ('', 'Sin indicar')])
                  ChoiceChip(label: Text(t), selected: perfil.modalidad == m, onSelected: (_) => guardarFicha(modalidad: m)),
              ]),
              if (perfil.modalidad == 'presencial' || perfil.modalidad == 'ambas')
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.location_city_outlined),
                  title: const Text('Ciudad'),
                  subtitle: Text(perfil.ciudad.isEmpty ? 'Para que te encuentren quienes buscan clase presencial' : perfil.ciudad, style: context.textos.labelSmall),
                  trailing: const Icon(Icons.edit_outlined, size: 18),
                  onTap: editarCiudad,
                ),
              if (verificado) ...[
                const SizedBox(height: 6),
                Text('Ejercicios que preparas', style: context.textos.titleSmall),
                const SizedBox(height: 6),
                Builder(builder: (context) {
                  final mia = ref.watch(verificadosProvider).valueOrNull?.where((v) => v.uid == ref.watch(usuarioActualProvider)?.uid).firstOrNull;
                  final actuales = mia?.ejercicios ?? const <int>[];
                  return Wrap(spacing: 6, runSpacing: 6, children: [
                    for (final e in [for (final n in ejerciciosPreparables) Oposiciones.actual.ejercicio(n)!])
                      FilterChip(
                        label: Text('${e.corto} · ${e.descripcion.replaceAll(RegExp(r' \(.*\)$'), '')}', overflow: TextOverflow.ellipsis),
                        selected: actuales.contains(e.numero),
                        onSelected: mia == null
                            ? null
                            : (v) {
                                final lista = v ? [...actuales, e.numero] : actuales.where((x) => x != e.numero).toList();
                                if (lista.isEmpty) return;
                                guardarFicha(ejercicios: lista..sort());
                              },
                      ),
                  ]);
                }),
              ],
              const SizedBox(height: 4),
              Text(verificado ? 'Lo ven los opositores en el directorio de preparadores verificados.' : 'Saldrá en el directorio cuando estés verificado.', style: context.textos.labelSmall),
            ]),
          ),
          const SeccionPlazas(),
          const TituloSeccion('Tus clases'),
          Tarjeta(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Duración habitual', style: context.textos.titleSmall),
              Text('Lo que ocupa una clase en tu agenda y en el calendario (el cronómetro de exposición de cada tema va aparte). Se puede cambiar en cada clase.', style: context.textos.labelSmall),
              const SizedBox(height: 6),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final m in {...duracionesClase, perfil.minutosClase}.toList()..sort())
                  ChoiceChip(label: Text(textoDuracion(m)), selected: perfil.minutosClase == m, onSelected: (_) => notifier.guardar(perfil.copyWith(minutosClase: m))),
              ]),
              const SizedBox(height: 12),
              Text('Temas por clase', style: context.textos.titleSmall),
              Text('Cuántos temas canta el alumno en cada clase (cerca del examen, lo normal son dos). Se puede cambiar en cada clase.', style: context.textos.labelSmall),
              const SizedBox(height: 6),
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const [ButtonSegment(value: 1, label: Text('1 tema')), ButtonSegment(value: 2, label: Text('2 temas'))],
                selected: {perfil.temasPorClase.clamp(1, 2)},
                onSelectionChanged: (s) => notifier.guardar(perfil.copyWith(temasPorClase: s.first)),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              ),
              const SizedBox(height: 12),
              Text('Videollamadas', style: context.textos.titleSmall),
              Text('La que propones para tus clases online. El alumno entra con el enlace que pongas; vale también cualquier otro.', style: context.textos.labelSmall),
              const SizedBox(height: 6),
              SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: plataformaMeet, label: Text('Google Meet'), icon: Icon(Icons.video_call_outlined, size: 18)),
                  ButtonSegment(value: plataformaTeams, label: Text('Microsoft Teams'), icon: Icon(Icons.groups_outlined, size: 18)),
                ],
                selected: {perfil.plataforma == plataformaTeams ? plataformaTeams : plataformaMeet},
                onSelectionChanged: (s) => notifier.guardar(perfil.copyWith(plataforma: s.first)),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              ),
              const SizedBox(height: 12),
              Text('Recordarme cada clase', style: context.textos.titleSmall),
              const SizedBox(height: 6),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final (m, t) in const [(PerfilPreparador.avisoVispera, 'La víspera, 20:00'), (60, '1 h antes'), (30, '30 min antes'), (15, '15 min antes')])
                  FilterChip(
                    label: Text(t),
                    selected: perfil.avisosClase.contains(m),
                    onSelected: (v) async {
                      if (v && !await asegurarAvisos(context)) return;
                      await notifier.guardar(perfil.copyWith(avisosClase: v ? [...perfil.avisosClase, m] : perfil.avisosClase.where((x) => x != m).toList()));
                      await ref.read(sesionesProvider.notifier).reprogramarAvisos();
                    },
                  ),
              ]),
              if (kIsWeb) Padding(padding: const EdgeInsets.only(top: 4), child: Text('En el navegador llegan mientras tengas la web abierta (aunque sea en otra pestaña); en la app del móvil, siempre.', style: context.textos.labelSmall)),
              const SizedBox(height: 12),
              Text('Tema antes de la clase: antelación propuesta', style: context.textos.titleSmall),
              Text(
                'Es la que aparece ya elegida cuando programas el envío del tema en una clase, para no tener que elegirla cada vez. '
                'No se manda nada sola: en cada clase decides si mandas tema y puedes cambiar la antelación o poner una hora concreta.',
                style: context.textos.labelSmall,
              ),
              const SizedBox(height: 6),
              Wrap(spacing: 6, runSpacing: 6, children: [
                ChoiceChip(
                  label: Text('Como en el examen (${textoAntelacion(perfil.copyWith(antelacionDelExamen: true).antelacionTema(temas: perfil.temasPorClase))} para ${perfil.temasPorClase == 1 ? 'un tema' : 'dos temas'})'),
                  selected: perfil.segundosTemaAntes == null,
                  onSelected: (_) => notifier.guardar(perfil.copyWith(antelacionDelExamen: true)),
                ),
                for (final h in {...antelacionesTema, if (perfil.segundosTemaAntes != null) perfil.segundosTemaAntes!}.toList()..sort())
                  ChoiceChip(label: Text('${textoAntelacion(h)} antes'), selected: perfil.segundosTemaAntes == h, onSelected: (_) => notifier.guardar(perfil.copyWith(segundosTemaAntes: h))),
                ActionChip(
                  label: const Text('Otra'),
                  onPressed: () async {
                    final h = await pedirAntelacion(context, actual: perfil.segundosTemaAntes);
                    if (h != null) await notifier.guardar(perfil.copyWith(segundosTemaAntes: h));
                  },
                ),
              ]),
            ]),
          ),
          const TarjetaCalendarioGoogle(),
          const TituloSeccion('Avisos'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
            SwitchListTile(
              value: perfil.avisosSustitucion,
              title: const Text('Clases sueltas y opositores que buscan preparador'),
              subtitle: Text(
                kIsWeb
                    ? 'En el navegador, mientras tengas la app abierta en una pestaña. En el móvil llegan también con la app cerrada.'
                    : 'También con la app cerrada: se comprueba cada 15 minutos aproximadamente, con conexión.',
                style: context.textos.labelSmall,
              ),
              onChanged: (v) async {
                if (v && !await asegurarAvisos(context)) return;
                await notifier.guardar(perfil.copyWith(avisosSustitucion: v));
              },
            ),
            SwitchListTile(
              value: perfil.avisosReservas,
              title: const Text('Reservas: cuando un alumno reserva clase'),
              onChanged: (v) async {
                if (v && !await asegurarAvisos(context)) return;
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
                      subtitle: Text(textoDuracion(h.minutos), style: context.textos.labelSmall),
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
