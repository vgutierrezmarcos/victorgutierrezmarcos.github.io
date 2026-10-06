/// Documentos que publica el Ministerio en la página de seguimiento de cada
/// proceso selectivo (convocatoria, admitidos, calendario, convocatorias de
/// cada ejercicio, aprobados…). Los lee una acción de GitHub de la web y los
/// deja en `oposicion/proceso.json` (ver scripts/leer-proceso.py).
class DocumentoProceso {
  const DocumentoProceso({required this.id, required this.seccion, required this.titulo, required this.url, this.desde});

  final String id;

  /// Apartado de la página («Tercer ejercicio», «Admitidos y Excluidos»…).
  final String seccion;
  final String titulo;
  final String url;

  /// Día en que apareció (null si ya estaba cuando se empezó a seguir).
  final DateTime? desde;

  /// Ha aparecido hace menos de [dias].
  bool reciente(DateTime ahora, {int dias = 14}) => desde != null && ahora.difference(desde!).inDays < dias;

  factory DocumentoProceso.fromJson(Map<String, dynamic> j) => DocumentoProceso(
        id: j['id'] as String,
        seccion: (j['seccion'] as String?) ?? '',
        titulo: (j['titulo'] as String?) ?? '',
        url: j['url'] as String,
        desde: DateTime.tryParse((j['desde'] as String?) ?? ''),
      );
}

/// Una convocatoria (OEP de un año) con sus documentos, en el orden de la página.
class ProcesoSelectivo {
  const ProcesoSelectivo({required this.convocatoria, required this.url, required this.documentos});

  /// Año de la oferta de empleo («2025»).
  final String convocatoria;

  /// Página oficial del proceso.
  final String url;
  final List<DocumentoProceso> documentos;

  /// Apartados en el orden de la página, con sus documentos.
  List<(String, List<DocumentoProceso>)> get secciones {
    final out = <(String, List<DocumentoProceso>)>[];
    for (final d in documentos) {
      if (out.isEmpty || out.last.$1 != d.seccion) {
        out.add((d.seccion, [d]));
      } else {
        out.last.$2.add(d);
      }
    }
    return out;
  }

  /// Los aparecidos con fecha, del más nuevo al más antiguo.
  List<DocumentoProceso> get novedades => documentos.where((d) => d.desde != null).toList()..sort((a, b) => b.desde!.compareTo(a.desde!));

  factory ProcesoSelectivo.fromJson(Map<String, dynamic> j) => ProcesoSelectivo(
        convocatoria: (j['convocatoria'] as String?) ?? '',
        url: j['url'] as String,
        documentos: [for (final d in (j['documentos'] as List? ?? const [])) DocumentoProceso.fromJson(Map<String, dynamic>.from(d as Map))],
      );

  /// Convocatorias de una oposición en el JSON, de la más reciente a la más
  /// antigua (puede haber dos mientras acaba una y empieza la siguiente).
  static List<ProcesoSelectivo> deOposicion(Map<String, dynamic> json, String oposicion) => [
        for (final p in ((json[oposicion] as Map?)?['procesos'] as List? ?? const [])) ProcesoSelectivo.fromJson(Map<String, dynamic>.from(p as Map)),
      ];
}

/// Documentos de [procesos] que no están en [vistos] (claves `op:id`).
/// La primera vez (sin la marca `op:base`) no hay novedades: todo lo que ya
/// había se da por visto, para no avisar de golpe de un proceso entero.
({List<DocumentoProceso> nuevos, Set<String> vistos}) novedadesProceso(String oposicion, List<ProcesoSelectivo> procesos, Set<String> vistos) {
  final todos = [for (final p in procesos) ...p.documentos];
  final claves = {for (final d in todos) '$oposicion:${d.id}'};
  if (todos.isEmpty) return (nuevos: const [], vistos: vistos);
  if (!vistos.contains('$oposicion:base')) return (nuevos: const [], vistos: {...vistos, '$oposicion:base', ...claves});
  final nuevos = [for (final d in todos) if (!vistos.contains('$oposicion:${d.id}')) d];
  return (nuevos: nuevos, vistos: {...vistos, ...claves});
}
