import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'directorio_page.dart';
import 'verificacion_page.dart';
import 'red_widgets.dart';
import 'reservas.dart';
import 'sustituciones.dart';

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

  Future<void> _desconectar(VinculoPreparador v) async {
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

  @override
  Widget build(BuildContext context) {
    final firebase = ref.watch(serviciosProvider).firebaseDisponible;
    final usuario = ref.watch(usuarioActualProvider);
    final vinculos = ref.watch(misPreparadoresProvider);
    final ahora = DateTime.now();
    final misPeticiones = (ref.watch(misPeticionesProvider).valueOrNull ?? const <Sustitucion>[]).where((s) => s.vigente(ahora) && s.estado != EstadoSustitucion.cancelada).toList();
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    return Scaffold(
      appBar: const BarraWeb(title: Text('Mi preparador')),
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
            Text('Los temas que marcas como estudiados o en repaso y tus cantes (fecha, tema, tiempo, valoración y comentarios). No ve tus tests, tus notas ni tus grabaciones, y puedes dejar de compartir cuando quieras. Nadie más ve nada: ni sus otros alumnos ni otros opositores.', style: context.textos.bodySmall),
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
