import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants.dart';
import '../models/oposicion.dart';

/// La oposición de la cuenta: la última que se usó con la sesión iniciada,
/// en `users/{uid}/cuenta/app`. Al entrar en un dispositivo nuevo, la app
/// arranca en ella sin preguntar la oposición ni el papel (el papel ya está
/// en la cuenta, en el perfil de cada oposición). Va antes de crear los
/// servicios, así que no usa Riverpod.
class OposicionCuenta {
  static const _espera = Duration(seconds: 8);

  static DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      FirebaseFirestore.instance.collection('users').doc(uid).collection('cuenta').doc('app');

  /// La sesión, también en el navegador, donde se recupera un poco después
  /// de arrancar (null si no hay).
  static Future<User?> _usuario() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) return auth.currentUser;
    try {
      return await auth.authStateChanges().first.timeout(const Duration(seconds: 3));
    } catch (_) {
      return null;
    }
  }

  /// Apunta [oposicion] en la cuenta, si hay sesión y ha cambiado.
  static Future<void> guardar(Oposicion oposicion) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final marca = '$uid:${oposicion.id}';
    final caja = Hive.box(Cajas.app);
    if (caja.get('oposicion_cuenta') == marca) return;
    try {
      await _doc(uid).set({'oposicion': oposicion.id, 'actualizada': FieldValue.serverTimestamp()}, SetOptions(merge: true)).timeout(_espera);
      await caja.put('oposicion_cuenta', marca);
    } catch (_) {
      // Sin red: se apunta en el próximo arranque.
    }
  }

  /// La oposición de la cuenta, o null si no se sabe (sin sesión, sin red o
  /// cuenta nueva). Cuentas de antes de guardarla: la primera en la que ya
  /// eligió papel o, en TCEE, la que tiene ajustes del opositor.
  static Future<Oposicion?> buscar() async {
    final usuario = await _usuario();
    if (usuario == null) return null;
    final db = FirebaseFirestore.instance;
    try {
      return await () async {
        final guardada = (await _doc(usuario.uid).get()).data()?['oposicion'];
        final o = Oposiciones.disponibles.where((o) => o.id == guardada).firstOrNull;
        if (o != null) return o;
        for (final o in Oposiciones.disponibles) {
          final perfil = await o.raizUsuario(db, usuario.uid).collection('progress').doc('preparador').get();
          if (perfil.data()?['papelElegido'] == true) return o;
        }
        final ajustes = await Oposiciones.tcee.raizUsuario(db, usuario.uid).collection('progress').doc('settings').get();
        return ajustes.exists && Oposiciones.tcee.lanzada ? Oposiciones.tcee : null;
      }()
          .timeout(_espera);
    } catch (_) {
      return null;
    }
  }
}
