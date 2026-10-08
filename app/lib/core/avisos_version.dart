import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data/models/oposicion.dart';
import '../data/models/temario.dart';
import 'notificaciones.dart';
import 'vistos.dart';

// Versiones de las que ya se ha avisado (fichero, como los avisos de la red,
// porque también lo usa la comprobación en segundo plano).
const _vistos = 'version_avisada';

/// Comprueba si hay una versión nueva de la app publicada (app-config.json de
/// TCEE, que es de donde sale la app aunque se prepare otra oposición) y avisa
/// una sola vez por versión. Devuelve la versión nueva, o null.
Future<String?> comprobarVersion({Map<String, dynamic>? json, String? instalada}) async {
  try {
    final j = json ??
        Map<String, dynamic>.from(jsonDecode((await Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 30), responseType: ResponseType.plain))
                .get<String>(Oposiciones.tcee.urlAppConfig))
            .data!) as Map);
    final config = AppConfig.fromJson(j);
    final publicada = config.versionActual;
    if (publicada == null) return null;
    final actual = instalada ?? (await PackageInfo.fromPlatform()).version;
    if (!AppConfig.esPosterior(publicada, actual)) return null;
    final vistos = await leerVistos(lista: _vistos);
    if (vistos.contains(publicada)) return publicada;
    final url = config.urlPlayStore ?? config.urlApk;
    if (url != null && Notificaciones.disponibles) {
      await Notificaciones.avisoVersion(publicada, url);
      await guardarVistos({...vistos, publicada}, lista: _vistos, maximo: 20);
    }
    return publicada;
  } catch (_) {
    return null;
  }
}
