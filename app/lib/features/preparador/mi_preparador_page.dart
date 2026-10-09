import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../data/repos/red_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'buscar_preparador_page.dart';
import 'directorio_page.dart';
import 'materiales_widgets.dart';
import 'verificacion_page.dart';
import 'red_widgets.dart';
import 'reservas.dart';
import 'sustituciones.dart';
import '../mas/ayuda_videos.dart';

/// Mi preparador: el lado del opositor. Conectar con su preparador (o con
/// varios), reservar clase y pedir una clase suelta si se la cancelan.
class MiPreparadorPage extends ConsumerStatefulWidget {
  const MiPreparadorPage({super.key});
  @override
  ConsumerState<MiPreparadorPage> createState() => _MiPreparadorPageState();
}

class _MiPreparadorPageState extends ConsumerState<MiPreparadorPage> {
  final _codigo = TextEditingController();
  bool _conectando = false;
  bool _otroPreparador = false;

  @override
  void dispose() {
    _codigo.dispose();
    super.dispose();
  }

  Future<void> _conectar() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _conectando = true);
    final error = await ref.read(misPreparadoresProvider.notifier).enlazar(_codigo.text);
    if (!mounted) return;
    setState(() {
      _conectando = false;
      if (error == null) {
        _codigo.clear();
        _otroPreparador = false;
      }
    });
    messenger.showSnackBar(SnackBar(content: Text(error ?? 'Conectado. Tu preparador ya puede ver tu progreso.')));
  }

  /// Clases pendientes de un preparador en la agenda.
  List<Cante> _pendientesDe(String preparador) {
    final ahora = DateTime.now();
    return ref.read(cantesProvider).where((c) => c.preparador == preparador && c.pendiente && c.fecha.isAfter(ahora)).toList();
  }

  Future<void> _cancelarPendientes(List<Cante> clases, String motivo) async {
    final yo = ref.read(usuarioActualProvider)?.uid;
    await ref.read(cantesProvider.notifier).guardarVarios([for (final c in clases) c.copyWith(estado: EstadoCante.cancelado, motivo: motivo, canceladoPor: yo)]);
  }

  Future<void> _desconectar(VinculoPreparador v) async {
    final pendientes = _pendientesDe(v.uid);
    var cancelar = true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (d, set) => AlertDialog(
          title: const Text('¿Dejar de compartir?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${v.nombre.isEmpty ? 'Tu preparador' : v.nombre} dejará de ver tus temas y tus cantes. Los cantes que ya te haya valorado se quedan en tu diario.'),
            if (pendientes.isNotEmpty)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: cancelar,
                onChanged: (x) => set(() => cancelar = x ?? false),
                title: Text('Cancelar sus ${pendientes.length} ${pendientes.length == 1 ? 'clase pendiente' : 'clases pendientes'}'),
              ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Volver')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Dejar de compartir')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    if (cancelar && pendientes.isNotEmpty) await _cancelarPendientes(pendientes, 'Has dejado de compartir con tu preparador');
    await ref.read(misPreparadoresProvider.notifier).desenlazar(v.uid);
  }

  /// Quitar a un preparador que te cogió clases sueltas: pierde el acceso a
  /// esas clases y salen de la agenda las que no se han hecho.
  Future<void> _olvidarSustituto(String uid, String nombre) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('¿Quitar a $nombre?'),
        content: const Text('Dejará de tener acceso a las clases sueltas que te cogió (cronómetro, pizarra y temas). Las que estén pendientes se cancelan y salen de tu agenda; las ya hechas se quedan en tu diario.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Volver')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Quitar')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      final suyas = ref.read(cantesProvider).where((c) => c.preparador == uid && c.sustitucion != null && !c.hecho).toList();
      await _cancelarPendientes(suyas.where((c) => c.pendiente).toList(), 'Has quitado a este preparador');
      await ref.read(redRepoProvider).olvidarSustituto(uid);
      final notifier = ref.read(cantesProvider.notifier);
      for (final c in suyas) {
        await notifier.borrar(c);
      }
      ref.invalidate(misPeticionesProvider);
      messenger.showSnackBar(SnackBar(content: Text('$nombre ya no tiene acceso a tus clases.')));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo (${textoError(e)}).')));
    }
  }

  /// Preparadores (sin conexión con código) que te han cogido clases sueltas.
  List<Widget> _sustitutos(BuildContext context, List<VinculoPreparador> vinculos) {
    final todas = ref.watch(misPeticionesProvider).valueOrNull ?? const <Sustitucion>[];
    final enlazados = {for (final v in vinculos) v.uid};
    final porPreparador = <String, List<Sustitucion>>{};
    for (final s in todas.where((s) => s.cogida && s.cogidaPor != null && s.cogidaPor!.isNotEmpty && !enlazados.contains(s.cogidaPor))) {
      porPreparador.putIfAbsent(s.cogidaPor!, () => []).add(s);
    }
    if (porPreparador.isEmpty) return const [];
    return [
      const TituloSeccion('Preparadores de tus clases sueltas'),
      for (final e in porPreparador.entries)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Tarjeta(
            padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
            child: Row(children: [
              PuntoPersona(e.key, tamano: 14),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(e.value.first.cogidaPorNombre.isEmpty ? 'Preparador' : e.value.first.cogidaPorNombre, style: context.textos.titleSmall),
                  Text('${e.value.length} ${e.value.length == 1 ? 'clase suelta' : 'clases sueltas'}. Solo ve esas clases.', style: context.textos.labelSmall),
                ]),
              ),
              TextButton(onPressed: () => _olvidarSustituto(e.key, e.value.first.cogidaPorNombre.isEmpty ? 'este preparador' : e.value.first.cogidaPorNombre), child: const Text('Quitar')),
            ]),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final vinculos = ref.watch(misPreparadoresProvider);
    final ahora = DateTime.now();
    final misPeticiones = (ref.watch(misPeticionesProvider).valueOrNull ?? const <Sustitucion>[]).where((s) => s.vigente(ahora) && s.estado != EstadoSustitucion.cancelada).toList();
    final materiales = ref.watch(materialesParaMiProvider).valueOrNull ?? const <MaterialCompartido>[];
    final busqueda = ref.watch(miBusquedaProvider).valueOrNull;
    final interesados = busqueda == null ? 0 : (ref.watch(interesadosProvider(busqueda.id)).valueOrNull?.length ?? 0);
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    return Scaffold(
      appBar: const BarraWeb(title: Text('Mi preparador'), actions: [BotonVideoAyuda('conectar-preparador')]),
      body: RefreshIndicator(
        onRefresh: () async => refrescarRedDesdeWidget(ref),
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          children: [
            TituloSeccion(vinculos.length > 1 ? 'Tus preparadores' : 'Tu preparador'),
            for (final v in vinculos)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Tarjeta(
                  color: context.colores.primarioPalido,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      PuntoPersona(v.uid, tamano: 14),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(v.nombre.isEmpty ? 'Tu preparador' : v.nombre, style: context.textos.titleMedium),
                          Text('Conectado${v.desde == null ? '' : ' desde el ${fechaCorta(v.desde!)}'}. Ve tus temas y tus cantes. En tu agenda, sus clases llevan este color.', style: context.textos.bodySmall),
                        ]),
                      ),
                      TextButton(onPressed: () => _desconectar(v), child: const Text('Quitar')),
                    ]),
                    if (ref.watch(huecosDeProvider(v.uid)).value?.activo ?? false)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton.icon(onPressed: () => ir(ReservarPage(preparador: v)), icon: const Icon(Icons.event_available_outlined, size: 18), label: const Text('Reservar clase')),
                      ),
                  ]),
                ),
              ),
            ..._sustitutos(context, vinculos),
            if (vinculos.isEmpty || _otroPreparador)
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Conecta con tu preparador', style: context.textos.titleMedium),
                  const SizedBox(height: 4),
                  Text('Pídele su código de seis caracteres. Las clases que te programe aparecerán en tu agenda y sus valoraciones, en tu diario.', style: context.textos.bodySmall),
                  const SizedBox(height: 12),
                  if (!firebase)
                    Text('Esta versión no se conecta a la red de preparadores.', style: context.textos.labelSmall)
                  else if (usuario == null)
                    OutlinedButton.icon(onPressed: () => context.go('/mas/cuenta'), icon: const Icon(Icons.login, size: 18), label: const Text('Inicia sesión con Google para conectar'))
                  else
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _codigo,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 7,
                          style: TextStyle(fontFamily: Fuentes.sans, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 4),
                          decoration: const InputDecoration(hintText: 'CÓDIGO', counterText: '', isDense: true),
                          onSubmitted: (_) => _conectar(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(onPressed: _conectando ? null : _conectar, child: Text(_conectando ? 'Conectando…' : 'Conectar')),
                    ]),
                ]),
              )
            else
              Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: () => setState(() => _otroPreparador = true), icon: const Icon(Icons.add, size: 18), label: const Text('Conectar con otro preparador'))),
            if (materiales.isNotEmpty) ...[
              TituloSeccion(vinculos.length > 1 ? 'Materiales de tus preparadores' : 'Materiales de tu preparador'),
              for (final m in materiales) TarjetaMaterial(material: m, subtitulo: vinculos.length > 1 && m.preparadorNombre.isNotEmpty ? 'De ${m.preparadorNombre}' : null),
            ],
            if (firebase) ...[
              const TituloSeccion('¿Buscas preparador?'),
              FilaEnlace(
                icono: Icons.person_search_outlined,
                titulo: 'Buscar preparador',
                subtitulo: busqueda == null
                    ? 'Quién admite alumnos y, si cuentas lo que buscas, quién se interesa por ti'
                    : (interesados == 0 ? 'Tu búsqueda está publicada' : '$interesados ${interesados == 1 ? 'preparador interesado' : 'preparadores interesados'} en prepararte'),
                final_: interesados == 0 ? null : globo(context, interesados),
                onTap: () => ir(const BuscarPreparadorPage()),
              ),
            ],
            if (firebase && usuario != null) ...[
              const TituloSeccion('¿Te han cancelado una clase?'),
              FilaEnlace(
                icono: Icons.campaign_outlined,
                titulo: 'Pedir una clase suelta',
                subtitulo: 'Se la pides a los preparadores verificados de ${Oposiciones.actual.siglas} y uno te la coge',
                onTap: () => ir(const PedirSustitucionPage()),
              ),
              for (final s in misPeticiones) FilaMiPeticion(peticion: s),
              FilaEnlace(
                icono: Icons.badge_outlined,
                titulo: 'Preparadores verificados',
                subtitulo: 'Quiénes son, qué ejercicios preparan y su LinkedIn',
                onTap: () => ir(const DirectorioPage()),
              ),
            ],
            const TituloSeccion('Qué ve tu preparador'),
            Text('Los temas que marcas como estudiados o en repaso y tus cantes (fecha, tema, tiempo, valoración y comentarios). No ve tus tests, tus notas ni tus grabaciones, y puedes dejar de compartir cuando quieras. En la pizarra de una clase solo se comparte lo que dibujáis en ella, nada más de tu móvil. Nadie más ve nada: ni sus otros alumnos ni otros opositores.', style: context.textos.bodySmall),
            const SizedBox(height: 18),
            FilaEnlace(
              icono: Icons.groups_outlined,
              titulo: '¿Preparas a opositores?',
              subtitulo: 'Date de alta como preparador de ${Oposiciones.actual.siglas}',
              onTap: () => context.go('/mas/preparador'),
            ),
          ],
        ),
      ),
    );
  }
}
