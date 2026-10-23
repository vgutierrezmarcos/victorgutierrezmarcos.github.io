import 'package:intl/intl.dart';

import '../../core/calendario.dart';
import '../../data/models/cronograma.dart';
import '../../data/models/oposicion.dart';
import '../../data/models/plan.dart';
import '../../data/models/temario.dart';
import '../../data/models/temas_clase.dart';
import '../../data/repos/usuario_repo.dart';

/// Temas que entran en el sorteo de un cante según su tipo de bolsa.
///
/// En una clase con preparador ([clase]; por defecto, las que trae el alumno
/// de su preparador), «los estudiados» son los temas que el opositor lleva a
/// ESA clase, iguales en las dos apps ([temasDeLaClase]): los que eligió para
/// ella o, si no, los de la semana de su cronograma cuyo cante cae ese día; si
/// no hay ninguno, la bolsa está vacía hasta que los indique. En la app del
/// preparador la clase no lleva `preparador`, así que se pasa `clase: true`.
List<Tema> temasDeCante(Cante c, Temario temario, Ajustes ajustes, {Cronograma? cronograma, bool? clase}) {
  final oposicion = Oposiciones.actual;
  // Dictamen (1.º de TCEE): se canta sin temas.
  if (oposicion.esDictamen(c.ejercicio)) return const [];
  final ejercicios = oposicion.ejerciciosDeBolsa(c.ejercicio);
  bool delEjercicio(Tema t) => ejercicios.contains(t.ejercicio);
  final estudiados = (clase ?? c.dePreparador)
      ? temasDeLaClase(c, elegidos: ajustes.temasClases, cronograma: cronograma, noCantar: ajustes.noCantar).temas.toSet()
      : ajustes.temasEstudiados;
  return switch (c.bolsa) {
    TipoBolsa.lista => [for (final codigo in c.temas) if (temario.tema(codigo) != null) temario.tema(codigo)!],
    TipoBolsa.estudiados => temario.todosLosTemas.where((t) => delEjercicio(t) && estudiados.contains(t.codigo)).toList(),
    TipoBolsa.ejercicio => temario.todosLosTemas.where(delEjercicio).toList(),
  };
}

/// Los temas que lleva el opositor para las clases, sin los que pide no cantar.
/// Con [fecha] (la de la clase) y un cronograma con una semana para ese cante,
/// son los temas de esa semana ([Cronograma.temasDelCante]); si no, los
/// estudiados más los del cronograma hasta hoy (lo que calcula el preparador
/// en la ficha del alumno).
Set<String> temasQueLleva(Ajustes ajustes, Cronograma? cronograma, {DateTime? fecha}) {
  final delCante = fecha == null ? null : cronograma?.temasDelCante(fecha);
  final base = delCante != null ? delCante.toSet() : {...ajustes.temasEstudiados, ...?cronograma?.temasLlevados(DateTime.now())};
  return base..removeAll(ajustes.noCantar.keys);
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

/// El próximo [diaSemana] (1 = lunes … 7 = domingo) después de [desde], a las
/// [hora]:[minuto]: el día de cante del cronograma del alumno al programarle
/// una clase. Nunca el mismo día de [desde].
DateTime proximoDiaDeSemana(DateTime desde, int diaSemana, {int hora = 17, int minuto = 0}) {
  final hoy = DateTime(desde.year, desde.month, desde.day);
  final salto = (diaSemana - hoy.weekday + 7) % 7;
  return DateTime(hoy.year, hoy.month, hoy.day + (salto == 0 ? 7 : salto), hora, minuto);
}

/// Línea de un cante hecho en el diario: «3.A.1 · Objeto y métodos» o, con
/// varios temas, «3.A.1 y 3.B.2» (todos, no solo el primero).
String tituloCanteHecho(Cante c, String Function(String codigo) titulo) {
  final temas = c.resultado?.temasCantados ?? const <String>[];
  if (temas.isEmpty) return tituloCante(c);
  if (temas.length == 1) return '${temas.first} · ${titulo(temas.first)}';
  return temas.join(' y ');
}

/// «2 h», «1 h 30 min», «45 min».
String textoDuracion(int minutos) {
  if (minutos <= 0) return '';
  final h = minutos ~/ 60, m = minutos % 60;
  return [if (h > 0) '$h h', if (m > 0) '$m min'].join(' ');
}

/// Duraciones que se ofrecen para una clase con el preparador (minutos).
const duracionesClase = [60, 90, 120, 150, 180];

/// Duraciones que se ofrecen para un cante por cuenta propia (minutos).
const duracionesCante = [30, 45, 60, 90, 120];

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

/// Cantes de una serie desde [primero] hasta [hasta] (incluido), uno cada
/// [cadaSemanas] semanas.
List<Cante> serieSemanal(Cante primero, DateTime hasta, {int cadaSemanas = 1}) {
  final serie = nuevoId();
  final out = <Cante>[];
  for (var i = 0; i < 104; i++) {
    final f = DateTime(primero.fecha.year, primero.fecha.month, primero.fecha.day + 7 * cadaSemanas * i, primero.fecha.hour, primero.fecha.minute);
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
