import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/oposicion.dart';
import 'notificaciones.dart';
import 'plataforma.dart';
import 'vistos.dart';

/// Tema que el preparador manda antes de una clase, ya visible.
class TemaAnticipado {
  const TemaAnticipado({required this.tema, required this.titulo, required this.preparadorNombre, required this.sorteado});
  final String tema;
  final String titulo;
  final String preparadorNombre;
  final bool sorteado;
}

/// El tema de la clase [canteId], si ya es la hora (el servidor no lo
/// entrega antes) y el preparador lo ha mandado; si no, null.
Future<TemaAnticipado?> leerTemaAnticipado(FirebaseFirestore db, Oposicion oposicion, String canteId) async {
  try {
    final d = await oposicion.red(db, 'temasAnticipados').doc(canteId).get(const GetOptions(source: Source.server));
    final j = d.data();
    if (j == null || j['tema'] == null) return null;
    return TemaAnticipado(
      tema: j['tema'] as String,
      titulo: (j['titulo'] as String?) ?? '',
      preparadorNombre: (j['preparadorNombre'] as String?) ?? 'Tu preparador',
      sorteado: j['sorteado'] == true,
    );
  } catch (_) {
    // Aún no es la hora (permiso denegado), no lo hay o no hay red.
    return null;
  }
}

/// Avisa (una sola vez) de los temas que ya han llegado: los de las clases
/// del alumno con hora de envío pasada. La usan la app abierta y la tarea en
/// segundo plano de Android.
Future<int> comprobarTemasAnticipados(FirebaseFirestore db, String uid, Oposicion oposicion, {DateTime? ahora}) async {
  final hoy = ahora ?? DateTime.now();
  final vistos = await leerVistos(lista: 'temas_anticipados');
  var avisados = 0;
  try {
    final snap = await oposicion.raizUsuario(db, uid).collection('cantes').where('temaA', isGreaterThan: hoy.subtract(const Duration(days: 3)).toIso8601String()).get();
    for (final d in snap.docs) {
      final j = d.data();
      final cuando = DateTime.tryParse((j['temaA'] as String?) ?? '');
      final clase = DateTime.tryParse((j['fecha'] as String?) ?? '');
      if (cuando == null || cuando.isAfter(hoy) || j['estado'] != 'pendiente' || j['borrado'] == true) continue;
      if (clase != null && clase.isBefore(hoy.subtract(const Duration(hours: 3)))) continue;
      final clave = '${oposicion.id}:${d.id}';
      if (vistos.contains(clave)) continue;
      final t = await leerTemaAnticipado(db, oposicion, d.id);
      if (t == null) continue;
      vistos.add(clave);
      avisados++;
      final texto = 'Tema ${t.tema}${t.titulo.isEmpty ? '' : ' · ${t.titulo}'}';
      if (Notificaciones.disponibles) {
        await Notificaciones.avisoTema(canteId: d.id, de: t.preparadorNombre, texto: texto, tema: t.tema, sorteado: t.sorteado);
      } else {
        notificacionNavegador(t.preparadorNombre, texto);
      }
    }
  } catch (_) {}
  if (avisados > 0) await guardarVistos(vistos, lista: 'temas_anticipados');
  return avisados;
}
