import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/preparador.dart';
import 'constants.dart';
import 'enlaces.dart';

/// Al arrancar: la invitación del enlace con el que se ha abierto la app (o,
/// en el primer arranque en Android, la del `referrer` de Google Play) se
/// deja pendiente en la caja `app` (ya abierta). Devuelve la pendiente, venga
/// de ahora o de un arranque anterior.
Future<Invitacion?> leerInvitacionAlArrancar() async {
  var inv = Invitacion.deUri(await enlaceInicial());
  final caja = Hive.box(Cajas.app);
  if (inv == null && !kIsWeb && caja.get(claveReferrerLeido) != true) {
    // Play solo lo da una vez con sentido (la instalación): se lee en el
    // primer arranque y no se vuelve a preguntar.
    await caja.put(claveReferrerLeido, true);
    inv = Invitacion.deReferrer(await referrerInstalacion());
  }
  if (inv != null) await inv.guardar();
  return Invitacion.pendiente();
}

/// Invitación de un preparador a conectar con él: su código y, si se sabe, la
/// oposición. Llega por el enlace de invitación
/// (`…/app/?codigo=ABC234&op=tcee`, que en Android abre la app si está
/// instalada y, si no, lleva a Google Play con ese mismo texto como
/// `referrer`) y se guarda en la caja `app` hasta que el alumno conecta.
class Invitacion {
  const Invitacion({required this.codigo, this.oposicion});

  /// Código del preparador, ya normalizado (seis caracteres).
  final String codigo;

  /// Id de la oposición (`tcee`, `dce`) o null si el enlace no la lleva.
  final String? oposicion;

  /// La invitación que lleva [uri] en su consulta (`codigo` y `op`), o null si
  /// no es un enlace de invitación o el código no vale.
  static Invitacion? deUri(Uri? uri) => uri == null ? null : _deParametros(uri.queryParameters);

  /// La invitación que lleva el `referrer` de Google Play (`codigo=…&op=…`).
  static Invitacion? deReferrer(String? referrer) {
    if (referrer == null || referrer.isEmpty) return null;
    try {
      return _deParametros(Uri.splitQueryString(referrer));
    } catch (_) {
      return null;
    }
  }

  static Invitacion? _deParametros(Map<String, String> p) {
    final codigo = normalizarCodigo(p['codigo'] ?? '');
    if (codigo == null) return null;
    final op = p['op']?.trim().toLowerCase();
    return Invitacion(codigo: codigo, oposicion: op == null || op.isEmpty ? null : op);
  }

  /// La pendiente de conectar, guardada en la caja `app` (o null).
  static Invitacion? pendiente() {
    if (!Hive.isBoxOpen(Cajas.app)) return null;
    final caja = Hive.box(Cajas.app);
    final codigo = normalizarCodigo(caja.get(claveInvitacionCodigo) as String? ?? '');
    return codigo == null ? null : Invitacion(codigo: codigo, oposicion: caja.get(claveInvitacionOposicion) as String?);
  }

  /// La deja pendiente hasta que se conecte (o se descarte).
  Future<void> guardar() async {
    if (!Hive.isBoxOpen(Cajas.app)) return;
    final caja = Hive.box(Cajas.app);
    await caja.put(claveInvitacionCodigo, codigo);
    if (oposicion == null) {
      await caja.delete(claveInvitacionOposicion);
    } else {
      await caja.put(claveInvitacionOposicion, oposicion);
    }
  }

  static Future<void> borrar() async {
    if (!Hive.isBoxOpen(Cajas.app)) return;
    final caja = Hive.box(Cajas.app);
    await caja.delete(claveInvitacionCodigo);
    await caja.delete(claveInvitacionOposicion);
  }
}
