import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/calendario.dart';
import '../../core/plataforma.dart';
import '../../core/providers.dart';
import '../../data/models/oposicion.dart';
import '../../core/red_providers.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../cantar/pizarra_page.dart';
import '../preparador/red_widgets.dart';
import '../preparador/sustituciones.dart';
import '../temario/agenda_tema_page.dart';
import 'cante_form_page.dart';
import 'cantes_util.dart';
import 'modalidad.dart';
import 'resultado_sheet.dart';
import '../mas/ayuda_videos.dart';

/// Detalle de un cante: cuenta atrás, temas que entran, apuntes pendientes
/// de esos temas y, una vez hecho, cómo fue.
class CantePage extends ConsumerWidget {
  const CantePage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(cantesProvider).where((x) => x.id == id).firstOrNull;
    if (c == null) return Scaffold(appBar: BarraWeb(title: const Text('Cante')), body: const Center(child: Text('Este cante ya no existe.')));
    final temario = ref.watch(temarioProvider).valueOrNull;
    final ajustes = ref.watch(ajustesProvider);
    final agendas = ref.watch(agendasProvider);
    final temas = temario == null ? const <Tema>[] : temasDeCante(c, temario, ajustes);
    final conApuntes = [for (final t in temas) if ((agendas[t.codigo]?.pendientes ?? const []).isNotEmpty) t];
    final r = c.resultado;
    final notifier = ref.read(cantesProvider.notifier);
    final peticion = ref.watch(peticionDeCanteProvider(c.id));
    final usuario = ref.watch(usuarioActualProvider);
    // Las clases del preparador las cambia él: aquí se ven, se anotan y se
    // pide clase suelta si las cancela.
    final mia = !c.dePreparador;
    final temasRecibidos = c.dePreparador && c.temaA != null && !c.temaA!.isAfter(DateTime.now()) ? ref.watch(temaAnticipadoProvider(c.id)).valueOrNull : null;

    Future<void> anotar() async {
      final res = await pedirResultadoCante(context, inicial: r ?? const ResultadoCante(), opciones: temas);
      if (res != null) await notifier.guardar(c.copyWith(estado: EstadoCante.hecho, resultado: res));
    }

    Future<void> borrar() async {
      final nav = Navigator.of(context);
      final enSerie = c.serie != null && c.pendiente;
      final que = await showDialog<String>(
        context: context,
        builder: (d) => AlertDialog(
          title: const Text('¿Borrar el cante?'),
          content: Text(enSerie ? 'Este cante forma parte de una repetición semanal.' : 'Se borrará de la agenda${c.hecho ? ' y del diario' : ''}.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            if (enSerie) TextButton(onPressed: () => Navigator.pop(d, 'serie'), child: const Text('Este y los siguientes')),
            FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(d).colorScheme.error), onPressed: () => Navigator.pop(d, 'uno'), child: Text(enSerie ? 'Solo este' : 'Borrar')),
          ],
        ),
      );
      if (que == null) return;
      que == 'serie' ? await notifier.borrarSerieDesde(c) : await notifier.borrar(c);
      nav.pop();
    }

    Future<void> compartirIcs() async {
      await guardarFichero(nombre: 'cante_${Oposiciones.actual.id}.ics', contenido: Calendario.ics([eventoDeCante(c)]), mime: 'text/calendar', asunto: 'Cante ${Oposiciones.actual.siglas}');
    }

    return Scaffold(
      appBar: BarraWeb(
        title: Text(tituloCante(c)),
        actions: [
          if (c.dePreparador) const BotonVideoAyuda('clase'),
          if (mia) IconButton(tooltip: 'Editar', icon: const Icon(Icons.edit_outlined), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CanteFormPage(cante: c)))),
          PopupMenuButton<String>(
            onSelected: (v) async {
              switch (v) {
                case 'google':
                  abrirUrl(context, Calendario.urlGoogle(eventoDeCante(c)));
                case 'ics':
                  await compartirIcs();
                case 'cancelar':
                  await notifier.guardar(c.copyWith(estado: c.estado == EstadoCante.cancelado ? EstadoCante.pendiente : EstadoCante.cancelado));
                case 'borrar':
                  await borrar();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'google', child: Text('Añadir a Google Calendar')),
              const PopupMenuItem(value: 'ics', child: Text('Enviar a otro calendario (.ics)')),
              if (!c.hecho && mia) PopupMenuItem(value: 'cancelar', child: Text(c.estado == EstadoCante.cancelado ? 'Recuperar cante' : 'Marcar como cancelado')),
              if (mia) const PopupMenuItem(value: 'borrar', child: Text('Borrar')),
            ],
          ),
        ],
      ),
      body: ListaAdaptable(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 32),
        children: [
          Tarjeta(
            color: c.pendiente ? context.colores.primarioPalido : null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text('${fechaLarga(c.fecha)}, ${horaDe(c.fecha)}', style: context.textos.titleMedium)),
                if (c.hecho) const Etiqueta('Hecho', color: Paleta.acierto),
                if (c.estado == EstadoCante.cancelado) Etiqueta('Cancelado', color: context.colores.textoClaro),
              ]),
              if (c.pendiente) Text(c.fecha.isAfter(DateTime.now()) ? 'Empieza ${cuentaAtras(c.fecha)}' : 'Pendiente de anotar', style: context.textos.headlineSmall?.copyWith(color: context.esquema.primary)),
              Text('${descripcionBolsa(c)} · ${textoDuracion(c.minutos)}', style: context.textos.bodySmall),
              if (c.notas.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(c.notas, style: context.textos.bodyMedium)),
              if (c.dePreparador)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(children: [
                    PuntoPersona(c.preparador!),
                    const SizedBox(width: 6),
                    Flexible(child: Etiqueta((c.preparadorNombre ?? '').isEmpty ? 'Programado por tu preparador' : 'Programado por tu preparador · ${c.preparadorNombre}', color: Color(colorDePersona(c.preparador!)))),
                  ]),
                ),
              if (c.sustitucion != null) const Padding(padding: EdgeInsets.only(top: 8), child: Etiqueta('Clase suelta')),
            ]),
          ),
          if (c.modalidad != Modalidad.sinIndicar && !c.cancelado) Padding(padding: const EdgeInsets.only(top: 10), child: TarjetaModalidad(cante: c)),
          if (c.temaA != null && c.pendiente) Padding(padding: const EdgeInsets.only(top: 10), child: _TemaRecibido(cante: c)),
          if (c.cancelado && c.dePreparador && c.fecha.isAfter(DateTime.now()) && peticion == null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Tarjeta(
                color: context.esquema.errorContainer.withValues(alpha: 0.4),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${(c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre} ha cancelado este cante', style: context.textos.titleSmall),
                  if (c.motivo.isNotEmpty) Text('Motivo: ${c.motivo}', style: context.textos.bodySmall),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PedirSustitucionPage(cante: c))),
                    icon: const Icon(Icons.campaign_outlined, size: 18),
                    label: const Text('Pedir una clase suelta'),
                  ),
                ]),
              ),
            ),
          if (peticion != null) ...[const SizedBox(height: 10), FilaMiPeticion(peticion: peticion)],
          if (peticion == null && c.sustitucion == null && !c.hecho && !(c.cancelado && c.dePreparador) && c.fecha.isAfter(DateTime.now()) && ref.watch(usuarioActualProvider) != null)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PedirSustitucionPage(cante: c))),
                icon: const Icon(Icons.campaign_outlined, size: 18),
                label: const Text('Pedir una clase suelta a otro preparador'),
              ),
            ),
          if (c.pendiente) ...[
            const SizedBox(height: 10),
            Row(children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: temas.isEmpty && c.ejercicio != 1 && mia
                      ? null
                      : () {
                          final router = GoRouter.of(context);
                          Navigator.of(context).popUntil((r) => r.isFirst);
                          // En una clase del preparador no se sortea: se canta lo que él manda (o se cronometra).
                          empezarCante(ref, router, c.id, tema: temasRecibidos?.temas.join(','));
                        },
                  icon: Icon(c.ejercicio == 1 || (c.dePreparador && temasRecibidos == null) ? Icons.timer_outlined : (c.dePreparador ? Icons.mic : Icons.casino_outlined)),
                  label: Text(c.ejercicio == 1 || (c.dePreparador && temasRecibidos == null) ? 'Cronometrar' : (c.dePreparador ? 'Cantar los temas' : 'Sacar bola y cantar')),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: anotar, child: const Text('Anotar resultado')),
            ]),
            if (temas.isEmpty && c.ejercicio != 1 && mia)
              Padding(padding: const EdgeInsets.only(top: 6), child: Text('No hay temas en la bolsa: marca temas como estudiados o elige una lista.', style: context.textos.labelSmall)),
            if (c.dePreparador && c.temaA == null)
              Padding(padding: const EdgeInsets.only(top: 6), child: Text('Los temas los saca o elige tu preparador en la clase; tú tienes el cronómetro.', style: context.textos.labelSmall)),
          ],
          if (c.dePreparador && usuario != null && !c.cancelado) ...[
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => abrirPizarra(context, alumnoUid: usuario.uid, canteId: c.id, otroNombre: (c.preparadorNombre ?? '').isEmpty ? 'tu preparador' : c.preparadorNombre!),
              icon: const Icon(Icons.draw_outlined, size: 18),
              label: const Text('Pizarra compartida'),
            ),
          ],
          if (c.hecho && r != null) ...[
            TituloSeccion(c.dePreparador ? 'Valoración del preparador' : 'Cómo fue', accion: TextButton(onPressed: anotar, child: const Text('Editar'))),
            Tarjeta(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (r.temaCantado != null) Text('${r.temaCantado} · ${temario?.tema(r.temaCantado!)?.titulo ?? ''}', style: context.textos.titleSmall),
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
          ],
          if (conApuntes.isNotEmpty) ...[
            const TituloSeccion('Apuntes pendientes de estos temas'),
            for (final t in conApuntes)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Tarjeta(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AgendaTemaPage(tema: t))),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${t.codigo} · ${t.titulo}', maxLines: 1, overflow: TextOverflow.ellipsis, style: context.textos.titleSmall),
                    for (final a in agendas[t.codigo]!.pendientes) Text('• ${a.texto}', style: context.textos.bodySmall),
                  ]),
                ),
              ),
          ],
          if (!Oposiciones.actual.esDictamen(c.ejercicio)) TituloSeccion('Temas que entran (${temas.length})'),
          if (Oposiciones.actual.esDictamen(c.ejercicio))
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

/// El tema que manda el preparador antes de la clase: a qué hora llega y,
/// cuando llega, cuál es, con el botón para empezar el esquema.
class _TemaRecibido extends ConsumerWidget {
  const _TemaRecibido({required this.cante});
  final Cante cante;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = cante;
    final de = (c.preparadorNombre ?? '').isEmpty ? 'Tu preparador' : c.preparadorNombre!;
    final cuando = DateFormat("EEEE d 'a las' HH:mm", 'es').format(c.temaA!);
    if (c.temaA!.isAfter(DateTime.now())) {
      return Tarjeta(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        child: Row(children: [
          Icon(Icons.schedule_send_outlined, color: context.esquema.primary),
          const SizedBox(width: 12),
          Expanded(child: Text('$de te mandará ${c.numTemas == 1 ? 'un tema' : 'los temas'} $cuando para que hagas el esquema.', style: context.textos.bodySmall)),
        ]),
      );
    }
    final t = ref.watch(temaAnticipadoProvider(c.id));
    final tema = t.valueOrNull;
    return Tarjeta(
      color: context.colores.primarioPalido,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.mark_email_unread_outlined, color: context.esquema.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(tema?.sorteado == true ? '$de ha sacado ${(tema?.temas.length ?? 1) == 1 ? 'esta bola' : 'estas bolas'} para ti' : '$de te ha mandado ${(tema?.temas.length ?? 1) == 1 ? 'este tema' : 'estos temas'}', style: context.textos.titleSmall)),
        ]),
        const SizedBox(height: 6),
        if (t.isLoading)
          const LinearProgressIndicator()
        else if (tema == null)
          Row(children: [
            Expanded(child: Text('No se ha podido traer. Comprueba la conexión.', style: context.textos.bodySmall)),
            TextButton(onPressed: () => ref.invalidate(temaAnticipadoProvider(c.id)), child: const Text('Reintentar')),
          ])
        else ...[
          for (var i = 0; i < tema.temas.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: TextoTema(
                tema.temas[i],
                (i < tema.titulos.length && tema.titulos[i].isNotEmpty) ? tema.titulos[i] : (ref.watch(temarioProvider).valueOrNull?.tema(tema.temas[i])?.titulo ?? ''),
                color: ref.watch(estructuraProvider).valueOrNull?.colorDe(tema.temas[i]),
              ),
            ),
          const SizedBox(height: 6),
          FilledButton.icon(
            onPressed: () {
              final router = GoRouter.of(context);
              Navigator.of(context).popUntil((r) => r.isFirst);
              empezarCante(ref, router, c.id, tema: tema.temas.join(','));
            },
            icon: const Icon(Icons.edit_note),
            label: Text(tema.temas.length == 1 ? 'Empezar el esquema' : 'Empezar el esquema de los ${tema.temas.length} temas'),
          ),
        ],
      ]),
    );
  }
}
