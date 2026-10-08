import 'package:flutter/material.dart';

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
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [ButtonSegment(value: 1, label: Text('Cada semana')), ButtonSegment(value: 2, label: Text('Cada 15 días'))],
              selected: {cada},
              onSelectionChanged: (s) => set(() => cada = s.first),
            ),
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
