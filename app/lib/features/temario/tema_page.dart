import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Visor de un tema: PDF (descargado para offline), estado de estudio y notas propias.
class TemaPage extends ConsumerStatefulWidget {
  const TemaPage({super.key, required this.tema, this.esRecurso = false});
  final Tema tema;
  final bool esRecurso;
  @override
  ConsumerState<TemaPage> createState() => _TemaPageState();
}

class _TemaPageState extends ConsumerState<TemaPage> {
  File? _fichero;
  PdfControllerPinch? _pdf;
  double _progreso = 0;
  Object? _error;
  int _pagina = 1, _paginas = 0;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final url = widget.tema.url;
    if (url == null) return;
    try {
      final f = await ref.read(descargasProvider).obtener(url, progreso: (r, t) {
        if (t > 0 && mounted) setState(() => _progreso = r / t);
      });
      if (!mounted) return;
      setState(() {
        _fichero = f;
        _pdf = PdfControllerPinch(document: PdfDocument.openFile(f.path));
      });
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    _pdf?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ajustes = ref.watch(ajustesProvider);
    final estudiado = ajustes.temasEstudiados.contains(widget.tema.codigo);
    final repaso = ajustes.temasEnRepaso.contains(widget.tema.codigo);
    final nota = ref.read(usuarioRepoProvider).nota(widget.tema.codigo);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.esRecurso ? widget.tema.titulo : 'Tema ${widget.tema.codigo}', overflow: TextOverflow.ellipsis),
        actions: [
          if (!widget.esRecurso)
            IconButton(
              tooltip: 'Notas',
              icon: Icon(nota.isEmpty ? Icons.sticky_note_2_outlined : Icons.sticky_note_2, color: nota.isEmpty ? null : context.colores.dorado),
              onPressed: () => _editarNota(nota),
            ),
          if (_fichero != null)
            IconButton(tooltip: 'Compartir PDF', icon: const Icon(Icons.share_outlined), onPressed: () => Share.shareXFiles([XFile(_fichero!.path)], text: '${widget.tema.codigo} ${widget.tema.titulo}')),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'web') {
                abrirUrl(context, widget.tema.url);
                return;
              }
              if (v == 'borrar' && widget.tema.url != null) {
                final nav = Navigator.of(context);
                await ref.read(descargasProvider).borrar(widget.tema.url!);
                nav.pop();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'web', child: Text('Abrir en el navegador')),
              PopupMenuItem(value: 'borrar', child: Text('Eliminar descarga')),
            ],
          ),
        ],
      ),
      body: Column(children: [
        if (!widget.esRecurso)
          Material(
            color: context.colores.superficie,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(children: [
                Expanded(child: Text(widget.tema.titulo, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                IconButton(
                  tooltip: 'En repaso',
                  icon: Icon(Icons.replay, color: repaso ? context.esquema.primary : context.colores.textoClaro),
                  onPressed: () => ref.read(ajustesProvider.notifier).alternarRepaso(widget.tema.codigo),
                ),
                FilterChip(
                  label: Text(estudiado ? 'Estudiado' : 'Marcar estudiado'),
                  selected: estudiado,
                  avatar: estudiado ? const Icon(Icons.check, size: 16) : null,
                  onSelected: (_) => ref.read(ajustesProvider.notifier).alternarEstudiado(widget.tema.codigo),
                ),
              ]),
            ),
          ),
        Expanded(
          child: _error != null
              ? ErrorVista(error: _error!, reintentar: () => setState(() { _error = null; _cargar(); }))
              : _pdf == null
                  ? Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(width: 160, child: LinearProgressIndicator(value: _progreso == 0 ? null : _progreso)),
                        const SizedBox(height: 12),
                        Text(_progreso == 0 ? 'Descargando PDF…' : 'Descargando ${(100 * _progreso).round()} %', style: context.textos.bodySmall),
                      ]),
                    )
                  : PdfViewPinch(
                      controller: _pdf!,
                      onDocumentLoaded: (d) => setState(() => _paginas = d.pagesCount),
                      onPageChanged: (p) => setState(() => _pagina = p),
                    ),
        ),
        if (_paginas > 0)
          SafeArea(
            top: false,
            child: Container(
              color: context.colores.superficie,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(children: [
                Text('Página $_pagina de $_paginas', style: context.textos.labelSmall),
                Expanded(
                  child: Slider(
                    value: _pagina.toDouble().clamp(1, _paginas.toDouble()),
                    min: 1,
                    max: _paginas.toDouble(),
                    onChanged: (v) => _pdf?.jumpToPage(v.round()),
                  ),
                ),
              ]),
            ),
          ),
      ]),
    );
  }

  Future<void> _editarNota(String actual) async {
    final ctrl = TextEditingController(text: actual);
    final texto = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (c) => Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(c).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Notas · ${widget.tema.codigo}', style: context.textos.titleMedium),
          const SizedBox(height: 8),
          TextField(controller: ctrl, maxLines: 8, minLines: 4, autofocus: true, decoration: const InputDecoration(hintText: 'Ideas clave, dudas, esquema para cantar el tema…')),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(c, ctrl.text), child: const Text('Guardar')),
          ]),
        ]),
      ),
    );
    if (texto != null) {
      await ref.read(usuarioRepoProvider).guardarNota(widget.tema.codigo, texto);
      if (mounted) setState(() {});
    }
  }
}
