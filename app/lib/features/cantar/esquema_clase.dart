import 'package:cloud_firestore/cloud_firestore.dart';

import 'reloj_cante.dart';

/// Tiempo de esquema de una clase con preparador, el mismo en el cronómetro y
/// en los avisos. Antes los avisos usaban siempre el del examen (22'30" para
/// un tema de TCEE) aunque la clase se hubiera puesto con otro (30'): el
/// cronómetro daba 30' y la notificación decía 22'30".
///
/// Por orden: el del cronómetro compartido de la clase ([reloj], el documento
/// `cantes/{id}/reloj/estado`, que es lo que de verdad va a contar), el que
/// lleva la clase ([deLaClase], `Cante.segundosEsquema`) y, si no hay
/// ninguno, el del examen ([delExamen]).
int segundosEsquemaVigente({Map<String, dynamic>? reloj, int? deLaClase, required int delExamen}) {
  final delReloj = reloj?['esquema'];
  if (delReloj is num && delReloj >= 0) return delReloj.toInt();
  return deLaClase ?? delExamen;
}

/// Hasta cuándo dura el esquema que anuncia el aviso de los temas, que
/// llegan en [llegada]: si el cronómetro de la clase ya corre en el esquema,
/// hasta cuando acabe ese esquema; si ya está en la exposición, null (no hay
/// cuenta atrás que enseñar); si no ha empezado, [segundos] desde que llegan
/// los temas (como en el examen). Null también sin esquema o si ya pasó.
DateTime? finDelEsquema({required DateTime llegada, required int segundos, RelojCante? reloj, required DateTime ahora}) {
  if (reloj != null && reloj.empezado) {
    if (!reloj.enPreparacion(ahora)) return null;
    return reloj.corriendo ? ahora.add(reloj.restanteFase(ahora)) : null;
  }
  if (segundos <= 0) return null;
  final fin = llegada.add(Duration(seconds: segundos));
  return fin.isAfter(ahora) ? fin : null;
}

/// El cronómetro compartido de la clase tal como está guardado (o null si
/// no existe o no se puede leer), con su hora del servidor.
({Map<String, dynamic> datos, RelojCante reloj})? relojGuardado(Map<String, dynamic>? j, {DateTime? ahora}) {
  if (j == null || j['esquema'] == null) return null;
  final cambiado = (j['cambiado'] as Timestamp?)?.toDate();
  return (datos: j, reloj: RelojCante.desdeJson(j, guardado: cambiado ?? ahora ?? DateTime.now()));
}

/// «22 min 30 s», «30 min»: para los avisos.
String textoEsquema(int segundos) {
  final m = segundos ~/ 60, s = segundos % 60;
  if (m == 0) return '$s s';
  return s == 0 ? '$m min' : '$m min $s s';
}

/// «17:05».
String horaCorta(DateTime d) => '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
