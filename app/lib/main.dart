import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/analitica.dart';
import 'core/avisos_fondo.dart';
import 'core/cache_http.dart';
import 'core/constants.dart';
import 'core/permiso_calendario.dart';
import 'core/firebase_web.dart';
import 'core/invitacion.dart';
import 'core/notificaciones.dart';
import 'core/pantalla_error.dart';
import 'core/providers.dart';
import 'core/resenas.dart';
import 'core/push_proceso.dart';
import 'features/inicio/elegir_oposicion.dart';
import 'theme/app_theme.dart';
import 'widgets/arranque.dart';
import 'data/models/oposicion.dart';
import 'data/models/preparador.dart';
import 'data/repos/contenido_repo.dart';
import 'data/repos/descargas_repo.dart';
import 'data/repos/oposicion_cuenta.dart';
import 'data/repos/plan_repo.dart';
import 'data/repos/preparador_repo.dart';
import 'data/repos/usuario_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Si una pantalla falla, se explica y se puede salir (no un rectángulo gris).
  PantallaError.instalar();
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
    // Avisos push de las novedades del proceso (Android).
    unawaited(iniciarPushProceso());
  } catch (e) {
    debugPrint('Firebase no disponible: $e');
    // Se enseña en Más → Cuenta: sin él no hay forma de saber por qué falla en un móvil.
    errorFirebase = '$e';
  }

  // Estadísticas de uso e informes de errores: solo si el usuario lo activa
  // (se enciende en crearServicios, al leer sus ajustes). Los errores se
  // enganchan ya, además de la pantalla de error.
  Analitica.instancia = Analitica.crear(firebaseDisponible: firebaseDisponible);
  Analitica.instancia.instalarErrores();

  final http = await CacheHttp.crear();
  final cajaApp = await Hive.openBox(Cajas.app);
  Resenas.iniciar(cajaApp);
  await Notificaciones.iniciar();
  // Invitación de un preparador (enlace de invitación o referrer de Play):
  // la bienvenida la tiene en cuenta y la app lleva a conectar.
  final invitacion = await leerInvitacionAlArrancar();

  runApp(RaizApp(http: http, firebaseDisponible: firebaseDisponible, elegida: cajaApp.get('oposicion') as String?, invitacion: invitacion));
}

/// Crea los servicios de una oposición: su contenido, los datos del opositor
/// en ella y la tarea de avisos.
Future<Servicios> crearServicios(Oposicion oposicion, {required CacheHttp http, required bool firebaseDisponible}) async {
  Oposiciones.actual = oposicion;
  // Colores y tipografías de su web (TCEE: los de esta; DCE: los de Manuel).
  Paleta.usar(oposicion.id);
  final db = firebaseDisponible ? FirebaseFirestore.instance : null;
  final auth = firebaseDisponible ? FirebaseAuth.instance : null;
  final contenido = ContenidoRepo(http, oposicion);
  final usuario = await UsuarioRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  // Según lo que contestó (null = aún no: apagado).
  await Analitica.instancia.iniciar(usuario.ajustes().estadisticas);
  final plan = await PlanRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  final preparador = await PreparadorRepo.crear(oposicion: oposicion, firestore: db, auth: auth);
  if (firebaseDisponible) {
    preparador.calendario = crearCalendario();
    // El del opositor: sus cantes y las clases con su preparador, si lo activa
    // en Más → Ajustes («Mis cantes en Google Calendar»).
    plan.calendario = crearCalendario(prefijo: 'cala:');
    plan.calendarioActivo = () => usuario.ajustes().calendarioGoogle;
  }
  final descargas = await DescargasRepo.crear(oposicion: oposicion);
  await iniciarAvisosEnSegundoPlano(oposicion: oposicion.id);

  // Refresco silencioso del contenido y sincronización si hay sesión.
  Future.microtask(() async {
    await contenido.refrescarTodo();
    // La sincronización con la cuenta la lanza la app en cuanto se carga la
    // sesión (TceeApp), junto con la red de preparadores.
    // El recordatorio diario solo existe si el usuario lo ha activado: en cada
    // arranque se reprograma o, si está desactivado, se cancela el que hubiera.
    try {
      final hoy = Ajustes.claveDia(DateTime.now());
      final hecho = usuario.resultadosLocales().any((r) => r.tipo == 'diario' && Ajustes.claveDia(r.timestamp) == hoy);
      await Notificaciones.programarRecordatorio(usuario.ajustes().horaRecordatorio, hechoHoy: hecho);
    } catch (_) {}
    // Los avisos de cantes se reprograman en cada arranque (y tras sincronizar).
    if (plan.plan().avisosCante) await Notificaciones.programarCantes(plan.cantes());
    // Y los de las clases, si en esta oposición es preparador.
    final perfil = preparador.perfil();
    if (perfil.activo) {
      final lista = preparador.alumnos();
      final nombres = {for (final a in lista) a.id: a.nombre};
      final sinApp = {for (final a in lista) if (!a.enlazado) a.id};
      await Notificaciones.programarClases(preparador.sesiones(), alumno: (c) => nombres[c.alumno] ?? 'tu alumno', antelaciones: perfil.avisosClase, sinApp: (c) => sinApp.contains(c.alumno));
    }
  });

  return Servicios(
    oposicion: oposicion,
    http: http,
    contenido: contenido,
    usuario: usuario,
    plan: plan,
    preparador: preparador,
    descargas: descargas,
    firebaseDisponible: firebaseDisponible,
  );
}

/// Raíz de la app: pregunta la oposición la primera vez (si hay varias) y
/// vuelve a crear los servicios cuando se cambia (`cambiarOposicionProvider`).
class RaizApp extends StatefulWidget {
  const RaizApp({super.key, required this.http, required this.firebaseDisponible, this.elegida, this.invitacion});

  /// Invitación de un preparador pendiente de conectar (ver core/invitacion.dart).
  final Invitacion? invitacion;
  final CacheHttp http;
  final bool firebaseDisponible;
  /// La guardada en la caja `app` (null = aún no ha elegido).
  final String? elegida;

  @override
  State<RaizApp> createState() => _RaizAppState();
}

class _RaizAppState extends State<RaizApp> {
  Servicios? _servicios;

  /// Instalación nueva: antes de nada, la bienvenida con la entrada con
  /// Google (una vez; sin Firebase no tiene sentido).
  late final bool _bienvenida = widget.firebaseDisponible && widget.elegida == null && Hive.box(Cajas.app).get(claveBienvenidaVista) != true;

  /// Sin oposición en este dispositivo pero con sesión: se mira la de la
  /// cuenta antes de preguntar (mientras, pantalla vacía).
  bool _buscandoEnCuenta = false;
  StreamSubscription<User?>? _sesion;

  /// La diana del arranque, encima hasta que hay algo que enseñar (en el
  /// navegador ya está la pantalla de carga de web/index.html).
  bool _arranqueVisto = kIsWeb || Arranque.omitir;

  @override
  void initState() {
    super.initState();
    final elegida = Oposiciones.todas.where((o) => o.id == widget.elegida).firstOrNull;
    if (elegida != null || (!Oposiciones.variasDisponibles && !_bienvenida)) {
      _arrancar(elegida ?? Oposiciones.todas.first);
    } else if (widget.firebaseDisponible) {
      _buscandoEnCuenta = true;
      OposicionCuenta.buscar().then((o) async {
        if (!mounted) return;
        if (o == null) return setState(() => _buscandoEnCuenta = false);
        await Hive.box(Cajas.app).put(claveBienvenidaVista, true);
        await _arrancar(o);
      });
    }
    // Al iniciar sesión (también más tarde, en Más → Cuenta), la cuenta se
    // queda con la oposición de este dispositivo como la última usada.
    if (widget.firebaseDisponible) {
      _sesion = FirebaseAuth.instance.authStateChanges().listen((u) {
        final s = _servicios;
        if (u != null && s != null) OposicionCuenta.guardar(s.oposicion);
      });
    }
  }

  @override
  void dispose() {
    _sesion?.cancel();
    super.dispose();
  }

  /// Arranca con [oposicion]. Con [papel] (al elegirla la primera vez), lo fija.
  Future<void> _arrancar(Oposicion oposicion, {Papel? papel}) async {
    await Hive.box(Cajas.app).put('oposicion', oposicion.id);
    final servicios = await crearServicios(oposicion, http: widget.http, firebaseDisponible: widget.firebaseDisponible);
    if (widget.firebaseDisponible) unawaited(OposicionCuenta.guardar(oposicion));
    if (papel != null) {
      final repo = servicios.preparador;
      if (papel == Papel.preparador && !repo.perfil().activo) await repo.activar();
      // Y, al arrancar, directo a pedir la verificación (ver TceeApp).
      if (papel == Papel.preparador) await Hive.box(Cajas.app).put(claveAbrirAlta, oposicion.id);
      await repo.guardarPerfil(repo.perfil().copyWith(papelElegido: true));
    }
    if (mounted) setState(() => _servicios = servicios);
  }

  @override
  Widget build(BuildContext context) {
    final contenido = _contenido();
    // Siempre en el mismo Stack: al quitar la diana no se reconstruye la app.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(fit: StackFit.expand, children: [
        contenido,
        if (!_arranqueVisto)
          Arranque(
            listo: contenido is! SizedBox,
            alTerminar: () => setState(() => _arranqueVisto = true),
          ),
      ]),
    );
  }

  Widget _contenido() {
    final servicios = _servicios;
    if (servicios == null) {
      return !_buscandoEnCuenta && ((Oposiciones.variasDisponibles && widget.elegida == null) || _bienvenida)
          ? ElegirOposicionApp(
              conBienvenida: _bienvenida,
              conOposicion: Oposiciones.variasDisponibles,
              alElegir: (o, papel) => _arrancar(o, papel: papel),
              buscarEnCuenta: OposicionCuenta.buscar,
              invitacion: widget.invitacion,
            )
          : const SizedBox.shrink();
    }
    // Una clave por oposición: al cambiarla se descartan todos los providers.
    return ProviderScope(
      key: ValueKey(servicios.oposicion.id),
      overrides: [
        serviciosProvider.overrideWithValue(servicios),
        cambiarOposicionProvider.overrideWithValue(_arrancar),
      ],
      child: const TceeApp(),
    );
  }
}
