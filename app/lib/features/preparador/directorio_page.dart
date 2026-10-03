import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red_providers.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Directorio de preparadores verificados: nombre, ejercicios que preparan y
/// su LinkedIn, para que el opositor vea qué perfil le interesa.
class DirectorioPage extends ConsumerStatefulWidget {
  const DirectorioPage({super.key});
  @override
  ConsumerState<DirectorioPage> createState() => _DirectorioPageState();
}

class _DirectorioPageState extends ConsumerState<DirectorioPage> {
  /// Filtro por ejercicio (null = todos).
  int? _ejercicio;

  @override
  Widget build(BuildContext context) {
    final lista = ref.watch(verificadosProvider);
    return Scaffold(
      appBar: BarraWeb(title: const Text('Preparadores verificados')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(verificadosProvider),
        child: ListaAdaptable(children: [
          Text('Preparadores que ha verificado otro preparador de la red. Mira su perfil y, si te interesa, pídele su código para enlazar o pídele un cante suelto desde «Buscar quién me coja un cante».', style: context.textos.bodySmall),
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 6, children: [
            ChoiceChip(label: const Text('Todos'), selected: _ejercicio == null, onSelected: (_) => setState(() => _ejercicio = null)),
            for (final e in ejerciciosConCante) ChoiceChip(label: Text(e == 1 ? '1.º (coyuntura)' : '$e.º'), selected: _ejercicio == e, onSelected: (_) => setState(() => _ejercicio = _ejercicio == e ? null : e)),
          ]),
          const SizedBox(height: 10),
          ...switch (lista) {
            AsyncData(:final value) => () {
                final filtrados = value.where((v) => _ejercicio == null || v.ejercicios.contains(_ejercicio)).toList();
                if (filtrados.isEmpty) return [Text('No hay preparadores verificados para este ejercicio todavía.', style: context.textos.bodySmall)];
                return [for (final v in filtrados) FichaPreparador(v: v)];
              }(),
            AsyncError() => [Text('No se ha podido cargar la lista. Desliza hacia abajo para reintentarlo.', style: context.textos.bodySmall)],
            _ => [const Center(child: CircularProgressIndicator())],
          },
        ]),
      ),
    );
  }
}

/// Ficha de un preparador verificado, con su LinkedIn si lo ha puesto.
class FichaPreparador extends StatelessWidget {
  const FichaPreparador({super.key, required this.v});
  final PreparadorVerificado v;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
          child: Row(children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE9DDF3),
              foregroundColor: Paleta.primario,
              child: Text(v.nombre.isEmpty ? '?' : v.nombre.characters.first.toUpperCase(), style: const TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v.nombre, style: context.textos.titleSmall),
                if (v.ejercicios.isNotEmpty) Text('Prepara el ${v.descripcionEjercicios} ejercicio', style: context.textos.labelSmall),
              ]),
            ),
            if (v.linkedin.isNotEmpty) BotonLinkedin(url: v.linkedin),
          ]),
        ),
      );
}

/// Abre el perfil de LinkedIn.
class BotonLinkedin extends StatelessWidget {
  const BotonLinkedin({super.key, required this.url, this.compacto = false});
  final String url;
  final bool compacto;
  @override
  Widget build(BuildContext context) => compacto
      ? IconButton(tooltip: 'Ver su LinkedIn', icon: const Icon(Icons.badge_outlined), onPressed: () => abrirUrl(context, url))
      : OutlinedButton.icon(
          onPressed: () => abrirUrl(context, url),
          icon: const Icon(Icons.badge_outlined, size: 18),
          label: const Text('LinkedIn'),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        );
}
