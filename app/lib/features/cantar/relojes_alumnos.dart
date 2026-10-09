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
  Timer? _revision;

  void empezar() {
    _revision?.cancel();
    _revision = Timer.periodic(const Duration(minutes: 1), (_) => revisar());
    revisar();
  }

  void revisar() {
    final yo = _ref.read(usuarioActualProvider);
    final activo = yo != null && _ref.read(serviciosProvider).firebaseDisponible && _ref.read(papelProvider) == Papel.preparador;
    final ahora = DateTime.now();
    final alumnos = {for (final a in _ref.read(alumnosProvider)) a.id: a};
    final clases = !activo
        ? const <String, ({String uid, String nombre})>{}
        : {
            for (final s in _ref.read(sesionesProvider))
              if (s.pendiente && !s.borrado && s.alumno != null && alumnos[s.alumno]?.uid != null && s.fecha.isAfter(ahora.subtract(const Duration(hours: 3))) && s.fecha.isBefore(ahora.add(const Duration(hours: 1))))
                s.id: (uid: alumnos[s.alumno]!.uid!, nombre: alumnos[s.alumno]!.nombre),
          };
    for (final id in _escuchas.keys.where((k) => !clases.containsKey(k)).toList()) {
      _quitar(id);
    }
    for (final e in clases.entries) {
      if (_escuchas.containsKey(e.key)) continue;
      final reloj = RelojCompartido.deClase(_ref.read(firestoreRelojProvider), _ref.read(oposicionProvider), alumnoUid: e.value.uid, canteId: e.key, miUid: yo!.uid, miNombre: _ref.read(perfilPreparadorProvider).nombre);
      _escuchas[e.key] = reloj.escuchar().listen((estado) => _alCambiar(e.key, e.value.nombre, estado, yo.uid));
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
      Notificaciones.relojAlumno(id, titulo: '$alumno · ${f.fase}', texto: texto, hasta: f.hasta, ruta: '/clase?id=$id').catchError((_) {});
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
