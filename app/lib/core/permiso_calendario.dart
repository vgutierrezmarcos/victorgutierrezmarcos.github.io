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

/// El cliente del calendario para el preparador de una oposición.
CalendarioGoogle crearCalendario() => CalendarioGoogle(
      token: tokenCalendario,
      huellas: Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null,
    );
