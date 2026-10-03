import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/repos/preparador_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cante_form_page.dart';
import '../plan/cantes_util.dart';
import '../../core/red_providers.dart';
import '../../data/models/red.dart';
import 'ajustes_preparador_page.dart';
import 'directorio_page.dart';
import 'alumno_page.dart';
import 'red_widgets.dart';
import 'reservas.dart';
import 'semana_page.dart';
import 'sesion_page.dart';
import 'sustituciones.dart';
import 'verificacion_page.dart';

/// Preparadores, en sus dos lados: «Tengo preparador» (el opositor enlaza su
/// app con el código de su preparador) y «Soy preparador» (alumnos, sesiones
/// de cante y valoraciones).
class PreparadorPage extends ConsumerStatefulWidget {
  const PreparadorPage({super.key});
  @override
  ConsumerState<PreparadorPage> createState() => _PreparadorPageState();
}

class _PreparadorPageState extends ConsumerState<PreparadorPage> {
  final _codigo = TextEditingController();
  bool _enlazando = false;
  bool _otroPreparador = false;

  @override
  void initState() {
    super.initState();
    // Al entrar se comprueba si algún alumno ha enlazado desde la última vez.
    Future.microtask(() {
      if (mounted && ref.read(perfilPreparadorProvider).activo && ref.read(usuarioActualProvider) != null) ref.read(alumnosProvider.notifier).refrescar();
    });
  }

  @override
  void dispose() {
    _codigo.dispose();
    super.dispose();
  }

  Future<void> _enlazar() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _enlazando = true);
    final error = await ref.read(misPreparadoresProvider.notifier).enlazar(_codigo.text);
    if (!mounted) return;
    setState(() {
      _enlazando = false;
      if (error == null) {
        _codigo.clear();
        _otroPreparador = false;
      }
    });
    messenger.showSnackBar(SnackBar(content: Text(error ?? 'Enlazado. Tu preparador ya puede ver tu progreso.')));
  }

  Future<void> _desenlazar(VinculoPreparador v) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Dejar de compartir?'),
        content: Text('${v.nombre.isEmpty ? 'Tu preparador' : v.nombre} dejará de ver tus temas y tus cantes. Los cantes que ya te haya valorado se quedan en tu diario.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Dejar de compartir')),
        ],
      ),
    );
    if (ok == true) await ref.read(misPreparadoresProvider.notifier).desenlazar(v.uid);
  }

  Future<void> _nuevoAlumno() async {
    final a = await editarAlumno(context);
    if (a != null) await ref.read(alumnosProvider.notifier).guardar(a);
  }

  void _nuevaSesion() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: ref.read(alumnosProvider))));

  @override
  Widget build(BuildContext context) {
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final vinculos = ref.watch(misPreparadoresProvider);
    final perfil = ref.watch(perfilPreparadorProvider);
    final alumnos = ref.watch(alumnosProvider);
    final sesiones = ref.watch(sesionesProvider);
    final proximas = ref.watch(proximasSesionesProvider);
    final nombres = {for (final a in alumnos) a.id: a.nombre};
    final ahora = DateTime.now();
    final red = ref.watch(estadoRedProvider);
    final estado = red.value ?? const EstadoRed();
    final tablon = ref.watch(tablonProvider).value ?? const <Sustitucion>[];
    final solicitudes = ref.watch(solicitudesPendientesProvider).value ?? const <SolicitudPreparador>[];
    final reservasPedidas = (ref.watch(reservasRecibidasProvider).value ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(ahora)).toList();
    final misPeticiones = (ref.watch(misPeticionesProvider).value ?? const <Sustitucion>[]).where((s) => s.vigente(ahora) && s.estado != EstadoSustitucion.cancelada).toList();
    final lunes = DateTime(ahora.year, ahora.month, ahora.day - (ahora.weekday - 1));
    final estaSemana = sesiones.where((s) => !s.cancelado && !s.fecha.isBefore(lunes) && s.fecha.isBefore(lunes.add(const Duration(days: 7)))).length;
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    // ---------------------------------------------------- Lado del opositor
    final ladoOpositor = <Widget>[
            const TituloSeccion('Tengo preparador'),
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
                          Text('Enlazado${v.desde == null ? '' : ' desde el ${fechaCorta(v.desde!)}'}. Ve tus temas y tus cantes. En tu agenda, sus cantes llevan este color.', style: context.textos.bodySmall),
                        ]),
                      ),
                      TextButton(onPressed: () => _desenlazar(v), child: const Text('Quitar')),
                    ]),
                    if (ref.watch(huecosDeProvider(v.uid)).value?.activo ?? false)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton.icon(onPressed: () => ir(ReservarPage(preparador: v)), icon: const Icon(Icons.event_available_outlined, size: 18), label: const Text('Reservar clase')),
                      ),
                  ]),
                ),
              ),
            if (vinculos.isEmpty || _otroPreparador)
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Enlaza tu app con la de tu preparador', style: context.textos.titleMedium),
                  const SizedBox(height: 4),
                  Text('Pídele su código de seis caracteres. Los cantes que te programe aparecerán en tu agenda y sus valoraciones, en tu diario.', style: context.textos.bodySmall),
                  const SizedBox(height: 12),
                  if (!firebase)
                    Text('Esta compilación no incluye credenciales de Firebase: el enlace no está disponible.', style: context.textos.labelSmall)
                  else if (usuario == null)
                    OutlinedButton.icon(onPressed: () => context.go('/mas/cuenta'), icon: const Icon(Icons.login, size: 18), label: const Text('Inicia sesión con Google para enlazar'))
                  else
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _codigo,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 7,
                          style: const TextStyle(fontFamily: Fuentes.sans, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 4),
                          decoration: const InputDecoration(hintText: 'CÓDIGO', counterText: '', isDense: true),
                          onSubmitted: (_) => _enlazar(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(onPressed: _enlazando ? null : _enlazar, child: Text(_enlazando ? 'Enlazando…' : 'Enlazar')),
                    ]),
                ]),
              )
            else
              Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: () => setState(() => _otroPreparador = true), icon: const Icon(Icons.add, size: 18), label: const Text('Enlazar con otro preparador'))),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Text('Tu preparador ve los temas que marcas como estudiados o en repaso y tus cantes (fecha, tema, tiempo, valoración y comentarios). No ve tus tests, tus notas ni tus grabaciones, y puedes dejar de compartir cuando quieras. Nadie más ve nada: ni sus otros alumnos ni otros opositores.', style: context.textos.labelSmall),
            ),
            if (firebase && usuario != null) ...[
              const TituloSeccion('Sustituciones'),
              FilaEnlace(
                icono: Icons.badge_outlined,
                titulo: 'Preparadores verificados',
                subtitulo: 'Quiénes son, qué ejercicios preparan y su LinkedIn',
                onTap: () => ir(const DirectorioPage()),
              ),
              FilaEnlace(
                icono: Icons.campaign_outlined,
                titulo: 'Buscar quién me coja un cante',
                subtitulo: 'Si tu preparador cancela o no puede: pídeselo a otros preparadores verificados',
                onTap: () => ir(const PedirSustitucionPage()),
              ),
              for (final s in misPeticiones) FilaMiPeticion(peticion: s),
            ],
    ];

    // -------------------------------------------------- Lado del preparador
    final ladoPreparador = <Widget>[
            const TituloSeccion('Soy preparador'),
            if (!perfil.activo)
              Tarjeta(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Lleva a tus alumnos desde la app', style: context.textos.titleMedium),
                  const SizedBox(height: 4),
                  Text('Programa las sesiones de cante, sortea entre los temas que lleva cada alumno, cronometra, valora y consulta su ficha: qué ha cantado, cómo y qué temas flojean.', style: context.textos.bodySmall),
                  const SizedBox(height: 12),
                  FilledButton.icon(onPressed: () => ref.read(perfilPreparadorProvider.notifier).activar(), icon: const Icon(Icons.groups_outlined), label: const Text('Activar la sección de preparador')),
                ]),
              )
            else ...[
              _tarjetaRed(context, perfil, red: red, estado: estado, firebase: firebase, conSesion: usuario != null),
              const SizedBox(height: 10),
              FilaEnlace(
                icono: Icons.view_week_outlined,
                titulo: 'Mi semana',
                subtitulo: '$estaSemana ${estaSemana == 1 ? 'sesión' : 'sesiones'} esta semana${reservasPedidas.isEmpty ? '' : ' · ${reservasPedidas.length} ${reservasPedidas.length == 1 ? 'reserva' : 'reservas'} por confirmar'}',
                final_: globo(context, reservasPedidas.length),
                onTap: () => ir(const SemanaPage()),
              ),
              if (estado.verificado)
                FilaEnlace(
                  icono: Icons.campaign_outlined,
                  titulo: 'Sustituciones',
                  subtitulo: tablon.isEmpty ? 'Cantes que otros alumnos necesitan que les cojan' : '${tablon.length} ${tablon.length == 1 ? 'alumno busca' : 'alumnos buscan'} preparador',
                  final_: globo(context, tablon.length),
                  onTap: () => ir(const TablonPage()),
                ),
              if (estado.verificado || estado.esAdmin)
                FilaEnlace(
                  icono: Icons.how_to_reg_outlined,
                  titulo: 'Verificar preparadores',
                  subtitulo: solicitudes.isEmpty ? 'Avala a quien conozcas' : '${solicitudes.length} por revisar',
                  final_: globo(context, solicitudes.length),
                  onTap: () => ir(const VerificarPreparadoresPage()),
                ),
              if (estado.esAdmin)
                FilaEnlace(icono: Icons.admin_panel_settings_outlined, titulo: 'Gestionar la red', subtitulo: 'Quién está verificado y quién lo avaló', onTap: () => ir(const AdminRedPage())),
              FilaEnlace(icono: Icons.tune, titulo: 'Ajustes de preparador', subtitulo: 'Teléfono, avisos y huecos para reservas', onTap: () => ir(const AjustesPreparadorPage())),
              TituloSeccion('Próximas sesiones', accion: TextButton.icon(onPressed: alumnos.isEmpty ? null : _nuevaSesion, icon: const Icon(Icons.add, size: 18), label: const Text('Sesión'))),
              if (proximas.isEmpty)
                Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(alumnos.isEmpty ? 'Añade primero a tus alumnos.' : 'No hay sesiones programadas.', style: context.textos.bodySmall))
              else
                for (final s in proximas.take(8))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Tarjeta(
                      padding: EdgeInsets.zero,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: s.id))),
                      child: ListTile(
                        leading: PuntoPersona(s.alumno ?? '', tamano: 14),
                        title: Text('${fechaCorta(s.fecha)} · ${horaDe(s.fecha)} · ${nombres[s.alumno] ?? 'Alumno'}', style: context.textos.titleSmall),
                        subtitle: Text('${s.titulo.isEmpty ? '' : '${s.titulo} · '}${detalleCante(s)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
                        trailing: s.fecha.isAfter(ahora) ? Etiqueta(cuentaAtras(s.fecha, ahora)) : const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
              TituloSeccion('Mis alumnos', accion: TextButton.icon(onPressed: _nuevoAlumno, icon: const Icon(Icons.person_add_alt, size: 18), label: const Text('Alumno'))),
              if (alumnos.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text('Todavía no tienes alumnos. Los que enlacen su app con tu código aparecerán aquí solos; a los que no usen la app puedes añadirlos a mano.', style: context.textos.bodySmall),
                )
              else
                for (final a in alumnos) _filaAlumno(context, a, sesiones),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                child: Text('Tus alumnos, sesiones y notas privadas solo los ves tú, en todos tus dispositivos. Cada alumno ve únicamente sus propias sesiones y valoraciones, nunca las de los demás.', style: context.textos.labelSmall),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => ref.read(perfilPreparadorProvider.notifier).desactivar(),
                  child: const Text('Ocultar la sección de preparador'),
                ),
              ),
            ],
    ];

    return Scaffold(
      appBar: BarraWeb(title: const Text('Preparadores')),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(alumnosProvider.notifier).refrescar();
          refrescarRedDesdeWidget(ref);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          // Quien ya lleva alumnos ve primero su lado.
          children: perfil.activo ? [...ladoPreparador, ...ladoOpositor] : [...ladoOpositor, ...ladoPreparador],
        ),
      ),
    );
  }

  /// Verificación como preparador: sin ella no hay código para alumnos ni
  /// acceso a las sustituciones (para que nadie se haga pasar por preparador).
  Widget _tarjetaRed(BuildContext context, PerfilPreparador perfil, {required AsyncValue<EstadoRed> red, required EstadoRed estado, required bool firebase, required bool conSesion}) {
    if (!firebase || !conSesion) return _tarjetaCodigo(context, perfil, firebase: firebase, conSesion: conSesion);
    if (red.isLoading && !red.hasValue) return const Tarjeta(child: Center(child: CircularProgressIndicator()));
    if (estado.verificado) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _tarjetaCodigo(context, perfil, firebase: firebase, conSesion: conSesion),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
          child: Row(children: [
            const Icon(Icons.verified, size: 16, color: Paleta.acierto),
            const SizedBox(width: 6),
            Expanded(child: Text(estado.verificacion!.avaladoPor == estado.verificacion!.uid ? 'Preparador verificado' : 'Verificado por ${estado.verificacion!.avaladoPorNombre}', style: context.textos.labelSmall)),
          ]),
        ),
      ]);
    }
    final solicitud = estado.solicitud;
    return Tarjeta(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(solicitud == null ? 'Verifícate como preparador' : 'Verificación pendiente', style: context.textos.titleMedium),
        const SizedBox(height: 4),
        Text(
          solicitud == null
              ? 'Para dar tu código a alumnos, aparecer en la lista de preparadores y coger sustituciones, te tiene que verificar un preparador ya verificado. Así nadie puede hacerse pasar por preparador. Mientras, puedes llevar a tus alumnos en este dispositivo.'
              : 'Has pedido la verificación${solicitud.creada == null ? '' : ' el ${fechaCorta(solicitud.creada!)}'}${solicitud.destinatario == null ? '. La revisará un preparador verificado' : ' a ${solicitud.destinatarioNombre.isEmpty ? 'un preparador' : solicitud.destinatarioNombre}'}; desliza hacia abajo para comprobarlo.',
          style: context.textos.bodySmall,
        ),
        const SizedBox(height: 10),
        Wrap(spacing: 10, runSpacing: 8, children: [
          if (estado.esAdmin)
            FilledButton.icon(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final nombre = perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? '');
                try {
                  await ref.read(redRepoProvider).verificarme(nombre: nombre);
                  refrescarRedDesdeWidget(ref);
                  await ref.read(perfilPreparadorProvider.notifier).reintentarCodigo();
                  messenger.showSnackBar(const SnackBar(content: Text('Verificado. Ya tienes tu código para alumnos.')));
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text('No se pudo: $e')));
                }
              },
              icon: const Icon(Icons.verified_outlined, size: 18),
              label: const Text('Verificarme'),
            )
          else if (solicitud == null)
            FilledButton.icon(onPressed: () => solicitarVerificacion(context, ref), icon: const Icon(Icons.how_to_reg_outlined, size: 18), label: const Text('Pedir la verificación')),
          if (solicitud != null)
            TextButton(
              onPressed: () async {
                await ref.read(redRepoProvider).retirarSolicitud();
                ref.invalidate(estadoRedProvider);
              },
              child: const Text('Retirar la solicitud'),
            ),
          if (estado.esAdmin) OutlinedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminRedPage())), child: const Text('Gestionar la red')),
        ]),
      ]),
    );
  }

  Widget _tarjetaCodigo(BuildContext context, PerfilPreparador perfil, {required bool firebase, required bool conSesion}) {
    final codigo = perfil.codigo;
    if (codigo == null) {
      return Tarjeta(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Sin código para alumnos', style: context.textos.titleMedium),
          const SizedBox(height: 4),
          Text(
            !firebase
                ? 'Esta compilación no incluye credenciales de Firebase: la sección funciona solo en este dispositivo.'
                : (conSesion
                    ? switch (ref.read(preparadorRepoProvider).errorCodigo) {
                        ErrorCodigo.permiso => 'El servidor ha rechazado la reserva del código (permiso denegado). Es un problema de configuración de la base de datos, no de tu cuenta: avisa en contacto@victorgutierrezmarcos.es. Mientras, puedes llevar a tus alumnos en este dispositivo.',
                        ErrorCodigo.red => 'No hay conexión con el servidor. Comprueba la red y vuelve a intentarlo.',
                        _ => 'No se ha podido reservar tu código. Vuelve a intentarlo.',
                      }
                    : 'Puedes llevar a tus alumnos solo en este móvil. Para que enlacen su app contigo y reciban tus valoraciones, inicia sesión con Google.'),
            style: context.textos.bodySmall,
          ),
          if (firebase && conSesion)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: OutlinedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  await ref.read(perfilPreparadorProvider.notifier).reintentarCodigo();
                  if (ref.read(perfilPreparadorProvider).codigo != null) messenger.showSnackBar(const SnackBar(content: Text('Código reservado')));
                  setState(() {});
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reintentar'),
              ),
            ),
          if (firebase && !conSesion) Padding(padding: const EdgeInsets.only(top: 10), child: OutlinedButton.icon(onPressed: () => context.go('/mas/cuenta'), icon: const Icon(Icons.login, size: 18), label: const Text('Iniciar sesión'))),
        ]),
      );
    }
    return Tarjeta(
      color: context.colores.primarioPalido,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Tu código para alumnos', style: context.textos.labelMedium),
        Row(children: [
          Expanded(child: SelectableText(codigo, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 6, color: context.esquema.primary))),
          IconButton(
            tooltip: 'Copiar',
            icon: const Icon(Icons.copy),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              await Clipboard.setData(ClipboardData(text: codigo));
              messenger.showSnackBar(const SnackBar(content: Text('Código copiado')));
            },
          ),
          IconButton(
            tooltip: 'Enviar a un alumno',
            icon: const Icon(Icons.ios_share),
            onPressed: () => compartirTexto(
              context,
              'Enlaza tu app ${Creditos.nombreApp} conmigo: abre Más → Preparadores → «Tengo preparador» y escribe el código $codigo. Así verás en tu agenda los cantes que te programe y mis valoraciones en tu diario. También funciona en el navegador: ${Urls.appWeb}',
              asunto: 'Código de preparador',
            ),
          ),
        ]),
        Text('El alumno lo escribe en Más → Preparadores → «Tengo preparador».', style: context.textos.bodySmall),
      ]),
    );
  }

  Widget _filaAlumno(BuildContext context, Alumno a, List<Cante> sesiones) {
    final suyas = sesiones.where((s) => s.alumno == a.id).toList();
    final hechas = suyas.where((s) => s.hecho).toList();
    final valoradas = hechas.where((s) => (s.resultado?.valoracion ?? 0) > 0).toList();
    final media = valoradas.isEmpty ? 0.0 : valoradas.fold<int>(0, (t, s) => t + s.resultado!.valoracion) / valoradas.length;
    final siguiente = suyas.where((s) => s.pendiente && s.fecha.isAfter(DateTime.now())).firstOrNull;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: EdgeInsets.zero,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AlumnoPage(id: a.id))),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(colorDePersona(a.id)).withValues(alpha: 0.18),
            foregroundColor: Color(colorDePersona(a.id)),
            child: Text(a.nombre.isEmpty ? '?' : a.nombre.characters.first.toUpperCase(), style: const TextStyle(fontFamily: Fuentes.serif, fontWeight: FontWeight.w700)),
          ),
          title: Row(children: [
            Flexible(child: Text(a.nombre, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall)),
            if (a.enlazado) Padding(padding: const EdgeInsets.only(left: 6), child: Icon(Icons.link, size: 16, color: context.esquema.primary)),
          ]),
          subtitle: Text(
            [
              '${a.temas.length} temas',
              '${hechas.length} ${hechas.length == 1 ? 'cante' : 'cantes'}',
              if (siguiente != null) 'próxima: ${fechaCorta(siguiente.fecha)}',
            ].join(' · '),
            style: context.textos.labelSmall,
          ),
          trailing: media > 0 ? Estrellas(valor: media.round(), tamano: 14) : const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

/// Diálogo para dar de alta o editar a un alumno. Devuelve null si se cancela.
Future<Alumno?> editarAlumno(BuildContext context, {Alumno? alumno}) {
  final nombre = TextEditingController(text: alumno?.nombre ?? '');
  final telefono = TextEditingController(text: alumno?.telefono ?? '');
  var ejercicio = alumno?.ejercicio ?? Oposiciones.actual.primerConTemas;
  return showDialog<Alumno>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, setState) => AlertDialog(
        title: Text(alumno == null ? 'Nuevo alumno' : 'Editar alumno'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(controller: nombre, autofocus: alumno == null, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nombre')),
          const SizedBox(height: 10),
          TextField(controller: telefono, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Teléfono (opcional)', helperText: 'Para escribirle por WhatsApp desde la app')),
          const SizedBox(height: 16),
          Text('Ejercicio que prepara', style: Theme.of(d).textTheme.labelMedium),
          const SizedBox(height: 6),
          SegmentedButton<int>(
            showSelectedIcon: false,
            segments: segmentosEjercicio(ambos: true),
            selected: {ejercicio},
            onSelectionChanged: (s) => setState(() => ejercicio = s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              final n = nombre.text.trim();
              if (n.isEmpty) return;
              Navigator.pop(d, alumno == null ? Alumno(id: nuevoId(), nombre: n, ejercicio: ejercicio, telefono: telefono.text.trim(), creado: DateTime.now(), updatedAt: DateTime.now()) : alumno.copyWith(nombre: n, ejercicio: ejercicio, telefono: telefono.text.trim()));
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ),
  );
}
