/// En el móvil los avisos son los del sistema (core/notificaciones.dart).
bool get navegadorAdmiteAvisos => false;

/// 'granted', 'denied' o 'default' (en el móvil, siempre 'denied').
String permisoAvisosNavegador() => 'denied';

Future<bool> pedirPermisoAvisosNavegador() async => false;

void iniciarAvisosNavegador(void Function(String contenido) alTocar) {}

void mostrarAvisoNavegador(int id, String titulo, String texto, {String? contenido}) {}

/// Huella de la versión publicada si es distinta de la abierta (o null).
Future<String?> versionNuevaNavegador() async => null;

void recargarNavegador() {}
