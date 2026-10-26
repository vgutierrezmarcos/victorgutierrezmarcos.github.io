import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/avisos_breves.dart';
import '../../core/conectar_calendario.dart';
import '../../core/constants.dart';
import '../../core/permiso_calendario.dart';
import '../../core/providers.dart';
import '../../data/models/preparador.dart';
import '../../data/repos/preparador_repo.dart';
import '../../theme/app_theme.dart';
import '../preparador/calendario_google_tarjeta.dart';

/// Marca, por dispositivo, de que ya se ha preguntado por Google Calendar
/// (el permiso de Google es de cada dispositivo, así que no va en los ajustes).
/// Marca de «ya se preguntó en este dispositivo» (la demo de capturas la pone a true).
const claveCalendarioPreguntado = 'cal_preguntado';
const _clavePreguntado = claveCalendarioPreguntado;

Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;

bool get calendarioPreguntado => _caja?.get(_clavePreguntado) == true;

Future<void> _marcarPreguntado() async {
  try {
    await _caja?.put(_clavePreguntado, true);
  } catch (_) {}
}

/// Una sola vez por dispositivo, al arrancar: ¿llevamos las clases (y los
/// cantes) a Google Calendar? Optativo: «Ahora no» no vuelve a preguntar; se
/// conecta cuando quiera desde Ajustes. Solo en el móvil, con una cuenta que
/// pueda usarlo y en un arranque distinto del de la pregunta de estadísticas
/// (para no encadenar dos preguntas). Si ya está conectado, no pregunta.
/// Devuelve si ha salido.
Future<bool> preguntarCalendarioSiToca(BuildContext context, WidgetRef ref, {bool trasOtraPregunta = false}) async {
  if (!calendarioDisponible || trasOtraPregunta || calendarioPreguntado) return false;
  // Sin cuenta de Google no hay calendario que conectar: se preguntará
  // cuando entre con ella (y no se marca).
  if (ref.read(usuarioActualProvider) == null) return false;
  final preparador = ref.read(papelProvider) == Papel.preparador;
  if (calendarioConectado(ref, preparador: preparador)) {
    await _marcarPreguntado();
    return false;
  }
  // Sin sesión (o sin poder usarlo todavía) no se pregunta ni se marca: se
  // preguntará cuando entre con su cuenta.
  PermisoCalendario permiso;
  try {
    permiso = await ref.read(calendarioPermitidoProvider.future);
  } catch (_) {
    return false;
  }
  if (permiso != PermisoCalendario.permitido) return false;
  await _marcarPreguntado();
  final texto = preparador
      ? 'Si lo conectas, cada clase que programes irá a tu Google Calendar con su día, hora, temas y reunión de Meet si es online, y tus alumnos recibirán la invitación. '
          'La app solo crea, cambia o borra los eventos de sus propias clases: no lee tu calendario. Puedes desconectarlo cuando quieras en Más → Preparador → Ajustes.'
      : 'Si lo conectas, tus cantes y las clases con tu preparador irán a tu Google Calendar con su día, hora y temas. '
          'La app solo crea, cambia o borra los eventos de sus propios cantes: no lee tu calendario. Puedes desconectarlo cuando quieras en Más → Ajustes.';
  if (!context.mounted) return false;
  final conectar = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (d) => AlertDialog(
      title: const Text('¿Llevamos tus clases a Google Calendar?'),
      content: Text(texto, style: d.textos.bodyMedium),
      actions: [
        TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Ahora no')),
        FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Conectar')),
      ],
    ),
  );
  if (conectar != true) return true;
  final r = await conectarCalendario(ref, preparador: preparador);
  if (context.mounted) ScaffoldMessenger.maybeOf(context)?.mostrar(SnackBar(content: Text(r.mensaje)));
  return true;
}
