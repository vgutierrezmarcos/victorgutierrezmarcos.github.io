import 'package:intl/intl.dart';

import '../../core/calendario.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../data/repos/usuario_repo.dart';

/// Temas que entran en el sorteo de un cante según su tipo de bolsa.
List<Tema> temasDeCante(Cante c, Temario temario, Ajustes ajustes) {
  final oposicion = Oposiciones.actual;
  // Dictamen (1.º de TCEE): se canta sin temas.
  if (oposicion.esDictamen(c.ejercicio)) return const [];
  final ejercicios = oposicion.ejerciciosDeBolsa(c.ejercicio);
  bool delEjercicio(Tema t) => ejercicios.contains(t.ejercicio);
  return switch (c.bolsa) {
    TipoBolsa.lista => [for (final codigo in c.temas) if (temario.tema(codigo) != null) temario.tema(codigo)!],
    TipoBolsa.estudiados => temario.todosLosTemas.where((t) => delEjercicio(t) && ajustes.temasEstudiados.contains(t.codigo)).toList(),
    TipoBolsa.ejercicio => temario.todosLosTemas.where(delEjercicio).toList(),
  };
}

/// «Tercer ejercicio» (0: «3.º y 4.º ejercicio»).
String nombreEjercicio(int ejercicio) => Oposiciones.actual.nombreEjercicio(ejercicio);

String descripcionBolsa(Cante c) => Oposiciones.actual.esDictamen(c.ejercicio) ? _descripcionDictamen(c.ejercicio) : switch (c.bolsa) {
      TipoBolsa.lista => '${c.temas.length} temas elegidos',
      TipoBolsa.estudiados => 'Temas estudiados · ${nombreEjercicio(c.ejercicio).toLowerCase()}',
      TipoBolsa.ejercicio => 'Todos los temas · ${nombreEjercicio(c.ejercicio).toLowerCase()}',
    };

/// «Dictamen de coyuntura · primer ejercicio».
String _descripcionDictamen(int ejercicio) {
  final e = Oposiciones.actual.ejercicio(ejercicio)!;
  final que = e.queSeCanta ?? 'cante';
  return '${que[0].toUpperCase()}${que.substring(1)} · ${e.nombre.toLowerCase()}';
}

/// Qué se canta y, si se sabe, si es online o presencial (para las listas).
String detalleCante(Cante c) => [descripcionBolsa(c), if (c.online) 'online' else if (c.presencial) 'presencial'].join(' · ');

String tituloCante(Cante c) => c.titulo.isEmpty ? 'Cante' : c.titulo;

/// «2 h», «1 h 30 min», «45 min».
String textoDuracion(int minutos) {
  if (minutos <= 0) return '';
  final h = minutos ~/ 60, m = minutos % 60;
  return [if (h > 0) '$h h', if (m > 0) '$m min'].join(' ');
}

/// Duraciones que se ofrecen para una clase con el preparador (minutos).
const duracionesClase = [60, 90, 120, 150, 180];

/// Duraciones que se ofrecen para un cante por cuenta propia (minutos).
const duracionesCante = [15, 20, 30, 45, 60];

/// Minutos de exposición por tema que se ofrecen.
const duracionesExposicion = [10, 15, 20, 30, 45];

String fechaLarga(DateTime f) => DateFormat("EEEE d 'de' MMMM", 'es').format(f);
String fechaCorta(DateTime f) => DateFormat('EEE d MMM', 'es').format(f);
String horaDe(DateTime f) => DateFormat('HH:mm').format(f);

EventoCalendario eventoDeCante(Cante c) => EventoCalendario(
      uid: 'cante-${c.id}',
      titulo: 'Cante ${Oposiciones.actual.siglas}${c.titulo.isEmpty ? '' : ' · ${c.titulo}'}',
      inicio: c.fecha,
      fin: c.fecha.add(Duration(minutes: c.minutos)),
      descripcion: [descripcionBolsa(c), if (c.online) c.enlace.isEmpty ? 'Online' : 'Online: ${c.enlace}', if (c.notas.isNotEmpty) c.notas].join('\n'),
      avisoMinutos: 60,
      lugar: c.online ? c.enlace : c.lugar,
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
      exposicion: primero.exposicion,
      ejercicio: primero.ejercicio,
      bolsa: primero.bolsa,
      temas: primero.temas,
      notas: primero.notas,
      serie: serie,
      alumno: primero.alumno,
      preparador: primero.preparador,
      preparadorNombre: primero.preparadorNombre,
      // Presencial u online, dónde y el enlace: igual en todas las de la serie.
      modalidad: primero.modalidad,
      lugar: primero.lugar,
      enlace: primero.enlace,
      plataforma: primero.plataforma,
      numTemas: primero.numTemas,
      unoPorParte: primero.unoPorParte,
      updatedAt: DateTime.now(),
    ));
  }
  return out;
}
