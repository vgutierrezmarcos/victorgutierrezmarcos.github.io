import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import 'reloj_cante.dart';
import 'reloj_clase.dart';
import 'reloj_compartido.dart';
import 'reloj_grande_page.dart';

/// Un cronómetro de clase que puede ir en el mini reloj flotante: quien lo
/// lleva ([fuente], la misma que usa la pantalla grande), de qué clase es
/// ([clave]), cómo volver a su pantalla ([abrir]) y hasta cuándo dura la
/// clase ([fin], si se sabe).
class RelojFlotante {
  RelojFlotante({required this.clave, required this.fuente, required this.abrir, this.visible = false, this.fin});
  final String clave;
  final FuenteReloj fuente;
  final VoidCallback abrir;

  /// Su pantalla (la clase, Cantar) está a la vista: entonces no hace falta
  /// el mini reloj.
  final bool visible;
  final DateTime? fin;

  bool _igual(RelojFlotante? o) => o != null && o.clave == clave && identical(o.fuente, fuente) && o.visible == visible && o.fin == fin;
}

/// Los cronómetros de clase en curso de este dispositivo, para el mini reloj
/// que se ve desde cualquier pantalla de la app ([MiniRelojFlotante]).
///
/// Los apunta quien los lleva: Cantar (con su propio reloj) y la tarjeta del
/// cronómetro de la clase, que lo pide aquí ([clase]) para que siga vivo
/// aunque se cierre la ficha de la clase: así se puede pausar y continuar
/// desde el temario, un test o lo que sea, igual que con el botón del reloj
/// grande (y lo ve el otro, porque se publica igual en Firestore).
class RelojesEnCurso extends ChangeNotifier {
  RelojesEnCurso({DateTime Function()? reloj}) : _ahora = reloj ?? DateTime.now;

  final DateTime Function() _ahora;
  final Map<Object, RelojFlotante> _entradas = {};
  final Set<FuenteReloj> _grandes = {};
  final Map<String, ClaseConReloj> _clases = {};

  /// Abre una ruta de la app como al tocar una notificación
  /// (`ruta:/clase?id=…`); lo pone la app al arrancar.
  void Function(String contenido)? abrirContenido;

  bool _pendiente = false;
  bool _cerrado = false;

  /// Avisa a quien escucha después del frame en curso: los cambios llegan
  /// desde initState y dispose de las pantallas, cuando no se puede
  /// reconstruir nada.
  void _cambio() {
    if (_pendiente || _cerrado) return;
    _pendiente = true;
    scheduleMicrotask(() {
      _pendiente = false;
      if (!_cerrado) notifyListeners();
    });
  }

  /// Apunta (o quita, con null) el cronómetro de [duenio].
  void poner(Object duenio, RelojFlotante? r) {
    final antes = _entradas[duenio];
    if (r == null) {
      if (_entradas.remove(duenio) != null) _cambio();
      return;
    }
    _entradas[duenio] = r;
    if (!r._igual(antes)) _cambio();
  }

  /// La pantalla grande de [fuente] está abierta (o se ha cerrado).
  void pantallaGrande(FuenteReloj fuente, bool abierta) {
    final cambia = abierta ? _grandes.add(fuente) : _grandes.remove(fuente);
    if (cambia) _cambio();
  }

  /// El que va en el mini reloj ahora (o null): uno empezado cuya clase no
  /// está a la vista, el último apuntado. Desaparece al acabar la clase: si
  /// se para con el tiempo cumplido o ya ha pasado su hora de fin.
  RelojFlotante? flotante() {
    final ahora = _ahora();
    final aLaVista = {for (final e in _entradas.values) if (e.visible || _grandes.contains(e.fuente)) e.clave};
    // Si Cantar lleva el reloj de una clase, manda él (su reloj es el que
    // corre en esta pantalla; el de la tarjeta lo sigue por Firestore).
    final conPantalla = {for (final e in _entradas.entries) if (e.key is! ClaseConReloj) e.value.clave};
    RelojFlotante? elegido;
    for (final x in _entradas.entries) {
      final e = x.value;
      if (x.key is ClaseConReloj && conPantalla.contains(e.clave)) continue;
      if (aLaVista.contains(e.clave) || !vigente(e.fuente.reloj, ahora, fin: e.fin)) continue;
      elegido = e;
    }
    return elegido;
  }

  /// Si un cronómetro sigue «en curso»: empezado, sin haberse parado con el
  /// tiempo cumplido, y sin pasar de la hora de fin de la clase (si no corre)
  /// o de una hora después (si sigue corriendo).
  static bool vigente(RelojCante r, DateTime ahora, {DateTime? fin}) {
    if (!r.empezado) return false;
    if (!r.corriendo && r.terminado(ahora)) return false;
    if (fin != null && ahora.isAfter(fin.add(r.corriendo ? const Duration(hours: 1) : Duration.zero))) return false;
    return true;
  }

  /// El cronómetro compartido de la clase [claseId] del alumno [alumnoUid]:
  /// el mismo para todas las pantallas que lo usen. Cada una lo suelta con
  /// [soltar]; se cierra cuando nadie lo usa y ya no está en curso.
  ClaseConReloj clase({
    required FirebaseFirestore db,
    required Oposicion oposicion,
    required String alumnoUid,
    required String claseId,
    required String miUid,
    required String miNombre,
    required String otroNombre,
    required Duration esquema,
    required Duration exposicion,
    required String ruta,
    String? Function(String codigo)? nombreTema,
    DateTime? fin,
    bool efectos = true,
  }) {
    final clave = '$alumnoUid/$claseId';
    final ya = _clases[clave];
    if (ya != null) {
      ya._usuarios++;
      ya.fin = fin ?? ya.fin;
      if (!ya.control.reloj.empezado) {
        ya.control.esquemaPorDefecto = esquema;
        ya.control.exposicionPorDefecto = exposicion;
      }
      return ya;
    }
    final c = ClaseConReloj._(this, clave, RelojCompartido.deClase(db, oposicion, alumnoUid: alumnoUid, canteId: claseId, miUid: miUid, miNombre: miNombre),
        esquema: esquema, exposicion: exposicion, otroNombre: otroNombre, miUid: miUid, nombreTema: nombreTema, ruta: ruta, fin: fin, efectos: efectos);
    _clases[clave] = c;
    return c;
  }

  /// Una pantalla deja de usar el cronómetro de [c].
  void soltar(ClaseConReloj c) {
    c._usuarios--;
    c.visible = false;
    _revisar(c);
  }

  void _revisar(ClaseConReloj c) {
    if (c._usuarios > 0 || vigente(c.control.reloj, _ahora(), fin: c.fin)) {
      poner(c, RelojFlotante(clave: c.clave, fuente: c.control, abrir: c.abrir, visible: c.visible, fin: c.fin));
      return;
    }
    _clases.remove(c.clave);
    poner(c, null);
    c._cerrar();
  }

  /// Quita las clases que ya han terminado y nadie mira (lo llama el mini
  /// reloj de vez en cuando).
  void limpiar() {
    for (final c in _clases.values.toList()) {
      _revisar(c);
    }
  }

  @override
  void dispose() {
    _cerrado = true;
    for (final c in _clases.values) {
      c._cerrar();
    }
    _clases.clear();
    super.dispose();
  }
}

/// El cronómetro compartido de una clase, con su escucha de Firestore y su
/// control ([ControlRelojClase]), vivo mientras alguna pantalla lo use o
/// esté en curso.
class ClaseConReloj extends ChangeNotifier {
  ClaseConReloj._(this._registro, this.clave, this.compartido,
      {required Duration esquema, required Duration exposicion, required String otroNombre, required String miUid, required this.ruta, String? Function(String codigo)? nombreTema, this.fin, bool efectos = true}) {
    control = ControlRelojClase(
      esquemaPorDefecto: esquema,
      exposicionPorDefecto: exposicion,
      otroNombre: otroNombre,
      miUid: miUid,
      publicador: (r, {temas = const [], elegido}) => compartido.publicar(r, temas: temas, elegido: elegido),
      nombreTema: nombreTema,
      alAvisar: (texto, {required fin}) => alAvisar?.call(texto, fin: fin),
      efectos: efectos,
    )..addListener(_alCambiar);
    compartido.medirDesfase();
    _escucha = compartido.escucharConErrores().listen(
      (e) {
        cargado = true;
        error = null;
        control.recibir(e);
      },
      onError: (Object e) {
        cargado = true;
        error = e.toString().contains('permission') ? 'sin permiso' : 'sin conexión';
        notifyListeners();
      },
    );
  }

  final RelojesEnCurso _registro;
  final String clave;
  final RelojCompartido compartido;
  late final ControlRelojClase control;
  StreamSubscription<EstadoRelojCompartido?>? _escucha;
  int _usuarios = 1;
  bool _cerrado = false;

  /// `ruta:/clase?id=…` o `ruta:/cantes?cante=…`: la pantalla de la clase.
  final String ruta;
  DateTime? fin;
  bool cargado = false;
  String? error;

  /// Su pantalla está a la vista.
  bool visible = false;

  /// Avisos al pasar un hito, para la pantalla que lo enseña.
  void Function(String texto, {required bool fin})? alAvisar;

  void abrir() => _registro.abrirContenido?.call(ruta);

  /// La pantalla que lo enseña dice si está a la vista.
  void ponerVisible(bool si) {
    if (visible == si) return;
    visible = si;
    _registro._revisar(this);
  }

  void _alCambiar() {
    if (_cerrado) return;
    notifyListeners();
    _registro._revisar(this);
  }

  void _cerrar() {
    if (_cerrado) return;
    _cerrado = true;
    _escucha?.cancel();
    control.removeListener(_alCambiar);
    control.dispose();
    dispose();
  }
}

/// El registro de los cronómetros en curso.
final relojesEnCursoProvider = Provider<RelojesEnCurso>((ref) {
  final r = RelojesEnCurso();
  ref.onDispose(r.dispose);
  return r;
});

/// Si la pantalla de [context] está a la vista: su ruta es la de encima y
/// no está en una pestaña escondida.
bool pantallaALaVista(BuildContext context) => TickerMode.of(context) && (ModalRoute.of(context)?.isCurrent ?? true);

/// El mini reloj flotante: va encima de todas las pantallas (en el `builder`
/// de la app) y solo aparece con una clase con el cronómetro en marcha o en
/// pausa cuya pantalla no se está viendo. Enseña la fase y el tiempo (como
/// el reloj grande, hacia delante o cuenta atrás), un botón para pausar o
/// continuar (lo mismo que el del reloj grande) y, al tocarlo, vuelve a la
/// clase. Se arrastra a donde moleste menos y recuerda el sitio; por defecto
/// va arriba a la derecha, lejos de la burbuja de EconomIA (abajo).
class MiniRelojFlotante extends ConsumerStatefulWidget {
  const MiniRelojFlotante({super.key});

  @override
  ConsumerState<MiniRelojFlotante> createState() => _MiniRelojFlotanteState();
}

class _MiniRelojFlotanteState extends ConsumerState<MiniRelojFlotante> {
  static const _clavePosicion = 'reloj_flotante_pos';
  static const _ancho = 176.0;
  static const _alto = 56.0;
  Timer? _tic;
  int _vueltas = 0;

  /// Posición guardada, en fracciones del hueco libre (0-1), o null (arriba a la derecha).
  Offset? _pos;

  @override
  void initState() {
    super.initState();
    try {
      final v = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app).get(_clavePosicion) : null;
      if (v is List && v.length == 2) _pos = Offset((v[0] as num).toDouble(), (v[1] as num).toDouble());
    } catch (_) {}
  }

  void _guardar() {
    final p = _pos;
    if (p == null) return;
    try {
      if (Hive.isBoxOpen(Cajas.app)) Hive.box(Cajas.app).put(_clavePosicion, [p.dx, p.dy]);
    } catch (_) {}
  }

  void _ritmo(bool hace) {
    if (hace && _tic == null) {
      _tic = Timer.periodic(const Duration(milliseconds: 500), (_) {
        if (!mounted) return;
        // De vez en cuando, fuera las clases ya terminadas.
        if (++_vueltas % 20 == 0) ref.read(relojesEnCursoProvider).limpiar();
        setState(() {});
      });
    } else if (!hace && _tic != null) {
      _tic!.cancel();
      _tic = null;
    }
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registro = ref.watch(relojesEnCursoProvider);
    return ListenableBuilder(
      listenable: registro,
      builder: (context, _) {
        final f = registro.flotante();
        // El ritmo sigue aunque no se vea (para que aparezca o se vaya a su hora).
        _ritmo(registro._entradas.isNotEmpty);
        if (f == null) return const SizedBox.shrink();
        return LayoutBuilder(builder: (context, c) {
          final mq = MediaQuery.of(context);
          final minX = mq.padding.left + 8, maxX = c.maxWidth - mq.padding.right - _ancho - 8;
          final minY = mq.padding.top + 8, maxY = c.maxHeight - mq.padding.bottom - _alto - 8;
          // Por defecto, arriba a la derecha, bajo la cabecera.
          final p = _pos ?? Offset(1, ((64.0) / (maxY - minY).clamp(1, double.infinity)).clamp(0.0, 1.0));
          final x = minX + (maxX - minX).clamp(0, double.infinity) * p.dx.clamp(0.0, 1.0);
          final y = minY + (maxY - minY).clamp(0, double.infinity) * p.dy.clamp(0.0, 1.0);
          return Stack(children: [
            Positioned(
              left: x,
              top: y,
              child: GestureDetector(
                onPanUpdate: (d) => setState(() {
                  final nx = ((x + d.delta.dx - minX) / (maxX - minX).clamp(1, double.infinity)).clamp(0.0, 1.0);
                  final ny = ((y + d.delta.dy - minY) / (maxY - minY).clamp(1, double.infinity)).clamp(0.0, 1.0);
                  _pos = Offset(nx, ny);
                }),
                onPanEnd: (_) => _guardar(),
                child: _Mini(reloj: f, ancho: _ancho, alto: _alto, alCambiar: () => setState(() {})),
              ),
            ),
          ]);
        });
      },
    );
  }
}

class _Mini extends StatelessWidget {
  const _Mini({required this.reloj, required this.ancho, required this.alto, required this.alCambiar});
  final RelojFlotante reloj;
  /// Para repintar en cuanto se pausa o se continúa.
  final VoidCallback alCambiar;
  final double ancho;
  final double alto;

  @override
  Widget build(BuildContext context) {
    final f = reloj.fuente;
    final r = f.reloj;
    final ahora = DateTime.now();
    final esquema = r.preparacion > Duration.zero && r.enPreparacion(ahora);
    final esperando = r.esperandoExposicion(ahora);
    final terminado = r.terminado(ahora);
    final lectura = lecturaReloj(r, ahora, f.modo);
    final ultimoMinuto = !esquema && !esperando && r.restanteFase(ahora).inSeconds <= 60;
    final fase = terminado ? 'Tiempo cumplido' : (esperando ? 'Esquema terminado' : (esquema ? 'Esquema' : 'Exposición'));
    final esq = Theme.of(context).colorScheme;
    // Mismos colores que la tarjeta del cronómetro: dorado en el esquema,
    // rojo al final; el fondo es el de las superficies (claro u oscuro).
    final color = lectura.pasado || ultimoMinuto ? esq.error : (esquema || esperando ? context.colores.dorado : esq.primary);
    final pausado = !r.corriendo;
    final textoBoton = esperando ? 'Empezar la exposición' : (pausado ? 'Continuar' : 'Pausar');
    return Semantics(
      container: true,
      label: 'Cronómetro de la clase',
      child: Material(
        elevation: 6,
        color: esq.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radios.tarjeta), side: BorderSide(color: color.withValues(alpha: 0.6))),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: ancho,
          height: alto,
          child: Row(children: [
            Expanded(
              child: InkWell(
                key: const ValueKey('mini-reloj-abrir'),
                onTap: reloj.abrir,
                child: Semantics(
                  button: true,
                  label: 'Volver a la clase',
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(pausado && !terminado && !esperando ? '$fase · en pausa' : fase,
                          maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall?.copyWith(color: esq.onSurfaceVariant)),
                      Text(lectura.texto,
                          maxLines: 1,
                          style: context.textos.titleLarge?.copyWith(color: color, fontFeatures: const [FontFeature.tabularFigures()], height: 1.1)),
                    ]),
                  ),
                ),
              ),
            ),
            IconButton(
              key: const ValueKey('mini-reloj-alternar'),
              // Sin tooltip: el mini reloj va fuera del Navigator (sin Overlay).
              icon: Icon(esperando ? Icons.record_voice_over_outlined : (pausado ? Icons.play_arrow : Icons.pause), semanticLabel: textoBoton),
              color: esq.primary,
              // Lo mismo que el botón principal del reloj grande.
              onPressed: () {
                esperando ? f.empezarExposicion() : f.alternar();
                alCambiar();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
