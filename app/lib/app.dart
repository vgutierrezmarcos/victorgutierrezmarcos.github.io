import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/constants.dart';
import 'core/notificaciones.dart';
import 'core/red_providers.dart';
import 'core/widget_inicio.dart';
import 'core/widget_providers.dart';
import 'core/providers.dart';
import 'features/cantar/probabilidades_page.dart';
import 'features/cantes/cantes_page.dart';
import 'features/cronograma/cronograma_page.dart';
import 'features/estudiar/estudiar_page.dart';
import 'features/inicio/inicio_page.dart';
import 'features/mas/cuenta_page.dart';
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
import 'features/preparador/preparador_page.dart';
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
final _router = GoRouter(
  initialLocation: '/hoy',
  // Rutas de antes de la reorganización (avisos, enlaces guardados): a su sitio nuevo.
  redirect: (context, state) => rutaNueva(state.uri.path),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _Shell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/hoy', builder: (c, s) => const InicioPage())]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/estudiar', builder: (c, s) => const EstudiarPage(), routes: [
            GoRoute(path: 'test/estadisticas', builder: (c, s) => const EstadisticasPage()),
          ]),
        ]),
        StatefulShellBranch(routes: [GoRoute(path: '/cantes', builder: (c, s) => const CantesPage())]),
        StatefulShellBranch(routes: [
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
        StatefulShellBranch(routes: [
          GoRoute(path: '/mas', builder: (c, s) => const MasPage(), routes: [
            GoRoute(path: 'cuenta', builder: (c, s) => const CuentaPage()),
            GoRoute(path: 'preparador', builder: (c, s) => const PreparadorPage(), routes: [
              GoRoute(path: 'alta', builder: (c, s) => const AltaPreparadorPage()),
            ]),
            GoRoute(path: 'mi-preparador', builder: (c, s) => const MiPreparadorPage()),
          ]),
        ]),
      ],
    ),
    // Fuera del shell: pantalla completa sin barra inferior.
    GoRoute(path: '/examen', builder: (c, s) => ExamenPage(config: s.extra as ConfigTest)),
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
      },
      onHide: () => _periodico?.cancel(),
    );
    _programar();
    Notificaciones.alTocar = _alTocarNotificacion;
    // Widget de la pantalla de inicio: al abrir la app desde él o tocarlo con ella abierta.
    abiertoDesdeWidget().then(_desdeWidget);
    _clicsWidget = clicsEnWidget().listen(_desdeWidget);
    // Y se redibuja cuando cambia lo que muestra.
    ref.listenManual(datosWidgetProvider, (_, d) => actualizarWidget(d), fireImmediately: true);
    WidgetsBinding.instance.addPostFrameCallback((_) => _abrirAltaSiToca());
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

  /// tcee://widget/{ruta}: cada zona del widget abre su pantalla.
  void _desdeWidget(Uri? uri) {
    if (uri == null || uri.host != 'widget') return;
    final ruta = uri.path;
    if (ruta == '/test-diario') {
      final banco = ref.read(preguntasProvider).valueOrNull;
      if (banco == null || ref.read(testDiarioHechoProvider)) {
        _router.go('/hoy');
        return;
      }
      _router.go('/hoy');
      _router.push('/examen', extra: ConfigTest(idsFijos: MotorTest.testDiario(banco, DateTime.now()).map((p) => p.id).toList(), minutos: 15, tipo: 'diario'));
      return;
    }
    if (ruta == '/cantes') ref.read(subpestanaCantesProvider.notifier).state = 0;
    _router.go(ruta.isEmpty ? '/hoy' : ruta);
  }

  /// Al tocar una notificación: `url:` abre esa página (p. ej. la del proceso
  /// selectivo); `ruta:` lleva a esa pantalla de la app.
  void _alTocarNotificacion(String contenido) {
    if (contenido.startsWith('url:')) {
      launchUrl(Uri.parse(contenido.substring(4)), mode: LaunchMode.externalApplication).catchError((_) => false);
    } else if (contenido.startsWith('ruta:')) {
      final uri = Uri.parse(contenido.substring(5));
      final cante = uri.queryParameters['cante'];
      final tema = uri.queryParameters['tema'];
      if (uri.path == '/cantes' && cante != null) {
        // Tema que manda el preparador: «Empezar el esquema» abre Cantar con
        // él; tocar el aviso abre la clase.
        if (uri.queryParameters['accion'] == 'esquema') {
          empezarCante(ref, _router, cante, tema: tema);
        } else {
          _router.go('/cantes');
          final nav = _router.routerDelegate.navigatorKey.currentState;
          nav?.push(MaterialPageRoute(builder: (_) => CantePage(id: cante)));
        }
        return;
      }
      _router.go(uri.toString());
    }
  }

  void _programar() {
    _periodico?.cancel();
    _periodico = Timer.periodic(const Duration(minutes: 3), (_) => ref.read(sesionProvider.notifier).sincronizarSiToca());
  }

  @override
  void dispose() {
    _periodico?.cancel();
    _ciclo.dispose();
    Notificaciones.alTocar = null;
    _clicsWidget?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Al cargarse la sesión (al arrancar o al iniciarla) se sincroniza todo.
    ref.listen(usuarioActualProvider, (antes, ahora) {
      if (ahora != null && antes?.uid != ahora.uid) ref.read(sesionProvider.notifier).sincronizarSiToca(forzar: true);
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
          child: child!,
        );
      },
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.shell});
  final StatefulNavigationShell shell;

  static const _destinos = [
    (Icons.today_outlined, Icons.today, 'HOY'),
    (Icons.menu_book_outlined, Icons.menu_book, 'ESTUDIAR'),
    (Icons.record_voice_over_outlined, Icons.record_voice_over, 'CANTES'),
    (Icons.event_note_outlined, Icons.event_note, 'ORGANIZACIÓN'),
    (Icons.more_horiz, Icons.more_horiz, 'MÁS'),
  ];

  void _ir(int i) => shell.goBranch(i, initialLocation: i == shell.currentIndex);

  @override
  Widget build(BuildContext context) {
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
              destinations: [for (final d in _destinos) NavigationRailDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: Text(d.$3))],
            ),
          ),
          Expanded(child: shell),
        ]),
      );
    }
    // La etiqueta más larga («ORGANIZACIÓN») cabe en una línea: si con la
    // tipografía de la oposición no cabe en el ancho de cada destino, se reduce.
    final tema = NavigationBarTheme.of(context);
    final base = tema.labelTextStyle?.resolve({WidgetState.selected}) ?? const TextStyle(fontSize: 10.5);
    final medida = (TextPainter(text: TextSpan(text: 'ORGANIZACIÓN', style: base), textDirection: TextDirection.ltr, textScaler: MediaQuery.textScalerOf(context))..layout()).width;
    final cabe = MediaQuery.sizeOf(context).width / _destinos.length - 8;
    final factor = medida > cabe ? cabe / medida : 1.0;
    return Scaffold(
      body: shell,
      // Menú de la web (.main-nav): blanco, con filete superior y etiquetas en mayúsculas.
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
          destinations: [for (final d in _destinos) NavigationDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: d.$3)],
          ),
        ),
      ),
    );
  }
}
