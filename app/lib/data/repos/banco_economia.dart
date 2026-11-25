import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/explicacion.dart';
import '../models/pregunta.dart';

/// El banco de preguntas de test de EconomIA (no oficiales, revisadas, con su
/// explicación): material exclusivo que el conector sirve solo con sesión
/// (mcp/worker/src/bancoApp.ts). Se mezcla con las oficiales en el test cuando
/// el usuario desmarca «Solo preguntas de exámenes oficiales».
const examenBancoEconomia = 'Banco de EconomIA';
const urlBancoEconomia = 'https://mcp.victorgutierrezmarcos.es/app/banco';

class BancoEconomia {
  const BancoEconomia({this.preguntas = const [], this.explicaciones = const {}});
  final List<Pregunta> preguntas;
  final Map<int, Explicacion> explicaciones;

  static const vacio = BancoEconomia();

  /// `{"preguntas": [{id, temas, enunciado, opciones, respuesta, explicacion: {clave, desarrollo}, imagenes?}]}`.
  factory BancoEconomia.fromJson(Map<String, dynamic> j) {
    final preguntas = <Pregunta>[];
    final explicaciones = <int, Explicacion>{};
    for (final e in (j['preguntas'] as List? ?? const [])) {
      if (e is! Map) continue;
      final m = Map<String, dynamic>.from(e);
      if (m['id'] is! num || m['opciones'] is! Map) continue;
      final p = Pregunta.fromJson({...m, 'examen': examenBancoEconomia, 'oficial': false, 'numero': 0});
      preguntas.add(p);
      final ex = m['explicacion'];
      if (ex is Map) {
        explicaciones[p.id] = Explicacion(
          clave: ex['clave']?.toString() ?? '',
          desarrollo: ex['desarrollo']?.toString() ?? '',
          opciones: const {},
          temas: p.temas,
        );
      }
    }
    return BancoEconomia(preguntas: preguntas, explicaciones: explicaciones);
  }

  /// Lo descarga con el token de Firebase del usuario; sin sesión o sin red, vacío.
  static Future<BancoEconomia> descargar(User? usuario, {Dio? dio}) async {
    if (usuario == null) return vacio;
    try {
      final token = await usuario.getIdToken();
      final r = await (dio ?? Dio()).get<Map<String, dynamic>>(
        urlBancoEconomia,
        options: Options(headers: {'Authorization': 'Bearer $token'}, responseType: ResponseType.json, receiveTimeout: const Duration(seconds: 30)),
      );
      return r.data == null ? vacio : BancoEconomia.fromJson(r.data!);
    } catch (_) {
      return vacio;
    }
  }
}
