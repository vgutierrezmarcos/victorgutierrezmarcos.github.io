import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../../data/models/temario.dart';
import '../../data/repos/usuario_repo.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/cantar_page.dart';
import '../plan/cante_form_page.dart';
import '../plan/cantes_util.dart';
import '../plan/modalidad.dart';
import '../plan/resultado_sheet.dart';
import 'red_widgets.dart';

/// Temas que entran en la sesión de un alumno: «los estudiados» son los suyos.
List<Tema> temasDeSesion(Cante sesion, Alumno alumno, Temario temario) => temasDeCante(sesion, temario, Ajustes(temasEstudiados: alumno.temas.toSet()));

/// Envía el informe de un cante al alumno por la app que elija el preparador.
Future<void> enviarInforme(BuildContext context, Cante sesion, Alumno? alumno, Temario? temario) => compartirTexto(
      context,
      informeCante(sesion, alumno: alumno?.nombre, tituloDe: (codigo) => temario?.tema(codigo)?.titulo ?? ''),
      asunto: 'Valoración del cante',
    );

/// Sesión de cante de un preparador con un alumno: cuándo es, qué temas
/// entran y, una vez cantada, la valoración.
class SesionPage extends ConsumerWidget {
  const SesionPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(sesionesProvider).where((x) => x.id == id).firstOrNull;
    if (s == null) return Scaffold(appBar: BarraWeb(title: const Text('Sesión')), body: const Center(child: Text('Esta sesión ya no existe.')));
    final alumnos = ref.watch(alumnosProvider);
    final alumno = alumnos.where((a) => a.id == s.alumno).firstOrNull;
    final temario = ref.watch(temarioProvider).valueOrNull;
    final temas = temario == null || alumno == null ? const <Tema>[] : temasDeSesion(s, alumno, temario);
    final r = s.resultado;
    final notifier = ref.read(sesionesProvider.notifier);

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
          title: const Text('¿Borrar la sesión?'),
          content: Text(enSerie ? 'Esta sesión forma parte de una repetición semanal.' : 'Se borrará de tu agenda${alumno?.enlazado == true ? ' y de la del alumno' : ''}.'),
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
      final messenger = ScaffoldMessenger.of(context);
      final d = await showDatePicker(context: context, initialDate: s.fecha, firstDate: DateTime.now().subtract(const Duration(days: 1)), lastDate: DateTime.now().add(const Duration(days: 365)), helpText: 'Nuevo día');
      if (d == null || !context.mounted) return;
      final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(s.fecha), helpText: 'Nueva hora');
      if (t == null) return;
      final nueva = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      final choca = ref.read(sesionesProvider).where((x) => x.id != s.id && !x.cancelado && !x.borrado && seSolapan(x.fecha, x.fecha.add(Duration(minutes: x.minutos)), nueva, nueva.add(Duration(minutes: s.minutos))));
      await notifier.guardar(s.copyWith(fecha: nueva, estado: EstadoCante.pendiente, motivo: ''));
      messenger.showSnackBar(SnackBar(content: Text(choca.isEmpty ? 'Cambiada al ${fechaCorta(nueva)}, ${horaDe(nueva)}${alumno?.enlazado == true ? '. El alumno ya lo ve en su agenda' : ''}' : 'Cambiada, pero se solapa con otra sesión de ese día')));
    }

    Future<void> cancelar() async {
      final motivo = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Cancelar la sesión?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(alumno?.enlazado == true ? 'El alumno lo verá en su agenda, con la opción de buscar a otro preparador que se la coja.' : 'Queda marcada como cancelada en tu agenda.'),
            const SizedBox(height: 10),
            TextField(controller: motivo, decoration: const InputDecoration(labelText: 'Motivo (opcional)', hintText: 'Viaje, enfermedad…')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('No')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, true), child: const Text('Cancelar sesión')),
          ],
        ),
      );
      if (ok == true) await notifier.guardar(s.copyWith(estado: EstadoCante.cancelado, motivo: motivo.text.trim()));
    }

    return Scaffold(
      appBar: BarraWeb(
        title: Text(alumno?.nombre ?? 'Sesión'),
        actions: [
          IconButton(tooltip: 'Editar', icon: const Icon(Icons.edit_outlined), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(cante: s, alumnos: alumnos)))),
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'hora':
                  await cambiarHora();
                case 'cancelar':
                  await cancelar();
                case 'recuperar':
                  await notifier.guardar(s.copyWith(estado: EstadoCante.pendiente, motivo: ''));
                case 'borrar':
                  await borrar();
              }
            },
            itemBuilder: (_) => [
              if (!s.hecho) const PopupMenuItem(value: 'hora', child: Text('Cambiar día u hora')),
              if (s.pendiente) const PopupMenuItem(value: 'cancelar', child: Text('Cancelar sesión')),
              if (s.cancelado) const PopupMenuItem(value: 'recuperar', child: Text('Recuperar sesión')),
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('${fechaLarga(s.fecha)}, ${horaDe(s.fecha)}', style: context.textos.titleMedium)),
                if (s.hecho) const Etiqueta('Valorado', color: Paleta.acierto),
                if (s.cancelado) Etiqueta('Cancelada', color: context.esquema.error),
              ]),
              if (s.cancelado && s.motivo.isNotEmpty) Text('Motivo: ${s.motivo}', style: context.textos.bodySmall),
              if (s.pendiente) Text(s.fecha.isAfter(DateTime.now()) ? 'Empieza ${cuentaAtras(s.fecha)}' : 'Pendiente de valorar', style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
              Text('${s.titulo.isEmpty ? '' : '${s.titulo} · '}${descripcionBolsa(s)} · ${s.minutos} min', style: context.textos.bodySmall),
              if (s.notas.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(s.notas, style: context.textos.bodyMedium)),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Etiqueta(alumno?.enlazado == true ? 'El alumno la ve en su agenda' : 'Alumno sin app enlazada', color: alumno?.enlazado == true ? null : context.colores.textoClaro),
              ),
            ]),
          ),
          if (s.modalidad != Modalidad.sinIndicar && !s.cancelado) Padding(padding: const EdgeInsets.only(top: 10), child: TarjetaModalidad(cante: s, telefono: alumno?.telefono.isEmpty ?? true ? null : alumno!.telefono)),
          if (alumno != null && alumno.telefono.isNotEmpty) ...[
            const SizedBox(height: 10),
            BotonWhatsApp(telefono: alumno.telefono, texto: 'Escribir a ${alumno.nombre}', mensaje: 'Hola, ${alumno.nombre}. Sobre el cante del ${fechaCorta(s.fecha)} a las ${horaDe(s.fecha)}: '),
          ],
          if (s.pendiente) ...[
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: OutlinedButton.icon(onPressed: cambiarHora, icon: const Icon(Icons.schedule, size: 18), label: const Text('Cambiar hora'))),
              const SizedBox(width: 10),
              Expanded(child: OutlinedButton.icon(onPressed: cancelar, icon: Icon(Icons.event_busy, size: 18, color: context.esquema.error), label: Text('Cancelar', style: TextStyle(color: context.esquema.error)))),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: (temas.isEmpty && s.ejercicio != 1) || alumno == null ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CantarPage(sesion: SesionAlumno(cante: s, alumno: alumno)))),
                  icon: Icon(s.ejercicio == 1 ? Icons.timer_outlined : Icons.casino_outlined),
                  label: Text(s.ejercicio == 1 ? 'Cronometrar' : 'Sortear y cantar'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: valorar, child: const Text('Valorar')),
            ]),
            if (temas.isEmpty && s.ejercicio != 1) Padding(padding: const EdgeInsets.only(top: 6), child: Text('No hay temas en la bolsa: apunta en la ficha los temas que lleva el alumno o elige una lista.', style: context.textos.labelSmall)),
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
            if (alumno?.enlazado == true) Padding(padding: const EdgeInsets.only(top: 4), child: Text('Además, la valoración ya está en su diario de cantes.', textAlign: TextAlign.center, style: context.textos.labelSmall)),
          ],
          if (!Oposiciones.actual.esDictamen(s.ejercicio)) TituloSeccion('Temas que entran (${temas.length})'),
          if (Oposiciones.actual.esDictamen(s.ejercicio))
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
