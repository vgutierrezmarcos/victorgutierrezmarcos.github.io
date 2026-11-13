import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../data/repos/preparador_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'red_widgets.dart';

/// Coordinación de un opositor con varios preparadores: el tablón común, las
/// notas entre preparadores (editables), el reparto de qué lleva cada uno y
/// lo que el opositor deja ver.

// ------------------------------------------------------------------ Mensajes

/// Lista de mensajes (tablón común o notas entre preparadores) con un campo
/// para escribir; cada uno cambia y borra los suyos.
class ListaMensajes extends ConsumerStatefulWidget {
  const ListaMensajes({super.key, required this.alumnoUid, required this.coleccion, required this.mensajes, required this.alCambiar, this.pista = 'Escribe un mensaje'});
  final String alumnoUid;

  /// [PreparadorRepo.tablonComun] o [PreparadorRepo.notasEntrePreparadores].
  final String coleccion;
  final List<NotaEntrePreparadores> mensajes;

  /// Para volver a leerlos después de escribir, cambiar o borrar.
  final VoidCallback alCambiar;
  final String pista;

  @override
  ConsumerState<ListaMensajes> createState() => _ListaMensajesState();
}

class _ListaMensajesState extends ConsumerState<ListaMensajes> {
  final _texto = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _texto.dispose();
    super.dispose();
  }

  Future<void> _hacer(Future<void> Function() f) async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _enviando = true);
    try {
      await f();
      widget.alCambiar();
    } catch (_) {
      messenger.mostrar(const SnackBar(content: Text('No se pudo guardar. Revisa la conexión.')));
    }
    if (mounted) setState(() => _enviando = false);
  }

  Future<void> _escribir() async {
    final t = _texto.text.trim();
    if (t.isEmpty) return;
    await _hacer(() => ref.read(preparadorRepoProvider).escribirMensaje(widget.alumnoUid, widget.coleccion, t));
    _texto.clear();
  }

  Future<void> _editar(NotaEntrePreparadores n) async {
    final c = TextEditingController(text: n.texto);
    final nuevo = await showDialog<String>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Cambiar el mensaje'),
        content: TextField(controller: c, autofocus: true, minLines: 2, maxLines: 6, maxLength: 2000, textCapitalization: TextCapitalization.sentences),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, c.text.trim()), child: const Text('Guardar')),
        ],
      ),
    );
    c.dispose();
    if (nuevo == null || nuevo.isEmpty || nuevo == n.texto) return;
    await _hacer(() => ref.read(preparadorRepoProvider).editarMensaje(widget.alumnoUid, widget.coleccion, n, nuevo));
  }

  @override
  Widget build(BuildContext context) {
    final yo = ref.watch(usuarioActualProvider)?.uid;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
          child: TextField(
            controller: _texto,
            minLines: 1,
            maxLines: 4,
            maxLength: 2000,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: widget.pista, counterText: ''),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(tooltip: 'Enviar', onPressed: _enviando ? null : _escribir, icon: const Icon(Icons.send)),
      ]),
      const SizedBox(height: 8),
      if (widget.mensajes.isEmpty) Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('Aún no hay mensajes.', style: context.textos.labelSmall)),
      for (final n in widget.mensajes)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Tarjeta(
            color: n.de == yo ? context.colores.primarioPalido : null,
            padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.only(top: 4, right: 8), child: PuntoPersona(n.de)),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${n.de == yo ? 'Tú' : (n.deNombre.isEmpty ? 'Alguien' : n.deNombre)} · ${fechaCorta(n.fecha)}, ${horaDe(n.fecha)}${n.editado != null ? ' · cambiado' : ''}',
                    style: context.textos.labelSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(n.texto, style: context.textos.bodyMedium),
                ]),
              ),
              if (n.de == yo)
                PopupMenuButton<String>(
                  tooltip: 'Opciones',
                  onSelected: (v) => v == 'editar' ? _editar(n) : _hacer(() => ref.read(preparadorRepoProvider).borrarMensaje(widget.alumnoUid, widget.coleccion, n)),
                  itemBuilder: (_) => const [PopupMenuItem(value: 'editar', child: Text('Cambiar')), PopupMenuItem(value: 'borrar', child: Text('Borrar'))],
                ),
            ]),
          ),
        ),
    ]);
  }
}

/// El tablón común de un opositor con todos sus preparadores (los que no ha
/// ocultado a los demás): para acordar cambios de clase, repartos, dudas…
class TablonComunPage extends ConsumerWidget {
  const TablonComunPage({super.key, required this.alumnoUid, required this.nombreAlumno, this.soyAlumno = false});
  final String alumnoUid;
  final String nombreAlumno;
  final bool soyAlumno;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mensajes = ref.watch(tablonComunProvider(alumnoUid));
    return Scaffold(
      appBar: BarraWeb(title: Text(soyAlumno ? 'Tablón con tus preparadores' : 'Tablón con $nombreAlumno')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(tablonComunProvider(alumnoUid)),
        child: ListaAdaptable(children: [
          Text(
            soyAlumno
                ? 'Lo leéis tú y tus preparadores (salvo los que hayas ocultado a los demás). Para acordar cambios de clase, quién lleva qué o cualquier duda. Os avisa cuando alguien escribe.'
                : 'Lo leéis $nombreAlumno y sus preparadores. Para acordar cambios de clase, quién lleva qué o cualquier duda. Os avisa cuando alguien escribe.',
            style: context.textos.labelSmall,
          ),
          const SizedBox(height: 10),
          mensajes.when(
            loading: () => const Padding(padding: EdgeInsets.all(24), child: Cargando()),
            error: (_, __) => const Text('No se pudo leer el tablón. Revisa la conexión.'),
            data: (lista) => ListaMensajes(
              alumnoUid: alumnoUid,
              coleccion: PreparadorRepo.tablonComun,
              mensajes: lista,
              alCambiar: () => ref.invalidate(tablonComunProvider(alumnoUid)),
            ),
          ),
        ]),
      ),
    );
  }
}

// ------------------------------------------------------------------ Reparto

/// «3.er ejercicio y 4.º ejercicio · Comercio».
String textoReparto(RepartoPreparador r) => [
      if (r.ejercicios.isNotEmpty) (r.ejercicios.toList()..sort()).map((e) => '${EjercicioDef.ordinalAbreviado(e)} ejercicio').join(' y '),
      if (r.nota.trim().isNotEmpty) r.nota.trim(),
    ].join(' · ');

/// Edita lo que lleva un preparador (ejercicios y una nota). Devuelve el
/// reparto nuevo o null si se cancela.
Future<RepartoPreparador?> editarReparto(BuildContext context, {required String nombre, required RepartoPreparador actual}) {
  final ejercicios = {...actual.ejercicios};
  final nota = TextEditingController(text: actual.nota);
  return showDialog<RepartoPreparador>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) => AlertDialog(
        title: Text('Qué lleva $nombre'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Sin marcar nada, hace de todo.'),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 4, children: [
            for (final e in ejerciciosPreparables)
              FilterChip(
                label: Text('${EjercicioDef.ordinalAbreviado(e)} ejercicio'),
                selected: ejercicios.contains(e),
                onSelected: (v) => set(() => v ? ejercicios.add(e) : ejercicios.remove(e)),
              ),
          ]),
          const SizedBox(height: 8),
          TextField(controller: nota, maxLength: 120, decoration: const InputDecoration(labelText: 'Nota (opcional)', hintText: 'p. ej. macro y comercio; corrige los cantes')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, RepartoPreparador(ejercicios: ejercicios, nota: nota.text.trim())), child: const Text('Guardar')),
        ],
      ),
    ),
  ).whenComplete(nota.dispose);
}

/// El reparto entre los preparadores de un alumno: qué lleva cada uno. Lo
/// cambia el alumno (el de todos) o cada preparador (el suyo, [soloYo]).
class SeccionReparto extends ConsumerWidget {
  const SeccionReparto({super.key, required this.alumnoUid, required this.preparadores, this.soloYo});
  final String alumnoUid;

  /// (uid, nombre) de cada preparador.
  final List<(String, String)> preparadores;

  /// Uid del preparador que mira (solo cambia lo suyo); null = el alumno.
  final String? soloYo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reparto = ref.watch(repartoProvider(alumnoUid)).valueOrNull ?? const {};
    Future<void> editar(String uid, String nombre) async {
      final messenger = ScaffoldMessenger.of(context);
      final r = await editarReparto(context, nombre: uid == soloYo ? 'tú' : nombre, actual: reparto[uid] ?? const RepartoPreparador());
      if (r == null) return;
      try {
        await ref.read(preparadorRepoProvider).guardarReparto(alumnoUid, uid, r);
        ref.invalidate(repartoProvider(alumnoUid));
      } catch (_) {
        messenger.mostrar(const SnackBar(content: Text('No se pudo guardar. Revisa la conexión.')));
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TituloSeccion('Qué lleva cada uno'),
      Text(
        reparto.isEmpty ? 'Opcional: sin repartir, todos hacen de todo. Si os repartís ejercicios o partes, anotadlo aquí; lo ven todos.' : 'Lo ven todos. Sin marcar nada, un preparador hace de todo.',
        style: context.textos.labelSmall,
      ),
      const SizedBox(height: 6),
      Tarjeta(
        padding: EdgeInsets.zero,
        child: Column(children: [
          for (final (uid, nombre) in preparadores)
            ListTile(
              leading: PuntoPersona(uid, tamano: 12),
              title: Text(uid == soloYo ? 'Tú' : nombre),
              subtitle: Text(reparto[uid] == null || reparto[uid]!.vacio ? 'De todo' : textoReparto(reparto[uid]!), style: context.textos.labelSmall),
              trailing: soloYo == null || uid == soloYo ? const Icon(Icons.edit_outlined, size: 20) : null,
              onTap: soloYo == null || uid == soloYo ? () => editar(uid, nombre) : null,
            ),
        ]),
      ),
    ]);
  }
}

// ------------------------------------------------------------------ Qué ven

/// El opositor decide qué ven sus preparadores. Por defecto, todo lo que
/// ayuda a coordinarse.
class QueVenMisPreparadoresPage extends ConsumerStatefulWidget {
  const QueVenMisPreparadoresPage({super.key});
  @override
  ConsumerState<QueVenMisPreparadoresPage> createState() => _QueVenMisPreparadoresPageState();
}

class _QueVenMisPreparadoresPageState extends ConsumerState<QueVenMisPreparadoresPage> {
  AjustesCoordinacion? _ajustes;

  Future<void> _guardar(AjustesCoordinacion a) async {
    final messenger = ScaffoldMessenger.of(context);
    final antes = _ajustes;
    setState(() => _ajustes = a);
    try {
      await ref.read(preparadorRepoProvider).guardarAjustesCoordinacion(a);
      ref.invalidate(ajustesCoordinacionProvider);
    } catch (_) {
      setState(() => _ajustes = antes);
      messenger.mostrar(const SnackBar(content: Text('No se pudo guardar. Revisa la conexión.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ajustes = _ajustes ?? ref.watch(ajustesCoordinacionProvider).valueOrNull;
    final preparadores = ref.watch(misPreparadoresProvider);
    return Scaffold(
      appBar: const BarraWeb(title: Text('Qué ven tus preparadores')),
      body: ajustes == null
          ? const Cargando()
          : ListaAdaptable(children: [
              Text(
                'Cada preparador ve tus temas estudiados y en repaso, y las clases que tiene contigo con su valoración. '
                'De las clases con los demás ve el tema, la fecha y con quién, sin su valoración ni sus comentarios. '
                'Nadie ve tus tests ni tus notas.',
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 10),
              Tarjeta(
                padding: EdgeInsets.zero,
                child: SwitchListTile(
                  value: ajustes.verCantesPropios,
                  onChanged: (v) => _guardar(ajustes.copyWith(verCantesPropios: v)),
                  title: const Text('Mis cantes por mi cuenta'),
                  subtitle: Text('Los ven, con tu nota y tus comentarios. Ayuda a que no te repitan temas.', style: context.textos.labelSmall),
                ),
              ),
              const TituloSeccion('Avisos que les llegan de tu actividad'),
              Text(
                'Apagados hasta que los actives. Cada preparador elige además cuáles quiere recibir; lo que no compartas aquí no le llega nunca.',
                style: context.textos.labelSmall,
              ),
              const SizedBox(height: 6),
              Tarjeta(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  for (final (clave, titulo, subtitulo) in const <(String, String, String)>[
                    ('temas', 'Cuando fijo los temas de una clase', 'Qué temas llevo a cada clase con él.'),
                    ('cantes', 'Cuando canto un tema por mi cuenta', 'Con mi valoración (solo si también comparto mis cantes, arriba).'),
                    ('estudiados', 'Cuando marco temas como estudiados', 'Los temas nuevos desde su última comprobación.'),
                    ('uso', 'Si llevo una semana sin usar la app', 'Comparte solo el último día en que la usé, nunca la hora ni qué hice.'),
                    ('examen', 'Cuando faltan 30 y 7 días para mi examen', 'Según la fecha que tengo puesta en Convocatoria.'),
                  ])
                    SwitchListTile(
                      value: ref.watch(ajustesProvider.select((a) => a.avisosPreparador.contains(clave))),
                      title: Text(titulo),
                      subtitle: Text(subtitulo, style: context.textos.labelSmall),
                      onChanged: (v) => ref.read(ajustesProvider.notifier).actualizar((a) => a.copyWith(avisosPreparador: v ? {...a.avisosPreparador, clave} : ({...a.avisosPreparador}..remove(clave)))),
                    ),
                ]),
              ),
              if (preparadores.length > 1) ...[
                const TituloSeccion('Si saben que tienes otros preparadores'),
                Text(
                  'Por defecto, sí: se ven entre ellos, ven las clases de los demás (para no pisarse) y los temas que te mandan (para no repetirlos), y comparten el tablón. '
                  'Si a alguno no se lo quieres decir, quítalo: no verá a los demás ni los demás a él (sus clases les saldrán como «otra clase», sin nombre).',
                  style: context.textos.labelSmall,
                ),
                const SizedBox(height: 6),
                Tarjeta(
                  padding: EdgeInsets.zero,
                  child: Column(children: [
                    for (final p in preparadores)
                      SwitchListTile(
                        secondary: PuntoPersona(p.uid, tamano: 12),
                        value: !ajustes.aislado(p.uid),
                        onChanged: (v) => _guardar(ajustes.copyWith(aislados: v ? ({...ajustes.aislados}..remove(p.uid)) : {...ajustes.aislados, p.uid})),
                        title: Text(p.nombre.isEmpty ? 'Preparador' : p.nombre),
                        subtitle: Text(ajustes.aislado(p.uid) ? 'No sabe que tienes otros' : 'Se coordina con los demás', style: context.textos.labelSmall),
                      ),
                  ]),
                ),
              ],
            ]),
    );
  }
}

// ------------------------------------------------------------------ Choques

/// La agenda que conoce el preparador de su alumno [idAlumno]: sus clases con
/// él y, si tiene la app enlazada, lo que el alumno deja ver (clases con
/// otros preparadores y cantes por su cuenta).
Future<List<Cante>> agendaDeAlumno(WidgetRef ref, String idAlumno) async {
  final mias = ref.read(sesionesProvider).where((s) => s.alumno == idAlumno).toList();
  ProgresoAlumno? progreso;
  try {
    // Al repositorio directamente (no al provider autoDispose, que sin nadie
    // que lo escuche puede desecharse antes de contestar) y con plazo: sin
    // red se sigue con lo que hay en local, en vez de quedarse esperando.
    final repo = ref.read(preparadorRepoProvider);
    final a = repo.alumno(idAlumno);
    if (a != null) progreso = await repo.progreso(a).timeout(const Duration(seconds: 8));
  } catch (_) {}
  final ids = {for (final s in mias) s.id};
  return [...mias, ...?progreso?.cantes.where((c) => !ids.contains(c.id))];
}

/// Si hay [choques] con la agenda del opositor, los enseña y pregunta si
/// seguir. Devuelve si se sigue (sin choques, true sin preguntar).
Future<bool> confirmarChoques(BuildContext context, List<Cante> choques, {String? yo, String? quien}) async {
  final unicos = {for (final c in choques) c.id: c}.values.toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
  if (unicos.isEmpty) return true;
  final ok = await showDialog<bool>(
    context: context,
    builder: (d) => AlertDialog(
      title: Text(unicos.length == 1 ? 'Choca con otra clase' : 'Choca con ${unicos.length} clases'),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(quien == null ? 'A esa hora ya tienes:' : 'A esa hora $quien ya tiene:'),
        const SizedBox(height: 8),
        for (final c in unicos.take(5))
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(children: [
              if (c.preparador != null && c.preparador != preparadorOculto) Padding(padding: const EdgeInsets.only(right: 8), child: PuntoPersona(c.preparador!)),
              Expanded(child: Text('${fechaCorta(c.fecha)}, ${horaDe(c.fecha)}–${horaDe(c.fecha.add(Duration(minutes: c.minutos)))} · ${conQuienEs(c, yo: yo)}')),
            ]),
          ),
        if (unicos.length > 5) Text('…y ${unicos.length - 5} más.'),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cambiar la hora')),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Guardar igualmente')),
      ],
    ),
  );
  return ok ?? false;
}
