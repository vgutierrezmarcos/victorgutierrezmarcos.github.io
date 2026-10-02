import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'cantes_util.dart';

/// Alta o edición de un cante: cuándo es, con quién y qué temas entran.
class CanteFormPage extends ConsumerStatefulWidget {
  const CanteFormPage({super.key, this.cante, this.diaInicial});
  final Cante? cante;
  final DateTime? diaInicial;
  @override
  ConsumerState<CanteFormPage> createState() => _CanteFormPageState();
}

class _CanteFormPageState extends ConsumerState<CanteFormPage> {
  late final _titulo = TextEditingController(text: widget.cante?.titulo ?? '');
  late final _notas = TextEditingController(text: widget.cante?.notas ?? '');
  late DateTime _fecha;
  late int _minutos = widget.cante?.minutos ?? 30;
  late int _ejercicio = widget.cante?.ejercicio ?? 3;
  late TipoBolsa _bolsa = widget.cante?.bolsa ?? TipoBolsa.estudiados;
  late List<String> _temas = widget.cante?.temas ?? const [];
  bool _repetir = false;
  DateTime? _hasta;

  bool get _edicion => widget.cante != null;

  @override
  void initState() {
    super.initState();
    final d = widget.diaInicial ?? DateTime.now().add(const Duration(days: 1));
    _fecha = widget.cante?.fecha ?? DateTime(d.year, d.month, d.day, 17);
  }

  @override
  void dispose() {
    _titulo.dispose();
    _notas.dispose();
    super.dispose();
  }

  Future<void> _elegirDia() async {
    final d = await showDatePicker(context: context, initialDate: _fecha, firstDate: DateTime(_fecha.year - 1), lastDate: DateTime(_fecha.year + 5), helpText: 'Día del cante');
    if (d != null) setState(() => _fecha = DateTime(d.year, d.month, d.day, _fecha.hour, _fecha.minute));
  }

  Future<void> _elegirHora() async {
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_fecha), helpText: 'Hora del cante');
    if (t != null) setState(() => _fecha = DateTime(_fecha.year, _fecha.month, _fecha.day, t.hour, t.minute));
  }

  Future<void> _otraDuracion() async {
    final ctrl = TextEditingController(text: '$_minutos');
    final min = await showDialog<int>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Duración del cante'),
        content: TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number, decoration: const InputDecoration(suffixText: 'min')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(c, int.tryParse(ctrl.text.trim())), child: const Text('Aceptar')),
        ],
      ),
    );
    if (min != null && min > 0 && min <= 240) setState(() => _minutos = min);
  }

  Future<void> _elegirTemas() async {
    final temario = ref.read(temarioProvider).value;
    if (temario == null) return;
    final r = await elegirTemas(context, temario: temario, seleccion: _temas, ejercicios: _ejercicio == 0 ? {3, 4} : {_ejercicio}, titulo: 'Temas que entran');
    if (r != null) setState(() => _temas = r);
  }

  Future<void> _guardar() async {
    if (_bolsa == TipoBolsa.lista && _temas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Elige al menos un tema para el sorteo')));
      return;
    }
    final nav = Navigator.of(context);
    final base = (widget.cante ?? Cante(id: nuevoId(), fecha: _fecha)).copyWith(
      fecha: _fecha,
      titulo: _titulo.text.trim(),
      minutos: _minutos,
      ejercicio: _ejercicio,
      bolsa: _bolsa,
      temas: _bolsa == TipoBolsa.lista ? _temas : const [],
      notas: _notas.text.trim(),
    );
    final lista = !_edicion && _repetir && _hasta != null ? serieSemanal(base, _hasta!) : [base];
    await ref.read(cantesProvider.notifier).guardarVarios(lista);
    // La primera vez que se programa un cante se pide permiso para avisar.
    try {
      if (ref.read(planProvider).avisosCante && await Notificaciones.pedirPermiso()) {
        await ref.read(cantesProvider.notifier).reprogramarAvisos();
      }
    } catch (_) {
      // Sin servicio de notificaciones el cante se guarda igualmente.
    }
    nav.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraWeb(
        title: Text(_edicion ? 'Editar cante' : 'Nuevo cante'),
        actions: [TextButton(onPressed: _guardar, child: const Text('Guardar'))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          const TituloSeccion('Cuándo'),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: _elegirDia, icon: const Icon(Icons.event_outlined, size: 18), label: Text(fechaCorta(_fecha)))),
            const SizedBox(width: 10),
            OutlinedButton.icon(onPressed: _elegirHora, icon: const Icon(Icons.access_time, size: 18), label: Text(horaDe(_fecha))),
          ]),
          if (!_edicion) ...[
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Repetir cada semana'),
              subtitle: Text(_repetir && _hasta != null ? 'Hasta el ${fechaCorta(_hasta!)}' : 'Mismo día y hora', style: context.textos.labelSmall),
              value: _repetir,
              onChanged: (v) async {
                if (!v) return setState(() => _repetir = false);
                final h = await showDatePicker(
                  context: context,
                  initialDate: _hasta ?? _fecha.add(const Duration(days: 7 * 12)),
                  firstDate: _fecha,
                  lastDate: _fecha.add(const Duration(days: 7 * 103)),
                  helpText: 'Repetir hasta',
                );
                if (h != null) {
                  setState(() {
                    _repetir = true;
                    _hasta = h;
                  });
                }
              },
            ),
          ],
          const TituloSeccion('Con quién o dónde'),
          TextField(controller: _titulo, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Preparador, grupo de cante… (opcional)')),
          const TituloSeccion('Qué temas entran'),
          SegmentedButton<int>(showSelectedIcon: false, 
            segments: const [
              ButtonSegment(value: 3, label: Text('3.º')),
              ButtonSegment(value: 4, label: Text('4.º')),
              ButtonSegment(value: 0, label: Text('3.º y 4.º')),
            ],
            selected: {_ejercicio},
            onSelectionChanged: (s) => setState(() {
              _ejercicio = s.first;
              _temas = const [];
            }),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 8),
          for (final (tipo, titulo, sub) in [
            (TipoBolsa.estudiados, 'Los que llevo estudiados', 'Los marcados como estudiados el día del cante'),
            (TipoBolsa.lista, 'Una lista concreta', 'Los que hayas acordado con el preparador'),
            (TipoBolsa.ejercicio, 'Todo el ejercicio', 'Como en el examen'),
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: Icon(_bolsa == tipo ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: _bolsa == tipo ? context.esquema.primary : context.colores.textoClaro),
              onTap: () => setState(() => _bolsa = tipo),
              title: Text(titulo, style: context.textos.titleSmall),
              subtitle: Text(sub, style: context.textos.labelSmall),
            ),
          if (_bolsa == TipoBolsa.lista)
            OutlinedButton.icon(onPressed: _elegirTemas, icon: const Icon(Icons.checklist, size: 18), label: Text(_temas.isEmpty ? 'Elegir temas' : '${_temas.length} temas elegidos')),
          const TituloSeccion('Duración'),
          Wrap(spacing: 6, children: [
            // Si se eligió otra duración, aparece como una opción más.
            for (final m in {15, 20, 30, 45, _minutos}.toList()..sort()) ChoiceChip(label: Text('$m min'), selected: _minutos == m, onSelected: (_) => setState(() => _minutos = m)),
            ActionChip(label: const Text('Otro'), onPressed: _otraDuracion),
          ]),
          const TituloSeccion('Notas'),
          TextField(controller: _notas, minLines: 2, maxLines: 5, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Lo que quieras recordar para este cante (opcional)')),
        ],
      ),
    );
  }
}
