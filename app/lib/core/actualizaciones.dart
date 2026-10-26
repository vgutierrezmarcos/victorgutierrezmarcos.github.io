import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/comunes.dart';
import 'avisos_breves.dart';
import 'avisos_navegador.dart';
import 'instalacion.dart';

// Actualizaciones de la app. Instalada desde Google Play, Play la actualiza
// dentro de la app («actualización flexible»: se descarga mientras se usa y
// se instala al aceptar). Instalada desde el APK, Play no la tiene como suya
// y la actualización dentro de la app falla: entonces se abre su ficha en la
// app de Google Play (misma firma desde el 12 oct. 2026, así que Play ofrece
// «Actualizar» sin desinstalar); tras esa primera vez Play pasa a ser el
// instalador y la actualiza sola. Sin ficha en Play, se abre la descarga.

bool _ofrecida = false;

/// Si hay una actualización en Google Play, la ofrece (una vez por arranque).
/// Con la app instalada desde el APK no pasa nada.
Future<void> comprobarActualizacionDePlay(BuildContext context) async {
  if (kIsWeb || _ofrecida || !defaultTargetPlatform.name.contains('android')) return;
  _ofrecida = true;
  try {
    final info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability != UpdateAvailability.updateAvailable || !info.flexibleUpdateAllowed) return;
    final r = await InAppUpdate.startFlexibleUpdate();
    if (r != AppUpdateResult.success || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.mostrar(SnackBar(
      content: const Text('La versión nueva ya está descargada.'),
      duration: const Duration(seconds: 20),
      action: SnackBarAction(label: 'Instalar', onPressed: () => InAppUpdate.completeFlexibleUpdate().catchError((_) {})),
    ));
  } catch (_) {
    // No viene de Play (APK), sin Play Services o sin red: la tarjeta de Hoy sigue ahí.
  }
}

/// Botón «Actualizar» de la tarjeta de Hoy: por Play si se puede; si no, [url]
/// (la ficha de Google Play se abre en la propia app de Play, con `market://`).
/// En el navegador, recarga la página (con la versión nueva).
Future<void> actualizar(BuildContext context, String? url) async {
  if (kIsWeb) return recargarNavegador();
  if (!kIsWeb && defaultTargetPlatform.name.contains('android')) {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable && info.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
        return;
      }
    } catch (_) {}
    if (esFichaDePlay(url)) {
      try {
        final id = Uri.parse(url!).queryParameters['id'] ?? (await PackageInfo.fromPlatform()).packageName;
        if (await launchUrl(Uri.parse('market://details?id=$id'), mode: LaunchMode.externalApplication)) return;
      } catch (_) {}
    }
  }
  if (context.mounted) abrirUrl(context, url);
}

/// Si [url] es la ficha de la app en Google Play.
bool esFichaDePlay(String? url) => url != null && url.contains('play.google.com/store/apps/details');

/// Textos del aviso de versión nueva de Hoy y de la notificación, según de
/// dónde se instaló la app: desde el APK y con la app ya en Google Play, se
/// pide actualizar desde Play (una vez: después Play la actualiza sola).
({String titulo, String texto, String boton}) textosVersionNueva(String version, OrigenInstalacion origen, {required bool hayPlay}) {
  switch (origen) {
    case OrigenInstalacion.web:
      return (titulo: 'Versión $version disponible', texto: 'Recarga la página para usarla; tus datos están en tu cuenta.', boton: 'Recargar');
    case OrigenInstalacion.apk when hayPlay:
      return (
        titulo: 'La app ya está en Google Play',
        texto: 'Actualízala desde Google Play (versión $version): se instala encima de la actual, sin perder tus datos, y a partir de ahí se actualizará sola.',
        boton: 'Ir a Google Play',
      );
    case OrigenInstalacion.play:
    case OrigenInstalacion.apk:
    case OrigenInstalacion.otro:
      return (titulo: 'Versión $version disponible', texto: 'Se instala encima de la actual, sin perder tus datos.', boton: 'Actualizar');
  }
}
