import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/avisos_proceso.dart';
import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/preparador.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../preparador/ajustes_preparador_page.dart';

/// «Para empezar»: los primeros pasos en Hoy, que se tachan solos según lo que
/// ya se ha hecho. Distintos para el opositor y el preparador; se ocultan al
/// completarlos o con «Ocultar» (en cada oposición y papel).

/// Si los avisos del proceso selectivo están activados en la oposición actual
/// (la página del proceso lo invalida al cambiarlos).
final avisosProcesoActivosProvider = FutureProvider<bool>((ref) => avisosProcesoActivados(ref.watch(oposicionProvider).id));

/// Clave de [Cajas.app] con «Para empezar» oculta en una oposición y un papel.
String claveParaEmpezarOculta(String oposicion, Papel papel) => 'para_empezar_oculta_${oposicion}_${papel.name}';
String _claveCodigoVisto(String oposicion) => 'codigo_visto_$oposicion';

class _Paso {
  const _Paso(this.icono, this.titulo, this.hecho, this.abrir);
  final IconData icono;
  final String titulo;
  final bool hecho;
  final void Function(BuildContext) abrir;
}

class TarjetaParaEmpezar extends ConsumerStatefulWidget {
  const TarjetaParaEmpezar({super.key});
  @override
  ConsumerState<TarjetaParaEmpezar> createState() => _TarjetaParaEmpezarState();
}

class _TarjetaParaEmpezarState extends ConsumerState<TarjetaParaEmpezar> {
  Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;

  List<_Paso> _pasos(Papel papel) {
    final oposicion = ref.watch(oposicionProvider).id;
    final conCuenta = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final cuenta = _Paso(Icons.login, 'Entra con tu cuenta de Google', usuario != null, (c) => c.go('/mas/cuenta'));
    if (papel == Papel.preparador) {
      final perfil = ref.watch(perfilPreparadorProvider);
      final verificado = ref.watch(estadoRedProvider).valueOrNull?.verificado ?? false;
      return [
        if (conCuenta) cuenta,
        if (conCuenta) _Paso(Icons.verified_outlined, 'Date de alta y pide la verificación', verificado, (c) => c.go('/mas/preparador/alta')),
        _Paso(Icons.key_outlined, 'Pasa tu código a tus alumnos', _caja?.get(_claveCodigoVisto(oposicion)) == true, (c) {
          _caja?.put(_claveCodigoVisto(oposicion), true);
          setState(() {});
          c.go('/mas/preparador');
        }),
        _Paso(Icons.event_available_outlined, 'Abre tus huecos semanales', perfil.huecos.isNotEmpty, (c) => Navigator.of(c).push(MaterialPageRoute(builder: (_) => const AjustesPreparadorPage()))),
        _Paso(Icons.record_voice_over_outlined, 'Programa tu primera clase', ref.watch(sesionesProvider).isNotEmpty, (c) {
          ref.read(subpestanaCantesProvider.notifier).state = 0;
          c.go('/cantes');
        }),
      ];
    }
    final descargas = ref.watch(descargasProvider);
    final fecha = ref.watch(fechasEjerciciosProvider).isNotEmpty;
    final tests = ref.watch(historialProvider).valueOrNull?.isNotEmpty ?? ref.read(usuarioRepoProvider).resultadosLocales().isNotEmpty;
    final preparador = ref.watch(misPreparadoresProvider).isNotEmpty || ref.watch(miBusquedaProvider).valueOrNull != null;
    final avisos = ref.watch(avisosProcesoActivosProvider).valueOrNull ?? false;
    return [
      if (conCuenta) cuenta,
      _Paso(Icons.flag_outlined, 'Pon la fecha del examen', fecha, (c) => c.go('/organizacion/convocatoria')),
      if (descargas.guardaSinConexion)
        _Paso(Icons.download_outlined, 'Descarga tu primer tema para leerlo sin red', descargas.tamanoTotal() > 0, (c) {
          ref.read(subpestanaEstudiarProvider.notifier).state = 0;
          c.go('/estudiar');
        }),
      _Paso(Icons.quiz_outlined, 'Haz tu primer test', tests, (c) {
        ref.read(subpestanaEstudiarProvider.notifier).state = 1;
        c.go('/estudiar');
      }),
      if (conCuenta) _Paso(Icons.groups_outlined, 'Conecta con tu preparador o busca uno', preparador, (c) => c.go('/mas/mi-preparador')),
      _Paso(Icons.notifications_active_outlined, 'Activa los avisos del proceso selectivo', avisos, (c) => c.go('/organizacion/proceso')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final papel = ref.watch(papelProvider);
    final oposicion = ref.watch(oposicionProvider).id;
    if (_caja?.get(claveParaEmpezarOculta(oposicion, papel)) == true) return const SizedBox();
    final pasos = _pasos(papel);
    final hechos = pasos.where((p) => p.hecho).length;
    if (hechos == pasos.length) return const SizedBox();
    final pendientes = pasos.where((p) => !p.hecho).take(4).toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(16, 12, 6, 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.rocket_launch_outlined, color: context.esquema.primary),
            const SizedBox(width: 10),
            Expanded(child: Text('Para empezar', style: context.textos.titleMedium)),
            Text('$hechos de ${pasos.length}', style: context.textos.labelSmall),
            const SizedBox(width: 6),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10, bottom: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: hechos / pasos.length, minHeight: 5, backgroundColor: context.esquema.primary.withValues(alpha: 0.12)),
            ),
          ),
          for (final p in pendientes)
            InkWell(
              onTap: () => p.abrir(context),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Row(children: [
                  Icon(p.icono, size: 22, color: context.esquema.primary),
                  const SizedBox(width: 12),
                  Expanded(child: Text(p.titulo, style: context.textos.bodyMedium)),
                  const Icon(Icons.chevron_right),
                ]),
              ),
            ),
          Row(children: [
            Expanded(child: Text('Todo lo demás, en las pestañas.', style: context.textos.labelSmall)),
            TextButton(
              onPressed: () async {
                await _caja?.put(claveParaEmpezarOculta(oposicion, papel), true);
                setState(() {});
              },
              child: const Text('Ocultar'),
            ),
          ]),
        ]),
      ),
    );
  }
}
