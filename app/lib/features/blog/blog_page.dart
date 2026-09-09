import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../data/models/articulo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

class BlogPage extends ConsumerStatefulWidget {
  const BlogPage({super.key});
  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  Box? _favoritos;
  bool _soloFavoritos = false;

  @override
  void initState() {
    super.initState();
    Hive.openBox(Cajas.favoritosBlog).then((b) => setState(() => _favoritos = b));
  }

  @override
  Widget build(BuildContext context) {
    final articulos = ref.watch(articulosProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          IconButton(
            tooltip: 'Favoritos',
            icon: Icon(_soloFavoritos ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => setState(() => _soloFavoritos = !_soloFavoritos),
          ),
          IconButton(tooltip: 'Newsletter', icon: const Icon(Icons.mail_outline), onPressed: () => abrirUrl(context, '${Urls.base}/blog/index.html', enApp: true)),
        ],
      ),
      body: articulos.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(articulosProvider)),
        data: (lista) {
          final filtrada = _soloFavoritos ? lista.where((a) => _favoritos?.containsKey(a.guid) ?? false).toList() : lista;
          if (filtrada.isEmpty) return Center(child: Text(_soloFavoritos ? 'Sin favoritos todavía.' : 'No hay artículos.', style: context.textos.bodySmall));
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(articulosProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtrada.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final a = filtrada[i];
                final fav = _favoritos?.containsKey(a.guid) ?? false;
                return Tarjeta(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ArticuloPage(articulo: a))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text(a.titulo, style: context.textos.titleMedium)),
                      IconButton(
                        icon: Icon(fav ? Icons.bookmark : Icons.bookmark_border, color: fav ? context.colores.dorado : null),
                        onPressed: () async {
                          fav ? await _favoritos?.delete(a.guid) : await _favoritos?.put(a.guid, true);
                          setState(() {});
                        },
                      ),
                    ]),
                    if (a.fecha != null) Text(DateFormat('d MMMM y', 'es').format(a.fecha!), style: context.textos.labelSmall),
                    const SizedBox(height: 6),
                    Text(a.descripcion.replaceAll(RegExp(r'<[^>]+>'), ''), maxLines: 3, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
                  ]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ArticuloPage extends StatefulWidget {
  const ArticuloPage({super.key, required this.articulo});
  final Articulo articulo;
  @override
  State<ArticuloPage> createState() => _ArticuloPageState();
}

class _ArticuloPageState extends State<ArticuloPage> {
  late final WebViewController _ctrl;
  int _progreso = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (p) => setState(() => _progreso = p),
        onNavigationRequest: (r) {
          // Los enlaces externos se abren fuera de la app.
          if (!r.url.startsWith(Urls.base) && !r.url.contains('victorgutierrezmarcos.es')) {
            abrirUrl(context, r.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.articulo.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articulo.titulo, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(icon: const Icon(Icons.picture_as_pdf_outlined), tooltip: 'PDF', onPressed: () => abrirUrl(context, widget.articulo.urlPdf)),
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () => Share.share('${widget.articulo.titulo}\n${widget.articulo.url}')),
        ],
        bottom: _progreso < 100 ? PreferredSize(preferredSize: const Size.fromHeight(2), child: LinearProgressIndicator(value: _progreso / 100, minHeight: 2)) : null,
      ),
      body: WebViewWidget(controller: _ctrl),
    );
  }
}
