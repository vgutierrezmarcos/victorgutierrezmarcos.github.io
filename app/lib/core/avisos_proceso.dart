import 'dart:convert';

import 'package:dio/dio.dart';

import '../data/models/oposicion.dart';
import '../data/models/proceso.dart';
import 'avisos_fondo.dart';
import 'notificaciones.dart';
import 'push_proceso.dart';
import 'vistos.dart';

// Las oposiciones con avisos del proceso y los documentos ya avisados se
// guardan como los avisos de la red (fichero o navegador, no Hive), porque
// también los usa la comprobación en segundo plano.
const _activadas = 'proceso_activado';
const _vistos = 'proceso_vistos';

/// Si un aviso no trae la página de su convocatoria: la de empleo del Ministerio.
const _empleo = 'https://portal.mineco.gob.es/es-es/ministerio/empleo/Paginas/default.aspx';

/// Las oposiciones con los avisos del proceso activados.
Future<Set<String>> oposicionesConAvisosProceso() => leerVistos(lista: _activadas);

/// Si [oposicion] tiene activados los avisos de novedades del proceso.
Future<bool> avisosProcesoActivados(String oposicion) async => (await leerVistos(lista: _activadas)).contains(oposicion);

/// Activa o quita los avisos del proceso de [oposicion]. Al activarlos, lo que
/// ya hay en [json] se da por visto: solo se avisa de lo que salga después.
Future<void> activarAvisosProceso(String oposicion, bool activar, {Map<String, dynamic>? json, required bool conSesion}) async {
  final activas = await leerVistos(lista: _activadas);
  activar ? activas.add(oposicion) : activas.remove(oposicion);
  await guardarVistos(activas, lista: _activadas);
  if (activar) {
    // Sin el JSON a mano, se descarga: si no, al volver a activarlos se
    // avisaría de golpe de todo lo publicado mientras estaban quitados.
    try {
      json ??= await descargarProceso();
    } catch (_) {}
    if (json != null) {
      final r = novedadesProceso(oposicion, ProcesoSelectivo.deOposicion(json, oposicion), await leerVistos(lista: _vistos));
      await guardarVistos(r.vistos, lista: _vistos, maximo: 4000);
    }
  }
  await sincronizarPushProceso();
  await programarAvisosEnSegundoPlano(activar: conSesion);
}

/// Descarga el JSON del proceso sin caché (para la tarea en segundo plano,
/// que no tiene Hive).
Future<Map<String, dynamic>> descargarProceso() async {
  final r = await Dio(BaseOptions(connectTimeout: const Duration(seconds: 20), receiveTimeout: const Duration(seconds: 40), responseType: ResponseType.plain))
      .get<String>(Oposiciones.tcee.urlProceso);
  return Map<String, dynamic>.from(jsonDecode(r.data!) as Map);
}

/// Avisa de los documentos nuevos de las oposiciones con avisos activados.
/// Con más de tres a la vez, un solo aviso con cuántos son.
Future<List<DocumentoProceso>> comprobarProceso(Map<String, dynamic> json) async {
  final activas = await leerVistos(lista: _activadas);
  if (activas.isEmpty) return const [];
  var vistos = await leerVistos(lista: _vistos);
  final avisados = <DocumentoProceso>[];
  for (final op in Oposiciones.todas.where((o) => activas.contains(o.id))) {
    final procesos = ProcesoSelectivo.deOposicion(json, op.id);
    final r = novedadesProceso(op.id, procesos, vistos);
    vistos = r.vistos;
    if (r.nuevos.isEmpty) continue;
    await _avisar(op, [for (final d in r.nuevos) (d, procesos.firstWhere((p) => p.documentos.contains(d), orElse: () => procesos.first).url)]);
    avisados.addAll(r.nuevos);
  }
  await guardarVistos(vistos, lista: _vistos, maximo: 4000);
  return avisados;
}

/// Lo que llega por push (la acción leer-proceso lo manda en cuanto lo ve en
/// la página oficial): [datos] trae la oposición y los documentos nuevos. Se
/// avisa solo si esa oposición tiene los avisos activados y de lo que no se
/// haya avisado ya (la comprobación periódica sigue, y no se repite).
Future<List<DocumentoProceso>> avisarPushProceso(Map<String, dynamic> datos) async {
  final op = Oposiciones.todas.where((o) => o.id == datos['op']).firstOrNull;
  if (op == null || !(await leerVistos(lista: _activadas)).contains(op.id)) return const [];
  final docs = [
    for (final d in jsonDecode(datos['docs']?.toString() ?? '[]') as List)
      if (d is Map) (DocumentoProceso.fromJson(Map<String, dynamic>.from(d)), d['pagina']?.toString() ?? ''),
  ];
  final vistos = await leerVistos(lista: _vistos);
  // Sin la marca inicial aún no se ha empezado a seguir: lo de ahora es la base.
  final base = vistos.contains('${op.id}:base');
  final nuevos = [for (final d in docs) if (!vistos.contains('${op.id}:${d.$1.id}')) d];
  await guardarVistos({...vistos, if (!base) '${op.id}:base', for (final d in docs) '${op.id}:${d.$1.id}'}, lista: _vistos, maximo: 4000);
  if (!base || nuevos.isEmpty) return const [];
  await _avisar(op, nuevos);
  return [for (final d in nuevos) d.$1];
}

/// Las notificaciones de unos documentos nuevos de [op] (cada uno con la
/// página oficial de su convocatoria). Con más de tres, una sola. La clave
/// lleva la oposición: los avisos de TCEE y DCE no se pisan.
Future<void> _avisar(Oposicion op, List<(DocumentoProceso, String)> nuevos) async {
  final titulo = 'Novedad en el proceso de ${op.siglas}';
  final avisos = nuevos.length > 3
      ? [(clave: 'proc:${op.id}:${nuevos.first.$1.id}', titulo: '${nuevos.length} novedades en el proceso de ${op.siglas}', texto: nuevos.map((d) => d.$1.titulo).take(4).join(' · '), url: nuevos.first.$2)]
      : [for (final (d, url) in nuevos) (clave: 'proc:${op.id}:${d.id}', titulo: titulo, texto: '${d.seccion}: ${d.titulo}', url: url)];
  for (final a in avisos) {
    await Notificaciones.avisoProceso(a.clave, a.titulo, a.texto, a.url.isEmpty ? _empleo : a.url);
  }
}
