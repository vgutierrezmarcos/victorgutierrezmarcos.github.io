import 'plan.dart';

/// Coordinación entre un opositor y sus preparadores (cuando tiene varios).
///
/// Vive en los datos del opositor, en `coordinacion/{ajustes, reparto}`:
/// - [AjustesCoordinacion]: lo que decide el opositor sobre qué ven sus
///   preparadores. Por defecto, todo lo que ayuda a coordinarse.
/// - [RepartoPreparador]: qué lleva cada preparador (opcional; sin reparto,
///   todos hacen de todo). Lo cambian el opositor y cada preparador lo suyo.

/// Uid que sustituye al de un preparador que el opositor ha ocultado a los
/// demás: sus clases se ven como «otra clase», sin nombre.
const preparadorOculto = '?';

class AjustesCoordinacion {
  const AjustesCoordinacion({this.aislados = const {}, this.verCantesPropios = true});

  /// Preparadores que no saben que tiene otros: no ven a los demás ni los
  /// demás a ellos (sus clases se ven como «otra clase», sin nombre).
  final Set<String> aislados;

  /// Sus preparadores ven los cantes que hace por su cuenta, con su nota.
  final bool verCantesPropios;

  bool aislado(String uid) => aislados.contains(uid);

  AjustesCoordinacion copyWith({Set<String>? aislados, bool? verCantesPropios}) =>
      AjustesCoordinacion(aislados: aislados ?? this.aislados, verCantesPropios: verCantesPropios ?? this.verCantesPropios);

  Map<String, dynamic> toJson() => {'aislados': aislados.toList()..sort(), 'verCantesPropios': verCantesPropios};

  factory AjustesCoordinacion.fromJson(Map<dynamic, dynamic>? j) => AjustesCoordinacion(
        aislados: {for (final e in (j?['aislados'] as List?) ?? const []) e.toString()},
        verCantesPropios: j?['verCantesPropios'] as bool? ?? true,
      );
}

/// Lo que lleva un preparador en el reparto: unos ejercicios y una nota libre
/// («macro y comercio», «solo corrijo los cantes»…).
class RepartoPreparador {
  const RepartoPreparador({this.ejercicios = const {}, this.nota = ''});
  final Set<int> ejercicios;
  final String nota;

  bool get vacio => ejercicios.isEmpty && nota.trim().isEmpty;

  Map<String, dynamic> toJson() => {'ejercicios': ejercicios.toList()..sort(), 'nota': nota.trim()};

  factory RepartoPreparador.fromJson(Map<dynamic, dynamic>? j) => RepartoPreparador(
        ejercicios: {for (final e in (j?['ejercicios'] as List?) ?? const []) if (e is num) e.toInt()},
        nota: j?['nota'] as String? ?? '',
      );
}

/// Las clases pendientes del opositor que se solapan con [inicio] (y
/// [minutos] de duración): sus cantes por su cuenta y las clases con
/// cualquiera de sus preparadores. Sin [excluir] (la propia clase que se está
/// moviendo). Un cante por su cuenta sin hora (a las 0:00) no cuenta.
List<Cante> choquesEnAgenda(Iterable<Cante> agenda, DateTime inicio, int minutos, {String? excluir}) {
  final fin = inicio.add(Duration(minutes: minutos));
  return [
    for (final c in agenda)
      if (c.id != excluir && !c.borrado && !c.cancelado && !c.hecho && !(c.fecha.hour == 0 && c.fecha.minute == 0 && c.preparador == null))
        if (c.fecha.isBefore(fin) && c.fecha.add(Duration(minutes: c.minutos)).isAfter(inicio)) c,
  ]..sort((a, b) => a.fecha.compareTo(b.fecha));
}

/// «con Olga», «por tu cuenta», «otra clase»: con quién es una clase de la
/// agenda del opositor, vista por el preparador [yo] (o por el propio opositor
/// con [yo] = null).
String conQuienEs(Cante c, {String? yo}) {
  if (c.preparador == null) return yo == null ? 'por tu cuenta' : 'por su cuenta';
  if (c.preparador == yo) return 'contigo';
  if (c.preparador == preparadorOculto) return 'otra clase';
  final n = (c.preparadorNombre ?? '').trim();
  return n.isEmpty ? 'con otro preparador' : 'con $n';
}

/// La primera letra en mayúscula («Con Olga»).
String mayuscula(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

/// Lo que ve el preparador [yo] de un cante de su alumno, según lo que el
/// alumno deja ver ([ajustes]); null = no lo ve.
/// - Sus clases, enteras.
/// - Los cantes por su cuenta, con su nota, si el alumno lo permite.
/// - Las clases con otros preparadores: tema, fecha y con quién, sin la
///   valoración, los comentarios ni las indicaciones. Si el alumno ha
///   ocultado a ese preparador, sin su nombre («otra clase»); si me ha
///   ocultado a mí, ninguna.
Cante? verCanteAjeno(Cante c, {required String yo, required AjustesCoordinacion ajustes}) {
  if (c.preparador == yo) return c;
  if (c.preparador == null) return ajustes.verCantesPropios ? c : null;
  if (ajustes.aislado(yo)) return null;
  final sinLoPrivado = c.copyWith(notas: '', resultado: c.resultado?.copyWith(valoracion: 0, comentarios: ''));
  return ajustes.aislado(c.preparador!) ? sinLoPrivado.copyWith(preparador: preparadorOculto, preparadorNombre: '') : sinLoPrivado;
}

/// Temas que conviene no repetir al sortear los de una clase, con el motivo:
/// los cantados (con quien sea) en los últimos [dias] días y los que ya están
/// mandados para otras clases próximas ([mandados], por id de clase; los de
/// otros preparadores y los míos). Sin [excluir] (la propia clase).
Map<String, String> temasAEvitar(Iterable<Cante> agenda, {Map<String, List<String>> mandados = const {}, int dias = 14, DateTime? ahora, String? yo, String? excluir}) {
  final hoy = ahora ?? DateTime.now();
  final desde = hoy.subtract(Duration(days: dias));
  final out = <String, String>{};
  for (final c in [...agenda]..sort((a, b) => a.fecha.compareTo(b.fecha))) {
    if (c.id == excluir || !c.hecho || c.fecha.isBefore(desde)) continue;
    for (final t in c.resultado?.temasCantados ?? const <String>[]) {
      out[t] = 'cantado ${_hace(c.fecha, hoy)} ${conQuienEs(c, yo: yo)}';
    }
  }
  final porId = {for (final c in agenda) c.id: c};
  for (final e in mandados.entries) {
    if (e.key == excluir) continue;
    final c = porId[e.key];
    for (final t in e.value) {
      out.putIfAbsent(t, () => c == null ? 'ya mandado para otra clase' : 'ya mandado para la clase del ${c.fecha.day}/${c.fecha.month} ${conQuienEs(c, yo: yo)}');
    }
  }
  return out;
}

String _hace(DateTime d, DateTime hoy) {
  final dias = DateTime(hoy.year, hoy.month, hoy.day).difference(DateTime(d.year, d.month, d.day)).inDays;
  return dias <= 0 ? 'hoy' : (dias == 1 ? 'ayer' : 'hace $dias días');
}

/// La bolsa sin los temas de [evitar], si quedan al menos [n] (y, con
/// [partes], de al menos [n] partes distintas); si no, la bolsa entera.
List<T> sinRepetir<T>(List<T> bolsa, Set<String> evitar, int n, String Function(T) codigo, {String Function(T)? partes}) {
  final quedan = bolsa.where((t) => !evitar.contains(codigo(t))).toList();
  if (quedan.length < n) return bolsa;
  if (partes != null && {for (final t in quedan) partes(t)}.length < n) return bolsa;
  return quedan;
}
