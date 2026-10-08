import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../data/repos/red_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import 'directorio_page.dart';
import 'disponibilidad_widget.dart';
import 'red_widgets.dart';

/// Buscar preparador (el opositor). Dos caminos que se juntan: los
/// preparadores verificados que admiten alumnos, ordenados por lo que
/// encajan con lo que busca, y lo que busca él, publicado sin nombre para que
/// los preparadores a los que les interese le dejen su contacto. Siempre es
/// el opositor quien escribe (por WhatsApp o LinkedIn); el enlace en la app,
/// con el código, lo hacen después, si se entienden.
class BuscarPreparadorPage extends ConsumerWidget {
  const BuscarPreparadorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioActualProvider);
    final busqueda = ref.watch(miBusquedaProvider);
    final b = busqueda.valueOrNull;
    final conPlazas = ref.watch(preparadoresConPlazasProvider);
    final interesados = b == null ? const AsyncValue<List<Interesado>>.data([]) : ref.watch(interesadosProvider(b.id));
    void ir(Widget w) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => w));

    Future<void> cerrar() async {
      if (b == null) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Cerrar la búsqueda?'),
          content: const Text('Dejará de verse en el tablón de los preparadores. Puedes publicar otra cuando quieras.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Cerrar búsqueda')),
          ],
        ),
      );
      if (ok != true) return;
      try {
        await ref.read(redRepoProvider).guardarBusqueda(b.copyWith(estado: 'cerrada'));
      } catch (_) {}
      ref.invalidate(miBusquedaProvider);
      ref.invalidate(preparadoresConPlazasProvider);
    }

    return Scaffold(
      appBar: const BarraWeb(title: Text('Buscar preparador')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(miBusquedaProvider);
          ref.invalidate(preparadoresConPlazasProvider);
          ref.invalidate(verificadosProvider);
          if (b != null) ref.invalidate(interesadosProvider(b.id));
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Text('Aquí no hay intermediarios: ves quién admite alumnos, miras su LinkedIn y le escribes tú. Y si cuentas lo que buscas, los preparadores a los que les interese te dejan su contacto. Nadie te escribe a ti sin que lo pidas.', style: context.textos.bodySmall),
            if (usuario == null) ...[
              const SizedBox(height: 10),
              Tarjeta(child: Text('Inicia sesión con Google (Más → Cuenta) para ver quién admite alumnos y publicar lo que buscas.', style: context.textos.bodySmall)),
            ],
            // ------------------------------------------------ Lo que busco
            const TituloSeccion('Lo que buscas'),
            if (b == null)
              Tarjeta(
                color: context.colores.primarioPalido,
                onTap: usuario == null ? null : () => ir(const BusquedaFormPage()),
                child: Row(children: [
                  Icon(Icons.person_search_outlined, color: context.esquema.primary, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Cuenta lo que buscas', style: context.textos.titleMedium),
                      Text('Ejercicio, online o presencial, cuándo puedes y cuándo quieres empezar (aunque sea dentro de unos meses). Sin tu nombre ni tu teléfono.', style: context.textos.bodySmall),
                    ]),
                  ),
                  const Icon(Icons.chevron_right),
                ]),
              )
            else ...[
              Tarjeta(
                color: context.colores.primarioPalido,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(b.descripcion, style: context.textos.titleSmall)),
                    const Etiqueta('Publicada', color: Paleta.acierto),
                  ]),
                  if (b.disponibilidad.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: TextoDisponibilidad(b.disponibilidad)),
                  if (b.nota.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text(b.nota, style: context.textos.bodySmall)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, children: [
                    OutlinedButton.icon(onPressed: () => ir(BusquedaFormPage(busqueda: b)), icon: const Icon(Icons.edit_outlined, size: 18), label: const Text('Cambiar')),
                    TextButton(onPressed: cerrar, child: const Text('Cerrar búsqueda')),
                  ]),
                ]),
              ),
              const SizedBox(height: 10),
              ...switch (interesados) {
                AsyncData(:final value) => value.isEmpty
                    ? [Text('Cuando a un preparador le interese, aparecerá aquí con su contacto y te llegará un aviso.', style: context.textos.labelSmall)]
                    : [
                        Subtitulo('Les interesa prepararte (${value.length})'),
                        for (final i in value) _TarjetaInteresado(interesado: i, busqueda: b),
                      ],
                _ => [const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()))],
              },
            ],
            // ------------------------------------------- Con plazas libres
            const TituloSeccion('Preparadores que admiten alumnos'),
            ...switch (conPlazas) {
              AsyncData(:final value) => value.isEmpty
                  ? [Text('Ningún preparador verificado ha dicho que admita alumnos nuevos por ahora. Puedes mirar el directorio completo y escribirles igualmente.', style: context.textos.bodySmall)]
                  : [
                      if (b == null) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('Cuenta lo que buscas y se ordenarán por lo que encajan contigo.', style: context.textos.labelSmall)),
                      for (final (v, p, c) in value) _TarjetaConPlazas(v: v, plazas: p, compat: c),
                    ],
              AsyncError() => [Text('No se ha podido cargar. Desliza hacia abajo para reintentarlo.', style: context.textos.bodySmall)],
              _ => [const Center(child: Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()))],
            },
            const SizedBox(height: 8),
            FilaEnlace(icono: Icons.badge_outlined, titulo: 'Todos los preparadores verificados', subtitulo: 'Quiénes son, qué ejercicios preparan y su LinkedIn', onTap: () => ir(const DirectorioPage())),
            const SizedBox(height: 6),
            Text('Cuando os hayáis puesto de acuerdo, el preparador te da su código de seis caracteres y lo escribes en Mi preparador: desde entonces ve tus temas y tus cantes y te programa las clases.', style: context.textos.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _TarjetaConPlazas extends StatelessWidget {
  const _TarjetaConPlazas({required this.v, required this.plazas, required this.compat});
  final PreparadorVerificado v;
  final Plazas plazas;
  final int compat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v.nombre, style: context.textos.titleMedium),
                if (v.ejercicios.isNotEmpty) Text('Prepara el ${v.descripcionEjercicios} ejercicio', style: context.textos.labelSmall),
                if (v.descripcionModalidad.isNotEmpty) Text(v.descripcionModalidad, style: context.textos.labelSmall),
                Text(plazas.desde == null ? 'Admite alumnos ya' : 'Admite alumnos desde ${_mes(plazas.desde!)}', style: context.textos.labelMedium?.copyWith(color: Paleta.acierto)),
                if (plazas.disponibilidad.isNotEmpty) TextoDisponibilidad(plazas.disponibilidad),
                if (plazas.mensaje.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(plazas.mensaje, style: context.textos.bodySmall)),
              ]),
            ),
            if (compat >= 0) Padding(padding: const EdgeInsets.only(left: 8), child: Compatibilidad(compat)),
          ]),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: [
            if (plazas.telefono.isNotEmpty) BotonWhatsApp(telefono: plazas.telefono, texto: 'Escribirle', mensaje: 'Hola, ${v.nombre}. He visto en la app Oposición ${Oposiciones.actual.siglas} que admites alumnos y me interesaría hablar contigo.'),
            if (v.linkedin.isNotEmpty) BotonLinkedin(url: v.linkedin),
            if (plazas.telefono.isEmpty && v.linkedin.isEmpty) Text('Sin contacto publicado: pídeselo a otro preparador o búscale en la red.', style: context.textos.labelSmall),
          ]),
        ]),
      ),
    );
  }
}

class _TarjetaInteresado extends ConsumerWidget {
  const _TarjetaInteresado({required this.interesado, required this.busqueda});
  final Interesado interesado;
  final Busqueda busqueda;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final i = interesado;
    final v = (ref.watch(verificadosProvider).valueOrNull ?? const <PreparadorVerificado>[]).where((x) => x.uid == i.uid).firstOrNull;
    final linkedin = i.linkedin.isNotEmpty ? i.linkedin : (v?.linkedin ?? '');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            PuntoPersona(i.uid, tamano: 12),
            const SizedBox(width: 10),
            Expanded(child: Text(i.nombre.isEmpty ? 'Un preparador' : i.nombre, style: context.textos.titleMedium)),
            if (v != null) Compatibilidad(compatibilidad(busqueda, v), tamano: 44),
          ]),
          if (v != null && v.ejercicios.isNotEmpty) Text('Prepara el ${v.descripcionEjercicios} ejercicio${v.descripcionModalidad.isEmpty ? '' : ' · ${v.descripcionModalidad}'}', style: context.textos.labelSmall),
          if (i.mensaje.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('«${i.mensaje}»', style: context.textos.bodySmall)),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 6, children: [
            if (i.telefono.isNotEmpty) BotonWhatsApp(telefono: i.telefono, texto: 'Escribirle', mensaje: 'Hola, ${i.nombre}. Soy el opositor de la búsqueda de la app Oposición ${Oposiciones.actual.siglas} que te ha interesado.'),
            if (linkedin.isNotEmpty) BotonLinkedin(url: linkedin),
            TextButton(
              onPressed: () async {
                try {
                  await ref.read(redRepoProvider).retirarInteres(busqueda.id);
                } catch (_) {}
                ref.invalidate(interesadosProvider(busqueda.id));
              },
              child: const Text('Quitar'),
            ),
          ]),
        ]),
      ),
    );
  }
}

String _mes(DateTime d) => const ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'][d.month - 1] + (d.year != DateTime.now().year ? ' de ${d.year}' : '');

/// Lo que busca el opositor: se publica sin nombre ni teléfono.
class BusquedaFormPage extends ConsumerStatefulWidget {
  const BusquedaFormPage({super.key, this.busqueda});
  final Busqueda? busqueda;
  @override
  ConsumerState<BusquedaFormPage> createState() => _BusquedaFormPageState();
}

class _BusquedaFormPageState extends ConsumerState<BusquedaFormPage> {
  late final Set<int> _ejercicios = {...widget.busqueda?.ejercicios ?? [Oposiciones.actual.primerConTemas]};
  late Modalidad _modalidad = widget.busqueda?.modalidad ?? Modalidad.sinIndicar;
  late final _ciudad = TextEditingController(text: widget.busqueda?.ciudad ?? '');
  late Set<String> _disponibilidad = {...widget.busqueda?.disponibilidad ?? const []};
  late int _clases = widget.busqueda?.clasesPorSemana ?? 1;
  late DateTime? _desde = widget.busqueda?.desde;
  late final _nota = TextEditingController(text: widget.busqueda?.nota ?? '');
  bool _guardando = false;

  @override
  void dispose() {
    _ciudad.dispose();
    _nota.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    if (_ejercicios.isEmpty) {
      messenger.showSnackBar(const SnackBar(content: Text('Elige al menos un ejercicio.')));
      return;
    }
    final red = ref.read(redRepoProvider);
    final temas = ref.read(ajustesProvider).temasEstudiados.length;
    final b = (widget.busqueda ?? Busqueda(id: 'bq_${nuevoId()}', alumno: red.uid ?? '', creada: DateTime.now())).copyWith(
      ejercicios: _ejercicios.toList()..sort(),
      modalidad: _modalidad,
      ciudad: _modalidad == Modalidad.online ? '' : _ciudad.text.trim(),
      disponibilidad: _disponibilidad.toList()..sort(),
      clasesPorSemana: _clases,
      temas: temas,
      desde: _desde,
      cuantoAntes: _desde == null,
      nota: _nota.text.trim(),
      estado: 'abierta',
    );
    setState(() => _guardando = true);
    try {
      await red.guardarBusqueda(b);
      ref.invalidate(miBusquedaProvider);
      ref.invalidate(preparadoresConPlazasProvider);
      messenger.showSnackBar(const SnackBar(content: Text('Publicada. Los preparadores a los que les interese te dejarán su contacto aquí.')));
      nav.pop();
    } on ErrorRed catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.mensaje)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo publicar: $e')));
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraWeb(
        title: const Text('Lo que buscas'),
        actions: [TextButton(onPressed: _guardando ? null : _guardar, child: const Text('Publicar'))],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Text('Lo verán los preparadores verificados de ${Oposiciones.actual.siglas}, sin tu nombre ni tu teléfono. Los que tengan hueco y les encaje te dejarán su contacto, y decides tú a quién escribes.', style: context.textos.bodySmall),
          const TituloSeccion('Qué ejercicio'),
          Wrap(spacing: 6, runSpacing: 6, children: [
            for (final e in ejerciciosPreparables)
              FilterChip(label: Text(etiquetaEjercicioCante(e)), selected: _ejercicios.contains(e), onSelected: (v) => setState(() => v ? _ejercicios.add(e) : _ejercicios.remove(e))),
          ]),
          const TituloSeccion('Online o presencial'),
          SegmentedButton<Modalidad>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: Modalidad.sinIndicar, label: Text('Me da igual')),
              ButtonSegment(value: Modalidad.online, label: Text('Online')),
              ButtonSegment(value: Modalidad.presencial, label: Text('Presencial')),
            ],
            selected: {_modalidad},
            onSelectionChanged: (s) => setState(() => _modalidad = s.first),
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
          if (_modalidad != Modalidad.online) ...[
            const SizedBox(height: 10),
            TextField(controller: _ciudad, maxLength: 60, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Ciudad (si es presencial)', hintText: 'Madrid', counterText: '')),
          ],
          const TituloSeccion('Cuándo puedes'),
          Text('Marca los tramos de la semana en los que podrías dar clase. Sirve para ordenar a los preparadores por lo que encajan contigo.', style: context.textos.labelSmall),
          const SizedBox(height: 8),
          SelectorDisponibilidad(claves: _disponibilidad, onCambio: (v) => setState(() => _disponibilidad = v)),
          const TituloSeccion('Ritmo'),
          Row(children: [
            Text('Clases por semana:', style: context.textos.labelMedium),
            const SizedBox(width: 10),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [ButtonSegment(value: 1, label: Text('1')), ButtonSegment(value: 2, label: Text('2')), ButtonSegment(value: 3, label: Text('3 o más'))],
              selected: {_clases.clamp(1, 3)},
              onSelectionChanged: (s) => setState(() => _clases = s.first),
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
          ]),
          const TituloSeccion('Desde cuándo'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.event_outlined),
              title: Text(_desde == null ? 'Cuanto antes' : 'Desde ${_mes(_desde!)}', style: context.textos.titleSmall),
              subtitle: Text('Si piensas empezar dentro de unos meses, dilo: así encajas con quien tenga hueco entonces.', style: context.textos.labelSmall),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final r = await elegirMesInicio(context, actual: _desde);
                if (r != null) setState(() => _desde = r.$1);
              },
            ),
          ),
          const TituloSeccion('Cuéntales algo (opcional)'),
          TextField(controller: _nota, minLines: 2, maxLines: 5, maxLength: 1000, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(hintText: 'Qué vuelta llevas, cómo te gustaría trabajar, si has tenido preparador antes…')),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: _guardando ? null : _guardar, icon: const Icon(Icons.campaign_outlined), label: Text(widget.busqueda == null ? 'Publicar' : 'Guardar')),
        ],
      ),
    );
  }
}
