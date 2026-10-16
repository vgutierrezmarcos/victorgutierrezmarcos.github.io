import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../data/models/oposicion.dart';
import 'avisos_proceso.dart';

/// Avisos push de las novedades del proceso selectivo (solo en Android).
///
/// La acción `leer-proceso` de la web lee la página oficial cada pocos
/// minutos y, en cuanto aparece un documento, lo manda por Firebase Cloud
/// Messaging al tema `proceso_{oposición}` (`proceso_tcee`, `proceso_dce`).
/// La app se suscribe al tema de cada oposición con los avisos activados, así
/// que TCEE y DCE van por separado. La comprobación periódica sigue (por si
/// falla el push) y no repite lo ya avisado.

bool get _conPush => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// El tema de FCM de [oposicion].
String temaPushProceso(String oposicion) => 'proceso_$oposicion';

/// Al arrancar la app: recibir los push, también con la app cerrada.
Future<void> iniciarPushProceso() async {
  if (!_conPush) return;
  try {
    FirebaseMessaging.onBackgroundMessage(alRecibirPushProceso);
    FirebaseMessaging.onMessage.listen(alRecibirPushProceso);
    await sincronizarPushProceso();
  } catch (_) {}
}

/// Suscribe a los temas de las oposiciones con avisos activados y quita los demás.
Future<void> sincronizarPushProceso() async {
  if (!_conPush) return;
  try {
    final activas = await oposicionesConAvisosProceso();
    final fcm = FirebaseMessaging.instance;
    for (final op in Oposiciones.todas) {
      activas.contains(op.id) ? await fcm.subscribeToTopic(temaPushProceso(op.id)) : await fcm.unsubscribeFromTopic(temaPushProceso(op.id));
    }
  } catch (_) {
    // Sin Google Play Services o sin red: queda la comprobación periódica.
  }
}

/// Un push recibido (con la app abierta o cerrada: otro isolate).
@pragma('vm:entry-point')
Future<void> alRecibirPushProceso(RemoteMessage m) async {
  if (m.data['tipo'] != 'proceso') return;
  try {
    await initializeDateFormatting('es');
    await avisarPushProceso(m.data);
  } catch (_) {}
}
