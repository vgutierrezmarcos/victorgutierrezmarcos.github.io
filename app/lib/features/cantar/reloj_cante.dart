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

  /// Si ya se ha empezado la exposición. Al acabar el esquema el reloj no
  /// pasa solo a la exposición: se queda esperando a que se empiece
  /// ([empezarExposicion]). Sin esquema, la exposición va desde el principio.
  bool exposicionEmpezada = false;
  bool get _enExposicion => exposicionEmpezada || preparacion == Duration.zero;

  Duration get total => preparacion + exposicion;
  bool get corriendo => _desde != null;
  bool get empezado => corriendo || _acumulado > Duration.zero;

  Duration _bruto(DateTime ahora) => _acumulado + (_desde == null ? Duration.zero : ahora.difference(_desde!));

  /// Tiempo transcurrido desde el inicio. Mientras no se empieza la
  /// exposición se queda en el final del esquema. Pasado el total sigue
  /// contando (ver [exceso]).
  Duration transcurrido(DateTime ahora) {
    final t = _bruto(ahora);
    return !_enExposicion && t > preparacion ? preparacion : t;
  }

  /// Acabado el esquema, a la espera de que se empiece la exposición.
  bool esperandoExposicion(DateTime ahora) => !_enExposicion && _bruto(ahora) >= preparacion;

  bool terminado(DateTime ahora) => _enExposicion && transcurrido(ahora) >= total;
  bool enPreparacion(DateTime ahora) => !_enExposicion && transcurrido(ahora) < preparacion;

  /// Tiempo pasado del de la exposición (sigue contando al cumplirse).
  Duration exceso(DateTime ahora) {
    final t = transcurrido(ahora) - total;
    return _enExposicion && t > Duration.zero ? t : Duration.zero;
  }

  /// Tiempo que queda de la fase en curso (0 al cumplirse).
  Duration restanteFase(DateTime ahora) {
    final t = transcurrido(ahora);
    if (!_enExposicion) return t < preparacion ? preparacion - t : exposicion;
    return t < total ? total - t : Duration.zero;
  }

  /// Tiempo que va de la fase en curso (para el modo cronómetro).
  Duration transcurridoFase(DateTime ahora) {
    final t = transcurrido(ahora);
    if (!_enExposicion) return t < preparacion ? t : Duration.zero;
    return t - preparacion;
  }

  /// Avance de la fase en curso (0-1).
  double progresoFase(DateTime ahora) {
    final t = transcurrido(ahora);
    if (!_enExposicion) return t < preparacion ? t.inMilliseconds / preparacion.inMilliseconds : 0;
    if (exposicion.inMilliseconds == 0) return 1;
    return ((t - preparacion).inMilliseconds / exposicion.inMilliseconds).clamp(0.0, 1.0);
  }

  /// Tiempo de exposición consumido (lo que se anota en el diario), con lo
  /// que se haya pasado.
  Duration expuesto(DateTime ahora) {
    final t = transcurrido(ahora) - preparacion;
    return t.isNegative || !_enExposicion ? Duration.zero : t;
  }

  void iniciar(DateTime ahora) => _desde ??= ahora;

  void pausar(DateTime ahora) {
    _acumulado = transcurrido(ahora);
    _desde = null;
  }

  void reiniciar() {
    _acumulado = Duration.zero;
    _desde = null;
    exposicionEmpezada = false;
  }

  /// Empieza la exposición ya (al acabar el esquema, o cortándolo).
  void empezarExposicion(DateTime ahora) {
    if (enPreparacion(ahora)) preparacion = transcurrido(ahora);
    _acumulado = preparacion;
    _desde = ahora;
    exposicionEmpezada = true;
  }

  /// Vuelve a dejar la exposición preparada, sin empezar y con el esquema hecho.
  void reiniciarExposicion() {
    _acumulado = preparacion;
    _desde = null;
    exposicionEmpezada = false;
  }

  /// Más (o menos, con [extra] negativo) tiempo para la fase en curso: el
  /// esquema o la exposición. Nunca por debajo de lo que ya va ni de 1 minuto.
  void ampliarFase(DateTime ahora, Duration extra) {
    const minimo = Duration(minutes: 1);
    if (enPreparacion(ahora)) {
      final nuevo = preparacion + extra;
      final va = transcurrido(ahora) + const Duration(seconds: 1);
      preparacion = nuevo < va ? va : (nuevo < minimo ? minimo : nuevo);
    } else {
      final nuevo = exposicion + extra;
      final va = expuesto(ahora);
      final suelo = va > minimo ? va : minimo;
      exposicion = nuevo < suelo ? suelo : nuevo;
    }
  }

  /// Termina el esquema ya y empieza la exposición (con todo su tiempo).
  void saltarFase(DateTime ahora) {
    if (_enExposicion) return;
    empezarExposicion(ahora);
  }

  /// Cuántos hitos han pasado ya (para no repetir sus avisos).
  int hitosPasados(DateTime ahora) {
    final t = transcurrido(ahora);
    return hitos.where((h) => h.en <= t).length;
  }

  /// Momentos (desde el inicio) en los que hay que avisar. Los de la
  /// exposición, solo cuando ya ha empezado.
  List<({Duration en, String texto, bool fin})> get hitos {
    final out = <({Duration en, String texto, bool fin})>[];
    if (preparacion > Duration.zero) {
      out.add((en: preparacion, texto: 'Fin del esquema. Cuando quieras, empieza la exposición.', fin: false));
    }
    if (!_enExposicion) return out;
    if (exposicion >= const Duration(minutes: 4)) {
      out.add((en: preparacion + exposicion ~/ 2, texto: 'Mitad del tiempo de exposición.', fin: false));
    }
    if (exposicion > const Duration(minutes: 2)) {
      out.add((en: total - const Duration(minutes: 1), texto: 'Queda 1 minuto.', fin: false));
    }
    out.add((en: total, texto: '¡Tiempo! Se han cumplido los ${textoMinutos(exposicion)} de exposición.', fin: true));
    return out;
  }

  /// Hitos que aún no han llegado, con su hora prevista (para programar avisos).
  /// Con el reloj parado no hay ninguno.
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
        'expo': exposicionEmpezada,
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
    r.exposicionEmpezada = j['expo'] == true || j['expo'] == null && r._acumulado > r.preparacion;
    return r;
  }
}

/// «22 minutos 30 segundos», «30 minutos», «1 minuto».
String textoMinutos(Duration d) {
  final m = d.inMinutes, s = d.inSeconds % 60;
  final min = '$m ${m == 1 ? 'minuto' : 'minutos'}';
  return s == 0 ? min : '$min $s segundos';
}

/// Tiempo de reloj: «07:05», «1:02:03» desde una hora. Redondea hacia arriba
/// en la cuenta atrás ([haciaArriba]) para que el 00:00 llegue al cumplirse.
String formatoReloj(Duration d, {bool haciaArriba = false}) {
  final ms = d.inMilliseconds.abs();
  final s = haciaArriba ? (ms / 1000).ceil() : ms ~/ 1000;
  final h = s ~/ 3600, m = (s % 3600) ~/ 60, x = s % 60;
  String dos(int n) => n.toString().padLeft(2, '0');
  return h > 0 ? '$h:${dos(m)}:${dos(x)}' : '${dos(m)}:${dos(x)}';
}

/// Cómo se muestra el reloj: hacia delante desde 0 (cronómetro, por defecto)
/// o cuenta atrás. Es una preferencia de cada dispositivo.
enum ModoReloj { adelante, atras }

/// Lo que marca el reloj en [modo]: el tiempo de la fase y si se ha pasado.
/// Hacia delante, al pasarse sigue contando; en la cuenta atrás se queda en
/// 00:00 y se muestra lo que va de más con «+».
({String texto, String? demas, bool pasado}) lecturaReloj(RelojCante r, DateTime ahora, ModoReloj modo) {
  final exceso = r.exceso(ahora);
  final pasado = exceso > Duration.zero;
  if (modo == ModoReloj.adelante) return (texto: formatoReloj(r.transcurridoFase(ahora)), demas: pasado ? '+${formatoReloj(exceso)}' : null, pasado: pasado);
  return (texto: formatoReloj(r.restanteFase(ahora), haciaArriba: true), demas: pasado ? '+${formatoReloj(exceso)}' : null, pasado: pasado);
}
