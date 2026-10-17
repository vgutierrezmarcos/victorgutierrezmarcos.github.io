import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cronograma_form_page.dart';
import 'cronograma_widgets.dart';
import 'planificador.dart';

/// Sección de la ficha del alumno con el cronograma que comparte (si lo hace).
class CronogramaDelAlumno extends ConsumerWidget {
  const CronogramaDelAlumno({super.key, required this.alumno});
  final Alumno alumno;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!alumno.enlazado) return const SizedBox();
    void hacerle() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CronogramaFormPage(para: alumno)));
    final c = ref.watch(cronogramaAlumnoProvider(alumno.id)).value;
    if (c == null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const TituloSeccion('Su cronograma'),
        Tarjeta(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('No comparte ningún cronograma contigo. Puedes hacerle uno (temas, ritmo y día de cante) y mandárselo: decide él si lo usa.', style: context.textos.bodySmall),
            const SizedBox(height: 10),
            OutlinedButton.icon(onPressed: hacerle, icon: const Icon(Icons.event_note, size: 18), label: const Text('Hacerle un cronograma')),
          ]),
        ),
      ]);
    }
    final estado = estadoDe(c, DateTime.now());
    final s = estado.semanaActual;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TituloSeccion('Su cronograma', accion: TextButton.icon(onPressed: hacerle, icon: const Icon(Icons.send_outlined, size: 18), label: const Text('Mandarle otro'))),
      Tarjeta(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PropuestaCronogramaPage(alumno: alumno, c: c))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(nombreVuelta(c.ejercicio), style: context.textos.titleMedium),
          const SizedBox(height: 6),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: estado.progreso, minHeight: 6)),
          const SizedBox(height: 6),
          Text(
            [
              '${estado.hechos.length} de ${estado.total} temas · ${c.temasPorSemana} por semana',
              if (s != null && s.temas.isNotEmpty) 'esta semana: ${s.temas.join(', ')}',
              if (estado.atrasados.isNotEmpty) 'va ${estado.atrasados.length} por detrás',
              if (c.pendientes.isNotEmpty) c.pendientes.length == 1 ? 'una propuesta pendiente de que la vea' : '${c.pendientes.length} propuestas pendientes de que las vea',
              if (c.autorNombre.isNotEmpty) c.autor == ref.read(preparadorRepoProvider).uid ? 'se lo hiciste tú' : 'se lo hizo ${c.autorNombre}',
            ].join(' · '),
            style: context.textos.bodySmall,
          ),
        ]),
      ),
    ]);
  }
}

/// El preparador ve el cronograma del alumno y le propone cambios de ritmo,
/// fecha de fin u orden, con una nota. El alumno los acepta o los rechaza.
class PropuestaCronogramaPage extends ConsumerStatefulWidget {
  const PropuestaCronogramaPage({super.key, required this.alumno, required this.c});
  final Alumno alumno;
  final Cronograma c;
  @override
  ConsumerState<PropuestaCronogramaPage> createState() => _PropuestaCronogramaPageState();
}

class _PropuestaCronogramaPageState extends ConsumerState<PropuestaCronogramaPage> {
  late Cronograma _c = widget.c;
  final _nota = TextEditingController();
  bool _cambiado = false;
  bool _enviando = false;

  @override
  void dispose() {
    _nota.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final estado = estadoDe(_c, DateTime.now());
    final yo = ref.read(preparadorRepoProvider).uid;
    // La mía (la que sustituiría si mando otra) y las de los demás preparadores.
    final mia = widget.c.pendientes.where((p) => p.de == yo).firstOrNull;
    final deOtros = widget.c.pendientes.where((p) => p.de != yo).toList();

    Future<void> ritmo() async {
      final r = await elegirRitmo(context, pendientes: estado.pendientes, porSemana: _c.temasPorSemana, fin: _c.fin, descansos: _c.descansos, diaCante: _c.diaCante);
      if (r == null) return;
      setState(() {
        _c = replanificarCronograma(_c, DateTime.now(), porSemana: r.porSemana, fin: r.fin);
        _cambiado = true;
      });
    }

    Future<void> orden() async {
      final o = await Navigator.of(context).push<List<String>>(MaterialPageRoute(builder: (_) => ReordenarTemasPage(c: _c, hechos: estado.hechos, titulo: 'Proponer otro orden')));
      if (o == null) return;
      setState(() {
        _c = replanificarCronograma(_c.copyWith(temas: o), DateTime.now());
        _cambiado = true;
      });
    }

    Future<void> enviar() async {
      final messenger = ScaffoldMessenger.of(context);
      final nav = Navigator.of(context);
      setState(() => _enviando = true);
      try {
        final repo = ref.read(preparadorRepoProvider);
        final perfil = ref.read(perfilPreparadorProvider);
        await repo.proponerCambios(
          widget.alumno,
          widget.c,
          PropuestaCronograma(
            de: repo.uid ?? '',
            nombre: perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? ''),
            fecha: DateTime.now(),
            nota: _nota.text.trim(),
            temas: _c.temas,
            temasPorSemana: _c.temasPorSemana,
            fin: _c.fin,
          ),
        );
        ref.invalidate(cronogramaAlumnoProvider(widget.alumno.id));
        messenger.mostrar(SnackBar(content: Text('Propuesta enviada. ${widget.alumno.nombre} la verá en su cronograma.')));
        nav.pop();
      } catch (e) {
        messenger.mostrar(SnackBar(content: Text('No se pudo enviar: $e')));
      } finally {
        if (mounted) setState(() => _enviando = false);
      }
    }

    return Scaffold(
      appBar: BarraWeb(title: Text('Cronograma de ${widget.alumno.nombre}')),
      body: ListaAdaptable(children: [
        ResumenCronograma(c: _c, estado: estado),
        if (mia != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Tiene pendiente tu propuesta del ${fechaLargaCrono(mia.fecha)}. Si envías otra, sustituye a esa.', style: context.textos.labelSmall),
          ),
        for (final o in deOtros)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${o.nombre.isEmpty ? 'Otro preparador' : o.nombre} también le ha propuesto cambios (${fechaLargaCrono(o.fecha)}): '
              '${o.fin != null ? 'acabar el ${fechaLargaCrono(o.fin!)}' : '${o.temasPorSemana} temas por semana'}${o.nota.isEmpty ? '' : ' · «${o.nota}»'}. La tuya no la sustituye.',
              style: context.textos.labelSmall,
            ),
          ),
        const TituloSeccion('Proponer cambios'),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('Ritmo o fecha de fin'),
              subtitle: Text(_c.fin != null ? 'Acabar el ${fechaLargaCrono(_c.fin!)}' : '${_c.temasPorSemana} temas por semana', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
              onTap: ritmo,
            ),
            ListTile(leading: const Icon(Icons.swap_vert), title: const Text('Orden de los temas'), trailing: const Icon(Icons.chevron_right), onTap: orden),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: TextField(controller: _nota, maxLines: 2, onChanged: (_) => setState(() {}), decoration: const InputDecoration(labelText: 'Nota para el alumno', hintText: 'Por qué propones el cambio')),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: _enviando || (!_cambiado && _nota.text.trim().isEmpty) ? null : enviar,
          icon: const Icon(Icons.send_outlined),
          label: const Text('Enviar la propuesta'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('El alumno decide si la acepta. Mientras, su cronograma no cambia.', style: context.textos.labelSmall),
        ),
        TituloSeccion(_cambiado ? 'Así quedaría' : 'Semanas'),
        SemanasCronograma(c: _c, estado: estado, soloDesdeActual: true),
        if (!_cambiado)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text('Solo ves lo que el alumno comparte; no puedes marcar temas por él.', style: context.textos.labelSmall?.copyWith(color: context.colores.textoClaro)),
          ),
      ]),
    );
  }
}
