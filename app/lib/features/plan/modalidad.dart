import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'cantes_util.dart';

/// Presencial u online, con el lugar o el enlace de la videollamada. Para
/// online propone crear una reunión (Google Meet o Microsoft Teams, lo elige
/// el preparador) y pegar su enlace; al volver a la app con el enlace copiado
/// se pega solo.
class SelectorModalidad extends StatefulWidget {
  const SelectorModalidad({
    super.key,
    required this.modalidad,
    required this.onModalidad,
    required this.lugar,
    required this.enlace,
    this.meetAutomatico = false,
    this.plataforma,
    this.onPlataforma,
  });
  final Modalidad modalidad;

  /// El preparador tiene conectado Google Calendar: si se deja el enlace
  /// vacío (y la videollamada es Meet), la reunión se crea sola al guardar.
  final bool meetAutomatico;
  final ValueChanged<Modalidad> onModalidad;
  final TextEditingController lugar;
  final TextEditingController enlace;

  /// Videollamada que propone ('meet' o 'teams'); null = no se elige aquí (el
  /// cante propio del opositor).
  final String? plataforma;
  final ValueChanged<String>? onPlataforma;

  @override
  State<SelectorModalidad> createState() => _SelectorModalidadState();
}

class _SelectorModalidadState extends State<SelectorModalidad> {
  late final AppLifecycleListener _ciclo;
  // Se ha abierto Meet o Teams para crear la reunión: al volver se mira el portapapeles.
  bool _esperandoEnlace = false;

  @override
  void initState() {
    super.initState();
    _ciclo = AppLifecycleListener(onResume: _alVolver);
  }

  @override
  void dispose() {
    _ciclo.dispose();
    super.dispose();
  }

  Future<void> _alVolver() async {
    if (!_esperandoEnlace || !mounted) return;
    _esperandoEnlace = false;
    if (widget.enlace.text.trim().isNotEmpty) return;
    final texto = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? '';
    final url = enlaceReunion(texto);
    if (url == null || plataformaDeEnlace(url).isEmpty || !mounted) return;
    widget.enlace.text = url;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enlace de la reunión pegado del portapapeles')));
  }

  Future<void> _pegar(BuildContext context) async {
    final texto = (await Clipboard.getData(Clipboard.kTextPlain))?.text ?? '';
    final url = enlaceReunion(texto);
    if (url != null) {
      widget.enlace.text = url;
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay ningún enlace copiado. Crea la reunión, copia su enlace y vuelve a pegarlo.')));
    }
  }

  void _crear(BuildContext context) {
    _esperandoEnlace = true;
    abrirUrl(context, (widget.plataforma ?? plataformaMeet) == plataformaTeams ? urlNuevaReunionTeams : urlNuevaReunionMeet);
  }

  @override
  Widget build(BuildContext context) {
    final plataforma = widget.plataforma ?? plataformaMeet;
    final teams = plataforma == plataformaTeams;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SegmentedButton<Modalidad>(
        showSelectedIcon: false,
        emptySelectionAllowed: true,
        segments: const [
          ButtonSegment(value: Modalidad.presencial, label: Text('Presencial'), icon: Icon(Icons.place_outlined, size: 18)),
          ButtonSegment(value: Modalidad.online, label: Text('Online'), icon: Icon(Icons.videocam_outlined, size: 18)),
        ],
        selected: {if (widget.modalidad != Modalidad.sinIndicar) widget.modalidad},
        onSelectionChanged: (s) => widget.onModalidad(s.isEmpty ? Modalidad.sinIndicar : s.first),
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      ),
      const SizedBox(height: 8),
      if (widget.modalidad == Modalidad.presencial)
        TextField(controller: widget.lugar, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Dónde (opcional)', prefixIcon: Icon(Icons.place_outlined))),
      if (widget.modalidad == Modalidad.online) ...[
        if (widget.onPlataforma != null) ...[
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: plataformaMeet, label: Text('Google Meet')),
              ButtonSegment(value: plataformaTeams, label: Text('Microsoft Teams')),
            ],
            selected: {teams ? plataformaTeams : plataformaMeet},
            onSelectionChanged: (s) => widget.onPlataforma!(s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: widget.enlace,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            hintText: teams ? 'Enlace de la reunión (teams.microsoft.com/…)' : 'Enlace de la reunión (meet.google.com/…)',
            prefixIcon: const Icon(Icons.link),
            suffixIcon: IconButton(tooltip: 'Pegar', icon: const Icon(Icons.content_paste), onPressed: () => _pegar(context)),
          ),
        ),
        const SizedBox(height: 6),
        if (widget.meetAutomatico && !teams)
          Row(children: [
            Icon(Icons.event_available_outlined, size: 18, color: context.esquema.primary),
            const SizedBox(width: 8),
            Expanded(child: Text('Déjalo vacío y, al guardar, la reunión de Meet se crea sola en tu Google Calendar, con la invitación al alumno.', style: context.textos.labelSmall)),
          ])
        else
          Wrap(spacing: 8, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.video_call_outlined, size: 18),
              label: Text('Crear reunión en ${nombrePlataforma(plataforma)}'),
              onPressed: () => _crear(context),
            ),
            Text(
              teams
                  ? 'Se abre Teams: crea la reunión, copia su enlace y vuelve (se pega solo). Con cuenta del trabajo, créala en tu Teams y pega el enlace.'
                  : 'Se abre Meet: copia el enlace de la reunión y vuelve a la app (se pega solo).',
              style: context.textos.labelSmall,
            ),
          ]),
      ],
    ]);
  }
}

/// Hoja para cambiar dónde es una clase ya creada (presencial u online, lugar,
/// videollamada y enlace). Devuelve la clase cambiada, o null.
Future<Cante?> editarModalidad(BuildContext context, Cante c, {required bool preparador}) async {
  final lugar = TextEditingController(text: c.lugar);
  final enlace = TextEditingController(text: c.enlace);
  var modalidad = c.modalidad;
  var plataforma = c.plataformaEfectiva.isEmpty ? plataformaMeet : c.plataformaEfectiva;
  final r = await showModalBottomSheet<Cante>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (d) => StatefulBuilder(
      builder: (d, set) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(d).bottom),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
              Text('Presencial u online', style: d.textos.titleLarge),
              const SizedBox(height: 10),
              SelectorModalidad(
                modalidad: modalidad,
                onModalidad: (m) => set(() => modalidad = m),
                lugar: lugar,
                enlace: enlace,
                plataforma: preparador ? plataforma : null,
                onPlataforma: preparador ? (p) => set(() => plataforma = p) : null,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(
                  d,
                  c.copyWith(
                    modalidad: modalidad,
                    lugar: modalidad == Modalidad.presencial ? lugar.text.trim() : '',
                    enlace: modalidad == Modalidad.online ? (enlaceReunion(enlace.text) ?? '') : '',
                    plataforma: modalidad == Modalidad.online && preparador ? plataforma : '',
                  ),
                ),
                child: const Text('Guardar'),
              ),
            ]),
          ),
        ),
      ),
    ),
  );
  lugar.dispose();
  enlace.dispose();
  return r;
}

/// Texto para enviar el enlace de un cante online a la otra persona.
String mensajeEnlace(Cante c) =>
    'Cante del ${fechaLarga(c.fecha)} a las ${horaDe(c.fecha)}${c.minutos > 0 ? ' (${textoDuracion(c.minutos)})' : ''}. Enlace de la videollamada: ${c.enlace}';

/// En la ficha de un cante: dónde es y, si es online, entrar a la clase,
/// copiar el enlace o enviarlo por WhatsApp (a [telefono], si se conoce).
/// Con [onEditar] (el preparador), sin enlace se ofrece ponerlo.
class TarjetaModalidad extends StatelessWidget {
  const TarjetaModalidad({super.key, required this.cante, this.telefono, this.onEditar});
  final Cante cante;
  final String? telefono;
  final VoidCallback? onEditar;

  @override
  Widget build(BuildContext context) {
    final c = cante;
    if (c.modalidad == Modalidad.sinIndicar) return const SizedBox.shrink();
    final whatsapp = telefono == null || !c.online || c.enlace.isEmpty ? null : enlaceWhatsApp(telefono!, mensajeEnlace(c));
    final plataforma = c.plataformaEfectiva;
    return Tarjeta(
      onTap: onEditar,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(c.online ? Icons.videocam_outlined : Icons.place_outlined, color: context.esquema.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(c.descripcionModalidad, style: context.textos.titleSmall)),
          if (onEditar != null) Icon(Icons.edit_outlined, size: 18, color: context.colores.textoClaro),
        ]),
        if (c.online && c.enlace.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(onEditar != null ? 'Aún sin enlace: toca para crear la reunión${plataforma.isEmpty ? '' : ' en ${nombrePlataforma(plataforma)}'} o pegar el enlace.' : 'Tu preparador aún no ha puesto el enlace de la reunión.', style: context.textos.labelSmall),
          ),
        if (c.online && c.enlace.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: [
            FilledButton.icon(icon: const Icon(Icons.video_call, size: 18), label: Text('Entrar a la clase${plataforma.isEmpty ? '' : ' (${nombrePlataforma(plataforma)})'}'), onPressed: () => abrirUrl(context, c.enlace)),
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
