import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/texto_formulas.dart';
import 'motor_test.dart';

class DatosResultado {
  const DatosResultado({required this.resultado, required this.preguntas, required this.respuestas, this.porTiempo = false});
  final ResultadoTest resultado;
  final List<Pregunta> preguntas;
  final Map<int, String?> respuestas;
  final bool porTiempo;
}

/// Fase de resultados: nota, desglose, puntuación por bloque y revisión pregunta a pregunta.
class ResultadosPage extends ConsumerStatefulWidget {
  const ResultadosPage({super.key, required this.datos});
  final DatosResultado datos;
  @override
  ConsumerState<ResultadosPage> createState() => _ResultadosPageState();
}

class _ResultadosPageState extends ConsumerState<ResultadosPage> {
  String _filtro = 'todas';

  /// De vuelta al simulador: Estudiar, subpestaña TEST.
  void _alTest() {
    ref.read(subpestanaEstudiarProvider.notifier).state = 1;
    context.go('/estudiar');
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.datos.resultado;
    final bloques = ref.watch(bloquesProvider).valueOrNull ?? Bloques.vacio;
    final porBloque = MotorTest.porBloque(widget.datos.preguntas, widget.datos.respuestas, bloques);
    final aprobado = r.notaSobre10 >= 5;

    final preguntas = widget.datos.preguntas.where((p) {
      final resp = widget.datos.respuestas[p.id];
      return switch (_filtro) {
        'falladas' => resp != null && !p.esCorrecta(resp),
        'blanco' => resp == null,
        _ => true,
      };
    }).toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _alTest();
      },
      child: Scaffold(
        appBar: BarraWeb(
          title: const Text('Resultados'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: _alTest),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => compartirTexto(context, 'Test ${Oposiciones.actual.siglas}: ${formatoNota(r.notaSobre10)}/10 · ${r.correctas} aciertos, ${r.incorrectas} fallos, ${r.sinResponder} en blanco (${formatoTiempo(r.tiempoSeconds)}). victorgutierrezmarcos.es'),
            ),
          ],
        ),
        body: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            // .resultados-header: nota final en blanco sobre el degradado morado.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(gradient: context.degradadoPrimario, borderRadius: BorderRadius.circular(8), boxShadow: context.sombraSuave),
              child: Column(children: [
                Text(aprobado ? 'Aprobado' : 'Resultado', style: TextStyle(fontFamily: Fuentes.serif, fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                FittedBox(child: Text('${formatoNota(r.notaSobre10)} / 10', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 44, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2))),
                Text('${formatoNota(r.puntosBrutos)} de ${formatoNota(r.maxPuntos)} puntos · ${formatoTiempo(r.tiempoSeconds)}', textAlign: TextAlign.center, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 14.5, color: Colors.white.withValues(alpha: 0.9))),
                if (widget.datos.porTiempo) Padding(padding: const EdgeInsets.only(top: 6), child: Text('Se agotó el tiempo', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.9)))),
              ]),
            ),
            const SizedBox(height: 12),
            // .estadisticas-grid
            Row(children: [
              Expanded(child: Estadistica(valor: '${r.correctas}', etiqueta: 'Correctas', color: Paleta.aciertoWeb)),
              const SizedBox(width: 10),
              Expanded(child: Estadistica(valor: '${r.incorrectas}', etiqueta: 'Incorrectas', color: Paleta.falloWeb)),
              const SizedBox(width: 10),
              Expanded(child: Estadistica(valor: '${r.sinResponder}', etiqueta: 'En blanco', color: Paleta.blanco)),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Text(
                ref.read(usuarioRepoProvider).conSesion ? 'Guardado en tu cuenta: también lo verás en la web.' : 'Guardado en este dispositivo. Inicia sesión para verlo también en la web.',
                style: context.textos.labelSmall,
              ),
            ),
            if (porBloque.length > 1) ...[
              const SizedBox(height: 12),
              // .grafico-bloques
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: context.colores.superficie, border: Border.all(color: context.colores.borde), borderRadius: BorderRadius.circular(8)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Subtitulo('Puntuación por bloque'),
                  for (final e in porBloque.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
                    _barra(e.key, e.value.aciertos, e.value.total),
                ]),
              ),
            ],
            TituloSeccion('Revisión', accion: DropdownButton<String>(
              value: _filtro,
              underline: const SizedBox(),
              style: context.textos.labelLarge,
              items: const [
                DropdownMenuItem(value: 'todas', child: Text('Todas')),
                DropdownMenuItem(value: 'falladas', child: Text('Falladas')),
                DropdownMenuItem(value: 'blanco', child: Text('En blanco')),
              ],
              onChanged: (v) => setState(() => _filtro = v!),
            )),
            for (var i = 0; i < preguntas.length; i++) _revision(i, preguntas[i]),
            const SizedBox(height: 16),
            Wrap(alignment: WrapAlignment.center, spacing: 10, runSpacing: 8, children: [
              FilledButton(onPressed: _alTest, child: const Text('Nuevo test')),
              OutlinedButton(onPressed: () => context.go('/estudiar/test/estadisticas'), child: const Text('Ver estadísticas')),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _barra(String nombre, int ok, int total) {
    final pct = total == 0 ? 0.0 : ok / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(nombre, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
          Text('$ok / $total', style: context.textos.labelMedium),
        ]),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 8,
            backgroundColor: context.colores.fondoClaro,
            color: pct >= 0.5 ? Paleta.aciertoWeb : (pct >= 0.3 ? Paleta.avisoWeb : Paleta.falloWeb),
          ),
        ),
      ]),
    );
  }

  /// .revision-pregunta: caja blanca con un filete a la izquierda según el resultado.
  Widget _revision(int i, Pregunta p) {
    final resp = widget.datos.respuestas[p.id];
    final estado = p.anulada ? 'anulada' : (resp == null ? 'blanco' : (p.esCorrecta(resp) ? 'ok' : 'fallo'));
    final color = switch (estado) { 'ok' => Paleta.aciertoWeb, 'fallo' => Paleta.falloWeb, 'anulada' => Paleta.avisoWeb, _ => Paleta.blanco };
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: context.colores.superficie, border: Border.all(color: context.colores.borde), borderRadius: BorderRadius.circular(8)),
        child: Container(
          decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 4))),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Icon(switch (estado) { 'ok' => Icons.check_circle, 'fallo' => Icons.cancel, 'anulada' => Icons.info, _ => Icons.remove_circle_outline }, color: color, size: 20),
              const SizedBox(width: 6),
              Etiqueta(p.tema),
            ]),
            const SizedBox(height: 8),
            TextoConFormulas(p.enunciado, style: context.textos.bodyMedium),
            const SizedBox(height: 10),
            for (final o in p.opciones.entries)
              Builder(builder: (context) {
                final correcta = p.respuesta.contains(o.key) && !p.anulada;
                final elegida = resp == o.key;
                // Verde la correcta; roja la elegida si era errónea (.opcion-btn.correct / .incorrect).
                final c = correcta || (p.anulada && elegida) ? Paleta.aciertoWeb : (elegida ? Paleta.falloWeb : null);
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: c?.withValues(alpha: 0.12),
                    border: Border.all(color: c ?? context.colores.bordeClaro, width: c == null ? 1 : 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('${o.key}) ', style: TextStyle(fontFamily: Fuentes.sans, fontWeight: FontWeight.w600, fontSize: 14, color: context.esquema.primary)),
                      Expanded(child: TextoConFormulas(o.value, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface, fontWeight: c != null ? FontWeight.w600 : null))),
                    ]),
                    if (elegida) Text('Tu respuesta', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11, fontWeight: FontWeight.w600, color: context.colores.textoSuave)),
                  ]),
                );
              }),
            // .revision-meta
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colores.bordeClaro))),
              child: Text('${p.anulada ? 'Pregunta anulada: se cuenta como acierto. ' : ''}${p.examen}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontStyle: FontStyle.italic, color: context.colores.textoSuave)),
            ),
          ]),
        ),
      ),
    );
  }
}
