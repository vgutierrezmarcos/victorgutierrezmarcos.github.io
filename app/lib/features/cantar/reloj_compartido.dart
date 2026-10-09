import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/oposicion.dart';
import 'reloj_cante.dart';

/// Firestore del cronómetro compartido (en las capturas de la app, una simulada).
final firestoreRelojProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// Estado del cronómetro compartido de una clase, tal como lo dejó el último
/// que lo tocó (alumno o preparador).
class EstadoRelojCompartido {
  const EstadoRelojCompartido({required this.reloj, required this.activo, required this.por, required this.porNombre, required this.temas, this.elegido});

  /// El reloj ya traducido a la hora de este dispositivo.
  final RelojCante reloj;

  /// Alguien lo está usando (si no, se dejó de compartir).
  final bool activo;
  final String por;
  final String porNombre;

  /// Temas sorteados y el elegido para cantar.
  final List<String> temas;
  final String? elegido;
}

/// Cronómetro de una clase compartido entre el alumno y su preparador, estén
/// juntos (presencial) o cada uno en su casa: los dos ven el mismo tiempo y
/// cualquiera puede empezarlo, pararlo o darle más tiempo.
///
/// Vive en `cantes/{id}/reloj/estado` dentro de los datos del alumno. El
/// tiempo se guarda como «acumulado en tal instante del servidor»; cada
/// dispositivo lo traduce a su reloj con el desfase que mide al unirse.
class RelojCompartido {
  RelojCompartido(this._doc, {required this.miUid, required this.miNombre});

  /// Documento de una clase del alumno [alumnoUid].
  factory RelojCompartido.deClase(FirebaseFirestore db, Oposicion oposicion, {required String alumnoUid, required String canteId, required String miUid, required String miNombre}) =>
      RelojCompartido(oposicion.raizUsuario(db, alumnoUid).collection('cantes').doc(canteId).collection('reloj').doc('estado'), miUid: miUid, miNombre: miNombre);

  final DocumentReference<Map<String, dynamic>> _doc;
  final String miUid;
  final String miNombre;

  /// Hora local menos hora del servidor (se mide al unirse).
  Duration _desfase = Duration.zero;

  /// Mide el desfase entre este dispositivo y el servidor con una escritura.
  Future<void> medirDesfase() async {
    try {
      final antes = DateTime.now();
      await _doc.set({'latido': {miUid: FieldValue.serverTimestamp()}}, SetOptions(merge: true));
      final despues = DateTime.now();
      final s = await _doc.get(const GetOptions(source: Source.server));
      final servidor = ((s.data()?['latido'] as Map?)?[miUid] as Timestamp?)?.toDate();
      if (servidor != null) _desfase = antes.add(despues.difference(antes) ~/ 2).difference(servidor);
    } catch (_) {}
  }

  EstadoRelojCompartido? _leer(DocumentSnapshot<Map<String, dynamic>> s) {
    final j = s.data();
    if (j == null || j['esquema'] == null) return null;
    // Una escritura propia aún sin confirmar no trae la hora del servidor: es ahora.
    final cambiado = (j['cambiado'] as Timestamp?)?.toDate();
    final local = cambiado == null ? DateTime.now() : cambiado.add(_desfase);
    return EstadoRelojCompartido(
      reloj: RelojCante.desdeJson(j, guardado: local),
      activo: j['activo'] == true,
      por: (j['por'] as String?) ?? '',
      porNombre: (j['porNombre'] as String?) ?? '',
      temas: [for (final t in (j['temas'] as List? ?? const [])) t.toString()],
      elegido: j['elegido'] as String?,
    );
  }

  /// Cambios del reloj (de los dos).
  Stream<EstadoRelojCompartido?> escuchar() => _doc.snapshots().map(_leer).handleError((_) {});

  /// Igual, pero con los errores (sin permiso, sin red) para enseñarlos.
  Stream<EstadoRelojCompartido?> escucharConErrores() => _doc.snapshots().map(_leer);

  /// Publica el estado de [reloj] tal como está ahora.
  Future<void> publicar(RelojCante reloj, {List<String> temas = const [], String? elegido, bool activo = true}) async {
    try {
      await _doc.set({
        ...reloj.aJson(DateTime.now()),
        'activo': activo,
        'por': miUid,
        'porNombre': miNombre,
        'temas': temas,
        'elegido': elegido,
        // La hora del servidor, menos lo que ya va adelantado este dispositivo.
        'cambiado': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  /// Deja de compartir (el otro sigue con su reloj, pero ya no se sincroniza).
  Future<void> dejar() async {
    try {
      await _doc.set({'activo': false, 'por': miUid, 'porNombre': miNombre}, SetOptions(merge: true));
    } catch (_) {}
  }
}
