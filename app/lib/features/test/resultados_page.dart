import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../data/models/pregunta.dart';
import '../../data/models/resultado.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
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

  @override
  Widget build(BuildContext context) {
    final r = widget.datos.resultado;
    final bloques = ref.watch(bloquesProvider).value ?? Bloques.vacio;
    final porBloque = MotorTest.porBloque(widget.datos.preguntas, widget.datos.respuestas, bloques);
    final aprobado = r.notaSobre10 >= 5;
    final colorNota = aprobado ? Paleta.acierto : context.esquema.error;

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
        if (!didPop) context.go('/test');
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resultados'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.go('/test')),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => Share.share(
                  'Test TCEE: ${formatoNota(r.notaSobre10)}/10 · ${r.correctas} aciertos, ${r.incorrectas} fallos, ${r.sinResponder} en blanco (${formatoTiempo(r.tiempoSeconds)}). victorgutierrezmarcos.es'),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          children: [
            if (widget.datos.porTiempo)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('⏱ Se agotó el tiempo', style: context.textos.labelLarge?.copyWith(color: context.esquema.error)),
              ),
            Tarjeta(
              color: colorNota.withValues(alpha: 0.08),
              child: Column(children: [
                Text('${formatoNota(r.notaSobre10)} / 10', style: context.textos.displaySmall?.copyWith(color: colorNota, fontWeight: FontWeight.w700)),
                Text('${formatoNota(r.puntosBrutos)} de ${formatoNota(r.maxPuntos)} puntos · ${formatoTiempo(r.tiempoSeconds)}', style: context.textos.bodySmall),
                const SizedBox(height: 12),
                Row(children: [
                  _cifra('${r.correctas}', 'Aciertos', Paleta.acierto),
                  _cifra('${r.incorrectas}', 'Fallos', Paleta.fallo),
                  _cifra('${r.sinResponder}', 'En blanco', Paleta.blanco),
                ]),
                const SizedBox(height: 8),
                Text(
                  ref.read(usuarioRepoProvider).conSesion ? '✅ Guardado en tu cuenta' : 'Guardado en este dispositivo. Inicia sesión para sincronizar con la web.',
                  style: context.textos.labelSmall,
                ),
              ]),
            ),
            if (porBloque.length > 1) ...[
              const TituloSeccion('Puntuación por bloque'),
              Tarjeta(
                child: Column(children: [
                  for (final e in porBloque.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
                    _barra(e.key, e.value.aciertos, e.value.total),
                ]),
              ),
            ],
            TituloSeccion('Revisión', accion: DropdownButton<String>(
              value: _filtro,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'todas', child: Text('Todas')),
                DropdownMenuItem(value: 'falladas', child: Text('Falladas')),
                DropdownMenuItem(value: 'blanco', child: Text('En blanco')),
              ],
              onChanged: (v) => setState(() => _filtro = v!),
            )),
            for (var i = 0; i < preguntas.length; i++) _revision(i, preguntas[i]),
            const SizedBox(height: 16),
            FilledButton(onPressed: () => context.go('/test'), child: const Text('Nuevo test')),
          ],
        ),
      ),
    );
  }

  Widget _cifra(String v, String e, Color c) => Expanded(
        child: Column(children: [
          Text(v, style: context.textos.headlineSmall?.copyWith(color: c)),
          Text(e, style: context.textos.labelMedium),
        ]),
      );

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
            color: pct >= 0.5 ? Paleta.acierto : (pct >= 0.3 ? context.colores.dorado : Paleta.fallo),
          ),
        ),
      ]),
    );
  }

  Widget _revision(int i, Pregunta p) {
    final resp = widget.datos.respuestas[p.id];
    final estado = resp == null ? 'blanco' : (p.esCorrecta(resp) ? 'ok' : 'fallo');
    final color = switch (estado) { 'ok' => Paleta.acierto, 'fallo' => Paleta.fallo, _ => Paleta.blanco };
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(estado == 'ok' ? Icons.check_circle : (estado == 'fallo' ? Icons.cancel : Icons.remove_circle_outline), color: color, size: 20),
            const SizedBox(width: 6),
            Etiqueta(p.tema),
            const Spacer(),
            Text(p.examen, style: context.textos.labelSmall),
          ]),
          const SizedBox(height: 8),
          Text(p.enunciado, style: context.textos.bodyMedium),
          const SizedBox(height: 8),
          for (final o in p.opciones.entries)
            Builder(builder: (context) {
              final correcta = p.respuesta.contains(o.key) && !p.anulada;
              final elegida = resp == o.key;
              Color? c;
              if (correcta || (p.anulada && elegida)) c = Paleta.acierto;
              if (elegida && !correcta && !p.anulada) c = Paleta.fallo;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${o.key}) ', style: context.textos.labelLarge?.copyWith(color: c)),
                  Expanded(child: Text(o.value, style: context.textos.bodySmall?.copyWith(color: c ?? context.esquema.onSurface, fontWeight: c != null ? FontWeight.w600 : null))),
                  if (elegida) Icon(Icons.person, size: 14, color: c ?? context.colores.textoClaro),
                ]),
              );
            }),
          if (p.anulada) Text('Pregunta anulada: se cuenta como acierto.', style: context.textos.labelSmall),
        ]),
      ),
    );
  }
}
