import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/avisos_breves.dart';
import '../../core/constants.dart';
import '../../core/providers.dart';
import '../../core/red_providers.dart';
import '../../data/models/preparador.dart';
import '../../data/models/red.dart';
import '../plan/cantes_util.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Punto del color de una persona (alumno o preparador).
class PuntoPersona extends StatelessWidget {
  const PuntoPersona(this.clave, {super.key, this.tamano = 10});
  final String clave;
  final double tamano;
  @override
  Widget build(BuildContext context) => Container(width: tamano, height: tamano, decoration: BoxDecoration(color: Color(colorDePersona(clave)), shape: BoxShape.circle));
}

/// Mensaje con el que el preparador invita a un alumno a la app y a
/// conectarse con él: el enlace de invitación (instala la app o la abre y
/// deja la conexión a un toque) y, por si acaso, su código.
String mensajeInvitacion(String codigo, {required String oposicion}) =>
    'Te invito a ${Creditos.nombreApp}, donde organizo las clases: verás en tu agenda las que te programe, '
    'los temas antes de cada clase y mis valoraciones.\n\n'
    'Toca este enlace para instalarla y conectar conmigo (si ya la tienes, te lleva directamente a conectar; en iPhone y ordenador se abre en el navegador): ${Urls.invitacion(codigo, oposicion)}\n\n'
    'Mi código, por si lo necesitas: $codigo';

/// Enseña el enlace de invitación como QR (para la clase presencial: el
/// alumno lo escanea con la cámara), con el código debajo.
Future<void> mostrarQrInvitacion(BuildContext context, {required String codigo, required String oposicion}) {
  final enlace = Urls.invitacion(codigo, oposicion);
  return showDialog<void>(
    context: context,
    builder: (d) => AlertDialog(
      title: const Text('Invitación para tus alumnos'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: QrImageView(data: enlace, size: 220, backgroundColor: Colors.white, errorCorrectionLevel: QrErrorCorrectLevel.M),
        ),
        const SizedBox(height: 12),
        Text(codigo, style: TextStyle(fontFamily: Fuentes.sans, fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: 5, color: Theme.of(d).colorScheme.primary)),
        const SizedBox(height: 6),
        Text('Al escanearlo, el alumno instala la app o, si ya la tiene, va directo a conectar contigo.', textAlign: TextAlign.center, style: Theme.of(d).textTheme.bodySmall),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cerrar'))],
    ),
  );
}

/// Abre WhatsApp con [mensaje] para elegir a quién mandarlo (un contacto o
/// un grupo).
Future<void> abrirWhatsAppConMensaje(BuildContext context, String mensaje) => abrirUrl(context, 'https://wa.me/?text=${Uri.encodeComponent(mensaje)}');

/// Botón que abre WhatsApp con ese teléfono y un mensaje.
class BotonWhatsApp extends StatelessWidget {
  const BotonWhatsApp({super.key, required this.telefono, this.mensaje = '', this.texto = 'Escribir por WhatsApp'});
  final String telefono;
  final String mensaje;
  final String texto;
  @override
  Widget build(BuildContext context) {
    final url = enlaceWhatsApp(telefono, mensaje);
    return FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: const Color(0xFF1F8F4E)),
      onPressed: url == null ? null : () => abrirUrl(context, url),
      icon: const Icon(Icons.chat_outlined, size: 18),
      label: Text(texto),
    );
  }
}

const nombresDias = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];

String horaMinutos(int minutoDelDia) => '${(minutoDelDia ~/ 60).toString().padLeft(2, '0')}:${(minutoDelDia % 60).toString().padLeft(2, '0')}';

/// Diálogo para elegir día de la semana, hora y duración (huecos y clases fijas).
/// Devuelve (díaSemana, minutoDelDia, minutos, cadaSemanas) o null.
Future<({int dia, int minuto, int minutos, int cada})?> elegirFranja(
  BuildContext context, {
  required String titulo,
  int dia = 1,
  int minuto = 18 * 60,
  int minutos = PerfilPreparador.minutosClasePorDefecto,
  int cada = 1,
  bool conRitmo = false,
}) {
  final opciones = {...duracionesClase, 30, 45, minutos}.toList()..sort();
  return showDialog(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) => AlertDialog(
        title: Text(titulo),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          DropdownButtonFormField<int>(
            initialValue: dia,
            decoration: const InputDecoration(labelText: 'Día'),
            items: [for (var i = 1; i <= 7; i++) DropdownMenuItem(value: i, child: Text(nombresDias[i - 1]))],
            onChanged: (v) => set(() => dia = v ?? dia),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.schedule, size: 18),
            label: Text('Hora: ${horaMinutos(minuto)}'),
            onPressed: () async {
              final t = await showTimePicker(context: d, initialTime: TimeOfDay(hour: minuto ~/ 60, minute: minuto % 60));
              if (t != null) set(() => minuto = t.hour * 60 + t.minute);
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: minutos,
            decoration: const InputDecoration(labelText: 'Duración'),
            items: opciones.map((m) => DropdownMenuItem(value: m, child: Text(textoDuracion(m)))).toList(),
            onChanged: (v) => set(() => minutos = v ?? minutos),
          ),
          if (conRitmo) ...[
            const SizedBox(height: 12),
            SelectorCadaSemanas(valor: cada, onCambio: (n) => set(() => cada = n)),
          ],
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(d, (dia: dia, minuto: minuto, minutos: minutos, cada: cada)), child: const Text('Aceptar')),
        ],
      ),
    ),
  );
}

/// Pide un teléfono (para WhatsApp). Devuelve null si se cancela.
Future<String?> pedirTelefono(BuildContext context, {String inicial = '', required String explicacion}) {
  final ctrl = TextEditingController(text: inicial);
  return showDialog<String>(
    context: context,
    builder: (d) => StatefulBuilder(
      builder: (d, set) {
        final valido = telefonoWhatsApp(ctrl.text) != null;
        return AlertDialog(
          title: const Text('Tu teléfono'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(explicacion, style: Theme.of(d).textTheme.bodySmall),
            const SizedBox(height: 10),
            TextField(
              controller: ctrl,
              autofocus: true,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: '600 123 456', errorText: ctrl.text.isEmpty || valido ? null : 'Revisa el número'),
              onChanged: (_) => set(() {}),
            ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(d), child: const Text('Cancelar')),
            FilledButton(onPressed: valido ? () => Navigator.pop(d, ctrl.text.trim()) : null, child: const Text('Aceptar')),
          ],
        );
      },
    ),
  );
}

/// Etiqueta con el número de pendientes (o nada si es cero).
Widget? globo(BuildContext context, int n) => n == 0
    ? null
    : Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: context.colores.dorado, borderRadius: BorderRadius.circular(10)),
        child: Text('$n', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
      );

/// Opositor que ha escrito tu código (o tocado tu enlace de invitación):
/// hasta que lo aceptes no ves nada suyo. Sale en Tus alumnos y en Hoy.
class TarjetaSolicitudEnlace extends ConsumerWidget {
  const TarjetaSolicitudEnlace(this.sol, {super.key});
  final SolicitudEnlace sol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> responder(bool aceptar) async {
      final messenger = ScaffoldMessenger.of(context);
      if (!aceptar) {
        final ok = await showDialog<bool>(
          context: context,
          builder: (d) => AlertDialog(
            title: const Text('¿Rechazar la conexión?'),
            content: Text('${sol.nombre.isEmpty ? 'Este opositor' : sol.nombre} no podrá compartir su progreso contigo. Si te equivocas, puede volver a escribir tu código.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Volver')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Rechazar')),
            ],
          ),
        );
        if (ok != true) return;
      }
      final error = await ref.read(solicitudesEnlaceProvider.notifier).responder(sol, aceptar: aceptar);
      messenger.mostrar(SnackBar(content: Text(error ?? (aceptar ? '${sol.nombre.isEmpty ? 'Alumno' : sol.nombre} ya es alumno tuyo: ves sus temas y sus cantes.' : 'Conexión rechazada.'))));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Tarjeta(
        color: context.colores.primarioPalido,
        padding: const EdgeInsets.fromLTRB(14, 10, 8, 6),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(Icons.person_add_alt_1_outlined, color: context.esquema.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${sol.nombre.isEmpty ? 'Un opositor' : sol.nombre} quiere conectar contigo', style: context.textos.titleSmall),
                Text(
                  '${sol.email.isEmpty ? '' : '${sol.email} · '}Ha escrito tu código${sol.desde == null ? '' : ' el ${fechaCorta(sol.desde!)}'}. Acéptalo solo si es alumno tuyo.',
                  style: context.textos.labelSmall,
                ),
              ]),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(onPressed: () => responder(false), child: const Text('Rechazar')),
            const SizedBox(width: 4),
            FilledButton(onPressed: () => responder(true), child: const Text('Aceptar')),
          ]),
        ]),
      ),
    );
  }
}
