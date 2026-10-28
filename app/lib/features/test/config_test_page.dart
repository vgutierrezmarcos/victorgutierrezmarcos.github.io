import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/frecuencia_test.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../organizacion/probabilidad_test_page.dart';
import 'motor_test.dart';
import 'preguntas_por_tema_page.dart';

/// Tarjeta «Continuar el test» (Hoy y Test): un test a medias guardado en el dispositivo.
class TarjetaTestEnCurso extends ConsumerWidget {
  const TarjetaTestEnCurso({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(testEnCursoProvider);
    if (t == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        onTap: () => context.push('/examen', extra: t),
        padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
        child: Row(children: [
          Icon(Icons.play_circle_outline, color: context.esquema.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Continuar el test', style: context.textos.titleMedium),
              Text('${t.respondidas} de ${t.ids.length} respondidas${t.config.tipo == 'diario' ? ' · test diario' : ''}${t.config.modoEstudio ? ' · modo estudio' : ''}. Guardado en este dispositivo.', style: context.textos.bodySmall),
            ]),
          ),
          PopupMenuButton<String>(
            tooltip: 'Más',
            onSelected: (_) async {
              await ref.read(usuarioRepoProvider).guardarTestEnCurso(null);
              ref.invalidate(testEnCursoProvider);
            },
            itemBuilder: (_) => const [PopupMenuItem(value: 'olvidar', child: Text('Descartar el test'))],
          ),
        ]),
      ),
    );
  }
}

/// Fase de selección del simulador: temas, exámenes, nº de preguntas, tiempo y baremo.
/// Es la subpestaña TEST de Estudiar; [pestanas] (los botones) va bajo la cabecera, en el cuerpo.
class ConfigTestPage extends ConsumerStatefulWidget {
  const ConfigTestPage({super.key, this.pestanas});
  final Widget? pestanas;
  @override
  ConsumerState<ConfigTestPage> createState() => _ConfigTestPageState();
}

class _ConfigTestPageState extends ConsumerState<ConfigTestPage> {
  ConfigTest _cfg = const ConfigTest();
  String _modo = 'temas'; // temas | examenes | flojos
  /// Tiempo que tenía antes de activar el modo estudio (sin tiempo), para devolverlo.
  int _minutosAntes = DefaultsTest.minutos;

  /// «Mis puntos flojos»: el peso de cada candidata según el acierto por tema
  /// de los tests hechos, lo que cae en el examen y las ya falladas.
  Map<int, double> _pesos(BancoPreguntas b) {
    final tests = (ref.read(historialProvider).valueOrNull ?? const <ResultadoTest>[]).where((r) => r.tipo != 'repaso');
    final leitner = ref.read(leitnerProvider);
    return MotorTest.pesosPuntosFlojos(
      MotorTest.filtrar(b, _cfg),
      aciertoPorTema: MotorTest.aciertoPorTema(tests, b),
      frecuencias: ref.read(frecuenciaTestProvider).valueOrNull?.frecuencias(PesoRecientes.mas),
      falladas: {for (final e in leitner.questions.entries) if (e.value.box < 5) e.key},
    );
  }

  /// Cuántas respuestas hay en el historial para explicar la ponderación.
  int get _respuestasHistorial => (ref.watch(historialProvider).valueOrNull ?? const <ResultadoTest>[]).where((r) => r.tipo != 'repaso').fold(0, (n, r) => n + r.respuestas.length);

  void _comenzar(BancoPreguntas b) => context.push('/examen', extra: _modo == 'flojos' ? _cfg.copyWith(pesos: _pesos(b)) : _cfg.copyWith(sinPesos: true));

  @override
  Widget build(BuildContext context) {
    final banco = ref.watch(preguntasProvider);
    final bloques = ref.watch(bloquesProvider).valueOrNull ?? Bloques.vacio;
    final leitner = ref.watch(leitnerProvider);
    final pendientes = leitner.pendientes();

    return Scaffold(
      appBar: BarraWeb(
        conOposicion: widget.pestanas != null,
        title: Text(widget.pestanas == null ? 'Simulador de test' : 'Estudiar'),
        actions: [
          IconButton(
            tooltip: 'Estadísticas',
            icon: const Icon(Icons.insights_outlined),
            onPressed: () => context.go('/estudiar/test/estadisticas'),
          ),
        ],
      ),
      body: Column(children: [
        if (widget.pestanas != null) widget.pestanas!,
        Expanded(child: _cuerpo(banco, bloques, pendientes)),
      ]),
    );
  }

  Widget _cuerpo(AsyncValue<BancoPreguntas> banco, Bloques bloques, List<int> pendientes) {
    return banco.when(
      loading: () => const Cargando(texto: 'Cargando preguntas…'),
      error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(preguntasProvider)),
      data: (b) {
        final disponibles = MotorTest.filtrar(b, _cfg).length;
        final delTest = disponibles == 0 ? 0 : _cfg.numPreguntas.clamp(1, disponibles);
        return ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          children: [
            // El camino a la otra subpestaña.
            if (widget.pestanas != null) Aviso(icono: Icons.menu_book_outlined, titulo: 'Ver el temario', texto: 'Los temas, con sus PDF y tu progreso', onTap: () => ref.read(subpestanaEstudiarProvider.notifier).state = 0),
            const TarjetaTestEnCurso(),
            if (ref.watch(oposicionProvider).testVoluntario)
              Tarjeta(
                color: context.colores.primarioPalido,
                child: Text(
                  'Tu examen no tiene test. Esto es práctica voluntaria con las preguntas del test de ${Oposiciones.porId(ref.watch(oposicionProvider).testDe).siglas}: muchas tratan materias que también entran en tu temario.',
                  style: context.textos.bodySmall,
                ),
              ),
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
                      Text('${pendientes.length} preguntas falladas por revisar (método Leitner)', style: context.textos.bodySmall),
                    ]),
                  ),
                  const Icon(Icons.chevron_right),
                ]),
              ),
            if (ref.watch(oposicionProvider).esPrincipal)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FilaEnlace(
                  icono: Icons.fact_check_outlined,
                  titulo: 'Probabilidad de aprobar el test',
                  subtitulo: 'Cuánto te da cada estrategia y qué temas caen más',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProbabilidadTestPage())),
                ),
              ),
            if (ref.watch(oposicionProvider).esPrincipal)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FilaEnlace(
                  icono: Icons.table_chart_outlined,
                  titulo: 'Preguntas por tema',
                  subtitulo: 'Cuántas ha tenido cada tema en los exámenes oficiales, examen a examen',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PreguntasPorTemaPage())),
                ),
              ),
            const TituloSeccion('Selección'),
            // Tres modos: con «Puntos flojos» no cabe junto al título en el móvil.
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<String>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 'temas', label: Text('Temas')),
                  ButtonSegment(value: 'examenes', label: Text('Exámenes')),
                  ButtonSegment(value: 'flojos', label: Text('Puntos flojos')),
                ],
                selected: {_modo},
                onSelectionChanged: (s) => setState(() {
                  _modo = s.first;
                  _cfg = _cfg.copyWith(temas: const {}, examenes: const {});
                }),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              ),
            ),
            const SizedBox(height: 10),
            if (_modo == 'temas')
              _selectorTemas(b, bloques)
            else if (_modo == 'examenes')
              _selectorExamenes(b)
            else
              Tarjeta(
                color: context.colores.primarioPalido,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Icon(Icons.track_changes_outlined, color: context.esquema.primary),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Mis puntos flojos', style: context.textos.titleMedium)),
                  ]),
                  const SizedBox(height: 6),
                  Text(
                    _respuestasHistorial >= 30
                        ? 'Salen con más probabilidad las preguntas de los temas que peor llevas (según tus tests hechos en la app: $_respuestasHistorial respuestas), las de los temas que más caen en el examen y las que ya has fallado. Un test de todo el temario, pero cargado hacia lo que te falta.'
                        : 'Todavía tienes pocas respuestas en la app ($_respuestasHistorial; a partir de 30 cuenta el acierto por tema): mientras, salen con más probabilidad las preguntas de los temas que más caen en el examen y las que ya has fallado.',
                    style: context.textos.bodySmall,
                  ),
                ]),
              ),
            const SizedBox(height: 8),
            // .config-examen de la web: caja verde clara con el título subrayado en dorado.
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              decoration: BoxDecoration(color: context.colores.fondoClaro, border: Border.all(color: context.colores.bordeClaro), borderRadius: BorderRadius.circular(8)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Subtitulo('Configuración del examen'),
                _slider('Preguntas', _cfg.numPreguntas.toDouble(), 5, 100, 19, (v) => _cfg = _cfg.copyWith(numPreguntas: v.round()), '${_cfg.numPreguntas}'),
                if (!_cfg.modoEstudio) _slider('Tiempo', _cfg.minutos.toDouble(), 0, 180, 36, (v) => _cfg = _cfg.copyWith(minutos: v.round()), _cfg.minutos == 0 ? 'Sin límite' : '${_cfg.minutos} min'),
                // Modo estudio: cada pregunta se corrige al responder, con su explicación, y sin tiempo.
                // (Material propio: la caja de fuera tiene color y taparía la tinta del interruptor.)
                Material(
                  type: MaterialType.transparency,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text('Corregir cada pregunta al responder', style: context.textos.titleSmall),
                    subtitle: Text('Modo estudio: ves si has acertado y el «¿Por qué?» antes de pasar a la siguiente. Sin tiempo.', style: context.textos.labelSmall),
                    value: _cfg.modoEstudio,
                    onChanged: (v) => setState(() {
                      if (v) _minutosAntes = _cfg.minutos;
                      _cfg = _cfg.copyWith(modoEstudio: v, minutos: v ? 0 : _minutosAntes);
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: _numero('Acierto', _cfg.puntosAcierto, (v) => _cfg = _cfg.copyWith(puntosAcierto: v))),
                  const SizedBox(width: 8),
                  Expanded(child: _numero('Fallo', _cfg.puntosFallo, (v) => _cfg = _cfg.copyWith(puntosFallo: v))),
                  const SizedBox(width: 8),
                  Expanded(child: _numero('Blanco', _cfg.puntosBlanco, (v) => _cfg = _cfg.copyWith(puntosBlanco: v))),
                ]),
              ]),
            ),
            const SizedBox(height: 12),
            // .filtro-oficial
            Tarjeta(
              color: context.colores.primarioPalido,
              padding: EdgeInsets.zero,
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('Solo preguntas de exámenes oficiales', style: context.textos.titleSmall),
                value: _cfg.soloOficiales,
                onChanged: (v) => setState(() => _cfg = _cfg.copyWith(soloOficiales: v ?? false)),
              ),
            ),
            const SizedBox(height: 12),
            // .contador-seleccion
            Contador(cifras: [
              (valor: _modo == 'temas' ? (_cfg.temas.isEmpty ? 'Todos' : '${_cfg.temas.length}') : (_cfg.examenes.isEmpty ? 'Todos' : '${_cfg.examenes.length}'), etiqueta: _modo == 'temas' ? 'Temas' : 'Exámenes'),
              (valor: '$disponibles', etiqueta: 'Disponibles'),
              (valor: '$delTest', etiqueta: 'En el test'),
            ]),
            const SizedBox(height: 18),
            // .btn-comenzar
            Center(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), textStyle: context.textos.labelLarge?.copyWith(fontSize: 16.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 3),
                onPressed: disponibles == 0 ? null : () => _comenzar(b),
                icon: const Icon(Icons.play_arrow),
                label: Text(disponibles == 0 ? 'No hay preguntas con esos filtros' : 'Comenzar test'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _repasar(List<int> ids) {
    context.push('/examen', extra: ConfigTest(idsFijos: ids, minutos: 0, tipo: 'repaso'));
  }

  Widget _slider(String etiqueta, double valor, double min, double max, int divisiones, void Function(double) onChange, String texto) {
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
    // Partes del banco de preguntas (A y B en TCEE), por la letra del código.
    final partes = <String, List<String>>{};
    for (final c in codigos) {
      final trozos = c.split('.');
      if (trozos.length >= 3) partes.putIfAbsent(trozos[1], () => []).add(c);
    }

    return Column(children: [
      // Wrap: en pantallas estrechas o con letra grande el contador baja a otra línea.
      SizedBox(
        width: double.infinity,
        child: Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, children: [
          Wrap(children: [
            TextButton(onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: const {})), child: const Text('Todos')),
            for (final letra in partes.keys.toList()..sort()) TextButton(onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: partes[letra]!.toSet())), child: Text('Parte $letra')),
            // Los temas que más caen en los exámenes oficiales (frecuencia_temas.json).
            if (ref.watch(frecuenciaTestProvider).valueOrNull case final f?)
              for (final n in const [20, 40])
                TextButton(
                  onPressed: () => setState(() => _cfg = _cfg.copyWith(temas: f.masPreguntados(PesoRecientes.mas).take(n).where(b.temas.containsKey).toSet())),
                  child: Text('$n más preguntados'),
                ),
          ]),
          Text(_cfg.temas.isEmpty ? 'Todos los temas' : '${_cfg.temas.length} temas', style: context.textos.bodySmall),
        ]),
      ),
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
        GrupoDesplegable(
          titulo: 'Parte ${e.key}',
          subtitulo: '${e.value.where(_cfg.temas.contains).length} de ${e.value.length} seleccionados',
          children: [
            for (final c in e.value)
              CheckboxListTile(
                dense: true,
                controlAffinity: ListTileControlAffinity.leading,
                title: TextoTema(c, b.temas[c] ?? ''),
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
            title: Text(ex.nombre, style: context.textos.titleSmall),
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
