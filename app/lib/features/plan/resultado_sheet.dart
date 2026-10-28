import 'package:flutter/material.dart';

import '../../data/models/esquema.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Hoja para anotar cómo fue un cante: temas, tiempo, valoración y comentarios.
/// Con varios temas, cada uno se valora aparte y se pueden cambiar, quitar o
/// añadir (si hubo problemas con el cronómetro o con el sorteo, se corrige
/// después). Devuelve null si se cancela.
Future<ResultadoCante?> pedirResultadoCante(
  BuildContext context, {
  ResultadoCante inicial = const ResultadoCante(),
  List<Tema> opciones = const [],
  String? titulo,
  String? textoGuardar,
  Map<String, List<EntradaEsquema>> esquemas = const {},
}) =>
    showModalBottomSheet<ResultadoCante>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => _ResultadoSheet(inicial: inicial, opciones: opciones, titulo: titulo ?? '¿Cómo ha ido el cante?', textoGuardar: textoGuardar ?? 'Guardar en el diario', esquemas: esquemas),
    );

/// Solo la lista de control (los apartados que va tocando), para marcarla
/// durante la clase sin pasar por la valoración. Devuelve el resultado con
/// [ResultadoCante.cubiertos] y [ResultadoCante.apartados] puestos, o null.
Future<ResultadoCante?> marcarApartados(BuildContext context, {required ResultadoCante inicial, required List<String> temas, required Map<String, List<EntradaEsquema>> esquemas}) =>
    showModalBottomSheet<ResultadoCante>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => _ApartadosSheet(inicial: inicial, temas: temas, esquemas: esquemas),
    );

/// Las casillas de los apartados de un tema, con el nivel como sangría.
class ListaControl extends StatelessWidget {
  const ListaControl({super.key, required this.esquema, required this.marcados, required this.onChanged, this.titulo});
  final List<EntradaEsquema> esquema;
  final Set<String> marcados;
  final void Function(String titulo, bool marcado) onChanged;
  final String? titulo;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (titulo != null) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(titulo!, style: context.textos.labelMedium)),
        for (final e in esquema)
          Padding(
            padding: EdgeInsets.only(left: 14.0 * e.nivel.clamp(0, 3)),
            child: CheckboxListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: marcados.contains(e.titulo),
              onChanged: (v) => onChanged(e.titulo, v ?? false),
              title: Text(e.titulo, style: e.nivel == 0 ? context.textos.titleSmall : context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            ),
          ),
      ]);
}

class _ApartadosSheet extends StatefulWidget {
  const _ApartadosSheet({required this.inicial, required this.temas, required this.esquemas});
  final ResultadoCante inicial;
  final List<String> temas;
  final Map<String, List<EntradaEsquema>> esquemas;
  @override
  State<_ApartadosSheet> createState() => _ApartadosSheetState();
}

class _ApartadosSheetState extends State<_ApartadosSheet> {
  late final Map<String, Set<String>> _cubiertos = {for (final t in widget.temas) t: {...?widget.inicial.cubiertos[t]}};

  @override
  Widget build(BuildContext context) {
    final temas = widget.temas.where(widget.esquemas.containsKey).toList();
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Apartados que va tocando', style: context.textos.titleMedium),
        Text('Marca cada apartado del esquema cuando lo cante. Queda en la valoración y en su ficha.', style: context.textos.labelSmall),
        const SizedBox(height: 8),
        Flexible(
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              for (final t in temas)
                ListaControl(
                  titulo: temas.length > 1 ? 'Tema $t · ${_cubiertos[t]!.length}/${widget.esquemas[t]!.length}' : '${_cubiertos[t]!.length} de ${widget.esquemas[t]!.length}',
                  esquema: widget.esquemas[t]!,
                  marcados: _cubiertos[t]!,
                  onChanged: (a, v) => setState(() => v ? _cubiertos[t]!.add(a) : _cubiertos[t]!.remove(a)),
                ),
            ]),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Wrap(spacing: 8, children: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () => Navigator.pop(context, widget.inicial.copyWith(
                    cubiertos: {for (final t in temas) t: (_cubiertos[t]!.toList())..sort()},
                    apartados: {for (final t in temas) t: widget.esquemas[t]!.length},
                  )),
              child: const Text('Guardar'),
            ),
          ]),
        ),
      ]),
    );
  }
}

/// Los temas cantados de un resultado, uno por línea, con las estrellas de
/// cada uno si se valoraron aparte.
class TemasValorados extends StatelessWidget {
  const TemasValorados({super.key, required this.resultado, required this.titulo, this.colorDe});
  final ResultadoCante resultado;
  final String Function(String codigo) titulo;
  final Color? Function(String codigo)? colorDe;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (final t in resultado.temasCantados)
          Row(children: [
            Expanded(child: TextoTema(t, titulo(t), color: colorDe?.call(t))),
            if ((resultado.valoraciones[t] ?? 0) > 0) Padding(padding: const EdgeInsets.only(left: 8), child: Estrellas(valor: resultado.valoraciones[t]!, tamano: 16)),
          ]),
      ]);
}

class _ResultadoSheet extends StatefulWidget {
  const _ResultadoSheet({required this.inicial, required this.opciones, required this.titulo, required this.textoGuardar, this.esquemas = const {}});
  final ResultadoCante inicial;
  final List<Tema> opciones;
  final String titulo;
  final String textoGuardar;
  /// Esquemas (apartados) de los temas que pueden cantarse: la lista de control.
  final Map<String, List<EntradaEsquema>> esquemas;
  @override
  State<_ResultadoSheet> createState() => _ResultadoSheetState();
}

class _ResultadoSheetState extends State<_ResultadoSheet> {
  late final _comentarios = TextEditingController(text: widget.inicial.comentarios);
  late final _minutos = TextEditingController(text: widget.inicial.segundos == 0 ? '' : (widget.inicial.segundos / 60).round().toString());

  /// Los temas cantados, por orden (vacío si aún no se ha dicho cuál).
  late final List<String> _temas = List.of(widget.inicial.temasCantados);

  /// Valoración de cada tema (con uno solo, la del cante).
  late final Map<String, int> _valoraciones = {for (final t in _temas) t: widget.inicial.valoracionDe(t)};
  late int _valoracion = widget.inicial.valoracion;

  /// Lista de control: apartados marcados por tema (plegada por defecto).
  late final Map<String, Set<String>> _cubiertos = {for (final e in widget.inicial.cubiertos.entries) e.key: {...e.value}};
  final _desplegados = <String>{};

  @override
  void dispose() {
    _comentarios.dispose();
    _minutos.dispose();
    super.dispose();
  }

  bool get _varios => _temas.length > 1;

  /// Temas de la bolsa que aún no están en la lista (para añadir o cambiar).
  List<Tema> _libres({String? salvo}) => [for (final t in widget.opciones) if (t.codigo == salvo || !_temas.contains(t.codigo)) t];

  /// Desplegable para elegir el tema de la fila [i] (o el primero, si aún no
  /// hay ninguno) entre los de la bolsa.
  Widget _desplegable(int i) {
    final actual = i < _temas.length ? _temas[i] : null;
    final items = _libres(salvo: actual);
    final codigos = {for (final t in items) t.codigo};
    return DropdownButtonFormField<String>(
      key: ValueKey('tema$i:$actual'),
      initialValue: codigos.contains(actual) ? actual : null,
      isExpanded: true,
      decoration: InputDecoration(labelText: _varios ? 'Tema ${i + 1}' : 'Tema cantado', isDense: true),
      items: [
        // Un tema que ya no está en la bolsa (se cambió la lista) se conserva.
        if (actual != null && !codigos.contains(actual)) DropdownMenuItem(value: actual, child: Text(actual)),
        for (final t in items) DropdownMenuItem(value: t.codigo, child: Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
      onChanged: (v) => setState(() {
        if (v == null) return;
        final valor = actual == null ? 0 : (_valoraciones.remove(actual) ?? 0);
        if (i < _temas.length) {
          _temas[i] = v;
        } else {
          _temas.add(v);
        }
        _valoraciones[v] = valor;
      }),
    );
  }

  void _quitar(int i) => setState(() {
        final t = _temas.removeAt(i);
        _valoraciones.remove(t);
        if (!_varios && _temas.isNotEmpty) _valoracion = _valoraciones[_temas.first] ?? 0;
      });

  void _anadir() {
    final libres = _libres();
    if (libres.isEmpty) return;
    setState(() {
      // Con uno solo, su valoración era la del cante: se queda como la suya.
      if (_temas.length == 1) _valoraciones[_temas.first] = _valoracion;
      _temas.add(libres.first.codigo);
      _valoraciones[libres.first.codigo] = 0;
    });
  }

  ResultadoCante _resultado() {
    final min = int.tryParse(_minutos.text.trim());
    final porTema = _varios ? {for (final t in _temas) if ((_valoraciones[t] ?? 0) > 0) t: _valoraciones[t]!} : const <String, int>{};
    return ResultadoCante(
      sorteados: widget.inicial.sorteados,
      temaCantado: _temas.firstOrNull,
      otrosCantados: _temas.skip(1).toList(),
      // Si no se tocan los minutos se conserva el tiempo exacto del cronómetro.
      segundos: min == null ? 0 : (min == (widget.inicial.segundos / 60).round() ? widget.inicial.segundos : min * 60),
      valoracion: _varios ? ResultadoCante.media(porTema.values) : _valoracion,
      valoraciones: porTema,
      comentarios: _comentarios.text.trim(),
      // La lista de control de cada tema cantado con esquema (si se tocó alguna casilla o ya venía).
      cubiertos: {for (final t in _temas) if (widget.esquemas.containsKey(t) && (_cubiertos[t]?.isNotEmpty ?? false)) t: (_cubiertos[t]!.toList()..sort())},
      apartados: {for (final t in _temas) if (widget.esquemas.containsKey(t) && (_cubiertos[t]?.isNotEmpty ?? false)) t: widget.esquemas[t]!.length},
    );
  }

  @override
  Widget build(BuildContext context) {
    final conBolsa = widget.opciones.isNotEmpty;
    final minutos = SizedBox(
      width: 110,
      child: TextField(controller: _minutos, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minutos', isDense: true)),
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.titulo, style: context.textos.titleMedium),
          const SizedBox(height: 12),
          if (_varios) ...[
            // Un tema por fila, cada uno con sus estrellas.
            for (var i = 0; i < _temas.length; i++) ...[
              Row(children: [
                Expanded(child: conBolsa ? _desplegable(i) : Text('Tema ${_temas[i]}', style: context.textos.titleSmall)),
                IconButton(icon: const Icon(Icons.close, size: 18), tooltip: 'Quitar este tema', visualDensity: VisualDensity.compact, onPressed: () => _quitar(i)),
              ]),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Estrellas(valor: _valoraciones[_temas[i]] ?? 0, tamano: 24, onChanged: (v) => setState(() => _valoraciones[_temas[i]] = v)),
              ),
            ],
            Row(children: [
              if (_libres().isNotEmpty) ActionChip(avatar: const Icon(Icons.add, size: 18), label: const Text('Añadir tema'), onPressed: _anadir),
              const Spacer(),
              minutos,
            ]),
          ] else ...[
            if (conBolsa)
              _desplegable(0)
            else if (_temas.isNotEmpty)
              Text('Tema ${_temas.first}', style: context.textos.titleSmall),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: Estrellas(valor: _valoracion, onChanged: (v) => setState(() => _valoracion = v))),
              minutos,
            ]),
            if (_libres().isNotEmpty && _temas.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: ActionChip(avatar: const Icon(Icons.add, size: 18), label: const Text('Añadir tema'), onPressed: _anadir),
              ),
          ],
          // Lista de control: los apartados del esquema de cada tema cantado.
          for (final t in _temas)
            if (widget.esquemas[t] case final esquema?) ...[
              const SizedBox(height: 6),
              InkWell(
                onTap: () => setState(() => _desplegados.contains(t) ? _desplegados.remove(t) : _desplegados.add(t)),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(children: [
                    Icon(_desplegados.contains(t) ? Icons.expand_less : Icons.expand_more, size: 20, color: context.esquema.primary),
                    const SizedBox(width: 6),
                    Expanded(child: Text('Apartados${_varios ? ' de $t' : ''}: ${_cubiertos[t]?.length ?? 0} de ${esquema.length}${(_cubiertos[t]?.isEmpty ?? true) ? ' · marca los que ha tocado' : ''}', style: context.textos.labelMedium)),
                  ]),
                ),
              ),
              if (_desplegados.contains(t))
                ListaControl(
                  esquema: esquema,
                  marcados: _cubiertos[t] ??= {},
                  onChanged: (a, v) => setState(() => v ? (_cubiertos[t] ??= {}).add(a) : _cubiertos[t]?.remove(a)),
                ),
            ],
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
              FilledButton(onPressed: () => Navigator.pop(context, _resultado()), child: Text(widget.textoGuardar)),
            ]),
          ),
        ]),
      ),
    );
  }
}
