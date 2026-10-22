import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/frecuencia_test.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Tabla con las preguntas que ha tenido cada tema en los exámenes oficiales
/// del test: cuántas en total, qué parte del test suponen (con más peso los
/// exámenes recientes, si se quiere) y en cuántos exámenes han salido.
/// Tocando un tema se ve examen a examen.
class PreguntasPorTemaPage extends ConsumerStatefulWidget {
  const PreguntasPorTemaPage({super.key});
  @override
  ConsumerState<PreguntasPorTemaPage> createState() => _PreguntasPorTemaPageState();
}

enum _Orden { masPreguntados, porTema }

class _PreguntasPorTemaPageState extends ConsumerState<PreguntasPorTemaPage> {
  var _peso = PesoRecientes.mas;
  var _orden = _Orden.masPreguntados;
  /// Parte del temario (A, B…) o null = todas.
  String? _parte;

  @override
  Widget build(BuildContext context) {
    final datos = ref.watch(frecuenciaTestProvider);
    return Scaffold(
      appBar: BarraWeb(title: const Text('Preguntas por tema')),
      body: datos.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(frecuenciaTestProvider)),
        data: (f) {
          if (f == null || f.examenes.isEmpty) {
            return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No se han podido cargar los exámenes. Comprueba la conexión y vuelve a entrar.')));
          }
          final fr = f.frecuencias(_peso);
          final partes = {for (final c in f.temas.keys) parteDe(c)}.toList()..sort();
          final codigos = f.temas.keys.where((c) => _parte == null || parteDe(c) == _parte).toList();
          if (_orden == _Orden.porTema) {
            codigos.sort(compararCodigosTema);
          } else {
            codigos.sort((a, b) {
              final d = (fr[b] ?? 0).compareTo(fr[a] ?? 0);
              return d != 0 ? d : compararCodigosTema(a, b);
            });
          }
          final anios = f.examenes.map((e) => e.anio).toList()..sort();
          final sinTexto = f.examenes.where((e) => e.sinTexto).length;
          return ListaAdaptable(children: [
            Text(
              '${f.examenes.length} exámenes oficiales (${anios.first}–${anios.last}), ${f.totalPreguntas} preguntas. Cada pregunta cuenta en su tema principal.'
              '${sinTexto > 0 ? ' $sinTexto ${sinTexto == 1 ? 'examen está clasificado' : 'exámenes están clasificados'} por tema pero sin el texto de las preguntas (no se puede practicar en el simulador).' : ''}',
              style: context.textos.bodySmall,
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 14, runSpacing: 10, crossAxisAlignment: WrapCrossAlignment.center, children: [
              _control(context, 'Orden', SegmentedButton<_Orden>(
                showSelectedIcon: false,
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                segments: const [ButtonSegment(value: _Orden.masPreguntados, label: Text('Más preguntados')), ButtonSegment(value: _Orden.porTema, label: Text('Por tema'))],
                selected: {_orden},
                onSelectionChanged: (s) => setState(() => _orden = s.first),
              )),
              _control(context, 'Peso de los recientes', SegmentedButton<PesoRecientes>(
                showSelectedIcon: false,
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                segments: [for (final p in PesoRecientes.values) ButtonSegment(value: p, label: Text(p.etiqueta))],
                selected: {_peso},
                onSelectionChanged: (s) => setState(() => _peso = s.first),
              )),
              if (partes.length > 1)
                _control(context, 'Parte', SegmentedButton<String?>(
                  showSelectedIcon: false,
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                  segments: [const ButtonSegment<String?>(value: null, label: Text('Todas')), for (final p in partes) ButtonSegment<String?>(value: p, label: Text(p))],
                  selected: {_parte},
                  onSelectionChanged: (s) => setState(() => _parte = s.first),
                )),
            ]),
            Text(
              _peso.vidaMedia == 0 ? 'El porcentaje es la parte del test que ha sido de cada tema, contando todos los exámenes igual.' : 'El porcentaje es la parte del test que ha sido de cada tema; un examen de hace ${_peso.vidaMedia} años cuenta la mitad que uno de este año.',
              style: context.textos.labelSmall,
            ),
            const SizedBox(height: 10),
            Tarjeta(
              padding: EdgeInsets.zero,
              child: Column(children: [
                _fila(context, cabecera: true, codigo: 'Tema', titulo: '', preguntas: 'Preg.', porcentaje: '% test', examenes: 'Exám.'),
                for (final c in codigos)
                  _fila(
                    context,
                    codigo: c,
                    titulo: f.temas[c] ?? '',
                    preguntas: '${f.preguntasDeTema(c)}',
                    porcentaje: '${((fr[c] ?? 0) * 100).toStringAsFixed(1).replaceAll('.', ',')} %',
                    examenes: '${f.examenesConTema(c)}/${f.examenes.length}',
                    onTap: () => _verExamenes(context, f, c),
                  ),
              ]),
            ),
            const SizedBox(height: 8),
            Text('Columnas: preguntas en todos los exámenes · parte del test · exámenes en los que ha salido. Toca un tema para verlo examen a examen.', style: context.textos.labelSmall),
          ]);
        },
      ),
    );
  }

  Widget _control(BuildContext context, String etiqueta, Widget control) => Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(etiqueta, style: context.textos.labelSmall),
        const SizedBox(height: 4),
        control,
      ]);

  Widget _fila(BuildContext context, {bool cabecera = false, required String codigo, required String titulo, required String preguntas, required String porcentaje, required String examenes, VoidCallback? onTap}) {
    final estiloCifra = cabecera ? context.textos.labelSmall : context.textos.labelMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colores.bordeClaro))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(width: 52, child: Text(codigo, style: cabecera ? context.textos.labelSmall : context.textos.labelMedium?.copyWith(fontWeight: FontWeight.w700))),
          Expanded(child: Text(titulo, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
          SizedBox(width: 44, child: Text(preguntas, textAlign: TextAlign.right, style: estiloCifra)),
          SizedBox(width: 58, child: Text(porcentaje, textAlign: TextAlign.right, style: estiloCifra)),
          SizedBox(width: 50, child: Text(examenes, textAlign: TextAlign.right, style: estiloCifra)),
        ]),
      ),
    );
  }

  /// Examen a examen: cuántas preguntas tuvo el tema en cada uno.
  Future<void> _verExamenes(BuildContext context, FrecuenciaTest f, String codigo) {
    final examenes = [...f.examenes]..sort((a, b) => b.anio.compareTo(a.anio));
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (c) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (c, scroll) => ListView(controller: scroll, padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), children: [
          Text(codigo, style: c.textos.titleMedium),
          Text(f.temas[codigo] ?? '', style: c.textos.bodySmall),
          const SizedBox(height: 6),
          Text('${f.preguntasDeTema(codigo)} preguntas en ${f.examenesConTema(codigo)} de ${f.examenes.length} exámenes.', style: c.textos.labelMedium),
          const SizedBox(height: 10),
          for (final e in examenes)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(children: [
                Expanded(child: Text(e.nombre, style: c.textos.bodySmall?.copyWith(color: c.esquema.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis)),
                SizedBox(
                  width: 80,
                  child: Text(
                    (e.temas[codigo] ?? 0) == 0 ? '—' : '${e.temas[codigo]} de ${e.preguntas}',
                    textAlign: TextAlign.right,
                    style: c.textos.labelMedium?.copyWith(color: (e.temas[codigo] ?? 0) == 0 ? c.colores.textoClaro : null),
                  ),
                ),
              ]),
            ),
        ]),
      ),
    );
  }
}

/// «A» de «3.A.12».
String parteDe(String codigo) {
  final p = codigo.split('.');
  return p.length >= 2 ? p[1] : '';
}

/// Orden natural de los códigos de tema: por parte y, dentro, por número.
int compararCodigosTema(String a, String b) {
  final pa = a.split('.'), pb = b.split('.');
  for (var i = 0; i < pa.length && i < pb.length; i++) {
    final na = int.tryParse(pa[i]), nb = int.tryParse(pb[i]);
    final d = na != null && nb != null ? na.compareTo(nb) : pa[i].compareTo(pb[i]);
    if (d != 0) return d;
  }
  return pa.length.compareTo(pb.length);
}
