/// Cuadro de coyuntura de España (oposicion/coyuntura.json): los indicadores
/// básicos para el dictamen, con la zona del euro al lado. Lo actualiza cada
/// día scripts/coyuntura.py (acción de GitHub) con Eurostat y el BCE.
class IndicadorCoyuntura {
  const IndicadorCoyuntura({
    required this.id,
    required this.grupo,
    required this.nombre,
    required this.unidad,
    required this.fuente,
    required this.nota,
    required this.periodo,
    required this.etiqueta,
    required this.valor,
    this.anterior,
    this.serie = const [],
    this.siguiente,
    this.referenciaNombre,
    this.referenciaValor,
    this.primaRiesgo,
  });

  final String id, grupo, nombre, unidad, fuente, nota;

  /// Periodo del dato (`2026-09`, `2026-Q2`, `2025`) y cómo se dice («sept. 2026»).
  final String periodo, etiqueta;
  final double valor;
  final double? anterior;
  final List<(String, double)> serie;

  /// Fecha aproximada del siguiente dato (o null si no tiene calendario).
  final DateTime? siguiente;
  final String? referenciaNombre;
  final double? referenciaValor;

  /// Prima de riesgo frente a Alemania, en puntos básicos (solo el bono).
  final int? primaRiesgo;

  double? get cambio => anterior == null ? null : valor - anterior!;

  static IndicadorCoyuntura? deJson(Object? j) {
    if (j is! Map) return null;
    final valor = j['valor'];
    if (j['id'] is! String || valor is! num) return null;
    final ref = j['referencia'];
    return IndicadorCoyuntura(
      id: j['id'] as String,
      grupo: (j['grupo'] as String?) ?? 'Otros',
      nombre: (j['nombre'] as String?) ?? j['id'] as String,
      unidad: (j['unidad'] as String?) ?? '',
      fuente: (j['fuente'] as String?) ?? '',
      nota: (j['nota'] as String?) ?? '',
      periodo: (j['periodo'] as String?) ?? '',
      etiqueta: (j['etiqueta'] as String?) ?? '',
      valor: valor.toDouble(),
      anterior: (j['anterior'] as num?)?.toDouble(),
      serie: [
        for (final p in (j['serie'] as List?) ?? const [])
          if (p is List && p.length >= 2 && p[1] is num) (p[0].toString(), (p[1] as num).toDouble()),
      ],
      siguiente: DateTime.tryParse((j['siguiente'] as String?) ?? ''),
      referenciaNombre: ref is Map ? ref['nombre'] as String? : null,
      referenciaValor: ref is Map ? (ref['valor'] as num?)?.toDouble() : null,
      primaRiesgo: (j['primaRiesgo'] as num?)?.toInt(),
    );
  }
}

class Coyuntura {
  const Coyuntura({this.actualizado, this.indicadores = const []});
  final DateTime? actualizado;
  final List<IndicadorCoyuntura> indicadores;

  static const vacia = Coyuntura();
  bool get sinDatos => indicadores.isEmpty;

  factory Coyuntura.fromJson(Map<dynamic, dynamic> j) => Coyuntura(
        actualizado: DateTime.tryParse((j['actualizado'] as String?)?.replaceAll('Z', ':00Z') ?? ''),
        indicadores: [for (final x in (j['indicadores'] as List?) ?? const []) IndicadorCoyuntura.deJson(x)].whereType<IndicadorCoyuntura>().toList(),
      );

  /// Por grupos, en el orden del fichero.
  Map<String, List<IndicadorCoyuntura>> get porGrupo {
    final out = <String, List<IndicadorCoyuntura>>{};
    for (final i in indicadores) {
      (out[i.grupo] ??= []).add(i);
    }
    return out;
  }

  /// Los indicadores cuyo periodo no está en [vistos] (id → periodo ya visto):
  /// los datos nuevos desde la última vez.
  List<IndicadorCoyuntura> nuevos(Map<String, String> vistos) => [
        for (final i in indicadores)
          if (vistos.isNotEmpty && vistos[i.id] != i.periodo) i,
      ];
}

/// «5,0 %», «101,4 % del PIB», «1,15 USD por EUR»: con coma decimal.
String cifraCoyuntura(double v, {int decimales = 1}) => v.toStringAsFixed(decimales).replaceAll('.', ',').replaceFirst(RegExp(r'^-'), '−');

/// Decimales según la magnitud (el tipo de cambio y los tipos con dos).
int decimalesCoyuntura(IndicadorCoyuntura i) => const {'usd', 'euribor', 'bono10', 'dfr'}.contains(i.id) ? 2 : 1;
