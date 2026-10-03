import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:workmanager/workmanager.dart';

import '../data/repos/red_repo.dart';
import 'avisos_red.dart';

const _tarea = 'avisos-red';

/// Punto de entrada de la tarea en segundo plano (otro isolate).
@pragma('vm:entry-point')
void despachadorAvisos() {
  Workmanager().executeTask((tarea, datos) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp();
      await initializeDateFormatting('es');
      final auth = FirebaseAuth.instance;
      // La sesión guardada tarda un momento en cargarse en este isolate.
      final usuario = auth.currentUser ?? await auth.authStateChanges().first.timeout(const Duration(seconds: 10), onTimeout: () => null);
      if (usuario == null) return true;
      final repo = RedRepo(firestore: FirebaseFirestore.instance, auth: auth);
      await comprobarAvisosRed(repo, preparador: await repo.quiereAvisosDeSustitucion(), admin: await repo.esAdmin());
    } catch (_) {
      // Sin red o sin credenciales: la próxima vez.
    }
    return true;
  });
}

Future<void> iniciarAvisosEnSegundoPlano() async {
  if (!Platform.isAndroid) return;
  try {
    await Workmanager().initialize(despachadorAvisos);
  } catch (_) {}
}

/// Activa (con sesión) o quita la comprobación periódica.
Future<void> programarAvisosEnSegundoPlano({required bool activar}) async {
  if (!Platform.isAndroid) return;
  try {
    if (activar) {
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
