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
import '../../data/repos/red_repo.dart';
import 'ajustes_preparador_page.dart';
import 'alta_page.dart';
import 'busquedas_page.dart';
import 'directorio_page.dart';
import 'materiales_page.dart';
import 'alumno_page.dart';
import 'red_widgets.dart';
import 'semana_page.dart';
import 'sesion_page.dart';
import 'sustituciones.dart';
import 'verificacion_page.dart';

/// Preparador: el lado de quien prepara a opositores en esta oposición. Si su
/// papel aún es el de opositor, presenta la sección y lleva al alta.
/// Por grupos: estado y código, tus clases, tus alumnos, clases sueltas, la
/// red de preparadores y los ajustes.
class PreparadorPage extends ConsumerStatefulWidget {
  const PreparadorPage({super.key});
  @override
  ConsumerState<PreparadorPage> createState() => _PreparadorPageState();
}

class _PreparadorPageState extends ConsumerState<PreparadorPage> {
  @override
  void initState() {
    super.initState();
    // Al entrar se comprueba si algún alumno ha enlazado desde la última vez.
    Future.microtask(() {
      if (mounted && ref.read(perfilPreparadorProvider).activo && ref.read(usuarioActualProvider) != null) ref.read(alumnosProvider.notifier).refrescar();
    });
  }

  Future<void> _nuevoAlumno() async {
    final a = await editarAlumno(context);
    if (a != null) await ref.read(alumnosProvider.notifier).guardar(a);
  }

  void _nuevaClase() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(alumnos: ref.read(misAlumnosProvider))));

  @override
  Widget build(BuildContext context) {
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final perfil = ref.watch(perfilPreparadorProvider);
    final siglas = Oposiciones.actual.siglas;
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    // Opositor en esta oposición: qué es ser preparador en la app y el alta.
    if (!perfil.activo) {
      return Scaffold(
        appBar: const BarraWeb(title: Text('Preparador')),
        body: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Text('¿Preparas a opositores de $siglas?', style: context.textos.headlineSmall),
            const SizedBox(height: 8),
            Text('Lleva a tus alumnos desde la app: tu semana de clases, la ficha de cada alumno con sus temas y sus cantes, sacar bola y cronometrar, valorar y enviarle el informe. Y coge clases sueltas de otros alumnos cuando su preparador no puede.', style: context.textos.bodyMedium),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: () => ir(const AltaPreparadorPage()), icon: const Icon(Icons.how_to_reg_outlined), label: const Text('Darme de alta como preparador')),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
              child: Text('En $siglas dejarás de ser opositor (en una misma oposición no se puede ser las dos cosas). Lo que llevas como opositor se queda guardado.', style: context.textos.labelSmall),
            ),
          ],
        ),
      );
    }

    final alumnos = ref.watch(misAlumnosProvider);
    final sesiones = ref.watch(sesionesProvider);
    final proximas = ref.watch(proximasSesionesProvider);
    final nombres = {for (final a in ref.watch(alumnosProvider)) a.id: a.nombre};
    final ahora = DateTime.now();
    final red = ref.watch(estadoRedProvider);
    final estado = red.value ?? const EstadoRed();
    final tablon = ref.watch(tablonProvider).valueOrNull ?? const <Sustitucion>[];
    final solicitudes = ref.watch(solicitudesPendientesProvider).valueOrNull ?? const <SolicitudPreparador>[];
    final reservasPedidas = (ref.watch(reservasRecibidasProvider).valueOrNull ?? const <Reserva>[]).where((r) => r.pedida && r.fecha.isAfter(ahora)).toList();
    final lunes = DateTime(ahora.year, ahora.month, ahora.day - (ahora.weekday - 1));
    final estaSemana = sesiones.where((s) => !s.cancelado && !s.fecha.isBefore(lunes) && s.fecha.isBefore(lunes.add(const Duration(days: 7)))).length;

    return Scaffold(
      appBar: const BarraWeb(title: Text('Preparador')),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(alumnosProvider.notifier).refrescar();
          refrescarRedDesdeWidget(ref);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            _tarjetaRed(context, perfil, red: red, estado: estado, firebase: firebase, conSesion: usuario != null),
            TituloSeccion('Tus clases', accion: TextButton.icon(onPressed: alumnos.isEmpty ? null : _nuevaClase, icon: const Icon(Icons.add, size: 18), label: const Text('Clase'))),
            FilaEnlace(
              icono: Icons.view_week_outlined,
              titulo: 'Mi semana',
              subtitulo: '$estaSemana ${estaSemana == 1 ? 'clase' : 'clases'} esta semana${reservasPedidas.isEmpty ? '' : ' · ${reservasPedidas.length} ${reservasPedidas.length == 1 ? 'reserva' : 'reservas'} por confirmar'}',
              final_: globo(context, reservasPedidas.length),
              onTap: () => ir(const SemanaPage()),
            ),
            if (proximas.isEmpty)
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(alumnos.isEmpty ? 'Añade primero a tus alumnos.' : 'No hay clases programadas.', style: context.textos.bodySmall))
            else
              for (final s in proximas.take(5))
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                    padding: EdgeInsets.zero,
                    onTap: () => ir(SesionPage(id: s.id)),
                    child: ListTile(
                      leading: PuntoPersona(s.alumno ?? '', tamano: 14),
                      title: Text('${fechaCorta(s.fecha)} · ${horaDe(s.fecha)} · ${nombres[s.alumno] ?? 'Alumno'}', style: context.textos.titleSmall),
                      subtitle: Text('${s.titulo.isEmpty ? '' : '${s.titulo} · '}${detalleCante(s)}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.labelSmall),
                      trailing: s.fecha.isAfter(ahora) ? Etiqueta(cuentaAtras(s.fecha, ahora)) : const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
            TituloSeccion('Tus alumnos', accion: TextButton.icon(onPressed: _nuevoAlumno, icon: const Icon(Icons.person_add_alt, size: 18), label: const Text('Alumno'))),
            if (alumnos.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  perfil.codigo != null
                      ? 'Todavía no tienes alumnos. Los que escriban tu código en su app aparecerán aquí solos; a los que no usen la app puedes añadirlos a mano.'
                      : 'Todavía no tienes alumnos. Añádelos a mano; cuando te verifiquen tendrás un código para que se conecten desde su app.',
                  style: context.textos.bodySmall,
                ),
              )
            else
              for (final a in alumnos) _filaAlumno(context, a, sesiones),
            if (estado.verificado) ...[
              const TituloSeccion('Alumnos nuevos'),
              FilaEnlace(
                icono: Icons.person_search_outlined,
                titulo: 'Opositores que buscan preparador',
                subtitulo: () {
                  final n = ref.watch(busquedasProvider).valueOrNull?.where((b) => !b.$3 && b.$2 > 0).length ?? 0;
                  return n == 0 ? 'Lo que buscan, sin su nombre; si te interesa, le dejas tu contacto' : '$n ${n == 1 ? 'opositor encaja' : 'opositores encajan'} con lo que preparas';
                }(),
                final_: globo(context, ref.watch(busquedasProvider).valueOrNull?.where((b) => !b.$3 && b.$2 > 0).length ?? 0),
                onTap: () => ir(const BusquedasPage()),
              ),
              const TituloSeccion('Materiales'),
              FilaEnlace(
                icono: Icons.folder_shared_outlined,
                titulo: 'Materiales para tus alumnos',
                subtitulo: (ref.watch(misMaterialesProvider).valueOrNull?.length ?? 0) == 0 ? 'Enlaces a Drive, PDF o vídeos, para todos o para algunos' : '${ref.watch(misMaterialesProvider).valueOrNull!.length} compartidos',
                onTap: () => ir(const MaterialesPage()),
              ),
              const TituloSeccion('Clases sueltas'),
              FilaEnlace(
                icono: Icons.campaign_outlined,
                titulo: 'Tablón de clases sueltas',
                subtitulo: tablon.isEmpty ? 'Clases que otros alumnos necesitan que les cojan' : '${tablon.length} ${tablon.length == 1 ? 'alumno busca' : 'alumnos buscan'} preparador',
                final_: globo(context, tablon.length),
                onTap: () => ir(const TablonPage()),
              ),
            ],
            if (firebase && usuario != null) ...[
              const TituloSeccion('La red de preparadores'),
              FilaEnlace(icono: Icons.badge_outlined, titulo: 'Preparadores verificados', subtitulo: 'Quiénes son, qué ejercicios preparan y su LinkedIn', onTap: () => ir(const DirectorioPage())),
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
            ],
            const TituloSeccion('Ajustes'),
            FilaEnlace(icono: Icons.tune, titulo: 'Ajustes de preparador', subtitulo: 'Nombre, teléfono, duración de las clases, Meet o Teams, avisos, Google Calendar y huecos para reservas', onTap: () => ir(const AjustesPreparadorPage())),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: Text('Tus alumnos, sus clases y tus notas privadas solo los ves tú, en todos tus dispositivos. Cada alumno ve únicamente sus propias clases y valoraciones, nunca las de los demás. Para volver a ser opositor en $siglas: Más → Ajustes → Tu papel.', style: context.textos.labelSmall),
            ),
          ],
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
        Text(solicitud == null ? 'Termina tu alta: pide la verificación' : 'Verificación pendiente', style: context.textos.titleMedium),
        const SizedBox(height: 4),
        Text(
          solicitud == null
              ? estado.retirada ? 'Te retiraron la verificación. Si quieres volver a tenerla, pídela otra vez: la revisa la administración. Mientras, puedes llevar a tus alumnos a mano.' : 'Para dar tu código a tus alumnos, aparecer en la lista de preparadores y coger clases sueltas, te tiene que verificar un preparador ya verificado. Así nadie puede hacerse pasar por preparador. Mientras, puedes llevar a tus alumnos a mano.'
              : 'Has pedido la verificación${solicitud.creada == null ? '' : ' el ${fechaCorta(solicitud.creada!)}'}${solicitud.reverificacion ? '. La revisará la administración' : solicitud.destinatario == null ? '. La revisará un preparador verificado' : ' a ${solicitud.destinatarioNombre.isEmpty ? 'un preparador' : solicitud.destinatarioNombre}'}; desliza hacia abajo para comprobarlo.',
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
            FilledButton.icon(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AltaPreparadorPage(soloVerificacion: true))), icon: const Icon(Icons.how_to_reg_outlined, size: 18), label: const Text('Pedir la verificación')),
          if (solicitud != null) ...[
            OutlinedButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AltaPreparadorPage(soloVerificacion: true))), child: const Text('Cambiar la solicitud')),
            TextButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await ref.read(redRepoProvider).retirarSolicitud().timeout(const Duration(seconds: 10));
                } catch (e) {
                  messenger.showSnackBar(SnackBar(content: Text('No se pudo retirar (${textoError(e)}).')));
                }
                ref.invalidate(estadoRedProvider);
              },
              child: const Text('Retirar la solicitud'),
            ),
          ],
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
              'Conecta tu app ${Creditos.nombreApp} conmigo: abre Más → Mi preparador y escribe el código $codigo. Así verás en tu agenda las clases que te programe y mis valoraciones en tu diario. También funciona en el navegador: ${Urls.appWeb}',
              asunto: 'Código de preparador',
            ),
          ),
        ]),
        Text('El alumno lo escribe en Más → Mi preparador.', style: context.textos.bodySmall),
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
            child: Text(a.nombre.isEmpty ? '?' : a.nombre.characters.first.toUpperCase(), style: TextStyle(fontFamily: Fuentes.serif, fontWeight: FontWeight.w700)),
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
  final email = TextEditingController(text: alumno?.email ?? '');
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
          const SizedBox(height: 10),
          TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Correo de Google (opcional)', helperText: 'Para invitarle a las clases en Google Calendar')),
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
              final correo = email.text.trim().toLowerCase();
              Navigator.pop(d, alumno == null ? Alumno(id: nuevoId(), nombre: n, ejercicio: ejercicio, telefono: telefono.text.trim(), email: correo, creado: DateTime.now(), updatedAt: DateTime.now()) : alumno.copyWith(nombre: n, ejercicio: ejercicio, telefono: telefono.text.trim(), email: correo));
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ),
  );
}
