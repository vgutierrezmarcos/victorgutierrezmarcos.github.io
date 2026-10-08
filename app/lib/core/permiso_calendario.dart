import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/repos/calendario_google.dart';
import 'constants.dart';

/// Google Calendar, de momento solo en la app del móvil (en el navegador el
/// permiso de Google dura una hora y no se puede renovar sin la ventana).
bool get calendarioDisponible => !kIsWeb;

/// Token de Google con el permiso del calendario, sin pedir nada al usuario
/// (null si no lo ha dado o no hay sesión de Google en el móvil).
Future<String?> tokenCalendario() async {
  if (!calendarioDisponible) return null;
  try {
    final cuenta = await GoogleSignIn(scopes: const ['email', ambitoCalendario]).signInSilently();
    return (await cuenta?.authentication)?.accessToken;
  } catch (_) {
    return null;
  }
}

/// Pide a Google el permiso del calendario (la ventana de Google). Devuelve
/// si lo ha dado.
Future<bool> pedirPermisoCalendario() async {
  if (!calendarioDisponible) return false;
  try {
    final google = GoogleSignIn(scopes: const ['email']);
    final cuenta = await google.signInSilently() ?? await google.signIn();
    if (cuenta == null) return false;
    return await google.requestScopes(const [ambitoCalendario]);
  } catch (_) {
    return false;
  }
}

/// Vuelve a pedir el permiso desde cero: cierra la sesión de Google de la app
/// (solo la caché local de Play Services; la sesión de la app sigue), vuelve
/// a entrar y pide el permiso. Hace falta cuando el usuario ha retirado el
/// acceso en su cuenta de Google: Play Services sigue creyendo que lo tiene
/// (y da un token ya revocado, que Google rechaza con 401) hasta que caduca.
Future<bool> renovarPermisoCalendario() async {
  if (!calendarioDisponible) return false;
  try {
    final google = GoogleSignIn(scopes: const ['email']);
    await google.signOut();
    final cuenta = await google.signIn();
    if (cuenta == null) return false;
    return await google.requestScopes(const [ambitoCalendario]);
  } catch (_) {
    return false;
  }
}

/// Si el error de Google es que el token ya no vale (permiso retirado o
/// caducado): hay que volver a pedirlo.
bool permisoRetirado(Object e) => e is DioException && (e.response?.statusCode == 401 || e.response?.statusCode == 403);

/// El cliente del calendario para el preparador de una oposición.
CalendarioGoogle crearCalendario() => CalendarioGoogle(
      token: tokenCalendario,
      huellas: Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null,
    );
