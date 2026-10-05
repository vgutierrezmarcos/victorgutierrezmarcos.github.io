import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/comunes.dart';
import '../temario/temario_page.dart';
import '../test/config_test_page.dart';

/// Estudiar: el temario y el test, juntos, en dos subpestañas. Cada una conserva
/// su cabecera (buscador del temario, estadísticas del test) con las pestañas debajo.
class EstudiarPage extends ConsumerStatefulWidget {
  const EstudiarPage({super.key});
  @override
  ConsumerState<EstudiarPage> createState() => _EstudiarPageState();
}

class _EstudiarPageState extends ConsumerState<EstudiarPage> with SingleTickerProviderStateMixin {
  late final TabController _pestanas = TabController(length: 2, vsync: this, initialIndex: ref.read(subpestanaEstudiarProvider));

  @override
  void dispose() {
    _pestanas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indice = ref.watch(subpestanaEstudiarProvider);
    // Otras pantallas cambian de subpestaña (p. ej. «Nuevo test» al acabar uno).
    ref.listen(subpestanaEstudiarProvider, (_, i) {
      if (_pestanas.index != i) _pestanas.animateTo(i);
    });
    TabBar pestanas() => barraPestanas(context, controller: _pestanas, textos: const ['TEMAS', 'TEST'], onTap: (i) => ref.read(subpestanaEstudiarProvider.notifier).state = i);
    return IndexedStack(
      index: indice,
      children: [TemarioPage(pestanas: pestanas()), ConfigTestPage(pestanas: pestanas())],
    );
  }
}
