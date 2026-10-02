import 'package:flutter/material.dart';

import '../data/models/temario.dart';
import '../theme/app_theme.dart';

/// Abre un selector de temas a pantalla completa y devuelve los códigos
/// elegidos (null si se cancela). [ejercicios] limita los ejercicios mostrados.
Future<List<String>?> elegirTemas(
  BuildContext context, {
  required Temario temario,
  Iterable<String> seleccion = const [],
  Set<int>? ejercicios,
  String titulo = 'Elegir temas',
}) =>
    Navigator.of(context, rootNavigator: true).push<List<String>>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _SelectorTemas(temario: temario, inicial: seleccion.toSet(), ejercicios: ejercicios, titulo: titulo),
    ));

class _SelectorTemas extends StatefulWidget {
  const _SelectorTemas({required this.temario, required this.inicial, required this.ejercicios, required this.titulo});
  final Temario temario;
  final Set<String> inicial;
  final Set<int>? ejercicios;
  final String titulo;
  @override
  State<_SelectorTemas> createState() => _SelectorTemasState();
}

class _SelectorTemasState extends State<_SelectorTemas> {
  late final Set<String> _sel = {...widget.inicial};
  String _busqueda = '';

  @override
  Widget build(BuildContext context) {
    final q = _busqueda.trim().toLowerCase();
    final ejercicios = widget.temario.ejercicios.where((e) => e.temas.isNotEmpty && (widget.ejercicios == null || widget.ejercicios!.contains(e.id)));
    // Se devuelven en el orden del temario, no en el de selección.
    List<String> ordenados() => [for (final t in widget.temario.todosLosTemas) if (_sel.contains(t.codigo)) t.codigo];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        actions: [TextButton(onPressed: () => Navigator.pop(context, ordenados()), child: Text('Aceptar (${_sel.length})'))],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Buscar tema…', prefixIcon: Icon(Icons.search), isDense: true),
              onChanged: (v) => setState(() => _busqueda = v),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
        children: [
          for (final e in ejercicios)
            for (final p in e.partes.where((p) => p.temas.isNotEmpty))
              Builder(builder: (context) {
                final temas = p.temas.where((t) => q.isEmpty || '${t.codigo} ${t.titulo}'.toLowerCase().contains(q)).toList();
                if (temas.isEmpty) return const SizedBox.shrink();
                final marcados = p.temas.where((t) => _sel.contains(t.codigo)).length;
                return ExpansionTile(
                  key: PageStorageKey('${e.id}.${p.letra}'),
                  initiallyExpanded: q.isNotEmpty || marcados > 0,
                  title: Text('${e.id}.${p.letra} · ${p.nombre}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                  subtitle: Text('$marcados de ${p.temas.length}', style: context.textos.labelSmall),
                  trailing: TextButton(
                    onPressed: () => setState(() {
                      final codigos = p.temas.map((t) => t.codigo);
                      marcados == p.temas.length ? _sel.removeAll(codigos) : _sel.addAll(codigos);
                    }),
                    child: Text(marcados == p.temas.length ? 'Ninguno' : 'Todos'),
                  ),
                  children: [
                    for (final t in temas)
                      CheckboxListTile(
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _sel.contains(t.codigo),
                        onChanged: (v) => setState(() => v == true ? _sel.add(t.codigo) : _sel.remove(t.codigo)),
                        title: Text('${t.codigo} · ${t.titulo}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                      ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
