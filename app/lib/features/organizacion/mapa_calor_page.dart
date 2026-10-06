import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/cronograma_providers.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../temario/agenda_tema_page.dart';
import 'dominio_tema.dart';

/// Mapa de calor del temario: cada tema con un color más intenso cuanto más
/// lo dominas (o según sus cantes, su test o lo reciente de su repaso), para
/// ver de un vistazo qué está flojo.
///
/// Con [alumno], el de un alumno enlazado visto por su preparador: solo con
/// lo que el alumno comparte (temas estudiados y cantes).
class MapaCalorPage extends ConsumerStatefulWidget {
  const MapaCalorPage({super.key, this.alumno, this.nombreAlumno});
  final ProgresoAlumno? alumno;
  final String? nombreAlumno;

  @override
  ConsumerState<MapaCalorPage> createState() => _MapaCalorPageState();
}

class _MapaCalorPageState extends ConsumerState<MapaCalorPage> {
  LenteMapa _lente = LenteMapa.dominio;
  int? _ejercicio;

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final alumno = widget.alumno;
    final ajustes = ref.watch(ajustesProvider);
    final tests = alumno == null ? (ref.watch(historialProvider).valueOrNull ?? const []) : const [];
    final banco = alumno == null ? ref.watch(preguntasProvider).valueOrNull : null;
    final ahora = DateTime.now();

    if (temario == null) return Scaffold(appBar: BarraWeb(title: const Text('Mapa de calor')), body: const Cargando());
    final ejercicios = temario.ejercicios.where((e) => e.partes.any((p) => p.temas.isNotEmpty) && (Oposiciones.actual.ejercicio(e.id)?.sorteo ?? true)).toList();
    final ej = ejercicios.where((e) => e.id == _ejercicio).firstOrNull ?? ejercicios.where((e) => e.id == Oposiciones.actual.primerConTemas).firstOrNull ?? ejercicios.first;
    final codigos = [for (final p in ej.partes) for (final t in p.temas) t.codigo];
    // Cantes, solo en los ejercicios que se cantan (3.º y 4.º de TCEE, 3.º de
    // DCE); test, solo en el 3.º de TCEE, que es de donde salen sus preguntas.
    final oposicion = Oposiciones.actual;
    final conCantes = oposicion.ejercicio(ej.id)?.cante == TipoCante.temas;
    final conTest = alumno == null && oposicion.id == 'tcee' && ej.id == 3;
    final lentes = [
      for (final l in LenteMapa.values)
        if ((l != LenteMapa.cantes || conCantes) && (l != LenteMapa.test || conTest)) l,
    ];
    final lente = lentes.contains(_lente) ? _lente : LenteMapa.dominio;
    final datos = datosPorTema(
      codigos: codigos,
      estudiados: alumno?.estudiados ?? ajustes.temasEstudiados,
      enRepaso: alumno?.enRepaso ?? ajustes.temasEnRepaso,
      cantes: alumno == null ? ref.watch(estadisticasCantesProvider) : EstadisticaTema.desde(alumno.cantes),
      vueltas: alumno == null ? ref.watch(vueltasProvider) : const {},
      tests: conTest ? [...tests] : const [],
      banco: conTest ? banco : null,
    );
    final valores = {for (final c in codigos) c: valorTema(datos[c]!, lente, ahora)};
    final conDato = valores.values.whereType<double>().toList();
    final media = conDato.isEmpty ? null : conDato.reduce((a, b) => a + b) / conDato.length;

    return Scaffold(
      appBar: BarraWeb(title: const Text('Mapa de calor'), subtitulo: widget.nombreAlumno),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
        children: [
          Text(
            alumno == null
                ? 'Cada tema, más intenso cuanto mejor lo llevas. Gris: aún no hay datos. Toca uno para ver por qué.'
                : 'Con lo que comparte ${widget.nombreAlumno ?? 'tu alumno'}: sus temas estudiados y sus cantes.',
            style: context.textos.bodySmall,
          ),
          const SizedBox(height: 10),
          if (ejercicios.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SegmentedButton<int>(
                showSelectedIcon: false,
                segments: [for (final e in ejercicios) ButtonSegment(value: e.id, label: Text(Oposiciones.actual.nombreEjercicio(e.id)))],
                selected: {ej.id},
                onSelectionChanged: (s) => setState(() => _ejercicio = s.first),
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
              ),
            ),
          SegmentedButton<LenteMapa>(
            showSelectedIcon: false,
            segments: [for (final l in lentes) ButtonSegment(value: l, label: Text(l.nombre))],
            selected: {lente},
            onSelectionChanged: (s) => setState(() => _lente = s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 10),
          _Leyenda(lente: lente, media: media, conDato: conDato.length, total: codigos.length),
          for (final p in ej.partes.where((p) => p.temas.isNotEmpty)) ...[
            TituloSeccion('${p.letra}. ${p.nombre}'),
            Wrap(spacing: 5, runSpacing: 5, children: [
              for (final t in p.temas) _Casilla(tema: t, valor: valores[t.codigo], onTap: () => _detalle(t, datos[t.codigo]!, ahora, conCantes: conCantes, conTest: conTest)),
            ]),
          ],
        ],
      ),
    );
  }

  void _detalle(Tema t, DatosTema d, DateTime ahora, {required bool conCantes, required bool conTest}) {
    final propio = widget.alumno == null;
    final dominio = valorTema(d, LenteMapa.dominio, ahora);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (hoja) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextoTema(t.codigo, t.titulo, color: ref.read(estructuraProvider).valueOrNull?.colorDe(t.codigo)),
            const SizedBox(height: 12),
            _Fila('Dominio', dominio == null ? 'Sin datos' : '${(dominio * 100).round()} de 100'),
            _Fila('Estudiado', d.estudiado ? (d.enRepaso ? 'Sí, y en repaso' : 'Sí') : (d.enRepaso ? 'En repaso' : 'No')),
            if (conCantes) _Fila('Cantes', d.cantes == 0 ? 'Ninguno' : '${d.cantes} · ${d.valoracion == 0 ? 'sin valorar' : '${d.valoracion.toStringAsFixed(1).replaceAll('.', ',')} de 5'}'),
            if (conTest) _Fila('Test', d.respuestas == 0 ? 'Sin preguntas respondidas' : '${d.aciertos} de ${d.respuestas} (${(d.acierto * 100).round()} %)'),
            _Fila(conCantes ? 'Último repaso o cante' : 'Último repaso', d.ultimo == null ? 'Nunca' : '${DateFormat('d MMM y', 'es').format(d.ultimo!)} · hace ${ahora.difference(d.ultimo!).inDays} días'),
            if (propio) ...[
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(hoja);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AgendaTemaPage(tema: t)));
                    },
                    icon: const Icon(Icons.menu_book_outlined, size: 18),
                    label: const Text('Abrir el tema'),
                  ),
                ),
                if (conCantes) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(hoja);
                      ref.read(canteEnCursoProvider.notifier).state = null;
                      ref.read(temaParaCantarProvider.notifier).state = t.codigo;
                      ref.read(subpestanaCantesProvider.notifier).state = 1;
                      context.go('/cantes');
                    },
                    icon: const Icon(Icons.record_voice_over_outlined, size: 18),
                    label: const Text('Cantarlo'),
                  ),
                ),
                ],
              ]),
            ],
          ]),
        ),
      ),
    );
  }
}

/// Color de una casilla: de un tono muy suave a uno intenso del color
/// principal; gris si no hay datos.
Color colorCalor(BuildContext context, double? v) {
  if (v == null) return context.colores.borde;
  return Color.lerp(context.esquema.primary.withValues(alpha: 0.10), context.esquema.primary, 0.12 + 0.88 * v.clamp(0, 1))!;
}

class _Casilla extends StatelessWidget {
  const _Casilla({required this.tema, required this.valor, required this.onTap});
  final Tema tema;
  final double? valor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fondo = colorCalor(context, valor);
    final claro = Color.alphaBlend(fondo, context.colores.superficie).computeLuminance() > 0.45;
    return Tooltip(
      message: tema.titulo,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 56,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: fondo, borderRadius: BorderRadius.circular(4)),
          child: Text(
            tema.codigo.split('.').skip(1).join('.'),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w600, color: claro ? const Color(0xFF1F1F1F) : Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Leyenda extends StatelessWidget {
  const _Leyenda({required this.lente, required this.media, required this.conDato, required this.total});
  final LenteMapa lente;
  final double? media;
  final int conDato;
  final int total;

  @override
  Widget build(BuildContext context) {
    final (bajo, alto) = switch (lente) {
      LenteMapa.dominio => ('Flojo', 'Dominado'),
      LenteMapa.cantes => ('1 estrella', '5 estrellas'),
      LenteMapa.test => ('0 %', '100 %'),
      LenteMapa.repaso => ('Hace mucho', 'Reciente'),
    };
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(bajo, style: context.textos.labelSmall),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: [for (var i = 0; i <= 4; i++) colorCalor(context, i / 4)]),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(alto, style: context.textos.labelSmall),
      ]),
      const SizedBox(height: 4),
      Text(
        conDato == 0 ? 'Aún no hay datos con esta vista.' : '$conDato de $total temas con datos${media == null ? '' : ' · media ${(media! * 100).round()} de 100'}',
        style: context.textos.labelSmall,
      ),
    ]);
  }
}

class _Fila extends StatelessWidget {
  const _Fila(this.etiqueta, this.valor);
  final String etiqueta;
  final String valor;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(children: [
          Expanded(child: Text(etiqueta, style: context.textos.labelMedium)),
          Text(valor, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
        ]),
      );
}
