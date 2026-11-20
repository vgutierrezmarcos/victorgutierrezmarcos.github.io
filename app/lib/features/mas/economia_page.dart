import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/analitica.dart';
import '../../core/avisos_breves.dart';
import '../../core/constants.dart';
import '../../core/exportar_ia.dart';
import '../../core/ia.dart';
import '../../core/ia_mensajes.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/configurar_ia.dart';
import '../cronograma/importar_cronograma.dart';

/// Una línea sobre lo que supone conectar el conector de IA (también en
/// Cuenta → Tus datos solo los ves tú).
const textoPrivacidadConector =
    'Si conectas el conector de IA, un servidor de la web lee y escribe tus datos con tu propia sesión, en tu nombre y solo cuando tu IA se lo pide: escribe en la app solo lo que tú confirmas en la conversación, y apunta en tu cuenta con qué IA lo usas y qué día fue la última vez (para ofrecerte aquí el acceso directo a tu IA). Lo desconectas en Más → EconomIA → «Desconectar la IA».';

/// Más → EconomIA: el equipo de preparación con IA. Qué es, con qué IA
/// funciona, cómo se añade el conector «Oposición TCEE · DCE», exportar los
/// datos para quien no lo use y cómo desconectarlo.
class EconomiaPage extends ConsumerWidget {
  const EconomiaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    return Scaffold(
      appBar: BarraWeb(title: const Text('EconomIA')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          // Lo primero: en qué IA está configurada.
          const EstadoEconomiaTarjeta(),
          const SizedBox(height: 10),
          Tarjeta(
            destacada: true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Un equipo de preparación en tu IA', style: context.textos.titleMedium),
              const SizedBox(height: 6),
              Text(
                'Con el conector «${Creditos.nombreApp}», tu asistente de IA corrige tus cantes y dictámenes con el temario revisado, te organiza el cronograma y te pregunta como el tribunal. Lee de la app tus temas, tus cantes, tus tests y tu cronograma, y guarda en ella el informe del cante o un cronograma nuevo cuando tú se lo confirmas.',
                style: context.textos.bodySmall,
              ),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 6, children: [
                FilledButton.icon(onPressed: () => abrirUrl(context, Urls.economia), icon: const Icon(Icons.open_in_new, size: 18), label: const Text('Cómo se añade')),
                OutlinedButton.icon(onPressed: () => _copiarUrl(context), icon: const Icon(Icons.copy, size: 18), label: const Text('Copiar la dirección del conector')),
              ]),
            ]),
          ),
          const SizedBox(height: 10),
          const Aviso(
            icono: Icons.school_outlined,
            titulo: 'No sustituye a tu preparador: lo complementa.',
            texto: 'Cita de dónde sale cada corrección, pero es una IA y puede equivocarse. Contrasta con tu preparador lo que te sorprenda.',
          ),
          const TituloSeccion('Tu IA'),
          const _TuIa(),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: SelectableText('Dirección del conector: ${Urls.conectorIa}', style: context.textos.labelSmall),
          ),
          const TituloSeccion('Tus datos y tu IA'),
          GrupoFilas(children: [
            ListTile(
              leading: Icon(Icons.file_download_outlined, color: context.esquema.primary),
              title: Text('Exportar mis datos para la IA', style: context.textos.titleSmall),
              subtitle: Text('Si no usas el conector: un resumen de tu preparación (temas, cantes, cronograma, tests) para subirlo al chat. Con el conector no hace falta.', style: context.textos.labelSmall),
              trailing: Icon(Icons.chevron_right, color: context.colores.textoClaro),
              onTap: () => exportarParaIa(ref),
            ),
            ListTile(
              leading: Icon(Icons.upload_file, color: context.esquema.primary),
              title: Text('Traer el cronograma de tu IA', style: context.textos.titleSmall),
              subtitle: Text('Pega el bloque de fechas y temas que te devuelve; la app te lo enseña antes de crearlo.', style: context.textos.labelSmall),
              trailing: Icon(Icons.chevron_right, color: context.colores.textoClaro),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ImportarCronogramaPage())),
            ),
            ListTile(
              leading: Icon(Icons.link_off, color: context.esquema.error),
              title: Text('Desconectar la IA', style: context.textos.titleSmall?.copyWith(color: context.esquema.error)),
              subtitle: Text('Quitarle a tu IA el acceso a tus datos de la app', style: context.textos.labelSmall),
              onTap: () => desconectarIa(context),
            ),
          ]),
          const TituloSeccion('Privacidad'),
          Tarjeta(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(textoPrivacidadConector, style: context.textos.bodySmall),
              const SizedBox(height: 6),
              Text(
                'Las transcripciones de los cantes y las grabaciones se quedan en tu móvil: solo llegan a tu IA si las envías tú. Lo que hace tu IA con lo que le das se rige por las condiciones de la empresa que la ofrece.${usuario == null ? ' Para conectar el conector necesitas iniciar sesión con Google (la misma cuenta que en la app).' : ''}',
                style: context.textos.bodySmall,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(onPressed: () => abrirUrl(context, Urls.politicaPrivacidad, enApp: true), child: const Text('Política de privacidad (apartado 2.3)')),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> _copiarUrl(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: Urls.conectorIa));
    messenger.mostrar(const SnackBar(content: Text('Dirección del conector copiada: pégala en los conectores de tu IA')));
  }
}

/// En qué IA está configurada EconomIA, elegirla, conectarla y decidir si se
/// quiere la burbuja (activada por defecto: sin configurar, lleva a configurarla).
class _TuIa extends ConsumerWidget {
  const _TuIa();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(iaProvider);
    final conexiones = ref.watch(conectorProvider).valueOrNull ?? const <Ia, DateTime>{};
    final elegida = ref.watch(iaElegidaProvider);
    final configurada = ref.watch(iaConfiguradaProvider);
    final notifier = ref.read(iaProvider.notifier);
    final vista = elegida == null ? null : conexiones[elegida];
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SelectorIa(),
      if (elegida != null && configurada == null) ...[
        const SizedBox(height: 10),
        Aviso(
          icono: Icons.link,
          titulo: 'Conecta EconomIA con ${elegida.nombre}',
          texto: 'Sigue los pasos de la web con la misma cuenta de Google que usas aquí. Cuando ${elegida.nombre} use el conector, la app lo sabrá sola; si ya lo has hecho, toca «Ya lo he conectado».',
          accion: Wrap(spacing: 8, children: [
            TextButton(onPressed: () => abrirUrl(context, elegida.urlComoConectar), child: const Text('Cómo se conecta')),
            TextButton(onPressed: () => notifier.conectadaAMano(true), child: const Text('Ya lo he conectado')),
          ]),
        ),
      ],
      const SizedBox(height: 10),
      GrupoFilas(children: [
        SwitchListTile(
          secondary: Icon(Icons.auto_awesome_outlined, color: context.esquema.primary),
          title: Text('Burbuja de EconomIA', style: context.textos.titleSmall),
          subtitle: Text(
            configurada != null
                ? 'Un acceso pequeño en Inicio, los temas, los tests, el cronograma y los cantes que abre ${configurada.nombre} con lo que le quieras pedir. Arrástrala de lado para cambiarla de esquina.'
                : 'Un acceso pequeño en Inicio, los temas, los tests, el cronograma y los cantes. Mientras EconomIA no esté configurada, te lleva a configurarla.',
            style: context.textos.labelSmall,
          ),
          value: estado.burbuja,
          onChanged: notifier.mostrarBurbuja,
        ),
        if (configurada != null)
          ListTile(
            leading: Icon(Icons.open_in_new, color: context.esquema.primary),
            title: Text('Abrir ${configurada.nombre}', style: context.textos.titleSmall),
            subtitle: Text('Con un mensaje para empezar', style: context.textos.labelSmall),
            onTap: () => abrirIa(context, configurada, MensajesIa(ref.read(oposicionProvider)).libre, acceso: 'economia'),
          ),
        if (configurada != null && vista == null)
          ListTile(
            leading: Icon(Icons.link_off, color: context.colores.textoClaro),
            title: Text('Aún no la he conectado', style: context.textos.titleSmall),
            subtitle: Text('Quita la marca de conectada (la burbuja volverá a llevarte a configurarla)', style: context.textos.labelSmall),
            onTap: () => notifier.conectadaAMano(false),
          ),
      ]),
    ]);
  }
}

/// Guarda (o comparte, en el móvil) `oposicion_<id>_para_ia.json`.
Future<void> exportarParaIa(WidgetRef ref) async {
  final usuario = ref.read(usuarioRepoProvider);
  final plan = ref.read(planRepoProvider);
  final oposicion = ref.read(oposicionProvider);
  String? version;
  try {
    version = (await PackageInfo.fromPlatform()).version;
  } catch (_) {}
  final datos = datosParaIa(
    oposicion: oposicion.id,
    generado: DateTime.now(),
    version: version,
    ajustes: usuario.ajustes(),
    plan: plan.plan(),
    agendas: plan.agendas(),
    cronograma: plan.cronogramaActivo(),
    cantes: plan.cantes(),
    tests: usuario.resultadosLocales(),
    leitner: usuario.leitner(),
  );
  Analitica.instancia.evento('ia_exportar');
  await guardarFichero(nombre: nombreExportacionIa(oposicion.id), contenido: jsonParaIa(datos), mime: 'application/json', asunto: 'Mis datos para la IA · ${Creditos.nombreApp}');
}

/// La app no puede revocar el acceso del conector por su cuenta: el servidor
/// solo atiende a la IA, con su propio token (ver `mcp/README.md` y la nota de
/// app/DCE.md). Así que explica las dos formas que lo cortan al momento.
Future<void> desconectarIa(BuildContext context) async {
  const frase = 'Desconéctate de la app';
  await showDialog<void>(
    context: context,
    builder: (d) => AlertDialog(
      title: const Text('Desconectar la IA'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('La app no puede cortar por sí sola el acceso del conector: se lo quitas desde tu IA, de una de estas dos formas, y deja de funcionar al momento.', style: d.textos.bodySmall),
          const SizedBox(height: 12),
          Text('1. Pídeselo en una conversación', style: d.textos.titleSmall),
          Text('Escribe «$frase». El conector borra su acceso a tus datos y no vuelve a funcionar hasta que lo conectes otra vez.', style: d.textos.bodySmall),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(d);
                await Clipboard.setData(const ClipboardData(text: frase));
                messenger.mostrar(const SnackBar(content: Text('Copiado: pégalo en el chat de tu IA')));
              },
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copiar la frase'),
            ),
          ),
          const SizedBox(height: 6),
          Text('2. Quita el conector en tu IA', style: d.textos.titleSmall),
          Text('En los ajustes de conectores de tu asistente (en Claude, Configuración → Conectores), elimina «${Creditos.nombreApp}».', style: d.textos.bodySmall),
          const SizedBox(height: 10),
          Text('Tus datos de la app no se borran: solo deja de leerlos y escribirlos tu IA.', style: d.textos.labelSmall),
        ]),
      ),
      actions: [FilledButton(onPressed: () => Navigator.pop(d), child: const Text('Entendido'))],
    ),
  );
}
