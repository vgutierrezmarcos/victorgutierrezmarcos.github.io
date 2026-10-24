import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../data/models/explicacion.dart';
import '../../data/models/pregunta.dart';
import '../../theme/app_theme.dart';
import '../../widgets/texto_formulas.dart';

/// «¿Por qué?» bajo una pregunta corregida: la idea clave, lo que falla en la
/// opción elegida, por qué la correcta lo es y, a petición, el resto de
/// opciones. Debajo, «Reportar respuesta». Sin explicación para la pregunta,
/// solo el botón de reportar.
class ExplicacionPregunta extends ConsumerStatefulWidget {
  const ExplicacionPregunta({super.key, required this.pregunta, this.elegida});
  final Pregunta pregunta;
  final String? elegida;
  @override
  ConsumerState<ExplicacionPregunta> createState() => _ExplicacionPreguntaState();
}

class _ExplicacionPreguntaState extends ConsumerState<ExplicacionPregunta> {
  /// El aviso de que las explicaciones son de IA sale una sola vez por
  /// arranque: en la primera que se abre (y en esa se queda).
  static int? _conAviso;

  bool _abierta = false;
  bool _todas = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.pregunta;
    final e = ref.watch(explicacionesProvider(p.examen)).valueOrNull?[p.id];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Wrap(spacing: 4, children: [
        if (e != null)
          TextButton.icon(
            onPressed: () => setState(() => _abierta = !_abierta),
            icon: Icon(_abierta ? Icons.expand_less : Icons.lightbulb_outline, size: 18),
            label: Text(_abierta ? 'Ocultar explicación' : '¿Por qué?'),
          ),
        TextButton.icon(
          onPressed: () => reportarPregunta(context, ref, p, widget.elegida),
          icon: const Icon(Icons.flag_outlined, size: 18),
          label: const Text('Reportar respuesta'),
          style: TextButton.styleFrom(foregroundColor: context.colores.textoSuave),
        ),
      ]),
      if (e != null && _abierta) _panel(context, p, e),
    ]);
  }

  Widget _panel(BuildContext context, Pregunta p, Explicacion e) {
    final cuerpo = context.textos.bodySmall?.copyWith(color: context.esquema.onSurface, height: 1.45);
    final elegida = widget.elegida;
    final fallada = elegida != null && !p.esCorrecta(elegida) && e.opciones.containsKey(elegida);
    final correctas = p.respuesta.where(e.opciones.containsKey).toList();
    final restantes = e.opciones.keys.where((k) => k != elegida && !correctas.contains(k)).toList()..sort();

    Widget opcion(String letra, String titulo, Color color) => Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$titulo · $letra)', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontWeight: FontWeight.w600, color: color)),
            const SizedBox(height: 2),
            TextoConFormulas(e.opciones[letra]!, style: cuerpo),
          ]),
        );

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(color: context.colores.primarioPalido, borderRadius: BorderRadius.circular(6)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        TextoConFormulas(e.clave, style: cuerpo?.copyWith(fontWeight: FontWeight.w600)),
        if (fallada) opcion(elegida, 'Tu respuesta', Paleta.falloWeb),
        for (final c in correctas) opcion(c, p.anulada ? 'Opción' : 'Correcta', Paleta.aciertoWeb),
        for (final g in e.graficos) _grafico(context, g),
        const SizedBox(height: 10),
        for (final par in e.parrafos)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: par.startsWith('Ojo:')
                ? Container(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    decoration: BoxDecoration(color: Paleta.avisoWeb.withValues(alpha: 0.12), border: const Border(left: BorderSide(color: Paleta.avisoWeb, width: 3))),
                    child: TextoConFormulas(par, style: cuerpo),
                  )
                : TextoConFormulas(par, style: cuerpo),
          ),
        if (restantes.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() => _todas = !_todas),
              child: Text(_todas ? 'Ocultar las demás opciones' : 'Ver por qué fallan las demás opciones'),
            ),
          ),
        if (_todas)
          for (final k in restantes) opcion(k, p.anulada ? 'Opción' : 'Incorrecta', context.colores.textoSuave),
        if (e.fuentes.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text('Fuentes: ${e.fuentes.join(' · ')}', style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11.5, fontStyle: FontStyle.italic, color: context.colores.textoSuave)),
        ],
        if ((_conAviso ??= p.id) == p.id)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text('Explicaciones redactadas con IA a partir del temario: pueden tener algún error. Si ves uno, «Reportar respuesta».',
                style: TextStyle(fontFamily: Fuentes.sans, fontSize: 11, color: context.colores.textoSuave)),
          ),
      ]),
    );
  }
}

/// Gráfico sobre papel blanco (también en el tema oscuro, como una figura
/// impresa); al tocarlo se abre a pantalla completa para ampliarlo.
Widget _grafico(BuildContext context, GraficoExplicacion g) {
  return Consumer(builder: (context, ref, _) {
    final url = ref.read(oposicionProvider).urlGraficoExplicacion(g.archivo);
    final imagen = Image.network(
      url,
      semanticLabel: g.alt,
      errorBuilder: (_, __, ___) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text('No se pudo cargar el gráfico (hace falta conexión).', style: context.textos.bodySmall),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(12),
              child: InteractiveViewer(maxScale: 5, child: Padding(padding: const EdgeInsets.all(8), child: Image.network(url, semanticLabel: g.alt))),
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 340),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: context.colores.bordeClaro)),
            child: imagen,
          ),
        ),
        if (g.pie.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextoConFormulas(g.pie, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 12, fontStyle: FontStyle.italic, color: context.colores.textoSuave)),
          ),
      ]),
    );
  });
}

const _motivos = {
  'respuesta': 'La respuesta correcta está mal',
  'explicacion': 'La explicación tiene un error',
  'enunciado': 'Errata en el enunciado o las opciones',
  'otro': 'Otro',
};

/// Diálogo de «Reportar respuesta»: motivo y comentario. Le llega por correo
/// solo al administrador (ver UsuarioRepo.reportarPregunta).
Future<void> reportarPregunta(BuildContext context, WidgetRef ref, Pregunta p, String? elegida) async {
  final repo = ref.read(usuarioRepoProvider);
  final messenger = ScaffoldMessenger.of(context);
  if (!repo.conSesion) {
    messenger.mostrar(const SnackBar(content: Text('Inicia sesión para reportar una pregunta.')));
    return;
  }
  var motivo = 'respuesta';
  final texto = TextEditingController();
  final enviar = await showDialog<bool>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, setD) => AlertDialog(
        title: const Text('Reportar respuesta'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Pregunta ${p.numero} · ${p.examen}', style: Theme.of(d).textTheme.bodySmall),
            const SizedBox(height: 8),
            RadioGroup<String>(
              groupValue: motivo,
              onChanged: (v) => setD(() => motivo = v!),
              child: Column(children: [
                for (final m in _motivos.entries) RadioListTile<String>(value: m.key, title: Text(m.value), dense: true, contentPadding: EdgeInsets.zero),
              ]),
            ),
            TextField(
              controller: texto,
              maxLines: 5,
              minLines: 3,
              maxLength: 2000,
              decoration: const InputDecoration(hintText: '¿Qué está mal? Si puedes, di cuál crees que es la correcta y por qué (con la fuente).'),
            ),
            Text('Solo lo lee Víctor.', style: Theme.of(d).textTheme.bodySmall),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Enviar')),
        ],
      ),
    ),
  );
  if (enviar != true) return;
  try {
    // Sin red, Firestore lo guarda y lo manda al volver: no esperar más de unos segundos.
    await repo
        .reportarPregunta(pregunta: p.id, examen: p.examen, numero: p.numero, elegida: elegida, motivo: motivo, comentario: texto.text.trim())
        .timeout(const Duration(seconds: 8), onTimeout: () {});
    messenger.mostrar(const SnackBar(content: Text('Gracias: lo revisaré.')));
  } catch (_) {
    messenger.mostrar(const SnackBar(content: Text('No se pudo enviar. Inténtalo de nuevo.')));
  }
}
