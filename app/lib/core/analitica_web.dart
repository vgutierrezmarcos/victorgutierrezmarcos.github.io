import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'analitica.dart';
import 'firebase_web.dart';

/// Navegador: solo Analytics, y solo si hay `measurementId` (Crashlytics no
/// existe en la web).
Analitica crearAnalitica() => measurementIdWeb == null ? AnaliticaNula() : _AnaliticaWeb();

class _AnaliticaWeb extends Analitica {
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
  void usuario({String? oposicion, String? papel}) {
    if (!_activa) return;
    final a = FirebaseAnalytics.instance;
    if (oposicion != null) unawaited(a.setUserProperty(name: 'oposicion', value: oposicion).catchError((_) {}));
    if (papel != null) unawaited(a.setUserProperty(name: 'papel', value: papel).catchError((_) {}));
  }

  @override
  void error(Object excepcion, StackTrace? pila, {bool fatal = false}) {}
}
