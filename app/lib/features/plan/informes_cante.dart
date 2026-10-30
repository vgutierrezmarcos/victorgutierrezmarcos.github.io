import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/avisos_breves.dart';
import '../../core/providers.dart';
import '../../data/models/informe_cante.dart';
import '../../data/models/oposicion.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/markdown_simple.dart';
import 'cantes_util.dart';

/// Firestore de los informes (en las pruebas, uno simulado).
final firestoreInformesProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

CollectionReference<Map<String, dynamic>> coleccionInformes(FirebaseFirestore db, Oposicion oposicion, {required String uid, required String canteId}) =>
    oposicion.raizUsuario(db, uid).collection('cantes').doc(canteId).collection('informes');

/// Los informes que la IA ha guardado de un cante de [uid] (el propio
/// opositor, o su alumno si quien mira es el preparador enlazado), los más
/// recientes primero. Sin permiso o sin conexión, ninguno.
final informesCanteProvider = StreamProvider.autoDispose.family<List<InformeCante>, ({String uid, String canteId})>((ref, k) {
  if (!ref.watch(serviciosProvider).firebaseDisponible || ref.watch(usuarioActualProvider) == null) return Stream.value(const []);
  final col = coleccionInformes(ref.watch(firestoreInformesProvider), ref.watch(oposicionProvider), uid: k.uid, canteId: k.canteId);
  return col.snapshots().map((s) => InformeCante.ordenar(s.docs.map((d) => InformeCante.fromJson(d.id, d.data())))).handleError((_) {});
});

String _fechaInforme(InformeCante i) => i.fecha == null ? 'sin fecha' : '${fechaCorta(i.fecha!)}, ${horaDe(i.fecha!)}';

/// Apartado «Informes de la IA» de la ficha de un cante: la lista por fecha
/// (de quién es y su primera línea) y, al tocar uno, el informe entero. No
/// aparece si no hay ninguno. [propio]: el del opositor, que puede borrarlos;
/// el preparador solo los lee.
class SeccionInformesCante extends ConsumerWidget {
  const SeccionInformesCante({super.key, required this.uid, required this.canteId, this.propio = false, this.titulo = true});
  final String uid;
  final String canteId;
  final bool propio;

  /// Con su [TituloSeccion] (en una hoja inferior, sin él).
  final bool titulo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final informes = ref.watch(informesCanteProvider((uid: uid, canteId: canteId))).valueOrNull ?? const <InformeCante>[];
    if (informes.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      if (titulo) TituloSeccion(informes.length == 1 ? 'Informe de la IA' : 'Informes de la IA (${informes.length})') else const SizedBox(height: 8),
      GrupoFilas(children: [
        for (final i in informes)
          ListTile(
            leading: Icon(Icons.auto_awesome_outlined, color: context.esquema.primary),
            title: Text('${i.autor} · ${_fechaInforme(i)}', style: context.textos.titleSmall),
            subtitle: Text(i.primeraLinea, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
            trailing: i.valoracion > 0 ? Estrellas(valor: i.valoracion, tamano: 14) : Icon(Icons.chevron_right, color: context.colores.textoClaro),
            onTap: () => Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => InformeCantePage(informe: i, uid: uid, canteId: canteId, propio: propio))),
          ),
      ]),
      if (!propio) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Los ha guardado el alumno desde su IA. Solo puedes leerlos.', style: context.textos.labelSmall)),
    ]);
  }
}

/// Un informe entero: valoración, comentarios y tareas, y el texto en
/// Markdown tal como lo escribió la IA.
class InformeCantePage extends ConsumerWidget {
  const InformeCantePage({super.key, required this.informe, required this.uid, required this.canteId, this.propio = false});
  final InformeCante informe;
  final String uid;
  final String canteId;
  final bool propio;

  Future<void> _borrar(BuildContext context, WidgetRef ref) async {
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Borrar el informe?'),
        content: const Text('Se borra de tu diario (y deja de verlo tu preparador). El cante y su valoración no se tocan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Borrar')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await coleccionInformes(ref.read(firestoreInformesProvider), ref.read(oposicionProvider), uid: uid, canteId: canteId).doc(informe.id).delete();
      nav.pop();
      messenger.mostrar(const SnackBar(content: Text('Informe borrado')));
    } catch (_) {
      messenger.mostrar(const SnackBar(content: Text('No se ha podido borrar. Revisa la conexión.')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = informe;
    return Scaffold(
      appBar: BarraWeb(
        title: Text('Informe de ${i.autor}'),
        subtitulo: _fechaInforme(i),
        actions: [
          IconButton(
            tooltip: 'Copiar el informe',
            icon: const Icon(Icons.copy),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await Clipboard.setData(ClipboardData(text: i.informe));
              messenger.mostrar(const SnackBar(content: Text('Informe copiado')));
            },
          ),
          if (propio) IconButton(tooltip: 'Borrar', icon: const Icon(Icons.delete_outline), onPressed: () => _borrar(context, ref)),
        ],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Aviso(
            icono: Icons.auto_awesome_outlined,
            titulo: 'Lo ha escrito ${i.autor == 'tu IA' ? 'tu IA' : '${i.autor}, con el conector'}${i.fecha == null ? '' : ' el ${_fechaInforme(i)}'}.',
            texto: 'Es una IA y puede equivocarse: contrasta con tu preparador lo que te sorprenda.',
          ),
          if (i.valoracion > 0 || i.valoraciones.isNotEmpty || i.criterios.isNotEmpty || i.comentarios.isNotEmpty || i.tareas.isNotEmpty) ...[
            const SizedBox(height: 10),
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (i.valoracion > 0) Row(children: [Text('Valoración', style: context.textos.labelMedium), const SizedBox(width: 10), Estrellas(valor: i.valoracion, tamano: 20)]),
                for (final e in i.valoraciones.entries)
                  Padding(padding: const EdgeInsets.only(top: 4), child: Row(children: [Text(e.key, style: context.textos.labelMedium), const SizedBox(width: 10), Estrellas(valor: e.value, tamano: 16)])),
                if (i.criterios.isNotEmpty)
                  Padding(padding: const EdgeInsets.only(top: 6), child: Text([for (final e in i.criterios.entries) '${e.key} ${e.value}/5'].join(' · '), style: context.textos.bodySmall)),
                if (i.comentarios.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(i.comentarios, style: context.textos.bodyMedium)),
                if (i.tareas.isNotEmpty) ...[
                  Padding(padding: const EdgeInsets.only(top: 10, bottom: 2), child: Text('Antes del próximo cante', style: context.textos.titleSmall)),
                  for (final (n, t) in i.tareas.indexed) Text('${n + 1}. $t', style: context.textos.bodySmall),
                ],
              ]),
            ),
          ],
          const SizedBox(height: 12),
          if (i.informe.trim().isEmpty) Text('El informe no trae texto.', style: context.textos.bodySmall) else MarkdownSimple(i.informe),
        ],
      ),
    );
  }
}
