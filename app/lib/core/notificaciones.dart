import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Notificaciones locales: recordatorio diario de estudio y avisos del cronómetro.
class Notificaciones {
  Notificaciones._();
  static final _plugin = FlutterLocalNotificationsPlugin();
  static const _idRecordatorio = 1;
  static const _idCronometro = 2;
  static bool _listo = false;

  static Future<void> iniciar() async {
    if (_listo) return;
    tzdata.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Europe/Madrid'));
    } catch (_) {}
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
    await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));
    _listo = true;
  }

  static Future<bool> pedirPermiso() async {
    await iniciar();
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final a = await android?.requestNotificationsPermission();
    final i = await ios?.requestPermissions(alert: true, badge: true, sound: true);
    return (a ?? true) && (i ?? true);
  }

  /// Programa (o cancela con [minutosDesdeMedianoche] < 0) el recordatorio diario.
  static Future<void> programarRecordatorio(int minutosDesdeMedianoche) async {
    await iniciar();
    await _plugin.cancel(_idRecordatorio);
    if (minutosDesdeMedianoche < 0) return;
    final ahora = tz.TZDateTime.now(tz.local);
    var cuando = tz.TZDateTime(tz.local, ahora.year, ahora.month, ahora.day,
        minutosDesdeMedianoche ~/ 60, minutosDesdeMedianoche % 60);
    if (cuando.isBefore(ahora)) cuando = cuando.add(const Duration(days: 1));
    await _plugin.zonedSchedule(
      _idRecordatorio,
      'Test diario TCEE',
      'Tus 10 preguntas de hoy te esperan. ¡Mantén la racha!',
      cuando,
      const NotificationDetails(
        android: AndroidNotificationDetails('recordatorio', 'Recordatorio diario',
            channelDescription: 'Aviso diario para hacer el test', importance: Importance.defaultImportance),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Aviso inmediato (cronómetro de cantar un tema en segundo plano).
  static Future<void> avisoCronometro(String texto) async {
    await iniciar();
    await _plugin.show(
      _idCronometro,
      'Cronómetro',
      texto,
      const NotificationDetails(
        android: AndroidNotificationDetails('cronometro', 'Cronómetro de exposición',
            channelDescription: 'Avisos de tiempo al cantar un tema', importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails(presentSound: true),
      ),
    );
  }
}
