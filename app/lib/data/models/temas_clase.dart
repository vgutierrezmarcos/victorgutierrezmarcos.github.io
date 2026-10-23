import 'cronograma.dart';
import 'plan.dart';

/// Los temas que el opositor lleva a una clase con su preparador, elegidos por
/// él (o aceptados de una propuesta del preparador). Se guardan en los ajustes
/// del opositor (`temasClases`), que su preparador ya puede leer: así ninguna
/// copia de la clase los pisa y no hace falta tocar las reglas de la base de
/// datos.
class TemasClase {
  const TemasClase({required this.temas, required this.fecha});
  final List<String> temas;
  /// Cuándo los fijó: una propuesta del preparador posterior está pendiente.
  final DateTime fecha;

  /// «idClase@fecha@3.A.1,3.A.2». Como lista y no como mapa: los ajustes se
  /// guardan con merge y un mapa no borraría lo que se quita.
  String codificar(String id) => '$id@${fecha.toIso8601String()}@${temas.join(',')}';

  static Map<String, TemasClase> deLista(Object? v) => {
        if (v is List)
          for (final s in v)
            if (s.toString().split('@') case [final id, final f, final t] when DateTime.tryParse(f) != null)
              id: TemasClase(temas: [for (final x in t.split(',')) if (x.trim().isNotEmpty) x.trim()], fecha: DateTime.parse(f)),
      };

  static List<String> aLista(Map<String, TemasClase> m) => [for (final e in m.entries) e.value.codificar(e.key)]..sort();
}

/// De dónde salen los temas de una clase.
enum OrigenTemas {
  /// Los eligió (o aceptó) el opositor para esta clase.
  opositor,
  /// La semana de su cronograma cuyo cante cae en el día de la clase.
  cronograma,
  /// Ni lo uno ni lo otro: el opositor tiene que indicarlos.
  pendiente,
}

class TemasDeClase {
  const TemasDeClase(this.temas, this.origen);
  final List<String> temas;
  final OrigenTemas origen;
  bool get pendiente => origen == OrigenTemas.pendiente;
}

/// Los temas que el opositor lleva a la clase [c], igual en su app y en la del
/// preparador: lo que eligió para esa clase; si no, la semana de su
/// [cronograma] cuyo cante cae ese día (sin los que pide no cantar); si no,
/// pendiente (lista vacía) hasta que los indique.
TemasDeClase temasDeLaClase(Cante c, {required Map<String, TemasClase> elegidos, Cronograma? cronograma, Map<String, DateTime> noCantar = const {}}) {
  final propios = elegidos[c.id];
  if (propios != null && propios.temas.isNotEmpty) return TemasDeClase(propios.temas, OrigenTemas.opositor);
  final semana = cronograma?.temasDelCante(c.fecha)?.where((t) => !noCantar.containsKey(t)).toList();
  if (semana != null && semana.isNotEmpty) return TemasDeClase(semana, OrigenTemas.cronograma);
  return const TemasDeClase([], OrigenTemas.pendiente);
}

/// Si el preparador ha propuesto temas para la clase y el opositor aún no ha
/// respondido (no ha fijado sus temas después de la propuesta).
bool propuestaPendiente(Cante c, Map<String, TemasClase> elegidos) {
  if (c.temasPropuestos.isEmpty || c.propuestaTemasA == null) return false;
  final suyos = elegidos[c.id];
  return suyos == null || suyos.fecha.isBefore(c.propuestaTemasA!);
}
