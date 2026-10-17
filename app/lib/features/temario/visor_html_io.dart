import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// El HTML ya preparado (ver `prepararHtmlRevisado`) en un WebView. Se carga
/// con [urlDocumento] (la del HTML en jsDelivr) como dirección base: así los
/// gráficos y estilos relativos se piden a jsDelivr y los enlaces #… se quedan
/// en la página. Cualquier otra navegación se abre fuera de la app.
class VisorHtml extends StatefulWidget {
  const VisorHtml({super.key, required this.html, required this.urlDocumento});
  final String html;
  final String urlDocumento;
  @override
  State<VisorHtml> createState() => _VisorHtmlState();
}

class _VisorHtmlState extends State<VisorHtml> {
  late final WebViewController _controlador;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _controlador = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) {
          if (mounted) setState(() => _cargando = false);
        },
        onNavigationRequest: (peticion) {
          final url = peticion.url;
          // La propia página (y sus #…) se queda; lo demás, fuera.
          if (url.startsWith('about:') || url.startsWith('data:') || url.split('#').first == widget.urlDocumento) {
            return NavigationDecision.navigate;
          }
          final uri = Uri.tryParse(url);
          if (uri != null && (uri.scheme == 'https' || uri.scheme == 'http' || uri.scheme == 'mailto')) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
          }
          return NavigationDecision.prevent;
        },
      ))
      ..loadHtmlString(widget.html, baseUrl: widget.urlDocumento);
  }

  @override
  Widget build(BuildContext context) => Stack(children: [
        WebViewWidget(controller: _controlador),
        if (_cargando) const LinearProgressIndicator(minHeight: 2),
      ]);
}
