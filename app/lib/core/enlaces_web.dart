import 'package:web/web.dart' as web;

/// La dirección con la que se ha abierto la app web (`/app/abrir/?codigo=…`).
/// Si lleva una invitación, se limpia de la barra del navegador para que no
/// se repita al recargar.
Future<Uri?> enlaceInicial() async {
  final uri = Uri.base;
  if (uri.queryParameters.isEmpty) return null;
  try {
    if (uri.queryParameters.containsKey('codigo')) {
      final limpia = uri.replace(queryParameters: {}).toString().replaceFirst(RegExp(r'\?$'), '');
      web.window.history.replaceState(null, '', limpia);
    }
  } catch (_) {}
  return uri;
}

/// En el navegador no llegan enlaces con la app abierta: se abre otra pestaña.
Stream<Uri> enlacesEntrantes() => const Stream.empty();

/// Solo existe en Android.
Future<String?> referrerInstalacion() async => null;
