import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/analitica.dart';
import 'data/repos/usuario_repo.dart' show Ajustes;
import 'core/cronograma_providers.dart';
import 'core/instalacion.dart';
import 'data/models/plan.dart';
import 'data/models/temas_clase.dart';
import 'core/constants.dart';
import 'core/enlaces.dart';
import 'core/invitacion.dart';
import 'core/notificaciones.dart';
import 'core/pantalla_error.dart';
import 'core/red_providers.dart';
import 'core/widget_inicio.dart';
import 'core/widget_providers.dart';
import 'core/actualizaciones.dart';
import 'core/providers.dart';
import 'features/cantar/probabilidades_page.dart';
import 'features/cantar/relojes_alumnos.dart';
import 'features/cantes/cantes_page.dart';
import 'features/cronograma/cronograma_page.dart';
import 'features/estudiar/estudiar_page.dart';
import 'features/guia/guia.dart';
import 'features/inicio/calendario_dialogo.dart';
import 'features/inicio/estadisticas_dialogo.dart';
import 'features/inicio/inicio_page.dart';
import 'features/inicio/permisos_sheet.dart';
import 'features/mas/cuenta_page.dart';
import 'features/mas/economia_page.dart';
import 'features/mas/mas_page.dart';
import 'features/organizacion/mapa_calor_page.dart';
import 'features/organizacion/organizacion_hub_page.dart';
import 'features/organizacion/organizacion_page.dart';
import 'features/plan/cante_page.dart';
import 'features/plan/convocatoria_page.dart';
import 'features/plan/horario_page.dart';
import 'features/plan/proceso_page.dart';
import 'features/preparador/alta_page.dart';
import 'features/preparador/mi_preparador_page.dart';
import 'features/preparador/buscar_preparador_page.dart';
import 'features/preparador/busquedas_page.dart';
import 'features/preparador/preparador_page.dart';
import 'features/preparador/semana_page.dart';
import 'features/preparador/sesion_page.dart';
import 'features/preparador/sustituciones.dart';
import 'features/test/estadisticas_page.dart';
import 'features/test/examen_page.dart';
import 'features/test/motor_test.dart';
import 'features/test/resultados_page.dart';
import 'theme/app_theme.dart';
import 'widgets/comunes.dart';

/// Cinco bloques, iguales para opositores y preparadores: Hoy (qué toca),
/// Estudiar (temario y test), Cantes (programar, cantar y anotar), Organización
/// (cronograma, probabilidades, convocatoria, horario y estructura del temario,
/// como la sección de la web) y Más (preparador, cuenta y ajustes).
/// Navegador de cada pestaña (para volver a su inicio con un segundo toque).
final clavesRamas = [for (var i = 0; i < 5; i++) GlobalKey<NavigatorState>(debugLabel: 'rama$i')];

final _router = GoRouter(
  initialLocation: '/hoy',
  // Una ruta que no existe (un aviso antiguo, un enlace roto) lleva a Hoy en
  // vez de a la página de error del enrutador, de la que no se puede salir.
  onException: (_, state, router) => router.go('/hoy'),
  // Rutas de antes de la reorganización (avisos, enlaces guardados): a su sitio nuevo.
  // El examen y los resultados llevan sus datos en `extra`, que el historial
  // del navegador no guarda: al volver a ellos con «atrás» (o al recargar), a Estudiar.
  redirect: (context, state) => switch (state.uri.path) {
        '/examen' when state.extra is! ConfigTest && state.extra is! TestEnCurso => '/estudiar',
        '/resultados' when state.extra is! DatosResultado => '/estudiar',
        final ruta => rutaNueva(ruta),
      },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _Shell(shell: shell),
      branches: [
        StatefulShellBranch(navigatorKey: clavesRamas[0], routes: [GoRoute(path: '/hoy', builder: (c, s) => const InicioPage())]),
        StatefulShellBranch(navigatorKey: clavesRamas[1], routes: [
          GoRoute(path: '/estudiar', builder: (c, s) => const EstudiarPage(), routes: [
            GoRoute(path: 'test/estadisticas', builder: (c, s) => const EstadisticasPage()),
          ]),
        ]),
        StatefulShellBranch(navigatorKey: clavesRamas[2], routes: [GoRoute(path: '/cantes', builder: (c, s) => const CantesPage())]),
        StatefulShellBranch(navigatorKey: clavesRamas[3], routes: [
          GoRoute(path: '/organizacion', builder: (c, s) => const OrganizacionHubPage(), routes: [
            GoRoute(path: 'cronograma', builder: (c, s) => const CronogramaPage()),
            GoRoute(path: 'probabilidades', builder: (c, s) => const ProbabilidadesPage()),
            GoRoute(path: 'convocatoria', builder: (c, s) => const ConvocatoriaPage()),
            GoRoute(path: 'proceso', builder: (c, s) => const ProcesoPage()),
            GoRoute(path: 'horario', builder: (c, s) => const HorarioPage()),
            GoRoute(path: 'estructura', builder: (c, s) => const OrganizacionPage()),
            GoRoute(path: 'mapa-calor', builder: (c, s) => const MapaCalorPage()),
          ]),
        ]),
        StatefulShellBranch(navigatorKey: clavesRamas[4], routes: [
          GoRoute(path: '/mas', builder: (c, s) => const MasPage(), routes: [
            GoRoute(path: 'cuenta', builder: (c, s) => const CuentaPage()),
            GoRoute(path: 'economia', builder: (c, s) => const EconomiaPage()),
            GoRoute(path: 'preparador', builder: (c, s) => const PreparadorPage(), routes: [
              GoRoute(path: 'alta', builder: (c, s) => const AltaPreparadorPage()),
            ]),
            GoRoute(path: 'mi-preparador', builder: (c, s) => const MiPreparadorPage()),
          ]),
        ]),
      ],
    ),
    // Fuera del shell: pantalla completa sin barra inferior.
    GoRoute(
      path: '/examen',
      // Un test nuevo (ConfigTest) o uno a medias que se continúa (TestEnCurso).
      builder: (c, s) => s.extra is TestEnCurso ? ExamenPage(config: (s.extra as TestEnCurso).config, reanudar: s.extra as TestEnCurso) : ExamenPage(config: s.extra as ConfigTest),
    ),
    GoRoute(path: '/resultados', builder: (c, s) => ResultadosPage(datos: s.extra as DatosResultado)),
  ],
);

/// Ruta nueva de una de antes de la reorganización en cinco bloques (o null si no cambia).
String? rutaNueva(String ruta) => const {
      '/temario': '/estudiar',
      '/test': '/estudiar',
      '/test/estadisticas': '/estudiar/test/estadisticas',
      '/temario/organizacion': '/organizacion/estructura',
      '/temario/probabilidades': '/organizacion/probabilidades',
      '/temario/cronograma': '/organizacion/cronograma',
      '/mas/convocatoria': '/organizacion/convocatoria',
      '/mas/horario': '/organizacion/horario',
    }[ruta];

class TceeApp extends ConsumerStatefulWidget {
  const TceeApp({super.key});
  @override
  ConsumerState<TceeApp> createState() => _TceeAppState();
}

class _TceeAppState extends ConsumerState<TceeApp> {
  late final AppLifecycleListener _ciclo;
  Timer? _periodico;
  /// Cronómetro de los alumnos en sus clases de ahora (para el preparador).
  late final VigilanteRelojes _relojes = VigilanteRelojes(ref);

  @override
  void initState() {
    super.initState();
    // Con sesión, lo que se cambia en otro dispositivo (o lo que programa el
    // preparador, o lo que marca el alumno) llega al volver a la app y, con
    // ella abierta, cada pocos minutos.
    _ciclo = AppLifecycleListener(
      onResume: () {
        ref.read(sesionProvider.notifier).sincronizarSiToca();
        _programar();
        _anotarUso();
        // En el navegador: si se ha publicado otra versión, se ofrece recargar.
        if (kIsWeb) ref.invalidate(actualizacionProvider);
        // Lo que haya cambiado en los ajustes del sistema, y la escucha en
        // tiempo real de las clases del preparador.
        ref.invalidate(permisosProvider);
        if (ref.read(usuarioActualProvider) != null) {
          ref.read(cantesProvider.notifier).escucharNube();
          ref.read(sesionesProvider.notifier).escucharAlumnos();
        }
      },
      onHide: () {
        _periodico?.cancel();
        ref.read(cantesProvider.notifier).dejarDeEscuchar();
        ref.read(sesionesProvider.notifier).dejarDeEscucharAlumnos();
      },
    );
    _programar();
    Notificaciones.alTocar = _alTocarNotificacion;
    _relojes.empezar();
    ref.listenManual(sesionesProvider, (_, __) => _relojes.revisar());
    ref.listenManual(cantesProvider, (_, __) => _relojes.revisar());
    // Los temas de las próximas clases con preparador, fijados desde el
    // cronograma para que el preparador vea la misma lista (comparta o no el
    // cronograma). Converge: una vez fijados, el origen ya no es el cronograma.
    ref.listenManual(cantesProvider, (_, __) => _fijarTemasDeClases(), fireImmediately: true);
    ref.listenManual(cronogramaProvider, (_, __) => _fijarTemasDeClases());
    ref.listenManual(ajustesProvider, (_, __) => _fijarTemasDeClases());
    // Los deberes que se tachan solos (tema estudiado, esquema, cante, test).
    ref.listenManual(cantesProvider, (_, __) => _tacharDeberes(), fireImmediately: true);
    ref.listenManual(ajustesProvider, (_, __) => _tacharDeberes());
    ref.listenManual(historialProvider, (_, __) => _tacharDeberes());
    // Un alumno nuevo (o uno que se va): se escuchan sus clases.
    ref.listenManual(alumnosProvider, (antes, ahora) {
      if (antes?.map((a) => '${a.id}:${a.uid}').join() != ahora.map((a) => '${a.id}:${a.uid}').join()) ref.read(sesionesProvider.notifier).escucharAlumnos();
    });
    ref.listenManual(papelProvider, (_, __) => _relojes.revisar());
    // Estadísticas (si están activadas): la pantalla que se ve y, como
    // propiedades, la oposición, el papel y de dónde se instaló (Play, APK o
    // navegador). Nunca datos personales.
    _router.routerDelegate.addListener(_pantallaVista);
    _pantallaVista();
    _anotarUso();
    ref.listenManual(papelProvider, (_, p) => Analitica.instancia.usuario(papel: p.name), fireImmediately: true);
    Analitica.instancia.usuario(oposicion: ref.read(oposicionProvider).id);
    origenInstalacion().then((o) => Analitica.instancia.usuario(instalacion: o.name));
    ref.listenManual(usuarioActualProvider, (_, __) => _relojes.revisar());
    // Widget de la pantalla de inicio: al abrir la app desde él o tocarlo con ella abierta.
    abiertoDesdeWidget().then(_desdeWidget);
    _clicsWidget = clicsEnWidget().listen(_desdeWidget);
    // Enlace de invitación de un preparador tocado con la app ya abierta.
    _enlaces = enlacesEntrantes().listen(_desdeEnlace);
    // Y se redibuja cuando cambia lo que muestra.
    ref.listenManual(datosWidgetProvider, (_, d) => actualizarWidget(d), fireImmediately: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(serviciosProvider).firebaseDisponible) ref.read(sesionProvider.notifier).renovarFoto();
      // Invitación pendiente (del enlace o del referrer de Play, leída al
      // arrancar): directo a conectar con el preparador.
      if (Invitacion.pendiente() != null) _router.go('/mas/mi-preparador');
      // La primera vez: para qué sirven los avisos y el permiso para
      // mostrarlos; después, la guía de la app (una vez por oposición y papel)
      // y, a quien acaba de elegir «Preparo a opositores», el alta.
      Future.delayed(const Duration(milliseconds: 800), () async {
        final c = _router.routerDelegate.navigatorKey.currentContext;
        // ignore: use_build_context_synchronously
        if (c != null && mounted) await mostrarHojaPermisosSiToca(c);
        if (!mounted) return;
        // ¿Enviar estadísticas de uso? Una vez; apagado si no dice que sí.
        // ignore: use_build_context_synchronously
        final preguntado = c != null && mounted && await preguntarEstadisticasSiToca(c, ref);
        if (!mounted) return;
        // ¿Las clases y los cantes a Google Calendar? Una vez por dispositivo,
        // y no en el mismo arranque que la pregunta anterior.
        // ignore: use_build_context_synchronously
        if (c != null && mounted) await preguntarCalendarioSiToca(c, ref, trasOtraPregunta: preguntado);
        if (!mounted) return;
        await empezarGuiaSiToca(ref);
        if (mounted) await _abrirAltaSiToca();
      });
    });
  }

  /// El día de hoy como último uso de la app, si el opositor comparte con su
  /// preparador cuándo la usó por última vez (solo el día). Una escritura al día.
  void _anotarUso() {
    final a = ref.read(ajustesProvider);
    if (!a.avisosPreparador.contains('uso')) return;
    final hoy = Ajustes.claveDia(DateTime.now());
    if (a.ultimoUso == hoy) return;
    ref.read(ajustesProvider.notifier).actualizar((x) => x.copyWith(ultimoUso: hoy));
  }

  /// Abre el test diario de hoy (si no está hecho; si no, Hoy).
  void _abrirTestDiario() {
    final banco = ref.read(preguntasProvider).valueOrNull;
    _router.go('/hoy');
    if (banco == null || ref.read(testDiarioHechoProvider)) return;
    _router.push('/examen', extra: ConfigTest(idsFijos: MotorTest.testDiario(banco, DateTime.now()).map((p) => p.id).toList(), minutos: 15, tipo: 'diario'));
  }

  /// Quien acaba de elegir «Preparo a opositores» va directo a pedir la
  /// verificación (salvo que ya esté verificado o la haya pedido antes).
  Future<void> _abrirAltaSiToca() async {
    if (!Hive.isBoxOpen(Cajas.app)) return;
    final caja = Hive.box(Cajas.app);
    if (caja.get(claveAbrirAlta) != ref.read(oposicionProvider).id) return;
    await caja.delete(claveAbrirAlta);
    EstadoRed? estado;
    try {
      estado = await ref.read(estadoRedProvider.future).timeout(const Duration(seconds: 8));
    } catch (_) {}
    if (!mounted || (estado?.verificado ?? false) || estado?.solicitud != null) return;
    _router.go('/mas/preparador/alta');
  }

  StreamSubscription<Uri?>? _clicsWidget;
  StreamSubscription<Uri>? _enlaces;

  /// Enlace `…/app/?codigo=…` con la app abierta: la invitación queda
  /// pendiente y se abre Mi preparador con el código puesto.
  Future<void> _desdeEnlace(Uri uri) async {
    final inv = Invitacion.deUri(uri);
    if (inv == null) return;
    await inv.guardar();
    if (!mounted) return;
    ref.invalidate(invitacionPendienteProvider);
    _router.go('/mas/mi-preparador');
  }

  /// tcee://widget/{ruta}: cada zona del widget abre su pantalla.
  void _desdeWidget(Uri? uri) {
    if (uri == null || uri.host != 'widget') return;
    final ruta = uri.path;
    if (ruta == '/test-diario') {
      _abrirTestDiario();
      return;
    }
    if (ruta == '/cantes') ref.read(subpestanaCantesProvider.notifier).state = 0;
    _router.go(ruta.isEmpty ? '/hoy' : ruta);
  }

  /// Al tocar una notificación: `url:` abre esa página (p. ej. la del proceso
  /// selectivo o la descarga de la versión nueva); `ruta:` lleva a la pantalla
  /// de la app que corresponde (la clase, el tablón, la semana, el test…);
  /// `actualizar:` actualiza por Play si se puede y, si no, abre esa descarga.
  void _alTocarNotificacion(String contenido) {
    if (contenido.startsWith('actualizar:')) {
      _router.go('/hoy');
      final ctx = _router.routerDelegate.navigatorKey.currentContext;
      if (ctx != null) actualizar(ctx, contenido.substring(11));
      return;
    }
    if (contenido.startsWith('url:')) {
      launchUrl(Uri.parse(contenido.substring(4)), mode: LaunchMode.externalApplication).catchError((_) => false);
      return;
    }
    if (!contenido.startsWith('ruta:')) return;
    final uri = Uri.parse(contenido.substring(5));
    final nav = _router.routerDelegate.navigatorKey.currentState;
    final cante = uri.queryParameters['cante'];
    final tema = uri.queryParameters['tema'];
    switch (uri.path) {
      case '/cantes' when cante != null:
        // Tema que manda el preparador: «Empezar el esquema» abre Cantar con
        // él; tocar el aviso (o «Ver») abre la clase.
        if (uri.queryParameters['accion'] == 'esquema') {
          empezarCante(ref, _router, cante, tema: tema, arrancarEsquema: true);
        } else {
          _router.go('/cantes');
          nav?.push(MaterialPageRoute(builder: (_) => CantePage(id: cante)));
        }
      case '/clase':
        // Clase del preparador con un alumno.
        final id = uri.queryParameters['id'];
        _router.go('/cantes');
        if (id != null) nav?.push(MaterialPageRoute(builder: (_) => SesionPage(id: id)));
      case '/tablon':
        _router.go('/mas/preparador');
        nav?.push(MaterialPageRoute(builder: (_) => const TablonPage()));
      case '/semana':
        _router.go('/cantes');
        nav?.push(MaterialPageRoute(builder: (_) => const SemanaPage()));
      case '/busquedas':
        // Opositores que buscan preparador (al preparador).
        _router.go('/mas/preparador');
        nav?.push(MaterialPageRoute(builder: (_) => const BusquedasPage()));
      case '/buscar-preparador':
        // Preparadores interesados en lo que busca (al opositor).
        _router.go('/mas/mi-preparador');
        nav?.push(MaterialPageRoute(builder: (_) => const BuscarPreparadorPage()));
      case '/hoy' when uri.queryParameters['test'] == 'diario':
        _abrirTestDiario();
      default:
        _router.go(uri.path);
    }
  }

  void _programar() {
    _periodico?.cancel();
    _periodico = Timer.periodic(const Duration(minutes: 3), (_) => ref.read(sesionProvider.notifier).sincronizarSiToca());
  }

  String? _ultimaPantalla;
  bool _fijando = false;
  Future<void> _fijarTemasDeClases() async {
    if (_fijando) return;
    // Nunca dentro de un build (el primer aviso llega en initState): se espera al siguiente tick.
    await Future<void>.delayed(Duration.zero);
    if (!mounted || _fijando) return;
    final ajustes = ref.read(ajustesProvider);
    final pendientes = clasesParaFijar(ref.read(cantesProvider), elegidos: ajustes.temasClases, cronograma: ref.read(cronogramaProvider), noCantar: ajustes.noCantar, ahora: DateTime.now());
    if (pendientes.isEmpty) return;
    _fijando = true;
    try {
      for (final e in pendientes.entries) {
        await ref.read(ajustesProvider.notifier).fijarTemasClase(e.key, e.value);
      }
    } catch (_) {
      // Sin ajustes todavía (arranque) o sin sitio: se intenta en el siguiente cambio.
    } finally {
      _fijando = false;
    }
  }

  bool _tachando = false;
  Future<void> _tacharDeberes() async {
    if (_tachando) return;
    await Future<void>.delayed(Duration.zero);
    if (!mounted || _tachando) return;
    final repo = ref.read(usuarioRepoProvider);
    final cambiadas = tacharDeberes(
      ref.read(cantesProvider).where((c) => c.dePreparador),
      estudiados: ref.read(ajustesProvider).temasEstudiados,
      cantes: ref.read(cantesProvider),
      tests: ref.read(historialProvider).valueOrNull ?? repo.resultadosLocales(),
      banco: ref.read(preguntasProvider).valueOrNull,
    );
    if (cambiadas.isEmpty) return;
    _tachando = true;
    try {
      await ref.read(cantesProvider.notifier).guardarVarios(cambiadas);
    } catch (_) {
      // Se vuelve a intentar en el siguiente cambio.
    } finally {
      _tachando = false;
    }
  }

  void _pantallaVista() {
    final nombre = Analitica.nombreDePantalla(_router.routerDelegate.currentConfiguration.uri.toString());
    if (nombre == _ultimaPantalla) return;
    _ultimaPantalla = nombre;
    Analitica.instancia.pantalla(nombre);
  }

  @override
  void dispose() {
    _router.routerDelegate.removeListener(_pantallaVista);
    _periodico?.cancel();
    _ciclo.dispose();
    Notificaciones.alTocar = null;
    _relojes.cerrar();
    _clicsWidget?.cancel();
    _enlaces?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PantallaError.alInicio = () => _router.go('/hoy');
    // Al cargarse la sesión (al arrancar o al iniciarla) se sincroniza todo.
    ref.listen(usuarioActualProvider, (antes, ahora) {
      if (ahora != null && antes?.uid != ahora.uid) {
        ref.read(sesionProvider.notifier).sincronizarSiToca(forzar: true);
        ref.read(cantesProvider.notifier).escucharNube();
        ref.read(sesionesProvider.notifier).escucharAlumnos();
      }
      if (ahora == null) {
        ref.read(cantesProvider.notifier).dejarDeEscuchar();
        ref.read(sesionesProvider.notifier).dejarDeEscucharAlumnos();
        // Firebase ha cerrado la sesión en pleno uso (token invalidado) sin
        // que el usuario tocara «Cerrar sesión»: se recupera sin preguntar.
        if (antes != null && !saliendoAProposito) unawaited(recuperarSesion());
      }
    });
    return MaterialApp.router(
      title: Creditos.nombreApp,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.claro,
      darkTheme: AppTheme.oscuro,
      themeMode: ref.watch(modoTemaProvider),
      locale: const Locale('es', 'ES'),
      supportedLocales: const [Locale('es', 'ES')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
      // Barras del sistema en las pantallas sin cabecera morada y abajo:
      // iconos oscuros sobre fondo claro y claros sobre fondo oscuro.
      builder: (context, child) {
        final tema = Theme.of(context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: estiloBarrasSistema(arriba: tema.scaffoldBackgroundColor, abajo: tema.navigationBarTheme.backgroundColor ?? tema.scaffoldBackgroundColor),
          child: ref.watch(versionObsoletaProvider).valueOrNull ?? false ? const _VersionObsoleta() : child!,
        );
      },
    );
  }
}

class _Shell extends ConsumerWidget {
  const _Shell({required this.shell});
  final StatefulNavigationShell shell;

  static const _destinos = [
    (Icons.today_outlined, Icons.today, 'Hoy'),
    (Icons.menu_book_outlined, Icons.menu_book, 'Estudiar'),
    (Icons.record_voice_over_outlined, Icons.record_voice_over, 'Cantes'),
    (Icons.event_note_outlined, Icons.event_note, 'Organización'),
    (Icons.more_horiz, Icons.more_horiz, 'Más'),
  ];

  /// Un toque cambia de pestaña; otro toque en la misma vuelve a su página
  /// principal: cierra lo abierto encima (fichas, temas, clases: rutas sin
  /// nombre que goBranch no toca) y va a la ruta inicial de la rama.
  void _ir(int i) {
    if (i == shell.currentIndex) clavesRamas[i].currentState?.popUntil((r) => r.isFirst);
    shell.goBranch(i, initialLocation: i == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Cada paso de la guía abre su pestaña (y su subpestaña).
    ref.listen(guiaProvider, (antes, e) {
      // Al acabarla, de vuelta a Hoy.
      if (e == null) {
        if (antes != null) shell.goBranch(0, initialLocation: true);
        return;
      }
      final p = e.paso;
      if (p.estudiar != null) ref.read(subpestanaEstudiarProvider.notifier).state = p.estudiar!;
      if (p.cantes != null) ref.read(subpestanaCantesProvider.notifier).state = p.cantes!;
      shell.goBranch(p.pestana, initialLocation: true);
    });
    final guia = ref.watch(guiaProvider);
    final pantalla = _pantalla(context);
    return guia == null ? pantalla : Stack(children: [pantalla, Positioned.fill(child: CapaGuia(estado: guia))]);
  }

  Widget _pantalla(BuildContext context) {
    // Pantalla ancha (ordenador, tableta en horizontal): el menú va a la izquierda.
    if (MediaQuery.sizeOf(context).width >= 720) {
      return Scaffold(
        body: Row(children: [
          DecoratedBox(
            decoration: BoxDecoration(border: Border(right: BorderSide(color: context.colores.borde))),
            child: NavigationRail(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _ir,
              labelType: NavigationRailLabelType.all,
              groupAlignment: -0.9,
              // La cuenta, con la foto de Google, arriba del todo.
              leading: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Tooltip(
                  message: 'Cuenta',
                  child: InkWell(customBorder: const CircleBorder(), onTap: () => GoRouter.of(context).go('/mas/cuenta'), child: const AvatarUsuario(radio: 18)),
                ),
              ),
              destinations: [
                for (final (i, d) in _destinos.indexed)
                  NavigationRailDestination(icon: AnclaGuia(pestana: i, child: Icon(d.$1)), selectedIcon: AnclaGuia(pestana: i, child: Icon(d.$2)), label: Text(d.$3)),
              ],
            ),
          ),
          Expanded(child: shell),
        ]),
      );
    }
    // La etiqueta más larga («Organización») cabe en una línea: si con la
    // tipografía de la oposición no cabe en el ancho de cada destino, se reduce.
    final tema = NavigationBarTheme.of(context);
    final base = tema.labelTextStyle?.resolve({WidgetState.selected}) ?? const TextStyle(fontSize: 10.5);
    final medida = (TextPainter(text: TextSpan(text: 'Organización', style: base), textDirection: TextDirection.ltr, textScaler: MediaQuery.textScalerOf(context))..layout()).width;
    final cabe = MediaQuery.sizeOf(context).width / _destinos.length - 8;
    final factor = medida > cabe ? cabe / medida : 1.0;
    return Scaffold(
      body: shell,
      // Menú de la web (.main-nav): papel, con filete superior y etiquetas en minúscula.
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colores.borde))),
        child: NavigationBarTheme(
          data: factor == 1.0
              ? tema
              : tema.copyWith(
                  labelTextStyle: WidgetStateProperty.resolveWith((estados) {
                    final t = tema.labelTextStyle?.resolve(estados) ?? base;
                    return t.copyWith(fontSize: (t.fontSize ?? 10.5) * factor, letterSpacing: (t.letterSpacing ?? 0) * factor);
                  }),
                ),
          child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: _ir,
          destinations: [
            for (final (i, d) in _destinos.indexed)
              NavigationDestination(icon: AnclaGuia(pestana: i, child: Icon(d.$1)), selectedIcon: AnclaGuia(pestana: i, child: Icon(d.$2)), label: d.$3),
          ],
          ),
        ),
      ),
    );
  }
}

/// La versión instalada es más antigua que la mínima compatible: se pide
/// actualizar (sin sincronizar, para no estropear los datos de la cuenta).
class _VersionObsoleta extends ConsumerWidget {
  const _VersionObsoleta();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).valueOrNull;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.system_update_outlined, size: 56, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 16),
              Text('Actualiza la app', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                'Esta versión ya no es compatible con la de tus otros dispositivos y podría estropear tus datos (clases, alumnos, temas). Actualízala para seguir: se instala encima, sin perder nada.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(onPressed: () => actualizar(context, config?.urlPlayStore ?? config?.urlApk), icon: const Icon(Icons.download_outlined), label: const Text('Actualizar')),
            ]),
          ),
        ),
      ),
    );
  }
}
