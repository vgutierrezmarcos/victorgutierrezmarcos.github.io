import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/calendario.dart';
import '../../core/providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../temario/agenda_tema_page.dart';
import 'cante_form_page.dart';
import 'cantes_util.dart';
import 'resultado_sheet.dart';

/// Detalle de un cante: cuenta atrás, temas que entran, apuntes pendientes
/// de esos temas y, una vez hecho, cómo fue.
class CantePage extends ConsumerWidget {
  const CantePage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(cantesProvider).where((x) => x.id == id).firstOrNull;
    if (c == null) return Scaffold(appBar: BarraWeb(title: const Text('Cante')), body: const Center(child: Text('Este cante ya no existe.')));
    final temario = ref.watch(temarioProvider).value;
    final ajustes = ref.watch(ajustesProvider);
    final agendas = ref.watch(agendasProvider);
    final temas = temario == null ? const <Tema>[] : temasDeCante(c, temario, ajustes);
    final conApuntes = [for (final t in temas) if ((agendas[t.codigo]?.pendientes ?? const []).isNotEmpty) t];
    final r = c.resultado;
    final notifier = ref.read(cantesProvider.notifier);

    Future<void> anotar() async {
      final res = await pedirResultadoCante(context, inicial: r ?? const ResultadoCante(), opciones: temas);
      if (res != null) await notifier.guardar(c.copyWith(estado: EstadoCante.hecho, resultado: res));
    }

    Future<void> borrar() async {
      final nav = Navigator.of(context);
      final enSerie = c.serie != null && c.pendiente;
      final que = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Borrar el cante?'),
          content: Text(enSerie ? 'Este cante forma parte de una repetición semanal.' : 'Se borrará de la agenda${c.hecho ? ' y del diario' : ''}.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            if (enSerie) TextButton(onPressed: () => Navigator.pop(d, 'serie'), child: const Text('Este y los siguientes')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, 'uno'), child: Text(enSerie ? 'Solo este' : 'Borrar')),
          ],
        ),
      );
      if (que == null) return;
      que == 'serie' ? await notifier.borrarSerieDesde(c) : await notifier.borrar(c);
      nav.pop();
    }

    Future<void> compartirIcs() async {
      final dir = await getTemporaryDirectory();
      final f = File('${dir.path}/cante_tcee.ics');
      await f.writeAsString(Calendario.ics([eventoDeCante(c)]));
      await SharePlus.instance.share(ShareParams(files: [XFile(f.path, mimeType: 'text/calendar')], subject: 'Cante TCEE'));
    }

    return Scaffold(
      appBar: BarraWeb(
        title: Text(tituloCante(c)),
        actions: [
          IconButton(tooltip: 'Editar', icon: const Icon(Icons.edit_outlined), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(cante: c)))),
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'google':
                  abrirUrl(context, Calendario.urlGoogle(eventoDeCante(c)));
                case 'ics':
                  await compartirIcs();
                case 'cancelar':
                  await notifier.guardar(c.copyWith(estado: c.estado == EstadoCante.cancelado ? EstadoCante.pendiente : EstadoCante.cancelado));
                case 'borrar':
                  await borrar();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'google', child: Text('Añadir a Google Calendar')),
              const PopupMenuItem(value: 'ics', child: Text('Enviar a otro calendario (.ics)')),
              if (!c.hecho) PopupMenuItem(value: 'cancelar', child: Text(c.estado == EstadoCante.cancelado ? 'Recuperar cante' : 'Marcar como cancelado')),
              const PopupMenuItem(value: 'borrar', child: Text('Borrar')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Tarjeta(
            color: c.pendiente ? context.colores.primarioPalido : null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('${fechaLarga(c.fecha)}, ${horaDe(c.fecha)}', style: context.textos.titleMedium)),
                if (c.hecho) const Etiqueta('Hecho', color: Paleta.acierto),
                if (c.estado == EstadoCante.cancelado) Etiqueta('Cancelado', color: context.colores.textoClaro),
              ]),
              if (c.pendiente) Text(c.fecha.isAfter(DateTime.now()) ? 'Empieza ${cuentaAtras(c.fecha)}' : 'Pendiente de anotar', style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
              Text('${descripcionBolsa(c)} · ${c.minutos} min', style: context.textos.bodySmall),
              if (c.notas.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(c.notas, style: context.textos.bodyMedium)),
              if (c.dePreparador)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Etiqueta((c.preparadorNombre ?? '').isEmpty ? 'Programado por tu preparador' : 'Programado por tu preparador · ${c.preparadorNombre}'),
                ),
            ]),
          ),
          if (c.pendiente) ...[
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: temas.isEmpty
                      ? null
                      : () {
                          final router = GoRouter.of(context);
                          ref.read(canteEnCursoProvider.notifier).state = c.id;
                          ref.read(subpestanaCantesProvider.notifier).state = 1;
                          Navigator.of(context).popUntil((r) => r.isFirst);
                          router.go('/cantes');
                        },
                  icon: const Icon(Icons.casino_outlined),
                  label: const Text('Sortear y cantar'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: anotar, child: const Text('Anotar resultado')),
            ]),
            if (temas.isEmpty)
              Padding(padding: const EdgeInsets.only(top: 6), child: Text('No hay temas en la bolsa: marca temas como estudiados o elige una lista.', style: context.textos.labelSmall)),
          ],
          if (c.hecho && r != null) ...[
            TituloSeccion(c.dePreparador ? 'Valoración del preparador' : 'Cómo fue', accion: TextButton(onPressed: anotar, child: const Text('Editar'))),
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (r.temaCantado != null) Text('${r.temaCantado} · ${temario?.tema(r.temaCantado!)?.titulo ?? ''}', style: context.textos.titleSmall),
                const SizedBox(height: 6),
                Row(children: [
                  Estrellas(valor: r.valoracion, tamano: 20),
                  const SizedBox(width: 12),
                  if (r.segundos > 0) Text(formatoTiempo(r.segundos), style: context.textos.labelMedium),
                ]),
                if (r.comentarios.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(r.comentarios, style: context.textos.bodyMedium)),
                if (r.sorteados.length > 1) Padding(padding: const EdgeInsets.only(top: 8), child: Text('Salieron: ${r.sorteados.join(', ')}', style: context.textos.labelSmall)),
              ]),
            ),
          ],
          if (conApuntes.isNotEmpty) ...[
            const TituloSeccion('Apuntes pendientes de estos temas'),
            for (final t in conApuntes)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Tarjeta(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AgendaTemaPage(tema: t))),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                    for (final a in agendas[t.codigo]!.pendientes) Text('• ${a.texto}', style: context.textos.bodySmall),
                  ]),
                ),
              ),
          ],
          TituloSeccion('Temas que entran (${temas.length})'),
          if (temas.isEmpty)
            Text('Ninguno todavía.', style: context.textos.bodySmall)
          else
            Tarjeta(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                for (final t in temas)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                  ),
              ]),
            ),
        ],
      ),
    );
  }
}
