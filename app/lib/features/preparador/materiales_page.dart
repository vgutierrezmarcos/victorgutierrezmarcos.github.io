import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../data/models/temario.dart';
import '../../data/repos/red_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'materiales_widgets.dart';
import 'alta_page.dart';

/// Materiales que el preparador comparte con sus alumnos: enlaces (Drive,
/// PDF en la web, vídeos…) con un título y una nota, para todos sus alumnos
/// enlazados o para algunos, y si va de un tema, el tema.
class MaterialesPage extends ConsumerWidget {
  const MaterialesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(misMaterialesProvider);
    final verificado = ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false;
    final alumnos = ref.watch(alumnosProvider);
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    String destinatarios(MaterialCompartido m) {
      if (m.paraTodos) return 'Para todos tus alumnos';
      final nombres = [for (final uid in m.alumnos) alumnos.where((a) => a.uid == uid).firstOrNull?.nombre].whereType<String>().toList();
      if (nombres.isEmpty) return 'Para ${m.alumnos.length} ${m.alumnos.length == 1 ? 'alumno' : 'alumnos'}';
      return nombres.length <= 2 ? 'Para ${nombres.join(' y ')}' : 'Para ${nombres.length} alumnos';
    }

    Future<void> borrar(MaterialCompartido m) async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Quitar este material?'),
          content: Text('«${m.titulo}» dejará de verse en la app de tus alumnos. El fichero o la página enlazados no se tocan.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Quitar')),
          ],
        ),
      );
      if (ok != true) return;
      try {
        await ref.read(redRepoProvider).borrarMaterial(m.id);
      } catch (_) {}
      ref.invalidate(misMaterialesProvider);
    }

    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Materiales para tus alumnos'),
        actions: [if (verificado) IconButton(tooltip: 'Compartir material', icon: const Icon(Icons.add), onPressed: () => ir(const MaterialFormPage()))],
      ),
      floatingActionButton: verificado ? FloatingActionButton.extended(onPressed: () => ir(const MaterialFormPage()), icon: const Icon(Icons.add_link), label: const Text('Material')) : null,
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(misMaterialesProvider),
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
          children: [
            Text('Comparte enlaces con tus alumnos: tus temas en Drive, un PDF, un vídeo, una página… Con un título, una nota y, si va de un tema, el tema: les aparece en «Mi preparador» y en ese tema del temario, y les llega un aviso.', style: context.textos.bodySmall),
            const SizedBox(height: 10),
            if (!verificado) ...[
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Para compartir materiales tienes que estar verificado como preparador.', style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  OutlinedButton(onPressed: () => ir(const AltaPreparadorPage()), child: const Text('Pedir la verificación')),
                ]),
              ),
            ] else
              ...switch (materiales) {
                AsyncData(:final value) => value.isEmpty
                    ? [Text('Todavía no has compartido nada. Toca «Material» para añadir el primero.', style: context.textos.bodySmall)]
                    : [
                        for (final m in value)
                          TarjetaMaterial(
                            material: m,
                            subtitulo: destinatarios(m),
                            accion: PopupMenuButton<String>(
                              onSelected: (v) => v == 'editar' ? ir(MaterialFormPage(material: m)) : borrar(m),
                              itemBuilder: (_) => const [PopupMenuItem(value: 'editar', child: Text('Editar')), PopupMenuItem(value: 'borrar', child: Text('Quitar'))],
                            ),
                          ),
                      ],
                AsyncError() => [Text('No se han podido cargar. Desliza hacia abajo para reintentarlo.', style: context.textos.bodySmall)],
                _ => [const Center(child: CircularProgressIndicator())],
              },
          ],
        ),
      ),
    );
  }
}

/// Alta o edición de un material. Con [alumnoUid] viene preelegido ese alumno;
/// con [tema], ese tema.
class MaterialFormPage extends ConsumerStatefulWidget {
  const MaterialFormPage({super.key, this.material, this.alumnoUid, this.tema});
  final MaterialCompartido? material;
  final String? alumnoUid;
  final String? tema;
  @override
  ConsumerState<MaterialFormPage> createState() => _MaterialFormPageState();
}

class _MaterialFormPageState extends ConsumerState<MaterialFormPage> {
  late final _titulo = TextEditingController(text: widget.material?.titulo ?? '');
  late final _url = TextEditingController(text: widget.material?.url ?? '');
  late final _texto = TextEditingController(text: widget.material?.texto ?? '');
  late String? _tema = widget.material?.tema ?? widget.tema;
  late bool _todos = widget.material?.paraTodos ?? widget.alumnoUid == null;
  late final Set<String> _alumnos = {...?widget.material?.alumnos, if (widget.alumnoUid != null) widget.alumnoUid!};
  bool _guardando = false;

  @override
  void dispose() {
    _titulo.dispose();
    _url.dispose();
    _texto.dispose();
    super.dispose();
  }

  Future<void> _pegar() async {
    final texto = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? '';
    final url = enlaceMaterial(texto);
    if (url != null) {
      setState(() => _url.text = url);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay ningún enlace copiado.')));
    }
  }

  Future<void> _elegirTema() async {
    final temario = ref.read(temarioProvider).valueOrNull;
    if (temario == null) return;
    final t = await elegirUnTema(context, temario: temario, actual: _tema);
    if (t != null) setState(() => _tema = t.isEmpty ? null : t);
  }

  Future<void> _guardar() async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    final url = enlaceMaterial(_url.text);
    final titulo = _titulo.text.trim();
    if (titulo.isEmpty || url == null) {
      messenger.showSnackBar(SnackBar(content: Text(titulo.isEmpty ? 'Ponle un título.' : 'El enlace tiene que empezar por http:// o https://.')));
      return;
    }
    if (!_todos && _alumnos.isEmpty) {
      messenger.showSnackBar(const SnackBar(content: Text('Elige al menos un alumno o compártelo con todos.')));
      return;
    }
    final red = ref.read(redRepoProvider);
    final perfil = ref.read(perfilPreparadorProvider);
    final m = (widget.material ?? MaterialCompartido(id: 'mat_${nuevoId()}', preparador: red.uid ?? '', titulo: titulo, url: url, creado: DateTime.now())).copyWith(
      titulo: titulo,
      url: url,
      texto: _texto.text.trim(),
      tema: _tema,
      sinTema: _tema == null,
      paraTodos: _todos,
      alumnos: _todos ? const [] : _alumnos.toList(),
      preparadorNombre: perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? ''),
    );
    setState(() => _guardando = true);
    try {
      await red.guardarMaterial(m);
      ref.invalidate(misMaterialesProvider);
      messenger.showSnackBar(SnackBar(content: Text(widget.material == null ? 'Compartido. Tus alumnos lo verán en Mi preparador y les llegará un aviso.' : 'Guardado.')));
      nav.pop();
    } on ErrorRed catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.mensaje)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo guardar: $e')));
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final alumnos = ref.watch(misAlumnosProvider).where((a) => a.enlazado).toList();
    final temario = ref.watch(temarioProvider).valueOrNull;
    final tema = _tema == null ? null : temario?.tema(_tema!);
    return Scaffold(
      appBar: BarraWeb(
        title: Text(widget.material == null ? 'Compartir material' : 'Editar material'),
        actions: [TextButton(onPressed: _guardando ? null : _guardar, child: const Text('Guardar'))],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          const TituloSeccion('Qué es'),
          TextField(controller: _titulo, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(labelText: 'Título', hintText: 'Esquema del tema 3.A.7, vídeo de la clase…')),
          const SizedBox(height: 10),
          TextField(
            controller: _url,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'Enlace',
              hintText: 'https://drive.google.com/…',
              helperText: 'Drive, Dropbox, un PDF en una web, YouTube… Comprueba que el enlace esté compartido con quien lo abra.',
              helperMaxLines: 3,
              prefixIcon: const Icon(Icons.link),
              suffixIcon: IconButton(tooltip: 'Pegar', icon: const Icon(Icons.content_paste), onPressed: _pegar),
            ),
          ),
          const SizedBox(height: 10),
          TextField(controller: _texto, minLines: 2, maxLines: 6, maxLength: 2000, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(labelText: 'Nota (opcional)', hintText: 'Qué es y cómo usarlo')),
          const TituloSeccion('Tema (opcional)'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.menu_book_outlined),
              title: tema == null ? Text(_tema ?? 'Sin tema: material general', style: context.textos.titleSmall) : TextoTema(tema.codigo, tema.titulo, maxLines: 2, color: ref.watch(estructuraProvider).valueOrNull?.colorDe(tema.codigo)),
              subtitle: Text(_tema == null ? 'Si va de un tema, el alumno lo verá también dentro de ese tema.' : 'Toca para cambiarlo.', style: context.textos.labelSmall),
              trailing: _tema == null ? const Icon(Icons.chevron_right) : IconButton(tooltip: 'Quitar el tema', icon: const Icon(Icons.close), onPressed: () => setState(() => _tema = null)),
              onTap: _elegirTema,
            ),
          ),
          const TituloSeccion('Para quién'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              SwitchListTile(
                title: const Text('Todos mis alumnos enlazados'),
                subtitle: Text(_todos ? 'También los que se conecten contigo más adelante.' : 'Solo los que marques.', style: context.textos.labelSmall),
                value: _todos,
                onChanged: (v) => setState(() => _todos = v),
              ),
              if (!_todos)
                if (alumnos.isEmpty)
                  Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 12), child: Text('Ningún alumno ha enlazado su app contigo todavía.', style: context.textos.bodySmall))
                else
                  for (final a in alumnos)
                    CheckboxListTile(
                      dense: true,
                      value: _alumnos.contains(a.uid),
                      onChanged: (v) => setState(() => v == true ? _alumnos.add(a.uid!) : _alumnos.remove(a.uid)),
                      title: Text(a.nombre),
                    ),
            ]),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: _guardando ? null : _guardar, icon: const Icon(Icons.share_outlined), label: Text(widget.material == null ? 'Compartir' : 'Guardar')),
        ],
      ),
    );
  }
}

/// Hoja para elegir un solo tema del temario, con buscador. Devuelve su
/// código, '' para «ninguno», o null si se cierra sin elegir.
Future<String?> elegirUnTema(BuildContext context, {required Temario temario, String? actual}) {
  final todos = temario.todosLosTemas;
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (d) {
      var filtro = '';
      return StatefulBuilder(
        builder: (d, set) {
          final f = filtro.toLowerCase();
          final lista = f.isEmpty ? todos : todos.where((t) => t.codigo.toLowerCase().contains(f) || t.titulo.toLowerCase().contains(f)).toList();
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.viewInsetsOf(d).bottom),
              child: SizedBox(
                height: MediaQuery.sizeOf(d).height * 0.75,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Text('¿De qué tema es?', style: d.textos.titleLarge),
                  const SizedBox(height: 8),
                  TextField(autofocus: false, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Buscar por número o título'), onChanged: (v) => set(() => filtro = v)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lista.length,
                      itemBuilder: (_, i) {
                        final t = lista[i];
                        return ListTile(
                          dense: true,
                          selected: t.codigo == actual,
                          title: Text('${t.codigo} · ${t.titulo}', maxLines: 2, overflow: TextOverflow.ellipsis),
                          onTap: () => Navigator.pop(d, t.codigo),
                        );
                      },
                    ),
                  ),
                  TextButton(onPressed: () => Navigator.pop(d, ''), child: const Text('Sin tema')),
                ]),
              ),
            ),
          );
        },
      );
    },
  );
}
