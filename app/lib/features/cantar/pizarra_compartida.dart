import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/oposicion.dart';
import 'pizarra_trazos.dart';

/// Sin permiso para ver la pizarra de esta clase (el enlace se ha roto o la
/// clase ya no está firmada por este preparador).
class SinAccesoPizarra implements Exception {
  const SinAccesoPizarra();
}

/// Pizarra de una clase compartida entre el alumno y su preparador: los dos
/// dibujan y cada trazo llega al otro al instante. Vive en
/// `cantes/{id}/pizarra/{p1, p2…}` dentro de los datos del alumno (una
/// página por documento; los trazos, en una lista).
///
/// Para no gastar una escritura por punto, los trazos terminados se encolan
/// y se suben juntos cada 300 ms (una escritura por ráfaga).
class PizarraCompartida {
  PizarraCompartida(this._col, {required this.miUid});

  /// Pizarra de una clase del alumno [alumnoUid].
  factory PizarraCompartida.deClase(FirebaseFirestore db, Oposicion oposicion, {required String alumnoUid, required String canteId, required String miUid}) =>
      PizarraCompartida(oposicion.raizUsuario(db, alumnoUid).collection('cantes').doc(canteId).collection('pizarra'), miUid: miUid);

  final CollectionReference<Map<String, dynamic>> _col;
  final String miUid;

  static String idPagina(int n) => 'p$n';

  /// Las páginas, con sus trazos, cada vez que cambian (de los dos). Vacío si
  /// aún no hay ninguna. Da [SinAccesoPizarra] si el servidor no deja leerla.
  Stream<List<PaginaPizarra>> escuchar() => _col.orderBy('n').snapshots().map((snap) => [for (final d in snap.docs) PaginaPizarra.fromJson(d.id, d.data())]).handleError(
        (Object e) => throw const SinAccesoPizarra(),
        test: (e) => e is FirebaseException && e.code == 'permission-denied',
      );

  Future<void> anadirTrazos(String pagina, int n, List<Trazo> trazos) async {
    if (trazos.isEmpty) return;
    await _col.doc(pagina).set({
      'n': n,
      'trazos': FieldValue.arrayUnion([for (final t in trazos) t.toJson()]),
      // Se vuelve a escribir: ya no está «recién borrada».
      'borradoPor': FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Quita un trazo: [elementoExacto] es el mapa tal como vino en el último
  /// snapshot (arrayRemove exige igualdad exacta).
  Future<void> deshacer(String pagina, Map<String, dynamic> elementoExacto) => _col.doc(pagina).update({
        'trazos': FieldValue.arrayRemove([elementoExacto]),
        'borradoPor': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  Future<void> borrarTodo(String pagina) => _col.doc(pagina).set({'trazos': <Map<String, dynamic>>[], 'borradoPor': miUid, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  /// Quita la página entera (no solo lo escrito), para los dos.
  Future<void> eliminarPagina(String pagina) => _col.doc(pagina).delete();

  Future<void> nuevaPagina(int n) => _col.doc(idPagina(n)).set({'n': n, 'trazos': <Map<String, dynamic>>[], 'creado': DateTime.now().toIso8601String(), 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  // ------------------------------------------------------------- Cola

  final Map<String, (int, List<Trazo>)> _cola = {};
  Timer? _temporizador;

  /// Trazos encolados y aún no subidos.
  bool get conPendientes => _cola.values.any((e) => e.$2.isNotEmpty);

  /// Encola un trazo terminado: se sube con los demás de la ráfaga.
  void encolar(String pagina, int n, Trazo t) {
    _cola.putIfAbsent(pagina, () => (n, [])).$2.add(t);
    _temporizador ??= Timer(const Duration(milliseconds: 300), vaciar);
  }

  /// Quita de la cola un trazo que aún no se ha subido. Devuelve si estaba.
  bool quitarDeCola(String id) {
    var quitado = false;
    for (final e in _cola.values) {
      quitado |= e.$2.remove(e.$2.where((t) => t.id == id).firstOrNull);
    }
    return quitado;
  }

  /// Sube lo encolado (una escritura por página).
  Future<void> vaciar() async {
    _temporizador?.cancel();
    _temporizador = null;
    final pendiente = Map.of(_cola);
    _cola.clear();
    for (final e in pendiente.entries) {
      try {
        await anadirTrazos(e.key, e.value.$1, e.value.$2);
      } catch (_) {
        // Sin red: se reintenta con la siguiente ráfaga.
        _cola.putIfAbsent(e.key, () => (e.value.$1, [])).$2.addAll(e.value.$2);
        _temporizador ??= Timer(const Duration(seconds: 3), vaciar);
      }
    }
  }
}
