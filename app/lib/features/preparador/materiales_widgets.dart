import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

IconData iconoMaterial(TipoMaterial t) => switch (t) {
      TipoMaterial.drive => Icons.folder_shared_outlined,
      TipoMaterial.video => Icons.play_circle_outline,
      TipoMaterial.pdf => Icons.picture_as_pdf_outlined,
      TipoMaterial.web => Icons.link,
    };

/// Un material compartido (del preparador o para el alumno): título, de
/// dónde es, la nota y el tema. Al tocarlo se abre el enlace.
class TarjetaMaterial extends ConsumerWidget {
  const TarjetaMaterial({super.key, required this.material, this.accion, this.subtitulo});
  final MaterialCompartido material;

  /// Menú o botón a la derecha (editar, borrar…).
  final Widget? accion;

  /// Línea extra (p. ej. a quién va, o de quién es).
  final String? subtitulo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = material;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final color = m.tema == null ? null : ref.watch(estructuraProvider).valueOrNull?.colorDe(m.tema!);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
        onTap: () => abrirUrl(context, m.url),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(top: 2), child: Icon(iconoMaterial(m.tipo), color: context.esquema.primary)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.titulo, style: context.textos.titleSmall),
              Text(m.dominio, style: context.textos.labelSmall),
              if (m.texto.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(m.texto, maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall)),
              if (m.tema != null) Padding(padding: const EdgeInsets.only(top: 4), child: TextoTema(m.tema!, temario?.tema(m.tema!)?.titulo ?? '', maxLines: 1, color: color)),
              if (subtitulo != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text(subtitulo!, style: context.textos.labelSmall)),
            ]),
          ),
          accion ?? Icon(Icons.open_in_new, size: 18, color: context.colores.textoClaro),
        ]),
      ),
    );
  }
}

/// Hoja con los materiales de un tema (desde la página del tema).
Future<void> mostrarMaterialesDeTema(BuildContext context, List<MaterialCompartido> materiales) => showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (d) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
              Text('Materiales de tu preparador', style: d.textos.titleLarge),
              const SizedBox(height: 10),
              for (final m in materiales) TarjetaMaterial(material: m, subtitulo: m.preparadorNombre.isEmpty ? null : 'De ${m.preparadorNombre}'),
            ]),
          ),
        ),
      ),
    );
