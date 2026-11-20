import 'package:flutter/material.dart';

import '../data/models/oposicion.dart';
import 'constants.dart';

/// Un acceso de la burbuja: abre la IA del usuario con [mensaje] ya escrito.
/// [id] es su nombre corto para las estadísticas anónimas.
class AccionIa {
  const AccionIa(this.id, this.icono, this.titulo, this.mensaje);

  final String id;
  final IconData icono;
  final String titulo;
  final String mensaje;
}

/// Los mensajes que la app le escribe a la IA. Todos nombran el conector, para
/// que la IA lo use (llama a `empezar` y a `leer_metodo`), y la oposición. No
/// llevan nada personal: como mucho, el código y el título de un tema; lo
/// demás lo lee la IA de la app con el conector.
class MensajesIa {
  const MensajesIa(this.oposicion);

  final Oposicion oposicion;

  String _con(String peticion) => 'Usa el conector «${Creditos.nombreApp}» (EconomIA). Oposición: ${oposicion.siglas}. $peticion';

  /// El genérico: la IA se presenta y el usuario sigue escribiendo.
  String get libre => _con('Mira cómo voy y pregúntame qué quiero hacer hoy.');

  List<AccionIa> inicio({required bool preparador}) => preparador
      ? [
          AccionIa('clase', Icons.co_present_outlined, 'Prepara mi próxima clase', _con('Soy preparador: prepara conmigo mi próxima clase.')),
          AccionIa('alumnos', Icons.groups_outlined, '¿Cómo van mis alumnos?', _con('Soy preparador: dime cómo van mis alumnos y en qué debería fijarme esta semana.')),
        ]
      : [
          AccionIa('hoy', Icons.today_outlined, '¿Qué me toca hoy?', _con('Dime qué me toca hoy según mi cronograma y mis últimos cantes, y por dónde empezar.')),
          AccionIa('test', Icons.quiz_outlined, 'Hazme un test', _con('Hazme un test de diez preguntas oficiales de lo que llevo estudiado.')),
          AccionIa('semana', Icons.date_range_outlined, 'Organiza mi semana', _con('Organiza conmigo esta semana de estudio.')),
        ];

  List<AccionIa> tema(String codigo, String titulo) {
    final t = 'tema $codigo («$titulo»)';
    return [
      AccionIa('duda', Icons.help_outline, 'Tengo una duda de este tema', _con('Tengo una duda del $t. Mi duda es: ')),
      AccionIa('tribunal', Icons.gavel_outlined, 'Pregúntame como el tribunal', _con('Pregúntame el $t como lo haría el tribunal, de una en una, y corrígeme.')),
      AccionIa('test_tema', Icons.quiz_outlined, 'Hazme un test de este tema', _con('Hazme un test del $t, primero con preguntas oficiales.')),
    ];
  }

  List<AccionIa> get resultadoTest => [
        AccionIa('fallos', Icons.fact_check_outlined, 'Repasa conmigo los fallos', _con('Acabo de hacer un test en la app: repasa conmigo las preguntas que he fallado y explícame por qué.')),
        AccionIa('refuerzo', Icons.fitness_center_outlined, 'Un test de refuerzo', _con('Mira mis últimos tests y hazme uno de refuerzo con lo que más fallo.')),
      ];

  List<AccionIa> get cronograma => [
        AccionIa('al_dia', Icons.insights_outlined, '¿Voy al día?', _con('Mira mi cronograma y mis cantes y dime si voy al día y qué llevo retrasado.')),
        AccionIa('cronograma', Icons.edit_calendar_outlined, 'Ajusta mi cronograma', _con('Quiero ajustar mi cronograma. Enséñame la propuesta antes de guardarla en la app.')),
      ];

  List<AccionIa> get cantes => [
        AccionIa('cante', Icons.rate_review_outlined, 'Corrige mi último cante', _con('Corrige mi último cante.')),
        AccionIa('tribunal', Icons.gavel_outlined, 'Simula al tribunal', _con('Simula al tribunal con el tema de mi próximo cante.')),
      ];
}
