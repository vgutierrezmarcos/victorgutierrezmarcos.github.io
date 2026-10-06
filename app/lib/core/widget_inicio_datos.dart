/// Lo que muestra el widget de la pantalla de inicio. Las fechas van en bruto:
/// los días que faltan y el «hoy»/«mañana» los calcula el propio widget.
class DatosWidget {
  const DatosWidget({required this.siglas, this.examen, this.examenNombre = '', this.cante, this.canteTexto = '', this.semana, this.testHecho, this.preparador = false});

  final String siglas;

  /// Próximo ejercicio con fecha y su nombre («3.er ejercicio»).
  final DateTime? examen;
  final String examenNombre;

  /// Próximo cante (opositor) o clase (preparador) y su descripción
  /// («con Paula · 3.A.7, 3.B.2» o «Clase con Ana»).
  final DateTime? cante;
  final String canteTexto;

  /// «Esta semana: 2 de 3 temas» (null sin cronograma).
  final String? semana;

  /// Día en que se hizo el último test diario.
  final DateTime? testHecho;
  final bool preparador;

  @override
  bool operator ==(Object other) =>
      other is DatosWidget &&
      other.siglas == siglas &&
      other.examen == examen &&
      other.examenNombre == examenNombre &&
      other.cante == cante &&
      other.canteTexto == canteTexto &&
      other.semana == semana &&
      other.testHecho == testHecho &&
      other.preparador == preparador;

  @override
  int get hashCode => Object.hash(siglas, examen, examenNombre, cante, canteTexto, semana, testHecho, preparador);
}
