import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../core/red_providers.dart';
import '../../data/models/frecuencia_test.dart';
import '../preparador/materiales_widgets.dart';
import 'agenda_tema_page.dart';

/// Visor de un tema: PDF (descargado para offline), estado de estudio y agenda
/// del tema (apuntes para la próxima vuelta, vueltas y nota libre). Si el tema
/// no tiene PDF se muestra directamente la agenda.
class TemaPage extends ConsumerStatefulWidget {
  const TemaPage({super.key, required this.tema, this.esRecurso = false});
  final Tema tema;
  final bool esRecurso;
  @override
  ConsumerState<TemaPage> createState() => _TemaPageState();
}

class _TemaPageState extends ConsumerState<TemaPage> {
  String? _ruta; // fichero descargado (solo en el móvil)
  PdfControllerPinch? _pdf;
  double _progreso = 0;
  Object? _error;
  int _pagina = 1, _paginas = 0;

  @override
  void initState() {
    super.initState();
    _cargar();
    // Al abrir el tema se recuerdan los apuntes que se dejaron para esta vuelta.
    if (!widget.esRecurso && widget.tema.url != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final n = ref.read(agendasProvider.notifier).de(widget.tema.codigo).pendientes.length;
        if (n == 0) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(n == 1 ? 'Tienes 1 apunte pendiente para esta vuelta' : 'Tienes $n apuntes pendientes para esta vuelta'),
          action: SnackBarAction(label: 'Ver', textColor: Colors.white, onPressed: _abrirAgenda),
        ));
      });
    }
  }

  void _abrirAgenda() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AgendaTemaPage(tema: widget.tema)));

  Future<void> _cargar() async {
    final url = widget.tema.url;
    if (url == null || widget.tema.esPaginaWeb) return;
    try {
      final pdf = await ref.read(descargasProvider).abrir(url, progreso: (r, t) {
        if (t > 0 && mounted) setState(() => _progreso = r / t);
      });
      if (!mounted) return;
      setState(() {
        _ruta = pdf.ruta;
        _pdf = PdfControllerPinch(document: pdf.ruta != null ? PdfDocument.openFile(pdf.ruta!) : PdfDocument.openData(pdf.bytes!));
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
    final pendientes = (ref.watch(agendasProvider)[widget.tema.codigo]?.pendientes ?? const []).length;
    final conNota = ref.read(usuarioRepoProvider).nota(widget.tema.codigo).isNotEmpty;
    final sinPdf = widget.tema.url == null;
    // El preparador consulta el tema: sin marcar estudiado ni repaso.
    final preparador = ref.watch(papelProvider) == Papel.preparador;
    final web = widget.tema.esPaginaWeb;

    return Scaffold(
      appBar: BarraWeb(
        title: Text(widget.esRecurso ? widget.tema.titulo : 'Tema ${widget.tema.codigo}', overflow: TextOverflow.ellipsis),
        actions: [
          if (!widget.esRecurso && !sinPdf)
            IconButton(
              tooltip: preparador ? 'Notas y test del tema' : 'Agenda del tema: apuntes para la próxima vuelta y notas',
              icon: Badge(
                isLabelVisible: pendientes > 0,
                label: Text('$pendientes'),
                child: Icon(pendientes > 0 || conNota ? Icons.sticky_note_2 : Icons.sticky_note_2_outlined, color: pendientes > 0 || conNota ? context.colores.dorado : null),
              ),
              onPressed: _abrirAgenda,
            ),
          if (_ruta != null)
            IconButton(tooltip: 'Compartir PDF', icon: const Icon(Icons.share_outlined), onPressed: () => SharePlus.instance.share(ShareParams(files: [XFile(_ruta!)], text: '${widget.tema.codigo} ${widget.tema.titulo}'))),
          if (!sinPdf && !web) PopupMenuButton<String>(
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
            itemBuilder: (_) => [
              PopupMenuItem(value: 'web', child: Text(kIsWeb ? 'Abrir en otra pestaña' : 'Abrir en el navegador')),
              if (ref.read(descargasProvider).guardaSinConexion) const PopupMenuItem(value: 'borrar', child: Text('Eliminar descarga')),
            ],
          ),
        ],
      ),
      body: Column(children: [
        if (!widget.esRecurso) _FilaMateriales(codigo: widget.tema.codigo),
        if (!widget.esRecurso)
          Material(
            color: context.colores.superficie,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Text(widget.tema.titulo, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                    // Cuánto cae en el test del primer ejercicio (solo los temas que entran en él).
                    if (ref.watch(frecuenciaTestProvider).valueOrNull case final f? when f.temas.containsKey(widget.tema.codigo))
                      Text('En el test: ${textoFrecuencia(f, widget.tema.codigo)}', style: context.textos.labelSmall),
                  ]),
                ),
                if (!preparador) IconButton(
                  tooltip: 'En repaso',
                  icon: Icon(Icons.replay, color: repaso ? context.esquema.primary : context.colores.textoClaro),
                  onPressed: () => ref.read(ajustesProvider.notifier).alternarRepaso(widget.tema.codigo),
                ),
                if (!preparador) FilterChip(
                  label: Text(estudiado ? 'Estudiado' : 'Marcar estudiado'),
                  selected: estudiado,
                  avatar: estudiado ? const Icon(Icons.check, size: 16) : null,
                  onSelected: (_) => ref.read(ajustesProvider.notifier).alternarEstudiado(widget.tema.codigo),
                ),
              ]),
            ),
          ),
        Expanded(
          child: sinPdf
              ? AgendaTemaVista(tema: widget.tema)
              : web
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                    child: Tarjeta(
                      color: context.colores.primarioPalido,
                      onTap: () => abrirUrl(context, widget.tema.url, enApp: true),
                      child: Row(children: [
                        Icon(Icons.menu_book_outlined, color: context.esquema.primary),
                        const SizedBox(width: 12),
                        Expanded(child: Text('Los apuntes de este tema están en la web.', style: context.textos.bodySmall)),
                        FilledButton(onPressed: () => abrirUrl(context, widget.tema.url, enApp: true), child: const Text('Leer el tema')),
                      ]),
                    ),
                  ),
                  Expanded(child: AgendaTemaVista(tema: widget.tema)),
                ])
              : _error != null
              ? ErrorVista(error: _error!, reintentar: () => setState(() { _error = null; _cargar(); }))
              : _pdf == null
                  ? Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(width: 160, child: LinearProgressIndicator(value: _progreso == 0 ? null : _progreso)),
                        const SizedBox(height: 12),
                        Text(_progreso == 0 ? (kIsWeb ? 'Cargando PDF…' : 'Descargando PDF…') : 'Descargando ${(100 * _progreso).round()} %', style: context.textos.bodySmall),
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
}

/// Materiales que el preparador ha compartido para este tema (sobre el PDF,
/// sin robarle sitio): uno se abre directamente; varios, en una hoja.
class _FilaMateriales extends ConsumerWidget {
  const _FilaMateriales({required this.codigo});
  final String codigo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(materialesDeTemaProvider(codigo));
    if (materiales.isEmpty) return const SizedBox.shrink();
    final uno = materiales.length == 1 ? materiales.first : null;
    return Material(
      color: context.colores.primarioPalido,
      child: ListTile(
        dense: true,
        leading: Icon(uno == null ? Icons.folder_shared_outlined : iconoMaterial(uno.tipo), color: context.esquema.primary),
        title: Text(uno == null ? '${materiales.length} materiales de tu preparador' : uno.titulo, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
        subtitle: Text(uno == null ? 'Toca para verlos' : 'De ${uno.preparadorNombre.isEmpty ? 'tu preparador' : uno.preparadorNombre} · ${uno.dominio}', style: context.textos.labelSmall),
        trailing: Icon(uno == null ? Icons.chevron_right : Icons.open_in_new, size: 18),
        onTap: () => uno == null ? mostrarMaterialesDeTema(context, materiales) : abrirUrl(context, uno.url),
      ),
    );
  }
}
