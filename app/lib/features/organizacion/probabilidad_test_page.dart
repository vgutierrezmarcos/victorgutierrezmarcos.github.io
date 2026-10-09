import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/frecuencia_test.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/probabilidades.dart';
import 'probabilidad_test.dart';

/// Probabilidad de aprobar el test del primer ejercicio: al azar, pregunta a
/// pregunta (sabidas, dudas entre 2, entre 3…) y con los temas estudiados,
/// cruzado con la frecuencia de cada tema en los exámenes oficiales. Es la
/// misma calculadora que oposicion/probabilidad-test.html.
class ProbabilidadTestPage extends ConsumerStatefulWidget {
  const ProbabilidadTestPage({super.key});
  @override
  ConsumerState<ProbabilidadTestPage> createState() => _ProbabilidadTestPageState();
}

/// Un grupo de «Pregunta a pregunta»: cuántas, entre cuántas opciones se duda
/// (null = me las sé) y qué se hace con ellas (null = lo que convenga).
class _Grupo {
  _Grupo(this.nombre, this.opciones, this.n);
  final String nombre;
  final int? opciones;
  int n;
  double? acierto;
  bool? responder;
}

class _ProbabilidadTestPageState extends ConsumerState<ProbabilidadTestPage> {
  var _reglas = const ReglasTest();
  var _peso = PesoRecientes.mas;
  double? _acierto;
  var _descarte = 0;
  List<_Grupo>? _grupos;
  Set<String>? _simulados;
  final _cache = <String, Object>{};

  T _memo<T extends Object>(String clave, T Function() f) => _cache.putIfAbsent(clave, f) as T;

  /// Acierto en las preguntas respondidas de los últimos tests, si hay bastantes.
  double? _aciertoHistorial(List<ResultadoTest> h) {
    final ultimos = h.where((r) => r.tipo == 'test').take(10).toList();
    final ok = ultimos.fold(0, (s, r) => s + r.correctas), mal = ultimos.fold(0, (s, r) => s + r.incorrectas);
    return ok + mal < 30 ? null : ok / (ok + mal);
  }

  List<_Grupo> _gruposPorDefecto() {
    final n = _reglas.preguntas, k = _reglas.opciones;
    final g = [_Grupo('Me las sé', null, (n * 0.5).round())];
    for (var m = 2; m <= k; m++) {
      g.add(_Grupo(m == k ? 'Ni idea (entre $m)' : 'Dudo entre $m', m, 0));
    }
    g[1].n = (n * 0.2).round();
    if (g.length > 2) g[2].n = (n * 0.1).round();
    return g;
  }

  @override
  Widget build(BuildContext context) {
    final datos = ref.watch(frecuenciaTestProvider);
    final historial = ref.watch(historialProvider).valueOrNull;
    final propio = historial == null ? null : _aciertoHistorial(historial);
    final acierto = _acierto ?? propio ?? 0.85;
    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Probabilidad de aprobar el test'),
        actions: [if (_simulados != null) TextButton(onPressed: () => setState(() => _simulados = null), child: const Text('Mis temas'))],
      ),
      body: datos.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(frecuenciaTestProvider)),
        data: (f) {
          if (f == null || f.examenes.isEmpty) {
            return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No se han podido cargar los exámenes. Comprueba la conexión y vuelve a entrar.')));
          }
          final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));
          final temas = _simulados ?? {for (final c in estudiados) if (f.temas.containsKey(c)) c};
          return ListaAdaptable(children: [
            _avisos(context),
            ..._ajustes(context, acierto, propio),
            ..._sinSaber(context, acierto),
            ..._preguntaAPregunta(context, acierto),
            ..._conTusTemas(context, f, temas, acierto),
            ..._siguientes(context, f, temas, acierto),
            ..._curva(context, f, temas, acierto),
            ..._reales(context, f, temas, acierto),
          ]);
        },
      ),
    );
  }

  // ----------------------------------------------------------------- Avisos

  Widget _avisos(BuildContext context) => GrupoDesplegable(
        titulo: 'Antes de usarla',
        children: [
          for (final (t, d) in const [
            ('Es un modelo sencillo.', 'Supone que cada pregunta es independiente, que aciertas siempre el mismo porcentaje de lo que sabes y que, al dudar, aciertas como el azar. Sirve para comparar estrategias y temas, no para predecir tu nota exacta.'),
            ('La intuición cuenta.', 'Al dudar entre 3 se suele acertar más de 1 de cada 3, y entre 4, más de 1 de cada 4, porque casi siempre algo se sabe. Si en tus simulacros te pasa, pon tu propio porcentaje en «Pregunta a pregunta».'),
            ('Responde a todo.', 'La recomendación es contestar todas las preguntas y entrenarlo así en casa: obliga a razonar cada pregunta, desarrolla la intuición y el día del examen no hay que improvisar. Cuando la calculadora sugiere dejar algo en blanco, es suponiendo que en esas preguntas aciertas solo por azar.'),
            ('El pasado orienta, no asegura.', 'El temario y el tribunal cambian, y cada pregunta cuenta en un solo tema aunque toque varios. Por eso los exámenes recientes pesan más (puedes cambiarlo).'),
            ('La nota para aprobar es la que elijas.', 'La nota de corte real depende de cada convocatoria y del resto del ejercicio.'),
          ])
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
              child: Text.rich(TextSpan(children: [TextSpan(text: '$t ', style: const TextStyle(fontWeight: FontWeight.w700)), TextSpan(text: d)]), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            ),
        ],
      );

  // ---------------------------------------------------------------- Ajustes

  List<Widget> _ajustes(BuildContext context, double acierto, double? propio) {
    Widget campo(String etiqueta, String valor, void Function(double) cambiar, {bool entero = false}) => SizedBox(
          width: 150,
          child: TextFormField(
            initialValue: valor,
            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
            decoration: InputDecoration(labelText: etiqueta, isDense: true),
            onChanged: (s) {
              final v = double.tryParse(s.replaceAll(',', '.'));
              if (v == null) return;
              setState(() {
                cambiar(entero ? v.roundToDouble() : v);
                _cache.clear();
              });
            },
          ),
        );
    String fmt(double v) => v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString().replaceAll('.', ',');
    return [
      const TituloSeccion('El examen'),
      Wrap(spacing: 12, runSpacing: 12, children: [
        campo('Preguntas', '${_reglas.preguntas}', (v) => _reglas = _reglas.copyWith(preguntas: v.toInt().clamp(10, 100)), entero: true),
        campo('Opciones por pregunta', '${_reglas.opciones}', (v) {
          _reglas = _reglas.copyWith(opciones: v.toInt().clamp(2, 6));
          _grupos = null;
        }, entero: true),
        campo('Suma un acierto', fmt(_reglas.acierto), (v) => _reglas = _reglas.copyWith(acierto: v)),
        campo('Resta un fallo', fmt(_reglas.fallo), (v) => _reglas = _reglas.copyWith(fallo: v)),
        campo('En blanco', fmt(_reglas.blanco), (v) => _reglas = _reglas.copyWith(blanco: v)),
        campo('Nota para aprobar (sobre 10)', fmt(_reglas.notaMinima), (v) => _reglas = _reglas.copyWith(notaMinima: v.clamp(0, 10))),
      ]),
      const SizedBox(height: 14),
      Text('Peso de los exámenes recientes', style: context.textos.labelMedium),
      const SizedBox(height: 6),
      SegmentedButton<PesoRecientes>(
        showSelectedIcon: false,
        segments: [for (final p in PesoRecientes.values) ButtonSegment(value: p, label: Text(p.etiqueta))],
        selected: {_peso},
        onSelectionChanged: (s) => setState(() {
          _peso = s.first;
          _cache.clear();
        }),
      ),
      Text(_peso.vidaMedia == 0 ? 'Todos los exámenes cuentan lo mismo.' : 'Un examen de hace ${_peso.vidaMedia} años cuenta la mitad que uno de este año.', style: context.textos.labelSmall),
      const SizedBox(height: 12),
      Text('En las preguntas que sabes aciertas el ${(acierto * 100).round()} %', style: context.textos.labelMedium),
      Slider(
        value: (acierto * 100).clamp(40, 100).toDouble(),
        min: 40,
        max: 100,
        divisions: 60,
        label: '${(acierto * 100).round()} %',
        onChanged: (v) => setState(() {
          _acierto = v / 100;
          _cache.clear();
        }),
      ),
      if (propio != null && _acierto == null) Text('Es lo que aciertas de lo que respondes en tus últimos tests.', style: context.textos.labelSmall),
      const SizedBox(height: 8),
      Text('En las que no sabes, descartas', style: context.textos.labelMedium),
      const SizedBox(height: 6),
      SegmentedButton<int>(
        showSelectedIcon: false,
        segments: const [ButtonSegment(value: 0, label: Text('Ninguna')), ButtonSegment(value: 1, label: Text('1 opción')), ButtonSegment(value: 2, label: Text('2 opciones'))],
        selected: {_descarte},
        onSelectionChanged: (s) => setState(() {
          _descarte = s.first;
          _cache.clear();
        }),
      ),
    ];
  }

  // ----------------------------------------------------- Sin saber ninguna

  List<Widget> _sinSaber(BuildContext context, double acierto) {
    final r = _reglas, n = r.preguntas, k = r.opciones;
    final todas = evaluarGrupos(r, [GrupoPreguntas(n, 1 / k)]);
    // Una línea por cómo se está en el resto: en blanco, ni idea, dudas entre k-1… y entre 2.
    final casos = <(String, int)>[('Resto en blanco', 0), for (var m = k; m >= 2; m--) (m == k ? 'Resto: ni idea (entre $m)' : 'Resto: dudas entre $m', m)];
    final lineas = _memo('sin-$acierto-${r.preguntas}-${r.opciones}-${r.acierto}-${r.fallo}-${r.blanco}-${r.notaMinima}', () => [
          for (final (_, m) in casos)
            [for (var s = 0; s <= n; s++) evaluarGrupos(r, [GrupoPreguntas(s, acierto), GrupoPreguntas(n - s, m == 0 ? 0 : 1 / m, responder: m > 0)]).aprobar],
        ]);
    int? para50(List<double> l) {
      final i = l.indexWhere((p) => p >= 0.5);
      return i < 0 ? null : i;
    }

    final colores = [for (var i = 0; i < casos.length; i++) i == 0 ? context.colores.textoClaro : Color.lerp(context.esquema.primary.withValues(alpha: 0.35), context.esquema.primary, (i - 1) / max(1, casos.length - 2))!];
    return [
      const TituloSeccion('Sin saber ninguna pregunta'),
      Wrap(spacing: 10, runSpacing: 10, children: [
        _cifra(context, porcentaje(todas.aprobar, decimales: todas.aprobar < 0.01 ? 3 : 1), 'de aprobar respondiendo todas al azar', principal: true),
        _cifra(context, _n(todas.media, 2), 'nota esperada (sobre 10)'),
      ]),
      const SizedBox(height: 12),
      Text('Preguntas que hay que saberse para tener un 50 % de aprobar, según cómo estés en el resto:', style: context.textos.bodySmall),
      const SizedBox(height: 6),
      for (var i = 0; i < casos.length; i++)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: [
            Container(width: 18, height: 3, color: colores[i]),
            const SizedBox(width: 8),
            Expanded(child: Text(casos[i].$1, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
            Text(para50(lineas[i])?.toString() ?? '—', style: context.textos.titleSmall),
          ]),
        ),
      const SizedBox(height: 10),
      SizedBox(
        height: 210,
        child: _grafico(context, [for (var i = 0; i < casos.length; i++) (lineas[i], colores[i], i == 0)], 'Preguntas que te sabes', (x) => 'Sabiendo ${x.round()}'),
      ),
      Text('Al azar puro cada respuesta vale ${_n(r.valorRespuesta(1 / k), 3)} puntos; descartando una opción, ${_n(r.valorRespuesta(1 / max(1, k - 1)), 2)}; descartando dos, ${_n(r.valorRespuesta(1 / max(1, k - 2)), 2)}.',
          style: context.textos.labelSmall),
    ];
  }

  // ---------------------------------------------------- Pregunta a pregunta

  List<Widget> _preguntaAPregunta(BuildContext context, double acierto) {
    final r = _reglas;
    final grupos = _grupos ??= _gruposPorDefecto();
    final ultimo = grupos.last;
    final int resto = r.preguntas - grupos.take(grupos.length - 1).fold<int>(0, (s, g) => s + g.n);
    ultimo.n = max(0, resto);
    double p(_Grupo g) => g.acierto ?? (g.opciones == null ? acierto : 1 / g.opciones!);
    // La mejor combinación de responder / dejar en blanco entre los grupos «lo que convenga».
    final libres = [for (var i = 0; i < grupos.length; i++) if (grupos[i].responder == null && grupos[i].n > 0) i];
    List<bool>? mejorDec;
    Resultado? mejor;
    for (var mask = 0; mask < (1 << libres.length); mask++) {
      final dec = [for (final g in grupos) g.responder ?? true];
      for (var b = 0; b < libres.length; b++) {
        dec[libres[b]] = mask & (1 << b) != 0;
      }
      final res = evaluarGrupos(r, [for (var i = 0; i < grupos.length; i++) GrupoPreguntas(grupos[i].n, p(grupos[i]), responder: dec[i])]);
      if (mejor == null || res.aprobar > mejor.aprobar + 1e-12 || ((res.aprobar - mejor.aprobar).abs() <= 1e-12 && res.media > mejor.media)) {
        mejor = res;
        mejorDec = dec;
      }
    }
    return [
      const TituloSeccion('Pregunta a pregunta'),
      Text('Reparte las preguntas según lo que sabes de cada una. La última fila se completa sola hasta el total. En «Lo que convenga», la app elige responder o dejar en blanco lo que más sube la probabilidad de aprobar.', style: context.textos.bodySmall),
      const SizedBox(height: 8),
      for (var i = 0; i < grupos.length; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Tarjeta(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(grupos[i].nombre, style: context.textos.titleSmall)),
                Text(grupos[i].n == 0 ? '' : (mejorDec![i] ? 'Responder' : 'En blanco'), style: context.textos.labelMedium?.copyWith(color: mejorDec![i] ? Paleta.acierto : context.colores.textoClaro, fontWeight: FontWeight.w700)),
              ]),
              const SizedBox(height: 6),
              Wrap(spacing: 10, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
                SizedBox(
                  width: 90,
                  child: i == grupos.length - 1
                      ? InputDecorator(decoration: const InputDecoration(labelText: 'Cuántas', isDense: true), child: Text('${grupos[i].n}'))
                      : TextFormField(
                          key: ValueKey('n-$i-${r.opciones}'),
                          initialValue: '${grupos[i].n}',
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Cuántas', isDense: true),
                          onChanged: (s) => setState(() => grupos[i].n = max(0, int.tryParse(s) ?? 0)),
                        ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    key: ValueKey('a-$i-${r.opciones}-${grupos[i].acierto == null ? (p(grupos[i]) * 100).round() : 'propio'}'),
                    initialValue: '${(p(grupos[i]) * 100).round()}',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Aciertas (%)', isDense: true),
                    onChanged: (s) {
                      final v = double.tryParse(s);
                      setState(() => grupos[i].acierto = v == null ? null : (v.clamp(0, 100) / 100));
                    },
                  ),
                ),
                DropdownButton<bool?>(
                  value: grupos[i].responder,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: null, child: Text('Lo que convenga')),
                    DropdownMenuItem(value: true, child: Text('Responder')),
                    DropdownMenuItem(value: false, child: Text('En blanco')),
                  ],
                  onChanged: (v) => setState(() => grupos[i].responder = v),
                ),
                Text('${_n(r.valorRespuesta(p(grupos[i])), 2)} pt de media al responder', style: context.textos.labelSmall),
              ]),
            ]),
          ),
        ),
      if (resto < 0) Text('Has repartido ${r.preguntas - resto} preguntas y el examen tiene ${r.preguntas}: baja alguna fila.', style: context.textos.bodySmall?.copyWith(color: context.esquema.error)),
      Wrap(spacing: 10, runSpacing: 10, children: [
        _cifra(context, porcentaje(mejor!.aprobar, decimales: 1), 'de aprobar', principal: true),
        _cifra(context, _n(mejor.media, 2), 'nota esperada'),
        _cifra(context, '${_n(mejor.cuantil(0.1), 1)}–${_n(mejor.cuantil(0.9), 1)}', 'nota en 8 de cada 10 intentos'),
      ]),
      const SizedBox(height: 10),
      SizedBox(height: 170, child: _histograma(context, mejor)),
    ];
  }

  // ----------------------------------------------------------- Tus temas

  (double, Resultado) _mejor(FrecuenciaTest f, Set<String> temas, double acierto) => _memo(
        'mejor-${(temas.toList()..sort()).join(',')}-$acierto-$_descarte-${_peso.name}-${_reglas.preguntas}-${_reglas.opciones}-${_reglas.acierto}-${_reglas.fallo}-${_reglas.blanco}-${_reglas.notaMinima}',
        () => mejorAlAzar(_reglas, f, _peso, temas, acierto, _reglas.opciones - _descarte),
      );

  List<Widget> _conTusTemas(BuildContext context, FrecuenciaTest f, Set<String> temas, double acierto) {
    final fr = f.frecuencias(_peso);
    final cobertura = temas.fold(0.0, (s, c) => s + (fr[c] ?? 0));
    final (g, res) = _mejor(f, temas, acierto);
    final orden = f.masPreguntados(_peso);
    return [
      const TituloSeccion('Con los temas que llevas'),
      Text(_simulados == null
          ? 'Con tus ${temas.length} temas estudiados de las partes A y B del tercer ejercicio (los que entran en el test). Combina lo que habría pasado en cada uno de los ${f.examenes.length} exámenes oficiales con tus temas.'
          : 'Simulación: los ${temas.length} temas más preguntados.', style: context.textos.bodySmall),
      Row(children: [
        Expanded(
          child: Slider(
            value: temas.length.toDouble().clamp(0, orden.length.toDouble()),
            min: 0,
            max: orden.length.toDouble(),
            divisions: orden.length,
            label: '${temas.length} más preguntados',
            onChanged: (v) => setState(() => _simulados = orden.take(v.round()).toSet()),
          ),
        ),
        Text('${temas.length} temas', style: context.textos.labelMedium),
      ]),
      Wrap(spacing: 10, runSpacing: 10, children: [
        _cifra(context, porcentaje(res.aprobar, decimales: 1), 'de aprobar', principal: true),
        _cifra(context, _n(res.media, 2), 'nota esperada'),
        _cifra(context, '${_n(res.cuantil(0.1), 1)}–${_n(res.cuantil(0.9), 1)}', 'nota en 8 de cada 10 exámenes'),
        _cifra(context, porcentaje(cobertura, decimales: 0), 'del test es de tus temas (≈ ${_n(cobertura * _reglas.preguntas, 1)} preguntas)'),
      ]),
      const SizedBox(height: 10),
      SizedBox(height: 170, child: _histograma(context, res)),
      Text(
        'Con ${_descarte == 0 ? 'ninguna opción descartada' : _descarte == 1 ? 'una opción descartada' : 'dos opciones descartadas'}, lo que más sube la probabilidad es '
        '${g == 1 ? 'responder al azar todas las que no sepas' : g == 0 ? 'dejar en blanco las que no sepas' : 'responder al azar más o menos el ${(g * 100).round()} % de las que no sepas'}.',
        style: context.textos.bodySmall,
      ),
    ];
  }

  List<Widget> _siguientes(BuildContext context, FrecuenciaTest f, Set<String> temas, double acierto) {
    final fr = f.frecuencias(_peso);
    final base = _mejor(f, temas, acierto).$2;
    final candidatos = (f.temas.keys.where((c) => !temas.contains(c)).toList()..sort((a, b) => fr[b]!.compareTo(fr[a]!))).take(20);
    // Lo que sube la probabilidad de aprobar y, si apenas se mueve (pocos temas), la nota esperada.
    final mejoras = [
      for (final c in candidatos)
        () {
          final r = _mejor(f, {...temas, c}, acierto).$2;
          return (c, r.aprobar - base.aprobar, r.media - base.media);
        }(),
    ];
    final porNota = mejoras.every((m) => m.$2 < 0.0005);
    mejoras.sort((a, b) => porNota ? b.$3.compareTo(a.$3) : b.$2.compareTo(a.$2));
    if (mejoras.isEmpty) return const [];
    return [
      const TituloSeccion('Qué estudiar después'),
      Text(porNota ? 'Con tan pocos temas la probabilidad de aprobar apenas se mueve: estos son los que más suben tu nota esperada.' : 'Los temas que no llevas que más suben tu probabilidad de aprobar el test.', style: context.textos.bodySmall),
      const SizedBox(height: 6),
      for (final (c, d, dn) in mejoras.take(8))
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 56, child: Text(c, style: context.textos.labelMedium?.copyWith(fontWeight: FontWeight.w700))),
            Expanded(child: Text(f.temas[c] ?? '', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
            Text(porNota ? '+${_n(dn, 2)} de nota' : '+${puntos(d)}', style: context.textos.labelMedium?.copyWith(color: Paleta.acierto, fontWeight: FontWeight.w700)),
          ]),
        ),
    ];
  }

  List<Widget> _curva(BuildContext context, FrecuenciaTest f, Set<String> temas, double acierto) {
    final orden = f.masPreguntados(_peso);
    final pts = [for (var n = 0; n <= orden.length; n += 5) _mejor(f, orden.take(n).toSet(), acierto).$2.aprobar];
    return [
      const TituloSeccion('Cuántos temas hacen falta'),
      Text('Probabilidad de aprobar si estudias los N temas más preguntados, con tu acierto y tus descartes.', style: context.textos.bodySmall),
      const SizedBox(height: 8),
      SizedBox(height: 200, child: _grafico(context, [(pts, context.esquema.primary, false)], 'Temas estudiados (de más a menos preguntados)', (x) => '${(x * 5).round()} temas', paso: 5, marca: temas.length / 5)),
    ];
  }

  List<Widget> _reales(BuildContext context, FrecuenciaTest f, Set<String> temas, double acierto) {
    final g = _mejor(f, temas, acierto).$1, cs = f.coberturas(temas), w = f.pesos(_peso), wmax = w.reduce(max);
    return [
      const TituloSeccion('En los exámenes reales'),
      Text('Cuántas preguntas de tus temas cayeron en cada examen y qué nota habrías sacado de media.', style: context.textos.bodySmall),
      const SizedBox(height: 6),
      for (var i = 0; i < f.examenes.length; i++)
        () {
          final e = f.examenes[i], res = conCobertura(_reglas, cs[i], acierto, g, _reglas.opciones - _descarte);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(children: [
              Expanded(child: Text(e.nombre, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis)),
              SizedBox(width: 70, child: Text('${(cs[i] * e.preguntas).round()} de ${e.preguntas}', textAlign: TextAlign.right, style: context.textos.labelSmall)),
              SizedBox(width: 44, child: Text(_n(res.media, 1), textAlign: TextAlign.right, style: context.textos.labelMedium)),
              SizedBox(width: 56, child: Text(porcentaje(res.aprobar, decimales: 0), textAlign: TextAlign.right, style: context.textos.labelMedium?.copyWith(color: res.aprobar >= 0.5 ? Paleta.acierto : context.esquema.error, fontWeight: FontWeight.w700))),
              SizedBox(width: 44, child: Text(porcentaje(w[i] / wmax, decimales: 0), textAlign: TextAlign.right, style: context.textos.labelSmall)),
            ]),
          );
        }(),
      Text('Columnas: preguntas de tus temas · nota media · probabilidad de aprobar · peso del examen.', style: context.textos.labelSmall),
    ];
  }

  // ------------------------------------------------------------- Piezas

  String _n(double v, int d) => v.toStringAsFixed(d).replaceAll('.', ',');

  Widget _cifra(BuildContext context, String valor, String texto, {bool principal = false}) => SizedBox(
        width: 160,
        child: Tarjeta(
          color: principal ? context.colores.primarioPalido : null,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(valor, style: context.textos.headlineSmall?.copyWith(color: principal ? context.esquema.primary : null, fontFeatures: const [FontFeature.tabularFigures()])),
            Text(texto, style: context.textos.labelSmall),
          ]),
        ),
      );

  /// Líneas de probabilidad (0-1) sobre x = 0, 1, 2…; [discontinua] para la de referencia.
  Widget _grafico(BuildContext context, List<(List<double>, Color, bool)> series, String ejeX, String Function(double) etiquetaX, {int paso = 1, double? marca}) {
    final n = series.first.$1.length - 1;
    return LineChart(LineChartData(
      minX: 0,
      maxX: n.toDouble(),
      minY: 0,
      maxY: 1,
      gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 0.25, getDrawingHorizontalLine: (_) => FlLine(color: context.colores.bordeClaro, strokeWidth: 1)),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, interval: 0.25, getTitlesWidget: (v, _) => Text('${(v * 100).round()} %', style: context.textos.labelSmall))),
        bottomTitles: AxisTitles(
          axisNameWidget: Text(ejeX, style: context.textos.labelSmall),
          sideTitles: SideTitles(showTitles: true, reservedSize: 22, interval: max(1, (n / 5).roundToDouble()), getTitlesWidget: (v, _) => Text('${(v * paso).round()}', style: context.textos.labelSmall)),
        ),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (ss) => [for (final s in ss) LineTooltipItem('${s.barIndex == 0 ? '${etiquetaX(s.x)}\n' : ''}${porcentaje(s.y, decimales: 0)}', TextStyle(color: series[s.barIndex].$2 == context.colores.textoClaro ? Colors.white : Colors.white, fontSize: 12))],
        ),
      ),
      lineBarsData: [
        for (final (pts, color, discontinua) in series)
          LineChartBarData(
            spots: [for (var i = 0; i < pts.length; i++) FlSpot(i.toDouble(), pts[i])],
            isCurved: false,
            color: color,
            barWidth: 2,
            dashArray: discontinua ? [5, 4] : null,
            dotData: FlDotData(show: marca != null, checkToShowDot: (s, _) => marca != null && (s.x - marca).abs() < 0.5),
            belowBarData: BarAreaData(show: series.length == 1, color: color.withValues(alpha: 0.1)),
          ),
      ],
    ));
  }

  /// Distribución de la nota (por medios puntos); en morado, las barras que aprueban.
  Widget _histograma(BuildContext context, Resultado res) {
    final bins = <int, double>{};
    for (final (n, q) in res.notas) {
      final b = max(-4, (n * 2).floor());
      bins[b] = (bins[b] ?? 0) + q;
    }
    final lo = min(0, bins.keys.fold(0, min)), hi = 20;
    final maxQ = bins.values.fold(0.0, max);
    return BarChart(BarChartData(
      minY: 0,
      maxY: maxQ * 1.1,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Nota sobre 10 (en morado, aprobado)', style: context.textos.labelSmall),
          sideTitles: SideTitles(showTitles: true, reservedSize: 20, getTitlesWidget: (v, _) => v.toInt().isEven ? Text('${v.toInt() ~/ 2}', style: context.textos.labelSmall) : const SizedBox.shrink()),
        ),
      ),
      barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(getTooltipItem: (g, _, rod, __) => BarTooltipItem('${_n(g.x / 2, 1)}–${_n(g.x / 2 + 0.5, 1)}: ${porcentaje(rod.toY, decimales: 1)}', const TextStyle(color: Colors.white, fontSize: 12)))),
      barGroups: [
        for (var b = lo; b <= hi; b++)
          BarChartGroupData(x: b, barRods: [
            BarChartRodData(
              toY: bins[b] ?? 0,
              width: 7,
              color: b / 2 >= _reglas.notaMinima - 1e-9 ? context.esquema.primary : context.colores.textoClaro.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
            ),
          ]),
      ],
    ));
  }
}
