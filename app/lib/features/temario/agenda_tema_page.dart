import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/estructura.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../organizacion/bloque_page.dart';
import '../test/motor_test.dart';
import 'abrir_tema.dart';

/// Agenda de un tema: lo que te apuntas para la próxima vuelta, las vueltas
/// que llevas, cómo te ha ido al cantarlo y tu nota libre.
class AgendaTemaPage extends ConsumerWidget {
  const AgendaTemaPage({super.key, required this.tema});
  final Tema tema;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: BarraWeb(title: Text('Agenda · ${tema.codigo}')),
        body: AgendaTemaVista(tema: tema),
      );
}

/// Contenido de la agenda (también se muestra en la página del tema cuando no hay PDF).
class AgendaTemaVista extends ConsumerStatefulWidget {
  const AgendaTemaVista({super.key, required this.tema});
  final Tema tema;
  @override
  ConsumerState<AgendaTemaVista> createState() => _AgendaTemaState();
}

class _AgendaTemaState extends ConsumerState<AgendaTemaVista> {
  final _nuevo = TextEditingController();
  late final _nota = TextEditingController(text: ref.read(usuarioRepoProvider).nota(widget.tema.codigo));
  bool _notaCambiada = false;
  bool _verResueltos = false;

  String get _codigo => widget.tema.codigo;

  @override
  void dispose() {
    _nuevo.dispose();
    _nota.dispose();
    super.dispose();
  }

  Future<void> _anadir() async {
    final texto = _nuevo.text.trim();
    if (texto.isEmpty) return;
    _nuevo.clear();
    await ref.read(agendasProvider.notifier).actualizar(_codigo, (a) => a.anadir(texto));
  }

  Future<void> _vuelta() async {
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(agendasProvider.notifier).actualizar(_codigo, (a) => a.vueltaCompletada());
    final ajustes = ref.read(ajustesProvider);
    if (!ajustes.temasEstudiados.contains(_codigo)) await ref.read(ajustesProvider.notifier).alternarEstudiado(_codigo);
    messenger.showSnackBar(const SnackBar(content: Text('Vuelta anotada')));
  }

  @override
  Widget build(BuildContext context) {
    final agenda = ref.watch(agendasProvider)[_codigo] ?? ref.read(agendasProvider.notifier).de(_codigo);
    final stats = ref.watch(estadisticasCantesProvider)[_codigo];
    // Organización del temario: bloque del tema, idea clave y temas con los que conecta.
    final estructura = ref.watch(estructuraProvider).value ?? EstructuraTemario.vacia;
    final bloque = estructura.bloqueDe(_codigo);
    final relacionados = estructura.relacionados(_codigo);
    final temario = ref.watch(temarioProvider).value;
    final pendientes = agenda.pendientes;
    final resueltos = agenda.resueltos;
    final notifier = ref.read(agendasProvider.notifier);
    final fecha = DateFormat('d MMM y', 'es');

    // Simulador: preguntas de este tema y cómo le ha ido en los tests hechos en la app.
    final banco = ref.watch(preguntasProvider).value;
    final delTema = banco == null ? const [] : MotorTest.filtrar(banco, ConfigTest(temas: {_codigo}));
    var respondidas = 0, acertadas = 0;
    if (banco != null && delTema.isNotEmpty) {
      final ids = {for (final p in delTema) p.id};
      for (final r in ref.watch(historialProvider).value ?? const []) {
        r.respuestas.forEach((id, letra) {
          if (!ids.contains(id)) return;
          respondidas++;
          if (letra != null && (banco.porId(id)?.esCorrecta(letra) ?? false)) acertadas++;
        });
      }
    }

    return ListaAdaptable(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Text(widget.tema.titulo, style: context.textos.titleMedium),
        if (bloque != null) ...[
          const SizedBox(height: 10),
          Tarjeta(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BloquePage(id: bloque.id))),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CasillaTema(_codigo, color: bloque.color, grande: true),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(bloque.nombre, style: context.textos.titleSmall),
                    Text(bloque.categoria, style: context.textos.labelSmall),
                  ]),
                ),
                Icon(Icons.chevron_right, color: context.colores.textoClaro),
              ]),
              if (estructura.ideas[_codigo] != null)
                Padding(padding: const EdgeInsets.only(top: 8), child: Text(estructura.ideas[_codigo]!, style: TextStyle(fontFamily: Fuentes.serif, fontStyle: FontStyle.italic, fontSize: 14.5, height: 1.35, color: context.colores.textoSuave))),
              if (relacionados.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text('Conecta con', style: context.textos.labelSmall),
                const SizedBox(height: 4),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  for (final r in relacionados)
                    if (r.esTema)
                      CasillaTema(r.tema!, color: estructura.colorDe(r.tema!) ?? context.esquema.primary, onTap: () => abrirTema(context, temario, r.tema!))
                    else
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BloquePage(id: r.bloque!))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(border: Border.all(color: estructura.bloque(r.bloque!)?.color ?? context.colores.borde, width: 1.5), borderRadius: BorderRadius.circular(3)),
                          child: Text(estructura.bloque(r.bloque!)?.nombre ?? '', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w600, color: context.esquema.onSurface)),
                        ),
                      ),
                ]),
              ],
            ]),
          ),
        ],
        const TituloSeccion('Para la próxima vuelta'),
        Tarjeta(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
          child: Column(children: [
            if (pendientes.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                child: Text('Apúntate aquí lo que quieras mirar la próxima vez que estudies este tema: un dato que actualizar, un gráfico que no te salió, una pregunta para el preparador…', style: context.textos.bodySmall),
              ),
            for (final a in pendientes)
              ListTile(
                dense: true,
                leading: IconButton(icon: Icon(Icons.circle_outlined, color: context.colores.textoClaro), tooltip: 'Hecho', onPressed: () => notifier.actualizar(_codigo, (x) => x.alternar(a.id))),
                title: Text(a.texto, style: context.textos.bodyMedium),
                subtitle: Text(fecha.format(a.creado), style: context.textos.labelSmall),
                trailing: IconButton(icon: const Icon(Icons.close, size: 18), tooltip: 'Borrar', onPressed: () => notifier.actualizar(_codigo, (x) => x.borrar(a.id))),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 4, 0),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _nuevo,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(hintText: 'Añadir apunte…', isDense: true),
                    onSubmitted: (_) => _anadir(),
                  ),
                ),
                IconButton(icon: Icon(Icons.add_circle, color: context.esquema.primary), tooltip: 'Añadir', onPressed: _anadir),
              ]),
            ),
          ]),
        ),
        if (resueltos.isNotEmpty) ...[
          TextButton.icon(
            onPressed: () => setState(() => _verResueltos = !_verResueltos),
            icon: Icon(_verResueltos ? Icons.expand_less : Icons.expand_more, size: 18),
            label: Text('${resueltos.length} ${resueltos.length == 1 ? 'apunte resuelto' : 'apuntes resueltos'}'),
          ),
          if (_verResueltos)
            for (final a in resueltos)
              ListTile(
                dense: true,
                leading: IconButton(icon: const Icon(Icons.check_circle, color: Paleta.acierto), tooltip: 'Volver a pendiente', onPressed: () => notifier.actualizar(_codigo, (x) => x.alternar(a.id))),
                title: Text(a.texto, style: context.textos.bodySmall?.copyWith(decoration: TextDecoration.lineThrough)),
                subtitle: Text('Resuelto el ${fecha.format(a.hecho!)}', style: context.textos.labelSmall),
              ),
        ],
        const TituloSeccion('Vueltas'),
        Tarjeta(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              agenda.vueltas.isEmpty ? 'Aún no has anotado ninguna vuelta a este tema.' : 'Llevas ${agenda.vueltas.length} ${agenda.vueltas.length == 1 ? 'vuelta' : 'vueltas'}. La última, el ${fecha.format(agenda.vueltas.last)}.',
              style: context.textos.bodySmall,
            ),
            if (agenda.vueltas.length > 1) Padding(padding: const EdgeInsets.only(top: 4), child: Text(agenda.vueltas.map(fecha.format).join(' · '), style: context.textos.labelSmall)),
            const SizedBox(height: 10),
            OutlinedButton.icon(onPressed: _vuelta, icon: const Icon(Icons.replay, size: 18), label: const Text('Vuelta completada hoy')),
          ]),
        ),
        if (stats != null) ...[
          const TituloSeccion('Al cantarlo'),
          Row(children: [
            Expanded(child: Estadistica(valor: '${stats.veces}', etiqueta: stats.veces == 1 ? 'vez cantado' : 'veces cantado', icono: Icons.record_voice_over_outlined)),
            const SizedBox(width: 10),
            Expanded(child: Estadistica(valor: stats.valoracionMedia == 0 ? '—' : stats.valoracionMedia.toStringAsFixed(1).replaceAll('.', ','), etiqueta: 'valoración media', icono: Icons.star_outline, color: stats.flojo ? Paleta.fallo : null)),
          ]),
        ],
        if (delTema.isNotEmpty) ...[
          const TituloSeccion('Test de este tema'),
          Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${delTema.length} ${delTema.length == 1 ? 'pregunta oficial' : 'preguntas oficiales'} de este tema en el simulador.'
                '${respondidas == 0 ? '' : ' Has acertado $acertadas de $respondidas (${(100 * acertadas / respondidas).round()} %).'}',
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: () => context.push('/examen', extra: ConfigTest(temas: {_codigo}, numPreguntas: delTema.length.clamp(1, 20), minutos: 0)),
                icon: const Icon(Icons.quiz_outlined, size: 18),
                label: Text('Hacer test de ${delTema.length.clamp(1, 20)} preguntas'),
              ),
            ]),
          ),
        ],
        const TituloSeccion('Nota libre'),
        TextField(
          controller: _nota,
          minLines: 4,
          maxLines: 12,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(hintText: 'Ideas clave, dudas, esquema para cantar el tema…'),
          onChanged: (_) {
            if (!_notaCambiada) setState(() => _notaCambiada = true);
          },
        ),
        if (_notaCambiada)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FilledButton(
                onPressed: () async {
                  await ref.read(usuarioRepoProvider).guardarNota(_codigo, _nota.text);
                  if (mounted) setState(() => _notaCambiada = false);
                },
                child: const Text('Guardar nota'),
              ),
            ),
          ),
      ],
    );
  }
}
