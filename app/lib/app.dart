import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/providers.dart';
import 'features/blog/blog_page.dart';
import 'features/cantar/cantar_page.dart';
import 'features/inicio/inicio_page.dart';
import 'features/mas/cuenta_page.dart';
import 'features/mas/mas_page.dart';
import 'features/temario/temario_page.dart';
import 'features/test/config_test_page.dart';
import 'features/test/estadisticas_page.dart';
import 'features/test/examen_page.dart';
import 'features/test/motor_test.dart';
import 'features/test/resultados_page.dart';
import 'theme/app_theme.dart';

final _router = GoRouter(
  initialLocation: '/inicio',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _Shell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/inicio', builder: (c, s) => const InicioPage())]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/test', builder: (c, s) => const ConfigTestPage(), routes: [
            GoRoute(path: 'estadisticas', builder: (c, s) => const EstadisticasPage()),
          ]),
        ]),
        StatefulShellBranch(routes: [GoRoute(path: '/temario', builder: (c, s) => const TemarioPage())]),
        StatefulShellBranch(routes: [GoRoute(path: '/cantar', builder: (c, s) => const CantarPage())]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/mas', builder: (c, s) => const MasPage(), routes: [
            GoRoute(path: 'blog', builder: (c, s) => const BlogPage()),
            GoRoute(path: 'cuenta', builder: (c, s) => const CuentaPage()),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.quiz_outlined), selectedIcon: Icon(Icons.quiz), label: 'Test'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Temario'),
          NavigationDestination(icon: Icon(Icons.record_voice_over_outlined), selectedIcon: Icon(Icons.record_voice_over), label: 'Cantar'),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Más'),
        ],
      ),
    );
  }
}
