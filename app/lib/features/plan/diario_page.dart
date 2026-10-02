import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cante_page.dart';
import 'cantes_util.dart';

/// Diario de cantes (subpestaña de Cantes): cómo fue cada uno, estadísticas
/// por tema y temas flojos.
class DiarioVista extends ConsumerWidget {
  const DiarioVista({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diario = ref.watch(diarioProvider);
    final stats = ref.watch(estadisticasCantesProvider);
    final temario = ref.watch(temarioProvider).value;
    final valorados = diario.where((c) => (c.resultado?.valoracion ?? 0) > 0).toList();
    final media = valorados.isEmpty ? 0.0 : valorados.fold<int>(0, (s, c) => s + c.resultado!.valoracion) / valorados.length;
    final flojos = stats.values.where((e) => e.flojo).toList()..sort((a, b) => a.valoracionMedia.compareTo(b.valoracionMedia));
    final porTema = stats.values.toList()..sort((a, b) => b.veces.compareTo(a.veces));
    String titulo(String codigo) => temario?.tema(codigo)?.titulo ?? '';

    return diario.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text('Aún no hay cantes anotados. Al terminar un cante, guarda el tema, el tiempo y cómo te ha ido para ver aquí tu evolución.', textAlign: TextAlign.center, style: context.textos.bodySmall),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
              children: [
                Row(children: [
                  Expanded(child: Estadistica(valor: '${diario.length}', etiqueta: 'cantes', icono: Icons.record_voice_over_outlined)),
                  const SizedBox(width: 10),
                  Expanded(child: Estadistica(valor: '${stats.length}', etiqueta: 'temas distintos', icono: Icons.menu_book_outlined)),
                  const SizedBox(width: 10),
                  Expanded(child: Estadistica(valor: media == 0 ? '—' : media.toStringAsFixed(1).replaceAll('.', ','), etiqueta: 'valoración', icono: Icons.star_outline, color: context.colores.dorado)),
                ]),
                if (flojos.isNotEmpty) ...[
                  const TituloSeccion('Temas flojos'),
                  Tarjeta(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Column(children: [
                      for (final e in flojos)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(children: [
                            Expanded(child: Text('${e.codigo} · ${titulo(e.codigo)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                            Estrellas(valor: e.valoracionMedia.round(), tamano: 14),
                          ]),
                        ),
                    ]),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 4), child: Text('Valorados por debajo de 3 de media. El sorteo de práctica puede darles prioridad.', style: context.textos.labelSmall)),
                ],
                const TituloSeccion('Por tema'),
                Tarjeta(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(children: [
                    for (final e in porTema)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(children: [
                          Expanded(child: Text('${e.codigo} · ${titulo(e.codigo)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                          Text('${e.veces}×${e.segundosMedios > 0 ? ' · ${formatoTiempo(e.segundosMedios)}' : ''}', style: context.textos.labelSmall),
                        ]),
                      ),
                  ]),
                ),
                const TituloSeccion('Historial'),
                for (final c in diario)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Tarjeta(
                      padding: EdgeInsets.zero,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: c.id))),
                      child: ListTile(
                        title: Text(c.resultado?.temaCantado == null ? tituloCante(c) : '${c.resultado!.temaCantado} · ${titulo(c.resultado!.temaCantado!)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                        subtitle: Text('${fechaCorta(c.fecha)}${(c.resultado?.segundos ?? 0) > 0 ? ' · ${formatoTiempo(c.resultado!.segundos)}' : ''}${c.titulo.isEmpty ? '' : ' · ${c.titulo}'}${c.dePreparador ? ' · valorado por tu preparador' : ''}', style: context.textos.labelSmall),
                        trailing: Estrellas(valor: c.resultado?.valoracion ?? 0, tamano: 14),
                      ),
                    ),
                  ),
              ],
            );
  }
}
