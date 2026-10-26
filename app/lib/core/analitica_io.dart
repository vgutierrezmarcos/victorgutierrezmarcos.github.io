import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'analitica.dart';

Analitica crearAnalitica() => _AnaliticaFirebase();

/// Android e iOS: Analytics y Crashlytics. Todo apagado hasta que el usuario
/// lo activa (el manifiesto lleva la recogida desactivada).
class _AnaliticaFirebase extends Analitica {
  bool _activa = false;

  @override
  bool get disponible => true;
  @override
  bool get activa => _activa;

  @override
  Future<void> iniciar(bool? activo) => activar(activo ?? false);

  @override
  Future<void> activar(bool activo) async {
    _activa = activo;
    try {
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(activo);
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(activo);
    } catch (e) {
      debugPrint('Analítica no disponible: $e');
    }
  }

  @override
  void pantalla(String nombre) {
    if (!_activa) return;
    unawaited(FirebaseAnalytics.instance.logScreenView(screenName: nombre).catchError((_) {}));
  }

  @override
  void evento(String nombre, {Map<String, Object> parametros = const {}}) {
    if (!_activa) return;
    unawaited(FirebaseAnalytics.instance.logEvent(name: nombre, parameters: parametros).catchError((_) {}));
  }

  @override
  void usuario({String? oposicion, String? papel, String? instalacion}) {
    if (!_activa) return;
    final a = FirebaseAnalytics.instance;
    if (oposicion != null) unawaited(a.setUserProperty(name: 'oposicion', value: oposicion).catchError((_) {}));
    if (papel != null) unawaited(a.setUserProperty(name: 'papel', value: papel).catchError((_) {}));
    if (instalacion != null) unawaited(a.setUserProperty(name: 'instalacion', value: instalacion).catchError((_) {}));
  }

  @override
  void error(Object excepcion, StackTrace? pila, {bool fatal = false}) {
    if (!_activa) return;
    unawaited(FirebaseCrashlytics.instance.recordError(excepcion, pila, fatal: fatal).catchError((_) {}));
  }
}
