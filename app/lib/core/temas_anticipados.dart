import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/oposicion.dart';
import 'notificaciones.dart';
import 'plataforma.dart';
import 'vistos.dart';

/// Tema (o temas) que el preparador manda antes de una clase, ya visible.
class TemaAnticipado {
  const TemaAnticipado({required this.tema, required this.titulo, required this.preparadorNombre, required this.sorteado, this.temas = const [], this.titulos = const []});
  /// El primero (las clases de antes mandaban uno solo).
  final String tema;
  final String titulo;
  final String preparadorNombre;
  final bool sorteado;
  /// Todos los temas mandados (al menos [tema]) y sus títulos, en el mismo orden.
  final List<String> temas;
  final List<String> titulos;

  /// «Tema 3.A.2 · Título» o «Temas 3.A.2 y 3.B.5 · Título 1 · Título 2».
  String get texto => temas.length <= 1
      ? 'Tema $tema${titulo.isEmpty ? '' : ' · $titulo'}'
      : 'Temas ${temas.take(temas.length - 1).join(', ')} y ${temas.last}${titulos.any((t) => t.isNotEmpty) ? ' · ${titulos.where((t) => t.isNotEmpty).join(' · ')}' : ''}';
}

/// El tema de la clase [canteId], si ya es la hora (el servidor no lo
/// entrega antes) y el preparador lo ha mandado; si no, null.
Future<TemaAnticipado?> leerTemaAnticipado(FirebaseFirestore db, Oposicion oposicion, String canteId) async {
  try {
    final d = await oposicion.red(db, 'temasAnticipados').doc(canteId).get(const GetOptions(source: Source.server));
    final j = d.data();
    if (j == null || j['tema'] == null) return null;
    final temas = j['temas'] is List ? [for (final t in j['temas'] as List) t.toString()] : [j['tema'] as String];
    final titulos = j['titulos'] is List ? [for (final t in j['titulos'] as List) t.toString()] : [(j['titulo'] as String?) ?? ''];
    return TemaAnticipado(
      tema: j['tema'] as String,
      titulo: (j['titulo'] as String?) ?? '',
      preparadorNombre: (j['preparadorNombre'] as String?) ?? 'Tu preparador',
      sorteado: j['sorteado'] == true,
      temas: temas.isEmpty ? [j['tema'] as String] : temas,
      titulos: titulos,
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
      final texto = t.texto;
      if (Notificaciones.disponibles) {
        await Notificaciones.avisoTema(canteId: d.id, de: t.preparadorNombre, texto: texto, tema: t.temas.join(','), sorteado: t.sorteado);
      } else {
        notificacionNavegador(t.preparadorNombre, texto);
      }
    }
  } catch (_) {}
  if (avisados > 0) await guardarVistos(vistos, lista: 'temas_anticipados');
  return avisados;
}
