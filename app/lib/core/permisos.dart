// Permisos del sistema que necesitan los avisos (notificaciones, alarmas
// exactas y optimización de batería) y los ajustes del sistema donde se
// cambian. En el navegador no existen.
export 'permisos_io.dart' if (dart.library.js_interop) 'permisos_web.dart';

/// Lo que el sistema permite ahora mismo (null = no se puede saber o no aplica).
class EstadoPermisos {
  const EstadoPermisos({this.notificaciones, this.alarmasExactas, this.bateriaSinOptimizar});

  /// La app puede mostrar notificaciones.
  final bool? notificaciones;

  /// Puede programar alarmas exactas (los avisos del cronómetro a su segundo).
  final bool? alarmasExactas;

  /// El sistema no limita la app por batería (los avisos en segundo plano
  /// llegan a su hora).
  final bool? bateriaSinOptimizar;

  /// Los avisos no pueden llegar: el permiso está denegado.
  bool get avisosBloqueados => notificaciones == false;
}
