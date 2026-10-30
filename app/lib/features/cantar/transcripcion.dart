import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/analitica.dart';
import '../../core/constants.dart';
import '../../core/plataforma.dart';
import 'reloj_cante.dart';

/// Un trozo reconocido: lo dicho y en qué momento de la exposición empezó
/// (el tiempo de esquema no cuenta), con el tema que se cantaba.
class FraseCante {
  const FraseCante(this.texto, this.en, {this.tema});
  final String texto;
  final Duration en;
  final String? tema;
}

/// La transcripción de un cante, por minutos de exposición, con el formato
/// que lee la IA (`claude/prepara-con-claude/references/datos-app.md`, §1):
/// una marca `[mm:ss]` al empezar cada minuto, también los minutos sin nada
/// (un silencio o un fallo del reconocedor también dice algo). Si se cantan
/// varios temas, cada uno empieza en `[00:00]` bajo su título.
class Transcripcion {
  final frases = <FraseCante>[];

  bool get vacia => frases.every((f) => f.texto.trim().isEmpty);

  void anadir(String texto, Duration en, {String? tema}) {
    final t = texto.trim();
    if (t.isEmpty) return;
    frases.add(FraseCante(t, en.isNegative ? Duration.zero : en, tema: tema));
  }

  void vaciar() => frases.clear();

  /// Palabras reconocidas (para enseñar que avanza).
  int get palabras => frases.fold(0, (n, f) => n + f.texto.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).length);

  /// El cuerpo, minuto a minuto: «[00:00] … \n[01:00] …».
  String porMinutos() {
    final temas = <String?>[];
    for (final f in frases) {
      if (!temas.contains(f.tema)) temas.add(f.tema);
    }
    final varios = temas.length > 1;
    final out = StringBuffer();
    for (final tema in temas) {
      final suyas = frases.where((f) => f.tema == tema).toList();
      if (suyas.isEmpty) continue;
      if (varios) out.write('${out.isEmpty ? '' : '\n'}## Tema ${tema ?? 'sin indicar'}\n\n');
      final ultimo = suyas.map((f) => f.en.inMinutes).reduce((a, b) => a > b ? a : b);
      for (var m = 0; m <= ultimo; m++) {
        final texto = suyas.where((f) => f.en.inMinutes == m).map((f) => f.texto).join(' ');
        out.write('[${formatoReloj(Duration(minutes: m))}]${texto.isEmpty ? '' : ' $texto'}\n');
      }
    }
    return out.toString();
  }

  /// El fichero entero: cabecera y cuerpo.
  String fichero({
    required String oposicion,
    required String ejercicio,
    String? tema,
    String? tituloTema,
    required DateTime fecha,
    required Duration exposicion,
    required Duration exposicionPrevista,
    Duration esquema = Duration.zero,
    Duration esquemaPrevisto = Duration.zero,
    List<String> sorteados = const [],
    List<String> cantados = const [],
  }) {
    final titulo = [
      'Cante',
      'Oposición $oposicion',
      ejercicio,
      if (tema != null) 'Tema $tema',
      if (tituloTema != null && tituloTema.isNotEmpty) tituloTema,
    ].join(' · ');
    final tiempos = [
      'Fecha: ${DateFormat('yyyy-MM-dd HH:mm').format(fecha)}',
      'Exposición: ${formatoReloj(exposicion)} (prevista ${formatoReloj(exposicionPrevista)})',
      if (esquemaPrevisto > Duration.zero || esquema > Duration.zero) 'Esquema: ${formatoReloj(esquema)} (previsto ${formatoReloj(esquemaPrevisto)})',
    ].join(' · ');
    final bolas = [
      if (sorteados.isNotEmpty) 'Sorteados: ${sorteados.join(', ')}',
      if (cantados.isNotEmpty) 'Cantado: ${cantados.join(', ')}',
    ].join(' · ');
    return [
      '# $titulo',
      tiempos,
      if (bolas.isNotEmpty) bolas,
      'Transcripción automática del móvil: puede tener errores de reconocimiento (nombres propios, fórmulas, números).',
      '',
      porMinutos(),
    ].join('\n');
  }
}

/// «3.A.8» → «3A08» (como los ficheros de tarjetas de la IA).
String codigoParaFichero(String codigo) {
  final p = codigo.split('.');
  if (p.length != 3) return codigo.replaceAll('.', '');
  return '${p[0]}${p[1]}${p[2].padLeft(2, '0')}';
}

/// `cante_3A08_2026-11-03.txt`.
String nombreFicheroTranscripcion(String? tema, DateTime fecha) => 'cante_${tema == null ? 'tema' : codigoParaFichero(tema)}_${DateFormat('yyyy-MM-dd').format(fecha)}.txt';

/// Las transcripciones guardadas con los cantes del diario: solo en este
/// dispositivo (Hive `transcripcion_<id>`), nunca se sincronizan.
class Transcripciones {
  static Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;
  static String _clave(String canteId) => 'transcripcion_$canteId';

  static ({String nombre, String texto})? de(String canteId) {
    final v = _caja?.get(_clave(canteId));
    if (v is! Map || v['texto'] is! String) return null;
    return (nombre: (v['nombre'] as String?) ?? 'cante.txt', texto: v['texto'] as String);
  }

  static Future<void> guardar(String canteId, {required String nombre, required String texto}) async => _caja?.put(_clave(canteId), {'nombre': nombre, 'texto': texto});

  static Future<void> borrar(String canteId) async => _caja?.delete(_clave(canteId));

  /// «Enviar a la IA»: entrega el `.txt` con el menú de compartir del móvil
  /// (o lo descarga en el navegador) para adjuntarlo en el chat de la IA.
  static Future<bool> enviarALaIa(String canteId) async {
    final t = de(canteId);
    if (t == null) return false;
    await guardarFichero(nombre: t.nombre, contenido: t.texto, mime: 'text/plain', asunto: 'Transcripción del cante');
    Analitica.instancia.evento('ia_enviar_cante');
    return true;
  }
}
