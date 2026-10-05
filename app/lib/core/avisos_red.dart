import 'package:intl/intl.dart';

import '../data/repos/red_repo.dart';
import 'notificaciones.dart';
import 'plataforma.dart';
import 'vistos.dart';

/// Comprueba si hay algo nuevo en la red (clases sueltas, reservas, clases
/// programadas o canceladas, verificaciones, alumnos que se conectan)
/// y lo notifica una sola vez: en Android con una notificación del sistema y
/// en el navegador con una del navegador (si se dio permiso). Devuelve los
/// avisos nuevos. La usan la app abierta (al sincronizar) y la tarea en
/// segundo plano de Android.
Future<List<AvisoRed>> comprobarAvisosRed(RedRepo repo, {required bool preparador, bool? reservas, bool admin = false}) async {
  if (!repo.conSesion) return const [];
  final vistos = await leerVistos();
  final nuevos = await repo.avisosNuevos(
    vistos: vistos,
    preparador: preparador,
    reservas: reservas,
    admin: admin,
    cuando: (d) => DateFormat("EEEE d 'a las' HH:mm", 'es').format(d),
  );
  if (nuevos.isEmpty) return nuevos;
  for (final a in nuevos) {
    if (Notificaciones.disponibles) {
      await Notificaciones.avisoRed(a.id, a.titulo, a.texto);
    } else {
      notificacionNavegador(a.titulo, a.texto);
    }
  }
  await guardarVistos({...vistos, ...nuevos.map((a) => a.id)});
  return nuevos;
}
