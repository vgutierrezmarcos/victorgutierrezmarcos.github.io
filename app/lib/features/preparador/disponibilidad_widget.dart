import 'package:flutter/material.dart';

import '../../data/models/red.dart';
import '../../theme/app_theme.dart';

/// Rejilla de disponibilidad semanal: siete días por tres tramos (mañana,
/// tarde y noche). Se toca cada casilla. [claves] son «día-tramo» («2-t»).
class SelectorDisponibilidad extends StatelessWidget {
  const SelectorDisponibilidad({super.key, required this.claves, required this.onCambio, this.compacto = false});
  final Set<String> claves;
  final ValueChanged<Set<String>> onCambio;
  final bool compacto;

  static const _dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final primario = context.esquema.primary;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        const SizedBox(width: 72),
        for (final d in _dias) Expanded(child: Center(child: Text(d, style: context.textos.labelMedium))),
      ]),
      for (final (t, nombre, horas) in tramosDia)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(children: [
            SizedBox(
              width: 72,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(nombre, style: context.textos.labelMedium),
                if (!compacto) Text(horas, style: context.textos.labelSmall),
              ]),
            ),
            for (var d = 1; d <= 7; d++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      final k = claveTramo(d, t);
                      final nuevo = {...claves};
                      nuevo.contains(k) ? nuevo.remove(k) : nuevo.add(k);
                      onCambio(nuevo);
                    },
                    child: Container(
                      height: compacto ? 28 : 36,
                      decoration: BoxDecoration(
                        color: claves.contains(claveTramo(d, t)) ? primario : context.colores.superficie,
                        border: Border.all(color: claves.contains(claveTramo(d, t)) ? primario : context.colores.borde),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: claves.contains(claveTramo(d, t)) ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                    ),
                  ),
                ),
              ),
          ]),
        ),
    ]);
  }
}

/// Vista de solo lectura de una disponibilidad, en una línea.
class TextoDisponibilidad extends StatelessWidget {
  const TextoDisponibilidad(this.claves, {super.key, this.vacio = 'Sin indicar'});
  final Iterable<String> claves;
  final String vacio;
  @override
  Widget build(BuildContext context) {
    final t = describirDisponibilidad(claves);
    return Text(t.isEmpty ? vacio : t[0].toUpperCase() + t.substring(1), style: context.textos.labelSmall);
  }
}

/// Cuánto encaja (ejercicio, online o presencial y horarios), en palabras:
/// nunca se enseña un número, para que nadie lo tome por una nota.
class Compatibilidad extends StatelessWidget {
  const Compatibilidad(this.valor, {super.key, this.tamano = 52});
  /// Resultado de [compatibilidad] (0-100); solo sirve para elegir la palabra.
  final int valor;
  final double tamano;

  static String texto(int valor) => valor >= 75 ? 'Encaja mucho' : (valor >= 45 ? 'Encaja' : (valor > 0 ? 'Encaja poco' : 'No encaja'));

  @override
  Widget build(BuildContext context) {
    final color = valor >= 75 ? Paleta.acierto : (valor >= 45 ? context.colores.dorado : context.colores.textoClaro);
    return Tooltip(
      message: 'Por el ejercicio, online o presencial y los horarios. No es una valoración de nadie.',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(valor >= 45 ? Icons.handshake_outlined : Icons.remove, size: 14, color: color),
          const SizedBox(width: 4),
          Text(texto(valor), style: context.textos.labelSmall?.copyWith(color: color, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }
}

/// Elige un mes de inicio (o «cuanto antes»). Devuelve la fecha, null si
/// «cuanto antes», y no cambia nada si se cierra.
Future<(DateTime?,)?> elegirMesInicio(BuildContext context, {DateTime? actual}) async {
  final ahora = DateTime.now();
  final meses = [for (var i = 0; i < 12; i++) DateTime(ahora.year, ahora.month + i)];
  const nombres = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
  return showDialog<(DateTime?,)>(
    context: context,
    builder: (d) => SimpleDialog(
      title: const Text('¿Desde cuándo?'),
      children: [
        SimpleDialogOption(onPressed: () => Navigator.pop(d, (null,)), child: Text('Cuanto antes', style: TextStyle(fontWeight: actual == null ? FontWeight.w700 : null))),
        for (final m in meses.skip(1))
          SimpleDialogOption(
            onPressed: () => Navigator.pop(d, (m,)),
            child: Text('${nombres[m.month - 1][0].toUpperCase()}${nombres[m.month - 1].substring(1)}${m.year != ahora.year ? ' de ${m.year}' : ''}', style: TextStyle(fontWeight: actual != null && actual.year == m.year && actual.month == m.month ? FontWeight.w700 : null)),
          ),
      ],
    ),
  );
}
