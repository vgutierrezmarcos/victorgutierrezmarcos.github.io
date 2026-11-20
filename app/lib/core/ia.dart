import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'analitica.dart';
import 'avisos_breves.dart';
import 'constants.dart';
import 'providers.dart';

/// Las IA con las que funciona el conector de EconomIA, por orden (Claude, la
/// recomendada). [nuevo] abre una conversación nueva; si [rellena], admite el
/// mensaje en la URL (`?q=`) y, si no, se copia al portapapeles para pegarlo.
enum Ia {
  claude('Claude', 'https://claude.ai/new', true, 'conector', 'La más completa: informes en PDF con la plantilla de los temas y gráficos como los del temario. Plan de pago (Pro, Max o Team).'),
  lechat('Le Chat', 'https://chat.mistral.ai/chat', true, 'plataformas', 'También con el plan gratuito.'),
  chatgpt('ChatGPT', 'https://chatgpt.com/', true, 'plataformas', 'Con los planes que admiten conectores propios. Hay que activar el conector en cada conversación (menú +).'),
  gemini('Gemini', 'https://gemini.google.com/app', false, 'plataformas', 'Con los planes que admiten conectores propios, y solo en la web. El mensaje se copia para que lo pegues.');

  const Ia(this.nombre, this.nuevo, this.rellena, this.ancla, this.nota);

  final String nombre;
  final String nuevo;
  final bool rellena;

  /// Ancla de sus pasos de conexión en la página de EconomIA.
  final String ancla;
  final String nota;

  static Ia? deId(Object? id) => Ia.values.where((i) => i.name == id).firstOrNull;

  /// La URL que abre una conversación nueva con [mensaje] ya escrito (si la IA lo admite).
  String urlCon(String mensaje) => rellena ? Uri.parse(nuevo).replace(queryParameters: {'q': mensaje}).toString() : nuevo;

  String get urlComoConectar => '${Urls.economia}#$ancla';
}

/// Lo que el usuario ha decidido sobre su IA. Es de la cuenta, no de una
/// oposición: en la caja [Cajas.app] y, con sesión, en `users/{uid}/cuenta/app`
/// (campo `ia`). El lado de la burbuja es de cada dispositivo.
class EstadoIa {
  const EstadoIa({this.preferida, this.aMano = false, this.burbuja = true, this.derecha = false});

  /// La IA elegida (null: aún no ha elegido; vale la que diga el conector).
  final Ia? preferida;

  /// «Ya lo he conectado»: el usuario lo da por conectado aunque el conector no lo haya apuntado.
  final bool aMano;

  /// Si quiere ver la burbuja.
  final bool burbuja;
  final bool derecha;

  EstadoIa copyWith({Ia? preferida, bool? aMano, bool? burbuja, bool? derecha}) =>
      EstadoIa(preferida: preferida ?? this.preferida, aMano: aMano ?? this.aMano, burbuja: burbuja ?? this.burbuja, derecha: derecha ?? this.derecha);

  Map<String, dynamic> toJson() => {'preferida': preferida?.name, 'aMano': aMano, 'burbuja': burbuja};

  factory EstadoIa.fromJson(Map<dynamic, dynamic> j, {bool derecha = false}) =>
      EstadoIa(preferida: Ia.deId(j['preferida']), aMano: j['aMano'] == true, burbuja: j['burbuja'] != false, derecha: derecha);
}

class IaNotifier extends Notifier<EstadoIa> {
  static const _clave = 'ia';
  static const _claveLado = 'ia_burbuja_derecha';

  Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;

  DocumentReference<Map<String, dynamic>>? get _doc {
    final uid = ref.read(usuarioActualProvider)?.uid;
    if (uid == null || !ref.read(serviciosProvider).firebaseDisponible) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('cuenta').doc('app');
  }

  @override
  EstadoIa build() {
    final caja = _caja;
    final guardado = caja?.get(_clave);
    final derecha = caja?.get(_claveLado) == true;
    // Dispositivo nuevo (o sesión recién iniciada): lo que diga la cuenta.
    ref.listen(usuarioActualProvider.select((u) => u?.uid), (_, uid) {
      if (uid != null && _caja?.get(_clave) == null) unawaited(_traer());
    }, fireImmediately: true);
    return guardado is Map ? EstadoIa.fromJson(guardado, derecha: derecha) : EstadoIa(derecha: derecha);
  }

  Future<void> _traer() async {
    try {
      final ia = (await _doc?.get().timeout(const Duration(seconds: 8)))?.data()?['ia'];
      if (ia is! Map || _caja?.get(_clave) != null) return;
      state = EstadoIa.fromJson(ia, derecha: state.derecha);
      await _caja?.put(_clave, state.toJson());
    } catch (_) {
      // Sin red: se queda con lo del dispositivo.
    }
  }

  Future<void> _guardar(EstadoIa nuevo) async {
    state = nuevo;
    await _caja?.put(_clave, nuevo.toJson());
    try {
      await _doc?.set({'ia': nuevo.toJson()}, SetOptions(merge: true)).timeout(const Duration(seconds: 8));
    } catch (_) {
      // Sin red: queda en el dispositivo.
    }
  }

  /// Elegir otra IA quita el «ya lo he conectado» de la anterior.
  Future<void> elegir(Ia ia) => _guardar(EstadoIa(preferida: ia, aMano: ia == state.preferida && state.aMano, burbuja: state.burbuja, derecha: state.derecha));

  Future<void> conectadaAMano(bool valor) => _guardar(state.copyWith(aMano: valor, burbuja: valor ? true : null));

  Future<void> mostrarBurbuja(bool valor) => _guardar(state.copyWith(burbuja: valor));

  Future<void> lado({required bool derecha}) async {
    state = state.copyWith(derecha: derecha);
    await _caja?.put(_claveLado, derecha);
  }
}

final iaProvider = NotifierProvider<IaNotifier, EstadoIa>(IaNotifier.new);

/// Lo que el conector ha apuntado en la cuenta (`users/{uid}/cuenta/conector`):
/// con qué IA se ha usado y cuándo fue la última vez. Vacío sin sesión.
final conectorProvider = StreamProvider<Map<Ia, DateTime>>((ref) {
  final uid = ref.watch(usuarioActualProvider.select((u) => u?.uid));
  if (uid == null || !ref.watch(serviciosProvider).firebaseDisponible) return Stream.value(const {});
  return FirebaseFirestore.instance.collection('users').doc(uid).collection('cuenta').doc('conector').snapshots().map((d) => conexionesDe(d.data()));
});

/// Las IA conectadas de un documento `cuenta/conector` (`ias.{ia}.ultimoUso`, texto ISO).
Map<Ia, DateTime> conexionesDe(Map<String, dynamic>? datos) {
  final ias = datos?['ias'];
  if (ias is! Map) return const {};
  final out = <Ia, DateTime>{};
  for (final e in ias.entries) {
    final ia = Ia.deId(e.key);
    final uso = e.value is Map ? DateTime.tryParse('${(e.value as Map)['ultimoUso']}') : null;
    if (ia != null && uso != null) out[ia] = uso;
  }
  return out;
}

/// La IA del usuario: la que ha elegido o, si no ha elegido, la última con la
/// que ha usado el conector.
Ia? iaElegida(EstadoIa estado, Map<Ia, DateTime> conexiones) {
  if (estado.preferida != null) return estado.preferida;
  if (conexiones.isEmpty) return null;
  return (conexiones.entries.toList()..sort((a, b) => b.value.compareTo(a.value))).first.key;
}

/// La IA con la que EconomIA está configurada, o null si falta algo: hace
/// falta una IA y que el conector esté conectado con ella (lo dice él o el
/// usuario con «Ya lo he conectado»).
Ia? iaConfigurada(EstadoIa estado, Map<Ia, DateTime> conexiones) {
  final ia = iaElegida(estado, conexiones);
  if (ia == null) return null;
  return conexiones.containsKey(ia) || (estado.aMano && estado.preferida == ia) ? ia : null;
}

/// La IA a la que lleva la burbuja, o null si no la abre directamente: la
/// configurada, si el usuario no ha ocultado la burbuja. (La burbuja se ve
/// aunque no esté configurada: entonces lleva a configurarla.)
Ia? iaDeLaBurbuja(EstadoIa estado, Map<Ia, DateTime> conexiones) => estado.burbuja ? iaConfigurada(estado, conexiones) : null;

final iaElegidaProvider = Provider<Ia?>((ref) => iaElegida(ref.watch(iaProvider), ref.watch(conectorProvider).valueOrNull ?? const {}));

final iaConfiguradaProvider = Provider<Ia?>((ref) => iaConfigurada(ref.watch(iaProvider), ref.watch(conectorProvider).valueOrNull ?? const {}));

final burbujaIaProvider = Provider<Ia?>((ref) => iaDeLaBurbuja(ref.watch(iaProvider), ref.watch(conectorProvider).valueOrNull ?? const {}));

/// Abre [ia] con [mensaje]: en el móvil, su aplicación si está instalada (y,
/// si no, el navegador); en la web, otra pestaña. Si la IA no admite el
/// mensaje en el enlace, se copia para pegarlo. [acceso] es el nombre corto
/// del acceso para las estadísticas anónimas (nunca el texto).
Future<void> abrirIa(BuildContext context, Ia ia, String mensaje, {String acceso = 'libre'}) async {
  final messenger = ScaffoldMessenger.of(context);
  Analitica.instancia.evento('ia_burbuja', parametros: {'ia': ia.name, 'acceso': acceso});
  if (!ia.rellena) {
    await Clipboard.setData(ClipboardData(text: mensaje));
    messenger.mostrar(SnackBar(content: Text('Mensaje copiado: pégalo en ${ia.nombre}')));
  }
  final ok = await launchUrl(Uri.parse(ia.urlCon(mensaje)), mode: LaunchMode.externalApplication);
  if (!ok) messenger.mostrar(SnackBar(content: Text('No se ha podido abrir ${ia.nombre}')));
}
