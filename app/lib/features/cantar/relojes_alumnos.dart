import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'reloj_cante.dart';
import 'reloj_compartido.dart';

/// El cronómetro que está usando cada alumno en su clase de ahora (por id de
/// la clase), para el preparador. Lo llena [VigilanteRelojes].
final relojesAlumnosProvider = StateProvider<Map<String, ({String alumno, EstadoRelojCompartido estado})>>((ref) => const {});

/// En qué va un cronómetro: la fase, cuánto queda y hasta cuándo (si corre).
({String fase, Duration queda, DateTime? hasta, bool acabado}) faseDeReloj(RelojCante r, DateTime ahora) {
  if (r.terminado(ahora)) return (fase: 'Tiempo cumplido', queda: Duration.zero, hasta: null, acabado: true);
  if (r.esperandoExposicion(ahora)) return (fase: 'Esquema terminado', queda: Duration.zero, hasta: null, acabado: false);
  final queda = r.restanteFase(ahora);
  return (fase: r.enPreparacion(ahora) ? 'Esquema' : 'Exposición', queda: queda, hasta: r.corriendo ? ahora.add(queda) : null, acabado: false);
}

/// Mientras la app del preparador está abierta, escucha el cronómetro
/// compartido de sus clases de ahora (de 3 h antes a 1 h después) y, si el
/// alumno lo está usando, lo enseña en la ficha de la clase y en una
/// notificación con lo que le queda de esquema o de exposición.
class VigilanteRelojes {
  VigilanteRelojes(this._ref);
  final WidgetRef _ref;
  final _escuchas = <String, StreamSubscription<EstadoRelojCompartido?>>{};
  final _temporizadores = <String, Timer>{};
  final _avisado = <String, String>{};
  final _rutas = <String, String>{};
  Timer? _revision;

  void empezar() {
    _revision?.cancel();
    _revision = Timer.periodic(const Duration(minutes: 1), (_) => revisar());
    revisar();
  }

  void revisar() {
    final yo = _ref.read(usuarioActualProvider);
    final activo = yo != null && _ref.read(serviciosProvider).firebaseDisponible;
    final preparador = _ref.read(papelProvider) == Papel.preparador;
    final ahora = DateTime.now();
    bool deAhora(DateTime f) => f.isAfter(ahora.subtract(const Duration(hours: 3))) && f.isBefore(ahora.add(const Duration(hours: 1)));
    final alumnos = {for (final a in _ref.read(alumnosProvider)) a.id: a};
    // El preparador mira el cronómetro de sus alumnos; el alumno, el de las
    // clases que le da su preparador (si es el preparador quien lo lleva).
    final Map<String, ({String uid, String nombre, String ruta})> clases = !activo
        ? const {}
        : preparador
            ? {
                for (final s in _ref.read(sesionesProvider))
                  if (s.pendiente && !s.borrado && s.alumno != null && alumnos[s.alumno]?.uid != null && deAhora(s.fecha))
                    s.id: (uid: alumnos[s.alumno]!.uid!, nombre: alumnos[s.alumno]!.nombre, ruta: '/clase?id=${s.id}'),
              }
            : {
                for (final c in _ref.read(cantesProvider))
                  if (c.dePreparador && c.pendiente && deAhora(c.fecha))
                    c.id: (uid: yo.uid, nombre: (c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre!, ruta: '/cantes?cante=${c.id}'),
              };
    for (final id in _escuchas.keys.where((k) => !clases.containsKey(k)).toList()) {
      _quitar(id);
    }
    for (final e in clases.entries) {
      if (_escuchas.containsKey(e.key)) continue;
      final reloj = RelojCompartido.deClase(_ref.read(firestoreRelojProvider), _ref.read(oposicionProvider), alumnoUid: e.value.uid, canteId: e.key, miUid: yo!.uid, miNombre: preparador ? _ref.read(perfilPreparadorProvider).nombre : (yo.displayName ?? 'Tu alumno'));
      _rutas[e.key] = e.value.ruta;
      _escuchas[e.key] = reloj.escuchar().listen((estado) => _alCambiar(e.key, e.value.nombre, estado, yo.uid));
      reloj.medirDesfase();
    }
  }

  void _alCambiar(String id, String alumno, EstadoRelojCompartido? e, String yo) {
    final mapa = Map.of(_ref.read(relojesAlumnosProvider));
    if (e == null || !e.activo || e.por == yo || !e.reloj.empezado) {
      mapa.remove(id);
      _ref.read(relojesAlumnosProvider.notifier).state = mapa;
      _temporizadores.remove(id)?.cancel();
      if (_avisado.remove(id) != null) Notificaciones.quitarRelojAlumno(id).catchError((_) {});
      return;
    }
    mapa[id] = (alumno: alumno, estado: e);
    _ref.read(relojesAlumnosProvider.notifier).state = mapa;
    _avisar(id, alumno, e);
  }

  /// Notificación con la fase y lo que queda; al acabar la fase se rehace.
  void _avisar(String id, String alumno, EstadoRelojCompartido e) {
    final ahora = DateTime.now();
    final f = faseDeReloj(e.reloj, ahora);
    final tema = e.elegido == null ? '' : ' · tema ${e.elegido}';
    final texto = f.acabado
        ? 'Ha cumplido el tiempo$tema.'
        : (f.fase == 'Esquema terminado' ? 'Va a empezar la exposición$tema.' : (e.reloj.corriendo ? 'Le quedan ${formatoReloj(f.queda, haciaArriba: true)}$tema.' : 'En pausa: le quedan ${formatoReloj(f.queda, haciaArriba: true)}$tema.'));
    final clave = '${f.fase}|${e.reloj.corriendo}|${f.hasta == null ? '' : f.hasta!.millisecondsSinceEpoch ~/ 5000}|${e.elegido}';
    if (_avisado[id] != clave) {
      _avisado[id] = clave;
      Notificaciones.relojAlumno(id, titulo: '$alumno · ${f.fase}', texto: texto, hasta: f.hasta, ruta: _rutas[id] ?? '/clase?id=$id').catchError((_) {});
    }
    _temporizadores.remove(id)?.cancel();
    if (f.hasta != null) {
      _temporizadores[id] = Timer(f.hasta!.difference(ahora) + const Duration(seconds: 1), () {
        final actual = _ref.read(relojesAlumnosProvider)[id];
        if (actual != null) _avisar(id, actual.alumno, actual.estado);
      });
    }
  }

  void _quitar(String id) {
    _escuchas.remove(id)?.cancel();
    _temporizadores.remove(id)?.cancel();
    if (_avisado.remove(id) != null) Notificaciones.quitarRelojAlumno(id).catchError((_) {});
    final mapa = Map.of(_ref.read(relojesAlumnosProvider))..remove(id);
    _ref.read(relojesAlumnosProvider.notifier).state = mapa;
  }

  void cerrar() {
    _revision?.cancel();
    for (final id in _escuchas.keys.toList()) {
      _escuchas.remove(id)?.cancel();
      _temporizadores.remove(id)?.cancel();
      if (_avisado.remove(id) != null) Notificaciones.quitarRelojAlumno(id).catchError((_) {});
    }
  }
}

/// Tarjeta de la ficha de la clase: el alumno está con el cronómetro.
class TarjetaRelojAlumno extends ConsumerStatefulWidget {
  const TarjetaRelojAlumno({super.key, required this.claseId, required this.onAbrir});
  final String claseId;
  final VoidCallback onAbrir;
  @override
  ConsumerState<TarjetaRelojAlumno> createState() => _TarjetaRelojAlumnoState();
}

class _TarjetaRelojAlumnoState extends ConsumerState<TarjetaRelojAlumno> {
  Timer? _tic;

  @override
  void initState() {
    super.initState();
    _tic = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = ref.watch(relojesAlumnosProvider)[widget.claseId];
    if (r == null) return const SizedBox.shrink();
    final f = faseDeReloj(r.estado.reloj, DateTime.now());
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        onTap: widget.onAbrir,
        child: Row(children: [
          Icon(Icons.timer_outlined, color: context.esquema.primary, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${r.alumno} está con el cronómetro', style: context.textos.titleSmall),
              Text(
                '${f.fase}${f.acabado || f.fase == 'Esquema terminado' ? '' : ' · quedan ${formatoReloj(f.queda, haciaArriba: true)}${r.estado.reloj.corriendo ? '' : ' (en pausa)'}'}${r.estado.elegido == null ? '' : ' · tema ${r.estado.elegido}'}',
                style: context.textos.bodySmall,
              ),
            ]),
          ),
          FilledButton(onPressed: widget.onAbrir, child: const Text('Verlo')),
        ]),
      ),
    );
  }
}

/// El cronómetro compartido de una clase, en la ficha de la clase (del alumno
/// y del preparador): los dos ven el mismo tiempo en todo momento y
/// cualquiera lo empieza, lo pausa o pasa a exponer. Si aún no se ha usado,
/// lo prepara con el esquema y la exposición de la clase.
class RelojDeClaseTarjeta extends ConsumerStatefulWidget {
  const RelojDeClaseTarjeta({super.key, required this.alumnoUid, required this.claseId, required this.otroNombre, required this.esquema, required this.exposicion, required this.onAbrir});
  final String alumnoUid;
  final String claseId;
  final String otroNombre;
  /// Por defecto, si el cronómetro aún no existe.
  final Duration esquema;
  final Duration exposicion;
  final VoidCallback onAbrir;
  @override
  ConsumerState<RelojDeClaseTarjeta> createState() => _RelojDeClaseTarjetaState();
}

class _RelojDeClaseTarjetaState extends ConsumerState<RelojDeClaseTarjeta> {
  RelojCompartido? _reloj;
  StreamSubscription<EstadoRelojCompartido?>? _escucha;
  EstadoRelojCompartido? _estado;
  bool _cargado = false;
  String? _error;
  Timer? _tic;

  @override
  void initState() {
    super.initState();
    final yo = ref.read(usuarioActualProvider);
    if (yo == null || !ref.read(serviciosProvider).firebaseDisponible) return;
    final soyAlumno = yo.uid == widget.alumnoUid;
    final nombre = soyAlumno ? (yo.displayName ?? 'Tu alumno') : ref.read(perfilPreparadorProvider).nombre;
    _reloj = RelojCompartido.deClase(ref.read(firestoreRelojProvider), ref.read(oposicionProvider), alumnoUid: widget.alumnoUid, canteId: widget.claseId, miUid: yo.uid, miNombre: nombre.isEmpty ? 'Preparador' : nombre);
    _reloj!.medirDesfase();
    _escucha = _reloj!.escucharConErrores().listen(
      (e) {
        if (mounted) {
          setState(() {
            _estado = e;
            _cargado = true;
            _error = null;
          });
        }
      },
      onError: (Object e) {
        if (mounted) {
          setState(() {
            _cargado = true;
            _error = e.toString().contains('permission') ? 'sin permiso' : 'sin conexión';
          });
        }
      },
    );
    _tic = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && (_estado?.reloj.corriendo ?? false)) setState(() {});
    });
  }

  @override
  void dispose() {
    _escucha?.cancel();
    _tic?.cancel();
    super.dispose();
  }

  /// Cambia el reloj compartido y lo publica (para los dos).
  Future<void> _cambiar(void Function(RelojCante r, DateTime ahora) cambio) async {
    final e = _estado;
    final r = e?.reloj ?? RelojCante(preparacion: widget.esquema, exposicion: widget.exposicion);
    final ahora = DateTime.now();
    cambio(r, ahora);
    await _reloj?.publicar(r, temas: e?.temas ?? const [], elegido: e?.elegido);
  }

  @override
  Widget build(BuildContext context) {
    if (_reloj == null) return const SizedBox.shrink();
    final ahora = DateTime.now();
    final e = _estado;
    final r = e?.reloj;
    final f = r == null ? null : faseDeReloj(r, ahora);
    final yo = _reloj!.miUid;
    final quien = e == null || e.por.isEmpty ? '' : (e.por == yo ? 'tú' : e.porNombre);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Tarjeta(
        color: (r?.corriendo ?? false) ? context.colores.primarioPalido : null,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.timer_outlined, color: context.esquema.primary),
            const SizedBox(width: 8),
            Expanded(child: Text('Cronómetro compartido con ${widget.otroNombre}', style: context.textos.titleSmall)),
            TextButton(onPressed: widget.onAbrir, child: const Text('Abrir')),
          ]),
          if (_error != null)
            Text('No se puede ver el cronómetro de esta clase ($_error). Si la clase no le ha llegado al alumno, vuelve a guardarla.', style: context.textos.bodySmall?.copyWith(color: context.esquema.error))
          else if (!_cargado)
            const LinearProgressIndicator()
          else if (r == null || !r.empezado)
            Text('Sin empezar. Lo que haga uno lo ve el otro al momento, cada uno en su móvil.', style: context.textos.bodySmall)
          else ...[
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(f!.acabado || f.fase == 'Esquema terminado' ? '--:--' : formatoReloj(f.queda, haciaArriba: true), style: context.textos.headlineMedium?.copyWith(fontFeatures: const [FontFeature.tabularFigures()], color: f.queda.inSeconds <= 60 && !f.acabado ? context.esquema.error : context.esquema.primary)),
              const SizedBox(width: 10),
              Expanded(child: Text('${f.fase}${r.corriendo ? '' : ' · en pausa'}${quien.isEmpty ? '' : ' · lo lleva $quien'}${e!.elegido == null ? '' : ' · tema ${e.elegido}'}', style: context.textos.bodySmall)),
            ]),
          ],
          if (_error == null && _cargado)
            Wrap(spacing: 8, runSpacing: 4, children: [
              if (r != null && r.esperandoExposicion(ahora))
                FilledButton.icon(onPressed: () => _cambiar((r, a) => r.empezarExposicion(a)), icon: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Empezar la exposición'))
              else if (r == null || !r.corriendo)
                FilledButton.icon(onPressed: () => _cambiar((r, a) => r.iniciar(a)), icon: const Icon(Icons.play_arrow, size: 18), label: Text(r != null && r.empezado ? 'Continuar' : 'Empezar'))
              else
                OutlinedButton.icon(onPressed: () => _cambiar((r, a) => r.pausar(a)), icon: const Icon(Icons.pause, size: 18), label: const Text('Pausar')),
              if (r != null && r.corriendo && r.enPreparacion(ahora))
                OutlinedButton(onPressed: () => _cambiar((r, a) => r.saltarFase(a)), child: const Text('Pasar a exponer')),
            ]),
        ]),
      ),
    );
  }
}

