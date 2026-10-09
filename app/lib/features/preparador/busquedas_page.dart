import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'disponibilidad_widget.dart';
import 'red_widgets.dart';

/// Tablón del preparador: opositores que buscan preparador, ordenados por lo
/// que encajan con su ficha y sus plazas. Si le interesa uno, deja su
/// contacto; es el opositor quien le escribe. No crea ninguna relación en la
/// app: esa la hace el opositor con el código, si se entienden.
class BusquedasPage extends ConsumerWidget {
  const BusquedasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lista = ref.watch(busquedasProvider);
    final plazas = ref.watch(misPlazasProvider).valueOrNull;
    return Scaffold(
      appBar: const BarraWeb(title: Text('Buscan preparador')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(busquedasProvider);
          ref.invalidate(misPlazasProvider);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Text('Lo que buscan, sin su nombre ni su teléfono. Si te interesa alguno y tienes hueco, deja tu contacto: será él quien te escriba. Ordenados por lo que encajan con lo que preparas, cómo das clase y tu disponibilidad (solo eso: no es una valoración de nadie).', style: context.textos.bodySmall),
            if (plazas == null || !plazas.admite)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Si admites alumnos nuevos, dilo en Ajustes → Alumnos nuevos: los opositores te verán al buscar preparador (los demás preparadores, no).', style: context.textos.labelSmall),
              ),
            const SizedBox(height: 10),
            ...switch (lista) {
              AsyncData(:final value) => value.isEmpty
                  ? [Text('Nadie busca preparador por ahora.', style: context.textos.bodySmall)]
                  : [for (final (b, c, mio) in value) _TarjetaBusqueda(busqueda: b, compat: c, interesado: mio)],
              AsyncError() => [Text('No se ha podido cargar. Desliza hacia abajo para reintentarlo.', style: context.textos.bodySmall)],
              _ => [const Center(child: CircularProgressIndicator())],
            },
          ],
        ),
      ),
    );
  }
}

class _TarjetaBusqueda extends ConsumerWidget {
  const _TarjetaBusqueda({required this.busqueda, required this.compat, required this.interesado});
  final Busqueda busqueda;
  final int compat;
  final bool interesado;

  Future<void> _interesarme(BuildContext context, WidgetRef ref) async {
    final perfil = ref.read(perfilPreparadorProvider);
    final messenger = ScaffoldMessenger.of(context);
    final mensaje = TextEditingController();
    var telefono = perfil.telefono;
    var conTelefono = telefonoWhatsApp(telefono) != null;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (d, set) => AlertDialog(
          title: const Text('Dejarle tu contacto'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('El opositor verá tu nombre, tu LinkedIn (si lo tienes en tu ficha) y lo que le escribas, y será él quien te escriba. No le compromete a nada ni crea ningún enlace en la app.', style: Theme.of(d).textTheme.bodySmall),
            const SizedBox(height: 10),
            TextField(controller: mensaje, maxLines: 3, maxLength: 300, decoration: const InputDecoration(labelText: 'Mensaje (opcional)', hintText: 'Tengo hueco los martes por la tarde…')),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: conTelefono,
              title: Text(telefonoWhatsApp(telefono) == null ? 'Dejarle también mi teléfono' : 'Dejarle también mi teléfono ($telefono)'),
              subtitle: const Text('Para que te escriba por WhatsApp'),
              onChanged: (v) async {
                if (v == true && telefonoWhatsApp(telefono) == null) {
                  final t = await pedirTelefono(d, inicial: telefono, explicacion: 'Se guarda en tus ajustes de preparador.');
                  if (t == null) return;
                  telefono = t;
                  await ref.read(perfilPreparadorProvider.notifier).guardar(perfil.copyWith(telefono: t));
                }
                set(() => conTelefono = v == true);
              },
            ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Me interesa')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final red = ref.read(redRepoProvider);
    final nombre = perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? '');
    try {
      await red.interesarme(busqueda.id, Interesado(uid: red.uid!, nombre: nombre, telefono: conTelefono ? telefono : '', linkedin: perfil.linkedin, mensaje: mensaje.text.trim(), creado: DateTime.now()));
      messenger.showSnackBar(const SnackBar(content: Text('Hecho. Si le interesa, te escribirá.')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo: $e')));
    }
    ref.invalidate(busquedasProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = busqueda;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(b.descripcion, style: context.textos.titleSmall),
                if (b.disponibilidad.isNotEmpty) TextoDisponibilidad(b.disponibilidad),
                if (b.temas > 0) Text('Lleva ${b.temas} temas preparados', style: context.textos.labelSmall),
                if (b.empiezaMasAdelante) Text('Quiere empezar más adelante', style: context.textos.labelSmall?.copyWith(color: context.colores.dorado)),
                if (b.nota.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('«${b.nota}»', style: context.textos.bodySmall)),
              ]),
            ),
            Padding(padding: const EdgeInsets.only(left: 8), child: Compatibilidad(compat)),
          ]),
          const SizedBox(height: 8),
          if (interesado)
            Row(children: [
              const Etiqueta('Le has dejado tu contacto', color: Paleta.acierto),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  try {
                    await ref.read(redRepoProvider).retirarInteres(b.id);
                  } catch (_) {}
                  ref.invalidate(busquedasProvider);
                },
                child: const Text('Retirar'),
              ),
            ])
          else
            FilledButton.icon(onPressed: compat == 0 ? null : () => _interesarme(context, ref), icon: const Icon(Icons.waving_hand_outlined, size: 18), label: Text(compat == 0 ? 'No encaja con lo que preparas' : 'Me interesa: dejarle mi contacto')),
        ]),
      ),
    );
  }
}

/// Ajustes del preparador → Alumnos nuevos: si admite alumnos, desde cuándo,
/// su disponibilidad, un mensaje y si deja su teléfono. Solo lo ven los
/// opositores que buscan preparador; los demás preparadores, no.
class SeccionPlazas extends ConsumerStatefulWidget {
  const SeccionPlazas({super.key});
  @override
  ConsumerState<SeccionPlazas> createState() => _SeccionPlazasState();
}

class _SeccionPlazasState extends ConsumerState<SeccionPlazas> {
  bool _guardando = false;

  Future<void> _guardar(Plazas p) async {
    setState(() => _guardando = true);
    try {
      await ref.read(redRepoProvider).guardarPlazas(p);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No se pudo guardar: $e')));
    }
    ref.invalidate(misPlazasProvider);
    if (mounted) setState(() => _guardando = false);
  }

  @override
  Widget build(BuildContext context) {
    final verificado = ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false;
    final perfil = ref.watch(perfilPreparadorProvider);
    final red = ref.read(redRepoProvider);
    final p = ref.watch(misPlazasProvider).valueOrNull ?? Plazas(preparador: red.uid ?? '');
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const TituloSeccion('Alumnos nuevos'),
      Tarjeta(
        padding: EdgeInsets.zero,
        child: Column(children: [
          SwitchListTile(
            value: p.admite,
            title: const Text('Admito alumnos nuevos'),
            subtitle: Text(
              'Los opositores que buscan preparador te verán con tu ficha y tu LinkedIn, ordenado por lo que encajas con lo que buscan, y te escribirán ellos. Los demás preparadores no ven si tienes hueco.',
              style: context.textos.labelSmall,
            ),
            onChanged: verificado && !_guardando ? (v) => _guardar(p.copyWith(admite: v)) : null,
          ),
          if (p.admite) ...[
            ListTile(
              leading: const Icon(Icons.event_outlined),
              title: Text(p.desde == null ? 'Desde ya' : 'Desde ${_mes(p.desde!)}', style: context.textos.titleSmall),
              subtitle: Text('Si tendrás hueco más adelante, dilo: hay opositores que empiezan dentro de unos meses.', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final r = await elegirMesInicio(context, actual: p.desde);
                if (r != null) await _guardar(p.copyWith(desde: r.$1, ya: r.$1 == null));
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Cuándo podrías dar clase', style: context.textos.titleSmall),
                const SizedBox(height: 6),
                SelectorDisponibilidad(claves: p.disponibilidad.toSet(), onCambio: (v) => _guardar(p.copyWith(disponibilidad: v.toList()..sort())), compacto: true),
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.notes_outlined),
              title: Text(p.mensaje.isEmpty ? 'Un mensaje para quien busca (opcional)' : p.mensaje, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
              trailing: const Icon(Icons.edit_outlined, size: 18),
              onTap: () async {
                final ctrl = TextEditingController(text: p.mensaje);
                final m = await showDialog<String>(
                  context: context,
                  builder: (d) => AlertDialog(
                    title: const Text('Mensaje'),
                    content: TextField(controller: ctrl, autofocus: true, maxLines: 3, maxLength: 300, decoration: const InputDecoration(hintText: 'Cómo trabajo, a quién busco, qué ejercicios preparo, cuándo tengo hueco…')),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
                      FilledButton(onPressed: () => Navigator.pop(d, ctrl.text.trim()), child: const Text('Guardar')),
                    ],
                  ),
                );
                if (m != null) await _guardar(p.copyWith(mensaje: m));
              },
            ),
            SwitchListTile(
              value: p.telefono.isNotEmpty,
              title: const Text('Que puedan escribirme por WhatsApp'),
              subtitle: Text(p.telefono.isEmpty ? 'Si no, solo verán tu LinkedIn${perfil.linkedin.isEmpty ? ' (ponlo arriba)' : ''}.' : 'Verán el ${p.telefono}.', style: context.textos.labelSmall),
              onChanged: (v) async {
                if (!v) return _guardar(p.copyWith(telefono: ''));
                var t = perfil.telefono;
                if (telefonoWhatsApp(t) == null) {
                  final nuevo = await pedirTelefono(context, inicial: t, explicacion: 'Se guarda en tus ajustes de preparador.');
                  if (nuevo == null) return;
                  t = nuevo;
                  await ref.read(perfilPreparadorProvider.notifier).guardar(perfil.copyWith(telefono: t));
                }
                await _guardar(p.copyWith(telefono: t));
              },
            ),
          ],
        ]),
      ),
      if (!verificado) Padding(padding: const EdgeInsets.only(top: 6), child: Text('Disponible cuando estés verificado.', style: context.textos.labelSmall)),
    ]);
  }
}

String _mes(DateTime d) => const ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'][d.month - 1] + (d.year != DateTime.now().year ? ' de ${d.year}' : '');
