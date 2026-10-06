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

/// Antelaciones que se ofrecen para mandar el tema (en horas antes de la clase).
const antelacionesTema = [1, 2, 4, 24, 48];

String textoAntelacion(int horas) => horas % 24 == 0 ? (horas == 24 ? '1 día antes' : '${horas ~/ 24} días antes') : (horas == 1 ? '1 hora antes' : '$horas horas antes');

/// «el martes 14 a las 18:00».
String cuandoTema(DateTime d) => DateFormat("EEEE d 'a las' HH:mm", 'es').format(d);

/// Ficha de la clase (preparador): mandar al alumno un tema antes de la clase
/// para que haga el esquema y lo practique. Elegido o sacado a suerte entre
/// los de la clase; a una hora fija o con cierta antelación.
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
    final ahora = DateTime.now();

    Future<void> elegir() async {
      final r = await showModalBottomSheet<Cante>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => _HojaTemaAnticipado(sesion: s, temas: temas),
      );
      if (r != null) await notifier.guardar(r);
    }

    if (!enlazado) {
      return Text('Cuando el alumno enlace su app, podrás mandarle un tema antes de la clase para que haga el esquema.', style: context.textos.labelSmall);
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
              Text('Mandarle un tema antes', style: context.textos.titleSmall),
              Text(
                temas.isEmpty ? 'Primero elige los temas que entran en la clase.' : 'Le llega como un mensaje tuyo, a la hora que elijas, para que haga el esquema.',
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
    final tema = temario?.tema(s.temaMandado!);
    return Tarjeta(
      color: context.colores.primarioPalido,
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.only(top: 2), child: Icon(llegado ? Icons.mark_email_read_outlined : Icons.schedule_send_outlined, color: context.esquema.primary)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(llegado ? 'Tema enviado ${cuandoTema(s.temaA!)}' : 'Se le manda ${cuandoTema(s.temaA!)}', style: context.textos.titleSmall),
            const SizedBox(height: 2),
            if (oculto)
              Text('Bola sorteada: ni tú la verás hasta esa hora.', style: context.textos.bodySmall)
            else
              Text('${s.temaMandado} · ${tema?.titulo ?? ''}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
            if (!llegado) Text('Hasta entonces el alumno solo sabe a qué hora le llegará.', style: context.textos.labelSmall),
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
              PopupMenuItem(value: 'cambiar', child: Text('Cambiar tema u hora')),
              PopupMenuItem(value: 'quitar', child: Text('No mandarlo')),
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
  late String? _tema = widget.sesion.mandaTema && !widget.sesion.temaSorteado ? widget.sesion.temaMandado : null;
  // Antelación en horas, o null si es a una hora concreta (_hora).
  int? _antelacion;
  DateTime? _hora;

  @override
  void initState() {
    super.initState();
    final s = widget.sesion;
    if (s.mandaTema) {
      final horas = s.fecha.difference(s.temaA!).inMinutes / 60;
      _antelacion = antelacionesTema.where((h) => h == horas).firstOrNull;
      if (_antelacion == null) _hora = s.temaA;
    } else {
      _antelacion = ref.read(perfilPreparadorProvider).horasTemaAntes;
    }
  }

  DateTime? get _cuando => _antelacion != null ? widget.sesion.fecha.subtract(Duration(hours: _antelacion!)) : _hora;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.sesion;
    final cuando = _cuando;
    final ahora = DateTime.now();
    final valida = cuando != null && cuando.isAfter(ahora) && cuando.isBefore(s.fecha);
    final listo = valida && (_sortear || _tema != null);
    final estructura = ref.watch(estructuraProvider).valueOrNull;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Mandar un tema antes de la clase', style: context.textos.titleLarge),
            const SizedBox(height: 4),
            Text('Le llega como un mensaje tuyo con el número y el título del tema, para que haga el esquema y lo practique. Antes de esa hora no puede verlo.', style: context.textos.bodySmall),
            const SizedBox(height: 14),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: false, icon: Icon(Icons.checklist, size: 18), label: Text('Elegir tema')),
                ButtonSegment(value: true, icon: Icon(Icons.casino_outlined, size: 18), label: Text('Sacar bola')),
              ],
              selected: {_sortear},
              onSelectionChanged: (v) => setState(() => _sortear = v.first),
            ),
            const SizedBox(height: 8),
            if (_sortear)
              Text('La app saca una bola entre los ${widget.temas.length} temas de la clase y no la verás tampoco tú hasta la hora en que le llegue.', style: context.textos.bodySmall)
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 260),
                child: RadioGroup<String>(
                  groupValue: _tema,
                  onChanged: (v) => setState(() => _tema = v),
                  child: ListView(shrinkWrap: true, children: [
                    for (final t in widget.temas)
                      RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: t.codigo,
                        title: TextoTema(t.codigo, t.titulo, color: estructura?.colorDe(t.codigo)),
                      ),
                  ]),
                ),
              ),
            const TituloSeccion('¿Cuándo le llega?'),
            Wrap(spacing: 6, runSpacing: 6, children: [
              for (final h in antelacionesTema)
                if (s.fecha.subtract(Duration(hours: h)).isAfter(ahora))
                  ChoiceChip(label: Text(textoAntelacion(h)), selected: _antelacion == h, onSelected: (_) => setState(() => _antelacion = h)),
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
                      ? 'Le llegará ${cuandoTema(cuando)} (la clase es ${fechaCorta(s.fecha)} a las ${horaDe(s.fecha)}).'
                      : 'Tiene que ser antes de la clase y a partir de ahora.',
              style: context.textos.labelSmall?.copyWith(color: valida || cuando == null ? null : context.esquema.error),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: !listo
                  ? null
                  : () {
                      final tema = _sortear ? Sorteo.sortear(widget.temas, 1).first.codigo : _tema!;
                      Navigator.pop(context, s.copyWith(temaA: cuando, temaMandado: tema, temaSorteado: _sortear));
                    },
              icon: const Icon(Icons.schedule_send_outlined),
              label: Text(_sortear ? 'Sacar bola y programar' : 'Programar el envío'),
            ),
          ]),
        ),
      ),
    );
  }
}
