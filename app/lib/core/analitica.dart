import 'dart:async';

import 'package:flutter/foundation.dart';

import 'analitica_io.dart' if (dart.library.js_interop) 'analitica_web.dart' as impl;

/// Estadísticas de uso anónimas (Firebase Analytics) e informes de errores
/// (Crashlytics), **solo si el usuario lo activa** (Más → Ajustes). Mientras
/// no diga que sí, no se envía nada: en Android la recogida está apagada en
/// el manifiesto y aquí se enciende o apaga en cada arranque según el ajuste.
///
/// Nunca lleva datos personales: ni nombre, ni correo, ni temas, ni tests, ni
/// cantes. Solo pantallas, seis eventos con números (`evento`) y tres
/// propiedades (oposición, papel y de dónde se instaló).
///
/// [instancia] es lo que usa la app: [AnaliticaNula] (nada) hasta que `main`
/// la sustituye por la de Firebase, y la que pongan las pruebas.
abstract class Analitica {
  static Analitica instancia = AnaliticaNula();

  /// Si en esta compilación se puede medir algo (Firebase y, en el navegador,
  /// un `measurementId`). Si no, ni se pregunta ni sale el interruptor.
  bool get disponible;

  /// Si el usuario lo tiene activado ahora mismo.
  bool get activa;

  /// Al arrancar: [activo] es el ajuste guardado (null = aún no ha contestado,
  /// que cuenta como no).
  Future<void> iniciar(bool? activo);

  /// Al cambiar el interruptor.
  Future<void> activar(bool activo);

  /// Pantalla vista (ruta sin identificadores: `/hoy`, `/estudiar`, `/tema`).
  void pantalla(String nombre);

  /// Un evento con parámetros numéricos o de pocas palabras (nunca personales).
  void evento(String nombre, {Map<String, Object> parametros = const {}});

  /// Propiedades del usuario: la oposición (tcee/dce), el papel
  /// (opositor/preparador) y de dónde se instaló la app (play/apk/web), para
  /// contar cuántos vienen de Google Play aunque empezaran con el APK.
  void usuario({String? oposicion, String? papel, String? instalacion});

  /// Un error no capturado (lo envía Crashlytics si está activo).
  void error(Object excepcion, StackTrace? pila, {bool fatal = false});

  /// Engancha los errores de Flutter y de la plataforma sin quitar lo que ya
  /// hubiera (la pantalla de error sigue saliendo: la pone `ErrorWidget.builder`).
  void instalarErrores() {
    final anterior = FlutterError.onError;
    FlutterError.onError = (detalles) {
      (anterior ?? FlutterError.presentError)(detalles);
      error(detalles.exception, detalles.stack);
    };
    final previo = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (e, pila) {
      error(e, pila, fatal: true);
      return previo?.call(e, pila) ?? false;
    };
  }

  /// La de Firebase, si esta compilación la tiene; si no, la nula.
  static Analitica crear({required bool firebaseDisponible}) => firebaseDisponible ? impl.crearAnalitica() : AnaliticaNula();

  /// Nombre de pantalla a partir de una ruta: sin consulta ni identificadores
  /// (los segmentos con números o muy largos se sustituyen por «_»).
  static String nombreDePantalla(String ruta) {
    final partes = Uri.parse(ruta).path.split('/').where((s) => s.isNotEmpty).map((s) => RegExp(r'\d').hasMatch(s) || s.length > 24 ? '_' : s);
    return '/${partes.join('/')}';
  }
}

/// No mide nada: sin Firebase, en el navegador sin `measurementId` y en las pruebas.
class AnaliticaNula extends Analitica {
  @override
  bool get disponible => false;
  @override
  bool get activa => false;
  @override
  Future<void> iniciar(bool? activo) async {}
  @override
  Future<void> activar(bool activo) async {}
  @override
  void pantalla(String nombre) {}
  @override
  void evento(String nombre, {Map<String, Object> parametros = const {}}) {}
  @override
  void usuario({String? oposicion, String? papel, String? instalacion}) {}
  @override
  void error(Object excepcion, StackTrace? pila, {bool fatal = false}) {}
}
