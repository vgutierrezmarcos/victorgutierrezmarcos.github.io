/// Reto diario: el agregado anónimo del test diario de un día (todos hacen las
/// mismas 10 preguntas). Un documento `retoDiario/{AAAA-MM-DD}` por
/// oposición con cuántos lo han hecho, la suma de notas y cuántos sacaron
/// cada nota redondeada (c0…c10). Las reglas solo dejan sumar uno mismo, una
/// vez; nunca hay nombres ni ranking (ver tool/reglas/generar.py).
class RetoDia {
  const RetoDia({required this.hechos, required this.sumaNotas, required this.cubos});

  final int hechos;
  final double sumaNotas;
  /// Cuántos sacaron cada nota (índice 0-10).
  final List<int> cubos;

  /// Con menos participantes no se enseñan cifras («hoy sois pocos»).
  static const minimo = 5;

  bool get suficiente => hechos >= minimo;
  double get media => hechos == 0 ? 0 : sumaNotas / hechos;

  /// Parte de los demás (sin contarme) que sacó menos que [nota] (0-1).
  double porDebajo(int nota) {
    final otros = hechos - 1;
    if (otros <= 0) return 0;
    var menos = 0;
    for (var i = 0; i < nota.clamp(0, 10) && i < cubos.length; i++) {
      menos += cubos[i];
    }
    return (menos / otros).clamp(0, 1);
  }

  /// Id del documento del día (`2026-10-28`).
  static String id(DateTime dia) => '${dia.year}-${dia.month.toString().padLeft(2, '0')}-${dia.day.toString().padLeft(2, '0')}';

  /// Nota redondeada (0-10) que se aporta.
  static int cubo(double notaSobre10) => notaSobre10.round().clamp(0, 10);

  factory RetoDia.fromJson(Map<dynamic, dynamic>? j) {
    if (j == null) return const RetoDia(hechos: 0, sumaNotas: 0, cubos: []);
    return RetoDia(
      hechos: (j['hechos'] as num?)?.toInt() ?? 0,
      sumaNotas: (j['sumaNotas'] as num?)?.toDouble() ?? 0,
      cubos: [for (var i = 0; i <= 10; i++) (j['c$i'] as num?)?.toInt() ?? 0],
    );
  }

  /// «Hoy lo han hecho 23 personas · nota media 6,4 · estás por encima del 70 %».
  String texto(int miNota) {
    if (!suficiente) return 'Hoy ${hechos == 1 ? 'lo has hecho tú' : 'lo habéis hecho $hechos'}: sois pocos todavía para dar cifras.';
    final m = media.toStringAsFixed(1).replaceAll('.', ',');
    return 'Hoy lo han hecho $hechos personas · nota media $m · estás por encima del ${(100 * porDebajo(miNota)).round()} %';
  }
}
