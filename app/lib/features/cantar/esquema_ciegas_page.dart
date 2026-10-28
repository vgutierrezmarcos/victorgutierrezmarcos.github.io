import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/analitica.dart';
import '../../core/avisos_breves.dart';
import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/esquema.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/resultado_sheet.dart';
import '../temario/esquema_tema.dart';
import 'pizarra_page.dart';

/// Abre el esquema a ciegas del tema [codigo].
Future<void> abrirEsquemaCiegas(BuildContext context, String codigo) =>
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => EsquemaCiegasPage(codigo: codigo)));

/// Elige el tema para un esquema a ciegas: los estudiados (o, sin ninguno,
/// los del ejercicio) que tienen esquema, los que llevan más tiempo sin
/// repasar primero. Devuelve el código o null.
Future<String?> elegirTemaParaEsquema(BuildContext context, WidgetRef ref) async {
  final temario = ref.read(temarioProvider).valueOrNull;
  if (temario == null) return null;
  final ajustes = ref.read(ajustesProvider);
  final stats = ref.read(estadisticasCantesProvider);
  final vueltas = ref.read(vueltasProvider);
  final ahora = DateTime.now();
  final todos = [for (final e in temario.ejercicios) for (final p in e.partes) for (final t in p.temas) t];
  var candidatos = todos.where((t) => ajustes.temasEstudiados.contains(t.codigo)).toList();
  if (candidatos.isEmpty) candidatos = todos.where((t) => t.codigo.startsWith('${Oposiciones.actual.primerConTemas}.')).toList();
  final esquemas = esquemasDe(ref, candidatos);
  candidatos = candidatos.where((t) => esquemas.containsKey(t.codigo)).toList();
  DateTime? ultimo(String c) {
    final fechas = [...?vueltas[c], if (stats[c]?.ultimo case final u?) u];
    return fechas.isEmpty ? null : fechas.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  candidatos.sort((a, b) {
    final ua = ultimo(a.codigo), ub = ultimo(b.codigo);
    if (ua == null && ub == null) return a.codigo.compareTo(b.codigo);
    if (ua == null) return -1;
    if (ub == null) return 1;
    return ua.compareTo(ub);
  });
  if (!context.mounted) return null;
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (c) => SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Esquema a ciegas', style: context.textos.titleLarge),
            Text(
              candidatos.isEmpty
                  ? 'Ningún tema estudiado tiene esquema todavía.'
                  : 'Saca el esquema de memoria con el tiempo del examen y compáralo con el del tema. Primero, los que llevas más tiempo sin repasar.',
              style: context.textos.bodySmall,
            ),
          ]),
        ),
        Flexible(
          child: ListView(shrinkWrap: true, children: [
            for (final t in candidatos)
              ListTile(
                dense: true,
                title: TextoTema(t.codigo, t.titulo),
                subtitle: Text(
                  switch (ultimo(t.codigo)) { null => 'Sin vuelta ni cante apuntados', final u => 'Hace ${ahora.difference(u).inDays} días · ${esquemas[t.codigo]!.length} apartados' },
                  style: context.textos.labelSmall,
                ),
                onTap: () => Navigator.pop(c, t.codigo),
              ),
          ]),
        ),
      ]),
    ),
  );
}

/// Esquema a ciegas: sacar el esquema de un tema de memoria (texto o
/// pizarra) con el tiempo de esquema del examen y, después, compararlo con
/// los apartados del tema marcando los que se tenían; se valora y va al
/// diario como un esquema (no un cante entero).
class EsquemaCiegasPage extends ConsumerStatefulWidget {
  const EsquemaCiegasPage({super.key, required this.codigo});
  final String codigo;
  @override
  ConsumerState<EsquemaCiegasPage> createState() => _EsquemaCiegasPageState();
}

class _EsquemaCiegasPageState extends ConsumerState<EsquemaCiegasPage> {
  bool _comparando = false;
  final _inicio = DateTime.now();
  int _segundos = 0;
  int _segundosEsquema = 0;
  Timer? _timer;
  final _texto = TextEditingController();
  final _tenia = <String>{};
  int _valoracion = 0;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_comparando) setState(() => _segundos = DateTime.now().difference(_inicio).inSeconds);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _texto.dispose();
    super.dispose();
  }

  String _reloj(int s) => '${(s ~/ 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';

  Future<void> _guardar(Tema tema, List<EntradaEsquema> esquema) async {
    setState(() => _guardando = true);
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final res = ResultadoCante(
      temaCantado: tema.codigo,
      segundos: _segundosEsquema,
      valoracion: _valoracion,
      comentarios: _texto.text.trim().isEmpty ? '' : 'Esquema escrito:\n${_texto.text.trim()}',
      cubiertos: {tema.codigo: _tenia.toList()..sort()},
      apartados: {tema.codigo: esquema.length},
    );
    final c = Cante(
      id: nuevoId(),
      fecha: _inicio,
      titulo: 'Esquema a ciegas',
      minutos: (_segundosEsquema / 60).ceil().clamp(1, 120),
      exposicion: 0,
      ejercicio: tema.ejercicio,
      bolsa: TipoBolsa.lista,
      temas: [tema.codigo],
      estado: EstadoCante.hecho,
      resultado: res,
      esquema: true,
      updatedAt: DateTime.now(),
    );
    await ref.read(cantesProvider.notifier).guardar(c);
    Analitica.instancia.evento('esquema_ciegas', parametros: {'apartados': esquema.length, 'tenia': _tenia.length});
    messenger.mostrar(SnackBar(content: Text('Esquema guardado en el diario: ${_tenia.length} de ${esquema.length} apartados.')));
    nav.pop();
  }

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final tema = temario?.tema(widget.codigo);
    final esquema = tema == null ? null : esquemaDelTema(ref, tema);
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    if (tema == null || esquema == null) {
      return Scaffold(appBar: BarraWeb(title: const Text('Esquema a ciegas')), body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(tema == null ? 'Cargando el temario…' : 'Este tema no tiene esquema en su PDF.', style: context.textos.bodyMedium))));
    }
    final limite = Oposiciones.actual.ejercicio(tema.ejercicio)?.segundosEsquemaPara(1) ?? 0;
    final pasado = limite > 0 && _segundos >= limite;
    final color = estructura?.colorDe(tema.codigo) ?? context.esquema.primary;

    return PopScope(
      canPop: _comparando || _segundos < 30,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final salir = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text('¿Dejar el esquema?'),
            content: const Text('Si sales ahora no se guarda nada. Puedes pasar a comparar y guardarlo aunque no hayas terminado.'),
            actions: [TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Seguir')), FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Salir'))],
          ),
        );
        if (salir == true && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: BarraWeb(
          title: const Text('Esquema a ciegas'),
          actions: [
            if (!_comparando)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: pasado ? Paleta.falloWeb : Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text(limite > 0 ? '${_reloj(_segundos)} / ${_reloj(limite)}' : _reloj(_segundos), style: TextStyle(fontFamily: Fuentes.sans, fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFeatures: const [FontFeature.tabularFigures()])),
                ),
              ),
          ],
        ),
        body: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Row(children: [
              CasillaTema(tema.codigo, color: color, grande: true),
              const SizedBox(width: 12),
              Expanded(child: Text(tema.titulo, style: context.textos.titleMedium)),
            ]),
            const SizedBox(height: 10),
            if (!_comparando) ...[
              Text(
                limite > 0
                    ? 'Saca el esquema de memoria, como en el examen: tienes ${_reloj(limite)} (el tiempo de esquema de un tema). Escríbelo aquí o en la pizarra; cuando acabes, compáralo con el del tema.'
                    : 'Saca el esquema de memoria. Escríbelo aquí o en la pizarra; cuando acabes, compáralo con el del tema.',
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _texto,
                minLines: 8,
                maxLines: 20,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(hintText: '1. …\n   1.1. …\n2. …', alignLabelWithHint: true),
              ),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 6, children: [
                OutlinedButton.icon(onPressed: () => abrirPizarraIndividual(context), icon: const Icon(Icons.draw_outlined, size: 18), label: const Text('Pizarra')),
                FilledButton.icon(
                  onPressed: () => setState(() {
                    _comparando = true;
                    _segundosEsquema = _segundos;
                  }),
                  icon: const Icon(Icons.compare_arrows),
                  label: const Text('Ya está: comparar'),
                ),
              ]),
            ] else ...[
              Text('Tu esquema, ${_reloj(_segundosEsquema)}. Marca los apartados que tenías; los que falten son los que hay que repasar.', style: context.textos.bodySmall),
              const SizedBox(height: 6),
              Tarjeta(
                child: ListaControl(
                  titulo: '${_tenia.length} de ${esquema.length} apartados',
                  esquema: esquema,
                  marcados: _tenia,
                  onChanged: (a, v) => setState(() => v ? _tenia.add(a) : _tenia.remove(a)),
                ),
              ),
              if (_texto.text.trim().isNotEmpty) ...[
                const TituloSeccion('Lo que escribiste'),
                Tarjeta(child: Text(_texto.text.trim(), style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
              ],
              const TituloSeccion('¿Cómo ha ido?'),
              Estrellas(valor: _valoracion, onChanged: (v) => setState(() => _valoracion = v)),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: _guardando ? null : () => _guardar(tema, esquema),
                icon: const Icon(Icons.save_outlined),
                label: const Text('Guardar en el diario'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
