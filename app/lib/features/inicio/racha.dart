import '../../data/models/plan.dart';
import '../../data/models/resultado.dart';
import '../../data/repos/usuario_repo.dart';

/// Racha de días seguidos con actividad (test, cante valorado o vuelta a un
/// tema), si el opositor la activa. Sobria: un número, sin insignias.
///
/// Reglas: cuenta los días con actividad encadenados hacia atrás desde hoy
/// (hoy no rompe nada mientras no acabe); **un día suelto** sin actividad no
/// la rompe (dos seguidos, sí); y los días **congelados** (descansos que el
/// opositor apunta, de uno a treinta días seguidos) no cuentan ni rompen.
class Racha {
  const Racha({required this.dias, required this.hoyActivo, this.congeladaHasta});

  /// Días con actividad en la cadena (0 = sin racha).
  final int dias;
  final bool hoyActivo;
  /// Hasta cuándo está congelada (hoy o después), o null si no lo está.
  final DateTime? congeladaHasta;

  bool get congelada => congeladaHasta != null;
  /// Hay algo que perder si hoy no se hace nada (y no está congelada).
  bool get enJuego => dias > 0 && !hoyActivo && !congelada;
}

String _clave(DateTime d) => Ajustes.claveDia(d);
DateTime _dia(DateTime d) => DateTime(d.year, d.month, d.day);

/// [n] días después (o antes), por calendario: sumar `Duration(days: n)` se
/// descuadra la noche del cambio de hora.
DateTime _mas(DateTime d, int n) => DateTime(d.year, d.month, d.day + n);

/// Los días con actividad: tests terminados (de cualquier tipo), cantes
/// hechos y vueltas anotadas en la agenda de los temas.
Set<String> diasActivos({Iterable<ResultadoTest> tests = const [], Iterable<Cante> cantes = const [], Iterable<DateTime> vueltas = const []}) => {
      for (final r in tests) _clave(r.timestamp),
      for (final c in cantes)
        if (c.hecho && !c.borrado) _clave(c.fecha),
      for (final v in vueltas) _clave(v),
    };

/// Los días congelados, a partir de los rangos «desde|hasta» de los ajustes.
Set<String> diasCongelados(Iterable<String> rangos) {
  final out = <String>{};
  for (final r in rangos) {
    final partes = r.split('|');
    if (partes.length != 2) continue;
    final desde = DateTime.tryParse(partes[0]), hasta = DateTime.tryParse(partes[1]);
    if (desde == null || hasta == null) continue;
    for (var d = _dia(desde), i = 0; !d.isAfter(hasta) && i < 400; d = _mas(d, 1), i++) {
      out.add(_clave(d));
    }
  }
  return out;
}

/// Hasta cuándo está congelada a partir de [hoy] (el fin del rango que
/// incluye hoy o el último de los futuros), o null.
DateTime? congeladaHasta(Iterable<String> rangos, DateTime hoy) {
  final h = _dia(hoy);
  DateTime? max;
  for (final r in rangos) {
    final partes = r.split('|');
    if (partes.length != 2) continue;
    final desde = DateTime.tryParse(partes[0]), hasta = DateTime.tryParse(partes[1]);
    if (desde == null || hasta == null || hasta.isBefore(h)) continue;
    if (desde.isAfter(h)) continue;
    if (max == null || hasta.isAfter(max)) max = _dia(hasta);
  }
  return max;
}

/// Congela [dias] días a partir de [desde] (incluido): devuelve los rangos nuevos.
List<String> congelar(List<String> rangos, DateTime desde, int dias) {
  final d = _dia(desde);
  final hasta = _mas(d, dias.clamp(1, 30) - 1);
  return [...rangos, '${_clave(d)}|${_clave(hasta)}'].toSet().toList()..sort();
}

/// Descongela desde [hoy]: los rangos que llegan a hoy o más allá se acortan
/// hasta ayer (lo ya descansado se conserva).
List<String> descongelar(List<String> rangos, DateTime hoy) {
  final h = _dia(hoy);
  final ayer = _clave(_mas(h, -1));
  final out = <String>[];
  for (final r in rangos) {
    final partes = r.split('|');
    if (partes.length != 2) continue;
    final desde = DateTime.tryParse(partes[0]), hasta = DateTime.tryParse(partes[1]);
    if (desde == null || hasta == null) continue;
    if (hasta.isBefore(h)) {
      out.add(r);
    } else if (desde.isBefore(h)) {
      out.add('${partes[0]}|$ayer');
    }
  }
  return out;
}

/// Calcula la racha a [hoy].
Racha calcularRacha({required Set<String> activos, required Set<String> congelados, required DateTime hoy, Iterable<String> rangos = const []}) {
  final h = _dia(hoy);
  final hoyActivo = activos.contains(_clave(h));
  var dias = 0, huecos = 0;
  // Hoy aún no ha acabado: si no hay nada, se empieza a contar desde ayer.
  var d = hoyActivo ? h : _mas(h, -1);
  for (var i = 0; i < 3000; i++, d = _mas(d, -1)) {
    final k = _clave(d);
    if (activos.contains(k)) {
      dias++;
      huecos = 0;
    } else if (congelados.contains(k)) {
      // Descanso apuntado: ni suma ni rompe.
    } else {
      huecos++;
      if (huecos > 1) break;
    }
  }
  return Racha(dias: dias, hoyActivo: hoyActivo, congeladaHasta: congeladaHasta(rangos, h));
}

/// La racha según los ajustes y los datos del opositor (null si no la tiene activada).
Racha? rachaDe(Ajustes ajustes, {Iterable<ResultadoTest> tests = const [], Iterable<Cante> cantes = const [], Iterable<DateTime> vueltas = const [], DateTime? hoy}) {
  if (!ajustes.racha) return null;
  final ahora = hoy ?? DateTime.now();
  return calcularRacha(
    activos: diasActivos(tests: tests, cantes: cantes, vueltas: vueltas),
    congelados: diasCongelados(ajustes.rachaCongelaciones),
    hoy: ahora,
    rangos: ajustes.rachaCongelaciones,
  );
}
