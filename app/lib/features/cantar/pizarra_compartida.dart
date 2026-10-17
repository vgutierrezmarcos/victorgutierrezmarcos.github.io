import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/oposicion.dart';
import 'pizarra_trazos.dart';

/// Sin permiso para ver la pizarra de esta clase (el enlace se ha roto o la
/// clase ya no está firmada por este preparador).
class SinAccesoPizarra implements Exception {
  const SinAccesoPizarra();
}

/// Lo que necesita la pizarra para guardar y recibir los trazos: la de una
/// clase ([PizarraCompartida], en la nube) o la de practicar ([PizarraLocal]).
abstract class FuentePizarra {
  Stream<List<PaginaPizarra>> escuchar();
  void encolar(String pagina, int n, Trazo t);
  bool quitarDeCola(String id);
  Future<void> vaciar();
  Future<void> deshacer(String pagina, Map<String, dynamic> elementoExacto);
  Future<void> borrarTodo(String pagina);
  Future<void> eliminarPagina(String pagina);
  Future<void> nuevaPagina(int n);

  /// Quita de la página los trazos [quitar] (por id) y añade [poner], de una
  /// vez: mover con el lazo, borrar por partes, deshacer y rehacer.
  Future<void> reemplazar(String pagina, int n, List<Trazo> quitar, List<Trazo> poner);

  /// Cambia el papel de la página ([fondoBlanco], [fondoRayas]…).
  Future<void> cambiarFondo(String pagina, int n, String fondo);
}

/// Pizarra para practicar sola (sin clase): los trazos se quedan en memoria,
/// no van a ningún sitio y se pierden al cerrarla.
class PizarraLocal implements FuentePizarra {
  final Map<String, (int, List<Map<String, dynamic>>)> _paginas = {};
  final Map<String, String> _fondos = {};
  final _cambios = StreamController<List<PaginaPizarra>>.broadcast();

  List<PaginaPizarra> get _lista {
    final ids = _paginas.keys.toList()..sort((a, b) => _paginas[a]!.$1.compareTo(_paginas[b]!.$1));
    return [for (final id in ids) PaginaPizarra.fromJson(id, {'n': _paginas[id]!.$1, 'trazos': List.of(_paginas[id]!.$2), if (_fondos[id] != null) 'fondo': _fondos[id]})];
  }

  void _avisar() => Future.microtask(() => _cambios.add(_lista));

  @override
  Stream<List<PaginaPizarra>> escuchar() => _cambios.stream;

  @override
  void encolar(String pagina, int n, Trazo t) {
    _paginas.putIfAbsent(pagina, () => (n, [])).$2.add(t.toJson());
    _avisar();
  }

  @override
  bool quitarDeCola(String id) => false;

  @override
  Future<void> vaciar() async {}

  @override
  Future<void> deshacer(String pagina, Map<String, dynamic> elementoExacto) async {
    _paginas[pagina]?.$2.removeWhere((t) => t['i'] == elementoExacto['i']);
    _avisar();
  }

  @override
  Future<void> borrarTodo(String pagina) async {
    _paginas[pagina]?.$2.clear();
    _avisar();
  }

  @override
  Future<void> eliminarPagina(String pagina) async {
    _paginas.remove(pagina);
    _avisar();
  }

  @override
  Future<void> nuevaPagina(int n) async {
    _paginas.putIfAbsent(PizarraCompartida.idPagina(n), () => (n, []));
    _avisar();
  }

  @override
  Future<void> reemplazar(String pagina, int n, List<Trazo> quitar, List<Trazo> poner) async {
    final ids = {for (final t in [...quitar, ...poner]) t.id};
    final lista = _paginas.putIfAbsent(pagina, () => (n, [])).$2;
    lista
      ..removeWhere((t) => ids.contains(t['i']))
      ..addAll([for (final t in poner) t.toJson()]);
    _avisar();
  }

  @override
  Future<void> cambiarFondo(String pagina, int n, String fondo) async {
    _paginas.putIfAbsent(pagina, () => (n, []));
    _fondos[pagina] = fondo;
    _avisar();
  }
}

/// Pizarra de una clase compartida entre el alumno y su preparador: los dos
/// dibujan y cada trazo llega al otro al instante. Vive en
/// `cantes/{id}/pizarra/{p1, p2…}` dentro de los datos del alumno (una
/// página por documento; los trazos, en una lista).
///
/// Para no gastar una escritura por punto, los trazos terminados se encolan
/// y se suben juntos cada 300 ms (una escritura por ráfaga).
class PizarraCompartida implements FuentePizarra {
  PizarraCompartida(this._col, {required this.miUid});

  /// Pizarra de una clase del alumno [alumnoUid].
  factory PizarraCompartida.deClase(FirebaseFirestore db, Oposicion oposicion, {required String alumnoUid, required String canteId, required String miUid}) =>
      PizarraCompartida(oposicion.raizUsuario(db, alumnoUid).collection('cantes').doc(canteId).collection('pizarra'), miUid: miUid);

  final CollectionReference<Map<String, dynamic>> _col;
  final String miUid;

  static String idPagina(int n) => 'p$n';

  /// Las páginas, con sus trazos, cada vez que cambian (de los dos). Vacío si
  /// aún no hay ninguna. Da [SinAccesoPizarra] si el servidor no deja leerla.
  @override
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
  @override
  Future<void> deshacer(String pagina, Map<String, dynamic> elementoExacto) => _col.doc(pagina).update({
        'trazos': FieldValue.arrayRemove([elementoExacto]),
        'borradoPor': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  @override
  Future<void> borrarTodo(String pagina) => _col.doc(pagina).set({'trazos': <Map<String, dynamic>>[], 'borradoPor': miUid, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  /// Quita la página entera (no solo lo escrito), para los dos.
  @override
  Future<void> eliminarPagina(String pagina) => _col.doc(pagina).delete();

  @override
  Future<void> nuevaPagina(int n) => _col.doc(idPagina(n)).set({'n': n, 'trazos': <Map<String, dynamic>>[], 'creado': DateTime.now().toIso8601String(), 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  /// En una transacción: arrayRemove pide el elemento exacto y no se puede
  /// combinar con arrayUnion en la misma escritura.
  @override
  Future<void> reemplazar(String pagina, int n, List<Trazo> quitar, List<Trazo> poner) async {
    // Lo encolado sale antes, para que no vuelva después de quitarlo.
    await vaciar();
    final ref = _col.doc(pagina);
    final ids = {for (final t in [...quitar, ...poner]) t.id};
    await _col.firestore.runTransaction((tx) async {
      final actual = await tx.get(ref);
      final quedan = [for (final t in (actual.data()?['trazos'] as List?) ?? const []) if (t is Map && !ids.contains(t['i'])) t];
      tx.set(ref, {
        'n': n,
        'trazos': [...quedan, for (final t in poner) t.toJson()],
        'borradoPor': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  @override
  Future<void> cambiarFondo(String pagina, int n, String fondo) => _col.doc(pagina).set({'n': n, 'fondo': fondo, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));

  // ------------------------------------------------------------- Cola

  final Map<String, (int, List<Trazo>)> _cola = {};
  Timer? _temporizador;

  /// Trazos encolados y aún no subidos.
  bool get conPendientes => _cola.values.any((e) => e.$2.isNotEmpty);

  /// Encola un trazo terminado: se sube con los demás de la ráfaga.
  @override
  void encolar(String pagina, int n, Trazo t) {
    _cola.putIfAbsent(pagina, () => (n, [])).$2.add(t);
    _temporizador ??= Timer(const Duration(milliseconds: 300), vaciar);
  }

  /// Quita de la cola un trazo que aún no se ha subido. Devuelve si estaba.
  @override
  bool quitarDeCola(String id) {
    var quitado = false;
    for (final e in _cola.values) {
      quitado |= e.$2.remove(e.$2.where((t) => t.id == id).firstOrNull);
    }
    return quitado;
  }

  /// Sube lo encolado (una escritura por página).
  @override
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
