import 'notificaciones.dart';
import 'permisos.dart';

/// En el navegador solo cuenta su permiso de notificaciones (no hay alarmas
/// exactas ni batería).
Future<EstadoPermisos> comprobarPermisos() async => EstadoPermisos(notificaciones: await Notificaciones.activadas());

Future<bool> abrirAjustesNotificaciones() async => false;

Future<bool> abrirAjustesBateria() async => false;

Future<bool> pedirAlarmasExactas() async => false;

Future<bool> pedirSinRestriccionBateria() async => false;

Future<String?> fabricanteMovil() async => null;

Future<bool> abrirAjustesFabricante() async => false;
