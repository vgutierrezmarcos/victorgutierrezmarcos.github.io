import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/plan.dart';

/// Permiso de Google para crear, cambiar y borrar eventos del calendario del
/// usuario (no da acceso a sus otros calendarios ni a leer sus eventos ajenos
/// a la app más allá de lo que ella crea).
const ambitoCalendario = 'https://www.googleapis.com/auth/calendar.events';

/// Las clases del preparador en su Google Calendar, con la API de Calendar
/// directamente desde el dispositivo (sin servidor):
/// - al programar una clase se crea su evento y, si es online y no tiene
///   enlace, la reunión de Meet; el alumno va como invitado (le llega la
///   invitación de Google y la clase aparece en su calendario);
/// - al cambiarla, se cambia el evento; al cancelarla o borrarla, se borra
///   (Google avisa al alumno en los dos casos).
///
/// [token] da el token de acceso de Google con el permiso [ambitoCalendario]
/// (null si no lo hay). [huellas] guarda, por clase, lo último que se mandó,
/// para no volver a mandar el evento si no ha cambiado.
class CalendarioGoogle {
  CalendarioGoogle({required this.token, Dio? dio, Box? huellas})
      : _dio = dio ?? Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 20))),
        _huellas = huellas;

  final Future<String?> Function() token;
  final Dio _dio;
  final Box? _huellas;
  final Map<String, String> _huellasMemoria = {};

  static const _eventos = 'https://www.googleapis.com/calendar/v3/calendars/primary/events';

  /// El último error al hablar con Google (para enseñarlo en Ajustes).
  String? ultimoError;

  String? _huella(String id) => _huellas?.get('cal:$id') as String? ?? _huellasMemoria[id];
  Future<void> _guardarHuella(String id, String? h) async {
    if (h == null) {
      _huellasMemoria.remove(id);
      await _huellas?.delete('cal:$id');
    } else {
      _huellasMemoria[id] = h;
      await _huellas?.put('cal:$id', h);
    }
  }

  /// El evento de la clase [c] con [alumno] (y su [email], si se le invita).
  Map<String, dynamic> evento(Cante c, {String alumno = '', String email = '', String preparador = '', String siglas = ''}) {
    final inicio = c.fecha.toUtc();
    final fin = inicio.add(Duration(minutes: c.minutos <= 0 ? 60 : c.minutos));
    final con = [if (preparador.isNotEmpty) preparador, if (alumno.isNotEmpty) alumno].join(' y ');
    final crearMeet = c.online && c.enlace.isEmpty;
    return {
      'summary': 'Clase de ${siglas.isEmpty ? 'oposición' : siglas}${con.isEmpty ? '' : ': $con'}',
      'description': [
        if (c.temas.isNotEmpty) 'Temas: ${c.temas.join(', ')}',
        if (c.notas.trim().isNotEmpty) c.notas.trim(),
        if (c.online && c.enlace.isNotEmpty) 'Enlace de la clase: ${c.enlace}',
        'Programada con la app Oposición TCEE · DCE.',
      ].join('\n'),
      'start': {'dateTime': inicio.toIso8601String(), 'timeZone': 'Europe/Madrid'},
      'end': {'dateTime': fin.toIso8601String(), 'timeZone': 'Europe/Madrid'},
      if (c.presencial && c.lugar.isNotEmpty) 'location': c.lugar,
      if (c.online && c.enlace.isNotEmpty) 'location': c.enlace,
      'attendees': [if (email.isNotEmpty) {'email': email, if (alumno.isNotEmpty) 'displayName': alumno}],
      if (crearMeet)
        'conferenceData': {
          'createRequest': {
            'requestId': 'clase-${c.id}-${DateTime.now().millisecondsSinceEpoch}',
            'conferenceSolutionKey': {'type': 'hangoutsMeet'},
          },
        },
      'extendedProperties': {
        'private': {'app': 'oposicion-tcee-dce', 'clase': c.id},
      },
      'reminders': {'useDefault': true},
    };
  }

  /// Lleva la clase [c] al calendario. Devuelve la clase con lo que cambia
  /// (el evento y, si se ha creado la reunión, su enlace de Meet) o null si
  /// no hay nada que guardar. Sin token no hace nada (null). Lanza
  /// [DioException] si Google responde con error.
  Future<Cante?> sincronizar(Cante c, {String alumno = '', String email = '', String preparador = '', String siglas = '', DateTime? ahora}) async {
    final hoy = ahora ?? DateTime.now();
    // Cancelada o borrada: fuera del calendario.
    if (c.borrado || c.cancelado) {
      if (c.eventoGoogle.isEmpty) return null;
      final t = await token();
      if (t == null) return null;
      await _borrar(c.eventoGoogle, t);
      await _guardarHuella(c.id, null);
      return c.copyWith(eventoGoogle: '');
    }
    // Hecha, o pasada sin evento: no se toca.
    if (c.hecho || (c.eventoGoogle.isEmpty && c.fecha.isBefore(hoy.subtract(const Duration(hours: 12))))) return null;

    final cuerpo = evento(c, alumno: alumno, email: email, preparador: preparador, siglas: siglas);
    final huella = _huellaDe(cuerpo);
    if (c.eventoGoogle.isNotEmpty && _huella(c.id) == huella) return null;
    final t = await token();
    if (t == null) return null;

    Map<String, dynamic> r;
    if (c.eventoGoogle.isEmpty) {
      r = await _crear(cuerpo, t);
    } else {
      try {
        r = await _cambiar(c.eventoGoogle, cuerpo, t);
      } on DioException catch (e) {
        // Si el preparador lo borró a mano en su calendario, se vuelve a crear.
        if (e.response?.statusCode != 404 && e.response?.statusCode != 410) rethrow;
        r = await _crear(cuerpo, t);
      }
    }
    ultimoError = null;
    final id = r['id'] as String? ?? c.eventoGoogle;
    final meet = r['hangoutLink'] as String?;
    final enlace = c.online && c.enlace.isEmpty && meet != null && meet.isNotEmpty ? meet : null;
    // La huella, con el enlace ya puesto (así no se vuelve a mandar).
    final guardada = enlace == null ? c.copyWith(eventoGoogle: id) : c.copyWith(eventoGoogle: id, enlace: enlace);
    await _guardarHuella(c.id, _huellaDe(evento(guardada, alumno: alumno, email: email, preparador: preparador, siglas: siglas)));
    if (id == c.eventoGoogle && enlace == null) return null;
    return guardada;
  }

  /// Prueba que el permiso funciona (lista un evento del calendario).
  Future<void> comprobar() async {
    final t = await token();
    if (t == null) throw StateError('sin permiso');
    await _dio.get(_eventos, queryParameters: {'maxResults': 1}, options: _opciones(t));
  }

  Options _opciones(String t) => Options(headers: {'Authorization': 'Bearer $t'}, contentType: 'application/json');

  Future<Map<String, dynamic>> _crear(Map<String, dynamic> cuerpo, String t) async {
    final r = await _dio.post(_eventos, queryParameters: {'conferenceDataVersion': 1, 'sendUpdates': 'all'}, data: cuerpo, options: _opciones(t));
    return Map<String, dynamic>.from(r.data as Map);
  }

  Future<Map<String, dynamic>> _cambiar(String id, Map<String, dynamic> cuerpo, String t) async {
    final r = await _dio.patch('$_eventos/$id', queryParameters: {'conferenceDataVersion': 1, 'sendUpdates': 'all'}, data: cuerpo, options: _opciones(t));
    return Map<String, dynamic>.from(r.data as Map);
  }

  Future<void> _borrar(String id, String t) async {
    try {
      await _dio.delete('$_eventos/$id', queryParameters: {'sendUpdates': 'all'}, options: _opciones(t));
    } on DioException catch (e) {
      // Ya no estaba: da igual.
      if (e.response?.statusCode != 404 && e.response?.statusCode != 410) rethrow;
    }
  }

  /// Lo que importa del evento para saber si ha cambiado (sin el id de la
  /// petición de Meet, que es distinto cada vez).
  static String _huellaDe(Map<String, dynamic> cuerpo) {
    final copia = Map<String, dynamic>.from(cuerpo)..remove('conferenceData');
    return jsonEncode(copia);
  }
}
