import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Pedir una reseña en Google Play **una sola vez** y solo tras un momento
/// bueno: al tercer momento (un test aprobado, un cante valorado, una clase
/// programada por el preparador, un preparador conectado) Hoy enseña una
/// tarjeta con dos salidas: «Valorar en Google Play» (la ficha, donde se
/// puntúa) y «Enviar una sugerencia» (correo privado). Cualquiera de las dos,
/// o «Ahora no», la cierra para siempre en este dispositivo. Así las mejoras
/// y las quejas llegan por correo y las valoraciones quedan en Play, sin
/// preguntar antes qué le parece la app a nadie (lo que Google no permite).
class Resenas {
  Resenas._();

  static const _claveMomentos = 'resena_momentos';
  static const _claveEstado = 'resena_estado'; // null (sin pedir) · 'pendiente' · 'hecha'
  static const momentosNecesarios = 3;

  static Box? _caja;

  /// Si toca enseñar la tarjeta en Hoy.
  static final pendiente = ValueNotifier<bool>(false);

  static void iniciar(Box caja) {
    _caja = caja;
    pendiente.value = caja.get(_claveEstado) == 'pendiente';
  }

  /// Para las pruebas: sin caja no hace nada.
  @visibleForTesting
  static void reiniciar() {
    _caja = null;
    pendiente.value = false;
  }

  static int get momentos => (_caja?.get(_claveMomentos) as int?) ?? 0;
  static String? get estado => _caja?.get(_claveEstado) as String?;

  /// Un momento bueno. Al tercero, si nunca se ha pedido, queda pendiente.
  static void momento() {
    final caja = _caja;
    if (caja == null || estado != null) return;
    final n = momentos + 1;
    caja.put(_claveMomentos, n);
    if (n >= momentosNecesarios) {
      caja.put(_claveEstado, 'pendiente');
      pendiente.value = true;
    }
  }

  /// Ya se valoró, se escribió o se dijo «ahora no»: no se vuelve a pedir.
  static void resuelta() {
    _caja?.put(_claveEstado, 'hecha');
    pendiente.value = false;
  }
}
