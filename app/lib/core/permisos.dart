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

  /// La batería restringe la app: con ella cerrada, los avisos pueden llegar tarde.
  bool get bateriaRestringida => bateriaSinOptimizar == false;

  /// Los avisos no pueden llegar: el permiso está denegado.
  bool get avisosBloqueados => notificaciones == false;
}

/// Ahorro de batería propio de algunos fabricantes, aparte del de Android:
/// qué tocar para que los avisos lleguen con la app cerrada (null si la marca
/// no tiene nada especial o no se sabe). [nombre] es la marca tal como se
/// conoce; [pasos], dónde está el ajuste.
({String nombre, String pasos})? consejoFabricante(String? fabricante) => switch (fabricante) {
      'xiaomi' || 'redmi' || 'poco' => (nombre: 'Xiaomi', pasos: 'Ajustes → Aplicaciones → la app: activa «Inicio automático» y, en «Ahorro de batería», elige «Sin restricciones».'),
      'huawei' => (nombre: 'Huawei', pasos: 'Ajustes → Batería → Inicio de aplicaciones → la app: «Gestionar manualmente» con las tres opciones activadas.'),
      'honor' => (nombre: 'Honor', pasos: 'Ajustes → Batería → Inicio de aplicaciones → la app: «Gestionar manualmente» con las tres opciones activadas.'),
      'samsung' => (nombre: 'Samsung', pasos: 'Ajustes → Batería → Límites de uso en segundo plano: que la app no esté en «Apps en suspensión» y añádela a «Apps que nunca se suspenden».'),
      'oppo' || 'realme' || 'oneplus' => (nombre: fabricante == 'oneplus' ? 'OnePlus' : (fabricante == 'realme' ? 'realme' : 'OPPO'), pasos: 'Ajustes → Batería → la app: activa «Permitir actividad en segundo plano» y, si aparece, «Inicio automático».'),
      'vivo' || 'iqoo' => (nombre: 'vivo', pasos: 'Ajustes → Batería → Consumo en segundo plano → la app: «Permitir», y activa su inicio automático.'),
      _ => null,
    };
