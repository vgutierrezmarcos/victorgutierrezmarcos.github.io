import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

import '../widgets/comunes.dart';
import 'avisos_navegador.dart';

// Actualizaciones de la app. Instalada desde Google Play, Play la actualiza
// dentro de la app («actualización flexible»: se descarga mientras se usa y
// se instala al aceptar). Instalada desde el APK, Play no la conoce y se
// abre la descarga.

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
    messenger.showSnackBar(SnackBar(
      content: const Text('La versión nueva ya está descargada.'),
      duration: const Duration(seconds: 20),
      action: SnackBarAction(label: 'Instalar', onPressed: () => InAppUpdate.completeFlexibleUpdate().catchError((_) {})),
    ));
  } catch (_) {
    // No viene de Play (APK), sin Play Services o sin red: la tarjeta de Hoy sigue ahí.
  }
}

/// Botón «Actualizar» de la tarjeta de Hoy: por Play si se puede; si no, [url].
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
  }
  if (context.mounted) abrirUrl(context, url);
}
