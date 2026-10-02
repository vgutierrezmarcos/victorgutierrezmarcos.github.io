/// Reloj de un cante con dos fases: preparación (opcional) y exposición.
/// Se basa en la hora del sistema, no en contar ticks, para que siga siendo
/// exacto aunque la app pase a segundo plano. Lógica pura (testeable).
class RelojCante {
  RelojCante({this.preparacion = Duration.zero, required this.exposicion});

  final Duration preparacion;
  final Duration exposicion;

  DateTime? _desde;
  Duration _acumulado = Duration.zero;

  Duration get total => preparacion + exposicion;
  bool get corriendo => _desde != null;
  bool get empezado => corriendo || _acumulado > Duration.zero;

  /// Tiempo transcurrido desde el inicio, sin pasar del total.
  Duration transcurrido(DateTime ahora) {
    final t = _acumulado + (_desde == null ? Duration.zero : ahora.difference(_desde!));
    return t > total ? total : t;
  }

  bool terminado(DateTime ahora) => transcurrido(ahora) >= total;
  bool enPreparacion(DateTime ahora) => transcurrido(ahora) < preparacion;

  /// Tiempo que queda de la fase en curso.
  Duration restanteFase(DateTime ahora) {
    final t = transcurrido(ahora);
    return t < preparacion ? preparacion - t : total - t;
  }

  /// Avance de la fase en curso (0-1).
  double progresoFase(DateTime ahora) {
    final t = transcurrido(ahora);
    if (t < preparacion) return t.inMilliseconds / preparacion.inMilliseconds;
    return exposicion.inMilliseconds == 0 ? 1 : (t - preparacion).inMilliseconds / exposicion.inMilliseconds;
  }

  /// Tiempo de exposición consumido (lo que se anota en el diario).
  Duration expuesto(DateTime ahora) {
    final t = transcurrido(ahora) - preparacion;
    return t.isNegative ? Duration.zero : t;
  }

  void iniciar(DateTime ahora) {
    if (terminado(ahora)) return;
    _desde ??= ahora;
  }

  void pausar(DateTime ahora) {
    _acumulado = transcurrido(ahora);
    _desde = null;
  }

  void reiniciar() {
    _acumulado = Duration.zero;
    _desde = null;
  }

  /// Momentos (desde el inicio) en los que hay que avisar.
  List<({Duration en, String texto, bool fin})> get hitos {
    final out = <({Duration en, String texto, bool fin})>[];
    if (preparacion > Duration.zero) {
      out.add((en: preparacion, texto: 'Fin de la preparación. Empieza la exposición.', fin: false));
    }
    if (exposicion >= const Duration(minutes: 4)) {
      out.add((en: preparacion + exposicion ~/ 2, texto: 'Mitad del tiempo de exposición.', fin: false));
    }
    if (exposicion > const Duration(minutes: 2)) {
      out.add((en: total - const Duration(minutes: 1), texto: 'Queda 1 minuto.', fin: false));
    }
    out.add((en: total, texto: '¡Tiempo! Se han cumplido los ${exposicion.inMinutes} minutos.', fin: true));
    return out;
  }

  /// Hitos que aún no han llegado, con su hora prevista (para programar avisos).
  List<({DateTime cuando, String texto})> avisosPendientes(DateTime ahora) {
    final t = transcurrido(ahora);
    return [for (final h in hitos) if (h.en > t) (cuando: ahora.add(h.en - t), texto: h.texto)];
  }
}
