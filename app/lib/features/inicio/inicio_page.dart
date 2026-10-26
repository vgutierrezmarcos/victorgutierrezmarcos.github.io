import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/models/plan.dart';
import '../../core/cronograma_providers.dart';
import '../../data/models/temas_clase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/actualizaciones.dart';
import '../../core/instalacion.dart';
import '../../core/resenas.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import 'para_empezar.dart';
import 'permisos_sheet.dart';
import '../cronograma/cronograma_page.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/probabilidades.dart';
import '../plan/proceso_page.dart';
import '../plan/cante_page.dart';
import '../plan/cantes_util.dart';
import '../preparador/panel_hoy.dart';
import '../test/motor_test.dart';

/// Hoy: lo que toca cada día. Al opositor, cuentas atrás (examen y próximo
/// cante), test diario, cronograma, repaso pendiente y probabilidad de
/// aprobar. Al preparador, primero su panel (clases de hoy y lo que espera
/// respuesta) y después el test diario y el repaso.
class InicioPage extends ConsumerWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider).valueOrNull;
    final usuario = ref.watch(usuarioActualProvider);
    final diarioHecho = ref.watch(testDiarioHechoProvider);
    final banco = ref.watch(preguntasProvider);
    final leitner = ref.watch(leitnerProvider);
    // Próxima fecha de examen: el primer ejercicio que aún no ha pasado.
    final fechas = ref.watch(fechasEjerciciosProvider).entries.where((e) => diasHasta(e.value) >= 0).toList()..sort((a, b) => a.value.compareTo(b.value));
    final proximo = fechas.firstOrNull;
    final fecha = proximo?.value;
    final dias = fecha == null ? null : diasHasta(fecha);
    final cante = ref.watch(proximosCantesProvider).firstOrNull;
    final prob = ref.watch(probabilidadAprobarProvider);
    final versionNueva = ref.watch(actualizacionProvider).valueOrNull;
    final origen = ref.watch(origenInstalacionProvider).valueOrNull ?? (kIsWeb ? OrigenInstalacion.web : OrigenInstalacion.otro);
    final canceladas = ref.watch(canceladasProximasProvider);
    // Clases con preparador de los próximos 14 días sin temas (ni elegidos ni
    // de una semana del cronograma) o con una propuesta del preparador sin
    // responder: el opositor tiene que decir qué lleva.
    final ajustesTemas = ref.watch(ajustesProvider);
    final cronogramaTemas = ref.watch(cronogramaProvider);
    final ahoraTemas = DateTime.now();
    final clasesPorTemas = [
      for (final c in ref.watch(cantesProvider))
        if (c.dePreparador && c.pendiente && !c.cancelado && c.bolsa == TipoBolsa.estudiados && !Oposiciones.actual.esDictamen(c.ejercicio) &&
            c.fecha.isAfter(ahoraTemas) && c.fecha.isBefore(ahoraTemas.add(const Duration(days: 14))) &&
            (temasDeLaClase(c, elegidos: ajustesTemas.temasClases, cronograma: cronogramaTemas, noCantar: ajustesTemas.noCantar).pendiente ||
                propuestaPendiente(c, ajustesTemas.temasClases)))
          c,
    ];
    // Con la app instalada desde Google Play, la actualización se ofrece dentro de la app.
    ref.listen(actualizacionProvider, (_, v) {
      if (v.valueOrNull != null) comprobarActualizacionDePlay(context);
    });
    // El preparador ve primero lo suyo; las cuentas atrás, los cantes y el
    // cronograma son del opositor.
    final opositor = ref.watch(papelProvider) == Papel.opositor;

    return Scaffold(
      appBar: BarraWeb(
        conOposicion: true,
        title: Text('Oposición ${Oposiciones.actual.siglas}'),
        subtitulo: usuario == null ? Oposiciones.actual.nombre : 'Hola, ${usuario.displayName?.split(' ').first ?? ''}',
        actions: [
          IconButton(
            tooltip: 'Cuenta',
            icon: usuario != null ? const AvatarUsuario(radio: 14) : const Icon(Icons.account_circle_outlined),
            onPressed: () => context.go('/mas/cuenta'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(configProvider);
          ref.invalidate(historialProvider);
          ref.invalidate(temarioProvider);
          // Con sesión, trae también lo nuevo de la nube (p. ej. un cante que ha puesto el preparador).
          if (usuario != null) await ref.read(sesionProvider.notifier).sincronizar();
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            // Sin temario (sin red la primera vez, o una oposición cuya web aún no
            // publica el contenido): se dice, en lugar de dejar la pantalla vacía.
            if (ref.watch(temarioProvider).hasError && ref.watch(temarioProvider).valueOrNull == null)
              Aviso(
                icono: Icons.cloud_off_outlined,
                titulo: Oposiciones.actual.lanzada ? 'No se ha podido descargar el temario' : 'Contenido aún sin publicar',
                texto: Oposiciones.actual.lanzada
                    ? 'Comprueba la conexión y vuelve a intentarlo.'
                    : 'La oposición ${Oposiciones.actual.siglas} está sin lanzar. Puedes volver a TCEE en Más → Ajustes → Oposición.',
                accion: TextButton(onPressed: () => ref.invalidate(temarioProvider), child: const Text('Reintentar')),
              ),
            const TarjetaAvisosDesactivados(),
            if (opositor)
              for (final c in canceladas)
                Aviso(
                  tipo: TipoAviso.error,
                  icono: Icons.event_busy,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: c.id))),
                  titulo: '${(c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre} ha cancelado la clase del ${fechaCorta(c.fecha)}',
                  texto: '${horaDe(c.fecha)}${c.motivo.isEmpty ? '' : ' · ${c.motivo}'}. Toca para verla o pedírsela a ${ref.watch(misPreparadoresProvider).length > 1 ? 'tu otro preparador' : 'otro preparador'}.',
                ),
            if (opositor)
              for (final c in clasesPorTemas)
                Aviso(
                  tipo: TipoAviso.aviso,
                  icono: Icons.playlist_add,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: c.id))),
                  titulo: propuestaPendiente(c, ajustesTemas.temasClases)
                      ? '${(c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre} te propone temas para la clase del ${fechaCorta(c.fecha)}'
                      : 'Indica qué temas llevas a la clase del ${fechaCorta(c.fecha)}',
                  texto: propuestaPendiente(c, ajustesTemas.temasClases)
                      ? 'Toca para aceptarlos o elegir otros.'
                      : 'No hay ninguna semana de tu cronograma para ese día. Toca para elegirlos; tu preparador verá los mismos.',
                ),
            if (versionNueva != null)
              Builder(builder: (context) {
                final t = textosVersionNueva(versionNueva, origen, hayPlay: config?.urlPlayStore != null);
                return Aviso(
                  icono: origen == OrigenInstalacion.apk && config?.urlPlayStore != null ? Icons.shop_outlined : Icons.system_update_outlined,
                  titulo: t.titulo,
                  texto: t.texto,
                  accion: TextButton(onPressed: () => actualizar(context, config?.urlPlayStore ?? config?.urlApk), child: Text(t.boton)),
                );
              }),
            if (!kIsWeb && config?.urlPlayStore != null)
              ValueListenableBuilder<bool>(
                valueListenable: Resenas.pendiente,
                builder: (context, pendiente, _) => !pendiente ? const SizedBox.shrink() : _TarjetaResena(opositor: opositor, urlPlay: config!.urlPlayStore!, email: config.email),
              ),
            if (config != null && config.avisos.isNotEmpty)
              for (final a in config.avisos)
                Aviso(tipo: TipoAviso.aviso, icono: Icons.campaign_outlined, titulo: a),
            const TarjetaNovedadProceso(),
            const TarjetaElegirPapel(),
            const TarjetaParaEmpezar(),
            if (!opositor) ...[const PanelPreparadorHoy(), const SizedBox(height: 10)],
            // Sin fecha de examen ni cantes no se ven sus tarjetas vacías: esos
            // pasos están en «Para empezar».
            if (opositor && fecha != null) ...[
              Estadistica(
                onTap: () => context.go('/organizacion/convocatoria'),
                valor: '$dias',
                etiqueta: '${dias == 1 ? 'día' : 'días'} para el ${nombreEjercicio(proximo!.key).toLowerCase()}',
                detalle: DateFormat('d MMM y', 'es').format(fecha),
              ),
              const SizedBox(height: 12),
            ],
            if (opositor && cante != null) ...[
              Tarjeta(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: cante.id))),
                child: Row(children: [
                  Icon(Icons.record_voice_over_outlined, color: context.esquema.primary, size: 24),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Próximo cante ${cuentaAtras(cante.fecha)}', style: context.textos.titleMedium),
                      Text('${fechaLarga(cante.fecha)}, ${horaDe(cante.fecha)} · ${detalleCante(cante)}', style: context.textos.bodySmall),
                    ]),
                  ),
                  const Icon(Icons.chevron_right),
                ]),
              ),
              const SizedBox(height: 12),
            ],
            Tarjeta(
              color: diarioHecho ? null : context.colores.primarioPalido,
              onTap: diarioHecho || banco.value == null
                  ? null
                  : () {
                      final ids = MotorTest.testDiario(banco.value!, DateTime.now()).map((p) => p.id).toList();
                      context.push('/examen', extra: ConfigTest(idsFijos: ids, minutos: 15, tipo: 'diario'));
                    },
              child: Row(children: [
                Icon(diarioHecho ? Icons.check_circle : Icons.today, color: diarioHecho ? Paleta.acierto : context.esquema.primary, size: 24),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Test diario', style: context.textos.titleMedium),
                    Text(diarioHecho ? 'Hecho. ¡Hasta mañana!' : '10 preguntas oficiales, las mismas para todos hoy. 15 minutos.', style: context.textos.bodySmall),
                  ]),
                ),
                if (!diarioHecho) const Icon(Icons.chevron_right),
              ]),
            ),
            if (opositor) TarjetaCronogramaHoy(abrir: () => context.go('/organizacion/cronograma')),
            if (leitner.pendientes().isNotEmpty) ...[
              const SizedBox(height: 12),
              Tarjeta(
                onTap: () => context.push('/examen', extra: ConfigTest(idsFijos: leitner.pendientes(), minutos: 0, tipo: 'repaso')),
                child: Row(children: [
                  Icon(Icons.replay, color: context.esquema.primary),
                  const SizedBox(width: 14),
                  Expanded(child: Text('${leitner.pendientes().length} preguntas pendientes de repaso', style: context.textos.bodyMedium)),
                  const Icon(Icons.chevron_right),
                ]),
              ),
            ],
            if (opositor && prob != null && prob.temasSabidos > 0) ...[
              const SizedBox(height: 12),
              Tarjeta(
                onTap: () => context.go('/organizacion/probabilidades'),
                child: Row(children: [
                  Icon(Icons.percent, color: context.esquema.primary),
                  const SizedBox(width: 14),
                  Expanded(child: Text('Probabilidad de que salga alguno de los temas que llevas estudiados', style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface))),
                  const SizedBox(width: 12),
                  Text(porcentaje(prob.total), style: context.textos.titleMedium?.copyWith(color: context.esquema.primary)),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Una sola vez, tras tres momentos buenos (ver [Resenas]): valorar en Google
/// Play o escribir una sugerencia por correo. Las dos salidas, y «Ahora no»,
/// cierran la tarjeta para siempre.
class _TarjetaResena extends StatelessWidget {
  const _TarjetaResena({required this.opositor, required this.urlPlay, required this.email});
  final bool opositor;
  final String urlPlay;
  final String email;

  @override
  Widget build(BuildContext context) {
    final asunto = Uri.encodeComponent(opositor ? 'Sugerencia para la app (opositor)' : 'Sugerencia para la app (preparador)');
    return Aviso(
      icono: Icons.star_outline,
      titulo: '¿Nos ayudas a mejorar la app?',
      texto: opositor
          ? 'Si te está sirviendo, una valoración en Google Play ayuda a que la encuentren otros opositores. Y si algo falla o se te ocurre una mejora, escríbenos: lo leemos todo y lo arreglamos en la siguiente versión.'
          : 'Si te sirve para llevar a tus alumnos, una valoración en Google Play ayuda a que la encuentren otros preparadores y opositores. Y si algo falla o echas algo en falta, escríbenos: lo leemos todo y lo arreglamos en la siguiente versión.',
      accion: Wrap(spacing: 4, children: [
        TextButton(
          onPressed: () {
            Resenas.resuelta();
            abrirEnPlay(context, urlPlay);
          },
          child: const Text('Valorar en Google Play'),
        ),
        TextButton(
          onPressed: () {
            Resenas.resuelta();
            abrirUrl(context, 'mailto:$email?subject=$asunto');
          },
          child: const Text('Enviar una sugerencia'),
        ),
        TextButton(onPressed: Resenas.resuelta, child: const Text('Ahora no')),
      ]),
    );
  }
}
