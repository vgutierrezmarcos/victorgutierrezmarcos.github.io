import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

import '../data/models/oposicion.dart';
import '../data/repos/red_repo.dart';
import 'avisos_proceso.dart';
import 'avisos_red.dart';
import 'vistos.dart';

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
    try {
      await Firebase.initializeApp();
      await initializeDateFormatting('es');
      final auth = FirebaseAuth.instance;
      // La sesión guardada tarda un momento en cargarse en este isolate.
      final usuario = auth.currentUser ?? await auth.authStateChanges().first.timeout(const Duration(seconds: 10), onTimeout: () => null);
      if (usuario == null) return true;
      final repo = RedRepo(firestore: FirebaseFirestore.instance, auth: auth, oposicion: Oposiciones.porId(await _leerOposicion()));
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

/// Activa o quita la comprobación periódica: hace falta con sesión
/// ([activar]) o con los avisos del proceso de alguna oposición.
Future<void> programarAvisosEnSegundoPlano({required bool activar}) async {
  if (!Platform.isAndroid) return;
  try {
    if (activar || (await leerVistos(lista: 'proceso_activado')).isNotEmpty) {
      await Workmanager().registerPeriodicTask(
        _tarea,
        _tarea,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      );
    } else {
      await Workmanager().cancelByUniqueName(_tarea);
    }
  } catch (_) {}
}
