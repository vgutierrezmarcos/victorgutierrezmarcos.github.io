import 'package:flutter/material.dart';

import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Hoja para anotar cómo fue un cante: tema, tiempo, valoración y comentarios.
/// Devuelve null si se cancela.
Future<ResultadoCante?> pedirResultadoCante(
  BuildContext context, {
  ResultadoCante inicial = const ResultadoCante(),
  List<Tema> opciones = const [],
  String? titulo,
  String? textoGuardar,
}) =>
    showModalBottomSheet<ResultadoCante>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => _ResultadoSheet(inicial: inicial, opciones: opciones, titulo: titulo ?? '¿Cómo ha ido el cante?', textoGuardar: textoGuardar ?? 'Guardar en el diario'),
    );

class _ResultadoSheet extends StatefulWidget {
  const _ResultadoSheet({required this.inicial, required this.opciones, required this.titulo, required this.textoGuardar});
  final ResultadoCante inicial;
  final List<Tema> opciones;
  final String titulo;
  final String textoGuardar;
  @override
  State<_ResultadoSheet> createState() => _ResultadoSheetState();
}

class _ResultadoSheetState extends State<_ResultadoSheet> {
  late final _comentarios = TextEditingController(text: widget.inicial.comentarios);
  late final _minutos = TextEditingController(text: widget.inicial.segundos == 0 ? '' : (widget.inicial.segundos / 60).round().toString());
  late int _valoracion = widget.inicial.valoracion;
  late String? _tema = widget.inicial.temaCantado;

  @override
  void dispose() {
    _comentarios.dispose();
    _minutos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codigos = {for (final t in widget.opciones) t.codigo};
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.titulo, style: context.textos.titleMedium),
          const SizedBox(height: 12),
          if (widget.inicial.otrosCantados.isNotEmpty)
            Text('Temas cantados: ${widget.inicial.temasCantados.join(' y ')}', style: context.textos.titleSmall)
          else if (widget.opciones.isNotEmpty)
            DropdownButtonFormField<String>(
              initialValue: codigos.contains(_tema) ? _tema : null,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Tema cantado', isDense: true),
              items: [
                for (final t in widget.opciones)
                  DropdownMenuItem(value: t.codigo, child: Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (v) => setState(() => _tema = v),
            )
          else if (_tema != null)
            Text('Tema $_tema', style: context.textos.titleSmall),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Estrellas(valor: _valoracion, onChanged: (v) => setState(() => _valoracion = v))),
            SizedBox(
              width: 110,
              child: TextField(controller: _minutos, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minutos', isDense: true)),
            ),
          ]),
          const SizedBox(height: 12),
          TextField(
            controller: _comentarios,
            minLines: 3,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(hintText: 'Comentarios del preparador, fallos, qué mejorar…'),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(alignment: WrapAlignment.end, spacing: 8, runSpacing: 4, children: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                final min = int.tryParse(_minutos.text.trim());
                Navigator.pop(
                  context,
                  ResultadoCante(
                    sorteados: widget.inicial.sorteados,
                    temaCantado: widget.inicial.otrosCantados.isNotEmpty ? widget.inicial.temaCantado : _tema,
                    otrosCantados: widget.inicial.otrosCantados,
                    // Si no se tocan los minutos se conserva el tiempo exacto del cronómetro.
                    segundos: min == null ? 0 : (min == (widget.inicial.segundos / 60).round() ? widget.inicial.segundos : min * 60),
                    valoracion: _valoracion,
                    comentarios: _comentarios.text.trim(),
                  ),
                );
              },
              child: Text(widget.textoGuardar),
            ),
          ])),
        ]),
      ),
    );
  }
}
