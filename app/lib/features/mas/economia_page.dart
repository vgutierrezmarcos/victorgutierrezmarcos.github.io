import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/analitica.dart';
import '../../core/avisos_breves.dart';
import '../../core/constants.dart';
import '../../core/exportar_ia.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cronograma/importar_cronograma.dart';

/// Las IA con las que funciona el conector, por orden (Claude, la recomendada).
const iasCompatibles = <({String nombre, String nota})>[
  (nombre: 'Claude', nota: 'Recomendada: con Claude, completo (informes en PDF con la plantilla de los temas y gráficos como los del temario). Plan de pago (Pro, Max o Team).'),
  (nombre: 'Le Chat (Mistral)', nota: 'También con el plan gratuito.'),
  (nombre: 'ChatGPT', nota: 'Con los planes que admiten conectores propios.'),
  (nombre: 'Gemini', nota: 'Con los planes que admiten conectores propios.'),
];

/// Una línea sobre lo que supone conectar el conector de IA (también en
/// Cuenta → Tus datos solo los ves tú).
const textoPrivacidadConector =
    'Si conectas el conector de IA, un servidor de la web lee y escribe tus datos con tu propia sesión, en tu nombre y solo cuando tu IA se lo pide: escribe en la app solo lo que tú confirmas en la conversación. Lo desconectas en Más → EconomIA → «Desconectar la IA».';

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
          const TituloSeccion('Con qué IA funciona'),
          GrupoFilas(children: [
            for (final (i, ia) in iasCompatibles.indexed)
              ListTile(
                leading: Icon(i == 0 ? Icons.star_outline : Icons.smart_toy_outlined, color: context.esquema.primary),
                title: Text(ia.nombre, style: context.textos.titleSmall),
                subtitle: Text(ia.nota, style: context.textos.labelSmall),
              ),
          ]),
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
