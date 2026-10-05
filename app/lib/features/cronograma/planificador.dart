import '../../data/models/oposicion.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/estructura.dart';

/// Lógica del cronograma, sin interfaz: orden sugerido por bloques
/// y conexiones del PowerPoint de organización, intercalado de los temas más
/// memorísticos (Mixto, en el 3.º) o de las dos partes (4.º), reparto por
/// semanas y replanificación.

/// Compara códigos de tema por sus números: 3.A.2 < 3.A.10 < 3.B.1.
int compararCodigos(String a, String b) {
  final x = a.split('.'), y = b.split('.');
  for (var i = 0; i < x.length && i < y.length; i++) {
    final n = int.tryParse(x[i]), m = int.tryParse(y[i]);
    final c = n != null && m != null ? n.compareTo(m) : x[i].compareTo(y[i]);
    if (c != 0) return c;
  }
  return x.length.compareTo(y.length);
}

/// Orden sugerido para una vuelta: los bloques del ejercicio en el orden del
/// PowerPoint, eligiendo como siguiente el más conectado con lo ya puesto, y
/// dentro de cada bloque un recorrido por las conexiones entre sus temas.
List<String> ordenSugerido(EstructuraTemario e, int ejercicio, Set<String> elegidos) {
  final puestos = <String>[];
  final yaPuestos = <String>{};
  final bloques = e.deEjercicio(ejercicio).where((b) => b.temas.any(elegidos.contains)).toList();
  final bloquesPuestos = <String>{};

  // Conexiones de un tema con lo ya puesto (con temas o con bloques enteros).
  int conexionesCon(String tema) {
    var n = 0;
    for (final r in e.relacionados(tema)) {
      if (r.esTema && yaPuestos.contains(r.tema)) n++;
      if (!r.esTema && bloquesPuestos.contains(r.bloque)) n++;
    }
    return n;
  }

  while (bloques.isNotEmpty) {
    var b = bloques.first;
    if (yaPuestos.isNotEmpty) {
      var mejor = -1;
      for (final c in bloques) {
        final n = c.temas.where(elegidos.contains).fold<int>(0, (s, t) => s + conexionesCon(t));
        if (n > mejor) {
          mejor = n;
          b = c;
        }
      }
    }
    bloques.remove(b);
    bloquesPuestos.add(b.id);
    final pendientes = b.temas.where((t) => elegidos.contains(t) && !yaPuestos.contains(t)).toList()..sort(compararCodigos);
    String? actual;
    while (pendientes.isNotEmpty) {
      final previo = actual;
      final vecinos = previo == null ? const <String>[] : pendientes.where((t) => e.relacionados(previo).any((r) => r.esTema && r.tema == t)).toList();
      var siguiente = vecinos.isNotEmpty ? vecinos.first : pendientes.first;
      if (vecinos.isEmpty) {
        // El más conectado con lo ya puesto; a igualdad, el de número más bajo.
        var mejor = conexionesCon(siguiente);
        for (final t in pendientes.skip(1)) {
          final n = conexionesCon(t);
          if (n > mejor) {
            mejor = n;
            siguiente = t;
          }
        }
      }
      pendientes.remove(siguiente);
      puestos.add(siguiente);
      yaPuestos.add(siguiente);
      actual = siguiente;
    }
  }
  final sueltos = elegidos.where((t) => !yaPuestos.contains(t)).toList()..sort(compararCodigos);
  return [...puestos, ...sueltos];
}

String _parte(String tema) {
  final p = tema.split('.');
  return p.length >= 2 ? '${p[0]}.${p[1]}' : tema;
}

/// Temas que se intercalan con el resto: los de la categoría intercalable del
/// ejercicio (en el 3.º de TCEE, los bloques de Mixto, más memorísticos) o, si
/// no tiene, los de la parte con menos temas, para alternar las partes.
bool Function(String) temaSecundario(EstructuraTemario e, int ejercicio, List<String> temas) {
  final categoria = Oposiciones.actual.ejercicio(ejercicio)?.categoriaIntercalable;
  if (categoria != null) return (t) => e.bloqueDe(t)?.categoria == categoria;
  final porParte = <String, int>{};
  for (final t in temas) {
    porParte[_parte(t)] = (porParte[_parte(t)] ?? 0) + 1;
  }
  if (porParte.length < 2) return (_) => false;
  final menor = (porParte.entries.toList()..sort((a, b) => a.value != b.value ? a.value.compareTo(b.value) : b.key.compareTo(a.key))).first.key;
  return (t) => _parte(t) == menor;
}

/// Intercala los temas secundarios con el resto, manteniendo el orden de cada
/// grupo: repartidos de forma regular según su peso o, con [cadaN], uno de cada N.
List<String> intercalarTemas(List<String> orden, bool Function(String) secundario, {int? cadaN}) {
  final sec = orden.where(secundario).toList();
  final pri = orden.where((t) => !secundario(t)).toList();
  if (sec.isEmpty || pri.isEmpty) return orden;
  final total = orden.length;
  // Posiciones de los secundarios: uno cada N o, en proporción, cada uno en el
  // centro de su tramo ((k + ½) · total / secundarios).
  final posiciones = <int>{};
  for (var k = 0; k < sec.length; k++) {
    var p = cadaN != null && cadaN > 0 ? (k + 1) * cadaN - 1 : ((k + 0.5) * total / sec.length).round();
    if (p >= total) break;
    while (posiciones.contains(p) && p < total - 1) {
      p++;
    }
    posiciones.add(p);
  }
  final out = <String>[];
  var i = 0, j = 0;
  for (var pos = 0; pos < total; pos++) {
    if ((posiciones.contains(pos) && j < sec.length) || i >= pri.length) {
      out.add(sec[j++]);
    } else {
      out.add(pri[i++]);
    }
  }
  return out;
}

/// Orden de partida de una vuelta: el sugerido y, si se pide, intercalado.
List<String> ordenInicial(EstructuraTemario e, int ejercicio, Set<String> elegidos, {bool intercalar = true, int? cadaN}) {
  final orden = ordenSugerido(e, ejercicio, elegidos);
  return intercalar ? intercalarTemas(orden, temaSecundario(e, ejercicio, orden), cadaN: cadaN) : orden;
}

/// Proporción automática de temas intercalados, como «1 de cada N».
int? unoDeCada(EstructuraTemario e, int ejercicio, List<String> temas) {
  final sec = temas.where(temaSecundario(e, ejercicio, temas)).length;
  if (sec == 0 || sec == temas.length) return null;
  return (temas.length / sec).round();
}

/// Semanas hábiles (sin descanso) desde la de [desde] hasta la de [fin].
int semanasHabiles(DateTime desde, DateTime fin, Set<DateTime> descansos, {int? diaCante}) {
  var n = 0;
  for (var l = inicioSemana(desde, diaCante); !l.isAfter(inicioSemana(fin, diaCante)); l = DateTime(l.year, l.month, l.day + 7)) {
    if (!descansos.contains(l)) n++;
  }
  return n;
}

/// Temas por semana para acabar [pendientes] temas en la semana de [fin].
int ritmoPara(int pendientes, DateTime desde, DateTime fin, Set<DateTime> descansos, {int? diaCante}) {
  final semanas = semanasHabiles(desde, fin, descansos, diaCante: diaCante);
  if (semanas <= 0) return pendientes < 1 ? 1 : pendientes;
  final r = (pendientes / semanas).ceil();
  return r < 1 ? 1 : r;
}

/// Reparte [temas] por semanas desde [desde], [porSemana] cada una, saltando los descansos.
List<SemanaPlan> repartir(List<String> temas, DateTime desde, int porSemana, Set<DateTime> descansos, {int? diaCante}) {
  final out = <SemanaPlan>[];
  var l = inicioSemana(desde, diaCante);
  var i = 0;
  final k = porSemana < 1 ? 1 : porSemana;
  while (i < temas.length) {
    if (descansos.contains(l)) {
      out.add(SemanaPlan(lunes: l, descanso: true));
    } else {
      out.add(SemanaPlan(lunes: l, temas: temas.sublist(i, i + k > temas.length ? temas.length : i + k)));
      i += k;
    }
    l = DateTime(l.year, l.month, l.day + 7);
  }
  return out;
}

/// Último día (el del cante, si lo hay) de la semana en la que se acabaría con
/// [pendientes] temas a [porSemana].
DateTime finEstimado(int pendientes, DateTime desde, int porSemana, Set<DateTime> descansos, {int? diaCante}) {
  final semanas = repartir(List.filled(pendientes, ''), desde, porSemana, descansos, diaCante: diaCante);
  return semanas.isEmpty ? inicioSemana(desde, diaCante) : semanas.last.domingo;
}

/// Situación del cronograma en una fecha.
class EstadoCronograma {
  const EstadoCronograma({required this.hechos, required this.total, required this.semanaActual, required this.atrasados, required this.fin});
  final Set<String> hechos;
  final int total;
  /// Semana en curso (null si aún no ha empezado o ya no quedan semanas).
  final SemanaPlan? semanaActual;
  /// Temas de semanas pasadas sin terminar.
  final List<String> atrasados;
  /// Domingo de la última semana con temas.
  final DateTime? fin;

  int get pendientes => total - hechos.length;
  double get progreso => total == 0 ? 0 : hechos.length / total;
  bool get terminado => total > 0 && pendientes == 0;
}

/// Un tema está hecho si se marcó en el cronograma o si tiene una vuelta
/// anotada en su agenda desde que empezó el cronograma (y no se desmarcó).
EstadoCronograma estadoDe(Cronograma c, DateTime hoy, {Map<String, List<DateTime>> vueltas = const {}}) {
  bool hecho(String t) => c.hechos.containsKey(t) || (!c.desmarcados.contains(t) && (vueltas[t] ?? const []).any((v) => !v.isBefore(c.inicio)));
  final hechos = {for (final t in c.temas) if (hecho(t)) t};
  final esta = inicioSemana(hoy, c.diaCante);
  final actual = c.semanas.where((s) => s.lunes == esta).firstOrNull;
  final atrasados = [for (final s in c.semanas.where((s) => s.lunes.isBefore(esta))) ...s.temas.where((t) => !hechos.contains(t))];
  final conTemas = c.semanas.where((s) => s.temas.isNotEmpty);
  return EstadoCronograma(hechos: hechos, total: c.temas.length, semanaActual: actual, atrasados: atrasados, fin: conTemas.isEmpty ? null : conTemas.last.domingo);
}

/// Vuelve a repartir lo pendiente desde la semana en curso (o desde el
/// inicio, si aún no ha empezado), con [porSemana] temas o, con [fin], al
/// ritmo que haga falta para acabar esa semana. Las semanas pasadas se quedan
/// con lo que se hizo en ellas, y la actual, con lo ya hecho en ella.
Cronograma replanificarCronograma(Cronograma c, DateTime hoy, {int? porSemana, DateTime? fin, Map<String, List<DateTime>> vueltas = const {}}) {
  final hechos = estadoDe(c, hoy, vueltas: vueltas).hechos;
  final esta = inicioSemana(hoy, c.diaCante);
  final desde = c.inicio.isAfter(esta) ? c.inicio : esta;
  final pasadas = [
    for (final s in c.semanas.where((s) => s.lunes.isBefore(desde))) SemanaPlan(lunes: s.lunes, temas: s.temas.where(hechos.contains).toList(), descanso: s.descanso),
  ];
  final enPasadas = {for (final s in pasadas) ...s.temas};
  final hechosEsta = c.semanas.where((s) => s.lunes == desde).expand((s) => s.temas).where(hechos.contains).toList();
  // Lo hecho fuera de su semana (antes de tiempo) se queda en la semana en curso.
  for (final t in c.temas) {
    if (hechos.contains(t) && !enPasadas.contains(t) && !hechosEsta.contains(t)) hechosEsta.add(t);
  }
  final pendientes = c.temas.where((t) => !hechos.contains(t)).toList();
  final objetivo = fin ?? (porSemana == null ? c.fin : null);
  final k = porSemana ?? (objetivo != null ? ritmoPara(pendientes.length + hechosEsta.length, desde, objetivo, c.descansos, diaCante: c.diaCante) : c.temasPorSemana);
  final futuras = <SemanaPlan>[];
  if (hechosEsta.isNotEmpty && !c.descansos.contains(desde)) {
    final hueco = (k - hechosEsta.length).clamp(0, pendientes.length);
    futuras.add(SemanaPlan(lunes: desde, temas: [...hechosEsta, ...pendientes.take(hueco)]));
    futuras.addAll(repartir(pendientes.skip(hueco).toList(), DateTime(desde.year, desde.month, desde.day + 7), k, c.descansos, diaCante: c.diaCante));
  } else {
    futuras.addAll(repartir(pendientes, desde, k, c.descansos, diaCante: c.diaCante));
  }
  return c.copyWith(temasPorSemana: k, fin: objetivo, quitarFin: objetivo == null, semanas: [...pasadas, ...futuras]);
}

/// Cronograma nuevo a partir de un orden de temas: [porSemana] temas cada
/// semana o, con [fin], los que hagan falta para acabar esa semana. Con
/// [diaCante], [inicio] es el día del primer cante de la vuelta y cada semana
/// acaba en un cante.
Cronograma crearCronograma({
  required String id,
  required int ejercicio,
  required List<String> temas,
  required DateTime inicio,
  int porSemana = 3,
  DateTime? fin,
  bool intercalar = true,
  int? cadaN,
  bool compartir = false,
  int? diaCante,
}) {
  final lunes = inicioSemana(inicio, diaCante);
  final k = fin != null ? ritmoPara(temas.length, lunes, fin, const {}, diaCante: diaCante) : porSemana;
  final ahora = DateTime.now();
  return Cronograma(
    id: id,
    ejercicio: ejercicio,
    temas: temas,
    inicio: lunes,
    temasPorSemana: k,
    fin: fin,
    intercalar: intercalar,
    cadaN: cadaN,
    semanas: repartir(temas, lunes, k, const {}, diaCante: diaCante),
    compartir: compartir,
    diaCante: diaCante,
    creado: ahora,
    updatedAt: ahora,
  );
}

// ------------------------------------------------------- Cronograma a mano

/// Cronograma hecho a mano (semana a semana o importado): [semanas] seguidas
/// desde [inicio] (las de descanso, vacías). El ejercicio es el de la mayoría
/// de sus temas y el ritmo, la media de las semanas con temas.
Cronograma cronogramaManual({required String id, required DateTime inicio, required int diaCante, required List<SemanaPlan> semanas, bool compartir = false}) {
  final temas = <String>[];
  final limpias = <SemanaPlan>[];
  var l = inicioSemana(inicio, diaCante);
  for (final s in semanas) {
    final suyas = s.descanso ? <String>[] : [for (final t in s.temas) if (!temas.contains(t)) t];
    temas.addAll(suyas);
    limpias.add(SemanaPlan(lunes: l, temas: suyas, descanso: s.descanso));
    l = DateTime(l.year, l.month, l.day + 7);
  }
  final ejercicios = <int, int>{};
  for (final t in temas) {
    final e = int.tryParse(t.split('.').first) ?? 0;
    ejercicios[e] = (ejercicios[e] ?? 0) + 1;
  }
  final conTemas = limpias.where((s) => s.temas.isNotEmpty).toList();
  final ritmo = conTemas.isEmpty ? 1 : (temas.length / conTemas.length).round().clamp(1, 99);
  final ahora = DateTime.now();
  return Cronograma(
    id: id,
    ejercicio: ejercicios.isEmpty ? 0 : (ejercicios.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key,
    temas: temas,
    inicio: inicioSemana(inicio, diaCante),
    temasPorSemana: ritmo,
    descansos: {for (final s in limpias) if (s.descanso) s.lunes},
    semanas: limpias,
    compartir: compartir,
    diaCante: diaCante,
    creado: ahora,
    updatedAt: ahora,
    manual: true,
  );
}

/// [c] con otras semanas: los temas, en el orden de las semanas, y los
/// descansos, los de sus semanas. Queda como hecho a mano.
Cronograma _conSemanas(Cronograma c, List<SemanaPlan> semanas) {
  final temas = [for (final s in semanas) ...s.temas];
  return c.copyWith(semanas: semanas, temas: temas, descansos: {for (final s in semanas) if (s.descanso) s.lunes}, manual: true);
}

/// Pasa [tema] a la semana que empieza en [lunes] (al final de sus temas).
Cronograma moverTema(Cronograma c, String tema, DateTime lunes) => _conSemanas(c, [
      for (final s in c.semanas)
        s.lunes == lunes
            ? SemanaPlan(lunes: s.lunes, temas: [...s.temas.where((t) => t != tema), tema])
            : SemanaPlan(lunes: s.lunes, temas: s.temas.where((t) => t != tema).toList(), descanso: s.descanso),
    ]);

/// Quita [tema] del cronograma.
Cronograma quitarTema(Cronograma c, String tema) => _conSemanas(c, [
      for (final s in c.semanas) SemanaPlan(lunes: s.lunes, temas: s.temas.where((t) => t != tema).toList(), descanso: s.descanso),
    ]);

/// Deja en la semana de [lunes] exactamente [temas] (los que estaban en otra
/// semana pasan a esta). Si era de descanso, deja de serlo.
Cronograma fijarTemasDeSemana(Cronograma c, DateTime lunes, List<String> temas) => _conSemanas(c, [
      for (final s in c.semanas)
        s.lunes == lunes ? SemanaPlan(lunes: s.lunes, temas: temas) : SemanaPlan(lunes: s.lunes, temas: s.temas.where((t) => !temas.contains(t)).toList(), descanso: s.descanso),
    ]);

/// Una semana más al final.
Cronograma anadirSemana(Cronograma c) {
  final ultima = c.semanas.isEmpty ? inicioSemana(c.inicio, c.diaCante) : DateTime(c.semanas.last.lunes.year, c.semanas.last.lunes.month, c.semanas.last.lunes.day + 7);
  return _conSemanas(c, [...c.semanas, SemanaPlan(lunes: ultima)]);
}

/// Descanso en un cronograma a mano: la semana de [lunes] pasa a descanso y
/// ella y las siguientes se retrasan una semana; quitarlo las adelanta.
Cronograma alternarDescansoManual(Cronograma c, DateTime lunes) {
  DateTime mas(DateTime d, int dias) => DateTime(d.year, d.month, d.day + dias);
  final i = c.semanas.indexWhere((s) => s.lunes == lunes);
  if (i < 0) return c;
  final antes = c.semanas.sublist(0, i);
  if (c.semanas[i].descanso) {
    final despues = c.semanas.sublist(i + 1);
    return _conSemanas(c, [...antes, for (final s in despues) SemanaPlan(lunes: mas(s.lunes, -7), temas: s.temas, descanso: s.descanso)]);
  }
  return _conSemanas(c, [
    ...antes,
    SemanaPlan(lunes: lunes, descanso: true),
    for (final s in c.semanas.sublist(i)) SemanaPlan(lunes: mas(s.lunes, 7), temas: s.temas, descanso: s.descanso),
  ]);
}
