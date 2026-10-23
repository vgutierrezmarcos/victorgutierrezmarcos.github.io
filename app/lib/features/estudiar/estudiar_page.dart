import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../widgets/comunes.dart';
import '../temario/temario_page.dart';
import '../test/config_test_page.dart';

/// Estudiar: el temario y el test, juntos, en dos subpestañas. Cada una conserva
/// su cabecera (buscador del temario, estadísticas del test); los botones de las
/// subpestañas ([BotonesPestanas]) van debajo, en el cuerpo.
class EstudiarPage extends ConsumerStatefulWidget {
  const EstudiarPage({super.key});
  @override
  ConsumerState<EstudiarPage> createState() => _EstudiarPageState();
}

class _EstudiarPageState extends ConsumerState<EstudiarPage> with SingleTickerProviderStateMixin {
  // Se crea al montar: si se creara la primera vez que se usa, podría ser al
  // cerrar la pantalla, cuando ya no se puede leer `ref`.
  late final TabController _pestanas;

  @override
  void initState() {
    super.initState();
    _pestanas = TabController(length: 2, vsync: this, initialIndex: ref.read(subpestanaEstudiarProvider));
  }

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
    final temas = ref.watch(temarioProvider).valueOrNull?.todosLosTemas.length ?? 0;
    final preguntas = ref.watch(preguntasProvider).valueOrNull?.preguntas.length ?? 0;
    Widget pestanas() => BotonesPestanas(
          indice: indice,
          onCambiar: (i) => ref.read(subpestanaEstudiarProvider.notifier).state = i,
          pestanas: [
            PestanaBoton(texto: 'Temas', icono: Icons.menu_book_outlined, cifra: temas > 0 ? cifraEs(temas) : null, descripcion: temas > 0 ? 'Temas del temario: $temas' : 'Temas del temario'),
            PestanaBoton(
              texto: 'Test',
              icono: Icons.fact_check_outlined,
              cifra: preguntas > 0 ? '${cifraEs(preguntas)} preguntas' : null,
              cifraCorta: preguntas > 0 ? cifraEs(preguntas) : null,
              descripcion: preguntas > 0 ? 'Simulador de test: $preguntas preguntas de exámenes oficiales' : 'Simulador de test',
            ),
          ],
        );
    return IndexedStack(
      index: indice,
      children: [TemarioPage(pestanas: pestanas()), ConfigTestPage(pestanas: pestanas())],
    );
  }
}
