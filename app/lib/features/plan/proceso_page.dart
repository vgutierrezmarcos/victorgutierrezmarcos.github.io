import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/avisos_proceso.dart';
import '../../core/constants.dart';
import '../../core/notificaciones.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/proceso.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// El proceso selectivo según la página oficial del Ministerio: lo último que
/// se ha publicado, todo el proceso por apartados y el aviso de novedades.
class ProcesoPage extends ConsumerStatefulWidget {
  const ProcesoPage({super.key});
  @override
  ConsumerState<ProcesoPage> createState() => _ProcesoPageState();
}

class _ProcesoPageState extends ConsumerState<ProcesoPage> {
  int _convocatoria = 0;
  bool _avisos = false;

  @override
  void initState() {
    super.initState();
    avisosProcesoActivados(ref.read(oposicionProvider).id).then((v) {
      if (mounted) setState(() => _avisos = v);
    });
  }

  Future<void> _alternarAvisos(bool v) async {
    final messenger = ScaffoldMessenger.of(context);
    if (v) {
      final permiso = kIsWeb ? await pedirPermisoNotificacionesNavegador() : await Notificaciones.pedirPermiso();
      if (!permiso) {
        messenger.showSnackBar(const SnackBar(content: Text('Sin permiso para mostrar notificaciones')));
        return;
      }
    }
    await activarAvisosProceso(
      ref.read(oposicionProvider).id,
      v,
      json: ref.read(procesoJsonProvider).valueOrNull,
      conSesion: ref.read(usuarioActualProvider) != null,
    );
    if (!mounted) return;
    setState(() => _avisos = v);
    messenger.showSnackBar(SnackBar(
      content: Text(v
          ? (kIsWeb ? 'Te avisaremos al abrir la app cuando haya algo nuevo.' : 'Te avisaremos cuando se publique algo nuevo.')
          : 'Ya no te avisaremos de las novedades del proceso.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final oposicion = ref.watch(oposicionProvider);
    final procesos = ref.watch(procesoProvider);
    return Scaffold(
      appBar: BarraWeb(title: const Text('Proceso selectivo'), subtitulo: oposicion.siglas),
      body: procesos.when(
        loading: () => const Cargando(),
        error: (e, _) => ErrorVista(error: e, reintentar: () => ref.invalidate(procesoJsonProvider)),
        data: (lista) {
          if (lista.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Todavía no hay aquí información del proceso. Mientras tanto, la tienes en la sección de empleo del Ministerio.', textAlign: TextAlign.center, style: context.textos.bodyMedium),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: () => abrirUrl(context, 'https://portal.mineco.gob.es/es-es/ministerio/empleo/Paginas/default.aspx'),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Empleo en el Ministerio'),
                  ),
                ]),
              ),
            );
          }
          final p = lista[_convocatoria.clamp(0, lista.length - 1)];
          final ahora = DateTime.now();
          final novedades = p.novedades.take(5).toList();
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(procesoJsonProvider),
            child: ListaAdaptable(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              children: [
                Text('Lo publica el Ministerio en la página del proceso: convocatoria, inscripción, admitidos, calendario, convocatorias de cada ejercicio y aprobados. La app la revisa varias veces al día.', style: context.textos.bodySmall),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => abrirUrl(context, p.url),
                  icon: const Icon(Icons.open_in_new),
                  label: Text('Abrir la página oficial (OEP ${p.convocatoria})'),
                ),
                if (lista.length > 1) ...[
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, children: [
                    for (final (i, x) in lista.indexed)
                      ChoiceChip(label: Text('Convocatoria ${x.convocatoria}'), selected: i == _convocatoria, onSelected: (_) => setState(() => _convocatoria = i)),
                  ]),
                ],
                const SizedBox(height: 8),
                Tarjeta(
                  padding: EdgeInsets.zero,
                  child: SwitchListTile(
                    secondary: Icon(Icons.notifications_active_outlined, color: context.esquema.primary),
                    title: const Text('Avisarme de las novedades'),
                    subtitle: Text(
                      kIsWeb
                          ? 'En el navegador, al abrir la app. En el móvil llegan aunque no la abras.'
                          : 'Una notificación cuando aparezca un documento nuevo; al tocarla se abre la página oficial.',
                      style: context.textos.labelSmall,
                    ),
                    value: _avisos,
                    onChanged: _alternarAvisos,
                  ),
                ),
                if (novedades.isNotEmpty) ...[
                  const TituloSeccion('Lo último'),
                  for (final d in novedades) _Documento(d, conSeccion: true, nuevo: d.reciente(ahora)),
                ],
                for (final (seccion, docs) in p.secciones.reversed) ...[
                  TituloSeccion(seccion),
                  for (final d in docs) _Documento(d, nuevo: d.reciente(ahora)),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text('La información oficial es la de la página del Ministerio y el BOE. La app solo enlaza sus documentos y no envía nada tuyo para comprobarlos.', style: context.textos.labelSmall),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Documento extends StatelessWidget {
  const _Documento(this.d, {this.conSeccion = false, this.nuevo = false});
  final DocumentoProceso d;
  final bool conSeccion;
  final bool nuevo;

  @override
  Widget build(BuildContext context) {
    final pdf = d.url.toLowerCase().endsWith('.pdf');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
        onTap: () => abrirUrl(context, d.url),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(top: 2), child: Icon(pdf ? Icons.picture_as_pdf_outlined : Icons.open_in_new, color: context.esquema.primary, size: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (conSeccion || nuevo)
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Wrap(spacing: 6, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
                    if (nuevo) Etiqueta('NUEVO', color: context.colores.dorado),
                    if (conSeccion) Text(d.seccion.toUpperCase(), style: context.textos.labelSmall?.copyWith(letterSpacing: 0.4)),
                    if (conSeccion && d.desde != null) Text('· ${DateFormat("d MMM", 'es').format(d.desde!)}', style: context.textos.labelSmall),
                  ]),
                ),
              Text(d.titulo, maxLines: 4, overflow: TextOverflow.ellipsis, style: context.textos.bodyMedium),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// En Hoy: lo último que ha publicado el Ministerio, si es de esta semana y
/// no se ha descartado.
class TarjetaNovedadProceso extends ConsumerStatefulWidget {
  const TarjetaNovedadProceso({super.key});
  @override
  ConsumerState<TarjetaNovedadProceso> createState() => _TarjetaNovedadProcesoState();
}

class _TarjetaNovedadProcesoState extends ConsumerState<TarjetaNovedadProceso> {
  String get _clave => 'proceso_descartado:${ref.read(oposicionProvider).id}';

  @override
  Widget build(BuildContext context) {
    final procesos = ref.watch(procesoProvider).valueOrNull ?? const [];
    final ultimo = procesos.expand((p) => p.novedades).where((d) => d.reciente(DateTime.now(), dias: 7)).firstOrNull;
    final caja = Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;
    if (ultimo == null || caja?.get(_clave) == ultimo.id) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
        onTap: () => context.go('/organizacion/proceso'),
        child: Row(children: [
          Icon(Icons.gavel_outlined, color: context.esquema.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Novedad en el proceso', style: context.textos.titleSmall),
              Text('${ultimo.seccion}: ${ultimo.titulo}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall),
            ]),
          ),
          IconButton(
            tooltip: 'Descartar',
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => setState(() => caja?.put(_clave, ultimo.id)),
          ),
        ]),
      ),
    );
  }
}
