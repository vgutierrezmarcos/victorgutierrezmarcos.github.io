import 'permisos.dart';

/// En el navegador los avisos son los suyos: no hay permisos del sistema.
Future<EstadoPermisos> comprobarPermisos() async => const EstadoPermisos();

Future<bool> abrirAjustesNotificaciones() async => false;

Future<bool> abrirAjustesBateria() async => false;

Future<bool> pedirAlarmasExactas() async => false;
