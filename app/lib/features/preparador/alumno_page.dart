import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../organizacion/mapa_calor_page.dart';
import '../../widgets/selector_temas.dart';
import '../cantar/cantar_page.dart';
import '../plan/cante_form_page.dart';
import '../plan/cantes_util.dart';
import '../cronograma/propuesta_page.dart';
import 'materiales_page.dart';
import 'preparador_page.dart';
import 'red_widgets.dart';
import 'sesion_page.dart';

/// Ficha de un alumno: qué temas lleva, qué ha cantado y cómo, qué temas
/// flojean, sus próximas sesiones y las notas privadas del preparador.
class AlumnoPage extends ConsumerStatefulWidget {
  const AlumnoPage({super.key, required this.id});
  final String id;
  @override
  ConsumerState<AlumnoPage> createState() => _AlumnoPageState();
}

class _AlumnoPageState extends ConsumerState<AlumnoPage> {
  TextEditingController? _notas;

  @override
  void dispose() {
    _notas?.dispose();
    super.dispose();
  }

  Future<void> _unir(Alumno a) async {
    final unido = await unirAlumnoDialogo(context, ref, a);
    if (unido != null && mounted && unido.id != a.id) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AlumnoPage(id: unido.id)));
    }
  }

  Future<void> _quitar(Alumno a) async {
    final nav = Navigator.of(context);
    final ahora = DateTime.now();
    final pendientes = ref.read(sesionesProvider).where((s) => s.alumno == a.id && s.pendiente && s.fecha.isAfter(ahora)).length;
    var cancelar = true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (d, set) => AlertDialog(
          title: Text('¿Quitar a ${a.nombre}?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(a.enlazado ? 'Dejarás de ver su progreso y desaparecerá de tu lista. Los cantes que ya le has valorado se quedan en su diario.' : 'Desaparecerá de tu lista junto con su ficha.'),
            if (pendientes > 0)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: cancelar,
                onChanged: (x) => set(() => cancelar = x ?? false),
                title: Text('Cancelar sus $pendientes ${pendientes == 1 ? 'clase pendiente' : 'clases pendientes'}${a.uid != null ? ' (se le avisa)' : ''}'),
              ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Volver')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Quitar')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    // Antes de romper el enlace, mientras se puede escribir en su agenda.
    if (cancelar && pendientes > 0) {
      await ref.read(preparadorRepoProvider).cancelarPendientesDe(a, motivo: 'Tu preparador ya no te da clase');
      ref.invalidate(sesionesProvider);
    }
    await ref.read(alumnosProvider.notifier).borrar(a);
    nav.pop();
  }

  Future<void> _nuevaClaseFija(Alumno a) async {
    final f = await elegirFranja(context, titulo: 'Clase fija con ${a.nombre}', dia: DateTime.now().weekday, minutos: ref.read(perfilPreparadorProvider).minutosClase, conRitmo: true);
    if (f == null) return;
    final c = ClaseFija(id: nuevoId(), diaSemana: f.dia, minutoDelDia: f.minuto, minutos: f.minutos, cadaSemanas: f.cada, desde: DateTime.now());
    await ref.read(alumnosProvider.notifier).guardar(a.copyWith(clasesFijas: [...a.clasesFijas, c]));
    final n = await ref.read(preparadorRepoProvider).generarClasesFijas();
    ref.invalidate(sesionesProvider);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clase fija añadida: $n ${n == 1 ? 'clase creada' : 'clases creadas'} para las próximas seis semanas')));
  }

  Future<void> _quitarClaseFija(Alumno a, ClaseFija c) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Quitar la clase fija?'),
        content: const Text('Se borrarán también sus próximas clases pendientes. Las ya hechas se quedan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Quitar')),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(preparadorRepoProvider).quitarClaseFija(a, c);
    ref.invalidate(alumnosProvider);
    ref.invalidate(sesionesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final a = ref.watch(alumnosProvider).where((x) => x.id == widget.id).firstOrNull;
    if (a == null) return Scaffold(appBar: BarraWeb(title: const Text('Alumno')), body: const Center(child: Text('Este alumno ya no está en tu lista.')));
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final progreso = a.enlazado ? ref.watch(progresoAlumnoProvider(a.id)) : null;
    final mias = ref.watch(sesionesProvider).where((s) => s.alumno == a.id).toList();
    // Con el alumno enlazado se ven también los cantes que hace por su cuenta.
    final idsMias = {for (final s in mias) s.id};
    final suyos = (progreso?.value?.cantes ?? const <Cante>[]).where((c) => !idsMias.contains(c.id)).toList();
    final hechos = [...mias, ...suyos].where((c) => c.hecho).toList()..sort((x, y) => y.fecha.compareTo(x.fecha));
    final proximas = mias.where((s) => s.pendiente && s.fecha.isAfter(DateTime.now().subtract(const Duration(hours: 2)))).toList();
    final stats = EstadisticaTema.desde(hechos);
    final valorados = hechos.where((c) => (c.resultado?.valoracion ?? 0) > 0).toList();
    final media = valorados.isEmpty ? 0.0 : valorados.fold<int>(0, (s, c) => s + c.resultado!.valoracion) / valorados.length;
    final flojos = stats.values.where((e) => e.flojo).toList()..sort((x, y) => x.valoracionMedia.compareTo(y.valoracionMedia));
    final enRepaso = progreso?.value?.enRepaso ?? const <String>{};
    String titulo(String codigo) => temario?.tema(codigo)?.titulo ?? '';
    _notas ??= TextEditingController(text: a.notas);

    Future<void> editarTemas() async {
      if (temario == null) return;
      final r = await elegirTemas(context, temario: temario, seleccion: a.temas, ejercicios: Oposiciones.actual.ejerciciosDeBolsa(a.ejercicio), titulo: 'Temas que lleva');
      if (r != null) await ref.read(alumnosProvider.notifier).guardar(a.copyWith(temas: r));
    }

    void cantarAhora() {
      final sesion = Cante(id: nuevoId(), fecha: DateTime.now(), ejercicio: a.ejercicio, alumno: a.id, bolsa: a.temas.isEmpty ? TipoBolsa.ejercicio : TipoBolsa.estudiados, updatedAt: DateTime.now());
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantarPage(sesion: SesionAlumno(cante: sesion, alumno: a))));
    }

    return Scaffold(
      appBar: BarraWeb(
        title: Text(a.nombre),
        subtitulo: a.enlazado ? 'App enlazada' : 'Sin app enlazada',
        actions: [
          IconButton(
            tooltip: 'Editar',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final nuevo = await editarAlumno(context, alumno: a);
              if (nuevo != null) await ref.read(alumnosProvider.notifier).guardar(nuevo);
            },
          ),
          if (ref.watch(misAlumnosProvider).any((x) => x.id != a.id && (a.enlazado ? x.uid == null : x.enlazado)))
            IconButton(tooltip: a.enlazado ? 'Unir con una ficha apuntada a mano' : 'Unir con su ficha enlazada', icon: const Icon(Icons.merge_type), onPressed: () => _unir(a)),
          IconButton(tooltip: 'Quitar alumno', icon: const Icon(Icons.person_remove_outlined), onPressed: () => _quitar(a)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(progresoAlumnoProvider(a.id)),
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Row(children: [
              Expanded(child: Estadistica(valor: '${a.temas.length}', etiqueta: 'temas que lleva')),
              const SizedBox(width: 10),
              Expanded(child: Estadistica(valor: '${hechos.length}', etiqueta: hechos.length == 1 ? 'cante' : 'cantes')),
              const SizedBox(width: 10),
              Expanded(child: Estadistica(valor: media == 0 ? '—' : media.toStringAsFixed(1).replaceAll('.', ','), etiqueta: 'valoración', color: context.colores.dorado)),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: FilledButton.icon(onPressed: cantarAhora, icon: const Icon(Icons.casino_outlined), label: const Text('Cantar ahora'))),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: ref.read(misAlumnosProvider), alumnosIniciales: {a.id}))),
                  icon: const Icon(Icons.event_outlined, size: 18),
                  label: const Text('Programar clase'),
                ),
              ),
            ]),
            if (a.enlazado && progreso != null && progreso.isLoading)
              Padding(padding: const EdgeInsets.only(top: 10), child: Text('Cargando lo que comparte el alumno…', style: context.textos.labelSmall))
            else if (a.enlazado && progreso?.value == null)
              Padding(padding: const EdgeInsets.only(top: 10), child: Text('Sin conexión con su app: se muestran los últimos datos guardados.', style: context.textos.labelSmall)),
            if (a.telefono.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 10), child: BotonWhatsApp(telefono: a.telefono, texto: 'Escribir a ${a.nombre}')),
            if (a.enlazado && (ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false))
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MaterialFormPage(alumnoUid: a.uid))),
                  icon: const Icon(Icons.add_link, size: 18),
                  label: Text('Compartir material con ${a.nombre}'),
                ),
              ),
            if (a.enlazado && progreso?.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FilaEnlace(
                  icono: Icons.grid_view_rounded,
                  titulo: 'Mapa de calor',
                  subtitulo: 'Qué temas domina y cuáles flojean, según sus cantes',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MapaCalorPage(alumno: progreso!.value, nombreAlumno: a.nombre))),
                ),
              ),
            CronogramaDelAlumno(alumno: a),
            TituloSeccion('Clases fijas', accion: TextButton.icon(onPressed: () => _nuevaClaseFija(a), icon: const Icon(Icons.add, size: 18), label: const Text('Clase fija'))),
            if (a.clasesFijas.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text('Si tenéis una hora fija (por ejemplo, los martes a las 18:00), añádela y las clases de las próximas semanas se crearán solas.', style: context.textos.bodySmall),
              )
            else
              Tarjeta(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  for (final c in a.clasesFijas)
                    ListTile(
                      dense: true,
                      leading: Icon(Icons.repeat, color: context.esquema.primary),
                      title: Text('${c.cadaSemanas == 1 ? 'Cada' : 'Uno de cada dos'} ${nombresDias[c.diaSemana - 1]} a las ${horaMinutos(c.minutoDelDia)}'),
                      subtitle: Text('${textoDuracion(c.minutos)} · desde el ${fechaCorta(c.desde)}', style: context.textos.labelSmall),
                      trailing: IconButton(tooltip: 'Quitar', icon: const Icon(Icons.close), onPressed: () => _quitarClaseFija(a, c)),
                    ),
                ]),
              ),
            if (proximas.isNotEmpty) ...[
              const TituloSeccion('Próximas clases'),
              for (final s in proximas.take(4))
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                    padding: EdgeInsets.zero,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: s.id))),
                    child: ListTile(
                      leading: Icon(Icons.event_outlined, color: context.esquema.primary),
                      title: Text('${fechaCorta(s.fecha)} · ${horaDe(s.fecha)}', style: context.textos.titleSmall),
                      subtitle: Text('${s.titulo.isEmpty ? '' : '${s.titulo} · '}${detalleCante(s)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
                      trailing: Etiqueta(cuentaAtras(s.fecha)),
                    ),
                  ),
                ),
            ],
            TituloSeccion('Temas que lleva (${a.temas.length})', accion: a.enlazado ? null : TextButton(onPressed: editarTemas, child: Text(a.temas.isEmpty ? 'Apuntar' : 'Editar'))),
            if (a.temas.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(a.enlazado ? 'Aún no ha marcado ningún tema como estudiado en su app.' : 'Apunta los temas que lleva preparados para sacar bola entre ellos.', style: context.textos.bodySmall),
              )
            else
              Tarjeta(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Wrap(spacing: 5, runSpacing: 5, children: [
                    for (final codigo in a.temas)
                      CasillaTema(codigo, color: estructura?.colorDe(codigo) ?? context.esquema.primary, apagada: !stats.containsKey(codigo)),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    'Con color, los que ya ha cantado (${a.temas.where(stats.containsKey).length}); en contorno, los que aún no.${enRepaso.isEmpty ? '' : ' Tiene ${enRepaso.length} en repaso.'}',
                    style: context.textos.labelSmall,
                  ),
                ]),
              ),
            if (flojos.isNotEmpty) ...[
              const TituloSeccion('Temas flojos'),
              Tarjeta(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(children: [
                  for (final e in flojos)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(children: [
                        Expanded(child: Text('${e.codigo} · ${titulo(e.codigo)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                        Estrellas(valor: e.valoracionMedia.round(), tamano: 14),
                      ]),
                    ),
                ]),
              ),
            ],
            const TituloSeccion('Historial de cantes'),
            if (hechos.isEmpty)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text('Todavía no hay cantes valorados.', style: context.textos.bodySmall))
            else
              for (final c in hechos.take(30))
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                    padding: EdgeInsets.zero,
                    onTap: idsMias.contains(c.id) ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: c.id))) : () => _verCanteDelAlumno(c, titulo),
                    child: ListTile(
                      title: Text(c.resultado?.temaCantado == null ? tituloCante(c) : '${c.resultado!.temaCantado} · ${titulo(c.resultado!.temaCantado!)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                      subtitle: Text(
                        '${fechaCorta(c.fecha)}${(c.resultado?.segundos ?? 0) > 0 ? ' · ${formatoTiempo(c.resultado!.segundos)}' : ''}${idsMias.contains(c.id) ? '' : ' · por su cuenta'}',
                        style: context.textos.labelSmall,
                      ),
                      trailing: Estrellas(valor: c.resultado?.valoracion ?? 0, tamano: 14),
                    ),
                  ),
                ),
            const TituloSeccion('Notas privadas'),
            TextField(
              controller: _notas,
              minLines: 2,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Lo que quieras recordar de este alumno'),
              onChanged: (v) => ref.read(alumnosProvider.notifier).guardar(a.copyWith(notas: v)),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(4, 4, 4, 0), child: Text('Solo las ves tú: no se comparten con el alumno.', style: context.textos.labelSmall)),
          ],
        ),
      ),
    );
  }

  /// Cante que el alumno hizo por su cuenta: se puede leer, no cambiar.
  void _verCanteDelAlumno(Cante c, String Function(String) titulo) {
    final r = c.resultado;
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Cante por su cuenta · ${fechaLarga(c.fecha)}', style: context.textos.titleMedium),
          const SizedBox(height: 8),
          for (final t in r?.temasCantados ?? const <String>[]) Text('$t · ${titulo(t)}', style: context.textos.titleSmall),
          const SizedBox(height: 6),
          Row(children: [
            Estrellas(valor: r?.valoracion ?? 0, tamano: 20),
            const SizedBox(width: 12),
            if ((r?.segundos ?? 0) > 0) Text(formatoTiempo(r!.segundos), style: context.textos.labelMedium),
          ]),
          if ((r?.comentarios ?? '').isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(r!.comentarios, style: context.textos.bodyMedium)),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}

/// El mismo alumno con dos fichas (una apuntada a mano y otra al enlazar su
/// app): se elige la otra y se unen. Devuelve la ficha unida (la enlazada) o
/// null si se cancela.
Future<Alumno?> unirAlumnoDialogo(BuildContext context, WidgetRef ref, Alumno a) async {
  final otros = ref.read(misAlumnosProvider).where((x) => x.id != a.id && (a.enlazado ? x.uid == null : x.enlazado)).toList();
  if (otros.isEmpty) return null;
  final otro = await showDialog<Alumno>(
    context: context,
    builder: (d) => SimpleDialog(
      title: Text(a.enlazado ? '¿Qué ficha a mano es ${a.nombre}?' : '¿Con qué ficha enlazada se une ${a.nombre}?'),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child: Text('Las clases, las clases fijas, las notas y los temas pasan a la ficha enlazada; la otra desaparece. Las clases se le copian a su agenda.', style: Theme.of(d).textTheme.bodySmall),
        ),
        for (final o in otros) SimpleDialogOption(onPressed: () => Navigator.pop(d, o), child: Text(o.nombre)),
      ],
    ),
  );
  if (otro == null) return null;
  final sinApp = a.enlazado ? otro : a, enlazado = a.enlazado ? a : otro;
  final unido = await ref.read(preparadorRepoProvider).unirAlumnos(sinApp, enlazado);
  ref.invalidate(alumnosProvider);
  ref.invalidate(sesionesProvider);
  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fichas unidas: ahora ${unido.nombre} tiene todas sus clases.')));
  return unido;
}
