import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import 'reloj_cante.dart';
import 'reloj_compartido.dart';
import 'reloj_grande_page.dart';

/// Hacia delante (por defecto) o cuenta atrás: la preferencia de este
/// dispositivo, la misma en Cantar y en el cronómetro de las clases.
ModoReloj modoRelojGuardado() {
  final v = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app).get('reloj_modo') : null;
  return v == 'atras' ? ModoReloj.atras : ModoReloj.adelante;
}

void guardarModoReloj(ModoReloj modo) {
  if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put('reloj_modo', modo.name);
}

/// Un hito del cronómetro que acaba de pasar (para avisar).
typedef HitoReloj = ({Duration en, String texto, bool fin});

/// El cronómetro compartido de una clase con preparador, con todo lo que
/// tiene el de Cantar: empezar, pausar y continuar, pasar a exponer, más o
/// menos minutos, reiniciar la exposición o todo, cronómetro (por defecto)
/// o cuenta atrás, pasar al tema siguiente, avisos con vibración y
/// notificación, la pantalla encendida mientras corre y la pantalla completa
/// ([RelojGrandePage], que lo recibe como [FuenteReloj]).
///
/// El estado vive en Firestore ([RelojCompartido]): cada cambio se aplica
/// aquí al momento y se publica para el otro; lo que llega del otro se toma
/// con [recibir].
class ControlRelojClase extends ChangeNotifier implements FuenteReloj {
  ControlRelojClase({
    required this.esquemaPorDefecto,
    required this.exposicionPorDefecto,
    required this.otroNombre,
    required this.miUid,
    this.publicador,
    this.nombreTema,
    this.alAvisar,
    this.efectos = true,
    ModoReloj? modo,
  }) : _modo = modo ?? modoRelojGuardado();

  /// Tiempos de la clase, para cuando el cronómetro aún no existe (o al
  /// reiniciarlo todo).
  Duration esquemaPorDefecto;
  Duration exposicionPorDefecto;
  final String otroNombre;
  final String miUid;

  /// Publica el estado para el otro (en las pruebas, nada).
  final Future<void> Function(RelojCante reloj, {List<String> temas, String? elegido})? publicador;

  /// «3.A.7 · Título» de un código, para la pantalla completa.
  final String? Function(String codigo)? nombreTema;

  /// Avisos al pasar un hito (mitad, último minuto, tiempo): la tarjeta los
  /// enseña; la vibración la pone el propio control.
  final void Function(String texto, {required bool fin})? alAvisar;

  /// Vibración, notificaciones y pantalla encendida (no en las pruebas).
  final bool efectos;

  EstadoRelojCompartido? _estado;
  RelojCante? _local;
  ModoReloj _modo;
  int _hitosAvisados = 0;
  bool _pantallaEncendida = false;

  /// El último estado llegado de Firestore (o null si aún no se ha usado).
  EstadoRelojCompartido? get estado => _estado;

  List<String> get temas => _estado?.temas ?? const [];
  String? get elegido => _estado?.elegido;

  /// Quién lo tocó por última vez: «tú», el nombre del otro o nada.
  String get quien {
    final e = _estado;
    if (e == null || e.por.isEmpty) return '';
    return e.por == miUid ? 'tú' : e.porNombre;
  }

  @override
  RelojCante get reloj => _estado?.reloj ?? (_local ??= RelojCante(preparacion: esquemaPorDefecto, exposicion: exposicionPorDefecto));

  @override
  String? get temaActual {
    final c = elegido;
    if (c == null) return null;
    return nombreTema?.call(c) ?? c;
  }

  @override
  String? get compartidoCon => otroNombre;

  @override
  ModoReloj get modo => _modo;

  /// El estado que llega de Firestore (de los dos). Los avisos que ya han
  /// pasado no se repiten.
  void recibir(EstadoRelojCompartido? e) {
    _estado = e;
    if (e != null) _local = null;
    _rehacerAvisos(DateTime.now());
    notifyListeners();
  }

  /// Cada segundo (o cada cuarto), mientras se ve: avisa de los hitos que
  /// acaban de pasar. Devuelve los avisados (para las pruebas).
  List<HitoReloj> tic(DateTime ahora) {
    final r = reloj;
    if (!r.corriendo) return const [];
    final hitos = r.hitos;
    final t = r.transcurrido(ahora);
    final nuevos = <HitoReloj>[];
    while (_hitosAvisados < hitos.length && t >= hitos[_hitosAvisados].en) {
      nuevos.add(hitos[_hitosAvisados]);
      _hitosAvisados++;
    }
    for (final h in nuevos) {
      alAvisar?.call(h.texto, fin: h.fin);
      if (efectos) _vibrar(h.fin);
    }
    return nuevos;
  }

  /// Cambia el reloj, lo aplica aquí ya y lo publica para el otro.
  Future<void> cambiar(void Function(RelojCante r, DateTime ahora) cambio, {String? elegido}) async {
    final r = reloj;
    final ahora = DateTime.now();
    cambio(r, ahora);
    final e = _estado;
    if (e != null) {
      _estado = EstadoRelojCompartido(reloj: r, activo: true, por: miUid, porNombre: e.porNombre, temas: e.temas, elegido: elegido ?? e.elegido);
    }
    _rehacerAvisos(ahora);
    notifyListeners();
    await publicador?.call(r, temas: temas, elegido: elegido ?? this.elegido);
  }

  /// Los temas de la clase que quedan por cantar después del actual (cuando
  /// se cantan varios por orden).
  String? get siguienteTema {
    final i = elegido == null ? -1 : temas.indexOf(elegido!);
    return i >= 0 && i < temas.length - 1 ? temas[i + 1] : null;
  }

  /// Al acabar la exposición de un tema, el siguiente, con la exposición desde cero.
  Future<void> pasarAlSiguienteTema() async {
    final s = siguienteTema;
    if (s == null) return;
    await cambiar((r, _) => r.reiniciarExposicion(), elegido: s);
  }

  /// Otros tiempos (solo con el cronómetro sin empezar).
  Future<void> ponerTiempos({required Duration esquema, required Duration exposicion}) async {
    esquemaPorDefecto = esquema;
    exposicionPorDefecto = exposicion;
    await cambiar((r, _) {
      r.reiniciar();
      r.preparacion = esquema;
      r.exposicion = exposicion;
    });
  }

  // FuenteReloj (los mismos botones que la pantalla grande de Cantar).
  @override
  void alternar() {
    final ahora = DateTime.now();
    final r = reloj;
    if (r.esperandoExposicion(ahora)) {
      cambiar((r, a) => r.empezarExposicion(a));
    } else if (r.corriendo) {
      cambiar((r, a) => r.pausar(a));
    } else {
      cambiar((r, a) => r.iniciar(a));
    }
  }

  @override
  void ajustarMinutos(int minutos) => cambiar((r, a) => r.ampliarFase(a, Duration(minutes: minutos)));
  @override
  void pasarAExponer() => cambiar((r, a) => r.saltarFase(a));
  @override
  void empezarExposicion() => cambiar((r, a) => r.empezarExposicion(a));
  @override
  void reiniciarExposicion() => cambiar((r, _) => r.reiniciarExposicion());
  @override
  void reiniciarTodo() => cambiar((r, _) {
        r.reiniciar();
        r.preparacion = esquemaPorDefecto;
        r.exposicion = exposicionPorDefecto;
      });

  @override
  void alternarModo() {
    _modo = _modo == ModoReloj.adelante ? ModoReloj.atras : ModoReloj.adelante;
    guardarModoReloj(_modo);
    notifyListeners();
  }

  /// Los hitos ya pasados no se avisan; los que faltan se programan como
  /// notificaciones (por si la app pasa a segundo plano) y la pantalla se
  /// queda encendida mientras corre.
  void _rehacerAvisos(DateTime ahora) {
    final r = reloj;
    _hitosAvisados = r.hitosPasados(ahora);
    if (!efectos) return;
    if (r.corriendo) {
      Notificaciones.programarCronometro(r.avisosPendientes(ahora)).catchError((_) {});
    } else {
      Notificaciones.cancelarCronometro().catchError((_) {});
    }
    _encender(r.corriendo);
  }

  void _encender(bool si) {
    if (si == _pantallaEncendida) return;
    _pantallaEncendida = si;
    // Sin plugin (pruebas, escritorio) no pasa nada.
    (si ? WakelockPlus.enable() : WakelockPlus.disable()).catchError((_) {});
  }

  Future<void> _vibrar(bool largo) async {
    try {
      if (await Vibration.hasVibrator()) Vibration.vibrate(pattern: largo ? [0, 400, 200, 400, 200, 600] : [0, 300]);
    } catch (_) {}
  }

  @override
  void dispose() {
    if (efectos) {
      _encender(false);
      // Si sigue corriendo, los avisos se quedan (como en Cantar al salir).
      if (!reloj.corriendo) Notificaciones.cancelarCronometro().catchError((_) {});
    }
    super.dispose();
  }
}

/// Para depurar sin Firestore.
@visibleForTesting
EstadoRelojCompartido estadoDePrueba(RelojCante r, {String por = 'otro', List<String> temas = const [], String? elegido}) =>
    EstadoRelojCompartido(reloj: r, activo: true, por: por, porNombre: 'Otro', temas: temas, elegido: elegido);
