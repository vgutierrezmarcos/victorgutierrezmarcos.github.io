import 'dart:io';

import 'package:flutter/services.dart';

import 'notificaciones.dart';
import 'permisos.dart';

/// Canal con MainActivity.kt: abrir los ajustes del sistema de la app.
const _canal = MethodChannel('es.victorgutierrezmarcos.tcee_app/sistema');

Future<EstadoPermisos> comprobarPermisos() async {
  if (!Platform.isAndroid) return EstadoPermisos(notificaciones: await Notificaciones.activadas());
  bool? bateria;
  try {
    bateria = await _canal.invokeMethod<bool>('ignoraBateria');
  } catch (_) {}
  return EstadoPermisos(notificaciones: await Notificaciones.activadas(), alarmasExactas: await Notificaciones.alarmasExactas(), bateriaSinOptimizar: bateria);
}

/// Abre los ajustes de notificaciones de la app. Devuelve si pudo.
Future<bool> abrirAjustesNotificaciones() async {
  if (!Platform.isAndroid) return false;
  try {
    return await _canal.invokeMethod<bool>('ajustesNotificaciones') ?? false;
  } catch (_) {
    return false;
  }
}

/// Abre los ajustes de optimización de batería (para quitar la app de la
/// lista). No necesita ningún permiso. Devuelve si pudo.
Future<bool> abrirAjustesBateria() async {
  if (!Platform.isAndroid) return false;
  try {
    return await _canal.invokeMethod<bool>('ajustesBateria') ?? false;
  } catch (_) {
    return false;
  }
}

/// Pide el permiso de alarmas exactas (Android 12+ abre sus ajustes).
Future<bool> pedirAlarmasExactas() => Notificaciones.pedirAlarmasExactas();
