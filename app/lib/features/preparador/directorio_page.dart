import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/red_providers.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Directorio de preparadores verificados: nombre, ejercicios que preparan,
/// si dan clase online o presencial (y dónde) y su LinkedIn, para que el
/// opositor vea qué perfil le interesa.
class DirectorioPage extends ConsumerStatefulWidget {
  const DirectorioPage({super.key});
  @override
  ConsumerState<DirectorioPage> createState() => _DirectorioPageState();
}

class _DirectorioPageState extends ConsumerState<DirectorioPage> {
  /// Filtro por ejercicio (null = todos).
  int? _ejercicio;

  /// Filtro por modalidad: 'online', 'presencial' o null (todas).
  String? _modalidad;

  /// Filtro por ciudad (null = todas).
  String? _ciudad;

  bool _pasa(PreparadorVerificado v) =>
      (_ejercicio == null || v.ejercicios.contains(_ejercicio)) &&
      (_modalidad == null || (_modalidad == 'online' ? v.daOnline : v.daPresencial)) &&
      (_ciudad == null || v.ciudad.trim().toLowerCase() == _ciudad!.toLowerCase());

  @override
  Widget build(BuildContext context) {
    final lista = ref.watch(verificadosProvider);
    final ordenados = ref.watch(directorioOrdenadoProvider);
    // A un opositor, además, quién admite alumnos (a un preparador las reglas no se lo dicen).
    final conPlazas = {for (final e in ref.watch(preparadoresConPlazasProvider).valueOrNull ?? const <(PreparadorVerificado, Plazas, int)>[]) e.$1.uid};
    return Scaffold(
      appBar: BarraWeb(title: const Text('Preparadores verificados')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(verificadosProvider),
        child: ListaAdaptable(children: [
          Text('Preparadores que ha verificado otro preparador de la red. Mira su perfil y, si te interesa, pídele su código para conectar con él o ella, o pídele una clase suelta desde «Pedir una clase suelta».', style: context.textos.bodySmall),
          const SizedBox(height: 10),
          Wrap(spacing: 6, runSpacing: 6, children: [
            ChoiceChip(label: const Text('Todos'), selected: _ejercicio == null, onSelected: (_) => setState(() => _ejercicio = null)),
            for (final e in ejerciciosPreparables) ChoiceChip(label: Text(etiquetaEjercicioCante(e)), selected: _ejercicio == e, onSelected: (_) => setState(() => _ejercicio = _ejercicio == e ? null : e)),
          ]),
          const SizedBox(height: 6),
          Wrap(spacing: 6, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
            for (final (m, t, i) in const [('online', 'Online', Icons.videocam_outlined), ('presencial', 'Presencial', Icons.groups_outlined)])
              FilterChip(
                avatar: Icon(i, size: 18),
                label: Text(t),
                selected: _modalidad == m,
                onSelected: (v) => setState(() {
                  _modalidad = v ? m : null;
                  if (_modalidad != 'presencial') _ciudad = null;
                }),
              ),
            if (_modalidad == 'presencial')
              Builder(builder: (context) {
                final ciudades = {for (final v in lista.valueOrNull ?? const <PreparadorVerificado>[]) if (v.daPresencial && v.ciudad.trim().isNotEmpty) v.ciudad.trim()}.toList()..sort();
                if (ciudades.isEmpty) return const SizedBox.shrink();
                return DropdownButton<String?>(
                  value: _ciudad,
                  hint: const Text('Cualquier ciudad'),
                  underline: const SizedBox.shrink(),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Cualquier ciudad')),
                    for (final c in ciudades) DropdownMenuItem(value: c, child: Text(c)),
                  ],
                  onChanged: (c) => setState(() => _ciudad = c),
                );
              }),
          ]),
          const SizedBox(height: 10),
          ...switch (lista) {
            AsyncData() => () {
                final filtrados = ordenados.where((e) => _pasa(e.$2)).toList();
                if (filtrados.isEmpty) return [Text('No hay preparadores verificados con estos filtros todavía.', style: context.textos.bodySmall)];
                // Subtítulos solo cuando hay grupos que distinguir.
                final conGrupos = filtrados.any((e) => e.$1 == GrupoDirectorio.mios || e.$1 == GrupoDirectorio.conClase);
                final widgets = <Widget>[];
                GrupoDirectorio? anterior;
                for (final (g, v) in filtrados) {
                  if (g != anterior) {
                    final titulo = switch (g) {
                      GrupoDirectorio.mios => 'Tus preparadores',
                      GrupoDirectorio.conClase => 'Con los que has tenido clase',
                      _ => conGrupos && (anterior == GrupoDirectorio.mios || anterior == GrupoDirectorio.conClase) ? 'Otros preparadores' : null,
                    };
                    if (titulo != null) widgets.add(Subtitulo(titulo));
                    anterior = g;
                  }
                  widgets.add(FichaPreparador(v: v, admiteAlumnos: conPlazas.contains(v.uid)));
                }
                return widgets;
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
  const FichaPreparador({super.key, required this.v, this.admiteAlumnos = false});
  final PreparadorVerificado v;
  final bool admiteAlumnos;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Tarjeta(
          padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
          child: Row(children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFE9DDF3),
              foregroundColor: Paleta.primario,
              child: Text(v.nombre.isEmpty ? '?' : v.nombre.characters.first.toUpperCase(), style: TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v.nombre, style: context.textos.titleSmall),
                if (v.ejercicios.isNotEmpty) Text('Prepara el ${v.descripcionEjercicios} ejercicio', style: context.textos.labelSmall),
                if (admiteAlumnos) Text('Admite alumnos nuevos', style: context.textos.labelSmall?.copyWith(color: Paleta.acierto)),
                if (v.descripcionModalidad.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(children: [
                      Icon(v.daPresencial ? Icons.place_outlined : Icons.videocam_outlined, size: 14, color: context.colores.textoSuave),
                      const SizedBox(width: 4),
                      Flexible(child: Text(v.descripcionModalidad, style: context.textos.labelSmall)),
                    ]),
                  ),
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
