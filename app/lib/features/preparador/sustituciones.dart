import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/red.dart';
import '../../data/models/temario.dart';
import '../../data/repos/red_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../plan/cantes_util.dart';
import 'red_widgets.dart';
import 'sesion_page.dart';

String _cuando(DateTime f) => DateFormat("EEEE d 'de' MMMM 'a las' HH:mm", 'es').format(f);

// ===================================================================== Alumno

/// El alumno pide que otro preparador le coja un cante. Sale de un cante de su
/// agenda ([cante]) o desde cero. Los preparadores ven día, hora, duración,
/// ejercicio, temas y notas; el nombre y el teléfono, solo quien lo coja.
class PedirSustitucionPage extends ConsumerStatefulWidget {
  const PedirSustitucionPage({super.key, this.cante});
  final Cante? cante;
  @override
  ConsumerState<PedirSustitucionPage> createState() => _PedirSustitucionPageState();
}

class _PedirSustitucionPageState extends ConsumerState<PedirSustitucionPage> {
  late DateTime _fecha = widget.cante?.fecha ?? DateTime.now().add(const Duration(days: 1));
  late int _minutos = widget.cante?.minutos ?? 30;
  late int _ejercicio = widget.cante?.ejercicio == 0 ? 3 : (widget.cante?.ejercicio ?? 3);
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

  List<String> _temas(Temario? temario) {
    if (temario == null) return const [];
    final c = widget.cante;
    final base = c ?? Cante(id: '', fecha: _fecha, ejercicio: _ejercicio, bolsa: TipoBolsa.estudiados);
    return temasDeCante(base.copyWith(ejercicio: _ejercicio), temario, ref.read(ajustesProvider)).map((t) => t.codigo).toList();
  }

  Future<void> _enviar(List<String> temas) async {
    final messenger = ScaffoldMessenger.of(context);
    final nav = Navigator.of(context);
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
        fecha: _fecha,
        minutos: _minutos,
        ejercicio: _ejercicio,
        temas: temas,
        notas: _notas.text.trim(),
        paraTodos: _todos,
        destinatarios: _todos ? const [] : _elegidos.toList(),
        cante: widget.cante?.id,
        creada: DateTime.now(),
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
    final temario = ref.watch(temarioProvider).value;
    final temas = _temas(temario);
    final verificados = (ref.watch(verificadosProvider).value ?? const <PreparadorVerificado>[]).where((v) => v.uid != ref.read(redRepoProvider).uid).toList();
    final ordenados = [...verificados]..sort((a, b) => (b.ejercicios.contains(_ejercicio) ? 1 : 0) - (a.ejercicios.contains(_ejercicio) ? 1 : 0));

    return Scaffold(
      appBar: BarraWeb(title: const Text('Buscar preparador')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Text('Otros preparadores verificados verán el día, la hora y los temas que entran. Tu nombre y tu teléfono solo los verá quien lo coja, para que os escribáis por WhatsApp.', style: context.textos.bodySmall),
          const TituloSeccion('El cante'),
          Tarjeta(
            padding: EdgeInsets.zero,
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.event),
                title: Text(_cuando(_fecha)),
                trailing: const Icon(Icons.edit_outlined, size: 18),
                onTap: () async {
                  final d = await showDatePicker(context: context, initialDate: _fecha, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                  if (d == null || !context.mounted) return;
                  final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_fecha));
                  if (t != null) setState(() => _fecha = DateTime(d.year, d.month, d.day, t.hour, t.minute));
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: const Text('Duración'),
                trailing: DropdownButton<int>(
                  value: [30, 45, 60, 90].contains(_minutos) ? _minutos : 30,
                  underline: const SizedBox(),
                  items: const [30, 45, 60, 90].map((m) => DropdownMenuItem(value: m, child: Text('$m min'))).toList(),
                  onChanged: (v) => setState(() => _minutos = v ?? _minutos),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Ejercicio'),
                trailing: SegmentedButton<int>(
                  showSelectedIcon: false,
                  segments: const [ButtonSegment(value: 3, label: Text('3.º')), ButtonSegment(value: 4, label: Text('4.º')), ButtonSegment(value: 5, label: Text('5.º'))],
                  selected: {_ejercicio},
                  onSelectionChanged: widget.cante?.bolsa == TipoBolsa.lista ? null : (s) => setState(() => _ejercicio = s.first),
                  style: const ButtonStyle(visualDensity: VisualDensity.compact),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 8),
          Text(temas.isEmpty ? 'No hay temas en la bolsa: marca temas como estudiados o elige un cante con lista.' : 'Entran ${temas.length} temas: ${temas.take(12).join(', ')}${temas.length > 12 ? '…' : ''}', style: context.textos.labelSmall),
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
                  ),
            ]),
          ),
          const TituloSeccion('Tu contacto'),
          TextField(controller: _nombre, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nombre')),
          const SizedBox(height: 10),
          TextField(controller: _telefono, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Teléfono (WhatsApp)', helperText: 'Solo lo verá el preparador que coja el cante')),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _enviando || temas.isEmpty ? null : () => _enviar(temas),
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
            Expanded(child: Text(_cuando(s.fecha), style: context.textos.titleSmall)),
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
          Text('${s.minutos} min · ${s.ejercicio}.º ejercicio · ${s.temas.length} temas · ${s.paraTodos ? 'a todos' : 'a ${s.destinatarios.length} preparadores'}', style: context.textos.labelSmall),
          if (s.cogida)
            FutureBuilder<ContactoRed?>(
              future: red.contacto(s.id, 'preparador'),
              builder: (_, snap) {
                final c = snap.data;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Te lo coge ${c?.nombre ?? s.cogidaPorNombre}${c == null ? '' : ' · ${c.telefono}'}', style: context.textos.bodyMedium),
                    if (c != null) Padding(padding: const EdgeInsets.only(top: 6), child: BotonWhatsApp(telefono: c.telefono, mensaje: 'Hola, ${c.nombre}. Soy ${ref.read(usuarioActualProvider)?.displayName ?? ''}: gracias por cogerme el cante del ${_cuando(s.fecha)}.')),
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
        content: Text('${_cuando(s.fecha)} · ${s.minutos} min.\n\nAl cogerlo verás el nombre y el teléfono del alumno, y él verá los tuyos para que habléis por WhatsApp. El cante pasará a tu semana.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Lo cojo')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    var telefono = perfil.telefono;
    if (telefonoWhatsApp(telefono) == null) {
      final t = await pedirTelefono(context, inicial: telefono, explicacion: 'El alumno lo recibirá para escribirte por WhatsApp. Se guarda en tus ajustes de preparador.');
      if (t == null) return;
      telefono = t;
      await ref.read(perfilPreparadorProvider.notifier).guardar(perfil.copyWith(telefono: t));
    }
    try {
      final nombre = perfil.nombre.isNotEmpty ? perfil.nombre : (ref.read(usuarioActualProvider)?.displayName ?? '');
      final alumno = await ref.read(redRepoProvider).coger(s, ContactoRed(nombre: nombre, telefono: telefono));
      await ref.read(preparadorRepoProvider).sesionDeSustitucion(s, alumno);
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
    final cogidas = (ref.watch(cogidasPorMiProvider).value ?? const <Sustitucion>[]).where((s) => s.vigente()).toList();
    final temario = ref.watch(temarioProvider).value;
    final estructura = ref.watch(estructuraProvider).value;
    final sesiones = ref.watch(sesionesProvider);

    return Scaffold(
      appBar: BarraWeb(title: const Text('Sustituciones')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(tablonProvider);
          ref.invalidate(cogidasPorMiProvider);
        },
        child: ListView(
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
                          Text(_cuando(s.fecha), style: context.textos.titleMedium),
                          Text('${s.minutos} min · ${s.ejercicio}.º ejercicio · ${s.temas.length} temas${s.paraTodos ? '' : ' · enviada a ti'}', style: context.textos.labelSmall),
                          if (sesiones.any((x) => !x.cancelado && !x.borrado && seSolapan(x.fecha, x.fecha.add(Duration(minutes: x.minutos)), s.fecha, s.fecha.add(Duration(minutes: s.minutos)))))
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text('Ojo: tienes otra sesión a esa hora.', style: context.textos.labelSmall?.copyWith(color: context.esquema.error)),
                            ),
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
                      title: Text(_cuando(s.fecha), style: context.textos.titleSmall),
                      subtitle: Text('${s.minutos} min · ${s.temas.length} temas', style: context.textos.labelSmall),
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
