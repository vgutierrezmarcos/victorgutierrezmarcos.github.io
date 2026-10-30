import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/analitica.dart';
import '../../core/constants.dart';
import '../../core/plataforma.dart';
import 'pizarra_cante.dart';
import 'pizarra_pdf.dart';
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
    String? pizarra,
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
      if (pizarra != null) lineaPizarra(pizarra),
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

  /// «Enviar a la IA»: entrega juntos el `.txt` y el PDF de la pizarra del
  /// cante (los que haya) con el menú de compartir del móvil (o los descarga
  /// en el navegador) para adjuntarlos en el chat de la IA.
  static Future<bool> enviarALaIa(String canteId) async {
    final t = de(canteId);
    final p = PizarrasCante.de(canteId);
    if (t == null && p == null) return false;
    final ficheros = <({String nombre, List<int> bytes, String mime})>[
      if (t != null) (nombre: t.nombre, bytes: utf8.encode(conLineaPizarra(t.texto, p?.nombre)), mime: 'text/plain'),
      if (p != null) (nombre: p.nombre, bytes: await PizarrasCante.pdf(canteId) ?? const <int>[], mime: 'application/pdf'),
    ];
    final asunto = t != null && p != null ? 'Transcripción y pizarra del cante' : (t != null ? 'Transcripción del cante' : 'Pizarra del cante');
    await guardarVarios(ficheros, asunto: asunto);
    Analitica.instancia.evento('ia_enviar_cante', parametros: {'texto': t == null ? 0 : 1, 'pizarra': p == null ? 0 : 1});
    return true;
  }
}

/// La pizarra de los cantes del diario (Cantar → Pizarra mientras corre el
/// cronómetro): solo en este dispositivo (Hive `pizarra_<id>`), nunca se
/// sincroniza. Se guarda la cronología ([CronologiaPizarra]) y el PDF se
/// saca de ella al enviarlo o verlo.
class PizarrasCante {
  static Box? get _caja => Hive.isBoxOpen(Cajas.app) ? Hive.box(Cajas.app) : null;
  static String _clave(String canteId) => 'pizarra_$canteId';

  static ({String nombre, DateTime fecha, CronologiaPizarra cronologia})? de(String canteId) {
    final v = _caja?.get(_clave(canteId));
    if (v is! Map || v['cronologia'] is! Map) return null;
    return (
      nombre: (v['nombre'] as String?) ?? 'pizarra.pdf',
      fecha: DateTime.fromMillisecondsSinceEpoch((v['fecha'] as num?)?.toInt() ?? 0),
      cronologia: CronologiaPizarra.fromJson(v['cronologia'] as Map),
    );
  }

  static Future<void> guardar(String canteId, {required String nombre, required DateTime fecha, required CronologiaPizarra cronologia}) async =>
      _caja?.put(_clave(canteId), {'nombre': nombre, 'fecha': fecha.millisecondsSinceEpoch, 'cronologia': cronologia.toJson()});

  /// La borra y quita su línea de la transcripción del mismo cante.
  static Future<void> borrar(String canteId) async {
    await _caja?.delete(_clave(canteId));
    final t = Transcripciones.de(canteId);
    if (t != null) await Transcripciones.guardar(canteId, nombre: t.nombre, texto: conLineaPizarra(t.texto, null));
  }

  /// El PDF (una página por minuto en que cambió la pizarra), o null si no hay.
  static Future<List<int>?> pdf(String canteId) async {
    final p = de(canteId);
    if (p == null) return null;
    return pdfPizarraCante(p.cronologia.paginas(fecha: p.fecha), fecha: p.fecha, letra: await letraParaPdf(), titulo: p.nombre.replaceAll('.pdf', ''));
  }

  /// Cuántas páginas tendría el PDF.
  static int paginas(String canteId) {
    final p = de(canteId);
    return p == null ? 0 : p.cronologia.paginas(fecha: p.fecha).length;
  }
}
