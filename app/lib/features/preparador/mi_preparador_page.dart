import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/avisos_breves.dart';
import '../../core/invitacion.dart';
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
import 'coordinacion.dart';
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

  /// Invitación de un preparador (enlace o referrer de Play) pendiente de
  /// conectar: el código viene puesto y solo hay que tocar «Conectar».
  Invitacion? _invitacion;
  String? _nombreInvita;

  @override
  void initState() {
    super.initState();
    _invitacion = ref.read(invitacionPendienteProvider);
    _aplicarInvitacion();
    ref.listenManual(invitacionPendienteProvider, (_, inv) {
      _invitacion = inv;
      _aplicarInvitacion();
      if (mounted) setState(() {});
    });
    // Con sesión se puede leer el nombre del preparador del código.
    ref.listenManual(usuarioActualProvider, (_, u) {
      if (u != null) _aplicarInvitacion();
    });
  }

  void _aplicarInvitacion() {
    final inv = _invitacion;
    if (inv == null) return;
    _codigo.text = inv.codigo;
    _otroPreparador = true;
    ref.read(preparadorRepoProvider).nombrePorCodigo(inv.codigo).then((n) {
      if (mounted && n != null && n != _nombreInvita) setState(() => _nombreInvita = n);
    });
  }

  Future<void> _descartarInvitacion() async {
    await Invitacion.borrar();
    if (!mounted) return;
    setState(() {
      _invitacion = null;
      _nombreInvita = null;
      _codigo.clear();
      _otroPreparador = false;
    });
    ref.invalidate(invitacionPendienteProvider);
  }

  @override
  void dispose() {
    _codigo.dispose();
    super.dispose();
  }

  Future<void> _conectar() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _conectando = true);
    final error = await ref.read(vinculosPreparadorProvider.notifier).enlazar(_codigo.text);
    if (!mounted) return;
    if (error == null && _invitacion != null) {
      // Conectado: la invitación deja de estar pendiente.
      await Invitacion.borrar();
      if (!mounted) return;
      _invitacion = null;
      _nombreInvita = null;
      ref.invalidate(invitacionPendienteProvider);
    }
    setState(() {
      _conectando = false;
      if (error == null) {
        _codigo.clear();
        _otroPreparador = false;
      }
    });
    messenger.mostrar(SnackBar(content: Text(error ?? 'Petición enviada. Cuando tu preparador la acepte, verá tu progreso y te llegará un aviso.')));
  }

  /// La oposición de la invitación si no es la elegida (y está disponible).
  Oposicion? get _invitacionDeOtraOposicion {
    final op = _invitacion?.oposicion;
    if (op == null || op == ref.read(oposicionProvider).id) return null;
    return Oposiciones.disponibles.where((o) => o.id == op).firstOrNull;
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
          title: Text(v.aceptado ? '¿Dejar de compartir?' : '¿Retirar la petición?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(v.aceptado
                ? '${v.nombre.isEmpty ? 'Tu preparador' : v.nombre} dejará de ver tus temas y tus cantes. Los cantes que ya te haya valorado se quedan en tu diario.'
                : '${v.nombre.isEmpty ? 'Tu preparador' : v.nombre} aún no ha aceptado la conexión y no ve nada tuyo. La petición se borra.'),
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
            FilledButton(onPressed: () => Navigator.pop(d, true), child: Text(v.aceptado ? 'Dejar de compartir' : 'Retirar')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    if (cancelar && pendientes.isNotEmpty) await _cancelarPendientes(pendientes, 'Has dejado de compartir con tu preparador');
    await ref.read(vinculosPreparadorProvider.notifier).desenlazar(v.uid);
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
      messenger.mostrar(SnackBar(content: Text('$nombre ya no tiene acceso a tus clases.')));
    } catch (e) {
      messenger.mostrar(SnackBar(content: Text('No se pudo (${textoError(e)}).')));
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
    final vinculos = ref.watch(vinculosPreparadorProvider);
    final ahora = DateTime.now();
    final misPeticiones = (ref.watch(misPeticionesProvider).valueOrNull ?? const <Sustitucion>[]).where((s) => s.vigente(ahora) && s.estado != EstadoSustitucion.cancelada).toList();
    final materiales = ref.watch(materialesParaMiProvider).valueOrNull ?? const <MaterialCompartido>[];
    final busqueda = ref.watch(miBusquedaProvider).valueOrNull;
    final interesados = busqueda == null ? 0 : (ref.watch(interesadosProvider(busqueda.id)).valueOrNull?.length ?? 0);
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));
    final aceptados = vinculos.where((v) => v.aceptado).toList();
    // Mensajes de los preparadores en el tablón en los dos últimos días.
    final tablon = usuario == null
        ? 0
        : (ref.watch(tablonComunProvider(usuario.uid)).valueOrNull ?? const <NotaEntrePreparadores>[])
            .where((n) => n.de != usuario.uid && n.fecha.isAfter(ahora.subtract(const Duration(days: 2))))
            .length;

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
                          Text(
                            v.aceptado
                                ? 'Conectado${v.desde == null ? '' : ' desde el ${fechaCorta(v.desde!)}'}. Ve tus temas y tus cantes. En tu agenda, sus clases llevan este color.'
                                : 'Pendiente de que acepte la conexión. Hasta entonces no ve nada tuyo; cuando la acepte te llegará un aviso.',
                            style: context.textos.bodySmall,
                          ),
                        ]),
                      ),
                      TextButton(onPressed: () => _desconectar(v), child: Text(v.aceptado ? 'Quitar' : 'Retirar')),
                    ]),
                    if (!v.aceptado)
                      const Padding(padding: EdgeInsets.only(top: 6), child: Etiqueta('Pendiente de aceptar'))
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton.icon(
                          onPressed: () => ir(ReservarPage(preparador: v)),
                          icon: const Icon(Icons.event_available_outlined, size: 18),
                          label: Text(ref.watch(huecosDeProvider(v.uid)).value?.activo ?? false ? 'Reservar clase' : 'Pedir una clase'),
                        ),
                      ),
                  ]),
                ),
              ),
            ..._sustitutos(context, vinculos),
            if (vinculos.isEmpty || _otroPreparador)
              Tarjeta(
                color: _invitacion == null ? null : context.colores.primarioPalido,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    _invitacion == null ? 'Conecta con tu preparador' : '${_nombreInvita ?? 'Tu preparador'} te invita a conectar',
                    style: context.textos.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _invitacion == null
                        ? 'Pídele su código de seis caracteres. Cuando acepte la conexión, las clases que te programe aparecerán en tu agenda y sus valoraciones, en tu diario.'
                        : 'Su código ya está puesto: toca «Conectar» y le llegará tu petición. Cuando la acepte verá tus temas estudiados y tus cantes, las clases que te programe aparecerán en tu agenda y sus valoraciones, en tu diario. Nadie más ve nada tuyo.',
                    style: context.textos.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  if (_invitacionDeOtraOposicion case final otra?)
                    // El código es de otra oposición: hay que cambiar a ella.
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('La invitación es de ${otra.siglas} y aquí tienes elegida ${ref.watch(oposicionProvider).siglas}. Cambia de oposición para conectar (tus datos de cada una se guardan aparte).', style: context.textos.bodySmall),
                      const SizedBox(height: 8),
                      FilledButton.icon(
                        onPressed: () => ref.read(cambiarOposicionProvider)(otra),
                        icon: const Icon(Icons.swap_horiz, size: 18),
                        label: Text('Cambiar a ${otra.siglas}'),
                      ),
                    ])
                  else if (!firebase)
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
                  if (_invitacion != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: _descartarInvitacion, child: const Text('Descartar la invitación')),
                    ),
                ]),
              )
            else
              Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: () => setState(() => _otroPreparador = true), icon: const Icon(Icons.add, size: 18), label: const Text('Conectar con otro preparador'))),
            // Coordinarse con los preparadores: tablón común, reparto y qué ven.
            if (usuario != null && aceptados.isNotEmpty) ...[
              TituloSeccion(aceptados.length > 1 ? 'Coordinación con tus preparadores' : 'Con tu preparador'),
              FilaEnlace(
                icono: Icons.forum_outlined,
                titulo: aceptados.length > 1 ? 'Tablón con tus preparadores' : 'Tablón con tu preparador',
                subtitulo: aceptados.length > 1 ? 'Para acordar entre todos cambios de clase, quién lleva qué o dudas' : 'Para acordar cambios de clase o dudas',
                final_: tablon == 0 ? null : globo(context, tablon),
                onTap: () => ir(TablonComunPage(alumnoUid: usuario.uid, nombreAlumno: usuario.displayName ?? '', soyAlumno: true)),
              ),
              FilaEnlace(
                icono: Icons.visibility_outlined,
                titulo: 'Qué ven tus preparadores',
                subtitulo: aceptados.length > 1 ? 'Tus cantes por tu cuenta y si cada uno sabe que tienes otros' : 'Tus cantes por tu cuenta',
                onTap: () => ir(const QueVenMisPreparadoresPage()),
              ),
              if (aceptados.length > 1) SeccionReparto(alumnoUid: usuario.uid, preparadores: [for (final v in aceptados) (v.uid, v.nombre.isEmpty ? 'Preparador' : v.nombre)]),
            ],
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
            Text('Los temas que marcas como estudiados o en repaso y tus cantes (fecha, tema, tiempo, valoración y comentarios). No ve tus tests, tus notas ni tus grabaciones, y puedes dejar de compartir cuando quieras. En la pizarra de una clase solo se comparte lo que dibujáis en ella, nada más de tu móvil. Nadie más ve nada: ni sus otros alumnos ni otros opositores. Si tienes varios preparadores, cada uno ve qué tema cantaste, cuándo y con quién, y las próximas clases con los demás (para no pisarse), pero no la valoración ni los comentarios de los otros; saben quiénes son los demás, ven los temas que te mandan los otros (para no repetírtelos), pueden dejarse notas sobre tu preparación y, si quieren, compartirse el WhatsApp. Puedes cambiarlo en «Qué ven tus preparadores», también ocultar a alguno que tienes otros, y elegir allí de qué actividad tuya recibe avisos (temas de una clase, cantes por tu cuenta, temas estudiados, una semana sin usar la app o la cercanía del examen): nada de eso le llega hasta que lo actives. Si te mandan un cronograma, decides tú si lo usas.', style: context.textos.bodySmall),
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
