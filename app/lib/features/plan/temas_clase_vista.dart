import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/cronograma.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../data/models/temas_clase.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/selector_temas.dart';

/// Los temas que el opositor lleva a una clase con su preparador, como los
/// ven los dos: la lista, de dónde sale (los eligió él o su cronograma) y, si
/// no hay ninguno, el aviso de que tiene que indicarlos. El opositor los
/// cambia y responde a las propuestas del preparador; el preparador solo
/// propone. La lista es siempre la misma en las dos apps ([temasDeLaClase]).
class TemasDeLaClaseVista extends StatelessWidget {
  const TemasDeLaClaseVista({
    super.key,
    required this.clase,
    required this.resueltos,
    required this.temario,
    required this.esPreparador,
    required this.otro,
    required this.propuestaPendiente,
    this.cronograma,
    this.onElegir,
    this.onAceptarPropuesta,
    this.onProponer,
    this.onRetirarPropuesta,
    this.respaldo,
  });

  final Cante clase;
  final TemasDeClase resueltos;
  final Temario? temario;
  final bool esPreparador;
  /// Nombre del otro: el alumno (para el preparador) o el preparador.
  final String otro;
  final bool propuestaPendiente;
  final Cronograma? cronograma;
  /// Opositor: elegir o cambiar los temas (con los de la lista actual marcados).
  final Future<void> Function(List<String> actuales)? onElegir;
  final Future<void> Function()? onAceptarPropuesta;
  /// Preparador: proponer otros temas.
  final Future<void> Function(List<String> actuales)? onProponer;
  final Future<void> Function()? onRetirarPropuesta;
  /// Preparador: cuántos temas entran mientras la clase esté pendiente (la bolsa de respaldo).
  final int? respaldo;

  String _origen() {
    final semana = cronograma?.temasDelCante(clase.fecha);
    final cante = semana != null ? DateFormat("EEEE d 'de' MMMM", 'es').format(clase.fecha) : '';
    // Fijados solos desde el cronograma (1.20.4): se dice de dónde vienen.
    final delCronograma = semana != null && semana.toSet().containsAll(resueltos.temas) && resueltos.temas.toSet().containsAll(semana);
    return switch (resueltos.origen) {
      OrigenTemas.opositor when delCronograma => esPreparador ? 'De su cronograma: la semana del cante del $cante.' : 'De tu cronograma: la semana del cante del $cante. $otro ve los mismos.',
      OrigenTemas.opositor => esPreparador ? 'Los ha indicado $otro para esta clase.' : 'Los has elegido tú para esta clase. $otro ve los mismos.',
      OrigenTemas.cronograma => esPreparador
          ? 'De su cronograma: la semana del cante del $cante.'
          : 'De tu cronograma: la semana del cante del $cante. $otro ve los mismos.',
      OrigenTemas.pendiente => '',
    };
  }

  Widget _lista(BuildContext context, List<String> codigos) => Tarjeta(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (final c in codigos)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('$c · ${temario?.tema(c)?.titulo ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
            ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final temas = resueltos.temas;
    final propuestos = clase.temasPropuestos;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TituloSeccion(esPreparador ? 'Temas que lleva (${temas.length})' : 'Temas que llevas (${temas.length})'),
      if (propuestaPendiente && propuestos.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: Espacio.e2),
          child: Aviso(
            icono: Icons.swap_horiz,
            titulo: esPreparador ? 'Le has propuesto otros temas' : '$otro te propone estos temas',
            texto: '${propuestos.join(', ')}${esPreparador ? '. Hasta que $otro la acepte, la clase sigue con los de abajo.' : '.'}',
            accion: esPreparador
                ? (onRetirarPropuesta == null ? null : TextButton(onPressed: onRetirarPropuesta, child: const Text('Retirar')))
                : Wrap(spacing: 4, children: [
                    if (temas.isNotEmpty && onElegir != null) TextButton(onPressed: () => onElegir!(temas), child: const Text('Elegir otros')),
                    if (onAceptarPropuesta != null) FilledButton(onPressed: onAceptarPropuesta, child: const Text('Aceptar')),
                  ]),
          ),
        ),
      if (resueltos.pendiente)
        Aviso(
          icono: Icons.playlist_add,
          tipo: TipoAviso.aviso,
          titulo: esPreparador ? 'Pendiente de que $otro indique sus temas' : 'Indica qué temas llevas a esta clase',
          texto: esPreparador
              ? 'No ha indicado temas para esta clase y no comparte ningún cronograma con una semana para este día (con la app al día se fijan solos desde su cronograma). Mientras tanto, para mandarle o sortear un tema entran todos los que lleva${respaldo == null ? '' : ' ($respaldo)'}.'
              : 'No hay ninguna semana de tu cronograma para este día. Hasta que los indiques, $otro puede mandarte o sortear cualquiera de los temas que llevas.',
          accion: esPreparador
              ? (onProponer == null ? null : TextButton(onPressed: () => onProponer!(const []), child: const Text('Proponer temas')))
              : (onElegir == null ? null : FilledButton(onPressed: () => onElegir!(const []), child: const Text('Elegir temas'))),
        )
      else ...[
        _lista(context, temas),
        Padding(
          padding: const EdgeInsets.only(top: Espacio.e1),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Text(_origen(), style: context.textos.labelSmall)),
            if (esPreparador && onProponer != null) TextButton(onPressed: () => onProponer!(temas), child: const Text('Proponer otros'))
            else if (!esPreparador && onElegir != null) TextButton(onPressed: () => onElegir!(temas), child: const Text('Cambiar')),
          ]),
        ),
      ],
    ]);
  }
}

/// Abre el selector con los temas del ejercicio de la clase.
Future<List<String>?> elegirTemasDeClase(BuildContext context, {required Temario temario, required Cante clase, required List<String> actuales, required String titulo}) =>
    elegirTemas(context, temario: temario, seleccion: actuales, ejercicios: Oposiciones.actual.ejerciciosDeBolsa(clase.ejercicio), titulo: titulo);
