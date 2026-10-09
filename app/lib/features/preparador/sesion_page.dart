import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../data/models/temario.dart';
import '../../data/repos/preparador_repo.dart';
import '../../data/repos/usuario_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/cantar_page.dart';
import '../cantar/pizarra_page.dart';
import '../plan/cante_form_page.dart';
import '../plan/cantes_util.dart';
import '../plan/modalidad.dart';
import '../plan/resultado_sheet.dart';
import 'alumno_page.dart';
import 'calendario_google_tarjeta.dart';
import 'red_widgets.dart';
import 'tema_anticipado.dart';

/// Temas que entran en la sesión de un alumno: «los estudiados» son los suyos.
List<Tema> temasDeSesion(Cante sesion, Alumno alumno, Temario temario) => temasDeCante(sesion, temario, Ajustes(temasEstudiados: alumno.temas.toSet()));

/// Envía el informe de un cante al alumno por la app que elija el preparador.
Future<void> enviarInforme(BuildContext context, Cante sesion, Alumno? alumno, Temario? temario) => compartirTexto(
      context,
      informeCante(sesion, alumno: alumno?.nombre, tituloDe: (codigo) => temario?.tema(codigo)?.titulo ?? ''),
      asunto: 'Valoración del cante',
    );

/// Elige un valor entre varios (chips) o uno a medida. Devuelve el elegido, o null.
Future<int?> elegirMinutos(BuildContext context, {required String titulo, required List<int> opciones, required int actual, required String Function(int) etiqueta, int maximo = 240}) {
  return showDialog<int>(
    context: context,
    builder: (d) => AlertDialog(
      title: Text(titulo),
      content: Wrap(spacing: 6, runSpacing: 6, children: [
        for (final m in {...opciones, actual}.toList()..sort()) ChoiceChip(label: Text(etiqueta(m)), selected: m == actual, onSelected: (_) => Navigator.pop(d, m)),
        ActionChip(
          label: const Text('Otra'),
          onPressed: () async {
            final ctrl = TextEditingController(text: '$actual');
            final v = await showDialog<int>(
              context: d,
              builder: (e) => AlertDialog(
                title: Text(titulo),
                content: TextField(controller: ctrl, autofocus: true, keyboardType: TextInputType.number, decoration: const InputDecoration(suffixText: 'min')),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(e), child: const Text('Cancelar')),
                  FilledButton(onPressed: () => Navigator.pop(e, int.tryParse(ctrl.text.trim())), child: const Text('Aceptar')),
                ],
              ),
            );
            if (v != null && v > 0 && v <= maximo && d.mounted) Navigator.pop(d, v);
          },
        ),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar'))],
    ),
  );
}

/// Ficha de una clase del preparador con un alumno: cuándo es, dónde, qué
/// temas entran y cuáles se mandan, y, una vez cantada, la valoración. Todo
/// se cambia desde aquí mismo (día y hora, duración, online o presencial,
/// temas), sin pasar por el formulario.
class SesionPage extends ConsumerWidget {
  const SesionPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(sesionesProvider).where((x) => x.id == id).firstOrNull;
    if (s == null) return Scaffold(appBar: BarraWeb(title: const Text('Clase')), body: const Center(child: Text('Esta clase ya no existe.')));
    final alumnos = ref.watch(alumnosProvider);
    final alumno = alumnos.where((a) => a.id == s.alumno).firstOrNull;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final temas = temario == null || alumno == null ? const <Tema>[] : temasDeSesion(s, alumno, temario);
    final r = s.resultado;
    final notifier = ref.read(sesionesProvider.notifier);
    final repo = ref.read(preparadorRepoProvider);
    final perfil = ref.watch(perfilPreparadorProvider);
    final usuario = ref.watch(usuarioActualProvider);
    final conUid = alumno?.uid != null;
    final ahora = DateTime.now();
    final dictamen = Oposiciones.actual.esDictamen(s.ejercicio);

    Future<void> guardar(Cante nuevo, {String? mensaje}) async {
      final messenger = ScaffoldMessenger.of(context);
      await notifier.guardar(nuevo);
      final estado = repo.estadoCopia(nuevo.id);
      if (mensaje != null || (conUid && estado != EstadoCopia.enviada)) {
        messenger.showSnackBar(SnackBar(content: Text([
          if (mensaje != null) mensaje,
          if (conUid) estado == EstadoCopia.enviada ? 'El alumno ya lo ve en su agenda.' : 'Aún no le ha llegado al alumno: se reintenta al sincronizar.',
        ].join(' '))));
      }
    }

    Future<void> valorar() async {
      final res = await pedirResultadoCante(
        context,
        inicial: r ?? const ResultadoCante(),
        opciones: temas,
        titulo: '¿Cómo ha ido el cante${alumno == null ? '' : ' de ${alumno.nombre}'}?',
        textoGuardar: 'Guardar valoración',
      );
      if (res != null) await notifier.guardar(s.copyWith(estado: EstadoCante.hecho, resultado: res));
    }

    Future<void> borrar() async {
      final nav = Navigator.of(context);
      final enSerie = s.serie != null && s.pendiente;
      final que = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Borrar la clase?'),
          content: Text(enSerie ? 'Esta clase forma parte de una repetición semanal.' : 'Se borrará de tu agenda${conUid ? ' y de la del alumno' : ''}.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            if (enSerie) TextButton(onPressed: () => Navigator.pop(d, 'serie'), child: const Text('Esta y las siguientes')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, 'una'), child: Text(enSerie ? 'Solo esta' : 'Borrar')),
          ],
        ),
      );
      if (que == null) return;
      final aBorrar = que == 'serie' ? ref.read(sesionesProvider).where((x) => x.serie == s.serie && x.alumno == s.alumno && x.pendiente && !x.fecha.isBefore(s.fecha)).toList() : [s];
      for (final x in aBorrar) {
        await notifier.borrar(x);
      }
      nav.pop();
    }

    Future<void> cambiarHora() async {
      final d = await showDatePicker(context: context, initialDate: s.fecha, firstDate: DateTime.now().subtract(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 365)), helpText: 'Nuevo día');
      if (d == null || !context.mounted) return;
      final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(s.fecha), helpText: 'Nueva hora');
      if (t == null) return;
      final nueva = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      final choca = ref.read(sesionesProvider).where((x) => x.id != s.id && !x.cancelado && !x.borrado && seSolapan(x.fecha, x.fecha.add(Duration(minutes: x.minutos)), nueva, nueva.add(Duration(minutes: s.minutos))));
      // El envío del tema, si era relativo a la clase (menos de un día antes), se mueve con ella.
      DateTime? temaA = s.temaA;
      if (s.temaA != null && s.fecha.difference(s.temaA!) < const Duration(hours: 24)) temaA = nueva.subtract(s.fecha.difference(s.temaA!));
      await guardar(
        s.copyWith(fecha: nueva, estado: EstadoCante.pendiente, motivo: '', temaA: temaA),
        mensaje: choca.isEmpty ? 'Cambiada al ${fechaCorta(nueva)}, ${horaDe(nueva)}.' : 'Cambiada, pero se solapa con otra clase de ese día.',
      );
    }

    Future<void> cancelar() async {
      final motivo = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Cancelar la clase?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(conUid ? 'El alumno lo verá en su agenda y recibirá un aviso, con la opción de buscar a otro preparador que se la coja.' : 'Queda marcada como cancelada en tu agenda.'),
            const SizedBox(height: 10),
            TextField(controller: motivo, decoration: const InputDecoration(labelText: 'Motivo (opcional)', hintText: 'Viaje, enfermedad…')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('No')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Cancelar clase')),
          ],
        ),
      );
      if (ok == true) await guardar(s.copyWith(estado: EstadoCante.cancelado, motivo: motivo.text.trim()), mensaje: 'Clase cancelada.');
    }

    Future<void> cambiarDuracion() async {
      final m = await elegirMinutos(context, titulo: 'Duración de la clase', opciones: duracionesClase, actual: s.minutos, etiqueta: textoDuracion);
      if (m != null && m != s.minutos) await guardar(s.copyWith(minutos: m));
    }

    Future<void> cambiarExposicion() async {
      final m = await elegirMinutos(context, titulo: 'Exposición por tema', opciones: duracionesExposicion, actual: s.exposicion, etiqueta: (m) => '$m min', maximo: 120);
      if (m != null && m != s.exposicion) await guardar(s.copyWith(exposicion: m));
    }

    Future<void> cambiarModalidad() async {
      final nuevo = await editarModalidad(context, s, preparador: true);
      if (nuevo != null) await guardar(nuevo);
    }

    Future<void> cambiarTemas() async {
      var n = s.numTemas.clamp(1, 2);
      var unoPorParte = s.unoPorParte;
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => StatefulBuilder(
          builder: (d, set) => AlertDialog(
            title: const Text('Temas que se cantan'),
            content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const [ButtonSegment(value: 1, label: Text('1 tema')), ButtonSegment(value: 2, label: Text('2 temas'))],
                selected: {n},
                onSelectionChanged: (v) => set(() => n = v.first),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Uno de cada parte'),
                subtitle: const Text('Al sortearlos, cada tema de una parte distinta, como en el examen.'),
                value: unoPorParte,
                onChanged: n > 1 ? (v) => set(() => unoPorParte = v) : null,
              ),
            ]),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Guardar')),
            ],
          ),
        ),
      );
      if (ok == true) await guardar(s.copyWith(numTemas: n, unoPorParte: unoPorParte));
    }

    void cantar({bool conMandados = false}) {
      if (alumno == null) return;
      if (conMandados) ref.read(temaParaCantarProvider.notifier).state = s.temasMandados.join(',');
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantarPage(sesion: SesionAlumno(cante: s, alumno: alumno))));
    }

    final estadoCopia = conUid ? repo.estadoCopia(s.id) : null;
    final mandadosLlegados = s.mandaTema && !s.temaA!.isAfter(ahora);

    return Scaffold(
      appBar: BarraWeb(
        title: Text(alumno == null ? 'Clase' : (alumno.suelto ? '${alumno.nombre} · clase suelta' : alumno.nombre)),
        actions: [
          IconButton(tooltip: 'Editar todo', icon: const Icon(Icons.edit_outlined), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(cante: s, alumnos: [...ref.read(misAlumnosProvider), if (alumno != null && alumno.suelto) alumno])))),
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'hora':
                  await cambiarHora();
                case 'cancelar':
                  await cancelar();
                case 'recuperar':
                  await guardar(s.copyWith(estado: EstadoCante.pendiente, motivo: ''), mensaje: 'Clase recuperada.');
                case 'borrar':
                  await borrar();
              }
            },
            itemBuilder: (_) => [
              if (!s.hecho) const PopupMenuItem(value: 'hora', child: Text('Cambiar día u hora')),
              if (s.pendiente) const PopupMenuItem(value: 'cancelar', child: Text('Cancelar clase')),
              if (s.cancelado) const PopupMenuItem(value: 'recuperar', child: Text('Recuperar clase')),
              const PopupMenuItem(value: 'borrar', child: Text('Borrar')),
            ],
          ),
        ],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Tarjeta(
            color: s.pendiente ? context.colores.primarioPalido : null,
            onTap: s.hecho ? null : cambiarHora,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('${fechaLarga(s.fecha)}, ${horaDe(s.fecha)}', style: context.textos.titleMedium)),
                if (s.hecho) const Etiqueta('Valorado', color: Paleta.acierto),
                if (s.cancelado) Etiqueta('Cancelada', color: context.esquema.error),
                if (!s.hecho) Icon(Icons.edit_outlined, size: 18, color: context.colores.textoClaro),
              ]),
              if (s.cancelado && s.motivo.isNotEmpty) Text('Motivo: ${s.motivo}', style: context.textos.bodySmall),
              if (s.pendiente) Text(s.fecha.isAfter(ahora) ? 'Empieza ${cuentaAtras(s.fecha)}' : 'Pendiente de valorar', style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
              Text('${s.titulo.isEmpty ? '' : '${s.titulo} · '}${descripcionBolsa(s)} · ${textoDuracion(s.minutos)}', style: context.textos.bodySmall),
              if (s.notas.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(s.notas, style: context.textos.bodyMedium)),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(spacing: 6, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
                  Etiqueta(
                    switch (estadoCopia) {
                      null => 'Alumno sin app enlazada',
                      EstadoCopia.enviada => alumno!.suelto ? 'Clase suelta: la ve en su agenda (no pasa a tus alumnos salvo que escriba tu código)' : 'El alumno la ve en su agenda',
                      EstadoCopia.sinRed => 'Pendiente de llegar al alumno (sin conexión)',
                      EstadoCopia.sinPermiso => 'No ha llegado al alumno: su app ya no está enlazada contigo',
                      EstadoCopia.otro => 'Pendiente de llegar al alumno',
                    },
                    color: estadoCopia == null ? context.colores.textoClaro : (estadoCopia == EstadoCopia.enviada ? null : context.esquema.error),
                  ),
                  // Apuntado a mano pero ya con la app (sale duplicado): unir las dos fichas.
                  if (alumno != null && alumno.uid == null && alumnos.any((a) => a.enlazado))
                    TextButton(
                      onPressed: () async {
                        final unido = await unirAlumnoDialogo(context, ref, alumno);
                        if (unido != null) ref.invalidate(sesionesProvider);
                      },
                      child: const Text('¿Ya tiene la app? Unir fichas'),
                    ),
                  if (estadoCopia != null && estadoCopia != EstadoCopia.enviada)
                    TextButton(
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final e = await repo.reintentarCopia(s.id);
                        ref.invalidate(sesionesProvider);
                        messenger.showSnackBar(SnackBar(content: Text(e == EstadoCopia.enviada ? 'Ya la tiene el alumno en su agenda.' : 'Sigue sin poder enviarse.')));
                      },
                      child: const Text('Reintentar'),
                    ),
                ]),
              ),
            ]),
          ),
          if (s.modalidad != Modalidad.sinIndicar && !s.cancelado)
            Padding(padding: const EdgeInsets.only(top: 10), child: TarjetaModalidad(cante: s, telefono: alumno?.telefono.isEmpty ?? true ? null : alumno!.telefono, onEditar: s.hecho ? null : cambiarModalidad)),
          if (alumno != null && alumno.telefono.isNotEmpty) ...[
            const SizedBox(height: 10),
            BotonWhatsApp(telefono: alumno.telefono, texto: 'Escribir a ${alumno.nombre}', mensaje: 'Hola, ${alumno.nombre}. Sobre la clase del ${fechaCorta(s.fecha)} a las ${horaDe(s.fecha)}: '),
          ],
          if (s.pendiente) ...[
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: OutlinedButton.icon(onPressed: cambiarHora, icon: const Icon(Icons.schedule, size: 18), label: const Text('Cambiar hora'))),
              const SizedBox(width: 10),
              Expanded(child: OutlinedButton.icon(onPressed: cancelar, icon: Icon(Icons.event_busy, size: 18, color: context.esquema.error), label: Text('Cancelar', style: TextStyle(color: context.esquema.error)))),
            ]),
            const SizedBox(height: 10),
            // En la clase se cantan los temas mandados antes (o se cronometra el
            // dictamen); los temas no se sortean desde aquí.
            Row(children: [
              if (dictamen || mandadosLlegados) ...[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: alumno == null ? null : () => cantar(conMandados: mandadosLlegados),
                    icon: Icon(dictamen ? Icons.timer_outlined : Icons.mic),
                    label: Text(dictamen ? 'Cronometrar' : 'Cantar los temas mandados'),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(onPressed: valorar, child: const Text('Valorar')),
              ] else
                Expanded(child: OutlinedButton.icon(onPressed: valorar, icon: const Icon(Icons.star_outline, size: 18), label: const Text('Valorar la clase'))),
            ]),
          ],
          // Lo principal de la clase: mandarle los temas antes.
          if (!dictamen && s.pendiente && (s.mandaTema || s.fecha.isAfter(ahora))) ...[
            const TituloSeccion('Temas antes de la clase'),
            if (s.sustitucion != null && !conUid) _RecuperarClaseSuelta(id: s.id) else SeccionTemaAnticipado(sesion: s, temas: temas, enlazado: conUid),
            if (temas.isEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text('No hay temas en la bolsa: apunta en la ficha los temas que lleva el alumno o elige una lista.', style: context.textos.labelSmall)),
          ],
          if (conUid && usuario != null && alumno != null) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => abrirPizarra(context, alumnoUid: alumno.uid!, canteId: s.id, otroNombre: alumno.nombre),
              icon: const Icon(Icons.draw_outlined, size: 18),
              label: const Text('Pizarra compartida'),
            ),
          ],
          if (!s.hecho) ...[
            const TituloSeccion('Detalles de la clase'),
            Tarjeta(
              padding: EdgeInsets.zero,
              child: Column(children: [
                FilaEnlace(icono: Icons.event_outlined, titulo: 'Día y hora', subtitulo: '${fechaCorta(s.fecha)}, ${horaDe(s.fecha)}', onTap: cambiarHora),
                FilaEnlace(icono: Icons.timelapse_outlined, titulo: 'Duración de la clase', subtitulo: textoDuracion(s.minutos), onTap: cambiarDuracion),
                FilaEnlace(
                  icono: s.online ? Icons.videocam_outlined : Icons.place_outlined,
                  titulo: 'Presencial u online',
                  subtitulo: s.modalidad == Modalidad.sinIndicar ? 'Sin indicar' : s.descripcionModalidad,
                  onTap: cambiarModalidad,
                ),
                if (!dictamen) ...[
                  FilaEnlace(
                    icono: Icons.format_list_numbered,
                    titulo: 'Temas que se cantan',
                    subtitulo: '${s.numTemas == 1 ? '1 tema' : '${s.numTemas} temas'}${s.unoPorParte && s.numTemas > 1 ? ' · uno de cada parte' : ''}',
                    onTap: cambiarTemas,
                  ),
                  FilaEnlace(icono: Icons.timer_outlined, titulo: 'Exposición por tema', subtitulo: '${s.exposicion} min en el cronómetro', onTap: cambiarExposicion),
                ],
                if (perfil.calendarioGoogle && s.pendiente && s.fecha.isAfter(ahora)) _FilaCalendario(sesion: s),
              ]),
            ),
          ],
          if (s.hecho && r != null) ...[
            TituloSeccion('Valoración', accion: TextButton(onPressed: valorar, child: const Text('Editar'))),
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (r.temaCantado != null) TextoTema(r.temaCantado!, temario?.tema(r.temaCantado!)?.titulo ?? '', color: ref.watch(estructuraProvider).valueOrNull?.colorDe(r.temaCantado!)),
                const SizedBox(height: 6),
                Row(children: [
                  Estrellas(valor: r.valoracion, tamano: 20),
                  const SizedBox(width: 12),
                  if (r.segundos > 0) Text(formatoTiempo(r.segundos), style: context.textos.labelMedium),
                ]),
                if (r.comentarios.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(r.comentarios, style: context.textos.bodyMedium)),
                if (r.sorteados.length > 1) Padding(padding: const EdgeInsets.only(top: 8), child: Text('Salieron: ${r.sorteados.join(', ')}', style: context.textos.labelSmall)),
              ]),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(onPressed: () => enviarInforme(context, s, alumno, temario), icon: const Icon(Icons.ios_share, size: 18), label: const Text('Enviar informe al alumno')),
            if (conUid) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Además, la valoración ya está en su diario de cantes.', textAlign: TextAlign.center, style: context.textos.labelSmall)),
          ],
          if (!dictamen) TituloSeccion('Temas que entran (${temas.length})'),
          if (dictamen)
            const SizedBox()
          else if (temas.isEmpty)
            Text('Ninguno todavía.', style: context.textos.bodySmall)
          else
            Tarjeta(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                for (final t in temas)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.bodySmall?.copyWith(color: context.esquema.onSurface)),
                  ),
              ]),
            ),
        ],
      ),
    );
  }
}

/// Estado de la clase en el Google Calendar del preparador, con reintento.
class _FilaCalendario extends ConsumerWidget {
  const _FilaCalendario({required this.sesion});
  final Cante sesion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = sesion;
    final error = ref.watch(errorCalendarioProvider);
    final enCalendario = s.eventoGoogle.isNotEmpty;
    return FilaEnlace(
      icono: enCalendario ? Icons.event_available_outlined : Icons.event_busy_outlined,
      titulo: 'Google Calendar',
      subtitulo: enCalendario ? 'En tu calendario${s.online && s.enlace.isNotEmpty ? ', con la reunión' : ''}. Toca para volver a enviarla.' : (error == null ? 'Pendiente de enviar. Toca para enviarla ahora.' : 'No se ha podido enviar: $error. Toca para reintentar.'),
      onTap: () async {
        final messenger = ScaffoldMessenger.of(context);
        final repo = ref.read(preparadorRepoProvider);
        final cambio = await repo.llevarAlCalendario(s.id);
        ref.invalidate(sesionesProvider);
        final e = repo.calendario?.ultimoError;
        messenger.showSnackBar(SnackBar(content: Text(e != null ? 'Google ha respondido con un error: $e' : (cambio || s.eventoGoogle.isNotEmpty ? 'La clase está en tu Google Calendar.' : 'No había nada que enviar.'))));
      },
    );
  }
}

/// Clase suelta cuya ficha ha perdido el alumno (sin él no se le pueden
/// mandar los temas): se recupera de la sustitución que se cogió.
class _RecuperarClaseSuelta extends ConsumerStatefulWidget {
  const _RecuperarClaseSuelta({required this.id});
  final String id;
  @override
  ConsumerState<_RecuperarClaseSuelta> createState() => _RecuperarClaseSueltaState();
}

class _RecuperarClaseSueltaState extends ConsumerState<_RecuperarClaseSuelta> {
  bool _buscando = true;

  @override
  void initState() {
    super.initState();
    _recuperar();
  }

  Future<void> _recuperar() async {
    setState(() => _buscando = true);
    final n = await ref.read(preparadorRepoProvider).repararClasesSueltas(soloId: widget.id);
    if (!mounted) return;
    if (n > 0) {
      ref.invalidate(alumnosProvider);
      ref.invalidate(sesionesProvider);
    }
    setState(() => _buscando = false);
  }

  @override
  Widget build(BuildContext context) => _buscando
      ? Row(children: [
          const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: 10),
          Expanded(child: Text('Recuperando al alumno de esta clase suelta para poder mandarle los temas…', style: context.textos.labelSmall)),
        ])
      : Row(children: [
          Expanded(child: Text('No se ha podido recuperar al alumno de esta clase suelta (¿sin conexión?). Sin él no se le pueden mandar los temas.', style: context.textos.labelSmall)),
          TextButton(onPressed: _recuperar, child: const Text('Reintentar')),
        ]);
}
