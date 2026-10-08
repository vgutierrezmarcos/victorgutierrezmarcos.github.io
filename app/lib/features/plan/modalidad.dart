import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cantes_util.dart';

/// Presencial u online, con el lugar o el enlace de la videollamada. Para
/// online propone crear una reunión de Google Meet y pegar su enlace.
class SelectorModalidad extends StatelessWidget {
  const SelectorModalidad({super.key, required this.modalidad, required this.onModalidad, required this.lugar, required this.enlace, this.meetAutomatico = false});
  final Modalidad modalidad;
  /// El preparador tiene conectado Google Calendar: si se deja el enlace
  /// vacío, la reunión de Meet se crea sola al guardar.
  final bool meetAutomatico;
  final ValueChanged<Modalidad> onModalidad;
  final TextEditingController lugar;
  final TextEditingController enlace;

  Future<void> _pegar(BuildContext context) async {
    final texto = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? '';
    final url = enlaceReunion(texto);
    if (url != null) {
      enlace.text = url;
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay ningún enlace copiado. Crea la reunión, copia su enlace y vuelve a pegarlo.')));
    }
  }

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SegmentedButton<Modalidad>(
          showSelectedIcon: false,
          emptySelectionAllowed: true,
          segments: const [
            ButtonSegment(value: Modalidad.presencial, label: Text('Presencial'), icon: Icon(Icons.place_outlined, size: 18)),
            ButtonSegment(value: Modalidad.online, label: Text('Online'), icon: Icon(Icons.videocam_outlined, size: 18)),
          ],
          selected: {if (modalidad != Modalidad.sinIndicar) modalidad},
          onSelectionChanged: (s) => onModalidad(s.isEmpty ? Modalidad.sinIndicar : s.first),
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
        ),
        const SizedBox(height: 8),
        if (modalidad == Modalidad.presencial)
          TextField(controller: lugar, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Dónde (opcional)', prefixIcon: Icon(Icons.place_outlined))),
        if (modalidad == Modalidad.online) ...[
          TextField(
            controller: enlace,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              hintText: 'Enlace de la reunión (meet.google.com/…)',
              prefixIcon: const Icon(Icons.link),
              suffixIcon: IconButton(tooltip: 'Pegar', icon: const Icon(Icons.content_paste), onPressed: () => _pegar(context)),
            ),
          ),
          const SizedBox(height: 6),
          if (meetAutomatico)
            Row(children: [
              Icon(Icons.event_available_outlined, size: 18, color: context.esquema.primary),
              const SizedBox(width: 8),
              Expanded(child: Text('Déjalo vacío y, al guardar, la reunión de Meet se crea sola en tu Google Calendar, con la invitación al alumno.', style: context.textos.labelSmall)),
            ])
          else
          Wrap(spacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.video_call_outlined, size: 18),
              label: const Text('Crear reunión en Meet'),
              onPressed: () => abrirUrl(context, urlNuevaReunionMeet),
            ),
            Text('Se abre Meet: copia el enlace de la reunión y pégalo aquí.', style: context.textos.labelSmall),
          ]),
        ],
      ]);
}

/// Texto para enviar el enlace de un cante online a la otra persona.
String mensajeEnlace(Cante c) =>
    'Cante del ${fechaLarga(c.fecha)} a las ${horaDe(c.fecha)}${c.minutos > 0 ? ' (${c.minutos} min)' : ''}. Enlace de la videollamada: ${c.enlace}';

/// En la ficha de un cante: dónde es y, si es online, entrar a la clase,
/// copiar el enlace o enviarlo por WhatsApp (a [telefono], si se conoce).
class TarjetaModalidad extends StatelessWidget {
  const TarjetaModalidad({super.key, required this.cante, this.telefono});
  final Cante cante;
  final String? telefono;

  @override
  Widget build(BuildContext context) {
    final c = cante;
    if (c.modalidad == Modalidad.sinIndicar) return const SizedBox.shrink();
    final whatsapp = telefono == null || !c.online || c.enlace.isEmpty ? null : enlaceWhatsApp(telefono!, mensajeEnlace(c));
    return Tarjeta(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(c.online ? Icons.videocam_outlined : Icons.place_outlined, color: context.esquema.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(c.descripcionModalidad, style: context.textos.titleSmall)),
        ]),
        if (c.online && c.enlace.isEmpty)
          Padding(padding: const EdgeInsets.only(top: 6), child: Text('Aún sin enlace: edita el cante para añadirlo.', style: context.textos.labelSmall)),
        if (c.online && c.enlace.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: [
            FilledButton.icon(icon: const Icon(Icons.video_call, size: 18), label: const Text('Entrar a la clase'), onPressed: () => abrirUrl(context, c.enlace)),
            OutlinedButton.icon(
              icon: const Icon(Icons.copy, size: 18),
              label: const Text('Copiar enlace'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: c.enlace));
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enlace copiado')));
              },
            ),
            if (whatsapp != null) OutlinedButton.icon(icon: const Icon(Icons.chat_outlined, size: 18), label: const Text('Enviar por WhatsApp'), onPressed: () => abrirUrl(context, whatsapp)),
          ]),
        ],
      ]),
    );
  }
}
