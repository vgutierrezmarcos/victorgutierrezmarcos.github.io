import 'package:flutter/material.dart';

import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Editor de la rúbrica (los criterios con los que se valoran los cantes):
/// quitar, añadir (hasta ocho, texto corto), reordenar y restaurar los de la
/// oposición. Devuelve la lista nueva, o null si se cancela. Vacía = solo
/// las estrellas de siempre.
Future<List<String>?> editarRubrica(BuildContext context, {required List<String> actual, required List<String> porDefecto}) {
  final lista = List.of(actual.isEmpty ? porDefecto : actual);
  final nuevo = TextEditingController();
  return showDialog<List<String>>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) {
        void anadir() {
          final t = nuevo.text.trim();
          if (t.isEmpty || lista.length >= 8 || lista.any((x) => x.toLowerCase() == t.toLowerCase())) return;
          set(() {
            lista.add(t.length > 30 ? t.substring(0, 30) : t);
            nuevo.clear();
          });
        }

        return AlertDialog(
          title: const Text('Criterios de valoración'),
          content: SizedBox(
            width: 420,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Cada criterio se valora de 1 a 5 estrellas al anotar un cante; son opcionales, y las estrellas de siempre siguen ahí (si no las tocas, salen de la media de los criterios).', style: Theme.of(d).textTheme.bodySmall),
              const SizedBox(height: 8),
              Flexible(
                child: ReorderableListView(
                  shrinkWrap: true,
                  buildDefaultDragHandles: false,
                  onReorder: (a, b) => set(() {
                    if (b > a) b--;
                    lista.insert(b, lista.removeAt(a));
                  }),
                  children: [
                    for (var i = 0; i < lista.length; i++)
                      ListTile(
                        key: ValueKey('crit$i${lista[i]}'),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: ReorderableDragStartListener(index: i, child: const Icon(Icons.drag_handle, size: 20)),
                        title: Text(lista[i]),
                        trailing: IconButton(icon: const Icon(Icons.close, size: 18), tooltip: 'Quitar', onPressed: () => set(() => lista.removeAt(i))),
                      ),
                  ],
                ),
              ),
              if (lista.length < 8)
                Row(children: [
                  Expanded(child: TextField(controller: nuevo, decoration: const InputDecoration(hintText: 'Otro criterio', isDense: true), textCapitalization: TextCapitalization.sentences, onSubmitted: (_) => anadir())),
                  IconButton(icon: const Icon(Icons.add), tooltip: 'Añadir', onPressed: anadir),
                ]),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(onPressed: () => set(() => lista..clear()..addAll(porDefecto)), child: const Text('Los de la oposición')),
              ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, List.of(lista)), child: const Text('Guardar')),
          ],
        );
      },
    ),
  );
}

/// Fila de ajustes «Valorar por criterios» (preparador y opositor): un
/// interruptor que activa la rúbrica (con los criterios de la oposición) y,
/// activada, el subtítulo con los criterios y un toque para editarlos.
class FilaRubrica extends StatelessWidget {
  const FilaRubrica({super.key, required this.rubrica, required this.porDefecto, required this.onChanged, this.texto});
  final List<String> rubrica;
  final List<String> porDefecto;
  final ValueChanged<List<String>> onChanged;
  final String? texto;

  @override
  Widget build(BuildContext context) {
    final activa = rubrica.isNotEmpty;
    return ListTile(
      leading: const Icon(Icons.fact_check_outlined),
      title: const Text('Valorar por criterios'),
      subtitle: Text(
        activa ? '${rubrica.join(' · ')}. Toca para cambiarlos.' : (texto ?? 'Además de las estrellas: esquema, rigor, tiempo, exposición y actualidad (o los tuyos). Opcional en cada cante.'),
        style: context.textos.labelSmall,
      ),
      trailing: Switch(value: activa, onChanged: (v) => onChanged(v ? List.of(porDefecto) : const [])),
      onTap: !activa
          ? null
          : () async {
              final r = await editarRubrica(context, actual: rubrica, porDefecto: porDefecto);
              if (r != null) onChanged(r);
            },
    );
  }
}

/// «Evolución por criterio»: la media de los últimos cinco cantes valorados
/// con cada criterio frente a los cinco anteriores (↑ ↓ →), y el más flojo.
class EvolucionCriterios extends StatelessWidget {
  const EvolucionCriterios({super.key, required this.cantes});
  /// De más reciente a más antiguo.
  final Iterable<Cante> cantes;

  @override
  Widget build(BuildContext context) {
    final ev = evolucionCriterios(cantes);
    if (ev.isEmpty) return const SizedBox.shrink();
    final entradas = ev.entries.toList()..sort((a, b) => a.value.ultimos.compareTo(b.value.ultimos));
    final flojo = entradas.first;
    String num(double v) => v.toStringAsFixed(1).replaceAll('.', ',');
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const TituloSeccion('Evolución por criterio'),
      Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Media de los últimos 5 cantes valorados con cada criterio, frente a los 5 anteriores.', style: context.textos.labelSmall),
          const SizedBox(height: 6),
          for (final e in entradas)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(children: [
                Expanded(flex: 4, child: Text(e.key, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface, fontWeight: e.key == flojo.key && entradas.length > 1 ? FontWeight.w600 : null))),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(value: e.value.ultimos / 5, minHeight: 8, backgroundColor: context.colores.fondoClaro, color: e.value.ultimos >= 3 ? Paleta.acierto : Paleta.fallo),
                  ),
                ),
                SizedBox(
                  width: 84,
                  child: Text(
                    '${num(e.value.ultimos)}${e.value.anteriores == null ? '' : (e.value.ultimos > e.value.anteriores! + 0.2 ? ' ↑' : (e.value.ultimos < e.value.anteriores! - 0.2 ? ' ↓' : ' →'))} · ${e.value.veces}',
                    textAlign: TextAlign.end,
                    style: context.textos.labelMedium,
                  ),
                ),
              ]),
            ),
          if (entradas.length > 1) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Lo más flojo: ${flojo.key}.', style: context.textos.labelSmall)),
        ]),
      ),
    ]);
  }
}
