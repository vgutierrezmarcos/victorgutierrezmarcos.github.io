import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

// Lo que cambia entre el móvil y el navegador: guardar ficheros y grabaciones.
export 'plataforma_io.dart' if (dart.library.js_interop) 'plataforma_web.dart';

/// Comparte un texto. En el móvil abre el menú de compartir; en el navegador,
/// donde ese menú no siempre existe, lo copia al portapapeles.
Future<void> compartirTexto(BuildContext context, String texto, {String? asunto}) async {
  if (!kIsWeb) {
    await SharePlus.instance.share(ShareParams(text: texto, subject: asunto));
    return;
  }
  final messenger = ScaffoldMessenger.of(context);
  await Clipboard.setData(ClipboardData(text: texto));
  messenger.showSnackBar(const SnackBar(content: Text('Copiado: pégalo donde quieras enviarlo')));
}
