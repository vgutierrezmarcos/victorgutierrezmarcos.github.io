import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/estructura.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../temario/abrir_tema.dart';
import 'bloque_page.dart';
import 'esquema_vista.dart';

/// Organización del temario: los bloques con su código de colores y los
/// esquemas con las conexiones entre temas (PowerPoint de organización),
/// sobre el progreso del opositor.
class OrganizacionPage extends ConsumerStatefulWidget {
  const OrganizacionPage({super.key});
  @override
  ConsumerState<OrganizacionPage> createState() => _OrganizacionPageState();
}

class _OrganizacionPageState extends ConsumerState<OrganizacionPage> {
  bool _esquema = false;
  int _ejercicio = 3;
  String _idEsquema = 'tercero';
  bool _verProgreso = true;

  @override
  Widget build(BuildContext context) {
    final estructura = ref.watch(estructuraProvider);
    final temario = ref.watch(temarioProvider).value;
    final estudiados = ref.watch(ajustesProvider.select((a) => a.temasEstudiados));

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Organización del temario'),
        actions: [
          IconButton(
            tooltip: _verProgreso ? 'Ver todos los temas encendidos' : 'Ver mi progreso',
            icon: Icon(_verProgreso ? Icons.visibility : Icons.visibility_off_outlined),
            onPressed: () => setState(() => _verProgreso = !_verProgreso),
          ),
        ],
      ),
      body: estructura.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(estructuraProvider)),
        data: (e) {
          if (e.bloques.isEmpty) return ErrorVista(error: 'sin datos', reintentar: () => ref.invalidate(estructuraProvider));
          return Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    showSelectedIcon: false,
                    segments: const [ButtonSegment(value: false, label: Text('Bloques')), ButtonSegment(value: true, label: Text('Esquema'))],
                    selected: {_esquema},
                    onSelectionChanged: (s) => setState(() => _esquema = s.first),
                    style: const ButtonStyle(visualDensity: VisualDensity.compact),
                  ),
                ),
              ]),
            ),
            Expanded(child: _esquema ? _vistaEsquema(e, temario, estudiados) : _vistaBloques(e, temario, estudiados)),
          ]);
        },
      ),
    );
  }

  void _abrirBloque(String id) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BloquePage(id: id)));

  // ------------------------------------------------------------------ Bloques

  Widget _vistaBloques(EstructuraTemario e, Temario? temario, Set<String> estudiados) {
    final sugeridos = e.sugeridos(estudiados, ejercicio: _ejercicio).take(8).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: const [ButtonSegment(value: 3, label: Text('Tercer ejercicio')), ButtonSegment(value: 4, label: Text('Cuarto ejercicio'))],
          selected: {_ejercicio},
          onSelectionChanged: (s) => setState(() => _ejercicio = s.first),
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
        ),
        if (sugeridos.isNotEmpty) ...[
          const SizedBox(height: 12),
          Tarjeta(
            color: context.colores.primarioPalido,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Por dónde seguir', style: context.textos.titleMedium),
              Text('Temas que aún no llevas y que conectan con alguno que ya te sabes.', style: context.textos.bodySmall),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: [
                for (final t in sugeridos) CasillaTema(t, color: e.colorDe(t) ?? context.esquema.primary, grande: true, onTap: () => abrirTema(context, temario, t)),
              ]),
            ]),
          ),
        ],
        for (final categoria in e.categorias(_ejercicio)) ...[
          TituloSeccion(categoria),
          for (final b in e.bloques.where((b) => b.ejercicio == _ejercicio && b.categoria == categoria)) _tarjetaBloque(e, b, estudiados),
        ],
      ],
    );
  }

  /// Caja de un bloque: cabecera con su color (como en el PowerPoint), avance y casillas de sus temas.
  Widget _tarjetaBloque(EstructuraTemario e, BloqueTemario b, Set<String> estudiados) {
    final hechos = b.temas.where(estudiados.contains).length;
    final conexiones = e.conexionesDeBloque(b.id).length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: context.colores.superficie, border: Border.all(color: context.colores.borde), borderRadius: BorderRadius.circular(8), boxShadow: context.sombraSuave),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => _abrirBloque(b.id),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Container(
                color: b.color,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                child: Row(children: [
                  Expanded(child: Text(b.nombre, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 15.5, fontWeight: FontWeight.w600, height: 1.2, color: textoSobre(b.color)))),
                  Text('$hechos / ${b.temas.length}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 14, fontWeight: FontWeight.w600, color: textoSobre(b.color))),
                ]),
              ),
              LinearProgressIndicator(value: b.temas.isEmpty ? 0 : hechos / b.temas.length, minHeight: 4, color: context.esquema.primary, backgroundColor: context.colores.fondoClaro),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Wrap(spacing: 5, runSpacing: 5, children: [
                    for (final t in b.temas) CasillaTema(t, color: b.color, apagada: _verProgreso && !estudiados.contains(t)),
                  ]),
                  if (conexiones > 0) Padding(padding: const EdgeInsets.only(top: 8), child: Text('$conexiones ${conexiones == 1 ? 'conexión' : 'conexiones'} con otros bloques', style: context.textos.labelSmall)),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ Esquema

  Widget _vistaEsquema(EstructuraTemario e, Temario? temario, Set<String> estudiados) {
    final esquema = e.esquemas.firstWhere((x) => x.id == _idEsquema, orElse: () => e.esquemas.first);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Wrap(spacing: 6, children: [
          for (final x in e.esquemas) ChoiceChip(label: Text(x.titulo), selected: x.id == esquema.id, onSelected: (_) => setState(() => _idEsquema = x.id)),
        ]),
      ),
      Expanded(
        child: EsquemaVista(
          estructura: e,
          esquema: esquema,
          temario: temario,
          estudiados: estudiados,
          verProgreso: _verProgreso,
          alAbrirTema: (t) => abrirTema(context, temario, t),
          alAbrirBloque: _abrirBloque,
          alAlternarEstudiado: (t) => ref.read(ajustesProvider.notifier).alternarEstudiado(t),
        ),
      ),
    ]);
  }
}
