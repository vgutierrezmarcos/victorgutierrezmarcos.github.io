import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/providers.dart';
import 'features/cantar/probabilidades_page.dart';
import 'features/cantes/cantes_page.dart';
import 'features/inicio/inicio_page.dart';
import 'features/mas/cuenta_page.dart';
import 'features/mas/mas_page.dart';
import 'features/organizacion/organizacion_page.dart';
import 'features/plan/convocatoria_page.dart';
import 'features/plan/horario_page.dart';
import 'features/preparador/preparador_page.dart';
import 'features/temario/temario_page.dart';
import 'features/test/config_test_page.dart';
import 'features/test/estadisticas_page.dart';
import 'features/test/examen_page.dart';
import 'features/test/motor_test.dart';
import 'features/test/resultados_page.dart';
import 'theme/app_theme.dart';

/// Cinco bloques: Hoy (qué toca), Temario (estudiar), Cantes (programar,
/// cantar y anotar), Test (simulador) y Más (convocatoria, horario,
/// preparadores, cuenta y ajustes).
final _router = GoRouter(
  initialLocation: '/hoy',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _Shell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/hoy', builder: (c, s) => const InicioPage())]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/temario', builder: (c, s) => const TemarioPage(), routes: [
            GoRoute(path: 'organizacion', builder: (c, s) => const OrganizacionPage()),
            GoRoute(path: 'probabilidades', builder: (c, s) => const ProbabilidadesPage()),
          ]),
        ]),
        StatefulShellBranch(routes: [GoRoute(path: '/cantes', builder: (c, s) => const CantesPage())]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/test', builder: (c, s) => const ConfigTestPage(), routes: [
            GoRoute(path: 'estadisticas', builder: (c, s) => const EstadisticasPage()),
          ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/mas', builder: (c, s) => const MasPage(), routes: [
            GoRoute(path: 'cuenta', builder: (c, s) => const CuentaPage()),
            GoRoute(path: 'convocatoria', builder: (c, s) => const ConvocatoriaPage()),
            GoRoute(path: 'horario', builder: (c, s) => const HorarioPage()),
            GoRoute(path: 'preparador', builder: (c, s) => const PreparadorPage()),
          ]),
        ]),
      ],
    ),
    // Fuera del shell: pantalla completa sin barra inferior.
    GoRoute(path: '/examen', builder: (c, s) => ExamenPage(config: s.extra as ConfigTest)),
    GoRoute(path: '/resultados', builder: (c, s) => ResultadosPage(datos: s.extra as DatosResultado)),
  ],
);

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
  }

  void _programar() {
    _periodico?.cancel();
    _periodico = Timer.periodic(const Duration(minutes: 3), (_) => ref.read(sesionProvider.notifier).sincronizarSiToca());
  }

  @override
  void dispose() {
    _periodico?.cancel();
    _ciclo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Oposición TCEE',
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
      builder: (context, child) => _AnchoMaximo(child: child ?? const SizedBox()),
    );
  }
}

/// En el ordenador la app ocupa, como la web, un máximo de 1000 px centrados
/// sobre el fondo verde; en el móvil no cambia nada.
class _AnchoMaximo extends StatelessWidget {
  const _AnchoMaximo({required this.child});
  final Widget child;
  static const ancho = 1000.0;

  @override
  Widget build(BuildContext context) {
    final medidas = MediaQuery.of(context);
    if (medidas.size.width <= ancho + 40) return child;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Container(
          width: ancho,
          decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 24)]),
          child: MediaQuery(data: medidas.copyWith(size: Size(ancho, medidas.size.height)), child: child),
        ),
      ),
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.shell});
  final StatefulNavigationShell shell;

  static const _destinos = [
    (Icons.today_outlined, Icons.today, 'HOY'),
    (Icons.menu_book_outlined, Icons.menu_book, 'TEMARIO'),
    (Icons.record_voice_over_outlined, Icons.record_voice_over, 'CANTES'),
    (Icons.quiz_outlined, Icons.quiz, 'TEST'),
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
              destinations: [for (final d in _destinos) NavigationRailDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: Text(d.$3))],
            ),
          ),
          Expanded(child: shell),
        ]),
      );
    }
    return Scaffold(
      body: shell,
      // Menú de la web (.main-nav): blanco, con filete superior y etiquetas en mayúsculas.
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colores.borde))),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: _ir,
          destinations: [for (final d in _destinos) NavigationDestination(icon: Icon(d.$1), selectedIcon: Icon(d.$2), label: d.$3)],
        ),
      ),
    );
  }
}
