import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../data/models/plan.dart';

/// Notificaciones locales: recordatorio diario de estudio, avisos del
/// cronómetro y recordatorios de los cantes programados.
class Notificaciones {
  Notificaciones._();
  static final _plugin = FlutterLocalNotificationsPlugin();
  static const _idRecordatorio = 1;
  static const _idCronometro = 2;
  // Avisos programados del cronómetro (hitos de tiempo con la app en segundo plano).
  static const _idCronometroProgramado = 10;
  static const _maxAvisosCronometro = 8;
  // Dos avisos por cante (víspera y una hora antes) para los próximos cantes.
  static const _idCantes = 100;
  static const maxCantesConAviso = 20;
  static bool _listo = false;

  /// Las notificaciones solo existen en la app del móvil.
  static bool get disponibles => !kIsWeb;

  static Future<void> iniciar() async {
    if (_listo || !disponibles) return;
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
    if (!disponibles) return false;
    await iniciar();
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final a = await android?.requestNotificationsPermission();
    final i = await ios?.requestPermissions(alert: true, badge: true, sound: true);
    return (a ?? true) && (i ?? true);
  }

  /// Programa (o cancela con [minutosDesdeMedianoche] < 0) el recordatorio diario.
  static Future<void> programarRecordatorio(int minutosDesdeMedianoche) async {
    if (!disponibles) return;
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

  /// Programa los avisos del cronómetro para que suenen aunque la app esté
  /// en segundo plano. Sustituye a los que hubiera.
  static Future<void> programarCronometro(List<({DateTime cuando, String texto})> avisos) async {
    if (!disponibles) return;
    await cancelarCronometro();
    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    // Sin permiso de alarmas exactas el aviso puede llegar con algo de retraso.
    final exacto = await android?.canScheduleExactNotifications() ?? false;
    final ahora = DateTime.now();
    var i = 0;
    for (final a in avisos.where((a) => a.cuando.isAfter(ahora)).take(_maxAvisosCronometro)) {
      try {
        await _plugin.zonedSchedule(
          _idCronometroProgramado + i++,
          'Cronómetro',
          a.texto,
          tz.TZDateTime.from(a.cuando, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails('cronometro', 'Cronómetro de exposición',
                channelDescription: 'Avisos de tiempo al cantar un tema', importance: Importance.high, priority: Priority.high),
            iOS: DarwinNotificationDetails(presentSound: true),
          ),
          androidScheduleMode: exacto ? AndroidScheduleMode.exactAllowWhileIdle : AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (_) {}
    }
  }

  static Future<void> cancelarCronometro() async {
    if (!disponibles) return;
    await iniciar();
    for (var i = 0; i < _maxAvisosCronometro; i++) {
      await _plugin.cancel(_idCronometroProgramado + i);
    }
  }

  /// Avisos de un cante: la víspera a las 20:00 y una hora antes.
  static List<({DateTime cuando, String titulo, String texto})> avisosDeCante(Cante c) {
    final hora = '${c.fecha.hour.toString().padLeft(2, '0')}:${c.fecha.minute.toString().padLeft(2, '0')}';
    final nombre = c.titulo.isEmpty ? 'Cante' : 'Cante · ${c.titulo}';
    return [
      (cuando: DateTime(c.fecha.year, c.fecha.month, c.fecha.day - 1, 20), titulo: nombre, texto: 'Mañana a las $hora. Repasa los temas que entran.'),
      (cuando: c.fecha.subtract(const Duration(hours: 1)), titulo: nombre, texto: 'En una hora, a las $hora.'),
    ];
  }

  /// Reprograma los recordatorios de los próximos cantes pendientes.
  /// Con [cantes] vacío solo cancela los que hubiera.
  static Future<void> programarCantes(List<Cante> cantes, {DateTime? ahora}) async {
    if (!disponibles) return;
    await iniciar();
    for (var i = 0; i < 2 * maxCantesConAviso; i++) {
      await _plugin.cancel(_idCantes + i);
    }
    final hoy = ahora ?? DateTime.now();
    final proximos = cantes.where((c) => c.pendiente && !c.borrado && c.fecha.isAfter(hoy)).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
    var id = _idCantes;
    for (final c in proximos.take(maxCantesConAviso)) {
      for (final a in avisosDeCante(c)) {
        final n = id++;
        if (!a.cuando.isAfter(hoy)) continue;
        try {
          await _plugin.zonedSchedule(
            n,
            a.titulo,
            a.texto,
            tz.TZDateTime.from(a.cuando, tz.local),
            const NotificationDetails(
              android: AndroidNotificationDetails('cantes', 'Cantes programados',
                  channelDescription: 'Recordatorios la víspera y una hora antes de cada cante', importance: Importance.high, priority: Priority.high),
              iOS: DarwinNotificationDetails(),
            ),
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          );
        } catch (_) {}
      }
    }
  }

  /// Aviso inmediato (cronómetro de cantar un tema en segundo plano).
  static Future<void> avisoCronometro(String texto) async {
    if (!disponibles) return;
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
