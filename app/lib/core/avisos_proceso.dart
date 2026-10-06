import 'dart:convert';

import 'package:dio/dio.dart';

import '../data/models/oposicion.dart';
import '../data/models/proceso.dart';
import 'avisos_fondo.dart';
import 'notificaciones.dart';
import 'plataforma.dart';
import 'vistos.dart';

// Las oposiciones con avisos del proceso y los documentos ya avisados se
// guardan como los avisos de la red (fichero o navegador, no Hive), porque
// también los usa la comprobación en segundo plano.
const _activadas = 'proceso_activado';
const _vistos = 'proceso_vistos';

/// Si [oposicion] tiene activados los avisos de novedades del proceso.
Future<bool> avisosProcesoActivados(String oposicion) async => (await leerVistos(lista: _activadas)).contains(oposicion);

/// Activa o quita los avisos del proceso de [oposicion]. Al activarlos, lo que
/// ya hay en [json] se da por visto: solo se avisa de lo que salga después.
Future<void> activarAvisosProceso(String oposicion, bool activar, {Map<String, dynamic>? json, required bool conSesion}) async {
  final activas = await leerVistos(lista: _activadas);
  activar ? activas.add(oposicion) : activas.remove(oposicion);
  await guardarVistos(activas, lista: _activadas);
  if (activar && json != null) {
    final r = novedadesProceso(oposicion, ProcesoSelectivo.deOposicion(json, oposicion), await leerVistos(lista: _vistos));
    await guardarVistos(r.vistos, lista: _vistos, maximo: 4000);
  }
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
    final titulo = 'Novedad en el proceso de ${op.siglas}';
    final avisos = r.nuevos.length > 3
        ? [(clave: 'proc:${op.id}:${r.nuevos.first.id}', titulo: '${r.nuevos.length} novedades en el proceso de ${op.siglas}', texto: r.nuevos.map((d) => d.titulo).take(4).join(' · '), url: procesos.first.url)]
        : [
            for (final d in r.nuevos)
              (clave: 'proc:${op.id}:${d.id}', titulo: titulo, texto: '${d.seccion}: ${d.titulo}', url: procesos.firstWhere((p) => p.documentos.contains(d), orElse: () => procesos.first).url),
          ];
    for (final a in avisos) {
      if (Notificaciones.disponibles) {
        await Notificaciones.avisoProceso(a.clave, a.titulo, a.texto, a.url);
      } else {
        notificacionNavegador(a.titulo, a.texto);
      }
    }
    avisados.addAll(r.nuevos);
  }
  await guardarVistos(vistos, lista: _vistos, maximo: 4000);
  return avisados;
}
