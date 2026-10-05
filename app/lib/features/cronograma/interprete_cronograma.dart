/// Intérprete de cronogramas hechos fuera de la app: un texto pegado o el
/// texto de un Excel, un Word, un PDF o un CSV. Busca en cada línea fechas de
/// cante («5/10», «5 de octubre», «2026-10-05»), marcas de semana («Semana 3»)
/// y códigos de tema («3A1», «3.A.1», «A1» con el ejercicio deducido, rangos
/// como «A1-A5»), y los agrupa por semanas. Lo que no entiende se devuelve
/// aparte para que el opositor lo vea. Puro Dart, sin Flutter.
library;

import '../../data/models/cronograma.dart';

/// Una semana leída: la fecha de su cante (si la había) y sus temas.
class SemanaLeida {
  SemanaLeida({this.fecha, List<String>? temas}) : temas = temas ?? [];
  final DateTime? fecha;
  final List<String> temas;
}

/// Resultado de leer un cronograma.
class CronogramaLeido {
  const CronogramaLeido({required this.semanas, this.noReconocidas = const []});
  final List<SemanaLeida> semanas;
  /// Líneas con contenido en las que no se ha reconocido nada.
  final List<String> noReconocidas;

  bool get vacio => semanas.every((s) => s.temas.isEmpty);
  bool get conFechas => semanas.isNotEmpty && semanas.every((s) => s.fecha != null);
  int get temas => semanas.fold(0, (t, s) => t + s.temas.length);
}

const _meses = {
  'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4, 'mayo': 5, 'junio': 6,
  'julio': 7, 'agosto': 8, 'septiembre': 9, 'setiembre': 9, 'octubre': 10, 'noviembre': 11, 'diciembre': 12,
  'ene': 1, 'feb': 2, 'mar': 3, 'abr': 4, 'may': 5, 'jun': 6, 'jul': 7, 'ago': 8, 'sep': 9, 'sept': 9, 'oct': 10, 'nov': 11, 'dic': 12,
};

final _reIso = RegExp(r'(?<!\d)(\d{4})-(\d{1,2})-(\d{1,2})(?!\d)');
final _reNumerica = RegExp(r'(?<![\w.])(\d{1,2})[/\-.](\d{1,2})(?:[/\-.](\d{2,4}))?(?![\w.])');
final _reTextual = RegExp(r'(?<!\d)(\d{1,2})\s*(?:de\s+)?(' + _meses.keys.join('|') + r')\.?(?:\s+(?:de\s+)?(\d{4}))?(?![a-záéíóú])', caseSensitive: false);
final _reSemana = RegExp(r'\bsemana\s*(\d{1,3})\b', caseSensitive: false);
// 3A1, 3.A.1, 3-a-1 (con ejercicio) y A1, A.1, A-1 (sin él, en mayúscula).
final _reConEjercicio = RegExp(r'(?<![\w.])([1-9])[.\-]?([A-Za-z])[.\-]?(\d{1,2})(?![\d])');
final _reSinEjercicio = RegExp(r'(?<![\w.])([A-H])[.\-]?(\d{1,2})(?![\d])');
// Rangos: «A1-A5», «3A1 a 3A5», «A1–A5», «A1 al A5».
final _reRango = RegExp(r'(?<![\w.])([1-9][.\-]?)?([A-Za-z])[.\-]?(\d{1,2})\s*(?:-|–|—|\ba\b|\bal\b|\bhasta\b)\s*(?:[1-9][.\-]?)?(?:[A-Za-z][.\-]?)?(\d{1,2})(?![\d])');

/// Lee [texto] (una línea por fila). [codigos] son los temas que existen
/// («3.A.1»…) y [ejercicioPorDefecto], el que se supone cuando un código no
/// lo lleva («A1») y el texto no da pistas. [hoy] fija el año de las fechas
/// sin año: el que deje la fecha más cerca de hoy.
CronogramaLeido interpretarCronograma(String texto, {required Set<String> codigos, int? ejercicioPorDefecto, DateTime? hoy}) {
  final lineas = texto.split(RegExp(r'\r?\n')).map((l) => l.replaceAll('\t', ' ').trim()).where((l) => l.isNotEmpty).toList();
  hoy ??= DateTime.now();
  // Ejercicio más frecuente entre los códigos completos: el de los incompletos.
  final ejercicios = <int, int>{};
  for (final l in lineas) {
    for (final m in _reConEjercicio.allMatches(l)) {
      final c = '${m[1]}.${m[2]!.toUpperCase()}.${int.parse(m[3]!)}';
      if (codigos.contains(c)) ejercicios[int.parse(m[1]!)] = (ejercicios[int.parse(m[1]!)] ?? 0) + 1;
    }
  }
  final ejercicio = ejercicios.isEmpty ? ejercicioPorDefecto : (ejercicios.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;

  final semanas = <SemanaLeida>[];
  final noReconocidas = <String>[];
  final vistos = <String>{};
  final hayMarcas = lineas.any((l) => _fechaDe(l, hoy!) != null || _reSemana.hasMatch(l));
  DateTime? anterior;

  for (final l in lineas) {
    var fecha = _fechaDe(l, hoy);
    // Fechas sin año que retroceden (de diciembre a enero): el año siguiente.
    if (fecha != null && anterior != null && fecha.isBefore(anterior.subtract(const Duration(days: 40))) && !_tieneAnio(l)) {
      fecha = DateTime(fecha.year + 1, fecha.month, fecha.day);
    }
    if (fecha != null) anterior = fecha;
    final marca = fecha != null || _reSemana.hasMatch(l);
    // Los códigos de la línea, sin la parte de fecha (para no leer «5/10» como tema).
    final temas = [for (final t in _codigosDe(_sinFechas(l), codigos, ejercicio)) if (vistos.add(t)) t];
    if (marca || !hayMarcas) {
      if (marca || temas.isNotEmpty) semanas.add(SemanaLeida(fecha: fecha, temas: temas));
    } else if (temas.isNotEmpty) {
      if (semanas.isEmpty) semanas.add(SemanaLeida());
      semanas.last.temas.addAll(temas);
    }
    if (!marca && temas.isEmpty && RegExp(r'[A-Za-z0-9]').hasMatch(l)) noReconocidas.add(l);
  }
  // Semanas sin temas al final (cabeceras, totales): fuera.
  while (semanas.isNotEmpty && semanas.last.temas.isEmpty) {
    semanas.removeLast();
  }
  // Con fechas en todas, en orden de fecha.
  if (semanas.isNotEmpty && semanas.every((s) => s.fecha != null)) semanas.sort((a, b) => a.fecha!.compareTo(b.fecha!));
  return CronogramaLeido(semanas: semanas, noReconocidas: noReconocidas);
}

/// Lee una hoja de cálculo o una tabla: cada fila es una línea (sus celdas,
/// separadas por espacios).
CronogramaLeido interpretarTabla(List<List<String>> filas, {required Set<String> codigos, int? ejercicioPorDefecto, DateTime? hoy}) =>
    interpretarCronograma([for (final f in filas) f.where((c) => c.trim().isNotEmpty).join('   ')].join('\n'), codigos: codigos, ejercicioPorDefecto: ejercicioPorDefecto, hoy: hoy);

bool _tieneAnio(String l) => _reIso.hasMatch(l) || RegExp(r'\d{1,2}[/\-.]\d{1,2}[/\-.]\d{2,4}').hasMatch(l) || RegExp(r'\b(19|20)\d{2}\b').hasMatch(l);

String _sinFechas(String l) => l.replaceAll(_reIso, ' ').replaceAll(_reTextual, ' ').replaceAll(_reNumerica, ' ').replaceAll(_reSemana, ' ');

DateTime? _fechaDe(String l, DateTime hoy) {
  DateTime? valida(int a, int m, int d) {
    if (m < 1 || m > 12 || d < 1 || d > 31) return null;
    final f = DateTime(a, m, d);
    return f.month == m ? f : null;
  }

  int anio(int m, int d) {
    // Sin año: el que deje la fecha más cerca de hoy.
    final candidatos = [hoy.year - 1, hoy.year, hoy.year + 1];
    candidatos.sort((a, b) => DateTime(a, m, d).difference(hoy).inDays.abs().compareTo(DateTime(b, m, d).difference(hoy).inDays.abs()));
    return candidatos.first;
  }

  final iso = _reIso.firstMatch(l);
  if (iso != null) return valida(int.parse(iso[1]!), int.parse(iso[2]!), int.parse(iso[3]!));
  final t = _reTextual.firstMatch(l);
  if (t != null) {
    final d = int.parse(t[1]!);
    final m = _meses[t[2]!.toLowerCase()]!;
    return valida(t[3] != null ? int.parse(t[3]!) : anio(m, d), m, d);
  }
  final n = _reNumerica.firstMatch(l);
  if (n != null) {
    final d = int.parse(n[1]!);
    final m = int.parse(n[2]!);
    var a = n[3] == null ? null : int.parse(n[3]!);
    if (a != null && a < 100) a += 2000;
    return valida(a ?? anio(m, d), m, d);
  }
  return null;
}

/// Códigos de tema de una línea, en orden, validados contra [codigos].
List<String> _codigosDe(String l, Set<String> codigos, int? ejercicio) {
  final out = <(int, String)>[];
  final ocupado = List.filled(l.length, false);
  void marcar(Match m) {
    for (var i = m.start; i < m.end; i++) {
      ocupado[i] = true;
    }
  }

  bool libre(Match m) => !ocupado.sublist(m.start, m.end).any((o) => o);

  // Rangos primero.
  for (final m in _reRango.allMatches(l)) {
    final ej = m[1] != null ? int.parse(m[1]!.replaceAll(RegExp(r'[.\-]'), '')) : ejercicio;
    if (ej == null) continue;
    final parte = m[2]!.toUpperCase();
    final desde = int.parse(m[3]!);
    final hasta = int.parse(m[4]!);
    if (hasta <= desde || hasta - desde > 30) continue;
    final rango = [for (var n = desde; n <= hasta; n++) '$ej.$parte.$n'].where(codigos.contains).toList();
    if (rango.isEmpty) continue;
    marcar(m);
    for (final c in rango) {
      out.add((m.start, c));
    }
  }
  for (final m in _reConEjercicio.allMatches(l)) {
    if (!libre(m)) continue;
    final c = '${m[1]}.${m[2]!.toUpperCase()}.${int.parse(m[3]!)}';
    if (!codigos.contains(c)) continue;
    marcar(m);
    out.add((m.start, c));
  }
  if (ejercicio != null) {
    for (final m in _reSinEjercicio.allMatches(l)) {
      if (!libre(m)) continue;
      final c = '$ejercicio.${m[1]}.${int.parse(m[2]!)}';
      if (!codigos.contains(c)) continue;
      marcar(m);
      out.add((m.start, c));
    }
  }
  out.sort((a, b) => a.$1.compareTo(b.$1));
  return [for (final e in out) e.$2];
}

/// Semanas del cronograma a partir de lo leído. Con fechas, el día de cante es
/// el de la primera y los huecos entre fechas son semanas de descanso; sin
/// ellas, semanas seguidas desde [primerCante].
({DateTime inicio, int diaCante, List<SemanaPlan> semanas}) semanasDesdeLeido(CronogramaLeido leido, {required DateTime primerCante}) {
  final conFechas = leido.conFechas;
  final diaCante = conFechas ? leido.semanas.first.fecha!.weekday : primerCante.weekday;
  final porLunes = <DateTime, List<String>>{};
  if (conFechas) {
    for (final s in leido.semanas) {
      (porLunes[inicioSemana(s.fecha!, diaCante)] ??= []).addAll(s.temas);
    }
  } else {
    var l = inicioSemana(primerCante, diaCante);
    for (final s in leido.semanas) {
      porLunes[l] = [...s.temas];
      l = DateTime(l.year, l.month, l.day + 7);
    }
  }
  final lunes = porLunes.keys.toList()..sort();
  final semanas = <SemanaPlan>[];
  if (lunes.isNotEmpty) {
    for (var l = lunes.first; !l.isAfter(lunes.last); l = DateTime(l.year, l.month, l.day + 7)) {
      final temas = porLunes[l];
      semanas.add(temas == null ? SemanaPlan(lunes: l, descanso: true) : SemanaPlan(lunes: l, temas: temas));
    }
  }
  return (inicio: lunes.isEmpty ? inicioSemana(primerCante, diaCante) : lunes.first, diaCante: diaCante, semanas: semanas);
}
