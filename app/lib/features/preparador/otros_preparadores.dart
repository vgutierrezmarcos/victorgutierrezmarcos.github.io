import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'red_widgets.dart';

/// Con quién cantó el alumno [c] visto por el preparador [yo]: «contigo»,
/// «por su cuenta» o «con Paula».
String conQuienCanto(Cante c, {required String? yo, required bool mia}) {
  if (mia || (c.preparador != null && c.preparador == yo)) return 'contigo';
  if (c.preparador == null) return 'por su cuenta';
  final n = (c.preparadorNombre ?? '').trim();
  return n.isEmpty ? 'con otro preparador' : 'con $n';
}

/// «hoy», «ayer», «hace 12 días», «hace 3 meses».
String haceCuanto(DateTime d, [DateTime? ahora]) {
  final hoy = ahora ?? DateTime.now();
  final dias = DateTime(hoy.year, hoy.month, hoy.day).difference(DateTime(d.year, d.month, d.day)).inDays;
  if (dias <= 0) return 'hoy';
  if (dias == 1) return 'ayer';
  if (dias < 60) return 'hace $dias días';
  return 'hace ${(dias / 30).round()} meses';
}

/// Lo que sabe el preparador de cada tema del alumno: cuántas veces lo ha
/// cantado, la última vez y con quién (contigo, por su cuenta u otro
/// preparador). De las clases con otros preparadores no se ve la valoración.
class TemaCantado {
  TemaCantado(this.codigo);
  final String codigo;
  int veces = 0;
  int conmigo = 0;
  DateTime? ultima;
  String ultimaCon = '';
  DateTime? ultimaConmigo;
}

Map<String, TemaCantado> temasCantados(Iterable<String> temas, List<Cante> hechos, {required String? yo, required Set<String> mias}) {
  final out = {for (final t in temas) t: TemaCantado(t)};
  for (final c in [...hechos]..sort((x, y) => x.fecha.compareTo(y.fecha))) {
    final mia = mias.contains(c.id) || (c.preparador != null && c.preparador == yo);
    for (final t in c.resultado?.temasCantados ?? const <String>[]) {
      final e = out.putIfAbsent(t, () => TemaCantado(t));
      e.veces++;
      e.ultima = c.fecha;
      e.ultimaCon = conQuienCanto(c, yo: yo, mia: mia);
      if (mia) {
        e.conmigo++;
        e.ultimaConmigo = c.fecha;
      }
    }
  }
  return out;
}

enum _Filtro { todos, sinCantar, conmigoNo, hace30 }

/// Temas del alumno, cantados o no, con la última vez y con quién.
class TemasCantadosPage extends ConsumerStatefulWidget {
  const TemasCantadosPage({super.key, required this.alumno, required this.hechos, required this.mias});
  final Alumno alumno;
  final List<Cante> hechos;
  final Set<String> mias;
  @override
  ConsumerState<TemasCantadosPage> createState() => _TemasCantadosPageState();
}

class _TemasCantadosPageState extends ConsumerState<TemasCantadosPage> {
  _Filtro _filtro = _Filtro.todos;

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final yo = ref.watch(usuarioActualProvider)?.uid;
    final datos = temasCantados(widget.alumno.temas, widget.hechos, yo: yo, mias: widget.mias);
    final ahora = DateTime.now();
    bool pasa(TemaCantado e) => switch (_filtro) {
          _Filtro.todos => true,
          _Filtro.sinCantar => e.veces == 0,
          _Filtro.conmigoNo => e.conmigo == 0,
          _Filtro.hace30 => e.ultima == null || ahora.difference(e.ultima!).inDays > 30,
        };
    // Primero los que llevan más tiempo sin cantarse (nunca, lo primero).
    final lista = datos.values.where(pasa).toList()
      ..sort((x, y) => (x.ultima ?? DateTime(0)).compareTo(y.ultima ?? DateTime(0)) != 0 ? (x.ultima ?? DateTime(0)).compareTo(y.ultima ?? DateTime(0)) : x.codigo.compareTo(y.codigo));
    final sinCantar = datos.values.where((e) => e.veces == 0).length;
    return Scaffold(
      appBar: BarraWeb(title: const Text('Temas cantados'), subtitulo: widget.alumno.nombre),
      body: ListaAdaptable(padding: const EdgeInsets.fromLTRB(16, 14, 16, 32), children: [
        Text(
          '${datos.length} temas · $sinCantar sin cantar todavía. Con todos sus preparadores y por su cuenta; de las clases con otros preparadores ves el tema, la fecha y con quién, no su valoración.',
          style: context.textos.bodySmall,
        ),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final (f, t) in [(_Filtro.todos, 'Todos'), (_Filtro.sinCantar, 'Sin cantar'), (_Filtro.conmigoNo, 'Nunca contigo'), (_Filtro.hace30, 'Hace más de un mes')])
            ChoiceChip(label: Text(t), selected: _filtro == f, onSelected: (_) => setState(() => _filtro = f)),
        ]),
        const SizedBox(height: 10),
        if (lista.isEmpty) Text('Ningún tema con este filtro.', style: context.textos.bodySmall),
        for (final e in lista)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Tarjeta(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CasillaTema(e.codigo, color: estructura?.colorDe(e.codigo) ?? context.esquema.primary, apagada: e.veces == 0),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(temario?.tema(e.codigo)?.titulo ?? e.codigo, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                    Text(
                      e.veces == 0
                          ? 'Nunca lo ha cantado'
                          : [
                              'Última: ${haceCuanto(e.ultima!, ahora)}, ${e.ultimaCon}',
                              '${e.veces} ${e.veces == 1 ? 'vez' : 'veces'}',
                              e.conmigo == 0 ? 'nunca contigo' : (e.ultimaCon == 'contigo' ? '${e.conmigo} contigo' : '${e.conmigo} contigo (la última, ${haceCuanto(e.ultimaConmigo!, ahora)})'),
                            ].join(' · '),
                      style: context.textos.labelSmall,
                    ),
                  ]),
                ),
              ]),
            ),
          ),
      ]),
    );
  }
}

/// En la ficha del alumno: sus otros preparadores (LinkedIn y WhatsApp si lo
/// comparten), compartir el tuyo con ellos y las notas entre preparadores.
class SeccionOtrosPreparadores extends ConsumerStatefulWidget {
  const SeccionOtrosPreparadores({super.key, required this.alumno});
  final Alumno alumno;
  @override
  ConsumerState<SeccionOtrosPreparadores> createState() => _SeccionOtrosPreparadoresState();
}

class _SeccionOtrosPreparadoresState extends ConsumerState<SeccionOtrosPreparadores> {
  final _nota = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _nota.dispose();
    super.dispose();
  }

  Future<void> _anadir() async {
    final texto = _nota.text.trim();
    if (texto.isEmpty) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _enviando = true);
    try {
      await ref.read(preparadorRepoProvider).anadirNotaPreparadores(widget.alumno, texto);
      _nota.clear();
      ref.invalidate(notasPreparadoresProvider(widget.alumno.id));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('No se pudo guardar la nota. Revisa la conexión.')));
    }
    if (mounted) setState(() => _enviando = false);
  }

  Future<void> _compartir(bool si) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(preparadorRepoProvider).compartirContacto(widget.alumno, si);
      ref.invalidate(comparteContactoProvider(widget.alumno.id));
    } catch (_) {
      messenger.showSnackBar(const SnackBar(content: Text('No se pudo. Revisa la conexión.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = widget.alumno;
    if (!a.enlazado) return const SizedBox();
    final otros = ref.watch(otrosPreparadoresProvider(a.id)).valueOrNull ?? const <OtroPreparador>[];
    final notas = ref.watch(notasPreparadoresProvider(a.id)).valueOrNull ?? const <NotaEntrePreparadores>[];
    if (otros.isEmpty && notas.isEmpty) return const SizedBox();
    final yo = ref.watch(usuarioActualProvider)?.uid;
    final comparto = ref.watch(comparteContactoProvider(a.id)).valueOrNull ?? false;
    final telefono = ref.watch(perfilPreparadorProvider).telefono;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      TituloSeccion(otros.length == 1 ? 'También le prepara' : 'Sus otros preparadores'),
      for (final o in otros)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(o.nombre, style: context.textos.titleSmall),
              const SizedBox(height: 6),
              Wrap(spacing: 8, runSpacing: 6, children: [
                if (o.telefono.isNotEmpty) BotonWhatsApp(telefono: o.telefono, texto: 'WhatsApp', mensaje: 'Hola, ${o.nombre.split(' ').first}. Soy ${ref.read(perfilPreparadorProvider).nombre}, también preparo a ${a.nombre}.'),
                if (o.linkedin.isNotEmpty) OutlinedButton.icon(onPressed: () => abrirUrl(context, o.linkedin), icon: const Icon(Icons.badge_outlined, size: 18), label: const Text('LinkedIn')),
                if (o.telefono.isEmpty && o.linkedin.isEmpty) Text('No ha compartido su contacto.', style: context.textos.labelSmall),
              ]),
            ]),
          ),
        ),
      if (otros.isNotEmpty)
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: comparto,
          onChanged: telefono.isEmpty ? null : _compartir,
          title: const Text('Que vean mi WhatsApp'),
          subtitle: Text(telefono.isEmpty ? 'Pon tu teléfono en Ajustes de preparador para poder compartirlo.' : 'Solo los otros preparadores de ${a.nombre}.', style: context.textos.labelSmall),
        ),
      const TituloSeccion('Notas entre preparadores'),
      Text('Las leéis los preparadores de ${a.nombre}; él no las ve en la app. Para coordinaros: qué temas lleváis, qué flojea…', style: context.textos.labelSmall),
      const SizedBox(height: 8),
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(child: TextField(controller: _nota, minLines: 1, maxLines: 4, maxLength: 2000, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Escribe una nota', counterText: ''))),
        const SizedBox(width: 8),
        IconButton.filled(tooltip: 'Guardar la nota', onPressed: _enviando ? null : _anadir, icon: const Icon(Icons.send)),
      ]),
      const SizedBox(height: 8),
      for (final n in notas)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Tarjeta(
            padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${n.de == yo ? 'Tú' : (n.deNombre.isEmpty ? 'Otro preparador' : n.deNombre)} · ${fechaCorta(n.fecha)}', style: context.textos.labelSmall),
                  const SizedBox(height: 2),
                  Text(n.texto, style: context.textos.bodyMedium),
                ]),
              ),
              if (n.de == yo)
                IconButton(
                  tooltip: 'Borrar mi nota',
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    await ref.read(preparadorRepoProvider).borrarNotaPreparadores(a, n);
                    ref.invalidate(notasPreparadoresProvider(a.id));
                  },
                ),
            ]),
          ),
        ),
    ]);
  }
}
