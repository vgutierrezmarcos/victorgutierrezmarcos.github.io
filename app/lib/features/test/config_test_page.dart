import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/pregunta.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'motor_test.dart';

/// Fase de selección del simulador: temas, exámenes, nº de preguntas, tiempo y baremo.
class ConfigTestPage extends ConsumerStatefulWidget {
  const ConfigTestPage({super.key});
  @override
  ConsumerState<ConfigTestPage> createState() => _ConfigTestPageState();
}

class _ConfigTestPageState extends ConsumerState<ConfigTestPage> {
  ConfigTest _cfg = const ConfigTest();
  String _modo = 'temas'; // temas | examenes

  @override
  Widget build(BuildContext context) {
    final banco = ref.watch(preguntasProvider);
    final bloques = ref.watch(bloquesProvider).value ?? Bloques.vacio;
    final leitner = ref.watch(leitnerProvider);
    final pendientes = leitner.pendientes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de test'),
        actions: [
          IconButton(
            tooltip: 'Estadísticas',
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => context.go('/test/estadisticas'),
          ),
        ],
      ),
      body: banco.when(
        loading: () => const Cargando(texto: 'Cargando preguntas…'),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(preguntasProvider)),
        data: (b) {
          final disponibles = MotorTest.filtrar(b, _cfg).length;
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            children: [
              if (pendientes.isNotEmpty)
                Tarjeta(
                  color: context.colores.primarioPalido,
                  onTap: () => _repasar(pendientes),
                  child: Row(children: [
                    Icon(Icons.replay, color: context.esquema.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Repaso pendiente', style: context.textos.titleMedium),
                        Text('${pendientes.length} preguntas falladas por revisar (método Leitner)',
                            style: context.textos.bodySmall),
                      ]),
                    ),
                    const Icon(Icons.chevron_right),
                  ]),
                ),
              TituloSeccion('Selección', accion: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'temas', label: Text('Temas')),
                  ButtonSegment(value: 'examenes', label: Text('Exámenes')),
                ],
                selected: {_modo},
                onSelectionChanged: (s) => setState(() {
                  _modo = s.first;
                  _cfg = _cfg.copyWith(temas: const {}, examenes: const {});
                }),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              )),
              if (_modo == 'temas') _selectorTemas(b, bloques) else _selectorExamenes(b),
              const TituloSeccion('Configuración'),
              Tarjeta(
                child: Column(children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Solo preguntas de exámenes oficiales'),
                    value: _cfg.soloOficiales,
                    onChanged: (v) => setState(() => _cfg = _cfg.copyWith(soloOficiales: v)),
                  ),
                  _slider('Preguntas', _cfg.numPreguntas.toDouble(), 5, 100, 19,
                      (v) => _cfg = _cfg.copyWith(numPreguntas: v.round()), '${_cfg.numPreguntas}'),
                  _slider('Tiempo', _cfg.minutos.toDouble(), 0, 180, 36,
                      (v) => _cfg = _cfg.copyWith(minutos: v.round()),
                      _cfg.minutos == 0 ? 'Sin límite' : '${_cfg.minutos} min'),
                  const Divider(),
                  Row(children: [
                    Expanded(child: _numero('Acierto', _cfg.puntosAcierto, (v) => _cfg = _cfg.copyWith(puntosAcierto: v))),
                    const SizedBox(width: 8),
                    Expanded(child: _numero('Fallo', _cfg.puntosFallo, (v) => _cfg = _cfg.copyWith(puntosFallo: v))),
                    const SizedBox(width: 8),
                    Expanded(child: _numero('Blanco', _cfg.puntosBlanco, (v) => _cfg = _cfg.copyWith(puntosBlanco: v))),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: disponibles == 0 ? null : () => context.push('/examen', extra: _cfg),
                icon: const Icon(Icons.play_arrow),
                label: Text(disponibles == 0
                    ? 'No hay preguntas con esos filtros'
                    : 'Comenzar test · ${_cfg.numPreguntas.clamp(1, disponibles)} de $disponibles preguntas'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _repasar(List<int> ids) {
    context.push('/examen', extra: ConfigTest(idsFijos: ids, minutos: 0, tipo: 'repaso'));
  }

  Widget _slider(String etiqueta, double valor, double min, double max, int divisiones,
      void Function(double) onChange, String texto) {
    return Row(children: [
      SizedBox(width: 80, child: Text(etiqueta, style: context.textos.labelLarge)),
      Expanded(
        child: Slider(value: valor, min: min, max: max, divisions: divisiones, onChanged: (v) => setState(() => onChange(v))),
      ),
      SizedBox(width: 72, child: Text(texto, textAlign: TextAlign.end, style: context.textos.bodySmall)),
    ]);
  }

  Widget _numero(String etiqueta, double valor, void Function(double) onChange) {
    return TextFormField(
      initialValue: valor.toString(),
      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
      decoration: InputDecoration(labelText: etiqueta, isDense: true),
      onChanged: (s) {
        final v = double.tryParse(s.replaceAll(',', '.'));
        if (v != null) setState(() => onChange(v));
      },
    );
  }

  Widget _selectorTemas(BancoPreguntas b, Bloques bloques) {
    final conteo = <String, int>{};
    for (final p in b.preguntas) {
      if (_cfg.soloOficiales && !p.oficial) continue;
      conteo[p.tema] = (conteo[p.tema] ?? 0) + 1;
    }
    final codigos = b.temas.keys.toList()..sort(_ordenTema);
    final partes = {'A': codigos.where((c) => c.contains('.A.')).toList(), 'B': codigos.where((c) => c.contains('.B.')).toList()};

    return Column(children: [
      Row(children: [
        TextButton(onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: const {})), child: const Text('Todos')),
        TextButton(onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: partes['A']!.toSet())), child: const Text('Parte A')),
        TextButton(onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: partes['B']!.toSet())), child: const Text('Parte B')),
        const Spacer(),
        Text(_cfg.temas.isEmpty ? 'Todos los temas' : '${_cfg.temas.length} temas', style: context.textos.bodySmall),
      ]),
      if (bloques.bloques.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Wrap(spacing: 6, runSpacing: 6, children: [
            for (final bl in bloques.bloques)
              FilterChip(
                label: Text(bl.nombre),
                selected: bl.temas.every(_cfg.temas.contains),
                onSelected: (sel) => setState(() {
                  final s = {..._cfg.temas};
                  sel ? s.addAll(bl.temas) : s.removeAll(bl.temas);
                  _cfg = _cfg.copyWith(temas: s);
                }),
              ),
          ]),
        ),
      for (final e in partes.entries)
        Tarjeta(
          padding: EdgeInsets.zero,
          child: ExpansionTile(
            title: Text('Parte ${e.key}', style: context.textos.titleMedium),
            subtitle: Text('${e.value.where(_cfg.temas.contains).length} de ${e.value.length} seleccionados', style: context.textos.bodySmall),
            children: [
              for (final c in e.value)
                CheckboxListTile(
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('$c · ${b.temas[c]}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                  secondary: Text('${conteo[c] ?? 0}', style: context.textos.labelMedium),
                  value: _cfg.temas.contains(c),
                  onChanged: (v) => setState(() {
                    final s = {..._cfg.temas};
                    v == true ? s.add(c) : s.remove(c);
                    _cfg = _cfg.copyWith(temas: s);
                  }),
                ),
            ],
          ),
        ),
    ]);
  }

  Widget _selectorExamenes(BancoPreguntas b) {
    final conteo = <String, int>{};
    for (final p in b.preguntas) {
      conteo[p.examen] = (conteo[p.examen] ?? 0) + 1;
    }
    final examenes = [...b.examenes]..sort((x, y) => y.fecha.compareTo(x.fecha));
    return Tarjeta(
      padding: EdgeInsets.zero,
      child: Column(children: [
        for (final ex in examenes)
          CheckboxListTile(
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(ex.nombre, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            secondary: Text('${conteo[ex.id] ?? 0}', style: context.textos.labelMedium),
            value: _cfg.examenes.contains(ex.id),
            onChanged: (v) => setState(() {
              final s = {..._cfg.examenes};
              v == true ? s.add(ex.id) : s.remove(ex.id);
              _cfg = _cfg.copyWith(examenes: s, numPreguntas: s.length == 1 ? (conteo[s.first] ?? DefaultsTest.numPreguntas) : _cfg.numPreguntas);
            }),
          ),
      ]),
    );
  }
}

int _ordenTema(String a, String b) {
  final pa = a.split('.'), pb = b.split('.');
  final c = pa[1].compareTo(pb[1]);
  if (c != 0) return c;
  return int.parse(pa[2]).compareTo(int.parse(pb[2]));
}
