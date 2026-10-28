import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/fases.dart';
import '../../data/models/frecuencia_test.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';
import 'cronograma_widgets.dart';
import 'fases.dart';
import 'planificador.dart';

/// Crear un cronograma: qué ejercicio, qué temas, a qué ritmo o
/// hasta cuándo, si se intercalan Mixto (3.º) o las dos partes (4.º), y la
/// vista previa de las primeras semanas. En un ejercicio escrito por fases
/// (1.º de DCE), en lugar del ritmo, la fecha del examen y las fases hasta
/// él (primera vuelta, simulacros y revisión), que se pueden mover o saltar.
///
/// Con [para], es el preparador quien lo hace para ese alumno y se lo manda:
/// el alumno lo acepta o lo rechaza en su app.
class CronogramaFormPage extends ConsumerStatefulWidget {
  const CronogramaFormPage({super.key, this.para});
  final Alumno? para;
  @override
  ConsumerState<CronogramaFormPage> createState() => _CronogramaFormPageState();
}

class _CronogramaFormPageState extends ConsumerState<CronogramaFormPage> {
  int _ejercicio = Oposiciones.actual.conCronograma.first.numero;
  bool _todos = true;
  List<String> _elegidos = const [];
  bool _porFecha = false;
  int _porSemana = 3;
  DateTime _fin = DateTime.now().add(const Duration(days: 120));
  bool _estaSemana = true;
  /// Día de la semana en que canta (null = semanas de lunes a domingo). Por
  /// defecto, el de su próximo cante programado.
  late int? _diaCante = (widget.para == null
          ? ref.read(cantesProvider).where((c) => !c.borrado && !c.hecho && c.fecha.isAfter(DateTime.now()))
          : ref.read(sesionesProvider).where((s) => s.alumno == widget.para!.id && !s.borrado && s.pendiente && s.fecha.isAfter(DateTime.now())))
      .firstOrNull
      ?.fecha
      .weekday;
  final _nota = TextEditingController();

  @override
  void dispose() {
    _nota.dispose();
    super.dispose();
  }
  /// Primer cante de la vuelta (con día de cante).
  DateTime? _primerCante;

  /// El próximo [dia] de la semana a partir de mañana.
  static DateTime _proximo(int dia) {
    final hoy = DateTime.now();
    final d = (dia - hoy.weekday + 7) % 7;
    return DateTime(hoy.year, hoy.month, hoy.day + (d == 0 ? 7 : d));
  }
  bool _intercalar = true;
  int? _cadaN;
  bool _compartir = false;
  /// Primero los temas que más caen en el test del primer ejercicio (solo 3.º de TCEE).
  bool _porTest = false;

  /// Cronograma por fases: fecha del examen, fases que se salta y las que
  /// empiezan otro día que el propuesto.
  DateTime _examen = DateTime.now().add(const Duration(days: 182));
  /// En un ejercicio con fases, planificarlo por fases hasta el examen o,
  /// como en TCEE, una vuelta suelta con su ritmo y su orden.
  bool _porFases = true;
  final _saltadas = <TipoFase>{};
  final _inicios = <TipoFase, DateTime>{};

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final vinculos = ref.watch(misPreparadoresProvider);
    final para = widget.para;
    final titulo = para == null ? 'Nuevo cronograma' : 'Cronograma para ${para.nombre}';
    if (temario == null || estructura == null) return Scaffold(appBar: BarraWeb(title: Text(titulo)), body: const Cargando());

    final delEjercicio = {for (final t in temario.todosLosTemas.where((t) => t.ejercicio == _ejercicio)) t.codigo};
    final temas = _todos ? delEjercicio : _elegidos.where(delEjercicio.contains).toSet();
    final frecuencia = _ejercicio == 3 ? ref.watch(frecuenciaTestProvider).valueOrNull : null;
    final tieneFases = Oposiciones.actual.ejercicio(_ejercicio)?.fases != null;
    final cfgFases = _porFases ? Oposiciones.actual.fasesEscrito(_ejercicio, ref.watch(configProvider).valueOrNull ?? AppConfig.porDefecto) : null;
    final base = ordenInicial(estructura, _ejercicio, temas, intercalar: _intercalar && !_porTest, cadaN: _cadaN);
    final orden = _porTest && frecuencia != null ? primeroLoQueMasCae(base, frecuencia.frecuencias(PesoRecientes.mas)) : base;
    final dia = cfgFases == null ? _diaCante : null;
    final primerCante = dia == null ? null : (_primerCante != null && _primerCante!.weekday == dia ? _primerCante! : _proximo(dia));
    final inicio = primerCante ?? lunesDe(_estaSemana ? DateTime.now() : DateTime.now().add(const Duration(days: 7)));
    // Por fases: la primera vuelta, la parte A y luego la B, hasta el final de su fase.
    final vueltaSaltada = _saltadas.contains(TipoFase.vuelta);
    final reparto = cfgFases == null ? null : repartoFases(desde: inicio, examen: _examen, cfg: cfgFases, temas: vueltaSaltada ? 0 : temas.length, saltadas: _saltadas, inicios: _inicios);
    final finVuelta = reparto?.fase(TipoFase.vuelta)?.fin;
    final c = reparto == null
        ? crearCronograma(id: nuevoId(), ejercicio: _ejercicio, temas: orden, inicio: inicio, porSemana: _porSemana, fin: _porFecha ? _fin : null, intercalar: _intercalar && !_porTest, cadaN: _cadaN, compartir: _compartir, diaCante: dia)
        : crearCronograma(
            id: nuevoId(),
            ejercicio: _ejercicio,
            temas: vueltaSaltada ? const [] : ordenPorPartes(temas),
            inicio: inicio,
            fin: finVuelta,
            intercalar: false,
            compartir: _compartir,
            fases: reparto.fases,
            examen: DateTime(_examen.year, _examen.month, _examen.day),
          );
    final sePuede = reparto == null ? temas.isNotEmpty : reparto.semanas > 0 && reparto.fases.any((f) => !f.saltada) && (vueltaSaltada || temas.isNotEmpty);
    final estado = estadoDe(c, DateTime.now());
    final auto = unoDeCada(estructura, _ejercicio, orden);

    Future<void> enviar() async {
      final nav = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);
      try {
        await ref.read(preparadorRepoProvider).enviarCronograma(para!, c, nota: _nota.text.trim());
        messenger.mostrar(SnackBar(content: Text('Enviado. A ${para.nombre} le llega un aviso; cuando lo acepte, lo verás en su ficha.')));
        nav.pop();
      } catch (_) {
        messenger.mostrar(const SnackBar(content: Text('No se pudo enviar. Revisa la conexión.')));
      }
    }

    Future<void> crear() async {
      final nav = Navigator.of(context);
      if (ref.read(cronogramaProvider) != null) {
        final ok = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text('Ya tienes un cronograma'),
            content: const Text('Solo hay uno activo: el que tienes ahora se archivará y podrás seguir viéndolo más abajo en la pantalla del cronograma.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Empezar el nuevo')),
            ],
          ),
        );
        if (ok != true) return;
      }
      try {
        await ref.read(cronogramaProvider.notifier).empezar(c);
        nav.pop();
      } catch (e) {
        if (context.mounted) ScaffoldMessenger.of(context).mostrar(SnackBar(content: Text('No se pudo crear: $e')));
      }
    }

    return Scaffold(
      appBar: BarraWeb(title: Text(titulo)),
      body: ListaAdaptable(children: [
        const TituloSeccion('Qué vuelta'),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: [for (final e in Oposiciones.actual.conCronograma) ButtonSegment(value: e.numero, label: Text(e.abreviado))],
          selected: {_ejercicio},
          onSelectionChanged: (s) => setState(() {
            _ejercicio = s.first;
            _elegidos = const [];
            _cadaN = null;
            _saltadas.clear();
            _inicios.clear();
          }),
        ),
        if (tieneFases) ...[
          const SizedBox(height: 10),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [ButtonSegment(value: true, label: Text('Por fases hasta el examen')), ButtonSegment(value: false, label: Text('Una vuelta'))],
            selected: {_porFases},
            onSelectionChanged: (s) => setState(() => _porFases = s.first),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
            child: Text(
              _porFases
                  ? 'Primera vuelta, simulacros y revisión de temas flojos, repartidos hasta la fecha del examen.'
                  : 'Una vuelta a los temas que elijas, con tu ritmo o hasta una fecha, en el orden de los bloques de la organización del temario.',
              style: context.textos.labelSmall,
            ),
          ),
        ],
        const SizedBox(height: 10),
        Tarjeta(
          padding: EdgeInsets.zero,
          child: RadioGroup<bool>(
            groupValue: _todos,
            onChanged: (v) => setState(() => _todos = v ?? true),
            child: Column(children: [
              RadioListTile<bool>(value: true, title: Text('Todos los temas (${delEjercicio.length})')),
              RadioListTile<bool>(
                value: false,
                title: Text(_elegidos.isEmpty ? 'Solo los que elija' : 'Solo los que elija (${temas.length})'),
                secondary: TextButton(
                  onPressed: () async {
                    final r = await elegirTemas(context, temario: temario, seleccion: _elegidos.isEmpty ? delEjercicio : _elegidos, ejercicios: {_ejercicio}, titulo: 'Temas de la vuelta');
                    if (r != null) {
                      setState(() {
                        _elegidos = r;
                        _todos = false;
                      });
                    }
                  },
                  child: const Text('Elegir'),
                ),
              ),
            ]),
          ),
        ),
        if (reparto != null) ..._fases(reparto, temas.length) else ...[
          const TituloSeccion('Ritmo'),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [ButtonSegment(value: false, label: Text('Temas por semana')), ButtonSegment(value: true, label: Text('Fecha de fin'))],
            selected: {_porFecha},
            onSelectionChanged: (s) => setState(() => _porFecha = s.first),
          ),
          const SizedBox(height: 10),
          Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (!_porFecha)
                SelectorNumero(valor: _porSemana, onChanged: (v) => setState(() => _porSemana = v))
              else
                OutlinedButton.icon(
                  icon: const Icon(Icons.event, size: 18),
                  label: Text('Acabar el ${fechaLargaCrono(_fin)}'),
                  onPressed: () async {
                    final x = await showDatePicker(context: context, initialDate: _fin, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 730)));
                    if (x != null) setState(() => _fin = x);
                  },
                ),
              const SizedBox(height: 8),
              Text(
                temas.isEmpty
                    ? 'Elige al menos un tema.'
                    : (_porFecha ? 'Unos ${c.temasPorSemana} temas por semana; acabas el ${fechaLargaCrono(estado.fin!)}.' : 'Acabas el ${fechaLargaCrono(estado.fin!)} (${c.semanas.length} semanas).'),
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 12),
              Text('Día en que cantas', style: context.textos.labelMedium),
              const SizedBox(height: 4),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (var d = 1; d <= 7; d++)
                  ChoiceChip(
                    label: Text(const ['L', 'M', 'X', 'J', 'V', 'S', 'D'][d - 1]),
                    tooltip: nombreDiaSemana(d),
                    selected: dia == d,
                    onSelected: (_) => setState(() {
                      _diaCante = d;
                      _primerCante = null;
                    }),
                  ),
                ChoiceChip(label: const Text('Sin día fijo'), selected: dia == null, onSelected: (_) => setState(() => _diaCante = null)),
              ]),
              const SizedBox(height: 8),
              if (primerCante != null) ...[
                OutlinedButton.icon(
                  icon: const Icon(Icons.event, size: 18),
                  label: Text('Primer cante: ${diaSemanaYMes(primerCante)}'),
                  onPressed: () async {
                    final x = await showDatePicker(
                      context: context,
                      initialDate: primerCante,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      selectableDayPredicate: (f) => f.weekday == dia,
                      helpText: 'Primer cante de la vuelta',
                    );
                    if (x != null) setState(() => _primerCante = x);
                  },
                ),
                const SizedBox(height: 4),
                Text('Cada semana del cronograma acaba en un cante: los temas de cada semana son los que llevas a ese cante, empezando por el del ${diaSemanaYMes(primerCante)}.', style: context.textos.labelSmall),
              ] else
                SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const [ButtonSegment(value: true, label: Text('Empiezo esta semana')), ButtonSegment(value: false, label: Text('La semana que viene'))],
                  selected: {_estaSemana},
                  onSelectionChanged: (s) => setState(() => _estaSemana = s.first),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
            ]),
          ),
          const TituloSeccion('Orden'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              SwitchListTile(
                value: _intercalar,
                onChanged: _porTest ? null : (v) => setState(() => _intercalar = v),
                title: Text(Oposiciones.actual.ejercicio(_ejercicio)?.intercalar?.$1 ?? 'Intercalar las partes'),
                subtitle: Text(
                  Oposiciones.actual.ejercicio(_ejercicio)?.intercalar?.$2 ?? 'Alternadas para no pasar semanas seguidas con una sola parte.',
                  style: context.textos.labelSmall,
                ),
              ),
              if (frecuencia != null)
                SwitchListTile(
                  value: _porTest,
                  onChanged: (v) => setState(() => _porTest = v),
                  title: const Text('Primero lo que más cae en el test'),
                  subtitle: Text('Los temas con más preguntas en los exámenes oficiales del test van al principio (sin intercalar). Útil si el test del primer ejercicio es lo próximo.', style: context.textos.labelSmall),
                ),
              if (_intercalar && auto != null && !_porTest)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: DropdownButtonFormField<int?>(
                    initialValue: _cadaN,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Proporción'),
                    items: [
                      DropdownMenuItem(value: null, child: Text('Proporcional (≈1 de cada $auto)')),
                      for (final n in [2, 3, 4, 5, 6]) DropdownMenuItem(value: n, child: Text('1 de cada $n')),
                    ],
                    onChanged: (v) => setState(() => _cadaN = v),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('El orden sale de los bloques y las conexiones de la organización del temario. Podrás cambiarlo después.', style: context.textos.labelSmall),
              ),
            ]),
          ),
        ],
        if (para != null) ...[
          const TituloSeccion('Nota para el alumno'),
          TextField(controller: _nota, minLines: 2, maxLines: 4, maxLength: 1000, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Por qué este orden, qué priorizar… (opcional)')),
        ] else if (vinculos.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Tarjeta(
              padding: EdgeInsets.zero,
              child: SwitchListTile(
                value: _compartir,
                onChanged: (v) => setState(() => _compartir = v),
                title: const Text('Compartirlo con mi preparador'),
                subtitle: Text('Lo verá y podrá proponerte cambios, que tú aceptas o no.', style: context.textos.labelSmall),
              ),
            ),
          ),
        const TituloSeccion('Primeras semanas'),
        if (c.semanas.isNotEmpty) SemanasCronograma(c: c.copyWith(semanas: c.semanas.take(3).toList()), estado: estado),
        const SizedBox(height: 10),
        if (para == null)
          FilledButton.icon(onPressed: sePuede ? crear : null, icon: const Icon(Icons.event_note), label: const Text('Crear el cronograma'))
        else ...[
          FilledButton.icon(onPressed: sePuede ? enviar : null, icon: const Icon(Icons.send_outlined), label: Text('Mandárselo a ${para.nombre}')),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('Le llega un aviso y decide si lo usa. Si lo acepta, lo compartirá contigo: lo verás en su ficha y podrás proponerle cambios.', style: context.textos.labelSmall),
          ),
        ],
      ]),
    );
  }

  /// Fecha del examen y fases hasta él: cada una se puede saltar y, salvo la
  /// primera, empezar otra semana. Si no da tiempo, se avisa.
  List<Widget> _fases(RepartoFases r, int temas) {
    Future<void> elegirFecha(DateTime inicial, String ayuda, void Function(DateTime) poner) async {
      final x = await showDatePicker(context: context, initialDate: inicial, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 1100)), helpText: ayuda);
      if (x != null) setState(() => poner(x));
    }

    return [
      const TituloSeccion('Fases hasta el examen'),
      Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutlinedButton.icon(
            icon: const Icon(Icons.event, size: 18),
            label: Text('Examen: ${fechaLargaCrono(_examen)}'),
            onPressed: () => elegirFecha(_examen, 'Fecha del examen', (x) {
              _examen = x;
              _inicios.clear();
            }),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [ButtonSegment(value: true, label: Text('Empiezo esta semana')), ButtonSegment(value: false, label: Text('La semana que viene'))],
            selected: {_estaSemana},
            onSelectionChanged: (s) => setState(() => _estaSemana = s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 8),
          Text(
            '${r.semanas} semanas hasta el examen. La app propone repartirlas en tres fases; puedes cambiar cuándo empieza cada una o saltártela.',
            style: context.textos.bodySmall,
          ),
        ]),
      ),
      if (r.aviso != null) ...[
        const SizedBox(height: 10),
        Aviso(titulo: 'No da tiempo a todo', texto: r.aviso, tipo: TipoAviso.aviso, icono: Icons.warning_amber_rounded),
      ],
      const SizedBox(height: 10),
      Tarjeta(
        padding: EdgeInsets.zero,
        child: Column(children: [
          for (final f in r.fases)
            SwitchListTile(
              value: !_saltadas.contains(f.tipo),
              onChanged: (v) => setState(() {
                v ? _saltadas.remove(f.tipo) : _saltadas.add(f.tipo);
                _inicios.clear();
              }),
              title: Text(f.tipo.nombre),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  _saltadas.contains(f.tipo)
                      ? 'Te la saltas.'
                      : f.saltada
                          ? 'No le quedan semanas.'
                          : 'Del ${fechaLargaCrono(f.inicio)} al ${fechaLargaCrono(f.fin)} · ${f.semanas} ${f.semanas == 1 ? 'semana' : 'semanas'}'
                              '${f.tipo == TipoFase.vuelta && r.ritmo > 0 ? ' · ${r.ritmo} temas por semana' : ''}',
                  style: context.textos.labelSmall,
                ),
                if (!f.saltada && f.tipo != r.fases.firstWhere((x) => !x.saltada).tipo)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: const ButtonStyle(visualDensity: VisualDensity.compact, padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () => elegirFecha(f.inicio, 'Empieza ${f.tipo.nombre.toLowerCase()}', (x) => _inicios[f.tipo] = x),
                      child: const Text('Cambiar cuándo empieza'),
                    ),
                  ),
              ]),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'Primera vuelta: ${temas == 0 ? 'sin temas' : 'la parte A entera y después la B'}. Simulacros: dos temas de cada parte, eliges uno de cada par y los escribes en 3 horas. '
              'Revisión: además de los simulacros, los temas que lleves flojos.',
              style: context.textos.labelSmall,
            ),
          ),
        ]),
      ),
    ];
  }
}

/// Nombre corto del cronograma para listas.
String describirCronograma(Cronograma c) => '${nombreVuelta(c.ejercicio)} · ${c.temas.length} temas';
