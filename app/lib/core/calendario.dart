/// Evento para exportar al calendario del móvil.
class EventoCalendario {
  const EventoCalendario({
    required this.uid,
    required this.titulo,
    required this.inicio,
    this.fin,
    this.todoElDia = false,
    this.descripcion = '',
    this.avisoMinutos,
  });

  final String uid;
  final String titulo;
  final DateTime inicio;
  final DateTime? fin;
  final bool todoElDia;
  final String descripcion;
  /// Minutos de antelación del recordatorio (null = sin recordatorio).
  final int? avisoMinutos;
}

/// Exportación de cantes e hitos: fichero iCalendar (.ics), que abren Google
/// Calendar, el calendario del iPhone y Outlook, y enlace directo a Google Calendar.
class Calendario {
  Calendario._();

  static String _dos(int n) => n.toString().padLeft(2, '0');
  static String _dia(DateTime d) => '${d.year}${_dos(d.month)}${_dos(d.day)}';
  static String _instante(DateTime d) {
    final u = d.toUtc();
    return '${_dia(u)}T${_dos(u.hour)}${_dos(u.minute)}${_dos(u.second)}Z';
  }

  static String _escapar(String s) =>
      s.replaceAll('\\', '\\\\').replaceAll(';', '\\;').replaceAll(',', '\\,').replaceAll('\r\n', '\\n').replaceAll('\n', '\\n');

  /// Pliega las líneas a 75 caracteres como pide el RFC 5545.
  static String _plegar(String linea) {
    if (linea.length <= 75) return linea;
    final out = StringBuffer(linea.substring(0, 75));
    for (var i = 75; i < linea.length; i += 74) {
      out.write('\r\n ${linea.substring(i, i + 74 > linea.length ? linea.length : i + 74)}');
    }
    return out.toString();
  }

  static String ics(List<EventoCalendario> eventos, {DateTime? ahora}) {
    final sello = _instante(ahora ?? DateTime.now());
    final l = <String>[
      'BEGIN:VCALENDAR',
      'VERSION:2.0',
      'PRODID:-//victorgutierrezmarcos.es//Oposicion TCEE//ES',
      'CALSCALE:GREGORIAN',
      'METHOD:PUBLISH',
    ];
    for (final e in eventos) {
      l.addAll(['BEGIN:VEVENT', 'UID:${e.uid}@victorgutierrezmarcos.es', 'DTSTAMP:$sello']);
      if (e.todoElDia) {
        l.add('DTSTART;VALUE=DATE:${_dia(e.inicio)}');
        l.add('DTEND;VALUE=DATE:${_dia(DateTime(e.inicio.year, e.inicio.month, e.inicio.day + 1))}');
      } else {
        l.add('DTSTART:${_instante(e.inicio)}');
        l.add('DTEND:${_instante(e.fin ?? e.inicio.add(const Duration(hours: 1)))}');
      }
      l.add('SUMMARY:${_escapar(e.titulo)}');
      if (e.descripcion.isNotEmpty) l.add('DESCRIPTION:${_escapar(e.descripcion)}');
      if (e.avisoMinutos != null) {
        l.addAll(['BEGIN:VALARM', 'ACTION:DISPLAY', 'DESCRIPTION:${_escapar(e.titulo)}', 'TRIGGER:-PT${e.avisoMinutos}M', 'END:VALARM']);
      }
      l.add('END:VEVENT');
    }
    l.add('END:VCALENDAR');
    return '${l.map(_plegar).join('\r\n')}\r\n';
  }

  /// Enlace que abre Google Calendar con el evento ya rellenado.
  static String urlGoogle(EventoCalendario e) {
    final fechas = e.todoElDia
        ? '${_dia(e.inicio)}/${_dia(DateTime(e.inicio.year, e.inicio.month, e.inicio.day + 1))}'
        : '${_instante(e.inicio)}/${_instante(e.fin ?? e.inicio.add(const Duration(hours: 1)))}';
    return Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': e.titulo,
      'dates': fechas,
      if (e.descripcion.isNotEmpty) 'details': e.descripcion,
    }).toString();
  }
}
