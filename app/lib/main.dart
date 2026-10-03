import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/avisos_fondo.dart';
import 'core/cache_http.dart';
import 'core/constants.dart';
import 'core/firebase_web.dart';
import 'core/notificaciones.dart';
import 'core/providers.dart';
import 'data/models/oposicion.dart';
import 'data/repos/contenido_repo.dart';
import 'data/repos/descargas_repo.dart';
import 'data/repos/plan_repo.dart';
import 'data/repos/preparador_repo.dart';
import 'data/repos/usuario_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting('es');

  // Firebase: usa google-services.json / GoogleService-Info.plist del proyecto web-vgm
  // (en el navegador, la configuración de la web).
  // Si no están (p. ej. build de desarrollo sin credenciales), la app funciona sin cuenta.
  var firebaseDisponible = false;
  try {
    await Firebase.initializeApp(options: kIsWeb ? opcionesFirebaseWeb : null);
    try {
      FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
    } catch (_) {
      // En el navegador la caché sin conexión puede no estar disponible (p. ej. ventana privada).
    }
    firebaseDisponible = true;
  } catch (e) {
    debugPrint('Firebase no disponible: $e');
  }

  final http = await CacheHttp.crear();
  // La oposición elegida (la única, mientras solo esté TCEE) decide de qué web
  // sale el contenido y dónde se guardan los datos del opositor.
  final oposicion = Oposiciones.porId((await Hive.openBox(Cajas.app)).get('oposicion') as String?);
  Oposiciones.actual = oposicion;
  final db = firebaseDisponible ? FirebaseFirestore.instance : null;
  final auth = firebaseDisponible ? FirebaseAuth.instance : null;
  final contenido = ContenidoRepo(http, oposicion);
  final usuario = await UsuarioRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  final plan = await PlanRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  final preparador = await PreparadorRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  final descargas = await DescargasRepo.crear(oposicion: oposicion);
  await Notificaciones.iniciar();
  await iniciarAvisosEnSegundoPlano(oposicion: oposicion.id);

  // Refresco silencioso del contenido y sincronización si hay sesión.
  Future.microtask(() async {
    await contenido.refrescarTodo();
    // La sincronización con la cuenta la lanza la app en cuanto se carga la
    // sesión (TceeApp), junto con la red de preparadores.
    // El recordatorio diario solo existe si el usuario lo ha activado: en cada
    // arranque se reprograma o, si está desactivado, se cancela el que hubiera.
    try {
      await Notificaciones.programarRecordatorio(usuario.ajustes().horaRecordatorio);
    } catch (_) {}
    // Los avisos de cantes se reprograman en cada arranque (y tras sincronizar).
    if (plan.plan().avisosCante) await Notificaciones.programarCantes(plan.cantes());
  });

  runApp(
    ProviderScope(
      overrides: [
        serviciosProvider.overrideWithValue(Servicios(
          oposicion: oposicion,
          http: http,
          contenido: contenido,
          usuario: usuario,
          plan: plan,
          preparador: preparador,
          descargas: descargas,
          firebaseDisponible: firebaseDisponible,
        )),
      ],
      child: const TceeApp(),
    ),
  );
}
