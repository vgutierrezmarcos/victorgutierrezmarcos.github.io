import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'dictado.dart';

const _canal = MethodChannel('es.victorgutierrezmarcos.tcee_app/dictado');
const _eventos = EventChannel('es.victorgutierrezmarcos.tcee_app/dictado/eventos');

Dictado crearDictado() => _DictadoAndroid();

/// Android: SpeechRecognizer por el canal propio de MainActivity.kt. En el
/// resto (iOS, escritorio, pruebas) no hay dictado.
class _DictadoAndroid implements Dictado {
  StreamSubscription<dynamic>? _escucha;

  @override
  bool get posible => Platform.isAndroid;

  @override
  Future<bool> disponible() async {
    if (!posible) return false;
    try {
      return await _canal.invokeMethod<bool>('disponible') ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String?> empezar(void Function(EventoDictado) alEvento) async {
    if (!await disponible()) return 'Este móvil no tiene reconocimiento de voz.';
    await _escucha?.cancel();
    _escucha = _eventos.receiveBroadcastStream().listen((e) {
      if (e is! Map) return;
      final tipo = switch (e['tipo']) {
        'parcial' => TipoDictado.parcial,
        'definitivo' => TipoDictado.definitivo,
        'parado' => TipoDictado.parado,
        _ => TipoDictado.error,
      };
      final ms = (e['desde'] as num?)?.toInt();
      alEvento(EventoDictado(tipo, texto: (e['texto'] as String?) ?? '', desde: ms == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(ms)));
    }, onError: (Object e) => alEvento(EventoDictado(TipoDictado.error, texto: '$e', desde: DateTime.now())));
    try {
      await _canal.invokeMethod<void>('empezar', {'idioma': 'es-ES'});
      return null;
    } on PlatformException catch (e) {
      await _escucha?.cancel();
      _escucha = null;
      return e.message ?? 'No se ha podido empezar a transcribir.';
    } catch (_) {
      await _escucha?.cancel();
      _escucha = null;
      return 'No se ha podido empezar a transcribir.';
    }
  }

  @override
  Future<void> parar() async {
    try {
      await _canal.invokeMethod<void>('parar');
    } catch (_) {}
    await _escucha?.cancel();
    _escucha = null;
  }
}
