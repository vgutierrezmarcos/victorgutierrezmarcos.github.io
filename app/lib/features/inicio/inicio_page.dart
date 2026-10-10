import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/actualizaciones.dart';
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
    final canceladas = ref.watch(canceladasProximasProvider);
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Tarjeta(
                  color: context.colores.primarioPalido,
                  child: Row(children: [
                    Icon(Icons.cloud_off_outlined, color: context.esquema.primary, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        Oposiciones.actual.lanzada
                            ? 'No se ha podido descargar el temario de ${Oposiciones.actual.siglas}. Comprueba la conexión y vuelve a intentarlo.'
                            : 'El contenido de ${Oposiciones.actual.siglas} aún no está publicado: la oposición está sin lanzar. Puedes volver a TCEE en Más → Ajustes → Oposición.',
                        style: context.textos.bodySmall,
                      ),
                    ),
                    TextButton(onPressed: () => ref.invalidate(temarioProvider), child: const Text('Reintentar')),
                  ]),
                ),
              ),
            const TarjetaAvisosDesactivados(),
            if (opositor)
              for (final c in canceladas)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Tarjeta(
                    color: context.esquema.errorContainer.withValues(alpha: 0.35),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: c.id))),
                    child: Row(children: [
                      Icon(Icons.event_busy, color: context.esquema.error, size: 30),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${(c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre} ha cancelado la clase del ${fechaCorta(c.fecha)}', style: context.textos.titleMedium),
                          Text('${horaDe(c.fecha)}${c.motivo.isEmpty ? '' : ' · ${c.motivo}'}. Toca para verla o pedir una clase suelta.', style: context.textos.bodySmall),
                        ]),
                      ),
                      const Icon(Icons.chevron_right),
                    ]),
                  ),
                ),
            if (versionNueva != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Tarjeta(
                  color: context.colores.primarioPalido,
                  child: Row(children: [
                    Icon(Icons.system_update_outlined, color: context.esquema.primary, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Hay una versión nueva ($versionNueva)', style: context.textos.titleMedium),
                        Text(kIsWeb ? 'Recarga la página para usarla; tus datos están en tu cuenta.' : 'Se instala encima de la actual, sin perder tus datos.', style: context.textos.bodySmall),
                      ]),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(onPressed: () => actualizar(context, config?.urlPlayStore ?? config?.urlApk), child: Text(kIsWeb ? 'Recargar' : 'Actualizar')),
                  ]),
                ),
              ),
            if (config != null && config.avisos.isNotEmpty)
              for (final a in config.avisos)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                      color: context.colores.dorado.withValues(alpha: 0.12),
                      child: Row(children: [Icon(Icons.campaign_outlined, color: context.colores.dorado), const SizedBox(width: 10), Expanded(child: Text(a, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)))])),
                ),
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
              const SizedBox(height: 10),
            ],
            if (opositor && cante != null) ...[
              Tarjeta(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantePage(id: cante.id))),
                child: Row(children: [
                  Icon(Icons.record_voice_over_outlined, color: context.esquema.primary, size: 32),
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
              const SizedBox(height: 10),
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
                Icon(diarioHecho ? Icons.check_circle : Icons.today, color: diarioHecho ? Paleta.acierto : context.esquema.primary, size: 32),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
