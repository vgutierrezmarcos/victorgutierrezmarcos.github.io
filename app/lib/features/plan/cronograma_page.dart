import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'planificador.dart';

/// Cronograma de temas por semanas (hoja "Cronograma" del Excel), con reparto
/// automático hasta la fecha del examen y seguimiento de lo previsto frente a lo hecho.
class CronogramaPage extends ConsumerWidget {
  const CronogramaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temario = ref.watch(temarioProvider);
    final crono = ref.watch(planProvider.select((p) => p.cronograma));
    return temario.when(
      loading: () => Scaffold(appBar: AppBar(title: const Text('Cronograma')), body: const Cargando()),
      error: (e, _) => Scaffold(appBar: AppBar(title: const Text('Cronograma')), body: ErrorVista(error: e, reintentar: () => ref.invalidate(temarioProvider))),
      data: (t) => crono.vacio ? _Generador(temario: t) : _Vista(temario: t, crono: crono),
    );
  }
}

// ------------------------------------------------------------------ Generador

enum _Fuente { pendientes, todos, lista }

class _Generador extends ConsumerStatefulWidget {
  const _Generador({required this.temario});
  final Temario temario;
  @override
  ConsumerState<_Generador> createState() => _GeneradorState();
}

class _GeneradorState extends ConsumerState<_Generador> {
  _Fuente _fuente = _Fuente.pendientes;
  Set<int> _ejercicios = {3, 4};
  List<String> _lista = const [];
  bool _alternar = true;
  bool _porFecha = true;
  DateTime _inicio = DateTime.now();
  DateTime? _fin;
  int _porSemana = 3;
  int _vueltas = 1;

  @override
  void initState() {
    super.initState();
    final fechas = ref.read(fechasEjerciciosProvider);
    _fin = fechas[3] ?? fechas[1];
    _porFecha = _fin != null && _fin!.isAfter(DateTime.now());
  }

  List<String> _temas() {
    final estudiados = ref.read(ajustesProvider).temasEstudiados;
    final base = switch (_fuente) {
      _Fuente.lista => _lista,
      _Fuente.todos => [for (final t in widget.temario.todosLosTemas) if (_ejercicios.contains(t.ejercicio)) t.codigo],
      _Fuente.pendientes => [for (final t in widget.temario.todosLosTemas) if (_ejercicios.contains(t.ejercicio) && !estudiados.contains(t.codigo)) t.codigo],
    };
    return _alternar ? Planificador.alternarPartes(base) : base;
  }

  Future<void> _fecha({required bool fin}) async {
    final f = await showDatePicker(
      context: context,
      initialDate: fin ? (_fin ?? _inicio.add(const Duration(days: 180))) : _inicio,
      firstDate: fin ? _inicio : DateTime(_inicio.year - 1),
      lastDate: DateTime(DateTime.now().year + 6),
      helpText: fin ? 'Tener todo visto para el' : 'Empezar la semana del',
    );
    if (f != null) setState(() => fin ? _fin = f : _inicio = f);
  }

  @override
  Widget build(BuildContext context) {
    final temas = _temas();
    final listo = temas.isNotEmpty && (!_porFecha || (_fin != null && _fin!.isAfter(_inicio)));
    final previa = !listo ? null : Planificador.repartir(temas: temas, inicio: _inicio, fin: _porFecha ? _fin : null, temasPorSemana: _porFecha ? null : _porSemana, vueltas: _vueltas);
    final formato = DateFormat('d MMM y', 'es');

    return Scaffold(
      appBar: AppBar(title: const Text('Cronograma')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        children: [
          Text('Reparte los temas por semanas y sigue si vas al día. Después podrás mover temas de semana, fijarles día y añadir comentarios.', style: context.textos.bodySmall),
          const TituloSeccion('Qué temas'),
          Wrap(spacing: 6, children: [
            for (final (f, texto) in [(_Fuente.pendientes, 'Los que me faltan'), (_Fuente.todos, 'Todos'), (_Fuente.lista, 'Elegir')])
              ChoiceChip(label: Text(texto), selected: _fuente == f, onSelected: (_) => setState(() => _fuente = f)),
          ]),
          const SizedBox(height: 8),
          if (_fuente == _Fuente.lista)
            OutlinedButton.icon(
              onPressed: () async {
                final r = await elegirTemas(context, temario: widget.temario, seleccion: _lista, ejercicios: {3, 4, 5});
                if (r != null) setState(() => _lista = r);
              },
              icon: const Icon(Icons.checklist, size: 18),
              label: Text(_lista.isEmpty ? 'Elegir temas' : '${_lista.length} temas elegidos'),
            )
          else
            Wrap(spacing: 6, children: [
              for (final ej in [3, 4, 5])
                FilterChip(
                  label: Text('$ej.º ejercicio'),
                  selected: _ejercicios.contains(ej),
                  onSelected: (v) => setState(() => _ejercicios = v ? {..._ejercicios, ej} : ({..._ejercicios}..remove(ej))),
                ),
            ]),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Alternar partes'),
            subtitle: Text('Un tema de cada parte por turnos, en vez de una parte entera de seguido', style: context.textos.labelSmall),
            value: _alternar,
            onChanged: (v) => setState(() => _alternar = v),
          ),
          const TituloSeccion('Ritmo'),
          SegmentedButton<bool>(
            segments: const [ButtonSegment(value: true, label: Text('Hasta una fecha')), ButtonSegment(value: false, label: Text('Temas por semana'))],
            selected: {_porFecha},
            onSelectionChanged: (s) => setState(() => _porFecha = s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => _fecha(fin: false), child: Text('Desde ${formato.format(Planificador.lunes(_inicio))}'))),
            if (_porFecha) ...[
              const SizedBox(width: 10),
              Expanded(child: OutlinedButton(onPressed: () => _fecha(fin: true), child: Text(_fin == null ? 'Hasta…' : 'Hasta ${formato.format(_fin!)}'))),
            ],
          ]),
          if (!_porFecha)
            Row(children: [
              Text('Temas por semana:', style: context.textos.labelMedium),
              Expanded(child: Slider(value: _porSemana.toDouble(), min: 1, max: 10, divisions: 9, label: '$_porSemana', onChanged: (v) => setState(() => _porSemana = v.round()))),
              Text('$_porSemana', style: context.textos.titleSmall),
            ]),
          Row(children: [
            Text('Vueltas:', style: context.textos.labelMedium),
            const SizedBox(width: 10),
            for (final v in [1, 2, 3]) Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(label: Text('$v'), selected: _vueltas == v, onSelected: (_) => setState(() => _vueltas = v))),
          ]),
          if (_vueltas > 1) Text('Cada vuelta va el doble de rápido que la anterior.', style: context.textos.labelSmall),
          const SizedBox(height: 16),
          Tarjeta(
            color: context.colores.primarioPalido,
            child: Text(
              temas.isEmpty
                  ? 'No hay temas que repartir con esta selección.'
                  : previa == null
                      ? 'Elige hasta qué fecha quieres tener los temas vistos.'
                      : '${temas.length} temas en ${previa.semanas} semanas: ${(temas.length * _vueltas / previa.semanas).toStringAsFixed(1).replaceAll('.', ',')} temas por semana de media. Terminarías el ${formato.format(previa.inicioSemana(previa.semanas + 1)!.subtract(const Duration(days: 1)))}.',
              style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: previa == null ? null : () => ref.read(planProvider.notifier).actualizar((p) => p.copyWith(cronograma: previa)),
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('Crear cronograma'),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------- Vista

class _Vista extends ConsumerWidget {
  const _Vista({required this.temario, required this.crono});
  final Temario temario;
  final Cronograma crono;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoy = DateTime.now();
    final actual = crono.semanaDe(hoy);
    final desfase = crono.desfase(hoy);
    final total = crono.entradas.length;
    final formato = DateFormat('d MMM', 'es');
    final notifier = ref.read(planProvider.notifier);

    Future<void> cambiar(List<EntradaCronograma> Function(List<EntradaCronograma>) f) =>
        notifier.actualizar((p) => p.copyWith(cronograma: Cronograma(inicio: p.cronograma.inicio, entradas: f([...p.cronograma.entradas]))));

    Future<void> editar(EntradaCronograma e) async {
      final i = crono.entradas.indexOf(e);
      final accion = await showModalBottomSheet<String>(
        context: context,
        builder: (c) => SafeArea(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(title: Text('${e.codigo} · ${temario.tema(e.codigo)?.titulo ?? ''}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall)),
            if (e.semana > 1) ListTile(leading: const Icon(Icons.arrow_upward), title: const Text('Pasar a la semana anterior'), onTap: () => Navigator.pop(c, 'antes')),
            ListTile(leading: const Icon(Icons.arrow_downward), title: const Text('Pasar a la semana siguiente'), onTap: () => Navigator.pop(c, 'despues')),
            ListTile(leading: const Icon(Icons.today_outlined), title: Text(e.dia == null ? 'Fijar día de la semana' : 'Cambiar día (${Horario.nombresDias[e.dia! - 1]})'), onTap: () => Navigator.pop(c, 'dia')),
            ListTile(leading: const Icon(Icons.comment_outlined), title: Text(e.comentario.isEmpty ? 'Añadir comentario' : 'Editar comentario'), onTap: () => Navigator.pop(c, 'comentario')),
            ListTile(leading: const Icon(Icons.delete_outline), title: const Text('Quitar del cronograma'), onTap: () => Navigator.pop(c, 'quitar')),
          ]),
        ),
      );
      if (accion == null || !context.mounted) return;
      switch (accion) {
        case 'antes':
          await cambiar((l) => l..[i] = e.copyWith(semana: e.semana - 1));
        case 'despues':
          await cambiar((l) => l..[i] = e.copyWith(semana: e.semana + 1));
        case 'quitar':
          await cambiar((l) => l..removeAt(i));
        case 'dia':
          final d = await showDialog<int>(
            context: context,
            builder: (c) => SimpleDialog(title: const Text('Día de la semana'), children: [
              SimpleDialogOption(onPressed: () => Navigator.pop(c, 0), child: const Text('Sin día fijo')),
              for (var n = 1; n <= 7; n++) SimpleDialogOption(onPressed: () => Navigator.pop(c, n), child: Text(Horario.nombresDias[n - 1])),
            ]),
          );
          if (d != null) await cambiar((l) => l..[i] = d == 0 ? e.copyWith(sinDia: true) : e.copyWith(dia: d));
        case 'comentario':
          final ctrl = TextEditingController(text: e.comentario);
          final texto = await showDialog<String>(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Comentario · ${e.codigo}'),
              content: TextField(controller: ctrl, autofocus: true, maxLines: 3, textCapitalization: TextCapitalization.sentences),
              actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')), FilledButton(onPressed: () => Navigator.pop(c, ctrl.text.trim()), child: const Text('Guardar'))],
            ),
          );
          if (texto != null) await cambiar((l) => l..[i] = e.copyWith(comentario: texto));
      }
    }

    Future<void> alternarHecho(EntradaCronograma e) async {
      final i = crono.entradas.indexOf(e);
      await cambiar((l) => l..[i] = e.copyWith(hecho: !e.hecho));
      // Dar un tema por hecho lo marca también como estudiado (cuenta para las probabilidades).
      if (!e.hecho && !ref.read(ajustesProvider).temasEstudiados.contains(e.codigo)) await ref.read(ajustesProvider.notifier).alternarEstudiado(e.codigo);
    }

    Future<void> anadir(int semana) async {
      final r = await elegirTemas(context, temario: temario, ejercicios: {3, 4, 5}, titulo: 'Añadir a la semana $semana');
      if (r == null || r.isEmpty) return;
      await cambiar((l) => l..addAll([for (final c in r) EntradaCronograma(codigo: c, semana: semana)]));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronograma'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text('¿Rehacer el cronograma?'),
                  content: const Text('Se borrará el cronograma actual, con sus comentarios y lo marcado como hecho, para crear uno nuevo.'),
                  actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancelar')), FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Rehacer'))],
                ),
              );
              if (ok == true) await notifier.actualizar((p) => p.copyWith(cronograma: const Cronograma()));
            },
            itemBuilder: (_) => const [PopupMenuItem(value: 'rehacer', child: Text('Rehacer cronograma'))],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        children: [
          Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('${crono.hechos} de $total temas', style: context.textos.titleMedium)),
                Text(
                  actual < 1 ? 'Empieza el ${formato.format(crono.inicio!)}' : (desfase == 0 ? 'Vas al día' : (desfase > 0 ? '$desfase de adelanto' : '${-desfase} de retraso')),
                  style: context.textos.titleSmall?.copyWith(color: desfase < 0 ? Paleta.fallo : Paleta.acierto),
                ),
              ]),
              const SizedBox(height: 8),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: total == 0 ? 0 : crono.hechos / total, minHeight: 8, backgroundColor: context.colores.fondoClaro)),
              const SizedBox(height: 6),
              Text(actual > crono.semanas ? 'Cronograma terminado.' : 'Semana ${actual.clamp(1, crono.semanas)} de ${crono.semanas}.', style: context.textos.labelSmall),
            ]),
          ),
          const SizedBox(height: 10),
          for (var s = 1; s <= crono.semanas; s++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Tarjeta(
                padding: EdgeInsets.zero,
                color: s == actual ? context.colores.primarioPalido : null,
                child: Builder(builder: (context) {
                  final entradas = crono.deSemana(s);
                  final hechos = entradas.where((e) => e.hecho).length;
                  return ExpansionTile(
                    key: PageStorageKey('semana$s'),
                    initiallyExpanded: s == actual || (actual < 1 && s == 1),
                    title: Text('Semana $s${s == actual ? ' · esta semana' : ''}', style: context.textos.titleSmall),
                    subtitle: Text('${formato.format(crono.inicioSemana(s)!)} – ${formato.format(crono.inicioSemana(s)!.add(const Duration(days: 6)))} · $hechos de ${entradas.length}', style: context.textos.labelSmall),
                    children: [
                      for (final e in entradas)
                        ListTile(
                          dense: true,
                          leading: IconButton(
                            icon: Icon(e.hecho ? Icons.check_circle : Icons.circle_outlined, color: e.hecho ? Paleta.acierto : context.colores.textoClaro),
                            tooltip: 'Hecho',
                            onPressed: () => alternarHecho(e),
                          ),
                          title: Text('${e.codigo} · ${temario.tema(e.codigo)?.titulo ?? ''}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                          subtitle: e.dia == null && e.comentario.isEmpty && e.vuelta == 1
                              ? null
                              : Text([if (e.vuelta > 1) '${e.vuelta}.ª vuelta', if (e.dia != null) Horario.nombresDias[e.dia! - 1], if (e.comentario.isNotEmpty) e.comentario].join(' · '), style: context.textos.labelSmall),
                          trailing: IconButton(icon: const Icon(Icons.more_vert, size: 18), tooltip: 'Opciones', onPressed: () => editar(e)),
                        ),
                      TextButton.icon(onPressed: () => anadir(s), icon: const Icon(Icons.add, size: 18), label: const Text('Añadir tema')),
                    ],
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
