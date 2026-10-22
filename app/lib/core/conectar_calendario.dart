import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'permiso_calendario.dart';
import 'providers.dart';

/// Conecta Google Calendar (la ventana de permiso de Google, la comprobación
/// y, si lo han retirado, volver a pedirlo) y, si va bien, lo deja activado:
/// al preparador, «Mis clases en Google Calendar» en su perfil y las clases
/// pendientes al calendario; al opositor, «Mis cantes en Google Calendar» en
/// sus ajustes y los cantes pendientes. Devuelve si ha ido bien y el mensaje
/// para enseñar (el de éxito o el del error). Lo usan la tarjeta del
/// preparador, el interruptor de Ajustes del opositor y la pregunta al abrir.
Future<({bool ok, String mensaje})> conectarCalendario(WidgetRef ref, {required bool preparador}) async {
  if (!await pedirPermisoCalendario()) {
    return (ok: false, mensaje: 'Google no ha dado acceso a tu calendario. Si sale «aplicación no verificada», entra en «Configuración avanzada» y continúa.');
  }
  final repoPreparador = ref.read(preparadorRepoProvider);
  final repoPlan = ref.read(planRepoProvider);
  final cal = preparador ? repoPreparador.calendario : repoPlan.calendario;
  if (cal == null) return (ok: false, mensaje: 'Esta compilación no puede usar Google Calendar.');
  try {
    await cal.comprobar();
  } catch (e) {
    // Permiso retirado desde la cuenta de Google (o token caducado): se
    // vuelve a pedir desde cero, con la ventana de Google, y se reintenta.
    if (permisoRetirado(e) && await renovarPermisoCalendario()) {
      try {
        await cal.comprobar();
      } catch (e2) {
        cal.ultimoError = e2.toString();
        return (ok: false, mensaje: 'Google no deja usar tu calendario desde la app todavía: $e2');
      }
    } else {
      cal.ultimoError = e.toString();
      return (ok: false, mensaje: permisoRetirado(e) ? 'Google ha retirado el permiso del calendario y no se ha podido volver a pedir. Prueba otra vez.' : 'Google no deja usar tu calendario desde la app todavía: $e');
    }
  }
  cal.ultimoError = null;
  if (preparador) {
    await ref.read(perfilPreparadorProvider.notifier).guardar(ref.read(perfilPreparadorProvider).copyWith(calendarioGoogle: true));
    final n = await repoPreparador.llevarClasesAlCalendario();
    ref.invalidate(sesionesProvider);
    return (ok: true, mensaje: n == 0 ? 'Conectado. Las clases que programes irán a tu Google Calendar.' : 'Conectado: $n ${n == 1 ? 'clase' : 'clases'} en tu Google Calendar.');
  }
  await ref.read(ajustesProvider.notifier).fijarCalendarioGoogle(true);
  final n = await repoPlan.llevarCantesAlCalendario();
  ref.invalidate(cantesProvider);
  return (ok: true, mensaje: n == 0 ? 'Conectado. Tus cantes y tus clases irán a tu Google Calendar.' : 'Conectado: $n ${n == 1 ? 'cante' : 'cantes'} en tu Google Calendar.');
}

/// Si Google Calendar ya está conectado en este papel.
bool calendarioConectado(WidgetRef ref, {required bool preparador}) =>
    preparador ? ref.read(perfilPreparadorProvider).calendarioGoogle : ref.read(ajustesProvider).calendarioGoogle;
