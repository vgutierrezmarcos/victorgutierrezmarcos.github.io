/// Reloj de un cante con dos fases: esquema (opcional) y exposición.
/// Se basa en la hora del sistema, no en contar ticks, para que siga siendo
/// exacto aunque la app pase a segundo plano. Lógica pura (testeable).
///
/// Su estado cabe en un mapa ([aJson] / [RelojCante.desdeJson]) para poder
/// compartirlo con el preparador: dos dispositivos con el mismo estado marcan
/// lo mismo.
class RelojCante {
  RelojCante({this.preparacion = Duration.zero, required this.exposicion});

  /// Tiempo para hacer el esquema de los temas antes de exponer.
  Duration preparacion;
  Duration exposicion;

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

  /// Más tiempo para la fase en curso (el esquema o la exposición).
  void ampliarFase(DateTime ahora, Duration extra) {
    if (enPreparacion(ahora)) {
      preparacion += extra;
    } else {
      // Si ya había terminado, se retoma desde el final.
      if (terminado(ahora) && !corriendo) _acumulado = total;
      exposicion += extra;
    }
  }

  /// Termina el esquema ya y empieza la exposición (con todo su tiempo).
  void saltarFase(DateTime ahora) {
    if (!enPreparacion(ahora)) return;
    preparacion = transcurrido(ahora);
  }

  /// Cuántos hitos han pasado ya (para no repetir sus avisos).
  int hitosPasados(DateTime ahora) {
    final t = transcurrido(ahora);
    return hitos.where((h) => h.en <= t).length;
  }

  /// Momentos (desde el inicio) en los que hay que avisar.
  List<({Duration en, String texto, bool fin})> get hitos {
    final out = <({Duration en, String texto, bool fin})>[];
    if (preparacion > Duration.zero) {
      out.add((en: preparacion, texto: 'Fin del esquema. Empieza la exposición.', fin: false));
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

  /// Estado completo. [ahora] fija el tiempo acumulado en ese instante; si
  /// corre, `desde` es ese instante (cada dispositivo lo traduce a su reloj).
  Map<String, dynamic> aJson(DateTime ahora) => {
        'esquema': preparacion.inSeconds,
        'exposicion': exposicion.inSeconds,
        'acumulado': transcurrido(ahora).inMilliseconds,
        'corriendo': corriendo,
      };

  /// Reloj con el estado de [j], que se guardó en [guardado] (hora local ya
  /// corregida del desfase con el otro dispositivo).
  factory RelojCante.desdeJson(Map<String, dynamic> j, {required DateTime guardado}) {
    final r = RelojCante(
      preparacion: Duration(seconds: (j['esquema'] as num?)?.toInt() ?? 0),
      exposicion: Duration(seconds: (j['exposicion'] as num?)?.toInt() ?? 30 * 60),
    );
    r._acumulado = Duration(milliseconds: (j['acumulado'] as num?)?.toInt() ?? 0);
    if (j['corriendo'] == true) r._desde = guardado;
    return r;
  }
}
