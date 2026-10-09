import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/sorteo.dart';
import '../plan/cantes_util.dart';
import '../mas/ayuda_videos.dart';

/// Antelaciones que se ofrecen para mandar el tema, en segundos antes de la
/// clase: el tiempo de esquema de un tema (22'30"), de dos (45 min) o una hora.
const antelacionesTema = [1350, 2700, 3600];

/// «22 min 30 s», «45 min», «1 h», «1 h 30 min», «2 días».
String textoAntelacion(int segundos) {
  final d = Duration(seconds: segundos);
  if (d.inHours >= 24 && d.inHours % 24 == 0 && d.inMinutes % 60 == 0) return d.inDays == 1 ? '1 día' : '${d.inDays} días';
  final partes = [
    if (d.inHours > 0) '${d.inHours} h',
    if (d.inMinutes % 60 > 0) '${d.inMinutes % 60} min',
    if (d.inSeconds % 60 > 0) '${d.inSeconds % 60} s',
  ];
  return partes.isEmpty ? '0 min' : partes.join(' ');
}

/// Lee «45», «22:30», «22,5» o «1:30:00» (minutos, o horas:minutos:segundos).
int? leerAntelacion(String texto) {
  final t = texto.trim().replaceAll(',', '.');
  if (t.isEmpty) return null;
  final partes = t.split(':');
  if (partes.length == 1) {
    final m = double.tryParse(t);
    return m == null || m <= 0 ? null : (m * 60).round();
  }
  final n = partes.map(int.tryParse).toList();
  if (n.contains(null)) return null;
  final s = n.length == 2 ? n[0]! * 60 + n[1]! : n[0]! * 3600 + n[1]! * 60 + n[2]!;
  return s <= 0 ? null : s;
}

/// Pide una antelación a medida.
Future<int?> pedirAntelacion(BuildContext context, {int? actual}) async {
  final ctrl = TextEditingController(text: actual == null ? '' : '${actual ~/ 60}${actual % 60 == 0 ? '' : ':${(actual % 60).toString().padLeft(2, '0')}'}');
  return showDialog<int>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) {
        final s = leerAntelacion(ctrl.text);
        return AlertDialog(
          title: const Text('Otra antelación'),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(suffixText: 'min antes', helperText: s == null ? 'Minutos (por ejemplo, 30 o 22:30)' : textoAntelacion(s)),
            onChanged: (_) => set(() {}),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: s == null ? null : () => Navigator.pop(d, s), child: const Text('Aceptar')),
          ],
        );
      },
    ),
  );
}

/// «el martes 14 a las 18:00».
String cuandoTema(DateTime d) => DateFormat("EEEE d 'a las' HH:mm", 'es').format(d);

/// Parte de un tema por su código: «3.A» de «3.A.7».
String parteDeTema(Tema t) => t.codigo.split('.').take(2).join('.');

/// Abre la hoja para mandar los temas de la clase [s] (elegidos o a suerte,
/// a una hora). Devuelve la clase con el envío programado, o null.
Future<Cante?> elegirTemasAnticipados(BuildContext context, {required Cante sesion, required List<Tema> temas}) => showModalBottomSheet<Cante>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _HojaTemaAnticipado(sesion: sesion, temas: temas),
    );

/// Ficha de la clase (preparador): mandar al alumno los temas antes de la
/// clase para que haga el esquema y los practique. Elegidos o sacados a
/// suerte entre los de la clase (uno o dos); a una hora fija o con cierta
/// antelación.
class SeccionTemaAnticipado extends ConsumerWidget {
  const SeccionTemaAnticipado({super.key, required this.sesion, required this.temas, required this.enlazado});
  final Cante sesion;
  final List<Tema> temas;
  final bool enlazado;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = sesion;
    final notifier = ref.read(sesionesProvider.notifier);
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final ahora = DateTime.now();

    Future<void> elegir() async {
      final r = await elegirTemasAnticipados(context, sesion: s, temas: temas);
      if (r != null) await notifier.guardar(r);
    }

    if (!enlazado) {
      return Text('Cuando el alumno enlace su app (o si es una clase suelta pedida desde la app), podrás mandarle los temas antes de la clase para que haga el esquema. Si ya la tiene y sale duplicado, une las dos fichas desde la suya.', style: context.textos.labelSmall);
    }
    if (!s.mandaTema) {
      return Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
        onTap: temas.isEmpty ? null : elegir,
        child: Row(children: [
          Icon(Icons.forward_to_inbox_outlined, color: context.esquema.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Mandarle ${s.numTemas == 1 ? 'un tema' : 'los temas'} antes', style: context.textos.titleSmall),
              Text(
                temas.isEmpty ? 'Primero elige los temas que entran en la clase.' : 'Elegidos por ti o a suerte. Le llegan como un mensaje tuyo, a la hora que elijas, para que haga el esquema.',
                style: context.textos.labelSmall,
              ),
            ]),
          ),
          if (temas.isNotEmpty) Icon(Icons.chevron_right, color: context.colores.textoClaro),
        ]),
      );
    }
    final llegado = !s.temaA!.isAfter(ahora);
    final oculto = s.temaSorteado && !llegado;
    final n = s.temasMandados.length;
    return Tarjeta(
      color: context.colores.primarioPalido,
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.only(top: 2), child: Icon(llegado ? Icons.mark_email_read_outlined : Icons.schedule_send_outlined, color: context.esquema.primary)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(llegado ? '${n == 1 ? 'Tema enviado' : 'Temas enviados'} ${cuandoTema(s.temaA!)}' : 'Se le ${n == 1 ? 'manda' : 'mandan'} ${cuandoTema(s.temaA!)}', style: context.textos.titleSmall),
            const SizedBox(height: 2),
            if (oculto)
              Text(n == 1 ? 'Bola sorteada: ni tú la verás hasta esa hora.' : '$n bolas sorteadas: ni tú las verás hasta esa hora.', style: context.textos.bodySmall)
            else
              for (final t in s.temasMandados)
                Padding(padding: const EdgeInsets.only(bottom: 2), child: TextoTema(t, temario?.tema(t)?.titulo ?? '', color: estructura?.colorDe(t))),
            if (!llegado) Text('Hasta entonces el alumno solo sabe a qué hora le ${n == 1 ? 'llegará' : 'llegarán'}.', style: context.textos.labelSmall),
          ]),
        ),
        if (!llegado)
          PopupMenuButton<String>(
            tooltip: 'Cambiar',
            onSelected: (v) async {
              if (v == 'cambiar') await elegir();
              if (v == 'quitar') await notifier.guardar(s.copyWith(sinTema: true));
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'cambiar', child: Text('Cambiar temas u hora')),
              PopupMenuItem(value: 'quitar', child: Text('No mandarlos')),
            ],
          ),
      ]),
    );
  }
}

class _HojaTemaAnticipado extends ConsumerStatefulWidget {
  const _HojaTemaAnticipado({required this.sesion, required this.temas});
  final Cante sesion;
  final List<Tema> temas;
  @override
  ConsumerState<_HojaTemaAnticipado> createState() => _HojaTemaAnticipadoState();
}

class _HojaTemaAnticipadoState extends ConsumerState<_HojaTemaAnticipado> {
  late bool _sortear = widget.sesion.mandaTema ? widget.sesion.temaSorteado : false;
  late final Set<String> _temas = {if (widget.sesion.mandaTema && !widget.sesion.temaSorteado) ...widget.sesion.temasMandados};
  late int _n = widget.sesion.mandaTema ? widget.sesion.temasMandados.length.clamp(1, 2) : widget.sesion.numTemas.clamp(1, 2);
  late bool _unoPorParte = widget.sesion.unoPorParte;
  // Antelación en segundos, o null si es a una hora concreta (_hora).
  int? _antelacion;
  DateTime? _hora;
  // La antelación sigue a «la del examen» para N temas mientras no se toque.
  bool _antelacionAutomatica = false;

  /// Partes distintas entre los temas de la clase («3.A», «3.B»…).
  late final Set<String> _partes = {for (final t in widget.temas) parteDeTema(t)};

  int _antelacionDelExamen(int n) => ref.read(perfilPreparadorProvider).antelacionTema(temas: n, ejercicio: widget.sesion.ejercicio == 0 ? null : widget.sesion.ejercicio);

  @override
  void initState() {
    super.initState();
    final s = widget.sesion;
    if (s.mandaTema) {
      // Si se programó con antelación, se muestra así; si no, la hora exacta.
      _antelacion = s.fecha.difference(s.temaA!).inSeconds;
      _hora = s.temaA;
    } else {
      _antelacion = _antelacionDelExamen(_n);
      _antelacionAutomatica = ref.read(perfilPreparadorProvider).segundosTemaAntes == null;
    }
  }

  void _cambiarN(int n) => setState(() {
        _n = n;
        if (_antelacionAutomatica) _antelacion = _antelacionDelExamen(n);
        while (_temas.length > n) {
          _temas.remove(_temas.last);
        }
      });

  DateTime? get _cuando => _antelacion != null ? widget.sesion.fecha.subtract(Duration(seconds: _antelacion!)) : _hora;

  Future<void> _elegirHora() async {
    final s = widget.sesion;
    final base = _hora ?? s.fecha.subtract(const Duration(hours: 24));
    final d = await showDatePicker(context: context, initialDate: base.isBefore(DateTime.now()) ? DateTime.now() : base, firstDate: DateTime.now(), lastDate: s.fecha, helpText: 'Día en que le llega');
    if (d == null || !mounted) return;
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(base), helpText: 'Hora en que le llega');
    if (t == null) return;
    setState(() {
      _hora = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      _antelacion = null;
      _antelacionAutomatica = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.sesion;
    final cuando = _cuando;
    final ahora = DateTime.now();
    final valida = cuando != null && cuando.isAfter(ahora) && cuando.isBefore(s.fecha);
    final listo = valida && (_sortear ? widget.temas.length >= _n : _temas.length == _n);
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final conPartes = _partes.length >= 2 && _n > 1;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Expanded(child: Text('Mandar los temas antes de la clase', style: context.textos.titleLarge)),
              const BotonVideoAyuda('programar-clase'),
            ]),
            const SizedBox(height: 4),
            Text('Le llegan como un mensaje tuyo con el número y el título de cada tema, para que haga el esquema y los practique. Antes de esa hora no puede verlos.', style: context.textos.bodySmall),
            const TituloSeccion('¿Cuántos temas?'),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [ButtonSegment(value: 1, label: Text('1 tema')), ButtonSegment(value: 2, label: Text('2 temas'))],
              selected: {_n},
              onSelectionChanged: (v) => _cambiarN(v.first),
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            const SizedBox(height: 4),
            Text(_n == 2 ? 'Como cerca del examen: dos temas, con el esquema de los dos.' : 'Un solo tema.', style: context.textos.labelSmall),
            const TituloSeccion('¿Cuáles?'),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: false, icon: Icon(Icons.checklist, size: 18), label: Text('Los elijo yo')),
                ButtonSegment(value: true, icon: Icon(Icons.casino_outlined, size: 18), label: Text('A suerte')),
              ],
              selected: {_sortear},
              onSelectionChanged: (v) => setState(() => _sortear = v.first),
            ),
            const SizedBox(height: 8),
            if (_sortear) ...[
              Text('La app saca ${_n == 1 ? 'una bola' : '$_n bolas'} entre los ${widget.temas.length} temas que lleva el alumno y no ${_n == 1 ? 'la verás tampoco tú' : 'las verás tampoco tú'} hasta la hora en que le ${_n == 1 ? 'llegue' : 'lleguen'}.', style: context.textos.bodySmall),
              if (conPartes)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text('Una de cada parte'),
                  subtitle: Text('Como en el examen: cada tema de una parte distinta (${(_partes.toList()..sort()).join(', ')}).', style: context.textos.labelSmall),
                  value: _unoPorParte,
                  onChanged: (v) => setState(() => _unoPorParte = v),
                ),
            ] else ...[
              Text(_n == 1 ? 'Elige el tema.' : 'Elige $_n temas (${_temas.length} elegidos).', style: context.textos.labelSmall),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: ListView(shrinkWrap: true, children: [
                  for (final t in widget.temas)
                    CheckboxListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _temas.contains(t.codigo),
                      onChanged: (v) => setState(() {
                        if (v == true) {
                          if (_n == 1) _temas.clear();
                          if (_temas.length < _n) _temas.add(t.codigo);
                        } else {
                          _temas.remove(t.codigo);
                        }
                      }),
                      title: TextoTema(t.codigo, t.titulo, color: estructura?.colorDe(t.codigo)),
                    ),
                ]),
              ),
            ],
            const TituloSeccion('¿Cuándo le llegan?'),
            Wrap(spacing: 6, runSpacing: 6, children: [
              for (final h in {...antelacionesTema, _antelacionDelExamen(_n), if (_antelacion != null) _antelacion!}.toList()..sort())
                if (s.fecha.subtract(Duration(seconds: h)).isAfter(ahora))
                  ChoiceChip(
                    label: Text('${textoAntelacion(h)} antes${h == _antelacionDelExamen(_n) ? ' (esquema del examen)' : ''}'),
                    selected: _antelacion == h,
                    onSelected: (_) => setState(() {
                      _antelacion = h;
                      _antelacionAutomatica = h == _antelacionDelExamen(_n);
                    }),
                  ),
              ActionChip(
                label: const Text('Otra'),
                onPressed: () async {
                  final h = await pedirAntelacion(context, actual: _antelacion);
                  if (h != null) {
                    setState(() {
                      _antelacion = h;
                      _antelacionAutomatica = false;
                    });
                  }
                },
              ),
              ChoiceChip(
                avatar: const Icon(Icons.edit_calendar_outlined, size: 18),
                label: Text(_hora == null || _antelacion != null ? 'A una hora concreta' : DateFormat('EEE d, HH:mm', 'es').format(_hora!)),
                selected: _antelacion == null && _hora != null,
                onSelected: (_) => _elegirHora(),
              ),
            ]),
            const SizedBox(height: 8),
            Text(
              cuando == null
                  ? 'Elige cuándo.'
                  : valida
                      ? 'Le ${_n == 1 ? 'llegará' : 'llegarán'} ${cuandoTema(cuando)} (la clase es ${fechaCorta(s.fecha)} a las ${horaDe(s.fecha)}).'
                      : 'Tiene que ser antes de la clase y a partir de ahora.',
              style: context.textos.labelSmall?.copyWith(color: valida || cuando == null ? null : context.esquema.error),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: !listo
                  ? null
                  : () {
                      final temas = _sortear
                          ? Sorteo.sortearClase(widget.temas, _n, unoPorParte: _unoPorParte, parte: parteDeTema).map((t) => t.codigo).toList()
                          : _temas.toList();
                      Navigator.pop(context, s.copyWith(temaA: cuando, temasMandados: temas, temaSorteado: _sortear, numTemas: _n, unoPorParte: _unoPorParte));
                    },
              icon: const Icon(Icons.schedule_send_outlined),
              label: Text(_sortear ? 'Sacar ${_n == 1 ? 'bola' : 'bolas'} y programar' : 'Programar el envío'),
            ),
          ]),
        ),
      ),
    );
  }
}
