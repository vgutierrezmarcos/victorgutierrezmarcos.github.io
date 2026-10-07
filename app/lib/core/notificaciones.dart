import 'dart:ui' show Color;

import '../data/models/oposicion.dart';
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
  /// Color del círculo de la diana en la notificación: el berenjena común a
  /// las dos oposiciones (PaletaNeutra.tintaClara).
  static const _colorAviso = Color(0xFF43294F);
  static const _idRecordatorio = 1;
  static const _idCronometro = 2;
  // Avisos programados del cronómetro (hitos de tiempo con la app en segundo plano).
  static const _idCronometroProgramado = 10;
  static const _maxAvisosCronometro = 8;
  // Dos avisos por cante (víspera y una hora antes) para los próximos cantes.
  static const _idCantes = 100;
  static const maxCantesConAviso = 20;
  static bool _listo = false;

  /// Qué hacer al tocar una notificación con contenido (`url:…` abre esa
  /// página; `ruta:…` va a esa pantalla de la app). Lo pone la app al arrancar;
  /// hasta entonces, el contenido espera en [_pendiente].
  static void Function(String contenido)? _alTocar;
  static String? _pendiente;

  static set alTocar(void Function(String contenido)? f) {
    _alTocar = f;
    final p = _pendiente;
    if (f != null && p != null) {
      _pendiente = null;
      f(p);
    }
  }

  static void _tocada(String? contenido) {
    if (contenido == null || contenido.isEmpty) return;
    final f = _alTocar;
    f == null ? _pendiente = contenido : f(contenido);
  }

  /// Las notificaciones solo existen en la app del móvil.
  static bool get disponibles => !kIsWeb;

  static Future<void> iniciar() async {
    if (_listo || !disponibles) return;
    tzdata.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Europe/Madrid'));
    } catch (_) {}
    // Icono pequeño: la diana del logo en silueta (res/drawable/ic_stat_diana.xml).
    const android = AndroidInitializationSettings('ic_stat_diana');
    const ios = DarwinInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (r) => _tocada(r.actionId == null || r.actionId!.isEmpty ? r.payload : '${r.payload}&accion=${r.actionId}'),
    );
    _listo = true;
    // Si la app se ha abierto tocando una notificación.
    try {
      final d = await _plugin.getNotificationAppLaunchDetails();
      if (d?.didNotificationLaunchApp ?? false) {
        final r = d!.notificationResponse;
        _tocada(r?.actionId == null || r!.actionId!.isEmpty ? r?.payload : '${r.payload}&accion=${r.actionId}');
      }
    } catch (_) {}
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
      'Test diario ${Oposiciones.actual.siglas}',
      'Tus 10 preguntas de hoy te esperan.',
      cuando,
      const NotificationDetails(
        android: AndroidNotificationDetails(color: _colorAviso, 'recordatorio', 'Recordatorio diario',
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
            android: AndroidNotificationDetails(color: _colorAviso, 'cronometro', 'Cronómetro de exposición',
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
      (cuando: c.fecha.subtract(const Duration(hours: 1)), titulo: nombre, texto: 'En una hora, a las $hora.${c.online ? (c.enlace.isEmpty ? ' Es online.' : ' Online: ${c.enlace}') : (c.presencial && c.lugar.isNotEmpty ? ' En ${c.lugar}.' : '')}'),
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
              android: AndroidNotificationDetails(color: _colorAviso, 'cantes', 'Cantes programados',
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

  // Recordatorios de las clases del preparador.
  static const _idClases = 200;
  static const _maxAvisosClase = 80;

  /// Recordatorios de una clase del preparador: [antelaciones] en minutos
  /// antes (-1 = la víspera a las 20:00).
  static List<({DateTime cuando, String titulo, String texto})> avisosDeClase(Cante c, {required String alumno, required List<int> antelaciones, String? tema}) {
    final hora = '${c.fecha.hour.toString().padLeft(2, '0')}:${c.fecha.minute.toString().padLeft(2, '0')}';
    final detalle = [
      if (tema != null) 'Le has mandado el $tema',
      if (c.online && c.enlace.isNotEmpty) 'Online: ${c.enlace}' else if (c.presencial && c.lugar.isNotEmpty) 'En ${c.lugar}',
    ].join('. ');
    return [
      for (final m in antelaciones..sort())
        if (m < 0)
          (cuando: DateTime(c.fecha.year, c.fecha.month, c.fecha.day - 1, 20), titulo: 'Clase con $alumno', texto: 'Mañana a las $hora.${detalle.isEmpty ? '' : ' $detalle.'}')
        else
          (cuando: c.fecha.subtract(Duration(minutes: m)), titulo: 'Clase con $alumno', texto: '${m >= 60 ? 'En ${m ~/ 60} h' : 'En $m min'}, a las $hora.${detalle.isEmpty ? '' : ' $detalle.'}'),
    ];
  }

  /// Reprograma los recordatorios de las próximas clases del preparador.
  static Future<void> programarClases(List<Cante> clases, {required String Function(Cante) alumno, required List<int> antelaciones, DateTime? ahora}) async {
    if (!disponibles) return;
    await iniciar();
    for (var i = 0; i < _maxAvisosClase; i++) {
      await _plugin.cancel(_idClases + i);
    }
    if (antelaciones.isEmpty) return;
    final hoy = ahora ?? DateTime.now();
    final proximas = clases.where((c) => c.pendiente && !c.borrado && c.fecha.isAfter(hoy)).toList()..sort((a, b) => a.fecha.compareTo(b.fecha));
    final avisos = [
      for (final c in proximas)
        for (final a in avisosDeClase(c, alumno: alumno(c), antelaciones: [...antelaciones], tema: c.mandaTema && !c.temaSorteado ? c.temaMandado : null))
          if (a.cuando.isAfter(hoy)) a,
    ].take(_maxAvisosClase);
    var id = _idClases;
    for (final a in avisos) {
      try {
        await _plugin.zonedSchedule(
          id++,
          a.titulo,
          a.texto,
          tz.TZDateTime.from(a.cuando, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(color: _colorAviso, 'clases', 'Tus clases',
                channelDescription: 'Recordatorios de las clases con tus alumnos', importance: Importance.high, priority: Priority.high),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      } catch (_) {}
    }
  }

  /// Aviso inmediato (cronómetro de cantar un tema en segundo plano).
  /// Aviso de la red de preparadores (sustitución nueva, cante cogido, reserva).
  static Future<void> avisoRed(String clave, String titulo, String texto) async {
    if (!disponibles) return;
    await iniciar();
    await _plugin.show(
      // Ids propios por encima de los de cantes y cronómetro.
      1000 + (clave.hashCode & 0x7ffff),
      titulo,
      texto,
      const NotificationDetails(
        android: AndroidNotificationDetails(color: _colorAviso, 'red', 'Preparadores y clases sueltas',
            channelDescription: 'Peticiones de sustitución, cantes cogidos y reservas', importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Tema que manda el preparador antes de la clase, como un mensaje suyo.
  /// Al tocarlo se abre la clase; con «Empezar el esquema», Cantar con ese
  /// tema y el cronómetro del esquema preparado.
  static Future<void> avisoTema({required String canteId, required String de, required String texto, required String tema, bool sorteado = false}) async {
    if (!disponibles) return;
    await iniciar();
    final persona = Person(name: de, key: de, important: true);
    await _plugin.show(
      1000 + ('tema:$canteId'.hashCode & 0x7ffff),
      de,
      texto,
      NotificationDetails(
        android: AndroidNotificationDetails(color: _colorAviso, 
          'temas',
          'Temas de tu preparador',
          channelDescription: 'El tema que te manda tu preparador antes de la clase',
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.message,
          styleInformation: MessagingStyleInformation(
            persona,
            conversationTitle: sorteado ? 'Ha salido esta bola' : null,
            messages: [Message(texto, DateTime.now(), persona)],
          ),
          actions: const [AndroidNotificationAction('esquema', 'Empezar el esquema', showsUserInterface: true)],
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: 'ruta:/cantes?cante=$canteId&tema=$tema',
    );
  }

  /// Novedad en la página del proceso selectivo: al tocarla se abre [url].
  static Future<void> avisoProceso(String clave, String titulo, String texto, String url) async {
    if (!disponibles) return;
    await iniciar();
    await _plugin.show(
      1000 + (clave.hashCode & 0x7ffff),
      titulo,
      texto,
      NotificationDetails(
        android: AndroidNotificationDetails(color: _colorAviso, 'proceso', 'Novedades del proceso selectivo',
            channelDescription: 'Documentos nuevos en la página oficial del proceso (convocatoria, listas, calendario…)',
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(texto)),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: 'url:$url',
    );
  }

  static Future<void> avisoCronometro(String texto) async {
    if (!disponibles) return;
    await iniciar();
    await _plugin.show(
      _idCronometro,
      'Cronómetro',
      texto,
      const NotificationDetails(
        android: AndroidNotificationDetails(color: _colorAviso, 'cronometro', 'Cronómetro de exposición',
            channelDescription: 'Avisos de tiempo al cantar un tema', importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails(presentSound: true),
      ),
    );
  }
}
