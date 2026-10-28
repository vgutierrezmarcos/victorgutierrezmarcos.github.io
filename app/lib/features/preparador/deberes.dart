import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';

/// Editor de los deberes de una clase (preparador): plantillas de un toque
/// (estudiar un tema, esquema a ciegas, cantar por su cuenta, test) y una
/// tarea libre. Devuelve la lista nueva, o null si se cancela.
Future<List<Tarea>?> editarDeberes(BuildContext context, {required Cante clase, required List<Tema> bolsa, Temario? temario}) => showModalBottomSheet<List<Tarea>>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (_) => _EditorDeberes(clase: clase, bolsa: bolsa, temario: temario),
    );

class _EditorDeberes extends StatefulWidget {
  const _EditorDeberes({required this.clase, required this.bolsa, this.temario});
  final Cante clase;
  final List<Tema> bolsa;
  final Temario? temario;
  @override
  State<_EditorDeberes> createState() => _EditorDeberesState();
}

class _EditorDeberesState extends State<_EditorDeberes> {
  late final List<Tarea> _tareas = List.of(widget.clase.tareas);
  final _libre = TextEditingController();

  @override
  void dispose() {
    _libre.dispose();
    super.dispose();
  }

  String _titulo(String c) => widget.temario?.tema(c)?.titulo ?? '';

  /// Los temas para elegir: los de la clase y, si no hay, los del temario.
  List<Tema> get _temas => widget.bolsa.isNotEmpty ? widget.bolsa : [for (final e in widget.temario?.ejercicios ?? const <Ejercicio>[]) for (final p in e.partes) for (final t in p.temas) t];

  Future<void> _conTema(String tipo) async {
    final temas = _temas;
    if (temas.isEmpty) return;
    final codigo = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (c) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 6), child: Text(switch (tipo) { 'estudiar' => 'Estudiar qué tema', 'esquema' => 'Esquema a ciegas de qué tema', 'cantar' => 'Cantar qué tema', _ => 'Test de qué tema' }, style: context.textos.titleLarge)),
          Flexible(
            child: ListView(shrinkWrap: true, children: [
              if (tipo == 'test') ListTile(dense: true, title: const Text('De todo el temario'), onTap: () => Navigator.pop(c, '')),
              for (final t in temas) ListTile(dense: true, title: TextoTema(t.codigo, t.titulo), onTap: () => Navigator.pop(c, t.codigo)),
            ]),
          ),
        ]),
      ),
    );
    if (codigo == null) return;
    setState(() => _tareas.add(Tarea(id: nuevoId(), tipo: tipo, tema: codigo.isEmpty ? null : codigo, preguntas: tipo == 'test' ? 30 : 0, creada: DateTime.now())));
  }

  void _anadirLibre() {
    final t = _libre.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _tareas.add(Tarea(id: nuevoId(), tipo: 'libre', texto: t, creada: DateTime.now()));
      _libre.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Deberes para la clase del ${fechaCorta(widget.clase.fecha)}', style: context.textos.titleLarge),
          const SizedBox(height: 4),
          Text('Los ve en su app (en Hoy y en la clase) y los tacha; estudiar, esquema, cantar y test se tachan solos cuando lo hace.', style: context.textos.bodySmall),
          const SizedBox(height: 10),
          for (var i = 0; i < _tareas.length; i++)
            Row(children: [
              Icon(_tareas[i].hecha ? Icons.check_circle : Icons.radio_button_unchecked, size: 20, color: _tareas[i].hecha ? Paleta.acierto : context.colores.textoClaro),
              const SizedBox(width: 8),
              Expanded(child: Text(_tareas[i].etiqueta(tituloDe: _titulo), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
              IconButton(icon: const Icon(Icons.close, size: 18), tooltip: 'Quitar', visualDensity: VisualDensity.compact, onPressed: () => setState(() => _tareas.removeAt(i))),
            ]),
          const SizedBox(height: 8),
          Wrap(spacing: 6, runSpacing: 6, children: [
            ActionChip(avatar: const Icon(Icons.menu_book_outlined, size: 18), label: const Text('Estudiar…'), onPressed: () => _conTema('estudiar')),
            ActionChip(avatar: const Icon(Icons.psychology_outlined, size: 18), label: const Text('Esquema a ciegas de…'), onPressed: () => _conTema('esquema')),
            ActionChip(avatar: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Cantar por su cuenta…'), onPressed: () => _conTema('cantar')),
            ActionChip(avatar: const Icon(Icons.fact_check_outlined, size: 18), label: const Text('Test de 30 de…'), onPressed: () => _conTema('test')),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: TextField(controller: _libre, decoration: const InputDecoration(hintText: 'Otra cosa (p. ej. «repasa Mundell-Fleming»)', isDense: true), textCapitalization: TextCapitalization.sentences, onSubmitted: (_) => _anadirLibre())),
            IconButton(icon: const Icon(Icons.add), tooltip: 'Añadir', onPressed: _anadirLibre),
          ]),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(spacing: 8, children: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(context, List.of(_tareas)), child: const Text('Guardar')),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// Los deberes de una clase, como lista. Con [onTachar] (el alumno), casillas
/// que se marcan y desmarcan; sin él (el preparador), solo lectura.
class ListaDeberes extends ConsumerWidget {
  const ListaDeberes({super.key, required this.clase, this.onTachar});
  final Cante clase;
  final void Function(Tarea tarea, bool hecha)? onTachar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    String titulo(String c) => temario?.tema(c)?.titulo ?? '';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final t in clase.tareas)
        onTachar == null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(t.hecha ? Icons.check_circle : Icons.radio_button_unchecked, size: 20, color: t.hecha ? Paleta.acierto : context.colores.textoClaro),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t.etiqueta(tituloDe: titulo), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface, decoration: t.hecha ? TextDecoration.lineThrough : null))),
                ]),
              )
            : CheckboxListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: t.hecha,
                onChanged: (v) => onTachar!(t, v ?? false),
                title: Text(t.etiqueta(tituloDe: titulo), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface, decoration: t.hecha ? TextDecoration.lineThrough : null)),
                subtitle: t.hecha && t.hechaEn != null ? Text('Hecho el ${fechaCorta(t.hechaEn!)}', style: context.textos.labelSmall) : null,
              ),
    ]);
  }
}

/// «3 de 4 deberes» o «4 deberes» (vacío si no hay).
String resumenDeberes(Cante c) => c.tareas.isEmpty ? '' : '${c.tareasHechas} de ${c.tareas.length} ${c.tareas.length == 1 ? 'deber' : 'deberes'}';
