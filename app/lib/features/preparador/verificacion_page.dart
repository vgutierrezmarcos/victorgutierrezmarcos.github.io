import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'red_widgets.dart';

/// Formulario para pedir la verificación como preparador.
Future<void> solicitarVerificacion(BuildContext context, WidgetRef ref) async {
  final usuario = ref.read(usuarioActualProvider);
  final nombre = TextEditingController(text: ref.read(perfilPreparadorProvider).nombre.isNotEmpty ? ref.read(perfilPreparadorProvider).nombre : (usuario?.displayName ?? ''));
  final presentacion = TextEditingController();
  final ejercicios = <int>{3, 4};
  // A quién se la pide: null = al administrador y a cualquier verificado.
  PreparadorVerificado? destinatario;
  final verificados = await ref.read(verificadosProvider.future);
  final candidatos = verificados.where((v) => v.uid != usuario?.uid).toList();
  if (!context.mounted) return;
  final ok = await showDialog<bool>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) => AlertDialog(
        title: const Text('Pedir la verificación'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Cuenta quién eres para que puedan comprobarlo.', style: Theme.of(d).textTheme.bodySmall),
            const SizedBox(height: 12),
            TextField(controller: nombre, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nombre y apellidos')),
            const SizedBox(height: 12),
            Text('Ejercicios que preparas', style: Theme.of(d).textTheme.labelMedium),
            Wrap(spacing: 8, children: [
              for (final e in ejerciciosConCante)
                FilterChip(label: Text(e == 1 ? '1.º (coyuntura)' : '$e.º'), selected: ejercicios.contains(e), onSelected: (v) => set(() => v ? ejercicios.add(e) : ejercicios.remove(e))),
            ]),
            const SizedBox(height: 12),
            Text('A quién se la pides', style: Theme.of(d).textTheme.labelMedium),
            DropdownButtonFormField<String>(
              initialValue: destinatario?.uid ?? '',
              isExpanded: true,
              items: [
                const DropdownMenuItem(value: '', child: Text('Al administrador (o a cualquier verificado)')),
                for (final v in candidatos) DropdownMenuItem(value: v.uid, child: Text(v.nombre, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (u) => set(() => destinatario = candidatos.where((v) => v.uid == u).firstOrNull),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                destinatario == null
                    ? 'Le llegará un aviso al administrador; los preparadores verificados también podrán verla en su lista.'
                    : 'Solo la verán ${destinatario!.nombre} (con un aviso) y el administrador.',
                style: Theme.of(d).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: presentacion,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Quién eres', hintText: 'Promoción y cuerpo, destino, desde cuándo preparas, quién te conoce…'),
              onChanged: (_) => set(() {}),
            ),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(
            onPressed: nombre.text.trim().isEmpty || presentacion.text.trim().length < 10 || ejercicios.isEmpty ? null : () => Navigator.pop(d, true),
            child: const Text('Enviar'),
          ),
        ],
      ),
    ),
  );
  if (ok != true || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  try {
    await ref.read(redRepoProvider).solicitar(
      nombre: nombre.text,
      ejercicios: ejercicios.toList()..sort(),
      presentacion: presentacion.text,
      destinatario: destinatario?.uid,
      destinatarioNombre: destinatario?.nombre ?? '',
    );
    ref.invalidate(estadoRedProvider);
    messenger.showSnackBar(const SnackBar(content: Text('Solicitud enviada. Te avisaremos en esta pantalla cuando te verifiquen.')));
  } catch (e) {
    messenger.showSnackBar(SnackBar(content: Text('No se pudo enviar: $e')));
  }
}

/// Solicitudes pendientes: las ve y resuelve un preparador verificado o el administrador.
class VerificarPreparadoresPage extends ConsumerWidget {
  const VerificarPreparadoresPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solicitudes = ref.watch(solicitudesPendientesProvider);
    final perfil = ref.watch(perfilPreparadorProvider);
    Future<void> resolver(SolicitudPreparador s, bool aprobar) async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: Text(aprobar ? '¿Verificar a ${s.nombre}?' : '¿Rechazar la solicitud?'),
          content: Text(aprobar
              ? 'Avalas que ${s.nombre} es preparador o preparadora de la oposición. Podrá dar su código a alumnos, ver y coger sustituciones y verificar a otros. Queda registrado que lo has verificado tú, y el administrador puede retirarlo.'
              : 'Se borrará la solicitud de ${s.nombre}. Podrá volver a pedirla.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: Text(aprobar ? 'Verificar' : 'Rechazar')),
          ],
        ),
      );
      if (ok != true) return;
      final red = ref.read(redRepoProvider);
      aprobar ? await red.aprobar(s, avalNombre: perfil.nombre.isEmpty ? null : perfil.nombre) : await red.rechazar(s);
      ref.invalidate(solicitudesPendientesProvider);
      ref.invalidate(verificadosProvider);
      ref.invalidate(verificadosConRetiradosProvider);
    }

    return Scaffold(
      appBar: BarraWeb(title: const Text('Verificar preparadores')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(solicitudesPendientesProvider),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Text('Verifica solo a quien conozcas o puedas comprobar que prepara la oposición. Así se evita que alguien se haga pasar por preparador.', style: context.textos.bodySmall),
            const TituloSeccion('Solicitudes'),
            ...switch (solicitudes) {
              AsyncData(:final value) when value.isEmpty => [Text('No hay solicitudes pendientes.', style: context.textos.bodySmall)],
              AsyncData(:final value) => [
                  for (final s in value)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Tarjeta(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s.nombre, style: context.textos.titleMedium),
                          Text([s.email, if (s.ejercicios.isNotEmpty) '${describirEjercicios(s.ejercicios)} ejercicio', if (s.creada != null) 'pedida el ${fechaCorta(s.creada!)}'].join(' · '), style: context.textos.labelSmall),
                          if (s.destinatario != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Etiqueta(s.destinatario == ref.read(redRepoProvider).uid ? 'Te la pide a ti' : 'Se la pide a ${s.destinatarioNombre}'),
                            ),
                          const SizedBox(height: 8),
                          Text(s.presentacion, style: context.textos.bodyMedium),
                          const SizedBox(height: 10),
                          Row(children: [
                            FilledButton(onPressed: () => resolver(s, true), child: const Text('Verificar')),
                            const SizedBox(width: 10),
                            TextButton(onPressed: () => resolver(s, false), child: const Text('Rechazar')),
                          ]),
                        ]),
                      ),
                    ),
                ],
              AsyncError() => [Text('No se han podido cargar. Desliza hacia abajo para reintentarlo.', style: context.textos.bodySmall)],
              _ => [const Center(child: CircularProgressIndicator())],
            },
          ],
        ),
      ),
    );
  }
}

/// Administración de la red: quién está verificado y quién lo avaló; retirar o devolver la verificación.
class AdminRedPage extends ConsumerWidget {
  const AdminRedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(estadoRedProvider).value ?? const EstadoRed();
    final todos = ref.watch(verificadosConRetiradosProvider);
    final pendientes = ref.watch(solicitudesPendientesProvider).value ?? const [];
    final red = ref.read(redRepoProvider);

    Future<void> retirar(PreparadorVerificado v, List<PreparadorVerificado> lista) async {
      final avalados = lista.where((x) => x.avaladoPor == v.uid && x.uid != v.uid && x.activo).length;
      var cascada = false;
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => StatefulBuilder(
          builder: (d, set) => AlertDialog(
            title: Text('¿Retirar a ${v.nombre}?'),
            content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Dejará de aparecer en la lista, sus alumnos enlazados dejarán de compartir con él o ella, y no podrá coger sustituciones ni verificar a nadie.'),
              if (avalados > 0) CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: cascada,
                onChanged: (x) => set(() => cascada = x ?? false),
                title: Text('Retirar también a los $avalados que verificó (y a los que verificaron estos)'),
              ),
            ]),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
              FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Retirar')),
            ],
          ),
        ),
      );
      if (ok != true) return;
      final n = await red.cambiarActivo(v, activo: false, cascada: cascada);
      ref.invalidate(verificadosConRetiradosProvider);
      ref.invalidate(verificadosProvider);
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(n == 1 ? 'Verificación retirada' : 'Verificación retirada a $n personas')));
    }

    return Scaffold(
      appBar: BarraWeb(title: const Text('Administración')),
      body: RefreshIndicator(
        onRefresh: () async => refrescarRedDesdeWidget(ref),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            if (!estado.esAdmin)
              Text('Esta pantalla es solo para el administrador.', style: context.textos.bodySmall)
            else ...[
              if (!estado.verificado)
                Tarjeta(
                  color: context.colores.primarioPalido,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Verifícate tú primero', style: context.textos.titleMedium),
                    Text('Eres el primer eslabón de la red: con tu verificación podrás dar tu código a alumnos y verificar a otros preparadores.', style: context.textos.bodySmall),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () async {
                        final p = ref.read(perfilPreparadorProvider);
                        await red.verificarme(nombre: p.nombre.isNotEmpty ? p.nombre : (ref.read(usuarioActualProvider)?.displayName ?? 'Administrador'));
                        refrescarRedDesdeWidget(ref);
                        await ref.read(perfilPreparadorProvider.notifier).reintentarCodigo();
                      },
                      child: const Text('Verificarme'),
                    ),
                  ]),
                ),
              FilaEnlace(
                icono: Icons.how_to_reg_outlined,
                titulo: 'Solicitudes pendientes',
                subtitulo: pendientes.isEmpty ? 'Ninguna' : '${pendientes.length} por revisar',
                final_: globo(context, pendientes.length),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VerificarPreparadoresPage())),
              ),
              const TituloSeccion('Preparadores verificados'),
              ...switch (todos) {
                AsyncData(:final value) when value.isEmpty => [Text('Todavía no hay ninguno.', style: context.textos.bodySmall)],
                AsyncData(:final value) => [
                    for (final v in value)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Tarjeta(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(v.nombre, style: context.textos.titleSmall?.copyWith(decoration: v.activo ? null : TextDecoration.lineThrough)),
                            subtitle: Text(
                              [
                                if (v.descripcionEjercicios.isNotEmpty) v.descripcionEjercicios,
                                v.avaladoPor == v.uid ? 'administrador' : 'verificado por ${v.avaladoPorNombre.isEmpty ? '—' : v.avaladoPorNombre}',
                                if (v.desde != null) fechaCorta(v.desde!),
                                if (!v.activo) 'RETIRADO',
                              ].join(' · '),
                              style: context.textos.labelSmall,
                            ),
                            trailing: v.uid == red.uid
                                ? null
                                : v.activo
                                    ? TextButton(onPressed: () => retirar(v, value), child: Text('Retirar', style: TextStyle(color: context.esquema.error)))
                                    : TextButton(
                                        onPressed: () async {
                                          await red.cambiarActivo(v, activo: true);
                                          ref.invalidate(verificadosConRetiradosProvider);
                                          ref.invalidate(verificadosProvider);
                                        },
                                        child: const Text('Devolver'),
                                      ),
                          ),
                        ),
                      ),
                  ],
                AsyncError() => [Text('No se ha podido cargar la lista.', style: context.textos.bodySmall)],
                _ => [const Center(child: CircularProgressIndicator())],
              },
              const SizedBox(height: 8),
              Text('Los administradores se dan de alta en la consola de Firebase (colección admins, un documento por uid).', style: context.textos.labelSmall),
            ],
          ],
        ),
      ),
    );
  }
}

/// [refrescarRed] desde un widget (que tiene WidgetRef y no Ref).
void refrescarRedDesdeWidget(WidgetRef ref) {
  for (final p in <ProviderOrFamily>[estadoRedProvider, verificadosProvider, verificadosConRetiradosProvider, solicitudesPendientesProvider, tablonProvider, cogidasPorMiProvider, misPeticionesProvider, reservasRecibidasProvider, misReservasProvider, huecosDeProvider]) {
    ref.invalidate(p);
  }
}
