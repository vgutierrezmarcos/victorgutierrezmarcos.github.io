import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/permiso_calendario.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'cantes_util.dart';
import 'modalidad.dart';
import '../inicio/permisos_sheet.dart';

/// Alta o edición de un cante: cuándo es, con quién y qué temas entran.
///
/// Con [alumnos] es el formulario de una sesión de preparador: se elige al
/// alumno (uno solo: las clases son individuales).
class CanteFormPage extends ConsumerStatefulWidget {
  const CanteFormPage({super.key, this.cante, this.diaInicial, this.alumnos, this.alumnosIniciales = const {}});
  final Cante? cante;
  final DateTime? diaInicial;
  /// Alumnos entre los que elegir (null = cante propio del opositor).
  final List<Alumno>? alumnos;
  final Set<String> alumnosIniciales;
  @override
  ConsumerState<CanteFormPage> createState() => _CanteFormPageState();
}

class _CanteFormPageState extends ConsumerState<CanteFormPage> {
  late final _titulo = TextEditingController(text: widget.cante?.titulo ?? '');
  late final _notas = TextEditingController(text: widget.cante?.notas ?? '');
  late Modalidad _modalidad = widget.cante?.modalidad ?? Modalidad.sinIndicar;
  late final _lugar = TextEditingController(text: widget.cante?.lugar ?? '');
  late final _enlace = TextEditingController(text: widget.cante?.enlace ?? '');
  late DateTime _fecha;
  late int _minutos = widget.cante?.minutos ?? (_sesion ? ref.read(perfilPreparadorProvider).minutosClase : 30);
  late int _exposicion = widget.cante?.exposicion ?? 30;
  late String _plataforma = widget.cante?.plataformaEfectiva.isNotEmpty == true ? widget.cante!.plataformaEfectiva : ref.read(perfilPreparadorProvider).plataforma;
  late int _numTemas = widget.cante?.numTemas ?? ref.read(perfilPreparadorProvider).temasPorClase;
  late bool _unoPorParte = widget.cante?.unoPorParte ?? false;
  late int _ejercicio = widget.cante?.ejercicio ?? Oposiciones.actual.primerConTemas;
  late TipoBolsa _bolsa = widget.cante?.bolsa ?? TipoBolsa.estudiados;
  late List<String> _temas = widget.cante?.temas ?? const [];
  bool _repetir = false;
  DateTime? _hasta;
  late final Set<String> _alumnos = {...widget.alumnosIniciales, if (widget.cante?.alumno != null) widget.cante!.alumno!};

  bool get _edicion => widget.cante != null;
  bool get _sesion => widget.alumnos != null;

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
    _lugar.dispose();
    _enlace.dispose();
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

  Future<void> _otraDuracion({bool exposicion = false}) async {
    final ctrl = TextEditingController(text: '${exposicion ? _exposicion : _minutos}');
    final min = await showDialog<int>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(exposicion ? 'Exposición por tema' : (_sesion ? 'Duración de la clase' : 'Duración del cante')),
        content: TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number, decoration: const InputDecoration(suffixText: 'min')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(c, int.tryParse(ctrl.text.trim())), child: const Text('Aceptar')),
        ],
      ),
    );
    if (min != null && min > 0 && min <= 240) setState(() => exposicion ? _exposicion = min : _minutos = min);
  }

  Future<void> _elegirTemas() async {
    final temario = ref.read(temarioProvider).valueOrNull;
    if (temario == null) return;
    final r = await elegirTemas(context, temario: temario, seleccion: _temas, ejercicios: Oposiciones.actual.ejerciciosDeBolsa(_ejercicio), titulo: 'Temas que entran');
    if (r != null) setState(() => _temas = r);
  }

  Future<void> _guardar() async {
    if (_ejercicio != 1 && _bolsa == TipoBolsa.lista && _temas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Elige al menos un tema para el sorteo')));
      return;
    }
    if (_sesion && _alumnos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Elige el alumno')));
      return;
    }
    final nav = Navigator.of(context);
    final base = (widget.cante ?? Cante(id: nuevoId(), fecha: _fecha)).copyWith(
      fecha: _fecha,
      titulo: _titulo.text.trim(),
      minutos: _minutos,
      exposicion: _exposicion,
      numTemas: _numTemas,
      unoPorParte: _unoPorParte,
      ejercicio: _ejercicio,
      bolsa: Oposiciones.actual.esDictamen(_ejercicio) ? TipoBolsa.estudiados : _bolsa,
      temas: !Oposiciones.actual.esDictamen(_ejercicio) && _bolsa == TipoBolsa.lista ? _temas : const [],
      notas: _notas.text.trim(),
      modalidad: _modalidad,
      lugar: _modalidad == Modalidad.presencial ? _lugar.text.trim() : '',
      enlace: _modalidad == Modalidad.online ? (enlaceReunion(_enlace.text) ?? '') : '',
      plataforma: _modalidad == Modalidad.online && _sesion ? _plataforma : '',
    );
    if (_sesion) {
      // Una sesión por alumno, cada una con su repetición semanal si se pidió.
      final sesiones = <Cante>[
        for (final (i, alumno) in _alumnos.indexed)
          ...() {
            final suya = (i == 0 ? base : Cante.fromJson({...base.toJson(), 'id': nuevoId()})).copyWith(alumno: alumno);
            return !_edicion && _repetir && _hasta != null ? serieSemanal(suya, _hasta!) : [suya];
          }(),
      ];
      await ref.read(sesionesProvider.notifier).guardarVarias(sesiones);
      nav.pop();
      return;
    }
    final lista = !_edicion && _repetir && _hasta != null ? serieSemanal(base, _hasta!) : [base];
    await ref.read(cantesProvider.notifier).guardarVarios(lista);
    // La primera vez que se programa un cante se pide permiso para avisar.
    try {
      if (ref.read(planProvider).avisosCante && mounted && await asegurarAvisos(context)) {
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
        title: Text(_sesion ? (_edicion ? 'Editar clase' : 'Nueva clase') : (_edicion ? 'Editar cante' : 'Nuevo cante')),
        actions: [TextButton(onPressed: _guardar, child: const Text('Guardar'))],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          if (_sesion && !_edicion) ...[
            const TituloSeccion('Quién canta'),
            if (widget.alumnos!.isEmpty)
              Text('Aún no tienes alumnos.', style: context.textos.bodySmall)
            else
              Wrap(spacing: 6, runSpacing: 2, children: [
                for (final a in widget.alumnos!)
                  // Un solo alumno por clase: elegir otro sustituye al anterior.
                  ChoiceChip(
                    label: Text(a.nombre),
                    selected: _alumnos.contains(a.id),
                    onSelected: (v) => setState(() {
                      _alumnos.clear();
                      if (v) _alumnos.add(a.id);
                    }),
                  ),
              ]),
          ],
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
          TituloSeccion(_sesion ? 'Nombre de la sesión' : 'Con quién o dónde'),
          TextField(controller: _titulo, textCapitalization: TextCapitalization.sentences, decoration: InputDecoration(hintText: _sesion ? 'Simulacro, repaso del bloque A… (opcional)' : 'Preparador, simulacro… (opcional)')),
          const TituloSeccion('Presencial u online'),
          SelectorModalidad(
            modalidad: _modalidad,
            onModalidad: (m) => setState(() => _modalidad = m),
            lugar: _lugar,
            enlace: _enlace,
            meetAutomatico: _sesion && calendarioDisponible && ref.watch(perfilPreparadorProvider).calendarioGoogle,
            plataforma: _sesion ? _plataforma : null,
            onPlataforma: _sesion ? (p) => setState(() => _plataforma = p) : null,
          ),
          const TituloSeccion('Qué se canta'),
          SegmentedButton<int>(showSelectedIcon: false, 
            segments: segmentosEjercicio(ambos: true),
            selected: {_ejercicio},
            onSelectionChanged: (s) => setState(() {
              _ejercicio = s.first;
              _temas = const [];
            }),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 8),
          if (Oposiciones.actual.esDictamen(_ejercicio))
            Text('${Oposiciones.actual.avisoDictamen(_ejercicio)} No hay sorteo de temas; el cronómetro y la valoración funcionan igual.', style: context.textos.bodySmall),
          if (!Oposiciones.actual.esDictamen(_ejercicio))
          for (final (tipo, titulo, sub) in [
            (TipoBolsa.estudiados, _sesion ? 'Los que lleva estudiados' : 'Los que llevo estudiados', _sesion ? 'Los que el alumno tenga marcados el día del cante' : 'Los marcados como estudiados el día del cante'),
            (TipoBolsa.lista, 'Una lista concreta', _sesion ? 'Los que hayas acordado con el alumno' : 'Los que hayas acordado con el preparador'),
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
          if (_bolsa == TipoBolsa.lista && !Oposiciones.actual.esDictamen(_ejercicio))
            OutlinedButton.icon(onPressed: _elegirTemas, icon: const Icon(Icons.checklist, size: 18), label: Text(_temas.isEmpty ? 'Elegir temas' : '${_temas.length} temas elegidos')),
          if (_sesion && !Oposiciones.actual.esDictamen(_ejercicio)) ...[
            const SizedBox(height: 10),
            Text('Temas que se cantan en la clase', style: context.textos.titleSmall),
            const SizedBox(height: 4),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [ButtonSegment(value: 1, label: Text('1 tema')), ButtonSegment(value: 2, label: Text('2 temas'))],
              selected: {_numTemas.clamp(1, 2)},
              onSelectionChanged: (s) => setState(() => _numTemas = s.first),
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            if (_numTemas > 1)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: const Text('Uno de cada parte'),
                subtitle: Text('Al sortearlos, cada tema de una parte distinta, como en el examen.', style: context.textos.labelSmall),
                value: _unoPorParte,
                onChanged: (v) => setState(() => _unoPorParte = v),
              ),
          ],
          TituloSeccion(_sesion ? 'Duración de la clase' : 'Duración'),
          Wrap(spacing: 6, runSpacing: 6, children: [
            // Si se eligió otra duración, aparece como una opción más.
            for (final m in {...(_sesion ? duracionesClase : duracionesCante), _minutos}.toList()..sort()) ChoiceChip(label: Text(textoDuracion(m)), selected: _minutos == m, onSelected: (_) => setState(() => _minutos = m)),
            ActionChip(label: const Text('Otra'), onPressed: _otraDuracion),
          ]),
          if (!Oposiciones.actual.esDictamen(_ejercicio)) ...[
            const TituloSeccion('Exposición por tema'),
            Text('Lo que cuenta el cronómetro al cantar cada tema.', style: context.textos.labelSmall),
            const SizedBox(height: 4),
            Wrap(spacing: 6, runSpacing: 6, children: [
              for (final m in {...duracionesExposicion, _exposicion}.toList()..sort()) ChoiceChip(label: Text('$m min'), selected: _exposicion == m, onSelected: (_) => setState(() => _exposicion = m)),
              ActionChip(label: const Text('Otra'), onPressed: () => _otraDuracion(exposicion: true)),
            ]),
          ],
          const TituloSeccion('Notas'),
          TextField(controller: _notas, minLines: 2, maxLines: 5, textCapitalization: TextCapitalization.sentences, decoration: InputDecoration(hintText: _sesion ? 'Indicaciones para el alumno (las verá si está enlazado)' : 'Lo que quieras recordar para este cante (opcional)')),
        ],
      ),
    );
  }
}
