import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// De dónde viene esta instalación de la app.
enum OrigenInstalacion {
  /// Instalada (o actualizada por última vez) desde Google Play: Play la
  /// actualiza sola y dentro de la app.
  play,

  /// Instalada con el APK de la web (o con cualquier instalador que no sea
  /// Play): Play no la actualiza hasta que se actualice una vez desde allí.
  apk,

  /// En el navegador.
  web,

  /// Otras plataformas o no se ha podido saber.
  otro,
}

OrigenInstalacion? _origen;

/// Lee una vez el instalador que anotó Android (`com.android.vending` es
/// Google Play) y lo recuerda.
Future<OrigenInstalacion> origenInstalacion() async {
  if (_origen != null) return _origen!;
  if (kIsWeb) return _origen = OrigenInstalacion.web;
  try {
    final tienda = (await PackageInfo.fromPlatform()).installerStore;
    if (defaultTargetPlatform == TargetPlatform.android) {
      _origen = tienda == 'com.android.vending' ? OrigenInstalacion.play : OrigenInstalacion.apk;
    } else {
      _origen = OrigenInstalacion.otro;
    }
  } catch (_) {
    _origen = OrigenInstalacion.otro;
  }
  return _origen!;
}

/// Para las pruebas: fija el origen (null vuelve a leerlo).
@visibleForTesting
void fijarOrigenInstalacion(OrigenInstalacion? origen) => _origen = origen;
