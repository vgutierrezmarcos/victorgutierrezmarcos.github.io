import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// El HTML ya preparado (ver `prepararHtmlRevisado`) en un iframe con
/// `srcdoc`: su `<base href>` (la URL del HTML en jsDelivr) resuelve los
/// gráficos y estilos, y el script que lleva dentro mantiene los enlaces #…
/// en la página y abre los externos en otra pestaña.
class VisorHtml extends StatelessWidget {
  const VisorHtml({super.key, required this.html, required this.urlDocumento});
  final String html;
  final String urlDocumento;

  @override
  Widget build(BuildContext context) => HtmlElementView.fromTagName(
        key: ValueKey(html.hashCode),
        tagName: 'iframe',
        onElementCreated: (e) {
          final iframe = e as web.HTMLIFrameElement;
          iframe.style
            ..border = 'none'
            ..width = '100%'
            ..height = '100%'
            ..backgroundColor = 'white';
          iframe.title = 'Tema revisado';
          iframe.srcdoc = html.toJS;
        },
      );
}
