import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/notificaciones.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../preparador/tema_anticipado.dart' show leerAntelacion;
import 'esquema_clase.dart';
import 'reloj_cante.dart';
import 'reloj_clase.dart';
import 'reloj_compartido.dart';
import 'reloj_flotante.dart';
import 'reloj_grande_page.dart';

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

/// Texto de la notificación del cronómetro de la clase. Mientras corre no
/// dice cuánto queda (eso lo cuenta el cronómetro nativo del aviso, que baja
/// solo): un «le quedan 30:00» escrito se quedaba fijo mientras el tiempo
/// pasaba. Dice hasta qué hora, que sigue siendo verdad.
String textoAvisoReloj(RelojCante r, DateTime ahora, {String? elegido}) {
  final f = faseDeReloj(r, ahora);
  final tema = elegido == null ? '' : ' · tema $elegido';
  if (f.acabado) return 'Ha cumplido el tiempo$tema.';
  if (f.fase == 'Esquema terminado') return 'Va a empezar la exposición$tema.';
  if (f.hasta != null) return '${f.fase} hasta las ${horaCorta(f.hasta!)}$tema.';
  return 'En pausa: le quedan ${formatoReloj(f.queda, haciaArriba: true)}$tema.';
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
    final texto = textoAvisoReloj(e.reloj, ahora, elegido: e.elegido);
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
/// cualquiera lo maneja. Tiene lo mismo que el de Cantar ([ControlRelojClase]):
/// por defecto cuenta hacia delante desde 0, avisa en los mismos momentos y
/// se pone a pantalla completa. Si aún no se ha usado, lo prepara con el
/// esquema y la exposición de la clase.
class RelojDeClaseTarjeta extends ConsumerStatefulWidget {
  const RelojDeClaseTarjeta({super.key, required this.alumnoUid, required this.claseId, required this.otroNombre, required this.esquema, required this.exposicion, required this.onAbrir, this.alCambiarTiempos, this.fin});
  final String alumnoUid;
  final String claseId;
  final String otroNombre;
  /// Por defecto, si el cronómetro aún no existe.
  final Duration esquema;
  final Duration exposicion;
  final VoidCallback onAbrir;

  /// Al poner otros tiempos: se guardan también en la clase, para que los
  /// avisos de los temas digan este esquema y se vuelvan a programar.
  final Future<void> Function(Duration esquema, Duration exposicion)? alCambiarTiempos;

  /// Cuándo acaba la clase: después, el mini reloj ya no sale.
  final DateTime? fin;
  @override
  ConsumerState<RelojDeClaseTarjeta> createState() => _RelojDeClaseTarjetaState();
}

class _RelojDeClaseTarjetaState extends ConsumerState<RelojDeClaseTarjeta> {
  /// El cronómetro de la clase, del registro común: sigue vivo al cerrar la
  /// ficha si está en marcha (para el mini reloj flotante).
  ClaseConReloj? _clase;
  RelojesEnCurso? _registro;
  Timer? _tic;

  ControlRelojClase? get _control => _clase?.control;
  bool get _cargado => _clase?.cargado ?? false;
  String? get _error => _clase?.error;

  @override
  void initState() {
    super.initState();
    final yo = ref.read(usuarioActualProvider);
    if (yo == null || !ref.read(serviciosProvider).firebaseDisponible) return;
    final soyAlumno = yo.uid == widget.alumnoUid;
    final nombre = soyAlumno ? (yo.displayName ?? 'Tu alumno') : ref.read(perfilPreparadorProvider).nombre;
    final registro = ref.read(relojesEnCursoProvider);
    _registro = registro;
    final clase = _clase = registro.clase(
      db: ref.read(firestoreRelojProvider),
      oposicion: ref.read(oposicionProvider),
      alumnoUid: widget.alumnoUid,
      claseId: widget.claseId,
      miUid: yo.uid,
      miNombre: nombre.isEmpty ? 'Preparador' : nombre,
      otroNombre: widget.otroNombre,
      esquema: widget.esquema,
      exposicion: widget.exposicion,
      ruta: soyAlumno ? 'ruta:/cantes?cante=${widget.claseId}' : 'ruta:/clase?id=${widget.claseId}',
      fin: widget.fin,
      nombreTema: (c) {
        final t = ref.read(temarioProvider).valueOrNull?.tema(c);
        return t == null ? c : '${t.codigo} · ${t.titulo}';
      },
    );
    clase.alAvisar = (texto, {required fin}) {
      if (mounted) ScaffoldMessenger.of(context).mostrar(SnackBar(content: Text(texto)));
    };
    clase.addListener(_redibujar);
    _tic = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final c = _control;
      if (!mounted || c == null || !c.reloj.corriendo) return;
      c.tic(DateTime.now());
      setState(() {});
    });
  }

  void _redibujar() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tic?.cancel();
    final c = _clase;
    if (c != null) {
      c.removeListener(_redibujar);
      c.alAvisar = null;
      _registro?.soltar(c);
    }
    super.dispose();
  }

  void _pantallaCompleta() {
    final c = _control;
    if (c == null) return;
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(fullscreenDialog: true, builder: (_) => RelojGrandePage(fuente: c)));
  }

  /// Otro tiempo de esquema o de exposición antes de empezar.
  Future<void> _tiempos() async {
    final c = _control;
    if (c == null) return;
    final r = c.reloj;
    final s = r.preparacion.inSeconds;
    final esquema = TextEditingController(text: '${s ~/ 60}${s % 60 == 0 ? '' : ':${(s % 60).toString().padLeft(2, '0')}'}');
    final expo = TextEditingController(text: '${r.exposicion.inMinutes}');
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Tiempos del cronómetro'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: esquema, decoration: const InputDecoration(labelText: 'Esquema', suffixText: 'min', helperText: 'Minutos, o minutos:segundos (22:30); 0, sin esquema')),
          const SizedBox(height: 10),
          TextField(controller: expo, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Exposición', suffixText: 'min')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Aceptar')),
        ],
      ),
    );
    if (ok != true) return;
    final seg = esquema.text.trim() == '0' ? 0 : leerAntelacion(esquema.text);
    final min = int.tryParse(expo.text.trim());
    if (seg == null || seg > 180 * 60 || min == null || min <= 0 || min > 180) {
      if (mounted) ScaffoldMessenger.of(context).mostrar(const SnackBar(content: Text('Tiempos no válidos')));
      return;
    }
    await c.ponerTiempos(esquema: Duration(seconds: seg), exposicion: Duration(minutes: min));
    await widget.alCambiarTiempos?.call(Duration(seconds: seg), Duration(minutes: min));
  }

  @override
  Widget build(BuildContext context) {
    final c = _control;
    if (_clase == null || c == null) return const SizedBox.shrink();
    // Con la ficha a la vista no hace falta el mini reloj.
    final aLaVista = pantallaALaVista(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _clase?.ponerVisible(aLaVista);
    });
    final ahora = DateTime.now();
    final r = c.reloj;
    final empezado = r.empezado;
    final enEsquema = r.preparacion > Duration.zero && r.enPreparacion(ahora);
    final esperando = r.esperandoExposicion(ahora);
    final terminado = r.terminado(ahora);
    final lectura = lecturaReloj(r, ahora, c.modo);
    final ultimoMinuto = !enEsquema && !esperando && empezado && r.restanteFase(ahora).inSeconds <= 60;
    final color = lectura.pasado || ultimoMinuto ? context.esquema.error : (enEsquema || esperando ? context.colores.dorado : context.esquema.primary);
    final fase = terminado ? 'Tiempo cumplido' : (esperando ? 'Esquema terminado' : (enEsquema ? 'Esquema' : 'Exposición'));
    final quien = c.quien;
    final siguiente = c.siguienteTema;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Tarjeta(
        color: r.corriendo ? context.colores.primarioPalido : null,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.timer_outlined, color: context.esquema.primary),
            const SizedBox(width: 8),
            Expanded(child: Text('Cronómetro compartido con ${widget.otroNombre}', style: context.textos.titleSmall)),
            IconButton(tooltip: 'Pantalla completa', icon: const Icon(Icons.fullscreen), onPressed: _error == null && _cargado ? _pantallaCompleta : null),
            TextButton(onPressed: widget.onAbrir, child: const Text('Abrir')),
          ]),
          if (_error != null)
            Text('No se puede ver el cronómetro de esta clase ($_error). Si la clase no le ha llegado al alumno, vuelve a guardarla.', style: context.textos.bodySmall?.copyWith(color: context.esquema.error))
          else if (!_cargado)
            const LinearProgressIndicator()
          else ...[
            Center(
              child: SegmentedButton<ModoReloj>(
                showSelectedIcon: false,
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                segments: const [
                  ButtonSegment(value: ModoReloj.adelante, icon: Icon(Icons.timer_outlined, size: 18), label: Text('Cronómetro')),
                  ButtonSegment(value: ModoReloj.atras, icon: Icon(Icons.hourglass_bottom, size: 18), label: Text('Cuenta atrás')),
                ],
                selected: {c.modo},
                onSelectionChanged: (_) => c.alternarModo(),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                empezado ? fase : 'Sin empezar · ${r.preparacion > Duration.zero ? 'esquema ${textoMinutos(r.preparacion)}, ' : ''}exposición ${textoMinutos(r.exposicion)}',
                textAlign: TextAlign.center,
                style: context.textos.labelMedium,
              ),
            ),
            Center(
              child: Text(
                lectura.texto,
                style: context.textos.displaySmall?.copyWith(fontFeatures: const [FontFeature.tabularFigures()], color: empezado ? color : context.colores.textoClaro),
              ),
            ),
            if (lectura.demas != null) Center(child: Text('${lectura.demas} de más', style: context.textos.titleSmall?.copyWith(color: context.esquema.error, fontFeatures: const [FontFeature.tabularFigures()]))),
            ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: r.progresoFase(ahora).clamp(0.0, 1.0), minHeight: 6, color: color, backgroundColor: context.colores.fondoClaro)),
            const SizedBox(height: 6),
            if (empezado || c.elegido != null)
              Center(
                child: Text(
                  [if (!r.corriendo && empezado) 'en pausa', if (quien.isNotEmpty) 'lo lleva $quien', if (c.elegido != null) 'tema ${c.elegido}'].join(' · '),
                  style: context.textos.bodySmall,
                ),
              )
            else
              Text('Lo que haga uno lo ve el otro al momento, cada uno en su móvil.', style: context.textos.bodySmall),
            const SizedBox(height: 8),
            Center(
              child: Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 4, children: [
                if (esperando)
                  FilledButton.icon(onPressed: c.empezarExposicion, icon: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Empezar la exposición'))
                else if (!r.corriendo)
                  FilledButton.icon(onPressed: c.alternar, icon: const Icon(Icons.play_arrow, size: 18), label: Text(empezado ? 'Continuar' : 'Empezar'))
                else
                  OutlinedButton.icon(onPressed: c.alternar, icon: const Icon(Icons.pause, size: 18), label: const Text('Pausar')),
                if (enEsquema && empezado) OutlinedButton.icon(onPressed: c.pasarAExponer, icon: const Icon(Icons.record_voice_over_outlined, size: 18), label: const Text('Pasar a exponer')),
                if (siguiente != null && empezado && !enEsquema && !esperando)
                  FilledButton.tonalIcon(onPressed: c.pasarAlSiguienteTema, icon: const Icon(Icons.skip_next, size: 18), label: Text('Pasar al tema $siguiente')),
              ]),
            ),
            const SizedBox(height: 4),
            Center(
              child: Wrap(alignment: WrapAlignment.center, spacing: 6, runSpacing: 4, children: [
                if (empezado) ...[
                  ActionChip(label: const Text('−1 min'), onPressed: () => c.ajustarMinutos(-1)),
                  ActionChip(label: const Text('+1 min'), onPressed: () => c.ajustarMinutos(1)),
                  ActionChip(avatar: const Icon(Icons.more_time, size: 18), label: const Text('+5 min'), onPressed: () => c.ajustarMinutos(5)),
                  if (!enEsquema && !esperando && r.preparacion > Duration.zero)
                    ActionChip(avatar: const Icon(Icons.replay, size: 18), label: const Text('Reiniciar la exposición'), onPressed: c.reiniciarExposicion),
                  ActionChip(avatar: const Icon(Icons.restart_alt, size: 18), label: const Text('Reiniciar todo'), onPressed: c.reiniciarTodo),
                ] else
                  ActionChip(avatar: const Icon(Icons.tune, size: 18), label: const Text('Cambiar los tiempos'), onPressed: _tiempos),
              ]),
            ),
            const SizedBox(height: 4),
            Text('Avisa al acabar el esquema, a mitad de la exposición, a 1 minuto del final y al cumplirse, también con la pantalla apagada; mientras corre, la pantalla no se apaga. Si os pasáis, sigue contando.', style: context.textos.labelSmall),
          ],
        ]),
      ),
    );
  }
}
