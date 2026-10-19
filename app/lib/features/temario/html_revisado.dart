/// Adapta la página HTML de un tema revisado (la de la web, con su cabecera,
/// menús, buscador, aviso de cookies y Firebase) para leerla dentro de la app.
///
/// - Quita lo que es de la web: cabecera, menús, migas, pie, botones de
///   descarga (la app tiene los suyos), el párrafo con enlaces al resto de la
///   web y los scripts del sitio (buscador, cookies y Analytics, Firebase).
/// - Añade `<base href>` con la URL del HTML en jsDelivr: los gráficos (SVG) y
///   las hojas de estilo relativas se cargan de ahí con su tipo correcto
///   (raw.githubusercontent.com los serviría como texto y no se verían).
/// - Añade un script que lleva los enlaces internos (#…) al punto de la página
///   sin salir de ella y abre los externos fuera.
///
/// Se queda MathJax (fórmulas), el índice lateral y la licencia.
library;

/// Script del sitio que no se carga en la app (por el final de su ruta).
const _scriptsDeLaWeb = [
  'search-engine.js',
  'search-ui.js',
  'cookie-consent.js',
  'firebase-app.js',
  'firebase-auth.js',
  'firebase-firestore.js',
  'firebase-config.js',
  'auth.js',
  'app-banner.js',
];

const _estilosDeLaWeb = ['search-styles.css', 'cookie-consent.css'];

/// Estilo propio de la app: sin el margen de las páginas de la web y con el
/// índice plegado arriba (en el móvil no cabe al lado).
const _estiloApp = '''
<style id="tcee-app">
  body { margin: 0; }
  .main-content { padding-top: 0.5rem !important; margin-top: 0 !important; }
  .main-content::before { display: none !important; }
  .tema-layout { max-width: 1000px; margin: 0 auto; }
  img, svg { max-width: 100%; height: auto; }
  /* En el móvil nada puede ensanchar la página: fórmulas y tablas largas se
     desplazan por dentro. */
  html, body { overflow-x: hidden; }
  .tema-documento { min-width: 0; overflow-wrap: break-word; }
  mjx-container[display="true"] { display: block; overflow-x: auto; overflow-y: hidden; max-width: 100%; min-width: 0 !important; }
  table { display: block; max-width: 100%; overflow-x: auto; }
  pre { white-space: pre-wrap; }
</style>
''';

/// Enlaces dentro de la app: los #… desplazan la página (con `<base>`, el
/// navegador los tomaría por otra página); los demás se abren fuera.
const _scriptApp = '''
<script id="tcee-app-enlaces">
document.addEventListener('click', function (e) {
  var a = e.target && e.target.closest ? e.target.closest('a[href]') : null;
  if (!a) return;
  var href = a.getAttribute('href') || '';
  if (href.charAt(0) === '#') {
    e.preventDefault();
    var id = decodeURIComponent(href.slice(1));
    var destino = document.getElementById(id) || document.getElementsByName(id)[0];
    if (destino) destino.scrollIntoView({ behavior: 'smooth', block: 'start' });
    return;
  }
  if (/^(https?:|mailto:)/i.test(a.href)) {
    a.setAttribute('target', '_blank');
    a.setAttribute('rel', 'noopener');
  }
}, true);
</script>
''';

/// [urlDocumento]: URL del HTML en jsDelivr (con el nombre del fichero).
String prepararHtmlRevisado(String html, {required String urlDocumento}) {
  var h = html;

  // Bloques de la web (cabecera, menús, migas, pie y botones de descarga).
  h = _quitarElemento(h, RegExp(r'<header\b[^>]*class="[^"]*\bsite-header\b'), 'header');
  h = _quitarElemento(h, RegExp(r'<nav\b[^>]*class="[^"]*\bmain-nav\b'), 'nav');
  h = _quitarElemento(h, RegExp(r'<nav\b[^>]*class="[^"]*\bsub-nav\b'), 'nav');
  h = _quitarElemento(h, RegExp(r'<nav\b[^>]*class="[^"]*\bbreadcrumb\b'), 'nav');
  h = _quitarElemento(h, RegExp(r'<footer\b[^>]*class="[^"]*\bsite-footer\b'), 'footer');
  h = _quitarElemento(h, RegExp(r'<div\b[^>]*class="[^"]*\btema-descargas\b'), 'div');
  h = _quitarElemento(h, RegExp(r'<section\b[^>]*class="[^"]*\btema-oposicion\b'), 'section');

  // Scripts y estilos del sitio.
  h = h.replaceAllMapped(RegExp(r'<script\b[^>]*\bsrc="([^"]*)"[^>]*>\s*</script>', caseSensitive: false), (m) {
    final src = m.group(1)!.split('?').first;
    return _scriptsDeLaWeb.any(src.endsWith) ? '' : m.group(0)!;
  });
  h = h.replaceAllMapped(RegExp(r'<link\b[^>]*>', caseSensitive: false), (m) {
    final l = m.group(0)!;
    final href = RegExp(r'href="([^"]*)"').firstMatch(l)?.group(1) ?? '';
    if (RegExp(r'rel="(canonical|icon)"').hasMatch(l)) return '';
    return _estilosDeLaWeb.any(href.endsWith) ? '' : l;
  });

  // <base> lo primero del <head>, para que valga para todo lo que sigue.
  final base = '<base href="${_atributo(urlDocumento)}">';
  final head = RegExp(r'<head\b[^>]*>', caseSensitive: false).firstMatch(h);
  h = head == null ? '$base$h' : h.replaceRange(head.end, head.end, '\n$base');

  final cierreHead = h.toLowerCase().indexOf('</head>');
  h = cierreHead < 0 ? '$_estiloApp$h' : h.replaceRange(cierreHead, cierreHead, _estiloApp);
  final cierreBody = h.toLowerCase().lastIndexOf('</body>');
  h = cierreBody < 0 ? '$h$_scriptApp' : h.replaceRange(cierreBody, cierreBody, _scriptApp);
  return h;
}

String _atributo(String s) => s.replaceAll('&', '&amp;').replaceAll('"', '&quot;');

/// Quita el primer elemento que empieza donde casa [apertura], hasta su
/// etiqueta de cierre (contando los anidados del mismo [tag]).
String _quitarElemento(String html, RegExp apertura, String tag) {
  final m = apertura.firstMatch(html);
  if (m == null) return html;
  final abre = RegExp('<$tag\\b', caseSensitive: false);
  final cierra = RegExp('</$tag\\s*>', caseSensitive: false);
  var nivel = 0;
  var i = m.start;
  while (i < html.length) {
    final a = _siguiente(abre, html, i);
    final c = _siguiente(cierra, html, i);
    if (c == null) return html; // mal formado: mejor no tocar
    if (a != null && a.start < c.start) {
      nivel++;
      i = a.end;
    } else {
      nivel--;
      i = c.end;
      if (nivel == 0) return html.replaceRange(m.start, i, '');
    }
  }
  return html;
}

Match? _siguiente(RegExp re, String s, int desde) {
  final it = re.allMatches(s, desde).iterator;
  return it.moveNext() ? it.current : null;
}
