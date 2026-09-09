import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/cache_http.dart';
import 'core/notificaciones.dart';
import 'core/providers.dart';
import 'data/repos/contenido_repo.dart';
import 'data/repos/descargas_repo.dart';
import 'data/repos/usuario_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeDateFormatting('es');

  // Firebase: usa google-services.json / GoogleService-Info.plist del proyecto web-vgm.
  // Si no están (p. ej. build de desarrollo sin credenciales), la app funciona sin cuenta.
  var firebaseDisponible = false;
  try {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
    firebaseDisponible = true;
  } catch (e) {
    debugPrint('Firebase no disponible: $e');
  }

  final http = await CacheHttp.crear();
  final contenido = ContenidoRepo(http);
  final usuario = await UsuarioRepo.crear(
    firestore: firebaseDisponible ? FirebaseFirestore.instance : null,
    auth: firebaseDisponible ? FirebaseAuth.instance : null,
  );
  final descargas = await DescargasRepo.crear();
  await Notificaciones.iniciar();

  // Refresco silencioso del contenido y sincronización si hay sesión.
  Future.microtask(() async {
    await contenido.refrescarTodo();
    if (usuario.conSesion) await usuario.sincronizarTodo();
  });

  runApp(
    ProviderScope(
      overrides: [
        serviciosProvider.overrideWithValue(Servicios(
          http: http,
          contenido: contenido,
          usuario: usuario,
          descargas: descargas,
          firebaseDisponible: firebaseDisponible,
        )),
      ],
      child: const TceeApp(),
    ),
  );
}
