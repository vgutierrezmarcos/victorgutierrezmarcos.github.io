import '../data/models/plan.dart';

/// En el navegador no hay tareas en segundo plano: los avisos llegan con la
/// pestaña abierta (ver avisos_red.dart).
Future<void> iniciarAvisosEnSegundoPlano({String oposicion = 'tcee'}) async {}

Future<void> programarAvisosEnSegundoPlano({required bool activar}) async {}

/// En el navegador el tema llega con la pestaña abierta (al sincronizar).
Future<void> programarTemasAnticipados(List<Cante> cantes) async {}
