import 'dart:js_interop';

import 'dictado.dart';

@JS('dictadoApp')
external _DictadoApp? get _dictadoApp;

extension type _DictadoApp._(JSObject _) implements JSObject {
  external bool admite();
  external void empezar(String idioma, JSFunction alEvento);
  external void parar();
}

Dictado crearDictado() => _DictadoWeb();

/// Navegador: la Web Speech API (`SpeechRecognition`), envuelta en
/// `window.dictadoApp` (web/index.html). Chrome y Edge la tienen; Firefox no,
/// y entonces no se enseña «Transcribir».
class _DictadoWeb implements Dictado {
  @override
  bool get posible {
    try {
      return _dictadoApp?.admite() ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> disponible() async => posible;

  @override
  Future<String?> empezar(void Function(EventoDictado) alEvento) async {
    final d = _dictadoApp;
    if (d == null || !posible) return 'Este navegador no tiene reconocimiento de voz (prueba con Chrome o Edge).';
    try {
      d.empezar(
        'es-ES',
        ((JSString tipo, JSString texto, JSNumber desde) {
          final t = switch (tipo.toDart) {
            'parcial' => TipoDictado.parcial,
            'definitivo' => TipoDictado.definitivo,
            'parado' => TipoDictado.parado,
            _ => TipoDictado.error,
          };
          alEvento(EventoDictado(t, texto: texto.toDart, desde: DateTime.fromMillisecondsSinceEpoch(desde.toDartDouble.round())));
        }).toJS,
      );
      return null;
    } catch (_) {
      return 'No se ha podido empezar a transcribir.';
    }
  }

  @override
  Future<void> parar() async {
    try {
      _dictadoApp?.parar();
    } catch (_) {}
  }
}
