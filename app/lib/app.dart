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

class TceeApp extends ConsumerWidget {
  const TceeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      // Menú de la web (.main-nav): blanco, con filete superior y etiquetas en mayúsculas.
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colores.borde))),
        child: NavigationBar(
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.today_outlined), selectedIcon: Icon(Icons.today), label: 'HOY'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'TEMARIO'),
            NavigationDestination(icon: Icon(Icons.record_voice_over_outlined), selectedIcon: Icon(Icons.record_voice_over), label: 'CANTES'),
            NavigationDestination(icon: Icon(Icons.quiz_outlined), selectedIcon: Icon(Icons.quiz), label: 'TEST'),
            NavigationDestination(icon: Icon(Icons.more_horiz), selectedIcon: Icon(Icons.more_horiz), label: 'MÁS'),
          ],
        ),
      ),
    );
  }
}
