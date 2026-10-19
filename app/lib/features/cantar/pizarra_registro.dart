import 'package:flutter/foundation.dart';

/// Un evento de puntero tal como lo ve el navegador, antes de que lo toque el
/// motor de Flutter (en el móvil no hay ninguno).
class EventoDom {
  const EventoDom({
    required this.tipo,
    required this.puntero,
    this.id = 0,
    this.botones = 0,
    this.presion = 0,
    this.x = 0,
    this.y = 0,
    this.ts = 0,
    this.primario = true,
    this.objetivo = '',
    this.toques = 0,
    this.tipoToque = '',
  });

  /// pointerdown, pointermove, pointerup, pointercancel, pointerleave,
  /// pointerout, touchstart, touchmove, touchend o touchcancel.
  final String tipo;

  /// pen, touch o mouse (vacío en los touch*).
  final String puntero;
  final int id;
  final int botones;
  final double presion;
  final double x;
  final double y;

  /// `event.timeStamp` del navegador, en ms (el mismo reloj que `timeStamp`
  /// de los eventos de Flutter).
  final double ts;
  final bool primario;

  /// Etiqueta del elemento que lo recibió (FLUTTER-VIEW, FLT-SEMANTICS…).
  final String objetivo;

  /// En los touch*: dedos en pantalla y `touchType` del primero (en Safari,
  /// `stylus` con el Apple Pencil).
  final int toques;
  final String tipoToque;

  bool get esLapiz => puntero == 'pen' || tipoToque == 'stylus';
  bool get esPuntero => tipo.startsWith('pointer');

  String get linea => esPuntero
      ? '$tipo $puntero id=$id b=$botones p=${presion.toStringAsFixed(2)} x=${x.toStringAsFixed(1)} y=${y.toStringAsFixed(1)} prim=${primario ? 1 : 0} ts=${ts.toStringAsFixed(1)} tgt=$objetivo'
      : '$tipo n=$toques $tipoToque x=${x.toStringAsFixed(1)} y=${y.toStringAsFixed(1)} ts=${ts.toStringAsFixed(1)} tgt=$objetivo';
}

/// Registro de lo que pasa en la pizarra (apagado salvo que se pida): cada
/// evento del navegador y de Flutter, lo que decide la lógica y lo que tarda.
/// Sirve para que un tester lo copie y lo mande cuando el lápiz falla en un
/// aparato que no tenemos a mano.
class RegistroPizarra {
  RegistroPizarra({this.maximo = 3000});

  final int maximo;
  final List<String> _lineas = [];
  final Stopwatch _reloj = Stopwatch()..start();
  bool activo = false;

  int get lineas => _lineas.length;

  /// [origen]: DOM (navegador), FL (evento de Flutter), LOG (decisión), MED
  /// (medida) o FR (fotograma lento).
  void anotar(String origen, String texto) {
    if (!activo) return;
    if (_lineas.length >= maximo) _lineas.removeAt(0);
    _lineas.add('t=${(_reloj.elapsedMicroseconds / 1000).toStringAsFixed(1)} $origen $texto');
  }

  String volcar({String cabecera = ''}) => [if (cabecera.isNotEmpty) cabecera, ..._lineas].join('\n');

  void vaciar() => _lineas.clear();
}

/// Con `?depurar=1` en la dirección (antes del `#`) la pizarra registra los
/// eventos del lápiz y muestra «Copiar registro».
bool get depuracionPedidaEnUrl => kIsWeb && Uri.base.queryParameters['depurar'] == '1';

/// Con `?sinparche=1` se desactiva el parche contra Scribble, para comparar.
bool get parcheScribblePedido => !kIsWeb || Uri.base.queryParameters['sinparche'] != '1';

/// Un lápiz apoyado manda un punto cada 8-16 ms. Si entre dos puntos del
/// mismo trazo pasan [pausaCorteLapiz] y además el lápiz ha saltado
/// [saltoCorteLapiz] píxeles, no es un trazo: el navegador se ha tragado el
/// levantar y el apoyar siguientes (en el iPad, Scribble) y el motor de
/// Flutter ha unido dos letras con una raya. Se corta y empieza otro trazo.
const Duration pausaCorteLapiz = Duration(milliseconds: 80);
const double saltoCorteLapiz = 20;

bool cortaTrazoLapiz(Duration pausa, double saltoPx) => pausa >= pausaCorteLapiz && saltoPx >= saltoCorteLapiz;
