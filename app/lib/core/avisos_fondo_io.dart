import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import '../data/models/oposicion.dart';
import '../data/models/plan.dart';
import '../data/repos/red_repo.dart';
import 'avisos_proceso.dart';
import 'avisos_red.dart';
import 'avisos_version.dart';
import 'temas_anticipados.dart';

const _tarea = 'avisos-red';

/// Punto de entrada de la tarea en segundo plano (otro isolate).
@pragma('vm:entry-point')
void despachadorAvisos() {
  Workmanager().executeTask((tarea, datos) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Novedades del proceso selectivo: no necesitan cuenta.
    try {
      await initializeDateFormatting('es');
      await comprobarProceso(await descargarProceso());
    } catch (_) {}
    // Versión nueva de la app: un aviso por versión.
    try {
      await comprobarVersion();
    } catch (_) {}
    try {
      await Firebase.initializeApp();
      await initializeDateFormatting('es');
      final auth = FirebaseAuth.instance;
      // La sesión guardada tarda un momento en cargarse en este isolate.
      final usuario = auth.currentUser ?? await auth.authStateChanges().first.timeout(const Duration(seconds: 10), onTimeout: () => null);
      if (usuario == null) return true;
      final oposicion = Oposiciones.porId(await _leerOposicion());
      // El tema que manda el preparador, en cuanto es la hora.
      await comprobarTemasAnticipados(FirebaseFirestore.instance, usuario.uid, oposicion);
      final repo = RedRepo(firestore: FirebaseFirestore.instance, auth: auth, oposicion: oposicion);
      await comprobarAvisosRed(repo, preparador: await repo.quiereAvisosDeSustitucion(), reservas: await repo.quiereAvisosDeReservas(), admin: await repo.esAdmin());
    } catch (_) {
      // Sin red o sin credenciales: la próxima vez.
    }
    return true;
  });
}

/// La tarea corre en otro isolate, sin Hive: la oposición elegida se le deja
/// en un fichero al arrancar la app.
Future<File> _ficheroOposicion() async => File('${(await getApplicationDocumentsDirectory()).path}/oposicion_avisos.txt');

Future<String?> _leerOposicion() async {
  try {
    final f = await _ficheroOposicion();
    return f.existsSync() ? (await f.readAsString()).trim() : null;
  } catch (_) {
    return null;
  }
}

Future<void> iniciarAvisosEnSegundoPlano({String oposicion = 'tcee'}) async {
  if (!Platform.isAndroid) return;
  try {
    await (await _ficheroOposicion()).writeAsString(oposicion);
  } catch (_) {}
  try {
    await Workmanager().initialize(despachadorAvisos);
  } catch (_) {}
}

/// Deja programada la comprobación periódica. Hace falta con sesión
/// ([activar]) o con los avisos del proceso; y, en cualquier caso, sirve para
/// avisar de las versiones nuevas (con la app instalada desde el APK es la
/// única forma de enterarse), así que no se cancela nunca.
Future<void> programarAvisosEnSegundoPlano({required bool activar}) async {
  if (!Platform.isAndroid) return;
  try {
    await Workmanager().registerPeriodicTask(
      _tarea,
      _tarea,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  } catch (_) {}
}

/// Para cada clase con tema anticipado, una comprobación a su hora (unos
/// segundos después, para que el servidor ya lo entregue): el aviso llega
/// aunque la app esté cerrada.
Future<void> programarTemasAnticipados(List<Cante> cantes) async {
  if (!Platform.isAndroid) return;
  final ahora = DateTime.now();
  for (final c in cantes) {
    final cuando = c.temaA;
    if (cuando == null || !cuando.isAfter(ahora) || !c.pendiente || c.borrado) continue;
    try {
      await Workmanager().registerOneOffTask(
        'tema-${c.id}',
        _tarea,
        initialDelay: cuando.difference(ahora) + const Duration(seconds: 20),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
    } catch (_) {}
  }
}
