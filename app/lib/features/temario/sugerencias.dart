import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../data/models/sugerencia.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Las sugerencias que el usuario ha mandado al autor en esta oposición
/// (desde la app o desde su IA), con lo que se le haya contestado.
final misSugerenciasProvider = StreamProvider<List<Sugerencia>>((ref) {
  ref.watch(authStateProvider);
  return ref.watch(usuarioRepoProvider).sugerencias();
});

/// Diálogo de «Sugerir una mejora» en un tema o en su ficha: qué le pasa, en
/// qué apartado y qué habría que cambiar. Le llega al autor sin el nombre ni
/// el correo de quien la manda (ver UsuarioRepo.sugerirMejora).
Future<void> sugerirMejora(BuildContext context, WidgetRef ref, {required String tema, required String recurso, String version = '', List<String> apartados = const []}) async {
  final repo = ref.read(usuarioRepoProvider);
  final messenger = ScaffoldMessenger.of(context);
  if (!repo.conSesion) {
    messenger.mostrar(const SnackBar(content: Text('Inicia sesión para sugerir una mejora.')));
    return;
  }
  var tipo = 'poco_claro';
  var apartado = '';
  var corto = false;
  final texto = TextEditingController();
  final enviar = await showDialog<bool>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, setD) => AlertDialog(
        title: const Text('Sugerir una mejora'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(recurso == 'ficha' ? 'Ficha de repaso del tema $tema' : 'Tema $tema', style: Theme.of(d).textTheme.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: tipo,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Qué le pasa'),
              items: [for (final t in Sugerencia.tipos.entries) DropdownMenuItem(value: t.key, child: Text(t.value))],
              onChanged: (v) => setD(() => tipo = v ?? tipo),
            ),
            if (apartados.isNotEmpty) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: apartado,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Dónde'),
                items: [
                  const DropdownMenuItem(value: '', child: Text('En todo el tema')),
                  for (final a in apartados) DropdownMenuItem(value: a, child: Text(a, overflow: TextOverflow.ellipsis)),
                ],
                onChanged: (v) => setD(() => apartado = v ?? ''),
              ),
            ],
            const SizedBox(height: 12),
            TextField(
              controller: texto,
              maxLines: 6,
              minLines: 3,
              maxLength: 2000,
              decoration: InputDecoration(
                hintText: 'Qué habría que cambiar y por qué (con la fuente, si la tienes).',
                errorText: corto ? 'Cuenta qué habría que cambiar.' : null,
              ),
            ),
            Text('Es anónima: el autor no ve quién la manda. Verás en qué queda en Más → Mis sugerencias.', style: Theme.of(d).textTheme.bodySmall),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () => texto.text.trim().length < 10 ? setD(() => corto = true) : Navigator.pop(d, true),
            child: const Text('Enviar'),
          ),
        ],
      ),
    ),
  );
  if (enviar != true) return;
  try {
    // Sin red, Firestore lo guarda y lo manda al volver: no esperar más de unos segundos.
    await repo
        .sugerirMejora(recurso: recurso, tema: tema, apartado: apartado, tipo: tipo, propuesta: texto.text.trim(), version: version)
        .timeout(const Duration(seconds: 8), onTimeout: () {});
    messenger.mostrar(const SnackBar(content: Text('Sugerencia enviada. Gracias.')));
  } catch (_) {
    messenger.mostrar(const SnackBar(content: Text('No se pudo enviar. Inténtalo de nuevo.')));
  }
}

/// Aviso de Inicio: el autor ha contestado a alguna sugerencia y aún no se ha visto.
class AvisoSugerencias extends ConsumerWidget {
  const AvisoSugerencias({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nuevas = (ref.watch(misSugerenciasProvider).valueOrNull ?? const <Sugerencia>[]).where((s) => s.novedad).toList();
    if (nuevas.isEmpty) return const SizedBox.shrink();
    final aceptadas = nuevas.where((s) => s.aceptada).length;
    return Aviso(
      icono: Icons.rate_review_outlined,
      titulo: nuevas.length == 1 ? 'Han contestado a tu sugerencia del ${nuevas.first.tema}' : 'Han contestado a ${nuevas.length} sugerencias tuyas',
      texto: aceptadas > 0 ? 'Gracias: ${aceptadas == 1 ? 'una ha servido' : '$aceptadas han servido'} para mejorar el material. Toca para verlo.' : 'Toca para ver la respuesta.',
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MisSugerenciasPage())),
    );
  }
}

/// Más → Mis sugerencias: lo que el usuario ha propuesto mejorar y en qué ha quedado.
class MisSugerenciasPage extends ConsumerStatefulWidget {
  const MisSugerenciasPage({super.key});
  @override
  ConsumerState<MisSugerenciasPage> createState() => _MisSugerenciasPageState();
}

class _MisSugerenciasPageState extends ConsumerState<MisSugerenciasPage> {
  /// Las que eran novedad al abrir la página: se marcan como vistas, pero
  /// siguen destacadas mientras se está en ella.
  final _recienVistas = <String>{};

  void _marcar(List<Sugerencia> lista) {
    final nuevas = [for (final s in lista) if (s.novedad && !_recienVistas.contains(s.id)) s.id];
    if (nuevas.isEmpty) return;
    _recienVistas.addAll(nuevas);
    ref.read(usuarioRepoProvider).marcarSugerenciasVistas(nuevas).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(misSugerenciasProvider);
    final lista = estado.valueOrNull ?? const <Sugerencia>[];
    WidgetsBinding.instance.addPostFrameCallback((_) => mounted ? _marcar(lista) : null);
    final mejorados = Sugerencia.materialesMejorados(lista);
    return Scaffold(
      appBar: BarraWeb(title: const Text('Mis sugerencias')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          if (!ref.watch(usuarioRepoProvider).conSesion)
            const VacioVista(icono: Icons.rate_review_outlined, texto: 'Inicia sesión para ver las sugerencias que has enviado.')
          else if (estado.isLoading && lista.isEmpty)
            const Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()))
          else if (lista.isEmpty)
            const VacioVista(
              icono: Icons.rate_review_outlined,
              texto: 'Aún no has enviado ninguna.\n\nSi algo de un tema o de una ficha no se entiende, falta o está mal, dilo desde el propio tema («Sugerir una mejora») o deja que tu IA lo proponga por ti con EconomIA. Son anónimas.',
            )
          else ...[
            if (mejorados > 0)
              Aviso(
                icono: Icons.volunteer_activism_outlined,
                titulo: mejorados == 1 ? 'Has ayudado a mejorar un material' : 'Has ayudado a mejorar $mejorados materiales',
                texto: 'Gracias. Lo que avisas lo aprovechan todos los que estudian con estos temas.',
              ),
            for (final s in lista) _Fila(s, destacada: _recienVistas.contains(s.id)),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Las sugerencias son anónimas: el autor las lee sin saber quién las manda.', style: context.textos.labelSmall),
            ),
          ],
        ],
      ),
    );
  }
}

class _Fila extends StatelessWidget {
  const _Fila(this.s, {required this.destacada});
  final Sugerencia s;
  final bool destacada;

  @override
  Widget build(BuildContext context) {
    final c = s.creado;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        destacada: destacada,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Wrap(spacing: 8, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(s.titulo, style: context.textos.titleSmall),
            Etiqueta(s.nombreEstado, color: s.aceptada ? context.colores.dorado : (s.resuelta ? context.colores.textoClaro : null)),
          ]),
          const SizedBox(height: 2),
          Text(
            [s.nombreTipo, if (s.apartado.isNotEmpty) s.apartado, if (c != null) '${c.day}/${c.month}/${c.year}', if (s.desdeIa) 'con tu IA'].join(' · '),
            style: context.textos.labelSmall,
          ),
          const SizedBox(height: 6),
          Text(s.propuesta, maxLines: 6, overflow: TextOverflow.ellipsis),
          if (s.respuesta.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Respuesta del autor', style: context.textos.labelSmall),
            Text(s.respuesta),
          ],
        ]),
      ),
    );
  }
}
