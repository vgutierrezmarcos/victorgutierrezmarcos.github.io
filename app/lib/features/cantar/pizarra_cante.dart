import 'package:intl/intl.dart';

import 'pizarra_trazos.dart';
import 'reloj_cante.dart';
import 'transcripcion.dart' show codigoParaFichero;

/// La pizarra de un cante, en el tiempo: cada trazo, forma o texto con el
/// momento de la exposición en que apareció (el mismo reloj que las marcas
/// de la transcripción: el tiempo de esquema no cuenta y las pausas
/// tampoco), y cuándo se quitó, se vació una página o se pasó de página.
/// Con eso se saca el PDF que lee la IA: una página por minuto en que cambió
/// la pizarra y otra justo antes de cada borrado. Lógica pura (sin Flutter).

/// Qué pasa en la pizarra.
enum TipoEventoPizarra {
  /// Aparece un trazo (dibujado aquí o llegado del otro, en una clase).
  poner('p'),

  /// Se quita un trazo (goma, deshacer, mover con el lazo).
  quitar('q'),

  /// Se vacía la página entera (o se elimina).
  borrar('b'),

  /// Se pasa a otra página.
  pagina('v');

  const TipoEventoPizarra(this.codigo);
  final String codigo;

  static TipoEventoPizarra? deCodigo(String? c) => values.where((t) => t.codigo == c).firstOrNull;
}

class EventoPizarra {
  const EventoPizarra(this.tipo, {required this.en, required this.hoja, this.tema, this.trazo, this.id});

  final TipoEventoPizarra tipo;

  /// Momento de la exposición (como las marcas `[mm:ss]` de la transcripción).
  final Duration en;

  /// La página de la pizarra (`p1`, `p2`…).
  final String hoja;

  /// El tema que se cantaba (con dos temas, cada uno empieza en 00:00).
  final String? tema;

  /// El trazo que aparece (en [TipoEventoPizarra.poner]), con su color ya puesto.
  final Trazo? trazo;

  /// El trazo que se quita (en [TipoEventoPizarra.quitar]).
  final String? id;

  Map<String, dynamic> toJson() => {
        'k': tipo.codigo,
        's': en.inMilliseconds,
        'h': hoja,
        if (tema != null) 'm': tema,
        if (trazo != null) 't': trazo!.toJson(),
        if (id != null) 'i': id,
      };

  static EventoPizarra? fromJson(Map<dynamic, dynamic> j) {
    final tipo = TipoEventoPizarra.deCodigo(j['k']?.toString());
    if (tipo == null) return null;
    final t = j['t'];
    return EventoPizarra(
      tipo,
      en: Duration(milliseconds: (j['s'] as num?)?.toInt() ?? 0),
      hoja: j['h']?.toString() ?? 'p1',
      tema: j['m']?.toString(),
      trazo: t is Map ? Trazo.fromJson(t) : null,
      id: j['i']?.toString(),
    );
  }
}

/// Lo que va grabando la pizarra mientras se canta. La pizarra le pasa cada
/// lectura de sus páginas ([observar]) y cada cambio de página ([verHoja]);
/// ella compara con la anterior y anota lo que ha cambiado con el tiempo de
/// exposición de [reloj].
///
/// Antes de que empiece el cronómetro ([grabando] falso) no hay eventos: lo
/// que haya en la pizarra queda como punto de partida ([inicial]) y sale,
/// más claro, en la primera página del PDF.
class CronologiaPizarra {
  CronologiaPizarra({Duration Function(DateTime ahora)? reloj, String? Function()? tema, bool Function()? grabando})
      : reloj = reloj ?? ((_) => Duration.zero),
        tema = tema ?? (() => null),
        grabando = grabando ?? (() => true);

  /// Tiempo de exposición en cada momento (`RelojCante.expuesto`).
  Duration Function(DateTime ahora) reloj;

  /// El tema que se canta ahora.
  String? Function() tema;

  /// Si ya ha empezado el cante (antes, solo se toma el punto de partida).
  bool Function() grabando;

  final eventos = <EventoPizarra>[];

  /// La pizarra al empezar a grabar, por página.
  final Map<String, Map<String, Trazo>> inicial = {};

  /// El papel y el número de cada página.
  final Map<String, String> fondos = {};
  final Map<String, int> numeros = {};

  /// Hora del primer evento (para la fecha del fichero).
  DateTime? inicio;

  /// La pizarra tal como está ahora, por página.
  final Map<String, Map<String, Trazo>> _estado = {};
  String? _hojaVista;

  /// Si no se ha dibujado nada durante el cante (no se guarda).
  bool get vacia => !eventos.any((e) => e.tipo == TipoEventoPizarra.poner);

  void _anotar(EventoPizarra Function(Duration en, String? tema) evento, DateTime ahora) {
    inicio ??= ahora;
    eventos.add(evento(reloj(ahora), tema()));
  }

  /// Una lectura de la pizarra: lo que ha aparecido o desaparecido desde la
  /// anterior. Una página que se queda sin nada de golpe (o desaparece) es un
  /// borrado. [colorDe] da el color ARGB con que se ve cada trazo (el de
  /// quien lo pintó si no eligió otro), para que el PDF lo pinte igual.
  void observar(List<PaginaPizarra> paginas, {required DateTime ahora, int Function(Trazo t)? colorDe}) {
    final graba = eventos.isNotEmpty || grabando();
    final vistas = <String>{};
    for (final p in paginas) {
      vistas.add(p.id);
      numeros[p.id] = p.n;
      fondos[p.id] = p.fondo;
      final antes = _estado.putIfAbsent(p.id, () => {});
      final ahoraIds = {for (final t in p.trazos) t.id};
      final quitados = [for (final id in antes.keys) if (!ahoraIds.contains(id)) id];
      if (p.trazos.isEmpty && antes.isNotEmpty) {
        if (graba) _anotar((en, tema) => EventoPizarra(TipoEventoPizarra.borrar, en: en, hoja: p.id, tema: tema), ahora);
        antes.clear();
      } else {
        for (final id in quitados) {
          antes.remove(id);
          if (graba) _anotar((en, tema) => EventoPizarra(TipoEventoPizarra.quitar, en: en, hoja: p.id, tema: tema, id: id), ahora);
        }
      }
      for (final t in p.trazos) {
        if (antes.containsKey(t.id)) continue;
        final c = colorDe == null || t.color != null ? t : t.copia(id: t.id, color: colorDe(t));
        antes[t.id] = c;
        if (graba) _anotar((en, tema) => EventoPizarra(TipoEventoPizarra.poner, en: en, hoja: p.id, tema: tema, trazo: c), ahora);
      }
    }
    // Páginas eliminadas.
    for (final id in [..._estado.keys]) {
      if (vistas.contains(id)) continue;
      if (_estado[id]!.isNotEmpty && graba) _anotar((en, tema) => EventoPizarra(TipoEventoPizarra.borrar, en: en, hoja: id, tema: tema), ahora);
      _estado.remove(id);
    }
    if (!graba) _tomarPartida();
  }

  /// Se pasa a la página [hoja].
  void verHoja(String hoja, {required DateTime ahora}) {
    if (hoja == _hojaVista) return;
    _hojaVista = hoja;
    if (eventos.isNotEmpty || grabando()) _anotar((en, tema) => EventoPizarra(TipoEventoPizarra.pagina, en: en, hoja: hoja, tema: tema), ahora);
  }

  void _tomarPartida() {
    inicial
      ..clear()
      ..addAll({for (final e in _estado.entries) if (e.value.isNotEmpty) e.key: Map.of(e.value)});
  }

  /// El cronómetro vuelve a cero: lo grabado se olvida (las marcas ya no
  /// casarían) y lo que hay ahora en la pizarra pasa a ser el punto de partida.
  void reiniciar() {
    eventos.clear();
    inicio = null;
    _tomarPartida();
  }

  Map<String, dynamic> toJson() => {
        'v': 1,
        'inicial': {for (final e in inicial.entries) e.key: [for (final t in e.value.values) t.toJson()]},
        'fondos': Map.of(fondos),
        'numeros': Map.of(numeros),
        'eventos': [for (final e in eventos) e.toJson()],
      };

  factory CronologiaPizarra.fromJson(Map<dynamic, dynamic> j) {
    final c = CronologiaPizarra();
    final ini = j['inicial'];
    if (ini is Map) {
      for (final e in ini.entries) {
        final lista = e.value;
        if (lista is! List) continue;
        final trazos = [for (final t in lista) if (t is Map) Trazo.fromJson(t)];
        c.inicial[e.key.toString()] = {for (final t in trazos) t.id: t};
      }
    }
    final f = j['fondos'];
    if (f is Map) c.fondos.addAll({for (final e in f.entries) e.key.toString(): e.value.toString()});
    final n = j['numeros'];
    if (n is Map) c.numeros.addAll({for (final e in n.entries) if (e.value is num) e.key.toString(): (e.value as num).toInt()});
    for (final e in (j['eventos'] as List?) ?? const []) {
      if (e is Map) {
        final ev = EventoPizarra.fromJson(e);
        if (ev != null) c.eventos.add(ev);
      }
    }
    return c;
  }

  /// Las páginas del PDF (ver [paginasDeCante]).
  List<PaginaCante> paginas({required DateTime fecha}) => paginasDeCante(this, fecha: fecha);
}

/// Una página del PDF de la pizarra del cante: la pizarra en un momento.
class PaginaCante {
  PaginaCante({required this.desde, required this.hasta, required this.tema, required this.hoja, required this.fondo, required this.trazos, required this.nuevos, this.antesDeBorrar = false});

  /// El tramo del cante que enseña (`[03:00]–[04:00]`).
  final Duration desde;
  final Duration hasta;
  final String? tema;
  final String hoja;
  final String fondo;

  /// Lo que hay en la pizarra al final del tramo.
  final List<Trazo> trazos;

  /// Los que han aparecido en este tramo (se ven con su color; el resto, más claros).
  final Set<String> nuevos;

  /// La página justo antes de vaciarla.
  final bool antesDeBorrar;

  /// Si después se vacía la página sin haber dibujado nada más: cuándo.
  Duration? borradaEn;

  /// Número de la página de la pizarra, si se usó más de una (para la cabecera).
  int? numeroHoja;
}

/// Las páginas del PDF: por cada tema (cada uno desde 00:00, como en la
/// transcripción), una por minuto de exposición en que cambió la pizarra,
/// con la pizarra como estaba al acabar ese minuto (todo lo que hay desde el
/// último borrado), y otra justo antes de cada borrado si desde la anterior
/// se había dibujado algo. Si se usaron varias páginas de la pizarra, una
/// por cada página que cambió.
List<PaginaCante> paginasDeCante(CronologiaPizarra c, {required DateTime fecha}) {
  final estado = <String, Map<String, Trazo>>{for (final e in c.inicial.entries) e.key: Map.of(e.value)};
  // Lo que ya salió en la última página de cada hoja (para resaltar lo nuevo).
  final vistos = <String, Set<String>>{for (final e in c.inicial.entries) e.key: {...e.value.keys}};
  final ultima = <String, PaginaCante>{};
  final cambiadas = <String>{};
  final salida = <PaginaCante>[];
  final varias = {...c.inicial.keys, for (final e in c.eventos) if (e.tipo != TipoEventoPizarra.pagina) e.hoja}.length > 1;

  int numero(String hoja) => c.numeros[hoja] ?? int.tryParse(hoja.replaceFirst('p', '')) ?? 1;

  PaginaCante pagina(String hoja, Duration desde, Duration hasta, String? tema, {bool antesDeBorrar = false}) {
    final trazos = estado[hoja]!.values.toList();
    final p = PaginaCante(
      desde: desde,
      hasta: hasta,
      tema: tema,
      hoja: hoja,
      fondo: c.fondos[hoja] ?? fondoBlanco,
      trazos: trazos,
      nuevos: {for (final t in trazos) if (!(vistos[hoja]?.contains(t.id) ?? false)) t.id},
      antesDeBorrar: antesDeBorrar,
    )..numeroHoja = varias ? numero(hoja) : null;
    vistos[hoja] = {for (final t in trazos) t.id};
    ultima[hoja] = p;
    salida.add(p);
    return p;
  }

  int? minuto;
  String? temaActual;
  Duration anterior = Duration.zero;
  var empezado = false;

  void cerrarMinuto() {
    final m = minuto;
    if (m == null) return;
    final hojas = cambiadas.toList()..sort((a, b) => numero(a).compareTo(numero(b)));
    for (final h in hojas) {
      if ((estado[h] ?? const {}).isEmpty) {
        vistos[h] = {};
        continue;
      }
      pagina(h, Duration(minutes: m), Duration(minutes: m + 1), temaActual);
    }
    cambiadas.clear();
    minuto = null;
  }

  for (final e in c.eventos) {
    // Otro tema (o el reloj vuelve atrás): se cierra lo anterior y se empieza de cero.
    final otroTramo = empezado && (e.tema != temaActual || e.en < anterior - const Duration(seconds: 1));
    if (otroTramo || (minuto != null && e.en.inMinutes != minuto)) cerrarMinuto();
    empezado = true;
    temaActual = e.tema;
    anterior = e.en;
    minuto = e.en.inMinutes;
    final hoja = estado.putIfAbsent(e.hoja, () => {});
    switch (e.tipo) {
      case TipoEventoPizarra.poner:
        if (e.trazo == null) break;
        hoja[e.trazo!.id] = e.trazo!;
        cambiadas.add(e.hoja);
      case TipoEventoPizarra.quitar:
        if (hoja.remove(e.id) != null) cambiadas.add(e.hoja);
      case TipoEventoPizarra.borrar:
        if (hoja.isNotEmpty) {
          if (cambiadas.contains(e.hoja)) {
            pagina(e.hoja, Duration(minutes: e.en.inMinutes), e.en, e.tema, antesDeBorrar: true);
          } else {
            // Lo que había ya salió en su página: se anota allí que se borra.
            ultima[e.hoja]?.borradaEn ??= e.en;
          }
        }
        hoja.clear();
        vistos[e.hoja] = {};
        cambiadas.remove(e.hoja);
        ultima.remove(e.hoja);
      case TipoEventoPizarra.pagina:
        break;
    }
  }
  cerrarMinuto();
  return salida;
}

const _meses = ['ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.', 'jul.', 'ago.', 'sept.', 'oct.', 'nov.', 'dic.'];

/// «3 nov. 2026».
String fechaDeCante(DateTime f) => '${f.day} ${_meses[f.month - 1]} ${f.year}';

/// La cabecera de una página: `[03:00]–[04:00] · Tema 3.A.8 · Cante del 3 nov. 2026`,
/// con la página de la pizarra si se usó más de una y si es la de antes de
/// un borrado.
String cabeceraPaginaCante(PaginaCante p, DateTime fecha) => [
      '[${formatoReloj(p.desde)}]–[${formatoReloj(p.hasta)}]',
      if (p.tema != null) 'Tema ${p.tema}',
      'Cante del ${fechaDeCante(fecha)}',
      if (p.numeroHoja != null) 'página ${p.numeroHoja} de la pizarra',
      if (p.antesDeBorrar) 'antes de borrar',
      if (p.borradaEn != null) 'se borra en [${formatoReloj(p.borradaEn!)}]',
    ].join(' · ');

/// `pizarra_3A08_2026-11-03.pdf` (como el `.txt` de la transcripción).
String nombreFicheroPizarra(String? tema, DateTime fecha) => 'pizarra_${tema == null ? 'tema' : codigoParaFichero(tema)}_${DateFormat('yyyy-MM-dd').format(fecha)}.pdf';

/// La línea que se añade a la cabecera del `.txt` cuando hay PDF de la pizarra.
String lineaPizarra(String nombrePdf) => 'Pizarra: $nombrePdf (una página por minuto con su marca [mm:ss])';

/// El `.txt` con la línea de la pizarra [nombrePdf] (o sin ella, si es null):
/// va justo antes del aviso de la transcripción automática.
String conLineaPizarra(String texto, String? nombrePdf) {
  final lineas = texto.split('\n').where((l) => !l.startsWith('Pizarra: ')).toList();
  if (nombrePdf != null) {
    final i = lineas.indexWhere((l) => l.startsWith('Transcripción automática'));
    final hueco = lineas.indexOf('');
    final donde = i >= 0 ? i : (hueco >= 0 ? hueco : lineas.length);
    lineas.insert(donde, lineaPizarra(nombrePdf));
  }
  return lineas.join('\n');
}
