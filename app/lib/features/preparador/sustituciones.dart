import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../data/models/temario.dart';
import '../../data/repos/red_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import '../../widgets/selector_temas.dart';
import 'directorio_page.dart';
import 'red_widgets.dart';
import 'sesion_page.dart';

String _cuando(DateTime f) => DateFormat("EEEE d 'de' MMMM 'a las' HH:mm", 'es').format(f);

/// «martes 6 de octubre, de 16:00 a 21:00» (o «a las 18:00» si es hora fija o ya se acordó).
String cuandoSustitucion(Sustitucion s) => '${DateFormat("EEEE d 'de' MMMM", 'es').format(s.inicio)}, ${horasDe(s)}';

// ===================================================================== Alumno

/// El alumno pide que otro preparador le coja un cante. Sale de un cante de su
/// agenda ([cante]) o desde cero. El alumno da un día y una franja de horas
/// (o una hora fija) y elige los temas que lleva. Los preparadores ven día,
/// horas, ejercicio, temas y notas; el nombre y el teléfono, solo quien lo coja.
class PedirSustitucionPage extends ConsumerStatefulWidget {
  const PedirSustitucionPage({super.key, this.cante});
  final Cante? cante;
  @override
  ConsumerState<PedirSustitucionPage> createState() => _PedirSustitucionPageState();
}

class _PedirSustitucionPageState extends ConsumerState<PedirSustitucionPage> {
  // Día y horas en las que el alumno puede. Por defecto, una franja de tarde.
  late DateTime _dia = widget.cante?.fecha ?? DateTime.now().add(const Duration(days: 1));
  late TimeOfDay _desde = widget.cante == null ? const TimeOfDay(hour: 16, minute: 0) : TimeOfDay.fromDateTime(widget.cante!.fecha);
  late TimeOfDay _hasta = TimeOfDay(hour: (_desde.hour + 4).clamp(0, 23), minute: _desde.minute);
  bool _franja = true;
  /// Temas elegidos a mano (null = los de la bolsa del cante o los estudiados).
  List<String>? _elegidosTemas;
  // Ejercicios con cante (en TCEE, 1.º —coyuntura—, 3.º y 4.º; el 5.º no se canta).
  late int _ejercicio = ejerciciosConCante.contains(widget.cante?.ejercicio) ? widget.cante!.ejercicio : Oposiciones.actual.primerConTemas;
  bool get _dictamen => Oposiciones.actual.esDictamen(_ejercicio);
  /// Presencial, online o le da igual (sin indicar); por defecto, la del cante.
  late Modalidad _modalidad = widget.cante?.modalidad ?? Modalidad.sinIndicar;
  late final _notas = TextEditingController(text: widget.cante?.notas ?? '');
  late final _nombre = TextEditingController(text: ref.read(usuarioActualProvider)?.displayName ?? '');
  late final _telefono = TextEditingController(text: ref.read(planProvider).telefono);
  bool _todos = true;
  final _elegidos = <String>{};
  bool _enviando = false;

  @override
  void dispose() {
    _notas.dispose();
    _nombre.dispose();
    _telefono.dispose();
    super.dispose();
  }

  DateTime _en(TimeOfDay t) => DateTime(_dia.year, _dia.month, _dia.day, t.hour, t.minute);

  List<String> _temas(Temario? temario) {
    if (temario == null || _dictamen) return const [];
    if (_elegidosTemas != null) return _elegidosTemas!;
    final c = widget.cante;
    final base = c ?? Cante(id: '', fecha: _dia, ejercicio: _ejercicio, bolsa: TipoBolsa.estudiados);
    return temasDeCante(base.copyWith(ejercicio: _ejercicio), temario, ref.read(ajustesProvider)).map((t) => t.codigo).toList();
  }

  Future<void> _enviar(List<String> temas) async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
    if (_franja && !_en(_hasta).isAfter(_en(_desde))) {
      messenger.showSnackBar(const SnackBar(content: Text('La hora final de la franja tiene que ser posterior a la inicial.')));
      return;
    }
    if (!_en(_desde).isAfter(DateTime.now()) && !(_franja && _en(_hasta).isAfter(DateTime.now()))) {
      messenger.showSnackBar(const SnackBar(content: Text('Elige un día y una hora que no hayan pasado.')));
      return;
    }
    if (!_todos && _elegidos.isEmpty) {
      messenger.showSnackBar(const SnackBar(content: Text('Elige al menos un preparador o envíala a todos.')));
      return;
    }
    setState(() => _enviando = true);
    try {
      final red = ref.read(redRepoProvider);
      final s = Sustitucion(
        id: nuevoId(),
        alumno: red.uid ?? '',
        fecha: _en(_desde),
        hasta: _franja ? _en(_hasta) : null,
        minutos: widget.cante?.minutos ?? 30,
        ejercicio: _ejercicio,
        temas: temas,
        notas: _notas.text.trim(),
        paraTodos: _todos,
        destinatarios: _todos ? const [] : _elegidos.toList(),
        cante: widget.cante?.id,
        creada: DateTime.now(),
        modalidad: _modalidad,
      );
      await red.publicarSustitucion(s, ContactoRed(nombre: _nombre.text.trim(), telefono: _telefono.text.trim()));
      // El teléfono se recuerda para la próxima vez (solo en tu cuenta).
      await ref.read(planProvider.notifier).actualizar((p) => p.copyWith(telefono: _telefono.text.trim()));
      ref.invalidate(misPeticionesProvider);
      messenger.showSnackBar(const SnackBar(content: Text('Petición enviada. Te avisaremos en cuanto alguien la coja.')));
      nav.pop();
    } on ErrorRed catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.mensaje)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo enviar: $e')));
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temario = ref.watch(temarioProvider).valueOrNull;
    final temas = _temas(temario);
    final verificados = (ref.watch(verificadosProvider).valueOrNull ?? const <PreparadorVerificado>[]).where((v) => v.uid != ref.read(redRepoProvider).uid).toList();
    final ordenados = [...verificados]..sort((a, b) => (b.ejercicios.contains(_ejercicio) ? 1 : 0) - (a.ejercicios.contains(_ejercicio) ? 1 : 0));

    return Scaffold(
      appBar: BarraWeb(title: const Text('Buscar preparador')),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Text('Otros preparadores verificados verán el día, la hora y los temas que entran. Tu nombre y tu teléfono solo los verá quien lo coja, para que os escribáis por WhatsApp.', style: context.textos.bodySmall),
          const TituloSeccion('El cante'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.event),
                title: Text(DateFormat("EEEE d 'de' MMMM", 'es').format(_dia)),
                trailing: const Icon(Icons.edit_outlined, size: 18),
                onTap: () async {
                  final d = await showDatePicker(context: context, initialDate: _dia.isBefore(DateTime.now()) ? DateTime.now() : _dia, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (d != null) setState(() => _dia = d);
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: SegmentedButton<bool>(
                  showSelectedIcon: false,
                  segments: const [ButtonSegment(value: true, label: Text('Franja de horas')), ButtonSegment(value: false, label: Text('Hora fija'))],
                  selected: {_franja},
                  onSelectionChanged: (v) => setState(() => _franja = v.first),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 6, children: [
                  Text(_franja ? 'Desde' : 'A las'),
                  ActionChip(
                    label: Text(_desde.format(context)),
                    onPressed: () async {
                      final t = await showTimePicker(context: context, initialTime: _desde);
                      if (t != null) setState(() => _desde = t);
                    },
                  ),
                  if (_franja) ...[
                    const Text('hasta'),
                    ActionChip(
                      label: Text(_hasta.format(context)),
                      onPressed: () async {
                        final t = await showTimePicker(context: context, initialTime: _hasta);
                        if (t != null) setState(() => _hasta = t);
                      },
                    ),
                  ],
                ]),
                subtitle: Text(_franja ? 'Quien lo coja elegirá la hora dentro de la franja.' : 'El cante sería justo a esa hora.', style: context.textos.labelSmall),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Ejercicio'),
                trailing: SegmentedButton<int>(
                  showSelectedIcon: false,
                  segments: segmentosEjercicio(),
                  selected: {_ejercicio},
                  onSelectionChanged: (s) => setState(() {
                    _ejercicio = s.first;
                    _elegidosTemas = null;
                  }),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ),
              ListTile(
                leading: Icon(_modalidad == Modalidad.online ? Icons.videocam_outlined : Icons.place_outlined),
                title: const Text('Cómo'),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_modalidad == Modalidad.sinIndicar ? 'Me da igual: presencial u online' : (_modalidad == Modalidad.online ? 'Online: así puede cogerlo alguien de otra ciudad' : 'Presencial'), style: context.textos.labelSmall),
                  const SizedBox(height: 6),
                  SegmentedButton<Modalidad>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: Modalidad.presencial, label: Text('Presencial')),
                    ButtonSegment(value: Modalidad.online, label: Text('Online')),
                    ButtonSegment(value: Modalidad.sinIndicar, label: Text('Igual')),
                  ],
                  selected: {_modalidad},
                  onSelectionChanged: (s) => setState(() => _modalidad = s.first),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
                ]),
              ),
            ]),
          ),
          TituloSeccion(
            _dictamen ? 'Qué se canta' : 'Temas que llevas (${temas.length})',
            accion: _dictamen || temario == null
                ? null
                : TextButton.icon(
                    icon: const Icon(Icons.checklist, size: 18),
                    label: const Text('Elegir'),
                    onPressed: () async {
                      final r = await elegirTemas(context, temario: temario, seleccion: temas, ejercicios: {_ejercicio}, titulo: 'Temas que llevas');
                      if (r != null) setState(() => _elegidosTemas = r);
                    },
                  ),
          ),
          if (_dictamen)
            Text('${Oposiciones.actual.avisoDictamen(_ejercicio)} No hay temas que sortear.', style: context.textos.bodySmall)
          else if (temas.isEmpty)
            Text('Ninguno: toca «Elegir» para marcar los temas que llevas para este cante.', style: context.textos.bodySmall)
          else
            Wrap(spacing: 4, runSpacing: 4, children: [
              for (final c in temas) CasillaCodigo(codigo: c, color: ref.watch(estructuraProvider).valueOrNull?.colorDe(c), titulo: temario?.tema(c)?.titulo),
            ]),
          if (_elegidosTemas == null && temas.isNotEmpty && _ejercicio != 1)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(widget.cante != null ? 'Son los del cante. Puedes cambiarlos.' : 'Son los que tienes marcados como estudiados. Puedes cambiarlos.', style: context.textos.labelSmall),
            ),
          const SizedBox(height: 10),
          TextField(controller: _notas, maxLines: 2, decoration: const InputDecoration(labelText: 'Nota para el preparador (opcional)', hintText: 'Online o presencial, qué quieres trabajar…')),
          const TituloSeccion('A quién'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              RadioGroup<bool>(
                groupValue: _todos,
                onChanged: (v) => setState(() => _todos = v ?? true),
                child: Column(children: [
                  RadioListTile<bool>(value: true, title: Text('A todos los preparadores verificados (${verificados.length})')),
                  const RadioListTile<bool>(value: false, title: Text('Solo a los que elija')),
                ]),
              ),
              if (!_todos)
                for (final v in ordenados)
                  CheckboxListTile(
                    dense: true,
                    value: _elegidos.contains(v.uid),
                    onChanged: (x) => setState(() => x == true ? _elegidos.add(v.uid) : _elegidos.remove(v.uid)),
                    title: Text(v.nombre),
                    subtitle: Text(v.descripcionEjercicios, style: context.textos.labelSmall),
                    secondary: v.linkedin.isEmpty ? null : BotonLinkedin(url: v.linkedin, compacto: true),
                  ),
            ]),
          ),
          const TituloSeccion('Tu contacto'),
          TextField(controller: _nombre, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nombre')),
          const SizedBox(height: 10),
          TextField(controller: _telefono, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Teléfono (WhatsApp)', helperText: 'Solo lo verá el preparador que coja el cante')),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _enviando || (temas.isEmpty && _ejercicio != 1) ? null : () => _enviar(temas),
            icon: const Icon(Icons.campaign_outlined),
            label: Text(_enviando ? 'Enviando…' : 'Enviar la petición'),
          ),
        ],
      ),
    );
  }
}

/// Petición del alumno con su estado y, si la han cogido, el contacto del sustituto.
class FilaMiPeticion extends ConsumerWidget {
  const FilaMiPeticion({super.key, required this.peticion});
  final Sustitucion peticion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = peticion;
    final red = ref.read(redRepoProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        color: s.cogida ? context.colores.primarioPalido : null,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(cuandoSustitucion(s), style: context.textos.titleSmall)),
            Etiqueta(
              switch (s.estado) {
                EstadoSustitucion.abierta => 'Buscando',
                EstadoSustitucion.cogida => 'Cogido',
                EstadoSustitucion.cancelada => 'Retirada',
              },
              color: switch (s.estado) {
                EstadoSustitucion.abierta => context.colores.dorado,
                EstadoSustitucion.cogida => Paleta.acierto,
                EstadoSustitucion.cancelada => context.colores.textoClaro,
              },
            ),
          ]),
          Text('${s.descripcion} · ${s.paraTodos ? 'a todos' : 'a ${s.destinatarios.length} preparadores'}', style: context.textos.labelSmall),
          if (s.cogida)
            FutureBuilder<ContactoRed?>(
              future: red.contacto(s.id, 'preparador'),
              builder: (_, snap) {
                final c = snap.data;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Te lo coge ${c?.nombre ?? s.cogidaPorNombre}${c == null ? '' : ' · ${c.telefono}'}', style: context.textos.bodyMedium),
                    if (c != null) Padding(padding: const EdgeInsets.only(top: 6), child: BotonWhatsApp(telefono: c.telefono, mensaje: 'Hola, ${c.nombre}. Soy ${ref.read(usuarioActualProvider)?.displayName ?? ''}: gracias por cogerme el cante del ${_cuando(s.inicio)}.')),
                  ]),
                );
              },
            ),
          if (s.abierta && s.vigente())
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await red.cancelarSustitucion(s);
                  ref.invalidate(misPeticionesProvider);
                },
                child: const Text('Retirar'),
              ),
            ),
        ]),
      ),
    );
  }
}

// ================================================================= Preparador

/// Tablón: peticiones abiertas dirigidas al preparador (o a todos) y las que ha cogido.
class TablonPage extends ConsumerWidget {
  const TablonPage({super.key});

  Future<void> _coger(BuildContext context, WidgetRef ref, Sustitucion s) async {
    final messenger = ScaffoldMessenger.of(context);
    final perfil = ref.read(perfilPreparadorProvider);
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('¿Coges este cante?'),
        content: Text('${cuandoSustitucion(s)}.\n\nAl cogerlo verás el nombre y el teléfono del alumno, y él verá los tuyos para que habléis por WhatsApp. El cante pasará a tu semana.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Lo cojo')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    // Con franja, el preparador elige a qué hora lo da.
    var hora = s.fecha;
    if (s.conFranja) {
      final elegida = await elegirHoraEnFranja(context, s);
      if (elegida == null || !context.mounted) return;
      hora = elegida;
    }
    var telefono = perfil.telefono;
    if (telefonoWhatsApp(telefono) == null) {
      final t = await pedirTelefono(context, inicial: telefono, explicacion: 'El alumno lo recibirá para escribirte por WhatsApp. Se guarda en tus ajustes de preparador.');
      if (t == null) return;
      telefono = t;
      await ref.read(perfilPreparadorProvider.notifier).guardar(perfil.copyWith(telefono: t));
    }
    try {
      final nombre = perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? '');
      final alumno = await ref.read(redRepoProvider).coger(s, ContactoRed(nombre: nombre, telefono: telefono), hora: hora);
      await ref.read(preparadorRepoProvider).sesionDeSustitucion(Sustitucion.fromJson({...s.toJson(), 'hora': hora.toIso8601String()}), alumno);
      ref.invalidate(sesionesProvider);
      ref.invalidate(alumnosProvider);
      ref.invalidate(tablonProvider);
      ref.invalidate(cogidasPorMiProvider);
      messenger.showSnackBar(SnackBar(content: Text('Es tuyo. ${alumno.nombre} ya tiene tu contacto.')));
    } on ErrorRed catch (e) {
      ref.invalidate(tablonProvider);
      messenger.showSnackBar(SnackBar(content: Text(e.mensaje)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('No se pudo coger: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tablon = ref.watch(tablonProvider);
    final cogidas = (ref.watch(cogidasPorMiProvider).valueOrNull ?? const <Sustitucion>[]).where((s) => s.vigente()).toList();
    final temario = ref.watch(temarioProvider).valueOrNull;
    final estructura = ref.watch(estructuraProvider).valueOrNull;
    final sesiones = ref.watch(sesionesProvider);

    return Scaffold(
      appBar: BarraWeb(title: const Text('Sustituciones')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(tablonProvider);
          ref.invalidate(cogidasPorMiProvider);
        },
        child: ListaAdaptable(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
          children: [
            Text('Alumnos que buscan quién les coja un cante. No ves su nombre ni su teléfono hasta que lo coges.', style: context.textos.bodySmall),
            const TituloSeccion('Buscan preparador'),
            ...switch (tablon) {
              AsyncData(:final value) when value.isEmpty => [Text('Ahora mismo no hay peticiones.', style: context.textos.bodySmall)],
              AsyncData(:final value) => [
                  for (final s in value)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Tarjeta(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(cuandoSustitucion(s), style: context.textos.titleMedium),
                          Text('${s.descripcion}${s.paraTodos ? '' : ' · enviada a ti'}', style: context.textos.labelSmall),
                          // Lo que el preparador ya tiene ese día dentro de la franja.
                          ...() {
                            final fin = s.hasta ?? s.fecha.add(const Duration(hours: 2));
                            final suyas = sesiones.where((x) => !x.cancelado && !x.borrado && seSolapan(x.fecha, x.fecha.add(Duration(minutes: x.minutos)), s.fecha, fin)).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
                            if (suyas.isEmpty) return const <Widget>[];
                            return [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text('Ese día ya tienes: ${suyas.map((x) => horaDe(x.fecha)).join(', ')}', style: context.textos.labelSmall?.copyWith(color: context.esquema.error)),
                              ),
                            ];
                          }(),
                          if (s.notas.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text(s.notas, style: context.textos.bodyMedium)),
                          const SizedBox(height: 8),
                          Wrap(spacing: 4, runSpacing: 4, children: [
                            for (final c in s.temas.take(30)) CasillaCodigo(codigo: c, color: estructura?.colorDe(c), titulo: temario?.tema(c)?.titulo),
                            if (s.temas.length > 30) Text('+${s.temas.length - 30}', style: context.textos.labelSmall),
                          ]),
                          const SizedBox(height: 10),
                          Align(alignment: Alignment.centerRight, child: FilledButton(onPressed: () => _coger(context, ref, s), child: const Text('Lo cojo'))),
                        ]),
                      ),
                    ),
                ],
              AsyncError() => [Text('No se ha podido cargar el tablón.', style: context.textos.bodySmall)],
              _ => [const Center(child: CircularProgressIndicator())],
            },
            if (cogidas.isNotEmpty) ...[
              const TituloSeccion('Cogidos por ti'),
              for (final s in cogidas)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Tarjeta(
                    padding: EdgeInsets.zero,
                    onTap: sesiones.any((x) => x.id == 'sust_${s.id}') ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SesionPage(id: 'sust_${s.id}'))) : null,
                    child: ListTile(
                      title: Text(cuandoSustitucion(s), style: context.textos.titleSmall),
                      subtitle: Text(s.descripcion, style: context.textos.labelSmall),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Código de un tema con el color de su bloque (con su título al mantener pulsado).
class CasillaCodigo extends StatelessWidget {
  const CasillaCodigo({super.key, required this.codigo, this.color, this.titulo});
  final String codigo;
  final Color? color;
  final String? titulo;
  @override
  Widget build(BuildContext context) => Tooltip(
        message: titulo ?? codigo,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: (color ?? context.esquema.primary).withValues(alpha: 0.18), borderRadius: BorderRadius.circular(4), border: Border.all(color: color ?? context.esquema.primary)),
          child: Text(codigo, style: context.textos.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
        ),
      );
}

/// El preparador elige a qué hora da el cante dentro de la franja del alumno.
Future<DateTime?> elegirHoraEnFranja(BuildContext context, Sustitucion s) async {
  final desde = s.fecha, hasta = s.hasta!;
  final t = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(desde),
    helpText: 'Entre las ${horaDe(desde)} y las ${horaDe(hasta)}',
  );
  if (t == null) return null;
  final h = DateTime(desde.year, desde.month, desde.day, t.hour, t.minute);
  if (h.isBefore(desde) || h.isAfter(hasta)) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tiene que ser entre las ${horaDe(desde)} y las ${horaDe(hasta)}.')));
    return null;
  }
  return h;
}
