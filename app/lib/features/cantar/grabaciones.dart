import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Una grabación de un cante, guardada solo en este móvil (nunca en la nube).
class Grabacion {
  const Grabacion({required this.ruta, required this.fecha, this.canteId, this.tema});
  final String ruta;
  final DateTime fecha;
  /// El cante del diario al que va unida (null: no se guardó en el diario).
  final String? canteId;
  final String? tema;

  Map<String, dynamic> toJson() => {'ruta': ruta, 'fecha': fecha.millisecondsSinceEpoch, if (canteId != null) 'cante': canteId, if (tema != null) 'tema': tema};

  static Grabacion? deJson(Object? j) {
    if (j is! Map || j['ruta'] is! String) return null;
    return Grabacion(
      ruta: j['ruta'] as String,
      fecha: DateTime.fromMillisecondsSinceEpoch((j['fecha'] as num?)?.toInt() ?? 0),
      canteId: j['cante'] as String?,
      tema: j['tema'] as String?,
    );
  }

  Grabacion conCante(String id) => Grabacion(ruta: ruta, fecha: fecha, canteId: id, tema: tema);
}

/// Índice local de las grabaciones (caja `app`, clave [claveGrabaciones]).
/// En el navegador no hay: la grabación vive en memoria y se pierde al cerrar.
class Grabaciones {
  static Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;

  static List<Grabacion> todas() {
    final l = _caja?.get(claveGrabaciones);
    if (l is! List) return const [];
    final out = [for (final x in l) Grabacion.deJson(x)].whereType<Grabacion>().where((g) => existeFichero(g.ruta)).toList();
    out.sort((a, b) => b.fecha.compareTo(a.fecha));
    return out;
  }

  static List<Grabacion> deCante(String canteId) => todas().where((g) => g.canteId == canteId).toList();

  static Future<void> _guardar(List<Grabacion> l) async => _caja?.put(claveGrabaciones, [for (final g in l) g.toJson()]);

  /// Apunta una grabación recién hecha (aún sin cante).
  static Future<void> anotar(String ruta, {String? tema}) async {
    if (kIsWeb || ruta.isEmpty) return;
    await _guardar([Grabacion(ruta: ruta, fecha: DateTime.now(), tema: tema), ...todas().where((g) => g.ruta != ruta)]);
  }

  /// La une al cante del diario [canteId].
  static Future<void> unir(String ruta, String canteId) async {
    if (kIsWeb) return;
    final l = todas();
    final i = l.indexWhere((g) => g.ruta == ruta);
    if (i < 0) {
      l.insert(0, Grabacion(ruta: ruta, fecha: DateTime.now(), canteId: canteId));
    } else {
      l[i] = l[i].conCante(canteId);
    }
    await _guardar(l);
  }

  static Future<void> borrar(String ruta) async {
    borrarGrabacion(ruta);
    await _guardar(todas().where((g) => g.ruta != ruta).toList());
  }
}

/// Cambia al tocar o borrar una grabación (para que las listas se repinten).
final versionGrabacionesProvider = StateProvider<int>((ref) => 0);

/// Las grabaciones de [canteId] (o todas, con null), con escuchar, mandar y borrar.
class ListaGrabaciones extends ConsumerStatefulWidget {
  const ListaGrabaciones({super.key, this.canteId, this.vacio});
  final String? canteId;
  final Widget? vacio;
  @override
  ConsumerState<ListaGrabaciones> createState() => _ListaGrabacionesState();
}

class _ListaGrabacionesState extends ConsumerState<ListaGrabaciones> {
  AudioPlayer? _reproductor;
  String? _sonando;

  @override
  void dispose() {
    _reproductor?.dispose();
    super.dispose();
  }

  Future<void> _escuchar(String ruta) async {
    final r = _reproductor ??= AudioPlayer()..onPlayerComplete.listen((_) => mounted ? setState(() => _sonando = null) : null);
    if (_sonando == ruta) {
      await r.stop();
      setState(() => _sonando = null);
      return;
    }
    await r.stop();
    await r.play(DeviceFileSource(ruta));
    setState(() => _sonando = ruta);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(versionGrabacionesProvider);
    final cantes = {for (final c in ref.watch(cantesProvider)) c.id: c};
    final l = widget.canteId == null ? Grabaciones.todas() : Grabaciones.deCante(widget.canteId!);
    if (l.isEmpty) return widget.vacio ?? const SizedBox.shrink();
    return Tarjeta(
      padding: EdgeInsets.zero,
      child: Column(children: [
        for (final g in l)
          Builder(builder: (context) {
            final c = g.canteId == null ? null : cantes[g.canteId];
            final tema = c?.resultado?.temaCantado ?? g.tema;
            final titulo = [if (tema != null) tema, DateFormat("d MMM. y, HH:mm", 'es').format(g.fecha)].join(' · ');
            return ListTile(
              dense: true,
              leading: IconButton(
                tooltip: _sonando == g.ruta ? 'Parar' : 'Escuchar',
                icon: Icon(_sonando == g.ruta ? Icons.stop_circle_outlined : Icons.play_circle_outline, color: context.esquema.primary),
                onPressed: () => _escuchar(g.ruta),
              ),
              title: Text(titulo, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
              subtitle: widget.canteId != null ? null : Text(c == null ? 'Sin guardar en el diario' : (c.titulo.isEmpty ? 'En el diario' : 'En el diario · ${c.titulo}'), style: context.textos.labelSmall),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                  tooltip: 'Mandar (a tu preparador, por WhatsApp…)',
                  icon: const Icon(Icons.send_outlined, size: 20),
                  onPressed: () => SharePlus.instance.share(ShareParams(files: [XFile(g.ruta, mimeType: 'audio/mp4')], text: 'Grabación de mi cante${tema == null ? '' : ' del tema $tema'}')),
                ),
                IconButton(
                  tooltip: 'Borrar',
                  icon: const Icon(Icons.delete_outline, size: 20),
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (d) => AlertDialog(
                        title: const Text('¿Borrar la grabación?'),
                        content: const Text('Se borra de este móvil y no se puede recuperar.'),
                        actions: [TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')), FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Borrar'))],
                      ),
                    );
                    if (ok != true) return;
                    if (_sonando == g.ruta) await _reproductor?.stop();
                    await Grabaciones.borrar(g.ruta);
                    ref.read(versionGrabacionesProvider.notifier).state++;
                  },
                ),
              ]),
            );
          }),
      ]),
    );
  }
}

/// Mis grabaciones: todas las del móvil, unidas o no a un cante del diario.
class MisGrabacionesPage extends StatelessWidget {
  const MisGrabacionesPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: BarraWeb(title: const Text('Mis grabaciones')),
        body: ListaAdaptable(padding: const EdgeInsets.fromLTRB(16, 14, 16, 32), children: [
          Text('Se guardan solo en este móvil y no se suben a ningún sitio. Desde aquí puedes escucharlas, mandarlas a tu preparador por WhatsApp (o lo que uses) y borrarlas.', style: context.textos.bodySmall),
          const SizedBox(height: 10),
          const ListaGrabaciones(vacio: VacioVista(icono: Icons.mic_none, texto: 'Aún no hay grabaciones. En Cantar, «Grabar» graba tu exposición y, al guardar el cante en el diario, queda unida a él.')),
        ]),
      );
}
