import 'package:intl/intl.dart';

import '../../core/calendario.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../data/repos/usuario_repo.dart';

/// Temas que entran en el sorteo de un cante según su tipo de bolsa.
List<Tema> temasDeCante(Cante c, Temario temario, Ajustes ajustes) {
  bool delEjercicio(Tema t) => c.ejercicio == 0 ? (t.ejercicio == 3 || t.ejercicio == 4) : t.ejercicio == c.ejercicio;
  return switch (c.bolsa) {
    TipoBolsa.lista => [for (final codigo in c.temas) if (temario.tema(codigo) != null) temario.tema(codigo)!],
    TipoBolsa.estudiados => temario.todosLosTemas.where((t) => delEjercicio(t) && ajustes.temasEstudiados.contains(t.codigo)).toList(),
    TipoBolsa.ejercicio => temario.todosLosTemas.where(delEjercicio).toList(),
  };
}

String nombreEjercicio(int ejercicio) => switch (ejercicio) {
      1 => 'Primer ejercicio',
      2 => 'Segundo ejercicio',
      3 => 'Tercer ejercicio',
      4 => 'Cuarto ejercicio',
      5 => 'Quinto ejercicio',
      _ => '3.º y 4.º ejercicio',
    };

String descripcionBolsa(Cante c) => switch (c.bolsa) {
      TipoBolsa.lista => '${c.temas.length} temas elegidos',
      TipoBolsa.estudiados => 'Temas estudiados · ${nombreEjercicio(c.ejercicio).toLowerCase()}',
      TipoBolsa.ejercicio => 'Todos los temas · ${nombreEjercicio(c.ejercicio).toLowerCase()}',
    };

String tituloCante(Cante c) => c.titulo.isEmpty ? 'Cante' : c.titulo;

String fechaLarga(DateTime f) => DateFormat("EEEE d 'de' MMMM", 'es').format(f);
String fechaCorta(DateTime f) => DateFormat('EEE d MMM', 'es').format(f);
String horaDe(DateTime f) => DateFormat('HH:mm').format(f);

EventoCalendario eventoDeCante(Cante c) => EventoCalendario(
      uid: 'cante-${c.id}',
      titulo: 'Cante TCEE${c.titulo.isEmpty ? '' : ' · ${c.titulo}'}',
      inicio: c.fecha,
      fin: c.fecha.add(Duration(minutes: c.minutos)),
      descripcion: [descripcionBolsa(c), if (c.notas.isNotEmpty) c.notas].join('\n'),
      avisoMinutos: 60,
    );

EventoCalendario eventoDeFecha(String id, String titulo, DateTime fecha) =>
    EventoCalendario(uid: 'hito-$id', titulo: titulo, inicio: fecha, todoElDia: true);

/// Cantes de una serie semanal desde [primero] hasta [hasta] (incluido).
List<Cante> serieSemanal(Cante primero, DateTime hasta) {
  final serie = nuevoId();
  final out = <Cante>[];
  for (var i = 0; i < 104; i++) {
    final f = DateTime(primero.fecha.year, primero.fecha.month, primero.fecha.day + 7 * i, primero.fecha.hour, primero.fecha.minute);
    if (f.isAfter(DateTime(hasta.year, hasta.month, hasta.day, 23, 59))) break;
    out.add(Cante(
      id: i == 0 ? primero.id : nuevoId(),
      fecha: f,
      titulo: primero.titulo,
      minutos: primero.minutos,
      ejercicio: primero.ejercicio,
      bolsa: primero.bolsa,
      temas: primero.temas,
      notas: primero.notas,
      serie: serie,
      updatedAt: DateTime.now(),
    ));
  }
  return out;
}
