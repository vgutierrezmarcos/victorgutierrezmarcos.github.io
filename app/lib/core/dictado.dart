import 'dictado_io.dart' if (dart.library.js_interop) 'dictado_web.dart' as impl;

/// Lo que llega del reconocimiento de voz: un texto provisional (lo que va
/// entendiendo), uno definitivo (una frase cerrada), un error que corta el
/// dictado o el aviso de que se ha parado.
enum TipoDictado { parcial, definitivo, error, parado }

class EventoDictado {
  const EventoDictado(this.tipo, {this.texto = '', required this.desde});
  final TipoDictado tipo;
  final String texto;

  /// Cuándo se empezó a decir (para la marca de minuto).
  final DateTime desde;
}

/// Transcripción del cante con el reconocimiento de voz del sistema:
/// `SpeechRecognizer` de Android (canal `…/dictado` de MainActivity.kt, en
/// es-ES, con preferencia por el reconocimiento en el dispositivo y
/// reiniciándose en cada silencio para aguantar todo el cante) o la Web
/// Speech API del navegador (`window.dictadoApp` en web/index.html). Lo
/// reconocido no se guarda en ningún sitio: lo usa Cantar.
abstract class Dictado {
  /// Si esta plataforma tiene dictado (Android o un navegador con Web
  /// Speech API). Si no, el botón «Transcribir» no se enseña.
  bool get posible;

  /// Si el reconocimiento está disponible de verdad en este dispositivo.
  Future<bool> disponible();

  /// Empieza a escuchar y manda cada resultado a [alEvento]. Devuelve un
  /// error legible o null si ha empezado. El permiso del micrófono se pide
  /// antes (en Android, con el de la grabadora).
  Future<String?> empezar(void Function(EventoDictado) alEvento);

  Future<void> parar();
}

Dictado crearDictado() => impl.crearDictado();
