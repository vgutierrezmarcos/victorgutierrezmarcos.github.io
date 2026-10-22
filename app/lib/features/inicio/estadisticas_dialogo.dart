import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/analitica.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';

/// Una sola vez, al arrancar: ¿envía la app estadísticas de uso anónimas e
/// informes de errores? Apagado si no dice que sí; se cambia en Más → Ajustes.
/// No sale si en esta compilación no se puede medir nada (sin Firebase, en el
/// navegador sin `measurementId`, en las pruebas). Devuelve si ha salido.
Future<bool> preguntarEstadisticasSiToca(BuildContext context, WidgetRef ref) async {
  if (!Analitica.instancia.disponible || ref.read(ajustesProvider).estadisticas != null) return false;
  final respuesta = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (d) => AlertDialog(
      title: const Text('¿Nos ayudas a mejorar la app?'),
      content: Text(
        'Si lo activas, la app envía a Google (Firebase) estadísticas de uso anónimas (qué pantallas se usan y cuánto) e informes de los errores que ocurran. '
        'No incluye tu nombre, tus temas, tus tests ni tus cantes. Puedes cambiarlo cuando quieras en Más → Ajustes.',
        style: d.textos.bodyMedium,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('No, gracias')),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Sí, ayudar')),
      ],
    ),
  );
  if (respuesta == null) return true;
  await ref.read(ajustesProvider.notifier).fijarEstadisticas(respuesta);
  return true;
}
